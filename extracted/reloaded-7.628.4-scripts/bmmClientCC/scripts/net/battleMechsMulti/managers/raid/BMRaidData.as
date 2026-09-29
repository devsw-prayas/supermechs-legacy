package net.battleMechsMulti.managers.raid
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.screens.raid.RaidLeaderboardData;
   
   public class BMRaidData extends BMBaseClass
   {
      
      public var attemptedLevel:int;
      
      public var currentLevelHighestScore:uint;
      
      public var currentLevel:uint;
      
      public var missionStatus:String;
      
      public var previewMechStructures:Array;
      
      public var previewEnemiesCount:Array;
      
      public var layout:String;
      
      public var day:uint;
      
      public var themeID:uint;
      
      public var reward:BMRewardData;
      
      public var currentWeekLeaderboard:Array;
      
      public var lastWeekLeaderboard:Array;
      
      public var lastRaidReward:BMRewardData;
      
      public var lastRaidRank:uint;
      
      public var lastRaidLevel:uint;
      
      public var mechsPerPlayer:uint;
      
      private var _lastRankingsByPlayerID:Object = new Object();
      
      private var _updateRaidPendingData:Object = null;
      
      private var _allowCurrentWeekLeaderboardResetTimer:Timer;
      
      private var _secondsSinceLastCurrentWeekLeaderboardReset:uint = 0;
      
      public function BMRaidData()
      {
         super();
         generateSingletonClassesPointers("");
         this.initTimer();
      }
      
      public function get raidDaysLeft() : uint
      {
         if(this.areRaidsEnabled() == false)
         {
            return 0;
         }
         return Math.max(0,6 - this.day);
      }
      
      public function areRaidsEnabled() : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         return BMDataManager.getInstance().getGeneralSetting("raidEnabled",0) == 1;
      }
      
      public function isRaidInProgress() : Boolean
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(this.areRaidsEnabled() == false)
         {
            return false;
         }
         return this.missionStatus == BMSinglePlayerManager.MAP_PROGRESS_IN_PROGRESS || this.missionStatus == BMSinglePlayerManager.MAP_PROGRESS_REPLAY;
      }
      
      public function get raidLastMissionScore() : uint
      {
         if(this.areRaidsEnabled() == false)
         {
            return 0;
         }
         if(this._updateRaidPendingData == null)
         {
            return 0;
         }
         return this._updateRaidPendingData.lastMissionScore;
      }
      
      public function updateRaidData(param1:Object, param2:Boolean = true) : void
      {
         if(this.areRaidsEnabled() == false)
         {
            return;
         }
         if(param1.currentLevelHighestScore == null)
         {
            return;
         }
         if(param2 == false)
         {
            this._updateRaidPendingData = param1;
            return;
         }
         this.attemptedLevel = param1.attemptedLevel;
         this.currentLevelHighestScore = param1.currentLevelHighestScore;
         this.currentLevel = param1.currentLevel;
         this.missionStatus = param1.missionStatus;
         this.mechsPerPlayer = 1;
         if(param1.mechsPerPlayer != null)
         {
            this.mechsPerPlayer = param1.mechsPerPlayer;
         }
         this.day = param1.raidDay;
         this.layout = param1.mapLayout.layout.layout;
         this.themeID = param1.mapLayout.themeID;
         this.lastRaidReward = null;
         if(param1.lastRaidReward != null)
         {
            this.lastRaidReward = new BMRewardData(param1.lastRaidReward);
         }
         this.lastRaidRank = param1.lastRaidRank;
         this.lastRaidLevel = param1.lastRaidLevel;
         this.reward = new BMRewardData(param1.reward);
         this.previewEnemiesCount = new Array();
         this.previewMechStructures = new Array();
         this.addRaidPreviewMechStructure(BMSinglePlayerManager.ENEMY_TYPE_JEEP,param1.enemies);
         this.addRaidPreviewMechStructure(BMSinglePlayerManager.ENEMY_TYPE_TANK,param1.enemies);
         this.addRaidPreviewMechStructure(BMSinglePlayerManager.ENEMY_TYPE_MECH,param1.enemies);
         this.addRaidPreviewMechStructure(BMSinglePlayerManager.ENEMY_TYPE_BOSS,param1.enemies);
         if(BMNotificationsManager.hasInstance())
         {
            BMRaidNotificationsHelper.updateLocalNotifications(BMNotificationsManager.getInstance());
         }
      }
      
      public function hasPendingReward() : Boolean
      {
         if(this.areRaidsEnabled() == false)
         {
            return false;
         }
         if(this.lastRaidReward == null)
         {
            return false;
         }
         return this.lastRaidReward.gold > 0 || this.lastRaidReward.tokens > 0;
      }
      
      public function get didAttemptCurrentLevel() : Boolean
      {
         if(this.areRaidsEnabled() == false)
         {
            return false;
         }
         return this.attemptedLevel == this.currentLevel;
      }
      
      public function get showCallToActionBadge() : Boolean
      {
         if(this.areRaidsEnabled() == false)
         {
            return false;
         }
         if(this.day == 6)
         {
            return false;
         }
         var _loc1_:uint = uint(int(dataM.getGeneralSetting("raidMinLevelForCallToActionBadge",999)));
         if(dataM.myProfile.level < _loc1_)
         {
            return false;
         }
         return this.attemptedLevel < this.currentLevel;
      }
      
      public function get didCompleteCurrentLevelRaid() : Boolean
      {
         return this.currentLevelHighestScore > 0;
      }
      
      public function rewardClaimed() : void
      {
         this.lastRaidReward = null;
      }
      
      private function addRaidPreviewMechStructure(param1:String, param2:Object) : void
      {
         var _loc3_:Array = null;
         var _loc5_:uint = 0;
         switch(param1)
         {
            case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
               _loc3_ = param2["JP"];
               break;
            case BMSinglePlayerManager.ENEMY_TYPE_TANK:
               _loc3_ = param2["TK"];
               break;
            case BMSinglePlayerManager.ENEMY_TYPE_MECH:
               _loc3_ = param2["ME"];
               break;
            case BMSinglePlayerManager.ENEMY_TYPE_BOSS:
               _loc3_ = param2["BS"];
         }
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:uint = this.getEnemiesCount(param1);
         if(_loc4_ == 0)
         {
            return;
         }
         this.previewEnemiesCount.push(_loc4_);
         if(_loc3_[0][0] == null)
         {
            this.previewMechStructures.push(BMMechStructure.parseMechStructureFromArray(_loc3_));
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               this.previewMechStructures.push(BMMechStructure.parseMechStructureFromArray(_loc3_[_loc5_]));
               _loc5_++;
            }
         }
      }
      
      private function getEnemiesCount(param1:String) : uint
      {
         var _loc4_:uint = 0;
         var _loc2_:Array = new Array();
         switch(param1)
         {
            case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
               _loc2_ = ["JP","J1","J2","J3"];
               break;
            case BMSinglePlayerManager.ENEMY_TYPE_TANK:
               _loc2_ = ["TK","T1","T2","T3"];
               break;
            case BMSinglePlayerManager.ENEMY_TYPE_MECH:
               _loc2_ = ["ME","M1","M2","M3"];
               break;
            case BMSinglePlayerManager.ENEMY_TYPE_BOSS:
               _loc2_ = ["BS","B1","B2","B3"];
         }
         var _loc3_:Number = -1;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = this.layout.indexOf(_loc2_[_loc4_]);
            if(_loc3_ > -1)
            {
               break;
            }
            _loc4_++;
         }
         if(_loc3_ == -1)
         {
            return 0;
         }
         var _loc5_:uint = 0;
         _loc4_ = _loc3_;
         while(_loc4_ < this.layout.length)
         {
            if(this.layout.substr(_loc4_,1) == "|")
            {
               break;
            }
            if(this.layout.substr(_loc4_,1) == "_")
            {
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function updateRaidPendingData() : void
      {
         if(this._updateRaidPendingData == null)
         {
            return;
         }
         this.updateRaidData(this._updateRaidPendingData);
         this._updateRaidPendingData = null;
      }
      
      public function reset() : void
      {
         this._updateRaidPendingData = null;
         this.currentWeekLeaderboard = null;
         this.lastWeekLeaderboard = null;
      }
      
      private function initTimer() : void
      {
         this._allowCurrentWeekLeaderboardResetTimer = new Timer(1000);
         this._allowCurrentWeekLeaderboardResetTimer.addEventListener(TimerEvent.TIMER,this.onTimerTrigger);
         this._allowCurrentWeekLeaderboardResetTimer.start();
      }
      
      private function onTimerTrigger(param1:TimerEvent) : void
      {
         ++this._secondsSinceLastCurrentWeekLeaderboardReset;
      }
      
      public function resetCurrentWeekLeaderboardData() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:RaidLeaderboardData = null;
         if(this._secondsSinceLastCurrentWeekLeaderboardReset < 10)
         {
            return;
         }
         this._secondsSinceLastCurrentWeekLeaderboardReset = 0;
         if(this.currentWeekLeaderboard != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.currentWeekLeaderboard.length)
            {
               _loc2_ = this.currentWeekLeaderboard[_loc1_];
               this._lastRankingsByPlayerID[_loc2_.playerID] = _loc2_.rank;
               _loc1_++;
            }
         }
         this.currentWeekLeaderboard = null;
      }
      
      public function getEnemiesColor() : uint
      {
         if(this.currentLevel <= 1)
         {
            return BMSinglePlayerManager.MISSION_COLOR_NORMAL;
         }
         if(this.currentLevel <= 3)
         {
            return BMSinglePlayerManager.MISSION_COLOR_HARD;
         }
         return BMSinglePlayerManager.MISSION_COLOR_INSANE;
      }
      
      public function reloadRaidData() : void
      {
         remoteM.socketM.raid_getData();
      }
      
      public function setLeaderboardData(param1:Array, param2:Boolean = true) : void
      {
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:String = null;
         var _loc15_:uint = 0;
         var _loc16_:int = 0;
         var _loc17_:RaidLeaderboardData = null;
         if(param2)
         {
            dataM.raidData.currentWeekLeaderboard = new Array();
         }
         else
         {
            dataM.raidData.lastWeekLeaderboard = new Array();
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = uint(_loc4_.playerID);
            _loc6_ = uint(_loc4_.rank);
            _loc7_ = uint(_loc4_.score);
            _loc8_ = uint(_loc4_.level);
            _loc9_ = _loc4_.name;
            _loc10_ = uint(_loc4_.ladderProgress);
            _loc11_ = uint(_loc4_.clanID);
            _loc12_ = uint(_loc4_.gold);
            _loc13_ = uint(_loc4_.tokens);
            _loc14_ = _loc4_.geo;
            _loc15_ = _loc6_;
            _loc16_ = 0;
            if(this._lastRankingsByPlayerID[_loc5_] != null)
            {
               _loc15_ = uint(this._lastRankingsByPlayerID[_loc5_]);
               if(_loc6_ > _loc15_)
               {
                  _loc16_ = -1;
               }
               else if(_loc6_ < _loc15_)
               {
                  _loc16_ = 1;
               }
            }
            _loc17_ = new RaidLeaderboardData(_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc16_);
            if(param2)
            {
               dataM.raidData.currentWeekLeaderboard.push(_loc17_);
            }
            else
            {
               dataM.raidData.lastWeekLeaderboard.push(_loc17_);
            }
            _loc3_++;
         }
      }
   }
}

