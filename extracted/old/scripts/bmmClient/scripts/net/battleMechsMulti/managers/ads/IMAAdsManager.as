package net.battleMechsMulti.managers.ads
{
   import com.google.ads.ima.api.AdErrorEvent;
   import com.google.ads.ima.api.AdEvent;
   import com.google.ads.ima.api.AdsLoader;
   import com.google.ads.ima.api.AdsManager;
   import com.google.ads.ima.api.AdsManagerLoadedEvent;
   import com.google.ads.ima.api.AdsRenderingSettings;
   import com.google.ads.ima.api.AdsRequest;
   import com.google.ads.ima.api.ViewModes;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class IMAAdsManager extends EventDispatcher implements IBMAdsManager
   {
      
      private static const TAG:String = "http://googleads.g.doubleclick.net/pagead/ads?ad_type=video_image&client=ca-games-pub-9207926024340530&description_url=http%3A%2F%2Fwww.supermechs.com&videoad_start_delay=30000&hl=en&max_ad_duration=30000";
      
      private var _adsLoader:AdsLoader;
      
      private var _adsManager:AdsManager;
      
      private var _parent:MovieClip;
      
      private var _isTest:Boolean = false;
      
      private var _showInterstitialCounter:int = 0;
      
      public function IMAAdsManager()
      {
         super();
         TsLogger.log("IMAAdsManager::ctor");
      }
      
      public function init(param1:MovieClip, param2:String) : void
      {
         TsLogger.log("IMAAdsManager::init " + param1);
         this._parent = param1;
         this.initAdsLoader();
      }
      
      public function isInterstitialAvailable() : Boolean
      {
         return true;
      }
      
      public function loadInterstitial() : void
      {
         if(this._adsManager == null)
         {
            this.requestAds();
         }
      }
      
      public function showInterstitial() : void
      {
         if(this._adsManager == null)
         {
            TsLogger.log("IMAAdsManager::showInterstitial not ready");
            this.requestAds();
            dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
         }
         else if(this._showInterstitialCounter <= 0)
         {
            this._showInterstitialCounter = 4;
            TsLogger.log("IMAAdsManager::showInterstitial show");
            this._parent.addChild(this._adsManager.adsContainer);
            this._adsManager.start();
         }
         else
         {
            TsLogger.log("IMAAdsManager::showInterstitial counting " + this._showInterstitialCounter);
            dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
         }
         --this._showInterstitialCounter;
      }
      
      public function isRewardedVideoAvailable(param1:String) : Boolean
      {
         return false;
      }
      
      public function showRewardedVideo(param1:String) : void
      {
         dispatchEvent(new Event(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL));
      }
      
      public function setTest(param1:Boolean) : void
      {
         TsLogger.log("IMAAdsManager::setTest " + param1);
         this._isTest = param1;
      }
      
      private function initAdsLoader() : void
      {
         if(this._adsLoader == null)
         {
            this._adsLoader = new AdsLoader();
            this._adsLoader.loadSdk();
            this._adsLoader.addEventListener(AdsManagerLoadedEvent.ADS_MANAGER_LOADED,this.adsManagerLoadedHandler);
            this._adsLoader.addEventListener(AdErrorEvent.AD_ERROR,this.adsLoadErrorHandler);
         }
      }
      
      private function requestAds() : void
      {
         TsLogger.log("IMAAdsManager.requestAds " + this._parent);
         var _loc1_:AdsRequest = new AdsRequest();
         if(this._isTest)
         {
            _loc1_.adTagUrl = TAG + "&adtest=on";
         }
         else
         {
            _loc1_.adTagUrl = TAG;
         }
         _loc1_.linearAdSlotWidth = this._parent.stage.stageWidth;
         _loc1_.linearAdSlotHeight = this._parent.stage.stageHeight;
         _loc1_.nonLinearAdSlotWidth = this._parent.stage.stageWidth;
         _loc1_.nonLinearAdSlotHeight = this._parent.stage.stageHeight;
         this._adsLoader.requestAds(_loc1_);
      }
      
      private function adsManagerLoadedHandler(param1:AdsManagerLoadedEvent) : void
      {
         var adsRenderingSettings:AdsRenderingSettings;
         var contentPlayhead:Object;
         var event:AdsManagerLoadedEvent = param1;
         TsLogger.log("IMAAdsManager.adsManagerLoadedHandler");
         adsRenderingSettings = new AdsRenderingSettings();
         contentPlayhead = {};
         contentPlayhead.time = function():Number
         {
            return 0;
         };
         this._adsManager = event.getAdsManager(contentPlayhead,adsRenderingSettings);
         if(this._adsManager)
         {
            this._adsManager.addEventListener(AdEvent.ALL_ADS_COMPLETED,this.allAdsCompletedHandler);
            this._adsManager.addEventListener(AdEvent.CONTENT_PAUSE_REQUESTED,this.contentPauseRequestedHandler);
            this._adsManager.addEventListener(AdEvent.CONTENT_RESUME_REQUESTED,this.contentResumeRequestedHandler);
            this._adsManager.addEventListener(AdErrorEvent.AD_ERROR,this.adsManagerPlayErrorHandler);
            this._adsManager.handshakeVersion("1.0");
            this._adsManager.init(this._parent.stage.stageWidth,this._parent.stage.stageHeight,ViewModes.FULLSCREEN);
         }
      }
      
      private function adsLoadErrorHandler(param1:AdErrorEvent) : void
      {
         TsLogger.log("IMAAdsManager.adsLoadErrorHandler Ads load error: " + param1.error.errorMessage);
         this.destroyAdsManager();
         dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
      }
      
      private function adsManagerPlayErrorHandler(param1:AdErrorEvent) : void
      {
         TsLogger.log("IMAAdsManager.adsManagerPlayErrorHandler Ad playback error: " + param1.error.errorMessage);
         this.destroyAdsManager();
         dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
      }
      
      private function allAdsCompletedHandler(param1:AdEvent) : void
      {
         TsLogger.log("IMAAdsManager.allAdsCompletedHandler");
         this.destroyAdsManager();
      }
      
      private function contentPauseRequestedHandler(param1:AdEvent) : void
      {
         TsLogger.log("IMAAdsManager.contentPauseRequestedHandler");
      }
      
      private function contentResumeRequestedHandler(param1:AdEvent) : void
      {
         TsLogger.log("IMAAdsManager.contentResumeRequestedHandler");
         this.destroyAdsManager();
         dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
      }
      
      private function destroyAdsManager() : void
      {
         if(this._adsManager)
         {
            this._adsManager.removeEventListener(AdEvent.ALL_ADS_COMPLETED,this.allAdsCompletedHandler);
            this._adsManager.removeEventListener(AdEvent.CONTENT_PAUSE_REQUESTED,this.contentPauseRequestedHandler);
            this._adsManager.removeEventListener(AdEvent.CONTENT_RESUME_REQUESTED,this.contentResumeRequestedHandler);
            this._adsManager.removeEventListener(AdErrorEvent.AD_ERROR,this.adsManagerPlayErrorHandler);
            if(Boolean(this._adsManager.adsContainer.parent) && this._adsManager.adsContainer.parent.contains(this._adsManager.adsContainer))
            {
               this._adsManager.adsContainer.parent.removeChild(this._adsManager.adsContainer);
            }
            this._adsManager.destroy();
         }
         this._adsManager = null;
      }
   }
}

