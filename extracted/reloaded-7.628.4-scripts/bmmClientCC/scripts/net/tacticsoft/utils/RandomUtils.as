package net.tacticsoft.utils
{
   public class RandomUtils
   {
      
      public function RandomUtils()
      {
         super();
         throw new Error();
      }
      
      public static function generateRandomString(param1:Number) : String
      {
         var _loc2_:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_";
         var _loc3_:Number = _loc2_.length - 1;
         var _loc4_:String = "";
         var _loc5_:Number = 0;
         while(_loc5_ < param1)
         {
            _loc4_ += _loc2_.charAt(Math.floor(Math.random() * _loc3_));
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function chooseRandomElement(param1:Array) : *
      {
         return param1[chooseRandomIndex(param1)];
      }
      
      public static function chooseRandomIndex(param1:Array) : int
      {
         return Math.floor(Math.random() * param1.length);
      }
      
      public static function getRandom(param1:Number, param2:Number) : Number
      {
         return param1 + Math.random() * (param2 - param1);
      }
   }
}

