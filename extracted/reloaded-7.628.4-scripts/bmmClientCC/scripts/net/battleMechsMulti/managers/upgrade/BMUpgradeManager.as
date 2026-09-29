package net.battleMechsMulti.managers.upgrade
{
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.unlockedMechSlotsResolver.BMUnlockedMechSlotsResolver;
   
   public class BMUpgradeManager extends BMBaseClass
   {
      
      private static var _instance:BMUpgradeManager;
      
      internal static const UPGRADE_ITEMS_TYPE_DEFAULT:uint = 0;
      
      internal static const UPGRADE_ITEMS_TYPE_TARGET:uint = 1;
      
      internal static const UPGRADE_ITEMS_TYPE_BOOST:uint = 2;
      
      public var selectedPlayerItemID:Number = -1;
      
      private var _targetPlayerItemID:Number = -1;
      
      private var _sourcePlayerItemIDs:Array;
      
      private const _transformForbiddenItemsSubType:Array = ["power"];
      
      public function BMUpgradeManager()
      {
         super();
         generateSingletonClassesPointers("");
      }
      
      public static function getInstance() : BMUpgradeManager
      {
         if(_instance == null)
         {
            _instance = new BMUpgradeManager();
         }
         return _instance;
      }
      
      public static function gi() : BMUpgradeManager
      {
         return getInstance();
      }
      
      public function doUpgarde(param1:Number, param2:Array, param3:Boolean, param4:uint) : void
      {
         var _loc6_:BMPotentialBoostInfo = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:BMItemData = null;
         var _loc11_:BMItemData = null;
         TsLogger.log("BMUpgradeManager :: doUpgarde target:" + param1 + " source:" + param2.join(","));
         this._targetPlayerItemID = param1;
         this._sourcePlayerItemIDs = param2;
         var _loc5_:Boolean = false;
         if(tutorialM.isTutorialActive())
         {
            this.onUpgardeComplete();
            screensM.screenHangerBoostComplete.activateBackTutorialArrow();
         }
         else
         {
            remoteM.socketM.lobby_fusionMultipleItems(this._sourcePlayerItemIDs,this._targetPlayerItemID);
            if(dataM.gameOfWhalesM.isEnabled)
            {
               _loc5_ = true;
            }
         }
         if(_loc5_ == false)
         {
            return;
         }
         if(param3)
         {
            _loc6_ = this.getPotentialBoostInfo(param1,param2);
            _loc7_ = 0;
            _loc8_ = 0;
            while(_loc8_ < param2.length)
            {
               _loc9_ = uint(param2[_loc8_]);
               _loc10_ = dataM.itemsDB[dataM.getPlayerItemData(dataM.player1PlayerID,_loc9_).itemID];
               _loc7_ += _loc10_.materialPowerContribution;
               _loc8_++;
            }
            dataM.gameOfWhalesM.usedBoost(param4,_loc7_);
         }
         else
         {
            _loc11_ = dataM.itemsDB[dataM.getPlayerItemData(dataM.player1PlayerID,param1).itemID];
            dataM.gameOfWhalesM.usedTransform(param4,_loc11_.specialStatus + 1);
         }
      }
      
      public function onUpgardeComplete() : void
      {
         TsLogger.log("BMUpgradeManager :: onUpgardeComplete");
         this.updateUpgradeChanges(this._targetPlayerItemID,this._sourcePlayerItemIDs);
         this._targetPlayerItemID = -1;
         this._sourcePlayerItemIDs = null;
         if(screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE))
         {
            screensM.screenHangerUpgrade.onUpgradeSuccess();
         }
      }
      
      private function updateUpgradeChanges(param1:Number, param2:Array) : void
      {
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItemData = null;
         var _loc10_:uint = 0;
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMItemData = null;
         if(this._targetPlayerItemID == -1)
         {
            TsLogger.log("BMUpgradeManager :: updateUpgradeChanges error no item data");
         }
         var _loc3_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         var _loc4_:Number = this.calcSourcePower(param1,param2);
         var _loc5_:Boolean = false;
         if(param2.length > 0)
         {
            _loc8_ = dataM.getPlayerItemData(dataM.player1PlayerID,param2[0]);
            _loc9_ = dataM.itemsDB[_loc8_.itemID];
            if(_loc9_.isAscensionKit)
            {
               _loc5_ = true;
            }
         }
         var _loc6_:BMItemUpgradeData = this.getUpgradeData(_loc3_.itemID,_loc3_.power,_loc4_,false,_loc5_);
         dataM.myProfile.gold -= _loc6_.cost;
         dataM.trackEvent(3,"Fusion","activate");
         var _loc7_:uint = 0;
         while(_loc7_ < this._sourcePlayerItemIDs.length)
         {
            _loc10_ = uint(this._sourcePlayerItemIDs[_loc7_]);
            _loc11_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc10_);
            _loc12_ = dataM.itemsDB[_loc11_.itemID];
            if(_loc12_.isColorKit)
            {
               _loc3_.colorID = Number(_loc12_.animation);
            }
            dataM.removePlayerItemData(dataM.player1PlayerID,_loc10_);
            _loc7_++;
         }
         _loc3_.itemID = _loc6_.newItemData.itemID;
         _loc3_.power = _loc6_.newPower;
      }
      
      public function getPotentialBoostInfo(param1:uint, param2:Array, param3:Boolean = false, param4:Boolean = false) : BMPotentialBoostInfo
      {
         var _loc14_:uint = 0;
         var _loc15_:BMPlayerItemData = null;
         var _loc16_:BMItemData = null;
         var _loc17_:Boolean = false;
         var _loc18_:int = 0;
         var _loc19_:BMItemUpgradeData = null;
         var _loc5_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         var _loc6_:BMItemData = dataM.itemsDB[_loc5_.itemID];
         var _loc7_:uint = _loc5_.itemID;
         var _loc8_:uint = _loc5_.power;
         var _loc9_:uint = 0;
         var _loc10_:uint = uint(_loc6_.displayLevel);
         var _loc11_:Array = new Array();
         param2.sort(this.orderRecommendedItems);
         var _loc12_:uint = 0;
         while(_loc12_ < param2.length)
         {
            _loc14_ = uint(param2[_loc12_]);
            _loc15_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc14_);
            _loc16_ = dataM.itemsDB[_loc15_.itemID];
            _loc17_ = true;
            _loc18_ = Math.round(_loc16_.materialPowerContribution * this.getMaterialPowerContributionMultiplier(dataM.itemsDB[_loc7_],_loc16_));
            _loc19_ = this.getUpgradeData(_loc7_,_loc8_,_loc18_,_loc17_);
            if(!(param3 == false && _loc9_ + _loc19_.cost > dataM.myProfile.gold))
            {
               if(_loc14_ != param1)
               {
                  _loc9_ += _loc19_.cost;
                  _loc7_ = uint(_loc19_.newItemData.itemID);
                  _loc8_ = uint(_loc19_.newPower);
                  _loc11_.push(_loc14_);
                  _loc10_ = uint(_loc19_.newItemData.displayLevel);
                  if(_loc19_.newItemData.isMaxLevel())
                  {
                     break;
                  }
               }
            }
            _loc12_++;
         }
         if(param4)
         {
            _loc11_.sort(this.orderRecommendedItemsDescending);
         }
         return new BMPotentialBoostInfo(_loc11_,_loc10_);
      }
      
      private function orderRecommendedItems(param1:uint, param2:uint) : int
      {
         var _loc3_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         var _loc4_:BMItemData = dataM.itemsDB[_loc3_.itemID];
         var _loc5_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param2);
         var _loc6_:BMItemData = dataM.itemsDB[_loc5_.itemID];
         if(_loc4_.materialPowerContribution > _loc6_.materialPowerContribution)
         {
            return -1;
         }
         if(_loc4_.materialPowerContribution < _loc6_.materialPowerContribution)
         {
            return 1;
         }
         return 0;
      }
      
      private function orderRecommendedItemsDescending(param1:uint, param2:uint) : int
      {
         return -this.orderRecommendedItems(param1,param2);
      }
      
      public function getPlayerItemIdsSub(param1:uint = 0, param2:Array = null, param3:uint = 0) : Array
      {
         var _loc6_:uint = 0;
         var _loc10_:BMPlayerItemData = null;
         var _loc11_:BMItemData = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Object = null;
         var _loc16_:int = 0;
         var _loc17_:BMPlayerItemData = null;
         var _loc18_:BMItemData = null;
         var _loc19_:int = 0;
         var _loc4_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc5_:Array = [[],[],[],[],[],[],[],[],[],[],[],[]];
         var _loc7_:uint = BMUnlockedMechSlotsResolver.getNumberOfMechsUnlocked();
         _loc6_ = 0;
         for(; _loc6_ < _loc4_.items.length; _loc6_++)
         {
            _loc10_ = _loc4_.items[_loc6_];
            _loc11_ = dataM.itemsDB[_loc10_.itemID];
            if(param1 == UPGRADE_ITEMS_TYPE_DEFAULT || param1 == UPGRADE_ITEMS_TYPE_TARGET || param1 == UPGRADE_ITEMS_TYPE_BOOST)
            {
               if(param2 != null && param2.indexOf(_loc10_.equipmentType) == -1)
               {
                  continue;
               }
            }
            if(param1 == UPGRADE_ITEMS_TYPE_TARGET)
            {
               if(!_loc11_.canBeUpgarded)
               {
                  continue;
               }
               if(dataM.myProfile.level <= dataM.getMaxPlayerLevelToOnlyAllowBoostingEquippedItems())
               {
                  if(_loc10_.equipped == 0)
                  {
                     continue;
                  }
               }
               if(_loc10_.equipped > _loc7_)
               {
                  continue;
               }
            }
            if(param1 == UPGRADE_ITEMS_TYPE_BOOST)
            {
               _loc17_ = dataM.getPlayerItemData(dataM.player1PlayerID,param3);
               _loc18_ = dataM.itemsDB[_loc17_.itemID];
               if(_loc10_.equipped > 0 && _loc10_.playerItemID != param3)
               {
                  continue;
               }
               if(_loc18_.isEnhancer)
               {
                  if(_loc11_.isAscensionKit)
                  {
                     continue;
                  }
                  if(_loc11_.isEnhancer == false && _loc11_.isEnhancerKit == false)
                  {
                     continue;
                  }
                  if(_loc11_.isEnhancer && _loc11_.enhancerCategory != _loc18_.enhancerCategory)
                  {
                     continue;
                  }
                  if(_loc11_.isEnhancerKit && _loc11_.enhancerKitCategory != _loc18_.enhancerCategory)
                  {
                     continue;
                  }
               }
               if(_loc18_.isEnhancerKit)
               {
                  if(_loc11_.isEnhancerKit == false)
                  {
                     continue;
                  }
                  if(_loc11_.enhancerKitCategory != _loc18_.enhancerKitCategory)
                  {
                     continue;
                  }
               }
            }
            _loc12_ = _loc11_.isDeprecated ? 0 : 1;
            _loc13_ = _loc11_.specialStatus;
            if(_loc11_.specialStatus == ItemRarityResolver.RARITY_PERK)
            {
               _loc13_ = 0;
            }
            _loc14_ = 0;
            if(_loc10_.equipped > 0)
            {
               _loc14_ = 100 - _loc10_.equipped;
            }
            _loc15_ = {
               "chainID":_loc11_.chainID,
               "displayLevel":_loc11_.displayLevel,
               "playerItemID":_loc10_.playerItemID,
               "isDeprecated":_loc12_,
               "specialStatus":_loc13_,
               "equippedValue":_loc14_
            };
            if(_loc11_.isDeprecated)
            {
               _loc16_ = 0;
            }
            else if(_loc10_.equipped > 0 || _loc11_.isColorKit)
            {
               _loc16_ = 5;
            }
            else
            {
               _loc16_ = _loc13_;
            }
            _loc5_[_loc16_].push(_loc15_);
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc5_[_loc6_].sortOn(["isDeprecated","specialStatus","displayLevel","equippedValue","chainID"],Array.NUMERIC | Array.DESCENDING);
            _loc6_++;
         }
         var _loc8_:Array = new Array();
         var _loc9_:* = int(_loc5_.length - 1);
         while(_loc9_ >= 0)
         {
            _loc19_ = 0;
            while(_loc19_ < _loc5_[_loc9_].length)
            {
               _loc8_.push(_loc5_[_loc9_][_loc19_].playerItemID);
               _loc19_++;
            }
            _loc9_--;
         }
         return _loc8_;
      }
      
      public function getPlayerItemIds(param1:Array = null) : Array
      {
         return this.getPlayerItemIdsSub(UPGRADE_ITEMS_TYPE_DEFAULT,param1);
      }
      
      public function getPlayerItemIdsForTarget(param1:Array = null) : Array
      {
         return this.getPlayerItemIdsSub(UPGRADE_ITEMS_TYPE_TARGET,param1);
      }
      
      public function getPlayerItemIdsColoringKits(param1:Array = null) : Array
      {
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.items.length)
         {
            _loc5_ = _loc2_.items[_loc4_];
            _loc6_ = dataM.itemsDB[_loc5_.itemID];
            if(_loc6_.isColorKit)
            {
               _loc3_.push(_loc5_.playerItemID);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getPlayerItemIdsForBoost(param1:uint, param2:Array = null) : Array
      {
         return this.getPlayerItemIdsSub(UPGRADE_ITEMS_TYPE_BOOST,param2,param1);
      }
      
      public function getPlayerItemIdsForTransform(param1:*, param2:Array = null) : Array
      {
         var _loc6_:uint = 0;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItemData = null;
         var _loc10_:int = 0;
         var _loc3_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc4_:BMItemData = _loc3_.getItemBy(param1);
         var _loc5_:Array = new Array();
         _loc6_ = 0;
         for(; _loc6_ < _loc3_.items.length; _loc6_++)
         {
            _loc8_ = _loc3_.items[_loc6_];
            _loc9_ = dataM.itemsDB[_loc8_.itemID];
            if(this._transformForbiddenItemsSubType.indexOf(_loc9_.subType) == -1)
            {
               if(!(param2 != null && param2.indexOf(_loc8_.equipmentType) == -1))
               {
                  if(!(_loc8_.equipped > 0 && _loc8_.playerItemID != param1))
                  {
                     if(_loc4_.specialStatus == ItemRarityResolver.RARITY_MYTHICAL)
                     {
                        if(_loc9_.isAscensionKit == false)
                        {
                           continue;
                        }
                        if(_loc4_.naturalTier != _loc9_.specialStatus)
                        {
                           if(!(_loc4_.naturalTier == ItemRarityResolver.RARITY_MYTHICAL && _loc9_.specialStatus == ItemRarityResolver.RARITY_LEGENDARY))
                           {
                              continue;
                           }
                        }
                     }
                     else
                     {
                        if(_loc9_.specialStatus != _loc4_.specialStatus)
                        {
                           continue;
                        }
                        if(_loc9_.isAscensionKit)
                        {
                           continue;
                        }
                     }
                     _loc10_ = _loc9_.isDeprecated ? 0 : 1;
                     _loc5_.push({
                        "chainID":_loc9_.chainID,
                        "displayLevel":_loc9_.displayLevel,
                        "playerItemID":_loc8_.playerItemID,
                        "isDeprecated":_loc10_
                     });
                  }
               }
            }
         }
         _loc5_.sortOn(["isDeprecated","chainID","displayLevel"],Array.NUMERIC | Array.DESCENDING);
         var _loc7_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_.push(_loc5_[_loc6_].playerItemID);
            _loc6_++;
         }
         return _loc7_;
      }
      
      public function getPlayerItemIdsForEnhance(param1:uint) : Array
      {
         var _loc5_:uint = 0;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:BMItemData = _loc2_.getItemBy(param1);
         var _loc4_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < _loc2_.items.length)
         {
            _loc7_ = _loc2_.items[_loc5_];
            if(_loc7_.equipped <= 0)
            {
               _loc8_ = dataM.itemsDB[_loc7_.itemID];
               if(_loc8_.isEnhancer != false)
               {
                  _loc4_.push({
                     "chainID":_loc8_.chainID,
                     "displayLevel":_loc8_.displayLevel,
                     "playerItemID":_loc7_.playerItemID
                  });
               }
            }
            _loc5_++;
         }
         _loc4_.sortOn(["chainID","displayLevel"],Array.NUMERIC | Array.DESCENDING);
         var _loc6_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_.push(_loc4_[_loc5_].playerItemID);
            _loc5_++;
         }
         return _loc6_;
      }
      
      public function getUpgradeData(param1:Number, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false) : BMItemUpgradeData
      {
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc6_:BMItemData = dataM.itemsDB[param1];
         var _loc7_:BMItemData = dataM.itemsDB[param1];
         var _loc8_:int = param3;
         var _loc9_:int = param2;
         var _loc10_:Number = 0;
         if(_loc6_.canEvolve() && param4 == false)
         {
            _loc10_ = _loc6_.evolutionGoldCost;
            _loc6_ = dataM.itemsDB[_loc6_.upgradeToItemID];
            _loc9_ = 0;
         }
         else if(_loc6_.canAscend() && param5)
         {
            _loc10_ = _loc6_.ascensionGoldCost;
            _loc6_ = dataM.itemsDB[_loc6_.upgradeToItemID];
            _loc9_ = 0;
         }
         else
         {
            while(!_loc6_.isMaxLevel() && _loc8_ > 0)
            {
               _loc7_ = dataM.itemsDB[_loc6_.upgradeToItemID];
               _loc12_ = _loc6_.powerToUpgrade - _loc9_;
               _loc13_ = _loc6_.powerToUpgrade - _loc6_.minPowerToHave;
               _loc14_ = _loc6_.upgradeGoldCost;
               if(_loc8_ < _loc12_)
               {
                  _loc9_ += _loc8_;
                  _loc10_ += _loc8_ / _loc13_ * _loc14_;
                  _loc8_ = 0;
               }
               else
               {
                  _loc6_ = _loc7_;
                  _loc8_ -= _loc12_;
                  _loc9_ = _loc7_.minPowerToHave;
                  _loc10_ += _loc12_ / _loc13_ * _loc14_;
               }
            }
         }
         return new BMItemUpgradeData(_loc6_,_loc9_,Math.ceil(_loc10_));
      }
      
      private function getMaterialPowerContributionMultiplier(param1:BMItemData, param2:BMItemData) : Number
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:Number = 1;
         if(dataM.boostConfigDB != null)
         {
            _loc4_ = uint(param1.getItemElement());
            _loc5_ = uint(param2.getItemElement());
            if(_loc5_ != BMItemData.ELEMENT_NONE && _loc5_ == _loc4_)
            {
               _loc3_ += dataM.boostConfigDB.elementContributionBonus;
            }
            if(param2.type == param1.type && param2.subType == param1.subType)
            {
               _loc3_ += dataM.boostConfigDB.subtypeContributionBonus;
            }
         }
         if(!tutorialM.isTutorialActive())
         {
            _loc3_ *= dataM.getGeneralSetting("materialPowerContributionMultiplier",1);
         }
         return _loc3_;
      }
      
      public function calcSourcePower(param1:uint, param2:Array) : Number
      {
         var _loc7_:uint = 0;
         var _loc8_:BMItemData = null;
         var _loc9_:Number = NaN;
         var _loc3_:BMPlayerData = dataM.myPlayerData;
         var _loc4_:BMItemData = _loc3_.getItemBy(param1);
         var _loc5_:Number = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param2.length)
         {
            _loc7_ = uint(param2[_loc6_]);
            _loc8_ = _loc3_.getItemBy(_loc7_);
            _loc9_ = this.getMaterialPowerContributionMultiplier(_loc4_,_loc8_);
            _loc5_ += Math.round(_loc8_.materialPowerContribution * _loc9_);
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function getItemMaxLevel(param1:Number) : int
      {
         var _loc2_:BMItemData = dataM.itemsDB[param1];
         if(tutorialM.isTutorialActive())
         {
            if(_loc2_.specialStatus == 0)
            {
               return 10;
            }
            return 20;
         }
         while(!_loc2_.isMaxLevel())
         {
            _loc2_ = dataM.itemsDB[_loc2_.upgradeToItemID];
         }
         return _loc2_.displayLevel;
      }
   }
}

