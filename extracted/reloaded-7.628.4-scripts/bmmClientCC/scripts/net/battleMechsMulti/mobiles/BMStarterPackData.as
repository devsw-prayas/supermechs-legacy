package net.battleMechsMulti.mobiles
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMStarterPackData
   {
      
      public static const PRICE_TYPE_MONEY:uint = 1;
      
      public static const PRICE_TYPE_TOKENS:uint = 2;
      
      public static const PRICE_TYPE_GOLD:uint = 3;
      
      public static const MANDATORY_LEGENDARY_GACHA_MACHINES:Array = [41];
      
      public static const GAME_OF_WHALES_OFFER_PACK_ID:uint = 50000;
      
      public static const TYPE_DEFAULT:uint = 0;
      
      public static const TYPE_MECH_AND_CURRENCY:uint = 1;
      
      public static const TYPE_MECH_ONLY:uint = 2;
      
      public static const TYPE_GOLD:uint = 3;
      
      public static const TYPE_TOKENS:uint = 4;
      
      public static const TYPE_GOLD_AND_TOKENS:uint = 5;
      
      public static const TYPE_ITEM_AND_TOKENS:uint = 6;
      
      public static const TYPE_BOXES_AND_CURRENCY:uint = 7;
      
      public static const TYPE_BOXES_ONLY:uint = 8;
      
      public static const TYPE_MANDATORY_LEGENDARY_BOX:uint = 9;
      
      public static const TYPE_BUNDLE:uint = 10;
      
      public var packID:uint = 0;
      
      public var tokenPackageID:uint = 0;
      
      public var offerDuration:uint;
      
      public var boostID:uint;
      
      public var boostAmount:uint;
      
      public var mechColorID:uint;
      
      public var torso:uint;
      
      public var leg:uint;
      
      public var sideWeapon1:uint;
      
      public var sideWeapon2:uint;
      
      public var sideWeapon3:uint;
      
      public var sideWeapon4:uint;
      
      public var topWeapon1:uint;
      
      public var topWeapon2:uint;
      
      public var module1:uint;
      
      public var module2:uint;
      
      public var module3:uint;
      
      public var module4:uint;
      
      public var module5:uint;
      
      public var module6:uint;
      
      public var module7:uint;
      
      public var module8:uint;
      
      public var drone:uint;
      
      public var teleport:uint;
      
      public var charge:uint;
      
      public var harpoon:uint;
      
      public var perk:uint;
      
      public var bonusGold:uint;
      
      public var skin:uint;
      
      public var starterPackStatus:uint;
      
      public var starterPackStartDate:Number;
      
      public var price:String;
      
      public var bonusTokens:uint;
      
      public var priceType:uint = 1;
      
      public var starterPackShopID:uint = 0;
      
      public var vipDays:uint = 0;
      
      public var extraValue:String = null;
      
      public var isBundle:Boolean = false;
      
      public var battleCredits:uint = 0;
      
      public var clanCoins:uint = 0;
      
      public var arenaCoins:uint = 0;
      
      public var nukes:uint = 0;
      
      public var module1Multiplier:uint = 1;
      
      public var module2Multiplier:uint = 1;
      
      public var module3Multiplier:uint = 1;
      
      public var module4Multiplier:uint = 1;
      
      public var module5Multiplier:uint = 1;
      
      public var module6Multiplier:uint = 1;
      
      public var module7Multiplier:uint = 1;
      
      public var module8Multiplier:uint = 1;
      
      private const MECH_ITEMS:Array = ["torso","leg","sideWeapon1","sideWeapon2","sideWeapon3","sideWeapon4","topWeapon1","topWeapon2","module1","module2","module3","module4","module5","module6","module7","module8","drone","teleport","charge","harpoon","perk"];
      
      public function BMStarterPackData()
      {
         super();
      }
      
      public function initialize_noItems(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:String, param9:uint = 0, param10:Number = 0, param11:String = "") : void
      {
         this.initialize(param1,param2,param3,param4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,param5,param6,0,param7,param8,param9,param10,param11);
      }
      
      public function initialize(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint, param9:uint, param10:uint, param11:uint, param12:uint, param13:uint, param14:uint, param15:uint, param16:uint, param17:uint, param18:uint, param19:uint, param20:uint, param21:uint, param22:uint, param23:uint, param24:uint, param25:uint, param26:uint, param27:uint, param28:uint, param29:uint, param30:uint, param31:String, param32:uint = 0, param33:Number = 0, param34:String = "", param35:Boolean = false, param36:uint = 0, param37:uint = 0, param38:uint = 0, param39:uint = 0, param40:uint = 1, param41:uint = 1, param42:uint = 1, param43:uint = 1, param44:uint = 1, param45:uint = 1, param46:uint = 1, param47:uint = 1) : void
      {
         this.packID = param1;
         this.offerDuration = param2;
         this.boostID = param3;
         this.boostAmount = param4;
         this.mechColorID = param5;
         this.torso = param6;
         this.leg = param7;
         this.sideWeapon1 = param8;
         this.sideWeapon2 = param9;
         this.sideWeapon3 = param10;
         this.sideWeapon4 = param11;
         this.topWeapon1 = param12;
         this.topWeapon2 = param13;
         this.module1 = param14;
         this.module2 = param15;
         this.module3 = param16;
         this.module4 = param17;
         this.module5 = param18;
         this.module6 = param19;
         this.module7 = param20;
         this.module8 = param21;
         this.drone = param22;
         this.teleport = param23;
         this.charge = param24;
         this.harpoon = param25;
         this.perk = param26;
         this.bonusGold = param27;
         this.skin = param29;
         this.starterPackStartDate = param33;
         this.starterPackStatus = param32;
         this.price = param34;
         this.bonusTokens = param28;
         this.vipDays = param30;
         this.extraValue = param31;
         this.isBundle = param35;
         this.battleCredits = param36;
         this.clanCoins = param37;
         this.arenaCoins = param38;
         this.nukes = param39;
         this.module1Multiplier = param40;
         this.module2Multiplier = param41;
         this.module3Multiplier = param42;
         this.module4Multiplier = param43;
         this.module5Multiplier = param44;
         this.module6Multiplier = param45;
         this.module7Multiplier = param46;
         this.module8Multiplier = param47;
      }
      
      public function getMechStructure() : BMMechStructure
      {
         var _loc1_:BMMechStructure = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         _loc1_.initialize(0,0);
         _loc1_.torso = this.torso;
         _loc1_.torso_colorID = this.mechColorID;
         _loc1_.leg = this.leg;
         _loc1_.leg_colorID = this.mechColorID;
         _loc1_.sideWeapon1 = this.sideWeapon1;
         _loc1_.sideWeapon1_colorID = this.mechColorID;
         _loc1_.sideWeapon2 = this.sideWeapon2;
         _loc1_.sideWeapon2_colorID = this.mechColorID;
         _loc1_.sideWeapon3 = this.sideWeapon3;
         _loc1_.sideWeapon3_colorID = this.mechColorID;
         _loc1_.sideWeapon4 = this.sideWeapon4;
         _loc1_.sideWeapon4_colorID = this.mechColorID;
         _loc1_.topWeapon1 = this.topWeapon1;
         _loc1_.topWeapon1_colorID = this.mechColorID;
         _loc1_.topWeapon2 = this.topWeapon2;
         _loc1_.topWeapon2_colorID = this.mechColorID;
         _loc1_.module1 = this.module1;
         _loc1_.module2 = this.module2;
         _loc1_.module3 = this.module3;
         _loc1_.module4 = this.module4;
         _loc1_.module5 = this.module5;
         _loc1_.module6 = this.module6;
         _loc1_.module7 = this.module7;
         _loc1_.module8 = this.module8;
         _loc1_.drone = this.drone;
         _loc1_.drone_colorID = this.mechColorID;
         _loc1_.teleport = this.teleport;
         _loc1_.charge = this.charge;
         _loc1_.harpoon = this.harpoon;
         return _loc1_;
      }
      
      public function getMechItemIDs() : Array
      {
         var _loc3_:uint = 0;
         var _loc1_:Array = new Array();
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         _loc1_ = this.addItemIDToArray(_loc1_,this[BMMechStructure.TORSO]);
         _loc1_ = this.addItemIDToArray(_loc1_,this[BMMechStructure.LEG]);
         _loc3_ = 1;
         while(_loc3_ <= _loc2_.maxEquipment[BMMechStructure.SIDE_WEAPON])
         {
            _loc1_ = this.addItemIDToArray(_loc1_,this[BMMechStructure.SIDE_WEAPON + _loc3_]);
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ <= _loc2_.maxEquipment[BMMechStructure.TOP_WEAPON])
         {
            _loc1_ = this.addItemIDToArray(_loc1_,this[BMMechStructure.TOP_WEAPON + _loc3_]);
            _loc3_++;
         }
         _loc1_ = this.addItemIDToArray(_loc1_,this[BMMechStructure.DRONE]);
         _loc1_ = this.addItemIDToArray(_loc1_,this[BMMechStructure.TELEPORT]);
         _loc1_ = this.addItemIDToArray(_loc1_,this[BMMechStructure.CHARGE]);
         _loc1_ = this.addItemIDToArray(_loc1_,this[BMMechStructure.HARPOON]);
         _loc3_ = 1;
         while(_loc3_ <= _loc2_.maxEquipment[BMMechStructure.MODULE])
         {
            _loc1_ = this.addItemIDToArray(_loc1_,this[BMMechStructure.MODULE + _loc3_]);
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function addItemIDToArray(param1:Array, param2:uint) : Array
      {
         if(param2 > 0)
         {
            param1.push(param2);
         }
         return param1;
      }
      
      public function getStarterPackType() : uint
      {
         if(this.isBundle)
         {
            return TYPE_BUNDLE;
         }
         if(this.isMechOnly())
         {
            return TYPE_MECH_ONLY;
         }
         if(this.isMechAndCurrency())
         {
            return TYPE_MECH_AND_CURRENCY;
         }
         if(this.isTypeGold())
         {
            return TYPE_GOLD;
         }
         if(this.isTypeTokens())
         {
            return TYPE_TOKENS;
         }
         if(this.isTypeGoldAndTokens())
         {
            return TYPE_GOLD_AND_TOKENS;
         }
         if(this.isTypeOneItemAndTokens() || this.isTypeSeveralItemsAndTokens())
         {
            return TYPE_ITEM_AND_TOKENS;
         }
         if(this.isBoxesAndCurrency())
         {
            return TYPE_BOXES_AND_CURRENCY;
         }
         if(this.isMandatoryLegendaryBox())
         {
            return TYPE_MANDATORY_LEGENDARY_BOX;
         }
         if(this.isBoxesOnly())
         {
            return TYPE_BOXES_ONLY;
         }
         return TYPE_DEFAULT;
      }
      
      public function isMandatoryLegendaryBox() : Boolean
      {
         if(this.isBoxesOnly() == false)
         {
            return false;
         }
         if(MANDATORY_LEGENDARY_GACHA_MACHINES.indexOf(this.boostID) > -1)
         {
            return true;
         }
         return false;
      }
      
      private function isBoxesOnly() : Boolean
      {
         if(this.boostID == 0)
         {
            return false;
         }
         if(this.bonusGold > 0)
         {
            return false;
         }
         if(this.bonusTokens > 0)
         {
            return false;
         }
         return true;
      }
      
      private function isBoxesAndCurrency() : Boolean
      {
         if(this.boostID == 0)
         {
            return false;
         }
         if(this.bonusGold == 0)
         {
            return false;
         }
         if(this.bonusTokens == 0)
         {
            return false;
         }
         return true;
      }
      
      private function isMechOnly() : Boolean
      {
         if(this.torso == 0)
         {
            return false;
         }
         if(this.bonusGold > 0)
         {
            return false;
         }
         if(this.bonusTokens > 0)
         {
            return false;
         }
         return true;
      }
      
      private function isMechAndCurrency() : Boolean
      {
         if(this.torso == 0)
         {
            return false;
         }
         if(this.bonusGold == 0)
         {
            return false;
         }
         if(this.bonusTokens == 0)
         {
            return false;
         }
         return true;
      }
      
      private function isTypeTokens() : Boolean
      {
         if(this.mechItemIDs.length > 0)
         {
            return false;
         }
         if(this.bonusGold > 0)
         {
            return false;
         }
         if(this.boostID > 0)
         {
            return false;
         }
         if(this.bonusTokens == 0)
         {
            return false;
         }
         return true;
      }
      
      public function isTypeGold() : Boolean
      {
         if(this.mechItemIDs.length > 0)
         {
            return false;
         }
         if(this.boostID > 0)
         {
            return false;
         }
         if(this.bonusTokens > 0)
         {
            return false;
         }
         if(this.bonusGold == 0)
         {
            return false;
         }
         return true;
      }
      
      public function isTypeGoldAndTokens() : Boolean
      {
         if(this.mechItemIDs.length > 0)
         {
            return false;
         }
         if(this.boostID > 0)
         {
            return false;
         }
         if(this.bonusGold == 0)
         {
            return false;
         }
         if(this.bonusTokens == 0)
         {
            return false;
         }
         return true;
      }
      
      public function isTypeOneItemAndTokens() : Boolean
      {
         if(this.mechItemIDs.length != 1)
         {
            return false;
         }
         if(this.boostID > 0)
         {
            return false;
         }
         if(this.bonusGold > 0)
         {
            return false;
         }
         if(this.bonusTokens == 0)
         {
            return false;
         }
         return true;
      }
      
      public function isTypeSeveralItemsAndTokens() : Boolean
      {
         if(this.mechItemIDs.length <= 1)
         {
            return false;
         }
         if(this.boostID > 0)
         {
            return false;
         }
         if(this.bonusGold > 0)
         {
            return false;
         }
         if(this.bonusTokens == 0)
         {
            return false;
         }
         return true;
      }
      
      public function get mechItemIDs() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < this.MECH_ITEMS.length)
         {
            if(this[this.MECH_ITEMS[_loc2_]] > 0)
            {
               _loc1_.push(this[this.MECH_ITEMS[_loc2_]]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get starterPackEndDate() : Number
      {
         return this.starterPackStartDate + this.offerDuration;
      }
      
      public function get priceWithoutCurrency() : Number
      {
         return TextUtils.getPriceWithoutCurrency(this.price);
      }
      
      public function get isGameOfWhalesOffer() : Boolean
      {
         return this.packID == GAME_OF_WHALES_OFFER_PACK_ID;
      }
   }
}

