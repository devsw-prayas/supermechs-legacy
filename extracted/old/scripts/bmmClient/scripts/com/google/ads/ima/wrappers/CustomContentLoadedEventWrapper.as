package com.google.ads.ima.wrappers
{
   import com.google.ads.ima.api.CustomContentLoadedEvent;
   import com.google.ads.ima.api.ima_internal_api;
   import flash.events.Event;
   
   internal class CustomContentLoadedEventWrapper extends CustomContentLoadedEvent
   {
      
      private var localInstance:Object;
      
      private var wrappersValue:Wrappers;
      
      private var remoteInstance:Object;
      
      public function CustomContentLoadedEventWrapper(param1:Wrappers, param2:Object, param3:Object = null)
      {
         this.remoteInstance = param2;
         this.localInstance = param3;
         wrappersValue = param1;
         super(param2.ima_internal_api::getCustomContentAd());
      }
      
      override public function displayCompanions() : void
      {
         remoteInstance.displayCompanions();
      }
      
      override public function get content() : String
      {
         return remoteInstance.content;
      }
      
      override public function get userRequestContext() : Object
      {
         return remoteInstance.userRequestContext;
      }
      
      override public function clone() : Event
      {
         return new CustomContentLoadedEventWrapper(wrappersValue,remoteInstance,localInstance);
      }
   }
}

