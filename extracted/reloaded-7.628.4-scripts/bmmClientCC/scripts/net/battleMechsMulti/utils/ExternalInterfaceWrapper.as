package net.battleMechsMulti.utils
{
   import flash.external.ExternalInterface;
   
   public class ExternalInterfaceWrapper
   {
      
      private static var _isAvailable:Boolean;
      
      private static var _instance:ExternalInterfaceWrapper = null;
      
      private static var _hasLogFunction:Boolean = false;
      
      public static const NOT_AVAILABLE:* = new Object();
      
      public function ExternalInterfaceWrapper()
      {
         var result:* = undefined;
         super();
         if(!ExternalInterface.available)
         {
            trace("ExternalInterfaceWrapper :: External Interface not available");
            ExternalInterfaceWrapper._isAvailable = false;
            return;
         }
         try
         {
            result = ExternalInterface.call("function() { return 40 + 2; }");
            if(result == 42)
            {
               trace("ExternalInterfaceWrapper :: External Interface avilable");
               ExternalInterfaceWrapper._isAvailable = true;
               initLogging();
            }
            else
            {
               trace("ExternalInterfaceWrapper :: External Interface wrong result: " + result);
               ExternalInterfaceWrapper._isAvailable = false;
            }
         }
         catch(err:Error)
         {
            trace("ExternalInterfaceWrapper :: External Interface error: " + err);
            ExternalInterfaceWrapper._isAvailable = false;
         }
      }
      
      private static function initLogging() : void
      {
         _hasLogFunction = ExternalInterface.call("function() { return typeof(tslog) === \'function\' }");
      }
      
      public static function log(param1:String) : *
      {
         initIfNeeded();
         if(_hasLogFunction)
         {
            ExternalInterface.call("tslog",param1);
         }
      }
      
      private static function initIfNeeded() : *
      {
         if(ExternalInterfaceWrapper._instance == null)
         {
            _instance = new ExternalInterfaceWrapper();
         }
      }
      
      public static function isAvailable() : Boolean
      {
         initIfNeeded();
         return ExternalInterfaceWrapper._isAvailable;
      }
      
      public static function call(param1:String, ... rest) : *
      {
         initIfNeeded();
         if(!_isAvailable)
         {
            return NOT_AVAILABLE;
         }
         rest.unshift(param1);
         return ExternalInterface.call.apply(null,rest);
      }
      
      public static function addCallback(param1:String, param2:Function) : *
      {
         initIfNeeded();
         if(!_isAvailable)
         {
            return NOT_AVAILABLE;
         }
         return ExternalInterface.addCallback(param1,param2);
      }
      
      public static function executeLine(param1:String) : *
      {
         return call("function(){return " + param1 + ";}");
      }
      
      public static function getFlashElementJSCode() : String
      {
         return "document.getElementById(\'game\')";
      }
      
      public static function initJSUserData(param1:int, param2:String) : *
      {
         var playerID:int = param1;
         var playerName:String = param2;
         initIfNeeded();
         if(!_isAvailable)
         {
            return NOT_AVAILABLE;
         }
         try
         {
            call("smSetUserData",playerID,playerName);
         }
         catch(e:*)
         {
            TsLogger.log("Unable to call smSetUserData");
            TsLogger.log(e);
         }
      }
      
      public static function setJSTags(param1:Object) : *
      {
         var tags:Object = param1;
         initIfNeeded();
         if(!_isAvailable)
         {
            return NOT_AVAILABLE;
         }
         try
         {
            call("smAddTags",tags);
         }
         catch(e:*)
         {
            TsLogger.log("Unable to call smSetUserData");
            TsLogger.log(e);
         }
      }
   }
}

