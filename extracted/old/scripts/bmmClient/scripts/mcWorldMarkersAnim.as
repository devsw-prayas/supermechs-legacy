package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1676")]
   public dynamic class mcWorldMarkersAnim extends MovieClip
   {
      
      public function mcWorldMarkersAnim()
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

