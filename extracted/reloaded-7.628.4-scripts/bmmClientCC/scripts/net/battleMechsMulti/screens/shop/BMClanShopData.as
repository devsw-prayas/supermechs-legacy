package net.battleMechsMulti.screens.shop
{
   public class BMClanShopData
   {
      
      public static const TYPE_ITEM_BOX:int = 1;
      
      public static const TYPE_ITEM:int = 4;
      
      public static const TYPE_GOLD:int = 2;
      
      public static const TYPE_PREMIUM_ACCOUNT:int = 6;
      
      public static const TYPE_MECH:int = 3;
      
      public static const TYPE_TOKENS:int = 0;
      
      public var clanShopID:uint;
      
      public var itemType:int;
      
      public var itemID:uint;
      
      public var price:uint;
      
      public function BMClanShopData(param1:uint, param2:int, param3:uint, param4:uint)
      {
         super();
         this.clanShopID = param1;
         this.itemType = param2;
         this.itemID = param3;
         this.price = param4;
      }
   }
}

