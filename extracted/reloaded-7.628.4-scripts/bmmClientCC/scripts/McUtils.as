package
{
   import flash.display.MovieClip;
   
   public class McUtils
   {
      
      public function McUtils()
      {
         super();
      }
      
      public static function resize(param1:MovieClip, param2:Number) : void
      {
         var _loc3_:Number = 1;
         if(param1.height < param1.width)
         {
            _loc3_ = param1.height / param1.width;
            param1.width = param2;
            param1.height = param2 * _loc3_;
         }
         else
         {
            _loc3_ = param1.width / param1.height;
            param1.width = param2 * _loc3_;
            param1.height = param2;
         }
      }
   }
}

