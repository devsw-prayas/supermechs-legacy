package net.battleMechsMulti.managers
{
   import com.greensock.TweenMax;
   import flash.events.DataEvent;
   import flash.events.Event;
   import net.battleMechsMulti.data.ItemDBDumper;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.session.LoginAsFlowTypes;
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
      
      public static const STATE_SETTINGS_UPDATE:String = "SETTINGS_UPDATE";
      
      private var _loginState:String = "DISCONNECTED";
      
      private var _loginAsFlowType:String = "";
      
      private var _disconnectCount:int = 0;
      
      private var _disableAutoRetryLogin:Boolean = false;
      
      private var _nextDisconnectMessage:String;
      
      private var _transactionService:String;
      
      private var _transactionUserName:String;
      
      private var _transactionPass:String;
      
      private var _settingsUpdateRequired:Boolean = false;
      
      private var _switchToServerCallBack:Function = null;
      
      private var _switchToServerParams:Array = null;
      
      private var _isRegisteredToDataDumpFinished:Boolean = false;
      
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
         TsLogger.log("BMLoginManager :: reset");
         this._loginState = STATE_DISCONNECTED;
      }
      
      public function get isConnectedOrLoggingIn() : Boolean
      {
         return this._loginState == STATE_CONNECTED || this._loginState == STATE_LOGGING_IN || this._loginState == STATE_SILENT_LOGGING_IN;
      }
      
      public function get isConnected() : Boolean
      {
         return this._loginState == STATE_CONNECTED;
      }
      
      public function get isDisconnected() : Boolean
      {
         return this._loginState == STATE_DISCONNECTED;
      }
      
      public function set settingsUpdateRequired(param1:Boolean) : void
      {
         this._settingsUpdateRequired = param1;
      }
      
      public function get settingsUpdateRequired() : Boolean
      {
         return this._settingsUpdateRequired;
      }
      
      public function generateLogout() : void
      {
         TsLogger.log("BMLoginManager :: generateLogout");
         BMGoogleGamesManager.getInstance().logOutLocal();
         FacebookManager.gi().logout(false);
         if(dataM.hasPlayerProfile)
         {
            dataM.myProfile.resetMissionSlotAndMode();
         }
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
            dataM.trackEvent(5,"LoginFlow","Start","google_first_install");
         }
         else if(dataM.welcomeScreenInitialized == false && false && dataM.installationData.isInstallSession())
         {
            this.doExternalLogin(LoginServices.GAME_CENTER);
            dataM.trackEvent(5,"LoginFlow","Start","gamecenter_first_install");
         }
         else
         {
            BMLoadingTimer.gi().showLoading();
            dataM.sessionManager.authenticate();
            dataM.trackEvent(5,"LoginFlow","Start","authenticate");
         }
      }
      
      public function endLoginFlow() : void
      {
         TsLogger.log("BMLoginManager :: endLoginFlow _loginState:" + this._loginState);
         BMLoadingTimer.gi().hideLoading();
         this._disconnectCount = 0;
         this._disableAutoRetryLogin = false;
         switch(this._loginState)
         {
            case STATE_SETTINGS_UPDATE:
               this.gotPlayerData();
               break;
            case STATE_LOGGING_IN:
               this.endLoginAsFlow();
               this.gotPlayerData();
               dataM.trackEvent(2,"LoginFlow","End");
               break;
            case STATE_SILENT_LOGGING_IN:
               this.gotPlayerData();
               screensM.notifyClientDataReloaded();
               break;
            case STATE_SWITCH_SERVER:
               this.switchToServerFinish();
               break;
            case STATE_CONNECTED:
               this.gotPlayerData();
         }
         this._loginState = STATE_CONNECTED;
         if(this._settingsUpdateRequired)
         {
            this._settingsUpdateRequired = false;
            screensM.screenTransitionsManager.onSettingsUpdateComplete();
         }
      }
      
      public function gotPlayerData() : void
      {
         dataM.initializeOnlineMode();
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL)
         {
            if(dataM.myProfile.level < 3 && dataM.myProfile.tutorialLevel > 0)
            {
               screensM.screenWelcomeBackground.playingAsGuest();
            }
            else if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
            {
               screensM.addIfNotOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
               screensM.screenWelcomeNewExisting.refreshScreen();
            }
         }
         else
         {
            BMNotificationsManager.gi().refreshRetentionNotifications();
            if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
            {
               screensM.screenWelcomeBackground.showWelcomeBack();
            }
         }
         dataM.gameOfWhalesM.alertLogin();
      }
      
      public function switchToServer(param1:Boolean, param2:Function, param3:* = null) : void
      {
         var requestMultiPlayerServer:Boolean = param1;
         var callBack:Function = param2;
         var params:* = param3;
         if(this._switchToServerCallBack != null)
         {
            TsLogger.log("BMLoginManager::switchToServer warning: another call is allready in progress");
         }
         this._switchToServerCallBack = callBack;
         this._switchToServerParams = params;
         if(!this.isNeedToSwitchServerTo(requestMultiPlayerServer))
         {
            this.switchToServerFinish();
            return;
         }
         this._loginState = STATE_SWITCH_SERVER;
         TsLogger.log("BMLoginManager::switchToServer " + requestMultiPlayerServer);
         BMLoadingTimer.gi().showLoading();
         if(remoteM.socketM.itemDBDumper != null && remoteM.socketM.itemDBDumper.isFinished() == false)
         {
            TsLogger.log("BMLoginManager::Data Dumping is running, scheduling switchToServer");
            if(this._isRegisteredToDataDumpFinished == false)
            {
               this._isRegisteredToDataDumpFinished = true;
               remoteM.socketM.itemDBDumper.addEventListener(ItemDBDumper.FINISHED,function(param1:Event):*
               {
                  var e:Event = param1;
                  TsLogger.log("BMLoginManager::Data Dumping finished, calling switchToServer");
                  e.currentTarget.removeEventListener(e.type,arguments.callee);
                  disconnectAndReconnect(requestMultiPlayerServer,function():*
                  {
                     _isRegisteredToDataDumpFinished = false;
                  });
               });
            }
            return;
         }
         this.disconnectAndReconnect(requestMultiPlayerServer);
      }
      
      public function disconnectAndReconnect(param1:Boolean, param2:Function = null) : *
      {
         var $requestMultiPlayerServer:Boolean = param1;
         var callback:Function = param2;
         remoteM.socketM.silentDisconnect();
         TweenMax.delayedCall(2 / 30,function():*
         {
            TsLogger.log("BMLoginManager::disconnectAndReconnect.delayedCall.switchToServer " + $requestMultiPlayerServer + " " + callback);
            dataM.sessionManager.switchToServer($requestMultiPlayerServer);
            if(callback != null)
            {
               callback();
            }
         });
      }
      
      public function updateSettings() : void
      {
         this._loginState = STATE_SETTINGS_UPDATE;
         this.disconnectAndReconnect(dataM.sessionManager.currentServerIsMultiplayer);
      }
      
      public function isNeedToSwitchServerTo(param1:Boolean) : Boolean
      {
         return dataM.sessionManager.currentServerIsMultiplayer != param1 && this.isConnected;
      }
      
      private function switchToServerFinish() : *
      {
         TsLogger.log("BMLoginManager::switchToServerFinish " + dataM.sessionManager.currentServerIsMultiplayer);
         BMLoadingTimer.gi().hideLoading();
         if(screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
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
            screensM.addIfNotOpened(BMScreensManager.SCR_LOST_CONNECTION);
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
         return !this._disableAutoRetryLogin && !screensM.isScreenOpened(BMScreensManager.SCR_BATTLE) && this._disconnectCount < 3 && Boolean(BMMSessionManager.gi().isAlive);
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
               screensM.addScreen(BMScreensManager.SCR_WELCOME_LOGIN);
               screensM.screenWelcomeLogin.refreshScreen(true);
               BMLoadingTimer.gi().hideLoading();
               screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
               break;
            case LoginServices.GOOGLE_PLAY:
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
               BMGoogleGamesManager.gi().logIn();
               break;
            case LoginServices.GAME_CENTER:
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
            case LoginServices.GAME_CENTER:
            case LoginServices.FACEBOOK:
               FacebookManager.gi().logout();
         }
      }
      
      private function onExternalLoginConflict(param1:ExternalLoginConflictEvent) : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
         {
            BMLoadingTimer.gi().hideLoading();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_LOGIN))
         {
            screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN);
         }
         screensM.addScreen(BMScreensManager.SCR_SELECT_ACCOUNT);
         screensM.screenSelectAccount.setData(param1.currentPlayer,param1.newPlayer);
      }
      
      private function onExternalLoginRelogin(param1:Event) : void
      {
         if(dataM.installationData.lastLoginService == LoginServices.GENERATED_USER)
         {
            dataM.installationData.lastLoginService = this._transactionService;
         }
      }
      
      private function onExternalSignInFailed(param1:Event) : void
      {
         TsLogger.log("BMLoginManager :: onExternalSignInFailed");
         if(this._loginState != STATE_CONNECTED)
         {
            this._loginState = STATE_DISCONNECTED;
         }
         BMLoadingTimer.gi().hideLoading();
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(this._transactionService == LoginServices.SUPERMECHS)
         {
            screensM.addIfNotOpened(BMScreensManager.SCR_WELCOME_LOGIN);
            screensM.screenWelcomeLogin.refreshScreen(true);
            screensM.screenWelcomeLogin.showWrongUsernamePasswordError();
         }
         else
         {
            if(dataM.sessionManager.lastLoginError != null)
            {
               screensM.screenConfirmation.displayCustomMessage("Could not sign in : " + dataM.sessionManager.lastLoginError);
            }
            if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
            {
               screensM.addIfNotOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
               screensM.screenWelcomeNewExisting.refreshScreen();
            }
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_ACCOUNTS))
         {
            screensM.screenProfileAccounts.refreshButtonsAndStatus();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
         {
            screensM.screenWelcomeNewExisting.isInteractive = true;
         }
      }
      
      private function onExternalSignInSucceeded(param1:Event) : void
      {
         dataM.installationData.lastLoginService = this._transactionService;
         if(remoteM.socketM.isConnected)
         {
            this._loginState = STATE_CONNECTED;
         }
         dataM.resetGuestSharedObject("onExternalSignInSucceeded");
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_LOGIN_AS))
         {
            BMLoadingTimer.gi().showLoading();
            screensM.screenWelcomeLoginAs.removeMe();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_ACCOUNTS))
         {
            screensM.screenProfileAccounts.refreshButtonsAndStatus();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_LOGIN))
         {
            screensM.screenWelcomeLogin.loginSuccess();
         }
         if(!remoteM.socketM.isConnected && tutorialM.addGuestDataToNextConnection)
         {
            BMLoadingTimer.gi().showLoading();
         }
         this.endLoginAsFlow();
      }
      
      private function onExternalSignedOut(param1:DataEvent) : void
      {
         if(param1.data == dataM.installationData.lastLoginService)
         {
            dataM.installationData.lastLoginService = "";
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_ACCOUNTS))
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
            case LoginServices.GAME_CENTER:
               break;
            case LoginServices.FACEBOOK:
               FacebookManager.gi().externalLoginResolveConflict(param1);
         }
      }
      
      public function externalLoginCancelConflict() : *
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.doExternalLogout(this._transactionService);
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
         {
            screensM.addScreen(BMScreensManager.SCR_WELCOME_LOGIN_AS);
            screensM.screenWelcomeLoginAs.refreshScreen();
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_LOGIN))
         {
            screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN);
         }
      }
      
      public function legacyTryToLogin(param1:String, param2:String) : void
      {
         this._loginState = STATE_LOGGING_IN;
         BMLoadingTimer.gi().showLoading();
         dataM.sessionManager.tryToLogin(param1,param2);
      }
      
      public function disableAutoRetryLogin() : *
      {
         this._disableAutoRetryLogin = true;
      }
      
      public function startLoginAsFlow(param1:String) : void
      {
         this._loginAsFlowType = param1;
         screensM.addScreen(BMScreensManager.SCR_WELCOME_LOGIN_AS);
         screensM.screenWelcomeLoginAs.refreshScreen();
      }
      
      public function endLoginAsFlow() : void
      {
         this._loginAsFlowType = LoginAsFlowTypes.NONE;
      }
      
      public function get loginAsFlowType() : String
      {
         return this._loginAsFlowType;
      }
      
      public function get isGuestOrSaveLoginAsFlow() : Boolean
      {
         return this._loginAsFlowType == LoginAsFlowTypes.GUEST || this._loginAsFlowType == LoginAsFlowTypes.SAVE_PROGRESS;
      }
      
      public function reOpenLoginAs() : void
      {
         screensM.addScreen(BMScreensManager.SCR_WELCOME_LOGIN_AS);
         screensM.screenWelcomeLoginAs.refreshScreen();
      }
      
      public function setNextDisconnectDescriptionMessage(param1:String) : *
      {
         this._nextDisconnectMessage = param1;
      }
      
      public function consumeNextDisconnectDescriptionMessage() : String
      {
         var _loc1_:String = this._nextDisconnectMessage;
         this._nextDisconnectMessage = null;
         return _loc1_;
      }
   }
}

