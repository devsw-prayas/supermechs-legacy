package net.tacticsoft.remoting
{
   import flash.events.*;
   import flash.net.NetConnection;
   import net.tacticsoft.core.IDisposable;
   import net.tacticsoft.remoting.events.ConnectionEvent;
   import net.tacticsoft.utils.MiscUtils;
   
   public class RemotingConnection extends EventDispatcher implements IDisposable
   {
      
      public var gateway:String;
      
      public var connection:NetConnection;
      
      public var needConnectedDispatched:Boolean = false;
      
      public function RemotingConnection(param1:String, param2:int = 3)
      {
         super();
         if(param1 == "")
         {
            throw new ArgumentError("Gateway cannot be null");
         }
         if(param2 != 0 && param2 != 3)
         {
            throw new ArgumentError("Object encoding must be 0 or 3");
         }
         this.gateway = param1;
         this.connection = new NetConnection();
         this.connection.objectEncoding = param2;
         this.connection.addEventListener(NetStatusEvent.NET_STATUS,this.onConnectionStatus);
         this.connection.addEventListener(IOErrorEvent.IO_ERROR,this.onConnectionError);
         this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConnectionError);
         TsLogger.log("RemotingConnection::ctor gateway " + param1 + " objectEncoding " + param2);
         this.connection.connect(param1);
         this.needConnectedDispatched = true;
      }
      
      public function setCredentials(param1:String, param2:String) : void
      {
         this.connection.addHeader("Credentials",false,{
            "userid":param1,
            "password":param2
         });
      }
      
      public function clearCredentials() : void
      {
         this.connection.addHeader("Credentials",false,"AMFPHP_CLEARED_CREDENTIALS");
      }
      
      private function onConnectionError(param1:ErrorEvent) : void
      {
         TsLogger.log("RemotingConnection::onConnectionError " + this.gateway + " " + param1.toString());
         this.connection.close();
         this.connection = null;
         var _loc2_:ConnectionEvent = new ConnectionEvent(ConnectionEvent.ERROR);
         _loc2_.message = param1.text;
         dispatchEvent(_loc2_);
      }
      
      private function onConnectionStatus(param1:NetStatusEvent) : void
      {
         var _loc2_:ConnectionEvent = null;
         switch(param1.info.code)
         {
            case "NetConnection.Connect.Success":
               _loc2_ = new ConnectionEvent(ConnectionEvent.CONNECTED);
               _loc2_.message = param1.info.code;
               dispatchEvent(_loc2_);
               break;
            case "NetConnection.Connect.Failed":
               _loc2_ = new ConnectionEvent(ConnectionEvent.FAILED);
               dispatchEvent(_loc2_);
               break;
            case "NetConnection.Call.BadVersion":
               _loc2_ = new ConnectionEvent(ConnectionEvent.FORMAT_ERROR);
               MiscUtils.traceObject(param1.info);
               dispatchEvent(_loc2_);
               break;
            case "NetConnection.Call.Prohibited":
               _loc2_ = new ConnectionEvent(ConnectionEvent.SECURITY_ERROR);
               _loc2_.message = param1.info.code;
               dispatchEvent(_loc2_);
               break;
            case "NetConnection.Connect.Closed":
               _loc2_ = new ConnectionEvent(ConnectionEvent.DISCONNECT);
               _loc2_.message = param1.info.code;
               dispatchEvent(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         TsLogger.log("RemotingConnection::dispose " + this.gateway);
         this.connection.close();
         this.connection = null;
         this.gateway = null;
      }
      
      public function get connected() : Boolean
      {
         return this.connection.connected;
      }
      
      public function reConnect() : void
      {
         var _loc1_:ConnectionEvent = null;
         this.connection.connect(this.gateway);
         if(this.needConnectedDispatched)
         {
            this.needConnectedDispatched = false;
            _loc1_ = new ConnectionEvent(ConnectionEvent.CONNECTED);
            _loc1_.message = "NetConnection.Connect.Success";
            dispatchEvent(_loc1_);
         }
      }
   }
}

