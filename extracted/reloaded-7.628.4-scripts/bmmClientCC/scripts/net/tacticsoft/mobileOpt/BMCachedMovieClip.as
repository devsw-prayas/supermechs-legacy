package net.tacticsoft.mobileOpt
{
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   
   public dynamic class BMCachedMovieClip extends MovieClip
   {
      
      public function BMCachedMovieClip()
      {
         super();
         this["cacheAsBitmapMatrix"] = new Matrix();
         this.cacheAsBitmap = true;
      }
   }
}

