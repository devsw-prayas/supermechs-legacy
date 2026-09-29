package net.battleMechsMulti.screens.shop
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol596")]
   public class BMScreenBuyGachaMachine extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcGachaMachineHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnBuy:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnBuy:BMButton;
      
      public var mcRays1:Sprite;
      
      public var mcRays2:Sprite;
      
      public var mcGachaMachine:Sprite;
      
      public var txtDescription:TextField;
      
      public var mcPriceWithIcon:IconAndText;
      
      private var _shopItemData:BMShopItemData;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenBuyGachaMachine()
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
         var _loc4_:Boolean = false;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("shopBuyItem");
            screensM.createButtonFromSizer("screenBuyGachaMachine","btnBack","pictureE");
            screensM.createButtonFromSizer("screenBuyGachaMachine","btnBuy","regular");
            _loc2_ = this.backClicked;
            _loc3_ = this.buyClicked;
            _loc4_ = dataM.runAsMobile;
            _loc4_ = false;
            if(_loc4_)
            {
               _loc2_ = null;
               _loc3_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,_loc4_);
            this.btnBuy.initialize("","green",null,null,_loc3_,_loc4_);
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
         this.displayGachaMachine();
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
         this.txtTitle.text = this._shopItemData.titleBottom;
         this.txtDescription.text = this._shopItemData.bonusText;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyGachaMachine_texts",[this.txtDescription,this.txtTitle],"",this);
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
      
      private function displayGachaMachine() : void
      {
         this.removeGachaMachine();
         this.mcGachaMachine = externalAssetsM.getAsset("general","buyGachaMachine_gachaMachine" + this._shopItemData.id);
         this.mcGachaMachineHolder.addChild(this.mcGachaMachine);
      }
      
      private function removeGachaMachine() : void
      {
         if(this.mcGachaMachine != null)
         {
            if(this.mcGachaMachine.parent != null)
            {
               this.mcGachaMachine.parent.removeChild(this.mcGachaMachine);
            }
            this.mcGachaMachine = null;
         }
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen("screenBuyGachaMachine");
      }
      
      public function buyClicked() : void
      {
         var _loc1_:BMGachaMachineData = dataM.gachaMachinesDB[this._shopItemData.id];
         if(_loc1_.costTokens > 0 && dataM.myProfile.tokens < _loc1_.costTokens)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("notEnoughTokensForGacha",this._shopItemData.id,-1);
         }
         else if(_loc1_.costGold > 0 && dataM.myProfile.gold < _loc1_.costGold)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("notEnoughGoldForGacha",this._shopItemData.id,-1);
         }
         else
         {
            BMShopManager.gi().tryToBuyGachaMachine(this._shopItemData);
            this.backClicked();
         }
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeGachaMachine();
      }
   }
}

