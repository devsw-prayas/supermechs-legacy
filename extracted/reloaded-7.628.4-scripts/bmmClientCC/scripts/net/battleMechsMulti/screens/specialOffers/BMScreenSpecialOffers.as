package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.externalImages.BMExternalImage;
   import net.battleMechsMulti.managers.externalImages.BMExternalImagesManager;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMCountdownTimerText;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.buttons.BMButton2;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol612")]
   public class BMScreenSpecialOffers extends BMScreenSpecialOffersBase
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcMechPosition:Sprite;
      
      public var mcMechHolder:Sprite;
      
      public var mcExternalImagesHolder:Sprite;
      
      public var mcExternalImageSizer:Sprite;
      
      public var txtTimer:TextField;
      
      public var txtTimeLeft:TextField;
      
      public var txtSpecialOffer:TextField;
      
      public var mcSizer_btnBuy:Sprite;
      
      public var btnBuy:BMButton2;
      
      public var mcSandClock:MovieClip;
      
      private var mechView:BMMechView;
      
      private var _firstRefresh:Boolean = true;
      
      private var _resetTimer:Timer;
      
      private var _externalImage:BMExternalImage;
      
      private var _swapSameSaleGraphics_currentIndex:uint;
      
      private var _swapSameSaleGraphics_frameCounter:uint;
      
      public function BMScreenSpecialOffers()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      override public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("specialOffers");
            screensM.createButtonFromSizer(BMScreensManager.SCR_SPECIAL_OFFERS,"btnBuy","regular2");
            _loc1_ = this.buyClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
            }
            switch(dataM.languageID)
            {
               case 5:
                  this.btnBuy.changeFontSize(23);
                  break;
               case 6:
                  this.btnBuy.changeFontSize(26);
                  break;
               case 7:
                  this.btnBuy.changeFontSize(23);
                  break;
               case 10:
                  this.btnBuy.changeFontSize(31);
                  break;
               default:
                  if(dataM.runAsMobile)
                  {
                     this.btnBuy.setRunAsMobile(dataM.runAsMobile);
                     this.btnBuy.changeFontSize(40);
                  }
            }
            this.btnBuy.initialize(getScreenText("buy"),"",null,null,_loc1_,dataM.runAsMobile);
            this.btnBuy.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         mcSpecialSalesHitArea.buttonMode = true;
         mcSpecialSalesHitArea.useHandCursor = true;
         this._swapSameSaleGraphics_currentIndex = 0;
         this.refreshSale();
         this.stopTimer();
         this.refreshTimer();
         this._resetTimer = new Timer(1000,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.resetTimerEvent);
         this._resetTimer.start();
         this.enableBuyButton();
         if(dataM.runAsMobile == false)
         {
            mcSpecialSalesHitArea.addEventListener(MouseEvent.CLICK,this.specialSaleHitAreaClicked);
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = 20;
            switch(dataM.languageID)
            {
               case 3:
                  _loc2_ = 16;
                  break;
               case 5:
                  _loc2_ = 14;
                  break;
               case 7:
                  _loc2_ = 16;
                  break;
               case 9:
                  _loc2_ = 16;
                  break;
               case 10:
                  _loc2_ = 14;
            }
            TextUtils.updateTextFormat(this.txtTimeLeft,_loc2_);
            TextUtils.updateTextFormat(this.txtTimer,20);
            param1 = true;
         }
         if(param1)
         {
            switch(dataM.languageID)
            {
               case 3:
                  this.btnBuy.changeFontSize(28);
                  break;
               case 4:
               case 5:
               case 7:
                  this.btnBuy.changeFontSize(23);
                  break;
               case 6:
                  this.btnBuy.changeFontSize(26);
                  break;
               case 10:
                  this.btnBuy.changeFontSize(31);
                  break;
               default:
                  this.btnBuy.changeFontSize(40);
            }
            this.btnBuy.setButtonName(getScreenText("buy"));
         }
         this.txtTimeLeft.text = getScreenText("timeLeft");
         dataM.updateBoostNames();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(this.mechView != null)
            {
               this.mechView.onEnterFrameTrigger();
            }
            this.swapSameSaleGraphicsHandler();
         }
      }
      
      override public function buyClicked() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
         }
      }
      
      public function enableBuyButton() : void
      {
         this.btnBuy.enableMe();
      }
      
      public function disableBuyButton() : void
      {
         this.btnBuy.disableMe();
      }
      
      private function swapSameSaleGraphicsHandler() : void
      {
         if(BMSalesManager.gi().getSaleData().bannerImageLinks.length < 2)
         {
            return;
         }
         if(this._swapSameSaleGraphics_frameCounter >= 500)
         {
            ++this._swapSameSaleGraphics_currentIndex;
            if(this._swapSameSaleGraphics_currentIndex >= BMSalesManager.gi().getSaleData().bannerImageLinks.length)
            {
               this._swapSameSaleGraphics_currentIndex = 0;
            }
            this._swapSameSaleGraphics_frameCounter = 0;
            this.refreshSale();
         }
         ++this._swapSameSaleGraphics_frameCounter;
      }
      
      private function specialSaleHitAreaClicked(param1:MouseEvent) : void
      {
         this.specialSaleHitAreaClickedSub();
      }
      
      override public function specialSaleHitAreaClickedSub() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            BMSpecialOffersManager.gi().doCurrentAction("SaleBanner");
         }
      }
      
      private function refreshSale() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         this.mcSandClock.gotoAndStop("animOff");
         this.refreshTimer();
         this.removeExternalImage();
         switch(BMSpecialOffersManager.gi().currentOfferID)
         {
            case BMSpecialOffersManager.STARTER_PACK_ID:
               this.btnBuy.visible = true;
               break;
            case BMSpecialOffersManager.GLOBAL_SALE_ID:
               this.btnBuy.visible = false;
               this.mcSandClock.gotoAndStop("animOn");
               _loc1_ = BMSalesManager.gi().getSaleData().bannerImageLinks[this._swapSameSaleGraphics_currentIndex];
               this._externalImage = BMExternalImagesManager.gi().createExternalImage(_loc1_,this.mcExternalImageSizer.width,this.mcExternalImageSizer.height,this.removeSandClock);
               this._externalImage.x = 0;
               this._externalImage.y = 0;
               this.mcExternalImagesHolder.addChild(this._externalImage);
         }
         if(dataM.runAsMobile)
         {
            _loc2_ = [this.txtTimeLeft];
            screensM.createMultipleTextsBitmap("specialOffers_texts",_loc2_,"",this);
         }
      }
      
      private function removeSandClock() : void
      {
         this.mcSandClock.gotoAndStop("animOff");
      }
      
      private function removeExternalImage() : void
      {
         if(this._externalImage != null)
         {
            if(this._externalImage.parent != null)
            {
               this._externalImage.parent.removeChild(this._externalImage);
            }
            this._externalImage = null;
         }
      }
      
      private function resetTimerEvent(param1:TimerEvent) : void
      {
         this.refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:Number = BMSalesManager.gi().getSaleData().endDate - dataM.currentTime;
         if(_loc1_ <= 0)
         {
            BMSpecialOffersManager.gi().offerTimerEnded();
            this.removeMe();
         }
         else
         {
            this.txtTimer.htmlText = TextUtils.getTextFont() + BMCountdownTimerText.getCountdownTimerText(_loc1_);
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("specialOffers_timer",[this.txtTimer],"",this);
            }
         }
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
      
      override public function removeMe() : void
      {
         this.stopTimer();
         if(mcSpecialSalesHitArea.parent != null)
         {
            mcSpecialSalesHitArea.parent.removeChild(mcSpecialSalesHitArea);
         }
         if(dataM.runAsMobile == false)
         {
            mcSpecialSalesHitArea.removeEventListener(MouseEvent.CLICK,this.specialSaleHitAreaClicked);
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_SPECIAL_OFFERS))
         {
            screensM.removeScreen(BMScreensManager.SCR_SPECIAL_OFFERS);
         }
      }
      
      override public function enableMe() : void
      {
         super.enableMe();
         this.enableBuyButton();
      }
      
      override public function disableMe() : void
      {
         super.disableMe();
         this.disableBuyButton();
      }
   }
}

