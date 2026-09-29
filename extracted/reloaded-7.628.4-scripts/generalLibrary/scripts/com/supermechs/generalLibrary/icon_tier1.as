package com.supermechs.generalLibrary
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1905")]
   public dynamic class icon_tier1 extends MovieClip
   {
      
      public function icon_tier1()
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

