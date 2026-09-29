package net.tacticsoft.remoting.events
{
   import flash.events.ErrorEvent;
   
   public class FaultEvent extends ErrorEvent
   {
      
      public static const FAULT:String = "fault";
      
      public var fault:Object;
      
      public function FaultEvent(param1:Object, param2:Boolean = false, param3:Boolean = false)
      {
         super(FaultEvent.FAULT,param2,param3);
         this.fault = param1;
      }
   }
}

