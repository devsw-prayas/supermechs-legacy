package net.battleMechsMulti.screens.shop
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.screens.inventory.BMInventoryTileListItem;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.TextUtils;
   import net.battleMechsMulti.utils.TimeUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4932")]
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
      
      public var txtExtraDescription:TextField;
      
      public var txtRedTimer:TextField;
      
      public var mcCounter:TextHolder;
      
      public var mcTopBadgeItemsHolder:Sprite;
      
      public var mcTopBadge:Sprite;
      
      public var mcPriceWithIcon:IconAndText;
      
      public var mcDefaultPriceWithIcon:IconAndText;
      
      public var mcSalePatch:MovieClip;
      
      public var mcBoughtBanner:MovieClip;
      
      public var mcBg:MovieClip;
      
      public var mcRollOverEffect:MovieClip;
      
      public var mcMobileTextHolder:Sprite;
      
      public var mcSaleTimer:TextHolder;
      
      public var mcBanner:MovieClip;
      
      public var mcSaleTitle:TextHolder;
      
      public var mcGrpHolder:MovieClip;
      
      public var mcCardOptions:MovieClip;
      
      private var _timer:Timer;
      
      private var _shopItemData:BMShopItemViewData;
      
      private var _extraChanceItems:Array = new Array();
      
      private var itemTileListItem:BMInventoryTileListItem;
      
      public var mcImageSizer:Sprite;
      
      private var _mechView:BMMechView;
      
      private var _mechCreated:Boolean = false;
      
      public function BMShopItemView()
      {
         super();
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("globalShop");
         this.updateTexstsFormats();
         this.mcRollOverEffect.visible = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.mcTopBadge.visible = false;
         updateTextAndFormat(this.txtRedTimer,"");
      }
      
      public function setOverParent(param1:MovieClip) : void
      {
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         this.mcRollOverEffect.visible = false;
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         this.mcRollOverEffect.visible = true;
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
      }
      
      public function getAllTextFields() : Array
      {
         return [this.txtTitleTop,this.txtTitleBottom,this.txtBody,this.txtBonus,this.txtPriceNoIcon];
      }
      
      public function setData(param1:BMShopItemViewData) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TextHolder = null;
         var _loc6_:TextHolder = null;
         var _loc7_:uint = 0;
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
         this.mcSaleTimer.text = "";
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
            _loc4_ = TextUtils.SIZE_KEEP_CURRENT;
            if(this._shopItemData.mechStructure != null)
            {
               _loc4_ = 18;
            }
            updateTextAndFormat(this.txtTitleTop,_loc3_,_loc4_);
            this.txtTitleBottom.text = "";
         }
         else
         {
            updateTextAndFormat(this.txtTitleBottom,_loc3_,param1.titleBottomTextSize);
            if(this.txtTitleBottom.numLines == 3)
            {
               this.txtTitleBottom.y -= 10;
            }
            this.txtTitleTop.text = "";
         }
         updateTextAndFormat(this.txtBody,param1.bodyText,param1.bodyTextSize);
         updateTextAndFormat(this.txtBonus,param1.bonusText,param1.bonusTextSize);
         if(this.txtBonus.numLines > 1)
         {
            this.txtBonus.y -= 20;
         }
         updateTextAndFormat(this.txtExtraDescription,param1.extraDescription);
         updateTextAndFormat(this.txtTwoRows,param1.twoRowsText);
         this.setCardImg(param1.imagePath,param1.imageName,param1.putImageInSizer);
         this.setBanner(param1.specialBanner,param1.discount);
         this.mcPriceWithIcon.visible = false;
         this.mcDefaultPriceWithIcon.visible = false;
         this.txtPriceNoIcon.visible = false;
         this.mcSalePatch.visible = false;
         if(int(dataM.getGeneralSetting("showExtraValueBanner",0)) == 1)
         {
            if(param1.extraValue_text1 != "")
            {
               _loc5_ = this.mcSalePatch.mcText1;
               _loc5_.text = param1.extraValue_text1;
               _loc5_ = this.mcSalePatch.mcText2;
               _loc5_.text = param1.extraValue_text2;
               this.mcSalePatch.visible = true;
            }
         }
         if(param1.timerEnd > 0)
         {
            this.startTimer(param1.timerEnd);
         }
         if(param1.timerEnd == 0 || param1.timerType != BMShopItemViewData.TIMER_TYPE_BOTTOM)
         {
            this.setPrice(param1);
         }
         if(this._shopItemData.counter <= 0)
         {
            this.mcCounter.visible = false;
         }
         else
         {
            this.mcCounter.text = this._shopItemData.counter.toString();
         }
         if(this._shopItemData.showBoughtBanner == false)
         {
            this.mcBoughtBanner.parent.removeChild(this.mcBoughtBanner);
         }
         else
         {
            _loc6_ = this.mcBoughtBanner.mcText;
            _loc6_.text = getSpecificText("globalShop_bought");
         }
         if(param1.itemID > 0)
         {
            _loc7_ = 135;
            this.itemTileListItem = dataM.createItemFragmentTileListItem(param1.itemID,_loc7_);
            this.itemTileListItem.x -= _loc7_ / 2;
            this.itemTileListItem.y -= _loc7_;
            this.mcGrpHolder.addChild(this.itemTileListItem);
         }
         this.showExtraChanceItems();
         this.showMech();
      }
      
      private function get hasMech() : Boolean
      {
         return this._shopItemData.mechStructure != null;
      }
      
      private function showMech() : void
      {
         if(this.hasMech == false)
         {
            return;
         }
         this.mcBg.gotoAndStop("mech");
      }
      
      public function mechOnEnterFrame() : void
      {
         if(this.hasMech == false)
         {
            return;
         }
         if(this._mechCreated)
         {
            this._mechView.onEnterFrameTrigger();
            return;
         }
         this._mechView = new BMMechView();
         var _loc1_:Number = 0.48;
         this._mechView.initialize(100,"hanger",BMMechStructure.ITEM_TYPE_ITEM_ID,_loc1_);
         this._mechView.buildMech(this._shopItemData.mechStructure);
         this.mcGrpHolder.addChild(this._mechView);
         this.mcGrpHolder.y += 78;
         this.mcGrpHolder.x -= 15;
         this._mechView.resetYPos();
         this._mechView.activateBreathing();
         this._mechCreated = true;
      }
      
      private function setBanner(param1:uint, param2:uint) : *
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(param1 == 0)
         {
            this.mcBanner.visible = false;
            this.mcSaleTitle.visible = false;
            return;
         }
         this.mcBanner.visible = true;
         this.mcSaleTitle.visible = true;
         this.mcBanner.gotoAndStop(param1);
         switch(param1)
         {
            case 1:
               this.mcSaleTitle.text = getScreenText("mostPopular");
               break;
            case 2:
               this.mcSaleTitle.text = getScreenText("bestValue");
               break;
            case 3:
               _loc3_ = getScreenText("discountOff");
               _loc3_ = dataM.replaceStringInText(_loc3_,"%DISCOUNT%",String(param2));
               this.mcSaleTitle.text = _loc3_;
               break;
            case 4:
               _loc4_ = getScreenText("extraDiscount");
               _loc4_ = dataM.replaceStringInText(_loc4_,"%DISCOUNT%",String(param2));
               this.mcSaleTitle.text = _loc4_;
               break;
            case 5:
               this.mcSaleTitle.text = getScreenText("sale");
               break;
            case 6:
               this.mcSaleTitle.text = getScreenText("hot");
               break;
            case 7:
               _loc5_ = getScreenText("discountOff");
               _loc5_ = dataM.replaceStringInText(_loc5_,"%DISCOUNT%",String(param2));
               this.mcSaleTitle.text = _loc5_;
         }
      }
      
      private function setPrice(param1:BMShopItemViewData) : *
      {
         switch(param1.currency)
         {
            case BMShopItemViewData.CURRENCY_TYPE_GOLD:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("gold");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = param1.price;
               break;
            case BMShopItemViewData.CURRENCY_TYPE_TOKENS:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("tokens");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = param1.price;
               break;
            case BMShopItemViewData.CURRENCY_TYPE_CLAN_COINS:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("clanCoins");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = param1.price;
               break;
            case BMShopItemViewData.CURRENCY_TYPE_KIN:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("kin");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = param1.price;
               break;
            case BMShopItemViewData.CURRENCY_TYPE_MONEY:
            case BMShopItemViewData.CURRENCY_TYPE_FREE:
            case BMShopItemViewData.CURRENCY_TYPE_BOX_FRAGMENTS:
               this.txtPriceNoIcon.visible = true;
               updateTextAndFormat(this.txtPriceNoIcon,param1.price);
         }
         if(param1.defaultPrice != "0")
         {
            switch(param1.currency)
            {
               case BMShopItemViewData.CURRENCY_TYPE_GOLD:
                  this.mcDefaultPriceWithIcon.mcIcon.gotoAndStop("goldDefault");
                  this.mcDefaultPriceWithIcon.visible = true;
                  this.mcDefaultPriceWithIcon.text = param1.defaultPrice;
                  break;
               case BMShopItemViewData.CURRENCY_TYPE_TOKENS:
                  this.mcDefaultPriceWithIcon.mcIcon.gotoAndStop("tokensDefault");
                  this.mcDefaultPriceWithIcon.visible = true;
                  this.mcDefaultPriceWithIcon.activateGrayText();
                  this.mcDefaultPriceWithIcon.text = param1.defaultPrice;
            }
         }
      }
      
      private function setCardImg(param1:String, param2:String, param3:Boolean) : *
      {
         var itemImage:Sprite = null;
         var imagePath:String = param1;
         var imageName:String = param2;
         var putImageInSizer:Boolean = param3;
         this.mcGrpHolder.removeChildren();
         if(imageName == "")
         {
            return;
         }
         try
         {
            itemImage = externalAssetsM.getAsset(imagePath,imageName);
            this.mcGrpHolder.x = this.mcTopBadgeItemsHolder.x;
            this.mcGrpHolder.y = this.mcTopBadgeItemsHolder.y;
            if(putImageInSizer)
            {
               itemImage.x = this.mcImageSizer.x;
               itemImage.y = this.mcImageSizer.y;
               itemImage.width = this.mcImageSizer.width;
               itemImage.height = this.mcImageSizer.height;
            }
            else
            {
               itemImage.width = this.mcBg.width;
               itemImage.height = this.mcBg.height;
            }
            itemImage.y += this._shopItemData.imageYAddon;
            this.mcGrpHolder.addChild(itemImage);
         }
         catch(e:Error)
         {
            TsLogger.log("BMShopItemView::setCardImg " + e.message);
         }
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
         switch(this._shopItemData.timerType)
         {
            case BMShopItemViewData.TIMER_TYPE_BOTTOM:
               updateTextAndFormat(this.txtTimeLeftBottom,TimeUtils.formatTimeLeft(_loc2_));
               break;
            case BMShopItemViewData.TIMER_TYPE_BANNER:
               this.mcSaleTimer.text = TimeUtils.formatTimeLeft(_loc2_);
               break;
            case BMShopItemViewData.TIMER_TYPE_EXTRA_DESCRIPTION:
               updateTextAndFormat(this.txtExtraDescription,this._shopItemData.extraDescription + TimeUtils.formatTimeLeft(_loc2_));
               break;
            case BMShopItemViewData.TIMER_TYPE_EXTRA_ITEMS:
               updateTextAndFormat(this.txtRedTimer,TimeUtils.formatTimeLeft(_loc2_));
         }
      }
      
      private function onTimerComplete(param1:TimerEvent = null) : void
      {
         if(this._shopItemData.timerCompleteImageName != "")
         {
            this.setCardImg(this._shopItemData.imagePath,this._shopItemData.timerCompleteImageName,this._shopItemData.putImageInSizer);
         }
         switch(this._shopItemData.timerType)
         {
            case BMShopItemViewData.TIMER_TYPE_BOTTOM:
               updateTextAndFormat(this.txtTimeLeftBottom,this._shopItemData.timerCompleteText);
               break;
            case BMShopItemViewData.TIMER_TYPE_BANNER:
               this.mcSaleTimer.text = this._shopItemData.timerCompleteText;
               break;
            case BMShopItemViewData.TIMER_TYPE_EXTRA_DESCRIPTION:
               updateTextAndFormat(this.txtExtraDescription,this._shopItemData.timerCompleteText);
               break;
            case BMShopItemViewData.TIMER_TYPE_EXTRA_ITEMS:
               updateTextAndFormat(this.txtRedTimer,this._shopItemData.timerCompleteText);
         }
      }
      
      private function showExtraChanceItems() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:BMTileListItem = null;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         if(this._shopItemData.extraChanceItemIDs.length == 0)
         {
            return;
         }
         this.mcTopBadge.visible = true;
         this.txtTitleBottom.y += 15;
         this.txtTitleTop.y -= 34;
         updateTextAndFormat(this.txtTitleTop,getSpecificText("globalShop_extraChance"),17);
         var _loc1_:uint = this._shopItemData.extraChanceItemIDs.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = uint(this._shopItemData.extraChanceItemIDs[_loc2_]);
            _loc4_ = 60;
            _loc5_ = 2;
            _loc6_ = -7;
            _loc7_ = dataM.createItemTileListItem(_loc3_,_loc4_);
            _loc8_ = width / 2 + _loc6_;
            if(_loc1_ == 1)
            {
               _loc8_ -= _loc4_ / 2;
            }
            else
            {
               _loc8_ -= (_loc1_ * _loc4_ + (_loc1_ - 1) * _loc5_) / 2;
               _loc8_ = _loc8_ + _loc2_ * _loc4_;
               if(_loc2_ > 0)
               {
                  _loc8_ += _loc2_ * _loc5_;
               }
            }
            _loc9_ = 5;
            _loc7_.x = _loc8_;
            _loc7_.y = _loc9_;
            this.mcTopBadgeItemsHolder.addChild(_loc7_);
            _loc2_++;
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         if(this.itemTileListItem != null)
         {
            this.itemTileListItem.removeMe();
            this.itemTileListItem = null;
         }
         if(this._mechView != null)
         {
         }
      }
   }
}

