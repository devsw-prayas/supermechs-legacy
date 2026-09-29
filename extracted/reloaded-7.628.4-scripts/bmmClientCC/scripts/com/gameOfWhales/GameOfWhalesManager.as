package com.gameOfWhales
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   
   public class GameOfWhalesManager extends Sprite
   {
      
      public static const PLATFORM_ANDROID:String = "android";
      
      public static const PLATFORM_IOS:String = "ios";
      
      public static const PLATFORM_MACOSX:String = "macosx";
      
      public static const PLATFORM_UWP:String = "uwp";
      
      public static const PLATFORM_WEB:String = "web";
      
      public static const STORE_AMAZON:String = "AmazonStore";
      
      public static const STORE_APPLE_APP_STORE:String = "AppleAppStore";
      
      public static const STORE_FACEBOOK:String = "Facebook";
      
      public static const STORE_GOOGLE_PLAY:String = "GooglePlay";
      
      public static const STORE_HUAWEI:String = "HuaweiStore";
      
      public static const STORE_KONGREGATE:String = "Kongregate";
      
      public static const STORE_MAC_APP:String = "MacAppStore";
      
      public static const STORE_ODNOKLASSNIKI:String = "Odnoklassniki";
      
      public static const STORE_SAMSUNG_APPS:String = "SamsungApps";
      
      public static const STORE_SFRPIXTEL:String = "SFRPixtel";
      
      public static const STORE_VK:String = "VK";
      
      public static const STORE_WINDOWS:String = "WindowsStore";
      
      public static const STORE_XIAOMI:String = "XiaomiStore";
      
      public static const STORE_OTHER:String = "Other";
      
      public static const PUSH_NOT_PROVIDER_APN:String = "apn";
      
      public static const PUSH_NOT_PROVIDER_GCM:String = "gcm";
      
      public static const PUSH_NOT_PROVIDER_FCM:String = "fcm";
      
      public static const AD_ACTION_LOADED:String = "loaded";
      
      public static const AD_ACTION_SHOWED:String = "showed";
      
      public static const AD_ACTION_CLICKED:String = "clicked";
      
      public static const DEFAULT_COUNTRY_CODE:String = "00";
      
      public static const SUPPORTED_COUNTRY_CODES:Array = ["AD","AE","AF","AG","AI","AL","AM","AO","AQ","AR","AS","AT","AU","AW","AX","AZ","BA","BB","BD","BE","BF","BG","BH","BI","BJ","BL","BM","BN","BO","BQ","BR","BS","BT","BV","BW","BY","BZ","CA","CC","CD","CF","CG","CH","CI","CK","CL","CM","CN","CO","CR","CU","CV","CW","CX","CY","CZ","DE","DJ","DK","DM","DO","DZ","EC","EE","EG","EH","ER","ES","ET","FI","FJ","FK","FM","FO","FR","GA","GB","GD","GE","GF","GG","GH","GI","GL","GM","GN","GP","GQ","GR","GS","GT","GU","GW","GY","HK","HM","HN","HR","HT","HU","ID","IE","IL","IM","IN","IO","IQ","IR","IS","IT","JE","JM","JO","JP","KE","KG","KH","KI","KM","KN","KP","KR","KW","KY","KZ","LA","LB","LC","LI","LK","LR","LS","LT","LU","LV","LY","MA","MC","MD","ME","MF","MG","MH","MK","ML","MM","MN","MO","MP","MQ","MR","MS","MT","MU","MV","MW","MX","MY","MZ","NA","NC","NE","NF","NG","NI","NL","NO","NP","NR","NU","NZ","OM","PA","PE","PF","PG","PH","PK","PL","PM","PN","PR","PS","PT","PW","PY","QA","RE","RO","RS"
      ,"RU","RW","SA","SB","SC","SD","SE","SG","SH","SI","SJ","SK","SL","SM","SN","SO","SR","SS","ST","SV","SX","SY","SZ","TC","TD","TF","TG","TH","TJ","TK","TL","TM","TN","TO","TR","TT","TV","TW","TZ","UA","UG","UM","US","UY","UZ","VA","VC","VE","VG","VI","VN","VU","WF","WS","YE","YT","ZA","ZM","ZW","00"];
      
      private var currentTimestamp:Function;
      
      private var _userProperties:GameOfWhaleUserProperties = null;
      
      private var _userReceipts:Vector.<GameOfWhalesReceiptInfo> = new Vector.<GameOfWhalesReceiptInfo>();
      
      private var _userOffers:Vector.<GameOfWhalesOffer> = new Vector.<GameOfWhalesOffer>();
      
      private var _userFutureOffers:Vector.<GameOfWhalesOffer> = new Vector.<GameOfWhalesOffer>();
      
      private var _gameKey:String;
      
      private var _userID:String;
      
      private var _latestVersion:String;
      
      private var _platform:String;
      
      private var _store:String;
      
      private var _localization:String;
      
      private var _ip:String;
      
      private var _coountry:String;
      
      private var _pendingRequests:Array = new Array();
      
      private var GAME_OF_WHALES_URL:String = "https://api.gameofwhales.com:8488/";
      
      public const RECEIPT_LEGAL:String = "legal";
      
      public const RECEIPT_ILLEGAL:String = "illegal";
      
      public const RECEIPT_UNDEFINED:String = "undefined";
      
      public const RECEIPT_BYPASS:String = "bypass";
      
      public const RECEIPT_DOUBLE:String = "double";
      
      public function GameOfWhalesManager(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:Function = null)
      {
         super();
         this._gameKey = param1;
         this._userID = param2;
         this._ip = param3;
         this._coountry = param4;
         this._platform = param5;
         this._store = param6;
         this._localization = param7;
         if(this._coountry != null)
         {
            this._coountry = this._coountry.toUpperCase();
            if(SUPPORTED_COUNTRY_CODES.indexOf(this._coountry) == -1)
            {
               this._coountry = DEFAULT_COUNTRY_CODE;
            }
         }
         if(param8 == null)
         {
            this.currentTimestamp = this.localTimestamp;
         }
         else
         {
            this.currentTimestamp = param8;
         }
         this.doHello();
      }
      
      private function localTimestamp() : Number
      {
         var _loc1_:Date = new Date();
         return _loc1_.time;
      }
      
      public function doHello() : void
      {
         this.sendRequest("",null,null,URLRequestMethod.GET);
      }
      
      public function setLoginInfo() : void
      {
         this.sendRequest("login",null,{"at":this.currentTimestamp()});
      }
      
      public function setReceipt(param1:String, param2:Number, param3:String, param4:String) : void
      {
         var _loc5_:Object = new Object();
         _loc5_.currency = param1;
         _loc5_.price = param2;
         _loc5_.receipt = param3;
         _loc5_.transactionId = param4;
         _loc5_.at = this.currentTimestamp();
         this.sendRequest("receipt",null,_loc5_);
      }
      
      public function setPurchase(param1:String, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:Boolean = true) : void
      {
         var _loc8_:Object = new Object();
         _loc8_.currency = param1;
         _loc8_.price = param2;
         _loc8_.product = param3;
         _loc8_.store = param4;
         _loc8_.receipt = param5;
         _loc8_.transactionId = param6;
         _loc8_.verify = param7;
         _loc8_.at = this.currentTimestamp();
         this.sendRequest("purchase",null,_loc8_);
      }
      
      public function setConversion(param1:Object, param2:String = "") : void
      {
         var _loc3_:Object = new Object();
         _loc3_.resources = param1;
         if(param2 != "")
         {
            _loc3_.place = param2;
         }
         _loc3_.at = this.currentTimestamp();
         this.sendRequest("converting",null,_loc3_);
      }
      
      public function resourcesConsumed(param1:uint, param2:String, param3:String, param4:String = "") : void
      {
         var _loc5_:Object = new Object();
         _loc5_.amount = param1;
         _loc5_.currency = param2;
         _loc5_.sink = param3;
         if(param4 != "")
         {
            _loc5_.place = param4;
         }
         _loc5_.at = this.currentTimestamp();
         this.sendRequest("consume",null,_loc5_);
      }
      
      public function resourcesAcquired(param1:uint, param2:String, param3:String, param4:String = "") : void
      {
         var _loc5_:Object = new Object();
         _loc5_.amount = param1;
         _loc5_.currency = param2;
         _loc5_.source = param3;
         if(param4 != "")
         {
            _loc5_.place = param4;
         }
         _loc5_.at = this.currentTimestamp();
         this.sendRequest("acquire",null,_loc5_);
      }
      
      public function getOffers() : void
      {
         this.sendRequest("offers");
      }
      
      public function getFutureOffers() : void
      {
         this.sendRequest("futureOffers");
      }
      
      public function setProfile(param1:Object) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.params = param1;
         _loc2_.at = this.currentTimestamp();
         this.sendRequest("profile",null,_loc2_);
      }
      
      public function setDeviceToken(param1:String, param2:String) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.token = param1;
         _loc3_.provider = param2;
         _loc3_.at = this.currentTimestamp();
         this.sendRequest("token",null,_loc3_);
      }
      
      public function pushNotificationDelivered(param1:String) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.camp = param1;
         _loc2_.at = this.currentTimestamp();
         this.sendRequest("pushDelivered",null,_loc2_);
      }
      
      public function pushNotificationReacted(param1:String) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.camp = param1;
         _loc2_.at = this.currentTimestamp();
         this.sendRequest("pushReacted",null,_loc2_);
      }
      
      public function getAdsInfo() : void
      {
         this.sendRequest("ads");
      }
      
      public function setAdAction(param1:String, param2:String) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.camp = param1;
         _loc3_.adAction = param2;
         _loc3_.at = this.currentTimestamp();
         this.sendRequest("adAction",null,_loc3_);
      }
      
      private function addPendingRequest(param1:String, param2:Object = null, param3:Object = null, param4:String = "POST") : void
      {
         var _loc5_:GameOfWhalesPendingRequest = new GameOfWhalesPendingRequest(param1,param2,param3,param4);
         this._pendingRequests.push(_loc5_);
      }
      
      private function tryToCallPendingRequest() : void
      {
         if(this._pendingRequests.length == 0)
         {
            return;
         }
         var _loc1_:GameOfWhalesPendingRequest = this._pendingRequests[0];
         var _loc2_:String = _loc1_.method;
         var _loc3_:Object = _loc1_.commonExtras;
         var _loc4_:Object = _loc1_.event;
         var _loc5_:String = _loc1_.requestMethod;
         _loc1_ = null;
         this._pendingRequests.splice(0,1);
         this.sendRequest(_loc2_,_loc3_,_loc4_,_loc5_,true);
      }
      
      private function sendRequest(param1:String, param2:Object = null, param3:Object = null, param4:String = "POST", param5:Boolean = false) : void
      {
         var loader:URLLoader;
         var request:URLRequest = null;
         var $method:String = param1;
         var $commonExtras:Object = param2;
         var $event:Object = param3;
         var $requestMethod:String = param4;
         var $isPending:Boolean = param5;
         if($method != "" && (this._latestVersion == null || $isPending == false && this._pendingRequests.length > 0))
         {
            this.addPendingRequest($method,$commonExtras,$event,$requestMethod);
            dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.TEMP,{"output":"REQUEST DELAYED: " + $method}));
            return;
         }
         loader = new URLLoader();
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.httpStatusHandler);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         loader.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         try
         {
            request = new URLRequest(this.GAME_OF_WHALES_URL + $method);
            request.method = $requestMethod;
            request.contentType = "application/json";
            request.data = JSON.stringify(this.getVariables($commonExtras,$event));
            loader.load(request);
            dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.TEMP,{"output":"REQUEST: " + JSON.stringify(request)}));
         }
         catch(error:Error)
         {
            trace("Error loading URL: " + error.message);
            dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.TEMP,{"output":"ERROR :" + error.message}));
         }
      }
      
      internal function loaderCompleteHandler(param1:Event) : void
      {
         this.resultHandler(param1.target.data);
      }
      
      internal function httpStatusHandler(param1:HTTPStatusEvent) : void
      {
         dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.TEMP,{"output":"httpStatusHandler: " + JSON.stringify(param1)}));
      }
      
      internal function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.TEMP,{"output":"securityErrorHandler: " + JSON.stringify(param1.text)}));
      }
      
      internal function ioErrorHandler(param1:IOErrorEvent) : void
      {
         dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.TEMP,{"output":"ioErrorHandler: " + JSON.stringify(param1.text)}));
      }
      
      private function resultHandler(param1:String) : void
      {
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:GameOfWhalesReceiptInfo = null;
         var _loc8_:GameOfWhalesOffer = null;
         var _loc9_:GameOfWhalesOffer = null;
         var _loc2_:Object = JSON.parse(param1);
         dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.TEMP,{"output":"RESULT: " + param1}));
         var _loc3_:Boolean = false;
         if(_loc2_.latestVersion != null)
         {
            this._latestVersion = _loc2_.latestVersion;
            _loc3_ = true;
         }
         this._userProperties = null;
         if(_loc2_.properties != null)
         {
            this._userProperties = new GameOfWhaleUserProperties(_loc2_.properties);
         }
         var _loc4_:Number = 0;
         if(_loc2_.serverTime != null)
         {
            _loc4_ = Number(_loc2_.serverTime);
         }
         if(this._userReceipts == null)
         {
            this._userReceipts = new Vector.<GameOfWhalesReceiptInfo>();
         }
         if(_loc2_.receipts != null)
         {
            this._userReceipts = new Vector.<GameOfWhalesReceiptInfo>();
            for each(_loc6_ in _loc2_.receipts)
            {
               _loc7_ = new GameOfWhalesReceiptInfo(_loc6_);
               this._userReceipts.push(_loc7_);
            }
         }
         if(this._userOffers == null)
         {
            this._userOffers = new Vector.<GameOfWhalesOffer>();
         }
         if(_loc2_.offers != null)
         {
            this._userOffers = new Vector.<GameOfWhalesOffer>();
            dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.TEMP,{"output":"OFFERS"}));
            for(_loc5_ in _loc2_.offers)
            {
               _loc2_.offers[_loc5_].product = _loc5_;
               _loc8_ = new GameOfWhalesOffer(_loc2_.offers[_loc5_]);
               this._userOffers.push(_loc8_);
            }
            dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.TEMP,{"output":"OFFERS: " + JSON.stringify(this._userOffers)}));
            dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.GOT_OFFERS));
         }
         if(this._userFutureOffers == null)
         {
            this._userFutureOffers = new Vector.<GameOfWhalesOffer>();
         }
         if(_loc2_.futureOffers != null)
         {
            this._userFutureOffers = new Vector.<GameOfWhalesOffer>();
            for(_loc5_ in _loc2_.futureOffers)
            {
               _loc2_.futureOffers[_loc5_].product = _loc5_;
               _loc9_ = new GameOfWhalesOffer(_loc2_.futureOffers[_loc5_]);
               this._userFutureOffers.push(_loc9_);
            }
         }
         if(_loc3_)
         {
            dispatchEvent(new GameOfWhalesEvent(GameOfWhalesEvent.VERSION_SET));
         }
         this.tryToCallPendingRequest();
      }
      
      public function get userProperties() : GameOfWhaleUserProperties
      {
         return this._userProperties;
      }
      
      public function get receipts() : Vector.<GameOfWhalesReceiptInfo>
      {
         return this._userReceipts;
      }
      
      public function get currentOffers() : Vector.<GameOfWhalesOffer>
      {
         return this._userOffers;
      }
      
      public function get futureOffers() : Vector.<GameOfWhalesOffer>
      {
         return this._userFutureOffers;
      }
      
      public function getVariables(param1:Object = null, param2:Object = null) : Object
      {
         var _loc4_:String = null;
         var _loc3_:Object = new Object();
         _loc3_.game = this.gameKey;
         _loc3_.user = this.userID;
         _loc3_.common = {
            "locale":this.local,
            "platform":this.platform,
            "store":this.store,
            "version":this.version
         };
         if(this._ip != null)
         {
            _loc3_.common["ip"] = this.ip;
         }
         else
         {
            _loc3_.common["country"] = this.country;
         }
         for(_loc4_ in param1)
         {
            _loc3_.common[_loc4_] = param1[_loc4_];
         }
         if(param2 != null)
         {
            _loc3_.event = param2;
         }
         return _loc3_;
      }
      
      private function get gameKey() : String
      {
         return this._gameKey;
      }
      
      public function get userID() : String
      {
         return this._userID;
      }
      
      public function set userID(param1:String) : void
      {
         this._userID = param1;
      }
      
      private function get ip() : String
      {
         return this._ip;
      }
      
      private function get country() : String
      {
         return this._coountry;
      }
      
      private function get local() : String
      {
         return this._localization;
      }
      
      private function get platform() : String
      {
         return this._platform;
      }
      
      private function get store() : String
      {
         return this._store;
      }
      
      private function get version() : String
      {
         return this._latestVersion;
      }
   }
}

