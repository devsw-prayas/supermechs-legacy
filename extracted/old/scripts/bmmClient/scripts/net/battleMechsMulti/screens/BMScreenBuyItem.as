package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureC;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureD;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureF;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureI;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureK;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureL;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureM;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureN;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol499")]
   public class BMScreenBuyItem extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcItemHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtCostValueRed:TextField;
      
      public var txtCostValueOrange:TextField;
      
      public var txtCostTitle:TextField;
      
      public var txtItemBoxes:TextField;
      
      public var txtAmount:TextField;
      
      public var mcGold:Sprite;
      
      public var mcTokens:Sprite;
      
      public var mcSizer_item:Sprite;
      
      public var mcSizer_btnBack0:Sprite;
      
      public var mcSizer_btnBack1:Sprite;
      
      public var mcSizer_btnBack2:Sprite;
      
      public var mcSizer_btnBack3:Sprite;
      
      public var mcSizer_btnBack4:Sprite;
      
      public var mcSizer_btnBack5:Sprite;
      
      public var mcSizer_btnCancel:Sprite;
      
      public var mcSizer_btnBuy:Sprite;
      
      public var mcSizer_btnGetCredits:Sprite;
      
      public var mcSizer_btnGetTokens:Sprite;
      
      public var mcSizer_tooltipItem:Sprite;
      
      public var mcSizer_tooltipBox1:Sprite;
      
      public var mcSizer_tooltipBox2:Sprite;
      
      public var mcSizer_tooltipBox3:Sprite;
      
      public var mcSizer_btnPlus:Sprite;
      
      public var mcSizer_btnMinus:Sprite;
      
      public var btnBack0:BMButton_pictureI;
      
      public var btnBack1:BMButton_pictureE;
      
      public var btnBack2:BMButton_pictureL;
      
      public var btnBack3:BMButton_pictureK;
      
      public var btnBack4:BMButton_pictureM;
      
      public var btnBack5:BMButton_pictureN;
      
      public var btnCancel:BMButton_pictureC;
      
      public var btnBuy:BMButton_pictureD;
      
      public var btnGetCredits:BMButton_pictureF;
      
      public var btnGetTokens:BMButton_pictureK;
      
      public var btnPlus:BMButton_pictureE;
      
      public var btnMinus:BMButton_pictureE;
      
      public var mcBox1:MovieClip;
      
      public var mcBox2:MovieClip;
      
      public var mcBox3:MovieClip;
      
      public var mcBackground:MovieClip;
      
      public var mcTutorialArrow_buy:MovieClip;
      
      private var mcItem:BMItem;
      
      private var _showAmountButtons:Boolean;
      
      private var _amount:uint;
      
      private var _boxesLocations:Array;
      
      private var _boxesSize:Array;
      
      private var _itemID:uint;
      
      private var _specialStatus:uint;
      
      private var _itemOriginYPos:Number;
      
      private var _toolTipHitAreaOriginYPos:Number;
      
      private var _costOriginYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenBuyItem()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:uint) : void
      {
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         var _loc9_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("shopBuyItem");
            screensM.createButtonFromSizer("screenBuyItem","btnBack0","pictureI");
            screensM.createButtonFromSizer("screenBuyItem","btnBack1","pictureE");
            screensM.createButtonFromSizer("screenBuyItem","btnBack2","pictureL");
            screensM.createButtonFromSizer("screenBuyItem","btnBack3","pictureK");
            screensM.createButtonFromSizer("screenBuyItem","btnBack4","pictureM");
            screensM.createButtonFromSizer("screenBuyItem","btnBack5","pictureN");
            screensM.createButtonFromSizer("screenBuyItem","btnBuy","pictureD");
            screensM.createButtonFromSizer("screenBuyItem","btnCancel","pictureC");
            screensM.createButtonFromSizer("screenBuyItem","btnGetCredits","pictureF");
            screensM.createButtonFromSizer("screenBuyItem","btnGetTokens","pictureK");
            screensM.createButtonFromSizer("screenBuyItem","btnPlus","pictureE");
            screensM.createButtonFromSizer("screenBuyItem","btnMinus","pictureE");
            _loc4_ = this.backClicked;
            _loc5_ = this.buyClicked;
            _loc6_ = this.getCreditsClicked;
            _loc7_ = this.getTokensClicked;
            _loc8_ = this.plusClicked;
            _loc9_ = this.minusClicked;
            if(dataM.runAsMobile)
            {
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
               _loc9_ = null;
            }
            this.btnBack0.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this.btnBack1.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this.btnBack2.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this.btnBack3.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this.btnBack4.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this.btnBack5.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this.btnBuy.initialize("","",externalAssetsM.getAsset("general","interface_V"),null,_loc5_,dataM.runAsMobile);
            this.btnCancel.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this.btnGetCredits.initialize("","",externalAssetsM.getAsset("general","interface_getCredits"),null,_loc6_,dataM.runAsMobile);
            this.btnGetTokens.initialize("","",externalAssetsM.getAsset("general","interface_getTokens"),null,_loc7_,dataM.runAsMobile);
            this.btnPlus.initialize("","",externalAssetsM.getAsset("general","interface_plus"),null,_loc8_,dataM.runAsMobile);
            this.btnMinus.initialize("","",externalAssetsM.getAsset("general","interface_minus"),null,_loc9_,dataM.runAsMobile);
            if(dataM.runAsMobile == false)
            {
               this.btnGetCredits.buttonCore.addMouseOverListerner(this.getCreditsMouseOver);
               this.btnGetCredits.buttonCore.addMouseOutListerner(this.generalMouseOutSub);
               this.btnGetTokens.buttonCore.addMouseOverListerner(this.getTokensMouseOver);
               this.btnGetTokens.buttonCore.addMouseOutListerner(this.generalMouseOutSub);
            }
            this.btnBack0.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack1.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack2.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack3.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack4.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack5.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuy.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCancel.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnGetCredits.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnGetTokens.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPlus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnMinus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._costOriginYPos = this.txtCostValueOrange.y;
            this._itemOriginYPos = this.mcSizer_item.y;
            this._toolTipHitAreaOriginYPos = this.mcSizer_tooltipItem.y;
            this.languageUpdate();
            this._boxesLocations = new Array();
            this._boxesLocations.push(new Point(this.mcBox1.x,this.mcBox1.y));
            this._boxesLocations.push(new Point(this.mcBox2.x,this.mcBox2.y));
            this._boxesLocations.push(new Point(this.mcBox3.x,this.mcBox3.y));
            this._boxesSize = new Array();
            this._boxesSize.push(this.mcBox1.scaleX);
            this._boxesSize.push(this.mcBox2.scaleX);
            this._boxesSize.push(this.mcBox3.scaleX);
            this.mcBox1.mcGlow.visible = false;
            this.mcBox2.mcGlow.visible = false;
            this.mcBox3.mcGlow.visible = false;
            this._firstRefresh = false;
         }
         else
         {
            if(lastLanguageID != dataM.languageID)
            {
               this.languageUpdate();
            }
            if(dataM.runAsMobile == false)
            {
               this.btnGetCredits.buttonCore.addAllListeners();
               this.btnGetTokens.buttonCore.addAllListeners();
            }
         }
         this._itemID = param1;
         var _loc2_:BMItemData = new BMItemData();
         _loc2_ = dataM.itemsDB[this._itemID];
         this._specialStatus = _loc2_.specialStatus;
         if(dataM.isColorKit(this._itemID))
         {
            this._specialStatus = 0;
         }
         this._showAmountButtons = false;
         if(dataM.maxItemsPerOnePurchase > 1)
         {
            if(_loc2_.type != "perk" && _loc2_.specialStatus < 3)
            {
               this._showAmountButtons = true;
            }
         }
         this._amount = 1;
         if(this._showAmountButtons)
         {
            this.mcBackground.gotoAndStop(this._specialStatus * 2 + 2);
            this.btnMinus.visible = true;
            this.btnPlus.visible = true;
            this.btnPlus.enableMe();
            this.btnMinus.disableMe();
            this.txtAmount.text = "X " + this._amount;
            this.mcSizer_item.y = this._itemOriginYPos - 43;
            this.mcSizer_tooltipItem.y = this._toolTipHitAreaOriginYPos - 43;
         }
         else
         {
            this.mcBackground.gotoAndStop(this._specialStatus * 2 + 1);
            this.btnMinus.visible = false;
            this.btnPlus.visible = false;
            this.txtAmount.text = "";
            this.mcSizer_item.y = this._itemOriginYPos;
            this.mcSizer_tooltipItem.y = this._toolTipHitAreaOriginYPos;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerBuyItem_amount",[this.txtAmount],"",this);
         }
         this.mcBox1.visible = false;
         this.mcBox2.visible = false;
         this.mcBox3.visible = false;
         this.txtCostTitle.text = "";
         this.txtCostValueOrange.text = "";
         this.txtCostValueRed.text = "";
         this.txtItemBoxes.text = "";
         this.mcGold.visible = false;
         this.mcTokens.visible = false;
         this.btnBack0.visible = false;
         this.btnBack1.visible = false;
         this.btnBack2.visible = false;
         this.btnBack3.visible = false;
         this.btnBack4.visible = false;
         this.btnBack5.visible = false;
         this.btnCancel.enableMe();
         this.btnBack0.enableMe();
         this.btnBack1.enableMe();
         this.btnBack2.enableMe();
         this.btnBack3.enableMe();
         this.btnBack4.enableMe();
         this.btnBack5.enableMe();
         this["btnBack" + this._specialStatus].visible = true;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc3_.tutorialLevel < BMDataManager.TUTORIAL_LEVEL_MECH5)
         {
            this.mcTutorialArrow_buy.gotoAndStop("animOn");
         }
         else
         {
            this.mcTutorialArrow_buy.gotoAndStop("animOff");
         }
         this.refreshItemCost();
         this.resetBoxesSize();
         this.addItem(_loc2_,0);
         this.refreshTitle();
         if(dataM.runAsMobile == false)
         {
            this.mcSizer_tooltipItem.addEventListener(MouseEvent.MOUSE_OVER,this.itemMouseOver);
            this.mcSizer_tooltipItem.addEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
            this.mcSizer_tooltipBox1.addEventListener(MouseEvent.CLICK,this.boxClicked);
            this.mcSizer_tooltipBox1.addEventListener(MouseEvent.MOUSE_OVER,this.boxMouseOver);
            this.mcSizer_tooltipBox1.addEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
            this.mcSizer_tooltipBox2.addEventListener(MouseEvent.CLICK,this.boxClicked);
            this.mcSizer_tooltipBox2.addEventListener(MouseEvent.MOUSE_OVER,this.boxMouseOver);
            this.mcSizer_tooltipBox2.addEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
            this.mcSizer_tooltipBox3.addEventListener(MouseEvent.CLICK,this.boxClicked);
            this.mcSizer_tooltipBox3.addEventListener(MouseEvent.MOUSE_OVER,this.boxMouseOver);
            this.mcSizer_tooltipBox3.addEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
         }
      }
      
      private function languageUpdate() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc1_ = 26;
            _loc2_ = 20;
            _loc3_ = 18;
            _loc4_ = 0;
            switch(dataM.languageID)
            {
               case 3:
                  _loc1_ = 20;
                  _loc2_ = 18;
                  _loc4_ = 4;
                  break;
               case 5:
                  _loc1_ = 22;
                  _loc2_ = 18;
                  _loc4_ = 2;
                  break;
               case 9:
                  _loc3_ = 16;
            }
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtCostTitle,_loc2_);
            TextUtils.updateTextFormat(this.txtCostValueOrange,_loc1_);
            TextUtils.updateTextFormat(this.txtCostValueRed,_loc1_);
            TextUtils.updateTextFormat(this.txtItemBoxes,_loc3_);
            this.txtCostValueOrange.y = this._costOriginYPos + _loc4_;
            this.txtCostValueRed.y = this._costOriginYPos + _loc4_;
         }
      }
      
      private function refreshItemCost() : void
      {
         var _loc2_:BMItemData = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc2_ = new BMItemData();
         _loc2_ = dataM.itemsDB[this._itemID];
         this.btnBuy.visible = false;
         this.btnCancel.visible = false;
         this.btnGetCredits.visible = false;
         this.btnGetTokens.visible = false;
         switch(this._specialStatus)
         {
            case 0:
            case 1:
            case 2:
            case 5:
               this.txtCostTitle.text = getScreenText("cost");
               this.mcSizer_tooltipBox1.visible = false;
               this.mcSizer_tooltipBox2.visible = false;
               this.mcSizer_tooltipBox3.visible = false;
               this.btnCancel.visible = true;
               _loc3_ = "gold";
               switch(this._specialStatus)
               {
                  case 0:
                  case 1:
                     break;
                  case 2:
                     _loc3_ = "tokens";
                  case 5:
                     if(_loc2_.costTokens > 0)
                     {
                        _loc3_ = "tokens";
                     }
               }
               switch(_loc3_)
               {
                  case "gold":
                     _loc5_ = _loc2_.costGold * this._amount;
                     this.txtCostValueOrange.text = dataM.getNumberWithComma(_loc5_);
                     this.mcGold.visible = true;
                     if(_loc5_ <= _loc1_.gold)
                     {
                        this.btnBuy.visible = true;
                        this.btnBuy.enableMe();
                     }
                     else
                     {
                        this.btnGetCredits.visible = true;
                     }
                     break;
                  case "tokens":
                     _loc6_ = _loc2_.costTokens * this._amount;
                     this.txtCostValueRed.text = dataM.getNumberWithComma(_loc6_);
                     this.mcTokens.visible = true;
                     if(_loc6_ <= _loc1_.tokens)
                     {
                        this.btnBuy.visible = true;
                        this.btnBuy.enableMe();
                     }
                     else
                     {
                        this.btnGetTokens.visible = true;
                     }
               }
               break;
            case 3:
            case 4:
               _loc4_ = 18;
               switch(dataM.languageID)
               {
                  case 9:
                     _loc4_ = 16;
               }
               this.txtItemBoxes.htmlText = TextUtils.getTextFont(_loc4_) + getScreenText("onlyInBoxes");
               this.mcSizer_tooltipBox1.visible = true;
               this.mcSizer_tooltipBox2.visible = true;
               this.mcSizer_tooltipBox3.visible = true;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerBuyItem_costs",[this.txtCostValueOrange,this.txtCostValueRed,this.txtItemBoxes],"",this);
         }
      }
      
      private function refreshTitle() : void
      {
         var _loc1_:BMItemData = dataM.itemsDB[this._itemID];
         if(_loc1_.specialStatus == 4)
         {
            this.txtTitle.text = _loc1_.fullName;
         }
         else
         {
            this.txtTitle.text = getScreenText("title");
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerBuyItem_title",[this.txtTitle],"",this);
         }
      }
      
      public function plusClicked() : void
      {
         if(this._amount < dataM.maxItemsPerOnePurchase)
         {
            ++this._amount;
            this.btnMinus.enableMe();
            if(this._amount == dataM.maxItemsPerOnePurchase)
            {
               this.btnPlus.disableMe();
            }
            this.txtAmount.text = "X " + this._amount;
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("hangerBuyItem_amount",[this.txtAmount],"",this);
            }
            this.refreshItemCost();
         }
      }
      
      public function minusClicked() : void
      {
         if(this._amount > 1)
         {
            --this._amount;
            this.btnPlus.enableMe();
            if(this._amount == 1)
            {
               this.btnMinus.disableMe();
            }
            this.txtAmount.text = "X " + this._amount;
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("hangerBuyItem_amount",[this.txtAmount],"",this);
            }
            this.refreshItemCost();
         }
      }
      
      private function addItem(param1:BMItemData, param2:Number) : void
      {
         this.mcItem = new BMItem();
         this.mcItem.initialize(-1,this.mcSizer_item.width,this.mcSizer_item.height,externalAssetsM.getAsset(dataM.itemTypeSourceDB[param1.type],param1.grp),-1,-1,false,null,dataM.runAsMobile);
         this.mcItem.x = this.mcSizer_item.x;
         this.mcItem.y = this.mcSizer_item.y;
         if(param2 > 0)
         {
            dataM.colorItem(this.mcItem,param2);
         }
         this.mcItemHolder.addChild(this.mcItem);
      }
      
      public function backClicked() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.tutorialLevel < BMDataManager.TUTORIAL_LEVEL_MECH5)
         {
            screensM.screenHangerMenu.refreshTutorial();
         }
         this.removeMe();
      }
      
      public function buyClicked() : void
      {
         this.removeMe();
         BMShopManager.gi().tryToBuyItem(this._itemID,this._amount);
      }
      
      private function resetBoxesSize() : void
      {
         this.mcBox1.visible = false;
         this.mcBox2.visible = false;
         this.mcBox3.visible = false;
         switch(this._specialStatus)
         {
            case 4:
               this.mcBox1.visible = true;
               this.mcBox2.visible = true;
               this.mcBox3.visible = true;
               this.mcBox1.x = this._boxesLocations[0].x;
               this.mcBox1.y = this._boxesLocations[0].y;
               this.mcBox2.x = this._boxesLocations[1].x;
               this.mcBox2.y = this._boxesLocations[1].y;
               this.mcBox3.x = this._boxesLocations[2].x;
               this.mcBox3.y = this._boxesLocations[2].y;
               this.mcBox1.scaleX = this._boxesSize[0];
               this.mcBox1.scaleY = this._boxesSize[0];
               this.mcBox2.scaleX = this._boxesSize[1];
               this.mcBox2.scaleY = this._boxesSize[1];
               this.mcBox3.scaleX = this._boxesSize[2];
               this.mcBox3.scaleY = this._boxesSize[2];
         }
      }
      
      private function itemMouseOver(param1:MouseEvent) : void
      {
         this.itemMouseOverSub();
      }
      
      public function itemMouseOverSub() : void
      {
         tooltip.showToolTip("newsItem","",this._itemID);
         if(dataM.runAsMobile)
         {
            tooltip.allowRepositionForMobile = true;
         }
      }
      
      private function generalMouseOut(param1:MouseEvent) : void
      {
         this.generalMouseOutSub();
      }
      
      public function generalMouseOutSub() : void
      {
         this.resetBoxesSize();
         tooltip.hideToolTip();
      }
      
      private function boxClicked(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(int(param1.target.name.substr(param1.target.name.length - 1,1)));
         this.boxClickedSub(_loc2_);
      }
      
      public function boxClickedSub(param1:uint) : void
      {
         var _loc2_:uint = 0;
         if(screensM.screenBlack.isActive() == false && this.btnBuy.buttonCore.isButtonEnabled() && (this._specialStatus == 3 || this._specialStatus == 4))
         {
            switch(this._specialStatus)
            {
               case 4:
                  switch(param1)
                  {
                     case 1:
                        _loc2_ = 5;
                        break;
                     case 2:
                        _loc2_ = 6;
                        break;
                     case 3:
                        _loc2_ = 20;
                  }
                  break;
               default:
                  switch(param1)
                  {
                     case 1:
                        _loc2_ = 9;
                        break;
                     case 2:
                        _loc2_ = 5;
                        break;
                     case 3:
                        _loc2_ = 6;
                  }
            }
            dataM.packages_markSpecificPackageID = _loc2_;
            screensM.screenNewMenu.shopCombinedClicked();
         }
         this.backClicked();
      }
      
      public function getSpecialStatus() : uint
      {
         return this._specialStatus;
      }
      
      private function boxMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(int(param1.target.name.substr(param1.target.name.length - 1,1)));
         this.boxMouseOverSub(_loc2_);
      }
      
      public function boxMouseOverSub(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Sprite = null;
         switch(this._specialStatus)
         {
            case 4:
               if(dataM.runAsMobile == false)
               {
                  _loc3_ = this["mcBox" + param1];
                  _loc3_.scaleX = this._boxesSize[param1 - 1] * 1.16;
                  _loc3_.scaleY = this._boxesSize[param1 - 1] * 1.16;
               }
               switch(param1)
               {
                  case 1:
                     _loc2_ = 5;
                     break;
                  case 2:
                     _loc2_ = 6;
                     break;
                  case 3:
                     _loc2_ = 20;
               }
               break;
            default:
               if(dataM.runAsMobile == false)
               {
                  _loc3_ = this["mcBox" + param1];
                  _loc3_.x = this._boxesLocations[param1 - 1].x - _loc3_.width * 0.08;
                  _loc3_.y = this._boxesLocations[param1 - 1].y - _loc3_.height * 0.08;
                  _loc3_.scaleX = this._boxesSize[param1 - 1] * 1.16;
                  _loc3_.scaleY = this._boxesSize[param1 - 1] * 1.16;
               }
               switch(param1)
               {
                  case 1:
                     _loc2_ = 9;
                     break;
                  case 2:
                     _loc2_ = 5;
                     break;
                  case 3:
                     _loc2_ = 6;
               }
         }
         this.itemBoxTooltip(_loc2_);
      }
      
      private function itemBoxTooltip(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc7_:String = null;
         var _loc2_:BMBoostData = dataM.boostsDB[param1];
         var _loc5_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc5_.level >= dataM.levelForExpandedItemBox)
         {
            _loc3_ = dataM.levelForExpandedItemBox;
            _loc4_ = dataM.LEVEL_MAX;
         }
         else
         {
            _loc3_ = _loc5_.level - _loc2_.levelDifference;
            _loc4_ = _loc5_.level + _loc2_.levelDifference;
            if(_loc3_ < 2)
            {
               _loc3_ = 2;
            }
         }
         var _loc6_:Boolean = false;
         if(_loc2_.ratioMythical > 0)
         {
            _loc6_ = true;
         }
         if(_loc2_.ratioMythical == 100)
         {
            if(_loc2_.amount == 1)
            {
               _loc7_ = getSpecificText("packages_randomItemsTooltipOnlyMythical");
            }
            else
            {
               _loc7_ = getSpecificText("packages_randomItemsTooltipOnlyMythicals");
            }
         }
         else if(_loc6_)
         {
            _loc7_ = getSpecificText("packages_randomItemsTooltipWithMythical");
         }
         else
         {
            _loc7_ = getSpecificText("packages_randomItemsTooltip");
         }
         _loc7_ = dataM.replaceStringInText(_loc7_,"%ITEMS%",String(_loc2_.amount));
         _loc7_ = dataM.replaceStringInText(_loc7_,"%LEVEL1%",String(_loc3_));
         _loc7_ = dataM.replaceStringInText(_loc7_,"%LEVEL2%",String(_loc4_));
         _loc7_ = dataM.replaceStringInText(_loc7_,"%RARE%",String(_loc2_.ratioRare));
         _loc7_ = dataM.replaceStringInText(_loc7_,"%EPIC%",String(_loc2_.ratioEpic));
         _loc7_ = dataM.replaceStringInText(_loc7_,"%LEGENDARY%",String(_loc2_.ratioLegendary));
         _loc7_ = dataM.replaceStringInText(_loc7_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
         if(_loc2_.ratioMythical == 100)
         {
            _loc7_ = dataM.replaceStringInText(_loc7_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
            _loc7_ = dataM.replaceStringInText(_loc7_,"%COLOR3%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
            _loc7_ = dataM.replaceStringInText(_loc7_,"%RATIO%",String(_loc2_.ratioNewMythical));
         }
         else
         {
            _loc7_ = dataM.replaceStringInText(_loc7_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_RARE_ITEM + "\'>");
            _loc7_ = dataM.replaceStringInText(_loc7_,"%COLOR3%","<FONT COLOR=\'#" + dataM.COLOR_EPIC_ITEM + "\'>");
            _loc7_ = dataM.replaceStringInText(_loc7_,"%COLOR4%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
            if(_loc6_)
            {
               _loc7_ = dataM.replaceStringInText(_loc7_,"%MYTHICAL%",String(_loc2_.ratioMythical));
               _loc7_ = dataM.replaceStringInText(_loc7_,"%COLOR5%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
               _loc7_ = dataM.replaceStringInText(_loc7_,"%COLOR6%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
               _loc7_ = dataM.replaceStringInText(_loc7_,"%RATIO%",String(_loc2_.ratioNewMythical));
            }
         }
         tooltip.showToolTip("regularText",_loc7_);
         if(dataM.runAsMobile)
         {
            tooltip.allowRepositionForMobile = true;
         }
      }
      
      public function getCreditsClicked() : void
      {
         this.removeMe();
         screensM.screenTopBar.getGoldClicked();
         tooltip.hideToolTip();
      }
      
      public function getTokensClicked() : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
         }
         else
         {
            this.removeMe();
            dataM.openBuyTokensPage("ScreenBuyItem");
            tooltip.hideToolTip();
         }
      }
      
      private function getCreditsMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("getMoreCredits"),-1,-1);
         if(dataM.runAsMobile)
         {
            tooltip.allowRepositionForMobile = true;
         }
      }
      
      private function getTokensMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("getMoreTokens"),-1,-1);
         if(dataM.runAsMobile)
         {
            tooltip.allowRepositionForMobile = true;
         }
      }
      
      private function removeItem() : void
      {
         if(this.mcItem != null)
         {
            this.mcItem.removeMe();
            this.mcItem = null;
         }
         if(dataM.runAsMobile == false)
         {
            this.mcSizer_tooltipItem.removeEventListener(MouseEvent.MOUSE_OVER,this.itemMouseOver);
            this.mcSizer_tooltipItem.removeEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
            this.mcSizer_tooltipItem.addEventListener(MouseEvent.MOUSE_OVER,this.itemMouseOver);
            this.mcSizer_tooltipItem.addEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
            this.mcSizer_tooltipItem.addEventListener(MouseEvent.MOUSE_OVER,this.itemMouseOver);
            this.mcSizer_tooltipItem.addEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
            this.mcSizer_tooltipItem.addEventListener(MouseEvent.MOUSE_OVER,this.itemMouseOver);
            this.mcSizer_tooltipItem.addEventListener(MouseEvent.MOUSE_OUT,this.generalMouseOut);
            this.btnGetCredits.buttonCore.removeAllListeners();
            this.btnGetTokens.buttonCore.removeAllListeners();
         }
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened("screenBuyItem"))
         {
            this.removeItem();
            screensM.removeScreen("screenBuyItem");
            this.mcTutorialArrow_buy.gotoAndStop("animOff");
         }
      }
   }
}

