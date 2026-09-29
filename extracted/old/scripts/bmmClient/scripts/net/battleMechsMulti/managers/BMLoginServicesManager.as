package net.battleMechsMulti.managers
{
   import net.battleMechsMulti.session.LoginServices;
   
   public class BMLoginServicesManager
   {
      
      public function BMLoginServicesManager()
      {
         super();
      }
      
      public static function getActiveServices() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(LoginServices.FACEBOOK);
         _loc1_.push(LoginServices.SUPERMECHS);
         return _loc1_;
      }
      
      public static function isServiceActive(param1:String) : *
      {
         return getActiveServices().indexOf(param1) >= 0;
      }
      
      public static function getServiceDisplayName(param1:String) : *
      {
         switch(param1)
         {
            case LoginServices.FACEBOOK:
               return "FACEBOOK";
            case LoginServices.SUPERMECHS:
               return "SUPERMECHS";
            case LoginServices.GOOGLE_PLAY:
               return "GOOGLE PLAY";
            case LoginServices.GAME_CENTER:
               return "GAME CENTER";
            case LoginServices.KONGREGATE:
               return "KONGREGATE";
            default:
               TsLogger.log("getServiceDisplayName() :: Unknown service " + param1);
               return null;
         }
      }
      
      public static function getServiceSubtitle(param1:String) : *
      {
         switch(param1)
         {
            case LoginServices.SUPERMECHS:
               return "ACCOUNT";
            case LoginServices.GAME_CENTER:
               return "Coming Soon";
            default:
               return null;
         }
      }
      
      public static function isServiceImplemented(param1:String) : *
      {
         switch(param1)
         {
            case LoginServices.GAME_CENTER:
               return false;
            default:
               return true;
         }
      }
   }
}

