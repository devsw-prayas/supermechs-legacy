package net.battleMechsMulti.managers.sales
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.shop.BMMechShopData;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   
   public class BMSalesManager
   {
      
      private static var _instance:BMSalesManager;
      
      private static var _allowInstantiation:Boolean;
      
      private var saleData:BMSale = null;
      
      private var boughtSales:Array;
      
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
      
      public function setSale(param1:Object, param2:Array) : void
      {
         var _loc3_:BMSale = new BMSale(param1.id,param1.internalName,param1.startDate,param1.duration,param1.newsImageLink,param1.bannerImageLink,param1.bannerImageLink2,param1.saleType,param1.saleEffect,param1.clickTarget,param1.clickTargetItemID,param1.ribbonID,param1.saleStoreSection,param1.fromGachaBoxID,param1.toGachaBoxID,param1.storePackageIDs);
         this.boughtSales = param2;
         if(this.saleItemAlreadyBought(_loc3_.saleID))
         {
            TsLogger.log("Sale " + _loc3_.saleID + " Already bought");
            this.saleData = null;
         }
         else
         {
            this.saleData = _loc3_;
         }
      }
      
      public function clearSale() : void
      {
         this.saleData = null;
      }
      
      public function activeSaleBought() : void
      {
         if(this.saleData == null)
         {
            return;
         }
         this.boughtSales.push(this.saleData.saleID);
      }
      
      private function saleItemAlreadyBought(param1:uint) : Boolean
      {
         if(this.boughtSales == null)
         {
            return false;
         }
         if(this.boughtSales.indexOf(param1) >= 0)
         {
            return true;
         }
         return false;
      }
      
      public function generateSaleStarterPackData() : void
      {
         var _loc6_:BMMechShopData = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:BMTokenPackage = null;
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(_loc1_.myProfile.starterPackData.packID > 0)
         {
            return;
         }
         if(this.isSaleActive(_loc1_.currentTime) == false)
         {
            return;
         }
         if(this.saleData.saleType != BMSale.SALE_TYPE_STARTER_PACK)
         {
            return;
         }
         var _loc2_:BMStarterPackData = new BMStarterPackData();
         var _loc3_:BMStarterPackData = _loc1_.starterPackData[this.saleData.starterPackID];
         _loc1_.myProfile.setStarterPackData(_loc3_);
         _loc1_.myProfile.starterPackData.offerDuration = this.saleData.duration * 3600;
         _loc1_.myProfile.starterPackData.starterPackStartDate = this.saleData.startDate;
         var _loc4_:String = "";
         var _loc5_:uint = BMStarterPackData.PRICE_TYPE_MONEY;
         if(this.saleData.storePackageIDs != null && this.saleData.storePackageIDs.length > 0)
         {
            _loc7_ = uint(this.saleData.storePackageIDs[BMDataManager.platformID - 1]);
            _loc8_ = 0;
            while(_loc8_ < _loc1_.allTokenPackages.length)
            {
               _loc9_ = _loc1_.allTokenPackages[_loc8_];
               if(_loc9_.packageID == _loc7_)
               {
                  _loc1_.myProfile.starterPackData.tokenPackageID = _loc7_;
                  _loc1_.myProfile.starterPackData.price = _loc9_.price;
                  _loc1_.myProfile.starterPackData.priceType = _loc5_;
               }
               _loc8_++;
            }
            return;
         }
         for each(_loc6_ in _loc1_.mechShopData)
         {
            if(_loc6_.starterPackID == this.saleData.starterPackID)
            {
               if(_loc6_.tokensCost > 0)
               {
                  _loc4_ = String(_loc6_.tokensCost);
                  _loc5_ = BMStarterPackData.PRICE_TYPE_TOKENS;
               }
               else if(_loc6_.goldCost > 0)
               {
                  _loc4_ = String(_loc6_.goldCost);
                  _loc5_ = BMStarterPackData.PRICE_TYPE_GOLD;
               }
               _loc1_.myProfile.starterPackData.price = _loc4_;
               _loc1_.myProfile.starterPackData.priceType = _loc5_;
               _loc1_.myProfile.starterPackData.starterPackShopID = _loc6_.packageID;
               return;
            }
         }
      }
      
      public function isSaleActive(param1:Number, param2:int = -1, param3:Boolean = false) : Boolean
      {
         if(this.saleData == null)
         {
            return false;
         }
         if(this.saleItemAlreadyBought(this.saleData.saleID))
         {
            return false;
         }
         if(param2 != -1 && param2 != this.saleData.saleStoreSection)
         {
            return false;
         }
         if(this.saleData.startDate < param1 && this.saleData.endDate > param1)
         {
            if(param3 && this.saleData.saleType == BMSale.SALE_TYPE_STARTER_PACK)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function saleTimeLeft(param1:Number) : uint
      {
         var _loc3_:uint = 0;
         var _loc2_:uint = 0;
         if(this.saleData != null)
         {
            _loc3_ = this.saleData.duration * 60 * 60;
            if(this.saleData.startDate + _loc3_ > param1)
            {
               _loc2_ = this.saleData.startDate + _loc3_ - param1;
            }
         }
         return _loc2_;
      }
      
      public function getSaleData() : BMSale
      {
         return this.saleData;
      }
      
      public function isStarterPackSale() : Boolean
      {
         if(this.saleData == null)
         {
            return false;
         }
         if(this.saleData.saleType == BMSale.SALE_TYPE_STARTER_PACK)
         {
            return true;
         }
         return false;
      }
      
      public function updateBoughtSales(param1:Array) : void
      {
         if(this.saleData != null && param1.indexOf(this.saleData.saleID) >= 0)
         {
            this.saleData = null;
         }
      }
      
      public function shouldDisplaySaleInMainScreen(param1:BMSale) : Boolean
      {
         return param1.saleType != BMSale.SALE_TYPE_STARTER_PACK;
      }
   }
}

