package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectMegaExplosion extends BMBaseClass
   {
      
      private var explosionMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var _frameCounter:Number;
      
      public function BMEffectMegaExplosion()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.explosionMC = externalAssetsM.getAsset("general","megaExplosion");
         this.explosionMC.x = param1;
         this.explosionMC.y = param2;
         this.holderMC = param3;
         this.holderMC.addChild(this.explosionMC);
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._frameCounter < 30)
         {
            if(this._frameCounter < 6)
            {
               if(this._frameCounter < 5)
               {
                  this.explosionMC.mcFlash.width -= 111;
                  this.explosionMC.mcFlash.height -= 111;
               }
               else
               {
                  this.explosionMC.mcFlash.visible = false;
               }
            }
            if(this._frameCounter < 25)
            {
               if(this._frameCounter < 24)
               {
                  this.explosionMC.mcFireTail.y -= 3.3;
                  this.explosionMC.mcFireTail.scaleX -= 0.033;
                  this.explosionMC.mcFireTail.scaleY -= 0.033;
               }
               else
               {
                  this.explosionMC.mcFireTail.visible = false;
               }
            }
            if(this._frameCounter >= 24)
            {
               this.explosionMC.mcFire1.alpha -= 0.17;
               this.explosionMC.mcFire2.alpha -= 0.17;
               this.explosionMC.mcFire3.alpha -= 0.17;
               this.explosionMC.mcFire4.alpha -= 0.17;
               this.explosionMC.mcFire5.alpha -= 0.17;
            }
            this.explosionMC.mcFire1.rotation -= 0.5;
            this.explosionMC.mcFire2.rotation += 1.8;
            this.explosionMC.mcFire3.rotation -= 1.2;
            this.explosionMC.mcFire4.rotation += 1;
            this.explosionMC.mcFire5.rotation += 0.9;
            this.explosionMC.mcFire1.y -= 4.5;
            this.explosionMC.mcFire2.y -= 4.5;
            this.explosionMC.mcFire3.y -= 4.5;
            this.explosionMC.mcFire4.y -= 4.5;
            this.explosionMC.mcFire5.y -= 4.5;
            ++this._frameCounter;
         }
         else
         {
            effectsM.setMegaExplosionForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         this.explosionMC.parent.removeChild(this.explosionMC);
         this.explosionMC = null;
      }
   }
}

