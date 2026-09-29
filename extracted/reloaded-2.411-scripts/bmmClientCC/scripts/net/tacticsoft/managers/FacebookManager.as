package net.tacticsoft.managers
{
   import com.facebook.graph.FacebookMobile;
   import com.facebook.graph.data.FacebookAuthResponse;
   import com.facebook.graph.data.FacebookSession;
   import com.milkmangames.nativeextensions.GoViral;
   import com.milkmangames.nativeextensions.events.GVFacebookEvent;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   import flash.media.StageWebView;
   import flash.net.SharedObject;
   import flash.utils.getQualifiedClassName;
   import net.battleMechsMulti.managers.BMSessionManager;
   import net.battleMechsMulti.session.LoginServices;
   import net.tacticsoft.utils.DelayedFunctionCall;
   
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
         var _loc1_:String = null;
         TsLogger.log("FacebookManager :: doFacebookInit()");
         TsLogger.log("FacebookManager :: doFacebookInit() - accessToken=" + this.accessToken);
         GoViral.create();
         if(GoViral.goViral.isFacebookSupported())
         {
            GoViral.goViral.initFacebook(FacebookManager.APP_ID);
            this.isUsingMobileApp = true;
            GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGGED_IN,this.onGoViralFacebookLoginSuccess);
            GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGIN_CANCELED,this.onGoViralFacebookLoginFail);
            GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGIN_FAILED,this.onGoViralFacebookLoginFail);
            GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGGED_OUT,this.onGoViralFacebookLogout);
            if(GoViral.goViral.isFacebookAuthenticated())
            {
               _loc1_ = GoViral.goViral.getFbAccessToken();
               this.onInit(_loc1_,null);
            }
            else
            {
               this.onInit(null,"NotLoggedIn");
            }
         }
         else
         {
            this.isUsingMobileApp = false;
            FacebookMobile.init(FacebookManager.APP_ID,this.onInit);
         }
      }
      
      private function onInit(param1:*, param2:*) : void
      {
         var _loc3_:FacebookAuthResponse = null;
         var _loc4_:String = null;
         var _loc5_:FacebookSession = null;
         this._initialized = true;
         TsLogger.log("FacebookManager :: onInit() - Callback for Facebook.init! success: " + param1 + ", fail: " + param2);
         TsLogger.log("FacebookManager :: onInit() - Success: " + getQualifiedClassName(param1));
         TsLogger.log("FacebookManager :: onInit() - Fail: " + getQualifiedClassName(param2));
         if(param2 != null)
         {
            dispatchEvent(new Event(FacebookManager.FB_INIT_SUCCESS));
            this._available = true;
            return;
         }
         if(param1 != null)
         {
            TsLogger.log("FacebookManager :: onInit() - success");
            TsLogger.log("FacebookManager :: onInit() - Already logged in");
            if(this.isUsingMobileApp)
            {
               _loc4_ = param1 as String;
               this.facebookSO.data.access_token = _loc4_;
            }
            else
            {
               _loc5_ = param1 as FacebookSession;
               this.facebookSO.data.access_token = _loc5_.accessToken;
            }
            this.facebookSO.flush();
            this.accessToken = this.facebookSO.data.access_token;
            this.loggedIn = true;
            this.finishInit();
            return;
         }
         TsLogger.log("FacebookManager :: onInit() -  Facebook initialized, but not yet logged in.");
         this.finishInit();
      }
      
      private function finishInit() : *
      {
         dispatchEvent(new Event(FacebookManager.FB_INIT_SUCCESS));
         TsLogger.log("FacebookManager :: finishInit");
         if(this.loginAfterInit)
         {
            new DelayedFunctionCall(this.performLoginAfterInit,10);
         }
      }
      
      private function performLoginAfterInit() : *
      {
         TsLogger.log("FacebookManager :: performLoginAfterInit");
         this.login(this.isExternalLoginAction);
      }
      
      public function login(param1:Boolean = false) : void
      {
         var _loc2_:StageWebView = null;
         var _loc3_:Array = null;
         this.isExternalLoginAction = param1;
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
         if(this.isUsingMobileApp)
         {
            TsLogger.log("FacebookManager :: login() - Logging in via goViral");
            GoViral.goViral.authenticateWithFacebook();
         }
         else
         {
            _loc2_ = new StageWebView();
            _loc2_.stage = GlobalAccess.stage;
            _loc2_.viewPort = new Rectangle(0,0,this.stage.width,this.stage.height);
            _loc3_ = new Array();
            FacebookMobile.login(this.onLogin,this.stage,_loc3_,_loc2_);
         }
      }
      
      public function logout(param1:Boolean = true) : *
      {
         this.isExternalLogoutAction = param1;
         if(this.isLocalLoggedIn)
         {
            if(this.isUsingMobileApp)
            {
               GoViral.goViral.logoutFacebook();
            }
            else
            {
               FacebookMobile.logout(this.onLogout);
            }
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
      
      private function onGoViralFacebookLoginSuccess(param1:*) : void
      {
         var _loc2_:String = "NoUIDHere";
         var _loc3_:String = GoViral.goViral.getFbAccessToken();
         this.finishFacebookLoginSuccess(_loc2_,_loc3_);
      }
      
      private function onGoViralFacebookLoginFail(param1:*) : void
      {
         dispatchEvent(new Event(FacebookManager.FB_LOGIN_FAIL));
      }
      
      private function onGoViralFacebookLogout(param1:*) : void
      {
         this.onLogout(null);
      }
   }
}

