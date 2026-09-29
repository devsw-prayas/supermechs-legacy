package skein.rest.cache.response
{
   import flash.net.URLRequestHeader;
   
   public class Headers
   {
      
      public var eTag:ETag;
      
      public var expires:Expires;
      
      public var cacheControl:CacheControl;
      
      public var url:String;
      
      public function Headers()
      {
         super();
      }
      
      public static function valueOf(param1:Array) : Headers
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:URLRequestHeader = null;
         var _loc2_:Headers = new Headers();
         _loc3_ = 0;
         _loc5_ = int(param1 != null ? param1.length : 0);
         while(_loc3_ < _loc5_)
         {
            switch((_loc4_ = param1[_loc3_]).name)
            {
               case "ETag":
                  _loc2_.eTag = ETag.valueOf(_loc4_.value);
                  break;
               case "Expires":
                  _loc2_.expires = Expires.valueOf(_loc4_.value);
                  break;
               case "Cache-Control":
                  _loc2_.cacheControl = CacheControl.valueOf(_loc4_.value);
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

