package net.battleMechsMulti.screens.mainMenu
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import com.greensock.easing.Power1;
   import com.greensock.easing.Power2;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.helpers.BMMultiplayerCallToActionHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMMarketingManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingNotificationHelper;
   import net.battleMechsMulti.managers.mining.BMMineUserData;
   import net.battleMechsMulti.managers.mining.BMMiningManager;
   import net.battleMechsMulti.managers.nukes.BMNukesResolver;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.mobiles.unlockedMechSlotsResolver.BMUnlockedMechSlotsResolver;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.quests.BMQuestsMiniPanel;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2595")]
   public class BMScreenMainMenu extends BMBaseScreen
   {
      
      public var mcBgDark:MovieClip;
      
      public var mcBgLight:MovieClip;
      
      public var mcSpecialOfferPos:Sprite;
      
      public var mcPlatformsCenter:MovieClip;
      
      public var mcArenaButton:BMBasicButton;
      
      public var mcWorkshopButton:BMBasicButton;
      
      public var mcShopButton:BMBasicButton;
      
      public var mcCampaignButton:BMBasicButton;
      
      public var mcUpgradeButton:BMBasicButton;
      
      public var mcUpgradeSmallButton:BMBasicButton;
      
      public var mcBaseButton:BMBasicButton;
      
      public var mcClanButton:BMBasicButton;
      
      public var mcRaidButton:BMBasicButton;
      
      public var mcKinButton:BMBasicButton;
      
      public var mcQuestsMiniPanel:BMQuestsMiniPanel;
      
      public var mcSupportBtn:BMBasicButton;
      
      public var mcResetAccountBtn:BMBasicButton;
      
      public var exitBetaBtn:MovieClip;
      
      public var mcShopCounter:TextHolder;
      
      public var mcUpgradeCounter:TextHolder;
      
      public var mcPVPHighRewardsCounter:TextHolder;
      
      public var mcBaseNotification_gold:Sprite;
      
      public var mcBaseNotification_items:Sprite;
      
      public var mcClanRewardAvailable:Sprite;
      
      public var mcClanWarJoinBadge:Sprite;
      
      public var mcClanWarBattlesLeft:TextHolder;
      
      public var mcMinedTokensIndicator:Sprite;
      
      public var mcChainDiscountTimer:BMTimer;
      
      public var mcMechStarterPackIndicator:Sprite;
      
      public var mcTutorialArrow:Sprite;
      
      public var mcPremiumTimer:BMPremiumTimer;
      
      public var mcVIPSubscriptionIndicator:Sprite;
      
      public var mcRaidBadge:Sprite;
      
      public var mcSpecialEventImageHolder:Sprite;
      
      public var snowFlakes:Array;
      
      private var _vipSubscriptionIndicatorTimer:Timer;
      
      private var _carouselAnimator:CarouselAnimator;
      
      private var _mechViews:Vector.<BMMechView> = new Vector.<BMMechView>();
      
      private var _firstRefresh:Boolean = true;
      
      private var _initTimeLine:TimelineMax;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _baseNotificationOriginXPos_gold:Number;
      
      private var _baseNotificationOriginXPos_items:Number;
      
      private var _frontMechDisplayPowerRating:Number = 400;
      
      private var _mechsTeaseFrameCounter:Number = 0;
      
      private var _mechsTeaseCurrentMech:uint = 0;
      
      public var mcSnowFlakesHolder:Sprite;
      
      private var snowFlakesTotal:uint = 30;
      
      public function BMScreenMainMenu()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         sub(BMPubSub.MESSAGE_KIN_READY_FOR_DISPLAY,this.onKinReadyForDisplay);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         this.mcArenaButton.addEventListener(BMIntractable.HIT,this.onArenaButtonHit);
         this.mcUpgradeButton.addEventListener(BMIntractable.HIT,this.onUpgradeButtonHit);
         this.mcUpgradeSmallButton.addEventListener(BMIntractable.HIT,this.onUpgradeButtonHit);
         this.mcBaseButton.addEventListener(BMIntractable.HIT,this.onBaseClicked);
         this.mcWorkshopButton.addEventListener(BMIntractable.HIT,this.onWorkshopButtonHit);
         this.mcShopButton.addEventListener(BMIntractable.HIT,this.onShopButtonHit);
         this.mcCampaignButton.addEventListener(BMIntractable.HIT,this.onCampaignButtonHit);
         this.mcClanButton.addEventListener(BMIntractable.HIT,this.onClanClick);
         this.mcRaidButton.addEventListener(BMIntractable.HIT,this.onRaidClicked);
         this.mcKinButton.addEventListener(BMIntractable.HIT,this.onKinClicked);
         this.exitBetaBtn.addEventListener(MouseEvent.CLICK,this.onExitBetaClick);
         this.exitBetaBtn.visible = !tutorialM.isTutorialActive() && dataM.myProfile.didOptInToBeta;
         this.mcSupportBtn.visible = false;
         this.mcResetAccountBtn.visible = false;
         this.initBaseNotifications();
         if(dataM.baseBuildingManager.isEnabled)
         {
            this.mcUpgradeButton.visible = false;
            this.mcUpgradeCounter.x = 438;
            this.mcUpgradeCounter.y = 306;
         }
         else
         {
            this.mcUpgradeSmallButton.visible = false;
            this.mcBaseButton.visible = false;
         }
         if(FeatureFlags.BLOCK_QUESTS)
         {
            this.mcQuestsMiniPanel.visible = false;
         }
         if(FeatureFlags.BLOCK_UPGRADE)
         {
            this.mcUpgradeButton.visible = false;
            this.mcUpgradeSmallButton.visible = false;
         }
         if(FeatureFlags.BLOCK_CAMPAIGN)
         {
            this.mcCampaignButton.visible = false;
         }
         if(FeatureFlags.BLOCK_SHOP)
         {
            this.mcShopButton.visible = false;
         }
         if(FeatureFlags.BLOCK_RAID)
         {
            this.mcRaidButton.visible = false;
         }
         if(FeatureFlags.BLOCK_PVP)
         {
            this.mcArenaButton.visible = false;
         }
         if(FeatureFlags.BLOCK_WORKSHOP)
         {
            this.mcWorkshopButton.visible = false;
         }
         if(FeatureFlags.MAIN_SCREEN_RESET_ACCOUNT_BUTTON)
         {
            this.mcResetAccountBtn.visible = true;
            this.mcResetAccountBtn.addEventListener(BMIntractable.HIT,this.resetAccountClicked);
         }
         if(FeatureFlags.MAIN_SCREEN_FEEDBACK_BUTTON)
         {
            this.mcSupportBtn.visible = true;
            this.mcSupportBtn.addEventListener(BMIntractable.HIT,this.supportClicked);
            this.mcSupportBtn.text = "FEEDBACK";
         }
         if(tutorialM.isTutorialActive() || dataM.getGeneralSetting("showClanButtonInMainMenu",0) == 0)
         {
            this.mcClanButton.visible = false;
         }
         if(dataM.raidData.areRaidsEnabled())
         {
            this.mcRaidBadge.mouseEnabled = false;
            this.mcRaidBadge.mouseChildren = false;
            this.mcRaidBadge.visible = false;
            if(dataM.raidData.hasPendingReward() || dataM.raidData.showCallToActionBadge)
            {
               this.mcRaidBadge.visible = true;
            }
            this.mcPremiumTimer.y -= 60;
            this.mcVIPSubscriptionIndicator.y -= 60;
         }
         else
         {
            this.mcRaidButton.visible = false;
            this.mcRaidBadge.visible = false;
         }
         if(dataM.kinM.isEnabled == false)
         {
            this.mcKinButton.visible = false;
         }
         this.mcClanRewardAvailable.mouseEnabled = false;
         this.mcClanRewardAvailable.mouseChildren = false;
         this.mcClanWarBattlesLeft.mouseEnabled = false;
         this.mcClanWarBattlesLeft.mouseChildren = false;
         this.mcClanWarJoinBadge.mouseEnabled = false;
         this.mcClanWarJoinBadge.mouseChildren = false;
         this.createLightAnimation();
         setLanguageManagerScreenName("mainMenu");
         sub(BMPubSub.MESSAGE_FREE_PACKAGES_UPDATED,this.handleFreePackagesUpdated);
         sub(BMPubSub.MESSAGE_MECH_EQUIPMENT_CHANGED,this.handleMechEquipmentChanged);
         sub(BMPubSub.MESSAGE_SHOP_CLOSED,this.handleShopClosed);
         sub(BMPubSub.MESSAGE_APP_ACTIVAED,this.handleAppActivated);
         tutorialM.reviveTutorialLastState();
         if(screensM.screenBlack.isActive())
         {
            sub(BMPubSub.MESSAGE_BLACK_SCREEN_INACTIVE,this.checkForPopupsAfterInit);
         }
         else
         {
            this.checkForPopupsAfterInit("",null);
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.specialEventImageHandler();
         this.initSnowFlakes();
         if(dataM.gameOfWhalesM.isEnabled)
         {
            dataM.gameOfWhalesM.updateUserProfile();
            dataM.gameOfWhalesM.getOffers();
         }
      }
      
      private function createLightAnimation() : *
      {
         var i:int;
         var dark:Function = function():*
         {
            return [new TweenMax(mcBgLight,0.01,{"visible":false}),new TweenMax(mcBgDark,0.01,{"visible":true})];
         };
         var light:Function = function():*
         {
            return [new TweenMax(mcBgLight,0.01,{"visible":true}),new TweenMax(mcBgDark,0.01,{"visible":false})];
         };
         this._initTimeLine = new TimelineMax();
         this._initTimeLine.add(dark());
         this._initTimeLine.add(light(),"+=" + (0.5 + Math.random() * 0.3));
         this._initTimeLine.add(dark(),"+=" + (0.03 + Math.random() * 0.04));
         this._initTimeLine.add(light(),"+=" + (0.15 + Math.random() * 0.3));
         i = 0;
         while(i < 1 + Math.random() * 2)
         {
            this._initTimeLine.add(dark(),"+=" + (0.03 + Math.random() * 0.03));
            this._initTimeLine.add(light(),"+=" + (0.03 + Math.random() * 0.1));
            i++;
         }
         this._initTimeLine.stop();
      }
      
      public function refreshScreen() : void
      {
         if(this._firstRefresh)
         {
            dataM.setGameTypeAndPlayersToDefault();
            screensM.addScreen(BMScreensManager.SCR_TOP_BAR,true,BMScreenTopBarClone);
            this.initMechs();
            this._initTimeLine.play();
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow);
            BMShopManager.gi().processPendingPurchases();
            if(!tutorialM.isTutorialActive())
            {
               dataM.starterPack_goBackToScreen = "mainMenu";
               if(BMMiningManager.isAvailable())
               {
                  this.mcSpecialOfferPos.y += 30;
                  this.mcPremiumTimer.y += 5;
                  this.mcVIPSubscriptionIndicator.y += 5;
               }
               BMSpecialOffersManager.gi().showSmallBanner(this.mcSpecialOfferPos);
            }
         }
         this._firstRefresh = false;
         var _loc1_:Boolean = false;
         if(dataM.myProfile.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_MECH3)
         {
            _loc1_ = true;
         }
         screensM.screenTopBar.refreshScreen(_loc1_);
         this.refreshFreePackagesCounter();
         this.refreshStarterPackMechCounter();
         this.refreshUpgradeCounter();
         this.refreshPVPHighRewardsCounter();
         this.refreshMinedTokensIndicator();
         this.refreshBaseCounter();
         this.refreshClanBadgesAndIndicators();
         this.refreshChainDiscountTimer();
         this.refreshButtonsForTutorial();
         this.refreshLanguages();
         this.checkForMarketingGifts();
         sub(BMPubSub.VIP_ACCOUNT_UPDATED,this.vipAccountUpdated);
         this.tryToShowVIPSubscriptionPopup();
         this.refreshMultiplayerCallToActionTutorialArrow();
         dataM.clanWarsM.setLocalNotifications();
      }
      
      private function onKinReadyForDisplay(param1:String, param2:Object) : void
      {
         if(dataM.kinM.isEnabled)
         {
            this.mcKinButton.visible = true;
         }
      }
      
      private function checkForMarketingGifts() : void
      {
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         var _loc1_:Array = BMMarketingManager.getGiftKeysAndClear();
         if(Boolean(_loc1_) && _loc1_.length > 0)
         {
            remoteM.socketM.marketing_claimGiftKeys(_loc1_);
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
      }
      
      private function refreshLanguages() : void
      {
         var _loc1_:Number = 1;
         if(dataM.languageID == BMLanguageManager.LANGUAGE_RUSSIAN)
         {
            _loc1_ = 0.8;
         }
         this.mcArenaButton.textScale = _loc1_;
         this.mcArenaButton.text = getScreenText("arena");
         this.mcCampaignButton.textScale = _loc1_;
         this.mcCampaignButton.text = getScreenText("campaign");
         this.mcUpgradeButton.textScale = _loc1_;
         this.mcUpgradeButton.text = getScreenText("upgrade");
         this.mcUpgradeSmallButton.textScale = _loc1_;
         this.mcUpgradeSmallButton.text = getScreenText("upgrade");
         this.mcBaseButton.textScale = _loc1_;
         this.mcBaseButton.text = getSpecificText("baseBuilding_base");
         this.mcWorkshopButton.textScale = _loc1_;
         this.mcWorkshopButton.text = getScreenText("workshop");
         this.mcShopButton.textScale = _loc1_;
         this.mcShopButton.text = getScreenText("shop");
         this.mcClanButton.textScale = _loc1_;
         this.mcClanButton.text = getGeneralText("clanCaps");
         this.mcRaidButton.textScale = _loc1_;
         this.mcRaidButton.text = getSpecificText("raid_title");
      }
      
      public function refreshButtonsForTutorial(param1:int = 0) : void
      {
         var _loc2_:BMBasicButton = null;
         var _loc3_:int = 0;
         if(tutorialM.isTutorialActive() || param1 != BMTutorialManager.TUTORIAL_DESTINATION_NONE)
         {
            this.mcArenaButton.disableMe();
            this.mcWorkshopButton.disableMe();
            this.mcShopButton.disableMe();
            this.mcCampaignButton.disableMe();
            this.mcUpgradeButton.disableMe();
            this.mcUpgradeSmallButton.disableMe();
            this.mcBaseButton.disableMe();
            this.mcQuestsMiniPanel.visible = false;
            this.mcClanButton.disableMe();
            this.mcRaidButton.disableMe();
            if(dataM.myProfile.levelUpData != null && BMGameShortcutsHelper.levelUpShortcut() == false)
            {
               if(param1 == BMTutorialManager.TUTORIAL_DESTINATION_NONE)
               {
                  return;
               }
            }
            _loc3_ = param1;
            if(param1 == BMTutorialManager.TUTORIAL_DESTINATION_NONE)
            {
               _loc3_ = int(tutorialM.getTutorialDestination());
            }
            switch(_loc3_)
            {
               case BMTutorialManager.TUTORIAL_DESTINATION_MECH:
                  _loc2_ = this.mcWorkshopButton;
                  break;
               case BMTutorialManager.TUTORIAL_DESTINATION_FUSION:
                  if(dataM.baseBuildingManager.isEnabled)
                  {
                     _loc2_ = this.mcUpgradeSmallButton;
                  }
                  else
                  {
                     _loc2_ = this.mcUpgradeButton;
                  }
                  break;
               case BMTutorialManager.TUTORIAL_DESTINATION_SHOP:
                  _loc2_ = this.mcShopButton;
                  break;
               case BMTutorialManager.TUTORIAL_DESTINATION_MISSION:
                  _loc2_ = this.mcCampaignButton;
                  break;
               case BMTutorialManager.TUTORIAL_DESTINATION_BASE:
                  _loc2_ = this.mcBaseButton;
            }
            _loc2_.enableMe();
            this._tutorialArrowController.activateTutorialArrow(this,_loc2_.x + _loc2_.width / 2,_loc2_.y,-90,0,0);
         }
         else
         {
            this._tutorialArrowController.deactivateTutorialArrow();
            this.mcArenaButton.enableMe();
            this.mcWorkshopButton.enableMe();
            this.mcShopButton.enableMe();
            this.mcCampaignButton.enableMe();
            this.mcUpgradeButton.enableMe();
            this.mcUpgradeSmallButton.enableMe();
            this.mcBaseButton.enableMe();
            this.mcClanButton.enableMe();
            this.mcRaidButton.enableMe();
         }
      }
      
      public function levelUpClosed() : void
      {
         this.refreshButtonsForTutorial();
      }
      
      private function initMechs() : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:BMMechStructure = null;
         var _loc7_:Boolean = false;
         var _loc8_:BMMechView = null;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:Vector.<MovieClip> = new Vector.<MovieClip>();
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc4_ = _loc3_ + 1;
            _loc5_ = new ScreenMainMenuPlatform();
            _loc5_.mcAssets.gotoAndStop("lightOff");
            _loc5_.orgIndex = _loc4_;
            _loc6_ = _loc1_.mechStructures[_loc4_];
            _loc7_ = _loc6_ != null && _loc6_.canBeDisplayed();
            if(_loc7_ == false || tutorialM.isTutorialActive() || BMUnlockedMechSlotsResolver.isMechSlotLocked(_loc4_) == false)
            {
               _loc5_.mcLocked.visible = false;
            }
            if(_loc7_)
            {
               _loc8_ = new BMMechView();
               _loc8_.initialize(dataM.player1PlayerID,"battle",BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,0.8,false);
               _loc8_.buildMech(_loc6_);
               this._mechViews.push(_loc8_);
               _loc8_.y = -(_loc8_.mechSizer.height + _loc8_.mechSizer.y);
               _loc5_.mcAssets.mcMechPosition.addChild(_loc8_);
               _loc5_.mechID = _loc6_.mechID;
               _loc5_.mouseChildren = false;
               _loc5_.addEventListener(MouseEvent.CLICK,this.onPlatformClick);
            }
            _loc5_.mcAssets.mcDisplayPowerRating.visible = false;
            _loc2_.push(_loc5_);
            _loc3_++;
         }
         this._carouselAnimator = new CarouselAnimator();
         addChildAt(this._carouselAnimator,getChildIndex(this.mcPlatformsCenter));
         this._carouselAnimator.x = this.mcPlatformsCenter.x;
         this._carouselAnimator.y = this.mcPlatformsCenter.y;
         this._carouselAnimator.radius = new Point(280,0);
         this._carouselAnimator.setItems(_loc2_);
         this._carouselAnimator.setSelectedItemLightOn();
         this._carouselAnimator.addEventListener(CarouselAnimator.ON_MOVE_COMPLETE,this.onMoveComplete);
      }
      
      public function get frontMechDisplayPowerRating() : Number
      {
         return this._frontMechDisplayPowerRating;
      }
      
      public function set frontMechDisplayPowerRating(param1:Number) : void
      {
         this._frontMechDisplayPowerRating = Math.ceil(param1);
      }
      
      public function updateFrontMechDisplayPowerRating(param1:MovieClip = null, param2:Number = -1) : void
      {
         if(param1 == null)
         {
            param1 = this._carouselAnimator.getSelectedItem();
         }
         if(param2 == -1)
         {
            param2 = this._frontMechDisplayPowerRating;
         }
         var _loc3_:String = TextUtils.getNumberWithComma(param2);
         updateTextAndFormat(param1.mcAssets.mcDisplayPowerRating.txtDisplayPowerRating,_loc3_);
      }
      
      private function onPlatformClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc6_:Number = NaN;
         BMPubSub.pub(BMPubSub.MESSAGE_MAIN_MENU_PLAYER_CLICKED_ON_MECH);
         if(tutorialM.isAllowedToClickOnMovieClip(_loc2_) == false)
         {
            return;
         }
         if(screensM.screensDirector.hasTasks())
         {
            return;
         }
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         if(tutorialM.isTutorialActive() == false)
         {
            this._tutorialArrowController.deactivateTutorialArrow();
         }
         _loc2_ = param1.target as MovieClip;
         if(this._carouselAnimator.getSelectedItem() == _loc2_)
         {
            if(FeatureFlags.BLOCK_WORKSHOP == false)
            {
               screensM.screenTransitionsManager.hangerMechClicked();
            }
            return;
         }
         var _loc3_:uint = uint(_loc2_.mechID);
         var _loc4_:uint = BMUnlockedMechSlotsResolver.getNumberOfMechsUnlocked();
         if(_loc3_ > _loc4_)
         {
            _loc6_ = BMUnlockedMechSlotsResolver.getChapterRequiredToCompleteForMechSlot(_loc3_);
            if(_loc6_ != BMUnlockedMechSlotsResolver.CANNOT_BE_UNLOCKED_BY_CHAPTER_COMPLETION)
            {
               screensM.screenConfirmation.displayCustomMessage("<BR>Complete chapter " + _loc6_ + " in campaign to unlock this Mech");
            }
            return;
         }
         var _loc5_:uint = uint(this._carouselAnimator.selectedMechID);
         this.rotateCarousel(this._carouselAnimator.getItemByIndex(_loc5_) == _loc2_);
      }
      
      private function rotateCarousel(param1:Boolean) : void
      {
         var _loc2_:int = param1 ? 1 : -1;
         if(this._carouselAnimator.getItemByIndex(this._carouselAnimator.selectedIndex + _loc2_).hasOwnProperty("mechID"))
         {
            this._carouselAnimator.setSelectedItemLightOff();
            this._carouselAnimator.moveBy(_loc2_,2);
            screensM.screenTransitionsManager.mechOrderToSave = this.getCurrentMechOrder();
         }
      }
      
      public function selectMech(param1:uint, param2:Boolean = false) : Boolean
      {
         var _loc4_:BMMechView = null;
         var _loc3_:uint = uint(this._carouselAnimator.selectedMechID);
         if(param2)
         {
            this._carouselAnimator.forceLockedVisualEffectForMech(param1);
            _loc4_ = this._mechViews[param1 - 1];
            _loc4_.setBumpParameters();
            _loc4_.activateShutdown(true);
         }
         if(param1 == _loc3_)
         {
            return false;
         }
         if(param1 == _loc3_ + 1)
         {
            this.rotateCarousel(true);
         }
         else
         {
            this.rotateCarousel(false);
         }
         return true;
      }
      
      public function pointOnMech() : void
      {
         var _loc1_:Number = 430;
         var _loc2_:Number = 240;
         var _loc3_:Number = 0;
         this._tutorialArrowController.activateTutorialArrow(this,_loc1_,_loc2_,_loc3_);
      }
      
      public function removeShadowFromMech() : void
      {
         this._carouselAnimator.removeForceLockedVisualEffectForMechs();
         var _loc1_:uint = uint(this._carouselAnimator.selectedMechID);
         var _loc2_:BMMechView = this._mechViews[_loc1_ - 1];
         _loc2_.deactivateShutdown();
      }
      
      private function onMoveComplete(param1:Event) : void
      {
         this._carouselAnimator.setSelectedItemLightOn();
      }
      
      public function activateSelectedMechTaunt() : void
      {
         var _loc1_:uint = uint(this._carouselAnimator.selectedMechID);
         var _loc2_:BMMechView = this._mechViews[_loc1_ - 1];
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.activateTease2();
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.mechAnimationsHandler();
         var _loc1_:int = 0;
         while(_loc1_ < this._mechViews.length)
         {
            this._mechViews[_loc1_].onEnterFrameTrigger();
            _loc1_++;
         }
         this._tutorialArrowController.runFrame();
      }
      
      private function mechAnimationsHandler() : void
      {
         var _loc1_:BMMechView = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         if(screensM.screensDirector.hasTasks())
         {
            return;
         }
         if(this._mechViews.length == 0)
         {
            return;
         }
         ++this._mechsTeaseFrameCounter;
         if(this._mechsTeaseFrameCounter >= 150)
         {
            _loc1_ = this._mechViews[this._mechsTeaseCurrentMech];
            _loc2_ = Math.ceil(Math.random() * 9);
            switch(_loc2_)
            {
               case 1:
                  _loc1_.activateTease1(null);
                  break;
               case 2:
                  _loc1_.activateTease2(null);
                  break;
               case 3:
                  _loc1_.activateTease3(null);
                  break;
               case 4:
                  _loc1_.activateTease4(null);
                  break;
               case 5:
                  _loc1_.activateTease5(null);
                  break;
               case 6:
                  _loc1_.activateTease6(null);
                  break;
               case 7:
                  _loc1_.activateTease8(null);
                  break;
               case 8:
                  _loc1_.activateTease9(null,false);
                  break;
               case 9:
                  if(_loc1_.hasSideWeaponAt(1))
                  {
                     _loc1_.activateSword(1,null,true);
                  }
            }
            this._mechsTeaseFrameCounter = 50;
            ++this._mechsTeaseCurrentMech;
            _loc3_ = this._mechsTeaseCurrentMech + 1;
            _loc4_ = BMUnlockedMechSlotsResolver.isMechSlotLocked(_loc3_);
            if(this._mechsTeaseCurrentMech >= this._mechViews.length || _loc4_)
            {
               this._mechsTeaseCurrentMech = 0;
            }
         }
      }
      
      private function onWorkshopButtonHit(param1:Event) : void
      {
         this.onWorkshopButtonHitSub();
      }
      
      private function onWorkshopButtonHitSub() : void
      {
         if(screensM.screenTopBar.isLevelUpDisplayInProgress())
         {
            return;
         }
         trackButtonClick("Workshop");
         screensM.screenTransitionsManager.hangerMechClicked();
      }
      
      private function onOptionsButtonHit(param1:Event) : void
      {
         trackButtonClick("Options");
         screensM.screenTransitionsManager.extraOptions();
      }
      
      private function onArenaButtonHit(param1:Event) : void
      {
         trackButtonClick("Arena");
         screensM.screenTransitionsManager.multiplayerLadderClicked(false,true);
      }
      
      private function onShopButtonHit(param1:Event) : void
      {
         trackButtonClick("Shop");
         BMShopManager.gi().showItemBoxes("MainMenu");
      }
      
      private function onCampaignButtonHit(param1:Event) : void
      {
         this.onCampaignButtonHitSub();
      }
      
      public function onCampaignButtonHitSub() : void
      {
         if(FeatureFlags.BLOCK_CAMPAIGN)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         if(dataM.singlePlayerM.showCampaignMenu())
         {
            screensM.addScreen(BMScreensManager.SCR_CAMPAIGNS_MENU);
            screensM.screenCampaignsMenu.setEnterCampaignFunction(this.continueToCampaign);
            return;
         }
         this.continueToCampaign(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
      }
      
      private function continueToCampaign(param1:uint) : void
      {
         if(dataM.myProfile.hasClanBossReward)
         {
            screensM.screenConfirmation.displayCustomMessage(getSpecificText("clanBoss_mustCollectClanCoins"),this.clanClicked);
            return;
         }
         trackButtonClick("Campaign");
         screensM.screenTransitionsManager.singlePlayerClicked(false,param1);
      }
      
      private function onUpgradeButtonHit(param1:Event) : void
      {
         if(FeatureFlags.BLOCK_UPGRADE)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         trackButtonClick("Upgrade");
         screensM.screenTransitionsManager.upgrade();
      }
      
      public function showQuestsScreen(param1:int = 1, param2:int = -1) : void
      {
         screensM.addScreen(BMScreensManager.SCR_QUESTS);
         screensM.screenQuests.doOpenAnim(param1,param2);
         TweenMax.to(this.mcQuestsMiniPanel,0.5,{"alpha":0});
         screensM.screenTopBar.hideLvlAndXp();
         if(screensM.isScreenOpened(BMScreensManager.SCR_SPECIAL_OFFERS))
         {
            TweenMax.to(screensM.screenSpecialOffers,0.2,{
               "alpha":0,
               "visible":false
            });
         }
      }
      
      public function onHideQuestsScreen() : void
      {
         TweenMax.to(this.mcQuestsMiniPanel,0.3,{"alpha":1});
         screensM.screenTopBar.showLvlAndXp();
         if(screensM.isScreenOpened(BMScreensManager.SCR_SPECIAL_OFFERS))
         {
            screensM.screenSpecialOffers.visible = true;
            TweenMax.to(screensM.screenSpecialOffers,0.2,{
               "alpha":1,
               "delay":0.1
            });
         }
      }
      
      private function onClanClick(param1:Event) : void
      {
         this.clanClicked();
      }
      
      private function clanClicked() : void
      {
         screensM.screenTransitionsManager.communityClanClicked();
      }
      
      private function onRaidClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.raidMenuClicked();
      }
      
      private function onKinClicked(param1:Event) : void
      {
         screensM.addScreen(BMScreensManager.SCR_KIN_SHOP);
         screensM.screenKinShop.refreshScreen(screensM.screenKinShop.TAB_SHOP);
      }
      
      public function raidClickedSub() : void
      {
         screensM.addScreen(BMScreensManager.SCR_RAID_MENU);
      }
      
      private function refreshChainDiscountTimer() : void
      {
         this.mcChainDiscountTimer.visible = false;
         var _loc1_:Array = dataM.chainDiscountsResolver.getActiveChainDiscountGachaMachineIDs();
         if(_loc1_.length == 0)
         {
            return;
         }
         var _loc2_:uint = uint(_loc1_[0]);
         var _loc3_:BMGachaMachineData = dataM.getGacheMachine(_loc2_);
         if(_loc3_.isInChainDiscount == false)
         {
            return;
         }
         this.mcChainDiscountTimer.visible = true;
         var _loc4_:uint = dataM.chainDiscountsResolver.getCurrentDiscount(_loc2_);
         this.mcChainDiscountTimer.initialize(this.getChainDiscountSecondsLeft,this.chainDiscountTimeEnded);
         this.mcChainDiscountTimer.setTitle(_loc4_ + "%");
      }
      
      private function getChainDiscountSecondsLeft() : uint
      {
         var _loc1_:Array = dataM.chainDiscountsResolver.getActiveChainDiscountGachaMachineIDs();
         var _loc2_:uint = uint(_loc1_[0]);
         return dataM.chainDiscountsResolver.getActiveChainDiscountSecondsLeft(_loc2_);
      }
      
      private function chainDiscountTimeEnded() : void
      {
         this.mcChainDiscountTimer.visible = false;
      }
      
      public function vipAccountUpdated(param1:String, param2:Object) : void
      {
         this.tryToShowVIPSubscriptionPopup();
      }
      
      private function showVIPSubscriptionClaimReward() : void
      {
         screensM.addScreen(BMScreensManager.SCR_VIP_SUBSCRIPTION_STATUS);
         screensM.screenVIPSubscriptionStatus.showClaim(this.vipSubscriptionBonusClaimed);
      }
      
      private function vipSubscriptionBonusClaimed() : void
      {
         remoteM.socketM.lobby_tokensRefresh();
      }
      
      private function tryToShowVIPSubscriptionPopup() : void
      {
         if(dataM.vipAccountData.vipReward != null)
         {
            this.showVIPSubscriptionClaimReward();
            dataM.vipAccountData.resetReward();
         }
         this.mcVIPSubscriptionIndicator.visible = false;
         if(dataM.vipAccountData.isVIPAccountActive == false)
         {
            return;
         }
         this.mcVIPSubscriptionIndicator.visible = true;
         this.mcVIPSubscriptionIndicator.addEventListener(MouseEvent.CLICK,this.vipSubscriptionIndicatorClicked);
         this.removeVIPSubscriptionTimer();
         if(dataM.isPremiumAccountActive() == false)
         {
            return;
         }
         var _loc1_:uint = 10000;
         if(dataM.clientRunningLocally)
         {
            _loc1_ = 1000;
         }
         this._vipSubscriptionIndicatorTimer = new Timer(_loc1_);
         this._vipSubscriptionIndicatorTimer.addEventListener(TimerEvent.TIMER,this.onVIPSubscriptionTimerTrigger);
         this._vipSubscriptionIndicatorTimer.start();
         this.refreshPremiumAndVIPSubscription();
      }
      
      private function removeVIPSubscriptionTimer() : void
      {
         if(this._vipSubscriptionIndicatorTimer == null)
         {
            return;
         }
         this._vipSubscriptionIndicatorTimer.stop();
         this._vipSubscriptionIndicatorTimer.removeEventListener(TimerEvent.TIMER,this.onVIPSubscriptionTimerTrigger);
         this._vipSubscriptionIndicatorTimer = null;
      }
      
      private function onVIPSubscriptionTimerTrigger(param1:TimerEvent) : void
      {
         this.refreshPremiumAndVIPSubscription();
      }
      
      private function refreshPremiumAndVIPSubscription() : void
      {
         if(this.mcVIPSubscriptionIndicator.visible)
         {
            this.mcVIPSubscriptionIndicator.visible = false;
            this.mcPremiumTimer.visible = true;
         }
         else
         {
            this.mcVIPSubscriptionIndicator.visible = true;
            this.mcPremiumTimer.visible = false;
         }
      }
      
      private function vipSubscriptionIndicatorClicked(param1:MouseEvent) : void
      {
         screensM.addScreen(BMScreensManager.SCR_VIP_SUBSCRIPTION_STATUS);
         screensM.screenVIPSubscriptionStatus.showTimer();
      }
      
      public function refreshFreePackagesCounter() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         this.mcShopCounter.visible = false;
         if(dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc2_ = BMShopManager.gi().getFreePackagesAmount(true);
            if(!tutorialM.isTutorialActive() && _loc2_ > 0)
            {
               _loc3_ = "9+";
               if(_loc2_ < 9)
               {
                  _loc3_ = String(_loc2_);
               }
               this.mcShopCounter.visible = true;
               this.mcShopCounter.text = _loc3_;
            }
         }
      }
      
      public function refreshStarterPackMechCounter() : void
      {
         this.mcMechStarterPackIndicator.visible = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL)
         {
            return;
         }
         if(dataM.myProfile.pendingStarterPackMech == 0)
         {
            return;
         }
         this.mcMechStarterPackIndicator.visible = true;
         this.onCompleteStarterPackIndicatorSizeDecrease(true);
         this.mcMechStarterPackIndicator.addEventListener(MouseEvent.CLICK,this.mechStarterPackIndicatorClicked);
      }
      
      private function refreshPVPHighRewardsCounter() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         this.mcPVPHighRewardsCounter.visible = false;
         if(!tutorialM.isTutorialActive())
         {
            _loc1_ = dataM.getGeneralSetting("minPlayerLevelForPvPRewardsCounterInMainMenu",-1);
            if(_loc1_ >= 0 && _loc1_ <= dataM.myProfile.level)
            {
               _loc2_ = dataM.pvpWinningRewardPredictionData.highRewardsLeftToday;
               if(_loc2_ > 0)
               {
                  this.mcPVPHighRewardsCounter.text = String(_loc2_);
                  this.mcPVPHighRewardsCounter.visible = true;
               }
            }
         }
      }
      
      private function initBaseNotifications() : void
      {
         this.mcBaseNotification_gold.mouseEnabled = false;
         this.mcBaseNotification_gold.mouseChildren = false;
         this.mcBaseNotification_items.mouseEnabled = false;
         this.mcBaseNotification_items.mouseChildren = false;
         this._baseNotificationOriginXPos_gold = this.mcBaseNotification_gold.x;
         this._baseNotificationOriginXPos_items = this.mcBaseNotification_items.x;
      }
      
      private function refreshBaseCounter() : void
      {
         this.mcBaseNotification_gold.visible = false;
         this.mcBaseNotification_items.visible = false;
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         if(dataM.baseBuildingManager.isEnabled == false)
         {
            return;
         }
         if(BMBaseBuildingNotificationHelper.shouldShowMainMenuGoldBadge())
         {
            this.mcBaseNotification_gold.visible = true;
         }
         if(BMBaseBuildingNotificationHelper.shouldShowMainMenuItemsBadge())
         {
            this.mcBaseNotification_items.visible = true;
            if(this.mcBaseNotification_gold.visible)
            {
               this.mcBaseNotification_items.x = this._baseNotificationOriginXPos_items;
            }
            else
            {
               this.mcBaseNotification_items.x = this._baseNotificationOriginXPos_gold;
            }
         }
      }
      
      private function refreshClanBadgesAndIndicators() : void
      {
         this.mcClanRewardAvailable.visible = false;
         this.mcClanWarBattlesLeft.visible = false;
         this.mcClanWarJoinBadge.visible = false;
         if(dataM.myProfile.clanID <= 0)
         {
            return;
         }
         var _loc1_:uint = BMShopManager.gi().getFreePackagesAmount(false,true);
         if(dataM.clanWarsM.hasPendingReward || dataM.myProfile.hasClanBossReward || _loc1_ > 0)
         {
            this.mcClanRewardAvailable.visible = true;
            return;
         }
         if(dataM.clanWarsM.isFeatureEnabled == false)
         {
            return;
         }
         if(dataM.clanWarsM.didIJoin)
         {
            if(dataM.clanWarsM.isWarPhase)
            {
               if(dataM.clanWarsM.attacksLeft > 0)
               {
                  this.mcClanWarBattlesLeft.text = String(dataM.clanWarsM.attacksLeft);
                  this.mcClanWarBattlesLeft.visible = true;
               }
            }
         }
         else if(dataM.clanWarsM.isPreparationPhase)
         {
            this.mcClanWarJoinBadge.visible = true;
         }
      }
      
      private function refreshMinedTokensIndicator() : void
      {
         this.mcMinedTokensIndicator.visible = false;
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         if(dataM.minedTokens_showIndicatorInShopTab)
         {
            this.mcMinedTokensIndicator.visible = true;
            return;
         }
         if(BMMiningManager.isAvailable() == false)
         {
            return;
         }
         if(dataM.minedTokens_mainMenuAvailabilityChecks > 0)
         {
            return;
         }
         dataM.minedTokens_mainMenuAvailabilityChecks += 1;
         sub(BMPubSub.MINING_GOT_USER_DATA,this.gotMinedTokensUserData);
         BMMiningManager.getAvailableToClaimTokensCount();
      }
      
      private function gotMinedTokensUserData(param1:String, param2:BMMineUserData) : void
      {
         if(param2.tokens == 0)
         {
            return;
         }
         dataM.minedTokens_showIndicatorInShopTab = true;
         this.mcMinedTokensIndicator.visible = true;
      }
      
      private function onCompleteStarterPackIndicatorSizeIncrease() : void
      {
         TweenMax.to(this.mcMechStarterPackIndicator,0.3,{
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.onCompleteStarterPackIndicatorSizeDecrease
         });
      }
      
      private function onCompleteStarterPackIndicatorSizeDecrease(param1:Boolean = false) : void
      {
         var _loc2_:Number = 0.5;
         if(param1)
         {
            _loc2_ = 0;
         }
         TweenMax.to(this.mcMechStarterPackIndicator,0.3,{
            "delay":_loc2_,
            "scaleX":1.2,
            "scaleY":1.2,
            "onComplete":this.onCompleteStarterPackIndicatorSizeIncrease
         });
      }
      
      private function mechStarterPackIndicatorClicked(param1:MouseEvent) : void
      {
         this.onWorkshopButtonHitSub();
      }
      
      private function removeMechStarterPackIndicator() : void
      {
         this.mcMechStarterPackIndicator.removeEventListener(MouseEvent.CLICK,this.mechStarterPackIndicatorClicked);
         TweenMax.killTweensOf(this.mcMechStarterPackIndicator);
      }
      
      public function refreshUpgradeCounter() : void
      {
         this.mcUpgradeCounter.visible = false;
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         var _loc1_:Array = dataM.getRecommendedBoostMaterialPlayerItemIDs();
         if(_loc1_.length == 0)
         {
            return;
         }
         this.mcUpgradeCounter.text = String(_loc1_.length);
         this.mcUpgradeCounter.visible = true;
      }
      
      private function refreshMultiplayerCallToActionTutorialArrow() : void
      {
         var _loc1_:MovieClip = null;
         if(BMMultiplayerCallToActionHelper.shouldDirectPlayerToMultiplayer())
         {
            _loc1_ = this.mcArenaButton;
            this._tutorialArrowController.activateTutorialArrow(this,_loc1_.x + _loc1_.width / 2,_loc1_.y + _loc1_.height / 3,-90,10);
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen();
         this.mcQuestsMiniPanel.notifyClientDataReloaded();
      }
      
      private function onRemoved(param1:Event) : void
      {
         if(this._carouselAnimator.getItemByIndex(this._carouselAnimator.selectedIndex).hasOwnProperty("mechID"))
         {
            dataM.mainMenuLastMechID = this._carouselAnimator.getItemByIndex(this._carouselAnimator.selectedIndex)["mechID"];
            dataM.mainMenuLastMechDisplayPowerRating = dataM.myPlayerData.getMechDisplayPowerRating(dataM.mainMenuLastMechID);
         }
         this.removeAllSnowFlakes();
         TweenMax.killTweensOf(this);
         this.removeMechStarterPackIndicator();
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         screensM.removeScreen(BMScreensManager.SCR_TOP_BAR);
         this._initTimeLine.kill();
         screensM.removeScreen(BMScreensManager.SCR_QUESTS);
         BMSpecialOffersManager.gi().removeSpecialOffer();
      }
      
      private function getCurrentMechOrder() : Array
      {
         if(this._carouselAnimator.selectedIndex > 0)
         {
            if(BMUnlockedMechSlotsResolver.getNumberOfMechsUnlocked() == 2)
            {
               return [0,2,1,3,4,5,6];
            }
         }
         if(this._carouselAnimator.selectedIndex == 1)
         {
            return [0,3,1,2,4,5,6];
         }
         if(this._carouselAnimator.selectedIndex == 2)
         {
            return [0,2,3,1,4,5,6];
         }
         return null;
      }
      
      private function supportClicked(param1:Event) : void
      {
         dataM.openSupportForm("In Game Super Mechs Beta Feedback");
      }
      
      private function resetAccountClicked(param1:Event) : void
      {
         screensM.screenConfirmation.displayCustomYesNoQuestion("Are you sure you want to reset your account?<BR>All progress will be lost!",this.resetAccountYesNoHandler);
      }
      
      private function onExitBetaClick(param1:MouseEvent) : void
      {
         dataM.goToDownloadOldClintPage();
      }
      
      private function resetAccountYesNoHandler(param1:Boolean) : void
      {
         if(param1)
         {
            remoteM.socketM.beta_resetAccount();
         }
      }
      
      private function handleFreePackagesUpdated(param1:String, param2:Object) : *
      {
         this.refreshFreePackagesCounter();
      }
      
      private function handleShopClosed(param1:String, param2:Object) : *
      {
         this.tryToShowVIPSubscriptionPopup();
         this.refreshFreePackagesCounter();
         this.refreshUpgradeCounter();
         this.refreshChainDiscountTimer();
         this.refreshMinedTokensIndicator();
      }
      
      private function handleAppActivated(param1:String, param2:Object) : void
      {
         this.checkForMarketingGifts();
      }
      
      private function handleMechEquipmentChanged(param1:String, param2:Object) : *
      {
         var _loc3_:BMScreensManager = screensM;
         _loc3_.removeScreen(BMScreensManager.SCR_MAIN_MENU);
         _loc3_.addScreen(BMScreensManager.SCR_MAIN_MENU);
         _loc3_.screenMainMenu.refreshScreen();
      }
      
      private function specialEventImageHandler() : void
      {
         var _loc1_:String = dataM.getGeneralSetting("specialEventImagesData","");
         if(_loc1_ == "")
         {
            return;
         }
         var _loc2_:Object = JSON.parse(_loc1_);
         if(_loc2_.mainMenu == null)
         {
            return;
         }
         if(_loc2_.mainMenu == "")
         {
            return;
         }
         if(dataM.currentTime < _loc2_.startTime)
         {
            return;
         }
         if(dataM.currentTime > _loc2_.startTime + _loc2_.durationInHours * 3600)
         {
            return;
         }
         var _loc3_:MovieClip = externalAssetsM.getAsset("general",_loc2_.mainMenu);
         this.mcSpecialEventImageHolder.addChild(_loc3_);
      }
      
      private function checkForPopupsAfterInit(param1:String, param2:Object) : void
      {
         var _loc3_:Boolean = this.openClanSettingsIfNeeded();
         if(_loc3_)
         {
            return;
         }
         if(dataM.baseBuildingManager.shouldShowEnableBaseBuildingDialogInMainMenu)
         {
         }
         BMNukesResolver.gi().displayNukesMaxedPopup();
      }
      
      private function openClanSettingsIfNeeded(param1:String = "", param2:Object = null) : Boolean
      {
         if(dataM.myProfile.clanID <= 0)
         {
            return false;
         }
         if(dataM.myProfile.isClanLeader == false)
         {
            return false;
         }
         if(dataM.myProfile.clanFlag != "")
         {
            return false;
         }
         this.clanClicked();
         return true;
      }
      
      private function onBaseClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.baseBuildingClicked();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.mcVIPSubscriptionIndicator.removeEventListener(MouseEvent.CLICK,this.vipSubscriptionIndicatorClicked);
         this.removeVIPSubscriptionTimer();
         while(this._mechViews.length > 0)
         {
            this._mechViews.pop().removeMe();
         }
      }
      
      private function initSnowFlakes() : void
      {
         var _loc4_:Sprite = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc1_:String = dataM.getGeneralSetting("snowFlakesData","");
         if(_loc1_ == "")
         {
            return;
         }
         var _loc2_:Object = JSON.parse(_loc1_);
         if(dataM.currentTime < _loc2_.startTime)
         {
            return;
         }
         if(dataM.currentTime > _loc2_.startTime + _loc2_.durationInDays * 86400)
         {
            return;
         }
         this.snowFlakes = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < this.snowFlakesTotal)
         {
            if(_loc2_.effect == "leaves")
            {
               _loc8_ = Math.ceil(Math.random() * 4);
               if(_loc8_ == 1)
               {
                  _loc4_ = new mcLeaf1();
               }
               else if(_loc8_ == 2)
               {
                  _loc4_ = new mcLeaf2();
               }
               else if(_loc8_ == 3)
               {
                  _loc4_ = new mcLeaf3();
               }
               else
               {
                  _loc4_ = new mcLeaf4();
               }
               _loc4_.rotation = -30 + Math.random() * 60;
               if(Math.ceil(Math.random() * 2) == 1)
               {
                  _loc4_.scaleX *= -1;
               }
            }
            else
            {
               _loc4_ = new mcSnowFlake();
               _loc4_.rotation = Math.random() * 360;
            }
            _loc5_ = 0.3 + Math.random() * 0.9;
            _loc4_.scaleX *= _loc5_;
            _loc4_.scaleY *= _loc5_;
            _loc4_.x = 70 + Math.random() * (dataM.STAGE_WIDTH - 140);
            _loc4_.y = -50;
            this.mcSnowFlakesHolder.addChild(_loc4_);
            _loc6_ = Math.random() * this.snowFlakesTotal * 2;
            _loc7_ = "right";
            if(Math.ceil(Math.random() * 2) == 1)
            {
               _loc7_ = "left";
            }
            this.snowFlakeOnComplete(_loc4_,_loc7_,_loc6_);
            this.snowFlakes.push(_loc4_);
            _loc3_++;
         }
      }
      
      private function snowFlakeOnComplete(param1:Sprite, param2:String, param3:Number = 0) : void
      {
         var _loc4_:Number = param1.x + 200;
         var _loc5_:String = "right";
         var _loc6_:Number = param1.rotation + 30;
         if(param2 == "right")
         {
            _loc5_ = "left";
            _loc4_ = param1.x - 200;
            _loc6_ = param1.rotation - 30;
         }
         if(param1.y > dataM.STAGE_HEIGHT)
         {
            param1.y -= dataM.STAGE_HEIGHT + 50;
         }
         TweenMax.to(param1,4,{
            "delay":param3,
            "rotation":_loc6_,
            "x":_loc4_,
            "ease":Power2.easeInOut,
            "onComplete":this.snowFlakeOnComplete,
            "onCompleteParams":[param1,_loc5_]
         });
         TweenMax.to(param1,1,{
            "delay":param3,
            "y":param1.y + 25,
            "ease":Power1.easeIn
         });
         TweenMax.to(param1,2.95,{
            "delay":param3 + 1,
            "y":param1.y + 50,
            "ease":Back.easeOut.config(3)
         });
      }
      
      private function removeAllSnowFlakes() : void
      {
         var _loc2_:Sprite = null;
         if(this.snowFlakes == null)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this.snowFlakes.length)
         {
            _loc2_ = this.snowFlakes[_loc1_];
            TweenMax.killTweensOf(_loc2_);
            _loc2_.parent.removeChild(_loc2_);
            _loc2_ = null;
            _loc1_++;
         }
         this.snowFlakes = new Array();
      }
   }
}

BMPremiumTimer;

