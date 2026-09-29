package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import net.battleMechsMulti.managers.upgrade.BMUpgradeManager;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMButton_plus2;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.dropdownList.BMDropdownList;
   import net.battleMechsMulti.mobiles.dropdownList.BMDropdownListItemData;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemInfoPanel;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.tacticsoft.utils.FunctionCall;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1289")]
   public class BMScreenHangerUpgrade extends BMBaseScreen
   {
      
      private static const SUB_TYPES_ARRAY:Array = [null,["torso"],["leg"],["sideWeapon"],["topWeapon"],["drone"],["charge","shield","harpoon","teleport","perk"],["module"],["kit"]];
      
      private const MILLISECONDS_FOR_HINT:uint = 300;
      
      private const INVENTORY_ITEM_SIZE:uint = 67;
      
      private const INVENTORY_ITEM_SIZE_MOBILE:uint = 74;
      
      private const INVENTORY_ROWS:uint = 5;
      
      private const INVENTORY_ROWS_MOBILE:uint = 4;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnGetGold:Sprite;
      
      public var mcFingerWheelingHitArea:Sprite;
      
      public var mcTileListHolder:Sprite;
      
      public var inventoryPlaceHolder:Sprite;
      
      public var inventoryPlaceHolder_mobile:Sprite;
      
      public var itemTypesPlaceHolder:Sprite;
      
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
      
      private var _itemTypeDropdown:BMDropdownList;
      
      private var _inventoryTileList:BMTileList;
      
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
         this.hideItemHint();
         this.initMobileFingerWheeling();
         this.initTileLists();
         this.initItemTypeDropdown();
         this.initButtons();
         this.initUpgradePanels();
         this.refreshGold();
         this.resetUpgradeState();
         this.movePanels(0);
         if(!FeatureFlags.NEW_ECONOMY)
         {
            this.upgradePanels.upgradeIntroPanel.txtTitle.text = "Select an item you want \nto Boost ";
            this.itemTypeSelected();
         }
         if(BMUpgradeManager.gi().selectedPlayerItemID != -1)
         {
            this.selectTargetItem(BMUpgradeManager.gi().selectedPlayerItemID);
         }
         this.initializeTutorialArrow_back();
         this.initializeTutorialArrow_boost();
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
      
      private function initItemTypeDropdown() : void
      {
         if(this._itemTypeDropdown == null)
         {
            this._itemTypeDropdown = new BMDropdownList();
         }
         var _loc1_:Array = new Array();
         if(dataM.myPlayerData.items.length < 1000)
         {
            _loc1_.push(new BMDropdownListItemData(0,"subType_inventory_all","general","ALL ITEMS"));
         }
         _loc1_.push(new BMDropdownListItemData(1,"subType_inventory_torso","general","TORSOS"));
         _loc1_.push(new BMDropdownListItemData(2,"subType_inventory_leg","general","LEGS"));
         _loc1_.push(new BMDropdownListItemData(3,"subType_inventory_sideWeapon","general","SIDE WEAPONS"));
         _loc1_.push(new BMDropdownListItemData(4,"subType_inventory_topWeapon","general","TOP WEAPONS"));
         _loc1_.push(new BMDropdownListItemData(5,"subType_inventory_drone","general","DRONES"));
         _loc1_.push(new BMDropdownListItemData(6,"subType_inventory_special","general","SPECIAL ITEMS"));
         _loc1_.push(new BMDropdownListItemData(7,"subType_inventory_module","general","MODULES"));
         _loc1_.push(new BMDropdownListItemData(8,"subType_inventory_kit","general","KITS"));
         this._itemTypeDropdown.createItems(_loc1_,this.itemTypeSelected);
         if(tutorialM.isTutorialActive())
         {
            this._itemTypeDropdown.disableMe();
         }
         this.itemTypesPlaceHolder.addChild(this._itemTypeDropdown);
      }
      
      private function itemTypeSelected(param1:uint = 0) : void
      {
         var _loc2_:Array = null;
         if(!FeatureFlags.NEW_ECONOMY)
         {
            _loc2_ = SUB_TYPES_ARRAY[this._itemTypeDropdown.getSelectedItemID()];
            this.setInventoryList(this._upgradeManager.getPlayerItemIds(_loc2_));
         }
         this.onInventoryChanged();
      }
      
      private function initButtons() : void
      {
         screensM.createButtonFromSizer("screenHangerUpgrade","btnGetGold","plus2");
         screensM.createButtonFromSizer("screenHangerUpgrade","btnBack","pictureE");
         this.btnGetGold.initialize("","",null,[],this.onGetGoldClick,false);
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
         this.btnUpgrade.addEventListener(BMIntractable.HIT,this.onUpgradeHit);
         this.btnUpgrade.close();
         if(tutorialM.isTutorialActive())
         {
            this.btnGetGold.disableMe();
         }
      }
      
      private function initUpgradePanels() : void
      {
         this.upgradePanels.upgradeBoostPanel.addEventListener(BMUpgradeBasePanel.ON_SOURCE_REMOVED,this.onSourceRemoved);
         this.upgradePanels.upgradeBoostPanel.addEventListener(BMUpgradeBasePanel.ON_TAGET_REMOVED,this.onTargetRemoved);
         this.upgradePanels.upgradeTransformPanel.addEventListener(BMUpgradeBasePanel.ON_SOURCE_REMOVED,this.onSourceRemoved);
         this.upgradePanels.upgradeTransformPanel.addEventListener(BMUpgradeBasePanel.ON_TAGET_REMOVED,this.onTargetRemoved);
      }
      
      private function onTargetRemoved(param1:Event) : void
      {
         this.resetUpgradeState();
      }
      
      private function onSourceRemoved(param1:DataEvent) : void
      {
         var _loc2_:Number = Number(param1.data);
         this._inventoryTileList.removeMarkers([_loc2_],"tileListItemID");
         if(FeatureFlags.NEW_ECONOMY)
         {
            this.upgradeCost = this._currentUpgradePanel.cost;
         }
         else if(this._currentUpgradePanel.getSourcePlayerItemIDs().length > 0)
         {
            this.btnUpgrade.enableMe();
         }
         else
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
            this._inventoryTileList.activateExtendedMode(0.68,true);
         }
         var _loc3_:uint = this.INVENTORY_ITEM_SIZE;
         var _loc4_:uint = this.INVENTORY_ROWS;
         if(dataM.runAsMobile)
         {
            _loc3_ = this.INVENTORY_ITEM_SIZE_MOBILE;
            _loc4_ = this.INVENTORY_ROWS_MOBILE;
         }
         this._inventoryTileList.initialize(screensM.stagePointer,[],_loc4_,4,_loc3_,_loc3_,null,true,_loc2_,null,null,false,0,0.4,true,_loc1_,false,"",false);
         this._inventoryTileList.loadAssetsFunction = externalAssetsM.getAsset;
         if(dataM.runAsMobile)
         {
            this._inventoryTileList.x = this.inventoryPlaceHolder_mobile.x;
            this._inventoryTileList.y = this.inventoryPlaceHolder_mobile.y;
         }
         else
         {
            this._inventoryTileList.x = this.inventoryPlaceHolder.x;
            this._inventoryTileList.y = this.inventoryPlaceHolder.y;
         }
         this.mcTileListHolder.addChild(this._inventoryTileList);
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
         var _loc5_:Function = null;
         var _loc6_:BMTileListItem = null;
         this._inventoryTileList.removeAllItems();
         var _loc2_:Array = new Array();
         var _loc3_:uint = 0;
         var _loc4_:uint = this.INVENTORY_ITEM_SIZE;
         if(dataM.runAsMobile)
         {
            _loc4_ = this.INVENTORY_ITEM_SIZE_MOBILE;
         }
         while(_loc3_ < param1.length)
         {
            _loc5_ = this.onInventoryItemClicked;
            if(dataM.runAsMobile)
            {
               _loc5_ = null;
            }
            _loc6_ = dataM.createInventoryTileListItem2(param1[_loc3_],_loc5_,_loc4_,this.onInventoryItemDown);
            _loc2_.push(_loc6_);
            _loc3_++;
         }
         this._inventoryTileList.addItems(this._inventoryTileList.highestTileID + 1,_loc2_,true);
         this.refreshInvntoryEmptyTiles();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this._inventoryTileList);
         }
         screensM.removeScreen("screenConfirmation");
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
      
      private function onInventoryChanged() : void
      {
         var _loc1_:Array = null;
         if(!FeatureFlags.NEW_ECONOMY)
         {
            if(this._currentUpgradePanel == null)
            {
               this.setInventoryMarkers(this.getNonTargetPlayerItemIDs(),null);
            }
            else
            {
               this.setInventoryMarkers(this.getNonSourcePlayerItemIDs(),this._currentUpgradePanel.getSourcePlayerItemIDs());
            }
         }
         else
         {
            _loc1_ = SUB_TYPES_ARRAY[this._itemTypeDropdown.getSelectedItemID()];
            if(this._currentUpgradePanel == this.upgradePanels.upgradeBoostPanel)
            {
               this.setInventoryList(this._upgradeManager.getPlayerItemIdsForBoost(this._targetPlayerItemID,_loc1_));
               this.setInventoryMarkers([this._targetPlayerItemID],this._currentUpgradePanel.getSourcePlayerItemIDs());
            }
            else if(this._currentUpgradePanel == this.upgradePanels.upgradeTransformPanel)
            {
               this.setInventoryList(this._upgradeManager.getPlayerItemIdsForTransform(this._targetPlayerItemID,_loc1_));
               this.setInventoryMarkers([this._targetPlayerItemID],this._currentUpgradePanel.getSourcePlayerItemIDs());
            }
            else
            {
               this.setInventoryList(this._upgradeManager.getPlayerItemIdsForTarget(_loc1_));
            }
         }
         tutorialM.refreshUpgradeTutorial();
      }
      
      private function getNonSourcePlayerItemIDs() : Array
      {
         var _loc4_:Number = NaN;
         var _loc5_:BMPlayerItemData = null;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._inventoryTileList.items.length)
         {
            _loc4_ = Number(this._inventoryTileList.items[_loc3_].contentData_playerItemID);
            _loc5_ = _loc1_.getPlayerItemBy(_loc4_);
            if(_loc5_ != null && (_loc5_.equipped > 0 || this._targetPlayerItemID == _loc4_))
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getNonTargetPlayerItemIDs() : Array
      {
         var _loc4_:Number = NaN;
         var _loc5_:BMPlayerItemData = null;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._inventoryTileList.items.length)
         {
            _loc4_ = Number(this._inventoryTileList.items[_loc3_].contentData_playerItemID);
            _loc5_ = _loc1_.getPlayerItemBy(_loc4_);
            if(_loc5_ != null && !_loc5_.canBeUpgarded())
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function onInventoryMouseUp() : void
      {
         this.hideItemHint();
      }
      
      private function onInventoryItemDown(param1:Number, param2:Number) : void
      {
         this._mouseDownPlayerItemID = param2;
         this._mouseDownTime = getTimer();
         tooltip.hideToolTip();
      }
      
      public function onInventoryItemClicked(param1:Number, param2:Number) : void
      {
         if(param2 <= -1)
         {
            return;
         }
         if(tutorialM.upgrade_isInventoryEnabled() == false)
         {
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
      
      private function doInventoryItemClicked(param1:Number) : void
      {
         var _loc2_:BMPlayerItemData = dataM.myPlayerData.getPlayerItemBy(param1);
         var _loc3_:BMItemData = dataM.itemsDB[_loc2_.itemID];
         if(this._targetPlayerItemID == -1)
         {
            if(tutorialM.upgrade_canSelectTargetItem(_loc3_.itemID))
            {
               this.selectTargetItem(param1);
            }
            return;
         }
         if(tutorialM.upgrade_canSelectSourceItem(_loc3_.itemID,this._currentUpgradePanel.getNumOfSource()) == false)
         {
            return;
         }
         if(this._targetPlayerItemID == param1)
         {
            this.resetUpgradeState();
            return;
         }
         if(_loc2_.equipped > 0)
         {
            return;
         }
         if(this._currentUpgradePanel.isItemInSource(param1))
         {
            if(tutorialM.isTutorialActive() == false)
            {
               this._currentUpgradePanel.removeFromSource(param1);
            }
            return;
         }
         if(this._currentUpgradePanel.isSourceFull())
         {
            return;
         }
         this.addInventoryMarkers([param1]);
         this._currentUpgradePanel.addToSource(param1);
         if(FeatureFlags.NEW_ECONOMY)
         {
            this.upgradeCost = this._currentUpgradePanel.cost;
         }
         else
         {
            this.btnUpgrade.enableMe();
         }
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
      
      private function selectTargetItem(param1:Number) : void
      {
         var _loc2_:BMItemData = dataM.myPlayerData.getItemBy(param1);
         if(_loc2_.upgradeToItemID == -1)
         {
            this._targetPlayerItemID = -1;
            this.movePanels(0);
            TsLogger.log("BMScreenHangerUpgrade::selectTargetItem item fully upgarded " + param1);
            return;
         }
         if(_loc2_.isMaxLevel())
         {
            this._currentUpgradePanel = this.upgradePanels.upgradeTransformPanel;
            this.btnUpgrade.text = "Transform";
            this.movePanels(-1);
         }
         else
         {
            this._currentUpgradePanel = this.upgradePanels.upgradeBoostPanel;
            this.btnUpgrade.text = "Boost";
            this.movePanels(1);
         }
         this._targetPlayerItemID = param1;
         this.onInventoryChanged();
         this._currentUpgradePanel.visible = true;
         this._currentUpgradePanel.setTarget(param1);
         this.btnUpgrade.open();
      }
      
      private function resetUpgradeState() : void
      {
         this._targetPlayerItemID = -1;
         if(this._currentUpgradePanel != null)
         {
            this._currentUpgradePanel.reset();
            this._currentUpgradePanel = null;
         }
         this.movePanels(0);
         this.btnUpgrade.close();
         this.onInventoryChanged();
         this.upgradeCost = 0;
      }
      
      private function movePanels(param1:int) : void
      {
         this.upgradePanels.upgradeIntroPanel.visible = true;
         this.upgradePanels.upgradeTransformPanel.visible = true;
         this.upgradePanels.upgradeBoostPanel.visible = true;
         TweenMax.to(this.upgradePanels,0.4,{
            "x":this.panelsStartX + param1 * 480,
            "onComplete":this.onMovePanelsComplete
         });
      }
      
      private function onMovePanelsComplete() : *
      {
         this.upgradePanels.upgradeIntroPanel.visible = false;
         this.upgradePanels.upgradeTransformPanel.visible = false;
         this.upgradePanels.upgradeBoostPanel.visible = false;
         if(this._currentUpgradePanel == null)
         {
            this.upgradePanels.upgradeIntroPanel.visible = true;
         }
         else
         {
            this._currentUpgradePanel.visible = true;
         }
      }
      
      private function showItemHint(param1:Number) : void
      {
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
         this.txtGold.text = dataM.getNumberWithComma(param1);
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
         screensM.addScreen("screenBuyGold");
         screensM.screenBuyGold.refreshScreen();
      }
      
      private function onUpgradeHit(param1:Event) : void
      {
         if(this._currentUpgradePanel.cost > dataM.myProfile.gold)
         {
            screensM.screenConfirmation.displayCustomMessage("Not enough credits");
            return;
         }
         tutorialM.hangerUpgradeClicked();
         this._currentUpgradePanel.doUpgrade();
         this._upgradeManager.doUpgarde(this._targetPlayerItemID,this._currentUpgradePanel.getSourcePlayerItemIDs());
      }
      
      public function onUpgradeSuccess() : void
      {
         this._currentUpgradePanel.onUpgradeSuccess();
      }
      
      public function onUpgradeComplete() : *
      {
         this.refreshGold();
         this.upgradeCost = 0;
         soundM.createSound("kitUsed",1);
         this._inventoryTileList.removeItems(this._currentUpgradePanel.getSourcePlayerItemIDs(),"tileListItemID");
         this.refreshInvntoryEmptyTiles();
         this._currentUpgradePanel.reset();
         var _loc1_:BMItemData = dataM.myPlayerData.getItemBy(this._targetPlayerItemID);
         if(_loc1_.upgradeToItemID == -1)
         {
            this.resetUpgradeState();
         }
         else
         {
            this.selectTargetItem(this._targetPlayerItemID);
         }
      }
      
      public function backClicked() : void
      {
         this._itemTypeDropdown.removemMe();
         if(BMUpgradeManager.gi().selectedPlayerItemID == -1)
         {
            screensM.screenNewMenu.mainMenu();
         }
         else
         {
            screensM.screenNewMenu.hangerMechClicked();
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
      }
      
      private function removedFromStage(param1:Event) : void
      {
         if(this._fingerWheeling != null)
         {
            this._fingerWheeling.removeMouseListeners();
         }
      }
   }
}

