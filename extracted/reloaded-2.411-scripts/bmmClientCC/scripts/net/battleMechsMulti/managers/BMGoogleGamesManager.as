package net.battleMechsMulti.managers
{
   import com.distriqt.extension.permissions.AuthorisationStatus;
   import com.distriqt.extension.permissions.Permissions;
   import com.distriqt.extension.permissions.events.AuthorisationEvent;
   import com.milkmangames.nativeextensions.*;
   import com.milkmangames.nativeextensions.events.GoogleGamesEvent;
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
      
      public var leaderboards:Vector.<GPGLeaderboard>;
      
      public var achievements:Vector.<GPGAchievement>;
      
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
         1048:"CgkI7szDuOQPEAIQMg"
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
         if(this.isSupported())
         {
            GoogleGames.create();
         }
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
            GoogleGames.games.signIn();
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
         return GoogleGames.isSupported();
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
            return GoogleGames.games.isSignedIn();
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
         if(!GoogleGames.games.isSignedIn())
         {
            this._alreadyCallingSignIn = true;
            GoogleGames.games.addEventListener(GoogleGamesEvent.SIGN_IN_SUCCEEDED,this.onSignedIn);
            GoogleGames.games.addEventListener(GoogleGamesEvent.SIGN_IN_FAILED,this.onSignedInError);
            GoogleGames.games.signIn();
         }
         else
         {
            this.onSignedIn();
         }
      }
      
      public function logOutLocal() : *
      {
         if(this.isLocalLoggedIn())
         {
            GoogleGames.games.signOut();
            GoogleGames.games.removeEventListener(GoogleGamesEvent.SIGNED_OUT,this.onSignedOut);
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
      
      private function onSignedOut(param1:GoogleGamesEvent = null) : void
      {
         this.logOut();
      }
      
      private function onSignedIn(param1:GoogleGamesEvent = null) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onSignedIn() ");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.SIGN_IN_SUCCEEDED,this.onSignedIn);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.SIGN_IN_FAILED,this.onSignedInError);
         GoogleGames.games.addEventListener(GoogleGamesEvent.SIGNED_OUT,this.onSignedOut);
         this.currentPlayerHiResImageUrl = GoogleGames.games.getCurrentPlayerHiResImageUrl();
         this.currentPlayerIconImageUrl = GoogleGames.games.getCurrentPlayerIconImageUrl();
         this.currentGamesID = GoogleGames.games.getCurrentPlayerId();
         this.currentGamesName = GoogleGames.games.getCurrentPlayerName();
         var _loc2_:String = Permissions.service.authorisationStatusForPermission(BMClient.PERMISSION_GET_ACCOUNTS);
         if(_loc2_ != AuthorisationStatus.AUTHORISED)
         {
            BMScreensManager.getInstance().screenConfirmation.displayCustomMessage("We require the accounts" + " permission in order to authorize you with our server",this.authorisePermission);
         }
         else
         {
            this.loadAuthToken();
         }
      }
      
      private function authorisePermission() : void
      {
         if(!Permissions.isSupported)
         {
            TsLogger.log("BMGoogleGamesManager :: ERROR!! Permissions NOT SUPPORTED ");
            return;
         }
         var _loc1_:String = Permissions.service.authorisationStatusForPermission(BMClient.PERMISSION_GET_ACCOUNTS);
         TsLogger.log("BMGoogleGamesManager :: authorisationStatus " + _loc1_);
         switch(_loc1_)
         {
            case AuthorisationStatus.AUTHORISED:
               this.loadAuthToken();
               break;
            case AuthorisationStatus.SHOULD_EXPLAIN:
            case AuthorisationStatus.NOT_DETERMINED:
               Permissions.service.addEventListener(AuthorisationEvent.CHANGED,this.authorisationChangedHandler);
               Permissions.service.requestAccessForPermission(BMClient.PERMISSION_GET_ACCOUNTS);
               break;
            case AuthorisationStatus.DENIED:
            case AuthorisationStatus.UNKNOWN:
            case AuthorisationStatus.RESTRICTED:
               this.signInFailed();
         }
      }
      
      private function loadAuthToken() : *
      {
         GoogleGames.games.addEventListener(GoogleGamesEvent.LOAD_AUTH_TOKEN_SUCCEEDED,this.onLoadAuthTokenSucceeded);
         GoogleGames.games.addEventListener(GoogleGamesEvent.LOAD_AUTH_TOKEN_FAILED,this.onLoadAuthTokenFailed);
         GoogleGames.games.loadAuthToken();
      }
      
      private function authorisationChangedHandler(param1:AuthorisationEvent) : void
      {
         Permissions.service.removeEventListener(AuthorisationEvent.CHANGED,this.authorisationChangedHandler);
         if(param1.status == AuthorisationStatus.AUTHORISED)
         {
            this.loadAuthToken();
         }
         else if(param1.status == AuthorisationStatus.SHOULD_EXPLAIN)
         {
            this.signInFailed("Google Play log in requires the contacts permission");
         }
         else if(param1.status == AuthorisationStatus.DENIED)
         {
            this.signInFailed("Google play log in requires contact permissions. Go to Settings -> Apps -> Supermechs -> Permissions -> Contacts");
         }
      }
      
      private function onLoadAuthTokenSucceeded(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onLoadAuthTokenSucceeded() token:" + param1.token);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_AUTH_TOKEN_SUCCEEDED,this.onLoadAuthTokenSucceeded);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_AUTH_TOKEN_FAILED,this.onLoadAuthTokenFailed);
         this._currentToken = param1.token;
         this.addSessionLoginEventListeners();
         this._session.doExternalLogin(LoginServices.GOOGLE_PLAY,this.currentGamesID,this._currentToken);
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
      
      private function onLoadAuthTokenFailed(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onLoadAuthTokenFailed() failureReason:" + param1.failureReason);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_AUTH_TOKEN_SUCCEEDED,this.onLoadAuthTokenSucceeded);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_AUTH_TOKEN_FAILED,this.onLoadAuthTokenFailed);
         this.signInFailed("Failed to retrive token from Google Play");
      }
      
      private function onSignedInError(param1:GoogleGamesEvent) : void
      {
         this._alreadyCallingSignIn = false;
         TsLogger.log("BMGoogleGamesManager :: onSignedInError() - " + param1.failureReason);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.SIGN_IN_SUCCEEDED,this.onSignedIn);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.SIGN_IN_FAILED,this.onSignedInError);
         this.signInFailed();
      }
      
      private function onAchievementsLoadedError(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onAchievementsLoadedError() - " + param1.failureReason);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_ACHIEVEMENTS_SUCCEEDED,this.onAchievementsLoaded);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_ACHIEVEMENTS_FAILED,this.onAchievementsLoadedError);
      }
      
      private function onLeaderboardsLoaded(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onLeaderboardsLoaded()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_LEADERBOARD_METADATA_SUCCEEDED,this.onLeaderboardsLoaded);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_LEADERBOARD_METADATA_FAILED,this.onLeaderboardsLoadedError);
         this.leaderboards = param1.leaderboards;
      }
      
      private function onLeaderboardsLoadedError(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onLeaderboardsLoadedError()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_LEADERBOARD_METADATA_SUCCEEDED,this.onLeaderboardsLoaded);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_LEADERBOARD_METADATA_FAILED,this.onLeaderboardsLoadedError);
      }
      
      private function onScoresLoaded(param1:GoogleGamesEvent) : void
      {
         var _loc3_:GPGScore = null;
         TsLogger.log("BMGoogleGamesManager :: onScoresLoaded()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_SCORES_SUCCEEDED,this.onScoresLoaded);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_SCORES_FAILED,this.onScoresLoadedError);
         var _loc2_:Vector.<GPGScore> = param1.scores;
         for each(_loc3_ in _loc2_)
         {
            TsLogger.log("Score: " + _loc3_.displayScore + " (" + _loc3_.score + ")");
            TsLogger.log("Rank: " + _loc3_.displayRank + "(" + _loc3_.rank + ")");
            TsLogger.log("Player: " + _loc3_.playerName + " (id=" + _loc3_.playerId + ")");
            TsLogger.log("Time: " + _loc3_.timestamp);
         }
      }
      
      private function onScoresLoadedError(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onScoresLoadedError()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_SCORES_SUCCEEDED,this.onScoresLoaded);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_SCORES_FAILED,this.onScoresLoadedError);
      }
      
      public function showAllLeaderboards() : void
      {
         TsLogger.log("BMGoogleGamesManager :: showAllLeaderboards()");
         if(!this.isLocalLoggedIn())
         {
            return;
         }
         GoogleGames.games.addEventListener(GoogleGamesEvent.LEADERBOARD_VIEW_DISMISSED,this.onLeaderboardViewDismissed);
         GoogleGames.games.showLeaderboard();
      }
      
      public function showAchievements() : void
      {
         TsLogger.log("BMGoogleGamesManager :: showAllLeaderboards()");
         if(!this.isLocalLoggedIn())
         {
            return;
         }
         GoogleGames.games.addEventListener(GoogleGamesEvent.ACHIEVEMENTS_VIEW_DISMISSED,this.onAchievementsViewDismissed);
         GoogleGames.games.showAchievements();
      }
      
      public function loadAchievements() : void
      {
         TsLogger.log("BMGoogleGamesManager :: loadAchievements()");
         if(!this.isLocalLoggedIn())
         {
            return;
         }
         GoogleGames.games.addEventListener(GoogleGamesEvent.LOAD_ACHIEVEMENTS_SUCCEEDED,this.onAchievementsLoaded);
         GoogleGames.games.addEventListener(GoogleGamesEvent.LOAD_ACHIEVEMENTS_FAILED,this.onAchievementsLoadedError);
         GoogleGames.games.loadAchievements();
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
         GoogleGames.games.unlockAchievement(_loc2_);
      }
      
      public function loadLeaderboards() : void
      {
         TsLogger.log("BMGoogleGamesManager :: loadLeaderboards()");
         if(!this.isLocalLoggedIn())
         {
            return;
         }
         GoogleGames.games.addEventListener(GoogleGamesEvent.LOAD_LEADERBOARD_METADATA_SUCCEEDED,this.onLeaderboardsLoaded);
         GoogleGames.games.addEventListener(GoogleGamesEvent.LOAD_LEADERBOARD_METADATA_FAILED,this.onLeaderboardsLoadedError);
         GoogleGames.games.loadLeaderboardMetadata();
      }
      
      public function loadScores() : void
      {
         TsLogger.log("BMGoogleGamesManager :: loadScores()");
         if(!this.isLocalLoggedIn())
         {
            return;
         }
      }
      
      private function onScoreSubmitted(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onScoreSubmitted()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.SUBMIT_SCORE_SUCCEEDED,this.onScoreSubmitted);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.SUBMIT_SCORE_FAILED,this.onScoreSubmittedError);
      }
      
      private function onScoreSubmittedError(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onScoreSubmittedError()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.SUBMIT_SCORE_SUCCEEDED,this.onScoreSubmitted);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.SUBMIT_SCORE_FAILED,this.onScoreSubmittedError);
      }
      
      private function onAchievementUnlocked(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onAchievementUnlocked()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.UNLOCK_ACHIEVEMENT_SUCCEEDED,this.onAchievementUnlocked);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.UNLOCK_ACHIEVEMENT_FAILED,this.onAchievementUnlockedError);
      }
      
      private function onAchievementUnlockedError(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onAchievementUnlockedError()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.UNLOCK_ACHIEVEMENT_SUCCEEDED,this.onAchievementUnlocked);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.UNLOCK_ACHIEVEMENT_FAILED,this.onAchievementUnlockedError);
      }
      
      private function onAchievementsViewDismissed(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onAchievementsViewDismissed()");
         GoogleGames.games.addEventListener(GoogleGamesEvent.ACHIEVEMENTS_VIEW_DISMISSED,this.onAchievementsViewDismissed);
         this.loadLeaderboards();
      }
      
      private function onLeaderboardViewDismissed(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onLeaderboardViewDismissed()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LEADERBOARD_VIEW_DISMISSED,this.onLeaderboardViewDismissed);
      }
      
      private function onAchievementIncremented(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onAchievementIncremented()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.INCREMENT_ACHIEVEMENT_SUCCEEDED,this.onAchievementIncremented);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.INCREMENT_ACHIEVEMENT_FAILED,this.onAchievementIncrementedError);
      }
      
      private function onAchievementIncrementedError(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onAchievementIncrementedError()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.INCREMENT_ACHIEVEMENT_SUCCEEDED,this.onAchievementIncremented);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.INCREMENT_ACHIEVEMENT_FAILED,this.onAchievementIncrementedError);
      }
      
      private function onAchievementRevaled(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onAchievementRevaled()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.REVEAL_ACHIEVEMENT_SUCCEEDED,this.onAchievementRevaled);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.REVEAL_ACHIEVEMENT_FAILED,this.onAchievementRevaledError);
      }
      
      private function onAchievementRevaledError(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onAchievementRevaledError()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.REVEAL_ACHIEVEMENT_SUCCEEDED,this.onAchievementRevaled);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.REVEAL_ACHIEVEMENT_FAILED,this.onAchievementRevaledError);
      }
      
      private function onAchievementsLoaded(param1:GoogleGamesEvent) : void
      {
         TsLogger.log("BMGoogleGamesManager :: onAchievementsLoaded()");
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_ACHIEVEMENTS_SUCCEEDED,this.onAchievementsLoaded);
         GoogleGames.games.removeEventListener(GoogleGamesEvent.LOAD_ACHIEVEMENTS_FAILED,this.onAchievementsLoadedError);
         this.achievements = param1.achievements;
      }
   }
}

