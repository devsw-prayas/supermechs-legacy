package com.google.ads.ima.api
{
   import com.google.ads.ima.apidependency.TimedLoader;
   import flash.system.ApplicationDomain;
   
   internal class SdkSwfLoader extends TimedLoader
   {
      
      private var publisherApplicationDomainValue:ApplicationDomain;
      
      public function SdkSwfLoader(param1:ApplicationDomain)
      {
         super();
         publisherApplicationDomainValue = param1;
      }
      
      public function get publisherApplicationDomain() : ApplicationDomain
      {
         return publisherApplicationDomainValue;
      }
   }
}

