package net.battleMechsMulti.data
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   
   public class BattleTypeResolver
   {
      
      public static var ENV_CAMPAIGN:String = "campaign";
      
      public static var ENV_RAID:String = "raid";
      
      public static var ENV_CLAN_BOSS:String = "clanBoss";
      
      public static var ENV_CLAN_WAR:String = "clanWar";
      
      public function BattleTypeResolver()
      {
         super();
      }
      
      public static function shouldPvEBattleBeOnServer(param1:String, param2:uint = 0) : Boolean
      {
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return false;
         }
         var _loc3_:String = dataM.getGeneralSetting("pveOnServerRequirements","");
         if(_loc3_ == "")
         {
            return false;
         }
         var _loc4_:Object = JSON.parse(_loc3_);
         if(param1 == ENV_RAID)
         {
            if(param2 >= int(_loc4_.minRaidLevel))
            {
               return true;
            }
            return false;
         }
         if(param1 == ENV_CLAN_BOSS)
         {
            if(_loc4_.clanBoss)
            {
               return true;
            }
            return false;
         }
         if(param1 == ENV_CLAN_WAR)
         {
            if(_loc4_.clanWar)
            {
               return true;
            }
            return false;
         }
         if(param1 == ENV_CAMPAIGN)
         {
            if(dataM.myProfile.level >= int(_loc4_.minXPLevelForCampaign))
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public static function get isTutorial() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL_PVE;
      }
      
      public static function get isCampaignLocal() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_PVE && dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION;
      }
      
      public static function get isCampaignOnServer() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_PVE_ON_SERVER && dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION;
      }
      
      public static function get isCampaign() : Boolean
      {
         return isCampaignLocal || isCampaignOnServer;
      }
      
      public static function get isPvE() : Boolean
      {
         return isCampaign || isClanWar || isClanBoss || isRaid;
      }
      
      public static function get isClanBossLocal() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_PVE && dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS;
      }
      
      public static function get isClanBossOnServer() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_PVE_ON_SERVER && dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS;
      }
      
      public static function get isClanBoss() : Boolean
      {
         return isClanBossLocal || isClanBossOnServer;
      }
      
      public static function get isRaidLocal() : Boolean
      {
         return dataM.raidData.isRaidInProgress() && dataM.gameType == BMDataManager.GAME_TYPE_PVE;
      }
      
      public static function get isRaidOnServer() : Boolean
      {
         return dataM.raidData.isRaidInProgress() && dataM.gameType == BMDataManager.GAME_TYPE_PVE_ON_SERVER;
      }
      
      public static function get isRaid() : Boolean
      {
         return isRaidLocal || isRaidOnServer;
      }
      
      public static function get isClanWarLocal() : Boolean
      {
         return false;
      }
      
      public static function get isClanWarOnServer() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_CLAN_WAR;
      }
      
      public static function get isClanWar() : Boolean
      {
         return isClanWarLocal || isClanWarOnServer;
      }
      
      public static function get isLadderPvPOnServer() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_PVP && (dataM.gameSubType == BMDataManager.GAME_SUB_TYPE_PVP_DEFAULT || dataM.gameSubType == BMDataManager.GAME_SUB_TYPE_NONE);
      }
      
      public static function get isLadderPvPBot() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_PVP && dataM.gameSubType == BMDataManager.GAME_SUB_TYPE_PVP_BOT;
      }
      
      public static function get isLadderBattle() : Boolean
      {
         return isLadderPvPOnServer || isLadderPvPBot;
      }
      
      public static function get isPvPPrivateBattle() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_PVP && dataM.gameSubType == BMDataManager.GAME_SUB_TYPE_PVP_BATTLE_INVITATION;
      }
      
      public static function get isReplay() : Boolean
      {
         return dataM.gameType == BMDataManager.GAME_TYPE_REPLAY;
      }
      
      public static function get isSinglePlayer() : Boolean
      {
         return isTutorial || isCampaign || isRaid || isClanBoss || isClanWar;
      }
      
      public static function get isPvEOnServer() : Boolean
      {
         return isCampaignOnServer || isRaidOnServer || isClanBossOnServer || isClanWarOnServer;
      }
      
      public static function get isBattleOnServer() : Boolean
      {
         return isLadderPvPOnServer || isPvPPrivateBattle || isPvEOnServer;
      }
      
      private static function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
   }
}

