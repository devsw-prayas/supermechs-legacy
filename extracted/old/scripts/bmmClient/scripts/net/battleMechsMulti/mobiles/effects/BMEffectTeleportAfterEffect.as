package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectTeleportAfterEffect extends BMBaseClass
   {
      
      private var afterEffectMC:Sprite;
      
      public var holderMC:MovieClip;
      
      private var _fastMode:Boolean;
      
      private var _frameCounter:Number;
      
      public function BMEffectTeleportAfterEffect()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Boolean, param5:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.afterEffectMC = externalAssetsM.getAsset("general",param1);
         this.afterEffectMC.rotation = Math.random() * 360;
         this.afterEffectMC.x = param2;
         this.afterEffectMC.y = param3;
         this.holderMC = param5;
         this.holderMC.addChild(this.afterEffectMC);
         this._fastMode = param4;
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         var _loc2_:Boolean = false;
         if(this._fastMode)
         {
            if(this._frameCounter < 75)
            {
               this.afterEffectMC.alpha = (75 - this._frameCounter) / 75;
               this.afterEffectMC.scaleX = (150 - this._frameCounter) / 150;
               this.afterEffectMC.scaleY = (150 - this._frameCounter) / 150;
               ++this._frameCounter;
            }
            else
            {
               _loc2_ = true;
            }
         }
         else if(this._frameCounter < 150)
         {
            this.afterEffectMC.alpha = (150 - this._frameCounter) / 150;
            this.afterEffectMC.scaleX = (300 - this._frameCounter) / 300;
            this.afterEffectMC.scaleY = (300 - this._frameCounter) / 300;
            ++this._frameCounter;
         }
         else
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            effectsM.setTeleportAfterEffectForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         this.afterEffectMC.parent.removeChild(this.afterEffectMC);
         this.afterEffectMC = null;
      }
   }
}

