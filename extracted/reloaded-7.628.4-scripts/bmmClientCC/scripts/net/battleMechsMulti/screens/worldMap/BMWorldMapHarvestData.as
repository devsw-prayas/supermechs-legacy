package net.battleMechsMulti.screens.worldMap
{
   public class BMWorldMapHarvestData
   {
      
      public var missionSlot:uint;
      
      public var cooldown:uint;
      
      public var gold:Array;
      
      public function BMWorldMapHarvestData(param1:uint, param2:uint, param3:Array)
      {
         super();
         this.missionSlot = param1;
         this.cooldown = param2;
         this.gold = param3;
      }
   }
}

