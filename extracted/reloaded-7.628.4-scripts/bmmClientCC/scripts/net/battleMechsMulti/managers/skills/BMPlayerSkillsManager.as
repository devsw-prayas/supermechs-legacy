package net.battleMechsMulti.managers.skills
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMRemoteManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.screens.arenaShop.BMPlayerSkillData;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMPlayerSkillsManager
   {
      
      private var _data:Array;
      
      private var _currentUpgradeSkillID:uint;
      
      private var _currentUpgradeHandler:Function;
      
      private var _enabledSkills:uint;
      
      public function BMPlayerSkillsManager()
      {
         super();
         BMPubSub.sub(BMPubSub.MESSAGE_UPGRADE_SKILL_NETWORK_REQUEST_COMPLETED,this.handleUpgradeRequestFinished);
      }
      
      public function getSkillIDByType(param1:String) : int
      {
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerSkillData = null;
         if(this._data != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this._data.length)
            {
               _loc3_ = this._data[_loc2_];
               if(_loc3_.type == param1)
               {
                  return _loc3_.skillID;
               }
               _loc2_++;
            }
         }
         return -1;
      }
      
      public function parseData(param1:Object) : *
      {
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:uint = 0;
         var _loc12_:BMPlayerSkillData = null;
         var _loc13_:Number = NaN;
         var _loc14_:uint = 0;
         this._data = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Array = param1["skills"];
         this._data = new Array();
         this._enabledSkills = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc3_];
            _loc6_ = _loc5_["type"];
            _loc7_ = 0;
            if(_loc5_["releaseTime"] != null)
            {
               _loc7_ = Number(_loc5_["releaseTime"]);
            }
            if(_loc7_ <= BMDataManager.getInstance().currentTime)
            {
               _loc8_ = new Array();
               _loc9_ = new Array();
               _loc10_ = _loc5_["levels"];
               _loc11_ = 0;
               while(_loc11_ < _loc10_.length)
               {
                  _loc13_ = Number(_loc10_[_loc11_]["bonus"]);
                  _loc14_ = uint(_loc10_[_loc11_]["cost"]);
                  _loc8_.push(_loc13_);
                  _loc9_.push(_loc14_);
                  _loc11_++;
               }
               _loc12_ = new BMPlayerSkillData(_loc3_,_loc6_,_loc8_,_loc9_);
               if(_loc12_.isEnabled)
               {
                  ++this._enabledSkills;
               }
               this._data.push(_loc12_);
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      public function get skillsData() : Array
      {
         return this._data;
      }
      
      public function get arePlayerSkillsEnabled() : Boolean
      {
         return this._data != null;
      }
      
      public function get totalSkillsEnabled() : uint
      {
         return this._enabledSkills;
      }
      
      public function getSkillLevel(param1:uint, param2:uint) : uint
      {
         if(this.arePlayerSkillsEnabled == false)
         {
            return 0;
         }
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         var _loc4_:BMPlayerProfile = _loc3_["player" + param1 + "Profile"];
         if(_loc4_.skills[param2] == null)
         {
            return 0;
         }
         return uint(_loc4_.skills[param2]);
      }
      
      public function getNextLevelCost(param1:uint) : uint
      {
         var _loc2_:BMPlayerSkillData = this._data[param1];
         var _loc3_:uint = this.getSkillLevel(BMDataManager.getInstance().player1PlayerID,param1);
         if(_loc3_ >= _loc2_.levelsTotal)
         {
            throw Error("ERROR: skill is maxed, cannot return cost");
         }
         return _loc2_.levelsCost[_loc3_];
      }
      
      public function getSkillCurrentLevelBonus(param1:uint, param2:uint) : Number
      {
         var _loc3_:BMPlayerSkillData = this._data[param2];
         var _loc4_:uint = this.getSkillLevel(param1,param2);
         if(_loc4_ == 0)
         {
            return 0;
         }
         return Number(_loc3_.levelBonus[_loc4_ - 1]);
      }
      
      public function getSkillNextLevelBonus(param1:uint) : Number
      {
         var _loc2_:BMPlayerSkillData = this._data[param1];
         var _loc3_:uint = this.getSkillLevel(BMDataManager.getInstance().player1PlayerID,param1);
         if(_loc3_ >= _loc2_.levelsTotal)
         {
            throw Error("ERROR: skill is maxed, cannot return bonus");
         }
         return Number(_loc2_.levelBonus[_loc3_]);
      }
      
      public function isSkillMaxed(param1:uint) : Boolean
      {
         var _loc2_:BMPlayerSkillData = this._data[param1];
         var _loc3_:uint = this.getSkillLevel(BMDataManager.getInstance().player1PlayerID,param1);
         if(_loc3_ >= _loc2_.levelsTotal)
         {
            return true;
         }
         return false;
      }
      
      public function upgradeSkill(param1:uint, param2:Function) : *
      {
         this._currentUpgradeSkillID = param1;
         this._currentUpgradeHandler = param2;
         var _loc3_:BMPlayerSkillData = this._data[param1];
         BMRemoteManager.getInstance().lobby_upgradeSkill(_loc3_.type);
      }
      
      public function getHighestLevelAvailableSkillCost() : uint
      {
         var _loc4_:int = 0;
         var _loc1_:uint = BMDataManager.getInstance().player1PlayerID;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < this._data.length)
         {
            if(!this.isSkillMaxed(_loc3_))
            {
               _loc4_ = int(this.getNextLevelCost(_loc3_));
               if(_loc4_ > _loc2_)
               {
                  _loc2_ = _loc4_;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function canPlayerBuyHighestLevelAvailableSkill() : Boolean
      {
         var _loc1_:uint = this.getHighestLevelAvailableSkillCost();
         if(_loc1_ == 0)
         {
            return false;
         }
         if(BMDataManager.getInstance().myProfile.arenaCoins < _loc1_)
         {
            return false;
         }
         return true;
      }
      
      private function handleUpgradeRequestFinished(param1:String, param2:Object) : *
      {
         var _loc7_:BMDataManager = null;
         var _loc8_:BMPlayerSkillData = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:Boolean = Boolean(param2.status);
         var _loc4_:String = param2.error;
         var _loc5_:uint = this._currentUpgradeSkillID;
         var _loc6_:Function = this._currentUpgradeHandler;
         if(_loc3_)
         {
            _loc7_ = BMDataManager.getInstance();
            _loc8_ = this.skillsData[_loc5_];
            _loc9_ = uint(_loc7_.myProfile.skills[_loc5_]);
            _loc10_ = uint(_loc8_.levelsCost[_loc9_]);
            ++_loc7_.myProfile.skills[_loc5_];
            _loc7_.myProfile.arenaCoins -= _loc10_;
         }
         this._currentUpgradeSkillID = 0;
         this._currentUpgradeHandler = null;
         if(_loc6_ != null)
         {
            _loc6_(_loc5_,_loc3_,_loc4_);
         }
      }
   }
}

