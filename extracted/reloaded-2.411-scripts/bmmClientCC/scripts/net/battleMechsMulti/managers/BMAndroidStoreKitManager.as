package net.battleMechsMulti.managers
{
   import com.milkmangames.nativeextensions.android.*;
   import com.milkmangames.nativeextensions.android.events.*;
   import flash.events.EventDispatcher;
   import flash.net.SharedObject;
   import net.battleMechsMulti.events.AndroidStoreEvent;
   import net.tacticsoft.events.DynamicEvent;
   import net.tacticsoft.managers.BMMSessionManager;
   import net.tacticsoft.responders.AndroidPurchasingResponder;
   import net.tacticsoft.utils.MiscUtils;
   
   public class BMAndroidStoreKitManager extends EventDispatcher
   {
      
      private static var _instance:BMAndroidStoreKitManager;
      
      private static const PUBLIC_KEY:String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuE4KHnfSqJ9VRFdcJwE8g8bJLZmE6RwKgZ0wvp9UoExo6pKDZ2uXJGiuUVo07mjDiY08XhvzANBqINFc3hHid3iwdTa6GmeU46o/v0K5yuhDAdszApcr6GHc87VA6BhEhL7bR4H8TRCjCxMKNupvXcsDYEk5Hb/W6Zc/PmHL/hGDzrgbLZ4Z5DS12RApjzzwPH6vYJtvfw6oH8JP4L0VTsKofTS+PUpmiYqzf26QFMPHS13he9QqhijUDWO7eYnfNiCey7pbJuaCSWdiF9YcvCcP+D0tiFTUimADAznbDh7ANeNYjXPAMNfYB+lURPFsstNTsqwvtWhVEhmDTrvMLwIDAQAB";
      
      private var androidIAB:AndroidIAB;
      
      private var purchasePending:Object;
      
      private var validProducts:Array = [];
      
      private var tsProducts:Array = [];
      
      private var purchaseSO:SharedObject;
      
      private var androidPurchasingResponder:AndroidPurchasingResponder;
      
      public var productsAvailable:Boolean = false;
      
      public var restoreTransactionsNeeded:Boolean = false;
      
      private var _pendingPurchases:Vector.<AndroidPurchase>;
      
      private var _initialized:Boolean = false;
      
      private var testMode:Boolean = false;
      
      public function BMAndroidStoreKitManager()
      {
         super();
         TsLogger.log("BMAndroidStoreKitManager :: Constructor.");
         if(BMAndroidStoreKitManager._instance)
         {
            throw new Error("BMAndroidStoreKitManager is a singleton, see BMAndroidStoreKitManager.getInstance()");
         }
         this.initialize();
      }
      
      public static function getInstance() : BMAndroidStoreKitManager
      {
         if(_instance == null)
         {
            _instance = new BMAndroidStoreKitManager();
         }
         return _instance;
      }
      
      public static function gi() : BMAndroidStoreKitManager
      {
         return getInstance();
      }
      
      private function initialize() : void
      {
         if(!this._initialized)
         {
            if(AndroidIAB.isSupported())
            {
               this.androidIAB = AndroidIAB.create();
            }
            else
            {
               TsLogger.log("BMAndroidStoreKitManager :: initialize() - StoreKit only works on android !");
               if(!this.testMode)
               {
                  dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.STOREKIT_UNAVAILABLE));
                  return;
               }
            }
            if(!this.testMode)
            {
               AndroidIAB.androidIAB.addEventListener(AndroidBillingEvent.SERVICE_READY,this.initializeProducts);
               AndroidIAB.androidIAB.addEventListener(AndroidBillingEvent.SERVICE_NOT_SUPPORTED,this.onServiceUnsupported);
               AndroidIAB.androidIAB.addEventListener(AndroidBillingEvent.PURCHASE_SUCCEEDED,this.onPurchaseSuccess);
               AndroidIAB.androidIAB.addEventListener(AndroidBillingErrorEvent.PURCHASE_FAILED,this.onPurchaseFailed);
               AndroidIAB.androidIAB.addEventListener(AndroidBillingEvent.INVENTORY_LOADED,this.onInventoryLoaded);
               AndroidIAB.androidIAB.addEventListener(AndroidBillingErrorEvent.LOAD_INVENTORY_FAILED,this.onInventoryFailed);
               AndroidIAB.androidIAB.addEventListener(AndroidBillingEvent.CONSUME_SUCCEEDED,this.onConsumed);
               AndroidIAB.androidIAB.addEventListener(AndroidBillingErrorEvent.CONSUME_FAILED,this.onConsumeFailed);
               AndroidIAB.androidIAB.addEventListener(AndroidBillingEvent.ITEM_DETAILS_LOADED,this.onItemDetails);
               AndroidIAB.androidIAB.addEventListener(AndroidBillingErrorEvent.ITEM_DETAILS_FAILED,this.onItemDetailsFailed);
               AndroidIAB.androidIAB.startBillingService(PUBLIC_KEY);
            }
            this.purchaseSO = SharedObject.getLocal("iabPurchaseSO","/");
            if(!this.purchaseSO.data.created)
            {
               this.purchaseSO.data.created = new Date();
               this.purchaseSO.data.currentPlayerID = null;
               this.purchaseSO.data.previousPlayerID = null;
               this.purchaseSO.data.purchaseMap = {};
               this.purchaseSO.flush();
            }
            if(this.purchaseSO.data.purchaseMap == null)
            {
               this.purchaseSO.data.purchaseMap = {};
               this.purchaseSO.flush();
            }
            this.androidPurchasingResponder = new AndroidPurchasingResponder(BMMSessionManager.gi("").session.serviceURL);
            this._initialized = true;
            if(this.testMode)
            {
               this.initializeProducts();
            }
         }
      }
      
      public function playerUserConnected(param1:uint) : void
      {
         if(this.purchaseSO.data.currentPlayerID != null)
         {
            this.purchaseSO.data.previousPlayerID = this.purchaseSO.data.currentPlayerID;
         }
         this.purchaseSO.data.currentPlayerID = param1;
         this.purchaseSO.flush();
      }
      
      private function onItemDetails(param1:AndroidBillingEvent) : void
      {
         var _loc4_:AndroidItemDetails = null;
         var _loc5_:Object = null;
         TsLogger.log("BMAndroidStoreKitManager :: onItemDetails() - ");
         var _loc2_:uint = param1.itemDetails.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.itemDetails[_loc3_];
            _loc5_ = new Object();
            _loc5_.productId = _loc4_.itemId;
            _loc5_.title = _loc4_.title.replace(" (Super Mechs)","");
            _loc5_.description = _loc4_.description;
            _loc5_.price = Number(_loc4_.priceAmountMicros * 0.000001).toPrecision(6);
            _loc5_.localId = _loc4_.priceCurrencyCode;
            _loc5_.localizedPrice = _loc4_.price;
            _loc5_.displayPrice = _loc4_.price + " " + _loc4_.priceCurrencyCode;
            _loc5_.tsProduct = this.tsProducts[_loc4_.itemId];
            _loc5_.sort = uint(_loc5_.tsProduct.count);
            this.validProducts[_loc4_.itemId] = _loc5_;
            _loc3_++;
         }
         this.productsAvailable = true;
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PRODUCT_DETAILS_LOADED));
         this.purchaseSO.data.previousValidProducts = this.validProducts;
         this.purchaseSO.flush();
         this.loadPendingPurchases();
      }
      
      private function onItemDetailsFailed(param1:AndroidBillingErrorEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onItemDetailsFailed() - Error event:");
         TsLogger.log(param1.text);
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PRODUCT_DETAILS_FAILED));
      }
      
      public function loadPendingPurchases() : *
      {
         TsLogger.log("BMAndroidStoreKitManager :: loadPlayerInventory");
         AndroidIAB.androidIAB.loadPlayerInventory();
      }
      
      private function onInventoryLoaded(param1:AndroidBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onInventoryLoaded()");
         this._pendingPurchases = param1.purchases;
         if(this.hasPendingPurchases)
         {
            dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.NEW_PENDING_PURCHASES));
         }
      }
      
      public function get hasPendingPurchases() : *
      {
         return this._pendingPurchases != null && this._pendingPurchases.length > 0;
      }
      
      public function hasPandingPurchase(param1:String) : Boolean
      {
         var _loc2_:AndroidPurchase = null;
         if(this._pendingPurchases == null)
         {
            return false;
         }
         for each(_loc2_ in this._pendingPurchases)
         {
            if(_loc2_.itemId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function processNextPendingPurchase() : *
      {
         if(!this.hasPendingPurchases)
         {
            return;
         }
         var _loc1_:AndroidPurchase = this._pendingPurchases.shift();
         this.purchasePending = new Object();
         this.purchasePending.purchaseToken = _loc1_.purchaseToken;
         this.purchasePending.itemId = _loc1_.itemId;
         this.purchaseSO.data.purchasePending = this.purchasePending;
         this.purchaseSO.flush();
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_RESULT,this.onCompleteOrderResult);
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_FAULT,this.onCompleteOrderFault);
         this.androidPurchasingResponder.completeOrder(null,_loc1_.jsonData);
      }
      
      private function onInventoryFailed(param1:AndroidBillingErrorEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onInventoryFailed() - Error event:");
         TsLogger.log(param1.text);
      }
      
      public function initializeProducts(param1:AndroidBillingEvent = null) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: initializeProducts() - ");
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_GETPRODUCTLIST_RESULT,this.onGetProductListResult);
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_GETPRODUCTLIST_FAULT,this.onGetProductListFault);
         this.androidPurchasingResponder.getProductList();
      }
      
      private function onServiceReady(param1:AndroidBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onServiceReady() - ");
      }
      
      private function onServiceUnsupported(param1:AndroidBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onServiceUnsupported() - ");
      }
      
      private function onGetProductListResult(param1:DynamicEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onGetProductListResult() - ");
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_GETPRODUCTLIST_RESULT,this.onGetProductListResult);
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_GETPRODUCTLIST_FAULT,this.onGetProductListFault);
         this.loadProductDetails(param1.result);
      }
      
      private function onGetProductListFault(param1:DynamicEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onGetProductListFault() - ");
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_GETPRODUCTLIST_RESULT,this.onGetProductListResult);
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_GETPRODUCTLIST_FAULT,this.onGetProductListFault);
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PRODUCT_DETAILS_FAILED));
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.STOREKIT_UNAVAILABLE));
      }
      
      private function loadProductDetails(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         TsLogger.log("BMAndroidStoreKitManager :: loadProductDetails() - ");
         var _loc2_:Vector.<String> = new Vector.<String>();
         for each(_loc3_ in param1)
         {
            _loc4_ = String(_loc3_["android_id"]);
            _loc2_.push(_loc4_);
            this.tsProducts[_loc4_] = _loc3_;
         }
         if(!this.testMode && AndroidIAB.isSupported())
         {
            AndroidIAB.androidIAB.loadItemDetails(_loc2_);
         }
         else
         {
            TsLogger.log("BMAndroidStoreKitManager :: loadProductDetails() - Manually adding products.");
            this.validProducts["com.supermechs.superapp.1"] = new Object();
            this.validProducts["com.supermechs.superapp.1"].productId = "com.supermechs.superapp.1";
            this.validProducts["com.supermechs.superapp.1"].title = "200 Tokens";
            this.validProducts["com.supermechs.superapp.1"].description = "200 Tokens for use in game.";
            this.validProducts["com.supermechs.superapp.1"].localizedPrice = "4.99";
            this.validProducts["com.supermechs.superapp.1"].tsProduct = this.tsProducts["com.supermechs.superapp.1"];
            this.validProducts["com.supermechs.superapp.1"].sort = uint(this.tsProducts["com.supermechs.superapp.1"].count);
            this.validProducts["com.supermechs.superapp.2"] = new Object();
            this.validProducts["com.supermechs.superapp.2"].productId = "com.supermechs.superapp.2";
            this.validProducts["com.supermechs.superapp.2"].title = "400 Tokens";
            this.validProducts["com.supermechs.superapp.2"].description = "400 Tokens for use in game.";
            this.validProducts["com.supermechs.superapp.2"].localizedPrice = "7.99";
            this.validProducts["com.supermechs.superapp.2"].tsProduct = this.tsProducts["com.supermechs.superapp.2"];
            this.validProducts["com.supermechs.superapp.2"].sort = uint(this.tsProducts["com.supermechs.superapp.2"].count);
            this.validProducts["com.supermechs.superapp.3"] = new Object();
            this.validProducts["com.supermechs.superapp.3"].productId = "com.supermechs.superapp.3";
            this.validProducts["com.supermechs.superapp.3"].title = "1000 Tokens";
            this.validProducts["com.supermechs.superapp.3"].description = "1000 Tokens for use in game.";
            this.validProducts["com.supermechs.superapp.3"].localizedPrice = "17.99";
            this.validProducts["com.supermechs.superapp.3"].tsProduct = this.tsProducts["com.supermechs.superapp.3"];
            this.validProducts["com.supermechs.superapp.3"].sort = uint(this.tsProducts["com.supermechs.superapp.3"].count);
            this.productsAvailable = true;
            dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PRODUCT_DETAILS_LOADED));
         }
      }
      
      protected function onProductsLoaded(param1:AndroidBillingEvent) : void
      {
         var _loc4_:AndroidItemDetails = null;
         var _loc5_:Object = null;
         TsLogger.log("BMAndroidStoreKitManager :: onProductsLoaded() - ");
         var _loc2_:uint = param1.itemDetails.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.itemDetails[_loc3_];
            TsLogger.log(_loc4_.toString());
            _loc5_ = new Object();
            _loc5_.productId = _loc4_.itemId;
            _loc5_.title = _loc4_.title;
            _loc5_.description = _loc4_.description;
            _loc5_.price = _loc4_.price;
            _loc5_.localId = _loc4_.priceCurrencyCode;
            _loc5_.displayPrice = String(_loc5_.price) + " " + String(_loc5_.localId).substr(String(_loc5_.localId).length - 3,3);
            _loc5_.tsProduct = this.tsProducts[_loc4_.itemId];
            _loc5_.sort = uint(_loc5_.tsProduct.count);
            this.validProducts[_loc4_.itemId] = _loc5_;
            _loc3_++;
         }
         this.purchaseSO.data.previousValidProducts = this.validProducts;
         this.purchaseSO.flush();
      }
      
      public function doPurchase(param1:String) : Boolean
      {
         TsLogger.log("BMAndroidStoreKitManager :: doPurchase() - productID: " + param1);
         if(!this._initialized)
         {
            TsLogger.log("BMAndroidStoreKitManager :: doPurchase() - Not initialized!");
            return false;
         }
         if(this.validProducts[param1] == undefined)
         {
            TsLogger.log("BMAndroidStoreKitManager :: doPurchase() - Product does not exist!");
            MiscUtils.traceObject(this.validProducts,9);
            return false;
         }
         if(this.purchasePending)
         {
            TsLogger.log("BMAndroidStoreKitManager :: doPurchase() - Purchase already in progress!");
            return false;
         }
         if(this.hasPandingPurchase(param1))
         {
            this.processNextPendingPurchase();
            return true;
         }
         this.purchasePending = this.validProducts[param1];
         this.purchaseSO.data.purchasePending = this.purchasePending;
         this.purchaseSO.flush();
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_CREATEORDER_RESULT,this.onCreateOrderResult);
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_CREATEORDER_FAULT,this.onCreateOrderFault);
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_CREATINGORDER));
         this.androidPurchasingResponder.createOrder(this.purchasePending);
         return true;
      }
      
      protected function onCreateOrderResult(param1:DynamicEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onCreateOrderResult(" + param1.result + ") - ");
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_CREATEORDER_RESULT,this.onCreateOrderResult);
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_CREATEORDER_FAULT,this.onCreateOrderFault);
         if(param1.result != false)
         {
            this.purchasePending = param1.result;
            this.purchaseSO.data.purchasePending = this.purchasePending;
            this.purchaseSO.data.purchaseMap[this.purchasePending.productData.productId] = this.purchasePending;
            this.purchaseSO.flush();
         }
         if(param1.result != false && Boolean(this.purchasePending))
         {
            if(this.purchasePending.productData)
            {
               if(this.purchasePending.productData.productId)
               {
                  dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_ORDERCREATED));
                  AndroidIAB.androidIAB.purchaseItem(this.purchasePending.productData.productId,this.purchasePending.GUID);
                  return;
               }
            }
         }
         else if(param1.result == false && Boolean(this.purchasePending))
         {
            TsLogger.log("BMAndroidStoreKitManager :: onCreateOrderResult() - Create order failed, but have pending purchase.");
         }
         TsLogger.log("BMAndroidStoreKitManager :: onCreateOrderResult() - could not get product info from createOrder!");
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_ORDERCREATEFAULT));
         this.deletePending();
      }
      
      protected function onCreateOrderFault(param1:DynamicEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onCreateOrderFault() - ");
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_CREATEORDER_RESULT,this.onCreateOrderResult);
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_CREATEORDER_FAULT,this.onCreateOrderFault);
         MiscUtils.traceObject(param1.fault,9);
         this.deletePending();
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_ORDERCREATEFAULT));
      }
      
      private function deletePending() : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: deletePending()");
         this.purchaseSO.data.purchasePending = null;
         delete this.purchaseSO.data.purchasePending;
         this.purchaseSO.flush();
         this.purchasePending = null;
      }
      
      protected function onPurchaseSuccess(param1:AndroidBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onPurchaseSuccess()");
         this.traceStoreEvent(param1);
         if(this.purchasePending != null)
         {
            this.purchasePending.purchaseToken = param1.purchaseToken;
            this.purchasePending.itemId = param1.itemId;
            this.purchaseSO.data.purchasePending = this.purchasePending;
            this.purchaseSO.flush();
            this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_RESULT,this.onCompleteOrderResult);
            this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_FAULT,this.onCompleteOrderFault);
            this.androidPurchasingResponder.completeOrder(this.purchasePending,param1.jsonData);
         }
         else
         {
            TsLogger.log("BMAndroidStoreKitManager :: onPurchaseSuccess() - Verifying with no pending transaction.");
            this.purchasePending = new Object();
            this.purchasePending.purchaseToken = param1.purchaseToken;
            this.purchasePending.itemId = param1.itemId;
            this.purchasePending.productData = this.purchaseSO.data.previousValidProducts[param1.itemId];
            this.purchaseSO.data.purchasePending = this.purchasePending;
            this.purchaseSO.flush();
            this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_RESULT,this.onCompleteOrderResult);
            this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_FAULT,this.onCompleteOrderFault);
            this.androidPurchasingResponder.completeOrder(this.purchasePending,param1.purchaseToken);
         }
      }
      
      protected function onCompleteOrderResult(param1:DynamicEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onCompleteOrderResult()");
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_RESULT,this.onCompleteOrderResult);
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_FAULT,this.onCompleteOrderFault);
         var _loc2_:Object = param1.result;
         var _loc3_:Object = {
            "purchaseValue":_loc2_.productData.price,
            "trackingCost":Number(_loc2_.productData.tsProduct.cost),
            "trackingID":_loc2_.GUID,
            "trackingName":_loc2_.productData.title,
            "trackingSKU":_loc2_.productData.productId,
            "localizedCost":_loc2_.productData.price,
            "localizedCurrency":_loc2_.productData.localId
         };
         var _loc4_:AndroidStoreEvent = new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_SUCCEEDED,false,false,_loc3_);
         this.finishTransaction(this.purchasePending.itemId);
         dispatchEvent(_loc4_);
         this.processNextPendingPurchase();
      }
      
      protected function onCompleteOrderFault(param1:DynamicEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onCompleteOrderFault()");
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_RESULT,this.onCompleteOrderResult);
         this.androidPurchasingResponder.removeEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_FAULT,this.onCompleteOrderFault);
         MiscUtils.traceObject(param1.fault,9);
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_FAILED));
         this.loadPendingPurchases();
      }
      
      private function finishTransaction(param1:String) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: finishTransaction(" + param1 + ") - Calling manualFinishTransaction.");
         this.consumeItem(param1);
         this.purchaseSO.data.purchaseMap[param1] = null;
         this.purchaseSO.flush();
         this.deletePending();
      }
      
      private function consumeItem(param1:String) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: consumeItem " + param1);
         AndroidIAB.androidIAB.consumeItem(param1);
      }
      
      private function onConsumed(param1:AndroidBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onConsumed() - ");
         MiscUtils.traceObject(param1,999);
      }
      
      private function onConsumeFailed(param1:AndroidBillingErrorEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onConsumeFailed() - Error event:");
         TsLogger.log(param1.text);
      }
      
      protected function onPurchaseUserCancelled(param1:AndroidBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onPurchaseUserCancelled()");
         this.traceStoreEvent(param1);
         this.finishTransaction(param1.itemId);
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_CANCELLED));
         this.loadPendingPurchases();
      }
      
      protected function onTransactionsRestored(param1:AndroidBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onTransactionsRestored()");
         this.traceStoreEvent(param1);
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.TRANSACTIONS_RESTORED));
      }
      
      protected function onProductsFailed(param1:AndroidBillingErrorEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onProductsFailed()");
         MiscUtils.traceObject(param1,9);
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PRODUCT_DETAILS_FAILED));
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.STOREKIT_UNAVAILABLE));
      }
      
      protected function onPurchaseFailed(param1:AndroidBillingErrorEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onPurchaseFailed() - " + param1.errorID + " " + param1.text);
         this.deletePending();
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_FAILED));
      }
      
      protected function onTransactionRestoreFailed(param1:AndroidBillingErrorEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onTransactionRestoreFailed()");
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.TRANSACTION_RESTORE_FAILED));
      }
      
      public function getValidProducts() : Array
      {
         return this.validProducts;
      }
      
      private function traceStoreEvent(param1:AndroidBillingEvent) : void
      {
         MiscUtils.traceObject(param1,9);
      }
      
      private function doesNothing() : void
      {
      }
   }
}

