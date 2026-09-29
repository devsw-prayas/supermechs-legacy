package net.battleMechsMulti.screens.worldMap
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   
   public class BMWorldMapLocationPointer extends MovieClip
   {
      
      public static const DIRECTION_DEFAULT:String = "default";
      
      public static const DIRECTION_LEFT:String = "left";
      
      public static const DIRECTION_RIGHT:String = "right";
      
      public var mcHitArea:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcEnemyThumb:RaidEnemyThumb;
      
      public var mcCounter:TextHolder;
      
      private var _clickedCallback:Function;
      
      private var _isShowing:Boolean = false;
      
      private var _isHiding:Boolean = false;
      
      private const HIDE_TARGET_SCALE:Number = 0.05;
      
      public function BMWorldMapLocationPointer()
      {
         super();
      }
      
      public function initialize(param1:Function) : void
      {
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.mcHitArea.addEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
         this._clickedCallback = param1;
         this._isShowing = true;
         this.mcEnemyThumb.visible = false;
         this.mcCounter.visible = false;
      }
      
      public function setCounter(param1:uint) : void
      {
         this.mcCounter.text = param1.toString();
         this.mcCounter.visible = true;
      }
      
      public function setEnemyAvatar(param1:String, param2:uint, param3:uint = 1) : void
      {
         var _loc4_:uint = 1;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = true;
         this.mcEnemyThumb.initialize_avatarThumb(param1,param2,param3);
         this.mcEnemyThumb.visible = true;
      }
      
      public function setDirection(param1:String) : void
      {
         if(this.mcBackground.currentLabel == param1)
         {
            return;
         }
         this.mcBackground.gotoAndStop(param1);
      }
      
      public function showMe() : void
      {
         if(this._isShowing)
         {
            return;
         }
         this._isHiding = false;
         this._isShowing = true;
         visible = true;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.13,{
            "scaleX":1,
            "scaleY":1
         });
      }
      
      public function hideMe() : void
      {
         if(this._isHiding)
         {
            return;
         }
         this._isHiding = true;
         this._isShowing = false;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.13,{
            "scaleX":this.HIDE_TARGET_SCALE,
            "scaleY":this.HIDE_TARGET_SCALE,
            "onComplete":this.hideMeComplete
         });
      }
      
      private function hideMeComplete() : void
      {
         visible = false;
      }
      
      private function onHitAreaClicked(param1:MouseEvent) : void
      {
         if(this._isHiding)
         {
            return;
         }
         this._isHiding = true;
         this._isShowing = false;
         scaleX = this.HIDE_TARGET_SCALE;
         scaleY = this.HIDE_TARGET_SCALE;
         visible = false;
         this._clickedCallback();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this);
         this.mcHitArea.removeEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
      }
   }
}

