package net.battleMechsMulti.events
{
   import flash.events.Event;
   
   public dynamic class BMDynamicEvent extends Event
   {
      
      public static const GENERIC_EVENT:String = "BMDynamicEvent_genericEvent";
      
      public function BMDynamicEvent(param1:String = "BMDynamicEvent_genericEvent", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

