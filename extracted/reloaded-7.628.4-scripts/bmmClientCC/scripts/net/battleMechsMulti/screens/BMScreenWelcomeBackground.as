package net.battleMechsMulti.screens
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import net.battleMechsMulti.helpers.BMAffiliatesHelper;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.BMGuestABTestManager;
   import net.battleMechsMulti.managers.BMLoadingTimer;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.navigatePlayerToRecommendedMission.BMNavigatePlayerToRecommendedMissionResolver;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.buttons.BMLanguageButton;
   import net.battleMechsMulti.session.BMDomainResolver;
   import net.battleMechsMulti.session.LoginServices;
   import net.battleMechsMulti.utils.TextUtils;
   import net.tacticsoft.global.BMMClientFlashConsts;
   import net.tacticsoft.global.BMMClientFlashVars;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol342")]
   public class BMScreenWelcomeBackground extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackgroundHolder:Sprite;
      
      public var mcMechHolder:MovieClip;
      
      public var txtVersion:TextField;
      
      public var txtConnectingToServer:TextField;
      
      public var txtWelcomeBack:TextField;
      
      public var mcLoadingBackground:MovieClip;
      
      public var mcSandClock:MovieClip;
      
      public var mcAvailableOnTheAppStore:MovieClip;
      
      public var mcAvailableOnGooglePlay:MovieClip;
      
      public var btnLanguages:BMLanguageButton;
      
      private var newURLLoader:URLLoader;
      
      private var _debuggerCode:String = "";
      
      private var _welcomeBackCountdown:Number = 0;
      
      public var mcWatchReplay:MovieClip;
      
      public var mcWatchReplayPosition:Sprite;
      
      private var _watchReplayReplayID:Number = -1;
      
      private var _firstRefreshWatchReplays:Boolean = true;
      
      private var _watchReplaysVisible:Boolean = false;
      
      private var _replaysWatched:Number = 0;
      
      private var _firstRefresh:Boolean = true;
      
      private var _firstLoading:Boolean = true;
      
      private const WELCOME_BACK_FRAMES:Number = 45;
      
      public var mcClientVersionHitArea:Sprite;
      
      private var _waitingForGeneralLibraryExtension:Boolean = false;
      
      private var _isWaitingForGeneralLibraryExtensionFirstTrigger:Boolean = true;
      
      private var _generalLibraryExtensionLastProgress:Number = -1;
      
      private const LOCATION_MAIN_MENU:String = "mainMenu";
      
      private const LOCATION_WORKSHOP:String = "workshop";
      
      private const LOCATION_OPENING_SEQUENCE:String = "openingSequence";
      
      private const LOCATION_BASE_MAP:String = "baseMap";
      
      private const LOCATION_DAILY_LOGIN_STREAK:String = "dailyLoginStreak";
      
      private const LOCATION_VIP_SUBSCRIPTION:String = "vipSubscription";
      
      private const LOCATION_FREE_PACKAGES:String = "freePackages";
      
      private const LOCATION_STARTER_PACK:String = "starterPack";
      
      private const LOCATION_NEWS:String = "news";
      
      public function BMScreenWelcomeBackground()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("welcome");
         var _loc1_:Function = this.languagesClicked;
         if(dataM.runAsMobile)
         {
            _loc1_ = null;
         }
         this.btnLanguages.addEventListener(BMIntractable.HIT,this.languagesClicked);
         this.updateLanguageFlagIcon();
         this.languageUpdate();
         this.txtWelcomeBack.text = "";
         this.mcLoadingBackground.visible = false;
         this.createLoggingInTextBitmapForMobile();
         this.txtConnectingToServer.visible = false;
         this.createLoggingInTextBitmapForMobile();
         dataM.sessionManager.createSession();
         if(!dataM.logOutClicked)
         {
            loginM.startLoginFlow();
         }
         if(dataM.useLanguages == false)
         {
            this.btnLanguages.visible = false;
         }
         if(dataM.welcomeScreenInitialized == false)
         {
            dataM.welcomeScreenInitialized = true;
         }
         this.loadGeneralLibraryExtension();
         this.mcClientVersionHitArea.addEventListener(MouseEvent.CLICK,this.onVersionTextClick);
      }
      
      public function showInitialLoginScreen(param1:String = null, param2:Boolean = false) : *
      {
         if(dataM.installationData.lastLoginService != LoginServices.SUPERMECHS && dataM.getSharedObjectLastLoginUsername() == "" && false == false)
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_LOGIN))
            {
               screensM.screenWelcomeLogin.backClicked();
            }
            else
            {
               screensM.addScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
               screensM.screenWelcomeNewExisting.refreshScreen();
            }
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_WELCOME_LOGIN);
            if(param2)
            {
               screensM.screenWelcomeLogin.removeSavedPassword();
            }
            screensM.screenWelcomeLogin.loginFailed(param1);
         }
      }
      
      public function refreshScreen(param1:Boolean) : void
      {
         if(this._firstRefresh)
         {
            if(dataM.runAsMobile)
            {
               this.mcAvailableOnTheAppStore.parent.removeChild(this.mcAvailableOnTheAppStore);
               this.mcAvailableOnTheAppStore = null;
               this.mcAvailableOnGooglePlay.parent.removeChild(this.mcAvailableOnGooglePlay);
               this.mcAvailableOnGooglePlay = null;
            }
            else
            {
               if(BMAffiliatesHelper.doesAffiliateAllowMobileVersionAds())
               {
                  this.mcAvailableOnTheAppStore.addEventListener(MouseEvent.CLICK,this.availableOnTheAppStoreClicked);
                  this.mcAvailableOnTheAppStore.addEventListener(MouseEvent.MOUSE_UP,this.availableOnTheAppStoreMouseOut);
                  this.mcAvailableOnTheAppStore.addEventListener(MouseEvent.MOUSE_OVER,this.availableOnTheAppStoreMouseOver);
                  this.mcAvailableOnTheAppStore.addEventListener(MouseEvent.MOUSE_OUT,this.availableOnTheAppStoreMouseOut);
                  this.mcAvailableOnTheAppStore.buttonMode = true;
                  this.mcAvailableOnTheAppStore.useHandCursor = true;
                  this.mcAvailableOnGooglePlay.addEventListener(MouseEvent.CLICK,this.availableOnGooglePlayClicked);
                  this.mcAvailableOnGooglePlay.addEventListener(MouseEvent.MOUSE_UP,this.availableOnGooglePlayMouseOut);
                  this.mcAvailableOnGooglePlay.addEventListener(MouseEvent.MOUSE_OVER,this.availableOnGooglePlayMouseOver);
                  this.mcAvailableOnGooglePlay.addEventListener(MouseEvent.MOUSE_OUT,this.availableOnGooglePlayMouseOut);
                  this.mcAvailableOnGooglePlay.buttonMode = true;
                  this.mcAvailableOnGooglePlay.useHandCursor = true;
               }
               this.mcAvailableOnTheAppStore.mcMouseOverEffect.visible = false;
               this.mcAvailableOnGooglePlay.mcMouseOverEffect.visible = false;
            }
            this._firstRefresh = false;
         }
         this.refreshVersionText();
         this.languageUpdate();
         screensM.topBottomBordersForMobile_hideTitle();
         if(dataM.logOutClicked)
         {
            dataM.logOutClicked = false;
            this.showInitialLoginScreen(null,true);
         }
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtConnectingToServer,17);
            TextUtils.updateTextFormat(this.txtWelcomeBack,17);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(screensM.screenBlack.isActive() == false)
            {
               this.welcomeBackHandler();
            }
         }
      }
      
      public function languagesClicked(param1:Event) : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_LANGUAGE_SELECTION))
         {
            screensM.removeScreen(BMScreensManager.SCR_LANGUAGE_SELECTION);
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_LANGUAGE_SELECTION);
            screensM.screenLanguageSelection.x = this.btnLanguages.x - 92;
            screensM.screenLanguageSelection.y = this.btnLanguages.y + this.btnLanguages.height + 3;
            screensM.screenLanguageSelection.refreshScreen(this.newLanguageSelected);
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
         {
            screensM.screenWelcomeNewExisting.removeSwitchToSpecificLanguagePanel();
         }
      }
      
      private function updateLanguageFlagIcon() : void
      {
         var _loc1_:String = languageM.getFlagIconNameByLanguageID(dataM.languageID);
         var _loc2_:Sprite = dataM.getLocalGraphicIcon(_loc1_);
         this.btnLanguages.addFlagImage(_loc2_);
      }
      
      public function newLanguageSelected() : void
      {
         if(lastLanguageID == dataM.languageID)
         {
            return;
         }
         this.updateLanguageFlagIcon();
         this.languageUpdate();
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_LOGIN))
         {
            screensM.screenWelcomeLogin.languageUpdate(true);
            return;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
         {
            screensM.screenWelcomeNewExisting.languageUpdate(true);
         }
      }
      
      private function createLoggingInTextBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("welcomeBackground_loggingIn",[this.txtConnectingToServer,this.txtWelcomeBack],"",this);
         }
      }
      
      public function resetWelcomeBack() : void
      {
         this.txtWelcomeBack.htmlText = "";
         this.createLoggingInTextBitmapForMobile();
      }
      
      public function showWelcomeBack() : void
      {
         var _loc2_:String = null;
         BMLoadingTimer.gi().hideLoading();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         if(_loc1_.level <= 1)
         {
            _loc2_ = getScreenText("welcome");
         }
         else
         {
            _loc2_ = getScreenText("welcomeBack");
         }
         screensM.screenConfirmation.displayCustomLockedMessage("<br><br><br>" + TextUtils.getTextFont(17) + _loc2_ + "<BR>" + _loc1_.playerName);
         this._welcomeBackCountdown = this.WELCOME_BACK_FRAMES;
      }
      
      private function welcomeBackHandler() : void
      {
         if(this._welcomeBackCountdown > 0)
         {
            --this._welcomeBackCountdown;
            if(this._welcomeBackCountdown == 0)
            {
               this.welcomeBackHandlerSub();
            }
         }
      }
      
      public function welcomeBackHandlerSub() : void
      {
         if(externalAssetsM.shouldLoadExternalLibrary && tutorialM.isTutorialActive() == false)
         {
            screensM.addScreen(BMScreensManager.SCR_LOAD_EXTERNAL_LIBRARY);
            screensM.screenLoadExternalLibrary.setCallback(this.moveToNextScreen);
         }
         else
         {
            this.moveToNextScreen();
         }
      }
      
      private function moveToNextScreen() : void
      {
         var _loc3_:Boolean = false;
         if(externalAssetsM.generalLibraryExtensionLoaded == false)
         {
            this._waitingForGeneralLibraryExtension = true;
            return;
         }
         var _loc1_:String = this.getPlayerStartingLocation(dataM.ONLINE_PLAYER_ID);
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         var _loc2_:Boolean = false;
         if(BMNavigatePlayerToRecommendedMissionResolver.targetMissionSlot > -1)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc3_ = true;
            switch(_loc1_)
            {
               case this.LOCATION_MAIN_MENU:
               case this.LOCATION_DAILY_LOGIN_STREAK:
               case this.LOCATION_NEWS:
               case this.LOCATION_STARTER_PACK:
                  break;
               case this.LOCATION_FREE_PACKAGES:
                  _loc3_ = false;
                  dataM.popupFreePackages();
                  break;
               case this.LOCATION_VIP_SUBSCRIPTION:
                  dataM.vipAccountData.resetReward();
                  break;
               case this.LOCATION_OPENING_SEQUENCE:
               case this.LOCATION_WORKSHOP:
                  _loc3_ = false;
                  break;
               case this.LOCATION_BASE_MAP:
                  remoteM.socketM.mission_getData();
                  screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
                  _loc3_ = false;
                  break;
               default:
                  throw Error("BMScreenWelcomeBackground moveToNextScreen unhandled case for BMNavigatePlayerToRecommendedMissionResolver");
            }
            if(_loc3_)
            {
               screensM.screenBlack.activateBlackScreen(this.proceedToWorldMapRecomendedMission,true,true,null,0);
            }
            return;
         }
         switch(_loc1_)
         {
            case this.LOCATION_MAIN_MENU:
               screensM.screenBlack.activateBlackScreen(this.proceedToMainMenu,true,true,null,0);
               break;
            case this.LOCATION_DAILY_LOGIN_STREAK:
               screensM.addScreen(BMScreensManager.SCR_DAILY_LOGIN_STREAK_BONUS);
               screensM.screenDailyLoginStreakBonus.refreshScreen();
               break;
            case this.LOCATION_VIP_SUBSCRIPTION:
               screensM.addScreen(BMScreensManager.SCR_VIP_SUBSCRIPTION_STATUS);
               screensM.screenVIPSubscriptionStatus.showClaim(this.moveToNextScreen);
               dataM.vipAccountData.resetReward();
               break;
            case this.LOCATION_BASE_MAP:
               remoteM.socketM.mission_getData();
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               break;
            case this.LOCATION_FREE_PACKAGES:
               dataM.popupFreePackages();
               break;
            case this.LOCATION_STARTER_PACK:
               screensM.screenBlack.activateBlackScreen(this.proceedToStarterPack,true,true,null,0);
               break;
            default:
               screensM.screenBlack.activateBlackScreen(this.proceedToOnlineTutorial,true,true,null,0);
         }
      }
      
      private function proceedToOnlineTutorial() : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc1_:String = this.getPlayerStartingLocation(dataM.ONLINE_PLAYER_ID);
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         if(_loc1_ == this.LOCATION_OPENING_SEQUENCE)
         {
            screensM.addScreen(BMScreensManager.SCR_CAMPAIGN_OPENING_SEQUENCE);
            screensM.screenCampaignOpeningSequence.startAnimation(this.proceedToOnlineTutorial);
            _loc2_.watchedOpeningSequenceThisSession = true;
         }
         else
         {
            switch(_loc1_)
            {
               case this.LOCATION_WORKSHOP:
                  screensM.screenTransitionsManager.hangerMechClicked(true);
                  if(_loc2_.tutorialLevel <= 1)
                  {
                     screensM.addScreen(BMScreensManager.SCR_ITEM_CARDS);
                     _loc3_ = [BMCampaignMechsHelper.getTutorial_hanger1_torso(),BMCampaignMechsHelper.getTutorial_hanger1_leg(),BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon()];
                     _loc4_ = [0,1,2];
                     screensM.screenItemCards.refreshScreen(_loc3_,_loc4_,BMShopManager.CUSTOM_ITEMS_BOX_ID,true);
                  }
                  break;
               case this.LOCATION_NEWS:
                  screensM.screenTransitionsManager.communityNewsClicked(true);
            }
            remoteM.enterSinglePlayerLobby();
            this.removeMe();
            if(dataM.clientRunningLocally || dataM.specialUser || dataM.userID == 11208154)
            {
               screensM.btnDebugger.visible = true;
            }
         }
      }
      
      private function proceedToStarterPack() : void
      {
         dataM.starterPack_goBackToScreen = "mainMenu";
         screensM.screenTransitionsManager.openBuyStarterPackSub("Welcome");
         this.removeMe();
      }
      
      private function proceedToMainMenu() : *
      {
         this.removeMe();
         screensM.screenTransitionsManager.mainMenu(true);
      }
      
      private function proceedToWorldMapRecomendedMission() : void
      {
         this.removeMe();
         var _loc1_:uint = BMNavigatePlayerToRecommendedMissionResolver.targetMissionStoryID;
         var _loc2_:uint = BMNavigatePlayerToRecommendedMissionResolver.targetMissionMode;
         var _loc3_:uint = uint(BMNavigatePlayerToRecommendedMissionResolver.targetMissionSlot);
         var _loc4_:Boolean = true;
         var _loc5_:Boolean = true;
         var _loc6_:Boolean = false;
         screensM.screenTransitionsManager.singlePlayerClicked(_loc4_,_loc1_,_loc3_,_loc2_,_loc6_,_loc5_);
      }
      
      private function loadGeneralLibraryExtension() : void
      {
         TweenMax.delayedCall(0.5,this.loadGeneralLibraryExtensionSub);
      }
      
      private function loadGeneralLibraryExtensionSub() : void
      {
         if(externalAssetsM.generalLibraryExtensionLoaded || externalAssetsM.generalLibraryExtensionLoading)
         {
            return;
         }
         externalAssetsM.loadGeneralLibraryExtension();
      }
      
      public function onGeneralExtensionLoadingOnEnterFrame(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = Math.ceil(param1 / param2 * 100);
         _loc3_ = Math.max(0,_loc3_);
         _loc3_ = Math.min(100,_loc3_);
         if(this._waitingForGeneralLibraryExtension)
         {
            if(this._isWaitingForGeneralLibraryExtensionFirstTrigger)
            {
               screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
               this._isWaitingForGeneralLibraryExtensionFirstTrigger = false;
            }
            if(this._generalLibraryExtensionLastProgress != _loc3_)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("loadingGeneralLibraryExtension",_loc3_);
            }
         }
         this._generalLibraryExtensionLastProgress = _loc3_;
      }
      
      public function onGeneralExtensionLoadingComplete() : void
      {
         TsLogger.log("General library extension loading complete");
         if(this._waitingForGeneralLibraryExtension)
         {
            this._waitingForGeneralLibraryExtension = false;
            this.moveToNextScreen();
         }
      }
      
      public function playingAsGuest() : void
      {
         var _loc1_:String = null;
         BMGuestABTestManager.fetchData();
         if(dataM.guestSharedObjectExists)
         {
            dataM.initializeLocalMode();
            _loc1_ = this.getPlayerStartingLocation(dataM.LOCAL_PLAYER_ID);
            this.proceedToGuestMode();
            BMNotificationsManager.getInstance();
         }
         else
         {
            dataM.initializeLocalMode();
            if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
            {
               screensM.screenWelcomeNewExisting.btnNewPlayer.disableMe();
            }
            this.proceedToGuestMode();
         }
      }
      
      public function proceedToGuestMode() : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         dataM.achievementsSortedDB = new Array();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.LOCAL_PLAYER_ID + "Profile"];
         var _loc2_:String = this.getPlayerStartingLocation(dataM.LOCAL_PLAYER_ID);
         if(_loc2_ == this.LOCATION_OPENING_SEQUENCE)
         {
            dataM.trackEvent(3,"Tutorial","Begin");
            screensM.addScreen(BMScreensManager.SCR_CAMPAIGN_OPENING_SEQUENCE);
            screensM.screenCampaignOpeningSequence.startAnimation(this.proceedToGuestMode);
            _loc1_.watchedOpeningSequenceThisSession = true;
         }
         else
         {
            switch(_loc2_)
            {
               case this.LOCATION_WORKSHOP:
                  screensM.screenTransitionsManager.hangerMechClicked(true);
                  _loc3_ = dataM.playersData[dataM.LOCAL_PLAYER_ID];
                  if(_loc1_.winsVSComputer == 0 && _loc3_.mechStructures[_loc3_.selectedMechID].torso == 0)
                  {
                     screensM.addScreen(BMScreensManager.SCR_ITEM_CARDS);
                     _loc4_ = [BMCampaignMechsHelper.getTutorial_hanger1_torso(),BMCampaignMechsHelper.getTutorial_hanger1_leg(),BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon()];
                     _loc5_ = [0,1,2];
                     screensM.screenItemCards.refreshScreen(_loc4_,_loc5_,BMShopManager.CUSTOM_ITEMS_BOX_ID,true);
                  }
                  break;
               case this.LOCATION_MAIN_MENU:
                  this.proceedToMainMenu();
                  break;
               case this.LOCATION_BASE_MAP:
                  screensM.addScreen(BMScreensManager.SCR_MISSION_BASE_MAP);
                  screensM.screenMissionBaseMap.refreshScreen(false);
                  if(dataM.useHiddenBaseMap)
                  {
                     dataM.battleMechsPerPlayer = dataM.getCurrentMissionMechsPerPlayer();
                     screensM.addBattleScreens();
                  }
                  else
                  {
                     screensM.addScreen(BMScreensManager.SCR_TOP_BAR);
                     screensM.screenTopBar.refreshScreen(true);
                  }
            }
            if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
            {
               screensM.screenWelcomeNewExisting.btnNewPlayer.enableMe();
            }
         }
         this.removeMe();
      }
      
      public function gotOnlineMissionData() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(dataM.useHiddenBaseMap)
         {
            screensM.screenBlack.activateBlackScreen(null,true,true,null,0,true,this.proceedToOnlineMissionBaseMap);
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.proceedToOnlineMissionBaseMap,true,true,null,0);
         }
      }
      
      public function getOnlineMissionDataFailed() : void
      {
      }
      
      public function newOnlineMissionCreated() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(dataM.useHiddenBaseMap)
         {
            screensM.screenBlack.activateBlackScreen(null,true,true,null,0,true,this.proceedToOnlineMissionBaseMap);
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.proceedToOnlineMissionBaseMap,true,true,null,0);
         }
      }
      
      private function proceedToOnlineMissionBaseMap() : void
      {
         screensM.addScreen(BMScreensManager.SCR_MISSION_BASE_MAP);
         screensM.screenMissionBaseMap.refreshScreen(false);
         if(dataM.useHiddenBaseMap)
         {
            dataM.battleMechsPerPlayer = dataM.getCurrentMissionMechsPerPlayer();
            screensM.addBattleScreens();
            if(screensM.screenMissionBaseMap.doesPlayerNeedToRevive())
            {
               screensM.screenBlack.unBlockOpeningScreen();
            }
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_TOP_BAR);
            screensM.screenTopBar.refreshScreen(false);
         }
         this.removeMe();
      }
      
      private function getPlayerStartingLocation(param1:Number) : String
      {
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc2_:BMPlayerProfile = dataM["player" + param1 + "Profile"];
         var _loc3_:String = this.LOCATION_MAIN_MENU;
         if(_loc2_.tutorialLevel == 0)
         {
            if(_loc2_.watchedOpeningSequenceThisSession || BMGameShortcutsHelper.openingSequenceShortcut())
            {
               _loc3_ = this.LOCATION_WORKSHOP;
            }
            else
            {
               _loc3_ = this.LOCATION_OPENING_SEQUENCE;
            }
            return _loc3_;
         }
         if(tutorialM.isTutorialActive())
         {
            if(_loc2_.missionID > 0)
            {
               _loc3_ = this.LOCATION_BASE_MAP;
            }
            else
            {
               switch(tutorialM.getTutorialDestination())
               {
                  case BMTutorialManager.TUTORIAL_DESTINATION_MECH:
                  case BMTutorialManager.TUTORIAL_DESTINATION_FUSION:
                  case BMTutorialManager.TUTORIAL_DESTINATION_MISSION:
                  case BMTutorialManager.TUTORIAL_DESTINATION_SHOP:
                     _loc3_ = this.LOCATION_MAIN_MENU;
                     break;
                  case BMTutorialManager.TUTORIAL_DESTINATION_LONE_BATTLE:
                     _loc3_ = this.LOCATION_WORKSHOP;
               }
            }
            return _loc3_;
         }
         if(loginM.isConnected)
         {
            _loc4_ = false;
            if(dataM.dailyLoginStreakBonus != null)
            {
               if(dataM.dailyLoginStreakBonus.reward != null)
               {
                  _loc4_ = true;
               }
            }
            _loc5_ = false;
            if(dataM.vipAccountData.vipReward != null)
            {
               _loc5_ = true;
            }
            if(_loc4_)
            {
               _loc3_ = this.LOCATION_DAILY_LOGIN_STREAK;
            }
            else if(_loc5_)
            {
               _loc3_ = this.LOCATION_VIP_SUBSCRIPTION;
            }
            else if(dataM.gotPopupFreePackages)
            {
               _loc3_ = this.LOCATION_FREE_PACKAGES;
            }
            else if(_loc2_.missionID > 0)
            {
               _loc3_ = this.LOCATION_BASE_MAP;
            }
            else if(dataM.isStarterPackActive())
            {
               _loc3_ = this.LOCATION_STARTER_PACK;
            }
            else
            {
               _loc6_ = false;
               if(dataM.newsHandler.hasNewNews())
               {
                  _loc3_ = this.LOCATION_NEWS;
               }
               else
               {
                  dataM.newsHandler.newsDisplayed();
               }
               if(dataM.useRateBox)
               {
                  _loc7_ = dataM.getLadderRankByProgress(_loc2_.ladderProgress);
                  if(_loc7_ >= 1 && _loc7_ <= dataM.rateBoxRankRequired)
                  {
                     if(_loc2_.rateStatus == "" || _loc2_.rateStatus == "D" && dataM.userDeclinedRatingForThisSession == false)
                     {
                        _loc6_ = true;
                     }
                  }
               }
               if(_loc6_)
               {
                  dataM.rateBox_initializeAndDisplay();
               }
            }
         }
         return _loc3_;
      }
      
      public function removeMe() : void
      {
         BMLoadingTimer.gi().deactivateRefreshClientTimer();
         if(screensM.isScreenOpened(BMScreensManager.SCR_LANGUAGE_SELECTION))
         {
            screensM.removeScreen(BMScreensManager.SCR_LANGUAGE_SELECTION);
         }
         screensM.removeScreen(BMScreensManager.SCR_WELCOME_BACKGROUND);
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_LOGIN_AS))
         {
            screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN_AS);
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
         {
            screensM.removeScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_LOGIN_AS))
         {
            screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN_AS);
         }
         screensM.topBottomBordersForMobile_displayTitle();
      }
      
      private function debuggerCode1Clicked(param1:MouseEvent) : void
      {
         this._debuggerCode += "s";
         var _loc2_:String = this._debuggerCode.substr(this._debuggerCode.length - 4,4);
         if(_loc2_ == "smms")
         {
            screensM.btnDebugger.visible = true;
         }
      }
      
      private function debuggerCode2Clicked(param1:MouseEvent) : void
      {
         this._debuggerCode += "m";
      }
      
      private function availableOnTheAppStoreClicked(param1:MouseEvent) : void
      {
         var _loc2_:String = "flash_0";
         var _loc3_:BMMClientFlashVars = new BMMClientFlashVars(screensM.clientPointer.stage);
         if(_loc3_ != null)
         {
            if(_loc3_.mcamp_id != null)
            {
               if(_loc3_.mcamp_id != "")
               {
                  _loc2_ = "flash_" + _loc3_.mcamp_id;
               }
            }
         }
         dataM.openURL("https://itunes.apple.com/app/apple-store/id864103912?pt=1225303&ct=" + _loc2_ + "&mt=8","_blank");
         soundM.createSound("buttonClick",1);
      }
      
      private function availableOnTheAppStoreMouseOver(param1:MouseEvent) : void
      {
         this.mcAvailableOnTheAppStore.mcMouseOverEffect.visible = true;
      }
      
      private function availableOnTheAppStoreMouseOut(param1:MouseEvent) : void
      {
         this.mcAvailableOnTheAppStore.mcMouseOverEffect.visible = false;
      }
      
      private function availableOnGooglePlayClicked(param1:MouseEvent) : void
      {
         dataM.openURL("https://play.google.com/store/apps/details?id=air.com.supermechs.superapp&hl=en","_blank");
         soundM.createSound("buttonClick",1);
      }
      
      private function availableOnGooglePlayMouseOver(param1:MouseEvent) : void
      {
         this.mcAvailableOnGooglePlay.mcMouseOverEffect.visible = true;
      }
      
      private function availableOnGooglePlayMouseOut(param1:MouseEvent) : void
      {
         this.mcAvailableOnGooglePlay.mcMouseOverEffect.visible = false;
      }
      
      private function getVersionText() : String
      {
         var _loc1_:String = String(dataM.clientVersion);
         return String(externalAssetsM.CLIENT_VERSION_ANDROID);
      }
      
      private function getBuildInfo() : String
      {
         var _loc1_:String = "";
         return _loc1_ + ("Port: " + BMMClientFlashConsts.usedPortForDev + " Auth Port: " + BMMClientFlashConsts.usedAuthPort);
      }
      
      public function refreshVersionText(param1:String = null) : void
      {
         var _loc2_:String = param1 == null ? this.getVersionText() : param1;
         this.txtVersion.text = _loc2_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("welcomeBackground_txtVersion",[this.txtVersion],"",this);
         }
      }
      
      private function onVersionTextClick(param1:MouseEvent) : void
      {
         this.refreshVersionText(this.getVersionText() + " loading");
         TsLogger.log("Version: " + this.getVersionText());
         TsLogger.log("Build Info: " + this.getBuildInfo());
         TsLogger.log("Domain: " + BMDomainResolver.getDomain());
         TsLogger.log("TCP Domain: " + BMDomainResolver.getDomain(true));
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.onServerInfoLoaderSent);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onServerInfoLoaderIoError);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onServerInfoLoaderSecurityError);
         _loc2_.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.serverInfoLoaderhttpStatusHandler);
         _loc2_.load(new URLRequest(BMDomainResolver.getHttpDomain() + "/api/server_info.php"));
      }
      
      private function serverInfoLoaderhttpStatusHandler(param1:HTTPStatusEvent) : void
      {
      }
      
      private function onServerInfoLoaderSecurityError(param1:SecurityErrorEvent) : void
      {
         TsLogger.log("onServerInfoLoaderSecurityError:onSecurityError " + param1.text);
      }
      
      private function onServerInfoLoaderIoError(param1:IOErrorEvent) : void
      {
         TsLogger.log("onServerInfoLoaderIoError:onIoError " + param1.text);
      }
      
      private function onServerInfoLoaderSent(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc2_:URLLoader = param1.target as URLLoader;
         if(_loc2_.data)
         {
            _loc4_ = JSON.parse(_loc2_.data);
            TsLogger.log("Server IP: " + _loc4_.ip);
            TsLogger.log("Server Info: " + _loc4_.info);
            if(_loc4_.info)
            {
               _loc3_ = "@" + _loc4_.info;
            }
            else
            {
               _loc3_ = "ip: " + _loc4_.ip;
            }
         }
         else
         {
            TsLogger.log("Bad Response: " + JSON.stringify(_loc2_));
            _loc3_ = "err";
         }
         _loc3_ += ":dynamic:" + BMMClientFlashConsts.usedAuthPort;
         this.refreshVersionText(this.getVersionText() + " " + _loc3_);
      }
   }
}

