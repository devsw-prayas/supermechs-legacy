package net.battleMechsMulti.mobiles.itemProperties
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.managers.skills.BMMechStatsResolver;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol22")]
   public class BMItemPropertiesPanel extends BMBaseClass
   {
      
      private var _currentItemData:BMItemData;
      
      private var _upgardedItemData:BMItemData;
      
      private var _showNextVal:Boolean = true;
      
      private var _showOnlyDiff:Boolean = true;
      
      private var _propertiesPerLine:int = 2;
      
      private var _propetyViewCls:Class = BMDefaultItemProperty;
      
      private var _propertiesCounter:uint;
      
      private var propYJumpReduction:Number = 0;
      
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
         var _loc3_:Object = null;
         var _loc4_:PropertyToAddData = null;
         this.reset();
         this._propertiesCounter = 0;
         var _loc1_:Array = new Array();
         if(this.canShowProp("weight"))
         {
            _loc1_.push(new PropertyToAddData("icon_weight",this.getPropText("weight"),"weight"));
         }
         if(this.canShowProp("HPBase"))
         {
            _loc1_.push(new PropertyToAddData("icon_HP",this.getPropText("HP"),"HPBase"));
         }
         if(this.canShowProp("HPAddon") && this._currentItemData.HPAddon > 0)
         {
            _loc1_.push(new PropertyToAddData("icon_repair",this.getPropText("repair"),"HPAddon"));
         }
         if(this.canShowProp("damageBase","damageAddon"))
         {
            _loc3_ = this.getDamageTypeViewData(this._currentItemData.damageType);
            _loc1_.push(new PropertyToAddData(_loc3_.icon,this.getPropText(_loc3_.title),"damageBase","damageAddon"));
         }
         if(this.canShowProp("damageHeat"))
         {
            _loc1_.push(new PropertyToAddData("icon_damageType_explosivePlus",this.getPropText("heatDamage"),"damageHeat"));
         }
         if(this.canShowProp("damageHeatBase"))
         {
            _loc1_.push(new PropertyToAddData("icon_damageHeatBase",this.getPropText("damageHeatBase"),"damageHeatBase"));
         }
         if(this.canShowProp("damageHeatAddon"))
         {
            _loc1_.push(new PropertyToAddData("icon_damageHeatAddon",this.getPropText("damageHeatAddon"),"damageHeatAddon"));
         }
         if(this.canShowProp("damageEnergy"))
         {
            _loc1_.push(new PropertyToAddData("icon_damageType_electricPlus",this.getPropText("energyDamage"),"damageEnergy"));
         }
         if(this.canShowProp("damageEnergyBase"))
         {
            _loc1_.push(new PropertyToAddData("icon_damageEnergyBase",this.getPropText("damageEnergyBase"),"damageEnergyBase"));
         }
         if(this.canShowProp("damageEnergyAddon"))
         {
            _loc1_.push(new PropertyToAddData("icon_damageEnergyAddon",this.getPropText("damageEnergyAddon"),"damageEnergyAddon"));
         }
         if(this.canShowProp("energyBase"))
         {
            _loc1_.push(new PropertyToAddData("icon_energy",this.getPropText("energyCapacity"),"energyBase"));
         }
         if(this.canShowProp("energyAddon"))
         {
            _loc1_.push(new PropertyToAddData("icon_energyRegeneration",this.getPropText("energyRegeneration"),"energyAddon"));
         }
         if(this.canShowProp("heatBase"))
         {
            _loc1_.push(new PropertyToAddData("icon_heat",this.getPropText("heat"),"heatBase"));
         }
         if(this.canShowProp("heatAddon"))
         {
            _loc1_.push(new PropertyToAddData("icon_heatCooling",this.getPropText("heatCooling"),"heatAddon"));
         }
         if(this.canShowProp("resist1"))
         {
            if(this._currentItemData.isWeapon)
            {
               _loc1_.push(new PropertyToAddData("icon_damageResist_physical",this.getPropText("resist1Damage"),"resist1"));
            }
            else
            {
               _loc1_.push(new PropertyToAddData("icon_resist_physical",this.getPropText("resist1"),"resist1"));
            }
         }
         if(this.canShowProp("resist2"))
         {
            if(this._currentItemData.isWeapon)
            {
               _loc1_.push(new PropertyToAddData("icon_damageResist_explosive",this.getPropText("resist2Damage"),"resist2"));
            }
            else
            {
               _loc1_.push(new PropertyToAddData("icon_resist_explosive",this.getPropText("resist2"),"resist2"));
            }
         }
         if(this.canShowProp("resist3"))
         {
            if(this._currentItemData.isWeapon)
            {
               _loc1_.push(new PropertyToAddData("icon_damageResist_electric",this.getPropText("resist3Damage"),"resist3"));
            }
            else
            {
               _loc1_.push(new PropertyToAddData("icon_resist_electric",this.getPropText("resist3"),"resist3"));
            }
         }
         if(this.canShowProp("rangeBase","rangeAddon"))
         {
            _loc1_.push(new PropertyToAddData("icon_range",this.getPropText("range"),"rangeBase","rangeAddon"));
         }
         if(this.canShowProp("push"))
         {
            if(this._currentItemData.push > 0)
            {
               _loc1_.push(new PropertyToAddData("icon_push",this.getPropText("knockback"),"push"));
            }
            else
            {
               _loc1_.push(new PropertyToAddData("icon_pull",this.getPropText("pull"),"push"));
            }
         }
         if(this.canShowProp("pushSelf"))
         {
            if(this._currentItemData.pushSelf > 0)
            {
               if(this._currentItemData.isFireJumpWeapon)
               {
                  _loc1_.push(new PropertyToAddData("icon_pushSelf",this.getPropText("retreat"),"pushSelf"));
               }
               else
               {
                  _loc1_.push(new PropertyToAddData("icon_pushSelf",this.getPropText("recoil"),"pushSelf"));
               }
            }
            else
            {
               _loc1_.push(new PropertyToAddData("icon_pullSelf",this.getPropText("advance"),"pushSelf"));
            }
         }
         if(this.canShowProp("uses"))
         {
            _loc1_.push(new PropertyToAddData("icon_uses",this.getPropText("maxUses"),"uses"));
         }
         if(this._currentItemData.type != BMMechStructure.ENHANCER)
         {
            if(this.canShowProp("HPAddon") && this._currentItemData.HPAddon < 0)
            {
               _loc1_.push(new PropertyToAddData("icon_hpCost",this.getPropText("hpCost"),"HPAddon"));
            }
            if(this.canShowProp("costEnergy"))
            {
               _loc1_.push(new PropertyToAddData("icon_energy",this.getPropText("energyPerUse"),"costEnergy"));
            }
            if(this.canShowProp("costHeat"))
            {
               _loc1_.push(new PropertyToAddData("icon_heat",this.getPropText("heatPerUse"),"costHeat"));
            }
         }
         if(this.canShowProp("stepsPerWalk"))
         {
            _loc1_.push(new PropertyToAddData("icon_movement_walk",this.getPropText("stepsPerWalk"),"stepsPerWalk"));
         }
         if(this.canShowProp("stepsPerJump"))
         {
            _loc1_.push(new PropertyToAddData("icon_movement_jump",this.getPropText("stepsPerJump"),"stepsPerJump"));
         }
         if(this._currentItemData.type == "kit" && this.canShowProp("materialPowerContribution"))
         {
            _loc1_.push(new PropertyToAddData("icon_energy",this.getPropText("materialPowerContribution"),"materialPowerContribution","",true));
         }
         if(this.canShowProp("bullets"))
         {
            _loc1_.push(new PropertyToAddData("icon_bullets",this.getPropText("bulletsPerUse"),"bullets"));
         }
         if(this.canShowProp("rockets"))
         {
            _loc1_.push(new PropertyToAddData("icon_rockets",this.getPropText("rocketsPerUse"),"rockets"));
         }
         if(this.canShowProp("absorbRatio"))
         {
            if(this._currentItemData.energyPerBlock != 0)
            {
               _loc1_.push(new PropertyToAddData("icon_shieldBlock","% " + this.getPropText("maxDamageAbsorbed"),"absorbRatio","",true));
            }
            else
            {
               _loc1_.push(new PropertyToAddData("icon_shieldBlockHeat","% " + this.getPropText("maxDamageAbsorbed"),"absorbRatio","",true));
            }
         }
         if(this.canShowProp("energyPerBlock"))
         {
            _loc1_.push(new PropertyToAddData("icon_energy",this.getPropText("energyToBlock") + " <font color=\'#FFFFFF\'>" + this._currentItemData.HPPerBlock + "</font> " + this.getPropText("pointsOfDamage"),"energyPerBlock","",true));
         }
         if(this.canShowProp("heatPerBlock"))
         {
            _loc1_.push(new PropertyToAddData("icon_heat",this.getPropText("heatToBlock") + " <font color=\'#FFFFFF\'>" + this._currentItemData.HPPerBlock + "</font> " + this.getPropText("pointsOfDamage"),"heatPerBlock","",true));
         }
         if(this._currentItemData.isFireJumpWeapon)
         {
            _loc1_.push(new PropertyToAddData("",languageM.getText("workshop_jumpingRequired"),"","",false,0,false,false,PropertyToAddData.TYPE_MESSAGE));
         }
         if(_loc1_.length == 11)
         {
            this.propYJumpReduction = 3;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc2_];
            if(_loc4_.type == PropertyToAddData.TYPE_PROPERTY)
            {
               this.addItemProperty(_loc4_.assetName,_loc4_.title,_loc4_.name,_loc4_.addonName,_loc4_.isLongProperty,_loc4_.playerItemID,_loc4_.decimalValues,_loc4_.percentages);
            }
            else
            {
               this.addMessage(_loc4_.title);
            }
            _loc2_++;
         }
      }
      
      public function get propertiesCount() : uint
      {
         return this._propertiesCounter;
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
      
      private function addItemProperty(param1:String, param2:String, param3:String, param4:String = "", param5:Boolean = false, param6:uint = 0, param7:Boolean = false, param8:Boolean = false) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param3 == "displayPowerRating")
         {
            _loc9_ = dataM.myPlayerData.getItemDisplayPowerRating(this._currentItemData.itemID);
            _loc10_ = dataM.myPlayerData.getItemDisplayPowerRating(this._upgardedItemData.itemID);
         }
         else
         {
            _loc9_ = Math.abs(this._currentItemData[param3]);
            _loc10_ = Math.abs(this._upgardedItemData[param3]);
         }
         var _loc11_:Number = 0;
         var _loc12_:Number = 0;
         if(param4 != "")
         {
            _loc11_ = Math.abs(this._currentItemData[param4]);
            _loc12_ = Math.abs(this._upgardedItemData[param4]);
         }
         if(param3 == "rangeBase")
         {
            if(_loc9_ == 1 && _loc11_ == 999)
            {
               _loc11_ = 9;
            }
            if(_loc9_ > 0)
            {
               _loc9_ += 1;
               _loc10_ += 1;
               _loc11_--;
               _loc12_--;
            }
         }
         if(!this._showNextVal)
         {
            _loc10_ = 0;
         }
         var _loc13_:MovieClip = new this._propetyViewCls();
         IBMItemProperty(_loc13_).init(param1,param2,_loc9_,_loc10_,_loc11_,_loc12_,param5,param7,param8);
         this.addProperty(_loc13_);
      }
      
      private function addMessage(param1:String) : void
      {
         var _loc2_:MovieClip = new this._propetyViewCls();
         IBMItemProperty(_loc2_).initNameOnly(param1);
         this.addProperty(_loc2_);
      }
      
      private function addEmptyProperty() : void
      {
         var _loc1_:MovieClip = new this._propetyViewCls();
         _loc1_.visible = false;
         this.addProperty(_loc1_);
      }
      
      private function addProperty(param1:MovieClip) : void
      {
         ++this._propertiesCounter;
         var _loc2_:Number = param1.width;
         var _loc3_:Number = param1.height;
         if(param1.mcGeneralSizer != null)
         {
            _loc2_ = Number(param1.mcGeneralSizer.width);
            _loc3_ = Number(param1.mcGeneralSizer.height);
         }
         _loc3_ -= this.propYJumpReduction;
         param1.x = numChildren % this._propertiesPerLine * _loc2_;
         param1.y = Math.floor(numChildren / this._propertiesPerLine) * _loc3_;
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
         var _loc2_:int = 0;
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
            _loc2_ = _loc17_.HPBase;
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
         _loc3_ = BMMechStatsResolver.getEnergyBase(_loc3_,dataM.player1PlayerID);
         _loc4_ = BMMechStatsResolver.getEnergyAddon(_loc4_,dataM.player1PlayerID);
         _loc5_ = BMMechStatsResolver.getHeatBase(_loc5_,dataM.player1PlayerID);
         _loc6_ = BMMechStatsResolver.getHeatAddon(_loc6_,dataM.player1PlayerID);
         _loc9_ = BMMechStatsResolver.getResistance(1,_loc9_,dataM.player1PlayerID);
         _loc10_ = BMMechStatsResolver.getResistance(2,_loc10_,dataM.player1PlayerID);
         _loc11_ = BMMechStatsResolver.getResistance(3,_loc11_,dataM.player1PlayerID);
         _loc2_ = int(BMMechStatsResolver.getHPMax(_loc2_,dataM.player1PlayerID));
         if(_loc2_ > 0)
         {
            _loc2_ -= dataM.getOverloadHPPenaltyForWeight(param1.mechWeight);
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

class PropertyToAddData
{
   
   public static const TYPE_PROPERTY:String = "property";
   
   public static const TYPE_MESSAGE:String = "message";
   
   public var assetName:String;
   
   public var title:String;
   
   public var name:String;
   
   public var addonName:String;
   
   public var isLongProperty:Boolean;
   
   public var playerItemID:uint;
   
   public var decimalValues:Boolean;
   
   public var percentages:Boolean;
   
   public var type:String;
   
   public function PropertyToAddData(param1:String, param2:String, param3:String, param4:String = "", param5:Boolean = false, param6:uint = 0, param7:Boolean = false, param8:Boolean = false, param9:String = "property")
   {
      super();
      this.assetName = param1;
      this.title = param2;
      this.name = param3;
      this.addonName = param4;
      this.isLongProperty = param5;
      this.playerItemID = param6;
      this.decimalValues = param7;
      this.percentages = this.percentages;
      this.type = param9;
   }
}
