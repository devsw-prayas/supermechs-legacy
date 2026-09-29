package net.battleMechsMulti.screens.rewards
{
   import com.greensock.TweenMax;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMDisplayRewardData;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMLevelUpManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.navigatePlayerToRecommendedMission.BMNavigatePlayerToRecommendedMissionResolver;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   import net.battleMechsMulti.screens.inventory.BMInventoryTileListItem;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1034")]
   public class BMScreenDisplayReward extends BMBaseScreen
   {
      
      public static const REWARD_TYPE_GOLD:String = "gold";
      
      public static const REWARD_TYPE_XP:String = "xp";
      
      public static const REWARD_TYPE_PICKUP_GOLD:String = "pickupGold";
      
      public static const REWARD_TYPE_TOKENS:String = "tokens";
      
      public static const REWARD_TYPE_ITEM_BOX:String = "itemBox";
      
      public static const REWARD_TYPE_BATTLE_CREDITS:String = "battleCredits";
      
      public static const REWARD_TYPE_FREE_BOX:String = "freeBox";
      
      public static const REWARD_TYPE_ITEM:String = "item";
      
      public static const REWARD_TYPE_CLAN_COINS:String = "clanCoins";
      
      public static const REWARD_TYPE_BOX_FRAGMENTS:String = "boxFragments";
      
      public static const REWARD_TYPE_KIN:String = "kin";
      
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
      
      public var mcBlackCover:Sprite;
      
      public var mcSizer_btnClose:Sprite;
      
      public var txtFirstClearBonus:TextField;
      
      public var btnClose:BMButton;
      
      public var mcGoldXP:MovieClip;
      
      public var mcItemBox:MovieClip;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcFinger:Sprite;
      
      public var txtRemaining:TextField;
      
      public var txtBarAmount:TextField;
      
      public var txtFragmentsTitle:TextField;
      
      public var mcBar:BMBar;
      
      private var mcLootCrate:MovieClip;
      
      private var mcLootCrateCenter:MovieClip;
      
      private var mcLootCrateLeft:MovieClip;
      
      private var mcLootCrateRight:MovieClip;
      
      private var _firstRefresh:Boolean = true;
      
      private var _lootData:Vector.<BMDisplayRewardData>;
      
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
      
      private var _collectBattleCreditsFrameCounter:uint = 0;
      
      private var _collectClanCoinsFrameCounter:uint = 0;
      
      private var _collectKinFrameCounter:uint = 0;
      
      private var _addItemsToInventory:Boolean;
      
      private var _rewardsFinalized:Boolean = false;
      
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
      
      private const STATUS_SHOWING_BATTLE_CREDITS:uint = 25;
      
      private const STATUS_WAITING_FOR_COLLECTING_BATTLE_CREDITS:uint = 26;
      
      private const STATUS_COLLECTING_BATTLE_CREDITS:uint = 27;
      
      private const STATUS_SHOWING_CLAN_COINS:uint = 28;
      
      private const STATUS_WAITING_FOR_COLLECTING_CLAN_COINS:uint = 29;
      
      private const STATUS_COLLECTING_CLAN_COINS:uint = 30;
      
      private const STATUS_SHOWING_KIN:uint = 31;
      
      private const STATUS_WAITING_FOR_COLLECTING_KIN:uint = 32;
      
      private const STATUS_COLLECTING_KIN:uint = 33;
      
      private const MIX_BOX_VISUAL_ID:uint = 25;
      
      private var _fragmentsCounter:uint;
      
      private const FRAGMENTS_BAR_ALPHA_IN_FRAMES:uint = 10;
      
      private const FRAGMENTS_BAR_ANIMATION_START_FRAME:uint = 20;
      
      private var _skipAutoClosing:Boolean = false;
      
      private var _closingScreen:Boolean = false;
      
      public function BMScreenDisplayReward()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("displayReward");
         sub(BMPubSub.MESSAGE_SCREENS_DIRECTOR_STARTED_PERFORMING_TASKS,this.screensDirectorStartedPerformingTasks);
      }
      
      public function refreshScreen(param1:Array, param2:String = "", param3:Boolean = true) : void
      {
         var _loc7_:Function = null;
         var _loc8_:BMDisplayRewardData = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_DISPLAY_REWARD,"btnClose","regular");
            _loc7_ = this.closeClicked;
            if(dataM.runAsMobile)
            {
               _loc7_ = null;
            }
            this.btnClose.initialize(getGeneralText("OK"),"blue",null,null,_loc7_,dataM.runAsMobile);
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
            this.mcBar.initialize(BMBar.COLOR_BLUE);
            this.languageUpdate();
            addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._lootData = new Vector.<BMDisplayRewardData>();
         var _loc5_:BMDisplayRewardData = param1[0];
         if(_loc5_.type != REWARD_TYPE_TOKENS && _loc4_.mission_gold > 0)
         {
            this._lootData.push({
               "type":REWARD_TYPE_PICKUP_GOLD,
               "amount":_loc4_.mission_gold
            });
            _loc4_.mission_gold = 0;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < param1.length)
         {
            _loc8_ = param1[_loc6_];
            this._lootData.push(_loc8_);
            if(_loc6_ == 0)
            {
               if(_loc5_.type == REWARD_TYPE_TOKENS && _loc4_.mission_gold > 0)
               {
                  this._lootData.push({
                     "type":REWARD_TYPE_PICKUP_GOLD,
                     "amount":_loc4_.mission_gold
                  });
                  _loc4_.mission_gold = 0;
               }
            }
            _loc6_++;
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
         this._addItemsToInventory = param3;
         this.txtRemaining.text = "";
         this.txtFragmentsTitle.text = "";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionCompleted_remaining",[this.txtRemaining],"",this);
         }
         this.mcLootCrate.gotoAndStop(_loc4_.mission_difficulty);
         this.mcLootCrateLeft.gotoAndStop(_loc4_.mission_difficulty);
         this.mcLootCrateRight.gotoAndStop(_loc4_.mission_difficulty);
         this.mcItemBox.gotoAndStop(_loc4_.mission_difficulty);
         this.mcLootCrate.visible = false;
         this.mcLootCrateCenter.visible = false;
         this.mcLootCrateLeft.visible = false;
         this.mcLootCrateRight.visible = false;
         this.mcGoldXP.visible = false;
         this.mcItemBox.visible = false;
         this.mcReflection.visible = false;
         this.mcCloseFrame.visible = false;
         this.mcRays.visible = false;
         this.hideBar();
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
         if(param1 != null && param1.length > 0)
         {
            updateTextAndFormat(this.mcBackground.txtTitle,param1);
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionCompleted_title",[this.mcBackground.txtTitle],"",this.mcBackground);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null && this._closingScreen == false)
         {
            this.generalFlowHandler();
         }
         if(this.mcRays.visible)
         {
            this.mcRays.rotation += 0.5;
         }
      }
      
      private function stopActiveAnimation(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._flowStatus.length)
         {
            switch(this._flowStatus[_loc2_])
            {
               case this.STATUS_SCREEN_ENTER:
                  this.endScreenEnterAnimation();
                  break;
               case this.STATUS_SHOWING_GOLD:
               case this.STATUS_SHOWING_XP:
               case this.STATUS_SHOWING_TOKENS:
               case this.STATUS_SHOWING_BATTLE_CREDITS:
                  this.endShowingGoldXPAnim();
                  break;
               case this.STATUS_COLLECTING_GOLD:
                  this.endCollectingGoldCoinsAnim();
                  break;
               case this.STATUS_COLLECTING_XP:
                  this.endCollectingXPAnim();
                  break;
               case this.STATUS_COLLECTING_TOKENS:
                  this.endCollectingTokensAnim();
                  break;
               case this.STATUS_COLLECTING_BATTLE_CREDITS:
                  this.endCollectingBattleCreditsAnim();
                  break;
               case this.STATUS_COLLECTING_CLAN_COINS:
                  this.endCollectingClanCoinsAnim();
                  break;
               case this.STATUS_COLLECTING_KIN:
                  this.endCollectingKinAnim();
                  break;
               case this.STATUS_SHOWING_ITEM_BOX:
                  this.endShowingItemBoxAnim(param1);
            }
            _loc2_++;
         }
      }
      
      private function generalFlowHandler() : void
      {
         var _loc2_:Object = null;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Object = null;
         var _loc8_:uint = 0;
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
                        case REWARD_TYPE_GOLD:
                           this._goldXPTextFrameCounter = 0;
                           this._flowStatus = [this.STATUS_SHOWING_GOLD];
                           break;
                        case REWARD_TYPE_XP:
                           this._goldXPTextFrameCounter = 0;
                           this._flowStatus = [this.STATUS_SHOWING_XP];
                           break;
                        case REWARD_TYPE_ITEM_BOX:
                           this._itemBoxFrameCounter = 0;
                           this._flowStatus = [this.STATUS_SHOWING_ITEM_BOX];
                           break;
                        case REWARD_TYPE_BATTLE_CREDITS:
                           this._goldXPTextFrameCounter = 0;
                           this._flowStatus = [this.STATUS_SHOWING_BATTLE_CREDITS];
                           break;
                        case REWARD_TYPE_CLAN_COINS:
                           this._goldXPTextFrameCounter = 0;
                           this._flowStatus = [this.STATUS_SHOWING_CLAN_COINS];
                           break;
                        case REWARD_TYPE_KIN:
                           this._goldXPTextFrameCounter = 0;
                           this._flowStatus = [this.STATUS_SHOWING_KIN];
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
               case this.STATUS_SHOWING_BATTLE_CREDITS:
                  this.showingGoldXP();
                  break;
               case this.STATUS_COLLECTING_BATTLE_CREDITS:
                  this.collectBattleCreditsHandler();
                  break;
               case this.STATUS_WAITING_FOR_COLLECTING_BATTLE_CREDITS:
                  break;
               case this.STATUS_SHOWING_CLAN_COINS:
                  this.showingGoldXP();
                  break;
               case this.STATUS_COLLECTING_CLAN_COINS:
                  this.collectClanCoinsHandler();
                  break;
               case this.STATUS_WAITING_FOR_COLLECTING_CLAN_COINS:
                  break;
               case this.STATUS_SHOWING_KIN:
                  this.showingGoldXP();
                  break;
               case this.STATUS_COLLECTING_KIN:
                  this.collectKinHandler();
                  break;
               case this.STATUS_WAITING_FOR_COLLECTING_KIN:
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
                  _loc2_ = this._lootData[this._lootSlot];
                  _loc3_ = this._lootData[this._lootSlot].id > 0;
                  _loc4_ = 0;
                  if(this._addItemsToInventory == false && _loc2_.items != null)
                  {
                     _loc4_ = uint(_loc2_.items.length);
                     if(this._lootData[this._lootSlot].boostID == 0 && _loc2_.items.length > 0)
                     {
                        _loc4_ = 100000;
                     }
                  }
                  if(dataM.isInventoryFull(true,_loc4_) && _loc3_ == false)
                  {
                     screensM.addScreen(BMScreensManager.SCR_GET_ITEMS_NO_SPACE);
                     if(this._addItemsToInventory && this._lootData[this._lootSlot].boostID > 0)
                     {
                        dataM.myProfile.addFreePackages(new <uint>[this._lootData[this._lootSlot].boostID]);
                     }
                  }
                  else if(this._lootData[this._lootSlot].boostID > 0)
                  {
                     if(_loc3_)
                     {
                        remoteM.tokens_redeemPackage(this._lootData[this._lootSlot].boostID,this._lootData[this._lootSlot].id);
                     }
                     else
                     {
                        BMShopManager.gi().tryToClaimFreeBoost(this._lootData[this._lootSlot].boostID);
                     }
                  }
                  else
                  {
                     _loc5_ = new Array();
                     _loc6_ = new Array();
                     for each(_loc7_ in _loc2_.items)
                     {
                        if(this._addItemsToInventory)
                        {
                           dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,_loc7_.itemID,_loc7_.playerItemID,0,0,0);
                        }
                        _loc5_.push(_loc7_.itemID);
                        _loc6_.push(_loc7_.playerItemID);
                     }
                     screensM.addScreen(BMScreensManager.SCR_ITEM_CARDS);
                     TsLogger.log("Loot data" + JSON.stringify(this._lootData[this._lootSlot]));
                     _loc8_ = BMShopManager.CUSTOM_ITEMS_BOX_ID;
                     if(this._lootData[this._lootSlot].gachaMachineID > 0)
                     {
                        _loc8_ = this._lootData[this._lootSlot].gachaMachineID;
                     }
                     screensM.screenItemCards.refreshScreen(_loc5_,_loc6_,_loc8_);
                  }
                  this._flowStatus = [this.STATUS_WAITING_FOR_ITEM_CARDS_TO_CLOSE];
                  break;
               case this.STATUS_WAITING_FOR_ITEM_CARDS_TO_CLOSE:
                  break;
               case this.STATUS_ITEM_CARDS_CLOSED:
                  this.mcRays.visible = false;
                  break;
               case this.STATUS_WAITING_TO_CLOSE_SCREEN:
                  if(this._skipAutoClosing == false)
                  {
                     this.closeClicked();
                  }
            }
            _loc1_++;
         }
      }
      
      private function selectingNextLoot() : void
      {
         var _loc1_:String = null;
         if(this._lootSlot >= this._lootData.length)
         {
            this.finalizeRewards();
            this._flowStatus = [this.STATUS_WAITING_TO_CLOSE_SCREEN];
            return;
         }
         switch(this._lootData[this._lootSlot].type)
         {
            case REWARD_TYPE_PICKUP_GOLD:
               this._goldXPTextFrameCounter = 0;
               this._flowStatus = [this.STATUS_SHOWING_GOLD];
               break;
            case REWARD_TYPE_TOKENS:
               this._goldXPTextFrameCounter = 0;
               this._flowStatus = [this.STATUS_SHOWING_TOKENS];
               this.txtFirstClearBonus.visible = true;
               _loc1_ = "";
               if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
               {
                  _loc1_ = getScreenText("firstClearBonus");
               }
               else
               {
                  _loc1_ = getScreenText("yourPrize");
               }
               updateTextAndFormat(this.txtFirstClearBonus,_loc1_);
               break;
            case REWARD_TYPE_GOLD:
            case REWARD_TYPE_XP:
            case REWARD_TYPE_ITEM_BOX:
            case REWARD_TYPE_BATTLE_CREDITS:
            case REWARD_TYPE_CLAN_COINS:
            case REWARD_TYPE_KIN:
               this._lootCrateFrameCounter = 0;
               this._lootCrateVibrationFrameCounter = 0;
               this._flowStatus = [this.STATUS_SHOWING_LOOT_CRATE];
               break;
            case REWARD_TYPE_FREE_BOX:
            case REWARD_TYPE_BOX_FRAGMENTS:
               this._lootCrateFrameCounter = 0;
               this._lootCrateVibrationFrameCounter = 0;
               this._itemBoxFrameCounter = 0;
               if(this._lootData[this._lootSlot].title != null)
               {
                  this.setTitle(this._lootData[this._lootSlot].title);
               }
               this._flowStatus = [this.STATUS_SHOWING_ITEM_BOX];
               break;
            case REWARD_TYPE_ITEM:
               this.addItemBox();
               this._flowStatus = [this.STATUS_SHOWING_ITEM];
         }
      }
      
      private function finalizeRewards() : void
      {
         if(this._rewardsFinalized)
         {
            return;
         }
         this._rewardsFinalized = true;
         var _loc1_:BMPlayerProfile = dataM.myProfile;
         if(_loc1_.level >= dataM.LEVEL_MAX)
         {
            return;
         }
         if(dataM.levelUpDB[_loc1_.level + 1] > _loc1_.XP)
         {
            return;
         }
         _loc1_.level = dataM.getLevelForXp(_loc1_.XP);
         if(this._openedFrom == "DailyLoginStreak")
         {
            screensM.addScreen(BMScreensManager.SCR_TOP_BAR,false);
         }
         BMLevelUpManager.gi().displayLevelUpPopUp();
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
            this.endScreenEnterAnimation();
         }
      }
      
      private function endScreenEnterAnimation() : void
      {
         this.mcBackground.y = this._backgroundOriginYPos;
         this._flowStatus = [this.STATUS_SCREEN_ENTER_DONE];
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
               if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
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
            _loc2_ = this._lootData[this._lootSlot].amount;
            this.mcGoldXP.visible = true;
            this.mcGoldXP.mcGold.visible = false;
            this.mcGoldXP.mcXP.visible = false;
            this.mcGoldXP.mcTokens.visible = false;
            this.mcGoldXP.mcBattleCredits.visible = false;
            this.mcGoldXP.mcClanCoins.visible = false;
            this.mcGoldXP.mcKin.visible = false;
            switch(this._lootData[this._lootSlot].type)
            {
               case REWARD_TYPE_GOLD:
               case REWARD_TYPE_PICKUP_GOLD:
                  this.mcGoldXP.mcGold.visible = true;
                  this.createGoldCoins(Math.ceil(_loc2_ / 50));
                  break;
               case REWARD_TYPE_XP:
                  this.mcGoldXP.mcXP.visible = true;
                  break;
               case REWARD_TYPE_TOKENS:
                  this.mcGoldXP.mcTokens.visible = true;
                  break;
               case REWARD_TYPE_BATTLE_CREDITS:
                  this.mcGoldXP.mcBattleCredits.visible = true;
                  break;
               case REWARD_TYPE_CLAN_COINS:
                  this.mcGoldXP.mcClanCoins.visible = true;
                  break;
               case REWARD_TYPE_KIN:
                  this.mcGoldXP.mcKin.visible = true;
            }
            updateTextAndFormat(this.mcGoldXP.txtAmount,TextUtils.getNumberWithComma(_loc2_));
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
            this.endShowingGoldXPAnim();
         }
         ++this._goldXPTextFrameCounter;
         this.resetGoldXPPosition();
      }
      
      private function endShowingGoldXPAnim() : void
      {
         this.mcGoldXP.scaleX = 1;
         this.mcGoldXP.scaleY = 1;
         switch(this._lootData[this._lootSlot].type)
         {
            case REWARD_TYPE_GOLD:
            case REWARD_TYPE_PICKUP_GOLD:
               this._flowStatus = [this.STATUS_WAITING_FOR_COLLECTING_GOLD];
               break;
            case REWARD_TYPE_XP:
               this._flowStatus = [this.STATUS_WAITING_FOR_COLLECTING_XP];
               break;
            case REWARD_TYPE_TOKENS:
               this._flowStatus = [this.STATUS_WAITING_FOR_COLLECTING_TOKENS];
               break;
            case REWARD_TYPE_BATTLE_CREDITS:
               this._flowStatus = [this.STATUS_WAITING_FOR_COLLECTING_BATTLE_CREDITS];
               break;
            case REWARD_TYPE_CLAN_COINS:
               this._flowStatus = [this.STATUS_WAITING_FOR_COLLECTING_CLAN_COINS];
               break;
            case REWARD_TYPE_KIN:
               this._flowStatus = [this.STATUS_WAITING_FOR_COLLECTING_KIN];
         }
         this.resetGoldXPPosition();
      }
      
      private function addRewardToProfile() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = this._lootData[this._lootSlot].amount;
         switch(this._lootData[this._lootSlot].type)
         {
            case REWARD_TYPE_TOKENS:
               _loc1_.tokens_bonus += _loc2_;
               _loc1_.tokens += _loc2_;
               break;
            case REWARD_TYPE_GOLD:
            case REWARD_TYPE_PICKUP_GOLD:
               _loc1_.gold += _loc2_;
               break;
            case REWARD_TYPE_CLAN_COINS:
               _loc1_.clanCoins += _loc2_;
               break;
            case REWARD_TYPE_XP:
               _loc1_.lastXPGained = _loc2_;
               _loc1_.XP += _loc2_;
               if(this._openedFrom == "" && screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR))
               {
                  screensM.screenTopBar.refreshScreen(true);
               }
               break;
            case REWARD_TYPE_BATTLE_CREDITS:
               _loc1_.battleCredits += _loc2_;
         }
         if(BMShopManager.gi().isScreenOpened())
         {
            if(BMShopManager.gi().currentCategory != BMShopManager.gi().category_kinShop)
            {
               BMShopManager.gi().refresh();
            }
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR))
         {
            screensM.screenTopBar.refreshScreen(false,true);
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
               this.endCollectingGoldCoinsAnim();
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
            this.endCollectingGoldCoinsAnim();
         }
         ++this._generalGoldCoinsCollectionAnimationFrameCounter;
      }
      
      private function endCollectingGoldCoinsAnim() : void
      {
         this.removeGoldCoins();
         ++this._lootSlot;
         this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
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
         updateTextAndFormat(this.mcGoldXP.txtAmount,String(_loc1_));
         --this._collectXPFrameCounter;
         if(_loc1_ <= _loc2_)
         {
            this.endCollectingXPAnim();
         }
      }
      
      private function endCollectingXPAnim() : void
      {
         this.mcGoldXP.visible = false;
         this.mcGoldXP.scaleX = 1;
         this.mcGoldXP.scaleY = 1;
         ++this._lootSlot;
         this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
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
         updateTextAndFormat(this.mcGoldXP.txtAmount,String(_loc1_));
         --this._collectTokensFrameCounter;
         if(_loc1_ <= 1)
         {
            this.endCollectingTokensAnim();
         }
      }
      
      private function endCollectingTokensAnim() : void
      {
         this.mcGoldXP.visible = false;
         this.mcGoldXP.scaleX = 1;
         this.mcGoldXP.scaleY = 1;
         ++this._lootSlot;
         this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
         this.txtFirstClearBonus.visible = false;
      }
      
      private function collectBattleCreditsHandler() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._openedFrom == "")
         {
            if(this._collectBattleCreditsFrameCounter <= 0)
            {
               _loc2_ = this.mcGoldXP.x + this.mcGoldXP.mcXP.x * this.mcGoldXP.scaleX;
               _loc3_ = this.mcGoldXP.y + this.mcGoldXP.mcXP.y * this.mcGoldXP.scaleY;
               this._collectBattleCreditsFrameCounter = 3;
            }
         }
         var _loc1_:Number = int(this.mcGoldXP.txtAmount.text);
         if(_loc1_ > 1)
         {
            _loc1_--;
         }
         updateTextAndFormat(this.mcGoldXP.txtAmount,String(_loc1_));
         --this._collectBattleCreditsFrameCounter;
         if(_loc1_ <= 1)
         {
            this.endCollectingBattleCreditsAnim();
         }
      }
      
      private function endCollectingBattleCreditsAnim() : void
      {
         this.mcGoldXP.visible = false;
         this.mcGoldXP.scaleX = 1;
         this.mcGoldXP.scaleY = 1;
         ++this._lootSlot;
         this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
         this.txtFirstClearBonus.visible = false;
      }
      
      private function collectClanCoinsHandler() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._openedFrom == "")
         {
            if(this._collectClanCoinsFrameCounter <= 0)
            {
               _loc2_ = this.mcGoldXP.x + this.mcGoldXP.mcXP.x * this.mcGoldXP.scaleX;
               _loc3_ = this.mcGoldXP.y + this.mcGoldXP.mcXP.y * this.mcGoldXP.scaleY;
               this._collectClanCoinsFrameCounter = 3;
            }
         }
         var _loc1_:Number = int(this.mcGoldXP.txtAmount.text);
         if(_loc1_ > 1)
         {
            _loc1_ -= 10;
         }
         updateTextAndFormat(this.mcGoldXP.txtAmount,String(_loc1_));
         --this._collectClanCoinsFrameCounter;
         if(_loc1_ <= 1)
         {
            this.endCollectingClanCoinsAnim();
         }
      }
      
      private function endCollectingClanCoinsAnim() : void
      {
         this.mcGoldXP.visible = false;
         this.mcGoldXP.scaleX = 1;
         this.mcGoldXP.scaleY = 1;
         ++this._lootSlot;
         this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
         this.txtFirstClearBonus.visible = false;
      }
      
      private function collectKinHandler() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._openedFrom == "")
         {
            if(this._collectKinFrameCounter <= 0)
            {
               _loc2_ = this.mcGoldXP.x + this.mcGoldXP.mcXP.x * this.mcGoldXP.scaleX;
               _loc3_ = this.mcGoldXP.y + this.mcGoldXP.mcXP.y * this.mcGoldXP.scaleY;
               this._collectKinFrameCounter = 3;
            }
         }
         var _loc1_:Number = int(this.mcGoldXP.txtAmount.text);
         if(_loc1_ > 1)
         {
            _loc1_ -= 2;
         }
         updateTextAndFormat(this.mcGoldXP.txtAmount,String(_loc1_));
         --this._collectKinFrameCounter;
         if(_loc1_ <= 1)
         {
            this.endCollectingKinAnim();
         }
      }
      
      private function endCollectingKinAnim() : void
      {
         this.mcGoldXP.visible = false;
         this.mcGoldXP.scaleX = 1;
         this.mcGoldXP.scaleY = 1;
         ++this._lootSlot;
         this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
         this.txtFirstClearBonus.visible = false;
      }
      
      private function movieClipHasLabel(param1:MovieClip, param2:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc5_:FrameLabel = null;
         var _loc4_:int = int(param1.currentLabels.length);
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.currentLabels[_loc3_];
            if(_loc5_.name == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function get isFragmentsLoot() : Boolean
      {
         return this._lootData[this._lootSlot].type == REWARD_TYPE_BOX_FRAGMENTS;
      }
      
      private function itemBoxHandler() : void
      {
         var _loc3_:int = 0;
         var _loc4_:BMGachaMachineData = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:BMInventoryTileListItem = null;
         var _loc9_:Number = NaN;
         var _loc1_:Boolean = this._lootData[this._lootSlot].gachaMachineID > 0 && this._lootData[this._lootSlot].gachaMachineID > 0;
         var _loc2_:Boolean = this._lootData[this._lootSlot].boostID > 0;
         if(this._itemBoxFrameCounter == 0)
         {
            if(_loc2_ || _loc1_ || this.isFragmentsLoot)
            {
               if(this.isFragmentsLoot)
               {
                  _loc4_ = dataM.getGacheMachine(this._lootData[this._lootSlot].gachaMachineID);
                  if(_loc4_.isSingleItem)
                  {
                     _loc7_ = 100;
                     _loc8_ = dataM.createItemFragmentTileListItem(_loc4_.itemID,_loc7_);
                     _loc8_.x = -_loc7_ / 2;
                     _loc8_.y = -_loc7_ / 2;
                     this.mcEffectsHolder.addChild(_loc8_);
                     _loc3_ = 0;
                  }
                  else
                  {
                     _loc3_ = 500 + _loc4_.imageID;
                  }
                  _loc5_ = getSpecificText("fragments_earned");
                  _loc6_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + this._lootData[this._lootSlot].amount + "</FONT>";
                  _loc5_ = dataM.replaceStringInText(_loc5_,"%AMOUNT%",_loc6_);
                  updateTextAndFormat(this.txtFragmentsTitle,_loc5_);
               }
               else if(_loc2_ && dataM.hasGacheMachine(this._lootData[this._lootSlot].boostID))
               {
                  _loc3_ = int(dataM.getGacheMachine(this._lootData[this._lootSlot].boostID).imageID);
               }
               else if(_loc1_ && dataM.hasGacheMachine(this._lootData[this._lootSlot].gachaMachineID))
               {
                  _loc3_ = int(dataM.getGacheMachine(this._lootData[this._lootSlot].gachaMachineID).imageID);
               }
               else
               {
                  _loc3_ = int(this._lootData[this._lootSlot].boostID);
               }
               if(!this.movieClipHasLabel(this.mcItemBox,"itemBox" + _loc3_))
               {
                  TsLogger.log("No frame label that matches visual id " + _loc3_ + ", showing mix box instead");
                  _loc3_ = int(this.MIX_BOX_VISUAL_ID);
               }
            }
            else
            {
               _loc3_ = int(this.MIX_BOX_VISUAL_ID);
            }
            this.mcItemBox.gotoAndStop("itemBox" + _loc3_);
            if(this.isFragmentsLoot)
            {
               this._fragmentsCounter = 0;
               this.mcBar.alpha = 0;
               _loc9_ = this._lootData[this._lootSlot].fillAnim_amountBefore / this._lootData[this._lootSlot].fillAnim_amountMax;
               this.mcBar.setFill(_loc9_);
            }
         }
         this.mcItemBox.visible = true;
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
         else if(this.isFragmentsLoot == false)
         {
            this.endShowingItemBoxAnim();
         }
         if(this.isFragmentsLoot)
         {
            this.itemBoxHandler_fragments();
         }
         ++this._itemBoxFrameCounter;
      }
      
      private function itemBoxHandler_fragments() : void
      {
         if(this._itemBoxFrameCounter <= this.FRAGMENTS_BAR_ALPHA_IN_FRAMES)
         {
            this.mcBar.alpha += 1 / this.FRAGMENTS_BAR_ALPHA_IN_FRAMES;
            if(this._itemBoxFrameCounter == this.FRAGMENTS_BAR_ALPHA_IN_FRAMES)
            {
               this.mcBar.alpha = 1;
               this.txtBarAmount.text = this._lootData[this._lootSlot].fillAnim_amountBefore + " / " + this._lootData[this._lootSlot].fillAnim_amountMax;
            }
            return;
         }
         if(this._itemBoxFrameCounter < this.FRAGMENTS_BAR_ANIMATION_START_FRAME)
         {
            return;
         }
         var _loc1_:int = int(Math.max(1,Math.min(5,25 / this._lootData[this._lootSlot].amount)));
         if(this._itemBoxFrameCounter % _loc1_ != 0)
         {
            return;
         }
         ++this._fragmentsCounter;
         this.updateFragmentProgressBar(this._fragmentsCounter);
         if(this._fragmentsCounter == this._lootData[this._lootSlot].amount)
         {
            this.endShowingItemBoxAnim();
         }
      }
      
      private function updateFragmentProgressBar(param1:int) : *
      {
         var _loc2_:uint = this._lootData[this._lootSlot].fillAnim_amountBefore + param1;
         var _loc3_:Number = _loc2_ / this._lootData[this._lootSlot].fillAnim_amountMax;
         this.mcBar.setFill(_loc3_,true);
         this.txtBarAmount.text = _loc2_ + " / " + this._lootData[this._lootSlot].fillAnim_amountMax;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionCompleted_txtBarAmount",[this.txtBarAmount],"",this);
         }
      }
      
      private function endShowingItemBoxAnim(param1:Boolean = false) : void
      {
         this.mcItemBox.scaleX = 1;
         this.mcItemBox.scaleY = 1;
         this.mcRays.visible = true;
         if(this.isFragmentsLoot)
         {
            this.updateFragmentProgressBar(this._lootData[this._lootSlot].amount);
            if(this._lootSlot == this._lootData.length - 1)
            {
               this._skipAutoClosing = true;
               this._flowStatus = [this.STATUS_WAITING_TO_CLOSE_SCREEN];
            }
            else if(!param1)
            {
               this._flowStatus = [this.STATUS_WAITING_TO_OPEN_ITEM_BOX];
            }
            else
            {
               this._fragmentsCounter == this._lootData[this._lootSlot].amount;
            }
         }
         else
         {
            this._flowStatus = [this.STATUS_WAITING_TO_OPEN_ITEM_BOX];
         }
      }
      
      private function hideBar() : void
      {
         this.mcBar.alpha = 0;
         this.txtBarAmount.text = "";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionCompleted_txtBarAmount",[this.txtBarAmount],"",this);
         }
      }
      
      private function addItemBox() : void
      {
         var _loc1_:Number = this._lootData[this._lootSlot].itemID;
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_];
         var _loc3_:String = dataM.itemTypeSourceDB[_loc2_.type];
         TsLogger.log("setTitle itemdb fullname");
         this.setTitle(languageM.getItemNameByItemData(_loc2_));
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
         this.mcRays.visible = true;
         this._flowStatus = [this.STATUS_WAITING_FOR_COLLECT_ITEM];
      }
      
      private function hitAreaClicked(param1:MouseEvent) : void
      {
         this.hitAreaClickedSub();
      }
      
      public function hitAreaClickedSub() : void
      {
         this.stopActiveAnimation(true);
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
            case this.STATUS_WAITING_FOR_COLLECTING_BATTLE_CREDITS:
               this.addRewardToProfile();
               this._collectBattleCreditsFrameCounter = 0;
               this._flowStatus = [this.STATUS_COLLECTING_BATTLE_CREDITS];
               break;
            case this.STATUS_WAITING_FOR_COLLECTING_CLAN_COINS:
               this.addRewardToProfile();
               this._collectClanCoinsFrameCounter = 0;
               this._flowStatus = [this.STATUS_COLLECTING_CLAN_COINS];
               break;
            case this.STATUS_WAITING_FOR_COLLECTING_KIN:
               this.addRewardToProfile();
               this._collectKinFrameCounter = 0;
               this._flowStatus = [this.STATUS_COLLECTING_KIN];
               break;
            case this.STATUS_WAITING_FOR_COLLECT_ITEM:
               if(this._itemIcon != null)
               {
                  TweenMax.killTweensOf(this._itemIcon);
                  this._itemIcon.parent.removeChild(this._itemIcon);
                  this._itemIcon = null;
               }
               this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
               break;
            case this.STATUS_WAITING_TO_OPEN_ITEM_BOX:
               if(this.isFragmentsLoot)
               {
                  if(this._lootSlot < this._lootData.length - 1)
                  {
                     this.txtFragmentsTitle.text = "";
                     this.hideBar();
                  }
                  ++this._lootSlot;
                  this._itemBoxFrameCounter = 0;
                  this._flowStatus = [this.STATUS_SELECTING_NEXT_LOOT];
               }
               else
               {
                  this._flowStatus = [this.STATUS_OPEN_ITEM_BOX];
               }
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
               if(this._lootData[_loc1_].id > 0)
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
         if(screensM.screenBlack.isActive())
         {
            return;
         }
         var _loc1_:int = this.getSourceNotificationID();
         this._lootData = new Vector.<BMDisplayRewardData>();
         this.btnClose.disableMe();
         if(this._openedFrom == "DailyLoginStreak")
         {
            this.removeMe(true);
            screensM.screenDailyLoginStreakBonus.closeScreen();
         }
         else if(this._openedFrom == "FreePackages")
         {
            this.removeMe(true);
            if(BMNavigatePlayerToRecommendedMissionResolver.isEnabled == true)
            {
               if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
               {
                  screensM.screenWelcomeBackground.welcomeBackHandlerSub();
               }
            }
            else
            {
               BMShopManager.gi().showItemBoxes(this._openedFrom);
               BMShopManager.gi().setSourceNotificationID(_loc1_);
            }
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
         {
            this.onCloseOverMissionBaseMap();
         }
         else
         {
            this.removeMe(true);
         }
      }
      
      private function onCloseOverMissionBaseMap() : void
      {
         if(tutorialM.isTutorialActive())
         {
            screensM.screenMissionBaseMap.exitScreen();
            return;
         }
         if(dataM.raidData.isRaidInProgress())
         {
            screensM.screenMissionBaseMap.exitScreen();
            return;
         }
         var _loc1_:Boolean = screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_RESULT) && screensM.screenBattleResult.isInNextMissionMode;
         if(_loc1_)
         {
            this.removeMe(true);
            return;
         }
         var _loc2_:BMWorldMapLocationData = dataM.singlePlayerM.currentMissionDB;
         var _loc3_:Boolean = dataM.myProfile.currentStoryID == BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1 && dataM.contentPackResolver.contentPacksEnabled() && _loc2_.chapterID == 1 && dataM.myProfile.currentMissionMode == 0;
         if(_loc3_ == false)
         {
            if(_loc2_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS && dataM.myProfile.currentMissionMode < 2 && dataM.singlePlayerM.finishMissionForFirstTime)
            {
               this.removeMe(true);
               screensM.addScreen(BMScreensManager.SCR_DIFFICULTY_UNLOCKED);
               return;
            }
         }
         if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_COMPLETE_MISSION))
         {
            screensM.addScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO);
            screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_COMPLETE_MISSION,dataM.myProfile.currentMissionSlot);
            this.removeMe(true);
            return;
         }
         screensM.screenMissionBaseMap.exitScreen();
      }
      
      private function screensDirectorStartedPerformingTasks(param1:String, param2:Object) : void
      {
         this.removeMe(true);
      }
      
      public function removeMe(param1:Boolean = false) : void
      {
         if(this._closingScreen)
         {
            return;
         }
         if(param1)
         {
            this.mcBlackCover.alpha = 0;
            TweenMax.to(this,0.5,{
               "y":-480,
               "onComplete":this.removeMeAnimationEnded
            });
            this.mcReflection.visible = false;
            this._closingScreen = true;
         }
         else
         {
            this.removeMeAnimationEnded();
         }
      }
      
      private function removeMeAnimationEnded() : void
      {
         this.finalizeRewards();
         this.removeGoldCoins();
         this.removeXPStars();
         screensM.removeScreen(BMScreensManager.SCR_DISPLAY_REWARD);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this);
      }
   }
}

