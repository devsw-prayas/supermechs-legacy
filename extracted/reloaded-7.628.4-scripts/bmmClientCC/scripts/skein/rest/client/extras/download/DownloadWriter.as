package skein.rest.client.extras.download
{
   import flash.utils.ByteArray;
   
   public interface DownloadWriter
   {
      
      function start(param1:Object) : void;
      
      function close() : void;
      
      function write(param1:ByteArray, param2:Boolean = false) : void;
      
      function errorCallback(param1:Function) : void;
      
      function completeCallback(param1:Function) : void;
   }
}

