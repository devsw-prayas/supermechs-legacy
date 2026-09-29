package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.screens.shop.IconAndText;
   import net.battleMechsMulti.utils.TextUtils;
   import net.battleMechsMulti.utils.TimeUtils;
   
   public class BMScreenSpecialOffersPackage extends BMScreenSpecialOffersBase
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var txtSpecialOffer:TextField;
      
      public var mcTokens:IconAndText;
      
      public var mcGold:IconAndText;
      
      public var txtTimer:TextField;
      
      public var txtTimeLeft:TextField;
      
      public var mcSizer_btnBuy:Sprite;
      
      public var btnBuy:BMButton;
      
      private var _firstRefresh:Boolean = true;
      
      private var _sparks:Array = new Array();
      
      private var _sparksActive:Boolean = false;
      
      private var _sparksRarity:uint;
      
      private var _resetTimer:Timer;
      
      private var _itemCardMCs:Array = new Array();
      
      private var _itemCardsRarity:Array = new Array();
      
      protected var _specialOfferFontSize:uint = 29;
      
      public function BMScreenSpecialOffersPackage()
      {
         super();
      }
      
      public function BMScreenSpecialOfferPackage() : *
      {
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMScreenSpecialOfferPackage initialized");
         generateSingletonClassesPointers("");
      }
      
      override public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("specialOffers");
            screensM.createButtonFromSizer("screenSpecialOffers","btnBuy","regular");
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
            this.btnBuy.initialize(getScreenText("buy"),"green",null,null,_loc1_,dataM.runAsMobile);
            this.btnBuy.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.updateFromData();
         this.enableBuyButton();
      }
      
      protected function updateFromData() : void
      {
         var _loc4_:BMTokenPackage = null;
         var _loc5_:Array = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:* = false;
         var _loc3_:uint = 0;
         while(_loc3_ < dataM.allTokenPackages.length)
         {
            _loc4_ = dataM.allTokenPackages[_loc3_];
            if(_loc4_.starterPackID == _loc1_.starterPackData.packID)
            {
               _loc1_.starterPackData.tokenPackageID = _loc4_.packageID;
               _loc1_.starterPackData.bonusTokens = _loc4_.tokens;
               _loc1_.starterPackData.price = _loc4_.price;
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         if(!_loc2_)
         {
            TsLogger.log("BMScreenSpecialOffersPackage :: refreshScreen ERROR could not find starterPackID " + _loc4_.starterPackID + " in allTokenPackages");
         }
         this.mcGold.text = dataM.getNumberWithComma(_loc1_.starterPackData.bonusGold);
         this.mcTokens.text = dataM.getNumberWithComma(_loc1_.starterPackData.bonusTokens);
         this.stopTimer();
         this.refreshTimer();
         this.startTimer();
         if(dataM.runAsMobile)
         {
            _loc5_ = [this.txtSpecialOffer,this.txtTimeLeft];
            screensM.createMultipleTextsBitmap("specialOffers_texts",_loc5_,"",this);
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = this._specialOfferFontSize;
            _loc3_ = 19;
            switch(dataM.languageID)
            {
               case 3:
                  _loc2_ -= 2;
                  _loc3_ -= 4;
                  break;
               case 5:
                  break;
               case 7:
                  _loc2_ -= 2;
                  break;
               case 9:
                  _loc2_ -= 2;
                  break;
               case 10:
                  _loc2_ -= 4;
            }
            TextUtils.updateTextFormat(this.txtSpecialOffer,_loc2_);
            TextUtils.updateTextFormat(this.txtTimeLeft,_loc3_);
            TextUtils.updateTextFormat(this.txtTimer,23);
            TextUtils.updateTextFormat(this.btnBuy.txtButtonName);
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
                  this.btnBuy.changeFontSize(23);
                  break;
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
                     this.btnBuy.changeFontSize(40);
                  }
                  else
                  {
                     this.btnBuy.changeFontSize(40);
                  }
            }
            this.btnBuy.setButtonName(getScreenText("buy"));
         }
         this.txtTimeLeft.text = getScreenText("timeLeft");
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.sparksHandler();
         }
      }
      
      private function sparksHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:Sprite = null;
         var _loc6_:Sprite = null;
         if(this._sparksActive)
         {
            _loc2_ = Math.ceil(Math.random() * 15);
            _loc3_ = 0;
            if(_loc2_ == 1)
            {
               _loc4_ = "Grp_itemCardSpark" + this._sparksRarity;
               _loc5_ = externalAssetsM.getAsset("general",_loc4_);
               this.mcIconsHolder.addChild(_loc5_);
               this._sparks.push(_loc5_);
            }
         }
         _loc1_ = 0;
         while(_loc1_ < this._sparks.length)
         {
            _loc6_ = this._sparks[_loc1_];
            if(_loc6_.scaleX > 0.075)
            {
               _loc6_.scaleX -= 0.075;
               _loc6_.scaleY -= 0.075;
            }
            else
            {
               this._sparks[_loc1_].parent.removeChild(this._sparks[_loc1_]);
               this._sparks[_loc1_] = null;
               this._sparks.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      override public function buyClicked() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            if(!screensM.isScreenOpened("screenMissionWorldMap"))
            {
               screensM.screenNewMenu.openBuyStarterPack("SpecialOffersPackage");
            }
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
      
      private function resetTimerEvent(param1:TimerEvent) : void
      {
         this.refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:BMPlayerProfile = dataM.myProfile;
         var _loc2_:Number = _loc1_.starterPackData.starterPackStartDate + _loc1_.starterPackData.offerDuration - dataM.currentTime;
         if(_loc2_ <= 0)
         {
            this.txtTimeLeft.htmlText = TextUtils.getTextFont() + getSpecificText("buyStarterPack_timeUp");
            this.txtTimer.text = "00:00";
            this.btnBuy.disableMe();
            this.stopTimer();
         }
         else
         {
            this.txtTimer.text = TimeUtils.formatTimeLeft(_loc2_);
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("specialOffers_timerPackage",[this.txtTimer],"",this);
         }
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
      
      override public function removeMe() : void
      {
         this.stopTimer();
         if(screensM.isScreenOpened("screenSpecialOffers"))
         {
            screensM.removeScreen("screenSpecialOffers");
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

