package com.snowplowanalytics.snowplow.tracker
{
   import com.snowplowanalytics.snowplow.tracker.util.UUID;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.ByteArray;
   import mx.utils.Base64Encoder;
   
   public class Util
   {
      
      public static var scriptAccessAllowed:int = -1;
      
      public function Util()
      {
         super();
      }
      
      public static function getTimestamp() : String
      {
         var _loc1_:Date = new Date();
         return _loc1_.time.toString();
      }
      
      private static function callCallback(param1:String, param2:URLLoader, param3:Function) : void
      {
         var _loc4_:* = undefined;
         switch(param1)
         {
            case URLLoaderDataFormat.TEXT:
            case URLLoaderDataFormat.VARIABLES:
               _loc4_ = param2.data;
               break;
            case URLLoaderDataFormat.BINARY:
            default:
               _loc4_ = ByteArray(param2.data);
         }
         param3(_loc4_);
      }
      
      public static function base64Encode(param1:String) : String
      {
         var encoder:Base64Encoder = null;
         var str:String = param1;
         try
         {
            encoder = new Base64Encoder();
            encoder.encode(str);
            return encoder.flush();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
         return null;
      }
      
      public static function fixupUrl(param1:String, param2:String, param3:String) : Array
      {
         var hostName:String = param1;
         var href:String = param2;
         var referrer:String = param3;
         if(hostName === "translate.googleusercontent.com")
         {
            if(referrer === "")
            {
               referrer = href;
            }
            href = getParameter(href,"u");
            hostName = getHostName(href);
         }
         else if(hostName === "cc.bingj.com" || hostName === "webcache.googleusercontent.com" || isYahooCachedPage(hostName))
         {
            try
            {
               href = ExternalInterface.call("function getLinkHref() { return document.links[0].href; }");
            }
            catch(e:Error)
            {
               href = "";
            }
            hostName = getHostName(href);
         }
         return [hostName,href,referrer];
      }
      
      private static function isYahooCachedPage(param1:String) : Boolean
      {
         var initialDivText:String = null;
         var cachedIndicator:String = null;
         var hostName:String = param1;
         return false;
      }
      
      public static function padZeroes(param1:*, param2:int = 2) : String
      {
         var _loc5_:int = 0;
         var _loc3_:String = param1.toString();
         var _loc4_:int = param2 - _loc3_.length;
         if(_loc4_ > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_ = "0" + _loc3_;
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public static function findFirstItemInArray(param1:Array, param2:String, param3:*) : *
      {
         var _loc4_:* = undefined;
         for each(_loc4_ in param1)
         {
            if(_loc4_[param2] == param3)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public static function clearArray(param1:Array) : void
      {
         param1.splice(0,param1.length);
      }
      
      private static function fromQuerystring(param1:String, param2:String) : String
      {
         var _loc3_:RegExp = new RegExp("^[^#]*[?&]" + param1 + "=([^&#]*)").exec(param2);
         if(!_loc3_)
         {
            return null;
         }
         return decodeURIComponent(_loc3_[1].replace(/\+/g," "));
      }
      
      private static function getHostName(param1:String) : String
      {
         var _loc2_:RegExp = new RegExp("^(?:(?:https?|ftp):)/*(?:[^@]+@)?([^:/#]+)");
         var _loc3_:* = _loc2_.exec(param1);
         return _loc3_ ? _loc3_[1] : param1;
      }
      
      public static function murmurhash3_32_gc(param1:String, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         _loc3_ = param1.length & 3;
         _loc4_ = param1.length - _loc3_;
         _loc5_ = param2;
         _loc7_ = 3432918353;
         _loc9_ = 461845907;
         _loc12_ = 0;
         while(_loc12_ < _loc4_)
         {
            _loc11_ = param1.charCodeAt(_loc12_) & 0xFF | (param1.charCodeAt(++_loc12_) & 0xFF) << 8 | (param1.charCodeAt(++_loc12_) & 0xFF) << 16 | (param1.charCodeAt(++_loc12_) & 0xFF) << 24;
            _loc12_++;
            _loc11_ = (_loc11_ & 0xFFFF) * _loc7_ + (((_loc11_ >>> 16) * _loc7_ & 0xFFFF) << 16) & 0xFFFFFFFF;
            _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
            _loc11_ = (_loc11_ & 0xFFFF) * _loc9_ + (((_loc11_ >>> 16) * _loc9_ & 0xFFFF) << 16) & 0xFFFFFFFF;
            _loc5_ ^= _loc11_;
            _loc5_ = _loc5_ << 13 | _loc5_ >>> 19;
            _loc6_ = (_loc5_ & 0xFFFF) * 5 + (((_loc5_ >>> 16) * 5 & 0xFFFF) << 16) & 0xFFFFFFFF;
            _loc5_ = (_loc6_ & 0xFFFF) + 27492 + (((_loc6_ >>> 16) + 58964 & 0xFFFF) << 16);
         }
         _loc11_ = 0;
         switch(_loc3_)
         {
            case 3:
               _loc11_ ^= (param1.charCodeAt(_loc12_ + 2) & 0xFF) << 16;
            case 2:
               _loc11_ ^= (param1.charCodeAt(_loc12_ + 1) & 0xFF) << 8;
            case 1:
               _loc11_ ^= param1.charCodeAt(_loc12_) & 0xFF;
               _loc11_ = (_loc11_ & 0xFFFF) * _loc7_ + (((_loc11_ >>> 16) * _loc7_ & 0xFFFF) << 16) & 0xFFFFFFFF;
               _loc11_ = _loc11_ << 15 | _loc11_ >>> 17;
               _loc11_ = (_loc11_ & 0xFFFF) * _loc9_ + (((_loc11_ >>> 16) * _loc9_ & 0xFFFF) << 16) & 0xFFFFFFFF;
               _loc5_ ^= _loc11_;
         }
         _loc5_ ^= param1.length;
         _loc5_ ^= _loc5_ >>> 16;
         _loc5_ = (_loc5_ & 0xFFFF) * 2246822507 + (((_loc5_ >>> 16) * 2246822507 & 0xFFFF) << 16) & 0xFFFFFFFF;
         _loc5_ ^= _loc5_ >>> 13;
         _loc5_ = (_loc5_ & 0xFFFF) * 3266489909 + (((_loc5_ >>> 16) * 3266489909 & 0xFFFF) << 16) & 0xFFFFFFFF;
         _loc5_ ^= _loc5_ >>> 16;
         return _loc5_ >>> 0;
      }
      
      public static function getTransactionId() : int
      {
         return Math.round(Math.random() * 1000000);
      }
      
      private static function getParameter(param1:String, param2:String) : String
      {
         var _loc3_:RegExp = new RegExp("^(?:https?|ftp)(?::/*(?:[^?]+))([?][^#]+)");
         var _loc4_:* = _loc3_.exec(param1);
         return fromQuerystring(param2,_loc4_[1]);
      }
      
      public static function copyObject(param1:Object, param2:Boolean = false) : Object
      {
         var _loc4_:String = null;
         if(param1 == null)
         {
            if(param2)
            {
               return {};
            }
            return null;
         }
         var _loc3_:Object = {};
         for(_loc4_ in param1)
         {
            _loc3_[_loc4_] = param1[_loc4_];
         }
         return _loc3_;
      }
      
      public static function fixupDomain(param1:String) : String
      {
         var _loc2_:int = param1.length;
         if(param1.charAt(--_loc2_) === ".")
         {
            param1 = param1.slice(0,_loc2_);
         }
         if(param1.slice(0,2) === "*.")
         {
            param1 = param1.slice(1);
         }
         return param1;
      }
      
      public static function getResponse(param1:String, param2:Function, param3:Function, param4:String = "get", param5:String = null, param6:String = "text") : void
      {
         var loader:URLLoader = null;
         var url:String = param1;
         var callback:Function = param2;
         var errorCallback:Function = param3;
         var method:String = param4;
         var postData:String = param5;
         var dataFormat:String = param6;
         loader = new URLLoader();
         var request:URLRequest = new URLRequest(url);
         request.method = method;
         if(postData != null && method == URLRequestMethod.POST)
         {
            request.data = postData;
            request.contentType = "application/json; charset=utf-8";
         }
         loader.dataFormat = dataFormat;
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            if(callback != null)
            {
               callCallback(dataFormat,loader,callback);
            }
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
            if(param1.type == "201")
            {
               if(callback != null)
               {
                  callCallback(dataFormat,loader,callback);
               }
            }
            else if(errorCallback != null)
            {
               errorCallback(param1);
            }
         });
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(param1:SecurityErrorEvent):void
         {
            if(errorCallback != null)
            {
               errorCallback(param1);
            }
         });
         loader.load(request);
      }
      
      public static function isNullOrEmpty(param1:*) : Boolean
      {
         return param1 == null || param1 is String && (param1 as String).length == 0;
      }
      
      private static function isIpAddress(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
         return _loc2_.test(param1);
      }
      
      public static function isScriptAccessAllowed() : Boolean
      {
         if(scriptAccessAllowed != -1)
         {
            return scriptAccessAllowed == 1;
         }
         if(!ExternalInterface.available)
         {
            scriptAccessAllowed = 0;
            return false;
         }
         try
         {
            ExternalInterface.call("function isScriptAccessAllowed(){return true;}");
            scriptAccessAllowed = 1;
         }
         catch(error:Error)
         {
            if(error is SecurityError)
            {
               scriptAccessAllowed = 0;
            }
         }
         return scriptAccessAllowed == 1;
      }
      
      public static function getEventId() : String
      {
         return UUID.generateGuid();
      }
   }
}

