package com.google.ads.ima.api
{
   import flash.events.Event;
   import flash.net.NetStream;
   
   public class NetStreamReadyEvent extends AdEvent
   {
      
      public static const NETSTREAM_READY:String = "netStreamReady";
      
      private var netStreamInstance:NetStream = null;
      
      public function NetStreamReadyEvent(param1:Ad, param2:NetStream)
      {
         super(NETSTREAM_READY,param1);
         netStreamInstance = param2;
      }
      
      public function get netStream() : NetStream
      {
         return netStreamInstance;
      }
      
      override public function clone() : Event
      {
         return new NetStreamReadyEvent(ad,netStream);
      }
   }
}

