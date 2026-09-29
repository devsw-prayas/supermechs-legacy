package net.battleMechsMulti.managers
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.display.StageAlign;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.external.ExternalInterface;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.tacticsoft.global.BMMClientFlashVars;
   
   [SWF(width="800", height="480", backgroundColor="#000000", frameRate="30")]
   public class BMLoader extends MovieClip
   {
      
      private var clientLoader:Loader = new Loader();
      
      private var loadedFromGlobalLoader:Boolean;
      
      private var languageID:Number = 1;
      
      private var _chineseTextFormat:TextFormat = new TextFormat("_sans",20);
      
      public var loadingBar_client:BMBar;
      
      public var loadingBar_resources:BMBar;
      
      public var txtLoading_status:TextField;
      
      public var txtLoading_client:TextField;
      
      public var txtLoading_resources:TextField;
      
      public var txtKBLoaded:TextField;
      
      public var txtVersion:TextField;
      
      public var txtDebugger:TextField;
      
      public var mcMech:MovieClip;
      
      public var mcAvailableOnTheAppStore:MovieClip;
      
      public var mcAvailableOnGooglePlay:MovieClip;
      
      public function BMLoader()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.loaderAddedToStage);
      }
      
      private function loaderAddedToStage(param1:Event) : void
      {
         var _loc4_:Stage = null;
         var _loc12_:URLVariables = null;
         var _loc13_:String = null;
         trace("BMLoader initialized");
         this.addDebuggerText("INITIALIZED");
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         this.addDebuggerText("client loader initialized");
         this.txtDebugger.visible = false;
         _loc4_ = stage;
         this.loadedFromGlobalLoader = false;
         this.txtLoading_status.text = "Loading client...";
         this.txtLoading_client.text = "";
         this.txtLoading_resources.text = "";
         this.txtVersion.text = "";
         this.loadingBar_client.initialize("","right");
         this.loadingBar_client.setFill(0,false);
         this.loadingBar_client.addSeparateorLines(5);
         this.loadingBar_resources.initialize("","right");
         this.loadingBar_resources.setFill(0,false);
         this.loadingBar_resources.addSeparateorLines(5);
         this.configureListeners(this.clientLoader.contentLoaderInfo);
         trace("HERE IN LOADER");
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         _loc4_.align = StageAlign.TOP_LEFT;
         var _loc5_:BMMClientFlashVars = new BMMClientFlashVars(_loc4_);
         this.addDebuggerText("CLIENT PATH:" + _loc5_.clientPath);
         var _loc6_:LocalConnection = new LocalConnection();
         var _loc7_:* = _loc6_.domain;
         var _loc8_:String = _loc5_.resourceURL + _loc5_.clientPath;
         var _loc9_:URLRequest = new URLRequest(_loc8_);
         if(_loc7_ != "localhost" && _loc7_ != null)
         {
            _loc12_ = new URLVariables();
            _loc12_.version = _loc5_.version;
            _loc9_.data = _loc12_;
            _loc9_.method = URLRequestMethod.GET;
         }
         var _loc10_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         this.addDebuggerText("loading client...");
         this.addDebuggerText("URL request: " + _loc9_.url);
         this.addDebuggerText("URL request: " + _loc9_.contentType);
         this.addDebuggerText("current domain: " + _loc7_);
         _loc10_.parameters = _loc4_.loaderInfo.parameters;
         this.clientLoader.load(_loc9_,_loc10_);
         this.clientLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.clientLoadingComplete);
         addChild(this.clientLoader);
         this.clientLoader.visible = false;
         if(false == false)
         {
            this.txtVersion.text = _loc5_.version;
         }
         var _loc11_:Boolean = false;
         if(false == false)
         {
            if(ExternalInterface.available)
            {
               _loc13_ = ExternalInterface.call("window.location.href.toString");
               if(_loc13_ != null)
               {
                  if(_loc13_.indexOf("mcamp_id=851") > 0)
                  {
                     _loc11_ = true;
                  }
               }
            }
         }
         if(_loc11_)
         {
            this.mcAvailableOnTheAppStore.parent.removeChild(this.mcAvailableOnTheAppStore);
            this.mcAvailableOnGooglePlay.parent.removeChild(this.mcAvailableOnGooglePlay);
         }
         else
         {
            if(false == false)
            {
               this.mcAvailableOnTheAppStore.addEventListener(MouseEvent.CLICK,this.availableOnTheAppStoreClicked);
               this.mcAvailableOnTheAppStore.addEventListener(MouseEvent.MOUSE_UP,this.availableOnTheAppStoreMouseOut);
               this.mcAvailableOnTheAppStore.addEventListener(MouseEvent.MOUSE_OVER,this.availableOnTheAppStoreMouseOver);
               this.mcAvailableOnTheAppStore.addEventListener(MouseEvent.MOUSE_OUT,this.availableOnTheAppStoreMouseOut);
               this.mcAvailableOnTheAppStore.buttonMode = true;
               this.mcAvailableOnTheAppStore.useHandCursor = true;
               this.mcAvailableOnGooglePlay.addEventListener(MouseEvent.CLICK,this.availableOnGooglePlayClicked);
               this.mcAvailableOnGooglePlay.addEventListener(MouseEvent.MOUSE_UP,this.availableOnGooglePlayMouseOut);
               this.mcAvailableOnGooglePlay.addEventListener(MouseEvent.MOUSE_OVER,this.availableOnGooglePlayMouseOver);
               this.mcAvailableOnGooglePlay.addEventListener(MouseEvent.MOUSE_OUT,this.availableOnGooglePlayMouseOut);
               this.mcAvailableOnGooglePlay.buttonMode = true;
               this.mcAvailableOnGooglePlay.useHandCursor = true;
            }
            this.mcAvailableOnTheAppStore.mcMouseOverEffect.visible = false;
            this.mcAvailableOnGooglePlay.mcMouseOverEffect.visible = false;
         }
      }
      
      private function availableOnTheAppStoreClicked(param1:MouseEvent) : void
      {
         var _loc2_:String = "flash_0";
         this.openURL("https://itunes.apple.com/app/apple-store/id864103912?pt=1225303&ct=" + _loc2_ + "&mt=8","_blank");
      }
      
      private function availableOnTheAppStoreMouseOver(param1:MouseEvent) : void
      {
         this.mcAvailableOnTheAppStore.mcMouseOverEffect.visible = true;
      }
      
      private function availableOnTheAppStoreMouseOut(param1:MouseEvent) : void
      {
         this.mcAvailableOnTheAppStore.mcMouseOverEffect.visible = false;
      }
      
      private function availableOnGooglePlayClicked(param1:MouseEvent) : void
      {
         this.openURL("https://play.google.com/store/apps/details?id=air.com.supermechs.superapp&hl=en","_blank");
      }
      
      private function availableOnGooglePlayMouseOver(param1:MouseEvent) : void
      {
         this.mcAvailableOnGooglePlay.mcMouseOverEffect.visible = true;
      }
      
      private function availableOnGooglePlayMouseOut(param1:MouseEvent) : void
      {
         this.mcAvailableOnGooglePlay.mcMouseOverEffect.visible = false;
      }
      
      public function openURL(param1:String, param2:String) : void
      {
         navigateToURL(new URLRequest(param1),param2);
      }
      
      private function configureListeners(param1:IEventDispatcher) : void
      {
         param1.addEventListener(ProgressEvent.PROGRESS,this.progressHandler_client);
      }
      
      private function progressHandler_client(param1:ProgressEvent) : void
      {
         var _loc2_:* = param1.bytesLoaded / param1.bytesTotal;
         if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         this.txtLoading_client.text = Math.ceil(_loc2_ * 100) + "%";
         this.loadingBar_client.setFill(_loc2_,true);
      }
      
      public function progressHandler_resources(param1:Number) : void
      {
         if(param1 > 100)
         {
            param1 = 100;
         }
         this.txtLoading_resources.text = Math.ceil(param1) + "%";
         this.loadingBar_resources.setFill(param1 / 100,true);
         if(param1 == 100)
         {
            this.clientLoader.visible = true;
         }
         if(this.mcMech.currentLabel != "animDone" && param1 >= 99)
         {
            this.mcMech.gotoAndStop("animDone");
         }
      }
      
      public function progressHandler_status(param1:String) : void
      {
         this.txtLoading_status.text = param1;
         if(this.languageID == 2)
         {
            this.txtLoading_status.text = "加载";
         }
      }
      
      private function clientLoadingComplete(param1:Event) : void
      {
         this.addDebuggerText("loading resources...");
      }
      
      public function addDebuggerText(param1:String) : void
      {
      }
   }
}

