package net.battlegate.sockets
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.ObjectEncoding;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import net.battlegate.events.BGSocketEvent;
   
   public class BGSocket extends Socket
   {
      
      public static const DISCONNECTED_CONNECT_ERROR:* = "ConnectError";
      
      public static const DISCONNECTED_CLIENT:* = "ClientDisconnected";
      
      public static const DISCONNECTED_SERVER:* = "ServerDisconnected";
      
      private const compressThreshold:uint = 1000;
      
      public var lastError:*;
      
      private var _host:String = null;
      
      private var _port:uint = 0;
      
      private var _statusFunction:Function;
      
      private var buffer:ByteArray;
      
      public var dataStack:Array;
      
      private var policyLoaded:Boolean = false;
      
      private var _lastObjectSent:Object = null;
      
      private var _connected:Boolean = false;
      
      private var _gettingData:Boolean = false;
      
      private var _dataExpected:uint = 0;
      
      public function BGSocket(param1:String = null, param2:uint = 0)
      {
         this._host = param1;
         this._port = param2;
         this.init();
         super(param1,param2);
      }
      
      public function get host() : String
      {
         return this._host;
      }
      
      public function set host(param1:String) : void
      {
         if(this._host != param1)
         {
            this.policyLoaded = false;
            this._host = param1;
         }
      }
      
      public function get port() : uint
      {
         return this._port;
      }
      
      public function set port(param1:uint) : void
      {
         if(this._port != param1)
         {
            this.policyLoaded = false;
            this._port = param1;
         }
      }
      
      public function get isConnected() : Boolean
      {
         return this._connected;
      }
      
      private function set isConnected(param1:Boolean) : void
      {
         this._connected = param1;
      }
      
      override public function connect(param1:String, param2:int) : void
      {
         var host:String = param1;
         var port:int = param2;
         TsLogger.log("BGSocket :: connect(host:" + host + ", port:" + port + ")");
         this._lastObjectSent = null;
         if(host != null && !this.policyLoaded && host != "localhost")
         {
            TsLogger.log("BGSocket :: connect() - loading policy: host: " + host);
            Security.loadPolicyFile("xmlsocket://" + host + ":843");
         }
         this._host = host;
         this._port = port;
         this.policyLoaded = true;
         dispatchEvent(new BGSocketEvent(BGSocketEvent.CONNECTING));
         try
         {
            super.connect(host,port);
         }
         catch(err:Error)
         {
            TsLogger.log(err.message);
            lastError = err;
            if(_statusFunction != null)
            {
               _statusFunction(DISCONNECTED_CONNECT_ERROR);
            }
         }
      }
      
      override public function close() : void
      {
         if(!this._connected)
         {
            return;
         }
         try
         {
            super.close();
         }
         catch(err:Error)
         {
         }
         this.closeHandler();
      }
      
      public function addStatusFunction(param1:Function) : void
      {
         this._statusFunction = param1;
      }
      
      private function init() : void
      {
         this.dataStack = new Array();
         objectEncoding = ObjectEncoding.AMF3;
         this.buffer = new ByteArray();
         addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         addEventListener(Event.CLOSE,this.closeHandler);
         addEventListener(Event.CONNECT,this.connectHandler);
         addEventListener(ProgressEvent.SOCKET_DATA,this.dataHandler);
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         TsLogger.log("BGSocket :: securityError() - error: " + param1.text);
         this.lastError = param1;
         this.policyLoaded = false;
         dispatchEvent(new BGSocketEvent(BGSocketEvent.SECURITY_ERROR));
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         if(param1 != null)
         {
            TsLogger.log("BGSocket :: ioErrorHandler() " + param1.errorID + " " + param1.text);
         }
         else
         {
            TsLogger.log("BGSocket :: ioErrorHandler() null");
         }
         this.lastError = param1;
         dispatchEvent(new BGSocketEvent(BGSocketEvent.IO_ERROR));
      }
      
      private function closeHandler(param1:Event = null) : void
      {
         this._connected = false;
         if(this._statusFunction != null)
         {
            if(param1 == null)
            {
               this._statusFunction(DISCONNECTED_CLIENT);
               TsLogger.log("BGSocket :: closeHandler() From Client");
            }
            else
            {
               this._statusFunction(DISCONNECTED_SERVER);
               TsLogger.log("BGSocket :: closeHandler() From Server");
            }
         }
         else
         {
            TsLogger.log("BGSocket :: closeHandler()");
         }
         dispatchEvent(new BGSocketEvent(BGSocketEvent.CLOSED));
      }
      
      private function connectHandler(param1:Event) : void
      {
         TsLogger.log("BGSocket :: connectHandler() - host: " + this._host + " port: " + this._port);
         this._connected = true;
         dispatchEvent(new BGSocketEvent(BGSocketEvent.CONNECTED));
      }
      
      private function processBuffer(param1:Boolean = true) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:Object = null;
         var _loc6_:ByteArray = null;
         this.buffer.position = 0;
         var _loc2_:String = this.buffer.readUTFBytes(1);
         if(_loc2_ == "b")
         {
            _loc3_ = this.buffer.readUnsignedInt();
            if(_loc3_ <= this.buffer.bytesAvailable)
            {
               _loc4_ = new ByteArray();
               this.buffer.readBytes(_loc4_,0,_loc3_);
               try
               {
                  _loc4_.uncompress();
               }
               catch(e:Error)
               {
               }
               _loc5_ = _loc4_.readObject();
               this.dataStack.unshift(_loc5_);
               if(this.buffer.bytesAvailable > 0)
               {
                  _loc6_ = new ByteArray();
                  this.buffer.readBytes(_loc6_,0,this.buffer.bytesAvailable);
                  this.buffer = new ByteArray();
                  _loc6_.position = 0;
                  this.buffer.writeBytes(_loc6_);
                  this.buffer.position = 0;
                  this.processBuffer(false);
               }
               else
               {
                  this.buffer = new ByteArray();
               }
               if(param1)
               {
                  dispatchEvent(new BGSocketEvent(BGSocketEvent.DATA_AVAILABLE,false,false));
               }
            }
         }
         else
         {
            TsLogger.log("error!");
         }
      }
      
      private function dataHandler(param1:ProgressEvent = null) : void
      {
         dispatchEvent(new BGSocketEvent(BGSocketEvent.DATA_RECEIVED));
         var _loc2_:ByteArray = new ByteArray();
         readBytes(_loc2_);
         _loc2_.position = 0;
         this.buffer.position = 0;
         this.buffer.position = this.buffer.bytesAvailable;
         this.buffer.writeBytes(_loc2_);
         this.processBuffer(true);
      }
      
      public function sendObject(param1:Object) : void
      {
         this._lastObjectSent = param1;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         if(_loc2_.bytesAvailable > this.compressThreshold)
         {
            _loc2_.compress();
            _loc2_.position = 0;
         }
         writeUTFBytes("b");
         writeUnsignedInt(_loc2_.bytesAvailable);
         writeBytes(_loc2_,0,_loc2_.bytesAvailable);
         flush();
      }
      
      public function get lastObjectSent() : Object
      {
         return this._lastObjectSent;
      }
   }
}

