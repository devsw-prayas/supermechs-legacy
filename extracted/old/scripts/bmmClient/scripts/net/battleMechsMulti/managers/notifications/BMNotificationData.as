package net.battleMechsMulti.managers.notifications
{
   public class BMNotificationData
   {
      
      public var id:int;
      
      public var intervalDays:int;
      
      public var text:String;
      
      public var popupText:String;
      
      public var boostID:int;
      
      public var notificationIcon:String;
      
      private var minLTV:int;
      
      private var maxLTV:int;
      
      private var minDaysPlayed:int;
      
      private var maxDaysPlayed:int;
      
      public function BMNotificationData(param1:int, param2:int, param3:String, param4:String = "", param5:int = -1, param6:int = -1, param7:int = -1, param8:int = -1, param9:int = -1, param10:String = "NotificationIconLarge.png")
      {
         super();
         this.id = param1;
         this.intervalDays = param2;
         this.text = param3;
         this.popupText = param4;
         this.boostID = param5;
         this.notificationIcon = param10;
         this.minLTV = param6;
         this.maxLTV = param7;
         this.minDaysPlayed = param8;
         this.maxDaysPlayed = param9;
      }
      
      public function shouldShow(param1:int, param2:int) : Boolean
      {
         if(this.minLTV != -1 && param1 < this.minLTV)
         {
            return false;
         }
         if(this.maxLTV != -1 && param1 >= this.maxLTV)
         {
            return false;
         }
         if(this.minDaysPlayed != -1 && param2 < this.minDaysPlayed)
         {
            return false;
         }
         if(this.maxDaysPlayed != -1 && param2 >= this.maxDaysPlayed)
         {
            return false;
         }
         return true;
      }
   }
}

