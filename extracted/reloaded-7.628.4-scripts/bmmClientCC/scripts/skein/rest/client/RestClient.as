package skein.rest.client
{
   import skein.rest.cache.CacheClient;
   
   public interface RestClient
   {
      
      function init(param1:String, param2:Array) : void;
      
      function addHeader(param1:Object) : RestClient;
      
      function headers(param1:Array) : RestClient;
      
      function addParam(param1:String, param2:Object, param3:Object = null) : RestClient;
      
      function params(param1:Object) : RestClient;
      
      function addField(param1:String, param2:Object, param3:Object = null) : RestClient;
      
      function fields(param1:Object) : RestClient;
      
      function accessToken(param1:String, param2:String = "access_token") : RestClient;
      
      function contentType(param1:String) : RestClient;
      
      function requestedResponseContentType(param1:String) : RestClient;
      
      function encoder(param1:Function) : RestClient;
      
      function decoder(param1:Function) : RestClient;
      
      function errorDecoder(param1:Function) : RestClient;
      
      function beforeResultHook(param1:Function) : RestClient;
      
      function afterResultHook(param1:Function) : RestClient;
      
      function errorHook(param1:Function) : RestClient;
      
      function progress(param1:Function) : RestClient;
      
      function status(param1:Function) : RestClient;
      
      function result(param1:Function) : RestClient;
      
      function error(param1:Function) : RestClient;
      
      function header(param1:String, param2:Function) : RestClient;
      
      function timeout(param1:Number) : RestClient;
      
      function stub(param1:Object, param2:uint = 0) : RestClient;
      
      function cache(param1:CacheClient) : RestClient;
      
      function useCache(param1:Boolean) : RestClient;
      
      function forceCache(param1:Boolean) : RestClient;
      
      function get() : Object;
      
      function post(param1:Object = null) : Object;
      
      function put(param1:Object = null) : Object;
      
      function patch(param1:Object = null) : Object;
      
      function del(param1:Object = null) : Object;
      
      function download(param1:Object, param2:String = "GET", param3:Object = null) : void;
      
      function upload(param1:Object) : void;
      
      function url() : String;
   }
}

