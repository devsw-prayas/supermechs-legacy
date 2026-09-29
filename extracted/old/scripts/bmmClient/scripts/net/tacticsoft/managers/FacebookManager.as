package net.tacticsoft.managers
{
   import com.facebook.graph.Facebook;
   import com.facebook.graph.data.FacebookAuthResponse;
   import com.facebook.graph.data.FacebookSession;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import flash.utils.getQualifiedClassName;
   import net.battleMechsMulti.managers.BMSessionManager;
   import net.battleMechsMulti.session.LoginServices;
   import net.tacticsoft.utils.DelayedFunctionCall;
   import net.tacticsoft.utils.MiscUtils;
   
   public class FacebookManager extends EventDispatcher
   {
      
      private static var inst:FacebookManager;
      
      public static const FB_INIT_UNAVAILABLE:String = "FacebookManager.init_unavailable";
      
      public static const FB_INIT_AVAILABLE:String = "FacebookManager.init_available";
      
      public static const FB_INIT_SUCCESS:String = "FacebookManager.init_success";
      
      public static const FB_INIT_FAIL:String = "FacebookManager.init_fail";
      
      public static const FB_INIT_LOGGED_IN:String = "FacebookManager.init_logged_in";
      
      public static const FB_LOGIN_SUCCESS:String = "FacebookManager.login_success";
      
      public static const FB_LOGIN_FAIL:String = "FacebookManager.login_fail";
      
      public static const FB_LOGOUT_SUCCESS:String = "FacebookManager.logout_success";
      
      private static const APP_ID:String = "118103108359595";
      
      private static const APP_SECRET:String = "c598b153279560c3b79e53c01bac9e62";
      
      private static const FACEBOOK_CHECK_STATUS_CODE:String = ( <![CDATA[ 
		function callGetFacebookLoginStatusJSCallback() {
			var swfObject = document.getElementById(FBAS.swfObjectID);
			FB.getLoginStatus(function(response) {
				swfObject.facebookLoginStatusCheckFinished(response);
			});
		}
	]]>).toString();
      
      private var facebookSO:SharedObject;
      
      public var stage:Stage;
      
      public var uid:String = null;
      
      public var accessToken:String = null;
      
      public var loggedIn:Boolean = false;
      
      private var isUsingMobileApp:Boolean = false;
      
      private var isLocalLoggedIn:Boolean = false;
      
      private var _session:BMSessionManager;
      
      private var _available:Boolean = false;
      
      private var _initialized:Boolean = false;
      
      private var loginAfterInit:Boolean = false;
      
      private var isExternalLoginAction:Boolean = false;
      
      private var isExternalLogoutAction:Boolean = false;
      
      public function FacebookManager(param1:Stage)
      {
         super();
         TsLogger.log("FacebookManager :: Constructor.");
         if(FacebookManager.inst)
         {
            throw new Error("FacebookManager is a singleton, see SessionManager.getInstance()");
         }
         this.stage = param1;
         this.initialize();
      }
      
      public static function getInstance(param1:Stage = null) : FacebookManager
      {
         if(inst == null)
         {
            inst = new FacebookManager(param1);
         }
         return inst;
      }
      
      public static function gi(param1:Stage = null) : FacebookManager
      {
         return getInstance(param1);
      }
      
      public function get available() : Boolean
      {
         return this._available;
      }
      
      public function get initialized() : Boolean
      {
         return this._initialized;
      }
      
      private function initialize() : void
      {
         TsLogger.log("FacebookManager :: initialize()");
         TsLogger.log("FacebookManager :: initialize() - Running in remote browser, attempting init.");
         this.facebookSO = SharedObject.getLocal("facebookSO","/");
         if(!this.facebookSO.data.created)
         {
            this.facebookSO.data.created = new Date();
            this.facebookSO.data.access_token = null;
            this.facebookSO.data.uid = null;
            this.facebookSO.flush();
            TsLogger.log("FacebookManager :: initialize() - New shared object created: " + this.facebookSO.data.created);
         }
         this.accessToken = this.facebookSO.data.access_token;
         this.uid = this.facebookSO.data.uid;
         if(this.accessToken != null && this.uid == null)
         {
            this.uid = "NoUID";
         }
         this._available = true;
         this.doFacebookInit();
      }
      
      public function SetSession(param1:BMSessionManager) : void
      {
         this._session = param1;
      }
      
      public function doFacebookInit() : void
      {
         TsLogger.log("FacebookManager :: doFacebookInit()");
         TsLogger.log("FacebookManager :: doFacebookInit() - accessToken=" + this.accessToken);
         Facebook.init(FacebookManager.APP_ID,this.onInit,null,this.accessToken);
      }
      
      private function onInit(param1:*, param2:*) : void
      {
         var _loc3_:FacebookAuthResponse = null;
         this._initialized = true;
         TsLogger.log("FacebookManager :: onInit() - Callback for Facebook.init! success: " + param1 + ", fail: " + param2);
         TsLogger.log("FacebookManager :: onInit() - Success: " + getQualifiedClassName(param1));
         TsLogger.log("FacebookManager :: onInit() - Fail: " + getQualifiedClassName(param2));
         if(param2 != null)
         {
            MiscUtils.traceObject(param2,99);
            dispatchEvent(new Event(FacebookManager.FB_INIT_FAIL));
            this._available = false;
            return;
         }
         if(param1 != null)
         {
            TsLogger.log("FacebookManager :: onInit() - success");
            _loc3_ = param1 as FacebookAuthResponse;
            if(_loc3_ != null && _loc3_.uid != null)
            {
               TsLogger.log("FacebookManager :: onInit() - Already logged in");
               TsLogger.log("FacebookManager :: onInit() - UID: " + _loc3_.uid + ", access token: " + _loc3_.accessToken);
               this.facebookSO.data.access_token = _loc3_.accessToken;
               this.facebookSO.flush();
               this.accessToken = this.facebookSO.data.access_token;
               this.loggedIn = true;
               this.finishInit();
               return;
            }
            if(_loc3_ != null && _loc3_.uid == null && _loc3_.accessToken != null)
            {
               TsLogger.log("FacebookManager :: onInit() - response != null, response.uid == null");
               TsLogger.log("FacebookManager :: onInit() - but we do have a UID.");
               this.facebookSO.data.access_token = _loc3_.accessToken;
               this.facebookSO.flush();
               this.accessToken = this.facebookSO.data.access_token;
            }
         }
         TsLogger.log("FacebookManager :: onInit() -  Facebook initialized, but not yet logged in.");
         this.finishInit();
      }
      
      private function finishInit() : *
      {
         dispatchEvent(new Event(FacebookManager.FB_INIT_SUCCESS));
         if(this.loginAfterInit)
         {
            new DelayedFunctionCall(this.performLoginAfterInit,10);
         }
      }
      
      private function performLoginAfterInit() : *
      {
         this.login(this.isExternalLoginAction);
      }
      
      public function login(param1:Boolean = false) : void
      {
         var isExternalLoginAction:Boolean = param1;
         this.isExternalLoginAction = isExternalLoginAction;
         if(!this.initialized)
         {
            TsLogger.log("FacebookManager :: login::loginAfterInit");
            this.loginAfterInit = true;
            return;
         }
         this.loginAfterInit = false;
         if(this.loggedIn)
         {
            TsLogger.log("FacebookManager :: login::finishFacebookLoginSuccess");
            this.finishFacebookLoginSuccess(this.uid,this.accessToken);
            return;
         }
         if(ExternalInterface.available)
         {
            try
            {
               TsLogger.log("FacebookManager :: login::ExternalInterface.addCallback");
               ExternalInterface.addCallback("facebookLoginStatusCheckFinished",this.facebookLoginStatusCheckFinished);
               this.callFacebookCheckStatus();
            }
            catch(e:Error)
            {
               TsLogger.log("FacebookManager :: login::Facebook.login2 + " + e.message);
               Facebook.login(this.onLogin,{
                  "read_friendlists":true,
                  "publish_stream":true
               });
            }
         }
         else
         {
            TsLogger.log("FacebookManager :: login::Facebook.login1");
            Facebook.login(this.onLogin,{
               "read_friendlists":true,
               "publish_stream":true
            });
         }
      }
      
      public function logout(param1:Boolean = true) : *
      {
         this.isExternalLogoutAction = param1;
         if(this.isLocalLoggedIn)
         {
            Facebook.logout(this.onLogout);
         }
         else
         {
            this.onLogout(null);
         }
      }
      
      public function get isFullyLoggedIn() : Boolean
      {
         return this.isExternalLoggedIn && this.isLocalLoggedIn;
      }
      
      private function get isExternalLoggedIn() : Boolean
      {
         if(this._session == null)
         {
            return false;
         }
         return this._session.isExternalLoggedIn(LoginServices.FACEBOOK);
      }
      
      private function onLogout(param1:*) : void
      {
         this.accessToken = null;
         this.uid = null;
         this.loggedIn = false;
         if(this.isExternalLoggedIn && this.isExternalLogoutAction)
         {
            BMMSessionManager.getInstance().getSession().externalLogout(LoginServices.FACEBOOK);
         }
         this.isLocalLoggedIn = false;
         dispatchEvent(new Event(FacebookManager.FB_LOGOUT_SUCCESS));
      }
      
      private function onLogin(param1:*, param2:*) : void
      {
         var _loc3_:FacebookAuthResponse = null;
         var _loc4_:FacebookSession = null;
         if(param1 != null)
         {
            _loc3_ = param1 as FacebookAuthResponse;
            if(_loc3_ != null)
            {
               this.finishFacebookLoginSuccess(_loc3_.uid,_loc3_.accessToken);
            }
            _loc4_ = param1 as FacebookSession;
            if(_loc4_ != null)
            {
               this.finishFacebookLoginSuccess(_loc4_.uid,_loc4_.accessToken);
            }
            return;
         }
         dispatchEvent(new Event(FacebookManager.FB_LOGIN_FAIL));
      }
      
      private function finishFacebookLoginSuccess(param1:String, param2:String) : void
      {
         TsLogger.log("FacebookManager :: finishFacebookLoginSuccess() - Successful login by user to FB.");
         TsLogger.log("FacebookManager :: finishFacebookLoginSuccess() - UID: " + param1 + ", access token: " + param2);
         this.facebookSO.data.uid = param1;
         this.facebookSO.data.access_token = param2;
         this.facebookSO.flush();
         this.uid = this.facebookSO.data.uid;
         this.accessToken = this.facebookSO.data.access_token;
         this.loggedIn = true;
         dispatchEvent(new Event(FacebookManager.FB_LOGIN_SUCCESS));
         this.isLocalLoggedIn = true;
         TsLogger.log("FacebookManager :: finishFacebookLoginSuccess() - isExternalLoginAction " + this.isExternalLoginAction);
         if(this.isExternalLoginAction)
         {
            BMMSessionManager.getInstance().getSession().externalLogin(LoginServices.FACEBOOK,this.uid,this.accessToken);
         }
      }
      
      public function externalLoginResolveConflict(param1:Number) : void
      {
         this._session.mergeAccounts(param1,LoginServices.FACEBOOK,this.uid,this.accessToken);
      }
      
      private function callFacebookCheckStatus() : *
      {
         return ExternalInterface.call(FACEBOOK_CHECK_STATUS_CODE);
      }
      
      private function facebookLoginStatusCheckFinished(param1:* = null) : *
      {
         ExternalInterface.addCallback("facebookLoginStatusCheckFinished",null);
         if(param1.status == "connected")
         {
            this.finishFacebookLoginSuccess(param1.authResponse.userID,param1.authResponse.accessToken);
         }
         else
         {
            Facebook.login(this.onLogin,{
               "read_friendlists":true,
               "publish_stream":true
            });
         }
      }
   }
}

