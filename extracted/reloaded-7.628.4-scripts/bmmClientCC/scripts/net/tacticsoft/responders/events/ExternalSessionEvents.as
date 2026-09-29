package net.tacticsoft.responders.events
{
   public class ExternalSessionEvents
   {
      
      public static const EXTERNAL_LOGIN_FAULT:String = "externalLoginFault";
      
      public static const EXTERNAL_LOGIN_TRUE:String = "externalLoginTrue";
      
      public static const EXTERNAL_RELOGIN:String = "externalReLogin";
      
      public static const EXTERNAL_LOGOUT_TRUE:String = "externalLogoutTrue";
      
      public static const EXTERNAL_LOGOUT_FAULT:String = "externalLogoutFault";
      
      public static const EXTERNAL_LOGIN_CONFLICT:String = "externalLoginConflict";
      
      public function ExternalSessionEvents()
      {
         super();
      }
   }
}

