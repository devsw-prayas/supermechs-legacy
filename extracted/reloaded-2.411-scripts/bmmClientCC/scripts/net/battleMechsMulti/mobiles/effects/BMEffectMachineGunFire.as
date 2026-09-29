package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectMachineGunFire extends BMBaseClass
   {
      
      public var holderMC:MovieClip;
      
      private var fireMC:MovieClip;
      
      private var _framesTotal:Number;
      
      private var _type:uint;
      
      public function BMEffectMachineGunFire()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:MovieClip, param3:uint, param4:Number) : void
      {
         generateSingletonClassesPointers("");
         this.holderMC = param1;
         this.fireMC = param2;
         this._type = param3;
         this._framesTotal = param4;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._framesTotal > 0)
         {
            switch(this._type)
            {
               case 1:
                  if(this._framesTotal % 2 == 0)
                  {
                     this.fireMC.mcGrp1.visible = true;
                     this.fireMC.mcGrp2.visible = false;
                  }
                  else
                  {
                     this.fireMC.mcGrp1.visible = false;
                     this.fireMC.mcGrp2.visible = true;
                  }
                  break;
               case 2:
                  if(this._framesTotal % 3 == 0)
                  {
                     this.fireMC.mcGrp1.visible = true;
                     this.fireMC.mcGrp2.visible = false;
                  }
                  else if(this._framesTotal % 3 == 1)
                  {
                     this.fireMC.mcGrp1.visible = false;
                     this.fireMC.mcGrp2.visible = true;
                  }
                  else
                  {
                     this.fireMC.mcGrp1.visible = false;
                     this.fireMC.mcGrp2.visible = false;
                  }
                  break;
               case 3:
                  if(this._framesTotal % 4 == 0)
                  {
                     this.fireMC.mcGrp1.visible = true;
                     this.fireMC.mcGrp2.visible = false;
                     this.fireMC.mcGrp3.visible = false;
                     this.fireMC.mcGrp4.visible = false;
                  }
                  else if(this._framesTotal % 4 == 1)
                  {
                     this.fireMC.mcGrp1.visible = false;
                     this.fireMC.mcGrp2.visible = true;
                     this.fireMC.mcGrp3.visible = false;
                     this.fireMC.mcGrp4.visible = false;
                  }
                  else if(this._framesTotal % 4 == 2)
                  {
                     this.fireMC.mcGrp1.visible = false;
                     this.fireMC.mcGrp2.visible = false;
                     this.fireMC.mcGrp3.visible = true;
                     this.fireMC.mcGrp4.visible = false;
                  }
                  else
                  {
                     this.fireMC.mcGrp1.visible = false;
                     this.fireMC.mcGrp2.visible = false;
                     this.fireMC.mcGrp3.visible = false;
                     this.fireMC.mcGrp4.visible = true;
                  }
            }
            --this._framesTotal;
         }
         else
         {
            effectsM.setMachineGunFireForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         this.fireMC.parent.removeChild(this.fireMC);
         this.fireMC = null;
      }
   }
}

