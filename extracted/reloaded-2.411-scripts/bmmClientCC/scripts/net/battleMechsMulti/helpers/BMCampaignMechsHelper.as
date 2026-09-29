package net.battleMechsMulti.helpers
{
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   public class BMCampaignMechsHelper
   {
      
      private static const MISSION_JEEP_CRASH_DAMAGE_BASE:Number = 15;
      
      private static const MISSION_JEEP_CRASH_DAMAGE_PER_LEVEL:Number = 1;
      
      private static const MISSION_TANK_CRASH_DAMAGE_BASE:Number = 15;
      
      private static const MISSION_TANK_CRASH_DAMAGE_PER_LEVEL:Number = 2;
      
      public function BMCampaignMechsHelper()
      {
         super();
         throw new Error("Don\'t construct this class");
      }
      
      public static function get tankTorsoItemID() : int
      {
         return FeatureFlags.NEW_ECONOMY ? 915 : 915;
      }
      
      public static function get tankLegItemID() : int
      {
         return FeatureFlags.NEW_ECONOMY ? 917 : 917;
      }
      
      public static function get jeepTorsoItemID() : int
      {
         return FeatureFlags.NEW_ECONOMY ? 914 : 914;
      }
      
      public static function get jeepLegItemID() : int
      {
         return FeatureFlags.NEW_ECONOMY ? 916 : 916;
      }
      
      public static function get jeepSideWeapon1ItemID() : int
      {
         return FeatureFlags.NEW_ECONOMY ? 162 : 162;
      }
      
      public static function get jeepSideWeapon2ItemID() : int
      {
         return FeatureFlags.NEW_ECONOMY ? 176 : 176;
      }
      
      public static function getItemAIDifficultyLevel(param1:BMItemData) : int
      {
         if(FeatureFlags.NEW_ECONOMY)
         {
            if(param1.isDeprecated)
            {
               return -1000;
            }
            return param1.level;
         }
         return param1.level;
      }
      
      public static function getMissionJeepCrashDamage(param1:BMPlayerProfile) : *
      {
         if(FeatureFlags.NEW_ECONOMY)
         {
            return MISSION_JEEP_CRASH_DAMAGE_BASE + param1.currentMissionSlot * 0.5 * MISSION_JEEP_CRASH_DAMAGE_PER_LEVEL;
         }
         return MISSION_JEEP_CRASH_DAMAGE_BASE + param1.level * MISSION_JEEP_CRASH_DAMAGE_PER_LEVEL;
      }
      
      public static function getMissionJeepCrashAddonDamage(param1:BMPlayerProfile) : *
      {
         return 0;
      }
      
      public static function getMissionTankCrashDamage(param1:BMPlayerProfile) : *
      {
         if(FeatureFlags.NEW_ECONOMY)
         {
            return MISSION_TANK_CRASH_DAMAGE_BASE + param1.currentMissionSlot * 0.5 * MISSION_TANK_CRASH_DAMAGE_PER_LEVEL;
         }
         return MISSION_TANK_CRASH_DAMAGE_BASE + param1.level * MISSION_TANK_CRASH_DAMAGE_PER_LEVEL;
      }
      
      public static function getMissionTankCrashAddonDamage(param1:BMPlayerProfile) : *
      {
         return 0;
      }
      
      public static function getTutorial_hanger1_torso() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 9505 : 23;
      }
      
      public static function getTutorial_hanger1_leg() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 17755 : 2;
      }
      
      public static function getTutorial_hanger1_sideWeapon() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 20975 : 3;
      }
      
      public static function getTutorial_hanger2_torso() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 9945 : 153;
      }
      
      public static function getTutorial_hanger2_sideWeapon() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 20915 : 197;
      }
      
      public static function getTutorial_hanger3_torso() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 9205 : 155;
      }
      
      public static function getTutorial_hanger3_sideWeapon() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 21225 : 161;
      }
      
      public static function getTutorial_hanger4_sideWeapon() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 23375 : 162;
      }
      
      public static function getTutorial_hanger4_topWeapon() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 14095 : 708;
      }
      
      public static function getTutorial_hanger4_module() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 61 : 56;
      }
      
      public static function getTutorial_hanger5_leg() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 17565 : 35;
      }
      
      public static function getTutorial_hanger5_module() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 25 : 25;
      }
      
      public static function getTutorial_hanger5_drone() : uint
      {
         return FeatureFlags.GACHA_MACHINES ? 13045 : 1;
      }
      
      public static function getTutorial_hanger6_boxItems() : Array
      {
         return FeatureFlags.GACHA_MACHINES ? [23375,22305,23315] : null;
      }
      
      public static function getTutorial_opponent1_leg() : uint
      {
         return 2;
      }
      
      public static function getTutorial_opponent1_sideweapon() : uint
      {
         return 3;
      }
      
      public static function getTutorial_opponent1_torso() : uint
      {
         return 23;
      }
      
      public static function getTutorial_opponent2_torso() : uint
      {
         return 153;
      }
      
      public static function getTutorial_opponent3_torso() : uint
      {
         return 155;
      }
      
      public static function getTutorial_opponent3_leg() : uint
      {
         return 2;
      }
      
      public static function getTutorial_opponent3_sideWeapon() : uint
      {
         return 161;
      }
      
      public static function getTutorial_opponent4_torso() : uint
      {
         return 155;
      }
      
      public static function getTutorial_opponent4_leg() : uint
      {
         return 2;
      }
      
      public static function getTutorial_opponent4_sideWeapon1() : uint
      {
         return 161;
      }
      
      public static function getTutorial_opponent4_sideWeapon2() : uint
      {
         return 162;
      }
   }
}

