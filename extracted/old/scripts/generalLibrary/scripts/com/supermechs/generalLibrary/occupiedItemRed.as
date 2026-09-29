package com.supermechs.generalLibrary
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1142")]
   public dynamic class occupiedItemRed extends MovieClip
   {
      
      public function occupiedItemRed()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

