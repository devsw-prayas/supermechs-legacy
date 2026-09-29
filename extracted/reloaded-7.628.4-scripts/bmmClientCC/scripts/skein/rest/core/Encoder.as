package skein.rest.core
{
   import skein.rest.core.coding.DefaultCoding;
   import skein.rest.core.coding.JSONCoding;
   import skein.rest.core.coding.MultipartFormCoding;
   import skein.rest.core.coding.WWWFormCoding;
   
   public class Encoder
   {
      
      public function Encoder()
      {
         super();
      }
      
      public static function forType(param1:String) : Function
      {
         switch(param1)
         {
            case "application/json":
               return JSONCoding.encode;
            case "application/x-www-form-urlencoded":
               return WWWFormCoding.encode;
            case "multipart/form-data":
               return MultipartFormCoding.encode;
            default:
               return DefaultCoding.encode;
         }
      }
   }
}

