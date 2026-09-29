package skein.rest.core.coding
{
   public class WWWFormCoding
   {
      
      public function WWWFormCoding()
      {
         super();
      }
      
      public static function encode(param1:Object, param2:Function) : void
      {
         var _loc4_:Array = [];
         if("toJSON" in param1)
         {
            param1 = param1.toJSON(undefined);
         }
         for(var _loc3_:String in param1)
         {
            _loc4_.push(_loc3_ + "=" + param1[_loc3_]);
         }
         param2(_loc4_.join("&"));
      }
      
      public static function decode(param1:String, param2:Function) : void
      {
         var _loc6_:Array = null;
         var _loc3_:Object = {};
         var _loc5_:Array = param1.split("&");
         for each(var _loc4_:String in _loc5_)
         {
            _loc6_ = _loc4_.split("=");
            _loc3_[_loc6_[0]] = _loc6_[1];
         }
         param2(_loc3_);
      }
   }
}

