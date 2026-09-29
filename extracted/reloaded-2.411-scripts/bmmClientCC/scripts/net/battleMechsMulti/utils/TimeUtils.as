package net.battleMechsMulti.utils
{
   public class TimeUtils
   {
      
      public function TimeUtils()
      {
         super();
      }
      
      public static function formatTimeLeft(param1:int) : String
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc2_:* = 60;
         var _loc3_:uint = _loc2_ * 60;
         var _loc4_:Number = Math.floor(param1 / _loc3_);
         var _loc5_:Number = Math.floor((param1 - _loc4_ * _loc3_) / _loc2_);
         var _loc6_:Number = Math.floor(param1 - _loc4_ * _loc3_ - _loc5_ * _loc2_);
         if(_loc5_ < 10)
         {
            _loc8_ = "0" + _loc5_;
         }
         else
         {
            _loc8_ = String(_loc5_);
         }
         if(_loc6_ < 10)
         {
            _loc9_ = "0" + _loc6_;
         }
         else
         {
            _loc9_ = String(_loc6_);
         }
         var _loc10_:Number = _loc4_;
         if(_loc10_ > 0)
         {
            _loc7_ = _loc4_ + ":" + _loc8_ + ":" + _loc9_;
         }
         else
         {
            _loc7_ = _loc8_ + ":" + _loc9_;
         }
         return _loc7_;
      }
   }
}

