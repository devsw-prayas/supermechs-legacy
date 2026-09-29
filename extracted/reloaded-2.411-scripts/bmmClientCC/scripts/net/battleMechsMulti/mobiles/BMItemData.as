package net.battleMechsMulti.mobiles
{
   import flash.utils.ByteArray;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   public class BMItemData
   {
      
      public var itemID:int;
      
      public var fullName:String;
      
      public var sortID:int;
      
      public var finalSortID:int;
      
      public var type:String;
      
      public var subType:String;
      
      public var level:int;
      
      public var displayLevel:int;
      
      public var upgradeToItemID:int;
      
      public var powerToUpgrade:int;
      
      public var minPowerToHave:int;
      
      public var materialPowerContribution:int;
      
      public var upgradeGoldCost:int;
      
      public var evolutionGoldCost:int;
      
      public var HPBase:int;
      
      public var HPAddon:int;
      
      public var energyBase:int;
      
      public var energyAddon:int;
      
      public var heatBase:int;
      
      public var heatAddon:int;
      
      public var bullets:int;
      
      public var rockets:int;
      
      public var damageBase:int;
      
      public var damageAddon:int;
      
      public var damageType:int;
      
      public var damageHeat:int;
      
      public var damageHeatBase:int;
      
      public var damageHeatAddon:int;
      
      public var damageEnergy:int;
      
      public var damageEnergyBase:int;
      
      public var damageEnergyAddon:int;
      
      public var uses:int;
      
      public var push:int;
      
      public var resist1:int;
      
      public var resist2:int;
      
      public var resist3:int;
      
      public var rangeBase:int;
      
      public var rangeAddon:int;
      
      public var stepsPerWalk:int;
      
      public var stepsPerJump:int;
      
      public var energyPerBlock:int;
      
      public var heatPerBlock:int;
      
      public var HPPerBlock:int;
      
      public var absorbRatio:int;
      
      public var costHeat:int;
      
      public var costEnergy:int;
      
      public var costGold:int;
      
      public var costTokens:int;
      
      public var costTokensDefault:int;
      
      public var animation:String;
      
      public var grp:String;
      
      public var specialStatus:int;
      
      public var power:int;
      
      public var weight:int;
      
      public var isInShop:Boolean;
      
      public var isDeprecated:Boolean;
      
      public function BMItemData(param1:ByteArray = null)
      {
         super();
         if(param1 != null)
         {
            this.readSelf(param1);
         }
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
         this.isDeprecated = false;
      }
      
      private function writeString(param1:ByteArray, param2:String) : *
      {
         param1.writeUTF(param2);
      }
      
      private function readString(param1:ByteArray) : String
      {
         return param1.readUTF();
      }
      
      public function writeSelf(param1:ByteArray) : *
      {
         param1.writeInt(this.itemID);
         this.writeString(param1,this.fullName);
         param1.writeInt(this.sortID);
         param1.writeInt(this.finalSortID);
         this.writeString(param1,this.type);
         this.writeString(param1,this.subType);
         param1.writeInt(this.level);
         param1.writeInt(this.displayLevel);
         param1.writeInt(this.upgradeToItemID);
         param1.writeInt(this.powerToUpgrade);
         param1.writeInt(this.minPowerToHave);
         param1.writeInt(this.materialPowerContribution);
         param1.writeInt(this.upgradeGoldCost);
         param1.writeInt(this.evolutionGoldCost);
         param1.writeInt(this.HPBase);
         param1.writeInt(this.HPAddon);
         param1.writeInt(this.energyBase);
         param1.writeInt(this.energyAddon);
         param1.writeInt(this.heatBase);
         param1.writeInt(this.heatAddon);
         param1.writeInt(this.bullets);
         param1.writeInt(this.rockets);
         param1.writeInt(this.damageBase);
         param1.writeInt(this.damageAddon);
         param1.writeInt(this.damageType);
         param1.writeInt(this.damageHeat);
         param1.writeInt(this.damageHeatBase);
         param1.writeInt(this.damageHeatAddon);
         param1.writeInt(this.damageEnergy);
         param1.writeInt(this.damageEnergyBase);
         param1.writeInt(this.damageEnergyAddon);
         param1.writeInt(this.uses);
         param1.writeInt(this.push);
         param1.writeInt(this.resist1);
         param1.writeInt(this.resist2);
         param1.writeInt(this.resist3);
         param1.writeInt(this.rangeBase);
         param1.writeInt(this.rangeAddon);
         param1.writeInt(this.stepsPerWalk);
         param1.writeInt(this.stepsPerJump);
         param1.writeInt(this.energyPerBlock);
         param1.writeInt(this.heatPerBlock);
         param1.writeInt(this.HPPerBlock);
         param1.writeInt(this.absorbRatio);
         param1.writeInt(this.costHeat);
         param1.writeInt(this.costEnergy);
         param1.writeInt(this.costGold);
         param1.writeInt(this.costTokens);
         param1.writeInt(this.costTokensDefault);
         this.writeString(param1,this.animation);
         this.writeString(param1,this.grp);
         param1.writeInt(this.specialStatus);
         param1.writeInt(this.power);
         param1.writeInt(this.weight);
         param1.writeBoolean(this.isInShop);
         param1.writeBoolean(this.isDeprecated);
      }
      
      public function readSelf(param1:ByteArray) : *
      {
         this.itemID = param1.readInt();
         this.fullName = this.readString(param1);
         this.sortID = param1.readInt();
         this.finalSortID = param1.readInt();
         this.type = this.readString(param1);
         this.subType = this.readString(param1);
         this.level = param1.readInt();
         this.displayLevel = param1.readInt();
         this.upgradeToItemID = param1.readInt();
         this.powerToUpgrade = param1.readInt();
         this.minPowerToHave = param1.readInt();
         this.materialPowerContribution = param1.readInt();
         this.upgradeGoldCost = param1.readInt();
         this.evolutionGoldCost = param1.readInt();
         this.HPBase = param1.readInt();
         this.HPAddon = param1.readInt();
         this.energyBase = param1.readInt();
         this.energyAddon = param1.readInt();
         this.heatBase = param1.readInt();
         this.heatAddon = param1.readInt();
         this.bullets = param1.readInt();
         this.rockets = param1.readInt();
         this.damageBase = param1.readInt();
         this.damageAddon = param1.readInt();
         this.damageType = param1.readInt();
         this.damageHeat = param1.readInt();
         this.damageHeatBase = param1.readInt();
         this.damageHeatAddon = param1.readInt();
         this.damageEnergy = param1.readInt();
         this.damageEnergyBase = param1.readInt();
         this.damageEnergyAddon = param1.readInt();
         this.uses = param1.readInt();
         this.push = param1.readInt();
         this.resist1 = param1.readInt();
         this.resist2 = param1.readInt();
         this.resist3 = param1.readInt();
         this.rangeBase = param1.readInt();
         this.rangeAddon = param1.readInt();
         this.stepsPerWalk = param1.readInt();
         this.stepsPerJump = param1.readInt();
         this.energyPerBlock = param1.readInt();
         this.heatPerBlock = param1.readInt();
         this.HPPerBlock = param1.readInt();
         this.absorbRatio = param1.readInt();
         this.costHeat = param1.readInt();
         this.costEnergy = param1.readInt();
         this.costGold = param1.readInt();
         this.costTokens = param1.readInt();
         this.costTokensDefault = param1.readInt();
         this.animation = this.readString(param1);
         this.grp = this.readString(param1);
         this.specialStatus = param1.readInt();
         this.power = param1.readInt();
         this.weight = param1.readInt();
         this.isInShop = param1.readBoolean();
         this.isDeprecated = param1.readBoolean();
      }
      
      public function isMaxLevel() : Boolean
      {
         if(FeatureFlags.NEW_ECONOMY)
         {
            return this.upgradeGoldCost <= 0;
         }
         return this.upgradeToItemID <= 0;
      }
      
      public function canEvolve() : Boolean
      {
         if(FeatureFlags.NEW_ECONOMY)
         {
            return this.isMaxLevel() && this.upgradeToItemID > 0;
         }
         return false;
      }
      
      public function get numOfItemsForTransform() : int
      {
         return this.specialStatus + 2;
      }
      
      public function get shortDescription() : String
      {
         return "item:" + this.itemID + " specialStatus:" + this.specialStatus + " displayLevel:" + this.displayLevel + " level (campaign):" + this.level + " fullName:" + this.fullName + " hp:" + (this.HPBase + this.HPAddon) + " damage:" + (this.damageBase + this.damageAddon);
      }
      
      public function get isWeapon() : Boolean
      {
         switch(this.type)
         {
            case "leg":
            case "sideWeapon":
            case "topWeapon":
            case "drone":
               return true;
            default:
               return false;
         }
      }
   }
}

