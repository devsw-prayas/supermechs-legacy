package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectOrbExplosion extends BMBaseClass
   {
      
      private var explosionMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var _frameCounter:Number;
      
      public function BMEffectOrbExplosion()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.explosionMC = externalAssetsM.getAsset("general","orbExplosion");
         this.explosionMC.x = param1;
         this.explosionMC.y = param2;
         this.holderMC = param3;
         this.holderMC.addChild(this.explosionMC);
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._frameCounter < 20)
         {
            if(this._frameCounter < 6)
            {
               if(this._frameCounter < 5)
               {
                  this.explosionMC.mcFlash.width -= 50;
                  this.explosionMC.mcFlash.height -= 50;
                  this.explosionMC.mcFlash.y -= 16;
               }
               else
               {
                  this.explosionMC.mcFlash.visible = false;
               }
            }
            if(this._frameCounter < 16)
            {
               if(this._frameCounter < 15)
               {
                  this.explosionMC.mcFireTail.y -= 2;
                  this.explosionMC.mcFireTail.scaleX -= 0.066;
                  this.explosionMC.mcFireTail.scaleY -= 0.066;
               }
               else
               {
                  this.explosionMC.mcFireTail.visible = false;
               }
            }
            if(this._frameCounter >= 15)
            {
               this.explosionMC.mcFire1.alpha -= 0.25;
               this.explosionMC.mcFire2.alpha -= 0.25;
               this.explosionMC.mcFire3.alpha -= 0.25;
            }
            this.explosionMC.mcFire1.rotation -= 0.5;
            this.explosionMC.mcFire2.rotation += 1.8;
            this.explosionMC.mcFire3.rotation -= 1.2;
            this.explosionMC.mcFire1.y -= 4.5;
            this.explosionMC.mcFire2.y -= 4.5;
            this.explosionMC.mcFire3.y -= 4.5;
            ++this._frameCounter;
         }
         else
         {
            effectsM.setOrbExplosionForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         this.explosionMC.parent.removeChild(this.explosionMC);
         this.explosionMC = null;
      }
   }
}

