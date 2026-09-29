package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMClanRankingListData;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMPlayerRankingListData;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol560")]
   public class BMScreenRankingList extends BMBaseScreen
   {
      
      public var mcMainHolder:MovieClip;
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcButtonMarker:Sprite;
      
      public var mcShowOnline:MovieClip;
      
      public var mcSizer_btnPlayers:Sprite;
      
      public var mcSizer_btnClans:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnPlayers:BMButton;
      
      public var btnClans:BMButton;
      
      public var mcSizer_rankingTileList:MovieClip;
      
      public var txtTitle:TextField;
      
      public var txtCountdown:TextField;
      
      public var txtTopClanReward:TextField;
      
      public var mcPlayersRewards:MovieClip;
      
      public var mcSandClock:MovieClip;
      
      public var btnBack:BMButton_pictureE;
      
      private var rankingTileList:BMTileList;
      
      private var mcLevelRank:MovieClip;
      
      private var rankingListTimer:Timer;
      
      public var rankingListEnabled:Boolean = true;
      
      private var _weeklyCountdown:Timer;
      
      private var _rankingType:String = "playersWeekly";
      
      private var _tileListLastDataType:String = "players";
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _lastCountText:String = "xxxx";
      
      private var _clansForSearch:Object;
      
      private var _titleInitialYPos:Number;
      
      public var clanRewardItems:Array = new Array();
      
      private var _minuteLength:Number;
      
      private var _hourLength:Number;
      
      private var _dayLength:Number;
      
      private var _firstRefresh:Boolean = true;
      
      private const RANKING_LIST_ROW_WIDTH:uint = 725;
      
      private const RANKING_LIST_PLAYERS_ROW_HEIGHT:uint = 30;
      
      private const RANKING_LIST_PLAYERS_ROWS:uint = 10;
      
      private const RANKING_LIST_CLANS_ROW_HEIGHT:uint = 43;
      
      private const RANKING_LIST_CLANS_ROWS:uint = 7;
      
      private const RANKING_LIST_ROW_WIDTH_MOBILE:uint = 767;
      
      private const RANKING_LIST_PLAYERS_ROW_HEIGHT_MOBILE:uint = 32;
      
      private const RANKING_LIST_PLAYERS_ROWS_MOBILE:uint = 9;
      
      private const RANKING_LIST_CLANS_ROW_HEIGHT_MOBILE:uint = 47;
      
      private const RANKING_LIST_CLANS_ROWS_MOBILE:uint = 6;
      
      private const RANKING_LIST_CALL_COOLDOWN:Number = 600;
      
      public function BMScreenRankingList()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("rankingList");
      }
      
      private function createTitleBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("rankingList_title",[this.txtTitle],"",this);
         }
      }
      
      private function createPlayersRewardsBitmapForMobile() : void
      {
         var _loc1_:Array = null;
         if(dataM.runAsMobile)
         {
            _loc1_ = [this.mcPlayersRewards.txtTopPlayersRewards,this.mcPlayersRewards.txt1A,this.mcPlayersRewards.txt1B,this.mcPlayersRewards.txt2A,this.mcPlayersRewards.txt2B,this.mcPlayersRewards.txt3A,this.mcPlayersRewards.txt3B];
            screensM.createMultipleTextsBitmap("rankingList_playersRewards",_loc1_,"",this.mcPlayersRewards);
         }
      }
      
      private function createCountdownBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            if(this._lastCountText != this.txtCountdown.text)
            {
               this._lastCountText = this.txtCountdown.text;
               screensM.createMultipleTextsBitmap("rankingList_countdown",[this.txtCountdown],"",this);
            }
         }
      }
      
      public function refreshScreen() : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenRankingList","btnPlayers","regular");
            screensM.createButtonFromSizer("screenRankingList","btnClans","regular");
            screensM.createButtonFromSizer("screenRankingList","btnBack","pictureE");
            _loc2_ = this.playersClicked;
            _loc3_ = this.clansClicked;
            _loc4_ = 34;
            _loc5_ = 34;
            switch(dataM.languageID)
            {
               case 10:
                  _loc4_ = 29;
                  _loc5_ = 27;
            }
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
            }
            this.btnPlayers.changeFontSize(_loc4_);
            this.btnClans.changeFontSize(_loc4_);
            this.btnPlayers.initialize(getScreenText("playersWeekly"),"blue",null,[],_loc2_,dataM.runAsMobile);
            this.btnClans.initialize(getScreenText("clans"),"blue",null,[],_loc3_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnPlayers.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnClans.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this.createTitleBitmapForMobile();
            this.createPlayersRewardsBitmapForMobile();
            dataM.callingRankingListEnabled = true;
            this._titleInitialYPos = this.txtTitle.y;
            this._minuteLength = 60;
            this._hourLength = this._minuteLength * 60;
            this._dayLength = this._hourLength * 24;
            if(!dataM.runAsMobile)
            {
               this.mcShowOnline.addEventListener(MouseEvent.CLICK,this.showOnlineClicked);
            }
            if(dataM.runAsMobile)
            {
               this._fingerWheeling = new BMFingerWheeling();
               this._fingerWheeling.initialize("rankingList",this.rankingTileList,this.mcFingerWheeling,this.rankingListItemClicked,null,false);
               addChild(this._fingerWheeling);
            }
            else
            {
               this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
               this.mcFingerWheeling = null;
            }
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         if(dataM.resetRankingListTimer)
         {
            this.resetRankingListTimer();
            dataM.resetRankingListTimer = false;
         }
         this.getRankingList();
         this.btnPlayers.visible = true;
         this.btnClans.visible = true;
         var _loc1_:Boolean = false;
         if(dataM.rankingList_gettingBackToRankingListFromAReplay)
         {
            dataM.rankingList_gettingBackToRankingListFromAReplay = false;
            if(this._rankingType == "playersWeekly" || this._rankingType == "playersOnline")
            {
               _loc1_ = true;
            }
         }
         if(_loc1_)
         {
            this.playersClickedSub();
         }
         else
         {
            this.clansClickedSub();
         }
         if(dataM.rankingList_weekly == null)
         {
            this.mcSandClock.gotoAndStop("animOn");
            this.btnPlayers.disableMe();
            this.btnClans.disableMe();
         }
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.addMouseListeners();
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = 15;
            _loc3_ = 15;
            _loc4_ = 15;
            _loc5_ = 15;
            switch(dataM.languageID)
            {
               case 3:
                  _loc2_ = 13;
                  _loc3_ = 16;
                  _loc4_ = 15;
                  _loc5_ = 20;
                  this.mcPlayersRewards.txt1A.text = "1)";
                  break;
               case 10:
                  _loc2_ = 13;
                  break;
               default:
                  this.mcPlayersRewards.txt1A.text = "1 )";
            }
            TextUtils.updateTextFormat(this.txtCountdown,17);
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtTopClanReward,_loc3_);
            TextUtils.updateTextFormat(this.btnClans.txtButtonName);
            TextUtils.updateTextFormat(this.btnPlayers.txtButtonName);
            TextUtils.updateTextFormat(this.mcShowOnline.txtShowOnline,_loc2_);
            TextUtils.updateTextFormat(this.mcPlayersRewards.txt1A,_loc5_);
            TextUtils.updateTextFormat(this.mcPlayersRewards.txt1B,_loc5_);
            TextUtils.updateTextFormat(this.mcPlayersRewards.txt2A,_loc5_);
            TextUtils.updateTextFormat(this.mcPlayersRewards.txt2B,_loc5_);
            TextUtils.updateTextFormat(this.mcPlayersRewards.txt3A,_loc5_);
            TextUtils.updateTextFormat(this.mcPlayersRewards.txt3B,_loc5_);
            TextUtils.updateTextFormat(this.mcPlayersRewards.txtTopPlayersRewards,_loc4_);
            param1 = true;
         }
         if(param1)
         {
            _loc6_ = 34;
            _loc7_ = 34;
            switch(dataM.languageID)
            {
               case 10:
                  _loc6_ = 29;
                  _loc7_ = 27;
            }
            this.btnPlayers.changeFontSize(_loc6_);
            this.btnClans.changeFontSize(_loc6_);
            this.btnPlayers.setButtonName(getScreenText("playersWeekly"));
            this.btnClans.setButtonName(getScreenText("clans"));
         }
         this.createTitleBitmapForMobile();
         this.mcPlayersRewards.txtTopPlayersRewards.text = getScreenText("topPlayersRewards");
         this.txtTopClanReward.text = getScreenText("topClanReward");
         this.mcShowOnline.txtShowOnline.text = getScreenText("showOnline");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("rankingList_showOnline",[this.mcShowOnline.txtShowOnline],"",this.mcShowOnline);
         }
      }
      
      public function lockScreen(param1:Boolean) : void
      {
         if(param1)
         {
            this.rankingListEnabled = false;
         }
         else
         {
            this.rankingListEnabled = true;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(screensM.isScreenOpened("screenRankingList"))
         {
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.onEnterFrameTrigger();
            }
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      public function playersClicked() : void
      {
         if(this._rankingType != "playersWeekly" && this._rankingType != "playersOnline")
         {
            this.playersClickedSub();
         }
      }
      
      private function playersClickedSub() : void
      {
         this.mcButtonMarker.visible = true;
         this.mcButtonMarker.x = this.btnPlayers.x;
         this.mcButtonMarker.y = this.btnPlayers.y;
         this._rankingType = "playersWeekly";
         this.activateWeeklyCountdown();
         this.txtTitle.text = getScreenText("titleWeekly");
         this.txtTitle.y = this._titleInitialYPos;
         this.createTitleBitmapForMobile();
         this.getRankingListSuccess("playersClicked");
         this.mcPlayersRewards.visible = true;
         this.mcShowOnline.visible = true;
         this.mcShowOnline.mcV.visible = false;
         this.removeTopClanReward();
      }
      
      private function showOnlineClicked(param1:MouseEvent) : void
      {
         this.showOnlineClickedSub();
      }
      
      public function showOnlineClickedSub() : void
      {
         if(this.mcShowOnline.mcV.visible)
         {
            this.mcShowOnline.mcV.visible = false;
            this.playersClickedSub();
         }
         else
         {
            this.mcShowOnline.mcV.visible = true;
            this.onlineClicked();
         }
         soundM.createSound("buttonClick",1);
      }
      
      public function onlineClicked() : void
      {
         this._rankingType = "playersOnline";
         this.activateWeeklyCountdown();
         this.getRankingListSuccess("onlineClicked");
         this.mcPlayersRewards.visible = true;
         this.removeTopClanReward();
      }
      
      public function clansClicked() : void
      {
         if(this._rankingType != "clans")
         {
            this.clansClickedSub();
         }
      }
      
      private function clansClickedSub() : void
      {
         this._rankingType = "clans";
         this.displayClanRewardItems();
         this.txtTitle.text = getScreenText("titleClans");
         this.txtTitle.y = this._titleInitialYPos;
         this.mcButtonMarker.visible = true;
         this.mcButtonMarker.x = this.btnClans.x;
         this.mcButtonMarker.y = this.btnClans.y;
         this.activateWeeklyCountdown();
         this.createTitleBitmapForMobile();
         this.getRankingListSuccess("clansClicked");
         this.mcPlayersRewards.visible = false;
         this.mcShowOnline.visible = false;
      }
      
      public function clansAroundMyLadderProgressLoaded() : void
      {
         screensM.removeScreen("screenConfirmation");
         this.clansClickedSub();
      }
      
      private function removeTopClanReward() : void
      {
         this.removeClanRewardItems();
         this.txtTopClanReward.visible = false;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("rankingList_topClanReward",[this.txtTopClanReward],"",this);
         }
      }
      
      private function displayClanRewardItems() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:BMTileListItem = null;
         if(dataM.weeklyTopClanRewards.length > 0)
         {
            this.txtTopClanReward.visible = true;
         }
         else
         {
            this.txtTopClanReward.visible = false;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("rankingList_topClanReward",[this.txtTopClanReward],"",this);
         }
         this.removeClanRewardItems();
         this.clanRewardItems = new Array();
         var _loc1_:uint = dataM.REWARD_TILE_LIST_ITEM_SIZE;
         if(dataM.runAsMobile)
         {
            _loc1_ = dataM.REWARD_TILE_LIST_ITEM_SIZE_MOBILE;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < dataM.weeklyTopClanRewards.length)
         {
            _loc3_ = Number(dataM.weeklyTopClanRewards[_loc2_]);
            _loc4_ = this.rewardItemMouseOver;
            _loc5_ = this.rewardItemMouseOut;
            if(dataM.runAsMobile)
            {
               _loc4_ = null;
               _loc5_ = null;
            }
            _loc6_ = dataM.createShopTileListItem_basedOnItemID(_loc3_,"reward",null,null,null,_loc4_,_loc5_,true);
            _loc6_.x = 590 + _loc2_ * (_loc1_ + 8);
            _loc6_.y = 41;
            addChild(_loc6_);
            this.clanRewardItems.push(_loc6_);
            _loc2_++;
         }
      }
      
      private function rewardItemMouseOver(param1:Number, param2:Number) : void
      {
         tooltip.showToolTip("newsItem","",param2,-1);
      }
      
      private function rewardItemMouseOut(param1:Number, param2:Number) : void
      {
         tooltip.hideToolTip();
      }
      
      private function removeClanRewardItems() : void
      {
         var _loc2_:BMTileListItem = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.clanRewardItems.length)
         {
            _loc2_ = this.clanRewardItems[_loc1_];
            _loc2_.removeMe();
            this.clanRewardItems[_loc1_] = null;
            _loc1_++;
         }
         this.clanRewardItems = new Array();
      }
      
      public function getRankingType() : String
      {
         return this._rankingType;
      }
      
      private function activateWeeklyCountdown() : void
      {
         if(dataM.nextWeeklyReset != "")
         {
            if(this._weeklyCountdown != null)
            {
               this.deactivateWeeklyCountdown();
            }
            this._weeklyCountdown = new Timer(1000,0);
            this._weeklyCountdown.addEventListener(TimerEvent.TIMER,this.weeklyCountdownTrigger);
            this._weeklyCountdown.start();
            this.weeklyCountdownTriggerSub();
         }
         else
         {
            this.txtCountdown.text = "";
            this.createCountdownBitmapForMobile();
         }
      }
      
      private function weeklyCountdownTrigger(param1:TimerEvent) : void
      {
         this.weeklyCountdownTriggerSub();
      }
      
      private function weeklyCountdownTriggerSub() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc1_:Number = int(dataM.nextWeeklyReset);
         var _loc2_:Number = _loc1_ - dataM.currentTime;
         if(_loc2_ >= 0)
         {
            _loc3_ = Math.floor(_loc2_ / this._dayLength);
            _loc4_ = Math.floor((_loc2_ - _loc3_ * this._dayLength) / this._hourLength);
            _loc5_ = Math.floor((_loc2_ - _loc3_ * this._dayLength - _loc4_ * this._hourLength) / this._minuteLength);
            _loc6_ = Math.floor(_loc2_ - _loc3_ * this._dayLength - _loc4_ * this._hourLength - _loc5_ * this._minuteLength);
            _loc7_ = String(_loc4_);
            if(_loc7_.length == 1)
            {
               _loc7_ = "0" + _loc7_;
            }
            _loc8_ = String(_loc5_);
            if(_loc8_.length == 1)
            {
               _loc8_ = "0" + _loc8_;
            }
            _loc9_ = String(_loc6_);
            if(_loc9_.length == 1)
            {
               _loc9_ = "0" + _loc9_;
            }
            if(_loc3_ >= 1)
            {
               _loc10_ = getScreenText("resetDays");
               _loc10_ = dataM.replaceStringInText(_loc10_,"%DAYS%",String(_loc3_));
               _loc10_ = dataM.replaceStringInText(_loc10_,"%HOURS%",String(_loc4_));
               if(_loc3_ > 1)
               {
                  _loc11_ = getScreenText("days");
               }
               else
               {
                  _loc11_ = getScreenText("day");
               }
               if(_loc4_ > 1)
               {
                  _loc12_ = getScreenText("hours");
               }
               else
               {
                  _loc12_ = getScreenText("hour");
               }
               _loc10_ = dataM.replaceStringInText(_loc10_,"%DAYNAME%",_loc11_);
               _loc10_ = dataM.replaceStringInText(_loc10_,"%HOURNAME%",_loc12_);
               this.txtCountdown.text = _loc10_;
            }
            else if(_loc4_ >= 3)
            {
               this.txtCountdown.text = dataM.replaceStringInText(getScreenText("resetHours"),"%HOURS%",String(_loc4_));
            }
            else
            {
               this.txtCountdown.text = dataM.replaceStringInText(getScreenText("resetMinutesSeconds"),"%TIME%",_loc7_ + ":" + _loc8_ + ":" + _loc9_);
            }
         }
         else
         {
            this.txtCountdown.text = getScreenText("resetComplete");
            this.deactivateWeeklyCountdown();
         }
         this.createCountdownBitmapForMobile();
      }
      
      private function deactivateWeeklyCountdown() : void
      {
         if(this._weeklyCountdown != null)
         {
            this._weeklyCountdown.stop();
            this._weeklyCountdown.removeEventListener(TimerEvent.TIMER,this.weeklyCountdownTrigger);
            this._weeklyCountdown = null;
         }
         this.txtCountdown.text = "";
         this.createCountdownBitmapForMobile();
      }
      
      private function getRankingList() : void
      {
         if(dataM.callingRankingListEnabled)
         {
            if(this.rankingTileList != null)
            {
               this.rankingTileList.visible = false;
            }
            remoteM.lobby_rankingList();
            dataM.callingRankingListEnabled = false;
            this.rankingListTimer = new Timer(this.RANKING_LIST_CALL_COOLDOWN * 1000,0);
            this.rankingListTimer.addEventListener(TimerEvent.TIMER,this.rankingListTimerEnded);
            this.rankingListTimer.start();
         }
      }
      
      private function resetRankingListTimer() : void
      {
         if(this.rankingListTimer != null)
         {
            this.rankingListTimer.stop();
         }
         dataM.callingRankingListEnabled = true;
      }
      
      private function rankingListTimerEnded(param1:TimerEvent) : void
      {
         this.resetRankingListTimer();
      }
      
      public function getRankingListSuccess(param1:String) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Array = null;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:Object = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:Array = null;
         var _loc19_:BMClanRankingListData = null;
         var _loc20_:Number = NaN;
         var _loc21_:Array = null;
         var _loc22_:BMPlayerRankingListData = null;
         var _loc23_:Boolean = false;
         var _loc24_:MovieClip = null;
         var _loc25_:Number = NaN;
         var _loc26_:Sprite = null;
         var _loc27_:BMItem = null;
         var _loc28_:BMTileListItem = null;
         var _loc29_:Function = null;
         var _loc30_:String = null;
         var _loc31_:Array = null;
         var _loc32_:BMClanFlag = null;
         var _loc33_:MovieClip = null;
         var _loc34_:Array = null;
         var _loc35_:MovieClip = null;
         var _loc36_:String = null;
         var _loc37_:String = null;
         var _loc38_:Boolean = false;
         var _loc39_:Number = NaN;
         var _loc40_:MovieClip = null;
         var _loc41_:BMItem = null;
         var _loc42_:BMTileListItem = null;
         var _loc43_:Function = null;
         var _loc44_:BMAvatarImage = null;
         var _loc45_:Array = null;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Array = new Array();
         var _loc4_:Number = 0;
         var _loc11_:uint = this.RANKING_LIST_ROW_WIDTH;
         if(dataM.runAsMobile)
         {
            _loc11_ = this.RANKING_LIST_ROW_WIDTH_MOBILE;
         }
         switch(this._rankingType)
         {
            case "clans":
               _loc12_ = this.RANKING_LIST_CLANS_ROW_HEIGHT;
               _loc13_ = this.RANKING_LIST_CLANS_ROWS;
               if(dataM.runAsMobile)
               {
                  _loc12_ = this.RANKING_LIST_CLANS_ROW_HEIGHT_MOBILE;
                  _loc13_ = this.RANKING_LIST_CLANS_ROWS_MOBILE;
               }
               _loc14_ = dataM.clansRankingList;
               _loc18_ = new Array();
               for each(_loc19_ in _loc14_)
               {
                  if(_loc19_.clanID == _loc2_.clan_tryingToJoinClanID)
                  {
                     _loc18_.push({
                        "rank":0,
                        "clanID":_loc19_.clanID
                     });
                  }
                  else
                  {
                     _loc18_.push({
                        "rank":_loc19_.rank,
                        "clanID":_loc19_.clanID
                     });
                  }
               }
               _loc18_.sortOn("rank",Array.NUMERIC);
               _loc20_ = 0;
               _loc15_ = 15;
               switch(dataM.languageID)
               {
                  case 3:
                     _loc15_ = 17;
               }
               _loc10_ = 0;
               while(_loc10_ < _loc18_.length)
               {
                  _loc19_ = _loc14_[_loc18_[_loc10_].clanID];
                  _loc23_ = true;
                  if(_loc19_.rank == 0)
                  {
                     _loc23_ = false;
                  }
                  if(_loc23_)
                  {
                     _loc4_++;
                     switch(this._rankingType)
                     {
                        case "clans":
                           if(_loc2_.clanID > 0)
                           {
                              if(_loc19_.clanID == _loc2_.clanID)
                              {
                                 _loc20_ = _loc4_;
                              }
                           }
                     }
                     if(dataM.runAsMobile)
                     {
                        _loc24_ = new mcRankingListRow_clans_mobile();
                     }
                     else
                     {
                        _loc24_ = new mcRankingListRow_clans();
                     }
                     TextUtils.updateTextFormat(_loc24_.txtWaitingForApproval,_loc15_);
                     TextUtils.updateTextFormat(_loc24_.txtMembers,_loc15_);
                     TextUtils.updateTextFormat(_loc24_.txtRank,_loc15_);
                     TextUtils.updateTextFormat(_loc24_.txtName,15);
                     TextUtils.updateTextFormat(_loc24_.txtLeaderName,13);
                     TextUtils.updateTextFormat(_loc24_.txtWins,_loc15_);
                     TextUtils.updateTextFormat(_loc24_.txtLoses,_loc15_);
                     _loc24_.txtName.text = _loc19_.clanName;
                     if(_loc19_.leaderName == null)
                     {
                        _loc24_.txtLeaderName.text = "";
                     }
                     else
                     {
                        _loc30_ = getScreenText("clanLeader");
                        _loc30_ = dataM.replaceStringInText(_loc30_,"%NAME%",_loc19_.leaderName);
                        _loc24_.txtLeaderName.text = _loc30_;
                     }
                     _loc24_.txtWaitingForApproval.text = "";
                     _loc24_.txtMembers.text = _loc19_.members + " / " + dataM.clanMaxMembers;
                     _loc24_.txtLoses.text = dataM.getNumberWithComma(_loc19_.ladderBattles - _loc19_.ladderWins);
                     _loc24_.txtWins.text = dataM.getNumberWithComma(_loc19_.ladderWins);
                     if(_loc19_.clanID == _loc2_.clanID)
                     {
                        if(_loc19_.rank <= 6)
                        {
                           _loc9_ = "self_top10";
                        }
                        else
                        {
                           _loc9_ = "self";
                        }
                     }
                     else if(_loc19_.rank <= 6)
                     {
                        _loc9_ = "top10";
                     }
                     else if(_loc4_ % 2 == 0)
                     {
                        _loc9_ = "regular1";
                     }
                     else
                     {
                        _loc9_ = "regular2";
                     }
                     _loc24_.mcBackground.gotoAndStop(_loc9_);
                     if(_loc19_.rank == 0)
                     {
                        _loc24_.txtRank.text = "";
                     }
                     else
                     {
                        _loc24_.txtRank.text = dataM.getNumberWithComma(_loc19_.rank);
                     }
                     if(_loc19_.flag != "")
                     {
                        _loc31_ = dataM.getClanFlagData(_loc19_.flag);
                        if(_loc31_.length > 0)
                        {
                           _loc32_ = new BMClanFlag();
                           _loc33_ = externalAssetsM.getAsset("general","clanFlag",_loc24_.mcSizer_flag.width,_loc24_.mcSizer_flag.height,false,false);
                           _loc33_.x = _loc24_.mcSizer_flag.x;
                           _loc33_.y = _loc24_.mcSizer_flag.y;
                           _loc32_.initialize(_loc33_,dataM.runAsMobile);
                           _loc32_.updateFlag(_loc31_);
                           _loc24_.addChild(_loc33_);
                        }
                     }
                     _loc25_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc19_.ladderProgress));
                     _loc26_ = externalAssetsM.getAsset("general","Grp_rank" + _loc25_,0,0,false,false);
                     _loc26_.width = _loc24_.mcSizer_rank.width;
                     _loc26_.height = _loc24_.mcSizer_rank.height;
                     _loc26_.x = _loc24_.mcSizer_rank.x;
                     _loc26_.y = _loc24_.mcSizer_rank.y;
                     _loc24_.addChild(_loc26_);
                     _loc27_ = new BMItem();
                     _loc27_.initialize(_loc19_.clanID,_loc11_,_loc12_,_loc24_,-1,-1,false,null,dataM.runAsMobile);
                     if(dataM.runAsMobile)
                     {
                        _loc34_ = [_loc24_.txtRank,_loc24_.txtName,_loc24_.txtMembers,_loc24_.txtLoses,_loc24_.txtWins,_loc24_.txtWaitingForApproval];
                        _loc27_.createAssetsBitmap(_loc34_,[_loc26_],_loc24_);
                     }
                     _loc28_ = new BMTileListItem();
                     _loc29_ = this.rankingListItemClicked;
                     if(dataM.runAsMobile)
                     {
                        _loc29_ = null;
                     }
                     _loc28_.initialize(_loc11_,_loc12_,_loc27_,"","","",0,_loc29_,null,null,null,null,dataM.runAsMobile);
                     _loc3_.push(_loc28_);
                  }
                  _loc10_++;
               }
               if(this._tileListLastDataType == "players")
               {
                  if(this.rankingTileList != null)
                  {
                     this.rankingTileList.removeMe();
                     this.rankingTileList = null;
                  }
                  this._tileListLastDataType = "clans";
               }
               if(this.rankingTileList == null)
               {
                  this.rankingTileList = new BMTileList();
                  _loc5_ = false;
                  if(dataM.runAsMobile)
                  {
                     this._fingerWheeling.resetTileList(this.rankingTileList);
                     _loc5_ = true;
                  }
                  _loc6_ = new Grp_scrollerContent();
                  if(dataM.runAsMobile)
                  {
                     _loc7_ = new mcRankingListHeader_clans_mobile();
                     this.rankingTileList.activateExtendedMode(0.44,true);
                  }
                  else
                  {
                     _loc7_ = new mcRankingListHeader_clans();
                  }
                  _loc16_ = 13;
                  _loc17_ = 13;
                  switch(dataM.languageID)
                  {
                     case 5:
                        _loc17_ = 12;
                        break;
                     case 3:
                        _loc16_ = 16;
                        _loc17_ = 10;
                        break;
                     case 9:
                        _loc17_ = 10;
                        break;
                     case 10:
                        _loc17_ = 10;
                  }
                  TextUtils.updateTextFormat(_loc7_.txtPosition,_loc16_);
                  TextUtils.updateTextFormat(_loc7_.txtName,_loc16_);
                  TextUtils.updateTextFormat(_loc7_.txtMembers,_loc17_);
                  TextUtils.updateTextFormat(_loc7_.txtWins,_loc17_);
                  TextUtils.updateTextFormat(_loc7_.txtLosses,_loc17_);
                  _loc7_.txtPosition.text = getScreenText("position");
                  _loc7_.txtName.text = getGeneralText("nameCaps");
                  _loc7_.txtMembers.text = getScreenText("members");
                  _loc7_.txtWins.text = getScreenText("wins");
                  _loc7_.txtLosses.text = getScreenText("losses");
                  this.rankingTileList.initialize(screensM.stagePointer.stage,_loc3_,_loc13_,1,_loc11_,_loc12_,null,true,_loc6_,null,_loc7_,false,_loc20_ - 4,1,true,_loc5_,dataM.runAsMobile);
                  this.rankingTileList.x = this.mcSizer_rankingTileList.x;
                  this.rankingTileList.y = this.mcSizer_rankingTileList.y;
                  if(dataM.runAsMobile)
                  {
                     _loc8_ = [_loc7_.txtPosition,_loc7_.txtName,_loc7_.txtMembers,_loc7_.txtWins,_loc7_.txtLosses];
                     screensM.createMultipleTextsBitmap("rankingList_clans_header",_loc8_,"",_loc7_);
                  }
                  this.mcMainHolder.addChild(this.rankingTileList);
               }
               else
               {
                  this.rankingTileList.removeAllItems();
                  this.rankingTileList.addItems(0,_loc3_,true);
                  if(_loc20_ > 0)
                  {
                     this.rankingTileList.jumpToRow(_loc20_ - 4,true,"rankingList_clans");
                  }
                  if(dataM.runAsMobile)
                  {
                     this._fingerWheeling.tileListItemsModified();
                  }
               }
               if(this._rankingType == "clans")
               {
                  this.btnPlayers.enableMe();
                  this.btnClans.enableMe();
                  this.activateWeeklyCountdown();
               }
               break;
            case "playersWeekly":
            case "playersOnline":
               _loc12_ = this.RANKING_LIST_PLAYERS_ROW_HEIGHT;
               _loc13_ = this.RANKING_LIST_PLAYERS_ROWS;
               if(dataM.runAsMobile)
               {
                  _loc12_ = this.RANKING_LIST_PLAYERS_ROW_HEIGHT_MOBILE;
                  _loc13_ = this.RANKING_LIST_PLAYERS_ROWS_MOBILE;
               }
               _loc21_ = new Array();
               _loc14_ = this.getTargetRankingList();
               for each(_loc22_ in _loc14_)
               {
                  _loc21_.push({
                     "overallRank":_loc22_.overallRank,
                     "playerID":_loc22_.playerID
                  });
               }
               _loc21_.sortOn("overallRank",Array.NUMERIC);
               _loc15_ = 15;
               switch(dataM.languageID)
               {
                  case 3:
                     _loc15_ = 17;
               }
               _loc10_ = 0;
               while(_loc10_ < _loc21_.length)
               {
                  _loc22_ = _loc14_[_loc21_[_loc10_].playerID];
                  if(_loc22_ != null)
                  {
                     _loc4_++;
                     if(dataM.runAsMobile)
                     {
                        _loc35_ = new mcRankingListRow_mobile();
                     }
                     else
                     {
                        _loc35_ = new mcRankingListRow();
                     }
                     switch(_loc22_.lastDevice)
                     {
                        case "1":
                        case "2":
                           _loc35_.txtName.width -= 18;
                           break;
                        default:
                           _loc35_.mcMobileDevice.parent.removeChild(_loc35_.mcMobileDevice);
                           _loc35_.mcMobileDevice = null;
                     }
                     _loc36_ = "Empty";
                     if(_loc22_.playerName != null)
                     {
                        _loc36_ = _loc22_.playerName;
                     }
                     TextUtils.updateTextFormat(_loc35_.txtRank,_loc15_);
                     TextUtils.updateTextFormat(_loc35_.txtName,_loc15_);
                     TextUtils.updateTextFormat(_loc35_.txtLevel,_loc15_);
                     TextUtils.updateTextFormat(_loc35_.txtWins,_loc15_);
                     TextUtils.updateTextFormat(_loc35_.txtLoses,_loc15_);
                     _loc35_.txtName.text = _loc36_;
                     _loc35_.txtLevel.text = _loc22_.level;
                     _loc35_.txtLoses.text = dataM.getNumberWithComma(_loc22_.onlineBattles - _loc22_.onlineWins);
                     _loc35_.txtWins.text = dataM.getNumberWithComma(_loc22_.onlineWins);
                     if(_loc22_.playerID == dataM.userID)
                     {
                        _loc22_.winLossStreak = _loc2_.winLossStreak;
                     }
                     if(_loc22_.winLossStreak > 0)
                     {
                        _loc35_.txtWins.htmlText = TextUtils.getTextFont(16) + "<B>" + _loc35_.txtWins.text + "  ( <FONT COLOR=\'#00CC00\'>+" + _loc22_.winLossStreak + "</B></FONT> )";
                     }
                     else if(_loc22_.winLossStreak < 0)
                     {
                        _loc35_.txtLoses.text = _loc35_.txtLoses.text + "  ( " + _loc22_.winLossStreak + " )";
                     }
                     _loc37_ = _loc22_.geo;
                     _loc38_ = false;
                     if(_loc37_ != null && _loc37_ != "")
                     {
                        _loc44_ = dataM.getAvatarImage(_loc37_);
                        _loc44_.x = _loc35_.mcSizer_flag.x;
                        _loc44_.y = _loc35_.mcSizer_flag.y;
                        _loc44_.width = _loc35_.mcSizer_flag.width;
                        _loc44_.height = _loc35_.mcSizer_flag.height;
                        _loc38_ = true;
                     }
                     if(_loc22_.playerID == dataM.userID)
                     {
                        if(_loc22_.overallRank <= 10)
                        {
                           _loc9_ = "self_top10";
                        }
                        else
                        {
                           _loc9_ = "self";
                        }
                     }
                     else if(_loc22_.overallRank <= 10)
                     {
                        if(_loc22_.isOnline)
                        {
                           _loc9_ = "top10_online";
                        }
                        else
                        {
                           _loc9_ = "top10";
                        }
                     }
                     else if(_loc22_.isOnline)
                     {
                        _loc9_ = "online";
                     }
                     else if(_loc4_ % 2 == 0)
                     {
                        _loc9_ = "regular1";
                     }
                     else
                     {
                        _loc9_ = "regular2";
                     }
                     _loc35_.mcRankProgression.gotoAndStop("empty");
                     _loc35_.mcBackground.gotoAndStop(_loc9_);
                     _loc35_.txtRank.text = dataM.getNumberWithComma(_loc22_.overallRank);
                     _loc39_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc22_.ladderProgress));
                     _loc40_ = externalAssetsM.getAsset("general","Grp_rank" + _loc39_,0,0,false,false);
                     _loc40_.width = _loc35_.mcSizer_rank.width;
                     _loc40_.height = _loc35_.mcSizer_rank.height;
                     _loc40_.x = _loc35_.mcSizer_rank.x;
                     _loc40_.y = _loc35_.mcSizer_rank.y;
                     _loc35_.addChild(_loc40_);
                     _loc41_ = new BMItem();
                     _loc41_.initialize(_loc22_.playerID,_loc11_,_loc12_,_loc35_,-1,-1,false,null,dataM.runAsMobile);
                     if(dataM.runAsMobile)
                     {
                        _loc45_ = [_loc35_.txtRank,_loc35_.txtName,_loc35_.txtLevel,_loc35_.txtLoses,_loc35_.txtWins];
                        _loc41_.createAssetsBitmap(_loc45_,[_loc40_],_loc35_);
                     }
                     _loc42_ = new BMTileListItem();
                     _loc43_ = this.rankingListItemClicked;
                     if(dataM.runAsMobile)
                     {
                        _loc43_ = null;
                     }
                     _loc42_.initialize(_loc11_,_loc12_,_loc41_,"","","",0,_loc43_,null,null,null,null,dataM.runAsMobile);
                     if(_loc38_)
                     {
                        _loc42_.itemsThatNeedsAddingAndRemoving.push(_loc44_);
                     }
                     _loc3_.push(_loc42_);
                  }
                  _loc10_++;
               }
               if(this._tileListLastDataType == "clans")
               {
                  if(this.rankingTileList != null)
                  {
                     this.rankingTileList.removeMe();
                     this.rankingTileList = null;
                  }
                  this._tileListLastDataType = "players";
               }
               if(this.rankingTileList == null)
               {
                  this.rankingTileList = new BMTileList();
                  _loc5_ = false;
                  if(dataM.runAsMobile)
                  {
                     this._fingerWheeling.resetTileList(this.rankingTileList);
                     _loc5_ = true;
                  }
                  _loc6_ = new Grp_scrollerContent();
                  if(dataM.runAsMobile)
                  {
                     _loc7_ = new mcRankingListHeader_mobile();
                     this.rankingTileList.activateExtendedMode(0.44,true);
                  }
                  else
                  {
                     _loc7_ = new mcRankingListHeader();
                  }
                  _loc16_ = 13;
                  _loc17_ = 13;
                  switch(dataM.languageID)
                  {
                     case 3:
                        _loc16_ = 16;
                        _loc17_ = 10;
                        break;
                     case 7:
                        _loc17_ = 12;
                        break;
                     case 9:
                        _loc17_ = 10;
                        break;
                     case 10:
                        _loc17_ = 10;
                  }
                  TextUtils.updateTextFormat(_loc7_.txtPosition,_loc16_);
                  TextUtils.updateTextFormat(_loc7_.txtName,_loc16_);
                  TextUtils.updateTextFormat(_loc7_.txtLevel,_loc16_);
                  TextUtils.updateTextFormat(_loc7_.txtWins,_loc17_);
                  TextUtils.updateTextFormat(_loc7_.txtLosses,_loc17_);
                  _loc7_.txtPosition.text = getScreenText("position");
                  _loc7_.txtName.text = getGeneralText("nameCaps");
                  _loc7_.txtLevel.text = getGeneralText("levelCaps");
                  _loc7_.txtWins.text = getScreenText("winsStreak");
                  _loc7_.txtLosses.text = getScreenText("losses");
                  this.rankingTileList.initialize(screensM.stagePointer.stage,_loc3_,_loc13_,1,_loc11_,_loc12_,null,true,_loc6_,null,_loc7_,false,0,1,true,_loc5_,dataM.runAsMobile);
                  this.rankingTileList.x = this.mcSizer_rankingTileList.x;
                  this.rankingTileList.y = this.mcSizer_rankingTileList.y;
                  if(dataM.runAsMobile)
                  {
                     _loc8_ = [_loc7_.txtPosition,_loc7_.txtName,_loc7_.txtLevel,_loc7_.txtWins,_loc7_.txtLosses];
                     screensM.createMultipleTextsBitmap("rankingList_header",_loc8_,"",_loc7_);
                  }
                  this.mcMainHolder.addChild(this.rankingTileList);
               }
               else
               {
                  this.rankingTileList.removeAllItems();
                  this.rankingTileList.addItems(0,_loc3_,true);
                  if(dataM.runAsMobile)
                  {
                     this._fingerWheeling.tileListItemsModified();
                  }
               }
               if(this._rankingType == "playersWeekly")
               {
                  this.btnClans.enableMe();
                  this.btnPlayers.enableMe();
                  this.activateWeeklyCountdown();
               }
         }
         this.rankingTileList.scrollToID(dataM.userID,"center","tileListItemID");
         this.rankingTileList.visible = true;
         this.mcSandClock.gotoAndStop("animOff");
      }
      
      private function rankingListItemClicked(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:BMClanRankingListData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Object = null;
         var _loc7_:BMPlayerRankingListData = null;
         if(this.rankingListEnabled)
         {
            switch(this._tileListLastDataType)
            {
               case "clans":
                  _loc3_ = param2;
                  _loc4_ = dataM.clansRankingList[_loc3_];
                  if(dataM.playersGeneralData[_loc4_.leaderID] != null)
                  {
                     this.inspectGeneralPlayerData(_loc4_.leaderID,"clan");
                  }
                  else
                  {
                     remoteM.socketM.lobby_getPlayerGeneralData(_loc4_.leaderID);
                     screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
                  }
                  break;
               case "players":
                  _loc5_ = param2;
                  _loc6_ = this.getTargetRankingList();
                  _loc7_ = _loc6_[_loc5_];
                  if(_loc7_ != null)
                  {
                     screensM.addScreen("screenInspectPlayer");
                     screensM.screenInspectPlayer.refreshScreen(_loc7_.playerID,false,"",0,0,_loc7_.clanID);
                  }
            }
            soundM.createSound("buttonClick",1);
         }
      }
      
      public function jumpToPlayer(param1:Number) : void
      {
         this.rankingTileList.jumpToRow(this.rankingTileList.findTileIDByTileListItemID(param1) - 5,true,"screenRankingList >> jumpToPlayer");
      }
      
      private function getTargetRankingList() : Object
      {
         var _loc1_:Object = null;
         switch(this._rankingType)
         {
            case "playersWeekly":
               _loc1_ = dataM.rankingList_weekly;
               break;
            case "playersOnline":
               _loc1_ = dataM.rankingList_online;
         }
         return _loc1_;
      }
      
      public function playerGeneralDataLoaded(param1:Number) : void
      {
         screensM.removeScreen("screenConfirmation");
         var _loc2_:String = "";
         if(this._rankingType == "clans")
         {
            _loc2_ = "clan";
         }
         this.inspectGeneralPlayerData(param1,_loc2_);
      }
      
      private function inspectGeneralPlayerData(param1:Number, param2:String = "") : void
      {
         var _loc3_:Object = dataM.playersGeneralData[param1];
         screensM.addScreen("screenInspectPlayer");
         screensM.screenInspectPlayer.refreshScreen(_loc3_.playerID,true,_loc3_.name,_loc3_.level,_loc3_.ladderProgress,_loc3_.clanID,param2);
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.multiplayerLadderClicked();
      }
      
      public function removeScreen() : void
      {
         dataM.playersGeneralData = new Object();
         this.deactivateWeeklyCountdown();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.removeMouseListeners();
         }
         screensM.removeScreen("screenRankingList");
         if(this.rankingTileList != null)
         {
            this.rankingTileList.removeMe();
            this.rankingTileList = null;
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.resetRankingListTimer();
         this.refreshScreen();
      }
   }
}

