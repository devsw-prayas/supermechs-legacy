package libraries.uanalytics.tracking
{
   import flash.utils.Dictionary;
   
   public class Metadata
   {
      
      public static const FIELD_PREFIX:String = "&";
      
      private var _nameToParameterMap:Dictionary = new Dictionary();
      
      private var _patternToParameterMap:Dictionary = new Dictionary();
      
      public function Metadata()
      {
         super();
         this.addAlias(Tracker.PROTOCOL_VERSION,"v");
         this.addAlias(Tracker.TRACKING_ID,"tid");
         this.addAlias(Tracker.ANON_IP,"aip");
         this.addAlias(Tracker.DATA_SOURCE,"ds");
         this.addAlias(Tracker.QUEUE_TIME,"qt");
         this.addAlias(Tracker.CACHE_BUSTER,"z");
         this.addAlias(Tracker.CLIENT_ID,"cid");
         this.addAlias(Tracker.USER_ID,"uid");
         this.addAlias(Tracker.SESSION_CONTROL,"sc");
         this.addAlias(Tracker.IP_OVERRIDE,"uip");
         this.addAlias(Tracker.USER_AGENT_OVERRIDE,"ua");
         this.addAlias(Tracker.GEOGRAPHICAL_OVERRIDE,"geoid");
         this.addAlias(Tracker.DOCUMENT_REFERRER,"dr");
         this.addAlias(Tracker.CAMPAIGN_NAME,"cn");
         this.addAlias(Tracker.CAMPAIGN_SOURCE,"cs");
         this.addAlias(Tracker.CAMPAIGN_MEDIUM,"cm");
         this.addAlias(Tracker.CAMPAIGN_KEYWORD,"ck");
         this.addAlias(Tracker.CAMPAIGN_CONTENT,"cc");
         this.addAlias(Tracker.CAMPAIGN_ID,"ci");
         this.addAlias(Tracker.GOOGLE_ADWORDS_ID,"gclid");
         this.addAlias(Tracker.GOOGLE_DISPLAY_ADS_ID,"dclid");
         this.addAlias(Tracker.SCREEN_RESOLUTION,"sr");
         this.addAlias(Tracker.VIEWPORT_SIZE,"vp");
         this.addAlias(Tracker.DOCUMENT_ENCODING,"de");
         this.addAlias(Tracker.SCREEN_COLORS,"sd");
         this.addAlias(Tracker.USER_LANGUAGE,"ul");
         this.addAlias(Tracker.JAVA_ENABLED,"je");
         this.addAlias(Tracker.FLASH_VERSION,"fl");
         this.addAlias(Tracker.HIT_TYPE,"t");
         this.addAlias(Tracker.NON_INTERACTION,"ni");
         this.addAlias(Tracker.DOCUMENT_LOCATION,"dl");
         this.addAlias(Tracker.DOCUMENT_HOSTNAME,"dh");
         this.addAlias(Tracker.DOCUMENT_PATH,"dp");
         this.addAlias(Tracker.DOCUMENT_TITLE,"dt");
         this.addAlias(Tracker.SCREEN_NAME,"cd");
         this.addAlias(Tracker.LINK_ID,"linkid");
         this.addAlias(Tracker.APP_NAME,"an");
         this.addAlias(Tracker.APP_ID,"aid");
         this.addAlias(Tracker.APP_VERSION,"av");
         this.addAlias(Tracker.APP_INSTALLER_ID,"aiid");
         this.addAlias(Tracker.EVENT_CATEGORY,"ec");
         this.addAlias(Tracker.EVENT_ACTION,"ea");
         this.addAlias(Tracker.EVENT_LABEL,"el");
         this.addAlias(Tracker.EVENT_VALUE,"ev");
         this.addAlias(Tracker.TRANSACTION_ID,"ti");
         this.addAlias(Tracker.TRANSACTION_AFFILIATION,"ta");
         this.addAlias(Tracker.TRANSACTION_REVENUE,"tr");
         this.addAlias(Tracker.TRANSACTION_SHIPPING,"ts");
         this.addAlias(Tracker.TRANSACTION_TAX,"tt");
         this.addAlias(Tracker.ITEM_NAME,"in");
         this.addAlias(Tracker.ITEM_PRICE,"ip");
         this.addAlias(Tracker.ITEM_QUANTITY,"iq");
         this.addAlias(Tracker.ITEM_CODE,"ic");
         this.addAlias(Tracker.ITEM_CATEGORY,"iv");
         this.addAlias(Tracker.CURRENCY_CODE,"cu");
         this.addAlias(Tracker.PRODUCT_ACTION,"pa");
         this.addAlias(Tracker.COUPON_CODE,"tcc");
         this.addAlias(Tracker.PRODUCT_ACTION_LIST,"pal");
         this.addAlias(Tracker.CHECKOUT_STEP,"cos");
         this.addAlias(Tracker.CHECKOUT_STEP_OPTION,"col");
         this.addAlias(Tracker.PROMOTION_ACTION,"promoa");
         this.addAlias(Tracker.SOCIAL_NETWORK,"sn");
         this.addAlias(Tracker.SOCIAL_ACTION,"sa");
         this.addAlias(Tracker.SOCIAL_TARGET,"st");
         this.addAlias(Tracker.USER_TIMING_CATEGORY,"utc");
         this.addAlias(Tracker.USER_TIMING_VAR,"utv");
         this.addAlias(Tracker.USER_TIMING_TIME,"utt");
         this.addAlias(Tracker.USER_TIMING_LABEL,"utl");
         this.addAlias(Tracker.PAGE_LOAD_TIME,"plt");
         this.addAlias(Tracker.DNS_TIME,"dns");
         this.addAlias(Tracker.PAGE_DOWNLOAD_TIME,"pdt");
         this.addAlias(Tracker.REDIRECT_RESPONSE_TIME,"rrt");
         this.addAlias(Tracker.TCP_CONNECT_TIME,"tcp");
         this.addAlias(Tracker.SERVER_RESPONSE_TIME,"srt");
         this.addAlias(Tracker.DOM_INTERACTIVE_TIME,"dit");
         this.addAlias(Tracker.CONTENT_LOAD_TIME,"clt");
         this.addAlias(Tracker.EXCEPT_DESCRIPTION,"exd");
         this.addAlias(Tracker.EXCEPT_FATAL,"exf");
         this.addPatternAlias("dimension([0-9]+)","cd");
         this.addPatternAlias("metric([0-9]+)","cm");
      }
      
      private function _getKeyFromPattern(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:RegExp = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         for(_loc2_ in this._patternToParameterMap)
         {
            _loc3_ = new RegExp(_loc2_);
            _loc4_ = _loc3_.exec(param1);
            if((Boolean(_loc4_)) && Boolean(_loc4_[1]))
            {
               _loc5_ = FIELD_PREFIX + this._patternToParameterMap[_loc2_] + _loc4_[1];
               this.addAlias(param1,_loc5_);
               return _loc5_;
            }
         }
         return param1;
      }
      
      protected function addAlias(param1:String, param2:String) : void
      {
         this._nameToParameterMap[param1] = FIELD_PREFIX + param2;
      }
      
      protected function addPatternAlias(param1:String, param2:String) : void
      {
         this._patternToParameterMap[param1] = param2;
      }
      
      public function getHitModelKey(param1:String) : String
      {
         if(param1.length > 0 && param1.charAt(0) == FIELD_PREFIX)
         {
            return param1;
         }
         var _loc2_:String = this._nameToParameterMap[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this._getKeyFromPattern(param1);
         }
         return _loc2_;
      }
   }
}

