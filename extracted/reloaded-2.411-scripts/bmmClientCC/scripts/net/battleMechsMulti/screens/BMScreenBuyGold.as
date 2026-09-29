package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureK;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol593")]
   public class BMScreenBuyGold extends BMBaseScreen
   {
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnBuy:Sprite;
      
      public var mcSizer_scroller:Sprite;
      
      public var mcSizer_btnGetTokens:Sprite;
      
      public var mcScroller:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtTokens:TextField;
      
      public var txtGold:TextField;
      
      public var txtGuide:TextField;
      
      public var txtNotEnough:TextField;
      
      public var btnBuy:BMButton;
      
      public var btnGetTokens:BMButton;
      
      public var btnBack:BMButton_pictureK;
      
      public var mcMouseHitArea:Sprite;
      
      private var _tokens:uint;
      
      private var _gold:uint;
      
      private var _enoughTokens:Boolean;
      
      private var _scrollerActive:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      private const TOKENS_MIN:uint = 25;
      
      private const TOKENS_MAX:uint = 1000;
      
      public function BMScreenBuyGold()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyGold");
      }
      
      public function refreshScreen() : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenBuyGold","btnBack","pictureK");
            screensM.createButtonFromSizer("screenBuyGold","btnGetTokens","regular");
            screensM.createButtonFromSizer("screenBuyGold","btnBuy","regular");
            _loc2_ = this.backClicked;
            _loc3_ = this.buyClicked;
            _loc4_ = this.getTokensClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
            }
            this.btnGetTokens.changeFontSize(26);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
            this.btnBuy.initialize(getSpecificText("buyGold_buy"),"orange",null,null,_loc3_,dataM.runAsMobile);
            this.btnGetTokens.initialize(getSpecificText("buyGold_getTokens"),"orange",null,null,_loc4_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuy.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnGetTokens.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.txtTitle.text = getSpecificText("buyGold_title");
            this.txtGuide.text = getSpecificText("buyGold_guide");
            if(dataM.runAsMobile == false)
            {
               this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.scrollerMouseDown);
               this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.scrollerMouseUp);
               this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.scrollerMouseUp);
            }
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this._tokens = 10;
         this.mcScroller.x = this.mcSizer_scroller.x;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.tokens >= this.TOKENS_MIN)
         {
            this._enoughTokens = true;
         }
         else
         {
            this._enoughTokens = false;
         }
         this.refreshStats();
         this.refreshNotEnoughTokens();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtGuide,20);
            TextUtils.updateTextFormat(this.txtNotEnough,20);
            TextUtils.updateTextFormat(this.txtTitle,20);
            _loc2_ = 30;
            switch(dataM.languageID)
            {
               case 1:
                  break;
               default:
                  _loc2_ = 34;
            }
            TextUtils.updateTextFormat(this.txtTokens,_loc2_);
            TextUtils.updateTextFormat(this.txtGold,_loc2_);
            param1 = true;
         }
         if(param1)
         {
            TextUtils.updateTextFormat(this.btnGetTokens.txtButtonName);
            TextUtils.updateTextFormat(this.btnBuy.txtButtonName);
            switch(dataM.languageID)
            {
               case 1:
                  this.btnGetTokens.changeFontSize(33);
                  this.btnBuy.changeFontSize(33);
                  break;
               default:
                  this.btnGetTokens.changeFontSize(23);
                  this.btnBuy.changeFontSize(27);
            }
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyGold_title",[this.txtTitle,this.txtGuide],"",this);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.scrollerHandler();
      }
      
      private function scrollerHandler() : void
      {
         var _loc1_:Number = NaN;
         if(this._enoughTokens)
         {
            if(this._scrollerActive)
            {
               _loc1_ = mouseX;
               if(_loc1_ < this.mcSizer_scroller.x)
               {
                  _loc1_ = this.mcSizer_scroller.x;
               }
               else if(_loc1_ > this.mcSizer_scroller.x + this.mcSizer_scroller.width)
               {
                  _loc1_ = this.mcSizer_scroller.x + this.mcSizer_scroller.width;
               }
               this.mcScroller.x = _loc1_;
               this.refreshStats();
            }
         }
      }
      
      private function scrollerMouseDown(param1:MouseEvent) : void
      {
         this.scrollerMouseDownSub();
      }
      
      public function scrollerMouseDownSub() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.tokens >= this.TOKENS_MIN)
         {
            if(mouseY > this.mcScroller.y - 50 && mouseY < this.mcScroller.y + 50)
            {
               if(mouseX > this.mcScroller.x - 30 && mouseX < this.mcScroller.x + 30)
               {
                  this._scrollerActive = true;
               }
               else if(mouseX > this.mcSizer_scroller.x && mouseX < this.mcSizer_scroller.x + this.mcSizer_scroller.width)
               {
                  this.mcScroller.x = mouseX;
                  this._scrollerActive = true;
               }
            }
         }
      }
      
      private function scrollerMouseUp(param1:MouseEvent) : void
      {
         this.scrollerMouseUpSub();
      }
      
      public function scrollerMouseUpSub() : void
      {
         this._scrollerActive = false;
      }
      
      private function refreshStats() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Number = _loc1_.tokens;
         if(_loc2_ > 1000)
         {
            _loc2_ = 1000;
         }
         this._tokens = (this.mcScroller.x - this.mcSizer_scroller.x) / this.mcSizer_scroller.width * (_loc2_ - this.TOKENS_MIN) + this.TOKENS_MIN;
         this._gold = dataM.goldPerToken * this._tokens;
         this.txtTokens.text = dataM.getNumberWithComma(this._tokens);
         this.txtGold.text = dataM.getNumberWithComma(this._gold);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyGold_amounts",[this.txtGold,this.txtTokens],"",this);
         }
      }
      
      private function refreshNotEnoughTokens() : void
      {
         var _loc1_:String = null;
         if(this._enoughTokens)
         {
            this.txtNotEnough.text = "";
            this.btnBuy.visible = true;
            this.btnBuy.enableMe();
            this.btnGetTokens.visible = false;
         }
         else
         {
            _loc1_ = getSpecificText("buyGold_minimumTokensRequired");
            _loc1_ = dataM.replaceStringInText(_loc1_,"%TOKENS%",dataM.getNumberWithComma(this.TOKENS_MIN));
            this.txtNotEnough.text = _loc1_;
            this.btnBuy.visible = false;
            this.btnGetTokens.visible = true;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyGold_notEnough",[this.txtNotEnough],"",this);
         }
      }
      
      public function buyClicked() : void
      {
         this.btnBuy.disableMe();
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         remoteM.socketM.buyGold(this._tokens);
      }
      
      public function buySuccess(param1:uint) : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("goldBought",this._gold,this._tokens);
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc2_.tokens -= this._tokens;
         if(this._tokens <= _loc2_.tokens_bonus)
         {
            _loc2_.tokens_bonus -= this._tokens;
         }
         else
         {
            this._tokens -= _loc2_.tokens_bonus;
            _loc2_.tokens_bonus = 0;
            _loc2_.tokens_supporter -= this._tokens;
         }
         _loc2_.gold = param1;
         this.refreshScreen();
         if(screensM.isScreenOpened("screenGlobalShop"))
         {
            screensM.screenGlobalShop.refreshGoldTokensTexts();
         }
         if(screensM.isScreenOpened("screenHangerUpgrade"))
         {
            screensM.screenHangerUpgrade.refreshGold();
         }
      }
      
      public function buyFailed() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("notEnoughTokens_noValue");
      }
      
      public function getTokensClicked() : void
      {
         dataM.openBuyTokensPage("ScreenBuyGold");
         screensM.removeScreen("screenBuyGold");
      }
      
      public function backClicked() : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenBuyGold");
         if(dataM.runAsMobile == false)
         {
            this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.scrollerMouseDown);
            this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.scrollerMouseUp);
            this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_OUT,this.scrollerMouseUp);
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen();
      }
   }
}

