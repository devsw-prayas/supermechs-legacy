package skein.utils
{
   public class StringUtil
   {
      
      public function StringUtil()
      {
         super();
      }
      
      public static function substitute(param1:String, ... rest) : String
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return "";
         }
         var _loc4_:uint = uint(rest.length);
         if(_loc4_ == 1 && rest[0] is Array)
         {
            _loc3_ = rest[0] as Array;
            _loc4_ = _loc3_.length;
         }
         else
         {
            _loc3_ = rest;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            param1 = param1.replace(new RegExp("\\{" + _loc5_ + "\\}","g"),_loc3_[_loc5_]);
            _loc5_++;
         }
         return param1;
      }
      
      public static function substituteWithArguments(param1:String, param2:StringSubstituteArguments) : String
      {
         return substitute(param1,param2.value);
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:int = 0;
         while(isWhitespace(param1.charAt(_loc2_)))
         {
            _loc2_++;
         }
         var _loc3_:int = param1.length - 1;
         while(isWhitespace(param1.charAt(_loc3_)))
         {
            _loc3_--;
         }
         if(_loc3_ >= _loc2_)
         {
            return param1.slice(_loc2_,_loc3_ + 1);
         }
         return "";
      }
      
      public static function isWhitespace(param1:String) : Boolean
      {
         switch(param1)
         {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
               break;
            default:
               return false;
         }
         return true;
      }
   }
}

