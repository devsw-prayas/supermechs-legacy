package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectOrbTail extends BMBaseClass
   {
      
      public var holderMC:MovieClip;
      
      private var orbTailMC:MovieClip;
      
      private var _frameCounter:uint;
      
      public function BMEffectOrbTail()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:String, param3:Number, param4:Number) : void
      {
         generateSingletonClassesPointers("");
         this.orbTailMC = externalAssetsM.getAsset("general",param2);
         this.orbTailMC.x = param3;
         this.orbTailMC.y = param4;
         this.holderMC = param1;
         this.holderMC.addChild(this.orbTailMC);
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._frameCounter < 8)
         {
            this.orbTailMC.scaleX -= 0.12;
            this.orbTailMC.scaleY -= 0.12;
            ++this._frameCounter;
         }
         else
         {
            effectsM.setOrbTailForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         this.orbTailMC.parent.removeChild(this.orbTailMC);
         this.orbTailMC = null;
      }
   }
}

