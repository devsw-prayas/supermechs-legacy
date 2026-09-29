package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.upgrade.BMItemUpgradeData;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.utils.BMItemShadowImage;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1282")]
   public class BMUpgradeTransformPanel extends BMUpgradeBasePanel
   {
      
      private const MAX_SOURCE_ITEMS:uint = 5;
      
      public var targetItemSizer:Sprite;
      
      public var transformedItemSizer:Sprite;
      
      public var upgradeTransformSource:MovieClip;
      
      public var txtTranformedTierName:TextField;
      
      public var txtTranformedItemName:TextField;
      
      public var mcLight1:Sprite;
      
      public var mcEffectsHolder:MovieClip;
      
      private var _currentItemID:Number;
      
      private var _upgradedItemID:Number;
      
      private var _targetItem:BMTileListItem;
      
      private var _newItem:BMTileListItem;
      
      private var _sourceList:Vector.<BMTileListItem> = new Vector.<BMTileListItem>();
      
      private var _sourceItemIds:Array = [];
      
      private var _timer:Timer;
      
      public function BMUpgradeTransformPanel()
      {
         super();
         generateSingletonClassesPointers("");
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      override public function setTarget(param1:Number) : void
      {
         if(this._targetItem != null)
         {
            removeChild(this._targetItem);
         }
         this._targetItem = dataM.createInventoryTileListItem2(param1,this.onTargetItemClicked,this.targetItemSizer.width);
         this._targetItem.x = this.targetItemSizer.x;
         this._targetItem.y = this.targetItemSizer.y;
         addChild(this._targetItem);
         var _loc2_:BMItemData = dataM.myPlayerData.getItemBy(param1);
         var _loc3_:BMItemData = dataM.itemsDB[_loc2_.upgradeToItemID];
         this._currentItemID = _loc2_.itemID;
         this._upgradedItemID = _loc3_.itemID;
         this.upgradeTransformSource.gotoAndStop(_loc2_.specialStatus + 1);
         this._sourceItemIds = [];
         this.showItemAfterTransformation(_loc3_);
         var _loc4_:uint = uint("0x" + dataM.getItemTierColor(_loc2_.specialStatus));
         this.txtTranformedItemName.textColor = _loc4_;
         this.txtTranformedTierName.textColor = _loc4_;
         this.tranformedItemName = _loc3_.fullName;
         this.tranformedTierName = this.getTierName(_loc2_.specialStatus);
         this.refrashSourceList();
         this.shrinkLight1();
      }
      
      private function refrashSourceList() : *
      {
         var _loc3_:MovieClip = null;
         var _loc1_:BMItemData = dataM.myPlayerData.getItemBy(this._targetItem.contentData_playerItemID);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.numOfItemsForTransform)
         {
            _loc3_ = this.upgradeTransformSource["sizer" + _loc2_];
            if(_loc2_ < this._sourceList.length && this._sourceList[_loc2_] != null)
            {
               this.upgradeTransformSource.removeChild(this._sourceList[_loc2_]);
            }
            if(_loc2_ < this._sourceItemIds.length)
            {
               this._sourceList[_loc2_] = dataM.createInventoryTileListItem2(this._sourceItemIds[_loc2_],this.onSourceItemClicked,_loc3_.width);
            }
            else
            {
               this._sourceList[_loc2_] = dataM.createEmptyInvntoryTileList2(_loc3_.width,_loc1_.specialStatus);
            }
            this._sourceList[_loc2_].x = _loc3_.x;
            this._sourceList[_loc2_].y = _loc3_.y;
            this.upgradeTransformSource.addChild(this._sourceList[_loc2_]);
            _loc2_++;
         }
      }
      
      private function enlargeLight1() : void
      {
         TweenMax.to(this.mcLight1,0.25,{
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.shrinkLight1
         });
      }
      
      private function shrinkLight1() : void
      {
         TweenMax.to(this.mcLight1,2,{
            "scaleX":0.85,
            "scaleY":0.85,
            "onComplete":this.enlargeLight1
         });
      }
      
      private function showItemAfterTransformation(param1:BMItemData) : void
      {
         if(this._newItem != null)
         {
            removeChild(this._newItem);
            this._newItem = null;
         }
         var _loc2_:uint = this.transformedItemSizer.width;
         var _loc3_:String = dataM.itemTypeSourceDB[param1.type];
         var _loc4_:MovieClip = externalAssetsM.getAsset(_loc3_,param1.grp,_loc2_,_loc2_);
         var _loc5_:uint = 0;
         var _loc6_:uint = 16724736;
         var _loc7_:MovieClip = BMItemShadowImage.createItemShadowImage(_loc4_,_loc2_,true,_loc5_,_loc6_,false,dataM.runAsMobile);
         var _loc8_:BMItem = new BMItem();
         var _loc9_:MovieClip = externalAssetsM.getAsset("general","icon_tier" + param1.specialStatus,_loc2_,_loc2_);
         _loc8_.initialize(0,_loc2_,_loc2_,_loc7_,0,10,false,_loc9_,dataM.runAsMobile);
         this._newItem = new BMTileListItem();
         this._newItem.initialize(_loc2_,_loc2_,_loc8_,"","","",0,this.transformItemClicked,null,null,null,null,dataM.runAsMobile);
         this._newItem.x = this.transformedItemSizer.x;
         this._newItem.y = this.transformedItemSizer.y;
         addChild(this._newItem);
      }
      
      private function transformItemClicked(param1:uint, param2:uint) : void
      {
         screensM.addScreen("screenHangerTransformPreview");
         screensM.screenHangerTransformPreview.refreshScreen(this._currentItemID,this._upgradedItemID);
      }
      
      private function getTierName(param1:int) : String
      {
         switch(param1)
         {
            case 1:
               return getGeneralText("rare");
            case 2:
               return getGeneralText("epic");
            case 3:
               return getGeneralText("legendary");
            case 4:
               return getGeneralText("mythical");
            default:
               return "Common";
         }
      }
      
      override public function addToSource(param1:Number) : void
      {
         if(this.isSourceFull())
         {
            return;
         }
         this._sourceItemIds.push(param1);
         this.refrashSourceList();
         this.refrashUpgardeState();
      }
      
      private function refrashUpgardeState() : void
      {
         if(this.isSourceFull())
         {
            _cost = dataM.myPlayerData.getItemBy(this._targetItem.contentData_playerItemID).evolutionGoldCost;
         }
         else
         {
            _cost = 0;
         }
      }
      
      private function onSourceItemClicked(param1:Number, param2:Number) : void
      {
         if(tutorialM.isTutorialActive() == false)
         {
            this.removeFromSource(param2);
         }
      }
      
      override public function removeFromSource(param1:Number) : void
      {
         var _loc2_:int = this._sourceItemIds.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this._sourceItemIds.splice(_loc2_,1);
         this.refrashSourceList();
         this.refrashUpgardeState();
         dispatchEvent(new DataEvent(ON_SOURCE_REMOVED,false,false,param1.toString()));
      }
      
      private function onTargetItemClicked(param1:Number, param2:Number) : void
      {
         if(tutorialM.isTutorialActive() == false)
         {
            dispatchEvent(new DataEvent(ON_TAGET_REMOVED));
         }
      }
      
      private function onTransformedItemClicked(param1:Number, param2:Number) : void
      {
      }
      
      private function set tranformedItemName(param1:String) : void
      {
         this.txtTranformedItemName.text = param1;
         ImageUtils.swapTextFieldWithBitMap(this.txtTranformedItemName,this);
      }
      
      private function set tranformedTierName(param1:String) : void
      {
         this.txtTranformedTierName.text = param1;
         ImageUtils.swapTextFieldWithBitMap(this.txtTranformedTierName,this);
      }
      
      private function startEffectsTimer() : void
      {
         this.removeEffectsTimer();
         this._timer = new Timer(33);
         this._timer.addEventListener(TimerEvent.TIMER,this.effectsTimerTrigger);
         this._timer.start();
      }
      
      private function removeEffectsTimer() : void
      {
         if(this._timer != null)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.effectsTimerTrigger);
            this._timer = null;
         }
      }
      
      private function effectsTimerTrigger(param1:TimerEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = Math.ceil(Math.random() * 6);
         if(_loc2_ <= 2)
         {
            _loc3_ = "electricity" + Math.ceil(Math.random() * 3);
            _loc4_ = Math.random() * 100 - 50;
            _loc5_ = Math.random() * 50 - 25;
            if(_loc2_ == 1)
            {
               _loc4_ += 90;
            }
            else
            {
               _loc4_ -= 90;
            }
            effectsM.createElectricity(_loc3_,_loc4_,_loc5_,this.mcEffectsHolder,2,2);
         }
      }
      
      override public function isSourceFull() : Boolean
      {
         var _loc1_:BMItemData = dataM.myPlayerData.getItemBy(this._targetItem.contentData_playerItemID);
         return this._sourceItemIds.length >= _loc1_.numOfItemsForTransform;
      }
      
      override public function isItemInSource(param1:Number) : Boolean
      {
         return this._sourceItemIds.indexOf(param1) != -1;
      }
      
      override public function reset() : void
      {
         if(this._targetItem != null)
         {
            removeChild(this._targetItem);
            this._targetItem = null;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this._sourceList.length)
         {
            this.upgradeTransformSource.removeChild(this._sourceList[_loc1_]);
            _loc1_++;
         }
         this._sourceItemIds = [];
         this._sourceList = new Vector.<BMTileListItem>();
      }
      
      override public function getSourcePlayerItemIDs() : Array
      {
         return this._sourceItemIds;
      }
      
      override public function getNumOfSource() : int
      {
         return this._sourceItemIds.length;
      }
      
      override public function getUpgardedData() : BMItemUpgradeData
      {
         var _loc1_:BMItemData = dataM.myPlayerData.getItemBy(this._targetItem.contentData_playerItemID);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.upgradeToItemID];
         return new BMItemUpgradeData(_loc2_,0,_cost);
      }
      
      override public function doUpgrade() : void
      {
         screensM.addScreen("screenHangerTransformComplete");
         var _loc1_:Point = this._targetItem.item.localToGlobal(new Point(this._targetItem.item.width / 2,this._targetItem.item.height / 2));
         var _loc2_:BMItemData = dataM.myPlayerData.getItemBy(this._targetItem.contentData_playerItemID);
         screensM.screenHangerTransformComplete.refreshScreen(_loc2_.itemID,_loc2_.upgradeToItemID,_loc1_,this._targetItem.item.width);
      }
      
      override public function onUpgradeSuccess() : void
      {
         if(screensM.isScreenOpened("screenHangerTransformComplete"))
         {
            screensM.screenHangerTransformComplete.onUpgradeSuccess();
         }
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeEffectsTimer();
      }
   }
}

