package libraries.uanalytics.tracker
{
   import flash.events.NetStatusEvent;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   import flash.system.ApplicationDomain;
   import libraries.uanalytics.tracker.senders.LoaderHitSender;
   import libraries.uanalytics.tracking.Configuration;
   import libraries.uanalytics.tracking.HitModel;
   import libraries.uanalytics.tracking.RateLimiter;
   import libraries.uanalytics.tracking.Tracker;
   import libraries.uanalytics.utils.generateUUID;
   
   public class AppTracker extends DefaultTracker
   {
      
      protected var _storage:SharedObject;
      
      public function AppTracker(param1:String = "", param2:Configuration = null)
      {
         super(param1,param2);
      }
      
      override protected function _ctor(param1:String = "") : void
      {
         var _loc3_:Class = null;
         _model = new HitModel();
         _temporary = new HitModel();
         if(_config.senderType != "")
         {
            _loc3_ = ApplicationDomain.currentDomain.getDefinition(_config.senderType) as Class;
            _sender = new _loc3_(this);
         }
         else
         {
            _sender = new LoaderHitSender(this);
         }
         _limiter = new RateLimiter(20,2,1);
         if(param1 != "")
         {
            set(TRACKING_ID,param1);
         }
         var _loc2_:String = this._getClientID();
         if(_loc2_ != "")
         {
            set(CLIENT_ID,_loc2_);
         }
         set(Tracker.DATA_SOURCE,DataSource.APP);
      }
      
      override protected function _getClientID() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         this._storage = SharedObject.getLocal(_config.storageName);
         if(!this._storage.data.clientid)
         {
            _loc1_ = generateUUID();
            this._storage.data.clientid = _loc1_;
            _loc2_ = null;
            try
            {
               _loc2_ = this._storage.flush(1024);
            }
            catch(e:Error)
            {
            }
            if(_loc2_ != null)
            {
               switch(_loc2_)
               {
                  case SharedObjectFlushStatus.PENDING:
                     this._storage.addEventListener(NetStatusEvent.NET_STATUS,this.onFlushStatus);
                     break;
                  case SharedObjectFlushStatus.FLUSHED:
               }
            }
         }
         else
         {
            _loc1_ = this._storage.data.clientid;
         }
         return _loc1_;
      }
      
      protected function onFlushStatus(param1:NetStatusEvent) : void
      {
         this._storage.removeEventListener(NetStatusEvent.NET_STATUS,this.onFlushStatus);
         switch(param1.info.code)
         {
            case "SharedObject.Flush.Success":
            case "SharedObject.Flush.Failed":
         }
      }
   }
}

