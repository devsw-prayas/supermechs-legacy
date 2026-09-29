package net.tacticsoft.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DelayedFunctionCall
   {
      
      private var myTimer:Timer;
      
      private var delayedFunction:Function;
      
      public function DelayedFunctionCall(param1:Function, param2:Number)
      {
         super();
         this.delayedFunction = param1;
         this.myTimer = new Timer(param2,1);
         this.myTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.callDelayedFunction);
         this.myTimer.start();
      }
      
      private function callDelayedFunction(param1:TimerEvent) : *
      {
         this.myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.callDelayedFunction);
         this.delayedFunction();
         this.myTimer = null;
         this.delayedFunction = null;
      }
   }
}

