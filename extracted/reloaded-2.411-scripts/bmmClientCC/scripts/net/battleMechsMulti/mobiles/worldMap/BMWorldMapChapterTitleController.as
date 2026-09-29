package net.battleMechsMulti.mobiles.worldMap
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BMWorldMapChapterTitleController
   {
      
      private static const ANIMATION_STATUS_NONE:uint = 0;
      
      private static const ANIMATION_STATUS_IN:uint = 1;
      
      private static const ANIMATION_STATUS_VISIBLE:uint = 2;
      
      private static const ANIMATION_STATUS_OUT:uint = 3;
      
      private var mcTitle:BMWorldMapChapterTitle;
      
      private var _holder:Sprite;
      
      private var _visibleYPos:Number;
      
      private var _hiddenYPos:Number;
      
      private var _hideDurationInSeconds:Number;
      
      private var _animationStatus:uint = 0;
      
      public function BMWorldMapChapterTitleController(param1:Sprite, param2:Number = 400, param3:Number = 20, param4:Number = -100)
      {
         super();
         this._holder = param1;
         this._visibleYPos = param3;
         this._hiddenYPos = param4;
         this.mcTitle = new BMWorldMapChapterTitle();
         this.mcTitle.x = param2;
         this.mcTitle.y = this._hiddenYPos;
      }
      
      public function showTitle(param1:String, param2:Number = 0) : void
      {
         this._hideDurationInSeconds = param2;
         this._animationStatus = ANIMATION_STATUS_IN;
         this.addTitle();
         this.mcTitle.setTitleText(param1);
         TweenMax.to(this.mcTitle,0.25,{
            "y":this._visibleYPos,
            "onComplete":this.showTitleComplete
         });
         this.mcTitle.addEventListener(MouseEvent.CLICK,this.titleClicked);
      }
      
      private function showTitleComplete() : void
      {
         this._animationStatus = ANIMATION_STATUS_VISIBLE;
         if(this._hideDurationInSeconds > 0)
         {
            TweenMax.to(this.mcTitle,this._hideDurationInSeconds,{"onComplete":this.hideTitle});
         }
      }
      
      private function hideTitle() : void
      {
         this._animationStatus = ANIMATION_STATUS_OUT;
         TweenMax.to(this.mcTitle,0.25,{
            "y":this._hiddenYPos,
            "onComplete":this.hideTitleComplete
         });
         this.mcTitle.removeEventListener(MouseEvent.CLICK,this.titleClicked);
      }
      
      private function hideTitleComplete() : void
      {
         this._animationStatus = ANIMATION_STATUS_NONE;
      }
      
      private function titleClicked(param1:MouseEvent) : void
      {
         this.hideTitle();
      }
      
      private function addTitle() : void
      {
         if(this.mcTitle.parent == null)
         {
            this._holder.addChild(this.mcTitle);
         }
      }
      
      public function clear() : void
      {
      }
   }
}

