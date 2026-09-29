package net.battleMechsMulti.managers.clanWars
{
   import net.battleMechsMulti.data.BMClanData;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.ClanWarAttackData;
   import net.battleMechsMulti.data.ClanWarLastWarInfo;
   import net.battleMechsMulti.data.ClanWarPlayerData;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMClanWarsManager
   {
      
      public static const WAR_PHASE_PREPARATION:uint = 0;
      
      public static const WAR_PHASE_ROUND1:uint = 1;
      
      public static const WAR_PHASE_ROUND2:uint = 2;
      
      public static const ALIGNMENT_ENEMY_CLAN:String = "enemyClan";
      
      public static const ALIGNMENT_MY_CLAN:String = "myClan";
      
      private var _myClanPlayersData:Vector.<ClanWarPlayerData>;
      
      private var _enemyClanPlayersData:Vector.<ClanWarPlayerData>;
      
      private var _attacksByDefenderIDs:Object;
      
      private var _warPhase:uint;
      
      private var _lastClanWarInfo:ClanWarLastWarInfo;
      
      private var _playerJoinedEra:int;
      
      private var _playerJoinedBuilds:Vector.<String>;
      
      private var _clanWarData:Object;
      
      private var _lastClanWarData:Object;
      
      private var _currentOpponentPlayerID:uint;
      
      private var _didQuitAClanThisSession:Boolean = false;
      
      private var p_defenceTeamChanged:Boolean = false;
      
      private var p_pendingReward:BMRewardData;
      
      private var p_battleResultMessage:Array;
      
      public function BMClanWarsManager()
      {
         super();
      }
      
      public function getPlayerData(param1:uint, param2:String = "myClan") : ClanWarPlayerData
      {
         var _loc4_:ClanWarPlayerData = null;
         var _loc3_:Vector.<ClanWarPlayerData> = this._myClanPlayersData;
         if(param2 == ALIGNMENT_ENEMY_CLAN)
         {
            _loc3_ = this._enemyClanPlayersData;
         }
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.playerID == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getTeam(param1:uint, param2:String = "myClan") : Vector.<BMMechStructure>
      {
         var _loc3_:ClanWarPlayerData = this.getPlayerData(param1,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.mechStructures;
      }
      
      public function GetTotalMechsInTeam(param1:uint, param2:String = "myClan") : uint
      {
         var _loc5_:BMMechStructure = null;
         var _loc3_:Vector.<BMMechStructure> = this.getTeam(param1,param2);
         if(_loc3_ == null)
         {
            return 0;
         }
         var _loc4_:uint = 0;
         for each(_loc5_ in _loc3_)
         {
            if(this.dataM.isMechStructureReadyForBattle(_loc5_))
            {
               _loc4_++;
            }
         }
         return _loc4_;
      }
      
      public function get themeID() : uint
      {
         return 3;
      }
      
      public function get enemyClanData() : BMClanData
      {
         var _loc1_:BMClanData = new BMClanData();
         var _loc2_:Object = new Object();
         _loc2_.clanID = this._clanWarData.enemyInfo.id;
         _loc2_.flag = this._clanWarData.enemyInfo.flag;
         _loc2_.name = this._clanWarData.enemyInfo.name;
         _loc2_.leaderID = this._clanWarData.enemyInfo.leaderID;
         _loc2_.leaderName = this._clanWarData.enemyInfo.leaderName;
         _loc2_.ladderProgress = this._clanWarData.enemyInfo.ladderProgress;
         _loc2_.membersList = new Array();
         _loc1_.SetData(_loc2_);
         return _loc1_;
      }
      
      public function didIFightPlayer(param1:uint) : Boolean
      {
         var _loc3_:ClanWarAttackData = null;
         if(this._attacksByDefenderIDs[param1] == null)
         {
            return false;
         }
         var _loc2_:Array = this._attacksByDefenderIDs[param1];
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.attackerPlayerID == this.dataM.myProfile.playerID)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setClanWarData(param1:Object, param2:Object) : *
      {
         this._playerJoinedEra = param1.joinedEra;
         this._clanWarData = param1;
         this._lastClanWarData = param2;
      }
      
      public function playerLeftClan() : void
      {
         this._didQuitAClanThisSession = true;
         this._myClanPlayersData = null;
         this._enemyClanPlayersData = null;
         this._lastClanWarInfo = null;
         this._clanWarData = null;
         this._lastClanWarData = null;
      }
      
      public function get didIJoin() : Boolean
      {
         var _loc1_:int = this.dataM.getGeneralSetting("currentClanWarID",-1);
         if(_loc1_ == -1)
         {
            return false;
         }
         if(_loc1_ != this._playerJoinedEra)
         {
            return false;
         }
         return true;
      }
      
      public function getPhaseSecLeft() : uint
      {
         var _loc1_:uint = uint(this.dataM.questsManager.dailyQuestsSecLeft);
         if(this.currentDayOfWeek == 7)
         {
            return _loc1_;
         }
         var _loc2_:uint = this.currentDayOfWeek + 1;
         while(_loc2_ <= 7)
         {
            if(this.getPhaseByDay(_loc2_) != this.currentPhase)
            {
               return _loc1_;
            }
            _loc1_ += 86400;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getNextWarStartSecLeft() : uint
      {
         var _loc1_:uint = this.getPhaseSecLeft();
         if(this.isPreparationPhase)
         {
            _loc1_ += 86400 * 4;
         }
         else if(this.currentPhase == WAR_PHASE_ROUND1)
         {
            _loc1_ += 86400 * 2;
         }
         return _loc1_;
      }
      
      public function get currentPhase() : uint
      {
         return this.getPhaseByDay(this.currentDayOfWeek);
      }
      
      public function get isWarPhase() : Boolean
      {
         return this.currentPhase != WAR_PHASE_PREPARATION;
      }
      
      public function get isPreparationPhase() : Boolean
      {
         return this.currentPhase == WAR_PHASE_PREPARATION;
      }
      
      public function get isFeatureEnabled() : Boolean
      {
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return false;
         }
         if(int(this.dataM.getGeneralSetting("clanWarsEnabled","0")) == 0)
         {
            return false;
         }
         return this.dataM.getGeneralSetting("clanWarsData",null) != null;
      }
      
      public function get didMyClanFailToFindOpponent() : Boolean
      {
         if(this.isWarPhase == false)
         {
            return false;
         }
         if(this._clanWarData == null)
         {
            return true;
         }
         if(this._clanWarData.enemyInfo == null)
         {
            return true;
         }
         return false;
      }
      
      private function get clanWarsData() : Object
      {
         var _loc1_:String = this.dataM.getGeneralSetting("clanWarsData",null);
         if(_loc1_ == null)
         {
            throw Error("clanWarsData is null");
         }
         return JSON.parse(_loc1_);
      }
      
      private function getPhaseByDay(param1:uint) : uint
      {
         return this.clanWarsData.daysToPhases[param1];
      }
      
      public function get currentDayOfWeek() : uint
      {
         return int(this.dataM.getGeneralSetting("currentClanWarDayOfWeek","0"));
      }
      
      public function get canJoinWar() : Boolean
      {
         return this.passedMinXPLevelToJoinAWar && this.dataM.areMechsReadyForBattle(3);
      }
      
      public function get passedMinXPLevelToJoinAWar() : Boolean
      {
         if(this.dataM.myProfile.level < int(this.dataM.getGeneralSetting("mechBuildsMinXPLevel","999")))
         {
            return false;
         }
         return true;
      }
      
      public function get firstRoundWinner() : String
      {
         var _loc1_:Number = this.getClanMaxScore(this._myClanPlayersData);
         var _loc2_:Number = this.getClanMaxScore(this._enemyClanPlayersData);
         var _loc3_:Number = this.getRound1ClanScore(this._clanWarData.teams);
         var _loc4_:Number = this.getRound1ClanScore(this._clanWarData.enemyTeams);
         var _loc5_:Number = _loc3_ / _loc2_;
         var _loc6_:Number = _loc4_ / _loc1_;
         if(_loc5_ > _loc6_)
         {
            return ALIGNMENT_MY_CLAN;
         }
         return ALIGNMENT_ENEMY_CLAN;
      }
      
      private function getRound1ClanScore(param1:Object) : Number
      {
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         var _loc2_:Boolean = false;
         if(this.currentPhase == WAR_PHASE_ROUND1 || this.currentPhase == WAR_PHASE_ROUND2)
         {
            if(this._clanWarData.attacksData != null)
            {
               if(this._clanWarData.attacksData[WAR_PHASE_ROUND1 - 1] != null)
               {
                  _loc2_ = true;
               }
            }
         }
         var _loc3_:Object = new Object();
         for each(_loc4_ in param1)
         {
            _loc7_ = null;
            if(_loc2_)
            {
               _loc7_ = this._clanWarData.attacksData[WAR_PHASE_ROUND1 - 1][String(_loc4_.playerID)];
               if(_loc7_ != null)
               {
                  for(_loc8_ in _loc7_[1])
                  {
                     _loc9_ = Number(_loc7_[1][_loc8_]);
                     if(_loc3_[_loc8_] == null)
                     {
                        _loc3_[_loc8_] = 0;
                     }
                     if(_loc9_ > _loc3_[_loc8_])
                     {
                        _loc3_[_loc8_] = _loc9_;
                     }
                  }
               }
            }
         }
         _loc5_ = 0;
         for each(_loc6_ in _loc3_)
         {
            _loc5_ += _loc6_;
         }
         return _loc5_;
      }
      
      public function get defenceTeamChanged() : Boolean
      {
         return this.p_defenceTeamChanged;
      }
      
      public function set defenceTeamChanged(param1:Boolean) : void
      {
         this.p_defenceTeamChanged = param1;
      }
      
      private function getGachaIDByPrizeTier(param1:String) : uint
      {
         if(param1 == "S+")
         {
            return 905;
         }
         if(param1 == "S")
         {
            return 904;
         }
         if(param1 == "A")
         {
            return 903;
         }
         if(param1 == "B")
         {
            return 902;
         }
         if(param1 == "C")
         {
            return 901;
         }
         return 900;
      }
      
      private function getWinPrizeTierByDefaultTier(param1:String) : String
      {
         if(param1 == "S")
         {
            return "S+";
         }
         if(param1 == "A")
         {
            return "S";
         }
         if(param1 == "B")
         {
            return "A";
         }
         if(param1 == "C")
         {
            return "B";
         }
         return "C";
      }
      
      private function get defaultPrizeClanCoins() : uint
      {
         return this.myScore * this.clanWarsData.rewards.scoreToClanCoinsRatio;
      }
      
      public function get myPredictedLoseReward() : BMRewardData
      {
         var _loc1_:String = "D";
         if(this._clanWarData.prizeTier != null)
         {
            _loc1_ = this._clanWarData.prizeTier;
         }
         var _loc2_:uint = this.getGachaIDByPrizeTier(_loc1_);
         return new BMRewardData({
            "boxes":[_loc2_],
            "clanCoins":this.defaultPrizeClanCoins
         });
      }
      
      public function get myPredictedWinReward() : BMRewardData
      {
         var _loc1_:String = "D";
         if(this._clanWarData.prizeTier != null)
         {
            _loc1_ = this._clanWarData.prizeTier;
         }
         var _loc2_:uint = this.getGachaIDByPrizeTier(this.getWinPrizeTierByDefaultTier(_loc1_));
         var _loc3_:uint = this.defaultPrizeClanCoins * 2;
         return new BMRewardData({
            "boxes":[_loc2_],
            "clanCoins":_loc3_
         });
      }
      
      public function get pendingReward() : BMRewardData
      {
         return this.p_pendingReward;
      }
      
      public function setPendingReward(param1:Object) : void
      {
         this.p_pendingReward = new BMRewardData(param1);
      }
      
      public function get hasPendingReward() : Boolean
      {
         return this.pendingReward != null;
      }
      
      public function rewardCollected() : void
      {
         this.dataM.handleGotRewardData(this.p_pendingReward,this.p_pendingReward.boxes[0]);
         this.p_pendingReward = null;
      }
      
      public function createClanPlayersData() : void
      {
         this.setLastClanWarData();
         if(this._clanWarData == null)
         {
            return;
         }
         this.createSpecificClanPlayersData(ALIGNMENT_MY_CLAN);
         if(this.isWarPhase)
         {
            this.createSpecificClanPlayersData(ALIGNMENT_ENEMY_CLAN);
         }
         this.setAndSortAttacksByDefenderIDs();
      }
      
      private function createSpecificClanPlayersData(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Array = null;
         var _loc9_:Object = null;
         var _loc10_:ClanWarPlayerData = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         if(this._clanWarData == null)
         {
            TsLogger.log("clanWarData was not set");
            return;
         }
         if(param1 == ALIGNMENT_MY_CLAN)
         {
            this._myClanPlayersData = new Vector.<ClanWarPlayerData>();
            _loc2_ = this._clanWarData.teams;
         }
         else
         {
            this._enemyClanPlayersData = new Vector.<ClanWarPlayerData>();
            _loc2_ = this._clanWarData.enemyTeams;
         }
         var _loc3_:Boolean = false;
         if(this.currentPhase == WAR_PHASE_ROUND1 || this.currentPhase == WAR_PHASE_ROUND2)
         {
            if(this._clanWarData.attacksData != null)
            {
               if(this._clanWarData.attacksData[this.currentPhase - 1] != null)
               {
                  _loc3_ = true;
               }
            }
         }
         for each(_loc4_ in _loc2_)
         {
            _loc5_ = new Array();
            _loc6_ = 1;
            while(_loc6_ <= 3)
            {
               _loc5_.push(_loc4_.teams[_loc6_ - 1].split("_"));
               _loc6_++;
            }
            _loc7_ = uint(_loc4_.maxAttacks);
            _loc8_ = new Array();
            _loc9_ = null;
            if(_loc3_)
            {
               _loc9_ = this._clanWarData.attacksData[this.currentPhase - 1][String(_loc4_.playerID)];
               if(_loc9_ != null)
               {
                  _loc7_ = uint(_loc9_[0]);
                  for(_loc11_ in _loc9_[1])
                  {
                     _loc12_ = _loc9_[1][_loc11_];
                     _loc8_.push(_loc11_ + "_" + _loc12_);
                  }
               }
            }
            _loc10_ = new ClanWarPlayerData(_loc4_.playerID,_loc4_.name,_loc4_.ladderProgress,_loc5_,_loc4_.skillsArray,_loc4_.maxAttacks,_loc7_,_loc8_,_loc4_.isFake);
            _loc10_.teamMaxScore = this.getTeamMaxScore(_loc10_.mechStructures);
            if(param1 == ALIGNMENT_MY_CLAN)
            {
               this._myClanPlayersData.push(_loc10_);
            }
            else
            {
               this._enemyClanPlayersData.push(_loc10_);
            }
         }
      }
      
      private function setAndSortAttacksByDefenderIDs() : void
      {
         var _loc1_:Array = null;
         this._attacksByDefenderIDs = new Object();
         this.setAttacksByDefenderIDsSub(this.myClanPlayersData);
         this.setAttacksByDefenderIDsSub(this.enemyClanPlayersData);
         for each(_loc1_ in this._attacksByDefenderIDs)
         {
            _loc1_.sortOn("score",Array.NUMERIC | Array.DESCENDING);
         }
      }
      
      private function setAttacksByDefenderIDsSub(param1:Vector.<ClanWarPlayerData>) : void
      {
         var _loc2_:ClanWarPlayerData = null;
         var _loc3_:uint = 0;
         var _loc4_:ClanWarAttackData = null;
         var _loc5_:ClanWarAttackData = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.attacks.length)
            {
               _loc4_ = _loc2_.attacks[_loc3_];
               if(this._attacksByDefenderIDs[_loc4_.defenderPlayerID] == null)
               {
                  this._attacksByDefenderIDs[_loc4_.defenderPlayerID] = new Array();
               }
               _loc5_ = new ClanWarAttackData(_loc4_.attackerPlayerID,_loc4_.defenderPlayerID,_loc4_.score);
               this._attacksByDefenderIDs[_loc4_.defenderPlayerID].push(_loc5_);
               _loc3_++;
            }
         }
      }
      
      public function getBestAttackInfoAgainstPlayer(param1:uint, param2:uint = 0) : ClanWarAttackData
      {
         var _loc4_:ClanWarAttackData = null;
         if(this._attacksByDefenderIDs[param1] == null)
         {
            return null;
         }
         if(param2 == 0)
         {
            return this._attacksByDefenderIDs[param1][0];
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this._attacksByDefenderIDs[param1].length)
         {
            _loc4_ = this._attacksByDefenderIDs[param1][_loc3_];
            if(_loc4_.attackerPlayerID == param2)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getAttackRecommendation() : Array
      {
         var _loc3_:ClanWarPlayerData = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:ClanWarAttackData = null;
         var _loc7_:uint = 0;
         var _loc8_:Object = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         for each(_loc3_ in this._enemyClanPlayersData)
         {
            _loc6_ = this.getBestAttackInfoAgainstPlayer(_loc3_.playerID);
            _loc7_ = _loc3_.teamPowerRating;
            _loc8_ = {
               "playerID":_loc3_.playerID,
               "powerRating":_loc7_
            };
            if(_loc6_ == null)
            {
               _loc1_.push(_loc8_);
            }
            else
            {
               _loc2_.push(_loc8_);
            }
         }
         _loc1_.sortOn("powerRating");
         _loc2_.sortOn("powerRating");
         _loc4_ = new Array();
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc4_.push(_loc1_[_loc5_].playerID);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_.push(_loc2_[_loc5_].playerID);
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function getClanPlayersData(param1:Boolean = true) : Vector.<ClanWarPlayerData>
      {
         if(param1)
         {
            return this.myClanPlayersData;
         }
         return this.enemyClanPlayersData;
      }
      
      public function get myClanPlayersData() : Vector.<ClanWarPlayerData>
      {
         return this._myClanPlayersData;
      }
      
      public function get enemyClanPlayersData() : Vector.<ClanWarPlayerData>
      {
         return this._enemyClanPlayersData;
      }
      
      public function set currentOpponentPlayerID(param1:uint) : void
      {
         this._currentOpponentPlayerID = param1;
      }
      
      public function get currentOpponentPlayerID() : uint
      {
         return this._currentOpponentPlayerID;
      }
      
      private function setLastClanWarData() : void
      {
         if(this._lastClanWarData == null)
         {
            return;
         }
         if(this._lastClanWarData.clan1Info.id != this.dataM.myProfile.clanID && this._lastClanWarData.clan2Info.id != this.dataM.myProfile.clanID)
         {
            return;
         }
         var _loc1_:uint = 1;
         var _loc2_:uint = 2;
         if(this._lastClanWarData.clan1Info.id != this.dataM.myProfile.clanID)
         {
            _loc1_ = 2;
            _loc2_ = 1;
         }
         var _loc3_:Object = this._lastClanWarData["clan" + _loc1_ + "Info"];
         var _loc4_:Object = this._lastClanWarData["clan" + _loc2_ + "Info"];
         this._lastClanWarInfo = new ClanWarLastWarInfo();
         this._lastClanWarInfo.available = true;
         this._lastClanWarInfo.enemyClanFlag = _loc4_.flag;
         this._lastClanWarInfo.enemyClanName = _loc4_.name;
         this._lastClanWarInfo.enemyClanLeaderName = _loc4_.leaderName;
         this._lastClanWarInfo.enemyClanLadderProgress = _loc4_.ladderProgress;
         this._lastClanWarInfo.myClanAttackScores = this._lastClanWarData.scores[_loc1_ - 1];
         this._lastClanWarInfo.myClanTeamsTotalScore = this._lastClanWarData.maxScores[_loc1_ - 1];
         this._lastClanWarInfo.enemyClanAttackScores = this._lastClanWarData.scores[_loc2_ - 1];
         this._lastClanWarInfo.enemyClanTeamsTotalScore = this._lastClanWarData.maxScores[_loc2_ - 1];
         var _loc5_:Number = (this._lastClanWarInfo.myClanAttackScores[0] + this._lastClanWarInfo.myClanAttackScores[1]) / this._lastClanWarInfo.enemyClanTeamsTotalScore;
         var _loc6_:Number = (this._lastClanWarInfo.enemyClanAttackScores[0] + this._lastClanWarInfo.enemyClanAttackScores[1]) / this._lastClanWarInfo.myClanTeamsTotalScore;
         this._lastClanWarInfo.myClanWon = _loc5_ > _loc6_;
      }
      
      public function get hasLastWarInfo() : Boolean
      {
         if(this._lastClanWarInfo == null)
         {
            return false;
         }
         return this._lastClanWarInfo.available;
      }
      
      public function get lastClanWarInfo() : ClanWarLastWarInfo
      {
         return this._lastClanWarInfo;
      }
      
      public function userStartedBattle(param1:uint) : void
      {
         this.currentOpponentPlayerID = param1;
         var _loc2_:ClanWarPlayerData = this.getPlayerData(this.dataM.userID);
         --_loc2_.attacksLeft;
      }
      
      public function userFinishedBattle(param1:uint) : void
      {
         var _loc2_:ClanWarPlayerData = this.getPlayerData(this.dataM.userID);
         this.setBattleResultMessage(param1);
         _loc2_.addAttackData(this.currentOpponentPlayerID,param1);
         this.setAndSortAttacksByDefenderIDs();
      }
      
      private function setBattleResultMessage(param1:uint) : void
      {
         var _loc8_:ClanWarPlayerData = null;
         var _loc9_:uint = 0;
         var _loc12_:String = null;
         var _loc13_:String = null;
         this.p_battleResultMessage = new Array();
         var _loc2_:String = TextUtils.getNumberWithComma(param1);
         var _loc3_:ClanWarAttackData = this.getBestAttackInfoAgainstPlayer(this.currentOpponentPlayerID);
         var _loc4_:ClanWarAttackData = this.getBestAttackInfoAgainstPlayer(this.currentOpponentPlayerID,this.dataM.userID);
         var _loc5_:String = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>";
         var _loc6_:Boolean = false;
         if(_loc4_ == null)
         {
            _loc6_ = true;
         }
         else if(param1 > _loc4_.score)
         {
            _loc6_ = true;
         }
         var _loc7_:Boolean = false;
         if(_loc3_ == null)
         {
            _loc7_ = true;
         }
         else if(param1 > _loc3_.score)
         {
            _loc7_ = true;
         }
         if(_loc6_)
         {
            _loc12_ = this.languageM.getText("clanWar_newBestScore");
            _loc12_ = this.dataM.replaceStringInText(_loc12_,"%SCORE%",_loc5_ + _loc2_ + "<FONT>");
            this.p_battleResultMessage.push(_loc12_);
         }
         else
         {
            _loc13_ = this.languageM.getText("clanWar_score");
            _loc13_ = this.dataM.replaceStringInText(_loc13_,"%SCORE%",_loc5_ + _loc2_ + "</FONT>");
            this.p_battleResultMessage.push(_loc13_);
         }
         if(_loc3_ != null)
         {
            _loc8_ = this.getPlayerData(_loc3_.attackerPlayerID);
            _loc9_ = _loc3_.score;
         }
         else
         {
            _loc8_ = this.getPlayerData(this.dataM.userID);
            _loc9_ = param1;
         }
         var _loc10_:String = this.languageM.getText("clanWar_bestScore");
         _loc10_ = this.dataM.replaceStringInText(_loc10_,"%SCORE%",_loc5_ + TextUtils.getNumberWithComma(_loc9_) + "</FONT>");
         this.p_battleResultMessage.push(_loc10_);
         var _loc11_:String = this.languageM.getText("clanWar_by");
         _loc11_ = this.dataM.replaceStringInText(_loc11_,"%NAME%",_loc5_ + _loc8_.playerName + "</FONT>");
         this.p_battleResultMessage.push(_loc11_);
      }
      
      private function get languageM() : BMLanguageManager
      {
         return BMLanguageManager.getInstance();
      }
      
      public function get battleResultMessage() : Array
      {
         return this.p_battleResultMessage;
      }
      
      public function joinWarSuccess(param1:Object) : void
      {
         var _loc12_:BMMechStructure = null;
         var _loc13_:String = null;
         var _loc14_:uint = 0;
         var _loc15_:String = null;
         var _loc16_:uint = 0;
         var _loc17_:BMItemData = null;
         this._clanWarData = param1;
         this.createClanPlayersData();
         var _loc2_:int = this.dataM.getGeneralSetting("currentClanWarID",-1);
         if(_loc2_ == -1)
         {
            throw Error("currentClanWarID is missing");
         }
         var _loc3_:Number = this.myClanPlayersData.length - 1;
         while(_loc3_ >= 0)
         {
            if(this.myClanPlayersData[_loc3_].playerID == this.dataM.userID)
            {
               this.myClanPlayersData.splice(_loc3_,1);
            }
            _loc3_--;
         }
         this._playerJoinedEra = _loc2_;
         var _loc4_:Array = new Array();
         var _loc5_:uint = 1;
         while(_loc5_ <= 3)
         {
            _loc12_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
            _loc12_.initialize(this.dataM.player1PlayerID,_loc5_);
            _loc12_.copyMechStructure(this.dataM.myPlayerData.mechStructures[_loc5_]);
            _loc12_.convertPlayerItemIDsIntoItemIDs();
            _loc13_ = "";
            _loc14_ = 0;
            while(_loc14_ < ClanWarPlayerData.arrayStructure.length)
            {
               _loc15_ = ClanWarPlayerData.arrayStructure[_loc14_];
               if(_loc13_ != "")
               {
                  _loc13_ += "_";
               }
               _loc16_ = uint(_loc12_[_loc15_]);
               _loc13_ += String(_loc16_);
               if(_loc16_ != 0)
               {
                  _loc17_ = this.dataM.itemsDB[_loc16_];
                  if(_loc17_.canBeColored)
                  {
                     if(_loc12_[_loc15_ + "_colorID"] > 0)
                     {
                        _loc13_ += "-" + String(_loc12_[_loc15_ + "_colorID"]);
                     }
                  }
               }
               _loc14_++;
            }
            _loc4_.push(_loc13_.split("_"));
            _loc5_++;
         }
         var _loc6_:Array = new Array();
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Array = new Array();
         var _loc10_:Boolean = false;
         var _loc11_:ClanWarPlayerData = new ClanWarPlayerData(this.dataM.userID,this.dataM.myProfile.playerName,this.dataM.myProfile.ladderProgress,_loc4_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
         _loc11_.teamMaxScore = this.getTeamMaxScore(_loc11_.mechStructures);
         this._myClanPlayersData.push(_loc11_);
         if(this.screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_PREPARATION))
         {
            this.screensM.screenClanWarPreparation.defenceTeamChangeUpdated();
         }
         else
         {
            this.screensM.screenClanMenu.openClanWarPreparation(true);
         }
      }
      
      private function get screensM() : BMScreensManager
      {
         return BMScreensManager.getInstance();
      }
      
      public function get attacksMax() : uint
      {
         var _loc1_:ClanWarPlayerData = null;
         for each(_loc1_ in this.myClanPlayersData)
         {
            if(_loc1_.playerID == this.dataM.userID)
            {
               return _loc1_.attacksMax;
            }
         }
         throw Error("did not find player data");
      }
      
      public function get attacksLeft() : uint
      {
         var _loc1_:ClanWarPlayerData = null;
         for each(_loc1_ in this.myClanPlayersData)
         {
            if(_loc1_.playerID == this.dataM.userID)
            {
               return _loc1_.attacksLeft;
            }
         }
         throw Error("did not find player data");
      }
      
      public function get currentWarRound() : uint
      {
         if(this.currentPhase == WAR_PHASE_ROUND1)
         {
            return 1;
         }
         if(this.currentPhase == WAR_PHASE_ROUND2)
         {
            return 2;
         }
         return 0;
      }
      
      public function get maxWarRounds() : uint
      {
         return 2;
      }
      
      public function get myClanScoreRatio() : Number
      {
         return this.myClanScore / this.enemyClanMaxScore;
      }
      
      public function get enemyClanScoreRatio() : Number
      {
         return this.enemyClanScore / this.myClanMaxScore;
      }
      
      public function get myScore() : uint
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:ClanWarAttackData = null;
         var _loc1_:uint = this.getMyPreviousRoundsScore();
         for each(_loc2_ in this._attacksByDefenderIDs)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_];
               if(_loc4_.attackerPlayerID == this.dataM.userID)
               {
                  _loc1_ += _loc4_.score;
                  break;
               }
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      private function getMyPreviousRoundsScore() : uint
      {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc1_:uint = 0;
         if(this.currentPhase != WAR_PHASE_ROUND2 || this._clanWarData.attacksData == null)
         {
            return _loc1_;
         }
         if(this._clanWarData.attacksData[WAR_PHASE_ROUND1 - 1] == null)
         {
            return _loc1_;
         }
         var _loc2_:Object = this._clanWarData.attacksData[WAR_PHASE_ROUND1 - 1][String(this.dataM.userID)];
         if(_loc2_ == null)
         {
            return _loc1_;
         }
         if(_loc2_[1] == null)
         {
            return _loc1_;
         }
         for(_loc3_ in _loc2_[1])
         {
            _loc4_ = uint(_loc2_[1][_loc3_]);
            _loc1_ += _loc4_;
         }
         return _loc1_;
      }
      
      public function get myClanScore() : uint
      {
         return this.getHighestScoreAgainstClan(this._enemyClanPlayersData);
      }
      
      public function get enemyClanScore() : uint
      {
         return this.getHighestScoreAgainstClan(this._myClanPlayersData);
      }
      
      public function getHighestScoreAgainstClan(param1:Vector.<ClanWarPlayerData>) : uint
      {
         var _loc3_:ClanWarPlayerData = null;
         var _loc4_:ClanWarAttackData = null;
         var _loc2_:uint = 0;
         for each(_loc3_ in param1)
         {
            if(this._attacksByDefenderIDs[_loc3_.playerID] != null)
            {
               _loc4_ = this._attacksByDefenderIDs[_loc3_.playerID][0];
               _loc2_ += _loc4_.score;
            }
         }
         return _loc2_;
      }
      
      public function get myAttacksLeft() : uint
      {
         return this.getPlayerData(this.dataM.userID).attacksLeft;
      }
      
      public function get myClanMaxScore() : uint
      {
         return this.getClanMaxScore(this._myClanPlayersData);
      }
      
      public function get enemyClanMaxScore() : uint
      {
         return this.getClanMaxScore(this._enemyClanPlayersData);
      }
      
      public function getClanMaxScore(param1:Vector.<ClanWarPlayerData>) : uint
      {
         var _loc3_:ClanWarPlayerData = null;
         var _loc2_:uint = 0;
         for each(_loc3_ in param1)
         {
            _loc2_ += this.getTeamMaxScore(_loc3_.mechStructures);
         }
         return _loc2_;
      }
      
      public function getTeamMaxScore(param1:Vector.<BMMechStructure>) : *
      {
         var _loc4_:BMMechStructure = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:BMItemData = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = this.dataM.getGeneralSetting("itemPROffset",0);
         for each(_loc4_ in param1)
         {
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc6_ < ClanWarPlayerData.arrayStructure.length)
            {
               _loc7_ = ClanWarPlayerData.arrayStructure[_loc6_];
               _loc8_ = uint(_loc4_[_loc7_]);
               if(_loc8_ != 0)
               {
                  _loc9_ = this.dataM.itemsDB[_loc8_];
                  _loc5_ += (_loc3_ + _loc9_.powerRating) * _loc9_.weight;
               }
               _loc6_++;
            }
            _loc2_ += Math.ceil(_loc5_ / int(this.clanWarsData.powerRatingToScoreMultiplier));
         }
         return _loc2_;
      }
      
      public function setLocalNotifications() : void
      {
         if(this.isFeatureEnabled == false)
         {
            return;
         }
         if(BMNotificationsManager.hasInstance())
         {
            BMClanWarsLocalNotificationsHelper.updateLocalNotifications(BMNotificationsManager.getInstance());
         }
      }
      
      public function get didQuitAClanThisSession() : Boolean
      {
         return this._didQuitAClanThisSession;
      }
      
      public function set didQuitAClanThisSession(param1:Boolean) : void
      {
         this._didQuitAClanThisSession = param1;
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
   }
}

