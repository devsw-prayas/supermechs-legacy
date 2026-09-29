package net.battlegate.events
{
   import flash.events.Event;
   
   public dynamic class BGSocketEvent extends Event
   {
      
      public static var DATA_RECEIVED:String = "BGSocketEvent_dataReceived";
      
      public static var CONNECTING:String = "BGSocketEvent_connecting";
      
      public static var CONNECTED:String = "BGSocketEvent_connected";
      
      public static var CLOSED:String = "BGSocketEvent_closed";
      
      public static var SECURITY_ERROR:String = "BGSocketEvent_securityError";
      
      public static var IO_ERROR:String = "BGSocketEvent_ioError";
      
      public static var DATA_AVAILABLE:String = "BGSocketEvent_dataAvailable";
      
      public var data:Object;
      
      public function BGSocketEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

