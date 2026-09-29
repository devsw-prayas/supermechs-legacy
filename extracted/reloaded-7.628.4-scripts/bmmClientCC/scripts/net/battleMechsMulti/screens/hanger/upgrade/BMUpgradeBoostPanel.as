package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import com.greensock.easing.Sine;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.upgrade.BMItemUpgradeData;
   import net.battleMechsMulti.managers.upgrade.BMUpgradeManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemPropertiesPanel;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2864")]
   public class BMUpgradeBoostPanel extends BMUpgradeBasePanel
   {
      
      private const SOURCE_ITEM_SIZE:uint = 52;
      
      public var itemProperties:BMItemPropertiesPanel;
      
      public var targetItemSizer:Sprite;
      
      public var sourceListPlaceHolder:Sprite;
      
      public var txtPower:TextField;
      
      public var txtCurrentLevel:TextField;
      
      public var txtMaxLevel:TextField;
      
      public var txtBoostLevel:TextField;
      
      public var txtItemReadyForAscension:TextField;
      
      public var mcBar:BMBar;
      
      public var boostGlow:MovieClip;
      
      public var btnEnhance:BMBasicButton;
      
      public var btnAscend:BMBasicButton;
      
      private var _targetItem:BMTileListItem;
      
      private var _sourceTileList:BMTileList;
      
      private var _upgardeData:BMItemUpgradeData;
      
      private var _sourcePower:Number;
      
      private var _targetPlayerItemData:BMPlayerItemData;
      
      private var _boostLevel:int = 0;
      
      private var _upgradeManager:BMUpgradeManager;
      
      private var _startBatchSourcePower:Number;
      
      private var _stackedItems:Array = new Array();
      
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
         this.btnAscend.text = getSpecificText("upgrade_ascend");
         this.btnAscend.addEventListener(BMIntractable.HIT,this.ascendClicked);
         this.btnEnhance.text = "Enhance";
         this.btnEnhance.addEventListener(BMIntractable.HIT,this.enhanceClicked);
      }
      
      override public function setTarget(param1:Number) : void
      {
         var _loc2_:BMItemData = null;
         if(this._targetItem != null)
         {
            removeChild(this._targetItem);
         }
         this._targetPlayerItemData = dataM.myPlayerData.getPlayerItemBy(param1);
         this._targetItem = dataM.createInventoryTileListItem2(param1,this.onTargetItemClicked,this.targetItemSizer.width);
         this._targetItem.x = this.targetItemSizer.x;
         this._targetItem.y = this.targetItemSizer.y;
         addChild(this._targetItem);
         _loc2_ = dataM.itemsDB[this._targetPlayerItemData.itemID];
         if(_loc2_.isMaxLevel())
         {
            updateTextAndFormat(this.txtMaxLevel,getGeneralText("powerLevelMaxed"));
            this.currentLevel = "";
            this.mcBar.visible = false;
            this.txtPower.visible = false;
            this.txtBoostLevel.visible = false;
            this.itemProperties.reset();
         }
         else
         {
            updateTextAndFormat(this.txtMaxLevel,"");
            this.mcBar.visible = true;
            this.txtPower.visible = true;
            this.txtBoostLevel.visible = true;
            this.currentLevel = getGeneralText("levelCaps") + " " + _loc2_.displayLevel + " / " + this._upgradeManager.getItemMaxLevel(this._targetPlayerItemData.itemID);
            this.sourcePower = 0;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("upgradeBoostPanel_txtPower",[this.txtPower],"",this);
            screensM.createMultipleTextsBitmap("upgradeBoostPanel_txtMaxLevel",[this.txtMaxLevel],"",this);
         }
         this.btnAscend.visible = false;
         this.txtItemReadyForAscension.text = "";
         if(_loc2_.canAscend())
         {
            this.btnAscend.visible = true;
            updateTextAndFormat(this.txtItemReadyForAscension,getSpecificText("upgrade_itemReadyForAscension"));
         }
         this.btnEnhance.visible = false;
         if(_loc2_.canBeEnhanced)
         {
            this.btnEnhance.visible = true;
         }
      }
      
      override public function beginAddToSourceBatch() : void
      {
         super.beginAddToSourceBatch();
         this._startBatchSourcePower = this.sourcePower;
      }
      
      override public function endAddToSourceBatch() : void
      {
         super.endAddToSourceBatch();
         this.sourcePower = this._startBatchSourcePower;
         if(this._stackedItems.length > 0)
         {
            this._sourceTileList.addItems(0,this._stackedItems,true);
            this._stackedItems = new Array();
         }
         this.refrashUpgardeState(true,0.5);
      }
      
      override public function addToSource(param1:Number) : void
      {
         var _loc2_:BMTileListItem = dataM.createInventoryTileListItem2(param1,this.onSourceItemClicked,this.SOURCE_ITEM_SIZE,null,null,false);
         this._stackedItems.insertAt(0,_loc2_);
         if(_isInUpgradeBatch == false)
         {
            this._sourceTileList.addItems(0,this._stackedItems,true);
            this._stackedItems = new Array();
            this.refrashUpgardeState();
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE_MASS_SELECTION))
         {
            return;
         }
         this._sourceTileList.removeItems([param1],"tileListItemID");
         screensM.screenHangerUpgrade.itemRemovedFromBoostSource();
         this.refrashUpgardeState();
         dispatchEvent(new DataEvent(ON_SOURCE_REMOVED,false,false,param1.toString()));
      }
      
      override public function removeAllSourceItems() : void
      {
         this._sourceTileList.removeAllItems();
         this.refrashUpgardeState();
         dispatchEvent(new DataEvent(ON_ALL_SOURCE_ITEMS_REMOVED));
      }
      
      private function onTargetItemClicked(param1:Number, param2:Number) : void
      {
         if(tutorialM.isTutorialActive() == false)
         {
            dispatchEvent(new DataEvent(ON_TAGET_REMOVED));
         }
      }
      
      override public function isTargetMaxLevel() : Boolean
      {
         var _loc1_:BMItemData = dataM.itemsDB[this._targetPlayerItemData.itemID];
         return _loc1_.isMaxLevel();
      }
      
      private function set currentLevel(param1:String) : void
      {
         updateTextAndFormat(this.txtCurrentLevel,param1);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("upgradeBoostPanel_txtCurrentLevel",[this.txtCurrentLevel],"",this);
         }
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
            updateTextAndFormat(this.txtBoostLevel,"+" + this._boostLevel);
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("upgradeBoostPanel_txtBoostLevel",[this.txtBoostLevel],"",this);
         }
      }
      
      public function get sourcePower() : Number
      {
         return this._sourcePower;
      }
      
      public function set sourcePower(param1:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
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
            updateTextAndFormat(this.txtPower,getSpecificText("upgrade_maxLevelCaps"));
            this.mcBar.setFill(1);
         }
         else
         {
            updateTextAndFormat(this.txtPower,TextUtils.getNumberWithComma(_loc3_.newPower) + "/" + TextUtils.getNumberWithComma(_loc4_.powerToUpgrade));
            _loc6_ = _loc3_.newPower + this._sourcePower - _loc2_ - _loc3_.newItemData.minPowerToHave;
            _loc7_ = _loc3_.newItemData.powerToUpgrade - _loc3_.newItemData.minPowerToHave;
            this.mcBar.setFill(_loc6_ / _loc7_);
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
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("upgradeBoostPanel_txtPower",[this.txtPower],"",this);
         }
      }
      
      private function refrashUpgardeState(param1:Boolean = true, param2:Number = 0) : void
      {
         if(_isInUpgradeBatch)
         {
            return;
         }
         var _loc3_:BMPlayerData = dataM.myPlayerData;
         this._upgardeData = this._upgradeManager.getUpgradeData(this._targetPlayerItemData.itemID,this._targetPlayerItemData.power,0);
         if(this._upgardeData.newItemData.isMaxLevel())
         {
            return;
         }
         var _loc4_:Number = this._upgradeManager.calcSourcePower(this._targetPlayerItemData.playerItemID,this.getSourcePlayerItemIDs());
         this._upgardeData = this._upgradeManager.getUpgradeData(this._targetPlayerItemData.itemID,this._targetPlayerItemData.power,_loc4_);
         _cost = this._upgardeData.cost;
         var _loc5_:BMItemData = dataM.itemsDB[this._targetPlayerItemData.itemID];
         if(this._upgardeData.newItemData.isMaxLevel())
         {
            _loc4_ = this._upgardeData.newItemData.minPowerToHave - this._targetPlayerItemData.power;
         }
         var _loc6_:int = Math.abs(this._upgardeData.newItemData.displayLevel - this._boostLevel);
         var _loc7_:Number = 0.5 + _loc6_ * 0.15;
         if(_loc7_ > 2)
         {
            _loc7_ = 2;
         }
         TweenMax.killTweensOf(this);
         if(param1)
         {
            if(_loc4_ < this._sourcePower && _loc6_ > 3)
            {
               TweenMax.to(this,_loc7_,{
                  "delay":param2,
                  "sourcePower":_loc4_,
                  "ease":Quad.easeIn
               });
            }
            else
            {
               TweenMax.to(this,_loc7_,{
                  "delay":param2,
                  "sourcePower":_loc4_,
                  "ease":Sine.easeOut
               });
            }
         }
         else
         {
            this.sourcePower = _loc4_;
         }
      }
      
      private function ascendClicked(param1:Event) : void
      {
         dispatchEvent(new DataEvent(ON_ASCEND_CLICKED));
      }
      
      private function enhanceClicked(param1:Event) : void
      {
         dispatchEvent(new DataEvent(ON_ENHANCE_CLICKED));
      }
      
      override public function isSourceFull() : Boolean
      {
         return this._upgardeData != null && this._upgardeData.newItemData.isMaxLevel();
      }
      
      override public function isSourceEmpty() : Boolean
      {
         return this._sourceTileList.items.length == 0;
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
         var _loc3_:BMTileListItem = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this._sourceTileList.items.length)
         {
            _loc3_ = this._sourceTileList.items[_loc2_];
            _loc1_.push(_loc3_.tileListItemID);
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function getNumOfSource() : int
      {
         return Math.max(this._sourceTileList.items.length,this._stackedItems.length);
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
      
      override public function get targetItemPlayerItemID() : uint
      {
         if(this._targetItem == null)
         {
            return 0;
         }
         return this._targetItem.tileListItemID;
      }
      
      override public function doUpgrade() : void
      {
         var _loc6_:BMTileListItem = null;
         var _loc7_:BMItemData = null;
         var _loc1_:BMPlayerItemData = dataM.myPlayerData.getPlayerItemBy(this.targetItemPlayerItemID);
         var _loc2_:int = _loc1_.colorID;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < this._sourceTileList.items.length)
         {
            _loc6_ = this._sourceTileList.items[_loc4_];
            _loc7_ = dataM.myPlayerData.getItemBy(_loc6_.tileListItemID);
            if(_loc7_.isColorKit)
            {
               _loc2_ = Number(_loc7_.animation);
               _loc3_ = true;
            }
            _loc4_++;
         }
         if(this._boostLevel == 0 && !_loc3_)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            return;
         }
         screensM.addScreen(BMScreensManager.SCR_HANGER_BOOST_COMPLETE);
         var _loc5_:Point = this._targetItem.item.localToGlobal(new Point(this._targetItem.item.width / 2,this._targetItem.item.height / 2));
         screensM.screenHangerBoostComplete.setData(_loc1_.itemID,_loc1_.power,this._upgradeManager.calcSourcePower(this._targetPlayerItemData.playerItemID,this.getSourcePlayerItemIDs()),_loc5_,_loc2_);
      }
      
      override public function onUpgradeSuccess() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(screensM.isScreenOpened(BMScreensManager.SCR_HANGER_BOOST_COMPLETE))
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

