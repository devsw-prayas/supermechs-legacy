package net.battleMechsMulti.managers.ads
{
   import com.supersonic.adobeair.Supersonic;
   import flash.display.MovieClip;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.system.Capabilities;
   
   public class BMSupersonicManager extends EventDispatcher implements IBMAdsManager
   {
      
      private static const ANDROID_KEY:String = "50023fad";
      
      private static const IOS_KEY:String = "5086d71d";
      
      private static const STATE_NULL:String = "STATE_NULL";
      
      private static const STATE_INITIALIZING:String = "STATE_INITIALIZING";
      
      private static const STATE_INITIALIZED:String = "STATE_INITIALIZED";
      
      private static const STATE_READY:String = "STATE_READY";
      
      private static const STATE_LOADING:String = "STATE_LOADING";
      
      private static const STATE_LOADING_TO_SHOW:String = "STATE_LOADING_TO_SHOW";
      
      private static const STATE_SHOWING:String = "STATE_SHOWING";
      
      private var interstitialState:String = "STATE_NULL";
      
      public function BMSupersonicManager()
      {
         super();
         TsLogger.log("BMSupersonicManager::ctor");
         Supersonic.instance.addEventListener("onInterstitialInitSuccess",this.onInterstitialInitSuccess);
         Supersonic.instance.addEventListener("onInterstitialInitFailed",this.onInterstitialInitFailed);
         Supersonic.instance.addEventListener("onInterstitialReady",this.onInterstitialReady);
         Supersonic.instance.addEventListener("onInterstitialLoadFailed",this.onInterstitialLoadFailed);
         Supersonic.instance.addEventListener("onInterstitialOpen",this.onInterstitialOpen);
         Supersonic.instance.addEventListener("onInterstitialClose",this.onInterstitialClose);
         Supersonic.instance.addEventListener("onInterstitialShowSuccess",this.onInterstitialShowSuccess);
         Supersonic.instance.addEventListener("onInterstitialShowFailed",this.onInterstitialShowFailed);
         Supersonic.instance.addEventListener("onInterstitialClick",this.onInterstitialClick);
         this.interstitialState = STATE_NULL;
         Supersonic.instance.addEventListener("onRewardedVideoAdRewarded",this.onRewardedVideoAdRewarded);
         Supersonic.instance.addEventListener("onRewardedVideoShowFail",this.onRewardedVideoShowFail);
         Supersonic.instance.addEventListener("onRewardedVideoInitSuccess",this.onRewardedVideoInitSuccess);
         Supersonic.instance.addEventListener("onRewardedVideoInitFail",this.onRewardedVideoInitFail);
         Supersonic.instance.addEventListener("onVideoAvailabilityChanged",this.onVideoAvailabilityChanged);
      }
      
      public function getKey() : String
      {
         if(Capabilities.os.indexOf("iPhone") > -1 || Capabilities.os.indexOf("iPod") > -1 || Capabilities.os.indexOf("iPad") > -1)
         {
            return IOS_KEY;
         }
         return ANDROID_KEY;
      }
      
      public function init(param1:MovieClip, param2:String) : void
      {
         TsLogger.log("BMSupersonicManager::init udid:" + param2);
         this.initRewardedVideo(param2);
         this.initInterstitial(param2);
      }
      
      public function isInterstitialAvailable() : Boolean
      {
         return this.interstitialState != STATE_NULL;
      }
      
      private function initInterstitial(param1:String) : void
      {
         var _loc2_:* = this.getKey();
         TsLogger.log("BMSupersonicManager: initInterstitial key:" + _loc2_);
         this.interstitialState = STATE_INITIALIZING;
         Supersonic.instance.initInterstitial(_loc2_,param1);
      }
      
      private function onInterstitialInitSuccess(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialInitSuccess " + param1.data);
         if(this.interstitialState == STATE_LOADING_TO_SHOW)
         {
            this.loadInterstitial();
            this.interstitialState = STATE_LOADING_TO_SHOW;
            return;
         }
         this.loadInterstitial();
      }
      
      private function onInterstitialInitFailed(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialInitFailed " + param1.data);
         if(this.interstitialState == STATE_LOADING_TO_SHOW)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         this.interstitialState = STATE_NULL;
      }
      
      public function loadInterstitial() : void
      {
         TsLogger.log("BMSupersonicManager: loadInterstitial");
         if(this.interstitialState == STATE_NULL)
         {
            TsLogger.log("BMSupersonicManager: loadInterstitial error: Supersonic not initialized");
            return;
         }
         this.interstitialState = STATE_LOADING;
         Supersonic.instance.loadInterstitial();
      }
      
      private function onInterstitialReady(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialReady " + param1.data);
         if(this.interstitialState == STATE_LOADING_TO_SHOW)
         {
            this.interstitialState = STATE_READY;
            this.showInterstitial();
         }
         this.interstitialState = STATE_READY;
      }
      
      private function onInterstitialLoadFailed(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialLoadFailed " + param1.data);
         if(this.interstitialState == STATE_LOADING_TO_SHOW)
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         this.interstitialState = STATE_INITIALIZED;
      }
      
      public function showInterstitial() : void
      {
         TsLogger.log("BMSupersonicManager: showInterstitial");
         if(this.interstitialState == STATE_NULL)
         {
            TsLogger.log("BMSupersonicManager: loadInterstitial error: Supersonic not initialized");
            dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
            return;
         }
         if(this.interstitialState == STATE_INITIALIZING)
         {
            this.interstitialState = STATE_LOADING_TO_SHOW;
            return;
         }
         if(this.interstitialState != STATE_READY)
         {
            this.loadInterstitial();
            this.interstitialState = STATE_LOADING_TO_SHOW;
            return;
         }
         this.interstitialState = STATE_SHOWING;
         Supersonic.instance.showInterstitial();
      }
      
      internal function onInterstitialOpen(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialOpen " + param1.data);
      }
      
      internal function onInterstitialClose(param1:Object) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialClose " + param1.data);
         this.interstitialState = STATE_READY;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function onInterstitialShowFailed(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialShowFailed " + param1.data);
         this.interstitialState = STATE_READY;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      internal function onInterstitialClick(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialClick " + param1.data);
      }
      
      internal function onInterstitialShowSuccess(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialShowSuccess " + param1.data);
      }
      
      private function initRewardedVideo(param1:String) : void
      {
         var _loc2_:* = this.getKey();
         TsLogger.log("BMSupersonicManager: initRewardedVideo key:" + _loc2_);
         Supersonic.instance.initRewardedVideo(_loc2_,param1);
      }
      
      public function isRewardedVideoAvailable(param1:String) : Boolean
      {
         var _loc2_:Boolean = Boolean(Supersonic.instance.isRewardedVideoAvailable()) && !Supersonic.instance.isRewardedVideoPlacementCapped(param1);
         TsLogger.log("BMSupersonicManager: isRewardedVideoAvailable " + param1 + ":" + _loc2_);
         return _loc2_;
      }
      
      public function showRewardedVideo(param1:String) : void
      {
         TsLogger.log("BMSupersonicManager: showRewardedVideo placementName:" + param1);
         if(!this.isRewardedVideoAvailable(param1))
         {
            dispatchEvent(new Event(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL));
            return;
         }
         Supersonic.instance.showRewardedVideo(param1);
      }
      
      public function setTest(param1:Boolean) : void
      {
      }
      
      internal function onRewardedVideoInitSuccess(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoInitSuccess " + param1.data);
      }
      
      internal function onRewardedVideoInitFail(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoInitFail " + param1.data);
      }
      
      internal function onVideoAvailabilityChanged(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onVideoAvailabilityChanged " + param1.data);
      }
      
      internal function onRewardedVideoAdRewarded(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoAdRewarded " + param1.data);
         dispatchEvent(new Event(BMAdsManagerEvents.ON_REWARDED_VIDEO_AD_REWARDED));
      }
      
      internal function onRewardedVideoShowFail(param1:DataEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoShowFail " + param1.data);
         dispatchEvent(new Event(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL));
      }
   }
}

