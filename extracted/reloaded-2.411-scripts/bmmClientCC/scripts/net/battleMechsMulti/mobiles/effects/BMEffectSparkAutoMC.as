package net.battleMechsMulti.mobiles.effects
{
   import flash.display.Sprite;
   
   public class BMEffectSparkAutoMC
   {
      
      public var screen:String;
      
      private var framesToStart:Number;
      
      private var framesCounter:Number;
      
      private var originXPos:Number;
      
      private var originYPos:Number;
      
      private var sparkMC:Sprite;
      
      private var setForDeletionFunction:Function;
      
      private var movementArray:Array = new Array();
      
      public function BMEffectSparkAutoMC()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Sprite, param4:Number, param5:Number, param6:Array, param7:Function) : void
      {
         this.screen = param1;
         this.framesToStart = param2;
         this.sparkMC = param3;
         this.originXPos = param4;
         this.originYPos = param5;
         this.movementArray = param6;
         this.setForDeletionFunction = param7;
         this.framesCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this.framesToStart > 0)
         {
            --this.framesToStart;
         }
         else if(this.framesCounter < this.movementArray.length)
         {
            this.sparkMC.x = this.originXPos + this.movementArray[this.framesCounter].xChange;
            this.sparkMC.y = this.originYPos + this.movementArray[this.framesCounter].yChange;
            ++this.framesCounter;
         }
         else
         {
            this.setForDeletionFunction(param1);
         }
      }
      
      public function removeMe() : void
      {
         if(this.sparkMC.parent != null)
         {
            this.sparkMC.parent.removeChild(this.sparkMC);
         }
      }
   }
}

