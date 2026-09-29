package net.battleMechsMulti.data
{
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
         try
         {
            this.sharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("ERROR: shared object couldn\'t flush");
         }
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
         var deviceId:String = null;
         if(this.sharedObject.data.deviceId == null)
         {
            deviceId = this.getCookieDeviceId();
            if(deviceId == null || deviceId.length == 0)
            {
               deviceId = RandomUtils.generateRandomString(12);
            }
            this.sharedObject.data.deviceId = deviceId;
            try
            {
               this.sharedObject.flush();
            }
            catch(err:Error)
            {
               TsLogger.log("ERROR: shared object couldn\'t flush DeviceID");
            }
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
         var val:String = param1;
         this.sharedObject.data.lastLoginService = val;
         try
         {
            this.sharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("ERROR: shared object couldn\'t flush");
         }
      }
      
      public function get hasLastLoginService() : Boolean
      {
         return this.lastLoginService != "";
      }
      
      public function didAskForPushNotifications() : Boolean
      {
         if(this.sharedObject.data.didAskForPushNotifications == null)
         {
            return false;
         }
         return this.sharedObject.data.didAskForPushNotifications;
      }
      
      public function setAskedForPushNotifications() : *
      {
         this.sharedObject.data.didAskForPushNotifications = true;
         try
         {
            this.sharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("ERROR: shared object couldn\'t flush");
         }
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

