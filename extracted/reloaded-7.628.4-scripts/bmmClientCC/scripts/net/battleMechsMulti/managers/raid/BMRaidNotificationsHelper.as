package net.battleMechsMulti.managers.raid
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationData;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   
   public class BMRaidNotificationsHelper
   {
      
      private static const NOTIFICATION_ID_NEXT_RAID_AVAILABLE:uint = 2101;
      
      private static const NOTIFICATION_IDS_TO_LOCALIZATION_KEYS:Object = {"2101":"notifications_nextRaidAvailable"};
      
      public function BMRaidNotificationsHelper()
      {
         super();
         throw Error("Static class, do not construct");
      }
      
      public static function updateLocalNotifications(param1:BMNotificationsManager) : void
      {
         var _loc2_:uint = 0;
         if(dataM.raidData.day < 6 && dataM.raidData.didCompleteCurrentLevelRaid)
         {
            _loc2_ = Math.max(0,dataM.questsManager.dailyQuestsSecLeft);
            updateLocalNotification(param1,NOTIFICATION_ID_NEXT_RAID_AVAILABLE,_loc2_);
         }
      }
      
      private static function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private static function updateLocalNotification(param1:BMNotificationsManager, param2:uint, param3:uint) : *
      {
         if(param3 <= 0)
         {
            param1.cancelLocalNotification(param2);
            return;
         }
         var _loc4_:Number = param3 / 86400;
         var _loc5_:* = NOTIFICATION_IDS_TO_LOCALIZATION_KEYS[param2.toString()];
         var _loc6_:String = BMLanguageManager.getInstance().getText(_loc5_);
         var _loc7_:BMNotificationData = new BMNotificationData(param2,_loc4_,_loc6_);
         param1.scheduleLocalNotification(_loc7_);
      }
   }
}

