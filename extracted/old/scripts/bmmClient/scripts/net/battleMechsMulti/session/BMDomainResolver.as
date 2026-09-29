package net.battleMechsMulti.session
{
   import flash.net.LocalConnection;
   
   public class BMDomainResolver
   {
      
      public function BMDomainResolver()
      {
         super();
      }
      
      public static function getDomain() : String
      {
         var _loc1_:LocalConnection = new LocalConnection();
         var _loc2_:* = _loc1_.domain;
         if(_loc2_ == "localhost" || _loc2_ == null)
         {
            _loc2_ = "supermechs.com";
         }
         if(_loc2_.substr(-14) != "supermechs.com")
         {
            _loc2_ = "supermechs.com";
         }
         return _loc2_;
      }
      
      public static function getHttpDomain() : String
      {
         return "https://" + getDomain();
      }
   }
}

