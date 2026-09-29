package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectStompFire extends BMBaseClass
   {
      
      private var stompMC:Sprite;
      
      public var holderMC:MovieClip;
      
      private var _frameCounter:Number;
      
      private var _speed:uint;
      
      private var _deceleration:uint;
      
      private var _framesToStartShrinking:uint;
      
      private var _flipModifier:Number;
      
      public function BMEffectStompFire()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Boolean, param3:Number, param4:Number, param5:Number, param6:uint, param7:uint, param8:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.stompMC = externalAssetsM.getAsset("general",param1);
         this._flipModifier = 1;
         if(param2)
         {
            this._flipModifier = -1;
            this.stompMC.scaleX = -1;
         }
         this.stompMC.x = param3;
         this.stompMC.y = param4;
         this.holderMC = param8;
         this.holderMC.addChild(this.stompMC);
         this._speed = param5;
         this._deceleration = param6;
         this._framesToStartShrinking = param7;
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._frameCounter < this._framesToStartShrinking + 10)
         {
            if(this._frameCounter >= this._framesToStartShrinking)
            {
               this.stompMC.scaleX -= 0.1 * this._flipModifier;
               this.stompMC.scaleY -= 0.1;
            }
            this.stompMC.x += this._speed * this._flipModifier;
            this._speed -= this._deceleration;
            ++this._frameCounter;
         }
         else
         {
            effectsM.setStompFireForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         this.stompMC.parent.removeChild(this.stompMC);
         this.stompMC = null;
      }
   }
}

