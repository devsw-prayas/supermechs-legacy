package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectExplosion extends BMBaseClass
   {
      
      private var explosionMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var grp:String;
      
      private var delayFrames:Number;
      
      private var framesFullAlpha:Number;
      
      private var framesToAlphaOut:Number;
      
      private var size_initial:Number;
      
      private var size_addon:Number;
      
      private var rotationPerFrame:Number;
      
      private var frameCounter:Number;
      
      private var shrinkInsteadOfAlpha:Boolean = true;
      
      public function BMEffectExplosion()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.grp = param1;
         this.delayFrames = param2;
         this.framesFullAlpha = param3;
         this.framesToAlphaOut = param4;
         this.size_initial = param5;
         this.size_addon = param6;
         this.rotationPerFrame = param7;
         this.holderMC = param8;
         this.frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         if(this.frameCounter >= this.delayFrames)
         {
            if(this.frameCounter < this.delayFrames + this.framesFullAlpha)
            {
               if(this.frameCounter == this.delayFrames && parent == null)
               {
                  this.explosionMC = externalAssetsM.getAsset("general",this.grp,this.size_initial,this.size_initial,false,false,false);
                  addChild(this.explosionMC);
                  this.holderMC.addChild(this);
               }
            }
            else if(this.frameCounter < this.delayFrames + this.framesFullAlpha + this.framesToAlphaOut)
            {
               if(this.shrinkInsteadOfAlpha)
               {
                  _loc2_ = 1 - (this.frameCounter - this.delayFrames - this.framesFullAlpha) / this.framesToAlphaOut;
                  this.explosionMC.width *= _loc2_;
                  this.explosionMC.height *= _loc2_;
               }
               else
               {
                  this.explosionMC.alpha = 1 - (this.frameCounter - this.delayFrames - this.framesFullAlpha) / this.framesToAlphaOut;
               }
            }
            else
            {
               effectsM.setExplosionForDeletion(param1);
            }
            this.explosionMC.width += this.size_addon / this.framesFullAlpha;
            this.explosionMC.height += this.size_addon / this.framesFullAlpha;
            rotation += this.rotationPerFrame;
         }
         ++this.frameCounter;
      }
      
      public function removeMe() : void
      {
         if(this.explosionMC.parent != null)
         {
            this.explosionMC.parent.removeChild(this.explosionMC);
            this.explosionMC = null;
         }
      }
   }
}

