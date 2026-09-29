package net.tacticsoft.responders
{
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.tacticsoft.remoting.RemotingManager;
   import net.tacticsoft.remoting.events.CallEvent;
   import net.tacticsoft.remoting.events.ConnectionEvent;
   import net.tacticsoft.remoting.events.FaultEvent;
   import net.tacticsoft.remoting.events.ResultEvent;
   import net.tacticsoft.remoting.events.TimeoutEvent;
   import net.tacticsoft.responders.events.ExternalLoginConflictEvent;
   import net.tacticsoft.responders.events.ExternalSessionEvents;
   import net.tacticsoft.utils.MiscUtils;
   
   public class BMMSessionResponder extends EventDispatcher
   {
      
      public static var GOTUSER_EVENT:String = "GOTUSER_EVENT";
      
      public static var AUTH_FAULT:String = "AUTH_FAULT";
      
      public static var AUTH_FINAL_FAULT:String = "AUTH_FINAL_FAULT";
      
      public static var AUTH_SUCCESS:String = "AUTH_SUCCESS";
      
      public static var SESSION_PONG:String = "SESSION_PONG";
      
      public static const KONG_USER_EXISTS_FAULT:String = "BMMSessionResponder.kongUserExistsFault";
      
      public static const KONG_USER_EXISTS_TRUE:String = "BMMSessionResponder.kongUserExistsTrue";
      
      public static const KONG_USER_EXISTS_FALSE:String = "BMMSessionResponder.kongUserExistsFalse";
      
      private const SESSION_SERVICES:String = "net.battlegate.secure.SessionControl";
      
      private const SERVICES_PATH:String = "/services/amfphp/gateway.php";
      
      private const SERVICE_CALL_TIMEOUT:uint = 30000;
      
      private const SERVICE_MAX_RETRIES:uint = 1;
      
      private const SERVICE_USE_LIMITER:Boolean = true;
      
      private const SERVICE_USE_CACHE:Boolean = false;
      
      private const SERVICE_CACHE_EXPIRE_TIMEOUT:int = -1;
      
      private const METHOD_AUTHENTICATE:String = "authenticate";
      
      private const METHOD_GETUSERDATA:String = "getUserData";
      
      private const METHOD_SESSIONPING:String = "sessionPing";
      
      private const METHOD_REGISTER:String = "register";
      
      private const METHOD_LOGIN:String = "login";
      
      private const METHOD_KONG_USER_EXISTS:String = "kongUserExists";
      
      private const METHOD_EXTERNAL_LOGIN:String = "externalLogin";
      
      private const METHOD_EXTERNAL_LOGOUT:String = "externalLogout";
      
      private const METHOD_MERGE_ACCOUNTS:String = "mergeAccounts";
      
      private const MAX_TIMEOUTS:uint = 1;
      
      private var authRetryCount:uint = 0;
      
      private var timeoutCount:uint = 0;
      
      public var internalID:String = null;
      
      public var gateway:String = null;
      
      public var sessionHash:String = null;
      
      public var connected:Boolean = false;
      
      public var authenticated:Boolean = false;
      
      public var primarySession:Boolean = false;
      
      public var connecting:Boolean = true;
      
      public var connectable:Boolean = true;
      
      public var sessionName:String = null;
      
      public var sessionID:String = null;
      
      private var _userData:Object;
      
      public var sessionData:Object;
      
      private var name:String = null;
      
      private var password:String = null;
      
      public var serviceURL:String = null;
      
      public var lastLoginError:String = null;
      
      private var isServiceCreated:Boolean = false;
      
      public function BMMSessionResponder(param1:String, param2:String, param3:String = "")
      {
         super();
         TsLogger.log("BMMSessionResponder[" + param1 + "] :: Constructor. getVars: " + param3);
         this.serviceURL = param2;
         this.internalID = param1;
         this.gateway = param2 + this.SERVICES_PATH + param3;
         this.userData = new Object();
         this.sessionData = new Object();
         this.initialize();
      }
      
      public function get userData() : Object
      {
         return this._userData;
      }
      
      public function set userData(param1:Object) : *
      {
         this._userData = param1;
      }
      
      private function initialize() : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: initialize():");
         this.createServiceIfNeeded();
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
         RemotingManager.gi().addServiceEventListener(CallEvent.SERVICE_AUTHENTICATE_ERROR,this.internalID,this.onLoginError);
         RemotingManager.gi().addServiceEventListener(CallEvent.SERVICE_AUTHENTICATE_SUCCESS,this.internalID,this.onLoginSuccess);
         RemotingManager.gi().addServiceEventListener(CallEvent.SERVICE_LOGOUT_ERROR,this.internalID,this.onLogoutError);
         RemotingManager.gi().addServiceEventListener(CallEvent.SERVICE_LOGOUT_SUCCESS,this.internalID,this.onLogoutSuccess);
      }
      
      private function createServiceIfNeeded() : *
      {
         if(!this.isServiceCreated)
         {
            RemotingManager.gi().createService(this.internalID,this.gateway,this.SESSION_SERVICES,this.SERVICE_CALL_TIMEOUT,this.SERVICE_MAX_RETRIES,this.SERVICE_USE_LIMITER,this.SERVICE_USE_CACHE,this.SERVICE_CACHE_EXPIRE_TIMEOUT);
            this.isServiceCreated = true;
         }
      }
      
      private function closeConnection() : void
      {
         if(this.isServiceCreated)
         {
            RemotingManager.gi().disposeService(this.internalID);
            this.isServiceCreated = false;
         }
      }
      
      public function authenticate() : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: authenticate()");
         this.createServiceIfNeeded();
         RemotingManager.gi().call(this.internalID,this.METHOD_AUTHENTICATE,[],this.onAuthenticateResult,this.onAuthenticateFault);
      }
      
      public function sessionPing() : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: sessionPing()");
         this.createServiceIfNeeded();
         RemotingManager.gi().call(this.internalID,this.METHOD_SESSIONPING,[],this.onSessionPingResult,this.onSessionPingFault);
      }
      
      public function onSessionPingResult(param1:ResultEvent) : *
      {
         this.createServiceIfNeeded();
         dispatchEvent(new Event(BMMSessionResponder.SESSION_PONG));
      }
      
      public function onSessionPingFault(param1:FaultEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onSessionPingFault()");
         this.createServiceIfNeeded();
         dispatchEvent(new Event(BMMSessionResponder.SESSION_PONG));
      }
      
      public function checkKongUserExists(param1:Number) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: checkKongUserExists(" + param1 + ")");
         this.createServiceIfNeeded();
         RemotingManager.gi().call(this.internalID,this.METHOD_KONG_USER_EXISTS,[param1],this.onKongUserExistsResult,this.onKongUserExistsFault);
      }
      
      public function onKongUserExistsResult(param1:ResultEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onKongUserExistsResult()");
         if(param1.result)
         {
            dispatchEvent(new Event(BMMSessionResponder.KONG_USER_EXISTS_TRUE));
         }
         else
         {
            dispatchEvent(new Event(BMMSessionResponder.KONG_USER_EXISTS_FALSE));
         }
      }
      
      public function onKongUserExistsFault(param1:FaultEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onKongUserExistsFault()");
         dispatchEvent(new Event(BMMSessionResponder.KONG_USER_EXISTS_FAULT));
      }
      
      public function consumeItems() : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: consumeTokens()");
         this.createServiceIfNeeded();
         RemotingManager.gi().call(this.internalID,"consumeItems",[],this.onConsumeTokensResult,this.onConsumeTokensFault);
      }
      
      public function onConsumeTokensResult(param1:ResultEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onConsumeTokensResult");
      }
      
      public function onConsumeTokensFault(param1:FaultEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onConsumeTokensFault");
         MiscUtils.traceObject(param1.fault,99);
      }
      
      private function onAuthenticateFault(param1:FaultEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onAuthenticateFault():");
         MiscUtils.traceObject(param1.fault,99);
         this.lastLoginError = param1.fault.code;
         this.timeoutCount = 0;
         this.doDisconnect();
         var _loc2_:Object = param1.fault;
         if(this.authenticated)
         {
            this.authenticated = false;
         }
         dispatchEvent(new Event(BMMSessionResponder.AUTH_FAULT));
      }
      
      private function doConnected() : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: doConnected()");
         if(!this.connected)
         {
            this.connected = true;
         }
      }
      
      public function doLogin(param1:String, param2:String) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: doLogin()");
         this.name = param1;
         this.password = param2;
         this.createServiceIfNeeded();
         RemotingManager.gi().getService(this.internalID).authenticate(param1,param2);
      }
      
      public function doLogout() : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: doLogout()");
         this.createServiceIfNeeded();
         RemotingManager.gi().getService(this.internalID).logout();
      }
      
      private function onConnect(param1:ConnectionEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onConnect()");
         if(this.connected)
         {
            return;
         }
         this.connected = true;
         if(!this.connectable)
         {
            this.connectable = true;
         }
      }
      
      private function onDisconnect(param1:ConnectionEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onDisconnect() ");
         this.doDisconnect();
      }
      
      public function doDisconnect() : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: doDisconnect() ");
         if(!this.connected)
         {
            return;
         }
         this.closeConnection();
         this.userData = new Object();
         this.connected = false;
      }
      
      private function onConnectionFail(param1:ConnectionEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onConnectionFail() -- Service connection failure!");
      }
      
      private function onConnectionFormatError(param1:ConnectionEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onConnectionFormatError() -- AMF format error!");
      }
      
      private function onConnectionSecurityError(param1:ConnectionEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onConnectionSecurityError() -- Security error!");
      }
      
      private function onRetry(param1:CallEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onRetry() -- Retrying - service: " + param1.service + " method: " + param1.method);
         if(param1.method == this.METHOD_AUTHENTICATE || param1.method == this.METHOD_LOGIN)
         {
            ++this.authRetryCount;
         }
      }
      
      private function onTimeout(param1:CallEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onTimeout() -- Timeout! - service[" + this.internalID + "]: " + param1.service + " method: " + param1.method);
         if(param1.method == this.METHOD_AUTHENTICATE && this.timeoutCount < this.MAX_TIMEOUTS)
         {
            ++this.timeoutCount;
            this.createServiceIfNeeded();
            RemotingManager.gi().call(this.internalID,this.METHOD_AUTHENTICATE,[],this.onAuthenticateResult,this.onAuthenticateFault);
         }
         else if(param1.method == this.METHOD_LOGIN && this.timeoutCount < this.MAX_TIMEOUTS)
         {
            ++this.timeoutCount;
            this.doLogin(this.name,this.password);
         }
         else if(param1.method == this.METHOD_SESSIONPING)
         {
            dispatchEvent(new Event(BMMSessionResponder.SESSION_PONG));
         }
         else
         {
            this.timeoutCount = 0;
            dispatchEvent(new TimeoutEvent(param1));
         }
      }
      
      private function onCallLimited(param1:CallEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onCallLimited() -- Call stopped by limiter! - service: " + param1.service + " method: " + param1.method);
      }
      
      private function onServicesHalted(param1:CallEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onServicesHalted() -- Service halted! - service: " + param1.service + " method: " + param1.method);
         this.connectable = false;
      }
      
      private function onRequestSent(param1:CallEvent) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onRequestSent() -- service: " + param1.service + " method: " + param1.method);
      }
      
      private function onFault(param1:CallEvent) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onFault() -- service: " + param1.service + " method: " + param1.method);
      }
      
      private function onResult(param1:CallEvent) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onResult() -- service: " + param1.service + " method: " + param1.method);
      }
      
      private function onLoginError(param1:CallEvent) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onLoginError() -- service: " + param1.service + " method: " + param1.method);
         this.lastLoginError = param1.rawData.description;
         this.timeoutCount = 0;
         dispatchEvent(new Event(BMMSessionResponder.AUTH_FAULT));
      }
      
      private function onLoginSuccess(param1:CallEvent) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onLoginSuccess() -- service: " + param1.service + " method: " + param1.method);
         this.finishAuthenticate(param1.rawData);
      }
      
      private function onAuthenticateResult(param1:ResultEvent) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onAuthenticateResult()");
         if(param1.result == null)
         {
            TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onAuthenticateResult() no result");
            return;
         }
         this.finishAuthenticate(param1.result);
      }
      
      private function finishAuthenticate(param1:Object) : *
      {
         this.timeoutCount = 0;
         this.doConnected();
         if(!this.authenticated)
         {
            this.authenticated = true;
         }
         dispatchEvent(new Event(BMMSessionResponder.AUTH_SUCCESS));
         this.userData = param1;
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: finishAuthenticate() data: " + JSON.stringify(this.userData));
         dispatchEvent(new Event(BMMSessionResponder.GOTUSER_EVENT));
      }
      
      private function onLogoutError(param1:CallEvent) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onLogoutError() -- service: " + param1.service + " method: " + param1.method);
         dispatchEvent(new CallEvent(CallEvent.SERVICE_LOGOUT_ERROR));
      }
      
      private function onLogoutSuccess(param1:CallEvent) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onLogoutSuccess() -- service: " + param1.service + " method: " + param1.method);
         this.doDisconnect();
         dispatchEvent(new CallEvent(CallEvent.SERVICE_LOGOUT_SUCCESS));
      }
      
      public function register(param1:Array, param2:Function, param3:Function) : void
      {
         this.createServiceIfNeeded();
         RemotingManager.gi().call(this.internalID,this.METHOD_REGISTER,param1,param2,param3);
      }
      
      public function externalLogin(param1:String, param2:String, param3:String) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: externalLogin(" + param1 + "," + param2 + "," + param3 + ")");
         this.createServiceIfNeeded();
         RemotingManager.gi().call(this.internalID,this.METHOD_EXTERNAL_LOGIN,[param1,param2,param3],this.onExternalLoginResult,this.onExternalLoginFault,true);
      }
      
      private function onExternalLoginResult(param1:ResultEvent, param2:Array) : *
      {
         var _loc3_:ExternalLoginConflictEvent = null;
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onExternalLoginResult() " + param1.result.type);
         switch(param1.result.type)
         {
            case "register":
            case "login":
               this.userData = param1.result.userData;
               dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE));
               if(!this.connected)
               {
                  this.name = param2[1];
                  this.password = param2[2];
                  if(param1.result.type == "login")
                  {
                     dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_RELOGIN));
                  }
                  else
                  {
                     this.finishAuthenticate(param1.result.userData);
                  }
               }
               break;
            case "conflict":
               _loc3_ = new ExternalLoginConflictEvent();
               _loc3_.currentPlayer.playerID = param1.result.currentPlayer.playerID;
               _loc3_.currentPlayer.name = param1.result.currentPlayer.name;
               _loc3_.currentPlayer.level = param1.result.currentPlayer.level;
               _loc3_.newPlayer.playerID = param1.result.newPlayer.playerID;
               _loc3_.newPlayer.name = param1.result.newPlayer.name;
               _loc3_.newPlayer.level = param1.result.newPlayer.level;
               dispatchEvent(_loc3_);
               break;
            case "auto_merged":
               this.doMergeAccounts(param1.result.userData);
         }
      }
      
      private function onExternalLoginFault(param1:FaultEvent, param2:Array) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onExternalLoginFault()");
         this.lastLoginError = param1.fault.description;
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT));
         MiscUtils.traceObject(param1.fault,99);
      }
      
      public function externalLogout(param1:String) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: externalLogout(" + param1 + ")");
         this.createServiceIfNeeded();
         RemotingManager.gi().call(this.internalID,this.METHOD_EXTERNAL_LOGOUT,[param1],this.onExternalLogoutResult,this.onExternalLogoutFault,true);
      }
      
      private function onExternalLogoutResult(param1:ResultEvent, param2:Array) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onExternalLogoutResult()");
         this.userData = param1.result;
         dispatchEvent(new DataEvent(ExternalSessionEvents.EXTERNAL_LOGOUT_TRUE,false,false,param2[0]));
      }
      
      private function onExternalLogoutFault(param1:FaultEvent, param2:Array) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onExternalLogoutFault()");
         MiscUtils.traceObject(param1.fault,99);
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGOUT_FAULT));
      }
      
      public function mergeAccounts(param1:Number, param2:String, param3:String, param4:String) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: mergeAccounts() targetPlayerID:" + param1);
         var _loc5_:Boolean = param1 == this.userData.user_id;
         this.createServiceIfNeeded();
         RemotingManager.gi().call(this.internalID,this.METHOD_MERGE_ACCOUNTS,[param2,param3,param4,_loc5_],this.onMergeAccountsResult,this.onMergeAccountsFault,true);
      }
      
      private function onMergeAccountsResult(param1:ResultEvent, param2:Array) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onMergeAccountsResult() ");
         this.doMergeAccounts(param1.result);
      }
      
      private function doMergeAccounts(param1:Object) : *
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: doMergeAccounts() ");
         if(param1.user_id != this.userData.user_id)
         {
            TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: EXTERNAL_RELOGIN ");
            dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_RELOGIN));
            return;
         }
         this.userData = param1;
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGIN_TRUE));
      }
      
      private function onMergeAccountsFault(param1:FaultEvent, param2:Array) : void
      {
         TsLogger.log("BMMSessionResponder[" + this.internalID + "] :: onMergeAccountsFault() ");
         MiscUtils.traceObject(param1.fault,99);
         dispatchEvent(new Event(ExternalSessionEvents.EXTERNAL_LOGIN_FAULT));
      }
   }
}

