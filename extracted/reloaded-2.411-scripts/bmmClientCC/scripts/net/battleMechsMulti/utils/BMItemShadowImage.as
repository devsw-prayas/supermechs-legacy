package net.battleMechsMulti.utils
{
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   
   public class BMItemShadowImage
   {
      
      public function BMItemShadowImage()
      {
         super();
      }
      
      public static function createItemShadowImage(param1:MovieClip, param2:uint, param3:Boolean, param4:uint, param5:uint, param6:Boolean = false, param7:Boolean = false) : MovieClip
      {
         var _loc9_:Color = null;
         if(param3)
         {
            _loc9_ = new Color();
            _loc9_.setTint(param4,1);
            param1.transform.colorTransform = _loc9_;
         }
         if(param6)
         {
            param1.x = -param1.width / 2;
            param1.y = -param1.height / 2;
         }
         var _loc8_:MovieClip = new MovieClip();
         _loc8_.addChild(param1);
         _loc8_.filters = [new GlowFilter(param5,1,2,2,10,3,false,false)];
         return _loc8_;
      }
   }
}

