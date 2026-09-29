package net.battleMechsMulti.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMRemoteManager;
   
   public class TokenPolling
   {
      
      private var remoteM:BMRemoteManager;
      
      private var getTokens:Function;
      
      private var lastTokens:int;
      
      private var callbackCalled:Boolean = false;
      
      private var tokensAddedCallback:Function;
      
      private var timeoutCallback:Function;
      
      private var delay:uint = 5000;
      
      private var repeat:uint = 20;
      
      private var myTimer:Timer = new Timer(this.delay,this.repeat);
      
      private var dismissed:Boolean = false;
      
      public function TokenPolling(param1:BMRemoteManager, param2:Function, param3:Function, param4:Function)
      {
         super();
         this.remoteM = param1;
         this.getTokens = param2;
         this.lastTokens = this.getTokens();
         this.myTimer.start();
         this.myTimer.addEventListener(TimerEvent.TIMER,this.timerHandler);
         this.myTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.completeHandler);
         this.tokensAddedCallback = param3;
         this.timeoutCallback = param4;
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         this.remoteM.socketM.lobby_tokensRefresh();
         if(this.getTokens() != this.lastTokens)
         {
            this.cancel();
            if(!this.dismissed)
            {
               this.callbackCalled = true;
               this.tokensAddedCallback();
            }
         }
      }
      
      private function completeHandler(param1:TimerEvent) : void
      {
         if(!this.dismissed && !this.callbackCalled)
         {
            this.timeoutCallback();
         }
      }
      
      public function cancel() : *
      {
         this.myTimer.stop();
      }
      
      public function dismiss() : *
      {
         this.dismissed = true;
      }
   }
}

