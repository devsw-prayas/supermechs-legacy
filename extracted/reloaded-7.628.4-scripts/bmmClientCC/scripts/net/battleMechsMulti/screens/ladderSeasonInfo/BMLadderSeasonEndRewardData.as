package net.battleMechsMulti.screens.ladderSeasonInfo
{
   public class BMLadderSeasonEndRewardData
   {
      
      public var groupName:String = "";
      
      public var ladderLevelRequired:uint = 0;
      
      public var rewardGachaMachineIDs:Array = [];
      
      public var ID:uint = 0;
      
      public var totalInList:uint = 0;
      
      public var playerIsHere:Boolean = false;
      
      public function BMLadderSeasonEndRewardData(param1:uint, param2:uint, param3:String, param4:uint, param5:Array)
      {
         super();
         this.ID = param1;
         this.totalInList = param2;
         this.groupName = param3;
         this.ladderLevelRequired = param4;
         this.rewardGachaMachineIDs = param5;
      }
   }
}

