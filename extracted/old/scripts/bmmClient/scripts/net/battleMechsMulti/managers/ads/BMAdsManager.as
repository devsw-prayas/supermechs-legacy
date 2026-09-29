package net.battleMechsMulti.managers.ads
{
   import flash.system.Security;
   
   public class BMAdsManager
   {
      
      private static var _instance:IBMAdsManager;
      
      public function BMAdsManager()
      {
         super();
      }
      
      public static function getInstance() : IBMAdsManager
      {
         if(_instance == null)
         {
            init();
         }
         return _instance;
      }
      
      public static function gi() : IBMAdsManager
      {
         return getInstance();
      }
      
      private static function init() : *
      {
         if(Security.pageDomain != null && Security.pageDomain.substr(-15) == "supermechs.com/")
         {
            _instance = new IMAAdsManager();
         }
         if(_instance == null)
         {
            _instance = new DummyAdsManager();
         }
      }
   }
}

