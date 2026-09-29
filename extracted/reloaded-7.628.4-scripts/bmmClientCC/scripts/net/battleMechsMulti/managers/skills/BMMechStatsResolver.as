package net.battleMechsMulti.managers.skills
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.screens.arenaShop.BMPlayerSkillData;
   
   public class BMMechStatsResolver
   {
      
      public function BMMechStatsResolver()
      {
         super();
      }
      
      public static function getHPMax(param1:uint, param2:uint) : uint
      {
         var _loc3_:String = BMPlayerSkillData.TYPE_HP_ADDON;
         return getValueSub(_loc3_,param1,param2,true);
      }
      
      public static function getHeatBase(param1:uint, param2:uint) : uint
      {
         var _loc3_:String = BMPlayerSkillData.TYPE_HEAT_BASE;
         return getValueSub(_loc3_,param1,param2);
      }
      
      public static function getHeatAddon(param1:uint, param2:uint) : uint
      {
         var _loc3_:String = BMPlayerSkillData.TYPE_HEAT_ADDON;
         return getValueSub(_loc3_,param1,param2);
      }
      
      public static function getEnergyBase(param1:uint, param2:uint) : uint
      {
         var _loc3_:String = BMPlayerSkillData.TYPE_ENERGY_BASE;
         return getValueSub(_loc3_,param1,param2);
      }
      
      public static function getEnergyAddon(param1:uint, param2:uint) : uint
      {
         var _loc3_:String = BMPlayerSkillData.TYPE_ENERGY_ADDON;
         return getValueSub(_loc3_,param1,param2);
      }
      
      public static function getEnergyDamage(param1:uint, param2:uint) : uint
      {
         var _loc3_:String = BMPlayerSkillData.TYPE_DAMAGE_ENERGY;
         return getValueSub(_loc3_,param1,param2);
      }
      
      public static function getHeatDamage(param1:uint, param2:uint) : uint
      {
         var _loc3_:String = BMPlayerSkillData.TYPE_DAMAGE_HEAT;
         return getValueSub(_loc3_,param1,param2);
      }
      
      public static function getDamage(param1:uint, param2:uint, param3:uint, param4:Boolean = false) : uint
      {
         var _loc7_:int = 0;
         var _loc5_:String = BMPlayerSkillData.TYPE_DAMAGE_1;
         switch(param1)
         {
            case 2:
               _loc5_ = BMPlayerSkillData.TYPE_DAMAGE_2;
               break;
            case 3:
               _loc5_ = BMPlayerSkillData.TYPE_DAMAGE_3;
         }
         var _loc6_:uint = uint(getValueSub(_loc5_,param2,param3));
         if(param4)
         {
            _loc7_ = getDamageAddonVSTitan(param2,param3);
            _loc6_ += _loc7_;
         }
         return _loc6_;
      }
      
      private static function getDamageAddonVSTitan(param1:int, param2:uint) : int
      {
         var _loc3_:String = BMPlayerSkillData.TYPE_TITAN_DAMAGE;
         var _loc4_:uint = uint(getValueSub(_loc3_,param1,param2));
         return _loc4_ - param1;
      }
      
      public static function getHPCost(param1:int, param2:uint) : int
      {
         var _loc3_:String = BMPlayerSkillData.TYPE_HP_COST;
         return getValueSub(_loc3_,param1,param2);
      }
      
      public static function getResistance(param1:uint, param2:int, param3:uint) : int
      {
         var _loc4_:String = BMPlayerSkillData.TYPE_RESIST_1;
         switch(param1)
         {
            case 2:
               _loc4_ = BMPlayerSkillData.TYPE_RESIST_2;
               break;
            case 3:
               _loc4_ = BMPlayerSkillData.TYPE_RESIST_3;
         }
         return getValueSub(_loc4_,param2,param3);
      }
      
      private static function getValueSub(param1:String, param2:int, param3:uint, param4:Boolean = false) : int
      {
         var _loc5_:BMDataManager = BMDataManager.getInstance();
         if(_loc5_.playerSkillsManager.arePlayerSkillsEnabled == false)
         {
            return param2;
         }
         var _loc6_:Array = [_loc5_.ONLINE_PLAYER_ID,_loc5_.ONLINE_OPPONENT_ID,_loc5_.REPLAY_PLAYER1_ID,_loc5_.REPLAY_PLAYER2_ID];
         if(_loc6_.indexOf(param3) == -1)
         {
            return param2;
         }
         var _loc7_:uint = uint(_loc5_.playerSkillsManager.getSkillIDByType(param1));
         var _loc8_:uint = uint(playerProfile(param3).skills[_loc7_]);
         var _loc9_:Number = _loc5_.playerSkillsManager.getSkillCurrentLevelBonus(param3,_loc7_);
         if(BMPlayerSkillData.isReductionSkill(param1))
         {
            _loc9_ *= -1;
         }
         var _loc10_:int = param2;
         if(param4)
         {
            _loc10_ = Math.ceil(param2 + _loc9_);
         }
         else
         {
            _loc10_ = Math.ceil(param2 * (100 + _loc9_) / 100);
         }
         return _loc10_;
      }
      
      private static function playerProfile(param1:uint) : BMPlayerProfile
      {
         return BMDataManager.getInstance()["player" + param1 + "Profile"];
      }
   }
}

