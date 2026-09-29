package skein.rest.core
{
   import skein.core.skein_internal;
   
   use namespace skein_internal;
   
   public class HeaderHandler
   {
      
      private static const handlers:Object = {};
      
      public function HeaderHandler()
      {
         super();
      }
      
      public static function forName(param1:String) : Function
      {
         return handlers[param1];
      }
      
      public static function hasHandler(param1:String) : Boolean
      {
         return handlers.hasOwnProperty(param1);
      }
      
      public static function hasHandlers() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Object = handlers;
         for(var _loc1_:String in _loc2_)
         {
            return true;
         }
         return false;
      }
      
      skein_internal static function register(param1:String, param2:Function) : void
      {
         handlers[param1] = param2;
      }
   }
}

