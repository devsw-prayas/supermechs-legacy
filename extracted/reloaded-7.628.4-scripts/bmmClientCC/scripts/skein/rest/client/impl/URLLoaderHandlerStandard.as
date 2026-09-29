package skein.rest.client.impl
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.utils.ByteArray;
   
   public class URLLoaderHandlerStandard extends HandlerAbstract implements URLLoaderHandler
   {
      
      private var _loader:URLLoader;
      
      public function URLLoaderHandlerStandard(param1:DefaultRestClient)
      {
         super(param1);
      }
      
      public function handle(param1:URLLoader) : void
      {
         _loader = param1;
         _loader.addEventListener("complete",resultHandler);
         _loader.addEventListener("httpStatus",statusHandler);
         _loader.addEventListener("progress",progressHandler);
         _loader.addEventListener("ioError",errorHandler);
         _loader.addEventListener("securityError",errorHandler);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _loader.removeEventListener("complete",resultHandler);
         _loader.removeEventListener("httpStatus",statusHandler);
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
         if(_loader.data is ByteArray && ByteArray(_loader.data).length == 0)
         {
            error(new Error(param1.text,param1.errorID));
         }
         else
         {
            error(_loader.data);
         }
      }
      
      protected function statusHandler(param1:HTTPStatusEvent) : void
      {
         status(param1.status);
      }
      
      protected function progressHandler(param1:ProgressEvent) : void
      {
         progress(param1.bytesLoaded,param1.bytesTotal);
      }
   }
}

