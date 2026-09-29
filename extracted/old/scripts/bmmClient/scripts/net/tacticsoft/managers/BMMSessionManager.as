package net.tacticsoft.managers
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.battleMechsMulti.session.BMDomainResolver;
   import net.tacticsoft.responders.BMMSessionResponder;
   
   public class BMMSessionManager extends EventDispatcher
   {
      
      private static var _instance:BMMSessionManager;
      
      public static var EVENT_AUTH_RETRY:String = "authRetryEvent";
      
      public static var EVENT_AUTH_TIMEOUT:String = "authTimeoutEvent";
      
      public static var EVENT_AUTH_HALTED:String = "authHaltedEvent";
      
      public static var EVENT_KONG_USER_EXISTS_TRUE:String = "kongUserExists";
      
      public static var EVENT_KONG_USER_EXISTS_FALSE:String = "kongUserDoesntExist";
      
      public static var EVENT_KONG_USER_EXISTS_FAULT:String = "kongUserExistsFault";
      
      public static var SESSION_TYPE_UNDETERMINED:String = "undetermined";
      
      public static var SESSION_TYPE_WEB:String = "web";
      
      public static var SESSION_TYPE_DESK:String = "desk";
      
      public static var SESSION_TYPE_KONGREGATE:String = "kong";
      
      public static var SESSION_TYPE_STEAM:String = "steam";
      
      public static var SESSION_TYPE_GAMESCENTER:String = "iTunesGames";
      
      public static var SESSION_TYPE_FACEBOOK_WEB:String = "facebookWeb";
      
      public static var SESSION_TYPE_FACEBOOK_MOBILE:String = "facebookMobile";
      
      public static var SESSION_TYPE_FACEBOOK_DESKTOP:String = "facebookDesk";
      
      private var currentURL:String = null;
      
      public var session:BMMSessionResponder;
      
      private var _sessionTypes:Vector.<String> = new <String>[SESSION_TYPE_UNDETERMINED];
      
      private var clientAliveTimer:ClientIsAliveTimer;
      
      private var mcamp_id:String = "";
      
      private const pythonFunctionsThatDoNotResetClientTimer:Array = ["BMM_CHAT_TO_ALL","BMM_LOBBY_CLIENT_IS_ALIVE"];
      
      public function BMMSessionManager(param1:String = "")
      {
         super();
         if(BMMSessionManager._instance)
         {
            throw new Error("SessionManager is a singleton, see SessionManager.getInstance()");
         }
         this.mcamp_id = param1;
         this.initialize();
      }
      
      public static function getInstance(param1:String = "") : BMMSessionManager
      {
         if(_instance == null)
         {
            _instance = new BMMSessionManager(param1);
         }
         return _instance;
      }
      
      public static function gi(param1:String = "") : BMMSessionManager
      {
         return getInstance(param1);
      }
      
      private function initialize() : *
      {
         TsLogger.log("BMMSessionManager :: initialize()");
         this.setupServices();
      }
      
      private function setupServices() : *
      {
         var _loc1_:String = "";
         if(this.mcamp_id != "" && this.mcamp_id != null && this.mcamp_id != "null")
         {
            _loc1_ = "?mcamp_id=" + this.mcamp_id;
            TsLogger.log("BMMSessionManager :: setupServices() addVars=" + _loc1_);
         }
         var _loc2_:* = BMDomainResolver.getHttpDomain();
         TsLogger.log("BMMSessionManager :: setupServices() - url:" + _loc2_);
         this.session = new BMMSessionResponder(BMDomainResolver.getDomain(),_loc2_,_loc1_);
         this.session.addEventListener(BMMSessionResponder.AUTH_FAULT,this.authFailure);
         this.session.addEventListener(BMMSessionResponder.GOTUSER_EVENT,this.gotUserData);
         this.clientAliveTimer = new ClientIsAliveTimer(this.session);
      }
      
      public function checkKongUserExists(param1:Number) : *
      {
         TsLogger.log("BMMSessionManager :: checkKongUserExists()");
         this.session.addEventListener(BMMSessionResponder.KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.session.addEventListener(BMMSessionResponder.KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.session.addEventListener(BMMSessionResponder.KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         this.session.checkKongUserExists(param1);
      }
      
      private function kongUserExists(param1:Event) : *
      {
         TsLogger.log("BMMSessionManager :: kongUserExists()");
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         dispatchEvent(new Event(BMMSessionManager.EVENT_KONG_USER_EXISTS_TRUE));
      }
      
      private function kongUserDoesntExist(param1:Event) : *
      {
         TsLogger.log("BMMSessionManager :: kongUserDoesntExist()");
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         dispatchEvent(new Event(BMMSessionManager.EVENT_KONG_USER_EXISTS_FALSE));
      }
      
      private function checkKongUserExistsFault(param1:Event) : *
      {
         TsLogger.log("BMMSessionManager :: checkKongUserExistsFault()");
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_TRUE,this.kongUserExists);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FALSE,this.kongUserDoesntExist);
         this.session.removeEventListener(BMMSessionResponder.KONG_USER_EXISTS_FAULT,this.checkKongUserExistsFault);
         dispatchEvent(new Event(BMMSessionManager.EVENT_KONG_USER_EXISTS_FAULT));
      }
      
      public function getSession() : BMMSessionResponder
      {
         return this.session;
      }
      
      public function login(param1:String, param2:String) : *
      {
         TsLogger.log("BMMSessionManager :: login()");
         this.session.doLogin(param1,param2);
      }
      
      public function logout() : *
      {
         TsLogger.log("BMMSessionManager :: logout()");
         this.session.doLogout();
         this.clientAliveTimer.disable();
      }
      
      public function register(param1:Array, param2:Function, param3:Function) : void
      {
         this.session.register(param1,param2,param3);
      }
      
      private function gotUserData(param1:Event) : void
      {
         TsLogger.log("BMMSessionManager :: gotuserdata()");
         dispatchEvent(new Event(BMMSessionResponder.GOTUSER_EVENT));
         this.clientAliveTimer.enable();
      }
      
      public function get isAlive() : *
      {
         return this.clientAliveTimer.isAlive;
      }
      
      public function consumeAllKongItems() : void
      {
         this.session.consumeItems();
      }
      
      private function authFailure(param1:Event) : void
      {
         TsLogger.log("BMMSessionManager :: authFailure()");
         dispatchEvent(new Event(BMMSessionResponder.AUTH_FAULT));
         this.clientAliveTimer.disable();
      }
      
      public function pythonFunctionCalled(param1:*) : void
      {
         if(this.pythonFunctionsThatDoNotResetClientTimer.indexOf(param1) >= 0)
         {
            return;
         }
         this.clientAliveTimer.reset();
      }
   }
}

import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;
import net.battleMechsMulti.managers.BMRemoteManager;
import net.battleMechsMulti.managers.BMSocketManager;
import net.tacticsoft.responders.BMMSessionResponder;

class ClientIsAliveTimer
{
   
   private static const INTERVAL:uint = 60 * 1000;
   
   private static const MAX_RUNS_WITH_NO_RESET:uint = 60;
   
   private var pingTimer:Timer = new Timer(INTERVAL,MAX_RUNS_WITH_NO_RESET);
   
   private var socketManager:BMSocketManager;
   
   private var wasOn:Boolean = false;
   
   private var _session:BMMSessionResponder;
   
   public function ClientIsAliveTimer(param1:BMMSessionResponder)
   {
      super();
      this._session = param1;
      this.pingTimer.addEventListener(TimerEvent.TIMER,this.sendAlive);
      this.pingTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.timerComplete);
   }
   
   internal function resumeEvent(param1:Event) : void
   {
      if(this.wasOn)
      {
         this.reset();
         this.wasOn = false;
      }
   }
   
   internal function stopEvent(param1:Event) : void
   {
      this.wasOn = this.pingTimer.running;
      if(this.wasOn)
      {
         this.disable();
      }
   }
   
   private function sendAlive(param1:TimerEvent) : *
   {
      if(this.socketManager == null)
      {
         this.socketManager = BMRemoteManager.getInstance().socketM;
      }
      if(this.socketManager == null)
      {
         return;
      }
      if(this.socketManager.isConnected)
      {
         this.socketManager.lobby_clientIsAlive();
      }
      if(this._session.connected)
      {
         this._session.sessionPing();
      }
   }
   
   private function timerComplete(param1:TimerEvent) : *
   {
      TsLogger.log("ClientIsAliveTimer :: Timer Complete");
   }
   
   public function get isAlive() : Boolean
   {
      return this.pingTimer.running;
   }
   
   public function enable() : *
   {
      this.pingTimer.reset();
      this.pingTimer.start();
   }
   
   public function reset() : *
   {
      this.enable();
   }
   
   public function disable() : *
   {
      this.pingTimer.stop();
   }
}
