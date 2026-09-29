package net.battleMechsMulti.session
{
   import flash.net.LocalConnection;
   
   public class BMDomainResolver
   {
      
      public function BMDomainResolver()
      {
         super();
      }
      
      public static function getDomain(param1:Boolean = false) : String
      {
         var _loc2_:LocalConnection = new LocalConnection();
         var _loc3_:* = _loc2_.domain;
         if(param1)
         {
            return "game.supermechs.com";
         }
         if(_loc3_ == "localhost" || _loc3_ == null)
         {
            _loc3_ = "supermechs.com";
         }
         if(_loc3_.substr(-14) != "supermechs.com")
         {
            _loc3_ = "supermechs.com";
         }
         return _loc3_;
      }
      
      public static function getHttpDomain() : String
      {
         return "https://" + getDomain();
      }
   }
}

