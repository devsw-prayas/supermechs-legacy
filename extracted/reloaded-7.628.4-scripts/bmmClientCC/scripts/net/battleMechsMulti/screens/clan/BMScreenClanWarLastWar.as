package net.battleMechsMulti.screens.clan
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenClanWarLastWar extends BMBaseScreen
   {
      
      public var btnClose:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var txtScore1_1:TextField;
      
      public var txtScore1_2:TextField;
      
      public var txtScore1_3:TextField;
      
      public var txtScore2_1:TextField;
      
      public var txtScore2_2:TextField;
      
      public var txtScore2_3:TextField;
      
      public var txtRound1:TextField;
      
      public var txtRound2:TextField;
      
      public var txtFinalScore:TextField;
      
      public var txtResult:TextField;
      
      public var mcScoreBar1_1:BMBar;
      
      public var mcScoreBar1_2:BMBar;
      
      public var mcScoreBar1_3:BMBar;
      
      public var mcScoreBar2_1:BMBar;
      
      public var mcScoreBar2_2:BMBar;
      
      public var mcScoreBar2_3:BMBar;
      
      public var mcClanOverview1:BMClanOverview;
      
      public var mcClanOverview2:BMClanOverview;
      
      public var mcResultLight:MovieClip;
      
      public function BMScreenClanWarLastWar()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clanWar");
         this.setButtons();
         this.initTexts();
         this.initClanOverviews();
         this.initScoreBars();
      }
      
      private function initTexts() : void
      {
         updateTextAndFormat(this.txtTitle,getScreenText("lastWar"));
         var _loc1_:String = getScreenText("roundX");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%ROUND%","1");
         updateTextAndFormat(this.txtRound1,_loc1_);
         _loc1_ = getScreenText("roundX");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%ROUND%","2");
         updateTextAndFormat(this.txtRound2,_loc1_);
         updateTextAndFormat(this.txtFinalScore,getScreenText("finalScore"));
         if(dataM.clanWarsM.lastClanWarInfo.myClanWon)
         {
            updateTextAndFormat(this.txtResult,"<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + getScreenText("victory"));
            this.mcResultLight.gotoAndStop("victory");
         }
         else
         {
            updateTextAndFormat(this.txtResult,"<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>" + getScreenText("loss"));
            this.mcResultLight.gotoAndStop("loss");
         }
      }
      
      private function initClanOverviews() : void
      {
         var _loc1_:String = dataM.myProfile.clanData.name;
         var _loc2_:String = dataM.myProfile.leaderName;
         var _loc3_:uint = dataM.myProfile.clanData.ladderProgress;
         var _loc4_:String = dataM.myProfile.clanFlag;
         this.mcClanOverview1.initialize(_loc1_,_loc2_,_loc4_,_loc3_);
         _loc3_ = dataM.clanWarsM.lastClanWarInfo.enemyClanLadderProgress;
         _loc1_ = dataM.clanWarsM.lastClanWarInfo.enemyClanName;
         _loc2_ = dataM.clanWarsM.lastClanWarInfo.enemyClanLeaderName;
         _loc4_ = dataM.clanWarsM.lastClanWarInfo.enemyClanFlag;
         this.mcClanOverview2.initialize(_loc1_,_loc2_,_loc4_,_loc3_);
      }
      
      private function initScoreBars() : void
      {
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= 2)
         {
            _loc5_ = 1;
            while(_loc5_ <= 3)
            {
               _loc6_ = "right";
               if(_loc1_ == 2)
               {
                  _loc6_ = "left";
               }
               this["mcScoreBar" + _loc1_ + "_" + _loc5_].initialize(BMBar.COLOR_BLUE,_loc6_);
               this["mcScoreBar" + _loc1_ + "_" + _loc5_].addSeparateorLines(4);
               _loc5_++;
            }
            _loc1_++;
         }
         var _loc2_:uint = 0;
         var _loc3_:Number = dataM.clanWarsM.lastClanWarInfo.myClanAttackScores[_loc2_] / dataM.clanWarsM.lastClanWarInfo.enemyClanTeamsTotalScore;
         updateTextAndFormat(this.txtScore1_1,this.getPercentageText(_loc3_));
         this.mcScoreBar1_1.setFill(_loc3_);
         _loc3_ = dataM.clanWarsM.lastClanWarInfo.enemyClanAttackScores[_loc2_] / dataM.clanWarsM.lastClanWarInfo.myClanTeamsTotalScore;
         updateTextAndFormat(this.txtScore2_1,this.getPercentageText(_loc3_));
         this.mcScoreBar2_1.setFill(_loc3_);
         _loc2_ = 1;
         _loc3_ = dataM.clanWarsM.lastClanWarInfo.myClanAttackScores[_loc2_] / dataM.clanWarsM.lastClanWarInfo.enemyClanTeamsTotalScore;
         updateTextAndFormat(this.txtScore1_2,this.getPercentageText(_loc3_));
         this.mcScoreBar1_2.setFill(_loc3_);
         _loc3_ = dataM.clanWarsM.lastClanWarInfo.enemyClanAttackScores[_loc2_] / dataM.clanWarsM.lastClanWarInfo.myClanTeamsTotalScore;
         updateTextAndFormat(this.txtScore2_2,this.getPercentageText(_loc3_));
         this.mcScoreBar2_2.setFill(_loc3_);
         _loc3_ = (dataM.clanWarsM.lastClanWarInfo.myClanAttackScores[0] + dataM.clanWarsM.lastClanWarInfo.myClanAttackScores[1]) / dataM.clanWarsM.lastClanWarInfo.enemyClanTeamsTotalScore / 2;
         updateTextAndFormat(this.txtScore1_3,this.getPercentageText(_loc3_));
         this.mcScoreBar1_3.setFill(_loc3_);
         var _loc4_:Number = (dataM.clanWarsM.lastClanWarInfo.enemyClanAttackScores[0] + dataM.clanWarsM.lastClanWarInfo.enemyClanAttackScores[1]) / dataM.clanWarsM.lastClanWarInfo.myClanTeamsTotalScore / 2;
         updateTextAndFormat(this.txtScore2_3,this.getPercentageText(_loc4_));
         this.mcScoreBar2_3.setFill(_loc4_);
      }
      
      private function getPercentageText(param1:Number) : String
      {
         param1 *= 1000;
         param1 = Math.round(param1);
         param1 /= 10;
         return param1.toString() + "%";
      }
      
      private function setButtons() : void
      {
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClicked);
      }
      
      private function onCloseClicked(param1:Event) : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CLAN_WAR_LAST_WAR);
      }
   }
}

