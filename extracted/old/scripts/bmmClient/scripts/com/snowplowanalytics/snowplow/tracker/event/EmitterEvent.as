package com.snowplowanalytics.snowplow.tracker.event
{
   import flash.events.Event;
   
   public class EmitterEvent extends Event
   {
      
      public static const SUCCESS:String = "EMITTER_SUCCESS";
      
      public static const FAILURE:String = "EMITTER_FAILURE";
      
      public var errorInfo:String;
      
      public var successCount:Number;
      
      public var unsentPayloads:Array;
      
      public function EmitterEvent(param1:String, param2:Number = NaN, param3:Array = null, param4:String = null, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.successCount = param2;
         this.unsentPayloads = param3;
         this.errorInfo = param4;
      }
   }
}

