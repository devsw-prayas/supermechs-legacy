package net.battleMechsMulti.managers
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.sales.BMSale;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.screens.arenaShop.BMPlayerSkillData;
   
   public class BMBattleCreditsManager extends BMBaseClass
   {
      
      private var _currentTimeTimer:Timer;
      
      private var _secondsLeftForBattleCreditAddon:Number;
      
      private var _battleCreditsChangeCallbacks:Array;
      
      public function BMBattleCreditsManager()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function activateMe() : void
      {
         this.stopTimer();
         this._battleCreditsChangeCallbacks = new Array();
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
      
      public function get battleCreditsMax() : uint
      {
         var _loc3_:Number = NaN;
         var _loc1_:uint = dataM.battleCreditsMax;
         var _loc2_:int = dataM.playerSkillsManager.getSkillIDByType(BMPlayerSkillData.TYPE_BATTLE_CREDITS_MAX);
         if(_loc2_ >= 0)
         {
            _loc3_ = dataM.playerSkillsManager.getSkillCurrentLevelBonus(dataM.player1PlayerID,_loc2_);
            _loc1_ += _loc3_;
         }
         return _loc1_;
      }
      
      public function get secondsForNewBattleCredit() : uint
      {
         var _loc1_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:BMSale = null;
         var _loc2_:uint = dataM.secondsForNewBattleCredit;
         if(dataM.myProfile.tokensSpent > 0)
         {
            _loc2_ = dataM.secondsForNewBattleCredit_supporters;
         }
         var _loc3_:int = dataM.playerSkillsManager.getSkillIDByType(BMPlayerSkillData.TYPE_BATTLE_CREDITS_REGEN);
         if(_loc3_ >= 0)
         {
            _loc4_ = dataM.playerSkillsManager.getSkillCurrentLevelBonus(dataM.player1PlayerID,_loc3_);
            if(_loc4_ > 0)
            {
               _loc1_ = 100 - _loc4_;
               _loc2_ = uint(int(Math.ceil(_loc2_ * _loc1_ / 100)));
            }
         }
         if(BMSalesManager.gi().isSaleActive(dataM.currentTime))
         {
            _loc5_ = BMSalesManager.gi().getSaleData();
            if(_loc5_.saleStoreSection == BMSale.STORE_SECTION_CAMPAIGN_BATTLE_CREDITS_REGENERATION)
            {
               _loc1_ = 100 - _loc5_.saleEffect;
               _loc2_ = uint(int(Math.ceil(_loc2_ * _loc1_ / 100)));
            }
         }
         return _loc2_;
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
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
         {
            _loc2_ = dataM.currentTime - dataM.lastBattleCreditAddon;
            if(_loc2_ >= this.secondsForNewBattleCredit)
            {
               _loc3_ = Math.floor(_loc2_ / this.secondsForNewBattleCredit);
               _loc4_ = _loc2_ - _loc3_ * this.secondsForNewBattleCredit;
               if(_loc3_ > 0)
               {
                  if(dataM.myProfile.battleCredits + _loc3_ > this.battleCreditsMax)
                  {
                     _loc3_ = this.battleCreditsMax - dataM.myProfile.battleCredits;
                  }
               }
               dataM.lastBattleCreditAddon = dataM.currentTime - _loc4_;
               if(_loc3_ > 0)
               {
                  dataM.myProfile.battleCredits += _loc3_;
                  this.sendDataToBattleCreditsChangeCallbacks();
               }
            }
            this._secondsLeftForBattleCreditAddon = this.secondsForNewBattleCredit - _loc2_;
         }
      }
      
      public function setBattleCredits(param1:uint) : void
      {
         dataM.myProfile.battleCredits = param1;
         this.sendDataToBattleCreditsChangeCallbacks();
      }
      
      public function setBattleCreditsToMax() : void
      {
         var _loc1_:int = int(this.battleCreditsMax);
         if(dataM.myProfile.battleCredits >= _loc1_)
         {
            return;
         }
         dataM.myProfile.setBattleCredits(_loc1_);
         this.sendDataToBattleCreditsChangeCallbacks();
      }
      
      public function getSecondsLeftForBattleCreditAddon() : Number
      {
         return this._secondsLeftForBattleCreditAddon;
      }
      
      public function addBattleCreditsChangeCallback(param1:Function) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._battleCreditsChangeCallbacks.length)
         {
            if(param1 == this._battleCreditsChangeCallbacks[_loc2_])
            {
               return;
            }
            _loc2_++;
         }
         this._battleCreditsChangeCallbacks.push(param1);
      }
      
      public function removeBattleCreditsChangeCallback(param1:Function) : void
      {
         var _loc2_:Number = this._battleCreditsChangeCallbacks.length - 1;
         while(_loc2_ >= 0)
         {
            if(param1 == this._battleCreditsChangeCallbacks[_loc2_])
            {
               this._battleCreditsChangeCallbacks.splice(_loc2_,1);
            }
            _loc2_--;
         }
      }
      
      public function clearBattleCreditsChangeCallbacks() : void
      {
         this._battleCreditsChangeCallbacks = new Array();
      }
      
      private function sendDataToBattleCreditsChangeCallbacks() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._battleCreditsChangeCallbacks.length)
         {
            this._battleCreditsChangeCallbacks[_loc1_](dataM.myProfile.battleCredits);
            _loc1_++;
         }
      }
   }
}

