package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureA;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol526")]
   public class BMScreenBuyBattleCredits extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnBuy1:Sprite;
      
      public var mcSizer_btnBuy6:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtTimeLeft:TextField;
      
      public var txtNewBattleCreditReceived:TextField;
      
      private var _txtTimeLeftOriginYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnBuy1:BMButton_pictureA;
      
      public var btnBuy6:BMButton_pictureA;
      
      public var buttonIcons:Sprite;
      
      public function BMScreenBuyBattleCredits()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyBattleCredits");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenBuyBattleCredits","btnBack","pictureE");
            screensM.createButtonFromSizer("screenBuyBattleCredits","btnBuy1","pictureA");
            screensM.createButtonFromSizer("screenBuyBattleCredits","btnBuy6","pictureA");
            _loc1_ = this.backClicked;
            _loc2_ = this.buy1Clicked;
            _loc3_ = this.buy6Clicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
               _loc3_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc1_,dataM.runAsMobile);
            this.btnBuy1.initialize("","",null,null,_loc2_,dataM.runAsMobile);
            this.btnBuy6.initialize("","",null,null,_loc3_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuy1.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuy6.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.buttonIcons.mouseEnabled = false;
            this.buttonIcons.mouseChildren = false;
            this._txtTimeLeftOriginYPos = this.txtTimeLeft.y;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this.txtNewBattleCreditReceived.text = "";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyLadderBattles_newBattleCreditReceived",[this.txtNewBattleCreditReceived],"",this);
         }
         this.txtTimeLeft.y = this._txtTimeLeftOriginYPos;
         this.refreshBattleCreditsTimer(screensM.getSecondsLeftForBattleCreditAddon());
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtNewBattleCreditReceived,20);
            TextUtils.updateTextFormat(this.txtTimeLeft,20);
            TextUtils.updateTextFormat(this.txtTitle,20);
         }
         this.txtTitle.text = getScreenText("title");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyLadderBattles_title",[this.txtTitle],"",this);
         }
      }
      
      public function refreshBattleCreditsTimer(param1:Number) : void
      {
         var _loc4_:String = null;
         var _loc2_:Number = Math.floor(param1 / 60);
         var _loc3_:Number = param1 % 60;
         if(_loc3_ >= 10)
         {
            _loc4_ = String(_loc3_);
         }
         else
         {
            _loc4_ = "0" + _loc3_;
         }
         var _loc5_:String = getScreenText("timeLeftForNextBattleCredit");
         if(param1 == 0)
         {
            this.txtNewBattleCreditReceived.text = getScreenText("newBattleCreditReceived");
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("buyLadderBattles_newBattleCreditReceived",[this.txtNewBattleCreditReceived],"",this);
            }
            this.txtTimeLeft.y = this._txtTimeLeftOriginYPos + 18;
            _loc5_ = dataM.replaceStringInText(_loc5_,"%TIME%","0 : 00");
         }
         else
         {
            _loc5_ = dataM.replaceStringInText(_loc5_,"%TIME%",_loc2_ + " : " + _loc4_);
         }
         this.txtTimeLeft.htmlText = _loc5_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyLadderBattles_timer",[this.txtTimeLeft],"",this);
         }
      }
      
      public function buy1Clicked() : void
      {
         this.checkForBattleCreditsPriceReset();
         screensM.screenConfirmation.displayQuestionOrNotification("tryToBuy1BattleCredit",-1,-1);
      }
      
      public function buy6Clicked() : void
      {
         this.checkForBattleCreditsPriceReset();
         screensM.screenConfirmation.displayQuestionOrNotification("tryToBuy6BattleCredits",-1,-1);
      }
      
      private function checkForBattleCreditsPriceReset() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(dataM.useBattleCreditsPriceIncrease)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc1_.nextBattleCreditsReset < dataM.currentTime)
            {
               _loc1_.battleCreditsBought = 0;
               _loc1_.nextBattleCreditsReset += dataM.battleCreditsPriceSecondsToReset;
            }
         }
      }
      
      public function battleCreditsBought() : void
      {
         screensM.removeScreen("screenBuyBattleCredits");
         if(screensM.isScreenOpened("screenMissionBaseMap"))
         {
            screensM.screenMissionBaseMap.battleCreditsBought();
         }
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen("screenBuyBattleCredits");
         if(screensM.isScreenOpened("screenMissionBaseMap"))
         {
            screensM.screenMissionBaseMap.buyBattleCreditsScreenClosed();
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen();
      }
   }
}

