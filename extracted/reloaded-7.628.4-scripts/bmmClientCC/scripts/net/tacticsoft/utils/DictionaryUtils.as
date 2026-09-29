package net.tacticsoft.utils
{
   import flash.utils.Dictionary;
   
   public class DictionaryUtils
   {
      
      public function DictionaryUtils()
      {
         super();
         throw Error("Don\'t instantiate");
      }
      
      public static function isEmpty(param1:Dictionary) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:* = param1;
         for(_loc2_ in _loc4_)
         {
            return false;
         }
         return true;
      }
   }
}

