package skein.rest.client.extras.upload
{
   import skein.rest.core.Config;
   
   public class UploadFactory
   {
      
      public function UploadFactory()
      {
         super();
      }
      
      public static function getUploadWriter() : UploadWriter
      {
         var _loc1_:Class = Config.sharedInstance().getImplementation(UploadWriter);
         return _loc1_ != null ? new _loc1_() : null;
      }
   }
}

