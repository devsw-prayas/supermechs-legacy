package com.google.ads.ima.wrappers
{
   import com.google.ads.ima.api.Ad;
   import com.google.ads.ima.api.NetStreamReadyEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   internal class NetStreamReadyEventWrapper extends NetStreamReadyEvent
   {
      
      private var localInstance:Object;
      
      private var wrappersValue:Wrappers;
      
      private var remoteMethodResultsStore:Dictionary = new Dictionary();
      
      private var remoteInstance:Object;
      
      public function NetStreamReadyEventWrapper(param1:Wrappers, param2:Object, param3:Object = null)
      {
         this.remoteInstance = param2;
         this.localInstance = param3;
         wrappersValue = param1;
         super(param1.remoteToLocal(remoteMethodResultsStore,param2.ad,localInstance) as Ad,param2.netStream);
      }
      
      override public function clone() : Event
      {
         return new NetStreamReadyEventWrapper(wrappersValue,remoteInstance,localInstance);
      }
   }
}

