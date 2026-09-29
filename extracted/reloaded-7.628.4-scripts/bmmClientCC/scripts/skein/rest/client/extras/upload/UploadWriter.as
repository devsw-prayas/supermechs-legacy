package skein.rest.client.extras.upload
{
   public interface UploadWriter
   {
      
      function close() : void;
      
      function load(param1:Object, param2:Object, param3:String, param4:Object = null) : void;
      
      function errorCallback(param1:Function) : void;
      
      function completeCallback(param1:Function) : void;
      
      function responseCallback(param1:Function) : void;
      
      function statusCallback(param1:Function) : void;
   }
}

