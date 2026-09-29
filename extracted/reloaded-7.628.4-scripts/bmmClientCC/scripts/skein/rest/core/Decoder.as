package skein.rest.core
{
   import skein.rest.core.coding.DefaultCoding;
   import skein.rest.core.coding.JSONCoding;
   import skein.rest.core.coding.WWWFormCoding;
   
   public class Decoder
   {
      
      public function Decoder()
      {
         super();
      }
      
      public static function forType(param1:String) : Function
      {
         switch(param1)
         {
            case "application/json":
               return JSONCoding.decode;
            case "application/x-www-form-urlencoded":
               return WWWFormCoding.decode;
            default:
               return DefaultCoding.decode;
         }
      }
   }
}

