package net.battleMechsMulti.screens
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol347")]
   public class BMScreenMissionCompleted extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcEffectsHolder:Sprite;
      
      public var mcGoldCoinsFrontHolder:Sprite;
      
      public var mcGoldCoinsBackHolder:Sprite;
      
      public var mcGoldCoinsFrontHolder_reflection:Sprite;
      
      public var mcGoldCoinsBackHolder_reflection:Sprite;
      
      public var mcGoldCoinsFlyingHolder:MovieClip;
      
      public var mcGoldXPTextPosition:Sprite;
      
      public var mcRays:Sprite;
      
      public var mcItemSizer:Sprite;
      
      public var mcReflection:Sprite;
      
      public var mcCloseFrame:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcSizer_btnClose:Sprite;
      
      public var txtFirstClearBonus:TextField;
      
      public var btnClose:BMButton;
      
      public var mcGoldXP:MovieClip;
      
      public var mcItemBox:MovieClip;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcFinger:Sprite;
      
      public var txtRemaining:TextField;
      
      private var mcLootCrate:MovieClip;
      
      private var mcLootCrateCenter:MovieClip;
      
      private var mcLootCrateLeft:MovieClip;
      
      private var mcLootCrateRight:MovieClip;
      
      private var _firstRefresh:Boolean = true;
      
      private var _lootData:Array;
      
      private var _lootSlot:uint;
      
      private var _flowStatus:Array = new Array();
      
      private var _waitingForClick:Boolean;
      
      private var _waitingToOpenLootCrate:Boolean;
      
      private var _waitingToOpenItemBox:Boolean;
      
      private var _lootCrateActive:Boolean = false;
      
      private var _lootCrateAnimationType:String;
      
      private var _lootCrateFrameCounter:uint;
      
      private var _lootCrateXSpeed:Number;
      
      private var _lootCrateXAcc:Number;
      
      private var _goldXPTextActive:Boolean = false;
      
      private var _goldXPTextStatus:String;
      
      private var _goldXPTextFrameCounter:uint;
      
      private var _goldXPTextVisibleTextWidth:Number;
      
      private var _goldXPTextEmptyTextWidth:Number;
      
      private var _lootRewardType:String;
      
      private var _lootRewardAmount:uint;
      
      private var _itemBoxActive:Boolean = false;
      
      private var _itemBoxFrameCounter:uint;
      
      private var _lootCrateVibrationFrameCounter:uint;
      
      private var _lootCrateVibrationDistance:uint;
      
      private var _backgroundOriginYPos:Number;
      
      private var _fingerHandler:Boolean = false;
      
      private var _fingerWaitFrames:uint;
      
      private var _fingerFrameCounter:uint;
      
      private var _fingerOriginXPos:Number;
      
      private var _fingerOriginYPos:Number;
      
      private var _openedFrom:String = "";
      
      private var _goldCoins:Array;
      
      private var _goldCoinsReflections:Array;
      
      private var _collectGoldCoinsActive:Boolean = false;
      
      private var _collectGoldCoinsFramesPerCoin:uint;
      
      private var _collectGoldCoinsYScaleChange:Number;
      
      private var _singleGoldCoinAnimationFrameCounter:uint;
      
      private var _generalGoldCoinsCollectionAnimationFrameCounter:uint;
      
      private var _collectXPStarsCounter:uint = 0;
      
      private var _collectXPMaxStars:uint = 0;
      
      private var _collectXPFrameCounter:uint = 0;
      
      private var _xpStars:Array;
      
      private var _itemIcon:MovieClip;
      
      private var _collectTokensFrameCounter:uint = 0;
      
      private const STATUS_NONE:uint = 0;
      
      private const STATUS_SCREEN_ENTER:uint = 1;
      
      private const STATUS_SCREEN_ENTER_DONE:uint = 2;
      
      private const STATUS_SELECTING_NEXT_LOOT:uint = 3;
      
      private const STATUS_SHOWING_LOOT_CRATE:uint = 4;
      
      private const STATUS_WAITING_TO_OPEN_LOOT_CRATE:uint = 5;
      
      private const STATUS_OPENING_LOOT_CRATE:uint = 6;
      
      private const STATUS_LOOT_CRATE_OPENED:uint = 7;
      
      private const STATUS_SHOWING_GOLD:uint = 8;
      
      private const STATUS_WAITING_FOR_COLLECTING_GOLD:uint = 9;
      
      private const STATUS_COLLECTING_GOLD:uint = 10;
      
      private const STATUS_SHOWING_XP:uint = 11;
      
      private const STATUS_WAITING_FOR_COLLECTING_XP:uint = 12;
      
      private const STATUS_COLLECTING_XP:uint = 13;
      
      private const STATUS_SHOWING_TOKENS:uint = 14;
      
      private const STATUS_WAITING_FOR_COLLECTING_TOKENS:uint = 15;
      
      private const STATUS_COLLECTING_TOKENS:uint = 16;
      
      private const STATUS_SHOWING_ITEM_BOX:uint = 17;
      
      private const STATUS_WAITING_TO_OPEN_ITEM_BOX:uint = 18;
      
      private const STATUS_OPEN_ITEM_BOX:uint = 19;
      
      private const STATUS_WAITING_FOR_ITEM_CARDS_TO_CLOSE:uint = 20;
      
      private const STATUS_ITEM_CARDS_CLOSED:uint = 21;
      
      private const STATUS_WAITING_TO_CLOSE_SCREEN:uint = 22;
      
      private const STATUS_SHOWING_ITEM:uint = 23;
      
      private const STATUS_WAITING_FOR_COLLECT_ITEM:uint = 24;
      
      private const STATUS_WAITING_FOR_ANIMATION_TO_FINISH:uint = 100;
      
      public function BMScreenMissionCompleted()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("missionCompleted");
      }
      
      public function refreshScreen(param1:Array, param2:String = "") : void
      {
         var _loc5_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenMissionCompleted","btnClose","regular");
            _loc5_ = this.closeClicked;
            if(dataM.runAsMobile)
            {
               _loc5_ = null;
            }
            this.btnClose.initialize(getGeneralText("OK"),"blue",null,null,_loc5_,dataM.runAsMobile);
            this.btnClose.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            if(dataM.runAsMobile == false)
            {
               this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.hitAreaClicked);
            }
            this._backgroundOriginYPos = this.mcBackground.y;
            this.mcLootCrate = externalAssetsM.getAsset("general","icon_lootBig");
            this.mcLootCrateCenter = externalAssetsM.getAsset("general","icon_lootCenter");
            this.mcLootCrateLeft = externalAssetsM.getAsset("general","icon_lootLeft");
            this.mcLootCrateRight = externalAssetsM.getAsset("general","icon_lootRight");
            this.mcEffectsHolder.addChild(this.mcLootCrate);
            this.mcEffectsHolder.addChild(this.mcLootCrateCenter);
            this.mcEffectsHolder.addChild(this.mcLootCrateLeft);
            this.mcEffectsHolder.addChild(this.mcLootCrateRight);
            this.mcFinger.mouseEnabled = false;
            this.mcFinger.mouseChildren = false;
            this._fingerOriginXPos = this.mcFinger.x;
            this._fingerOriginYPos = this.mcFinger.y;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._lootData = new Array();
         if(param1[0].type != "tokens" && _loc3_.mission_gold > 0)
         {
            this._lootData.push({
               "type":"pickupGold",
               "amount":_loc3_.mission_gold
            });
            _loc3_.mission_gold = 0;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            this._lootData.push(param1[_loc4_]);
            if(_loc4_ == 0)
            {
               if(param1[0].type == "tokens" && _loc3_.mission_gold > 0)
               {
                  this._lootData.push({
                     "type":"pickupGold",
                     "amount":_loc3_.mission_gold
                  });
                  _loc3_.mission_gold = 0;
               }
            }
            _loc4_++;
         }
         this._flowStatus.push(this.STATUS_SCREEN_ENTER);
         this._openedFrom = param2;
         this._lootSlot = 0;
         this._waitingForClick = false;
         this._waitingToOpenLootCrate = false;
         this._waitingToOpenItemBox = false;
         this._lootCrateActive = false;
         this._goldXPTextActive = false;
         this._itemBoxActive = false;
         this._lootRewardType = "";
         this.txtRemaining.text = "";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionCompleted_remaining",[this.txtRemaining],"",this);
         }
         this.mcLootCrate.gotoAndStop(_loc3_.mission_difficulty);
         this.mcLootCrateLeft.gotoAndStop(_loc3_.mission_difficulty);
         this.mcLootCrateRight.gotoAndStop(_loc3_.mission_difficulty);
         this.mcItemBox.gotoAndStop(_loc3_.mission_difficulty);
         this.mcLootCrate.visible = false;
         this.mcLootCrateCenter.visible = false;
         this.mcLootCrateLeft.visible = false;
         this.mcLootCrateRight.visible = false;
         this.mcGoldXP.visible = false;
         this.mcItemBox.visible = false;
         this.mcReflection.visible = false;
         this.mcCloseFrame.visible = false;
         this.mcRays.visible = false;
         this.mcGoldXP.scaleX = 1;
         this.mcGoldXP.scaleY = 1;
         this.resetGoldXPPosition();
         this.deactivateFinger();
         this.mcBackground.y = this._backgroundOriginYPos - 400;
         this.txtFirstClearBonus.visible = false;
         this.btnClose.visible = false;
         this.btnClose.enableMe();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtRemaining,20);
            TextUtils.updateTextFormat(this.mcBackground.txtTitle,20);
            TextUtils.updateTextFormat(this.mcGoldXP.txtAmount,70);
         }
         if(param1)
         {
            this.btnClose.setButtonName(getGeneralText("OK"));
         }
         this.setTitle(getScreenText("title"));
      }
      
      private function setTitle(param1:String) : void
      {
         this.mcBackground.txtTitle.text = param1;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionCompleted_title",[this.mcBackground.txtTitle],"",this.mcBackground);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.generalFlowHandler();
         }
         if(this.mcRays.visible)
         {
            this.mcRays.rotation += 0.5;
         }
      }
      
      private function generalFlowHandler() : void
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._flowStatus.length)
         {
            switch(this._flowStatus[_loc1_])
            {
               case this.STATUS_NONE:
                  break;
               case this.STATUS_SCREEN_ENTER:
                  this.screenEnter();
                  break;
               case this.STATUS_SCREEN_ENTER_DONE:
                  this.mcReflection.visible = true;
                  this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
                  break;
               case this.STATUS_SELECTING_NEXT_LOOT:
                  this.selectingNextLoot();
                  break;
               case this.STATUS_SHOWING_LOOT_CRATE:
                  this.showingLootCrate();
                  break;
               case this.STATUS_WAITING_TO_OPEN_LOOT_CRATE:
                  this.lootCrateVibrationHandler();
                  break;
               case this.STATUS_OPENING_LOOT_CRATE:
                  this.openingLootCrate();
                  break;
               case this.STATUS_LOOT_CRATE_OPENED:
                  if(this._lootSlot < this._lootData.length)
                  {
                     switch(this._lootData[this._lootSlot].type)
                     {
                        case "gold":
                           this._goldXPTextFrameCounter = 0;
                           this._flowStatus = [this.STATUS_SHOWING_GOLD];
                           break;
                        case "xp":
                           this._goldXPTextFrameCounter = 0;
                           this._flowStatus = [this.STATUS_SHOWING_XP];
                           break;
                        case "itemBox":
                           this._itemBoxFrameCounter = 0;
                           this._flowStatus = [this.STATUS_SHOWING_ITEM_BOX];
                     }
                     this._flowStatus.push(this.STATUS_OPENING_LOOT_CRATE);
                  }
                  break;
               case this.STATUS_SHOWING_GOLD:
                  this.showingGoldXP();
                  break;
               case this.STATUS_WAITING_FOR_COLLECTING_GOLD:
                  break;
               case this.STATUS_COLLECTING_GOLD:
                  this.collectGoldCoinsHandler();
                  break;
               case this.STATUS_SHOWING_XP:
                  this.showingGoldXP();
                  break;
               case this.STATUS_WAITING_FOR_COLLECTING_XP:
                  break;
               case this.STATUS_COLLECTING_XP:
                  this.collectXPHandler();
                  break;
               case this.STATUS_SHOWING_TOKENS:
                  this.showingGoldXP();
                  break;
               case this.STATUS_WAITING_FOR_COLLECTING_TOKENS:
                  break;
               case this.STATUS_WAITING_FOR_COLLECT_ITEM:
                  break;
               case this.STATUS_COLLECTING_TOKENS:
                  this.collectTokensHandler();
                  break;
               case this.STATUS_SHOWING_ITEM_BOX:
                  this.itemBoxHandler();
                  break;
               case this.STATUS_SHOWING_ITEM:
                  break;
               case this.STATUS_WAITING_TO_OPEN_ITEM_BOX:
                  break;
               case this.STATUS_OPEN_ITEM_BOX:
                  this.mcRays.visible = false;
                  if(this._lootData[this._lootSlot].boostId != undefined)
                  {
                     if(this._lootData[this._lootSlot].id == undefined)
                     {
                        remoteM.tokens_buyPackageNew(this._lootData[this._lootSlot].boostId);
                     }
                     else
                     {
                        remoteM.tokens_redeemPackage(this._lootData[this._lootSlot].boostId,this._lootData[this._lootSlot].id);
                     }
                  }
                  else
                  {
                     _loc2_ = new Array();
                     _loc3_ = this._lootData[this._lootSlot];
                     for each(_loc4_ in _loc3_.items)
                     {
                        dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,_loc4_.itemID,_loc4_.playerItemID,0,0,0);
                        _loc2_.push(_loc4_.itemID);
                     }
                     screensM.addScreen("screenItemCards");
                     screensM.screenItemCards.refreshScreen(_loc2_,25);
                  }
                  this._flowStatus = [this.STATUS_WAITING_FOR_ITEM_CARDS_TO_CLOSE];
                  break;
               case this.STATUS_WAITING_FOR_ITEM_CARDS_TO_CLOSE:
                  break;
               case this.STATUS_ITEM_CARDS_CLOSED:
                  this.mcRays.visible = false;
                  break;
               case this.STATUS_WAITING_FOR_ANIMATION_TO_FINISH:
                  break;
               case this.STATUS_WAITING_TO_CLOSE_SCREEN:
                  this.closeClicked();
            }
            _loc1_++;
         }
      }
      
      private function selectingNextLoot() : void
      {
         if(this._lootSlot < this._lootData.length)
         {
            switch(this._lootData[this._lootSlot].type)
            {
               case "pickupGold":
                  this._goldXPTextFrameCounter = 0;
                  this._flowStatus = [this.STATUS_SHOWING_GOLD];
                  break;
               case "tokens":
                  this._goldXPTextFrameCounter = 0;
                  this._flowStatus = [this.STATUS_SHOWING_TOKENS];
                  this.txtFirstClearBonus.visible = true;
                  if(screensM.isScreenOpened("screenMissionBaseMap"))
                  {
                     this.txtFirstClearBonus.text = "FIRST CLEAR BONUS";
                  }
                  else
                  {
                     this.txtFirstClearBonus.text = "YOUR PRIZE";
                  }
                  break;
               case "gold":
               case "xp":
               case "itemBox":
                  this._lootCrateFrameCounter = 0;
                  this._lootCrateVibrationFrameCounter = 0;
                  this._flowStatus = [this.STATUS_SHOWING_LOOT_CRATE];
                  break;
               case "freeBox":
                  this._lootCrateFrameCounter = 0;
                  this._lootCrateVibrationFrameCounter = 0;
                  this.setTitle(this._lootData[this._lootSlot].title);
                  this._flowStatus = [this.STATUS_SHOWING_ITEM_BOX];
                  break;
               case "item":
                  this.addItemBox();
                  this._flowStatus = [this.STATUS_SHOWING_ITEM];
            }
         }
         else
         {
            this._flowStatus = [this.STATUS_WAITING_TO_CLOSE_SCREEN];
         }
      }
      
      private function removeFlowStatus(param1:uint) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._flowStatus.length)
         {
            if(this._flowStatus[_loc2_] == param1)
            {
               this._flowStatus.splice(_loc2_,1);
               _loc2_ = this._flowStatus.length;
            }
            _loc2_++;
         }
      }
      
      private function screenEnter() : void
      {
         this.mcBackground.y += (this._backgroundOriginYPos - this.mcBackground.y) * 0.3;
         if(Math.abs(this._backgroundOriginYPos - this.mcBackground.y) < 2)
         {
            this.mcBackground.y = this._backgroundOriginYPos;
            this._flowStatus = [this.STATUS_SCREEN_ENTER_DONE];
         }
      }
      
      private function showingLootCrate() : void
      {
         if(this._lootCrateFrameCounter == 0)
         {
            this.mcLootCrate.visible = true;
            this.mcLootCrateCenter.visible = false;
            this.mcLootCrateLeft.visible = false;
            this.mcLootCrateRight.visible = false;
            this.mcLootCrate.scaleX = 0.1;
            this.mcLootCrate.scaleY = 0.1;
            this.mcLootCrate.x = 0;
            this.mcLootCrate.y = 0;
            if(this._openedFrom == "")
            {
               if(screensM.isScreenOpened("screenMissionBaseMap"))
               {
                  screensM.screenMissionBaseMap.removeLootPickup();
               }
            }
         }
         else if(this._lootCrateFrameCounter < 7)
         {
            this.mcLootCrate.scaleX += 0.2;
            this.mcLootCrate.scaleY += 0.2;
         }
         else if(this.mcLootCrateLeft.scaleX > 1)
         {
            this.mcLootCrate.scaleX -= 0.1;
            this.mcLootCrate.scaleY -= 0.1;
         }
         else
         {
            this.mcLootCrate.scaleX = 1;
            this.mcLootCrate.scaleY = 1;
            this.mcRays.visible = true;
            this._flowStatus = [this.STATUS_WAITING_TO_OPEN_LOOT_CRATE];
         }
         ++this._lootCrateFrameCounter;
      }
      
      private function openingLootCrate() : void
      {
         this.mcRays.visible = false;
         if(this._lootCrateFrameCounter == 0)
         {
            this.mcLootCrate.visible = false;
            this.mcLootCrateCenter.visible = true;
            this.mcLootCrateLeft.visible = true;
            this.mcLootCrateRight.visible = true;
            this.mcLootCrateCenter.x = 0;
            this.mcLootCrateLeft.x = 0;
            this.mcLootCrateRight.x = 0;
            this.mcLootCrateCenter.gotoAndPlay("animOn");
            soundM.createSound("fireBullet1",1);
            this._flowStatus = [this.STATUS_LOOT_CRATE_OPENED];
         }
         this.mcLootCrateLeft.x -= this._lootCrateXSpeed;
         this.mcLootCrateRight.x += this._lootCrateXSpeed;
         if(this._lootCrateFrameCounter > 5)
         {
            this.mcLootCrateCenter.visible = false;
            this.mcLootCrateLeft.visible = false;
            this.mcLootCrateRight.visible = false;
            this._lootCrateActive = false;
            this.removeFlowStatus(this.STATUS_OPENING_LOOT_CRATE);
         }
         ++this._lootCrateFrameCounter;
      }
      
      private function lootCrateVibrationHandler() : void
      {
         ++this._lootCrateVibrationFrameCounter;
         if(this._lootCrateVibrationFrameCounter >= 120)
         {
            if(this._lootCrateVibrationFrameCounter == 120)
            {
               this._lootCrateVibrationDistance = 20;
            }
            if(this._lootCrateVibrationDistance > 0)
            {
               if(this._lootCrateVibrationFrameCounter % 2 == 0)
               {
                  this.mcLootCrate.x = this._lootCrateVibrationDistance;
               }
               else
               {
                  this.mcLootCrate.x = -this._lootCrateVibrationDistance;
               }
               --this._lootCrateVibrationDistance;
            }
            else
            {
               this._lootCrateVibrationFrameCounter = Math.ceil(Math.random() * 80);
               this.mcLootCrate.x = 0;
            }
         }
      }
      
      private function showingGoldXP() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(this._goldXPTextFrameCounter == 0)
         {
            _loc1_ = 20;
            _loc2_ = uint(this._lootData[this._lootSlot].amount);
            this.mcGoldXP.visible = true;
            switch(this._lootData[this._lootSlot].type)
            {
               case "gold":
               case "pickupGold":
                  this.mcGoldXP.mcGold.visible = true;
                  this.mcGoldXP.mcXP.visible = false;
                  this.mcGoldXP.mcTokens.visible = false;
                  this.createGoldCoins(Math.ceil(_loc2_ / 50));
                  break;
               case "xp":
                  this.mcGoldXP.mcGold.visible = false;
                  this.mcGoldXP.mcXP.visible = true;
                  this.mcGoldXP.mcTokens.visible = false;
                  break;
               case "tokens":
                  this.mcGoldXP.mcGold.visible = false;
                  this.mcGoldXP.mcXP.visible = false;
                  this.mcGoldXP.mcTokens.visible = true;
            }
            this.mcGoldXP.txtAmount.text = dataM.getNumberWithComma(_loc2_);
            this._goldXPTextEmptyTextWidth = this.mcGoldXP.txtAmount.width - this.mcGoldXP.txtAmount.textWidth;
            this._goldXPTextVisibleTextWidth = this.mcGoldXP.width - this._goldXPTextEmptyTextWidth - _loc1_;
            this._goldXPTextStatus = "in";
            this.mcGoldXP.scaleX = 0.1;
            this.mcGoldXP.scaleY = 0.1;
         }
         else if(this._goldXPTextFrameCounter < 7)
         {
            this.mcGoldXP.scaleX += 0.2;
            this.mcGoldXP.scaleY += 0.2;
         }
         else if(this.mcGoldXP.scaleX > 1)
         {
            this.mcGoldXP.scaleX -= 0.1;
            this.mcGoldXP.scaleY -= 0.1;
         }
         else
         {
            this.mcGoldXP.scaleX = 1;
            this.mcGoldXP.scaleY = 1;
            switch(this._lootData[this._lootSlot].type)
            {
               case "gold":
               case "pickupGold":
                  this._flowStatus = [this.STATUS_WAITING_FOR_COLLECTING_GOLD];
                  break;
               case "xp":
                  this._flowStatus = [this.STATUS_WAITING_FOR_COLLECTING_XP];
                  break;
               case "tokens":
                  this._flowStatus = [this.STATUS_WAITING_FOR_COLLECTING_TOKENS];
            }
         }
         ++this._goldXPTextFrameCounter;
         this.resetGoldXPPosition();
      }
      
      private function addRewardToProfile() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = uint(this._lootData[this._lootSlot].amount);
         switch(this._lootData[this._lootSlot].type)
         {
            case "tokens":
               _loc1_.tokens_bonus += _loc2_;
               _loc1_.tokens += _loc2_;
               break;
            case "gold":
            case "pickupGold":
               _loc1_.gold += _loc2_;
               break;
            case "xp":
               _loc1_.lastXPGained = _loc2_;
               _loc1_.XP += _loc2_;
               if(_loc1_.level < dataM.LEVEL_MAX)
               {
                  if(dataM.levelUpDB[_loc1_.level + 1] <= _loc1_.XP)
                  {
                     if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL)
                     {
                        _loc1_.lastGoldFromLevelUp = 2000 + (_loc1_.level - 1) * 200;
                     }
                     ++_loc1_.level;
                     if(_loc1_.lastGoldFromLevelUp > 0)
                     {
                        _loc1_.gold += _loc1_.lastGoldFromLevelUp;
                     }
                     if(_loc1_.lastTokensFromLevelUp > 0)
                     {
                        _loc1_.tokens += _loc1_.lastTokensFromLevelUp;
                        _loc1_.tokens_bonus += _loc1_.lastTokensFromLevelUp;
                     }
                     if(this._openedFrom == "DailyLoginStreak")
                     {
                        screensM.addScreen("screenTopBar",false);
                     }
                     screensM.screenTopBar.displayLevelUpPopUp();
                  }
               }
               if(this._openedFrom == "")
               {
                  screensM.screenTopBar.refreshScreen(true);
               }
         }
      }
      
      private function createGoldCoins(param1:uint) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Sprite = null;
         var _loc9_:Boolean = false;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:Sprite = null;
         var _loc13_:Sprite = null;
         this.removeGoldCoins();
         this.mcGoldCoinsBackHolder.scaleX = 1;
         this.mcGoldCoinsBackHolder.scaleY = 1;
         this.mcGoldCoinsFrontHolder.scaleX = 1;
         this.mcGoldCoinsFrontHolder.scaleY = 1;
         this.mcGoldCoinsBackHolder_reflection.scaleX = 1;
         this.mcGoldCoinsBackHolder_reflection.scaleY = 1;
         this.mcGoldCoinsFrontHolder_reflection.scaleX = 1;
         this.mcGoldCoinsFrontHolder_reflection.scaleY = 1;
         if(param1 > 26)
         {
            param1 = 26;
         }
         else if(param1 < 7)
         {
            param1 = 7;
         }
         this._collectGoldCoinsFramesPerCoin = 3;
         this._collectGoldCoinsYScaleChange = 0.3;
         if(param1 > 10)
         {
            if(param1 > 20)
            {
               this._collectGoldCoinsFramesPerCoin = 1;
               this._collectGoldCoinsYScaleChange = 0.9;
            }
            else
            {
               this._collectGoldCoinsFramesPerCoin = 2;
               this._collectGoldCoinsYScaleChange = 0.45;
            }
         }
         this._collectGoldCoinsFramesPerCoin = 1;
         this._collectGoldCoinsYScaleChange = 1;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 11;
         var _loc6_:uint = 4;
         _loc7_ = 0;
         while(_loc7_ < param1)
         {
            _loc8_ = new mcGoldCoin();
            _loc9_ = false;
            _loc10_ = (_loc7_ + 1) % 6;
            if(_loc10_ <= 2)
            {
               _loc11_ = "center";
               _loc8_.y = -_loc2_ * _loc5_;
               this.mcGoldCoinsFrontHolder.addChild(_loc8_);
               if(_loc2_ <= _loc6_)
               {
                  _loc9_ = true;
               }
               _loc2_++;
            }
            else if(_loc10_ <= 4)
            {
               _loc11_ = "left";
               _loc8_.x = -40;
               _loc8_.y = -_loc3_ * _loc5_;
               this.mcGoldCoinsBackHolder.addChild(_loc8_);
               if(_loc3_ <= _loc6_ + 1)
               {
                  _loc9_ = true;
               }
               _loc3_++;
            }
            else
            {
               _loc11_ = "right";
               _loc8_.x = 40;
               _loc8_.y = -_loc4_ * _loc5_;
               this.mcGoldCoinsBackHolder.addChild(_loc8_);
               if(_loc4_ <= _loc6_ + 1)
               {
                  _loc9_ = true;
               }
               _loc4_++;
            }
            this._goldCoins.push(_loc8_);
            if(_loc9_)
            {
               _loc12_ = new mcGoldCoin();
               _loc12_.x = this._goldCoins[_loc7_].x;
               _loc12_.y = this._goldCoins[_loc7_].y * -1 + 10;
               switch(_loc11_)
               {
                  case "center":
                     this.mcGoldCoinsFrontHolder_reflection.addChild(_loc12_);
                     break;
                  default:
                     this.mcGoldCoinsBackHolder_reflection.addChild(_loc12_);
               }
               this._goldCoinsReflections.push(_loc12_);
            }
            else
            {
               this._goldCoinsReflections.push(null);
            }
            _loc7_++;
         }
         _loc7_ = this._goldCoinsReflections.length - 1;
         while(_loc7_ >= 0)
         {
            if(this._goldCoinsReflections[_loc7_] != null)
            {
               _loc13_ = this._goldCoinsReflections[_loc7_].parent;
               _loc13_.removeChild(this._goldCoinsReflections[_loc7_]);
               _loc13_.addChild(this._goldCoinsReflections[_loc7_]);
            }
            _loc7_--;
         }
      }
      
      private function collectGoldCoinsHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.mcGoldXP.visible)
         {
            if(this.mcGoldXP.scaleX > 0.2)
            {
               this.mcGoldXP.scaleX -= 0.2;
               this.mcGoldXP.scaleY -= 0.2;
               if(this.mcGoldXP.scaleX <= 0.2)
               {
                  this.mcGoldXP.visible = false;
                  this.mcGoldXP.scaleX = 1;
                  this.mcGoldXP.scaleY = 1;
               }
            }
            this.resetGoldXPPosition();
         }
         if(this._generalGoldCoinsCollectionAnimationFrameCounter == 0)
         {
            TsLogger.log("_singleGoldCoinAnimationFrameCounter:" + this._singleGoldCoinAnimationFrameCounter);
            this.addRewardToProfile();
         }
         if(this._openedFrom == "DailyLoginStreak")
         {
            if(this.mcGoldCoinsBackHolder.scaleX > 0.1)
            {
               this.mcGoldCoinsBackHolder.scaleX -= 0.15;
               this.mcGoldCoinsBackHolder.scaleY -= 0.15;
               this.mcGoldCoinsFrontHolder.scaleX -= 0.15;
               this.mcGoldCoinsFrontHolder.scaleY -= 0.15;
               this.mcGoldCoinsBackHolder_reflection.scaleX -= 0.15;
               this.mcGoldCoinsBackHolder_reflection.scaleY -= 0.15;
               this.mcGoldCoinsFrontHolder_reflection.scaleX -= 0.15;
               this.mcGoldCoinsFrontHolder_reflection.scaleY -= 0.15;
            }
            else
            {
               this.removeGoldCoins();
               ++this._lootSlot;
               this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
            }
         }
         else if(this._goldCoins.length > 0)
         {
            _loc1_ = this._goldCoins.length - 1;
            if(this._singleGoldCoinAnimationFrameCounter < this._collectGoldCoinsFramesPerCoin)
            {
               if(this._singleGoldCoinAnimationFrameCounter == 0)
               {
                  if(this._goldCoinsReflections[_loc1_] != null)
                  {
                     this._goldCoinsReflections[_loc1_].parent.removeChild(this._goldCoinsReflections[_loc1_]);
                     this._goldCoinsReflections[_loc1_] = null;
                  }
                  else
                  {
                     this._goldCoinsReflections.splice(_loc1_,1);
                  }
               }
               this._goldCoins[_loc1_].y -= 4 + this._singleGoldCoinAnimationFrameCounter * 2;
               this._goldCoins[_loc1_].scaleY += this._collectGoldCoinsYScaleChange;
               ++this._singleGoldCoinAnimationFrameCounter;
            }
            else
            {
               _loc2_ = this._goldCoins[_loc1_].x + this._goldCoins[_loc1_].parent.x;
               _loc3_ = this._goldCoins[_loc1_].y + this._goldCoins[_loc1_].parent.y - 30;
               effectsM.createFlyingGoldCoinEffect(_loc2_,_loc3_);
               this._goldCoins[_loc1_].parent.removeChild(this._goldCoins[_loc1_]);
               this._goldCoins[_loc1_] = null;
               this._goldCoins.splice(_loc1_,1);
               this._singleGoldCoinAnimationFrameCounter = 0;
            }
         }
         else
         {
            ++this._lootSlot;
            this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
         }
         ++this._generalGoldCoinsCollectionAnimationFrameCounter;
      }
      
      private function removeGoldCoins() : void
      {
         var _loc1_:uint = 0;
         if(this._goldCoins != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._goldCoins.length)
            {
               this._goldCoins[_loc1_].parent.removeChild(this._goldCoins[_loc1_]);
               this._goldCoins[_loc1_] = null;
               _loc1_++;
            }
         }
         this._goldCoins = new Array();
         if(this._goldCoinsReflections != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._goldCoinsReflections.length)
            {
               if(this._goldCoinsReflections[_loc1_] != null)
               {
                  this._goldCoinsReflections[_loc1_].parent.removeChild(this._goldCoinsReflections[_loc1_]);
                  this._goldCoinsReflections[_loc1_] = null;
               }
               _loc1_++;
            }
         }
         this._goldCoinsReflections = new Array();
      }
      
      private function collectXPHandler() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._openedFrom == "")
         {
            if(this._collectXPFrameCounter <= 0)
            {
               _loc3_ = this.mcGoldXP.x + this.mcGoldXP.mcXP.x * this.mcGoldXP.scaleX;
               _loc4_ = this.mcGoldXP.y + this.mcGoldXP.mcXP.y * this.mcGoldXP.scaleY;
               effectsM.createFlyingGoldCoinEffect(_loc3_,_loc4_,true);
               this._collectXPFrameCounter = 3;
            }
         }
         var _loc1_:Number = int(this.mcGoldXP.txtAmount.text);
         var _loc2_:uint = Math.ceil(this._lootData[this._lootSlot].amount / 15);
         if(_loc2_ < 5)
         {
            _loc2_ = 5;
         }
         if(_loc1_ > _loc2_)
         {
            _loc1_ -= _loc2_;
         }
         this.mcGoldXP.txtAmount.text = String(_loc1_);
         --this._collectXPFrameCounter;
         if(_loc1_ <= _loc2_)
         {
            this.mcGoldXP.visible = false;
            this.mcGoldXP.scaleX = 1;
            this.mcGoldXP.scaleY = 1;
            ++this._lootSlot;
            this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
         }
      }
      
      private function removeXPStars() : void
      {
         var _loc1_:uint = 0;
         if(this._xpStars != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._xpStars.length)
            {
               this._xpStars[_loc1_].parent.removeChild(this._xpStars[_loc1_]);
               this._xpStars[_loc1_] = null;
               _loc1_++;
            }
         }
         this._xpStars = new Array();
      }
      
      private function collectTokensHandler() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._openedFrom == "")
         {
            if(this._collectTokensFrameCounter <= 0)
            {
               _loc2_ = this.mcGoldXP.x + this.mcGoldXP.mcXP.x * this.mcGoldXP.scaleX;
               _loc3_ = this.mcGoldXP.y + this.mcGoldXP.mcXP.y * this.mcGoldXP.scaleY;
               effectsM.createFlyingGoldCoinEffect(_loc2_,_loc3_,false,true);
               this._collectTokensFrameCounter = 3;
            }
         }
         var _loc1_:Number = int(this.mcGoldXP.txtAmount.text);
         if(_loc1_ > 1)
         {
            _loc1_--;
         }
         this.mcGoldXP.txtAmount.text = String(_loc1_);
         --this._collectTokensFrameCounter;
         if(_loc1_ <= 1)
         {
            this.mcGoldXP.visible = false;
            this.mcGoldXP.scaleX = 1;
            this.mcGoldXP.scaleY = 1;
            ++this._lootSlot;
            this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
            this.txtFirstClearBonus.visible = false;
         }
      }
      
      private function itemBoxHandler() : void
      {
         if(this._lootData[this._lootSlot].boostId != undefined)
         {
            this.mcItemBox.gotoAndStop("itemBox" + this._lootData[this._lootSlot].boostId);
         }
         this.mcItemBox.visible = true;
         this.mcRays.visible = true;
         if(this._itemBoxFrameCounter == 0)
         {
            this.mcItemBox.scaleX = 0.1;
            this.mcItemBox.scaleY = 0.1;
         }
         else if(this._itemBoxFrameCounter < 7)
         {
            this.mcItemBox.scaleX += 0.2;
            this.mcItemBox.scaleY += 0.2;
         }
         else if(this.mcItemBox.scaleX > 1)
         {
            this.mcItemBox.scaleX -= 0.1;
            this.mcItemBox.scaleY -= 0.1;
         }
         else
         {
            this.mcItemBox.scaleX = 1;
            this.mcItemBox.scaleY = 1;
            this._flowStatus = [this.STATUS_WAITING_TO_OPEN_ITEM_BOX];
         }
         ++this._itemBoxFrameCounter;
      }
      
      private function addItemBox() : void
      {
         this.mcRays.visible = true;
         var _loc1_:Number = Number(this._lootData[this._lootSlot].itemID);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_];
         var _loc3_:String = dataM.itemTypeSourceDB[_loc2_.type];
         this.setTitle(_loc2_.fullName);
         var _loc4_:MovieClip = externalAssetsM.getAsset(_loc3_,_loc2_.grp,this.mcItemSizer.width,this.mcItemSizer.height,true,false);
         _loc4_.x = -_loc4_.width / 2;
         _loc4_.y = -_loc4_.height / 2;
         this._itemIcon = new MovieClip();
         this._itemIcon.addChild(_loc4_);
         addChild(this._itemIcon);
         this._itemIcon.x = this.mcItemSizer.x + _loc4_.width / 2;
         this._itemIcon.y = this.mcItemSizer.y + _loc4_.height / 2;
         this._itemIcon.mouseChildren = false;
         this._itemIcon.mouseEnabled = false;
         TweenMax.fromTo(this._itemIcon,0.3,{
            "scaleX":0.1,
            "scaleY":0.1
         },{
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.onItemAnimComplete
         });
      }
      
      private function onItemAnimComplete() : void
      {
         TweenMax.to(this._itemIcon,0.3,{
            "scaleX":1.05,
            "scaleY":1.05,
            "yoyo":true,
            "repeat":-1
         });
         this._flowStatus = [this.STATUS_WAITING_FOR_COLLECT_ITEM];
      }
      
      private function hitAreaClicked(param1:MouseEvent) : void
      {
         this.hitAreaClickedSub();
      }
      
      public function hitAreaClickedSub() : void
      {
         switch(this._flowStatus[0])
         {
            case this.STATUS_WAITING_FOR_COLLECTING_GOLD:
               this._singleGoldCoinAnimationFrameCounter = 0;
               this._generalGoldCoinsCollectionAnimationFrameCounter = 0;
               this._flowStatus = [this.STATUS_COLLECTING_GOLD];
               break;
            case this.STATUS_WAITING_FOR_COLLECTING_XP:
               this.addRewardToProfile();
               this._collectXPFrameCounter = 0;
               this._xpStars = new Array();
               this._flowStatus = [this.STATUS_COLLECTING_XP];
               break;
            case this.STATUS_WAITING_FOR_COLLECTING_TOKENS:
               this.addRewardToProfile();
               this._collectTokensFrameCounter = 0;
               this._flowStatus = [this.STATUS_COLLECTING_TOKENS];
               break;
            case this.STATUS_WAITING_FOR_COLLECT_ITEM:
               if(this._itemIcon != null)
               {
                  TweenMax.killTweensOf(this._itemIcon);
                  this._itemIcon.parent.removeChild(this._itemIcon);
                  this._itemIcon = null;
               }
               ++this._lootSlot;
               this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
               break;
            case this.STATUS_WAITING_TO_OPEN_ITEM_BOX:
               this._flowStatus = [this.STATUS_OPEN_ITEM_BOX];
               break;
            case this.STATUS_WAITING_TO_OPEN_LOOT_CRATE:
               this._flowStatus = [this.STATUS_OPENING_LOOT_CRATE];
               this._lootCrateFrameCounter = 0;
               this._lootCrateXSpeed = 50;
               break;
            case this.STATUS_WAITING_TO_CLOSE_SCREEN:
               this.closeClicked();
         }
      }
      
      public function itemCardsScreenClosed() : void
      {
         this.mcItemBox.visible = false;
         this.mcRays.visible = false;
         this._lootCrateFrameCounter = 0;
         this._lootCrateVibrationFrameCounter = 0;
         ++this._lootSlot;
         this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
      }
      
      private function resetGoldXPPosition() : void
      {
         if(this.mcGoldXP.mcGold.visible)
         {
            this.mcGoldXP.x = this.mcGoldXPTextPosition.x - this.mcGoldXP.scaleX * this._goldXPTextEmptyTextWidth - this.mcGoldXP.scaleX * this._goldXPTextVisibleTextWidth / 2 + 10;
         }
         else if(this.mcGoldXP.mcTokens.visible)
         {
            this.mcGoldXP.x = this.mcGoldXPTextPosition.x - this.mcGoldXP.scaleX * this._goldXPTextEmptyTextWidth - this.mcGoldXP.scaleX * this._goldXPTextVisibleTextWidth / 2 - 10;
         }
         else
         {
            this.mcGoldXP.x = this.mcGoldXPTextPosition.x - this.mcGoldXP.scaleX * this._goldXPTextEmptyTextWidth - this.mcGoldXP.scaleX * this._goldXPTextVisibleTextWidth / 2;
         }
         if(this.mcGoldXP.mcGold.visible)
         {
            this.mcGoldXP.y = this.mcGoldXPTextPosition.y - this.mcGoldXP.height / 2;
         }
         else if(this.mcGoldXP.mcTokens.visible)
         {
            this.mcGoldXP.y = this.mcGoldXPTextPosition.y - 110;
         }
         else
         {
            this.mcGoldXP.y = this.mcGoldXPTextPosition.y - this.mcGoldXP.height / 2 - 100;
         }
      }
      
      private function activateFinger() : void
      {
         this.deactivateFinger();
         this._fingerHandler = true;
         this._fingerWaitFrames = 50;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.currentMissionSlot > 0)
         {
            this._fingerWaitFrames = 200;
         }
         else if(this._waitingToOpenLootCrate == false)
         {
            this._fingerWaitFrames += 50;
         }
         this._fingerFrameCounter = 0;
      }
      
      private function deactivateFinger() : void
      {
         this._fingerHandler = false;
         this.mcFinger.visible = false;
         this.mcFinger.x = this._fingerOriginXPos;
         this.mcFinger.y = this._fingerOriginYPos;
      }
      
      private function fingerHandler() : void
      {
         if(this._fingerHandler)
         {
            if(this._fingerWaitFrames > 0)
            {
               --this._fingerWaitFrames;
               if(this._fingerWaitFrames == 0)
               {
                  this.mcFinger.visible = true;
               }
            }
            else
            {
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
      }
      
      private function getSourceNotificationID() : int
      {
         var _loc1_:int = 0;
         if(this._openedFrom == "FreePackages")
         {
            _loc1_ = 0;
            while(_loc1_ < this._lootData.length)
            {
               if(this._lootData[_loc1_].id != null)
               {
                  return this._lootData[_loc1_].id;
               }
               _loc1_++;
            }
         }
         return BMNotificationsManager.NO_NOTIFICATION_ID;
      }
      
      public function closeClicked() : void
      {
         var _loc1_:int = 0;
         if(screensM.screenBlack.isActive() == false)
         {
            _loc1_ = this.getSourceNotificationID();
            this._lootData = new Array();
            this.btnClose.disableMe();
            if(this._openedFrom == "DailyLoginStreak")
            {
               this.removeMe();
               screensM.screenDailyLoginStreakBonus.closeScreen();
            }
            else if(this._openedFrom == "FreePackages")
            {
               this.removeMe();
               BMShopManager.gi().showSpecialBoxses(this._openedFrom);
               BMShopManager.gi().setSourceNotificationID(_loc1_);
            }
            else if(screensM.isScreenOpened("screenMissionBaseMap"))
            {
               if(tutorialM.isTutorialActive() == false && dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_COMPLETE_MISSION))
               {
                  screensM.addScreen("screenWatchRewardedVideo");
                  screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_COMPLETE_MISSION);
                  this.removeMe();
               }
               else
               {
                  screensM.screenMissionBaseMap.exitScreen();
               }
            }
            else
            {
               this.removeMe();
            }
         }
      }
      
      public function removeMe() : void
      {
         this.removeGoldCoins();
         this.removeXPStars();
         screensM.removeScreen("screenMissionCompleted");
      }
   }
}

