package net.battleMechsMulti.managers
{
   import com.distriqt.extension.application.Application;
   import com.distriqt.extension.application.display.DisplayMode;
   import com.distriqt.extension.permissions.Permissions;
   import flash.desktop.InvokeEventReason;
   import flash.desktop.NativeApplication;
   import flash.desktop.SystemIdleMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageQuality;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.InvokeEvent;
   import flash.events.KeyboardEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.net.LocalConnection;
   import flash.net.SharedObject;
   import flash.text.StageText;
   import flash.ui.Keyboard;
   import libraries.uanalytics.utils.generateUUID;
   import net.battleMechsMulti.events.AndroidStoreEvent;
   import net.battleMechsMulti.managers.ads.BMAdsManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.utils.DelayedFunctionCall;
   import net.tacticsoft.utils.LongPressListener;
   import net.tacticsoft.utils.QueryString;
   
   [SWF(width="800", height="480", backgroundColor="#333333", frameRate="30")]
   public dynamic class BMClient extends BMBaseClass
   {
      
      public static var isInForeground:Boolean = true;
      
      public static const DISTRIQT_KEY:String = "ed75f83577763bd3f9f5172cb3d122f5722f6efcWJSYc0WoeK+AKHf7GwcD0Dtx1FyFVzvJvEmBMqKzOShmmtmoDQ/BtW/usm0cctn6XTAQm/zPI9hqBfRfggMQ8P0aiEVPHcGHNPr1JCmKMZTmzSvP49/15YfyrVtazbrqihts+DUvC7t5q1g8vYnhf5EKVH4n8FNu9/NsF/chpi2EM9EOCrIk/aAF2dpuhP1Wx5vjMhL+mzvhQsg2IcqyrfROk+aCxPvefCr12+673a+8rlZ9hNF4HWJw2UNcS/gMXwjOKmnfW9num6516CTXltxVeKASTpbKVIXltAuzlH1Mew8kLa/iVg7f/aRle2nIGzFm+7B5Pwywon52oNeSag==";
      
      public static const PERMISSION_GET_ACCOUNTS:String = "android.permission.GET_ACCOUNTS";
      
      public static const PERMISSION_WRITE_STORAGE:String = "android.permission.WRITE_EXTERNAL_STORAGE";
      
      public static const PERMISSION_READ_STORAGE:String = "android.permission.READ_EXTERNAL_STORAGE";
      
      public var iosBackground:MovieClip;
      
      public var loadedFromLoader:Boolean = false;
      
      public var loadedFromGlobalLoader:Boolean = false;
      
      public var sessionManager:BMSessionManager;
      
      public var launchScreen:Sprite;
      
      public var mcMainHolder:Sprite;
      
      public var storeKitAvailable:Boolean = false;
      
      public var androidStoreKitAvailable:Boolean = false;
      
      public var mcClientMobileBorders:Sprite;
      
      private var _enterFrameTasks:Vector.<Function> = new Vector.<Function>();
      
      private var onStage:Boolean = false;
      
      private var loadingComplete:Boolean = false;
      
      private var swfInited:Boolean = false;
      
      private var iosWait:uint = 0;
      
      private var longPressListener:LongPressListener;
      
      public var afInterface:AppsFlyerInterface = new AppsFlyerInterface();
      
      public function BMClient()
      {
         super();
         loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.onUncaughtError);
         TsLogger.log("preInit");
         this.initialize();
      }
      
      public static function GetUUID() : String
      {
         var clientParams:SharedObject = SharedObject.getLocal("ClientParams","/");
         if(clientParams.data.udid == undefined)
         {
            clientParams.data.udid = generateUUID();
            try
            {
               clientParams.flush();
            }
            catch(err:Error)
            {
               TsLogger.log("ERROR: shared object couldn\'t flush");
            }
         }
         return clientParams.data.udid;
      }
      
      private function onUncaughtError(param1:UncaughtErrorEvent) : void
      {
         var _loc2_:String = null;
         if(param1.error is Error)
         {
            _loc2_ = Error(param1.error).message + " \n " + Error(param1.error).getStackTrace();
         }
         else if(param1.error is ErrorEvent)
         {
            _loc2_ = ErrorEvent(param1.error).text;
         }
         else
         {
            _loc2_ = param1.error.toString();
         }
         TsLogger.pushLog("UncaughtError:: " + _loc2_);
         BMPubSub.pub(BMPubSub.MESSAGE_UNCAUGHT_ERROR,{"uncaughtErrorEvent":param1});
      }
      
      private function initialize() : void
      {
         var _loc1_:XML = null;
         var _loc2_:Namespace = null;
         var _loc3_:String = null;
         TsLogger.log("BMClient initialized");
         BMDataManager.initCrashHandling();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         this.loaderInfo.addEventListener(Event.COMPLETE,this.swfLoadComplete);
         this.loaderInfo.addEventListener(Event.INIT,this.swfInit);
         TsLogger.log("BMMClient :: initialize() - CONFIG::FOR_ANDROID");
         _loc1_ = NativeApplication.nativeApplication.applicationDescriptor;
         _loc2_ = _loc1_.namespace();
         _loc3_ = _loc1_._loc2_::versionNumber;
         TsLogger.log("BMMClient :: initialize() - Application version: " + _loc3_);
         NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
         NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE,this.onAppDeactivate);
         NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,this.onAppActivate);
         NativeApplication.nativeApplication.addEventListener(Event.EXITING,this.onAppExiting);
         NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE,this.onAppInvoke);
         NativeApplication.nativeApplication.addEventListener(Event.NETWORK_CHANGE,this.onAppNetworkChange);
         NativeApplication.nativeApplication.addEventListener(Event.SUSPEND,this.onAppSuspend);
         NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,this.onAppKey);
         NativeApplication.nativeApplication.executeInBackground = false;
         BMGoogleGamesManager.getInstance();
         if(false)
         {
            this.mcClientMobileBorders.parent.removeChild(this.mcClientMobileBorders);
            this.mcClientMobileBorders = null;
         }
         this.setupLongPressSendsDebugLog();
      }
      
      private function swfInit(param1:Event) : void
      {
         TsLogger.log("BMMClient :: swfInit()");
         this.loaderInfo.removeEventListener(Event.INIT,this.swfInit);
         this.swfInited = true;
         if(this.loadingComplete && this.onStage && this.swfInited)
         {
            this.readyAfterFrame();
         }
      }
      
      private function swfLoadComplete(param1:Event) : void
      {
         TsLogger.log("BMMClient :: swfLoadComplete()");
         this.loaderInfo.removeEventListener(Event.COMPLETE,this.swfLoadComplete);
         this.loadingComplete = true;
         if(this.loadingComplete && this.onStage && this.swfInited)
         {
            this.readyAfterFrame();
         }
         this.setLaunchScreenDepth();
      }
      
      private function setLaunchScreenDepth() : void
      {
      }
      
      private function addedToStage(param1:Event) : void
      {
         stage.stageFocusRect = false;
         TsLogger.log("BMMClient :: addedToStage()");
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         if(parent.parent != null)
         {
            this.loadedFromLoader = true;
         }
         GlobalAccess.loaderInfo = this.loaderInfo;
         GlobalAccess.stage = this.stage;
         GlobalAccess.root = this.root;
         GlobalAccess.stage.quality = StageQuality.LOW;
         Application.service.setStage(stage);
         Application.service.display.setDisplayMode(DisplayMode.IMMERSIVE);
         Application.service.keyboard.init();
         this.onStage = true;
         var _loc2_:BMMClientFlashVars = new BMMClientFlashVars(GlobalAccess.stage);
         GlobalAccess.mcamp_id = _loc2_.mcamp_id;
         if(_loc2_.gift_key != null && _loc2_.gift_key.length > 0)
         {
            BMMarketingManager.addGiftKey(_loc2_.gift_key);
         }
         if(this.loadingComplete && this.onStage && this.swfInited)
         {
            this.readyAfterFrame();
         }
         this.setLaunchScreenDepth();
      }
      
      private function readyAfterFrame() : void
      {
         TsLogger.log("BMMClient :: readyAfterFrame()");
         addEventListener(Event.ENTER_FRAME,this.ready);
      }
      
      public function disconnect() : *
      {
      }
      
      public function reauthenticate() : void
      {
         TsLogger.log("BMMClient :: reauthenticate()");
         this.sessionManager.authenticate();
      }
      
      private function ready(param1:Event = null) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.ready);
         TsLogger.log("BMClient :: ready() - calling generateSingletonClassesPointers(\"\")");
         generateSingletonClassesPointers("");
         var _loc2_:LocalConnection = new LocalConnection();
         var _loc3_:* = _loc2_.domain;
         tutorialM.initialize();
         loginM.initialize();
         remoteM.initialize();
         TsLogger.log("Setting up session manager");
         this.sessionManager = new BMSessionManager();
         this.sessionManager.initialize();
         TsLogger.log("Set up session manager");
         screensM.initialize(this);
         draggingM.initialize();
         effectsM.initialize();
         soundM.initialize();
         keyboardM.initialize();
         screensM.setStagePointer(GlobalAccess.stage);
         keyboardM.setStagePointer(GlobalAccess.stage);
         BMGoogleGamesManager.gi().SetSession(this.sessionManager);
         addChild(screensM);
         addChild(draggingM);
         this.setLaunchScreenDepth();
         this._enterFrameTasks.push(this.initLanguageManager);
         this._enterFrameTasks.push(this.initToolTip);
         this._enterFrameTasks.push(this.initAndroidAppsFlyer);
         this._enterFrameTasks.push(this.initDataManager);
         this._enterFrameTasks.push(this.initAndroidPermissions);
         this._enterFrameTasks.push(this.initAndroidStoreKit);
         this._enterFrameTasks.push(this.initAdsManager);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this._enterFrameTasks.length == 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            return;
         }
         var _loc2_:Function = this._enterFrameTasks.shift();
         _loc2_();
      }
      
      private function initLanguageManager() : void
      {
         languageM.initialize();
      }
      
      private function initDataManager() : void
      {
         dataM.initialize();
      }
      
      private function initAndroidPermissions() : void
      {
         if(Permissions.isSupported)
         {
            Permissions.service.setPermissions([PERMISSION_READ_STORAGE,PERMISSION_WRITE_STORAGE]);
         }
      }
      
      private function initAndroidAppsFlyer() : void
      {
         BMDataManager.getInstance().afInterface = this.afInterface;
         this.afInterface.addEventListener(AppsFlyerEvent.INSTALL_CONVERSATION_DATA_LOADED,BMDataManager.getInstance().onAFConversionData);
         this.afInterface.addEventListener(AppsFlyerEvent.INSTALL_CONVERSATION_FAILED,BMDataManager.getInstance().onAFConversionData);
         this.afInterface.addEventListener(AppsFlyerEvent.ATTRIBUTION_FAILURE,BMDataManager.getInstance().onAFConversionData);
         this.afInterface.addEventListener(AppsFlyerEvent.APP_OPEN_ATTRIBUTION,BMDataManager.getInstance().onAFConversionData);
         this.afInterface.registerConversionListener();
         this.afInterface.setCurrency("USD");
         TsLogger.log("AppsFlyer android setup complete. " + this.afInterface.toString());
      }
      
      private function initAndroidStoreKit() : void
      {
         BMAndroidStoreKitManager.getInstance().addEventListener(AndroidStoreEvent.STOREKIT_UNAVAILABLE,this.androidStoreKitUnavailable);
         BMAndroidStoreKitManager.getInstance().addEventListener(AndroidStoreEvent.PRODUCT_DETAILS_LOADED,this.androidStoreKitReady);
      }
      
      private function initToolTip() : void
      {
         tooltip.initialize();
         addChild(tooltip);
      }
      
      private function initAdsManager() : void
      {
         BMAdsManager.gi().init(this,GetUUID());
      }
      
      private function doIOSFollowUp(param1:Event) : void
      {
      }
      
      public function goFullScreen() : void
      {
         TsLogger.log("FULL_SCREEN");
      }
      
      public function ignoreNextLongPress() : void
      {
         this.longPressListener.ignoreNextRelease();
      }
      
      private function setupLongPressSendsDebugLog() : void
      {
         this.longPressListener = new LongPressListener(this.mcMainHolder,20 * 1000);
         this.longPressListener.addEventListener(LongPressListener.EVENT_LONG_PRESS,function():*
         {
            screensM.screenConfirmation.displayCustomYesNoQuestion("Do you want to send a debug log?",function(param1:Boolean):*
            {
               if(param1)
               {
                  dataM.openSupportForm("Debug Support ");
               }
            });
         });
      }
      
      private function fixTextKeyboard(param1:Stage) : *
      {
         var _loc2_:StageText = new StageText();
         _loc2_.stage = param1;
         _loc2_.assignFocus();
         _loc2_.stage = null;
         _loc2_ = null;
      }
      
      protected function onAppDeactivate(param1:Event) : void
      {
         TsLogger.log("BMMClient :: onAppDeactivate()");
         isInForeground = false;
      }
      
      protected function onAppActivate(param1:Event) : void
      {
         TsLogger.log("BMMClient :: onAppActivate()");
         isInForeground = true;
      }
      
      protected function onAppExiting(param1:Event) : void
      {
         TsLogger.log("BMMClient :: onAppExiting()");
         isInForeground = false;
      }
      
      private function onAppKey(param1:KeyboardEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         if(param1.keyCode == Keyboard.BACK)
         {
            TsLogger.log("BMMClient :: onAppKey BACK");
            param1.preventDefault();
            _loc2_ = screensM.getTargetScreens();
            if(_loc2_.length == 0)
            {
               this.promptAppExit();
               return;
            }
            _loc3_ = screensM[_loc2_[0]];
            if("backClicked" in _loc3_)
            {
               _loc3_.backClicked();
            }
            else
            {
               this.promptAppExit();
            }
         }
      }
      
      private function promptAppExit() : void
      {
         TsLogger.log("BMMClient :: promptAppExit");
         screensM.screenConfirmation.displayCustomYesNoQuestion("Are you sure you want to exit Super Mechs?",this.onPromptAppExit);
      }
      
      private function onPromptAppExit(param1:Boolean) : void
      {
         if(param1)
         {
            NativeApplication.nativeApplication.exit();
         }
      }
      
      protected function onAppInvoke(param1:InvokeEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:QueryString = null;
         var _loc5_:String = null;
         TsLogger.log("BMMClient :: onAppInvoke() - event.reason: " + param1.reason);
         switch(param1.reason)
         {
            case InvokeEventReason.LOGIN:
               TsLogger.log("BMMClient :: onAppInvoke() - InvokeEventReason.LOGIN");
               break;
            case InvokeEventReason.NOTIFICATION:
               TsLogger.log("BMMClient :: onAppInvoke() - InvokeEventReason.NOTIFICATION");
               break;
            case InvokeEventReason.OPEN_URL:
               TsLogger.log("BMMClient :: onAppInvoke() - InvokeEventReason.OPEN_URL");
               _loc3_ = param1.arguments;
               _loc4_ = new QueryString(_loc3_[0]);
               _loc5_ = _loc3_[1];
               this.processAndroidDeepLink(_loc5_,_loc4_);
               break;
            case InvokeEventReason.STANDARD:
            default:
               TsLogger.log("BMMClient :: onAppInvoke() - InvokeEventReason.STANDARD (default)");
         }
      }
      
      private function processAndroidDeepLink(param1:String, param2:QueryString) : *
      {
         var _loc3_:Object = param2.parameters;
         var _loc4_:String = param2.location;
         TsLogger.log("location: " + _loc4_ + " queryString: " + param2.getQueryString);
         if(_loc3_.mcamp_id)
         {
            GlobalAccess.mcamp_id = _loc3_.mcamp_id;
            TsLogger.log("BMMClient :: processAndroidDeepLink() - mcamp_id: " + GlobalAccess.mcamp_id);
         }
      }
      
      protected function onAppNetworkChange(param1:Event) : void
      {
         TsLogger.log("BMMClient :: onAppNetworkChange()");
      }
      
      protected function onAppSuspend(param1:Event) : void
      {
         TsLogger.log("BMMClient :: onAppSuspend()");
      }
      
      protected function androidStoreKitUnavailable(param1:AndroidStoreEvent) : void
      {
         TsLogger.log("BMMClient :: androidStoreKitUnavailable() - Retrying in 10 seconds");
         new DelayedFunctionCall(BMAndroidStoreKitManager.gi().initializeProducts,10000);
      }
      
      protected function androidStoreKitReady(param1:AndroidStoreEvent) : void
      {
         TsLogger.log("BMMClient :: androidStoreKitReady()");
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.STOREKIT_UNAVAILABLE,this.androidStoreKitUnavailable);
         BMAndroidStoreKitManager.gi().removeEventListener(AndroidStoreEvent.PRODUCT_DETAILS_LOADED,this.androidStoreKitReady);
         this.androidStoreKitAvailable = true;
         dataM.syncPlatformStoreProducts();
      }
   }
}

