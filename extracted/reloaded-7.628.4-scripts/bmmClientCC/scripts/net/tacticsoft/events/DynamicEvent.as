package net.tacticsoft.events
{
   import flash.events.Event;
   
   public dynamic class DynamicEvent extends Event
   {
      
      public function DynamicEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

