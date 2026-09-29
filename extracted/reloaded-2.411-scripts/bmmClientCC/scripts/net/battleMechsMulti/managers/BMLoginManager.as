package net.battleMechsMulti.managers
{
   import flash.events.DataEvent;
   import flash.events.Event;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.session.LoginServices;
   import net.tacticsoft.managers.BMMSessionManager;
   import net.tacticsoft.managers.FacebookManager;
   import net.tacticsoft.responders.events.ExternalLoginConflictEvent;
   import net.tacticsoft.responders.events.ExternalSessionEvents;
   
   public class BMLoginManager extends BMBaseClass
   {
      
      private static var _instance:BMLoginManager;
      
      private static var _allowInstantiation:Boolean;
      
      public static const STATE_DISCONNECTED:String = "DISCONNECTED";
      
      public static const STATE_CONNECTED:String = "CONNECTED";
      
      public static const STATE_LOGGING_IN:String = "LOGGING_IN";
      
      public static const STATE_SILENT_LOGGING_IN:String = "SILENT_LOGGING_IN";
      
      public static const STATE_LOGGING_OUT:String = "LOGGING_OUT";
      
      public static const STATE_SWITCH_SERVER:String = "SWITCH_SERVER";
      
      public static const LOGIN_TYPE_UNKNOWN:* = 0;
      
      public static const LOGIN_TYPE_NEW_USER:* = 1;
      
      public static const LOGIN_TYPE_EXISTING_USER:* = 2;
      
      public static const LOGIN_TYPE_REGISTER_GENERATED:* = 3;
      
      private var _loginState:String = "DISCONNECTED";
      
      public var loginType:int = 0;
      
      private var _disconnectCount:int = 0;
      
      private var _disableAutoRetryLogin:Boolean = false;
      
      private var _transactionService:String;
      
      private var _transactionUserName:String;
      
      private var _transactionPass:String;
      
      private var _switchToServerCallBack:Function = null;
      
      private var _switchToServerParams:Array = null;
      
      private var _didInitializeExternalLoginSystem:* = false;
      
      public function BMLoginManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMLoginManager.getInstance() instead of new.");
         }
      }
      
      public static function gi() : BMLoginManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMLoginManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("loginManager");
      }
      
      public function get loginState() : String
      {
         return this._loginState;
      }
      
      public function reset() : *
      {
         this._loginState = STATE_DISCONNECTED;
         this.loginType = LOGIN_TYPE_UNKNOWN;
      }
      
      public function get isConnected() : Boolean
      {
         return this._loginState == STATE_CONNECTED;
      }
      
      public function generateLogout() : void
      {
         TsLogger.log("BMLoginManager :: generateLogout");
         BMGoogleGamesManager.getInstance().logOutLocal();
         FacebookManager.gi().logout(false);
         dataM.installationData.lastLoginService = "";
         dataM.bmmSessionSO.clear();
         remoteM.doDisco();
         dataM.sessionManager.logout();
         dataM.sessionManager.resetLoggedInIndicator();
         this._loginState = STATE_LOGGING_OUT;
      }
      
      public function startLoginFlow() : void
      {
         TsLogger.log("BMLoginManager :: startLoginFlow");
         this._loginState = STATE_LOGGING_IN;
         this.doLogIn();
      }
      
      private function doLogIn() : *
      {
         if(dataM.welcomeScreenInitialized == false && dataM.installationData.isInstallSession())
         {
            this.doExternalLogin(LoginServices.GOOGLE_PLAY);
            dataM.trackEvent("LoginFlow","Start","google_first_install");
         }
         else
         {
            BMLoadingTimer.gi().showLoading();
            dataM.sessionManager.authenticate();
            dataM.trackEvent("LoginFlow","Start","authenticate");
         }
      }
      
      public function endLoginFlow() : void
      {
         TsLogger.log("BMLoginManager :: endLoginFlow");
         BMLoadingTimer.gi().hideLoading();
         this._disconnectCount = 0;
         this._disableAutoRetryLogin = false;
         switch(this._loginState)
         {
            case STATE_LOGGING_IN:
               this.gotPlayerData();
               dataM.trackEvent("LoginFlow","End");
               break;
            case STATE_SILENT_LOGGING_IN:
               this.gotPlayerData();
               screensM.notifyClientDataReloaded();
               break;
            case STATE_SWITCH_SERVER:
               this.switchToServerFinish();
         }
         this._loginState = STATE_CONNECTED;
      }
      
      public function gotPlayerData() : void
      {
         dataM.initializeOnlineMode();
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL)
         {
            screensM.screenWelcomeBackground.playingAsGuest();
         }
         else
         {
            BMNotificationsManager.gi().refreshRetentionNotifications();
            if(this.loginType == LOGIN_TYPE_REGISTER_GENERATED)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("changePlayerNameAndTermsOfUse_online",-1,-1);
               this.loginType = LOGIN_TYPE_UNKNOWN;
            }
            else if(screensM.isScreenOpened("screenWelcomeBackground"))
            {
               screensM.screenWelcomeBackground.showWelcomeBack();
            }
         }
      }
      
      public function switchToServer(param1:Boolean, param2:Function, param3:* = null) : void
      {
         if(this._switchToServerCallBack != null)
         {
            TsLogger.log("BMLoginManager::switchToServer warning: another call is allready in progress");
         }
         this._switchToServerCallBack = param2;
         this._switchToServerParams = param3;
         if(!this.isNeedToSwitchServerTo(param1))
         {
            this.switchToServerFinish();
            return;
         }
         this._loginState = STATE_SWITCH_SERVER;
         TsLogger.log("BMLoginManager::switchToServer " + param1);
         BMLoadingTimer.gi().showLoading();
         remoteM.socketM.silentDisconnect();
         dataM.sessionManager.switchToServer(param1);
      }
      
      public function isNeedToSwitchServerTo(param1:Boolean) : Boolean
      {
         return dataM.sessionManager.currentServerIsMultiplayer != param1 && this.isConnected;
      }
      
      private function switchToServerFinish() : *
      {
         TsLogger.log("BMLoginManager::switchToServerFinish " + dataM.sessionManager.currentServerIsMultiplayer);
         BMLoadingTimer.gi().hideLoading();
         if(screensM.isScreenOpened("screenMainMenu"))
         {
            screensM.screenMainMenu.refreshStarterPackMechCounter();
         }
         var _loc1_:Function = this._switchToServerCallBack;
         var _loc2_:Array = this._switchToServerParams;
         this.switchToServerReset();
         if(_loc1_ != null)
         {
            if(_loc2_ == null || _loc2_.length == 0)
            {
               _loc1_();
            }
            else if(_loc2_.length == 1)
            {
               _loc1_(_loc2_[0]);
            }
            else if(_loc2_.length == 2)
            {
               _loc1_(_loc2_[0],_loc2_[1]);
            }
            else
            {
               TsLogger.log("switchToServerFinish ERROR: can support up to 2 params");
            }
         }
      }
      
      private function switchToServerReset() : *
      {
         this._switchToServerCallBack = null;
         this._switchToServerParams = null;
      }
      
      public function doDisconnectFlow() : void
      {
         TsLogger.log("BMLoginManager :: doDisconnectFlow");
         var _loc1_:String = this._loginState;
         this.disconnect();
         screensM.screenBlack.unBlockOpeningScreen();
         BMLoadingTimer.gi().hideLoading();
         if(tutorialM.isTutorialActive())
         {
            screensM.forceBackToLoginScreenSub();
            return;
         }
         if(!this.canAutoReLogin)
         {
            screensM.addIfNotOpened("screenLostConnection");
            screensM.screenLostConnection.refreshScreen();
            return;
         }
         if(_loc1_ == STATE_LOGGING_IN)
         {
            this.startLoginFlow();
         }
         else
         {
            this.startSilentReLoginFlow();
         }
         ++this._disconnectCount;
      }
      
      private function get canAutoReLogin() : Boolean
      {
         return !this._disableAutoRetryLogin && !screensM.isScreenOpened("screenBattle") && this._disconnectCount < 3 && Boolean(BMMSessionManager.gi().isAlive);
      }
      
      public function startSilentReLoginFlow() : void
      {
         TsLogger.log("BMLoginManager :: startSilentReLoginFlow " + this._disconnectCount);
         this._loginState = STATE_SILENT_LOGGING_IN;
         this.doLogIn();
      }
      
      public function disconnect() : void
      {
         TsLogger.log("BMLoginManager :: disconnect");
         this._loginState = STATE_DISCONNECTED;
         remoteM.doDisco();
         dataM.sessionManager.doDisconnect();
      }
      
      public function initializeExternalLoginSystemIfNeeded() : void
      {
         if(!this._didInitializeExternalLoginSystem)
         {
            dataM.sessionManager.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE,this.onExternalSignInSucceeded);
            dataM.sessionManager.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT,this.onExternalSignInFailed);
            dataM.sessionManager.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_CONFLICT,this.onExternalLoginConflict);
            dataM.sessionManager.addEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalSignedOut);
            dataM.sessionManager.addEventListener(ExternalSessionEvents.EXTERNAL_RELOGIN,this.onExternalLoginRelogin);
            BMGoogleGamesManager.getInstance().addEventListener(BMGoogleGamesManager.SIGN_IN_FAILED,this.onExternalSignInFailed);
            if(false == false)
            {
               FacebookManager.getInstance(GlobalAccess.stage).addEventListener(FacebookManager.FB_LOGIN_FAIL,this.onExternalSignInFailed);
               FacebookManager.getInstance().SetSession(dataM.sessionManager);
            }
            this._didInitializeExternalLoginSystem = true;
         }
      }
      
      public function doesServiceLoginWithoutUserIntervention(param1:String) : *
      {
         switch(param1)
         {
            case LoginServices.SUPERMECHS:
               return false;
            default:
               return true;
         }
      }
      
      public function doExternalLogin(param1:String, param2:String = null, param3:String = null) : *
      {
         this.initializeExternalLoginSystemIfNeeded();
         this._transactionService = param1;
         this._transactionUserName = param2;
         this._transactionPass = param3;
         if(param2 != null)
         {
            if(this._loginState != STATE_SILENT_LOGGING_IN)
            {
               this._loginState = STATE_LOGGING_IN;
            }
            dataM.sessionManager.doExternalLogin(param1,param2,param3);
            return;
         }
         if(this.doesServiceLoginWithoutUserIntervention(param1))
         {
            if(this._loginState != STATE_SILENT_LOGGING_IN)
            {
               this._loginState = STATE_LOGGING_IN;
            }
         }
         switch(param1)
         {
            case LoginServices.SUPERMECHS:
               screensM.addScreen("screenWelcomeLogin");
               screensM.screenWelcomeLogin.refreshScreen(true);
               BMLoadingTimer.gi().hideLoading();
               screensM.removeScreen("screenConfirmation");
               break;
            case LoginServices.GOOGLE_PLAY:
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
               BMGoogleGamesManager.gi().logIn();
               break;
            case LoginServices.FACEBOOK:
               FacebookManager.gi().login(true);
               break;
            case LoginServices.GENERATED_USER:
               dataM.sessionManager.doExternalLogin(LoginServices.GENERATED_USER,"",dataM.installationData.deviceId);
         }
      }
      
      public function doExternalLogout(param1:String) : *
      {
         switch(param1)
         {
            case LoginServices.SUPERMECHS:
               dataM.sessionManager.doExternalLogout(param1);
               break;
            case LoginServices.GOOGLE_PLAY:
               BMGoogleGamesManager.gi().logOut();
               break;
            case LoginServices.FACEBOOK:
               FacebookManager.gi().logout();
         }
      }
      
      private function onExternalLoginConflict(param1:ExternalLoginConflictEvent) : void
      {
         if(screensM.isScreenOpened("screenWelcomeBackground"))
         {
            BMLoadingTimer.gi().hideLoading();
         }
         if(screensM.isScreenOpened("screenWelcomeLogin"))
         {
            screensM.removeScreen("screenWelcomeLogin");
         }
         screensM.addScreen("screenSelectAccount");
         screensM.screenSelectAccount.setData(param1.currentPlayer,param1.newPlayer);
      }
      
      private function onExternalLoginRelogin(param1:Event) : void
      {
         if(dataM.installationData.lastLoginService == LoginServices.GENERATED_USER)
         {
            dataM.installationData.lastLoginService = this._transactionService;
         }
      }
      
      private function finishOnExternalSignInFailed() : void
      {
         screensM.removeScreen("screenConfirmation");
         if(screensM.isScreenOpened("screenWelcomeBackground"))
         {
            BMLoadingTimer.gi().hideLoading();
            if(screensM.isScreenOpened("screenWelcomeLogin"))
            {
               screensM.screenWelcomeLogin.showWrongUsernamePasswordError();
            }
            else
            {
               screensM.addIfNotOpened("screenWelcomeNewExisting");
               screensM.screenWelcomeNewExisting.refreshScreen();
            }
         }
         if(screensM.isScreenOpened("screenWelcomeLoginAs"))
         {
         }
         if(screensM.isScreenOpened("screenProfileAccounts"))
         {
            screensM.screenProfileAccounts.refreshButtonsAndStatus();
         }
         if(screensM.isScreenOpened("screenWelcomeNewExisting"))
         {
            screensM.screenWelcomeNewExisting.isInteractive = true;
         }
      }
      
      private function onExternalSignInFailed(param1:Event) : void
      {
         if(this._loginState != STATE_CONNECTED)
         {
            this._loginState = STATE_DISCONNECTED;
         }
         if(dataM.sessionManager.lastLoginError != null)
         {
            screensM.screenConfirmation.displayCustomMessage("Could not sign in : " + dataM.sessionManager.lastLoginError,this.finishOnExternalSignInFailed);
         }
         else
         {
            this.finishOnExternalSignInFailed();
         }
      }
      
      private function onExternalSignInSucceeded(param1:Event) : void
      {
         dataM.installationData.lastLoginService = this._transactionService;
         dataM.resetGuestSharedObject("onExternalSignInSucceeded");
         screensM.removeScreen("screenConfirmation");
         if(screensM.isScreenOpened("screenWelcomeLoginAs"))
         {
            BMLoadingTimer.gi().showLoading();
            screensM.screenWelcomeLoginAs.removeMe();
         }
         if(screensM.isScreenOpened("screenProfileAccounts"))
         {
            screensM.screenProfileAccounts.refreshButtonsAndStatus();
         }
         if(screensM.isScreenOpened("screenWelcomeLogin"))
         {
            screensM.screenWelcomeLogin.loginSuccess();
         }
      }
      
      private function onExternalSignedOut(param1:DataEvent) : void
      {
         if(param1.data == dataM.installationData.lastLoginService)
         {
            dataM.installationData.lastLoginService = "";
         }
         if(screensM.isScreenOpened("screenProfileAccounts"))
         {
            screensM.screenProfileAccounts.refreshButtonsAndStatus();
         }
      }
      
      public function externalLoginResolveConflict(param1:Number) : void
      {
         switch(this._transactionService)
         {
            case LoginServices.SUPERMECHS:
               dataM.sessionManager.mergeAccounts(param1,this._transactionService,this._transactionUserName,this._transactionPass);
               break;
            case LoginServices.GOOGLE_PLAY:
               BMGoogleGamesManager.gi().externalLoginResolveConflict(param1);
               break;
            case LoginServices.FACEBOOK:
               FacebookManager.gi().externalLoginResolveConflict(param1);
         }
      }
      
      public function externalLoginCancelConflict() : *
      {
         screensM.removeScreen("screenConfirmation");
         this.doExternalLogout(this._transactionService);
         if(screensM.isScreenOpened("screenWelcomeLogin"))
         {
            screensM.removeScreen("screenWelcomeLogin");
         }
      }
      
      public function legacyTryToLogin(param1:String, param2:String) : void
      {
         this._loginState = STATE_LOGGING_IN;
         dataM.sessionManager.tryToLogin(param1,param2);
         BMLoadingTimer.gi().showLoading();
      }
      
      public function disableAutoRetryLogin() : *
      {
         this._disableAutoRetryLogin = true;
      }
   }
}

