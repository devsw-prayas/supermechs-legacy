package com.snowplowanalytics.snowplow.tracker.util
{
   import com.snowplowanalytics.snowplow.tracker.Util;
   import de.aggro.utils.CookieUtil;
   import flash.net.SharedObject;
   
   public class LocalStorage
   {
      
      public static const COOKIES:String = "cookies";
      
      public static const SHARED_OBJECT:String = "sharedObject";
      
      public static const BOTH:String = "both";
      
      private static const LOCAL_OBJECT_NAME:String = "com.snowplowanalytics.snowplow-as3-tracker";
      
      private var sharedObject:Boolean = false;
      
      private var cookies:Boolean = false;
      
      private var sharedObjectClient:SharedObject;
      
      public function LocalStorage(param1:String)
      {
         var mode:String = param1;
         super();
         switch(mode)
         {
            case COOKIES:
               cookies = true;
               break;
            case SHARED_OBJECT:
               sharedObject = true;
               break;
            case BOTH:
               cookies = true;
               sharedObject = true;
         }
         if(sharedObject)
         {
            sharedObjectClient = SharedObject.getLocal(LOCAL_OBJECT_NAME);
         }
         try
         {
            CookieUtil.init();
         }
         catch(e:Error)
         {
            cookies = false;
         }
      }
      
      public function deleteLocal(param1:String) : void
      {
         if(cookies)
         {
            CookieUtil.deleteCookie(param1);
         }
         if(sharedObject)
         {
            delete sharedObjectClient.data[param1];
            sharedObjectClient.flush();
         }
      }
      
      public function setLocal(param1:String, param2:String, param3:int = 999999, param4:String = "/", param5:String = null) : void
      {
         if(cookies)
         {
            CookieUtil.setCookie(param1,param2,param3,param4,param5);
         }
         if(sharedObject)
         {
            sharedObjectClient.data[param1] = param2;
            sharedObjectClient.flush();
         }
      }
      
      public function getLocal(param1:String) : String
      {
         var _loc2_:String = null;
         if(cookies)
         {
            _loc2_ = CookieUtil.getCookie(param1) as String;
         }
         if(sharedObject && Util.isNullOrEmpty(_loc2_))
         {
            _loc2_ = sharedObjectClient.data[param1];
         }
         return _loc2_;
      }
   }
}

