package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   import net.battleMechsMulti.utils.TimeUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol704")]
   public class BMScreenItemSpecialOffers extends BMBaseScreen
   {
      
      public var btnClose:BMBasicButton;
      
      public var btnBuy:BMBasicButton;
      
      public var mcBagAndCurrency:MovieClip;
      
      public var mcItemHolder:MovieClip;
      
      public var txtTimer:TextField;
      
      private var _resetTimer:Timer;
      
      private var _data:BMStarterPackData;
      
      public function BMScreenItemSpecialOffers()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("specialOffers");
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClick);
         this.btnBuy.addEventListener(BMIntractable.HIT,this.onBuyClick);
      }
      
      public function setData(param1:BMStarterPackData) : void
      {
         this._data = param1;
         var _loc2_:BMTokenPackage = dataM.getTokenPackageByStarterPackID(param1.packID);
         if(_loc2_ == null)
         {
            TsLogger.log("BMScreenItemSpecialOffers::setData ERROR!!! could not find BMTokenPackage for starterPackId:" + param1.packID);
            return;
         }
         var _loc3_:BMBoostData = dataM.boostsDB[param1.boostID];
         if(_loc3_ == null)
         {
            TsLogger.log("BMScreenItemSpecialOffers::setData ERROR!!! could not find BMBoostData for boostID:" + param1.boostID + " starterPackId:" + param1.packID);
            return;
         }
         if(_loc2_.tokens > 0)
         {
            this.setTokensAndGold(param1.bonusGold,_loc2_.tokens);
         }
         else
         {
            this.mcBagAndCurrency.visible = false;
            this.mcItemHolder.x = 292;
         }
         this.setItem(_loc3_.itemID,_loc3_.amount);
         this.btnBuy.text = _loc2_.price;
         this.startTimer();
      }
      
      private function setItem(param1:Number, param2:int) : void
      {
         var _loc4_:MovieClip = null;
         var _loc3_:BMItemData = dataM.itemsDB[param1];
         _loc4_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc3_.type],_loc3_.grp,0,0,true,true);
         _loc4_.x = this.mcItemHolder.mcItemSizer.x;
         _loc4_.y = this.mcItemHolder.mcItemSizer.y;
         _loc4_.width = this.mcItemHolder.mcItemSizer.width;
         _loc4_.height = this.mcItemHolder.mcItemSizer.height;
         _loc4_.filters = [new GlowFilter(15846933,1,2,2,5,3,false,false)];
         this.mcItemHolder.mcHolder.addChild(_loc4_);
         this.mcItemHolder.txtItemName.text = languageM.getItemNameByItemData(_loc3_);
         ImageUtils.swapTextFieldWithBitMap(this.mcItemHolder.txtItemName,this.mcItemHolder);
         this.mcItemHolder.txtAmount.text = "x" + param2;
         ImageUtils.swapTextFieldWithBitMap(this.mcItemHolder.txtAmount,this.mcItemHolder);
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
      
      private function startTimer() : *
      {
         this._resetTimer = new Timer(1000,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.onTimerTick);
         this._resetTimer.start();
         this.onTimerTick();
      }
      
      private function onTimerTick(param1:Event = null) : void
      {
         var _loc4_:String = null;
         var _loc2_:BMPlayerProfile = dataM.myProfile;
         var _loc3_:Number = this._data.starterPackStartDate + this._data.offerDuration - dataM.currentTime;
         if(_loc3_ <= 0)
         {
            this.txtTimer.htmlText = getScreenText("timeIsUp");
            this._resetTimer.stop();
         }
         else
         {
            this.txtTimer.htmlText = getScreenText("limited") + "<br> <font size=\'19\' color=\'#ff0000\'>" + TimeUtils.formatTimeLeft(_loc3_) + "</font>";
         }
         ImageUtils.swapTextFieldWithBitMap(this.txtTimer,this);
      }
      
      private function onBuyClick(param1:Event) : void
      {
         var _loc2_:BMTokenPackage = dataM.getTokenPackageByStarterPackID(this._data.packID);
         var _loc3_:String = _loc2_.tokenSystemPackageID;
         if(dataM.needToRegisterToBuyRealMoney)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",1);
            return;
         }
         BMShopManager.getInstance().triggerMobilePurchase(String(_loc3_));
         this.backClicked();
      }
      
      private function onCloseClick(param1:Event) : void
      {
         this.backClicked();
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen("screenItemSpecialOffers");
      }
   }
}

