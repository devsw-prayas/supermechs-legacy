package com.google.ads.ima.wrappers
{
   import com.google.ads.ima.api.HtmlCompanionAd;
   
   internal class HtmlCompanionAdWrapper extends Wrapper implements HtmlCompanionAd
   {
      
      public function HtmlCompanionAdWrapper(param1:Wrappers, param2:Object, param3:Object = null)
      {
         super(param1,param2,param3);
      }
      
      public function get content() : String
      {
         return remoteInstance.content;
      }
      
      public function get environment() : String
      {
         return remoteInstance.environment;
      }
      
      public function get isBackfill() : Boolean
      {
         return remoteInstance.isBackfill;
      }
   }
}

