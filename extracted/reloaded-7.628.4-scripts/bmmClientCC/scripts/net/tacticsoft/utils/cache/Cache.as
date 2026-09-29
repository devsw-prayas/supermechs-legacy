package net.tacticsoft.utils.cache
{
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class Cache implements ICacheStore
   {
      
      private var cache:Dictionary;
      
      private var purgeAllInterval:int;
      
      public function Cache(param1:int = -1)
      {
         super();
         if(param1 > -1)
         {
            param1 = int(setInterval(this.purgeAll,param1));
         }
         this.cache = new Dictionary(true);
      }
      
      public function purgeAll() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.cache)
         {
            this.cache[_loc1_].destroy();
         }
         this.cache = new Dictionary(true);
      }
      
      public function dispose() : void
      {
         this.purgeAll();
         this.cache = null;
      }
      
      public function clearPurgeAllInterval() : void
      {
         clearInterval(this.purgeAllInterval);
      }
      
      public function setPurgeAllInterval(param1:Number) : void
      {
         clearInterval(this.purgeAllInterval);
         setInterval(this.purgeAll,param1);
      }
      
      public function purgeItem(param1:*) : void
      {
         if(!this.cache[param1])
         {
            return;
         }
         if(this.cache[param1])
         {
            delete this.cache[param1];
            this.cache[param1] = null;
         }
      }
      
      public function cacheObject(param1:*, param2:*, param3:int = -1, param4:Boolean = false) : void
      {
         var _loc5_:CacheItem = null;
         if(!param1)
         {
            throw new ArgumentError("Key cannot be null");
         }
         if(!param2)
         {
            throw new ArgumentError("The object to store cannot be null");
         }
         if(!this.cache[param1] || param4)
         {
            _loc5_ = new CacheItem(param1,param2,this.purgeItem,param3);
            this.cache[param1] = _loc5_;
         }
      }
      
      public function isCached(param1:*) : Boolean
      {
         if(!this.cache[param1])
         {
            return false;
         }
         return true;
      }
      
      public function getCachedObject(param1:*) : *
      {
         var _loc2_:CacheItem = null;
         if(!this.cache[param1])
         {
            throw new Error("No cached item existed for " + param1.toString() + " use the isCached() function before blindly calling getCachedItem");
         }
         if(this.cache[param1])
         {
            _loc2_ = this.cache[param1] as CacheItem;
            return _loc2_.object;
         }
      }
   }
}

