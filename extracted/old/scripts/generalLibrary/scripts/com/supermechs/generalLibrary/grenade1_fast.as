package com.supermechs.generalLibrary
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1683")]
   public dynamic class grenade1_fast extends MovieClip
   {
      
      public function grenade1_fast()
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

