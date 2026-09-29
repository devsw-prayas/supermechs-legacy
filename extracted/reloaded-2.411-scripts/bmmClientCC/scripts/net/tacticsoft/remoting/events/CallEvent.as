package net.tacticsoft.remoting.events
{
   import flash.events.Event;
   import net.tacticsoft.remoting.RemotingConnection;
   import net.tacticsoft.remoting.RemotingService;
   
   public class CallEvent extends Event
   {
      
      public static const REQUEST_SENT:String = "requestSent";
      
      public static const RESULT:String = "result";
      
      public static const FAULT:String = "fault";
      
      public static const RETRY:String = "retry";
      
      public static const TIMEOUT:String = "timedout";
      
      public static const LIMITER_STOPPED_CALL:String = "limiterStoppedCall";
      
      public static const SERVICE_HALTED:String = "serviceHalted";
      
      public static const SERVICE_AUTHENTICATE_SUCCESS:String = "authenticateSuccess";
      
      public static const SERVICE_AUTHENTICATE_ERROR:String = "authenticateError";
      
      public static const SERVICE_LOGOUT_SUCCESS:String = "logoutSuccess";
      
      public static const SERVICE_LOGOUT_ERROR:String = "logoutError";
      
      public var connection:RemotingConnection;
      
      public var service:RemotingService;
      
      public var method:String;
      
      public var args:Array;
      
      public var rawData:*;
      
      public var resultCallback:Function;
      
      public var faultCallback:Function;
      
      public function CallEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

