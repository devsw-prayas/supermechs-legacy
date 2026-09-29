package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItemCard;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol361")]
   public class BMScreenItemCards extends BMBaseScreen
   {
      
      public var mcEffectsHolder:MovieClip;
      
      public var mcBoxHolder:MovieClip;
      
      public var mcBoxReflectionHolder:Sprite;
      
      public var mcCardsHolder:Sprite;
      
      public var mcTinyCardsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcLightsHolder:Sprite;
      
      public var mcItemBoxClickHitArea:Sprite;
      
      public var mcTutorialArrow_card:MovieClip;
      
      public var mcTutorialMarker_card:MovieClip;
      
      public var mcTutorialArrow_button:MovieClip;
      
      public var mcTutorialMarker_button:MovieClip;
      
      public var mcSizer_btnOK:Sprite;
      
      public var btnOK:BMButton;
      
      public var mcTitle:MovieClip;
      
      public var mcFinger:Sprite;
      
      public var mcBackgroundLeft:Sprite;
      
      public var mcBackgroundRight:Sprite;
      
      public var mcBoxReflectionCover:Sprite;
      
      public var mcBoxGlow:Sprite;
      
      public var mcGfxCover:Sprite;
      
      private var _itemIDs:Array;
      
      private var _itemCards:Array;
      
      private var _boxAnimationActive:Boolean;
      
      private var _boxAnimationStatus:String;
      
      private var _boxCardCounter:uint;
      
      private var _boxCards:Array;
      
      private var _movingCards:Boolean;
      
      private var _motionType:String;
      
      private var _frameCounterBox:Number;
      
      private var _frameCounterCards:Number;
      
      private var _tutorialFrameCounter:Number;
      
      private var _titleOriginYPos:Number;
      
      private var _itemCardsClicked:Array;
      
      private var _itemCardsFlipped:Array;
      
      private var _backgroundLeftInitialXPos:Number;
      
      private var _backgroundRightInitialXPos:Number;
      
      private var _sparks:Array = new Array();
      
      private var _packageID:uint;
      
      private var mcBox:MovieClip;
      
      private var mcBoxReflection:MovieClip;
      
      private var _cardsTargetXPos:Array;
      
      private var _itemCardLights:Array;
      
      private var _clickToOpen:Boolean = false;
      
      private var _fingerOriginXPos:Number;
      
      private var _fingerOriginYPos:Number;
      
      private var _fingerFrameCounter:uint;
      
      public var closingScreen:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      private const CARDS_DISTANCE_FROM_BORDER:Number = 15;
      
      private const CARD_X_DISTANCE:Number = 6;
      
      private const CARD_WIDTH:Number = 150;
      
      private const CARD_Y_START:Number = 630;
      
      private const CARD_Y_START_BOX:Number = -250;
      
      private const CARD_Y_START_ADDON:Number = 40;
      
      private const CARD_Y_TARGET:Number = 126;
      
      private const BOX_TARGET_Y_POS:uint = 370;
      
      private const DELAY_FRAMES_BETWEEN_CARDS:Number = 2;
      
      private const OK_BUTTON_Y_JUMP:Number = 100;
      
      private const TITLE_Y_JUMP:Number = 100;
      
      public function BMScreenItemCards()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("itemCards");
      }
      
      public function refreshScreen(param1:Array, param2:uint = 0, param3:Boolean = false) : void
      {
         var _loc4_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenItemCards","btnOK","regular");
            _loc4_ = this.OKClicked;
            if(dataM.runAsMobile)
            {
               _loc4_ = null;
               this.btnOK.changeFontSize(34);
            }
            else
            {
               this.btnOK.changeFontSize(33);
            }
            this.btnOK.initialize(getGeneralText("OK"),"blue",null,null,_loc4_,dataM.runAsMobile);
            this.btnOK.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.mcTitle.txtTitle.text = getScreenText("title");
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("itemCards_title",[this.mcTitle.txtTitle],"",this.mcTitle);
            }
            this._titleOriginYPos = this.mcTitle.y;
            this.mcTutorialArrow_card.mouseEnabled = false;
            this.mcTutorialArrow_card.mouseChildren = false;
            this.mcTutorialMarker_card.mouseEnabled = false;
            this.mcTutorialMarker_card.mouseChildren = false;
            this.mcTutorialArrow_button.mouseEnabled = false;
            this.mcTutorialArrow_button.mouseChildren = false;
            this.mcTutorialMarker_button.mouseEnabled = false;
            this.mcTutorialMarker_button.mouseChildren = false;
            this.mcEffectsHolder.mouseEnabled = false;
            this.mcEffectsHolder.mouseChildren = false;
            this._backgroundLeftInitialXPos = this.mcBackgroundLeft.x;
            this._backgroundRightInitialXPos = this.mcBackgroundRight.x;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.closingScreen = false;
         this._itemIDs = param1;
         this._packageID = param2;
         this._clickToOpen = param3;
         this._itemCards = new Array();
         this._itemCardLights = new Array();
         this._frameCounterBox = 0;
         this._frameCounterCards = 0;
         this._tutorialFrameCounter = 0;
         this._motionType = "in";
         this.mcBoxGlow.visible = false;
         this.mcBoxGlow.scaleX = 0.05;
         this.mcBoxGlow.scaleY = 0.05;
         this.mcBoxReflectionCover.visible = true;
         this.btnOK.disableMe();
         this.mcBackgroundLeft.x = this._backgroundLeftInitialXPos;
         this.mcBackgroundRight.x = this._backgroundRightInitialXPos;
         this.mcTitle.y = this._titleOriginYPos;
         this.btnOK.y = this.mcSizer_btnOK.y;
         this.mcFinger.mouseEnabled = false;
         this.mcFinger.mouseChildren = false;
         this.mcFinger.visible = false;
         if(this._clickToOpen && dataM.runAsMobile == false)
         {
            this.mcItemBoxClickHitArea.addEventListener(MouseEvent.CLICK,this.itemBoxClicked);
         }
         this._fingerOriginXPos = this.mcFinger.x;
         this._fingerOriginYPos = this.mcFinger.y;
         this._boxAnimationActive = false;
         this._movingCards = false;
         if(param2 == 0)
         {
            this.createItemCards();
         }
         else
         {
            this.createBox();
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = 32;
            switch(dataM.languageID)
            {
               case 3:
                  _loc2_ = 30;
            }
            TextUtils.updateTextFormat(this.mcTitle.txtTitle,_loc2_);
            param1 = true;
         }
         if(param1)
         {
            if(dataM.runAsMobile)
            {
               this.btnOK.changeFontSize(34);
            }
            else
            {
               this.btnOK.changeFontSize(33);
            }
            this.btnOK.setButtonName(getGeneralText("OK"));
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.sparksHandler();
            this.cardsMotionHandler();
            this.boxMotionHandler();
            this.itemCardLightsHandler();
         }
      }
      
      public function itemCardClicked(param1:uint) : void
      {
         soundM.createSound("buttonClick",1);
         this.mcTutorialArrow_card.gotoAndStop("animOff");
         this.mcTutorialMarker_card.gotoAndStop("animOff");
         this._tutorialFrameCounter = 0;
         this._itemCardsClicked[param1] = true;
      }
      
      public function get itemCards() : Array
      {
         return this._itemCards;
      }
      
      private function boxMotionHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:BMItemData = null;
         var _loc4_:Sprite = null;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:BMBoostData = null;
         var _loc8_:uint = 0;
         var _loc9_:Sprite = null;
         if(this._boxAnimationActive)
         {
            _loc1_ = false;
            switch(this._boxAnimationStatus)
            {
               case "fallDown":
                  this.mcBox.y += 40;
                  this.mcBoxReflection.y -= 40;
                  if(this._frameCounterBox == 1)
                  {
                     this.mcBoxGlow.visible = true;
                  }
                  if(this.mcBoxGlow.scaleX < 1)
                  {
                     this.mcBoxGlow.scaleX += 0.1;
                     this.mcBoxGlow.scaleY += 0.1;
                  }
                  if(this.mcBox.y >= this.BOX_TARGET_Y_POS)
                  {
                     this.mcBox.y = this.BOX_TARGET_Y_POS;
                     this.mcBoxReflection.y = this.BOX_TARGET_Y_POS;
                     this._boxAnimationStatus = "waitBeforeOpen";
                     this._frameCounterBox = 0;
                     soundM.createSound("footStep",1);
                  }
                  break;
               case "waitBeforeOpen":
                  if(this._clickToOpen)
                  {
                     if(this._frameCounterBox >= 60)
                     {
                        if(this._frameCounterBox == 60)
                        {
                           this._fingerFrameCounter = 0;
                           this.mcFinger.visible = true;
                        }
                        ++this._fingerFrameCounter;
                        if(this._fingerFrameCounter <= 12)
                        {
                           this.mcFinger.x += (12 - this._fingerFrameCounter) / 2;
                           this.mcFinger.y -= (12 - this._fingerFrameCounter) / 2;
                        }
                        else if(this._fingerFrameCounter <= 24)
                        {
                           this.mcFinger.x -= (this._fingerFrameCounter - 12) / 2;
                           this.mcFinger.y += (this._fingerFrameCounter - 12) / 2;
                        }
                        else
                        {
                           this._fingerFrameCounter = 0;
                           this.mcFinger.x = this._fingerOriginXPos;
                           this.mcFinger.y = this._fingerOriginYPos;
                        }
                     }
                  }
                  else if(this._frameCounterBox >= 10)
                  {
                     this._boxAnimationStatus = "open";
                     this._frameCounterBox = 0;
                     soundM.createSound("openBox",1);
                  }
                  break;
               case "open":
                  if(this.mcBox.mcCover.y > -122)
                  {
                     this.mcBox.mcCover.y += (-123 - this.mcBox.mcCover.y) * 0.1;
                  }
                  else
                  {
                     this.mcBox.mcCover.y = -123;
                     this._boxAnimationStatus = "shootCards";
                     this._boxCardCounter = 0;
                     this._frameCounterBox = 0;
                  }
                  if(this._frameCounterBox == 1)
                  {
                     this.mcBox.mcOuterGlow.visible = true;
                  }
                  _loc1_ = true;
                  break;
               case "shootCards":
                  _loc2_ = false;
                  if(this._frameCounterBox == 1)
                  {
                     _loc2_ = true;
                  }
                  else if(this._itemIDs.length > 1 && this._boxCardCounter < this._itemIDs.length)
                  {
                     if(this._frameCounterBox == 1 + this._boxCardCounter * 3)
                     {
                        _loc2_ = true;
                     }
                  }
                  if(this.mcBoxGlow.scaleX > 0.1)
                  {
                     this.mcBoxGlow.scaleX -= 0.1;
                     this.mcBoxGlow.scaleY -= 0.1;
                     if(this.mcBoxGlow.scaleX <= 0.1)
                     {
                        this.mcBoxGlow.visible = false;
                     }
                  }
                  if(_loc2_)
                  {
                     _loc3_ = dataM.itemsDB[this._itemIDs[this._boxCardCounter]];
                     switch(_loc3_.specialStatus)
                     {
                        case 0:
                           _loc4_ = new grpItemCardBack0();
                           break;
                        case 1:
                           _loc4_ = new grpItemCardBack1();
                           break;
                        case 2:
                           _loc4_ = new grpItemCardBack2();
                           break;
                        case 3:
                           _loc4_ = new grpItemCardBack3();
                           break;
                        case 4:
                           _loc4_ = new grpItemCardBack4();
                     }
                     _loc4_.scaleX = 0.55;
                     _loc4_.scaleY = 0.55;
                     _loc5_ = 0;
                     if(this._itemIDs.length > 1)
                     {
                        _loc6_ = 45;
                        if(this._packageID > 20)
                        {
                           _loc7_ = dataM.boostsDB[this._packageID];
                           if(_loc7_.amount == 5)
                           {
                              _loc6_ = 25;
                           }
                           else if(_loc7_.amount == 4)
                           {
                              _loc6_ = 35;
                           }
                        }
                        _loc5_ = (this._boxCardCounter - (this._itemIDs.length - 1) / 2) * _loc6_;
                     }
                     _loc4_.x = _loc5_ - _loc4_.width / 2;
                     this._boxCards.push(_loc4_);
                     this.mcBox.mcCardsHolder.addChild(_loc4_);
                     soundM.createSound("cardFire",1);
                     ++this._boxCardCounter;
                  }
                  if(this._boxCards.length > 0)
                  {
                     _loc8_ = 0;
                     while(_loc8_ < this._boxCards.length)
                     {
                        _loc9_ = this._boxCards[_loc8_];
                        if(_loc9_.y > -600)
                        {
                           _loc9_.y -= 50;
                           if(_loc9_.y <= -600 && _loc9_.visible)
                           {
                              _loc9_.visible = false;
                           }
                        }
                        _loc8_++;
                     }
                  }
                  if(this._frameCounterBox == 17)
                  {
                     this.createItemCards();
                  }
                  else if(this._frameCounterBox > 17)
                  {
                     if(this.mcBox.visible)
                     {
                        this.mcBox.scaleX -= 0.05;
                        this.mcBox.scaleY -= 0.05;
                        this.mcBoxReflection.scaleX -= 0.05;
                        this.mcBoxReflection.scaleY += 0.05;
                        if(this.mcBox.scaleX <= 0.05)
                        {
                           this.mcBox.visible = false;
                           this.mcBoxReflection.visible = false;
                           this.mcBoxReflectionCover.visible = false;
                           this._boxAnimationActive = false;
                        }
                     }
                  }
            }
            if(_loc1_)
            {
               if(this.mcBox.mcOuterGlow.scaleX < 1)
               {
                  this.mcBox.mcOuterGlow.scaleX += 0.025;
                  this.mcBox.mcOuterGlow.scaleY += 0.025;
               }
            }
            ++this._frameCounterBox;
         }
      }
      
      private function itemBoxClicked(param1:MouseEvent) : void
      {
         this.itemBoxClickedSub();
      }
      
      public function itemBoxClickedSub() : void
      {
         if(this._boxAnimationStatus == "waitBeforeOpen" && this._clickToOpen)
         {
            this.mcFinger.visible = false;
            this._boxAnimationStatus = "open";
            this._frameCounterBox = 0;
            soundM.createSound("openBox",1);
            if(dataM.runAsMobile == false)
            {
               this.mcItemBoxClickHitArea.removeEventListener(MouseEvent.CLICK,this.itemBoxClicked);
            }
         }
      }
      
      public function waitingForBoxClick() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this._boxAnimationStatus == "waitBeforeOpen" && this._clickToOpen)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function createBox() : void
      {
         var _loc3_:String = null;
         var _loc4_:BMItemData = null;
         this._boxAnimationActive = true;
         this._boxCards = new Array();
         switch(this._packageID)
         {
            case 5:
               this.mcBox = new mcItemBox_5();
               this.mcBoxReflection = new grpItemBox_5_bottom();
               break;
            case 6:
               this.mcBox = new mcItemBox_6();
               this.mcBoxReflection = new grpItemBox_6_bottom();
               break;
            case 19:
               this.mcBox = new mcItemBox_19();
               this.mcBoxReflection = new grpItemBox_19_bottom();
               break;
            case 20:
               this.mcBox = new mcItemBox_20();
               this.mcBoxReflection = new grpItemBox_20_bottom();
               break;
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
               this.mcBox = new mcItemBox_regular();
               this.mcBoxReflection = new grpItemBox_regular_bottom();
               switch(this._packageID)
               {
                  case 21:
                     _loc3_ = "torsoLeg";
                     break;
                  case 22:
                     _loc3_ = "weapons";
                     break;
                  case 23:
                     _loc3_ = "specials";
                     break;
                  case 24:
                     _loc3_ = "modules";
                     break;
                  case 25:
                     _loc3_ = "mix";
               }
               this.mcBox.mcBottom.mcIcons.gotoAndStop(_loc3_);
               this.mcBoxReflection.mcIcons.gotoAndStop(_loc3_);
         }
         var _loc1_:uint = 1;
         var _loc2_:uint = 0;
         while(_loc2_ < this._itemIDs.length)
         {
            _loc4_ = dataM.itemsDB[this._itemIDs[_loc2_]];
            if(_loc1_ < _loc4_.specialStatus)
            {
               _loc1_ = _loc4_.specialStatus;
            }
            _loc2_++;
         }
         this.mcBox.mcInnerGlow.gotoAndStop(_loc1_);
         this.mcBox.mcOuterGlow.gotoAndStop(_loc1_);
         this.mcBox.x = 400;
         this.mcBox.y = -100;
         this.mcBoxReflection.x = 400;
         this.mcBoxReflection.y = 840;
         this.mcBoxReflection.scaleY = -1;
         this.mcBox.mcOuterGlow.visible = false;
         this.mcBox.mcOuterGlow.scaleX = 0.05;
         this.mcBox.mcOuterGlow.scaleY = 0.05;
         this.mcBoxReflectionCover.y = this.BOX_TARGET_Y_POS - 1;
         this.mcBoxReflectionHolder.addChild(this.mcBoxReflection);
         this.mcBoxHolder.addChild(this.mcBox);
         this._frameCounterBox = 0;
         this._boxAnimationStatus = "fallDown";
      }
      
      private function cardsMotionHandler() : void
      {
         if(this._movingCards)
         {
            if(this._packageID > 0)
            {
               this.cardsMotionHandler_afterBox();
            }
            else
            {
               this.cardsMotionHander_noBox();
            }
         }
      }
      
      private function cardsMotionHandler_afterBox() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:BMItemCard = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:BMItemData = null;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         ++this._frameCounterCards;
         ++this._tutorialFrameCounter;
         if(this._tutorialFrameCounter == 90)
         {
            _loc4_ = -1;
            _loc1_ = 0;
            while(_loc1_ < this._itemCardsClicked.length)
            {
               if(this._itemCardsClicked[_loc1_] == false)
               {
                  _loc4_ = _loc1_;
                  _loc1_ = this._itemCardsClicked.length;
               }
               _loc1_++;
            }
            if(_loc4_ > -1)
            {
               _loc3_ = this._itemCards[_loc4_];
               this.mcTutorialArrow_card.x = _loc3_.x;
               this.mcTutorialArrow_card.y = _loc3_.y + _loc3_.height;
               this.mcTutorialArrow_card.gotoAndStop("animOn");
               this.mcTutorialMarker_card.x = _loc3_.x - _loc3_.width / 2;
               this.mcTutorialMarker_card.y = _loc3_.y;
               this.mcTutorialMarker_card.gotoAndStop("animOn");
            }
         }
         switch(this._motionType)
         {
            case "in":
               _loc2_ = 0;
               while(_loc2_ < this._itemCards.length)
               {
                  if(this._frameCounterCards >= _loc2_ * this.DELAY_FRAMES_BETWEEN_CARDS)
                  {
                     _loc3_ = this._itemCards[_loc2_];
                     _loc7_ = this.CARD_Y_TARGET;
                     if(this._itemCards.length > 5)
                     {
                        if(_loc2_ < 5)
                        {
                           _loc7_ = this.CARD_Y_TARGET - this.CARD_Y_START_ADDON;
                        }
                        else
                        {
                           _loc7_ = this.CARD_Y_TARGET + this.CARD_Y_START_ADDON;
                        }
                     }
                     if(_loc3_.y < _loc7_)
                     {
                        _loc3_.y += (_loc7_ - _loc3_.y) * 0.2;
                        if(Math.abs(_loc3_.y - _loc7_) <= 1)
                        {
                           _loc3_.y = _loc7_;
                           _loc3_.enableClicks();
                           _loc8_ = dataM.itemsDB[this._itemIDs[_loc2_]];
                           this.createItemCardLight(_loc3_.x,_loc3_.y + _loc3_.height / 2,_loc2_,_loc8_.specialStatus);
                        }
                     }
                     else if(this._itemCardsClicked[_loc2_])
                     {
                        _loc9_ = 25;
                        if(_loc3_.mcCardBack.visible)
                        {
                           _loc3_.width -= _loc9_;
                           if(_loc3_.width <= _loc9_)
                           {
                              _loc3_.mcCardBack.visible = false;
                              _loc3_.mcCardFront.visible = true;
                           }
                        }
                        else if(_loc3_.width < 150)
                        {
                           _loc3_.width += _loc9_;
                        }
                        else
                        {
                           if(this._itemCardsFlipped[_loc2_] == false)
                           {
                              this._itemCardsFlipped[_loc2_] = true;
                              _loc3_.width = 150;
                              _loc3_.mcLightEffect.gotoAndPlay("animOn");
                           }
                           _loc10_ = true;
                           _loc1_ = 0;
                           while(_loc1_ < this._itemCardsClicked.length)
                           {
                              if(this._itemCardsClicked[_loc1_] == false)
                              {
                                 _loc10_ = false;
                                 _loc1_ = this._itemCardsClicked.length;
                              }
                              _loc1_++;
                           }
                           if(_loc10_)
                           {
                              _loc11_ = true;
                              _loc1_ = 0;
                              while(_loc1_ < this._itemCardsFlipped.length)
                              {
                                 if(this._itemCardsFlipped[_loc1_] == false)
                                 {
                                    _loc11_ = false;
                                    _loc1_ = this._itemCardsFlipped.length;
                                 }
                                 _loc1_++;
                              }
                              if(_loc11_)
                              {
                                 this._movingCards = false;
                                 this.btnOK.enableMe();
                                 if(dataM.isTutorialActive())
                                 {
                                    this.mcTutorialArrow_button.gotoAndStop("animOn");
                                    this.mcTutorialMarker_button.gotoAndStop("animOn");
                                 }
                              }
                           }
                        }
                     }
                  }
                  _loc2_++;
               }
               break;
            case "out":
               _loc2_ = 0;
               while(_loc2_ < this._itemCards.length)
               {
                  if(this._frameCounterCards >= _loc2_ * this.DELAY_FRAMES_BETWEEN_CARDS)
                  {
                     _loc3_ = this._itemCards[_loc2_];
                     _loc12_ = this.CARD_Y_START;
                     if(this._itemCards.length > 5)
                     {
                        if(_loc2_ < 5)
                        {
                           _loc12_ = this.CARD_Y_START - this.CARD_Y_START_ADDON;
                        }
                        else
                        {
                           _loc12_ = this.CARD_Y_START + this.CARD_Y_START_ADDON;
                        }
                     }
                     if(_loc3_.y < _loc12_)
                     {
                        _loc3_.y += (_loc12_ - _loc3_.y) * 0.2;
                        if(Math.abs(_loc12_ - _loc3_.y) <= 1)
                        {
                           _loc3_.y = _loc12_;
                           if(_loc2_ == this._itemCards.length - 1)
                           {
                              this._movingCards = false;
                              this.removeAllCards();
                              screensM.removeScreen("screenItemCards");
                           }
                        }
                     }
                  }
                  _loc2_++;
               }
               if(this.mcTitle.y > this._titleOriginYPos - this.TITLE_Y_JUMP)
               {
                  this.mcTitle.y += (this._titleOriginYPos - this.TITLE_Y_JUMP - this.mcTitle.y) * 0.15;
                  if(Math.abs(this._titleOriginYPos - this.TITLE_Y_JUMP - this.mcTitle.y) < 1)
                  {
                     this.mcTitle.y = this._titleOriginYPos - this.TITLE_Y_JUMP;
                  }
               }
               if(this.btnOK.y < this.mcSizer_btnOK.y + this.OK_BUTTON_Y_JUMP)
               {
                  this.btnOK.y += (this.mcSizer_btnOK.y + this.OK_BUTTON_Y_JUMP - this.btnOK.y) * 0.15;
                  if(Math.abs(this.mcSizer_btnOK.y + this.OK_BUTTON_Y_JUMP - this.btnOK.y) < 1)
                  {
                     this.btnOK.y = this.mcSizer_btnOK.y + this.OK_BUTTON_Y_JUMP;
                  }
               }
               _loc5_ = dataM.STAGE_WIDTH * 0.8;
               _loc6_ = 25;
               if(this.mcBackgroundLeft.x > -_loc5_)
               {
                  this.mcBackgroundLeft.x -= _loc6_;
                  this.mcBackgroundRight.x += _loc6_;
                  if(this.mcBackgroundLeft.x <= -_loc5_)
                  {
                     this.mcBackgroundLeft.x = -_loc5_;
                     this.mcBackgroundRight.x = dataM.STAGE_WIDTH + _loc5_;
                  }
               }
         }
      }
      
      private function cardsMotionHander_noBox() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:BMItemCard = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         ++this._frameCounterCards;
         ++this._tutorialFrameCounter;
         if(this._tutorialFrameCounter == 90)
         {
            _loc4_ = -1;
            _loc1_ = 0;
            while(_loc1_ < this._itemCardsClicked.length)
            {
               if(this._itemCardsClicked[_loc1_] == false)
               {
                  _loc4_ = _loc1_;
                  _loc1_ = this._itemCardsClicked.length;
               }
               _loc1_++;
            }
            if(_loc4_ > -1)
            {
               _loc3_ = this._itemCards[_loc4_];
               this.mcTutorialArrow_card.x = _loc3_.x;
               this.mcTutorialArrow_card.y = _loc3_.y + _loc3_.height;
               this.mcTutorialArrow_card.gotoAndStop("animOn");
               this.mcTutorialMarker_card.x = _loc3_.x - _loc3_.width / 2;
               this.mcTutorialMarker_card.y = _loc3_.y;
               this.mcTutorialMarker_card.gotoAndStop("animOn");
            }
         }
         switch(this._motionType)
         {
            case "in":
               _loc2_ = 0;
               while(_loc2_ < this._itemCards.length)
               {
                  if(this._frameCounterCards >= _loc2_ * this.DELAY_FRAMES_BETWEEN_CARDS)
                  {
                     _loc3_ = this._itemCards[_loc2_];
                     _loc7_ = this.CARD_Y_TARGET;
                     if(this._itemCards.length > 5)
                     {
                        if(_loc2_ < 5)
                        {
                           _loc7_ = this.CARD_Y_TARGET - this.CARD_Y_START_ADDON;
                        }
                        else
                        {
                           _loc7_ = this.CARD_Y_TARGET + this.CARD_Y_START_ADDON;
                        }
                     }
                     if(_loc3_.y > _loc7_)
                     {
                        _loc3_.y -= (_loc3_.y - _loc7_) * 0.2;
                        if(Math.abs(_loc3_.y - _loc7_) <= 1)
                        {
                           _loc3_.y = _loc7_;
                           _loc3_.enableClicks();
                        }
                     }
                     else if(this._itemCardsClicked[_loc2_])
                     {
                        _loc8_ = 25;
                        if(_loc3_.mcCardBack.visible)
                        {
                           _loc3_.width -= _loc8_;
                           if(_loc3_.width <= _loc8_)
                           {
                              _loc3_.mcCardBack.visible = false;
                           }
                        }
                        else if(_loc3_.width < 150)
                        {
                           _loc3_.width += _loc8_;
                        }
                        else
                        {
                           if(this._itemCardsFlipped[_loc2_] == false)
                           {
                              this._itemCardsFlipped[_loc2_] = true;
                              _loc3_.width = 150;
                              _loc3_.mcLightEffect.gotoAndPlay("animOn");
                           }
                           _loc9_ = true;
                           _loc1_ = 0;
                           while(_loc1_ < this._itemCardsClicked.length)
                           {
                              if(this._itemCardsClicked[_loc1_] == false)
                              {
                                 _loc9_ = false;
                                 _loc1_ = this._itemCardsClicked.length;
                              }
                              _loc1_++;
                           }
                           if(_loc9_)
                           {
                              _loc10_ = true;
                              _loc1_ = 0;
                              while(_loc1_ < this._itemCardsFlipped.length)
                              {
                                 if(this._itemCardsFlipped[_loc1_] == false)
                                 {
                                    _loc10_ = false;
                                    _loc1_ = this._itemCardsFlipped.length;
                                 }
                                 _loc1_++;
                              }
                              if(_loc10_)
                              {
                                 this._movingCards = false;
                                 this.btnOK.enableMe();
                                 if(dataM.isTutorialActive())
                                 {
                                    this.mcTutorialArrow_button.gotoAndStop("animOn");
                                    this.mcTutorialMarker_button.gotoAndStop("animOn");
                                 }
                              }
                           }
                        }
                     }
                  }
                  _loc2_++;
               }
               break;
            case "out":
               _loc2_ = 0;
               while(_loc2_ < this._itemCards.length)
               {
                  if(this._frameCounterCards >= _loc2_ * this.DELAY_FRAMES_BETWEEN_CARDS)
                  {
                     _loc3_ = this._itemCards[_loc2_];
                     _loc11_ = this.CARD_Y_START;
                     if(this._itemCards.length > 5)
                     {
                        if(_loc2_ < 5)
                        {
                           _loc11_ = this.CARD_Y_START - this.CARD_Y_START_ADDON;
                        }
                        else
                        {
                           _loc11_ = this.CARD_Y_START + this.CARD_Y_START_ADDON;
                        }
                     }
                     if(_loc3_.y < _loc11_)
                     {
                        _loc3_.y += (_loc11_ - _loc3_.y) * 0.2;
                        if(Math.abs(_loc11_ - _loc3_.y) <= 1)
                        {
                           _loc3_.y = _loc11_;
                           if(_loc2_ == this._itemCards.length - 1)
                           {
                              this._movingCards = false;
                              this.removeAllCards();
                              screensM.removeScreen("screenItemCards");
                           }
                        }
                     }
                  }
                  _loc2_++;
               }
               if(this.mcTitle.y > this._titleOriginYPos - this.TITLE_Y_JUMP)
               {
                  this.mcTitle.y += (this._titleOriginYPos - this.TITLE_Y_JUMP - this.mcTitle.y) * 0.15;
                  if(Math.abs(this._titleOriginYPos - this.TITLE_Y_JUMP - this.mcTitle.y) < 1)
                  {
                     this.mcTitle.y = this._titleOriginYPos - this.TITLE_Y_JUMP;
                  }
               }
               if(this.btnOK.y < this.mcSizer_btnOK.y + this.OK_BUTTON_Y_JUMP)
               {
                  this.btnOK.y += (this.mcSizer_btnOK.y + this.OK_BUTTON_Y_JUMP - this.btnOK.y) * 0.15;
                  if(Math.abs(this.mcSizer_btnOK.y + this.OK_BUTTON_Y_JUMP - this.btnOK.y) < 1)
                  {
                     this.btnOK.y = this.mcSizer_btnOK.y + this.OK_BUTTON_Y_JUMP;
                  }
               }
               _loc5_ = dataM.STAGE_WIDTH * 0.8;
               _loc6_ = 25;
               if(this.mcBackgroundLeft.x > -_loc5_)
               {
                  this.mcBackgroundLeft.x -= _loc6_;
                  this.mcBackgroundRight.x += _loc6_;
                  if(this.mcBackgroundLeft.x <= -_loc5_)
                  {
                     this.mcBackgroundLeft.x = -_loc5_;
                     this.mcBackgroundRight.x = dataM.STAGE_WIDTH + _loc5_;
                  }
               }
         }
      }
      
      private function createItemCards() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:BMItemCard = null;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         this._movingCards = true;
         this._itemCardsClicked = new Array();
         this._itemCardsFlipped = new Array();
         this._cardsTargetXPos = new Array();
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemIDs.length)
         {
            _loc4_ = new BMItemCard();
            _loc5_ = false;
            _loc6_ = uint(this._itemIDs[_loc1_]);
            if(dataM.isPowerKit(_loc6_))
            {
               _loc5_ = true;
            }
            _loc4_.initialize(_loc1_,"item",_loc6_,false,_loc5_);
            _loc4_.disableClicks();
            if(this._packageID > 0)
            {
               _loc3_ = this._itemIDs.length;
               _loc2_ = this.CARD_WIDTH * _loc3_ + (_loc3_ - 1) * this.CARD_X_DISTANCE;
               _loc4_.x = (dataM.STAGE_WIDTH - _loc2_) / 2 + _loc1_ * (this.CARD_WIDTH + this.CARD_X_DISTANCE) + 0.5 * this.CARD_WIDTH;
               _loc4_.y = this.CARD_Y_START_BOX;
            }
            else
            {
               _loc4_.mcCardFront.visible = true;
               if(_loc1_ < 5)
               {
                  _loc3_ = this._itemIDs.length;
                  if(this._itemIDs.length > 5)
                  {
                     _loc3_ = 5;
                  }
                  _loc2_ = this.CARD_WIDTH * _loc3_ + (_loc3_ - 1) * this.CARD_X_DISTANCE;
                  _loc4_.x = (dataM.STAGE_WIDTH - _loc2_) / 2 + _loc1_ * (this.CARD_WIDTH + this.CARD_X_DISTANCE) + 0.5 * this.CARD_WIDTH;
                  _loc4_.y = this.CARD_Y_START;
                  if(this._itemIDs.length > 5)
                  {
                     _loc4_.y = this.CARD_Y_START - this.CARD_Y_START_ADDON;
                  }
               }
               else
               {
                  _loc3_ = this._itemIDs.length - 5;
                  _loc2_ = this.CARD_WIDTH * _loc3_ + (_loc3_ - 1) * this.CARD_X_DISTANCE;
                  _loc4_.x = (dataM.STAGE_WIDTH - _loc2_) / 2 + (_loc1_ - 5) * (this.CARD_WIDTH + this.CARD_X_DISTANCE) + 0.5 * this.CARD_WIDTH;
                  _loc4_.y = this.CARD_Y_START + this.CARD_Y_START_ADDON;
               }
            }
            this.mcCardsHolder.addChild(_loc4_);
            this._itemCards.push(_loc4_);
            this._itemCardsClicked[_loc1_] = false;
            this._itemCardsFlipped[_loc1_] = false;
            _loc1_++;
         }
      }
      
      private function sparksHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMItemCard = null;
         var _loc3_:uint = 0;
         var _loc4_:Sprite = null;
         var _loc5_:Sprite = null;
         _loc1_ = 0;
         while(_loc1_ < this._itemCards.length)
         {
            _loc2_ = this._itemCards[_loc1_];
            if(_loc2_.rarity >= 3 && _loc2_.mcCardBack.visible)
            {
               if(_loc2_.glowCounter == -1)
               {
                  _loc2_.glowCounter = 100 + Math.ceil(Math.random() * 50);
               }
               else
               {
                  --_loc2_.glowCounter;
                  if(_loc2_.glowCounter <= 0)
                  {
                     _loc2_.mcLightEffect.gotoAndPlay("animOn");
                     _loc2_.glowCounter = 100 + Math.ceil(Math.random() * 50);
                  }
               }
               _loc3_ = Math.ceil(Math.random() * 15);
               if(_loc3_ == 1)
               {
                  _loc4_ = externalAssetsM.getAsset("general","Grp_itemCardSpark" + _loc2_.rarity,0,0,false,false);
                  _loc4_.x = _loc2_.x + 20 + Math.random() * (_loc2_.width - 40) - _loc2_.width / 2;
                  _loc4_.y = _loc2_.y + 15 + Math.random() * (_loc2_.height - 30);
                  this.mcEffectsHolder.addChild(_loc4_);
                  this._sparks.push(_loc4_);
               }
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._sparks.length)
         {
            _loc5_ = this._sparks[_loc1_];
            if(_loc5_.scaleX > 0.075)
            {
               _loc5_.scaleX -= 0.075;
               _loc5_.scaleY -= 0.075;
            }
            else
            {
               this._sparks[_loc1_].parent.removeChild(this._sparks[_loc1_]);
               this._sparks[_loc1_] = null;
               this._sparks.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      public function cardMouseOver(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:BMItemCard = null;
         if(this._movingCards == false)
         {
         }
      }
      
      public function cardMouseOut(param1:Number) : void
      {
      }
      
      private function createItemCardLight(param1:Number, param2:Number, param3:uint, param4:uint) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(param4 > 0)
         {
            switch(param4)
            {
               case 1:
                  _loc5_ = new mcItemCardLight1();
                  _loc6_ = 0.4;
                  _loc7_ = 0.5;
                  break;
               case 2:
                  _loc5_ = new mcItemCardLight2();
                  _loc6_ = 0.4;
                  _loc7_ = 0.6;
                  break;
               case 3:
                  _loc5_ = new mcItemCardLight3();
                  _loc6_ = 0.4;
                  _loc7_ = 0.75;
                  break;
               case 4:
                  _loc5_ = new mcItemCardLight4();
                  _loc6_ = 0.4;
                  _loc7_ = 0.9;
            }
            _loc5_.x = param1;
            _loc5_.y = param2;
            _loc5_.scaleX = _loc6_;
            _loc5_.scaleY = _loc6_;
            _loc5_.scaleMax = _loc7_;
            _loc5_.scaleStatus = "enter";
            _loc5_.cardID = param3;
            this.mcLightsHolder.addChild(_loc5_);
            this._itemCardLights.push(_loc5_);
         }
      }
      
      private function itemCardLightsHandler() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = NaN;
         var _loc1_:uint = 0;
         for(; _loc1_ < this._itemCardLights.length; _loc1_++)
         {
            _loc2_ = this._itemCardLights[_loc1_];
            if(this._itemCardsClicked[_loc2_.cardID])
            {
               if(_loc2_.scaleX > 0.05)
               {
                  _loc2_.scaleX -= 0.08;
                  _loc2_.scaleY -= 0.08;
               }
               continue;
            }
            switch(_loc2_.scaleStatus)
            {
               case "enter":
                  if(_loc2_.scaleMax > _loc2_.scaleX + 0.01)
                  {
                     _loc3_ = (_loc2_.scaleMax - _loc2_.scaleX) * 0.25;
                     _loc2_.scaleX += _loc3_;
                     _loc2_.scaleY += _loc3_;
                  }
                  else
                  {
                     _loc2_.scaleStatus = "shrink";
                  }
                  break;
               case "shrink":
                  if(_loc2_.mcLight1.scaleX > 0.94)
                  {
                     _loc2_.mcLight1.scaleX -= 0.003;
                     _loc2_.mcLight1.scaleY -= 0.003;
                     _loc2_.mcLight2.scaleX += 0.003;
                     _loc2_.mcLight2.scaleY += 0.003;
                  }
                  else
                  {
                     _loc2_.scaleStatus = "expand";
                  }
                  break;
               case "expand":
                  if(_loc2_.mcLight2.scaleX > 0.94)
                  {
                     _loc2_.mcLight2.scaleX -= 0.003;
                     _loc2_.mcLight2.scaleY -= 0.003;
                     _loc2_.mcLight1.scaleX += 0.003;
                     _loc2_.mcLight1.scaleY += 0.003;
                  }
                  else
                  {
                     _loc2_.scaleStatus = "shrink";
                  }
            }
         }
      }
      
      private function removeAllItemCardLights() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:uint = 0;
         while(_loc1_ <= this._itemCardLights.length)
         {
            if(this._itemCardLights[_loc1_] != null)
            {
               _loc2_ = this._itemCardLights[_loc1_];
               if(_loc2_.parent != null)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               _loc2_ = null;
               this._itemCardLights[_loc1_] = null;
            }
            _loc1_++;
         }
         this._itemCardLights = new Array();
      }
      
      public function maskAnimDone() : void
      {
      }
      
      public function OKClicked() : void
      {
         this._movingCards = true;
         this._frameCounterCards = 0;
         this._motionType = "out";
         this.mcBoxReflectionCover.visible = false;
         this.mcGfxCover.visible = false;
         if(dataM.runAsMobile == false)
         {
            this.mcItemBoxClickHitArea.removeEventListener(MouseEvent.CLICK,this.itemBoxClicked);
         }
         this.btnOK.disableMe();
         this.closingScreen = true;
         this.mcTutorialArrow_button.gotoAndStop("animOff");
         this.mcTutorialMarker_button.gotoAndStop("animOff");
         this.removeAllItemCardLights();
         if(!screensM.isScreenOpened("screenGlobalShop"))
         {
            if(screensM.isScreenOpened("screenLevelUp"))
            {
               screensM.screenLevelUp.itemCardsScreenClosed();
            }
            else if(screensM.isScreenOpened("screenHangerInventory"))
            {
               screensM.screenHangerInventory.itemCardsScreenClosed();
            }
            else if(screensM.isScreenOpened("screenMissionCompleted"))
            {
               screensM.screenMissionCompleted.itemCardsScreenClosed();
            }
            else if(screensM.isScreenOpened("screenMissionWorldMap"))
            {
               screensM.screenMissionWorldMap.openBuyAnotherItemBoxScreen();
            }
            else if(screensM.isScreenOpened("screenDailyLoginStreakBonus"))
            {
               screensM.screenDailyLoginStreakBonus.closeScreen();
            }
            else if(screensM.isScreenOpened("screenBuyStarterPack"))
            {
               screensM.screenNewMenu.hangerMechClicked(true);
            }
         }
         if(dataM.canCreateServerGeneratedUser())
         {
            dataM.createServerGeneratedUser();
         }
      }
      
      private function removeAllCards() : void
      {
         var _loc2_:BMItemCard = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemCards.length)
         {
            _loc2_ = this._itemCards[_loc1_];
            _loc2_.removeMe();
            _loc1_++;
         }
         this._itemCards = new Array();
      }
      
      public function removeScreenInstantly() : void
      {
         this.removeAllCards();
         this.removeAllItemCardLights();
         this._movingCards = false;
         this.closingScreen = false;
         this.mcTutorialArrow_button.gotoAndStop("animOff");
         this.mcTutorialMarker_button.gotoAndStop("animOff");
         if(dataM.runAsMobile == false)
         {
            this.mcItemBoxClickHitArea.removeEventListener(MouseEvent.CLICK,this.itemBoxClicked);
         }
         screensM.removeScreen("screenItemCards");
      }
   }
}

