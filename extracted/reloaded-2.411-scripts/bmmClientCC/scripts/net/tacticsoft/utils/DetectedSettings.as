package net.tacticsoft.utils
{
   import flash.system.Capabilities;
   import flash.system.Security;
   
   public dynamic class DetectedSettings
   {
      
      public static var isAir:Boolean = Capabilities.playerType == "Desktop";
      
      public static var isPlayerTypeSA:Boolean = Capabilities.playerType == "StandAlone";
      
      public static var isPlayerTypeBrowser:Boolean = Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn";
      
      public static var isPlayerTypeOther:Boolean = Capabilities.playerType == "External";
      
      public static var isAndroid:Boolean = Capabilities.version.substr(0,3) == "AND";
      
      public static var isIOS:Boolean = Capabilities.version.substr(0,3) == "IOS";
      
      public static var isBlackBerry:Boolean = Capabilities.version.substr(0,3) == "QNX";
      
      public static var isWindowsOS:Boolean = Capabilities.version.substr(0,3) == "WIN";
      
      public static var isMacOS:Boolean = Capabilities.version.substr(0,3) == "MAC";
      
      public static var isAndroidOS:Boolean = Capabilities.version.substr(0,3) == "AND";
      
      public static var isUnixOS:Boolean = Capabilities.version.substr(0,3) == "LNX" || Capabilities.version.substr(0,4) == "UNIX";
      
      public static var isDebugPlayer:Boolean = Capabilities.isDebugger;
      
      public static var isInAcrobat:Boolean = false;
      
      public static var isRemote:Boolean = Security.sandboxType == Security.REMOTE;
      
      public static var isLocalBrowser:Boolean = Security.sandboxType != Security.REMOTE && (Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn");
      
      public static var isRemoteBrowser:Boolean = Security.sandboxType == Security.REMOTE && (Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn");
      
      public static var needsTrustForNet:Boolean = Security.sandboxType == Security.LOCAL_WITH_FILE;
      
      public static var needsTrustForLocal:Boolean = Security.sandboxType == Security.LOCAL_WITH_NETWORK;
      
      public static var isTrusted:Boolean = Security.sandboxType == Security.LOCAL_TRUSTED;
      
      public static var isApplication:Boolean = false;
      
      public static var isMobile:Boolean = Boolean(DetectedSettings.isAndroid) || Boolean(DetectedSettings.isIOS) || Boolean(DetectedSettings.isBlackBerry);
      
      public function DetectedSettings()
      {
         super();
      }
   }
}

