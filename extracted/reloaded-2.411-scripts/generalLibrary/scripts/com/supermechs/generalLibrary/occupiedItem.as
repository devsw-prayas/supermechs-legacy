package com.supermechs.generalLibrary
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1168")]
   public dynamic class occupiedItem extends MovieClip
   {
      
      public function occupiedItem()
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

