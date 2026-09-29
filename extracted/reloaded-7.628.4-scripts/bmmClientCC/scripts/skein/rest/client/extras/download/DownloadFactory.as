package skein.rest.client.extras.download
{
   import skein.rest.client.impl.extras.download.FileStreamAsyncDownloadWriter;
   import skein.rest.client.impl.extras.download.URLStreamDownloadReader;
   
   public class DownloadFactory
   {
      
      public function DownloadFactory()
      {
         super();
      }
      
      public static function getWriter(param1:Object) : DownloadWriter
      {
         if(FileStreamAsyncDownloadWriter.isSupported())
         {
            return new FileStreamAsyncDownloadWriter();
         }
         return null;
      }
      
      public static function getReceiver(param1:Object) : DownloadReader
      {
         return new URLStreamDownloadReader();
      }
   }
}

