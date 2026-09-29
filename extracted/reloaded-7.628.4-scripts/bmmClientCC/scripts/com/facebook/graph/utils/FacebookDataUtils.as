package com.facebook.graph.utils
{
   import flash.net.URLVariables;
   
   public class FacebookDataUtils
   {
      
      public function FacebookDataUtils()
      {
         super();
      }
      
      public static function stringToDate(param1:String) : Date
      {
         var _loc2_:Array = null;
         if(param1 == null)
         {
            return null;
         }
         if(/[^0-9]/g.test(param1) == false)
         {
            return new Date(parseInt(param1) * 1000);
         }
         if(/(\d\d)\/(\d\d)(\/\d+)?/ig.test(param1))
         {
            _loc2_ = param1.split("/");
            if(_loc2_.length == 3)
            {
               return new Date(_loc2_[2],Number(_loc2_[0]) - 1,_loc2_[1]);
            }
            return new Date(0,Number(_loc2_[0]) - 1,_loc2_[1]);
         }
         if(/\d{4}-\d\d-\d\d[\sT]\d\d:\d\d(:\d\d)?[\.\-Z\+]?(\d{0,4})?(\:)?(\-\d\d:)?/ig.test(param1))
         {
            return iso8601ToDate(param1);
         }
         return new Date(param1);
      }
      
      protected static function iso8601ToDate(param1:String) : Date
      {
         var _loc12_:int = 0;
         var _loc13_:Number = NaN;
         var _loc14_:String = null;
         var _loc15_:Number = NaN;
         var _loc2_:Array = param1.toUpperCase().split("T");
         var _loc3_:Array = _loc2_[0].split("-");
         var _loc4_:Array = _loc2_.length <= 1 ? [] : _loc2_[1].split(":");
         var _loc5_:uint = _loc3_[0] == "" ? 0 : uint(Number(_loc3_[0]));
         var _loc6_:uint = _loc3_[1] == "" ? 0 : uint(Number(_loc3_[1] - 1));
         var _loc7_:uint = _loc3_[2] == "" ? 1 : uint(Number(_loc3_[2]));
         var _loc8_:int = _loc4_[0] == "" ? 0 : int(Number(_loc4_[0]));
         var _loc9_:uint = _loc4_[1] == "" ? 0 : uint(Number(_loc4_[1]));
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         if(_loc4_[2] != null)
         {
            _loc12_ = int(_loc4_[2].length);
            if(_loc4_[2].indexOf("+") > -1)
            {
               _loc12_ = int(_loc4_[2].indexOf("+"));
            }
            else if(_loc4_[2].indexOf("-") > -1)
            {
               _loc12_ = int(_loc4_[2].indexOf("-"));
            }
            else if(_loc4_[2].indexOf("Z") > -1)
            {
               _loc12_ = int(_loc4_[2].indexOf("Z"));
            }
            if(!isNaN(_loc12_))
            {
               _loc13_ = Number(_loc4_[2].slice(0,_loc12_));
               _loc10_ = uint(_loc13_ << 0);
               _loc11_ = 1000 * (_loc13_ % 1 / 1);
            }
            if(_loc12_ != _loc4_[2].length)
            {
               _loc14_ = _loc4_[2].slice(_loc12_);
               _loc15_ = new Date(_loc5_,_loc6_,_loc7_).getTimezoneOffset() / 60;
               switch(_loc14_.charAt(0))
               {
                  case "+":
                  case "-":
                     _loc8_ -= _loc15_ + Number(_loc14_.slice(0));
                     break;
                  case "Z":
                     _loc8_ -= _loc15_;
               }
            }
         }
         return new Date(_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_);
      }
      
      public static function dateToUnixTimeStamp(param1:Date) : uint
      {
         return param1.time / 1000;
      }
      
      public static function flattenArray(param1:Array) : Array
      {
         if(param1 == null)
         {
            return [];
         }
         return FacebookDataUtils.internalFlattenArray(param1);
      }
      
      public static function getURLVariables(param1:String) : URLVariables
      {
         var _loc2_:String = null;
         if(param1.indexOf("#") != -1)
         {
            _loc2_ = param1.slice(param1.indexOf("#") + 1);
         }
         else if(param1.indexOf("?") != -1)
         {
            _loc2_ = param1.slice(param1.indexOf("?") + 1);
         }
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.decode(_loc2_);
         return _loc3_;
      }
      
      private static function internalFlattenArray(param1:Array, param2:Array = null) : Array
      {
         var _loc5_:Object = null;
         if(param2 == null)
         {
            param2 = [];
         }
         var _loc3_:uint = param1.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_ is Array)
            {
               FacebookDataUtils.internalFlattenArray(_loc5_ as Array,param2);
            }
            else
            {
               param2.push(_loc5_);
            }
            _loc4_++;
         }
         return param2;
      }
   }
}

