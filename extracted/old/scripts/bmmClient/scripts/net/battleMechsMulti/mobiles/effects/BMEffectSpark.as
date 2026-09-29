package net.battleMechsMulti.mobiles.effects
{
   public class BMEffectSpark
   {
      
      public var screen:String;
      
      private var color:String;
      
      private var xPos:Number;
      
      private var yPos:Number;
      
      private var xSpeed:Number;
      
      private var ySpeed:Number;
      
      private var yAcc:Number;
      
      private var floorYPos:Number;
      
      private var framesToStart:Number;
      
      private var framesTotal:Number;
      
      private var reactsToFloor:Boolean;
      
      private var setForDeletionFunction:Function;
      
      public function BMEffectSpark()
      {
         super();
      }
      
      public function initialize(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Boolean, param13:Function) : void
      {
         this.screen = param1;
         this.color = param2;
         this.xPos = param4;
         this.yPos = param5;
         this.xSpeed = param6;
         this.ySpeed = param7;
         this.yAcc = param8;
         this.floorYPos = param9;
         this.framesToStart = param10;
         this.framesTotal = param11;
         this.reactsToFloor = param12;
         this.setForDeletionFunction = param13;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this.framesToStart > 0)
         {
            --this.framesToStart;
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
            if(this.framesTotal > 0)
            {
               --this.framesTotal;
            }
            else
            {
               this.setForDeletionFunction(param1);
            }
         }
      }
   }
}

