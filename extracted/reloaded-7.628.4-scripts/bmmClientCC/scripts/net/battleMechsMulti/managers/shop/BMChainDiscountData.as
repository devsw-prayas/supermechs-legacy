package net.battleMechsMulti.managers.shop
{
   public class BMChainDiscountData
   {
      
      public var gachaMachineID:uint;
      
      public var discounts:Array;
      
      public var durationInSeconds:uint;
      
      public function BMChainDiscountData(param1:uint, param2:Array, param3:uint)
      {
         super();
         this.gachaMachineID = param1;
         this.discounts = param2;
         this.durationInSeconds = param3;
      }
   }
}

