package net.battleMechsMulti.managers
{
   import com.distriqt.extension.googleidentity.GoogleIdentity;
   import com.distriqt.extension.googleidentity.GoogleIdentityOptions;
   import com.distriqt.extension.googleidentity.GoogleIdentityOptionsBuilder;
   import com.distriqt.extension.googleidentity.events.GoogleIdentityEvent;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.battleMechsMulti.session.BMMSession;
   import net.battleMechsMulti.session.LoginServices;
   import net.tacticsoft.responders.events.ExternalLoginConflictEvent;
   import net.tacticsoft.responders.events.ExternalSessionEvents;
   
   public class BMGoogleGamesManager extends EventDispatcher
   {
      
      private static var _instance:BMGoogleGamesManager;
      
      public static const SIGN_IN_FAILED:String = "SIGN_IN_FAILED";
      
      public static const SIGN_IN_SUCCEEDED:String = "SIGN_IN_SUCCEEDED";
      
      public static const SIGNED_OUT:String = "SIGNED_OUT";
      
      private var _currentGamesID:String = null;
      
      private var _currentGamesName:String = null;
      
      private var _currentPlayerHiResImageUrl:String = null;
      
      private var _currentPlayerIconImageUrl:String = null;
      
      private var _currentToken:String = null;
      
      private var _didInitGoogleGames:Boolean = false;
      
      private var _isCallingSilentSignIn:Boolean = false;
      
      private var _session:BMSessionManager;
      
      private var _alreadyCallingSignIn:Boolean = false;
      
      private var achivmentKeysConversion:Object = {
         1025:"CgkI7szDuOQPEAIQAg",
         1026:"CgkI7szDuOQPEAIQBg",
         1027:"CgkI7szDuOQPEAIQAw",
         1028:"CgkI7szDuOQPEAIQBA",
         1029:"CgkI7szDuOQPEAIQBQ",
         1030:"CgkI7szDuOQPEAIQBw",
         1031:"CgkI7szDuOQPEAIQCA",
         1032:"CgkI7szDuOQPEAIQCQ",
         1040:"CgkI7szDuOQPEAIQCg",
         1043:"CgkI7szDuOQPEAIQCw",
         1049:"CgkI7szDuOQPEAIQDA",
         1055:"CgkI7szDuOQPEAIQDQ",
         1056:"CgkI7szDuOQPEAIQDg",
         1060:"CgkI7szDuOQPEAIQDw",
         1063:"CgkI7szDuOQPEAIQEA",
         1066:"CgkI7szDuOQPEAIQEQ",
         1070:"CgkI7szDuOQPEAIQEg",
         1073:"CgkI7szDuOQPEAIQEw",
         1100:"CgkI7szDuOQPEAIQFA",
         1090:"CgkI7szDuOQPEAIQFQ",
         1091:"CgkI7szDuOQPEAIQFg",
         1103:"CgkI7szDuOQPEAIQFw",
         1120:"CgkI7szDuOQPEAIQGA",
         1033:"CgkI7szDuOQPEAIQGQ",
         1046:"CgkI7szDuOQPEAIQGg",
         1041:"CgkI7szDuOQPEAIQGw",
         1044:"CgkI7szDuOQPEAIQHA",
         1050:"CgkI7szDuOQPEAIQHQ",
         1061:"CgkI7szDuOQPEAIQHg",
         1064:"CgkI7szDuOQPEAIQHw",
         1067:"CgkI7szDuOQPEAIQIA",
         1071:"CgkI7szDuOQPEAIQIQ",
         1074:"CgkI7szDuOQPEAIQIg",
         1101:"CgkI7szDuOQPEAIQIw",
         1104:"CgkI7szDuOQPEAIQJA",
         1034:"CgkI7szDuOQPEAIQJQ",
         1047:"CgkI7szDuOQPEAIQJg",
         1042:"CgkI7szDuOQPEAIQJw",
         1045:"CgkI7szDuOQPEAIQKA",
         1051:"CgkI7szDuOQPEAIQKQ",
         1062:"CgkI7szDuOQPEAIQKg",
         1065:"CgkI7szDuOQPEAIQKw",
         1068:"CgkI7szDuOQPEAIQLA",
         1072:"CgkI7szDuOQPEAIQLQ",
         1075:"CgkI7szDuOQPEAIQLg",
         1102:"CgkI7szDuOQPEAIQLw",
         1105:"CgkI7szDuOQPEAIQMA",
         1035:"CgkI7szDuOQPEAIQMQ",
         1048:"CgkI7szDuOQPEAIQMg",
         1001:"CgkI7szDuOQPEAIQNA",
         1002:"CgkI7szDuOQPEAIQNQ",
         1003:"CgkI7szDuOQPEAIQNw",
         1004:"CgkI7szDuOQPEAIQOA",
         1005:"CgkI7szDuOQPEAIQOQ",
         1006:"CgkI7szDuOQPEAIQOg",
         1007:"CgkI7szDuOQPEAIQOw",
         1008:"CgkI7szDuOQPEAIQPA",
         1009:"CgkI7szDuOQPEAIQPQ",
         1010:"CgkI7szDuOQPEAIQPg",
         1011:"CgkI7szDuOQPEAIQPw",
         1012:"CgkI7szDuOQPEAIQQA",
         1013:"CgkI7szDuOQPEAIQQQ",
         1014:"CgkI7szDuOQPEAIQQg",
         1015:"CgkI7szDuOQPEAIQQw",
         1016:"CgkI7szDuOQPEAIQRA",
         1017:"CgkI7szDuOQPEAIQRQ",
         1018:"CgkI7szDuOQPEAIQRg",
         1019:"CgkI7szDuOQPEAIQRw",
         1020:"CgkI7szDuOQPEAIQSA",
         1021:"CgkI7szDuOQPEAIQSQ",
         1022:"CgkI7szDuOQPEAIQMw",
         1023:"CgkI7szDuOQPEAIQSg"
      };
      
      public function BMGoogleGamesManager()
      {
         super();
         if(BMGoogleGamesManager._instance)
         {
            throw new Error("BMGoogleGamesManager is a singleton, see BMGoogleGamesManager.getInstance()");
         }
         this.initialize();
      }
      
      public static function getInstance() : BMGoogleGamesManager
      {
         if(_instance == null)
         {
            _instance = new BMGoogleGamesManager();
         }
         return _instance;
      }
      
      public static function gi() : BMGoogleGamesManager
      {
         return getInstance();
      }
      
      public function get currentGamesID() : String
      {
         return this._currentGamesID;
      }
      
      public function set currentGamesID(param1:String) : void
      {
         this._currentGamesID = param1;
      }
      
      public function get currentToken() : String
      {
         return this._currentToken;
      }
      
      public function set currentGamesName(param1:String) : void
      {
         this._currentGamesName = param1;
      }
      
      public function get currentPlayerHiResImageUrl() : String
      {
         return this._currentPlayerHiResImageUrl;
      }
      
      public function set currentPlayerHiResImageUrl(param1:String) : void
      {
         this._currentPlayerHiResImageUrl = param1;
      }
      
      public function get currentPlayerIconImageUrl() : String
      {
         return this._currentPlayerIconImageUrl;
      }
      
      public function set currentPlayerIconImageUrl(param1:String) : void
      {
         this._currentPlayerIconImageUrl = param1;
      }
      
      private function initialize() : void
      {
         TsLogger.log("BMGoogleGamesManager :: initialize()");
         GoogleIdentity.service.addEventListener(GoogleIdentityEvent.SETUP_COMPLETE,this.setupCompleteHandler);
         GoogleIdentity.service.addEventListener(GoogleIdentityEvent.SIGN_IN,this.signInHandler);
         GoogleIdentity.service.addEventListener(GoogleIdentityEvent.SIGN_OUT,this.signOutHandler);
         GoogleIdentity.service.addEventListener(GoogleIdentityEvent.ERROR,this.errorHandler);
         GoogleIdentity.service.addEventListener(GoogleIdentityEvent.TOKEN_UPDATED,this.tokenUpdatedHandler);
         GoogleIdentity.service.addEventListener(GoogleIdentityEvent.TOKEN_FAILED,this.tokenFailedHandler);
         var _loc1_:GoogleIdentityOptionsBuilder = new GoogleIdentityOptionsBuilder(GoogleIdentityOptions.DEFAULT_GAMES_SIGN_IN);
         _loc1_.requestIdToken(false);
         _loc1_.requestEmail(false);
         _loc1_.requestProfile(false);
         _loc1_.requestServerAuthCode();
         _loc1_.setAndroidServerClientID("542358169198-20k5lcuoqkn63h67o3438l03j1t9hnvd.apps.googleusercontent.com");
         _loc1_.setClientID("542358169198-20k5lcuoqkn63h67o3438l03j1t9hnvd.apps.googleusercontent.com");
         _loc1_.setServerClientID("542358169198-20k5lcuoqkn63h67o3438l03j1t9hnvd.apps.googleusercontent.com");
         GoogleIdentity.service.setup(_loc1_.build());
      }
      
      public function SetSession(param1:BMSessionManager) : void
      {
         if(this._session != null)
         {
            this.removeSessionLoginEventListeners();
            this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalLogoutTrue);
            this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT,this.onExternalLogoutFault);
            this._session.removeEventListener(BMMSession.GOT_USER_SESSION,this.onGotUserData);
         }
         this._session = param1;
         this._session.addEventListener(BMMSession.GOT_USER_SESSION,this.onGotUserData);
      }
      
      private function onGotUserData(param1:Event) : void
      {
         if(this.isExternalLoggedIn() && !this.isLocalLoggedIn())
         {
            GoogleIdentity.service.signIn();
         }
      }
      
      private function addSessionLoginEventListeners() : void
      {
         this.removeSessionLoginEventListeners();
         this._session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE,this.onExternalLoginTrue);
         this._session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT,this.onExternalLoginFault);
         this._session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_CONFLICT,this.onExternalLoginConflict);
         this._session.addEventListener(ExternalSessionEvents.EXTERNAL_RELOGIN,this.onExternalReLogin);
      }
      
      private function removeSessionLoginEventListeners() : void
      {
         this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE,this.onExternalLoginTrue);
         this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT,this.onExternalLoginFault);
         this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGIN_CONFLICT,this.onExternalLoginConflict);
         this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_RELOGIN,this.onExternalReLogin);
      }
      
      public function isSupported() : Boolean
      {
         return GoogleIdentity.isSupported;
      }
      
      public function isFullyLoggedIn() : Boolean
      {
         return this.isExternalLoggedIn() && Boolean(this.isLocalLoggedIn());
      }
      
      public function isExternalLoggedIn() : Boolean
      {
         if(this._session == null)
         {
            return false;
         }
         return this._session.isExternalLoggedIn(LoginServices.GOOGLE_PLAY);
      }
      
      private function isLocalLoggedIn() : *
      {
         if(this.isSupported())
         {
            return GoogleIdentity.service.isSignedIn();
         }
         return false;
      }
      
      public function logIn() : void
      {
         TsLogger.log("BMGoogleGamesManager :: signIn()");
         if(!this.isSupported())
         {
            TsLogger.log("GoogleGames not supported");
            return;
         }
         if(this._alreadyCallingSignIn)
         {
            TsLogger.log("GoogleGames alreadyCallingSignIn");
            return;
         }
         this._alreadyCallingSignIn = true;
         if(!GoogleIdentity.service.isSignedIn())
         {
            this._isCallingSilentSignIn = false;
            GoogleIdentity.service.signIn();
         }
         else
         {
            this._isCallingSilentSignIn = true;
            GoogleIdentity.service.signInSilently();
         }
      }
      
      public function logOutLocal() : *
      {
         if(this.isLocalLoggedIn())
         {
            GoogleIdentity.service.signOut();
         }
      }
      
      public function logOut() : void
      {
         TsLogger.log("BMGoogleGamesManager :: logOut()");
         this.logOutLocal();
         if(this.isExternalLoggedIn())
         {
            this._session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalLogoutTrue);
            this._session.addEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT,this.onExternalLogoutFault);
            this._session.doExternalLogout(LoginServices.GOOGLE_PLAY);
         }
         else
         {
            this.LogOutFinish();
         }
      }
      
      private function onExternalLogoutTrue(param1:DataEvent) : void
      {
         this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalLogoutTrue);
         this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT,this.onExternalLogoutFault);
         this.LogOutFinish();
      }
      
      private function onExternalLogoutFault(param1:Event) : void
      {
         this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,this.onExternalLogoutTrue);
         this._session.removeEventListener(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT,this.onExternalLogoutFault);
      }
      
      public function externalLoginResolveConflict(param1:Number) : void
      {
         this._session.mergeAccounts(param1,LoginServices.GOOGLE_PLAY,this.currentGamesID,this._currentToken);
      }
      
      private function LogOutFinish() : *
      {
         TsLogger.log("BMGoogleGamesManager :: LogOutFinish()");
         this._currentToken = null;
         this._alreadyCallingSignIn = false;
         dispatchEvent(new Event(SIGNED_OUT));
      }
      
      private function onSignedOut(param1:* = null) : void
      {
         this.logOut();
      }
      
      private function onSignedIn(param1:*) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onSignedIn() ");
      }
      
      private function onExternalLoginTrue(param1:Event = null) : void
      {
         this.removeSessionLoginEventListeners();
         this._alreadyCallingSignIn = false;
         dispatchEvent(new Event(SIGN_IN_SUCCEEDED));
      }
      
      private function onExternalLoginFault(param1:Event) : void
      {
         this.removeSessionLoginEventListeners();
         this._alreadyCallingSignIn = false;
         this.signInFailed("Failed to log in to Game with Google Play");
      }
      
      private function signInFailed(param1:String = null) : void
      {
         this.logOut();
         dispatchEvent(new Event(SIGN_IN_FAILED));
         if(param1 != null)
         {
            BMScreensManager.getInstance().screenConfirmation.displayCustomMessage(param1);
         }
      }
      
      private function onExternalLoginConflict(param1:ExternalLoginConflictEvent) : void
      {
         this.removeSessionLoginEventListeners();
         dispatchEvent(param1);
      }
      
      private function onExternalReLogin(param1:Event) : void
      {
         this.removeSessionLoginEventListeners();
      }
      
      private function onSignedInError(param1:*) : void
      {
         this._alreadyCallingSignIn = false;
         TsLogger.log("BMGoogleGamesManager :: onSignedInError() - ");
         this.signInFailed();
         if(BMLoginManager.gi().isGuestOrSaveLoginAsFlow)
         {
            BMLoginManager.gi().reOpenLoginAs();
         }
      }
      
      public function showAchievements() : void
      {
         TsLogger.log("BMGoogleGamesManager :: showAchievements()");
         if(!this.isLocalLoggedIn())
         {
            return;
         }
      }
      
      public function unlockAchievement(param1:Number) : void
      {
         if(!this.isLocalLoggedIn())
         {
            return;
         }
         TsLogger.log("BMGoogleGamesManager :: unlockAchievement " + param1);
         var _loc2_:* = this.achivmentKeysConversion[param1];
         if(_loc2_ == undefined)
         {
            TsLogger.log("BMGoogleGamesManager :: cannot find gplay achievementId for " + param1);
            return;
         }
      }
      
      private function setupCompleteHandler(param1:GoogleIdentityEvent) : void
      {
         TsLogger.log("setupCompleteHandler");
      }
      
      private function signInHandler(param1:GoogleIdentityEvent) : void
      {
         TsLogger.log("signInHandler");
         if(this._isCallingSilentSignIn && (param1.user.serverAuthCode == null || param1.user.serverAuthCode.length == 0))
         {
            this._isCallingSilentSignIn = false;
            GoogleIdentity.service.signIn();
            return;
         }
         if(this._alreadyCallingSignIn)
         {
            GoogleIdentity.service.getToken("Sen7Oh2KwkMeKEqkljkrcqAh");
         }
      }
      
      private function signOutHandler(param1:GoogleIdentityEvent) : void
      {
         TsLogger.log("signOutHandler");
         this.logOut();
      }
      
      private function errorHandler(param1:GoogleIdentityEvent) : void
      {
         TsLogger.log("errorHandler");
         if(!this._alreadyCallingSignIn)
         {
            return;
         }
         this._alreadyCallingSignIn = false;
         var _loc2_:String = null;
         switch(param1.errorCode)
         {
            case 8:
               _loc2_ = "Internal error, please contact support";
               break;
            case 12501:
               this._session.clearLastLoginError();
               break;
            default:
               _loc2_ = param1.error;
         }
         this.signInFailed(_loc2_);
      }
      
      private function tokenUpdatedHandler(param1:GoogleIdentityEvent) : void
      {
         TsLogger.log("tokenUpdatedHandler");
         this._currentToken = param1.user.authentication.accessToken;
         if(!this._didInitGoogleGames)
         {
            this._didInitGoogleGames = true;
         }
         this._alreadyCallingSignIn = false;
         this.addSessionLoginEventListeners();
         this._session.doExternalLogin(LoginServices.GOOGLE_PLAY,param1.user.userID,this._currentToken);
      }
      
      private function tokenFailedHandler(param1:GoogleIdentityEvent) : void
      {
         TsLogger.log("tokenFailedHandler");
         if(!this._alreadyCallingSignIn)
         {
            return;
         }
         this.signInFailed(param1.error);
      }
   }
}

