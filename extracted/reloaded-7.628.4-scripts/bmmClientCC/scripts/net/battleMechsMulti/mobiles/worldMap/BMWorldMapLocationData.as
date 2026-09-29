package net.battleMechsMulti.mobiles.worldMap
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   
   public class BMWorldMapLocationData
   {
      
      public static const TYPE_MISSION:uint = 1;
      
      public static const TYPE_LOOT:uint = 2;
      
      public static const SUB_TYPE_LOOT_ITEM_BOX:uint = 1;
      
      public static const SUB_TYPE_LOOT_CUSTOM_ITEM_BOX:uint = 2;
      
      public static const SUB_TYPE_MISSION_REGULAR:uint = 1;
      
      public static const SUB_TYPE_MISSION_BOSS:uint = 2;
      
      public static const SUB_TYPE_MISSION_DUNGEON:uint = 3;
      
      public var storyID:uint;
      
      public var locationID:uint;
      
      public var displayNumber:uint;
      
      public var missionNumber:uint = 0;
      
      public var type:uint;
      
      public var subType:uint;
      
      public var difficulty:uint;
      
      private var _onlineWinsRequired:uint;
      
      public var itemBoxID:uint;
      
      public var xPos:uint;
      
      public var yPos:uint;
      
      public var chapterID:uint;
      
      public var themeID:uint;
      
      public var mythicalCards:uint;
      
      public var mainPath:Boolean;
      
      public var bossID:String = null;
      
      public var name:String = "";
      
      public var campaignID:int;
      
      public var startDate:int = 0;
      
      public var duration:int = 0;
      
      public function BMWorldMapLocationData()
      {
         super();
      }
      
      public function initializeMission(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:Boolean = true, param8:uint = 1, param9:uint = 1, param10:uint = 1, param11:uint = 0, param12:uint = 1, param13:String = null) : void
      {
         this.storyID = param1;
         this.locationID = param2;
         this.missionNumber = param3;
         this.displayNumber = param4;
         this.xPos = param5;
         this.yPos = param6;
         this.mainPath = param7;
         this.chapterID = param8;
         this.themeID = param9;
         this.type = TYPE_MISSION;
         this.subType = param12;
         this.difficulty = param10;
         this._onlineWinsRequired = param11;
         this.bossID = param13;
         this.campaignID = param2;
      }
      
      public function initializeDungeon(param1:uint, param2:uint, param3:String, param4:uint, param5:uint, param6:uint, param7:int, param8:int, param9:int, param10:String = null) : void
      {
         this.storyID = param1;
         this.locationID = param2;
         this.displayNumber = 0;
         this.xPos = param4;
         this.yPos = param5;
         this.mainPath = false;
         this.chapterID = 1;
         this.themeID = param6;
         this.type = TYPE_MISSION;
         this.subType = SUB_TYPE_MISSION_DUNGEON;
         this.difficulty = 1;
         this._onlineWinsRequired = 0;
         this.bossID = param10;
         this.name = param3;
         this.campaignID = param7;
         this.startDate = param8;
         this.duration = param9;
      }
      
      public function initializeItemBoxLoot(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint = 1, param7:uint = 5, param8:uint = 0) : void
      {
         this.storyID = param1;
         this.locationID = param2;
         this.missionNumber = param3;
         this.xPos = param4;
         this.yPos = param5;
         this.chapterID = param6;
         this.type = TYPE_LOOT;
         this.subType = SUB_TYPE_LOOT_ITEM_BOX;
         this.mainPath = false;
         this.itemBoxID = param7;
         this._onlineWinsRequired = param8;
      }
      
      public function initializeCustomItemBoxLoot(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint = 1, param7:uint = 1, param8:uint = 0) : void
      {
         this.storyID = param1;
         this.locationID = param2;
         this.missionNumber = param3;
         this.xPos = param4;
         this.yPos = param5;
         this.chapterID = param6;
         this.type = TYPE_LOOT;
         this.subType = SUB_TYPE_LOOT_CUSTOM_ITEM_BOX;
         this.mainPath = false;
         this.mythicalCards = param7;
         this._onlineWinsRequired = param8;
      }
      
      public function isBossMission() : Boolean
      {
         return this.type == TYPE_MISSION && this.subType == SUB_TYPE_MISSION_BOSS;
      }
      
      public function isLastBossMission() : Boolean
      {
         return this.type == TYPE_MISSION && this.subType == SUB_TYPE_MISSION_BOSS && this.chapterID == 7;
      }
      
      public function get endDate() : int
      {
         return this.startDate + this.duration * 60 * 60;
      }
      
      public function isMissionActive(param1:int) : Boolean
      {
         if(this.startDate == 0)
         {
            return true;
         }
         return this.endDate > param1;
      }
      
      public function get onlineWinsRequired() : uint
      {
         var _loc1_:String = "PvPWinsRequiredSlot" + this.locationID;
         if(this.storyID == BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2 || this.storyID == BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3)
         {
            _loc1_ = "PvPWinsRequiredStoryID" + this.storyID + "Slot" + this.locationID;
         }
         return uint(BMDataManager.getInstance().getGeneralSetting(_loc1_,this._onlineWinsRequired));
      }
   }
}

