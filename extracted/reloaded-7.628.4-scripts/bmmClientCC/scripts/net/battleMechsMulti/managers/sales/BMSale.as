package net.battleMechsMulti.managers.sales
{
   public class BMSale
   {
      
      public static const SALE_TYPE_DUMMY_SALE:uint = 0;
      
      public static const SALE_TYPE_COST_REDUCTION:uint = 1;
      
      public static const SALE_TYPE_REWARD_INCREASE:uint = 2;
      
      public static const SALE_TYPE_GACHA_MACHINE_CHANGE:uint = 3;
      
      public static const SALE_TYPE_QUEST:uint = 4;
      
      public static const SALE_TYPE_DUNGEON:uint = 5;
      
      public static const SALE_TYPE_STARTER_PACK:uint = 6;
      
      public static const STORE_SECTION_TOKENS:uint = 1;
      
      public static const STORE_SECTION_GOLD:uint = 2;
      
      public static const STORE_SECTION_ITEM_BOXES:uint = 3;
      
      public static const STORE_SECTION_CUSTOMIZE:uint = 4;
      
      public static const STORE_SECTION_PREMIUM:uint = 5;
      
      public static const STORE_SECTION_CAMPAIGN_GOLD:uint = 6;
      
      public static const STORE_SECTION_ARENA_GOLD:uint = 7;
      
      public static const STORE_SECTION_CAMPAIGN_XP:uint = 8;
      
      public static const STORE_SECTION_ARENA_XP:uint = 9;
      
      public static const STORE_SECTION_MECH_SHOP:uint = 10;
      
      public static const STORE_SECTION_CAMPAIGN_CLAN_BOSS_TICKETS:uint = 11;
      
      public static const STORE_SECTION_CAMPAIGN_BATTLE_CREDITS_REGENERATION:uint = 12;
      
      public static const STORE_SECTION_ARENA_COINS:uint = 13;
      
      public var saleID:uint;
      
      public var internalName:String;
      
      public var startDate:uint;
      
      public var duration:uint;
      
      public var newsImageLink:String;
      
      public var bannerImageLinks:Array = new Array();
      
      public var saleType:uint;
      
      public var saleEffect:uint;
      
      public var clickTarget:uint;
      
      public var clickTargetItemID:uint;
      
      public var ribbonID:uint;
      
      public var saleStoreSection:uint;
      
      public var fromGachaBoxID:int;
      
      public var toGachaBoxID:int;
      
      public var storePackageIDs:Array;
      
      public function BMSale(param1:uint, param2:String, param3:uint, param4:uint, param5:String, param6:String, param7:String, param8:uint, param9:uint, param10:uint, param11:uint, param12:uint, param13:uint, param14:uint, param15:uint, param16:Array)
      {
         super();
         this.saleID = param1;
         this.internalName = param2;
         this.startDate = param3;
         this.duration = param4;
         this.newsImageLink = param5;
         this.bannerImageLinks.push(param6);
         if(param7 != "" && param7 != null)
         {
            this.bannerImageLinks.push(param7);
         }
         this.saleType = param8;
         this.saleEffect = param9;
         this.clickTarget = param10;
         this.clickTargetItemID = param11;
         this.ribbonID = param12;
         this.saleStoreSection = param13;
         this.fromGachaBoxID = param14;
         this.toGachaBoxID = param15;
         this.storePackageIDs = param16 || [];
      }
      
      public function get starterPackID() : uint
      {
         return this.saleEffect;
      }
      
      public function get endDate() : int
      {
         return this.startDate + this.duration * 60 * 60;
      }
   }
}

