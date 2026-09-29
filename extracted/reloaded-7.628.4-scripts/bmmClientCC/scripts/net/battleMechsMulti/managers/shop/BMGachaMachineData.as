package net.battleMechsMulti.managers.shop
{
   public class BMGachaMachineData
   {
      
      public var gachaMachineID:uint;
      
      public var name:String;
      
      public var description:String;
      
      public var costGold:uint;
      
      public var costTokens:uint;
      
      public var costTokensDefault:uint;
      
      public var imageID:uint;
      
      public var isInShop:Boolean;
      
      public var isInSale:Boolean;
      
      public var isInChainDiscount:Boolean;
      
      public var extraChanceItemIDs:Array;
      
      public var isSingleItem:Boolean;
      
      public function BMGachaMachineData(param1:uint, param2:String, param3:String, param4:uint, param5:uint, param6:uint, param7:uint, param8:Boolean, param9:Boolean, param10:Boolean, param11:Array, param12:Boolean)
      {
         super();
         this.gachaMachineID = param1;
         this.name = param2;
         this.description = param3;
         this.costGold = param4;
         this.costTokens = param5;
         this.costTokensDefault = param6;
         this.imageID = param7;
         this.isInShop = param8;
         this.isInSale = param9;
         this.isInChainDiscount = param10;
         if(param11 == null)
         {
            this.extraChanceItemIDs = new Array();
         }
         else
         {
            this.extraChanceItemIDs = param11;
         }
         this.isSingleItem = param12;
      }
      
      public function get itemID() : uint
      {
         if(this.isSingleItem)
         {
            return this.imageID;
         }
         return 0;
      }
   }
}

