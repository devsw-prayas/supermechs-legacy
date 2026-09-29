package net.tacticsoft.responders
{
   import flash.events.EventDispatcher;
   import net.tacticsoft.events.DynamicEvent;
   import net.tacticsoft.remoting.RemotingManager;
   import net.tacticsoft.remoting.events.CallEvent;
   import net.tacticsoft.remoting.events.ConnectionEvent;
   import net.tacticsoft.remoting.events.FaultEvent;
   import net.tacticsoft.remoting.events.ResultEvent;
   
   public class AndroidPurchasingResponder extends EventDispatcher
   {
      
      public static var EVENT_GETPRODUCTLIST_RESULT:String = "AndroidPurchasingResponder.GETPRODUCTLIST_RESULT";
      
      public static var EVENT_GETPRODUCTLIST_FAULT:String = "AndroidPurchasingResponder.GETPRODUCTLIST_FAULT";
      
      public static var EVENT_CREATEORDER_RESULT:String = "AndroidPurchasingResponder.CREATEORDER_RESULT";
      
      public static var EVENT_CREATEORDER_FAULT:String = "AndroidPurchasingResponder.CREATEORDER_FAULT";
      
      public static var EVENT_CANCELORDER_RESULT:String = "AndroidPurchasingResponder.CANCELORDER_RESULT";
      
      public static var EVENT_CANCELORDER_FAULT:String = "AndroidPurchasingResponder.CANCELORDER_FAULT";
      
      public static var EVENT_FAILORDER_RESULT:String = "AndroidPurchasingResponder.FAILORDER_RESULT";
      
      public static var EVENT_FAILORDER_FAULT:String = "AndroidPurchasingResponder.FAILORDER_FAULT";
      
      public static var EVENT_COMPLETEORDER_RESULT:String = "AndroidPurchasingResponder.COMPLETEORDER_RESULT";
      
      public static var EVENT_COMPLETEORDER_FAULT:String = "AndroidPurchasingResponder.COMPLETEORDER_FAULT";
      
      private const ANDROIDPURCHASING_SERVICES:String = "net.battlegate.secure.AndroidPurchasing";
      
      private const SERVICES_PATH:String = "/services/amfphp/gateway.php";
      
      private const SERVICE_CALL_TIMEOUT:uint = 30000;
      
      private const SERVICE_MAX_RETRIES:uint = 0;
      
      private const SERVICE_USE_LIMITER:Boolean = false;
      
      private const SERVICE_USE_CACHE:Boolean = false;
      
      private const SERVICE_CACHE_EXPIRE_TIMEOUT:int = -1;
      
      private const METHOD_GETPRODUCTLIST:String = "getProductList";
      
      private const METHOD_CREATEORDER:String = "createOrder";
      
      private const METHOD_CANCELORDER:String = "cancelOrder";
      
      private const METHOD_FAILORDER:String = "failOrder";
      
      private const METHOD_COMPLETEORDER:String = "completeOrder";
      
      public var gateway:String = null;
      
      public var internalID:String = null;
      
      public function AndroidPurchasingResponder(param1:String)
      {
         super();
         this.internalID = "AndroidPurchasing";
         this.gateway = param1 + this.SERVICES_PATH;
         this.initialize();
      }
      
      private function initialize() : *
      {
         RemotingManager.gi().createService(this.internalID,this.gateway,this.ANDROIDPURCHASING_SERVICES,this.SERVICE_CALL_TIMEOUT,this.SERVICE_MAX_RETRIES,this.SERVICE_USE_LIMITER,this.SERVICE_USE_CACHE,this.SERVICE_CACHE_EXPIRE_TIMEOUT);
         RemotingManager.gi().addConnectionEventListener(ConnectionEvent.CONNECTED,this.gateway,this.onConnect);
         RemotingManager.gi().addConnectionEventListener(ConnectionEvent.DISCONNECT,this.gateway,this.onDisconnect);
         RemotingManager.gi().addConnectionEventListener(ConnectionEvent.FAILED,this.gateway,this.onConnectionFail);
         RemotingManager.gi().addConnectionEventListener(ConnectionEvent.FORMAT_ERROR,this.gateway,this.onConnectionFormatError);
         RemotingManager.gi().addConnectionEventListener(ConnectionEvent.SECURITY_ERROR,this.gateway,this.onConnectionSecurityError);
         RemotingManager.gi().addServiceEventListener(CallEvent.RETRY,this.internalID,this.onRetry);
         RemotingManager.gi().addServiceEventListener(CallEvent.TIMEOUT,this.internalID,this.onTimeout);
         RemotingManager.gi().addServiceEventListener(CallEvent.LIMITER_STOPPED_CALL,this.internalID,this.onCallLimited);
         RemotingManager.gi().addServiceEventListener(CallEvent.SERVICE_HALTED,this.internalID,this.onServicesHalted);
         RemotingManager.gi().addServiceEventListener(CallEvent.REQUEST_SENT,this.internalID,this.onRequestSent);
         RemotingManager.gi().addServiceEventListener(CallEvent.FAULT,this.internalID,this.onFault);
         RemotingManager.gi().addServiceEventListener(CallEvent.RESULT,this.internalID,this.onResult);
      }
      
      public function completeOrder(param1:*, param2:*) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: completeOrder()");
         RemotingManager.gi().call(this.internalID,this.METHOD_COMPLETEORDER,[param1,param2],this.onCompleteOrderResult,this.onCompleteOrderFault);
      }
      
      public function onCompleteOrderResult(param1:ResultEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onCompleteOrderResult()");
         var _loc2_:DynamicEvent = new DynamicEvent(EVENT_COMPLETEORDER_RESULT);
         _loc2_.result = param1.result;
         dispatchEvent(_loc2_);
      }
      
      public function onCompleteOrderFault(param1:FaultEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onCompleteOrderFault()");
         var _loc2_:DynamicEvent = new DynamicEvent(EVENT_COMPLETEORDER_FAULT);
         _loc2_.fault = param1.fault;
         dispatchEvent(_loc2_);
      }
      
      public function getProductList() : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: getProductList()");
         RemotingManager.gi().call(this.internalID,this.METHOD_GETPRODUCTLIST,[],this.onGetProductListResult,this.onGetProductListFault);
      }
      
      public function onGetProductListResult(param1:ResultEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onGetProductListResult()");
         var _loc2_:DynamicEvent = new DynamicEvent(EVENT_GETPRODUCTLIST_RESULT);
         _loc2_.result = param1.result;
         dispatchEvent(_loc2_);
      }
      
      public function onGetProductListFault(param1:FaultEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onGetProductListFault()");
         var _loc2_:DynamicEvent = new DynamicEvent(EVENT_GETPRODUCTLIST_FAULT);
         _loc2_.fault = param1.fault;
         dispatchEvent(_loc2_);
      }
      
      public function createOrder(param1:*) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: createOrder()");
         RemotingManager.gi().call(this.internalID,this.METHOD_CREATEORDER,[param1],this.onCreateOrderResult,this.onCreateOrderFault);
      }
      
      public function onCreateOrderResult(param1:ResultEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onCreateOrderResult()");
         var _loc2_:DynamicEvent = new DynamicEvent(EVENT_CREATEORDER_RESULT);
         _loc2_.result = param1.result;
         dispatchEvent(_loc2_);
      }
      
      public function onCreateOrderFault(param1:FaultEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onCreateOrderFault()");
         var _loc2_:DynamicEvent = new DynamicEvent(EVENT_CREATEORDER_FAULT);
         _loc2_.fault = param1.fault;
         dispatchEvent(_loc2_);
      }
      
      private function onConnect(param1:ConnectionEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onConnect()");
      }
      
      private function onDisconnect(param1:ConnectionEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onDisconnect() -- Service disconnected!");
      }
      
      private function onConnectionFail(param1:ConnectionEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onConnectionFail() -- Service connection failure!");
      }
      
      private function onConnectionFormatError(param1:ConnectionEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onConnectionFormatError() -- AMF format error!");
      }
      
      private function onConnectionSecurityError(param1:ConnectionEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onConnectionSecurityError() -- Security error!");
      }
      
      private function onRetry(param1:CallEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onRetry() -- Retrying - service: " + param1.service + " method: " + param1.method);
      }
      
      private function onTimeout(param1:CallEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onTimeout() -- Timeout! - service[" + this.internalID + "]: " + param1.service + " method: " + param1.method);
      }
      
      private function onCallLimited(param1:CallEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onCallLimited() -- Call stopped by limiter! - service: " + param1.service + " method: " + param1.method);
      }
      
      private function onServicesHalted(param1:CallEvent) : *
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onServicesHalted() -- Service halted! - service: " + param1.service + " method: " + param1.method);
      }
      
      private function onRequestSent(param1:CallEvent) : void
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onRequestSent() -- service: " + param1.service + " method: " + param1.method);
      }
      
      private function onFault(param1:CallEvent) : void
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onFault() -- service: " + param1.service + " method: " + param1.method);
      }
      
      private function onResult(param1:CallEvent) : void
      {
         TsLogger.log("AndroidPurchasingResponder[" + this.internalID + "] :: onResult() -- service: " + param1.service + " method: " + param1.method);
      }
   }
}

