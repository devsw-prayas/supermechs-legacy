package net.battleMechsMulti.managers.basebuilding
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.screens.arenaShop.BMPlayerSkillData;
   
   public class BMBaseBuildingDB
   {
      
      public static const STRUCTURE_TYPE_HQ:uint = 1;
      
      public static const STRUCTURE_TYPE_GOLD_MINE:uint = 2;
      
      public static const STRUCTURE_TYPE_ITEM_FACTORY:uint = 3;
      
      public static const ALL_STRUCTURE_TYPES:Array = [STRUCTURE_TYPE_HQ,STRUCTURE_TYPE_GOLD_MINE,STRUCTURE_TYPE_ITEM_FACTORY];
      
      public static const HQ_STRUCTURE_POSITION:uint = 0;
      
      private var baseDefinition:Object;
      
      private var skippingCostEntries:Array;
      
      private var structureConfigs:Object;
      
      private var skippingUpgradeQueueGraceSeconds:int = 0;
      
      public function BMBaseBuildingDB()
      {
         super();
      }
      
      public function initializeFromData(param1:Object) : void
      {
         this.baseDefinition = param1.base_definition;
         this.skippingCostEntries = param1.skipping_queues_config;
         this.structureConfigs = param1.structures;
         if(param1.hasOwnProperty("skipping_upgrade_queue_grace_seconds"))
         {
            this.skippingUpgradeQueueGraceSeconds = param1.skipping_upgrade_queue_grace_seconds;
         }
      }
      
      public function getNumberOfStuctureInstancesLevels(param1:uint) : *
      {
         return this.baseDefinition[param1].levelsUnlocked;
      }
      
      public function getTokensCostToSkipQueue(param1:uint, param2:Boolean) : uint
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         if(param2 && param1 < this.skippingUpgradeQueueGraceSeconds)
         {
            return 0;
         }
         var _loc3_:uint = 0;
         var _loc4_:* = int(this.skippingCostEntries.length - 1);
         while(_loc4_ >= 0)
         {
            _loc5_ = uint(this.skippingCostEntries[_loc4_].periodSeconds);
            _loc6_ = uint(int(Math.floor(param1 / _loc5_)));
            if(_loc4_ == 0)
            {
               _loc6_ = uint(int(Math.ceil(param1 / _loc5_)));
            }
            _loc7_ = _loc6_ * this.skippingCostEntries[_loc4_].skipCostTokens;
            if(_loc4_ < this.skippingCostEntries.length - 1)
            {
               _loc8_ = uint(this.skippingCostEntries[_loc4_ + 1].skipCostTokens);
               if(_loc7_ > _loc8_)
               {
                  _loc3_ += _loc8_;
                  break;
               }
            }
            _loc3_ += _loc7_;
            param1 -= _loc6_ * _loc5_;
            _loc4_--;
         }
         return _loc3_;
      }
      
      public function getSecondsRequiredToUpgradeStructure(param1:uint, param2:uint) : uint
      {
         var _loc6_:Number = NaN;
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         var _loc4_:Number = Number(this.structureConfigs[param1][param2].upgradeSeconds);
         var _loc5_:int = _loc3_.playerSkillsManager.getSkillIDByType(BMPlayerSkillData.TYPE_BASE_UPGRADES_TIME);
         if(_loc5_ > -1)
         {
            _loc6_ = _loc3_.playerSkillsManager.getSkillCurrentLevelBonus(_loc3_.player1PlayerID,_loc5_);
            _loc4_ = _loc4_ * (100 - _loc6_) / 100;
         }
         return _loc4_;
      }
      
      public function getGoldRequiredToUpgradeStructure(param1:uint, param2:uint) : uint
      {
         return this.structureConfigs[param1][param2].upgradeCost;
      }
      
      public function getGoldMineMiningRate(param1:uint) : uint
      {
         if(param1 == 0)
         {
            return 0;
         }
         return this.structureConfigs[STRUCTURE_TYPE_GOLD_MINE][param1 - 1].miningRate;
      }
      
      public function getGoldMineCapacity(param1:uint) : uint
      {
         if(param1 == 0)
         {
            return 0;
         }
         return this.structureConfigs[STRUCTURE_TYPE_GOLD_MINE][param1 - 1].capacity;
      }
      
      public function getItemFactoryProductionPrice(param1:uint) : uint
      {
         if(param1 == 0)
         {
            return 0;
         }
         return this.structureConfigs[STRUCTURE_TYPE_ITEM_FACTORY][param1 - 1].productionPrice;
      }
      
      public function getItemFactoryProductionTimeSeconds(param1:uint) : uint
      {
         if(param1 == 0)
         {
            return 0;
         }
         return this.structureConfigs[STRUCTURE_TYPE_ITEM_FACTORY][param1 - 1].productionSeconds;
      }
      
      public function getStructureMaxLevel(param1:uint) : uint
      {
         return this.structureConfigs[param1].length;
      }
      
      public function getItemFactoryLevelDescription(param1:uint) : String
      {
         return this.structureConfigs[STRUCTURE_TYPE_ITEM_FACTORY][param1 - 1].description;
      }
      
      public function getItemFactoryLevelVisualID(param1:uint) : int
      {
         return this.structureConfigs[STRUCTURE_TYPE_ITEM_FACTORY][param1 - 1].visualID;
      }
      
      public function getItemFactoryLevelTitle(param1:uint) : String
      {
         return this.structureConfigs[STRUCTURE_TYPE_ITEM_FACTORY][param1 - 1].title;
      }
   }
}

