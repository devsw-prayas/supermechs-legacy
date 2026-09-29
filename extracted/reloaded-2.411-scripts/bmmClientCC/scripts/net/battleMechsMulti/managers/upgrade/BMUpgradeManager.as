package net.battleMechsMulti.managers.upgrade
{
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMUpgradeManager extends BMBaseClass
   {
      
      private static var _instance:BMUpgradeManager;
      
      public var selectedPlayerItemID:Number = -1;
      
      private var _targetPlayerItemID:Number = -1;
      
      private var _sourcePlayerItemIDs:Array;
      
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
      
      public function doUpgarde(param1:Number, param2:Array) : void
      {
         TsLogger.log("BMUpgradeManager :: doUpgarde target:" + param1 + " source:" + param2.join(","));
         this._targetPlayerItemID = param1;
         this._sourcePlayerItemIDs = param2;
         if(tutorialM.isTutorialActive())
         {
            this.onUpgardeComplete();
            screensM.screenHangerBoostComplete.activateBackTutorialArrow();
         }
         else
         {
            remoteM.socketM.lobby_fusionMultipleItems(this._sourcePlayerItemIDs,this._targetPlayerItemID);
         }
      }
      
      public function onUpgardeComplete() : void
      {
         TsLogger.log("BMUpgradeManager :: onUpgardeComplete");
         this.updateUpgradeChanges(this._targetPlayerItemID,this._sourcePlayerItemIDs);
         this._targetPlayerItemID = -1;
         this._sourcePlayerItemIDs = null;
         if(screensM.isScreenOpened("screenHangerUpgrade"))
         {
            screensM.screenHangerUpgrade.onUpgradeSuccess();
         }
      }
      
      private function updateUpgradeChanges(param1:Number, param2:Array) : void
      {
         var _loc7_:uint = 0;
         var _loc8_:BMPlayerItemData = null;
         if(this._targetPlayerItemID == -1)
         {
            TsLogger.log("BMUpgradeManager :: updateUpgradeChanges error no item data");
         }
         var _loc3_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         var _loc4_:Number = this.calcSourcePower(param2);
         var _loc5_:BMItemUpgradeData = this.getUpgradeData(_loc3_.itemID,_loc3_.power,_loc4_);
         dataM.myProfile.gold -= _loc5_.cost;
         dataM.trackEvent("Fusion","activate");
         var _loc6_:uint = 0;
         while(_loc6_ < this._sourcePlayerItemIDs.length)
         {
            _loc7_ = uint(this._sourcePlayerItemIDs[_loc6_]);
            _loc8_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_);
            dataM.removePlayerItemData(dataM.player1PlayerID,_loc7_);
            _loc6_++;
         }
         _loc3_.itemID = _loc5_.newItemData.itemID;
         _loc3_.power = _loc5_.newPower;
         trace("targetPlayerItemData.itemID:" + _loc3_.itemID);
         trace("dataM.itemsDB[targetPlayerItemData.itemID]:" + dataM.itemsDB[_loc3_.itemID]);
      }
      
      public function getPlayerItemIds(param1:Array = null) : Array
      {
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:Array = [[],[],[],[],[],[]];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.items.length)
         {
            _loc7_ = _loc2_.items[_loc4_];
            _loc8_ = dataM.itemsDB[_loc7_.itemID];
            if(!(param1 != null && param1.indexOf(_loc7_.equipmentType) == -1))
            {
               if(_loc7_.equipped > 0)
               {
                  _loc3_[5].push(_loc7_.playerItemID);
               }
               else if(_loc8_.specialStatus == 5)
               {
                  _loc3_[0].push(_loc7_.playerItemID);
               }
               else
               {
                  _loc3_[_loc8_.specialStatus].push(_loc7_.playerItemID);
               }
            }
            _loc4_++;
         }
         var _loc5_:Array = new Array();
         var _loc6_:* = int(_loc3_.length - 1);
         while(_loc6_ >= 0)
         {
            _loc5_ = _loc5_.concat(_loc3_[_loc6_]);
            _loc6_--;
         }
         return _loc5_;
      }
      
      public function getPlayerItemIdsForTarget(param1:Array = null) : Array
      {
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:Array = [[],[],[],[],[],[]];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.items.length)
         {
            _loc7_ = _loc2_.items[_loc4_];
            _loc8_ = dataM.itemsDB[_loc7_.itemID];
            if(_loc7_.canBeUpgarded())
            {
               if(!(param1 != null && param1.indexOf(_loc7_.equipmentType) == -1))
               {
                  if(_loc7_.equipped > 0)
                  {
                     _loc3_[5].push(_loc7_.playerItemID);
                  }
                  else if(_loc8_.specialStatus == 5)
                  {
                     _loc3_[0].push(_loc7_.playerItemID);
                  }
                  else
                  {
                     _loc3_[_loc8_.specialStatus].push(_loc7_.playerItemID);
                  }
               }
            }
            _loc4_++;
         }
         var _loc5_:Array = new Array();
         var _loc6_:* = int(_loc3_.length - 1);
         while(_loc6_ >= 0)
         {
            _loc5_ = _loc5_.concat(_loc3_[_loc6_]);
            _loc6_--;
         }
         return _loc5_;
      }
      
      public function getPlayerItemIdsForBoost(param1:*, param2:Array = null) : Array
      {
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItemData = null;
         var _loc3_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc4_:Array = [[],[],[],[],[],[]];
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_.items.length)
         {
            _loc8_ = _loc3_.items[_loc5_];
            _loc9_ = dataM.itemsDB[_loc8_.itemID];
            if(!(param2 != null && param2.indexOf(_loc8_.equipmentType) == -1))
            {
               if(!(_loc8_.equipped > 0 && _loc8_.playerItemID != param1))
               {
                  if(_loc9_.specialStatus == 5)
                  {
                     _loc4_[0].push(_loc8_.playerItemID);
                  }
                  else
                  {
                     _loc4_[_loc9_.specialStatus].push(_loc8_.playerItemID);
                  }
               }
            }
            _loc5_++;
         }
         var _loc6_:Array = new Array();
         var _loc7_:* = int(_loc4_.length - 1);
         while(_loc7_ >= 0)
         {
            _loc6_ = _loc6_.concat(_loc4_[_loc7_]);
            _loc7_--;
         }
         return _loc6_;
      }
      
      public function getPlayerItemIdsForTransform(param1:*, param2:Array = null) : Array
      {
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc3_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc4_:BMItemData = _loc3_.getItemBy(param1);
         var _loc5_:Array = new Array();
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_.items.length)
         {
            _loc7_ = _loc3_.items[_loc6_];
            _loc8_ = dataM.itemsDB[_loc7_.itemID];
            if(!(param2 != null && param2.indexOf(_loc7_.equipmentType) == -1))
            {
               if(!(_loc7_.equipped > 0 && _loc7_.playerItemID != param1 || _loc8_.specialStatus != _loc4_.specialStatus))
               {
                  _loc5_.push(_loc7_.playerItemID);
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function getUpgradeData(param1:Number, param2:int, param3:int) : BMItemUpgradeData
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc4_:BMItemData = dataM.itemsDB[param1];
         var _loc5_:BMItemData = dataM.itemsDB[param1];
         var _loc6_:int = param3;
         var _loc7_:int = param2;
         var _loc8_:Number = 0;
         if(_loc4_.canEvolve())
         {
            _loc8_ = _loc4_.evolutionGoldCost;
            _loc4_ = dataM.itemsDB[_loc4_.upgradeToItemID];
            _loc7_ = 0;
         }
         else
         {
            while(!_loc4_.isMaxLevel() && _loc6_ > 0)
            {
               _loc5_ = dataM.itemsDB[_loc4_.upgradeToItemID];
               _loc10_ = _loc4_.powerToUpgrade - _loc7_;
               _loc11_ = _loc4_.powerToUpgrade - _loc4_.minPowerToHave;
               _loc12_ = _loc4_.upgradeGoldCost;
               if(_loc6_ < _loc10_)
               {
                  _loc7_ += _loc6_;
                  _loc8_ += _loc6_ / _loc11_ * _loc12_;
                  _loc6_ = 0;
               }
               else
               {
                  _loc4_ = _loc5_;
                  _loc6_ -= _loc10_;
                  _loc7_ = _loc5_.minPowerToHave;
                  _loc8_ += _loc10_ / _loc11_ * _loc12_;
               }
            }
         }
         return new BMItemUpgradeData(_loc4_,_loc7_,_loc8_);
      }
      
      public function calcSourcePower(param1:Array) : Number
      {
         var _loc5_:Number = NaN;
         var _loc6_:BMItemData = null;
         var _loc2_:BMPlayerData = dataM.myPlayerData;
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = Number(param1[_loc4_]);
            _loc6_ = _loc2_.getItemBy(_loc5_);
            _loc3_ += _loc6_.materialPowerContribution;
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getItemMaxLevel(param1:Number) : int
      {
         var _loc2_:BMItemData = dataM.itemsDB[param1];
         while(!_loc2_.isMaxLevel())
         {
            _loc2_ = dataM.itemsDB[_loc2_.upgradeToItemID];
         }
         return _loc2_.displayLevel;
      }
   }
}

