package net.battleMechsMulti.managers.notifications
{
   import flash.net.SharedObject;
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class BMNotificationsManager
   {
      
      private static var _instance:BMNotificationsManager;
      
      public static const NO_NOTIFICATION_ID:int = -1;
      
      private static const DAY:int = 86400;
      
      private static const HOUR:int = 3600;
      
      private static const MINUTE:int = 60;
      
      internal var _first24hNotificationInTutorial:BMNotificationData = new BMNotificationData(2011,1,"Your Mech is rusting. Get Back to the Fight!");
      
      internal var _first24hNotificationAfterTutorial:BMNotificationData = new BMNotificationData(2010,1,"Attention Pilots: Strengthen your Mech with a FREE Gold box!","FREE Gold Box!",6);
      
      private var _sessionNotifications:Array = new Array(new BMNotificationData(1010,1,"Your daily bonus is available. Get it now!"),new BMNotificationData(1030,3,"Revive your Mech with a FREE Silver Box!","FREE Silver Box!",5,-1,100,-1,14),new BMNotificationData(1070,7,"Your Mech is getting rusty fix him up with a FREE Gold Box!","FREE Gold Box!",6,-1,100,14,-1),new BMNotificationData(1071,7,"Claim your FREE Mythical Box and destroy some Mechs!","FREE Mythical Box!",20,100,-1));
      
      private var _nonResetingNotifications:Array = [this._first24hNotificationAfterTutorial.id];
      
      private var _sharedObject:SharedObject;
      
      public function BMNotificationsManager()
      {
         super();
         this.initialize();
      }
      
      public static function getInstance() : BMNotificationsManager
      {
         if(_instance == null)
         {
            _instance = new BMNotificationsManager();
         }
         return _instance;
      }
      
      public static function gi() : BMNotificationsManager
      {
         return getInstance();
      }
      
      private function initialize() : void
      {
         this._sharedObject = SharedObject.getLocal("BMNotificationsManager");
         if(this._sharedObject.data.scheduledNotifications == null)
         {
            this._sharedObject.data.scheduledNotifications = {};
         }
         if(this._sharedObject.data.allowNotifications == null)
         {
            this._sharedObject.data.allowNotifications = true;
         }
      }
      
      private function setupRedeemable() : void
      {
         var _loc1_:BMNotificationData = this.findRedeemableNotification();
         if(_loc1_ != null)
         {
            this._sharedObject.data.redeemableNotificationID = _loc1_.id;
         }
      }
      
      private function unsetFirst12HNotifications() : *
      {
         this.cancelLocalNotification(this._first24hNotificationInTutorial.id);
      }
      
      private function setFirst12HNotifications() : *
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(_loc1_.isTutorialActive())
         {
            TsLogger.log("BMNotificationsManager :: First session segment - InTutorial");
            this.rescheduleNotification(this._first24hNotificationInTutorial);
         }
         else
         {
            TsLogger.log("BMNotificationsManager :: First session segment - AfterTutorial");
            this.unsetFirst12HNotifications();
            if(_loc1_.gameType != BMDataManager.GAME_TYPE_GUEST && !this.isScheduled(this._first24hNotificationAfterTutorial.id))
            {
               if(_loc1_.daysSinceRegistration() <= 4)
               {
                  TsLogger.log("BMNotificationsManager :: First session segment - First time");
                  this.rescheduleNotification(this._first24hNotificationAfterTutorial);
               }
               else
               {
                  this.trackNotificationEvent("BMNotificationsManager :: Finished tutorial after 4 days, unable to give box");
               }
            }
         }
      }
      
      private function get isFirstNotificationsTime() : *
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         return _loc1_.gameType == BMDataManager.GAME_TYPE_GUEST || _loc1_.hoursSinceRegistration() < 12;
      }
      
      public function refreshRetentionNotifications() : void
      {
         this.setupRedeemable();
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(this.isFirstNotificationsTime)
         {
            this.setFirst12HNotifications();
         }
         else if(!_loc1_.isTutorialActive())
         {
            TsLogger.log("BMNotificationsManager :: refreshRetentionNotifications Setting segment with: " + _loc1_.estimatedDollarsSpent() + " " + _loc1_.daysSinceRegistration());
            this.unsetFirst12HNotifications();
            this._sessionNotifications.forEach(this.rescheduleNotification);
         }
         this._sharedObject.flush();
      }
      
      private function rescheduleNotification(param1:BMNotificationData, param2:int = -1, param3:Array = null) : void
      {
         this.cancelLocalNotification(param1.id);
         var _loc4_:BMDataManager = BMDataManager.getInstance();
         if(param1.shouldShow(_loc4_.estimatedDollarsSpent(),_loc4_.daysSinceRegistration()))
         {
            this.scheduleLocalNotification(param1);
         }
      }
      
      private function get day() : int
      {
         return DAY;
      }
      
      private function cancelLocalNotification(param1:int) : *
      {
      }
      
      private function isScheduled(param1:int) : Boolean
      {
         return this._sharedObject.data.scheduledNotifications != null && this._sharedObject.data.scheduledNotifications[param1] != null;
      }
      
      private function scheduleLocalNotification(param1:BMNotificationData) : void
      {
         if(!this.allowNotifications)
         {
            return;
         }
      }
      
      private function getSecondsOffsetToShow(param1:Date = null) : int
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Date = param1;
         if(_loc2_ == null)
         {
            _loc2_ = new Date();
         }
         var _loc3_:int = _loc2_.hours;
         var _loc4_:int = -1 * (_loc2_.minutes * MINUTE + _loc2_.seconds);
         if(_loc3_ < 2 || _loc3_ >= 22)
         {
            _loc5_ = 0;
            if(_loc3_ < 2)
            {
               _loc5_ = -1 * _loc3_ * HOUR;
               _loc3_ = 24;
            }
            _loc6_ = -1 * ((_loc3_ - 22) * HOUR);
            return int(_loc5_ + _loc6_ + _loc4_);
         }
         if(_loc3_ >= 2 && _loc3_ < 8)
         {
            _loc8_ = (8 - _loc3_) * HOUR;
            return _loc8_ + _loc4_;
         }
         return 0;
      }
      
      public function trackNotificationEvent(param1:String, param2:int = -1, param3:Number = NaN) : *
      {
         BMDataManager.getInstance().trackEvent("Notification",param1,param2.toString(),param3);
      }
      
      private function findRedeemableNotification() : BMNotificationData
      {
         var _loc1_:int = -1;
         TsLogger.log("BMNotificationsManager :: foundId" + _loc1_);
         var _loc2_:BMNotificationData = this.getNotification(_loc1_);
         if(_loc2_ != null && _loc2_.boostID != -1)
         {
            return _loc2_;
         }
         return null;
      }
      
      private function getNotification(param1:int) : BMNotificationData
      {
         if(param1 == -1)
         {
            return null;
         }
         if(this._first24hNotificationInTutorial.id == param1)
         {
            return this._first24hNotificationInTutorial;
         }
         if(this._first24hNotificationAfterTutorial.id == param1)
         {
            return this._first24hNotificationAfterTutorial;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._sessionNotifications.length)
         {
            if(this._sessionNotifications[_loc2_].id == param1)
            {
               return this._sessionNotifications[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get hasRedeemableNotification() : Boolean
      {
         return this._sharedObject.data.redeemableNotificationID != null;
      }
      
      public function getRedeemableNotification() : BMNotificationData
      {
         if(!this.hasRedeemableNotification)
         {
            return null;
         }
         return this.getNotification(this._sharedObject.data.redeemableNotificationID);
      }
      
      public function redeemNotification(param1:Boolean = true) : void
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         if(this.hasRedeemableNotification)
         {
            _loc2_ = param1 ? "Redeemed" : "RedeemFailed";
            _loc3_ = this.getRedeemableNotification().id;
            this.trackNotificationEvent(_loc2_,_loc3_);
            this._sharedObject.data.redeemableNotificationID = null;
            if(this._nonResetingNotifications.indexOf(_loc3_) >= 0)
            {
               this.cancelLocalNotification(_loc3_);
            }
         }
      }
      
      public function reset() : *
      {
         this._sharedObject.data.redeemableNotificationID = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._sessionNotifications.length)
         {
            this.cancelLocalNotification(this._sessionNotifications[_loc1_].id);
            _loc1_++;
         }
         this._sharedObject.flush();
      }
      
      public function get allowNotifications() : Boolean
      {
         return this._sharedObject.data.allowNotifications;
      }
      
      public function set allowNotifications(param1:Boolean) : *
      {
         var _loc2_:* = this.allowNotifications;
         if(param1 != _loc2_)
         {
            this._sharedObject.data.allowNotifications = param1;
            if(param1)
            {
               this.refreshRetentionNotifications();
            }
            else
            {
               this.reset();
            }
         }
      }
   }
}

