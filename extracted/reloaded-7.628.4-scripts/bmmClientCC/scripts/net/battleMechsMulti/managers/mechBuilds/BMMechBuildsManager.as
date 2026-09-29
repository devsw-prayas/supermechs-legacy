package net.battleMechsMulti.managers.mechBuilds
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMMechBuildsManager
   {
      
      private var _selectedBuildID:int = 0;
      
      private var buildsData:Array = new Array();
      
      private var dataCreated:Boolean = false;
      
      public const maxBuilds:uint = 9;
      
      private var _pendingParsData:Object;
      
      public function BMMechBuildsManager()
      {
         super();
      }
      
      public function get isEnabled() : Boolean
      {
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return false;
         }
         if(this.dataM.myProfile.level < int(this.dataM.getGeneralSetting("mechBuildsMinXPLevel","999")))
         {
            return false;
         }
         return true;
      }
      
      public function resetOnLogout() : void
      {
         this._selectedBuildID = 0;
         this.buildsData = new Array();
         this.dataCreated = false;
      }
      
      public function addPendingParseData(param1:Object) : void
      {
         this._pendingParsData = param1;
      }
      
      public function parseDataIfPending() : void
      {
         if(this._pendingParsData == null)
         {
            return;
         }
         this.parseData(this._pendingParsData);
         this._pendingParsData = null;
      }
      
      public function parseData(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMMechBuildData = null;
         var _loc5_:Object = null;
         if(param1 == null)
         {
            return;
         }
         if(param1 == false)
         {
            return;
         }
         this.selectedBuildID = param1.selectedBuildID;
         var _loc4_:* = param1.builds.length;
         if(_loc4_ > this.maxBuilds)
         {
            trace("Warning: mech builds data has too many items: " + _loc4_);
            trace("> > > >  inserting only first 9");
            _loc4_ = this.maxBuilds;
         }
         this.buildsData = new Array();
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc5_ = param1.builds[_loc2_];
            _loc3_ = new BMMechBuildData(_loc5_.name,_loc5_.mechStructures);
            this.buildsData.push(_loc3_);
            _loc2_++;
         }
         this.dataCreated = true;
         if(this.buildsData.length == this.maxBuilds)
         {
            return;
         }
         _loc2_ = this.buildsData.length;
         while(_loc2_ < this.maxBuilds)
         {
            _loc3_ = new BMMechBuildData("",new Array());
            this.buildsData.push(_loc3_);
            _loc2_++;
         }
      }
      
      public function migrateMechs456ToBuild2() : Boolean
      {
         var _loc2_:BMMechStructure = null;
         var _loc3_:uint = 0;
         var _loc7_:BMPlayerItemData = null;
         var _loc1_:Boolean = false;
         _loc3_ = 4;
         while(_loc3_ <= 6)
         {
            _loc2_ = this.dataM.myPlayerData.mechStructures[_loc3_];
            if(_loc2_.hasAtLeastOneItem())
            {
               _loc1_ = true;
               break;
            }
            _loc3_++;
         }
         if(_loc1_ == false)
         {
            return false;
         }
         TsLogger.log("ALERT: mech builds manager - starting mechs 4 5 6 migration");
         this.createLocalBuildsDataIfNeeded();
         var _loc4_:BMMechBuildData = this.buildsData[1];
         var _loc5_:Boolean = true;
         if(_loc4_.isEmpty == false)
         {
            TsLogger.log("ALERT: mech builds manager - team 2 is not empty, cannot migrate mechs 4 5 6");
            _loc5_ = false;
         }
         if(_loc5_)
         {
            this.updateSpecificBuildForSpecificMechIDs(1,[4,5,6]);
            TsLogger.log("ALERT: mech builds manager - migrating mechs 4 5 6 to team 2");
         }
         TsLogger.log("ALERT: mech builds manager - unequipping all items from mechs 4 5 6");
         var _loc6_:uint = 0;
         while(_loc6_ < this.dataM.myPlayerData.items.length)
         {
            _loc7_ = this.dataM.myPlayerData.items[_loc6_];
            if(_loc7_.equipmentID >= 4)
            {
               _loc7_.resetEquippedData();
            }
            _loc6_++;
         }
         _loc2_ = this.dataM.myPlayerData.mechStructures[4];
         _loc2_.resetStructure();
         _loc2_ = this.dataM.myPlayerData.mechStructures[5];
         _loc2_.resetStructure();
         _loc2_ = this.dataM.myPlayerData.mechStructures[6];
         _loc2_.resetStructure();
         this.dataM.myPlayerData.updateMechsWeight();
         return true;
      }
      
      public function getBuildData(param1:uint) : BMMechBuildData
      {
         var _loc4_:BMMechStructure = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItemData = null;
         this.createLocalBuildsDataIfNeeded();
         var _loc2_:BMMechBuildData = this.buildsData[param1];
         var _loc3_:uint = 1;
         while(_loc3_ <= 3)
         {
            _loc4_ = _loc2_.mechStructures[_loc3_ - 1];
            _loc5_ = 0;
            while(_loc5_ < BMMechBuildData.arrayStructure.length)
            {
               _loc6_ = BMMechBuildData.arrayStructure[_loc5_];
               _loc7_ = uint(_loc4_[_loc6_]);
               if(_loc7_ != 0)
               {
                  _loc8_ = this.dataM.getPlayerItemData(this.dataM.ONLINE_PLAYER_ID,_loc7_);
                  if(_loc8_ == null)
                  {
                     _loc4_[_loc6_] = 0;
                  }
                  _loc9_ = this.dataM.itemsDB[_loc8_.itemID];
                  if(_loc6_.indexOf(_loc9_.type) == -1)
                  {
                     _loc4_[_loc6_] = 0;
                  }
               }
               _loc5_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function isItemInAnyBuild(param1:uint) : Boolean
      {
         var _loc3_:BMMechBuildData = null;
         this.createLocalBuildsDataIfNeeded();
         var _loc2_:uint = 0;
         while(_loc2_ < this.buildsData.length)
         {
            _loc3_ = this.buildsData[_loc2_];
            if(!_loc3_.isEmpty)
            {
               if(_loc3_.availablePlayerItemIDs.indexOf(param1) > -1)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getBuildsWith3ReadyMechs() : Array
      {
         var _loc3_:BMMechBuildData = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < this.buildsData.length)
         {
            _loc3_ = this.buildsData[_loc2_];
            _loc4_ = 0;
            _loc5_ = 1;
            while(_loc5_ <= 3)
            {
               if(this.dataM.isMechStructureReadyForBattle(_loc3_.mechStructures[_loc5_ - 1]))
               {
                  _loc4_ += 1;
               }
               _loc5_++;
            }
            if(_loc4_ == 3)
            {
               _loc1_.push(_loc2_);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function createLocalBuildsDataIfNeeded() : void
      {
         var _loc4_:BMMechStructure = null;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         if(this.dataCreated)
         {
            return;
         }
         var _loc1_:Object = new Object();
         _loc1_.selectedBuildID = 0;
         _loc1_.builds = new Array();
         var _loc2_:Object = new Object();
         _loc2_.name = "";
         _loc2_.mechStructures = new Array();
         var _loc3_:uint = 1;
         while(_loc3_ <= 3)
         {
            _loc4_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
            _loc4_.initialize(this.dataM.ONLINE_PLAYER_ID,_loc3_);
            _loc4_.copyMechStructure(this.dataM.myPlayerData.mechStructures[_loc3_]);
            _loc5_ = new Array();
            _loc6_ = 0;
            while(_loc6_ < BMMechBuildData.arrayStructure.length)
            {
               _loc7_ = BMMechBuildData.arrayStructure[_loc6_];
               _loc5_.push(_loc4_[_loc7_]);
               _loc6_++;
            }
            _loc2_.mechStructures.push(_loc5_);
            _loc3_++;
         }
         _loc1_.builds.push(_loc2_);
         this.parseData(_loc1_);
      }
      
      public function getBuildName(param1:uint, param2:Boolean = false) : String
      {
         this.createLocalBuildsDataIfNeeded();
         var _loc3_:BMMechBuildData = this.buildsData[param1];
         var _loc4_:String = _loc3_.buildName;
         if(_loc4_ == "" && param2)
         {
            _loc4_ = BMLanguageManager.getInstance().getText("mechBuilds_buildX");
            _loc4_ = this.dataM.replaceStringInText(_loc4_,"%NUMBER%",String(param1 + 1));
         }
         return _loc4_;
      }
      
      public function renameBuild(param1:uint, param2:String) : void
      {
         this.createLocalBuildsDataIfNeeded();
         var _loc3_:BMMechBuildData = this.buildsData[param1];
         _loc3_.buildName = param2;
      }
      
      public function exportData() : Object
      {
         var _loc3_:BMMechBuildData = null;
         var _loc1_:Object = new Object();
         _loc1_.selectedBuildID = this.selectedBuildID;
         _loc1_.builds = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < this.buildsData.length)
         {
            _loc3_ = this.buildsData[_loc2_];
            if(_loc3_.isEmpty)
            {
               _loc1_.builds.push({
                  "name":_loc3_.buildName,
                  "mechStructures":[]
               });
            }
            else
            {
               _loc1_.builds.push({
                  "name":_loc3_.buildName,
                  "mechStructures":_loc3_.getMechStructuresArray()
               });
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function updateCurrentBuild() : void
      {
         this.createLocalBuildsDataIfNeeded();
         this.updateSpecificBuildForSpecificMechIDs(this.selectedBuildID,[1,2,3]);
      }
      
      private function updateSpecificBuildForSpecificMechIDs(param1:uint, param2:Array) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:BMMechStructure = null;
         var _loc8_:BMMechStructure = null;
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Number = NaN;
         var _loc3_:BMMechBuildData = this.getBuildData(param1);
         var _loc4_:uint = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = uint(param2[_loc4_]);
            _loc6_ = _loc5_ - 1;
            if(_loc6_ >= 3)
            {
               _loc6_ -= 3;
            }
            _loc7_ = this.dataM.myPlayerData.mechStructures[_loc5_];
            _loc8_ = _loc3_.mechStructures[_loc6_];
            _loc9_ = 0;
            while(_loc9_ < BMMechBuildData.arrayStructure.length)
            {
               _loc10_ = BMMechBuildData.arrayStructure[_loc9_];
               _loc11_ = uint(_loc8_[_loc10_]);
               _loc12_ = uint(_loc7_[_loc10_]);
               _loc8_[_loc10_] = _loc12_;
               _loc13_ = _loc3_.availablePlayerItemIDs.indexOf(_loc11_);
               if(_loc13_ > -1)
               {
                  _loc3_.availablePlayerItemIDs.splice(_loc13_,1);
               }
               _loc3_.availablePlayerItemIDs.push(_loc12_);
               _loc9_++;
            }
            _loc4_++;
         }
         _loc3_.cleanBuildFromDeletedItems();
      }
      
      public function loadSelectedBuild() : void
      {
         var _loc1_:BMPlayerItemData = null;
         var _loc2_:uint = 0;
         var _loc5_:BMMechStructure = null;
         var _loc6_:BMMechStructure = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:String = null;
         _loc2_ = 0;
         while(_loc2_ < this.dataM.myPlayerData.items.length)
         {
            _loc1_ = this.dataM.myPlayerData.items[_loc2_];
            _loc1_.resetEquippedData();
            _loc2_++;
         }
         var _loc3_:BMMechBuildData = this.getBuildData(this.selectedBuildID);
         var _loc4_:uint = 1;
         while(_loc4_ <= 3)
         {
            _loc5_ = this.dataM.myPlayerData.mechStructures[_loc4_];
            _loc5_.resetStructure();
            _loc6_ = _loc3_.mechStructures[_loc4_ - 1];
            _loc2_ = 0;
            while(_loc2_ < BMMechBuildData.arrayStructure.length)
            {
               _loc7_ = BMMechBuildData.arrayStructure[_loc2_];
               _loc8_ = uint(_loc6_[_loc7_]);
               if(_loc8_ != 0)
               {
                  _loc1_ = this.dataM.getPlayerItemData(this.dataM.ONLINE_PLAYER_ID,_loc8_);
                  if(_loc1_ != null)
                  {
                     _loc5_[_loc7_] = _loc8_;
                     _loc1_.equipped = _loc4_;
                     _loc9_ = _loc7_.substr(_loc7_.length - 1,1);
                     _loc10_ = "12345678";
                     if(_loc10_.indexOf(_loc9_) != -1)
                     {
                        _loc1_.equipmentID = int(_loc9_);
                     }
                  }
               }
               _loc2_++;
            }
            _loc4_++;
         }
         this.dataM.myPlayerData.updateMechsWeight();
      }
      
      public function cloneBuild(param1:uint, param2:uint) : void
      {
         var _loc6_:BMMechStructure = null;
         var _loc7_:BMMechStructure = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc3_:BMMechBuildData = this.getBuildData(param1);
         var _loc4_:BMMechBuildData = this.getBuildData(param2);
         _loc4_.buildName = _loc3_.buildName;
         var _loc5_:uint = 1;
         while(_loc5_ <= 3)
         {
            _loc6_ = _loc3_.mechStructures[_loc5_ - 1];
            _loc7_ = _loc4_.mechStructures[_loc5_ - 1];
            _loc8_ = 0;
            while(_loc8_ < BMMechBuildData.arrayStructure.length)
            {
               _loc9_ = BMMechBuildData.arrayStructure[_loc8_];
               _loc7_[_loc9_] = _loc6_[_loc9_];
               _loc8_++;
            }
            _loc5_++;
         }
      }
      
      public function cleanAllBuildsFromDeletedItems() : void
      {
         var _loc2_:BMMechBuildData = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.buildsData.length)
         {
            _loc2_ = this.buildsData[_loc1_];
            _loc2_.cleanBuildFromDeletedItems();
            _loc1_++;
         }
      }
      
      public function get selectedBuildID() : int
      {
         return this._selectedBuildID;
      }
      
      public function set selectedBuildID(param1:int) : void
      {
         this._selectedBuildID = param1;
      }
      
      public function getMechStructureWeight(param1:uint, param2:uint) : uint
      {
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:BMItemData = null;
         var _loc3_:uint = 0;
         var _loc4_:BMMechBuildData = this.getBuildData(param1);
         var _loc5_:BMMechStructure = _loc4_.mechStructures[param2 - 1];
         var _loc6_:uint = 0;
         while(_loc6_ < BMMechBuildData.arrayStructure.length)
         {
            _loc7_ = BMMechBuildData.arrayStructure[_loc6_];
            _loc8_ = uint(_loc5_[_loc7_]);
            if(_loc8_ != 0)
            {
               _loc9_ = this.dataM.getPlayerItemData(this.dataM.ONLINE_PLAYER_ID,_loc8_);
               _loc10_ = this.dataM.itemsDB[_loc9_.itemID];
               _loc3_ += _loc10_.weight;
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private function get screensM() : BMScreensManager
      {
         return BMScreensManager.getInstance();
      }
   }
}

