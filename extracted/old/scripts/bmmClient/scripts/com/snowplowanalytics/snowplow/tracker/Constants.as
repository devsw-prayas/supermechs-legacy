package com.snowplowanalytics.snowplow.tracker
{
   public class Constants
   {
      
      public static const PROTOCOL_VENDOR:String = "com.snowplowanalytics.snowplow";
      
      public static const PROTOCOL_VERSION:String = "tp2";
      
      public static const SCHEMA_PAYLOAD_DATA:String = "iglu:com.snowplowanalytics.snowplow/payload_data/jsonschema/1-0-0";
      
      public static const SCHEMA_CONTEXTS:String = "iglu:com.snowplowanalytics.snowplow/contexts/jsonschema/1-0-0";
      
      public static const SCHEMA_UNSTRUCT_EVENT:String = "iglu:com.snowplowanalytics.snowplow/unstruct_event/jsonschema/1-0-0";
      
      public static const SCHEMA_SCREEN_VIEW:String = "iglu:com.snowplowanalytics.snowplow/screen_view/jsonschema/1-0-0";
      
      public static const SCHEMA_FLASH:String = "iglu:com.snowplowanalytics.snowplow/flash_context/jsonschema/1-0-0";
      
      public static const EVENT_PAGE_VIEW:String = "pv";
      
      public static const EVENT_STRUCTURED:String = "se";
      
      public static const EVENT_UNSTRUCTURED:String = "ue";
      
      public static const EVENT_ECOMM:String = "tr";
      
      public static const EVENT_ECOMM_ITEM:String = "ti";
      
      public function Constants()
      {
         super();
      }
   }
}

