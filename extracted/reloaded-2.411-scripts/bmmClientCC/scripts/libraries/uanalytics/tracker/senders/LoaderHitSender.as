package libraries.uanalytics.tracker.senders
{
   import flash.display.Loader;
   import flash.errors.IOError;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import libraries.uanalytics.tracking.AnalyticsTracker;
   import libraries.uanalytics.tracking.HitModel;
   import libraries.uanalytics.tracking.HitSender;
   
   public class LoaderHitSender extends HitSender
   {
      
      protected var _tracker:AnalyticsTracker;
      
      protected var _loader:Loader;
      
      public function LoaderHitSender(param1:AnalyticsTracker)
      {
         super();
         this._tracker = param1;
         this._loader = new Loader();
      }
      
      protected function _hookEvents() : void
      {
         this._loader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.onUncaughtError);
         this._loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
      }
      
      protected function _unhookEvents() : void
      {
         this._loader.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.onUncaughtError);
         this._loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onComplete);
      }
      
      protected function onUncaughtError(param1:UncaughtErrorEvent) : void
      {
         var _loc2_:Error = null;
         var _loc3_:ErrorEvent = null;
         this._unhookEvents();
         if(param1.error is Error)
         {
            _loc2_ = param1.error as Error;
         }
         else if(param1.error is ErrorEvent)
         {
            _loc3_ = param1.error as ErrorEvent;
            _loc2_ = new Error(_loc3_.text,_loc3_.errorID);
         }
         else
         {
            _loc2_ = new Error("a non-Error, non-ErrorEvent type was thrown and uncaught");
         }
         if(this._tracker.config.enableErrorChecking)
         {
            throw _loc2_;
         }
      }
      
      protected function onHTTPStatus(param1:HTTPStatusEvent) : void
      {
      }
      
      protected function onIOError(param1:IOErrorEvent) : void
      {
         var _loc2_:IOError = null;
         this._unhookEvents();
         if(this._tracker.config.enableErrorChecking)
         {
            throw new IOError(param1.text,param1.errorID);
         }
      }
      
      protected function onComplete(param1:Event) : void
      {
         this._unhookEvents();
      }
      
      override public function send(param1:HitModel) : void
      {
         var request:URLRequest;
         var err:*;
         var model:HitModel = param1;
         var payload:String = _buildHit(model);
         var url:String = "";
         var sendViaPOST:Boolean = false;
         if(this._tracker.config.forcePOST || payload.length > this._tracker.config.maxGETlength)
         {
            sendViaPOST = true;
         }
         if(payload.length > this._tracker.config.maxPOSTlength)
         {
            throw new ArgumentError("POST data is bigger than " + this._tracker.config.maxPOSTlength + " bytes.");
         }
         if(this._tracker.config.forceSSL)
         {
            url = this._tracker.config.secureEndpoint;
         }
         else
         {
            url = this._tracker.config.endpoint;
         }
         request = new URLRequest();
         request.url = url;
         if(sendViaPOST)
         {
            request.method = URLRequestMethod.POST;
         }
         else
         {
            request.method = URLRequestMethod.GET;
         }
         request.data = payload;
         this._hookEvents();
         err = null;
         try
         {
            this._loader.load(request);
         }
         catch(e:IOError)
         {
            _unhookEvents();
            err = e;
         }
         catch(e:SecurityError)
         {
            _unhookEvents();
            err = e;
         }
         catch(e:IllegalOperationError)
         {
            _unhookEvents();
            err = e;
         }
         catch(e:Error)
         {
            _unhookEvents();
            err = e;
         }
         if(err)
         {
            throw err;
         }
      }
   }
}

