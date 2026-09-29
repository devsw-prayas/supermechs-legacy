package net.battleMechsMulti.screens.raid
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.missionDifficulty.MissionReward;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenRaidBattle extends BMBaseScreen
   {
      
      public static const RAID_DAYS:uint = 6;
      
      public var mcReward1:MissionReward;
      
      public var mcReward2:MissionReward;
      
      public var mcReward3:MissionReward;
      
      public var mcReward4:MissionReward;
      
      public var mcDay1:RaidDayTitle;
      
      public var mcDay2:RaidDayTitle;
      
      public var mcDay3:RaidDayTitle;
      
      public var mcDay4:RaidDayTitle;
      
      public var mcDay5:RaidDayTitle;
      
      public var mcDay6:RaidDayTitle;
      
      public var btnMechBuilds:BMBasicButton;
      
      public var btnBattle:BMBasicButton;
      
      public var btnBattle_short:BMBasicButton;
      
      public var btnBattle2v2And3v3:BMBasicButton;
      
      public var btnBattle2v2And3v3_short:BMBasicButton;
      
      public var txtScore:TextField;
      
      public var txtRewards:TextField;
      
      public var txtTimeLeftTitle:TextField;
      
      public var txtPlayerCurrentDay:TextField;
      
      public var mcTimer:BMTimer;
      
      public var mcEnemyThumbsHolder:MovieClip;
      
      private var _rewards:uint;
      
      private const MAX_REWARD_ROWS:uint = 4;
      
      private const MAX_ENEMIES:uint = 4;
      
      public function BMScreenRaidBattle()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("raid");
         this.initButtons();
         this.initRewards();
         this.refreshTierAndScore();
         this.initTimeLeft();
         this.initEnemyThumbs();
         this.initDays();
      }
      
      private function initDays() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:RaidDayTitle = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = this.mcDay1.FRAME_NOT_CURRENT;
            if(_loc1_ == dataM.raidData.currentLevel)
            {
               _loc2_ = this.mcDay1.FRAME_CURRENT;
            }
            _loc3_ = this.mcDay1.FILL_LOCKED;
            if(_loc1_ == dataM.raidData.currentLevel && dataM.raidData.missionStatus == BMSinglePlayerManager.MAP_PROGRESS_INCOMPLETE)
            {
               _loc3_ = this.mcDay1.FILL_CURRENT;
            }
            else if(_loc1_ <= dataM.raidData.currentLevel)
            {
               _loc3_ = this.mcDay1.FILL_COMPLETED;
            }
            _loc4_ = _loc1_ + 1;
            _loc5_ = this["mcDay" + _loc4_];
            _loc5_.initialize(_loc4_,_loc2_,_loc3_);
            _loc1_++;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc2_:RaidEnemyThumb = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= this.MAX_ENEMIES)
         {
            _loc2_ = this.mcEnemyThumbsHolder["mcEnemyThumb" + _loc1_];
            _loc2_.triggerMech();
            _loc1_++;
         }
      }
      
      private function initEnemyThumbs() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:RaidEnemyThumb = null;
         var _loc5_:BMMechViewManualColors = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Boolean = false;
         var _loc9_:Vector.<BMMechStructure> = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:BMMechStructure = null;
         var _loc14_:String = null;
         var _loc1_:uint = dataM.raidData.previewEnemiesCount.length;
         var _loc4_:uint = 0;
         _loc2_ = 1;
         while(_loc2_ <= _loc1_)
         {
            _loc5_ = new BMMechViewManualColors();
            if(_loc2_ < _loc1_)
            {
               _loc5_.setSpecificColorForAll(dataM.raidData.getEnemiesColor());
            }
            else
            {
               _loc5_ = null;
            }
            _loc3_ = this.mcEnemyThumbsHolder["mcEnemyThumb" + _loc2_];
            _loc6_ = uint(dataM.raidData.previewEnemiesCount[_loc2_ - 1]);
            _loc7_ = dataM.raidData.themeID;
            _loc8_ = _loc2_ == _loc1_;
            _loc9_ = new Vector.<BMMechStructure>();
            _loc10_ = (_loc2_ - 1) * dataM.raidData.mechsPerPlayer;
            _loc11_ = _loc10_ + dataM.raidData.mechsPerPlayer;
            _loc12_ = _loc10_;
            while(_loc12_ < _loc11_)
            {
               _loc13_ = dataM.raidData.previewMechStructures[_loc4_];
               _loc9_.push(_loc13_);
               _loc4_++;
               _loc12_++;
            }
            _loc3_.initialize_mechView(_loc9_,_loc5_,_loc6_,_loc7_,_loc8_);
            _loc2_++;
         }
         if(_loc1_ >= this.MAX_ENEMIES)
         {
            return;
         }
         _loc2_ = _loc1_ + 1;
         while(_loc2_ <= this.MAX_ENEMIES)
         {
            _loc14_ = "mcEnemyThumb" + _loc2_;
            _loc3_ = this.mcEnemyThumbsHolder[_loc14_];
            if(_loc3_.parent != null)
            {
               this.mcEnemyThumbsHolder[_loc14_].parent.removeChild(this.mcEnemyThumbsHolder[_loc14_]);
            }
            _loc2_++;
         }
         this.mcEnemyThumbsHolder.x = (dataM.STAGE_WIDTH - this.mcEnemyThumbsHolder.width) / 2;
      }
      
      private function refreshTierAndScore() : void
      {
         var _loc2_:String = null;
         updateTextAndFormat(this.txtPlayerCurrentDay,getScreenText("tierCaps"));
         var _loc1_:uint = dataM.raidData.currentLevelHighestScore;
         if(_loc1_ == 0)
         {
            this.txtScore.text = "";
         }
         else
         {
            _loc2_ = getScreenText("todaysBestScore");
            _loc2_ = dataM.replaceStringInText(_loc2_,"%SCORE%","<FONT COLOR=\'#00FFFF\'>" + TextUtils.getNumberWithComma(_loc1_));
            updateTextAndFormat(this.txtScore,_loc2_);
         }
      }
      
      private function initButtons() : void
      {
         this.btnBattle.addEventListener(BMIntractable.HIT,this.battleClicked);
         this.btnBattle_short.addEventListener(BMIntractable.HIT,this.battleClicked);
         this.btnBattle2v2And3v3.addEventListener(BMIntractable.HIT,this.battleClicked);
         this.btnBattle2v2And3v3_short.addEventListener(BMIntractable.HIT,this.battleClicked);
         this.btnMechBuilds.addEventListener(BMIntractable.HIT,this.mechBuildsClicked);
         switch(dataM.raidData.missionStatus)
         {
            case BMSinglePlayerManager.MAP_PROGRESS_COMPLETE:
               this.btnBattle.text = getScreenText("replay");
               this.btnBattle_short.text = getScreenText("replay");
               this.btnBattle2v2And3v3.text = getScreenText("replay");
               this.btnBattle2v2And3v3_short.text = getScreenText("replay");
               break;
            case BMSinglePlayerManager.MAP_PROGRESS_INCOMPLETE:
               this.btnBattle.text = getScreenText("battle");
               this.btnBattle_short.text = getScreenText("battle");
               this.btnBattle2v2And3v3.text = getScreenText("battle");
               this.btnBattle2v2And3v3_short.text = getScreenText("battle");
         }
         if(dataM.mechBuildsM.isEnabled)
         {
            this.btnBattle.visible = false;
            this.btnBattle2v2And3v3.visible = false;
         }
         else
         {
            this.btnMechBuilds.visible = false;
            this.btnBattle_short.visible = false;
            this.btnBattle2v2And3v3_short.visible = false;
         }
         if(dataM.raidData.mechsPerPlayer == 1)
         {
            if(dataM.mechBuildsM.isEnabled)
            {
               this.btnBattle2v2And3v3_short.visible = false;
            }
            else
            {
               this.btnBattle2v2And3v3.visible = false;
            }
         }
         else if(dataM.mechBuildsM.isEnabled)
         {
            this.btnBattle_short.visible = false;
            this.btnBattle2v2And3v3_short.subText = dataM.raidData.mechsPerPlayer + " vs " + dataM.raidData.mechsPerPlayer;
         }
         else
         {
            this.btnBattle.visible = false;
            this.btnBattle2v2And3v3.subText = dataM.raidData.mechsPerPlayer + " vs " + dataM.raidData.mechsPerPlayer;
         }
      }
      
      private function mechBuildsClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.mechBuildsClicked(dataM.raidData.mechsPerPlayer);
         screensM.screenTransitionsManager.cameFromRaid = true;
      }
      
      private function battleClicked(param1:Event) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(dataM.areMechsReadyForBattle(dataM.raidData.mechsPerPlayer) == false)
         {
            _loc3_ = 0;
            _loc4_ = 1;
            while(_loc4_ <= dataM.raidData.mechsPerPlayer)
            {
               if(dataM.isMechReadyForBattle(_loc4_,dataM.player1PlayerID) == false)
               {
                  _loc3_ = _loc4_;
                  break;
               }
               _loc4_++;
            }
            if(_loc3_ > 0)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",_loc3_);
            }
            return;
         }
         var _loc2_:String = dataM.myPlayerData.isBlockedFromPlayingInCompetitveBattles(dataM.raidData.mechsPerPlayer);
         if(_loc2_ != null)
         {
            screensM.screenConfirmation.displayQuestionOrNotification(_loc2_);
            return;
         }
         screensM.screenRaidMenu.enterRaidClicked();
      }
      
      private function initRewards() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MissionReward = null;
         if(dataM.raidData.currentLevelHighestScore > 0)
         {
            this.txtRewards.text = "";
            _loc1_ = 1;
            while(_loc1_ <= this.MAX_REWARD_ROWS)
            {
               _loc2_ = this["mcReward" + _loc1_];
               _loc2_.visible = false;
               _loc1_++;
            }
            return;
         }
         updateTextAndFormat(this.txtRewards,getScreenText("firstClearRewards"));
         this._rewards = 0;
         this.addRewardRowIfNeeded("gold",dataM.raidData.reward.gold);
         this.addRewardRowIfNeeded("tokens",dataM.raidData.reward.tokens);
         this.addRewardRowIfNeeded("xp",dataM.raidData.reward.xp);
         this.addRewardRowIfNeeded("boxes",int(dataM.raidData.reward.hasBoxes));
         if(this._rewards < this.MAX_REWARD_ROWS)
         {
            _loc1_ = this._rewards + 1;
            while(_loc1_ <= this.MAX_REWARD_ROWS)
            {
               _loc2_ = this["mcReward" + _loc1_];
               _loc2_.visible = false;
               _loc1_++;
            }
         }
      }
      
      private function addRewardRowIfNeeded(param1:String, param2:uint) : *
      {
         if(this._rewards >= this.MAX_REWARD_ROWS)
         {
            return;
         }
         if(param2 == 0)
         {
            return;
         }
         ++this._rewards;
         var _loc3_:MissionReward = this["mcReward" + this._rewards];
         _loc3_.text = TextUtils.getNumberWithComma(param2);
         _loc3_.setIconByType(param1);
      }
      
      private function initTimeLeft() : void
      {
         var _loc1_:String = getScreenText("timeLeft");
         if(dataM.raidData.missionStatus == BMSinglePlayerManager.MAP_PROGRESS_COMPLETE)
         {
            _loc1_ = getScreenText("nextRaid");
         }
         updateTextAndFormat(this.txtTimeLeftTitle,_loc1_);
         this.mcTimer.initialize(dataM.questsManager.getDailyQuestsSecLeft,this.onTimeEnd);
      }
      
      private function onTimeEnd() : void
      {
      }
      
      private function closeClicked(param1:Event) : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_RAID_BATTLE);
      }
   }
}

