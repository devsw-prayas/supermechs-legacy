package net.battleMechsMulti.mobiles.baseMapAssets
{
   import flash.display.MovieClip;
   
   public class BMBaseMapDamageFloor
   {
      
      public var row:uint;
      
      public var column:uint;
      
      private var _cooldownFramesMax:uint;
      
      private var _cooldownFramesLeft:uint;
      
      private var _damageFramesMax:uint;
      
      private var _damageFramesLeft:uint = 0;
      
      private var _delayFrames:uint;
      
      public var grp:MovieClip;
      
      public function BMBaseMapDamageFloor()
      {
         super();
      }
      
      public function initialize(param1:uint, param2:uint, param3:uint, param4:uint, param5:MovieClip, param6:uint = 0) : void
      {
         this.row = param1;
         this.column = param2;
         this._cooldownFramesMax = param3;
         this._cooldownFramesLeft = this._cooldownFramesMax;
         this._damageFramesMax = param4;
         this._delayFrames = param6;
         this.grp = param5;
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._delayFrames > 0)
         {
            --this._delayFrames;
            return;
         }
         if(this._cooldownFramesLeft > 0)
         {
            --this._cooldownFramesLeft;
            if(this._cooldownFramesLeft == 0)
            {
               this._damageFramesLeft = this._damageFramesMax;
            }
         }
         else if(this._damageFramesLeft > 0)
         {
            --this._damageFramesLeft;
            if(this._damageFramesLeft == 0)
            {
               this._cooldownFramesLeft = this._cooldownFramesMax;
            }
         }
         if(this.isDealingDamage)
         {
            this.setEffectFrame(10);
            return;
         }
         var _loc1_:uint = Math.ceil((this._cooldownFramesMax - this._cooldownFramesLeft) / this._cooldownFramesMax * 16);
         if(_loc1_ > 8)
         {
            this.setEffectFrame(_loc1_ - 8);
         }
         else if(this.grp.mcFire.currentFrame > 1)
         {
            this.setEffectFrame(this.grp.mcFire.currentFrame - 1);
         }
         else
         {
            this.setEffectFrame(1);
         }
      }
      
      private function setEffectFrame(param1:uint) : void
      {
         if(this.grp.mcFire.currentFrame != param1)
         {
            this.grp.mcFire.gotoAndStop(param1);
         }
      }
      
      public function get isDealingDamage() : Boolean
      {
         return this._damageFramesLeft > 0;
      }
      
      public function get isFirstDamageFrame() : Boolean
      {
         return this._damageFramesLeft == this._damageFramesMax;
      }
   }
}

