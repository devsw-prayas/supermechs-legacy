package net.battleMechsMulti.session
{
   public class LoginServices
   {
      
      public static const SUPERMECHS:String = "phpbb";
      
      public static const GOOGLE_PLAY:String = "gplay";
      
      public static const GAME_CENTER:String = "gamecenter";
      
      public static const FACEBOOK:String = "facebook";
      
      public static const KONGREGATE:String = "kong";
      
      public static const GENERATED_USER:String = "generated";
      
      public static const ALL_SERVICES:Array = [SUPERMECHS,GOOGLE_PLAY,FACEBOOK,KONGREGATE,GAME_CENTER];
      
      public static const MAJOR_SERVICES:Array = [SUPERMECHS,FACEBOOK];
      
      public function LoginServices()
      {
         super();
      }
   }
}

