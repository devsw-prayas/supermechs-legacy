package skein.rest.cache.impl
{
   import flash.net.URLRequest;
   import skein.core.skein_internal;
   import skein.rest.cache.CacheClient;
   import skein.rest.cache.CacheStorage;
   import skein.rest.cache.CacheStorageRegistry;
   import skein.rest.cache.response.Head;
   import skein.rest.cache.response.Headers;
   import skein.rest.cache.response.Response;
   
   use namespace skein_internal;
   
   public class DefaultCacheClient implements CacheClient
   {
      
      private var ignoringParams:Array = [];
      
      public function DefaultCacheClient()
      {
         super();
      }
      
      skein_internal function setIgnoreParams(param1:Array) : void
      {
         ignoringParams = param1;
      }
      
      public function head(param1:URLRequest) : Head
      {
         var _loc4_:String = null;
         var _loc2_:* = null;
         var _loc3_:CacheStorage = CacheStorageRegistry.storage();
         if(_loc3_ != null)
         {
            _loc4_ = retrieveURL(param1);
            return _loc3_.head(_loc4_);
         }
         return null;
      }
      
      public function live(param1:URLRequest) : Boolean
      {
         var _loc5_:String = null;
         var _loc2_:Head = null;
         var _loc3_:Date = null;
         var _loc4_:CacheStorage = CacheStorageRegistry.storage();
         if(_loc4_ != null)
         {
            _loc5_ = retrieveURL(param1);
            _loc2_ = _loc4_.head(_loc5_);
            if(_loc2_ != null && _loc2_.headers != null)
            {
               if(_loc2_.headers.cacheControl)
               {
                  if(_loc2_.headers.cacheControl.noCache)
                  {
                     return false;
                  }
               }
               if(_loc2_.headers.expires)
               {
                  _loc3_ = new Date();
                  if(_loc2_.headers.expires.date.time > _loc3_.time)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function find(param1:URLRequest, param2:Function) : void
      {
         var _loc4_:String = null;
         var _loc3_:CacheStorage = CacheStorageRegistry.storage();
         if(_loc3_ != null)
         {
            _loc4_ = retrieveURL(param1);
            _loc3_.find(_loc4_,param2);
         }
         else
         {
            param2(null);
         }
      }
      
      public function keep(param1:URLRequest, param2:Object, param3:Array, param4:Function = null) : Boolean
      {
         var _loc5_:Head = null;
         var _loc7_:String = null;
         var _loc6_:CacheStorage = CacheStorageRegistry.storage();
         if(_loc6_ != null)
         {
            _loc5_ = new Head();
            _loc5_.headers = Headers.valueOf(param3);
            if(_loc5_.headers.cacheControl)
            {
               if(_loc5_.headers.cacheControl.noStore)
               {
                  if(param4 != null)
                  {
                     param4(null);
                  }
                  return false;
               }
            }
            _loc7_ = retrieveURL(param1);
            return _loc6_.keep(_loc7_,new Response(_loc5_,param2),param4);
         }
         if(param4 != null)
         {
            param4(null);
         }
         return false;
      }
      
      public function drop(param1:URLRequest) : void
      {
         var _loc3_:String = null;
         var _loc2_:CacheStorage = CacheStorageRegistry.storage();
         if(_loc2_ != null)
         {
            _loc3_ = retrieveURL(param1);
            _loc2_.drop(_loc3_);
         }
      }
      
      public function purge() : void
      {
         var _loc1_:CacheStorage = CacheStorageRegistry.storage();
         if(_loc1_ != null)
         {
            _loc1_.purge();
         }
      }
      
      private function retrieveURL(param1:URLRequest) : String
      {
         var _loc5_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:String = param1.url;
         if(ignoringParams != null && ignoringParams.length > 0 && _loc6_.indexOf("?") != -1)
         {
            _loc5_ = _loc6_.split("?");
            _loc2_ = _loc5_[1].split("&");
            _loc3_ = [];
            _loc4_ = 0;
            _loc7_ = int(_loc2_ != null ? _loc2_.length : 0);
            while(_loc4_ < _loc7_)
            {
               if(ignoringParams.indexOf(_loc2_[_loc4_].split("=")[0]) == -1)
               {
                  _loc3_.push(_loc2_[_loc4_]);
               }
               _loc4_++;
            }
            if(_loc3_.length > 0)
            {
               return _loc5_[0] + "?" + _loc3_.concat("&");
            }
            return _loc5_[0];
         }
         return _loc6_;
      }
   }
}

