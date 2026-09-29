package net.tacticsoft.utils
{
   import flash.text.TextFormat;
   
   public class MiscUtils
   {
      
      public function MiscUtils()
      {
         super();
      }
      
      public static function traceObject(param1:Object, param2:Number = 0, param3:Number = 0) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         for(_loc4_ in param1)
         {
            _loc5_ = "}";
            _loc6_ = 0;
            while(_loc6_ < param3)
            {
               _loc5_ += "---+";
               _loc6_++;
            }
            _loc7_ = "";
            _loc8_ = "";
            _loc9_ = typeof param1[_loc4_];
            switch(_loc9_)
            {
               case "string":
                  _loc7_ = "\"";
                  _loc8_ = "\"";
                  break;
               case "object":
                  _loc7_ = "[";
                  _loc8_ = "]";
            }
            trace(_loc5_ + " " + _loc4_ + ": " + _loc7_ + param1[_loc4_] + _loc8_ + " - " + _loc9_);
            if(param2 > 0)
            {
               traceObject(param1[_loc4_],param2 - 1,param3 + 1);
            }
         }
      }
      
      public static function getTraceObject(param1:Object, param2:Number = 0, param3:Number = 0) : String
      {
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc4_:String = "";
         if(typeof param1 == "string")
         {
            return param1 + "\n";
         }
         for(_loc5_ in param1)
         {
            _loc6_ = "}";
            _loc7_ = 0;
            while(_loc7_ < param3)
            {
               _loc6_ += "---+";
               _loc7_++;
            }
            _loc8_ = "";
            _loc9_ = "";
            _loc10_ = typeof param1[_loc5_];
            switch(_loc10_)
            {
               case "string":
                  _loc8_ = "\"";
                  _loc9_ = "\"";
                  break;
               case "object":
                  _loc8_ = "[";
                  _loc9_ = "]";
            }
            _loc4_ += _loc6_ + " " + _loc5_ + ": " + _loc8_ + param1[_loc5_] + _loc9_ + " - " + _loc10_ + "\n";
            if(param2 > 0)
            {
               _loc4_ += getTraceObject(param1[_loc5_],param2 - 1,param3 + 1);
            }
         }
         return _loc4_;
      }
      
      public static function getTextFormatFromObject(param1:Object) : TextFormat
      {
         var _loc3_:* = undefined;
         var _loc2_:TextFormat = new TextFormat();
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      public static function getNumberAsHexString(param1:uint, param2:uint = 1, param3:String = "0x") : String
      {
         var _loc4_:String = param1.toString(16).toUpperCase();
         while(param2 > _loc4_.length)
         {
            _loc4_ = "0" + _loc4_;
         }
         return param3 + _loc4_;
      }
      
      internal function utils() : *
      {
      }
   }
}

