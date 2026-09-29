package com.facebook.graph
{
   import com.facebook.graph.core.AbstractFacebook;
   import com.facebook.graph.data.Batch;
   import com.facebook.graph.data.FQLMultiQuery;
   import com.facebook.graph.data.FacebookSession;
   import com.facebook.graph.net.FacebookRequest;
   import com.facebook.graph.utils.FacebookDataUtils;
   import com.facebook.graph.utils.IResultParser;
   import com.facebook.graph.windows.MobileLoginWindow;
   import flash.display.Stage;
   import flash.media.StageWebView;
   import flash.net.SharedObject;
   import flash.net.URLRequestMethod;
   import net.tacticsoft.utils.MiscUtils;
   
   public class FacebookMobile extends AbstractFacebook
   {
      
      protected static var _instance:FacebookMobile;
      
      protected static const SO_NAME:String = "com.facebook.graph.FacebookMobile";
      
      protected static var _canInit:Boolean = false;
      
      protected var _manageSession:Boolean = true;
      
      protected var loginWindow:MobileLoginWindow;
      
      protected var applicationId:String;
      
      protected var loginCallback:Function;
      
      protected var logoutCallback:Function;
      
      protected var initCallback:Function;
      
      protected var webView:StageWebView;
      
      protected var stageRef:Stage;
      
      public function FacebookMobile()
      {
         super();
         if(_canInit == false)
         {
            throw new Error("FacebookMobile is an singleton and cannot be instantiated.");
         }
      }
      
      public static function init(param1:String, param2:Function, param3:String = null) : void
      {
         getInstance().init(param1,param2,param3);
      }
      
      public static function set locale(param1:String) : void
      {
         getInstance().locale = param1;
      }
      
      public static function login(param1:Function, param2:Stage, param3:Array, param4:StageWebView = null, param5:String = "touch") : void
      {
         getInstance().login(param1,param2,param3,param4,param5);
      }
      
      public static function set manageSession(param1:Boolean) : void
      {
         getInstance().manageSession = param1;
      }
      
      public static function logout(param1:Function = null, param2:String = null) : void
      {
         getInstance().logout(param1,param2);
      }
      
      public static function requestExtendedPermissions(param1:Function, param2:StageWebView, ... rest) : void
      {
         getInstance().requestExtendedPermissions(param1,param2,rest);
      }
      
      public static function api(param1:String, param2:Function, param3:* = null, param4:String = "GET") : void
      {
         getInstance().api(param1,param2,param3,param4);
      }
      
      public static function getRawResult(param1:Object) : Object
      {
         return getInstance().getRawResult(param1);
      }
      
      public static function hasNext(param1:Object) : Boolean
      {
         var _loc2_:Object = getInstance().getRawResult(param1);
         if(!_loc2_.paging)
         {
            return false;
         }
         return _loc2_.paging.next != null;
      }
      
      public static function hasPrevious(param1:Object) : Boolean
      {
         var _loc2_:Object = getInstance().getRawResult(param1);
         if(!_loc2_.paging)
         {
            return false;
         }
         return _loc2_.paging.previous != null;
      }
      
      public static function nextPage(param1:Object, param2:Function) : FacebookRequest
      {
         return getInstance().nextPage(param1,param2);
      }
      
      public static function previousPage(param1:Object, param2:Function) : FacebookRequest
      {
         return getInstance().previousPage(param1,param2);
      }
      
      public static function postData(param1:String, param2:Function, param3:* = null) : void
      {
         api(param1,param2,param3,URLRequestMethod.POST);
      }
      
      public static function uploadVideo(param1:String, param2:Function = null, param3:* = null) : void
      {
         getInstance().uploadVideo(param1,param2,param3);
      }
      
      public static function deleteObject(param1:String, param2:Function) : void
      {
         getInstance().deleteObject(param1,param2);
      }
      
      public static function fqlQuery(param1:String, param2:Function = null, param3:Object = null) : void
      {
         getInstance().fqlQuery(param1,param2,param3);
      }
      
      public static function fqlMultiQuery(param1:FQLMultiQuery, param2:Function = null, param3:IResultParser = null) : void
      {
         getInstance().fqlMultiQuery(param1,param2,param3);
      }
      
      public static function batchRequest(param1:Batch, param2:Function = null) : void
      {
         getInstance().batchRequest(param1,param2);
      }
      
      public static function callRestAPI(param1:String, param2:Function = null, param3:* = null, param4:String = "GET") : void
      {
         getInstance().callRestAPI(param1,param2,param3,param4);
      }
      
      public static function getImageUrl(param1:String, param2:String = null) : String
      {
         return getInstance().getImageUrl(param1,param2);
      }
      
      public static function getSession() : FacebookSession
      {
         return getInstance().session;
      }
      
      protected static function getInstance() : FacebookMobile
      {
         if(_instance == null)
         {
            _canInit = true;
            _instance = new FacebookMobile();
            _canInit = false;
         }
         return _instance;
      }
      
      protected function init(param1:String, param2:Function, param3:String = null) : void
      {
         var _loc4_:SharedObject = null;
         this.initCallback = param2;
         this.applicationId = param1;
         if(param3 != null)
         {
            session = new FacebookSession();
            session.accessToken = param3;
         }
         else if(this._manageSession)
         {
            session = new FacebookSession();
            _loc4_ = SharedObject.getLocal(SO_NAME);
            session.accessToken = _loc4_.data.accessToken;
            session.expireDate = _loc4_.data.expireDate;
         }
         this.verifyAccessToken();
      }
      
      protected function verifyAccessToken() : void
      {
         api("/me",this.handleUserLoad);
      }
      
      protected function handleUserLoad(param1:Object, param2:Object) : void
      {
         trace("FacebookMobile ::  handleUserLoad() - result=");
         MiscUtils.traceObject(param1,99);
         trace("FacebookMobile ::  handleUserLoad() - error=");
         MiscUtils.traceObject(param2,99);
         if(param1)
         {
            session.uid = param1.id;
            session.user = param1;
            if(this.loginCallback != null)
            {
               this.loginCallback(session,null);
            }
            if(this.initCallback != null)
            {
               this.initCallback(session,null);
               this.initCallback = null;
            }
         }
         else
         {
            if(this.loginCallback != null)
            {
               this.loginCallback(null,param2);
            }
            if(this.initCallback != null)
            {
               this.initCallback(null,param2);
               this.initCallback = null;
            }
            session = null;
         }
      }
      
      protected function login(param1:Function, param2:Stage, param3:Array, param4:StageWebView = null, param5:String = "touch") : void
      {
         this.loginCallback = param1;
         this.stageRef = param2;
         if(!param4)
         {
            this.webView = this.createWebView();
         }
         else
         {
            this.webView = param4;
            this.webView.stage = this.stageRef;
         }
         this.webView.assignFocus();
         if(this.applicationId == null)
         {
            throw new Error("FacebookMobile.init() needs to be called first.");
         }
         this.loginWindow = new MobileLoginWindow(this.handleLogin);
         this.loginWindow.open(this.applicationId,this.webView,FacebookDataUtils.flattenArray(param3),param5);
      }
      
      protected function set manageSession(param1:Boolean) : void
      {
         this._manageSession = param1;
      }
      
      protected function requestExtendedPermissions(param1:Function, param2:StageWebView, ... rest) : void
      {
         if(this.applicationId == null)
         {
            throw new Error("User must be logged in before asking for extended permissions.");
         }
         this.login(param1,this.stageRef,rest,param2);
      }
      
      protected function handleLogin(param1:Object, param2:Object) : void
      {
         var _loc5_:SharedObject = null;
         this.loginWindow.loginCallback = null;
         trace("FacebookMobile ::  handleLogin() - result=");
         MiscUtils.traceObject(param1);
         trace("FacebookMobile ::  handleLogin() - fail=");
         MiscUtils.traceObject(param2);
         if(param2)
         {
            this.loginCallback(null,param2);
            return;
         }
         session = new FacebookSession();
         session.accessToken = String(param1.access_token).split(",")[0];
         var _loc3_:Date = new Date();
         var _loc4_:Number = Math.ceil(_loc3_.getTime() / 1000) + 1000;
         session.expireDate = param1.expires_in == 0 ? null : FacebookDataUtils.stringToDate(_loc4_ + parseInt(param1.expires_in) + "");
         if(this._manageSession)
         {
            _loc5_ = SharedObject.getLocal(SO_NAME);
            _loc5_.data.accessToken = session.accessToken;
            _loc5_.data.expireDate = session.expireDate;
            _loc5_.flush();
         }
         this.verifyAccessToken();
      }
      
      protected function logout(param1:Function = null, param2:String = null) : void
      {
         this.logoutCallback = param1;
         var _loc3_:Object = {};
         _loc3_.confirm = 1;
         _loc3_.next = param2;
         _loc3_.access_token = accessToken;
         var _loc4_:FacebookRequest = new FacebookRequest();
         openRequests[_loc4_] = this.handleLogout;
         _loc4_.call("https://m.facebook.com/logout.php","GET",handleRequestLoad,_loc3_);
         var _loc5_:SharedObject = SharedObject.getLocal(SO_NAME);
         _loc5_.clear();
         _loc5_.flush();
         session = null;
      }
      
      protected function handleLogout(param1:Object, param2:Object) : void
      {
         if(this.logoutCallback != null)
         {
            this.logoutCallback(true);
            this.logoutCallback = null;
         }
      }
      
      protected function createWebView() : StageWebView
      {
         if(this.webView)
         {
            try
            {
               this.webView.dispose();
            }
            catch(e:*)
            {
            }
         }
         this.webView = new StageWebView();
         this.webView.stage = this.stageRef;
         return this.webView;
      }
   }
}

