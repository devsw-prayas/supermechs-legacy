package net.tacticsoft.utils
{
   public class QueryString
   {
      
      private var _queryString:String = "";
      
      private var _all:String = "";
      
      private var _params:Object;
      
      private var _location:String = "";
      
      public function QueryString(param1:String = "")
      {
         super();
         this.readQueryString(param1);
      }
      
      public function get getQueryString() : String
      {
         return this._queryString;
      }
      
      public function get url() : String
      {
         return this._all;
      }
      
      public function get parameters() : Object
      {
         return this._params;
      }
      
      public function get location() : String
      {
         return this._location;
      }
      
      private function readQueryString(param1:String = "") : void
      {
         var allParams:Array = null;
         var paramsCount:uint = 0;
         var i:int = 0;
         var index:* = undefined;
         var keyValuePair:String = null;
         var paramKey:String = null;
         var paramValue:String = null;
         var url:String = param1;
         this._params = new Object();
         try
         {
            this._all = url;
            if(url.length > 0 && url.indexOf("?") > -1)
            {
               this._queryString = url.substring(url.indexOf("?") + 1);
               if(url.indexOf("?") > 0)
               {
                  this._location = url.split("?",1)[0];
               }
            }
            else if(url.length > 0)
            {
               this._location = url.split("?",1)[0];
            }
            if(this._queryString.length > 0)
            {
               allParams = this._queryString.split("&");
               paramsCount = allParams.length;
               i = 0;
               index = -1;
               while(i < paramsCount)
               {
                  keyValuePair = allParams[i];
                  if((index = keyValuePair.indexOf("=")) > 0)
                  {
                     paramKey = keyValuePair.substring(0,index);
                     paramValue = keyValuePair.substring(index + 1);
                     this._params[paramKey] = paramValue;
                  }
                  else if(keyValuePair.indexOf("=") < 0)
                  {
                     this._params[keyValuePair] = "";
                  }
                  i++;
               }
            }
         }
         catch(e:Error)
         {
            TsLogger.log("QueryString :: Unable to parse query string.");
         }
      }
   }
}

