package net.battleMechsMulti.screens.clan
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.clanWars.BMClanWarsManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenClanWarBattle extends BMBaseScreen
   {
      
      public var mcClanOverview1:BMClanOverview;
      
      public var mcClanOverview2:BMClanOverview;
      
      public var mcScoreBar1:BMBar;
      
      public var mcScoreBar2:BMBar;
      
      public var mcMechsHolder1:Sprite;
      
      public var mcMechsHolder2:Sprite;
      
      public var mcMechsHolder3:Sprite;
      
      public var txtScore1:TextField;
      
      public var txtScore2:TextField;
      
      public var mcMedal1:Sprite;
      
      public var mcMedal2:Sprite;
      
      public var txtRound:TextField;
      
      public var mcReward:BMClanWarRewards;
      
      public var btnInspectDefence:BMBasicButton;
      
      public var btnInspectOffence:BMBasicButton;
      
      public var btnBattle:BMBasicButton;
      
      public var mcTimer:BMTimer;
      
      private var mechsCreator:BMClanWarEyeCandyMechs;
      
      public function BMScreenClanWarBattle()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clanWar");
         this.initClanOverviews();
         this.initTexts();
         this.initRewards();
         this.initButtons();
         this.initTimer();
         this.initBarsAndMedals();
         this.createMechs();
         dataM.clanWarsM.setLocalNotifications();
      }
      
      private function initBarsAndMedals() : void
      {
         this.mcScoreBar1.initialize(BMBar.COLOR_BLUE);
         this.mcScoreBar1.addSeparateorLines(4);
         this.mcScoreBar1.setFill(0);
         this.mcScoreBar1.setFill(dataM.clanWarsM.myClanScoreRatio,true);
         this.mcScoreBar2.initialize(BMBar.COLOR_BLUE,"left");
         this.mcScoreBar2.addSeparateorLines(4);
         this.mcScoreBar2.setFill(0);
         this.mcScoreBar2.setFill(dataM.clanWarsM.enemyClanScoreRatio,true);
         updateTextAndFormat(this.txtScore1,Math.ceil(dataM.clanWarsM.myClanScoreRatio * 1000) / 10 + "%");
         updateTextAndFormat(this.txtScore2,Math.ceil(dataM.clanWarsM.enemyClanScoreRatio * 1000) / 10 + "%");
         this.mcMedal1.visible = false;
         this.mcMedal2.visible = false;
         if(dataM.clanWarsM.currentPhase == BMClanWarsManager.WAR_PHASE_ROUND2)
         {
            if(dataM.clanWarsM.firstRoundWinner == BMClanWarsManager.ALIGNMENT_MY_CLAN)
            {
               this.mcMedal1.visible = true;
            }
            else
            {
               this.mcMedal2.visible = true;
            }
         }
      }
      
      private function createMechs() : void
      {
         this.mechsCreator = new BMClanWarEyeCandyMechs();
         this.mechsCreator.createMechs(this.mcMechsHolder1,this.mcMechsHolder2,this.mcMechsHolder3);
      }
      
      private function initButtons() : void
      {
         this.btnInspectDefence.addEventListener(BMIntractable.HIT,this.onInspectDefenceClicked);
         if(dataM.clanWarsM.didIJoin)
         {
            this.btnInspectOffence.visible = false;
            this.btnBattle.text = getSpecificText("raid_battle");
            this.btnBattle.subText = dataM.clanWarsM.attacksLeft + " / " + dataM.clanWarsM.attacksMax;
            this.btnBattle.addEventListener(BMIntractable.HIT,this.onBattleClicked);
         }
         else
         {
            this.btnBattle.visible = false;
            this.btnInspectOffence.text = getScreenText("spectate");
            this.btnInspectOffence.addEventListener(BMIntractable.HIT,this.onInspectOffenceClicked);
         }
      }
      
      private function onBattleClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.clanWarBaseClicked(BMClanWarsManager.ALIGNMENT_ENEMY_CLAN);
      }
      
      private function onInspectOffenceClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.clanWarBaseClicked(BMClanWarsManager.ALIGNMENT_ENEMY_CLAN);
      }
      
      private function onInspectDefenceClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.clanWarBaseClicked(BMClanWarsManager.ALIGNMENT_MY_CLAN);
      }
      
      private function initTimer() : void
      {
         this.mcTimer.initialize(dataM.clanWarsM.getPhaseSecLeft,this.onTimeEnd);
      }
      
      private function onTimeEnd() : void
      {
         screensM.screenClanMenu.refreshClanData();
      }
      
      private function initRewards() : void
      {
         if(dataM.clanWarsM.didIJoin == false)
         {
            this.mcReward.visible = false;
            return;
         }
         var _loc1_:uint = uint(dataM.clanWarsM.myPredictedLoseReward.clanCoins);
         var _loc2_:uint = uint(dataM.clanWarsM.myPredictedWinReward.clanCoins);
         var _loc3_:uint = dataM.clanWarsM.myPredictedLoseReward.boxes[0];
         var _loc4_:uint = dataM.clanWarsM.myPredictedWinReward.boxes[0];
         this.mcReward.initialize(_loc1_,_loc2_,_loc3_,_loc4_);
      }
      
      private function initTexts() : void
      {
         var _loc1_:String = getScreenText("currentRound");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%CURRENT%",dataM.clanWarsM.currentWarRound.toString());
         _loc1_ = dataM.replaceStringInText(_loc1_,"%MAX%",dataM.clanWarsM.maxWarRounds.toString());
         updateTextAndFormat(this.txtRound,_loc1_);
      }
      
      private function initClanOverviews() : void
      {
         var _loc1_:String = dataM.myProfile.clanData.name;
         var _loc2_:String = dataM.myProfile.leaderName;
         var _loc3_:uint = dataM.myProfile.clanData.ladderProgress;
         var _loc4_:String = dataM.myProfile.clanFlag;
         this.mcClanOverview1.initialize(_loc1_,_loc2_,_loc4_,_loc3_);
         _loc3_ = dataM.clanWarsM.enemyClanData.ladderProgress;
         _loc1_ = dataM.clanWarsM.enemyClanData.name;
         _loc2_ = dataM.clanWarsM.enemyClanData.leaderName;
         _loc4_ = dataM.clanWarsM.enemyClanData.flag;
         this.mcClanOverview2.initialize(_loc1_,_loc2_,_loc4_,_loc3_);
      }
      
      public function removeMe() : void
      {
         this.mechsCreator.removeMechs();
         screensM.removeScreen(BMScreensManager.SCR_CLAN_WAR_BATTLE);
      }
   }
}

