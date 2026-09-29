package net.tacticsoft.events
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class EventDispatcherProxy implements IEventDispatcher
   {
      
      private var ed:EventDispatcher;
      
      public function EventDispatcherProxy()
      {
         super();
         this.ed = new EventDispatcher(this);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.ed.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.ed.removeEventListener(param1,param2);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.ed.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.ed.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.ed.willTrigger(param1);
      }
   }
}

