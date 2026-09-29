package net.battleMechsMulti.mobiles.effects
{
   import flash.display.Sprite;
   
   public class BMEffectEnergyChargeSparkMC
   {
      
      private var targetXPos:Number;
      
      private var targetYPos:Number;
      
      private var xPos:Number;
      
      private var yPos:Number;
      
      private var speed:Number;
      
      private var motionAngle:Number;
      
      private var framesToStart:Number;
      
      private var sparkMC:Sprite;
      
      private var movementData:Array;
      
      public var screen:String;
      
      private var movementDataImport:Array;
      
      private var movementDataImportSlot:uint = 0;
      
      private var movementDataExport:Array = new Array();
      
      internal var distance:Number;
      
      private var setForDeletionFunction:Function;
      
      private var exportMovementFunction:Function;
      
      public function BMEffectEnergyChargeSparkMC()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Sprite, param10:Function, param11:Function, param12:Array) : void
      {
         this.screen = param1;
         this.targetXPos = param2;
         this.targetYPos = param3;
         this.xPos = param4;
         this.yPos = param5;
         this.speed = param6;
         this.motionAngle = param7;
         this.motionAngle = param7;
         this.framesToStart = param8;
         this.movementDataImport = param12;
         this.sparkMC = param9;
         this.sparkMC.scaleX = 0.1;
         this.sparkMC.scaleY = 0.1;
         this.setForDeletionFunction = param10;
         this.exportMovementFunction = param11;
         this.distance = this.getVectorSize(this.targetXPos - this.xPos,this.targetYPos - this.yPos);
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this.framesToStart > 0)
         {
            --this.framesToStart;
         }
         else if(this.movementDataImport != null)
         {
            if(this.movementDataImportSlot >= this.movementDataImport.length)
            {
               this.setForDeletionFunction(param1);
            }
            else
            {
               this.sparkMC.x = this.targetXPos + this.movementDataImport[this.movementDataImportSlot].xChange;
               this.sparkMC.y = this.targetYPos + this.movementDataImport[this.movementDataImportSlot].yChange;
               this.sparkMC.scaleX = this.movementDataImport[this.movementDataImportSlot].scale;
               this.sparkMC.scaleY = this.movementDataImport[this.movementDataImportSlot].scale;
               ++this.movementDataImportSlot;
            }
         }
         else if(this.distance <= 0)
         {
            if(this.exportMovementFunction != null)
            {
               this.exportMovementFunction(this.movementDataExport);
            }
            this.setForDeletionFunction(param1);
         }
         else
         {
            this.xPos = this.targetXPos - this.getVectorSizeOnXAxis(this.distance,this.motionAngle);
            this.yPos = this.targetYPos - this.getVectorSizeOnYAxis(this.distance,this.motionAngle);
            this.sparkMC.x = this.xPos;
            this.sparkMC.y = this.yPos;
            if(this.sparkMC.scaleX < 1)
            {
               this.sparkMC.scaleX += 0.2;
               this.sparkMC.scaleY += 0.2;
               if(this.sparkMC.scaleX >= 1)
               {
                  this.sparkMC.scaleX = 1;
                  this.sparkMC.scaleY = 1;
               }
            }
            this.distance -= this.speed;
            if(this.distance < 0)
            {
               this.distance = 0;
            }
            if(this.exportMovementFunction != null)
            {
               this.movementDataExport.push({
                  "xChange":this.targetXPos - this.sparkMC.x,
                  "yChange":this.targetYPos - this.sparkMC.y,
                  "scale":this.sparkMC.scaleX
               });
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
      
      private function getVectorSize(param1:Number, param2:Number) : Number
      {
         return Math.sqrt(param1 * param1 + param2 * param2);
      }
      
      private function getVectorSizeOnXAxis(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param1 * Math.cos(param2 / 180 * Math.PI);
         if(Math.abs(_loc3_) < 0.0001)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      private function getVectorSizeOnYAxis(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param1 * Math.sin(param2 / 180 * Math.PI);
         if(Math.abs(_loc3_) < 0.0001)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
   }
}

