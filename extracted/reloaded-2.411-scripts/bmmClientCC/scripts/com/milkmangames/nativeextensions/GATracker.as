package com.milkmangames.nativeextensions
{
   public class GATracker
   {
      
      public var trackingID:String;
      
      private var ganalytics:GAnalytics;
      
      public function GATracker(param1:String, param2:GAnalytics)
      {
         super();
         if(!GAnalytics._isTrackerCreating)
         {
            throw new Error("Use GAnalytrics.getTracker() instead of \'new GATracker()\'.");
         }
         this.trackingID = this.trackingID;
         this.ganalytics = param2;
      }
      
      public function setTrackerField(param1:String, param2:String) : void
      {
      }
      
      public function trackScreenView(param1:String = null, param2:Object = null) : void
      {
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN, param5:Object = null) : void
      {
      }
      
      public function trackTransaction(param1:String, param2:String, param3:Number, param4:Number = NaN, param5:Number = NaN, param6:String = null, param7:Object = null) : void
      {
      }
      
      public function trackItem(param1:String, param2:String, param3:String, param4:Number, param5:String = null, param6:Number = 1, param7:String = null, param8:Object = null) : void
      {
      }
      
      public function trackException(param1:String, param2:Boolean, param3:Object = null) : void
      {
      }
      
      public function trackTiming(param1:String, param2:Number, param3:String = null, param4:String = null, param5:Object = null) : void
      {
      }
      
      public function trackSocial(param1:String, param2:String, param3:String = null, param4:Object = null) : void
      {
      }
      
      public function setAdvertisingIdCollectionEnabled(param1:Boolean) : void
      {
      }
   }
}

