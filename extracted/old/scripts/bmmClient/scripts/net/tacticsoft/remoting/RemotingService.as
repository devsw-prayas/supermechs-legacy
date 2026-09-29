package net.tacticsoft.remoting
{
   import flash.events.*;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import net.tacticsoft.core.IDisposable;
   import net.tacticsoft.remoting.events.*;
   import net.tacticsoft.remoting.limiting.RemotingCallLimiter;
   import net.tacticsoft.utils.cache.ICacheStore;
   
   use namespace flash_proxy;
   
   public dynamic class RemotingService extends Proxy implements IEventDispatcher, IDisposable
   {
      
      public static var MaxTimeoutsBeforeHault:Number = 10;
      
      public static var NumTimeouts:int = -1;
      
      public static var Halted:Boolean = false;
      
      public var remotingConnection:RemotingConnection;
      
      public var service:String;
      
      private var eventDispatcher:EventDispatcher;
      
      private var remotingLimiter:RemotingCallLimiter;
      
      private var useLimiter:Boolean;
      
      public var remotingCache:ICacheStore;
      
      private var maxRetriesPerCall:int;
      
      private var callTimeout:int;
      
      private var authenticating:Boolean = false;
      
      public function RemotingService(param1:RemotingConnection, param2:String, param3:int, param4:int, param5:Boolean = true)
      {
         super();
         if(!param1)
         {
            throw new ArgumentError("No remoting connection was supplied.");
         }
         if(!param2 || param2 == "")
         {
            throw new ArgumentError("Service path cannot be null");
         }
         this.eventDispatcher = new EventDispatcher();
         this.remotingConnection = param1;
         this.service = param2;
         this.maxRetriesPerCall = param4;
         this.callTimeout = param3;
         this.useLimiter = param5;
         if(param5)
         {
            this.remotingLimiter = new RemotingCallLimiter();
         }
      }
      
      public function authenticate(param1:String, param2:String) : void
      {
         this.authenticating = true;
         this.remotingConnection.setCredentials(param1,param2);
         this.call("login",[],this.authenticationResult,this.authenticationFault,false);
      }
      
      public function authenticationResult(param1:Object) : void
      {
         this.authenticating = false;
         this.remotingConnection.clearCredentials();
         var _loc2_:CallEvent = new CallEvent(CallEvent.SERVICE_AUTHENTICATE_SUCCESS,false,false);
         _loc2_.connection = this.remotingConnection;
         _loc2_.service = this;
         _loc2_.rawData = param1.result;
         _loc2_.method = "login";
         this.dispatchEvent(_loc2_);
      }
      
      public function authenticationFault(param1:Object) : void
      {
         this.authenticating = false;
         this.remotingConnection.clearCredentials();
         var _loc2_:CallEvent = new CallEvent(CallEvent.SERVICE_AUTHENTICATE_ERROR,false,false);
         _loc2_.connection = this.remotingConnection;
         _loc2_.service = this;
         _loc2_.rawData = param1.fault;
         _loc2_.method = "login";
         this.dispatchEvent(_loc2_);
      }
      
      public function logout() : void
      {
         this.call("logout",[],this.logoutResult,this.logoutFault,false);
      }
      
      public function logoutResult(param1:Object) : void
      {
         var _loc2_:CallEvent = new CallEvent(CallEvent.SERVICE_LOGOUT_SUCCESS,false,false);
         _loc2_.connection = this.remotingConnection;
         _loc2_.service = this;
         _loc2_.rawData = param1.result;
         _loc2_.method = "logout";
         this.dispatchEvent(_loc2_);
      }
      
      public function logoutFault(param1:Object) : void
      {
         var _loc2_:CallEvent = new CallEvent(CallEvent.SERVICE_LOGOUT_ERROR,false,false);
         _loc2_.connection = this.remotingConnection;
         _loc2_.service = this;
         _loc2_.rawData = param1.fault;
         _loc2_.method = "logout";
         this.dispatchEvent(_loc2_);
      }
      
      private function call(param1:String, param2:Array, param3:Function, param4:Function, param5:Boolean) : void
      {
         var _loc7_:CallEvent = null;
         var _loc8_:String = null;
         if(RemotingService.NumTimeouts >= RemotingService.MaxTimeoutsBeforeHault)
         {
            _loc7_ = new CallEvent(CallEvent.SERVICE_HALTED,false,false);
            _loc7_.service = this;
            _loc7_.method = param1;
            _loc7_.args = param2;
            this.dispatchEvent(_loc7_);
            RemotingService.Halted = true;
            return;
         }
         RemotingService.Halted = false;
         if(this.useLimiter)
         {
            _loc8_ = this.remotingConnection.gateway + this.service + param1 + param2.toString() as String;
            if(!this.remotingLimiter.canExecute(_loc8_))
            {
               return;
            }
         }
         var _loc6_:RemotingCall = new RemotingCall(this,param1,param3,param4,param2,param5,this.callTimeout,this.maxRetriesPerCall);
         if(Boolean(this.remotingCache) && !_loc6_.remotingCache)
         {
            _loc6_.remotingCache = this.remotingCache;
         }
         if(this.useLimiter && !_loc6_.remotingLimiter)
         {
            _loc6_.remotingLimiter = this.remotingLimiter;
         }
         _loc6_.addEventListener(CallEvent.RETRY,this.onCallRetry);
         _loc6_.addEventListener(CallEvent.TIMEOUT,this.onCallTimedOut);
         _loc6_.addEventListener(CallEvent.REQUEST_SENT,this.onCallSent);
         _loc6_.execute();
      }
      
      private function onCallSent(param1:CallEvent) : void
      {
         var _loc2_:CallEvent = new CallEvent(CallEvent.REQUEST_SENT);
         _loc2_.service = this;
         _loc2_.args = param1.args;
         _loc2_.connection = param1.connection;
         _loc2_.faultCallback = param1.faultCallback;
         _loc2_.method = param1.method;
         _loc2_.rawData = param1.rawData;
         this.dispatchEvent(_loc2_);
      }
      
      private function onCallRetry(param1:CallEvent) : void
      {
         var _loc2_:CallEvent = new CallEvent(CallEvent.RETRY,false,false);
         _loc2_.method = param1.method;
         _loc2_.args = param1.args;
         _loc2_.service = param1.service;
         this.eventDispatcher.dispatchEvent(_loc2_);
      }
      
      private function onCallTimedOut(param1:CallEvent) : void
      {
         ++RemotingService.NumTimeouts;
         var _loc2_:CallEvent = new CallEvent(CallEvent.TIMEOUT,false,false);
         _loc2_.method = param1.method;
         _loc2_.args = param1.args;
         _loc2_.service = param1.service;
         this.eventDispatcher.dispatchEvent(_loc2_);
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : *
      {
         if(param1 == "apply")
         {
            if(rest[4] !== true)
            {
               rest[4] = false;
            }
            this.call(rest[0],rest[1],rest[2],rest[3],rest[4]);
         }
         else
         {
            this.call(param1.toString(),rest[0],rest[1],rest[2],rest[3]);
         }
         return null;
      }
      
      public function dispose() : void
      {
         this.callTimeout = 0;
         this.eventDispatcher = null;
         this.maxRetriesPerCall = 0;
         this.remotingCache.dispose();
         this.remotingCache = null;
         this.remotingConnection.dispose();
         this.remotingLimiter.dispose();
         this.remotingLimiter = null;
         this.service = null;
         this.useLimiter = false;
      }
      
      public function toString() : String
      {
         return "[RemotingService " + this.service + "]";
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         return false;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return null;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.eventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.eventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.eventDispatcher.willTrigger(param1);
      }
   }
}

