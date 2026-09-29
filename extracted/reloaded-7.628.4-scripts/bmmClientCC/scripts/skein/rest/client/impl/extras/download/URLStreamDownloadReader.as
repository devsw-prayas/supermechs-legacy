package skein.rest.client.impl.extras.download
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import skein.rest.client.extras.download.DownloadReader;
   
   public class URLStreamDownloadReader implements DownloadReader
   {
      
      private var stream:URLStream;
      
      protected var _progressCallback:Function;
      
      protected var _completeCallback:Function;
      
      protected var _errorCallback:Function;
      
      public function URLStreamDownloadReader()
      {
         super();
      }
      
      public function progressCallback(param1:Function) : void
      {
         _progressCallback = param1;
      }
      
      public function completeCallback(param1:Function) : void
      {
         _completeCallback = param1;
      }
      
      public function errorCallback(param1:Function) : void
      {
         _errorCallback = param1;
      }
      
      public function start(param1:Object) : void
      {
         var _loc2_:URLRequest = null;
         if(stream == null)
         {
            stream = new URLStream();
            stream.addEventListener("open",openHandler);
            stream.addEventListener("complete",completeHandler);
            stream.addEventListener("ioError",errorHandler);
            stream.addEventListener("securityError",errorHandler);
            stream.addEventListener("progress",progressHandler);
            _loc2_ = param1 as URLRequest;
            stream.load(_loc2_);
         }
      }
      
      public function close() : void
      {
         if(stream != null)
         {
            stream.close();
            stream.removeEventListener("open",openHandler);
            stream.removeEventListener("complete",completeHandler);
            stream.removeEventListener("ioError",errorHandler);
            stream.removeEventListener("securityError",errorHandler);
            stream.removeEventListener("progress",progressHandler);
            stream = null;
         }
      }
      
      public function getBytes() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         if(stream != null)
         {
            stream.readBytes(_loc1_);
         }
         return _loc1_;
      }
      
      private function openHandler(param1:Event) : void
      {
      }
      
      private function errorHandler(param1:ErrorEvent) : void
      {
         _errorCallback(new Error(param1.text,param1.errorID));
      }
      
      private function completeHandler(param1:Event) : void
      {
         _completeCallback();
      }
      
      private function progressHandler(param1:ProgressEvent) : void
      {
         _progressCallback();
      }
   }
}

