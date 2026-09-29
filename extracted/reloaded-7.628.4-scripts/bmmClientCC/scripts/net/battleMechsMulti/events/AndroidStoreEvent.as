package net.battleMechsMulti.events
{
   import flash.events.Event;
   
   public dynamic class AndroidStoreEvent extends Event
   {
      
      public static var STOREKIT_UNAVAILABLE:String = "AndroidStoreEvent_storekitUnavailable";
      
      public static var PURCHASE_CURRENTLY_IN_PROGRESS:String = "AndroidStoreEvent_purchaseCurrentlyInProgress";
      
      public static var PRODUCT_DETAILS_LOADED:String = "AndroidStoreEvent_productDetailsLoaded";
      
      public static var PURCHASE_CREATINGORDER:String = "AndroidStoreEvent_creatingOrder";
      
      public static var PURCHASE_ORDERCREATED:String = "AndroidStoreEvent_orderCreated";
      
      public static var PURCHASE_ORDERCREATEFAULT:String = "AndroidStoreEvent_orderCreateFault";
      
      public static var PURCHASE_SUCCEEDED:String = "AndroidStoreEvent_purchaseSuccess";
      
      public static var PURCHASE_CANCELLED:String = "AndroidStoreEvent_purchaseUserCancelled";
      
      public static var PURCHASE_PENDINGINITIALIZE:String = "AndroidStoreEvent_purchasePendingInitialize";
      
      public static var TRANSACTIONS_RESTORED:String = "AndroidStoreEvent_pransactionsRestored";
      
      public static var PRODUCT_DETAILS_FAILED:String = "AndroidStoreEvent_productsFailed";
      
      public static var PURCHASE_FAILED:String = "AndroidStoreEvent_purchaseFailed";
      
      public static var TRANSACTION_RESTORE_FAILED:String = "AndroidStoreEvent_pransactionRestoreFailed";
      
      public static var PURCHASE_CANNOTCOMPLETE:String = "AndroidStoreEvent_purchaseCanNotComplete";
      
      public static var NEW_PENDING_PURCHASES:String = "AndroidStoreEvent_newPendingPurchases";
      
      public var data:Object;
      
      public function AndroidStoreEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Object = null)
      {
         if(param4 != null)
         {
            this.data = param4;
         }
         super(param1,param2,param3);
      }
   }
}

