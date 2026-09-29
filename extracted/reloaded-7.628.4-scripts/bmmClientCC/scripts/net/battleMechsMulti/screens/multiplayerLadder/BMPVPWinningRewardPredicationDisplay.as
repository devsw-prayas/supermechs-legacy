package net.battleMechsMulti.screens.multiplayerLadder
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.screens.missionDifficulty.MissionReward;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMPVPWinningRewardPredicationDisplay extends MovieClip
   {
      
      public var mcReward1:MissionReward;
      
      public var mcReward2:MissionReward;
      
      public var mcReward3:MissionReward;
      
      public var mcCounter:TextHolder;
      
      public var mcTimer:BMTimer;
      
      private var _timerEnded:Function;
      
      private const REWARD_GOLD:String = "gold";
      
      private const REWARD_XP:String = "xp";
      
      private const REWARD_ARENA_COINS:String = "arenaCoins";
      
      private const REWARD_NUKES:String = "nukes";
      
      public function BMPVPWinningRewardPredicationDisplay()
      {
         super();
      }
      
      public function initialize(param1:Function) : void
      {
         var _loc3_:uint = 0;
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         mouseEnabled = false;
         mouseChildren = false;
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         if(_loc2_.pvpWinningRewardPredictionData.isEnabled() == false)
         {
            visible = false;
            return;
         }
         this._timerEnded = param1;
         if(_loc2_.pvpWinningRewardPredictionData.highRewardsLeftToday == 0)
         {
            _loc3_ = 5;
            if(_loc2_.pvpWinningRewardPredictionData.nextCycleStartTime > 0)
            {
               this.mcTimer.initialize(_loc2_.pvpWinningRewardPredictionData.getSecondsUntilNextCycleStart,this.onTimeEnd,_loc3_);
            }
            else
            {
               this.mcTimer.initialize(_loc2_.questsManager.getDailyQuestsSecLeft,this.onTimeEnd,_loc3_);
            }
            this.mcTimer.setTitle(BMLanguageManager.getInstance().getText("multiplayerLadder_betterRewardsIn"));
            this.mcCounter.visible = false;
            this.mcReward3.visible = false;
            return;
         }
         this.showRewardPrediction();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function showRewardPrediction() : void
      {
         var _loc4_:MissionReward = null;
         var _loc5_:String = null;
         if(visible == false)
         {
            return;
         }
         if(this.mcTimer != null)
         {
            this.mcTimer.visible = false;
         }
         this.mcCounter.visible = true;
         var _loc1_:uint = 1;
         var _loc2_:uint = 0;
         var _loc3_:Array = [this.REWARD_ARENA_COINS,this.REWARD_GOLD,this.REWARD_XP];
         while(_loc1_ <= 2 && _loc2_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc2_];
            _loc2_++;
            _loc4_ = this["mcReward" + _loc1_];
            if(this.displayReward(_loc5_,_loc4_))
            {
               _loc1_++;
            }
         }
         if(this.nukes > 0)
         {
            this.displayReward(this.REWARD_NUKES,this.mcReward3);
            this.mcReward1.x += 20;
            this.mcReward3.visible = true;
         }
         else
         {
            this.mcReward3.visible = false;
         }
         this.mcCounter.text = String(this.dataM.pvpWinningRewardPredictionData.highRewardsLeftToday);
      }
      
      private function displayReward(param1:String, param2:MissionReward) : Boolean
      {
         var _loc3_:uint = 0;
         switch(param1)
         {
            case this.REWARD_ARENA_COINS:
               _loc3_ = this.arenaCoins;
               break;
            case this.REWARD_GOLD:
               _loc3_ = this.gold;
               break;
            case this.REWARD_XP:
               _loc3_ = this.xp;
               break;
            case this.REWARD_NUKES:
               _loc3_ = this.nukes;
         }
         if(_loc3_ == 0)
         {
            return false;
         }
         param2.setIconByType(param1);
         param2.text = TextUtils.getNumberWithComma(_loc3_);
         param2.pushRightAccordingToContent();
         return true;
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private function get arenaCoins() : uint
      {
         return this.dataM.pvpWinningRewardPredictionData.reward.arenaCoins;
      }
      
      private function get gold() : uint
      {
         return this.dataM.pvpWinningRewardPredictionData.reward.gold;
      }
      
      private function get xp() : uint
      {
         return this.dataM.pvpWinningRewardPredictionData.reward.xp;
      }
      
      private function get nukes() : uint
      {
         return this.dataM.pvpWinningRewardPredictionData.reward.nukes;
      }
      
      private function onTimeEnd() : void
      {
         this._timerEnded();
      }
   }
}

