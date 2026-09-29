package com.snowplowanalytics.snowplow.tracker
{
   import com.adobe.crypto.SHA1;
   import com.adobe.serialization.json.JSON;
   import com.snowplowanalytics.snowplow.tracker.emitter.Emitter;
   import com.snowplowanalytics.snowplow.tracker.payload.IPayload;
   import com.snowplowanalytics.snowplow.tracker.payload.SchemaPayload;
   import com.snowplowanalytics.snowplow.tracker.payload.TrackerPayload;
   import com.snowplowanalytics.snowplow.tracker.util.LocalStorage;
   import com.snowplowanalytics.snowplow.tracker.util.Preconditions;
   import de.aggro.utils.CookieUtil;
   import flash.display.Stage;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import flash.system.Capabilities;
   import flash.system.System;
   
   public class Tracker
   {
      
      private var localSharedObject:LocalStorage;
      
      private var cookieUserFingerprint:Number;
      
      private var appId:String;
      
      private var sharedObjectDomainHash:String = null;
      
      private var businessUserId:String = null;
      
      private var domainUserId:String;
      
      private var subject:Subject;
      
      private var configUserFingerprintHashSeed:Number = 123412414;
      
      private var customUrl:String = null;
      
      private var hasLocalStorage:Boolean;
      
      private var namespace:String;
      
      private var isDebugger:Boolean;
      
      private var platform:String;
      
      private var emitter:Emitter;
      
      private var trackerVersion:String;
      
      private var sharedObjectUserFingerprint:Number;
      
      private var browserFeatures:Object = null;
      
      private var configCookiePath:String = "/";
      
      private var localBoth:LocalStorage;
      
      private var cookieDomainHash:String = null;
      
      private var localCookies:LocalStorage;
      
      private var configStorageNamePrefix:String = "_sp_";
      
      private var playerVersion:String;
      
      private var playerType:String;
      
      private var base64Encoded:Boolean = true;
      
      private var javascriptInfo:Object = null;
      
      private var hasScriptAccess:Boolean;
      
      private var configSessionCookieTimeout:int = 1800;
      
      private var configVisitorCookieTimeout:int = 63072000;
      
      private var configStorageDomain:String = null;
      
      private var stage:Stage;
      
      public function Tracker(param1:Emitter, param2:String, param3:String, param4:Subject = null, param5:Stage = null, param6:Boolean = true)
      {
         var javascriptInfoScript:String = null;
         var fromQuerystringMethod:String = null;
         var getReferrerMethod:String = null;
         var locationArray:Array = null;
         var emitter:Emitter = param1;
         var namespace:String = param2;
         var appId:String = param3;
         var subject:Subject = param4;
         var stage:Stage = param5;
         var base64Encoded:Boolean = param6;
         localSharedObject = new LocalStorage(LocalStorage.SHARED_OBJECT);
         localCookies = new LocalStorage(LocalStorage.COOKIES);
         localBoth = new LocalStorage(LocalStorage.BOTH);
         super();
         this.emitter = emitter;
         this.appId = appId;
         this.base64Encoded = base64Encoded;
         this.namespace = namespace;
         this.subject = subject;
         this.trackerVersion = Version.TRACKER;
         this.platform = DevicePlatform.WEB;
         this.stage = stage;
         this.playerType = Capabilities.playerType;
         this.playerVersion = Capabilities.version;
         this.isDebugger = Capabilities.isDebugger;
         try
         {
            SharedObject.getLocal("test");
            this.hasLocalStorage = true;
         }
         catch(e:Error)
         {
            this.hasLocalStorage = false;
         }
         this.hasScriptAccess = Util.isScriptAccessAllowed();
         if(this.hasScriptAccess)
         {
            javascriptInfoScript = "function getJavascriptInfo() {\n " + "function cookie(name, value, ttl, path, domain, secure) {\n " + "\t\n " + "\tif (arguments.length > 1) {\n " + "\t\treturn document.cookie = name + \'=\' + encodeURIComponent(value) +\n " + "\t\t(ttl ? \'; expires=\' + new Date(+new Date()+(ttl*1000)).toUTCString() : \'\') +\n " + "\t\t(path   ? \'; path=\' + path : \'\') +\n " + "\t\t(domain ? \'; domain=\' + domain : \'\') +\n " + "\t\t(secure ? \'; secure\' : \'\')\n " + "\t}\n " + "\t\n " + "\treturn decodeURIComponent(((\'; \'+document.cookie).split(\'; \'+name+\'=\')[1]||\'\').split(\';\')[0])\n " + "}\n " + "function hasCookies () {\n" + "\tvar cookieName = \'testcookie\';\n" + "\t\n" + "\tif (typeof navigator.cookieEnabled == \'undefined\') {\n" + "\t\tcookie(cookieName, \'1\');\n" + "\t\treturn cookie(cookieName) === \'1\' ? \'1\' : \'0\';\n" + "\t}\n" + "\t\n" + "\treturn navigator.cookieEnabled ? \'1\' : \'0\';\n" + "}\n" + "function getMimeTypes () {\n" + "\tvar mimeTypes = [];\n" + "\tfor (var i=0; i < navigator.mimeTypes.length; i++) {\n" + "\t\tvar mimeType = navigator.mimeTypes[i];\n" + "\t\tmimeTypes.push({description: mimeType.description \n" + "\t\t\t\t\t\t, enabledPlugin: typeof mimeType.enabledPlugin != \'undefined\' \n" + "\t\t\t\t\t\t, suffixes: mimeType.suffixes \n" + "\t\t\t\t\t\t, type: mimeType.type \n" + "   \t\t\t\t   });\n" + "\t}\n" + "\treturn mimeTypes;\n" + "}\n" + "function getPlugins () {\n" + "\tvar plugins = [];\n" + "\tfor(var i = 0; i < navigator.plugins.length; i++)\n" + "\t{\n" + "\t\tplugins[i] = {};\n" + "\t\tfor(var j = 0; j < navigator.plugins[i].length; j++)\n" + "\t\t{\n" + "\t\t\tplugins[i][j] = {}\n" + "\t\t\tplugins[i][j].suffixes = navigator.plugins[i][j].suffixes;\n" + "\t\t\tplugins[i][j].type = navigator.plugins[i][j].type;\n" + "\t\t}\n" + "\t\tplugins[i].name = navigator.plugins[i].name;\n" + "\t\tplugins[i].description = navigator.plugins[i].description;\n" + "\t}\n" + "\treturn plugins;\n" + "}\n" + "function hasLocalStorage () {\n" + "  try {\n" + "    return !!window.localStorage;\n" + "  } catch (e) {\n" + "    return true; // SecurityError when referencing it means it exists\n" + "  }\n" + "}\n" + "function hasSessionStorage () {\n" + "  try {\n" + "    return !!window.sessionStorage;\n" + "  } catch (e) {\n" + "    return true; // SecurityError when referencing it means it exists\n" + "  }\n" + "}\n" + "return { " + "  cd: screen.colorDepth\n" + ", cookie: hasCookies()\n" + ", domain: document.domain\n" + ", gears: typeof window.GearsFactory == \'function\' ? \'1\' : \'0\' \n" + ", hasLocalStorage: hasLocalStorage()\n" + ", hasSessionStorage: hasSessionStorage()\n" + ", javaEnabled: typeof navigator.javaEnabled !== \'unknown\' && !navigator.hasOwnProperty(\'javaEnabled\') && navigator.javaEnabled() ? \'1\' : \'0\'\n" + ", mimeTypes: getMimeTypes()\n" + ", pageUrl: document.location.href\n" + ", platform: navigator.platform\n" + ", plugins: getPlugins()\n" + ", res: screen.width + \'x\' + screen.height\n" + ", title: document.title\n" + ", userAgent: navigator.userAgent \n" + "}; }";
            try
            {
               javascriptInfo = ExternalInterface.call(javascriptInfoScript);
            }
            catch(e:Error)
            {
               javascriptInfo = {};
            }
            fromQuerystringMethod = "function fromQuerystring (field, url) {\n" + "\tvar match = new RegExp(\'^[^#]*[?&]\' + field + \'=([^&#]*)\').exec(url);\n" + "\tif (!match) {\n" + "\t\treturn null;\n" + "\t}\n" + "\treturn decodeURIComponent(match[1].replace(/\\+/g, \' \'));\n" + "}";
            try
            {
               ExternalInterface.call(fromQuerystringMethod);
            }
            catch(e:Error)
            {
            }
            getReferrerMethod = "function getReferrer() { \n" + "var referrer = \'\';\n" + "var fromQs = fromQuerystring(\'referrer\', window.location.href) || " + "fromQuerystring(\'referer\', window.location.href);\n" + "\n" + "// Short-circuit\n" + "if (fromQs) {\n" + "\treturn fromQs;\n" + "}\n" + "\n" + "try {\n" + "\treferrer = window.top.document.referrer;\n" + "} catch (e) {\n" + "\tif (window.parent) {\n" + "\t\ttry {\n" + "\t\t\treferrer = window.parent.document.referrer;\n" + "\t\t} catch (e2) {\n" + "\t\t\treferrer = \'\';\n" + "\t\t}\n" + "\t}\n" + "}\n" + "if (referrer === \'\') {\n" + "\treferrer = document.referrer;\n" + "}\n" + "return referrer; }";
            try
            {
               javascriptInfo.referrer = ExternalInterface.call(getReferrerMethod);
            }
            catch(e:Error)
            {
               javascriptInfo.referrer = null;
            }
            locationArray = Util.fixupUrl(javascriptInfo.domain,javascriptInfo.pageUrl,javascriptInfo.referrer);
            javascriptInfo.domain = Util.fixupDomain(locationArray[0]);
            javascriptInfo.pageUrl = locationArray[1];
            javascriptInfo.referrer = locationArray[2];
            browserFeatures = detectBrowserFeatures();
            cookieUserFingerprint = detectJavascriptSignature(configUserFingerprintHashSeed);
         }
         else
         {
            javascriptInfo = {
               "cd":Capabilities.screenColor,
               "cookie":"0",
               "domain":"",
               "gears":null,
               "hasLocalStorage":false,
               "hasSessionStorage":false,
               "javaEnabled":null,
               "mimeTypes":null,
               "pageUrl":null,
               "platform":Capabilities.os,
               "plugins":null,
               "res":Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY,
               "title":null,
               "userAgent":null,
               "referrer":null
            };
            cookieUserFingerprint = NaN;
         }
         sharedObjectUserFingerprint = detectFlashSignature(configUserFingerprintHashSeed);
         updateCookieDomainHash();
      }
      
      public function trackStructuredEvent(param1:String, param2:String, param3:String, param4:String, param5:int, param6:Array = null, param7:Number = 0) : void
      {
         Preconditions.checkNotNull(param3);
         Preconditions.checkNotNull(param4);
         Preconditions.checkArgument(!Util.isNullOrEmpty(param3),"label cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param4),"property cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param1),"category cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param2),"action cannot be empty");
         var _loc8_:IPayload = new TrackerPayload();
         _loc8_.add(Parameter.EVENT,Constants.EVENT_STRUCTURED);
         _loc8_.add(Parameter.SE_CATEGORY,param1);
         _loc8_.add(Parameter.SE_ACTION,param2);
         _loc8_.add(Parameter.SE_LABEL,param3);
         _loc8_.add(Parameter.SE_PROPERTY,param4);
         _loc8_.add(Parameter.SE_VALUE,String(param5));
         completePayload(_loc8_,param6,param7);
         addTrackerPayload(_loc8_);
      }
      
      public function setUserIdFromStorage(param1:String) : void
      {
         businessUserId = localBoth.getLocal(param1);
      }
      
      public function trackUnstructuredEvent(param1:SchemaPayload, param2:Array = null, param3:Number = 0) : void
      {
         var _loc4_:SchemaPayload = new SchemaPayload();
         _loc4_.setSchema(Constants.SCHEMA_UNSTRUCT_EVENT);
         _loc4_.setData(param1.getMap());
         var _loc5_:IPayload = new TrackerPayload();
         _loc5_.add(Parameter.EVENT,Constants.EVENT_UNSTRUCTURED);
         _loc5_.addMap(_loc4_.getMap(),base64Encoded,Parameter.UNSTRUCTURED_ENCODED,Parameter.UNSTRUCTURED);
         completePayload(_loc5_,param2,param3);
         addTrackerPayload(_loc5_);
      }
      
      public function setReferrerUrl(param1:String) : void
      {
         javascriptInfo.referrer = param1;
      }
      
      public function setVisitorCookieTimeout(param1:int) : void
      {
         configVisitorCookieTimeout = param1;
      }
      
      protected function trackEcommerceTransactionItem(param1:String, param2:String, param3:Number, param4:int, param5:String, param6:String, param7:String, param8:Array, param9:Number) : void
      {
         Preconditions.checkNotNull(param5);
         Preconditions.checkNotNull(param6);
         Preconditions.checkNotNull(param7);
         Preconditions.checkArgument(!Util.isNullOrEmpty(param1),"order_id cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param2),"sku cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param5),"name cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param6),"category cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param7),"currency cannot be empty");
         var _loc10_:IPayload = new TrackerPayload();
         _loc10_.add(Parameter.EVENT,Constants.EVENT_ECOMM_ITEM);
         _loc10_.add(Parameter.TI_ITEM_ID,param1);
         _loc10_.add(Parameter.TI_ITEM_SKU,param2);
         _loc10_.add(Parameter.TI_ITEM_NAME,param5);
         _loc10_.add(Parameter.TI_ITEM_CATEGORY,param6);
         _loc10_.add(Parameter.TI_ITEM_PRICE,String(param3));
         _loc10_.add(Parameter.TI_ITEM_QUANTITY,String(param4));
         _loc10_.add(Parameter.TI_ITEM_CURRENCY,param7);
         completePayload(_loc10_,param8,param9);
         addTrackerPayload(_loc10_);
      }
      
      protected function completePayload(param1:IPayload, param2:Array, param3:Number) : IPayload
      {
         var _loc6_:SchemaPayload = null;
         var _loc7_:Array = null;
         var _loc8_:SchemaPayload = null;
         param1.add(Parameter.PLATFORM,this.platform);
         param1.add(Parameter.APPID,this.appId);
         param1.add(Parameter.NAMESPACE,this.namespace);
         param1.add(Parameter.TRACKER_VERSION,this.trackerVersion);
         param1.add(Parameter.EID,Util.getEventId());
         param1.add(Parameter.PAGE_URL,customUrl == null ? javascriptInfo.pageUrl : customUrl);
         param1.add(Parameter.PAGE_TITLE,javascriptInfo.title);
         param1.add(Parameter.PAGE_REFR,javascriptInfo.referrer);
         param1.add(Parameter.TIMESTAMP,param3 == 0 ? Util.getTimestamp() : String(param3));
         if(param2 == null)
         {
            param2 = [];
         }
         var _loc4_:TrackerPayload = new TrackerPayload();
         _loc4_.add(Parameter.FLASH_PLAYER_TYPE,playerType);
         _loc4_.add(Parameter.FLASH_VERSION,playerVersion);
         _loc4_.add(Parameter.FLASH_IS_DEBUGGER,isDebugger);
         _loc4_.add(Parameter.FLASH_HAS_LOCAL_STORAGE,hasLocalStorage);
         _loc4_.add(Parameter.FLASH_HAS_SCRIPT_ACCESS,hasScriptAccess);
         if(stage != null)
         {
            _loc4_.add(Parameter.FLASH_STAGE_SIZE,{
               "width":stage.stageWidth,
               "height":stage.stageHeight
            });
         }
         var _loc5_:SchemaPayload = new SchemaPayload();
         _loc5_.setSchema(Constants.SCHEMA_FLASH);
         _loc5_.setData(_loc4_.getMap());
         addBrowserData(param1,_loc5_);
         param2.push(_loc5_);
         if(param2 != null && param2.length > 0)
         {
            _loc6_ = new SchemaPayload();
            _loc6_.setSchema(Constants.SCHEMA_CONTEXTS);
            _loc7_ = [];
            for each(_loc8_ in param2)
            {
               if(_loc8_ != null)
               {
                  _loc7_.push(_loc8_.getMap());
               }
            }
            _loc6_.setData(_loc7_);
            param1.addMap(_loc6_.getMap(),this.base64Encoded,Parameter.CONTEXT_ENCODED,Parameter.CONTEXT);
         }
         if(this.subject != null)
         {
            param1.addMap(Util.copyObject(subject.getSubject(),true));
         }
         return param1;
      }
      
      public function detectJavascriptSignature(param1:Number) : Number
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc2_:Array = [javascriptInfo.userAgent,javascriptInfo.res + "x" + javascriptInfo.cd,new Date().getTimezoneOffset(),javascriptInfo.hasSessionStorage,javascriptInfo.hasLocalStorage];
         var _loc3_:Array = [];
         if(javascriptInfo.plugins)
         {
            _loc4_ = 0;
            while(_loc4_ < javascriptInfo.plugins.length)
            {
               _loc5_ = [];
               _loc6_ = 0;
               while(_loc6_ < javascriptInfo.plugins[_loc4_].length)
               {
                  _loc5_.push([javascriptInfo.plugins[_loc4_][_loc6_].type,javascriptInfo.plugins[_loc4_][_loc6_].suffixes]);
                  _loc6_++;
               }
               _loc3_.push([javascriptInfo.plugins[_loc4_].name + "::" + javascriptInfo.plugins[_loc4_].description,_loc5_.join("~")]);
               _loc4_++;
            }
         }
         return Util.murmurhash3_32_gc(_loc2_.join("###") + "###" + _loc3_.sort().join(";"),param1);
      }
      
      public function detectFlashSignature(param1:Number) : Number
      {
         var _loc2_:String = com.adobe.serialization.json.JSON.encode([Capabilities,System]);
         return Util.murmurhash3_32_gc(_loc2_,param1);
      }
      
      public function setDomainUserIdCookie(param1:String, param2:String, param3:String, param4:String, param5:String) : void
      {
         localCookies.setLocal(getSnowplowCookieName("id"),param1 + "." + param2 + "." + param3 + "." + param4 + "." + param5,configVisitorCookieTimeout,configCookiePath,configStorageDomain);
      }
      
      private function addTrackerPayload(param1:IPayload) : void
      {
         this.emitter.addToBuffer(param1);
      }
      
      public function getSnowplowSharedObjectName(param1:String) : String
      {
         return configStorageNamePrefix + param1 + "." + sharedObjectDomainHash;
      }
      
      public function getUserId() : String
      {
         return businessUserId;
      }
      
      public function updateSharedObjectDomainHash() : void
      {
         var _loc1_:String = (configStorageDomain || javascriptInfo.domain) + (configCookiePath || "/");
         var _loc2_:String = SHA1.hash(_loc1_);
         sharedObjectDomainHash = _loc2_.slice(0,4);
      }
      
      public function trackPageView(param1:String, param2:String, param3:String, param4:Array = null, param5:Number = 0) : void
      {
         Preconditions.checkNotNull(param1);
         Preconditions.checkArgument(!Util.isNullOrEmpty(param1),"pageUrl cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param2),"pageTitle cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param3),"referrer cannot be empty");
         var _loc6_:IPayload = new TrackerPayload();
         _loc6_.add(Parameter.EVENT,Constants.EVENT_PAGE_VIEW);
         _loc6_.add(Parameter.PAGE_URL,param1);
         _loc6_.add(Parameter.PAGE_TITLE,param2);
         _loc6_.add(Parameter.PAGE_REFR,param3);
         completePayload(_loc6_,param4,param5);
         addTrackerPayload(_loc6_);
      }
      
      public function setUserId(param1:String) : void
      {
         businessUserId = param1;
      }
      
      public function setUserIdFromReferrer(param1:String) : void
      {
         var querystringField:String = param1;
         try
         {
            businessUserId = ExternalInterface.call("fromQuerystring",querystringField,javascriptInfo.referrer);
         }
         catch(e:Error)
         {
         }
      }
      
      public function getSnowplowCookieName(param1:String) : String
      {
         return configStorageNamePrefix + param1 + "." + cookieDomainHash;
      }
      
      public function updateCookieDomainHash() : void
      {
         var _loc1_:String = (configStorageDomain || javascriptInfo.domain) + (configCookiePath || "/");
         var _loc2_:String = SHA1.hash(_loc1_);
         cookieDomainHash = _loc2_.slice(0,4);
      }
      
      public function detectBrowserFeatures() : Object
      {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         var _loc3_:Object = {};
         var _loc4_:Object = {
            "pdf":"application/pdf",
            "qt":"video/quicktime",
            "realp":"audio/x-pn-realaudio-plugin",
            "wma":"application/x-mplayer2",
            "dir":"application/x-director",
            "fla":"application/x-shockwave-flash",
            "java":"application/x-java-vm",
            "gears":"application/x-googlegears",
            "ag":"application/x-silverlight"
         };
         if(Boolean(javascriptInfo.mimeTypes) && javascriptInfo.mimeTypes.length > 0)
         {
            for(_loc1_ in _loc4_)
            {
               _loc2_ = Util.findFirstItemInArray(javascriptInfo.mimeTypes,"type",_loc4_[_loc1_]);
               _loc3_[_loc1_] = Boolean(_loc2_) && Boolean(_loc2_.enabledPlugin) ? "1" : "0";
            }
         }
         _loc3_.java = javascriptInfo.java;
         _loc3_.gears = javascriptInfo.gears;
         _loc3_.res = javascriptInfo.res;
         _loc3_.cd = javascriptInfo.cd;
         _loc3_.cookie = javascriptInfo.cookie;
         return _loc3_;
      }
      
      public function loadDomainUserIdSharedObject() : Array
      {
         var _loc4_:Array = null;
         var _loc1_:Date = new Date();
         var _loc2_:Number = Math.round(_loc1_.getTime() / 1000);
         var _loc3_:String = localSharedObject.getLocal("id");
         if(_loc3_)
         {
            _loc4_ = _loc3_.split(".");
            _loc4_.unshift("0");
         }
         else
         {
            if(!domainUserId)
            {
               domainUserId = SHA1.hash((javascriptInfo.userAgent || "") + (javascriptInfo.platform || "") + com.adobe.serialization.json.JSON.encode(browserFeatures) + _loc2_).slice(0,16);
            }
            _loc4_ = ["1",domainUserId,_loc2_,0,_loc2_,""];
         }
         return _loc4_;
      }
      
      public function setUserFingerprintSeed(param1:Number) : void
      {
         configUserFingerprintHashSeed = param1;
         cookieUserFingerprint = detectJavascriptSignature(configUserFingerprintHashSeed);
         sharedObjectUserFingerprint = detectFlashSignature(configUserFingerprintHashSeed);
      }
      
      public function detectViewport() : String
      {
         var vp:String = null;
         var detectViewportString:String = "function detectViewport () {\n" + "\tvar e = window, a = \'inner\';\n" + "\tif (!(\'innerWidth\' in window)) {\n" + "\t\ta = \'client\';\n" + "\t\te = document.documentElement || document.body;\n" + "\t}\n" + "\treturn e[a+\'Width\'] + \'x\' + e[a+\'Height\'];\n" + "}";
         try
         {
            vp = ExternalInterface.call(detectViewportString);
         }
         catch(e:Error)
         {
            vp = null;
         }
         return vp;
      }
      
      public function setSubject(param1:Subject) : void
      {
         this.subject = param1;
      }
      
      public function trackEcommerceTransaction(param1:String, param2:Number, param3:String, param4:Number, param5:Number, param6:String, param7:String, param8:String, param9:String, param10:Array, param11:Array = null, param12:Number = 0) : void
      {
         var _loc14_:TransactionItem = null;
         Preconditions.checkNotNull(param3);
         Preconditions.checkNotNull(param6);
         Preconditions.checkNotNull(param7);
         Preconditions.checkNotNull(param8);
         Preconditions.checkNotNull(param9);
         Preconditions.checkArgument(!Util.isNullOrEmpty(param1),"order_id cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param3),"affiliation cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param6),"city cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param7),"state cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param8),"country cannot be empty");
         Preconditions.checkArgument(!Util.isNullOrEmpty(param9),"currency cannot be empty");
         var _loc13_:IPayload = new TrackerPayload();
         _loc13_.add(Parameter.EVENT,Constants.EVENT_ECOMM);
         _loc13_.add(Parameter.TR_ID,param1);
         _loc13_.add(Parameter.TR_TOTAL,String(param2));
         _loc13_.add(Parameter.TR_AFFILIATION,param3);
         _loc13_.add(Parameter.TR_TAX,String(param4));
         _loc13_.add(Parameter.TR_SHIPPING,String(param5));
         _loc13_.add(Parameter.TR_CITY,param6);
         _loc13_.add(Parameter.TR_STATE,param7);
         _loc13_.add(Parameter.TR_COUNTRY,param8);
         _loc13_.add(Parameter.TR_CURRENCY,param9);
         completePayload(_loc13_,param11,param12);
         for each(_loc14_ in param10)
         {
            trackEcommerceTransactionItem(String(_loc14_.get(Parameter.TI_ITEM_ID)),String(_loc14_.get(Parameter.TI_ITEM_SKU)),Number(_loc14_.get(Parameter.TI_ITEM_PRICE)),parseInt(_loc14_.get(Parameter.TI_ITEM_QUANTITY)),String(_loc14_.get(Parameter.TI_ITEM_NAME)),String(_loc14_.get(Parameter.TI_ITEM_CATEGORY)),String(_loc14_.get(Parameter.TI_ITEM_CURRENCY)),_loc14_.get(Parameter.CONTEXT),param12);
         }
         addTrackerPayload(_loc13_);
      }
      
      protected function setTrackerVersion(param1:String) : void
      {
         this.trackerVersion = param1;
      }
      
      public function getCustomUrl() : String
      {
         return customUrl;
      }
      
      public function addBrowserData(param1:IPayload, param2:IPayload) : void
      {
         var _loc3_:String = Math.round(new Date().getTime() / 1000).toString();
         var _loc4_:String = getSnowplowCookieName("id");
         var _loc5_:String = getSnowplowCookieName("ses");
         var _loc6_:String = getSnowplowCookieValue("ses");
         var _loc7_:Array = loadDomainUserIdCookie();
         var _loc8_:String = _loc7_[1];
         var _loc9_:String = _loc7_[2];
         var _loc10_:Number = parseInt(_loc7_[3]);
         var _loc11_:String = _loc7_[4];
         var _loc12_:String = _loc7_[5];
         var _loc13_:Array = loadDomainUserIdSharedObject();
         var _loc14_:String = _loc13_[1];
         var _loc15_:String = _loc13_[2];
         var _loc16_:Number = parseInt(_loc13_[3]);
         var _loc17_:String = _loc13_[4];
         var _loc18_:String = _loc13_[5];
         if(!_loc6_)
         {
            _loc10_++;
            _loc12_ = _loc11_;
         }
         _loc16_++;
         param1.add(Parameter.VIEWPORT,detectViewport());
         param1.add(Parameter.DOCUMENT_SIZE,detectDocumentSize());
         param1.add(Parameter.VISIT_COUNT,_loc10_);
         param1.add(Parameter.DOMAIN_USER_ID,_loc8_);
         param1.add(Parameter.USER_FINGERPRINT,cookieUserFingerprint);
         param1.add(Parameter.UID,businessUserId);
         param2.add(Parameter.SHARED_OBJECT_VISIT_COUNT,_loc16_);
         param2.add(Parameter.SHARED_OBJECT_DOMAIN_USER_ID,_loc14_);
         param2.add(Parameter.SHARED_OBJECT_USER_FINGERPRINT,sharedObjectUserFingerprint);
         setDomainUserIdSharedObject(_loc14_,_loc15_,_loc16_.toString(),_loc3_,_loc18_);
         if(hasScriptAccess)
         {
            setDomainUserIdCookie(_loc8_,_loc9_,_loc10_.toString(),_loc3_,_loc12_);
            CookieUtil.setCookie(_loc5_,"*",configSessionCookieTimeout,configCookiePath,configStorageDomain);
         }
      }
      
      public function setStorageNamePrefix(param1:String) : void
      {
         configStorageNamePrefix = param1;
      }
      
      public function getReferrerUrl() : String
      {
         return javascriptInfo.referrer;
      }
      
      public function setCookiePath(param1:String) : void
      {
         configCookiePath = param1;
         updateCookieDomainHash();
      }
      
      public function loadDomainUserIdCookie() : Array
      {
         var _loc4_:Array = null;
         var _loc1_:Date = new Date();
         var _loc2_:Number = Math.round(_loc1_.getTime() / 1000);
         var _loc3_:String = localCookies.getLocal("id");
         if(_loc3_)
         {
            _loc4_ = _loc3_.split(".");
            _loc4_.unshift("0");
         }
         else
         {
            if(!domainUserId)
            {
               domainUserId = SHA1.hash((javascriptInfo.userAgent || "") + (javascriptInfo.platform || "") + com.adobe.serialization.json.JSON.encode(browserFeatures) + _loc2_).slice(0,16);
            }
            _loc4_ = ["1",domainUserId,_loc2_,0,_loc2_,""];
         }
         return _loc4_;
      }
      
      public function setCookieDomain(param1:String) : void
      {
         configStorageDomain = Util.fixupDomain(param1);
         updateCookieDomainHash();
      }
      
      public function getSnowplowCookieValue(param1:String) : String
      {
         return localCookies.getLocal(getSnowplowCookieName(param1));
      }
      
      public function setDomainUserIdSharedObject(param1:String, param2:String, param3:String, param4:String, param5:String) : void
      {
         localSharedObject.setLocal(getSnowplowSharedObjectName("id"),param1 + "." + param2 + "." + param3 + "." + param4 + "." + param5);
      }
      
      public function trackScreenView(param1:String, param2:String, param3:Array, param4:Number) : void
      {
         Preconditions.checkArgument(param1 != null || param2 != null);
         var _loc5_:TrackerPayload = new TrackerPayload();
         _loc5_.add(Parameter.SV_NAME,param1);
         _loc5_.add(Parameter.SV_ID,param2);
         var _loc6_:SchemaPayload = new SchemaPayload();
         _loc6_.setSchema(Constants.SCHEMA_SCREEN_VIEW);
         _loc6_.setData(_loc5_);
         trackUnstructuredEvent(_loc6_,param3,param4);
      }
      
      public function setUserIdFromLocation(param1:String) : void
      {
         var querystringField:String = param1;
         try
         {
            businessUserId = ExternalInterface.call("fromQuerystring",querystringField,javascriptInfo.pageUrl);
         }
         catch(e:Error)
         {
         }
      }
      
      public function getPlatform() : String
      {
         return this.platform;
      }
      
      public function setSessionCookieTimeout(param1:int) : void
      {
         configSessionCookieTimeout = param1;
      }
      
      public function setPlatform(param1:String) : void
      {
         this.platform = param1;
      }
      
      public function getSubject() : Subject
      {
         return this.subject;
      }
      
      public function getSnowplowSharedObjectValue(param1:String) : String
      {
         return localSharedObject.getLocal(getSnowplowSharedObjectName(param1));
      }
      
      public function setCustomUrl(param1:String) : void
      {
         customUrl = param1;
      }
      
      public function detectDocumentSize() : String
      {
         var ds:String = null;
         var detectDocumentSizeString:String = "function detectDocumentSize  () {\n" + "\tvar de = document.documentElement; // Alias\n" + "\tvar w = Math.max(de.clientWidth, de.offsetWidth, de.scrollWidth);\n" + "\tvar h = Math.max(de.clientHeight, de.offsetHeight, de.scrollHeight);\n" + "\treturn isNaN(w) || isNaN(h) ? \'\' : w + \'x\' + h;\n" + "}";
         try
         {
            ds = ExternalInterface.call(detectDocumentSizeString);
         }
         catch(e:Error)
         {
            ds = null;
         }
         return ds;
      }
   }
}

