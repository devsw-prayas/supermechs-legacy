package net.battleMechsMulti.managers.shop
{
   public class BMGoldPackageData
   {
      
      public var title:String = "";
      
      public var bonus:String = "";
      
      public var goldPackageID:uint = 0;
      
      public var costTokens:uint = 0;
      
      public var costTokensDefault:uint = 0;
      
      public var gold:uint = 0;
      
      public var visual:uint = 0;
      
      public var banner:uint = 0;
      
      public var sortID:uint = 0;
      
      public function BMGoldPackageData(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint, param9:uint)
      {
         super();
         this.title = param1;
         this.bonus = param2;
         this.goldPackageID = param3;
         this.costTokens = param4;
         this.costTokensDefault = param5;
         this.gold = param6;
         this.visual = param7;
         this.banner = param8;
         this.sortID = param9;
      }
   }
}

