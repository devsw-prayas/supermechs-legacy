package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMScreensManager;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1567")]
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
      
      public var mcSandClock:MovieClip;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnPrizeList:MovieClip;
      
      public var txtPrizeList:TextField;
      
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
         this.btnPrizeList.addEventListener(MouseEvent.CLICK,this.onPrizeListClick);
         updateTextAndFormat(this.txtPrizeList,getScreenText("prizeList"));
      }
      
      private function onPrizeListClick(param1:MouseEvent) : void
      {
         screensM.addScreen(BMScreensManager.SCR_LADDER_SEASON_INFO);
      }
      
      private function createTitleBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("rankingList_title",[this.txtTitle],"",this);
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
      
      public function refreshScreen(param1:Boolean = false) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_RANKING_LIST,"btnPlayers","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_RANKING_LIST,"btnClans","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_RANKING_LIST,"btnBack","pictureE");
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
         if(param1)
         {
            this.clansClickedSub();
         }
         else
         {
            this.playersClickedSub();
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
         this.createTitleBitmapForMobile();
         updateTextAndFormat(this.mcShowOnline.txtShowOnline,getScreenText("showOnline"));
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_RANKING_LIST))
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
         updateTextAndFormat(this.txtTitle,getScreenText("titleWeekly"));
         this.txtTitle.y = this._titleInitialYPos;
         this.createTitleBitmapForMobile();
         this.getRankingListSuccess("playersClicked");
         this.mcShowOnline.visible = true;
         this.mcShowOnline.mcV.visible = false;
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
         updateTextAndFormat(this.txtTitle,getScreenText("titleClans"));
         this.txtTitle.y = this._titleInitialYPos;
         this.mcButtonMarker.visible = true;
         this.mcButtonMarker.x = this.btnClans.x;
         this.mcButtonMarker.y = this.btnClans.y;
         this.activateWeeklyCountdown();
         this.createTitleBitmapForMobile();
         this.getRankingListSuccess("clansClicked");
         this.mcShowOnline.visible = false;
      }
      
      public function clansAroundMyLadderProgressLoaded() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.clansClickedSub();
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
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc1_:Number = int(dataM.nextWeeklyReset);
         var _loc2_:Number = _loc1_ - dataM.currentTime;
         var _loc3_:String = "";
         if(_loc2_ >= 0)
         {
            _loc4_ = Math.floor(_loc2_ / this._dayLength);
            _loc5_ = Math.floor((_loc2_ - _loc4_ * this._dayLength) / this._hourLength);
            _loc6_ = Math.floor((_loc2_ - _loc4_ * this._dayLength - _loc5_ * this._hourLength) / this._minuteLength);
            _loc7_ = Math.floor(_loc2_ - _loc4_ * this._dayLength - _loc5_ * this._hourLength - _loc6_ * this._minuteLength);
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
            _loc10_ = String(_loc7_);
            if(_loc10_.length == 1)
            {
               _loc10_ = "0" + _loc10_;
            }
            if(_loc4_ >= 1)
            {
               _loc11_ = getScreenText("resetDays");
               _loc11_ = dataM.replaceStringInText(_loc11_,"%DAYS%",String(_loc4_));
               _loc11_ = dataM.replaceStringInText(_loc11_,"%HOURS%",String(_loc5_));
               if(_loc4_ > 1)
               {
                  _loc12_ = getScreenText("days");
               }
               else
               {
                  _loc12_ = getScreenText("day");
               }
               if(_loc5_ > 1)
               {
                  _loc13_ = getScreenText("hours");
               }
               else
               {
                  _loc13_ = getScreenText("hour");
               }
               _loc11_ = dataM.replaceStringInText(_loc11_,"%DAYNAME%",_loc12_);
               _loc3_ = _loc11_ = dataM.replaceStringInText(_loc11_,"%HOURNAME%",_loc13_);
            }
            else if(_loc5_ >= 3)
            {
               _loc3_ = dataM.replaceStringInText(getScreenText("resetHours"),"%HOURS%",String(_loc5_));
            }
            else
            {
               _loc3_ = dataM.replaceStringInText(getScreenText("resetMinutesSeconds"),"%TIME%",_loc8_ + ":" + _loc9_ + ":" + _loc10_);
            }
         }
         else
         {
            _loc3_ = getScreenText("resetComplete");
            this.deactivateWeeklyCountdown();
         }
         updateTextAndFormat(this.txtCountdown,_loc3_);
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
         var _loc15_:Array = null;
         var _loc16_:BMClanRankingListData = null;
         var _loc17_:Number = NaN;
         var _loc18_:Array = null;
         var _loc19_:BMPlayerRankingListData = null;
         var _loc20_:Boolean = false;
         var _loc21_:MovieClip = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:Number = NaN;
         var _loc25_:Sprite = null;
         var _loc26_:BMItem = null;
         var _loc27_:BMTileListItem = null;
         var _loc28_:Function = null;
         var _loc29_:Array = null;
         var _loc30_:BMClanFlag = null;
         var _loc31_:MovieClip = null;
         var _loc32_:Array = null;
         var _loc33_:MovieClip = null;
         var _loc34_:String = null;
         var _loc35_:String = null;
         var _loc36_:Boolean = false;
         var _loc37_:Number = NaN;
         var _loc38_:MovieClip = null;
         var _loc39_:BMItem = null;
         var _loc40_:BMTileListItem = null;
         var _loc41_:Function = null;
         var _loc42_:BMAvatarImage = null;
         var _loc43_:Array = null;
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
               _loc15_ = new Array();
               for each(_loc16_ in _loc14_)
               {
                  if(_loc16_.clanID == _loc2_.clan_tryingToJoinClanID)
                  {
                     _loc15_.push({
                        "rank":0,
                        "clanID":_loc16_.clanID
                     });
                  }
                  else
                  {
                     _loc15_.push({
                        "rank":_loc16_.rank,
                        "clanID":_loc16_.clanID
                     });
                  }
               }
               _loc15_.sortOn("rank",Array.NUMERIC);
               _loc17_ = 0;
               _loc10_ = 0;
               while(_loc10_ < _loc15_.length)
               {
                  _loc16_ = _loc14_[_loc15_[_loc10_].clanID];
                  _loc20_ = true;
                  if(_loc16_.rank == 0)
                  {
                     _loc20_ = false;
                  }
                  if(_loc20_)
                  {
                     _loc4_++;
                     switch(this._rankingType)
                     {
                        case "clans":
                           if(_loc2_.clanID > 0)
                           {
                              if(_loc16_.clanID == _loc2_.clanID)
                              {
                                 _loc17_ = _loc4_;
                              }
                           }
                     }
                     if(dataM.runAsMobile)
                     {
                        _loc21_ = new mcRankingListRow_clanRankings_mobile();
                     }
                     else
                     {
                        _loc21_ = new mcRankingListRow_clanRankings();
                     }
                     updateTextAndFormat(_loc21_.txtName,_loc16_.clanName);
                     _loc22_ = "";
                     if(_loc16_.leaderName != null)
                     {
                        _loc22_ = getScreenText("clanLeader");
                        _loc22_ = _loc22_ = dataM.replaceStringInText(_loc22_,"%NAME%",_loc16_.leaderName);
                     }
                     updateTextAndFormat(_loc21_.txtLeaderName,_loc22_);
                     updateTextAndFormat(_loc21_.txtWaitingForApproval,"");
                     updateTextAndFormat(_loc21_.txtMembers,_loc16_.members + " / " + dataM.clanMaxMembers);
                     updateTextAndFormat(_loc21_.txtArenaPoints,TextUtils.getNumberWithComma(_loc16_.arenaPoints));
                     if(_loc16_.clanID == _loc2_.clanID)
                     {
                        if(_loc16_.rank <= 6)
                        {
                           _loc9_ = "self_top10";
                        }
                        else
                        {
                           _loc9_ = "self";
                        }
                     }
                     else if(_loc16_.rank <= 6)
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
                     _loc21_.mcBackground.gotoAndStop(_loc9_);
                     _loc23_ = "";
                     if(_loc16_.rank > 0)
                     {
                        _loc23_ = TextUtils.getNumberWithComma(_loc16_.rank);
                     }
                     updateTextAndFormat(_loc21_.txtRank,_loc23_);
                     if(_loc16_.flag != "")
                     {
                        _loc29_ = dataM.getClanFlagData(_loc16_.flag);
                        if(_loc29_.length > 0)
                        {
                           _loc30_ = new BMClanFlag();
                           _loc31_ = externalAssetsM.getAsset("general","clanFlag",_loc21_.mcSizer_flag.width,_loc21_.mcSizer_flag.height,false,false);
                           _loc31_.x = _loc21_.mcSizer_flag.x;
                           _loc31_.y = _loc21_.mcSizer_flag.y;
                           _loc30_.initialize(_loc31_,dataM.runAsMobile);
                           _loc30_.updateFlag(_loc29_);
                           _loc21_.addChild(_loc31_);
                        }
                     }
                     _loc24_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc16_.ladderProgress));
                     _loc25_ = externalAssetsM.getAsset("general","Grp_rank" + _loc24_,0,0,false,false);
                     _loc25_.width = _loc21_.mcSizer_rank.width;
                     _loc25_.height = _loc21_.mcSizer_rank.height;
                     _loc25_.x = _loc21_.mcSizer_rank.x;
                     _loc25_.y = _loc21_.mcSizer_rank.y;
                     _loc21_.addChild(_loc25_);
                     _loc26_ = new BMItem();
                     _loc26_.initialize(_loc16_.clanID,_loc11_,_loc12_,_loc21_,-1,-1,false,null,dataM.runAsMobile);
                     if(dataM.runAsMobile)
                     {
                        _loc32_ = [_loc21_.txtRank,_loc21_.txtName,_loc21_.txtMembers,_loc21_.txtArenaPoints,_loc21_.txtWaitingForApproval];
                        _loc26_.createAssetsBitmap(_loc32_,[_loc25_],_loc21_);
                     }
                     _loc27_ = new BMTileListItem();
                     _loc28_ = this.rankingListItemClicked;
                     if(dataM.runAsMobile)
                     {
                        _loc28_ = null;
                     }
                     _loc27_.initialize(_loc11_,_loc12_,_loc26_,"","","",0,_loc28_,null,null,null,null,dataM.runAsMobile);
                     _loc3_.push(_loc27_);
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
                     _loc7_ = new mcRankingListHeader_clanRankings_mobile();
                     this.rankingTileList.activateExtendedMode(0.44,true);
                  }
                  else
                  {
                     _loc7_ = new mcRankingListHeader_clanRankings();
                  }
                  updateTextAndFormat(_loc7_.txtPosition,getScreenText("position"));
                  updateTextAndFormat(_loc7_.txtName,getGeneralText("nameCaps"));
                  updateTextAndFormat(_loc7_.txtMembers,getScreenText("members"));
                  updateTextAndFormat(_loc7_.txtArenaPoints,getGeneralText("arenaPointsCaps"));
                  this.rankingTileList.initialize(screensM.stagePointer.stage,_loc3_,_loc13_,1,_loc11_,_loc12_,null,true,_loc6_,null,_loc7_,false,_loc17_ - 4,1,true,_loc5_,dataM.runAsMobile);
                  this.rankingTileList.x = this.mcSizer_rankingTileList.x;
                  this.rankingTileList.y = this.mcSizer_rankingTileList.y;
                  if(dataM.runAsMobile)
                  {
                     _loc8_ = [_loc7_.txtPosition,_loc7_.txtName,_loc7_.txtMembers,_loc7_.txtArenaPoints];
                     screensM.createMultipleTextsBitmap("rankingList_clans_header",_loc8_,"",_loc7_);
                  }
                  this.mcMainHolder.addChild(this.rankingTileList);
               }
               else
               {
                  this.rankingTileList.removeAllItems();
                  this.rankingTileList.addItems(0,_loc3_,true);
                  if(_loc17_ > 0)
                  {
                     this.rankingTileList.jumpToRow(_loc17_ - 4,true,"rankingList_clans");
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
               _loc18_ = new Array();
               _loc14_ = this.getTargetRankingList();
               for each(_loc19_ in _loc14_)
               {
                  _loc18_.push({
                     "overallRank":_loc19_.overallRank,
                     "playerID":_loc19_.playerID
                  });
               }
               _loc18_.sortOn("overallRank",Array.NUMERIC);
               _loc10_ = 0;
               while(_loc10_ < _loc18_.length)
               {
                  _loc19_ = _loc14_[_loc18_[_loc10_].playerID];
                  if(_loc19_ != null)
                  {
                     _loc4_++;
                     if(dataM.runAsMobile)
                     {
                        _loc33_ = new mcRankingListRow_solo_mobile();
                     }
                     else
                     {
                        _loc33_ = new mcRankingListRow_solo();
                     }
                     switch(_loc19_.lastDevice)
                     {
                        case "1":
                        case "2":
                           _loc33_.txtName.width -= 18;
                           break;
                        default:
                           _loc33_.mcMobileDevice.parent.removeChild(_loc33_.mcMobileDevice);
                           _loc33_.mcMobileDevice = null;
                     }
                     _loc34_ = "Empty";
                     if(_loc19_.playerName != null)
                     {
                        _loc34_ = _loc19_.playerName;
                     }
                     updateTextAndFormat(_loc33_.txtName,_loc34_);
                     updateTextAndFormat(_loc33_.txtLevel,String(_loc19_.level));
                     updateTextAndFormat(_loc33_.txtArenaPoints,TextUtils.getNumberWithComma(_loc19_.arenaPoints));
                     if(_loc19_.playerID == dataM.userID)
                     {
                        _loc19_.winLossStreak = _loc2_.winLossStreak;
                     }
                     _loc35_ = _loc19_.geo;
                     _loc36_ = false;
                     if(_loc35_ != null && _loc35_ != "")
                     {
                        _loc42_ = dataM.getAvatarImage(_loc35_);
                        _loc42_.x = _loc33_.mcSizer_flag.x;
                        _loc42_.y = _loc33_.mcSizer_flag.y;
                        _loc42_.width = _loc33_.mcSizer_flag.width;
                        _loc42_.height = _loc33_.mcSizer_flag.height;
                        _loc36_ = true;
                     }
                     if(_loc19_.playerID == dataM.userID)
                     {
                        if(_loc19_.overallRank <= 10)
                        {
                           _loc9_ = "self_top10";
                        }
                        else
                        {
                           _loc9_ = "self";
                        }
                     }
                     else if(_loc19_.overallRank <= 10)
                     {
                        if(_loc19_.isOnline)
                        {
                           _loc9_ = "top10_online";
                        }
                        else
                        {
                           _loc9_ = "top10";
                        }
                     }
                     else if(_loc19_.isOnline)
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
                     _loc33_.mcRankProgression.gotoAndStop("empty");
                     _loc33_.mcBackground.gotoAndStop(_loc9_);
                     updateTextAndFormat(_loc33_.txtRank,TextUtils.getNumberWithComma(_loc19_.overallRank));
                     _loc37_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc19_.ladderProgress));
                     _loc38_ = externalAssetsM.getAsset("general","Grp_rank" + _loc37_,0,0,false,false);
                     _loc38_.width = _loc33_.mcSizer_rank.width;
                     _loc38_.height = _loc33_.mcSizer_rank.height;
                     _loc38_.x = _loc33_.mcSizer_rank.x;
                     _loc38_.y = _loc33_.mcSizer_rank.y;
                     _loc33_.addChild(_loc38_);
                     _loc39_ = new BMItem();
                     _loc39_.initialize(_loc19_.playerID,_loc11_,_loc12_,_loc33_,-1,-1,false,null,dataM.runAsMobile);
                     if(dataM.runAsMobile)
                     {
                        _loc43_ = [_loc33_.txtRank,_loc33_.txtName,_loc33_.txtLevel,_loc33_.txtArenaPoints];
                        _loc39_.createAssetsBitmap(_loc43_,[_loc38_],_loc33_);
                     }
                     _loc40_ = new BMTileListItem();
                     _loc41_ = this.rankingListItemClicked;
                     if(dataM.runAsMobile)
                     {
                        _loc41_ = null;
                     }
                     _loc40_.initialize(_loc11_,_loc12_,_loc39_,"","","",0,_loc41_,null,null,null,null,dataM.runAsMobile);
                     if(_loc36_)
                     {
                        _loc40_.itemsThatNeedsAddingAndRemoving.push(_loc42_);
                     }
                     _loc3_.push(_loc40_);
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
                     _loc7_ = new mcRankingListHeader_solo_mobile();
                     this.rankingTileList.activateExtendedMode(0.44,true);
                  }
                  else
                  {
                     _loc7_ = new mcRankingListHeader_solo();
                  }
                  updateTextAndFormat(_loc7_.txtPosition,getScreenText("position"));
                  updateTextAndFormat(_loc7_.txtName,getGeneralText("nameCaps"));
                  updateTextAndFormat(_loc7_.txtLevel,getGeneralText("levelCaps"));
                  updateTextAndFormat(_loc7_.txtArenaPoints,getGeneralText("arenaPointsCaps"));
                  this.rankingTileList.initialize(screensM.stagePointer.stage,_loc3_,_loc13_,1,_loc11_,_loc12_,null,true,_loc6_,null,_loc7_,false,0,1,true,_loc5_,dataM.runAsMobile);
                  this.rankingTileList.x = this.mcSizer_rankingTileList.x;
                  this.rankingTileList.y = this.mcSizer_rankingTileList.y;
                  if(dataM.runAsMobile)
                  {
                     _loc8_ = [_loc7_.txtPosition,_loc7_.txtName,_loc7_.txtLevel,_loc7_.txtArenaPoints];
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
                     screensM.addScreen(BMScreensManager.SCR_INSPECT_PLAYER);
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
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
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
         screensM.addScreen(BMScreensManager.SCR_INSPECT_PLAYER);
         screensM.screenInspectPlayer.refreshScreen(_loc3_.playerID,true,_loc3_.name,_loc3_.level,_loc3_.ladderProgress,_loc3_.clanID,param2);
      }
      
      public function backClicked() : void
      {
         if(screensM.screenTransitionsManager.cameFromClan && dataM.myProfile.clanID > 0)
         {
            screensM.screenTransitionsManager.communityClanClicked();
         }
         else
         {
            screensM.screenTransitionsManager.multiplayerLadderClicked();
         }
      }
      
      public function removeScreen() : void
      {
         dataM.playersGeneralData = new Object();
         this.deactivateWeeklyCountdown();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.removeMouseListeners();
         }
         screensM.removeScreen(BMScreensManager.SCR_RANKING_LIST);
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

