package com.facebook.graph.data
{
   public class FacebookAuthResponse
   {
      
      public var uid:String;
      
      public var expireDate:Date;
      
      public var accessToken:String;
      
      public var signedRequest:String;
      
      public function FacebookAuthResponse()
      {
         super();
      }
      
      public function fromJSON(param1:Object) : void
      {
         var _loc2_:Number = NaN;
         if(param1 != null)
         {
            this.expireDate = new Date();
            _loc2_ = 0;
            if(param1 !== false && param1 !== true)
            {
               if(param1.expiresIn != undefined)
               {
                  _loc2_ = Number(param1.expiresIn);
               }
            }
            this.expireDate.setTime(this.expireDate.time + _loc2_ * 1000);
            this.accessToken = param1.access_token || param1.accessToken;
            this.signedRequest = param1.signedRequest;
            this.uid = param1.userID;
         }
      }
      
      public function toString() : String
      {
         return "[userId:" + this.uid + "]";
      }
   }
}

