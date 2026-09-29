package skein.rest.cache.response
{
   public class CacheControl
   {
      
      public static const NAME:String = "Cache-Control";
      
      public static const CACHE_CONTROL_PUBLIC:String = "public";
      
      public static const CACHE_CONTROL_PRIVATE:String = "private";
      
      public static const CACHE_CONTROL_NO_CACHE:String = "no-cache";
      
      public static const CACHE_CONTROL_NO_STORE:String = "no-store";
      
      public static const CACHE_CONTROL_MUST_REVALIDATE:String = "must-revalidate";
      
      public static const CACHE_CONTROL_MAX_AGE:String = "max-age";
      
      public static const CACHE_CONTROL_NO_TRANSFORM:String = "no-transform";
      
      public var isPrivate:Boolean;
      
      public var isPublic:Boolean;
      
      public var noCache:Boolean;
      
      public var noStore:Boolean;
      
      public var noTransform:Boolean;
      
      public var mustRevalidate:Boolean;
      
      public var maxAge:Number;
      
      public var noCacheFields:Array;
      
      public var privateFields:Array;
      
      public function CacheControl()
      {
         super();
      }
      
      public static function valueOf(param1:String) : CacheControl
      {
         var _loc5_:String = null;
         var _loc9_:Object = null;
         var _loc10_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:CacheControl = new CacheControl();
         param1 = param1.replace(/\s*/g,"");
         var _loc6_:Object = {};
         while(true)
         {
            _loc7_ = param1.indexOf("=");
            if(_loc7_ == -1)
            {
               break;
            }
            _loc11_ = param1.lastIndexOf(",",_loc7_);
            _loc11_ = _loc11_ != -1 ? _loc11_ + 1 : 0;
            _loc5_ = param1.substring(_loc11_,_loc7_);
            if(param1.charAt(_loc7_ + 1) == "\"")
            {
               _loc3_ = _loc7_ + 1;
               _loc4_ = param1.indexOf("\"",_loc3_ + 1) + 1;
            }
            else
            {
               _loc3_ = _loc7_ + 1;
               _loc4_ = param1.indexOf(",",_loc7_);
               _loc4_ = _loc4_ != -1 ? _loc4_ : param1.length;
            }
            _loc9_ = param1.substring(_loc3_,_loc4_).replace(/"/g,"").split(",");
            _loc6_[_loc5_] = _loc9_;
            param1 = param1.replace(param1.substring(_loc11_,_loc4_),"");
         }
         for each(_loc5_ in param1.split(","))
         {
            if(_loc5_)
            {
               _loc6_[_loc5_] = true;
            }
         }
         _loc2_.isPublic = _loc6_["public"];
         _loc2_.isPrivate = _loc6_["private"];
         _loc2_.noCache = _loc6_["no-cache"];
         _loc2_.noStore = _loc6_["no-store"];
         _loc2_.noTransform = _loc6_["no-transform"];
         _loc2_.mustRevalidate = _loc6_["must-revalidate"];
         _loc2_.maxAge = _loc6_["max-age"];
         if(_loc6_["no-cache"] is Array)
         {
            _loc2_.noCacheFields = _loc6_["no-cache"];
         }
         if(_loc6_["private"] is Array)
         {
            _loc2_.privateFields = _loc6_["private"];
         }
         return _loc2_;
      }
   }
}

