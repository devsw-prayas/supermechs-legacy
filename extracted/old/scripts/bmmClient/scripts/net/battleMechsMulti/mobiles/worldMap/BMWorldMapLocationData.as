package net.battleMechsMulti.mobiles.worldMap
{
   public class BMWorldMapLocationData
   {
      
      public static const TYPE_MISSION:uint = 1;
      
      public static const TYPE_LOOT:uint = 2;
      
      public static const SUB_TYPE_LOOT_ITEM_BOX:uint = 1;
      
      public static const SUB_TYPE_LOOT_CUSTOM_ITEM_BOX:uint = 2;
      
      public static const SUB_TYPE_MISSION_REGULAR:uint = 1;
      
      public static const SUB_TYPE_MISSION_BOSS:uint = 2;
      
      public var locationID:uint;
      
      public var displayNumber:uint;
      
      public var type:uint;
      
      public var subType:uint;
      
      public var difficulty:uint;
      
      public var onlineWinsRequired:uint;
      
      public var itemBoxID:uint;
      
      public var xPos:uint;
      
      public var yPos:uint;
      
      public var chapterID:uint;
      
      public var themeID:uint;
      
      public var mythicalCards:uint;
      
      public var mainPath:Boolean;
      
      public var bossDataSlot:Number = -1;
      
      public function BMWorldMapLocationData()
      {
         super();
      }
      
      public function initializeMission(param1:uint, param2:uint, param3:uint, param4:uint, param5:Boolean = true, param6:uint = 1, param7:uint = 1, param8:uint = 1, param9:uint = 0, param10:uint = 1, param11:Number = -1) : void
      {
         this.locationID = param1;
         this.displayNumber = param2;
         this.xPos = param3;
         this.yPos = param4;
         this.mainPath = param5;
         this.chapterID = param6;
         this.themeID = param7;
         this.type = TYPE_MISSION;
         this.subType = param10;
         this.difficulty = param8;
         this.onlineWinsRequired = param9;
         this.bossDataSlot = param11;
      }
      
      public function initializeItemBoxLoot(param1:uint, param2:uint, param3:uint, param4:uint = 1, param5:uint = 5, param6:uint = 0) : void
      {
         this.locationID = param1;
         this.xPos = param2;
         this.yPos = param3;
         this.chapterID = param4;
         this.type = TYPE_LOOT;
         this.subType = SUB_TYPE_LOOT_ITEM_BOX;
         this.mainPath = false;
         this.itemBoxID = param5;
         this.onlineWinsRequired = param6;
      }
      
      public function initializeCustomItemBoxLoot(param1:uint, param2:uint, param3:uint, param4:uint = 1, param5:uint = 1, param6:uint = 0) : void
      {
         this.locationID = param1;
         this.xPos = param2;
         this.yPos = param3;
         this.chapterID = param4;
         this.type = TYPE_LOOT;
         this.subType = SUB_TYPE_LOOT_CUSTOM_ITEM_BOX;
         this.mainPath = false;
         this.mythicalCards = param5;
         this.onlineWinsRequired = param6;
      }
   }
}

