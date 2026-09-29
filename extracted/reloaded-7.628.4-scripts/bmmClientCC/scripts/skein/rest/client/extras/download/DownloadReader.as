package skein.rest.client.extras.download
{
   import flash.utils.ByteArray;
   
   public interface DownloadReader
   {
      
      function start(param1:Object) : void;
      
      function close() : void;
      
      function getBytes() : ByteArray;
      
      function progressCallback(param1:Function) : void;
      
      function completeCallback(param1:Function) : void;
      
      function errorCallback(param1:Function) : void;
   }
}

