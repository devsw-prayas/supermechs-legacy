package generalLibrary_fla
{
   import flash.display.MovieClip;
   
   [SWF(width="550", height="400", backgroundColor="#cccccc", frameRate="40")]
   public dynamic class MainTimeline extends MovieClip
   {
      
      public var _mochiads_game_id:String;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         this._mochiads_game_id = "f4c10c7d79496f81";
      }
   }
}

