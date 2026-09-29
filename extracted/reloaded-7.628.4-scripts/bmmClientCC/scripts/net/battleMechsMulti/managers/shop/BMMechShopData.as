package net.battleMechsMulti.managers.shop
{
   public class BMMechShopData
   {
      
      public var packageID:uint;
      
      public var starterPackID:uint;
      
      public var tokensCost:uint = 0;
      
      public var goldCost:uint = 0;
      
      public var mechName:String = "";
      
      public var description:String = "";
      
      public var isActive:Boolean;
      
      public function BMMechShopData(param1:uint, param2:uint, param3:uint, param4:uint, param5:String, param6:String, param7:Boolean)
      {
         super();
         this.packageID = param1;
         this.starterPackID = param2;
         this.tokensCost = param3;
         this.goldCost = param4;
         this.mechName = param5;
         this.description = param6;
         this.isActive = param7;
      }
   }
}

