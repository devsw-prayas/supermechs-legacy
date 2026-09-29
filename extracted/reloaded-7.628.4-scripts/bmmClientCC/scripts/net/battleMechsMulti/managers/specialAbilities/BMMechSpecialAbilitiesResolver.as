package net.battleMechsMulti.managers.specialAbilities
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMMechSpecialAbilitiesResolver
   {
      
      public static const CRITICAL_HIT:String = "1";
      
      public static const INCREASED_ENERGY_REGENERATION:String = "2";
      
      public static const INCREASED_HEAT_COOLING:String = "3";
      
      public static const RESISTANCE_DRAIN_SHIELD:String = "4";
      
      public static const DAMAGE_SHIELD:String = "5";
      
      public static const ENERGY_DAMAGE_SHIELD:String = "6";
      
      public static const HEAT_DAMAGE_SHIELD:String = "7";
      
      public static const IGNORE_RESISTANCE:String = "8";
      
      public static const PUSH_PULL_SHIELD:String = "9";
      
      public static const EXTRA_AP:String = "10";
      
      public static const REPAIR:String = "11";
      
      public static const FREE_MECH_CHANGE:String = "12";
      
      public static const ENHANCER_CATEGORY_OFFENSIVE:String = "offensive";
      
      public static const ENHANCER_CATEGORY_DEFFENSIVE:String = "deffensive";
      
      public static const ENHANCER_CATEGORY_SUPPORT:String = "support";
      
      public static const ENHANCER_CATEGORIES:Array = [ENHANCER_CATEGORY_OFFENSIVE,ENHANCER_CATEGORY_DEFFENSIVE,ENHANCER_CATEGORY_SUPPORT];
      
      public static const SPECIAL_ABILITIES_TO_CODES:Object = {
         "1":CRITICAL_HIT,
         "2":INCREASED_ENERGY_REGENERATION,
         "3":INCREASED_HEAT_COOLING,
         "4":RESISTANCE_DRAIN_SHIELD,
         "5":DAMAGE_SHIELD,
         "6":ENERGY_DAMAGE_SHIELD,
         "7":HEAT_DAMAGE_SHIELD,
         "8":IGNORE_RESISTANCE,
         "9":PUSH_PULL_SHIELD,
         "10":EXTRA_AP,
         "11":REPAIR,
         "12":FREE_MECH_CHANGE
      };
      
      public function BMMechSpecialAbilitiesResolver()
      {
         super();
      }
      
      public static function getEnhancerCategoryBySpecialAbility(param1:String) : String
      {
         switch(param1)
         {
            case "criticalHit":
               return ENHANCER_CATEGORY_OFFENSIVE;
            default:
               throw Error("getEnhancerCategoryBySpecialAbility could not find category");
         }
      }
      
      public static function applyCriticalHitDamage(param1:uint, param2:uint, param3:BMMechBattleData, param4:Number) : uint
      {
         var _loc5_:uint = uint(param3.getCriticalHitChance(param2));
         if(_loc5_ == 0)
         {
            return param1;
         }
         var _loc6_:uint = uint(param3.getCriticalHitDamageBonus(param2));
         if(_loc6_ == 0)
         {
            return param1;
         }
         if(param4 <= _loc5_)
         {
            param1 = Math.ceil(param1 * (1000 + _loc5_) / 1000);
         }
         return param1;
      }
      
      public static function getItemSpecialAbilityDescription(param1:uint) : String
      {
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         var _loc3_:BMItemData = _loc2_.itemsDB[param1];
         return _loc3_.fullName;
      }
      
      public static function enhancersEnabled() : Boolean
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(int(_loc1_.getGeneralSetting("useEnahcers",0)) == 1)
         {
            return true;
         }
         return false;
      }
      
      public static function getCostForEnhancersModification(param1:uint, param2:Array) : uint
      {
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         var _loc4_:BMItemData = _loc3_.itemsDB[param1];
         var _loc5_:BMPlayerItemData = _loc3_.getPlayerItemData(_loc3_.player1PlayerID,param1);
         return Math.ceil(Math.random() * 10) * 500;
      }
   }
}

