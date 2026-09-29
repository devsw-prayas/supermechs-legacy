package com.supermechs.generalLibrary
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1733")]
   public dynamic class grenade2_fast extends MovieClip
   {
      
      public function grenade2_fast()
      {
         super();
         addFrameScript(15,this.frame16);
      }
      
      internal function frame16() : *
      {
         stop();
      }
   }
}

