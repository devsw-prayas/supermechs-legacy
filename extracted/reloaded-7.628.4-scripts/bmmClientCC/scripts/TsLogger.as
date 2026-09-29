package
{
   import flash.utils.getTimer;
   
   public class TsLogger
   {
      
      private static var _logs:Array = new Array();
      
      public function TsLogger()
      {
         super();
      }
      
      public static function log(... rest) : void
      {
         var _loc2_:Number = getTimer() / 1000;
         rest.unshift(_loc2_);
         trace(rest);
         pushLog(rest);
      }
      
      public static function pushLog(... rest) : void
      {
         if(_logs.length > 200)
         {
            _logs.shift();
         }
         _logs.push(rest.join(" "));
      }
      
      public static function getLog() : String
      {
         return _logs.join("\n");
      }
      
      public static function logStackTrace() : *
      {
         var _loc1_:String = new Error().getStackTrace();
         log(_loc1_);
      }
   }
}

