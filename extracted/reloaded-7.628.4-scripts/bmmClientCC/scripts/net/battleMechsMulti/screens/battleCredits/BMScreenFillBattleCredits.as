package net.battleMechsMulti.screens.battleCredits
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMCountdownTimerText;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3468")]
   public class BMScreenFillBattleCredits extends BMBaseScreen
   {
      
      public static const POSITION_CENTER_SCREEN:uint = 1;
      
      public static const POSITION_ON_MISSION_DIFFICULTY:uint = 2;
      
      public var mcBackgound:Sprite;
      
      public var mcSizer_screen:Sprite;
      
      public var closeBtn:BMBasicButton;
      
      public var refillBtn:BMBasicButton;
      
      public var mcRays:Sprite;
      
      public var btnMoreTokens:BMButton_plus;
      
      public var mcSizer_btnBuyTokens:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtTime:TextField;
      
      public var txtAmount:TextField;
      
      public var txtTokens:TextField;
      
      private var _countdownTimer:Timer;
      
      public function BMScreenFillBattleCredits()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("fillBattleCredits");
         this.initButtons();
         this.refreshTokens();
         this.refreshBattleCredits();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.btnMoreTokens.initialize("","",null,null,this.buyTokensClicked,false);
         TweenMax.to(this.mcRays,15,{
            "rotation":360,
            "ease":Linear.easeNone,
            "repeat":-1
         });
      }
      
      public function setPosition(param1:uint) : void
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:String = "";
         switch(param1)
         {
            case POSITION_CENTER_SCREEN:
               _loc2_ = (dataM.STAGE_WIDTH - this.mcSizer_screen.width) / 2;
               _loc3_ = (dataM.STAGE_HEIGHT - this.mcSizer_screen.height) / 2;
               _loc4_ = getScreenText("title_refillBattleCredits");
               break;
            case POSITION_ON_MISSION_DIFFICULTY:
               _loc2_ = 486;
               _loc3_ = (dataM.STAGE_HEIGHT - this.mcSizer_screen.height) / 2;
               _loc4_ = getScreenText("title_notEnoughBattleCredits");
         }
         updateTextAndFormat(this.txtTitle,_loc4_);
         x = _loc2_;
         y = _loc3_;
         this.mcBackgound.x = -_loc2_;
         this.mcBackgound.y = -_loc3_;
      }
      
      private function initButtons() : void
      {
         this.refillBtn.text = String(dataM.battleCreditsFillTokensCost);
         updateTextAndFormat(this.refillBtn["txtRefill"],getScreenText("refill"));
         ImageUtils.swapTextFieldWithBitMap(MovieClip(this.refillBtn).txtRefill,this.refillBtn.txtPlaceHolder);
         this.refillBtn.addEventListener(BMIntractable.HIT,this.onRefillButtonHit);
         this.closeBtn.addEventListener(BMIntractable.HIT,this.onCloseButtonHit);
      }
      
      public function refreshTokens() : void
      {
         updateTextAndFormat(this.txtTokens,TextUtils.getNumberWithComma(dataM.myProfile.tokens));
         ImageUtils.swapTextFieldWithBitMap(this.txtTokens,this);
      }
      
      private function onRefillButtonHit(param1:Event) : void
      {
         if(dataM.myProfile.tokens >= dataM.battleCreditsFillTokensCost)
         {
            dataM.gameOfWhalesM.tokensConvertedToBattleCredits(dataM.battleCreditsFillTokensCost,dataM.battleCreditsManager.battleCreditsMax);
            remoteM.socketM.fillBattleCredits();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            this.removeMe();
         }
         else
         {
            this.openTokensShop();
         }
      }
      
      private function openTokensShop() : void
      {
         BMShopManager.gi().showTokens();
      }
      
      private function onCloseButtonHit(param1:Event) : void
      {
         this.removeMe();
      }
      
      private function removeMe() : void
      {
         screensM.removeScreen("screenFillBattleCredits");
      }
      
      private function refreshBattleCredits() : void
      {
         dataM.battleCreditsManager.addBattleCreditsChangeCallback(this.battleCreditsChanged);
         this.removeCountdownTimer();
         this._countdownTimer = new Timer(1000);
         this._countdownTimer.addEventListener(TimerEvent.TIMER,this.countdownTimerTrigger);
         this._countdownTimer.start();
         this.refreshBattleCreditsCountdownText();
      }
      
      private function battleCreditsChanged(param1:uint) : void
      {
         if(param1 >= dataM.battleCreditsManager.battleCreditsMax)
         {
            screensM.addScreen("screenBattleCreditsFull");
            this.removeMe();
         }
      }
      
      private function countdownTimerTrigger(param1:TimerEvent) : void
      {
         this.refreshBattleCreditsCountdownText();
      }
      
      private function refreshBattleCreditsCountdownText() : void
      {
         updateTextAndFormat(this.txtTime,"in " + BMCountdownTimerText.getCountdownTimerText(dataM.battleCreditsManager.getSecondsLeftForBattleCreditAddon()));
      }
      
      private function removeCountdownTimer() : void
      {
         if(this._countdownTimer != null)
         {
            this._countdownTimer.stop();
            this._countdownTimer.removeEventListener(TimerEvent.TIMER,this.countdownTimerTrigger);
            this._countdownTimer = null;
         }
      }
      
      private function buyTokensClicked() : void
      {
         this.openTokensShop();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         dataM.battleCreditsManager.removeBattleCreditsChangeCallback(this.battleCreditsChanged);
         TweenMax.killTweensOf(this.mcRays);
      }
   }
}

