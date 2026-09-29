package net.battleMechsMulti.managers
{
   import flash.utils.Dictionary;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   
   public class BMBoxFragmentsManager
   {
      
      private var _costDict:Dictionary;
      
      private var _fragmentAmounts:Dictionary;
      
      private var _boxesWithFragments:* = new Array();
      
      public function BMBoxFragmentsManager()
      {
         super();
      }
      
      public static function parseFragmentAmountObject(param1:Object) : Dictionary
      {
         return createDictionaryFromIntObject(param1,true);
      }
      
      public static function getNumberOfFragments(param1:Dictionary) : int
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc4_ = int(_loc3_);
            _loc2_ += param1[_loc4_];
         }
         return _loc2_;
      }
      
      private static function createDictionaryFromIntObject(param1:Object, param2:Boolean = false) : Dictionary
      {
         var _loc4_:String = null;
         var _loc3_:Dictionary = new Dictionary();
         if(param1 != null)
         {
            for(_loc4_ in param1)
            {
               if(!(param2 && param1[_loc4_] == 0))
               {
                  _loc3_[int(_loc4_)] = param1[_loc4_];
               }
            }
         }
         return _loc3_;
      }
      
      public function updateDB(param1:Object) : void
      {
         this._costDict = createDictionaryFromIntObject(param1);
      }
      
      public function addFragmentAmounts(param1:Dictionary) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         for(_loc2_ in param1)
         {
            _loc3_ = int(_loc2_);
            if(this._fragmentAmounts[_loc3_] != null)
            {
               this._fragmentAmounts[_loc3_] += param1[_loc3_];
            }
            else
            {
               this._fragmentAmounts[_loc3_] = param1[_loc3_];
               this._boxesWithFragments.push(_loc3_);
            }
         }
      }
      
      public function updateState(param1:Object) : void
      {
         this._fragmentAmounts = new Dictionary();
         this._boxesWithFragments = new Array();
         this.addFragmentAmounts(parseFragmentAmountObject(param1));
      }
      
      public function getBoxesWithFragments() : Array
      {
         return this._boxesWithFragments;
      }
      
      public function getFragmentsRequiredForBox(param1:int) : int
      {
         return this._costDict[param1];
      }
      
      public function getNumberOfFragmentsOwned(param1:int) : int
      {
         return this._fragmentAmounts[param1];
      }
      
      public function tryToClaimFragmentBox(param1:int) : void
      {
         BMRemoteManager.getInstance().socketM.lobby_claimFragmentBox(param1);
      }
      
      public function notifyFragmentBoxBought(param1:int) : void
      {
         this._fragmentAmounts[param1] -= this.getFragmentsRequiredForBox(param1);
         if(this._fragmentAmounts[param1] <= 0)
         {
            delete this._fragmentAmounts[param1];
            this._boxesWithFragments.splice(this._boxesWithFragments.indexOf(param1),1);
         }
         BMShopManager.gi().refresh();
      }
      
      public function getNumberOfBoxesReadyToBeClaimed() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         for each(_loc2_ in this._boxesWithFragments)
         {
            _loc1_ += this.getNumberOfClaimsAvailableForBox(_loc2_);
         }
         return _loc1_;
      }
      
      public function getNumberOfClaimsAvailableForBox(param1:int) : int
      {
         var _loc2_:int = this.getFragmentsRequiredForBox(param1);
         var _loc3_:int = this.getNumberOfFragmentsOwned(param1);
         return int(_loc3_ / _loc2_);
      }
   }
}

