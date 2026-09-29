package skein.rest.cache.response
{
   import skein.rest.utils.DateUtil;
   
   public class Expires
   {
      
      public static const NAME:String = "Expires";
      
      public var date:Date;
      
      public function Expires()
      {
         super();
      }
      
      public static function valueOf(param1:String) : Expires
      {
         var _loc2_:Expires = new Expires();
         _loc2_.date = DateUtil.parseRFC822(param1);
         return _loc2_;
      }
   }
}

