package net.tacticsoft.utils.cache
{
   import net.tacticsoft.core.IDisposable;
   
   public interface ICacheStore extends IDisposable
   {
      
      function purgeAll() : void;
      
      function purgeItem(param1:*) : void;
      
      function cacheObject(param1:*, param2:*, param3:int = -1, param4:Boolean = false) : void;
      
      function isCached(param1:*) : Boolean;
      
      function getCachedObject(param1:*) : *;
   }
}

