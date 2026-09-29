package net.battleMechsMulti.managers
{
   import com.greensock.TweenMax;
   import deng.fzip.FZip;
   import deng.fzip.FZipErrorEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.mobileOpt.BMCachedMovieClip;
   import net.tacticsoft.mobileOpt.BMCachedSprite;
   import net.tacticsoft.mobileOpt.BMUncachedMovieClip;
   import net.tacticsoft.mobileOpt.BMUncachedSprite;
   import net.tacticsoft.utils.DetectedSettings;
   
   public class BMExternalAssetsManager extends MovieClip
   {
      
      private static var _instance:BMExternalAssetsManager;
      
      private static var _allowInstantiation:Boolean;
      
      public static const EXTERNAL_LIBRARY_VERSION_FILE_NAME:String = "version.txt";
      
      private var generalLibrary:Loader;
      
      private var generalLibraryExtension:Loader;
      
      private var itemsLibrary1:Loader;
      
      private var itemsLibrary2:Loader;
      
      private var itemsLibrary3:Loader;
      
      private var mapLibrary:Loader;
      
      private var soundsLibrary:Loader;
      
      private var musicLibrary:Loader;
      
      private var _clientVersion:String;
      
      private var _clientRunningLocally:Boolean;
      
      private var _bytesTotal_items:Number = 0;
      
      private var _bytesTotal_map:Number = 0;
      
      private var _bytesTotal_sounds:Number = 0;
      
      private var _loadingCompleteFunction:Function;
      
      private var _loadingEnterFrameFunction:Function;
      
      private var _musicLoaded:Boolean = false;
      
      private var _musicLoadingProgressOutput:Function;
      
      private var _musicLoadingCompleteOutput:Function;
      
      private var _updateLoadingStatus:Function;
      
      private var _hardCodeResourcesLink:Boolean;
      
      private var _assetPaths:Array = new Array();
      
      private var _generalLibraryExtensionLoading:Boolean = false;
      
      private var _generalLibraryExtensionLoaded:Boolean = false;
      
      private var _totalSwfsToLoad:uint = 6;
      
      private var flashVars:BMMClientFlashVars;
      
      public var server_version_client_pc:Number = 0;
      
      public var server_version_items1:Number = 0;
      
      public var server_version_items2:Number = 0;
      
      public var server_version_items3:Number = 0;
      
      public var server_version_general:Number = 0;
      
      public var server_version_music:Number = 0;
      
      public var server_version_sound:Number = 0;
      
      public var client_version_items1:Number = 0;
      
      public var client_version_items2:Number = 0;
      
      public var client_version_items3:Number = 0;
      
      public var client_version_general:Number = 0;
      
      public var client_version_music:Number = 0;
      
      public var client_version_sound:Number = 0;
      
      public var version_client_ios:Number = 0;
      
      public var version_client_android:Number = 0;
      
      public var version_client_steam:Number = 0;
      
      public var versionsUpToDate:Boolean = false;
      
      public var clientNotUpToDateMessage:String = "";
      
      private var itemEditorPointer:DisplayObject;
      
      public const CLIENT_VERSION_PC:Number = 7610;
      
      public const CLIENT_VERSION_IOS:Number = 7610;
      
      public const CLIENT_VERSION_ANDROID:Number = 7610;
      
      public const CLIENT_VERSION_STEAM:Number = 1;
      
      private const GENERAL_LIBRARY_EXTENSION_STORAGE_FILE_NAME:String = "generalLibraryExtension";
      
      private const GENERAL_LIBRARY_EXTENSION_VERSION:uint = 7200;
      
      private const GENERAL_LIBRARY_EXTENSION_URL:String = "http://supermechs.com/resources/general/generalLibraryExt.swf";
      
      private var _extenalLibraryExtensionAppDomain:ApplicationDomain = null;
      
      private var _externalLibraryLoaded:Boolean = false;
      
      private var _externalLibraryOnLoadProgress:Function = null;
      
      private var _externalLibraryOnLoadComplete:Function = null;
      
      private var externalLibraryZip:FZip;
      
      private var _externalLibraryVersionNumber:int = 0;
      
      private var _externalLibraryVersionLoader:Loader;
      
      private var _externalAssetsDuplicatedLoaders:Object = new Object();
      
      public function BMExternalAssetsManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMExternalAssetsManager.getInstance() instead of new.");
         }
         this.flashVars = new BMMClientFlashVars(GlobalAccess.stage);
      }
      
      public static function getInstance() : BMExternalAssetsManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMExternalAssetsManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function get versionsString() : String
      {
         return "Versions::\n" + "PC:" + this.CLIENT_VERSION_PC + "\n" + "IOS:" + this.CLIENT_VERSION_IOS + "\n" + "ANDROID:" + this.CLIENT_VERSION_ANDROID + "\n" + "STEAM:" + this.CLIENT_VERSION_STEAM;
      }
      
      public function initialize(param1:Function, param2:Function, param3:Function, param4:String, param5:Boolean, param6:Boolean) : void
      {
         TsLogger.log("BMExternalAssetsManager initialized");
         if(!DetectedSettings.isAir)
         {
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
         }
         this._loadingEnterFrameFunction = param1;
         this._loadingCompleteFunction = param2;
         this._updateLoadingStatus = param3;
         this._clientVersion = param4;
         this._clientRunningLocally = param5;
         this._hardCodeResourcesLink = param6;
         if(this.shouldLoadGeneralLibraryExtensionAfterInit == false)
         {
            this._generalLibraryExtensionLoaded = true;
         }
         this.loadGeneralLibrary();
      }
      
      public function setItemEditorPointer(param1:DisplayObject) : void
      {
         this.itemEditorPointer = param1;
      }
      
      private function activateUpdateLoadingStatus(param1:String) : void
      {
         if(this._updateLoadingStatus != null)
         {
            this._updateLoadingStatus("Loading general assets...");
         }
      }
      
      private function get swfRatioFromDownload() : Number
      {
         return 100 / this._totalSwfsToLoad;
      }
      
      private function loadGeneralLibrary() : void
      {
         var _loc4_:URLVariables = null;
         this.generalLibrary = new Loader();
         var _loc1_:String = this.flashVars.resourceURL + this.flashVars.generalLibraryPath;
         if(this._hardCodeResourcesLink)
         {
         }
         if(this._clientRunningLocally == false)
         {
            _loc4_ = new URLVariables();
            _loc4_.version = this._clientVersion;
         }
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         if(this._clientRunningLocally == false)
         {
            _loc2_.data = _loc4_;
            _loc2_.method = URLRequestMethod.GET;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         this.generalLibrary.load(_loc2_,_loc3_);
         this.generalLibrary.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.generalLibraryProgressHandler);
         this.generalLibrary.contentLoaderInfo.addEventListener(Event.COMPLETE,this.generalLibraryLoadingComplete);
         this.activateUpdateLoadingStatus("Loading general assets...");
      }
      
      private function generalLibraryLoadingComplete(param1:Event) : void
      {
         TsLogger.log("BMExternalAssetsManager >> general library loading complete");
         if(this.itemEditorPointer != null)
         {
            this["itemEditorPointer"].addTrace("BMExternalAssetsManager >> general library loading complete");
         }
         if(this.shouldLoadGeneralLibraryExtensionAfterInit)
         {
            this.loadItemsLibrary1();
         }
         else
         {
            this.loadGeneralLibraryExtension();
         }
      }
      
      private function generalLibraryProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this._loadingEnterFrameFunction != null)
         {
            if(this._bytesTotal_items == 0)
            {
               this._bytesTotal_items = param1.bytesTotal;
            }
            _loc2_ = Math.ceil(param1.bytesLoaded / this._bytesTotal_items * this.swfRatioFromDownload);
            if(_loc2_ > 20)
            {
               _loc2_ = 20;
            }
            this._loadingEnterFrameFunction(_loc2_);
         }
      }
      
      public function loadGeneralLibraryExtension() : void
      {
         var _loc4_:URLVariables = null;
         var _loc5_:File = null;
         this.generalLibraryExtension = new Loader();
         var _loc1_:String = this.flashVars.resourceURL + this.flashVars.generalLibraryExtensionPath;
         if(this._hardCodeResourcesLink)
         {
         }
         if(this._clientRunningLocally == false)
         {
            _loc4_ = new URLVariables();
            _loc4_.version = this._clientVersion;
         }
         if(this.shouldLoadGeneralLibraryExtensionAfterInit)
         {
            _loc1_ = this.GENERAL_LIBRARY_EXTENSION_URL;
            _loc5_ = File.cacheDirectory.resolvePath(this.generalLibraryExtensionFileName);
            if(_loc5_.exists)
            {
               _loc1_ = File.cacheDirectory.url + "/" + this.generalLibraryExtensionFileName;
               TsLogger.log("General library extension: " + this.generalLibraryExtensionFileName + " exists");
               TsLogger.log("Loading general library extension from local storage");
            }
            else
            {
               TsLogger.log("General library extension: " + this.generalLibraryExtensionFileName + " doesn\'t exist");
               TsLogger.log("General library extension not found in storage");
            }
         }
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         if(this._clientRunningLocally == false)
         {
            _loc2_.data = _loc4_;
            _loc2_.method = URLRequestMethod.GET;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         this._generalLibraryExtensionLoading = true;
         this.generalLibraryExtension.load(_loc2_,_loc3_);
         this.generalLibraryExtension.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.generalLibraryExtensionProgressHandler);
         this.generalLibraryExtension.contentLoaderInfo.addEventListener(Event.COMPLETE,this.generalLibraryExtensionLoadingComplete);
         this.generalLibraryExtension.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.generalLibraryExtensionLoadingFailed);
         this.activateUpdateLoadingStatus("Loading general assets...");
      }
      
      private function generalLibraryExtensionLoadingFailed(param1:IOErrorEvent) : void
      {
         TsLogger.log("BMExternalAssetsManager >> general library extension loading failed. retrying in 5 seconds...");
         TweenMax.delayedCall(5,this.loadGeneralLibraryExtension);
      }
      
      private function generalLibraryExtensionLoadingComplete(param1:Event) : void
      {
         var _loc2_:File = null;
         var _loc3_:FileStream = null;
         var _loc4_:LoaderInfo = null;
         var _loc5_:ByteArray = null;
         TsLogger.log("BMExternalAssetsManager >> general library extension loading complete");
         this._extenalLibraryExtensionAppDomain = param1.target.applicationDomain;
         if(this.shouldLoadGeneralLibraryExtensionAfterInit)
         {
            this._generalLibraryExtensionLoaded = true;
            this._generalLibraryExtensionLoading = false;
            if(this.screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
            {
               this.screensM.screenWelcomeBackground.onGeneralExtensionLoadingComplete();
            }
            TsLogger.log("BMExternalAssetsManager >> saving general library extension to cacheDirectory");
            _loc2_ = File.cacheDirectory.resolvePath(this.generalLibraryExtensionFileName);
            _loc3_ = new FileStream();
            _loc3_.open(_loc2_,FileMode.WRITE);
            _loc4_ = LoaderInfo(param1.target);
            _loc5_ = _loc4_.bytes;
            _loc3_.writeBytes(_loc5_,0,_loc5_.length);
            _loc3_.close();
            TsLogger.log("BMExternalAssetsManager >> general library extension saved to cacheDirectory");
            return;
         }
         this.loadItemsLibrary1();
      }
      
      private function get generalLibraryExtensionFileName() : String
      {
         return this.GENERAL_LIBRARY_EXTENSION_STORAGE_FILE_NAME + this.GENERAL_LIBRARY_EXTENSION_VERSION + ".swf";
      }
      
      private function generalLibraryExtensionProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this._loadingEnterFrameFunction != null)
         {
            if(this._bytesTotal_items == 0)
            {
               this._bytesTotal_items = param1.bytesTotal;
            }
            _loc2_ = Math.ceil(param1.bytesLoaded / this._bytesTotal_items * this.swfRatioFromDownload);
            if(_loc2_ > 20)
            {
               _loc2_ = 20;
            }
            if(this.shouldLoadGeneralLibraryExtensionAfterInit)
            {
               if(this.screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
               {
                  this.screensM.screenWelcomeBackground.onGeneralExtensionLoadingOnEnterFrame(param1.bytesLoaded,param1.bytesTotal);
               }
               return;
            }
            this._loadingEnterFrameFunction(_loc2_);
         }
      }
      
      public function get generalLibraryExtensionLoading() : Boolean
      {
         return this._generalLibraryExtensionLoading;
      }
      
      public function get generalLibraryExtensionLoaded() : Boolean
      {
         return this._generalLibraryExtensionLoaded;
      }
      
      public function get shouldLoadGeneralLibraryExtensionAfterInit() : Boolean
      {
         return true;
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private function get screensM() : BMScreensManager
      {
         return BMScreensManager.getInstance();
      }
      
      private function loadItemsLibrary1() : void
      {
         var _loc4_:URLVariables = null;
         this.itemsLibrary1 = new Loader();
         var _loc1_:String = this.flashVars.resourceURL + this.flashVars.itemsLibrary1Path;
         if(this._hardCodeResourcesLink)
         {
         }
         if(this._clientRunningLocally == false)
         {
            _loc4_ = new URLVariables();
            _loc4_.version = this._clientVersion;
         }
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         if(this._clientRunningLocally == false)
         {
            _loc2_.data = _loc4_;
            _loc2_.method = URLRequestMethod.GET;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         this.itemsLibrary1.load(_loc2_,_loc3_);
         this.itemsLibrary1.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.itemsLibrary1ProgressHandler);
         this.itemsLibrary1.contentLoaderInfo.addEventListener(Event.COMPLETE,this.itemsLibrary1LoadingComplete);
         this.activateUpdateLoadingStatus("Loading items (1/3)...");
      }
      
      private function itemsLibrary1LoadingComplete(param1:Event) : void
      {
         TsLogger.log("BMExternalAssetsManager >> items1 library loading complete");
         if(this.itemEditorPointer != null)
         {
            this["itemEditorPointer"].addTrace("BMExternalAssetsManager >> items1 library loading complete");
         }
         this.loadItemsLibrary2();
      }
      
      private function itemsLibrary1ProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this._loadingEnterFrameFunction != null)
         {
            if(this._bytesTotal_items == 0)
            {
               this._bytesTotal_items = param1.bytesTotal;
            }
            _loc2_ = 20 + Math.ceil(param1.bytesLoaded / this._bytesTotal_items * this.swfRatioFromDownload);
            if(_loc2_ > 40)
            {
               _loc2_ = 40;
            }
            else if(_loc2_ < 20)
            {
               _loc2_ = 20;
            }
            this._loadingEnterFrameFunction(_loc2_);
         }
      }
      
      private function loadItemsLibrary2() : void
      {
         var _loc4_:URLVariables = null;
         this.itemsLibrary2 = new Loader();
         var _loc1_:String = this.flashVars.resourceURL + this.flashVars.itemsLibrary2Path;
         if(this._hardCodeResourcesLink)
         {
         }
         if(this._clientRunningLocally == false)
         {
            _loc4_ = new URLVariables();
            _loc4_.version = this._clientVersion;
         }
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         if(this._clientRunningLocally == false)
         {
            _loc2_.data = _loc4_;
            _loc2_.method = URLRequestMethod.GET;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         this.itemsLibrary2.load(_loc2_,_loc3_);
         this.itemsLibrary2.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.itemsLibrary2ProgressHandler);
         this.itemsLibrary2.contentLoaderInfo.addEventListener(Event.COMPLETE,this.itemsLibrary2LoadingComplete);
         this.activateUpdateLoadingStatus("Loading items (2/3)...");
      }
      
      private function itemsLibrary2LoadingComplete(param1:Event) : void
      {
         TsLogger.log("BMExternalAssetsManager >> items2 library loading complete");
         if(this.itemEditorPointer != null)
         {
            this["itemEditorPointer"].addTrace("BMExternalAssetsManager >> items2 library loading complete");
         }
         this.loadItemsLibrary3();
      }
      
      private function itemsLibrary2ProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this._loadingEnterFrameFunction != null)
         {
            if(this._bytesTotal_items == 0)
            {
               this._bytesTotal_items = param1.bytesTotal;
            }
            _loc2_ = 40 + Math.ceil(param1.bytesLoaded / this._bytesTotal_items * this.swfRatioFromDownload);
            if(_loc2_ > 60)
            {
               _loc2_ = 60;
            }
            else if(_loc2_ < 40)
            {
               _loc2_ = 40;
            }
            this._loadingEnterFrameFunction(_loc2_);
         }
      }
      
      private function loadItemsLibrary3() : void
      {
         var _loc4_:URLVariables = null;
         this.itemsLibrary3 = new Loader();
         var _loc1_:String = this.flashVars.resourceURL + this.flashVars.itemsLibrary3Path;
         if(this._hardCodeResourcesLink)
         {
         }
         if(this._clientRunningLocally == false)
         {
            _loc4_ = new URLVariables();
            _loc4_.version = this._clientVersion;
         }
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         if(this._clientRunningLocally == false)
         {
            _loc2_.data = _loc4_;
            _loc2_.method = URLRequestMethod.GET;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         this.itemsLibrary3.load(_loc2_,_loc3_);
         this.itemsLibrary3.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.itemsLibrary3ProgressHandler);
         this.itemsLibrary3.contentLoaderInfo.addEventListener(Event.COMPLETE,this.itemsLibrary3LoadingComplete);
         this.activateUpdateLoadingStatus("Loading items (3/3)...");
      }
      
      private function itemsLibrary3LoadingComplete(param1:Event) : void
      {
         TsLogger.log("BMExternalAssetsManager >> items3 library loading complete");
         if(this.itemEditorPointer != null)
         {
            this["itemEditorPointer"].addTrace("BMExternalAssetsManager >> items3 library loading complete");
         }
         this.loadSoundsLibrary();
      }
      
      private function itemsLibrary3ProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this._loadingEnterFrameFunction != null)
         {
            if(this._bytesTotal_items == 0)
            {
               this._bytesTotal_items = param1.bytesTotal;
            }
            _loc2_ = 60 + Math.ceil(param1.bytesLoaded / this._bytesTotal_items * this.swfRatioFromDownload);
            if(_loc2_ > 80)
            {
               _loc2_ = 80;
            }
            else if(_loc2_ < 60)
            {
               _loc2_ = 60;
            }
            this._loadingEnterFrameFunction(_loc2_);
         }
      }
      
      private function loadSoundsLibrary() : void
      {
         var _loc4_:URLVariables = null;
         this.soundsLibrary = new Loader();
         var _loc1_:String = this.flashVars.resourceURL + this.flashVars.soundsLibraryPath;
         if(this._hardCodeResourcesLink)
         {
         }
         if(this._clientRunningLocally == false)
         {
            _loc4_ = new URLVariables();
            _loc4_.version = this._clientVersion;
         }
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         if(this._clientRunningLocally == false)
         {
            _loc2_.data = _loc4_;
            _loc2_.method = URLRequestMethod.GET;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         this.soundsLibrary.load(_loc2_,_loc3_);
         this.soundsLibrary.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.soundsLibraryProgressHandler);
         this.soundsLibrary.contentLoaderInfo.addEventListener(Event.COMPLETE,this.soundsLibraryLoadingComplete);
         this.activateUpdateLoadingStatus("Loading sounds...");
      }
      
      private function soundsLibraryLoadingComplete(param1:Event) : void
      {
         TsLogger.log("BMExternalAssetsManager >> sounds library loading complete");
         if(this.itemEditorPointer != null)
         {
            this["itemEditorPointer"].addTrace("BMExternalAssetsManager >> sounds library loading complete");
         }
         this._loadingCompleteFunction();
         this._musicLoaded = true;
      }
      
      private function soundsLibraryProgressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this._loadingEnterFrameFunction != null)
         {
            if(this._bytesTotal_sounds == 0)
            {
               this._bytesTotal_sounds = param1.bytesTotal;
            }
            _loc2_ = 80 + Math.ceil(param1.bytesLoaded / param1.bytesTotal * this.swfRatioFromDownload);
            if(_loc2_ > 100)
            {
               _loc2_ = 100;
            }
            this._loadingEnterFrameFunction(_loc2_);
         }
      }
      
      private function loadMusicLibrary() : void
      {
         var _loc4_:URLVariables = null;
         this.musicLibrary = new Loader();
         var _loc1_:String = this.flashVars.resourceURL + this.flashVars.musicLibraryPath;
         if(this._hardCodeResourcesLink)
         {
         }
         if(this._clientRunningLocally == false)
         {
            _loc4_ = new URLVariables();
            _loc4_.version = this._clientVersion;
         }
         var _loc2_:URLRequest = new URLRequest(_loc1_);
         if(this._clientRunningLocally == false)
         {
            _loc2_.data = _loc4_;
            _loc2_.method = URLRequestMethod.GET;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         this.musicLibrary.load(_loc2_,_loc3_);
         this.musicLibrary.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.musicLibraryProgressHandler);
         this.musicLibrary.contentLoaderInfo.addEventListener(Event.COMPLETE,this.musicLibraryLoadingComplete);
      }
      
      private function musicLibraryLoadingComplete(param1:Event) : void
      {
         TsLogger.log("BMExternalAssetsManager >> music library loading complete");
         if(this.itemEditorPointer != null)
         {
            this["itemEditorPointer"].addTrace("BMExternalAssetsManager >> music library loading complete");
         }
         this._musicLoaded = true;
         if(this._musicLoadingCompleteOutput != null)
         {
            this._musicLoadingCompleteOutput();
         }
      }
      
      private function musicLibraryProgressHandler(param1:ProgressEvent) : void
      {
         if(this._musicLoadingProgressOutput != null)
         {
            this._musicLoadingProgressOutput(param1.bytesLoaded / param1.bytesTotal);
         }
      }
      
      public function setMusicLoadingOutput(param1:Function, param2:Function) : void
      {
         this._musicLoadingProgressOutput = param1;
         this._musicLoadingCompleteOutput = param2;
      }
      
      public function resetExternalLibraryParams() : void
      {
         this._externalLibraryLoaded = false;
         this._externalLibraryOnLoadProgress = null;
         this._externalLibraryOnLoadComplete = null;
         this._externalLibraryVersionNumber = 0;
      }
      
      private function externalLibraryZipProgressHandler(param1:ProgressEvent) : void
      {
         if(this._externalLibraryOnLoadProgress == null)
         {
            return;
         }
         this._externalLibraryOnLoadProgress(param1.bytesLoaded,param1.bytesTotal);
      }
      
      private function externalLibraryZipLoadingComplete(param1:Event) : void
      {
         this._externalLibraryLoaded = true;
         if(this._externalLibraryOnLoadComplete == null)
         {
            return;
         }
         this.dataM.saveExternalLibrarySharedObjectData(this.externalLibraryZip);
         TsLogger.log("> > > > > SAVING EXTERNAL LIBRARY");
         this._externalLibraryOnLoadComplete();
      }
      
      private function externalLibraryZipParsingFailed(param1:FZipErrorEvent) : void
      {
         TsLogger.log("> > > > > EXTERNAL LIBRARY LOADING FAILED!");
         this.showZipLoadingError();
      }
      
      private function externalLibraryZipLoadingFailed(param1:IOErrorEvent) : void
      {
         TsLogger.log("> > > > > EXTERNAL LIBRARY LOADING FAILED!");
         this.showZipLoadingError();
      }
      
      private function showZipLoadingError() : void
      {
         this.screensM.addIfNotOpened(BMScreensManager.SCR_LOST_CONNECTION);
         this.screensM.screenLostConnection.refreshScreen();
      }
      
      private function get externalLibraryVersionSuccess() : Boolean
      {
         var _loc1_:uint = this.dataM.getGeneralSetting("version_externalLibrary",0);
         var _loc2_:String = this.dataM.externalLibraryURL;
         var _loc3_:String = "";
         if(this.dataM.externalLibrarySharedObject.data.url != null)
         {
            _loc3_ = this.dataM.externalLibrarySharedObject.data.url;
         }
         return this.getURLFileName(_loc3_) == this.getURLFileName(_loc2_) && this._externalLibraryVersionNumber >= _loc1_;
      }
      
      public function loadExternalLibrary(param1:Function, param2:Function) : void
      {
         var _loc3_:String = null;
         var _loc4_:URLRequest = null;
         this._externalLibraryOnLoadProgress = param1;
         this._externalLibraryOnLoadComplete = param2;
         if(this.shouldLoadExternalLibrary)
         {
            if(this.externalLibraryVersionSuccess)
            {
               this._externalLibraryLoaded = true;
               this._externalLibraryOnLoadComplete();
            }
            else
            {
               this.externalLibraryZip = new FZip();
               _loc3_ = this.dataM.externalLibraryURL;
               _loc3_ = _loc3_ + "?version=" + this.dataM.getGeneralSetting("version_externalLibrary",0);
               _loc4_ = new URLRequest(_loc3_);
               this.externalLibraryZip.load(_loc4_);
               this.externalLibraryZip.addEventListener(ProgressEvent.PROGRESS,this.externalLibraryZipProgressHandler);
               this.externalLibraryZip.addEventListener(Event.COMPLETE,this.externalLibraryZipLoadingComplete);
               this.externalLibraryZip.addEventListener(FZipErrorEvent.PARSE_ERROR,this.externalLibraryZipParsingFailed);
               this.externalLibraryZip.addEventListener(IOErrorEvent.IO_ERROR,this.externalLibraryZipLoadingFailed);
            }
         }
      }
      
      private function getURLFileName(param1:String) : String
      {
         var _loc2_:int = param1.lastIndexOf("/");
         var _loc3_:int = param1.lastIndexOf("\\");
         var _loc4_:int = _loc2_ > _loc3_ ? _loc2_ : _loc3_;
         return param1.substr(_loc4_ + 1);
      }
      
      public function get shouldLoadExternalLibrary() : Boolean
      {
         var _loc1_:LoaderContext = null;
         var _loc2_:ByteArray = null;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(this.dataM.externalLibrarySharedObjectExists)
         {
            if(this.dataM.externalLibrarySharedObject.data[EXTERNAL_LIBRARY_VERSION_FILE_NAME] != null)
            {
               _loc1_ = new LoaderContext(false,ApplicationDomain.currentDomain,null);
               _loc1_.allowCodeImport = true;
               _loc2_ = this.dataM.externalLibrarySharedObject.data[EXTERNAL_LIBRARY_VERSION_FILE_NAME];
               _loc3_ = int(_loc2_.toString());
               this._externalLibraryVersionNumber = _loc3_;
               _loc4_ = this.dataM.getGeneralSetting("version_externalLibrary",0);
               _loc5_ = this.dataM.externalLibraryURL;
               _loc6_ = "";
               if(this.dataM.externalLibrarySharedObject.data.url != null)
               {
                  _loc6_ = this.dataM.externalLibrarySharedObject.data.url;
               }
               TsLogger.log("> > > > > EXTERNAL LIBRARY VERSION: " + _loc3_ + " DATABASE VERSION: " + _loc4_);
               if(_loc3_ < _loc4_ || this.getURLFileName(_loc6_) != this.getURLFileName(_loc5_))
               {
                  trace(_loc6_ + " ::: " + _loc5_);
                  TsLogger.log("> > > > > MUST RELOAD EXTERNAL LIBRARY");
                  return true;
               }
               TsLogger.log("> > > > > EXTERNAL LIBRARY IS UP TO DATE");
               return false;
            }
            TsLogger.log("> > > > > EXTERNAL LIBRARY DOES NOT EXIST");
            return true;
         }
         TsLogger.log("> > > > > EXTERNAL LIBRARY DOES NOT EXIST");
         return true;
      }
      
      private function externalLibraryVersionLoadComplete(param1:Event) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc2_:Boolean = false;
         if(this._externalLibraryVersionLoader.contentLoaderInfo.loader.content == null)
         {
            _loc2_ = true;
         }
         else
         {
            _loc3_ = this._externalLibraryVersionLoader.contentLoaderInfo.loader.content as MovieClip;
            if(_loc3_.txtVersion == null)
            {
               _loc2_ = true;
            }
         }
         if(_loc2_ == false)
         {
            _loc4_ = uint(_loc3_.txtVersion.text);
            _loc5_ = this.dataM.getGeneralSetting("version_externalLibrary",0);
            TsLogger.log("> > > > > EXTERNAL LIBRARY VERSION: " + _loc4_ + " DATABASE VERSION: " + _loc5_);
            if(_loc4_ >= _loc5_)
            {
               this._externalLibraryVersionNumber = _loc4_;
               TsLogger.log("> > > > > EXTERNAL LIBRARY IS UP TO DATE");
            }
            else
            {
               TsLogger.log("> > > > > MUST RELOAD EXTERNAL LIBRARY");
            }
         }
         else
         {
            TsLogger.log("> > > > > MUST RELOAD EXTERNAL LIBRARY");
         }
         this.loadExternalLibrary(this._externalLibraryOnLoadProgress,this._externalLibraryOnLoadComplete);
      }
      
      public function getAsset(param1:String, param2:String, param3:Number = 0, param4:Number = 0, param5:Boolean = false, param6:Boolean = false, param7:Boolean = true) : MovieClip
      {
         var _loc8_:MovieClip = null;
         var _loc10_:Class = null;
         var _loc11_:String = null;
         var _loc12_:ApplicationDomain = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Object = null;
         var _loc16_:Loader = null;
         var _loc17_:LoaderContext = null;
         var _loc18_:ByteArray = null;
         var _loc9_:Boolean = false;
         _loc12_ = ApplicationDomain.currentDomain;
         if(param2 == null || param2 == "")
         {
            TsLogger.log("ERROR external assets manager trying to load empty asset");
         }
         switch(param1)
         {
            case "items1":
               _loc11_ = "com.supermechs.itemsLibrary1." + param2;
               break;
            case "items2":
               _loc11_ = "com.supermechs.itemsLibrary2." + param2;
               break;
            case "items3":
               _loc11_ = "com.supermechs.items3." + param2;
               break;
            case "general":
               _loc11_ = "com.supermechs.generalLibrary." + param2;
               break;
            case "sound":
               _loc11_ = "com.supermechs.soundsLibrary." + param2;
               break;
            case "music":
               _loc11_ = "com.supermechs.musicLibrary." + param2;
         }
         if(this.dataM.externalLibrarySharedObjectExists)
         {
            if(this.dataM.externalLibrarySharedObject.data[param2 + ".swf"] != null)
            {
               _loc9_ = true;
            }
         }
         if(_loc9_)
         {
            _loc8_ = new MovieClip();
            _loc8_.graphics.beginFill(0);
            _loc13_ = param3;
            _loc14_ = param4;
            if(_loc13_ == 0)
            {
               _loc13_ = 50;
               _loc14_ = 50;
            }
            _loc8_.graphics.drawRect(0,0,_loc13_,_loc14_);
            _loc8_.loading = true;
            _loc8_.loadingCompleteCallback = null;
            _loc8_.mouseDisabled = param5;
            _loc8_.convertItemGfxIntoBitmap = param6;
            _loc8_.allowCachingAsBitmap = param7;
            _loc15_ = new Object();
            _loc16_ = new Loader();
            _loc15_.loader = _loc16_;
            _loc15_.assetContainer = _loc8_;
            this._externalAssetsDuplicatedLoaders[_loc16_.name] = _loc15_;
            _loc17_ = new LoaderContext(false,ApplicationDomain.currentDomain,null);
            _loc17_.allowCodeImport = true;
            _loc18_ = this.dataM.externalLibrarySharedObject.data[param2 + ".swf"];
            _loc16_.loadBytes(_loc18_,_loc17_);
            _loc16_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loaderDuplicationLoadComplete);
         }
         else
         {
            if(this._extenalLibraryExtensionAppDomain != null && this._extenalLibraryExtensionAppDomain.hasDefinition(_loc11_))
            {
               _loc10_ = this._extenalLibraryExtensionAppDomain.getDefinition(_loc11_) as Class;
            }
            else
            {
               _loc10_ = _loc12_.getDefinition(_loc11_) as Class;
            }
            _loc8_ = new _loc10_() as MovieClip;
            this.finalizeAsset(_loc8_,param3,param4,param5,param6,param7);
         }
         return _loc8_;
      }
      
      private function finalizeAsset(param1:MovieClip, param2:Number = 0, param3:Number = 0, param4:Boolean = false, param5:Boolean = false, param6:Boolean = true) : void
      {
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:BitmapData = null;
         var _loc10_:Bitmap = null;
         if(param2 > 0)
         {
            param1.width = param2;
         }
         if(param3 > 0)
         {
            param1.height = param3;
         }
         if(param4)
         {
            param1.mouseEnabled = false;
            param1.mouseChildren = false;
         }
         param5 = false;
         if(param1.itemGfx != null)
         {
            if(param1.mcGlow != null)
            {
               param1.mcGlow.alpha = 0;
            }
            if(param5)
            {
               _loc7_ = GlobalAccess.stage.quality;
               GlobalAccess.stage.quality = StageQuality.LOW;
               _loc8_ = 5;
               _loc9_ = new BitmapData(param1.itemGfx.width + _loc8_ * 2,param1.itemGfx.height + _loc8_ * 2,true,0);
               _loc10_ = new Bitmap(_loc9_);
               param1.itemGfx.x += _loc8_;
               param1.itemGfx.y += _loc8_;
               if(param1.mcIgnoreBlackBorder == null)
               {
                  param1.itemGfx.filters = [new GlowFilter(0,1,5,5,10,1,false,false)];
               }
               if(param1.mcHandle != null)
               {
                  param1.mcHandle.visible = false;
               }
               if(param1.mcArm != null)
               {
                  param1.mcArm.visible = false;
               }
               _loc9_.draw(param1);
               if(param1.mcHandle != null)
               {
                  param1.mcHandle.visible = true;
               }
               if(param1.mcArm != null)
               {
                  param1.mcArm.visible = true;
               }
               _loc10_.smoothing = true;
               param1.removeChild(param1.itemGfx);
               param1.itemGfx = null;
               param1.itemBM = _loc10_;
               param1.itemBMD = _loc9_;
               param1.addChild(_loc10_);
               if(param1.mcColor != null)
               {
                  param1.mcColor.x += _loc8_;
                  param1.mcColor.y += _loc8_;
                  param1.swapChildren(param1.mcColor,_loc10_);
               }
               if(param1.mcBarrel != null)
               {
                  param1.mcBarrel.x += _loc8_;
                  param1.mcBarrel.y += _loc8_;
               }
               if(param1.mcGlow != null)
               {
                  param1.mcGlow.x += _loc8_;
                  param1.mcGlow.y += _loc8_;
               }
               if(param1.mcLight != null)
               {
                  param1.mcLight.x += _loc8_;
                  param1.mcLight.y += _loc8_;
               }
               if(param1.mcHandle != null)
               {
                  param1.mcHandle.x += _loc8_;
                  param1.mcHandle.y += _loc8_;
               }
               if(param1.mcArm != null)
               {
                  param1.mcArm.x += _loc8_;
                  param1.mcArm.y += _loc8_;
               }
               if(param1.mcShutdown != null)
               {
                  param1.mcShutdown.x += _loc8_;
                  param1.mcShutdown.y += _loc8_;
                  param1.mcShutdown.parent.removeChild(param1.mcShutdown);
                  param1.addChild(param1.mcShutdown);
               }
               GlobalAccess.stage.quality = _loc7_;
               return;
            }
         }
         if(param6 == false)
         {
            return;
         }
         if(param1 is BMCachedMovieClip || param1 is BMCachedSprite || param1 is BMUncachedMovieClip || param1 is BMUncachedSprite)
         {
            return;
         }
         GlobalAccess.stage.quality = StageQuality.LOW;
         if(DetectedSettings.isMobile)
         {
            param1["cacheAsBitmapMatrix"] = new Matrix();
         }
         param1.cacheAsBitmap = true;
         if(param1.itemGfx == null)
         {
            return;
         }
         if(param1.mcBarrel != null)
         {
            param1.mcBarrel.parent.removeChild(param1.mcBarrel);
            param1.addChild(param1.mcBarrel);
         }
         if(param1.mcLight != null)
         {
            param1.mcLight.parent.removeChild(param1.mcLight);
            param1.addChild(param1.mcLight);
         }
         if(param1.mcHandle != null)
         {
            param1.mcHandle.parent.removeChild(param1.mcHandle);
            param1.addChild(param1.mcHandle);
         }
         if(param1.mcGlow != null)
         {
            param1.mcGlow.parent.removeChild(param1.mcGlow);
            param1.addChild(param1.mcGlow);
         }
         if(param1.mcArm != null)
         {
            param1.mcArm.parent.removeChild(param1.mcArm);
            param1.addChild(param1.mcArm);
         }
         if(param1.mcShutdown != null)
         {
            param1.mcShutdown.parent.removeChild(param1.mcShutdown);
            param1.addChild(param1.mcShutdown);
         }
      }
      
      public function modifyExternalAssetDuplicationContainer(param1:MovieClip, param2:Boolean = true, param3:Number = 0, param4:Function = null, param5:Array = null) : MovieClip
      {
         param1.loadingCompleteCallback = param4;
         param1.loadingCompleteParams = param5;
         param1.ignoreContainerSize = param2;
         param1.sizeAddon = param3;
         return param1;
      }
      
      private function loaderDuplicationLoadComplete(param1:Event) : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:Function = null;
         var _loc8_:Array = null;
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Number = NaN;
         var _loc15_:MovieClip = null;
         var _loc16_:Number = NaN;
         var _loc2_:LoaderInfo = param1["target"];
         var _loc3_:String = _loc2_.loader.name;
         var _loc4_:Object = this._externalAssetsDuplicatedLoaders[_loc3_];
         var _loc5_:Boolean = true;
         if(_loc4_.assetContainer == null)
         {
            _loc5_ = false;
         }
         if(_loc5_)
         {
            _loc6_ = _loc4_.assetContainer.parent;
            _loc7_ = _loc4_.assetContainer.loadingCompleteCallback;
            _loc8_ = _loc4_.assetContainer.loadingCompleteParams;
            _loc9_ = Boolean(_loc4_.assetContainer.ignoreContainerSize);
            _loc10_ = Number(_loc4_.assetContainer.sizeAddon);
            _loc11_ = Boolean(_loc4_.assetContainer.mouseDisabled);
            _loc12_ = Boolean(_loc4_.assetContainer.convertItemGfxIntoBitmap);
            _loc13_ = Boolean(_loc4_.assetContainer.allowCachingAsBitmap);
            _loc14_ = Number(_loc4_.assetContainer.width);
            if(_loc6_ != null)
            {
               _loc4_.assetContainer.parent.removeChild(_loc4_.assetContainer);
            }
            _loc15_ = _loc2_.loader.content as MovieClip;
            _loc15_.x = _loc4_.assetContainer.x;
            _loc15_.y = _loc4_.assetContainer.y;
            if(_loc9_ == false)
            {
               if(_loc15_.x > _loc15_.y)
               {
                  _loc15_.x = _loc15_.y;
               }
               else
               {
                  _loc15_.y = _loc15_.x;
               }
               if(_loc15_.width > _loc15_.height)
               {
                  _loc16_ = _loc15_.width / _loc14_;
               }
               else
               {
                  _loc16_ = _loc15_.height / _loc14_;
               }
               _loc15_.width /= _loc16_;
               _loc15_.height /= _loc16_;
               if(_loc15_.width > _loc15_.height)
               {
                  _loc15_.y += (_loc15_.width - _loc15_.height) / 2;
               }
               else
               {
                  _loc15_.x += (_loc15_.height - _loc15_.width) / 2;
               }
               if(_loc10_ > 0)
               {
                  if(_loc15_.width > _loc15_.height)
                  {
                     _loc16_ = _loc15_.height / _loc15_.width;
                     _loc15_.width += _loc10_;
                     _loc15_.height += _loc10_ * _loc16_;
                     _loc15_.x -= _loc10_ / 2;
                     _loc15_.y -= _loc10_ / 2 * _loc16_;
                  }
                  else
                  {
                     _loc16_ = _loc15_.width / _loc15_.height;
                     _loc15_.width += _loc10_ * _loc16_;
                     _loc15_.height += _loc10_;
                     _loc15_.x -= _loc10_ / 2 * _loc16_;
                     _loc15_.y -= _loc10_ / 2;
                  }
               }
            }
            this.finalizeAsset(_loc15_,0,0,_loc11_,_loc12_,_loc13_);
            if(_loc6_ != null)
            {
               _loc6_.addChild(_loc15_);
            }
            if(_loc7_ != null)
            {
               _loc7_(_loc15_,_loc8_);
            }
         }
         this._externalAssetsDuplicatedLoaders[_loc3_] = null;
      }
      
      public function getSound(param1:String) : Sound
      {
         var _loc2_:ApplicationDomain = null;
         _loc2_ = ApplicationDomain.currentDomain;
         var _loc3_:Class = _loc2_.getDefinition("com.supermechs.soundsLibrary." + param1) as Class;
         return new _loc3_() as Sound;
      }
      
      public function musicLoaded() : Boolean
      {
         var _loc1_:Boolean = true;
         if(this._musicLoaded == false)
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function getVersionNumber() : Number
      {
         return this.CLIENT_VERSION_ANDROID;
      }
      
      public function checkVersions() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:Boolean = false;
         _loc1_ = true;
         if(_loc1_)
         {
            TsLogger.log("CLIENT_VERSION_ANDROID:" + this.CLIENT_VERSION_ANDROID + " Number(version_client_android):" + Number(this.version_client_android));
            if(Number(this.version_client_android) > this.CLIENT_VERSION_ANDROID)
            {
               this.clientNotUpToDateMessage = "ERROR : client version is not up to date | SERVER version : " + this.version_client_android + " | manager version : " + this.CLIENT_VERSION_ANDROID;
               TsLogger.log(this.clientNotUpToDateMessage);
               if(this.itemEditorPointer != null)
               {
                  this["itemEditorPointer"].addTrace("ERROR : client version is not up to date");
               }
            }
            else
            {
               this.versionsUpToDate = true;
            }
         }
         else
         {
            _loc2_ = this.getAsset("items1","mcClientVersion");
            this.client_version_items1 = int(_loc2_.txtVersion.text);
            if(this.client_version_items1 < this.server_version_items1)
            {
               this.clientNotUpToDateMessage = "ERROR : items1 version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.server_version_items1;
               TsLogger.log(this.clientNotUpToDateMessage);
               if(this.itemEditorPointer != null)
               {
                  this["itemEditorPointer"].addTrace("ERROR : items1 version is not up to date");
               }
            }
            else
            {
               _loc2_ = this.getAsset("items2","mcClientVersion");
               this.client_version_items2 = int(_loc2_.txtVersion.text);
               if(this.client_version_items2 < this.server_version_items2)
               {
                  this.clientNotUpToDateMessage = "ERROR : items2 version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.server_version_items2;
                  TsLogger.log(this.clientNotUpToDateMessage);
                  if(this.itemEditorPointer != null)
                  {
                     this["itemEditorPointer"].addTrace("ERROR : items2 version is not up to date");
                  }
               }
               else
               {
                  _loc2_ = this.getAsset("items3","mcClientVersion");
                  this.client_version_items3 = int(_loc2_.txtVersion.text);
                  if(this.client_version_items3 < this.server_version_items3)
                  {
                     this.clientNotUpToDateMessage = "ERROR : items3 version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.server_version_items3;
                     TsLogger.log(this.clientNotUpToDateMessage);
                     if(this.itemEditorPointer != null)
                     {
                        this["itemEditorPointer"].addTrace("ERROR : items3 version is not up to date");
                     }
                  }
                  else
                  {
                     _loc2_ = this.getAsset("general","mcClientVersion");
                     this.client_version_general = int(_loc2_.txtVersion.text);
                     if(this.client_version_general < this.server_version_general)
                     {
                        this.clientNotUpToDateMessage = "ERROR : general version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.server_version_general;
                        TsLogger.log(this.clientNotUpToDateMessage);
                        if(this.itemEditorPointer != null)
                        {
                           this["itemEditorPointer"].addTrace("ERROR : general version is not up to date");
                        }
                     }
                     else
                     {
                        _loc2_ = this.getAsset("sound","mcClientVersion");
                        this.client_version_sound = int(_loc2_.txtVersion.text);
                        if(this.client_version_sound < this.server_version_sound)
                        {
                           this.clientNotUpToDateMessage = "ERROR : sound version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.server_version_sound;
                           TsLogger.log(this.clientNotUpToDateMessage);
                           if(this.itemEditorPointer != null)
                           {
                              this["itemEditorPointer"].addTrace("ERROR : sound version is not up to date");
                           }
                        }
                        else if(this.CLIENT_VERSION_PC < this.server_version_client_pc)
                        {
                           this.clientNotUpToDateMessage = "ERROR : client version is not up to date | SERVER version : " + this.server_version_client_pc + " | manager version : " + this.CLIENT_VERSION_PC;
                           TsLogger.log(this.clientNotUpToDateMessage);
                           if(this.itemEditorPointer != null)
                           {
                              this["itemEditorPointer"].addTrace("ERROR : client version is not up to date");
                           }
                        }
                        else
                        {
                           this.versionsUpToDate = true;
                        }
                     }
                  }
               }
            }
         }
      }
   }
}

