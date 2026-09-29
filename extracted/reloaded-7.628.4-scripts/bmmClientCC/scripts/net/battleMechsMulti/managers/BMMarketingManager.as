package net.battleMechsMulti.managers
{
   public class BMMarketingManager
   {
      
      private static var _giftKeys:Array = [];
      
      private static var _targetScreen:int = 0;
      
      private static var _unseenNotifications:Array = [];
      
      public function BMMarketingManager()
      {
         super();
      }
      
      public static function setTargetScreen(param1:int) : void
      {
         _targetScreen = param1;
      }
      
      public static function getTargetScreenAndClear() : int
      {
         var _loc1_:int = _targetScreen;
         _targetScreen = 0;
         return _loc1_;
      }
      
      public static function addGiftKey(param1:String) : void
      {
         _giftKeys.push(param1);
      }
      
      public static function getGiftKeysAndClear() : Array
      {
         var _loc1_:Array = _giftKeys.concat();
         _giftKeys.length = 0;
         return _loc1_;
      }
      
      public static function addUnseenNotification(param1:String) : void
      {
         _unseenNotifications.push(param1);
      }
      
      public static function getUnseenNotificationsAndClear() : Array
      {
         var _loc1_:Array = _unseenNotifications.concat();
         _unseenNotifications.length = 0;
         return _loc1_;
      }
   }
}

