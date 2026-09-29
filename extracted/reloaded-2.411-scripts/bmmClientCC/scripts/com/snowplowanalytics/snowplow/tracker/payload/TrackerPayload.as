package com.snowplowanalytics.snowplow.tracker.payload
{
   import com.adobe.serialization.json.JSON;
   import com.snowplowanalytics.snowplow.tracker.Util;
   
   public class TrackerPayload implements IPayload
   {
      
      private var objectNode:Object = {};
      
      public function TrackerPayload()
      {
         super();
      }
      
      public function add(param1:String, param2:*) : void
      {
         if(Util.isNullOrEmpty(param2))
         {
            trace("kv-value is empty. Returning out without adding key..");
            return;
         }
         objectNode[param1] = param2;
      }
      
      public function getMap() : Object
      {
         return objectNode;
      }
      
      public function addMap(param1:Object, param2:Boolean = false, param3:String = null, param4:String = null) : void
      {
         var key:String = null;
         var mapString:String = null;
         var map:Object = param1;
         var base64_encoded:Boolean = param2;
         var type_encoded:String = param3;
         var type_no_encoded:String = param4;
         if(Util.isNullOrEmpty(type_encoded) && Util.isNullOrEmpty(type_no_encoded))
         {
            if(map == null)
            {
               trace("Map passed in is null. Returning without adding map..");
               return;
            }
            for(key in map)
            {
               add(key,map[key]);
            }
         }
         else
         {
            if(map == null)
            {
               trace("Map passed in is null. Returning nothing..");
               return;
            }
            try
            {
               mapString = com.adobe.serialization.json.JSON.encode(map);
            }
            catch(e:Error)
            {
               trace(e.getStackTrace());
               return;
            }
            if(base64_encoded)
            {
               objectNode[type_encoded] = Util.base64Encode(mapString);
            }
            else
            {
               add(type_no_encoded,mapString);
            }
         }
      }
      
      public function toString() : String
      {
         return com.adobe.serialization.json.JSON.encode(objectNode);
      }
   }
}

