package net.battleMechsMulti.screens.kinShop
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMKinBetPanel extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtOn:TextField;
      
      public var txtBank:TextField;
      
      public var txtWinTitle:TextField;
      
      public var txtWinValue:TextField;
      
      public var txtBetTitle:TextField;
      
      public var txtBetValue:TextField;
      
      public var mcSwitch:MovieClip;
      
      public var mcHitArea:Sprite;
      
      public var mcDisabledCover:Sprite;
      
      public var mcBetsLeftCounter:TextHolder;
      
      private var _isEnabled:Boolean = true;
      
      public function BMKinBetPanel()
      {
         super();
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("kin");
         updateTextAndFormat(this.txtTitle,getScreenText("kinChallenge"));
         updateTextAndFormat(this.txtOn,getScreenText("imIn"));
         updateTextAndFormat(this.txtWinTitle,getScreenText("win"));
         updateTextAndFormat(this.txtBetTitle,getScreenText("bet"));
         this.mcHitArea.addEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
         sub(BMPubSub.MESSAGE_KIN_ACCOUNT_BALANCE_UPDATED,this.onBalanceUpdate);
      }
      
      public function refreshData() : void
      {
         this.txtBetValue.text = dataM.kinM.pvpBet.toString();
         this.txtWinValue.text = dataM.kinM.pvpWin.toString();
         if(dataM.kinM.challengesLeftToday > 0)
         {
            this.mcBetsLeftCounter.text = String(dataM.kinM.challengesLeftToday);
            this.mcBetsLeftCounter.visible = true;
         }
         else
         {
            this.mcBetsLeftCounter.visible = false;
         }
         this.updateKin();
         this.refreshBettingState();
      }
      
      private function updateKin() : void
      {
         this.txtBank.text = dataM.kinM.kin.toString();
      }
      
      private function onHitAreaClicked(param1:MouseEvent) : void
      {
         if(this._isEnabled == false)
         {
            return;
         }
         dataM.kinM.toggleBettingState(true);
         this.refreshBettingState();
      }
      
      private function refreshBettingState() : void
      {
         if(dataM.kinM.bettingActive)
         {
            this.mcSwitch.gotoAndStop("on");
            this.mcDisabledCover.visible = false;
         }
         else
         {
            this.mcSwitch.gotoAndStop("off");
            this.mcDisabledCover.visible = true;
         }
      }
      
      public function disableMe() : void
      {
         this._isEnabled = false;
      }
      
      public function enableMe() : void
      {
         this._isEnabled = true;
      }
      
      private function onBalanceUpdate(param1:String, param2:Object) : void
      {
         this.updateKin();
      }
   }
}

