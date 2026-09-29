package net.battleMechsMulti.screens
{
   import com.greensock.*;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.tacticsoft.utils.FunctionCall;
   
   public class BMScreenNewMenu extends BMBaseScreen
   {
      
      private var _lastScreen:String = "";
      
      private var _currentScreen:String = "";
      
      private var _useBlackScreen:Boolean = false;
      
      private var _skipBlackScreen:Boolean = false;
      
      private var _multiplayerEnterChat:Boolean = false;
      
      private var _lastButtonName:String = "";
      
      public var refreshTopBarAfterBattle:Boolean = false;
      
      private var blackScreenFunction:FunctionCall = null;
      
      public var mechOrderToSave:Array;
      
      private var _switchServerTo:String = null;
      
      public var mechItemsDataToSave:Array;
      
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
         this.buttonClickedSub(param1);
      }
      
      private function buttonClickedSub(param1:String) : void
      {
         if(screensM.screenBlack.isActive() == false || this._skipBlackScreen)
         {
            if(this.externalLockActive() == false)
            {
               this._useBlackScreen = false;
               this.blackScreenFunction = null;
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
               }
               this.handleActivateBlackScreen();
               if(screensM.isScreenOpened("screenSelectBattleMechsPerPlayer"))
               {
                  screensM.screenSelectBattleMechsPerPlayer.closeScreen();
               }
            }
         }
      }
      
      private function handleActivateBlackScreen() : *
      {
         if(this.hasTasks)
         {
            screensM.screenBlack.activateBlackScreen(this.blackScreenFunction.func,true,true,this.blackScreenFunction.params,0,true);
            this.doNextTask();
         }
         else if(this._useBlackScreen)
         {
            if(this._skipBlackScreen)
            {
               this.blackScreenFunction.call();
            }
            else
            {
               screensM.screenBlack.activateBlackScreen(this.blackScreenFunction.func,true,true,this.blackScreenFunction.params,0);
            }
         }
      }
      
      private function get hasTasks() : Boolean
      {
         return (this.mechOrderToSave != null || this._switchServerTo != null || this.mechItemsDataToSave != null) && !this._skipBlackScreen;
      }
      
      private function doNextTask() : void
      {
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
         }
         else
         {
            screensM.screenBlack.unBlockOpeningScreen();
         }
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
            case "mainMenu":
               screensM.removeScreen("screenMainMenu");
               break;
            case "screenWorkshop":
               screensM.removeScreen("screenWorkshop");
               break;
            case "screenHangerUpgrade":
               screensM.removeScreen("screenHangerUpgrade");
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
                     if(screensM.isScreenOpened("screenHangerMenu"))
                     {
                        screensM.screenHangerMenu.removeHanger();
                     }
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
         this._lastScreen = "";
      }
      
      public function removeCurrentScreen() : void
      {
         switch(this._currentScreen)
         {
            case "mainMenu":
               screensM.removeScreen("screenMainMenu");
               break;
            case "screenWorkshop":
               screensM.removeScreen("screenWorkshop");
               break;
            case "screenHangerUpgrade":
               screensM.removeScreen("screenHangerUpgrade");
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
               this.blackScreenFunction = new FunctionCall(this.openBuyStarterPackSub,["SinglePlayerPopup"]);
            }
            else
            {
               this.openBuyStarterPackSub("SinglePlayerPopup");
            }
         }
         else if(this.forceBlackScreen())
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
               this.blackScreenFunction = new FunctionCall(this.openHangerMechSub);
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
         dataM.trackScreenView("hangerMech");
      }
      
      private function openHangerFusion() : void
      {
         if(screensM.isScreenOpened("screenHangerFusion") == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openHangerFusionSub);
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
               this.blackScreenFunction = new FunctionCall(this.openShopMythicalSub);
            }
            else
            {
               this.openShopMythicalSub();
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
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openProfileGiftsSub);
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
         screensM.addScreen("screenReplays");
         screensM.screenReplays.refreshScreen();
         dataM.trackScreenView("profileReplays");
      }
      
      private function openProfileHelp() : void
      {
         if(screensM.isScreenOpened("screenHelp") == false)
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
         screensM.addScreen("screenHelp");
         screensM.screenHelp.refreshScreen();
         dataM.trackScreenView("profileHelp");
      }
      
      private function openProfileInfo() : void
      {
         if(screensM.isScreenOpened("screenProfileInfo") == false)
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
         screensM.addScreen("screenProfileOptions");
         screensM.screenProfileOptions.refreshScreen();
         dataM.trackScreenView("profileOptions");
      }
      
      private function openProfileAccounts() : void
      {
         if(screensM.isScreenOpened("screenProfileAccounts") == false)
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
         screensM.addScreen("screenProfileAccounts");
         screensM.screenProfileAccounts.refreshScreen();
         dataM.trackScreenView("profileAccounts");
      }
      
      public function openProfileLogout() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("logout",-1,-1);
      }
      
      public function openBuyStarterPack(param1:String) : void
      {
         if(screensM.isScreenOpened("screenBuyStarterPack") == false)
         {
            if(this.forceBlackScreen())
            {
               this._useBlackScreen = true;
               this.blackScreenFunction = new FunctionCall(this.openBuyStarterPackSub,[param1]);
               screensM.screenBlack.activateBlackScreen(this.blackScreenFunction.func,true,true,this.blackScreenFunction.params,0);
            }
            else
            {
               this.openBuyStarterPackSub(param1);
            }
         }
      }
      
      public function openBuyStarterPackSub(param1:String) : void
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
         this._useBlackScreen = true;
         this._skipBlackScreen = param1;
         this.blackScreenFunction = new FunctionCall(this.mainScreenSub);
         this.handleActivateBlackScreen();
      }
      
      public function mainScreenSub() : void
      {
         this.openScreenFinalFunctions("mainMenu");
         screensM.addScreen("screenMainMenu");
         screensM.screenMainMenu.refreshScreen();
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
         this.openScreenFinalFunctions("screenHangerUpgrade");
         screensM.addScreen("screenHangerUpgrade");
      }
      
      public function singlePlayerClicked(param1:Boolean = false) : void
      {
         this._skipBlackScreen = param1;
         if(BMLoginManager.gi().isNeedToSwitchServerTo(false))
         {
            this._switchServerTo = "singlePlayer";
         }
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
         this._useBlackScreen = true;
         this._skipBlackScreen = param1;
         this.blackScreenFunction = new FunctionCall(this.openWorkshopSub);
         this.handleActivateBlackScreen();
      }
      
      public function openWorkshopSub() : void
      {
         this.openScreenFinalFunctions("screenWorkshop",false);
         screensM.addScreen("screenWorkshop");
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
      }
   }
}

