package net.battleMechsMulti.screens.levelUp
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.data.BMLevelUpData;
   import net.battleMechsMulti.managers.BMLevelUpManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.unlockedMechSlotsResolver.BMUnlockedMechSlotsResolver;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2653")]
   public class BMScreenLevelUpNew extends BMBaseScreen
   {
      
      public var mcTitle:TextHolder;
      
      public var mcLvl:TextHolder;
      
      public var mcFlare:MovieClip;
      
      public var mcBg:MovieClip;
      
      public var mcSkipHitArea:MovieClip;
      
      public var mcPrizesHolder1:MovieClip;
      
      public var mcPrizesHolder2:MovieClip;
      
      public var mcPrizesHolder3:MovieClip;
      
      public var mcGlow:MovieClip;
      
      public var mcRays:MovieClip;
      
      public var continueBtn:BMBasicButton;
      
      private var _timLine:TimelineMax;
      
      private var _data:BMLevelUpData;
      
      private var _additionalPrizes:Array;
      
      private var _prizes:Vector.<BMLevelUpPrize>;
      
      private var _prizesViewType:uint = 1;
      
      public function BMScreenLevelUpNew()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("levelUp");
         this.initButton();
         this.initTexts();
      }
      
      private function initButton() : void
      {
         this.mcSkipHitArea.addEventListener(MouseEvent.CLICK,this.onSkipAnimClick);
         this.continueBtn.addEventListener(BMIntractable.HIT,this.onContinueClick);
         this.continueBtn.ignoreScreensDirectorTasks();
      }
      
      private function initTexts() : void
      {
         this.mcTitle.text = getScreenText("title");
         this.continueBtn.text = getScreenText("continue");
      }
      
      public function show(param1:BMLevelUpData) : void
      {
         var _loc2_:Number = NaN;
         this._data = param1;
         this._additionalPrizes = dataM.getEquipmentUnlockedListAtLevel(this._data.newLevel);
         if(BMUnlockedMechSlotsResolver.areMechSlotsUnlockedByCampaign())
         {
            _loc2_ = this._additionalPrizes.length - 1;
            while(_loc2_ >= 0)
            {
               if(this._additionalPrizes[_loc2_].substr(0,4) == "mech")
               {
                  this._additionalPrizes.splice(_loc2_,1);
               }
               _loc2_--;
            }
         }
         if(dataM.myProfile.inventorySizeState.maxSize < this._data.inventorySlots)
         {
            this._additionalPrizes.push("inventorySlots");
         }
         if(this._data.hasItemsOrBoxes)
         {
            this._additionalPrizes.push("itemsBox");
         }
         this.mcLvl.text = this._data.newLevel.toString();
         this.doRaysAnimation();
         this.doFirstAnimSeq();
      }
      
      private function doRaysAnimation() : void
      {
         TweenMax.fromTo(this.mcGlow,2,{"alpha":0.6},{
            "alpha":1,
            "repeat":-1,
            "yoyo":true
         });
         TweenMax.fromTo(this.mcRays,50,{"rotation":0},{
            "rotation":360,
            "repeat":-1
         });
         TweenMax.fromTo(this.mcRays,2,{"alpha":0.5},{
            "alpha":1,
            "repeat":-1,
            "yoyo":true,
            "overwrite":0
         });
      }
      
      private function doFirstAnimSeq() : void
      {
         var _loc2_:BMLevelUpPrize = null;
         var _loc3_:uint = 0;
         this._prizes = new Vector.<BMLevelUpPrize>();
         this.resetPrizeHolders();
         this._prizesViewType = 1;
         var _loc1_:Number = 2.25;
         if(this._data.newLevel > 99)
         {
            _loc1_ = 1.33;
         }
         else if(this._data.newLevel > 9)
         {
            _loc1_ = 1.6;
         }
         this._timLine = new TimelineMax();
         this._timLine.fromTo(this,0.5,{"y":-500},{
            "y":0,
            "ease":Back.easeOut
         });
         this._timLine.fromTo(this.mcBg,0.5,{"alpha":0},{"alpha":1},0);
         this._timLine.fromTo(this.mcTitle,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         });
         this._timLine.fromTo(this.mcLvl,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":_loc1_,
            "scaleY":_loc1_,
            "ease":Back.easeOut
         },"-=0.1");
         this._timLine.fromTo(this.mcFlare,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1
         },"-=0.3");
         this._timLine.fromTo(this.mcFlare,0.2,{"alpha":1},{"alpha":0});
         if(this._data.getTokensAmount() > 0)
         {
            _loc2_ = this.addPrize(new localIcon_tokensCentered(),this._data.getTokensAmount());
            this._timLine.add(_loc2_.getShowTimeLine());
         }
         if(this._data.getGoldAmount() > 0)
         {
            _loc2_ = this.addPrize(new localIcon_gold(),this._data.getGoldAmount());
            this._timLine.add(_loc2_.getShowTimeLine(),"-=0.1");
         }
         if(tutorialM.isTutorialActive() == false)
         {
            if(dataM.getGeneralSetting("giveHalfBattleCreditsOnLevelUp",false))
            {
               _loc3_ = this._data.battleCreditsMax / 2;
               _loc2_ = this.addPrize(new battleCreditsIcon(),-1,"+" + _loc3_);
            }
            else
            {
               _loc2_ = this.addPrize(new battleCreditsIcon(),-1,getScreenText("refill"));
            }
            this._timLine.add(_loc2_.getShowTimeLine(),"-=0.1");
         }
         this._timLine.fromTo(this.continueBtn,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         });
         this._timLine.addLabel("end");
      }
      
      private function addPrize(param1:MovieClip, param2:int, param3:String = "") : BMLevelUpPrize
      {
         var _loc5_:MovieClip = null;
         var _loc7_:BMLevelUpPrize = null;
         var _loc4_:Class = LevelUpPrize1;
         var _loc6_:Number = 46.5;
         switch(this._prizesViewType)
         {
            case 1:
               _loc5_ = this.mcPrizesHolder1;
               break;
            case 2:
               _loc5_ = this.mcPrizesHolder2;
               break;
            case 3:
               _loc4_ = LevelUpPrize2;
               _loc5_ = this.mcPrizesHolder3;
               _loc6_ = 80.5;
         }
         _loc7_ = new _loc4_();
         _loc7_.setContent(param1,param2,param3);
         _loc7_.y = this._prizes.length * _loc6_;
         _loc5_.addChild(_loc7_);
         this._prizes.push(_loc7_);
         return _loc7_;
      }
      
      private function resetPrizeHolders() : void
      {
         this.mcPrizesHolder1.removeChildren();
         this.mcPrizesHolder2.removeChildren();
         this.mcPrizesHolder3.removeChildren();
      }
      
      private function onSkipAnimClick(param1:MouseEvent) : void
      {
         this._timLine.seek("end");
      }
      
      private function onContinueClick(param1:Event) : void
      {
         if(this._additionalPrizes.length == 0)
         {
            this.backClicked();
            return;
         }
         this.doAdditionalPrizesAnimSeq();
      }
      
      private function doAdditionalPrizesAnimSeq() : void
      {
         var _loc3_:String = null;
         var _loc4_:BMLevelUpPrize = null;
         var _loc5_:String = null;
         this._timLine = new TimelineMax();
         this._timLine.to(this.mcTitle,0.2,{"alpha":0},0);
         var _loc1_:int = 0;
         while(_loc1_ < this._prizes.length)
         {
            this._timLine.add(this._prizes[_loc1_].getHideTimeLine(),0);
            _loc1_++;
         }
         this._prizes = new Vector.<BMLevelUpPrize>();
         this._prizesViewType = 3;
         var _loc2_:int = 0;
         while(this._additionalPrizes.length > 0 && _loc2_ < 2)
         {
            _loc3_ = this._additionalPrizes.shift();
            if(_loc3_ == "itemsBox")
            {
               _loc4_ = this.addPrize(new mcEmptyItemBox(),-1,getScreenText("itemBox"));
            }
            else if(_loc3_ == "inventorySlots")
            {
               _loc5_ = getScreenText("inventorySlots");
               _loc5_ = dataM.replaceStringInText(_loc5_,"%SLOTS%",String(this._data.inventorySlots - dataM.myProfile.inventorySizeState.maxSize));
               _loc4_ = this.addPrize(new mcNewInventorySlotsIcon(),-1,_loc5_);
            }
            else
            {
               _loc4_ = this.addPrize(this.createUnlockIcon(_loc3_),-1,getSpecificText("hanger_slot_" + _loc3_));
            }
            this._timLine.add(_loc4_.getShowTimeLine());
            _loc2_++;
         }
         this._timLine.fromTo(this.continueBtn,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         });
         this._timLine.addLabel("end");
      }
      
      private function createUnlockIcon(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = externalAssetsM.getAsset("general",this.getEquipmentIconNames(param1),30,30,false,false);
         _loc2_.x = -_loc2_.width / 2;
         _loc2_.y = -_loc2_.height / 2;
         var _loc3_:MovieClip = new MovieClip();
         _loc3_.addChild(_loc2_);
         return _loc3_;
      }
      
      private function getEquipmentIconNames(param1:*) : String
      {
         switch(param1)
         {
            case "leg":
               return "subType_inventory_leg";
            case "torso":
               return "subType_inventory_torso";
            case "sideWeapon":
               return "subType_inventory_sideWeapon";
            case "topWeapon":
               return "subType_inventory_topWeapon";
            case "drone":
               return "subType_inventory_drone";
            case "shield":
               return "subType_inventory_sideWeapon";
            case "teleport":
               return "emptyItem_teleport2";
            case "harpoon":
               return "emptyItem_harpoon2";
            case "charge":
               return "emptyItem_charge2";
            case "module":
               return "subType_inventory_module";
            case "kit":
               return "subType_inventory_kit";
            case "mech1":
               return "subType_inventory_all";
            case "mech2":
               return "subType_inventory_all";
            case "mech3":
               return "subType_inventory_all";
            default:
               return "";
         }
      }
      
      public function backClicked() : void
      {
         if(this._data.hasItems)
         {
            screensM.addScreen(BMScreensManager.SCR_ITEM_CARDS);
            screensM.screenItemCards.refreshScreen(this._data.reward.getItemIds(),this._data.reward.getPlayerItemIds(),BMShopManager.CUSTOM_ITEMS_BOX_ID);
         }
         else
         {
            screensM.removeScreen(BMScreensManager.SCR_LEVEL_UP_NEW);
         }
         BMLevelUpManager.gi().applyLevelUpData(this._data);
         if(screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
         {
            screensM.screenMainMenu.levelUpClosed();
         }
      }
   }
}

