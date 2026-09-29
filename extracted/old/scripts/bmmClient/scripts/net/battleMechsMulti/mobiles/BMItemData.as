package net.battleMechsMulti.mobiles
{
   public class BMItemData
   {
      
      public var itemID:Number;
      
      public var fullName:String;
      
      public var sortID:Number;
      
      public var finalSortID:Number;
      
      public var type:String;
      
      public var subType:String;
      
      public var level:Number;
      
      public var displayLevel:Number;
      
      public var upgradeToItemID:Number;
      
      public var powerToUpgrade:Number;
      
      public var minPowerToHave:Number;
      
      public var materialPowerContribution:Number;
      
      public var upgradeGoldCost:Number;
      
      public var evolutionGoldCost:Number;
      
      public var HPBase:Number;
      
      public var HPAddon:Number;
      
      public var energyBase:Number;
      
      public var energyAddon:Number;
      
      public var heatBase:Number;
      
      public var heatAddon:Number;
      
      public var bullets:Number;
      
      public var rockets:Number;
      
      public var damageBase:Number;
      
      public var damageAddon:Number;
      
      public var damageType:Number;
      
      public var damageHeat:Number;
      
      public var damageHeatBase:Number;
      
      public var damageHeatAddon:Number;
      
      public var damageEnergy:Number;
      
      public var damageEnergyBase:Number;
      
      public var damageEnergyAddon:Number;
      
      public var uses:Number;
      
      public var push:Number;
      
      public var resist1:Number;
      
      public var resist2:Number;
      
      public var resist3:Number;
      
      public var rangeBase:Number;
      
      public var rangeAddon:Number;
      
      public var stepsPerWalk:Number;
      
      public var stepsPerJump:Number;
      
      public var energyPerBlock:Number;
      
      public var heatPerBlock:Number;
      
      public var HPPerBlock:Number;
      
      public var absorbRatio:Number;
      
      public var costHeat:Number;
      
      public var costEnergy:Number;
      
      public var costGold:Number;
      
      public var costTokens:Number;
      
      public var costTokensDefault:Number;
      
      public var animation:String;
      
      public var grp:String;
      
      public var specialStatus:Number;
      
      public var power:Number;
      
      public var weight:Number;
      
      public var isInShop:Boolean;
      
      public function BMItemData()
      {
         super();
      }
      
      public function initialize() : void
      {
         this.itemID = 0;
         this.fullName = "";
         this.sortID = 1;
         this.finalSortID = 1;
         this.type = "";
         this.subType = "";
         this.level = 0;
         this.HPBase = 0;
         this.HPAddon = 0;
         this.energyBase = 0;
         this.energyAddon = 0;
         this.heatBase = 0;
         this.heatAddon = 0;
         this.bullets = 0;
         this.rockets = 0;
         this.damageBase = 0;
         this.damageAddon = 0;
         this.damageType = 0;
         this.damageHeat = 0;
         this.damageHeatBase = 0;
         this.damageHeatAddon = 0;
         this.damageEnergy = 0;
         this.damageEnergyBase = 0;
         this.damageEnergyAddon = 0;
         this.uses = 0;
         this.push = 0;
         this.resist1 = 0;
         this.resist2 = 0;
         this.resist3 = 0;
         this.rangeBase = 0;
         this.rangeAddon = 0;
         this.stepsPerWalk = 0;
         this.stepsPerJump = 0;
         this.energyPerBlock = 0;
         this.heatPerBlock = 0;
         this.HPPerBlock = 0;
         this.absorbRatio = 0;
         this.costHeat = 0;
         this.costEnergy = 0;
         this.costGold = 0;
         this.costTokens = 0;
         this.costTokensDefault = 0;
         this.animation = "";
         this.grp = "";
         this.specialStatus = 0;
         this.power = 0;
         this.weight = 0;
         this.isInShop = false;
      }
      
      public function isMaxLevel() : Boolean
      {
         return this.powerToUpgrade <= 0;
      }
      
      public function canEvolve() : Boolean
      {
         return this.isMaxLevel() && this.upgradeToItemID > 0;
      }
   }
}

