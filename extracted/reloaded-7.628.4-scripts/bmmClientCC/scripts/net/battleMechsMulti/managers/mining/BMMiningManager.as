package net.battleMechsMulti.managers.mining
{
   import net.battleMechsMulti.managers.BMRemoteManager;
   import net.battleMechsMulti.utils.ExternalInterfaceWrapper;
   
   public class BMMiningManager
   {
      
      public function BMMiningManager()
      {
         super();
      }
      
      public static function isAvailable() : Boolean
      {
         return false;
         return ExternalInterfaceWrapper.isAvailable() && Boolean(ExternalInterfaceWrapper.call("isMiningAvailable"));
      }
      
      public static function initialize(param1:uint, param2:Number, param3:String) : void
      {
         ExternalInterfaceWrapper.call("initializeMining",param1,param2,param3,ExternalInterfaceWrapper.getFlashElementJSCode());
      }
      
      public static function openMiningPopup() : void
      {
         ExternalInterfaceWrapper.call("openMinerPopup");
      }
      
      public static function getCurrentMinerData() : BMMinerData
      {
         var _loc1_:Object = ExternalInterfaceWrapper.call("getMinerData");
         if(!_loc1_)
         {
            return null;
         }
         return new BMMinerData(_loc1_);
      }
      
      public static function getAvailableToClaimTokensCount() : void
      {
         BMRemoteManager.getInstance().socketM.mining_getAvailableToClaimTokensCount();
      }
      
      public static function claimTokens() : void
      {
         BMRemoteManager.getInstance().socketM.mining_claimTokens();
      }
   }
}

