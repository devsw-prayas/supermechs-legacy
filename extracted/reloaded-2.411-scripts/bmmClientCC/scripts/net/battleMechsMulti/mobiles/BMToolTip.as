package net.battleMechsMulti.mobiles
{
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMToolTip extends BMBaseClass
   {
      
      private static var _instance:BMToolTip;
      
      private static var _allowInstantiation:Boolean;
      
      private var titleText:TextField;
      
      private var mainText:TextField;
      
      private var equipmentText:TextField;
      
      public var mcMainHolder:Sprite;
      
      private var mcBackground:Sprite;
      
      private var mcIconsHolder:Sprite;
      
      private var mcHP:Sprite;
      
      private var mcRepair:Sprite;
      
      private var mcGold:Sprite;
      
      private var mcSellValue_gold:Sprite;
      
      private var mcTokens:Sprite;
      
      private var mcUses:Sprite;
      
      private var mcDamageType_physical:Sprite;
      
      private var mcDamageType_explosive:Sprite;
      
      private var mcDamageType_explosivePlus:Sprite;
      
      private var mcDamageType_electric:Sprite;
      
      private var mcDamageType_electricPlus:Sprite;
      
      private var mcResist_physical:Sprite;
      
      private var mcResist_explosive:Sprite;
      
      private var mcResist_electric:Sprite;
      
      private var mcDamageResist_physical:Sprite;
      
      private var mcDamageResist_explosive:Sprite;
      
      private var mcDamageResist_electric:Sprite;
      
      private var mcRange:Sprite;
      
      private var mcRangeInfinit:Sprite;
      
      private var mcHeat:Sprite;
      
      private var mcHeatCooling:Sprite;
      
      private var mcEnergy:Sprite;
      
      private var mcEnergyRegeneration:Sprite;
      
      private var mcDamageEnergyBase:Sprite;
      
      private var mcDamageEnergyAddon:Sprite;
      
      private var mcDamageHeatBase:Sprite;
      
      private var mcDamageHeatAddon:Sprite;
      
      private var mcBullets:Sprite;
      
      private var mcRockets:Sprite;
      
      private var mcShieldBlockEnergy:Sprite;
      
      private var mcShieldBlockHeat:Sprite;
      
      private var mcShieldEnergyPerBlock:Sprite;
      
      private var mcShieldHeatPerBlock:Sprite;
      
      private var mcShieldHPPerBlock:Sprite;
      
      private var mcPush:Sprite;
      
      private var mcPull:Sprite;
      
      private var mcMovementWalk:Sprite;
      
      private var mcMovementJump:Sprite;
      
      private var mcPowerRank:Sprite;
      
      private var mcPower:Sprite;
      
      private var mcWeight:Sprite;
      
      private var mcDurability:Sprite;
      
      private var mcItemType_topWeapon:Sprite;
      
      private var mcItemType_sideWeapon:Sprite;
      
      private var mcItemType_module:Sprite;
      
      private var mcItemType_kit:Sprite;
      
      private var _toolTipTitleText:String;
      
      private var _toolTipMainText:String;
      
      private var _toolTipEquipmentText:String;
      
      private var _initialY:Number;
      
      private var _yAddon:Number;
      
      private var _yAddonMultiplier:Number;
      
      private var _yAddonMultiplier_equipment:Number;
      
      private var _sideWeapons:Number;
      
      private var _topWeapons:Number;
      
      private var _drones:Number;
      
      private var _shields:Number;
      
      private var _teleports:Number;
      
      private var _charges:Number;
      
      private var _harpoons:Number;
      
      private var _kits:Number;
      
      private var _modules:Number;
      
      private var _damageTypeIcons:Array = new Array();
      
      private var _positionHandler:Boolean = false;
      
      private var _tooltipExtraHeight:Number;
      
      public var currentTooltipType:String = "";
      
      public var allowRepositionForMobile:Boolean = false;
      
      private var _mobileTooltipOriginMouseXPos:Number;
      
      private var _mobileTooltipOriginMouseYPos:Number;
      
      private const TITLE_TEXT_X:Number = 4;
      
      private const TITLE_TEXT_Y:Number = 2;
      
      private const MAIN_TEXT_X:Number = 4;
      
      private const MAIN_TEXT_Y:Number = 24;
      
      private const EQUIPMENT_TEXT_X:Number = 135;
      
      private const EQUIPMENT_TEXT_Y_ITEM:Number = 27;
      
      private const EQUIPMENT_TEXT_Y_MECH:Number = 21;
      
      private const REGULAR_ICON_X:Number = 5;
      
      private const EQUIPMENT_ICON_X:Number = 100;
      
      private const TOOLTIP_X_ADDON:Number = 30;
      
      private const TOOLTIP_Y_ADDON:Number = 30;
      
      private var ICONS_Y_INITIAL:Number = 26;
      
      private var ICONS_Y_ADDON:Number = 20.5;
      
      private var TEXT_FONT:String = "American Captain Eternal";
      
      private const TEXT_DEFAULT_COLOR:String = "CCCCCC";
      
      private const TEXT_GRAY_COLOR:String = "7F7F7F";
      
      private const TEXT_DEACTIVATE_COLOR:String = "CC0000";
      
      private const TEXT_ACTIVATE_COLOR:String = "00CC00";
      
      private const TEXT_DAMAGE_ENERGY_COLOR:String = "00CC00";
      
      private const TEXT_DAMAGE_HEAT_COLOR:String = "FF6600";
      
      private const TEXT_DAMAGE_MULTIPLIER_COLOR:String = "CC3399";
      
      private const TEXT_TECH_TITLE_COLOR:String = "FF9900";
      
      private const TEXT_TECH_RANK_COLOR:String = "0099FF";
      
      private var TEXT_SIZE:Number = 16;
      
      private const ATTRIBUTE_SIZE:Number = 20;
      
      private const EQUIPMENT_SIZE:Number = 38;
      
      private var TEXT_HIT_POINTS:String;
      
      private var TEXT_HIT_POINTS_KIT:String;
      
      private var TEXT_REPAIR:String;
      
      private var TEXT_ENERGY:String;
      
      private var TEXT_ENERGY_REGENERATION:String;
      
      private var TEXT_ENERGY_KIT:String;
      
      private var TEXT_HEAT:String;
      
      private var TEXT_HEAT_COOLING:String;
      
      private var TEXT_HEAT_KIT:String;
      
      private var TEXT_BULLETS:String;
      
      private var TEXT_BULLETS_CAPACITY:String;
      
      private var TEXT_BULLETS_KIT:String;
      
      private var TEXT_ROCKETS:String;
      
      private var TEXT_ROCKETS_CAPACITY:String;
      
      private var TEXT_ROCKETS_KIT:String;
      
      private var TEXT_RANGE:String;
      
      private var TEXT_USES:String;
      
      private var TEXT_RESIST1:String;
      
      private var TEXT_RESIST2:String;
      
      private var TEXT_RESIST3:String;
      
      private var TEXT_RESIST1_DAMAGE:String;
      
      private var TEXT_RESIST2_DAMAGE:String;
      
      private var TEXT_RESIST3_DAMAGE:String;
      
      private var TEXT_DAMAGE_ENERGY_BASE:String;
      
      private var TEXT_DAMAGE_ENERGY_ADDON:String;
      
      private var TEXT_DAMAGE_HEAT_BASE:String;
      
      private var TEXT_DAMAGE_HEAT_ADDON:String;
      
      private var TEXT_SINGLE_USE:String;
      
      private var TEXT_FOR_FUSION_ONLY:String;
      
      private var TEXT_PUSH:String;
      
      private var TEXT_PULL:String;
      
      private var TEXT_DAMAGE_TYPE1:String;
      
      private var TEXT_DAMAGE_TYPE2:String;
      
      private var TEXT_DAMAGE_TYPE3:String;
      
      private var TEXT_DAMAGE_EFFECT1:String;
      
      private var TEXT_DAMAGE_EFFECT2:String;
      
      private var TEXT_DAMAGE_EFFECT3:String;
      
      private var TEXT_DAMAGE_EFFECT4:String;
      
      private var TEXT_SELL_VALUE:String;
      
      private var TEXT_STEPS_PER_WALK:String;
      
      private var TEXT_STEPS_PER_JUMP:String;
      
      private var TEXT_COST_ENERGY:String;
      
      private var TEXT_COST_HEAT:String;
      
      private var TEXT_COST_BULLETS:String;
      
      private var TEXT_COST_ROCKETS:String;
      
      private var TEXT_SIDE_WEAPONS:String;
      
      private var TEXT_TOP_WEAPONS:String;
      
      private var TEXT_KITS:String;
      
      private var TEXT_MODULES:String;
      
      private var TEXT_SHIELD_ABSORB_RATIO:String;
      
      private var TEXT_SHIELD_ENERGY_PER_BLOCK1:String;
      
      private var TEXT_SHIELD_HEAT_PER_BLOCK1:String;
      
      private var TEXT_SHIELD_ENERGY_PER_BLOCK2:String;
      
      private var TEXT_SHIELD_ENERGY_DEACTIVATION:String;
      
      private var TEXT_SHIELD_HEAT_DEACTIVATION:String;
      
      private var TEXT_POWER:String;
      
      private var TEXT_WEIGHT:String;
      
      private var ATTRIBUTE_SPACES:String = "       ";
      
      private var TITLE_TEXT_BASE_TEXT:String;
      
      private var MAIN_TEXT_BASE_TEXT:String;
      
      private var EQUIPMENT_TEXT_BASE_TEXT:String;
      
      public function BMToolTip()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMToolTip.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : BMToolTip
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMToolTip();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMToolTip initialized");
         generateSingletonClassesPointers("tooltip");
         setLanguageManagerScreenName("tooltip");
         this.mcMainHolder = new Sprite();
         this.mcIconsHolder = new Sprite();
         this.mcBackground = new mcToolTipBackground();
         this.titleText = new TextField();
         this.titleText.x = this.TITLE_TEXT_X;
         this.titleText.y = this.TITLE_TEXT_Y;
         this.titleText.selectable = false;
         this.titleText.multiline = true;
         this.titleText.autoSize = TextFieldAutoSize.LEFT;
         this.titleText.embedFonts = true;
         this.titleText.antiAliasType = AntiAliasType.ADVANCED;
         this.titleText.filters = [new GlowFilter(0,1,3,3,200,1)];
         this.mainText = new TextField();
         this.mainText.x = this.MAIN_TEXT_X;
         this.mainText.y = this.MAIN_TEXT_Y;
         this.mainText.selectable = false;
         this.mainText.multiline = true;
         this.mainText.autoSize = TextFieldAutoSize.LEFT;
         this.mainText.embedFonts = true;
         this.mainText.antiAliasType = AntiAliasType.ADVANCED;
         this.mainText.filters = [new GlowFilter(0,1,3,3,200,1)];
         this.equipmentText = new TextField();
         TextUtils.updateTextFormat(this.equipmentText);
         this.equipmentText.x = this.EQUIPMENT_TEXT_X;
         this.equipmentText.selectable = false;
         this.equipmentText.multiline = true;
         this.equipmentText.autoSize = TextFieldAutoSize.LEFT;
         this.equipmentText.embedFonts = true;
         this.equipmentText.antiAliasType = AntiAliasType.ADVANCED;
         this.equipmentText.filters = [new GlowFilter(0,1,3,3,200,1)];
         this.mcMainHolder.addChild(this.mcBackground);
         this.mcMainHolder.addChild(this.mcIconsHolder);
         this.mcMainHolder.addChild(this.titleText);
         this.mcMainHolder.addChild(this.mainText);
         this.mcMainHolder.addChild(this.equipmentText);
         this.languageUpdate(true);
      }
      
      public function externalAssetsLoaded() : void
      {
         this.mcHP = externalAssetsM.getAsset("general","icon_HP",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcRepair = externalAssetsM.getAsset("general","icon_repair",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcGold = externalAssetsM.getAsset("general","icon_gold",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcSellValue_gold = externalAssetsM.getAsset("general","icon_sellValue_gold",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcTokens = externalAssetsM.getAsset("general","icon_tokens",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcUses = externalAssetsM.getAsset("general","icon_uses",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageType_physical = externalAssetsM.getAsset("general","icon_damageType_physical",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageType_explosive = externalAssetsM.getAsset("general","icon_damageType_explosive",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageType_explosivePlus = externalAssetsM.getAsset("general","icon_damageType_explosivePlus",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageType_electric = externalAssetsM.getAsset("general","icon_damageType_electric",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageType_electricPlus = externalAssetsM.getAsset("general","icon_damageType_electricPlus",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcResist_physical = externalAssetsM.getAsset("general","icon_resist_physical",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcResist_explosive = externalAssetsM.getAsset("general","icon_resist_explosive",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcResist_electric = externalAssetsM.getAsset("general","icon_resist_electric",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageResist_physical = externalAssetsM.getAsset("general","icon_damageResist_physical",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageResist_explosive = externalAssetsM.getAsset("general","icon_damageResist_explosive",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageResist_electric = externalAssetsM.getAsset("general","icon_damageResist_electric",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcRange = externalAssetsM.getAsset("general","icon_range",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcRangeInfinit = externalAssetsM.getAsset("general","icon_rangeInfinit",28,this.ATTRIBUTE_SIZE,false,false);
         this.mcHeat = externalAssetsM.getAsset("general","icon_heat",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcHeatCooling = externalAssetsM.getAsset("general","icon_heatCooling",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcEnergy = externalAssetsM.getAsset("general","icon_energy",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcEnergyRegeneration = externalAssetsM.getAsset("general","icon_energyRegeneration",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageHeatBase = externalAssetsM.getAsset("general","icon_damageHeatBase",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageHeatAddon = externalAssetsM.getAsset("general","icon_damageHeatAddon",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageEnergyBase = externalAssetsM.getAsset("general","icon_damageEnergyBase",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDamageEnergyAddon = externalAssetsM.getAsset("general","icon_damageEnergyAddon",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcBullets = externalAssetsM.getAsset("general","icon_bullets",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcRockets = externalAssetsM.getAsset("general","icon_rockets",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcShieldBlockEnergy = externalAssetsM.getAsset("general","icon_shieldBlock",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcShieldBlockHeat = externalAssetsM.getAsset("general","icon_shieldBlockHeat",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcShieldEnergyPerBlock = externalAssetsM.getAsset("general","icon_energy",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcShieldHeatPerBlock = externalAssetsM.getAsset("general","icon_heat",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcShieldHPPerBlock = externalAssetsM.getAsset("general","icon_HP",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcPush = externalAssetsM.getAsset("general","icon_push",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcPull = externalAssetsM.getAsset("general","icon_pull",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcMovementWalk = externalAssetsM.getAsset("general","icon_movement_walk",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcMovementJump = externalAssetsM.getAsset("general","icon_movement_jump",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcPower = externalAssetsM.getAsset("general","icon_power",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcWeight = externalAssetsM.getAsset("general","icon_weight",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcDurability = externalAssetsM.getAsset("general","icon_durability",this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcItemType_topWeapon = externalAssetsM.getAsset("general","emptyItem_topWeaponLeft",this.EQUIPMENT_SIZE,this.EQUIPMENT_SIZE,false,false);
         this.mcItemType_sideWeapon = externalAssetsM.getAsset("general","emptyItem_sideWeaponLeft",this.EQUIPMENT_SIZE,this.EQUIPMENT_SIZE,false,false);
         this.mcItemType_module = externalAssetsM.getAsset("general","emptyItem_module",this.EQUIPMENT_SIZE,this.EQUIPMENT_SIZE,false,false);
         this.mcItemType_kit = externalAssetsM.getAsset("general","emptyItem_kit",this.EQUIPMENT_SIZE,this.EQUIPMENT_SIZE,false,false);
         this.mcHP.x = this.REGULAR_ICON_X;
         this.mcRepair.x = this.REGULAR_ICON_X;
         this.mcGold.x = this.REGULAR_ICON_X;
         this.mcSellValue_gold.x = this.REGULAR_ICON_X;
         this.mcTokens.x = this.REGULAR_ICON_X;
         this.mcUses.x = this.REGULAR_ICON_X;
         this.mcDamageType_physical.x = this.REGULAR_ICON_X;
         this.mcDamageType_explosive.x = this.REGULAR_ICON_X;
         this.mcDamageType_explosivePlus.x = this.REGULAR_ICON_X;
         this.mcDamageType_electric.x = this.REGULAR_ICON_X;
         this.mcDamageType_electricPlus.x = this.REGULAR_ICON_X;
         this.mcResist_physical.x = this.REGULAR_ICON_X;
         this.mcResist_explosive.x = this.REGULAR_ICON_X;
         this.mcResist_electric.x = this.REGULAR_ICON_X;
         this.mcDamageResist_physical.x = this.REGULAR_ICON_X;
         this.mcDamageResist_explosive.x = this.REGULAR_ICON_X;
         this.mcDamageResist_electric.x = this.REGULAR_ICON_X;
         this.mcRange.x = this.REGULAR_ICON_X;
         this.mcHeat.x = this.REGULAR_ICON_X;
         this.mcHeatCooling.x = this.REGULAR_ICON_X;
         this.mcEnergy.x = this.REGULAR_ICON_X;
         this.mcEnergyRegeneration.x = this.REGULAR_ICON_X;
         this.mcDamageHeatBase.x = this.REGULAR_ICON_X;
         this.mcDamageHeatAddon.x = this.REGULAR_ICON_X;
         this.mcDamageEnergyBase.x = this.REGULAR_ICON_X;
         this.mcDamageEnergyAddon.x = this.REGULAR_ICON_X;
         this.mcBullets.x = this.REGULAR_ICON_X;
         this.mcRockets.x = this.REGULAR_ICON_X;
         this.mcShieldBlockEnergy.x = this.REGULAR_ICON_X;
         this.mcShieldBlockHeat.x = this.REGULAR_ICON_X;
         this.mcShieldEnergyPerBlock.x = this.REGULAR_ICON_X;
         this.mcShieldHeatPerBlock.x = this.REGULAR_ICON_X;
         this.mcShieldHPPerBlock.x = this.REGULAR_ICON_X;
         this.mcPush.x = this.REGULAR_ICON_X;
         this.mcPull.x = this.REGULAR_ICON_X;
         this.mcMovementWalk.x = this.REGULAR_ICON_X;
         this.mcMovementJump.x = this.REGULAR_ICON_X;
         this.mcPower.x = this.REGULAR_ICON_X;
         this.mcWeight.x = this.REGULAR_ICON_X;
         this.mcDurability.x = this.REGULAR_ICON_X;
         this.mcRangeInfinit.x = 24;
         this.mcItemType_topWeapon.x = this.REGULAR_ICON_X;
         this.mcItemType_sideWeapon.x = this.REGULAR_ICON_X;
         this.mcItemType_module.x = this.REGULAR_ICON_X;
         this.mcItemType_kit.x = this.REGULAR_ICON_X;
         this._damageTypeIcons[1] = this.mcDamageType_physical;
         this._damageTypeIcons[2] = this.mcDamageType_explosive;
         this._damageTypeIcons[3] = this.mcDamageType_electric;
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID || param1)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.titleText);
            TextUtils.updateTextFormat(this.mainText);
            switch(dataM.languageID)
            {
               case 3:
               case 4:
               case 6:
               case 7:
               case 8:
               case 9:
               case 10:
                  this.ICONS_Y_INITIAL = 26;
                  this.ICONS_Y_ADDON = 21;
                  this.ATTRIBUTE_SPACES = "     ";
                  break;
               default:
                  this.ATTRIBUTE_SPACES = "       ";
                  this.ICONS_Y_INITIAL = 26;
                  this.ICONS_Y_ADDON = 20.5;
            }
            this.createTexts();
         }
      }
      
      public function showToolTip(param1:String, param2:String, param3:Number = -1, param4:Number = -1) : void
      {
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:BMPlayerData = null;
         var _loc7_:BMMechStructure = null;
         var _loc8_:String = null;
         var _loc9_:BMMechBattleData = null;
         var _loc10_:uint = 0;
         var _loc11_:BMItemData = null;
         var _loc12_:Number = NaN;
         var _loc13_:Sprite = null;
         var _loc15_:BMPlayerItemData = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:Boolean = false;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Boolean = false;
         var _loc32_:String = null;
         var _loc33_:String = null;
         var _loc34_:String = null;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:uint = 0;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Boolean = false;
         var _loc44_:int = 0;
         var _loc45_:String = null;
         var _loc46_:String = null;
         var _loc47_:uint = 0;
         var _loc48_:uint = 0;
         var _loc49_:uint = 0;
         var _loc50_:uint = 0;
         var _loc51_:uint = 0;
         var _loc52_:uint = 0;
         var _loc53_:uint = 0;
         var _loc54_:Number = NaN;
         var _loc55_:Number = NaN;
         var _loc56_:Number = NaN;
         var _loc57_:uint = 0;
         var _loc58_:uint = 0;
         var _loc59_:BMPlayerItemData = null;
         var _loc60_:BMItemData = null;
         var _loc61_:uint = 0;
         var _loc62_:BMItemData = null;
         var _loc63_:String = null;
         this.languageUpdate();
         this.currentTooltipType = param1;
         this.removeIcon(this.mcHP);
         this.removeIcon(this.mcRepair);
         this.removeIcon(this.mcGold);
         this.removeIcon(this.mcSellValue_gold);
         this.removeIcon(this.mcTokens);
         this.removeIcon(this.mcUses);
         this.removeIcon(this.mcDamageType_physical);
         this.removeIcon(this.mcDamageType_explosive);
         this.removeIcon(this.mcDamageType_explosivePlus);
         this.removeIcon(this.mcDamageType_electric);
         this.removeIcon(this.mcDamageType_electricPlus);
         this.removeIcon(this.mcResist_physical);
         this.removeIcon(this.mcResist_explosive);
         this.removeIcon(this.mcResist_electric);
         this.removeIcon(this.mcDamageResist_physical);
         this.removeIcon(this.mcDamageResist_explosive);
         this.removeIcon(this.mcDamageResist_electric);
         this.removeIcon(this.mcRange);
         this.removeIcon(this.mcRangeInfinit);
         this.removeIcon(this.mcHeat);
         this.removeIcon(this.mcHeatCooling);
         this.removeIcon(this.mcEnergy);
         this.removeIcon(this.mcEnergyRegeneration);
         this.removeIcon(this.mcDamageHeatBase);
         this.removeIcon(this.mcDamageHeatAddon);
         this.removeIcon(this.mcDamageEnergyBase);
         this.removeIcon(this.mcDamageEnergyAddon);
         this.removeIcon(this.mcBullets);
         this.removeIcon(this.mcRockets);
         this.removeIcon(this.mcShieldBlockEnergy);
         this.removeIcon(this.mcShieldBlockHeat);
         this.removeIcon(this.mcShieldEnergyPerBlock);
         this.removeIcon(this.mcShieldHeatPerBlock);
         this.removeIcon(this.mcShieldHPPerBlock);
         this.removeIcon(this.mcPush);
         this.removeIcon(this.mcPull);
         this.removeIcon(this.mcMovementWalk);
         this.removeIcon(this.mcMovementJump);
         this.removeIcon(this.mcItemType_sideWeapon);
         this.removeIcon(this.mcItemType_topWeapon);
         this.removeIcon(this.mcItemType_module);
         this.removeIcon(this.mcItemType_kit);
         this.removeIcon(this.mcPowerRank);
         this.removeIcon(this.mcPower);
         this.removeIcon(this.mcWeight);
         this.removeIcon(this.mcDurability);
         this.mcResist_explosive.x = this.REGULAR_ICON_X;
         this.mcResist_electric.x = this.REGULAR_ICON_X;
         var _loc14_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc23_:Boolean = false;
         this._toolTipTitleText = this.TITLE_TEXT_BASE_TEXT;
         this._toolTipMainText = this.MAIN_TEXT_BASE_TEXT;
         this._toolTipEquipmentText = this.EQUIPMENT_TEXT_BASE_TEXT;
         if(this.mcMainHolder.parent == null)
         {
            addChild(this.mcMainHolder);
         }
         switch(param1)
         {
            case "regularText":
               this._toolTipTitleText += param2;
               break;
            case "floorBuff":
               _loc26_ = "";
               switch(param2)
               {
                  case "damage":
                     switch(param3)
                     {
                        case 1:
                           _loc26_ = "     +" + dataM.floorBuff_damageAddon + "%";
                           this.mcDamageType_physical.y = 5;
                           this.mcIconsHolder.addChild(this.mcDamageType_physical);
                           break;
                        case 2:
                           _loc26_ = "     +" + dataM.floorBuff_damageAddon + "%";
                           this.mcDamageType_explosive.y = 5;
                           this.mcIconsHolder.addChild(this.mcDamageType_explosive);
                           break;
                        case 3:
                           _loc26_ = "     +" + dataM.floorBuff_damageAddon + "%";
                           this.mcDamageType_electric.y = 5;
                           this.mcIconsHolder.addChild(this.mcDamageType_electric);
                     }
                     break;
                  case "damageHeat":
                     this.mcHeat.y = 5;
                     this.mcIconsHolder.addChild(this.mcHeat);
                     _loc26_ = "     +" + dataM.floorBuff_heatDamageAddon + "% Heat damage";
                     break;
                  case "damageEnergy":
                     this.mcEnergy.y = 5;
                     this.mcIconsHolder.addChild(this.mcEnergy);
                     _loc26_ = "     +" + dataM.floorBuff_energyDamageAddon + "% Energy damage";
                     break;
                  case "ignoreResistance":
                     this.mcResist_physical.y = 5;
                     this.mcResist_explosive.x = this.mcResist_physical.x + this.ATTRIBUTE_SIZE + 3;
                     this.mcResist_explosive.y = 5;
                     this.mcResist_electric.x = this.mcResist_explosive.x + this.ATTRIBUTE_SIZE + 3;
                     this.mcResist_electric.y = 5;
                     this.mcIconsHolder.addChild(this.mcResist_physical);
                     this.mcIconsHolder.addChild(this.mcResist_explosive);
                     this.mcIconsHolder.addChild(this.mcResist_electric);
                     _loc26_ = "                    Ignored";
                     break;
                  case "energyRegeneration":
                     this.mcEnergyRegeneration.y = 5;
                     this.mcIconsHolder.addChild(this.mcEnergyRegeneration);
                     _loc26_ = "     +" + dataM.floorBuff_energyRegenerationAddon + "%";
                     break;
                  case "heatCooling":
                     this.mcHeatCooling.y = 5;
                     this.mcIconsHolder.addChild(this.mcHeatCooling);
                     _loc26_ = "     +" + dataM.floorBuff_heatCoolingAddon + "%";
               }
               this._toolTipTitleText += _loc26_;
               break;
            case "newsItem":
               _loc14_ = true;
               _loc17_ = true;
               this.equipmentText.y = this.EQUIPMENT_TEXT_Y_ITEM;
               break;
            case "inventory":
               _loc14_ = true;
               _loc17_ = true;
               _loc19_ = true;
               if(!FeatureFlags.NEW_ECONOMY)
               {
                  _loc20_ = true;
               }
               this.equipmentText.y = this.EQUIPMENT_TEXT_Y_ITEM;
               break;
            case "battleInterface":
               _loc16_ = true;
               break;
            case "inspectMech":
               _loc21_ = true;
               break;
            case "tokens":
               _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc27_ = getScreenText("tokensDetails");
               _loc27_ = dataM.replaceStringInText(_loc27_,"%SUPPORTER%",dataM.getNumberWithComma(_loc5_.tokens_supporter));
               _loc27_ = dataM.replaceStringInText(_loc27_,"%BONUS%",dataM.getNumberWithComma(_loc5_.tokens_bonus));
               this._toolTipTitleText += _loc27_;
         }
         this._initialY = this.ICONS_Y_INITIAL;
         this._yAddon = this.ICONS_Y_ADDON;
         this._yAddonMultiplier = 0;
         this._yAddonMultiplier_equipment = 0;
         this._tooltipExtraHeight = 0;
         if(_loc14_)
         {
            _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc28_ = false;
            if(param1 == "inventory")
            {
               _loc15_ = dataM.getPlayerItemData(dataM.player1PlayerID,param3);
               _loc11_ = dataM.itemsDB[_loc15_.itemID];
               _loc10_ = 0;
               while(_loc10_ < _loc5_.newItemsPurchased.length)
               {
                  if(_loc5_.newItemsPurchased[_loc10_] == param3)
                  {
                     _loc28_ = true;
                     _loc10_ = _loc5_.newItemsPurchased.length;
                  }
                  _loc10_++;
               }
            }
            else if(param1 == "newsItem")
            {
               _loc11_ = dataM.itemsDB[param3];
            }
            _loc29_ = this.getItemCompareScore(_loc11_.itemID);
            _loc30_ = 0;
            _loc31_ = true;
            _loc6_ = dataM.playersData[dataM.player1PlayerID];
            _loc7_ = _loc6_.mechStructures[1];
            switch(_loc11_.type)
            {
               case "torso":
               case "leg":
               case "drone":
               case "harpoon":
               case "teleport":
               case "shield":
               case "charge":
                  if(_loc7_[_loc11_.type] > 0)
                  {
                     _loc30_ = this.getItemCompareScore(dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_[_loc11_.type]).itemID);
                  }
                  break;
               case "kit":
               case "perk":
                  _loc31_ = false;
                  break;
               default:
                  if(_loc7_[_loc11_.type + "1"] > 0)
                  {
                     _loc30_ = this.getItemCompareScore(dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_[_loc11_.type + "1"]).itemID);
                  }
            }
            _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc5_.level >= 30)
            {
               _loc31_ = false;
            }
            else if(param1 == "inventory")
            {
               if(_loc15_.equipped > 0)
               {
                  _loc31_ = false;
               }
            }
            _loc31_ = false;
            _loc32_ = "";
            if(_loc31_)
            {
               if(_loc30_ == 0)
               {
                  _loc32_ = "<FONT COLOR=\'#00CC00\'>++ MUCH STRONGER</FONT>";
               }
               else if(_loc29_ / _loc30_ < 0.5)
               {
                  _loc32_ = "<FONT COLOR=\'#CC3300\'>--- MUCH WEAKER</FONT>";
               }
               else if(_loc29_ / _loc30_ < 0.7)
               {
                  _loc32_ = "<FONT COLOR=\'#CC3300\'>-- MUCH WEAKER</FONT>";
               }
               else if(_loc29_ / _loc30_ < 0.95)
               {
                  _loc32_ = "<FONT COLOR=\'#CC3300\'>- WEAKER</FONT>";
               }
               else if(_loc29_ / _loc30_ < 1.05)
               {
                  _loc32_ = "<FONT COLOR=\'#7F7F7F\'>EQUAL</FONT>";
               }
               else if(_loc29_ / _loc30_ < 1.3)
               {
                  _loc32_ = "<FONT COLOR=\'#00CC00\'>+ STRONGER</FONT>";
               }
               else if(_loc29_ / _loc30_ < 1.5)
               {
                  _loc32_ = "<FONT COLOR=\'#00CC00\'>++ MUCH STRONGER</FONT>";
               }
               else
               {
                  _loc32_ = "<FONT COLOR=\'#00CC00\'>+++ MUCH STRONGER</FONT>";
               }
            }
            _loc33_ = "";
            if(dataM.languageID == 2)
            {
               _loc33_ = getSpecificText("item_" + _loc11_.itemID);
            }
            else
            {
               _loc33_ = _loc11_.fullName;
            }
            _loc34_ = "";
            switch(_loc11_.specialStatus)
            {
               case 1:
                  _loc34_ = dataM.COLOR_RARE_ITEM;
                  break;
               case 2:
                  _loc34_ = dataM.COLOR_EPIC_ITEM;
                  break;
               case 3:
                  _loc34_ = dataM.COLOR_LEGENDARY_ITEM;
                  break;
               case 4:
                  _loc34_ = dataM.COLOR_MYTHICAL_ITEM;
                  break;
               case 5:
                  _loc34_ = dataM.COLOR_PERK;
            }
            if(_loc34_ != "")
            {
               _loc33_ = "<FONT COLOR=\'#" + _loc34_ + "\'>" + _loc33_ + "</FONT>";
            }
            if(dataM.clientRunningLocally)
            {
               _loc33_ = _loc33_ + " " + _loc11_.itemID;
            }
            this._toolTipTitleText = this._toolTipTitleText + "<B>" + _loc33_ + "</B>";
            if(_loc32_ != "")
            {
               this._toolTipMainText += _loc32_;
               this._toolTipMainText += "<BR>";
               this._toolTipEquipmentText += "<BR>";
               ++this._yAddonMultiplier;
               ++this._yAddonMultiplier_equipment;
            }
            if(_loc17_)
            {
               switch(_loc11_.type)
               {
                  case "drone":
                  case "shield":
                  case "teleport":
                  case "charge":
                  case "harpoon":
                     _loc39_ = uint(dataM.equipmentUnlockDB[_loc11_.type].level);
                     if(_loc5_.level < _loc39_)
                     {
                        this._toolTipMainText = this._toolTipMainText + "<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>Level required : " + _loc39_ + "</FONT><BR>";
                        ++this._yAddonMultiplier;
                        ++this._yAddonMultiplier_equipment;
                     }
               }
               if(_loc11_.weight > 0)
               {
                  this.displayIcon(this.mcWeight);
                  this._toolTipMainText = this._toolTipMainText + this.ATTRIBUTE_SPACES + _loc11_.weight + "  " + this.TEXT_WEIGHT + "<BR>";
                  this._toolTipEquipmentText += "<BR>";
               }
               ++this._yAddonMultiplier;
               ++this._yAddonMultiplier_equipment;
            }
            if(_loc19_)
            {
               if(dataM.isColorKit(_loc15_.itemID) == false)
               {
                  _loc40_ = _loc15_.power;
                  _loc41_ = dataM.getItemCurrentPowerLevel(dataM.player1PlayerID,_loc15_.playerItemID);
                  _loc42_ = _loc41_ + 1;
                  _loc43_ = false;
                  switch(_loc11_.type)
                  {
                     case "drone":
                     case "teleport":
                     case "charge":
                     case "harpoon":
                        _loc43_ = true;
                  }
                  _loc44_ = _loc11_.powerToUpgrade;
                  switch(_loc11_.type)
                  {
                     case "torso":
                     case "leg":
                     case "sideWeapon":
                     case "topWeapon":
                        this._toolTipMainText = this._toolTipMainText + this.ATTRIBUTE_SPACES + getGeneralText("powerLevel") + " : " + _loc41_ + "  <FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>( " + dataM.getNumberWithComma(_loc40_) + " / " + dataM.getNumberWithComma(_loc44_) + " )</FONT><BR>";
                        break;
                     default:
                        if(_loc11_.type == "kit" && _loc11_.subType == "power")
                        {
                           this._toolTipMainText = this._toolTipMainText + "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>" + "Power Contribution" + " : " + dataM.getNumberWithComma(_loc11_.materialPowerContribution) + "</FONT><BR>";
                        }
                        else if(_loc43_)
                        {
                           this._toolTipMainText = this._toolTipMainText + this.ATTRIBUTE_SPACES + getGeneralText("powerLevel") + " : " + _loc41_ + "  <FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>( " + dataM.getNumberWithComma(_loc40_) + " / " + dataM.getNumberWithComma(_loc44_) + " )</FONT><BR>";
                        }
                        else
                        {
                           this._toolTipMainText = this._toolTipMainText + "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>" + getGeneralText("power") + " : " + dataM.getNumberWithComma(_loc40_) + "</FONT><BR>";
                        }
                  }
                  if(_loc15_.durability > 0)
                  {
                     this._toolTipMainText = this._toolTipMainText + this.ATTRIBUTE_SPACES + "<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>" + getScreenText("durability") + " : " + _loc15_.durability + "</FONT><BR>";
                     this.displayIcon(this.mcDurability);
                  }
                  this._toolTipEquipmentText += "<BR>";
                  ++this._yAddonMultiplier;
                  ++this._yAddonMultiplier_equipment;
               }
            }
            _loc22_ = true;
            _loc36_ = 0;
            _loc37_ = 0;
            _loc38_ = 0;
            switch(_loc11_.type)
            {
               case "torso":
                  if(_loc20_)
                  {
                     _loc35_ = dataM.getItemCurrentPowerLevel(dataM.player1PlayerID,_loc15_.playerItemID);
                     _loc36_ = dataM.powerLevelsDB_regular[_loc11_.displayLevel].bonusHP * (_loc35_ - 1);
                     this.displayPowerRankIcon(_loc35_);
                  }
                  this.displayIconAndText_regular(this.mcHP,_loc11_.HPBase,_loc36_,"",this.TEXT_HIT_POINTS);
                  this.displayIconAndText_regular(this.mcEnergy,_loc11_.energyBase,0,"",this.TEXT_ENERGY);
                  this.displayIconAndText_regular(this.mcEnergyRegeneration,_loc11_.energyAddon,0,"",this.TEXT_ENERGY_REGENERATION);
                  this.displayIconAndText_regular(this.mcHeat,_loc11_.heatBase,0,"",this.TEXT_HEAT);
                  this.displayIconAndText_regular(this.mcHeatCooling,_loc11_.heatAddon,0,"",this.TEXT_HEAT_COOLING);
                  this.displayIconAndText_regular(this.mcBullets,_loc11_.bullets,0,"",this.TEXT_BULLETS_CAPACITY);
                  this.displayIconAndText_regular(this.mcRockets,_loc11_.rockets,0,"",this.TEXT_ROCKETS_CAPACITY);
                  if(this.itemHasResistances(_loc11_))
                  {
                     this._toolTipMainText += "<BR>";
                     ++this._yAddonMultiplier;
                     this.displayIconAndText_itemResistance(this.mcResist_physical,_loc11_,1);
                     this.displayIconAndText_itemResistance(this.mcResist_explosive,_loc11_,2);
                     this.displayIconAndText_itemResistance(this.mcResist_electric,_loc11_,3);
                  }
                  break;
               case "leg":
                  this.displayIconAndText_regular(this.mcHP,_loc11_.HPBase,0,"",this.TEXT_HIT_POINTS);
                  this.displayIconAndText_regular(this.mcMovementWalk,_loc11_.stepsPerWalk,0,"",this.TEXT_STEPS_PER_WALK);
                  this.displayIconAndText_regular(this.mcMovementJump,_loc11_.stepsPerJump,0,"",this.TEXT_STEPS_PER_JUMP);
                  this._toolTipMainText += "<BR>";
                  ++this._yAddonMultiplier;
                  _loc12_ = _loc11_.damageType;
                  _loc13_ = this._damageTypeIcons[int(_loc12_)];
                  if(_loc20_)
                  {
                     _loc35_ = dataM.getItemCurrentPowerLevel(dataM.player1PlayerID,_loc15_.playerItemID);
                     _loc37_ = dataM.powerLevelsDB_regular[_loc35_].bonusDamage * (_loc35_ - 1);
                     this.displayPowerRankIcon(_loc35_);
                  }
                  this.displayIconAndText_weapon(_loc13_,_loc11_,_loc37_);
                  if(_loc11_.uses > 0)
                  {
                     this.displayIconAndText_regular(this.mcUses,_loc11_.uses,0,"",this.TEXT_USES);
                  }
                  if(_loc11_.push != 0)
                  {
                     if(_loc11_.push > 0)
                     {
                        this.displayIconAndText_regular(this.mcPush,_loc11_.push,0,"",this.TEXT_PUSH);
                     }
                     else
                     {
                        this.displayIconAndText_regular(this.mcPull,Math.abs(_loc11_.push),0,"",this.TEXT_PULL);
                     }
                  }
                  if(this.itemHasResistances(_loc11_))
                  {
                     this._toolTipMainText += "<BR>";
                     ++this._yAddonMultiplier;
                     this.displayIconAndText_itemResistance(this.mcResist_physical,_loc11_,1);
                     this.displayIconAndText_itemResistance(this.mcResist_explosive,_loc11_,2);
                     this.displayIconAndText_itemResistance(this.mcResist_electric,_loc11_,3);
                  }
                  break;
               case "sideWeapon":
               case "topWeapon":
               case "drone":
               case "teleport":
               case "charge":
               case "harpoon":
                  if(_loc20_)
                  {
                     switch(_loc11_.type)
                     {
                        case "sideWeapon":
                        case "topWeapon":
                           _loc35_ = dataM.getItemCurrentPowerLevel(dataM.player1PlayerID,_loc15_.playerItemID);
                           if(!FeatureFlags.NEW_ECONOMY)
                           {
                              _loc37_ = dataM.powerLevelsDB_regular[_loc11_.displayLevel].bonusDamage * (_loc35_ - 1);
                           }
                           break;
                        case "drone":
                        case "teleport":
                        case "charge":
                        case "harpoon":
                           _loc35_ = dataM.getItemCurrentPowerLevel(dataM.player1PlayerID,_loc15_.playerItemID);
                           if(!FeatureFlags.NEW_ECONOMY)
                           {
                              if(_loc11_.type == "drone" && _loc11_.HPAddon > 0)
                              {
                                 _loc38_ = dataM.powerLevelsDB_special[_loc11_.displayLevel].bonusRepair * (_loc35_ - 1);
                              }
                              else
                              {
                                 _loc37_ = dataM.powerLevelsDB_special[_loc11_.displayLevel].bonusDamage * (_loc35_ - 1);
                              }
                           }
                     }
                  }
                  if(_loc11_.HPAddon > 0)
                  {
                     this.displayIconAndText_regular(this.mcRepair,_loc11_.HPAddon,_loc38_,"",this.TEXT_REPAIR);
                  }
                  if(_loc11_.resist1 > 0)
                  {
                     this.displayIconAndText_regular(this.mcDamageResist_physical,_loc11_.resist1,0,"",this.TEXT_RESIST1_DAMAGE);
                  }
                  if(_loc11_.resist2 > 0)
                  {
                     this.displayIconAndText_regular(this.mcDamageResist_explosive,_loc11_.resist2,0,"",this.TEXT_RESIST2_DAMAGE);
                  }
                  if(_loc11_.resist3 > 0)
                  {
                     this.displayIconAndText_regular(this.mcDamageResist_electric,_loc11_.resist3,0,"",this.TEXT_RESIST3_DAMAGE);
                  }
                  if(_loc11_.damageEnergyBase > 0)
                  {
                     this.displayIconAndText_regular(this.mcDamageEnergyBase,_loc11_.damageEnergyBase,0,"",this.TEXT_DAMAGE_ENERGY_BASE);
                  }
                  if(_loc11_.damageEnergyAddon > 0)
                  {
                     this.displayIconAndText_regular(this.mcDamageEnergyAddon,_loc11_.damageEnergyAddon,0,"",this.TEXT_DAMAGE_ENERGY_ADDON);
                  }
                  if(_loc11_.damageHeatBase > 0)
                  {
                     this.displayIconAndText_regular(this.mcDamageHeatBase,_loc11_.damageHeatBase,0,"",this.TEXT_DAMAGE_HEAT_BASE);
                  }
                  if(_loc11_.damageHeatAddon > 0)
                  {
                     this.displayIconAndText_regular(this.mcDamageHeatAddon,_loc11_.damageHeatAddon,0,"",this.TEXT_DAMAGE_HEAT_ADDON);
                  }
                  _loc12_ = _loc11_.damageType;
                  _loc13_ = this._damageTypeIcons[int(_loc12_)];
                  if(_loc20_)
                  {
                     switch(_loc11_.type)
                     {
                        case "sideWeapon":
                        case "topWeapon":
                        case "drone":
                        case "teleport":
                        case "charge":
                        case "harpoon":
                           this.displayPowerRankIcon(_loc35_);
                     }
                  }
                  this.displayIconAndText_weapon(_loc13_,_loc11_,_loc37_);
                  if(_loc11_.uses > 0)
                  {
                     this.displayIconAndText_regular(this.mcUses,_loc11_.uses,0,"",this.TEXT_USES);
                  }
                  if(_loc11_.push != 0)
                  {
                     if(_loc11_.push > 0)
                     {
                        this.displayIconAndText_regular(this.mcPush,_loc11_.push,0,"",this.TEXT_PUSH);
                     }
                     else
                     {
                        this.displayIconAndText_regular(this.mcPull,Math.abs(_loc11_.push),0,"",this.TEXT_PULL);
                     }
                  }
                  switch(_loc11_.type)
                  {
                     case "charge":
                        break;
                     default:
                        if(_loc11_.damageBase > 0 || _loc11_.damageAddon > 0 || (_loc11_.resist1 > 0 || _loc11_.resist2 > 0 || _loc11_.resist3 > 0))
                        {
                           this.displayIconAndText_range(_loc11_);
                        }
                  }
                  this._toolTipMainText += "<BR>";
                  ++this._yAddonMultiplier;
                  this.displayIconAndText_regular(this.mcEnergy,_loc11_.costEnergy,0,"",this.TEXT_COST_ENERGY);
                  this.displayIconAndText_regular(this.mcHeat,_loc11_.costHeat,0,"",this.TEXT_COST_HEAT);
                  this.displayIconAndText_regular(this.mcBullets,_loc11_.bullets,0,"",this.TEXT_COST_BULLETS);
                  this.displayIconAndText_regular(this.mcRockets,_loc11_.rockets,0,"",this.TEXT_COST_ROCKETS);
                  break;
               case "shield":
                  this.displayIconAndText_shield(_loc11_.absorbRatio,_loc11_.energyPerBlock,_loc11_.heatPerBlock,_loc11_.HPPerBlock);
                  break;
               case "kit":
                  if(param1 == "newsItem" && _loc11_.subType == "power")
                  {
                     this.displayIconAndText_regular(this.mcPower,_loc11_.materialPowerContribution,0,"",this.TEXT_POWER);
                  }
                  this.displayIconAndText_minAndAddon(this.mcHP,_loc11_.HPBase,_loc11_.HPAddon,"+",this.TEXT_HIT_POINTS_KIT);
                  this.displayIconAndText_minAndAddon(this.mcEnergy,_loc11_.energyBase,_loc11_.energyAddon,"+",this.TEXT_ENERGY_KIT);
                  this.displayIconAndText_minAndAddon(this.mcHeat,_loc11_.heatBase,_loc11_.heatAddon,"-",this.TEXT_HEAT_KIT);
                  this.displayIconAndText_regular(this.mcBullets,_loc11_.bullets,0,"+",this.TEXT_BULLETS_KIT);
                  this.displayIconAndText_regular(this.mcRockets,_loc11_.rockets,0,"+",this.TEXT_ROCKETS_KIT);
                  if(this.itemHasResistances(_loc11_))
                  {
                     this.displayIconAndText_itemResistance(this.mcResist_physical,_loc11_,1);
                     this.displayIconAndText_itemResistance(this.mcResist_explosive,_loc11_,2);
                     this.displayIconAndText_itemResistance(this.mcResist_electric,_loc11_,3);
                  }
                  if(dataM.isColorKit(_loc11_.itemID) || dataM.isPowerKit(_loc11_.itemID))
                  {
                     _loc45_ = this.TEXT_FOR_FUSION_ONLY;
                     _loc46_ = "<BR>";
                  }
                  else
                  {
                     _loc45_ = this.TEXT_SINGLE_USE;
                     _loc46_ = "<BR><BR>";
                  }
                  this._toolTipMainText = this._toolTipMainText + _loc46_ + _loc45_;
                  break;
               case "module":
                  this.displayIconAndText_regular(this.mcHP,_loc11_.HPBase,0,"+",this.TEXT_HIT_POINTS);
                  this.displayIconAndText_regular(this.mcEnergy,_loc11_.energyBase,0,"+",this.TEXT_ENERGY);
                  this.displayIconAndText_regular(this.mcEnergyRegeneration,_loc11_.energyAddon,0,"+",this.TEXT_ENERGY_REGENERATION);
                  this.displayIconAndText_regular(this.mcHeat,_loc11_.heatBase,0,"+",this.TEXT_HEAT);
                  this.displayIconAndText_regular(this.mcHeatCooling,_loc11_.heatAddon,0,"+",this.TEXT_HEAT_COOLING);
                  this.displayIconAndText_regular(this.mcBullets,_loc11_.bullets,0,"+",this.TEXT_BULLETS_CAPACITY);
                  this.displayIconAndText_regular(this.mcRockets,_loc11_.rockets,0,"+",this.TEXT_ROCKETS_CAPACITY);
                  if(this.itemHasResistances(_loc11_))
                  {
                     this.displayIconAndText_itemResistance(this.mcResist_physical,_loc11_,1);
                     this.displayIconAndText_itemResistance(this.mcResist_explosive,_loc11_,2);
                     this.displayIconAndText_itemResistance(this.mcResist_electric,_loc11_,3);
                  }
            }
         }
         else if(_loc21_)
         {
            this._toolTipTitleText += getSpecificText("hanger_mechSummary");
            ++this._yAddonMultiplier;
            _loc22_ = true;
            _loc6_ = dataM.playersData[dataM.player1PlayerID];
            _loc7_ = _loc6_.mechStructures[param3];
            _loc47_ = 0;
            _loc48_ = 0;
            _loc49_ = 0;
            _loc50_ = 0;
            _loc51_ = 0;
            _loc52_ = 0;
            _loc53_ = 0;
            _loc54_ = 0;
            _loc55_ = 0;
            _loc56_ = 0;
            _loc57_ = 0;
            _loc58_ = 0;
            if(_loc7_.torso > 0)
            {
               _loc59_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_.torso);
               _loc62_ = dataM.itemsDB[_loc59_.itemID];
               _loc47_ = uint(_loc62_.HPBase);
               _loc48_ = uint(_loc62_.energyBase);
               _loc49_ = uint(_loc62_.energyAddon);
               _loc50_ = uint(_loc62_.heatBase);
               _loc51_ = uint(_loc62_.heatAddon);
               _loc52_ = uint(_loc62_.bullets);
               _loc53_ = uint(_loc62_.rockets);
               _loc54_ = _loc62_.resist1;
               _loc55_ = _loc62_.resist2;
               _loc56_ = _loc62_.resist3;
            }
            if(_loc7_.leg > 0)
            {
               _loc59_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_.leg);
               _loc60_ = dataM.itemsDB[_loc59_.itemID];
               _loc47_ += _loc60_.HPBase;
               _loc57_ = uint(_loc60_.stepsPerWalk);
               _loc58_ = uint(_loc60_.stepsPerJump);
            }
            _loc61_ = 1;
            while(_loc61_ <= dataM.maxEquipment["module"])
            {
               if(_loc7_["module" + _loc61_] > 0)
               {
                  _loc59_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_["module" + _loc61_]);
                  _loc11_ = dataM.itemsDB[_loc59_.itemID];
                  _loc47_ += _loc11_.HPBase;
                  _loc48_ += _loc11_.energyBase;
                  _loc49_ += _loc11_.energyAddon;
                  _loc50_ += _loc11_.heatBase;
                  _loc51_ += _loc11_.heatAddon;
                  _loc52_ += _loc11_.bullets;
                  _loc53_ += _loc11_.rockets;
                  _loc54_ += _loc11_.resist1;
                  _loc55_ += _loc11_.resist2;
                  _loc56_ += _loc11_.resist3;
               }
               _loc61_++;
            }
            if(_loc47_ > 0)
            {
               this.displayIconAndText_regular(this.mcHP,_loc47_,0,"",this.TEXT_HIT_POINTS);
            }
            if(_loc48_ > 0)
            {
               this.displayIconAndText_regular(this.mcEnergy,_loc48_,0,"",this.TEXT_ENERGY);
            }
            if(_loc49_ > 0)
            {
               this.displayIconAndText_regular(this.mcEnergyRegeneration,_loc49_,0,"",this.TEXT_ENERGY_REGENERATION);
            }
            if(_loc50_ > 0)
            {
               this.displayIconAndText_regular(this.mcHeat,_loc50_,0,"",this.TEXT_HEAT);
            }
            if(_loc51_ > 0)
            {
               this.displayIconAndText_regular(this.mcHeatCooling,_loc51_,0,"",this.TEXT_HEAT_COOLING);
            }
            if(_loc52_ > 0)
            {
               this.displayIconAndText_regular(this.mcBullets,_loc52_,0,"",this.TEXT_BULLETS_CAPACITY);
            }
            if(_loc53_ > 0)
            {
               this.displayIconAndText_regular(this.mcRockets,_loc53_,0,"",this.TEXT_ROCKETS_CAPACITY);
            }
            if(_loc54_ != 0)
            {
               this.displayIconAndText_generalResistance(this.mcResist_physical,_loc54_,1);
            }
            if(_loc55_ != 0)
            {
               this.displayIconAndText_generalResistance(this.mcResist_explosive,_loc55_,2);
            }
            if(_loc56_ != 0)
            {
               this.displayIconAndText_generalResistance(this.mcResist_electric,_loc56_,3);
            }
            if(_loc57_ > 0)
            {
               this.displayIconAndText_regular(this.mcMovementWalk,_loc57_,0,"",this.TEXT_STEPS_PER_WALK);
            }
            if(_loc58_ > 0)
            {
               this.displayIconAndText_regular(this.mcMovementJump,_loc58_,0,"",this.TEXT_STEPS_PER_JUMP);
            }
         }
         if(_loc16_)
         {
            _loc22_ = true;
            _loc6_ = dataM.playersData[dataM["player" + param3 + "PlayerID"]];
            _loc7_ = _loc6_.mechStructures[_loc6_.selectedMechID];
            _loc8_ = screensM.screenBattle.getMechSlot(_loc7_.playerID);
            _loc9_ = screensM.screenBattle.mechBattleDatas[_loc8_];
            if(param3 == 2)
            {
               switch(param2)
               {
                  case "level":
                     this._toolTipTitleText += getGeneralText("matchMakingLevel");
                     break;
                  default:
                     this._toolTipTitleText += dataM.battleInterfaceToolTipDB[param2].title;
               }
            }
            if(param3 == 1)
            {
               _loc63_ = dataM.battleInterfaceToolTipDB[param2].text;
               switch(param2)
               {
                  case "energy":
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%ENERGY%",String(_loc9_.energyRegeneration));
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR1%","<FONT COLOR=\'#00CCFF\'>");
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR2%","<FONT COLOR=\'#00CC00\'>");
                     this._toolTipTitleText = this._toolTipTitleText + _loc63_ + "<BR>";
                     break;
                  case "heat":
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%HEAT%",String(_loc9_.heatCooling));
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR1%","<FONT COLOR=\'#FF6600\'>");
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR2%","<FONT COLOR=\'#FF6600\'>");
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR3%","<FONT COLOR=\'#FF6600\'>");
                     this._toolTipTitleText = this._toolTipTitleText + _loc63_ + "<BR>";
                     break;
                  case "resist1":
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR1%","<FONT COLOR=\'#FFCC00\'>");
                     this._toolTipTitleText += dataM.replaceStringInText(_loc63_,"%RESIST%",String(_loc9_.resist1));
                     break;
                  case "resist2":
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR1%","<FONT COLOR=\'#FF6600\'>");
                     this._toolTipTitleText += dataM.replaceStringInText(_loc63_,"%RESIST%",String(_loc9_.resist2));
                     break;
                  case "resist3":
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR1%","<FONT COLOR=\'#00CCFF\'>");
                     this._toolTipTitleText += dataM.replaceStringInText(_loc63_,"%RESIST%",String(_loc9_.resist3));
                     break;
                  case "bullets":
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR1%","<FONT COLOR=\'#FFCC00\'>");
                     this._toolTipTitleText += _loc63_;
                     break;
                  case "rockets":
                     _loc63_ = dataM.replaceStringInText(_loc63_,"%COLOR1%","<FONT COLOR=\'#FF6600\'>");
                     this._toolTipTitleText += _loc63_;
                     break;
                  default:
                     this._toolTipTitleText += _loc63_;
               }
            }
         }
         this.titleText.htmlText = this._toolTipTitleText;
         this.mainText.htmlText = this._toolTipMainText;
         this.equipmentText.htmlText = this._toolTipEquipmentText;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("tooltipTexts",[this.titleText,this.mainText,this.equipmentText],"",this.mcMainHolder);
         }
         var _loc24_:Number = this.titleText.textWidth;
         var _loc25_:Number = this.titleText.textHeight;
         if(_loc22_)
         {
            if(_loc24_ < this.mainText.x + this.mainText.textWidth)
            {
               _loc24_ = this.mainText.x + this.mainText.textWidth;
            }
            if(_loc25_ < this.mainText.y + this.mainText.textHeight)
            {
               _loc25_ = this.mainText.y + this.mainText.textHeight;
            }
         }
         if(_loc23_)
         {
            if(_loc24_ < this.equipmentText.x + this.equipmentText.textWidth)
            {
               _loc24_ = this.equipmentText.x + this.equipmentText.textWidth;
            }
            if(_loc25_ < this.equipmentText.y + this.equipmentText.textHeight)
            {
               _loc25_ = this.equipmentText.y + this.equipmentText.textHeight;
            }
         }
         _loc24_ += 12;
         _loc25_ += 10 + this._tooltipExtraHeight;
         if(this.mainText.htmlText == "")
         {
            _loc25_ -= 2;
         }
         this.mcBackground.width = _loc24_;
         this.mcBackground.height = _loc25_;
         this._positionHandler = true;
         this._mobileTooltipOriginMouseXPos = mouseX;
         this._mobileTooltipOriginMouseYPos = mouseY;
         this.positionHandler();
      }
      
      private function removeIcon(param1:Sprite) : void
      {
         if(param1 != null)
         {
            if(param1.parent != null)
            {
               this.mcIconsHolder.removeChild(param1);
            }
         }
      }
      
      private function displayPowerRankIcon(param1:Number) : void
      {
         this.mcPowerRank = externalAssetsM.getAsset("general","Grp_rank" + param1,this.ATTRIBUTE_SIZE,this.ATTRIBUTE_SIZE,false,false);
         this.mcPowerRank.x = this.REGULAR_ICON_X;
         this.mcPowerRank.y = this._initialY + this._yAddon;
         this.mcIconsHolder.addChild(this.mcPowerRank);
      }
      
      private function displayMechEquipmentText(param1:Number, param2:String) : void
      {
         var _loc7_:String = null;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItemData = null;
         var _loc10_:Sprite = null;
         var _loc11_:Boolean = false;
         var _loc3_:BMPlayerData = dataM.playersData[param1];
         var _loc4_:BMMechStructure = _loc3_.mechStructures[_loc3_.selectedMechID];
         var _loc5_:Number = Number(_loc4_[param2]);
         var _loc6_:String = "";
         if(_loc5_ > 0)
         {
            _loc8_ = dataM.getPlayerItemData(param1,_loc5_);
            _loc9_ = dataM.itemsDB[_loc8_.itemID];
            _loc7_ = "";
            if(dataM.languageID == 2)
            {
               _loc7_ = getSpecificText("item_" + _loc9_.itemID);
            }
            else
            {
               _loc7_ = _loc9_.fullName;
            }
            _loc6_ = "<BR>" + _loc7_;
            switch(_loc9_.type)
            {
               case "sideWeapon":
                  ++this._sideWeapons;
                  break;
               case "topWeapon":
                  ++this._topWeapons;
                  break;
               case "drone":
                  ++this._drones;
                  break;
               case "shield":
                  ++this._shields;
                  break;
               case "teleport":
                  ++this._teleports;
                  break;
               case "charge":
                  ++this._charges;
                  break;
               case "harpoon":
                  ++this._harpoons;
                  break;
               case "kit":
                  ++this._kits;
                  break;
               case "module":
                  ++this._modules;
            }
            _loc10_ = this["mcItemType_" + _loc9_.type];
            _loc6_ = "";
            _loc11_ = false;
         }
         if(param2 == "sideWeapon4" && this._sideWeapons % 2 != 0)
         {
            _loc11_ = true;
         }
         else if(param2 == "topWeapon4" && this._topWeapons % 2 != 0)
         {
            _loc11_ = true;
         }
         else if(param2 == "drone" && this._drones % 2 != 0)
         {
            _loc11_ = true;
         }
         else if(param2 == "shield" && this._shields % 2 != 0)
         {
            _loc11_ = true;
         }
         else if(param2 == "teleport" && this._teleports % 2 != 0)
         {
            _loc11_ = true;
         }
         else if(param2 == "charge" && this._charges % 2 != 0)
         {
            _loc11_ = true;
         }
         else if(param2 == "harpoon" && this._harpoons % 2 != 0)
         {
            _loc11_ = true;
         }
         else if(param2 == "kit4" && this._kits % 2 != 0)
         {
            _loc11_ = true;
         }
         else if(param2 == "module4" && this._modules == 1)
         {
            _loc11_ = true;
         }
         if(_loc5_ > 0)
         {
            if(_loc10_.parent == null)
            {
               _loc10_.y = 2 + this._initialY + this._yAddon * this._yAddonMultiplier_equipment;
               this.mcIconsHolder.addChild(_loc10_);
            }
            _loc6_ = _loc6_ + "<BR>" + _loc9_.fullName;
            ++this._yAddonMultiplier_equipment;
         }
         if(_loc11_)
         {
            ++this._yAddonMultiplier_equipment;
            _loc6_ += "<BR> ";
         }
         this._toolTipEquipmentText += _loc6_;
      }
      
      private function displayIcon(param1:Sprite) : void
      {
         param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
         this.mcIconsHolder.addChild(param1);
         ++this._yAddonMultiplier;
      }
      
      private function displayIconAndText_minAndAddon(param1:Sprite, param2:Number, param3:Number, param4:String, param5:String) : void
      {
         if(param2 > 0)
         {
            param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(param1);
            this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + param4 + this.getBaseAndAddonText(param2,param3) + param5;
            ++this._yAddonMultiplier;
         }
      }
      
      private function displayIconAndText_weapon(param1:Sprite, param2:BMItemData, param3:Number) : void
      {
         if(param2.damageBase > 0)
         {
            param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(param1);
            this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + this.getDamageText(param2,param3);
            switch(param2.damageType)
            {
               case 2:
                  ++this._yAddonMultiplier;
                  this.mcDamageType_explosivePlus.y = this._initialY + this._yAddon * this._yAddonMultiplier;
                  this.mcIconsHolder.addChild(this.mcDamageType_explosivePlus);
                  break;
               case 3:
                  ++this._yAddonMultiplier;
                  this.mcDamageType_electricPlus.y = this._initialY + this._yAddon * this._yAddonMultiplier;
                  this.mcIconsHolder.addChild(this.mcDamageType_electricPlus);
            }
            ++this._yAddonMultiplier;
         }
      }
      
      private function displayIconAndText_itemResistance(param1:Sprite, param2:BMItemData, param3:Number) : void
      {
         var _loc4_:String = null;
         if(param2["resist" + param3] != 0)
         {
            param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(param1);
            _loc4_ = "+";
            if(param2["resist" + param3] < 0)
            {
               _loc4_ = "";
            }
            this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + _loc4_ + param2["resist" + param3] + this["TEXT_RESIST" + param3];
            ++this._yAddonMultiplier;
         }
      }
      
      private function displayIconAndText_generalResistance(param1:Sprite, param2:Number, param3:Number) : void
      {
         if(param2 != 0)
         {
            param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(param1);
            this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + param2 + this["TEXT_RESIST" + param3];
            ++this._yAddonMultiplier;
         }
      }
      
      private function displayIconAndText_torsoEquipment(param1:Sprite, param2:Number, param3:Boolean) : void
      {
         var _loc4_:String = null;
         if(param2 > 0)
         {
            param1.y = this._initialY + this._yAddon * this._yAddonMultiplier_equipment;
            this.mcIconsHolder.addChild(param1);
            _loc4_ = "";
            if(param3 && param2 > 1)
            {
               _loc4_ = "X " + param2;
            }
            this._toolTipEquipmentText = this._toolTipEquipmentText + "<BR>" + _loc4_ + "<BR> ";
            this._yAddonMultiplier_equipment += 2;
         }
      }
      
      private function displayIconAndText_mechResistance(param1:Sprite, param2:Number) : void
      {
         if(param2 > 0)
         {
            param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(param1);
            this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + param2;
            ++this._yAddonMultiplier;
         }
      }
      
      private function displayIconAndText_regular(param1:Sprite, param2:Number, param3:Number, param4:String, param5:String) : void
      {
         var _loc6_:String = null;
         if(param2 > 0)
         {
            param2 -= param3;
            param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(param1);
            if(param3 == 0)
            {
               if(param2 > 999)
               {
                  _loc6_ = dataM.getNumberWithComma(param2);
               }
               else
               {
                  _loc6_ = String(param2);
               }
               this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + param4 + _loc6_ + param5;
            }
            else
            {
               this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + param4 + param2 + " + " + param3 + param5;
            }
            ++this._yAddonMultiplier;
         }
      }
      
      private function displayIconAndText_gold(param1:Sprite, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:BMPlayerProfile = null;
         var _loc7_:Number = NaN;
         if(param2 > 0)
         {
            _loc6_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(param4)
            {
               if(param5)
               {
                  _loc7_ = param2;
               }
               else
               {
                  _loc7_ = Math.ceil(param2 * dataM.SELL_ORIGINAL_VALUE_RATIO);
               }
               this.mcSellValue_gold.y = this._initialY + this._yAddon * this._yAddonMultiplier;
               this.mcIconsHolder.addChild(this.mcSellValue_gold);
               this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + dataM.getNumberWithComma(_loc7_) + this.TEXT_SELL_VALUE;
               ++this._yAddonMultiplier;
            }
            else
            {
               param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
               this.mcIconsHolder.addChild(param1);
               if(_loc6_.gold < param2 && param3)
               {
                  this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + "<FONT FACE=\'" + TextUtils.getTextFont_short() + "\' SIZE=\'" + this.TEXT_SIZE + "\' COLOR=\'#" + dataM.COLOR_BAD + "\'>" + dataM.getNumberWithComma(param2) + "</FONT><FONT SIZE=\'" + this.TEXT_SIZE + "\'>";
               }
               else
               {
                  this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + "<FONT FACE=\'" + TextUtils.getTextFont_short() + "\' SIZE=\'" + this.TEXT_SIZE + "\' COLOR=\'#" + this.TEXT_DEFAULT_COLOR + "\'>" + dataM.getNumberWithComma(param2) + "</FONT><FONT SIZE=\'" + this.TEXT_SIZE + "\'>";
               }
               ++this._yAddonMultiplier;
            }
            this._toolTipMainText += "<BR>";
            ++this._yAddonMultiplier;
         }
         else
         {
            param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(param1);
            this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + getGeneralText("free") + "<BR>";
            this._yAddonMultiplier += 2;
         }
      }
      
      private function displayIconAndText_tokens(param1:Sprite, param2:Number, param3:Boolean) : void
      {
         var _loc4_:BMPlayerProfile = null;
         if(param2 > 0)
         {
            _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            param1.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(param1);
            if(_loc4_.tokens < param2 && param3)
            {
               this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + "<FONT FACE=\'" + TextUtils.getTextFont_short() + "\' SIZE=\'" + this.TEXT_SIZE + "\' COLOR=\'#" + this.TEXT_DEFAULT_COLOR + "\'>" + param2 + "</FONT><FONT SIZE=\'" + this.TEXT_SIZE + "\'>";
            }
            else
            {
               this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + param2;
            }
            ++this._yAddonMultiplier;
            this._toolTipMainText += "<BR>";
            ++this._yAddonMultiplier;
         }
      }
      
      private function displayIconAndText_battleHeat(param1:Sprite, param2:Number) : void
      {
         if(param2 > 0)
         {
            this.displayIconAndText_regular(param1,param2,0,"+","");
         }
      }
      
      private function displayIconAndText_range(param1:BMItemData) : void
      {
         this.mcRange.y = this._initialY + this._yAddon * this._yAddonMultiplier;
         this.mcIconsHolder.addChild(this.mcRange);
         this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + this.getRangeText(param1);
         if(param1.rangeAddon >= 999)
         {
            this.mcRangeInfinit.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(this.mcRangeInfinit);
            this._toolTipMainText += "    ";
         }
         this._toolTipMainText += this.TEXT_RANGE;
         ++this._yAddonMultiplier;
      }
      
      private function displayIconAndText_shutDown(param1:BMPlayerData, param2:BMMechBattleData) : void
      {
         this.mcHeat.y = this._initialY + this._yAddon * this._yAddonMultiplier;
         this.mcIconsHolder.addChild(this.mcHeat);
         this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + "-" + param2.heatCooling + this.TEXT_HEAT_COOLING;
         ++this._yAddonMultiplier;
      }
      
      private function displayIconAndText_shield(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:String = "energy";
         if(param3 > 0)
         {
            _loc5_ = "heat";
         }
         if(param2 > 0)
         {
            this.mcShieldBlockEnergy.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(this.mcShieldBlockEnergy);
         }
         else
         {
            this.mcShieldBlockHeat.y = this._initialY + this._yAddon * this._yAddonMultiplier;
            this.mcIconsHolder.addChild(this.mcShieldBlockHeat);
         }
         this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + param1 + "% " + this.TEXT_SHIELD_ABSORB_RATIO;
         ++this._yAddonMultiplier;
         switch(_loc5_)
         {
            case "energy":
               this.mcShieldEnergyPerBlock.y = this._initialY + this._yAddon * this._yAddonMultiplier;
               this.mcIconsHolder.addChild(this.mcShieldEnergyPerBlock);
               this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + param2 + this.TEXT_SHIELD_ENERGY_PER_BLOCK1 + param4 + this.TEXT_SHIELD_ENERGY_PER_BLOCK2 + "<BR>" + this.TEXT_SHIELD_ENERGY_DEACTIVATION;
               break;
            case "heat":
               this.mcShieldHeatPerBlock.y = this._initialY + this._yAddon * this._yAddonMultiplier;
               this.mcIconsHolder.addChild(this.mcShieldHeatPerBlock);
               this._toolTipMainText = this._toolTipMainText + "<BR>" + this.ATTRIBUTE_SPACES + param3 + this.TEXT_SHIELD_HEAT_PER_BLOCK1 + param4 + this.TEXT_SHIELD_ENERGY_PER_BLOCK2 + "<BR>" + this.TEXT_SHIELD_HEAT_DEACTIVATION;
         }
         ++this._yAddonMultiplier;
      }
      
      private function getBaseAndAddonText(param1:Number, param2:Number) : String
      {
         var _loc3_:String = param1 + " - " + (param1 + param2);
         if(param2 == 0)
         {
            _loc3_ = String(param1);
         }
         return _loc3_;
      }
      
      private function getDamageText(param1:BMItemData, param2:Number) : String
      {
         var _loc3_:Number = param1.damageBase - param2;
         var _loc4_:Number = param1.damageAddon;
         var _loc5_:String = _loc3_ + " - " + (_loc3_ + _loc4_);
         if(_loc4_ == 0)
         {
            _loc5_ = String(_loc3_);
         }
         if(param2 > 0)
         {
            _loc5_ = _loc5_ + " + " + param2;
         }
         switch(param1.damageType)
         {
            case 1:
               _loc5_ += this.TEXT_DAMAGE_TYPE1;
               break;
            case 2:
               _loc5_ = _loc5_ + this.TEXT_DAMAGE_TYPE2 + "<BR>" + this.ATTRIBUTE_SPACES + "<FONT COLOR=\'#" + this.TEXT_DAMAGE_HEAT_COLOR + "\'>" + param1.damageHeat + "</FONT>" + this.TEXT_DAMAGE_EFFECT2;
               break;
            case 3:
               _loc5_ = _loc5_ + this.TEXT_DAMAGE_TYPE3 + "<BR>" + this.ATTRIBUTE_SPACES + "<FONT COLOR=\'#" + this.TEXT_DAMAGE_ENERGY_COLOR + "\'>" + param1.damageEnergy + "</FONT>" + this.TEXT_DAMAGE_EFFECT3;
         }
         return _loc5_;
      }
      
      private function getRangeText(param1:BMItemData) : String
      {
         var _loc2_:String = String(param1.rangeBase + param1.rangeAddon);
         if(param1.rangeBase > 0)
         {
            _loc2_ = param1.rangeBase + 1 + " - " + (param1.rangeBase + param1.rangeAddon);
         }
         if(param1.rangeAddon >= 999)
         {
            _loc2_ = "";
         }
         return _loc2_;
      }
      
      private function itemHasResistances(param1:BMItemData) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:uint = 1;
         while(_loc3_ <= 3)
         {
            if(param1["resist" + _loc3_] != 0)
            {
               _loc2_ = true;
               _loc3_ = 3;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function mechHasResistances(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:uint = 1;
         while(_loc3_ <= 4)
         {
            if(dataM.getResistance(param1,_loc3_,true) > 0)
            {
               _loc2_ = true;
               _loc3_ = 5;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getItemCompareScore(param1:uint) : Number
      {
         var _loc2_:BMItemData = dataM.itemsDB[param1];
         var _loc3_:Number = _loc2_.weight;
         switch(_loc2_.specialStatus)
         {
            case 1:
               _loc3_ *= 1.02;
               break;
            case 2:
               _loc3_ *= 1.7;
               break;
            case 3:
               _loc3_ *= 1.2;
               break;
            case 4:
               _loc3_ *= 1.45;
         }
         return _loc3_;
      }
      
      public function hideToolTip() : void
      {
         this.currentTooltipType = "";
         if(this.mcMainHolder.parent != null)
         {
            removeChild(this.mcMainHolder);
         }
         this._positionHandler = false;
         this.allowRepositionForMobile = false;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("tooltipTexts",[this.titleText,this.mainText,this.equipmentText],"",this.mcMainHolder);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(dataM.runAsMobile == false || this.allowRepositionForMobile)
         {
            this.positionHandler();
         }
      }
      
      private function positionHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(this._positionHandler)
         {
            _loc1_ = screensM.stagePointer.mouseX + this.TOOLTIP_X_ADDON;
            _loc2_ = screensM.stagePointer.mouseY + this.TOOLTIP_Y_ADDON;
            _loc3_ = _loc1_;
            _loc4_ = _loc2_;
            _loc5_ = false;
            _loc6_ = false;
            if(_loc1_ + this.mcMainHolder.width > dataM.STAGE_WIDTH)
            {
               _loc5_ = true;
            }
            if(_loc2_ + this.mcMainHolder.height > dataM.STAGE_HEIGHT)
            {
               _loc6_ = true;
            }
            if(_loc5_ && _loc6_)
            {
               _loc3_ = _loc1_ - 60 - this.mcMainHolder.width;
               _loc4_ = dataM.STAGE_HEIGHT - this.mcMainHolder.height;
            }
            else if(_loc5_)
            {
               _loc3_ = dataM.STAGE_WIDTH - this.mcMainHolder.width;
            }
            else if(_loc6_)
            {
               _loc4_ = dataM.STAGE_HEIGHT - this.mcMainHolder.height;
            }
            this.mcMainHolder.x = _loc3_;
            this.mcMainHolder.y = _loc4_;
            if(dataM.runAsMobile)
            {
               _loc7_ = mouseX - this._mobileTooltipOriginMouseXPos;
               _loc8_ = mouseY - this._mobileTooltipOriginMouseYPos;
               _loc9_ = dataM.getVectorSize(_loc7_,_loc8_);
               if(_loc9_ > 50)
               {
                  this.hideToolTip();
               }
            }
         }
      }
      
      private function createTexts() : void
      {
         switch(dataM.languageID)
         {
            case 3:
            case 4:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
               this.TEXT_SIZE = 18;
               break;
            default:
               this.TEXT_SIZE = 16;
         }
         this.TITLE_TEXT_BASE_TEXT = "<FONT FACE=\'" + TextUtils.getTextFont_short() + "\' SIZE=\'" + this.TEXT_SIZE + "\' COLOR=\'#" + this.TEXT_DEFAULT_COLOR + "\'>";
         this.MAIN_TEXT_BASE_TEXT = "<FONT FACE=\'" + TextUtils.getTextFont_short() + "\' SIZE=\'" + this.TEXT_SIZE + "\' COLOR=\'#" + this.TEXT_DEFAULT_COLOR + "\'>";
         this.EQUIPMENT_TEXT_BASE_TEXT = "<FONT FACE=\'" + TextUtils.getTextFont_short() + "\' SIZE=\'" + this.TEXT_SIZE + "\' COLOR=\'#" + this.TEXT_DEFAULT_COLOR + "\'>";
         this.TEXT_HIT_POINTS = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("HP") + "</FONT>";
         this.TEXT_HIT_POINTS_KIT = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("HP") + "</FONT>";
         this.TEXT_REPAIR = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("repair") + "</FONT>";
         this.TEXT_ENERGY = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("energyCapacity") + "</FONT>";
         this.TEXT_ENERGY_REGENERATION = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("energyRegeneration") + "</FONT>";
         this.TEXT_ENERGY_KIT = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("energy") + "</FONT>";
         this.TEXT_HEAT = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("heat") + "</FONT>";
         this.TEXT_HEAT_COOLING = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("heatCooling") + "</FONT>";
         this.TEXT_HEAT_KIT = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("heat") + "</FONT>";
         this.TEXT_BULLETS = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("bullets") + "</FONT>";
         this.TEXT_BULLETS_CAPACITY = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("bulletsCapacity") + "</FONT>";
         this.TEXT_BULLETS_KIT = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("bullets") + "</FONT>";
         this.TEXT_ROCKETS = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("rockets") + "</FONT>";
         this.TEXT_ROCKETS_CAPACITY = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("rocketsCapacity") + "</FONT>";
         this.TEXT_ROCKETS_KIT = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("rockets") + "</FONT>";
         this.TEXT_RANGE = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("range") + "</FONT>";
         this.TEXT_USES = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("maxUses") + "</FONT>";
         this.TEXT_RESIST1 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("resist1") + "</FONT>";
         this.TEXT_RESIST2 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("resist2") + "</FONT>";
         this.TEXT_RESIST3 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("resist3") + "</FONT>";
         this.TEXT_RESIST1_DAMAGE = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("resist1Damage") + "</FONT>";
         this.TEXT_RESIST2_DAMAGE = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("resist2Damage") + "</FONT>";
         this.TEXT_RESIST3_DAMAGE = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("resist3Damage") + "</FONT>";
         this.TEXT_DAMAGE_ENERGY_BASE = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("damageEnergyBase") + "</FONT>";
         this.TEXT_DAMAGE_ENERGY_ADDON = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("damageEnergyAddon") + "</FONT>";
         this.TEXT_DAMAGE_HEAT_BASE = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("damageHeatBase") + "</FONT>";
         this.TEXT_DAMAGE_HEAT_ADDON = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("damageHeatAddon") + "</FONT>";
         this.TEXT_SINGLE_USE = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>" + getScreenText("singleUse") + "</FONT>";
         this.TEXT_FOR_FUSION_ONLY = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>" + getScreenText("forFusionOnly") + "</FONT>";
         this.TEXT_PUSH = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("knockback") + "</FONT>";
         this.TEXT_PULL = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("pull") + "</FONT>";
         this.TEXT_DAMAGE_TYPE1 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("physicalDamage") + "</FONT>";
         this.TEXT_DAMAGE_TYPE2 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("explosiveDamage") + "</FONT>";
         this.TEXT_DAMAGE_TYPE3 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("electricDamage") + "</FONT>";
         this.TEXT_DAMAGE_EFFECT1 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  </FONT>";
         this.TEXT_DAMAGE_EFFECT2 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("heatDamage") + "</FONT>";
         this.TEXT_DAMAGE_EFFECT3 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("energyDamage") + "</FONT>";
         this.TEXT_DAMAGE_EFFECT4 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  </FONT>";
         this.TEXT_SELL_VALUE = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("sellValue") + "</FONT>";
         this.TEXT_STEPS_PER_WALK = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("stepsPerWalk") + "</FONT>";
         this.TEXT_STEPS_PER_JUMP = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("stepsPerJump") + "</FONT>";
         this.TEXT_COST_ENERGY = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("energyPerUse") + "</FONT>";
         this.TEXT_COST_HEAT = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("heatPerUse") + "</FONT>";
         this.TEXT_COST_BULLETS = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("bulletsPerUse") + "</FONT>";
         this.TEXT_COST_ROCKETS = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("rocketsPerUse") + "</FONT>";
         this.TEXT_SIDE_WEAPONS = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("sideWeaponSlots") + "</FONT>";
         this.TEXT_TOP_WEAPONS = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("topWeaponSlots") + "</FONT>";
         this.TEXT_KITS = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("kitSlots") + "</FONT>";
         this.TEXT_MODULES = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("moduleSlots") + "</FONT>";
         this.TEXT_SHIELD_ABSORB_RATIO = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'> " + getScreenText("maxDamageAbsorbed") + "</FONT>";
         this.TEXT_SHIELD_ENERGY_PER_BLOCK1 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("energyToBlock") + " </FONT>";
         this.TEXT_SHIELD_HEAT_PER_BLOCK1 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getScreenText("heatToBlock") + " </FONT>";
         this.TEXT_SHIELD_ENERGY_PER_BLOCK2 = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'> " + getScreenText("pointsOfDamage") + "</FONT>";
         this.TEXT_SHIELD_ENERGY_DEACTIVATION = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>" + getScreenText("energyAutoDeactivate") + "</FONT>";
         this.TEXT_SHIELD_HEAT_DEACTIVATION = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>" + getScreenText("heatAutoDeactivate") + "</FONT>";
         this.TEXT_POWER = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>  " + getGeneralText("power") + "</FONT>";
         this.TEXT_WEIGHT = "<FONT COLOR=\'#" + this.TEXT_GRAY_COLOR + "\'>" + getScreenText("weight") + "</FONT>";
      }
   }
}

