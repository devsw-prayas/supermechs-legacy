package skein.logger.core
{
   import skein.core.skein_internal;
   import skein.logger.*;
   
   use namespace skein_internal;
   
   public class LoggerRegistry
   {
      
      private static const _loggers:Object = {};
      
      public function LoggerRegistry()
      {
         super();
      }
      
      public static function getLogger(param1:String) : Logger
      {
         var _loc3_:Class = null;
         var _loc2_:Logger = null;
         if(_loggers.hasOwnProperty(param1))
         {
            return _loggers[param1];
         }
         _loc3_ = Config.getImplementationForTag(param1,Logger);
         if(_loc3_ != null)
         {
            _loc2_ = new _loc3_();
            _loc2_.appenders = Config.releaseLoggerAppenders(param1);
            _loggers[param1] = _loc2_;
            return _loc2_;
         }
         return null;
      }
   }
}

