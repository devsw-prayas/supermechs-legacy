package net.tacticsoft.remoting.events
{
   import flash.events.Event;
   
   public class ConnectionEvent extends Event
   {
      
      public static const CONNECTED:String = "connected";
      
      public static const DISCONNECT:String = "disconnect";
      
      public static const FAILED:String = "failed";
      
      public static const ERROR:String = "error";
      
      public static const SECURITY_ERROR:String = "securityError";
      
      public static const FORMAT_ERROR:String = "formatError";
      
      public var message:String;
      
      public function ConnectionEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

