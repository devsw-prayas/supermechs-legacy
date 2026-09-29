package skein.rest.client.impl.extras.download
{
   import flash.errors.IOError;
   import flash.events.IOErrorEvent;
   import flash.events.OutputProgressEvent;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import skein.rest.client.extras.download.DownloadWriter;
   
   public class FileStreamAsyncDownloadWriter implements DownloadWriter
   {
      
      protected static const File:Class = getDefinitionByName("flash.filesystem::File") as Class;
      
      protected static const FileMode:Class = getDefinitionByName("flash.filesystem::FileMode") as Class;
      
      protected static const FileStream:Class = getDefinitionByName("flash.filesystem::FileStream") as Class;
      
      private var file:Object;
      
      private var stream:Object;
      
      private var isLastPortionReceived:Boolean = false;
      
      protected var _errorCallback:Function;
      
      protected var _completeCallback:Function;
      
      public function FileStreamAsyncDownloadWriter()
      {
         super();
      }
      
      public static function isSupported() : Boolean
      {
         return File != null && FileStream != null;
      }
      
      public function errorCallback(param1:Function) : void
      {
         _errorCallback = param1;
      }
      
      public function completeCallback(param1:Function) : void
      {
         _completeCallback = param1;
      }
      
      public function start(param1:Object) : void
      {
         if(stream == null)
         {
            stream = new FileStream();
            stream.addEventListener("ioError",errorHandler);
            stream.addEventListener("outputProgress",outputProgressHandler);
            try
            {
               file = param1;
               stream.openAsync(file,FileMode.WRITE);
            }
            catch(error:Error)
            {
               _errorCallback(error);
            }
         }
      }
      
      public function close() : void
      {
         if(stream != null)
         {
            stream.close();
            stream.removeEventListener("ioError",errorHandler);
            stream.removeEventListener("outputProgress",outputProgressHandler);
            stream = null;
            file = null;
         }
         isLastPortionReceived = false;
      }
      
      public function write(param1:ByteArray, param2:Boolean = false) : void
      {
         if(!isLastPortionReceived)
         {
            isLastPortionReceived = param2;
         }
         try
         {
            stream.writeBytes(param1);
         }
         catch(error:Error)
         {
            _errorCallback(error);
         }
      }
      
      private function errorHandler(param1:IOErrorEvent) : void
      {
         _errorCallback(new IOError(param1.text,param1.errorID));
      }
      
      private function outputProgressHandler(param1:OutputProgressEvent) : void
      {
         if(param1.bytesPending == 0 && isLastPortionReceived)
         {
            _completeCallback(file);
         }
      }
   }
}

