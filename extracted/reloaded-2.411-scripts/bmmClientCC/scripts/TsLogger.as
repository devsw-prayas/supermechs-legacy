package
{
   public class TsLogger
   {
      
      private static var _logs:Array = new Array();
      
      public function TsLogger()
      {
         super();
      }
      
      public static function log(... rest) : void
      {
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
   }
}

