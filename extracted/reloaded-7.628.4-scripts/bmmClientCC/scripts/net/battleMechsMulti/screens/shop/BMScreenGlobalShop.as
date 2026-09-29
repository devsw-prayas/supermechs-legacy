package net.battleMechsMulti.screens.shop
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1326")]
   public class BMScreenGlobalShop extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcTileListHolder:MovieClip;
      
      public var mcSizer_btnClose:Sprite;
      
      public var mcSizer_tileListMobile:Sprite;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcEffectsHolder:Sprite;
      
      public var txtError:TextField;
      
      public var btnClose:BMButton_pictureE;
      
      public var btnGetGold:BMButton;
      
      public var btnGetTokens:BMButton;
      
      public var txtTokens:TextField;
      
      public var txtGold:TextField;
      
      public var mcBorderButton1:BMBasicButton;
      
      public var mcBorderButton2:BMBasicButton;
      
      public var mcTutorialArrow:MovieClip;
      
      public var mcTabsHolder:MovieClip;
      
      private var _tileListItems:Array = new Array();
      
      private var _scrollActive:Boolean = false;
      
      private var _scrollingSpeed:Number = 0;
      
      private var _lastScrollXPos:Number;
      
      private var _scrollXPos:Array = new Array();
      
      private var _scrollMax:Number = 0;
      
      private var _scrollAbsoluteDeltaX:uint = 0;
      
      private var _tileListHolderOriginXPos:Number;
      
      private var _tileListWidth:Number;
      
      private var _claimTextCounter:uint = 0;
      
      private var _claimTextCounter2:uint = 0;
      
      private var _sparkLocations:Array = new Array();
      
      private var _webScrollingTargetTileID:Number;
      
      private var _webScrollingTargetXPos:Number;
      
      private var _webScrollingActive:Boolean = false;
      
      private var _webScrollingDelayFrames:uint = 0;
      
      private var _finalWidth:uint;
      
      private var _finalHeight:uint;
      
      private var _firstRefresh:Boolean = true;
      
      private var _categoryTextsUpdated:Boolean = false;
      
      public var blockNextMobileClick:Boolean = false;
      
      private const ITEM_WIDTH_MOBILE:uint = 218;
      
      private const ITEM_HEIGHT_MOBILE:uint = 342;
      
      private var _onSelect:Function;
      
      private var _dataArr:Array;
      
      private var _tutorialArrowActive:Boolean = false;
      
      private var _tutorialArrowFrameCounter:uint;
      
      private var _tutorialArrowRemoveFrames:uint;
      
      private var _tutorialArrowDelayFrames:uint;
      
      private var _tutorialArrowPoint:Point;
      
      private var _tutorialArrowAngle:Number;
      
      private var _borderButtonHidden:Boolean;
      
      private const NUM_ITEMS_PER_PAGE:int = 3;
      
      private var _selectCategoryId:int = -1;
      
      private var _tabsList:Vector.<BMGlobalShopTab> = new Vector.<BMGlobalShopTab>();
      
      private var _screenJustOpened:Boolean = true;
      
      public function BMScreenGlobalShop()
      {
         super();
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMScreenGlobalShop initializing");
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("globalShop");
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         this.mcBorderButton1.alpha = 0;
         this.mcBorderButton2.alpha = 0;
         sub(BMPubSub.MESSAGE_SCREENS_DIRECTOR_STARTED_PERFORMING_TASKS,this.screensDirectorStartedPerformingTasks);
         sub(BMPubSub.MESSAGE_SHOP_ACTIVE_CHAIN_DISCOUNT_UPDATED,this.activeChainDiscountUpdated);
         sub(BMPubSub.VIP_ACCOUNT_UPDATED,this.handleVIPAccountUpdated);
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         if(this._firstRefresh)
         {
            if(this.isNarrowInterface == false)
            {
               screensM.createButtonFromSizer(BMScreensManager.SCR_GLOBAL_SHOP,"btnClose","pictureE");
               _loc1_ = this.closeClicked;
               _loc2_ = this.buyGoldClicked;
               _loc3_ = this.buyTokensClicked;
               if(dataM.runAsMobile)
               {
                  _loc1_ = null;
                  _loc2_ = null;
                  _loc3_ = null;
               }
               this.btnGetGold.initialize("","",null,[],_loc2_,dataM.runAsMobile);
               this.btnGetTokens.initialize("","",null,[],_loc3_,dataM.runAsMobile);
               this.btnGetGold.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               this.btnGetTokens.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               this.btnClose.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc1_,dataM.runAsMobile);
               this.btnClose.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            }
            this._tileListWidth = this.mcSizer_tileListMobile.width;
            this._finalWidth = this.ITEM_WIDTH_MOBILE;
            this._finalHeight = this.ITEM_HEIGHT_MOBILE;
            if(dataM.runAsMobile == false)
            {
               this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
               this.mcEffectsHolder.mouseEnabled = false;
               this.mcEffectsHolder.mouseChildren = false;
               this.mcBorderButton1.addEventListener(BMIntractable.HIT,this.borderButtonLeftClicked);
               this.mcBorderButton2.addEventListener(BMIntractable.HIT,this.borderButtonRightClicked);
            }
            this.mcTileListHolder.tilesHolder = new Sprite();
            this.mcTileListHolder.tutorialArrowHolder = new Sprite();
            this.mcTileListHolder.addChild(this.mcTileListHolder.tilesHolder);
            this.mcTileListHolder.addChild(this.mcTileListHolder.tutorialArrowHolder);
            this._tileListHolderOriginXPos = this.mcTileListHolder.x;
            if(this.isNarrowInterface == false)
            {
               this.mcTutorialArrow.mouseEnabled = false;
               this.mcTutorialArrow.mouseChildren = false;
            }
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.deactivateTutorialArrow();
         this._borderButtonHidden = false;
         if(tutorialM.isTutorialActive())
         {
            this._borderButtonHidden = true;
            this.mcBorderButton1.visible = false;
            this.mcBorderButton2.visible = false;
         }
         if(this.isNarrowInterface == false)
         {
            if(tutorialM.isTutorialActive())
            {
               this.btnClose.visible = false;
               this.btnGetGold.visible = false;
               this.btnGetTokens.visible = false;
            }
            else
            {
               this.btnClose.visible = true;
               this.btnGetGold.visible = true;
               this.btnGetTokens.visible = true;
            }
         }
         if(this.isNarrowInterface == false)
         {
            this.refreshGoldTokensTexts();
         }
         dataM.trackScreenView("shop");
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMTileListItem = null;
         var _loc4_:BMShopItemView = null;
         this._screenJustOpened = false;
         if(parent == null)
         {
            return;
         }
         if(dataM.runAsMobile)
         {
            this.scrollingOnEnterFrameMobile();
         }
         else
         {
            this.scrollingOnEnterFrameWeb();
         }
         if(this._borderButtonHidden == false)
         {
            this.borderButtonsHandler();
         }
         var _loc1_:Boolean = BMShopManager.gi().currentCategory == BMShopManager.gi().category_mechs || BMShopManager.gi().currentCategory == BMShopManager.gi().category_clanShop;
         if(BMShopManager.gi().useMechsShop && _loc1_)
         {
            _loc2_ = 0;
            while(_loc2_ < this._tileListItems.length)
            {
               _loc3_ = this._tileListItems[_loc2_];
               _loc4_ = _loc3_.item.itemGrp as BMShopItemView;
               _loc4_.mechOnEnterFrame();
               _loc2_++;
            }
         }
         this.tutorialArrowHandler();
         this.blockNextMobileClick = false;
      }
      
      private function get isNarrowInterface() : Boolean
      {
         return screensM.isScreenOpened(BMScreensManager.SCR_CLAN_MENU) || screensM.isScreenOpened(BMScreensManager.SCR_KIN_SHOP);
      }
      
      public function setScreenJustOpened() : void
      {
         this._screenJustOpened = true;
      }
      
      private function refreshItemsVisibility() : void
      {
         var _loc2_:BMTileListItem = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         if(this._tileListItems.length < 4)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._tileListItems.length)
         {
            _loc2_ = this._tileListItems[_loc1_];
            if(_loc2_.parent == null)
            {
               _loc3_ = false;
               if(_loc2_.x + _loc2_.width >= Math.abs(this.mcTileListHolder.x - this._tileListHolderOriginXPos))
               {
                  if(_loc2_.x - this._tileListWidth <= Math.abs(this.mcTileListHolder.x - this._tileListHolderOriginXPos))
                  {
                     _loc3_ = true;
                  }
               }
               if(_loc3_)
               {
                  this.mcTileListHolder.tilesHolder.addChild(this._tileListItems[_loc1_]);
               }
            }
            else
            {
               _loc4_ = true;
               if(_loc2_.x + _loc2_.width >= Math.abs(this.mcTileListHolder.x - this._tileListHolderOriginXPos))
               {
                  if(_loc2_.x - this._tileListWidth <= Math.abs(this.mcTileListHolder.x - this._tileListHolderOriginXPos))
                  {
                     _loc4_ = false;
                  }
               }
               if(_loc4_)
               {
                  this._tileListItems[_loc1_].parent.removeChild(this._tileListItems[_loc1_]);
               }
            }
            _loc1_++;
         }
      }
      
      public function selectCategoryTab(param1:int) : void
      {
         var _loc2_:BMGlobalShopTab = null;
         var _loc3_:int = 0;
         if(this._selectCategoryId == param1)
         {
            return;
         }
         if(this._selectCategoryId != -1)
         {
            this._tabsList[this._selectCategoryId].selected = false;
            _loc3_ = 0;
            while(_loc3_ < this._tabsList.length)
            {
               this.mcTabsHolder.addChildAt(this._tabsList[_loc3_],0);
               _loc3_++;
            }
         }
         this._selectCategoryId = param1;
         this._tabsList[this._selectCategoryId].selected = true;
         this.mcTabsHolder.addChild(this._tabsList[this._selectCategoryId]);
         this.setTabsXPosition();
      }
      
      public function setTabs(param1:Array) : void
      {
         var _loc3_:BMShopCategoryViewData = null;
         var _loc4_:BMGlobalShopTab = null;
         var _loc5_:Boolean = false;
         var _loc6_:Sprite = null;
         if(this.isNarrowInterface)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            if(BMShopManager.gi().useIconTabs)
            {
               _loc4_ = new BMGlobalShopIconTab();
            }
            else
            {
               _loc4_ = new BMGlobalShopTab();
            }
            _loc4_.title = _loc3_.name;
            _loc4_.counter = _loc3_.counter;
            _loc4_.selected = false;
            _loc5_ = _loc3_.id == BMShopManager.gi().category_unclaimed && dataM.minedTokens_showIndicatorInShopTab;
            _loc4_.minedTokensIndicator = _loc5_;
            _loc4_.id = _loc3_.id;
            if(BMShopManager.gi().useIconTabs)
            {
               switch(_loc4_.id)
               {
                  case BMShopManager.gi().category_tokens:
                     _loc6_ = new shopTabIcon_tokens();
                     break;
                  case BMShopManager.gi().category_itemBoxes:
                     _loc6_ = new shopTabIcon_itemBoxes();
                     break;
                  case BMShopManager.gi().category_gold:
                     _loc6_ = new shopTabIcon_gold();
                     break;
                  case BMShopManager.gi().category_premium:
                     _loc6_ = new shopTabIcon_premium();
                     break;
                  case BMShopManager.gi().category_unclaimed:
                     _loc6_ = new shopTabIcon_unclaimed();
                     break;
                  case BMShopManager.gi().category_customization:
                     _loc6_ = new shopTabIcon_customize();
                     break;
                  case BMShopManager.gi().category_mechs:
                     _loc6_ = new shopTabIcon_mechs();
               }
               _loc4_.setIcon(_loc6_);
               _loc4_.mcHitArea.addEventListener(MouseEvent.CLICK,this.onTabClick);
            }
            else
            {
               _loc4_.addEventListener(MouseEvent.CLICK,this.onTabClick);
            }
            this.mcTabsHolder.addChildAt(_loc4_,0);
            this._tabsList.push(_loc4_);
            _loc2_++;
         }
         this.setTabsXPosition();
      }
      
      private function setTabsXPosition() : void
      {
         var _loc5_:BMGlobalShopTab = null;
         if(this.isNarrowInterface)
         {
            return;
         }
         var _loc1_:uint = 118;
         var _loc2_:Number = 0;
         var _loc3_:uint = 230;
         if(BMShopManager.gi().useIconTabs)
         {
            _loc1_ = 76;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._tabsList.length)
         {
            _loc5_ = this._tabsList[_loc4_];
            if(BMShopManager.gi().useIconTabs)
            {
               _loc5_.x = _loc2_;
               if(this._selectCategoryId == _loc5_.id)
               {
                  _loc2_ += _loc3_;
               }
               else
               {
                  _loc2_ += _loc1_;
               }
            }
            else
            {
               _loc5_.x = _loc1_ * _loc4_;
            }
            _loc4_++;
         }
      }
      
      public function set tabsEnabled(param1:Boolean) : void
      {
         if(this.isNarrowInterface)
         {
            return;
         }
         this.mcTabsHolder.mouseEnabled = param1;
         this.mcTabsHolder.mouseChildren = param1;
      }
      
      public function setTabCounter(param1:int, param2:int) : void
      {
         if(this.isNarrowInterface)
         {
            return;
         }
         this._tabsList[param1].counter = param2;
      }
      
      private function onTabClick(param1:MouseEvent) : void
      {
         var _loc2_:BMGlobalShopTab = null;
         if(BMShopManager.gi().useIconTabs)
         {
            _loc2_ = param1.currentTarget.parent as BMGlobalShopTab;
         }
         else
         {
            _loc2_ = param1.currentTarget as BMGlobalShopTab;
         }
         if(tutorialM.isAllowedToClickOnMovieClip(_loc2_) == false)
         {
            return;
         }
         BMShopManager.gi().showCategory(_loc2_.id,BMShopManager.gi().currentScreenSource,true);
      }
      
      public function removeMinedTokensIndicator() : void
      {
         dataM.minedTokens_showIndicatorInShopTab = false;
         var _loc1_:BMGlobalShopTab = this._tabsList[BMShopManager.gi().category_unclaimed];
         _loc1_.minedTokensIndicator = false;
      }
      
      public function resetList() : void
      {
         this._tileListItems = new Array();
         this._dataArr = new Array();
         this.mcTileListHolder.tilesHolder.removeChildren();
      }
      
      private function get supportsErrorText() : Boolean
      {
         if(this.txtError == null)
         {
            return false;
         }
         if(dataM.runAsMobile && this.mcButtonsHolder == null)
         {
            return false;
         }
         return true;
      }
      
      public function setError(param1:String) : void
      {
         if(!this.supportsErrorText)
         {
            return;
         }
         this.resetList();
         this.txtError.visible = true;
         updateTextAndFormat(this.txtError,param1);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("globalShop_error",[this.txtError],"",this.mcButtonsHolder);
         }
      }
      
      private function hideError() : *
      {
         if(!this.supportsErrorText)
         {
            return;
         }
         if(!this.txtError.visible)
         {
            return;
         }
         this.txtError.visible = false;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("globalShop_error",[this.txtError],"",this.mcButtonsHolder);
         }
      }
      
      public function setTitle(param1:String) : void
      {
      }
      
      public function setItems(param1:Array, param2:Boolean = true, param3:uint = 0) : *
      {
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:BMShopItemViewData = null;
         this.hideError();
         this.resetList();
         this._dataArr = param1;
         var _loc4_:int = 0;
         while(_loc4_ < this._dataArr.length)
         {
            _loc5_ = false;
            _loc6_ = false;
            if(param3 > 0)
            {
               _loc7_ = this._dataArr[_loc4_];
               if(param3 == _loc7_.id)
               {
                  _loc6_ = true;
                  if(_loc4_ == 0)
                  {
                     _loc5_ = true;
                  }
               }
            }
            this.addItem(this._dataArr[_loc4_],_loc6_,_loc5_);
            _loc4_++;
         }
         this._scrollMax = this.mcTileListHolder.width - this._tileListWidth;
         if(param2)
         {
            this.resetScroller();
         }
         this.refreshItemsVisibility();
         if(tutorialM.isTutorialActive())
         {
            this.showTutorialArrow(0);
         }
      }
      
      public function showTutorialArrow(param1:int, param2:Boolean = false) : *
      {
         var _loc5_:int = 0;
         var _loc6_:BMTileListItem = null;
         var _loc3_:Number = this._tileListItems[param1].x + this._tileListItems[param1].width * 0.75;
         var _loc4_:Number = this._tileListItems[param1].y + this._tileListItems[param1].height / 2;
         this.activateTutorialArrow(_loc3_,_loc4_,0,10,true);
         if(param2)
         {
            _loc5_ = 0;
            while(_loc5_ < this._tileListItems.length)
            {
               _loc6_ = this._tileListItems[_loc5_];
               if(param1 == _loc5_)
               {
                  tutorialM.onlyClickableMovieClip = _loc6_.clickableObject;
               }
               else
               {
                  _loc6_.disableMe(true);
               }
               _loc5_++;
            }
         }
      }
      
      private function addItem(param1:BMShopItemViewData, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc5_:MovieClip = null;
         var _loc10_:uint = 0;
         var _loc11_:Number = NaN;
         var _loc4_:BMTileListItem = new BMTileListItem();
         var _loc6_:BMShopItemView = null;
         if(param1.viewCls != null)
         {
            _loc5_ = new param1.viewCls();
         }
         else
         {
            _loc5_ = new BMShopItemView();
         }
         if(_loc5_ is BMShopItemView)
         {
            _loc6_ = _loc5_ as BMShopItemView;
            _loc6_.setData(param1);
         }
         var _loc7_:BMItem = new BMItem();
         _loc7_.initialize(this._tileListItems.length,this._finalWidth,this._finalHeight,_loc5_,0,0,false,null,dataM.runAsMobile);
         var _loc8_:Function = this.tileListItemClicked;
         var _loc9_:Function = this.tileListItemMouseOver;
         if(dataM.runAsMobile)
         {
            _loc8_ = null;
            _loc9_ = null;
         }
         _loc4_.initialize(this._finalWidth,this._finalHeight,_loc7_,"","","",0,_loc8_,null,null,_loc9_,null,dataM.runAsMobile);
         if(_loc6_ != null)
         {
            _loc6_.setOverParent(_loc4_);
         }
         _loc4_.changeMouseOverEffect(new MovieClip());
         if(dataM.runAsMobile && _loc6_ != null)
         {
            _loc7_.createAssetsBitmap(_loc6_.getAllTextFields(),null,_loc5_.mcMobileTextHolder);
         }
         _loc4_.x = this._tileListItems.length * this._finalWidth;
         if(param2)
         {
            _loc10_ = 180;
            _loc11_ = _loc4_.x + 30;
            if(param3)
            {
               _loc10_ = 0;
               _loc11_ = _loc4_.x + _loc4_.width - 30;
            }
            this.activateTutorialArrow(_loc11_,_loc4_.y + _loc4_.height / 2,_loc10_,0,true,120);
         }
         if(param1.isDisabled)
         {
            _loc4_.disableMe(true);
         }
         this._tileListItems.push(_loc4_);
         this.mcTileListHolder.tilesHolder.addChild(_loc4_);
         this.mcTileListHolder.visible = true;
      }
      
      private function tileListItemClicked(param1:uint, param2:uint) : void
      {
         this.doItemSelect(param2);
      }
      
      private function tileListItemMouseOver(param1:uint, param2:uint) : void
      {
         soundM.createSound("buttonRollover",1);
      }
      
      private function doItemSelect(param1:uint) : *
      {
         if(this._onSelect == null)
         {
            return;
         }
         soundM.createSound("buttonClick",1);
         this.deactivateTutorialArrow();
         this._onSelect(this._dataArr[param1]);
      }
      
      public function set onSelect(param1:Function) : *
      {
         this._onSelect = param1;
      }
      
      private function activateTutorialArrow(param1:Number, param2:Number, param3:Number = 0, param4:uint = 0, param5:Boolean = false, param6:uint = 0) : void
      {
         if(this.mcTutorialArrow.parent != null)
         {
            this.mcTutorialArrow.parent.removeChild(this.mcTutorialArrow);
         }
         if(param5)
         {
            this.mcTileListHolder.tutorialArrowHolder.addChild(this.mcTutorialArrow);
         }
         else
         {
            addChild(this.mcTutorialArrow);
         }
         this._tutorialArrowPoint = new Point(param1,param2);
         this.mcTutorialArrow.x = param1;
         this.mcTutorialArrow.y = param2;
         this.mcTutorialArrow.rotation = param3;
         this._tutorialArrowDelayFrames = param4;
         if(this._tutorialArrowDelayFrames == 0)
         {
            this.mcTutorialArrow.visible = true;
         }
         this._tutorialArrowRemoveFrames = param6;
         this._tutorialArrowFrameCounter = 0;
         this._tutorialArrowActive = true;
      }
      
      private function deactivateTutorialArrow() : void
      {
         if(this.isNarrowInterface)
         {
            return;
         }
         this._tutorialArrowActive = false;
         this.mcTutorialArrow.visible = false;
      }
      
      private function tutorialArrowHandler() : void
      {
         if(this._tutorialArrowActive)
         {
            if(this._tutorialArrowDelayFrames > 0)
            {
               --this._tutorialArrowDelayFrames;
               if(this._tutorialArrowDelayFrames == 0)
               {
                  this.mcTutorialArrow.visible = true;
               }
            }
            else
            {
               ++this._tutorialArrowFrameCounter;
               if(this._tutorialArrowFrameCounter <= 10)
               {
                  this.mcTutorialArrow.mcArrow.x += 10 - this._tutorialArrowFrameCounter;
               }
               else if(this._tutorialArrowFrameCounter <= 20)
               {
                  this.mcTutorialArrow.mcArrow.x -= this._tutorialArrowFrameCounter - 10;
               }
               else
               {
                  this._tutorialArrowFrameCounter = 0;
                  this.mcTutorialArrow.mcArrow.x = 0;
               }
               if(this._tutorialArrowRemoveFrames > 0)
               {
                  --this._tutorialArrowRemoveFrames;
                  if(this._tutorialArrowRemoveFrames == 0)
                  {
                     this.deactivateTutorialArrow();
                  }
               }
            }
         }
      }
      
      public function refreshGoldTokensTexts() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Array = [];
         if(this.txtTokens != null)
         {
            this.txtTokens.text = TextUtils.getNumberWithComma(_loc1_.tokens);
            _loc2_.push(this.txtTokens);
         }
         if(this.txtGold != null)
         {
            this.txtGold.text = TextUtils.getNumberWithComma(_loc1_.gold);
            _loc2_.push(this.txtGold);
         }
         if(dataM.runAsMobile && _loc2_.length > 0)
         {
            screensM.createMultipleTextsBitmap("globalShop_goldAndTokens",_loc2_,"",this);
         }
      }
      
      public function buyGoldClicked() : void
      {
         if(dataM.runAsMobile && this.blockNextMobileClick)
         {
            return;
         }
         BMShopManager.gi().showGoldPackages();
      }
      
      public function buyTokensClicked() : void
      {
         if(this.blockNextMobileClick)
         {
            return;
         }
         dataM.openBuyTokensPage("GlobalShopPlus");
      }
      
      private function get scrollActive() : Boolean
      {
         return this._scrollActive || this._webScrollingActive;
      }
      
      private function borderButtonsHandler() : void
      {
         var _loc1_:int = this.getTargetTileIDMax();
         if(this._webScrollingTargetTileID > 0)
         {
            if(this.mcBorderButton1.alpha < 1)
            {
               this.mcBorderButton1.alpha += 0.2;
               if(this.mcBorderButton1.visible == false)
               {
                  this.mcBorderButton1.visible = true;
               }
            }
         }
         else if(this.mcBorderButton1.alpha > 0 && (!this.scrollActive || _loc1_ == 0))
         {
            this.mcBorderButton1.alpha -= 0.2;
            if(this.mcBorderButton1.alpha <= 0)
            {
               this.mcBorderButton1.visible = false;
            }
         }
         if(this._webScrollingTargetTileID < _loc1_)
         {
            if(this.mcBorderButton2.alpha < 1)
            {
               this.mcBorderButton2.alpha += 0.2;
               if(this.mcBorderButton2.visible == false)
               {
                  this.mcBorderButton2.visible = true;
               }
            }
         }
         else if(this.mcBorderButton2.alpha > 0 && (!this.scrollActive || _loc1_ == 0))
         {
            this.mcBorderButton2.alpha -= 0.2;
            if(this.mcBorderButton2.alpha <= 0)
            {
               this.mcBorderButton2.visible = false;
            }
         }
      }
      
      private function getTargetTileIDMax() : int
      {
         var _loc1_:int = this._tileListItems.length - 1 - 2;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      private function borderButtonLeftClicked(param1:Event) : void
      {
         this.previousClicked();
      }
      
      private function borderButtonRightClicked(param1:Event) : void
      {
         this.nextClicked();
      }
      
      private function scrollingOnEnterFrameMobile() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         if(this._scrollActive)
         {
            this._scrollXPos.push(mouseX);
            if(this._scrollXPos.length > 10)
            {
               this._scrollXPos.splice(0,1);
            }
            if(this._scrollXPos.length > 1)
            {
               this._scrollAbsoluteDeltaX += Math.abs(mouseX - this._scrollXPos[this._scrollXPos.length - 2]);
            }
         }
         if(this._scrollXPos.length > 0)
         {
            _loc1_ = 0;
            _loc2_ = 1;
            while(_loc2_ < this._scrollXPos.length)
            {
               _loc1_ += this._scrollXPos[_loc2_] - this._scrollXPos[_loc2_ - 1];
               _loc2_++;
            }
            _loc1_ /= this._scrollXPos.length - 1;
            if(_loc1_ > this._scrollingSpeed)
            {
               if(_loc1_ > this._scrollingSpeed + 15)
               {
                  _loc1_ = this._scrollingSpeed + 15;
               }
            }
            else if(_loc1_ < this._scrollingSpeed - 15)
            {
               _loc1_ = this._scrollingSpeed - 15;
            }
            this._scrollingSpeed = _loc1_;
            if(this._scrollingSpeed > 50)
            {
               this._scrollingSpeed = 50;
            }
            else if(this._scrollingSpeed < -50)
            {
               this._scrollingSpeed = -50;
            }
         }
         else if(this._scrollingSpeed > 0)
         {
            this._scrollingSpeed -= 0.5;
            if(this._scrollingSpeed < 0)
            {
               this._scrollingSpeed = 0;
            }
         }
         else
         {
            this._scrollingSpeed += 0.5;
            if(this._scrollingSpeed > 0)
            {
               this._scrollingSpeed = 0;
            }
         }
         if(this._scrollingSpeed == 0)
         {
            return;
         }
         this.mcTileListHolder.x += this._scrollingSpeed;
         if(this.mcTileListHolder.x > this._tileListHolderOriginXPos)
         {
            this.mcTileListHolder.x = this._tileListHolderOriginXPos;
         }
         else if(this.mcTileListHolder.x < -this._scrollMax + this._tileListHolderOriginXPos)
         {
            this.mcTileListHolder.x = -this._scrollMax + this._tileListHolderOriginXPos;
         }
         this.refreshItemsVisibility();
      }
      
      public function scrollerClicked() : void
      {
         if(this._screenJustOpened)
         {
            return;
         }
         if(this.blockNextMobileClick)
         {
            return;
         }
         var _loc1_:Boolean = false;
         if(this._scrollActive == false)
         {
            if(dataM.runAsMobile)
            {
               if(this._scrollAbsoluteDeltaX < 50)
               {
                  _loc1_ = true;
               }
            }
            else
            {
               _loc1_ = true;
            }
         }
         if(_loc1_ == false)
         {
            return;
         }
         if(Math.abs(this._scrollingSpeed) >= 2)
         {
            return;
         }
         var _loc2_:Number = Math.ceil((mouseX - (this.mcFingerWheeling.x + this.mcTileListHolder.x)) / this._finalWidth);
         if(this._tileListItems[_loc2_ - 1] == null)
         {
            return;
         }
         var _loc3_:BMTileListItem = this._tileListItems[_loc2_ - 1];
         if(_loc3_.isEnabled())
         {
            this.doItemSelect(_loc3_.item.ID);
         }
      }
      
      private function get canScroll() : *
      {
         return this._scrollMax > 0;
      }
      
      public function scrollMouseDown() : void
      {
         if(!this.canScroll)
         {
            return;
         }
         this._scrollActive = true;
         this._scrollAbsoluteDeltaX = 0;
         this._scrollXPos.push(mouseX);
      }
      
      public function scrollMouseUp() : void
      {
         this._scrollXPos = new Array();
         this._scrollActive = false;
      }
      
      private function resetScroller() : void
      {
         if(dataM.runAsMobile)
         {
            this.scrollMouseUp();
            if(this._scrollMax < 0)
            {
               this.mcTileListHolder.x = this._tileListHolderOriginXPos + this._scrollMax / -2;
            }
            else
            {
               this.mcTileListHolder.x = this._tileListHolderOriginXPos;
            }
            return;
         }
         this.setWebTargetScrolling(99,false);
         this.setWebTargetScrolling(0,true,8);
      }
      
      private function activeChainDiscountUpdated(param1:String, param2:Object) : void
      {
         var _loc5_:BMShopItemViewData = null;
         if(screensM.isScreenOpened(BMScreensManager.SCR_SHOP_ITEM_INFO))
         {
            return;
         }
         var _loc3_:BMGachaMachineData = dataM.getGacheMachine(param2.gachaMachineID);
         if(_loc3_.isInChainDiscount == false)
         {
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._dataArr.length)
         {
            _loc5_ = this._dataArr[_loc4_];
            if(_loc5_.id == param2.gachaMachineID)
            {
               this._onSelect(this._dataArr[_loc4_]);
               screensM.readdScreenIntoTopLayer(BMScreensManager.SCR_ITEM_CARDS);
               return;
            }
            _loc4_++;
         }
      }
      
      private function handleVIPAccountUpdated(param1:String, param2:Object) : void
      {
         BMShopManager.gi().refresh();
      }
      
      private function setWebTargetScrolling(param1:Number, param2:Boolean = true, param3:uint = 0) : void
      {
         if(dataM.runAsMobile)
         {
            return;
         }
         this._webScrollingTargetTileID = param1;
         var _loc4_:uint = uint(this.getTargetTileIDMax());
         if(this._webScrollingTargetTileID > _loc4_)
         {
            this._webScrollingTargetTileID = _loc4_;
         }
         else if(this._webScrollingTargetTileID < 0)
         {
            this._webScrollingTargetTileID = 0;
         }
         this._webScrollingTargetXPos = this._webScrollingTargetTileID * this._finalWidth * -1;
         if(param2)
         {
            this._webScrollingActive = true;
            this._webScrollingDelayFrames = param3;
            this._webScrollingTargetXPos = this._tileListHolderOriginXPos + this._webScrollingTargetXPos;
         }
         else
         {
            if(param1 >= 99)
            {
               this.mcTileListHolder.x = this._tileListHolderOriginXPos + this._webScrollingTargetXPos - 800;
            }
            else
            {
               this.mcTileListHolder.x = this._tileListHolderOriginXPos + this._webScrollingTargetXPos;
            }
            this.refreshItemsVisibility();
         }
         if(!this.canScroll)
         {
            this._webScrollingTargetXPos = this._tileListHolderOriginXPos + this._scrollMax / -2;
         }
         else if(this._webScrollingTargetXPos < -this._scrollMax + this._tileListHolderOriginXPos)
         {
            this._webScrollingTargetXPos = -this._scrollMax + this._tileListHolderOriginXPos;
         }
      }
      
      private function scrollingOnEnterFrameWeb() : void
      {
         if(this._webScrollingActive == false)
         {
            return;
         }
         if(this._webScrollingDelayFrames > 0)
         {
            --this._webScrollingDelayFrames;
            return;
         }
         if(Math.abs(this.mcTileListHolder.x - this._webScrollingTargetXPos) < 1)
         {
            this._webScrollingActive = false;
            this.mcTileListHolder.x = this._webScrollingTargetXPos;
            return;
         }
         var _loc1_:Number = (this._webScrollingTargetXPos - this.mcTileListHolder.x) * 0.15;
         this.mcTileListHolder.x += _loc1_;
         this.refreshItemsVisibility();
      }
      
      private function nextClicked() : void
      {
         this.setWebTargetScrolling(this._webScrollingTargetTileID + this.NUM_ITEMS_PER_PAGE,true);
      }
      
      private function previousClicked() : void
      {
         this.setWebTargetScrolling(this._webScrollingTargetTileID - this.NUM_ITEMS_PER_PAGE,true);
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
      }
      
      public function backClicked() : void
      {
         this.closeClicked();
      }
      
      private function screensDirectorStartedPerformingTasks(param1:String, param2:Object) : void
      {
         this.closeClicked();
      }
      
      public function closeClicked() : void
      {
         this.removeMe();
         BMShopManager.gi().notifyShopClosed();
      }
      
      public function removeMe() : *
      {
         screensM.removeScreen(BMScreensManager.SCR_GLOBAL_SHOP);
         if(screensM.isScreenOpened(BMScreensManager.SCR_SHOP_ITEM_INFO))
         {
            screensM.screenShopItemInfo.removeMe();
         }
      }
      
      private function onRemoved(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         BMShopManager.gi().resetLastCateogry();
         if(screensM.isScreenOpened(BMScreensManager.SCR_MORE_PAYMENT_OPTIONS))
         {
            screensM.screenMorePaymentOptions.backClicked();
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._tabsList.length)
         {
            this._tabsList[_loc2_].removeEventListener(MouseEvent.CLICK,this.onTabClick);
            _loc2_++;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
         {
            screensM.screenWelcomeBackground.welcomeBackHandlerSub();
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshGoldTokensTexts();
      }
   }
}

