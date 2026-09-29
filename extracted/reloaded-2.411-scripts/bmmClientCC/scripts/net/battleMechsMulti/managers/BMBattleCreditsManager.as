package net.battleMechsMulti.managers
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   public class BMBattleCreditsManager extends BMBaseClass
   {
      
      private var _currentTimeTimer:Timer;
      
      private var _secondsLeftForBattleCreditAddon:Number;
      
      public function BMBattleCreditsManager()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function activateMe() : void
      {
         this.stopTimer();
         this._currentTimeTimer = new Timer(1000,0);
         this._currentTimeTimer.start();
         this._currentTimeTimer.addEventListener(TimerEvent.TIMER,this.battleCreditsTimerHandler);
         TsLogger.log("BMBattleCreditsManager activated");
      }
      
      public function deactivateMe() : void
      {
         this.stopTimer();
         TsLogger.log("BMBattleCreditsManager deactivated");
      }
      
      private function stopTimer() : void
      {
         if(this._currentTimeTimer != null)
         {
            this._currentTimeTimer.stop();
            this._currentTimeTimer.removeEventListener(TimerEvent.TIMER,this.battleCreditsTimerHandler);
            this._currentTimeTimer = null;
         }
      }
      
      private function battleCreditsTimerHandler(param1:TimerEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(FeatureFlags.PLAYER_ENERGY && dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
         {
            _loc2_ = dataM.battleCreditsMax;
            _loc3_ = dataM.secondsForNewBattleCredit;
            if(dataM.myProfile.tokensSpent > 0)
            {
               _loc2_ = dataM.battleCreditsMax_supporters;
               _loc3_ = dataM.secondsForNewBattleCredit_supporters;
            }
            _loc4_ = dataM.currentTime - dataM.lastBattleCreditAddon;
            if(_loc4_ >= _loc3_)
            {
               _loc5_ = Math.floor(_loc4_ / _loc3_);
               _loc6_ = _loc4_ - _loc5_ * _loc3_;
               if(_loc5_ > 0)
               {
                  if(dataM.myProfile.battleCredits + _loc5_ > _loc2_)
                  {
                     _loc5_ = _loc2_ - dataM.myProfile.battleCredits;
                  }
               }
               dataM.lastBattleCreditAddon = dataM.currentTime - _loc6_;
               if(_loc5_ > 0)
               {
                  dataM.myProfile.battleCredits += _loc5_;
               }
            }
            this._secondsLeftForBattleCreditAddon = _loc3_ - _loc4_;
            if(screensM.isScreenOpened("screenMissionWorldMap"))
            {
               screensM.screenMissionWorldMap.refreshBattleCredits();
            }
         }
      }
      
      public function setBattleCreditsToMax() : void
      {
         dataM.myProfile.setBattleCredits(this.getMaxBattleCredits());
         if(screensM.isScreenOpened("screenMissionWorldMap"))
         {
            screensM.screenMissionWorldMap.refreshBattleCredits();
         }
      }
      
      public function getMaxBattleCredits() : Number
      {
         var _loc1_:uint = dataM.battleCreditsMax;
         if(dataM.myProfile.tokensSpent > 0)
         {
            _loc1_ = dataM.battleCreditsMax_supporters;
         }
         return _loc1_;
      }
      
      public function getSecondsLeftForBattleCreditAddon() : Number
      {
         return this._secondsLeftForBattleCreditAddon;
      }
   }
}

