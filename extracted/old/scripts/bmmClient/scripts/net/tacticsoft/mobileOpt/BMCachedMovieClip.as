package net.tacticsoft.mobileOpt
{
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   
   public dynamic class BMCachedMovieClip extends MovieClip
   {
      
      public function BMCachedMovieClip()
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

