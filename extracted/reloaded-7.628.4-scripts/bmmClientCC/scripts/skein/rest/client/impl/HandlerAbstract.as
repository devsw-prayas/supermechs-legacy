package skein.rest.client.impl
{
   import flash.net.URLRequestHeader;
   import flash.utils.ByteArray;
   import skein.core.skein_internal;
   import skein.logger.Log;
   import skein.rest.core.HeaderHandler;
   import skein.rest.errors.DataProcessingError;
   import skein.rest.errors.UnknownServerError;
   import skein.utils.StringUtil;
   
   use namespace skein_internal;
   
   public class HandlerAbstract
   {
      
      protected var client:DefaultRestClient;
      
      protected var responseCode:int;
      
      protected var attempts:uint;
      
      protected var responseHeaders:Array;
      
      public function HandlerAbstract(param1:DefaultRestClient)
      {
         super();
         this.client = param1;
      }
      
      public function isSuccessResponseCode(param1:int) : Boolean
      {
         if(param1 <= 0)
         {
            return true;
         }
         return responseCode >= 200 && responseCode < 300;
      }
      
      protected function dispose() : void
      {
         client.free();
      }
      
      protected function status(param1:int) : void
      {
         responseCode = param1;
         if(client.statusCallback != null)
         {
            client.statusCallback(param1);
         }
      }
      
      protected function headers(param1:Array) : void
      {
         var _loc3_:Function = null;
         responseHeaders = param1;
         for each(var _loc2_:URLRequestHeader in responseHeaders)
         {
            var _loc4_:String = _loc2_.name.toLowerCase();
            if("content-type" === _loc4_)
            {
               client.setResponseContentType(_loc2_.value);
            }
            _loc3_ = client.headerCallbacks[_loc2_.name] || HeaderHandler.forName(_loc2_.name);
            if(_loc3_ != null)
            {
               _loc3_.apply(null,[_loc2_]);
            }
         }
      }
      
      protected function progress(param1:Number, param2:Number) : void
      {
         client.handleProgress(false,param1,param2);
      }
      
      protected function result(param1:Object) : void
      {
         var isDataSerializedSuccessfully:Boolean;
         var data:Object = param1;
         Log.i("skein-rest",URLLoadersQueue.name(client.loader) + " " + client.request.method.toUpperCase() + " " + client.request.url + " " + responseCode + " <- " + (data is ByteArray ? "%BINARY_DATA%" : data));
         isDataSerializedSuccessfully = false;
         try
         {
            client.decodeResult(data,function(param1:Object):void
            {
               isDataSerializedSuccessfully = true;
               if(param1 is Error)
               {
                  handleError(param1);
               }
               else
               {
                  handleResult(data,param1);
               }
            });
         }
         catch(error:Error)
         {
            if(isDataSerializedSuccessfully)
            {
               Log.e("skein-rest","Error during handling result: " + error + ". Please fix this issue as it may cause unexpected behaviour.");
            }
            else
            {
               trace(error);
               handleError(new DataProcessingError("An incorrect or invalid data was received."));
            }
         }
      }
      
      protected function handleResult(param1:Object, param2:Object) : void
      {
         var rawData:Object = param1;
         var decodedValue:Object = param2;
         if(client.beforeResultInterceptor != null)
         {
            client.beforeResultInterceptor(rawData);
         }
         client.handleResult(decodedValue,responseCode,responseHeaders,function():void
         {
            if(Boolean(client.afterResultInterceptor))
            {
               client.afterResultInterceptor(rawData);
            }
            dispose();
         });
      }
      
      protected function error(param1:Object) : void
      {
         var isErrorSerializedSuccessfully:Boolean;
         var data:Object = param1;
         Log.e("skein-rest",StringUtil.substitute("{0} {1} {2}{3} <- {4} {5}",URLLoadersQueue.name(client.loader),client.request.method.toUpperCase(),client.request.url,client.request.data ? " -> " + client.request.data : "",responseCode,data is ByteArray ? "%BINARY_DATA%" : data));
         isErrorSerializedSuccessfully = false;
         try
         {
            client.decodeError(data,responseCode,function(param1:Object):void
            {
               isErrorSerializedSuccessfully = true;
               handleError(param1);
            });
         }
         catch(error:Error)
         {
            if(isErrorSerializedSuccessfully)
            {
               Log.e("skein-rest","Error during handling error: " + error + ". Please fix this issue as it may cause unexpected behaviour.");
            }
            else
            {
               handleError(new UnknownServerError("An error message received from server could not be parsed."));
            }
         }
      }
      
      protected function handleError(param1:Object) : void
      {
         if(client.errorInterceptor != null)
         {
            interceptError(param1);
         }
         else if(client.errorCallback != null)
         {
            proceedError(param1);
         }
         else
         {
            dispose();
         }
      }
      
      private function interceptError(param1:Object) : void
      {
         var info:Object = param1;
         var proceedErrorCallback:Function = function():void
         {
            proceedError(info);
         };
         var retryRequestCallback:Function = function():void
         {
            retryRequest(info);
         };
         if(client.errorInterceptor.length == 2)
         {
            client.errorInterceptor(info,responseCode)(attempts,proceedErrorCallback,retryRequestCallback);
         }
         else
         {
            client.errorInterceptor(info)(attempts,proceedErrorCallback,retryRequestCallback);
         }
      }
      
      private function retryRequest(param1:Object) : void
      {
         if(client.retry())
         {
            attempts = attempts + 1;
         }
         else
         {
            proceedError(param1);
         }
      }
      
      private function proceedError(param1:Object) : void
      {
         client.handleError(param1,responseCode);
         dispose();
      }
   }
}

