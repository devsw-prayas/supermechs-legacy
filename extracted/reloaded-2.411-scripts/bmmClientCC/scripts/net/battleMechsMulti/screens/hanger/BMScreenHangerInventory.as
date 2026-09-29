package net.battleMechsMulti.screens.hanger
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureA;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1430")]
   public class BMScreenHangerInventory extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcMainHolder:Sprite;
      
      public var mcFingerWheelingHitArea:Sprite;
      
      public var mcTutorialMarker_bottomButtons:MovieClip;
      
      public var mcSizer_itemDescription:Sprite;
      
      public var mcSizer_btnItemsLeft:Sprite;
      
      public var mcSizer_btnItemsRight:Sprite;
      
      public var mcSizer_btnItemType1:Sprite;
      
      public var mcSizer_btnItemType2:Sprite;
      
      public var mcSizer_btnItemType3:Sprite;
      
      public var mcSizer_btnItemType4:Sprite;
      
      public var mcSizer_btnItemType5:Sprite;
      
      public var mcSizer_btnItemType6:Sprite;
      
      public var mcSizer_btnItemType7:Sprite;
      
      public var mcSizer_btnItemType1_mobile:Sprite;
      
      public var mcSizer_btnItemType2_mobile:Sprite;
      
      public var mcSizer_btnItemType3_mobile:Sprite;
      
      public var mcSizer_btnItemType4_mobile:Sprite;
      
      public var mcSizer_btnItemType5_mobile:Sprite;
      
      public var mcSizer_btnItemType6_mobile:Sprite;
      
      public var mcSizer_btnItemType7_mobile:Sprite;
      
      public var txtItemType1Items:TextField;
      
      public var txtItemType2Items:TextField;
      
      public var txtItemType3Items:TextField;
      
      public var txtItemType4Items:TextField;
      
      public var txtItemType5Items:TextField;
      
      public var txtItemType6Items:TextField;
      
      public var txtItemType7Items:TextField;
      
      public var inventoryTileList:BMTileList;
      
      private var _currentEquipmentType:String;
      
      private var _currentPlayerData:BMPlayerData;
      
      private var _sellItemTileID:Number;
      
      private var _sellItemTileEquipmentType:String;
      
      private var _sellItemTileEquipmentID:Number;
      
      private var _equipItem_type:String;
      
      private var _equipItem_originPlayerItemID:Number;
      
      private var _equipItem_originEquipmentID:Number;
      
      private var _equipItem_targetPlayerItemID:Number;
      
      private var _equipItem_targetMechID:Number;
      
      private var _equipItem_targetEquipmentID:Number;
      
      private var _equipItem_tileID:Number;
      
      private var _equipItem_backgroundMouseUp:Boolean;
      
      private var _lastTotalInventoryItems:Number = 0;
      
      private var _inventoryFingerWheeling:BMFingerWheeling;
      
      private var _activateItemsLeftClicked:Boolean = false;
      
      private var _activateItemsRightClicked:Boolean = false;
      
      private var _maxItemsInDisplay:uint;
      
      private var _currentPage:uint;
      
      private var _subTypeTotalPages:uint;
      
      private var _showDraggingFingerWithoutDragging:Number;
      
      public var btnItemsLeft:BMButton_pictureA;
      
      public var btnItemsRight:BMButton_pictureA;
      
      public var btnItemType1:BMButton_pictureE;
      
      public var btnItemType2:BMButton_pictureE;
      
      public var btnItemType3:BMButton_pictureE;
      
      public var btnItemType4:BMButton_pictureE;
      
      public var btnItemType5:BMButton_pictureE;
      
      public var btnItemType6:BMButton_pictureE;
      
      public var btnItemType7:BMButton_pictureE;
      
      public var mcSizer_inventory:Sprite;
      
      public var mcLocked1:Sprite;
      
      public var mcLocked2:Sprite;
      
      public var mcLocked3:Sprite;
      
      public var mcLocked4:Sprite;
      
      public var mcLocked5:Sprite;
      
      public var mcLocked6:Sprite;
      
      public var mcLocked7:Sprite;
      
      public var mcItemTypeButtonMarker:Sprite;
      
      public var mcDraggingFinger:MovieClip;
      
      public var inventoryPlayerItemIDsInCategory:Array;
      
      private var _draggingFingerDelayFrames:uint;
      
      private var _lastMouseXPos:Number = 0;
      
      private var _lastMouseYPos:Number = 0;
      
      private var _itemComparison_draggedPlayerItemID:Number = 0;
      
      private var _itemComparison_draggedEquipmentType:String;
      
      private var _itemComparison_rollOverredPlayerItemID:Number = 0;
      
      private var _itemComparison_rollOverredEquipmentType:String;
      
      private var _itemComparison_targetTileListItems:Array;
      
      public const MAX_ITEMS_VISIBLE_IN_INVENTORY:Number = 40;
      
      public const MAX_ITEMS_VISIBLE_IN_INVENTORY_MOBILE:Number = 30;
      
      public var ITEM_TYPE_BUTTONS:Number = 5;
      
      public const TILE_LIST_X_PUSH_MOBILE:uint = 9;
      
      public function BMScreenHangerInventory()
      {
         super();
      }
      
      public function initialize() : void
      {
         var _loc1_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Sprite = null;
         var _loc8_:Sprite = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Function = null;
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("hanger");
         var _loc2_:Function = this.itemTypeClicked;
         if(dataM.runAsMobile)
         {
            _loc2_ = null;
            this.ITEM_TYPE_BUTTONS = 7;
         }
         _loc1_ = 1;
         while(_loc1_ <= this.ITEM_TYPE_BUTTONS)
         {
            if(dataM.runAsMobile)
            {
               _loc7_ = this["mcSizer_btnItemType" + _loc1_];
               _loc8_ = this["mcSizer_btnItemType" + _loc1_ + "_mobile"];
               _loc9_ = _loc8_.x - _loc7_.x;
               _loc10_ = _loc8_.y - _loc7_.y;
               _loc7_.x = _loc8_.x;
               _loc7_.y = _loc8_.y;
               this["txtItemType" + _loc1_ + "Items"].x += _loc9_;
               this["txtItemType" + _loc1_ + "Items"].y += _loc10_;
            }
            screensM.createButtonFromSizer("screenHangerInventory","btnItemType" + _loc1_,"pictureE");
            this["mcSizer_btnItemType" + _loc1_].parent.removeChild(this["mcSizer_btnItemType" + _loc1_]);
            this["mcSizer_btnItemType" + _loc1_] = null;
            this["mcSizer_btnItemType" + _loc1_ + "_mobile"].parent.removeChild(this["mcSizer_btnItemType" + _loc1_ + "_mobile"]);
            this["mcSizer_btnItemType" + _loc1_ + "_mobile"] = null;
            _loc5_ = "subType_inventory_" + dataM.shopItemTypesSourceDB[_loc1_ - 1].iconName;
            _loc6_ = "general";
            this["btnItemType" + _loc1_].initialize("","",externalAssetsM.getAsset(_loc6_,_loc5_,0,0,false,true),[_loc1_],_loc2_,dataM.runAsMobile);
            this["btnItemType" + _loc1_].activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            if(dataM.runAsMobile == false)
            {
               this["btnItemType" + _loc1_].buttonCore.addMouseOutListerner(this.itemTypeButtonMouseOut);
               _loc11_ = this["itemType" + _loc1_ + "ButtonMouseOver"];
               this["btnItemType" + _loc1_].buttonCore.addMouseOverListerner(_loc11_);
            }
            this["txtItemType" + _loc1_ + "Items"].mouseEnabled = false;
            _loc1_++;
         }
         this.mcItemTypeButtonMarker.mouseEnabled = false;
         this.mcItemTypeButtonMarker.mouseChildren = false;
         this.mcTutorialMarker_bottomButtons.mouseEnabled = false;
         this.mcTutorialMarker_bottomButtons.mouseChildren = false;
         if(dataM.runAsMobile)
         {
            this._inventoryFingerWheeling = new BMFingerWheeling();
            this._inventoryFingerWheeling.initialize("inventory",this.inventoryTileList,this.mcFingerWheelingHitArea,this.inventoryItemMouseUp,this.inventoryItemMouseDown,true);
            addChild(this._inventoryFingerWheeling);
            screensM.createButtonFromSizer("screenHangerInventory","btnItemsLeft","pictureA");
            screensM.createButtonFromSizer("screenHangerInventory","btnItemsRight","pictureA");
            this.btnItemsLeft.initialize("","",externalAssetsM.getAsset("general","interface_arrowLeft"),null,null,dataM.runAsMobile);
            this.btnItemsRight.initialize("","",externalAssetsM.getAsset("general","interface_arrowRight"),null,null,dataM.runAsMobile);
            this.btnItemsLeft.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnItemsRight.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         }
         else
         {
            this.mcFingerWheelingHitArea.parent.removeChild(this.mcFingerWheelingHitArea);
            this.mcSizer_itemDescription.parent.removeChild(this.mcSizer_itemDescription);
            this.mcSizer_btnItemsLeft.parent.removeChild(this.mcSizer_btnItemsLeft);
            this.mcSizer_btnItemsRight.parent.removeChild(this.mcSizer_btnItemsRight);
            this.mcSizer_btnItemsLeft = null;
            this.mcSizer_btnItemsRight = null;
         }
         var _loc3_:Number = dataM.INVENTORY_TILE_LIST_ROWS;
         var _loc4_:Number = dataM.INVENTORY_TILE_LIST_COLUMNS;
         if(dataM.runAsMobile)
         {
            _loc3_ = dataM.INVENTORY_TILE_LIST_ROWS_MOBILE;
            _loc4_ = dataM.INVENTORY_TILE_LIST_COLUMNS_MOBILE;
         }
         this._maxItemsInDisplay = _loc3_ * _loc4_;
         if(dataM.runAsMobile == false)
         {
            this.mcDraggingFinger.addEventListener(MouseEvent.MOUSE_UP,this.draggingFingerMouseUp);
         }
      }
      
      public function refreshScreen() : void
      {
         this._currentPage = 0;
         this._currentEquipmentType = dataM.shopItemTypesDB[0];
         this._currentPlayerData = dataM.playersData[dataM.player1PlayerID];
         this._showDraggingFingerWithoutDragging = 0;
         this._itemComparison_draggedPlayerItemID = 0;
         this.addAndRefreshInventoryTileList("refreshScreen",false);
         this.refreshItemTypesButtonsAndAmount();
         if(dataM.runAsMobile)
         {
            this._inventoryFingerWheeling.addMouseListeners();
         }
         if(this.mcDraggingFinger.parent != null)
         {
            this.mcDraggingFinger.parent.removeChild(this.mcDraggingFinger);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(screensM.isScreenOpened("screenHangerInventory"))
         {
            if(dataM.runAsMobile)
            {
               if(draggingM.item == null)
               {
                  this._inventoryFingerWheeling.onEnterFrameTrigger();
               }
               if(this._activateItemsLeftClicked)
               {
                  this._activateItemsLeftClicked = false;
                  this.itemsLeftClickedSub();
               }
               if(this._activateItemsRightClicked)
               {
                  this._activateItemsRightClicked = false;
                  this.itemsRightClickedSub();
               }
            }
            this.draggingTutorialAnimationHandler();
            this.mouseTrackerForMobileItemComparison();
         }
      }
      
      public function addAndRefreshInventoryTileList(param1:String, param2:Boolean) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc26_:uint = 0;
         var _loc27_:Number = NaN;
         var _loc28_:uint = 0;
         var _loc29_:Number = NaN;
         var _loc30_:BMTileListItem = null;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:MovieClip = null;
         var _loc36_:Boolean = false;
         var _loc37_:Boolean = false;
         var _loc38_:Boolean = false;
         var _loc39_:Boolean = false;
         var _loc40_:Boolean = false;
         var _loc41_:Boolean = false;
         var _loc42_:Boolean = false;
         var _loc43_:Array = null;
         var _loc44_:Array = null;
         var _loc45_:uint = 0;
         var _loc46_:Boolean = false;
         var _loc47_:Object = null;
         var _loc48_:Boolean = false;
         var _loc49_:uint = 0;
         var _loc50_:uint = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Number = -1;
         if(this.inventoryTileList != null)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc4_ = this.inventoryTileList.getCurrentRow();
            this.inventoryTileList.deactivateGuideArrow();
            if(_loc13_ == false && _loc14_ == false && param2)
            {
               this.inventoryTileList.setCurrentRowManually(_loc4_);
            }
         }
         else
         {
            this.inventoryTileList = new BMTileList();
            if(dataM.runAsMobile)
            {
               this._inventoryFingerWheeling.resetTileList(this.inventoryTileList);
            }
            _loc32_ = dataM.INVENTORY_TILE_LIST_ITEM_SIZE;
            _loc33_ = dataM.INVENTORY_TILE_LIST_ROWS;
            _loc34_ = dataM.INVENTORY_TILE_LIST_COLUMNS;
            _loc35_ = new Grp_scrollerContent();
            this.inventoryTileList.loadAssetsFunction = externalAssetsM.getAsset;
            if(dataM.runAsMobile)
            {
               _loc32_ = dataM.INVENTORY_TILE_LIST_ITEM_SIZE_MOBILE;
               _loc33_ = dataM.INVENTORY_TILE_LIST_ROWS_MOBILE;
               _loc34_ = dataM.INVENTORY_TILE_LIST_COLUMNS_MOBILE;
            }
            _loc36_ = false;
            if(dataM.runAsMobile)
            {
               _loc36_ = true;
            }
            this.inventoryTileList.initialize(screensM.stagePointer,new Array(),_loc33_,_loc34_,_loc32_,_loc32_,this.inventoryBackgroundMouseUp,true,_loc35_,null,null,false,0,0.65,true,_loc36_,dataM.runAsMobile);
            this.inventoryTileList.x = this.mcSizer_inventory.x;
            this.inventoryTileList.y = this.mcSizer_inventory.y;
            if(dataM.runAsMobile)
            {
               this.inventoryTileList.x += this.TILE_LIST_X_PUSH_MOBILE;
            }
            this.inventoryTileList.pushScroller(0,2);
            this.mcMainHolder.addChild(this.inventoryTileList);
         }
         var _loc9_:Array = new Array();
         var _loc10_:Number = 0;
         var _loc11_:Array = new Array();
         var _loc12_:String = screensM.screenHangerMenu.screenStatus;
         if(_loc12_ == "fusion")
         {
            _loc11_ = screensM.screenHangerFusion.getEquippedPlayerItemIDs();
         }
         _loc5_ = 0;
         while(_loc5_ < this._currentPlayerData.items.length)
         {
            _loc7_ = this._currentPlayerData.items[_loc5_];
            _loc8_ = dataM.itemsDB[_loc7_.itemID];
            if(_loc8_ != null)
            {
               _loc37_ = false;
               _loc6_ = 0;
               while(_loc6_ < _loc11_.length)
               {
                  if(_loc7_.playerItemID == _loc11_[_loc6_])
                  {
                     _loc37_ = true;
                     _loc6_ = _loc11_.length;
                  }
                  _loc6_++;
               }
               if(_loc37_ == false)
               {
                  _loc9_.push({
                     "finalSortID":_loc8_.finalSortID,
                     "itemSlot":_loc5_
                  });
                  _loc38_ = false;
                  switch(_loc8_.type)
                  {
                     case "torso":
                     case "leg":
                     case "sideWeapon":
                     case "topWeapon":
                     case "drone":
                     case "teleport":
                     case "charge":
                     case "harpoon":
                        _loc38_ = true;
                  }
                  if(_loc7_.equipped == 0 || _loc12_ == "fusion" && _loc7_.equipped >= 1 && _loc38_)
                  {
                     _loc10_++;
                  }
               }
            }
            else
            {
               TsLogger.log("ERROR : ITEM ID " + _loc7_.itemID + " DOES NOT EXIST");
            }
            _loc5_++;
         }
         _loc9_.sortOn("finalSortID",Array.NUMERIC);
         _loc13_ = false;
         _loc14_ = false;
         var _loc15_:Number = this.MAX_ITEMS_VISIBLE_IN_INVENTORY;
         if(dataM.runAsMobile)
         {
            _loc15_ = this.MAX_ITEMS_VISIBLE_IN_INVENTORY_MOBILE;
         }
         if(this._lastTotalInventoryItems <= _loc15_ && _loc10_ > _loc15_)
         {
            _loc13_ = true;
         }
         else if(this._lastTotalInventoryItems > _loc15_ && _loc10_ <= _loc15_)
         {
            _loc14_ = true;
         }
         var _loc16_:String = "up";
         if(_loc10_ <= _loc15_)
         {
            _loc16_ = "down";
         }
         this._lastTotalInventoryItems = _loc10_;
         var _loc17_:Array = new Array();
         var _loc18_:Array = new Array();
         var _loc19_:uint = 1;
         while(_loc19_ <= dataM.inventoryMaxMechs)
         {
            _loc18_.push(_loc19_);
            _loc19_++;
         }
         _loc18_.push(0);
         this.inventoryPlayerItemIDsInCategory = new Array();
         var _loc20_:uint = 0;
         while(_loc20_ < _loc18_.length)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc9_.length)
            {
               _loc7_ = this._currentPlayerData.items[_loc9_[_loc5_].itemSlot];
               if(_loc7_.equipped == _loc18_[_loc20_])
               {
                  _loc39_ = false;
                  _loc40_ = false;
                  switch(_loc7_.equipmentType)
                  {
                     case "torso":
                     case "leg":
                     case "sideWeapon":
                     case "topWeapon":
                        _loc39_ = true;
                        _loc40_ = true;
                        break;
                     case "drone":
                        _loc39_ = true;
                        _loc40_ = true;
                        break;
                     case "teleport":
                     case "charge":
                     case "harpoon":
                        _loc40_ = true;
                  }
                  _loc41_ = false;
                  _loc42_ = false;
                  if(_loc12_ == "mech" || _loc12_ == "shop")
                  {
                     if(_loc7_.equipped == 0)
                     {
                        _loc41_ = true;
                     }
                  }
                  if(_loc12_ == "fusion")
                  {
                     if(_loc7_.equipped == 0)
                     {
                        _loc42_ = true;
                     }
                     else if(_loc40_)
                     {
                        _loc42_ = true;
                     }
                  }
                  if(_loc41_ || _loc42_)
                  {
                     _loc8_ = dataM.itemsDB[_loc7_.itemID];
                     if(this.isItemTypeInSelectedCategory(_loc8_.type) || _loc10_ <= _loc15_ || dataM.tutorialEnabled)
                     {
                        this.inventoryPlayerItemIDsInCategory.push(_loc7_.playerItemID);
                     }
                  }
               }
               _loc5_++;
            }
            _loc20_++;
         }
         if(this.inventoryPlayerItemIDsInCategory.length > 0)
         {
            this._subTypeTotalPages = Math.ceil(this.inventoryPlayerItemIDsInCategory.length / this._maxItemsInDisplay) - 1;
         }
         else
         {
            this._subTypeTotalPages = 0;
         }
         var _loc21_:uint = 99999;
         var _loc22_:uint = 0;
         if(dataM.runAsMobile)
         {
            _loc21_ = this._maxItemsInDisplay;
            if(this._currentPage > 0)
            {
               if(this._currentPage * this._maxItemsInDisplay >= this.inventoryPlayerItemIDsInCategory.length)
               {
                  --this._currentPage;
               }
               _loc22_ = this._currentPage * _loc21_;
            }
         }
         var _loc23_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < this.inventoryPlayerItemIDsInCategory.length)
         {
            if(_loc5_ + 1 > _loc22_ && _loc23_.length < _loc21_)
            {
               _loc23_.push(this.inventoryPlayerItemIDsInCategory[_loc5_]);
            }
            _loc5_++;
         }
         var _loc24_:Array = this.inventoryTileList.getAllTileListItemIDs();
         var _loc25_:Array = new Array();
         var _loc31_:Boolean = false;
         if(_loc24_.length > 0)
         {
            _loc43_ = new Array();
            _loc44_ = new Array();
            _loc45_ = 0;
            _loc28_ = 0;
            while(_loc28_ < _loc23_.length)
            {
               _loc29_ = Number(_loc23_[_loc28_]);
               _loc46_ = true;
               _loc26_ = 0;
               while(_loc26_ < _loc24_.length)
               {
                  _loc27_ = Number(_loc24_[_loc26_]);
                  if(_loc29_ == _loc27_)
                  {
                     _loc46_ = false;
                     _loc43_.push(_loc29_);
                     _loc26_ = _loc24_.length;
                  }
                  _loc26_++;
               }
               if(_loc46_)
               {
                  _loc44_.push({
                     "playerItemID":_loc29_,
                     "slot":_loc45_ + _loc43_.length
                  });
                  _loc45_++;
               }
               _loc28_++;
            }
            if(_loc43_.length == 0)
            {
               this.inventoryTileList.removeAllItems();
               _loc31_ = true;
            }
            else
            {
               _loc5_ = 0;
               while(_loc5_ < _loc44_.length)
               {
                  _loc47_ = _loc44_[_loc5_];
                  _loc30_ = this.createInventoryTileListItem(_loc47_.playerItemID);
                  this.inventoryTileList.addItems(_loc47_.slot,[_loc30_],false);
                  _loc5_++;
               }
               if(_loc24_.length > _loc43_.length)
               {
                  _loc26_ = 0;
                  while(_loc26_ < _loc24_.length)
                  {
                     _loc27_ = Number(_loc24_[_loc26_]);
                     _loc48_ = true;
                     _loc49_ = 0;
                     while(_loc49_ < _loc43_.length)
                     {
                        _loc50_ = uint(_loc43_[_loc49_]);
                        if(_loc27_ == _loc50_)
                        {
                           _loc48_ = false;
                        }
                        _loc49_++;
                     }
                     if(_loc48_)
                     {
                        _loc25_.push(_loc27_);
                     }
                     _loc26_++;
                  }
                  this.inventoryTileList.removeItems(_loc25_,"tileListItemID");
               }
            }
         }
         else
         {
            _loc31_ = true;
         }
         if(_loc31_)
         {
            _loc28_ = 0;
            while(_loc28_ < _loc23_.length)
            {
               _loc29_ = Number(_loc23_[_loc28_]);
               _loc30_ = this.createInventoryTileListItem(_loc29_);
               _loc17_.push(_loc30_);
               _loc28_++;
            }
            this.inventoryTileList.addItems(0,_loc17_,false);
         }
         this.refreshItemsLeftRightButtons();
      }
      
      private function inventoryItemMouseClicked(param1:Number, param2:Number) : void
      {
      }
      
      private function inventoryItemMouseDown(param1:Number, param2:Number) : void
      {
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         var _loc8_:BMItem = null;
         if(param1 > -1)
         {
            if(screensM.screenHangerMenu.hangerEnabled)
            {
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc4_ = false;
               _loc5_ = screensM.screenHangerMenu.screenStatus;
               if(_loc5_ != "shop")
               {
                  _loc6_ = dataM.getPlayerItemData(dataM.player1PlayerID,param2);
                  _loc7_ = dataM.itemsDB[_loc6_.itemID];
                  if(dataM.tutorialEnabled)
                  {
                     if(_loc3_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_MECH1)
                     {
                        switch(_loc7_.itemID)
                        {
                           case BMCampaignMechsHelper.getTutorial_hanger1_torso():
                           case BMCampaignMechsHelper.getTutorial_hanger1_leg():
                           case BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon():
                              _loc4_ = true;
                        }
                     }
                     else if(_loc3_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_MECH2)
                     {
                        switch(_loc7_.itemID)
                        {
                           case BMCampaignMechsHelper.getTutorial_hanger2_torso():
                           case BMCampaignMechsHelper.getTutorial_hanger2_sideWeapon():
                              _loc4_ = true;
                        }
                     }
                     else if(_loc3_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_MECH3)
                     {
                        switch(_loc7_.itemID)
                        {
                           case BMCampaignMechsHelper.getTutorial_hanger3_torso():
                           case BMCampaignMechsHelper.getTutorial_hanger3_sideWeapon():
                              _loc4_ = true;
                        }
                     }
                     else if(_loc3_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_MECH4)
                     {
                        switch(_loc7_.itemID)
                        {
                           case BMCampaignMechsHelper.getTutorial_hanger4_sideWeapon():
                              if(FeatureFlags.NEW_ECONOMY)
                              {
                                 break;
                              }
                           case BMCampaignMechsHelper.getTutorial_hanger4_topWeapon():
                           case BMCampaignMechsHelper.getTutorial_hanger4_module():
                              _loc4_ = true;
                        }
                     }
                     else if(_loc3_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_MECH5)
                     {
                        switch(_loc7_.itemID)
                        {
                           case BMCampaignMechsHelper.getTutorial_hanger5_leg():
                           case BMCampaignMechsHelper.getTutorial_hanger5_module():
                           case BMCampaignMechsHelper.getTutorial_hanger5_drone():
                              _loc4_ = true;
                        }
                     }
                     else if(_loc3_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_FUSION)
                     {
                        switch(_loc7_.itemID)
                        {
                           case BMCampaignMechsHelper.getTutorial_hanger3_torso():
                              _loc4_ = true;
                              break;
                           case BMCampaignMechsHelper.getTutorial_hanger1_torso():
                           case BMCampaignMechsHelper.getTutorial_hanger1_leg():
                           case BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon():
                              if(screensM.screenHangerFusion.getTargetPlayerItemID() > 0)
                              {
                                 _loc4_ = true;
                              }
                        }
                     }
                  }
                  else
                  {
                     _loc4_ = true;
                  }
               }
               if(_loc4_)
               {
                  _loc8_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,param2,"drag",true);
                  this.dragItem("inventory",_loc8_,param1,"",-1,false);
                  if(screensM.isScreenOpened("screenHangerMech"))
                  {
                     screensM.screenHangerMech.refreshMechStats(0);
                  }
                  this.inventoryTileList.addDisabledEffectForSpecificItems([param2],"tileListItemID");
                  if(dataM.runAsMobile)
                  {
                     if(_loc3_.tutorialLevel > 2)
                     {
                        tooltip.showToolTip("inventory","",param2);
                        tooltip.allowRepositionForMobile = true;
                        if(screensM.isScreenOpened("screenHangerMech"))
                        {
                           screensM.screenHangerMech.refreshMechStats(param2);
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function inventoryItemMouseOver(param1:Number, param2:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:BMPlayerItemData = null;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param2);
         var _loc5_:Boolean = true;
         if(screensM.isScreenOpened("screenHangerMech") == false)
         {
            _loc5_ = false;
         }
         else if(dataM.isPowerKit(_loc4_.itemID) || dataM.isColorKit(_loc4_.itemID))
         {
            _loc5_ = false;
         }
         else if(screensM.isScreenOpened("screenHangerItemComparison"))
         {
            _loc6_ = screensM.screenHangerItemComparison.getInventoryPlayerItemID();
            _loc7_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_);
            if(_loc4_.equipmentType != _loc7_.equipmentType)
            {
               _loc5_ = false;
            }
         }
         if(_loc5_)
         {
            screensM.screenHangerMech.mechEquipment.showEquipmentMarkers(_loc4_.equipmentType,0,true);
         }
         if(_loc3_.tutorialLevel >= BMTutorialManager.TUTORIAL_LEVEL_MECH2)
         {
            tooltip.showToolTip("inventory","",param2,-1);
            if(screensM.isScreenOpened("screenHangerMech"))
            {
               screensM.screenHangerMech.refreshMechStats(param2);
            }
         }
      }
      
      private function inventoryItemMouseOut(param1:Number, param2:Number) : void
      {
         tooltip.hideToolTip();
         if(screensM.isScreenOpened("screenHangerMech"))
         {
            if(screensM.isScreenOpened("screenHangerItemComparison") == false)
            {
               screensM.screenHangerMech.mechEquipment.removeEquipmentMarkers();
            }
            screensM.screenHangerMech.refreshMechStats(0);
         }
      }
      
      private function inventoryItemMouseUp(param1:Number, param2:Number) : void
      {
         if(param1 > -1)
         {
            this.inventoryItemMouseUpSub(param1,false);
            this.unEquippAnItemFromFusion();
            if(screensM.isScreenOpened("screenHangerMech"))
            {
               screensM.screenHangerMech.mechEquipment.removeEquipmentMarkers();
            }
         }
      }
      
      public function inventoryBackgroundMouseUp() : void
      {
         this.inventoryItemMouseUpSub(this.inventoryTileList.highestTileID,true);
         this.unEquippAnItemFromFusion();
      }
      
      private function unEquippAnItemFromFusion() : void
      {
         if(draggingM.item != null)
         {
            if(draggingM.dragOrigin == "fusion")
            {
               screensM.screenHangerFusion.itemDraggedOnInventory();
               this.addAndRefreshInventoryTileList("unEquippAnItemFromFusion",true);
               this.refreshItemTypesButtonsAndAmount();
            }
         }
      }
      
      private function inventoryItemMouseUpSub(param1:Number, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:BMItemData = null;
         var _loc11_:BMTileListItem = null;
         var _loc12_:Boolean = false;
         var _loc13_:BMPlayerProfile = null;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:BMPlayerData = null;
         var _loc17_:uint = 0;
         var _loc18_:BMMechStructure = null;
         var _loc19_:uint = 0;
         if(screensM.screenHangerMenu.hangerEnabled)
         {
            if(draggingM.item != null)
            {
               _loc3_ = draggingM.dragOrigin;
               _loc4_ = draggingM.dragTileID;
               _loc5_ = param1;
               switch(_loc3_)
               {
                  case "inventory":
                  case "mech":
                     if(_loc3_ == "mech")
                     {
                        screensM.screenHangerMech.mechEquipment.removeAllItemsStaticGlow();
                     }
                     _loc6_ = draggingM.item.ID;
                     _loc7_ = false;
                     _loc8_ = false;
                     if(_loc3_ == "inventory")
                     {
                        if(_loc5_ == _loc4_ && param2 == false)
                        {
                           switch(screensM.screenHangerMenu.screenStatus)
                           {
                              case "mech":
                                 _loc7_ = true;
                                 break;
                              case "fusion":
                                 _loc8_ = true;
                           }
                        }
                     }
                     _loc9_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_);
                     if(_loc7_ == false && _loc8_ == false && dataM.tutorialEnabled == false)
                     {
                        this.stopDraggingItem("inventoryItemMouseUpSub inventory/mech");
                        _loc10_ = dataM.itemsDB[_loc9_.itemID];
                        switch(_loc3_)
                        {
                           case "mech":
                              this._equipItem_type = "mechToInventory";
                              this._equipItem_originPlayerItemID = _loc6_;
                              this._equipItem_tileID = param1;
                              this._equipItem_backgroundMouseUp = param2;
                              screensM.screenHangerMenu.hangerEnabled = false;
                              this.unequipItemLocally();
                        }
                     }
                     else if(_loc7_)
                     {
                        _loc12_ = false;
                        _loc13_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                        if(_loc13_.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_MECH1)
                        {
                           if(dataM.useItemComparisonOnInventoryItemClick)
                           {
                              _loc14_ = 0;
                              _loc15_ = 0;
                              if(dataM.isPowerKit(_loc9_.itemID) == false && dataM.isColorKit(_loc9_.itemID) == false)
                              {
                                 _loc16_ = dataM.playersData[dataM.player1PlayerID];
                                 _loc17_ = screensM.screenHangerMech.getTargetMechID();
                                 _loc18_ = _loc16_.mechStructures[_loc17_];
                                 _loc15_ = _loc9_.playerItemID;
                                 switch(_loc9_.equipmentType)
                                 {
                                    case "sideWeapon":
                                    case "topWeapon":
                                    case "module":
                                    case "kit":
                                       _loc19_ = 1;
                                       while(_loc19_ <= dataM.maxEquipment[_loc9_.equipmentType])
                                       {
                                          if(_loc18_[_loc9_.equipmentType + _loc19_] > 0)
                                          {
                                             _loc14_ = uint(_loc18_[_loc9_.equipmentType + _loc19_]);
                                             _loc12_ = true;
                                             _loc19_ = uint(dataM.maxEquipment[_loc9_.equipmentType]);
                                          }
                                          _loc19_++;
                                       }
                                       break;
                                    default:
                                       if(_loc18_[_loc9_.equipmentType] > 0)
                                       {
                                          _loc14_ = uint(_loc18_[_loc9_.equipmentType]);
                                          _loc12_ = true;
                                       }
                                 }
                              }
                           }
                        }
                        if(_loc12_)
                        {
                           this.openItemComparisonScreen(_loc14_,_loc15_);
                        }
                        else
                        {
                           this.dropItemAtClosestEquipment();
                           if(screensM.isScreenOpened("screenHangerItemComparison"))
                           {
                              screensM.screenHangerMech.showAllAvailableItems();
                              screensM.screenHangerMech.showMechStats();
                              screensM.screenHangerItemComparison.removeMe();
                           }
                        }
                     }
                     else if(_loc8_)
                     {
                        screensM.screenHangerFusion.equipItem();
                        this.stopDraggingItem("inventoryItemMouseUpSub fusionFromInventory");
                     }
               }
            }
         }
      }
      
      private function createInventoryTileListItem(param1:Number) : BMTileListItem
      {
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.newItemsPurchased.length)
         {
            if(param1 == _loc2_.newItemsPurchased[_loc4_])
            {
               _loc3_ = true;
               _loc4_ = _loc2_.newItemsPurchased.length;
            }
            _loc4_++;
         }
         var _loc5_:Boolean = false;
         if(dataM.runAsMobile)
         {
            _loc5_ = true;
         }
         return dataM.createInventoryTileListItem(param1,_loc3_,this.inventoryItemMouseClicked,this.inventoryItemMouseDown,this.inventoryItemMouseUp,this.inventoryItemMouseOver,this.inventoryItemMouseOut,_loc5_);
      }
      
      private function isItemTypeInSelectedCategory(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         if(dataM.shopItemTypesReverseDB[this._currentEquipmentType] == dataM.shopItemTypesReverseDB[param1])
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function openItemComparisonScreen(param1:Number, param2:Number) : void
      {
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:Number = NaN;
         var _loc10_:BMPlayerItemData = null;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc3_.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_MECH1)
         {
            screensM.addScreen("screenHangerItemComparison");
            if(dataM.useItemComparisonOnMechItemRollOver)
            {
               _loc7_ = dataM.getPlayerItemData(dataM.player1PlayerID,param2);
               screensM.screenHangerItemComparison.refreshScreen(param1,param2);
               screensM.screenHangerMech.mechEquipment.showEquipmentMarkers(_loc7_.equipmentType,1,true);
               _loc4_ = _loc7_.equipmentType;
               tooltip.hideToolTip();
            }
            else
            {
               if(param1 > 0)
               {
                  _loc8_ = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
               }
               _loc9_ = screensM.screenHangerItemComparison.getInventoryPlayerItemID();
               if(_loc9_ > 0)
               {
                  _loc10_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc9_);
               }
               if(param1 == 0)
               {
                  screensM.screenHangerItemComparison.changeMechPlayerItemIDOnly(0);
               }
               else if(param2 > 0)
               {
                  screensM.screenHangerItemComparison.refreshScreen(param1,param2);
                  screensM.screenHangerMech.mechEquipment.showEquipmentMarkers(_loc8_.equipmentType,1,true);
                  tooltip.hideToolTip();
               }
               else
               {
                  screensM.screenHangerItemComparison.changeMechPlayerItemIDOnly(param1);
               }
               if(param1 > 0)
               {
                  if(dataM.useItemComparisonOnInventoryItemClick)
                  {
                     screensM.screenHangerMech.showAllAvailableItems();
                     screensM.screenHangerMech.hideAllItemsExceptType(_loc8_.equipmentType);
                  }
                  _loc4_ = _loc8_.equipmentType;
               }
               else
               {
                  _loc4_ = _loc10_.equipmentType;
               }
            }
            screensM.screenHangerItemComparison.x = 140;
            _loc5_ = screensM.screenHangerItemComparison.getScreenHeight();
            _loc6_ = screensM.screenHangerMech.mcSizer_mechEquipment.y + (screensM.screenHangerMech.mcSizer_mechEquipment.height - _loc5_) / 2;
            switch(_loc4_)
            {
               case "sideWeapon":
               case "topWeapon":
                  if(_loc6_ + _loc5_ > screensM.screenHangerMech.weaponsYPos - 8)
                  {
                     _loc6_ -= _loc6_ + _loc5_ - (screensM.screenHangerMech.weaponsYPos - 8);
                  }
            }
            screensM.screenHangerItemComparison.y = _loc6_;
            screensM.screenHangerMech.hideMechStats();
         }
      }
      
      private function mouseTrackerForMobileItemComparison() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Boolean = false;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:BMPlayerData = null;
         var _loc12_:uint = 0;
         var _loc13_:BMMechStructure = null;
         var _loc14_:Number = NaN;
         if(dataM.runAsMobile)
         {
            if(screensM.screenHangerMenu.screenStatus == "mech")
            {
               _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc1_.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_MECH1)
               {
                  _loc2_ = false;
                  if(draggingM.item != null)
                  {
                     if(this._lastMouseXPos != mouseX || this._lastMouseYPos != mouseY)
                     {
                        if(mouseX >= screensM.screenHangerMech.mcSizer_mechEquipment.x && mouseX <= screensM.screenHangerMech.mcSizer_mechEquipment.x + screensM.screenHangerMech.mcSizer_mechEquipment.width)
                        {
                           if(mouseY >= screensM.screenHangerMech.mcSizer_mechEquipment.y && mouseY <= screensM.screenHangerMech.mcSizer_mechEquipment.y + screensM.screenHangerMech.mcSizer_mechEquipment.height)
                           {
                              _loc2_ = true;
                              if(this._itemComparison_draggedPlayerItemID != draggingM.item.ID)
                              {
                                 this._itemComparison_draggedPlayerItemID = draggingM.item.ID;
                                 this._itemComparison_rollOverredPlayerItemID = 0;
                                 _loc3_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._itemComparison_draggedPlayerItemID);
                                 this._itemComparison_draggedEquipmentType = _loc3_.equipmentType;
                                 this._itemComparison_targetTileListItems = new Array();
                                 if(this._itemComparison_draggedEquipmentType == "torso")
                                 {
                                    this._itemComparison_targetTileListItems.push("torso");
                                 }
                                 if(screensM.screenHangerMech.mechEquipment.leg.visible)
                                 {
                                    switch(this._itemComparison_draggedEquipmentType)
                                    {
                                       case "sideWeapon":
                                       case "topWeapon":
                                       case "module":
                                       case "kit":
                                          _loc4_ = 1;
                                          while(_loc4_ <= dataM.maxEquipment[this._itemComparison_draggedEquipmentType])
                                          {
                                             if(screensM.screenHangerMech.mechEquipment[this._itemComparison_draggedEquipmentType + _loc4_].visible)
                                             {
                                                this._itemComparison_targetTileListItems.push(this._itemComparison_draggedEquipmentType + _loc4_);
                                             }
                                             _loc4_++;
                                          }
                                          break;
                                       case "leg":
                                       case "drone":
                                       case "teleport":
                                       case "shield":
                                       case "charge":
                                       case "harpoon":
                                          if(screensM.screenHangerMech.mechEquipment[this._itemComparison_draggedEquipmentType].visible)
                                          {
                                             this._itemComparison_targetTileListItems.push(this._itemComparison_draggedEquipmentType);
                                          }
                                    }
                                 }
                              }
                              if(this._itemComparison_targetTileListItems.length > 0)
                              {
                                 _loc5_ = -1;
                                 _loc6_ = 999;
                                 _loc7_ = 0;
                                 while(_loc7_ < this._itemComparison_targetTileListItems.length)
                                 {
                                    _loc8_ = mouseX - 25 - screensM.screenHangerMech.mechEquipment[this._itemComparison_targetTileListItems[_loc7_]].x - screensM.screenHangerMech.mechEquipment.x;
                                    _loc9_ = mouseY - 25 - screensM.screenHangerMech.mechEquipment[this._itemComparison_targetTileListItems[_loc7_]].y - screensM.screenHangerMech.mechEquipment.y;
                                    _loc10_ = dataM.getVectorSize(_loc8_,_loc9_);
                                    if(_loc10_ < _loc6_)
                                    {
                                       _loc5_ = _loc7_;
                                       _loc6_ = _loc10_;
                                    }
                                    _loc7_++;
                                 }
                                 if(_loc6_ < 50)
                                 {
                                    _loc11_ = dataM.playersData[dataM.player1PlayerID];
                                    _loc12_ = screensM.screenHangerMech.getTargetMechID();
                                    _loc13_ = _loc11_.mechStructures[_loc12_];
                                    _loc14_ = Number(_loc13_[this._itemComparison_targetTileListItems[_loc5_]]);
                                    if(this._itemComparison_rollOverredPlayerItemID != _loc14_)
                                    {
                                       this._itemComparison_rollOverredPlayerItemID = _loc14_;
                                       if(this._itemComparison_rollOverredPlayerItemID > 0)
                                       {
                                          if(this._itemComparison_rollOverredPlayerItemID != this._itemComparison_draggedPlayerItemID)
                                          {
                                             this.openItemComparisonScreen(this._itemComparison_rollOverredPlayerItemID,this._itemComparison_draggedPlayerItemID);
                                             _loc2_ = false;
                                          }
                                          else if(_loc1_.tutorialLevel > 2)
                                          {
                                             tooltip.showToolTip("inventory","",this._itemComparison_draggedPlayerItemID);
                                             tooltip.allowRepositionForMobile = true;
                                          }
                                       }
                                       else if(_loc1_.tutorialLevel > 2)
                                       {
                                          tooltip.showToolTip("inventory","",this._itemComparison_draggedPlayerItemID);
                                          tooltip.allowRepositionForMobile = true;
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ = false;
                                    }
                                 }
                              }
                           }
                           else if(this._itemComparison_rollOverredPlayerItemID > 0)
                           {
                              _loc2_ = true;
                           }
                        }
                        else if(this._itemComparison_rollOverredPlayerItemID > 0)
                        {
                           _loc2_ = true;
                        }
                     }
                     this._lastMouseXPos = mouseX;
                     this._lastMouseYPos = mouseY;
                  }
                  else if(this._itemComparison_draggedPlayerItemID > 0)
                  {
                     _loc2_ = true;
                     this._itemComparison_draggedPlayerItemID = 0;
                  }
                  if(_loc2_)
                  {
                     if(screensM.isScreenOpened("screenHangerItemComparison"))
                     {
                        screensM.screenHangerItemComparison.removeMe();
                        screensM.screenHangerMech.showMechStats();
                     }
                     if(this._itemComparison_draggedPlayerItemID == 0)
                     {
                        screensM.screenHangerMech.mechEquipment.removeEquipmentMarkers();
                     }
                     this._itemComparison_rollOverredPlayerItemID = 0;
                  }
               }
            }
         }
      }
      
      public function getInventoryCurrentPage() : uint
      {
         return this._currentPage;
      }
      
      public function itemsLeftClicked() : void
      {
         if(this._currentPage > 0)
         {
            this._activateItemsLeftClicked = true;
            this.btnItemsLeft.disableMe();
         }
      }
      
      private function itemsLeftClickedSub() : void
      {
         --this._currentPage;
         this.addAndRefreshInventoryTileList("itemsLeftClickedSub",false);
         this.refreshItemsLeftRightButtons();
      }
      
      public function itemsRightClicked() : void
      {
         if(this._currentPage < this._subTypeTotalPages)
         {
            this._activateItemsRightClicked = true;
            this.btnItemsRight.disableMe();
         }
      }
      
      private function itemsRightClickedSub() : void
      {
         ++this._currentPage;
         this.addAndRefreshInventoryTileList("itemsLeftClickedSub",false);
         this.refreshItemsLeftRightButtons();
      }
      
      public function setInventoryCurrentPage(param1:uint) : void
      {
         this._currentPage = param1;
      }
      
      private function refreshItemsLeftRightButtons() : void
      {
         if(dataM.runAsMobile)
         {
            if(dataM.tutorialEnabled)
            {
               this.btnItemsLeft.visible = false;
               this.btnItemsRight.visible = false;
            }
            else if(this._subTypeTotalPages == 0)
            {
               this.btnItemsLeft.visible = false;
               this.btnItemsRight.visible = false;
               this.btnItemsLeft.disableMe();
               this.btnItemsRight.disableMe();
            }
            else
            {
               this.btnItemsLeft.visible = true;
               this.btnItemsRight.visible = true;
               if(this._currentPage < this._subTypeTotalPages)
               {
                  this.btnItemsRight.enableMe();
               }
               else
               {
                  this.btnItemsRight.disableMe();
               }
               if(this._currentPage > 0)
               {
                  this.btnItemsLeft.enableMe();
               }
               else
               {
                  this.btnItemsLeft.disableMe();
               }
            }
         }
      }
      
      public function equipItemLocally() : void
      {
         this.equipItemSuccess();
      }
      
      public function equipItemSuccess() : void
      {
         var _loc1_:BMPlayerItemData = null;
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMItemData = null;
         var _loc4_:BMItemData = null;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         screensM.screenHangerMech.mechEquipment.removeEquipmentMarkers();
         var _loc5_:Boolean = false;
         var _loc6_:String = "";
         var _loc7_:Number = 0;
         switch(this._equipItem_type)
         {
            case "inventoryToMech":
               _loc1_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._equipItem_originPlayerItemID);
               _loc3_ = dataM.itemsDB[_loc1_.itemID];
               _loc1_.equipped = this._equipItem_targetMechID;
               _loc1_.equipmentType = _loc3_.type;
               _loc1_.equipmentID = this._equipItem_targetEquipmentID;
               if(this._equipItem_targetPlayerItemID > 0)
               {
                  _loc2_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._equipItem_targetPlayerItemID);
                  _loc4_ = dataM.itemsDB[_loc2_.itemID];
                  _loc6_ = _loc2_.equipmentType;
                  _loc7_ = _loc2_.equipmentID;
                  _loc2_.equipmentID = 0;
                  _loc2_.equipped = 0;
                  switch(_loc4_.type)
                  {
                     case "sideWeapon":
                     case "topWeapon":
                        if(dataM.tutorialEnabled == false)
                        {
                        }
                  }
               }
               this.addAndRefreshInventoryTileList("equipItemSuccess",true);
               break;
            case "mechToItself":
               _loc1_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._equipItem_originPlayerItemID);
               _loc3_ = dataM.itemsDB[_loc1_.itemID];
               _loc9_ = _loc1_.equipmentType;
               _loc10_ = _loc1_.equipmentID;
               _loc1_.equipmentType = _loc3_.type;
               _loc1_.equipmentID = this._equipItem_targetEquipmentID;
               if(this._equipItem_targetPlayerItemID > 0)
               {
                  _loc2_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._equipItem_targetPlayerItemID);
                  _loc6_ = _loc2_.equipmentType;
                  _loc7_ = _loc2_.equipmentID;
                  _loc2_.equipmentType = _loc3_.type;
                  _loc2_.equipmentID = this._equipItem_originEquipmentID;
               }
         }
         var _loc8_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         _loc8_.updateMechsWeight();
         switch(_loc6_)
         {
            case "torso":
               screensM.screenHangerMech.mechEquipment.mechView.activateUnequipAnimation("torso",0);
               break;
            case "leg":
            case "sideWeapon":
            case "topWeapon":
               screensM.screenHangerMech.mechEquipment.mechView.activateUnequipAnimation(_loc6_,_loc7_);
         }
         this.equipAndUnEquipRefreshFunctions(_loc1_.equipmentType);
         switch(_loc1_.equipmentType)
         {
            case "torso":
            case "leg":
            case "sideWeapon":
            case "topWeapon":
               screensM.screenHangerMech.mechEquipment.mechView.activateEquipmentAnimation(_loc1_.equipmentType,_loc1_.equipmentID);
               break;
            default:
               soundM.createSound("itemEquipped",1);
         }
         if(_loc5_)
         {
            if(_loc3_.bullets > screensM.screenHangerMech.getCurrentMechTotalBullets())
            {
               screensM.screenConfirmation.displayQuestionOrNotification("itemEquippedNoBullets",_loc3_.itemID,-1);
            }
            else if(_loc3_.rockets > screensM.screenHangerMech.getCurrentMechTotalRockets())
            {
               screensM.screenConfirmation.displayQuestionOrNotification("itemEquippedNoRockets",_loc3_.itemID,-1);
            }
         }
         if(dataM.runAsMobile)
         {
            screensM.screenHangerMech.mechEquipment.removeEquipmentMarkers();
         }
      }
      
      private function equipAndUnEquipRefreshFunctions(param1:String) : void
      {
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:uint = screensM.screenHangerMech.getTargetMechID();
         dataM.updateMechStructure(dataM.player1PlayerID,_loc3_);
         var _loc4_:Boolean = false;
         switch(param1)
         {
            case "torso":
            case "leg":
            case "sideWeapon":
            case "topWeapon":
               _loc4_ = true;
         }
         screensM.screenHangerMech.mechEquipment.refreshEquipemnt(_loc4_,false);
         this.refreshItemTypesButtonsAndAmount();
         screensM.screenHangerMenu.refreshTutorial();
         screensM.screenHangerMech.refreshMechStats(0);
         screensM.screenHangerMenu.hangerEnabled = true;
         dataM.saveGuestData("hanger equipAndUnEquipRefreshFunctions");
      }
      
      public function equipItemFailed() : void
      {
         screensM.screenHangerMenu.hangerEnabled = true;
      }
      
      public function unequipItemLocally() : void
      {
         this.unequipItemSuccess();
      }
      
      public function unequipItemSuccess() : void
      {
         var _loc1_:BMPlayerItemData = null;
         var _loc2_:BMItemData = null;
         var _loc3_:BMPlayerData = null;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Boolean = false;
         if(screensM.isScreenOpened("screenHangerInventory"))
         {
            _loc3_ = dataM.playersData[dataM.player1PlayerID];
            _loc4_ = screensM.screenHangerMech.getTargetMechID();
            switch(this._equipItem_type)
            {
               case "mechToInventory":
                  _loc1_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._equipItem_originPlayerItemID);
                  _loc2_ = dataM.itemsDB[_loc1_.itemID];
                  _loc5_ = this._equipItem_tileID;
                  _loc6_ = false;
                  if(_loc2_.type == "torso")
                  {
                     _loc9_ = [{
                        "equipmentType":"torso",
                        "equipmentID":0
                     }];
                     if(_loc3_.mechStructures[_loc4_].leg > 0)
                     {
                        _loc9_.push({
                           "equipmentType":"leg",
                           "equipmentID":0
                        });
                     }
                     _loc10_ = 1;
                     while(_loc10_ <= dataM.maxEquipment["sideWeapon"])
                     {
                        if(_loc3_.mechStructures[_loc4_]["sideWeapon" + _loc10_] > 0)
                        {
                           _loc9_.push({
                              "equipmentType":"sideWeapon",
                              "equipmentID":_loc10_
                           });
                        }
                        _loc10_++;
                     }
                     _loc10_ = 1;
                     while(_loc10_ <= dataM.maxEquipment["topWeapon"])
                     {
                        if(_loc3_.mechStructures[_loc4_]["topWeapon" + _loc10_] > 0)
                        {
                           _loc9_.push({
                              "equipmentType":"topWeapon",
                              "equipmentID":_loc10_
                           });
                        }
                        _loc10_++;
                     }
                     _loc11_ = 0;
                     while(_loc11_ < _loc9_.length)
                     {
                        screensM.screenHangerMech.mechEquipment.mechView.activateUnequipAnimation(_loc9_[_loc11_].equipmentType,_loc9_[_loc11_].equipmentID);
                        _loc11_++;
                     }
                     this.mechEquipmentBreakApart();
                  }
                  else
                  {
                     _loc12_ = false;
                     switch(_loc1_.equipmentType)
                     {
                        case "leg":
                        case "sideWeapon":
                        case "topWeapon":
                           screensM.screenHangerMech.mechEquipment.mechView.activateUnequipAnimation(_loc1_.equipmentType,_loc1_.equipmentID);
                     }
                     _loc1_.equipped = 0;
                     _loc1_.equipmentID = 0;
                     _loc6_ = true;
                  }
                  _loc7_ = this._currentEquipmentType;
                  this._currentEquipmentType = dataM.shopItemTypesDB[dataM.shopItemTypesReverseDB[_loc1_.equipmentType]];
                  _loc8_ = false;
                  if(_loc7_ == this._currentEquipmentType)
                  {
                     _loc8_ = true;
                  }
                  if(dataM.tutorialEnabled == false)
                  {
                     this.itemTypeClickedSub(dataM.shopItemTypesReverseDB[_loc2_.type],false,_loc8_,false,-1,"unequipItemSuccess");
                     _loc6_ = true;
                  }
                  if(_loc6_)
                  {
                     this.addAndRefreshInventoryTileList("unequipItemSuccess",_loc8_);
                  }
            }
            _loc3_.updateMechsWeight();
            this.equipAndUnEquipRefreshFunctions(_loc1_.equipmentType);
            screensM.screenHangerMech.resetUnequipPointers();
         }
      }
      
      public function unequipItemFailed() : void
      {
         screensM.screenHangerMenu.hangerEnabled = true;
      }
      
      public function dragItem(param1:String, param2:BMItem, param3:Number, param4:String, param5:Number, param6:Boolean) : void
      {
         param2.x = -200;
         param2.y = -200;
         draggingM.activateDragging(param2,param6);
         draggingM.dragOrigin = param1;
         draggingM.dragTileID = param3;
         draggingM.dragEquipmentType = param4;
         draggingM.dragEquipmentID = param5;
         switch(param1)
         {
            case "inventory":
               if(dataM.runAsMobile)
               {
                  this.inventoryTileList.disableItems([param3],"tileID",true);
               }
               break;
            case "mech":
               screensM.screenHangerMech.mechEquipment.disableItems([{
                  "type":draggingM.dragEquipmentType,
                  "ID":draggingM.dragEquipmentID
               }]);
               break;
            case "fusion":
         }
         this._showDraggingFingerWithoutDragging = 0;
         tooltip.hideToolTip();
         if(dataM.runAsMobile)
         {
            this._inventoryFingerWheeling.removeMouseListeners();
         }
      }
      
      public function stopDraggingItem(param1:String) : void
      {
         if(draggingM.item != null)
         {
            switch(draggingM.dragOrigin)
            {
               case "inventory":
                  this.inventoryTileList.enableItems([draggingM.dragTileID],"tileID");
                  break;
               case "mech":
                  screensM.screenHangerMech.mechEquipment.enableItems([{
                     "type":draggingM.dragEquipmentType,
                     "ID":draggingM.dragEquipmentID
                  }]);
                  break;
               case "fusion":
            }
            draggingM.deactivateDragging();
            this.removeDraggingFinger();
         }
         if(screensM.screenHangerMenu.screenStatus == "mech")
         {
            screensM.screenHangerMech.clearItemMechRollOver(true,"stopDraggingItem");
         }
         if(dataM.runAsMobile)
         {
            if(screensM.screenHangerMenu.screenStatus == "mech")
            {
               screensM.screenHangerMech.refreshMechStats(0);
            }
            this._inventoryFingerWheeling.addMouseListeners();
         }
      }
      
      public function equipmentItemMouseDown(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:BMItem = null;
         if(screensM.screenHangerMenu.hangerEnabled)
         {
            _loc4_ = false;
            if(screensM.isScreenOpened("screenHangerItemComparison") == false)
            {
               switch(screensM.screenHangerMenu.screenStatus)
               {
                  case "none":
                  case "mech":
                     if(param3 > 0)
                     {
                        _loc4_ = true;
                     }
                     else if(param3 == -1)
                     {
                        this.itemTypeClickedSub(dataM.shopItemTypesReverseDB[param1],false,false,false,-1,"equipmentItemMouseDown");
                     }
               }
            }
            if(_loc4_)
            {
               _loc5_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,param3,"drag",true);
               this.dragItem("mech",_loc5_,-1,param1,param2,false);
               screensM.screenHangerMech.mechEquipment.addDisabledEffectForSpecificItem(param1,param2);
            }
         }
      }
      
      public function equipmentItemMouseUp(param1:String, param2:Number, param3:Number, param4:Boolean, param5:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:Boolean = false;
         var _loc10_:BMPlayerData = null;
         var _loc11_:BMMechStructure = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:BMPlayerItemData = null;
         var _loc15_:BMPlayerItemData = null;
         var _loc16_:BMItemData = null;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc23_:Boolean = false;
         var _loc24_:Boolean = false;
         var _loc25_:Boolean = false;
         var _loc26_:Boolean = false;
         var _loc27_:Number = NaN;
         var _loc28_:Boolean = false;
         var _loc29_:Number = NaN;
         var _loc30_:BMPlayerItemData = null;
         var _loc31_:BMItemData = null;
         var _loc32_:Number = NaN;
         var _loc33_:Boolean = false;
         var _loc34_:Number = NaN;
         var _loc35_:BMPlayerItemData = null;
         var _loc36_:BMItemData = null;
         var _loc37_:Boolean = false;
         var _loc38_:Boolean = false;
         var _loc39_:Boolean = false;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:uint = 0;
         var _loc43_:BMItem = null;
         if(screensM.screenHangerMenu.hangerEnabled)
         {
            if(draggingM.item != null)
            {
               _loc6_ = draggingM.dragOrigin;
               _loc7_ = draggingM.dragTileID;
               _loc8_ = screensM.screenHangerMech.getTargetMechID();
               switch(_loc6_)
               {
                  case "inventory":
                  case "mech":
                     _loc9_ = true;
                     if(dataM.tutorialEnabled && _loc6_ == "mech")
                     {
                        _loc9_ = false;
                     }
                     _loc10_ = dataM.playersData[dataM.player1PlayerID];
                     _loc11_ = _loc10_.mechStructures[_loc8_];
                     if(dataM.tutorialEnabled && _loc6_ == "inventory")
                     {
                        switch(screensM.screenHangerMenu.tutorialPhase)
                        {
                           case "equip_sideWeaponLevel0":
                              param2 = 1;
                              param3 = 0;
                              break;
                           case "equip_sideWeaponLevel1":
                              param2 = 2;
                              param3 = 0;
                              break;
                           case "equip_sideWeaponLevel2":
                              param2 = 1;
                              param3 = _loc11_.sideWeapon1;
                              break;
                           case "equip_sideWeaponLevel2Again":
                              param2 = 2;
                              param3 = _loc11_.sideWeapon2;
                              break;
                           case "equip_fromBox_module":
                              param2 = 2;
                              param3 = _loc11_.module2;
                        }
                     }
                     if(_loc9_)
                     {
                        _loc12_ = draggingM.item.ID;
                        _loc13_ = param3;
                        _loc14_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc12_);
                        _loc16_ = dataM.itemsDB[_loc14_.itemID];
                        _loc17_ = false;
                        if(param1 == _loc16_.type)
                        {
                           _loc17_ = true;
                        }
                        _loc18_ = false;
                        _loc19_ = false;
                        _loc20_ = false;
                        _loc21_ = false;
                        _loc22_ = false;
                        _loc23_ = false;
                        _loc24_ = false;
                        _loc25_ = false;
                        _loc26_ = false;
                        if(_loc17_)
                        {
                           switch(param1)
                           {
                              case "module":
                                 if(_loc16_.resist1 > 0 || _loc16_.resist2 > 0 || _loc16_.resist3 > 0)
                                 {
                                    _loc27_ = 1;
                                    while(_loc27_ <= dataM.maxEquipment["module"])
                                    {
                                       if(_loc27_ != param2)
                                       {
                                          _loc28_ = false;
                                          if(_loc6_ == "mech")
                                          {
                                             if(_loc27_ == _loc14_.equipmentID)
                                             {
                                                _loc28_ = true;
                                             }
                                          }
                                          if(_loc28_ == false)
                                          {
                                             _loc29_ = Number(_loc11_["module" + _loc27_]);
                                             if(_loc29_ > 0)
                                             {
                                                _loc30_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc29_);
                                                _loc31_ = dataM.itemsDB[_loc30_.itemID];
                                                if(_loc16_.resist1 > 0 && _loc31_.resist1 > 0 || _loc16_.resist2 > 0 && _loc31_.resist2 > 0 || _loc16_.resist3 > 0 && _loc31_.resist3 > 0)
                                                {
                                                   _loc17_ = false;
                                                   _loc18_ = true;
                                                }
                                             }
                                          }
                                       }
                                       _loc27_++;
                                    }
                                 }
                                 break;
                              case "kit":
                                 if(dataM.isPowerKit(_loc14_.itemID))
                                 {
                                    _loc25_ = true;
                                    _loc17_ = false;
                                 }
                                 else if(dataM.isColorKit(_loc14_.itemID))
                                 {
                                    _loc26_ = true;
                                    _loc17_ = false;
                                 }
                                 else
                                 {
                                    _loc32_ = 1;
                                    while(_loc32_ <= dataM.maxEquipment["kit"])
                                    {
                                       if(_loc32_ != param2)
                                       {
                                          _loc33_ = false;
                                          if(_loc6_ == "mech")
                                          {
                                             if(_loc32_ == _loc14_.equipmentID)
                                             {
                                                _loc33_ = true;
                                             }
                                          }
                                          if(_loc33_ == false)
                                          {
                                             _loc34_ = Number(_loc11_["kit" + _loc32_]);
                                             if(_loc34_ > 0)
                                             {
                                                _loc35_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc34_);
                                                _loc36_ = dataM.itemsDB[_loc35_.itemID];
                                                if(_loc16_.resist1 > 0 && _loc36_.resist1 > 0 || _loc16_.resist2 > 0 && _loc36_.resist2 > 0 || _loc16_.resist3 > 0 && _loc36_.resist3 > 0)
                                                {
                                                   _loc19_ = true;
                                                   _loc17_ = false;
                                                }
                                                else if(_loc16_.HPBase > 0 && _loc36_.HPBase > 0)
                                                {
                                                   _loc20_ = true;
                                                   _loc17_ = false;
                                                }
                                                else if(_loc16_.energyBase > 0 && _loc36_.energyBase > 0)
                                                {
                                                   _loc21_ = true;
                                                   _loc17_ = false;
                                                }
                                                else if(_loc16_.heatBase > 0 && _loc36_.heatBase > 0)
                                                {
                                                   _loc22_ = true;
                                                   _loc17_ = false;
                                                }
                                                else if(_loc16_.bullets > 0 && _loc36_.bullets > 0)
                                                {
                                                   _loc23_ = true;
                                                   _loc17_ = false;
                                                }
                                                else if(_loc16_.rockets > 0 && _loc36_.rockets > 0)
                                                {
                                                   _loc24_ = true;
                                                   _loc17_ = false;
                                                }
                                             }
                                          }
                                       }
                                       _loc32_++;
                                    }
                                 }
                           }
                        }
                        if(_loc17_)
                        {
                           switch(_loc6_)
                           {
                              case "inventory":
                                 this.stopDraggingItem("equipmentItemMouseUp inventory");
                                 this._equipItem_type = "inventoryToMech";
                                 this._equipItem_targetMechID = _loc8_;
                                 this._equipItem_originPlayerItemID = _loc12_;
                                 this._equipItem_targetPlayerItemID = _loc13_;
                                 this._equipItem_targetEquipmentID = param2;
                                 this._equipItem_tileID = _loc7_;
                                 screensM.screenHangerMenu.hangerEnabled = false;
                                 this.equipItemLocally();
                                 break;
                              case "mech":
                                 _loc37_ = false;
                                 _loc38_ = false;
                                 if(param4 && dataM.runAsMobile == false)
                                 {
                                    if(screensM.screenHangerMech.mechRollOverLastEquipmentType == _loc14_.equipmentType)
                                    {
                                       if(screensM.screenHangerMech.mechRollOverLastEquipmentID > 0)
                                       {
                                          if(screensM.screenHangerMech.mechRollOverLastEquipmentID == _loc14_.equipmentID)
                                          {
                                             _loc38_ = true;
                                          }
                                       }
                                       else
                                       {
                                          _loc38_ = true;
                                       }
                                    }
                                 }
                                 else if(_loc14_.equipmentType == param1)
                                 {
                                    if(_loc14_.equipmentID != param2)
                                    {
                                       _loc37_ = true;
                                    }
                                    else
                                    {
                                       _loc38_ = true;
                                    }
                                 }
                                 if(_loc37_)
                                 {
                                    this.stopDraggingItem("equipmentItemMouseUp mech sameEquipmentTypeOnly");
                                    this._equipItem_type = "mechToItself";
                                    this._equipItem_targetMechID = _loc8_;
                                    this._equipItem_originPlayerItemID = _loc12_;
                                    this._equipItem_originEquipmentID = _loc14_.equipmentID;
                                    this._equipItem_targetPlayerItemID = _loc13_;
                                    this._equipItem_targetEquipmentID = param2;
                                    screensM.screenHangerMenu.hangerEnabled = false;
                                    this.equipItemLocally();
                                 }
                                 else if(_loc38_)
                                 {
                                    if(dataM.runAsMobile)
                                    {
                                       this.stopDraggingItem("equipmentMouseUp >> clickedForMobile");
                                       screensM.screenHangerMech.equipmentItemClicked(_loc14_.equipmentType,_loc14_.equipmentID,_loc14_.playerItemID);
                                    }
                                    else
                                    {
                                       this.inventoryItemMouseUpSub(this.inventoryTileList.highestTileID,false);
                                    }
                                 }
                                 else if(_loc14_.equipmentType == param1 && _loc14_.equipmentID == param2)
                                 {
                                    this.inventoryItemMouseUpSub(this.inventoryTileList.highestTileID,true);
                                 }
                           }
                        }
                        else
                        {
                           if(_loc18_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("resistanceModuleBlock",-1,-1);
                           }
                           else if(_loc19_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("resistanceKitBlock",-1,-1);
                           }
                           else if(_loc20_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("repairKitBlock",-1,-1);
                           }
                           else if(_loc21_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("energyKitBlock",-1,-1);
                           }
                           else if(_loc22_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("coolingKitBlock",-1,-1);
                           }
                           else if(_loc23_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("bulletsKitBlock",-1,-1);
                           }
                           else if(_loc24_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("rocketsKitBlock",-1,-1);
                           }
                           else if(_loc25_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("powerKitBlock",-1,-1);
                           }
                           else if(_loc26_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("colorKitBlock",-1,-1);
                           }
                           screensM.screenHangerMech.mechEquipment.removeEquipmentMarkers();
                        }
                     }
                     else
                     {
                        this.stopDraggingItem("equipmentItemMouseUp dragDropAllowed false");
                     }
               }
               if(dataM.useItemComparisonOnMechItemRollOver)
               {
                  if(screensM.isScreenOpened("screenHangerItemComparison"))
                  {
                     screensM.screenHangerItemComparison.removeMe();
                  }
                  screensM.screenHangerMech.showMechStats();
               }
            }
            else if(dataM.tutorialEnabled == false)
            {
               _loc39_ = false;
               _loc40_ = 0;
               if(param3 == 0)
               {
                  if(screensM.isScreenOpened("screenHangerItemComparison"))
                  {
                     _loc39_ = true;
                  }
                  else if(this.btnItemType1.visible)
                  {
                     this.itemTypeClickedSub(dataM.shopItemTypesReverseDB[param1],true,false,false,-1,"equipmentItemMouseUp");
                  }
               }
               else if(screensM.isScreenOpened("screenHangerItemComparison"))
               {
                  _loc39_ = true;
                  _loc40_ = param3;
               }
               if(dataM.useItemComparisonOnInventoryItemClick && _loc39_)
               {
                  _loc41_ = screensM.screenHangerItemComparison.getInventoryPlayerItemID();
                  _loc42_ = this.inventoryTileList.findTileIDByTileListItemID(_loc41_);
                  _loc43_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc41_,"drag",true);
                  screensM.screenHangerItemComparison.removeMe();
                  screensM.screenHangerMech.showAllAvailableItems();
                  this.dragItem("inventory",_loc43_,_loc42_,"",-1,false);
                  this._equipItem_targetPlayerItemID = 0;
                  this.equipmentItemMouseUp(param1,param2,_loc40_,false,"hangerInventory equipmentItemMouseUp");
               }
            }
         }
      }
      
      public function equipmentItemMouseOver(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:BMPlayerItemData = null;
         if(draggingM.item == null)
         {
            _loc4_ = false;
            if(param3 > 0)
            {
               if(dataM.useItemComparisonOnInventoryItemClick)
               {
                  if(screensM.isScreenOpened("screenHangerItemComparison"))
                  {
                     _loc4_ = true;
                  }
               }
               if(_loc4_)
               {
                  this.openItemComparisonScreen(param3,0);
               }
               else
               {
                  _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                  if(_loc5_.tutorialLevel > 2)
                  {
                     tooltip.showToolTip("inventory","",param3,-1);
                     screensM.screenHangerMech.mechEquipment.addItemStaticGlow(param1,param2);
                  }
               }
            }
            else
            {
               if(dataM.useItemComparisonOnInventoryItemClick)
               {
                  if(screensM.isScreenOpened("screenHangerItemComparison"))
                  {
                     _loc4_ = true;
                  }
               }
               if(_loc4_)
               {
                  this.openItemComparisonScreen(0,0);
               }
               else
               {
                  tooltip.showToolTip("regularText",getScreenText("slot_" + param1),-1,-1);
               }
            }
            screensM.screenHangerMech.mouseOverEquipmentItems = true;
            screensM.screenHangerMech.clearItemMechRollOver(false,"equipmentItemMouseOver");
         }
         else if(dataM.useItemComparisonOnMechItemRollOver)
         {
            if(param3 > 0)
            {
               if(param3 != draggingM.item.ID)
               {
                  _loc6_ = dataM.getPlayerItemData(dataM.player1PlayerID,draggingM.item.ID);
                  if(_loc6_.equipmentType == param1)
                  {
                     this.openItemComparisonScreen(param3,draggingM.item.ID);
                  }
               }
            }
         }
      }
      
      public function equipmentItemMouseOut(param1:String, param2:Number, param3:Number) : void
      {
         tooltip.hideToolTip();
         screensM.screenHangerMech.mechEquipment.removeAllItemsStaticGlow();
         screensM.screenHangerMech.mouseOverEquipmentItems = false;
         if(dataM.useItemComparisonOnMechItemRollOver)
         {
            if(screensM.isScreenOpened("screenHangerItemComparison"))
            {
               screensM.screenHangerItemComparison.removeMe();
            }
            screensM.screenHangerMech.showMechStats();
         }
      }
      
      public function mouseUpOutsideEquipment() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:BMPlayerData = null;
         var _loc9_:BMMechStructure = null;
         var _loc10_:Number = NaN;
         var _loc11_:BMItemData = null;
         var _loc1_:Boolean = true;
         if(draggingM.item != null)
         {
            _loc2_ = draggingM.item.ID;
            _loc3_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc2_);
            _loc4_ = screensM.screenHangerMech.mechRollOverLastEquipmentType;
            _loc5_ = screensM.screenHangerMech.mechRollOverLastEquipmentID;
            _loc6_ = screensM.screenHangerMech.getTargetMechID();
            if(_loc4_ != "")
            {
               if(_loc3_.equipmentType == _loc4_)
               {
                  switch(_loc4_)
                  {
                     case "torso":
                     case "leg":
                        _loc7_ = screensM.screenHangerMech.mechRollOverLastEquipmentType;
                        _loc8_ = dataM.playersData[dataM.player1PlayerID];
                        _loc9_ = _loc8_.mechStructures[_loc6_];
                        _loc10_ = Number(_loc9_[_loc7_]);
                        this.equipmentItemMouseUp(_loc4_,_loc5_,_loc10_,true,"mouseUpOutsideEquipment");
                        break;
                     default:
                        if(_loc3_.equipmentID != _loc5_)
                        {
                           _loc7_ = _loc4_;
                           if(screensM.screenHangerMech.mechRollOverLastEquipmentID > 0)
                           {
                              _loc7_ = _loc4_ + _loc5_;
                           }
                           _loc8_ = dataM.playersData[dataM.player1PlayerID];
                           _loc9_ = _loc8_.mechStructures[_loc6_];
                           _loc10_ = Number(_loc9_[_loc7_]);
                           this.equipmentItemMouseUp(_loc4_,_loc5_,_loc10_,true,"mouseUpOutsideEquipment");
                        }
                        else
                        {
                           this.stopDraggingItem("mouseUpOutsideEquipment");
                        }
                  }
                  _loc1_ = false;
               }
               else if(screensM.screenHangerMech.draggingItemFromMechEquipment)
               {
                  _loc11_ = dataM.itemsDB[_loc3_.itemID];
                  switch(_loc11_.type)
                  {
                     case "torso":
                     case "leg":
                        break;
                     default:
                        this.inventoryItemMouseUpSub(this.inventoryTileList.highestTileID,true);
                  }
                  _loc1_ = false;
               }
            }
            else if(screensM.screenHangerMech.draggingItemFromMechEquipment)
            {
               this.inventoryItemMouseUpSub(this.inventoryTileList.highestTileID,true);
               _loc1_ = false;
            }
         }
         if(_loc1_)
         {
            this.dropItemAtClosestEquipment();
         }
      }
      
      public function mouseDownOutsideEquipment() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc4_:BMPlayerData = null;
         var _loc5_:uint = 0;
         var _loc6_:BMMechStructure = null;
         var _loc7_:Number = NaN;
         var _loc8_:BMMechView = null;
         if(screensM.screenHangerMech.mechRollOverLastEquipmentType != "")
         {
            _loc1_ = screensM.screenHangerMech.mechRollOverLastEquipmentType;
            _loc2_ = screensM.screenHangerMech.mechRollOverLastEquipmentType;
            _loc3_ = screensM.screenHangerMech.mechRollOverLastEquipmentID;
            if(_loc3_ > 0)
            {
               _loc1_ = _loc2_ + _loc3_;
            }
            _loc4_ = dataM.playersData[dataM.player1PlayerID];
            _loc5_ = screensM.screenHangerMech.getTargetMechID();
            _loc6_ = _loc4_.mechStructures[_loc5_];
            _loc7_ = Number(_loc6_[_loc1_]);
            screensM.screenHangerMech.draggingItemFromMechEquipment = true;
            this.equipmentItemMouseDown(_loc2_,_loc3_,_loc7_);
            _loc8_ = screensM.screenHangerMech.mechEquipment.mechView;
            _loc8_.addItemStaticGlow(_loc1_,"strongGreen");
            _loc8_.addItemStaticGlowLock(_loc1_);
         }
      }
      
      public function mouseOverOutsideEquipment() : void
      {
      }
      
      public function mouseOutOutsideEquipment() : void
      {
         tooltip.hideToolTip();
      }
      
      public function mechEquipmentBreakApart() : void
      {
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:uint = 0;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:uint = 0;
         while(_loc2_ < this._currentPlayerData.items.length)
         {
            _loc3_ = this._currentPlayerData.items[_loc2_];
            _loc4_ = screensM.screenHangerMech.getTargetMechID();
            if(_loc3_.equipped == _loc4_)
            {
               if(_loc3_.equipmentType == "torso")
               {
                  _loc3_.equipped = 0;
                  _loc3_.equipmentID = 0;
               }
            }
            _loc2_++;
         }
         dataM.updateMechStructure(dataM.player1PlayerID,1);
         screensM.screenHangerMech.mechEquipment.refreshEquipemnt(true,false);
         this.addAndRefreshInventoryTileList("mechEquipmentBreakApart",false);
      }
      
      private function dropItemAtClosestEquipment() : void
      {
         var _loc1_:String = null;
         var _loc2_:BMPlayerData = null;
         var _loc3_:uint = 0;
         var _loc4_:BMMechStructure = null;
         var _loc5_:Number = NaN;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         var _loc8_:Boolean = false;
         var _loc9_:BMPlayerProfile = null;
         var _loc10_:String = null;
         if(draggingM.item != null)
         {
            _loc1_ = draggingM.dragOrigin;
            _loc2_ = dataM.playersData[dataM.player1PlayerID];
            _loc3_ = screensM.screenHangerMech.getTargetMechID();
            _loc4_ = _loc2_.mechStructures[_loc3_];
            switch(_loc1_)
            {
               case "inventory":
               case "mech":
                  _loc5_ = draggingM.item.ID;
                  _loc6_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc5_);
                  _loc7_ = dataM.itemsDB[_loc6_.itemID];
                  if(_loc7_.type == "torso")
                  {
                     this.equipmentItemMouseUp("torso",0,_loc4_.torso,true,"dropItemAtClosestEquipment");
                  }
                  else
                  {
                     _loc8_ = true;
                     _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                     _loc10_ = _loc7_.type;
                     switch(_loc7_.type)
                     {
                        case "sideWeapon":
                        case "topWeapon":
                        case "kit":
                        case "module":
                           _loc10_ += "1";
                     }
                     if(_loc9_.level < dataM.equipmentUnlockDB[_loc10_].level)
                     {
                        _loc8_ = false;
                     }
                     if(_loc8_)
                     {
                        switch(_loc7_.type)
                        {
                           case "leg":
                           case "drone":
                           case "shield":
                           case "teleport":
                           case "charge":
                           case "harpoon":
                           case "perk":
                              this.equipmentItemMouseUp(_loc7_.type,0,_loc4_[_loc7_.type],true,"dropItemAtClosestEquipment");
                              break;
                           case "sideWeapon":
                           case "topWeapon":
                           case "kit":
                           case "module":
                              this.dropItemAtClosestEquipmentSub(_loc7_.type,_loc4_,_loc5_);
                        }
                     }
                     this.stopDraggingItem("dropItemAtClosestEquipment");
                  }
            }
         }
      }
      
      private function dropItemAtClosestEquipmentSub(param1:String, param2:BMMechStructure, param3:Number) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Number = NaN;
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc8_:Boolean = false;
         _loc5_ = uint(dataM.maxEquipment[param1]);
         var _loc10_:uint = 1;
         while(_loc10_ <= _loc5_)
         {
            _loc6_ = true;
            _loc11_ = false;
            switch(param1)
            {
               case "sideWeapon":
               case "topWeapon":
               case "kit":
               case "module":
                  _loc11_ = true;
                  _loc9_ = dataM.getEquipmentUnlockByLevel(_loc4_.level,param1);
                  if(_loc10_ > _loc9_)
                  {
                     _loc6_ = false;
                  }
            }
            if(_loc6_)
            {
               if(_loc11_)
               {
                  _loc7_ = Number(param2[param1 + _loc10_]);
               }
               else
               {
                  _loc7_ = Number(param2[param1]);
               }
               _loc12_ = false;
               if(_loc7_ > 0)
               {
                  if(_loc7_ != param3 && draggingM.dragOrigin == "mech")
                  {
                     _loc12_ = true;
                  }
               }
               else
               {
                  _loc12_ = true;
               }
               if(_loc12_)
               {
                  this.equipmentItemMouseUp(param1,_loc10_,_loc7_,true,"dropItemAtClosestEquipmentSub");
                  _loc8_ = true;
                  _loc10_ = _loc5_;
               }
            }
            _loc10_++;
         }
         if(_loc8_ == false)
         {
            switch(param1)
            {
               case "sideWeapon":
               case "topWeapon":
               case "kit":
               case "module":
                  _loc6_ = false;
                  _loc13_ = 1;
                  _loc9_ = dataM.getEquipmentUnlockByLevel(_loc4_.level,param1);
                  if(_loc13_ <= _loc9_)
                  {
                     _loc6_ = true;
                  }
                  if(_loc6_)
                  {
                     _loc7_ = Number(param2[param1 + _loc13_]);
                     this.equipmentItemMouseUp(param1,_loc13_,_loc7_,true,"dropItemAtClosestEquipmentSub");
                  }
            }
         }
      }
      
      public function refreshItemTypesButtonsAndAmount() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TextField = null;
         var _loc5_:Array = null;
         var _loc6_:BMPlayerData = null;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:BMPlayerItemData = null;
         var _loc11_:Boolean = false;
         var _loc12_:uint = 0;
         var _loc13_:Boolean = false;
         var _loc14_:Number = NaN;
         var _loc15_:Array = null;
         var _loc16_:Boolean = false;
         var _loc17_:Array = null;
         var _loc18_:String = null;
         var _loc19_:uint = 0;
         var _loc20_:Sprite = null;
         var _loc21_:BMButton_pictureE = null;
         var _loc22_:BMItemData = null;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:Array = new Array();
         if(screensM.isScreenOpened("screenHangerFusion"))
         {
            _loc4_ = screensM.screenHangerFusion.getEquippedPlayerItemIDs();
         }
         if(dataM.tutorialEnabled && _loc3_.winsVSComputer < 1)
         {
            this.hideAllItemTypeInterface();
         }
         else
         {
            _loc5_ = new Array();
            _loc6_ = dataM.playersData[dataM.player1PlayerID];
            _loc1_ = 0;
            while(_loc1_ < dataM.shopItemTypesDB.length)
            {
               _loc5_[dataM.shopItemTypesDB[_loc1_]] = 0;
               _loc1_++;
            }
            _loc7_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc6_.items.length)
            {
               _loc10_ = _loc6_.items[_loc8_];
               _loc11_ = false;
               _loc12_ = 0;
               while(_loc12_ < _loc4_.length)
               {
                  if(_loc10_.playerItemID == _loc4_[_loc12_])
                  {
                     _loc11_ = true;
                  }
                  _loc12_++;
               }
               if(_loc11_ == false)
               {
                  _loc13_ = false;
                  switch(_loc10_.equipmentType)
                  {
                     case "torso":
                     case "leg":
                     case "sideWeapon":
                     case "topWeapon":
                     case "drone":
                     case "teleport":
                     case "charge":
                     case "harpoon":
                        _loc13_ = true;
                  }
                  if(_loc10_.equipped == 0 || screensM.screenHangerMenu.screenStatus == "fusion" && _loc10_.equipped >= 1 && _loc13_)
                  {
                     _loc14_ = Number(dataM.shopItemTypesReverseDB[_loc10_.equipmentType]);
                     ++_loc5_[dataM.shopItemTypesDB[_loc14_]];
                     _loc7_++;
                  }
               }
               _loc8_++;
            }
            _loc9_ = this.MAX_ITEMS_VISIBLE_IN_INVENTORY;
            if(dataM.runAsMobile)
            {
               _loc9_ = this.MAX_ITEMS_VISIBLE_IN_INVENTORY_MOBILE;
            }
            if(_loc7_ <= _loc9_ && (screensM.screenHangerMenu.screenStatus == "fusion" || screensM.screenHangerMenu.screenStatus == "mech"))
            {
               this.hideAllItemTypeInterface();
            }
            else
            {
               _loc15_ = new Array();
               _loc1_ = 0;
               while(_loc1_ < dataM.shopItemTypesDB.length)
               {
                  _loc16_ = false;
                  _loc17_ = new Array();
                  _loc18_ = dataM.shopItemTypesDB[_loc1_];
                  switch(_loc18_)
                  {
                     case "torsoLeg":
                        _loc17_.push("torso");
                        _loc17_.push("leg");
                        break;
                     case "specialModule":
                        _loc17_.push("drone");
                        _loc17_.push("shield");
                        _loc17_.push("teleport");
                        _loc17_.push("charge");
                        _loc17_.push("harpoon");
                        _loc17_.push("module");
                        break;
                     case "special":
                        _loc17_.push("drone");
                        _loc17_.push("shield");
                        _loc17_.push("teleport");
                        _loc17_.push("charge");
                        _loc17_.push("harpoon");
                        break;
                     default:
                        _loc17_.push(_loc18_);
                  }
                  _loc19_ = 0;
                  while(_loc19_ < _loc17_.length)
                  {
                     for each(_loc22_ in dataM.itemsDB)
                     {
                        if(_loc16_ == false)
                        {
                           if(_loc22_.type == _loc17_[_loc19_] && _loc22_.level <= _loc3_.level)
                           {
                              _loc16_ = true;
                              _loc19_ = _loc17_.length;
                           }
                        }
                     }
                     _loc19_++;
                  }
                  _loc2_ = this["txtItemType" + (_loc1_ + 1) + "Items"];
                  _loc15_.push(this["txtItemType" + (_loc1_ + 1) + "Items"]);
                  _loc20_ = this["mcLocked" + (_loc1_ + 1)];
                  _loc21_ = this["btnItemType" + (_loc1_ + 1)];
                  if(_loc16_ && _loc3_.winsVSComputer < dataM.TUTORIAL_BATTLES)
                  {
                     if(_loc17_[0] == "leg" || _loc17_[0] == "topWeapon" || _loc17_[0] == "module")
                     {
                        _loc16_ = false;
                     }
                  }
                  if(_loc16_)
                  {
                     _loc20_.visible = false;
                     _loc21_.visible = true;
                  }
                  else
                  {
                     _loc20_.visible = true;
                     _loc21_.visible = false;
                  }
                  if(_loc16_ && _loc7_ > _loc9_)
                  {
                     _loc2_.text = String(_loc5_[_loc18_]);
                  }
                  else
                  {
                     _loc2_.text = "";
                  }
                  _loc1_++;
               }
               if(dataM.runAsMobile)
               {
                  screensM.createMultipleTextsBitmap("hangerInventory_subTypes",_loc15_,"",this);
               }
               this.setItemTypeButtonMarkerPosition(dataM.shopItemTypesReverseDB[this._currentEquipmentType]);
            }
         }
      }
      
      public function itemTypeClicked(param1:uint) : void
      {
         if(this._currentEquipmentType != dataM.shopItemTypesDB[param1 - 1])
         {
            this.itemTypeClickedSub(param1 - 1,true,false,true,-1,"itemTypeClicked");
         }
      }
      
      public function getCurrentEquipmentType() : String
      {
         return this._currentEquipmentType;
      }
      
      public function itemTypeClickedSub(param1:uint, param2:Boolean, param3:Boolean, param4:Boolean, param5:Number, param6:String) : void
      {
         if(screensM.isScreenOpened("screenHangerItemComparison"))
         {
            screensM.screenHangerMech.showAllAvailableItems();
            screensM.screenHangerMech.showMechStats();
            if(screensM.isScreenOpened("screenHangerItemComparison"))
            {
               screensM.screenHangerItemComparison.removeMe();
            }
            screensM.screenHangerMech.mechEquipment.removeEquipmentMarkers();
         }
         if(this._currentEquipmentType != dataM.shopItemTypesDB[param1] || param5 > -1)
         {
            if(dataM.runAsMobile)
            {
               this._currentPage = 0;
               if(param5 > -1)
               {
                  this._currentPage = param5;
               }
            }
            this._currentEquipmentType = dataM.shopItemTypesDB[param1];
            this.setItemTypeButtonMarkerPosition(param1);
            if(param2)
            {
               this.addAndRefreshInventoryTileList("itemTypeClickedSub",param3);
            }
            else
            {
               this.inventoryTileList.deactivateGuideArrow();
            }
            screensM.screenHangerMenu.refreshTutorial();
         }
      }
      
      private function setItemTypeButtonMarkerPosition(param1:Number) : void
      {
         var _loc2_:BMButton_pictureE = null;
         if(param1 == -1)
         {
            this.mcItemTypeButtonMarker.visible = false;
         }
         else
         {
            _loc2_ = this["btnItemType" + (param1 + 1)];
            this.mcItemTypeButtonMarker.x = _loc2_.x;
            this.mcItemTypeButtonMarker.y = _loc2_.y;
            if(_loc2_.visible)
            {
               this.mcItemTypeButtonMarker.visible = true;
            }
         }
      }
      
      public function hideAllItemTypeInterface() : void
      {
         var _loc1_:uint = 0;
         var _loc3_:BMButton_pictureE = null;
         var _loc4_:Sprite = null;
         var _loc5_:TextField = null;
         _loc1_ = 1;
         while(_loc1_ <= dataM.shopItemTypesDB.length)
         {
            _loc3_ = this["btnItemType" + _loc1_];
            _loc3_.visible = false;
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.shopItemTypesDB.length)
         {
            _loc4_ = this["mcLocked" + _loc1_];
            _loc4_.visible = false;
            _loc1_++;
         }
         var _loc2_:Array = new Array();
         _loc1_ = 1;
         while(_loc1_ <= dataM.shopItemTypesDB.length)
         {
            _loc5_ = this["txtItemType" + _loc1_ + "Items"];
            _loc5_.text = "";
            if(dataM.runAsMobile)
            {
               _loc2_.push(this["txtItemType" + _loc1_ + "Items"]);
            }
            _loc1_++;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerInventory_subTypes",_loc2_,"",this);
         }
         this.mcItemTypeButtonMarker.visible = false;
      }
      
      private function itemType1ButtonMouseOver(param1:Number) : void
      {
         this.itemTypeButtonMouseOverSub(1);
      }
      
      private function itemType2ButtonMouseOver(param1:Number) : void
      {
         this.itemTypeButtonMouseOverSub(2);
      }
      
      private function itemType3ButtonMouseOver(param1:Number) : void
      {
         this.itemTypeButtonMouseOverSub(3);
      }
      
      private function itemType4ButtonMouseOver(param1:Number) : void
      {
         this.itemTypeButtonMouseOverSub(4);
      }
      
      private function itemType5ButtonMouseOver(param1:Number) : void
      {
         this.itemTypeButtonMouseOverSub(5);
      }
      
      public function itemTypeButtonMouseOverSub(param1:Number) : void
      {
         tooltip.showToolTip("regularText",getScreenText(dataM.shopItemTypesDB[param1 - 1]),-1,-1);
      }
      
      private function itemTypeButtonMouseOut(param1:Number) : void
      {
         tooltip.hideToolTip();
      }
      
      private function draggingFingerMouseUp(param1:MouseEvent) : void
      {
         if(screensM.isScreenOpened("screenHangerFusion"))
         {
            if(screensM.isSpriteInCoordinates(screensM.screenHangerFusion.targetHitArea,0,0))
            {
               screensM.screenHangerFusion.targetHitAreaMouseUpSub();
            }
            else if(screensM.isSpriteInCoordinates(screensM.screenHangerFusion.generalHitArea,0,0))
            {
               screensM.screenHangerFusion.generalHitAreaMouseUpSub();
            }
         }
         else if(screensM.isSpriteInCoordinates(screensM.screenHangerMech.mechEquipment.mouseHitArea,screensM.screenHangerMech.mechEquipment.x,screensM.screenHangerMech.mechEquipment.y))
         {
            screensM.screenHangerMech.mechEquipment.mouseHitAreaMouseUpSub();
         }
      }
      
      public function itemCardsScreenClosed() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(parent != null)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc1_.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_MECH1)
            {
               this._showDraggingFingerWithoutDragging = 2;
            }
         }
      }
      
      private function draggingTutorialAnimationHandler() : void
      {
         var _loc1_:String = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(dataM.tutorialEnabled)
         {
            _loc1_ = screensM.screenHangerMenu.tutorialPhase;
            if(draggingM.item != null || this._showDraggingFingerWithoutDragging > 0)
            {
               switch(_loc1_)
               {
                  case "equip_torsoLevel0":
                  case "fusion_equipTargetItem":
                  case "fusion_equipSourceTorso1":
                  case "fusion_equipSourceLeg1":
                  case "fusion_equipSourceWeapon1":
                     if(this.mcDraggingFinger.parent == null)
                     {
                        addChild(this.mcDraggingFinger);
                        this.resetDraggingFinger(true);
                        this.inventoryTileList.deactivateGuideArrow();
                        this.inventoryTileList.deactivateAllAnimatedMarkers();
                     }
                     switch(screensM.screenHangerMenu.tutorialPhase)
                     {
                        case "equip_torsoLevel0":
                           _loc2_ = 270;
                           _loc3_ = 6;
                           _loc4_ = 2.9;
                           if(this.mcDraggingFinger.currentLabel != "torso1")
                           {
                              this.mcDraggingFinger.gotoAndStop("torso1");
                           }
                           break;
                        case "fusion_equipTargetItem":
                           _loc2_ = 340;
                           _loc3_ = 7.5;
                           _loc4_ = 3;
                           if(this.mcDraggingFinger.currentLabel != "torso2")
                           {
                              this.mcDraggingFinger.gotoAndStop("torso2");
                           }
                           break;
                        case "fusion_equipSourceTorso1":
                           _loc2_ = 134;
                           _loc3_ = 9;
                           _loc4_ = 1.15;
                           if(this.mcDraggingFinger.currentLabel != "torso1")
                           {
                              this.mcDraggingFinger.gotoAndStop("torso1");
                           }
                           break;
                        case "fusion_equipSourceLeg1":
                           _loc2_ = 134;
                           _loc3_ = 9;
                           _loc4_ = 1.15;
                           if(this.mcDraggingFinger.currentLabel != "leg1")
                           {
                              this.mcDraggingFinger.gotoAndStop("leg1");
                           }
                           break;
                        case "fusion_equipSourceWeapon1":
                           _loc2_ = 134;
                           _loc3_ = 9;
                           _loc4_ = 1.15;
                           if(this.mcDraggingFinger.currentLabel != "weapon1")
                           {
                              this.mcDraggingFinger.gotoAndStop("weapon1");
                           }
                     }
                     if(this.mcDraggingFinger.x > _loc2_)
                     {
                        this.mcDraggingFinger.x -= _loc3_;
                        this.mcDraggingFinger.y += _loc4_;
                        if(this.mcDraggingFinger.alpha < 1)
                        {
                           this.mcDraggingFinger.alpha += 0.2;
                        }
                     }
                     else if(this._draggingFingerDelayFrames < 30)
                     {
                        ++this._draggingFingerDelayFrames;
                        if(this._draggingFingerDelayFrames >= 26)
                        {
                           this.mcDraggingFinger.alpha -= 0.2;
                        }
                     }
                     else
                     {
                        this.resetDraggingFinger(true);
                        --this._showDraggingFingerWithoutDragging;
                     }
               }
            }
         }
      }
      
      private function resetDraggingFinger(param1:Boolean) : void
      {
         if(param1 || draggingM.item != null)
         {
            this._draggingFingerDelayFrames = 0;
            switch(screensM.screenHangerMenu.tutorialPhase)
            {
               case "fusion_equipTargetItem":
                  this.mcDraggingFinger.x = 570;
                  this.mcDraggingFinger.y = 120;
                  break;
               case "fusion_equipSourceTorso1":
               case "fusion_equipSourceLeg1":
               case "fusion_equipSourceWeapon1":
                  if(dataM.runAsMobile)
                  {
                     this.mcDraggingFinger.x = 574;
                     this.mcDraggingFinger.y = 175;
                  }
                  else
                  {
                     this.mcDraggingFinger.x = 500;
                     this.mcDraggingFinger.y = 175;
                  }
                  break;
               default:
                  this.mcDraggingFinger.x = 500;
                  this.mcDraggingFinger.y = 120;
            }
            this.mcDraggingFinger.alpha = 0;
         }
      }
      
      private function removeDraggingFinger() : void
      {
         if(this.mcDraggingFinger.parent != null)
         {
            this.mcDraggingFinger.parent.removeChild(this.mcDraggingFinger);
            this.resetDraggingFinger(false);
            screensM.screenHangerMenu.refreshTutorial();
         }
      }
      
      public function changeMechsOrderScreenOpened() : void
      {
         TsLogger.log("changeMechsOrderScreenOpened");
         if(dataM.runAsMobile)
         {
            if(this._inventoryFingerWheeling != null)
            {
               this._inventoryFingerWheeling.removeMouseListeners();
            }
         }
      }
      
      public function changeMechsOrderScreenClosed() : void
      {
         TsLogger.log("changeMechsOrderScreenClosed");
         if(dataM.runAsMobile)
         {
            if(this._inventoryFingerWheeling != null)
            {
               this._inventoryFingerWheeling.addMouseListeners();
            }
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._inventoryFingerWheeling.cancelFingerWheeling();
         }
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened("screenHangerInventory"))
         {
            screensM.removeScreen("screenHangerInventory");
            if(dataM.runAsMobile)
            {
               this._inventoryFingerWheeling.removeMouseListeners();
            }
            this.inventoryTileList.removeMe();
            this.inventoryTileList = null;
         }
      }
   }
}

