package com.snowplowanalytics.snowplow.tracker.payload
{
   public interface IPayload
   {
      
      function add(param1:String, param2:*) : void;
      
      function addMap(param1:Object, param2:Boolean = false, param3:String = null, param4:String = null) : void;
      
      function toString() : String;
      
      function getMap() : Object;
   }
}

