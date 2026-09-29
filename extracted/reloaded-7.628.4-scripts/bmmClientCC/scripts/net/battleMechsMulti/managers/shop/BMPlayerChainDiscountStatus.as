package net.battleMechsMulti.managers.shop
{
   public class BMPlayerChainDiscountStatus
   {
      
      public var gachaMachineID:uint;
      
      public var startDate:uint;
      
      public var purchases:uint;
      
      public function BMPlayerChainDiscountStatus(param1:uint, param2:uint, param3:uint)
      {
         super();
         this.gachaMachineID = param1;
         this.startDate = param2;
         this.purchases = param3;
      }
   }
}

