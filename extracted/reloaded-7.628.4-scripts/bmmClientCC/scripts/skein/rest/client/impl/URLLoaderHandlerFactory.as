package skein.rest.client.impl
{
   import skein.rest.core.HeaderHandler;
   
   public class URLLoaderHandlerFactory
   {
      
      public function URLLoaderHandlerFactory()
      {
         super();
      }
      
      public static function create(param1:DefaultRestClient) : URLLoaderHandler
      {
         if(param1.hasHeaderCallbacks() || HeaderHandler.hasHandlers())
         {
            if("httpResponseStatus")
            {
               return new URLLoaderHandlerExtended(param1);
            }
         }
         return new URLLoaderHandlerStandard(param1);
      }
   }
}

