package net.battleMechsMulti.utils
{
   import flash.external.ExternalInterface;
   
   public class ExternalInterfaceWrapper
   {
      
      private static var _isAvailable:Boolean;
      
      private static var _instance:ExternalInterfaceWrapper = null;
      
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
      
      public static function call(param1:*, ... rest) : *
      {
         initIfNeeded();
         if(!_isAvailable)
         {
            return NOT_AVAILABLE;
         }
         rest.unshift(param1);
         return ExternalInterface.call.apply(null,rest);
      }
   }
}

