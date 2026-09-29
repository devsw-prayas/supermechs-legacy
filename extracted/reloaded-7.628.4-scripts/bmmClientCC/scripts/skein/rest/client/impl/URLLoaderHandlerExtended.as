package skein.rest.client.impl
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   
   public class URLLoaderHandlerExtended extends HandlerAbstract implements URLLoaderHandler
   {
      
      private var _loader:URLLoader;
      
      public function URLLoaderHandlerExtended(param1:DefaultRestClient)
      {
         super(param1);
      }
      
      public function handle(param1:URLLoader) : void
      {
         _loader = param1;
         _loader.addEventListener("complete",resultHandler);
         _loader.addEventListener("httpStatus",statusHandler);
         _loader.addEventListener("httpResponseStatus",responseStatusHandler);
         _loader.addEventListener("progress",progressHandler);
         _loader.addEventListener("ioError",errorHandler);
         _loader.addEventListener("securityError",errorHandler);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _loader.removeEventListener("complete",resultHandler);
         _loader.removeEventListener("httpStatus",statusHandler);
         _loader.removeEventListener("httpResponseStatus",responseStatusHandler);
         _loader.removeEventListener("progress",progressHandler);
         _loader.removeEventListener("ioError",errorHandler);
         _loader.removeEventListener("securityError",errorHandler);
         _loader = null;
      }
      
      protected function resultHandler(param1:Event) : void
      {
         if(isSuccessResponseCode(responseCode))
         {
            result(_loader.data);
         }
         else
         {
            error(_loader.data);
         }
      }
      
      protected function errorHandler(param1:ErrorEvent) : void
      {
         error(_loader.data);
      }
      
      protected function statusHandler(param1:HTTPStatusEvent) : void
      {
         status(param1.status);
      }
      
      protected function responseStatusHandler(param1:HTTPStatusEvent) : void
      {
         headers(param1.responseHeaders);
      }
      
      protected function progressHandler(param1:ProgressEvent) : void
      {
         progress(param1.bytesLoaded,param1.bytesTotal);
      }
   }
}

