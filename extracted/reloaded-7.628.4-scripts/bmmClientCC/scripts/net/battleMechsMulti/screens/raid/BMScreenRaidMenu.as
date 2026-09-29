package net.battleMechsMulti.screens.raid
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   
   public class BMScreenRaidMenu extends BMBaseScreen
   {
      
      public static const TAB_BATTLE:uint = 1;
      
      public static const TAB_LEADERBOARD:uint = 2;
      
      public static const TAB_RULES:uint = 3;
      
      public var mcTabs:MovieClip;
      
      public var mcTab1HitArea:Sprite;
      
      public var mcTab2HitArea:Sprite;
      
      public var mcTab3HitArea:Sprite;
      
      public var btnClose:BMBasicButton;
      
      public var mcTimer:BMTimer;
      
      private var _selectedTab:uint = 0;
      
      public function BMScreenRaidMenu()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("raid");
         this.initButtons();
         this.initTimer();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.initTabs();
         if(dataM.raidData.hasPendingReward())
         {
            screensM.addScreen(BMScreensManager.SCR_RAID_CLAIM_REWARD);
         }
      }
      
      private function initTimer() : void
      {
         this.mcTimer.initialize(dataM.questsManager.getDailyQuestsSecLeft,this.onTimeEnd);
      }
      
      private function onTimeEnd() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CONFIRMATION))
         {
            return;
         }
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT,2);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         screensM.screensDirector.addDataUpdateTask(BMScreensDirectorTask.DATA_UPDATE_RELOAD_QUESTS_DATA);
         screensM.screensDirector.addDataUpdateTask(BMScreensDirectorTask.DATA_UPDATE_RELOAD_RAID_DATA);
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT,4);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_RAID_MENU);
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_CLOSE_CONFIRMATION_SCREEN);
      }
      
      private function initTabs() : void
      {
         this.mcTab1HitArea.addEventListener(MouseEvent.CLICK,this.tab1Clicked);
         this.mcTab2HitArea.addEventListener(MouseEvent.CLICK,this.tab2Clicked);
         this.mcTab3HitArea.addEventListener(MouseEvent.CLICK,this.tab3Clicked);
         var _loc1_:String = getScreenText("battle");
         var _loc2_:String = getScreenText("leaderboard");
         var _loc3_:String = getScreenText("rules");
         updateTextAndFormat(this.mcTabs.mcTab1Selected.txtTab1,_loc1_);
         updateTextAndFormat(this.mcTabs.mcTab1Selected.txtTab2,_loc2_);
         updateTextAndFormat(this.mcTabs.mcTab1Selected.txtTab3,_loc3_);
         updateTextAndFormat(this.mcTabs.mcTab2Selected.txtTab1,_loc1_);
         updateTextAndFormat(this.mcTabs.mcTab2Selected.txtTab2,_loc2_);
         updateTextAndFormat(this.mcTabs.mcTab2Selected.txtTab3,_loc3_);
         updateTextAndFormat(this.mcTabs.mcTab3Selected.txtTab1,_loc1_);
         updateTextAndFormat(this.mcTabs.mcTab3Selected.txtTab2,_loc2_);
         updateTextAndFormat(this.mcTabs.mcTab3Selected.txtTab3,_loc3_);
         if(dataM.raidData.raidDaysLeft >= 1)
         {
            this.selectTab(TAB_BATTLE);
         }
         else
         {
            this.selectTab(TAB_LEADERBOARD);
         }
      }
      
      private function tab1Clicked(param1:MouseEvent) : void
      {
         if(dataM.raidData.raidDaysLeft == 0)
         {
            screensM.screenConfirmation.displayCustomMessage(getScreenText("nextRaidWillStartTomorrow"));
            return;
         }
         this.selectBattleTab();
      }
      
      private function tab2Clicked(param1:MouseEvent) : void
      {
         this.selectLeaderboardTab();
      }
      
      private function tab3Clicked(param1:MouseEvent) : void
      {
         this.selectRulesTab();
      }
      
      public function selectBattleTab() : void
      {
         this.selectTab(TAB_BATTLE);
      }
      
      public function selectLeaderboardTab() : void
      {
         this.selectTab(TAB_LEADERBOARD);
      }
      
      public function selectRulesTab() : void
      {
         this.selectTab(TAB_RULES);
      }
      
      private function selectTab(param1:uint) : void
      {
         if(this._selectedTab == param1)
         {
            return;
         }
         this._selectedTab = param1;
         this.mcTabs.mcTab1Selected.visible = false;
         this.mcTabs.mcTab2Selected.visible = false;
         this.mcTabs.mcTab3Selected.visible = false;
         switch(this._selectedTab)
         {
            case TAB_BATTLE:
               this.mcTabs.mcTab1Selected.visible = true;
               screensM.addScreen(BMScreensManager.SCR_RAID_BATTLE);
               this.removeLeaderboardScreen();
               this.removeRulesScreen();
               break;
            case TAB_LEADERBOARD:
               this.mcTabs.mcTab2Selected.visible = true;
               screensM.addScreen(BMScreensManager.SCR_RAID_LEADERBOARD);
               this.removeBattleScreen();
               this.removeRulesScreen();
               break;
            case TAB_RULES:
               this.mcTabs.mcTab3Selected.visible = true;
               screensM.addScreen(BMScreensManager.SCR_RAID_RULES);
               this.removeBattleScreen();
               this.removeLeaderboardScreen();
         }
      }
      
      private function removeBattleScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_RAID_BATTLE))
         {
            screensM.screenRaidBattle.removeMe();
         }
      }
      
      private function removeLeaderboardScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_RAID_LEADERBOARD))
         {
            screensM.screenRaidLeaderboard.removeMe();
         }
      }
      
      private function removeRulesScreen() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_RAID_RULES))
         {
            screensM.screenRaidRules.removeMe();
         }
      }
      
      private function initButtons() : void
      {
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
      }
      
      private function closeClicked(param1:Event) : void
      {
         this.closeClickedSub();
      }
      
      public function closeClickedSub() : void
      {
         dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_DEFAULT);
         screensM.screenTransitionsManager.mainMenu();
      }
      
      public function enterRaidClicked() : void
      {
         if(dataM.areMechsReadyForBattle())
         {
            if(dataM.raidData.missionStatus == BMSinglePlayerManager.MAP_PROGRESS_INCOMPLETE)
            {
               dataM.raidData.missionStatus = BMSinglePlayerManager.MAP_PROGRESS_IN_PROGRESS;
            }
            else
            {
               dataM.raidData.missionStatus = BMSinglePlayerManager.MAP_PROGRESS_REPLAY;
            }
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            remoteM.socketM.raid_create();
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",-1,-1);
         }
      }
      
      public function newMissionCreated() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(dataM.useHiddenBaseMap)
         {
            screensM.screenBlack.activateBlackScreen(null,true,true,null,0,true,this.enterNewMission);
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.enterNewMission,true,true,null,0);
         }
      }
      
      public function enterNewMission() : void
      {
         this.removeMe();
         dataM.myProfile.currentStoryID = BMSinglePlayerManager.STORY_ID_RAID;
         screensM.screenTransitionsManager.removeCurrentScreen();
         screensM.addScreen(BMScreensManager.SCR_MISSION_BASE_MAP);
         screensM.screenMissionBaseMap.refreshScreen(false);
         if(dataM.useHiddenBaseMap)
         {
            dataM.battleMechsPerPlayer = dataM.getCurrentMissionMechsPerPlayer();
            screensM.addBattleScreens();
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.mcTab1HitArea.removeEventListener(MouseEvent.CLICK,this.tab1Clicked);
         this.mcTab2HitArea.removeEventListener(MouseEvent.CLICK,this.tab2Clicked);
         this.removeLeaderboardScreen();
         this.removeBattleScreen();
         this.removeRulesScreen();
         screensM.removeScreen(BMScreensManager.SCR_RAID_CLAIM_REWARD);
         screensM.removeScreen(BMScreensManager.SCR_INSPECT_PLAYER);
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_RAID_MENU);
      }
   }
}

