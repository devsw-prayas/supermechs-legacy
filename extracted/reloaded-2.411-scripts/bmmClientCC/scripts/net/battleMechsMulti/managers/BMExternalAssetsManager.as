package net.battleMechsMulti.managers
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
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
      
      private var generalLibrary:Loader;
      
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
      
      private var _assetsInMemory:Object = new Object();
      
      private var _assetPaths:Array = new Array();
      
      private var flashVars:BMMClientFlashVars;
      
      public var version_client_pc:Number = 0;
      
      public var version_items1:Number = 0;
      
      public var version_items2:Number = 0;
      
      public var version_items3:Number = 0;
      
      public var version_general:Number = 0;
      
      public var version_music:Number = 0;
      
      public var version_sound:Number = 0;
      
      public var version_client_ios:Number = 0;
      
      public var version_client_android:Number = 0;
      
      public var version_client_steam:Number = 0;
      
      public var versionsUpToDate:Boolean = false;
      
      public var clientNotUpToDateMessage:String = "";
      
      private var itemEditorPointer:DisplayObject;
      
      public const CLIENT_VERSION_PC:Number = 2410;
      
      public const CLIENT_VERSION_IOS:Number = 2410;
      
      public const CLIENT_VERSION_ANDROID:Number = 2410;
      
      public const CLIENT_VERSION_STEAM:Number = 1;
      
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
         this.loadItemsLibrary1();
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
            _loc2_ = Math.ceil(param1.bytesLoaded / this._bytesTotal_items * 100 * 0.2);
            if(_loc2_ > 20)
            {
               _loc2_ = 20;
            }
            this._loadingEnterFrameFunction(_loc2_);
         }
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
            _loc2_ = 20 + Math.ceil(param1.bytesLoaded / this._bytesTotal_items * 100 * 0.2);
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
            _loc2_ = 40 + Math.ceil(param1.bytesLoaded / this._bytesTotal_items * 100 * 0.2);
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
            _loc2_ = 60 + Math.ceil(param1.bytesLoaded / this._bytesTotal_items * 100 * 0.2);
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
            _loc2_ = 80 + Math.ceil(param1.bytesLoaded / param1.bytesTotal * 100 * 0.2);
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
      
      public function getAsset(param1:String, param2:String, param3:Number = 0, param4:Number = 0, param5:Boolean = false, param6:Boolean = false, param7:Boolean = true) : MovieClip
      {
         var _loc8_:MovieClip = null;
         var _loc10_:Class = null;
         var _loc11_:String = null;
         var _loc12_:ApplicationDomain = null;
         var _loc13_:String = null;
         var _loc14_:Number = NaN;
         var _loc15_:BitmapData = null;
         var _loc16_:Bitmap = null;
         if(this._assetsInMemory[param1 + "_" + param2] == null)
         {
            _loc12_ = ApplicationDomain.currentDomain;
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
            _loc10_ = _loc12_.getDefinition(_loc11_) as Class;
            this._assetsInMemory[param1 + "_" + param2] = new _loc10_() as MovieClip;
         }
         var _loc9_:Class = Object(this._assetsInMemory[param1 + "_" + param2]).constructor;
         _loc8_ = new _loc9_();
         if(param3 > 0)
         {
            _loc8_.width = param3;
         }
         if(param4 > 0)
         {
            _loc8_.height = param4;
         }
         if(param5)
         {
            _loc8_.mouseEnabled = false;
            _loc8_.mouseChildren = false;
         }
         param6 = false;
         if(_loc8_.itemGfx != null && param6)
         {
            _loc13_ = GlobalAccess.stage.quality;
            GlobalAccess.stage.quality = StageQuality.LOW;
            _loc14_ = 5;
            _loc15_ = new BitmapData(_loc8_.itemGfx.width + _loc14_ * 2,_loc8_.itemGfx.height + _loc14_ * 2,true,0);
            _loc16_ = new Bitmap(_loc15_);
            _loc8_.itemGfx.x += _loc14_;
            _loc8_.itemGfx.y += _loc14_;
            _loc8_.itemGfx.filters = [new GlowFilter(0,1,5,5,10,1,false,false)];
            if(_loc8_.mcHandle != null)
            {
               _loc8_.mcHandle.visible = false;
            }
            _loc15_.draw(_loc8_);
            if(_loc8_.mcHandle != null)
            {
               _loc8_.mcHandle.visible = true;
            }
            _loc16_.smoothing = true;
            _loc8_.removeChild(_loc8_.itemGfx);
            _loc8_.itemGfx = null;
            _loc8_.itemBM = _loc16_;
            _loc8_.itemBMD = _loc15_;
            _loc8_.addChild(_loc16_);
            if(_loc8_.mcColor != null)
            {
               _loc8_.mcColor.x += _loc14_;
               _loc8_.mcColor.y += _loc14_;
               _loc8_.swapChildren(_loc8_.mcColor,_loc16_);
            }
            if(_loc8_.mcBarrel != null)
            {
               _loc8_.mcBarrel.x += _loc14_;
               _loc8_.mcBarrel.y += _loc14_;
            }
            if(_loc8_.mcLight != null)
            {
               _loc8_.mcLight.x += _loc14_;
               _loc8_.mcLight.y += _loc14_;
            }
            if(_loc8_.mcHandle != null)
            {
               _loc8_.mcHandle.x += _loc14_;
               _loc8_.mcHandle.y += _loc14_;
            }
            if(_loc8_.mcShutdown != null)
            {
               _loc8_.mcShutdown.x += _loc14_;
               _loc8_.mcShutdown.y += _loc14_;
               _loc8_.mcShutdown.parent.removeChild(_loc8_.mcShutdown);
               _loc8_.addChild(_loc8_.mcShutdown);
            }
            GlobalAccess.stage.quality = _loc13_;
         }
         else if(param7)
         {
            if(!(_loc8_ is BMCachedMovieClip || _loc8_ is BMCachedSprite || _loc8_ is BMUncachedMovieClip || _loc8_ is BMUncachedSprite))
            {
               GlobalAccess.stage.quality = StageQuality.LOW;
               if(DetectedSettings.isMobile)
               {
                  _loc8_["cacheAsBitmapMatrix"] = new Matrix();
               }
               _loc8_.cacheAsBitmap = true;
               if(_loc8_.itemGfx != null)
               {
                  if(_loc8_.mcBarrel != null)
                  {
                     _loc8_.mcBarrel.parent.removeChild(_loc8_.mcBarrel);
                     _loc8_.addChild(_loc8_.mcBarrel);
                  }
                  if(_loc8_.mcLight != null)
                  {
                     _loc8_.mcLight.parent.removeChild(_loc8_.mcLight);
                     _loc8_.addChild(_loc8_.mcLight);
                  }
                  if(_loc8_.mcHandle != null)
                  {
                     _loc8_.mcHandle.parent.removeChild(_loc8_.mcHandle);
                     _loc8_.addChild(_loc8_.mcHandle);
                  }
                  if(_loc8_.mcShutdown != null)
                  {
                     _loc8_.mcShutdown.parent.removeChild(_loc8_.mcShutdown);
                     _loc8_.addChild(_loc8_.mcShutdown);
                  }
               }
            }
         }
         return _loc8_;
      }
      
      public function getSound(param1:String) : Sound
      {
         var _loc2_:ApplicationDomain = null;
         _loc2_ = ApplicationDomain.currentDomain;
         var _loc3_:Class = _loc2_.getDefinition("com.supermechs.soundsLibrary." + param1) as Class;
         return new _loc3_() as Sound;
      }
      
      public function getMusic(param1:String) : Sound
      {
         var _loc2_:Class = null;
         var _loc3_:Sound = null;
         var _loc4_:ApplicationDomain = null;
         _loc4_ = ApplicationDomain.currentDomain;
         if(this._musicLoaded)
         {
            _loc2_ = _loc4_.getDefinition("com.supermechs.musicLibrary." + param1) as Class;
            _loc3_ = new _loc2_() as Sound;
         }
         else
         {
            TsLogger.log("MUSIC MANAGER ERROR : CANNOT PLAYER MUSIC, MUSIC LIBRARY DOWNLOAD HAS NOT BEEN COMPLETED");
            if(this.itemEditorPointer != null)
            {
               this["itemEditorPointer"].addTrace("MUSIC MANAGER ERROR : CANNOT PLAYER MUSIC, MUSIC LIBRARY DOWNLOAD HAS NOT BEEN COMPLETED");
            }
         }
         return _loc3_;
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
            if(int(_loc2_.txtVersion.text) < this.version_items1)
            {
               this.clientNotUpToDateMessage = "ERROR : items1 version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.version_items1;
               TsLogger.log(this.clientNotUpToDateMessage);
               if(this.itemEditorPointer != null)
               {
                  this["itemEditorPointer"].addTrace("ERROR : items1 version is not up to date");
               }
            }
            else
            {
               _loc2_ = this.getAsset("items2","mcClientVersion");
               if(int(_loc2_.txtVersion.text) < this.version_items2)
               {
                  this.clientNotUpToDateMessage = "ERROR : items2 version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.version_items2;
                  TsLogger.log(this.clientNotUpToDateMessage);
                  if(this.itemEditorPointer != null)
                  {
                     this["itemEditorPointer"].addTrace("ERROR : items2 version is not up to date");
                  }
               }
               else
               {
                  _loc2_ = this.getAsset("items3","mcClientVersion");
                  if(int(_loc2_.txtVersion.text) < this.version_items3)
                  {
                     this.clientNotUpToDateMessage = "ERROR : items3 version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.version_items3;
                     TsLogger.log(this.clientNotUpToDateMessage);
                     if(this.itemEditorPointer != null)
                     {
                        this["itemEditorPointer"].addTrace("ERROR : items3 version is not up to date");
                     }
                  }
                  else
                  {
                     _loc2_ = this.getAsset("general","mcClientVersion");
                     if(int(_loc2_.txtVersion.text) < this.version_general)
                     {
                        this.clientNotUpToDateMessage = "ERROR : general version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.version_general;
                        TsLogger.log(this.clientNotUpToDateMessage);
                        if(this.itemEditorPointer != null)
                        {
                           this["itemEditorPointer"].addTrace("ERROR : general version is not up to date");
                        }
                     }
                     else
                     {
                        _loc2_ = this.getAsset("sound","mcClientVersion");
                        if(int(_loc2_.txtVersion.text) < this.version_sound)
                        {
                           this.clientNotUpToDateMessage = "ERROR : sound version is not up to date | SWF version : " + _loc2_.txtVersion.text + " | manager version : " + this.version_sound;
                           TsLogger.log(this.clientNotUpToDateMessage);
                           if(this.itemEditorPointer != null)
                           {
                              this["itemEditorPointer"].addTrace("ERROR : sound version is not up to date");
                           }
                        }
                        else if(this.CLIENT_VERSION_PC < this.version_client_pc)
                        {
                           this.clientNotUpToDateMessage = "ERROR : client version is not up to date | SERVER version : " + this.version_client_pc + " | manager version : " + this.CLIENT_VERSION_PC;
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

