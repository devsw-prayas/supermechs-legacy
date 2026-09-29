package net.battleMechsMulti.managers.externalImages
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class BMExternalImage extends MovieClip
   {
      
      public var imageLoader:Loader;
      
      public var imageUrl:String;
      
      private var _targetWidth:Number;
      
      private var _targetHeight:Number;
      
      private var _onLoadCompleteFunction:Function;
      
      public function BMExternalImage(param1:String, param2:Number = 0, param3:Number = 0, param4:Function = null)
      {
         super();
         this.imageUrl = param1;
         this._targetWidth = param2;
         this._targetHeight = param3;
         this._onLoadCompleteFunction = param4;
         var _loc5_:LoaderContext = new LoaderContext();
         _loc5_.checkPolicyFile = true;
         this.imageLoader = new Loader();
         this.imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.doneLoad);
         this.imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadingError);
         this.imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.updateInfo);
         this.imageLoader.load(new URLRequest(param1),_loc5_);
         addChild(this.imageLoader);
      }
      
      internal function updateInfo(param1:ProgressEvent) : void
      {
      }
      
      internal function loadingError(param1:IOErrorEvent) : void
      {
      }
      
      internal function doneLoad(param1:Event) : void
      {
         var bitmap:Bitmap = null;
         var $event:Event = param1;
         this.imageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.doneLoad);
         this.imageLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.updateInfo);
         this.imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadingError);
         if(this.imageLoader.content != null && this.imageLoader.content is Bitmap)
         {
            bitmap = Bitmap(this.imageLoader.content);
            bitmap.smoothing = true;
            bitmap.pixelSnapping = "never";
         }
         if(this._targetWidth > 0 && this._targetHeight > 0)
         {
            this.setSize(this._targetWidth,this._targetHeight);
         }
         if(this._onLoadCompleteFunction != null)
         {
            try
            {
               this._onLoadCompleteFunction();
            }
            catch(e:Error)
            {
               TsLogger.log("ExternalImage: onLoadComplete function screen does not exist");
            }
         }
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         width = param1;
         height = param2;
      }
   }
}

