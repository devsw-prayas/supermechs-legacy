package net.battleMechsMulti.mobiles.itemProperties
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol12")]
   public class BMItemPropertiesPanel extends BMBaseClass
   {
      
      private var _currentItemData:BMItemData;
      
      private var _upgardedItemData:BMItemData;
      
      private var _showNextVal:Boolean = true;
      
      private var _showOnlyDiff:Boolean = true;
      
      private var _propertiesPerLine:int = 2;
      
      private var _propetyViewCls:Class = BMDefaultItemProperty;
      
      public function BMItemPropertiesPanel()
      {
         super();
         generateSingletonClassesPointers("");
      }
      
      public function reset() : void
      {
         removeChildren();
      }
      
      public function show(param1:BMItemData) : void
      {
         this.showDifference(param1,param1,false);
      }
      
      public function showUpgradable(param1:BMItemData) : *
      {
         if(this._currentItemData != null && this._currentItemData.itemID == param1.itemID && this._showNextVal == false)
         {
            return;
         }
         this._showNextVal = false;
         this._currentItemData = param1;
         this._upgardedItemData = dataM.itemsDB[this._currentItemData.upgradeToItemID];
         this.refrash();
      }
      
      public function showDifference(param1:BMItemData, param2:BMItemData, param3:* = true) : void
      {
         if(this._currentItemData != null && this._currentItemData.itemID == param1.itemID && this._upgardedItemData != null && this._upgardedItemData.itemID == param2.itemID && this._showOnlyDiff == param3 && this._showNextVal == true)
         {
            return;
         }
         this._currentItemData = param1;
         this._upgardedItemData = param2;
         this._showNextVal = true;
         this._showOnlyDiff = param3;
         this.refrash();
      }
      
      private function canShowProp(param1:String, param2:String = "") : Boolean
      {
         if(this._showOnlyDiff)
         {
            if(this._currentItemData[param1] != this._upgardedItemData[param1])
            {
               return true;
            }
            if(param2 != "")
            {
               if(this._currentItemData[param2] != this._upgardedItemData[param2])
               {
                  return true;
               }
            }
            return false;
         }
         if(this._currentItemData[param1] != 0 || this._upgardedItemData[param1] != 0)
         {
            return true;
         }
         if(param2 != "")
         {
            if(this._currentItemData[param2] != 0 || this._upgardedItemData[param2] != 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private function refrash() : void
      {
         var _loc1_:Object = null;
         this.reset();
         if(this.canShowProp("weight"))
         {
            this.addItemProperty("icon_weight",this.getPropText("weight"),"weight");
         }
         if(this.canShowProp("HPBase"))
         {
            this.addItemProperty("icon_HP",this.getPropText("HP"),"HPBase");
         }
         if(this.canShowProp("HPAddon"))
         {
            this.addItemProperty("icon_repair",this.getPropText("repair"),"HPAddon");
         }
         if(this.canShowProp("damageBase","damageAddon"))
         {
            _loc1_ = this.getDamageTypeViewData(this._currentItemData.damageType);
            this.addItemProperty(_loc1_.icon,this.getPropText(_loc1_.title),"damageBase","damageAddon");
         }
         if(this.canShowProp("damageHeat"))
         {
            this.addItemProperty("icon_heat",this.getPropText("heatDamage"),"damageHeat");
         }
         if(this.canShowProp("damageEnergy"))
         {
            this.addItemProperty("icon_energy",this.getPropText("energyDamage"),"damageEnergy");
         }
         if(this.canShowProp("energyBase"))
         {
            this.addItemProperty("icon_energy",this.getPropText("energyCapacity"),"energyBase");
         }
         if(this.canShowProp("energyAddon"))
         {
            this.addItemProperty("icon_energyRegeneration",this.getPropText("energyRegeneration"),"energyAddon");
         }
         if(this.canShowProp("heatBase"))
         {
            this.addItemProperty("icon_heat",this.getPropText("heat"),"heatBase");
         }
         if(this.canShowProp("heatAddon"))
         {
            this.addItemProperty("icon_heatCooling",this.getPropText("heatCooling"),"heatAddon");
         }
         if(this.canShowProp("resist1"))
         {
            if(this._currentItemData.isWeapon)
            {
               this.addItemProperty("icon_damageResist_physical",this.getPropText("resist1Damage"),"resist1");
            }
            else
            {
               this.addItemProperty("icon_resist_physical",this.getPropText("resist1"),"resist1");
            }
         }
         if(this.canShowProp("resist2"))
         {
            if(this._currentItemData.isWeapon)
            {
               this.addItemProperty("icon_damageResist_explosive",this.getPropText("resist2Damage"),"resist2");
            }
            else
            {
               this.addItemProperty("icon_resist_explosive",this.getPropText("resist2"),"resist2");
            }
         }
         if(this.canShowProp("resist3"))
         {
            if(this._currentItemData.isWeapon)
            {
               this.addItemProperty("icon_damageResist_electric",this.getPropText("resist3Damage"),"resist3");
            }
            else
            {
               this.addItemProperty("icon_resist_electric",this.getPropText("resist3"),"resist3");
            }
         }
         if(this.canShowProp("rangeBase","rangeAddon"))
         {
            this.addItemProperty("icon_range",this.getPropText("range"),"rangeBase","rangeAddon");
         }
         if(this.canShowProp("push"))
         {
            if(this._currentItemData.push > 0)
            {
               this.addItemProperty("icon_push",this.getPropText("knockback"),"push");
            }
            else
            {
               this.addItemProperty("icon_pull",this.getPropText("pull"),"push");
            }
         }
         if(this.canShowProp("uses"))
         {
            this.addItemProperty("icon_uses",this.getPropText("maxUses"),"uses");
         }
         if(this.canShowProp("costEnergy"))
         {
            this.addItemProperty("icon_energy",this.getPropText("energyPerUse"),"costEnergy");
         }
         if(this.canShowProp("costHeat"))
         {
            this.addItemProperty("icon_heat",this.getPropText("heatPerUse"),"costHeat");
         }
         if(this.canShowProp("stepsPerWalk"))
         {
            this.addItemProperty("icon_movement_walk",this.getPropText("stepsPerWalk"),"stepsPerWalk");
         }
         if(this.canShowProp("stepsPerJump"))
         {
            this.addItemProperty("icon_movement_jump",this.getPropText("stepsPerJump"),"stepsPerJump");
         }
         if(this._currentItemData.type == "kit" && this.canShowProp("materialPowerContribution"))
         {
            this.addItemProperty("icon_energy",this.getPropText("materialPowerContribution"),"materialPowerContribution","",true);
         }
         if(this.canShowProp("bullets"))
         {
            this.addItemProperty("icon_bullets",this.getPropText("bulletsPerUse"),"bullets");
         }
         if(this.canShowProp("rockets"))
         {
            this.addItemProperty("icon_rockets",this.getPropText("rocketsPerUse"),"rockets");
         }
         if(this.canShowProp("absorbRatio"))
         {
            if(this._currentItemData.energyPerBlock != 0)
            {
               this.addItemProperty("icon_shieldBlock","% " + this.getPropText("maxDamageAbsorbed"),"absorbRatio","",true);
            }
            else
            {
               this.addItemProperty("icon_shieldBlockHeat","% " + this.getPropText("maxDamageAbsorbed"),"absorbRatio","",true);
            }
         }
         if(this.canShowProp("energyPerBlock"))
         {
            this.addItemProperty("icon_energy",this.getPropText("energyToBlock") + " <font color=\'#FFFFFF\'>" + this._currentItemData.HPPerBlock + "</font> " + this.getPropText("pointsOfDamage"),"energyPerBlock","",true);
         }
         if(this.canShowProp("heatPerBlock"))
         {
            this.addItemProperty("icon_heat",this.getPropText("heatToBlock") + " <font color=\'#FFFFFF\'>" + this._currentItemData.HPPerBlock + "</font> " + this.getPropText("pointsOfDamage"),"heatPerBlock","",true);
         }
      }
      
      private function getDamageTypeViewData(param1:int) : Object
      {
         switch(param1)
         {
            case 1:
               return {
                  "icon":"icon_damageType_physical",
                  "title":"physicalDamage"
               };
            case 2:
               return {
                  "icon":"icon_damageType_explosive",
                  "title":"explosiveDamage"
               };
            case 3:
               return {
                  "icon":"icon_damageType_electric",
                  "title":"electricDamage"
               };
            default:
               return {
                  "icon":"icon_damageType_physical",
                  "title":"Pys dmg"
               };
         }
      }
      
      public function getPropText(param1:String) : String
      {
         return getSpecificText("tooltip_" + param1);
      }
      
      private function addItemProperty(param1:String, param2:String, param3:String, param4:String = "", param5:Boolean = false) : void
      {
         var _loc6_:Number = Math.abs(this._currentItemData[param3]);
         var _loc7_:Number = Math.abs(this._upgardedItemData[param3]);
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         if(param4 != "")
         {
            _loc8_ = Math.abs(this._currentItemData[param4]);
            _loc9_ = Math.abs(this._upgardedItemData[param4]);
         }
         if(!this._showNextVal)
         {
            _loc7_ = 0;
         }
         var _loc10_:MovieClip = new this._propetyViewCls();
         IBMItemProperty(_loc10_).init(param1,param2,_loc6_,_loc7_,_loc8_,_loc9_,param5);
         this.addProperty(_loc10_);
      }
      
      private function addEmptyProperty() : void
      {
         var _loc1_:MovieClip = new this._propetyViewCls();
         _loc1_.visible = false;
         this.addProperty(_loc1_);
      }
      
      private function addProperty(param1:MovieClip) : void
      {
         param1.x = numChildren % this._propertiesPerLine * param1.width;
         param1.y = Math.floor(numChildren / this._propertiesPerLine) * param1.height;
         addChild(param1);
      }
      
      public function get propertiesPerLine() : int
      {
         return this._propertiesPerLine;
      }
      
      public function set propertiesPerLine(param1:int) : void
      {
         this._propertiesPerLine = param1;
      }
      
      public function get propetyViewCls() : Class
      {
         return this._propetyViewCls;
      }
      
      public function set propetyViewCls(param1:Class) : void
      {
         this._propetyViewCls = param1;
      }
      
      public function showMech(param1:BMMechStructure) : *
      {
         var _loc14_:BMPlayerItemData = null;
         var _loc15_:BMItemData = null;
         var _loc17_:BMItemData = null;
         var _loc18_:BMItemData = null;
         this._currentItemData = null;
         this._upgardedItemData = null;
         this.reset();
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         var _loc11_:Number = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         if(param1.torso > 0)
         {
            _loc14_ = dataM.getPlayerItemData(dataM.player1PlayerID,param1.torso);
            _loc17_ = dataM.itemsDB[_loc14_.itemID];
            _loc2_ = uint(_loc17_.HPBase);
            _loc3_ = uint(_loc17_.energyBase);
            _loc4_ = uint(_loc17_.energyAddon);
            _loc5_ = uint(_loc17_.heatBase);
            _loc6_ = uint(_loc17_.heatAddon);
            _loc7_ = uint(_loc17_.bullets);
            _loc8_ = uint(_loc17_.rockets);
            _loc9_ = _loc17_.resist1;
            _loc10_ = _loc17_.resist2;
            _loc11_ = _loc17_.resist3;
         }
         if(param1.leg > 0)
         {
            _loc14_ = dataM.getPlayerItemData(dataM.player1PlayerID,param1.leg);
            _loc15_ = dataM.itemsDB[_loc14_.itemID];
            _loc2_ += _loc15_.HPBase;
            _loc12_ = uint(_loc15_.stepsPerWalk);
            _loc13_ = uint(_loc15_.stepsPerJump);
         }
         var _loc16_:uint = 1;
         while(_loc16_ <= dataM.maxEquipment["module"])
         {
            if(param1["module" + _loc16_] > 0)
            {
               _loc14_ = dataM.getPlayerItemData(dataM.player1PlayerID,param1["module" + _loc16_]);
               _loc18_ = dataM.itemsDB[_loc14_.itemID];
               _loc2_ += _loc18_.HPBase;
               _loc3_ += _loc18_.energyBase;
               _loc4_ += _loc18_.energyAddon;
               _loc5_ += _loc18_.heatBase;
               _loc6_ += _loc18_.heatAddon;
               _loc7_ += _loc18_.bullets;
               _loc8_ += _loc18_.rockets;
               _loc9_ += _loc18_.resist1;
               _loc10_ += _loc18_.resist2;
               _loc11_ += _loc18_.resist3;
            }
            _loc16_++;
         }
         if(_loc2_ > 0)
         {
            this.addMechProperty("icon_HP",this.getPropText("HP"),_loc2_);
         }
         if(_loc3_ > 0)
         {
            this.addMechProperty("icon_energy",this.getPropText("energyCapacity"),_loc3_);
         }
         if(_loc4_ > 0)
         {
            this.addMechProperty("icon_energyRegeneration",this.getPropText("energyRegeneration"),_loc4_);
         }
         if(_loc5_ > 0)
         {
            this.addMechProperty("icon_heat",this.getPropText("heat"),_loc5_);
         }
         if(_loc6_ > 0)
         {
            this.addMechProperty("icon_heatCooling",this.getPropText("heatCooling"),_loc6_);
         }
         if(_loc7_ > 0)
         {
            this.addMechProperty("icon_bullets",this.getPropText("bulletsCapacity"),_loc7_);
         }
         if(_loc8_ > 0)
         {
            this.addMechProperty("icon_rockets",this.getPropText("rocketsCapacity"),_loc8_);
         }
         if(_loc9_ != 0)
         {
            this.addMechProperty("icon_resist_physical",this.getPropText("resist1"),_loc9_);
         }
         if(_loc10_ != 0)
         {
            this.addMechProperty("icon_resist_explosive",this.getPropText("resist2"),_loc10_);
         }
         if(_loc11_ != 0)
         {
            this.addMechProperty("icon_resist_electric",this.getPropText("resist3"),_loc11_);
         }
         if(_loc12_ > 0)
         {
            this.addMechProperty("icon_movement_walk",this.getPropText("stepsPerWalk"),_loc12_);
         }
         if(_loc13_ > 0)
         {
            this.addMechProperty("icon_movement_jump",this.getPropText("stepsPerJump"),_loc13_);
         }
      }
      
      private function addMechProperty(param1:String, param2:String, param3:Number) : *
      {
         var _loc4_:MovieClip = new this.propetyViewCls();
         IBMItemProperty(_loc4_).init(param1,param2,param3,0,0,0,false);
         this.addProperty(_loc4_);
      }
   }
}

