package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5236")]
   public class BMFloorBuff extends BMBaseClass
   {
      
      public var mcLightAnim:MovieClip;
      
      public var mcMouseOver:Sprite;
      
      public var step:Number;
      
      public var type:String;
      
      public var subType:Number;
      
      public var buffAcive:Boolean = false;
      
      private var mcIcon:Sprite;
      
      public var mcIconHolder:MovieClip;
      
      public function BMFloorBuff()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:String, param3:Number) : void
      {
         generateSingletonClassesPointers("");
         this.step = param1;
         this.type = param2;
         this.subType = param3;
         var _loc4_:String = "";
         var _loc5_:String = this.type;
         switch(this.type)
         {
            case "damage":
               switch(this.subType)
               {
                  case 1:
                     _loc4_ = "icon_damageType_physical";
                     break;
                  case 2:
                     _loc4_ = "icon_damageType_explosive";
                     break;
                  case 3:
                     _loc4_ = "icon_damageType_electric";
               }
               _loc5_ += this.subType;
               break;
            case "damageHeat":
               _loc4_ = "icon_heat";
               break;
            case "damageEnergy":
               _loc4_ = "icon_energy";
               break;
            case "ignoreResistance":
               _loc4_ = "icon_resist_ignore";
               break;
            case "energyRegeneration":
               _loc4_ = "icon_energyRegeneration";
               break;
            case "heatCooling":
               _loc4_ = "icon_heatCooling";
               break;
            case "resistanceIncrease":
               _loc4_ = "icon_resist_all";
               break;
            case "resistanceDecrease":
               _loc4_ = "icon_resist_ignore";
               break;
            case "regenHP":
               _loc4_ = "icon_HP";
         }
         this.mcLightAnim.mcLight.gotoAndStop(_loc5_);
         if(_loc4_ != "")
         {
            this.mcIcon = externalAssetsM.getAsset("general",_loc4_,this.mcIconHolder.mcSizer_icon.width,this.mcIconHolder.mcSizer_icon.height,false,false);
            this.mcIcon.x = this.mcIconHolder.mcSizer_icon.x;
            this.mcIcon.y = this.mcIconHolder.mcSizer_icon.y;
            this.mcIconHolder.addChild(this.mcIcon);
         }
         this.mcLightAnim.parent.removeChild(this.mcLightAnim);
         this.mcLightAnim.x += screensM.screenBattle.FLOOR_STEP_SIZE * (this.step + 0.5);
         screensM.screenBattle.holder_effects.addChild(this.mcLightAnim);
         this.mcIconHolder.parent.removeChild(this.mcIconHolder);
         this.mcIconHolder.x += screensM.screenBattle.FLOOR_STEP_SIZE * (this.step + 0.5);
         screensM.screenBattle.holder_effects.addChild(this.mcIconHolder);
         this.deactivateMouseOverEffect();
      }
      
      public function activateMouseOverEffect() : void
      {
         if(this.mcMouseOver.parent == null)
         {
            addChild(this.mcMouseOver);
         }
      }
      
      public function deactivateMouseOverEffect() : void
      {
         if(this.mcMouseOver.parent != null)
         {
            removeChild(this.mcMouseOver);
         }
      }
      
      public function activateBuff() : void
      {
         if(this.buffAcive == false)
         {
            this.buffAcive = true;
            this.mcLightAnim.gotoAndPlay("active");
         }
      }
      
      public function deactivateBuff() : void
      {
         if(this.buffAcive)
         {
            this.buffAcive = false;
            this.mcLightAnim.gotoAndPlay("inactive");
         }
      }
      
      public function removeMe() : void
      {
         if(parent != null)
         {
            if(this.mcIcon != null)
            {
               if(this.mcIcon.parent != null)
               {
                  this.mcIcon.parent.removeChild(this.mcIcon);
               }
               this.mcIcon = null;
            }
            if(this.mcIconHolder != null)
            {
               if(this.mcIconHolder.parent != null)
               {
                  this.mcIconHolder.parent.removeChild(this.mcIconHolder);
               }
               this.mcIconHolder = null;
            }
            if(this.mcLightAnim.parent != null)
            {
               this.mcLightAnim.parent.removeChild(this.mcLightAnim);
               this.mcLightAnim = null;
            }
            if(this.mcMouseOver.parent != null)
            {
               removeChild(this.mcMouseOver);
               this.mcMouseOver = null;
            }
            parent.removeChild(this);
         }
      }
   }
}

