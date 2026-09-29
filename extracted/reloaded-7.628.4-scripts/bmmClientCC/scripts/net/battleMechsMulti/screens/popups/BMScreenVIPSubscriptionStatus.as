package net.battleMechsMulti.screens.popups
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2037")]
   public class BMScreenVIPSubscriptionStatus extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtTokens:TextField;
      
      public var txtTimeLeftDesc:TextField;
      
      public var mcTokens:Sprite;
      
      public var mcTokensBackground:Sprite;
      
      public var mcTimer:BMTimer;
      
      public var btnClaim:BMBasicButton;
      
      public var btnOK:BMBasicButton;
      
      public var btnClose:BMBasicButton;
      
      private var _onClaimCallback:Function;
      
      public function BMScreenVIPSubscriptionStatus()
      {
         super();
      }
      
      public function BMScreenMonthlyDealStatus() : *
      {
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("vipSubscription");
         this.btnClaim.addEventListener(BMIntractable.HIT,this.claimClicked);
         this.btnOK.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.btnOK.text = getGeneralText("OK");
         this.btnClaim.text = getSpecificText("buyTokens_claim");
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
      }
      
      public function showClaim(param1:Function) : void
      {
         this._onClaimCallback = param1;
         this.btnClaim.visible = true;
         this.btnClose.visible = false;
         this.btnOK.visible = false;
         this.mcTimer.visible = false;
         updateTextAndFormat(this.txtTimeLeftDesc,"");
         updateTextAndFormat(this.txtTokens,String(dataM.vipAccountData.dailyTokensForVIPAccount));
         this.mcTokens.visible = true;
         this.mcTokensBackground.visible = true;
         this.blockNextClickInGlobalShopForMobile();
      }
      
      public function showTimer() : void
      {
         var _loc1_:String = null;
         this.btnClaim.visible = false;
         this.btnClose.visible = true;
         this.btnOK.visible = true;
         this.mcTimer.visible = true;
         var _loc2_:uint = Math.ceil(dataM.vipAccountData.vipAccountSecondsLeft / 86400);
         if(_loc2_ == 1)
         {
            _loc1_ = getScreenText("oneDayLeft");
         }
         else
         {
            _loc1_ = getScreenText("xDaysLeft");
            _loc1_ = dataM.replaceStringInText(_loc1_,"%DAYS%",String(_loc2_));
         }
         _loc1_ = _loc1_ + "<BR>" + getScreenText("timeLeftToNextBonus");
         updateTextAndFormat(this.txtTimeLeftDesc,_loc1_);
         updateTextAndFormat(this.txtTokens,"");
         this.mcTokens.visible = false;
         this.mcTokensBackground.visible = false;
         this.mcTimer.initialize(this.getTimeLeft,this.onTimeEnded);
         this.blockNextClickInGlobalShopForMobile();
      }
      
      private function blockNextClickInGlobalShopForMobile() : void
      {
         if(dataM.runAsMobile && screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP))
         {
            screensM.screenGlobalShop.blockNextMobileClick = true;
         }
      }
      
      private function onTimeEnded() : void
      {
      }
      
      private function getTimeLeft() : int
      {
         return dataM.vipAccountData.secondsUntilNextDailyBonus;
      }
      
      private function claimClicked(param1:Event) : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP))
         {
            screensM.screenGlobalShop.blockNextMobileClick = true;
         }
         if(this._onClaimCallback != null)
         {
            this._onClaimCallback();
         }
         this.removeMe();
      }
      
      private function closeClicked(param1:Event) : void
      {
         this.removeMe();
      }
      
      private function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_VIP_SUBSCRIPTION_STATUS);
      }
   }
}

