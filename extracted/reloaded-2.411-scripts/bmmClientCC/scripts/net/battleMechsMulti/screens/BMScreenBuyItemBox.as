package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.shop.BMShopItemData;
   import net.battleMechsMulti.screens.shop.IconAndText;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol549")]
   public class BMScreenBuyItemBox extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBoxHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnBuy:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnBuy:BMButton;
      
      public var mcRays1:Sprite;
      
      public var mcRays2:Sprite;
      
      public var mcBox:Sprite;
      
      public var txtCardsRatio1:TextField;
      
      public var txtCardsRatio2:TextField;
      
      public var txtCardsRatio3:TextField;
      
      public var txtCardsAmount:TextField;
      
      public var txtCardsRatioExtended:TextField;
      
      public var mcCardOptions:MovieClip;
      
      public var mcPriceWithIcon:IconAndText;
      
      private var _shopItemData:BMShopItemData;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenBuyItemBox()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:BMShopItemData) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("shopBuyItem");
            screensM.createButtonFromSizer("screenBuyItemBox","btnBack","pictureE");
            screensM.createButtonFromSizer("screenBuyItemBox","btnBuy","regular");
            _loc2_ = this.backClicked;
            _loc3_ = this.buyClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
            this.btnBuy.initialize("","green",null,null,_loc3_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuy.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this._shopItemData = param1;
         if(this._shopItemData.itemBox_ratio4 > 1)
         {
            this.mcRays1.visible = true;
            this.mcRays2.visible = true;
         }
         else
         {
            this.mcRays1.visible = false;
            this.mcRays2.visible = false;
         }
         this.displayItemBox();
         this.displayDetails();
         this.refreshPrice();
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
         if(this.mcRays1.visible)
         {
            this.mcRays1.rotation += 0.4;
            this.mcRays2.rotation -= 0.2;
         }
      }
      
      private function displayDetails() : void
      {
         var _loc1_:String = null;
         this.txtTitle.text = this._shopItemData.titleBottom;
         if(this._shopItemData.itemBox_ratio4 == 100)
         {
            this.txtCardsRatio1.text = "";
            this.txtCardsRatio2.text = "";
            this.txtCardsRatio3.text = "";
            this.txtCardsAmount.text = "";
            _loc1_ = getSpecificText("shopCombined_notInInventory");
            _loc1_ = dataM.replaceStringInText(_loc1_,"%CHANCE%",String(this._shopItemData.ratioNewMythical));
            this.txtCardsRatioExtended.text = _loc1_;
            if(this._shopItemData.itemBox_cards == 1)
            {
               this.mcCardOptions.gotoAndStop("mythical1");
            }
            else
            {
               this.mcCardOptions.gotoAndStop("mythical3");
            }
         }
         else
         {
            this.txtCardsRatioExtended.text = "";
            if(this._shopItemData.itemBox_ratio4 > 1)
            {
               this.mcCardOptions.gotoAndStop("epicToMythical");
               this.txtCardsRatio1.text = this._shopItemData.itemBox_ratio2 + "%";
               this.txtCardsRatio2.text = this._shopItemData.itemBox_ratio3 + "%";
               this.txtCardsRatio3.text = this._shopItemData.itemBox_ratio4 + "%";
            }
            else
            {
               this.mcCardOptions.gotoAndStop("rareToLegendary");
               this.txtCardsRatio1.text = this._shopItemData.itemBox_ratio1 + "%";
               this.txtCardsRatio2.text = this._shopItemData.itemBox_ratio2 + "%";
               this.txtCardsRatio3.text = this._shopItemData.itemBox_ratio3 + "%";
            }
            this.txtCardsAmount.text = "X" + this._shopItemData.itemBox_cards;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyItemBox_texts",[this.txtCardsAmount,this.txtCardsRatio1,this.txtCardsRatio2,this.txtCardsRatio3,this.txtCardsRatioExtended,this.txtTitle],"",this);
         }
      }
      
      private function refreshPrice() : void
      {
         this.mcPriceWithIcon.mouseEnabled = false;
         this.mcPriceWithIcon.mouseChildren = false;
         switch(this._shopItemData.currency)
         {
            case BMShopItemData.CURRENCY_TYPE_GOLD:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("gold");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = this._shopItemData.price;
               break;
            case BMShopItemData.CURRENCY_TYPE_TOKENS:
               this.mcPriceWithIcon.mcIcon.gotoAndStop("tokens");
               this.mcPriceWithIcon.visible = true;
               this.mcPriceWithIcon.text = this._shopItemData.price;
         }
      }
      
      private function displayItemBox() : void
      {
         this.removeBox();
         this.mcBox = externalAssetsM.getAsset("general","buyItemBox_itemBox" + this._shopItemData.id);
         this.mcBoxHolder.addChild(this.mcBox);
      }
      
      private function removeBox() : void
      {
         if(this.mcBox != null)
         {
            if(this.mcBox.parent != null)
            {
               this.mcBox.parent.removeChild(this.mcBox);
            }
            this.mcBox = null;
         }
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen("screenBuyItemBox");
      }
      
      public function buyClicked() : void
      {
         BMShopManager.gi().tryToBuyBox(this._shopItemData);
         this.backClicked();
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeBox();
      }
   }
}

