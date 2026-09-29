package net.battleMechsMulti.managers.ads
{
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
         _instance = new BMSupersonicManager();
         if(_instance == null)
         {
            _instance = new DummyAdsManager();
         }
      }
   }
}

