package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectTeleportDisappear extends BMBaseClass
   {
      
      private var teleportMC:MovieClip;
      
      private var _frameCounter:Number;
      
      private var _returnFunction:Function;
      
      private var _functionParams:Array;
      
      private var _holderMC:MovieClip;
      
      private var _scale:Number;
      
      public function BMEffectTeleportDisappear()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Function, param7:Array, param8:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.teleportMC = externalAssetsM.getAsset("general",param1);
         this._scale = param5;
         var _loc9_:Number = param4 / this.teleportMC.width;
         this.teleportMC.width *= _loc9_;
         this.teleportMC.height *= _loc9_;
         this.teleportMC.x = param2;
         this.teleportMC.y = param3;
         this.teleportMC.mcLight.visible = false;
         if(dataM.newVisualEffects)
         {
            this.teleportMC.mcBallA1.visible = false;
         }
         this.teleportMC.mcBallB1.visible = false;
         this.teleportMC.mcBallB2.visible = false;
         this.teleportMC.mcBallB3.visible = false;
         this.teleportMC.mcBallB4.visible = false;
         this.teleportMC.mcBallB5.visible = false;
         this.teleportMC.mcBallB6.visible = false;
         this.teleportMC.mcBallB7.visible = false;
         this.teleportMC.mcBallB8.visible = false;
         this.teleportMC.mcBallB9.visible = false;
         this.teleportMC.mcBallC1.visible = false;
         this.teleportMC.mcBallC2.visible = false;
         this.teleportMC.mcBallC3.visible = false;
         this.teleportMC.mcBallC4.visible = false;
         this.teleportMC.mcBallC5.visible = false;
         this.teleportMC.mcBallC6.visible = false;
         this.teleportMC.mcBallC7.visible = false;
         this.teleportMC.mcBallC8.visible = false;
         this.teleportMC.mcBallC9.visible = false;
         this._holderMC = param8;
         this._holderMC.addChild(this.teleportMC);
         this._returnFunction = param6;
         this._functionParams = param7;
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._frameCounter >= 35)
         {
            effectsM.setTeleportDisappearForDeletion(param1);
            return;
         }
         if(this._frameCounter == 25)
         {
            if(this._returnFunction != null)
            {
               if(this._functionParams != null)
               {
                  this._returnFunction(this._functionParams[0]);
               }
               else
               {
                  this._returnFunction();
               }
            }
         }
         if(this._frameCounter >= 1)
         {
            if(this._frameCounter < 10)
            {
               if(this._frameCounter == 1 && dataM.newVisualEffects)
               {
                  effectsM.addAnimatedEffect("effect_teleport",this._holderMC,this.teleportMC.x,this.teleportMC.y,this._scale);
               }
               if(dataM.newVisualEffects == false)
               {
                  this.teleportMC["mcBallB" + this._frameCounter].visible = true;
               }
            }
            else if(this._frameCounter < 19)
            {
               if(dataM.newVisualEffects == false)
               {
                  this.teleportMC["mcBallC" + (this._frameCounter - 9)].visible = true;
               }
            }
            else
            {
               if(this._frameCounter == 19)
               {
                  this.teleportMC.mcLight.visible = true;
               }
               if(this._frameCounter < 25)
               {
                  this.teleportMC.mcLight.scaleX += 0.17;
                  this.teleportMC.mcLight.scaleY += 0.17;
               }
               else
               {
                  this.teleportMC.mcLight.scaleX -= 0.1;
                  this.teleportMC.mcLight.scaleY -= 0.1;
               }
            }
         }
         ++this._frameCounter;
      }
      
      public function removeMe() : void
      {
         this.teleportMC.parent.removeChild(this.teleportMC);
         this.teleportMC = null;
      }
   }
}

