package net.battleMechsMulti.mobiles.pointersAndMarkers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class BMTutorialArrowController extends MovieClip
   {
      
      private var mcArrow:Sprite;
      
      private var mcArrowHolder:Sprite;
      
      private var _tutorialArrowActive:Boolean = false;
      
      private var _tutorialArrowFrameCounter:uint;
      
      private var _tutorialArrowRemoveFrames:uint;
      
      private var _tutorialArrowDelayFrames:uint;
      
      private var _tutorialArrowPoint:Point;
      
      private var _tutorialArrowAngle:Number;
      
      public function BMTutorialArrowController(param1:Sprite)
      {
         super();
         this.mcArrow = param1;
         this.mcArrow.x = 0;
         this.mcArrow.y = 0;
         this.mcArrow.mouseEnabled = false;
         this.mcArrow.mouseChildren = false;
         if(this.mcArrow.parent != null)
         {
            this.mcArrow.parent.removeChild(this.mcArrow);
         }
         this.mcArrowHolder = new Sprite();
         this.mcArrowHolder.addChild(this.mcArrow);
      }
      
      private function removeArrowHolderFromStage() : void
      {
         if(this.mcArrowHolder.parent != null)
         {
            this.mcArrowHolder.parent.removeChild(this.mcArrowHolder);
         }
      }
      
      public function activateTutorialArrow(param1:MovieClip, param2:Number, param3:Number, param4:Number = 0, param5:uint = 0, param6:uint = 0) : void
      {
         this.removeArrowHolderFromStage();
         param1.addChild(this.mcArrowHolder);
         this._tutorialArrowPoint = new Point(param2,param3);
         this.mcArrowHolder.x = param2;
         this.mcArrowHolder.y = param3;
         this.mcArrowHolder.rotation = param4;
         this._tutorialArrowDelayFrames = param5;
         if(this._tutorialArrowDelayFrames == 0)
         {
            this.mcArrowHolder.visible = true;
         }
         this._tutorialArrowRemoveFrames = param6;
         this._tutorialArrowFrameCounter = 0;
         this._tutorialArrowActive = true;
      }
      
      public function deactivateTutorialArrow() : void
      {
         this._tutorialArrowActive = false;
         this.mcArrowHolder.visible = false;
         this.removeArrowHolderFromStage();
      }
      
      public function runFrame() : void
      {
         if(this._tutorialArrowActive)
         {
            if(this._tutorialArrowDelayFrames > 0)
            {
               --this._tutorialArrowDelayFrames;
               if(this._tutorialArrowDelayFrames == 0)
               {
                  this.mcArrowHolder.visible = true;
               }
            }
            else
            {
               ++this._tutorialArrowFrameCounter;
               if(this._tutorialArrowFrameCounter <= 10)
               {
                  this.mcArrow.x += 10 - this._tutorialArrowFrameCounter;
               }
               else if(this._tutorialArrowFrameCounter <= 20)
               {
                  this.mcArrow.x -= this._tutorialArrowFrameCounter - 10;
               }
               else
               {
                  this._tutorialArrowFrameCounter = 0;
                  this.mcArrow.x = 0;
               }
               if(this._tutorialArrowRemoveFrames > 0)
               {
                  --this._tutorialArrowRemoveFrames;
                  if(this._tutorialArrowRemoveFrames == 0)
                  {
                     this.deactivateTutorialArrow();
                  }
               }
            }
         }
      }
   }
}

