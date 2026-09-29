package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectFireEffect extends BMBaseClass
   {
      
      private var fireEffectMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var _xSpeed:uint;
      
      private var _effect1ScaleDifference:Number;
      
      private var _effect2ScaleDifference:Number;
      
      private var _flipModifier:Number;
      
      private var _frameCounter:Number;
      
      public function BMEffectFireEffect()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Boolean, param5:Number, param6:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this._xSpeed = 5;
         switch(int(param1.substr(param1.length - 1,1)))
         {
            case 2:
               this._xSpeed = 7;
               break;
            case 3:
               this._xSpeed = 9;
         }
         this.fireEffectMC = externalAssetsM.getAsset("general",param1);
         this._flipModifier = 1;
         if(param4)
         {
            this._flipModifier = -1;
         }
         else if(param5 != 0)
         {
            this.fireEffectMC.rotation = param5;
         }
         this._effect1ScaleDifference = this.fireEffectMC.mcEffect1.scaleX / 7;
         if(this.fireEffectMC.mcEffect2 != null)
         {
            this._effect2ScaleDifference = this.fireEffectMC.mcEffect2.scaleX / 4;
         }
         if(param4)
         {
            this.fireEffectMC.scaleX *= -1;
         }
         this.fireEffectMC.x = param2;
         this.fireEffectMC.y = param3;
         this.holderMC = param6;
         this.holderMC.addChild(this.fireEffectMC);
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._frameCounter < 7)
         {
            if(this.fireEffectMC.mcEffect2 != null)
            {
               if(this._frameCounter < 5)
               {
                  if(this._frameCounter < 4)
                  {
                     this.fireEffectMC.mcEffect2.scaleX -= this._effect2ScaleDifference;
                     this.fireEffectMC.mcEffect2.scaleY -= this._effect2ScaleDifference;
                  }
                  else
                  {
                     this.fireEffectMC.mcEffect2.visible = false;
                  }
               }
            }
            this.fireEffectMC.mcEffect1.x += this._xSpeed;
            this.fireEffectMC.mcEffect1.scaleX -= this._effect1ScaleDifference;
            this.fireEffectMC.mcEffect1.scaleY -= this._effect1ScaleDifference;
            if(this._frameCounter >= 4)
            {
               this.fireEffectMC.mcEffect1.alpha -= 0.25;
            }
            ++this._frameCounter;
         }
         else
         {
            effectsM.setFireEffectForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         this.fireEffectMC.parent.removeChild(this.fireEffectMC);
         this.fireEffectMC = null;
      }
   }
}

