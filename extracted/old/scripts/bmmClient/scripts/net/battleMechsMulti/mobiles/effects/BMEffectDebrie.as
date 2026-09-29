package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectDebrie extends BMBaseClass
   {
      
      public var xSpeed:Number;
      
      public var ySpeed:Number;
      
      public var yAcc:Number;
      
      public var yDistanceFromFloor:Number;
      
      public var framesToStart:Number;
      
      public var framesTotal:Number;
      
      public var alphaOut:Boolean;
      
      public var holderMC:MovieClip;
      
      public var gfxMC:MovieClip;
      
      public function BMEffectDebrie()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Boolean, param11:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.gfxMC = externalAssetsM.getAsset("general",param1,param2,param2,false,false,false);
         this.gfxMC.rotation = param3;
         this.xSpeed = param4;
         this.ySpeed = param5;
         this.yAcc = param6;
         this.yDistanceFromFloor = param7;
         this.framesToStart = param8;
         this.framesTotal = param9;
         this.alphaOut = param10;
         this.holderMC = param11;
         addChild(this.gfxMC);
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this.framesToStart > 0)
         {
            --this.framesToStart;
         }
         else
         {
            if(this.framesToStart == 0 && parent == null)
            {
               this.holderMC.addChild(this);
            }
            if(this.yDistanceFromFloor == 0)
            {
               this.gfxMC.y += this.ySpeed;
            }
            else if(this.gfxMC.y + this.ySpeed >= this.yDistanceFromFloor)
            {
               this.gfxMC.y = this.yDistanceFromFloor;
               this.ySpeed *= -0.4;
               this.xSpeed *= 0.6;
            }
            this.gfxMC.x += this.xSpeed;
            this.gfxMC.y += this.ySpeed;
            this.ySpeed += this.yAcc;
            if(this.framesTotal > 0)
            {
               --this.framesTotal;
            }
            else
            {
               effectsM.setDebrieForDeletion(param1);
            }
         }
      }
      
      public function removeMe() : void
      {
         removeChild(this.gfxMC);
         this.gfxMC = null;
      }
   }
}

