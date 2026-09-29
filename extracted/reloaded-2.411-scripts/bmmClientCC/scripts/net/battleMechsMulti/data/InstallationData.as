package net.battleMechsMulti.data
{
   import com.mesmotronic.ane.AndroidID;
   import com.supersonic.adobeair.Supersonic;
   import flash.net.SharedObject;
   import net.battleMechsMulti.utils.ExternalInterfaceWrapper;
   import net.tacticsoft.utils.RandomUtils;
   
   public class InstallationData
   {
      
      private static const GET_COOKIE_FUNCTION:String = ( <![CDATA[ function (key)
	{
    var cookieValue = null;

    if (key)
    {
        var cookieSearch = key + '=';

        if (document.cookie)
        {
            var cookieArray = document.cookie.split(';');
            for (var i = 0; i < cookieArray.length; i++)
            {
                var cookieString = cookieArray[i];

                // skip past leading spaces
                while (cookieString.charAt(0) == ' ')
                {
                    cookieString = cookieString.substr(1);
                }

                // extract the actual value
                if (cookieString.indexOf(cookieSearch) == 0)
                {
                    cookieValue = cookieString.substr(cookieSearch.length);
                }
            }
        }
    }

    return cookieValue;
	}
	
	
	]]>).toString();
      
      private static const SET_COOKIE_FUNCTION:String = ( <![CDATA[ 
		
	function (key, val)
	{
		if (key)
		{
			var date = new Date();

			if (val != null)
			{
				// expires in one year
				date.setTime(date.getTime() + (365*24*60*60*1000));
				document.cookie = key + "=" + val + "; expires=" + date.toGMTString();
			}
			else
			{
				// expires yesterday
				date.setTime(date.getTime() - (24*60*60*1000));
				document.cookie = key + "=; expires=" + date.toGMTString();
			}
		}
	}
		
	]]>).toString();
      
      private var sharedObject:SharedObject;
      
      public function InstallationData()
      {
         super();
         this.sharedObject = SharedObject.getLocal("installationData");
         this.setSessionCount(this.getSessionCount() + 1);
         TsLogger.log("Installation session count is " + this.getSessionCount().toString());
         this.sharedObject.flush();
         this.setCookieDeviceId(this.deviceId);
      }
      
      public function getSessionCount() : int
      {
         if(this.sharedObject.data.sessionCount == null)
         {
            return 0;
         }
         return this.sharedObject.data.sessionCount;
      }
      
      private function setSessionCount(param1:int) : *
      {
         this.sharedObject.data.sessionCount = param1;
      }
      
      public function isInstallSession() : Boolean
      {
         return this.getSessionCount() == 1;
      }
      
      public function get deviceId() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         try
         {
            _loc1_ = Supersonic.instance.getAdvertiserId();
            if(_loc1_ != null && _loc1_.length > 0)
            {
               return _loc1_;
            }
         }
         catch(e:Error)
         {
         }
         try
         {
            if(AndroidID.isSupported)
            {
               _loc2_ = AndroidID.ANDROID_ID;
               if(_loc2_ != null && _loc2_.length > 0)
               {
                  return _loc2_;
               }
            }
         }
         catch(e:Error)
         {
         }
         if(this.sharedObject.data.deviceId == null)
         {
            _loc3_ = this.getCookieDeviceId();
            if(_loc3_ == null || _loc3_.length == 0)
            {
               _loc3_ = RandomUtils.generateRandomString(12);
            }
            this.sharedObject.data.deviceId = _loc3_;
            this.sharedObject.flush();
         }
         return this.sharedObject.data.deviceId;
      }
      
      public function get lastLoginService() : String
      {
         if(this.sharedObject.data == null || this.sharedObject.data.lastLoginService == undefined)
         {
            return "";
         }
         return this.sharedObject.data.lastLoginService;
      }
      
      public function set lastLoginService(param1:String) : void
      {
         this.sharedObject.data.lastLoginService = param1;
         this.sharedObject.flush();
      }
      
      public function get hasLastLoginService() : Boolean
      {
         return this.lastLoginService != "";
      }
      
      private function setCookieDeviceId(param1:String) : void
      {
         if(ExternalInterfaceWrapper.isAvailable())
         {
            ExternalInterfaceWrapper.call(SET_COOKIE_FUNCTION,"TSDID",param1);
         }
      }
      
      private function getCookieDeviceId() : String
      {
         if(ExternalInterfaceWrapper.isAvailable())
         {
            return ExternalInterfaceWrapper.call(GET_COOKIE_FUNCTION,"TSDID");
         }
         return null;
      }
   }
}

