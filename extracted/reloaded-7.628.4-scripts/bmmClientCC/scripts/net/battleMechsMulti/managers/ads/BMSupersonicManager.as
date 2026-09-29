package net.battleMechsMulti.managers.ads
{
   import com.distriqt.extension.ironsource.IronSource;
   import com.distriqt.extension.ironsource.events.InterstitialAdEvent;
   import com.distriqt.extension.ironsource.events.RewardedVideoAdEvent;
   import flash.desktop.NativeApplication;
   import flash.display.MovieClip;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.system.Capabilities;
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class BMSupersonicManager extends EventDispatcher implements IBMAdsManager
   {
      
      private static const ANDROID_KEY:String = "50023fad";
      
      private static const IOS_KEY:String = "5086d71d";
      
      private static const INTERSTITIAL_PLACEMENT_NAME:String = "DefaultInterstitial";
      
      private static const STATE_NULL:String = "STATE_NULL";
      
      private static const STATE_INITIALIZING:String = "STATE_INITIALIZING";
      
      private static const STATE_INITIALIZED:String = "STATE_INITIALIZED";
      
      private static const STATE_READY:String = "STATE_READY";
      
      private static const STATE_LOADING:String = "STATE_LOADING";
      
      private static const STATE_LOADING_TO_SHOW:String = "STATE_LOADING_TO_SHOW";
      
      private static const STATE_SHOWING:String = "STATE_SHOWING";
      
      private var _initUserID:int = 0;
      
      private var _initializedIronsource:Boolean = false;
      
      private var hadUnexpectedFailure:Boolean = false;
      
      private var interstitialState:String = "STATE_NULL";
      
      private var didRewardLastRewardedVideo:Boolean = false;
      
      public function BMSupersonicManager()
      {
         super();
         TsLogger.log("BMSupersonicManager::ctor");
         IronSource.instance.addEventListener("onInterstitialInitSuccess",this.onInterstitialInitSuccess);
         IronSource.instance.addEventListener("onInterstitialInitFailed",this.onInterstitialInitFailed);
         IronSource.instance.addEventListener(InterstitialAdEvent.READY,this.onInterstitialReady);
         IronSource.instance.addEventListener(InterstitialAdEvent.FAILED,this.onInterstitialLoadFailed);
         IronSource.instance.addEventListener(InterstitialAdEvent.OPENED,this.onInterstitialOpen);
         IronSource.instance.addEventListener(InterstitialAdEvent.CLOSED,this.onInterstitialClose);
         IronSource.instance.addEventListener(InterstitialAdEvent.SHOW_SUCCEEDED,this.onInterstitialShowSuccess);
         IronSource.instance.addEventListener(InterstitialAdEvent.SHOW_FAILED,this.onInterstitialShowFailed);
         IronSource.instance.addEventListener(InterstitialAdEvent.CLICKED,this.onInterstitialClick);
         this.interstitialState = STATE_NULL;
         this.hadUnexpectedFailure = false;
         IronSource.instance.addEventListener(RewardedVideoAdEvent.OPENED,this.onRewardedVideoAdOpened);
         IronSource.instance.addEventListener(RewardedVideoAdEvent.CLOSED,this.onRewardedVideoAdClosed);
         IronSource.instance.addEventListener(RewardedVideoAdEvent.STARTED,this.onRewardedVideoAdStarted);
         IronSource.instance.addEventListener(RewardedVideoAdEvent.ENDED,this.onRewardedVideoAdEnded);
         IronSource.instance.addEventListener(RewardedVideoAdEvent.REWARDED,this.onRewardedVideoAdRewarded);
         IronSource.instance.addEventListener(RewardedVideoAdEvent.SHOW_FAILED,this.onRewardedVideoShowFail);
         IronSource.instance.addEventListener("onRewardedVideoInitSuccess",this.onRewardedVideoInitSuccess);
         IronSource.instance.addEventListener("onRewardedVideoInitFail",this.onRewardedVideoInitFail);
         IronSource.instance.addEventListener(RewardedVideoAdEvent.AVAILABILITY_CHANGED,this.onVideoAvailabilityChanged);
         IronSource.instance.addEventListener(RewardedVideoAdEvent.CLICKED,this.onRewardedVideoClicked);
         NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE,this.onAppDeactivate);
         NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,this.onAppActivate);
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
      }
      
      private function initIronSourceIfNeeded() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(!this._initializedIronsource)
         {
            this._initUserID = BMDataManager.getInstance().userID;
            _loc1_ = this._initUserID.toString();
            _loc2_ = this.getKey();
            TsLogger.log("BMSupersonicManager::init udid:" + _loc1_ + ", key:" + _loc2_ + ", isid:" + IronSource.instance.getAdvertiserId() + ", uid:" + this._initUserID);
            IronSource.instance.setMetaData("is_deviceid_optout","true");
            IronSource.instance.setMetaData("is_child_directed","true");
            IronSource.instance.setMetaData("Chartboost_Coppa","true");
            IronSource.instance.setConsent(false);
            IronSource.instance.setDynamicUserId(this._initUserID.toString());
            IronSource.instance.init(_loc2_,[IronSource.REWARDED_VIDEO,IronSource.INTERSTITIAL]);
            IronSource.instance.setMetaData("is_deviceid_optout","true");
            IronSource.instance.setMetaData("is_child_directed","true");
            IronSource.instance.setMetaData("Chartboost_Coppa","true");
            IronSource.instance.setConsent(false);
            this.initRewardedVideo(_loc1_);
            this.initInterstitial(_loc1_);
            this._initializedIronsource = true;
         }
      }
      
      public function isInterstitialAvailable() : Boolean
      {
         this.initIronSourceIfNeeded();
         return !this.hadUnexpectedFailure && this.interstitialState != STATE_NULL && Boolean(IronSource.instance.isInterstitialReady());
      }
      
      private function initInterstitial(param1:String) : void
      {
         this.interstitialState = STATE_INITIALIZING;
         this.onInterstitialInitSuccess(new DataEvent("None"));
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
            dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
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
         IronSource.instance.loadInterstitial();
      }
      
      private function onInterstitialReady(param1:InterstitialAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialReady " + param1.data);
         if(this.interstitialState == STATE_LOADING_TO_SHOW)
         {
            this.interstitialState = STATE_READY;
            this.showInterstitial();
         }
         this.interstitialState = STATE_READY;
      }
      
      private function onInterstitialLoadFailed(param1:InterstitialAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialLoadFailed " + param1.data);
         if(this.interstitialState == STATE_LOADING_TO_SHOW)
         {
            dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
         }
         this.interstitialState = STATE_INITIALIZED;
      }
      
      public function showInterstitial() : void
      {
         TsLogger.log("BMSupersonicManager: showInterstitial");
         this.initIronSourceIfNeeded();
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
         IronSource.instance.showInterstitial(INTERSTITIAL_PLACEMENT_NAME);
      }
      
      internal function onInterstitialOpen(param1:InterstitialAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialOpen " + param1.data);
      }
      
      internal function onInterstitialClose(param1:InterstitialAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialClose " + param1.data);
         this.interstitialState = STATE_READY;
         dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
      }
      
      internal function onInterstitialShowFailed(param1:InterstitialAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialShowFailed " + param1.data);
         this.interstitialState = STATE_READY;
         this.hadUnexpectedFailure = true;
         dispatchEvent(new Event(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE));
      }
      
      internal function onInterstitialClick(param1:InterstitialAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialClick " + param1.data);
      }
      
      internal function onInterstitialShowSuccess(param1:InterstitialAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onInterstitialShowSuccess " + param1.data);
      }
      
      private function initRewardedVideo(param1:String) : void
      {
      }
      
      public function isRewardedVideoAvailable(param1:String) : Boolean
      {
         var _loc3_:Boolean = false;
         this.initIronSourceIfNeeded();
         var _loc2_:Boolean = BMDataManager.getInstance().userID == this._initUserID;
         _loc3_ = !this.hadUnexpectedFailure && _loc2_ && Boolean(IronSource.instance.isRewardedVideoAvailable()) && !IronSource.instance.isRewardedVideoCappedForPlacement(param1);
         TsLogger.log("BMSupersonicManager: isRewardedVideoAvailable " + param1 + ":" + _loc3_);
         return _loc3_;
      }
      
      public function showRewardedVideo(param1:String) : void
      {
         TsLogger.log("BMSupersonicManager: showRewardedVideo placementName:" + param1);
         this.initIronSourceIfNeeded();
         if(!this.isRewardedVideoAvailable(param1))
         {
            dispatchEvent(new Event(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL));
            return;
         }
         this.didRewardLastRewardedVideo = false;
         IronSource.instance.showRewardedVideo(param1);
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
      
      internal function onVideoAvailabilityChanged(param1:RewardedVideoAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onVideoAvailabilityChanged " + param1.data);
      }
      
      internal function onRewardedVideoClicked(param1:RewardedVideoAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoClicked " + param1.data);
      }
      
      internal function onRewardedVideoAdRewarded(param1:RewardedVideoAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoAdRewarded " + param1.data);
         if(!this.didRewardLastRewardedVideo)
         {
            this.didRewardLastRewardedVideo = true;
            dispatchEvent(new Event(BMAdsManagerEvents.ON_REWARDED_VIDEO_AD_REWARDED));
         }
      }
      
      internal function onRewardedVideoShowFail(param1:RewardedVideoAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoShowFail " + param1.data);
         this.hadUnexpectedFailure = true;
         dispatchEvent(new Event(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL));
      }
      
      internal function onRewardedVideoAdOpened(param1:RewardedVideoAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoAdOpened " + param1.data);
      }
      
      internal function onRewardedVideoAdClosed(param1:RewardedVideoAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoAdClosed " + param1.data);
      }
      
      internal function onRewardedVideoAdStarted(param1:RewardedVideoAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoAdStarted " + param1.data);
      }
      
      internal function onRewardedVideoAdEnded(param1:RewardedVideoAdEvent) : void
      {
         TsLogger.log("BMSupersonicManager: onRewardedVideoAdEnded " + param1.data);
      }
      
      internal function onAppDeactivate(param1:Event) : void
      {
         TsLogger.log("BMSupersonicManager :: onAppDeactivate()");
         IronSource.instance.onPause();
      }
      
      internal function onAppActivate(param1:Event) : void
      {
         TsLogger.log("BMSupersonicManager :: onAppActivate()");
         IronSource.instance.onResume();
      }
   }
}

