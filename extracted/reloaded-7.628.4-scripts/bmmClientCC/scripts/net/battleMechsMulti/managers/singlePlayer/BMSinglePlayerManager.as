package net.battleMechsMulti.managers.singlePlayer
{
   import flash.geom.Point;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossData;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   
   public class BMSinglePlayerManager
   {
      
      private static var _instance:BMSinglePlayerManager;
      
      public static const MISSION_DIFFICULTY_NORMAL:* = 1;
      
      public static const MISSION_DIFFICULTY_HARD:* = 2;
      
      public static const MISSION_DIFFICULTY_INSANE:* = 3;
      
      public static const MISSION_MODE_NORMAL:* = 0;
      
      public static const MISSION_MODE_HARD:* = 1;
      
      public static const MISSION_MODE_INSANE:* = 2;
      
      public static const MAP_THEME_DESERT:uint = 1;
      
      public static const MAP_THEME_FOREST:uint = 2;
      
      public static const MAP_THEME_SEA:uint = 3;
      
      public static const MAP_THEME_SNOW:uint = 4;
      
      public static const MAP_THEME_LAVA:uint = 5;
      
      public static const MAP_THEME_WASTELAND:uint = 6;
      
      public static const MAP_THEME_TOWER:uint = 7;
      
      public static const MAP_THEME_CITY:uint = 8;
      
      public static const MAP_THEME_SWAMP:uint = 9;
      
      public static const MAP_PROGRESS_INCOMPLETE:String = "x";
      
      public static const MAP_PROGRESS_COMPLETE:String = "v";
      
      public static const MAP_PROGRESS_REPLAY:String = "r";
      
      public static const MAP_PROGRESS_IN_PROGRESS:String = "c";
      
      public static const MISSION_START_STATE_CAN_START:int = 0;
      
      public static const MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MISSION:int = 1;
      
      public static const MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MODE_CHAPTER:int = 2;
      
      public static const MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MISSION_DIFFICULTY:int = 3;
      
      public static const NUM_DIFFICULTY_MODES:int = 3;
      
      public static const BATTLE_TYPE_NONE:String = "none";
      
      public static const BATTLE_TYPE_REGULAR:String = "regular";
      
      public static const BATTLE_TYPE_MISSION:String = "mission";
      
      public static const BATTLE_TYPE_CLAN_BOSS:String = "clanBoss";
      
      public static const BATTLE_TYPE_CHALLENGE:String = "challenge";
      
      public static const BATTLE_TYPE_CLAN_WAR:String = "clanWar";
      
      public static const ENEMY_TYPE_TURRET:String = "turret";
      
      public static const ENEMY_TYPE_JEEP:String = "jeep";
      
      public static const ENEMY_TYPE_TANK:String = "tank";
      
      public static const ENEMY_TYPE_MECH:String = "mech";
      
      public static const ENEMY_TYPE_BOSS:String = "boss";
      
      public static const ENEMY_TYPE_CLAN_BOSS:String = "clanBoss";
      
      public static const CHALLENGE_DAMAGE:String = "damage";
      
      public static const CHALLENGE_INVISIBLE:String = "invisible";
      
      public static const CHALLENGE_GODMODE:String = "godMode";
      
      public static const MISSION_COLOR_NORMAL:uint = 301;
      
      public static const MISSION_COLOR_HARD:uint = 302;
      
      public static const MISSION_COLOR_INSANE:uint = 303;
      
      public static const MISSION_COLOR_BOSS:uint = 21;
      
      public static const UNICORN_DUNGEON_THEME_ID:uint = 100;
      
      public static const TIME_TO_DEFEAT_FIRST_BOSS:uint = 3600;
      
      public static const NO_LOCATION_ID:int = -1;
      
      public static const STORY_ID_NONE:int = -1;
      
      public static const STORY_ID_DUNGEON:int = 0;
      
      public static const STORY_ID_CAMPAIGN_1V1:int = 0;
      
      public static const STORY_ID_CAMPAIGN_2V2:int = 1;
      
      public static const STORY_ID_CAMPAIGN_3V3:int = 3;
      
      public static const STORY_ID_RAID:int = 2;
      
      private static const STORY_IDS_OLD:Array = [STORY_ID_CAMPAIGN_1V1,STORY_ID_CAMPAIGN_2V2,STORY_ID_RAID];
      
      public static const STORY_IDS_NEW:Array = [STORY_ID_CAMPAIGN_1V1,STORY_ID_CAMPAIGN_2V2,STORY_ID_CAMPAIGN_3V3,STORY_ID_RAID];
      
      private static const STORY_IDS_FOR_CAMPAIGNS_MENU_OLD:Array = [STORY_ID_CAMPAIGN_1V1,STORY_ID_CAMPAIGN_2V2];
      
      private static const STORY_IDS_FOR_CAMPAIGNS_MENU_NEW:Array = [STORY_ID_CAMPAIGN_1V1,STORY_ID_CAMPAIGN_2V2,STORY_ID_CAMPAIGN_3V3];
      
      public static const MECHS_PER_STORY_ID:* = [1,2,1,3];
      
      public static const CLAN_BOSS_MISSION_SLOT:uint = 150;
      
      private var _missionsDB:Array = new Array();
      
      private var _missionDisplayNumbers:Array = new Array();
      
      private var _sideMissionDisplayNumbers:Array = new Array();
      
      private var _missionsItemBoxSlots:Array = new Array();
      
      private var _totalMissions:Array = new Array();
      
      private var _totalChapters:Array = new Array();
      
      private var _missionLayouts_tutorial:Array;
      
      private var _missionLayouts_tutorialHiddenBaseMaps:Array;
      
      private var _missionLayouts_regular:Array;
      
      private var _bossesInitiated:Boolean = false;
      
      public var finishMissionForFirstTime:Boolean = false;
      
      public var premiumBoxTutorialManager:BMForceBuyPremiumBoxTutorialManager;
      
      private var _mapProgressTrace:String = "";
      
      private var _campaignChaptersReleaseData:Object;
      
      private var _startBattle_startPositionsExist:Boolean;
      
      private var _startBattle_battlePosition:Number;
      
      private var _startBattle_showBlackScreen:Boolean;
      
      private var _startBattle_battleVSComputerSuccess:Boolean;
      
      private var _startBattle_blackScreenClosed:Boolean;
      
      private var _startBattle_fightingDamagedEnemy:Boolean = false;
      
      public function BMSinglePlayerManager()
      {
         super();
         this.initMapData();
         this.initMissionLayouts();
         this.premiumBoxTutorialManager = new BMForceBuyPremiumBoxTutorialManager();
      }
      
      public static function get is3V3CampaignEnabled() : Boolean
      {
         if(int(BMDataManager.getInstance().getGeneralSetting("use3V3Campaign","0")) == 0)
         {
            return false;
         }
         return BMDataManager.getInstance().singlePlayerM.isStoryVisible(BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3);
      }
      
      public static function get STORY_IDS() : Array
      {
         if(is3V3CampaignEnabled)
         {
            return STORY_IDS_NEW;
         }
         return STORY_IDS_OLD;
      }
      
      public static function get STORY_IDS_FOR_CAMPAIGNS_MENU() : Array
      {
         if(is3V3CampaignEnabled)
         {
            return STORY_IDS_FOR_CAMPAIGNS_MENU_NEW;
         }
         return STORY_IDS_FOR_CAMPAIGNS_MENU_OLD;
      }
      
      public static function getInstance() : BMSinglePlayerManager
      {
         if(_instance == null)
         {
            _instance = new BMSinglePlayerManager();
         }
         return _instance;
      }
      
      public static function gi() : BMSinglePlayerManager
      {
         return getInstance();
      }
      
      private function initMissionLayouts() : void
      {
         this._missionLayouts_tutorial = new Array();
         this._missionLayouts_tutorialHiddenBaseMaps = new Array();
         this._missionLayouts_regular = new Array();
         this._missionLayouts_tutorial[0] = {
            "rows":3,
            "columns":3,
            "startLocation":8,
            "layout":"ME_5|L1_1_3"
         };
         this._missionLayouts_tutorial[1] = {
            "rows":4,
            "columns":3,
            "startLocation":11,
            "layout":"ME_2|X1_7_9|CA1_5|JP_8|L1_1_3"
         };
         this._missionLayouts_tutorial[2] = {
            "rows":5,
            "columns":4,
            "startLocation":18,
            "layout":"CA1_13_16|SI2_5_8|L1_1_4|ME_2|SI1_9_12|JP_14|XX_17_20|TK_3"
         };
         this._missionLayouts_tutorialHiddenBaseMaps[0] = {
            "rows":3,
            "columns":3,
            "startLocation":8,
            "layout":"ME_5"
         };
         this._missionLayouts_tutorialHiddenBaseMaps[1] = {
            "rows":4,
            "columns":3,
            "startLocation":11,
            "layout":"ME_2|CA1_5|JP_8"
         };
         this._missionLayouts_tutorialHiddenBaseMaps[2] = {
            "rows":5,
            "columns":4,
            "startLocation":18,
            "layout":"CA1_13_16|ME_2|JP_14|TK_3"
         };
         this._missionLayouts_regular[1] = new Array();
         this._missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"SD1_11_16|X1_6_7|CA1_15|JP_18|L1_1_2|ME_3|XX_21_22_24_25|CA2_10|TK_5"
         });
         this._missionLayouts_regular[1].push({
            "rows":4,
            "columns":5,
            "startLocation":18,
            "layout":"CA1_1_2|JP_4|L1_6_11|ME_5|SI1_14_15|SI2_9_10|XX_16_17_19_20|TK_13"
         });
         this._missionLayouts_regular[1].push({
            "rows":5,
            "columns":4,
            "startLocation":18,
            "layout":"SH1_10_11|X1_9_12|XX_17_20|SB1_1|L1_3_4|ME_14|JP_6|CA2_13_16|TK_7"
         });
         this._missionLayouts_regular[1].push({
            "rows":3,
            "columns":7,
            "startLocation":18,
            "layout":"CA1_6_7|JP_9|L1_1_8|ME_2|SF1_13_14|XX_15_16_17_19_20_21|TK_11"
         });
         this._missionLayouts_regular[1].push({
            "rows":6,
            "columns":4,
            "startLocation":22,
            "layout":"L2_2|SE1_6_7_14_15|CA1_10_11|ME_3|XX_21_24|TK_18_19"
         });
         this._missionLayouts_regular[1].push({
            "rows":4,
            "columns":5,
            "startLocation":18,
            "layout":"L2_1|CA1_15|JP_11_19|SG1_7_8_9_12_14|ME_2|SA1_13|CA2_20"
         });
         this._missionLayouts_regular[1].push({
            "rows":6,
            "columns":4,
            "startLocation":22,
            "layout":"ME_7|XX_21_24|CA1_17|SB1_4|JP_18_19|L1_3_8|SD1_1_5_9_13|SI1_15_16|SI2_11_12|CA2_20"
         });
         this._missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"SH1_7_9|CA1_25|JP_18|L1_2_4|SF1_3_8|CA2_21|TK_12_14|ME_13"
         });
         this._missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"CA1_12_13_14|SI2_1_5|L1_7_9|SI1_6_10|JP_17_19|ME_18|TK_8"
         });
         this._missionLayouts_regular[1].push({
            "rows":5,
            "columns":6,
            "startLocation":27,
            "layout":"CA1_5_6|JP_4|TK_22|L1_1_2|ME_8|SI1_16_17_18|SI2_10_11_12|XX_25_26_29_30|SC1_19"
         });
         this._missionLayouts_regular[1].push({
            "rows":4,
            "columns":4,
            "startLocation":14,
            "layout":"ME_10_11|L1_6_7|SG1_1_2|SA1_4|CA1_9_13"
         });
         this._missionLayouts_regular[1].push({
            "rows":5,
            "columns":4,
            "startLocation":18,
            "layout":"TK_2_3_6_7_10_11|SI1_9_12|L1_1_4|XX_17_20|SI2_5_8|CA1_13_16"
         });
         this._missionLayouts_regular[1].push({
            "rows":4,
            "columns":6,
            "startLocation":21,
            "layout":"CA1_24|JP_14_16|SG1_8_9_10|L1_5_6|ME_1|SA1_15|CA2_23"
         });
         this._missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"SD1_21_22_24_25|X1_2_3_4_7_9_12_14|CA1_1_5|ME_13|L2_8|TK_6_10"
         });
         this._missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"CB1_5|CA1_3|SG1_10_15|L1_11_16|ME_6|X1_7_9_12_14_17_19|SA1_20|XX_21_22_24_25|TK_8_13"
         });
         this._missionLayouts_regular[2] = new Array();
         this._missionLayouts_regular[2].push({
            "rows":5,
            "columns":6,
            "startLocation":27,
            "layout":"SH1_8_13_14|L2_1|SE1_7|CA1_6_23_24|SI2_11_12|L1_2|ME_3_4|SI1_17_18|XX_25_26_29_30|TK_21_22"
         });
         this._missionLayouts_regular[2].push({
            "rows":5,
            "columns":6,
            "startLocation":27,
            "layout":"L2_4|SG1_1_2_5_6_7_12|L1_10|ME_21_22|SA1_8_11|CA2_9|TK_20_23|CA3_3"
         });
         this._missionLayouts_regular[2].push({
            "rows":4,
            "columns":4,
            "startLocation":14,
            "layout":"ME_6_7|L3_2|CA2_10|TK_3|CA3_11"
         });
         this._missionLayouts_regular[2].push({
            "rows":4,
            "columns":5,
            "startLocation":18,
            "layout":"ME_9_10|L2_15|CA1_2|JP_7_8|CA3_12|SD1_1_6_11|SF1_5|XX_16_17_19_20|L1_14"
         });
         this._missionLayouts_regular[2].push({
            "rows":6,
            "columns":6,
            "startLocation":33,
            "layout":"SF1_5|ME_12_14|XX_31_32_35_36|SI2_16|L2_6|TK_11_19|CA2_24_30|SI1_22|SD1_1_2_7_8|L1_13|JP_27_28|CA1_25"
         });
         this._missionLayouts_regular[2].push({
            "rows":5,
            "columns":7,
            "startLocation":31,
            "layout":"SC1_1_8_15_22|CA1_14_21|ME_11_18|L1_5_6_7|TK_17_19_25|JP_28|SE1_13"
         });
         this._missionLayouts_regular[2].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"ME_13_18|TK_12_14|JP_17_19|L3_8|SD1_4_5|SB1_1|CA1_7_9"
         });
         this._missionLayouts_regular[3] = new Array();
         this._missionLayouts_regular[3].push({
            "rows":6,
            "columns":7,
            "startLocation":39,
            "layout":"CB1_29_30|CB2_35|SB1_1_7|SI2_16_17_19_20|L1_2|ME_5_12_13|SI1_23_24_26_27|L3_6|JP_9_10|XX_36_37_38_40_41_42|TK_3_32"
         });
         this._missionLayouts_regular[3].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"L2_13|SB1_8|L1_7_9|ME_12_14_18|CB1_20_25|CB2_21|TK_17_19"
         });
         this._missionLayouts_regular[3].push({
            "rows":5,
            "columns":6,
            "startLocation":27,
            "layout":"L2_6_12|SE1_22_23|SI2_5|SC1_13_19|CA3_1|ME_4_10|CB1_7_24|SI1_11|JP_21|XX_25_26_29_30|TK_2_3_8_9"
         });
         this._missionLayouts_regular[3].push({
            "rows":6,
            "columns":6,
            "startLocation":33,
            "layout":"SD1_6_12_18|JP_27_28|SG1_8_9_10_14_16|L1_2|ME_3_4_7_13|SA1_15|L3_1|XX_31_32_35_36|CA2_25_30"
         });
         this._missionLayouts_regular[3].push({
            "rows":7,
            "columns":5,
            "startLocation":33,
            "layout":"SH1_6_10_11_15|L2_1_5|SE1_7_9_12_14|CA1_22_24|JP_26_30|CA3_23|ME_3_8_13|XX_31_32_34_35|SF1_27_29|CA2_28|TK_16_20"
         });
         this._missionLayouts_regular[3].push({
            "rows":5,
            "columns":7,
            "startLocation":32,
            "layout":"CB1_15_22|SH1_17_19|TK_2_6|ME_18_24_26|CA2_28|SD1_3_5|L1_1_7_8_14|CA3_21|JP_9_13|XX_29_30_31_33_34_35|SE1_4"
         });
         this._missionLayouts_regular[3].push({
            "rows":6,
            "columns":7,
            "startLocation":39,
            "layout":"CB1_28_35|SH1_9_10_16_17|TK_1_7|XX_36_37_38_40_41_42|CB2_22_29|ME_4_31_32_33|L1_2_3_5_6|JP_8_14|SE1_12_13_19_20"
         });
      }
      
      private function initMapData() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:BMWorldMapLocationData = null;
         var _loc8_:int = 0;
         var _loc1_:Array = STORY_IDS_NEW;
         var _loc2_:Array = new Array();
         _loc2_.push(["RAMBOY","EXTERMINATOR","CYBER GOAT","MOLOTOV","SABERTOOTH","SENIOR QUADS","BIGBOY"]);
         _loc2_.push(["SHARK TOOTH","MEGA BREAKER","META BLASTER","ULTRA QUAKER","HAVOC","STORM","MADBOY"]);
         _loc2_.push(null);
         _loc2_.push(["ROASTER","DYNAMIC FUSE","ELECTRO BURN","MOLTEN BEAST","PLATINUM BREAKER","COMPLEX BATTALION","HELL GATE"]);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = uint(_loc1_[_loc3_]);
            this._missionsDB[_loc4_] = new Vector.<BMWorldMapLocationData>();
            if(_loc4_ != STORY_ID_RAID)
            {
               this._totalMissions[_loc4_] = 0;
               this._totalChapters[_loc4_] = 0;
               _loc5_ = 1;
               _loc6_ = _loc2_[_loc4_][_loc5_ - 1];
               this.createWorldMapMissionLocationData(_loc4_,81,249);
               this.createWorldMapMissionLocationData(_loc4_,213,223);
               this.createWorldMapMissionLocationData(_loc4_,358,191);
               this.createWorldMapMissionLocationData(_loc4_,495,136,false,_loc5_,MAP_THEME_DESERT,2);
               this.createWorldMapMissionLocationData(_loc4_,470,267);
               this.createWorldMapMissionLocationData(_loc4_,618,223);
               this.createWorldMapMissionLocationData(_loc4_,746,170,true,_loc5_,MAP_THEME_DESERT,1,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,_loc6_);
               this.createWorldMapItemBoxLocationData(_loc4_,748,240,_loc5_,5,2);
               _loc5_ = 2;
               _loc6_ = _loc2_[_loc4_][_loc5_ - 1];
               this.createWorldMapMissionLocationData(_loc4_,878,234,true,_loc5_,MAP_THEME_FOREST);
               this.createWorldMapMissionLocationData(_loc4_,1016,111,false,_loc5_,MAP_THEME_FOREST,2);
               this.createWorldMapMissionLocationData(_loc4_,940,325,true,_loc5_,MAP_THEME_FOREST);
               this.createWorldMapMissionLocationData(_loc4_,1090,361,true,_loc5_,MAP_THEME_FOREST);
               this.createWorldMapMissionLocationData(_loc4_,1200,269,true,_loc5_,MAP_THEME_FOREST);
               this.createWorldMapMissionLocationData(_loc4_,1334,272,false,_loc5_,MAP_THEME_FOREST,2);
               this.createWorldMapMissionLocationData(_loc4_,1414,443,false,_loc5_,MAP_THEME_FOREST,3);
               this.createWorldMapMissionLocationData(_loc4_,1264,164,true,_loc5_,MAP_THEME_FOREST);
               this.createWorldMapMissionLocationData(_loc4_,1339,71,false,_loc5_,MAP_THEME_FOREST,3);
               this.createWorldMapMissionLocationData(_loc4_,1406,195,true,_loc5_,MAP_THEME_FOREST);
               this.createWorldMapMissionLocationData(_loc4_,1534,267,true,_loc5_,MAP_THEME_FOREST,1,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,_loc6_);
               this.createWorldMapItemBoxLocationData(_loc4_,1534,336,_loc5_,5,5);
               _loc5_ = 3;
               _loc6_ = _loc2_[_loc4_][_loc5_ - 1];
               this.createWorldMapMissionLocationData(_loc4_,1698,276,true,_loc5_,MAP_THEME_SEA);
               this.createWorldMapMissionLocationData(_loc4_,1906,391,true,_loc5_,MAP_THEME_SEA);
               this.createWorldMapMissionLocationData(_loc4_,1820,175,true,_loc5_,MAP_THEME_SEA);
               this.createWorldMapMissionLocationData(_loc4_,1647,126,false,_loc5_,MAP_THEME_SEA,2);
               this.createWorldMapMissionLocationData(_loc4_,2043,273,true,_loc5_,MAP_THEME_SEA);
               this.createWorldMapMissionLocationData(_loc4_,2221,317,false,_loc5_,MAP_THEME_SEA,2);
               this.createWorldMapMissionLocationData(_loc4_,1953,71,true,_loc5_,MAP_THEME_SEA);
               this.createWorldMapMissionLocationData(_loc4_,2188,180,true,_loc5_,MAP_THEME_SEA);
               this.createWorldMapMissionLocationData(_loc4_,2291,210,false,_loc5_,MAP_THEME_SEA,3);
               this.createWorldMapMissionLocationData(_loc4_,2285,93,true,_loc5_,MAP_THEME_SEA,2,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,_loc6_);
               this.createWorldMapItemBoxLocationData(_loc4_,2301,143,_loc5_,6,10);
               _loc5_ = 4;
               _loc6_ = _loc2_[_loc4_][_loc5_ - 1];
               this.createWorldMapMissionLocationData(_loc4_,2494,90,true,_loc5_,MAP_THEME_SNOW);
               this.createWorldMapMissionLocationData(_loc4_,2469,185,false,_loc5_,MAP_THEME_SNOW,2);
               this.createWorldMapMissionLocationData(_loc4_,2458,283,false,_loc5_,MAP_THEME_SNOW,3);
               this.createWorldMapMissionLocationData(_loc4_,2653,92,true,_loc5_,MAP_THEME_SNOW);
               this.createWorldMapMissionLocationData(_loc4_,2824,120,true,_loc5_,MAP_THEME_SNOW);
               this.createWorldMapMissionLocationData(_loc4_,2974,85,false,_loc5_,MAP_THEME_SNOW,2);
               this.createWorldMapMissionLocationData(_loc4_,2746,223,true,_loc5_,MAP_THEME_SNOW);
               this.createWorldMapMissionLocationData(_loc4_,2645,329,true,_loc5_,MAP_THEME_SNOW);
               this.createWorldMapMissionLocationData(_loc4_,2806,376,true,_loc5_,MAP_THEME_SNOW);
               this.createWorldMapMissionLocationData(_loc4_,3012,263,false,_loc5_,MAP_THEME_SNOW,3);
               this.createWorldMapMissionLocationData(_loc4_,2977,377,true,_loc5_,MAP_THEME_SNOW,2,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,_loc6_);
               this.createWorldMapItemBoxLocationData(_loc4_,3041,415,_loc5_,6,20);
               _loc5_ = 5;
               _loc6_ = _loc2_[_loc4_][_loc5_ - 1];
               this.createWorldMapMissionLocationData(_loc4_,3181,356,true,_loc5_,MAP_THEME_LAVA);
               this.createWorldMapMissionLocationData(_loc4_,3252,209,true,_loc5_,MAP_THEME_LAVA);
               this.createWorldMapMissionLocationData(_loc4_,3315,90,true,_loc5_,MAP_THEME_LAVA);
               this.createWorldMapMissionLocationData(_loc4_,3198,62,false,_loc5_,MAP_THEME_LAVA,2);
               this.createWorldMapMissionLocationData(_loc4_,3480,97,true,_loc5_,MAP_THEME_LAVA);
               this.createWorldMapMissionLocationData(_loc4_,3638,185,false,_loc5_,MAP_THEME_LAVA,2);
               this.createWorldMapMissionLocationData(_loc4_,3749,147,false,_loc5_,MAP_THEME_LAVA,3);
               this.createWorldMapMissionLocationData(_loc4_,3455,250,true,_loc5_,MAP_THEME_LAVA);
               this.createWorldMapMissionLocationData(_loc4_,3518,369,true,_loc5_,MAP_THEME_LAVA);
               this.createWorldMapMissionLocationData(_loc4_,3697,353,true,_loc5_,MAP_THEME_LAVA);
               this.createWorldMapMissionLocationData(_loc4_,3838,248,true,_loc5_,MAP_THEME_LAVA,2,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,_loc6_);
               this.createWorldMapItemBoxLocationData(_loc4_,3838,312,_loc5_,6,30);
               _loc5_ = 6;
               _loc6_ = _loc2_[_loc4_][_loc5_ - 1];
               this.createWorldMapMissionLocationData(_loc4_,4025,234,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4181,251,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4266,191,false,_loc5_,MAP_THEME_WASTELAND,2);
               this.createWorldMapMissionLocationData(_loc4_,4291,112,false,_loc5_,MAP_THEME_WASTELAND,3);
               this.createWorldMapMissionLocationData(_loc4_,4289,341,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4419,411,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4563,353,false,_loc5_,MAP_THEME_WASTELAND,2);
               this.createWorldMapMissionLocationData(_loc4_,4461,290,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4361,186,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4415,67,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4566,65,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4645,180,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4738,205,false,_loc5_,MAP_THEME_WASTELAND,2);
               this.createWorldMapMissionLocationData(_loc4_,4756,290,false,_loc5_,MAP_THEME_WASTELAND,3);
               this.createWorldMapMissionLocationData(_loc4_,4651,324,true,_loc5_,MAP_THEME_WASTELAND);
               this.createWorldMapMissionLocationData(_loc4_,4770,414,true,_loc5_,MAP_THEME_WASTELAND,3,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,_loc6_);
               this.createWorldMapCustomItemBoxLocationData(_loc4_,4679,437,_loc5_,1,40);
               _loc5_ = 7;
               _loc6_ = _loc2_[_loc4_][_loc5_ - 1];
               this.createWorldMapMissionLocationData(_loc4_,4906,313,true,_loc5_,MAP_THEME_TOWER);
               this.createWorldMapMissionLocationData(_loc4_,4993,170,true,_loc5_,MAP_THEME_TOWER);
               this.createWorldMapMissionLocationData(_loc4_,4951,67,false,_loc5_,MAP_THEME_TOWER,3);
               this.createWorldMapMissionLocationData(_loc4_,5141,101,true,_loc5_,MAP_THEME_TOWER);
               this.createWorldMapMissionLocationData(_loc4_,5295,141,true,_loc5_,MAP_THEME_TOWER);
               this.createWorldMapMissionLocationData(_loc4_,5438,210,false,_loc5_,MAP_THEME_TOWER,3);
               this.createWorldMapMissionLocationData(_loc4_,5357,271,true,_loc5_,MAP_THEME_TOWER);
               this.createWorldMapMissionLocationData(_loc4_,5298,398,true,_loc5_,MAP_THEME_TOWER);
               this.createWorldMapMissionLocationData(_loc4_,5100,392,true,_loc5_,MAP_THEME_TOWER);
               this.createWorldMapMissionLocationData(_loc4_,5188,274,true,_loc5_,MAP_THEME_TOWER,3,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,_loc6_);
               this.createWorldMapCustomItemBoxLocationData(_loc4_,5184,361,_loc5_,2,50);
               this._missionsItemBoxSlots[_loc4_] = new Object();
               _loc8_ = 0;
               while(_loc8_ < this._missionsDB[_loc4_].length)
               {
                  _loc7_ = this._missionsDB[_loc4_][_loc8_];
                  if(_loc7_.type == BMWorldMapLocationData.TYPE_LOOT)
                  {
                     this._missionsItemBoxSlots[_loc4_][_loc8_] = _loc8_;
                  }
                  _loc8_++;
               }
            }
            _loc3_++;
         }
      }
      
      private function createWorldMapMissionLocationData(param1:uint, param2:uint, param3:uint, param4:Boolean = true, param5:uint = 1, param6:uint = 1, param7:uint = 1, param8:uint = 0, param9:uint = 1, param10:String = null) : void
      {
         var _loc11_:int = 0;
         if(param4)
         {
            if(this._missionDisplayNumbers[param1] == null)
            {
               this._missionDisplayNumbers[param1] = new Array();
            }
            if(this._missionDisplayNumbers[param1][param6] == null)
            {
               this._missionDisplayNumbers[param1][param6] = 1;
            }
            else
            {
               this._missionDisplayNumbers[param1][param6] += 1;
            }
            _loc11_ = int(this._missionDisplayNumbers[param1][param6]);
         }
         else
         {
            if(this._sideMissionDisplayNumbers[param1] == null)
            {
               this._sideMissionDisplayNumbers[param1] = new Array();
            }
            if(this._sideMissionDisplayNumbers[param1][param6] == null)
            {
               this._sideMissionDisplayNumbers[param1][param6] = 1;
            }
            else
            {
               this._sideMissionDisplayNumbers[param1][param6] += 1;
            }
            _loc11_ = int(this._sideMissionDisplayNumbers[param1][param6]);
         }
         var _loc12_:BMWorldMapLocationData = new BMWorldMapLocationData();
         this._totalMissions[param1] += 1;
         var _loc13_:uint = uint(this._totalMissions[param1]);
         _loc12_.initializeMission(param1,this._missionsDB[param1].length,_loc13_,_loc11_,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         this._missionsDB[param1].push(_loc12_);
         this._totalChapters[param1] = Math.max(this._totalChapters[param1],param5);
         if(param1 == 0)
         {
            this._mapProgressTrace += "v";
         }
      }
      
      private function createWorldMapItemBoxLocationData(param1:uint, param2:uint, param3:uint, param4:uint = 1, param5:uint = 5, param6:uint = 0) : void
      {
         var _loc7_:BMWorldMapLocationData = new BMWorldMapLocationData();
         var _loc8_:uint = uint(this._totalMissions[param1]);
         _loc7_.initializeItemBoxLoot(param1,this._missionsDB[param1].length,_loc8_,param2,param3,param4,param5,param6);
         this._missionsDB[param1].push(_loc7_);
         if(param1 == 0)
         {
            this._mapProgressTrace += "x";
         }
      }
      
      private function createWorldMapCustomItemBoxLocationData(param1:uint, param2:uint, param3:uint, param4:uint = 1, param5:uint = 1, param6:uint = 0) : void
      {
         var _loc7_:BMWorldMapLocationData = new BMWorldMapLocationData();
         var _loc8_:uint = uint(this._totalMissions[param1]);
         _loc7_.initializeCustomItemBoxLoot(param1,this._missionsDB[param1].length,_loc8_,param2,param3,param4,param5,param6);
         this._missionsDB[param1].push(_loc7_);
         if(param1 == 0)
         {
            this._mapProgressTrace += "x";
         }
      }
      
      public function getMissionBossData(param1:uint, param2:int, param3:String, param4:int) : BMWorldMapBossData
      {
         if(param3 == null)
         {
            trace("WARNING: BOSS DATA SLOT IS NULLED - AUTO SETTING TO FIRST BOSS");
            param3 = "RAMBOY";
         }
         var _loc5_:uint = 1159;
         var _loc6_:uint = 2;
         var _loc7_:uint = this.dataM.campaignMissionRewardsRepository.getMissionEnemyPowerRating(param1,param2,param4) + _loc6_;
         var _loc8_:BMWorldMapBossData = new BMWorldMapBossData();
         var _loc9_:* = this.dataM.missionBossData[param3];
         _loc8_.setName(_loc9_.name);
         _loc8_.torso = this.getItemFromChainByPowerRating(_loc9_.torso,_loc7_);
         _loc8_.leg = this.getItemFromChainByPowerRating(_loc9_.leg,_loc7_);
         _loc8_.sideWeapon1 = this.getItemFromChainByPowerRating(_loc9_.sideWeapon1,_loc7_);
         _loc8_.sideWeapon2 = this.getItemFromChainByPowerRating(_loc9_.sideWeapon2,_loc7_);
         _loc8_.sideWeapon3 = this.getItemFromChainByPowerRating(_loc9_.sideWeapon3,_loc7_);
         _loc8_.sideWeapon4 = this.getItemFromChainByPowerRating(_loc9_.sideWeapon4,_loc7_);
         _loc8_.topWeapon1 = this.getItemFromChainByPowerRating(_loc9_.topWeapon1,_loc7_);
         _loc8_.topWeapon2 = this.getItemFromChainByPowerRating(_loc9_.topWeapon2,_loc7_);
         _loc8_.drone = this.getItemFromChainByPowerRating(_loc9_.drone,_loc7_);
         _loc8_.teleport = this.getItemFromChainByPowerRating(_loc9_.teleport,_loc7_);
         _loc8_.charge = this.getItemFromChainByPowerRating(_loc9_.charge,_loc7_);
         _loc8_.harpoon = this.getItemFromChainByPowerRating(_loc9_.harpoon,_loc7_);
         _loc8_.shield = this.getItemFromChainByPowerRating(_loc9_.shield,_loc7_);
         _loc8_.module1 = this.getItemFromChainByPowerRating(_loc9_.module1,_loc7_);
         _loc8_.module2 = this.getItemFromChainByPowerRating(_loc9_.module2,_loc7_);
         _loc8_.module3 = this.getItemFromChainByPowerRating(_loc9_.module3,_loc7_);
         _loc8_.module4 = this.getItemFromChainByPowerRating(_loc9_.module4,_loc7_);
         _loc8_.module5 = this.getItemFromChainByPowerRating(_loc9_.module5,_loc7_);
         _loc8_.module6 = this.getItemFromChainByPowerRating(_loc9_.module6,_loc7_);
         _loc8_.module7 = this.getItemFromChainByPowerRating(_loc9_.module7,_loc7_);
         _loc8_.perk = _loc5_;
         return _loc8_;
      }
      
      public function getItemFromChainByPowerRating(param1:uint, param2:uint = 0) : uint
      {
         var _loc4_:uint = 0;
         if(param1 == 0)
         {
            return param1;
         }
         if(param2 == 0)
         {
            return param1;
         }
         var _loc3_:BMItemData = this.dataM.itemsDB[param1];
         if(_loc3_ == null)
         {
         }
         if(_loc3_.powerRating == param2)
         {
            return param1;
         }
         if(this.dataM.itemsByChainIDs[_loc3_.chainID] == null)
         {
            return param1;
         }
         if(this.dataM.itemsByChainIDs[_loc3_.chainID][param2] != null)
         {
            return this.dataM.itemsByChainIDs[_loc3_.chainID][param2];
         }
         if(_loc3_.powerRating > param2)
         {
            _loc4_ = 0;
            while(_loc4_ < this.dataM.itemsByChainIDs[_loc3_.chainID].length)
            {
               if(this.dataM.itemsByChainIDs[_loc3_.chainID][_loc4_] != null)
               {
                  return this.dataM.itemsByChainIDs[_loc3_.chainID][_loc4_];
               }
               _loc4_++;
            }
            return param1;
         }
         return this.dataM.itemsByChainIDs[_loc3_.chainID][this.dataM.itemsByChainIDs[_loc3_.chainID].length - 1];
      }
      
      public function getMissionsDB(param1:*) : Vector.<BMWorldMapLocationData>
      {
         return this._missionsDB[param1];
      }
      
      public function getSpecificMissionDB(param1:uint, param2:uint) : BMWorldMapLocationData
      {
         return this._missionsDB[param1][param2];
      }
      
      public function doesMissionExist(param1:uint, param2:uint) : Boolean
      {
         if(param2 >= this._missionsDB[param1].length)
         {
            return false;
         }
         return this._missionsDB[param1][param2] != null;
      }
      
      public function get currentMissionDB() : BMWorldMapLocationData
      {
         return this._missionsDB[this.dataM.myProfile.currentStoryID][this.dataM.myProfile.currentMissionSlot];
      }
      
      public function get missionsItemBoxSlots() : Object
      {
         return this._missionsItemBoxSlots;
      }
      
      public function getChapterName(param1:uint) : String
      {
         if(param1 >= 1 && param1 <= 7)
         {
            return BMLanguageManager.getInstance().getText("missionWorldMap_chapter" + param1);
         }
         return "";
      }
      
      public function getBossDialog(param1:uint) : String
      {
         if(param1 >= 1 && param1 <= 7)
         {
            return BMLanguageManager.getInstance().getText("missionWorldMap_bossDialog" + param1);
         }
         return "";
      }
      
      public function getStoryDialog(param1:uint) : String
      {
         if(this.dataM.getGeneralSetting("showCampaignStory",0) == 0)
         {
            return "";
         }
         switch(param1)
         {
            case 2:
               return "Hey, are you the new mech pilot? Good timing! We\'re overrun by alien mechs! Push toward the Alien Boss and take him out!";
            case 6:
               return "This is it! Get your mech ready, and take this Alien Boss out!";
            case 8:
               return "YES!!! That was an impressive battle Pilot! Keep pushing forward like this and we\'ll kick them all off our planet! Keep it up!";
            default:
               return "";
         }
      }
      
      public function get missionLayouts_tutorial() : Array
      {
         if(this.dataM.useHiddenBaseMap)
         {
            return this._missionLayouts_tutorialHiddenBaseMaps;
         }
         return this._missionLayouts_tutorial;
      }
      
      public function get missionLayouts_regular() : Array
      {
         return this._missionLayouts_regular;
      }
      
      public function getChapterForSlot(param1:uint, param2:int) : int
      {
         return this._missionsDB[param1][param2].chapterID;
      }
      
      public function getBossSlotForChapter(param1:uint, param2:int) : int
      {
         var _loc3_:int = 0;
         while(_loc3_ < this._missionsDB[param1].length)
         {
            if(this._missionsDB[param1][_loc3_].chapterID == param2 && this._missionsDB[param1][_loc3_].subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         trace("Could not find boss mission for chapter!");
         return -1;
      }
      
      public function didCompleteChapter(param1:uint, param2:int, param3:int) : *
      {
         return this.didCompleteSlot(param1,this.getBossSlotForChapter(param1,param2),param3);
      }
      
      public function getHighestChapterCompleted(param1:uint, param2:int) : int
      {
         var _loc3_:uint = uint(this.getHighestPlayableMissionSlot(param1,param2));
         var _loc4_:BMWorldMapLocationData = this._missionsDB[param1][_loc3_];
         if(this.didCompleteChapter(param1,_loc4_.chapterID,param2))
         {
            return _loc4_.chapterID;
         }
         return _loc4_.chapterID - 1;
      }
      
      public function getAvailableMissionWithMostClanBossTickets(param1:int = -1) : Array
      {
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc2_:int = -1;
         var _loc3_:int = -1;
         var _loc4_:int = -1;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(_loc6_ < 2)
         {
            if(!(param1 > -1 && _loc6_ != param1))
            {
               _loc7_ = 0;
               while(_loc7_ < this._missionsDB[_loc6_].length)
               {
                  _loc8_ = 0;
                  while(_loc8_ <= 2)
                  {
                     if(this.didCompleteSlot(_loc6_,_loc7_,_loc8_) != false)
                     {
                        _loc9_ = this.dataM.campaignMissionRewardsRepository.getMissionClanBossTickets(_loc6_,_loc7_,_loc8_);
                        if(!(_loc9_ == 0 || _loc9_ < _loc5_))
                        {
                           _loc5_ = _loc9_;
                           _loc2_ = int(_loc6_);
                           _loc3_ = _loc7_;
                           _loc4_ = int(_loc8_);
                        }
                     }
                     _loc8_++;
                  }
                  _loc7_++;
               }
            }
            _loc6_++;
         }
         if(_loc2_ == -1)
         {
            if(!(param1 == -1 || param1 == 0))
            {
               return null;
            }
            _loc2_ = 0;
            _loc3_ = 3;
            _loc4_ = 0;
         }
         return [_loc2_,_loc3_,_loc4_];
      }
      
      public function didCompleteSlot(param1:uint, param2:int, param3:int) : Boolean
      {
         var _loc7_:String = null;
         var _loc4_:BMPlayerProfile = this.dataM.myProfile;
         var _loc5_:BMWorldMapLocationData = this._missionsDB[param1][param2];
         if(_loc5_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_DUNGEON)
         {
            _loc7_ = _loc4_.getDungeonProgress(param1,_loc5_.locationID,param3);
            return _loc7_ == MAP_PROGRESS_COMPLETE || _loc7_ == MAP_PROGRESS_REPLAY;
         }
         var _loc6_:Array = _loc4_.getMapProgress(param1,param3);
         if(_loc6_.length < param2)
         {
            return false;
         }
         return _loc6_[param2] == MAP_PROGRESS_COMPLETE || _loc6_[param2] == MAP_PROGRESS_REPLAY;
      }
      
      public function getSlotCompleteState(param1:uint, param2:int) : Vector.<Boolean>
      {
         var _loc3_:Vector.<Boolean> = new Vector.<Boolean>();
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            _loc3_.push(this.didCompleteSlot(param1,param2,_loc4_));
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getMissionStartState(param1:uint, param2:int, param3:int) : int
      {
         var _loc4_:BMWorldMapLocationData = null;
         var _loc5_:* = 0;
         var _loc6_:BMWorldMapLocationData = null;
         if(param3 == MISSION_MODE_NORMAL)
         {
            if(this.getHighestPlayableMissionSlot(param1,param3) < param2)
            {
               return MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MISSION;
            }
         }
         else
         {
            if(!this.didCompleteChapter(param1,this.getChapterForSlot(param1,param2),param3 - 1))
            {
               return MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MODE_CHAPTER;
            }
            if(!this.didCompleteSlot(param1,param2,param3 - 1))
            {
               return MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MISSION_DIFFICULTY;
            }
            _loc4_ = this._missionsDB[param1][param2];
            if(_loc4_.mainPath && _loc4_.displayNumber > 1)
            {
               _loc5_ = int(param2 - 1);
               while(_loc5_ >= 0)
               {
                  _loc6_ = this._missionsDB[param1][_loc5_];
                  if(_loc6_.mainPath)
                  {
                     if(!this.didCompleteSlot(param1,_loc5_,param3))
                     {
                        return MISSION_START_STATE_MUST_COMPLETE_PREVIOUS_MISSION;
                     }
                     break;
                  }
                  _loc5_--;
               }
            }
         }
         return MISSION_START_STATE_CAN_START;
      }
      
      public function isMissionOnMainPath(param1:uint, param2:int) : Boolean
      {
         var _loc3_:BMWorldMapLocationData = null;
         if(param1 == STORY_ID_CAMPAIGN_1V1 || param1 == STORY_ID_CAMPAIGN_2V2)
         {
            _loc3_ = this._missionsDB[param1][param2];
            return _loc3_ != null && _loc3_.mainPath;
         }
         return false;
      }
      
      public function getRecommendedMissionSlot(param1:uint, param2:int = -1) : int
      {
         var _loc5_:int = 0;
         var _loc3_:int = this.getLastMissionSlotOnPath(param1);
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            if(!(param2 >= 0 && param2 != _loc4_))
            {
               _loc5_ = this.getLastCompleteMissionSlotOnPath(param1,_loc4_);
               if(_loc5_ < _loc3_)
               {
                  return this.getNextMissionSlotOnPath(param1,_loc5_);
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getLastCompleteMissionSlotOnPath(param1:uint, param2:int) : int
      {
         var _loc6_:BMWorldMapLocationData = null;
         var _loc3_:BMPlayerProfile = this.dataM.myProfile;
         var _loc4_:Array = _loc3_.getMapProgress(param1,param2);
         var _loc5_:* = int(_loc4_.length - 1);
         while(_loc5_ >= 0)
         {
            _loc6_ = this._missionsDB[param1][_loc5_];
            if(_loc6_.mainPath && _loc6_.type == BMWorldMapLocationData.TYPE_MISSION && (_loc4_[_loc5_] == MAP_PROGRESS_COMPLETE || _loc4_[_loc5_] == MAP_PROGRESS_REPLAY))
            {
               return _loc5_;
            }
            _loc5_--;
         }
         return 0;
      }
      
      private function getLastMissionSlotOnPath(param1:uint) : int
      {
         var _loc3_:BMWorldMapLocationData = null;
         var _loc2_:* = int(this._missionsDB[param1].length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this._missionsDB[param1][_loc2_];
            if(_loc3_.mainPath && _loc3_.type == BMWorldMapLocationData.TYPE_MISSION)
            {
               return _loc2_;
            }
            _loc2_--;
         }
         return 0;
      }
      
      private function getNextMissionSlotOnPath(param1:uint, param2:int) : int
      {
         var _loc4_:BMWorldMapLocationData = null;
         var _loc3_:int = param2 + 1;
         while(_loc3_ < this._missionsDB[param1].length)
         {
            _loc4_ = this._missionsDB[param1][_loc3_];
            if(_loc4_.mainPath && _loc4_.type == BMWorldMapLocationData.TYPE_MISSION)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return this._missionsDB.length - 1;
      }
      
      public function getHighestMissionCompletedSlot(param1:uint, param2:uint) : int
      {
         var _loc3_:uint = uint(this.getHighestPlayableMissionSlot(param1,param2));
         var _loc4_:Array = this.dataM.myProfile.getMapProgress(param1,param2);
         if(_loc4_[_loc3_] == MAP_PROGRESS_COMPLETE)
         {
            return _loc3_;
         }
         if(_loc3_ == 0)
         {
            return -1;
         }
         var _loc5_:Number = _loc3_ - 1;
         while(_loc5_ >= 0)
         {
            if(_loc4_[_loc5_] == MAP_PROGRESS_COMPLETE)
            {
               return _loc5_;
            }
            _loc5_--;
         }
         return -1;
      }
      
      public function getAllCampaignsProgress() : uint
      {
         var _loc1_:uint = uint(this.getHighestMissionCompletedSlot(STORY_ID_CAMPAIGN_1V1,0));
         _loc1_ += 1 + this.getHighestMissionCompletedSlot(STORY_ID_CAMPAIGN_2V2,0);
         return uint(_loc1_ + (1 + this.getHighestMissionCompletedSlot(STORY_ID_CAMPAIGN_3V3,0)));
      }
      
      public function getHighestPlayableMissionSlot(param1:uint, param2:int) : int
      {
         var _loc5_:BMWorldMapLocationData = null;
         var _loc6_:Number = NaN;
         var _loc3_:BMPlayerProfile = this.dataM.myProfile;
         var _loc4_:Number = -1;
         var _loc7_:Array = _loc3_.getMapProgress(param1,param2);
         _loc6_ = _loc7_.length - 1;
         while(_loc6_ >= 0)
         {
            if(_loc7_[_loc6_] == MAP_PROGRESS_COMPLETE)
            {
               _loc5_ = this._missionsDB[param1][_loc6_];
               if(_loc5_.type == BMWorldMapLocationData.TYPE_MISSION && _loc5_.subType != BMWorldMapLocationData.SUB_TYPE_MISSION_DUNGEON)
               {
                  _loc4_ = _loc6_;
                  _loc6_ = 0;
               }
            }
            _loc6_--;
         }
         if(_loc4_ == -1)
         {
            return 0;
         }
         var _loc8_:int = _loc4_;
         _loc6_ = _loc4_ + 1;
         while(_loc6_ < this._missionsDB[param1].length)
         {
            _loc5_ = this._missionsDB[param1][_loc6_];
            if(_loc5_.type == BMWorldMapLocationData.TYPE_MISSION && _loc5_.mainPath)
            {
               _loc8_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         return _loc8_;
      }
      
      public function getTotalMissionsCompleted(param1:uint, param2:uint) : uint
      {
         var _loc3_:int = this.getHighestMissionCompletedSlot(param1,param2);
         if(_loc3_ == -1)
         {
            return 0;
         }
         var _loc4_:BMWorldMapLocationData = this._missionsDB[param1][_loc3_];
         return _loc4_.missionNumber;
      }
      
      public function getMissionDifficulty(param1:uint, param2:int) : int
      {
         var _loc3_:BMWorldMapLocationData = this._missionsDB[param1][param2];
         return _loc3_.difficulty;
      }
      
      public function getMissionFirstClearBonusTokens(param1:uint, param2:int, param3:int) : int
      {
         return this.dataM.campaignMissionRewardsRepository.getMissionFirstClearRewardTokens(param1,param2,param3);
      }
      
      public function getMissionClanBossTickets(param1:uint, param2:int, param3:int) : int
      {
         return this.dataM.campaignMissionRewardsRepository.getMissionClanBossTickets(param1,param2,param3);
      }
      
      public function getMissionBoxFragmentsGachaMachineID(param1:uint, param2:int, param3:int) : int
      {
         var _loc4_:Object = this.dataM.campaignMissionRewardsRepository.getMissionBoxFragmentsData(param1,param2,param3);
         if(_loc4_ == null)
         {
            return 0;
         }
         return _loc4_.gachaMachineID;
      }
      
      public function getMissionBoxFragmentsMax(param1:uint, param2:int, param3:int) : int
      {
         var _loc4_:Object = this.dataM.campaignMissionRewardsRepository.getMissionBoxFragmentsData(param1,param2,param3);
         if(_loc4_ == null)
         {
            return 0;
         }
         return _loc4_.amount;
      }
      
      public function shouldUserBeExposedToBattleCredits() : Boolean
      {
         return this.shouldUserBeExposedToMissionModes();
      }
      
      public function shouldUserBeExposedToMissionModes() : Boolean
      {
         var _loc1_:uint = 0;
         return this.didCompleteSlot(_loc1_,2,0);
      }
      
      public function didCompleteCampaign(param1:uint, param2:int) : Boolean
      {
         return this.getLastCompleteMissionSlotOnPath(param1,param2) == this.getLastMissionSlotOnPath(param1);
      }
      
      public function getCurrentMissionPosition() : uint
      {
         var _loc1_:BMPlayerProfile = this.dataM.myProfile;
         return (this.dataM.mission_battleRow - 1) * _loc1_.mission_columns + this.dataM.mission_battleColumn;
      }
      
      public function getBaseDifficultyMultiplier(param1:uint, param2:uint, param3:uint, param4:uint) : Number
      {
         return this.dataM.campaignMissionRewardsRepository.getMissionDifficultyMultiplier(param1,param2,param3,param4);
      }
      
      public function getAIMechHPMultiplier(param1:uint, param2:uint, param3:uint, param4:uint) : Number
      {
         return this.getBaseDifficultyMultiplier(param1,param2,param3,param4);
      }
      
      public function getAIMechDamageMultiplier(param1:uint, param2:uint, param3:uint, param4:uint) : Number
      {
         return this.getBaseDifficultyMultiplier(param1,param2,param3,param4);
      }
      
      public function getAIMechHeatEnergyMultiplier(param1:uint, param2:uint, param3:uint, param4:uint) : Number
      {
         var _loc5_:Number = this.getBaseDifficultyMultiplier(param1,param2,param3,param4);
         return (1 + _loc5_) / 2;
      }
      
      public function getStoryCompletionRatio(param1:uint) : uint
      {
         var _loc2_:uint = this.getTotalMissionsCompleted(param1,0);
         _loc2_ += this.getTotalMissionsCompleted(param1,1);
         _loc2_ += this.getTotalMissionsCompleted(param1,2);
         return Math.floor(_loc2_ / 3 / this._totalMissions[param1] * 100);
      }
      
      public function getVisualMissionsDataByChapterIDs(param1:uint, param2:Array) : Array
      {
         var _loc5_:BMWorldMapLocationData = null;
         var _loc6_:Object = null;
         var _loc7_:uint = 0;
         var _loc3_:Array = new Array();
         var _loc4_:uint = 0;
         while(_loc4_ < this._missionsDB[param1].length)
         {
            _loc5_ = this._missionsDB[param1][_loc4_];
            if(param2.indexOf(_loc5_.chapterID) != -1)
            {
               if(_loc5_.type == BMWorldMapLocationData.TYPE_MISSION)
               {
                  _loc6_ = new Object();
                  _loc6_.slot = _loc4_;
                  _loc6_.xPos = _loc5_.xPos;
                  _loc6_.yPos = _loc5_.yPos;
                  _loc6_.stars = 0;
                  _loc7_ = 0;
                  while(_loc7_ <= 2)
                  {
                     if(this.didCompleteSlot(param1,_loc4_,_loc7_))
                     {
                        _loc6_.stars = _loc7_ + 1;
                     }
                     _loc7_++;
                  }
                  _loc3_.push(_loc6_);
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function isChapterLocked(param1:uint, param2:uint) : Boolean
      {
         return this.getChapterReleaseDate(param1,param2) > this.dataM.currentTime;
      }
      
      public function getChapterReleaseDate(param1:uint, param2:uint) : uint
      {
         if(this.campaignChaptersReleaseDataAvailable() == false)
         {
            return 0;
         }
         if(this.campaignChaptersReleaseData.storiesData[param1] == null)
         {
            return 0;
         }
         if(this.campaignChaptersReleaseData.storiesData[param1].releaseDates[param2 - 1] == null)
         {
            return 0;
         }
         return this.campaignChaptersReleaseData.storiesData[param1].releaseDates[param2 - 1];
      }
      
      public function showCampaignMenu() : Boolean
      {
         if(this.campaignChaptersReleaseDataAvailable() == false)
         {
            return false;
         }
         var _loc1_:uint = uint(this.dataM.myProfile.level);
         if(_loc1_ >= this.campaignChaptersReleaseData.levelRequiredForCampaignMenu)
         {
            return true;
         }
         return false;
      }
      
      public function isStoryVisible(param1:uint) : Boolean
      {
         if(this.campaignChaptersReleaseDataAvailable() == false)
         {
            return false;
         }
         if(this.campaignChaptersReleaseData.storiesData[param1] == null)
         {
            return false;
         }
         if(this.campaignChaptersReleaseData.storiesData[param1].visibleFromDate == null)
         {
            return true;
         }
         return int(this.campaignChaptersReleaseData.storiesData[param1].visibleFromDate) < this.dataM.currentTime;
      }
      
      public function isStoryLocked(param1:uint) : Boolean
      {
         if(this.campaignChaptersReleaseDataAvailable() == false)
         {
            return false;
         }
         if(this.campaignChaptersReleaseData.storiesData[param1] == null)
         {
            return false;
         }
         var _loc2_:uint = uint(this.dataM.myProfile.level);
         return _loc2_ < this.campaignChaptersReleaseData.storiesData[param1].levelRequired;
      }
      
      public function getStoryLevelRequired(param1:uint) : uint
      {
         if(this.campaignChaptersReleaseDataAvailable() == false)
         {
            return 0;
         }
         if(this.campaignChaptersReleaseData.storiesData[param1] == null)
         {
            return 0;
         }
         return this.campaignChaptersReleaseData.storiesData[param1].levelRequired;
      }
      
      public function getTotalChapters(param1:uint) : uint
      {
         return this._totalChapters[param1];
      }
      
      public function getTotalMissions(param1:*) : uint
      {
         return this._totalMissions[param1];
      }
      
      private function campaignChaptersReleaseDataAvailable() : Boolean
      {
         if(this.campaignChaptersReleaseData == null)
         {
            return false;
         }
         if(this.campaignChaptersReleaseData.storiesData == null)
         {
            return false;
         }
         return true;
      }
      
      private function get campaignChaptersReleaseData() : Object
      {
         if(this._campaignChaptersReleaseData != null)
         {
            return this._campaignChaptersReleaseData;
         }
         this._campaignChaptersReleaseData = new Object();
         var _loc1_:String = this.dataM.getGeneralSetting("campaignChaptersReleaseData",null);
         if(_loc1_ == null)
         {
            return this._campaignChaptersReleaseData;
         }
         this._campaignChaptersReleaseData = JSON.parse(_loc1_);
         return this._campaignChaptersReleaseData;
      }
      
      public function parseDungeons(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:BMWorldMapLocationData = null;
         if(param1 == null)
         {
            return;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = uint(STORY_ID_DUNGEON);
            _loc5_ = uint(_loc2_);
            _loc6_ = this.getMissionIndex(_loc4_,_loc5_);
            _loc7_ = new BMWorldMapLocationData();
            _loc7_.initializeDungeon(_loc4_,_loc5_,_loc3_.name,_loc3_.location[0],_loc3_.location[1],_loc3_.themeID,_loc3_.campaignID,_loc3_.startDate,_loc3_.duration,_loc3_.bossID);
            if(_loc6_ == -1)
            {
               this._missionsDB[_loc4_].push(_loc7_);
            }
            else
            {
               this._missionsDB[_loc4_][_loc6_] = _loc7_;
            }
         }
      }
      
      public function getMissionIndex(param1:uint, param2:uint) : int
      {
         var _loc3_:int = 0;
         while(_loc3_ < this._missionsDB[param1].length)
         {
            if(this._missionsDB[param1][_loc3_].locationID == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function get clanBossActive() : Boolean
      {
         return true;
      }
      
      public function getClanBossPosition() : Point
      {
         return new Point(200,200);
      }
      
      public function getFocusedMissionSlot(param1:uint) : int
      {
         if(this.dataM.myProfile.currentMissionSlot > -1)
         {
            return this.dataM.myProfile.currentMissionSlot;
         }
         return this.getRecommendedMissionSlot(param1);
      }
      
      public function getNextBossLocationID(param1:uint, param2:Number = -1, param3:uint = 0) : Number
      {
         var _loc5_:BMWorldMapLocationData = null;
         if(param2 >= this._missionsDB[param1].length - 1)
         {
            return NO_LOCATION_ID;
         }
         if(this.didCompleteCampaign(param1,MISSION_MODE_NORMAL))
         {
            return NO_LOCATION_ID;
         }
         if(param2 == -1)
         {
            param2 = this.getRecommendedMissionSlot(param1);
         }
         var _loc4_:uint = param2;
         while(_loc4_ < this._missionsDB[param1].length)
         {
            _loc5_ = this._missionsDB[param1][_loc4_];
            if(_loc5_.type == BMWorldMapLocationData.TYPE_MISSION && _loc5_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS)
            {
               if(param3 > 0 && param3 != _loc5_.chapterID)
               {
                  return NO_LOCATION_ID;
               }
               return _loc4_;
            }
            _loc4_++;
         }
         return NO_LOCATION_ID;
      }
      
      public function getTauntBossLocationID(param1:uint) : int
      {
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return NO_LOCATION_ID;
         }
         if(this.tauntBossesOnCampaignMapEnabled == false)
         {
            return NO_LOCATION_ID;
         }
         if(this.didCompleteCampaign(param1,0))
         {
            return NO_LOCATION_ID;
         }
         return this.getNextBossLocationID(param1,this.getRecommendedMissionSlot(param1));
      }
      
      public function get tauntBossesOnCampaignMapEnabled() : Boolean
      {
         if(this.dataM.getGeneralSetting("showTauntBossesOnCampaignMap",0) == 1)
         {
            return true;
         }
         return false;
      }
      
      public function startBattle_phase1(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:uint = 0) : void
      {
         var player1Step:Number;
         var player2Step:Number;
         var $battleType:String = param1;
         var $battleSubType:String = param2;
         var $openVSScreen:Boolean = param3;
         var $damagedEnemy:Boolean = param4;
         var $isOnlineBattle:Boolean = param5;
         var $clanWarOpponentID:uint = param6;
         this._startBattle_startPositionsExist = false;
         this._startBattle_battlePosition = this.dataM.singlePlayerM.getCurrentMissionPosition();
         this._startBattle_battleVSComputerSuccess = false;
         this._startBattle_blackScreenClosed = false;
         player1Step = -1;
         player2Step = -1;
         if(this.dataM.myProfile.mission_startPositions[this._startBattle_battlePosition] != null)
         {
            this._startBattle_startPositionsExist = true;
            player1Step = Number(this.dataM.myProfile.mission_startPositions[this._startBattle_battlePosition].player1Step);
            player2Step = Number(this.dataM.myProfile.mission_startPositions[this._startBattle_battlePosition].player2Step);
         }
         this.screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         if(this.screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
         {
            this.screensM.screenMissionBaseMap.activateSaving("startBattle_phase1");
         }
         this._startBattle_showBlackScreen = !$openVSScreen;
         if(this._startBattle_showBlackScreen && this.dataM.useHiddenBaseMap)
         {
            this._startBattle_showBlackScreen = false;
         }
         if(this._startBattle_showBlackScreen)
         {
            this.screensM.screenBlack.activateBlackScreen(null,true,true,null,0,true,this.screenBlackClosed);
         }
         this.dataM.startBattleVSComputer($battleType,$battleSubType,player1Step,player2Step,this._startBattle_battlePosition,function(param1:Boolean):*
         {
            _startBattle_battleVSComputerSuccess = true;
            _startBattle_fightingDamagedEnemy = $damagedEnemy;
            startBattle_phase2(param1);
         },$isOnlineBattle,$clanWarOpponentID);
      }
      
      public function get isFightingDamagedEnemy() : Boolean
      {
         return this._startBattle_fightingDamagedEnemy;
      }
      
      private function screenBlackClosed() : void
      {
         this._startBattle_blackScreenClosed = true;
         this.startBattle_phase2();
      }
      
      private function startBattle_phase2(param1:Boolean = true) : void
      {
         var _loc2_:BMPlayerData = null;
         var _loc3_:Boolean = false;
         if(param1 == false)
         {
         }
         if(this._startBattle_battleVSComputerSuccess == false)
         {
            return;
         }
         if(this._startBattle_showBlackScreen && this._startBattle_blackScreenClosed == false)
         {
            return;
         }
         if(this.screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
         {
            this.screensM.screenMissionBaseMap.deactivateSaving(true);
         }
         if(this._startBattle_showBlackScreen)
         {
            this.screensM.screenBlack.unBlockOpeningScreen();
         }
         this.screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.saveComputerItemsInProfile(this._startBattle_battlePosition);
         if(this._startBattle_startPositionsExist == false)
         {
            this.dataM.myProfile.mission_startPositions[this._startBattle_battlePosition] = {
               "player1Step":this.dataM.battleData.player1.currentStep,
               "player2Step":this.dataM.battleData.player2.currentStep
            };
         }
         if(this.dataM.useHiddenBaseMap)
         {
            this.startBattle_phase3();
         }
         else if(this._startBattle_showBlackScreen)
         {
            this.startBattle_phase3();
         }
         else
         {
            this.screensM.addScreen(BMScreensManager.SCR_VS,true,null,[false]);
            this.screensM.screenVS.addStartPVEBattleFunction(this.startBattle_phase3);
            this.screensM.screenVS.activateScreen();
            _loc2_ = this.dataM.playersData[this.dataM.player2PlayerID];
            this.screensM.screenVS.battleStarted(_loc2_.mechStructures[1]);
            _loc3_ = false;
            if(this.dataM.raidData.isRaidInProgress() && this.dataM.raidData.mechsPerPlayer > 1)
            {
               _loc3_ = true;
            }
            else if(BMSinglePlayerManager.MECHS_PER_STORY_ID[this.dataM.myProfile.currentStoryID] > 1)
            {
               _loc3_ = true;
            }
            else if(BattleTypeResolver.isClanWar)
            {
            }
            if(_loc3_)
            {
               this.screensM.screenVS.addInstantMultipleMechs();
            }
         }
      }
      
      private function startBattle_phase3() : void
      {
         if(this.dataM.useHiddenBaseMap)
         {
            this.screensM.screenBattle.startNewBattleSuccessSub();
            return;
         }
         if(this.screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
         {
            this.screensM.screenMissionBaseMap.removeMe();
            this.screensM.removeScreen(BMScreensManager.SCR_TOP_BAR);
         }
         else if(this.screensM.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
         {
            this.screensM.screenMissionWorldMap.removeMe();
         }
         this.screensM.addBattleScreens();
      }
      
      private function saveComputerItemsInProfile(param1:Number) : void
      {
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:Object = null;
         var _loc2_:BMPlayerData = this.dataM.playersData[this.dataM.player2PlayerID];
         this.dataM.myProfile.mission_computerItems[param1] = new Array();
         for each(_loc3_ in _loc2_.items)
         {
            _loc4_ = new Object();
            _loc4_.playerItemID = _loc3_.playerItemID;
            _loc4_.itemID = _loc3_.itemID;
            _loc4_.equipmentType = _loc3_.equipmentType;
            _loc4_.equipmentID = _loc3_.equipmentID;
            _loc4_.equipped = _loc3_.equipped;
            _loc4_.colorID = _loc3_.colorID;
            _loc4_.power = _loc3_.power;
            this.dataM.myProfile.mission_computerItems[param1].push(_loc4_);
         }
      }
      
      public function get allowNextMissionButtonInBattleResult() : Boolean
      {
         return this.dataM.getGeneralSetting("allowNextMissionButtonInBattleResult",0) == 1;
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private function get screensM() : BMScreensManager
      {
         return BMScreensManager.getInstance();
      }
   }
}

