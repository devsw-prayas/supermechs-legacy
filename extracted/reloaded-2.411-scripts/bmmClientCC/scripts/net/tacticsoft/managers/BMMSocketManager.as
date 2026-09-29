package net.tacticsoft.managers
{
   import flash.events.EventDispatcher;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battlegate.events.BGSocketEvent;
   import net.battlegate.sockets.BGSocket;
   import net.tacticsoft.utils.MiscUtils;
   
   public final class BMMSocketManager extends EventDispatcher
   {
      
      private static var _instance:BMMSocketManager;
      
      public var bgSocket:BGSocket;
      
      private var _connected:Boolean = false;
      
      private var _domain:String = "localhost";
      
      private var _port:uint = 0;
      
      public function BMMSocketManager()
      {
         super();
         if(BMMSocketManager._instance)
         {
            throw new Error("SocketManager is a singleton, see SessionManager.getInstance()");
         }
         this.initialize();
      }
      
      public static function getInstance() : BMMSocketManager
      {
         if(_instance == null)
         {
            _instance = new BMMSocketManager();
         }
         return _instance;
      }
      
      public static function gi() : BMMSocketManager
      {
         return getInstance();
      }
      
      public function get connected() : Boolean
      {
         return this._connected;
      }
      
      public function set connected(param1:Boolean) : void
      {
      }
      
      public function get domain() : String
      {
         return this._domain;
      }
      
      public function set domain(param1:String) : void
      {
         this._domain = param1;
      }
      
      public function get port() : uint
      {
         return this._port;
      }
      
      public function set port(param1:uint) : void
      {
         this._port = param1;
      }
      
      private function initialize() : void
      {
      }
      
      public function connect(param1:String = null, param2:uint = 0) : void
      {
         if(!this._connected)
         {
            if(param1 != null)
            {
               this.domain = param1;
            }
            if(param2 != 0)
            {
               this.port = param2;
            }
            if(this.port == 0)
            {
               throw new Error("SocketManager :: connect() - Invalid port number!");
            }
            if(this.bgSocket != null)
            {
               this.bgSocket.removeEventListener(BGSocketEvent.DATA_AVAILABLE,this.gotData);
               this.bgSocket.removeEventListener(BGSocketEvent.CONNECTED,this.onConnect);
               this.bgSocket.removeEventListener(BGSocketEvent.CLOSED,this.onDisconnect);
               this.bgSocket.removeEventListener(BGSocketEvent.IO_ERROR,this.onIOError);
               this.bgSocket.removeEventListener(BGSocketEvent.SECURITY_ERROR,this.onSecurityError);
               this.bgSocket.close();
            }
            this.bgSocket = new BGSocket();
            this.bgSocket.addEventListener(BGSocketEvent.DATA_AVAILABLE,this.gotData);
            this.bgSocket.addEventListener(BGSocketEvent.CONNECTED,this.onConnect);
            this.bgSocket.addEventListener(BGSocketEvent.CLOSED,this.onDisconnect);
            this.bgSocket.addEventListener(BGSocketEvent.IO_ERROR,this.onIOError);
            this.bgSocket.addEventListener(BGSocketEvent.SECURITY_ERROR,this.onSecurityError);
            this.bgSocket.connect(this.domain,this.port);
            return;
         }
         throw new Error("SocketManager :: connect() - Already connected");
      }
      
      private function onIOError(param1:BGSocketEvent) : void
      {
         this.createTrace("SocketManager :: onIOError()");
         this.createTrace(MiscUtils.getTraceObject(this.bgSocket.lastError.toString()));
         BMDataManager.getInstance().trackError("BMMIOError",this.bgSocket.lastError.toString());
      }
      
      private function onSecurityError(param1:BGSocketEvent) : void
      {
         this.createTrace("SocketManager :: onSecurityError()");
         this.createTrace(MiscUtils.getTraceObject(this.bgSocket.lastError.toString()));
         BMDataManager.getInstance().trackError("BMMSocketIOError",this.bgSocket.lastError.toString());
      }
      
      private function gotData(param1:BGSocketEvent) : void
      {
         this.createTrace("SocketManager :: gotData()");
         dispatchEvent(new BGSocketEvent(BGSocketEvent.DATA_AVAILABLE));
      }
      
      public function sendCommand(param1:String, param2:Object) : void
      {
         var _loc4_:String = null;
         this.createTrace("SocketManager :: sendCommand - \n $command:" + param1 + "\n $params:\n" + MiscUtils.getTraceObject(param2));
         var _loc3_:Object = new Object();
         _loc3_.cmd = param1;
         for(_loc4_ in param2)
         {
            _loc3_[_loc4_] = param2[_loc4_];
         }
         this.bgSocket.sendObject(_loc3_);
      }
      
      private function onConnect(param1:BGSocketEvent) : void
      {
         this.createTrace("SocketManager :: onConnect(Domain: " + this.domain + " Port: " + this.port + ")");
         this._connected = true;
         dispatchEvent(new BGSocketEvent(BGSocketEvent.CONNECTED));
      }
      
      private function onDisconnect(param1:BGSocketEvent) : void
      {
         this.createTrace("SocketManager :: onDisconnect(Domain: " + this.domain + " Port: " + this.port + ")");
         this._connected = false;
         dispatchEvent(new BGSocketEvent(BGSocketEvent.CLOSED));
      }
      
      public function close() : void
      {
         if(this.connected)
         {
            this.bgSocket.close();
         }
      }
      
      private function createTrace(param1:String) : void
      {
      }
   }
}

