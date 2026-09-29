package net.battleMechsMulti.managers.inventory
{
   public class InventorySizeState
   {
      
      public var maxSize:int = 100;
      
      public var expansionTokensCost:int;
      
      public var expansionSlotsIncrease:int;
      
      public var gracePeriodFinishTime:int = 0;
      
      public function InventorySizeState(param1:Object = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.maxSize = param1.maxSize;
         this.expansionTokensCost = param1.expansionTokensCost;
         this.expansionSlotsIncrease = param1.expansionSlotsIncrease;
         if(param1.hasOwnProperty("gracePeriodFinishTime"))
         {
            this.gracePeriodFinishTime = param1.gracePeriodFinishTime;
         }
      }
      
      public function isInGracePeriod() : Boolean
      {
         return this.gracePeriodFinishTime > 0;
      }
   }
}

