package net.battleMechsMulti.managers.quests
{
   import flash.utils.Dictionary;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMGoogleGamesManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMCompletedQuestData;
   
   public class BMQuestsManager extends BMBaseClass
   {
      
      public static const TYPE_DAILY_QUEST:uint = 1;
      
      public static const TYPE_ACHIEVEMENT_QUEST:uint = 2;
      
      public static const SUB_TYPE_COMPLETE_ALL_DAILY_QUESTS:uint = 1;
      
      public static const SUB_TYPE_PVE_WINS:uint = 2;
      
      public static const SUB_TYPE_PVP_WINS:uint = 3;
      
      public static const SUB_TYPE_COMPLETE_CAMPAIGN_CHAPTER:uint = 4;
      
      public static const SUB_TYPE_KILL_BOSS:uint = 5;
      
      public static const SUB_TYPE_COMPLETE_CAMPAIGN_MISSIONS:uint = 6;
      
      public static const SUB_TYPE_BOOST_ITEM:uint = 7;
      
      public static const SUB_TYPE_TRANSFORM_ITEM:uint = 8;
      
      public static const SUB_TYPE_TOTAL_ITEM_BOOSTS:uint = 9;
      
      public static const SUB_TYPE_EARN_GOLD:uint = 10;
      
      public static const SUB_TYPE_BUY_ITEM_BOXES:uint = 11;
      
      public static const SUB_TYPE_JOIN_OR_CREATE_A_CLAN:uint = 12;
      
      public static const SUB_TYPE_TOTAL_MECHS:uint = 13;
      
      public static const SUB_TYPE_SPEND_TOKENS:uint = 14;
      
      public static const SUB_TYPE_PVP_WIN_STREAK:uint = 15;
      
      public static const SUB_TYPE_SINGLE_SHOT_DAMAGE:uint = 16;
      
      public static const SUB_TYPE_SINGLE_MECH_HP:uint = 17;
      
      private var _dailyQuestsLastResetTime:int;
      
      private var _allQuests:Dictionary;
      
      private var _dailyPlayerQuests:Dictionary;
      
      private var _achievementPlayerQuests:Dictionary;
      
      private var _questToPlayerQuest:Dictionary;
      
      private var _questProgresses:Dictionary;
      
      public function BMQuestsManager()
      {
         super();
         generateSingletonClassesPointers("");
      }
      
      public function parseQuestData(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         this._allQuests = new Dictionary();
         for(_loc2_ in param1)
         {
            _loc3_ = uint(_loc2_);
            this._allQuests[_loc3_] = new BMQuestData(_loc3_,param1[_loc3_]);
         }
      }
      
      public function parsePlayerQuestData(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerQuestData = null;
         var _loc7_:String = null;
         this._questToPlayerQuest = new Dictionary();
         this._dailyPlayerQuests = new Dictionary();
         this._questProgresses = new Dictionary();
         for(_loc4_ in param2)
         {
            _loc5_ = uint(_loc4_);
            _loc6_ = new BMPlayerQuestData(_loc5_,param2[_loc5_]);
            this._dailyPlayerQuests[_loc5_] = _loc6_;
            this._questToPlayerQuest[_loc6_.questID] = _loc6_;
         }
         this._achievementPlayerQuests = new Dictionary();
         for(_loc4_ in param3)
         {
            _loc5_ = uint(_loc4_);
            _loc6_ = new BMPlayerQuestData(_loc5_,param3[_loc5_]);
            this.addAchievementPlayerQuest(_loc6_);
         }
         for(_loc7_ in param1)
         {
            this._questProgresses[uint(_loc7_)] = param1[_loc7_];
         }
      }
      
      public function getQuest(param1:uint) : BMQuestData
      {
         return this._allQuests[param1];
      }
      
      public function getPlayerQuestForQuestID(param1:uint) : BMPlayerQuestData
      {
         return this._questToPlayerQuest[param1] || null;
      }
      
      public function getPlayerQuest(param1:int) : BMPlayerQuestData
      {
         if(this._dailyPlayerQuests[param1])
         {
            return this._dailyPlayerQuests[param1];
         }
         return this._achievementPlayerQuests[param1] || null;
      }
      
      public function hasPlayerQuest(param1:int) : Boolean
      {
         return this.getPlayerQuest(param1) != null;
      }
      
      public function getQuestsOfType(param1:uint) : Vector.<BMQuestData>
      {
         var _loc3_:* = undefined;
         var _loc4_:BMQuestData = null;
         var _loc2_:Vector.<BMQuestData> = new Vector.<BMQuestData>();
         for(_loc3_ in this._allQuests)
         {
            _loc4_ = this.getQuest(_loc3_);
            if(_loc4_.type == param1 && Boolean(this.canShowQuest(_loc4_)))
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_.sort(this.sortFunc);
      }
      
      public function getQuestProgress(param1:uint) : uint
      {
         return uint(this._questProgresses[param1]) || 0;
      }
      
      private function canShowQuest(param1:BMQuestData) : *
      {
         if(!param1.hasStars())
         {
            return true;
         }
         var _loc2_:Boolean = true;
         var _loc3_:Boolean = param1.isRewarded();
         if(param1.previousQuestID != 0)
         {
            _loc2_ = this.getQuest(param1.previousQuestID).isRewarded();
         }
         return _loc2_ && !_loc3_ || param1.nextQuestID == 0 && _loc3_;
      }
      
      private function sortFunc(param1:BMQuestData, param2:BMQuestData) : Number
      {
         return param1.getSortingKey() - param2.getSortingKey();
      }
      
      public function getNumOfCompletedQuests(param1:uint) : int
      {
         var _loc4_:BMPlayerQuestData = null;
         var _loc2_:Dictionary = this._dailyPlayerQuests;
         if(param1 == TYPE_ACHIEVEMENT_QUEST)
         {
            _loc2_ = this._achievementPlayerQuests;
         }
         var _loc3_:int = 0;
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.completed && !_loc4_.rewarded)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      public function getNumOfCompletedAll() : *
      {
         return this.getNumOfCompletedQuests(TYPE_ACHIEVEMENT_QUEST) + this.getNumOfCompletedQuests(TYPE_DAILY_QUEST);
      }
      
      public function get dailyQuestsLastResetTime() : int
      {
         return this._dailyQuestsLastResetTime;
      }
      
      public function set dailyQuestsLastResetTime(param1:int) : void
      {
         this._dailyQuestsLastResetTime = param1;
      }
      
      public function get dailyQuestsSecLeft() : int
      {
         return this._dailyQuestsLastResetTime + 24 * 60 * 60 - BMDataManager.getInstance().currentTime;
      }
      
      public function loadQuestData() : *
      {
         remoteM.socketM.getQuestsData();
      }
      
      public function claimQuestReward(param1:int) : void
      {
         TsLogger.log("BMQuestsManager::claimQuestReward " + param1);
         screensM.screenConfirmation.displayCustomLoading("Claiming...");
         remoteM.socketM.claimQuestReward(param1);
      }
      
      public function onClaimReward(param1:int, param2:BMRewardData) : void
      {
         TsLogger.log("BMQuestsManager::onClaimReward " + param1);
         screensM.removeScreen("screenConfirmation");
         var _loc3_:BMPlayerQuestData = this.getPlayerQuest(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.rewarded = true;
         this.onQuestDataUpdated();
         dataM.giveRewardPopup(param2);
      }
      
      public function addAchievementPlayerQuest(param1:BMPlayerQuestData) : void
      {
         this._achievementPlayerQuests[param1.playerQuestID] = param1;
         this._questToPlayerQuest[param1.questID] = param1;
      }
      
      public function handleQuestCompleted(param1:int) : void
      {
         var _loc5_:uint = 0;
         var _loc2_:BMPlayerQuestData = this.getPlayerQuest(param1);
         _loc2_.completed = true;
         TsLogger.log("Quest Completed: " + _loc2_);
         this.onQuestDataUpdated();
         var _loc3_:BMQuestData = this.getQuest(_loc2_.questID);
         var _loc4_:BMCompletedQuestData = new BMCompletedQuestData();
         if(_loc3_.type == TYPE_DAILY_QUEST)
         {
            _loc4_.title = "Mission completed";
         }
         else
         {
            _loc4_.title = "Achievement unlocked";
         }
         _loc4_.body = _loc3_.body;
         _loc4_.iconSource = "general";
         if(_loc3_.type == TYPE_DAILY_QUEST)
         {
            _loc4_.iconName = _loc3_.icon;
         }
         else
         {
            _loc5_ = uint(_loc3_.getNumOfStars());
            if(_loc5_ < 1)
            {
               _loc5_ = 1;
            }
            _loc4_.iconName = "quest_achievementStar" + _loc5_;
         }
         screensM.addScreen("screenAchievementUnlocked",false);
         screensM.screenAchievementUnlocked.displayCompletedQuest(_loc4_);
         if(_loc3_.type == TYPE_ACHIEVEMENT_QUEST)
         {
            this.unlockPlatformAchievement(_loc3_.questID);
         }
      }
      
      public function onQuestDataUpdated() : *
      {
         if(screensM.isScreenOpened("screenQuests"))
         {
            screensM.screenQuests.onQuestsDataUpdated();
         }
         if(screensM.isScreenOpened("screenMainMenu"))
         {
            screensM.screenMainMenu.refreshQuestsCounter();
         }
      }
      
      private function unlockPlatformAchievement(param1:Number) : void
      {
         BMGoogleGamesManager.gi().unlockAchievement(param1);
      }
      
      public function syncPlatformAchievements() : void
      {
         var _loc1_:BMQuestData = null;
         for each(_loc1_ in this._allQuests)
         {
            if(_loc1_.type == TYPE_ACHIEVEMENT_QUEST && _loc1_.getCompleteAmount() == 1)
            {
               this.unlockPlatformAchievement(_loc1_.questID);
            }
         }
      }
   }
}

