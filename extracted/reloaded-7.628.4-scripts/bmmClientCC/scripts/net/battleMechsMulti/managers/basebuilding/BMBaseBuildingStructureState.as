package net.battleMechsMulti.managers.basebuilding
{
   public class BMBaseBuildingStructureState
   {
      
      public var type:uint;
      
      public var level:uint;
      
      public var upgradeFinishTime:uint;
      
      public var goldMineLastCollectTime:uint;
      
      public var itemFactoryItemsInQueue:uint;
      
      public var itemFactoryQueueFinishTime:uint;
      
      public var itemFactoryItemTypeInQueue:uint;
      
      public function BMBaseBuildingStructureState(param1:Object)
      {
         super();
         this.type = param1.type;
         this.level = param1.level;
         this.upgradeFinishTime = param1.upgradeFinishTime;
         if(this.type == BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE)
         {
            this.goldMineLastCollectTime = param1.lastCollectTime;
         }
         if(this.type == BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY)
         {
            this.itemFactoryItemsInQueue = param1.itemsInQueue;
            this.itemFactoryQueueFinishTime = param1.queueFinishTime;
            this.itemFactoryItemTypeInQueue = param1.itemTypeInQueue;
         }
      }
   }
}

