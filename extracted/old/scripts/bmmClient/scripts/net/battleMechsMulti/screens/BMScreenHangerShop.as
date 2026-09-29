package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureA;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1096")]
   public class BMScreenHangerShop extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcItemsTileListHolder:Sprite;
      
      public var mcSubTypeTileListHolder:Sprite;
      
      public var mcSizer_subTypeTileList:Sprite;
      
      public var mcSizer_itemsTileList:Sprite;
      
      public var mcSizer_btnItemsLeft:Sprite;
      
      public var mcSizer_btnItemsRight:Sprite;
      
      public var mcFingerWheelingItemsHitArea:Sprite;
      
      public var mcFingerWheelingTypesHitArea:Sprite;
      
      public var btnItemsLeft:BMButton_pictureA;
      
      public var btnItemsRight:BMButton_pictureA;
      
      public var subTypeTileList:BMTileList;
      
      public var itemsTileList:BMTileList;
      
      private var _shopType:String;
      
      private var fingerWheelingItems:BMFingerWheeling;
      
      private var fingerWheelingTypes:BMFingerWheeling;
      
      private var _currentPlayerData:BMPlayerData;
      
      private var _selectedItemID:Number;
      
      private var _maxItemsInDisplay:uint;
      
      private var _subTypeTotalPages:Number;
      
      private var _currentPage:uint;
      
      private var _totalItemsInSubType:uint;
      
      private var _targetSubType:String = "";
      
      private var _shopJumpToTileID:Number;
      
      private var _itemsFinalSortIDs:Object;
      
      private var _itemsFinalSortIDs_myth:Object;
      
      private var _itemPagesByLevels:Object;
      
      private var _activateItemsLeftClicked:Boolean = false;
      
      private var _activateItemsRightClicked:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      private const SUB_TYPE_ITEM_WIDTH:Number = 220;
      
      private const SUB_TYPE_ITEM_HEIGHT:Number = 70;
      
      private const SUB_TYPE_ROWS:Number = 6;
      
      private const SUB_TYPE_ITEM_WIDTH_MOBILE:Number = 230;
      
      private const SUB_TYPE_ITEM_HEIGHT_MOBILE:Number = 66;
      
      private const SUB_TYPE_ROWS_MOBILE:Number = 6;
      
      private const ITEMS_TILE_LIST_ROWS:Number = 5;
      
      private const ITEMS_TILE_LIST_COLUMNS:Number = 5;
      
      private const ITEMS_TILE_LIST_ROWS_MOBILE:Number = 4;
      
      private const ITEMS_TILE_LIST_COLUMNS_MOBILE:Number = 5;
      
      public function BMScreenHangerShop()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("tooltip");
      }
      
      public function refreshScreen(param1:String = "regular") : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this._firstRefresh)
         {
            _loc5_ = this.ITEMS_TILE_LIST_ROWS;
            _loc6_ = this.ITEMS_TILE_LIST_COLUMNS;
            if(dataM.runAsMobile)
            {
               _loc5_ = this.ITEMS_TILE_LIST_ROWS_MOBILE;
               _loc6_ = this.ITEMS_TILE_LIST_COLUMNS_MOBILE;
            }
            this._maxItemsInDisplay = _loc5_ * _loc6_;
            if(dataM.runAsMobile)
            {
               this.mcSizer_btnItemsLeft.y = 500;
               this.mcSizer_btnItemsRight.y = 500;
               this.fingerWheelingItems = new BMFingerWheeling();
               this.fingerWheelingItems.initialize("shop_items",this.itemsTileList,this.mcFingerWheelingItemsHitArea,this.shopItemMouseClicked,null,false);
               addChild(this.fingerWheelingItems);
               this.fingerWheelingTypes = new BMFingerWheeling();
               this.fingerWheelingTypes.initialize("shop_subTypes",this.subTypeTileList,this.mcFingerWheelingTypesHitArea,this.subTypeClicked,null,false);
               addChild(this.fingerWheelingTypes);
               screensM.createButtonFromSizer("screenHangerShop","btnItemsLeft","pictureA");
               screensM.createButtonFromSizer("screenHangerShop","btnItemsRight","pictureA");
               this.btnItemsLeft.initialize("","",externalAssetsM.getAsset("general","interface_arrowLeft"),null,null,dataM.runAsMobile);
               this.btnItemsRight.initialize("","",externalAssetsM.getAsset("general","interface_arrowRight"),null,null,dataM.runAsMobile);
               this.btnItemsLeft.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               this.btnItemsRight.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            }
            else
            {
               this.mcFingerWheelingItemsHitArea.parent.removeChild(this.mcFingerWheelingItemsHitArea);
               this.mcFingerWheelingTypesHitArea.parent.removeChild(this.mcFingerWheelingTypesHitArea);
               this.mcSizer_btnItemsLeft.parent.removeChild(this.mcSizer_btnItemsLeft);
               this.mcSizer_btnItemsRight.parent.removeChild(this.mcSizer_btnItemsRight);
               this.mcSizer_btnItemsLeft = null;
               this.mcSizer_btnItemsRight = null;
            }
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this._currentPlayerData = dataM.playersData[dataM.player1PlayerID];
         this._selectedItemID = 0;
         this._shopType = param1;
         var _loc2_:Boolean = false;
         if(dataM.isTutorialActive())
         {
            _loc2_ = true;
         }
         if(this._targetSubType == "")
         {
            this._targetSubType = "torso";
         }
         this._shopJumpToTileID = 0;
         this.addAndRefreshSubTypeTileList();
         var _loc3_:Number = 0;
         if(this._shopType == "regular")
         {
            _loc4_ = Number(dataM.subTypeDB[this._targetSubType].ID);
         }
         else if(dataM.subTypeDB_myth[this._targetSubType] == null)
         {
            this._targetSubType = "torso";
         }
         else
         {
            _loc4_ = Number(dataM.subTypeDB_myth[this._targetSubType].ID);
         }
         _loc3_ = this.subTypeTileList.findTileIDByTileListItemID(_loc4_);
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         else if(this._targetSubType == "torso")
         {
            _loc3_ = 0;
         }
         this.subTypeTileList.jumpToRow(_loc3_,false,"screenHangerShop refreshScreen");
         if(_loc2_ == false)
         {
            this.setSelectedSubTypeItemBackground("selected");
         }
         this.subTypeClickedSub(this._targetSubType,true);
         if(_loc2_)
         {
            this.itemsTileList.visible = false;
            if(dataM.runAsMobile)
            {
               this.btnItemsLeft.visible = false;
               this.btnItemsRight.visible = false;
            }
         }
         if(dataM.runAsMobile)
         {
            this.fingerWheelingItems.addMouseListeners();
            this.fingerWheelingTypes.addMouseListeners();
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            param1 = true;
         }
         dataM.updateSubTypeNames();
      }
      
      public function resetSelectedSubType() : void
      {
         this._targetSubType = "";
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(dataM.runAsMobile)
            {
               this.fingerWheelingItems.onEnterFrameTrigger();
               this.fingerWheelingTypes.onEnterFrameTrigger();
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
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this.fingerWheelingItems.cancelFingerWheeling();
            this.fingerWheelingTypes.cancelFingerWheeling();
         }
      }
      
      public function getShopType() : String
      {
         return this._shopType;
      }
      
      public function buyClicked() : void
      {
         if(screensM.screenHangerMenu.hangerEnabled)
         {
            if(this.buyItemAllowed(this._selectedItemID))
            {
               this.tryToBuyItem(this._selectedItemID,0);
            }
            this.deactivateItemMarkers();
         }
      }
      
      private function buyItemAllowed(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:BMItemData = dataM.itemsDB[param1];
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc3_.level <= _loc4_.level || this.isUltraPowerKit(_loc3_))
         {
            if(dataM.tutorialEnabled)
            {
               switch(screensM.screenHangerMenu.tutorialPhase)
               {
                  case "buy_torsoLevel2":
                     if(_loc3_.level == 2 && _loc3_.type == "torso")
                     {
                        _loc2_ = true;
                     }
                     break;
                  case "buy_sideWeaponLevel2":
                     if(_loc3_.itemID == dataM.TUTORIAL_BUY_SIDE_WEAPON2_ID || _loc3_.itemID == dataM.TUTORIAL_BUY_SIDE_WEAPON3_ID)
                     {
                        _loc2_ = true;
                     }
                     break;
                  case "buy_sideWeaponLevel2Again":
                     if(_loc3_.itemID == dataM.TUTORIAL_BUY_SIDE_WEAPON4_ID)
                     {
                        _loc2_ = true;
                     }
                     break;
                  case "buy_topWeaponLevel2":
                     if(_loc3_.level == 2 && _loc3_.type == "topWeapon")
                     {
                        _loc2_ = true;
                     }
                     break;
                  case "buy_moduleLevel2":
                     if(_loc3_.level == 2 && _loc3_.type == "module")
                     {
                        _loc2_ = true;
                     }
                     break;
                  case "buy_kitLevel2":
                     if(_loc3_.level == 2 && _loc3_.type == "kit")
                     {
                        _loc2_ = true;
                     }
                     break;
                  case "switchToMech":
                  case "switchToFusion":
                     break;
                  default:
                     _loc2_ = true;
               }
            }
            else
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function tryToBuyItem(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerData = null;
         var _loc5_:BMItemData = null;
         var _loc6_:Boolean = false;
         var _loc7_:BMPlayerProfile = null;
         var _loc8_:Boolean = false;
         var _loc9_:uint = 0;
         var _loc10_:BMPlayerItemData = null;
         if(screensM.screenHangerMenu.hangerEnabled)
         {
            _loc3_ = false;
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               _loc4_ = dataM.playersData[dataM.player1PlayerID];
               if(_loc4_.items.length >= dataM.GUEST_MAX_ITEMS)
               {
                  _loc3_ = true;
               }
            }
            if(_loc3_)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegisterInventoryBlocked",-1,-1);
            }
            else
            {
               _loc5_ = dataM.itemsDB[param1];
               _loc6_ = true;
               _loc7_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc5_.costGold == 0)
               {
                  _loc8_ = false;
                  _loc9_ = 0;
                  while(_loc9_ < this._currentPlayerData.items.length)
                  {
                     _loc10_ = this._currentPlayerData.items[_loc9_];
                     if(_loc10_.itemID == param1)
                     {
                        _loc8_ = true;
                     }
                     _loc9_++;
                  }
                  if(_loc8_)
                  {
                     _loc6_ = false;
                  }
               }
               if(_loc5_.costTokens > 0)
               {
                  if(_loc5_.costTokens > _loc7_.tokens)
                  {
                     _loc6_ = false;
                  }
               }
               else if(_loc5_.costGold > _loc7_.gold)
               {
                  _loc6_ = false;
               }
               if(_loc6_)
               {
                  this.buyItemConfirmed(param1);
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
                  }
               }
               else if(_loc5_.costGold == 0)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("cantBuyFreeItem",param1,-1);
               }
               else if(_loc5_.costTokens > 0 && dataM.runAsMobile == false && dataM.usePersonaly)
               {
                  screensM.screenGetTokens.refreshScreen(0,_loc5_.costTokens,"shopItem");
                  screensM.addScreen("screenGetTokens");
               }
               else
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("notEnoughMoneyForItem",param1,-1);
               }
            }
         }
      }
      
      public function buyItemConfirmed(param1:Number) : void
      {
         screensM.screenHangerMenu.hangerEnabled = false;
         remoteM.inventory_buyItem(param1);
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
      }
      
      public function buyItemLocally(param1:Number) : void
      {
         var _loc2_:Number = this._currentPlayerData.playerItemIDCounter;
         ++this._currentPlayerData.playerItemIDCounter;
         this.buyItemSuccess(_loc2_,param1);
      }
      
      public function buyItemSuccess(param1:Number, param2:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc3_.newItemsPurchased.push(param1);
         var _loc4_:BMItemData = dataM.itemsDB[param2];
         if(_loc4_.costTokens == 0)
         {
            _loc3_.gold -= _loc4_.costGold;
            screensM.screenTopBar.refreshScreen(false);
         }
         else
         {
            _loc5_ = _loc4_.costTokens;
            _loc3_.tokens -= _loc5_;
            if(_loc3_.tokens_bonus >= _loc5_)
            {
               _loc3_.tokens_bonus -= _loc5_;
            }
            else
            {
               _loc5_ -= _loc3_.tokens_bonus;
               _loc3_.tokens_bonus = 0;
               _loc3_.tokens_supporter -= _loc5_;
            }
            screensM.screenTopBar.refreshScreen(false);
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            dataM.trackEvent("Shop","buyItem",_loc4_.type);
         }
         dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,param2,param1,0,0,0);
         screensM.screenHangerShop.addAndRefreshItemsTileList(true,false);
         screensM.screenHangerMenu.refreshTutorial();
         soundM.createSound("itemBought",1);
         screensM.screenHangerMenu.hangerEnabled = true;
         dataM.saveGuestData("hanger buyItemSuccess");
         screensM.removeScreen("screenConfirmation");
      }
      
      public function buyItemCancel() : void
      {
      }
      
      public function buyItemFailed() : void
      {
         screensM.screenHangerMenu.hangerEnabled = true;
      }
      
      private function createTextBitmaps() : void
      {
         if(dataM.runAsMobile)
         {
         }
      }
      
      private function removeIcon(param1:Sprite) : void
      {
         if(param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      private function addAndRefreshSubTypeTileList() : void
      {
         var _loc9_:Object = null;
         var _loc10_:uint = 0;
         var _loc11_:MovieClip = null;
         var _loc14_:Array = null;
         var _loc15_:MovieClip = null;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:String = null;
         var _loc19_:MovieClip = null;
         var _loc20_:Boolean = false;
         var _loc21_:BMItem = null;
         var _loc22_:BMTileListItem = null;
         var _loc23_:Function = null;
         var _loc24_:String = null;
         var _loc25_:Array = null;
         if(this.subTypeTileList != null)
         {
            this.subTypeTileList.removeMe();
         }
         var _loc1_:Array = new Array();
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Number = this.SUB_TYPE_ROWS;
         var _loc4_:Number = this.SUB_TYPE_ITEM_WIDTH;
         var _loc5_:Number = this.SUB_TYPE_ITEM_HEIGHT;
         if(dataM.runAsMobile)
         {
            _loc3_ = this.SUB_TYPE_ROWS_MOBILE;
            _loc4_ = this.SUB_TYPE_ITEM_WIDTH_MOBILE;
            _loc5_ = this.SUB_TYPE_ITEM_HEIGHT_MOBILE;
         }
         var _loc6_:Array = new Array();
         var _loc7_:Array = new Array();
         var _loc8_:Array = new Array();
         if(this._shopType == "regular")
         {
            _loc10_ = 0;
            while(_loc10_ < dataM.subTypeOrderDB.length)
            {
               _loc9_ = dataM.subTypeDB[dataM.subTypeOrderDB[_loc10_].name];
               if(_loc9_.unlockLevel > _loc2_.level)
               {
                  _loc7_.push(_loc9_.name);
               }
               else
               {
                  _loc6_.push(_loc9_.name);
               }
               _loc10_++;
            }
         }
         else
         {
            _loc10_ = 0;
            while(_loc10_ < dataM.subTypeOrderDB_myth.length)
            {
               _loc9_ = dataM.subTypeDB_myth[dataM.subTypeOrderDB_myth[_loc10_].name];
               if(_loc9_.unlockLevel > _loc2_.level)
               {
                  _loc7_.push(_loc9_.name);
               }
               else
               {
                  _loc6_.push(_loc9_.name);
               }
               _loc10_++;
            }
         }
         _loc10_ = 0;
         while(_loc10_ < _loc6_.length)
         {
            _loc8_.push(_loc6_[_loc10_]);
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc7_.length)
         {
            _loc8_.push(_loc7_[_loc10_]);
            _loc10_++;
         }
         if(_loc2_.level >= 5)
         {
            if(_loc8_[_loc8_.length - 2] == "kit_color")
            {
               _loc14_ = new Array();
               _loc14_.push("kit_color");
               _loc10_ = 0;
               while(_loc10_ < _loc8_.length - 2)
               {
                  _loc14_.push(_loc8_[_loc10_]);
                  _loc10_++;
               }
               _loc8_ = _loc14_;
            }
         }
         _loc10_ = 0;
         while(_loc10_ < _loc8_.length)
         {
            if(this._shopType == "regular")
            {
               _loc9_ = dataM.subTypeDB[_loc8_[_loc10_]];
            }
            else
            {
               _loc9_ = dataM.subTypeDB_myth[_loc8_[_loc10_]];
            }
            if(this._shopType == "regular")
            {
               if(dataM.runAsMobile)
               {
                  _loc15_ = new mcSubTypeListRow_mobile();
               }
               else
               {
                  _loc15_ = new mcSubTypeListRow();
               }
            }
            else if(dataM.runAsMobile)
            {
               _loc15_ = new mcSubTypeListRow_myth_mobile();
            }
            else
            {
               _loc15_ = new mcSubTypeListRow_myth();
            }
            _loc16_ = Number(_loc15_.mcSizer_icon.width);
            _loc17_ = Number(_loc15_.mcSizer_icon.height);
            _loc18_ = _loc9_.text;
            _loc19_ = null;
            _loc20_ = false;
            if(this._shopType == "regular")
            {
               if(_loc2_.level >= dataM.subTypeDB[_loc9_.name].unlockLevel)
               {
                  _loc20_ = true;
               }
            }
            else if(_loc2_.level >= dataM.subTypeDB_myth[_loc9_.name].unlockLevel)
            {
               _loc20_ = true;
            }
            if(_loc20_)
            {
               _loc15_.mcLocked.visible = false;
               _loc15_.mcBlackScreen.visible = false;
               _loc24_ = "";
               if(this._shopType == "mythical")
               {
                  _loc24_ = "myth_";
               }
               _loc19_ = externalAssetsM.getAsset("general","subType_shop_" + _loc24_ + _loc9_.name,_loc16_,_loc17_,false,false);
               _loc19_.x = _loc15_.mcSizer_icon.x;
               _loc19_.y = _loc15_.mcSizer_icon.y;
               _loc15_.addChild(_loc19_);
            }
            if(_loc15_.txtSubType2.numLines == 1)
            {
               TextUtils.updateTextFormat(_loc15_.txtSubType1);
               _loc15_.txtSubType1.htmlText = TextUtils.getTextFont() + _loc18_;
               _loc15_.txtSubType2.htmlText = "";
            }
            else
            {
               TextUtils.updateTextFormat(_loc15_.txtSubType2);
               _loc15_.txtSubType2.htmlText = TextUtils.getTextFont() + _loc18_;
               _loc15_.txtSubType1.htmlText = "";
            }
            _loc21_ = new BMItem();
            _loc21_.initialize(_loc9_.ID,_loc4_,_loc5_,_loc15_,0,0,false,null,dataM.runAsMobile);
            if(dataM.runAsMobile)
            {
               _loc25_ = new Array();
               if(_loc19_ != null)
               {
                  _loc25_.push(_loc19_);
               }
               _loc21_.createAssetsBitmap([_loc15_.txtSubType1,_loc15_.txtSubType2],_loc25_,_loc15_,true);
            }
            _loc22_ = new BMTileListItem();
            _loc23_ = this.subTypeClicked;
            if(dataM.runAsMobile)
            {
               _loc23_ = null;
            }
            _loc22_.initialize(_loc4_,_loc5_,_loc21_,"","","",0,_loc23_,null,null,null,null,dataM.runAsMobile);
            _loc1_.push(_loc22_);
            _loc10_++;
         }
         this.subTypeTileList = new BMTileList();
         if(dataM.runAsMobile)
         {
            this.fingerWheelingTypes.resetTileList(this.subTypeTileList);
         }
         if(this._shopType == "regular")
         {
            _loc11_ = new Grp_scrollerContent();
         }
         else
         {
            _loc11_ = new Grp_scrollerContent_myth();
         }
         var _loc12_:Boolean = false;
         if(dataM.runAsMobile)
         {
            _loc12_ = true;
            this.subTypeTileList.activateExtendedMode(0.38,true);
         }
         var _loc13_:String = "";
         if(this._shopType == "mythical")
         {
            _loc13_ = "mythical";
         }
         this.subTypeTileList.initialize(screensM.stagePointer,_loc1_,_loc3_,1,_loc4_,_loc5_,null,true,_loc11_,null,null,false,0,0.65,true,_loc12_,dataM.runAsMobile,_loc13_);
         this.subTypeTileList.x = this.mcSizer_subTypeTileList.x;
         this.subTypeTileList.y = this.mcSizer_subTypeTileList.y;
         this.mcSubTypeTileListHolder.addChild(this.subTypeTileList);
      }
      
      private function subTypeClicked(param1:Number, param2:Number) : void
      {
         var _loc3_:String = null;
         if(param1 > -1)
         {
            if(this._shopType == "regular")
            {
               _loc3_ = dataM.subTypeDB[dataM.subTypeOrderDB[param2 - 1].name].name;
            }
            else
            {
               _loc3_ = dataM.subTypeDB_myth[dataM.subTypeOrderDB_myth[param2 - 1].name].name;
            }
            screensM.sound_buttonClicked();
            this.subTypeClickedSub(_loc3_,false);
         }
      }
      
      public function subTypeClickedSub(param1:String, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMItemData = null;
         if(this._targetSubType != param1 || param2)
         {
            this.deactivateItemMarkers();
            this.setSelectedSubTypeItemBackground("regular");
            this._selectedItemID = 0;
            this._targetSubType = param1;
            if(dataM.runAsMobile)
            {
               this.fingerWheelingItems.cancelFingerWheeling();
            }
            if(this._shopType == "regular")
            {
               if(dataM.subTypeItemsAmount == null)
               {
                  dataM.subTypeItemsAmount = new Object();
                  for each(_loc4_ in dataM.itemsDB)
                  {
                     if(_loc4_.level <= dataM.LEVEL_MAX)
                     {
                        switch(_loc4_.type)
                        {
                           case "sideWeapon":
                           case "topWeapon":
                           case "module":
                              _loc3_ = dataM.subTypeOriginDB[_loc4_.type + "_" + _loc4_.subType];
                              if(dataM.subTypeItemsAmount[_loc3_] == null)
                              {
                                 dataM.subTypeItemsAmount[_loc3_] = 1;
                              }
                              else
                              {
                                 ++dataM.subTypeItemsAmount[_loc3_];
                              }
                              break;
                           case "kit":
                              if(_loc4_.subType != "power")
                              {
                                 _loc3_ = dataM.subTypeOriginDB[_loc4_.type + "_" + _loc4_.subType];
                                 if(dataM.subTypeItemsAmount[_loc3_] == null)
                                 {
                                    dataM.subTypeItemsAmount[_loc3_] = 1;
                                 }
                                 else
                                 {
                                    ++dataM.subTypeItemsAmount[_loc3_];
                                 }
                              }
                              break;
                           default:
                              _loc3_ = dataM.subTypeOriginDB[_loc4_.type];
                              if(dataM.subTypeItemsAmount[_loc3_] == null)
                              {
                                 dataM.subTypeItemsAmount[_loc3_] = 1;
                              }
                              else
                              {
                                 ++dataM.subTypeItemsAmount[_loc3_];
                              }
                        }
                     }
                     else if(_loc4_.level > dataM.LEVEL_MAX)
                     {
                        if(_loc4_.type == "kit")
                        {
                           if(this.isUltraPowerKit(_loc4_))
                           {
                              _loc3_ = dataM.subTypeOriginDB[_loc4_.type + "_" + _loc4_.subType];
                              if(dataM.subTypeItemsAmount[_loc3_] == null)
                              {
                                 dataM.subTypeItemsAmount[_loc3_] = 1;
                              }
                              else
                              {
                                 ++dataM.subTypeItemsAmount[_loc3_];
                              }
                           }
                        }
                     }
                  }
               }
               this._totalItemsInSubType = dataM.subTypeItemsAmount[this._targetSubType];
            }
            else
            {
               if(dataM.subTypeItemsAmount_myth == null)
               {
                  dataM.subTypeItemsAmount_myth = new Object();
                  for each(_loc4_ in dataM.itemsDB)
                  {
                     if(!(_loc4_.specialStatus == 4 && _loc4_.level == dataM.LEVEL_MAX + 1))
                     {
                        continue;
                     }
                     switch(_loc4_.type)
                     {
                        case "sideWeapon":
                        case "topWeapon":
                        case "module":
                           _loc3_ = dataM.subTypeOriginDB_myth[_loc4_.type + "_" + _loc4_.subType];
                           if(dataM.subTypeItemsAmount_myth[_loc3_] == null)
                           {
                              dataM.subTypeItemsAmount_myth[_loc3_] = 1;
                           }
                           else
                           {
                              ++dataM.subTypeItemsAmount_myth[_loc3_];
                           }
                           break;
                        default:
                           _loc3_ = dataM.subTypeOriginDB_myth[_loc4_.type];
                           if(dataM.subTypeItemsAmount_myth[_loc3_] == null)
                           {
                              dataM.subTypeItemsAmount_myth[_loc3_] = 1;
                           }
                           else
                           {
                              ++dataM.subTypeItemsAmount_myth[_loc3_];
                           }
                     }
                  }
               }
               this._totalItemsInSubType = dataM.subTypeItemsAmount_myth[this._targetSubType];
            }
            this._currentPage = 0;
            if(this._totalItemsInSubType > 0)
            {
               this._subTypeTotalPages = Math.ceil(this._totalItemsInSubType / this._maxItemsInDisplay) - 1;
            }
            else
            {
               this._subTypeTotalPages = 0;
            }
            this.addAndRefreshItemsTileList(false,true);
            this.setSelectedSubTypeItemBackground("selected");
            if(dataM.tutorialEnabled)
            {
               screensM.screenHangerMenu.refreshTutorial();
            }
         }
      }
      
      public function getTargetSubType() : String
      {
         return this._targetSubType;
      }
      
      private function setSelectedSubTypeItemBackground(param1:String) : void
      {
         if(this._shopType == "regular")
         {
            this.subTypeTileList.findTileListItemByTileListItemID(dataM.subTypeDB[this._targetSubType].ID).item.itemGrp.mcBackground.gotoAndStop(param1);
         }
         else
         {
            this.subTypeTileList.findTileListItemByTileListItemID(dataM.subTypeDB_myth[this._targetSubType].ID).item.itemGrp.mcBackground.gotoAndStop(param1);
         }
      }
      
      public function addAndRefreshItemsTileList(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Number = dataM.SHOP_REGULAR_TILE_LIST_ITEM_SIZE;
         var _loc4_:Number = dataM.SHOP_REGULAR_TILE_LIST_ITEM_SIZE;
         var _loc5_:Number = this.ITEMS_TILE_LIST_ROWS;
         var _loc6_:Number = this.ITEMS_TILE_LIST_COLUMNS;
         if(dataM.runAsMobile)
         {
            _loc3_ = dataM.SHOP_REGULAR_TILE_LIST_ITEM_SIZE_MOBILE;
            _loc4_ = dataM.SHOP_REGULAR_TILE_LIST_ITEM_SIZE_MOBILE;
            _loc5_ = this.ITEMS_TILE_LIST_ROWS_MOBILE;
            _loc6_ = this.ITEMS_TILE_LIST_COLUMNS_MOBILE;
         }
         var _loc7_:Number = 0;
         if(this.itemsTileList != null)
         {
            _loc7_ = this.itemsTileList.getCurrentRow();
            this.itemsTileList.removeMe();
         }
         var _loc8_:Array = new Array();
         var _loc9_:Array = this.getShopTileListItems(param2);
         var _loc10_:Number = 0;
         if(dataM.runAsMobile == false)
         {
            if(param1)
            {
               _loc10_ = _loc7_;
            }
            else if(param2)
            {
               _loc10_ = Math.floor(this._shopJumpToTileID / _loc6_) - (_loc5_ - 1);
            }
         }
         this.itemsTileList = new BMTileList();
         if(dataM.runAsMobile)
         {
            this.fingerWheelingItems.resetTileList(this.itemsTileList);
         }
         var _loc11_:Sprite = null;
         var _loc12_:MovieClip = new Grp_scrollerContent();
         this.itemsTileList.loadAssetsFunction = externalAssetsM.getAsset;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = true;
         if(dataM.runAsMobile)
         {
            _loc13_ = true;
         }
         var _loc15_:String = "";
         if(this._shopType == "mythical")
         {
            _loc15_ = "mythical";
         }
         this.itemsTileList.initialize(screensM.stagePointer,_loc9_,_loc5_,_loc6_,_loc3_,_loc4_,null,true,_loc12_,_loc11_,null,false,_loc10_,0.65,_loc14_,_loc13_,dataM.runAsMobile,_loc15_);
         this.itemsTileList.x = this.mcSizer_itemsTileList.x;
         this.itemsTileList.y = this.mcSizer_itemsTileList.y;
         if(dataM.runAsMobile)
         {
            this.itemsTileList.x -= 16;
         }
         this.mcItemsTileListHolder.addChild(this.itemsTileList);
         if(dataM.tutorialEnabled)
         {
            this.itemsTileList.scroller.disableMe();
         }
         if(dataM.runAsMobile)
         {
            this.refreshItemsLeftRightButtons();
         }
      }
      
      private function shopItemMouseClicked(param1:Number, param2:Number) : void
      {
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:BMItemData = null;
         if(param1 > -1)
         {
            if(this.canShopItemBeSelected(param2))
            {
               _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc4_ = dataM.itemsDB[param2];
               if(_loc3_.level >= _loc4_.level || _loc4_.specialStatus == 4 || this.isUltraPowerKit(_loc4_))
               {
                  this._selectedItemID = param2;
                  screensM.addScreen("screenBuyItem");
                  screensM.screenBuyItem.refreshScreen(param2);
                  screensM.sound_buttonClicked();
                  this.deactivateItemMarkers();
                  if(dataM.tutorialEnabled)
                  {
                     this.itemsTileList.deactivateAllAnimatedMarkers();
                     this.itemsTileList.deactivateGuideArrow();
                  }
               }
            }
         }
      }
      
      private function isUltraPowerKit(param1:BMItemData) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.level > dataM.LEVEL_MAX)
         {
            if(param1.specialStatus == 2 && param1.type == "kit" && param1.subType == "power")
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function shopItemMouseOver(param1:Number, param2:Number) : void
      {
         this.shopItemMouseOverSub(param2);
      }
      
      public function shopItemMouseOverSub(param1:Number) : void
      {
         tooltip.showToolTip("newsItem","",param1);
         if(dataM.runAsMobile)
         {
            tooltip.allowRepositionForMobile = true;
         }
      }
      
      private function shopItemMouseOut(param1:Number, param2:Number) : void
      {
         tooltip.hideToolTip();
      }
      
      private function getShopTileListItems(param1:Boolean) : Array
      {
         var _loc3_:BMPlayerData = null;
         var _loc5_:Object = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:BMItemData = null;
         var _loc9_:uint = 0;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:String = null;
         var _loc13_:* = 0;
         var _loc14_:uint = 0;
         var _loc15_:Array = null;
         var _loc16_:Array = null;
         var _loc17_:BMTileListItem = null;
         var _loc18_:Number = NaN;
         var _loc19_:Array = null;
         var _loc20_:Boolean = false;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:* = 0;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc26_:Function = null;
         var _loc27_:Function = null;
         var _loc28_:Function = null;
         var _loc29_:uint = 0;
         var _loc30_:Boolean = false;
         var _loc31_:uint = 0;
         var _loc32_:BMPlayerItemData = null;
         var _loc33_:Boolean = false;
         var _loc34_:uint = 0;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:Array = new Array();
         if(this._itemsFinalSortIDs == null)
         {
            this._itemsFinalSortIDs = new Object();
            this._itemsFinalSortIDs_myth = new Object();
            for each(_loc8_ in dataM.itemsDB)
            {
               _loc6_ = false;
               _loc7_ = false;
               _loc10_ = false;
               if(_loc8_.specialStatus <= 3)
               {
                  _loc6_ = true;
               }
               else if(_loc8_.specialStatus == 4)
               {
                  _loc7_ = true;
               }
               if(_loc7_)
               {
                  if(_loc8_.level == dataM.LEVEL_MAX + 1)
                  {
                     _loc10_ = true;
                  }
               }
               else if(_loc8_.type == "kit")
               {
                  if(_loc8_.subType == "power")
                  {
                     if(this.isUltraPowerKit(_loc8_))
                     {
                        _loc10_ = true;
                     }
                  }
                  else if(_loc8_.level <= dataM.LEVEL_MAX)
                  {
                     _loc10_ = true;
                  }
               }
               else if(_loc8_.level <= dataM.LEVEL_MAX)
               {
                  _loc10_ = true;
               }
               if(_loc10_)
               {
                  _loc11_ = false;
                  if(_loc6_ || _loc7_)
                  {
                     if(_loc6_)
                     {
                        switch(_loc8_.type)
                        {
                           case "sideWeapon":
                           case "topWeapon":
                           case "module":
                           case "kit":
                              _loc12_ = dataM.subTypeOriginDB[_loc8_.type + "_" + _loc8_.subType];
                              break;
                           default:
                              _loc12_ = dataM.subTypeOriginDB[_loc8_.type];
                        }
                     }
                     else
                     {
                        switch(_loc8_.type)
                        {
                           case "sideWeapon":
                           case "topWeapon":
                           case "module":
                           case "kit":
                              _loc12_ = dataM.subTypeOriginDB_myth[_loc8_.type + "_" + _loc8_.subType];
                              break;
                           default:
                              _loc12_ = dataM.subTypeOriginDB_myth[_loc8_.type];
                        }
                     }
                     if(_loc6_)
                     {
                        if(this._itemsFinalSortIDs[_loc12_] == null)
                        {
                           this._itemsFinalSortIDs[_loc12_] = new Object();
                           this._itemsFinalSortIDs[_loc12_].subType = _loc12_;
                           this._itemsFinalSortIDs[_loc12_].items = new Array();
                        }
                     }
                     else if(this._itemsFinalSortIDs_myth[_loc12_] == null)
                     {
                        this._itemsFinalSortIDs_myth[_loc12_] = new Object();
                        this._itemsFinalSortIDs_myth[_loc12_].subType = _loc12_;
                        this._itemsFinalSortIDs_myth[_loc12_].items = new Array();
                     }
                     if(_loc6_)
                     {
                        if(dataM.isPowerKit(_loc8_.itemID) == false)
                        {
                           _loc11_ = true;
                        }
                        else if(_loc8_.costTokens > 0)
                        {
                           _loc11_ = true;
                        }
                        else
                        {
                           _loc11_ = false;
                        }
                     }
                     else if(_loc7_)
                     {
                        _loc11_ = true;
                     }
                     if(_loc11_)
                     {
                        if(_loc6_)
                        {
                           this._itemsFinalSortIDs[_loc12_].items.push({
                              "finalSortID":_loc8_.finalSortID,
                              "itemID":_loc8_.itemID
                           });
                        }
                        else
                        {
                           this._itemsFinalSortIDs_myth[_loc12_].items.push({
                              "finalSortID":_loc8_.finalSortID,
                              "itemID":_loc8_.itemID
                           });
                        }
                     }
                  }
               }
            }
            for each(_loc5_ in this._itemsFinalSortIDs)
            {
               _loc5_.items.sortOn("finalSortID",Array.NUMERIC);
            }
            for each(_loc5_ in this._itemsFinalSortIDs_myth)
            {
               _loc5_.items.sortOn("finalSortID",Array.NUMERIC);
            }
         }
         if(dataM.runAsMobile)
         {
            if(this._itemPagesByLevels == null)
            {
               this._itemPagesByLevels = new Object();
               for each(_loc5_ in this._itemsFinalSortIDs)
               {
                  if(this._itemPagesByLevels[_loc5_.subType] == null)
                  {
                     this._itemPagesByLevels[_loc5_.subType] = new Array();
                  }
                  _loc13_ = 0;
                  _loc14_ = uint(this._itemsFinalSortIDs[_loc5_.subType].items.length);
                  _loc9_ = 0;
                  while(_loc9_ < _loc14_)
                  {
                     if(++_loc13_ == this._maxItemsInDisplay || _loc9_ == _loc14_ - 1)
                     {
                        _loc13_ = 0;
                        _loc8_ = dataM.itemsDB[this._itemsFinalSortIDs[_loc5_.subType].items[_loc9_].itemID];
                        this._itemPagesByLevels[_loc5_.subType].push(_loc8_.level);
                     }
                     _loc9_++;
                  }
               }
            }
         }
         if(this._shopType == "regular" && this._itemsFinalSortIDs[this._targetSubType] != null || this._shopType == "mythical" && this._itemsFinalSortIDs_myth[this._targetSubType] != null)
         {
            _loc15_ = new Array();
            _loc16_ = new Array();
            _loc18_ = 0;
            if(this._shopType == "regular")
            {
               _loc19_ = this._itemsFinalSortIDs[this._targetSubType].items;
            }
            else
            {
               _loc19_ = this._itemsFinalSortIDs_myth[this._targetSubType].items;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc19_.length)
            {
               _loc29_ = uint(_loc19_[_loc9_].itemID);
               _loc8_ = dataM.itemsDB[_loc29_];
               if(_loc8_ == null)
               {
                  TsLogger.log("ITEM ID " + _loc29_ + " DOESNT EXIST IN CURRENT DATA BASE");
               }
               else if(_loc8_.grp != "")
               {
                  _loc30_ = false;
                  if(_loc8_.costGold == 0)
                  {
                     _loc3_ = dataM.playersData[dataM.player1PlayerID];
                     _loc31_ = 0;
                     while(_loc31_ < _loc3_.items.length)
                     {
                        _loc32_ = _loc3_.items[_loc31_];
                        if(_loc32_.itemID == _loc8_.itemID)
                        {
                           _loc30_ = true;
                        }
                        _loc31_++;
                     }
                  }
                  if(_loc30_ == false)
                  {
                     _loc33_ = false;
                     if(dataM.tutorialEnabled == false)
                     {
                        _loc33_ = this.isUltraPowerKit(_loc8_);
                     }
                     _loc7_ = false;
                     if(_loc8_.specialStatus == 4)
                     {
                        _loc7_ = true;
                     }
                     if(_loc7_)
                     {
                        _loc15_.push(_loc8_.itemID);
                     }
                     else if(_loc33_)
                     {
                        _loc15_.push(_loc8_.itemID);
                     }
                     else if(_loc2_.level < _loc8_.level)
                     {
                        _loc16_.push(_loc8_.itemID);
                     }
                     else if(dataM.tutorialEnabled && _loc2_.winsVSComputer < 1 && (_loc8_.itemID == dataM.TUTORIAL_BUY_TORSO1_ID || _loc8_.itemID == dataM.TUTORIAL_BUY_SIDE_WEAPON1_ID))
                     {
                        _loc16_.push(_loc8_.itemID);
                     }
                     else
                     {
                        _loc15_.push(_loc8_.itemID);
                     }
                     if(_loc2_.level >= _loc8_.level)
                     {
                        _loc18_++;
                     }
                  }
               }
               else
               {
                  TsLogger.log("ERROR : ITEM ID " + _loc8_.itemID + " HAS NO PICTURE");
               }
               _loc9_++;
            }
            _loc21_ = this.ITEMS_TILE_LIST_ROWS;
            _loc22_ = this.ITEMS_TILE_LIST_COLUMNS;
            if(dataM.runAsMobile)
            {
               _loc21_ = this.ITEMS_TILE_LIST_ROWS_MOBILE;
               _loc22_ = this.ITEMS_TILE_LIST_COLUMNS_MOBILE;
            }
            _loc23_ = 0;
            _loc24_ = 99999;
            _loc25_ = 0;
            if(this._shopType == "regular")
            {
               if(dataM.runAsMobile)
               {
                  _loc24_ = this._maxItemsInDisplay;
                  if(param1)
                  {
                     if(_loc2_.level == dataM.LEVEL_MAX && this._targetSubType != "mythical")
                     {
                        this._currentPage = this._itemPagesByLevels[this._targetSubType].length - 1;
                     }
                     else
                     {
                        _loc34_ = 0;
                        _loc9_ = 0;
                        while(_loc9_ < this._itemPagesByLevels[this._targetSubType].length)
                        {
                           if(_loc2_.level > _loc34_ && _loc2_.level <= this._itemPagesByLevels[this._targetSubType][_loc9_])
                           {
                              this._currentPage = _loc9_;
                              _loc9_ = uint(this._itemPagesByLevels[this._targetSubType].length);
                           }
                           _loc34_ = uint(this._itemPagesByLevels[this._targetSubType][_loc9_]);
                           _loc9_++;
                        }
                     }
                  }
                  if(this._currentPage > 0)
                  {
                     _loc25_ = this._currentPage * _loc24_;
                  }
               }
            }
            _loc26_ = this.shopItemMouseClicked;
            _loc27_ = this.shopItemMouseOver;
            _loc28_ = this.shopItemMouseOut;
            _loc9_ = 0;
            while(_loc9_ < _loc15_.length)
            {
               if(++_loc23_ > _loc25_ && _loc4_.length < _loc24_)
               {
                  _loc20_ = false;
                  if(dataM.runAsMobile)
                  {
                     _loc20_ = true;
                  }
                  _loc17_ = dataM.createShopTileListItem_basedOnItemID(_loc15_[_loc9_],"shop",_loc26_,null,null,_loc27_,_loc28_,_loc20_);
                  _loc4_.push(_loc17_);
               }
               _loc9_++;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc16_.length)
            {
               if(++_loc23_ > _loc25_ && _loc4_.length < _loc24_)
               {
                  _loc20_ = false;
                  _loc17_ = dataM.createShopTileListItem_basedOnItemID(_loc16_[_loc9_],"shop",_loc26_,null,null,_loc27_,_loc28_,_loc20_);
                  _loc17_.disableMe(true);
                  _loc17_.enableMouseOverAndOutWhileDisabled();
                  _loc4_.push(_loc17_);
               }
               _loc9_++;
            }
            this._shopJumpToTileID = _loc18_;
            if(this._shopJumpToTileID < 0)
            {
               this._shopJumpToTileID = 0;
            }
         }
         else
         {
            this._shopJumpToTileID = 0;
         }
         return _loc4_;
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
         this.addAndRefreshItemsTileList(false,false);
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
         this.addAndRefreshItemsTileList(false,false);
         this.refreshItemsLeftRightButtons();
      }
      
      private function refreshItemsLeftRightButtons() : void
      {
         if(this._subTypeTotalPages == 0 || dataM.tutorialEnabled)
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
      
      private function canShopItemBeSelected(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         if(dataM.tutorialEnabled)
         {
            switch(screensM.screenHangerMenu.tutorialPhase)
            {
               case "buy_sideWeaponLevel2Again":
                  if(param1 == dataM.TUTORIAL_BUY_SIDE_WEAPON4_ID)
                  {
                     _loc2_ = true;
                  }
                  break;
               case "buy_topWeaponLevel2":
                  if(param1 == dataM.TUTORIAL_BUY_TOP_WEAPON1_ID)
                  {
                     _loc2_ = true;
                  }
                  break;
               case "buy_moduleLevel2":
                  if(param1 == dataM.TUTORIAL_BUY_MODULE_ID)
                  {
                     _loc2_ = true;
                  }
            }
         }
         else
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function deactivateItemMarkers() : void
      {
         if(dataM.tutorialEnabled)
         {
            if(this.itemsTileList != null)
            {
               this.itemsTileList.deactivateAllAnimatedMarkers();
               if(dataM.runAsMobile)
               {
                  this.itemsTileList.deactivateGuideArrow();
               }
            }
         }
      }
      
      public function itemBoxClicked() : void
      {
         dataM.packages_markItemsBox = true;
      }
      
      public function itemBoxSilverGoldClicked() : void
      {
         var _loc1_:uint = 6;
         var _loc2_:Number = Math.ceil(Math.random() * 2);
         if(_loc2_ == 2 && dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            _loc1_ = 20;
         }
         dataM.packages_markSpecificPackageID = _loc1_;
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      public function removeMe() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(screensM.isScreenOpened("screenHangerShop"))
         {
            if(screensM.isScreenOpened("screenBuyItem"))
            {
               screensM.screenBuyItem.removeMe();
            }
            this.deactivateItemMarkers();
            this.itemsTileList.removeMe();
            this.itemsTileList = null;
            this.subTypeTileList.removeMe();
            this.subTypeTileList = null;
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc1_.level < 5)
            {
               this._targetSubType = "torso";
            }
            if(dataM.runAsMobile)
            {
               this.fingerWheelingItems.removeMouseListeners();
               this.fingerWheelingTypes.removeMouseListeners();
            }
            screensM.removeScreen("screenHangerShop");
         }
      }
   }
}

