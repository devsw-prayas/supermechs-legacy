package com.snowplowanalytics.snowplow.tracker.emitter
{
   import com.adobe.net.URI;
   import com.snowplowanalytics.snowplow.tracker.Constants;
   import com.snowplowanalytics.snowplow.tracker.Util;
   import com.snowplowanalytics.snowplow.tracker.event.EmitterEvent;
   import com.snowplowanalytics.snowplow.tracker.payload.IPayload;
   import com.snowplowanalytics.snowplow.tracker.payload.SchemaPayload;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLRequestMethod;
   
   public class Emitter extends EventDispatcher
   {
      
      protected var bufferSize:int = 1;
      
      protected var httpMethod:String = "GET";
      
      private var _uri:URI;
      
      private var _buffer:Array = [];
      
      public function Emitter(param1:String, param2:String = "GET")
      {
         super();
         if(param2 == URLRequestMethod.GET)
         {
            _uri = new URI("http://" + param1 + "/i");
         }
         else
         {
            _uri = new URI("http://" + param1 + "/" + Constants.PROTOCOL_VENDOR + "/" + Constants.PROTOCOL_VERSION);
         }
         this.httpMethod = param2;
      }
      
      public function setBufferSize(param1:int) : void
      {
         this.bufferSize = param1;
      }
      
      public function flushBuffer() : void
      {
         var successCount:int = 0;
         var totalCount:int = 0;
         var totalPayloads:int = 0;
         var unsentPayloads:Array = null;
         var getPayload:IPayload = null;
         var unsentPayload:Array = null;
         var postPayload:SchemaPayload = null;
         var eventMaps:Array = null;
         var payload:IPayload = null;
         if(_buffer.length == 0)
         {
            trace("Buffer is empty, exiting flush operation.");
            return;
         }
         if(httpMethod == URLRequestMethod.GET)
         {
            successCount = 0;
            totalCount = 0;
            totalPayloads = int(_buffer.length);
            unsentPayloads = [];
            for each(getPayload in _buffer)
            {
               sendGetData(getPayload,function onGetSuccess(param1:*):void
               {
                  ++successCount;
                  ++totalCount;
                  checkBufferComplete(successCount,totalCount,totalPayloads,unsentPayloads);
               },function onGetError():void
               {
                  ++totalCount;
                  unsentPayloads.push(payload);
                  checkBufferComplete(successCount,totalCount,totalPayloads,unsentPayloads);
               });
            }
         }
         else if(httpMethod == URLRequestMethod.POST)
         {
            unsentPayload = [];
            postPayload = new SchemaPayload();
            postPayload.setSchema(Constants.SCHEMA_PAYLOAD_DATA);
            eventMaps = [];
            for each(payload in _buffer)
            {
               eventMaps.push(payload.getMap());
            }
            postPayload.setData(eventMaps);
            sendPostData(postPayload,function onPostSuccess(param1:*):void
            {
               dispatchEvent(new EmitterEvent(EmitterEvent.SUCCESS,_buffer.length));
            },function onPostError(param1:Event):void
            {
               unsentPayload.push(postPayload);
               dispatchEvent(new EmitterEvent(EmitterEvent.FAILURE,0,unsentPayloads,param1.toString()));
            });
         }
         Util.clearArray(_buffer);
      }
      
      public function checkBufferComplete(param1:int, param2:int, param3:int, param4:Array) : void
      {
         if(param2 == param3)
         {
            if(param4.length == 0)
            {
               dispatchEvent(new EmitterEvent(EmitterEvent.SUCCESS,param1));
            }
            else
            {
               dispatchEvent(new EmitterEvent(EmitterEvent.FAILURE,param1,param4,"Not all items in buffer were sent"));
            }
         }
      }
      
      protected function sendGetData(param1:IPayload, param2:Function, param3:Function) : void
      {
         var _loc4_:Object = param1.getMap();
         _uri.setQueryByMap(_loc4_);
         Util.getResponse(_uri.toString(),param2,param3);
      }
      
      protected function sendPostData(param1:IPayload, param2:Function, param3:Function) : void
      {
         Util.getResponse(_uri.toString(),param2,param3,URLRequestMethod.POST,param1.toString());
      }
      
      public function addToBuffer(param1:IPayload) : void
      {
         _buffer.push(param1);
         if(_buffer.length == bufferSize)
         {
            flushBuffer();
         }
      }
   }
}

