package net.battleMechsMulti.mobiles
{
   public class BMPlayerProfile extends BMBaseClass
   {
      
      public var playerID:Number = 0;
      
      public var playerName:String = "";
      
      public var userName:String = "";
      
      public var gold:Number = 0;
      
      public var tokens:Number = 0;
      
      public var tokens_supporter:Number = 0;
      
      public var tokens_bonus:Number = 0;
      
      public var XP:Number = 0;
      
      public var level:Number = 0;
      
      public var lastLevel:Number = 0;
      
      public var levelByItems:Number = 0;
      
      public var levelByItems_noLimitation:Number = 0;
      
      public var overallRank:Number = 0;
      
      public var ladderProgress:Number = 0;
      
      public var lastLadderProgress:Number = 0;
      
      public var onlineRank:Number = 0;
      
      public var onlineWins:Number = 0;
      
      public var onlineBattles:Number = 0;
      
      public var winsVSComputer:Number = 0;
      
      public var battlesVSComputer:Number = 0;
      
      public var winsTotal:Number = 0;
      
      public var winLossStreak:Number = 0;
      
      public var campaignWins:Number = 0;
      
      public var campaignLosesStreak:Number = 0;
      
      public var lastNewsID:Number = 0;
      
      public var lastNewsIDBeforeLogin:Number = 0;
      
      public var totalGoldGained:Number = 0;
      
      public var totalXPGained:Number = 0;
      
      public var playersJoinedByInvitation:Number = 0;
      
      public var gameSettings:String = "11100000";
      
      public var tutorialLevel:Number = 0;
      
      public var watchedOpeningSequenceThisSession:Boolean = false;
      
      public var geo:String = "";
      
      public var isAdmin:Boolean = false;
      
      public var superMechs:Number = 0;
      
      public var freePackages:Array = new Array();
      
      public var initialSelectedMechID:uint = 1;
      
      public var rateStatus:String = "";
      
      public var missionsCompleted:uint = 0;
      
      public var missionsCompletedAtLastChallenge:uint = 0;
      
      public var playTime:Number;
      
      public var firstSessionDate:Number;
      
      public var battleCredits:uint = 0;
      
      public var nextBattleCreditsReset:Number = 0;
      
      public var battleCreditsBought:uint = 0;
      
      public var missionID:Number = 0;
      
      public var mapProgress:Array = new Array();
      
      public var currentMissionSlot:Number = -1;
      
      public var wonLastBattleVSComputer:Boolean = false;
      
      public var abortCurrentMission:Boolean = false;
      
      public var mission_layout:String = "";
      
      public var mission_hp:Number = 0;
      
      public var mission_energy:Number = 0;
      
      public var mission_energyRegeneration:Number = 0;
      
      public var mission_heat:Number = 0;
      
      public var mission_heatCooling:Number = 0;
      
      public var mission_bullets:Number = 0;
      
      public var mission_rockets:Number = 0;
      
      public var mission_startingPosition:Number = 0;
      
      public var mission_playerPosition:Number = 0;
      
      public var mission_themeID:uint = 0;
      
      public var mission_flag:String = "";
      
      public var mission_rows:uint = 0;
      
      public var mission_columns:uint = 0;
      
      public var mission_progress:Array = new Array();
      
      public var mission_upgrades:Array = new Array();
      
      public var mission_loot:Array = new Array();
      
      public var mission_gold:Number = 0;
      
      public var mission_difficulty:uint = 0;
      
      public var mission_colorID:Number = 0;
      
      public var mission_startPositions:Array = new Array();
      
      public var mission_computerItems:Object = new Object();
      
      public var gotFreeTokensDate:Number = 0;
      
      public var achievementsStatistics:Object;
      
      public var ageVerification:Boolean = false;
      
      public var gifts:Object = new Object();
      
      public var alreadyUsedAGift:Boolean = false;
      
      public var giftReceiversLevelProgress:Object = new Object();
      
      public var clanID:uint = 0;
      
      public var clan_name:String = "";
      
      public var clan_description:String = "";
      
      public var clan_leaderPlayerID:Number = 0;
      
      public var clan_ladderProgress:Number = 0;
      
      public var clan_ladderBattles:Number = 0;
      
      public var clan_ladderWins:Number = 0;
      
      public var clan_members:Array = new Array();
      
      public var clan_tryingToJoinClanID:Number = 0;
      
      public var clan_playersRequestedToJoin:Array = new Array();
      
      public var clan_winsRewardGold:Number = 0;
      
      public var clan_winsRewardBattleCredits:Number = 0;
      
      public var clan_flag:String = "";
      
      public var lastBattleResult:String = "";
      
      public var lastGoldGained:Number = 0;
      
      public var lastGoldFromLevelUp:Number = 0;
      
      public var lastTokensFromLevelUp:Number = 0;
      
      public var randomItemsFromLevelUp:Array = new Array();
      
      public var lastXPGained:Number = 0;
      
      public var winningStreakVSComputer:Number = 0;
      
      public var winningStreakVSComputerThisLevel:Number = 0;
      
      public var losingStreakVSComputer:Number = 0;
      
      public var computerLevelAddon:Number = -1;
      
      public var pendingStarterPackMech:Number = 0;
      
      public var timeToFirstPayment:Number = 0;
      
      public var tokensSpent:Number = 0;
      
      public var itemBoxesBought_guest:uint = 0;
      
      public var hasPerks:Boolean = false;
      
      public var notifications:Array = new Array();
      
      public var starterPackData:BMStarterPackData = new BMStarterPackData();
      
      public var freeItemBoxes:uint = 0;
      
      public var gotFreeItemBox:Number = 0;
      
      public var totalDamageDealt:Number = 0;
      
      public var dailyLoginStreak:Number = 0;
      
      public var lastDevice:String = "";
      
      public var userID:Number = 0;
      
      public var facebook:Boolean = false;
      
      public var avatarLink:String = "";
      
      public var newItemsPurchased:Array = new Array();
      
      public var expandedInventorySortingMessageDisplayed:Boolean = false;
      
      public var allowBattleChatMessages:Boolean = true;
      
      public function BMPlayerProfile()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function updateWinsTotal() : void
      {
         this.winsTotal = this.winsVSComputer + this.onlineWins;
      }
      
      public function setStarterPackData(param1:Object) : void
      {
         this.starterPackData = new BMStarterPackData();
         this.starterPackData.initialize(param1.packID,param1.offerDuration,param1.boostID,param1.boostAmount,param1.mechColorID,param1.torso,param1.leg,param1.sideWeapon1,param1.sideWeapon2,param1.topWeapon1,param1.topWeapon2,param1.module1,param1.module2,param1.module3,param1.module4,param1.module5,param1.drone,param1.bonusGold,param1.skin,param1.starterPackStatus,param1.starterPackStartDate);
      }
      
      public function applyDurabilityChanges(param1:Array) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:uint = 0;
         var _loc10_:BMMechStructure = null;
         var _loc11_:String = null;
         var _loc2_:BMPlayerData = dataM.playersData[this.playerID];
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = Number(param1[_loc4_].playerItemID);
            _loc6_ = Number(param1[_loc4_].durability);
            _loc7_ = 0;
            while(_loc7_ < _loc2_.items.length)
            {
               _loc8_ = _loc2_.items[_loc7_];
               if(_loc8_.playerItemID == _loc5_)
               {
                  if(_loc6_ == 0)
                  {
                     _loc9_ = _loc8_.equipped;
                     _loc10_ = _loc2_.mechStructures[_loc9_];
                     _loc11_ = _loc8_.equipmentType;
                     if(_loc8_.equipmentID > 0)
                     {
                        _loc11_ += _loc8_.equipmentID;
                     }
                     _loc10_[_loc11_] = 0;
                     dataM.removePlayerItemData(dataM.player1PlayerID,_loc5_);
                     _loc3_++;
                     TsLogger.log("ITEM DELETED");
                  }
                  else
                  {
                     _loc8_.durability = _loc6_;
                     TsLogger.log("DURABILITY REDUCED");
                  }
                  _loc7_ = _loc2_.items.length;
               }
               _loc7_++;
            }
            _loc4_++;
         }
         if(_loc3_ == 1)
         {
            screensM.screenConfirmation.displayUrgentMessage("mythicalItemDestroyed");
         }
         else if(_loc3_ > 1)
         {
            screensM.screenConfirmation.displayUrgentMessage("mythicalItemsDestroyed");
         }
      }
      
      public function setFreePackages(param1:String) : void
      {
         this.freePackages = new Array();
         if(param1 != "")
         {
            this.freePackages = param1.split(",");
         }
      }
      
      public function getFreePackagesString() : String
      {
         var _loc1_:String = "";
         var _loc2_:uint = 0;
         while(_loc2_ < this.freePackages.length)
         {
            if(_loc1_ != "")
            {
               _loc1_ += ",";
            }
            _loc1_ += this.freePackages[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getAllFreePackagesAmount() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this.freePackages.length)
         {
            if(this.freePackages[_loc2_] != 9)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getFreePackageAmount(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < this.freePackages.length)
         {
            if(int(this.freePackages[_loc3_]) == param1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         if(param1 == 9)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function removeFreePackage(param1:Number) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.freePackages.length)
         {
            if(int(this.freePackages[_loc2_]) == param1)
            {
               this.freePackages.splice(_loc2_,1);
               _loc2_ = this.freePackages.length;
            }
            _loc2_++;
         }
      }
      
      public function updateClanData(param1:Object) : void
      {
         var _loc2_:uint = 0;
         this.clanID = param1.clanID;
         this.clan_name = dataM.getCensoredString(param1.name);
         this.clan_flag = param1.flag;
         this.clan_leaderPlayerID = param1.leaderID;
         this.clan_ladderProgress = param1.ladderProgress;
         this.clan_ladderBattles = param1.ladderBattles;
         this.clan_ladderWins = param1.ladderWins;
         this.clan_members = param1.membersList;
         this.clan_members.sortOn("ladderProgress",Array.DESCENDING | Array.NUMERIC);
         var _loc3_:Object = new Object();
         if(param1.onlineMembers != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.onlineMembers.length)
            {
               _loc3_[param1.onlineMembers[_loc2_]] = true;
               _loc2_++;
            }
         }
         _loc2_ = 0;
         while(_loc2_ < this.clan_members.length)
         {
            this.clan_members[_loc2_].name = dataM.getCensoredString(this.clan_members[_loc2_].name);
            this.clan_members[_loc2_].isOnline = false;
            if(_loc3_[this.clan_members[_loc2_].playerID] != null)
            {
               this.clan_members[_loc2_].isOnline = true;
            }
            _loc2_++;
         }
      }
      
      public function updateMemberOnlineStatus(param1:Number, param2:Boolean) : void
      {
         var _loc3_:uint = 0;
         while(_loc3_ < this.clan_members.length)
         {
            if(this.clan_members[_loc3_].playerID == param1)
            {
               this.clan_members[_loc3_].isOnline = param2;
               _loc3_ = this.clan_members.length;
            }
            _loc3_++;
         }
      }
      
      public function updateMissionData(param1:Object) : void
      {
         var _loc5_:String = null;
         var _loc2_:String = "";
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < param1.mechData.length)
         {
            _loc5_ = param1.mechData.substr(_loc4_,1);
            if(_loc5_ == "_" || _loc4_ == param1.mechData.length - 1)
            {
               if(_loc4_ == param1.mechData.length - 1)
               {
                  _loc2_ += _loc5_;
               }
               switch(_loc3_)
               {
                  case 0:
                     this.mission_hp = int(_loc2_);
                     break;
                  case 1:
                     this.mission_energy = int(_loc2_);
                     break;
                  case 2:
                     this.mission_energyRegeneration = int(_loc2_);
                     break;
                  case 3:
                     this.mission_heat = int(_loc2_);
                     break;
                  case 4:
                     this.mission_heatCooling = int(_loc2_);
                     break;
                  case 5:
                     this.mission_bullets = int(_loc2_);
                     break;
                  case 6:
                     this.mission_rockets = int(_loc2_);
               }
               _loc3_++;
               _loc2_ = "";
            }
            else
            {
               _loc2_ += _loc5_;
            }
            _loc4_++;
         }
         this.missionID = param1.missionID;
         this.mission_layout = param1.layout;
         trace("GGGGGGGGGGG mission_layout:" + this.mission_layout);
         this.mission_startingPosition = param1.playerPosition;
         this.mission_playerPosition = param1.playerPosition;
         this.mission_themeID = param1.themeID;
         this.mission_flag = param1.flag;
         this.mission_rows = param1.rows;
         this.mission_columns = param1.columns;
         this.mission_progress = param1.progress;
         this.mission_upgrades = param1.upgrades;
         this.mission_gold = param1.gold;
         this.mission_difficulty = param1.difficulty;
         this.mission_loot = new Array();
         this.mission_computerItems = new Object();
      }
      
      public function clearMissionData() : void
      {
         this.missionID = 0;
         this.mission_layout = "";
         this.mission_hp = 0;
         this.mission_energy = 0;
         this.mission_energyRegeneration = 0;
         this.mission_heat = 0;
         this.mission_heatCooling = 0;
         this.mission_bullets = 0;
         this.mission_rockets = 0;
         this.mission_startingPosition = 0;
         this.mission_playerPosition = 0;
         this.mission_themeID = 0;
         this.mission_flag = "";
         this.mission_rows = 0;
         this.mission_columns = 0;
         this.mission_progress = new Array();
         this.mission_upgrades = new Array();
         this.mission_loot = new Array();
         this.mission_colorID = 0;
         this.mission_startPositions = new Array();
         this.mission_computerItems = new Object();
      }
      
      public function setMapProgress(param1:String) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(_loc2_ < dataM.missionsDB.length)
               {
                  _loc3_ = param1.substr(_loc2_,1);
                  this.mapProgress.push(_loc3_);
                  if(_loc3_ == "c")
                  {
                     this.currentMissionSlot = _loc2_;
                  }
               }
               _loc2_++;
            }
            if(this.mapProgress.length > 0)
            {
               _loc2_ = this.mapProgress.length - 1;
               while(_loc2_ >= 0)
               {
                  if(this.mapProgress[_loc2_] == "x")
                  {
                     this.mapProgress.splice(_loc2_,1);
                  }
                  else
                  {
                     _loc2_ = -1;
                  }
                  _loc2_--;
               }
            }
         }
      }
      
      public function addNotificationsData(param1:Array) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            this.notifications.push(param1[_loc2_]);
            _loc2_++;
         }
         if(this.notifications.length > 0)
         {
            screensM.screenConfirmation.displayUrgentMessage("newNotification");
         }
      }
      
      public function setSetting(param1:String, param2:Number) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Number = 8;
         switch(param1)
         {
            case "music":
               _loc3_ = 0;
               break;
            case "sound":
               _loc3_ = 1;
               break;
            case "breathing":
               _loc3_ = 2;
               break;
            case "particles":
               _loc3_ = 3;
               break;
            case "quality":
               _loc3_ = 4;
               break;
            case "seePerks":
               _loc3_ = 5;
         }
         if(_loc3_ == 0)
         {
            this.gameSettings = param2 + this.gameSettings.substr(1,_loc4_ - 1);
         }
         else if(_loc3_ == this.gameSettings.length)
         {
            this.gameSettings = this.gameSettings.substr(0,_loc4_ - 1) + param2;
         }
         else
         {
            this.gameSettings = this.gameSettings.substr(0,_loc3_) + param2 + this.gameSettings.substr(_loc3_ + 1,_loc4_ - 1);
         }
         trace("gameSettings:" + this.gameSettings);
      }
      
      public function getSetting(param1:String) : Number
      {
         var _loc3_:uint = 0;
         var _loc2_:Number = 0;
         if(this.gameSettings == null)
         {
            this.gameSettings = "11112100";
         }
         switch(param1)
         {
            case "music":
               _loc3_ = 0;
               break;
            case "sound":
               _loc3_ = 1;
               break;
            case "breathing":
               _loc3_ = 2;
               break;
            case "particles":
               _loc3_ = 3;
               break;
            case "quality":
               _loc3_ = 4;
               break;
            case "seePerks":
               _loc3_ = 5;
         }
         return int(this.gameSettings.substr(_loc3_,1));
      }
      
      public function getSettingAsBoolean(param1:String) : Boolean
      {
         var _loc2_:Number = this.getSetting(param1);
         var _loc3_:Boolean = false;
         if(_loc2_ == 1)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function updateLevelByItems() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMItemData = null;
         var _loc5_:Number = NaN;
         this.levelByItems = 0;
         this.levelByItems_noLimitation = 0;
         var _loc1_:BMPlayerData = dataM.playersData[this.playerID];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.items.length)
         {
            _loc2_ = _loc1_.items[_loc4_];
            if(_loc2_.equipped == _loc1_.selectedMechID)
            {
               _loc3_ = dataM.itemsDB[_loc2_.itemID];
               _loc5_ = _loc3_.level;
               if(this.levelByItems < _loc5_)
               {
                  this.levelByItems = _loc5_;
                  this.levelByItems_noLimitation = this.levelByItems;
               }
            }
            _loc4_++;
         }
         if(this.level > dataM.advancedMatchmakingBlockLevel && this.levelByItems < dataM.advancedMatchmakingBlockLevel)
         {
            this.levelByItems = dataM.advancedMatchmakingBlockLevel;
         }
      }
      
      public function setBattleCredits(param1:int, param2:String) : *
      {
         this.battleCredits = param1;
         if(param1 == 0 && param2 != null)
         {
            dataM.trackEvent("BattleCredits","Depleted",param2);
         }
      }
   }
}

