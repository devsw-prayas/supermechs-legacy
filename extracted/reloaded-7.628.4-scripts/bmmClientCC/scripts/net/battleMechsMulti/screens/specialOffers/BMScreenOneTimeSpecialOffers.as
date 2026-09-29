package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.managers.specialOffers.OneTimeSpecialOffersData;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol685")]
   public class BMScreenOneTimeSpecialOffers extends BMBaseScreen
   {
      
      public var btnClose:BMBasicButton;
      
      public var btnBuy:BMBasicButton;
      
      public var mcBoxes:MovieClip;
      
      public var mcBagAndCurrency:MovieClip;
      
      public var txtBox:TextField;
      
      public var txtTitle:TextField;
      
      private var _tokenSystemPackageID:String;
      
      public function BMScreenOneTimeSpecialOffers()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("oneTimeSpecialOffer");
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClick);
         this.btnBuy.addEventListener(BMIntractable.HIT,this.onBuyClick);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function setData(param1:OneTimeSpecialOffersData) : void
      {
         var _loc2_:BMStarterPackData = dataM.starterPackData[param1.starterPackId];
         if(_loc2_ == null)
         {
            TsLogger.log("BMScreenOneTimeSpecialOffers::setData ERROR!!! could not find BMStarterPackData for starterPackId:" + param1.starterPackId);
            return;
         }
         var _loc3_:BMTokenPackage = dataM.getTokenPackageByStarterPackID(param1.starterPackId);
         if(_loc3_ == null)
         {
            TsLogger.log("BMScreenOneTimeSpecialOffers::setData ERROR!!! could not find BMTokenPackage for starterPackId:" + param1.starterPackId);
            return;
         }
         this._tokenSystemPackageID = _loc3_.tokenSystemPackageID;
         this.setBox(_loc2_.boostID,_loc2_.boostAmount);
         this.setTokensAndGold(_loc2_.bonusGold,_loc3_.tokens);
         this.btnBuy.text = _loc3_.price;
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         this.setSaleTxt(param1.text);
      }
      
      private function setSaleTxt(param1:*) : void
      {
         if(param1 != "")
         {
            this.mcBagAndCurrency.txtSale.text = param1;
            ImageUtils.swapTextFieldWithBitMap(this.mcBagAndCurrency.txtSale,this.mcBagAndCurrency);
            this.mcBagAndCurrency.txtSm.visible = false;
         }
         else
         {
            this.mcBagAndCurrency.txtSale.visible = false;
         }
      }
      
      private function setBox(param1:uint, param2:int) : void
      {
         var _loc3_:BMGachaMachineData = null;
         if(param1 > 0)
         {
            _loc3_ = dataM.getGacheMachine(param1);
            this.mcBoxes.gotoAndStop("boost" + _loc3_.imageID);
            if(param2 <= 1)
            {
               updateTextAndFormat(this.txtBox,languageM.getGachaMachineName(_loc3_.description));
            }
            else
            {
               updateTextAndFormat(this.txtBox,"<font color=\'#F6A100\' size=\'19\'>" + param2 + "X</font> " + getSpecificText(_loc3_.name));
            }
            if(this.txtBox.numLines == 1)
            {
               this.txtBox.y += 12;
               this.mcBoxes.y += 12;
            }
            else if(this.txtBox.numLines == 3)
            {
               this.txtBox.y -= 9;
            }
            ImageUtils.swapTextFieldWithBitMap(this.txtBox,this);
         }
         else
         {
            this.txtBox.visible = false;
            this.mcBoxes.visible = false;
            this.mcBagAndCurrency.x = width / 2 - 10;
            this.mcBagAndCurrency.scaleX = 1.2;
            this.mcBagAndCurrency.scaleY = 1.2;
         }
      }
      
      private function setTokensAndGold(param1:uint, param2:uint) : *
      {
         if(param1 == 0)
         {
            this.mcBagAndCurrency.mcBag.gotoAndStop(2);
            this.mcBagAndCurrency.mcCurrency1.visible = false;
            this.mcBagAndCurrency.mcCurrency0.setX(-85);
            this.mcBagAndCurrency.mcCurrency0.text = TextUtils.getNumberWithComma(param2);
         }
         else
         {
            this.mcBagAndCurrency.mcCurrency0.mcIcon.gotoAndStop(2);
            this.mcBagAndCurrency.mcCurrency0.text = TextUtils.getNumberWithComma(param1);
            this.mcBagAndCurrency.mcCurrency1.text = TextUtils.getNumberWithComma(param2);
            this.mcBagAndCurrency.mcCurrency1.x = this.mcBagAndCurrency.mcCurrency0.x + this.mcBagAndCurrency.mcCurrency0.width;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.mcBoxes.mcRays.rotation += 0.3;
         this.mcBagAndCurrency.mcRays.rotation += 0.3;
      }
      
      private function onBuyClick(param1:Event) : void
      {
         if(dataM.needToRegisterToBuyRealMoney)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",1);
            return;
         }
         BMShopManager.getInstance().triggerMobilePurchase(String(this._tokenSystemPackageID));
         this.backClicked();
      }
      
      private function onCloseClick(param1:Event) : void
      {
         this.backClicked();
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_ONE_TIME_SPECIAL_OFFERS);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
   }
}

