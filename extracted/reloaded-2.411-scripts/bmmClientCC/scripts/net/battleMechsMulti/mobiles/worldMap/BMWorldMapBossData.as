package net.battleMechsMulti.mobiles.worldMap
{
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMWorldMapBossData
   {
      
      public var name:String = "";
      
      public var torso:uint = 0;
      
      public var leg:uint = 0;
      
      public var sideWeapon1:uint = 0;
      
      public var sideWeapon2:uint = 0;
      
      public var sideWeapon3:uint = 0;
      
      public var sideWeapon4:uint = 0;
      
      public var topWeapon1:uint = 0;
      
      public var topWeapon2:uint = 0;
      
      public var drone:uint = 0;
      
      public var teleport:uint = 0;
      
      public var charge:uint = 0;
      
      public var shield:uint = 0;
      
      public var harpoon:uint = 0;
      
      public var perk:uint = 0;
      
      public var fixed_hp:uint = 0;
      
      public var fixed_energyBase:uint = 0;
      
      public var fixed_energyAddon:uint = 0;
      
      public var fixed_heatBase:uint = 0;
      
      public var fixed_heatAddon:uint = 0;
      
      public var fixed_bullets:uint = 0;
      
      public var fixed_rockets:uint = 0;
      
      public var fixed_resist1:uint = 0;
      
      public var fixed_resist2:uint = 0;
      
      public var fixed_resist3:uint = 0;
      
      public function BMWorldMapBossData()
      {
         super();
      }
      
      public function setName(param1:String) : void
      {
         this.name = param1;
      }
      
      public function setItems(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint = 0, param8:uint = 0, param9:uint = 0, param10:uint = 0, param11:uint = 0, param12:uint = 0, param13:uint = 0, param14:uint = 0) : void
      {
         this.torso = param1;
         this.leg = param2;
         this.sideWeapon1 = param3;
         this.sideWeapon2 = param4;
         this.sideWeapon3 = param5;
         this.sideWeapon4 = param6;
         this.topWeapon1 = param7;
         this.topWeapon2 = param8;
         this.drone = param9;
         this.teleport = param10;
         this.charge = param11;
         this.harpoon = param12;
         this.shield = param13;
         this.perk = param14;
      }
      
      public function setFixedProperties(param1:uint, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:uint = 0, param9:uint = 0, param10:uint = 0) : void
      {
         this.fixed_hp = param1;
         this.fixed_energyBase = param2;
         this.fixed_energyAddon = param3;
         this.fixed_heatBase = param4;
         this.fixed_heatAddon = param5;
         this.fixed_bullets = param6;
         this.fixed_rockets = param7;
         this.fixed_resist1 = param8;
         this.fixed_resist2 = param9;
         this.fixed_resist3 = param10;
      }
      
      public function getPlayerItemsData() : Array
      {
         var _loc2_:uint = 0;
         var _loc1_:Array = new Array();
         _loc1_.push(this.getSpecificPlayerItemData(this.torso,"torso",0,9));
         _loc1_.push(this.getSpecificPlayerItemData(this.leg,"leg",0,9));
         _loc2_ = 1;
         while(_loc2_ <= 4)
         {
            if(this["sideWeapon" + _loc2_] > 0)
            {
               _loc1_.push(this.getSpecificPlayerItemData(this["sideWeapon" + _loc2_],"sideWeapon",_loc2_,9));
            }
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= 2)
         {
            if(this["topWeapon" + _loc2_] > 0)
            {
               _loc1_.push(this.getSpecificPlayerItemData(this["topWeapon" + _loc2_],"topWeapon",_loc2_,9));
            }
            _loc2_++;
         }
         if(this.drone > 0)
         {
            _loc1_.push(this.getSpecificPlayerItemData(this.drone,"drone",0,9));
         }
         if(this.teleport > 0)
         {
            _loc1_.push(this.getSpecificPlayerItemData(this.teleport,"teleport"));
         }
         if(this.charge > 0)
         {
            _loc1_.push(this.getSpecificPlayerItemData(this.charge,"charge"));
         }
         if(this.harpoon > 0)
         {
            _loc1_.push(this.getSpecificPlayerItemData(this.harpoon,"harpoon"));
         }
         if(this.shield > 0)
         {
            _loc1_.push(this.getSpecificPlayerItemData(this.shield,"shield"));
         }
         if(this.perk > 0)
         {
            _loc1_.push(this.getSpecificPlayerItemData(this.perk,"perk"));
         }
         return _loc1_;
      }
      
      public function getBossMechStructure() : BMMechStructure
      {
         var _loc1_:BMMechStructure = new BMMechStructure();
         _loc1_.initialize(0,0);
         _loc1_.torso = this.torso;
         _loc1_.leg = this.leg;
         _loc1_.sideWeapon1 = this.sideWeapon1;
         _loc1_.sideWeapon2 = this.sideWeapon2;
         _loc1_.sideWeapon3 = this.sideWeapon3;
         _loc1_.sideWeapon4 = this.sideWeapon4;
         _loc1_.topWeapon1 = this.topWeapon1;
         _loc1_.topWeapon2 = this.topWeapon2;
         _loc1_.torso_colorID = 9;
         _loc1_.leg_colorID = 9;
         _loc1_.sideWeapon1_colorID = 9;
         _loc1_.sideWeapon2_colorID = 9;
         _loc1_.sideWeapon3_colorID = 9;
         _loc1_.sideWeapon4_colorID = 9;
         _loc1_.topWeapon1_colorID = 9;
         _loc1_.topWeapon2_colorID = 9;
         return _loc1_;
      }
      
      private function getSpecificPlayerItemData(param1:uint, param2:String, param3:uint = 0, param4:uint = 0) : BMPlayerItemData
      {
         var _loc5_:BMPlayerItemData = new BMPlayerItemData();
         _loc5_.itemID = param1;
         _loc5_.equipmentType = param2;
         _loc5_.equipmentID = param3;
         _loc5_.colorID = param4;
         return _loc5_;
      }
   }
}

