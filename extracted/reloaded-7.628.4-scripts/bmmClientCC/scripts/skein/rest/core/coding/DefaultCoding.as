package skein.rest.core.coding
{
   public class DefaultCoding
   {
      
      public function DefaultCoding()
      {
         super();
      }
      
      public static function encode(param1:Object, param2:Function) : void
      {
         if(param2.length == 1)
         {
            param2(param1);
         }
         else
         {
            param2();
         }
      }
      
      public static function decode(param1:Object, param2:Function) : void
      {
         if(param2.length == 1)
         {
            param2(param1);
         }
         else
         {
            param2();
         }
      }
   }
}

