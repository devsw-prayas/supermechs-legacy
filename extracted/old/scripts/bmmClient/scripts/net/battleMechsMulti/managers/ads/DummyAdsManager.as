package net.battleMechsMulti.managers.ads
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DummyAdsManager extends EventDispatcher implements IBMAdsManager
   {
      
      public function DummyAdsManager()
      {
         super();
      }
      
      public function init(param1:MovieClip, param2:String) : void
      {
      }
      
      public function isInterstitialAvailable() : Boolean
      {
         return false;
      }
      
      public function showInterstitial() : void
      {
         dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
      }
      
      public function isRewardedVideoAvailable(param1:String) : Boolean
      {
         return false;
      }
      
      public function showRewardedVideo(param1:String) : void
      {
         dispatchEvent(new Event(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL));
      }
      
      public function loadInterstitial() : void
      {
      }
      
      public function setTest(param1:Boolean) : void
      {
      }
   }
}

