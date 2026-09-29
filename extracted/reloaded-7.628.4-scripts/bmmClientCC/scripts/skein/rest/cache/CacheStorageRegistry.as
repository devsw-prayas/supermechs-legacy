package skein.rest.cache
{
   import flash.net.registerClassAlias;
   import skein.rest.cache.response.CacheControl;
   import skein.rest.cache.response.ETag;
   import skein.rest.cache.response.Expires;
   import skein.rest.cache.response.Head;
   import skein.rest.cache.response.Headers;
   import skein.rest.cache.response.Response;
   import skein.rest.core.Config;
   
   public class CacheStorageRegistry
   {
      
      private static var _storage:CacheStorage;
      
      registerClassAlias("skein.rest.cache.response.Head",Head);
      registerClassAlias("skein.rest.cache.response.Response",Response);
      registerClassAlias("skein.rest.cache.response.Headers",Headers);
      registerClassAlias("skein.rest.cache.response.ETag",ETag);
      registerClassAlias("skein.rest.cache.response.Expires",Expires);
      registerClassAlias("skein.rest.cache.response.CacheControl",CacheControl);
      
      public function CacheStorageRegistry()
      {
         super();
      }
      
      public static function storage() : CacheStorage
      {
         var _loc1_:Class = null;
         if(_storage == null)
         {
            _loc1_ = Config.sharedInstance().getImplementation(CacheStorage);
            if(_loc1_ != null)
            {
               _storage = new _loc1_();
            }
         }
         return _storage;
      }
   }
}

