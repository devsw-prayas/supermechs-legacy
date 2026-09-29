package net.tacticsoft.mobileOpt
{
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public dynamic class BMCachedSprite extends Sprite
   {
      
      public function BMCachedSprite()
      {
         super();
         if(false)
         {
            this["cacheAsBitmapMatrix"] = new Matrix();
            this.cacheAsBitmap = true;
         }
      }
   }
}

