package net.battleMechsMulti.screens.shop
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.TextUtils;
   import net.battleMechsMulti.utils.TimeUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2455")]
   public class BMShopItemView extends BMBaseClass
   {
      
      public static const CARD_OPTIONS_EMPTY:String = "empty";
      
      public static const CARD_OPTIONS_RARE_TO_LEGENDARY:String = "rareToLegendary";
      
      public static const CARD_OPTIONS_EPIC_TO_MYTHICAL:String = "epicToMythical";
      
      public static const CARD_OPTIONS_MYTH1:String = "mythical1";
      
      public static const CARD_OPTIONS_MYTH3:String = "mythical3";
      
      public var txtTitleTop:TextField;
      
      public var txtTitleBottom:TextField;
      
      public var txtBody:TextField;
      
      public var txtBonus:TextField;
      
      public var txtTimeLeftBottom:TextField;
      
      public var txtTwoRows:TextField;
      
      public var txtPriceNoIcon:TextField;
      
      public var mcPriceWithIcon:IconAndText;
      
      public var mcDefaultPriceWithIcon:IconAndText;
      
      public var mcSalePatch:MovieClip;
      
      public var mcRollOverEffect:MovieClip;
      
      public var mcMobileTextHolder:Sprite;
      
      public var mcSaleTimer:MovieClip;
      
      public var mcBanner:MovieClip;
      
      public var mcGrpHolder:MovieClip;
      
      public var mcCardOptions:MovieClip;
      
      private var _timer:Timer;
      
      private var _shopItemData:BMShopItemData;
      
      public function BMShopItemView()
      {
         super();
         generateSingletonClassesPointers("");
         this.updateTexstsFormats();
         this.mcRollOverEffect.visible = false;
      }
      
      private function updateTexstsFormats() : void
      {
         TextUtils.updateTextFormat(this.txtTitleTop,25);
         TextUtils.updateTextFormat(this.txtTitleBottom,25);
         TextUtils.updateTextFormat(this.txtBody,35);
         TextUtils.updateTextFormat(this.txtBonus,17);
         TextUtils.updateTextFormat(this.txtTimeLeftBottom,20);
         TextUtils.updateTextFormat(this.mcPriceWithIcon.textField,27);
         TextUtils.updateTextFormat(this.mcDefaultPriceWithIcon.textField,27);
         TextUtils.updateTextFormat(this.mcSaleTimer.txtTimeLeft,20);
      }
      
      public function getAllTextFields() : Array
      {
         return [this.txtTitleTop,this.txtTitleBottom,this.txtBody,this.txtBonus,this.txtPriceNoIcon];
      }
      
      public function setData(param1:BMShopItemData) : void
      {
         this._shopItemData = param1;
         if(this._shopItemData.moveGrpHolderUpPixels > 0)
         {
            this.mcGrpHolder.y -= this._shopItemData.moveGrpHolderUpPixels;
         }
         if(this._shopItemData.moveBonusTextUpPixels > 0)
         {
            this.txtBonus.y -= this._shopItemData.moveBonusTextUpPixels;
         }
         this.txtTimeLeftBottom.text = "";
         this.mcSaleTimer.txtTimeLeft.text = "";
         var _loc2_:uint = 25;
         var _loc3_:String = param1.titleTop;
         if(_loc3_ == "")
         {
            _loc3_ = param1.titleBottom;
         }
         if(_loc3_.length > 34)
         {
            _loc2_ = 18;
         }
         else if(_loc3_.length > 24)
         {
            _loc2_ = 20;
         }
         if(param1.titleTop != "")
         {
            this.txtTitleTop.htmlText = TextUtils.getTextFont(_loc2_) + _loc3_;
            this.txtTitleBottom.text = "";
         }
         else
         {
            this.txtTitleBottom.htmlText = TextUtils.getTextFont(_loc2_) + _loc3_;
            this.txtTitleTop.text = "";
         }
         this.txtBody.text = param1.bodyText;
         this.txtBonus.text = param1.bonusText;
         this.txtTwoRows.htmlText = param1.twoRowsText;
         this.setCardOptions(param1);
         this.setCardImg(param1.imagePath,param1.imageName);
         this.setBanner(param1.specialBanner);
         this.mcPriceWithIcon.visible = false;
         this.mcDefaultPriceWithIcon.visible = false;
         this.txtPriceNoIcon.visible = false;
         this.mcSalePatch.visible = false;
         if(param1.timerEnd > 0)
         {
            this.startTimer(param1.timerEnd);
         }
         if(param1.timerEnd == 0 || param1.useBottomTimer == false)
         {
            this.setPrice(param1);
         }
      }
      
      private function setBanner(param1:uint) : *
      {
         if(param1 == 0)
         {
            this.mcBanner.visible = false;
            return;
         }
         this.mcBanner.visible = true;
         this.mcBanner.gotoAndStop(param1);
      }
      
      private function setPrice(param1:BMShopItemData) : *
      {
         switch(param1.currency)
         {
            case BMShopItemData.CURRENCY_TYPE_GOLD:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("gold");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = param1.price;
               break;
            case BMShopItemData.CURRENCY_TYPE_TOKENS:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("tokens");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = param1.price;
               break;
            case BMShopItemData.CURRENCY_TYPE_MONEY:
            case BMShopItemData.CURRENCY_TYPE_FREE:
               this.txtPriceNoIcon.visible = true;
               this.txtPriceNoIcon.text = param1.price;
         }
         if(param1.discount > 0)
         {
            this.mcSalePatch.visible = true;
            this.mcSalePatch.txtDiscount.text = param1.discount + "%";
         }
         if(param1.defaultPrice != "0")
         {
            switch(param1.currency)
            {
               case BMShopItemData.CURRENCY_TYPE_GOLD:
                  this.mcDefaultPriceWithIcon.mcIcon.gotoAndStop("goldDefault");
                  this.mcDefaultPriceWithIcon.visible = true;
                  this.mcDefaultPriceWithIcon.text = param1.defaultPrice;
                  break;
               case BMShopItemData.CURRENCY_TYPE_TOKENS:
                  this.mcDefaultPriceWithIcon.mcIcon.gotoAndStop("tokensDefault");
                  this.mcDefaultPriceWithIcon.visible = true;
                  this.mcDefaultPriceWithIcon.activateGrayText();
                  this.mcDefaultPriceWithIcon.text = param1.defaultPrice;
            }
         }
      }
      
      private function setCardImg(param1:String, param2:String) : *
      {
         var itemImage:Sprite = null;
         var imagePath:String = param1;
         var imageName:String = param2;
         this.mcGrpHolder.removeChildren();
         try
         {
            itemImage = externalAssetsM.getAsset(imagePath,imageName);
            if(imagePath == "items3")
            {
               itemImage.x -= itemImage.width / 2;
               itemImage.y -= itemImage.height / 2;
            }
            else
            {
               itemImage.width = width;
               itemImage.height = height;
               this.mcGrpHolder.x = 0;
               this.mcGrpHolder.y = 0;
            }
            this.mcGrpHolder.addChild(itemImage);
         }
         catch(e:Error)
         {
            TsLogger.log("BMShopItemView::setData " + e.message);
         }
      }
      
      private function setCardOptions(param1:BMShopItemData) : void
      {
      }
      
      private function startTimer(param1:int) : void
      {
         this.mcPriceWithIcon.visible = false;
         this.txtPriceNoIcon.visible = false;
         var _loc2_:Number = param1 - BMDataManager.getInstance().currentTime;
         if(_loc2_ <= 0)
         {
            this.onTimerComplete();
            return;
         }
         this._timer = new Timer(1000,_loc2_);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerTick);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._timer.start();
         this.onTimerTick();
      }
      
      private function onTimerTick(param1:TimerEvent = null) : void
      {
         var _loc2_:int = this._timer.repeatCount - this._timer.currentCount;
         if(this._shopItemData.useBottomTimer)
         {
            this.txtTimeLeftBottom.htmlText = TextUtils.getTextFont() + TimeUtils.formatTimeLeft(_loc2_);
         }
         else
         {
            this.mcSaleTimer.txtTimeLeft.htmlText = TextUtils.getTextFont() + TimeUtils.formatTimeLeft(_loc2_);
         }
      }
      
      private function onTimerComplete(param1:TimerEvent = null) : void
      {
         if(this._shopItemData.timerCompleteImageName != "")
         {
            this.setCardImg(this._shopItemData.imagePath,this._shopItemData.timerCompleteImageName);
         }
         if(this._shopItemData.useBottomTimer)
         {
            this.txtTimeLeftBottom.htmlText = TextUtils.getTextFont() + this._shopItemData.timerCompleteText;
         }
         else
         {
            this.mcSaleTimer.txtTimeLeft.htmlText = TextUtils.getTextFont() + this._shopItemData.timerCompleteText;
         }
      }
   }
}

