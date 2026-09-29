package net.battleMechsMulti.mobiles
{
   import com.greensock.TimelineMax;
   import flash.display.MovieClip;
   
   public class BMLoadingIcon extends MovieClip
   {
      
      public var mcArrows:MovieClip;
      
      private var _timeLine:TimelineMax = new TimelineMax({
         "repeat":-1,
         "repeatDelay":0.5
      });
      
      public function BMLoadingIcon()
      {
         super();
         this._timeLine.to(this.mcArrows,1.5,{"rotation":360});
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(visible)
         {
            this._timeLine.play();
         }
         else
         {
            this._timeLine.stop();
         }
      }
   }
}

