package net.battleMechsMulti.managers.quests
{
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class BMQuestData
   {
      
      public var questID:uint;
      
      public var type:uint;
      
      public var subType:String;
      
      public var title:String;
      
      public var body:String;
      
      public var icon:String;
      
      public var requiredProgress:int;
      
      public var order:int;
      
      public var reward:BMRewardData;
      
      public var previousQuestID:int;
      
      public var nextQuestID:int;
      
      private const completeAllDailyQuestsSubType:String = "completeAllDailyQuests";
      
      public function BMQuestData(param1:uint, param2:Object)
      {
         super();
         this.questID = param1;
         this.type = param2["type"];
         this.subType = param2["subType"];
         this.title = param2["title"];
         this.body = param2["body"];
         this.icon = param2["icon"];
         this.requiredProgress = param2["requiredProgress"];
         this.order = param2["order"];
         this.previousQuestID = param2["previousQuestID"];
         this.nextQuestID = param2["nextQuestID"];
         if(param2.hasOwnProperty("reward"))
         {
            this.reward = new BMRewardData(param2["reward"]);
         }
         if(this.requiredProgress == 0)
         {
            this.requiredProgress = 1;
         }
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
         var _loc1_:uint = 100000;
         var _loc2_:uint = 10000;
         var _loc3_:uint = 1000;
         var _loc4_:uint = uint(this.order);
         var _loc5_:BMPlayerQuestData = this.getPlayerQuestData();
         if(_loc5_)
         {
            _loc4_ += int(_loc5_.rewarded) * _loc1_;
         }
         if(this.type === BMQuestsManager.TYPE_ACHIEVEMENT_QUEST)
         {
            if(!_loc5_ || !_loc5_.completed)
            {
               _loc4_ += _loc3_;
            }
            return _loc4_;
         }
         if(this.subType === this.completeAllDailyQuestsSubType)
         {
            _loc4_ += _loc2_;
         }
         return uint(_loc4_ + (1 - this.getCompleteAmount()) * _loc3_);
      }
   }
}

