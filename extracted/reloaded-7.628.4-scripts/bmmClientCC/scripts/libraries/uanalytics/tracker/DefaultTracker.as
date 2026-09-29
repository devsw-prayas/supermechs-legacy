package libraries.uanalytics.tracker
{
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import libraries.uanalytics.tracker.senders.LoaderHitSender;
   import libraries.uanalytics.tracking.Configuration;
   import libraries.uanalytics.tracking.HitModel;
   import libraries.uanalytics.tracking.HitSampler;
   import libraries.uanalytics.tracking.RateLimitError;
   import libraries.uanalytics.tracking.RateLimiter;
   import libraries.uanalytics.tracking.Tracker;
   import libraries.uanalytics.utils.generateUUID;
   import libraries.uanalytics.utils.getHostname;
   
   public class DefaultTracker extends Tracker
   {
      
      public function DefaultTracker(param1:String = "", param2:Configuration = null)
      {
         super();
         if(!param2)
         {
            param2 = new Configuration();
         }
         _config = param2;
         this._ctor(param1);
      }
      
      protected function _ctor(param1:String = "") : void
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
         _limiter = new RateLimiter(100,10);
         if(param1 != "")
         {
            set(TRACKING_ID,param1);
         }
         var _loc2_:String = this._getClientID();
         if(_loc2_ != "")
         {
            set(CLIENT_ID,_loc2_);
         }
      }
      
      protected function _getClientID() : String
      {
         return generateUUID();
      }
      
      protected function _getCacheBuster() : String
      {
         var _loc1_:Date = new Date();
         var _loc2_:Number = Math.random();
         return String(_loc1_.valueOf() + _loc2_);
      }
      
      override public function send(param1:String = null, param2:Dictionary = null) : Boolean
      {
         var copy:HitModel;
         var err:Error;
         var entry:String = null;
         var hitType:String = param1;
         var tempValues:Dictionary = param2;
         if(trackingId == "" || trackingId == null)
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("tracking id is missing.");
            }
            return false;
         }
         if(clientId == "" || clientId == null)
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("client id is missing.");
            }
            return false;
         }
         copy = _model.clone();
         copy.add(_temporary);
         _temporary.clear();
         if(tempValues != null)
         {
            for(entry in tempValues)
            {
               copy.set(entry,tempValues[entry]);
            }
         }
         if((hitType != "" || hitType != null) && HitType.isValid(hitType))
         {
            copy.set(HIT_TYPE,hitType);
            if(Boolean(_config) && _config.enableSampling)
            {
               if(HitSampler.isSampled(copy,String(_config.sampleRate)))
               {
                  return false;
               }
            }
            if(Boolean(_config) && _config.enableThrottling)
            {
               if(!_limiter.consumeToken())
               {
                  if(Boolean(_config) && _config.enableErrorChecking)
                  {
                     throw new RateLimitError();
                  }
                  return false;
               }
            }
            if(Boolean(_config) && _config.enableCacheBusting)
            {
               copy.set(CACHE_BUSTER,this._getCacheBuster());
            }
            if(Boolean(_config) && _config.anonymizeIp)
            {
               copy.set(ANON_IP,"1");
            }
            if(Boolean(_config) && _config.overrideIpAddress != "")
            {
               copy.set(IP_OVERRIDE,_config.overrideIpAddress);
            }
            if(Boolean(_config) && _config.overrideUserAgent != "")
            {
               copy.set(USER_AGENT_OVERRIDE,_config.overrideUserAgent);
            }
            if(Boolean(_config) && _config.overrideGeographicalId != "")
            {
               copy.set(GEOGRAPHICAL_OVERRIDE,_config.overrideGeographicalId);
            }
            err = null;
            try
            {
               _sender.send(copy);
            }
            catch(e:Error)
            {
               err = e;
            }
            if(Boolean(_config) && Boolean(_config.enableErrorChecking) && Boolean(err))
            {
               throw err;
            }
            if(err)
            {
               return false;
            }
            return true;
         }
         if(Boolean(_config) && _config.enableErrorChecking)
         {
            throw new ArgumentError("hit type \"" + hitType + "\" is not valid.");
         }
         return false;
      }
      
      override public function pageview(param1:String, param2:String = "") : Boolean
      {
         if(param1 == null || param1 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("path is empty");
            }
            return false;
         }
         var _loc3_:Dictionary = new Dictionary();
         _loc3_[Tracker.DOCUMENT_PATH] = param1;
         if(Boolean(param2) && param2.length > 0)
         {
            if(param2.length > 1500)
            {
               if(Boolean(_config) && _config.enableErrorChecking)
               {
                  throw new ArgumentError("Title is bigger than 1500 bytes.");
               }
               return false;
            }
            _loc3_[Tracker.DOCUMENT_TITLE] = param2;
         }
         var _loc4_:String = get(Tracker.DOCUMENT_HOSTNAME);
         if(_loc4_ == null)
         {
            if(!(Tracker.DOCUMENT_HOSTNAME in _loc3_))
            {
               _loc4_ = getHostname();
               if(_loc4_ == "")
               {
                  if(Boolean(_config) && _config.enableErrorChecking)
                  {
                     throw new ArgumentError("hostname is not defined.");
                  }
                  return false;
               }
               _loc3_[Tracker.DOCUMENT_HOSTNAME] = _loc4_;
            }
         }
         return this.send(HitType.PAGEVIEW,_loc3_);
      }
      
      override public function screenview(param1:String, param2:Dictionary = null) : Boolean
      {
         var _loc5_:String = null;
         if(param1 == null || param1 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("name is empty");
            }
            return false;
         }
         var _loc3_:Dictionary = new Dictionary();
         if(param2 != null)
         {
            for(_loc5_ in param2)
            {
               _loc3_[_loc5_] = param2[_loc5_];
            }
         }
         var _loc4_:String = get(Tracker.APP_NAME);
         if(_loc4_ == null)
         {
            if(!(Tracker.APP_NAME in _loc3_))
            {
               if(Boolean(_config) && _config.enableErrorChecking)
               {
                  throw new ArgumentError("Application name is not defined.");
               }
               return false;
            }
         }
         _loc3_[Tracker.SCREEN_NAME] = param1;
         return this.send(HitType.SCREENVIEW,_loc3_);
      }
      
      override public function event(param1:String, param2:String, param3:String = "", param4:int = -1) : Boolean
      {
         if(param1 == null || param1 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("category is empty");
            }
            return false;
         }
         if(param2 == null || param2 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("action is empty");
            }
            return false;
         }
         var _loc5_:Dictionary = new Dictionary();
         _loc5_[Tracker.EVENT_CATEGORY] = param1;
         _loc5_[Tracker.EVENT_ACTION] = param2;
         if(param3 != "")
         {
            _loc5_[Tracker.EVENT_LABEL] = param3;
         }
         if(param4 > -1)
         {
            _loc5_[Tracker.EVENT_VALUE] = param4;
         }
         return this.send(HitType.EVENT,_loc5_);
      }
      
      override public function transaction(param1:String, param2:String = "", param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:String = "") : Boolean
      {
         if(param1 == null || param1 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("id is empty");
            }
            return false;
         }
         var _loc7_:Dictionary = new Dictionary();
         _loc7_[Tracker.TRANSACTION_ID] = param1;
         if(param2 != "")
         {
            _loc7_[Tracker.TRANSACTION_AFFILIATION] = param2;
         }
         _loc7_[Tracker.TRANSACTION_REVENUE] = param3;
         _loc7_[Tracker.TRANSACTION_SHIPPING] = param4;
         _loc7_[Tracker.TRANSACTION_TAX] = param5;
         if(param6 != "")
         {
            _loc7_[Tracker.CURRENCY_CODE] = param6;
         }
         return this.send(HitType.TRANSACTION,_loc7_);
      }
      
      override public function item(param1:String, param2:String, param3:Number = 0, param4:int = 0, param5:String = "", param6:String = "", param7:String = "") : Boolean
      {
         if(param1 == null || param1 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("transaction id is empty");
            }
            return false;
         }
         if(param2 == null || param2 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("name is empty");
            }
            return false;
         }
         var _loc8_:Dictionary = new Dictionary();
         _loc8_[Tracker.TRANSACTION_ID] = param1;
         _loc8_[Tracker.ITEM_NAME] = param2;
         _loc8_[Tracker.ITEM_PRICE] = param3;
         _loc8_[Tracker.ITEM_QUANTITY] = param4;
         if(param5 != "")
         {
            _loc8_[Tracker.ITEM_CODE] = param5;
         }
         if(param6 != "")
         {
            _loc8_[Tracker.ITEM_CATEGORY] = param6;
         }
         if(param7 != "")
         {
            _loc8_[Tracker.CURRENCY_CODE] = param7;
         }
         return this.send(HitType.ITEM,_loc8_);
      }
      
      override public function social(param1:String, param2:String, param3:String) : Boolean
      {
         if(param1 == null || param1 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("network is empty");
            }
            return false;
         }
         if(param2 == null || param2 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("action is empty");
            }
            return false;
         }
         if(param3 == null || param3 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("target is empty");
            }
            return false;
         }
         var _loc4_:Dictionary = new Dictionary();
         _loc4_[Tracker.SOCIAL_NETWORK] = param1;
         _loc4_[Tracker.SOCIAL_ACTION] = param2;
         _loc4_[Tracker.SOCIAL_TARGET] = param3;
         return this.send(HitType.SOCIAL,_loc4_);
      }
      
      override public function exception(param1:String = "", param2:Boolean = true) : Boolean
      {
         var _loc3_:Dictionary = new Dictionary();
         if(param1 != "")
         {
            _loc3_[Tracker.EXCEPT_DESCRIPTION] = param1;
         }
         if(param2)
         {
            _loc3_[Tracker.EXCEPT_FATAL] = "1";
         }
         else
         {
            _loc3_[Tracker.EXCEPT_FATAL] = "0";
         }
         return this.send(HitType.EXCEPTION,_loc3_);
      }
      
      override public function timing(param1:String, param2:String, param3:int, param4:String = "", param5:Dictionary = null) : Boolean
      {
         var _loc7_:String = null;
         if(param1 == null || param1 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("category is empty");
            }
            return false;
         }
         if(param2 == null || param2 == "")
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("name is empty");
            }
            return false;
         }
         if(param3 < 0)
         {
            if(Boolean(_config) && _config.enableErrorChecking)
            {
               throw new ArgumentError("value is empty");
            }
            return false;
         }
         var _loc6_:Dictionary = new Dictionary();
         _loc6_[Tracker.USER_TIMING_CATEGORY] = param1;
         _loc6_[Tracker.USER_TIMING_VAR] = param2;
         _loc6_[Tracker.USER_TIMING_TIME] = param3;
         if(param4 != "")
         {
            _loc6_[Tracker.USER_TIMING_LABEL] = param4;
         }
         if(param5 != null)
         {
            for(_loc7_ in param5)
            {
               _loc6_[_loc7_] = param5[_loc7_];
            }
         }
         return this.send(HitType.TIMING,_loc6_);
      }
   }
}

