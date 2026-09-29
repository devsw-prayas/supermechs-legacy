package net.battleMechsMulti.screens.arenaShop
{
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   
   public class BMPlayerSkillData
   {
      
      public static const TYPE_ENERGY_BASE:String = "energyBase";
      
      public static const TYPE_ENERGY_ADDON:String = "energyAddon";
      
      public static const TYPE_HEAT_BASE:String = "heatBase";
      
      public static const TYPE_HEAT_ADDON:String = "heatAddon";
      
      public static const TYPE_DAMAGE_HEAT:String = "damageHeat";
      
      public static const TYPE_DAMAGE_ENERGY:String = "damageEnergy";
      
      public static const TYPE_DAMAGE_1:String = "damage1";
      
      public static const TYPE_DAMAGE_2:String = "damage2";
      
      public static const TYPE_DAMAGE_3:String = "damage3";
      
      public static const TYPE_RESIST_1:String = "resist1";
      
      public static const TYPE_RESIST_2:String = "resist2";
      
      public static const TYPE_RESIST_3:String = "resist3";
      
      public static const TYPE_BATTLE_CREDITS_MAX:String = "battleCreditsMax";
      
      public static const TYPE_BATTLE_CREDITS_REGEN:String = "battleCreditsRegen";
      
      public static const TYPE_HP_ADDON:String = "hpAddon";
      
      public static const TYPE_GOLD_PVP:String = "goldPVP";
      
      public static const TYPE_GOLD_CAMPAIGN:String = "goldCampaign";
      
      public static const TYPE_TITAN_DAMAGE:String = "titanDamage";
      
      public static const TYPE_HP_COST:String = "hpCost";
      
      public static const TYPE_FORTUNE_BOX:String = "fortuneBox";
      
      public static const TYPE_CLAN_COINS:String = "clanCoins";
      
      public static const TYPE_BASE_CRAFTING_COST:String = "baseCraftingCost";
      
      public static const TYPE_BASE_CRAFTING_TIME:String = "baseCraftingTime";
      
      public static const TYPE_BASE_UPGRADES_TIME:String = "baseUpgradesTime";
      
      private var _skillID:uint;
      
      private var _type:String;
      
      private var _levelBonus:Array;
      
      private var _levelsCost:Array;
      
      public function BMPlayerSkillData(param1:uint, param2:String, param3:Array, param4:Array)
      {
         super();
         this._skillID = param1;
         this._type = param2;
         this._levelBonus = param3;
         this._levelsCost = param4;
      }
      
      public static function getExternalIconName(param1:String) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case TYPE_ENERGY_BASE:
               _loc2_ = "icon_energy";
               break;
            case TYPE_ENERGY_ADDON:
               _loc2_ = "icon_energyRegeneration";
               break;
            case TYPE_HEAT_BASE:
               _loc2_ = "icon_heat";
               break;
            case TYPE_HEAT_ADDON:
               _loc2_ = "icon_heatCooling";
               break;
            case TYPE_DAMAGE_HEAT:
               _loc2_ = "icon_damageType_explosivePlus";
               break;
            case TYPE_DAMAGE_ENERGY:
               _loc2_ = "icon_damageType_electricPlus";
               break;
            case TYPE_DAMAGE_1:
               _loc2_ = "icon_damageType_physical";
               break;
            case TYPE_DAMAGE_2:
               _loc2_ = "icon_damageType_explosive";
               break;
            case TYPE_DAMAGE_3:
               _loc2_ = "icon_damageType_electric";
               break;
            case TYPE_RESIST_1:
               _loc2_ = "icon_resist_physical";
               break;
            case TYPE_RESIST_2:
               _loc2_ = "icon_resist_explosive";
               break;
            case TYPE_RESIST_3:
               _loc2_ = "icon_resist_electric";
               break;
            case TYPE_BATTLE_CREDITS_MAX:
               _loc2_ = "icon_battleCreditsMax";
               break;
            case TYPE_BATTLE_CREDITS_REGEN:
               _loc2_ = "icon_battleCreditsRegen";
               break;
            case TYPE_HP_ADDON:
               _loc2_ = "icon_hpAddon";
         }
         return _loc2_;
      }
      
      public static function getLocalIcon(param1:String) : Sprite
      {
         switch(param1)
         {
            case TYPE_GOLD_PVP:
               return new localIcon_arenaShop_goldPVP();
            case TYPE_GOLD_CAMPAIGN:
               return new localIcon_arenaShop_goldCampaign();
            case TYPE_TITAN_DAMAGE:
               return new localIcon_arenaShop_titanDamage();
            case TYPE_HP_COST:
               return new localIcon_arenaShop_hpCost();
            case TYPE_FORTUNE_BOX:
               return new localIcon_arenaShop_fortuneBox();
            case TYPE_CLAN_COINS:
               return new localIcon_arenaShop_clanCoins();
            case TYPE_BASE_CRAFTING_COST:
               return new localIcon_arenaShop_baseCraftingCost();
            case TYPE_BASE_CRAFTING_TIME:
               return new localIcon_arenaShop_baseCraftingTime();
            case TYPE_BASE_UPGRADES_TIME:
               return new localIcon_arenaShop_baseUpgradesTime();
            default:
               return new Sprite();
         }
      }
      
      public static function isLocalIcon(param1:String) : Boolean
      {
         switch(param1)
         {
            case TYPE_GOLD_PVP:
            case TYPE_GOLD_CAMPAIGN:
            case TYPE_TITAN_DAMAGE:
            case TYPE_HP_COST:
            case TYPE_FORTUNE_BOX:
            case TYPE_CLAN_COINS:
            case TYPE_BASE_CRAFTING_COST:
            case TYPE_BASE_CRAFTING_TIME:
            case TYPE_BASE_UPGRADES_TIME:
               return true;
            default:
               return false;
         }
      }
      
      public static function isBaseBuildingSkill(param1:String) : Boolean
      {
         switch(param1)
         {
            case TYPE_BASE_CRAFTING_COST:
            case TYPE_BASE_CRAFTING_TIME:
            case TYPE_BASE_UPGRADES_TIME:
               return true;
            default:
               return false;
         }
      }
      
      public static function isReductionSkill(param1:String) : Boolean
      {
         switch(param1)
         {
            case TYPE_HP_COST:
            case TYPE_BASE_CRAFTING_COST:
            case TYPE_BASE_CRAFTING_TIME:
            case TYPE_BASE_UPGRADES_TIME:
               return true;
            default:
               return false;
         }
      }
      
      public static function isRewardInQueueSkill(param1:String) : Boolean
      {
         if(param1 == TYPE_FORTUNE_BOX)
         {
            return true;
         }
         return false;
      }
      
      public function get skillID() : uint
      {
         return this._skillID;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get levelBonus() : Array
      {
         return this._levelBonus;
      }
      
      public function get levelsCost() : Array
      {
         return this._levelsCost;
      }
      
      public function get levelsTotal() : uint
      {
         return this._levelsCost.length;
      }
      
      public function get isEnabled() : Boolean
      {
         if(isBaseBuildingSkill(this.type) && BMDataManager.getInstance().baseBuildingManager.isEnabled == false)
         {
            return false;
         }
         return true;
      }
      
      public function get skillName() : String
      {
         var _loc1_:String = "";
         var _loc2_:BMLanguageManager = BMLanguageManager.getInstance();
         var _loc3_:Boolean = BMDataManager.getInstance().languageID == BMLanguageManager.LANGUAGE_ENGLISH;
         switch(this.type)
         {
            case TYPE_ENERGY_BASE:
               if(_loc3_)
               {
                  _loc1_ = "Energy capacity";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_energyCapacity");
               }
               break;
            case TYPE_ENERGY_ADDON:
               if(_loc3_)
               {
                  _loc1_ = "Energy regeneration";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_energyRegeneration");
               }
               break;
            case TYPE_HEAT_BASE:
               if(_loc3_)
               {
                  _loc1_ = "Heat capacity";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_heatCapacity");
               }
               break;
            case TYPE_HEAT_ADDON:
               if(_loc3_)
               {
                  _loc1_ = "Heat cooling";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_heatCooling");
               }
               break;
            case TYPE_DAMAGE_HEAT:
               if(_loc3_)
               {
                  _loc1_ = "Heat damage";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_heatDamage");
               }
               break;
            case TYPE_DAMAGE_ENERGY:
               if(_loc3_)
               {
                  _loc1_ = "Energy damage";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_energyDamage");
               }
               break;
            case TYPE_DAMAGE_1:
               if(_loc3_)
               {
                  _loc1_ = "Physical damage";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_physicalDamage");
               }
               break;
            case TYPE_DAMAGE_2:
               if(_loc3_)
               {
                  _loc1_ = "Explosive damage";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_explosiveDamage");
               }
               break;
            case TYPE_DAMAGE_3:
               if(_loc3_)
               {
                  _loc1_ = "Electric damage";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_electricDamage");
               }
               break;
            case TYPE_RESIST_1:
               if(_loc3_)
               {
                  _loc1_ = "Physical resistance";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_resist1");
               }
               break;
            case TYPE_RESIST_2:
               if(_loc3_)
               {
                  _loc1_ = "Explosive resistance";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_resist2");
               }
               break;
            case TYPE_RESIST_3:
               if(_loc3_)
               {
                  _loc1_ = "Electric resistance";
               }
               else
               {
                  _loc1_ = _loc2_.getText("tooltip_resist3");
               }
               break;
            case TYPE_BATTLE_CREDITS_MAX:
               _loc1_ = _loc2_.getText("arenaShop_fuelCapacity");
               break;
            case TYPE_BATTLE_CREDITS_REGEN:
               _loc1_ = _loc2_.getText("arenaShop_fuelRegen");
               break;
            case TYPE_HP_ADDON:
               _loc1_ = _loc2_.getText("arenaShop_totalHP");
               break;
            case TYPE_GOLD_PVP:
               _loc1_ = _loc2_.getText("arenaShop_goldPVP");
               break;
            case TYPE_GOLD_CAMPAIGN:
               _loc1_ = _loc2_.getText("arenaShop_goldCampaign");
               break;
            case TYPE_TITAN_DAMAGE:
               _loc1_ = _loc2_.getText("arenaShop_titanDamage");
               break;
            case TYPE_HP_COST:
               _loc1_ = _loc2_.getText("arenaShop_hpCost");
               break;
            case TYPE_FORTUNE_BOX:
               _loc1_ = _loc2_.getText("arenaShop_foruneBox");
               break;
            case TYPE_CLAN_COINS:
               _loc1_ = _loc2_.getText("arenaShop_clanCoins");
               break;
            case TYPE_BASE_CRAFTING_COST:
               _loc1_ = _loc2_.getText("arenaShop_baseCraftingCost");
               break;
            case TYPE_BASE_CRAFTING_TIME:
               _loc1_ = _loc2_.getText("arenaShop_baseCraftingTime");
               break;
            case TYPE_BASE_UPGRADES_TIME:
               _loc1_ = _loc2_.getText("arenaShop_baseUpgradesTime");
         }
         return _loc1_;
      }
      
      public function get isFixedValue() : Boolean
      {
         switch(this.type)
         {
            case TYPE_BATTLE_CREDITS_MAX:
            case TYPE_HP_ADDON:
               return true;
            default:
               return false;
         }
      }
   }
}

