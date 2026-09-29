package com.snowplowanalytics.snowplow.tracker.util
{
   public class Preconditions
   {
      
      public function Preconditions()
      {
         super();
      }
      
      public static function checkNotNull(param1:*, ... rest) : *
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(param1 == null)
         {
            if(rest != null && rest.length == 1)
            {
               throw new Error(String(rest[0]));
            }
            if(rest != null && rest.length > 1)
            {
               _loc3_ = rest[0];
               _loc4_ = rest.slice(1);
               throw new Error(format(_loc3_,rest));
            }
            throw new Error("reference is null");
         }
         return param1;
      }
      
      private static function badPositionIndex(param1:int, param2:int, param3:String) : String
      {
         if(param1 < 0)
         {
            return format("%s (%s) must not be negative",param3,param1);
         }
         if(param2 < 0)
         {
            throw new Error("negative size: " + param2);
         }
         return format("%s (%s) must not be greater than size (%s)",param3,param1,param2);
      }
      
      public static function checkArgument(param1:Boolean, ... rest) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(!param1)
         {
            if(rest != null && rest.length == 1)
            {
               throw new Error(String(rest[0]));
            }
            if(rest != null && rest.length > 1)
            {
               _loc3_ = rest[0];
               _loc4_ = rest.slice(1);
               throw new Error(format(_loc3_,rest));
            }
            throw new Error("expression is false");
         }
      }
      
      private static function format(param1:String, ... rest) : String
      {
         var _loc6_:int = 0;
         param1 = String(param1);
         var _loc3_:String = "";
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         while(_loc5_ < rest.length)
         {
            _loc6_ = param1.indexOf("%s",_loc4_);
            if(_loc6_ == -1)
            {
               break;
            }
            _loc3_ += param1.substring(_loc4_,_loc6_);
            _loc3_ += String(rest[_loc5_++]);
            _loc4_ = _loc6_ + 2;
         }
         _loc3_ += param1.substring(_loc4_);
         if(_loc5_ < rest.length)
         {
            _loc3_ += " [";
            _loc3_ += String(rest[_loc5_++]);
            while(_loc5_ < rest.length)
            {
               _loc3_ += ", ";
               _loc3_ += String(rest[_loc5_++]);
            }
            _loc3_ += "]";
         }
         return _loc3_;
      }
      
      public static function checkPositionIndex(param1:int, param2:int, param3:String = "index") : int
      {
         if(param1 < 0 || param1 > param2)
         {
            throw new Error(badPositionIndex(param1,param2,param3));
         }
         return param1;
      }
      
      public static function checkState(param1:Boolean, ... rest) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(!param1)
         {
            if(rest != null && rest.length == 1)
            {
               throw new Error(String(rest[0]));
            }
            if(rest != null && rest.length > 1)
            {
               _loc3_ = rest[0];
               _loc4_ = rest.slice(1);
               throw new Error(format(_loc3_,rest));
            }
            throw new Error("expression is false");
         }
      }
      
      private static function badPositionIndexes(param1:int, param2:int, param3:int) : String
      {
         if(param1 < 0 || param1 > param3)
         {
            return badPositionIndex(param1,param3,"start index");
         }
         if(param2 < 0 || param2 > param3)
         {
            return badPositionIndex(param2,param3,"end index");
         }
         return format("end index (%s) must not be less than start index (%s)",param2,param1);
      }
      
      private static function badElementIndex(param1:int, param2:int, param3:String) : String
      {
         if(param1 < 0)
         {
            return format("%s (%s) must not be negative",param3,param1);
         }
         if(param2 < 0)
         {
            throw new Error("negative size: " + param2);
         }
         return format("%s (%s) must be less than size (%s)",param3,param1,param2);
      }
      
      public static function checkElementIndex(param1:int, param2:int, param3:String = "index") : int
      {
         if(param1 < 0 || param1 >= param2)
         {
            throw new Error(badElementIndex(param1,param2,param3));
         }
         return param1;
      }
      
      public static function checkPositionIndexes(param1:int, param2:int, param3:int) : void
      {
         if(param1 < 0 || param2 < param1 || param2 > param3)
         {
            throw new Error(badPositionIndexes(param1,param2,param3));
         }
      }
   }
}

