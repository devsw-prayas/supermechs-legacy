package net.battleMechsMulti.managers
{
   import com.distriqt.extension.inappbilling.BillingService;
   import com.distriqt.extension.inappbilling.ErrorCodes;
   import com.distriqt.extension.inappbilling.InAppBilling;
   import com.distriqt.extension.inappbilling.Product;
   import com.distriqt.extension.inappbilling.Purchase;
   import com.distriqt.extension.inappbilling.PurchaseRequest;
   import com.distriqt.extension.inappbilling.events.InAppBillingEvent;
   import com.distriqt.extension.inappbilling.events.PurchaseEvent;
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
      
      private var purchasePending:Object;
      
      private var validProducts:Array = [];
      
      private var tsProducts:Array = [];
      
      private var purchaseSO:SharedObject;
      
      private var androidPurchasingResponder:AndroidPurchasingResponder;
      
      public var productsAvailable:Boolean = false;
      
      public var restoreTransactionsNeeded:Boolean = false;
      
      private var _pendingPurchases:Vector.<Purchase>;
      
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
            if(!InAppBilling.isSupported)
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
               InAppBilling.service.addEventListener(InAppBillingEvent.SETUP_SUCCESS,this.onSetupComplete);
               InAppBilling.service.addEventListener(InAppBillingEvent.SETUP_FAILURE,this.onSetupFailure);
               InAppBilling.service.addEventListener(InAppBillingEvent.PRODUCTS_LOADED,this.onItemDetails);
               InAppBilling.service.addEventListener(InAppBillingEvent.PRODUCTS_FAILED,this.onItemDetailsFailed);
               InAppBilling.service.addEventListener(PurchaseEvent.GET_PURCHASES_COMPLETE,this.onInventoryLoaded);
               InAppBilling.service.addEventListener(PurchaseEvent.GET_PURCHASES_FAILED,this.onInventoryFailed);
               InAppBilling.service.addEventListener(PurchaseEvent.PURCHASES_UPDATED,this.onPurchasesUpdated);
               InAppBilling.service.addEventListener(PurchaseEvent.PURCHASE_FAILED,this.onPurchaseFailed);
               InAppBilling.service.addEventListener(InAppBillingEvent.FINISH_SUCCESS,this.finishPurchase_successHandler);
               InAppBilling.service.addEventListener(InAppBillingEvent.FINISH_FAILED,this.finishPurchase_failedHandler);
               InAppBilling.service.addEventListener(InAppBillingEvent.CONSUME_SUCCESS,this.onConsumed);
               InAppBilling.service.addEventListener(InAppBillingEvent.CONSUME_FAILED,this.onConsumeFailed);
               InAppBilling.service.setup(new BillingService().setGooglePlayPublicKey(PUBLIC_KEY));
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
      
      private function get useEXOrderFunctions() : Boolean
      {
         return BMDataManager.getInstance().getGeneralSetting("androidPurchaseEX",0) == 1;
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
      
      private function onItemDetails(param1:InAppBillingEvent) : void
      {
         var _loc2_:Product = null;
         var _loc3_:Object = null;
         TsLogger.log("BMAndroidStoreKitManager :: onItemDetails() - ");
         for each(_loc2_ in param1.data)
         {
            _loc3_ = {};
            _loc3_.productId = _loc2_.id;
            _loc3_.title = _loc2_.title.replace(" (Super Mechs)","");
            _loc3_.description = _loc2_.description;
            _loc3_.price = Number(_loc2_.price).toPrecision(6);
            _loc3_.localId = _loc2_.currencyCode;
            _loc3_.localizedPrice = _loc2_.price;
            _loc3_.displayPrice = _loc2_.price + " " + _loc2_.currencyCode;
            _loc3_.tsProduct = this.tsProducts[_loc2_.id];
            _loc3_.sort = uint(_loc3_.tsProduct.count);
            this.validProducts[_loc2_.id] = _loc3_;
         }
         this.productsAvailable = true;
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PRODUCT_DETAILS_LOADED));
         this.purchaseSO.data.previousValidProducts = this.validProducts;
         this.purchaseSO.flush();
         this.loadPendingPurchases();
      }
      
      private function onItemDetailsFailed(param1:InAppBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onItemDetailsFailed() - Error event:");
         TsLogger.log("[" + param1.errorCode + "] " + param1.message);
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PRODUCT_DETAILS_FAILED));
      }
      
      public function loadPendingPurchases() : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: loadPlayerInventory");
         InAppBilling.service.getPurchases();
      }
      
      private function onInventoryFailed(param1:PurchaseEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onInventoryFailed() - Error event:");
         TsLogger.log("[" + param1.errorCode + "] " + param1.message);
      }
      
      private function onInventoryLoaded(param1:PurchaseEvent) : void
      {
         var _loc2_:Purchase = null;
         TsLogger.log("BMAndroidStoreKitManager :: onInventoryLoaded");
         this._pendingPurchases = param1.data;
         if(this._pendingPurchases != null && this._pendingPurchases.length > 0)
         {
            for each(_loc2_ in this._pendingPurchases)
            {
               BMDataManager.getInstance().trackEvent(BMDataManager.ANALYTICS_PRIORITY_HIGHEST,"Monetization","PendingPurchaseLoaded",_loc2_.productId,_loc2_.transactionDate.time,_loc2_.transactionId,_loc2_.developerPayload);
               this.consumeItem(_loc2_);
            }
         }
         if(this.hasPendingPurchases)
         {
            dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.NEW_PENDING_PURCHASES));
         }
      }
      
      public function get hasPendingPurchases() : *
      {
         return this._pendingPurchases != null && this._pendingPurchases.length > 0;
      }
      
      public function hasPendingPurchase(param1:String) : Boolean
      {
         var _loc2_:Purchase = null;
         if(this._pendingPurchases == null)
         {
            return false;
         }
         for each(_loc2_ in InAppBilling.service.getPendingPurchases())
         {
            if(_loc2_.productId == param1)
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
         var _loc1_:Purchase = this._pendingPurchases.shift();
         this.purchasePending = {};
         this.purchasePending.purchase = _loc1_;
         this.purchasePending.purchaseToken = _loc1_.transactionId;
         this.purchasePending.itemId = _loc1_.productId;
         this.purchaseSO.data.purchasePending = this.purchasePending;
         this.purchaseSO.flush();
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_RESULT,this.onCompleteOrderResult);
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_FAULT,this.onCompleteOrderFault);
         this.completeOrderImpl(null,_loc1_.originalMessage);
      }
      
      private function completeOrderImpl(param1:*, param2:*) : *
      {
         if(this.useEXOrderFunctions)
         {
            this.androidPurchasingResponder.completeOrderEX(BMDataManager.getInstance().userID,param1,param2);
         }
         else
         {
            this.androidPurchasingResponder.completeOrder(param1,param2);
         }
      }
      
      public function initializeProducts(param1:InAppBillingEvent = null) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: initializeProducts() - ");
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_GETPRODUCTLIST_RESULT,this.onGetProductListResult);
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_GETPRODUCTLIST_FAULT,this.onGetProductListFault);
         this.androidPurchasingResponder.getProductList();
      }
      
      private function onSetupComplete(param1:InAppBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onSetupComplete() - ");
         this.initializeProducts(null);
      }
      
      private function onSetupFailure(param1:InAppBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onSetupFailure() - ");
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
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            _loc4_ = String(_loc3_["android_id"]);
            _loc2_.push(_loc4_);
            this.tsProducts[_loc4_] = _loc3_;
         }
         if(!this.testMode && Boolean(InAppBilling.isSupported))
         {
            InAppBilling.service.getProducts(_loc2_);
         }
         else
         {
            TsLogger.log("BMAndroidStoreKitManager :: loadProductDetails() - Manually adding products.");
            this.validProducts["com.supermechs.superapp.1"] = {};
            this.validProducts["com.supermechs.superapp.1"].productId = "com.supermechs.superapp.1";
            this.validProducts["com.supermechs.superapp.1"].title = "200 Tokens";
            this.validProducts["com.supermechs.superapp.1"].description = "200 Tokens for use in game.";
            this.validProducts["com.supermechs.superapp.1"].localizedPrice = "4.99";
            this.validProducts["com.supermechs.superapp.1"].tsProduct = this.tsProducts["com.supermechs.superapp.1"];
            this.validProducts["com.supermechs.superapp.1"].sort = uint(this.tsProducts["com.supermechs.superapp.1"].count);
            this.validProducts["com.supermechs.superapp.2"] = {};
            this.validProducts["com.supermechs.superapp.2"].productId = "com.supermechs.superapp.2";
            this.validProducts["com.supermechs.superapp.2"].title = "400 Tokens";
            this.validProducts["com.supermechs.superapp.2"].description = "400 Tokens for use in game.";
            this.validProducts["com.supermechs.superapp.2"].localizedPrice = "7.99";
            this.validProducts["com.supermechs.superapp.2"].tsProduct = this.tsProducts["com.supermechs.superapp.2"];
            this.validProducts["com.supermechs.superapp.2"].sort = uint(this.tsProducts["com.supermechs.superapp.2"].count);
            this.validProducts["com.supermechs.superapp.3"] = {};
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
         if(this.hasPendingPurchase(param1))
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
         if(this.useEXOrderFunctions)
         {
            this.androidPurchasingResponder.createOrderEX(BMDataManager.getInstance().userID,this.purchasePending);
         }
         else
         {
            this.androidPurchasingResponder.createOrder(this.purchasePending);
         }
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
                  InAppBilling.service.makePurchase(new PurchaseRequest(this.purchasePending.productData.productId).setApplicationUsername(this.purchasePending.GUID));
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
         dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_ORDERCREATEFAULT,false,false,param1.fault));
      }
      
      private function deletePending() : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: deletePending()");
         this.purchaseSO.data.purchasePending = null;
         delete this.purchaseSO.data.purchasePending;
         this.purchaseSO.flush();
         this.purchasePending = null;
      }
      
      protected function addPurchaseToInventory(param1:Purchase) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: addPurchaseToInventory()");
         if(this.purchasePending == null)
         {
            TsLogger.log("BMAndroidStoreKitManager :: onPurchaseSuccess() - Verifying with no pending transaction.");
            this.purchasePending = {};
            this.purchasePending.productData = this.purchaseSO.data.previousValidProducts[param1.productId];
         }
         this.purchasePending.purchase = param1;
         this.purchasePending.purchaseToken = param1.transactionId;
         this.purchasePending.itemId = param1.productId;
         this.purchaseSO.data.purchasePending = this.purchasePending;
         this.purchaseSO.flush();
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_RESULT,this.onCompleteOrderResult);
         this.androidPurchasingResponder.addEventListener(AndroidPurchasingResponder.EVENT_COMPLETEORDER_FAULT,this.onCompleteOrderFault);
         this.completeOrderImpl(this.purchasePending,param1.originalMessage);
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
         this.finishTransaction(this.purchasePending.purchase);
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
      
      private function finishTransaction(param1:Purchase) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: finishTransaction(" + param1.productId + ") - Calling manualFinishTransaction.");
         InAppBilling.service.finishPurchase(param1);
         this.purchaseSO.data.purchaseMap[param1.productId] = null;
         this.purchaseSO.flush();
         this.deletePending();
      }
      
      private function finishPurchase_successHandler(param1:InAppBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: finishPurchase_successHandler()");
         this.consumeItem(param1.data[0]);
      }
      
      private function finishPurchase_failedHandler(param1:InAppBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: finishPurchase_failedHandler() - Error event:");
         TsLogger.log("[" + param1.errorCode + "] " + param1.message);
      }
      
      private function consumeItem(param1:Purchase) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: consumeItem " + param1.productId);
         InAppBilling.service.consumePurchase(param1);
      }
      
      private function onConsumed(param1:InAppBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onConsumed() - ");
         MiscUtils.traceObject(param1,999);
      }
      
      private function onConsumeFailed(param1:InAppBillingEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onConsumeFailed() - Error event:");
         TsLogger.log("[" + param1.errorCode + "] " + param1.message);
      }
      
      protected function onPurchasesUpdated(param1:PurchaseEvent) : void
      {
         var _loc2_:Purchase = null;
         this.traceStoreEvent(param1);
         for each(_loc2_ in param1.data)
         {
            switch(_loc2_.transactionState)
            {
               case Purchase.STATE_PURCHASING:
               case Purchase.STATE_DEFERRED:
                  break;
               case Purchase.STATE_PURCHASED:
                  this.addPurchaseToInventory(_loc2_);
                  break;
               case Purchase.STATE_FAILED:
               case Purchase.STATE_REFUNDED:
               case Purchase.STATE_RESTORED:
               case Purchase.STATE_REMOVED:
               case Purchase.STATE_NOTALLOWED:
                  this.finishTransaction(_loc2_);
                  break;
               case Purchase.STATE_CANCELLED:
                  this.finishTransaction(_loc2_);
                  dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_CANCELLED));
            }
         }
      }
      
      protected function onPurchaseFailed(param1:PurchaseEvent) : void
      {
         TsLogger.log("BMAndroidStoreKitManager :: onPurchaseFailed() - " + param1.errorCode);
         this.deletePending();
         if(Boolean(param1.data) && param1.data.length > 0)
         {
            this.finishTransaction(param1.data[0]);
         }
         if(param1.errorCode == ErrorCodes.ITEM_ALREADY_OWNED)
         {
            this.loadPendingPurchases();
         }
         else
         {
            dispatchEvent(new AndroidStoreEvent(AndroidStoreEvent.PURCHASE_FAILED));
         }
      }
      
      public function getValidProducts() : Array
      {
         return this.validProducts;
      }
      
      private function traceStoreEvent(param1:*) : void
      {
         MiscUtils.traceObject(param1,9);
      }
   }
}

