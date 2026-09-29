package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectElectricity extends BMBaseClass
   {
      
      private var electricityEffectMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var _frameCounter:Number;
      
      public function BMEffectElectricity()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.electricityEffectMC = externalAssetsM.getAsset("general",param1);
         this.electricityEffectMC.rotation = Math.random() * 360;
         this.electricityEffectMC.x = param2;
         this.electricityEffectMC.y = param3;
         this.electricityEffectMC.mc2.visible = false;
         this.electricityEffectMC.mc3.visible = false;
         this.electricityEffectMC.mc4.visible = false;
         this.holderMC = param4;
         this.holderMC.addChild(this.electricityEffectMC);
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         switch(this._frameCounter)
         {
            case 2:
               this.electricityEffectMC.mc1.visible = false;
               this.electricityEffectMC.mc2.visible = true;
               break;
            case 3:
               this.electricityEffectMC.mc2.visible = false;
               this.electricityEffectMC.mc3.visible = true;
               break;
            case 4:
               this.electricityEffectMC.mc3.visible = false;
               this.electricityEffectMC.mc4.visible = true;
               break;
            case 5:
               effectsM.setElectricityForDeletion(param1);
         }
         ++this._frameCounter;
      }
      
      public function removeMe() : void
      {
         this.electricityEffectMC.parent.removeChild(this.electricityEffectMC);
         this.electricityEffectMC = null;
      }
   }
}

