package skein.rest.cache.response
{
   public class ETag
   {
      
      public static const NAME:String = "ETag";
      
      public var value:String;
      
      public function ETag()
      {
         super();
      }
      
      public static function valueOf(param1:String) : ETag
      {
         var _loc2_:ETag = new ETag();
         _loc2_.value = param1;
         return _loc2_;
      }
   }
}

