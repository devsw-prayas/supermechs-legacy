package skein.rest.client.impl.extras
{
   import flash.events.HTTPStatusEvent;
   import skein.rest.client.extras.Uploader;
   import skein.rest.client.impl.DefaultRestClient;
   import skein.rest.client.impl.HandlerAbstract;
   
   public class UploaderHandler extends HandlerAbstract
   {
      
      private var _uploader:Uploader;
      
      public function UploaderHandler(param1:DefaultRestClient)
      {
         super(param1);
      }
      
      public function handle(param1:Uploader) : void
      {
         _uploader = param1;
         _uploader.completeCallback(completeHandler);
         _uploader.responseCallback(responseHandler);
         _uploader.statusCallback(statusHandler);
         _uploader.errorCallback(errorHandler);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _uploader.completeCallback(null);
         _uploader.statusCallback(null);
         _uploader.responseCallback(null);
         _uploader.errorCallback(null);
         _uploader = null;
      }
      
      private function statusHandler(param1:Object) : void
      {
         if(param1 is HTTPStatusEvent)
         {
            status(HTTPStatusEvent(param1).status);
         }
      }
      
      private function responseHandler(param1:Object) : void
      {
         if(param1 is HTTPStatusEvent)
         {
            headers(HTTPStatusEvent(param1).responseHeaders);
         }
      }
      
      private function completeHandler(param1:Object = null) : void
      {
         if(responseCode >= 200 && responseCode < 300)
         {
            result(param1);
         }
         else
         {
            error(param1);
         }
      }
      
      private function errorHandler(param1:Object = null) : void
      {
         error(param1);
      }
   }
}

