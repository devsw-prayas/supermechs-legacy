package net.battleMechsMulti.screens
{
   import com.greensock.*;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.screens.buyStarterPack.BMBuyStarterPackScreenChooser;
   import net.tacticsoft.utils.FunctionCall;
   
   public class BMScreenTransitionsManager extends BMBaseScreen
   {
      
      private var _lastScreen:String = "";
      
      private var _prevScreen:String = "";
      
      private var _currentScreen:String = "";
      
      private var _useBlackScreen:Boolean = false;
      
      private var _skipBlackScreen:Boolean = false;
      
      private var _multiplayerEnterChat:Boolean = false;
      
      private var _lastButtonName:String = "";
      
      private var _raidMenuOpenLeaderboard:Boolean = false;
      
      private var _rankingListOpenClanTab:Boolean = false;
      
      public var refreshTopBarAfterBattle:Boolean = false;
      
      private var blackScreenFunction:FunctionCall = null;
      
      public var mechOrderToSave:Array;
      
      private var _switchServerTo:String = null;
      
      public var mechItemsDataToSave:Array;
      
      public var cameFromClan:Boolean = false;
      
      public var cameFromClanWarPreparation:Boolean = false;
      
      public var cameFromClanWarInspectEnemy:Boolean = false;
      
      public var cameFromWorkshop:Boolean = false;
      
      public var cameFromSinglePlayer:Boolean = false;
      
      public var cameFromMultiplayerLadder:Boolean = false;
      
      public var cameFromRaid:Boolean = false;
      
      public var cameFromWorldMapClanBoss:Boolean = false;
      
      public var clanWarInspectEnemy_playerID:uint;
      
      private var _setCurrentStoryID:uint = 0;
      
      private var _setCurrentMissionSlot:int;
      
      private var _setCurrentMissionMode:int;
      
      private var _setCurrentMissionAutoStart:Boolean = false;
      
      private var _campaignSkipStarterPack:Boolean = false;
      
      private var _clanTab:uint = 0;
      
      private var _mechBuildsMechsPerPlayer:uint = 0;
      
      private var _allowMechsPerPlayerSelectionOnly:Boolean = false;
      
      private var _clanWarBaseAlignment:String;
      
      private var _clanWarBaseInspectPlayerID:int;
      
      public function BMScreenTransitionsManager()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("newMenu");
      }
      
      public function refreshScreen(param1:* = false) : void
      {
         if(!param1)
         {
            this._lastScreen = "";
            this._currentScreen = "";
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
         }
      }
      
      private function externalLockActive() : Boolean
      {
         var _loc1_:Boolean = false;
         if(screensM.isScreenOpened(BMScreensManager.SCR_RANKING_LIST))
         {
            if(screensM.screenRankingList.rankingListEnabled == false)
            {
               _loc1_ = true;
            }
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_SETTINGS))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function buttonClicked(param1:String) : void
      {
         this.buttonClickedSub(param1);
      }
      
      private function buttonClickedSub(param1:String) : void
      {
         if(screensM.screenBlack.isActive() && this._skipBlackScreen == false)
         {
            return;
         }
         if(this.externalLockActive())
         {
            return;
         }
         this._useBlackScreen = false;
         this.blackScreenFunction = null;
         switch(param1)
         {
            case "clanWarBase":
               this.openClanWarBase();
               break;
            case "singlePlayer":
               this.openSinglePlayer();
               break;
            case "multiplayerLadder":
               this.openMultiplayerLadder();
               break;
            case "multiplayerChat":
               this.openMultiplayerChat();
               break;
            case "raidMenu":
               this.openRaidMenu();
               break;
            case "baseBuilding":
               this.openBaseBuilding();
               break;
            case "hangerMech":
               this.openHangerMech();
               break;
            case "shopCombined":
               this.openShopCombined();
               break;
            case "shopMythical":
               this.openShopMythical();
               break;
            case "communityClan":
               this.openCommunityClan();
               break;
            case "communityRankingList":
               this.openCommunityRankingList();
               break;
            case "arenaShop":
               this.openArenaShop();
               break;
            case "mechBuilds":
               this.openMechBuilds();
               break;
            case "communityNews":
               this.openCommunityNews();
               break;
            case "communityForum":
               this.openCommunityForum();
               break;
            case "communityYouTube":
               this.openCommunityYouTube();
               break;
            case "profileReplays":
               this.openProfileReplays();
               break;
            case "profileGifts":
               this.openProfileGifts();
               break;
            case "profileInfo":
               this.openProfileInfo();
               break;
            case "profileHelp":
               this.openProfileHelp();
               break;
            case "profileOptions":
               this.openProfileOptions();
               break;
            case "profileAccounts":
               this.openProfileAccounts();
               break;
            case "contentPackLibrary":
               this.openContentPackLibrary();
         }
         this.handleActivateBlackScreen();
         if(screensM.isScreenOpened(BMScreensManager.SCR_SELECT_BATTLE_MECHS_PER_PLAYER))
         {
            screensM.screenSelectBattleMechsPerPlayer.closeScreen();
         }
      }
      
      private function handleActivateBlackScreen() : *
      {
         if(this.blackScreenFunction == null)
         {
            return;
         }
         if(this.hasTasks)
         {
            screensM.screenBlack.activateBlackScreen(this.blackScreenFunction.func,true,true,this.blackScreenFunction.params,0,true);
            this.doNextTask();
            return;
         }
         if(this._useBlackScreen == false)
         {
            return;
         }
         if(this._skipBlackScreen)
         {
            this.blackScreenFunction.call();
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.blackScreenFunction.func,true,true,this.blackScreenFunction.params,0);
         }
      }
      
      private function get hasTasks() : Boolean
      {
         return (loginM.settingsUpdateRequired || this.mechOrderToSave != null || this._switchServerTo != null || this.mechItemsDataToSave != null) && !this._skipBlackScreen;
      }
      
      public function get prevScreen() : String
      {
         return this._prevScreen;
      }
      
      private function doNextTask() : void
      {
         var _loc1_:Boolean = false;
         if(this.mechOrderToSave != null)
         {
            remoteM.socketM.inventory_changeMechsOrder(this.mechOrderToSave);
         }
         else if(this._switchServerTo != null)
         {
            BMLoginManager.gi().switchToServer(this._switchServerTo == "multiplayerLadder",this.onSwitchServerComplete);
         }
         else if(this.mechItemsDataToSave != null)
         {
            remoteM.inventory_updateMechs(true,[],this.mechItemsDataToSave,false,dataM.myPlayerData.selectedMechID);
            _loc1_ = true;
         }
         else if(loginM.settingsUpdateRequired)
         {
            BMLoginManager.gi().updateSettings();
         }
         else
         {
            screensM.screenBlack.unBlockOpeningScreen();
         }
         if(_loc1_ && dataM.mechBuildsM.isEnabled)
         {
            dataM.mechBuildsM.updateCurrentBuild();
            remoteM.socketM.inventory_updateMechBuilds(dataM.mechBuildsM.exportData());
         }
      }
      
      public function onSettingsUpdateComplete() : void
      {
         this.doNextTask();
      }
      
      public function onMechOrderSaved() : void
      {
         this.mechOrderToSave = null;
         this.doNextTask();
      }
      
      private function onSwitchServerComplete() : *
      {
         this._switchServerTo = null;
         this.doNextTask();
      }
      
      public function onMechItemsSaved() : *
      {
         if(this.mechItemsDataToSave == null)
         {
            return;
         }
         this.mechItemsDataToSave = null;
         this.doNextTask();
      }
      
      public function removeLastScreen() : void
      {
         switch(this._lastScreen)
         {
            case "clanWarBase":
               if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_BASE))
               {
                  screensM.screenClanWarBase.removeMe();
               }
               break;
            case "mainMenu":
               screensM.removeScreen(BMScreensManager.SCR_MAIN_MENU);
               break;
            case BMScreensManager.SCR_EXTRA_OPTIONS:
               screensM.removeScreen(BMScreensManager.SCR_EXTRA_OPTIONS);
               break;
            case "raidMenu":
               screensM.removeScreen(BMScreensManager.SCR_RAID_MENU);
               break;
            case "baseBuilding":
               screensM.removeScreen(BMScreensManager.SCR_BASE_BUILDING_MAIN);
               break;
            case BMScreensManager.SCR_WORKSHOP:
               screensM.removeScreen(BMScreensManager.SCR_WORKSHOP);
               break;
            case BMScreensManager.SCR_HANGER_UPGRADE:
               screensM.removeScreen(BMScreensManager.SCR_HANGER_UPGRADE);
               break;
            case BMScreensManager.SCR_CONVERT_LEGACY_ITEMS:
               screensM.removeScreen(BMScreensManager.SCR_CONVERT_LEGACY_ITEMS);
               break;
            case "hangerMech":
            case "profileGifts":
            case "shopMythical":
               switch(this._currentScreen)
               {
                  case "hangerMech":
                  case "profileGifts":
                  case "shopMythical":
               }
               break;
            case "shopCombined":
               BMShopManager.gi().close();
               break;
            case "multiplayerLadder":
               if(screensM.isScreenOpened(BMScreensManager.SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS))
               {
                  screensM.screenLadderSeasonEndNewLadderProgress.removeMe();
               }
               if(screensM.isScreenOpened(BMScreensManager.SCR_LADDER_SEASON_END_REWARD))
               {
                  screensM.screenLadderSeasonEndReward.removeMe();
               }
               if(screensM.isScreenOpened(BMScreensManager.SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS))
               {
                  screensM.screenLadderSeasonHighestLadderProgress.removeMe();
               }
               if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER))
               {
                  screensM.screenMultiPlayerLadder.removeMe();
               }
               switch(this._currentScreen)
               {
                  case "multiplayerChat":
                  case "communityClan":
                     break;
                  default:
                     dataM.chatData.exitChat();
               }
               break;
            case "multiplayerChat":
               if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
               {
                  screensM.screenMultiPlayerChat.removeMe();
               }
               switch(this._currentScreen)
               {
                  case "multiplayerLadder":
                  case "communityClan":
                     break;
                  default:
                     dataM.chatData.exitChat();
               }
               break;
            case "singlePlayer":
               if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
               {
                  screensM.screenMissionWorldMap.removeMe();
               }
               break;
            case "communityRankingList":
               if(screensM.isScreenOpened(BMScreensManager.SCR_RANKING_LIST))
               {
                  screensM.screenRankingList.removeScreen();
               }
               break;
            case "arenaShop":
               if(screensM.isScreenOpened(BMScreensManager.SCR_ARENA_SHOP))
               {
                  screensM.screenArenaShop.removeMe();
               }
               break;
            case "mechBuilds":
               if(screensM.isScreenOpened(BMScreensManager.SCR_MECH_BUILDS))
               {
                  screensM.screenMechBuilds.removeMe();
               }
               break;
            case "communitySearchForClan":
               if(screensM.isScreenOpened(BMScreensManager.SCR_SEACH_FOR_CLAN))
               {
                  screensM.screenSearchForClan.removeScreen();
               }
               break;
            case "communityClan":
               switch(this._currentScreen)
               {
                  case "multiplayerLadder":
                  case "multiplayerChat":
                     break;
                  default:
                     dataM.chatData.exitChat();
               }
               if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_MENU))
               {
                  screensM.screenClanMenu.removeMe();
               }
               break;
            case "profileNews":
               if(screensM.isScreenOpened(BMScreensManager.SCR_NEWS))
               {
                  screensM.screenNews.removeMe();
               }
               break;
            case "profileReplays":
               if(screensM.isScreenOpened(BMScreensManager.SCR_REPLAYS))
               {
                  screensM.screenReplays.removeMe();
               }
               break;
            case "profileHelp":
               if(screensM.isScreenOpened(BMScreensManager.SCR_HELP))
               {
                  screensM.screenHelp.removeMe();
               }
               break;
            case "profileInfo":
               if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_INFO))
               {
                  screensM.screenProfileInfo.removeMe();
               }
               break;
            case "profileOptions":
               if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_OPTIONS))
               {
                  screensM.screenProfileOptions.removeMe();
               }
               break;
            case "profileAccounts":
               if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_ACCOUNTS))
               {
                  screensM.screenProfileAccounts.removeMe();
               }
               break;
            case "buyStarterPack":
               if(screensM.isBuyStarterPackOpened())
               {
                  screensM.getBuyStarterPackScreen().removeMe();
               }
               if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR))
               {
                  if(screensM.screenTopBar.btnGetGold != null)
                  {
                     screensM.screenTopBar.btnGetGold.enableMe();
                  }
               }
               break;
            case "contentPackLibrary":
               if(screensM.isScreenOpened(BMScreensManager.SCR_CONTENT_PACK_LIBRARY))
               {
                  screensM.screenContentPackLibrary.removeMe();
               }
         }
         this._lastScreen = "";
      }
      
      public function removeCurrentScreen() : void
      {
         switch(this._currentScreen)
         {
            case "clanWarBase":
               screensM.screenClanWarBase.removeMe();
               break;
            case "mainMenu":
               screensM.removeScreen(BMScreensManager.SCR_MAIN_MENU);
               break;
            case BMScreensManager.SCR_EXTRA_OPTIONS:
               screensM.removeScreen(BMScreensManager.SCR_EXTRA_OPTIONS);
               break;
            case BMScreensManager.SCR_WORKSHOP:
               screensM.removeScreen(BMScreensManager.SCR_WORKSHOP);
               break;
            case "raidMenu":
               screensM.removeScreen(BMScreensManager.SCR_RAID_MENU);
               break;
            case "baseBuilding":
               screensM.removeScreen(BMScreensManager.SCR_BASE_BUILDING_MAIN);
               break;
            case BMScreensManager.SCR_HANGER_UPGRADE:
               screensM.removeScreen(BMScreensManager.SCR_HANGER_UPGRADE);
               break;
            case BMScreensManager.SCR_CONVERT_LEGACY_ITEMS:
               screensM.removeScreen(BMScreensManager.SCR_CONVERT_LEGACY_ITEMS);
               break;
            case "hangerMech":
            case "profileGifts":
               break;
            case "shopCombined":
            case "shopMythical":
               BMShopManager.gi().close();
               break;
            case "singlePlayer":
               screensM.screenMissionWorldMap.removeMe();
               break;
            case "multiplayerLadder":
               screensM.screenMultiPlayerLadder.removeMe();
               break;
            case "multiplayerChat":
               screensM.screenMultiPlayerChat.removeMe();
               break;
            case "communityRankingList":
               screensM.screenRankingList.removeScreen();
               break;
            case "arenaShop":
               screensM.screenArenaShop.removeMe();
               break;
            case "mechBuilds":
               screensM.screenMechBuilds.removeMe();
               break;
            case "communitySearchForClan":
               screensM.screenSearchForClan.removeScreen();
               break;
            case "communityClan":
               screensM.screenClanMenu.removeMe();
               break;
            case "profileNews":
               screensM.screenNews.removeMe();
               break;
            case "profileReplays":
               screensM.screenReplays.removeMe();
               break;
            case "profileHelp":
               screensM.screenHelp.removeMe();
               break;
            case "profileInfo":
               screensM.screenProfileInfo.removeMe();
               break;
            case "profileOptions":
               screensM.screenProfileOptions.removeMe();
               break;
            case "profileAccounts":
               screensM.screenProfileAccounts.removeMe();
               break;
            case "buyStarterPack":
               screensM.getBuyStarterPackScreen().removeMe();
               screensM.screenTopBar.btnGetGold.enableMe();
               break;
            case "contentPackLibrary":
               screensM.screenContentPackLibrary.removeMe();
         }
         this._currentScreen = "";
         this._lastScreen = "";
      }
      
      private function forceBlackScreen() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.hasTasks)
         {
            _loc1_ = true;
         }
         else if(dataM.runAsMobile)
         {
            _loc1_ = true;
         }
         else
         {
            switch(this._lastScreen)
            {
               case "multiplayerLadder":
               case "multiplayerChat":
               case "mainMenu":
               case "clanWarBase":
                  _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private function openSinglePlayer() : void
      {
         var _loc1_:Boolean = this._setCurrentMissionAutoStart;
         var _loc2_:Boolean = false;
         if(!_loc1_)
         {
            if(dataM.isStarterPackActive() && dataM.myProfile.showEpilogueForMode == -1)
            {
               if(dataM.starterPack_displayAfterSinglePlayerMissionCounter >= dataM.DISPLAY_STARTER_PACK_COUNTER_MAX)
               {
                  if(this._campaignSkipStarterPack == false)
                  {
                     _loc2_ = true;
                     dataM.starterPack_displayAfterOnlineBattleCounter = 0;
                     dataM.starterPack_displayAfterSinglePlayerMissionCounter = 0;
                  }
               }
            }
         }
         this._campaignSkipStarterPack = false;
         if(_loc2_)
         {
            dataM.starterPack_goBackToScreen = "singlePlayer";
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openBuyStarterPackSub,["SinglePlayerPopup"]);
            }
            else
            {
               this.openBuyStarterPackSub("SinglePlayerPopup");
            }
         }
         else if(this._skipBlackScreen == false || this.forceBlackScreen())
         {
            this._useBlackScreen = true;
            this.blackScreenFunction = new FunctionCall(this.openSinglePlayerSub);
         }
         else
         {
            this.openSinglePlayerSub();
         }
      }
      
      private function openSinglePlayerSub() : void
      {
         this.openScreenFinalFunctions("singlePlayer");
         dataM.myProfile.resetMissionSlotAndMode();
         screensM.addScreen(BMScreensManager.SCR_MISSION_WORLD_MAP);
         screensM.screenMissionWorldMap.refreshScreen(this._setCurrentStoryID);
         if(this._setCurrentMissionSlot > -1)
         {
            screensM.screenMissionWorldMap.manuallySelectMission(this._setCurrentMissionSlot,this._setCurrentMissionMode);
         }
         else if(this.cameFromWorldMapClanBoss)
         {
            screensM.screenMissionWorldMap.manuallySelectBossMission();
         }
         if(this._setCurrentMissionAutoStart)
         {
            dataM.myProfile.currentStoryID = this._setCurrentStoryID;
            dataM.myProfile.setCurrentMissionSlot(this._setCurrentMissionSlot);
            dataM.myProfile.setCurrentMissionMode(this._setCurrentMissionMode);
         }
         this._setCurrentMissionSlot = -1;
         this._setCurrentMissionMode = -1;
         this._setCurrentStoryID = BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1;
         dataM.trackScreenView("singlePlayer");
         if(this._setCurrentMissionAutoStart)
         {
            screensM.screenMissionWorldMap.enterMission();
         }
         this.removeMe(true);
         this.cameFromWorldMapClanBoss = false;
      }
      
      private function openMultiplayerLadder() : void
      {
         var _loc1_:Boolean = false;
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER) == false)
         {
            _loc1_ = false;
            if(dataM.isStarterPackActive())
            {
               if(dataM.starterPack_displayAfterOnlineBattleCounter >= dataM.DISPLAY_STARTER_PACK_COUNTER_MAX)
               {
                  _loc1_ = true;
                  dataM.starterPack_displayAfterOnlineBattleCounter = 0;
                  dataM.starterPack_displayAfterSinglePlayerMissionCounter = 0;
               }
            }
            if(_loc1_)
            {
               dataM.starterPack_goBackToScreen = "multiplayerLadder";
               if(this._skipBlackScreen)
               {
                  this.openBuyStarterPackSub("MultiplayerPopup");
                  this._skipBlackScreen = false;
               }
               else
               {
                  this._useBlackScreen = true;
                  this.blackScreenFunction = new FunctionCall(this.openBuyStarterPackSub,["MultiplayerPopup"]);
               }
            }
            else if(this._skipBlackScreen)
            {
               this.openMultiplayerLadderSub();
               this._skipBlackScreen = false;
            }
            else
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openMultiplayerLadderSub);
            }
         }
      }
      
      private function openMultiplayerLadderSub() : void
      {
         dataM.chatData.initialize();
         this.openScreenFinalFunctions("multiplayerLadder");
         screensM.addScreen(BMScreensManager.SCR_MULTIPLAYER_LADDER);
         screensM.screenMultiPlayerLadder.refreshScreen(this._multiplayerEnterChat);
         dataM.trackScreenView("multiplayerLadder");
      }
      
      private function openMultiplayerChat() : void
      {
         var _loc1_:Boolean = false;
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT) == false)
         {
            _loc1_ = false;
            if(dataM.isStarterPackActive())
            {
               if(dataM.starterPack_displayAfterOnlineBattleCounter >= dataM.DISPLAY_STARTER_PACK_COUNTER_MAX)
               {
                  _loc1_ = true;
                  dataM.starterPack_displayAfterOnlineBattleCounter = 0;
                  dataM.starterPack_displayAfterSinglePlayerMissionCounter = 0;
               }
            }
            if(_loc1_)
            {
               dataM.starterPack_goBackToScreen = "multiplayerChat";
               if(this._skipBlackScreen)
               {
                  this.openBuyStarterPackSub("MultiplayerChat");
                  this._skipBlackScreen = false;
               }
               else
               {
                  this._useBlackScreen = true;
                  this.blackScreenFunction = new FunctionCall(this.openBuyStarterPackSub,["MultiplayerChat"]);
               }
            }
            else if(this._skipBlackScreen)
            {
               this.openMultiplayerChatSub();
               this._skipBlackScreen = false;
            }
            else
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openMultiplayerChatSub);
            }
         }
      }
      
      private function openMultiplayerChatSub() : void
      {
         dataM.chatData.initialize();
         this.openScreenFinalFunctions("multiplayerChat",true);
         screensM.addScreen(BMScreensManager.SCR_MULTIPLAYER_CHAT);
         screensM.screenMultiPlayerChat.refreshScreen(this._multiplayerEnterChat);
         dataM.trackScreenView("multiplayerChat");
         if(this._lastScreen != "multiplayerLadder")
         {
            screensM.screenTopBar.mcLadderRankDisplay.showRankStars(true);
         }
      }
      
      private function openRaidMenu() : void
      {
         if(this._skipBlackScreen)
         {
            this.openRaidMenuSub();
            this._skipBlackScreen = false;
         }
         else
         {
            this._useBlackScreen = true;
            this.blackScreenFunction = new FunctionCall(this.openRaidMenuSub);
         }
      }
      
      private function openRaidMenuSub() : void
      {
         this.openScreenFinalFunctions("raidMenu");
         screensM.addScreen(BMScreensManager.SCR_RAID_MENU);
         dataM.trackScreenView("raidMenu");
         if(this._raidMenuOpenLeaderboard)
         {
            screensM.screenRaidMenu.selectLeaderboardTab();
         }
         this._raidMenuOpenLeaderboard = false;
         this.cameFromRaid = false;
      }
      
      private function openClanWarBase() : void
      {
         if(this._skipBlackScreen)
         {
            this.openClanWarBaseSub();
            this._skipBlackScreen = false;
         }
         else
         {
            this._useBlackScreen = true;
            this.blackScreenFunction = new FunctionCall(this.openClanWarBaseSub);
         }
      }
      
      private function openClanWarBaseSub() : void
      {
         this.cameFromClanWarInspectEnemy = false;
         this.openScreenFinalFunctions("clanWarBase");
         screensM.addScreen(BMScreensManager.SCR_CLAN_WAR_BASE);
         screensM.screenClanWarBase.setBaseAlignment(this._clanWarBaseAlignment);
         if(this._clanWarBaseInspectPlayerID > -1)
         {
            screensM.screenClanWarBase.inspectPlayerByID(this._clanWarBaseInspectPlayerID);
         }
         dataM.trackScreenView("clanWarBase");
      }
      
      private function openBaseBuilding() : void
      {
         if(this._skipBlackScreen)
         {
            this.openBaseBuildingSub();
            this._skipBlackScreen = false;
         }
         else
         {
            this._useBlackScreen = true;
            this.blackScreenFunction = new FunctionCall(this.openBaseBuildingSub);
         }
      }
      
      private function openBaseBuildingSub() : void
      {
         screensM.addScreen(BMScreensManager.SCR_BASE_BUILDING_MAIN);
         this.openScreenFinalFunctions("baseBuilding",true,BMScreenTopBarClone2);
         dataM.trackScreenView("baseBuilding");
      }
      
      public function contentPackLibraryClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("contentPackLibrary");
      }
      
      private function openContentPackLibrary() : void
      {
         if(this._skipBlackScreen)
         {
            this.openContentPackLibrarySub();
            this._skipBlackScreen = false;
         }
         else
         {
            this._useBlackScreen = true;
            this.blackScreenFunction = new FunctionCall(this.openContentPackLibrarySub);
         }
      }
      
      private function openContentPackLibrarySub() : void
      {
         this.openScreenFinalFunctions("contentPackLibrary");
         screensM.addScreen(BMScreensManager.SCR_CONTENT_PACK_LIBRARY);
         dataM.trackScreenView("contentPackLibrary");
      }
      
      private function openCommunityClan() : void
      {
         this.cameFromClan = false;
         this.cameFromClanWarPreparation = false;
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_MENU))
         {
            return;
         }
         if(this.forceBlackScreen())
         {
            this._useBlackScreen = true;
            this.blackScreenFunction = new FunctionCall(this.openCommunityClanSub);
         }
         else
         {
            this.openCommunityClanSub();
         }
      }
      
      private function openCommunityClanSub() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.clanID > 0)
         {
            this.openScreenFinalFunctions("communityClan");
            screensM.addScreen(BMScreensManager.SCR_CLAN_MENU);
            dataM.trackScreenView("communityClan");
            if(this._clanTab > 0)
            {
               screensM.screenClanMenu.setPendingTab(this._clanTab);
            }
            this._clanTab = 0;
         }
         else
         {
            this.openCommunitySearchForClan();
         }
      }
      
      private function openCommunityRankingList() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_RANKING_LIST) == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openCommunityRankingListSub);
            }
            else
            {
               this.openCommunityRankingListSub();
            }
         }
      }
      
      private function openCommunityRankingListSub() : void
      {
         this.openScreenFinalFunctions("communityRankingList");
         screensM.addScreen(BMScreensManager.SCR_RANKING_LIST);
         screensM.screenRankingList.refreshScreen(this._rankingListOpenClanTab);
         this._rankingListOpenClanTab = false;
         dataM.trackScreenView("communityRankingList");
      }
      
      private function openCommunitySearchForClan() : void
      {
         this.openScreenFinalFunctions("communitySearchForClan");
         screensM.addScreen(BMScreensManager.SCR_SEACH_FOR_CLAN);
         screensM.screenSearchForClan.refreshScreen();
         dataM.trackScreenView("communitySearchForClan");
      }
      
      private function openArenaShop() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_ARENA_SHOP) == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openArenaShopSub);
            }
            else
            {
               this.openArenaShopSub();
            }
         }
      }
      
      private function openArenaShopSub() : void
      {
         this.openScreenFinalFunctions("arenaShop");
         screensM.addScreen(BMScreensManager.SCR_ARENA_SHOP);
         dataM.trackScreenView("arenaShop");
      }
      
      private function openMechBuilds() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_MECH_BUILDS) == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openMechBuildsSub);
            }
            else
            {
               this.openMechBuildsSub();
            }
         }
      }
      
      private function openMechBuildsSub() : void
      {
         this.openScreenFinalFunctions("mechBuilds");
         screensM.addScreen(BMScreensManager.SCR_MECH_BUILDS);
         dataM.trackScreenView("mechBuilds");
         if(this._mechBuildsMechsPerPlayer > 0)
         {
            screensM.screenMechBuilds.activateSelectOnlyMode(this._mechBuildsMechsPerPlayer,this._allowMechsPerPlayerSelectionOnly);
            this._mechBuildsMechsPerPlayer = 0;
            this._allowMechsPerPlayerSelectionOnly = false;
         }
      }
      
      private function openCommunityNews() : void
      {
         if(dataM.newsHandler.hasNews())
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_NEWS) == false)
            {
               if(this.forceBlackScreen())
               {
                  this._useBlackScreen = true;
                  this.blackScreenFunction = new FunctionCall(this.openCommunityNewsSub);
               }
               else
               {
                  this.openCommunityNewsSub();
               }
            }
         }
      }
      
      private function openCommunityNewsSub() : void
      {
         if(dataM.newsHandler.hasNews())
         {
            this.openScreenFinalFunctions("profileNews");
            screensM.addScreen(BMScreensManager.SCR_NEWS);
            screensM.screenNews.refreshScreen();
            dataM.trackScreenView("communityNews");
         }
      }
      
      private function openHangerMech() : void
      {
      }
      
      private function openHangerMechSub() : void
      {
      }
      
      private function openShopCombined() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         if(dataM.packages_markSpecificPackageID > 0)
         {
            _loc2_ = BMShopManager.gi().getCategoryForPackageID(dataM.packages_markSpecificPackageID);
            if(_loc2_ != BMShopManager.CAT_NONE)
            {
               BMShopManager.gi().showCategory(_loc2_,"MainMenu");
               _loc1_ = true;
            }
            dataM.packages_markSpecificPackageID = 0;
         }
         if(!_loc1_)
         {
            BMShopManager.gi().showItemBoxes("MainMenu");
         }
      }
      
      private function openShopMythical() : void
      {
      }
      
      private function openShopMythicalSub() : void
      {
      }
      
      public function extraOptions(param1:Boolean = true) : void
      {
         if(param1)
         {
            this._useBlackScreen = true;
            this._skipBlackScreen = false;
            this.blackScreenFunction = new FunctionCall(this.extraOptionsSub);
            this.handleActivateBlackScreen();
         }
         else
         {
            this.extraOptionsSub();
         }
      }
      
      private function extraOptionsSub() : void
      {
         this.openScreenFinalFunctions(BMScreensManager.SCR_EXTRA_OPTIONS);
         screensM.addScreen(BMScreensManager.SCR_EXTRA_OPTIONS);
      }
      
      private function openProfileGifts() : void
      {
      }
      
      private function openProfileGiftsSub() : void
      {
      }
      
      private function openCommunityForum() : void
      {
         dataM.openURL("http://community.tacticsoft.net/c/supermechs","_blank");
         dataM.trackScreenView("communityForum");
      }
      
      private function openCommunityYouTube() : void
      {
         dataM.openURL("https://www.youtube.com/channel/UCpB4nxzR8cEUQSGFG_lLIKA","_blank");
         dataM.trackScreenView("communityYouTube");
      }
      
      private function openProfileReplays() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_REPLAYS) == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openProfileReplaysSub);
            }
            else
            {
               this.openProfileReplaysSub();
            }
         }
      }
      
      private function openProfileReplaysSub() : void
      {
         this.openScreenFinalFunctions("profileReplays");
         screensM.addScreen(BMScreensManager.SCR_REPLAYS);
         screensM.screenReplays.refreshScreen();
         dataM.trackScreenView("profileReplays");
      }
      
      private function openProfileHelp() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_HELP) == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openProfileHelpSub);
            }
            else
            {
               this.openProfileHelpSub();
            }
         }
      }
      
      private function openProfileHelpSub() : void
      {
         this.openScreenFinalFunctions("profileHelp");
         screensM.addScreen(BMScreensManager.SCR_HELP);
         screensM.screenHelp.refreshScreen();
         dataM.trackScreenView("profileHelp");
      }
      
      private function openProfileInfo() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_INFO) == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openProfileInfoSub);
            }
            else
            {
               this.openProfileInfoSub();
            }
         }
      }
      
      private function openProfileInfoSub() : void
      {
         this.openScreenFinalFunctions("profileInfo");
         screensM.addScreen(BMScreensManager.SCR_PROFILE_INFO);
         screensM.screenProfileInfo.refreshScreen();
         dataM.trackScreenView("profileInfo");
      }
      
      private function openProfileOptions() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_OPTIONS) == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openProfileOptionsSub);
            }
            else
            {
               this.openProfileOptionsSub();
            }
         }
      }
      
      private function openProfileOptionsSub() : void
      {
         this.openScreenFinalFunctions("profileOptions");
         screensM.addScreen(BMScreensManager.SCR_PROFILE_OPTIONS);
         screensM.screenProfileOptions.refreshScreen();
         dataM.trackScreenView("profileOptions");
      }
      
      private function openProfileAccounts() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_ACCOUNTS) == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openProfileAccountsSub);
            }
            else
            {
               this.openProfileAccountsSub();
            }
         }
      }
      
      private function openProfileAccountsSub() : void
      {
         this.openScreenFinalFunctions("profileAccounts");
         screensM.addScreen(BMScreensManager.SCR_PROFILE_ACCOUNTS);
         screensM.screenProfileAccounts.refreshScreen();
         dataM.trackScreenView("profileAccounts");
      }
      
      public function openProfileLogout() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("logout",-1,-1);
      }
      
      public function openBuyStarterPack(param1:String) : void
      {
         if(screensM.isBuyStarterPackOpened())
         {
            return;
         }
         if(BMBuyStarterPackScreenChooser.isStarterPackLegit() == false)
         {
            return;
         }
         if(this.forceBlackScreen())
         {
            this._useBlackScreen = true;
            this.blackScreenFunction = new FunctionCall(this.openBuyStarterPackSub,[param1]);
            this.handleActivateBlackScreen();
         }
         else
         {
            this.openBuyStarterPackSub(param1);
         }
      }
      
      public function openBuyStarterPackSub(param1:String) : void
      {
         this.openScreenFinalFunctions("buyStarterPack",true);
         dataM.updateProfileStarterPackData();
         this.addAndRefreshBuyStarterPackScreen(param1);
         this.removeMe(false);
      }
      
      private function addAndRefreshBuyStarterPackScreen(param1:String) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc2_:String = BMBuyStarterPackScreenChooser.getBuyStarterPackScreenName();
         screensM.addIfNotOpened(_loc2_);
         switch(_loc2_)
         {
            case BMScreensManager.SCR_BUY_STARTER_PACK_IMPROVE_YOUR_MECH:
               _loc3_ = BMBuyStarterPackScreenChooser.getStatsForImproveYourMechStarterPack();
               _loc4_ = _loc3_[0];
               _loc5_ = _loc3_[1];
               screensM.screenBuyStarterPackImproveYourMech.refreshScreen(param1,_loc4_,_loc5_);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_MECH_AND_CURRENCY:
               screensM.screenBuyStarterPackMechAndCurrency.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_MECH_ONLY:
               screensM.screenBuyStarterPackMechOnly.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_BOXES_AND_CURRENCY:
               screensM.screenBuyStarterPackBoxesAndCurrency.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_BOXES_ONLY:
               screensM.screenBuyStarterPackBoxesOnly.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_TOKENS:
               screensM.screenBuyStarterPackTokens.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_GOLD:
               screensM.screenBuyStarterPackGold.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_GOLD_WITH_BADGE:
               screensM.screenBuyStarterPackGold_withBadge.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_TOKENS_WITH_BADGE:
               screensM.screenBuyStarterPackTokens_withBadge.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_GOLD_AND_TOKENS:
               screensM.screenBuyStarterPackGoldAndTokens.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_ITEM_AND_TOKENS:
               screensM.screenBuyStarterPackItemAndTokens.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_GUARANTEED_LEGENDARY_BOX:
               screensM.screenBuyStarterPackGuaranteedLegendaryBox.refreshScreen(param1);
               break;
            case BMScreensManager.SCR_BUY_STARTER_PACK_BUNDLE:
               screensM.screenBuyStarterPackBundle.refreshScreen(param1);
         }
      }
      
      private function openScreenFinalFunctions(param1:String, param2:Boolean = false, param3:Class = null) : void
      {
         if(this._currentScreen != "")
         {
            this._lastScreen = this._currentScreen;
         }
         else
         {
            this._lastScreen = param1;
         }
         this._prevScreen = this._lastScreen;
         this._currentScreen = param1;
         if(this._lastScreen != this._currentScreen)
         {
            this.removeLastScreen();
         }
         if(param2)
         {
            this.addTopBar(param3);
         }
         else
         {
            this.removeTopBar();
         }
      }
      
      private function removeTopBar() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR))
         {
            screensM.removeScreen(BMScreensManager.SCR_TOP_BAR);
         }
      }
      
      private function addTopBar(param1:Class = null) : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR) == false)
         {
            if(param1 == null)
            {
               screensM.addScreen(BMScreensManager.SCR_TOP_BAR);
            }
            else
            {
               screensM.addScreen(BMScreensManager.SCR_TOP_BAR,true,param1);
            }
            screensM.screenTopBar.refreshScreen(this.refreshTopBarAfterBattle);
            this.refreshTopBarAfterBattle = false;
         }
      }
      
      public function mainMenu(param1:Boolean = false) : void
      {
         this._useBlackScreen = true;
         this._skipBlackScreen = param1;
         this.blackScreenFunction = new FunctionCall(this.mainScreenSub);
         this.handleActivateBlackScreen();
      }
      
      public function mainScreenSub() : void
      {
         if(dataM.chatData.isInChatChannel)
         {
            dataM.chatData.exitChat();
         }
         this.openScreenFinalFunctions("mainMenu");
         screensM.addScreen(BMScreensManager.SCR_MAIN_MENU);
         screensM.screenMainMenu.refreshScreen();
         dataM.trackScreenView(BMScreensManager.SCR_MAIN_MENU);
      }
      
      public function upgrade() : *
      {
         this._useBlackScreen = true;
         this._skipBlackScreen = false;
         this.blackScreenFunction = new FunctionCall(this.upgradeSub);
         this.handleActivateBlackScreen();
      }
      
      public function upgradeSub() : *
      {
         this.openScreenFinalFunctions(BMScreensManager.SCR_HANGER_UPGRADE);
         screensM.addScreen(BMScreensManager.SCR_HANGER_UPGRADE);
      }
      
      public function convertLegacyItems() : *
      {
         this._useBlackScreen = true;
         this._skipBlackScreen = false;
         this.blackScreenFunction = new FunctionCall(this.convertLegacyItemsSub);
         this.handleActivateBlackScreen();
      }
      
      public function convertLegacyItemsSub() : *
      {
         this.openScreenFinalFunctions(BMScreensManager.SCR_CONVERT_LEGACY_ITEMS);
         screensM.addScreen(BMScreensManager.SCR_CONVERT_LEGACY_ITEMS);
      }
      
      public function singlePlayerClicked(param1:Boolean = false, param2:int = -1, param3:int = -1, param4:int = -1, param5:Boolean = false, param6:Boolean = false) : void
      {
         this.cameFromSinglePlayer = false;
         this._skipBlackScreen = param1;
         if(param2 > 0)
         {
            this._setCurrentStoryID = param2;
         }
         this._setCurrentMissionSlot = param3;
         this._setCurrentMissionMode = param4;
         this._setCurrentMissionAutoStart = param5;
         this._campaignSkipStarterPack = param6;
         if(BMLoginManager.gi().isNeedToSwitchServerTo(false))
         {
            this._switchServerTo = "singlePlayer";
         }
         if(dataM.contentPackResolver.didUnlockNewContentPackID())
         {
            this.contentPackLibraryClicked(param1);
            this.cameFromSinglePlayer = true;
         }
         else
         {
            this.buttonClicked("singlePlayer");
         }
      }
      
      public function multiplayerLadderClicked(param1:Boolean = false, param2:Boolean = true) : void
      {
         this.cameFromMultiplayerLadder = false;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc3_.ageVerification == false)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("ageVerification",-1,-1);
            return;
         }
         if(dataM.contentPackResolver.didUnlockNewContentPackID())
         {
            this.contentPackLibraryClicked(param1);
            this.cameFromMultiplayerLadder = true;
            return;
         }
         if(this._currentScreen == "multiplayerChat")
         {
            param2 = false;
         }
         if(BMLoginManager.gi().isNeedToSwitchServerTo(true))
         {
            this._switchServerTo = "multiplayerLadder";
         }
         this._skipBlackScreen = param1;
         this._multiplayerEnterChat = param2;
         this.buttonClicked("multiplayerLadder");
      }
      
      public function multiplayerChatClicked(param1:Boolean = false, param2:Boolean = false) : void
      {
         if(param2 == false && this._currentScreen != "multiplayerLadder")
         {
            param2 = true;
         }
         if(BMLoginManager.gi().isNeedToSwitchServerTo(true))
         {
            this._switchServerTo = "multiplayerLadder";
         }
         this._skipBlackScreen = param1;
         this._multiplayerEnterChat = param2;
         this.buttonClicked("multiplayerChat");
      }
      
      public function communityClanClicked(param1:Boolean = false, param2:uint = 0) : void
      {
         this._clanTab = param2;
         if(BMLoginManager.gi().isNeedToSwitchServerTo(true))
         {
            this._switchServerTo = "multiplayerLadder";
         }
         this._skipBlackScreen = param1;
         this.buttonClicked("communityClan");
      }
      
      public function communityRankingListClicked(param1:Boolean = false, param2:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this._rankingListOpenClanTab = param2;
         this.buttonClicked("communityRankingList");
      }
      
      public function arenaShopClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("arenaShop");
      }
      
      public function mechBuildsClicked(param1:uint = 0, param2:Boolean = false, param3:Boolean = false) : void
      {
         this._mechBuildsMechsPerPlayer = param1;
         this._allowMechsPerPlayerSelectionOnly = param2;
         this._skipBlackScreen = param3;
         this.buttonClicked("mechBuilds");
      }
      
      public function profileReplaysClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("profileReplays");
      }
      
      public function hangerMechClicked(param1:Boolean = false) : void
      {
         this._useBlackScreen = true;
         this._skipBlackScreen = param1;
         this.blackScreenFunction = new FunctionCall(this.openWorkshopSub);
         this.handleActivateBlackScreen();
      }
      
      public function openWorkshopSub() : void
      {
         this.cameFromWorkshop = false;
         this.openScreenFinalFunctions(BMScreensManager.SCR_WORKSHOP,false);
         screensM.addScreen(BMScreensManager.SCR_WORKSHOP);
      }
      
      public function shopCombinedClicked(param1:Boolean = false) : void
      {
         this.openShopCombined();
      }
      
      public function shopMythicalClicked() : void
      {
         this.buttonClicked("shopMythical");
      }
      
      public function raidMenuClicked(param1:Boolean = false, param2:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         if(BMLoginManager.gi().isNeedToSwitchServerTo(false))
         {
            this._switchServerTo = "singlePlayer";
         }
         this._raidMenuOpenLeaderboard = param2;
         this.buttonClicked("raidMenu");
      }
      
      public function baseBuildingClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("baseBuilding");
      }
      
      public function communityNewsClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("communityNews");
      }
      
      public function profileGiftsClicked() : void
      {
         this.buttonClicked("profileGifts");
      }
      
      public function communityForumClicked() : void
      {
         if(false == false)
         {
            this.buttonClicked("communityForum");
         }
      }
      
      public function communityYouTubeClicked() : void
      {
         this.buttonClicked("communityYouTube");
      }
      
      public function profileInfoClicked() : void
      {
         this.buttonClicked("profileInfo");
      }
      
      public function profileHelpClicked() : void
      {
         this.buttonClicked("profileHelp");
      }
      
      public function profileOptionsClicked() : void
      {
         this.buttonClicked("profileOptions");
      }
      
      public function profileAccountsClicked() : void
      {
         this.buttonClicked("profileAccounts");
      }
      
      public function profileLogoutClicked() : void
      {
         this.buttonClicked("profileLogout");
      }
      
      public function clanWarBaseClicked(param1:String, param2:int = -1, param3:Boolean = false) : void
      {
         this._clanWarBaseAlignment = param1;
         this._clanWarBaseInspectPlayerID = param2;
         this._skipBlackScreen = param3;
         this.buttonClicked("clanWarBase");
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen(true);
      }
      
      public function removeMe(param1:Boolean = true) : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_ITEM_CARDS))
         {
            screensM.screenItemCards.removeScreenInstantly();
         }
         if(param1)
         {
            this.removeTopBar();
         }
      }
      
      public function reset() : *
      {
         this._prevScreen = "";
      }
   }
}

