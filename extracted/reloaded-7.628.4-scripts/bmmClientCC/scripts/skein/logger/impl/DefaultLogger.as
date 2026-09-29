package skein.logger.impl
{
   import skein.logger.LogEvent;
   import skein.logger.Logger;
   import skein.logger.LoggerAppender;
   
   public class DefaultLogger implements Logger
   {
      
      private var _appenders:Vector.<LoggerAppender>;
      
      public function DefaultLogger()
      {
         super();
      }
      
      public function get appenders() : Vector.<LoggerAppender>
      {
         return _appenders;
      }
      
      public function set appenders(param1:Vector.<LoggerAppender>) : void
      {
         _appenders = param1;
      }
      
      public function log(param1:LogEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_appenders != null && _appenders.length > 0)
         {
            _loc2_ = 0;
            _loc3_ = int(_appenders.length);
            while(_loc2_ < _loc3_)
            {
               _appenders[_loc2_].append(param1);
               _loc2_++;
            }
         }
      }
   }
}

