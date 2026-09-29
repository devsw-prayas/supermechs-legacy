package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMCountdownTimerText;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol785")]
   public class BMScreenServerRestartCountdown extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtTimer:TextField;
      
      private var _timer:Timer;
      
      private var _hideTextNextFrame:Boolean = false;
      
      public function BMScreenServerRestartCountdown()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         this.removeTimer();
         this.txtTitle.text = "SERVER WILL RESTART IN:";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("serverRestartCountdown_title",[this.txtTitle],"",this);
         }
         this.refreshCountdownTimerTextSub();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.refreshCountdownTimerText);
         this._timer.start();
         this.refreshCountdownTimerTextSub();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      private function refreshCountdownTimerText(param1:TimerEvent) : void
      {
         this.refreshCountdownTimerTextSub();
      }
      
      private function refreshCountdownTimerTextSub() : void
      {
         var _loc1_:Number = NaN;
         if(dataM.serverRestartTimeDisplay == 0)
         {
            screensM.removeScreen("screenServerRestartCountdown");
         }
         else
         {
            _loc1_ = dataM.serverRestartTimeDisplay - dataM.currentTime;
            this.txtTimer.text = BMCountdownTimerText.getCountdownTimerText(_loc1_);
            if(this.txtTimer.text == "00:00" && this._hideTextNextFrame)
            {
               this.txtTimer.text = "";
               this._hideTextNextFrame = false;
            }
            else
            {
               this._hideTextNextFrame = true;
            }
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("serverRestartCountdown_timer",[this.txtTimer],"",this);
         }
      }
      
      private function removeTimer() : void
      {
         if(this._timer != null)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.refreshCountdownTimerText);
            this._timer = null;
         }
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeTimer();
      }
   }
}

