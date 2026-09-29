package com.milkmangames.nativeextensions
{
   import flash.events.EventDispatcher;
   
   public class RateBox extends EventDispatcher
   {
      
      private static var _instance:RateBox;
      
      private static var _isCreating:Boolean;
      
      public static const VERSION:String = "2.3.0";
      
      private var message:String;
      
      private var rateNowLabel:String;
      
      private var declineLabel:String;
      
      private var neverAgainLabel:String;
      
      private var minLaunchesTilPrompt:int;
      
      private var minEventsTilPrompt:int;
      
      private var minDaysToPrompt:int;
      
      private var coolDownDays:int;
      
      public function RateBox(param1:String, param2:String, param3:String, param4:String = "Rate Now", param5:String = "Not now", param6:String = "Don\'t ask again", param7:int = 3, param8:int = 0, param9:int = 0, param10:int = 1)
      {
         super();
         if(!_isCreating)
         {
            throw new Error("Use RateBox.create() instead of \'new RateBox()\'.");
         }
         this.message = param3;
         this.rateNowLabel = param4;
         this.neverAgainLabel = this.neverAgainLabel;
         this.minLaunchesTilPrompt = param7;
         this.minEventsTilPrompt = param8;
         this.minDaysToPrompt = this.minDaysToPrompt;
      }
      
      public static function isSupported() : Boolean
      {
         return false;
      }
      
      public static function create(param1:String, param2:String, param3:String, param4:String = "Rate Now", param5:String = "Not now", param6:String = "Don\'t ask again", param7:int = 3, param8:int = 0, param9:int = 0, param10:int = 1) : RateBox
      {
         if(_instance != null)
         {
            throw new Error("RateBox already initiated; use RateBox.rateBox to get instance.");
         }
         _isCreating = true;
         _instance = new RateBox(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         _isCreating = false;
         return _instance;
      }
      
      public static function get rateBox() : RateBox
      {
         if(_instance != null)
         {
            return _instance;
         }
         throw new Error("RateBox not initialized; call RateBox.create() first.");
      }
      
      public function setAutoPrompt(param1:Boolean = true) : void
      {
      }
      
      public function setUseInlineStoreView(param1:Boolean) : void
      {
      }
      
      public function useTestMode() : void
      {
      }
      
      public function useAmazonAppStore() : void
      {
      }
      
      public function gotoRatingsNow() : void
      {
      }
      
      public function recordCustomLaterButtonPress() : void
      {
      }
      
      public function recordCustomNeverButtonPress() : void
      {
      }
      
      public function onLaunch() : Boolean
      {
         return false;
      }
      
      public function showRatingPrompt(param1:String, param2:String, param3:String = "Rate It Now", param4:String = "Not now", param5:String = "Don\'t ask again") : void
      {
      }
      
      public function areRatingConditionsMet() : Boolean
      {
         return false;
      }
      
      public function didRateCurrentVersion() : Boolean
      {
         return false;
      }
      
      public function incrementEventCount() : Boolean
      {
         return false;
      }
      
      public function resetConditions() : void
      {
      }
   }
}

