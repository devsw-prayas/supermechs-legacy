package net.battleMechsMulti.mobiles.effects
{
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectShield extends BMBaseClass
   {
      
      private var _fast:Boolean;
      
      private var mcShield:Sprite;
      
      private var _direction:String;
      
      private var _frameCounter:uint = 0;
      
      private var _currentPhase:String;
      
      private var _staticFrames:uint;
      
      public var holderMC:Sprite;
      
      public function BMEffectShield()
      {
         super();
      }
      
      public function BMEffectBeamRound() : *
      {
      }
      
      public function initialize(param1:Sprite, param2:String, param3:String, param4:Boolean) : void
      {
         generateSingletonClassesPointers("");
         this.holderMC = param1;
         this._fast = param4;
         switch(param2)
         {
            case "red":
               switch(param3)
               {
                  case "top":
                     this.mcShield = externalAssetsM.getAsset("general","shieldAbsorbDamageTop_red",0,0,false,false,false);
                     break;
                  case "front":
                     this.mcShield = externalAssetsM.getAsset("general","shieldAbsorbDamage_red",0,0,false,false,false);
                     break;
                  case "back":
                     this.mcShield = externalAssetsM.getAsset("general","shieldAbsorbDamage_red",0,0,false,false,false);
                     this.mcShield.scaleX = -1;
               }
               break;
            case "blue":
               switch(param3)
               {
                  case "top":
                     this.mcShield = externalAssetsM.getAsset("general","shieldAbsorbDamageTop_blue",0,0,false,false,false);
                     break;
                  case "front":
                     this.mcShield = externalAssetsM.getAsset("general","shieldAbsorbDamage_blue",0,0,false,false,false);
                     break;
                  case "back":
                     this.mcShield = externalAssetsM.getAsset("general","shieldAbsorbDamage_blue",0,0,false,false,false);
                     this.mcShield.scaleX = -1;
               }
         }
         addChild(this.mcShield);
         this._currentPhase = "static";
         if(this._fast)
         {
            this._staticFrames = 15;
         }
         else
         {
            this._staticFrames = 35;
         }
      }
      
      public function runFrame(param1:uint) : void
      {
         switch(this._currentPhase)
         {
            case "static":
               ++this._frameCounter;
               if(this._frameCounter == this._staticFrames)
               {
                  this._currentPhase = "disappear";
               }
               break;
            case "disappear":
               this.mcShield.alpha -= 0.3;
               if(this.mcShield.alpha <= 0)
               {
                  effectsM.setShieldForDeletion(param1);
                  this.removeMe();
               }
         }
      }
      
      public function removeMe() : void
      {
         if(this.mcShield != null)
         {
            if(this.mcShield.parent != null)
            {
               this.mcShield.parent.removeChild(this.mcShield);
            }
            this.mcShield = null;
         }
      }
   }
}

