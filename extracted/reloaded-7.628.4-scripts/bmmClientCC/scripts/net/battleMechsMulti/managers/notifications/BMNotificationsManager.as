package net.battleMechsMulti.managers.notifications
{
   import com.distriqt.extension.notifications.AuthorisationStatus;
   import com.distriqt.extension.notifications.Notifications;
   import com.distriqt.extension.notifications.Service;
   import com.distriqt.extension.notifications.builders.ChannelBuilder;
   import com.distriqt.extension.notifications.builders.NotificationBuilder;
   import com.distriqt.extension.notifications.events.AuthorisationEvent;
   import flash.net.SharedObject;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingNotificationHelper;
   import net.battleMechsMulti.managers.raid.BMRaidNotificationsHelper;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   public class BMNotificationsManager extends BMBaseClass
   {
      
      private static var _instance:BMNotificationsManager;
      
      public static const NO_NOTIFICATION_ID:int = -1;
      
      private static const DAY:int = 86400;
      
      private static const HOUR:int = 3600;
      
      private static const MINUTE:int = 60;
      
      private static const fakeNotificationID:int = 0;
      
      private static var _fakeNotificationApplied:* = false;
      
      internal var _first24hNotificationInTutorial:BMNotificationData = new BMNotificationData(2011,1,"Your Mech is rusting. Get Back to the Fight!");
      
      internal var _first24hNotificationAfterTutorial:BMNotificationData = new BMNotificationData(2010,1,"Attention Pilots: Boost your Mech with 10K Gold Coins!","FREE 10k Gold!",2010);
      
      internal var _first24hLongTermNotifications:Array = new Array(new BMNotificationData(1011,3,"Your daily bonus is available. Get it now!"),new BMNotificationData(1012,5,"Your daily bonus is available. Get it now!"),new BMNotificationData(1013,7,"Your daily bonus is available. Get it now!"),new BMNotificationData(1014,9,"Your daily bonus is available. Get it now!"),new BMNotificationData(1015,11,"Your daily bonus is available. Get it now!"),new BMNotificationData(1016,13,"Your daily bonus is available. Get it now!"));
      
      private var _sessionNotifications:Array = new Array(new BMNotificationData(1010,1,"Your daily bonus is available. Get it now!"),new BMNotificationData(1012,5,"Your daily bonus is available. Get it now!"),new BMNotificationData(1014,9,"Your daily bonus is available. Get it now!"),new BMNotificationData(1015,11,"Your daily bonus is available. Get it now!"),new BMNotificationData(1016,13,"Your daily bonus is available. Get it now!"),new BMNotificationData(1030,3,"Revive your Mech with a FREE Silver Box, 1 GUARANTEED Epic!","FREE Silver Box!",3,-1,100,-1,14),new BMNotificationData(1070,7,"Your Mech is getting rusty tune it up with 75k Gold Coins!","FREE Gold Box!",1070,-1,100,14,-1),new BMNotificationData(1072,3,"Earth Needs You! Get Back to the Fight with 1 FREE Premium Box!","FREE Premium Box!",2,100,-1),new BMNotificationData(1071,7,"Your Mech is Getting Rusty! Get Back to the Fight with 2 FREE Premium Items!","2 FREE Premium Items!",1071,100,-1));
      
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
      
      public static function hasInstance() : Boolean
      {
         return _instance != null;
      }
      
      private static function authorisationChangedHandler(param1:AuthorisationEvent) : void
      {
         TsLogger.log("Distriqt authorisationChangedHandler: " + param1.status);
      }
      
      private function initialize() : void
      {
         var service:Service = null;
         generateSingletonClassesPointers();
         this._sharedObject = SharedObject.getLocal("BMNotificationsManager");
         if(this._sharedObject.data.scheduledNotifications == null)
         {
            this._sharedObject.data.scheduledNotifications = {};
         }
         if(this._sharedObject.data.allowNotifications == null)
         {
            this._sharedObject.data.allowNotifications = true;
         }
         try
         {
            if(Notifications.isSupported)
            {
               TsLogger.log("Inited Distriqt Notifications");
            }
         }
         catch(e:Error)
         {
            TsLogger.log("Unable to init Distriqt");
            TsLogger.log(e);
         }
         if(!Notifications.isSupported)
         {
            TsLogger.log("BMNotificationsManager :: Notifications is not supported on this platform.");
            return;
         }
         TsLogger.log("BMNotificationsManager :: initializing Notifications...");
         Notifications.service.addEventListener(AuthorisationEvent.CHANGED,authorisationChangedHandler);
         service = new Service();
         service.channels.push(new ChannelBuilder().setId("main_channel").setName("Main Channel").build());
         Notifications.service.setup(service);
         switch(Notifications.service.authorisationStatus())
         {
            case AuthorisationStatus.AUTHORISED:
               Notifications.service.register();
               TsLogger.log("Distriqt authorisation: " + AuthorisationStatus.AUTHORISED);
               break;
            case AuthorisationStatus.NOT_DETERMINED:
               Notifications.service.requestAuthorisation();
               TsLogger.log("Distriqt authorisation: " + AuthorisationStatus.NOT_DETERMINED);
               break;
            case AuthorisationStatus.DENIED:
               TsLogger.log("Distriqt authorisation: " + AuthorisationStatus.DENIED);
         }
         this.refreshRetentionNotifications();
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
         var _loc1_:* = 0;
         while(_loc1_ < this._first24hLongTermNotifications.length)
         {
            this.cancelLocalNotification(this._first24hLongTermNotifications[_loc1_].id);
            _loc1_++;
         }
      }
      
      private function setFirst12HNotifications() : *
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(tutorialM.isTutorialActive())
         {
            TsLogger.log("BMNotificationsManager :: First session segment - InTutorial");
            this.rescheduleNotification(this._first24hNotificationInTutorial);
         }
         else
         {
            TsLogger.log("BMNotificationsManager :: First session segment - AfterTutorial");
            this.unsetFirst12HNotifications();
            if(_loc1_.gameType == BMDataManager.GAME_TYPE_DEFAULT && !this.isScheduled(this._first24hNotificationAfterTutorial.id))
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
         this._first24hLongTermNotifications.forEach(this.rescheduleNotification);
      }
      
      private function get isFirstNotificationsTime() : *
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:Boolean = _loc1_.player1PlayerID == _loc1_.ONLINE_PLAYER_ID;
         return !_loc2_ || _loc1_.hoursSinceRegistration() < 12;
      }
      
      public function refreshRetentionNotifications() : void
      {
         var dataM:BMDataManager;
         if(FeatureFlags.DISABLE_LOCAL_NOTIFICATIONS)
         {
            return;
         }
         this.setupRedeemable();
         dataM = BMDataManager.getInstance();
         if(this.isFirstNotificationsTime)
         {
            this.setFirst12HNotifications();
         }
         else if(!tutorialM.isTutorialActive())
         {
            TsLogger.log("BMNotificationsManager :: refreshRetentionNotifications Setting segment with: " + dataM.estimatedDollarsSpent() + " " + dataM.daysSinceRegistration());
            this.unsetFirst12HNotifications();
            this._sessionNotifications.forEach(this.rescheduleNotification);
         }
         BMBaseBuildingNotificationHelper.updateLocalNotifications(this);
         BMRaidNotificationsHelper.updateLocalNotifications(this);
         try
         {
            this._sharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("BMNotificationsManager Error: couldn\'t load shared object");
         }
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
      
      public function cancelLocalNotification(param1:int) : *
      {
         TsLogger.log("BMNotificationsManager :: cancelLocalNotification id:" + param1);
         this._sharedObject.data.scheduledNotifications[param1] = null;
         Notifications.service.cancel(param1);
      }
      
      private function isScheduled(param1:int) : Boolean
      {
         return this._sharedObject.data.scheduledNotifications != null && this._sharedObject.data.scheduledNotifications[param1] != null;
      }
      
      public function scheduleLocalNotification(param1:BMNotificationData) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!this.allowNotifications)
         {
            return;
         }
         _loc2_ = param1.intervalDays * this.day + this.getSecondsOffsetToShow();
         _loc3_ = new Date().time / 1000 + _loc2_;
         TsLogger.log("BMNotificationsManager :: scheduleLocalNotification id:" + param1.id + " secDelay:" + _loc2_);
         this._sharedObject.data.scheduledNotifications[param1.id] = {
            "id":param1.id,
            "timeToShow":_loc3_
         };
         Notifications.service.notify(new NotificationBuilder().setTitle("SuperMechs").setBody(param1.text).setId(param1.id).setIcon("ic_stat_notification").setCount(1).setDelay(_loc2_).build());
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
         BMDataManager.getInstance().trackEvent(BMDataManager.ANALYTICS_PRIORITY_LOWEST,"Notification",param1,param2.toString(),param3);
      }
      
      private function findRedeemableNotification() : BMNotificationData
      {
         var _loc2_:BMNotificationData = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:BMNotificationData = null;
         var _loc1_:int = -1;
         _loc3_ = int.MAX_VALUE;
         _loc4_ = new Date().time / 1000;
         for each(_loc5_ in this._sharedObject.data.scheduledNotifications)
         {
            if(_loc5_ != null)
            {
               _loc6_ = _loc4_ - _loc5_.timeToShow;
               _loc7_ = this.getNotification(_loc5_.id);
               if(_loc7_ != null && _loc7_.boostID != -1)
               {
                  if(_loc6_ >= 0 && _loc6_ < _loc3_)
                  {
                     _loc1_ = int(_loc5_.id);
                     _loc3_ = _loc6_;
                  }
               }
            }
         }
         TsLogger.log("BMNotificationsManager :: foundId" + _loc1_);
         _loc2_ = this.getNotification(_loc1_);
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
         if(fakeNotificationID)
         {
            return !_fakeNotificationApplied;
         }
         return this._sharedObject.data.redeemableNotificationID != null;
      }
      
      public function getRedeemableNotification() : BMNotificationData
      {
         if(fakeNotificationID)
         {
            return this.getNotification(fakeNotificationID);
         }
         if(FeatureFlags.DISABLE_LOCAL_NOTIFICATIONS)
         {
            return null;
         }
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
            _fakeNotificationApplied = true;
            this._sharedObject.data.redeemableNotificationID = null;
            if(this._nonResetingNotifications.indexOf(_loc3_) >= 0)
            {
               this.cancelLocalNotification(_loc3_);
            }
         }
      }
      
      public function reset() : *
      {
         var i:int;
         _fakeNotificationApplied = true;
         this._sharedObject.data.redeemableNotificationID = null;
         i = 0;
         while(i < this._sessionNotifications.length)
         {
            this.cancelLocalNotification(this._sessionNotifications[i].id);
            i++;
         }
         BMBaseBuildingNotificationHelper.cancelLocalNotifications(this);
         try
         {
            this._sharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("BMNotificationsManager Error: couldn\'t load shared object");
         }
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

