package skein.rest
{
   import skein.rest.client.RestClient;
   import skein.rest.core.RestClientRegistry;
   
   public function rest(param1:String, ... rest) : RestClient
   {
      var _loc3_:RestClient = RestClientRegistry.get();
      _loc3_.init(param1,rest);
      return _loc3_;
   }
}

