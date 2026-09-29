package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1552")]
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
            screensM.createButtonFromSizer(BMScreensManager.SCR_SEACH_FOR_CLAN,"btnClanSearch","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_SEACH_FOR_CLAN,"btnClanCreate","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_SEACH_FOR_CLAN,"btnBack","pictureE");
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
            updateTextAndFormat(this.txtTitle,getScreenText("clans"));
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_SEACH_FOR_CLAN))
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
         updateTextAndFormat(this.txtTitle,getScreenText("clans"));
         this.txtTitle.y = this._titleInitialYPos + 6;
         screensM.screenConfirmation.displayQuestionOrNotification("createOrJoinAClan",-1,-1);
         this.createTitleBitmapForMobile();
         this.getRankingListSuccess("clansClicked");
      }
      
      public function clansAroundMyLadderProgressLoaded() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
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
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc19_:BMClanRankingListData = null;
         var _loc20_:Number = NaN;
         var _loc21_:Boolean = false;
         var _loc22_:MovieClip = null;
         var _loc23_:String = null;
         var _loc24_:Boolean = false;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:String = null;
         var _loc29_:String = null;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Sprite = null;
         var _loc33_:BMItem = null;
         var _loc34_:BMTileListItem = null;
         var _loc35_:Function = null;
         var _loc36_:Array = null;
         var _loc37_:BMClanFlag = null;
         var _loc38_:MovieClip = null;
         var _loc39_:Array = null;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Array = new Array();
         var _loc4_:Number = 0;
         var _loc11_:uint = this.RANKING_LIST_ROW_WIDTH;
         if(dataM.runAsMobile)
         {
            _loc11_ = this.RANKING_LIST_ROW_WIDTH_MOBILE;
         }
         var _loc14_:Object = this.getTargetRankingListData();
         _loc12_ = this.RANKING_LIST_CLANS_ROW_HEIGHT;
         _loc13_ = this.RANKING_LIST_CLANS_ROWS;
         if(dataM.runAsMobile)
         {
            _loc12_ = this.RANKING_LIST_CLANS_ROW_HEIGHT_MOBILE;
            _loc13_ = this.RANKING_LIST_CLANS_ROWS_MOBILE;
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
                  _loc22_ = new mcRankingListRow_clanSearch_mobile();
               }
               else
               {
                  _loc22_ = new mcRankingListRow_clanSearch();
               }
               updateTextAndFormat(_loc22_.txtName,_loc19_.clanName);
               _loc23_ = "";
               if(_loc19_.leaderName != null)
               {
                  _loc23_ = getScreenText("clanLeader");
                  _loc23_ = dataM.replaceStringInText(_loc23_,"%NAME%",_loc19_.leaderName);
               }
               updateTextAndFormat(_loc22_.txtLeaderName,_loc23_);
               _loc24_ = false;
               if((this._rankingType == "clansOnly" || this._rankingType == "clansSearch") && _loc2_.clan_tryingToJoinClanID == _loc19_.clanID)
               {
                  _loc24_ = true;
               }
               _loc25_ = "";
               _loc26_ = "";
               _loc27_ = "";
               _loc28_ = "";
               if(_loc24_)
               {
                  _loc25_ = getScreenText("waitingForApproval");
               }
               else
               {
                  _loc26_ = _loc19_.members + " / " + dataM.clanMaxMembers;
                  _loc27_ = TextUtils.getNumberWithComma(_loc19_.arenaPoints);
                  _loc28_ = TextUtils.getNumberWithComma(_loc19_.ladderWins);
               }
               updateTextAndFormat(_loc22_.txtWaitingForApproval,_loc25_);
               updateTextAndFormat(_loc22_.txtMembers,_loc26_);
               updateTextAndFormat(_loc22_.txtArenaPoints,_loc27_);
               updateTextAndFormat(_loc22_.txtWins,_loc28_);
               if(_loc24_)
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
               _loc29_ = "";
               if(_loc19_.rank > 0)
               {
                  _loc29_ = TextUtils.getNumberWithComma(_loc19_.rank);
               }
               updateTextAndFormat(_loc22_.txtRank,_loc29_);
               _loc22_.txtRank.text = "";
               _loc30_ = _loc22_.mcSizer_rank.x - _loc22_.txtRank.x;
               _loc22_.txtName.x -= _loc30_;
               _loc22_.txtLeaderName.x -= _loc30_;
               _loc22_.mcSizer_rank.x -= _loc30_;
               if(_loc19_.flag != "")
               {
                  _loc36_ = dataM.getClanFlagData(_loc19_.flag);
                  if(_loc36_.length > 0)
                  {
                     _loc37_ = new BMClanFlag();
                     _loc38_ = externalAssetsM.getAsset("general","clanFlag",_loc22_.mcSizer_flag.width,_loc22_.mcSizer_flag.height,false,false);
                     _loc38_.x = _loc22_.mcSizer_flag.x;
                     _loc38_.y = _loc22_.mcSizer_flag.y;
                     _loc37_.initialize(_loc38_,dataM.runAsMobile);
                     _loc37_.updateFlag(_loc36_);
                     _loc22_.addChild(_loc38_);
                  }
               }
               _loc31_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc19_.ladderProgress));
               _loc32_ = externalAssetsM.getAsset("general","Grp_rank" + _loc31_,0,0,false,false);
               _loc32_.width = _loc22_.mcSizer_rank.width;
               _loc32_.height = _loc22_.mcSizer_rank.height;
               _loc32_.x = _loc22_.mcSizer_rank.x;
               _loc32_.y = _loc22_.mcSizer_rank.y;
               _loc22_.addChild(_loc32_);
               _loc33_ = new BMItem();
               _loc33_.initialize(_loc19_.clanID,_loc11_,_loc12_,_loc22_,-1,-1,false,null,dataM.runAsMobile);
               if(dataM.runAsMobile)
               {
                  _loc39_ = [_loc22_.txtRank,_loc22_.txtName,_loc22_.txtMembers,_loc22_.txtArenaPoints,_loc22_.txtWins,_loc22_.txtWaitingForApproval];
                  _loc33_.createAssetsBitmap(_loc39_,[_loc32_],_loc22_);
               }
               _loc34_ = new BMTileListItem();
               _loc35_ = this.rankingListItemClicked;
               if(dataM.runAsMobile)
               {
                  _loc35_ = null;
               }
               _loc34_.initialize(_loc11_,_loc12_,_loc33_,"","","",0,_loc35_,null,null,null,null,dataM.runAsMobile);
               _loc3_.push(_loc34_);
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
               _loc7_ = new mcRankingListHeader_clanSearch_mobile();
               this.rankingTileList.activateExtendedMode(0.44,true);
            }
            else
            {
               _loc7_ = new mcRankingListHeader_clanSearch();
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
            TextUtils.updateTextFormat(_loc7_.txtArenaPoints,_loc17_);
            _loc7_.txtPosition.text = "";
            _loc7_.txtName.x = _loc7_.txtPosition.x;
            updateTextAndFormat(_loc7_.txtName,getGeneralText("nameCaps"));
            updateTextAndFormat(_loc7_.txtMembers,getScreenText("members"));
            updateTextAndFormat(_loc7_.txtWins,getScreenText("wins"));
            updateTextAndFormat(_loc7_.txtArenaPoints,getGeneralText("arenaPointsCaps"));
            this.rankingTileList.initialize(screensM.stagePointer.stage,_loc3_,_loc13_,1,_loc11_,_loc12_,null,true,_loc6_,null,_loc7_,false,_loc20_ - 4,1,true,_loc5_,dataM.runAsMobile);
            this.rankingTileList.x = this.mcSizer_rankingTileList.x;
            this.rankingTileList.y = this.mcSizer_rankingTileList.y;
            if(dataM.runAsMobile)
            {
               _loc8_ = [_loc7_.txtPosition,_loc7_.txtName,_loc7_.txtMembers,_loc7_.txtWins,_loc7_.txtArenaPoints];
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
      
      private function getTargetRankingListData() : Object
      {
         var _loc1_:Object = null;
         switch(this._rankingType)
         {
            case "clansOnly":
               _loc1_ = dataM.clansAroundMyLadderProgress;
               break;
            case "clansSearch":
               _loc1_ = this._clansForSearch;
         }
         return _loc1_;
      }
      
      private function rankingListItemClicked(param1:Number, param2:Number) : void
      {
         var _loc6_:BMTileListItem = null;
         if(this.rankingListEnabled == false)
         {
            return;
         }
         soundM.createSound("buttonClick",1);
         var _loc3_:Number = param2;
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc5_:BMClanRankingListData = this.getTargetRankingListData()[_loc3_];
         if(_loc5_.requiredRankToJoin < dataM.getLadderRankByProgress(_loc4_.ladderProgress))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("clanRequiredRankToJoinTooHigh",_loc5_.requiredRankToJoin);
            return;
         }
         if(_loc4_.clan_tryingToJoinClanID > 0)
         {
            _loc6_ = this.rankingTileList.findTileListItemByTileListItemID(_loc4_.clan_tryingToJoinClanID);
            if(_loc6_ != null)
            {
               if(param1 % 2 == 0)
               {
                  _loc6_.item.itemGrp.mcBackground.gotoAndStop("regular1");
               }
               else
               {
                  _loc6_.item.itemGrp.mcBackground.gotoAndStop("regular2");
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
            screensM.screenConfirmation.displayQuestionOrNotification("doYouWantToJoinThisClan",_loc3_);
         }
      }
      
      public function getClanName(param1:uint) : String
      {
         var _loc2_:Object = this.getTargetRankingListData();
         var _loc3_:BMClanRankingListData = _loc2_[param1];
         if(_loc3_ == null)
         {
            return "";
         }
         return _loc3_.clanName;
      }
      
      public function clanSelected(param1:uint) : void
      {
         remoteM.socketM.clan_requestToJoin(param1);
         var _loc2_:BMTileListItem = this.rankingTileList.findTileListItemByTileListItemID(param1);
         if(_loc2_ != null)
         {
            _loc2_.item.itemGrp.mcBackground.gotoAndStop("online");
         }
      }
      
      public function requestToJoinDeclined() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_SEACH_FOR_CLAN))
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
         screensM.addScreen(BMScreensManager.SCR_CLAN_CREATE);
         screensM.screenClanCreate.refreshScreen();
      }
      
      public function searchForClansSuccess(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc4_:BMClanRankingListData = null;
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
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
            _loc4_.requiredRankToJoin = 999;
            _loc4_.arenaPoints = _loc3_.rankedValue;
            if(_loc3_.requiredRankToJoin != null)
            {
               _loc4_.requiredRankToJoin = _loc3_.requiredRankToJoin;
            }
            this._clansForSearch[_loc3_.clanID] = _loc4_;
            _loc2_++;
         }
         this.getRankingListSuccess("searchForClansSuccess");
      }
      
      public function createClanNotEnoughGoldOKClicked() : void
      {
         screensM.screenClanCreate.backClicked();
         BMShopManager.gi().showGoldPackages();
      }
      
      public function backClicked(param1:Boolean = false) : void
      {
         if(param1)
         {
            screensM.screenTransitionsManager.communityClanClicked();
            return;
         }
         screensM.screenTransitionsManager.mainMenu();
      }
      
      public function removeScreen() : void
      {
         dataM.playersGeneralData = new Object();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.removeMouseListeners();
         }
         screensM.removeScreen(BMScreensManager.SCR_SEACH_FOR_CLAN);
         if(this.rankingTileList != null)
         {
            this.rankingTileList.removeMe();
            this.rankingTileList = null;
         }
      }
   }
}

