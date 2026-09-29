package net.tacticsoft.remoting.events
{
   public interface IRemotingEventsDelegate
   {
      
      function onConnect(param1:ConnectionEvent) : void;
      
      function onDisconnect(param1:ConnectionEvent) : void;
      
      function onConnectionFail(param1:ConnectionEvent) : void;
      
      function onConnectionSecurityError(param1:ConnectionEvent) : void;
      
      function onConnectionFormatError(param1:ConnectionEvent) : void;
      
      function onRetry(param1:CallEvent) : void;
      
      function onTimeout(param1:CallEvent) : void;
      
      function onRequestSent(param1:CallEvent) : void;
      
      function onCallLimited(param1:CallEvent) : void;
      
      function onServicesHalted() : void;
   }
}

