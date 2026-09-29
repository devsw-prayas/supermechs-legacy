package net.battleMechsMulti.screens.clan
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   
   public class BMClanBossData
   {
      
      public var ID:String;
      
      public var name:String;
      
      public var level:uint;
      
      public var damageMultiplier:Number;
      
      public var ticketsRequired:uint;
      
      public var colorID:uint;
      
      public var themeID:uint;
      
      public var hpMax:uint;
      
      public var xPos:uint;
      
      public var yPos:uint;
      
      public var energy:uint;
      
      public var energyRegeneration:uint;
      
      public var heat:uint;
      
      public var heatCooling:uint;
      
      public var resist1:uint;
      
      public var resist2:uint;
      
      public var resist3:uint;
      
      public var battleAvatar:String;
      
      public var destructionType:uint;
      
      public var allowWeaponFiringAngle:Boolean;
      
      public function BMClanBossData(param1:Object)
      {
         super();
         this.ID = param1.mechID;
         this.name = param1.name;
         this.level = param1.level;
         this.damageMultiplier = param1.damageMultiplier;
         this.ticketsRequired = param1.tickets;
         this.hpMax = param1.HP;
         this.xPos = param1.xPos;
         this.yPos = param1.yPos;
         this.energy = param1.energy;
         this.energyRegeneration = param1.energyRegenration;
         this.heat = param1.heat;
         this.heatCooling = param1.heatCooling;
         this.resist1 = param1.resist1;
         this.resist2 = param1.resist2;
         this.resist3 = param1.resist3;
         this.colorID = param1.colorID;
         this.themeID = param1.themeID;
         this.battleAvatar = param1.battleAvatar;
         this.destructionType = param1.destructionType;
         this.allowWeaponFiringAngle = true;
         if(param1["allowWeaponFiringAngle"] != null && int(param1["allowWeaponFiringAngle"]) == 0)
         {
            this.allowWeaponFiringAngle = false;
         }
      }
      
      public function getMechStructure() : BMMechStructure
      {
         var _loc1_:Object = BMDataManager.getInstance().missionBossData[this.ID];
         return BMMechStructure.parseMechStructureFromObject(_loc1_);
      }
      
      public function getMechViewManualColors() : BMMechViewManualColors
      {
         var _loc1_:BMMechViewManualColors = new BMMechViewManualColors();
         _loc1_.setSpecificColorForAll(this.colorID);
         return _loc1_;
      }
   }
}

