package net.battleMechsMulti.session
{
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import net.tacticsoft.utils.URLParser;
   
   public class BMPlatformUtils
   {
      
      public static const PLATFORM_IOS:* = "ios";
      
      public static const PLATFORM_IDE:* = "ide";
      
      public static const PLATFORM_ANDROID:* = "android";
      
      public static const PLATFORM_KONG:* = "kong";
      
      public static const SOURCE_GAMEROOM:* = "gameroom";
      
      public function BMPlatformUtils()
      {
         super();
      }
      
      public static function get browserUrl() : String
      {
         if(!ExternalInterface.available)
         {
            return "";
         }
         var _loc1_:String = "";
         try
         {
            _loc1_ = ExternalInterface.call("function(){return (window.location != window.parent.location) ? document.referrer : document.location.toString();}");
         }
         catch(e:Error)
         {
         }
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public static function get browserName() : String
      {
         if(!ExternalInterface.available)
         {
            return "";
         }
         var _loc1_:String = "";
         try
         {
            _loc1_ = ExternalInterface.call("window.navigator.appName.toString");
         }
         catch(e:Error)
         {
         }
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public static function get sourcePlatform() : String
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         if(isGameRoom)
         {
            return SOURCE_GAMEROOM;
         }
         var _loc1_:String = browserUrl;
         try
         {
            _loc2_ = new URLParser(_loc1_).host;
            _loc3_ = _loc2_.split(".");
            if(_loc3_.length > 1)
            {
               return "web-" + _loc3_[_loc3_.length - 2];
            }
            return "web-" + _loc2_;
         }
         catch(e:Error)
         {
         }
         return "web-" + _loc1_;
      }
      
      public static function get isGameRoom() : Boolean
      {
         return browserName == "FacebookCanvasDesktop";
      }
      
      public static function get isFaceBook() : Boolean
      {
         return browserUrl.toLowerCase().search("facebook") != -1;
      }
      
      public static function get infoString() : String
      {
         return "Platform info::\n" + "browserName: " + browserName + "\n" + "sourcePlatform: " + sourcePlatform;
      }
      
      public static function get capabilitiesString() : String
      {
         return "Capabilities::\n" + "os: " + Capabilities.os + "\n" + "version: " + Capabilities.version + "\n" + "playerType: " + Capabilities.playerType;
      }
      
      public static function refrashPage() : *
      {
         try
         {
            ExternalInterface.call("window.location.reload");
         }
         catch(e:Error)
         {
            TsLogger.log("Error:: cannot refrash page on this platform");
         }
      }
      
      public static function get networkInfoString() : String
      {
         var _loc1_:String = "Network Info:\n";
         return _loc1_ + "Not Supported";
      }
   }
}

