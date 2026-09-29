package net.battleMechsMulti.screens.shop
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureD;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol383")]
   public class BMScreenGlobalShop extends BMBaseScreen
   {
      
      public static const NUM_OF_CATEGORIES:int = 5;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcTileListHolder:MovieClip;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnClose:Sprite;
      
      public var mcSizer_btnBuyGold:Sprite;
      
      public var mcSizer_btnBuyTokens:Sprite;
      
      public var mcSizer_btnPrevious:Sprite;
      
      public var mcSizer_btnNext:Sprite;
      
      public var mcSizer_tileListMobile:Sprite;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcEffectsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtError:TextField;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnClose:BMButton_pictureE;
      
      public var btnBuyGold:BMButton_pictureD;
      
      public var btnBuyTokens:BMButton_pictureD;
      
      public var btnNext:BMButton_pictureD;
      
      public var btnPrevious:BMButton_pictureD;
      
      public var txtTokens:TextField;
      
      public var txtGold:TextField;
      
      public var mcCategory0:MovieClip;
      
      public var mcCategory1:MovieClip;
      
      public var mcCategory2:MovieClip;
      
      public var mcCategory3:MovieClip;
      
      public var mcCategory4:MovieClip;
      
      public var mcBorderButton1:MovieClip;
      
      public var mcBorderButton2:MovieClip;
      
      public var mcTutorialArrow:MovieClip;
      
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
      
      private var _lastCategoryClicked:Number = -1;
      
      private var _firstRefresh:Boolean = true;
      
      private const ITEM_WIDTH_MOBILE:uint = 218;
      
      private const ITEM_HEIGHT_MOBILE:uint = 322;
      
      private var _onSelect:Function;
      
      private var _dataArr:Array;
      
      private var _isCategoriesOpen:Boolean = false;
      
      private var _tutorialArrowActive:Boolean = false;
      
      private var _tutorialArrowFrameCounter:uint;
      
      private var _tutorialArrowRemoveFrames:uint;
      
      private var _tutorialArrowDelayFrames:uint;
      
      private var _tutorialArrowPoint:Point;
      
      private var _tutorialArrowAngle:Number;
      
      private var _borderButtonHidden:Boolean;
      
      private const NUM_ITEMS_PER_PAGE:int = 3;
      
      public function BMScreenGlobalShop()
      {
         super();
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMScreenGlobalShop initializing");
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("globalShop");
         this.initCategories();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenGlobalShop","btnBack","pictureE");
            screensM.createButtonFromSizer("screenGlobalShop","btnClose","pictureE");
            screensM.createButtonFromSizer("screenGlobalShop","btnBuyGold","pictureD");
            screensM.createButtonFromSizer("screenGlobalShop","btnBuyTokens","pictureD");
            _loc1_ = this.backClicked;
            _loc2_ = this.closeClicked;
            _loc3_ = this.buyGoldClicked;
            _loc4_ = this.buyTokensClicked;
            _loc5_ = this.nextClicked;
            _loc6_ = this.previousClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
            }
            this.btnClose.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,_loc1_,dataM.runAsMobile);
            this.btnBuyGold.initialize("","",externalAssetsM.getAsset("general","interface_plus"),null,_loc3_,dataM.runAsMobile);
            this.btnBuyTokens.initialize("","",externalAssetsM.getAsset("general","interface_plus"),null,_loc4_,dataM.runAsMobile);
            this.btnBuyGold.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuyTokens.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnClose.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._tileListWidth = this.mcSizer_tileListMobile.width;
            this._finalWidth = this.ITEM_WIDTH_MOBILE;
            this._finalHeight = this.ITEM_HEIGHT_MOBILE;
            if(dataM.runAsMobile)
            {
               this.mcSizer_btnNext.parent.removeChild(this.mcSizer_btnNext);
               this.mcSizer_btnPrevious.parent.removeChild(this.mcSizer_btnPrevious);
            }
            else
            {
               screensM.createButtonFromSizer("screenGlobalShop","btnNext","pictureD");
               screensM.createButtonFromSizer("screenGlobalShop","btnPrevious","pictureD");
               this.btnNext.initialize("","",externalAssetsM.getAsset("general","interface_arrowRight"),null,_loc5_,dataM.runAsMobile);
               this.btnPrevious.initialize("","",externalAssetsM.getAsset("general","interface_arrowLeft"),null,_loc6_,dataM.runAsMobile);
               this.btnNext.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               this.btnPrevious.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
               this.mcEffectsHolder.mouseEnabled = false;
               this.mcEffectsHolder.mouseChildren = false;
            }
            if(dataM.runAsMobile == false)
            {
               this.mcBorderButton1.addEventListener(MouseEvent.CLICK,this.borderButtonLeftClicked);
               this.mcBorderButton1.addEventListener(MouseEvent.MOUSE_OVER,this.borderButtonMouseOver);
               this.mcBorderButton1.addEventListener(MouseEvent.MOUSE_OUT,this.borderButtonMouseOut);
               this.mcBorderButton2.addEventListener(MouseEvent.CLICK,this.borderButtonRightClicked);
               this.mcBorderButton2.addEventListener(MouseEvent.MOUSE_OVER,this.borderButtonMouseOver);
               this.mcBorderButton2.addEventListener(MouseEvent.MOUSE_OUT,this.borderButtonMouseOut);
            }
            this.mcTileListHolder.tilesHolder = new Sprite();
            this.mcTileListHolder.tutorialArrowHolder = new Sprite();
            this.mcTileListHolder.addChild(this.mcTileListHolder.tilesHolder);
            this.mcTileListHolder.addChild(this.mcTileListHolder.tutorialArrowHolder);
            this._tileListHolderOriginXPos = this.mcTileListHolder.x;
            this.mcTutorialArrow.mouseEnabled = false;
            this.mcTutorialArrow.mouseChildren = false;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.deactivateTutorialArrow();
         this._borderButtonHidden = false;
         if(dataM.isTutorialActive())
         {
            this._borderButtonHidden = true;
            this.mcBorderButton1.visible = false;
            this.mcBorderButton2.visible = false;
         }
         if(dataM.isTutorialActive())
         {
            this.btnBack.visible = false;
            this.btnClose.visible = false;
            this.btnBuyGold.visible = false;
            this.btnBuyTokens.visible = false;
         }
         else
         {
            this.btnClose.visible = true;
            this.btnBuyGold.visible = true;
            this.btnBuyTokens.visible = true;
         }
         this.refreshGoldTokensTexts();
         dataM.trackScreenView("shop");
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
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
            this.tutorialArrowHandler();
         }
      }
      
      private function refreshItemsVisibility() : void
      {
         var _loc2_:BMTileListItem = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
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
      
      public function initCategories() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < NUM_OF_CATEGORIES)
         {
            _loc2_ = this["mcCategory" + _loc1_];
            _loc2_.visible = true;
            _loc2_.orgWidth = _loc2_.width;
            _loc2_.orgHeight = _loc2_.height;
            if(!dataM.runAsMobile)
            {
               _loc2_.addEventListener(MouseEvent.CLICK,this.onCategoryClick);
               _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onCategoryMouseOver);
               _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.onCategoryMouseOut);
               _loc2_.addEventListener(MouseEvent.MIDDLE_MOUSE_UP,this.onCategoryMouseOut);
            }
            _loc1_++;
         }
      }
      
      public function setCategories(param1:Array, param2:Array = null) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:BMShopCategoryData = null;
         var _loc6_:Sprite = null;
         this.resetList();
         this.hideError();
         this.btnBack.visible = false;
         this._isCategoriesOpen = true;
         this.setTitle(getScreenText("shop"));
         var _loc3_:int = 0;
         while(_loc3_ < NUM_OF_CATEGORIES)
         {
            _loc4_ = this["mcCategory" + _loc3_];
            _loc5_ = param1[_loc3_];
            TextUtils.updateTextFormat(_loc4_.txtTitle);
            _loc4_.txtTitle.text = _loc5_.name;
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("globalShopCategory" + _loc3_,[_loc4_.txtTitle],"",_loc4_);
            }
            _loc4_.scaleX = 1;
            _loc4_.scaleY = 1;
            _loc6_ = externalAssetsM.getAsset("general",_loc5_.imageName);
            _loc6_.width = _loc4_.orgWidth;
            _loc6_.height = _loc4_.orgHeight;
            _loc6_.x = -_loc4_.width / 2;
            _loc6_.y = -_loc4_.height / 2;
            _loc4_.mcGrpHolder.removeChildren();
            _loc4_.mcGrpHolder.addChild(_loc6_);
            _loc4_.id = _loc5_.id;
            if(_loc5_.counter > 0)
            {
               if(_loc5_.counter > 9)
               {
                  _loc4_.mcCounter.txtAmount.text = "9+";
               }
               else
               {
                  _loc4_.mcCounter.txtAmount.text = _loc5_.counter;
               }
               _loc4_.mcCounter.visible = true;
            }
            else
            {
               _loc4_.mcCounter.visible = false;
            }
            _loc4_.mcDisabled.visible = false;
            if(param2 != null)
            {
               if(param2[_loc3_])
               {
                  _loc4_.mcDisabled.visible = true;
               }
            }
            _loc4_.visible = false;
            _loc4_.scaleX = 0.1;
            _loc4_.scaleY = 0.1;
            _loc4_.animationStatus = "grow";
            TweenMax.fromTo(_loc4_,0.2,{
               "visible":true,
               "delay":_loc3_ * 0.1
            },{
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut,
               "delay":_loc3_ * 0.1
            });
            _loc3_++;
         }
         if(dataM.isTutorialActive())
         {
            this.activateTutorialArrow(this.mcTutorialArrow.x,this.mcTutorialArrow.y,90,10);
         }
         if(!dataM.runAsMobile)
         {
            this.btnNext.visible = false;
            this.btnPrevious.visible = false;
         }
      }
      
      private function resetCategory(param1:MovieClip) : void
      {
         TweenMax.killTweensOf(param1);
         param1.scaleX = 1;
         param1.scaleY = 1;
         param1.visible = true;
      }
      
      public function get isCategoriesOpen() : Boolean
      {
         return this._isCategoriesOpen;
      }
      
      private function onCategoryClick(param1:MouseEvent) : void
      {
         this.onCategoryClickSub(param1.target.parent.id);
      }
      
      private function onCategoryMouseOver(param1:MouseEvent) : void
      {
         var _loc3_:MovieClip = null;
         if(this._lastCategoryClicked > -1)
         {
            return;
         }
         var _loc2_:uint = uint(param1.target.parent.id);
         if(BMShopManager.gi().isCategoryInTutorialBlock(_loc2_) == false)
         {
            _loc3_ = this["mcCategory" + _loc2_];
            TweenMax.to(_loc3_,0.1,{
               "scaleX":1.07,
               "scaleY":1.07
            });
            soundM.createSound("buttonRollover",1);
         }
      }
      
      private function onCategoryMouseOut(param1:MouseEvent) : void
      {
         if(this._lastCategoryClicked > -1)
         {
            return;
         }
         var _loc2_:uint = uint(param1.target.parent.id);
         var _loc3_:MovieClip = this["mcCategory" + _loc2_];
         TweenMax.to(_loc3_,0.2,{
            "scaleX":1,
            "scaleY":1
         });
      }
      
      public function onCategoryClickSub(param1:int) : void
      {
         if(this._lastCategoryClicked == param1)
         {
            return;
         }
         var _loc2_:MovieClip = this["mcCategory" + param1];
         this.resetCategory(_loc2_);
         if(BMShopManager.gi().isCategoryInTutorialBlock(param1) == false)
         {
            soundM.createSound("buttonClick",1);
            if(BMShopManager.gi().isCategoryInGuestBlock(param1) == false)
            {
               this._lastCategoryClicked = param1;
               this.deactivateTutorialArrow();
            }
            if(param1 == BMShopManager.CAT_TOKENS)
            {
               dataM.openBuyTokensPage("GlobalShopCategory");
            }
            else
            {
               BMShopManager.gi().showCategory(param1,BMShopManager.gi().currentScreenSource);
            }
         }
      }
      
      private function hideCategories() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this._isCategoriesOpen = false;
         if(dataM.isTutorialActive())
         {
            this.btnBack.visible = false;
         }
         else
         {
            this.btnBack.visible = true;
         }
         if(this._lastCategoryClicked > -1)
         {
            _loc1_ = 0;
            while(_loc1_ < NUM_OF_CATEGORIES)
            {
               _loc2_ = this["mcCategory" + _loc1_];
               TweenMax.killTweensOf(_loc2_);
               if(_loc1_ == this._lastCategoryClicked)
               {
                  TweenMax.to(_loc2_,0.075,{
                     "scaleX":1.2,
                     "scaleY":1.2,
                     "onComplete":this.shrinkSelectedCategory,
                     "onCompleteParams":[_loc2_]
                  });
               }
               else
               {
                  TweenMax.to(_loc2_,0.2,{
                     "visible":false,
                     "scaleX":0.1,
                     "scaleY":0.1
                  });
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < NUM_OF_CATEGORIES)
            {
               this["mcCategory" + _loc1_].visible = false;
               _loc1_++;
            }
         }
      }
      
      private function shrinkSelectedCategory(param1:MovieClip) : void
      {
         TweenMax.to(param1,0.2,{
            "visible":false,
            "scaleX":0.1,
            "scaleY":0.1
         });
      }
      
      public function resetList() : void
      {
         this._tileListItems = new Array();
         this._dataArr = new Array();
         this.mcTileListHolder.tilesHolder.removeChildren();
      }
      
      public function setError(param1:String) : void
      {
         this.resetList();
         this.hideCategories();
         this.txtError.visible = true;
         this.txtError.htmlText = TextUtils.getTextFont(20) + param1;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("globalShop_error",[this.txtError],"",this.mcButtonsHolder);
         }
      }
      
      private function hideError() : *
      {
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
         this.txtTitle.text = param1;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("globalShop_title",[this.txtTitle],"",this);
         }
      }
      
      public function setItems(param1:Array, param2:Boolean = true, param3:uint = 0) : *
      {
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:BMShopItemData = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         this.hideCategories();
         this.hideError();
         if(!dataM.runAsMobile)
         {
            this.btnNext.visible = true;
            this.btnPrevious.visible = true;
         }
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
         this.resetScroller(param2);
         this.refreshItemsVisibility();
         if(dataM.isTutorialActive())
         {
            _loc8_ = this._tileListItems[0].x + this._tileListItems[0].width;
            _loc9_ = this._tileListItems[0].y + this._tileListItems[0].height / 2;
            this.activateTutorialArrow(_loc8_,_loc9_,0,10,true);
         }
      }
      
      private function addItem(param1:BMShopItemData, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc9_:uint = 0;
         var _loc10_:Number = NaN;
         var _loc4_:BMTileListItem = new BMTileListItem();
         var _loc5_:BMShopItemView = new BMShopItemView();
         _loc5_.setData(param1);
         var _loc6_:BMItem = new BMItem();
         _loc6_.initialize(this._tileListItems.length,this._finalWidth,this._finalHeight,_loc5_,0,0,false,null,dataM.runAsMobile);
         var _loc7_:Function = this.tileListItemClicked;
         var _loc8_:Function = this.tileListItemMouseOver;
         if(dataM.runAsMobile)
         {
            _loc7_ = null;
            _loc8_ = null;
         }
         _loc4_.initialize(this._finalWidth,this._finalHeight,_loc6_,"","","",0,_loc7_,null,null,_loc8_,null,dataM.runAsMobile);
         if(param1.specialBanner > 0)
         {
            _loc5_.mcRollOverEffect.gotoAndStop(2);
         }
         _loc4_.changeMouseOverEffect(_loc5_.mcRollOverEffect);
         if(dataM.runAsMobile)
         {
            _loc6_.createAssetsBitmap(_loc5_.getAllTextFields(),null,_loc5_.mcMobileTextHolder);
         }
         _loc4_.x = this._tileListItems.length * this._finalWidth;
         if(param2)
         {
            _loc9_ = 180;
            _loc10_ = _loc4_.x + 30;
            if(param3)
            {
               _loc9_ = 0;
               _loc10_ = _loc4_.x + _loc4_.width - 30;
            }
            this.activateTutorialArrow(_loc10_,_loc4_.y + _loc4_.height / 2,_loc9_,0,true,120);
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
         this.txtTokens.text = dataM.getNumberWithComma(_loc1_.tokens);
         this.txtGold.text = dataM.getNumberWithComma(_loc1_.gold);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("globalShop_goldAndTokens",[this.txtTokens,this.txtGold],"",this);
         }
      }
      
      public function buyGoldClicked() : void
      {
         BMShopManager.gi().showBuyGold();
      }
      
      public function buyTokensClicked() : void
      {
         dataM.openBuyTokensPage("GlobalShopPlus");
      }
      
      private function get scrollActive() : Boolean
      {
         return this._scrollActive || this._webScrollingActive;
      }
      
      private function borderButtonsHandler() : void
      {
         var _loc1_:uint = 0;
         if(this._isCategoriesOpen)
         {
            if(this.mcBorderButton1.alpha > 0)
            {
               this.mcBorderButton1.alpha -= 0.2;
               if(this.mcBorderButton1.alpha <= 0)
               {
                  this.mcBorderButton1.visible = false;
               }
            }
            if(this.mcBorderButton2.alpha > 0)
            {
               this.mcBorderButton2.alpha -= 0.2;
               if(this.mcBorderButton2.alpha <= 0)
               {
                  this.mcBorderButton2.visible = false;
               }
            }
         }
         else
         {
            _loc1_ = this._tileListItems.length - 1 - 2;
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
            else if(this.mcBorderButton1.alpha > 0 && !this.scrollActive)
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
            else if(this.mcBorderButton2.alpha > 0 && !this.scrollActive)
            {
               this.mcBorderButton2.alpha -= 0.2;
               if(this.mcBorderButton2.alpha <= 0)
               {
                  this.mcBorderButton2.visible = false;
               }
            }
         }
      }
      
      private function borderButtonLeftClicked(param1:MouseEvent) : void
      {
         soundM.createSound("buttonClick",1);
         this.previousClicked();
      }
      
      private function borderButtonRightClicked(param1:MouseEvent) : void
      {
         soundM.createSound("buttonClick",1);
         this.nextClicked();
      }
      
      private function borderButtonMouseOver(param1:MouseEvent) : void
      {
         param1.target.gotoAndStop(2);
         soundM.createSound("buttonRollover",1);
      }
      
      private function borderButtonMouseOut(param1:MouseEvent) : void
      {
         param1.target.gotoAndStop(1);
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
         if(this._scrollingSpeed != 0)
         {
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
      }
      
      public function scrollerClicked() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:BMTileListItem = null;
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
         if(_loc1_)
         {
            if(Math.abs(this._scrollingSpeed) < 2)
            {
               _loc2_ = Math.ceil((mouseX - (this.mcFingerWheeling.x + this.mcTileListHolder.x)) / this._finalWidth);
               _loc3_ = this._tileListItems[_loc2_ - 1];
               if(_loc3_.isEnabled())
               {
                  this.doItemSelect(_loc3_.item.ID);
               }
            }
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
      
      private function resetScroller(param1:Boolean = true) : void
      {
         if(dataM.runAsMobile)
         {
            this.scrollMouseUp();
            if(param1)
            {
               if(this._scrollMax < 0)
               {
                  this.mcTileListHolder.x = this._tileListHolderOriginXPos + this._scrollMax / -2;
               }
               else
               {
                  this.mcTileListHolder.x = this._tileListHolderOriginXPos;
               }
            }
            return;
         }
         if(param1)
         {
            this.setWebTargetScrolling(99,false);
         }
         if(this._lastCategoryClicked > -1)
         {
            this.setWebTargetScrolling(0,true,8);
         }
         else
         {
            this.setWebTargetScrolling(0,true);
         }
      }
      
      private function setWebTargetScrolling(param1:Number, param2:Boolean = true, param3:uint = 0) : void
      {
         if(dataM.runAsMobile)
         {
            return;
         }
         this._webScrollingTargetTileID = param1;
         var _loc4_:uint = this._tileListItems.length - 1 - 2;
         if(this._webScrollingTargetTileID > _loc4_)
         {
            this._webScrollingTargetTileID = _loc4_;
         }
         else if(this._webScrollingTargetTileID < 0)
         {
            this._webScrollingTargetTileID = 0;
         }
         if(this._webScrollingTargetTileID == 0)
         {
            this.btnPrevious.disableMe();
         }
         else
         {
            this.btnPrevious.enableMe();
         }
         if(this._webScrollingTargetTileID == _loc4_)
         {
            this.btnNext.disableMe();
         }
         else
         {
            this.btnNext.enableMe();
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
         var _loc1_:Number = NaN;
         if(this._webScrollingActive)
         {
            if(this._webScrollingDelayFrames > 0)
            {
               --this._webScrollingDelayFrames;
            }
            else if(Math.abs(this.mcTileListHolder.x - this._webScrollingTargetXPos) < 1)
            {
               this._webScrollingActive = false;
               this.mcTileListHolder.x = this._webScrollingTargetXPos;
            }
            else
            {
               _loc1_ = (this._webScrollingTargetXPos - this.mcTileListHolder.x) * 0.15;
               this.mcTileListHolder.x += _loc1_;
               this.refreshItemsVisibility();
            }
         }
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
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,25);
            TextUtils.updateTextFormat(this.txtError,20);
            _loc2_ = 22;
            switch(dataM.languageID)
            {
               case 4:
                  _loc2_ = 28;
            }
            TextUtils.updateTextFormat(this.txtGold,_loc2_);
            TextUtils.updateTextFormat(this.txtTokens,_loc2_);
         }
         if(param1)
         {
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("globalShop_title",[this.txtTitle],"",this);
         }
      }
      
      public function backClicked() : void
      {
         this._lastCategoryClicked = -1;
         if(this._isCategoriesOpen)
         {
            this.closeClicked();
         }
         else
         {
            this.deactivateTutorialArrow();
            BMShopManager.gi().showCategoriesScreen(BMShopManager.gi().currentScreenSource);
         }
      }
      
      public function closeClicked() : void
      {
         this.removeMe();
         BMShopManager.gi().notifyShopClosed();
      }
      
      public function removeMe() : *
      {
         screensM.removeScreen("screenGlobalShop");
      }
      
      private function onRemoved(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         BMShopManager.gi().resetLastCateogry();
         if(screensM.isScreenOpened("screenMorePaymentOptions"))
         {
            screensM.screenMorePaymentOptions.backClicked();
         }
         if(!dataM.runAsMobile)
         {
            while(_loc2_ < NUM_OF_CATEGORIES)
            {
               _loc3_ = this["mcCategory" + _loc2_];
               this.resetCategory(_loc3_);
               _loc3_.removeEventListener(MouseEvent.CLICK,this.onCategoryClick);
               _loc2_++;
            }
         }
         if(screensM.isScreenOpened("screenWelcomeBackground"))
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

