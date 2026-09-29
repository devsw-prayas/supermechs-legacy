package net.battleMechsMulti.session
{
   import flash.external.ExternalInterface;
   import flash.net.NetworkInfo;
   import flash.net.NetworkInterface;
   import flash.system.Capabilities;
   import net.battleMechsMulti.utils.ExternalInterfaceWrapper;
   
   public class BMPlatformUtils
   {
      
      public static const PLATFORM_IOS:* = "ios";
      
      public static const PLATFORM_IDE:* = "ide";
      
      public static const PLATFORM_ANDROID:* = "android";
      
      public static const PLATFORM_KONG:* = "kong";
      
      public static const SOURCE_GAMEROOM:* = "gameroom";
      
      public static const SOURCE_ELECTRON:* = "electron";
      
      public static const PLATFORM_WEB:* = "web";
      
      public function BMPlatformUtils()
      {
         super();
      }
      
      public static function get browserUrl() : String
      {
         if(!ExternalInterfaceWrapper.isAvailable())
         {
            return "";
         }
         var _loc1_:String = ExternalInterface.call("function(){return (window.location != window.parent.location) ? document.referrer : document.location.toString();}");
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public static function get userAgent() : String
      {
         if(!ExternalInterfaceWrapper.isAvailable())
         {
            return "";
         }
         var _loc1_:String = ExternalInterface.call("window.navigator.userAgent.toString");
         if(_loc1_ == null)
         {
            _loc1_ = "";
         }
         return _loc1_;
      }
      
      public static function get browserName() : String
      {
         if(!ExternalInterfaceWrapper.isAvailable())
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
         return PLATFORM_ANDROID;
      }
      
      public static function get shortSourcePlatform() : String
      {
         return PLATFORM_ANDROID;
      }
      
      public static function get isGameRoom() : Boolean
      {
         return browserName == "FacebookCanvasDesktop";
      }
      
      public static function get isElectron() : Boolean
      {
         return userAgent.indexOf("Electron") > -1;
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
         var _loc2_:NetworkInfo = null;
         var _loc3_:NetworkInterface = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc1_:String = "Network Info:\n";
         if(NetworkInfo.isSupported)
         {
            _loc2_ = NetworkInfo.networkInfo;
            for each(_loc3_ in _loc2_.findInterfaces())
            {
               _loc4_ = "";
               _loc5_ = uint(_loc3_.addresses.length);
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc4_ += _loc3_.addresses[_loc6_].address;
                  _loc6_++;
               }
               _loc1_ += "Name: " + _loc3_.name + " Active: " + _loc3_.active + " DName: " + _loc3_.displayName + " Addresses: " + _loc4_ + "\n";
            }
         }
         else
         {
            _loc1_ += "Not Supported";
         }
         return _loc1_;
      }
   }
}

