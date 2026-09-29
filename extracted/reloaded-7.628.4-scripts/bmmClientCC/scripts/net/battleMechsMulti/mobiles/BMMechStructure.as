package net.battleMechsMulti.mobiles
{
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class BMMechStructure extends BMBaseClass
   {
      
      public static const TORSO:String = "torso";
      
      public static const LEG:String = "leg";
      
      public static const LEG_1:String = "leg1";
      
      public static const LEG_2:String = "leg2";
      
      public static const SIDE_WEAPON:String = "sideWeapon";
      
      public static const SIDE_WEAPON_1:String = "sideWeapon1";
      
      public static const SIDE_WEAPON_2:String = "sideWeapon2";
      
      public static const SIDE_WEAPON_3:String = "sideWeapon3";
      
      public static const SIDE_WEAPON_4:String = "sideWeapon4";
      
      public static const TOP_WEAPON:String = "topWeapon";
      
      public static const TOP_WEAPON_1:String = "topWeapon1";
      
      public static const TOP_WEAPON_2:String = "topWeapon2";
      
      public static const MODULE:String = "module";
      
      public static const MODULE_1:String = "module1";
      
      public static const MODULE_2:String = "module2";
      
      public static const MODULE_3:String = "module3";
      
      public static const MODULE_4:String = "module4";
      
      public static const MODULE_5:String = "module5";
      
      public static const MODULE_6:String = "module6";
      
      public static const MODULE_7:String = "module7";
      
      public static const MODULE_8:String = "module8";
      
      public static const KIT:String = "kit";
      
      public static const DRONE:String = "drone";
      
      public static const TELEPORT:String = "teleport";
      
      public static const CHARGE:String = "charge";
      
      public static const HARPOON:String = "harpoon";
      
      public static const SHIELD:String = "shield";
      
      public static const PERK:String = "perk";
      
      public static const SPECIAL:String = "special";
      
      public static const ENHANCER:String = "enhancer";
      
      public static const ALL_ITEMS:Array = ["leg","torso","sideWeapon1","sideWeapon2","sideWeapon3","sideWeapon4","topWeapon1","topWeapon2","drone","shield","teleport","charge","harpoon","module1","module2","module3","module4","module5","module6","module7","module8","kit1","kit2","kit3","kit4","kit5","kit6","perk"];
      
      public static const ALL_SPECIAL_ITEMS:Array = ["drone","shield","teleport","charge","harpoon"];
      
      public static const ITEM_TYPE_ITEM_ID:String = "itemID";
      
      public static const ITEM_TYPE_PLAYER_ITEM_ID:String = "playerItemID";
      
      public var playerID:Number;
      
      public var mechID:uint;
      
      public var leg:Number;
      
      public var torso:Number;
      
      public var sideWeapon1:Number;
      
      public var sideWeapon2:Number;
      
      public var sideWeapon3:Number;
      
      public var sideWeapon4:Number;
      
      public var topWeapon1:Number;
      
      public var topWeapon2:Number;
      
      public var drone:Number;
      
      public var shield:Number;
      
      public var teleport:Number;
      
      public var charge:Number;
      
      public var harpoon:Number;
      
      public var module1:Number;
      
      public var module2:Number;
      
      public var module3:Number;
      
      public var module4:Number;
      
      public var module5:Number;
      
      public var module6:Number;
      
      public var module7:Number;
      
      public var module8:Number;
      
      public var kit1:Number;
      
      public var kit2:Number;
      
      public var kit3:Number;
      
      public var kit4:Number;
      
      public var kit5:Number;
      
      public var kit6:Number;
      
      public var perk:Number;
      
      public var torso_colorID:Number;
      
      public var leg_colorID:Number;
      
      public var sideWeapon1_colorID:Number;
      
      public var sideWeapon2_colorID:Number;
      
      public var sideWeapon3_colorID:Number;
      
      public var sideWeapon4_colorID:Number;
      
      public var topWeapon1_colorID:Number;
      
      public var topWeapon2_colorID:Number;
      
      public var drone_colorID:Number;
      
      public var has_sideWeapons:Boolean;
      
      public var has_topWeapons:Boolean;
      
      public var has_kits:Boolean;
      
      public var has_specials:Boolean;
      
      public var totalBullets:Number;
      
      public var totalRockets:Number;
      
      public var mechWeight:Number = 0;
      
      public var totalMythicalItems:Number = 0;
      
      private var _itemType:String;
      
      public function BMMechStructure(param1:String)
      {
         super();
         this._itemType = param1;
      }
      
      public static function extractEquipmentIDFromEquipmentSlot(param1:String) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case TORSO:
            case LEG:
            case DRONE:
            case SHIELD:
            case TELEPORT:
            case CHARGE:
            case HARPOON:
            case PERK:
               return _loc2_;
            default:
               return uint(int(param1.substr(param1.length - 1,1)));
         }
      }
      
      public static function getEquipmentSlotByTypeAndID(param1:String, param2:uint) : String
      {
         switch(param1)
         {
            case MODULE:
            case SIDE_WEAPON:
            case TOP_WEAPON:
            case KIT:
               return param1 + param2;
            default:
               return param1;
         }
      }
      
      public static function parseMechStructureFromArray(param1:Array) : BMMechStructure
      {
         var _loc3_:Object = null;
         var _loc4_:BMPlayerItemDataTemplate = null;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc2_:BMMechStructure = new BMMechStructure(ITEM_TYPE_ITEM_ID);
         for each(_loc3_ in param1)
         {
            _loc4_ = BMPlayerItemDataTemplate.parsePlayerItemData(_loc3_);
            _loc5_ = false;
            _loc6_ = _loc4_.getSlotName();
            _loc2_[_loc6_] = _loc4_.itemID;
            switch(_loc4_.equipmentType)
            {
               case "sideWeapon":
               case "topWeapon":
               case "torso":
               case "leg":
               case "drone":
                  _loc7_ = _loc6_ + "_colorID";
                  _loc2_[_loc7_] = _loc4_.colorID;
            }
         }
         return _loc2_;
      }
      
      public static function parseMechStructureFromObject(param1:Object) : BMMechStructure
      {
         var _loc5_:uint = 0;
         var _loc2_:BMMechStructure = new BMMechStructure(ITEM_TYPE_ITEM_ID);
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         var _loc4_:uint = 0;
         if(param1.colorID != null)
         {
            _loc4_ = uint(param1.colorID);
         }
         _loc2_.leg = param1.leg;
         _loc2_.leg_colorID = _loc4_;
         _loc2_.torso = param1.torso;
         _loc2_.torso_colorID = _loc4_;
         _loc5_ = 1;
         while(_loc5_ <= _loc3_.maxEquipment["sideWeapon"])
         {
            if(param1["sideWeapon" + _loc5_] != null)
            {
               _loc2_["sideWeapon" + _loc5_] = param1["sideWeapon" + _loc5_];
               _loc2_["sideWeapon" + _loc5_ + "_colorID"] = _loc4_;
            }
            _loc5_++;
         }
         _loc5_ = 1;
         while(_loc5_ <= _loc3_.maxEquipment["topWeapon"])
         {
            if(param1["topWeapon" + _loc5_] != null)
            {
               _loc2_["topWeapon" + _loc5_] = param1["topWeapon" + _loc5_];
               _loc2_["topWeapon" + _loc5_ + "_colorID"] = _loc4_;
            }
            _loc5_++;
         }
         if(param1.drone != null)
         {
            _loc2_.drone = param1.drone;
            _loc2_.drone_colorID = _loc4_;
         }
         if(param1.shield != null)
         {
            _loc2_.shield = param1.shield;
         }
         if(param1.teleport != null)
         {
            _loc2_.teleport = param1.teleport;
         }
         if(param1.charge != null)
         {
            _loc2_.charge = param1.charge;
         }
         if(param1.harpoon != null)
         {
            _loc2_.harpoon = param1.harpoon;
         }
         _loc5_ = 1;
         while(_loc5_ <= _loc3_.maxEquipment["module"])
         {
            if(_loc2_["module" + _loc5_] != null)
            {
               _loc2_["module" + _loc5_] = param1["module" + _loc5_];
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function get itemType() : String
      {
         return this._itemType;
      }
      
      public function initialize(param1:Number, param2:uint) : void
      {
         generateSingletonClassesPointers("");
         this.playerID = param1;
         this.mechID = param2;
         this.resetStructure();
      }
      
      public function get mechItemIDs() : Array
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:BMPlayerItemData = null;
         var _loc1_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < ALL_ITEMS.length)
         {
            _loc3_ = 0;
            switch(this._itemType)
            {
               case ITEM_TYPE_PLAYER_ITEM_ID:
                  _loc4_ = uint(this[ALL_ITEMS[_loc2_]]);
                  if(_loc4_ > 0)
                  {
                     _loc5_ = BMDataManager.getInstance().getPlayerItemData(this.playerID,_loc4_);
                     _loc3_ = _loc5_.itemID;
                  }
                  break;
               case ITEM_TYPE_ITEM_ID:
                  _loc3_ = uint(this[ALL_ITEMS[_loc2_]]);
            }
            if(_loc3_ > 0)
            {
               _loc1_.push(_loc3_);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function isEmpty() : Boolean
      {
         if(this.mechItemIDs.length == 0)
         {
            return true;
         }
         return false;
      }
      
      public function resetStructure() : void
      {
         var _loc1_:uint = 0;
         this.leg = 0;
         this.leg_colorID = 0;
         this.torso = 0;
         this.torso_colorID = 0;
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["sideWeapon"])
         {
            this["sideWeapon" + _loc1_] = 0;
            this["sideWeapon" + _loc1_ + "_colorID"] = 0;
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["topWeapon"])
         {
            this["topWeapon" + _loc1_] = 0;
            this["topWeapon" + _loc1_ + "_colorID"] = 0;
            _loc1_++;
         }
         this.drone = 0;
         this.drone_colorID = 0;
         this.shield = 0;
         this.teleport = 0;
         this.charge = 0;
         this.harpoon = 0;
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["module"])
         {
            this["module" + _loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["kit"])
         {
            this["kit" + _loc1_] = 0;
            _loc1_++;
         }
         this.totalBullets = 0;
         this.totalRockets = 0;
         this.perk = 0;
      }
      
      public function copyMechStructure(param1:BMMechStructure) : void
      {
         var _loc2_:uint = 0;
         this.leg = param1.leg;
         this.leg_colorID = param1.leg_colorID;
         this.torso = param1.torso;
         this.torso_colorID = param1.torso_colorID;
         _loc2_ = 1;
         while(_loc2_ <= dataM.maxEquipment["sideWeapon"])
         {
            this["sideWeapon" + _loc2_] = param1["sideWeapon" + _loc2_];
            this["sideWeapon" + _loc2_ + "_colorID"] = param1["sideWeapon" + _loc2_ + "_colorID"];
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= dataM.maxEquipment["topWeapon"])
         {
            this["topWeapon" + _loc2_] = param1["topWeapon" + _loc2_];
            this["topWeapon" + _loc2_ + "_colorID"] = param1["topWeapon" + _loc2_ + "_colorID"];
            _loc2_++;
         }
         this.drone = param1.drone;
         this.drone_colorID = param1.drone_colorID;
         this.shield = param1.shield;
         this.teleport = param1.teleport;
         this.charge = param1.charge;
         this.harpoon = param1.harpoon;
         _loc2_ = 1;
         while(_loc2_ <= dataM.maxEquipment["module"])
         {
            this["module" + _loc2_] = param1["module" + _loc2_];
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= dataM.maxEquipment["kit"])
         {
            this["kit" + _loc2_] = param1["kit" + _loc2_];
            _loc2_++;
         }
         this.totalBullets = param1.totalBullets;
         this.totalRockets = param1.totalRockets;
         this.perk = param1.perk;
      }
      
      public function convertPlayerItemIDsIntoItemIDs() : void
      {
         var _loc1_:uint = 0;
         if(this._itemType == ITEM_TYPE_ITEM_ID)
         {
            throw new Error("Error: mech structure cannot convert playerItemIDs into itemIDs");
         }
         this.leg_colorID = this.getPlayerItemDataColor(this.leg);
         this.leg = dataM.getItemIDByPlayerItemID(this.leg);
         this.torso_colorID = this.getPlayerItemDataColor(this.torso);
         this.torso = dataM.getItemIDByPlayerItemID(this.torso);
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["sideWeapon"])
         {
            this["sideWeapon" + _loc1_ + "_colorID"] = this.getPlayerItemDataColor(this["sideWeapon" + _loc1_]);
            this["sideWeapon" + _loc1_] = dataM.getItemIDByPlayerItemID(this["sideWeapon" + _loc1_]);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["topWeapon"])
         {
            this["topWeapon" + _loc1_ + "_colorID"] = this.getPlayerItemDataColor(this["topWeapon" + _loc1_]);
            this["topWeapon" + _loc1_] = dataM.getItemIDByPlayerItemID(this["topWeapon" + _loc1_]);
            _loc1_++;
         }
         this.drone_colorID = this.getPlayerItemDataColor(this.drone);
         this.drone = dataM.getItemIDByPlayerItemID(this.drone);
         this.shield = dataM.getItemIDByPlayerItemID(this.shield);
         this.teleport = dataM.getItemIDByPlayerItemID(this.teleport);
         this.charge = dataM.getItemIDByPlayerItemID(this.charge);
         this.harpoon = dataM.getItemIDByPlayerItemID(this.harpoon);
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["module"])
         {
            this["module" + _loc1_] = dataM.getItemIDByPlayerItemID(this["module" + _loc1_]);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["kit"])
         {
            this["kit" + _loc1_] = dataM.getItemIDByPlayerItemID(this["kit" + _loc1_]);
            _loc1_++;
         }
         this.perk = dataM.getItemIDByPlayerItemID(this.perk);
         this._itemType = ITEM_TYPE_ITEM_ID;
      }
      
      private function getPlayerItemDataColor(param1:uint) : uint
      {
         if(param1 == 0)
         {
            return 0;
         }
         return dataM.getPlayerItemData(this.playerID,param1).colorID;
      }
      
      public function hasLegacyShield() : Boolean
      {
         var _loc1_:BMItemData = null;
         var _loc2_:BMPlayerItemData = null;
         if(this.shield == 0)
         {
            return false;
         }
         if(this._itemType == ITEM_TYPE_ITEM_ID)
         {
            _loc1_ = dataM.itemsDB[this.shield];
         }
         else
         {
            _loc2_ = dataM.getPlayerItemData(this.playerID,this.shield);
            _loc1_ = dataM.itemsDB[_loc2_.itemID];
         }
         return _loc1_.isDeprecated;
      }
      
      public function hasRepairDrone() : Boolean
      {
         var _loc1_:BMItemData = null;
         var _loc2_:BMPlayerItemData = null;
         if(this.drone == 0)
         {
            return false;
         }
         if(this._itemType == ITEM_TYPE_ITEM_ID)
         {
            _loc1_ = dataM.itemsDB[this.drone];
         }
         else
         {
            _loc2_ = dataM.getPlayerItemData(this.playerID,this.drone);
            _loc1_ = dataM.itemsDB[_loc2_.itemID];
         }
         return _loc1_.HPAddon > 0;
      }
      
      public function updateEquipmentIndicators() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMItemData = null;
         this.totalBullets = 0;
         this.totalRockets = 0;
         if(this.playerID == dataM.LOCAL_PLAYER_ID || this.playerID == dataM.ONLINE_PLAYER_ID)
         {
            if(this.torso > 0)
            {
               _loc2_ = dataM.getPlayerItemData(this.playerID,this.torso);
               _loc3_ = dataM.itemsDB[_loc2_.itemID];
               this.totalBullets += _loc3_.bullets;
               this.totalRockets += _loc3_.rockets;
            }
            _loc1_ = 1;
            while(_loc1_ <= dataM.maxEquipment["module"])
            {
               if(this["module" + _loc1_] > 0)
               {
                  _loc2_ = dataM.getPlayerItemData(this.playerID,this["module" + _loc1_]);
                  _loc3_ = dataM.itemsDB[_loc2_.itemID];
                  this.totalBullets += _loc3_.bullets;
                  this.totalRockets += _loc3_.rockets;
               }
               _loc1_++;
            }
         }
         this.has_sideWeapons = false;
         this.has_topWeapons = false;
         this.has_kits = false;
         this.has_specials = false;
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["sideWeapon"])
         {
            if(this["sideWeapon" + _loc1_] > 0)
            {
               this.has_sideWeapons = true;
               _loc1_ = dataM.maxEquipment["sideWeapon"] + 1;
            }
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["topWeapon"])
         {
            if(this["topWeapon" + _loc1_] > 0)
            {
               this.has_topWeapons = true;
               _loc1_ = dataM.maxEquipment["topWeapon"] + 1;
            }
            _loc1_++;
         }
         if(this.drone > 0 || this.shield > 0 || this.teleport > 0 || this.charge > 0 || this.harpoon > 0)
         {
            this.has_specials = true;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["kit"])
         {
            if(this["kit" + _loc1_] > 0)
            {
               this.has_kits = true;
               _loc1_ = dataM.maxEquipment["kit"] + 1;
            }
            _loc1_++;
         }
      }
      
      public function hasAtLeastOneItem() : Boolean
      {
         var _loc1_:uint = 0;
         if(this.torso > 0 || this.leg > 0)
         {
            return true;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["sideWeapon"])
         {
            if(this["sideWeapon" + _loc1_] > 0)
            {
               return true;
            }
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["topWeapon"])
         {
            if(this["topWeapon" + _loc1_] > 0)
            {
               return true;
            }
            _loc1_++;
         }
         if(this.drone > 0 || this.shield > 0 || this.teleport > 0 || this.charge > 0 || this.harpoon > 0)
         {
            return true;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["module"])
         {
            if(this["module" + _loc1_] > 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function canBeDisplayed() : Boolean
      {
         return this.torso > 0 && this.leg > 0;
      }
   }
}

