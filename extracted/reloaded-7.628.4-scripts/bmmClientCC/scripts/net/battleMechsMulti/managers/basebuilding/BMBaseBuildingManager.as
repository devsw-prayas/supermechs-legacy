package net.battleMechsMulti.managers.basebuilding
{
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMRemoteManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.screens.arenaShop.BMPlayerSkillData;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMBaseBuildingManager
   {
      
      public static const STRUCTURE_UPGRADE_STATE_CAN_UPGRADE:uint = 0;
      
      public static const STRUCTURE_UPGRADE_STATE_OTHER_UPGRADE_IN_PROGRESS:uint = 1;
      
      public static const STRUCTURE_UPGRADE_STATE_HQ_LEVEL_TOO_LOW:uint = 2;
      
      public static const STRUCTURE_UPGRADE_STATE_NOT_ENOUGH_GOLD:uint = 3;
      
      public static const STRUCTURE_UPGRADE_STATE_MAX_LEVEL:uint = 4;
      
      public static const STRUCTURE_UPGRADE_STATE_MUST_COLLECT_FIRST:uint = 5;
      
      public static const STRUCTURE_UPGRADE_STATE_CRAFT_IN_PROGRESS:uint = 6;
      
      public static const MIN_MINED_GOLD_PERCENT_FOR_COLLECTION:uint = 5;
      
      public var db:BMBaseBuildingDB;
      
      public var state:BMBaseBuildingState;
      
      private var _pendingTransactionGoldCost:int;
      
      private var _pendingTransactionTokenCost:int;
      
      public function BMBaseBuildingManager()
      {
         super();
         this.db = new BMBaseBuildingDB();
         this.state = new BMBaseBuildingState();
      }
      
      public function get isEnabled() : Boolean
      {
         if(BMDataManager.getInstance().getGeneralSetting("enableBaseBuilding",0) == 1)
         {
            if(this.state.getPositionsWithStructures().length > 0)
            {
               return true;
            }
            if(BMTutorialManager.gi().isTutorialActive())
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isOptInAllowed() : Boolean
      {
         if(this.isEnabled)
         {
            return false;
         }
         if(BMDataManager.getInstance().getGeneralSetting("enableBaseBuilding",0) == 1)
         {
            return true;
         }
         return false;
      }
      
      public function parseRules(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.db.initializeFromData(param1);
      }
      
      public function updateState(param1:Object) : void
      {
         if(param1 != null)
         {
            this.state.updateFromData(param1);
            this.refreshNotifications();
            BMPubSub.pub(BMPubSub.MESSAGE_BASE_BUILDING_STATE_MODIFIED);
         }
      }
      
      public function buildStructure(param1:uint, param2:uint) : void
      {
         this._pendingTransactionGoldCost = this.db.getGoldRequiredToUpgradeStructure(param2,0);
         this.remoteM.baseBuilding_buildStructure(param1,param2);
      }
      
      public function upgradeStructure(param1:uint) : void
      {
         var _loc2_:BMBaseBuildingStructureState = this.state.getStructureState(param1);
         this._pendingTransactionGoldCost = this.db.getGoldRequiredToUpgradeStructure(_loc2_.type,_loc2_.level);
         this.remoteM.baseBuilding_upgradeStructure(param1);
      }
      
      public function collectResources(param1:uint) : void
      {
         this.remoteM.baseBuilding_collectResources(param1);
      }
      
      public function getItemFactoryProductionPriceForPlayer(param1:uint) : uint
      {
         var _loc2_:uint = this.db.getItemFactoryProductionPrice(param1);
         var _loc3_:int = this.dataM.playerSkillsManager.getSkillIDByType(BMPlayerSkillData.TYPE_BASE_CRAFTING_COST);
         var _loc4_:Number = 0;
         if(_loc3_ > -1)
         {
            _loc4_ = this.dataM.playerSkillsManager.getSkillCurrentLevelBonus(this.dataM.player1PlayerID,_loc3_);
         }
         return int(Math.ceil(_loc2_ * (100 - _loc4_) / 100));
      }
      
      public function addToItemFactoryBuildQueue(param1:uint, param2:uint, param3:uint) : void
      {
         this._pendingTransactionGoldCost = this.getItemFactoryProductionPriceForPlayer(param2) * param3;
         this.remoteM.baseBuilding_addToItemFactoryBuildQueue(param1,param2,param3);
      }
      
      public function removeFromItemFactoryBuildQueue(param1:uint, param2:uint) : void
      {
         var _loc3_:uint = param2;
         this._pendingTransactionGoldCost = -this.getItemFactoryProductionPriceForPlayer(this.state.getStructureState(param1).itemFactoryItemTypeInQueue) * _loc3_;
         this.remoteM.baseBuilding_removeFromItemFactoryBuildQueue(param1,param2);
      }
      
      public function swapStructurePositions(param1:uint, param2:uint) : void
      {
         this.remoteM.baseBuilding_swapStructurePositions(param1,param2);
      }
      
      public function optInToFeature() : void
      {
         this.remoteM.baseBuilding_optIn();
      }
      
      public function skipStructureQueueWithTokens(param1:uint) : *
      {
         var _loc2_:uint = this.getCostTokensToSkipStructure(param1);
         this._pendingTransactionTokenCost = _loc2_;
         this.remoteM.baseBuilding_skipBaseBuildingQueue(param1,_loc2_);
      }
      
      public function getCostTokensToSkipStructure(param1:uint) : uint
      {
         var _loc2_:BMBaseBuildingStructureState = this.state.getStructureState(param1);
         if(_loc2_.upgradeFinishTime > this.now)
         {
            return this.db.getTokensCostToSkipQueue(_loc2_.upgradeFinishTime - this.now,true);
         }
         if(_loc2_.type == BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY && _loc2_.itemFactoryQueueFinishTime > this.now)
         {
            return this.db.getTokensCostToSkipQueue(_loc2_.itemFactoryQueueFinishTime - this.now,false);
         }
         return 0;
      }
      
      public function getSecondsLeftToUpgradeStructure(param1:uint) : uint
      {
         var _loc2_:BMBaseBuildingStructureState = this.state.getStructureState(param1);
         if(_loc2_.upgradeFinishTime > this.now)
         {
            return _loc2_.upgradeFinishTime - this.now;
         }
         return 0;
      }
      
      public function getSecondsLeftToFinishProducingItems(param1:uint, param2:uint = 0) : uint
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:BMBaseBuildingStructureState = this.state.getStructureState(param1);
         if(param2 > 0 && param2 < _loc3_.itemFactoryItemsInQueue)
         {
            _loc4_ = this.getItemFactoryProductionTimeSecondsForPlayer(_loc3_.itemFactoryItemTypeInQueue);
            _loc5_ = _loc3_.itemFactoryQueueFinishTime - _loc3_.itemFactoryItemsInQueue * _loc4_;
            _loc6_ = _loc5_ + param2 * _loc4_;
            if(_loc6_ > this.now)
            {
               return _loc6_ - this.now;
            }
         }
         else if(_loc3_.itemFactoryQueueFinishTime > this.now)
         {
            return _loc3_.itemFactoryQueueFinishTime - this.now;
         }
         return 0;
      }
      
      private function getItemFactoryProductionTimeSecondsForPlayer(param1:uint) : *
      {
         var _loc2_:uint = this.db.getItemFactoryProductionTimeSeconds(param1);
         var _loc3_:int = this.dataM.playerSkillsManager.getSkillIDByType(BMPlayerSkillData.TYPE_BASE_CRAFTING_TIME);
         var _loc4_:Number = 0;
         if(_loc3_ > -1)
         {
            _loc4_ = this.dataM.playerSkillsManager.getSkillCurrentLevelBonus(this.dataM.player1PlayerID,_loc3_);
         }
         return int(Math.ceil(_loc2_ * (100 - _loc4_) / 100));
      }
      
      public function getNumberOfItemsReadyToBeCollected(param1:uint) : uint
      {
         var _loc2_:uint = this.getSecondsLeftToFinishProducingItems(param1);
         var _loc3_:uint = this.state.getStructureState(param1).itemFactoryItemTypeInQueue;
         var _loc4_:uint = this.state.getStructureState(param1).itemFactoryItemsInQueue;
         var _loc5_:uint = this.getItemFactoryProductionTimeSecondsForPlayer(_loc3_);
         var _loc6_:uint = _loc5_ * _loc4_;
         var _loc7_:int = Math.max(_loc6_ - _loc2_,0);
         return int(_loc7_ / _loc5_);
      }
      
      public function getNumberOfItemsStillInQueue(param1:uint) : uint
      {
         return this.state.getStructureState(param1).itemFactoryItemsInQueue - this.getNumberOfItemsReadyToBeCollected(param1);
      }
      
      public function getGoldPercentReadyToBeCollected(param1:uint) : uint
      {
         var _loc2_:BMBaseBuildingStructureState = this.state.getStructureState(param1);
         var _loc3_:uint = this.db.getGoldMineCapacity(_loc2_.level);
         return uint(this.getGoldReadyToBeCollected(param1) * 100 / _loc3_);
      }
      
      public function getGoldReadyToBeCollected(param1:uint) : uint
      {
         var _loc2_:BMBaseBuildingStructureState = this.state.getStructureState(param1);
         if(this.now < _loc2_.goldMineLastCollectTime)
         {
            return 0;
         }
         var _loc3_:uint = this.now - _loc2_.goldMineLastCollectTime;
         var _loc4_:uint = this.db.getGoldMineCapacity(_loc2_.level);
         var _loc5_:uint = this.db.getGoldMineMiningRate(_loc2_.level);
         var _loc6_:* = int(_loc5_ * _loc3_ / 3600);
         if(_loc6_ >= _loc4_)
         {
            _loc6_ = _loc4_;
         }
         return _loc6_;
      }
      
      public function getSecondsLeftToFillGoldMine(param1:uint, param2:uint = 100) : uint
      {
         var _loc3_:BMBaseBuildingStructureState = this.state.getStructureState(param1);
         if(this.now < _loc3_.goldMineLastCollectTime)
         {
            return 0;
         }
         var _loc4_:uint = this.db.getGoldMineCapacity(_loc3_.level);
         var _loc5_:uint = this.db.getGoldMineMiningRate(_loc3_.level);
         var _loc6_:uint = uint(int(Math.ceil(_loc4_ * 3600 * (param2 / 100) / _loc5_)));
         var _loc7_:uint = _loc3_.goldMineLastCollectTime + _loc6_;
         if(_loc7_ > this.now)
         {
            return _loc7_ - this.now;
         }
         return 0;
      }
      
      public function getStructureTypesThatCanBeBuilt() : Array
      {
         var _loc2_:uint = 0;
         var _loc1_:Array = [];
         for each(_loc2_ in BMBaseBuildingDB.ALL_STRUCTURE_TYPES)
         {
            if(this.canBuildInstanceOfStructure(_loc2_))
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getStructureLevel(param1:uint) : *
      {
         var _loc2_:BMBaseBuildingStructureState = this.state.getStructureState(param1);
         var _loc3_:uint = _loc2_.level;
         if(_loc2_.upgradeFinishTime > this.now)
         {
            _loc3_--;
         }
         return _loc3_;
      }
      
      public function getHQLevelToUnlockNextStructure() : uint
      {
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc1_:uint = 4294967295;
         var _loc2_:uint = this.getStructureLevel(BMBaseBuildingDB.HQ_STRUCTURE_POSITION);
         for each(_loc3_ in BMBaseBuildingDB.ALL_STRUCTURE_TYPES)
         {
            if(_loc3_ != BMBaseBuildingDB.STRUCTURE_TYPE_HQ)
            {
               _loc4_ = this.db.getNumberOfStuctureInstancesLevels(_loc3_);
               for each(_loc5_ in _loc4_)
               {
                  if(_loc5_ > _loc2_)
                  {
                     _loc1_ = Math.min(_loc1_,_loc5_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      public function getNumberOfStructuresAvailableAtHQLevel(param1:uint, param2:uint = 0) : uint
      {
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         for each(_loc4_ in BMBaseBuildingDB.ALL_STRUCTURE_TYPES)
         {
            if(_loc4_ != BMBaseBuildingDB.STRUCTURE_TYPE_HQ)
            {
               if(!(param2 > 0 && _loc4_ != param2))
               {
                  _loc5_ = this.db.getNumberOfStuctureInstancesLevels(_loc4_);
                  for each(_loc6_ in _loc5_)
                  {
                     if(_loc6_ <= param1)
                     {
                        _loc3_++;
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function canBuildInstanceOfStructure(param1:uint) : Boolean
      {
         var _loc2_:int = int(this.state.getStructureState(BMBaseBuildingDB.HQ_STRUCTURE_POSITION).level);
         var _loc3_:* = this.getHQLevelRequiredToBuildNextInstanceOfStructure(param1);
         return _loc3_ >= 0 && _loc2_ >= _loc3_;
      }
      
      public function getHQLevelRequiredToBuildNextInstanceOfStructure(param1:uint) : int
      {
         var _loc2_:uint = this.getNumberOfBuiltInstancesForStructure(param1);
         var _loc3_:Array = this.db.getNumberOfStuctureInstancesLevels(param1);
         if(_loc2_ >= _loc3_.length)
         {
            return -1;
         }
         return _loc3_[_loc2_];
      }
      
      public function isStructureUpgrading(param1:uint) : Boolean
      {
         return this.state.getStructureState(param1).upgradeFinishTime > this.now;
      }
      
      public function getNextEventTime() : uint
      {
         var _loc3_:uint = 0;
         var _loc4_:BMBaseBuildingStructureState = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc1_:uint = 4294967295;
         var _loc2_:Array = this.state.getPositionsWithStructures();
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = this.state.getStructureState(_loc3_);
            if(this.isStructureUpgrading(_loc3_))
            {
               _loc1_ = Math.min(_loc1_,this.getSecondsLeftToUpgradeStructure(_loc3_));
            }
            if(_loc4_.type == BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE)
            {
               _loc5_ = this.getGoldPercentReadyToBeCollected(_loc3_);
               _loc6_ = this.getSecondsLeftToFillGoldMine(_loc3_);
               if(_loc5_ < MIN_MINED_GOLD_PERCENT_FOR_COLLECTION)
               {
                  _loc6_ = this.getSecondsLeftToFillGoldMine(_loc3_,MIN_MINED_GOLD_PERCENT_FOR_COLLECTION);
               }
               if(_loc6_ > 0)
               {
                  _loc1_ = Math.min(_loc1_,_loc6_);
               }
            }
            if(_loc4_.type == BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY)
            {
               _loc7_ = this.getSecondsLeftToItemFactoryNextItemReadyTime(_loc3_);
               if(_loc7_ > 0)
               {
                  _loc1_ = Math.min(_loc1_,_loc7_);
               }
            }
         }
         if(_loc1_ != 4294967295)
         {
            return this.now + _loc1_;
         }
         return 0;
      }
      
      public function getSecondsLeftToItemFactoryNextItemReadyTime(param1:uint) : uint
      {
         if(this.getNumberOfItemsStillInQueue(param1) == 0)
         {
            return 0;
         }
         return this.getSecondsLeftToFinishProducingItems(param1,this.getNumberOfItemsReadyToBeCollected(param1) + 1);
      }
      
      public function isAnyStructureUpgrading() : Boolean
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.state.getPositionsWithStructures())
         {
            if(this.isStructureUpgrading(_loc1_))
            {
               return true;
            }
         }
         return false;
      }
      
      public function getStructureUpgradeState(param1:uint) : uint
      {
         var _loc2_:uint = this.state.getStructureState(param1).level;
         var _loc3_:uint = this.state.getStructureState(param1).type;
         if(_loc2_ >= this.db.getStructureMaxLevel(_loc3_))
         {
            return STRUCTURE_UPGRADE_STATE_MAX_LEVEL;
         }
         if(this.isAnyStructureUpgrading())
         {
            return STRUCTURE_UPGRADE_STATE_OTHER_UPGRADE_IN_PROGRESS;
         }
         if(_loc3_ != BMBaseBuildingDB.STRUCTURE_TYPE_HQ && _loc2_ >= this.state.getStructureState(BMBaseBuildingDB.HQ_STRUCTURE_POSITION).level)
         {
            return STRUCTURE_UPGRADE_STATE_HQ_LEVEL_TOO_LOW;
         }
         if(this.db.getGoldRequiredToUpgradeStructure(_loc3_,_loc2_) > this.dataM.myProfile.gold)
         {
            return STRUCTURE_UPGRADE_STATE_NOT_ENOUGH_GOLD;
         }
         if(_loc3_ == BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE && this.getGoldPercentReadyToBeCollected(param1) >= MIN_MINED_GOLD_PERCENT_FOR_COLLECTION)
         {
            return STRUCTURE_UPGRADE_STATE_MUST_COLLECT_FIRST;
         }
         if(_loc3_ == BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY && this.getNumberOfItemsReadyToBeCollected(param1) > 0)
         {
            return STRUCTURE_UPGRADE_STATE_MUST_COLLECT_FIRST;
         }
         if(_loc3_ == BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY && this.getNumberOfItemsStillInQueue(param1) > 0)
         {
            return STRUCTURE_UPGRADE_STATE_CRAFT_IN_PROGRESS;
         }
         return STRUCTURE_UPGRADE_STATE_CAN_UPGRADE;
      }
      
      private function getNumberOfBuiltInstancesForStructure(param1:uint) : uint
      {
         var _loc3_:uint = 0;
         var _loc2_:uint = 0;
         for each(_loc3_ in this.state.getPositionsWithStructures())
         {
            if(this.state.getStructureState(_loc3_).type == param1)
            {
               _loc2_ += 1;
            }
         }
         return _loc2_;
      }
      
      public function getStructureName(param1:uint) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY:
               _loc2_ = this.languageM.getText("baseBuilding_structureItemFactory");
               break;
            case BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE:
               _loc2_ = this.languageM.getText("baseBuilding_structureGoldMine");
               break;
            case BMBaseBuildingDB.STRUCTURE_TYPE_HQ:
               _loc2_ = this.languageM.getText("baseBuilding_structureHeadquarters");
         }
         return _loc2_;
      }
      
      public function get now() : uint
      {
         return this.dataM.currentTime;
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private function get remoteM() : BMRemoteManager
      {
         return BMRemoteManager.getInstance();
      }
      
      private function get languageM() : BMLanguageManager
      {
         return BMLanguageManager.getInstance();
      }
      
      private function refreshNotifications() : void
      {
         if(BMNotificationsManager.hasInstance())
         {
            BMBaseBuildingNotificationHelper.updateLocalNotifications(BMNotificationsManager.getInstance());
         }
      }
      
      public function notifyBuildStructureSucceeded(param1:Object) : *
      {
         this.dataM.myProfile.gold -= this._pendingTransactionGoldCost;
         this.updateState(param1);
      }
      
      public function notifyUpgradeStructureSucceeded(param1:Object) : *
      {
         this.dataM.myProfile.gold -= this._pendingTransactionGoldCost;
         this.updateState(param1);
      }
      
      public function notifyCollectResourcesSucceeded(param1:Object, param2:BMRewardData) : *
      {
         if(param2.gold > 0)
         {
            this.dataM.myProfile.gold += param2.gold;
         }
         if(param2.hasItems)
         {
            this.dataM.handleGotRewardData(param2,BMDataManager.REGULAR_GACHA_MACHINE_ID,"BaseBuilding");
         }
         this.updateState(param1);
      }
      
      public function notifyAddToItemFactoryQueueSucceeded(param1:Object) : *
      {
         this.dataM.myProfile.gold -= this._pendingTransactionGoldCost;
         this.updateState(param1);
      }
      
      public function notifyRemoveFromItemFactoryQueueSucceeded(param1:Object) : *
      {
         this.dataM.myProfile.gold -= this._pendingTransactionGoldCost;
         this.updateState(param1);
      }
      
      public function notifySkipQueueWithTokensSucceeded(param1:Object, param2:BMRewardData) : *
      {
         this.dataM.myProfile.removeFromTokens(this._pendingTransactionTokenCost);
         if(param2 != null && param2.hasItems)
         {
            this.dataM.handleGotRewardData(param2,BMDataManager.REGULAR_GACHA_MACHINE_ID,"BaseBuilding");
         }
         this.updateState(param1);
      }
      
      public function notifySwapStructurePositionsSucceeded(param1:Object) : *
      {
         this.updateState(param1);
      }
      
      public function notifyBuildStructureFailed(param1:String) : *
      {
         this.handleGenericError(param1);
      }
      
      public function notifyUpgradeStructureFailed(param1:String) : *
      {
         this.handleGenericError(param1);
      }
      
      public function notifyCollectResourcesFailed(param1:String) : *
      {
         this.handleGenericError(param1);
      }
      
      public function notifyAddToItemFactoryQueueFailed(param1:String) : *
      {
         this.handleGenericError(param1);
      }
      
      public function notifyRemoveFromItemFactoryQueueFailed(param1:String) : *
      {
         this.handleGenericError(param1);
      }
      
      public function notifySkipQueueWithTokensFailed(param1:String) : *
      {
         this.handleGenericError(param1);
      }
      
      public function notifySwapStructurePositionsFailed(param1:String) : *
      {
         this.handleGenericError(param1);
      }
      
      public function handleGenericError(param1:String) : *
      {
         BMScreensManager.getInstance().screenConfirmation.displayCustomMessage(param1);
      }
      
      public function notifyOptInSucceeded(param1:Object) : *
      {
         var _loc2_:BMScreensManager = BMScreensManager.getInstance();
         _loc2_.forceBackToLoginScreen();
      }
      
      public function notifyOptInFailed(param1:String) : *
      {
         this.handleGenericError(param1);
         var _loc2_:BMScreensManager = BMScreensManager.getInstance();
         _loc2_.screenConfirmation.displayCustomMessage("<BR>ENABLING BASE FAILED");
      }
      
      public function showEnableBaseBuildingDialog() : void
      {
         var _loc1_:BMScreensManager = BMScreensManager.getInstance();
         _loc1_.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup7_baseBuilding);
         var _loc2_:String = this.languageM.getText("enableBaseBuilding_title");
         var _loc3_:String = this.languageM.getText("enableBaseBuilding_desc1");
         _loc3_ = this.dataM.replaceStringInText(_loc3_,"%COLOR%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
         _loc3_ = this.dataM.replaceStringInText(_loc3_,"%COLOREND%","</FONT>");
         var _loc4_:String = this.languageM.getText("enableBaseBuilding_desc2");
         _loc4_ = this.dataM.replaceStringInText(_loc4_,"%COLOR%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_EPIC_ITEM + "\'>");
         _loc4_ = this.dataM.replaceStringInText(_loc4_,"%COLOREND%","</FONT>");
         var _loc5_:String = this.languageM.getText("enableBaseBuilding_desc3");
         var _loc6_:String = this.languageM.getText("enableBaseBuilding_desc4");
         var _loc7_:String = this.languageM.getText("enableBaseBuilding_desc5");
         var _loc8_:String = _loc3_ + "<BR>" + _loc4_ + "<BR>" + _loc5_ + "<BR>" + "<BR>" + "<BR>" + _loc6_ + "<BR>" + _loc7_;
         var _loc9_:String = this.languageM.getText("enableBaseBuilding_enable");
         var _loc10_:String = this.languageM.getText("itemCards_noThanks");
         _loc1_.screenYesNoPopup.displayYesNoPopup(_loc2_,_loc8_,"",this.enableBaseBuildingAccepted,null,_loc9_,_loc10_);
      }
      
      private function enableBaseBuildingAccepted() : void
      {
         BMScreensManager.getInstance().screenConfirmation.displayQuestionOrNotification("pleaseWait");
         this.optInToFeature();
      }
      
      public function get shouldShowEnableBaseBuildingDialogInMainMenu() : Boolean
      {
         if(this.isOptInAllowed == false)
         {
            return false;
         }
         if(this.isEnabled)
         {
            return false;
         }
         if(this.dataM.userWasOfferedToEnableBaseBuilding == false)
         {
            this.dataM.userWasOfferedToEnableBaseBuilding = true;
            return true;
         }
         return false;
      }
   }
}

