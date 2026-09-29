package net.tacticsoft.utils.cache
{
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class CacheItem
   {
      
      private var purgeCallback:Function;
      
      public var timeout:int;
      
      public var object:*;
      
      public var cacheKey:String;
      
      public function CacheItem(param1:String, param2:*, param3:Function, param4:int = -1)
      {
         super();
         this.purgeCallback = param3;
         this.cacheKey = param1;
         this.timeout = param4;
         this.object = param2;
         if(param4 > -1)
         {
            setTimeout(this.purgeItem,param4);
         }
      }
      
      private function purgeItem() : void
      {
         this.purgeCallback(this.cacheKey);
      }
      
      public function destroy() : void
      {
         this.purgeCallback = null;
         this.cacheKey = null;
         clearTimeout(this.timeout);
         this.timeout = NaN;
         this.object = null;
      }
   }
}

