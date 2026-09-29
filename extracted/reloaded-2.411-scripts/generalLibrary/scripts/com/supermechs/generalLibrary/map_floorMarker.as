package com.supermechs.generalLibrary
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol365")]
   public dynamic class map_floorMarker extends MovieClip
   {
      
      public var mcMarker:MovieClip;
      
      public function map_floorMarker()
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

