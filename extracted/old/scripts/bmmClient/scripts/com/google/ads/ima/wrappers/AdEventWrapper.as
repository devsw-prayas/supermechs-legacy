package com.google.ads.ima.wrappers
{
   import com.google.ads.ima.api.Ad;
   import com.google.ads.ima.api.AdEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   internal class AdEventWrapper extends AdEvent
   {
      
      private var localInstance:Object;
      
      private var wrappersValue:Wrappers;
      
      private var remoteMethodResultsStore:Dictionary = new Dictionary();
      
      private var remoteInstance:Object;
      
      public function AdEventWrapper(param1:Wrappers, param2:Object, param3:Object = null)
      {
         this.remoteInstance = param2;
         this.localInstance = param3;
         wrappersValue = param1;
         super(param2.type,param1.remoteToLocal(remoteMethodResultsStore,param2.ad,localInstance) as Ad,param2.adData);
      }
      
      override public function clone() : Event
      {
         return new AdEventWrapper(wrappersValue,remoteInstance,localInstance);
      }
   }
}

