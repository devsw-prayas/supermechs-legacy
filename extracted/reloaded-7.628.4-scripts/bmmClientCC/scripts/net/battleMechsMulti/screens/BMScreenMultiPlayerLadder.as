package net.battleMechsMulti.screens
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.helpers.BMMultiplayerCallToActionHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLevelUpManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.nukes.BMNukesResolver;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMMultiplayerLadderChatAlert;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemComparison.BMMechBoostRecommender;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.mobiles.unlockedMechSlotsResolver.BMUnlockedMechSlotsResolver;
   import net.battleMechsMulti.screens.kinShop.BMKinBetPanel;
   import net.battleMechsMulti.screens.kinShop.BMKinClaimPanel;
   import net.battleMechsMulti.screens.multiplayerLadder.BMPVPWinningRewardPredicationDisplay;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   import net.battleMechsMulti.screens.topBar.BMLadderRankDisplay;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.TimeUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2381")]
   public class BMScreenMultiPlayerLadder extends BMBaseScreen
   {
      
      public var mcChatAlertsHolder:Sprite;
      
      public var txtPlayersInLobby:TextField;
      
      public var txtWinningWall:TextField;
      
      public var txtSeasonTitle:TextField;
      
      public var txtSeasonTimeLeft:TextField;
      
      public var mcLadderRankDisplay:BMLadderRankDisplay;
      
      public var mcSizer_SMTV:Sprite;
      
      public var mcSizer_chatAlert1:Sprite;
      
      public var mcSizer_chatAlertsHitArea:Sprite;
      
      public var mcChatAlert0Position:Sprite;
      
      public var mcChatAlert1Position:Sprite;
      
      public var mcChatAlert2Position:Sprite;
      
      public var mcChatAlert3Position:Sprite;
      
      public var mcChatAlert4Position:Sprite;
      
      public var mcSpecialOffersLocation:Sprite;
      
      public var mcArenaShopReminder:Sprite;
      
      public var btnSearchForBattle:BMBasicButton;
      
      public var btnSearchForBattle_withMechsPerBattle:BMBasicButton;
      
      public var btnChatRoom:BMBasicButton;
      
      public var btnLeague:BMBasicButton;
      
      public var btnClan:BMBasicButton;
      
      public var btnShop:BMBasicButton;
      
      public var btnReplays:BMBasicButton;
      
      public var btnBack:BMBasicButton;
      
      public var btnChangeMechsOrder:BMBasicButton;
      
      public var btnMechBuilds:BMBasicButton;
      
      public var btn1V1:BMBasicSelectable;
      
      public var btn2V2:BMBasicSelectable;
      
      public var btn3V3:BMBasicSelectable;
      
      public var btnKinShop:BMBasicButton;
      
      public var mcRay1:Sprite;
      
      public var mcRay2:Sprite;
      
      public var mcRay3:Sprite;
      
      public var mcTopRanksInfoButton:MovieClip;
      
      public var winningRewardPredicationDisplay:BMPVPWinningRewardPredicationDisplay;
      
      public var mcChatAlertBorderBottom:Sprite;
      
      public var mcChatAlertBorderTop:Sprite;
      
      public var mcTutorialArrow:Sprite;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      public var mcKinBetPanel:BMKinBetPanel;
      
      public var mcKinClaimPanel:BMKinClaimPanel;
      
      private var _firstRefresh:Boolean = true;
      
      private var _searchingForBattleInProgress:Boolean = false;
      
      private var _btnChatRoomOriginXPos:Number;
      
      private var _btnClanOriginXPos:Number;
      
      private var _btnShopOriginXPos:Number;
      
      private var _btnLeageOriginXPos:Number;
      
      private var _btnReplaysOriginXPos:Number;
      
      private var _tournamentTimer:Timer;
      
      private var _ladderSeasonEndRewards:Array = new Array();
      
      private var _ladderSeasonEndGachaMachineIDs:Array = new Array();
      
      public var chatAlerts:Array = new Array();
      
      private const CHAT_ALERT_MAX:uint = 4;
      
      private const CHAT_ALERT_X_JUMP:uint = 8;
      
      private const WINNING_WALL_MAX_MESSAGES:Number = 5;
      
      private const SUN_RAYS_ALPHA_MIN:Number = 0.1;
      
      private const SUN_RAYS_ALPHA_MAX:Number = 0.5;
      
      private var _reEnterMultiplayerLobbyAndChat:Boolean = false;
      
      public function BMScreenMultiPlayerLadder()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         sub(BMPubSub.MESSAGE_KIN_READY_FOR_DISPLAY,this.onKinReadyForDisplay);
      }
      
      public function refreshScreen(param1:Boolean = true) : void
      {
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("multiplayerLadder");
            dataM.setGameTypeAndPlayersToDefault();
            this.btnSearchForBattle.addEventListener(BMIntractable.HIT,this.searchForBattleClicked);
            this.btnSearchForBattle_withMechsPerBattle.addEventListener(BMIntractable.HIT,this.searchForBattleClicked);
            this.btnChatRoom.addEventListener(BMIntractable.HIT,this.chatRoomClicked);
            this.btnLeague.addEventListener(BMIntractable.HIT,this.leagueClicked);
            this.btnReplays.addEventListener(BMIntractable.HIT,this.replaysClicked);
            this.btnClan.addEventListener(BMIntractable.HIT,this.clanClicked);
            this.btnShop.addEventListener(BMIntractable.HIT,this.shopClicked);
            this.btnChangeMechsOrder.addEventListener(BMIntractable.HIT,this.changeMechsOrderClicked);
            this.btnMechBuilds.addEventListener(BMIntractable.HIT,this.mechBuildsClicked);
            this.btnBack.addEventListener(BMIntractable.HIT,this.backClicked);
            this.btn1V1.addEventListener(BMIntractable.HIT,this.btn1v1Clicked);
            this.btn2V2.addEventListener(BMIntractable.HIT,this.btn2v2Clicked);
            this.btn3V3.addEventListener(BMIntractable.HIT,this.btn3v3Clicked);
            this.btnKinShop.addEventListener(BMIntractable.HIT,this.kinShopClicked);
            this.btnClan.text = getScreenText("clan");
            this.btnShop.text = getSpecificText("mainMenu_shop");
            this.btnChatRoom.text = getScreenText("chat");
            this.btnReplays.text = getScreenText("replays");
            this.btnLeague.text = getScreenText("league");
            this.btnSearchForBattle.text = getScreenText("fight");
            this.btnSearchForBattle_withMechsPerBattle.text = getScreenText("fight");
            this.languageUpdate();
            this.createWinningWallMobileBitmap();
            if(dataM.playerSkillsManager.arePlayerSkillsEnabled)
            {
               this.btnClan.visible = false;
            }
            else
            {
               this.btnShop.visible = false;
            }
            this.winningRewardPredicationDisplay.initialize(this.reloadDataForWinningRewardPredication);
            if(dataM.pvpWinningRewardPredictionData.isEnabled())
            {
               this.btnSearchForBattle.y += 21;
               this.btnSearchForBattle_withMechsPerBattle.y += 21;
               this.mcTopRanksInfoButton.y += 21;
               this.btn1V1.y += 18;
               this.btn2V2.y += 18;
               this.btn3V3.y += 18;
               this.btnChangeMechsOrder.y += 21;
               this.btnMechBuilds.y += 21;
            }
            this._btnChatRoomOriginXPos = this.btnChatRoom.x;
            this._btnClanOriginXPos = this.btnClan.x;
            this._btnShopOriginXPos = this.btnShop.x;
            this._btnLeageOriginXPos = this.btnLeague.x;
            this._btnReplaysOriginXPos = this.btnReplays.x;
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow);
            sub(BMPubSub.MESSAGE_WEEKLY_RESET_OCCURED,this.handleWeeklyResetOccured);
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.mcLadderRankDisplay.addRank();
         if(param1 && remoteM.socketM.isSocketConnected())
         {
            dataM.chatData.enterChat();
         }
         this.refreshSpecialOffers();
         this._searchingForBattleInProgress = false;
         this.mcChatAlertBorderBottom.visible = false;
         this.mcChatAlertBorderTop.visible = false;
         this.refreshChatRoomFrame();
         this.refreshSearchForBattleButton();
         this.refreshMechsPerBattleButtons();
         this.refreshArenaShopReminder();
         if(dataM.areMechsReadyForBattle())
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_VS) == false)
            {
               screensM.addScreen(BMScreensManager.SCR_VS);
            }
         }
         this.initSunRaysAnim();
         this.initTournamentCountdown();
         if(dataM.myProfile.hasPandingLevelUp)
         {
            BMLevelUpManager.gi().displayLevelUpPopUp();
         }
         else if(dataM.contentPackResolver.didUnlockNewContentPackID())
         {
            screensM.screenTransitionsManager.contentPackLibraryClicked();
         }
         else
         {
            BMNukesResolver.gi().displayNukesMaxedPopup();
         }
         if(remoteM.socketM.isSocketConnected())
         {
            remoteM.enterMultiplayerLobby();
         }
         else
         {
            this._reEnterMultiplayerLobbyAndChat = true;
         }
         this.refreshKin();
         this.disableAllButtons();
         this.showBoostRecommendation();
         this.refreshMultiplayerCallToActionTutorialArrow();
         dataM.gameOfWhalesM.updateUserProfile();
         dataM.gameOfWhalesM.getOffers();
      }
      
      private function refreshMultiplayerCallToActionTutorialArrow() : void
      {
         var _loc1_:MovieClip = null;
         if(BMMultiplayerCallToActionHelper.shouldDirectPlayerToMultiplayer())
         {
            _loc1_ = this.btnSearchForBattle_withMechsPerBattle;
            this._tutorialArrowController.activateTutorialArrowWithTimer(this,_loc1_.x + _loc1_.width / 3,_loc1_.y + _loc1_.height * 0.4,180,10);
         }
         else
         {
            this._tutorialArrowController.deactivateTutorialArrow();
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         this.txtWinningWall.text = "";
         this.refreshPlayersInLobbyText();
      }
      
      public function refreshPlayersInLobbyText() : void
      {
         var _loc1_:String = getScreenText("playersInLobby");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%PLAYERS%",String(dataM.chatData.totalPlayersInLobby));
         updateTextAndFormat(this.txtPlayersInLobby,_loc1_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("menuMultiPlayerLadder_txtPlayersInLobby",[this.txtPlayersInLobby],"",this);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.chatAlertsHandler();
            this.mcLadderRankDisplay.onEnterFrameTrigger();
         }
      }
      
      private function btn1v1Clicked(param1:Event) : void
      {
         this.updateMechsPerBattle(1);
      }
      
      private function btn2v2Clicked(param1:Event) : void
      {
         this.updateMechsPerBattle(2);
      }
      
      private function btn3v3Clicked(param1:Event) : void
      {
         this.updateMechsPerBattle(3);
      }
      
      private function updateMechsPerBattle(param1:uint) : void
      {
         dataM.myProfile.lastSelectedMechsPerBattle = param1;
         this.refreshMechsPerBattleButtons();
      }
      
      private function refreshSearchForBattleButton() : void
      {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc1_:uint = dataM.getLadderRankByProgress(dataM.myProfile.ladderProgress);
         var _loc2_:Boolean = false;
         if(_loc1_ <= dataM.getTopRankBattlesMinimumRank())
         {
            _loc2_ = true;
         }
         this.mcTopRanksInfoButton.visible = false;
         if(this.isForceSpecificMechsPerPlayerModeEnabled())
         {
            this.btnSearchForBattle.visible = false;
            _loc3_ = "";
            if(this.getNumberOfMechsPerPlayerInRank() == 3)
            {
               _loc3_ = "3 VS 3";
            }
            else if(this.getNumberOfMechsPerPlayerInRank() == 2)
            {
               _loc3_ = "2 VS 2";
            }
            else
            {
               _loc3_ = "1 VS 1";
            }
            if(_loc2_)
            {
               _loc3_ = "Top ranks:<BR>" + _loc3_;
               this.btnSearchForBattle_withMechsPerBattle["mcBattleTypeBackground"].gotoAndStop("topRanks");
               updateTextAndFormat(this.btnSearchForBattle_withMechsPerBattle["txtTopRanksSubTitle"],_loc3_);
               this.btnSearchForBattle_withMechsPerBattle.subText = "";
               this.mcTopRanksInfoButton.visible = true;
               this.mcTopRanksInfoButton.addEventListener(MouseEvent.CLICK,this.onTopRanksInfoClicked);
            }
            else
            {
               this.btnSearchForBattle_withMechsPerBattle.subText = _loc3_;
               this.btnSearchForBattle_withMechsPerBattle["txtTopRanksSubTitle"].text = "";
            }
            _loc4_ = 13;
            this.btnSearchForBattle_withMechsPerBattle.y += _loc4_;
            this.btnChangeMechsOrder.y += _loc4_;
            this.btnMechBuilds.y += _loc4_;
            this.winningRewardPredicationDisplay.y += _loc4_;
         }
         else
         {
            this.btnSearchForBattle_withMechsPerBattle.visible = false;
         }
      }
      
      private function onTopRanksInfoClicked(param1:MouseEvent) : void
      {
         var _loc2_:String = "Competitive Seasons";
         var _loc3_:String = "Congratulations, Pilot!<BR>You have made it to the Top Ranks of the Super Mechs Arena! Every week, the top ranks play a different gameplay style (1v1, 2v2 or 3v3) to determine who is the best pilot in the Super Mechs Universe!<BR>Good luck and may the best Pilot win!";
         var _loc4_:String = getGeneralText("OK");
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup9_topRanks);
         screensM.screenYesNoPopup.displayYesNoPopup(_loc2_,_loc3_,"",null,null,_loc4_);
      }
      
      private function refreshMechsPerBattleButtons() : void
      {
         this.btn1V1.enableMe();
         this.btn2V2.disableMe();
         this.btn3V3.disableMe();
         this.btnChangeMechsOrder.visible = false;
         this.btnMechBuilds.visible = false;
         if(dataM.mechBuildsM.isEnabled)
         {
            this.btnMechBuilds.visible = true;
         }
         var _loc1_:uint = BMUnlockedMechSlotsResolver.getNumberOfMechsUnlocked();
         if(_loc1_ >= 2)
         {
            if(dataM.mechBuildsM.isEnabled == false)
            {
               this.btnChangeMechsOrder.visible = true;
            }
            this.btn2V2.enableMe();
            if(_loc1_ >= 3)
            {
               this.btn3V3.enableMe();
            }
            else
            {
               this.btn3V3.lock();
            }
         }
         else
         {
            this.btn2V2.lock();
            this.btn3V3.lock();
         }
         this.btn1V1.selected = false;
         this.btn2V2.selected = false;
         this.btn3V3.selected = false;
         switch(dataM.myProfile.lastSelectedMechsPerBattle)
         {
            case 1:
               this.btn1V1.selected = true;
               break;
            case 2:
               this.btn2V2.selected = true;
               break;
            case 3:
               this.btn3V3.selected = true;
         }
         if(this.isForceSpecificMechsPerPlayerModeEnabled() == false)
         {
            return;
         }
         this.btn1V1.visible = false;
         this.btn2V2.visible = false;
         this.btn3V3.visible = false;
      }
      
      private function isForceSpecificMechsPerPlayerModeEnabled() : Boolean
      {
         if(dataM.get1v1to2v2TransitionRank() == 0)
         {
            return false;
         }
         return true;
      }
      
      public function searchForBattleClicked(param1:Event) : void
      {
         if(this.show1v1to2v2TransitionWarning())
         {
            screensM.addScreen(BMScreensManager.SCR_1V1_TO_2V2_TRANSITION_WARNING);
            return;
         }
         var _loc2_:uint = 1;
         if(this.getSelectedMechsPerBattle(true) > 1)
         {
            _loc2_ = 3;
         }
         var _loc3_:String = dataM.myPlayerData.isBlockedFromPlayingInCompetitveBattles(_loc2_);
         if(_loc3_ != null)
         {
            screensM.screenConfirmation.displayQuestionOrNotification(_loc3_);
            return;
         }
         this.startSearchingForBattle();
      }
      
      private function getSelectedMechsPerBattle(param1:Boolean = false) : uint
      {
         var _loc2_:uint = 0;
         if(this.isForceSpecificMechsPerPlayerModeEnabled())
         {
            _loc2_ = dataM.getLadderRankByProgress(dataM.myProfile.ladderProgress);
            if(_loc2_ <= dataM.getTopRankBattlesMinimumRank())
            {
               return dataM.getTopRankBattlesMechsPerPlayer();
            }
            if(_loc2_ > dataM.get1v1to2v2TransitionRank())
            {
               return 1;
            }
            if(param1)
            {
               return 2;
            }
            if(dataM.isMechReadyForBattle(2,dataM.player1PlayerID))
            {
               return 2;
            }
            return 1;
         }
         return dataM.myProfile.lastSelectedMechsPerBattle;
      }
      
      private function getNumberOfMechsPerPlayerInRank() : int
      {
         var _loc1_:uint = 0;
         if(this.isForceSpecificMechsPerPlayerModeEnabled())
         {
            _loc1_ = dataM.getLadderRankByProgress(dataM.myProfile.ladderProgress);
            if(_loc1_ <= dataM.getTopRankBattlesMinimumRank())
            {
               return dataM.getTopRankBattlesMechsPerPlayer();
            }
            if(_loc1_ > dataM.get1v1to2v2TransitionRank())
            {
               return 1;
            }
            return 2;
         }
         return -1;
      }
      
      private function startSearchingForBattle() : void
      {
         this.btnSearchForBattle.disableMe();
         this.btnSearchForBattle_withMechsPerBattle.disableMe();
         this.battleMechsPerPlayerSelected(this.getSelectedMechsPerBattle());
         tooltip.hideToolTip();
      }
      
      public function battleMechsPerPlayerSelected(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc7_:uint = 0;
         if(dataM.areMechsReadyForBattle(param1) == false)
         {
            _loc7_ = 0;
            _loc2_ = 1;
            while(_loc2_ <= param1)
            {
               if(dataM.isMechReadyForBattle(_loc2_,dataM.player1PlayerID) == false)
               {
                  _loc7_ = _loc2_;
                  break;
               }
               _loc2_++;
            }
            if(_loc7_ > 0)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",_loc7_);
            }
            return;
         }
         var _loc3_:uint = param1;
         if(_loc3_ == 2)
         {
            _loc3_ = 3;
         }
         var _loc4_:Array = new Array();
         _loc2_ = 1;
         while(_loc2_ <= _loc3_)
         {
            _loc4_.push(_loc2_);
            _loc2_++;
         }
         var _loc5_:uint = dataM.mechIsOverWeight(_loc4_);
         if(_loc5_ > 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",_loc5_);
            return;
         }
         var _loc6_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc6_.updateLevelByItems();
         dataM.battleMechsPerPlayer = param1;
         this.disableAllButtons();
         this._searchingForBattleInProgress = true;
         if(screensM.isScreenOpened(BMScreensManager.SCR_SPECIAL_OFFERS))
         {
            screensM.screenSpecialOffers.disableMe();
         }
         if(dataM.areMechsReadyForBattle())
         {
            dataM.battle_isCurrentBattlePvPWithPickMechs = false;
            dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_PVP,BMDataManager.GAME_SUB_TYPE_PVP_DEFAULT,"multiplayerLadder_battleMechsPerPlayerSelected");
            screensM.screenVS.activateScreen(this.vsScreenClosed);
            screensM.screenVS.addSearchForBattleFunction(remoteM.lobby_searchForBattle,dataM.battleMechsPerPlayer);
         }
      }
      
      public function searchingForBattleInProgress() : Boolean
      {
         return this._searchingForBattleInProgress;
      }
      
      private function vsScreenClosed() : void
      {
         dataM.setGameTypeAndPlayersToDefault();
         this.enableAllButtons();
      }
      
      public function findBattleSuccess() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_VS))
         {
            this.findBattleSuccessSub();
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.findBattleSuccessSub,true,true,null,0);
         }
      }
      
      private function findBattleSuccessSub() : void
      {
         screensM.addBattleScreens();
         screensM.screenTransitionsManager.removeCurrentScreen();
         screensM.screenTransitionsManager.removeMe();
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
      }
      
      private function show1v1to2v2TransitionWarning() : Boolean
      {
         if(this.isForceSpecificMechsPerPlayerModeEnabled() == false)
         {
            return false;
         }
         var _loc1_:uint = dataM.getLadderRankByProgress(dataM.myProfile.ladderProgress);
         if(_loc1_ <= dataM.getTopRankBattlesMinimumRank())
         {
            if(dataM.getTopRankBattlesMechsPerPlayer() == 1)
            {
               return false;
            }
         }
         if(_loc1_ <= dataM.get1v1to2v2TransitionRank())
         {
            if(this.getSelectedMechsPerBattle() == 1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function transitionWarningGoToHanger() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_1V1_TO_2V2_TRANSITION_WARNING);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_WORKSHOP);
         screensM.screensDirector.addUserActionTask(BMScreensDirectorTask.USER_ACTION_WORKSHOP_SWITCH_TO_MECH_X,{"mechID":2});
      }
      
      public function transitionWarningPlay1V1() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_1V1_TO_2V2_TRANSITION_WARNING);
         this.startSearchingForBattle();
      }
      
      public function searchForBattleSuccess() : void
      {
      }
      
      public function cancelSearchForBattleSuccess(param1:Boolean = false) : void
      {
         this.enableAllButtons();
         this.btnSearchForBattle.enableMe();
         this.btnSearchForBattle_withMechsPerBattle.enableMe();
         if(param1 && screensM.isScreenOpened(BMScreensManager.SCR_VS))
         {
            screensM.screenVS.removeMe();
         }
         this._searchingForBattleInProgress = false;
      }
      
      public function refreshSpecialOffers() : void
      {
         dataM.starterPack_goBackToScreen = "multiplayerLadder";
         BMSpecialOffersManager.gi().showBigBanner(this.mcSpecialOffersLocation,0.818);
         if(BMSpecialOffersManager.gi().hasSpecialOffers() == false)
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_SMTV) == false)
            {
               screensM.addScreen(BMScreensManager.SCR_SMTV,false);
               screensM.screenSMTV.addMe("multiplayerLadder");
               screensM.screenSMTV.refreshWatchReplay();
            }
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_SMTV))
         {
            screensM.screenSMTV.removeMe();
         }
      }
      
      private function disableAllButtons() : void
      {
         this.btnClan.disableMe();
         this.btnShop.disableMe();
         this.btnLeague.disableMe();
         this.btnReplays.disableMe();
         this.btnBack.disableMe();
         this.btnSearchForBattle.disableMe();
         this.btnSearchForBattle_withMechsPerBattle.disableMe();
         this.btnChangeMechsOrder.disableMe();
         this.btnMechBuilds.disableMe();
         this.btnChatRoom.disableMe();
         this.btn1V1.disableMe();
         this.btn2V2.disableMe();
         this.btn3V3.disableMe();
         this.btnKinShop.disableMe();
         this.mcKinBetPanel.disableMe();
      }
      
      private function enableAllButtons() : void
      {
         this.btnClan.enableMe();
         this.btnShop.enableMe();
         this.btnLeague.enableMe();
         this.btnReplays.enableMe();
         this.btnBack.enableMe();
         this.btnSearchForBattle.enableMe();
         this.btnSearchForBattle_withMechsPerBattle.enableMe();
         this.btnChangeMechsOrder.enableMe();
         this.btnMechBuilds.enableMe();
         this.btnChatRoom.enableMe();
         if(screensM.isScreenOpened(BMScreensManager.SCR_SPECIAL_OFFERS))
         {
            screensM.screenSpecialOffers.enableMe();
         }
         this.refreshMechsPerBattleButtons();
         this.btnKinShop.enableMe();
         this.mcKinBetPanel.enableMe();
      }
      
      private function refreshChatRoomFrame() : void
      {
         var _loc1_:Number = 0;
         if(this.chatAlerts.length > 0)
         {
            _loc1_ = -20;
         }
         this.btnChatRoom.x = this._btnChatRoomOriginXPos + _loc1_;
         this.btnClan.x = this._btnClanOriginXPos + _loc1_;
         this.btnShop.x = this._btnShopOriginXPos + _loc1_;
         this.btnReplays.x = this._btnReplaysOriginXPos + _loc1_;
      }
      
      public function addChatAlert(param1:String, param2:Number, param3:String, param4:Number, param5:String, param6:uint) : void
      {
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:BMMultiplayerLadderChatAlert = null;
         var _loc7_:BMMultiplayerLadderChatAlert = new BMMultiplayerLadderChatAlert();
         var _loc8_:uint = this.chatAlerts.length + 1;
         if(_loc8_ >= this.CHAT_ALERT_MAX)
         {
            _loc8_ = this.CHAT_ALERT_MAX;
         }
         _loc7_.initialize(param1,param2,param3,param4,param5,param6,_loc8_);
         soundM.createSound("messagePop",1);
         _loc7_.x = this["mcChatAlert" + _loc8_ + "Position"].x;
         _loc7_.y = this["mcChatAlert" + _loc8_ + "Position"].y;
         _loc7_.scaleX = 0.2;
         _loc7_.scaleY = 0.2;
         this.mcChatAlertsHolder.addChild(_loc7_);
         this.chatAlerts.push(_loc7_);
         if(this.chatAlerts.length == 1)
         {
            this.refreshChatRoomFrame();
         }
         else if(this.chatAlerts.length > this.CHAT_ALERT_MAX)
         {
            _loc10_ = this.chatAlerts.length - this.CHAT_ALERT_MAX;
            _loc11_ = 0;
            while(_loc11_ < this.chatAlerts.length)
            {
               _loc12_ = this.chatAlerts[_loc11_];
               if(_loc11_ < _loc10_)
               {
                  _loc12_.targetSlot = 0;
                  _loc12_.animationStatus = "disappear";
               }
               else
               {
                  _loc12_.targetSlot = this.CHAT_ALERT_MAX + 1 - (this.chatAlerts.length - _loc11_);
               }
               _loc11_++;
            }
         }
         this.mcChatAlertBorderTop.visible = true;
         this.mcChatAlertBorderBottom.visible = true;
         var _loc9_:uint = 1;
         if(this.chatAlerts.length < this.CHAT_ALERT_MAX)
         {
            _loc9_ = this.chatAlerts.length;
         }
         else
         {
            _loc9_ = this.CHAT_ALERT_MAX;
         }
         this.mcChatAlertBorderBottom.y = this["mcChatAlert" + _loc9_ + "Position"].y;
      }
      
      public function chatAlertClicked(param1:String, param2:Number, param3:Number, param4:uint) : void
      {
         if(screensM.screenMultiPlayerLadder.searchingForBattleInProgress())
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustExitSearchForBattle",-1,-1);
            return;
         }
         if(this.btnChatRoom.isEnabled() == false)
         {
            return;
         }
         switch(param1)
         {
            case "message_regular":
               dataM.chatData.goToSpecificPlayerChatPlayerID = param2;
               break;
            case "message_clan":
               dataM.chatData.goToClanChat = true;
               break;
            case "battleInvitation":
            case "clanInvitation":
               dataM.chatData.goToInspectPlayerID = param2;
         }
         this.openChatRoom();
      }
      
      private function chatAlertsHandler() : void
      {
         var _loc4_:BMMultiplayerLadderChatAlert = null;
         var _loc5_:Number = NaN;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this.chatAlerts.length)
         {
            _loc4_ = this.chatAlerts[_loc2_];
            switch(_loc4_.animationStatus)
            {
               case "appear1":
                  _loc4_.scaleX += 0.2;
                  _loc4_.scaleY += 0.2;
                  if(_loc4_.scaleX >= 1.3)
                  {
                     _loc4_.scaleX = 1;
                     _loc4_.scaleY = 1;
                     _loc4_.animationStatus = "appear2";
                  }
                  break;
               case "appear2":
                  _loc4_.scaleX -= 0.1;
                  _loc4_.scaleY -= 0.1;
                  if(_loc4_.scaleX <= 1)
                  {
                     _loc4_.scaleX = 1;
                     _loc4_.scaleY = 1;
                     _loc4_.animationStatus = "none";
                  }
                  break;
               case "disappear":
                  _loc4_.scaleX -= 0.2;
                  _loc4_.scaleY -= 0.2;
                  if(_loc4_.scaleX < 0.2)
                  {
                     _loc4_.visible = false;
                     _loc4_.animationStatus = "none";
                  }
                  break;
               case "none":
            }
            if(_loc4_.currentSlot != _loc4_.targetSlot)
            {
               _loc5_ = _loc4_.y - this["mcChatAlert" + _loc4_.targetSlot + "Position"].y;
               if(Math.abs(_loc5_) <= 0.5)
               {
                  _loc4_.y = this["mcChatAlert" + _loc4_.targetSlot + "Position"].y;
                  _loc4_.currentSlot = _loc4_.targetSlot;
                  if(_loc4_.currentSlot == 0)
                  {
                     _loc1_++;
                  }
               }
               else
               {
                  _loc4_.y -= _loc5_ * 0.3;
               }
            }
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            this.chatAlerts[0].parent.removeChild(this.chatAlerts[0]);
            this.chatAlerts[0] = null;
            this.chatAlerts.splice(0,1);
            _loc3_++;
         }
      }
      
      private function removeChatAlerts() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.chatAlerts.length)
         {
            this.chatAlerts[_loc1_].parent.removeChild(this.chatAlerts[_loc1_]);
            this.chatAlerts[_loc1_] = null;
            _loc1_++;
         }
         this.chatAlerts = new Array();
      }
      
      public function chatRoomClicked(param1:Event) : void
      {
         this.openChatRoom();
      }
      
      private function openChatRoom() : void
      {
         screensM.screenTransitionsManager.multiplayerChatClicked();
      }
      
      private function leagueClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.communityRankingListClicked();
      }
      
      public function clanClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.communityClanClicked();
      }
      
      public function shopClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.arenaShopClicked();
      }
      
      public function replaysClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.profileReplaysClicked();
      }
      
      public function backClicked(param1:Event) : void
      {
         this.backClickedSub();
      }
      
      public function backClickedSub(param1:Boolean = false) : void
      {
         if(param1)
         {
            screensM.screenTransitionsManager.upgrade();
         }
         else
         {
            screensM.screenTransitionsManager.mainMenu();
         }
      }
      
      public function changeMechsOrderClicked(param1:Event) : void
      {
         screensM.addScreen(BMScreensManager.SCR_CHANGE_MECHS_ORDER);
         screensM.screenChangeMechsOrder.refreshScreen();
      }
      
      public function mechBuildsClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.mechBuildsClicked(this.getSelectedMechsPerBattle(true));
         screensM.screenTransitionsManager.cameFromMultiplayerLadder = true;
      }
      
      public function mechsOrderChanged() : void
      {
         if(dataM.myProfile.improveYourMechStarterPackOffer == null)
         {
            return;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_SPECIAL_OFFERS))
         {
            screensM.screenSpecialOffers.removeMe();
         }
         this.refreshSpecialOffers();
      }
      
      public function getLadderSeasonEndRewards(param1:Array, param2:Array, param3:uint, param4:uint) : void
      {
         var _loc6_:BMRewardData = null;
         this._ladderSeasonEndRewards = new Array();
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = new BMRewardData(param1[_loc5_]);
            this._ladderSeasonEndRewards.push(_loc6_);
            _loc5_++;
         }
         this._ladderSeasonEndGachaMachineIDs = param2;
         dataM.myProfile.currentSeasonHighestLadderProgress = param3;
         screensM.addScreen(BMScreensManager.SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS);
         screensM.screenLadderSeasonHighestLadderProgress.showLastSeasonHighestLadderProgress(dataM.myProfile.currentSeasonHighestLadderProgress);
         dataM.myProfile.ladderProgress = param4;
         dataM.myProfile.lastLadderProgress = param4;
      }
      
      public function enterMultiplayerLobbySuccess() : void
      {
         this.enableAllButtons();
      }
      
      public function enterChatIfDidNotEnterOnInit() : void
      {
         if(this._reEnterMultiplayerLobbyAndChat == false)
         {
            return;
         }
         dataM.chatData.enterChat();
         remoteM.enterMultiplayerLobby();
         this._reEnterMultiplayerLobbyAndChat = false;
      }
      
      public function ladderSeasonSubScreenClosed(param1:String) : void
      {
         switch(param1)
         {
            case BMScreensManager.SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS:
               screensM.addScreen(BMScreensManager.SCR_LADDER_SEASON_END_REWARD);
               screensM.screenLadderSeasonEndReward.showContent(dataM.myProfile.currentSeasonHighestLadderProgress,this._ladderSeasonEndRewards,this._ladderSeasonEndGachaMachineIDs);
               dataM.myProfile.currentSeasonHighestLadderProgress = 0;
               this._ladderSeasonEndRewards = new Array();
               break;
            case BMScreensManager.SCR_LADDER_SEASON_END_REWARD:
               screensM.addScreen(BMScreensManager.SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS);
               screensM.screenLadderSeasonEndNewLadderProgress.showNewSeasonStartingLadderProgress(dataM.myProfile.ladderProgress);
               break;
            case BMScreensManager.SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS:
               this.mcLadderRankDisplay.addRank();
               this.enableAllButtons();
         }
      }
      
      private function refreshArenaShopReminder() : void
      {
         this.mcArenaShopReminder.visible = false;
         if(dataM.playerSkillsManager.canPlayerBuyHighestLevelAvailableSkill())
         {
            this.mcArenaShopReminder.visible = true;
         }
      }
      
      private function initTournamentCountdown() : void
      {
         updateTextAndFormat(this.txtSeasonTitle,getScreenText("seasonEndsIn"));
         this._tournamentTimer = new Timer(1000);
         this._tournamentTimer.start();
         this._tournamentTimer.addEventListener(TimerEvent.TIMER,this.tournamentCountdownTimerTrigger);
         this.refreshTournamentCountdown();
      }
      
      private function tournamentCountdownTimerTrigger(param1:TimerEvent) : void
      {
         this.refreshTournamentCountdown();
      }
      
      private function refreshTournamentCountdown() : void
      {
         this.txtSeasonTimeLeft.text = TimeUtils.formatTimeLeftWithDays(dataM.getSecondsLeftToLeagueEnding());
      }
      
      private function removeTournamentCountdown() : void
      {
         if(this._tournamentTimer == null)
         {
            return;
         }
         this._tournamentTimer.stop();
         this._tournamentTimer = null;
      }
      
      private function reloadDataForWinningRewardPredication() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         remoteM.socketM.getQuestsData();
      }
      
      public function gotPVPWinningRewardPredictionData() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.winningRewardPredicationDisplay.showRewardPrediction();
      }
      
      public function createWinningWallMobileBitmap() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("multiplayerLadder_txtWinningWall",this.txtWinningWall," ",this);
         }
      }
      
      public function addWinningWallMessage(param1:String, param2:Boolean = false) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:String = "";
         if(this.txtWinningWall.numLines > this.WINNING_WALL_MAX_MESSAGES && dataM.chatData.winningWallTexts.length > this.WINNING_WALL_MAX_MESSAGES)
         {
            _loc4_ = dataM.chatData.winningWallTexts.length - this.WINNING_WALL_MAX_MESSAGES - 1;
            while(_loc4_ < dataM.chatData.winningWallTexts.length)
            {
               _loc3_ = this.txtWinningWall.htmlText + dataM.chatData.winningWallTexts[_loc4_].winningWallText;
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = this.txtWinningWall.htmlText + param1;
         }
         updateTextAndFormat(this.txtWinningWall,_loc3_);
         this.txtWinningWall.scrollV = this.txtWinningWall.maxScrollV;
         this.createWinningWallMobileBitmap();
      }
      
      private function searchForBattleMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("battle"),-1,-1);
      }
      
      private function chatRoomMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("goToChat"),-1,-1);
      }
      
      private function rankingListMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_rankingList"));
      }
      
      private function replaysMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_replays"));
      }
      
      private function clanRoomMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_clan"));
      }
      
      private function changeMechsOrderMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("changeMechsOrder"));
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      private function initSunRaysAnim() : void
      {
         this.mcRay1.alpha = this.SUN_RAYS_ALPHA_MAX;
         this.mcRay2.alpha = this.SUN_RAYS_ALPHA_MIN;
         this.mcRay3.alpha = this.SUN_RAYS_ALPHA_MAX;
         this.rayShowAnimComplete(1);
         this.rayHideAnimComplete(2);
         this.rayShowAnimComplete(3);
      }
      
      private function rayHideAnimComplete(param1:uint) : void
      {
         var _loc2_:Number = Math.random() * 2 + 2;
         var _loc3_:Number = Math.random() * 1 + 1;
         TweenMax.to(this["mcRay" + param1],_loc2_,{
            "delay":_loc3_,
            "alpha":this.SUN_RAYS_ALPHA_MAX,
            "onComplete":this.rayShowAnimComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function rayShowAnimComplete(param1:uint) : void
      {
         var _loc2_:Number = Math.random() * 2 + 2;
         var _loc3_:Number = Math.random() * 1 + 1;
         TweenMax.to(this["mcRay" + param1],_loc2_,{
            "delay":_loc3_,
            "alpha":this.SUN_RAYS_ALPHA_MIN,
            "onComplete":this.rayHideAnimComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function showBoostRecommendation() : void
      {
         dataM.mechBoostRecommender.showBoostRecommendation(this.boostRecommendationAccepted);
      }
      
      private function boostRecommendationAccepted(param1:uint) : void
      {
         dataM.mechBoostRecommender.setActiveRecommendation(param1,BMMechBoostRecommender.ORIGIN_PVP);
         this.backClickedSub(true);
      }
      
      private function onKinReadyForDisplay(param1:String, param2:Object) : void
      {
         this.refreshKin();
      }
      
      public function refreshKin() : void
      {
         this.mcKinBetPanel.visible = false;
         this.mcKinClaimPanel.visible = false;
         this.btnKinShop.visible = false;
         if(dataM.kinM.isEnabled == false)
         {
            return;
         }
         this.btnMechBuilds.x = 422;
         this.btnMechBuilds.y = 165;
         if(dataM.kinM.canClaimKin)
         {
            dataM.kinM.deactivateBetting();
            this.mcKinClaimPanel.refreshData();
            this.mcKinClaimPanel.visible = true;
         }
         else
         {
            dataM.kinM.activateBetting(true);
            this.mcKinBetPanel.refreshData();
            this.mcKinBetPanel.visible = true;
            this.btnKinShop.visible = true;
         }
      }
      
      private function kinShopClicked(param1:Event) : void
      {
         screensM.addScreen(BMScreensManager.SCR_KIN_SHOP);
         screensM.screenKinShop.refreshScreen(screensM.screenKinShop.TAB_SHOP);
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_SELECT_BATTLE_MECHS_PER_PLAYER))
         {
            screensM.screenSelectBattleMechsPerPlayer.removeMe();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_VS))
         {
            if(screensM.screenVS.visible == false)
            {
               screensM.removeScreen(BMScreensManager.SCR_VS);
            }
         }
         BMSpecialOffersManager.gi().removeSpecialOffer();
         if(screensM.isScreenOpened(BMScreensManager.SCR_YOUTUBE_VIDS_GUID))
         {
            screensM.screenYouTubeVidsGuide.removeMe();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_SMTV))
         {
            screensM.screenSMTV.removeMe();
         }
         this.removeChatAlerts();
         tooltip.hideToolTip();
         screensM.removeScreen(BMScreensManager.SCR_MULTIPLAYER_LADDER);
         TweenMax.killTweensOf(this.mcRay1);
         TweenMax.killTweensOf(this.mcRay2);
         TweenMax.killTweensOf(this.mcRay3);
         this.removeTournamentCountdown();
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.cancelSearchForBattleSuccess();
         this.refreshScreen(true);
      }
      
      public function handleSearchForBattleFailed() : *
      {
         this.cancelSearchForBattleSuccess();
         this.refreshScreen(true);
         screensM.screenConfirmation.displayCustomMessage("Could not search for battle, please try again");
      }
      
      private function handleWeeklyResetOccured(param1:String, param2:Object) : void
      {
         this.refreshSearchForBattleButton();
      }
   }
}

