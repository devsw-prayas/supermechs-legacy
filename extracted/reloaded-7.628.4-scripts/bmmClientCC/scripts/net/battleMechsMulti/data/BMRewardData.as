package net.battleMechsMulti.data
{
   import flash.utils.Dictionary;
   import net.battleMechsMulti.managers.BMBoxFragmentsManager;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.tacticsoft.utils.DictionaryUtils;
   
   public class BMRewardData
   {
      
      public var xp:int = 0;
      
      public var gold:int = 0;
      
      public var tokens:int = 0;
      
      public var battleCredits:uint = 0;
      
      public var arenaCoins:int = 0;
      
      public var clanCoins:int = 0;
      
      public var clanBossTickets:int = 0;
      
      public var vanityCoins:uint = 0;
      
      public var nukes:int = 0;
      
      public var items:Vector.<BMPlayerItemData> = new Vector.<BMPlayerItemData>();
      
      public var boxes:Vector.<uint> = new Vector.<uint>();
      
      public var levelUpData:BMLevelUpData = null;
      
      public var boxFragments:Dictionary = null;
      
      public function BMRewardData(param1:Object = null)
      {
         var _loc2_:uint = 0;
         super();
         if(param1 == null)
         {
            return;
         }
         if(param1.hasOwnProperty("xp"))
         {
            this.xp = param1["xp"];
         }
         if(param1.hasOwnProperty("gold"))
         {
            this.gold = param1["gold"];
         }
         if(param1.hasOwnProperty("tokens"))
         {
            this.tokens = param1["tokens"];
         }
         if(param1.hasOwnProperty("battleCredits"))
         {
            this.battleCredits = param1["battleCredits"];
         }
         if(param1.hasOwnProperty("arenaCoins"))
         {
            this.arenaCoins = param1["arenaCoins"];
         }
         if(param1.hasOwnProperty("clanCoins"))
         {
            this.clanCoins = param1["clanCoins"];
         }
         if(param1.hasOwnProperty("clanBossTickets"))
         {
            this.clanBossTickets = param1["clanBossTickets"];
         }
         if(param1.hasOwnProperty("vanityCoins"))
         {
            this.vanityCoins = param1["vanityCoins"];
         }
         if(param1.hasOwnProperty("nukes"))
         {
            this.nukes = param1["nukes"];
         }
         if(param1.hasOwnProperty("items"))
         {
            this.parseItems(param1.items);
         }
         if(param1.hasOwnProperty("boxes"))
         {
            for each(_loc2_ in param1.boxes)
            {
               this.boxes.push(_loc2_);
            }
         }
         if(param1.hasOwnProperty("levelUpData"))
         {
            this.levelUpData = BMLevelUpData.create(param1["levelUpData"]);
         }
         if(param1.hasOwnProperty("boxFragments"))
         {
            this.boxFragments = BMBoxFragmentsManager.parseFragmentAmountObject(param1.boxFragments);
         }
      }
      
      public function parseItems(param1:Object) : *
      {
         var _loc2_:Object = null;
         var _loc3_:BMPlayerItemData = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = new BMPlayerItemData();
            _loc3_.itemID = _loc2_.itemID;
            _loc3_.playerItemID = _loc2_.playerItemID;
            _loc3_.power = _loc2_.power;
            _loc3_.colorID = _loc2_.colorID;
            this.items.push(_loc3_);
         }
      }
      
      public function get hasCurrencyReward() : Boolean
      {
         return this.gold > 0 || this.xp > 0 || this.battleCredits > 0 || this.tokens > 0 || this.clanCoins > 0 || this.vanityCoins > 0 || this.arenaCoins > 0;
      }
      
      public function get hasItems() : Boolean
      {
         return this.items != null && this.items.length > 0;
      }
      
      public function get hasBoxes() : Boolean
      {
         return this.boxes != null && this.boxes.length > 0;
      }
      
      public function get hasBoxFragments() : Boolean
      {
         return this.boxFragments != null && DictionaryUtils.isEmpty(this.boxFragments) == false;
      }
      
      public function get hasSpecificItemFragments() : Boolean
      {
         return this.fragmentItemID > 0;
      }
      
      public function get fragmentItemID() : uint
      {
         var _loc1_:Object = null;
         var _loc2_:BMGachaMachineData = null;
         if(this.hasBoxFragments == false)
         {
            return 0;
         }
         for(_loc1_ in this.boxFragments)
         {
            _loc2_ = BMDataManager.getInstance().gachaMachinesDB[_loc1_];
            if(_loc2_.isSingleItem)
            {
               return _loc2_.itemID;
            }
         }
         return 0;
      }
      
      public function get numBoxFragments() : int
      {
         return BMBoxFragmentsManager.getNumberOfFragments(this.boxFragments);
      }
      
      public function get hasItemsOrBoxes() : Boolean
      {
         return this.hasBoxes || this.hasItems;
      }
      
      public function getItemIds() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this.items.length)
         {
            _loc1_.push(this.items[_loc2_].itemID);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getPlayerItemIds() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this.items.length)
         {
            _loc1_.push(this.items[_loc2_].playerItemID);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get hasContent() : Boolean
      {
         return this.xp > 0 || this.gold > 0 || this.tokens > 0 || this.battleCredits > 0 || this.arenaCoins > 0 || this.clanBossTickets > 0 || this.vanityCoins > 0 || this.clanCoins > 0 || this.nukes > 0 || this.hasItemsOrBoxes || this.hasBoxFragments || this.levelUpData != null && this.levelUpData.hasContent();
      }
   }
}

