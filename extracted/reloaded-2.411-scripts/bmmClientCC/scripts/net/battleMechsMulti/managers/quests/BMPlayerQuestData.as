package net.battleMechsMulti.managers.quests
{
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class BMPlayerQuestData
   {
      
      public var playerQuestID:uint;
      
      public var questID:uint;
      
      public var created:uint;
      
      public var completed:Boolean;
      
      public var rewarded:Boolean;
      
      public function BMPlayerQuestData(param1:*, param2:*)
      {
         super();
         this.playerQuestID = param1;
         this.questID = param2["questID"];
         this.created = param2["created"];
         this.completed = param2["completed"];
         this.rewarded = param2["rewarded"];
      }
      
      public function get data() : BMQuestData
      {
         return BMDataManager.getInstance().questsManager.getQuest(this.questID);
      }
      
      public function toString() : String
      {
         return "BMPlayerQuestData " + this.playerQuestID + " [" + this.questID + " " + this.created + " " + this.completed + " " + this.rewarded + "]";
      }
      
      public function get isReadyToClaim() : Boolean
      {
         return this.completed && !this.rewarded;
      }
   }
}

