package libraries.uanalytics.tracker
{
   import flash.system.System;
   import flash.utils.describeType;
   
   public class HitType
   {
      
      public static const PAGEVIEW:String = "pageview";
      
      public static const SCREENVIEW:String = "screenview";
      
      public static const EVENT:String = "event";
      
      public static const TRANSACTION:String = "transaction";
      
      public static const ITEM:String = "item";
      
      public static const SOCIAL:String = "social";
      
      public static const EXCEPTION:String = "exception";
      
      public static const TIMING:String = "timing";
      
      public function HitType()
      {
         super();
      }
      
      public static function isValid(param1:String) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc2_:XML = describeType(HitType);
         var _loc3_:Boolean = false;
         for each(_loc5_ in _loc2_.constant)
         {
            _loc4_ = String(_loc5_.@name);
            if(HitType[_loc4_] == param1)
            {
               _loc3_ = true;
               break;
            }
         }
         System.disposeXML(_loc2_);
         if(_loc3_)
         {
            return true;
         }
         return false;
      }
   }
}

