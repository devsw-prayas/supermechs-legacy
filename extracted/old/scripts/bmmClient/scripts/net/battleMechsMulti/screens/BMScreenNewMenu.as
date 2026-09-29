package net.battleMechsMulti.screens
{
   import com.greensock.*;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   
   public class BMScreenNewMenu extends BMBaseScreen
   {
      
      private var _loadAchievements:Boolean = true;
      
      private var _lastScreen:String = "";
      
      private var _currentScreen:String = "";
      
      private var _useBlackScreen:Boolean = false;
      
      private var _skipBlackScreen:Boolean = false;
      
      private var _multiplayerEnterChat:Boolean = false;
      
      private var _updateMechRequired:Boolean = false;
      
      private var _lastButtonName:String = "";
      
      public var refreshTopBarAfterBattle:Boolean = false;
      
      private var blackScreenFunction:Function = null;
      
      public function BMScreenNewMenu()
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
            this._updateMechRequired = false;
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
         if(screensM.isScreenOpened("screenRankingList"))
         {
            if(screensM.screenRankingList.rankingListEnabled == false)
            {
               _loc1_ = true;
            }
         }
         else if(screensM.isScreenOpened("screenClanFlag"))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function buttonClicked(param1:String) : void
      {
         if(param1 == "multiplayerLadder")
         {
            dataM.sessionManager.switchToServer(true,this.buttonClickedSub,[param1]);
         }
         else if(param1 == "singlePlayer")
         {
            dataM.sessionManager.switchToServer(false,this.buttonClickedSub,[param1]);
         }
         else
         {
            this.buttonClickedSub(param1);
         }
      }
      
      private function buttonClickedSub(param1:String) : void
      {
         var _loc2_:Array = null;
         if(screensM.screenBlack.isActive() == false || this._skipBlackScreen)
         {
            if(this.externalLockActive() == false)
            {
               this._useBlackScreen = false;
               this.blackScreenFunction = null;
               _loc2_ = new Array();
               _loc2_ = ["multiplayer","hanger","shop","community","profile"];
               switch(param1)
               {
                  case "singlePlayer":
                     this.openSinglePlayer();
                     break;
                  case "multiplayerLadder":
                     this.openMultiplayerLadder();
                     break;
                  case "multiplayerChat":
                     this.openMultiplayerChat();
                     break;
                  case "hangerMech":
                     this.openHangerMech();
                     break;
                  case "hangerFusion":
                     this.openHangerFusion();
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
                  case "profileAchievements":
                     this.openProfileAchievements();
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
                  case "profileLogout":
                     this.openProfileLogout();
               }
               if(this._useBlackScreen)
               {
                  if(this._skipBlackScreen)
                  {
                     this.blackScreenFunction();
                  }
                  else
                  {
                     screensM.screenBlack.activateBlackScreen(this.blackScreenFunction,true,true,null,0);
                  }
               }
               if(screensM.isScreenOpened("screenSelectBattleMechsPerPlayer"))
               {
                  screensM.screenSelectBattleMechsPerPlayer.closeScreen();
               }
            }
         }
      }
      
      public function removeLastScreen() : void
      {
         switch(this._lastScreen)
         {
            case "mainMenu":
               screensM.removeScreen("screenMainMenu");
               break;
            case "hangerMech":
            case "hangerFusion":
            case "profileGifts":
            case "shopMythical":
               switch(this._currentScreen)
               {
                  case "hangerMech":
                  case "hangerFusion":
                  case "profileGifts":
                  case "shopMythical":
                     break;
                  default:
                     screensM.screenHangerMenu.removeHanger();
               }
               break;
            case "shopCombined":
               BMShopManager.gi().close();
               break;
            case "multiplayerLadder":
               screensM.screenMultiPlayerLadder.removeMe();
               switch(this._currentScreen)
               {
                  case "multiplayerChat":
                  case "communityClan":
                     break;
                  default:
                     remoteM.socketM.chat_exit();
               }
               break;
            case "multiplayerChat":
               screensM.screenMultiPlayerChat.removeMe();
               switch(this._currentScreen)
               {
                  case "multiplayerLadder":
                  case "communityClan":
                     break;
                  default:
                     remoteM.socketM.chat_exit();
               }
               break;
            case "singlePlayer":
               screensM.screenMissionWorldMap.removeMe();
               break;
            case "communityRankingList":
               screensM.screenRankingList.removeScreen();
               break;
            case "communitySearchForClan":
               screensM.screenSearchForClan.removeScreen();
               break;
            case "communityClan":
               switch(this._currentScreen)
               {
                  case "multiplayerLadder":
                  case "multiplayerChat":
                     break;
                  default:
                     remoteM.socketM.chat_exit();
               }
               screensM.screenClan.removeMe();
               break;
            case "profileNews":
               screensM.screenNews.removeMe();
               break;
            case "profileAchievements":
               screensM.screenAchievements.removeMe();
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
               screensM.screenBuyStarterPack.removeMe();
               screensM.screenTopBar.btnGetGold.enableMe();
         }
      }
      
      public function removeCurrentScreen() : void
      {
         switch(this._currentScreen)
         {
            case "mainMenu":
               screensM.removeScreen("screenMainMenu");
               break;
            case "hangerMech":
            case "hangerFusion":
            case "profileGifts":
               screensM.screenHangerMenu.removeHanger();
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
            case "communitySearchForClan":
               screensM.screenSearchForClan.removeScreen();
               break;
            case "communityClan":
               screensM.screenClan.removeMe();
               break;
            case "profileNews":
               screensM.screenNews.removeMe();
               break;
            case "profileAchievements":
               screensM.screenAchievements.removeMe();
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
               screensM.screenBuyStarterPack.removeMe();
               screensM.screenTopBar.btnGetGold.enableMe();
         }
      }
      
      private function forceBlackScreen() : Boolean
      {
         var _loc1_:Boolean = false;
         if(dataM.runAsMobile)
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
                  _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private function openSinglePlayer() : void
      {
         var _loc1_:Boolean = false;
         if(dataM.isStarterPackActive())
         {
            if(dataM.starterPack_displayAfterSinglePlayerMissionCounter >= dataM.DISPLAY_STARTER_PACK_COUNTER_MAX)
            {
               _loc1_ = true;
               dataM.starterPack_displayAfterOnlineBattleCounter = 0;
               dataM.starterPack_displayAfterSinglePlayerMissionCounter = 0;
            }
         }
         if(_loc1_)
         {
            dataM.starterPack_goBackToScreen = "singlePlayer";
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openBuyStarterPackSub;
            }
            else
            {
               this.openBuyStarterPackSub("SinglePlayerPopup");
            }
         }
         else if(this.forceBlackScreen())
         {
            this._useBlackScreen = true;
            this.blackScreenFunction = this.openSinglePlayerSub;
         }
         else
         {
            this.openSinglePlayerSub();
         }
      }
      
      private function openSinglePlayerSub() : void
      {
         this.removeCurrentScreen();
         screensM.addScreen("screenMissionWorldMap");
         screensM.screenMissionWorldMap.refreshScreen();
         dataM.trackScreenView("singlePlayer");
         this.removeMe(true);
      }
      
      private function openMultiplayerLadder() : void
      {
         var _loc1_:Boolean = false;
         if(screensM.isScreenOpened("screenMultiPlayerLadder") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else
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
                     this.blackScreenFunction = this.openBuyStarterPackSub;
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
                  this.blackScreenFunction = this.openMultiplayerLadderSub;
               }
            }
         }
      }
      
      private function openMultiplayerLadderSub() : void
      {
         dataM.chat_initialize();
         this.openScreenFinalFunctions("multiplayerLadder",true);
         screensM.addScreen("screenMultiPlayerLadder");
         screensM.screenMultiPlayerLadder.refreshScreen(this._multiplayerEnterChat);
         dataM.trackScreenView("multiplayerLadder");
         if(this._lastScreen != "multiplayerChat")
         {
            screensM.screenTopBar.showRankStars(true);
         }
      }
      
      private function openMultiplayerChat() : void
      {
         var _loc1_:Boolean = false;
         if(screensM.isScreenOpened("screenMultiPlayerChat") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else
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
                     this.blackScreenFunction = this.openBuyStarterPackSub;
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
                  this.blackScreenFunction = this.openMultiplayerChatSub;
               }
            }
         }
      }
      
      private function openMultiplayerChatSub() : void
      {
         dataM.chat_initialize();
         this.openScreenFinalFunctions("multiplayerChat",true);
         screensM.addScreen("screenMultiPlayerChat");
         screensM.screenMultiPlayerChat.refreshScreen(this._multiplayerEnterChat);
         dataM.trackScreenView("multiplayerChat");
         if(this._lastScreen != "multiplayerLadder")
         {
            screensM.screenTopBar.showRankStars(true);
         }
      }
      
      private function openCommunityClan() : void
      {
         if(screensM.isScreenOpened("screenClan") == false && screensM.isScreenOpened("screenClanFlag") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openCommunityClanSub;
            }
            else
            {
               this.openCommunityClanSub();
            }
         }
      }
      
      private function openCommunityClanSub() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.clanID > 0)
         {
            this.openScreenFinalFunctions("communityClan");
            screensM.addScreen("screenClan");
            screensM.screenClan.refreshScreen();
            dataM.trackScreenView("communityClan");
         }
         else
         {
            this.openCommunitySearchForClan();
         }
      }
      
      private function openCommunityRankingList() : void
      {
         if(screensM.isScreenOpened("screenRankingList") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openCommunityRankingListSub;
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
         screensM.addScreen("screenRankingList");
         screensM.screenRankingList.refreshScreen();
         dataM.trackScreenView("communityRankingList");
      }
      
      private function openCommunitySearchForClan() : void
      {
         this.openScreenFinalFunctions("communitySearchForClan");
         screensM.addScreen("screenSearchForClan");
         screensM.screenSearchForClan.refreshScreen();
         dataM.trackScreenView("communitySearchForClan");
      }
      
      private function openCommunityNews() : void
      {
         if(screensM.isScreenOpened("screenNews") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openCommunityNewsSub;
            }
            else
            {
               this.openCommunityNewsSub();
            }
         }
      }
      
      private function openCommunityNewsSub() : void
      {
         this.openScreenFinalFunctions("profileNews");
         screensM.addScreen("screenNews");
         screensM.screenNews.refreshScreen();
         dataM.trackScreenView("communityNews");
      }
      
      private function openHangerMech() : void
      {
         if(screensM.isScreenOpened("screenHangerMech") == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openHangerMechSub;
            }
            else
            {
               this.openHangerMechSub();
            }
         }
      }
      
      private function openHangerMechSub() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc2_.winsVSComputer >= 1)
         {
            _loc1_ = true;
         }
         this.openScreenFinalFunctions("hangerMech",_loc1_);
         screensM.addScreen("screenHangerBackground");
         screensM.addScreen("screenHangerMenu");
         screensM.screenHangerMenu.refreshScreen("mech");
         this._updateMechRequired = true;
         dataM.trackScreenView("hangerMech");
      }
      
      public function mechUpdated() : void
      {
         this._updateMechRequired = false;
         this.buttonClickedSub(this._lastButtonName);
      }
      
      private function openHangerFusion() : void
      {
         if(screensM.isScreenOpened("screenHangerFusion") == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openHangerFusionSub;
            }
            else
            {
               this.openHangerFusionSub();
            }
         }
      }
      
      private function openHangerFusionSub() : void
      {
         this.openScreenFinalFunctions("hangerFusion",true);
         screensM.addScreen("screenHangerBackground");
         screensM.addScreen("screenHangerMenu");
         screensM.screenHangerMenu.refreshScreen("fusion");
         dataM.trackScreenView("hangerFusion");
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
            BMShopManager.gi().showCategoriesScreen("MainMenu");
         }
      }
      
      private function openShopMythical() : void
      {
         var _loc1_:Boolean = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
         }
         else
         {
            _loc1_ = false;
            if(screensM.isScreenOpened("screenHangerShop"))
            {
               if(screensM.screenHangerShop.getShopType() == "mythical")
               {
                  _loc1_ = true;
               }
            }
            if(_loc1_ == false)
            {
               if(this.forceBlackScreen())
               {
                  this._useBlackScreen = true;
                  this.blackScreenFunction = this.openShopMythicalSub;
               }
               else
               {
                  this.openShopMythicalSub();
               }
            }
         }
      }
      
      private function openShopMythicalSub() : void
      {
         this.openScreenFinalFunctions("shopMythical",true);
         screensM.addScreen("screenHangerBackground");
         screensM.addScreen("screenHangerMenu");
         screensM.screenHangerMenu.refreshScreen("shopMythical");
         dataM.trackScreenView("shopMythical");
      }
      
      public function extraOptions() : void
      {
         screensM.addScreen("screenExtraOptions");
      }
      
      private function openProfileGifts() : void
      {
         if(screensM.isScreenOpened("screenHangerInsertGiftKey") == false && screensM.isScreenOpened("screenHangerGiftKeys") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openProfileGiftsSub;
            }
            else
            {
               this.openProfileGiftsSub();
            }
         }
      }
      
      private function openProfileGiftsSub() : void
      {
         this.openScreenFinalFunctions("profileGifts",true);
         screensM.addScreen("screenHangerBackground");
         screensM.addScreen("screenHangerMenu");
         screensM.screenHangerMenu.refreshScreen("gifts");
         dataM.trackScreenView("profileGifts");
      }
      
      private function openCommunityForum() : void
      {
         dataM.openURL("http://www.supermechs.com/forum/viewforum.php?f=402","_blank");
         dataM.trackScreenView("communityForum");
      }
      
      private function openCommunityYouTube() : void
      {
         dataM.openURL("https://www.youtube.com/channel/UCpB4nxzR8cEUQSGFG_lLIKA","_blank");
         dataM.trackScreenView("communityYouTube");
      }
      
      private function openProfileReplays() : void
      {
         if(screensM.isScreenOpened("screenReplays") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openProfileReplaysSub;
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
         screensM.addScreen("screenReplays");
         screensM.screenReplays.refreshScreen();
         dataM.trackScreenView("profileReplays");
      }
      
      private function openProfileAchievements() : void
      {
         if(screensM.isScreenOpened("screenAchievements") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openProfileAchievementsSub;
            }
            else
            {
               this.openProfileAchievementsSub();
            }
         }
      }
      
      private function openProfileAchievementsSub() : void
      {
         this.openScreenFinalFunctions("profileAchievements");
         screensM.addScreen("screenAchievements");
         screensM.screenAchievements.refreshScreen(this._loadAchievements);
         this._loadAchievements = false;
         dataM.trackScreenView("profileAchievements");
      }
      
      public function setLoadAchievementsToFalse() : void
      {
         this._loadAchievements = false;
      }
      
      private function openProfileHelp() : void
      {
         if(screensM.isScreenOpened("screenHelp") == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openProfileHelpSub;
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
         screensM.addScreen("screenHelp");
         screensM.screenHelp.refreshScreen();
         dataM.trackScreenView("profileHelp");
      }
      
      private function openProfileInfo() : void
      {
         if(screensM.isScreenOpened("screenProfileInfo") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openProfileInfoSub;
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
         screensM.addScreen("screenProfileInfo");
         screensM.screenProfileInfo.refreshScreen();
         dataM.trackScreenView("profileInfo");
      }
      
      private function openProfileOptions() : void
      {
         if(screensM.isScreenOpened("screenProfileOptions") == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openProfileOptionsSub;
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
         screensM.addScreen("screenProfileOptions");
         screensM.screenProfileOptions.refreshScreen();
         dataM.trackScreenView("profileOptions");
      }
      
      private function openProfileAccounts() : void
      {
         if(screensM.isScreenOpened("screenProfileAccounts") == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
            }
            else if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openProfileAccountsSub;
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
         screensM.addScreen("screenProfileAccounts");
         screensM.screenProfileAccounts.refreshScreen();
         dataM.trackScreenView("profileAccounts");
      }
      
      public function openProfileLogout() : void
      {
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_ONLINE:
               screensM.screenConfirmation.displayQuestionOrNotification("logout",-1,-1);
               break;
            case BMDataManager.GAME_TYPE_GUEST:
               this.removeCurrentScreen();
               this.removeMe();
               screensM.addScreen("screenWelcomeBackground");
               screensM.addScreen("screenWelcomeNewExisting");
               screensM.screenWelcomeBackground.refreshScreen(true);
               screensM.screenWelcomeNewExisting.refreshScreen();
         }
      }
      
      public function openBuyStarterPack(param1:String) : void
      {
         if(screensM.isScreenOpened("screenBuyStarterPack") == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = this.openBuyStarterPackSub;
               screensM.screenBlack.activateBlackScreen(this.blackScreenFunction,true,true,[param1],0);
            }
            else
            {
               this.openBuyStarterPackSub(param1);
            }
         }
      }
      
      private function openBuyStarterPackSub(param1:String) : void
      {
         this.openScreenFinalFunctions("buyStarterPack",true);
         screensM.addIfNotOpened("screenBuyStarterPack");
         screensM.screenBuyStarterPack.refreshScreen(param1);
         this.removeMe(false);
      }
      
      private function openScreenFinalFunctions(param1:String, param2:Boolean = false) : void
      {
         if(this._currentScreen != "")
         {
            this._lastScreen = this._currentScreen;
         }
         else
         {
            this._lastScreen = param1;
         }
         this._currentScreen = param1;
         if(this._lastScreen != this._currentScreen)
         {
            this.removeLastScreen();
         }
         if(param2)
         {
            this.addTopBar();
         }
         else
         {
            this.removeTopBar();
         }
      }
      
      private function removeTopBar() : void
      {
         if(screensM.isScreenOpened("screenTopBar"))
         {
            screensM.removeScreen("screenTopBar");
         }
      }
      
      private function addTopBar() : void
      {
         if(screensM.isScreenOpened("screenTopBar") == false)
         {
            screensM.addScreen("screenTopBar");
            screensM.screenTopBar.refreshScreen(this.refreshTopBarAfterBattle);
            this.refreshTopBarAfterBattle = false;
         }
      }
      
      public function mainMenu(param1:Boolean = false) : void
      {
         if(!param1)
         {
            screensM.screenBlack.activateBlackScreen(this.mainScreenSub,true,true,null,0);
         }
         else
         {
            this.mainScreenSub();
         }
      }
      
      public function mainScreenSub() : void
      {
         this.openScreenFinalFunctions("mainMenu");
         screensM.addScreen("screenMainMenu");
         screensM.screenMainMenu.refreshScreen();
      }
      
      public function singlePlayerClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("singlePlayer");
      }
      
      public function multiplayerLadderClicked(param1:Boolean = false, param2:Boolean = true) : void
      {
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc3_.ageVerification == false)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("ageVerification",-1,-1);
            return;
         }
         if(this._currentScreen == "multiplayerChat")
         {
            param2 = false;
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
         this._skipBlackScreen = param1;
         this._multiplayerEnterChat = param2;
         this.buttonClicked("multiplayerChat");
      }
      
      public function communityClanClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("communityClan");
      }
      
      public function communityRankingListClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("communityRankingList");
      }
      
      public function profileReplaysClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("profileReplays");
      }
      
      public function hangerMechClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         this.buttonClicked("hangerMech");
      }
      
      public function hangerFusionClicked() : void
      {
         this.buttonClicked("hangerFusion");
      }
      
      public function shopCombinedClicked(param1:Boolean = false) : void
      {
         this.openShopCombined();
      }
      
      public function shopMythicalClicked() : void
      {
         this.buttonClicked("shopMythical");
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
      
      public function profileAchievementsClicked() : void
      {
         this.buttonClicked("profileAchievements");
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
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen(true);
      }
      
      public function removeMe(param1:Boolean = true) : void
      {
         if(screensM.isScreenOpened("screenItemCards"))
         {
            screensM.screenItemCards.removeScreenInstantly();
         }
         if(param1)
         {
            this.removeTopBar();
         }
         this._currentScreen = "";
         this._lastScreen = "";
      }
   }
}

