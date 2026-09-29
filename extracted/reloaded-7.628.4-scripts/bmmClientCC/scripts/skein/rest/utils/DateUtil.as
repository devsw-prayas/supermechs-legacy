package skein.rest.utils
{
   public class DateUtil
   {
      
      private static var monthNamesShort:Array = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
      
      private static var monthNamesLong:Array = ["January","February","March","April","May","June","July","August","September","October","November","December"];
      
      private static var dayNamesShort:Array = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
      
      private static var dayNamesLong:Array = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
      
      public function DateUtil()
      {
         super();
      }
      
      public static function getShortMonthName(param1:Date) : String
      {
         return monthNamesShort[param1.getMonth()];
      }
      
      public static function getShortMonthIndex(param1:String) : int
      {
         return monthNamesShort.indexOf(param1);
      }
      
      public static function getFullMonthName(param1:Date) : String
      {
         return monthNamesLong[param1.getMonth()];
      }
      
      public static function getFullMonthIndex(param1:String) : int
      {
         return monthNamesLong.indexOf(param1);
      }
      
      public static function getShortDayName(param1:Date) : String
      {
         return dayNamesShort[param1.getDay()];
      }
      
      public static function getShortDayIndex(param1:String) : int
      {
         return dayNamesShort.indexOf(param1);
      }
      
      public static function getFullDayName(param1:Date) : String
      {
         return dayNamesLong[param1.getDay()];
      }
      
      public static function getFullDayIndex(param1:String) : int
      {
         return dayNamesLong.indexOf(param1);
      }
      
      public static function getShortYear(param1:Date) : String
      {
         var _loc2_:String = String(param1.getFullYear());
         if(_loc2_.length < 3)
         {
            return _loc2_;
         }
         return _loc2_.substr(_loc2_.length - 2);
      }
      
      public static function compareDates(param1:Date, param2:Date) : int
      {
         var _loc4_:Number = param1.getTime();
         var _loc3_:Number = param2.getTime();
         if(_loc4_ > _loc3_)
         {
            return -1;
         }
         if(_loc4_ < _loc3_)
         {
            return 1;
         }
         return 0;
      }
      
      public static function getShortHour(param1:Date) : int
      {
         var _loc2_:int = param1.hours;
         if(_loc2_ == 0 || _loc2_ == 12)
         {
            return 12;
         }
         if(_loc2_ > 12)
         {
            return _loc2_ - 12;
         }
         return _loc2_;
      }
      
      public static function getMonth(param1:Date) : String
      {
         var _loc2_:String = (param1.month + 1).toString();
         if(_loc2_.length == 1)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public static function getFullHour(param1:Date) : String
      {
         var _loc2_:String = param1.hours.toString();
         if(_loc2_.length == 1)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public static function getMinutes(param1:Date) : String
      {
         var _loc2_:String = param1.minutes.toString();
         if(_loc2_.length == 1)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public static function getSeconds(param1:Date) : String
      {
         var _loc2_:String = param1.seconds.toString();
         if(_loc2_.length == 1)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public static function getAMPM(param1:Date) : String
      {
         return param1.hours > 11 ? "PM" : "AM";
      }
      
      public static function parseRFC822(param1:String) : Date
      {
         var _loc4_:Date = null;
         var _loc17_:Array = null;
         var _loc18_:String = null;
         var _loc2_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc3_:Array = null;
         var _loc15_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc10_:String = null;
         var _loc7_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc6_:String = null;
         try
         {
            _loc17_ = param1.split(" ");
            _loc18_ = null;
            if(_loc17_[0].search(/\d/) == -1)
            {
               _loc18_ = _loc17_.shift().replace(/\W/,"");
            }
            _loc2_ = _loc17_.shift();
            _loc14_ = Number(DateUtil.getShortMonthIndex(_loc17_.shift()));
            _loc9_ = _loc17_.shift();
            _loc3_ = _loc17_.shift().split(":");
            _loc15_ = int(_loc3_.shift());
            _loc12_ = int(_loc3_.shift());
            _loc13_ = Number(_loc3_.length > 0 ? int(_loc3_.shift()) : 0);
            _loc5_ = Date.UTC(_loc9_,_loc14_,_loc2_,_loc15_,_loc12_,_loc13_,0);
            _loc10_ = _loc17_.shift();
            _loc7_ = 0;
            if(_loc10_.search(/\d/) == -1)
            {
               switch(_loc10_)
               {
                  case "UT":
                     _loc7_ = 0;
                     break;
                  case "UTC":
                     _loc7_ = 0;
                     break;
                  case "GMT":
                     _loc7_ = 0;
                     break;
                  case "EST":
                     _loc7_ = -18000000;
                     break;
                  case "EDT":
                     _loc7_ = -14400000;
                     break;
                  case "CST":
                     _loc7_ = -21600000;
                     break;
                  case "CDT":
                     _loc7_ = -18000000;
                     break;
                  case "MST":
                     _loc7_ = -25200000;
                     break;
                  case "MDT":
                     _loc7_ = -21600000;
                     break;
                  case "PST":
                     _loc7_ = -28800000;
                     break;
                  case "PDT":
                     _loc7_ = -25200000;
                     break;
                  case "Z":
                     _loc7_ = 0;
                     break;
                  case "A":
                     _loc7_ = -3600000;
                     break;
                  case "M":
                     _loc7_ = -43200000;
                     break;
                  case "N":
                     _loc7_ = 3600000;
                     break;
                  case "Y":
                     _loc7_ = 43200000;
                     break;
                  default:
                     _loc7_ = 0;
               }
            }
            else
            {
               _loc11_ = 1;
               _loc16_ = 0;
               _loc8_ = 0;
               if(_loc10_.length != 4)
               {
                  if(_loc10_.charAt(0) == "-")
                  {
                     _loc11_ = -1;
                  }
                  _loc10_ = _loc10_.substr(1,4);
               }
               _loc16_ = Number(_loc10_.substr(0,2));
               _loc8_ = Number(_loc10_.substr(2,2));
               _loc7_ = (_loc16_ * 3600000 + _loc8_ * 60000) * _loc11_;
            }
            _loc4_ = new Date(_loc5_ - _loc7_);
            if(_loc4_.toString() == "Invalid Date")
            {
               throw new Error("This date does not conform to RFC822.");
            }
         }
         catch(e:Error)
         {
            _loc6_ = "Unable to parse the string [" + param1 + "] into a date. ";
            _loc6_ = _loc6_ + ("The internal error was: " + e.toString());
            throw new Error(_loc6_);
         }
         return _loc4_;
      }
      
      public static function toRFC822(param1:Date) : String
      {
         var _loc2_:Number = param1.getUTCDate();
         var _loc3_:Number = param1.getUTCHours();
         var _loc5_:Number = param1.getUTCMinutes();
         var _loc4_:Number = param1.getUTCSeconds();
         var _loc6_:String = new String();
         _loc6_ = _loc6_ + dayNamesShort[param1.getUTCDay()];
         _loc6_ = _loc6_ + ", ";
         if(_loc2_ < 10)
         {
            _loc6_ += "0";
         }
         _loc6_ += _loc2_;
         _loc6_ = _loc6_ + " ";
         _loc6_ = _loc6_ + monthNamesShort[param1.getUTCMonth()];
         _loc6_ = _loc6_ + " ";
         _loc6_ = _loc6_ + param1.getUTCFullYear();
         _loc6_ = _loc6_ + " ";
         if(_loc3_ < 10)
         {
            _loc6_ += "0";
         }
         _loc6_ += _loc3_;
         _loc6_ = _loc6_ + ":";
         if(_loc5_ < 10)
         {
            _loc6_ += "0";
         }
         _loc6_ += _loc5_;
         _loc6_ = _loc6_ + ":";
         if(_loc4_ < 10)
         {
            _loc6_ += "0";
         }
         _loc6_ += _loc4_;
         return _loc6_ + " GMT";
      }
      
      public static function parseW3CDTF(param1:String) : Date
      {
         var _loc3_:Date = null;
         var _loc19_:int = 0;
         var _loc7_:String = null;
         var _loc13_:String = null;
         var _loc18_:Array = null;
         var _loc9_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc22_:String = null;
         var _loc21_:Array = null;
         var _loc17_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc15_:Array = null;
         var _loc14_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc6_:String = null;
         try
         {
            _loc19_ = param1.indexOf("T");
            _loc7_ = _loc19_ == -1 ? param1 : param1.substring(0,_loc19_);
            _loc13_ = _loc19_ == -1 ? "" : param1.substring(_loc19_ + 1,param1.length);
            _loc18_ = _loc7_.split("-");
            _loc9_ = _loc18_.shift();
            _loc16_ = _loc18_.shift();
            _loc2_ = _loc18_.shift();
            _loc11_ = 1;
            _loc20_ = 0;
            _loc5_ = 0;
            if(_loc13_.indexOf("Z") != -1)
            {
               _loc11_ = 1;
               _loc20_ = 0;
               _loc5_ = 0;
               _loc13_ = _loc13_.replace("Z","");
            }
            else if(_loc13_.indexOf("+") != -1)
            {
               _loc11_ = 1;
               _loc22_ = _loc13_.substring(_loc13_.indexOf("+") + 1,_loc13_.length);
               if(_loc22_.indexOf(":") == -1)
               {
                  _loc22_ = _loc22_.slice(0,2) + ":" + _loc22_.slice(2);
                  if(_loc22_.length == 3)
                  {
                     _loc22_ += "00";
                  }
               }
               _loc20_ = Number(_loc22_.substring(0,_loc22_.indexOf(":")));
               _loc5_ = Number(_loc22_.substring(_loc22_.indexOf(":") + 1,_loc22_.length));
               _loc13_ = _loc13_.substring(0,_loc13_.indexOf("+"));
            }
            else if(_loc13_.indexOf("-") != -1)
            {
               _loc11_ = -1;
               _loc22_ = _loc13_.substring(_loc13_.indexOf("-") + 1,_loc13_.length);
               if(_loc22_.indexOf(":") == -1)
               {
                  _loc22_ = _loc22_.slice(0,2) + ":" + _loc22_.slice(2);
                  if(_loc22_.length == 3)
                  {
                     _loc22_ += "00";
                  }
               }
               _loc20_ = Number(_loc22_.substring(0,_loc22_.indexOf(":")));
               _loc5_ = Number(_loc22_.substring(_loc22_.indexOf(":") + 1,_loc22_.length));
               _loc13_ = _loc13_.substring(0,_loc13_.indexOf("-"));
            }
            _loc21_ = _loc13_.split(":");
            _loc17_ = _loc21_.length > 0 ? Number(_loc21_.shift()) : 0;
            _loc12_ = _loc21_.length > 0 ? Number(_loc21_.shift()) : 0;
            _loc15_ = _loc21_.length > 0 ? String(_loc21_.shift()).split(".") : null;
            _loc14_ = _loc15_ != null && _loc15_.length > 0 ? Number(_loc15_.shift()) : 0;
            _loc4_ = _loc15_ != null && _loc15_.length > 0 ? Number(_loc15_.shift()) : 0;
            _loc10_ = Date.UTC(_loc9_,_loc16_ - 1,_loc2_,_loc17_,_loc12_,_loc14_,_loc4_);
            _loc8_ = (_loc20_ * 3600000 + _loc5_ * 60000) * _loc11_;
            _loc3_ = new Date(_loc10_ - _loc8_);
            if(_loc3_.toString() == "Invalid Date")
            {
               throw new Error("This date does not conform to W3CDTF.");
            }
         }
         catch(e:Error)
         {
            _loc6_ = "Unable to parse the string " + param1 + " into a date. ";
            _loc6_ = _loc6_ + ("The internal error was: " + e.toString());
            throw new Error(_loc6_);
         }
         return _loc3_;
      }
      
      public static function toW3CDTF(param1:Date, param2:Boolean = false, param3:Boolean = true) : String
      {
         var _loc13_:Number = NaN;
         var _loc11_:String = null;
         var _loc14_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:Number = param1.getDate();
         var _loc12_:Number = param1.getMonth();
         var _loc7_:Number = param1.getHours();
         var _loc8_:Number = param1.getMinutes();
         var _loc10_:Number = param1.getSeconds();
         var _loc5_:Number = param1.getMilliseconds();
         var _loc9_:String = new String();
         _loc9_ = _loc9_ + param1.getUTCFullYear();
         _loc9_ = _loc9_ + "-";
         if(_loc12_ + 1 < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ += _loc12_ + 1;
         _loc9_ = _loc9_ + "-";
         if(_loc4_ < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ += _loc4_;
         _loc9_ = _loc9_ + "T";
         if(_loc7_ < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ += _loc7_;
         _loc9_ = _loc9_ + ":";
         if(_loc8_ < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ += _loc8_;
         _loc9_ = _loc9_ + ":";
         if(_loc10_ < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ += _loc10_;
         if(param2 && _loc5_ > 0)
         {
            _loc9_ += ".";
            _loc9_ = _loc9_ + _loc5_;
         }
         if(param3)
         {
            _loc13_ = param1.getTimezoneOffset() / 60;
            _loc11_ = _loc13_ < 0 ? "+" : "-";
            _loc14_ = Math.abs(_loc13_);
            _loc6_ = Math.abs(_loc13_ - int(_loc13_)) * 60;
            _loc9_ += _loc11_;
            if(_loc14_ < 10)
            {
               _loc9_ += "0";
            }
            _loc9_ += _loc14_;
            _loc9_ = _loc9_ + ":";
            if(_loc6_ < 10)
            {
               _loc9_ += "0";
            }
            _loc9_ += _loc6_;
         }
         else
         {
            _loc9_ += "+00:00";
         }
         return _loc9_;
      }
      
      public static function makeMorning(param1:Date) : Date
      {
         var _loc2_:Date = new Date(param1.time);
         _loc2_.hours = 0;
         _loc2_.minutes = 0;
         _loc2_.seconds = 0;
         _loc2_.milliseconds = 0;
         return _loc2_;
      }
      
      public static function makeNight(param1:Date) : Date
      {
         var _loc2_:Date = new Date(param1.time);
         _loc2_.hours = 23;
         _loc2_.minutes = 59;
         _loc2_.seconds = 59;
         _loc2_.milliseconds = 999;
         return _loc2_;
      }
      
      public static function getUTCDate(param1:Date) : Date
      {
         var _loc3_:Date = new Date();
         var _loc2_:Number = param1.getTimezoneOffset() * 60 * 1000;
         _loc3_.setTime(param1.getTime() + _loc2_);
         return _loc3_;
      }
   }
}

