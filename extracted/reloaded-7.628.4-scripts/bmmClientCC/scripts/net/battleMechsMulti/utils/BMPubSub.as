package net.battleMechsMulti.utils
{
   import net.tacticsoft.utils.PubSub;
   
   public class BMPubSub
   {
      
      private static var _pubSub:PubSub = new PubSub();
      
      public static const MESSAGE_SECOND_PASSED:* = "SecondPassed";
      
      public static const MESSAGE_FREE_PACKAGES_UPDATED:* = "FreePackagesUpdated";
      
      public static const MESSAGE_REWARDED_VIDEO_WATCHED:* = "RewardVideoWatched";
      
      public static const MESSAGE_REWARDED_VIDEO_FAILED:* = "RewardedVideoFailed";
      
      public static const MESSAGE_PREMIUM_PACKAGE_BOUGHT:* = "PremiumPackageBought";
      
      public static const MESSAGE_MECH_EQUIPMENT_CHANGED:* = "MechEquipmentChanged";
      
      public static const MESSAGE_SHOP_CLOSED:* = "ShopClosed";
      
      public static const MESSAGE_SHOP_ACTIVE_CHAIN_DISCOUNT_UPDATED:* = "ShopActiveChainDiscountUpdated";
      
      public static const MESSAGE_FINISHED_GET_INITIAL_DATA:* = "FinishedGetInitialData";
      
      public static const MESSAGE_BLACK_SCREEN_ACTIVE:* = "BlackScreenActive";
      
      public static const MESSAGE_BLACK_SCREEN_INACTIVE:* = "BlackScreenInactive";
      
      public static const MESSAGE_MAIN_MENU_PLAYER_CLICKED_ON_MECH:* = "MainMenuPlayerClickedOnMech";
      
      public static const MESSAGE_SCREEN_OPENED:* = "ScreenOpened";
      
      public static const MESSAGE_SCREEN_CLOSED:* = "ScreenClosed";
      
      public static const MESSAGE_SCREENS_DIRECTOR_FINISHED_ALL_TASKS:* = "ScreensDirectorFinishedAllTasks";
      
      public static const MESSAGE_SCREENS_DIRECTOR_STARTED_PERFORMING_TASKS:* = "ScreensDirectorStartedPerformingTasks";
      
      public static const MESSAGE_MAIN_MENU_CAROUSEL_ANIMATION_COMPLETED:* = "MainMenuCarouselAnimationCompleted";
      
      public static const MESSAGE_APP_ACTIVAED:* = "AppActivated";
      
      public static const MESSAGE_UPGRADE_SKILL_NETWORK_REQUEST_COMPLETED:* = "UpgradeSkillNetworkRequestCompleted";
      
      public static const MESSAGE_WORKSHOP_SWITCH_TO_MECH_X:* = "WorkshopSwitchToMechX";
      
      public static const MINING_GOT_USER_DATA:* = "MiningGotUserData";
      
      public static const MINING_GOT_USER_DATA_ERROR:* = "MiningGotUserDataError";
      
      public static const MINING_WITHDRAWN_TOKENS:* = "MiningWithdrawnTokens";
      
      public static const MINING_WITHDRAWN_TOKENS_ERROR:* = "MiningWithdrawnTokensError";
      
      public static const VIP_ACCOUNT_UPDATED:* = "VIPAccountUpdated";
      
      public static const MESSAGE_BASE_BUILDING_STATE_MODIFIED:* = "BaseBuildingStateModified";
      
      public static const MESSAGE_UNCAUGHT_ERROR:* = "UncaughtError";
      
      public static const MESSAGE_WEEKLY_RESET_OCCURED:* = "WeeklyResetOccured";
      
      public static const MESSAGE_KIN_ACCOUNT_LOAD_SUCCESS:* = "KinAccountLoadSuccess";
      
      public static const MESSAGE_KIN_ACCOUNT_LOAD_FAIL:* = "KinAccountLoadFail";
      
      public static const MESSAGE_KIN_ACCOUNT_BALANCE_UPDATED:* = "KinAccountBalanceUpdated";
      
      public static const MESSAGE_KIN_ACCOUNT_TRANSACTION_SUCCESS:* = "KinAccountTransactionSuccess";
      
      public static const MESSAGE_KIN_ACCOUNT_BUILD_WHITELISTABLE_TRANSACTION_SUCCESS:* = "KinAccountBuildWhitelistableTransactionSuccess";
      
      public static const MESSAGE_KIN_ACCOUNT_TRANSACTION_FAIL:* = "KinAccountTransactionFail";
      
      public static const MESSAGE_KIN_ACCOUNT_BACKUP_FLOW_FINISHED:* = "KinAccountBackupFlowFinished";
      
      public static const MESSAGE_KIN_ACCOUNT_RESTORE_FLOW_FINISHED:* = "KinAccountRestoreFlowFinished";
      
      public static const MESSAGE_KIN_READY_FOR_DISPLAY:* = "KinReadyForDisplay";
      
      public static const MESSAGE_KIN_ACCOUNT_ONBOARDING_REQUIRED:* = "KinAccountOnboardingRequired";
      
      public function BMPubSub()
      {
         super();
      }
      
      public static function sub(param1:String, param2:Function) : Number
      {
         return _pubSub.sub(param1,param2);
      }
      
      public static function pub(param1:String, param2:Object = null) : *
      {
         _pubSub.pub(param1,param2);
      }
      
      public static function remove(param1:Number) : Boolean
      {
         return _pubSub.remove(param1);
      }
   }
}

