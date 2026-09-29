package net.battleMechsMulti.data
{
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   
   public class BMMissionDefinitionRepository
   {
      
      private var missionRewards:Array;
      
      private var missionCosts:Array;
      
      private var missionEnemyPowerRating:Array;
      
      private var missionFirstClearTokenRewards:Array;
      
      private var missionDifficultyMultipliers:Array;
      
      private var missionClanBossTickets:Array;
      
      private var missionBoxFragments:Array;
      
      public function BMMissionDefinitionRepository(param1:* = null)
      {
         var _loc2_:uint = 0;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:Array = null;
         var _loc15_:Array = null;
         var _loc16_:Object = null;
         var _loc17_:BMRewardRange = null;
         var _loc18_:Object = null;
         super();
         if(param1 == null)
         {
            return;
         }
         this.missionRewards = new Array();
         this.missionCosts = new Array();
         this.missionEnemyPowerRating = new Array();
         this.missionFirstClearTokenRewards = new Array();
         this.missionDifficultyMultipliers = new Array();
         this.missionClanBossTickets = new Array();
         this.missionBoxFragments = new Array();
         var _loc3_:Array = BMSinglePlayerManager.STORY_IDS_NEW;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = uint(_loc3_[_loc4_]);
            this.missionRewards[_loc2_] = new Array();
            this.missionCosts[_loc2_] = new Array();
            this.missionEnemyPowerRating[_loc2_] = new Array();
            this.missionFirstClearTokenRewards[_loc2_] = new Array();
            this.missionDifficultyMultipliers[_loc2_] = new Array();
            this.missionClanBossTickets[_loc2_] = new Array();
            this.missionBoxFragments[_loc2_] = new Array();
            _loc5_ = param1[_loc2_];
            if(_loc5_ != null)
            {
               for(_loc6_ in _loc5_)
               {
                  _loc7_ = _loc5_[_loc6_];
                  _loc8_ = parseInt(_loc6_);
                  _loc9_ = new Array();
                  _loc10_ = new Array();
                  _loc11_ = new Array();
                  _loc12_ = new Array();
                  _loc13_ = new Array();
                  _loc14_ = new Array();
                  _loc15_ = new Array();
                  for each(_loc16_ in _loc7_)
                  {
                     _loc17_ = new BMRewardRange(_loc16_);
                     _loc9_.push(_loc17_);
                     _loc10_.push(_loc16_["battleCreditsCost"]);
                     _loc11_.push(_loc16_["enemyPowerRating"]);
                     _loc12_.push(_loc16_["firstClearRewardTokens"]);
                     _loc15_.push(_loc16_["difficultyMultipliers"]);
                     _loc13_.push(_loc16_["clanBossTickets"]);
                     if(_loc17_.max.boxFragments != null)
                     {
                        for(_loc18_ in _loc17_.max.boxFragments)
                        {
                           _loc14_.push({
                              "gachaMachineID":int(_loc18_),
                              "amount":_loc17_.max.boxFragments[_loc18_]
                           });
                        }
                     }
                  }
                  this.missionRewards[_loc2_][_loc8_] = _loc9_;
                  this.missionCosts[_loc2_][_loc8_] = _loc10_;
                  this.missionEnemyPowerRating[_loc2_][_loc8_] = _loc11_;
                  this.missionFirstClearTokenRewards[_loc2_][_loc8_] = _loc12_;
                  this.missionDifficultyMultipliers[_loc2_][_loc8_] = _loc15_;
                  this.missionClanBossTickets[_loc2_][_loc8_] = _loc13_;
                  this.missionBoxFragments[_loc2_][_loc8_] = _loc14_;
               }
            }
            _loc4_++;
         }
      }
      
      public function getMissionRewards(param1:uint, param2:uint, param3:uint) : BMRewardRange
      {
         var _loc4_:Array = this.missionRewards[param1][param2];
         return _loc4_[param3];
      }
      
      public function getMissionBattleCreditsCost(param1:uint, param2:uint, param3:uint, param4:uint) : uint
      {
         var _loc5_:Array = this.missionCosts[param1][param2];
         return _loc5_[param3];
      }
      
      public function getMissionEnemyPowerRating(param1:uint, param2:uint, param3:uint) : uint
      {
         var _loc4_:Array = this.missionEnemyPowerRating[param1][param2];
         return _loc4_[param3];
      }
      
      public function getMissionFirstClearRewardTokens(param1:uint, param2:uint, param3:uint) : uint
      {
         var _loc4_:Array = this.missionFirstClearTokenRewards[param1][param2];
         return _loc4_[param3];
      }
      
      public function getMissionDifficultyMultiplier(param1:uint, param2:uint, param3:uint, param4:uint) : Number
      {
         var _loc5_:Array = this.missionDifficultyMultipliers[param1][param2];
         return Number(_loc5_[param3]);
      }
      
      public function getMissionClanBossTickets(param1:uint, param2:uint, param3:uint) : Number
      {
         var _loc4_:Array = this.missionClanBossTickets[param1][param2];
         if(_loc4_ == null)
         {
            return 0;
         }
         return Number(_loc4_[param3]);
      }
      
      public function getMissionBoxFragmentsData(param1:uint, param2:uint, param3:uint) : Object
      {
         var _loc4_:Array = this.missionBoxFragments[param1][param2];
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_[param3];
      }
   }
}

