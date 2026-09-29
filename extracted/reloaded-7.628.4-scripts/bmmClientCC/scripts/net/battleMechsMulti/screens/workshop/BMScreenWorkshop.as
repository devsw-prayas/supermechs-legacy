package net.battleMechsMulti.screens.workshop
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.specialOffers.BMOneTimeSpecialOffersManager;
   import net.battleMechsMulti.managers.upgrade.BMUpgradeManager;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemComparison.BMItemComparisonPanel;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemInfoPanel;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.mobiles.unlockedMechSlotsResolver.BMUnlockedMechSlotsResolver;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.inventory.BMInventoryTileListItem;
   import net.battleMechsMulti.screens.inventoryGracePeriodInfo.BMInventoryGracePeriodTimer;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.tacticsoft.utils.FunctionCall;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol139")]
   public class BMScreenWorkshop extends BMBaseScreen
   {
      
      private static const CATEGORIES_DATA:Vector.<BMWorkshopCategoryData> = new <BMWorkshopCategoryData>[new BMWorkshopCategoryData(["torso","leg"],"subType_inventory_torsoLeg",["emptyItem_torso","emptyItem_leg"]),new BMWorkshopCategoryData(["sideWeapon"],"subType_inventory_sideWeapon",["emptyItem_sideWeaponLeft","emptyItem_sideWeaponRight","emptyItem_sideWeaponLeft","emptyItem_sideWeaponRight"]),new BMWorkshopCategoryData(["topWeapon"],"subType_inventory_topWeapon",["emptyItem_topWeaponLeft","emptyItem_topWeaponRight"]),new BMWorkshopCategoryData(["drone","charge","shield","harpoon","teleport","perk"],"subType_inventory_special",["emptyItem_drone","emptyItem_charge","emptyItem_shield","emptyItem_harpoon","emptyItem_teleport","emptyItem_perk"]),new BMWorkshopCategoryData(["module"],"subType_inventory_module",["emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module","emptyItem_module"])];
      
      private static const VISIBLE_ITEM_TYPES:Array = ["torso","leg","sideWeapon","topWeapon"];
      
      public static const WEIGHT_EMPHASIZE_VAL:uint = 900;
      
      private const INVENTORY_ITEM_SIZE:uint = 67;
      
      private const MAX_ITEMS_FOR_UNIFIED_INVENTORY:uint = 15;
      
      private const MAX_ITEMS_FOR_NO_SCROLL:uint = 15;
      
      private const NUM_OF_INVENTORY_COLS:uint = 3;
      
      private const DRAG_TYPE_INVENTORY:String = "inventory";
      
      private const DRAG_TYPE_MECH:String = "mech";
      
      public var mcItemComparisonHolder:Sprite;
      
      public var mechViewHolder:Sprite;
      
      public var mcDragItemHitArea:Sprite;
      
      public var mcMechItemHitArea:Sprite;
      
      public var mcShowMechInfoHitArea:Sprite;
      
      public var mcDraggingFinger:MovieClip;
      
      public var mcTutorialArrow:MovieClip;
      
      public var mcNextMechArrow:MovieClip;
      
      public var mcMechStarterPackArrow:MovieClip;
      
      public var mechNumber:TextHolder;
      
      public var mcWeightIcon:MovieClip;
      
      public var mcWeightBackground:MovieClip;
      
      public var mcWeightOverloadHPIcon:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtWeight:TextField;
      
      public var txtWeightOverloadTitle:TextField;
      
      public var txtWeightOverloadPenalty:TextField;
      
      public var txtWeightOverweight:TextField;
      
      public var itemInfo:BMItemInfoPanel;
      
      public var mcInventoryGracePeriodTimer:BMInventoryGracePeriodTimer;
      
      public var mcSizer_btnBack:Sprite;
      
      public var inventoryPlaceHolder:Sprite;
      
      public var btnScrollUp:BMBasicButton;
      
      public var btnScrollDown:BMBasicButton;
      
      public var btnNextMech:BMBasicButton;
      
      public var btnPrevMech:BMBasicButton;
      
      public var upgardeBtn:BMBasicButton;
      
      public var redeemMechBtn:BMBasicButton;
      
      public var btnConvertLegacyItems:BMBasicButton;
      
      public var btnLibrary:BMBasicButton;
      
      public var btnMechBuilds:BMBasicButton;
      
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
      
      private var _numOfItemsInTileList:int = 0;
      
      private var _selectedCategory:int = -1;
      
      private var _currentMechID:* = 1;
      
      private var _updateMech_lastItems:Array;
      
      private var _inventoryEnabled:Boolean = true;
      
      private var _mechEnabled:Boolean = true;
      
      private var _categoriesEnabled:Boolean = true;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _mechStarterPackArrowController:BMTutorialArrowController;
      
      private var _nextMechArrowController:BMTutorialArrowController;
      
      private var _savedPlayerData:BMPlayerData;
      
      private var _inventorySelectedMc:BMInventoryTileListItem;
      
      private var _lastMouseX:Number = 0;
      
      private var _lastMouseY:Number = 0;
      
      private var _lastPerkPlayerItemID:uint = 0;
      
      private var _upgradeButtonOriginYPos:Number;
      
      private var itemComparisonPanel:BMItemComparisonPanel;
      
      private const MAX_SLOTS:uint = 8;
      
      private const EQUIP_TYPE_NONE:String = "none";
      
      private const EQUIP_TYPE_ITEMS_SWAPPED:String = "itemsSwapped";
      
      private const EQUIP_TYPE_EQUIPPED_FROM_INVENTORY_ON_EMPTY_SLOT:String = "equippedFromInventoryOnEmptySlot";
      
      private const EQUIP_TYPE_EQUIPPED_FROM_INVENTORY_ON_EQUIPPED_ITEM:String = "equippedFromInventoryOnEquippedItem";
      
      private const EQUIP_TYPE_CHANGED_EQUIPMENT_ID_ON_MECH:String = "changedEquipmentIDOnMech";
      
      private const EQUIP_TYPE_UNEQUIPPED_FROM_MECH:String = "unequippedFromMech";
      
      public function BMScreenWorkshop()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("workshop");
         this.initInventoryGracePeriodTimer();
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         this._savedPlayerData = dataM.playersData[dataM.player1PlayerID];
         this._upgradeButtonOriginYPos = this.upgardeBtn.y;
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.createUpdateMechLastData();
         this.initTileLists();
         this.initButtons();
         this.initMechInfoHitArea();
         this.removeDragItemHitAreas();
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
         this.initializeMechStarterPackArrow();
         this.initializeNextMechArrow();
         BMOneTimeSpecialOffersManager.gi().tryShowOfferInWorkshop();
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
         screensM.createButtonFromSizer(BMScreensManager.SCR_WORKSHOP,"btnBack","pictureE");
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
         this.upgardeBtn.addEventListener(BMIntractable.HIT,this.onUpgardeClicked);
         this.redeemMechBtn.addEventListener(BMIntractable.HIT,this.onRedeemMechClicked);
         this.redeemMechBtn.visible = dataM.myProfile.pendingStarterPackMech > 0;
         if(this.redeemMechBtn.visible)
         {
            this.activateMechStarterPackArrow();
            this.btnMechBuilds.y += 56;
         }
         if(dataM.mechBuildsM.isEnabled == false)
         {
            this.btnMechBuilds.visible = false;
         }
         this.btnConvertLegacyItems.addEventListener(BMIntractable.HIT,this.onConvertLegacyItemsClicked);
         this.btnConvertLegacyItems.text = "Legacy Converter";
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
         if(BMUnlockedMechSlotsResolver.getNumberOfMechsUnlocked() == 1)
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
         this.refreshConvertLegacyItemsButton();
         if(dataM.contentPackResolver.contentPacksEnabled())
         {
            this.btnLibrary.text = getSpecificText("contentPackLibrary_library");
            this.btnLibrary.addEventListener(BMIntractable.HIT,this.libraryClicked);
         }
         else
         {
            this.btnLibrary.visible = false;
         }
         this.btnMechBuilds.addEventListener(BMIntractable.HIT,this.mechBuildsClicked);
      }
      
      private function mechBuildsClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.cameFromWorkshop = true;
         this.updateMech(screensM.screenTransitionsManager.mechBuildsClicked);
      }
      
      private function libraryClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.cameFromWorkshop = true;
         screensM.screenTransitionsManager.contentPackLibraryClicked();
      }
      
      private function onUpgardeClicked(param1:Event) : void
      {
         if(this.checkForInvalidHPDueToOverload())
         {
            return;
         }
         if(FeatureFlags.BLOCK_UPGRADE)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         var _loc2_:BMItemData = dataM.myPlayerData.getItemBy(BMUpgradeManager.gi().selectedPlayerItemID);
         if(_loc2_.isDeprecated)
         {
            screensM.screenConfirmation.displayCustomMessage(getSpecificText("migration_legacyItemCanNotBeUpgraded"));
            return;
         }
         this.updateMech(screensM.screenTransitionsManager.upgrade);
      }
      
      private function onCategoryClick(param1:Event) : void
      {
         if(this._categoriesEnabled)
         {
            this.selectCategory(param1.target.id);
         }
      }
      
      private function checkForInvalidHPDueToOverload() : Boolean
      {
         if(dataM.doesMechHaveInvalidHPDueToOverload(this._currentMechID))
         {
            screensM.screenConfirmation.displayCustomMessage(getScreenText("invalidHP"));
            return true;
         }
         return false;
      }
      
      private function onNextMechClicked(param1:Event) : void
      {
         if(this.checkForInvalidHPDueToOverload())
         {
            return;
         }
         if(dataM.mechIsOverWeight([this._currentMechID]) > 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",this._currentMechID,-1);
            return;
         }
         if(this.checkForStationaryMechsWithFireJumpWeapons())
         {
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
         BMPubSub.pub(BMPubSub.MESSAGE_WORKSHOP_SWITCH_TO_MECH_X,{"mechID":this._currentMechID});
         this.refreshAfterMechChange();
      }
      
      private function onPrevMechClicked(param1:Event) : void
      {
         if(this.checkForInvalidHPDueToOverload())
         {
            return;
         }
         if(dataM.mechIsOverWeight([this._currentMechID]) > 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",this._currentMechID,-1);
            return;
         }
         if(this.checkForStationaryMechsWithFireJumpWeapons())
         {
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
      
      public function refreshAfterMechChange() : *
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
      
      private function checkForStationaryMechsWithFireJumpWeapons() : Boolean
      {
         var _loc1_:Array = dataM.getStationaryMechsWithFireJumpWeapons([this._currentMechID]);
         if(_loc1_.length == 0)
         {
            return false;
         }
         this.displayStationaryMechsWithRetreatWeaponBlock();
         return true;
      }
      
      private function isStationaryMechWithFireJumpWeapon(param1:uint) : Boolean
      {
         var _loc4_:Array = null;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         var _loc2_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         var _loc3_:BMItemData = dataM.itemsDB[_loc2_.itemID];
         if(_loc3_.type == BMMechStructure.LEG)
         {
            if(_loc3_.isNoJumpingLeg == false)
            {
               return false;
            }
            _loc4_ = dataM.getMechFireJumpWeaponPlayerItemIDs(this._currentMechID);
            if(_loc4_.length > 0)
            {
               this.displayStationaryMechsWithRetreatWeaponBlock(_loc4_[0]);
               return true;
            }
         }
         else
         {
            if(_loc3_.isFireJumpWeapon == false)
            {
               return false;
            }
            if(this.currentMechStructure.leg == 0)
            {
               return false;
            }
            _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,this.currentMechStructure.leg);
            _loc6_ = dataM.itemsDB[_loc5_.itemID];
            if(_loc6_.isNoJumpingLeg)
            {
               this.displayStationaryMechsWithRetreatWeaponBlock(param1);
               return true;
            }
         }
         return false;
      }
      
      private function displayStationaryMechsWithRetreatWeaponBlock(param1:Number = -1) : void
      {
         var _loc3_:uint = 0;
         var _loc7_:Array = null;
         var _loc2_:String = "<FONT COLOR=\'#FF3300\'>" + getScreenText("jumpingRequired") + "</FONT>" + "<BR><BR>" + getScreenText("weaponRequiresJumping");
         if(param1 > -1)
         {
            _loc3_ = param1;
         }
         else
         {
            _loc7_ = dataM.getMechFireJumpWeaponPlayerItemIDs(this._currentMechID);
            _loc3_ = uint(_loc7_[0]);
         }
         var _loc4_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,_loc3_);
         var _loc5_:BMItemData = dataM.itemsDB[_loc4_.itemID];
         var _loc6_:String = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + _loc5_.fullName + "</FONT>";
         _loc2_ = dataM.replaceStringInText(_loc2_,"%WEAPON%",_loc6_);
         screensM.screenConfirmation.displayCustomMessage(_loc2_);
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
         var _loc1_:int = 0;
         var _loc2_:BMBasicSelectable = null;
         this.currentMechStructure.updateEquipmentIndicators();
         _loc1_ = 0;
         while(_loc1_ < this.MAX_SLOTS)
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
         var _loc4_:BMInventoryTileListItem = null;
         var _loc5_:BMItemData = null;
         var _loc2_:BMBasicSelectable = this.getSlotViewAt(param1);
         var _loc3_:Number = this.getPlayerItemIdInSlot(param1);
         if(_loc3_ == 0)
         {
            _loc2_.content = this.createEmptySlotMc(param1);
         }
         else
         {
            _loc4_ = dataM.createInventoryTileListItem2(_loc3_,null,this.INVENTORY_ITEM_SIZE,this.onSlotItemDown,null);
            _loc5_ = dataM.myPlayerData.getItemBy(_loc3_);
            if(_loc5_.bullets > this.currentMechStructure.totalBullets)
            {
               _loc4_.addMarker(this.createNotEnoughAmmo("notEnoughBullets"));
            }
            if(_loc5_.rockets > this.currentMechStructure.totalRockets)
            {
               _loc4_.addMarker(this.createNotEnoughAmmo("notEnoughRockets"));
            }
            _loc2_.content = _loc4_;
            if(_loc4_.tileListItemID == BMUpgradeManager.gi().selectedPlayerItemID)
            {
               this.setInventoryItemSelected(_loc4_);
            }
         }
      }
      
      private function createEmptySlotMc(param1:int) : MovieClip
      {
         var _loc5_:TextHolder = null;
         var _loc2_:MovieClip = externalAssetsM.getAsset("general",this.selectedCatData.getSlotEmptyImage(param1),0,0,true);
         _loc2_.x = 4;
         _loc2_.y = 4;
         var _loc3_:int = this.getSlotUnlockLevel(param1);
         if(dataM.myProfile.level < _loc3_)
         {
            _loc5_ = new workshopLockedSlot();
            _loc5_.text = "lvl " + _loc3_;
            _loc2_.width = _loc5_.width - 8;
            _loc2_.height = _loc5_.height - 8;
            _loc5_.addChildAt(_loc2_,0);
            return _loc5_;
         }
         var _loc4_:MovieClip = new workshopEmptySlot();
         _loc2_.width = _loc4_.width - 8;
         _loc2_.height = _loc4_.height - 8;
         _loc4_.addChild(_loc2_);
         return _loc4_;
      }
      
      private function createNotEnoughAmmo(param1:String) : MovieClip
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
      
      private function getSlotUnlockLevel(param1:int) : int
      {
         var _loc2_:String = this.selectedCatData.getEquipmentTypeAt(param1);
         var _loc3_:int = this.slotToEquipmentID(param1);
         if(dataM.equipmentUnlockDB.hasOwnProperty(_loc2_))
         {
            return dataM.equipmentUnlockDB[_loc2_].level;
         }
         if(dataM.equipmentUnlockDB.hasOwnProperty(_loc2_ + _loc3_))
         {
            return dataM.equipmentUnlockDB[_loc2_ + _loc3_].level;
         }
         return 0;
      }
      
      private function onSlotItemDown(param1:Number, param2:Number) : void
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
         this.setInventoryItemSelected(_loc6_ as BMInventoryTileListItem);
         this.dragItem(this.DRAG_TYPE_MECH,param2,_loc5_);
         if(BMGameShortcutsHelper.gameSpeedShortcut())
         {
            this.dropItemAtClosestEquipment();
         }
      }
      
      public function refreshInventory(param1:Boolean = false) : void
      {
         this.setInventoryList(this.getInventoryPlayerItemIds(this.selectedCatData.equipmentTypesSlots),param1);
      }
      
      private function setInventoryList(param1:Array, param2:Boolean = false) : void
      {
         if(param1.length > 500)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            TweenMax.delayedCall(0.1,this.setInventoryListSub,[param1,param2]);
         }
         else
         {
            this.setInventoryListSub(param1,param2);
         }
      }
      
      private function setInventoryListSub(param1:Array, param2:Boolean = false) : void
      {
         var _loc8_:BMTileListItem = null;
         var _loc9_:uint = 0;
         var _loc10_:BMTileListItem = null;
         var _loc11_:TextFormat = null;
         var _loc12_:TextField = null;
         var _loc13_:BMInventoryTileListItem = null;
         var _loc3_:Array = new Array();
         var _loc4_:Boolean = param2 || param1.length != this._numOfItemsInTileList || param1.length == 0;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_.push(this.createInventoryTileList(param1[_loc5_]));
            if(this._inventoryTileList.items[_loc5_] == null)
            {
               _loc4_ = true;
            }
            else
            {
               _loc8_ = this._inventoryTileList.items[_loc5_];
               _loc4_ ||= _loc8_.tileListItemID != param1[_loc5_];
            }
            _loc5_++;
         }
         if(!_loc4_)
         {
            return;
         }
         this._inventoryTileList.removeAllItems();
         this._numOfItemsInTileList = param1.length;
         var _loc6_:int = int(_loc3_.length);
         while(_loc6_ < dataM.myProfile.inventorySizeState.maxSize)
         {
            _loc3_.push(dataM.createUnoccupiedTile(this.INVENTORY_ITEM_SIZE));
            _loc6_++;
         }
         _loc3_.push(dataM.createInventorySizeTile(this.INVENTORY_ITEM_SIZE));
         var _loc7_:int = 4;
         if(_loc3_.length <= this.MAX_ITEMS_FOR_NO_SCROLL)
         {
            _loc7_ = 5;
            this.btnScrollUp.visible = false;
            this.btnScrollDown.visible = false;
         }
         else
         {
            _loc7_ = 4;
            this.btnScrollUp.visible = true;
            this.btnScrollDown.visible = true;
         }
         if(this._inventoryTileList.getColumns() != _loc7_)
         {
            this._inventoryTileList.initialize(screensM.stagePointer,[],this.NUM_OF_INVENTORY_COLS,_loc7_,this.INVENTORY_ITEM_SIZE,this.INVENTORY_ITEM_SIZE,null,true,null,null,null,false,0,0.4,true,true,false,"",true);
         }
         if(FeatureFlags.SHOW_INVENTORY_ITEM_NUMBERS)
         {
            _loc9_ = 0;
            for each(_loc10_ in _loc3_)
            {
               _loc9_ += 1;
               _loc11_ = new TextFormat("American Captain Eternal",23,16777215);
               _loc12_ = new TextField();
               _loc12_.setTextFormat(_loc11_);
               _loc12_.defaultTextFormat = _loc11_;
               _loc12_.text = String(_loc9_);
               _loc12_.autoSize = TextFieldAutoSize.LEFT;
               _loc10_.addChild(_loc12_);
            }
         }
         this.addItemsToInventory(this._inventoryTileList.highestTileID + 1,_loc3_,false);
         if(BMUpgradeManager.gi().selectedPlayerItemID != -1)
         {
            _loc13_ = this._inventoryTileList.findTileListItemByTileListItemID(BMUpgradeManager.gi().selectedPlayerItemID) as BMInventoryTileListItem;
            if(_loc13_ != null)
            {
               this.setInventoryItemSelected(_loc13_);
            }
         }
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.refreshScrollButtons();
         tutorialM.refreshWorkshopTutorial();
      }
      
      private function addItemsToInventory(param1:Number, param2:Array, param3:Boolean) : void
      {
         this._inventoryTileList.addItems(param1,param2,param3);
         this._inventoryTileList.fillEmptyGridCells(new FunctionCall(dataM.createEmptyInvntoryTileList2,[this.INVENTORY_ITEM_SIZE]),param3);
      }
      
      private function createInventoryTileList(param1:Number) : BMInventoryTileListItem
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
            this.setInventoryItemSelected(this._inventoryTileList.findTileListItemByTileID(param1) as BMInventoryTileListItem);
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
      
      private function setInventoryItemSelected(param1:BMInventoryTileListItem) : void
      {
         this.removeInventoryItemSelected();
         this._inventorySelectedMc = param1;
         this._inventorySelectedMc.isSelected = true;
      }
      
      private function removeInventoryItemSelected() : void
      {
         if(this._inventorySelectedMc != null)
         {
            this._inventorySelectedMc.isSelected = false;
            this._inventorySelectedMc = null;
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
         var _loc4_:uint = 0;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc9_:* = undefined;
         var _loc10_:Object = null;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.items.length)
         {
            _loc7_ = _loc2_.items[_loc4_];
            _loc8_ = dataM.itemsDB[_loc7_.itemID];
            if(_loc7_.equipmentType != "kit")
            {
               if(!(param1 != null && param1.indexOf(_loc7_.equipmentType) == -1 && _loc2_.items.length > this.MAX_ITEMS_FOR_UNIFIED_INVENTORY))
               {
                  if(_loc7_.equipped <= 0)
                  {
                     _loc9_ = _loc8_.specialStatus;
                     if(_loc8_.specialStatus == 5)
                     {
                        _loc9_ = 0;
                     }
                     _loc10_ = {
                        "chainID":_loc8_.chainID,
                        "displayLevel":_loc8_.displayLevel,
                        "playerItemID":_loc7_.playerItemID,
                        "isDeprecated":(_loc8_.isDeprecated ? 0 : 1),
                        "usedSpecialStatus":_loc9_
                     };
                     _loc3_.push(_loc10_);
                  }
               }
            }
            _loc4_++;
         }
         _loc3_.sortOn(["isDeprecated","usedSpecialStatus","displayLevel","chainID"],Array.NUMERIC | Array.DESCENDING);
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc5_.push(_loc3_[_loc6_].playerItemID);
            _loc6_++;
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
         if(tutorialM.isTutorialActive())
         {
            this.btnScrollUp.disableMe();
            this.btnScrollDown.disableMe();
            return;
         }
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
      
      public function onInventorySlotsBought() : *
      {
         this.refreshInventory(true);
         this._inventoryTileList.scrollToID(this._inventoryTileList.items.length - 1,"bottom","tileID");
         this.refreshScrollButtons();
      }
      
      private function selectItem(param1:Number) : void
      {
         BMUpgradeManager.gi().selectedPlayerItemID = param1;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:BMPlayerItemData = _loc2_.getPlayerItemBy(param1);
         var _loc4_:BMItemData = dataM.itemsDB[_loc3_.itemID];
         this.itemInfo.propertiesPanel.y = MovieClip(this.itemInfo).itemPropertiesPos.y;
         this.itemInfo.showItemInfo(_loc3_);
         this.repositionUpgradeButton();
         if(tutorialM.workshop_upgradeButtonVisible() && _loc4_.canBeUpgarded)
         {
            this.upgardeBtn.visible = true;
         }
         else
         {
            this.upgardeBtn.visible = false;
         }
         this.selectCategory(this.getCategoryForType(_loc4_.type));
      }
      
      private function repositionUpgradeButton() : void
      {
         this.upgardeBtn.y = this._upgradeButtonOriginYPos;
         if(this.itemInfo.propertiesPanel.propertiesCount > 10)
         {
            if(this.itemInfo.propertiesPanel.propertiesCount <= 12)
            {
               this.upgardeBtn.y -= 20;
            }
            else
            {
               this.upgardeBtn.y -= 40;
            }
         }
      }
      
      private function showCurrentMechData() : *
      {
         this.upgardeBtn.visible = false;
         this.itemInfo.showMech(this.currentMechStructure);
         BMUpgradeManager.gi().selectedPlayerItemID = -1;
         this.removeInventoryItemSelected();
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
               _loc1_ = this._inventoryTileList.items[draggingM.dragTileID];
               if(_loc1_.item == null)
               {
                  break;
               }
               this._inventoryTileList.enableItems([draggingM.dragTileID],"tileID");
               break;
            case this.DRAG_TYPE_MECH:
               if(this.getSlotViewAt(draggingM.dragTileID).content is BMTileListItem)
               {
                  _loc1_ = this.getSlotViewAt(draggingM.dragTileID).content as BMTileListItem;
                  if(_loc1_.item == null)
                  {
                     break;
                  }
                  _loc1_.removeDisabledEffect();
               }
         }
         draggingM.deactivateDragging();
         this.removeDragItemHitAreas();
         this.removeItemComparison();
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
         while(_loc1_ < this.MAX_SLOTS)
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
      
      public function equipItem(param1:Number, param2:int) : *
      {
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:Number = NaN;
         if(this.isResistanceStacking(param1,param2))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("resistanceModuleBlock",-1,-1);
            return;
         }
         if(this.isStationaryMechWithFireJumpWeapon(param1))
         {
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
         var _loc8_:String = this.EQUIP_TYPE_EQUIPPED_FROM_INVENTORY_ON_EMPTY_SLOT;
         if(_loc7_ > 0)
         {
            _loc8_ = this.EQUIP_TYPE_EQUIPPED_FROM_INVENTORY_ON_EQUIPPED_ITEM;
            _loc9_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_);
            _loc9_.equipped = 0;
            _loc9_.equipmentID = 0;
            _loc10_ = this.inventoryTileList.findTileIDByTileListItemID(param1);
            this._inventoryTileList.addItems(_loc10_,[this.createInventoryTileList(_loc7_)],false);
            ++this._numOfItemsInTileList;
         }
         this.currentMechStructure[_loc6_] = param1;
         _loc4_.equipped = this._currentMechID;
         _loc4_.equipmentID = param2;
         _loc4_.equipmentType = _loc5_.type;
         this.inventoryTileList.removeItems([param1],"tileListItemID");
         --this._numOfItemsInTileList;
         if(this._numOfItemsInTileList < dataM.myProfile.inventorySizeState.maxSize)
         {
            this._inventoryTileList.addItems(this._numOfItemsInTileList,[dataM.createUnoccupiedTile(this.INVENTORY_ITEM_SIZE)],false);
         }
         this._inventoryTileList.fillEmptyGridCells(new FunctionCall(dataM.createEmptyInvntoryTileList2,[this.INVENTORY_ITEM_SIZE]),false);
         this.refreshAfterEquip(_loc8_,_loc5_.type,0,param2);
         this.refreshSlotView(this.equipmentIDToSlot(param2,_loc5_.type));
         dataM.trackEvent(BMDataManager.ANALYTICS_PRIORITY_LOWEST,"Workshop","EquipItem",_loc5_.type,_loc5_.itemID);
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
      
      private function refreshAfterEquip(param1:String = "none", param2:String = "", param3:uint = 0, param4:uint = 0) : void
      {
         this.refreshScrollButtons();
         dataM.myPlayerData.updateMechsWeight();
         this.currentMechStructure.updateEquipmentIndicators();
         this.unequipAnimationsHandler(param1,param2,param3,param4);
         var _loc5_:Boolean = this._mechView.mechStructure.torso == 0;
         this.refreshMechView();
         this.equipAnimationsHandler(param1,param2,param3,param4,_loc5_);
         tutorialM.refreshWorkshopTutorial();
      }
      
      private function swapItemEquipmentPos(param1:Number, param2:Number, param3:*) : void
      {
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:BMPlayerItemData = null;
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
            _loc9_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_);
            _loc9_.equipped = this._currentMechID;
            _loc9_.equipmentID = param2;
            _loc9_.equipmentType = param3;
         }
         if(_loc7_ != 0)
         {
            _loc10_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_);
            _loc10_.equipped = this._currentMechID;
            _loc10_.equipmentID = param1;
            _loc10_.equipmentType = param3;
         }
         var _loc8_:String = this.EQUIP_TYPE_CHANGED_EQUIPMENT_ID_ON_MECH;
         if(_loc6_ > 0 && _loc7_ > 0)
         {
            _loc8_ = this.EQUIP_TYPE_ITEMS_SWAPPED;
         }
         this.refreshAfterEquip(_loc8_,param3,param1,param2);
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
         if(this._numOfItemsInTileList < dataM.myProfile.inventorySizeState.maxSize)
         {
            this._inventoryTileList.removeItems([this._numOfItemsInTileList],"tileID");
         }
         this.addItemsToInventory(0,[this.createInventoryTileList(param1)],false);
         ++this._numOfItemsInTileList;
         this.refreshAfterEquip(this.EQUIP_TYPE_UNEQUIPPED_FROM_MECH,_loc3_.type,_loc4_);
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
            this._mechView.initialize(dataM.player1PlayerID,"hanger",BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,0.58,true);
            this.mechViewHolder.addChild(this._mechView);
         }
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:uint = this._currentMechID;
         var _loc3_:BMMechStructure = _loc1_.mechStructures[_loc2_];
         if(this._lastPerkPlayerItemID != _loc3_.perk)
         {
            this._mechView.forceRebuildingTorso = true;
         }
         this._lastPerkPlayerItemID = _loc3_.perk;
         this._mechView.buildMech(_loc3_,this.refreshMechViewSub);
         this.mechWeight = this.currentMechStructure.mechWeight;
         this.mechNumber.mcIcon.visible = false;
         if(BMUnlockedMechSlotsResolver.getNumberOfMechsUnlocked() == 1)
         {
            this.mechNumber.visible = false;
         }
         else
         {
            this.mechNumber.text = this._currentMechID;
            this.mechNumber.visible = true;
         }
      }
      
      private function refreshMechViewSub() : void
      {
         this._mechView.removeTeasers(false);
         this._mechView.activateBreathing();
      }
      
      private function getMaxMechs() : int
      {
         return BMUnlockedMechSlotsResolver.getNumberOfMechsUnlocked();
      }
      
      private function set mechWeight(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = "FFFFFF";
         var _loc4_:String = "default";
         this.txtWeightOverloadPenalty.text = "";
         this.txtWeightOverloadTitle.text = "";
         this.txtWeightOverweight.text = "";
         this.mcWeightOverloadHPIcon.visible = false;
         if(param1 > dataM.weightMax + dataM.weightOverload)
         {
            _loc2_ = dataM.COLOR_BAD;
            _loc4_ = "overweight";
            updateTextAndFormat(this.txtWeightOverweight,getScreenText("overweight"));
         }
         else if(param1 > dataM.weightMax)
         {
            _loc2_ = "FF6600";
            _loc4_ = "overload";
            this.txtWeightOverloadPenalty.text = "-" + dataM.getOverloadHPPenaltyForWeight(param1);
            updateTextAndFormat(this.txtWeightOverloadTitle,getScreenText("overload"));
            this.mcWeightOverloadHPIcon.visible = true;
         }
         else if(param1 >= WEIGHT_EMPHASIZE_VAL)
         {
            _loc2_ = "FFFFFF";
         }
         else
         {
            _loc2_ = "666666";
            _loc3_ = "666666";
         }
         this.mcWeightBackground.gotoAndStop(_loc4_);
         if(param1 >= WEIGHT_EMPHASIZE_VAL)
         {
            this.mcWeightIcon.gotoAndStop(2);
         }
         else
         {
            this.mcWeightIcon.gotoAndStop(1);
         }
         this.txtWeight.htmlText = "<FONT COLOR=\'#" + _loc2_ + "\'>" + param1 + "</FONT><FONT COLOR=\'#" + _loc3_ + "\'> / " + dataM.weightMax;
         ImageUtils.swapTextFieldWithBitMap(this.txtWeight,this);
         this.putItemComparisonHolderOnTop();
      }
      
      private function putItemComparisonHolderOnTop() : void
      {
         this.mcItemComparisonHolder.parent.removeChild(this.mcItemComparisonHolder);
         addChild(this.mcItemComparisonHolder);
      }
      
      private function createUpdateMechLastData() : void
      {
         this._updateMech_lastItems = dataM.createPlayerItemsArr();
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
      
      public function updateMech(param1:Function = null) : void
      {
         if(dataM.mechIsOverWeight([this._currentMechID]) > 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",this._currentMechID,-1);
            return;
         }
         if(this.checkForStationaryMechsWithFireJumpWeapons())
         {
            return;
         }
         var _loc2_:Array = dataM.createPlayerItemsArr();
         if(!this.arePlayerItemsEqual(_loc2_,this._updateMech_lastItems))
         {
            screensM.screenTransitionsManager.mechItemsDataToSave = _loc2_;
         }
         if(param1 == null)
         {
            return;
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
         this.deactivateMechStarterPackArrow();
         if(param1)
         {
            this.showCurrentMechData();
            this.refreshCategorySlots();
            this.refreshMechView();
            this.refreshInventory(true);
         }
      }
      
      private function initInventoryGracePeriodTimer() : void
      {
         this.mcInventoryGracePeriodTimer.activateTimer(true);
         if(this.mcInventoryGracePeriodTimer.isActive() == false)
         {
            return;
         }
         this.mcInventoryGracePeriodTimer.activateStatus();
         this.mcInventoryGracePeriodTimer.activateInfoButton(this.inventoryGracePeriodInfoClicked);
         this.txtTitle.x -= 150;
      }
      
      private function inventoryGracePeriodInfoClicked() : void
      {
         screensM.addScreen("screenInventoryGracePeriodInfo");
      }
      
      private function openConvertLegacyItems() : void
      {
         screensM.addScreen(BMScreensManager.SCR_CONVERT_LEGACY_ITEMS);
      }
      
      public function showEquipmentSequence(param1:Object) : void
      {
      }
      
      private function switchCategoryByPlayerItemID() : Number
      {
         return 1;
      }
      
      private function unequipAnimationsHandler(param1:String = "none", param2:String = "", param3:uint = 0, param4:uint = 0) : void
      {
         var _loc5_:Boolean = false;
         switch(param1)
         {
            case this.EQUIP_TYPE_ITEMS_SWAPPED:
               this._mechView.activateUnequipAnimation(param2,param3);
         }
         switch(param1)
         {
            case this.EQUIP_TYPE_UNEQUIPPED_FROM_MECH:
               _loc5_ = param2 == BMMechStructure.TORSO;
               this._mechView.activateUnequipAnimation(param2,param3,_loc5_);
         }
         switch(param1)
         {
            case this.EQUIP_TYPE_CHANGED_EQUIPMENT_ID_ON_MECH:
            case this.EQUIP_TYPE_EQUIPPED_FROM_INVENTORY_ON_EQUIPPED_ITEM:
               this._mechView.activateUnequipAnimation(param2,param4);
         }
         switch(param1)
         {
            case this.EQUIP_TYPE_ITEMS_SWAPPED:
               this._mechView.activateUnequipAnimation(param2,param4);
         }
      }
      
      private function equipAnimationsHandler(param1:String = "none", param2:String = "", param3:uint = 0, param4:uint = 0, param5:Boolean = false) : void
      {
         switch(param1)
         {
            case this.EQUIP_TYPE_ITEMS_SWAPPED:
               this._mechView.activateEquipmentAnimation(param2,param3);
         }
         switch(param1)
         {
            case this.EQUIP_TYPE_ITEMS_SWAPPED:
            case this.EQUIP_TYPE_EQUIPPED_FROM_INVENTORY_ON_EMPTY_SLOT:
            case this.EQUIP_TYPE_EQUIPPED_FROM_INVENTORY_ON_EQUIPPED_ITEM:
               this._mechView.activateEquipmentAnimation(param2,param4,param5);
         }
         switch(param1)
         {
            case this.EQUIP_TYPE_CHANGED_EQUIPMENT_ID_ON_MECH:
               this._mechView.activateEquipmentAnimation(param2,param3);
         }
      }
      
      private function onConvertLegacyItemsClicked(param1:Event) : void
      {
         this.updateMech(screensM.screenTransitionsManager.convertLegacyItems);
      }
      
      public function refreshConvertLegacyItemsButton() : void
      {
         if(this.showConvertLegacyItemsButton())
         {
            this.btnConvertLegacyItems.visible = true;
         }
         else
         {
            this.btnConvertLegacyItems.visible = false;
         }
      }
      
      private function showConvertLegacyItemsButton() : Boolean
      {
         if(tutorialM.isTutorialActive() == false)
         {
            if(dataM.getLegacyItemsAmountTotal() > 0)
            {
               return true;
            }
         }
         return false;
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
      
      private function initializeMechStarterPackArrow() : void
      {
         if(this._mechStarterPackArrowController == null)
         {
            this._mechStarterPackArrowController = new BMTutorialArrowController(this.mcMechStarterPackArrow);
         }
      }
      
      private function activateMechStarterPackArrow() : void
      {
         this.initializeMechStarterPackArrow();
         var _loc1_:Number = this.redeemMechBtn.x - this.redeemMechBtn.width / 2 - 2;
         var _loc2_:Number = this.redeemMechBtn.y;
         var _loc3_:uint = 180;
         this._mechStarterPackArrowController.activateTutorialArrowWithTimer(this,_loc1_,_loc2_,_loc3_);
      }
      
      private function deactivateMechStarterPackArrow() : void
      {
         if(this._mechStarterPackArrowController == null)
         {
            return;
         }
         this._mechStarterPackArrowController.deactivateTutorialArrow();
      }
      
      private function initializeNextMechArrow() : void
      {
         if(this._nextMechArrowController == null)
         {
            this._nextMechArrowController = new BMTutorialArrowController(this.mcNextMechArrow);
         }
      }
      
      public function activateNextMechArrow() : void
      {
         this.initializeNextMechArrow();
         var _loc1_:Number = this.btnNextMech.x;
         var _loc2_:Number = this.btnNextMech.y - 10;
         var _loc3_:uint = 270;
         this._nextMechArrowController.activateTutorialArrowWithTimer(this,_loc1_,_loc2_,_loc3_);
      }
      
      public function deactivateNextMechArrow() : void
      {
         if(this._nextMechArrowController == null)
         {
            return;
         }
         this._nextMechArrowController.deactivateTutorialArrow();
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
         if(this._mechView != null)
         {
            this._mechView.removeMe();
            this._mechView = null;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._mechView != null)
         {
            this._mechView.onEnterFrameTrigger();
            this.mechGlowHandlerFunction();
            this.itemComparisonHandler();
         }
      }
      
      private function itemComparisonHandler() : void
      {
         var _loc3_:BMBasicSelectable = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:BMInventoryTileListItem = null;
         var _loc8_:Number = NaN;
         if(draggingM.item == null)
         {
            return;
         }
         if(this._lastMouseX == mouseX && this._lastMouseY == mouseY)
         {
            return;
         }
         this._lastMouseX = mouseX;
         this._lastMouseY = mouseY;
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         while(_loc2_ < this.MAX_SLOTS)
         {
            _loc3_ = this.getSlotViewAt(_loc2_);
            if(_loc3_.visible != false)
            {
               _loc4_ = mouseX - (_loc3_.x + _loc3_.width / 2);
               _loc5_ = mouseY - (_loc3_.y + _loc3_.height / 2);
               _loc6_ = dataM.getVectorSize(_loc4_,_loc5_);
               if(_loc6_ <= 30)
               {
                  if(_loc3_.content is BMInventoryTileListItem)
                  {
                     _loc7_ = _loc3_["content"];
                     _loc1_ = this.showItemComparison(_loc7_.item.ID,draggingM.item.ID);
                     if(_loc1_)
                     {
                        return;
                     }
                  }
               }
            }
            _loc2_++;
         }
         if(this._inventoryTileList != null)
         {
            _loc8_ = Number(this._inventoryTileList.getItemIDInCoords(mouseX - this.inventoryPlaceHolder.x,mouseY - this.inventoryPlaceHolder.y)[1]);
            if(_loc8_ > -1)
            {
               _loc1_ = this.showItemComparison(_loc8_,draggingM.item.ID);
               if(_loc1_)
               {
                  return;
               }
            }
         }
         this.removeItemComparison();
      }
      
      private function showItemComparison(param1:uint, param2:uint) : Boolean
      {
         if(int(dataM.getGeneralSetting("useItemComparison",0)) == 0)
         {
            return false;
         }
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         if(this.itemComparisonPanel == null)
         {
            this.itemComparisonPanel = new BMItemComparisonPanel();
            this.itemComparisonPanel.initialize();
            this.itemComparisonPanel.x = 132;
         }
         var _loc3_:Boolean = false;
         if(dataM.myProfile.level < 15)
         {
            _loc3_ = true;
         }
         var _loc4_:Boolean = this.itemComparisonPanel.refreshScreen(param1,param2,_loc3_,this.mcItemComparisonHolder);
         if(_loc4_)
         {
            screensM.clientPointer.ignoreNextLongPress();
         }
         return _loc4_;
      }
      
      private function removeItemComparison() : void
      {
         if(this.itemComparisonPanel == null)
         {
            return;
         }
         if(this.itemComparisonPanel.parent == null)
         {
            return;
         }
         this.itemComparisonPanel.removeMe();
      }
      
      public function backClicked() : void
      {
         if(this.checkForInvalidHPDueToOverload())
         {
            return;
         }
         this.updateMech(this.goToMainMenu);
      }
      
      private function goToMainMenu() : *
      {
         this.removeItemComparison();
         BMUpgradeManager.gi().selectedPlayerItemID = -1;
         screensM.screenTransitionsManager.mainMenu();
      }
      
      override public function notifyClientDataReloaded() : *
      {
         dataM.playersData[dataM.player1PlayerID] = this._savedPlayerData;
      }
   }
}

