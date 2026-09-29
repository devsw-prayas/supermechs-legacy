package skein.rest.core
{
   import skein.core.skein_internal;
   import skein.rest.client.RestClient;
   
   use namespace skein_internal;
   
   public class RestClientRegistry
   {
      
      private static var repository:Array = [];
      
      public function RestClientRegistry()
      {
         super();
      }
      
      public static function get() : RestClient
      {
         var _loc1_:Class = null;
         var _loc2_:RestClient = repository.shift();
         if(_loc2_ == null)
         {
            _loc1_ = Config.sharedInstance().getImplementation(RestClient);
            _loc2_ = new _loc1_();
         }
         return _loc2_;
      }
      
      skein_internal static function clear() : void
      {
         repository.length = 0;
      }
      
      skein_internal static function reuse(param1:RestClient = null) : void
      {
         if(repository.length < 2)
         {
            repository.push(param1);
         }
      }
   }
}

