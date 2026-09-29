package net.battleMechsMulti.managers.shop
{
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMVIPAccountData
   {
      
      public function BMVIPAccountData()
      {
         super();
      }
      
      public function get isVIPAccountActive() : Boolean
      {
         return this.vipAccountSecondsLeft > this.secondsUntilNextDailyBonus;
      }
      
      public function get vipAccountSecondsLeft() : int
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(this.dataM.dailyLoginStreakBonus != null && this.dataM.dailyLoginStreakBonus.hasOwnProperty("vipStatusEndTime"))
         {
            _loc1_ = Number(this.dataM.dailyLoginStreakBonus.vipStatusEndTime);
            _loc2_ = _loc1_ - BMDataManager.getInstance().currentTime;
            _loc3_ = _loc2_;
            if(_loc3_ > 0)
            {
               return _loc3_;
            }
         }
         return -1;
      }
      
      public function get secondsUntilNextDailyBonus() : int
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(this.dataM.dailyLoginStreakBonus != null && this.dataM.dailyLoginStreakBonus.hasOwnProperty("nextBonusTime"))
         {
            _loc1_ = Number(this.dataM.dailyLoginStreakBonus.nextBonusTime);
            _loc2_ = _loc1_ - BMDataManager.getInstance().currentTime;
            _loc3_ = _loc2_;
            if(_loc3_ > 0)
            {
               return _loc3_;
            }
         }
         return -1;
      }
      
      public function get dailyTokensForVIPAccount() : int
      {
         return this.dataM.getGeneralSetting("vipTokensPerDay",25);
      }
      
      public function get vipReward() : BMRewardData
      {
         if(this.dataM.dailyLoginStreakBonus != null && this.dataM.dailyLoginStreakBonus.hasOwnProperty("vipReward"))
         {
            return this.dataM.dailyLoginStreakBonus.vipReward;
         }
         return null;
      }
      
      public function resetReward() : void
      {
         if(this.dataM.dailyLoginStreakBonus != null && this.dataM.dailyLoginStreakBonus.hasOwnProperty("vipReward"))
         {
            this.dataM.dailyLoginStreakBonus.vipReward = null;
         }
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      public function notifyVIPAccountUpdated(param1:Number, param2:BMRewardData) : void
      {
         this.dataM.dailyLoginStreakBonus.vipStatusEndTime = param1;
         this.dataM.dailyLoginStreakBonus.vipReward = param2;
         BMPubSub.pub(BMPubSub.VIP_ACCOUNT_UPDATED,this);
      }
   }
}

