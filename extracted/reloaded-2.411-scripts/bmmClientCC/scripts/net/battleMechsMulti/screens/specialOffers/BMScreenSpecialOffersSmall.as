package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMSpecialOffersManager;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.utils.TimeUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol896")]
   public class BMScreenSpecialOffersSmall extends BMScreenSpecialOffersBase
   {
      
      public var txtTitle:TextField;
      
      public var txtTimer:TextField;
      
      public var mcRays:Sprite;
      
      private var _resetTimer:Timer;
      
      public function BMScreenSpecialOffersSmall()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMScreenSpecialOffersSmall initialized");
         generateSingletonClassesPointers("");
         if(dataM.runAsMobile == false)
         {
            mcSpecialSalesHitArea.addEventListener(MouseEvent.CLICK,this.specialSaleHitAreaClicked);
         }
      }
      
      override public function refreshScreen() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(BMSpecialOffersManager.gi().currentOfferID == BMSpecialOffersManager.STARTER_PACK_ID)
         {
            _loc1_ = dataM.myProfile;
            if(_loc1_.starterPackData.boostID > 0)
            {
               gotoAndStop("box");
            }
            else
            {
               gotoAndStop("mech");
            }
            this.titleText = "Special Offer";
         }
         else
         {
            gotoAndStop("sale");
            this.titleText = "HOT SALE!";
         }
         this.stopTimer();
         this.startTimer();
         this.refreshTimer();
      }
      
      private function startTimer() : *
      {
         this._resetTimer = new Timer(1000,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.resetTimerEvent);
         this._resetTimer.start();
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
      
      private function resetTimerEvent(param1:TimerEvent) : void
      {
         this.refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:Number = BMSpecialOffersManager.gi().currentOfferID == BMSpecialOffersManager.STARTER_PACK_ID ? this.getStarterPackTimeLeft() : this.getSaleTimeLeft();
         if(_loc1_ <= 0)
         {
            this.titleText = getSpecificText("buyStarterPack_timeUp");
            this.timeText = "00:00";
            this.disableMe();
            this.stopTimer();
            BMSpecialOffersManager.gi().offerTimerEnded();
         }
         else
         {
            this.timeText = TimeUtils.formatTimeLeft(_loc1_);
         }
      }
      
      private function set timeText(param1:String) : void
      {
         this.txtTimer.text = param1;
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTimer,this);
         }
      }
      
      private function set titleText(param1:String) : void
      {
         this.txtTitle.text = param1;
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         }
      }
      
      private function getSaleTimeLeft() : Number
      {
         return BMSalesManager.gi().getSaleData().startDate + BMSalesManager.gi().getSaleData().duration - dataM.currentTime;
      }
      
      private function getStarterPackTimeLeft() : Number
      {
         var _loc1_:BMPlayerProfile = dataM.myProfile;
         return _loc1_.starterPackData.starterPackStartDate + _loc1_.starterPackData.offerDuration - dataM.currentTime;
      }
      
      override public function buyClicked() : void
      {
      }
      
      override public function removeMe() : void
      {
         this.stopTimer();
         if(screensM.isScreenOpened("screenSpecialOffers"))
         {
            screensM.removeScreen("screenSpecialOffers");
         }
      }
      
      override public function disableMe() : void
      {
         mcSpecialSalesHitArea.removeEventListener(MouseEvent.CLICK,this.specialSaleHitAreaClicked);
      }
      
      override public function enableMe() : void
      {
         mcSpecialSalesHitArea.addEventListener(MouseEvent.CLICK,this.specialSaleHitAreaClicked);
      }
      
      private function specialSaleHitAreaClicked(param1:MouseEvent) : void
      {
         this.specialSaleHitAreaClickedSub();
      }
      
      override public function specialSaleHitAreaClickedSub() : void
      {
         BMSpecialOffersManager.gi().doCurrentAction("Small");
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this.mcRays.visible)
         {
            this.mcRays.rotation += 0.1;
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

