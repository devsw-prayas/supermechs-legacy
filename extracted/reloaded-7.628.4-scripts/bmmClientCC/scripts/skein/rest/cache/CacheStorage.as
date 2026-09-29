package skein.rest.cache
{
   import skein.rest.cache.response.Head;
   import skein.rest.cache.response.Response;
   
   public interface CacheStorage
   {
      
      function head(param1:String) : Head;
      
      function find(param1:String, param2:Function) : void;
      
      function keep(param1:String, param2:Response, param3:Function = null) : Boolean;
      
      function purge() : void;
      
      function drop(param1:String) : void;
   }
}

