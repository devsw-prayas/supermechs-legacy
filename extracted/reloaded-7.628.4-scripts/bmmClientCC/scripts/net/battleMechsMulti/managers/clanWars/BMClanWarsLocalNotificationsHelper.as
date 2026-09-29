package net.battleMechsMulti.managers.clanWars
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationData;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   
   public class BMClanWarsLocalNotificationsHelper
   {
      
      public static const NOTIFICATION_ID_JOIN_PREPARATION_STARTED:uint = 3000;
      
      public static const NOTIFICATION_ID_JOIN_PREPARATION_ENDING:uint = 3001;
      
      public static const NOTIFICATION_ID_BATTLE_WAR_ROUND_STARTED:uint = 3002;
      
      public static const NOTIFICATION_ID_BATTLE_WAR_ROUND_ENDING:uint = 3003;
      
      public static const NOTIFICATION_ID_BATTLE_WAR_ROUND2_STARTED:uint = 3004;
      
      public static const PREPARATION_STARTED_DELAY_SECONDS:* = 30 * 60;
      
      private static const NOTIFICATION_IDS_TO_LOCALIZATION_KEYS:Object = {
         "3000":"notifications_clanWarJoin_preparationStarted",
         "3001":"notifications_clanWarJoin_preparationEnding",
         "3002":"notifications_clanWarBattle_warRoundStarted",
         "3003":"notifications_clanWarBattle_warRoundEnding",
         "3004":"notifications_clanWarBattle_warRoundStarted"
      };
      
      public function BMClanWarsLocalNotificationsHelper()
      {
         super();
         throw Error("Static class, do not construct");
      }
      
      public static function updateLocalNotifications(param1:BMNotificationsManager) : void
      {
         var _loc3_:uint = 0;
         cancelAllNotifications(param1);
         if(dataM.myProfile.clanID == 0)
         {
            return;
         }
         if(dataM.clanWarsM.passedMinXPLevelToJoinAWar == false)
         {
            return;
         }
         var _loc2_:uint = 86400;
         var _loc4_:uint = 0;
         var _loc5_:Array = new Array();
         if(dataM.clanWarsM.isPreparationPhase)
         {
            if(dataM.clanWarsM.didIJoin)
            {
               _loc3_ = dataM.clanWarsM.getPhaseSecLeft();
               _loc5_.push({
                  "id":NOTIFICATION_ID_BATTLE_WAR_ROUND_STARTED,
                  "sec":_loc3_
               });
               _loc3_ += _loc2_ * 2;
               _loc5_.push({
                  "id":NOTIFICATION_ID_BATTLE_WAR_ROUND2_STARTED,
                  "sec":_loc3_
               });
            }
            else if(dataM.clanWarsM.getPhaseSecLeft() > _loc2_)
            {
               _loc3_ = dataM.clanWarsM.getPhaseSecLeft() - _loc2_;
               _loc5_.push({
                  "id":NOTIFICATION_ID_JOIN_PREPARATION_ENDING,
                  "sec":_loc3_
               });
            }
         }
         else if(dataM.clanWarsM.didIJoin)
         {
            if(dataM.clanWarsM.attacksLeft > 0 && dataM.clanWarsM.getPhaseSecLeft() > _loc2_ / 2)
            {
               _loc3_ = dataM.clanWarsM.getPhaseSecLeft() - _loc2_ / 2;
               _loc5_.push({
                  "id":NOTIFICATION_ID_BATTLE_WAR_ROUND_ENDING,
                  "sec":_loc3_
               });
            }
            if(dataM.clanWarsM.currentPhase == BMClanWarsManager.WAR_PHASE_ROUND1)
            {
               _loc3_ = dataM.clanWarsM.getPhaseSecLeft();
               _loc5_.push({
                  "id":NOTIFICATION_ID_BATTLE_WAR_ROUND_STARTED,
                  "sec":_loc3_
               });
            }
         }
         _loc3_ = dataM.clanWarsM.getNextWarStartSecLeft() + PREPARATION_STARTED_DELAY_SECONDS;
         _loc5_.push({
            "id":NOTIFICATION_ID_JOIN_PREPARATION_STARTED,
            "sec":_loc3_
         });
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_.length)
         {
            updateLocalNotification(param1,_loc5_[_loc6_].id,_loc5_[_loc6_].sec);
            _loc6_++;
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
            return;
         }
         var _loc4_:Number = param3 / 86400;
         var _loc5_:* = NOTIFICATION_IDS_TO_LOCALIZATION_KEYS[param2.toString()];
         var _loc6_:String = BMLanguageManager.getInstance().getText(_loc5_);
         _loc6_ = dataM.replaceStringInText(_loc6_,"%NAME%",dataM.myProfile.clanName);
         var _loc7_:BMNotificationData = new BMNotificationData(param2,_loc4_,_loc6_);
         param1.scheduleLocalNotification(_loc7_);
      }
      
      private static function cancelAllNotifications(param1:BMNotificationsManager) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in NOTIFICATION_IDS_TO_LOCALIZATION_KEYS)
         {
            param1.cancelLocalNotification(int(_loc2_));
         }
      }
   }
}

