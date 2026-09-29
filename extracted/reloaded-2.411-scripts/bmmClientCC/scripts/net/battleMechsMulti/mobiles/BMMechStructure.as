package net.battleMechsMulti.mobiles
{
   public class BMMechStructure extends BMBaseClass
   {
      
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
      
      public var has_sideWeapons:Boolean;
      
      public var has_topWeapons:Boolean;
      
      public var has_kits:Boolean;
      
      public var has_specials:Boolean;
      
      public var totalBullets:Number;
      
      public var totalRockets:Number;
      
      public var mechWeight:Number = 0;
      
      public var totalMythicalItems:Number = 0;
      
      public function BMMechStructure()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:uint) : void
      {
         generateSingletonClassesPointers("");
         this.playerID = param1;
         this.mechID = param2;
         this.resetStructure();
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
         var _loc2_:uint = 0;
         var _loc1_:Boolean = false;
         if(this.torso > 0 || this.leg > 0)
         {
            _loc1_ = true;
         }
         else
         {
            _loc2_ = 1;
            while(_loc2_ <= dataM.maxEquipment["sideWeapon"])
            {
               if(this["sideWeapon" + _loc2_] > 0)
               {
                  _loc1_ = true;
                  _loc2_ = uint(dataM.maxEquipment["sideWeapon"]);
               }
               _loc2_++;
            }
            if(_loc1_ == false)
            {
               _loc2_ = 1;
               while(_loc2_ <= dataM.maxEquipment["topWeapon"])
               {
                  if(this["topWeapon" + _loc2_] > 0)
                  {
                     _loc1_ = true;
                     _loc2_ = uint(dataM.maxEquipment["topWeapon"]);
                  }
                  _loc2_++;
               }
               if(_loc1_ == false)
               {
                  if(this.drone > 0 || this.shield > 0 || this.teleport > 0 || this.charge > 0 || this.harpoon > 0)
                  {
                     _loc1_ = true;
                  }
                  if(_loc1_ == false)
                  {
                     _loc2_ = 1;
                     while(_loc2_ <= dataM.maxEquipment["module"])
                     {
                        if(this["module" + _loc2_] > 0)
                        {
                           _loc1_ = true;
                           _loc2_ = uint(dataM.maxEquipment["module"]);
                        }
                        _loc2_++;
                     }
                  }
               }
            }
         }
         return _loc1_;
      }
      
      public function canBeDisplayed() : Boolean
      {
         return this.torso > 0 && this.leg > 0;
      }
   }
}

