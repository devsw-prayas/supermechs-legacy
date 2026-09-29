package net.battleMechsMulti.managers.quests
{
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   
   public class BMQuestData
   {
      
      public var questID:uint;
      
      public var type:uint;
      
      public var subType:String;
      
      public var icon:String;
      
      public var storyID:uint;
      
      public var requiredProgress:int;
      
      public var order:int;
      
      public var reward:BMRewardData;
      
      public var previousQuestID:int;
      
      public var nextQuestID:int;
      
      public var slicesToUpdateProgress:uint = 0;
      
      public var copyQuestIDTitle:int = -1;
      
      public var copyQuestIDBody:int = -1;
      
      private const completeAllDailyQuestsSubType:String = "completeAllDailyQuests";
      
      public function BMQuestData(param1:uint, param2:Object)
      {
         super();
         this.questID = param1;
         this.type = param2["type"];
         this.subType = param2["subType"];
         this.icon = param2["icon"];
         this.requiredProgress = param2["requiredProgress"];
         this.storyID = param2["storyID"];
         this.order = param2["order"];
         this.previousQuestID = param2["previousQuestID"];
         this.nextQuestID = param2["nextQuestID"];
         if(param2["slicesToUpdateProgress"] != null)
         {
            this.slicesToUpdateProgress = param2["slicesToUpdateProgress"];
         }
         if(param2.hasOwnProperty("reward"))
         {
            this.reward = new BMRewardData(param2["reward"]);
         }
         if(this.requiredProgress == 0)
         {
            this.requiredProgress = 1;
         }
         var _loc3_:RegExp = /^ID:(\d+)$/;
         var _loc4_:String = param2["title"];
         var _loc5_:Object = _loc3_.exec(_loc4_);
         if(_loc5_)
         {
            this.copyQuestIDTitle = int(_loc5_[1]);
         }
         var _loc6_:* = param2["body"];
         _loc5_ = _loc3_.exec(_loc6_);
         if(_loc5_)
         {
            this.copyQuestIDBody = int(_loc5_[1]);
         }
      }
      
      private function _getParsedQuestStringWithVariables(param1:String) : *
      {
         var _loc2_:String = BMDataManager.getInstance().replaceStringInText(param1,"%TARGET_PROGRESS%",this.requiredProgress.toString());
         if(_loc2_ == null || _loc2_.length == 0)
         {
            TsLogger.log("WARNING: Problems looking up string for quest " + this.questID);
         }
         return _loc2_;
      }
      
      private function _getTranslatedQuestBody() : *
      {
         var _loc1_:int = this.copyQuestIDTitle == -1 ? int(this.questID) : this.copyQuestIDTitle;
         var _loc2_:String = BMLanguageManager.getInstance().getText("questsData_" + _loc1_ + "_body");
         _loc2_ = this.addQuestChapterNames(_loc2_);
         return this._getParsedQuestStringWithVariables(_loc2_);
      }
      
      private function _getTranslatedQuestTitle() : *
      {
         var _loc1_:int = this.copyQuestIDBody == -1 ? int(this.questID) : this.copyQuestIDBody;
         var _loc2_:String = BMLanguageManager.getInstance().getText("questsData_" + _loc1_ + "_title");
         _loc2_ = this.addQuestChapterNames(_loc2_);
         return this._getParsedQuestStringWithVariables(_loc2_);
      }
      
      private function addQuestChapterNames(param1:String) : String
      {
         var _loc2_:String = null;
         if(param1.indexOf("%CHAPTER%") > -1 || param1.indexOf("%CHAPTERSHORT%") > -1)
         {
            _loc2_ = BMLanguageManager.getInstance().getText("missionWorldMap_chapter" + this.requiredProgress);
            param1 = BMDataManager.getInstance().replaceStringInText(param1,"%CHAPTER%",_loc2_);
            param1 = BMDataManager.getInstance().replaceStringInText(param1,"%CHAPTERSHORT%",_loc2_);
         }
         return param1;
      }
      
      public function get body() : String
      {
         return this._getTranslatedQuestBody();
      }
      
      public function get title() : String
      {
         return this._getTranslatedQuestTitle();
      }
      
      public function getPlayerQuestData() : BMPlayerQuestData
      {
         return BMDataManager.getInstance().questsManager.getPlayerQuestForQuestID(this.questID);
      }
      
      public function getProgress() : uint
      {
         return BMDataManager.getInstance().questsManager.getQuestProgress(this.questID);
      }
      
      public function toString() : String
      {
         var _loc1_:BMPlayerQuestData = this.getPlayerQuestData();
         var _loc2_:String = "";
         if(_loc1_ != null)
         {
            _loc2_ = "PlayerQuest: " + _loc1_.toString();
         }
         return "BMQuestData " + this.questID + " [" + this.type + " " + this.subType + " " + this.title + " " + this.body + " " + this.icon + "] " + _loc2_;
      }
      
      public function isRewarded() : Boolean
      {
         var _loc1_:BMPlayerQuestData = this.getPlayerQuestData();
         if(_loc1_ == null)
         {
            return false;
         }
         return _loc1_.rewarded;
      }
      
      public function getCompleteAmount() : Number
      {
         var _loc1_:BMPlayerQuestData = this.getPlayerQuestData();
         if(Boolean(_loc1_) && _loc1_.completed)
         {
            return 1;
         }
         return this.getProgress() / this.requiredProgress;
      }
      
      public function getNumOfStars() : int
      {
         var _loc1_:int = 1;
         if(this.previousQuestID == 0)
         {
            _loc1_ = 0;
         }
         else if(this.nextQuestID == 0)
         {
            _loc1_ = 2;
         }
         var _loc2_:BMPlayerQuestData = this.getPlayerQuestData();
         if(_loc2_ != null && (_loc2_.rewarded || _loc2_.completed))
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function hasStars() : Boolean
      {
         return this.previousQuestID != 0 || this.nextQuestID != 0;
      }
      
      public function getSortingKey() : uint
      {
         var _loc1_:uint = 10000000;
         var _loc2_:uint = 1000000;
         var _loc3_:uint = 100000;
         var _loc4_:uint = 0;
         var _loc5_:uint = uint(this.order);
         if(this.type == BMQuestsManager.TYPE_SALE_QUEST)
         {
            return _loc4_;
         }
         var _loc6_:BMPlayerQuestData = this.getPlayerQuestData();
         if(_loc6_)
         {
            _loc5_ += int(_loc6_.rewarded) * _loc1_;
         }
         if(this.type === BMQuestsManager.TYPE_ACHIEVEMENT_QUEST)
         {
            if(!_loc6_ || !_loc6_.completed)
            {
               _loc5_ += _loc3_;
            }
            return _loc5_;
         }
         if(this.subType === this.completeAllDailyQuestsSubType)
         {
            _loc5_ += _loc2_;
         }
         return uint(_loc5_ + (1 - this.getCompleteAmount()) * _loc3_);
      }
   }
}

