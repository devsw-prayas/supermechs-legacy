package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectJumpJet extends BMBaseClass
   {
      
      private var _frameCountdown:uint = 0;
      
      private var _effectDeleted:Boolean = false;
      
      private var grp:MovieClip;
      
      public var holderMC:Sprite;
      
      public function BMEffectJumpJet()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:uint, param4:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.grp = externalAssetsM.getAsset("general","jumpJetAnimManual");
         this.grp.x = param1;
         this.grp.y = param2;
         this.holderMC = param4;
         this.holderMC.addChild(this.grp);
         this._frameCountdown = param3;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._effectDeleted)
         {
            return;
         }
         if(this._frameCountdown > 0)
         {
            if(this.grp.mcJet1.scaleX < 1)
            {
               this.grp.mcJet1.scaleX += 0.15;
               this.grp.mcJet1.scaleY += 0.15;
               this.grp.mcJet2.scaleX += 0.15;
               this.grp.mcJet2.scaleY += 0.15;
            }
            else
            {
               --this._frameCountdown;
            }
            return;
         }
         if(this.grp.mcJet1.scaleX > 0.2)
         {
            this.grp.mcJet1.scaleX -= 0.15;
            this.grp.mcJet1.scaleY -= 0.15;
            this.grp.mcJet2.scaleX -= 0.15;
            this.grp.mcJet2.scaleY -= 0.15;
            return;
         }
         this._effectDeleted = true;
         effectsM.setJumpJetForDeletion(param1);
      }
      
      public function removeMe() : void
      {
         if(this.grp.parent != null)
         {
            this.grp.parent.removeChild(this.grp);
         }
         this.grp = null;
      }
   }
}

