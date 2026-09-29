package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectEnergyExplosion extends BMBaseClass
   {
      
      private var explosionMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var _speedRatio:uint;
      
      private var _frameCounter:Number;
      
      public function BMEffectEnergyExplosion()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:MovieClip, param4:Boolean = true, param5:Boolean = false) : void
      {
         generateSingletonClassesPointers("");
         this.explosionMC = externalAssetsM.getAsset("general","energyExplosion");
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
            effectsM.setEnergyExplosionForDeletion(param1);
            return;
         }
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
         if(this._frameCounter < 25 * this._speedRatio)
         {
            if(dataM.runAsMobile)
            {
               this.createElectricityEffect();
            }
            else
            {
               this.createElectricityEffect();
               this.createElectricityEffect();
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
         ++this._frameCounter;
      }
      
      private function createElectricityEffect() : void
      {
         var _loc1_:String = "electricity" + Math.ceil(Math.random() * 3);
         var _loc2_:Number = 1;
         var _loc3_:uint = 130;
         var _loc4_:Number = Math.random() * _loc3_ * 2 - _loc3_;
         if(dataM.newVisualEffects)
         {
            _loc2_ = 1 - 0.7 * Math.abs(_loc4_) / _loc3_;
         }
         var _loc5_:Number = this.explosionMC.x + _loc4_;
         var _loc6_:Number = this.explosionMC.y + Math.random() * 100;
         effectsM.createElectricity(_loc1_,_loc5_,_loc6_,this.holderMC,_loc2_);
      }
      
      public function removeMe() : void
      {
         this.explosionMC.parent.removeChild(this.explosionMC);
         this.explosionMC = null;
      }
   }
}

