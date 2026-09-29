package skein.rest.client.extras
{
   import skein.rest.client.extras.upload.UploadFactory;
   import skein.rest.client.extras.upload.UploadWriter;
   
   public class Uploader
   {
      
      private var writer:UploadWriter;
      
      protected var _errorCallback:Function;
      
      protected var _completeCallback:Function;
      
      protected var _statusCallback:Function;
      
      protected var _responseCallback:Function;
      
      public function Uploader()
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
      
      public function statusCallback(param1:Function) : void
      {
         _statusCallback = param1;
      }
      
      public function responseCallback(param1:Function) : void
      {
         _responseCallback = param1;
      }
      
      public function upload(param1:Object, param2:Object, param3:String, param4:Object = null) : void
      {
         if(writer == null)
         {
            writer = UploadFactory.getUploadWriter();
            writer.completeCallback(writerCompleteCallback);
            writer.responseCallback(writerResponseCallback);
            writer.statusCallback(writerStatusCallback);
            writer.errorCallback(writerErrorCallback);
         }
         else
         {
            writer.close();
         }
         writer.load(param1,param2,param3,param4);
      }
      
      public function close() : void
      {
         if(writer != null)
         {
            writer.close();
            writer.completeCallback(null);
            writer.responseCallback(null);
            writer.statusCallback(null);
            writer.errorCallback(null);
            writer = null;
         }
      }
      
      private function writerErrorCallback(param1:Object) : void
      {
         _errorCallback(param1);
      }
      
      private function writerCompleteCallback(param1:Object) : void
      {
         _completeCallback(param1);
      }
      
      private function writerStatusCallback(param1:Object) : void
      {
         _statusCallback(param1);
      }
      
      private function writerResponseCallback(param1:Object) : void
      {
         _responseCallback(param1);
      }
   }
}

