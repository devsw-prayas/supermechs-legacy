package net.battleMechsMulti.managers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.UncaughtErrorEvent;
   import flash.net.LocalConnection;
   import flash.net.SharedObject;
   import libraries.uanalytics.utils.generateUUID;
   import net.battleMechsMulti.managers.ads.BMAdsManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.utils.LongPressListener;
   
   [SWF(width="800", height="480", backgroundColor="#000000", frameRate="30")]
   public dynamic class BMClient extends BMBaseClass
   {
      
      public static const DISTRIQT_KEY:String = "ed75f83577763bd3f9f5172cb3d122f5722f6efcWJSYc0WoeK+AKHf7GwcD0Dtx1FyFVzvJvEmBMqKzOShmmtmoDQ/BtW/usm0cctn6XTAQm/zPI9hqBfRfggMQ8P0aiEVPHcGHNPr1JCmKMZTmzSvP49/15YfyrVtazbrqihts+DUvC7t5q1g8vYnhf5EKVH4n8FNu9/NsF/chpi2EM9EOCrIk/aAF2dpuhP1Wx5vjMhL+mzvhQsg2IcqyrfROk+aCxPvefCr12+673a+8rlZ9hNF4HWJw2UNcS/gMXwjOKmnfW9num6516CTXltxVeKASTpbKVIXltAuzlH1Mew8kLa/iVg7f/aRle2nIGzFm+7B5Pwywon52oNeSag==";
      
      public static const PERMISSION_GET_ACCOUNTS:String = "android.permission.GET_ACCOUNTS";
      
      public var iosBackground:MovieClip;
      
      public var loadedFromLoader:Boolean = false;
      
      public var loadedFromGlobalLoader:Boolean = false;
      
      public var sessionManager:BMSessionManager;
      
      public var launchScreen:Sprite;
      
      public var mcMainHolder:Sprite;
      
      public var storeKitAvailable:Boolean = false;
      
      public var androidStoreKitAvailable:Boolean = false;
      
      public var mcClientMobileBorders:Sprite;
      
      private var onStage:Boolean = false;
      
      private var loadingComplete:Boolean = false;
      
      private var swfInited:Boolean = false;
      
      private var iosWait:uint = 0;
      
      public function BMClient()
      {
         super();
         loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.onUncaughtError);
         BMAdsManager.gi().init(this,GetUUID());
         TsLogger.log("preInit");
         this.initialize();
      }
      
      public static function GetUUID() : String
      {
         var _loc1_:SharedObject = SharedObject.getLocal("ClientParams","/");
         if(_loc1_.data.udid == undefined)
         {
            _loc1_.data.udid = generateUUID();
            _loc1_.flush();
         }
         return _loc1_.data.udid;
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
      }
      
      private function initialize() : void
      {
         TsLogger.log("BMClient initialized");
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         this.loaderInfo.addEventListener(Event.COMPLETE,this.swfLoadComplete);
         this.loaderInfo.addEventListener(Event.INIT,this.swfInit);
         this.mcClientMobileBorders.parent.removeChild(this.mcClientMobileBorders);
         this.mcClientMobileBorders = null;
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
         setChildIndex(this.launchScreen,numChildren - 1);
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
         this.onStage = true;
         var _loc2_:BMMClientFlashVars = new BMMClientFlashVars(GlobalAccess.stage);
         GlobalAccess.mcamp_id = _loc2_.mcamp_id;
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
         remoteM.initialize();
         languageM.initialize();
         dataM.initialize();
         TsLogger.log("Setting up session manager");
         this.sessionManager = new BMSessionManager();
         this.sessionManager.initialize();
         TsLogger.log("Set up session manager");
         screensM.initialize(this);
         draggingM.initialize();
         effectsM.initialize();
         tooltip.initialize();
         soundM.initialize();
         keyboardM.initialize();
         screensM.setStagePointer(GlobalAccess.stage);
         keyboardM.setStagePointer(GlobalAccess.stage);
         addChild(screensM);
         addChild(draggingM);
         addChild(tooltip);
         this.setLaunchScreenDepth();
      }
      
      private function doIOSFollowUp(param1:Event) : void
      {
      }
      
      public function goFullScreen() : void
      {
         TsLogger.log("FULL_SCREEN");
      }
      
      private function setupLongPressSendsDebugLog() : void
      {
         var longPressListener:LongPressListener = new LongPressListener(this.mcMainHolder,20 * 1000);
         longPressListener.addEventListener(LongPressListener.EVENT_LONG_PRESS,function():*
         {
            screensM.screenConfirmation.displayCustomYesNoQuestion("Do you want to send a debug log?",function(param1:Boolean):*
            {
               if(param1)
               {
                  dataM.emailSupport("Debug Log");
               }
            });
         });
      }
   }
}

