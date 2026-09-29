package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   
   public class BMFlyingKit extends BMBaseClass
   {
      
      public var holderMC:MovieClip;
      
      private var kit:MovieClip;
      
      private var frameCounter:Number;
      
      private var animationStage:String;
      
      private const FRAMES_STATIC:Number = 60;
      
      private const ALPHA_CHANGE_PER_FRAME:Number = 0.125;
      
      private const SCALE_CHANGE_PER_FRAME:Number = 0.1;
      
      public function BMFlyingKit()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.holderMC = param1;
         this.kit = param2;
         this.kit.x = -this.kit.width / 2;
         this.kit.y = -this.kit.height / 2;
         addChild(this.kit);
         this.frameCounter = 0;
         this.animationStage = "grow";
         scaleX = 0;
         scaleY = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         switch(this.animationStage)
         {
            case "grow":
               scaleX += this.SCALE_CHANGE_PER_FRAME;
               scaleY += this.SCALE_CHANGE_PER_FRAME;
               if(scaleX >= 0.5)
               {
                  scaleX = 0.5;
                  scaleY = 0.5;
                  this.animationStage = "static";
               }
               break;
            case "static":
               ++this.frameCounter;
               if(this.frameCounter > this.FRAMES_STATIC)
               {
                  this.animationStage = "shrink";
               }
               break;
            case "shrink":
               scaleX -= this.SCALE_CHANGE_PER_FRAME;
               scaleY -= this.SCALE_CHANGE_PER_FRAME;
               if(scaleX <= 0)
               {
                  scaleX = 0;
                  scaleY = 0;
                  effectsM.setFlyingKitForDeletion(param1);
               }
         }
      }
      
      public function removeMe() : void
      {
         removeChild(this.kit);
         this.kit = null;
      }
   }
}

