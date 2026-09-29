package net.battleMechsMulti.managers.shop
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMChainDiscountsResolver
   {
      
      private var _chainDiscountsDataString:String = "";
      
      public function BMChainDiscountsResolver()
      {
         super();
      }
      
      public function isChainDiscountAvailableForGachaMachine(param1:uint) : Boolean
      {
         var _loc3_:BMChainDiscountData = null;
         if(this.chainDiscountsData == null)
         {
            return false;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.chainDiscountsData.length)
         {
            _loc3_ = this.chainDiscountsData[_loc2_];
            if(_loc3_.gachaMachineID == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isActiveDiscount(param1:uint) : Boolean
      {
         return this.getActiveChainDiscountSecondsLeft(param1) > 0;
      }
      
      public function getActiveChainDiscountPurchases(param1:uint) : uint
      {
         if(this.isChainDiscountAvailableForGachaMachine(param1) == false)
         {
            return 0;
         }
         var _loc2_:BMPlayerChainDiscountStatus = this.getPlayerChainDiscountStatus(param1);
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_.purchases;
      }
      
      public function getCurrentDiscount(param1:uint) : uint
      {
         this.checkForChainDiscountReset(param1);
         var _loc2_:BMPlayerChainDiscountStatus = this.getPlayerChainDiscountStatus(param1);
         if(_loc2_ == null)
         {
            return 0;
         }
         return this.getDiscountByPurchases(param1,_loc2_.purchases);
      }
      
      private function checkForChainDiscountReset(param1:uint) : void
      {
         var _loc2_:BMPlayerChainDiscountStatus = this.getPlayerChainDiscountStatus(param1);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:uint = this.getActiveChainDiscountEndDate(param1);
         var _loc4_:BMDataManager = BMDataManager.getInstance();
         if(_loc3_ <= _loc4_.currentTime)
         {
            _loc4_.myProfile.removeChainDiscountStatus(param1);
         }
      }
      
      public function getNextBoxDiscount(param1:uint) : uint
      {
         var _loc2_:BMPlayerChainDiscountStatus = this.getPlayerChainDiscountStatus(param1);
         if(_loc2_ == null)
         {
            return 0;
         }
         return this.getDiscountByPurchases(param1,_loc2_.purchases + 1);
      }
      
      private function getDiscountByPurchases(param1:uint, param2:uint) : uint
      {
         var _loc3_:BMChainDiscountData = this.getSpecificChainDiscountData(param1);
         if(_loc3_ == null)
         {
            return 0;
         }
         if(param2 > _loc3_.discounts.length)
         {
            return _loc3_.discounts[_loc3_.discounts.length - 1];
         }
         return _loc3_.discounts[param2 - 1];
      }
      
      public function getMaxDiscount(param1:uint) : uint
      {
         var _loc2_:BMChainDiscountData = this.getSpecificChainDiscountData(param1);
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_.discounts[_loc2_.discounts.length - 1];
      }
      
      private function getPlayerChainDiscountStatus(param1:uint) : BMPlayerChainDiscountStatus
      {
         var _loc4_:BMPlayerChainDiscountStatus = null;
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.myProfile.chainDiscountsStatus.length)
         {
            _loc4_ = _loc2_.myProfile.chainDiscountsStatus[_loc3_];
            if(_loc4_.gachaMachineID == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getActiveChainDiscountGachaMachineIDs() : Array
      {
         var _loc4_:BMPlayerChainDiscountStatus = null;
         var _loc5_:uint = 0;
         var _loc1_:Array = new Array();
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         if(_loc2_.myProfile.chainDiscountsStatus.length == 0)
         {
            return _loc1_;
         }
         var _loc3_:* = int(_loc2_.myProfile.chainDiscountsStatus.length - 1);
         while(_loc3_ >= 0)
         {
            _loc4_ = _loc2_.myProfile.chainDiscountsStatus[_loc3_];
            _loc5_ = _loc4_.gachaMachineID;
            this.checkForChainDiscountReset(_loc5_);
            if(_loc2_.myProfile.chainDiscountsStatus[_loc3_] != null)
            {
               _loc1_.push(_loc5_);
            }
            _loc3_--;
         }
         return _loc1_;
      }
      
      public function getActiveChainDiscountEndDate(param1:uint) : uint
      {
         if(this.isChainDiscountAvailableForGachaMachine(param1) == false)
         {
            return 0;
         }
         var _loc2_:BMPlayerChainDiscountStatus = this.getPlayerChainDiscountStatus(param1);
         if(_loc2_ == null)
         {
            return 0;
         }
         var _loc3_:BMChainDiscountData = this.getSpecificChainDiscountData(param1);
         if(_loc3_ == null)
         {
            return 0;
         }
         var _loc4_:BMDataManager = BMDataManager.getInstance();
         var _loc5_:int = _loc2_.startDate + _loc3_.durationInSeconds;
         if(_loc5_ > _loc4_.currentTime)
         {
            return _loc5_;
         }
         return 0;
      }
      
      public function getActiveChainDiscountSecondsLeft(param1:uint) : uint
      {
         if(this.isChainDiscountAvailableForGachaMachine(param1) == false)
         {
            return 0;
         }
         var _loc2_:uint = this.getActiveChainDiscountEndDate(param1);
         if(_loc2_ == 0)
         {
            return 0;
         }
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         var _loc4_:int = _loc2_ - _loc3_.currentTime;
         return Math.max(0,_loc4_);
      }
      
      private function getSpecificChainDiscountData(param1:uint) : BMChainDiscountData
      {
         var _loc3_:BMChainDiscountData = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.chainDiscountsData.length)
         {
            _loc3_ = this.chainDiscountsData[_loc2_];
            if(_loc3_.gachaMachineID == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function setChainDiscountsDataString(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._chainDiscountsDataString = param1;
      }
      
      private function get chainDiscountsData() : Array
      {
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:BMChainDiscountData = null;
         if(this._chainDiscountsDataString == "")
         {
            return null;
         }
         var _loc1_:Object = JSON.parse(this._chainDiscountsDataString);
         var _loc2_:Array = new Array();
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = uint(_loc3_.gachaMachineID);
            _loc5_ = _loc3_.discounts;
            _loc6_ = uint(_loc3_.durationInSeconds);
            _loc7_ = new BMChainDiscountData(_loc4_,_loc5_,_loc6_);
            _loc2_.push(_loc7_);
         }
         return _loc2_;
      }
      
      public function gachaMachineBought(param1:uint) : void
      {
         if(this.isChainDiscountAvailableForGachaMachine(param1) == false)
         {
            return;
         }
         var _loc2_:BMPlayerChainDiscountStatus = this.getPlayerChainDiscountStatus(param1);
         if(_loc2_ == null)
         {
            BMDataManager.getInstance().myProfile.addNewChainDiscountStatus(param1);
         }
         else
         {
            _loc2_.purchases += 1;
         }
         if(this.getCurrentDiscount(param1) > 0)
         {
            BMPubSub.pub(BMPubSub.MESSAGE_SHOP_ACTIVE_CHAIN_DISCOUNT_UPDATED,{"gachaMachineID":param1});
         }
      }
   }
}

