package com.milkmangames.nativeextensions
{
   import flash.events.EventDispatcher;
   
   public class GAnalytics extends EventDispatcher
   {
      
      private static var _instance:GAnalytics;
      
      private static var _isCreating:Boolean;
      
      internal static var _isTrackerCreating:Boolean;
      
      private static var defaultTrackerID:String;
      
      private static var _defaultTracker:GATracker;
      
      private static var _customTrackers:Object;
      
      public static const VERSION:String = "2.4.0";
      
      public function GAnalytics(param1:String)
      {
         var defaultID:String = param1;
         super();
         if(!_isCreating)
         {
            throw new Error("Use GAnalytrics.create() instead of \'new GAnalytrics()\'.");
         }
         try
         {
            defaultTrackerID = defaultID;
            _isTrackerCreating = true;
            _defaultTracker = new GATracker(defaultTrackerID,this);
            _customTrackers = {};
            _customTrackers[defaultTrackerID] = _defaultTracker;
            _isTrackerCreating = false;
         }
         catch(e:Error)
         {
            throw new Error("Error initializing GAnalytrics protocol.");
         }
      }
      
      public static function isSupported() : Boolean
      {
         return false;
      }
      
      public static function create(param1:String) : GAnalytics
      {
         if(_instance != null)
         {
            throw new Error("GAnalytrics already initiated; use GAnalytrics.analytics to get instance.");
         }
         _isCreating = true;
         _instance = new GAnalytics(param1);
         _isCreating = false;
         return _instance;
      }
      
      public static function get analytics() : GAnalytics
      {
         if(_instance != null)
         {
            return _instance;
         }
         throw new Error("GAnalytrics not initialized; call GAnalytrics.create() first.");
      }
      
      public function forceDispatchHits() : void
      {
      }
      
      public function getOptOut() : Boolean
      {
         return false;
      }
      
      public function setOptOut(param1:Boolean) : void
      {
      }
      
      public function getDryRun() : Boolean
      {
         return false;
      }
      
      public function setDryRun(param1:Boolean) : void
      {
      }
      
      public function get defaultTracker() : GATracker
      {
         return _defaultTracker;
      }
      
      public function getTracker(param1:String) : GATracker
      {
         if(_customTrackers[param1])
         {
            return _customTrackers[param1];
         }
         _isTrackerCreating = true;
         var _loc2_:GATracker = new GATracker(param1,this);
         _isTrackerCreating = false;
         _customTrackers[param1] = _loc2_;
         return _loc2_;
      }
      
      public function getInstallReferrer() : String
      {
         return null;
      }
   }
}

