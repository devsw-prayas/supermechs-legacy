package skein.rest.client.extras
{
   import flash.events.EventDispatcher;
   import skein.rest.client.extras.download.DownloadFactory;
   import skein.rest.client.extras.download.DownloadReader;
   import skein.rest.client.extras.download.DownloadWriter;
   
   public class Downloader extends EventDispatcher
   {
      
      private var writer:DownloadWriter;
      
      private var receiver:DownloadReader;
      
      protected var _errorCallback:Function;
      
      protected var _completeCallback:Function;
      
      public function Downloader()
      {
         super();
      }
      
      public function errorCallback(param1:Function) : void
      {
         _errorCallback = param1;
      }
      
      public function completeCallback(param1:Function) : void
      {
         _completeCallback = param1;
      }
      
      public function download(param1:Object, param2:Object) : void
      {
         writer = DownloadFactory.getWriter(param2);
         writer.errorCallback(writerErrorCallback);
         writer.completeCallback(writerCompleteCallback);
         writer.start(param2);
         receiver = DownloadFactory.getReceiver(param1);
         receiver.progressCallback(receiverProgressCallback);
         receiver.completeCallback(receiverCompleteCallback);
         receiver.errorCallback(receiverErrorCallback);
         receiver.start(param1);
      }
      
      protected function complete(param1:Object) : void
      {
         close();
         _completeCallback(param1);
      }
      
      protected function error(param1:Error) : void
      {
         close();
         _errorCallback(param1);
      }
      
      public function close() : void
      {
         if(writer != null)
         {
            writer.close();
            writer = null;
         }
         if(receiver != null)
         {
            receiver.close();
            receiver = null;
         }
      }
      
      private function writerErrorCallback(param1:Error) : void
      {
         this.error(param1);
      }
      
      private function writerCompleteCallback(param1:Object) : void
      {
         this.complete(param1);
      }
      
      private function receiverProgressCallback() : void
      {
         writer.write(receiver.getBytes());
      }
      
      private function receiverCompleteCallback() : void
      {
         writer.write(receiver.getBytes(),true);
      }
      
      private function receiverErrorCallback(param1:Error) : void
      {
         this.error(param1);
      }
   }
}

