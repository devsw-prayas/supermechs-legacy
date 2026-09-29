package net.battleMechsMulti.screens.clan
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.clan.listRow.ClanBossLeaderboardListHeader;
   import net.battleMechsMulti.screens.clan.listRow.ClanBossLeaderboardListRow;
   import net.battleMechsMulti.screens.clan.listRow.ClanListRowDataForBossLeaderboard;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenClanBoss extends BMBaseScreen
   {
      
      public var mcFingerWheeling:Sprite;
      
      public var mcTileListHolder:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var getBattle:BMBasicButton;
      
      public var getTickets:BMBasicButton;
      
      public var mcBossLevel:MovieClip;
      
      public var txtBossName:TextField;
      
      public var txtTickets:TextField;
      
      public var txtBossHP:TextField;
      
      public var txtTimerTitle:TextField;
      
      public var mcBossThumb:RaidEnemyThumb;
      
      public var mcTimer:BMTimer;
      
      public var bossHPBar:BMBar;
      
      public var btnGetTickets:BMBasicButton;
      
      public var btnBattle:BMBasicButton;
      
      public var mcInactiveBlock:MovieClip;
      
      private var bossLeaderboardTileList:BMTileList;
      
      private var _selectedMemberSlot:Number;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private const MEMBERS_ITEM_WIDTH:uint = 703;
      
      private const MEMBERS_ITEM_HEIGHT:uint = 30;
      
      private const MEMBERS_ROWS:uint = 7;
      
      private const MEMBERS_ITEM_WIDTH_MOBILE:uint = 743;
      
      private const MEMBERS_ITEM_HEIGHT_MOBILE:uint = 33;
      
      private const MEMBERS_ROWS_MOBILE:uint = 6;
      
      public function BMScreenClanBoss()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clanBoss");
         this.initButtons();
         this.initBossPanel();
         this.addAndRefreshBossLeaderboardTileList();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function initButtons() : void
      {
         this.btnBattle.text = getSpecificText("missionDifficulty_battle") + " " + dataM.myProfile.clan_bossBattlesLeft + "/" + dataM.clanBossBattlesMax;
         this.btnGetTickets.text = getScreenText("getTickets");
         this.btnBattle.addEventListener(BMIntractable.HIT,this.onBattleClicked);
         this.btnGetTickets.addEventListener(BMIntractable.HIT,this.onGetTicketsClicked);
         if(dataM.runAsMobile)
         {
            this._fingerWheeling = new BMFingerWheeling();
            this._fingerWheeling.initialize("clanBoss",this.bossLeaderboardTileList,this.mcFingerWheeling,this.bossLeaderboardClicked,null,false);
            addChild(this._fingerWheeling);
         }
         else
         {
            this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
            this.mcFingerWheeling = null;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._fingerWheeling == null)
         {
            return;
         }
         this._fingerWheeling.onEnterFrameTrigger();
      }
      
      private function initBossPanel() : void
      {
         var _loc1_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc8_:BMTimer = null;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:String = null;
         this.btnGetTickets.visible = false;
         this.btnBattle.visible = false;
         if(dataM.myProfile.hasClanBoss == false)
         {
            updateTextAndFormat(this.mcInactiveBlock.txtTitle,getScreenText("nextBossWillArriveIn"));
            _loc8_ = this.mcInactiveBlock.mcTimer;
            _loc8_.initialize(this.timerProvider,this.onInactiveBossTimerEnded,0,true);
            return;
         }
         this.mcInactiveBlock.visible = false;
         _loc1_ = dataM.myProfile.clan_bossTickets;
         var _loc2_:uint = dataM.myProfile.clanBossData.ticketsRequired;
         var _loc3_:uint = dataM.myProfile.clanBossData.hpMax;
         var _loc4_:uint = dataM.myProfile.clanBossHP;
         _loc5_ = dataM.myProfile.isClanBossAlive;
         var _loc6_:Boolean = dataM.myProfile.clanHasEnoughBossTickets;
         var _loc7_:String = dataM.myProfile.clanBossData.name;
         this.mcBossLevel.gotoAndStop(dataM.myProfile.clanBossData.level);
         this.bossHPBar.initialize(BMBar.COLOR_YELLOW);
         this.bossHPBar.addSeparateorLines(5);
         updateTextAndFormat(this.txtBossName,_loc7_);
         if(_loc6_)
         {
            this.txtTickets.text = "";
            this.btnBattle.visible = true;
            if(_loc5_)
            {
               _loc9_ = TextUtils.getNumberWithComma(_loc4_) + " / " + TextUtils.getNumberWithComma(_loc3_);
               updateTextAndFormat(this.txtBossHP,_loc9_);
               _loc10_ = _loc4_ / _loc3_;
               this.bossHPBar.setFill(_loc10_);
            }
            else
            {
               updateTextAndFormat(this.txtBossHP,"<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>" + getScreenText("defeated"));
               this.bossHPBar.visible = false;
               this.btnBattle.disableMe();
            }
         }
         else
         {
            this.txtBossHP.text = "";
            this.bossHPBar.visible = false;
            _loc11_ = getScreenText("ticketsStatus");
            _loc11_ = dataM.replaceStringInText(_loc11_,"%AVAILABLE%",TextUtils.getNumberWithComma(_loc1_));
            _loc11_ = dataM.replaceStringInText(_loc11_,"%REQUIRED%",TextUtils.getNumberWithComma(_loc2_));
            updateTextAndFormat(this.txtTickets,_loc11_);
            this.btnGetTickets.visible = true;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("clanBoss_hp",[this.txtBossHP],"",this);
         }
         if(dataM.myProfile.isClanBossAlive == false && dataM.myProfile.isClanBossActive)
         {
            updateTextAndFormat(this.txtTimerTitle,getScreenText("collectRewardsIn"));
         }
         else
         {
            updateTextAndFormat(this.txtTimerTitle,getSpecificText("raid_timeLeft"));
         }
         this.mcTimer.initialize(this.timerProvider,this.onActiveBossTimerEnded,0,true);
         this.setBossMechThumb();
      }
      
      private function onInactiveBossTimerEnded() : void
      {
         this.timerEndedSub();
      }
      
      private function onActiveBossTimerEnded() : void
      {
         this.timerEndedSub();
      }
      
      private function timerEndedSub() : void
      {
         loginM.settingsUpdateRequired = true;
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT,3);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_CLAN,{"tab":BMScreenClanMenu.TAB_BOSS});
      }
      
      private function timerProvider() : uint
      {
         if(dataM.myProfile.hasClanBoss == false)
         {
            return dataM.myProfile.clanBossInactiveTimeLeft;
         }
         return dataM.myProfile.clanBossTimeLeft;
      }
      
      private function setBossMechThumb() : void
      {
         this.mcBossThumb.initialize_avatarThumb(dataM.myProfile.clanBossData.battleAvatar,dataM.myProfile.clanBossData.colorID,dataM.myProfile.clanBossData.themeID);
      }
      
      private function get clanBossCoinsToGoldRewardMultiplier() : Number
      {
         return Number(dataM.getGeneralSetting("clanBossCoinsToGoldRewardMultiplier","0"));
      }
      
      private function get useGoldReward() : Boolean
      {
         return this.clanBossCoinsToGoldRewardMultiplier > 0;
      }
      
      private function onBattleClicked(param1:Event) : void
      {
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT,0.3);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_CAMPAIGN_WORLD,{"storyID":0});
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT);
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WORLD_MAP_SELECT_CLAN_BOSS_MISSION);
      }
      
      private function onGetTicketsClicked(param1:Event) : void
      {
         var _loc2_:Array = dataM.singlePlayerM.getAvailableMissionWithMostClanBossTickets();
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(_loc2_ != null)
         {
            _loc3_ = uint(_loc2_[0]);
            _loc4_ = uint(_loc2_[1]);
            _loc5_ = uint(_loc2_[2]);
         }
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT,0.3);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_CAMPAIGN_WORLD,{"storyID":_loc3_});
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT);
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WORLD_MAP_SELECT_MISSION,0.3,{
            "missionSlot":_loc4_,
            "missionMode":_loc5_
         });
      }
      
      public function addAndRefreshBossLeaderboardTileList() : void
      {
         var _loc5_:uint = 0;
         var _loc7_:Object = null;
         var _loc11_:ClanBossLeaderboardListHeader = null;
         var _loc14_:BMClanMemberData = null;
         var _loc15_:uint = 0;
         var _loc16_:int = 0;
         var _loc17_:Object = null;
         var _loc18_:uint = 0;
         var _loc19_:String = null;
         var _loc20_:ClanBossLeaderboardListRow = null;
         var _loc21_:ClanListRowDataForBossLeaderboard = null;
         var _loc22_:String = null;
         var _loc23_:BMItem = null;
         var _loc24_:BMTileListItem = null;
         var _loc25_:Function = null;
         if(this.bossLeaderboardTileList == null)
         {
            this.bossLeaderboardTileList = new BMTileList();
         }
         else
         {
            this.bossLeaderboardTileList.removeAllItems();
         }
         var _loc1_:Array = new Array();
         var _loc2_:uint = this.MEMBERS_ROWS;
         var _loc3_:uint = this.MEMBERS_ITEM_WIDTH;
         var _loc4_:uint = this.MEMBERS_ITEM_HEIGHT;
         if(dataM.runAsMobile)
         {
            _loc2_ = this.MEMBERS_ROWS_MOBILE;
            _loc3_ = this.MEMBERS_ITEM_WIDTH_MOBILE;
            _loc4_ = this.MEMBERS_ITEM_HEIGHT_MOBILE;
         }
         var _loc6_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < dataM.myProfile.clanMembers)
         {
            _loc14_ = dataM.myProfile.clanData.members[_loc5_];
            _loc15_ = _loc14_.clanPointsWinPrize;
            if(dataM.myProfile.clan_bossHP > 0)
            {
               _loc15_ = _loc14_.clanPointsLosePrize;
            }
            _loc16_ = -1;
            if(this.useGoldReward)
            {
               _loc16_ = Math.ceil(_loc15_ * this.clanBossCoinsToGoldRewardMultiplier);
            }
            _loc7_ = {
               "type":"member",
               "playerID":_loc14_.playerID,
               "name":_loc14_.name,
               "level":_loc14_.level,
               "ladderProgress":_loc14_.ladderProgress,
               "tickets":_loc14_.bossTickets,
               "damage":_loc14_.bossDamage,
               "prize_clanCoins":_loc15_,
               "prize_gold":_loc16_
            };
            _loc6_.push(_loc7_);
            _loc5_++;
         }
         _loc6_.sortOn(["prize_clanCoins","damage"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING]);
         var _loc8_:Boolean = dataM.myProfile.clanBossData.ticketsRequired == 0;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc17_ = _loc6_[_loc5_];
            _loc18_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc17_.ladderProgress));
            _loc19_ = _loc17_.geo;
            _loc20_ = new mcClanBossLeaderboardRow();
            _loc21_ = new ClanListRowDataForBossLeaderboard(_loc17_.level,_loc17_.name,_loc18_,_loc19_,_loc17_.tickets,_loc17_.damage,_loc17_.prize_clanCoins,_loc17_.prize_gold,_loc8_);
            _loc20_.initialize(_loc21_);
            _loc22_ = screensM.screenClanMenu.getMemberRowBackground(this._selectedMemberSlot,_loc20_,_loc17_,_loc5_);
            _loc20_.setBackground(_loc22_);
            _loc23_ = new BMItem();
            _loc23_.initialize(_loc17_.playerID,_loc3_,_loc4_,_loc20_,0,0,false,null,dataM.runAsMobile);
            _loc24_ = new BMTileListItem();
            _loc25_ = this.bossLeaderboardClicked;
            if(dataM.runAsMobile)
            {
               _loc25_ = null;
            }
            _loc24_.initialize(_loc3_,_loc4_,_loc23_,"","","",0,_loc25_,null,null,null,null,dataM.runAsMobile);
            _loc1_.push(_loc24_);
            _loc5_++;
         }
         var _loc9_:Boolean = false;
         if(dataM.runAsMobile)
         {
            _loc9_ = true;
            this.bossLeaderboardTileList.activateExtendedMode(0.35,true);
         }
         var _loc10_:MovieClip = new Grp_scrollerContent();
         if(dataM.runAsMobile)
         {
            _loc11_ = new mcClanBossLeaderboardHeader_mobile();
         }
         else
         {
            _loc11_ = new mcClanBossLeaderboardHeader();
         }
         var _loc12_:String = getScreenText("winPrize");
         if(dataM.myProfile.isClanBossActive == false && dataM.myProfile.clan_bossHP > 0)
         {
            _loc12_ = getSpecificText("raid_prizeCaps");
         }
         var _loc13_:String = "";
         if(_loc8_ == false)
         {
            _loc13_ = getScreenText("tickets");
         }
         _loc11_.initialize(getGeneralText("levelCaps"),getGeneralText("nameCaps"),_loc13_,getScreenText("damage"),_loc12_);
         this.bossLeaderboardTileList.initialize(screensM.clientPointer.stage,_loc1_,_loc2_,1,_loc3_,_loc4_,null,true,_loc10_,null,_loc11_,false,-1,1,true,_loc9_,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            this.bossLeaderboardTileList.x = this.mcSizer_tileList.x - 4;
         }
         else
         {
            this.bossLeaderboardTileList.x = this.mcSizer_tileList.x;
         }
         this.bossLeaderboardTileList.y = this.mcSizer_tileList.y;
         this.mcTileListHolder.addChild(this.bossLeaderboardTileList);
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this.bossLeaderboardTileList);
            this._fingerWheeling.addMouseListeners();
         }
      }
      
      private function bossLeaderboardClicked(param1:Number, param2:Number) : void
      {
      }
      
      public function resetSelectedMemberSlot() : void
      {
         this._selectedMemberSlot = -1;
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      public function inspectClicked() : void
      {
         screensM.screenClanMenu.inspectPlayer(this._selectedMemberSlot);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CLAN_BOSS);
      }
   }
}

