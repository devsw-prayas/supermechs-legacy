package net.tacticsoft.remoting.events
{
   import flash.events.Event;
   
   public class TimeoutEvent extends Event
   {
      
      public static const TIMEOUT:String = "TimeoutEvent_timeout";
      
      public var callEvent:CallEvent;
      
      public function TimeoutEvent(param1:CallEvent, param2:Boolean = false, param3:Boolean = false)
      {
         this.callEvent = param1;
         super(TimeoutEvent.TIMEOUT,param2,param3);
      }
   }
}

