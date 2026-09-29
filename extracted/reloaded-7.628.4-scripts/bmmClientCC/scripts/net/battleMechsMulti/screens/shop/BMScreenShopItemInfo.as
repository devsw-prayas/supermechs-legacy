package net.battleMechsMulti.screens.shop
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1224")]
   public class BMScreenShopItemInfo extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcItemHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtBody:TextField;
      
      public var btnBuy:BMBasicButton;
      
      public var btnClose:BMBasicButton;
      
      public var btnBuyOne:BMBasicButton;
      
      public var btnBuySeveral:BMBasicButton;
      
      public var btnContentPackLibrary:BMBasicButton;
      
      public var mcRays1:Sprite;
      
      public var mcRays2:Sprite;
      
      public var mcItem:Sprite;
      
      public var txtDescription:TextField;
      
      public var mcPriceWithIcon:IconAndText;
      
      public var mcDefaultPriceWithIcon:IconAndText;
      
      public var mcImageSizer:Sprite;
      
      public var btnBuyNew:BMBasicButton;
      
      public var btnBackNew:BMBasicButton;
      
      public var txtContentPackRange:TextField;
      
      private var _shopItemData:BMShopItemViewData;
      
      private var _firstRefresh:Boolean = true;
      
      private var _buyCallBack:Function;
      
      public function BMScreenShopItemInfo()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function initChainDiscount() : void
      {
      }
      
      public function initItemsExtraChance() : void
      {
      }
      
      public function initMech() : void
      {
      }
      
      public function refreshScreen(param1:BMShopItemViewData, param2:Function = null) : void
      {
         var _loc3_:Boolean = false;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("shopBuyItem");
            this.initButtons();
            addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this._shopItemData = param1;
         this._buyCallBack = param2;
         if(this.mcRays1 != null)
         {
            _loc3_ = true;
            if(this._shopItemData.currency == BMShopItemViewData.CURRENCY_TYPE_TOKENS)
            {
               if(BMShopManager.gi().currentCategory != BMShopManager.gi().category_gold)
               {
                  _loc3_ = false;
               }
            }
            if(_loc3_)
            {
               this.mcRays1.visible = false;
               this.mcRays2.visible = false;
            }
            else
            {
               this.mcRays1.visible = true;
               this.mcRays2.visible = true;
            }
         }
         this.displayItem();
         this.displayDetails();
         this.refreshPrice();
         this.refreshContentPackLibraryInfo();
         this.initChainDiscount();
         this.initItemsExtraChance();
         this.initMech();
      }
      
      protected function getShopItemData() : BMShopItemViewData
      {
         return this._shopItemData;
      }
      
      private function initButtons() : void
      {
         if(this.btnBuyNew != null)
         {
            this.btnBuyNew.addEventListener(BMIntractable.HIT,this.onBuyNewClick);
            this.btnBuyNew.text = "";
            this.btnBackNew.addEventListener(BMIntractable.HIT,this.onCloseNewClick);
            return;
         }
         if(this.btnBuy != null)
         {
            this.btnBuy.addEventListener(BMIntractable.HIT,this.buyClicked);
         }
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         if(this.btnContentPackLibrary != null)
         {
            this.btnContentPackLibrary.addEventListener(BMIntractable.HIT,this.contentPackLibraryClicked);
         }
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,20);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this.mcRays1 == null)
         {
            return;
         }
         if(this.mcRays1.visible == false)
         {
            return;
         }
         this.mcRays1.rotation += 0.1;
         this.mcRays2.rotation -= 0.06;
         this.onEnterFrameTriggerSub();
      }
      
      public function onEnterFrameTriggerSub() : void
      {
      }
      
      private function displayDetails() : void
      {
         updateTextAndFormat(this.txtTitle,this._shopItemData.titleBottom);
         updateTextAndFormat(this.txtDescription,this._shopItemData.bonusText);
         updateTextAndFormat(this.txtBody,this._shopItemData.bodyText);
         if(this._shopItemData.bodyText == "")
         {
            this.txtDescription.y = this.txtBody.y;
         }
      }
      
      private function refreshPrice() : void
      {
         var _loc1_:uint = 0;
         if(this.btnBuyOne != null)
         {
            _loc1_ = BMShopManager.getInstance().multipleBoxesAmount();
            this.btnBuyOne.addEventListener(BMIntractable.HIT,this.buyOneClicked);
            this.btnBuySeveral.addEventListener(BMIntractable.HIT,this.buySeveralClicked);
            this.btnBuyOne.text = getSpecificText("specialOffers_buy") + " 1";
            this.btnBuyOne.subText = TextUtils.getNumberWithComma(this.getPrice());
            this.btnBuySeveral.text = getSpecificText("specialOffers_buy") + " " + _loc1_;
            this.btnBuySeveral.subText = TextUtils.getNumberWithComma(this.getPrice(_loc1_));
            return;
         }
         this.mcPriceWithIcon.mouseEnabled = false;
         this.mcPriceWithIcon.mouseChildren = false;
         this.mcDefaultPriceWithIcon.visible = false;
         switch(this._shopItemData.currency)
         {
            case BMShopItemViewData.CURRENCY_TYPE_GOLD:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("gold");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = this._shopItemData.price;
               break;
            case BMShopItemViewData.CURRENCY_TYPE_TOKENS:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("tokens");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = this._shopItemData.price;
               break;
            case BMShopItemViewData.CURRENCY_TYPE_CLAN_COINS:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("clanCoins");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = this._shopItemData.price;
               break;
            case BMShopItemViewData.CURRENCY_TYPE_KIN:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("kin");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = this._shopItemData.price;
         }
         if(this._shopItemData.defaultPrice != "0")
         {
            this.mcDefaultPriceWithIcon.visible = true;
            this.mcDefaultPriceWithIcon.activateGrayText();
            this.mcDefaultPriceWithIcon.text = this._shopItemData.defaultPrice;
            switch(this._shopItemData.currency)
            {
               case BMShopItemViewData.CURRENCY_TYPE_GOLD:
                  this.mcDefaultPriceWithIcon.mcIcon.gotoAndStop("goldDefault");
                  break;
               case BMShopItemViewData.CURRENCY_TYPE_TOKENS:
                  this.mcDefaultPriceWithIcon.mcIcon.gotoAndStop("tokensDefault");
            }
         }
      }
      
      private function buyOneClicked(param1:Event) : void
      {
         this.buyClickedSub();
      }
      
      private function buySeveralClicked(param1:Event) : void
      {
         var _loc2_:uint = BMShopManager.getInstance().multipleBoxesAmount();
         this.buyClickedSub(_loc2_);
      }
      
      private function displayItem() : void
      {
         this.removeItem();
         try
         {
            this.mcItem = externalAssetsM.getAsset(this._shopItemData.imagePath,this._shopItemData.imageName);
            if(this._shopItemData.putImageInSizer)
            {
               this.mcItem.x = this.mcImageSizer.x;
               this.mcItem.y = this.mcImageSizer.y;
               this.mcItem.width = this.mcImageSizer.width;
               this.mcItem.height = this.mcImageSizer.height;
               this.mcItemHolder.x = 0;
               this.mcItemHolder.y = 0;
            }
            this.fixRaysSizeAndPositionForRegularColorKits();
            this.mcItemHolder.addChild(this.mcItem);
         }
         catch(e:Error)
         {
            TsLogger.log("BMScreenShopItemInfo::displayItem " + e.message);
         }
      }
      
      private function fixRaysSizeAndPositionForRegularColorKits() : void
      {
         var _loc1_:BMItemData = dataM.itemsDB[this._shopItemData.id];
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.isColorKit == false)
         {
            return;
         }
         if(int(_loc1_.animation) >= BMDataManager.PATTERN_COLORS_FIRST_ID)
         {
            return;
         }
         this.mcRays1.scaleX *= 0.7;
         this.mcRays1.scaleY *= 0.7;
         this.mcRays2.scaleX *= 0.7;
         this.mcRays2.scaleY *= 0.7;
         this.mcRays1.x -= 13;
         this.mcRays1.y += 2;
         this.mcRays2.x -= 13;
         this.mcRays2.y += 2;
      }
      
      private function removeItem() : void
      {
         if(this.mcItem != null)
         {
            if(this.mcItem.parent != null)
            {
               this.mcItem.parent.removeChild(this.mcItem);
            }
            this.mcItem = null;
         }
      }
      
      private function onCloseNewClick(param1:Event) : void
      {
         this.onCloseClicked();
      }
      
      private function onCloseClicked() : *
      {
         TweenMax.delayedCall(0.01,this.removeMe);
      }
      
      private function closeClicked(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP) && dataM.runAsMobile)
         {
            _loc2_ = false;
            if(screensM.screenShopItemInfo is BMScreenShopItemInfoMech)
            {
               _loc2_ = true;
            }
            else if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_SHOP) || screensM.isScreenOpened(BMScreensManager.SCR_KIN_SHOP))
            {
               _loc2_ = true;
            }
            if(_loc2_)
            {
               screensM.screenGlobalShop.blockNextMobileClick = true;
            }
         }
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO))
         {
            screensM.screenContentPackItemInfo.removeMe();
         }
         screensM.removeScreen(BMScreensManager.SCR_SHOP_ITEM_INFO);
      }
      
      private function onBuyNewClick(param1:Event) : void
      {
         this.buyClickedSub();
      }
      
      private function buyClicked(param1:Event) : void
      {
         this.buyClickedSub();
      }
      
      private function buyClickedSub(param1:uint = 1) : void
      {
         var _loc2_:Number = this.getPrice();
         switch(this._shopItemData.currency)
         {
            case BMShopItemViewData.CURRENCY_TYPE_GOLD:
               if(_loc2_ > 0 && dataM.myProfile.gold < _loc2_)
               {
                  BMShopManager.gi().showBuyMoreGoldYesNoPopup(_loc2_);
                  return;
               }
               break;
            case BMShopItemViewData.CURRENCY_TYPE_TOKENS:
               if(_loc2_ > 0 && dataM.myProfile.tokens < _loc2_)
               {
                  BMShopManager.gi().showBuyMoreTokensYesNoPopup(_loc2_);
                  return;
               }
               break;
            case BMShopItemViewData.CURRENCY_TYPE_CLAN_COINS:
               if(_loc2_ > 0 && dataM.myProfile.clanCoins < _loc2_)
               {
                  BMShopManager.gi().showNotEnoughClanCoins();
                  return;
               }
               break;
            case BMShopItemViewData.CURRENCY_TYPE_KIN:
               if(_loc2_ > 0 && dataM.kinM.kin < _loc2_)
               {
                  BMShopManager.gi().showNotEnoughKin();
                  return;
               }
         }
         this._buyCallBack(this._shopItemData,param1);
         this.removeMe();
      }
      
      private function getPrice(param1:uint = 1) : Number
      {
         var _loc2_:Number = Number(this._shopItemData.price.split(",").join(""));
         return _loc2_ * param1;
      }
      
      private function contentPackLibraryClicked(param1:Event) : void
      {
         screensM.addScreen(BMScreensManager.SCR_CONTENT_PACK_LIBRARY);
         screensM.screenContentPackLibrary.openedAsPopup = true;
      }
      
      private function refreshContentPackLibraryInfo() : void
      {
         if(this._shopItemData.category != BMShopManager.gi().category_itemBoxes || dataM.contentPackResolver.contentPacksEnabled() == false)
         {
            if(this.txtContentPackRange == null)
            {
               return;
            }
            updateTextAndFormat(this.txtContentPackRange,"");
            this.btnContentPackLibrary.visible = false;
            return;
         }
         var _loc1_:String = "";
         var _loc2_:uint = dataM.contentPackResolver.getMyHighestContentPackID();
         if(_loc2_ == 0)
         {
            _loc1_ = languageM.getText("contentPackLibrary_armoryLevel");
            _loc1_ = dataM.replaceStringInText(_loc1_,"%LEVEL%",String(1));
         }
         else
         {
            _loc1_ = languageM.getText("contentPackLibrary_armoryLevels");
            _loc1_ = dataM.replaceStringInText(_loc1_,"%LEVEL%",String(_loc2_ + 1));
         }
         updateTextAndFormat(this.txtContentPackRange,_loc1_);
         this.btnContentPackLibrary.visible = true;
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeItem();
         this.removedFromStageSub();
      }
      
      public function removedFromStageSub() : void
      {
      }
   }
}

