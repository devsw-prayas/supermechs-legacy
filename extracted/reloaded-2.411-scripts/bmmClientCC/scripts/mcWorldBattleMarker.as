package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1907")]
   public dynamic class mcWorldBattleMarker extends MovieClip
   {
      
      public var mcHitArea:MovieClip;
      
      public function mcWorldBattleMarker()
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

