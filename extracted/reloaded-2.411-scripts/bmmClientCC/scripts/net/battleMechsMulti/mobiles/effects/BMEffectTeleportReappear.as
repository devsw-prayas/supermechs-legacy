package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectTeleportReappear extends BMBaseClass
   {
      
      private var teleportMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var _frameCounter:Number;
      
      public function BMEffectTeleportReappear()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Number, param5:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.teleportMC = externalAssetsM.getAsset("general",param1);
         var _loc6_:Number = param4 / this.teleportMC.width;
         this.teleportMC.width *= _loc6_;
         this.teleportMC.height *= _loc6_;
         this.teleportMC.mcLight.scaleX = 1;
         this.teleportMC.mcLight.scaleY = 1;
         this.teleportMC.x = param2;
         this.teleportMC.y = param3;
         this.holderMC = param5;
         this.holderMC.addChild(this.teleportMC);
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._frameCounter < 27)
         {
            if(this._frameCounter < 8)
            {
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
         else
         {
            effectsM.setTeleportReappearForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         this.teleportMC.parent.removeChild(this.teleportMC);
         this.teleportMC = null;
      }
   }
}

