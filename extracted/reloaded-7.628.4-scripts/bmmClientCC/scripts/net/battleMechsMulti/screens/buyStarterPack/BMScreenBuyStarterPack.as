package net.battleMechsMulti.screens.buyStarterPack
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMRemoteManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.managers.shop.BMGoldPackageData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenBuyStarterPack extends BMBaseScreen
   {
      
      public var mcTokens_bonus:Sprite;
      
      public var mcGold_bonus:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDescription:TextField;
      
      public var txtDescription2:TextField;
      
      public var txtTimeLeft:TextField;
      
      public var txtBonusGold:TextField;
      
      public var txtBonusTokens:TextField;
      
      public var btnBack:BMBasicButton;
      
      public var btnBuy:BMBasicButton;
      
      public var mcExtraValue:MovieClip;
      
      private var _minuteLength:Number;
      
      private var _hourLength:Number;
      
      private var _dayLength:Number;
      
      private var _resetTimer:Timer;
      
      private var _lastChanceAlert:Boolean = false;
      
      private var _screenSource:String;
      
      private var _buyTokensOriginXPos:Number;
      
      private var _buyPriceTextOriginXPos:Number;
      
      public function BMScreenBuyStarterPack()
      {
         super();
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         _loc1_.trackScreenView("buyStarterPack");
         _loc1_.updateStarterPackActive();
         this.btnBack.addEventListener(BMIntractable.HIT,this.backClicked);
         this.btnBuy.addEventListener(BMIntractable.HIT,this.buyClicked);
         this._minuteLength = 60;
         this._hourLength = this._minuteLength * 60;
         this._dayLength = this._hourLength * 24;
         this._buyTokensOriginXPos = this.btnBuy["mcTokens"].x;
         this._buyPriceTextOriginXPos = this.btnBuy.txtSubTitle.x;
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public static function get showExtraValueBanner() : Boolean
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(int(_loc1_.getGeneralSetting("showExtraValueBanner",0)) == 0)
         {
            return false;
         }
         if(_loc1_.myProfile.starterPackData.extraValue == null)
         {
            return false;
         }
         if(_loc1_.myProfile.starterPackData.extraValue == "")
         {
            return false;
         }
         return true;
      }
      
      protected function refreshScreenSub(param1:String) : void
      {
         var _loc2_:BMDataManager = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:TextHolder = null;
         _loc2_ = BMDataManager.getInstance();
         this._screenSource = param1;
         _loc2_.starterPack_displayAfterOnlineBattleCounter = 0;
         _loc2_.starterPack_displayAfterSinglePlayerMissionCounter = 0;
         switch(_loc2_.myProfile.starterPackData.priceType)
         {
            case BMStarterPackData.PRICE_TYPE_MONEY:
               this.btnBuy["mcTokens"].visible = false;
               break;
            case BMStarterPackData.PRICE_TYPE_TOKENS:
               _loc4_ = int(_loc2_.myProfile.starterPackData.price);
               if(_loc4_ < 1000)
               {
                  this.btnBuy["mcTokens"].x = this._buyTokensOriginXPos + 8;
                  this.btnBuy.txtSubTitle.x = this._buyPriceTextOriginXPos + 10;
               }
               else if(_loc4_ < 2000)
               {
                  this.btnBuy["mcTokens"].x = this._buyTokensOriginXPos + 6;
                  this.btnBuy.txtSubTitle.x = this._buyPriceTextOriginXPos + 11;
               }
               else
               {
                  this.btnBuy.txtSubTitle.x = this._buyPriceTextOriginXPos + 10;
               }
         }
         this.btnBuy.text = BMLanguageManager.getInstance().getText("buyStarterPack_buy");
         this.btnBuy.setSubText(_loc2_.myProfile.starterPackData.price,true);
         if(this.txtBonusGold != null)
         {
            updateTextAndFormat(this.txtBonusGold,TextUtils.getNumberWithComma(_loc2_.myProfile.starterPackData.bonusGold));
            this.mcGold_bonus.visible = true;
            _loc3_ = this.txtBonusGold.width - this.txtBonusGold.textWidth;
            this.txtBonusGold.x += _loc3_ / 2;
            this.mcGold_bonus.x += _loc3_ / 2;
         }
         if(this.txtBonusTokens != null)
         {
            updateTextAndFormat(this.txtBonusTokens,TextUtils.getNumberWithComma(_loc2_.myProfile.starterPackData.bonusTokens));
            this.mcTokens_bonus.visible = true;
            _loc3_ = this.txtBonusTokens.width - this.txtBonusTokens.textWidth;
            this.txtBonusTokens.x += _loc3_ / 2;
            this.mcTokens_bonus.x += _loc3_ / 2;
         }
         if(this.mcExtraValue != null)
         {
            if(showExtraValueBanner)
            {
               this.mcExtraValue.mouseEnabled = false;
               this.mcExtraValue.mouseChildren = false;
               _loc5_ = BMShopManager.gi().getExtraValueDisplayString(_loc2_.myProfile.starterPackData.extraValue);
               _loc6_ = this.mcExtraValue.mcText1;
               _loc6_.text = _loc5_[0];
               _loc6_ = this.mcExtraValue.mcText2;
               _loc6_.text = _loc5_[1];
            }
            else
            {
               this.mcExtraValue.parent.removeChild(this.mcExtraValue);
            }
         }
         this.stopTimer();
         this.refreshTimer();
         this._resetTimer = new Timer(1000,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.resetTimerEvent);
         this._resetTimer.start();
      }
      
      protected function getCheapestTokensPackage() : BMTokenPackage
      {
         var _loc4_:BMTokenPackage = null;
         var _loc1_:uint = 9999999;
         var _loc2_:Number = -1;
         var _loc3_:uint = 0;
         while(_loc3_ < dataM.allTokenPackages.length)
         {
            _loc4_ = dataM.allTokenPackages[_loc3_];
            if(_loc4_.tokens > 0 && _loc4_.tokens < _loc1_)
            {
               _loc2_ = _loc3_;
               _loc1_ = _loc4_.tokens;
            }
            _loc3_++;
         }
         if(_loc2_ == -1)
         {
            return null;
         }
         return dataM.allTokenPackages[_loc2_];
      }
      
      protected function getCheapestGoldPackage() : BMGoldPackageData
      {
         var _loc3_:BMGoldPackageData = null;
         var _loc1_:uint = 9999999;
         var _loc2_:Number = -1;
         for each(_loc3_ in dataM.goldPackagesDB)
         {
            if(_loc3_.gold > 0 && _loc3_.gold < _loc1_)
            {
               _loc2_ = _loc3_.goldPackageID;
               _loc1_ = _loc3_.gold;
            }
         }
         if(_loc2_ == -1)
         {
            return null;
         }
         return dataM.goldPackagesDB[_loc2_];
      }
      
      private function setStarterPackPurchaseInProgress() : *
      {
         BMDataManager.getInstance().myProfile.starterPackData.starterPackStatus = 1;
      }
      
      public function buyClicked(param1:Event) : void
      {
         var _loc2_:BMScreensManager = BMScreensManager.getInstance();
         if(_loc2_.screenBlack.isActive())
         {
            return;
         }
         if(FeatureFlags.BLOCK_SPECIAL_OFFERS)
         {
            _loc2_.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         BMSpecialOffersManager.trackSpecialOffersEvent("BeginBuy",this._screenSource,_loc3_.myProfile.starterPackData.packID);
         if(_loc3_.needToRegisterToBuyRealMoney)
         {
            _loc2_.screenConfirmation.displayQuestionOrNotification("mustRegister",1);
            return;
         }
         if(_loc3_.myProfile.pendingStarterPackMech > 0)
         {
            _loc2_.screenConfirmation.displayQuestionOrNotification("mustRedeemStarterPackMech");
            return;
         }
         if(this.isCostGold)
         {
            if(_loc3_.myProfile.gold < int(_loc3_.myProfile.starterPackData.price))
            {
               BMShopManager.gi().showGoldPackages();
               return;
            }
         }
         if(this.isCostTokens)
         {
            if(_loc3_.myProfile.tokens < int(_loc3_.myProfile.starterPackData.price))
            {
               BMShopManager.gi().showBuyMoreTokensYesNoPopup(int(_loc3_.myProfile.starterPackData.price));
               return;
            }
         }
         var _loc4_:uint = _loc3_.myProfile.starterPackData.tokenPackageID;
         var _loc5_:BMTokenPackage = null;
         if(this.isCostMoney)
         {
            _loc5_ = _loc3_.getTokenPackageByID(_loc4_);
         }
         if(_loc5_ !== null)
         {
            if(_loc3_.myProfile.improveYourMechStarterPackOffer != null)
            {
               BMRemoteManager.getInstance().socketM.lobby_saveCurrentMechStructureForImproveYourMechStarterPack(_loc5_.starterPackID);
            }
         }
         this.setStarterPackPurchaseInProgress();
         if(this.isCostMoney)
         {
            BMShopManager.getInstance().triggerMobilePurchase(String(_loc5_.tokenSystemPackageID));
            this.closeScreen();
         }
         else
         {
            _loc2_.screenConfirmation.displayQuestionOrNotification("buySpecialOfferForTokens",int(_loc3_.myProfile.starterPackData.price));
         }
      }
      
      public function buyStarterPackWithTokensConfirmed() : void
      {
         this.buyConfirmed(false);
         this.closeScreen();
      }
      
      public function forceToRedeemMech() : void
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         _loc1_.starterPack_goBackToScreen = "hanger";
         this.closeScreen();
      }
      
      public function buyConfirmed(param1:Boolean = true) : void
      {
         if(param1 == false)
         {
            BMSalesManager.gi().activeSaleBought();
         }
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         this.setStarterPackPurchaseInProgress();
         if(this.isCostMoney)
         {
            BMRemoteManager.getInstance().socketM.lobby_buyStarterPack();
         }
         else if(this.isGameOfWhalesOffer)
         {
            BMShopManager.gi().tryToBuyGachaMachineWhenShopIsClosed(_loc2_.myProfile.starterPackData.boostID,1);
         }
         else
         {
            BMRemoteManager.getInstance().socketM.buySaleShopMech(_loc2_.myProfile.starterPackData.starterPackShopID);
         }
         BMScreensManager.getInstance().screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      private function get isCostMoney() : Boolean
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         return _loc1_.myProfile.starterPackData.priceType == BMStarterPackData.PRICE_TYPE_MONEY;
      }
      
      private function get isCostTokens() : Boolean
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         return _loc1_.myProfile.starterPackData.priceType == BMStarterPackData.PRICE_TYPE_TOKENS;
      }
      
      private function get isCostGold() : Boolean
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         return _loc1_.myProfile.starterPackData.priceType == BMStarterPackData.PRICE_TYPE_GOLD;
      }
      
      private function get isGameOfWhalesOffer() : Boolean
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         return _loc1_.myProfile.starterPackData.isGameOfWhalesOffer;
      }
      
      public function packBought() : void
      {
         BMScreensManager.getInstance().screenConfirmation.displayQuestionOrNotification("starterPackBought");
         BMSpecialOffersManager.gi().removeSpecialOffer();
      }
      
      public function packBoughtSub() : void
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(_loc1_.myProfile.starterPackData.torso > 0)
         {
            _loc1_.starterPack_goBackToScreen = "hanger";
            this.closeScreen();
         }
         else
         {
            BMScreensManager.getInstance().addScreen(BMScreensManager.SCR_ITEM_CARDS);
         }
      }
      
      private function backClicked(param1:Event) : void
      {
         this.closeScreen();
      }
      
      public function closeScreen() : void
      {
         var _loc1_:BMScreensManager = BMScreensManager.getInstance();
         switch(dataM.starterPack_goBackToScreen)
         {
            case "hanger":
               _loc1_.screenTransitionsManager.hangerMechClicked();
               break;
            case "singlePlayer":
               _loc1_.screenTransitionsManager.singlePlayerClicked();
               break;
            case "multiplayerLadder":
               _loc1_.screenTransitionsManager.multiplayerLadderClicked();
               break;
            case "multiplayerChat":
               _loc1_.screenTransitionsManager.multiplayerChatClicked();
               break;
            case "mainMenu":
               _loc1_.screenTransitionsManager.mainMenu();
         }
         this.removeMe();
      }
      
      public function removeMe() : void
      {
      }
      
      private function resetTimerEvent(param1:TimerEvent) : void
      {
         this.refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         if(this._lastChanceAlert)
         {
            return;
         }
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:Number = _loc1_.myProfile.starterPackData.starterPackStartDate + _loc1_.myProfile.starterPackData.offerDuration - _loc1_.currentTime;
         if(_loc2_ <= 0)
         {
            this._lastChanceAlert = true;
            _loc3_ = BMLanguageManager.getInstance().getText("buyStarterPack_timeUp");
         }
         else
         {
            _loc4_ = Math.floor(_loc2_ / this._hourLength);
            _loc5_ = Math.floor((_loc2_ - _loc4_ * this._hourLength) / this._minuteLength);
            _loc6_ = Math.floor(_loc2_ - _loc4_ * this._hourLength - _loc5_ * this._minuteLength);
            if(_loc5_ < 10)
            {
               _loc7_ = "0" + _loc5_;
            }
            else
            {
               _loc7_ = String(_loc5_);
            }
            if(_loc6_ < 10)
            {
               _loc8_ = "0" + _loc6_;
            }
            else
            {
               _loc8_ = String(_loc6_);
            }
            _loc9_ = _loc4_;
            if(_loc9_ > 0)
            {
               _loc3_ = BMLanguageManager.getInstance().getText("buyStarterPack_timeLeft") + "<BR>" + _loc4_ + ":" + _loc7_ + ":" + _loc8_;
            }
            else
            {
               _loc3_ = BMLanguageManager.getInstance().getText("buyStarterPack_timeLeft") + "<BR>" + _loc7_ + ":" + _loc8_;
            }
            if(_loc2_ <= 60)
            {
               soundM.createSound("clockTick",1);
            }
         }
         updateTextAndFormat(this.txtTimeLeft,_loc3_);
      }
      
      private function stopTimer() : void
      {
         if(this._resetTimer != null)
         {
            this._resetTimer.stop();
            this._resetTimer.removeEventListener(TimerEvent.TIMER,this.resetTimerEvent);
            this._resetTimer = null;
         }
      }
      
      public function onRemovedFromStage(param1:Event) : void
      {
         this.stopTimer();
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreenSub(this._screenSource);
      }
   }
}

