package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.managers.specialAbilities.BMMechSpecialAbilitiesResolver;
   import net.battleMechsMulti.managers.upgrade.BMPotentialBoostInfo;
   import net.battleMechsMulti.managers.upgrade.BMUpgradeManager;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.dropdownList.BMDropdownList;
   import net.battleMechsMulti.mobiles.dropdownList.BMDropdownListItemData;
   import net.battleMechsMulti.mobiles.itemComparison.BMMechBoostRecommender;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemInfoPanel;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.popups.BMScreenYesNoPopup;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   import net.tacticsoft.utils.FunctionCall;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2902")]
   public class BMScreenHangerUpgrade extends BMBaseScreen
   {
      
      private const MILLISECONDS_FOR_HINT:uint = 300;
      
      private const INVENTORY_ITEM_SIZE:uint = 67;
      
      private const INVENTORY_ITEM_SIZE_MOBILE:uint = 74;
      
      private const INVENTORY_ROWS:uint = 5;
      
      private const INVENTORY_ROWS_MOBILE:uint = 4;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnGetGold:Sprite;
      
      public var btnMassSelection:BMBasicButton;
      
      public var btnMassSelectionHighlighted:BMBasicButton;
      
      public var btnClearMassSelection:BMBasicButton;
      
      public var mcMassSelectionPosition:Sprite;
      
      public var mcFingerWheelingHitArea:Sprite;
      
      public var mcTileListHolder:Sprite;
      
      public var itemTypesPlaceHolder:Sprite;
      
      public var mcInventoryTileListPosition:Sprite;
      
      public var mcButtonsHolder:MovieClip;
      
      public var btnUpgrade:BMScreenHangerUpgradeBtn;
      
      public var btnGetGold:BMButton_plus2;
      
      public var btnBack:BMButton_pictureE;
      
      public var txtTitle:TextField;
      
      public var txtGold:TextField;
      
      public var mcTutorialArrow_back:MovieClip;
      
      public var mcTutorialArrow_boost:MovieClip;
      
      public var itemInfo:BMItemInfoPanel;
      
      public var upgradePanels:MovieClip;
      
      public var massSelectionData:BMMassSelectionData;
      
      private var _itemTypeDropdown:BMDropdownList;
      
      private var _inventoryTileList:BMTileList;
      
      private var _numOfItemsInTileList:int = 0;
      
      private var _targetPlayerItemID:Number = -1;
      
      private var _currentUpgradePanel:BMUpgradeBasePanel;
      
      private var _upgradeManager:BMUpgradeManager;
      
      private var _tutorialArrowController_back:BMTutorialArrowController;
      
      private var _tutorialArrowController_boost:BMTutorialArrowController;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _itemInfoVisibleLastFrame:Boolean = false;
      
      private var panelsStartX:Number;
      
      private var _mouseDownTime:Number;
      
      private var _mouseDownPlayerItemID:Number = -1;
      
      private var _waitingForCreditsShopClose:Boolean = false;
      
      private var _addedIndividualItemsToSourceItemList:Boolean = true;
      
      private const DROPDOWN_LIST_ENHANCE_ID:uint = 8;
      
      private var _lastDropdownListItemID:int = -1;
      
      public function BMScreenHangerUpgrade()
      {
         super();
         this._upgradeManager = BMUpgradeManager.gi();
         this.panelsStartX = this.upgradePanels.x;
      }
      
      public function initialize() : void
      {
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("upgrade");
         this.massSelectionData = new BMMassSelectionData();
         this.massSelectionData.setUpdateCallback(this.handleMassSelectionChanged);
         this.hideItemHint();
         this.initMobileFingerWheeling();
         this.initTileLists();
         this.initMassSelection();
         this.initItemTypeDropdown();
         this.initTexts();
         this.initButtons();
         this.initUpgradePanels();
         this.refreshGold();
         this.resetUpgradeState();
         this.refreshItemDropdownAndMassSelectionInterface();
         this.movePanels(0);
         if(BMUpgradeManager.gi().selectedPlayerItemID != -1)
         {
            this.selectTargetItem(BMUpgradeManager.gi().selectedPlayerItemID);
         }
         this.initializeTutorialArrow_back();
         this.initializeTutorialArrow_boost();
         if(dataM.mechBoostRecommender.activeRecommendationPlayerItemID != BMMechBoostRecommender.NO_RECOMMENDATION)
         {
            this.selectTargetItem(dataM.mechBoostRecommender.activeRecommendationPlayerItemID);
         }
      }
      
      private function initTexts() : void
      {
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         updateTextAndFormat(this.introPanel.txtTitle,getScreenText("selectAnItem"));
         updateTextAndFormat(this.introPanel.txtExtraInfo,getScreenText("holdItemForInfo"));
      }
      
      private function initMobileFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling = new BMFingerWheeling();
            this._fingerWheeling.initialize("hangerUpgrade",this._inventoryTileList,this.mcFingerWheelingHitArea,this.onInventoryItemClicked,null,false,this.onInventoryItemDown,this.onInventoryMouseUp);
            addChild(this._fingerWheeling);
         }
         else
         {
            this.mcFingerWheelingHitArea.parent.removeChild(this.mcFingerWheelingHitArea);
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      private function get isInMassSelectionMode() : Boolean
      {
         return screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE_MASS_SELECTION);
      }
      
      private function initMassSelection() : void
      {
         this.btnMassSelection.text = languageM.getText("massSelect_title");
         this.btnMassSelection.addEventListener(BMIntractable.HIT,this.massSelectionClicked);
         this.btnMassSelectionHighlighted.text = languageM.getText("massSelect_title");
         this.btnMassSelectionHighlighted.addEventListener(BMIntractable.HIT,this.massSelectionClicked);
         this.btnClearMassSelection.addEventListener(BMIntractable.HIT,this.clearMassSelectionClicked);
      }
      
      private function hideMassSelectionWindow() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE_MASS_SELECTION))
         {
            screensM.removeScreen(BMScreensManager.SCR_HANGER_UPGRADE_MASS_SELECTION);
            this._inventoryTileList.visible = true;
         }
      }
      
      private function massSelectionClicked(param1:Event) : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE_MASS_SELECTION))
         {
            this.hideMassSelectionWindow();
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_HANGER_UPGRADE_MASS_SELECTION);
            screensM.screenHangerUpgradeMassSelection.moveMe(this.mcMassSelectionPosition.x,this.mcMassSelectionPosition.y);
            this._inventoryTileList.visible = false;
            this.massSelectionData.setDefault();
            screensM.screenHangerUpgradeMassSelection.refreshAllState();
         }
         this.refreshItemDropdownAndMassSelectionInterface();
      }
      
      private function refreshMassSelectionEnabledState() : void
      {
         this.refreshItemDropdownAndMassSelectionInterface();
      }
      
      private function clearMassSelectionClicked(param1:Event) : void
      {
         this.hideMassSelectionWindow();
         this._currentUpgradePanel.removeAllSourceItems();
         this.refreshItemDropdownAndMassSelectionInterface();
      }
      
      private function useMassSelection() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         if(this._currentUpgradePanel == this.boostPanel)
         {
            if(tutorialM.isTutorialActive())
            {
               return false;
            }
            _loc1_ = dataM.myProfile.level;
            _loc2_ = dataM.getGeneralSetting("minPlayerLevelForMassSelection",30);
            if(_loc1_ < _loc2_)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function refreshItemDropdownAndMassSelectionInterface() : void
      {
         if(this.useMassSelection())
         {
            this.btnMassSelection.visible = false;
            this.btnMassSelectionHighlighted.visible = false;
            if(screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE_MASS_SELECTION))
            {
               this.btnMassSelectionHighlighted.visible = true;
            }
            else
            {
               this.btnMassSelection.visible = true;
               if(this._currentUpgradePanel.getNumOfSource() > 0 && this._addedIndividualItemsToSourceItemList)
               {
                  this.btnMassSelection.disableMe();
               }
               else
               {
                  this.btnMassSelection.enableMe();
               }
            }
            this.btnClearMassSelection.visible = true;
            this._itemTypeDropdown.visible = false;
         }
         else
         {
            this.btnMassSelection.visible = false;
            this.btnMassSelectionHighlighted.visible = false;
            this.btnClearMassSelection.visible = false;
            this._itemTypeDropdown.visible = true;
         }
      }
      
      private function handleMassSelectionChanged() : void
      {
         var _loc4_:uint = 0;
         this._currentUpgradePanel.beginAddToSourceBatch();
         this.onUpgradeComplete(false);
         var _loc1_:Array = dataM.getMassBoostMaterialPlayerItemIDs(this.massSelectionData);
         if(_loc1_.length == 0)
         {
            this._currentUpgradePanel.endAddToSourceBatch();
            return;
         }
         if(this._currentUpgradePanel.isTargetMaxLevel())
         {
            this._currentUpgradePanel.endAddToSourceBatch();
            return;
         }
         var _loc2_:BMPotentialBoostInfo = this._upgradeManager.getPotentialBoostInfo(this._targetPlayerItemID,_loc1_,false,true);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.playerItemIDsToAddToSource.length)
         {
            _loc4_ = uint(_loc2_.playerItemIDsToAddToSource[_loc3_]);
            this.doInventoryItemClicked(_loc4_);
            _loc3_++;
         }
         this._currentUpgradePanel.endAddToSourceBatch();
         this.upgradeCost = this._currentUpgradePanel.cost;
      }
      
      public function itemRemovedFromBoostSource() : void
      {
         if(this._currentUpgradePanel.isSourceEmpty())
         {
            this.refreshMassSelectionEnabledState();
            return;
         }
         this.btnMassSelection.disableMe();
      }
      
      private function get SUB_TYPES_ARRAY() : Array
      {
         if(BMMechSpecialAbilitiesResolver.enhancersEnabled())
         {
            return [null,[BMMechStructure.TORSO],[BMMechStructure.LEG],[BMMechStructure.SIDE_WEAPON],[BMMechStructure.TOP_WEAPON],[BMMechStructure.DRONE,BMMechStructure.CHARGE,BMMechStructure.SHIELD,BMMechStructure.HARPOON,BMMechStructure.TELEPORT,BMMechStructure.PERK],[BMMechStructure.MODULE],[BMMechStructure.KIT],[BMMechStructure.ENHANCER]];
         }
         return [null,[BMMechStructure.TORSO],[BMMechStructure.LEG],[BMMechStructure.SIDE_WEAPON],[BMMechStructure.TOP_WEAPON],[BMMechStructure.DRONE],[BMMechStructure.CHARGE,BMMechStructure.SHIELD,BMMechStructure.HARPOON,BMMechStructure.TELEPORT,BMMechStructure.PERK],[BMMechStructure.MODULE],[BMMechStructure.KIT]];
      }
      
      private function initItemTypeDropdown() : void
      {
         if(this._itemTypeDropdown == null)
         {
            this._itemTypeDropdown = new BMDropdownList();
         }
         var _loc1_:Array = new Array();
         if(dataM.myPlayerData.items.length < 1000)
         {
            _loc1_.push(new BMDropdownListItemData(0,"subType_inventory_all","general",getGeneralText("allItemsCaps")));
         }
         _loc1_.push(new BMDropdownListItemData(1,"subType_inventory_torso","general",getGeneralText("torsosCaps")));
         _loc1_.push(new BMDropdownListItemData(2,"subType_inventory_leg","general",getGeneralText("legsCaps")));
         _loc1_.push(new BMDropdownListItemData(3,"subType_inventory_sideWeapon","general",getGeneralText("sideWeaponsCaps")));
         _loc1_.push(new BMDropdownListItemData(4,"subType_inventory_topWeapon","general",getGeneralText("topWeaponsCaps")));
         if(BMMechSpecialAbilitiesResolver.enhancersEnabled())
         {
            _loc1_.push(new BMDropdownListItemData(5,"subType_inventory_specialDrone","general",getGeneralText("specialItemsCaps")));
            _loc1_.push(new BMDropdownListItemData(6,"subType_inventory_module","general",getGeneralText("modulesCaps")));
            _loc1_.push(new BMDropdownListItemData(7,"subType_inventory_kit","general",getGeneralText("kitsCaps")));
            _loc1_.push(new BMDropdownListItemData(this.DROPDOWN_LIST_ENHANCE_ID,"subType_inventory_enhancer","general","ENHANCERS"));
         }
         else
         {
            _loc1_.push(new BMDropdownListItemData(5,"subType_inventory_drone","general",getGeneralText("dronesCaps")));
            _loc1_.push(new BMDropdownListItemData(6,"subType_inventory_special","general",getGeneralText("specialItemsCaps")));
            _loc1_.push(new BMDropdownListItemData(7,"subType_inventory_module","general",getGeneralText("modulesCaps")));
            _loc1_.push(new BMDropdownListItemData(8,"subType_inventory_kit","general",getGeneralText("kitsCaps")));
         }
         this._itemTypeDropdown.createItems(_loc1_,this.itemTypeSelected);
         if(tutorialM.isTutorialActive())
         {
            this._itemTypeDropdown.disableMe();
         }
         this.itemTypesPlaceHolder.addChild(this._itemTypeDropdown);
      }
      
      private function getSelectedItemType() : uint
      {
         if(this._itemTypeDropdown.visible == false)
         {
            return 0;
         }
         return this._itemTypeDropdown.getSelectedItemID();
      }
      
      private function itemTypeSelected(param1:uint = 0) : void
      {
         this.onInventoryChanged();
      }
      
      private function initButtons() : void
      {
         screensM.createButtonFromSizer(BMScreensManager.SCR_HANGER_UPGRADE,"btnGetGold","plus2");
         screensM.createButtonFromSizer(BMScreensManager.SCR_HANGER_UPGRADE,"btnBack","pictureE");
         this.btnGetGold.initialize("","",null,[],this.onGetGoldClick,false);
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
         this.btnUpgrade.addEventListener(BMIntractable.HIT,this.onUpgradeHit);
         this.btnUpgrade.close();
         if(tutorialM.isTutorialActive())
         {
            this.btnGetGold.disableMe();
         }
      }
      
      private function get introPanel() : MovieClip
      {
         return this.upgradePanels.upgradeIntroPanel;
      }
      
      private function get transformPanel() : BMUpgradeTransformPanel
      {
         return this.upgradePanels.upgradeTransformPanel;
      }
      
      private function get boostPanel() : BMUpgradeBoostPanel
      {
         return this.upgradePanels.upgradeBoostPanel;
      }
      
      private function get enhancePanel() : BMUpgradeEnhancePanel
      {
         return this.upgradePanels.upgradeEnhancePanel;
      }
      
      private function initUpgradePanels() : void
      {
         this.boostPanel.addEventListener(BMUpgradeBasePanel.ON_SOURCE_REMOVED,this.onSourceRemoved);
         this.boostPanel.addEventListener(BMUpgradeBasePanel.ON_ALL_SOURCE_ITEMS_REMOVED,this.onAllSourceItemsRemoved);
         this.boostPanel.addEventListener(BMUpgradeBasePanel.ON_TAGET_REMOVED,this.onTargetRemoved);
         this.boostPanel.addEventListener(BMUpgradeBasePanel.ON_ASCEND_CLICKED,this.onAscendButtonClicked);
         if(BMMechSpecialAbilitiesResolver.enhancersEnabled())
         {
            this.boostPanel.addEventListener(BMUpgradeBasePanel.ON_ENHANCE_CLICKED,this.onEnhanceButtonClicked);
         }
         else
         {
            this.boostPanel.visible = false;
         }
         this.transformPanel.addEventListener(BMUpgradeBasePanel.ON_SOURCE_REMOVED,this.onSourceRemoved);
         this.transformPanel.addEventListener(BMUpgradeBasePanel.ON_TAGET_REMOVED,this.onTargetRemoved);
         this.enhancePanel.addEventListener(BMUpgradeBasePanel.ON_SOURCE_REMOVED,this.onSourceRemoved);
         this.enhancePanel.addEventListener(BMUpgradeBasePanel.ON_TAGET_REMOVED,this.onTargetRemoved);
      }
      
      private function onTargetRemoved(param1:Event) : void
      {
         if(this._currentUpgradePanel == this.enhancePanel)
         {
            this.closeEnhancePanel();
         }
         else
         {
            this.resetUpgradeState();
         }
      }
      
      private function onSourceRemoved(param1:DataEvent) : void
      {
         var _loc2_:Number = Number(param1.data);
         this._inventoryTileList.removeMarkers([_loc2_],"tileListItemID");
         this.upgradeCost = this._currentUpgradePanel.cost;
         if(this._currentUpgradePanel.allowClickOnUpgrade() == false)
         {
            this.btnUpgrade.disableMe();
         }
      }
      
      private function onAllSourceItemsRemoved(param1:DataEvent) : void
      {
         this._inventoryTileList.removeAllMarkers();
         this.upgradeCost = this._currentUpgradePanel.cost;
         if(this._currentUpgradePanel.allowClickOnUpgrade() == false)
         {
            this.btnUpgrade.disableMe();
         }
      }
      
      public function initTileLists() : void
      {
         this._inventoryTileList = new BMTileList();
         var _loc1_:Boolean = false;
         var _loc2_:MovieClip = new Grp_scrollerContent();
         if(dataM.runAsMobile)
         {
            _loc1_ = true;
            this._inventoryTileList.activateExtendedMode(0.6,true);
         }
         var _loc3_:uint = this.INVENTORY_ITEM_SIZE;
         var _loc4_:uint = this.INVENTORY_ROWS;
         if(dataM.runAsMobile)
         {
            _loc3_ = this.INVENTORY_ITEM_SIZE_MOBILE;
            _loc4_ = this.INVENTORY_ROWS_MOBILE;
         }
         var _loc5_:Number = 0.71;
         this._inventoryTileList.initialize(screensM.stagePointer,[],_loc4_,4,_loc3_,_loc3_,null,true,_loc2_,null,null,false,0,_loc5_,true,_loc1_,false,"",true);
         this._inventoryTileList.loadAssetsFunction = externalAssetsM.getAsset;
         this._inventoryTileList.x = this.mcInventoryTileListPosition.x;
         this._inventoryTileList.y = this.mcInventoryTileListPosition.y;
         this.mcTileListHolder.addChild(this._inventoryTileList);
      }
      
      private function setInventoryList(param1:Array) : void
      {
         if(param1.length > 500)
         {
            screensM.screenConfirmation.displayCustomLoading(getGeneralText("pleaseWait"));
            TweenMax.delayedCall(0.1,this.setInventoryListSub,[param1]);
         }
         else
         {
            this.setInventoryListSub(param1);
         }
      }
      
      private function setInventoryListSub(param1:Array) : void
      {
         var _loc9_:Function = null;
         var _loc10_:BMTileListItem = null;
         var _loc11_:uint = 0;
         var _loc12_:BMItemData = null;
         var _loc13_:* = undefined;
         var _loc14_:Object = null;
         var _loc15_:BMTileListItem = null;
         var _loc16_:uint = 0;
         var _loc17_:BMTileListItem = null;
         var _loc18_:TextFormat = null;
         var _loc19_:TextField = null;
         this._inventoryTileList.removeAllItems();
         var _loc2_:Array = new Array();
         var _loc3_:uint = 0;
         var _loc4_:uint = this.getTileItemSize();
         var _loc5_:Array = new Array();
         var _loc6_:Boolean = true;
         var _loc7_:uint = 0;
         for(; _loc3_ < param1.length; _loc3_++)
         {
            _loc9_ = this.onInventoryItemClicked;
            if(dataM.runAsMobile)
            {
               _loc9_ = null;
            }
            if(_loc6_)
            {
               _loc11_ = uint(param1[_loc3_]);
               _loc12_ = dataM.itemsDB[dataM.getPlayerItemData(dataM.player1PlayerID,_loc11_).itemID];
               if(_loc12_.isAscensionKit)
               {
                  _loc7_ += 1;
                  if(_loc5_[_loc12_.specialStatus] == null)
                  {
                     _loc13_ = new Object();
                     _loc13_.count = 1;
                     _loc13_.playerItemID = _loc11_;
                     _loc5_[_loc12_.specialStatus] = _loc13_;
                  }
                  else
                  {
                     _loc5_[_loc12_.specialStatus].count += 1;
                  }
                  continue;
               }
            }
            _loc10_ = dataM.createInventoryTileListItem2(param1[_loc3_],_loc9_,_loc4_,this.onInventoryItemDown,null,true,false,true);
            _loc2_.push(_loc10_);
         }
         var _loc8_:uint = 0;
         while(_loc8_ < _loc5_.length)
         {
            _loc14_ = _loc5_[_loc8_];
            if(_loc14_ != null)
            {
               _loc15_ = dataM.createInventoryTileListItem2(_loc14_.playerItemID,_loc9_,_loc4_,this.onInventoryItemDown,null,true,false,true,_loc14_.count);
               _loc2_.push(_loc15_);
            }
            _loc8_++;
         }
         this._numOfItemsInTileList = param1.length - _loc7_;
         _loc2_ = _loc2_.concat(this.createUnoccupiedTiles(this._numOfItemsInTileList));
         if(FeatureFlags.SHOW_INVENTORY_ITEM_NUMBERS)
         {
            _loc16_ = 0;
            for each(_loc17_ in _loc2_)
            {
               _loc16_ += 1;
               _loc18_ = new TextFormat("American Captain Eternal",23,16777215);
               _loc19_ = new TextField();
               _loc19_.setTextFormat(_loc18_);
               _loc19_.defaultTextFormat = _loc18_;
               _loc19_.text = String(_loc16_);
               _loc19_.autoSize = TextFieldAutoSize.LEFT;
               _loc17_.addChild(_loc19_);
            }
         }
         _loc2_.push(dataM.createInventorySizeTile(_loc4_));
         this._inventoryTileList.addItems(this._inventoryTileList.highestTileID + 1,_loc2_,true);
         this.refreshInvntoryEmptyTiles();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this._inventoryTileList);
         }
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
      }
      
      private function getTileItemSize() : Number
      {
         if(dataM.runAsMobile)
         {
            return this.INVENTORY_ITEM_SIZE_MOBILE;
         }
         return this.INVENTORY_ITEM_SIZE;
      }
      
      private function createUnoccupiedTiles(param1:*) : Array
      {
         var _loc2_:uint = this.getTileItemSize();
         var _loc3_:Array = new Array();
         var _loc4_:int = param1;
         while(_loc4_ < dataM.myProfile.inventorySizeState.maxSize)
         {
            _loc3_.push(dataM.createUnoccupiedTile(_loc2_));
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function refreshInvntoryEmptyTiles() : *
      {
         var _loc1_:uint = this.INVENTORY_ITEM_SIZE;
         if(dataM.runAsMobile)
         {
            _loc1_ = this.INVENTORY_ITEM_SIZE_MOBILE;
         }
         this._inventoryTileList.fillEmptyGridCells(new FunctionCall(dataM.createEmptyInvntoryTileList2,[_loc1_]));
      }
      
      private function isItemIDLegacyItem(param1:Number, param2:int, param3:Array) : *
      {
         return dataM.myPlayerData.getItemBy(param1).isDeprecated;
      }
      
      private function extractLegacyItemsFromItemIDs(param1:Array) : Array
      {
         return param1.filter(this.isItemIDLegacyItem);
      }
      
      public function onInventoryChanged() : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:BMItemData = null;
         if(this._lastDropdownListItemID > -1 && this._currentUpgradePanel != this.enhancePanel)
         {
            this._itemTypeDropdown.manuallySetItem(this._lastDropdownListItemID,false);
            this._lastDropdownListItemID = -1;
         }
         var _loc1_:Array = this.SUB_TYPES_ARRAY[this.getSelectedItemType()];
         this._itemTypeDropdown.enableMe();
         if(this._currentUpgradePanel == this.boostPanel)
         {
            _loc5_ = dataM.myPlayerData.getItemBy(this._targetPlayerItemID);
            if(_loc5_.isMaxEvolved || _loc5_.isMaxedMythical)
            {
               _loc2_ = this._upgradeManager.getPlayerItemIdsColoringKits(_loc1_);
            }
            else
            {
               _loc2_ = this._upgradeManager.getPlayerItemIdsForBoost(this._targetPlayerItemID,_loc1_);
            }
            _loc3_ = [this._targetPlayerItemID];
            _loc4_ = this._currentUpgradePanel.getSourcePlayerItemIDs();
         }
         else if(this._currentUpgradePanel == this.transformPanel)
         {
            _loc2_ = this._upgradeManager.getPlayerItemIdsForTransform(this._targetPlayerItemID,_loc1_);
            _loc3_ = this.extractLegacyItemsFromItemIDs(_loc2_);
            _loc3_.push(this._targetPlayerItemID);
            _loc4_ = this._currentUpgradePanel.getSourcePlayerItemIDs();
         }
         else if(this._currentUpgradePanel == this.enhancePanel)
         {
            _loc2_ = this._upgradeManager.getPlayerItemIdsForEnhance(this._targetPlayerItemID);
            this._lastDropdownListItemID = this._itemTypeDropdown.getSelectedItemID();
            this._itemTypeDropdown.disableMe();
            this._itemTypeDropdown.manuallySetItem(this.DROPDOWN_LIST_ENHANCE_ID,false);
         }
         else
         {
            _loc2_ = this._upgradeManager.getPlayerItemIdsForTarget(_loc1_);
            _loc3_ = this.extractLegacyItemsFromItemIDs(_loc2_);
            _loc4_ = [];
         }
         this.setInventoryList(_loc2_);
         this.setInventoryMarkers(_loc3_,_loc4_);
         tutorialM.refreshUpgradeTutorial();
      }
      
      public function onInventorySlotsBought() : *
      {
         this.onInventoryChanged();
         this._inventoryTileList.scrollToID(this._inventoryTileList.items.length - 1,"bottom","tileID");
      }
      
      private function onInventoryMouseUp() : void
      {
         this.hideItemHint();
      }
      
      private function onInventoryItemDown(param1:Number, param2:Number) : void
      {
         if(isNaN(param2))
         {
            trace("NAN!!!!");
            return;
         }
         this._mouseDownPlayerItemID = param2;
         this._mouseDownTime = getTimer();
         tooltip.hideToolTip();
      }
      
      public function onInventoryItemClicked(param1:Number, param2:Number) : void
      {
         if(isNaN(param2))
         {
            return;
         }
         if(tutorialM.upgrade_isInventoryEnabled() == false)
         {
            return;
         }
         if(param2 == -1)
         {
            dataM.onInventorySizeTileClick(param1,param2);
            return;
         }
         tooltip.hideToolTip();
         if(this.isHintVisible)
         {
            this.hideItemHint();
         }
         else
         {
            this.doInventoryItemClicked(param2);
         }
         this._mouseDownPlayerItemID = -1;
      }
      
      private function doInventoryItemClicked(param1:Number, param2:Boolean = false) : void
      {
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         var _loc3_:BMPlayerItemData = dataM.myPlayerData.getPlayerItemBy(param1);
         var _loc4_:BMItemData = dataM.itemsDB[_loc3_.itemID];
         if(param2 == false && this._currentUpgradePanel == this.transformPanel)
         {
            _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
            _loc6_ = dataM.itemsDB[_loc5_.itemID];
            if(_loc6_.canAscend())
            {
               return;
            }
         }
         if(this._currentUpgradePanel != this.transformPanel)
         {
            if(_loc4_.isTransformKit)
            {
               screensM.screenConfirmation.displayCustomMessage(getScreenText("cannotUseTransformKitAsBoostSource"));
               return;
            }
            if(_loc4_.isAscensionKit)
            {
               screensM.screenConfirmation.displayCustomMessage(getScreenText("cannotUseAscensionKitAsBoostSource"));
               return;
            }
         }
         if(this._targetPlayerItemID == -1)
         {
            if(tutorialM.upgrade_canSelectTargetItem(_loc4_.itemID))
            {
               this.selectTargetItem(param1);
            }
            return;
         }
         if(tutorialM.upgrade_canSelectSourceItem(_loc4_.itemID,this._currentUpgradePanel.getNumOfSource()) == false)
         {
            return;
         }
         if(this._targetPlayerItemID == param1)
         {
            this.resetUpgradeState();
            return;
         }
         if(_loc3_.equipped > 0)
         {
            return;
         }
         if(this._currentUpgradePanel.isItemInSource(param1))
         {
            if(tutorialM.isTutorialActive() == false)
            {
               this._currentUpgradePanel.removeFromSource(param1);
               this.refreshItemDropdownAndMassSelectionInterface();
               if(this._currentUpgradePanel.allowClickOnUpgrade() == false)
               {
                  this.btnUpgrade.disableMe();
               }
            }
            return;
         }
         if(this._currentUpgradePanel.isSourceFull() && !_loc4_.isColorKit)
         {
            return;
         }
         if(!this._currentUpgradePanel.canItemBeAddedAsSource(param1))
         {
            if(this._currentUpgradePanel == this.enhancePanel)
            {
               this.enhancePanel.tryToRemoveSourceItemByPlayerItemID(param1);
            }
            return;
         }
         this.addInventoryMarkers([param1]);
         this._currentUpgradePanel.addToSource(param1);
         if(!this._currentUpgradePanel.isInAddToSourceBatch)
         {
            this._addedIndividualItemsToSourceItemList = true;
         }
         this.refreshMassSelectionEnabledState();
         if(this._currentUpgradePanel.allowClickOnUpgrade() == false)
         {
            this.btnUpgrade.disableMe();
         }
         else
         {
            this.btnUpgrade.enableMe();
         }
         this.upgradeCost = this._currentUpgradePanel.cost;
         tutorialM.refreshUpgradeTutorial();
      }
      
      public function setInventoryMarkers(param1:Array, param2:Array) : void
      {
         this._inventoryTileList.removeAllMarkers();
         this.addInventoryMarkers(param1,2);
         this.addInventoryMarkers(param2,1);
      }
      
      private function addInventoryMarkers(param1:Array, param2:int = 1) : *
      {
         var _loc4_:MovieClip = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = new tileListItemCover();
            _loc4_.gotoAndStop(param2);
            _loc4_.mouseChildren = false;
            _loc4_.mouseEnabled = false;
            this._inventoryTileList.addMarker(param1[_loc3_],_loc4_,"tileListItemID");
            _loc3_++;
         }
      }
      
      private function selectTargetItem(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:BMItemData = dataM.myPlayerData.getItemBy(param1);
         if(_loc4_.isColorKit)
         {
            return;
         }
         if(_loc4_.isDeprecated)
         {
            screensM.screenConfirmation.displayCustomMessage(getSpecificText("migration_legacyItemCanNotBeUpgraded"));
            return;
         }
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(param3)
         {
            this._currentUpgradePanel = this.upgradePanels.upgradeEnhancePanel;
            this.btnUpgrade.text = "Apply";
            this.movePanels(2);
         }
         else if(_loc4_.canEvolve())
         {
            this._currentUpgradePanel = this.upgradePanels.upgradeTransformPanel;
            this.btnUpgrade.text = getScreenText("transform");
            this.movePanels(-1);
         }
         else if(param2 && _loc4_.canAscend())
         {
            this._currentUpgradePanel = this.upgradePanels.upgradeTransformPanel;
            this.btnUpgrade.text = getScreenText("transform");
            this.movePanels(-1);
            _loc6_ = true;
         }
         else
         {
            this._currentUpgradePanel = this.upgradePanels.upgradeBoostPanel;
            this.btnUpgrade.text = getScreenText("boost");
            this.movePanels(1);
            _loc5_ = dataM.recommendBoostMaterials() && !this.isInMassSelectionMode;
         }
         this.refreshItemDropdownAndMassSelectionInterface();
         this._targetPlayerItemID = param1;
         this.onInventoryChanged();
         this._currentUpgradePanel.visible = true;
         this._currentUpgradePanel.setTarget(param1);
         this.btnUpgrade.open();
         this.upgradeCost = this._currentUpgradePanel.cost;
         if(this._currentUpgradePanel.allowClickOnUpgrade() == false)
         {
            this.btnUpgrade.disableMe();
         }
         if(_loc5_)
         {
            this.selectRecommendedBoostMaterials();
         }
         if(_loc6_)
         {
            this.autoSelectAscensionMaterials();
         }
      }
      
      private function autoSelectAscensionMaterials() : void
      {
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.itemID];
         var _loc3_:uint = 0;
         for each(_loc4_ in dataM.myPlayerData.items)
         {
            _loc5_ = dataM.itemsDB[_loc4_.itemID];
            if(_loc5_.isAscensionKit != false)
            {
               if(_loc5_.specialStatus != _loc2_.naturalTier)
               {
                  if(!(_loc2_.naturalTier == ItemRarityResolver.RARITY_MYTHICAL && _loc5_.specialStatus == ItemRarityResolver.RARITY_LEGENDARY))
                  {
                     continue;
                  }
               }
               this.doInventoryItemClicked(_loc4_.playerItemID,true);
               _loc3_ += 1;
               if(_loc3_ == 5)
               {
                  return;
               }
            }
         }
      }
      
      private function onAscendButtonClicked(param1:Event) : void
      {
         this.selectTargetItem(this._targetPlayerItemID,true);
      }
      
      private function onEnhanceButtonClicked(param1:Event) : void
      {
         this.selectTargetItem(this._targetPlayerItemID,false,true);
      }
      
      private function closeEnhancePanel() : void
      {
         this.selectTargetItem(this._targetPlayerItemID);
      }
      
      private function resetUpgradeState() : void
      {
         this._targetPlayerItemID = -1;
         if(this._currentUpgradePanel != null)
         {
            this._currentUpgradePanel.reset();
            this._currentUpgradePanel = null;
         }
         this.hideMassSelectionWindow();
         this.refreshItemDropdownAndMassSelectionInterface();
         this.movePanels(0);
         this.btnUpgrade.close();
         this.onInventoryChanged();
         this.upgradeCost = 0;
         this._addedIndividualItemsToSourceItemList = false;
      }
      
      private function selectRecommendedBoostMaterials() : void
      {
         var _loc1_:Array = dataM.getRecommendedBoostMaterialPlayerItemIDs();
         if(_loc1_.length == 0)
         {
            return;
         }
         if(this._currentUpgradePanel.isTargetMaxLevel())
         {
            return;
         }
         var _loc2_:BMPotentialBoostInfo = this._upgradeManager.getPotentialBoostInfo(this._targetPlayerItemID,_loc1_);
         this._currentUpgradePanel.beginAddToSourceBatch();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.playerItemIDsToAddToSource.length)
         {
            this.doInventoryItemClicked(_loc2_.playerItemIDsToAddToSource[_loc3_]);
            _loc3_++;
         }
         this._currentUpgradePanel.endAddToSourceBatch();
         this.upgradeCost = this._currentUpgradePanel.cost;
      }
      
      private function movePanels(param1:int) : void
      {
         this.introPanel.visible = true;
         this.transformPanel.visible = true;
         this.boostPanel.visible = true;
         this.enhancePanel.visible = true;
         TweenMax.to(this.upgradePanels,0.4,{
            "x":this.panelsStartX + param1 * 480,
            "onComplete":this.onMovePanelsComplete
         });
      }
      
      private function onMovePanelsComplete() : *
      {
         this.introPanel.visible = false;
         this.transformPanel.visible = false;
         this.boostPanel.visible = false;
         this.enhancePanel.visible = false;
         if(this._currentUpgradePanel == null)
         {
            this.introPanel.visible = true;
         }
         else
         {
            this._currentUpgradePanel.visible = true;
         }
      }
      
      private function showItemHint(param1:Number = -1) : void
      {
         if(param1 == -1)
         {
            return;
         }
         var _loc2_:BMPlayerItemData = dataM.myPlayerData.getPlayerItemBy(param1);
         var _loc3_:Sprite = MovieClip(this.itemInfo).itemSizer;
         var _loc4_:BMTileListItem = dataM.createInventoryTileListItem2(param1,null,_loc3_.width);
         _loc4_.mouseEnabled = false;
         _loc4_.mouseChildren = false;
         _loc4_.x = _loc3_.x;
         _loc4_.y = _loc3_.y;
         this.itemInfo.addChild(_loc4_);
         this.itemInfo.showItemInfo(_loc2_);
         this.itemInfo.visible = true;
         this.upgradePanels.visible = false;
      }
      
      private function hideItemHint() : void
      {
         if(this.itemInfo.visible)
         {
            this._itemInfoVisibleLastFrame = true;
            this.itemInfo.visible = false;
         }
         this.upgradePanels.visible = true;
      }
      
      private function get isHintVisible() : Boolean
      {
         return this.itemInfo.visible == true || this._itemInfoVisibleLastFrame;
      }
      
      private function onItemInfoAddHit(param1:Event) : void
      {
         this.doInventoryItemClicked(this.itemInfo.playerItemID);
      }
      
      private function get isItemHintActive() : Boolean
      {
         return !tutorialM.isTutorialActive();
      }
      
      private function set gold(param1:int) : void
      {
         updateTextAndFormat(this.txtGold,TextUtils.getNumberWithComma(param1));
         ImageUtils.swapTextFieldWithBitMap(this.txtGold,this);
      }
      
      public function refreshGold() : *
      {
         this.gold = dataM.myProfile.gold;
      }
      
      private function set upgradeCost(param1:int) : void
      {
         this.btnUpgrade.cost = param1;
      }
      
      public function get inventoryTileList() : BMTileList
      {
         return this._inventoryTileList;
      }
      
      public function get currentUpgradePanel() : BMUpgradeBasePanel
      {
         return this._currentUpgradePanel;
      }
      
      private function initializeTutorialArrow_back() : void
      {
         if(this._tutorialArrowController_back == null)
         {
            this._tutorialArrowController_back = new BMTutorialArrowController(this.mcTutorialArrow_back);
         }
      }
      
      public function activateBackTutorialArrow_back() : void
      {
         this.initializeTutorialArrow_back();
         var _loc1_:Number = this.mcSizer_btnBack.x + this.mcSizer_btnBack.width;
         var _loc2_:Number = this.mcSizer_btnBack.y + this.mcSizer_btnBack.height / 2;
         this._tutorialArrowController_back.activateTutorialArrowWithTimer(this,_loc1_,_loc2_);
      }
      
      private function initializeTutorialArrow_boost() : void
      {
         if(this._tutorialArrowController_boost == null)
         {
            this._tutorialArrowController_boost = new BMTutorialArrowController(this.mcTutorialArrow_boost);
         }
      }
      
      public function activateBackTutorialArrow_boost() : void
      {
         this.initializeTutorialArrow_boost();
         var _loc1_:Number = this.btnUpgrade.x + this.btnUpgrade.shutterTop.x;
         var _loc2_:Number = this.btnUpgrade.y;
         this._tutorialArrowController_boost.activateTutorialArrowWithTimer(this,_loc1_,_loc2_,270);
      }
      
      public function deactivateTutorialArrow_boost() : void
      {
         if(this._tutorialArrowController_boost != null)
         {
            this._tutorialArrowController_boost.deactivateTutorialArrow();
         }
      }
      
      private function onGetGoldClick() : void
      {
         BMShopManager.gi().showGoldPackages();
         this._waitingForCreditsShopClose = true;
      }
      
      private function onUpgradeHit(param1:Event) : void
      {
         if(!FeatureFlags.BLOCK_TRANSFORM)
         {
            if(this._currentUpgradePanel.cost > dataM.myProfile.gold)
            {
               screensM.screenConfirmation.displayCustomMessage(getGeneralText("notEnoughGold"));
               return;
            }
         }
         tutorialM.hangerUpgradeClicked();
         if(this.destroyingItemFromAnotherMechBuildWarning())
         {
            screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP);
            screensM.screenYesNoPopup.displayYesNoPopup(getScreenText("destroyEpicOrHigherTitle"),getSpecificText("mechBuilds_destroyingItemFromAnotherBuildDesc"),"",this.doUpgrade);
            return;
         }
         if(this.destroyingEpicOrHigherWarning())
         {
            screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP);
            screensM.screenYesNoPopup.displayYesNoPopup(getScreenText("destroyEpicOrHigherTitle"),getScreenText("destroyEpicOrHigherDesc"),"",this.doUpgrade);
            return;
         }
         if(this.replacingColorWarning())
         {
            screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP);
            screensM.screenYesNoPopup.displayYesNoPopup(getScreenText("replacingColorTitle"),getScreenText("replacingColorDesc"),"",this.doUpgrade,null,"","",BMScreenYesNoPopup.SIGN_EXCLAMATION);
            return;
         }
         this.doUpgrade();
      }
      
      private function doUpgrade() : void
      {
         soundM.createSound("kitUsed",0.7);
         this.hideMassSelectionWindow();
         this._currentUpgradePanel.doUpgrade();
         var _loc1_:Boolean = this._currentUpgradePanel == this.upgradePanels.upgradeBoostPanel;
         this._upgradeManager.doUpgarde(this._targetPlayerItemID,this._currentUpgradePanel.getSourcePlayerItemIDs(),_loc1_,this._currentUpgradePanel.cost);
      }
      
      private function destroyingEpicOrHigherWarning() : Boolean
      {
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         if(this._currentUpgradePanel != this.boostPanel)
         {
            return false;
         }
         var _loc1_:Array = this._currentUpgradePanel.getSourcePlayerItemIDs();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc1_[_loc2_]);
            if(_loc3_ != null)
            {
               _loc4_ = dataM.itemsDB[_loc3_.itemID];
               if(_loc4_ != null)
               {
                  if(!(_loc4_.subType == "color" || _loc4_.subType == "power"))
                  {
                     if(_loc4_.specialStatus >= 2 && !_loc4_.isDeprecated)
                     {
                        return true;
                     }
                  }
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      private function destroyingItemFromAnotherMechBuildWarning() : Boolean
      {
         var _loc3_:uint = 0;
         if(dataM.mechBuildsM.isEnabled == false)
         {
            return false;
         }
         if(this._currentUpgradePanel != this.boostPanel)
         {
            return false;
         }
         var _loc1_:Array = this._currentUpgradePanel.getSourcePlayerItemIDs();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = uint(_loc1_[_loc2_]);
            if(dataM.mechBuildsM.isItemInAnyBuild(_loc3_))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function replacingColorWarning() : Boolean
      {
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         if(this._currentUpgradePanel != this.boostPanel)
         {
            return false;
         }
         if(this._currentUpgradePanel.targetItemPlayerItemID == 0)
         {
            return false;
         }
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,this._currentUpgradePanel.targetItemPlayerItemID);
         if(_loc1_.colorID == 0)
         {
            return false;
         }
         var _loc2_:Array = this._currentUpgradePanel.getSourcePlayerItemIDs();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc2_[_loc3_]);
            if(_loc4_ != null)
            {
               _loc5_ = dataM.itemsDB[_loc4_.itemID];
               if(_loc5_ != null)
               {
                  if(_loc5_.subType == "color")
                  {
                     return true;
                  }
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public function onUpgradeSuccess() : void
      {
         this._currentUpgradePanel.onUpgradeSuccess();
      }
      
      public function onUpgradeComplete(param1:Boolean = true) : *
      {
         this.btnUpgrade.disableMe();
         this.refreshGold();
         this.upgradeCost = 0;
         var _loc2_:int = this._currentUpgradePanel.getNumOfSource();
         this._inventoryTileList.removeItems(this._currentUpgradePanel.getSourcePlayerItemIDs(),"tileListItemID");
         this._numOfItemsInTileList -= _loc2_;
         this._inventoryTileList.addItems(this._numOfItemsInTileList,this.createUnoccupiedTiles(this._numOfItemsInTileList),true);
         this.refreshInvntoryEmptyTiles();
         this._currentUpgradePanel.reset();
         var _loc3_:BMItemData = dataM.myPlayerData.getItemBy(this._targetPlayerItemID);
         if(_loc3_.upgradeToItemID == -1)
         {
            this.resetUpgradeState();
         }
         else
         {
            this.selectTargetItem(this._targetPlayerItemID);
         }
         if(param1)
         {
            if(!dataM.isInventoryFull(true) && dataM.myPlayerData.items.length + _loc2_ >= dataM.myProfile.inventorySizeState.maxSize && BMShopManager.gi().getFreePackagesAmount() > 0)
            {
               screensM.addScreen(BMScreensManager.SCR_UNCLAIMED_BOXES);
            }
         }
         this._addedIndividualItemsToSourceItemList = false;
         this.refreshItemDropdownAndMassSelectionInterface();
      }
      
      public function backClicked(param1:Boolean = false) : void
      {
         if(dataM.mechBuildsM.isEnabled)
         {
            dataM.mechBuildsM.cleanAllBuildsFromDeletedItems();
         }
         this.hideMassSelectionWindow();
         if(this._itemTypeDropdown != null)
         {
            this._itemTypeDropdown.removemMe();
         }
         if(dataM.mechBoostRecommender.activeRecommendationPlayerItemID != BMMechBoostRecommender.NO_RECOMMENDATION)
         {
            switch(dataM.mechBoostRecommender.recommendationOrigin)
            {
               case BMMechBoostRecommender.ORIGIN_CAMPAIGN:
                  screensM.screenTransitionsManager.singlePlayerClicked();
                  break;
               case BMMechBoostRecommender.ORIGIN_PVP:
                  screensM.screenTransitionsManager.multiplayerLadderClicked();
                  break;
               default:
                  throw new Error("ERROR! screenHangerUpgrade >> no origin found for boost recommendation");
            }
         }
         else if(BMUpgradeManager.gi().selectedPlayerItemID == -1 || param1)
         {
            screensM.screenTransitionsManager.mainMenu();
         }
         else
         {
            screensM.screenTransitionsManager.hangerMechClicked();
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this.isItemHintActive && this._mouseDownPlayerItemID != -1 && getTimer() - this._mouseDownTime >= this.MILLISECONDS_FOR_HINT)
         {
            this.showItemHint(this._mouseDownPlayerItemID);
            this._mouseDownPlayerItemID = -1;
         }
         if(dataM.runAsMobile)
         {
            if(this._fingerWheeling != null)
            {
               this._fingerWheeling.onEnterFrameTrigger();
            }
         }
         this._itemInfoVisibleLastFrame = false;
         if(this._waitingForCreditsShopClose)
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP) == false)
            {
               this._waitingForCreditsShopClose = false;
               this.refreshGold();
            }
         }
      }
      
      private function removedFromStage(param1:Event) : void
      {
         dataM.mechBoostRecommender.removeActiveRecommendation();
         if(this._fingerWheeling != null)
         {
            this._fingerWheeling.removeMouseListeners();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE_MASS_SELECTION))
         {
            screensM.removeScreen(BMScreensManager.SCR_HANGER_UPGRADE_MASS_SELECTION);
         }
      }
   }
}

