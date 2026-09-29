package skein.rest.client.impl.extras
{
   import skein.rest.client.extras.Downloader;
   import skein.rest.client.impl.DefaultRestClient;
   import skein.rest.client.impl.HandlerAbstract;
   
   public class DownloaderHandler extends HandlerAbstract
   {
      
      private var _downloader:Downloader;
      
      public function DownloaderHandler(param1:DefaultRestClient)
      {
         super(param1);
      }
      
      public function handle(param1:Downloader) : void
      {
         _downloader = param1;
         _downloader.completeCallback(resultHandler);
         _downloader.errorCallback(errorHandler);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _downloader.completeCallback(null);
         _downloader.errorCallback(null);
         _downloader = null;
      }
      
      private function resultHandler(param1:Object = null) : void
      {
         result(param1);
      }
      
      private function errorHandler(param1:Object = null) : void
      {
         error(param1);
      }
   }
}

