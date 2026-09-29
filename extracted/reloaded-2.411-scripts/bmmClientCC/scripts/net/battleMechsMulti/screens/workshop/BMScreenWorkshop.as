package net.battleMechsMulti.screens.workshop
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.upgrade.BMUpgradeManager;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemInfoPanel;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.tacticsoft.utils.FunctionCall;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol70")]
   public class BMScreenWorkshop extends BMBaseScreen
   {
      
      private static const CATEGORIES_DATA:Vector.<BMWorkshopCategoryData> = new <BMWorkshopCategoryData>[new BMWorkshopCategoryData(["torso","leg"],"subType_inventory_torsoLeg",["emptyItem_torso","emptyItem_leg"]),new BMWorkshopCategoryData(["sideWeapon"],"subType_inventory_sideWeapon",["emptyItem_sideWeaponLeft","emptyItem_sideWeaponRight","emptyItem_sideWeaponLeft","emptyItem_sideWeaponRight"]),new BMWorkshopCategoryData(["topWeapon"],"subType_inventory_topWeapon",["emptyItem_topWeaponLeft","emptyItem_topWeaponRight"]),new BMWorkshopCategoryData(["drone","charge","shield","harpoon","teleport","perk"],"subType_inventory_special",["emptyItem_drone","emptyItem_charge","emptyItem_shield","emptyItem_harpoon","emptyItem_teleport","emptyItem_perk"]),new BMWorkshopCategoryData(["module"],"subType_inventory_module",["emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module"])];
      
      private static const VISIBLE_ITEM_TYPES:Array = ["torso","leg","sideWeapon","topWeapon"];
      
      private const INVENTORY_ITEM_SIZE:uint = 67;
      
      private const MAX_ITEMS_FOR_UNIFIED_INVENTORY:uint = 15;
      
      private const MAX_ITEMS_FOR_NO_SCROLL:uint = 15;
      
      private const NUM_OF_INVENTORY_COLS:uint = 3;
      
      private const DRAG_TYPE_INVENTORY:String = "inventory";
      
      private const DRAG_TYPE_MECH:String = "mech";
      
      public var mechViewHolder:Sprite;
      
      public var mcDragItemHitArea:Sprite;
      
      public var mcMechItemHitArea:Sprite;
      
      public var mcShowMechInfoHitArea:Sprite;
      
      public var mcWeightIconPlaceHolder:Sprite;
      
      public var mcDraggingFinger:MovieClip;
      
      public var mcTutorialArrow:MovieClip;
      
      public var txtTitle:TextField;
      
      public var txtWeight:TextField;
      
      public var itemInfo:BMItemInfoPanel;
      
      public var mcSizer_btnBack:Sprite;
      
      public var inventoryPlaceHolder:Sprite;
      
      public var btnScrollUp:BMBasicButton;
      
      public var btnScrollDown:BMBasicButton;
      
      public var btnNextMech:BMBasicButton;
      
      public var btnPrevMech:BMBasicButton;
      
      public var upgardeBtn:BMBasicButton;
      
      public var redeemMechBtn:BMBasicButton;
      
      public var mcButtonsHolder:Sprite;
      
      public var btnCategory0:MovieClip;
      
      public var btnCategory1:MovieClip;
      
      public var btnCategory2:MovieClip;
      
      public var btnCategory3:MovieClip;
      
      public var btnCategory4:MovieClip;
      
      public var mcSlot0:MovieClip;
      
      public var mcSlot1:MovieClip;
      
      public var mcSlot2:MovieClip;
      
      public var mcSlot3:MovieClip;
      
      public var mcSlot4:MovieClip;
      
      public var mcSlot5:MovieClip;
      
      public var mcSlot6:MovieClip;
      
      public var mcSlot7:MovieClip;
      
      public var btnBack:BMButton_pictureE;
      
      private var _tutorialTasksCompletedTauntFunction:Function;
      
      private var _mechGlowHandler:Boolean = false;
      
      private var _mechGlowCounter:Number;
      
      private var _mechView:BMMechView;
      
      private var _inventoryTileList:BMTileList;
      
      private var _selectedCategory:int = -1;
      
      private var _currentMechID:* = 1;
      
      private var _updateMech_lastItems:Array;
      
      private var _inventoryEnabled:Boolean = true;
      
      private var _mechEnabled:Boolean = true;
      
      private var _categoriesEnabled:Boolean = true;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _savedPlayerData:BMPlayerData;
      
      public function BMScreenWorkshop()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this._savedPlayerData = dataM.playersData[dataM.player1PlayerID];
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.createUpdateMechLastData();
         this.initTileLists();
         this.initButtons();
         this.initMechInfoHitArea();
         this.removeDragItemHitAreas();
         this.mcWeightIconPlaceHolder.addChild(externalAssetsM.getAsset("general","icon_weight",18,18,true,false));
         if(BMUpgradeManager.gi().selectedPlayerItemID == -1)
         {
            this.selectCategory(0);
            this.showCurrentMechData();
         }
         else
         {
            this.selectItem(BMUpgradeManager.gi().selectedPlayerItemID);
         }
         this.refreshMechView();
         this.initializeTutorialArrow();
      }
      
      private function initTileLists() : void
      {
         this._inventoryTileList = new BMTileList();
         this._inventoryTileList.initialize(screensM.stagePointer,[],this.NUM_OF_INVENTORY_COLS,5,this.INVENTORY_ITEM_SIZE,this.INVENTORY_ITEM_SIZE,null,true,null,null,null,false,0,0.4,true,true,false,"",true);
         this._inventoryTileList.loadAssetsFunction = externalAssetsM.getAsset;
         this.inventoryPlaceHolder.addChild(this._inventoryTileList);
      }
      
      private function initButtons() : void
      {
         var _loc2_:BMBasicSelectable = null;
         screensM.createButtonFromSizer("screenWorkshop","btnBack","pictureE");
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
         this.upgardeBtn.addEventListener(BMIntractable.HIT,this.onUpgardeClicked);
         this.redeemMechBtn.addEventListener(BMIntractable.HIT,this.onRedeemMechClicked);
         this.redeemMechBtn.visible = dataM.myProfile.pendingStarterPackMech > 0;
         this.btnScrollUp.addEventListener(BMIntractable.HIT,this.onScrollUpClicked);
         this.btnScrollDown.addEventListener(BMIntractable.HIT,this.onScrollDownClicked);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this.getCategoryBtn(_loc1_);
            _loc2_.addEventListener(BMIntractable.HIT,this.onCategoryClick);
            _loc2_.id = _loc1_.toString();
            _loc2_.selected = false;
            _loc2_.content = externalAssetsM.getAsset("general",CATEGORIES_DATA[_loc1_].catImage,0,0,true);
            _loc1_++;
         }
         if(dataM.myProfile.level < dataM.SECOND_MECH_UNLOCK_LEVEL)
         {
            this.btnNextMech.visible = false;
            this.btnPrevMech.visible = false;
         }
         else
         {
            this.btnNextMech.addEventListener(BMIntractable.HIT,this.onNextMechClicked);
            this.btnPrevMech.addEventListener(BMIntractable.HIT,this.onPrevMechClicked);
         }
         if(tutorialM.isTutorialActive())
         {
            this.btnBack.visible = false;
         }
      }
      
      private function onUpgardeClicked(param1:Event) : void
      {
         this.updateMech(screensM.screenNewMenu.upgrade);
      }
      
      private function onCategoryClick(param1:Event) : void
      {
         if(this._categoriesEnabled)
         {
            this.selectCategory(param1.target.id);
         }
      }
      
      private function onNextMechClicked(param1:Event) : void
      {
         if(dataM.mechIsOverWeight([this._currentMechID]))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",-1,-1);
            return;
         }
         var _loc2_:int = this.getMaxMechs();
         if(this._currentMechID >= _loc2_)
         {
            this._currentMechID = 1;
         }
         else
         {
            ++this._currentMechID;
         }
         this.refreshAfterMechChange();
      }
      
      private function onPrevMechClicked(param1:Event) : void
      {
         if(dataM.mechIsOverWeight([this._currentMechID]))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",-1,-1);
            return;
         }
         var _loc2_:int = this.getMaxMechs();
         if(this._currentMechID <= 1)
         {
            this._currentMechID = _loc2_;
         }
         else
         {
            --this._currentMechID;
         }
         this.refreshAfterMechChange();
      }
      
      private function refreshAfterMechChange() : *
      {
         this.refreshCategorySlots();
         this.refreshMechView();
         this.showCurrentMechData();
      }
      
      private function initMechInfoHitArea() : void
      {
         this.mcShowMechInfoHitArea.addEventListener(MouseEvent.CLICK,this.onMechHitAreaClick);
         this.mechViewHolder.addEventListener(MouseEvent.CLICK,this.onMechHitAreaClick);
         this.itemInfo.propertiesPanel.mouseEnabled = false;
         this.itemInfo.propertiesPanel.mouseChildren = false;
         this.itemInfo.txtItemName.mouseEnabled = false;
         this.itemInfo.txtPowerLevel.mouseEnabled = false;
         this.txtTitle.mouseEnabled = false;
      }
      
      private function onMechHitAreaClick(param1:MouseEvent) : void
      {
         this.showCurrentMechData();
      }
      
      private function selectCategory(param1:int) : void
      {
         if(this._selectedCategory == param1)
         {
            return;
         }
         if(this._selectedCategory != -1)
         {
            this.getCategoryBtn(this._selectedCategory).selected = false;
         }
         this._selectedCategory = param1;
         this.getCategoryBtn(this._selectedCategory).selected = true;
         this.refreshInventory();
         this.refreshCategorySlots();
      }
      
      private function refreshCategorySlots() : *
      {
         var _loc2_:BMBasicSelectable = null;
         this.currentMechStructure.updateEquipmentIndicators();
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = this.getSlotViewAt(_loc1_);
            if(_loc1_ < this.selectedCatData.numOfSlots)
            {
               _loc2_.visible = true;
               _loc2_.mouseChildren = true;
               _loc2_.id = _loc1_.toString();
               this.refreshSlotView(_loc1_);
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
      }
      
      private function refreshSlotView(param1:int) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:BMTileListItem = null;
         var _loc6_:BMItemData = null;
         var _loc2_:BMBasicSelectable = this.getSlotViewAt(param1);
         if(this.isSlotLocked(param1))
         {
            _loc4_ = new tileListItemCover();
            _loc4_.gotoAndStop(2);
            _loc2_.content = _loc4_;
            return;
         }
         var _loc3_:Number = this.getPlayerItemIdInSlot(param1);
         if(_loc3_ == 0)
         {
            _loc2_.content = externalAssetsM.getAsset("general",this.selectedCatData.getSlotEmptyImage(param1),0,0,true);
         }
         else
         {
            _loc5_ = dataM.createInventoryTileListItem2(_loc3_,null,this.INVENTORY_ITEM_SIZE,this.onSlotItenDown,null);
            _loc6_ = dataM.myPlayerData.getItemBy(_loc3_);
            if(_loc6_.bullets > this.currentMechStructure.totalBullets)
            {
               _loc5_.addMarker(this.createNotEnoughAmmo("notEnoughBullets"));
            }
            if(_loc6_.rockets > this.currentMechStructure.totalRockets)
            {
               _loc5_.addMarker(this.createNotEnoughAmmo("notEnoughRockets"));
            }
            _loc2_.content = _loc5_;
         }
      }
      
      private function createNotEnoughAmmo(param1:String) : *
      {
         var _loc2_:MovieClip = new mcWorkshopNotEnoughAmmo();
         _loc2_.mouseEnabled = false;
         _loc2_.mouseChildren = false;
         _loc2_.gotoAndStop(param1);
         return _loc2_;
      }
      
      private function getPlayerItemIdInSlot(param1:*) : Number
      {
         var _loc2_:String = this.selectedCatData.getEquipmentTypeAt(param1);
         var _loc3_:Number = 0;
         if(dataM.maxEquipment.hasOwnProperty(_loc2_) && dataM.maxEquipment[_loc2_] > 1)
         {
            if(this.currentMechStructure.hasOwnProperty(_loc2_ + (param1 + 1)))
            {
               _loc3_ = Number(this.currentMechStructure[_loc2_ + (param1 + 1)]);
            }
         }
         else
         {
            _loc3_ = Number(this.currentMechStructure[_loc2_]);
         }
         return _loc3_;
      }
      
      private function isSlotLocked(param1:int) : Boolean
      {
         var _loc2_:String = this.selectedCatData.getEquipmentTypeAt(param1);
         var _loc3_:int = this.slotToEquipmentID(param1);
         return this.isEquipmentLocked(_loc3_,_loc2_);
      }
      
      private function isEquipmentLocked(param1:Number, param2:String) : Boolean
      {
         if(dataM.equipmentUnlockDB.hasOwnProperty(param2))
         {
            return dataM.equipmentUnlockDB[param2].level > dataM.myProfile.level;
         }
         var _loc3_:int = int(dataM.getEquipmentUnlockByLevel(dataM.myProfile.level,param2));
         return param1 > _loc3_;
      }
      
      private function onSlotItenDown(param1:Number, param2:Number) : void
      {
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         this.selectItem(param2);
         var _loc3_:Boolean = true;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:BMPlayerItemData = dataM.myPlayerData.getPlayerItemBy(param2);
         var _loc5_:int = this.equipmentIDToSlot(_loc4_.equipmentID,_loc4_.equipmentType);
         var _loc6_:BMTileListItem = this.getSlotViewAt(_loc5_).content as BMTileListItem;
         _loc6_.addDisabledEffect();
         this.dragItem(this.DRAG_TYPE_MECH,param2,_loc5_);
         if(BMGameShortcutsHelper.gameSpeedShortcut())
         {
            this.dropItemAtClosestEquipment();
         }
      }
      
      private function refreshInventory() : void
      {
         this.setInventoryList(this.getInventoryPlayerItemIds(this.selectedCatData.equipmentTypesSlots));
      }
      
      private function setInventoryList(param1:Array) : void
      {
         if(param1.length > 500)
         {
            screensM.screenConfirmation.displayCustomLoading("Please wait");
            TweenMax.delayedCall(0.1,this.setInventoryListSub,[param1]);
         }
         else
         {
            this.setInventoryListSub(param1);
         }
      }
      
      private function setInventoryListSub(param1:Array) : void
      {
         var _loc2_:Array = new Array();
         var _loc3_:Boolean = param1.length != this._inventoryTileList.items.length || param1.length == 0;
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_.push(this.createInventoryTileList(param1[_loc4_]));
            if(this._inventoryTileList.items[_loc4_] == null)
            {
               _loc3_ = true;
            }
            else
            {
               _loc3_ ||= this._inventoryTileList.items[_loc4_].contentData_playerItemID != param1[_loc4_];
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            return;
         }
         this._inventoryTileList.removeAllItems();
         var _loc5_:int = 4;
         if(_loc2_.length <= this.MAX_ITEMS_FOR_NO_SCROLL)
         {
            _loc5_ = 5;
            this.btnScrollUp.visible = false;
            this.btnScrollDown.visible = false;
         }
         else
         {
            _loc5_ = 4;
            this.btnScrollUp.visible = true;
            this.btnScrollDown.visible = true;
         }
         if(this._inventoryTileList.getColumns() != _loc5_)
         {
            this._inventoryTileList.initialize(screensM.stagePointer,[],this.NUM_OF_INVENTORY_COLS,_loc5_,this.INVENTORY_ITEM_SIZE,this.INVENTORY_ITEM_SIZE,null,true,null,null,null,false,0,0.4,true,true,false,"",true);
         }
         this.addItemsToInventory(this._inventoryTileList.highestTileID + 1,_loc2_,false);
         screensM.removeScreen("screenConfirmation");
         this.refreshScrollButtons();
         tutorialM.refreshWorkshopTutorial();
      }
      
      private function addItemsToInventory(param1:Number, param2:Array, param3:Boolean) : void
      {
         this._inventoryTileList.addItems(param1,param2,param3);
         this._inventoryTileList.fillEmptyGridCells(new FunctionCall(dataM.createEmptyInvntoryTileList2,[this.INVENTORY_ITEM_SIZE]),param3);
      }
      
      private function createInventoryTileList(param1:Number) : BMTileListItem
      {
         return dataM.createInventoryTileListItem2(param1,null,this.INVENTORY_ITEM_SIZE,this.onInventoryItemDown,this.onInventoryItemUp);
      }
      
      private function onInventoryItemDown(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerItemData = null;
         if(this._inventoryEnabled)
         {
            this.selectItem(param2);
            _loc3_ = true;
            if(tutorialM.workshop_equipItemID > -1)
            {
               _loc4_ = dataM.getPlayerItemData(dataM.player1PlayerID,param2);
               if(_loc4_.itemID != tutorialM.workshop_equipItemID)
               {
                  _loc3_ = false;
               }
            }
            if(!_loc3_)
            {
               return;
            }
            this._inventoryTileList.addDisabledEffectForSpecificItems([param2],"tileListItemID");
            this.dragItem(this.DRAG_TYPE_INVENTORY,param2,param1);
         }
      }
      
      private function onInventoryItemUp(param1:Number, param2:Number) : void
      {
         if(this._inventoryEnabled)
         {
            this.stopDraggingItem();
         }
      }
      
      public function getInventoryPlayerItemIds(param1:Array = null) : *
      {
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:Array = [[],[],[],[],[],[]];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.items.length)
         {
            _loc7_ = _loc2_.items[_loc4_];
            _loc8_ = dataM.itemsDB[_loc7_.itemID];
            if(!(param1 != null && param1.indexOf(_loc7_.equipmentType) == -1 && _loc2_.items.length > this.MAX_ITEMS_FOR_UNIFIED_INVENTORY))
            {
               if(_loc7_.equipped <= 0)
               {
                  if(_loc8_.specialStatus == 5)
                  {
                     _loc3_[0].push(_loc7_.playerItemID);
                  }
                  else
                  {
                     _loc3_[_loc8_.specialStatus].push(_loc7_.playerItemID);
                  }
               }
            }
            _loc4_++;
         }
         var _loc5_:Array = new Array();
         var _loc6_:* = int(_loc3_.length - 1);
         while(_loc6_ >= 0)
         {
            _loc5_ = _loc5_.concat(_loc3_[_loc6_]);
            _loc6_--;
         }
         return _loc5_;
      }
      
      private function onScrollUpClicked(param1:Event) : void
      {
         this._inventoryTileList.scrollBy(-this._inventoryTileList.getRows());
         this.refreshScrollButtons();
      }
      
      private function onScrollDownClicked(param1:Event) : void
      {
         this._inventoryTileList.scrollBy(this._inventoryTileList.getRows());
         this.refreshScrollButtons();
      }
      
      private function refreshScrollButtons() : void
      {
         if(this._inventoryTileList.canScorllUp)
         {
            this.btnScrollUp.enableMe();
         }
         else
         {
            this.btnScrollUp.disableMe();
         }
         if(this._inventoryTileList.canScorllDown)
         {
            this.btnScrollDown.enableMe();
         }
         else
         {
            this.btnScrollDown.disableMe();
         }
      }
      
      private function selectItem(param1:Number) : void
      {
         BMUpgradeManager.gi().selectedPlayerItemID = param1;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:BMPlayerItemData = _loc2_.getPlayerItemBy(param1);
         var _loc4_:BMItemData = dataM.itemsDB[_loc3_.itemID];
         this.itemInfo.propertiesPanel.y = MovieClip(this.itemInfo).itemPropertiesPos.y;
         this.itemInfo.showItemInfo(_loc3_);
         if(tutorialM.workshop_upgradeButtonVisible() && Boolean(_loc3_.canBeUpgarded()))
         {
            this.upgardeBtn.visible = true;
         }
         else
         {
            this.upgardeBtn.visible = false;
         }
         if(_loc4_.upgradeToItemID == -1)
         {
            this.upgardeBtn.disableMe();
         }
         else
         {
            this.upgardeBtn.enableMe();
         }
         this.selectCategory(this.getCategoryForType(_loc4_.type));
      }
      
      private function showCurrentMechData() : *
      {
         var _loc1_:uint = uint("0xffffff");
         this.itemInfo.txtItemName.textColor = uint("0xffffff");
         this.itemInfo.itemName = getSpecificText("hanger_mechSummary");
         this.itemInfo.itemPowerLevelTxt = "";
         this.upgardeBtn.visible = false;
         this.itemInfo.propertiesPanel.y = MovieClip(this.itemInfo).mechPropertiesPos.y;
         this.itemInfo.propertiesPanel.propertiesPerLine = 2;
         this.itemInfo.propertiesPanel.showMech(this.currentMechStructure);
         BMUpgradeManager.gi().selectedPlayerItemID = -1;
      }
      
      private function getCategoryForType(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < CATEGORIES_DATA.length)
         {
            if(CATEGORIES_DATA[_loc2_].equipmentTypesSlots.indexOf(param1) != -1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function dragItem(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:BMItemData = dataM.myPlayerData.getItemBy(param2);
         var _loc5_:BMItem = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,param2,"drag",true);
         _loc5_.x = -200;
         _loc5_.y = -200;
         draggingM.activateDragging(_loc5_,false);
         draggingM.dragOrigin = param1;
         draggingM.dragTileID = param3;
         draggingM.dragEquipmentType = _loc4_.type;
         draggingM.dragEquipmentID = -1;
         this.addDragItemHitAreas(_loc4_.type);
      }
      
      public function stopDraggingItem() : void
      {
         var _loc1_:BMTileListItem = null;
         if(draggingM.item == null)
         {
            return;
         }
         switch(draggingM.dragOrigin)
         {
            case this.DRAG_TYPE_INVENTORY:
               this._inventoryTileList.enableItems([draggingM.dragTileID],"tileID");
               break;
            case this.DRAG_TYPE_MECH:
               if(this.getSlotViewAt(draggingM.dragTileID).content is BMTileListItem)
               {
                  _loc1_ = this.getSlotViewAt(draggingM.dragTileID).content as BMTileListItem;
                  _loc1_.removeDisabledEffect();
               }
         }
         draggingM.deactivateDragging();
         this.removeDragItemHitAreas();
      }
      
      private function onSlotUp(param1:Event) : void
      {
         var _loc2_:BMBasicSelectable = null;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this._inventoryEnabled)
         {
            _loc2_ = param1.currentTarget as BMBasicSelectable;
            _loc3_ = int(_loc2_.id);
            _loc4_ = this.slotToEquipmentID(_loc3_);
            _loc5_ = this.slotToEquipmentID(draggingM.dragTileID);
            if(draggingM.dragOrigin == this.DRAG_TYPE_INVENTORY)
            {
               this.equipItem(draggingM.item.ID,_loc4_);
            }
            else
            {
               this.swapItemEquipmentPos(_loc4_,_loc5_,draggingM.dragEquipmentType);
            }
            this.stopDraggingItem();
         }
      }
      
      private function addDragItemHitAreas(param1:String) : void
      {
         this.mcDragItemHitArea.addEventListener(MouseEvent.MOUSE_UP,this.onDragItemHitAreaUp);
         this.mcDragItemHitArea.mouseEnabled = true;
         this.mcMechItemHitArea.addEventListener(MouseEvent.MOUSE_UP,this.onMechItemHitAreaUp);
         this.mcMechItemHitArea.mouseEnabled = true;
         stage.addEventListener(Event.MOUSE_LEAVE,this.onDragMouseLeave);
         var _loc2_:int = 0;
         while(_loc2_ < this.selectedCatData.numOfSlots)
         {
            if(this.selectedCatData.getEquipmentTypeAt(_loc2_) == param1 && !this.isSlotLocked(_loc2_))
            {
               this.getSlotViewAt(_loc2_).selected = true;
               this.getSlotViewAt(_loc2_).mouseEnabled = true;
               this.getSlotViewAt(_loc2_).mouseChildren = true;
               this.getSlotViewAt(_loc2_).addEventListener(BMIntractable.UP,this.onSlotUp);
            }
            else
            {
               this.getSlotViewAt(_loc2_).selected = false;
               this.getSlotViewAt(_loc2_).mouseEnabled = false;
               this.getSlotViewAt(_loc2_).mouseChildren = false;
            }
            _loc2_++;
         }
      }
      
      private function removeDragItemHitAreas() : void
      {
         this.mcDragItemHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.onDragItemHitAreaUp);
         this.mcDragItemHitArea.mouseEnabled = false;
         this.mcMechItemHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.onMechItemHitAreaUp);
         this.mcMechItemHitArea.mouseEnabled = false;
         if(stage != null)
         {
            stage.removeEventListener(Event.MOUSE_LEAVE,this.onDragMouseLeave);
         }
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            this.getSlotViewAt(_loc1_).removeEventListener(BMIntractable.UP,this.onSlotUp);
            this.getSlotViewAt(_loc1_).mouseEnabled = true;
            this.getSlotViewAt(_loc1_).mouseChildren = true;
            this.getSlotViewAt(_loc1_).selected = false;
            _loc1_++;
         }
      }
      
      private function onDragItemHitAreaUp(param1:MouseEvent) : void
      {
         if(draggingM.dragOrigin == this.DRAG_TYPE_MECH)
         {
            this.unEquipItem(draggingM.item.ID);
         }
         this.stopDraggingItem();
      }
      
      private function onMechItemHitAreaUp(param1:MouseEvent) : void
      {
         if(draggingM.dragOrigin == this.DRAG_TYPE_MECH)
         {
            this.unEquipItem(draggingM.item.ID);
         }
         else
         {
            this.dropItemAtClosestEquipment();
         }
         this.stopDraggingItem();
      }
      
      private function onDragMouseLeave(param1:Event) : void
      {
         this.stopDraggingItem();
      }
      
      private function equipItem(param1:Number, param2:int) : *
      {
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:Number = NaN;
         if(this.isResistanceStacking(param1,param2))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("resistanceModuleBlock",-1,-1);
            return;
         }
         var _loc3_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc4_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         if(tutorialM.workshop_equipItemID == _loc4_.itemID)
         {
            if(tutorialM.workshop_equipItemEquipmentID > 0)
            {
               param2 = tutorialM.workshop_equipItemEquipmentID;
            }
         }
         var _loc5_:BMItemData = dataM.itemsDB[_loc4_.itemID];
         var _loc6_:String = param2 == 0 ? _loc5_.type : _loc5_.type + param2;
         var _loc7_:Number = Number(this.currentMechStructure[_loc6_]);
         if(_loc7_ > 0)
         {
            _loc8_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_);
            _loc8_.equipped = 0;
            _loc8_.equipmentID = 0;
            _loc9_ = this.inventoryTileList.findTileIDByTileListItemID(param1);
            this._inventoryTileList.addItems(_loc9_,[this.createInventoryTileList(_loc7_)],false);
         }
         this.currentMechStructure[_loc6_] = param1;
         _loc4_.equipped = this._currentMechID;
         _loc4_.equipmentID = param2;
         _loc4_.equipmentType = _loc5_.type;
         this.inventoryTileList.removeItems([param1],"tileListItemID");
         this._inventoryTileList.fillEmptyGridCells(new FunctionCall(dataM.createEmptyInvntoryTileList2,[this.INVENTORY_ITEM_SIZE]),false);
         this.refreshAfterEquip();
         this.refreshSlotView(this.equipmentIDToSlot(param2,_loc5_.type));
         soundM.createSound("itemEquipped",1);
      }
      
      private function isResistanceStacking(param1:Number, param2:int) : *
      {
         var _loc6_:Number = NaN;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc3_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         var _loc4_:BMItemData = dataM.itemsDB[_loc3_.itemID];
         if(_loc4_.type != "module" || _loc4_.resist1 == 0 && _loc4_.resist2 == 0 && _loc4_.resist3 == 0)
         {
            return false;
         }
         var _loc5_:Number = 1;
         while(_loc5_ <= dataM.maxEquipment["module"])
         {
            if(_loc5_ != param2)
            {
               _loc6_ = Number(this.currentMechStructure["module" + _loc5_]);
               if(_loc6_ != 0)
               {
                  _loc7_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_);
                  _loc8_ = dataM.itemsDB[_loc7_.itemID];
                  if(_loc4_.resist1 > 0 && _loc8_.resist1 > 0 || _loc4_.resist2 > 0 && _loc8_.resist2 > 0 || _loc4_.resist3 > 0 && _loc8_.resist3 > 0)
                  {
                     return true;
                  }
               }
            }
            _loc5_++;
         }
         return false;
      }
      
      private function refreshAfterEquip() : void
      {
         this.refreshScrollButtons();
         dataM.myPlayerData.updateMechsWeight();
         this.currentMechStructure.updateEquipmentIndicators();
         this.refreshMechView();
         tutorialM.refreshWorkshopTutorial();
      }
      
      private function swapItemEquipmentPos(param1:Number, param2:Number, param3:*) : void
      {
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMPlayerItemData = null;
         if(param1 == param2)
         {
            return;
         }
         var _loc4_:String = param3 + param1;
         var _loc5_:String = param3 + param2;
         var _loc6_:Number = Number(this.currentMechStructure[_loc4_]);
         var _loc7_:Number = Number(this.currentMechStructure[_loc5_]);
         this.currentMechStructure[_loc5_] = _loc6_;
         this.currentMechStructure[_loc4_] = _loc7_;
         if(_loc6_ != 0)
         {
            _loc8_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_);
            _loc8_.equipped = this._currentMechID;
            _loc8_.equipmentID = param2;
            _loc8_.equipmentType = param3;
         }
         if(_loc7_ != 0)
         {
            _loc9_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_);
            _loc9_.equipped = this._currentMechID;
            _loc9_.equipmentID = param1;
            _loc9_.equipmentType = param3;
         }
         this.refreshAfterEquip();
         this.refreshSlotView(this.equipmentIDToSlot(param1,param3));
         this.refreshSlotView(this.equipmentIDToSlot(param2,param3));
         soundM.createSound("itemEquipped",1);
      }
      
      private function slotToEquipmentID(param1:int) : *
      {
         var _loc2_:String = this.selectedCatData.getEquipmentTypeAt(param1);
         if(dataM.maxEquipment.hasOwnProperty(_loc2_) && dataM.maxEquipment[_loc2_] > 1)
         {
            return param1 + 1;
         }
         return 0;
      }
      
      private function equipmentIDToSlot(param1:Number, param2:String) : int
      {
         if(param1 == 0)
         {
            return this.selectedCatData.getEquipmentSlotForType(param2);
         }
         return param1 - 1;
      }
      
      private function unEquipItem(param1:Number) : void
      {
         var _loc2_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         var _loc3_:BMItemData = dataM.itemsDB[_loc2_.itemID];
         var _loc4_:int = _loc2_.equipmentID;
         var _loc5_:String = _loc2_.equipmentID == 0 ? _loc3_.type : _loc3_.type + _loc4_;
         _loc2_.equipped = 0;
         _loc2_.equipmentID = 0;
         this.currentMechStructure[_loc5_] = 0;
         this.addItemsToInventory(0,[this.createInventoryTileList(param1)],false);
         this.refreshAfterEquip();
         this.refreshSlotView(this.equipmentIDToSlot(_loc4_,_loc3_.type));
      }
      
      private function dropItemAtClosestEquipment() : void
      {
         var _loc2_:BMPlayerData = null;
         var _loc3_:BMMechStructure = null;
         var _loc4_:Number = NaN;
         var _loc5_:BMItemData = null;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         if(draggingM.item == null)
         {
            return;
         }
         var _loc1_:String = draggingM.dragOrigin;
         if(_loc1_ == this.DRAG_TYPE_INVENTORY)
         {
            _loc2_ = dataM.playersData[dataM.player1PlayerID];
            _loc3_ = this.currentMechStructure;
            _loc4_ = draggingM.item.ID;
            _loc5_ = _loc2_.getItemBy(_loc4_);
            if(dataM.maxEquipment.hasOwnProperty(_loc5_.type) && dataM.maxEquipment[_loc5_.type] > 1)
            {
               _loc6_ = 1;
               _loc7_ = 1;
               while(_loc7_ <= dataM.maxEquipment[_loc5_.type])
               {
                  if(_loc3_[_loc5_.type + _loc7_] == 0 && !this.isEquipmentLocked(_loc7_,_loc5_.type))
                  {
                     _loc6_ = _loc7_;
                     break;
                  }
                  _loc7_++;
               }
            }
            else
            {
               _loc6_ = 0;
            }
            if(!this.isEquipmentLocked(_loc6_,_loc5_.type))
            {
               this.equipItem(_loc4_,_loc6_);
            }
         }
      }
      
      private function refreshMechView() : void
      {
         if(this._mechView == null)
         {
            this._mechView = new BMMechView();
            this._mechView.initialize(dataM.player1PlayerID,"hanger","playerItemID",0.58,true);
            this.mechViewHolder.addChild(this._mechView);
         }
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:uint = this._currentMechID;
         this._mechView.buildMech(_loc1_.mechStructures[_loc2_]);
         this._mechView.clearBreathingMovementData();
         this._mechView.removeTeasers(false);
         this._mechView.activateBreathing();
         this._mechView.y = -(this._mechView.mechSizer.height + this._mechView.mechSizer.y);
         this.mechWeight = this.currentMechStructure.mechWeight;
      }
      
      private function getMaxMechs() : int
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:uint = 0;
         var _loc5_:BMMechStructure = null;
         var _loc1_:uint = dataM.battleMaxMechs;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc2_.level < dataM.LEVEL_MAX)
         {
            _loc3_ = dataM.playersData[dataM.player1PlayerID];
            if(dataM.inventoryMaxMechs > dataM.battleMaxMechs)
            {
               _loc4_ = dataM.battleMaxMechs + 1;
               while(_loc4_ <= dataM.inventoryMaxMechs)
               {
                  _loc5_ = _loc3_.mechStructures[_loc4_];
                  if(_loc5_.hasAtLeastOneItem())
                  {
                     _loc1_ = dataM.inventoryMaxMechs;
                     _loc4_ = dataM.inventoryMaxMechs;
                  }
                  _loc4_++;
               }
            }
         }
         return _loc1_;
      }
      
      private function set mechWeight(param1:int) : void
      {
         var _loc2_:uint = 0;
         if(param1 > dataM.weightMax)
         {
            _loc2_ = uint("0x" + dataM.COLOR_BAD);
         }
         else
         {
            _loc2_ = uint("0x2BA304");
         }
         var _loc3_:* = new ColorTransform();
         _loc3_.color = _loc2_;
         this.mcWeightIconPlaceHolder.transform.colorTransform = _loc3_;
         this.txtWeight.textColor = _loc2_;
         this.txtWeight.text = dataM.getNumberWithComma(param1) + " / " + dataM.getNumberWithComma(dataM.weightMax);
         ImageUtils.swapTextFieldWithBitMap(this.txtWeight,this);
      }
      
      private function createUpdateMechLastData() : void
      {
         this._updateMech_lastItems = this.createPlayerItemsArr();
      }
      
      private function createPlayerItemsArr() : Array
      {
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:Array = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_.items.length)
         {
            _loc4_ = _loc1_.items[_loc3_];
            _loc5_ = _loc4_.equipped;
            if(_loc5_ >= 1)
            {
               _loc6_ = _loc4_.equipmentID == 0 ? _loc4_.equipmentType : _loc4_.equipmentType + _loc4_.equipmentID;
               _loc2_.push({
                  "slotName":_loc6_,
                  "equipped":_loc5_,
                  "playerItemID":_loc4_.playerItemID
               });
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function arePlayerItemsEqual(param1:Array, param2:Array) : Boolean
      {
         if(param1.length != param2.length)
         {
            return false;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].slotName != param2[_loc3_].slotName || param1[_loc3_].playerItemID != param2[_loc3_].playerItemID || param1[_loc3_].equipped != param2[_loc3_].equipped)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function updateMech(param1:Function) : void
      {
         if(dataM.mechIsOverWeight([this._currentMechID]))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",-1,-1);
            return;
         }
         var _loc2_:Array = this.createPlayerItemsArr();
         if(!this.arePlayerItemsEqual(_loc2_,this._updateMech_lastItems))
         {
            screensM.screenNewMenu.mechItemsDataToSave = _loc2_;
         }
         param1();
      }
      
      public function tutorialTasksCompletedTaunt(param1:Function = null) : void
      {
         this._tutorialTasksCompletedTauntFunction = param1;
         this._mechGlowHandler = true;
         this._mechGlowCounter = 0;
      }
      
      private function mechGlowHandlerFunction() : void
      {
         if(this._mechGlowHandler)
         {
            ++this._mechGlowCounter;
            switch(this._mechGlowCounter)
            {
               case 20:
                  this._mechView.activateTease2(null);
                  break;
               case 22:
               case 28:
               case 34:
               case 40:
               case 46:
               case 52:
                  this._mechView.addItemStaticGlow("torso","lightGreen");
                  this._mechView.addItemStaticGlow("leg","lightGreen");
                  this._mechView.addItemStaticGlow("sideWeapon1","lightGreen");
                  this._mechView.addItemStaticGlow("sideWeapon2","lightGreen");
                  break;
               case 25:
               case 31:
               case 37:
               case 43:
               case 49:
               case 55:
                  this._mechView.removeAllItemsStaticGlow();
                  break;
               case 58:
                  this._mechGlowHandler = false;
                  if(this._tutorialTasksCompletedTauntFunction != null)
                  {
                     this._tutorialTasksCompletedTauntFunction();
                  }
            }
         }
      }
      
      private function onRedeemMechClicked(param1:Event) : void
      {
         remoteM.socketM.lobby_redeemStarterPackMech(this._currentMechID);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      public function onRedeemMechComplete(param1:Boolean) : void
      {
         this.redeemMechBtn.visible = dataM.myProfile.pendingStarterPackMech > 0;
         if(param1)
         {
            this.showCurrentMechData();
            this.refreshCategorySlots();
            this.refreshMechView();
         }
      }
      
      private function initializeTutorialArrow() : void
      {
         if(this._tutorialArrowController == null)
         {
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow);
         }
      }
      
      public function activateBackTutorialArrow() : void
      {
         this.initializeTutorialArrow();
         var _loc1_:Number = this.mcSizer_btnBack.x + this.mcSizer_btnBack.width;
         var _loc2_:Number = this.mcSizer_btnBack.y + this.mcSizer_btnBack.height / 2;
         this._tutorialArrowController.activateTutorialArrowWithTimer(this,_loc1_,_loc2_);
      }
      
      public function disableInventory() : void
      {
         this._inventoryEnabled = false;
      }
      
      public function disableMech() : void
      {
         this._mechEnabled = false;
      }
      
      public function disableCategories() : void
      {
         this._categoriesEnabled = false;
      }
      
      private function getCategoryBtn(param1:int) : BMBasicSelectable
      {
         return this["btnCategory" + param1];
      }
      
      private function get currentMechStructure() : BMMechStructure
      {
         return dataM.myPlayerData.mechStructures[this._currentMechID];
      }
      
      private function get selectedCatData() : BMWorkshopCategoryData
      {
         return CATEGORIES_DATA[this._selectedCategory];
      }
      
      public function get inventoryTileList() : BMTileList
      {
         return this._inventoryTileList;
      }
      
      private function getSlotViewAt(param1:int) : BMBasicSelectable
      {
         return this["mcSlot" + param1];
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.removeDragItemHitAreas();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._mechView != null)
         {
            this._mechView.onEnterFrameTrigger();
            this.mechGlowHandlerFunction();
         }
      }
      
      public function backClicked() : void
      {
         this.updateMech(this.goToMainMenu);
      }
      
      private function goToMainMenu() : *
      {
         BMUpgradeManager.gi().selectedPlayerItemID = -1;
         screensM.screenNewMenu.mainMenu();
      }
      
      override public function notifyClientDataReloaded() : *
      {
         dataM.playersData[dataM.player1PlayerID] = this._savedPlayerData;
      }
   }
}

