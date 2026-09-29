package net.battleMechsMulti.helpers
{
   public class BMGameShortcutsHelper
   {
      
      private static const SHORTCUT_DISABLE_ALL_SHORTCUTS:Boolean = false;
      
      private static const SHORTCUT_SCREEN_ITEM_CARDS:Boolean = true;
      
      private static const SHORTCUT_GAME_SPEED:Boolean = true;
      
      private static const SHORTCUT_LEVEL_UP:Boolean = true;
      
      private static const SHORTCUT_MISSION_COMPLETED:Boolean = true;
      
      private static const SHORTCUT_SHOP:Boolean = true;
      
      private static const SHORTCUT_VS:Boolean = true;
      
      private static const SHORTCUT_MECH_DESTRUCTION:Boolean = true;
      
      private static const SHORTCUT_BATTLE_RESULT_SCREEN:Boolean = true;
      
      private static const SHORTCUT_BATTLE_STOMP_GUIDE:Boolean = true;
      
      private static const SHORTCUT_BATTLE_EXTRA_DAMAGE:Boolean = true;
      
      public function BMGameShortcutsHelper()
      {
         super();
         throw new Error("Don\'t construct this class");
      }
      
      public static function extraDamamgeShortcut() : Boolean
      {
         return false;
      }
      
      public static function missionCompletedShortcut() : Boolean
      {
         return false;
      }
      
      public static function battleStompGuideShortcut() : Boolean
      {
         return false;
      }
      
      public static function battleResultScreenShortcut() : Boolean
      {
         return false;
      }
      
      public static function mechDestructionShortcut() : Boolean
      {
         return false;
      }
      
      public static function vsShortcut() : Boolean
      {
         return false;
      }
      
      public static function shopShortcut() : Boolean
      {
         return false;
      }
      
      public static function screenItemCardsShortcut() : Boolean
      {
         return false;
      }
      
      public static function gameSpeedShortcut() : Boolean
      {
         return false;
      }
      
      public static function levelUpShortcut() : Boolean
      {
         return false;
      }
   }
}

