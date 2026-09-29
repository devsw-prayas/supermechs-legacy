package com.facebook.graph.windows
{
   import com.facebook.graph.core.FacebookURLDefaults;
   import com.facebook.graph.utils.FacebookDataUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.LocationChangeEvent;
   import flash.media.StageWebView;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class MobileLoginWindow extends Sprite
   {
      
      protected var loginRequest:URLRequest;
      
      protected var userClosedWindow:Boolean = true;
      
      private var webView:StageWebView;
      
      public var loginCallback:Function;
      
      public function MobileLoginWindow(param1:Function)
      {
         this.loginCallback = param1;
         super();
      }
      
      public function open(param1:String, param2:StageWebView, param3:Array = null, param4:String = "touch") : void
      {
         this.webView = param2;
         this.loginRequest = new URLRequest();
         this.loginRequest.method = URLRequestMethod.GET;
         this.loginRequest.url = FacebookURLDefaults.AUTH_URL + "?" + this.formatData(param1,param4,param3);
         this.showWindow(this.loginRequest);
      }
      
      protected function showWindow(param1:URLRequest) : void
      {
         this.webView.addEventListener(Event.COMPLETE,this.handleLocationChange,false,0,true);
         this.webView.addEventListener(LocationChangeEvent.LOCATION_CHANGE,this.handleLocationChange,false,0,true);
         this.webView.loadURL(param1.url);
      }
      
      protected function formatData(param1:String, param2:String, param3:Array = null) : URLVariables
      {
         var _loc4_:URLVariables = new URLVariables();
         _loc4_.client_id = param1;
         _loc4_.redirect_uri = FacebookURLDefaults.LOGIN_SUCCESS_URL;
         _loc4_.display = param2;
         _loc4_.type = "user_agent";
         if(param3 != null)
         {
            _loc4_.scope = param3.join(",");
         }
         return _loc4_;
      }
      
      protected function handleLocationChange(param1:Event) : void
      {
         var _loc2_:String = this.webView.location;
         if(_loc2_.indexOf(FacebookURLDefaults.LOGIN_FAIL_URL) == 0 || _loc2_.indexOf(FacebookURLDefaults.LOGIN_FAIL_SECUREURL) == 0)
         {
            this.webView.removeEventListener(Event.COMPLETE,this.handleLocationChange);
            this.webView.removeEventListener(LocationChangeEvent.LOCATION_CHANGE,this.handleLocationChange);
            this.loginCallback(null,FacebookDataUtils.getURLVariables(_loc2_).error_reason);
            this.userClosedWindow = false;
            this.webView.dispose();
            this.webView = null;
         }
         else if(_loc2_.indexOf(FacebookURLDefaults.LOGIN_SUCCESS_URL) == 0 || _loc2_.indexOf(FacebookURLDefaults.LOGIN_SUCCESS_SECUREURL) == 0)
         {
            this.webView.removeEventListener(Event.COMPLETE,this.handleLocationChange);
            this.webView.removeEventListener(LocationChangeEvent.LOCATION_CHANGE,this.handleLocationChange);
            this.loginCallback(FacebookDataUtils.getURLVariables(_loc2_),null);
            this.userClosedWindow = false;
            this.webView.dispose();
            this.webView = null;
         }
      }
   }
}

