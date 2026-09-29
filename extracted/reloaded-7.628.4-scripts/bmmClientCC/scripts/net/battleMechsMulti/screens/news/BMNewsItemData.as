package net.battleMechsMulti.screens.news
{
   public class BMNewsItemData
   {
      
      public var newsID:uint;
      
      public var dataID:uint = 0;
      
      public var priority:uint = 0;
      
      public var newsTitle:String = "";
      
      public var newsText:String = "";
      
      public var imageUrl:String = "";
      
      public var newsPageLink:String = "";
      
      public var startDate:uint;
      
      public var duration:uint;
      
      public var sticky:Boolean = false;
      
      public var category:uint = 0;
      
      public var clickTarget:uint = 0;
      
      public var clickTargetItemID:uint = 0;
      
      public var platform:uint = 0;
      
      public var languageID:uint = 0;
      
      private var _ignoreAlerts:Boolean = false;
      
      public function BMNewsItemData(param1:Object, param2:Boolean = false)
      {
         super();
         this._ignoreAlerts = param2;
         this.newsID = this.setValue(param1,"newsID");
         this.dataID = this.setValue(param1,"dataID");
         this.priority = this.setValue(param1,"priority");
         this.newsTitle = this.setString(param1,"newsTitle");
         this.newsText = this.setString(param1,"newsText");
         this.imageUrl = this.setString(param1,"imageUrl");
         this.newsPageLink = this.setString(param1,"newsPageLink");
         this.startDate = this.setValue(param1,"startDate");
         this.duration = this.setValue(param1,"duration");
         this.sticky = this.setBoolean(param1,"sticky");
         this.category = this.setValue(param1,"category");
         this.clickTarget = this.setValue(param1,"clickTarget");
         this.clickTargetItemID = this.setValue(param1,"clickTargetItemID");
         this.platform = this.setValue(param1,"platform");
         this.languageID = this.setValue(param1,"languageID");
      }
      
      private function setValue(param1:Object, param2:String) : uint
      {
         if(param1[param2] == null)
         {
            if(this._ignoreAlerts == false)
            {
            }
         }
         return uint(param1[param2]);
      }
      
      private function setString(param1:Object, param2:String) : String
      {
         if(param1[param2] == null)
         {
            if(this._ignoreAlerts == false)
            {
            }
         }
         if(param1[param2])
         {
            return String(param1[param2]);
         }
         if(this._ignoreAlerts == false)
         {
         }
         return "";
      }
      
      private function setBoolean(param1:Object, param2:String) : Boolean
      {
         if(param1[param2] == null)
         {
            if(this._ignoreAlerts == false)
            {
            }
         }
         return int(param1[param2]) == 1;
      }
   }
}

