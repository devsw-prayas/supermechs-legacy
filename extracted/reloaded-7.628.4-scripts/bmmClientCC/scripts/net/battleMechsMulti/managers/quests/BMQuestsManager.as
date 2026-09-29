package net.battleMechsMulti.managers.quests
{
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMGoogleGamesManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMQuestStatusUpdateData;
   
   public class BMQuestsManager extends BMBaseClass
   {
      
      public static const SALE_QUEST_PLAYER_QUEST_ID:int = -1;
      
      public static const TYPE_DAILY_QUEST:uint = 1;
      
      public static const TYPE_ACHIEVEMENT_QUEST:uint = 2;
      
      public static const TYPE_SALE_QUEST:uint = 3;
      
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
      
      private var _saleQuestData:BMPlayerQuestData;
      
      private var _questProgresses:Dictionary = new Dictionary();
      
      private var _sharedObject:SharedObject;
      
      public function BMQuestsManager()
      {
         super();
         this._sharedObject = SharedObject.getLocal("BMQuestsManager");
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
      
      public function parsePlayerQuestData(param1:Object, param2:Object, param3:Object, param4:Object) : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:BMPlayerQuestData = null;
         var _loc8_:String = null;
         this._questToPlayerQuest = new Dictionary();
         this._dailyPlayerQuests = new Dictionary();
         this._questProgresses = new Dictionary();
         for(_loc5_ in param2)
         {
            _loc6_ = int(_loc5_);
            _loc7_ = new BMPlayerQuestData(_loc6_,param2[_loc6_]);
            this._dailyPlayerQuests[_loc6_] = _loc7_;
            this._questToPlayerQuest[_loc7_.questID] = _loc7_;
         }
         this._achievementPlayerQuests = new Dictionary();
         for(_loc5_ in param3)
         {
            _loc6_ = int(_loc5_);
            _loc7_ = new BMPlayerQuestData(_loc6_,param3[_loc6_]);
            this.addAchievementPlayerQuest(_loc7_);
         }
         if(param4 != null)
         {
            this._saleQuestData = new BMPlayerQuestData(param4["playerQuestID"],param4);
            this._questToPlayerQuest[this._saleQuestData.questID] = this._saleQuestData;
         }
         else
         {
            this._saleQuestData = null;
            delete this._questToPlayerQuest[SALE_QUEST_PLAYER_QUEST_ID];
         }
         for(_loc8_ in param1)
         {
            this._questProgresses[int(_loc8_)] = param1[_loc8_];
         }
      }
      
      public function getQuest(param1:uint) : BMQuestData
      {
         if(this._allQuests == null)
         {
            return null;
         }
         return this._allQuests[param1];
      }
      
      public function getPlayerQuestForQuestID(param1:uint) : BMPlayerQuestData
      {
         return this._questToPlayerQuest[param1] || null;
      }
      
      public function getPlayerQuest(param1:int) : BMPlayerQuestData
      {
         if(param1 == SALE_QUEST_PLAYER_QUEST_ID)
         {
            return this._saleQuestData;
         }
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
      
      public function getQuestsOfTypes(param1:Array) : Vector.<BMQuestData>
      {
         var _loc3_:* = undefined;
         var _loc4_:BMQuestData = null;
         var _loc2_:Vector.<BMQuestData> = new Vector.<BMQuestData>();
         for(_loc3_ in this._allQuests)
         {
            _loc4_ = this.getQuest(_loc3_);
            if(param1.indexOf(_loc4_.type) >= 0 && Boolean(this.canShowQuest(_loc4_)))
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
         if(param1.type == TYPE_SALE_QUEST)
         {
            return this._saleQuestData != null && this._saleQuestData.questID == param1.questID;
         }
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
         return this.dailyQuestsNextResetTime - BMDataManager.getInstance().currentTime;
      }
      
      public function increaseQuestsDailyResetByOneDay() : void
      {
         this.dailyQuestsLastResetTime = this.dailyQuestsNextResetTime;
      }
      
      public function getDailyQuestsSecLeft() : int
      {
         return this.dailyQuestsSecLeft;
      }
      
      public function get dailyQuestsNextResetTime() : int
      {
         return this._dailyQuestsLastResetTime + 24 * 60 * 60;
      }
      
      public function loadQuestData() : *
      {
         remoteM.socketM.getQuestsData();
      }
      
      public function claimQuestReward(param1:int) : void
      {
         TsLogger.log("BMQuestsManager::claimQuestReward " + param1);
         if(screensM.isScreenOpened(BMScreensManager.SCR_DISPLAY_REWARD))
         {
            TsLogger.log("BMQuestsManager::claimQuestReward suppressing reward claim because the previous one is still active");
            return;
         }
         screensM.screenConfirmation.displayCustomLoading(getSpecificText("quests_claiming"));
         remoteM.socketM.claimQuestReward(param1);
      }
      
      public function onClaimReward(param1:int, param2:BMRewardData) : void
      {
         TsLogger.log("BMQuestsManager::onClaimReward " + param1);
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
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
         var _loc2_:BMPlayerQuestData = this.getPlayerQuest(param1);
         _loc2_.completed = true;
         TsLogger.log("Quest Completed: " + _loc2_);
         this.onQuestDataUpdated();
         var _loc3_:BMQuestData = this.getQuest(_loc2_.questID);
         var _loc4_:BMQuestStatusUpdateData = new BMQuestStatusUpdateData();
         _loc4_.isCompleted = true;
         if(_loc3_.type == TYPE_DAILY_QUEST)
         {
            _loc4_.title = getSpecificText("quests_missionCompleted");
         }
         else
         {
            _loc4_.title = getSpecificText("quests_achievementUnlocked");
         }
         _loc4_.body = _loc3_.body;
         screensM.addScreen(BMScreensManager.SCR_QUEST_STATUS_UPDATE);
         screensM.screenQuestStatusUpdate.showQuestStatus(_loc4_);
         if(_loc3_.type == TYPE_ACHIEVEMENT_QUEST)
         {
            this.unlockPlatformAchievement(_loc3_.questID);
         }
      }
      
      public function handleQuestProgressChanged(param1:int, param2:int) : void
      {
         var _loc5_:BMQuestStatusUpdateData = null;
         var _loc3_:uint = 0;
         if(this._questProgresses[param1] != null)
         {
            _loc3_ = uint(this._questProgresses[param1]);
         }
         this._questProgresses[param1] = param2;
         var _loc4_:BMQuestData = this.getQuest(param1);
         this.onQuestDataUpdated();
         if(_loc4_ != null)
         {
            if(this.shouldShowProgressUpdate(_loc3_,_loc4_) == false)
            {
               return;
            }
            _loc5_ = new BMQuestStatusUpdateData();
            _loc5_.isCompleted = false;
            _loc5_.lastProgress = _loc3_;
            _loc5_.currentProgress = _loc4_.getProgress();
            _loc5_.progressRequired = _loc4_.requiredProgress;
            _loc5_.body = _loc4_.body;
            screensM.addScreen(BMScreensManager.SCR_QUEST_STATUS_UPDATE);
            screensM.screenQuestStatusUpdate.showQuestStatus(_loc5_);
         }
      }
      
      private function shouldShowProgressUpdate(param1:uint, param2:BMQuestData) : Boolean
      {
         if(dataM.getGeneralSetting("showQuestProgress",0) == 0)
         {
            return false;
         }
         if(param2.slicesToUpdateProgress == 0)
         {
            return false;
         }
         var _loc3_:Number = param2.requiredProgress / param2.slicesToUpdateProgress;
         var _loc4_:uint = Math.floor(param1 / _loc3_);
         var _loc5_:uint = Math.floor(this._questProgresses[param2.questID] / _loc3_);
         if(_loc4_ >= _loc5_)
         {
            return false;
         }
         return true;
      }
      
      public function onQuestDataUpdated() : *
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_QUESTS))
         {
            screensM.screenQuests.onQuestsDataUpdated();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
         {
            if(screensM.screenMainMenu.mcQuestsMiniPanel == null)
            {
               trace("WARNING screensM.screenMainMenu.mcQuestsMiniPanel == null");
               return;
            }
            screensM.screenMainMenu.mcQuestsMiniPanel.onQuestsDataUpdated();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
         {
            screensM.screenMissionWorldMap.onQuestsDataUpdated();
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
      
      public function get hasNew() : Boolean
      {
         var _loc1_:BMPlayerQuestData = this.getFirstPlayerQuestData();
         return _loc1_ != null && this._sharedObject.data.lastPlayerQuestId != _loc1_.playerQuestID;
      }
      
      private function getFirstPlayerQuestData() : BMPlayerQuestData
      {
         var _loc1_:BMPlayerQuestData = null;
         var _loc2_:int = 0;
         var _loc3_:* = this._dailyPlayerQuests;
         for each(_loc1_ in _loc3_)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function resetNew() : void
      {
         var _loc1_:BMPlayerQuestData = this.getFirstPlayerQuestData();
         if(_loc1_ == null)
         {
            return;
         }
         if(this._sharedObject.data.lastPlayerQuestId != _loc1_.playerQuestID)
         {
            this._sharedObject.data.lastPlayerQuestId = _loc1_.playerQuestID;
            this._sharedObject.flush();
         }
      }
   }
}

