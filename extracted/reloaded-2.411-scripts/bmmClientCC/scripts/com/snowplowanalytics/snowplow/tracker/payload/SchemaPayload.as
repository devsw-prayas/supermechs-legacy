package com.snowplowanalytics.snowplow.tracker.payload
{
   import com.adobe.serialization.json.JSON;
   import com.snowplowanalytics.snowplow.tracker.Parameter;
   import com.snowplowanalytics.snowplow.tracker.Util;
   import com.snowplowanalytics.snowplow.tracker.util.Preconditions;
   
   public class SchemaPayload implements IPayload
   {
      
      private var objectNode:Object = {};
      
      public function SchemaPayload(param1:IPayload = null)
      {
         super();
         if(param1 != null)
         {
            objectNode[Parameter.DATA] = param1.getMap();
         }
      }
      
      public function setSchema(param1:String) : SchemaPayload
      {
         Preconditions.checkNotNull(param1,"schema cannot be null");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param1),"schema cannot be empty.");
         objectNode[Parameter.SCHEMA] = param1;
         return this;
      }
      
      public function setData(param1:*) : SchemaPayload
      {
         if(param1 is IPayload)
         {
            param1 = param1.getMap();
         }
         objectNode[Parameter.DATA] = param1;
         return this;
      }
      
      public function add(param1:String, param2:*) : void
      {
      }
      
      public function toString() : String
      {
         return com.adobe.serialization.json.JSON.encode(objectNode);
      }
      
      public function getMap() : Object
      {
         return objectNode;
      }
      
      public function addMap(param1:Object, param2:Boolean = false, param3:String = null, param4:String = null) : void
      {
      }
   }
}

