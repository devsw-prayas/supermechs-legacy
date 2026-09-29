package skein.rest.cache
{
   import flash.net.URLRequest;
   import skein.rest.cache.response.Head;
   
   public interface CacheClient
   {
      
      function head(param1:URLRequest) : Head;
      
      function live(param1:URLRequest) : Boolean;
      
      function find(param1:URLRequest, param2:Function) : void;
      
      function keep(param1:URLRequest, param2:Object, param3:Array, param4:Function = null) : Boolean;
      
      function drop(param1:URLRequest) : void;
      
      function purge() : void;
   }
}

