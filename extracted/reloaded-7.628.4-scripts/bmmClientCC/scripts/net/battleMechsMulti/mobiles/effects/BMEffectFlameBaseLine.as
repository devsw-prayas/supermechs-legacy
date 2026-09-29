package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectFlameBaseLine extends BMBaseClass
   {
      
      private var flameMC:Sprite;
      
      public var holderMC:MovieClip;
      
      private var _frameCounter:Number;
      
      private var _flipModifier:Number;
      
      private var _fastMode:Boolean;
      
      private var _flameWidth:uint;
      
      public function BMEffectFlameBaseLine()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Boolean, param3:uint, param4:Number, param5:Number, param6:Boolean, param7:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.flameMC = externalAssetsM.getAsset("general",param1);
         this._flipModifier = 1;
         if(param2)
         {
            this._flipModifier = -1;
         }
         this.flameMC.x = param4;
         this.flameMC.y = param5;
         this.holderMC = param7;
         this.holderMC.addChild(this.flameMC);
         this._flameWidth = param3;
         this._fastMode = param6;
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._fastMode)
         {
            if(this._frameCounter < 33)
            {
               if(this._frameCounter < 8)
               {
                  this.flameMC.x += this._flameWidth / 2 / 8 * this._flipModifier;
                  this.flameMC.width += this._flameWidth / 8;
               }
               else if(this._frameCounter >= 20)
               {
                  this.flameMC.x += this._flameWidth / 2 / 5 * this._flipModifier;
                  this.flameMC.width -= this._flameWidth / 5;
                  this.flameMC.alpha -= 0.2;
               }
               ++this._frameCounter;
            }
            else
            {
               this.flameMC.parent.removeChild(this.flameMC);
               this.flameMC = null;
               effectsM.setFlameBaseLineForDeletion(param1);
            }
         }
         else if(this._frameCounter < 45)
         {
            if(this._frameCounter < 15)
            {
               this.flameMC.x += this._flameWidth / 2 / 15 * this._flipModifier;
               this.flameMC.width += this._flameWidth / 15;
            }
            else if(this._frameCounter >= 35)
            {
               this.flameMC.x += this._flameWidth / 2 / 10 * this._flipModifier;
               this.flameMC.width -= this._flameWidth / 10;
               this.flameMC.alpha -= 0.1;
            }
            ++this._frameCounter;
         }
         else
         {
            effectsM.setFlameBaseLineForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         if(this.flameMC != null)
         {
            this.flameMC.parent.removeChild(this.flameMC);
            this.flameMC = null;
         }
      }
   }
}

