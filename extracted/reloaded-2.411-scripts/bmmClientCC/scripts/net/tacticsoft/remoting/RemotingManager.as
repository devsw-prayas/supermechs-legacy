package net.tacticsoft.remoting
{
   import flash.utils.Dictionary;
   import net.tacticsoft.core.IDisposable;
   import net.tacticsoft.events.EventDispatcherProxy;
   import net.tacticsoft.remoting.events.CallEvent;
   import net.tacticsoft.remoting.events.ConnectionEvent;
   import net.tacticsoft.remoting.events.IRemotingEventsDelegate;
   import net.tacticsoft.utils.Assert;
   import net.tacticsoft.utils.cache.Cache;
   
   public class RemotingManager implements IDisposable
   {
      
      private static var inst:RemotingManager;
      
      public static var DefaultObjectEncoding:int = 3;
      
      private var edp:EventDispatcherProxy;
      
      private var services:Dictionary;
      
      public var remotingEventsDelegate:IRemotingEventsDelegate;
      
      private var connections:Dictionary;
      
      private var _debugLastMsgData:Object = new Object();
      
      public function RemotingManager()
      {
         super();
         if(RemotingManager.inst)
         {
            throw new Error("RemotingManager is a singleton, see RemotingManager.getInstance()");
         }
         this.edp = new EventDispatcherProxy();
         this.services = new Dictionary();
         this.connections = new Dictionary();
      }
      
      public static function getInstance() : RemotingManager
      {
         if(inst == null)
         {
            inst = new RemotingManager();
         }
         return inst;
      }
      
      public static function gi() : RemotingManager
      {
         return getInstance();
      }
      
      public function createService(param1:String, param2:String, param3:String, param4:int = 9000, param5:int = 3, param6:Boolean = true, param7:Boolean = false, param8:int = -1) : void
      {
         var _loc9_:RemotingConnection = null;
         TsLogger.log("RemotingManager :: createService(id: " + param1 + " gateway: " + param2 + ", service: " + param3 + ")");
         Assert.NotNull(param1,"Parameter id cannot be null");
         Assert.NotNull(param2,"Parameter gateway cannot be null");
         Assert.NotNull(param3,"Parameter service cannot be null");
         Assert.NotNull(param4,"Parameter calTimeout cannot be null");
         Assert.NotNull(param5,"Parameter maxRetries cannot be null");
         Assert.NotNull(param6,"Parameter useLimiter cannot be null");
         Assert.NotNull(param7,"Parameter useCache cannot be null");
         Assert.NotNull(param8,"Parameter cacheExpireTimeout cannot be null");
         if(this.connections[param2])
         {
            _loc9_ = this.connections[param2];
         }
         else
         {
            _loc9_ = new RemotingConnection(param2,RemotingManager.DefaultObjectEncoding);
            _loc9_.addEventListener(ConnectionEvent.CONNECTED,this.onConnected);
            _loc9_.addEventListener(ConnectionEvent.DISCONNECT,this.onDisconnect);
            _loc9_.addEventListener(ConnectionEvent.FAILED,this.onFail);
            _loc9_.addEventListener(ConnectionEvent.FORMAT_ERROR,this.onFormatError);
            _loc9_.addEventListener(ConnectionEvent.SECURITY_ERROR,this.onSecurityError);
            this.connections[param2] = _loc9_;
         }
         var _loc10_:RemotingService = new RemotingService(_loc9_,param3,param4,param5,param6);
         _loc10_.addEventListener(CallEvent.LIMITER_STOPPED_CALL,this.onLimited);
         _loc10_.addEventListener(CallEvent.REQUEST_SENT,this.onRequestSent);
         _loc10_.addEventListener(CallEvent.RETRY,this.onRetry);
         _loc10_.addEventListener(CallEvent.SERVICE_HALTED,this.onServicesHalted);
         _loc10_.addEventListener(CallEvent.TIMEOUT,this.onTimeout);
         _loc10_.addEventListener(CallEvent.SERVICE_AUTHENTICATE_SUCCESS,this.onAuthenticateSuccess);
         _loc10_.addEventListener(CallEvent.SERVICE_AUTHENTICATE_ERROR,this.onAuthenticateError);
         _loc10_.addEventListener(CallEvent.SERVICE_LOGOUT_SUCCESS,this.onLogoutSuccess);
         _loc10_.addEventListener(CallEvent.SERVICE_LOGOUT_ERROR,this.onLogoutError);
         if(param7)
         {
            _loc10_.remotingCache = new Cache(param8);
         }
         this.services[param1] = _loc10_;
      }
      
      public function getService(param1:String) : RemotingService
      {
         TsLogger.log("RemotingManager :: getService(" + param1 + ")");
         Assert.NotNull(param1,"Parameter id cannot be null");
         Assert.NotNull(this.services[param1],"Service " + param1 + "not available");
         return this.services[param1];
      }
      
      public function call(param1:String, param2:String, param3:Array, param4:Function, param5:Function, param6:Boolean = false) : void
      {
         TsLogger.log("RemotingManager :: call(id: " + param1 + ", serviceMethod: " + param2 + ") - args:");
         this._debugLastMsgData.id = param1;
         this._debugLastMsgData.serviceMethod = param2;
         this._debugLastMsgData.args = param3;
         var _loc7_:RemotingService = this.services[param1];
         _loc7_.apply(param2,param3,param4,param5,param6);
      }
      
      public function disposeService(param1:String) : void
      {
         var rs:RemotingService = null;
         var gateway:String = null;
         var count:int = 0;
         var ser:RemotingService = null;
         var connection:RemotingConnection = null;
         var id:String = param1;
         TsLogger.log("RemotingManager :: disposeService() " + id);
         if(!id)
         {
            return;
         }
         try
         {
            rs = this.services[id];
            gateway = rs.remotingConnection.gateway;
            count = 0;
            for each(ser in this.services)
            {
               if(ser.remotingConnection.gateway == gateway)
               {
                  count++;
               }
            }
            if(count <= 1)
            {
               connection = this.connections[gateway];
               connection.removeEventListener(ConnectionEvent.CONNECTED,this.onConnected);
               connection.removeEventListener(ConnectionEvent.DISCONNECT,this.onDisconnect);
               connection.removeEventListener(ConnectionEvent.FAILED,this.onFail);
               connection.removeEventListener(ConnectionEvent.FORMAT_ERROR,this.onFormatError);
               connection.removeEventListener(ConnectionEvent.SECURITY_ERROR,this.onSecurityError);
               rs.remotingConnection.dispose();
               this.connections[gateway] = null;
            }
         }
         catch(e:Error)
         {
            TsLogger.log("RemotingManager :: exseption " + e.message + " \n" + e.getStackTrace());
         }
         this.services[id] = null;
      }
      
      public function addConnectionEventListener(param1:String, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false) : void
      {
         var _loc7_:String = param1 + param2;
         this.edp.addEventListener(_loc7_,param3,param4,param5,param6);
      }
      
      public function addServiceEventListener(param1:String, param2:String, param3:Function, param4:String = null, param5:Boolean = false, param6:int = 0, param7:Boolean = false) : void
      {
         var _loc8_:RemotingService = RemotingService(this.services[param2]);
         var _loc9_:String = param1 + _loc8_.remotingConnection.gateway + _loc8_.service;
         if(param4)
         {
            _loc9_ += param4;
         }
         this.edp.addEventListener(_loc9_,param3,param5,param6,param7);
      }
      
      public function removeConnectionEventListener(param1:String, param2:String, param3:Function) : void
      {
         this.edp.removeEventListener(param1 + param2,param3);
      }
      
      public function removeServiceEventListener(param1:String, param2:String, param3:Function, param4:String = null) : void
      {
         var _loc5_:RemotingService = RemotingService(this.services[param2]);
         var _loc6_:String = param1 + _loc5_.remotingConnection.gateway + _loc5_.service;
         if(param4)
         {
            _loc6_ += param4;
         }
         this.edp.removeEventListener(_loc6_,param3);
      }
      
      public function dispose() : void
      {
         TsLogger.log("RemotingManager :: dispose()");
         this.services = new Dictionary();
         this.connections = new Dictionary();
         this.edp = null;
      }
      
      private function getExtendedTypeFromCallEvent(param1:CallEvent) : String
      {
         var _loc4_:String = null;
         var _loc2_:RemotingService = param1.service;
         var _loc3_:String = param1.type + _loc2_.remotingConnection.gateway + _loc2_.service;
         if(param1.method)
         {
            _loc4_ = _loc3_ + param1.method;
            if(this.edp.hasEventListener(_loc4_))
            {
               _loc3_ += param1.method;
            }
         }
         return _loc3_;
      }
      
      private function createExtendedCallEvent(param1:CallEvent) : CallEvent
      {
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         var _loc3_:CallEvent = new CallEvent(_loc2_,false,false);
         _loc3_.args = param1.args;
         _loc3_.connection = param1.connection;
         _loc3_.faultCallback = param1.faultCallback;
         _loc3_.resultCallback = param1.resultCallback;
         _loc3_.method = param1.method;
         _loc3_.rawData = param1.rawData;
         _loc3_.service = param1.service;
         return _loc3_;
      }
      
      private function getExtendedTypeFromConnectionEvent(param1:ConnectionEvent) : String
      {
         var _loc2_:RemotingConnection = param1.target as RemotingConnection;
         return param1.type + _loc2_.gateway;
      }
      
      private function createdExtendedConnectionEvent(param1:ConnectionEvent) : ConnectionEvent
      {
         var _loc2_:String = this.getExtendedTypeFromConnectionEvent(param1);
         var _loc3_:ConnectionEvent = new ConnectionEvent(_loc2_,false,false);
         _loc3_.message = param1.message;
         return _loc3_;
      }
      
      private function onConnected(param1:ConnectionEvent) : void
      {
         TsLogger.log("RemotingManager :: onConnected()");
         var _loc2_:String = this.getExtendedTypeFromConnectionEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createdExtendedConnectionEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onConnect(param1);
         }
      }
      
      private function onDisconnect(param1:ConnectionEvent) : void
      {
         TsLogger.log("RemotingManager :: onDisconnect()");
         var _loc2_:String = this.getExtendedTypeFromConnectionEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createdExtendedConnectionEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onConnect(param1);
         }
      }
      
      private function onFail(param1:ConnectionEvent) : void
      {
         TsLogger.log("RemotingManager :: onFail()");
         var _loc2_:String = this.getExtendedTypeFromConnectionEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createdExtendedConnectionEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onConnectionFail(param1);
         }
      }
      
      private function onFormatError(param1:ConnectionEvent) : void
      {
         TsLogger.log("RemotingManager :: onFormatError() - " + param1.target);
         var _loc2_:String = this.getExtendedTypeFromConnectionEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createdExtendedConnectionEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onConnectionFormatError(param1);
         }
      }
      
      private function onSecurityError(param1:ConnectionEvent) : void
      {
         TsLogger.log("RemotingManager :: onSecurityError()");
         var _loc2_:String = this.getExtendedTypeFromConnectionEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createdExtendedConnectionEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onConnectionSecurityError(param1);
         }
      }
      
      private function onLimited(param1:CallEvent) : void
      {
         TsLogger.log("RemotingManager :: onLimited()");
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createExtendedCallEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onCallLimited(param1);
         }
      }
      
      private function onRequestSent(param1:CallEvent) : void
      {
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createExtendedCallEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onRequestSent(param1);
         }
      }
      
      private function onRetry(param1:CallEvent) : void
      {
         TsLogger.log("RemotingManager :: onRetry()");
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createExtendedCallEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onRetry(param1);
         }
      }
      
      private function onServicesHalted(param1:CallEvent) : void
      {
         TsLogger.log("RemotingManager :: onServicesHalted()");
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createExtendedCallEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onServicesHalted();
         }
      }
      
      private function onTimeout(param1:CallEvent) : void
      {
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         TsLogger.log("RemotingManager :: onTimeout() " + _loc2_);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createExtendedCallEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onTimeout(param1);
         }
      }
      
      private function onAuthenticateSuccess(param1:CallEvent) : void
      {
         TsLogger.log("RemotingManager :: onAuthenticateSuccess()");
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createExtendedCallEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onTimeout(param1);
         }
      }
      
      private function onAuthenticateError(param1:CallEvent) : void
      {
         TsLogger.log("RemotingManager :: onAuthenticateError()");
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createExtendedCallEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onTimeout(param1);
         }
      }
      
      private function onLogoutSuccess(param1:CallEvent) : void
      {
         TsLogger.log("RemotingManager :: onLogoutSuccess()");
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createExtendedCallEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onTimeout(param1);
         }
      }
      
      private function onLogoutError(param1:CallEvent) : void
      {
         TsLogger.log("RemotingManager :: onLogoutError()");
         var _loc2_:String = this.getExtendedTypeFromCallEvent(param1);
         if(this.edp.hasEventListener(_loc2_))
         {
            this.edp.dispatchEvent(this.createExtendedCallEvent(param1));
         }
         else if(this.remotingEventsDelegate)
         {
            this.remotingEventsDelegate.onTimeout(param1);
         }
      }
      
      public function get debugLastMsgData() : Object
      {
         return this._debugLastMsgData;
      }
   }
}

