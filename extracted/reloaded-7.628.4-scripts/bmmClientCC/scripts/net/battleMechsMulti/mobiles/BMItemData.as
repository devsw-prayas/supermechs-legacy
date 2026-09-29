package net.battleMechsMulti.mobiles
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.managers.specialAbilities.BMMechSpecialAbilitiesResolver;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   public class BMItemData implements IExternalizable
   {
      
      public static const UPGRADABLE_ITEM_TYPES:Array = [BMMechStructure.TORSO,BMMechStructure.LEG,BMMechStructure.SIDE_WEAPON,BMMechStructure.TOP_WEAPON,BMMechStructure.DRONE,BMMechStructure.CHARGE,BMMechStructure.HARPOON,BMMechStructure.TELEPORT,BMMechStructure.KIT,BMMechStructure.MODULE,BMMechStructure.ENHANCER];
      
      public static const ELEMENT_NONE:int = 0;
      
      public static const ELEMENT_PHYSICAL:int = 1;
      
      public static const ELEMENT_HEAT:int = 2;
      
      public static const ELEMENT_ENERGY:int = 3;
      
      public static const MIN_POWER_RATING_TIER_0:uint = 0;
      
      public static const MIN_POWER_RATING_TIER_1:uint = 10;
      
      public static const MIN_POWER_RATING_TIER_2:uint = 30;
      
      public static const MIN_POWER_RATING_TIER_3:uint = 60;
      
      public static const MIN_POWER_RATING_TIER_4:uint = 100;
      
      public static const MIN_POWER_RATING_TIER_10:uint = 150;
      
      private static const PERK_TYPE_HAT:String = "hat";
      
      private static const PERK_TYPE_TORSO:String = "torso";
      
      private static const PERK_TYPE_SIZE_GIANT:String = "sizeGiant";
      
      private static const PERK_TYPE_SIZE_DWARF:String = "sizeDwarf";
      
      private static const PERK_TYPE_SHOTS:String = "shots";
      
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
      
      public var ascensionGoldCost:int;
      
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
      
      public var pushSelf:int;
      
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
      
      private var _grp:String;
      
      public var specialStatus:int;
      
      public var power:int;
      
      public var weight:int;
      
      public var isInShop:Boolean;
      
      public var isDeprecated:Boolean;
      
      public var chainID:uint;
      
      public var contentPackID:uint;
      
      public function BMItemData(param1:IDataInput = null)
      {
         super();
         if(param1 != null)
         {
            this.readExternal(param1);
         }
      }
      
      public static function canTypeBeColored(param1:String) : Boolean
      {
         return param1 == BMMechStructure.TORSO || param1 == BMMechStructure.LEG || param1 == BMMechStructure.SIDE_WEAPON || param1 == BMMechStructure.TOP_WEAPON || param1 == BMMechStructure.DRONE;
      }
      
      public function set grp(param1:String) : void
      {
         this._grp = param1;
      }
      
      public function get grp() : String
      {
         return BMDataManager.getInstance().getGeneralSetting("grpOverride_" + this._grp,this._grp);
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
         this.pushSelf = 0;
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
         this._grp = "";
         this.specialStatus = 0;
         this.power = 0;
         this.weight = 0;
         this.isInShop = false;
         this.isDeprecated = false;
         this.chainID = 0;
         this.contentPackID = 0;
      }
      
      private function writeString(param1:IDataOutput, param2:String) : *
      {
         param1.writeUTF(param2);
      }
      
      private function readString(param1:IDataInput) : String
      {
         return param1.readUTF();
      }
      
      public function writeExternal(param1:IDataOutput) : void
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
         param1.writeInt(this.ascensionGoldCost);
         param1.writeInt(this.HPBase);
         param1.writeInt(this.HPAddon);
         param1.writeInt(this.energyBase);
         param1.writeInt(this.energyAddon);
         param1.writeInt(this.heatBase);
         param1.writeInt(this.heatAddon);
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
         param1.writeInt(this.pushSelf);
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
         this.writeString(param1,this._grp);
         param1.writeInt(this.specialStatus);
         param1.writeInt(this.power);
         param1.writeInt(this.weight);
         param1.writeBoolean(this.isInShop);
         param1.writeBoolean(this.isDeprecated);
         param1.writeInt(this.chainID);
         param1.writeInt(this.contentPackID);
      }
      
      public function readExternal(param1:IDataInput) : void
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
         this.ascensionGoldCost = param1.readInt();
         this.HPBase = param1.readInt();
         this.HPAddon = param1.readInt();
         this.energyBase = param1.readInt();
         this.energyAddon = param1.readInt();
         this.heatBase = param1.readInt();
         this.heatAddon = param1.readInt();
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
         this.pushSelf = param1.readInt();
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
         this._grp = this.readString(param1);
         this.specialStatus = param1.readInt();
         this.power = param1.readInt();
         this.weight = param1.readInt();
         this.isInShop = param1.readBoolean();
         this.isDeprecated = param1.readBoolean();
         this.chainID = param1.readInt();
         this.contentPackID = param1.readInt();
      }
      
      public function isMaxLevel() : Boolean
      {
         if(FeatureFlags.BLOCK_TRANSFORM)
         {
            return this.upgradeToItemID == 0 || (this.evolutionGoldCost > 0 || this.ascensionGoldCost > 0);
         }
         return this.upgradeGoldCost <= 0;
      }
      
      public function get naturalTier() : uint
      {
         if(this.isDeprecated)
         {
            throw Error("cannot check natural tier for deprecated items");
         }
         var _loc1_:uint = BMSinglePlayerManager.gi().getItemFromChainByPowerRating(this.itemID,1);
         var _loc2_:BMItemData = BMDataManager.getInstance().itemsDB[_loc1_];
         return _loc2_.specialStatus;
      }
      
      public function canEvolve() : Boolean
      {
         if(FeatureFlags.BLOCK_TRANSFORM)
         {
            return false;
         }
         return this.isMaxLevel() && this.upgradeToItemID > 0 && !this.isDeprecated && this.ascensionGoldCost == 0;
      }
      
      public function canAscend() : Boolean
      {
         if(FeatureFlags.BLOCK_TRANSFORM)
         {
            return false;
         }
         return this.isMaxLevel() && this.upgradeToItemID > 0 && !this.isDeprecated && this.ascensionGoldCost > 0;
      }
      
      public function get isMaxEvolved() : Boolean
      {
         return this.upgradeToItemID == -1;
      }
      
      public function get isMaxedMythical() : Boolean
      {
         return this.isMaxLevel() && this.specialStatus == ItemRarityResolver.RARITY_MYTHICAL;
      }
      
      public function get numOfItemsForTransform() : int
      {
         switch(this.specialStatus)
         {
            case ItemRarityResolver.RARITY_COMMON:
               return 2;
            case ItemRarityResolver.RARITY_RARE:
               return 3;
            case ItemRarityResolver.RARITY_EPIC:
               return 4;
            case ItemRarityResolver.RARITY_LEGENDARY:
               return 5;
            case ItemRarityResolver.RARITY_MYTHICAL:
               if(this.naturalTier == ItemRarityResolver.RARITY_COMMON)
               {
                  return 2;
               }
               if(this.naturalTier == ItemRarityResolver.RARITY_RARE)
               {
                  return 3;
               }
               if(this.naturalTier == ItemRarityResolver.RARITY_EPIC)
               {
                  return 4;
               }
               return 5;
               break;
            default:
               throw Error("cannot return numOfItemsForTransform for rarity " + this.specialStatus);
         }
      }
      
      public function get isEnhancer() : Boolean
      {
         if(BMMechSpecialAbilitiesResolver.enhancersEnabled())
         {
            if(this.isDeprecated)
            {
               return false;
            }
            if(this.type == BMMechStructure.ENHANCER)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get enhancerCategory() : String
      {
         if(this.isEnhancer == false)
         {
            throw Error("BMItemData enhancerCategory: item is not an enhancer");
         }
         return BMMechSpecialAbilitiesResolver.getEnhancerCategoryBySpecialAbility(this.subType);
      }
      
      public function get enhancerKitCategory() : String
      {
         if(this.isEnhancerKit == false)
         {
            throw Error("BMItemData enhancerKitCategory: item is not an enhancer kit");
         }
         return this.subType;
      }
      
      public function get enhancerSlots() : Array
      {
         if(BMMechSpecialAbilitiesResolver.enhancersEnabled())
         {
            if(this.type == BMMechStructure.TORSO)
            {
               return [0,0,1,2,3];
            }
         }
         return new Array();
      }
      
      public function get canBeEnhanced() : Boolean
      {
         if(BMMechSpecialAbilitiesResolver.enhancersEnabled() == false)
         {
            return false;
         }
         if(this.type != BMMechStructure.TORSO)
         {
            return false;
         }
         return true;
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
      
      public function get powerRating() : uint
      {
         var _loc1_:uint = MIN_POWER_RATING_TIER_0;
         switch(this.specialStatus)
         {
            case 1:
               _loc1_ = MIN_POWER_RATING_TIER_1;
               break;
            case 2:
               _loc1_ = MIN_POWER_RATING_TIER_2;
               break;
            case 3:
               _loc1_ = MIN_POWER_RATING_TIER_3;
               break;
            case 4:
               _loc1_ = MIN_POWER_RATING_TIER_4;
               break;
            case 10:
               _loc1_ = MIN_POWER_RATING_TIER_10;
         }
         return uint(_loc1_ + this.displayLevel);
      }
      
      public function get isMultiEquipmentItem() : Boolean
      {
         return this.type == BMMechStructure.SIDE_WEAPON || this.type == BMMechStructure.TOP_WEAPON || this.type == BMMechStructure.MODULE || this.type == BMMechStructure.KIT;
      }
      
      public function get isColorKit() : Boolean
      {
         return this.type == BMMechStructure.KIT && this.subType == "color";
      }
      
      public function get isPowerKit() : Boolean
      {
         return this.type == BMMechStructure.KIT && this.subType == "power";
      }
      
      public function get isEnhancerKit() : Boolean
      {
         return this.type == BMMechStructure.KIT && BMMechSpecialAbilitiesResolver.ENHANCER_CATEGORIES.indexOf(this.subType) > -1;
      }
      
      public function get isTransformKit() : Boolean
      {
         return this.type == BMMechStructure.KIT && this.subType == "transform";
      }
      
      public function get isAscensionKit() : Boolean
      {
         return this.type == BMMechStructure.KIT && this.subType == "ascension";
      }
      
      public function get isStationaryLeg() : Boolean
      {
         if(this.type != BMMechStructure.LEG)
         {
            return false;
         }
         return this.stepsPerWalk == 0 && this.stepsPerJump == 0;
      }
      
      public function get isNoJumpingLeg() : Boolean
      {
         if(this.type != BMMechStructure.LEG)
         {
            return false;
         }
         return this.stepsPerJump == 0;
      }
      
      public function get isFireJumpWeapon() : Boolean
      {
         if(this.pushSelf == 0)
         {
            return false;
         }
         if(this.animation.indexOf("shotgun") > -1)
         {
            return false;
         }
         return true;
      }
      
      public function get isRecoilWeapon() : Boolean
      {
         if(this.pushSelf == 0)
         {
            return false;
         }
         return this.isFireJumpWeapon == false;
      }
      
      public function get specialStatusForDisplay() : int
      {
         return this.type == "perk" ? 0 : this.specialStatus;
      }
      
      public function get canBeUpgarded() : Boolean
      {
         return UPGRADABLE_ITEM_TYPES.indexOf(this.type) != -1;
      }
      
      public function get canBeColored() : Boolean
      {
         return canTypeBeColored(this.type);
      }
      
      public function get isPerk() : Boolean
      {
         if(this.type != BMMechStructure.PERK)
         {
            return false;
         }
         return this.isHatPerk || this.isTorsoPerk || this.isGiantSizePerk || this.isDwarfSizePerk || this.isShotsPerk;
      }
      
      public function get isHatPerk() : Boolean
      {
         return this.isSpecificPerk(PERK_TYPE_HAT);
      }
      
      public function get isTorsoPerk() : Boolean
      {
         return this.isSpecificPerk(PERK_TYPE_TORSO);
      }
      
      public function get isGiantSizePerk() : Boolean
      {
         return this.isSpecificPerk(PERK_TYPE_SIZE_GIANT);
      }
      
      public function get isDwarfSizePerk() : Boolean
      {
         return this.isSpecificPerk(PERK_TYPE_SIZE_DWARF);
      }
      
      public function get isShotsPerk() : Boolean
      {
         return this.isSpecificPerk(PERK_TYPE_SHOTS);
      }
      
      public function get perkMechAsset() : String
      {
         if(this.isPerk == false)
         {
            return "";
         }
         return this.animation;
      }
      
      private function isSpecificPerk(param1:String) : Boolean
      {
         return this.subType == param1;
      }
      
      public function getItemElement() : int
      {
         if(this.damageType > 0)
         {
            return this.damageType;
         }
         if(this.type == "module")
         {
            if(this.resist1 > 0 && this.resist2 > 0 && this.resist3 > 0)
            {
               return ELEMENT_NONE;
            }
            if(this.HPBase > 0 || this.resist1 > 0)
            {
               return ELEMENT_PHYSICAL;
            }
            if(this.heatBase > 0 || this.heatAddon > 0 || this.resist2 > 0)
            {
               return ELEMENT_HEAT;
            }
            if(this.energyBase > 0 || this.energyAddon > 0 || this.resist3 > 0)
            {
               return ELEMENT_ENERGY;
            }
         }
         else if(this.type == "torso")
         {
            if(this.energyBase == this.heatBase)
            {
               return ELEMENT_PHYSICAL;
            }
            if(this.energyBase < this.heatBase)
            {
               return ELEMENT_HEAT;
            }
            return ELEMENT_ENERGY;
         }
         return ELEMENT_NONE;
      }
      
      public function clone() : BMItemData
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeObject(this);
         _loc1_.position = 0;
         return _loc1_.readObject();
      }
   }
}

