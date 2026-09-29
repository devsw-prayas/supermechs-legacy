package net.battleMechsMulti.screens.itemCards
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.greensock.easing.Sine;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMItemCard;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.inventoryGracePeriodInfo.BMInventoryGracePeriodTimer;
   import net.battleMechsMulti.utils.BMPubSub;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1315")]
   public class BMScreenItemCards extends BMBaseScreen
   {
      
      private static const LIGHT_STATUS_ENTER:String = "enter";
      
      private static const LIGHT_STATUS_SHRINK:String = "shrink";
      
      private static const LIGHT_STATUS_EXPAND:String = "expand";
      
      public var mcEffectsHolder:MovieClip;
      
      public var mcBoxHolder:MovieClip;
      
      public var mcBoxReflectionHolder:Sprite;
      
      public var mcCardsHolder:Sprite;
      
      public var mcItemInfoHolder:Sprite;
      
      public var mcTinyCardsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcLightsHolder:Sprite;
      
      public var mcItemBoxClickHitArea:Sprite;
      
      public var mcTutorialArrow_card:MovieClip;
      
      public var mcTutorialMarker_card:MovieClip;
      
      public var mcTutorialArrow_button:MovieClip;
      
      public var mcTutorialMarker_button:MovieClip;
      
      public var mcSkipAnimationMouseHitArea:Sprite;
      
      public var mcSizer_btnOK:Sprite;
      
      public var btnOK:BMButton;
      
      public var mcTitle:MovieClip;
      
      public var mcFinger:Sprite;
      
      public var mcBackgroundLeft:Sprite;
      
      public var mcBackgroundRight:Sprite;
      
      public var mcBoxReflectionCover:Sprite;
      
      public var mcBoxGlow:Sprite;
      
      public var mcGfxCover:Sprite;
      
      private var _itemIDs:Array;
      
      private var _playerItemIDs:Array;
      
      private var _itemCards:Array;
      
      private var _hasEpicItems:Boolean;
      
      private var _hasLegendaryOrMythItems:Boolean;
      
      private var _boxAnimationActive:Boolean;
      
      private var _boxAnimationStatus:String;
      
      private var _boxCardCounter:uint;
      
      private var _boxCards:Array;
      
      private var _movingCards:Boolean;
      
      private var _frameCounterBox:Number;
      
      private var _frameCounterCards:Number;
      
      private var _tutorialFrameCounter:Number;
      
      private var _titleOriginYPos:Number;
      
      private var _itemCardsClicked:Array;
      
      private var _itemCardsFlipped:Array;
      
      private var _backgroundLeftInitialXPos:Number;
      
      private var _backgroundRightInitialXPos:Number;
      
      private var _sparks:Array = new Array();
      
      private var _packageID:uint;
      
      private var mcBox:MovieClip;
      
      private var mcBoxReflection:MovieClip;
      
      private var _cardsTargetXPos:Array;
      
      private var _cardsStillMoving:uint;
      
      private var _itemCardLights:Array;
      
      private var _clickToOpen:Boolean = false;
      
      private var _fingerOriginXPos:Number;
      
      private var _fingerOriginYPos:Number;
      
      private var _fingerFrameCounter:uint;
      
      private var _mcCoverTargetYPos:Number;
      
      private var _insertExtraCard:Boolean = false;
      
      private var _highestRarity:int;
      
      private var _showWatchVideoPopupDisplayed:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      public var closingScreen:Boolean = false;
      
      private const CARDS_DISTANCE_FROM_BORDER:Number = 15;
      
      private const CARD_X_DISTANCE:Number = 6;
      
      private const CARD_WIDTH:Number = 150;
      
      private const CARD_HEIGHT:Number = 230;
      
      private const CARD_Y_START:Number = -585;
      
      private const FRAMES_FOR_TUTORIAL_POINTER:uint = 90;
      
      private const BOX_TARGET_Y_POS:uint = 370;
      
      private const DELAY_FRAMES_BETWEEN_CARDS:Number = 2;
      
      private const OK_BUTTON_Y_JUMP:Number = 100;
      
      private const TITLE_Y_JUMP:Number = 100;
      
      private var _didTriggerSkipAnimation:Boolean = false;
      
      private var _extraCardID:int = -1;
      
      private const ANIM_STATUS_FALL_DOWN:String = "fallDown";
      
      private const ANIM_STATUS_WAIT_BEFORE_OPEN:String = "waitBeforeOpen";
      
      private const ANIM_STATUS_OPEN:String = "open";
      
      private const ANIM_STATUS_SHOOT_CARDS:String = "shootCards";
      
      private const ANIM_STATUS_RAFFLE:String = "raffle";
      
      private var _raffleAnimLight:int = -1;
      
      public function BMScreenItemCards()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("itemCards");
         sub(BMPubSub.MESSAGE_SCREENS_DIRECTOR_STARTED_PERFORMING_TASKS,this.screensDirectorStartedPerformingTasks);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function refreshScreen(param1:Array, param2:Array, param3:Number = 0, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc7_:Function = null;
         var _loc8_:BMInventoryGracePeriodTimer = null;
         var _loc9_:BMItemData = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_ITEM_CARDS,"btnOK","regular");
            _loc7_ = this.OKClicked;
            if(dataM.runAsMobile)
            {
               _loc7_ = null;
               this.btnOK.changeFontSize(34);
            }
            else
            {
               this.btnOK.changeFontSize(33);
            }
            this.btnOK.initialize("","blue",null,null,_loc7_,dataM.runAsMobile);
            this.btnOK.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnOK.setButtonName("OK");
            updateTextAndFormat(this.mcTitle.txtTitle,getScreenText("title"));
            _loc8_ = this.mcTitle.mcInventoryGracePeriodTimer;
            _loc8_.activateTimer();
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("itemCards_title",[this.mcTitle.txtTitle],"",this.mcTitle);
            }
            this._titleOriginYPos = this.mcTitle.y;
            this.mcTutorialArrow_card.mouseEnabled = false;
            this.mcTutorialArrow_card.mouseChildren = false;
            this.mcTutorialMarker_card.mouseEnabled = false;
            this.mcTutorialMarker_card.mouseChildren = false;
            this.mcTutorialArrow_button.mouseEnabled = false;
            this.mcTutorialArrow_button.mouseChildren = false;
            this.mcTutorialMarker_button.mouseEnabled = false;
            this.mcTutorialMarker_button.mouseChildren = false;
            this.mcEffectsHolder.mouseEnabled = false;
            this.mcEffectsHolder.mouseChildren = false;
            this._backgroundLeftInitialXPos = this.mcBackgroundLeft.x;
            this._backgroundRightInitialXPos = this.mcBackgroundRight.x;
            this._firstRefresh = false;
         }
         this.closingScreen = false;
         this._itemIDs = param1;
         this._hasLegendaryOrMythItems = false;
         this._hasEpicItems = false;
         var _loc6_:uint = 0;
         while(_loc6_ < this._itemIDs.length)
         {
            _loc9_ = dataM.itemsDB[this._itemIDs[_loc6_]];
            if(_loc9_.specialStatus == ItemRarityResolver.RARITY_EPIC)
            {
               this._hasEpicItems = true;
            }
            if(_loc9_.specialStatus == ItemRarityResolver.RARITY_LEGENDARY || _loc9_.specialStatus == ItemRarityResolver.RARITY_MYTHICAL)
            {
               this._hasLegendaryOrMythItems = true;
            }
            if(this._hasEpicItems || this._hasLegendaryOrMythItems)
            {
               _loc6_ = this._itemIDs.length;
            }
            _loc6_++;
         }
         this._playerItemIDs = param2;
         this._packageID = param3;
         this._clickToOpen = param4;
         this._itemCards = new Array();
         this._itemCardLights = new Array();
         this._frameCounterBox = 0;
         this._frameCounterCards = 0;
         this._tutorialFrameCounter = 0;
         this._insertExtraCard = param5;
         this.mcBoxGlow.visible = false;
         this.mcBoxGlow.scaleX = 0.05;
         this.mcBoxGlow.scaleY = 0.05;
         this.mcBoxReflectionCover.visible = true;
         this.btnOK.enableMe();
         if(BMGameShortcutsHelper.screenItemCardsShortcut())
         {
            this.btnOK.visible = true;
         }
         else
         {
            this.btnOK.visible = false;
         }
         this.mcBackgroundLeft.x = this._backgroundLeftInitialXPos;
         this.mcBackgroundRight.x = this._backgroundRightInitialXPos;
         this.mcTitle.y = this._titleOriginYPos;
         this.btnOK.y = this.mcSizer_btnOK.y;
         this.mcFinger.mouseEnabled = false;
         this.mcFinger.mouseChildren = false;
         this.mcFinger.visible = false;
         if(this._clickToOpen && dataM.runAsMobile == false)
         {
            this.mcItemBoxClickHitArea.addEventListener(MouseEvent.CLICK,this.itemBoxClicked);
         }
         this._fingerOriginXPos = this.mcFinger.x;
         this._fingerOriginYPos = this.mcFinger.y;
         this._boxAnimationActive = false;
         this._movingCards = false;
         if(tutorialM.isTutorialActive())
         {
            this.mcSkipAnimationMouseHitArea.visible = false;
         }
         else
         {
            this.mcSkipAnimationMouseHitArea.addEventListener(MouseEvent.CLICK,this.skipAnimationHitAreaClicked);
         }
         this.sortItemOrder();
         this.createBox();
         this._didTriggerSkipAnimation = false;
      }
      
      private function sortItemOrder() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         if(this.getMaxCardRows() > 1)
         {
            _loc1_ = new Array();
            _loc2_ = 0;
            while(_loc2_ < this._itemIDs.length)
            {
               _loc1_.push(_loc2_);
               _loc2_++;
            }
            _loc1_.sort(this.compareItemIndices);
            _loc3_ = new Array();
            _loc4_ = new Array();
            _loc2_ = 0;
            while(_loc2_ < this._itemIDs.length)
            {
               _loc3_.push(this._itemIDs[_loc1_[_loc2_]]);
               _loc4_.push(this._playerItemIDs[_loc1_[_loc2_]]);
               _loc2_++;
            }
            this._itemIDs = _loc3_;
            this._playerItemIDs = _loc4_;
         }
      }
      
      private function compareItemIndices(param1:int, param2:int) : *
      {
         var _loc3_:BMItemData = dataM.itemsDB[this._itemIDs[param1]];
         var _loc4_:BMItemData = dataM.itemsDB[this._itemIDs[param2]];
         return _loc3_.specialStatus - _loc4_.specialStatus;
      }
      
      private function skipAnimationHitAreaClicked(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Sprite = null;
         if(this._boxAnimationActive == false || this.isFortuneBox())
         {
            return;
         }
         if(this._boxCards.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this._boxCards.length)
            {
               _loc3_ = this._boxCards[_loc2_];
               _loc3_.visible = false;
               _loc2_++;
            }
         }
         if(this.mcBox != null)
         {
            this.mcBox.visible = false;
            this.mcBoxGlow.visible = false;
            this.mcBoxReflection.visible = false;
            this.mcBoxReflectionCover.visible = false;
         }
         this.createItemCards();
         this._boxAnimationActive = false;
         this.mcSkipAnimationMouseHitArea.visible = false;
         this._didTriggerSkipAnimation = true;
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         this.sparksHandler();
         this.cardsMotionHandler();
         this.boxMotionHandler();
         this.itemCardLightsHandler();
      }
      
      public function itemCardClicked(param1:uint) : void
      {
         var _loc2_:BMItemCard = this._itemCards[param1];
         if(this.isRewardedVideoDialogInProgress())
         {
            _loc2_.readdClickEvent();
            screensM.screenYesNoPopup.activateGuideArrow(screensM.screenYesNoPopup.btnYes);
            return;
         }
         if(_loc2_.isLegendaryOrBetter == false)
         {
            soundM.createSound("buttonClick",1);
         }
         this.mcTutorialArrow_card.gotoAndStop("animOff");
         this.mcTutorialMarker_card.gotoAndStop("animOff");
         this._tutorialFrameCounter = 0;
         this._itemCardsClicked[param1] = true;
         dataM.trackEvent(BMDataManager.ANALYTICS_PRIORITY_LOWEST,"Items","OpenCard",param1.toString(),this._itemIDs[param1]);
         this.insertExtraCard();
      }
      
      private function insertExtraCard() : void
      {
         if(this._insertExtraCard == false)
         {
            return;
         }
         if(this.areAllCardsFlipped() == false)
         {
            return;
         }
         if(this.shouldAutoFlipCards)
         {
            this._cardsStillMoving = 1;
            this._movingCards = true;
         }
         this._insertExtraCard = false;
         this._extraCardID = this._itemIDs.length;
         this._itemIDs[this._extraCardID] = 0;
         this.createSpecificItemCard(this._extraCardID);
         this.recalculateAllCardsTargetXPos();
      }
      
      private function areAllCardsFlipped() : Boolean
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemCardsClicked.length)
         {
            if(this._itemCardsClicked[_loc1_] == false)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function get itemCards() : Array
      {
         return this._itemCards;
      }
      
      private function createBox() : void
      {
         var _loc3_:BMGachaMachineData = null;
         this._boxCards = new Array();
         var _loc1_:uint = this._packageID;
         if(dataM.hasGacheMachine(this._packageID))
         {
            _loc3_ = dataM.getGacheMachine(this._packageID);
            if(_loc3_.isSingleItem)
            {
               _loc1_ = BMShopManager.MIX_BOX_VISUAL_ID;
            }
            else
            {
               _loc1_ = _loc3_.imageID;
            }
         }
         if(this._packageID == BMShopManager.FREE_ITEM_BOX_ID && BMShopManager.gi().isTimedBoxFortuneBox())
         {
            _loc1_ = BMShopManager.FORTUNE_BOX_VISUAL_ID;
            BMShopManager.gi().unsetNextTimedBoxToBeFortuneBox();
         }
         var _loc2_:Array = BMShopManager.gi().getBoxGrpForVisualID(_loc1_,this._packageID);
         this.mcBox = _loc2_[0];
         this.mcBoxReflection = _loc2_[1];
         this._highestRarity = this.culcItemsHighestRarity();
         if(this._highestRarity == 0)
         {
            this.mcBox.mcInnerGlow.visible = false;
            this.mcBox.mcOuterGlow.visible = false;
         }
         else
         {
            this.mcBox.mcInnerGlow.visible = true;
            this.mcBox.mcOuterGlow.visible = true;
            this.mcBox.mcInnerGlow.gotoAndStop(this._highestRarity);
            this.mcBox.mcOuterGlow.gotoAndStop(this._highestRarity);
         }
         this.mcBox.x = 400;
         this.mcBox.y = -100;
         this.mcBoxReflection.x = 400;
         this.mcBoxReflection.y = 840;
         this.mcBox.mcOuterGlow.visible = false;
         this.mcBox.mcOuterGlow.scaleX = 0.05;
         this.mcBox.mcOuterGlow.scaleY = 0.05;
         this.mcBoxReflectionCover.y = this.BOX_TARGET_Y_POS - 1;
         this.mcBoxReflectionHolder.addChild(this.mcBoxReflection);
         this._mcCoverTargetYPos = this.mcBox.mcCover.y - 32;
         this.mcBoxHolder.addChild(this.mcBox);
         this._frameCounterBox = 0;
         this._boxAnimationStatus = this.ANIM_STATUS_FALL_DOWN;
         this._boxAnimationActive = true;
         if(this.isFortuneBox())
         {
            this.mcBox.mcSpark0.alpha = this.mcBox.mcSpark1.alpha = this.mcBox.mcSpark2.alpha = this.mcBox.mcSpark3.alpha = 0;
            this.mcBox.mcFlare0.alpha = this.mcBox.mcFlare1.alpha = this.mcBox.mcFlare2.alpha = this.mcBox.mcFlare3.alpha = 0;
         }
      }
      
      private function boxMotionHandler() : void
      {
         if(this._boxAnimationActive == false)
         {
            return;
         }
         var _loc1_:Boolean = false;
         switch(this._boxAnimationStatus)
         {
            case this.ANIM_STATUS_FALL_DOWN:
               this.itemBoxFallDownAnim();
               break;
            case this.ANIM_STATUS_WAIT_BEFORE_OPEN:
               this.itemBoxWaitBeforeOpen();
               break;
            case this.ANIM_STATUS_OPEN:
               this.itemBoxAnimOpen();
               _loc1_ = true;
               break;
            case this.ANIM_STATUS_SHOOT_CARDS:
               this.itemBoxAnimShootCards();
         }
         if(_loc1_)
         {
            if(this.mcBox.mcOuterGlow.scaleX < 1)
            {
               this.mcBox.mcOuterGlow.scaleX += 0.025;
               this.mcBox.mcOuterGlow.scaleY += 0.025;
            }
         }
         ++this._frameCounterBox;
      }
      
      private function itemBoxFallDownAnim() : void
      {
         this.mcBox.y += 40;
         this.mcBoxReflection.y -= 40;
         if(this._frameCounterBox == 1)
         {
            this.mcBoxGlow.visible = true;
         }
         if(this.mcBoxGlow.scaleX < 1)
         {
            this.mcBoxGlow.scaleX += 0.1;
            this.mcBoxGlow.scaleY += 0.1;
         }
         if(this.mcBox.y >= this.BOX_TARGET_Y_POS)
         {
            this.mcBox.y = this.BOX_TARGET_Y_POS;
            this.mcBoxReflection.y = this.BOX_TARGET_Y_POS;
            this._frameCounterBox = 0;
            soundM.createSound("footStep",1);
            if(this.isFortuneBox())
            {
               this.doBoxRaffleAnimation();
            }
            else
            {
               this._boxAnimationStatus = this.ANIM_STATUS_WAIT_BEFORE_OPEN;
            }
         }
      }
      
      private function itemBoxWaitBeforeOpen() : void
      {
         if(this._clickToOpen)
         {
            if(this._frameCounterBox >= 60)
            {
               if(this._frameCounterBox == 60)
               {
                  this._fingerFrameCounter = 0;
                  this.mcFinger.visible = true;
               }
               ++this._fingerFrameCounter;
               if(this._fingerFrameCounter <= 12)
               {
                  this.mcFinger.x += (12 - this._fingerFrameCounter) / 2;
                  this.mcFinger.y -= (12 - this._fingerFrameCounter) / 2;
               }
               else if(this._fingerFrameCounter <= 24)
               {
                  this.mcFinger.x -= (this._fingerFrameCounter - 12) / 2;
                  this.mcFinger.y += (this._fingerFrameCounter - 12) / 2;
               }
               else
               {
                  this._fingerFrameCounter = 0;
                  this.mcFinger.x = this._fingerOriginXPos;
                  this.mcFinger.y = this._fingerOriginYPos;
               }
            }
         }
         else if(this._frameCounterBox >= 10)
         {
            this._boxAnimationStatus = this.ANIM_STATUS_OPEN;
            this._frameCounterBox = 0;
            soundM.createSound("openBox",1);
         }
      }
      
      private function itemBoxAnimOpen() : void
      {
         if(this.mcBox.mcCover.y > this._mcCoverTargetYPos + 1)
         {
            this.mcBox.mcCover.y += (this._mcCoverTargetYPos - this.mcBox.mcCover.y) * 0.1;
         }
         else
         {
            this.mcBox.mcCover.y = this._mcCoverTargetYPos;
            this._boxAnimationStatus = this.ANIM_STATUS_SHOOT_CARDS;
            this._boxCardCounter = 0;
            this._frameCounterBox = 0;
         }
         if(this._frameCounterBox == 1 && this._highestRarity > 0)
         {
            this.mcBox.mcOuterGlow.visible = true;
         }
      }
      
      private function itemBoxAnimShootCards() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMItemData = null;
         var _loc4_:Sprite = null;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:Sprite = null;
         var _loc1_:Boolean = false;
         if(this._frameCounterBox == 1)
         {
            _loc1_ = true;
         }
         else if(this._itemIDs.length > 1 && this._boxCardCounter < this._itemIDs.length)
         {
            if(this._frameCounterBox == 1 + this._boxCardCounter * 3)
            {
               _loc1_ = true;
            }
         }
         if(this.mcBoxGlow.scaleX > 0.1)
         {
            this.mcBoxGlow.scaleX -= 0.1;
            this.mcBoxGlow.scaleY -= 0.1;
            if(this.mcBoxGlow.scaleX <= 0.1)
            {
               this.mcBoxGlow.visible = false;
            }
         }
         if(_loc1_)
         {
            _loc2_ = uint(this._itemIDs[this._boxCardCounter]);
            _loc3_ = dataM.itemsDB[_loc2_];
            _loc4_ = this.getItemCardMC(_loc3_.specialStatusForDisplay);
            _loc4_.scaleX = 0.55;
            _loc4_.scaleY = 0.55;
            this.getMaxCardRows();
            this.getMaxCardsInRow();
            _loc5_ = 0;
            if(this.getMaxCardsInRow() > 1)
            {
               _loc6_ = 25;
               _loc7_ = (this.getMaxCardsInRow() - 1) * _loc6_;
               _loc8_ = this._boxCardCounter % this.getMaxCardsInRow();
               _loc5_ = _loc8_ * _loc6_ - _loc7_ / 2;
            }
            _loc5_ -= _loc4_.width / 2;
            _loc4_.x = _loc5_;
            this._boxCards.push(_loc4_);
            this.mcBox.mcCardsHolder.addChild(_loc4_);
            soundM.createSound("cardFire",1);
            ++this._boxCardCounter;
         }
         if(this._boxCards.length > 0)
         {
            _loc9_ = 0;
            while(_loc9_ < this._boxCards.length)
            {
               _loc10_ = this._boxCards[_loc9_];
               if(_loc10_.y > -600)
               {
                  _loc10_.y -= 50;
                  if(_loc10_.y <= -600 && _loc10_.visible)
                  {
                     _loc10_.visible = false;
                  }
               }
               _loc9_++;
            }
         }
         if(this._frameCounterBox == this.frameToCreateItemCards())
         {
            this.createItemCards();
         }
         else if(this._frameCounterBox > this.frameToCreateItemCards())
         {
            if(this.mcBox.visible)
            {
               this.mcBox.scaleX -= 0.05;
               this.mcBox.scaleY -= 0.05;
               this.mcBoxReflection.scaleX -= 0.05;
               this.mcBoxReflection.scaleY += 0.05;
               if(this.mcBox.scaleX <= 0.05)
               {
                  this.mcBox.visible = false;
                  this.mcBoxReflection.visible = false;
                  this.mcBoxReflectionCover.visible = false;
                  this._boxAnimationActive = false;
                  this.mcSkipAnimationMouseHitArea.visible = false;
               }
            }
         }
      }
      
      private function frameToCreateItemCards() : uint
      {
         return 15 + this._itemIDs.length;
      }
      
      private function getItemCardMC(param1:uint) : Sprite
      {
         var _loc2_:Sprite = null;
         switch(param1)
         {
            case ItemRarityResolver.RARITY_COMMON:
               _loc2_ = new grpItemCardBack0();
               break;
            case ItemRarityResolver.RARITY_RARE:
               _loc2_ = new grpItemCardBack1();
               break;
            case ItemRarityResolver.RARITY_EPIC:
               _loc2_ = new grpItemCardBack2();
               break;
            case ItemRarityResolver.RARITY_LEGENDARY:
               _loc2_ = new grpItemCardBack3();
               break;
            case ItemRarityResolver.RARITY_MYTHICAL:
               _loc2_ = new grpItemCardBack4();
               break;
            case BMItemCard.EXTRA_CARD:
               _loc2_ = new grpItemCardBack4();
         }
         return _loc2_;
      }
      
      private function doBoxRaffleAnimation() : void
      {
         this._boxAnimationStatus = this.ANIM_STATUS_RAFFLE;
         this._raffleAnimLight = -1;
         var _loc1_:TimelineMax = new TimelineMax({"onComplete":this.onBoxRaffleAnimationComplete});
         _loc1_.fromTo(this,3.2,{"currentLight":0},{
            "currentLight":20 + this._highestRarity - 1,
            "ease":Sine.easeOut
         });
         _loc1_.to(this.mcBox["mcDark" + this._highestRarity],0.2,{"alpha":0},"+=0.5");
         _loc1_.to(this.mcBox["mcSpark" + this._highestRarity],0.2,{"alpha":1},"-=0.2");
         _loc1_.to(this.mcBox["mcFlare" + this._highestRarity],0.2,{"alpha":1});
         _loc1_.to(this.mcBox["mcFlare" + this._highestRarity],0.2,{"alpha":0});
      }
      
      public function get currentLight() : int
      {
         return this._raffleAnimLight;
      }
      
      public function set currentLight(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(this._raffleAnimLight == param1)
         {
            return;
         }
         this._raffleAnimLight = param1;
         var _loc2_:int = this._raffleAnimLight % 4;
         TweenMax.to(this.mcBox["mcDark" + _loc2_],0.15,{"alpha":0});
         TweenMax.to(this.mcBox["mcSpark" + _loc2_],0.15,{"alpha":1});
         TweenMax.to(this.mcBox["mcDark" + _loc2_],0.15,{
            "alpha":1,
            "delay":0.2
         });
         TweenMax.to(this.mcBox["mcSpark" + _loc2_],0.15,{
            "alpha":0,
            "delay":0.2
         });
      }
      
      private function onBoxRaffleAnimationComplete() : void
      {
         this._boxAnimationStatus = this.ANIM_STATUS_WAIT_BEFORE_OPEN;
      }
      
      private function itemBoxClicked(param1:MouseEvent) : void
      {
         this.itemBoxClickedSub();
      }
      
      public function itemBoxClickedSub() : void
      {
         if(this._boxAnimationStatus == this.ANIM_STATUS_WAIT_BEFORE_OPEN && this._clickToOpen)
         {
            this.mcFinger.visible = false;
            this._boxAnimationStatus = this.ANIM_STATUS_OPEN;
            this._frameCounterBox = 0;
            soundM.createSound("openBox",1);
            if(dataM.runAsMobile == false)
            {
               this.mcItemBoxClickHitArea.removeEventListener(MouseEvent.CLICK,this.itemBoxClicked);
            }
         }
      }
      
      public function waitingForBoxClick() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this._boxAnimationStatus == this.ANIM_STATUS_WAIT_BEFORE_OPEN && this._clickToOpen)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function createItemCards() : void
      {
         this.mcSkipAnimationMouseHitArea.visible = false;
         this._movingCards = true;
         this._itemCardsClicked = new Array();
         this._itemCardsFlipped = new Array();
         this._cardsTargetXPos = new Array();
         this._cardsStillMoving = this._itemIDs.length;
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemIDs.length)
         {
            this.createSpecificItemCard(_loc1_);
            _loc1_++;
         }
         this.setCardsHolderScale();
      }
      
      private function createSpecificItemCard(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc11_:BMItemCard = null;
         var _loc12_:Number = NaN;
         var _loc4_:BMItemCard = new BMItemCard();
         var _loc5_:Boolean = false;
         var _loc6_:uint = uint(this._itemIDs[param1]);
         if(_loc6_ > 0 && dataM.isPowerKit(_loc6_))
         {
            _loc5_ = true;
         }
         var _loc7_:Boolean = true;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = param1 == this._extraCardID;
         if(this.shouldAutoFlipCards && _loc9_ == false)
         {
            _loc7_ = false;
            _loc8_ = true;
         }
         _loc4_.initialize(param1,_loc6_,_loc5_,_loc7_,_loc8_);
         _loc4_.disableClicks();
         if(_loc4_.isEpicOrBetter || _loc9_)
         {
            _loc4_.addOuterGlow();
         }
         else
         {
            _loc4_.removeOuterGlow();
         }
         var _loc10_:Number = this.CARD_Y_START;
         if(this.getMaxCardRows() > 1)
         {
            _loc10_ *= 2;
         }
         _loc4_.y = _loc10_;
         if(this.shouldAutoFlipCards && _loc9_)
         {
            _loc11_ = this._itemCards[this._itemCards.length - 1];
            _loc12_ = _loc11_.targetXPos + this.CARD_WIDTH / 2;
            _loc4_.x = _loc12_;
            _loc4_.targetXPos = _loc12_;
            _loc4_.targetYPos = _loc11_.targetYPos;
         }
         else
         {
            _loc4_.x = this.getCardXPosition(param1);
            _loc4_.targetXPos = this.getCardXPosition(param1);
            _loc4_.targetYPos = this.getCardYTarget(param1);
         }
         if(_loc9_ == false && _loc4_.isEpicOrBetter && this.shouldAutoFlipCards)
         {
            _loc4_.activateItemAnimation();
            _loc4_.activateItemInnerGlow();
            _loc4_.switchOuterGlowToFrontMask();
         }
         this.mcCardsHolder.addChild(_loc4_);
         this._itemCards.push(_loc4_);
         this._itemCardsClicked[param1] = false;
         this._itemCardsFlipped[param1] = false;
         if(this.shouldAutoFlipCards && param1 != this._extraCardID)
         {
            this._itemCardsClicked[param1] = true;
            this._itemCardsFlipped[param1] = true;
         }
      }
      
      private function cardsMotionHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         var _loc3_:BMItemCard = null;
         if(this._movingCards == false)
         {
            return;
         }
         ++this._frameCounterCards;
         ++this._tutorialFrameCounter;
         if(this._tutorialFrameCounter == this.FRAMES_FOR_TUTORIAL_POINTER && this.isRewardedVideoDialogInProgress() == false)
         {
            _loc1_ = -1;
            _loc2_ = 0;
            while(_loc2_ < this._itemCardsClicked.length)
            {
               if(this._itemCardsClicked[_loc2_] == false)
               {
                  _loc1_ = _loc2_;
                  _loc2_ = this._itemCardsClicked.length;
               }
               _loc2_++;
            }
            if(_loc1_ > -1 && this._hasLegendaryOrMythItems == false)
            {
               _loc3_ = this._itemCards[_loc1_];
               this.mcTutorialArrow_card.x = this.mcCardsHolder.x + _loc3_.x;
               this.mcTutorialArrow_card.y = this.mcCardsHolder.y + _loc3_.y + _loc3_.fixedHeight;
               this.mcTutorialArrow_card.gotoAndStop("animOn");
               this.mcTutorialMarker_card.x = this.mcCardsHolder.x + _loc3_.x;
               this.mcTutorialMarker_card.y = this.mcCardsHolder.y + _loc3_.y;
               this.mcTutorialMarker_card.gotoAndStop("animOn");
            }
         }
         this.handleCardsXPosAlignment();
         this.handleCardsDropFromTopAnimation();
      }
      
      private function handleCardsXPosAlignment() : void
      {
         var _loc2_:BMItemCard = null;
         var _loc3_:Number = NaN;
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemCards.length)
         {
            _loc2_ = this._itemCards[_loc1_];
            _loc3_ = _loc2_.targetXPos - _loc2_.x;
            if(Math.abs(_loc3_) < 1)
            {
               _loc2_.x = _loc2_.targetXPos;
            }
            else
            {
               _loc2_.x += _loc3_ * 0.1;
            }
            _loc1_++;
         }
      }
      
      private function handleCardsDropFromTopAnimation() : void
      {
         var _loc2_:BMItemCard = null;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc7_:Boolean = false;
         var _loc8_:BMItemData = null;
         var _loc9_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemCards.length)
         {
            if(this._frameCounterCards >= _loc1_ * this.DELAY_FRAMES_BETWEEN_CARDS)
            {
               _loc2_ = this._itemCards[_loc1_];
               _loc3_ = 0.2;
               if(this._didTriggerSkipAnimation)
               {
                  _loc3_ = 0.3;
               }
               if(_loc2_.y < _loc2_.targetYPos)
               {
                  _loc2_.y += (_loc2_.targetYPos - _loc2_.y) * _loc3_;
                  if(Math.abs(_loc2_.y - _loc2_.targetYPos) <= 1)
                  {
                     if(this._cardsStillMoving > 0)
                     {
                        --this._cardsStillMoving;
                     }
                     else
                     {
                        trace("_cardsStillMoving already 0!");
                     }
                     _loc2_.y = _loc2_.targetYPos;
                     _loc2_.enableClicks();
                     _loc8_ = dataM.itemsDB[this._itemIDs[_loc1_]];
                     _loc9_ = 1;
                     if(_loc8_ != null)
                     {
                        _loc9_ = uint(_loc8_.specialStatusForDisplay);
                     }
                     this.createItemCardLight(_loc2_.x,_loc2_.y,_loc1_,_loc9_);
                  }
               }
               else if(this._itemCardsClicked[_loc1_] != false)
               {
                  if(this.shouldAutoFlipCards == false || _loc1_ == this._extraCardID)
                  {
                     this.handleItemCardFlipAnimation(_loc1_,_loc2_);
                  }
                  _loc4_ = true;
                  _loc5_ = false;
                  _loc6_ = 0;
                  while(_loc6_ < this._itemCardsClicked.length)
                  {
                     if(this._itemCardsClicked[_loc6_] == false)
                     {
                        _loc4_ = false;
                        if(_loc6_ == this._itemCardsClicked.length - 1 && this._itemIDs[_loc6_] == 0)
                        {
                           _loc5_ = true;
                        }
                        _loc6_ = this._itemCardsClicked.length;
                     }
                     _loc6_++;
                  }
                  if(_loc5_)
                  {
                     this.showWatchVideoPopup();
                  }
                  if(_loc4_ != false)
                  {
                     _loc7_ = true;
                     _loc6_ = 0;
                     while(_loc6_ < this._itemCardsFlipped.length)
                     {
                        if(this._itemCardsFlipped[_loc6_] == false)
                        {
                           _loc7_ = false;
                           _loc6_ = this._itemCardsFlipped.length;
                        }
                        _loc6_++;
                     }
                     if(_loc7_ && this._cardsStillMoving == 0)
                     {
                        this._movingCards = false;
                        this.handleAllCardsFlipped();
                     }
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private function handleItemCardFlipAnimation(param1:Number, param2:BMItemCard) : void
      {
         var _loc3_:Number = 0.3;
         var _loc4_:Number = 0;
         if(param2.isLegendaryOrBetter)
         {
            _loc3_ = 0.2;
            _loc4_ = 0.1;
         }
         else if(param2.isEpic)
         {
            _loc4_ = 0.1;
         }
         else if(this._didTriggerSkipAnimation)
         {
            _loc3_ = 0.25;
         }
         if(param2.mcCardBack.visible)
         {
            if(param2.scaleX == 1)
            {
               if(param2.isLegendaryOrBetter)
               {
                  soundM.createSound("legendaryCardFlip");
               }
            }
            param2.scaleX -= _loc3_;
            param2.scaleY += _loc4_;
            if(param2.scaleX <= _loc3_)
            {
               param2.mcCardBack.visible = false;
               param2.mcCardFront.visible = true;
               param2.switchOuterGlowToFrontMask();
               if(param1 == this._extraCardID && param2.isEpicOrBetter == false)
               {
                  param2.removeOuterGlow();
               }
            }
            return;
         }
         if(param2.scaleX < 1)
         {
            param2.scaleX += _loc3_;
            param2.scaleY -= _loc4_;
            return;
         }
         if(this._itemCardsFlipped[param1])
         {
            return;
         }
         this._itemCardsFlipped[param1] = true;
         if(param2.parent != null)
         {
            param2.parent.removeChild(param2);
            this.mcCardsHolder.addChild(param2);
         }
         param2.scaleX = 1;
         param2.scaleY = 1;
         var _loc5_:Number = 0.2;
         if(param2.isLegendaryOrBetter)
         {
            _loc5_ = 0.6;
         }
         param2.activateLightEffect(_loc5_);
         if(param2.isEpic)
         {
            param2.activateRotation(6);
         }
         else if(param2.isLegendaryOrBetter)
         {
            param2.activateRotation(12);
         }
         if(param2.isEpicOrBetter)
         {
            param2.activateItemAnimation();
            param2.activateItemInnerGlow();
         }
         var _loc6_:Number = 0;
         if(param2.isLegendaryOrBetter)
         {
            _loc6_ = 4;
         }
         if(_loc6_ > 0)
         {
            effectsM.addAnimatedEffect("effect_itemCardExplosion3",param2,0,0,4);
         }
      }
      
      private function handleAllCardsFlipped() : void
      {
         if(this.shouldAutoFlipCards)
         {
            if(this._insertExtraCard)
            {
               this.insertExtraCard();
               return;
            }
         }
         this.btnOK.visible = true;
         if(tutorialM.isTutorialActive())
         {
            this.mcTutorialArrow_button.gotoAndStop("animOn");
            this.mcTutorialMarker_button.gotoAndStop("animOn");
         }
         this.showItemInfo();
      }
      
      private function recalculateAllCardsTargetXPos() : void
      {
         var _loc2_:BMItemCard = null;
         var _loc3_:BMItemCard = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemIDs.length)
         {
            _loc2_ = this._itemCards[_loc1_];
            if(this.shouldAutoFlipCards == false)
            {
               _loc2_.targetXPos = this.getCardXPosition(_loc1_);
            }
            else if(_loc1_ != this._extraCardID)
            {
               _loc3_ = this._itemCards[this._extraCardID];
               if(_loc2_.targetYPos == _loc3_.targetYPos)
               {
                  _loc2_.targetXPos -= this.CARD_WIDTH / 2;
               }
            }
            _loc1_++;
         }
      }
      
      private function get numCardsToDisplay() : uint
      {
         return this._itemIDs.length + (this._insertExtraCard ? 1 : 0);
      }
      
      private function getMaxCardsInRow() : uint
      {
         if(this.numCardsToDisplay <= 5)
         {
            return this._itemIDs.length;
         }
         if(this.numCardsToDisplay <= 6)
         {
            return 3;
         }
         if(this.numCardsToDisplay <= 8)
         {
            return 4;
         }
         if(this.numCardsToDisplay <= 10)
         {
            return 5;
         }
         if(this.numCardsToDisplay <= 12)
         {
            return 6;
         }
         if(this.numCardsToDisplay <= 14)
         {
            return 7;
         }
         return 8;
      }
      
      private function getMaxCardRows() : uint
      {
         return this.numCardsToDisplay > 5 ? 2 : 1;
      }
      
      private function getCardYTarget(param1:uint) : Number
      {
         var _loc2_:Number = this.CARD_HEIGHT / 2;
         var _loc3_:Number = 0;
         if(this.getMaxCardRows() == 1)
         {
            return _loc3_;
         }
         var _loc4_:uint = this.getMaxCardsInRow();
         var _loc5_:uint = this.getMaxCardRows();
         var _loc6_:uint = Math.floor(param1 / _loc4_) + 1;
         var _loc7_:Number = _loc3_;
         if(_loc5_ == 2)
         {
            if(_loc6_ == 1)
            {
               _loc7_ = _loc3_ - _loc2_;
            }
            else
            {
               _loc7_ = _loc3_ + _loc2_;
            }
         }
         return _loc7_;
      }
      
      private function getCardXPosition(param1:uint) : Number
      {
         var _loc9_:BMItemCard = null;
         if(param1 == this._extraCardID && this.shouldAutoFlipCards)
         {
            _loc9_ = this._itemCards[this._itemCards.length - 1];
            return _loc9_.x + this.CARD_WIDTH / 2;
         }
         var _loc2_:uint = Math.floor(param1 / this.getMaxCardsInRow()) + 1;
         var _loc3_:Number = this.getMaxCardsInRow();
         if(_loc2_ > 1 && _loc2_ == this.getMaxCardRows() && this._itemIDs.length % this.getMaxCardsInRow() > 0)
         {
            _loc3_ = this._itemIDs.length % this.getMaxCardsInRow();
         }
         var _loc4_:Number = param1 - this.getMaxCardsInRow() * (_loc2_ - 1);
         var _loc5_:uint = this.CARD_WIDTH;
         var _loc6_:uint = _loc5_ * _loc3_ - 1;
         var _loc7_:Number = this.CARD_WIDTH / 2;
         return _loc4_ * _loc5_ - _loc6_ / 2 + _loc7_;
      }
      
      private function setCardsHolderScale() : void
      {
         var _loc1_:Number = 1;
         if(this.getMaxCardRows() == 2)
         {
            _loc1_ = 0.65;
            this.btnOK.y += 10;
            this.mcTitle.y -= 20;
         }
         this.mcCardsHolder.scaleX = _loc1_;
         this.mcCardsHolder.scaleY = _loc1_;
         this.mcLightsHolder.scaleX = _loc1_;
         this.mcLightsHolder.scaleY = _loc1_;
      }
      
      private function get shouldAutoFlipCards() : Boolean
      {
         if(this._packageID == 2 || this._packageID == 5)
         {
            return false;
         }
         if(this.numCardsToDisplay > 5)
         {
            return true;
         }
         var _loc1_:uint = uint(int(dataM.getGeneralSetting("xpLevelToAutoflipItemBoxCardsBelowEpic",999)));
         if(this._hasEpicItems == false && this._hasLegendaryOrMythItems == false && dataM.myProfile.level >= _loc1_)
         {
            return true;
         }
         var _loc2_:uint = uint(int(dataM.getGeneralSetting("xpLevelToAutoflipItemBoxCardsBelowLegendary",999)));
         if(this._hasLegendaryOrMythItems == false && dataM.myProfile.level >= _loc2_)
         {
            return true;
         }
         return false;
      }
      
      private function showItemInfo() : void
      {
         if(dataM.clientRunningLocally == false && int(dataM.getGeneralSetting("showSingleItemStats",0)) == 0)
         {
            return;
         }
         if(this._itemCards.length != 1)
         {
            return;
         }
         var _loc1_:uint = uint(this._itemIDs[0]);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_];
         if(_loc2_.isPowerKit || _loc2_.isTransformKit)
         {
            return;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_ITEM_INFO))
         {
            return;
         }
         if(this._insertExtraCard)
         {
            return;
         }
         this.btnOK.visible = false;
         var _loc3_:Number = 0.3;
         if(this._didTriggerSkipAnimation)
         {
            _loc3_ = 0.2;
         }
         var _loc4_:BMItemCard = this._itemCards[0];
         var _loc5_:uint = 5;
         var _loc6_:Number = 1.2;
         var _loc7_:Number = 5;
         var _loc8_:Number = _loc4_.x - _loc4_.fixedWidth / 2 - _loc5_;
         _loc8_ = _loc8_ - ((_loc4_.fixedWidth * _loc6_ - _loc4_.fixedWidth) / 2 + _loc7_);
         var _loc9_:Number = _loc4_.y * _loc6_;
         var _loc10_:Number = 0.3;
         if(_loc4_.isLegendaryOrBetter)
         {
            _loc10_ = 0.8;
         }
         TweenMax.to(_loc4_,_loc3_,{
            "delay":_loc10_,
            "x":_loc8_,
            "y":_loc9_,
            "scaleX":_loc6_,
            "scaleY":_loc6_
         });
         screensM.addScreen(BMScreensManager.SCR_ITEM_INFO);
         screensM.screenItemInfo.x = 0;
         screensM.screenItemInfo.y = 102;
         screensM.screenItemInfo.showItemInfo(this._itemIDs[0]);
         screensM.screenItemInfo.parent.removeChild(screensM.screenItemInfo);
         this.mcItemInfoHolder.addChild(screensM.screenItemInfo);
         _loc8_ = dataM.STAGE_WIDTH / 2 + _loc5_ - _loc7_ - 20;
         TweenMax.to(screensM.screenItemInfo,_loc3_,{
            "delay":_loc3_ + _loc10_,
            "x":_loc8_
         });
         TweenMax.delayedCall(_loc3_ * 3,this.enableOKButton);
      }
      
      private function enableOKButton() : void
      {
         this.btnOK.visible = true;
      }
      
      private function sparksHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMItemCard = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Sprite = null;
         var _loc6_:Sprite = null;
         _loc1_ = 0;
         while(_loc1_ < this._itemCards.length)
         {
            _loc2_ = this._itemCards[_loc1_];
            if(!(_loc2_.rarity < ItemRarityResolver.RARITY_LEGENDARY || _loc2_.mcCardBack.visible == false))
            {
               if(_loc2_.glowCounter == -1)
               {
                  _loc2_.glowCounter = 100 + Math.ceil(Math.random() * 50);
               }
               else
               {
                  --_loc2_.glowCounter;
                  if(_loc2_.glowCounter <= 0)
                  {
                     _loc2_.activateLightEffect();
                     _loc2_.glowCounter = 100 + Math.ceil(Math.random() * 50);
                  }
               }
               _loc3_ = Math.ceil(Math.random() * 15);
               if(_loc3_ == 1)
               {
                  _loc4_ = _loc2_.rarity;
                  if(_loc4_ == BMItemCard.EXTRA_CARD)
                  {
                     _loc4_ = ItemRarityResolver.RARITY_EPIC;
                  }
                  _loc5_ = externalAssetsM.getAsset("general","Grp_itemCardSpark" + _loc4_,0,0,false,false);
                  _loc5_.x = _loc2_.x + Math.random() * (_loc2_.fixedWidth - 40) - _loc2_.fixedWidth / 2;
                  _loc5_.y = _loc2_.y + Math.random() * (_loc2_.fixedHeight - 30) - _loc2_.fixedHeight / 2;
                  this.mcEffectsHolder.addChild(_loc5_);
                  TweenMax.to(_loc5_,0.6,{
                     "scaleX":0.05,
                     "scaleY":0.05,
                     "ease":Linear.easeNone
                  });
                  this._sparks.push(_loc5_);
               }
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._sparks.length)
         {
            _loc6_ = this._sparks[_loc1_];
            if(_loc6_.scaleX < 0.1)
            {
               TweenMax.killTweensOf(_loc6_);
               this._sparks[_loc1_].parent.removeChild(this._sparks[_loc1_]);
               this._sparks[_loc1_] = null;
               this._sparks.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      public function cardMouseOver(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:BMItemCard = null;
         if(this._movingCards == false)
         {
         }
      }
      
      public function cardMouseOut(param1:Number) : void
      {
      }
      
      private function createItemCardLight(param1:Number, param2:Number, param3:uint, param4:uint) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(param4 <= ItemRarityResolver.RARITY_RARE)
         {
            return;
         }
         if(this._insertExtraCard || param3 == this._extraCardID)
         {
            return;
         }
         switch(param4)
         {
            case ItemRarityResolver.RARITY_RARE:
               _loc5_ = new mcItemCardLight1();
               _loc6_ = 0.4;
               _loc7_ = 0.5;
               break;
            case ItemRarityResolver.RARITY_EPIC:
               _loc5_ = new mcItemCardLight2();
               _loc6_ = 0.3;
               _loc7_ = 0.6;
               break;
            case ItemRarityResolver.RARITY_LEGENDARY:
               _loc5_ = new mcItemCardLight3();
               _loc6_ = 0.4;
               _loc7_ = 0.75;
               break;
            case ItemRarityResolver.RARITY_MYTHICAL:
               _loc5_ = new mcItemCardLight4();
               _loc6_ = 0.4;
               _loc7_ = 0.9;
         }
         _loc5_.x = param1;
         _loc5_.y = param2;
         _loc5_.scaleX = _loc6_;
         _loc5_.scaleY = _loc6_;
         _loc5_.scaleMax = _loc7_;
         _loc5_.scaleStatus = LIGHT_STATUS_ENTER;
         _loc5_.cardID = param3;
         this.mcLightsHolder.addChild(_loc5_);
         this._itemCardLights.push(_loc5_);
         this.itemCardLightAnimationHandler(_loc5_,LIGHT_STATUS_ENTER);
      }
      
      private function itemCardLightAnimationHandler(param1:MovieClip, param2:String) : void
      {
         var _loc7_:Number = NaN;
         var _loc3_:Number = 0.9;
         var _loc4_:Number = 1.3;
         var _loc5_:Number = 1.2;
         var _loc6_:Number = 1.4;
         switch(param2)
         {
            case LIGHT_STATUS_ENTER:
               _loc7_ = Number(param1.scaleMax);
               TweenMax.to(param1,0.2,{
                  "scaleX":_loc7_,
                  "scaleY":_loc7_,
                  "ease":Linear.easeNone,
                  "onComplete":this.itemCardLightAnimationHandler,
                  "onCompleteParams":[param1,LIGHT_STATUS_SHRINK]
               });
               break;
            case LIGHT_STATUS_SHRINK:
               _loc7_ = param1.scaleMax * _loc3_;
               TweenMax.to(param1.mcLight1,2,{
                  "scaleX":_loc7_,
                  "scaleY":_loc7_
               });
               _loc7_ = param1.scaleMax * _loc6_;
               TweenMax.to(param1.mcLight2,2,{
                  "scaleX":_loc7_,
                  "scaleY":_loc7_,
                  "onComplete":this.itemCardLightAnimationHandler,
                  "onCompleteParams":[param1,LIGHT_STATUS_EXPAND]
               });
               break;
            case LIGHT_STATUS_EXPAND:
               _loc7_ = param1.scaleMax * _loc4_;
               TweenMax.to(param1.mcLight1,2,{
                  "scaleX":_loc7_,
                  "scaleY":_loc7_
               });
               _loc7_ = param1.scaleMax * _loc5_;
               TweenMax.to(param1.mcLight2,2,{
                  "scaleX":_loc7_,
                  "scaleY":_loc7_,
                  "onComplete":this.itemCardLightAnimationHandler,
                  "onCompleteParams":[param1,LIGHT_STATUS_SHRINK]
               });
         }
      }
      
      private function itemCardLightsHandler() : void
      {
         var _loc2_:MovieClip = null;
         if(this.shouldAutoFlipCards)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemCardLights.length)
         {
            _loc2_ = this._itemCardLights[_loc1_];
            if(!_loc2_.isHidden)
            {
               if(this._itemCardsClicked[_loc2_.cardID] != false)
               {
                  this.removeLightTweens(_loc2_);
                  _loc2_.isHidden = true;
                  TweenMax.to(_loc2_,0.3,{
                     "scaleX":0.05,
                     "scaleY":0.05,
                     "onComplete":this.hideLight,
                     "onCompleteParams":[_loc2_]
                  });
               }
            }
            _loc1_++;
         }
      }
      
      private function hideLight(param1:MovieClip) : void
      {
         param1.visible = false;
         this.removeLightTweens(param1);
      }
      
      private function removeAllItemCardLights() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:uint = 0;
         while(_loc1_ <= this._itemCardLights.length)
         {
            if(this._itemCardLights[_loc1_] != null)
            {
               _loc2_ = this._itemCardLights[_loc1_];
               this.removeLightTweens(_loc2_);
               if(_loc2_.parent != null)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               _loc2_ = null;
               this._itemCardLights[_loc1_] = null;
            }
            _loc1_++;
         }
         this._itemCardLights = new Array();
      }
      
      private function removeLightTweens(param1:MovieClip) : void
      {
         TweenMax.killChildTweensOf(param1);
         TweenMax.killChildTweensOf(param1.mcLight1);
         TweenMax.killChildTweensOf(param1.mcLight2);
      }
      
      private function isRewardedVideoDialogInProgress() : Boolean
      {
         return screensM.isScreenOpened(BMScreensManager.SCR_YES_NO_POPUP);
      }
      
      private function showWatchVideoPopup() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_YES_NO_POPUP))
         {
            return;
         }
         if(this._showWatchVideoPopupDisplayed)
         {
            return;
         }
         this._showWatchVideoPopupDisplayed = true;
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup4);
         var _loc1_:String = getScreenText("watchAVideoForAnotherCard");
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = getScreenText("watch");
         var _loc5_:String = getScreenText("noThanks");
         screensM.screenYesNoPopup.displayYesNoPopup(_loc1_,_loc2_,_loc3_,this.watchingVideoForExtraCardAccepted,this.watchingVideoForExtraCardDeclined,_loc4_,_loc5_);
         screensM.screenYesNoPopup.y = 160;
         TweenMax.to(screensM.screenYesNoPopup,0.3,{
            "delay":0.3,
            "y":0
         });
      }
      
      private function watchingVideoForExtraCardAccepted() : void
      {
         screensM.addScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO,false);
         screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_OPEN_BOX_EXTRA_CARD);
      }
      
      public function onVideoWatched(param1:Array, param2:Array) : void
      {
         this._itemIDs[this._extraCardID] = param1[0];
         this._playerItemIDs.push(param2[0]);
         var _loc3_:BMItemCard = this._itemCards[this._extraCardID];
         _loc3_.addCardItemAndTexts(param1[0]);
         if(this.shouldAutoFlipCards)
         {
            soundM.createSound("buttonClick",1);
            this._itemCardsClicked[this._extraCardID] = true;
            this.btnOK.enableMe();
            this.btnOK.visible = true;
            return;
         }
         this._tutorialFrameCounter = this.FRAMES_FOR_TUTORIAL_POINTER - 1;
         if(dataM.myProfile.level > 10)
         {
            this._tutorialFrameCounter *= 3;
         }
         _loc3_.enableClicks();
      }
      
      private function watchingVideoForExtraCardDeclined() : void
      {
         this.OKClicked();
      }
      
      public function watchingVideoForExtraCardFailed() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_YES_NO_POPUP))
         {
            screensM.screenYesNoPopup.removeMe();
         }
         this.OKClicked();
      }
      
      private function isFortuneBox() : Boolean
      {
         if(this.mcBox != null && this.mcBox.mcSpark0 != null)
         {
            return true;
         }
         return false;
      }
      
      private function culcItemsHighestRarity() : int
      {
         var _loc3_:BMItemData = null;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this._itemIDs.length)
         {
            _loc3_ = dataM.itemsDB[this._itemIDs[_loc2_]];
            if(_loc1_ < _loc3_.specialStatusForDisplay)
            {
               _loc1_ = uint(_loc3_.specialStatusForDisplay);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function maskAnimDone() : void
      {
      }
      
      public function OKClicked() : void
      {
         trackButtonClick("OK");
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
         {
            this.finishScreen();
            return;
         }
         dataM.mechEquipmentRecommander.recommendEquippingBetterItems(this._playerItemIDs,this.finishScreen,this.shouldBlockEquipmentRecommendationAnimationSequence);
      }
      
      public function finishScreen() : *
      {
         if(BMGameShortcutsHelper.screenItemCardsShortcut())
         {
            this.removeAllCards();
            this.removeAllItemCardLights();
            if(screensM.isScreenOpened(BMScreensManager.SCR_DISPLAY_REWARD))
            {
               screensM.screenDisplayReward.itemCardsScreenClosed();
            }
            else if(!screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP))
            {
               if(screensM.isScreenOpened(BMScreensManager.SCR_LEVEL_UP_NEW))
               {
                  screensM.removeScreen(BMScreensManager.SCR_LEVEL_UP_NEW);
               }
               else if(!screensM.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
               {
                  if(screensM.isScreenOpened(BMScreensManager.SCR_DAILY_LOGIN_STREAK_BONUS))
                  {
                     screensM.screenDailyLoginStreakBonus.closeScreen();
                  }
                  else if(screensM.isBuyStarterPackOpened())
                  {
                     screensM.screenTransitionsManager.hangerMechClicked(true);
                  }
                  else if(screensM.isScreenOpened(BMScreensManager.SCR_LADDER_SEASON_END_REWARD))
                  {
                     screensM.screenLadderSeasonEndReward.itemCardsScreenClosed();
                  }
               }
            }
            screensM.removeScreen(BMScreensManager.SCR_ITEM_CARDS);
            screensM.removeScreen(BMScreensManager.SCR_ITEM_INFO);
            return;
         }
         this._movingCards = true;
         this._frameCounterCards = 0;
         this.mcBoxReflectionCover.visible = false;
         this.mcGfxCover.visible = false;
         if(dataM.runAsMobile == false)
         {
            this.mcItemBoxClickHitArea.removeEventListener(MouseEvent.CLICK,this.itemBoxClicked);
         }
         this.btnOK.disableMe();
         this.closingScreen = true;
         this.mcTutorialArrow_button.gotoAndStop("animOff");
         this.mcTutorialMarker_button.gotoAndStop("animOff");
         this.removeAllCards();
         this.removeAllItemCardLights();
         if(screensM.isScreenOpened(BMScreensManager.SCR_DISPLAY_REWARD))
         {
            screensM.screenDisplayReward.itemCardsScreenClosed();
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP))
         {
            screensM.screenGlobalShop.setScreenJustOpened();
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_LEVEL_UP_NEW))
         {
            screensM.removeScreen(BMScreensManager.SCR_LEVEL_UP_NEW);
         }
         else if(!screensM.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_DAILY_LOGIN_STREAK_BONUS))
            {
               screensM.screenDailyLoginStreakBonus.closeScreen();
            }
            else if(screensM.isBuyStarterPackOpened())
            {
               screensM.screenTransitionsManager.hangerMechClicked(true);
            }
            else if(screensM.isScreenOpened(BMScreensManager.SCR_LADDER_SEASON_END_REWARD))
            {
               screensM.screenLadderSeasonEndReward.itemCardsScreenClosed();
            }
         }
         screensM.removeScreen(BMScreensManager.SCR_ITEM_CARDS);
         screensM.removeScreen(BMScreensManager.SCR_ITEM_INFO);
      }
      
      private function removeAllCards() : void
      {
         var _loc2_:BMItemCard = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemCards.length)
         {
            _loc2_ = this._itemCards[_loc1_];
            _loc2_.removeMe();
            _loc1_++;
         }
         this._itemCards = new Array();
      }
      
      private function screensDirectorStartedPerformingTasks(param1:String, param2:Object) : void
      {
         this.removeScreenInstantly();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function removeScreenInstantly() : void
      {
         this.removeAllCards();
         this.removeAllItemCardLights();
         this._movingCards = false;
         this.closingScreen = false;
         this.mcTutorialArrow_button.gotoAndStop("animOff");
         this.mcTutorialMarker_button.gotoAndStop("animOff");
         if(dataM.runAsMobile == false)
         {
            this.mcItemBoxClickHitArea.removeEventListener(MouseEvent.CLICK,this.itemBoxClicked);
         }
         TweenMax.killTweensOf(screensM.screenYesNoPopup);
         screensM.removeScreen(BMScreensManager.SCR_ITEM_CARDS);
         screensM.removeScreen(BMScreensManager.SCR_ITEM_INFO);
      }
      
      private function get shouldBlockEquipmentRecommendationAnimationSequence() : Boolean
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_RESULT))
         {
            return screensM.screenBattleResult.isInNextMissionMode;
         }
         return false;
      }
   }
}

