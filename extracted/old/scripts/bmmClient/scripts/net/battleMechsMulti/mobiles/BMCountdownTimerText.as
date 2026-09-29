package net.battleMechsMulti.mobiles
{
   public class BMCountdownTimerText
   {
      
      private static const MINUTE_SECONDS:uint = 60;
      
      private static const HOUR_SECONDS:uint = 3600;
      
      public function BMCountdownTimerText()
      {
         super();
      }
      
      public static function getCountdownTimerText(param1:Number) : String
      {
         var _loc8_:String = null;
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc2_:Number = Math.floor(param1 / HOUR_SECONDS);
         var _loc3_:Number = Math.floor((param1 - _loc2_ * HOUR_SECONDS) / MINUTE_SECONDS);
         var _loc4_:Number = Math.floor(param1 - _loc2_ * HOUR_SECONDS - _loc3_ * MINUTE_SECONDS);
         var _loc5_:String = String(_loc2_);
         if(_loc5_.length == 1)
         {
            _loc5_ = "0" + _loc5_;
         }
         var _loc6_:String = String(_loc3_);
         if(_loc6_.length == 1)
         {
            _loc6_ = "0" + _loc6_;
         }
         var _loc7_:String = String(_loc4_);
         if(_loc7_.length == 1)
         {
            _loc7_ = "0" + _loc7_;
         }
         if(_loc2_ > 0)
         {
            _loc8_ = _loc5_ + ":" + _loc6_ + ":" + _loc7_;
         }
         else
         {
            _loc8_ = _loc6_ + ":" + _loc7_;
         }
         return _loc8_;
      }
   }
}

