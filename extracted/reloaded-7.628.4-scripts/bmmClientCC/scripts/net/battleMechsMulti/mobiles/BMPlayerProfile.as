package net.battleMechsMulti.mobiles
{
   import net.battleMechsMulti.data.BMClanData;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.data.BMLevelUpData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.inventory.InventorySizeState;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMPlayerChainDiscountStatus;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.clan.BMClanBossData;
   import net.battleMechsMulti.screens.missionBaseMap.BMMissionMechStats;
   import net.battleMechsMulti.screens.missionBaseMap.BMMissionServerToClientStats;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.tacticsoft.utils.SafeInt;
   
   public class BMPlayerProfile extends BMBaseClass
   {
      
      public static const MISSION_BONUS_NONE:int = 0;
      
      public static const MISSION_BONUS_HP:int = 1;
      
      private static const CURRENT_MISSIONS_SLOT_DEFAULT:Array = [null,-1,-1];
      
      private static const CURRENT_MISSIONS_MODE_DEFAULT:Array = [null,0,0];
      
      public var playerID:Number = 0;
      
      public var playerName:String = "";
      
      public var userName:String = "";
      
      private var _gold:SafeInt = new SafeInt();
      
      private var _tokens:SafeInt = new SafeInt();
      
      private var _tokens_supporter:SafeInt = new SafeInt();
      
      private var _tokens_bonus:SafeInt = new SafeInt();
      
      private var _XP:SafeInt = new SafeInt();
      
      private var _level:SafeInt = new SafeInt();
      
      private var _lastLevel:SafeInt = new SafeInt();
      
      public var levelByItems:Number = 0;
      
      public var levelByItems_noLimitation:Number = 0;
      
      public var overallRank:Number = 0;
      
      public var ladderProgress:Number = 0;
      
      public var currentSeasonHighestLadderProgress:uint = 0;
      
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
      
      public var pvpInitialRankingListPosition:uint = 0;
      
      public var pvpFinalRankingListPosition:uint = 0;
      
      public var rankingListPosition:uint = 0;
      
      public var contentPackID:uint = 0;
      
      public var itemsExtraChanceStartDate:uint = 0;
      
      public var fortuneBoxFreeBoxCount:uint = 0;
      
      public var improveYourMechStarterPackOffer:Object = null;
      
      public var shopMechsBought:Object = new Object();
      
      public var chainDiscountsStatus:Array = new Array();
      
      public var skills:Array = [0,0,0,0,0,0,0,0,0,0,0,0];
      
      public var arenaCoins:uint = 0;
      
      public var clanCoins:uint = 0;
      
      public var lastArenaCoinsGained:Number = 0;
      
      public var lastNukesGained:Number = 0;
      
      public var battleCredits:uint = 0;
      
      public var missionID:Number = 0;
      
      public var mapProgress:Array = new Array();
      
      public var mapProgressHard:Array = new Array();
      
      public var mapProgressInsane:Array = new Array();
      
      public var mapProgress1Normal:Array = new Array();
      
      public var mapProgress1Hard:Array = new Array();
      
      public var mapProgress1Insane:Array = new Array();
      
      public var mapProgress3Normal:Array = new Array();
      
      public var mapProgress3Hard:Array = new Array();
      
      public var mapProgress3Insane:Array = new Array();
      
      public var dungeonProgress:Object = new Object();
      
      public var showEpilogueForMode:Number = -1;
      
      public var currentStoryID:int = -1;
      
      public var missionCurrentMechID:uint;
      
      public var _currentMissionSlot:int = -1;
      
      public var _currentMissionMode:int = 0;
      
      public var wonLastBattleVSComputer:Boolean = false;
      
      public var abortCurrentMission:Boolean = false;
      
      public var mission_layout:String = "";
      
      public var mission_mechStats:Array = new Array();
      
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
      
      public var mission_xp:int = 0;
      
      public var mission_difficulty:uint = 0;
      
      public var mission_colorID:Number = 0;
      
      public var mission_startPositions:Array = new Array();
      
      public var mission_computerItems:Object = new Object();
      
      public var mission_mode:uint = 0;
      
      public var mission_damagedEnemies:Array = new Array();
      
      public var lastHarvestingDatesByMissionSlot:Object = new Object();
      
      public var gotFreeTokensDate:Number = 0;
      
      public var ladderWins:uint = 0;
      
      public var nameChanges:uint = 0;
      
      public var ageVerification:Boolean = false;
      
      public var gifts:Object = new Object();
      
      public var alreadyUsedAGift:Boolean = false;
      
      public var giftReceiversLevelProgress:Object = new Object();
      
      public var clanData:BMClanData;
      
      public var clanID:uint = 0;
      
      public var clan_tryingToJoinClanID:Number = 0;
      
      public var clan_playersRequestedToJoin:Vector.<BMClanMemberData> = new Vector.<BMClanMemberData>();
      
      public var clan_winsRewardGold:Number = 0;
      
      public var clan_arenaPoints:uint = 0;
      
      public var clan_joinType:uint;
      
      public var clan_requiredRankToJoin:uint;
      
      public var clan_bossTickets:uint = 0;
      
      public var clan_bossHP:uint;
      
      public var clan_bossDamageDealtInLastBattle:uint;
      
      public var clan_bossBattlesDoneToday:uint;
      
      public var clan_bossCoinsToCollect:uint;
      
      public var clanBossData:BMClanBossData;
      
      public var lastBattleResult:String = "";
      
      public var lastGoldGained:Number = 0;
      
      public var randomItemsFromLevelUp:Array = new Array();
      
      public var lastXPGained:Number = 0;
      
      public var winningStreakVSComputer:Number = 0;
      
      public var losingStreakVSComputer:Number = 0;
      
      public var pendingStarterPackMech:Number = 0;
      
      public var timeToFirstPayment:Number = 0;
      
      public var tokensSpent:Number = 0;
      
      public var itemBoxesBought_guest:uint = 0;
      
      public var hasPerks:Boolean = false;
      
      public var notifications:Array = new Array();
      
      public var starterPackData:BMStarterPackData = new BMStarterPackData();
      
      public var postMythicalStarterPackData:BMStarterPackData = new BMStarterPackData();
      
      public var nukes:uint = 0;
      
      public var freeItemBoxes:uint = 0;
      
      public var gotFreeItemBox:Number = 0;
      
      public var tokensBought:Number = 0;
      
      public var inventorySizeState:InventorySizeState = new InventorySizeState();
      
      public var totalDamageDealt:Number = 0;
      
      public var dailyLoginStreak:Number = 0;
      
      public var lastDevice:String = "";
      
      public var userID:Number = 0;
      
      public var facebook:Boolean = false;
      
      public var avatarLink:String = "";
      
      public var newItemsPurchased:Array = new Array();
      
      public var expandedInventorySortingMessageDisplayed:Boolean = false;
      
      public var allowBattleChatMessages:Boolean = true;
      
      public var dRegistration:String;
      
      private var _levelUpData:BMLevelUpData;
      
      public var lastSelectedMechsPerBattle:uint = 1;
      
      public var lastSelectedMissionSlot:Array = new Array();
      
      public var lastSelectedMissionMode:Array = new Array();
      
      public var didOptInToBeta:Boolean = false;
      
      private var _nextMissionBonus:int = 0;
      
      public function BMPlayerProfile()
      {
         super();
         this.initialize();
      }
      
      public function get gold() : int
      {
         return this._gold.value;
      }
      
      public function set gold(param1:int) : void
      {
         this._gold.value = param1;
      }
      
      public function get tokens() : int
      {
         return this._tokens.value;
      }
      
      public function set tokens(param1:int) : void
      {
         this._tokens.value = param1;
      }
      
      public function get tokens_supporter() : int
      {
         return this._tokens_supporter.value;
      }
      
      public function set tokens_supporter(param1:int) : void
      {
         this._tokens_supporter.value = param1;
      }
      
      public function get tokens_bonus() : int
      {
         return this._tokens_bonus.value;
      }
      
      public function set tokens_bonus(param1:int) : void
      {
         this._tokens_bonus.value = param1;
      }
      
      public function get XP() : int
      {
         return this._XP.value;
      }
      
      public function set XP(param1:int) : void
      {
         if(this.maxXPAllowed > 0 && param1 > this.maxXPAllowed)
         {
            param1 = this.maxXPAllowed;
         }
         this._XP.value = param1;
      }
      
      public function get level() : int
      {
         return this._level.value;
      }
      
      public function set level(param1:int) : void
      {
         this._level.value = param1;
      }
      
      public function get lastLevel() : int
      {
         return this._lastLevel.value;
      }
      
      public function set lastLevel(param1:int) : void
      {
         this._lastLevel.value = param1;
      }
      
      public function get maxXPAllowed() : int
      {
         return dataM.getGeneralSetting("maxXPAllowed",-1);
      }
      
      private function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function updateWinsTotal() : void
      {
         this.winsTotal = this.winsVSComputer + this.onlineWins;
      }
      
      public function initClanBossData(param1:Object, param2:Object = null) : void
      {
         if(param1 == null && param2 == null)
         {
            this.clanBossData = null;
            return;
         }
         if(param1 != null)
         {
            this.clanBossData = new BMClanBossData(param1);
         }
         else
         {
            this.clanBossData = new BMClanBossData(param2);
         }
      }
      
      public function get hasClanBoss() : Boolean
      {
         if(dataM.clanBossEnabled == false)
         {
            return false;
         }
         if(this.clanID == 0)
         {
            return false;
         }
         if(this.clanBossData == null)
         {
            return false;
         }
         if(this.clanBossDataEndDate <= dataM.currentTime)
         {
            return false;
         }
         return true;
      }
      
      public function get isInClan() : Boolean
      {
         return this.clanID > 0;
      }
      
      public function get hasClanBossPreview() : Boolean
      {
         if(dataM.clanBossEnabled == false)
         {
            return false;
         }
         if(this.clanID > 0)
         {
            return false;
         }
         if(this.clanBossData == null)
         {
            return false;
         }
         var _loc1_:int = int(dataM.getGeneralSetting("clanBossOnboardingMinXPLevel",999));
         if(this.level < _loc1_)
         {
            return false;
         }
         return true;
      }
      
      public function get isClanBossAlive() : Boolean
      {
         if(this.isInClan == false)
         {
            return true;
         }
         if(this.clan_bossHP > 0)
         {
            return true;
         }
         return false;
      }
      
      public function get clanHasEnoughBossTickets() : Boolean
      {
         if(this.clanID == 0)
         {
            throw Error("bmPlayerProfile clanHasEnoughBossTickets error: player not in a clan");
         }
         if(this.hasClanBoss == false)
         {
            throw Error("bmPlayerProfile clanHasEnoughBossTickets error: boss not available");
         }
         return this.clanBossTickets >= this.clanBossData.ticketsRequired;
      }
      
      public function get isClanBossCollectingTicketsPhase() : Boolean
      {
         if(this.clanID == 0)
         {
            return false;
         }
         if(this.hasClanBoss == false)
         {
            return false;
         }
         if(this.isClanBossActive == false)
         {
            return false;
         }
         if(this.clanHasEnoughBossTickets)
         {
            return false;
         }
         return true;
      }
      
      public function get clanBossDataEndDate() : uint
      {
         return this.clanBossActiveTimeLeft + dataM.currentTime;
      }
      
      public function get clanBossInactiveTimeLeft() : uint
      {
         if(this.clanBossActiveTimeLeft > 0)
         {
            return 0;
         }
         var _loc1_:uint = dataM.clanBossInactiveDays - (dataM.clanBossCurrentDay - (dataM.clanBossStartDay + dataM.clanBossActiveDays - 1));
         return _loc1_ * 86400 + dataM.questsManager.dailyQuestsSecLeft;
      }
      
      public function get clanBossTimeLeft() : uint
      {
         return Math.max(0,this.clanBossDataEndDate - dataM.currentTime);
      }
      
      public function get clanBossTickets() : uint
      {
         return this.clan_bossTickets;
      }
      
      public function get clanBossHP() : uint
      {
         if(this.isInClan == false)
         {
            return this.clanBossData.hpMax;
         }
         return this.clan_bossHP;
      }
      
      public function get clan_bossBattlesLeft() : uint
      {
         return dataM.clanBossBattlesMax - this.clan_bossBattlesDoneToday;
      }
      
      public function get isClanBossLastActiveDay() : Boolean
      {
         return dataM.clanBossCurrentDay - dataM.clanBossStartDay == dataM.clanBossActiveDays - 1;
      }
      
      public function get isClanBossLastInactiveDay() : Boolean
      {
         return dataM.clanBossCurrentDay - dataM.clanBossStartDay == dataM.clanBossActiveDays + dataM.clanBossInactiveDays - 1;
      }
      
      public function get clanBossActiveTimeLeft() : uint
      {
         if(this.isClanBossActive == false)
         {
            return 0;
         }
         return uint(dataM.questsManager.dailyQuestsSecLeft + this.clanBossActiveFullDaysLeft * 86400);
      }
      
      public function get clanBossActiveFullDaysLeft() : uint
      {
         if(this.isClanBossActive == false)
         {
            return 0;
         }
         return dataM.clanBossActiveDays - 1 - (dataM.clanBossCurrentDay - dataM.clanBossStartDay);
      }
      
      public function get isClanBossActive() : Boolean
      {
         return dataM.clanBossCurrentDay - dataM.clanBossStartDay < dataM.clanBossActiveDays;
      }
      
      public function get hasClanBossReward() : Boolean
      {
         if(this.clanID == 0)
         {
            return false;
         }
         return this.clan_bossCoinsToCollect > 0;
      }
      
      public function clan_collectBossCoins() : void
      {
         this.clanCoins += this.clan_bossCoinsToCollect;
         var _loc1_:Number = Number(dataM.getGeneralSetting("clanBossCoinsToGoldRewardMultiplier","0"));
         if(_loc1_ > 0)
         {
            this.gold += this.clan_bossCoinsToCollect * _loc1_;
         }
         this.clan_bossCoinsToCollect = 0;
      }
      
      public function createStarterPackDataOverride(param1:String, param2:Number, param3:Number, param4:uint, param5:uint) : void
      {
         var _loc23_:uint = 0;
         var _loc24_:BMTokenPackage = null;
         var _loc25_:uint = 0;
         var _loc26_:BMGachaMachineData = null;
         var _loc27_:Array = null;
         var _loc6_:BMStarterPackData = new BMStarterPackData();
         var _loc7_:uint = BMStarterPackData.GAME_OF_WHALES_OFFER_PACK_ID;
         var _loc8_:uint = param5;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:String = "";
         var _loc15_:uint = 0;
         var _loc16_:uint = param4;
         var _loc17_:String = "";
         var _loc18_:uint = 0;
         var _loc19_:uint = BMStarterPackData.PRICE_TYPE_MONEY;
         var _loc20_:String = "tokens";
         var _loc21_:String = "buyGacha";
         var _loc22_:Boolean = false;
         if(param1.indexOf(_loc20_) > -1)
         {
            _loc23_ = uint(int(param1.substr(_loc20_.length,param1.length - _loc20_.length)));
            for each(_loc24_ in dataM.allTokenPackages)
            {
               if(_loc24_.tokens == _loc23_)
               {
                  if(_loc24_.starterPackID == 0)
                  {
                     _loc17_ = _loc24_.price;
                     _loc18_ = _loc24_.packageID;
                     _loc12_ = Math.ceil(_loc23_ * param3);
                     _loc22_ = true;
                     break;
                  }
               }
            }
         }
         else if(param1.indexOf(_loc21_) > -1)
         {
            _loc25_ = uint(int(param1.substr(_loc21_.length,param1.length - _loc21_.length)));
            for each(_loc26_ in dataM.gachaMachinesDB)
            {
               if(_loc26_.gachaMachineID == _loc25_)
               {
                  _loc27_ = [2,5];
                  if(_loc27_.indexOf(_loc25_) != -1)
                  {
                     _loc9_ = _loc25_;
                     _loc10_ = 1;
                     _loc19_ = BMStarterPackData.PRICE_TYPE_TOKENS;
                     _loc17_ = String(Math.ceil(_loc26_.costTokens * param2));
                     _loc22_ = true;
                     break;
                  }
               }
            }
         }
         if(_loc22_ == false)
         {
            TsLogger.log("Warning: could not create GameOfWhales for " + param1);
            return;
         }
         if(param4 > dataM.currentTime || param4 + _loc8_ < dataM.currentTime)
         {
            TsLogger.log("Warning: could not create GameOfWhales offer because it is not scheduled properly");
            return;
         }
         _loc6_.initialize_noItems(_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_);
         _loc6_.priceType = _loc19_;
         _loc6_.tokenPackageID = _loc18_;
         this.starterPackData = _loc6_;
      }
      
      public function setStarterPackData(param1:Object) : void
      {
         if(this.starterPackData != null)
         {
            if(this.starterPackData.isGameOfWhalesOffer)
            {
               TsLogger.log("GOW Starter pack already exists, ignoring SM starter pack");
               return;
            }
         }
         this.starterPackData = new BMStarterPackData();
         this.parseStarterPackData(param1,this.starterPackData);
      }
      
      public function setPostMythicalStarterPackData(param1:Object) : void
      {
         this.postMythicalStarterPackData = new BMStarterPackData();
         this.parseStarterPackData(param1,this.postMythicalStarterPackData);
      }
      
      private function parseStarterPackData(param1:Object, param2:BMStarterPackData) : void
      {
         this.starterPackData.initialize(param1.packID,param1.offerDuration,param1.boostID,param1.boostAmount,param1.mechColorID,param1.torso,param1.leg,param1.sideWeapon1,param1.sideWeapon2,param1.sideWeapon3,param1.sideWeapon4,param1.topWeapon1,param1.topWeapon2,param1.module1,param1.module2,param1.module3,param1.module4,param1.module5,param1.module6,param1.module7,param1.module8,param1.drone,param1.teleport,param1.charge,param1.harpoon,param1.perk,param1.bonusGold,param1.bonusTokens,param1.skin,param1.vipDays,param1.extraValue,param1.starterPackStatus,param1.starterPackStartDate,"",param1.isBundle,param1.battleCredits,param1.clanCoins,param1.arenaCoins,param1.nukes,param1.module1Multiplier,param1.module2Multiplier,param1.module3Multiplier,param1.module4Multiplier,param1.module5Multiplier,param1.module6Multiplier,param1.module7Multiplier,param1.module8Multiplier);
      }
      
      public function applyDurabilityChanges(param1:Array) : void
      {
      }
      
      public function setChainDiscountsStatus(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerChainDiscountStatus = null;
         this.chainDiscountsStatus = new Array();
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            _loc3_ = uint(_loc2_.gachaMachineID);
            _loc4_ = uint(_loc2_.startDate);
            _loc5_ = uint(_loc2_.purchases);
            _loc6_ = new BMPlayerChainDiscountStatus(_loc3_,_loc4_,_loc5_);
            this.chainDiscountsStatus.push(_loc6_);
         }
      }
      
      public function addNewChainDiscountStatus(param1:uint) : void
      {
         var _loc2_:uint = dataM.currentTime - 2;
         var _loc3_:uint = 1;
         var _loc4_:BMPlayerChainDiscountStatus = new BMPlayerChainDiscountStatus(param1,_loc2_,_loc3_);
         this.chainDiscountsStatus.push(_loc4_);
      }
      
      public function removeChainDiscountStatus(param1:uint) : void
      {
         var _loc3_:BMPlayerChainDiscountStatus = null;
         if(this.chainDiscountsStatus.length == 0)
         {
            return;
         }
         var _loc2_:* = int(this.chainDiscountsStatus.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.chainDiscountsStatus[_loc2_];
            if(_loc3_.gachaMachineID == param1)
            {
               this.chainDiscountsStatus.splice(_loc2_,1);
            }
            _loc2_--;
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
      
      public function addFreePackages(param1:Vector.<uint>) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.freePackages.push(param1[_loc2_]);
            _loc2_++;
         }
         BMPubSub.pub(BMPubSub.MESSAGE_FREE_PACKAGES_UPDATED,this.freePackages);
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
         BMPubSub.pub(BMPubSub.MESSAGE_FREE_PACKAGES_UPDATED,this.freePackages);
      }
      
      public function updateClanData(param1:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc6_:BMClanMemberData = null;
         this.clanID = param1.clanID;
         this.clanData = new BMClanData();
         this.clanData.SetData(param1);
         this.clan_arenaPoints = param1.rankedValue;
         this.clan_joinType = param1.joinType;
         this.clan_requiredRankToJoin = param1.requiredRankToJoin;
         if(param1.bossData != null)
         {
            this.initClanBossData(param1.bossData);
         }
         var _loc2_:uint = this.clan_bossTickets;
         this.clan_bossTickets = param1.bossTickets;
         if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
         {
            if(_loc2_ > 0 && _loc2_ < this.clanBossData.ticketsRequired && this.clan_bossTickets >= this.clanBossData.ticketsRequired)
            {
               screensM.screenConfirmation.displayCustomMessage(getSpecificText("clanBoss_enoughTicketsCollected"));
            }
         }
         var _loc3_:uint = this.clan_bossHP;
         this.clan_bossHP = Math.max(0,param1.bossHP);
         if(_loc3_ > 0 && this.clan_bossHP == 0)
         {
            screensM.screenConfirmation.displayCustomMessage(getSpecificText("clanBoss_bossDefeated"));
         }
         var _loc5_:Object = new Object();
         if(param1.onlineMembers != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.onlineMembers.length)
            {
               _loc5_[param1.onlineMembers[_loc4_]] = true;
               _loc4_++;
            }
         }
         for each(_loc6_ in this.clanData.members)
         {
            if(_loc5_[_loc6_.playerID] != null)
            {
               _loc6_.isOnline = true;
            }
         }
      }
      
      public function get clanName() : String
      {
         if(this.clanID == 0)
         {
            return "";
         }
         return this.clanData.name;
      }
      
      public function get leaderName() : String
      {
         if(this.clanID == 0)
         {
            return "";
         }
         var _loc1_:BMClanMemberData = this.getClanMemberByPlayerID(this.clanLeaderID);
         return _loc1_.name;
      }
      
      public function get clanFlag() : String
      {
         if(this.clanID == 0)
         {
            return "";
         }
         return this.clanData.flag;
      }
      
      public function get clanLeaderID() : uint
      {
         if(this.clanID == 0)
         {
            return 0;
         }
         return this.clanData.leaderID;
      }
      
      public function get clanLadderProgress() : uint
      {
         if(this.clanID == 0)
         {
            return 0;
         }
         return this.clanData.ladderProgress;
      }
      
      public function get clanMembers() : int
      {
         if(this.clanID == 0)
         {
            return 0;
         }
         return this.clanData.members.length;
      }
      
      public function get clanLadderBattles() : int
      {
         if(this.clanID == 0)
         {
            return 0;
         }
         return this.clanData.ladderBattles;
      }
      
      public function get clanLadderWins() : int
      {
         if(this.clanID == 0)
         {
            return 0;
         }
         return this.clanData.ladderWins;
      }
      
      public function getClanMemberByPlayerID(param1:uint) : BMClanMemberData
      {
         var _loc3_:BMClanMemberData = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.clanMembers)
         {
            _loc3_ = this.clanData.members[_loc2_];
            if(_loc3_.playerID == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function updateMemberOnlineStatus(param1:Number, param2:Boolean) : void
      {
         var _loc4_:BMClanMemberData = null;
         var _loc3_:uint = 0;
         while(_loc3_ < this.clanMembers)
         {
            _loc4_ = this.clanData.members[_loc3_];
            if(_loc4_.playerID == param1)
            {
               _loc4_.isOnline = param2;
               _loc3_ = uint(this.clanMembers);
            }
            _loc3_++;
         }
      }
      
      public function get isClanLeader() : Boolean
      {
         return this.clanLeaderID == dataM.userID && this.playerID == dataM.ONLINE_PLAYER_ID;
      }
      
      public function updateMissionData(param1:BMMissionServerToClientStats) : void
      {
         this.missionID = param1.missionID;
         this.mission_layout = param1.layout;
         this.mission_startingPosition = param1.playerPosition;
         this.mission_playerPosition = param1.playerPosition;
         this.mission_themeID = param1.themeID;
         this.mission_flag = param1.flag;
         this.mission_rows = param1.rows;
         this.mission_columns = param1.columns;
         this.mission_progress = param1.progress;
         this.mission_gold = param1.gold;
         this.mission_xp = param1.xp;
         this.mission_difficulty = param1.difficulty;
         this.mission_upgrades = param1.upgrades;
         this.mission_loot = new Array();
         this.mission_computerItems = new Object();
         this.mission_mode = param1.mode;
         this.mission_mechStats = param1.mechsStats;
         this._currentMissionMode = param1.mode;
      }
      
      public function get missionCurrentMechStats() : BMMissionMechStats
      {
         return this.mission_mechStats[this.missionCurrentMechID - 1];
      }
      
      public function missionMechsAlive() : uint
      {
         var _loc3_:BMMissionMechStats = null;
         var _loc1_:uint = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= this.mission_mechStats.length)
         {
            _loc3_ = this.mission_mechStats[_loc2_ - 1];
            if(_loc3_.hp > 0)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getMissionLiveMechID() : uint
      {
         var _loc2_:BMMissionMechStats = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= this.mission_mechStats.length)
         {
            _loc2_ = this.mission_mechStats[_loc1_ - 1];
            if(_loc2_.hp > 0)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 1;
      }
      
      public function clearMissionData() : void
      {
         this.missionID = 0;
         this.mission_layout = "";
         this.mission_mechStats = new Array();
         this.mission_startingPosition = 0;
         this.mission_playerPosition = 0;
         this.mission_themeID = 0;
         this.mission_flag = "";
         this.mission_rows = 0;
         this.mission_columns = 0;
         this.mission_progress = new Array();
         this.mission_loot = new Array();
         this.mission_colorID = 0;
         this.mission_startPositions = new Array();
         this.mission_computerItems = new Object();
         this.mission_damagedEnemies = new Array();
         this._nextMissionBonus = MISSION_BONUS_NONE;
      }
      
      public function setMapProgress(param1:uint, param2:String, param3:int = 0) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         if(param2 == null)
         {
            return;
         }
         var _loc4_:Array = this.getMapProgress(param1,param3);
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            if(_loc5_ < dataM.singlePlayerM.getMissionsDB(param1).length)
            {
               _loc6_ = param2.substr(_loc5_,1);
               _loc4_.push(_loc6_);
            }
            _loc5_++;
         }
         if(_loc4_.length == 0)
         {
            return;
         }
         _loc5_ = _loc4_.length - 1;
         while(_loc5_ >= 0)
         {
            if(_loc4_[_loc5_] == BMSinglePlayerManager.MAP_PROGRESS_INCOMPLETE)
            {
               _loc4_.splice(_loc5_,1);
            }
            else
            {
               _loc5_ = -1;
            }
            _loc5_--;
         }
      }
      
      public function setDungeonsProgress(param1:Object) : void
      {
         this.dungeonProgress = new Object();
         this.dungeonProgress[BMSinglePlayerManager.STORY_ID_DUNGEON] = param1;
      }
      
      public function getLastSelectedMissionSlot(param1:uint) : int
      {
         if(this.lastSelectedMissionSlot[param1] == null)
         {
            return -1;
         }
         return this.lastSelectedMissionSlot[param1];
      }
      
      public function getLastMissionMode(param1:uint, param2:uint) : int
      {
         if(this.lastSelectedMissionMode[param1] == null)
         {
            return 0;
         }
         if(this.lastSelectedMissionMode[param1][param2] == null)
         {
            return 0;
         }
         return this.lastSelectedMissionMode[param1][param2];
      }
      
      public function setLastSelectedMissionSlotAndMode(param1:uint, param2:uint, param3:uint) : void
      {
         this.lastSelectedMissionSlot[param1] = param2;
         if(this.lastSelectedMissionMode[param1] == null)
         {
            this.lastSelectedMissionMode[param1] = new Array();
         }
         if(param2 != BMSinglePlayerManager.CLAN_BOSS_MISSION_SLOT)
         {
            this.lastSelectedMissionMode[param1][param2] = param3;
         }
      }
      
      public function removeFromTokens(param1:uint) : void
      {
         this.tokens -= param1;
         if(this.tokens_bonus >= param1)
         {
            this.tokens_bonus -= param1;
         }
         else
         {
            param1 -= this.tokens_bonus;
            this.tokens_bonus = 0;
            this.tokens_supporter -= param1;
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
      
      public function setBattleCredits(param1:int, param2:String = null) : *
      {
         this.battleCredits = param1;
         if(param1 == 0 && param2 != null)
         {
            dataM.trackEvent(BMDataManager.ANALYTICS_PRIORITY_HIGHEST,"BattleCredits","Depleted",param2);
         }
      }
      
      public function getMapProgress(param1:uint, param2:int) : Array
      {
         switch(param1)
         {
            case BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1:
               switch(param2)
               {
                  case 0:
                     return this.mapProgress;
                  case 1:
                     return this.mapProgressHard;
                  case 2:
                     return this.mapProgressInsane;
               }
               break;
            case BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2:
               switch(param2)
               {
                  case 0:
                     return this.mapProgress1Normal;
                  case 1:
                     return this.mapProgress1Hard;
                  case 2:
                     return this.mapProgress1Insane;
               }
               break;
            case BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3:
               switch(param2)
               {
                  case 0:
                     return this.mapProgress3Normal;
                  case 1:
                     return this.mapProgress3Hard;
                  case 2:
                     return this.mapProgress3Insane;
               }
         }
         throw new Error("Invalid storyID or mode sent to getMapProgress");
      }
      
      public function getNormalMapProgress(param1:uint) : Array
      {
         switch(param1)
         {
            case BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1:
               return this.mapProgress;
            case BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2:
               return this.mapProgress1Normal;
            case BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3:
               return this.mapProgress3Normal;
            default:
               throw new Error("Invalid storyID sent to getNormalMapProgress");
         }
      }
      
      public function updateCurrentMissionProgress(param1:uint, param2:String) : void
      {
         if(this._currentMissionSlot == -1)
         {
            return;
         }
         this.updateMissionProgress(param1,this.currentMissionSlot,param2,this.currentMissionMode);
      }
      
      public function updateMissionProgress(param1:uint, param2:int, param3:String, param4:int) : void
      {
         var _loc5_:BMWorldMapLocationData = dataM.singlePlayerM.getSpecificMissionDB(param1,param2);
         if(_loc5_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_DUNGEON)
         {
            this.dungeonProgress[param1][_loc5_.locationID + "_" + param4] = param3;
            return;
         }
         var _loc6_:Array = this.getMapProgress(param1,param4);
         var _loc7_:String = _loc6_[param2];
         _loc6_[param2] = param3;
         if(_loc7_ == BMSinglePlayerManager.MAP_PROGRESS_IN_PROGRESS && param3 == BMSinglePlayerManager.MAP_PROGRESS_COMPLETE)
         {
            if(_loc5_.isLastBossMission())
            {
               this.showEpilogueForMode = param4;
            }
         }
      }
      
      public function getDungeonProgress(param1:uint, param2:int, param3:int) : String
      {
         var _loc4_:String = param2 + "_" + param3;
         if(this.dungeonProgress[param1].hasOwnProperty(_loc4_))
         {
            return this.dungeonProgress[param1][_loc4_];
         }
         return "";
      }
      
      public function getCurrentMissionProgress(param1:uint) : String
      {
         if(this._currentMissionSlot == -1)
         {
            return "";
         }
         var _loc2_:BMWorldMapLocationData = dataM.singlePlayerM.getSpecificMissionDB(param1,this._currentMissionSlot);
         if(_loc2_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_DUNGEON)
         {
            return this.getDungeonProgress(param1,_loc2_.locationID,this._currentMissionMode);
         }
         return this.getMapProgress(param1,this._currentMissionMode)[this._currentMissionSlot];
      }
      
      public function get hasPandingLevelUp() : Boolean
      {
         return this.levelUpData != null && this.levelUpData.hasContent();
      }
      
      public function set levelUpData(param1:BMLevelUpData) : *
      {
         this._levelUpData = param1;
      }
      
      public function get levelUpData() : BMLevelUpData
      {
         return this._levelUpData;
      }
      
      public function get nextMissionBonus() : int
      {
         return this._nextMissionBonus;
      }
      
      public function set nextMissionBonus(param1:int) : void
      {
         this._nextMissionBonus = param1;
      }
      
      public function getCurrentMission(param1:uint = 0) : BMWorldMapLocationData
      {
         return dataM.singlePlayerM.getSpecificMissionDB(param1,this._currentMissionSlot);
      }
      
      public function get currentMissionSlot() : int
      {
         return this._currentMissionSlot;
      }
      
      public function setCurrentMissionSlot(param1:int) : void
      {
         this._currentMissionSlot = param1;
      }
      
      public function get currentMissionMode() : uint
      {
         return this._currentMissionMode;
      }
      
      public function setCurrentMissionMode(param1:uint) : void
      {
         this._currentMissionMode = param1;
      }
      
      public function resetMissionSlotAndMode() : void
      {
         this._currentMissionSlot = -1;
         this._currentMissionMode = 0;
      }
   }
}

