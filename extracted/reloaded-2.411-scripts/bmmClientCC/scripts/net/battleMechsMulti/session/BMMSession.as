package net.battleMechsMulti.session
{
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.net.SharedObject;
   import net.battleMechsMulti.events.BMDynamicEvent;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battlegate.events.BGSocketEvent;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.managers.BMMSessionManager;
   import net.tacticsoft.managers.BMMSocketManager;
   import net.tacticsoft.managers.FacebookManager;
   import net.tacticsoft.remoting.events.CallEvent;
   import net.tacticsoft.remoting.events.TimeoutEvent;
   import net.tacticsoft.responders.BMMSessionResponder;
   import net.tacticsoft.responders.events.ExternalLoginConflictEvent;
   import net.tacticsoft.responders.events.ExternalSessionEvents;
   
   public final dynamic class BMMSession extends MovieClip
   {
      
      public static const AUTH_FAILURE:String = "BMMSession.authFailure";
      
      public static const AUTH_SUCCESS:String = "BMMSession.authSuccess";
      
      public static const AUTH_LOGOUT:String = "BMMSession.authLogout";
      
      public static const AUTH_TIMEOUT:String = "BMMSession.authTimeout";
      
      public static const AUTH_MAINTENANCE:String = "BMMSession.authMaintenance";
      
      public static const GOT_USER_SESSION:String = "BMMSession.gotSession";
      
      public static const DOING_FB_LOGIN:String = "BMMSession.doingFBLogin";
      
      public static const FB_INITED:String = "BMMSession.fbInited";
      
      public static const FB_INITFAILED:String = "BMMSession.fbInitFailed";
      
      public static const FB_ALREADY_LOGGED_IN:String = "BMMSession.fbAlreadyLoggedIn";
      
      private var bmmSessionSO:SharedObject;
      
      private var sessionManager:BMMSessionManager;
      
      private var session:BMMSessionResponder;
      
      private var bmmFlashVars:BMMClientFlashVars;
      
      private var facebookAllowed:Boolean = true;
      
      public var facebookManager:FacebookManager;
      
      private var _stage:Stage;
      
      public var lastLoginError:String = null;
      
      private var _currentServerIsMultiplayer:* = false;
      
      public function BMMSession(param1:Stage, param2:Boolean = true, param3:String = "")
      {
         super();
         TsLogger.log("BMMSession :: Constructed - ");
         this._stage = param1;
         this.initialize(param2,param3);
      }
      
      public function get facebookInited() : Boolean
      {
         return this.facebookManager.initialized;
      }
      
      public function get facebookAvailable() : Boolean
      {
         return this.facebookManager.available;
      }
      
      private function initialize(param1:Boolean = true, param2:String = "", param3:* = false) : void
      {
         TsLogger.log("BMMSession :: initialize() -");
         this.bmmFlashVars = new BMMClientFlashVars(GlobalAccess.stage);
         this.bmmSessionSO = SharedObject.getLocal("BMMSessionSO","/");
         if(!this.bmmSessionSO.data.created)
         {
            this.bmmSessionSO.data.created = new Date();
            this.bmmSessionSO.flush();
         }
         this.sessionManager = BMMSessionManager.gi(param2);
         this.sessionManager.addEventListener(BMMSessionResponder.GOTUSER_EVENT,this.gotUserData);
         this.sessionManager.addEventListener(BMMSessionResponder.AUTH_FAULT,this.authFailure);
         this.sessionManager.addEventListener(TimeoutEvent.TIMEOUT,this.timeoutCalled);
         this.facebookAllowed = param1;
         if(this.facebookAllowed)
         {
            this.facebookManager = FacebookManager.getInstance(this._stage);
            this.facebookManager.addEventListener(FacebookManager.FB_INIT_FAIL,this.fbInitFail);
            this.facebookManager.addEventListener(FacebookManager.FB_INIT_LOGGED_IN,this.fbInitLoggedIn);
            this.facebookManager.addEventListener(FacebookManager.FB_INIT_SUCCESS,this.fbInitSuccess);
         }
         if(this.session != null)
         {
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE,this.onExternalLoginTrue);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT,this.onExternalLoginFault);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_CONFLICT,this.onExternalLoginConflict);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalLogoutTrue);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT,this.onExternalLogoutFault);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_RELOGIN,this.onExternalRelogin);
            this.session.removeEventListener(CallEvent.SERVICE_LOGOUT_SUCCESS,this.onLogoutSuccess);
            this.session.removeEventListener(CallEvent.SERVICE_LOGOUT_ERROR,this.onLogoutError);
         }
         this.session = this.sessionManager.getSession();
         this.session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE,this.onExternalLoginTrue);
         this.session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT,this.onExternalLoginFault);
         this.session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_CONFLICT,this.onExternalLoginConflict);
         this.session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalLogoutTrue);
         this.session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT,this.onExternalLogoutFault);
         this.session.addEventListener(ExternalSessionEvents.EXTERNAL_RELOGIN,this.onExternalRelogin);
         this.session.addEventListener(CallEvent.SERVICE_LOGOUT_SUCCESS,this.onLogoutSuccess);
         this.session.addEventListener(CallEvent.SERVICE_LOGOUT_ERROR,this.onLogoutError);
      }
      
      public function dispose() : void
      {
         this.sessionManager = BMMSessionManager.gi();
         this.sessionManager.removeEventListener(BMMSessionResponder.GOTUSER_EVENT,this.gotUserData);
         this.sessionManager.removeEventListener(BMMSessionResponder.AUTH_FAULT,this.authFailure);
         this.sessionManager.removeEventListener(TimeoutEvent.TIMEOUT,this.timeoutCalled);
         if(this.facebookAllowed)
         {
            this.facebookManager = FacebookManager.getInstance();
            this.facebookManager.removeEventListener(FacebookManager.FB_INIT_FAIL,this.fbInitFail);
            this.facebookManager.removeEventListener(FacebookManager.FB_INIT_LOGGED_IN,this.fbInitLoggedIn);
            this.facebookManager.removeEventListener(FacebookManager.FB_INIT_SUCCESS,this.fbInitSuccess);
         }
         if(this.session != null)
         {
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE,this.onExternalLoginTrue);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT,this.onExternalLoginFault);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_CONFLICT,this.onExternalLoginConflict);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalLogoutTrue);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT,this.onExternalLogoutFault);
            this.session.removeEventListener(ExternalSessionEvents.EXTERNAL_RELOGIN,this.onExternalRelogin);
            this.session.removeEventListener(CallEvent.SERVICE_LOGOUT_SUCCESS,this.onLogoutSuccess);
            this.session.removeEventListener(CallEvent.SERVICE_LOGOUT_ERROR,this.onLogoutError);
         }
      }
      
      private function onExternalRelogin(param1:Event) : void
      {
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_RELOGIN));
      }
      
      private function fbInitFail(param1:Event) : void
      {
         TsLogger.log("BMMSession :: fbInitFail() - Facebook service not available");
         this.facebookManager.removeEventListener(FacebookManager.FB_INIT_FAIL,this.fbInitFail);
         this.facebookManager.removeEventListener(FacebookManager.FB_INIT_LOGGED_IN,this.fbInitLoggedIn);
         this.facebookManager.removeEventListener(FacebookManager.FB_INIT_SUCCESS,this.fbInitSuccess);
         dispatchEvent(new Event(FB_INITFAILED));
      }
      
      private function fbInitLoggedIn(param1:Event) : void
      {
         TsLogger.log("BMMSession :: fbInitLoggedIn()");
         this.facebookManager.removeEventListener(FacebookManager.FB_INIT_FAIL,this.fbInitFail);
         this.facebookManager.removeEventListener(FacebookManager.FB_INIT_LOGGED_IN,this.fbInitLoggedIn);
         this.facebookManager.removeEventListener(FacebookManager.FB_INIT_SUCCESS,this.fbInitSuccess);
         dispatchEvent(new Event(FB_ALREADY_LOGGED_IN));
      }
      
      private function fbInitSuccess(param1:Event) : void
      {
         TsLogger.log("BMMSession :: fbInitSuccess()");
         this.facebookManager.removeEventListener(FacebookManager.FB_INIT_FAIL,this.fbInitFail);
         this.facebookManager.removeEventListener(FacebookManager.FB_INIT_LOGGED_IN,this.fbInitLoggedIn);
         this.facebookManager.removeEventListener(FacebookManager.FB_INIT_SUCCESS,this.fbInitSuccess);
         dispatchEvent(new Event(FB_INITED));
      }
      
      private function timeoutCalled(param1:TimeoutEvent) : void
      {
         TsLogger.log("BMMSession :: timeoutCalled - method: " + param1.callEvent.method);
         dispatchEvent(new Event(AUTH_TIMEOUT));
      }
      
      public function checkKongUserExists(param1:Number) : *
      {
         TsLogger.log("BMMSession :: checkKongUserExists()");
         this.session.addEventListener(BMMSessionResponder.KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.session.addEventListener(BMMSessionResponder.KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.session.addEventListener(BMMSessionResponder.KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         this.session.checkKongUserExists(param1);
      }
      
      private function kongUserExists(param1:Event) : *
      {
         TsLogger.log("BMMSession :: kongUserExists()");
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         dispatchEvent(new Event(BMMSessionManager.EVENT_KONG_USER_EXISTS_TRUE));
      }
      
      private function kongUserDoesntExist(param1:Event) : *
      {
         TsLogger.log("BMMSession :: kongUserDoesntExist()");
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         dispatchEvent(new Event(BMMSessionManager.EVENT_KONG_USER_EXISTS_FALSE));
      }
      
      private function checkKongUserExistsFault(param1:Event) : *
      {
         TsLogger.log("BMMSession :: checkKongUserExistsFault()");
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         dispatchEvent(new Event(BMMSessionManager.EVENT_KONG_USER_EXISTS_FAULT));
      }
      
      private function gotUserData(param1:Event) : void
      {
         TsLogger.log("BMMSession :: gotUserData()");
         this.session.userData.session.session_id = this.session.userData.session[this.session.userData.session.session_name];
         this.saveUserData();
         dispatchEvent(new Event(BMMSession.GOT_USER_SESSION));
         if(!BMMSocketManager.getInstance().connected)
         {
            TsLogger.log("BMMSession :: gotUserData() - connecting to bmmauthd service port: " + this.bmmFlashVars.authServicePort);
            BMMSocketManager.getInstance().addEventListener(BGSocketEvent.CONNECTED,this.doHello);
            BMMSocketManager.getInstance().connect(BMDomainResolver.getDomain(),this.bmmFlashVars.authServicePort);
         }
         else
         {
            this.doHello();
         }
      }
      
      private function saveUserData() : *
      {
         var _loc1_:SharedObject = SharedObject.getLocal("BMMSessionSO","/");
         _loc1_.data.userData = this.session.userData;
         _loc1_.flush();
      }
      
      public function doLogout() : void
      {
         TsLogger.log("BMMSession :: doLogout()");
         var _loc1_:SharedObject = SharedObject.getLocal("BMMSessionSO","/");
         _loc1_.clear();
         _loc1_.flush();
         this.sessionManager.logout();
      }
      
      public function doDisconnect() : void
      {
         this.session.doDisconnect();
      }
      
      private function onLogoutError(param1:CallEvent) : void
      {
         dispatchEvent(new CallEvent(CallEvent.SERVICE_LOGOUT_ERROR));
      }
      
      private function onLogoutSuccess(param1:CallEvent) : void
      {
         this.saveUserData();
         dispatchEvent(new CallEvent(CallEvent.SERVICE_LOGOUT_SUCCESS));
      }
      
      public function authenticate() : void
      {
         this.sessionManager.getSession().authenticate();
      }
      
      private function doHello(param1:BGSocketEvent = null, param2:Object = null) : void
      {
         TsLogger.log("BMMSession :: doHello() requestMultiPlayerServer " + param2);
         if(param1 != null)
         {
            BMMSocketManager.getInstance().removeEventListener(BGSocketEvent.CONNECTED,this.doHello);
         }
         BMMSocketManager.getInstance().bgSocket.addEventListener(BGSocketEvent.DATA_AVAILABLE,this.processAuthCmd);
         var _loc3_:String = this.session.userData.session[this.session.userData.session.cookie_name + "_sid"];
         if(param2 == null)
         {
            param2 = this._currentServerIsMultiplayer;
         }
         this._currentServerIsMultiplayer = param2;
         BMMSocketManager.gi().sendCommand("HELLO",{
            "sessionID":_loc3_,
            "flashVars":this.bmmFlashVars,
            "multiPlayerServer":this._currentServerIsMultiplayer,
            "version":BMExternalAssetsManager.getInstance().getVersionNumber(),
            "platform":BMPlatformUtils.sourcePlatform
         });
      }
      
      public function switchToServer(param1:Boolean) : *
      {
         if(!this.session.connected)
         {
            TsLogger.log("BMMSession ::switchToServer Error session on connected");
            return;
         }
         if(this._currentServerIsMultiplayer == param1)
         {
            TsLogger.log("BMMSession :: Called switch server when on same server - Is multi: " + param1);
         }
         BMMSocketManager.gi().close();
         var _loc2_:Function = param1 ? this.callDoHelloMultiPlayer : this.callDoHelloSinglePlayer;
         BMMSocketManager.gi().addEventListener(BGSocketEvent.CONNECTED,_loc2_);
         BMMSocketManager.gi().connect(BMDomainResolver.getDomain(),this.bmmFlashVars.authServicePort);
      }
      
      public function get currentServerIsMultiplayer() : Boolean
      {
         return this._currentServerIsMultiplayer;
      }
      
      private function callDoHelloMultiPlayer(param1:BGSocketEvent = null) : *
      {
         BMMSocketManager.gi().removeEventListener(BGSocketEvent.CONNECTED,this.callDoHelloMultiPlayer);
         this.doHello(param1,true);
      }
      
      private function callDoHelloSinglePlayer(param1:BGSocketEvent = null) : *
      {
         BMMSocketManager.gi().removeEventListener(BGSocketEvent.CONNECTED,this.callDoHelloSinglePlayer);
         this.doHello(param1,false);
      }
      
      private function processAuthCmd(param1:BGSocketEvent = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:BMDynamicEvent = null;
         TsLogger.log("BMMSession :: processAuthCmd() - got cmd from bmmauthd service");
         while(BMMSocketManager.gi().bgSocket.dataStack.length > 0)
         {
            _loc2_ = BMMSocketManager.gi().bgSocket.dataStack.pop().data;
            if(_loc2_.cmd == null)
            {
               continue;
            }
            switch(_loc2_.cmd)
            {
               case "GOODBYE":
                  TsLogger.log("BMMSession :: processAuthCmd() - GOODBYE.");
                  BMMSocketManager.getInstance().bgSocket.removeEventListener(BGSocketEvent.DATA_AVAILABLE,this.processAuthCmd);
                  BMMSocketManager.gi().close();
                  dispatchEvent(new Event(AUTH_SUCCESS));
                  break;
               case "OVERRIDEPORT":
                  TsLogger.log("BMMSession :: processAuthCmd() - OVERRIDEPORT: " + _loc2_.port);
                  BMMSocketManager.getInstance().bgSocket.removeEventListener(BGSocketEvent.DATA_AVAILABLE,this.processAuthCmd);
                  GlobalAccess.overridePort = _loc2_.port;
                  BMMSocketManager.gi().close();
                  dispatchEvent(new Event(AUTH_SUCCESS));
                  break;
               case "MAINTENANCE":
                  TsLogger.log("BMMSession :: processAuthCmd() - MAINTENANCE: " + _loc2_.message);
                  BMMSocketManager.getInstance().bgSocket.removeEventListener(BGSocketEvent.DATA_AVAILABLE,this.processAuthCmd);
                  BMMSocketManager.gi().close();
                  _loc3_ = new BMDynamicEvent(AUTH_MAINTENANCE);
                  _loc3_.message = _loc2_.message;
                  dispatchEvent(_loc3_);
                  break;
               default:
                  TsLogger.log("BMMSession :: processAuthCmd() - unhandled cmd case: " + _loc2_.cmd + " -- ignoring.");
                  BMMSocketManager.gi().close();
                  dispatchEvent(new Event(AUTH_SUCCESS));
            }
         }
      }
      
      public function doLogin(param1:String = null, param2:String = null) : void
      {
         TsLogger.log("BMMSession :: doLogin()");
         this.sessionManager.login(param1,param2);
      }
      
      public function doFacebookInit() : void
      {
         TsLogger.log("BMMSession :: doFacebookInit().");
         this.facebookManager.addEventListener(FacebookManager.FB_INIT_FAIL,this.fbInitFail);
         this.facebookManager.addEventListener(FacebookManager.FB_INIT_LOGGED_IN,this.fbInitLoggedIn);
         this.facebookManager.addEventListener(FacebookManager.FB_INIT_SUCCESS,this.fbInitSuccess);
         this.facebookManager.doFacebookInit();
      }
      
      private function fbLoggedIn(param1:Event = null) : void
      {
         TsLogger.log("BMMSession :: fbLoggedIn()");
         this.facebookManager.removeEventListener(FacebookManager.FB_LOGIN_SUCCESS,this.fbLoggedIn);
         this.facebookManager.removeEventListener(FacebookManager.FB_LOGIN_FAIL,this.fbLoginFailed);
         this.doLogin("dofacebooklogin",this.facebookManager.accessToken);
      }
      
      private function fbLoginFailed(param1:Event) : void
      {
         TsLogger.log("BMMSession :: fbLoginFailed()");
         this.facebookManager.removeEventListener(FacebookManager.FB_LOGIN_SUCCESS,this.fbLoggedIn);
         this.facebookManager.removeEventListener(FacebookManager.FB_LOGIN_FAIL,this.fbLoginFailed);
         dispatchEvent(new Event(AUTH_FAILURE));
      }
      
      private function authFailure(param1:Event) : void
      {
         TsLogger.log("BMMSession :: authFailure()");
         this.lastLoginError = this.session.lastLoginError;
         dispatchEvent(new Event(AUTH_FAILURE));
      }
      
      public function doExternalLogin(param1:String, param2:String, param3:String) : *
      {
         this.session.externalLogin(param1,param2,param3);
      }
      
      private function onExternalLoginTrue(param1:Event) : void
      {
         this.saveUserData();
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE));
      }
      
      private function onExternalLoginFault(param1:Event) : void
      {
         this.lastLoginError = this.session.lastLoginError;
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT));
         this.lastLoginError = null;
      }
      
      private function onExternalLoginConflict(param1:ExternalLoginConflictEvent) : void
      {
         dispatchEvent(param1);
      }
      
      public function doExternalLogout(param1:String) : *
      {
         this.session.externalLogout(param1);
      }
      
      private function onExternalLogoutTrue(param1:DataEvent) : void
      {
         this.saveUserData();
         dispatchEvent(param1.clone());
      }
      
      private function onExternalLogoutFault(param1:Event) : void
      {
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT));
      }
      
      public function isExternalLoggedIn(param1:String) : Boolean
      {
         var _loc3_:String = null;
         if(this.session.userData == null || this.session.userData.profile_fields == null)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case LoginServices.GOOGLE_PLAY:
               _loc3_ = this.session.userData.profile_fields["pf_gplay_userid"];
               _loc2_ = Boolean(_loc3_) && _loc3_ != "0" && _loc3_ != "";
               break;
            case LoginServices.FACEBOOK:
               _loc3_ = this.session.userData.profile_fields["pf_fb_userid"];
               _loc2_ = Boolean(_loc3_) && _loc3_ != "0" && _loc3_ != "";
               break;
            case LoginServices.SUPERMECHS:
               _loc2_ = this.session.userData.user_email != "" && this.session.userData.user_email != undefined;
               break;
            case LoginServices.KONGREGATE:
               _loc2_ = false;
               break;
            default:
               TsLogger.log("isExternalLoggedIn - Unsupported service " + param1);
               _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function mergeAccounts(param1:Number, param2:String, param3:String, param4:String) : void
      {
         this.session.mergeAccounts(param1,param2,param3,param4);
      }
      
      public function get userData() : Object
      {
         return this.session.userData;
      }
      
      public function set userData(param1:Object) : *
      {
         this.session.userData = param1;
         this.saveUserData();
      }
   }
}

