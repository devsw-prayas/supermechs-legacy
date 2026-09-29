package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1233")]
   public dynamic class ScreenMainMenuPlatform extends MovieClip
   {
      
      public var mcMechPosition:MovieClip;
      
      public function ScreenMainMenuPlatform()
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

