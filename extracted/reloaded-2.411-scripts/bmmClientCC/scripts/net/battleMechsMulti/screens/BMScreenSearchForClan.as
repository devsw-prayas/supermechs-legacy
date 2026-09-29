package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMClanRankingListData;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol610")]
   public class BMScreenSearchForClan extends BMBaseScreen
   {
      
      public var mcMainHolder:MovieClip;
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcSizer_btnPlayers:Sprite;
      
      public var mcSizer_btnClans:Sprite;
      
      public var mcSizer_btnClanSearch:Sprite;
      
      public var mcSizer_btnClanCreate:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnClans:BMButton;
      
      public var btnClanSearch:BMButton;
      
      public var btnClanCreate:BMButton;
      
      public var btnBack:BMButton_pictureE;
      
      public var mcSizer_rankingTileList:MovieClip;
      
      public var txtTitle:TextField;
      
      public var mcSandClock:MovieClip;
      
      private var rankingTileList:BMTileList;
      
      private var mcLevelRank:MovieClip;
      
      private var rankingListTimer:Timer;
      
      public var rankingListEnabled:Boolean = true;
      
      private var _rankingType:String = "clansOnly";
      
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
      
      public function BMScreenSearchForClan()
      {
         super();
      }
      
      public function BMScreenRankingList() : *
      {
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
      
      public function refreshScreen() : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenSearchForClan","btnClanSearch","regular");
            screensM.createButtonFromSizer("screenSearchForClan","btnClanCreate","regular");
            screensM.createButtonFromSizer("screenSearchForClan","btnBack","pictureE");
            _loc2_ = this.clanSearchClicked;
            _loc3_ = this.clanCreateClicked;
            _loc4_ = 34;
            _loc5_ = 34;
            switch(dataM.languageID)
            {
               case 10:
                  _loc4_ = 29;
                  _loc5_ = 27;
            }
            this.btnClanSearch.changeFontSize(_loc5_);
            this.btnClanCreate.changeFontSize(_loc5_);
            this.btnClanSearch.initialize(getScreenText("clanSearch"),"blue",null,[],_loc2_,dataM.runAsMobile);
            this.btnClanCreate.initialize(getScreenText("clanCreate"),"blue",null,[],_loc3_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnClanSearch.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnClanCreate.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this.createTitleBitmapForMobile();
            dataM.callingRankingListEnabled = true;
            this._titleInitialYPos = this.txtTitle.y;
            this._minuteLength = 60;
            this._hourLength = this._minuteLength * 60;
            this._dayLength = this._hourLength * 24;
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
         var _loc1_:Number = 0;
         if(dataM.clansAroundMyLadderProgress != null)
         {
            for each(_loc6_ in dataM.clansAroundMyLadderProgress)
            {
               _loc1_++;
            }
         }
         if(_loc1_ == 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
            remoteM.socketM.clan_getClansAroundMyLadderProgress();
            this.txtTitle.text = getScreenText("clans");
            this.txtTitle.y = this._titleInitialYPos + 6;
            this.createTitleBitmapForMobile();
         }
         else
         {
            this.clansClickedSub();
         }
         this.btnClanCreate.visible = true;
         this.btnClanSearch.visible = true;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.addMouseListeners();
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.btnClanCreate.txtButtonName);
            TextUtils.updateTextFormat(this.btnClanSearch.txtButtonName);
            param1 = true;
         }
         if(param1)
         {
            _loc2_ = 34;
            switch(dataM.languageID)
            {
               case 10:
                  _loc2_ = 27;
            }
            this.btnClanSearch.changeFontSize(_loc2_);
            this.btnClanCreate.changeFontSize(_loc2_);
            this.btnClanSearch.setButtonName(getScreenText("clanSearch"));
            this.btnClanCreate.setButtonName(getScreenText("clanCreate"));
         }
         this.createTitleBitmapForMobile();
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
         if(screensM.isScreenOpened("screenSearchForClan"))
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
      
      private function clansClickedSub() : void
      {
         this._rankingType = "clansOnly";
         this.txtTitle.text = getScreenText("clans");
         this.txtTitle.y = this._titleInitialYPos + 6;
         screensM.screenConfirmation.displayQuestionOrNotification("createOrJoinAClan",-1,-1);
         this.createTitleBitmapForMobile();
         this.getRankingListSuccess("clansClicked");
      }
      
      public function clansAroundMyLadderProgressLoaded() : void
      {
         screensM.removeScreen("screenConfirmation");
         this.clansClickedSub();
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
         var _loc19_:BMClanRankingListData = null;
         var _loc20_:Number = NaN;
         var _loc21_:Boolean = false;
         var _loc22_:MovieClip = null;
         var _loc23_:Boolean = false;
         var _loc24_:Number = NaN;
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
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Array = new Array();
         var _loc4_:Number = 0;
         var _loc11_:uint = this.RANKING_LIST_ROW_WIDTH;
         if(dataM.runAsMobile)
         {
            _loc11_ = this.RANKING_LIST_ROW_WIDTH_MOBILE;
         }
         _loc12_ = this.RANKING_LIST_CLANS_ROW_HEIGHT;
         _loc13_ = this.RANKING_LIST_CLANS_ROWS;
         if(dataM.runAsMobile)
         {
            _loc12_ = this.RANKING_LIST_CLANS_ROW_HEIGHT_MOBILE;
            _loc13_ = this.RANKING_LIST_CLANS_ROWS_MOBILE;
         }
         switch(this._rankingType)
         {
            case "clansOnly":
               _loc14_ = dataM.clansAroundMyLadderProgress;
               break;
            case "clansSearch":
               _loc14_ = this._clansForSearch;
         }
         var _loc18_:Array = new Array();
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
            _loc21_ = true;
            if(_loc19_.members >= dataM.clanMaxMembers)
            {
               _loc21_ = false;
            }
            if(_loc21_)
            {
               _loc4_++;
               if(dataM.runAsMobile)
               {
                  _loc22_ = new mcRankingListRow_clans_mobile();
               }
               else
               {
                  _loc22_ = new mcRankingListRow_clans();
               }
               TextUtils.updateTextFormat(_loc22_.txtWaitingForApproval,_loc15_);
               TextUtils.updateTextFormat(_loc22_.txtMembers,_loc15_);
               TextUtils.updateTextFormat(_loc22_.txtRank,_loc15_);
               TextUtils.updateTextFormat(_loc22_.txtName,15);
               TextUtils.updateTextFormat(_loc22_.txtLeaderName,13);
               TextUtils.updateTextFormat(_loc22_.txtWins,_loc15_);
               TextUtils.updateTextFormat(_loc22_.txtLoses,_loc15_);
               _loc22_.txtName.text = _loc19_.clanName;
               if(_loc19_.leaderName == null)
               {
                  _loc22_.txtLeaderName.text = "";
               }
               else
               {
                  _loc30_ = getScreenText("clanLeader");
                  _loc30_ = dataM.replaceStringInText(_loc30_,"%NAME%",_loc19_.leaderName);
                  _loc22_.txtLeaderName.text = _loc30_;
               }
               _loc23_ = false;
               if((this._rankingType == "clansOnly" || this._rankingType == "clansSearch") && _loc2_.clan_tryingToJoinClanID == _loc19_.clanID)
               {
                  _loc23_ = true;
               }
               if(_loc23_)
               {
                  _loc22_.txtWaitingForApproval.text = getScreenText("waitingForApproval");
                  _loc22_.txtMembers.text = "";
                  _loc22_.txtLoses.text = "";
                  _loc22_.txtWins.text = "";
               }
               else
               {
                  _loc22_.txtWaitingForApproval.text = "";
                  _loc22_.txtMembers.text = _loc19_.members + " / " + dataM.clanMaxMembers;
                  _loc22_.txtLoses.text = dataM.getNumberWithComma(_loc19_.ladderBattles - _loc19_.ladderWins);
                  _loc22_.txtWins.text = dataM.getNumberWithComma(_loc19_.ladderWins);
               }
               if(_loc23_)
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
               _loc22_.mcBackground.gotoAndStop(_loc9_);
               if(_loc19_.rank == 0)
               {
                  _loc22_.txtRank.text = "";
               }
               else
               {
                  _loc22_.txtRank.text = dataM.getNumberWithComma(_loc19_.rank);
               }
               _loc22_.txtRank.text = "";
               _loc24_ = _loc22_.mcSizer_rank.x - _loc22_.txtRank.x;
               _loc22_.txtName.x -= _loc24_;
               _loc22_.txtLeaderName.x -= _loc24_;
               _loc22_.mcSizer_rank.x -= _loc24_;
               if(_loc19_.flag != "")
               {
                  _loc31_ = dataM.getClanFlagData(_loc19_.flag);
                  if(_loc31_.length > 0)
                  {
                     _loc32_ = new BMClanFlag();
                     _loc33_ = externalAssetsM.getAsset("general","clanFlag",_loc22_.mcSizer_flag.width,_loc22_.mcSizer_flag.height,false,false);
                     _loc33_.x = _loc22_.mcSizer_flag.x;
                     _loc33_.y = _loc22_.mcSizer_flag.y;
                     _loc32_.initialize(_loc33_,dataM.runAsMobile);
                     _loc32_.updateFlag(_loc31_);
                     _loc22_.addChild(_loc33_);
                  }
               }
               _loc25_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc19_.ladderProgress));
               _loc26_ = externalAssetsM.getAsset("general","Grp_rank" + _loc25_,0,0,false,false);
               _loc26_.width = _loc22_.mcSizer_rank.width;
               _loc26_.height = _loc22_.mcSizer_rank.height;
               _loc26_.x = _loc22_.mcSizer_rank.x;
               _loc26_.y = _loc22_.mcSizer_rank.y;
               _loc22_.addChild(_loc26_);
               _loc27_ = new BMItem();
               _loc27_.initialize(_loc19_.clanID,_loc11_,_loc12_,_loc22_,-1,-1,false,null,dataM.runAsMobile);
               if(dataM.runAsMobile)
               {
                  _loc34_ = [_loc22_.txtRank,_loc22_.txtName,_loc22_.txtMembers,_loc22_.txtLoses,_loc22_.txtWins,_loc22_.txtWaitingForApproval];
                  _loc27_.createAssetsBitmap(_loc34_,[_loc26_],_loc22_);
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
            _loc7_.txtPosition.text = "";
            _loc7_.txtName.x = _loc7_.txtPosition.x;
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
         this.rankingTileList.scrollToID(dataM.userID,"center","tileListItemID");
         this.rankingTileList.visible = true;
         this.mcSandClock.gotoAndStop("animOff");
      }
      
      private function rankingListItemClicked(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:BMPlayerProfile = null;
         var _loc5_:BMTileListItem = null;
         var _loc6_:BMTileListItem = null;
         if(this.rankingListEnabled)
         {
            _loc3_ = param2;
            _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc4_.clan_tryingToJoinClanID > 0)
            {
               _loc5_ = this.rankingTileList.findTileListItemByTileListItemID(_loc4_.clan_tryingToJoinClanID);
               if(_loc5_ != null)
               {
                  if(param1 % 2 == 0)
                  {
                     _loc5_.item.itemGrp.mcBackground.gotoAndStop("regular1");
                  }
                  else
                  {
                     _loc5_.item.itemGrp.mcBackground.gotoAndStop("regular2");
                  }
               }
            }
            if(_loc4_.clan_tryingToJoinClanID != _loc3_)
            {
               if(dataM.clansRankingList[_loc3_] == null)
               {
                  switch(this._rankingType)
                  {
                     case "clansOnly":
                        if(dataM.clansAroundMyLadderProgress[_loc3_] != null)
                        {
                           dataM.clansRankingList[_loc3_] = dataM.clansAroundMyLadderProgress[_loc3_];
                        }
                        break;
                     case "clansSearch":
                        if(this._clansForSearch[_loc3_] != null)
                        {
                           dataM.clansRankingList[_loc3_] = this._clansForSearch[_loc3_];
                        }
                  }
               }
               remoteM.socketM.clan_requestToJoin(_loc3_);
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               _loc6_ = this.rankingTileList.findTileListItemByTileListItemID(_loc3_);
               if(_loc6_ != null)
               {
                  _loc6_.item.itemGrp.mcBackground.gotoAndStop("online");
               }
            }
            soundM.createSound("buttonClick",1);
         }
      }
      
      public function requestToJoinDeclined() : void
      {
         if(screensM.isScreenOpened("screenSearchForClan"))
         {
            this.getRankingListSuccess("requestToJoinDeclined");
         }
      }
      
      public function clanSearchClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("clanSearch",-1,-1);
      }
      
      public function clanCreateClicked() : void
      {
         screensM.addScreen("screenClanCreate");
         screensM.screenClanCreate.refreshScreen();
      }
      
      public function searchForClansSuccess(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc4_:BMClanRankingListData = null;
         screensM.removeScreen("screenConfirmation");
         this._clansForSearch = new Object();
         this._rankingType = "clansSearch";
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = new BMClanRankingListData();
            _loc4_.clanID = _loc3_.clanID;
            _loc4_.rank = 0;
            _loc4_.clanName = dataM.getCensoredString(_loc3_.name);
            _loc4_.leaderID = _loc3_.leaderID;
            _loc4_.leaderName = dataM.getCensoredString(_loc3_.leaderName);
            _loc4_.ladderProgress = _loc3_.ladderProgress;
            _loc4_.rankedValue = _loc3_.rankedValue;
            _loc4_.members = _loc3_.members;
            _loc4_.ladderBattles = _loc3_.ladderBattles;
            _loc4_.ladderWins = _loc3_.ladderWins;
            this._clansForSearch[_loc3_.clanID] = _loc4_;
            _loc2_++;
         }
         this.getRankingListSuccess("searchForClansSuccess");
      }
      
      public function createClanNotEnoughGoldOKClicked() : void
      {
         screensM.screenClanCreate.refreshScreen();
         screensM.addScreen("screenBuyGold");
         screensM.screenBuyGold.refreshScreen();
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.multiplayerLadderClicked();
      }
      
      public function removeScreen() : void
      {
         dataM.playersGeneralData = new Object();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.removeMouseListeners();
         }
         screensM.removeScreen("screenSearchForClan");
         if(this.rankingTileList != null)
         {
            this.rankingTileList.removeMe();
            this.rankingTileList = null;
         }
      }
   }
}

