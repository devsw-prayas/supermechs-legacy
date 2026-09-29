package net.battleMechsMulti.mobiles.itemComparison
{
   import net.battleMechsMulti.mobiles.BMItemData;
   
   public class BMItemComparisonLogic
   {
      
      public function BMItemComparisonLogic()
      {
         super();
      }
      
      public static function shouldRecommendReplacingItem(param1:BMItemData, param2:BMItemData) : Boolean
      {
         switch(param1.type)
         {
            case "torso":
            case "leg":
            case "sideWeapon":
            case "topWeapon":
            case "module":
            case "drone":
            case "teleport":
            case "charge":
            case "harpoon":
               if(param1.type != param2.type)
               {
                  throw Error("BMItemComparisonLogic items are not of the same type");
               }
               if(param1.specialStatus >= param2.specialStatus)
               {
                  return false;
               }
               var _loc3_:uint = uint(param1.itemID);
               switch(param1.type)
               {
                  case "torso":
                     _loc3_ = checkTorsos(param1,param2);
                     break;
                  case "leg":
                     _loc3_ = checkLegs(param1,param2);
                     break;
                  case "sideWeapon":
                  case "topWeapon":
                  case "drone":
                     _loc3_ = checkWeapons(param1,param2);
                     break;
                  case "module":
                     _loc3_ = checkModules(param1,param2);
                     break;
                  case "teleport":
                     _loc3_ = checkTeleport(param1,param2);
                     break;
                  case "charge":
                     _loc3_ = checkCharge(param1,param2);
                     break;
                  case "harpoon":
                     _loc3_ = checkHarpoon(param1,param2);
               }
               if(_loc3_ == param1.itemID)
               {
                  return false;
               }
               return true;
               break;
            default:
               throw Error("BMItemComparisonLogic invalid item type: " + param1.type);
         }
      }
      
      private static function checkTorsos(param1:BMItemData, param2:BMItemData) : uint
      {
         return param2.itemID;
      }
      
      private static function checkLegs(param1:BMItemData, param2:BMItemData) : uint
      {
         return param2.itemID;
      }
      
      private static function getWeaponUses(param1:BMItemData) : uint
      {
         var _loc2_:uint = uint(param1.uses);
         if(_loc2_ == 0)
         {
            _loc2_ += 10;
         }
         return _loc2_;
      }
      
      private static function getWeaponMinRange(param1:BMItemData) : uint
      {
         return param1.rangeBase;
      }
      
      private static function getWeaponMaxRange(param1:BMItemData) : uint
      {
         return param1.rangeBase + param1.rangeAddon;
      }
      
      private static function checkWeapons(param1:BMItemData, param2:BMItemData) : uint
      {
         if(getWeaponMinRange(param2) <= getWeaponMinRange(param1) && getWeaponMaxRange(param2) >= getWeaponMaxRange(param1) && getWeaponUses(param2) >= getWeaponUses(param1))
         {
            return param2.itemID;
         }
         return param1.itemID;
      }
      
      private static function checkModules(param1:BMItemData, param2:BMItemData) : uint
      {
         return param2.itemID;
      }
      
      private static function checkTeleport(param1:BMItemData, param2:BMItemData) : uint
      {
         return param2.itemID;
      }
      
      private static function checkCharge(param1:BMItemData, param2:BMItemData) : uint
      {
         return param2.itemID;
      }
      
      private static function checkHarpoon(param1:BMItemData, param2:BMItemData) : uint
      {
         return param2.itemID;
      }
   }
}

