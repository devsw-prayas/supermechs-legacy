package net.battleMechsMulti.helpers
{
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerItemDataTemplate;
   import net.tacticsoft.utils.RandomUtils;
   
   public class BMCampaignMechsHelper
   {
      
      private static const MISSION_JEEP_CRASH_DAMAGE_BASE:Number = 35;
      
      private static const MISSION_JEEP_CRASH_DAMAGE_PER_POWER_RATING:Number = 1.5;
      
      private static const MISSION_TANK_CRASH_DAMAGE_BASE:Number = 50;
      
      private static const MISSION_TANK_CRASH_DAMAGE_PER_POWER_RATING:Number = 2.5;
      
      public function BMCampaignMechsHelper()
      {
         super();
         throw new Error("Don\'t construct this class");
      }
      
      public static function get tankTorsoItemID() : int
      {
         return 915;
      }
      
      public static function get tankLegItemID() : int
      {
         return 917;
      }
      
      public static function get jeepTorsoItemID() : int
      {
         return 914;
      }
      
      public static function get jeepLegItemID() : int
      {
         return 916;
      }
      
      public static function get jeepSideWeapon1ItemID() : int
      {
         return getTutorial_hanger3_sideWeapon();
      }
      
      public static function getItemAIDifficultyLevel(param1:BMItemData) : int
      {
         if(param1.isDeprecated)
         {
            return -1000;
         }
         return param1.powerRating;
      }
      
      public static function getMissionJeepAttributes(param1:uint, param2:Boolean = false) : *
      {
         var _loc3_:Object = new Object();
         if(param2)
         {
            _loc3_.hp = 75;
         }
         else
         {
            _loc3_.hp = getRoundedNumber(75 + Math.ceil((param1 - 1) * 5),5);
         }
         _loc3_.energyBase = getRoundedNumber(20 + Math.ceil((param1 - 1) * 2),5);
         _loc3_.energyAddon = getRoundedNumber(10 + Math.ceil((param1 - 1) * 1),5);
         _loc3_.heatBase = getRoundedNumber(20 + Math.ceil((param1 - 1) * 2),5);
         _loc3_.heatAddon = getRoundedNumber(10 + Math.ceil((param1 - 1) * 1),5);
         return _loc3_;
      }
      
      public static function getMissionJeepCrashDamage(param1:uint) : *
      {
         return Math.ceil(MISSION_JEEP_CRASH_DAMAGE_BASE + param1 * MISSION_JEEP_CRASH_DAMAGE_PER_POWER_RATING);
      }
      
      public static function getMissionJeepCrashAddonDamage(param1:uint) : *
      {
         return 0;
      }
      
      public static function getMissionTankAttributes(param1:uint) : *
      {
         var _loc2_:Object = new Object();
         _loc2_.hp = getRoundedNumber(100 + Math.ceil((param1 - 1) * 7.5),5);
         _loc2_.energyBase = getRoundedNumber(30 + Math.ceil((param1 - 1) * 3),5);
         _loc2_.energyAddon = getRoundedNumber(15 + Math.ceil((param1 - 1) * 1.5),5);
         _loc2_.heatBase = getRoundedNumber(30 + Math.ceil((param1 - 1) * 3),5);
         _loc2_.heatAddon = getRoundedNumber(15 + Math.ceil((param1 - 1) * 1.5),5);
         return _loc2_;
      }
      
      public static function getMissionTankCrashDamage(param1:uint) : *
      {
         return Math.ceil(MISSION_TANK_CRASH_DAMAGE_BASE + param1 * MISSION_TANK_CRASH_DAMAGE_PER_POWER_RATING);
      }
      
      public static function getMissionTankCrashAddonDamage(param1:uint) : *
      {
         return 0;
      }
      
      private static function getRoundedNumber(param1:uint, param2:uint) : uint
      {
         return Math.ceil(param1 / param2) * param2;
      }
      
      public static function getTutorial_hanger1_torso() : uint
      {
         return 22535;
      }
      
      public static function getTutorial_hanger1_leg() : uint
      {
         return 9355;
      }
      
      public static function getTutorial_hanger1_sideWeapon() : uint
      {
         return 15245;
      }
      
      public static function getTutorial_hanger2_torso() : uint
      {
         return 22755;
      }
      
      public static function getTutorial_hanger3_sideWeapon() : uint
      {
         return 29655;
      }
      
      public static function getTutorial_hanger4_topWeapon() : uint
      {
         return 19295;
      }
      
      public static function getTutorial_hanger4_module() : uint
      {
         return 9805;
      }
      
      public static function getTutorial_hanger5_torso() : uint
      {
         return 25606;
      }
      
      public static function getTutorial_hanger5_drone() : uint
      {
         return 11555;
      }
      
      public static function getTutorial_opponent1_torso() : uint
      {
         return 23145;
      }
      
      public static function getTutorial_opponent1_leg() : uint
      {
         return 24925;
      }
      
      public static function getTutorial_opponent1_sideweapon() : uint
      {
         return getTutorial_hanger1_sideWeapon();
      }
      
      public static function getTutorial_opponent2_torso() : uint
      {
         return 23145;
      }
      
      public static function getTutorial_opponent3_torso() : uint
      {
         return 22655;
      }
      
      public static function getTutorial_opponent3_leg() : uint
      {
         return 24735;
      }
      
      public static function getTutorial_opponent3_sideWeapon() : uint
      {
         return getTutorial_hanger3_sideWeapon();
      }
      
      public static function getTutorial_opponent4_torso() : uint
      {
         return 22655;
      }
      
      public static function getTutorial_opponent4_leg() : uint
      {
         return 24735;
      }
      
      public static function getTutorial_opponent4_sideWeapon1() : uint
      {
         return getTutorial_hanger3_sideWeapon();
      }
      
      public static function getTutorial_opponent4_sideWeapon2() : uint
      {
         return getTutorial_hanger1_sideWeapon();
      }
      
      public static function getTutorialItems_hanger1() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_hanger1_torso(),"torso",0,0,10));
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_hanger1_leg(),"leg"));
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_hanger1_sideWeapon(),"sideWeapon"));
         return _loc1_;
      }
      
      public static function getTutorialEnemyMech_mission1() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_opponent3_torso(),"torso",1));
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_opponent3_leg(),"leg",1));
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_opponent3_sideWeapon(),"sideWeapon",1,1));
         return _loc1_;
      }
      
      public static function getTutorialEnemyMech_mission2() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_opponent4_torso(),"torso",1));
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_opponent4_leg(),"leg",1));
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_opponent4_sideWeapon1(),"sideWeapon",1,1));
         _loc1_.push(getPlayerItemDataTemplate(getTutorial_opponent4_sideWeapon2(),"sideWeapon",1,2));
         return _loc1_;
      }
      
      public static function getTutorialEnemyJeep_mission2() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(getPlayerItemDataTemplate(jeepTorsoItemID,"torso",1));
         _loc1_.push(getPlayerItemDataTemplate(jeepLegItemID,"leg",1));
         _loc1_.push(getPlayerItemDataTemplate(jeepSideWeapon1ItemID,"sideWeapon",1,1));
         return _loc1_;
      }
      
      public static function getCampaignEnemyJeep(param1:Array, param2:Array) : Array
      {
         var _loc4_:uint = 0;
         var _loc3_:Array = new Array();
         _loc3_.push(getPlayerItemDataTemplate(jeepTorsoItemID,"torso",1));
         _loc3_.push(getPlayerItemDataTemplate(jeepLegItemID,"leg",1));
         _loc3_.push(getPlayerItemDataTemplate(RandomUtils.chooseRandomElement(param1),"sideWeapon",1,1));
         var _loc5_:String = "sideWeapon";
         if(Math.ceil(Math.random() * 2) == 1)
         {
            _loc4_ = RandomUtils.chooseRandomElement(param1);
         }
         else
         {
            _loc4_ = RandomUtils.chooseRandomElement(param2);
            _loc5_ = "topWeapon";
         }
         _loc3_.push(getPlayerItemDataTemplate(_loc4_,_loc5_,1,2));
         return _loc3_;
      }
      
      public static function getCampaignEnemyTank(param1:Array, param2:Array) : Array
      {
         var _loc4_:uint = 0;
         var _loc3_:Array = new Array();
         _loc3_.push(getPlayerItemDataTemplate(tankTorsoItemID,"torso",1));
         _loc3_.push(getPlayerItemDataTemplate(tankLegItemID,"leg",1));
         _loc3_.push(getPlayerItemDataTemplate(RandomUtils.chooseRandomElement(param1),"sideWeapon",1,1));
         var _loc5_:String = "sideWeapon";
         if(Math.ceil(Math.random() * 2) == 1)
         {
            _loc4_ = RandomUtils.chooseRandomElement(param1);
         }
         else
         {
            _loc4_ = RandomUtils.chooseRandomElement(param2);
            _loc5_ = "topWeapon";
         }
         _loc3_.push(getPlayerItemDataTemplate(_loc4_,_loc5_,1,2));
         return _loc3_;
      }
      
      private static function getPlayerItemDataTemplate(param1:uint, param2:String = "", param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0) : BMPlayerItemDataTemplate
      {
         var _loc7_:BMPlayerItemDataTemplate = new BMPlayerItemDataTemplate();
         _loc7_.itemID = param1;
         _loc7_.equipped = param3;
         _loc7_.equipmentType = param2;
         _loc7_.equipmentID = param4;
         _loc7_.power = param5;
         _loc7_.colorID = param6;
         return _loc7_;
      }
   }
}

