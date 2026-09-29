package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectTeleportReappear extends BMBaseClass
   {
      
      private var teleportMC:MovieClip;
      
      public var _holderMC:MovieClip;
      
      private var _frameCounter:Number;
      
      private var _scale:Number;
      
      public function BMEffectTeleportReappear()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.teleportMC = externalAssetsM.getAsset("general",param1);
         this._scale = param5;
         var _loc7_:Number = param4 / this.teleportMC.width;
         this.teleportMC.width *= _loc7_;
         this.teleportMC.height *= _loc7_;
         this.teleportMC.mcLight.scaleX = 1;
         this.teleportMC.mcLight.scaleY = 1;
         this.teleportMC.x = param2;
         this.teleportMC.y = param3;
         if(dataM.newVisualEffects)
         {
            this.teleportMC.mcBallA1.visible = false;
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
         }
         this._holderMC = param6;
         this._holderMC.addChild(this.teleportMC);
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._frameCounter >= 27)
         {
            effectsM.setTeleportReappearForDeletion(param1);
            return;
         }
         if(this._frameCounter < 8)
         {
            if(this._frameCounter == 1 && dataM.newVisualEffects)
            {
               effectsM.addAnimatedEffect("effect_teleport",this._holderMC,this.teleportMC.x,this.teleportMC.y,this._scale);
            }
            if(this._frameCounter < 7)
            {
               this.teleportMC.mcLight.scaleX -= 0.15;
               this.teleportMC.mcLight.scaleY -= 0.15;
            }
            else
            {
               this.teleportMC.mcLight.visible = false;
            }
         }
         else if(this._frameCounter < 17)
         {
            this.teleportMC["mcBallB" + (this._frameCounter - 7)].visible = false;
         }
         else if(this._frameCounter < 26)
         {
            this.teleportMC["mcBallC" + (this._frameCounter - 16)].visible = false;
         }
         else
         {
            this.teleportMC.mcBallA1.visible = false;
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

