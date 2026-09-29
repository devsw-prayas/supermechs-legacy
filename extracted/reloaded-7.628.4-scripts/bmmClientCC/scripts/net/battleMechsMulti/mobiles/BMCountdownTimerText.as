package net.battleMechsMulti.mobiles
{
   public class BMCountdownTimerText
   {
      
      private static const MINUTE_SECONDS:uint = 60;
      
      private static const HOUR_SECONDS:uint = 3600;
      
      private static const DAY_SECONDS:uint = 86400;
      
      public function BMCountdownTimerText()
      {
         super();
      }
      
      public static function getCountdownTimerText(param1:Number) : String
      {
         var _loc10_:String = null;
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc2_:Number = Math.floor(param1 / DAY_SECONDS);
         var _loc3_:Number = Math.floor((param1 - _loc2_ * DAY_SECONDS) / HOUR_SECONDS);
         var _loc4_:Number = Math.floor((param1 - _loc2_ * DAY_SECONDS - _loc3_ * HOUR_SECONDS) / MINUTE_SECONDS);
         var _loc5_:Number = Math.floor(param1 - _loc2_ * DAY_SECONDS - _loc3_ * HOUR_SECONDS - _loc4_ * MINUTE_SECONDS);
         var _loc6_:String = String(_loc2_);
         var _loc7_:String = String(_loc3_);
         if(_loc7_.length == 1)
         {
            _loc7_ = "0" + _loc7_;
         }
         var _loc8_:String = String(_loc4_);
         if(_loc8_.length == 1)
         {
            _loc8_ = "0" + _loc8_;
         }
         var _loc9_:String = String(_loc5_);
         if(_loc9_.length == 1)
         {
            _loc9_ = "0" + _loc9_;
         }
         if(_loc2_ > 0)
         {
            _loc10_ = _loc6_ + ":" + _loc7_ + ":" + _loc8_ + ":" + _loc9_;
         }
         else if(_loc3_ > 0)
         {
            _loc10_ = _loc7_ + ":" + _loc8_ + ":" + _loc9_;
         }
         else
         {
            _loc10_ = _loc8_ + ":" + _loc9_;
         }
         return _loc10_;
      }
   }
}

