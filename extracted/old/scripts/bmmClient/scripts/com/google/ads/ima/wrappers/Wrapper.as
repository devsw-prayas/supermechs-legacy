package com.google.ads.ima.wrappers
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   internal class Wrapper extends EventDispatcher
   {
      
      private var remoteMethodResultsDictionary:Dictionary = new Dictionary();
      
      private var localInstanceValue:Object;
      
      private var remoteInstanceValue:Object;
      
      private var wrappersValue:Wrappers;
      
      public function Wrapper(param1:Wrappers, param2:Object, param3:Object = null)
      {
         super();
         wrappersValue = param1;
         remoteMethodResultsDictionary = new Dictionary();
         remoteInstanceValue = param2;
         localInstanceValue = param3;
      }
      
      public function get localInstance() : Object
      {
         return localInstanceValue;
      }
      
      protected function get wrappers() : Wrappers
      {
         return wrappersValue;
      }
      
      protected function get remoteMethodResultsStore() : Dictionary
      {
         return remoteMethodResultsDictionary;
      }
      
      public function get remoteInstance() : Object
      {
         return remoteInstanceValue;
      }
      
      public function set remoteInstance(param1:Object) : void
      {
         remoteInstanceValue = param1;
      }
   }
}

