package skein.rest.core.coding
{
   public class JSONCoding
   {
      
      public function JSONCoding()
      {
         super();
      }
      
      public static function encode(param1:Object, param2:Function) : void
      {
         param2(JSON.stringify(param1));
      }
      
      public static function decode(param1:String, param2:Function) : void
      {
         var _loc3_:Object = null;
         _loc3_ = JSON.parse(param1);
         param2(_loc3_);
      }
   }
}

