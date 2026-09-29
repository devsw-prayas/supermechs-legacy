package com.google.ads.ima.wrappers
{
   import com.google.ads.ima.api.AdError;
   import com.google.ads.ima.api.AdErrorEvent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   internal class AdErrorEventWrapper extends AdErrorEvent
   {
      
      private var localInstance:Object;
      
      private var wrappersValue:Wrappers;
      
      private var remoteMethodResultsStore:Dictionary = new Dictionary();
      
      private var remoteInstance:Object;
      
      public function AdErrorEventWrapper(param1:Wrappers, param2:Object, param3:Object = null)
      {
         this.remoteInstance = param2;
         this.localInstance = param3;
         wrappersValue = param1;
         super(param1.remoteToLocal(remoteMethodResultsStore,param2.error,localInstance) as AdError,param2.userRequestContext);
      }
      
      override public function clone() : Event
      {
         return new AdErrorEventWrapper(wrappersValue,remoteInstance,localInstance);
      }
   }
}

