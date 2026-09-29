package net.battleMechsMulti.mobiles.effects
{
   import flash.display.Sprite;
   
   public class BMEffectSparkMC
   {
      
      public var screen:String;
      
      private var type:String;
      
      private var originXPos:Number;
      
      private var originYPos:Number;
      
      private var xPos:Number;
      
      private var yPos:Number;
      
      private var xSpeed:Number;
      
      private var ySpeed:Number;
      
      private var yAcc:Number;
      
      private var floorYPos:Number;
      
      private var framesToStart:Number;
      
      private var framesTotal:Number;
      
      private var direction:String;
      
      private var reactsToFloor:Boolean;
      
      private var sparkMC:Sprite;
      
      private var motionData:Array = new Array();
      
      private var setForDeletionFunction:Function;
      
      private var exportDataFunction:Function;
      
      public function BMEffectSparkMC()
      {
         super();
      }
      
      public function initialize(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:String, param12:Boolean, param13:Sprite, param14:Function, param15:Function) : void
      {
         this.screen = param1;
         this.type = param2;
         this.originXPos = param3;
         this.originYPos = param4;
         this.xPos = param3;
         this.yPos = param4;
         this.xSpeed = param5;
         this.ySpeed = param6;
         this.yAcc = param7;
         this.floorYPos = param8;
         this.framesToStart = param9;
         this.framesTotal = param10;
         this.direction = param11;
         this.reactsToFloor = param12;
         this.sparkMC = param13;
         this.setForDeletionFunction = param14;
         this.exportDataFunction = param15;
         if(this.framesToStart > 0)
         {
            this.sparkMC.visible = false;
         }
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this.framesToStart > 0)
         {
            --this.framesToStart;
            if(this.framesToStart == 0)
            {
               this.sparkMC.visible = true;
            }
         }
         else
         {
            if(this.reactsToFloor && this.yPos + this.ySpeed >= this.floorYPos)
            {
               this.yPos = this.floorYPos;
               this.ySpeed *= -0.4;
               this.xSpeed *= 0.6;
            }
            this.xPos += this.xSpeed;
            this.yPos += this.ySpeed;
            this.ySpeed += this.yAcc;
            this.sparkMC.x = this.xPos;
            this.sparkMC.y = this.yPos;
            if(this.exportDataFunction != null)
            {
               this.motionData.push({
                  "xChange":this.sparkMC.x - this.originXPos,
                  "yChange":this.sparkMC.y - this.originYPos
               });
            }
            if(this.framesTotal > 0)
            {
               --this.framesTotal;
            }
            else
            {
               if(this.exportDataFunction != null)
               {
                  this.exportDataFunction(this.type,this.originYPos,this.direction,this.reactsToFloor,this.motionData);
               }
               this.setForDeletionFunction(param1);
            }
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

