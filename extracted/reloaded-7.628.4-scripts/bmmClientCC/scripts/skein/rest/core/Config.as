package skein.rest.core
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import skein.core.skein_internal;
   import skein.rest.cache.CacheClient;
   import skein.rest.cache.impl.DefaultCacheClient;
   import skein.rest.client.RestClient;
   import skein.rest.client.impl.DefaultRestClient;
   import skein.utils.Base64;
   
   use namespace skein_internal;
   
   public class Config extends EventDispatcher
   {
      
      private static var _auth:String;
      
      private static var _beforeResultHook:Function;
      
      private static var _afterResultHook:Function;
      
      private static var _errorHook:Function;
      
      private static var _errorDecoder:Function;
      
      private static var _progressHandler:Function;
      
      private static var instance:Config;
      
      private static var _implementations:Dictionary = new Dictionary();
      
      _implementations[RestClient] = DefaultRestClient;
      _implementations[CacheClient] = DefaultCacheClient;
      
      private var _rest:String;
      
      private var _fixKnownIssues:Boolean;
      
      private var _accessToken:String = null;
      
      private var _accessTokenKey:String = "access_token";
      
      private var _username:String;
      
      private var _password:String;
      
      private var _token:String;
      
      private var _authorization:String;
      
      private var _useQueue:Boolean = true;
      
      private var _useCache:Boolean = false;
      
      private var _cache:CacheClient;
      
      private var _cacheIgnoreParams:Array;
      
      public function Config()
      {
         super();
      }
      
      skein_internal static function auth(param1:String) : void
      {
         _auth = param1;
      }
      
      skein_internal static function setImplementation(param1:Class, param2:Class) : void
      {
         _implementations[param1] = param2;
      }
      
      skein_internal static function setBeforeResultHook(param1:Function) : void
      {
         _beforeResultHook = param1;
      }
      
      public static function setAfterResultHook(param1:Function) : void
      {
         _afterResultHook = param1;
      }
      
      skein_internal static function setErrorHook(param1:Function) : void
      {
         _errorHook = param1;
      }
      
      skein_internal static function setErrorDecoder(param1:Function) : void
      {
         _errorDecoder = param1;
      }
      
      skein_internal static function setProgressHandler(param1:Function) : void
      {
         _progressHandler = param1;
      }
      
      public static function sharedInstance() : Config
      {
         if(instance == null)
         {
            instance = new Config();
         }
         return instance;
      }
      
      public function get auth() : String
      {
         return _auth;
      }
      
      public function get rest() : String
      {
         return _rest;
      }
      
      public function set rest(param1:String) : void
      {
         _rest = param1;
      }
      
      public function get beforeResultHook() : Function
      {
         return _beforeResultHook;
      }
      
      public function get afterResultHook() : Function
      {
         return _afterResultHook;
      }
      
      public function get errorHook() : Function
      {
         return _errorHook;
      }
      
      public function get errorDecoder() : Function
      {
         return _errorDecoder;
      }
      
      public function get progressHandler() : Function
      {
         return _progressHandler;
      }
      
      public function get fixKnownIssues() : Boolean
      {
         return _fixKnownIssues;
      }
      
      skein_internal function setFixKnownIssues(param1:Boolean) : void
      {
         _fixKnownIssues = param1;
      }
      
      public function get accessToken() : String
      {
         return _accessToken;
      }
      
      public function set accessToken(param1:String) : void
      {
         if(_accessToken == param1)
         {
            return;
         }
         _accessToken = param1;
         dispatchEvent(new Event("accessTokenChanged"));
      }
      
      public function get accessTokenKey() : String
      {
         return _accessTokenKey;
      }
      
      public function set accessTokenKey(param1:String) : void
      {
         if(_accessTokenKey == param1)
         {
            return;
         }
         _accessTokenKey = param1;
         dispatchEvent(new Event("accessTokenKeyChanged"));
      }
      
      public function get username() : String
      {
         return _username;
      }
      
      public function set username(param1:String) : void
      {
         if(_username == param1)
         {
            return;
         }
         _username = param1;
         updateAuthorization();
      }
      
      public function get password() : String
      {
         return _password;
      }
      
      public function set password(param1:String) : void
      {
         if(_password == param1)
         {
            return;
         }
         _password = param1;
         updateAuthorization();
      }
      
      public function get token() : String
      {
         return _token;
      }
      
      public function set token(param1:String) : void
      {
         if(param1 == _token)
         {
            return;
         }
         _token = param1;
         updateAuthorization();
      }
      
      public function get authorization() : String
      {
         return _authorization;
      }
      
      private function updateAuthorization() : void
      {
         if(_token)
         {
            _authorization = "Bearer " + _token;
         }
         else if(_username && _password)
         {
            _authorization = "Basic " + skein.utils.Base64.encode(_username + ":" + _password);
         }
         else
         {
            _authorization = null;
         }
      }
      
      public function get useQueue() : Boolean
      {
         return _useQueue;
      }
      
      public function set useQueue(param1:Boolean) : void
      {
         if(_useQueue == param1)
         {
            return;
         }
         _useQueue = param1;
         dispatchEvent(new Event("useQueueChanged"));
      }
      
      public function get useCache() : Boolean
      {
         return _useCache;
      }
      
      public function set useCache(param1:Boolean) : void
      {
         if(_useCache == param1)
         {
            return;
         }
         _useCache = param1;
         _cache = null;
         dispatchEvent(new Event("useCacheChanged"));
      }
      
      public function get cache() : CacheClient
      {
         var _loc1_:Class = null;
         if(_cache == null)
         {
            _loc1_ = getImplementation(CacheClient);
            if(_loc1_ != null)
            {
               _cache = new _loc1_();
               if(_cache is DefaultCacheClient)
               {
                  DefaultCacheClient(_cache).skein_internal::setIgnoreParams(_cacheIgnoreParams);
               }
            }
         }
         return _cache;
      }
      
      public function get cacheIgnoreParams() : Array
      {
         return _cacheIgnoreParams;
      }
      
      skein_internal function setCacheIgnoreParams(param1:Array) : void
      {
         _cacheIgnoreParams = param1;
      }
      
      public function getImplementation(param1:Class) : Class
      {
         return _implementations[param1];
      }
   }
}

