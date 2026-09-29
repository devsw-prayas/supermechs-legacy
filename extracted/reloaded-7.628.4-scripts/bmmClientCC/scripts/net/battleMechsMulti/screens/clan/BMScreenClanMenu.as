package net.battleMechsMulti.screens.clan
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.gameOfWhales.BMGameOfWhalesManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.clan.listRow.ClanListRow;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3406")]
   public class BMScreenClanMenu extends BMBaseScreen
   {
      
      public static const TAB_NONE:uint = 0;
      
      public static const TAB_CHAT:uint = 1;
      
      public static const TAB_MEMBERS:uint = 2;
      
      public static const TAB_BOSS:uint = 3;
      
      public static const TAB_SHOP:uint = 4;
      
      public static const TAB_WAR_JOIN:uint = 5;
      
      public static const TAB_WAR_PREPARATION:uint = 6;
      
      public static const TAB_WAR_BATTLE:uint = 7;
      
      public var btnClose:BMBasicButton;
      
      public var mcTabs:MovieClip;
      
      public var mcTab1HitArea:Sprite;
      
      public var mcTab2HitArea:Sprite;
      
      public var mcTab3HitArea:Sprite;
      
      public var mcTab4HitArea:Sprite;
      
      public var mcTabs5:MovieClip;
      
      public var mcTabB1HitArea:Sprite;
      
      public var mcTabB2HitArea:Sprite;
      
      public var mcTabB3HitArea:Sprite;
      
      public var mcTabB4HitArea:Sprite;
      
      public var mcTabB5HitArea:Sprite;
      
      public var mcClanWarAttacksCounter:TextHolder;
      
      public var mcClanWarJoinBadge:Sprite;
      
      private var _selectedTab:uint = 0;
      
      private var _tabSelectedExternally:uint = 0;
      
      private var _pendingTab:uint = 0;
      
      public function BMScreenClanMenu()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clan");
         dataM.chatData.enterChat(dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID);
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.resetTabs();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.claimRewards();
         this.refreshBadgesAndCounters();
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         remoteM.socketM.clan_getClanData(dataM.myProfile.clanID);
      }
      
      public function setPendingTab(param1:uint) : void
      {
         this._pendingTab = param1;
      }
      
      public function gotClanData() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(this._selectedTab != TAB_NONE)
         {
            trace("need to handle refreshing tabs here");
            return;
         }
         this.initTabs();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_CHAT))
         {
            screensM.screenClanChat.onEnterFrameTrigger();
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_BOSS))
         {
            screensM.screenClanBoss.onEnterFrameTrigger();
         }
      }
      
      private function refreshBadgesAndCounters() : void
      {
         this.mcClanWarAttacksCounter.visible = false;
         this.mcClanWarJoinBadge.visible = false;
         if(dataM.clanWarsM.isFeatureEnabled == false)
         {
            return;
         }
         if(dataM.clanWarsM.isWarPhase)
         {
            if(dataM.clanWarsM.didIJoin == false)
            {
               return;
            }
            if(dataM.clanWarsM.attacksLeft > 0)
            {
               this.mcClanWarAttacksCounter.text = String(dataM.clanWarsM.attacksLeft);
               this.mcClanWarAttacksCounter.visible = true;
            }
            return;
         }
         if(dataM.clanWarsM.didIJoin == false)
         {
            this.mcClanWarJoinBadge.visible = true;
            return;
         }
      }
      
      private function resetTabs() : void
      {
         this.mcTabs.visible = false;
         this.mcTabs5.visible = false;
         this.mcTab1HitArea.visible = false;
         this.mcTab2HitArea.visible = false;
         this.mcTab3HitArea.visible = false;
         this.mcTab4HitArea.visible = false;
         this.mcTabB1HitArea.visible = false;
         this.mcTabB2HitArea.visible = false;
         this.mcTabB3HitArea.visible = false;
         this.mcTabB4HitArea.visible = false;
         this.mcTabB5HitArea.visible = false;
      }
      
      private function initTabs() : void
      {
         var _loc3_:uint = 0;
         var _loc1_:Array = [getSpecificText("multiplayerLadder_chat"),getSpecificText("rankingList_members"),getSpecificText("clanBoss_title")];
         if(dataM.clanWarsM.isFeatureEnabled)
         {
            this.mcTabs5.visible = true;
            this.mcTabB1HitArea.addEventListener(MouseEvent.CLICK,this.tab1Clicked);
            this.mcTabB2HitArea.addEventListener(MouseEvent.CLICK,this.tab2Clicked);
            this.mcTabB3HitArea.addEventListener(MouseEvent.CLICK,this.tab3Clicked);
            this.mcTabB4HitArea.addEventListener(MouseEvent.CLICK,this.tab4Clicked);
            this.mcTabB5HitArea.addEventListener(MouseEvent.CLICK,this.tab5Clicked);
            this.mcTabB1HitArea.visible = true;
            this.mcTabB2HitArea.visible = true;
            this.mcTabB3HitArea.visible = true;
            this.mcTabB4HitArea.visible = true;
            this.mcTabB5HitArea.visible = true;
            _loc1_.push(getScreenText("warCaps"));
         }
         else
         {
            this.mcTabs.visible = true;
            this.mcTab1HitArea.addEventListener(MouseEvent.CLICK,this.tab1Clicked);
            this.mcTab2HitArea.addEventListener(MouseEvent.CLICK,this.tab2Clicked);
            this.mcTab3HitArea.addEventListener(MouseEvent.CLICK,this.tab3Clicked);
            this.mcTab4HitArea.addEventListener(MouseEvent.CLICK,this.tab4Clicked);
            this.mcTab1HitArea.visible = true;
            this.mcTab2HitArea.visible = true;
            this.mcTab3HitArea.visible = true;
            this.mcTab4HitArea.visible = true;
         }
         _loc1_.push(getSpecificText("packages_title"));
         var _loc2_:uint = 1;
         while(_loc2_ <= _loc1_.length)
         {
            _loc3_ = 1;
            while(_loc3_ <= _loc1_.length)
            {
               if(dataM.clanWarsM.isFeatureEnabled)
               {
                  updateTextAndFormat(this.mcTabs5["mcTab" + _loc2_ + "Selected"]["txtTab" + _loc3_],_loc1_[_loc3_ - 1]);
               }
               else
               {
                  updateTextAndFormat(this.mcTabs["mcTab" + _loc2_ + "Selected"]["txtTab" + _loc3_],_loc1_[_loc3_ - 1]);
               }
               _loc3_++;
            }
            _loc2_++;
         }
         if(this._tabSelectedExternally != TAB_NONE)
         {
            this.selectTab(this._tabSelectedExternally);
            this._tabSelectedExternally = TAB_NONE;
            return;
         }
         if(this._pendingTab > 0)
         {
            this.selectTab(this._pendingTab);
         }
         else
         {
            this.selectTab(TAB_CHAT);
         }
         if(dataM.myProfile.isClanLeader && dataM.myProfile.clanFlag == "")
         {
            screensM.screenClanChat.openSettings();
            return;
         }
      }
      
      private function tab1Clicked(param1:MouseEvent) : void
      {
         this.selectChatTab();
      }
      
      private function tab2Clicked(param1:MouseEvent) : void
      {
         this.selectMembersTab();
      }
      
      private function tab3Clicked(param1:MouseEvent) : void
      {
         if(dataM.clanBossEnabled == false)
         {
            this.showComingSoon();
            return;
         }
         this.selectBossTab();
      }
      
      private function tab4Clicked(param1:MouseEvent) : void
      {
         if(this.mcTabs.visible)
         {
            this.shopClicked();
            return;
         }
         if(dataM.clanWarsM.didQuitAClanThisSession)
         {
            screensM.screenConfirmation.displayCustomMessage(getSpecificText("clanWar_spectatorCannotFight"));
            return;
         }
         if(dataM.clanWarsM.isWarPhase)
         {
            if(dataM.clanWarsM.didMyClanFailToFindOpponent)
            {
               screensM.screenConfirmation.displayCustomMessage(getSpecificText("clanWar_noOpponent"));
               return;
            }
            this.selectWarBattleTab();
         }
         else if(dataM.clanWarsM.didIJoin)
         {
            this.selectWarPreparationTab();
         }
         else
         {
            this.selectWarJoinTab();
         }
      }
      
      private function tab5Clicked(param1:MouseEvent) : void
      {
         this.shopClicked();
      }
      
      public function openClanWarPreparation(param1:Boolean = false) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.selectWarPreparationTab();
         if(param1)
         {
            this.refreshBadgesAndCounters();
         }
      }
      
      private function shopClicked() : void
      {
         if(dataM.clanBossEnabled == false)
         {
            this.showComingSoon();
            return;
         }
         this.selectShopTab();
      }
      
      public function selectTab(param1:uint) : void
      {
         if(this._selectedTab == param1)
         {
            return;
         }
         var _loc2_:Boolean = false;
         if(param1 == TAB_SHOP && FeatureFlags.BLOCK_SHOP)
         {
            _loc2_ = true;
         }
         else if(param1 == TAB_BOSS && FeatureFlags.BLOCK_CLAN_BOSS)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         var _loc3_:uint = this._selectedTab;
         this._selectedTab = param1;
         var _loc4_:MovieClip = this.mcTabs;
         if(this.mcTabs5.visible)
         {
            _loc4_ = this.mcTabs5;
         }
         _loc4_.mcTab1Selected.visible = false;
         _loc4_.mcTab2Selected.visible = false;
         _loc4_.mcTab3Selected.visible = false;
         _loc4_.mcTab4Selected.visible = false;
         if(this.mcTabs5.visible)
         {
            this.mcTabs5.mcTab5Selected.visible = false;
         }
         switch(_loc3_)
         {
            case TAB_CHAT:
               this.removeChatScreen();
               break;
            case TAB_MEMBERS:
               this.removeMembersScreen();
               break;
            case TAB_BOSS:
               this.removeBossScreen();
               break;
            case TAB_SHOP:
               this.removeShopScreen();
               break;
            case TAB_WAR_JOIN:
               this.removeWarJoinScreen();
               break;
            case TAB_WAR_PREPARATION:
               this.removeWarPreparationScreen();
               break;
            case TAB_WAR_BATTLE:
               this.removeWarBattleScreen();
         }
         switch(this._selectedTab)
         {
            case TAB_CHAT:
               screensM.addScreen(BMScreensManager.SCR_CLAN_CHAT);
               _loc4_.mcTab1Selected.visible = true;
               break;
            case TAB_MEMBERS:
               screensM.addScreen(BMScreensManager.SCR_CLAN_MEMBERS);
               _loc4_.mcTab2Selected.visible = true;
               break;
            case TAB_BOSS:
               screensM.addScreen(BMScreensManager.SCR_CLAN_BOSS);
               _loc4_.mcTab3Selected.visible = true;
               break;
            case TAB_SHOP:
               screensM.addScreen(BMScreensManager.SCR_CLAN_SHOP);
               if(this.mcTabs5.visible)
               {
                  this.mcTabs5.mcTab5Selected.visible = true;
               }
               else
               {
                  this.mcTabs.mcTab4Selected.visible = true;
               }
               break;
            case TAB_WAR_JOIN:
               screensM.addScreen(BMScreensManager.SCR_CLAN_WAR_JOIN);
               this.mcTabs5.mcTab4Selected.visible = true;
               break;
            case TAB_WAR_PREPARATION:
               screensM.addScreen(BMScreensManager.SCR_CLAN_WAR_PREPARATION);
               this.mcTabs5.mcTab4Selected.visible = true;
               break;
            case TAB_WAR_BATTLE:
               screensM.addScreen(BMScreensManager.SCR_CLAN_WAR_BATTLE);
               this.mcTabs5.mcTab4Selected.visible = true;
         }
      }
      
      public function selectChatTab() : void
      {
         this.selectTab(TAB_CHAT);
      }
      
      public function selectMembersTab() : void
      {
         if(this._selectedTab == TAB_NONE)
         {
            this._tabSelectedExternally = TAB_MEMBERS;
            return;
         }
         this.selectTab(TAB_MEMBERS);
      }
      
      public function selectBossTab() : void
      {
         this.selectTab(TAB_BOSS);
      }
      
      public function selectShopTab() : void
      {
         this.selectTab(TAB_SHOP);
      }
      
      public function selectWarJoinTab() : void
      {
         this.selectTab(TAB_WAR_JOIN);
      }
      
      public function selectWarBattleTab() : void
      {
         this.selectTab(TAB_WAR_BATTLE);
      }
      
      public function selectWarPreparationTab() : void
      {
         this.selectTab(TAB_WAR_PREPARATION);
      }
      
      private function removeChatScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_CHAT))
         {
            screensM.screenClanChat.removeMe();
         }
      }
      
      private function removeMembersScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_MEMBERS))
         {
            screensM.screenClanMembers.removeMe();
         }
      }
      
      private function removeBossScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_BOSS))
         {
            screensM.screenClanBoss.removeMe();
         }
      }
      
      private function removeShopScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_SHOP))
         {
            screensM.screenClanShop.removeMe();
            BMShopManager.gi().close();
         }
      }
      
      private function removeWarJoinScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_JOIN))
         {
            screensM.screenClanWarJoin.removeMe();
         }
      }
      
      private function removeWarPreparationScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_PREPARATION))
         {
            screensM.screenClanWarPreparation.removeMe();
         }
      }
      
      private function removeWarBattleScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_BATTLE))
         {
            screensM.screenClanWarBattle.removeMe();
         }
      }
      
      private function removeWarLastWarScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_LAST_WAR))
         {
            screensM.screenClanWarLastWar.removeMe();
         }
      }
      
      private function showComingSoon() : void
      {
         var _loc1_:String = "<BR><BR>" + getGeneralText("comingSoon");
         screensM.screenConfirmation.displayCustomMessage(_loc1_,this.comingSoonClosed);
      }
      
      public function showLastWar() : void
      {
         screensM.addScreen(BMScreensManager.SCR_CLAN_WAR_LAST_WAR);
      }
      
      private function comingSoonClosed() : void
      {
         this.selectChatTab();
      }
      
      public function acceptRequestMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("acceptNewMember"),-1,-1);
      }
      
      private function generalButtonMouseOut(param1:MouseEvent) : void
      {
         this.generalButtonMouseOutSub();
      }
      
      private function generalButtonMouseOutSub() : void
      {
         tooltip.hideToolTip();
      }
      
      public function playerRequestsToJoin() : void
      {
         if(this._selectedTab != TAB_MEMBERS)
         {
            return;
         }
         screensM.screenClanMembers.addAndRefreshMembersTileList();
      }
      
      public function playerCancelledRequestToJoin(param1:uint) : void
      {
         if(this._selectedTab != TAB_MEMBERS)
         {
            return;
         }
         screensM.screenClanMembers.removePlayerFromTileList(param1);
      }
      
      public function acceptNewMemberFailed(param1:uint) : void
      {
         if(this._selectedTab != TAB_MEMBERS)
         {
            return;
         }
         screensM.screenConfirmation.displayQuestionOrNotification("joinClanRequestNotValid",-1,-1);
         screensM.screenClanMembers.removePlayerFromTileList(param1);
      }
      
      public function youWereKickedFromClan() : void
      {
         this.returnToPreviousScreen();
      }
      
      private function claimRewards() : Boolean
      {
         if(dataM.myProfile.hasClanBossReward)
         {
            this.showBossClaimReward();
            return true;
         }
         if(dataM.clanWarsM.hasPendingReward)
         {
            this.showClanWarClaimReward();
            return true;
         }
         return false;
      }
      
      private function showBossClaimReward() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         remoteM.socketM.clan_collectClanBossCoins();
      }
      
      public function clanBossCoinsClaimed() : void
      {
         screensM.addScreen(BMScreensManager.SCR_CLAN_BOSS_CLAIM_REWARD);
         var _loc1_:String = getSpecificText("clanBoss_bossBattlesReward");
         var _loc2_:uint = dataM.myProfile.clan_bossCoinsToCollect;
         var _loc3_:uint = 0;
         if(this.clanBossCoinsToGoldRewardMultiplier > 0)
         {
            _loc3_ = Math.ceil(dataM.myProfile.clan_bossCoinsToCollect * this.clanBossCoinsToGoldRewardMultiplier);
         }
         var _loc4_:uint = 0;
         dataM.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_GOLD,_loc3_,BMGameOfWhalesManager.SOURCE_CLAN_BOSS,BMGameOfWhalesManager.PLACE_CLAN_BOSS);
         dataM.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_CLAN_COINS,_loc2_,BMGameOfWhalesManager.SOURCE_CLAN_BOSS,BMGameOfWhalesManager.PLACE_CLAN_BOSS);
         screensM.screenClanBossClaimReward.showReward(_loc1_,_loc2_,_loc3_,_loc4_,this.clanBossRewardCeremonyFinished);
      }
      
      public function clanBossRewardCeremonyFinished() : void
      {
         dataM.myProfile.clan_collectBossCoins();
         var _loc1_:Boolean = this.claimRewards();
         if(_loc1_ == false)
         {
            this.selectShopTab();
         }
      }
      
      private function showClanWarClaimReward() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         this.clanWarRewardClaimed();
      }
      
      public function clanWarRewardClaimed() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         screensM.addScreen(BMScreensManager.SCR_CLAN_BOSS_CLAIM_REWARD);
         var _loc1_:String = getSpecificText("clanWar_clanWarReward");
         var _loc2_:uint = uint(dataM.clanWarsM.pendingReward.clanCoins);
         var _loc3_:uint = 0;
         var _loc4_:uint = dataM.clanWarsM.pendingReward.boxes[0];
         screensM.screenClanBossClaimReward.showReward(_loc1_,_loc2_,_loc3_,_loc4_,this.clanWarRewardCeremonyFinished);
      }
      
      public function clanWarRewardCeremonyFinished() : void
      {
         dataM.clanWarsM.rewardCollected();
         remoteM.socketM.clanWar_collectReward();
      }
      
      private function get clanBossCoinsToGoldRewardMultiplier() : Number
      {
         return Number(dataM.getGeneralSetting("clanBossCoinsToGoldRewardMultiplier","0"));
      }
      
      public function refreshClanData() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CONFIRMATION))
         {
            return;
         }
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         loginM.settingsUpdateRequired = true;
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT,1);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_CLAN,{"tab":TAB_CHAT});
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_CLOSE_CONFIRMATION_SCREEN);
      }
      
      public function inspectPlayer(param1:int) : void
      {
         var _loc3_:BMClanMemberData = null;
         if(param1 == -1)
         {
            return;
         }
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(param1 >= _loc2_.clanMembers)
         {
            _loc3_ = _loc2_.clan_playersRequestedToJoin[param1 - _loc2_.clanMembers];
         }
         else
         {
            _loc3_ = _loc2_.clanData.members[param1];
         }
         screensM.addScreen(BMScreensManager.SCR_INSPECT_PLAYER);
         screensM.screenInspectPlayer.refreshScreen(_loc3_.playerID,true,_loc3_.name,_loc3_.level,_loc3_.ladderProgress,_loc2_.clanID);
      }
      
      public function getMemberRowBackground(param1:int, param2:ClanListRow, param3:Object, param4:uint, param5:Boolean = false) : String
      {
         var _loc6_:String = ClanListRow.BACKGROUND_REGULAR1;
         if(param3.type == "request")
         {
            _loc6_ = ClanListRow.BACKGROUND_ONLINE;
         }
         else if(dataM.myProfile.clanLeaderID == param3.playerID)
         {
            _loc6_ = ClanListRow.BACKGROUND_TOP10;
         }
         else if(param4 == param1)
         {
            _loc6_ = ClanListRow.BACKGROUND_SELF;
         }
         else if(param5)
         {
            if(Math.ceil(param4 / 2) % 2 == 0)
            {
               _loc6_ = ClanListRow.BACKGROUND_REGULAR2;
            }
         }
         else if(param4 % 2 == 0)
         {
            _loc6_ = ClanListRow.BACKGROUND_REGULAR2;
         }
         return _loc6_;
      }
      
      public function leftClan() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.clanMembers == 1 && dataM.clansRankingList[_loc1_.clanID] != null)
         {
            delete dataM.clansRankingList[_loc1_.clanID];
         }
         _loc1_.clanID = 0;
         _loc1_.clan_playersRequestedToJoin = new Vector.<BMClanMemberData>();
         dataM.chatData.gotRecentClanMessagesThisLogin = false;
         dataM.chatData.clearClanChannelLog();
         dataM.clanWarsM.playerLeftClan();
         screensM.screenConfirmation.displayQuestionOrNotification("playerHasLeftClan",-1,-1);
      }
      
      public function goToClanRankingList() : void
      {
         screensM.screenTransitionsManager.cameFromClan = true;
         screensM.screenTransitionsManager.communityRankingListClicked(false,true);
      }
      
      private function closeClicked(param1:Event) : void
      {
         this.closeClickedSub();
      }
      
      public function closeClickedSub() : void
      {
         this.returnToPreviousScreen();
      }
      
      private function returnToPreviousScreen() : void
      {
         screensM.screenTransitionsManager.mainMenu();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function removeMe() : void
      {
         this.removeChatScreen();
         this.removeMembersScreen();
         this.removeBossScreen();
         this.removeShopScreen();
         this.removeWarJoinScreen();
         this.removeWarPreparationScreen();
         this.removeWarBattleScreen();
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_LAST_WAR))
         {
            screensM.screenClanWarLastWar.removeMe();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_INSPECT_PLAYER))
         {
            screensM.screenClanWarInspectPlayer.removeMe();
         }
         screensM.removeScreen(BMScreensManager.SCR_CLAN_MENU);
      }
   }
}

