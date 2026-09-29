package net.battleMechsMulti.mobiles
{
   import net.tacticsoft.utils.SafeInt;
   
   public class BMPlayerData extends BMBaseClass
   {
      
      private var _playerID:uint;
      
      public var items:Array = new Array();
      
      public var existingItemsIDs:Object = new Object();
      
      public var playerItemIDCounter:uint = 0;
      
      private var _AP:SafeInt = new SafeInt();
      
      private var _APMax:SafeInt = new SafeInt();
      
      public var battlePlayerID:Number = 0;
      
      public var mechWeight:Number = 0;
      
      public var mechStructures:Array = new Array();
      
      public var selectedMechID:uint = 1;
      
      public var mechsDestroyed:uint = 0;
      
      public var switchMech1Uses:uint;
      
      public var switchMech2Uses:uint;
      
      public var switchMech3Uses:uint;
      
      public function BMPlayerData()
      {
         super();
      }
      
      public function get AP() : int
      {
         return this._AP.value;
      }
      
      public function set AP(param1:int) : void
      {
         this._AP.value = param1;
      }
      
      public function get APMax() : int
      {
         return this._APMax.value;
      }
      
      public function set APMax(param1:int) : void
      {
         this._APMax.value = param1;
      }
      
      public function initialize(param1:uint) : void
      {
         generateSingletonClassesPointers("");
         this._playerID = param1;
      }
      
      public function updateExistingPlayerItemIDs() : void
      {
         var _loc2_:BMPlayerItemData = null;
         this.existingItemsIDs = new Object();
         var _loc1_:uint = 0;
         while(_loc1_ < this.items.length)
         {
            _loc2_ = this.items[_loc1_];
            this.existingItemsIDs[_loc2_.itemID] = true;
            _loc1_++;
         }
      }
      
      public function updateMechsWeight() : void
      {
         var _loc1_:uint = 0;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         _loc1_ = 1;
         while(_loc1_ <= dataM.inventoryMaxMechs)
         {
            this.mechStructures[_loc1_].mechWeight = 0;
            this.mechStructures[_loc1_].totalMythicalItems = 0;
            _loc1_++;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.items.length)
         {
            _loc3_ = this.items[_loc2_];
            _loc1_ = _loc3_.equipped;
            if(_loc1_ >= 1)
            {
               _loc4_ = dataM.itemsDB[_loc3_.itemID];
               this.mechStructures[_loc1_].mechWeight += _loc4_.weight;
               if(_loc4_.specialStatus == 4)
               {
                  this.mechStructures[_loc1_].totalMythicalItems += 1;
               }
            }
            _loc2_++;
         }
      }
      
      public function getPlayerItemBy(param1:Number) : BMPlayerItemData
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.items.length)
         {
            if(this.items[_loc2_].playerItemID == param1)
            {
               return this.items[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getItemBy(param1:Number) : BMItemData
      {
         var _loc2_:BMPlayerItemData = this.getPlayerItemBy(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return dataM.itemsDB[_loc2_.itemID];
      }
      
      public function hasItemOfSpecificRarity(param1:uint) : Boolean
      {
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.items.length)
         {
            _loc3_ = this.items[_loc2_];
            _loc4_ = dataM.itemsDB[_loc3_.itemID];
            if(_loc4_.specialStatus == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isBlockedFromPlayingInCompetitveBattles(param1:uint) : String
      {
         var _loc3_:BMMechStructure = null;
         var _loc2_:uint = 1;
         while(_loc2_ <= param1)
         {
            _loc3_ = this.mechStructures[_loc2_];
            if(int(dataM.getGeneralSetting("blockLegacyShieldsInCompetitivePlay","0")) == 1)
            {
               if(_loc3_.hasLegacyShield())
               {
                  return "cannotPlayWithLegacyShields";
               }
            }
            if(int(dataM.getGeneralSetting("blockRepairDronesInCompetitivePlay","0")) == 1)
            {
               if(_loc3_.hasRepairDrone())
               {
                  return "cannotPlayWithRepairDrones";
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getItemIDByItemID(param1:Number) : Number
      {
         return param1;
      }
      
      public function getMechStructurePowerRatingPrecise(param1:BMMechStructure, param2:Boolean, param3:Boolean) : *
      {
         var _loc5_:uint = 0;
         var _loc4_:Function = param3 ? dataM.getItemIDByPlayerItemID : this.getItemIDByItemID;
         var _loc6_:uint = dataM.getGeneralSetting("itemPROffset",0);
         if(param2)
         {
            _loc6_ = 0;
         }
         var _loc7_:uint = 0;
         _loc7_ = _loc7_ + this.getItemPowerRating(_loc4_(param1.torso),_loc6_);
         _loc7_ = _loc7_ + this.getItemPowerRating(_loc4_(param1.leg),_loc6_);
         _loc5_ = 1;
         while(_loc5_ <= dataM.maxEquipment["sideWeapon"])
         {
            _loc7_ += this.getItemPowerRating(_loc4_(param1["sideWeapon" + _loc5_]),_loc6_);
            _loc5_++;
         }
         _loc5_ = 1;
         while(_loc5_ <= dataM.maxEquipment["topWeapon"])
         {
            _loc7_ += this.getItemPowerRating(_loc4_(param1["topWeapon" + _loc5_]),_loc6_);
            _loc5_++;
         }
         _loc7_ += this.getItemPowerRating(_loc4_(param1.drone),_loc6_);
         _loc7_ = _loc7_ + this.getItemPowerRating(_loc4_(param1.shield),_loc6_);
         _loc7_ = _loc7_ + this.getItemPowerRating(_loc4_(param1.teleport),_loc6_);
         _loc7_ = _loc7_ + this.getItemPowerRating(_loc4_(param1.charge),_loc6_);
         _loc7_ = _loc7_ + this.getItemPowerRating(_loc4_(param1.harpoon),_loc6_);
         _loc5_ = 1;
         while(_loc5_ <= dataM.maxEquipment["module"])
         {
            _loc7_ += this.getItemPowerRating(_loc4_(param1["module" + _loc5_]),_loc6_);
            _loc5_++;
         }
         return _loc7_ / 1000;
      }
      
      public function getMechPowerRatingPrecise(param1:uint, param2:Boolean) : Number
      {
         var _loc3_:BMMechStructure = this.mechStructures[param1];
         return this.getMechStructurePowerRatingPrecise(_loc3_,param2,true);
      }
      
      public function getMechPowerRating(param1:uint, param2:Boolean, param3:Boolean = true) : Number
      {
         var _loc4_:Number = this.getMechPowerRatingPrecise(param1,param2);
         if(param3)
         {
            return Math.ceil(_loc4_);
         }
         return _loc4_;
      }
      
      private function getItemPowerRating(param1:uint, param2:uint) : uint
      {
         if(param1 == 0)
         {
            return 0;
         }
         var _loc3_:BMItemData = dataM.itemsDB[param1];
         return (_loc3_.powerRating + param2) * _loc3_.weight;
      }
      
      public function getMechDisplayPowerRating(param1:uint) : uint
      {
         return Math.ceil(this.getMechPowerRating(param1,false,false) * 50);
      }
      
      public function getItemDisplayPowerRating(param1:uint) : uint
      {
         var _loc2_:uint = dataM.getGeneralSetting("itemPROffset",0);
         return Math.ceil(this.getItemPowerRating(param1,_loc2_) / 1000 * 50);
      }
      
      public function resetSwitchMechUses() : void
      {
         this.switchMech1Uses = 0;
         this.switchMech2Uses = 0;
         this.switchMech3Uses = 0;
      }
   }
}

