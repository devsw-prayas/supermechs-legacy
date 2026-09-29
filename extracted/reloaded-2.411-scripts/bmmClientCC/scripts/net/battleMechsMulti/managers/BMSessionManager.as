package net.battleMechsMulti.managers
{
   import flash.events.DataEvent;
   import flash.events.Event;
   import net.battleMechsMulti.events.BMDynamicEvent;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.session.BMMSession;
   import net.battleMechsMulti.session.BMPlatformUtils;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.managers.BMMSessionManager;
   import net.tacticsoft.responders.events.ExternalLoginConflictEvent;
   import net.tacticsoft.responders.events.ExternalSessionEvents;
   
   public class BMSessionManager extends BMBaseClass
   {
      
      public static const GOT_KONG_USER_SESSION:String = "BMSessionManager.gotSession";
      
      private var bmmSession:BMMSession;
      
      public var preAuth:Boolean = true;
      
      private var _loggedIn:Boolean = false;
      
      private var flashVars:BMMClientFlashVars;
      
      public function BMSessionManager()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("SessionManager");
      }
      
      public function createSession() : void
      {
         var _loc1_:BMMClientFlashVars = null;
         TsLogger.log("BMSessionManager :: createSession()");
         if(GlobalAccess.userbase == 0)
         {
            this.preAuth = true;
            _loc1_ = new BMMClientFlashVars(GlobalAccess.stage);
            if(this.bmmSession != null)
            {
               this.bmmSession.removeEventListener(BMMSession.AUTH_FAILURE,this.onAuthFail);
               this.bmmSession.removeEventListener(BMMSession.AUTH_MAINTENANCE,this.onAuthMaintenance);
               this.bmmSession.removeEventListener(BMMSession.AUTH_SUCCESS,this.onAuthSuccess);
               this.bmmSession.removeEventListener(BMMSession.AUTH_TIMEOUT,this.onAuthTimeout);
               this.bmmSession.removeEventListener(BMMSession.GOT_USER_SESSION,this.onUserData);
               this.bmmSession.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE,this.onExternalLoginTrue);
               this.bmmSession.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT,this.onExternalLoginFault);
               this.bmmSession.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_CONFLICT,this.onExternalLoginConflict);
               this.bmmSession.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalLogoutTrue);
               this.bmmSession.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT,this.onExternalLogoutFault);
               this.bmmSession.removeEventListener(ExternalSessionEvents.EXTERNAL_RELOGIN,this.onExternalRelogin);
               this.bmmSession.dispose();
            }
            this.bmmSession = new BMMSession(GlobalAccess.stage,!_loc1_.disableFB,GlobalAccess.mcamp_id);
            this.bmmSession.addEventListener(BMMSession.AUTH_FAILURE,this.onAuthFail);
            this.bmmSession.addEventListener(BMMSession.AUTH_MAINTENANCE,this.onAuthMaintenance);
            this.bmmSession.addEventListener(BMMSession.AUTH_SUCCESS,this.onAuthSuccess);
            this.bmmSession.addEventListener(BMMSession.AUTH_TIMEOUT,this.onAuthTimeout);
            this.bmmSession.addEventListener(BMMSession.GOT_USER_SESSION,this.onUserData);
            this.bmmSession.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE,this.onExternalLoginTrue);
            this.bmmSession.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT,this.onExternalLoginFault);
            this.bmmSession.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_CONFLICT,this.onExternalLoginConflict);
            this.bmmSession.addEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalLogoutTrue);
            this.bmmSession.addEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT,this.onExternalLogoutFault);
            this.bmmSession.addEventListener(ExternalSessionEvents.EXTERNAL_RELOGIN,this.onExternalRelogin);
            return;
         }
         remoteM.establishSocketConnection();
      }
      
      private function onUserData(param1:Event) : void
      {
         dispatchEvent(new Event(BMMSession.GOT_USER_SESSION));
      }
      
      private function onExternalRelogin(param1:Event) : void
      {
         dispatchEvent(param1);
         TsLogger.log("BMSessionManager :: onExternalRelogin()");
         screensM.forceBackToLoginScreenSub();
      }
      
      private function onAuthTimeout(param1:Event) : void
      {
         this.sendAuthTrackingEvent("Timeout");
         screensM.screenDebugger.addTrace("BMSessionManager :: onAuthTimeout() - handle timeout here!");
         TsLogger.log("BMSessionManager :: onAuthTimeout() - handle timeout here!");
         dataM.firstSocketConnectionEstablished = true;
         if(dataM.runAsMobile)
         {
            if(screensM.isScreenOpened("screenWelcomeNewExisting"))
            {
               screensM.screenWelcomeNewExisting.refreshExistingPlayerButton();
            }
         }
         if(dataM.useNoConnectionMode && dataM.noConnectionModeActive)
         {
            screensM.screenWelcomeLogin.loginFailed();
         }
         this.preAuth = false;
      }
      
      private function onAuthFail(param1:Event) : void
      {
         this.sendAuthTrackingEvent("Fail");
         if(screensM.isScreenOpened("screenDebugger"))
         {
            screensM.screenDebugger.addTrace("BMSessionManager :: onAuthFail(" + this.bmmSession.lastLoginError + ")");
         }
         TsLogger.log("BMSessionManager :: onAuthFail(" + this.bmmSession.lastLoginError + ")");
         this.bmmSession.doDisconnect();
         dataM.firstSocketConnectionEstablished = true;
         if(dataM.useNoConnectionMode == false || dataM.useNoConnectionMode && dataM.noConnectionModeActive == false)
         {
            BMLoadingTimer.gi().hideLoading();
            if(BMPlatformUtils.isFaceBook)
            {
               screensM.forceBackToLoginScreenSub();
               screensM.screenConfirmation.displayCustomMessage("The game cannot connect to Facebook, refresh the page to reconnect.",this.onRefrash);
            }
            else if(dataM.installationData.hasLastLoginService && Boolean(BMLoginManager.gi().doesServiceLoginWithoutUserIntervention(dataM.installationData.lastLoginService)))
            {
               BMLoadingTimer.gi().showLoading();
               BMLoginManager.gi().doExternalLogin(dataM.installationData.lastLoginService);
            }
            else
            {
               screensM.resetClient();
               screensM.addIfNotOpened("screenWelcomeBackground");
               screensM.screenWelcomeBackground.showInitialLoginScreen(this.bmmSession.lastLoginError);
            }
         }
         this.preAuth = false;
      }
      
      private function onAuthMaintenance(param1:BMDynamicEvent) : void
      {
         var message:String = null;
         var event:BMDynamicEvent = param1;
         message = event.message;
         this.sendAuthTrackingEvent("Maintenance");
         if(screensM.isScreenOpened("screenDebugger"))
         {
            screensM.screenDebugger.addTrace("BMSessionManager :: onAuthMaintenance(" + message + ")");
         }
         TsLogger.log("BMSessionManager :: onAuthMaintenance(" + message + ")");
         this.bmmSession.doDisconnect();
         dataM.firstSocketConnectionEstablished = true;
         BMLoadingTimer.gi().hideLoading();
         screensM.screenConfirmation.displayCustomMessage(message,function():*
         {
            screensM.resetClient();
            screensM.addIfNotOpened("screenWelcomeBackground");
            screensM.screenWelcomeBackground.showInitialLoginScreen(message);
            preAuth = false;
         });
      }
      
      private function onRefrash() : void
      {
         BMPlatformUtils.refrashPage();
      }
      
      private function sendAuthTrackingEvent(param1:String) : void
      {
         dataM.trackEvent("Auth",param1);
      }
      
      public function authenticate() : void
      {
         this.sendAuthTrackingEvent("Start");
         TsLogger.log("BMSessionManager :: authenticate()");
         this.bmmSession.authenticate();
      }
      
      private function onAuthSuccess(param1:Event) : void
      {
         this.sendAuthTrackingEvent("Success");
         TsLogger.log("BMSessionManager :: onAuthSuccess() - called");
         dataM.firstSocketConnectionEstablished = true;
         if(this._loggedIn == false)
         {
            if(screensM.isScreenOpened("screenDebugger"))
            {
               screensM.screenDebugger.addTrace("BMSessionManager :: onAuthSuccess()");
            }
            TsLogger.log("BMSessionManager :: onAuthSuccess() - calling remoteM.establishSocketConnection()");
            remoteM.establishSocketConnection();
            this.preAuth = false;
            this._loggedIn = true;
         }
         else
         {
            if(screensM.isScreenOpened("screenDebugger"))
            {
               screensM.screenDebugger.addTrace("BMSessionManager :: onAuthSuccess was triggered again for an unknown reason");
            }
            TsLogger.log("BMSessionManager :: onAuthSuccess was triggered again for an unknown reason");
            remoteM.establishSocketConnection();
            this.preAuth = false;
         }
      }
      
      public function resetLoggedInIndicator() : void
      {
         this._loggedIn = false;
      }
      
      public function tryToLogin(param1:String, param2:String) : void
      {
         TsLogger.log("BMSessionManager :: tryToLogin()");
         this.bmmSession.doLogin(param1,param2);
      }
      
      public function tryToLoginKong(param1:Number, param2:String) : void
      {
         TsLogger.log("BMSessionManager :: tryToLoginKong()");
         this.bmmSession.addEventListener(BMMSession.GOT_USER_SESSION,this.haveKongUserSession);
         this.bmmSession.doLogin(String(param1),param2);
      }
      
      private function haveKongUserSession(param1:Event) : void
      {
         this.bmmSession.removeEventListener(BMMSession.GOT_USER_SESSION,this.haveKongUserSession);
         dispatchEvent(new Event(BMSessionManager.GOT_KONG_USER_SESSION));
      }
      
      public function checkKongUserExists(param1:Number) : *
      {
         TsLogger.log("BMSessionManager :: checkKongUserExists()");
         this.bmmSession.addEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.bmmSession.addEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.bmmSession.addEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         this.bmmSession.checkKongUserExists(param1);
      }
      
      private function kongUserExists(param1:Event) : *
      {
         TsLogger.log("BMSessionManager :: kongUserExists()");
         this.bmmSession.removeEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.bmmSession.removeEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.bmmSession.removeEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         dispatchEvent(new Event(BMMSessionManager.EVENT_KONG_USER_EXISTS_TRUE));
      }
      
      private function kongUserDoesntExist(param1:Event) : *
      {
         TsLogger.log("BMSessionManager :: kongUserDoesntExist()");
         this.bmmSession.removeEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.bmmSession.removeEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.bmmSession.removeEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         dispatchEvent(new Event(BMMSessionManager.EVENT_KONG_USER_EXISTS_FALSE));
      }
      
      private function checkKongUserExistsFault(param1:Event) : *
      {
         TsLogger.log("BMSessionManager :: checkKongUserExistsFault()");
         this.bmmSession.removeEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.bmmSession.removeEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.bmmSession.removeEventListener(BMMSessionManager.EVENT_KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         dispatchEvent(new Event(BMMSessionManager.EVENT_KONG_USER_EXISTS_FAULT));
      }
      
      public function doExternalLogin(param1:String, param2:String, param3:String) : void
      {
         this.bmmSession.doExternalLogin(param1,param2,param3);
      }
      
      private function onExternalLoginTrue(param1:Event) : void
      {
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE));
      }
      
      private function onExternalLoginFault(param1:Event) : void
      {
         if(screensM.isScreenOpened("screenWelcomeLogin"))
         {
            screensM.screenWelcomeLogin.loginFailed(this.bmmSession.lastLoginError);
         }
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT));
      }
      
      private function onExternalLoginConflict(param1:ExternalLoginConflictEvent) : void
      {
         dispatchEvent(param1);
      }
      
      public function doExternalLogout(param1:String) : *
      {
         this.bmmSession.doExternalLogout(param1);
      }
      
      private function onExternalLogoutTrue(param1:DataEvent) : void
      {
         dispatchEvent(param1.clone());
      }
      
      private function onExternalLogoutFault(param1:Event) : void
      {
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT));
      }
      
      public function get lastLoginError() : String
      {
         return this.bmmSession.lastLoginError;
      }
      
      public function logout() : void
      {
         TsLogger.log("BMSessionManager :: logout()");
         this.bmmSession.doLogout();
      }
      
      public function doDisconnect() : void
      {
         this.bmmSession.doDisconnect();
      }
      
      public function isExternalLoggedIn(param1:String) : Boolean
      {
         return this.bmmSession.isExternalLoggedIn(param1);
      }
      
      public function mergeAccounts(param1:Number, param2:String, param3:String, param4:String) : void
      {
         this.bmmSession.mergeAccounts(param1,param2,param3,param4);
      }
      
      public function get userData() : Object
      {
         return this.bmmSession.userData;
      }
      
      public function set userData(param1:Object) : *
      {
         this.bmmSession.userData = param1;
      }
      
      public function switchToServer(param1:Boolean) : *
      {
         this.bmmSession.switchToServer(param1);
      }
      
      public function get currentServerIsMultiplayer() : Boolean
      {
         return this.bmmSession.currentServerIsMultiplayer;
      }
   }
}

