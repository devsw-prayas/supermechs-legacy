package net.battleMechsMulti.mobiles
{
   public class BMReplayAction
   {
      
      public static const ACTION_CODE_FIRE_WEAPON:String = "FW";
      
      public static const ACTION_CODE_SHUTDOWN:String = "SH";
      
      public static const ACTION_CODE_USE_KIT:String = "KI";
      
      public static const ACTION_CODE_MOVE:String = "MV";
      
      public static const ACTION_CODE_TELEPORT:String = "TP";
      
      public static const ACTION_CODE_CHARGE:String = "CH";
      
      public static const ACTION_CODE_HARPOON:String = "HR";
      
      public static const ACTION_CODE_ACTIVATE_DRONE:String = "DA";
      
      public static const ACTION_CODE_DEACTIVATE_DRONE:String = "DD";
      
      public static const ACTION_CODE_ACTIVATE_SHIELD:String = "SA";
      
      public static const ACTION_CODE_DEACTIVATE_SHIELD:String = "SD";
      
      public static const ACTION_CODE_SWITCH_MECH:String = "SW";
      
      public static const ACTION_CODE_QUIT:String = "QU";
      
      public static const ACTION_NAME_FIRE_WEAPON:String = "fireWeapon";
      
      public static const ACTION_NAME_SHUTDOWN:String = "shutDown";
      
      public static const ACTION_NAME_USE_KIT:String = "useKit";
      
      public static const ACTION_NAME_MOVE:String = "moveMechToStep";
      
      public static const ACTION_NAME_TELEPORT:String = "teleport";
      
      public static const ACTION_NAME_CHARGE:String = "charge";
      
      public static const ACTION_NAME_HARPOON:String = "harpoon";
      
      public static const ACTION_NAME_ACTIVATE_DRONE:String = "activateDrone";
      
      public static const ACTION_NAME_DEACTIVATE_DRONE:String = "deactivateDrone";
      
      public static const ACTION_NAME_ACTIVATE_SHIELD:String = "activateShield";
      
      public static const ACTION_NAME_DEACTIVATE_SHIELD:String = "deactivateShield";
      
      public static const ACTION_NAME_SWITCH_MECH:String = "switchMech";
      
      public static const ACTION_NAME_QUIT:String = "quit";
      
      public static const ACTION_CODES_TO_NAMES:Object = {
         "FW":ACTION_NAME_FIRE_WEAPON,
         "SH":ACTION_NAME_SHUTDOWN,
         "KI":ACTION_NAME_USE_KIT,
         "MV":ACTION_NAME_MOVE,
         "TP":ACTION_NAME_TELEPORT,
         "CH":ACTION_NAME_CHARGE,
         "HR":ACTION_NAME_HARPOON,
         "DA":ACTION_NAME_ACTIVATE_DRONE,
         "DD":ACTION_NAME_DEACTIVATE_DRONE,
         "SA":ACTION_NAME_ACTIVATE_SHIELD,
         "SD":ACTION_NAME_DEACTIVATE_SHIELD,
         "SW":ACTION_NAME_SWITCH_MECH,
         "QU":ACTION_NAME_QUIT
      };
      
      public static const ACTION_CODE_FIRE_WEAPON_SIDE_WEAPON:String = "S";
      
      public static const ACTION_CODE_FIRE_WEAPON_TOP_WEAPON:String = "T";
      
      public static const ACTION_CODE_FIRE_WEAPON_DRONE:String = "D";
      
      public static const ACTION_CODE_FIRE_WEAPON_LEG:String = "L";
      
      public static const ACTION_NAME_FIRE_WEAPON_SIDE_WEAPON:String = "sideWeapon";
      
      public static const ACTION_NAME_FIRE_WEAPON_TOP_WEAPON:String = "topWeapon";
      
      public static const ACTION_NAME_FIRE_WEAPON_DRONE:String = "drone";
      
      public static const ACTION_NAME_FIRE_WEAPON_LEG:String = "leg";
      
      public static const ACTION_NAME_FIRE_WEAPON_TO_CODE:Object = {
         "sideWeapon":ACTION_CODE_FIRE_WEAPON_SIDE_WEAPON,
         "topWeapon":ACTION_CODE_FIRE_WEAPON_TOP_WEAPON,
         "drone":ACTION_CODE_FIRE_WEAPON_DRONE,
         "leg":ACTION_CODE_FIRE_WEAPON_LEG
      };
      
      public static const ACTION_CODE_MOVE_WALK:String = "W";
      
      public static const ACTION_CODE_MOVE_JUMP:String = "J";
      
      public static const ACTION_NAME_MOVE_WALK:String = "walk";
      
      public static const ACTION_NAME_MOVE_JUMP:String = "jump";
      
      public static const ACTION_NAME_MOVE_TO_CODE:Object = {
         "walk":ACTION_CODE_MOVE_WALK,
         "jump":ACTION_CODE_MOVE_JUMP
      };
      
      public static const ACTION_PART_SEPARATOR:String = "-";
      
      public static const ACTION_SPECIAL_ABILITY_SEPARATOR:String = "+";
      
      public const ACTION_NAMES_TO_CODES:Object = {
         "fireWeapon":ACTION_CODE_FIRE_WEAPON,
         "shutDown":ACTION_CODE_SHUTDOWN,
         "useKit":ACTION_CODE_USE_KIT,
         "moveMechToStep":ACTION_CODE_MOVE,
         "teleport":ACTION_CODE_TELEPORT,
         "charge":ACTION_CODE_CHARGE,
         "harpoon":ACTION_CODE_HARPOON,
         "activateDrone":ACTION_CODE_ACTIVATE_DRONE,
         "deactivateDrone":ACTION_CODE_DEACTIVATE_DRONE,
         "activateShield":ACTION_CODE_ACTIVATE_SHIELD,
         "deactivateShield":ACTION_CODE_DEACTIVATE_SHIELD,
         "switchMech":ACTION_CODE_SWITCH_MECH,
         "quit":ACTION_CODE_QUIT
      };
      
      public var playerNumber:Number;
      
      public var actionName:String;
      
      public var equipmentType:String;
      
      public var equipmentID:Number;
      
      public var motionType:String;
      
      public var mechID:uint;
      
      public var specialAbilities:Array = new Array();
      
      public function BMReplayAction()
      {
         super();
      }
      
      public static function createFireWeaponAction(param1:String, param2:Number = 0) : BMReplayAction
      {
         var _loc3_:BMReplayAction = new BMReplayAction();
         _loc3_.actionName = ACTION_NAME_FIRE_WEAPON;
         _loc3_.equipmentType = param1;
         _loc3_.equipmentID = param2;
         return _loc3_;
      }
      
      public static function createMoveAction(param1:String) : BMReplayAction
      {
         var _loc2_:BMReplayAction = new BMReplayAction();
         _loc2_.actionName = ACTION_NAME_MOVE;
         _loc2_.motionType = param1;
         return _loc2_;
      }
      
      public static function createSwitchMechAction(param1:uint) : BMReplayAction
      {
         var _loc2_:BMReplayAction = new BMReplayAction();
         _loc2_.actionName = ACTION_NAME_SWITCH_MECH;
         _loc2_.mechID = param1;
         return _loc2_;
      }
      
      public static function createSimpleAction(param1:String) : BMReplayAction
      {
         var _loc2_:BMReplayAction = new BMReplayAction();
         _loc2_.actionName = param1;
         return _loc2_;
      }
      
      public function getReplayString(param1:Array) : String
      {
         var _loc2_:String = "";
         var _loc3_:Object = this.ACTION_NAMES_TO_CODES;
         _loc2_ += this.playerNumber.toString();
         _loc2_ += ACTION_PART_SEPARATOR;
         _loc2_ += this.ACTION_NAMES_TO_CODES[this.actionName];
         if(this.actionName == ACTION_NAME_FIRE_WEAPON)
         {
            _loc2_ += ACTION_PART_SEPARATOR;
            _loc2_ += ACTION_NAME_FIRE_WEAPON_TO_CODE[this.equipmentType];
            if(this.equipmentID > 0)
            {
               _loc2_ += this.equipmentID.toString();
            }
         }
         else if(this.actionName == ACTION_NAME_MOVE)
         {
            _loc2_ += ACTION_PART_SEPARATOR;
            _loc2_ += ACTION_NAME_MOVE_TO_CODE[this.motionType];
         }
         else if(this.actionName == ACTION_NAME_SWITCH_MECH)
         {
            _loc2_ += ACTION_PART_SEPARATOR;
            _loc2_ += this.mechID;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ += ACTION_SPECIAL_ABILITY_SEPARATOR + param1[_loc4_];
            _loc4_++;
         }
         return _loc2_;
      }
   }
}

