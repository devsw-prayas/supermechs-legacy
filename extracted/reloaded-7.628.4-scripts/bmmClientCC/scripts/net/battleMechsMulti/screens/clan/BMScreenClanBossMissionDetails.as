package net.battleMechsMulti.screens.clan
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.popups.BMScreenYesNoPopup;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenClanBossMissionDetails extends BMBaseScreen
   {
      
      private static const WIDTH:uint = 296;
      
      public var txtTitle:TextField;
      
      public var txtBossName:TextField;
      
      public var txtBossHP:TextField;
      
      public var txtTicketsAmount:TextField;
      
      public var txtTicketsNotEnough:TextField;
      
      public var btnClose:BMBasicButton;
      
      public var btnBattle:BMBasicButton;
      
      public var btnBattle_noBattlesLeft:BMBasicButton;
      
      public var btnLocked:BMBasicButton;
      
      public var btnClanBossLeaderboard:BMBasicButton;
      
      public var btnMechBuilds:BMBasicButton;
      
      public var mcTicketsIcon:Sprite;
      
      public var mcHPBarFrame:Sprite;
      
      public var mcBossLevel:MovieClip;
      
      public var mcBossThumb:RaidEnemyThumb;
      
      public var bossHPBar:BMBar;
      
      public var mcBattlesRefillTimer:BMTimer;
      
      public var mcBossActiveTimer:BMTimer;
      
      private var _locked:Boolean = false;
      
      public function BMScreenClanBossMissionDetails()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clanBoss");
         this.setBossMechThumb();
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         updateTextAndFormat(this.txtBossName,dataM.myProfile.clanBossData.name);
         this.mcBossLevel.gotoAndStop(dataM.myProfile.clanBossData.level);
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClicked);
         this.btnBattle.addEventListener(BMIntractable.HIT,this.onBattleClicked);
         this.btnBattle_noBattlesLeft.addEventListener(BMIntractable.HIT,this.onBattleClicked);
         this.btnLocked.addEventListener(BMIntractable.HIT,this.onLockedClicked);
         this.btnClanBossLeaderboard.addEventListener(BMIntractable.HIT,this.onClanBossLeaderboardClicked);
         this.btnMechBuilds.addEventListener(BMIntractable.HIT,this.onMechBuildsClicked);
         if(dataM.mechBuildsM.isEnabled == false)
         {
            this.btnMechBuilds.visible = false;
         }
         if(dataM.myProfile.isInClan == false)
         {
            this.btnClanBossLeaderboard.visible = false;
         }
         this.btnBattle.text = getSpecificText("multiplayerLadder_battle") + " " + dataM.myProfile.clan_bossBattlesLeft + "/" + dataM.clanBossBattlesMax;
         this.btnBattle_noBattlesLeft.text = getSpecificText("multiplayerLadder_battle") + " " + dataM.myProfile.clan_bossBattlesLeft + "/" + dataM.clanBossBattlesMax;
         this.btnLocked.text = getSpecificText("missionDifficulty_locked");
         this.bossHPBar.initialize(BMBar.COLOR_YELLOW);
         this.bossHPBar.addSeparateorLines(5);
         this.refreshInterface();
         x = dataM.STAGE_WIDTH;
         y = 25;
         this.mcBattlesRefillTimer.mouseEnabled = false;
         this.mcBattlesRefillTimer.mouseChildren = false;
         if(dataM.clientRunningLocally == false)
         {
            this.mcBossActiveTimer.visible = false;
         }
         this.open();
      }
      
      public function open() : void
      {
         this._locked = true;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.3,{
            "x":dataM.STAGE_WIDTH - WIDTH,
            "onComplete":this.openAnimComplete
         });
      }
      
      private function openAnimComplete() : void
      {
         this._locked = false;
      }
      
      private function refreshInterface() : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         this.mcBattlesRefillTimer.visible = false;
         this.btnBattle.visible = false;
         this.btnBattle_noBattlesLeft.visible = false;
         this.mcBossActiveTimer.initialize(this.bossActiveTimerProvider,this.onBossActiveTimerEnded,0,true);
         if(dataM.myProfile.isInClan == false || dataM.myProfile.clanHasEnoughBossTickets)
         {
            this.txtTicketsAmount.text = "";
            this.txtTicketsNotEnough.text = "";
            this.mcTicketsIcon.visible = false;
            this.btnLocked.visible = false;
            if(dataM.myProfile.isClanBossAlive)
            {
               _loc5_ = dataM.myProfile.clanBossHP;
               _loc6_ = dataM.myProfile.clanBossData.hpMax;
               _loc7_ = TextUtils.getNumberWithComma(_loc5_) + " / " + TextUtils.getNumberWithComma(_loc6_);
               updateTextAndFormat(this.txtBossHP,_loc7_);
               _loc8_ = _loc5_ / _loc6_;
               this.bossHPBar.setFill(_loc8_);
               this.btnBattle.visible = true;
               if(dataM.myProfile.clan_bossBattlesLeft == 0)
               {
                  this.mcBattlesRefillTimer.visible = true;
                  this.mcBattlesRefillTimer.initialize(this.battlesRefillTimerProvider,this.onBattlesRefillTimerEnded,0,true);
                  this.btnBattle_noBattlesLeft.visible = true;
               }
               else
               {
                  this.btnBattle.visible = true;
               }
            }
            else
            {
               updateTextAndFormat(this.txtBossHP,"<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>" + getScreenText("defeated"));
               this.bossHPBar.visible = false;
            }
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("clanBossMissionDetails_hp",[this.txtBossHP],"",this);
            }
            return;
         }
         this.txtBossHP.text = "";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("clanBossMissionDetails_hp",[this.txtBossHP],"",this);
         }
         this.bossHPBar.visible = false;
         this.mcHPBarFrame.visible = false;
         var _loc1_:String = TextUtils.getNumberWithComma(dataM.myProfile.clanBossTickets) + " / " + TextUtils.getNumberWithComma(dataM.myProfile.clanBossData.ticketsRequired);
         updateTextAndFormat(this.txtTicketsAmount,_loc1_);
         updateTextAndFormat(this.txtTicketsNotEnough,getScreenText("notEnoughTickets"));
         var _loc2_:Number = this.mcTicketsIcon.x + this.txtTicketsAmount.x + this.txtTicketsAmount.width;
         var _loc3_:Number = this.txtTicketsAmount.width - this.txtTicketsAmount.textWidth;
         var _loc4_:Number = _loc3_ / 2 - 5;
         this.mcTicketsIcon.x += _loc4_;
         this.txtTicketsAmount.x += _loc4_;
      }
      
      private function onBattlesRefillTimerEnded() : void
      {
         dataM.myProfile.clan_bossBattlesDoneToday = 0;
         this.btnBattle.text = getSpecificText("multiplayerLadder_battle") + " " + dataM.myProfile.clan_bossBattlesLeft + "/" + dataM.clanBossBattlesMax;
         this.btnBattle.visible = true;
         this.mcBattlesRefillTimer.visible = false;
         this.btnBattle_noBattlesLeft.visible = false;
      }
      
      private function onBossActiveTimerEnded() : void
      {
         this.close();
         screensM.screenMissionWorldMap.clanBossInactive();
      }
      
      private function bossActiveTimerProvider() : uint
      {
         return dataM.myProfile.clanBossActiveTimeLeft;
      }
      
      private function battlesRefillTimerProvider() : uint
      {
         return dataM.questsManager.dailyQuestsSecLeft;
      }
      
      private function setBossMechThumb() : void
      {
         this.mcBossThumb.initialize_avatarThumb(dataM.myProfile.clanBossData.battleAvatar,dataM.myProfile.clanBossData.colorID,dataM.myProfile.clanBossData.themeID);
      }
      
      private function onCloseClicked(param1:Event) : void
      {
         if(this._locked)
         {
            return;
         }
         this.close();
      }
      
      public function close() : void
      {
         this._locked = true;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.3,{
            "x":dataM.STAGE_WIDTH,
            "onComplete":this.onCloseAnimComplete
         });
      }
      
      private function onCloseAnimComplete() : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CLAN_BOSS_MISSION_DETAILS);
      }
      
      private function onBattleClicked(param1:Event) : void
      {
         if(this._locked)
         {
            return;
         }
         if(dataM.myProfile.isInClan == false)
         {
            this.showCreateJoinClanPopup();
            return;
         }
         var _loc2_:String = dataM.myPlayerData.isBlockedFromPlayingInCompetitveBattles(1);
         if(_loc2_ != null)
         {
            screensM.screenConfirmation.displayQuestionOrNotification(_loc2_);
            return;
         }
         var _loc3_:Boolean = dataM.myProfile.clan_bossBattlesLeft == 0;
         if(_loc3_)
         {
            if(dataM.myProfile.isClanBossLastActiveDay)
            {
               screensM.screenConfirmation.displayCustomMessage(getScreenText("noMoreBattlesLeft"));
            }
            else
            {
               screensM.screenConfirmation.displayCustomMessage(getScreenText("comeBackTomorrowToBattleAgain"));
            }
            return;
         }
         var _loc4_:uint = 1;
         if(dataM.areMechsReadyForBattle(_loc4_) == false)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",-1,-1);
            return;
         }
         screensM.screenMissionWorldMap.enterClanBossBattle();
      }
      
      private function showCreateJoinClanPopup() : void
      {
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup8);
         var _loc1_:String = getSpecificText("clanBoss_mustJoinClan");
         var _loc2_:String = getSpecificText("rankingList_clans");
         var _loc3_:String = getGeneralText("cancel");
         screensM.screenYesNoPopup.displayYesNoPopup(_loc1_,"","",this.goToClanLeaderboard,null,_loc2_,_loc3_,BMScreenYesNoPopup.SIGN_NONE);
      }
      
      private function onLockedClicked(param1:Event) : void
      {
         if(this._locked)
         {
            return;
         }
         screensM.screenConfirmation.displayCustomMessage(getScreenText("findMoreTickets"),this.goToBestSideMission);
      }
      
      private function goToBestSideMission() : void
      {
         var _loc1_:Array = dataM.singlePlayerM.getAvailableMissionWithMostClanBossTickets(screensM.screenMissionWorldMap.storyID);
         var _loc2_:uint = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(_loc1_ != null)
         {
            _loc2_ = uint(_loc1_[0]);
            _loc3_ = uint(_loc1_[1]);
            _loc4_ = uint(_loc1_[2]);
         }
         screensM.screenMissionWorldMap.manuallySelectMission(_loc3_,_loc4_);
      }
      
      private function onMechBuildsClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.mechBuildsClicked(1);
         screensM.screenTransitionsManager.cameFromWorldMapClanBoss = true;
      }
      
      private function onClanBossLeaderboardClicked(param1:Event) : void
      {
         if(this._locked)
         {
            return;
         }
         this.goToClanLeaderboard();
      }
      
      private function goToClanLeaderboard() : void
      {
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_CLAN,{"tab":BMScreenClanMenu.TAB_BOSS});
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this);
      }
   }
}

