package net.battleMechsMulti.managers.basebuilding
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationData;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   
   public class BMBaseBuildingNotificationHelper
   {
      
      private static const NOTIFICATION_ID_FINISH_UPGRADING:uint = 1101;
      
      private static const NOTIFICATION_ID_GOLD_MINE_FULL:uint = 1102;
      
      private static const NOTIFICATION_ID_ITEM_FACTORY_FINISHED:uint = 1103;
      
      private static const NOTIFICATION_IDS_TO_LOCALIZATION_KEYS:Object = {
         "1101":"notifications_baseBuildingFinishUpgrade",
         "1102":"notifications_baseBuildingGoldMineFull",
         "1103":"notifications_baseBuildingItemFactoryFinished"
      };
      
      public function BMBaseBuildingNotificationHelper()
      {
         super();
         throw Error("Static class, do not construct");
      }
      
      private static function get baseBuildingManager() : BMBaseBuildingManager
      {
         return BMDataManager.getInstance().baseBuildingManager;
      }
      
      public static function shouldShowMainMenuGoldBadge() : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:BMBaseBuildingStructureState = null;
         if(!baseBuildingManager.isEnabled)
         {
            return false;
         }
         var _loc1_:Array = baseBuildingManager.state.getPositionsWithStructures();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = baseBuildingManager.state.getStructureState(_loc2_);
            if(_loc3_.type == BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE && baseBuildingManager.getGoldPercentReadyToBeCollected(_loc2_) == 100)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function shouldShowMainMenuItemsBadge() : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:BMBaseBuildingStructureState = null;
         if(!baseBuildingManager.isEnabled)
         {
            return false;
         }
         var _loc1_:Array = baseBuildingManager.state.getPositionsWithStructures();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = baseBuildingManager.state.getStructureState(_loc2_);
            if(_loc3_.type == BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY && baseBuildingManager.getNumberOfItemsReadyToBeCollected(_loc2_) > 0 && baseBuildingManager.getSecondsLeftToFinishProducingItems(_loc2_) == 0)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function updateNearestTime(param1:uint, param2:uint) : uint
      {
         if(param2 == 0)
         {
            return param1;
         }
         if(param1 == 0)
         {
            return param2;
         }
         return Math.min(param2,param1);
      }
      
      private static function updateLocalNotification(param1:BMNotificationsManager, param2:uint, param3:uint) : *
      {
         var _loc4_:Number = NaN;
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:BMNotificationData = null;
         if(param3 > 0)
         {
            _loc4_ = param3 / 86400;
            _loc5_ = NOTIFICATION_IDS_TO_LOCALIZATION_KEYS[param2.toString()];
            _loc6_ = BMLanguageManager.getInstance().getText(_loc5_);
            _loc7_ = new BMNotificationData(param2,_loc4_,_loc6_);
            param1.scheduleLocalNotification(_loc7_);
         }
         else
         {
            param1.cancelLocalNotification(param2);
         }
      }
      
      public static function updateLocalNotifications(param1:BMNotificationsManager) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:BMBaseBuildingStructureState = null;
         if(!baseBuildingManager.isEnabled)
         {
            return;
         }
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return;
         }
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Array = baseBuildingManager.state.getPositionsWithStructures();
         for each(_loc6_ in _loc5_)
         {
            _loc7_ = baseBuildingManager.state.getStructureState(_loc6_);
            if(baseBuildingManager.isStructureUpgrading(_loc6_))
            {
               _loc2_ = updateNearestTime(_loc2_,baseBuildingManager.getSecondsLeftToUpgradeStructure(_loc6_));
            }
            if(_loc7_.type == BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE)
            {
               _loc3_ = updateNearestTime(_loc3_,baseBuildingManager.getSecondsLeftToFillGoldMine(_loc6_));
            }
            if(_loc7_.type == BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY)
            {
               _loc4_ = updateNearestTime(_loc4_,baseBuildingManager.getSecondsLeftToFinishProducingItems(_loc6_));
            }
         }
         updateLocalNotification(param1,NOTIFICATION_ID_FINISH_UPGRADING,_loc2_);
         updateLocalNotification(param1,NOTIFICATION_ID_GOLD_MINE_FULL,_loc3_);
         updateLocalNotification(param1,NOTIFICATION_ID_ITEM_FACTORY_FINISHED,_loc4_);
      }
      
      public static function cancelLocalNotifications(param1:BMNotificationsManager) : void
      {
         if(!baseBuildingManager.isEnabled)
         {
            return;
         }
         updateLocalNotification(param1,NOTIFICATION_ID_FINISH_UPGRADING,0);
         updateLocalNotification(param1,NOTIFICATION_ID_GOLD_MINE_FULL,0);
         updateLocalNotification(param1,NOTIFICATION_ID_ITEM_FACTORY_FINISHED,0);
      }
   }
}

