package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import com.greensock.easing.Sine;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.upgrade.BMItemUpgradeData;
   import net.battleMechsMulti.managers.upgrade.BMUpgradeManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemPropertiesPanel;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1274")]
   public class BMUpgradeBoostPanel extends BMUpgradeBasePanel
   {
      
      private const SOURCE_ITEM_SIZE:uint = 52;
      
      public var itemProperties:BMItemPropertiesPanel;
      
      public var targetItemSizer:Sprite;
      
      public var sourceListPlaceHolder:Sprite;
      
      public var txtPower:TextField;
      
      public var txtCurrentLevel:TextField;
      
      public var txtBoostLevel:TextField;
      
      public var mcBar:BMBar;
      
      public var boostGlow:MovieClip;
      
      private var _targetItem:BMTileListItem;
      
      private var _sourceTileList:BMTileList;
      
      private var _upgardeData:BMItemUpgradeData;
      
      private var _sourcePower:Number;
      
      private var _targetPlayerItemData:BMPlayerItemData;
      
      private var _boostLevel:int = 0;
      
      private var _upgradeManager:BMUpgradeManager;
      
      public function BMUpgradeBoostPanel()
      {
         super();
         generateSingletonClassesPointers("");
         this._upgradeManager = BMUpgradeManager.gi();
         this.mcBar.initialize();
         this.mcBar.setFill(0.6);
         this._sourceTileList = new BMTileList();
         this._sourceTileList.initialize(screensM.stagePointer,[],1,9,this.SOURCE_ITEM_SIZE,this.SOURCE_ITEM_SIZE,null,true,null,null,null,false,0,0,true,false,false);
         this._sourceTileList.loadAssetsFunction = externalAssetsM.getAsset;
         this.sourceListPlaceHolder.addChild(this._sourceTileList);
      }
      
      override public function setTarget(param1:Number) : void
      {
         if(this._targetItem != null)
         {
            removeChild(this._targetItem);
         }
         this._targetPlayerItemData = dataM.myPlayerData.getPlayerItemBy(param1);
         this._targetItem = dataM.createInventoryTileListItem2(param1,this.onTargetItemClicked,this.targetItemSizer.width);
         this._targetItem.x = this.targetItemSizer.x;
         this._targetItem.y = this.targetItemSizer.y;
         addChild(this._targetItem);
         var _loc2_:BMItemData = dataM.itemsDB[this._targetPlayerItemData.itemID];
         this.currentLevel = "LEVEL " + _loc2_.displayLevel + " / " + this._upgradeManager.getItemMaxLevel(this._targetPlayerItemData.itemID);
         this.sourcePower = 0;
      }
      
      override public function addToSource(param1:Number) : void
      {
         var _loc2_:BMTileListItem = dataM.createInventoryTileListItem2(param1,this.onSourceItemClicked,this.SOURCE_ITEM_SIZE);
         this._sourceTileList.addItems(0,[_loc2_],true);
         this.refrashUpgardeState();
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
         this._sourceTileList.removeItems([param1],"tileListItemID");
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
      
      private function set currentLevel(param1:String) : void
      {
         this.txtCurrentLevel.text = param1;
         ImageUtils.swapTextFieldWithBitMap(this.txtCurrentLevel,this);
      }
      
      private function set boostLevel(param1:int) : void
      {
         this._boostLevel = param1;
         if(this._boostLevel <= 0)
         {
            this._boostLevel = 0;
            this.txtBoostLevel.text = "";
         }
         else
         {
            this.txtBoostLevel.text = "+" + this._boostLevel;
         }
         ImageUtils.swapTextFieldWithBitMap(this.txtBoostLevel,this);
      }
      
      public function get sourcePower() : Number
      {
         return this._sourcePower;
      }
      
      public function set sourcePower(param1:Number) : void
      {
         this._sourcePower = param1;
         if(this._targetPlayerItemData == null)
         {
            this.txtPower.text = "";
            this.mcBar.setFill(0);
            this.boostLevel = 0;
            return;
         }
         var _loc2_:int = int(this._sourcePower);
         var _loc3_:BMItemUpgradeData = this._upgradeManager.getUpgradeData(this._targetPlayerItemData.itemID,this._targetPlayerItemData.power,_loc2_);
         var _loc4_:BMItemData = _loc3_.newItemData;
         var _loc5_:BMItemData = dataM.itemsDB[this._targetPlayerItemData.itemID];
         if(_loc4_.isMaxLevel())
         {
            this.txtPower.text = "MAX LEVEL";
            this.mcBar.setFill(1);
         }
         else
         {
            this.txtPower.text = dataM.getNumberWithComma(_loc3_.newPower) + "/" + dataM.getNumberWithComma(_loc4_.powerToUpgrade);
            this.mcBar.setFill((_loc3_.newPower + this._sourcePower - _loc2_ - _loc3_.newItemData.minPowerToHave) / (_loc3_.newItemData.powerToUpgrade - _loc3_.newItemData.minPowerToHave));
         }
         this.boostLevel = _loc4_.displayLevel - _loc5_.displayLevel;
         if(this._boostLevel == 0)
         {
            this.itemProperties.showUpgradable(_loc5_);
         }
         else
         {
            this.itemProperties.showDifference(_loc5_,_loc4_);
         }
         ImageUtils.swapTextFieldWithBitMap(this.txtPower,this);
      }
      
      private function refrashUpgardeState() : void
      {
         var _loc1_:BMPlayerData = dataM.myPlayerData;
         var _loc2_:Number = this._upgradeManager.calcSourcePower(this.getSourcePlayerItemIDs());
         this._upgardeData = this._upgradeManager.getUpgradeData(this._targetPlayerItemData.itemID,this._targetPlayerItemData.power,_loc2_);
         _cost = this._upgardeData.cost;
         var _loc3_:BMItemData = dataM.itemsDB[this._targetPlayerItemData.itemID];
         if(this._upgardeData.newItemData.isMaxLevel())
         {
            _loc2_ = this._upgardeData.newItemData.minPowerToHave - this._targetPlayerItemData.power;
         }
         var _loc4_:int = Math.abs(this._upgardeData.newItemData.displayLevel - this._boostLevel);
         var _loc5_:Number = 0.5 + _loc4_ * 0.15;
         if(_loc5_ > 2)
         {
            _loc5_ = 2;
         }
         TweenMax.killTweensOf(this);
         if(_loc2_ < this._sourcePower && _loc4_ > 3)
         {
            TweenMax.to(this,_loc5_,{
               "sourcePower":_loc2_,
               "ease":Quad.easeIn
            });
         }
         else
         {
            TweenMax.to(this,_loc5_,{
               "sourcePower":_loc2_,
               "ease":Sine.easeOut
            });
         }
      }
      
      override public function isSourceFull() : Boolean
      {
         return this._upgardeData != null && this._upgardeData.newItemData.isMaxLevel();
      }
      
      override public function isItemInSource(param1:Number) : Boolean
      {
         return this._sourceTileList.findTileListItemByTileListItemID(param1) != null;
      }
      
      override public function reset() : void
      {
         if(this._targetItem != null)
         {
            removeChild(this._targetItem);
            this._targetItem = null;
         }
         TweenMax.killTweensOf(this);
         this._targetPlayerItemData = null;
         this._boostLevel = 0;
         this.sourcePower = 0;
         this.currentLevel = "";
         this._upgardeData = null;
         this._sourceTileList.removeAllItems();
      }
      
      override public function getSourcePlayerItemIDs() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this._sourceTileList.items.length)
         {
            _loc1_.push(this._sourceTileList.items[_loc2_].contentData_playerItemID);
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function getNumOfSource() : int
      {
         return this._sourceTileList.items.length;
      }
      
      override public function getUpgardedData() : BMItemUpgradeData
      {
         return this._upgardeData;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            TweenMax.to(this.boostGlow,1,{
               "scaleX":1.2,
               "scaleY":1.2,
               "yoyo":true,
               "repeat":-1
            });
         }
         else
         {
            this.boostGlow.scaleX = 1;
            this.boostGlow.scaleY = 1;
            TweenMax.killTweensOf(this.boostGlow);
         }
      }
      
      override public function doUpgrade() : void
      {
         if(this._boostLevel == 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            return;
         }
         var _loc1_:BMPlayerItemData = dataM.myPlayerData.getPlayerItemBy(this._targetItem.contentData_playerItemID);
         screensM.addScreen("screenHangerBoostComplete");
         var _loc2_:Point = this._targetItem.item.localToGlobal(new Point(this._targetItem.item.width / 2,this._targetItem.item.height / 2));
         screensM.screenHangerBoostComplete.setData(_loc1_.itemID,_loc1_.power,this._upgradeManager.calcSourcePower(this.getSourcePlayerItemIDs()),_loc2_);
      }
      
      override public function onUpgradeSuccess() : void
      {
         screensM.removeScreen("screenConfirmation");
         if(screensM.isScreenOpened("screenHangerBoostComplete"))
         {
            screensM.screenHangerBoostComplete.onUpgradeSuccess();
         }
         else
         {
            screensM.screenHangerUpgrade.onUpgradeComplete();
         }
      }
   }
}

