package net.battleMechsMulti.screens
{
   import net.battleMechsMulti.mobiles.FrameRateTracker;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4161")]
   public class BMScreenFPSTracker extends BMBaseScreen
   {
      
      public var fpsTracker:FrameRateTracker;
      
      public function BMScreenFPSTracker()
      {
         super();
      }
      
      public function ScreenFPSTracker() : *
      {
      }
      
      public function initialize() : void
      {
         this.fpsTracker = new FrameRateTracker();
         this.fpsTracker.mouseChildren = false;
         this.fpsTracker.x = 480;
         this.fpsTracker.y = 7;
         addChild(this.fpsTracker);
      }
      
      public function getFPS() : Number
      {
         return this.fpsTracker.getAverageFPS();
      }
   }
}

