package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   
   public class BMEffectEnergyChargeCenter extends MovieClip
   {
      
      public var framesToStart:Number;
      
      public var framesToIncrease:Number;
      
      public var framesToDecrease:Number;
      
      private var mcEffect:MovieClip;
      
      private var setForDeletionFunction:Function;
      
      private var returnFunction:Function;
      
      private var originalWidth:Number;
      
      private var originalHeight:Number;
      
      private var increaseFrameCounter:Number;
      
      private var decreaseFrameCounter:Number;
      
      public function BMEffectEnergyChargeCenter()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:Number, param3:Number, param4:Number, param5:Function, param6:Function) : void
      {
         this.mcEffect = param1;
         this.framesToStart = param2;
         this.framesToIncrease = param3;
         this.framesToDecrease = param4;
         this.setForDeletionFunction = param5;
         this.returnFunction = param6;
         this.originalWidth = this.mcEffect.width;
         this.originalHeight = this.mcEffect.height;
         this.mcEffect.width = 0;
         this.mcEffect.height = 0;
         this.increaseFrameCounter = 0;
         this.decreaseFrameCounter = 0;
         addChild(this.mcEffect);
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this.framesToStart > 0)
         {
            --this.framesToStart;
         }
         else if(this.increaseFrameCounter < this.framesToIncrease)
         {
            ++this.increaseFrameCounter;
            this.mcEffect.width = this.originalWidth * (this.increaseFrameCounter / this.framesToIncrease);
            this.mcEffect.height = this.originalHeight * (this.increaseFrameCounter / this.framesToIncrease);
         }
         else if(this.decreaseFrameCounter < this.framesToDecrease)
         {
            ++this.decreaseFrameCounter;
            this.mcEffect.width = this.originalWidth * (1 - this.decreaseFrameCounter / this.framesToDecrease);
            this.mcEffect.height = this.originalHeight * (1 - this.decreaseFrameCounter / this.framesToDecrease);
         }
         else
         {
            this.setForDeletionFunction(param1);
            if(this.returnFunction != null)
            {
               this.returnFunction();
            }
         }
      }
      
      public function removeMe() : void
      {
         if(this.mcEffect.parent != null)
         {
            this.mcEffect.parent.removeChild(this.mcEffect);
            this.mcEffect = null;
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

