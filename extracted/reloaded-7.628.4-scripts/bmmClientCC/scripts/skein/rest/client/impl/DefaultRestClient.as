package skein.rest.client.impl
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   import skein.core.skein_internal;
   import skein.logger.Log;
   import skein.rest.cache.CacheClient;
   import skein.rest.client.RestClient;
   import skein.rest.client.extras.Downloader;
   import skein.rest.client.extras.Uploader;
   import skein.rest.client.impl.extras.DownloaderHandler;
   import skein.rest.client.impl.extras.UploaderHandler;
   import skein.rest.core.Config;
   import skein.rest.core.Decoder;
   import skein.rest.core.Encoder;
   import skein.rest.core.ProgressTracker;
   import skein.rest.core.RestClientRegistry;
   import skein.rest.core.coding.DefaultCoding;
   import skein.utils.StringSubstituteArguments;
   import skein.utils.StringUtil;
   
   use namespace skein_internal;
   
   public class DefaultRestClient implements RestClient
   {
      
      private static const DEFAULT_CONTENT_TYPE:String = "application/json";
      
      private static const DEFAULT_RESPONSE_CONTENT_TYPE:String = "application/json";
      
      protected var _path:String;
      
      protected var _pathParams:Array;
      
      internal var loader:URLLoader;
      
      internal var request:URLRequest;
      
      protected var uploader:Uploader;
      
      protected var downloader:Downloader;
      
      private var downloadTo:Object;
      
      private var uploadFrom:Object;
      
      private var removeDefaultHeaders:Boolean = false;
      
      private var _headers:Array;
      
      private var _params:Object;
      
      private var _fields:Object;
      
      private var _contentType:String = "application/json";
      
      private var _requestedResponseContentType:String = "application/json";
      
      private var _actualResponseContentType:String = null;
      
      private var accessTokenSpecified:Boolean = false;
      
      private var _accessTokenKey:String;
      
      private var _accessTokenValue:String;
      
      private var _encoder:Function;
      
      private var _decoder:Function;
      
      public var _errorDecoder:Function;
      
      internal var beforeResultInterceptor:Function;
      
      internal var afterResultInterceptor:Function;
      
      internal var errorInterceptor:Function;
      
      internal var resultCallback:Function;
      
      internal var progressCallback:Function;
      
      internal var statusCallback:Function;
      
      internal var errorCallback:Function;
      
      internal var headerCallbacks:Object = {};
      
      internal var _timeout:Number = NaN;
      
      internal var stubDelay:uint;
      
      internal var stubValue:Object;
      
      internal var _cache:CacheClient;
      
      internal var _useCache:Boolean;
      
      private var _forceCache:Boolean = false;
      
      public function DefaultRestClient()
      {
         beforeResultInterceptor = Config.sharedInstance().beforeResultHook;
         afterResultInterceptor = Config.sharedInstance().afterResultHook;
         errorInterceptor = Config.sharedInstance().errorHook;
         _cache = Config.sharedInstance().cache;
         _useCache = Config.sharedInstance().useCache;
         super();
         Log.d("skein-rest","DefaultRestClient");
      }
      
      public function init(param1:String, param2:Array) : void
      {
         _path = param1;
         if(param2.length == 1 && param2[0] is StringSubstituteArguments)
         {
            _pathParams = StringSubstituteArguments(param2[0]).value;
         }
         else
         {
            _pathParams = param2;
         }
      }
      
      protected function get path() : String
      {
         if(_path.indexOf("http") == 0 || _path.indexOf("file") == 0 || _path.indexOf("app") == 0)
         {
            return StringUtil.substitute(_path,_pathParams);
         }
         return Config.sharedInstance().rest + StringUtil.substitute(_path,_pathParams);
      }
      
      public function addHeader(param1:Object) : RestClient
      {
         if(!_headers)
         {
            _headers = [];
         }
         _headers.push(param1);
         return this;
      }
      
      public function headers(param1:Array) : RestClient
      {
         _headers = param1;
         removeDefaultHeaders = true;
         return this;
      }
      
      public function addParam(param1:String, param2:Object, param3:Object = null) : RestClient
      {
         if(!param2)
         {
            if(!(param2 is Boolean) && !(param2 is Number && !isNaN(param2 as Number)))
            {
               param2 = param3;
            }
         }
         if(param2 != null)
         {
            if(!_params)
            {
               _params = {};
            }
            _params[param1] = String(param2);
         }
         return this;
      }
      
      public function params(param1:Object) : RestClient
      {
         _params = param1;
         return this;
      }
      
      public function addField(param1:String, param2:Object, param3:Object = null) : RestClient
      {
         param2 ||= param3;
         if(param2 != null)
         {
            if(!_fields)
            {
               _fields = {};
            }
            _fields[param1] = String(param2);
         }
         return this;
      }
      
      public function fields(param1:Object) : RestClient
      {
         _fields = param1;
         return this;
      }
      
      public function contentType(param1:String) : RestClient
      {
         _contentType = param1;
         return this;
      }
      
      private function getRequestContentType(param1:Object = null) : String
      {
         if(_contentType != null)
         {
            return _contentType;
         }
         if(param1 is ByteArray)
         {
            return "application/octet-stream";
         }
         return null;
      }
      
      public function requestedResponseContentType(param1:String) : RestClient
      {
         _requestedResponseContentType = param1;
         return this;
      }
      
      skein_internal function setResponseContentType(param1:String) : void
      {
         _actualResponseContentType = param1;
      }
      
      private function getResponseContentType() : String
      {
         return _actualResponseContentType || _requestedResponseContentType;
      }
      
      public function accessToken(param1:String, param2:String = "access_token") : RestClient
      {
         _accessTokenValue = param1;
         _accessTokenKey = param2;
         accessTokenSpecified = true;
         return this;
      }
      
      public function encoder(param1:Function) : RestClient
      {
         _encoder = param1;
         return this;
      }
      
      public function decoder(param1:Function) : RestClient
      {
         _decoder = param1;
         return this;
      }
      
      public function errorDecoder(param1:Function) : RestClient
      {
         _errorDecoder = param1;
         return this;
      }
      
      public function beforeResultHook(param1:Function) : RestClient
      {
         beforeResultInterceptor = param1;
         return this;
      }
      
      public function afterResultHook(param1:Function) : RestClient
      {
         afterResultInterceptor = param1;
         return this;
      }
      
      public function errorHook(param1:Function) : RestClient
      {
         errorInterceptor = param1;
         return this;
      }
      
      public function result(param1:Function) : RestClient
      {
         resultCallback = param1;
         return this;
      }
      
      public function progress(param1:Function) : RestClient
      {
         progressCallback = param1;
         return this;
      }
      
      public function status(param1:Function) : RestClient
      {
         statusCallback = param1;
         return this;
      }
      
      public function error(param1:Function) : RestClient
      {
         errorCallback = param1;
         return this;
      }
      
      public function header(param1:String, param2:Function) : RestClient
      {
         headerCallbacks[param1] = param2;
         return this;
      }
      
      internal function hasHeaderCallbacks() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Object = headerCallbacks;
         for(var _loc1_:String in _loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function timeout(param1:Number) : RestClient
      {
         _timeout = param1;
         return this;
      }
      
      public function stub(param1:Object, param2:uint = 0) : RestClient
      {
         stubValue = param1;
         stubDelay = param2;
         return this;
      }
      
      public function cache(param1:CacheClient) : RestClient
      {
         _cache = param1;
         return this;
      }
      
      public function useCache(param1:Boolean) : RestClient
      {
         _useCache = param1;
         return this;
      }
      
      public function forceCache(param1:Boolean) : RestClient
      {
         _forceCache = param1;
         return this;
      }
      
      private function get canUseCache() : Boolean
      {
         return _useCache && _cache != null;
      }
      
      public function get() : Object
      {
         send("GET");
         return loader;
      }
      
      public function post(param1:Object = null) : Object
      {
         send("POST",param1);
         return loader;
      }
      
      public function put(param1:Object = null) : Object
      {
         send("PUT",param1);
         return loader;
      }
      
      public function patch(param1:Object = null) : Object
      {
         var _loc2_:Boolean = Capabilities.version.substr(0,3) == "AND";
         if(_loc2_ && param1 != null && Config.sharedInstance().fixKnownIssues)
         {
            addHeader(new URLRequestHeader("X-HTTP-Method-Override","PATCH"));
            send("POST",param1);
            return loader;
         }
         send("PATCH",param1);
         return loader;
      }
      
      public function del(param1:Object = null) : Object
      {
         var _loc2_:Boolean = Capabilities.version.substr(0,3) == "AND";
         if(_loc2_ && param1 != null && Config.sharedInstance().fixKnownIssues)
         {
            addHeader(new URLRequestHeader("X-HTTP-Method-Override","DELETE"));
            send("POST",param1);
            return loader;
         }
         send("DELETE",param1);
         return loader;
      }
      
      public function download(param1:Object, param2:String = "GET", param3:Object = null) : void
      {
         var to:Object = param1;
         var method:String = param2;
         var data:Object = param3;
         downloadTo = to;
         downloader ||= new Downloader();
         new DownloaderHandler(this).handle(downloader);
         createRequest(method,data,function():void
         {
            doDownload();
         });
      }
      
      private function doDownload() : void
      {
         downloader.download(request,downloadTo);
      }
      
      public function upload(param1:Object) : void
      {
         uploadFrom = param1;
         uploader ||= new Uploader();
         new UploaderHandler(this).handle(uploader);
         request = new URLRequest(createURL());
         uploader.upload(uploadFrom,request,getRequestContentType(uploadFrom),_fields);
      }
      
      private function send(param1:String, param2:Object = null) : void
      {
         var method:String = param1;
         var data:Object = param2;
         createRequest(method,data,function():void
         {
            load();
         });
      }
      
      private function load() : void
      {
         var _loc1_:Boolean = true;
         if(loader == null)
         {
            loader = URLLoadersQueue.find(request);
            if(loader == null)
            {
               loader = new URLLoader();
            }
            else
            {
               _loc1_ = false;
            }
         }
         URLLoadersQueue.keep(request,loader);
         if(_requestedResponseContentType == "application/octet-stream")
         {
            loader.dataFormat = "binary";
         }
         else
         {
            loader.dataFormat = "text";
         }
         URLLoaderHandlerFactory.create(this).handle(loader);
         if(_loc1_)
         {
            if(stubValue != null)
            {
               doStub();
            }
            else
            {
               doLoad();
            }
         }
      }
      
      private function doStub() : void
      {
         var receiveStubData:Function;
         var timer:Timer;
         Log.i("skein-rest",URLLoadersQueue.name(loader) + " *STUB* " + request.method.toUpperCase() + " " + request.url + (request.data ? " -> " + request.data : ""));
         receiveStubData = function():void
         {
            loader.data = stubValue is Function ? (stubValue as Function).apply() : stubValue;
            loader.dispatchEvent(new HTTPStatusEvent("httpStatus",false,false,200));
            loader.dispatchEvent(new Event("complete"));
         };
         if(stubDelay > 0)
         {
            timer = new Timer(stubDelay,1);
            timer.addEventListener("timerComplete",function(param1:TimerEvent):void
            {
               timer.removeEventListener("timerComplete",arguments.callee);
               receiveStubData();
            });
            timer.start();
         }
         else
         {
            receiveStubData();
         }
      }
      
      private function doLoad() : void
      {
         if(_useCache && _cache != null)
         {
            if(_cache.live(request) || _forceCache)
            {
               _cache.find(request,function(param1:Object):void
               {
                  if(param1 != null)
                  {
                     loader.data = param1.data;
                     loader.dispatchEvent(new HTTPStatusEvent("httpStatus",false,false,200));
                     loader.dispatchEvent(new Event("complete"));
                  }
                  else
                  {
                     doLoadFromResource();
                  }
               });
            }
            else
            {
               _cache.find(request,function(param1:Object):void
               {
                  if(param1 != null)
                  {
                     request.requestHeaders = request.requestHeaders.concat(param1.headers);
                  }
                  doLoadFromResource();
               });
            }
         }
         else
         {
            doLoadFromResource();
         }
      }
      
      private function doLoadFromResource() : void
      {
         Log.i("skein-rest",URLLoadersQueue.name(loader) + " " + request.method.toUpperCase() + " " + request.url + (request.data ? " -> " + request.data : ""));
         loader.load(request);
      }
      
      skein_internal function retry() : Boolean
      {
         if(loader != null && request != null)
         {
            request.url = createURL();
            doLoadFromResource();
            return true;
         }
         if(downloader != null && downloadTo != null && request != null)
         {
            request.url = createURL();
            downloader.download(request,downloadTo);
            return true;
         }
         if(uploader != null && uploadFrom != null && request != null)
         {
            request.url = createURL();
            uploader.upload(uploadFrom,request,getRequestContentType(uploadFrom),_fields);
            return true;
         }
         return false;
      }
      
      public function url() : String
      {
         return createURL();
      }
      
      internal function free() : void
      {
         if(loader != null)
         {
            loader.dataFormat = "text";
            try
            {
               loader.close();
            }
            catch(error:Error)
            {
            }
            if(!URLLoadersQueue.free(loader))
            {
               loader = null;
            }
         }
         if(downloader != null)
         {
            try
            {
               downloader.close();
               downloader = null;
            }
            catch(error:Error)
            {
            }
         }
         if(uploader != null)
         {
            try
            {
               uploader.close();
               uploader = null;
            }
            catch(error:Error)
            {
            }
         }
         _path = null;
         _pathParams = null;
         request = null;
         downloadTo = null;
         uploadFrom = null;
         _headers = null;
         _params = null;
         _fields = null;
         _contentType = "application/json";
         _actualResponseContentType = null;
         _requestedResponseContentType = "application/json";
         _accessTokenKey = null;
         _accessTokenValue = null;
         accessTokenSpecified = false;
         _encoder = null;
         _decoder = null;
         beforeResultInterceptor = Config.sharedInstance().beforeResultHook;
         afterResultInterceptor = Config.sharedInstance().afterResultHook;
         errorInterceptor = Config.sharedInstance().errorHook;
         resultCallback = null;
         progressCallback = null;
         errorCallback = null;
         statusCallback = null;
         headerCallbacks = {};
         _timeout = NaN;
         stubValue = null;
         stubDelay = 0;
         _cache = Config.sharedInstance().cache;
         _useCache = Config.sharedInstance().useCache;
         _forceCache = false;
         RestClientRegistry.reuse(this);
      }
      
      private function createURL() : String
      {
         var _loc1_:String = encodeParams();
         return _loc1_ ? path + "?" + _loc1_ : path;
      }
      
      private function createRequest(param1:String, param2:Object = null, param3:Function = null) : void
      {
         var method:String = param1;
         var data:Object = param2;
         var callback:Function = param3;
         request = new URLRequest(createURL());
         request.method = method;
         request.contentType = _contentType;
         request.requestHeaders = request.requestHeaders.concat(gatherRequestHeaders());
         if(!isNaN(_timeout) && Boolean(Object(request).hasOwnProperty("idleTimeout")))
         {
            request["idleTimeout"] = _timeout;
         }
         if(data != null)
         {
            encodeRequest(data,function(param1:Object, param2:String = null):void
            {
               request.data = param1;
               if(param2 != null)
               {
                  request.contentType = param2;
               }
               if(callback != null)
               {
                  callback();
               }
            });
         }
         else if(callback != null)
         {
            callback();
         }
      }
      
      private function gatherRequestHeaders() : Array
      {
         var _loc3_:int = 0;
         var _loc4_:URLRequestHeader = null;
         var _loc1_:Array = [];
         var _loc2_:Boolean = false;
         var _loc5_:int = int(_headers ? _headers.length : 0);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = _headers[_loc3_];
            if(_loc4_.name == "Authorization")
            {
               _loc2_ = true;
               if(_loc4_.value)
               {
                  _loc1_[_loc1_.length] = _loc4_;
               }
            }
            else
            {
               _loc1_[_loc1_.length] = _loc4_;
            }
            _loc3_++;
         }
         if(!_loc2_ && Config.sharedInstance().authorization)
         {
            _loc1_[_loc1_.length] = new URLRequestHeader("Authorization",Config.sharedInstance().authorization);
         }
         return _loc1_;
      }
      
      private function encodeRequest(param1:Object, param2:Function) : void
      {
         if(_encoder != null)
         {
            _encoder(param1,param2);
         }
         else
         {
            Encoder.forType(getRequestContentType(param1))(param1,param2);
         }
      }
      
      internal function decodeResult(param1:Object, param2:Function) : void
      {
         getDecoderForDataWithPreferred(param1,_decoder)(param1,param2);
      }
      
      internal function decodeError(param1:Object, param2:int, param3:Function) : void
      {
         var _loc4_:Function = getDecoderForDataWithPreferred(param1,_errorDecoder || Config.sharedInstance().errorDecoder);
         if(_loc4_.length == 3)
         {
            _loc4_(param1,param2,param3);
         }
         else
         {
            _loc4_(param1,param3);
         }
      }
      
      private function getDecoderForDataWithPreferred(param1:Object, param2:Function) : Function
      {
         if(param2 != null)
         {
            return param2;
         }
         if(getQualifiedClassName(param1) == "flash.filesystem::File")
         {
            return DefaultCoding.decode;
         }
         if(param1 == null)
         {
            return DefaultCoding.decode;
         }
         return Decoder.forType(getResponseContentType());
      }
      
      private function encodeParams() : String
      {
         var _loc2_:URLVariables = null;
         if(accessTokenSpecified)
         {
            if(_accessTokenValue)
            {
               addParam(_accessTokenKey,_accessTokenValue);
            }
         }
         else if(Config.sharedInstance().accessToken)
         {
            addParam(Config.sharedInstance().accessTokenKey,Config.sharedInstance().accessToken);
         }
         if(_params)
         {
            _loc2_ = new URLVariables();
            for(var _loc1_:String in _params)
            {
               _loc2_[_loc1_] = _params[_loc1_];
            }
            return _loc2_.toString();
         }
         return "";
      }
      
      internal function handleResult(param1:Object, param2:uint, param3:Array, param4:Function) : void
      {
         var data:Object = param1;
         var responseCode:uint = param2;
         var headers:Array = param3;
         var callback:Function = param4;
         handleProgress(true);
         if(_useCache && _cache != null)
         {
            if(responseCode == 304)
            {
               _cache.find(request,function(param1:Object):void
               {
                  notifyResult(param1 ? param1.data : null,responseCode);
                  callback();
               });
            }
            else
            {
               notifyResult(data,responseCode);
               _cache.keep(request,data,headers,function(param1:* = undefined):void
               {
                  callback();
               });
            }
         }
         else
         {
            notifyResult(data,responseCode);
            callback();
         }
      }
      
      private function notifyResult(param1:Object, param2:uint) : void
      {
         if(resultCallback != null)
         {
            if(resultCallback.length == 2)
            {
               resultCallback(param1,param2);
            }
            else if(resultCallback.length == 1)
            {
               resultCallback(param1);
            }
            else
            {
               resultCallback();
            }
         }
      }
      
      internal function handleError(param1:Object, param2:uint) : void
      {
         handleProgress(true);
         notifyError(param1,param2);
      }
      
      private function notifyError(param1:Object, param2:uint) : void
      {
         if(errorCallback != null)
         {
            if(errorCallback.length == 2)
            {
               errorCallback(param1,param2);
            }
            else
            {
               errorCallback(param1);
            }
         }
      }
      
      internal function handleProgress(param1:Boolean, param2:Number = NaN, param3:Number = NaN) : void
      {
         if(param1)
         {
            ProgressTracker.complete(this);
         }
         else
         {
            ProgressTracker.progress(this,param2,param3);
            notifyProgress(param2,param3);
         }
         if(Config.sharedInstance().progressHandler != null)
         {
            Config.sharedInstance().progressHandler(ProgressTracker.loaded,ProgressTracker.total);
         }
      }
      
      private function notifyProgress(param1:Number, param2:Number) : void
      {
         if(progressCallback != null)
         {
            progressCallback(param1,param2);
         }
      }
   }
}

