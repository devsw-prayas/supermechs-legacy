package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.text.TextField;
   import net.battleMechsMulti.helpers.BMAffiliatesHelper;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.managers.BMLoadingTimer;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMNewsData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.session.LoginServices;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   import net.tacticsoft.global.BMMClientFlashVars;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol156")]
   public class BMScreenWelcomeBackground extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackgroundHolder:Sprite;
      
      public var mcSizer_btnLanguages:Sprite;
      
      public var mcMechHolder:MovieClip;
      
      public var txtVersion:TextField;
      
      public var txtConnectingToServer:TextField;
      
      public var txtWelcomeBack:TextField;
      
      public var mcLoadingBackground:MovieClip;
      
      public var mcSandClock:MovieClip;
      
      public var mcAvailableOnTheAppStore:MovieClip;
      
      public var mcAvailableOnGooglePlay:MovieClip;
      
      public var btnLanguages:BMButton_pictureE;
      
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
      
      public function BMScreenWelcomeBackground()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("welcome");
         screensM.createButtonFromSizer("screenWelcomeBackground","btnLanguages","pictureE");
         var _loc1_:Function = this.languagesClicked;
         if(dataM.runAsMobile)
         {
            _loc1_ = null;
         }
         this.btnLanguages.initialize("","",dataM.getLanguageIcon(),[],_loc1_,dataM.runAsMobile);
         this.btnLanguages.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.languageUpdate();
         this.txtWelcomeBack.text = "";
         this.mcLoadingBackground.visible = false;
         this.createLoggingInTextBitmapForMobile();
         this.txtConnectingToServer.visible = false;
         this.createLoggingInTextBitmapForMobile();
         dataM.sessionManager.createSession();
         if(!dataM.logOutClicked && !tutorialM.guestRegistrationActive)
         {
            BMLoginManager.gi().startLoginFlow();
         }
         if(dataM.useLanguages == false)
         {
            this.btnLanguages.visible = false;
         }
         if(dataM.welcomeScreenInitialized == false)
         {
            dataM.welcomeScreenInitialized = true;
         }
      }
      
      public function showInitialLoginScreen(param1:String = null, param2:Boolean = false) : *
      {
         if(dataM.installationData.lastLoginService != LoginServices.SUPERMECHS && dataM.getSharedObjectLastLoginUsername() == "" && false == false)
         {
            if(screensM.isScreenOpened("screenWelcomeLogin"))
            {
               screensM.screenWelcomeLogin.backClicked();
            }
            else
            {
               screensM.addScreen("screenWelcomeNewExisting");
               screensM.screenWelcomeNewExisting.refreshScreen();
            }
         }
         else
         {
            screensM.addScreen("screenWelcomeLogin");
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
      
      public function languagesClicked() : void
      {
         if(screensM.isScreenOpened("screenLanguageSelection"))
         {
            screensM.removeScreen("screenLanguageSelection");
         }
         else
         {
            screensM.addScreen("screenLanguageSelection");
            screensM.screenLanguageSelection.x = this.btnLanguages.x - 6;
            screensM.screenLanguageSelection.y = this.btnLanguages.y + this.btnLanguages.height + 4;
            screensM.screenLanguageSelection.refreshScreen(this.newLanguageSelected);
         }
      }
      
      private function newLanguageSelected() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            this.btnLanguages.replacePicture(dataM.getLanguageIcon());
            this.languageUpdate();
            if(screensM.isScreenOpened("screenWelcomeLogin"))
            {
               screensM.screenWelcomeLogin.languageUpdate(true);
            }
            else if(screensM.isScreenOpened("screenWelcomeNewExisting"))
            {
               screensM.screenWelcomeNewExisting.languageUpdate(true);
            }
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
         if(_loc1_.level <= 1 || BMLoginManager.gi().loginType == BMLoginManager.LOGIN_TYPE_REGISTER_GENERATED)
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
         var _loc1_:String = this.getPlayerStartingLocation(dataM.ONLINE_PLAYER_ID);
         screensM.removeScreen("screenConfirmation");
         switch(_loc1_)
         {
            case "mainMenu":
               screensM.screenBlack.activateBlackScreen(this.proceedToMainMenu,true,true,null,0);
               break;
            case "dailyLoginStreak":
               screensM.addScreen("screenDailyLoginStreakBonus");
               screensM.screenDailyLoginStreakBonus.refreshScreen();
               break;
            case "baseMap":
               remoteM.socketM.mission_getData();
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               break;
            case "freePackages":
               dataM.popupFreePackages();
               break;
            case "starterPack":
               screensM.screenBlack.activateBlackScreen(this.proceedToStarterPack,true,true,null,0);
               break;
            default:
               screensM.screenBlack.activateBlackScreen(this.proceedToOnlineTutorial,true,true,null,0);
         }
      }
      
      private function proceedToOnlineTutorial() : void
      {
         var _loc1_:String = this.getPlayerStartingLocation(dataM.ONLINE_PLAYER_ID);
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         if(_loc1_ == "openingSequence")
         {
            screensM.addScreen("screenOpeningSequence");
            screensM.screenOpeningSequence.startAnimation(this.proceedToOnlineTutorial);
            _loc2_.watchedOpeningSequenceThisSession = true;
         }
         else
         {
            switch(_loc1_)
            {
               case "hanger":
                  screensM.screenNewMenu.hangerMechClicked(true);
                  if(_loc2_.tutorialLevel <= 1)
                  {
                     screensM.addScreen("screenItemCards");
                     screensM.screenItemCards.refreshScreen([BMCampaignMechsHelper.getTutorial_hanger1_torso(),BMCampaignMechsHelper.getTutorial_hanger1_leg(),BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon()],25,true);
                  }
                  break;
               case "packages":
                  screensM.screenNewMenu.shopCombinedClicked(true);
                  break;
               case "news":
                  screensM.screenNewMenu.communityNewsClicked(true);
            }
            remoteM.lobby_enter();
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
         screensM.screenNewMenu.openBuyStarterPackSub("Welcome");
         this.removeMe();
      }
      
      private function proceedToMainMenu() : *
      {
         this.removeMe();
         screensM.screenNewMenu.mainMenu(true);
      }
      
      public function playingAsGuest() : void
      {
         var _loc1_:BMBoostData = null;
         var _loc2_:String = null;
         if(FeatureFlags.NEW_ECONOMY == false)
         {
            _loc1_ = dataM.boostsDB[14];
            _loc1_.itemID = 892;
            _loc1_ = dataM.boostsDB[15];
            _loc1_.itemID = 920;
         }
         if(dataM.guestSharedObjectExists)
         {
            dataM.initializeLocalMode();
            _loc2_ = this.getPlayerStartingLocation(dataM.LOCAL_PLAYER_ID);
            this.proceedToGuestMode();
            BMNotificationsManager.getInstance();
         }
         else
         {
            this.playingAsGuestSub();
         }
      }
      
      private function playingAsGuestSub() : void
      {
         dataM.initializeLocalMode();
         if(screensM.isScreenOpened("screenWelcomeNewExisting"))
         {
            screensM.screenWelcomeNewExisting.btnNewPlayer.disableMe();
         }
         this.proceedToGuestMode();
      }
      
      public function proceedToGuestMode() : void
      {
         var _loc3_:BMPlayerData = null;
         dataM.achievementsSortedDB = new Array();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.LOCAL_PLAYER_ID + "Profile"];
         var _loc2_:String = this.getPlayerStartingLocation(dataM.LOCAL_PLAYER_ID);
         if(_loc2_ == "openingSequence")
         {
            screensM.addScreen("screenOpeningSequence");
            screensM.screenOpeningSequence.startAnimation(this.proceedToGuestMode);
            _loc1_.watchedOpeningSequenceThisSession = true;
         }
         else
         {
            switch(_loc2_)
            {
               case "hanger":
                  screensM.screenNewMenu.hangerMechClicked(true);
                  _loc3_ = dataM.playersData[dataM.LOCAL_PLAYER_ID];
                  if(_loc1_.winsVSComputer == 0 && _loc3_.mechStructures[_loc3_.selectedMechID].torso == 0)
                  {
                     screensM.addScreen("screenItemCards");
                     screensM.screenItemCards.refreshScreen([BMCampaignMechsHelper.getTutorial_hanger1_torso(),BMCampaignMechsHelper.getTutorial_hanger1_leg(),BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon()],25,true);
                  }
                  break;
               case "packages":
                  screensM.screenNewMenu.shopCombinedClicked(true);
                  break;
               case "mainMenu":
                  this.proceedToMainMenu();
                  break;
               case "baseMap":
                  screensM.addScreen("screenMissionBaseMap");
                  screensM.addScreen("screenTopBar");
                  screensM.screenTopBar.refreshScreen(true);
                  screensM.screenMissionBaseMap.refreshScreen(false);
            }
            if(screensM.isScreenOpened("screenWelcomeNewExisting"))
            {
               screensM.screenWelcomeNewExisting.btnNewPlayer.enableMe();
            }
         }
         this.removeMe();
      }
      
      private function launchOnlineMissionBaseMap() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         if(_loc1_.missionID > 0)
         {
            remoteM.socketM.mission_getData();
         }
         else
         {
            _loc1_.currentMissionSlot = 0;
            if(_loc1_.mapProgress[0] == "v")
            {
               _loc1_.currentMissionSlot = 1;
            }
            remoteM.socketM.mission_create(0,1,_loc1_.currentMissionSlot,"");
         }
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
      }
      
      public function gotOnlineMissionData() : void
      {
         screensM.removeScreen("screenConfirmation");
         screensM.screenBlack.activateBlackScreen(this.proceedToOnlineMissionBaseMap,true,true,null,0);
      }
      
      public function getOnlineMissionDataFailed() : void
      {
         this.launchOnlineMissionBaseMap();
      }
      
      public function newOnlineMissionCreated() : void
      {
         screensM.removeScreen("screenConfirmation");
         screensM.screenBlack.activateBlackScreen(this.proceedToOnlineMissionBaseMap,true,true,null,0);
      }
      
      private function proceedToOnlineMissionBaseMap() : void
      {
         screensM.addScreen("screenTopBar");
         screensM.screenTopBar.refreshScreen(false);
         screensM.addScreen("screenMissionBaseMap");
         screensM.screenMissionBaseMap.refreshScreen(false);
         this.removeMe();
      }
      
      private function getPlayerStartingLocation(param1:Number) : String
      {
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc7_:BMNewsData = null;
         var _loc8_:Number = NaN;
         var _loc2_:BMPlayerProfile = dataM["player" + param1 + "Profile"];
         var _loc3_:String = "mainMenu";
         if(_loc2_.tutorialLevel == 0)
         {
            if(_loc2_.watchedOpeningSequenceThisSession || dataM.clientRunningLocally)
            {
               _loc3_ = "hanger";
            }
            else
            {
               _loc3_ = "openingSequence";
            }
         }
         else if(tutorialM.isTutorialActive())
         {
            if(_loc2_.missionID > 0)
            {
               _loc3_ = "baseMap";
            }
            else
            {
               switch(tutorialM.getTutorialDestination())
               {
                  case BMTutorialManager.TUTORIAL_DESTINATION_MECH:
                  case BMTutorialManager.TUTORIAL_DESTINATION_FUSION:
                  case BMTutorialManager.TUTORIAL_DESTINATION_MISSION:
                  case BMTutorialManager.TUTORIAL_DESTINATION_SHOP:
                     _loc3_ = "mainMenu";
                     break;
                  case BMTutorialManager.TUTORIAL_DESTINATION_LONE_BATTLE:
                     _loc3_ = "hanger";
               }
            }
         }
         else if(loginM.isConnected)
         {
            _loc4_ = false;
            if(dataM.dailyLoginStreakBonus != null)
            {
               if(dataM.dailyLoginStreakBonus.type != null)
               {
                  _loc4_ = true;
               }
            }
            if(_loc4_)
            {
               _loc3_ = "dailyLoginStreak";
            }
            else if(dataM.gotPopupFreePackages)
            {
               _loc3_ = "freePackages";
            }
            else if(_loc2_.missionID > 0)
            {
               _loc3_ = "baseMap";
            }
            else if(dataM.isStarterPackActive())
            {
               _loc3_ = "starterPack";
            }
            else
            {
               _loc5_ = false;
               _loc6_ = 0;
               for each(_loc7_ in dataM.newsDB)
               {
                  if(_loc6_ < _loc7_.newsID)
                  {
                     _loc6_ = _loc7_.newsID;
                  }
               }
               if(_loc2_.lastNewsID < _loc6_)
               {
                  if(_loc2_.level >= 8)
                  {
                     _loc3_ = "news";
                  }
               }
               if(dataM.useRateBox)
               {
                  _loc8_ = dataM.getLadderRankByProgress(_loc2_.ladderProgress);
                  if(_loc8_ >= 1 && _loc8_ <= dataM.rateBoxRankRequired)
                  {
                     if(_loc2_.rateStatus == "" || _loc2_.rateStatus == "D" && dataM.userDeclinedRatingForThisSession == false)
                     {
                        _loc5_ = true;
                     }
                  }
               }
               if(_loc5_)
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
         if(screensM.isScreenOpened("screenLanguageSelection"))
         {
            screensM.removeScreen("screenLanguageSelection");
         }
         screensM.removeScreen("screenWelcomeBackground");
         if(screensM.isScreenOpened("screenWelcomeLoginAs"))
         {
            screensM.removeScreen("screenWelcomeLoginAs");
         }
         if(screensM.isScreenOpened("screenWelcomeNewExisting"))
         {
            screensM.removeScreen("screenWelcomeNewExisting");
         }
         if(screensM.isScreenOpened("screenWelcomeLoginAs"))
         {
            screensM.removeScreen("screenWelcomeLoginAs");
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
      
      public function refreshVersionText() : void
      {
         this.txtVersion.text = String(dataM.clientVersion);
         this.txtVersion.text = String(externalAssetsM.CLIENT_VERSION_ANDROID);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("welcomeBackground_txtVersion",[this.txtVersion],"",this);
         }
      }
   }
}

