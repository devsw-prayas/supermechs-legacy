package net.battleMechsMulti.data
{
   public class BMBattleResultData
   {
      
      public var totalPlayerGold:int;
      
      public var totalPlayerXP:int;
      
      public var totalPlayerNukes:int;
      
      public var reward:BMRewardData;
      
      public var ladderProgress:int;
      
      public var currentSeasonHighestLadderProgress:uint;
      
      public var replay:Object;
      
      public var totalCalls:int;
      
      public var rewardReduced:Boolean;
      
      public var rankingListPosition:uint;
      
      public function BMBattleResultData(param1:Object)
      {
         super();
         if(param1.status != true || param1.cmd != "BMM_BATTLE_RESULT")
         {
            throw new Error("Data not match for battle result: " + JSON.stringify(param1));
         }
         this.totalPlayerGold = param1.totalPlayerGold;
         this.totalPlayerXP = param1.totalPlayerXP;
         this.totalPlayerNukes = param1.totalPlayerNukes;
         this.reward = new BMRewardData(param1.reward);
         this.ladderProgress = param1.ladderProgress;
         this.currentSeasonHighestLadderProgress = param1.currentSeasonHighestLadderProgress;
         this.replay = param1.replay;
         this.totalCalls = param1.totalCalls;
         this.rewardReduced = param1.rewardReduced;
         this.rankingListPosition = param1.rankingListPosition;
      }
   }
}

