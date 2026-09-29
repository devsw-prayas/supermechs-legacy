package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectMegaExplosion extends BMBaseClass
   {
      
      private var explosionMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var _speedRatio:uint;
      
      private var _frameCounter:Number;
      
      public function BMEffectMegaExplosion()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:MovieClip, param4:Boolean = true, param5:Boolean = false, param6:Boolean = false) : void
      {
         generateSingletonClassesPointers("");
         if(param6)
         {
            this.explosionMC = externalAssetsM.getAsset("general","megaExplosionFalloutOnly");
         }
         else
         {
            this.explosionMC = externalAssetsM.getAsset("general","megaExplosion");
         }
         this.explosionMC.x = param1;
         this.explosionMC.y = param2;
         this._speedRatio = 2;
         if(param4)
         {
            this._speedRatio = 1;
         }
         if(param5 == false)
         {
            this.explosionMC.mcFallout.visible = false;
         }
         this.holderMC = param3;
         this.holderMC.addChild(this.explosionMC);
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._frameCounter >= 30 * this._speedRatio)
         {
            effectsM.setMegaExplosionForDeletion(param1);
            return;
         }
         if(this.explosionMC.mcFlash != null)
         {
            if(this._frameCounter < 6 * this._speedRatio)
            {
               if(this._frameCounter < 6 * this._speedRatio - 1)
               {
                  this.explosionMC.mcFlash.width -= 111 / this._speedRatio;
                  this.explosionMC.mcFlash.height -= 111 / this._speedRatio;
               }
               else
               {
                  this.explosionMC.mcFlash.visible = false;
               }
            }
         }
         if(this.explosionMC.mcFireTail != null)
         {
            if(this._frameCounter < 25 * this._speedRatio)
            {
               if(this._frameCounter < 25 * this._speedRatio - 1)
               {
                  this.explosionMC.mcFireTail.y -= 3.3 / this._speedRatio;
                  this.explosionMC.mcFireTail.scaleX -= 0.033 / this._speedRatio;
                  this.explosionMC.mcFireTail.scaleY -= 0.033 / this._speedRatio;
               }
               else
               {
                  this.explosionMC.mcFireTail.visible = false;
               }
            }
         }
         if(this.explosionMC.mcFire1 != null)
         {
            if(this._frameCounter >= 24 * this._speedRatio)
            {
               this.explosionMC.mcFire1.alpha -= 0.17 / this._speedRatio;
               this.explosionMC.mcFire2.alpha -= 0.17 / this._speedRatio;
               this.explosionMC.mcFire3.alpha -= 0.17 / this._speedRatio;
               this.explosionMC.mcFire4.alpha -= 0.17 / this._speedRatio;
               this.explosionMC.mcFire5.alpha -= 0.17 / this._speedRatio;
            }
         }
         if(this.explosionMC.mcFallout.visible)
         {
            this.explosionMC.mcFallout.scaleX -= 0.01 / this._speedRatio;
            this.explosionMC.mcFallout.scaleY -= 0.01 / this._speedRatio;
            if(this._frameCounter >= 24 * this._speedRatio)
            {
               this.explosionMC.mcFallout.alpha -= 0.17 / this._speedRatio;
            }
         }
         if(this.explosionMC.mcFire1 != null)
         {
            this.explosionMC.mcFire1.rotation -= 0.5 / this._speedRatio;
            this.explosionMC.mcFire2.rotation += 1.8 / this._speedRatio;
            this.explosionMC.mcFire3.rotation -= 1.2 / this._speedRatio;
            this.explosionMC.mcFire4.rotation += 1 / this._speedRatio;
            this.explosionMC.mcFire5.rotation += 0.9 / this._speedRatio;
            this.explosionMC.mcFire1.y -= 4.5 / this._speedRatio;
            this.explosionMC.mcFire2.y -= 4.5 / this._speedRatio;
            this.explosionMC.mcFire3.y -= 4.5 / this._speedRatio;
            this.explosionMC.mcFire4.y -= 4.5 / this._speedRatio;
            this.explosionMC.mcFire5.y -= 4.5 / this._speedRatio;
         }
         ++this._frameCounter;
      }
      
      public function removeMe() : void
      {
         this.explosionMC.parent.removeChild(this.explosionMC);
         this.explosionMC = null;
      }
   }
}

