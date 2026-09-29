package net.battleMechsMulti.screens.multiplayerLadder
{
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   
   public class BMPVPWinningRewardPredictionData
   {
      
      private var _reward:BMRewardData = new BMRewardData();
      
      private var _highRewardsLeftToday:uint = 0;
      
      private var _nextCycleStartTime:uint = 0;
      
      public function BMPVPWinningRewardPredictionData()
      {
         super();
      }
      
      public function updateData(param1:Object) : void
      {
         if(this.isEnabled() == false)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.reward == null)
         {
            return;
         }
         if(param1.highRewardsLeftToday == null)
         {
            return;
         }
         this._reward = new BMRewardData(param1.reward);
         this._highRewardsLeftToday = param1.highRewardsLeftToday;
         if(param1.nextCycleStartTime != null)
         {
            this._nextCycleStartTime = param1.nextCycleStartTime;
         }
         else
         {
            this._nextCycleStartTime = 0;
         }
      }
      
      public function get reward() : BMRewardData
      {
         if(this.isEnabled() == false)
         {
            return new BMRewardData();
         }
         return this._reward;
      }
      
      public function get highRewardsLeftToday() : uint
      {
         if(this.isEnabled() == false)
         {
            return 0;
         }
         return this._highRewardsLeftToday;
      }
      
      public function get nextCycleStartTime() : uint
      {
         if(this.isEnabled() == false)
         {
            return 0;
         }
         return this._nextCycleStartTime;
      }
      
      public function getSecondsUntilNextCycleStart() : uint
      {
         if(this.isEnabled() == false)
         {
            return 0;
         }
         return this._nextCycleStartTime - BMDataManager.getInstance().currentTime;
      }
      
      public function isEnabled() : Boolean
      {
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return false;
         }
         if(BMDataManager.getInstance().getGeneralSetting("pvpWinningRewardPredictionEnabled",0) == 0)
         {
            return false;
         }
         return true;
      }
   }
}

