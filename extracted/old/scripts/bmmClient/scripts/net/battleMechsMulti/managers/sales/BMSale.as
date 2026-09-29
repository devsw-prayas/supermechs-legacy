package net.battleMechsMulti.managers.sales
{
   public class BMSale
   {
      
      public var saleID:uint;
      
      public var startDate:uint;
      
      public var duration:uint;
      
      public var specialOfferUrl1:String;
      
      public var specialOfferUrl2:String;
      
      public var clickTarget:uint;
      
      public var clickTargetItemID:uint;
      
      public function BMSale(param1:uint, param2:uint, param3:uint, param4:String, param5:String, param6:uint, param7:uint)
      {
         super();
         this.saleID = param1;
         this.startDate = param2;
         this.duration = param3;
         this.specialOfferUrl1 = param4;
         this.specialOfferUrl2 = param5;
         this.clickTarget = param6;
         this.clickTargetItemID = param7;
      }
   }
}

