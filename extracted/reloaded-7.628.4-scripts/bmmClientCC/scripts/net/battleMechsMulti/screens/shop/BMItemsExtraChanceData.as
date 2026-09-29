package net.battleMechsMulti.screens.shop
{
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMItemsExtraChanceData extends BMBaseClass
   {
      
      private var itemsExtraChanceData:Object;
      
      public function BMItemsExtraChanceData()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function setData(param1:String) : void
      {
         this.itemsExtraChanceData = null;
         if(param1 == null)
         {
            return;
         }
         if(param1 == "")
         {
            return;
         }
         this.itemsExtraChanceData = JSON.parse(param1);
      }
      
      public function get isAvailable() : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         if(this.itemsExtraChanceData == null)
         {
            return false;
         }
         if(dataM.myProfile.level < this.requiredLevel)
         {
            return false;
         }
         return true;
      }
      
      private function get duration() : uint
      {
         return this.itemsExtraChanceData["duration"];
      }
      
      private function get requiredLevel() : uint
      {
         return this.itemsExtraChanceData["requiredLevel"];
      }
      
      private function get startDate() : uint
      {
         var _loc1_:uint = dataM.myProfile.itemsExtraChanceStartDate;
         if(dataM.currentTime > _loc1_ + this.duration)
         {
            _loc1_ += Math.floor((dataM.currentTime - _loc1_) / this.duration) * this.duration;
            dataM.myProfile.itemsExtraChanceStartDate = _loc1_;
         }
         return _loc1_;
      }
      
      public function get endDate() : uint
      {
         return this.startDate + this.duration;
      }
      
      public function get timeLeft() : uint
      {
         return Math.max(0,this.endDate - dataM.currentTime);
      }
   }
}

