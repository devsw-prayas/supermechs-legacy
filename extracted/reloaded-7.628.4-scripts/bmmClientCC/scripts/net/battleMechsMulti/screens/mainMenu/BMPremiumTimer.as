package net.battleMechsMulti.screens.mainMenu
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.TimeUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2496")]
   public class BMPremiumTimer extends BMBaseScreen
   {
      
      public var txtTimer:TextField;
      
      private var _resetTimer:Timer = null;
      
      public function BMPremiumTimer()
      {
         super();
         generateSingletonClassesPointers();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         sub(BMPubSub.MESSAGE_PREMIUM_PACKAGE_BOUGHT,this.onPremiumPackageBought);
         if(dataM.isPremiumAccountActive())
         {
            this.startTimer();
         }
         else
         {
            visible = false;
         }
      }
      
      private function onPremiumPackageBought(param1:String, param2:Object) : void
      {
         if(this._resetTimer == null)
         {
            this.startTimer();
         }
      }
      
      private function startTimer() : *
      {
         this._resetTimer = new Timer(1000,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.onTimerEvent);
         this._resetTimer.start();
         visible = true;
         this.refreshTimer();
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         this.refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:Number = dataM.premiumAccountTime - dataM.currentTime;
         if(_loc1_ <= 0)
         {
            this.stopTimer();
         }
         else
         {
            this.timeText = TimeUtils.formatTimeLeftWithDays(_loc1_);
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
      
      private function stopTimer() : void
      {
         if(this._resetTimer != null)
         {
            this._resetTimer.stop();
            this._resetTimer.removeEventListener(TimerEvent.TIMER,this.onTimerEvent);
            this._resetTimer = null;
         }
         visible = false;
      }
      
      private function onRemoved(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         notifyRemoved();
      }
   }
}

