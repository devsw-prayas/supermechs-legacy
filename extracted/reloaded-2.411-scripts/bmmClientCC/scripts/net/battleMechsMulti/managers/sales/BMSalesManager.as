package net.battleMechsMulti.managers.sales
{
   public class BMSalesManager
   {
      
      private static var _instance:BMSalesManager;
      
      private static var _allowInstantiation:Boolean;
      
      private var saleData:BMSale;
      
      public function BMSalesManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMSalesManager.getInstance() instead of new.");
         }
      }
      
      public static function gi() : BMSalesManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMSalesManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function setSale(param1:Object) : void
      {
         this.saleData = new BMSale(param1.saleID,param1.startDate,param1.duration,param1.specialOfferUrl1,param1.specialOfferUrl2,param1.clickTarget,param1.clickTargetItemID);
      }
      
      public function isSaleActive(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         if(this.saleData != null)
         {
            if(this.saleData.startDate < param1 && this.saleData.startDate + this.saleData.duration > param1)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function saleTimeLeft(param1:Number) : uint
      {
         var _loc2_:uint = 0;
         if(this.saleData != null)
         {
            if(this.saleData.startDate + this.saleData.duration > param1)
            {
               _loc2_ = this.saleData.startDate + this.saleData.duration - param1;
            }
         }
         return _loc2_;
      }
      
      public function getSaleData() : BMSale
      {
         return this.saleData;
      }
   }
}

