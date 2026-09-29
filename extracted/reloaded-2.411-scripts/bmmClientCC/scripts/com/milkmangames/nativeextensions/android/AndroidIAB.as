package com.milkmangames.nativeextensions.android
{
   import flash.events.EventDispatcher;
   import flash.external.ExtensionContext;
   
   public class AndroidIAB extends EventDispatcher
   {
      
      private static var _instance:AndroidIAB;
      
      public static const VERSION:String = "2.6.0";
      
      public static const TEST_ITEM_ID_PURCHASED:String = "android.test.purchased";
      
      public static const TEST_ITEM_ID_CANCELLED:String = "android.test.canceled";
      
      public static const TEST_ITEM_ID_REFUNDED:String = "android.test.refunded";
      
      public static const TEST_ITEM_ID_UNAVAILABLE:String = "android.test.item_unavailable";
      
      private static const INVENTORY_REQUEST_ID:int = 10;
      
      private static const DETAILS_REQUEST_ID:int = 20;
      
      private static var _isCreating:Boolean = false;
      
      private var extContext:ExtensionContext = null;
      
      private var _isServiceRunning:Boolean = false;
      
      private var _isServiceStartInProgress:Boolean = false;
      
      private var _subscriptionsSupported:Boolean = false;
      
      private var logCallback:Function;
      
      private var lastRequestItemId:String;
      
      private var lastRequestPayload:String;
      
      public function AndroidIAB()
      {
         super();
         if(!_isCreating)
         {
            throw new Error("Use AndroidIAB.create() instead of \'new AndroidIAB()\'.");
         }
         this._subscriptionsSupported = false;
      }
      
      public static function create() : AndroidIAB
      {
         if(_instance != null)
         {
            throw new Error("AndroidIAB already initiated; use AndroidIAB.androidIAB to get instance.");
         }
         _isCreating = true;
         _instance = new AndroidIAB();
         _isCreating = false;
         return _instance;
      }
      
      public static function isSupported() : Boolean
      {
         return false;
      }
      
      public static function get androidIAB() : AndroidIAB
      {
         if(_instance != null)
         {
            return _instance;
         }
         throw new Error("AndroidIAB not initialized; call AndroidIAB.create() first.");
      }
      
      private function dispose() : void
      {
      }
      
      public function isBillingServiceRunning() : Boolean
      {
         return false;
      }
      
      public function areSubscriptionsSupported() : Boolean
      {
         return false;
      }
      
      public function startBillingService(param1:String) : void
      {
      }
      
      public function stopBillingService() : void
      {
      }
      
      public function purchaseItem(param1:String, param2:String = null) : void
      {
      }
      
      public function consumeItem(param1:String) : void
      {
      }
      
      public function loadPlayerInventory(param1:Boolean = false, param2:Vector.<String> = null) : void
      {
      }
      
      public function loadItemDetails(param1:Vector.<String>) : void
      {
      }
      
      public function purchaseSubscriptionItem(param1:String, param2:String = "") : void
      {
      }
      
      public function launchProductPage() : void
      {
      }
      
      public function testPurchaseItemSuccess() : void
      {
      }
      
      public function testPurchaseItemRefunded() : void
      {
      }
      
      public function testPurchaseItemCancelled() : void
      {
      }
      
      public function testPurchaseItemUnavailable() : void
      {
      }
   }
}

