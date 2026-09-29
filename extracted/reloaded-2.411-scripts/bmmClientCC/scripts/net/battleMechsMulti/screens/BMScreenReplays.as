package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMReplayData;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol607")]
   public class BMScreenReplays extends BMBaseScreen
   {
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcSizer_btnPlay:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcMechsHolder:Sprite;
      
      public var mcMech1Pos:Sprite;
      
      public var mcMech2Pos:Sprite;
      
      public var txtNoReplays:TextField;
      
      public var txtTitle:TextField;
      
      public var btnPlay:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureE;
      
      private var replaysTileList:BMTileList;
      
      private var _selectedReplayID:Number;
      
      private var _selectedTileID:Number;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _firstRefresh:Boolean = true;
      
      private var mechView1:BMMechView;
      
      private var mechView2:BMMechView;
      
      private const REPLAY_ROWS:uint = 12;
      
      private const REPLAY_ROW_WIDTH:uint = 382;
      
      private const REPLAY_ROW_HEIGHT:uint = 30;
      
      private const REPLAY_ROWS_MOBILE:uint = 11;
      
      private const REPLAY_ROW_WIDTH_MOBILE:uint = 425;
      
      private const REPLAY_ROW_HEIGHT_MOBILE:uint = 32;
      
      public function BMScreenReplays()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("replays");
      }
      
      public function cancelFingerWheeling() : void
      {
         this._fingerWheeling.cancelFingerWheeling();
      }
      
      private function createNoReplaysTextBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("replays_noReplays",[this.txtNoReplays],"",this);
         }
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenReplays","btnPlay","pictureE");
            screensM.createButtonFromSizer("screenReplays","btnBack","pictureE");
            _loc1_ = this.playClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
            }
            this.btnPlay.initialize("","",externalAssetsM.getAsset("general","interface_play"),null,_loc1_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this.createNoReplaysTextBitmapForMobile();
            if(dataM.runAsMobile)
            {
               this._fingerWheeling = new BMFingerWheeling();
               this._fingerWheeling.initialize("replays",this.replaysTileList,this.mcFingerWheeling,this.tileListItemClicked,null,false);
               addChild(this._fingerWheeling);
            }
            else
            {
               this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
            }
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this.removeMechs();
         this._selectedReplayID = 0;
         this._selectedTileID = -1;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.addMouseListeners();
         }
         if(dataM.replays_loaded)
         {
            this.refreshReplaysTileList();
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
            remoteM.socketM.lobby_getPlayerReplays(dataM.userID);
         }
         this.refreshButtons();
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtNoReplays,14);
            TextUtils.updateTextFormat(this.txtTitle,20);
         }
         this.txtTitle.text = getScreenText("title");
         this.txtNoReplays.text = getScreenText("noReplays");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("replays_title",[this.txtTitle],"",this);
         }
      }
      
      public function replaysLoadedSuccess() : void
      {
         dataM.replays_loaded = true;
         screensM.removeScreen("screenConfirmation");
         this.refreshReplaysTileList();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(screensM.isScreenOpened("screenReplays"))
         {
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.onEnterFrameTrigger();
            }
         }
      }
      
      public function refreshReplaysTileList() : void
      {
         var _loc4_:BMReplayData = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:String = null;
         var _loc11_:BMPlayerProfile = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Sprite = null;
         var _loc15_:BMItem = null;
         var _loc16_:BMTileListItem = null;
         var _loc17_:Function = null;
         var _loc18_:MovieClip = null;
         var _loc19_:Boolean = false;
         var _loc20_:MovieClip = null;
         var _loc21_:MovieClip = null;
         var _loc22_:uint = 0;
         var _loc23_:Number = NaN;
         var _loc1_:Array = new Array();
         var _loc2_:Number = 0;
         var _loc3_:Array = new Array();
         for each(_loc4_ in dataM.replaysDB_online)
         {
            _loc3_.push({"replayID":_loc4_.replayID});
         }
         _loc3_.sortOn("replayID",Array.NUMERIC);
         _loc5_ = this.REPLAY_ROWS;
         _loc6_ = this.REPLAY_ROW_WIDTH;
         _loc7_ = this.REPLAY_ROW_HEIGHT;
         if(dataM.runAsMobile)
         {
            _loc5_ = this.REPLAY_ROWS_MOBILE;
            _loc6_ = this.REPLAY_ROW_WIDTH_MOBILE;
            _loc7_ = this.REPLAY_ROW_HEIGHT_MOBILE;
         }
         if(_loc3_.length > 0)
         {
            if(this._selectedTileID == -1)
            {
               this._selectedTileID = 0;
            }
         }
         var _loc8_:uint = 0;
         while(_loc8_ < _loc3_.length)
         {
            _loc4_ = dataM.replaysDB_online[_loc3_[_loc8_].replayID];
            if(_loc8_ == this._selectedTileID)
            {
               this._selectedReplayID = _loc4_.replayID;
            }
            _loc2_++;
            if(dataM.runAsMobile)
            {
               _loc9_ = new mcReplayListRow_mobile();
               _loc9_.mcBackground.height = _loc7_;
            }
            else
            {
               _loc9_ = new mcReplayListRow();
            }
            if(_loc8_ == this._selectedTileID)
            {
               _loc9_.mcBackground.gotoAndStop("selected");
               this._selectedReplayID = _loc4_.replayID;
            }
            _loc11_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc11_.playerName == _loc4_.playerName1)
            {
               _loc10_ = _loc2_ + " - VS " + dataM.getCensoredString(_loc4_.playerName2);
            }
            else if(_loc11_.playerName == _loc4_.playerName2)
            {
               _loc10_ = _loc2_ + " - VS " + dataM.getCensoredString(_loc4_.playerName1);
            }
            else
            {
               _loc10_ = _loc2_ + " - " + dataM.getCensoredString(_loc4_.playerName1) + " VS " + dataM.getCensoredString(_loc4_.playerName2);
            }
            TextUtils.updateTextFormat(_loc9_.txtDescription,15);
            _loc9_.txtDescription.text = _loc10_;
            _loc9_.txtTurns.text = _loc4_.numberOfTurns;
            _loc12_ = "1V1";
            if(_loc4_.battleMechsPerPlayer == 2)
            {
               _loc12_ = "2V2";
            }
            else if(_loc4_.battleMechsPerPlayer == 3)
            {
               _loc12_ = "3V3";
            }
            _loc9_.txtType.text = _loc12_;
            _loc13_ = getScreenText("win");
            if(_loc4_.wonPlayerID > 0)
            {
               if(_loc4_.wonPlayerID != dataM.userID)
               {
                  _loc13_ = getScreenText("lose");
               }
            }
            else if(_loc4_.quitPlayerID == dataM.userID)
            {
               _loc13_ = getScreenText("lose");
            }
            TextUtils.updateTextFormat(_loc9_.txtWinLoss,15);
            _loc9_.txtWinLoss.text = _loc13_;
            _loc14_ = _loc9_.mcSizer_watched;
            if(_loc2_ % 2 == 0)
            {
               _loc9_.mcBackground.gotoAndStop("regular2");
            }
            if(_loc4_.watched)
            {
               _loc18_ = externalAssetsM.getAsset("general","interface_V",_loc14_.width,_loc14_.height,false,false);
               _loc18_.x = _loc14_.x;
               _loc18_.y = _loc14_.y;
               _loc9_.addChild(_loc18_);
            }
            if(this._selectedReplayID == _loc4_.replayID)
            {
               _loc9_.mcBackground.gotoAndStop("selected");
            }
            _loc15_ = new BMItem();
            _loc15_.initialize(_loc4_.replayID,_loc6_,_loc7_,_loc9_,-1,-1,false,null,dataM.runAsMobile);
            if(dataM.runAsMobile)
            {
               _loc15_.createAssetsBitmap([_loc9_.txtDescription,_loc9_.txtTurns,_loc9_.txtType,_loc9_.txtWinLoss],[],_loc9_);
            }
            _loc16_ = new BMTileListItem();
            _loc17_ = this.tileListItemClicked;
            if(dataM.runAsMobile)
            {
               _loc17_ = null;
            }
            _loc16_.initialize(_loc6_,_loc7_,_loc15_,"","","",0,_loc17_,null,null,null,null,dataM.runAsMobile);
            _loc1_.push(_loc16_);
            _loc8_++;
         }
         if(this.replaysTileList == null)
         {
            this.replaysTileList = new BMTileList();
            _loc19_ = false;
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.resetTileList(this.replaysTileList);
               _loc19_ = true;
            }
            _loc20_ = new Grp_scrollerContent();
            if(dataM.runAsMobile)
            {
               _loc21_ = new mcReplayListHeader_mobile();
               this.replaysTileList.activateExtendedMode(0.35,true);
            }
            else
            {
               _loc21_ = new mcReplayListHeader();
            }
            _loc22_ = 13;
            switch(dataM.languageID)
            {
               case 7:
                  _loc22_ = 10;
            }
            TextUtils.updateTextFormat(_loc21_.txtDescription,13);
            TextUtils.updateTextFormat(_loc21_.txtTurns,_loc22_);
            TextUtils.updateTextFormat(_loc21_.txtType,_loc22_);
            TextUtils.updateTextFormat(_loc21_.txtResult,_loc22_);
            _loc21_.txtDescription.text = getScreenText("description");
            _loc21_.txtTurns.text = getScreenText("turns");
            _loc21_.txtType.text = getScreenText("type");
            _loc21_.txtResult.text = getScreenText("result");
            this.replaysTileList.initialize(screensM.stagePointer.stage,_loc1_,_loc5_,1,_loc6_,_loc7_,null,true,_loc20_,null,_loc21_,false,0,1,true,_loc19_,dataM.runAsMobile);
            this.replaysTileList.x = this.mcSizer_tileList.x;
            this.replaysTileList.y = this.mcSizer_tileList.y;
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("replays_header",[_loc21_.txtDescription,_loc21_.txtTurns,_loc21_.txtType,_loc21_.txtResult],"",_loc21_);
            }
            this.mcButtonsHolder.addChild(this.replaysTileList);
         }
         else
         {
            _loc23_ = this.replaysTileList.getCurrentRow();
            this.replaysTileList.removeAllItems();
            this.replaysTileList.addItems(0,_loc1_,true);
            this.replaysTileList.jumpToRow(_loc23_,false,"screenReplays - refreshReplaysTileList");
         }
         if(_loc1_.length > 0)
         {
            this.txtNoReplays.visible = false;
            this.replaysTileList.visible = true;
            if(this._selectedTileID > -1)
            {
               this.tileListItemClicked(this._selectedTileID,this._selectedReplayID,true);
            }
         }
         else
         {
            this._selectedTileID = -1;
            this.txtNoReplays.visible = true;
            this.replaysTileList.visible = false;
         }
         this.createNoReplaysTextBitmapForMobile();
         this.refreshPlayButton();
      }
      
      private function tileListItemClicked(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         var _loc4_:BMTileListItem = null;
         var _loc5_:String = null;
         var _loc6_:BMTileListItem = null;
         if(param3 || param1 > -1 && param1 != this._selectedTileID)
         {
            this._selectedReplayID = param2;
            _loc4_ = this.replaysTileList.findTileListItemByTileID(this._selectedTileID);
            _loc5_ = "regular2";
            if(_loc4_.tileID % 2 == 0)
            {
               _loc5_ = "regular1";
            }
            _loc4_.item.itemGrp.mcBackground.gotoAndStop(_loc5_);
            _loc6_ = this.replaysTileList.findTileListItemByTileID(param1);
            _loc6_.item.itemGrp.mcBackground.gotoAndStop("selected");
            this._selectedTileID = param1;
            this.createMechs(dataM.replaysDB_online,this._selectedReplayID);
            if(param3 == false)
            {
               soundM.createSound("buttonClick",1);
            }
         }
      }
      
      public function playClicked() : void
      {
         var _loc2_:BMTileListItem = null;
         var _loc3_:Sprite = null;
         var _loc4_:MovieClip = null;
         var _loc1_:BMReplayData = dataM.replaysDB_online[this._selectedReplayID];
         if(_loc1_.watched == false)
         {
            _loc2_ = this.replaysTileList.findTileListItemByTileListItemID(this._selectedReplayID);
            _loc3_ = _loc2_.item.itemGrp.mcSizer_watched;
            _loc4_ = externalAssetsM.getAsset("general","interface_V",_loc3_.width,_loc3_.height,false,false);
            _loc4_.x = _loc3_.x;
            _loc4_.y = _loc3_.y;
            _loc2_.item.itemGrp.addChild(_loc4_);
         }
         screensM.screenBlack.activateBlackScreen(this.activateReplay,true,true,null,0);
      }
      
      private function activateReplay() : void
      {
         dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_REPLAY,BMDataManager.GAME_SUB_TYPE_REPLAY_REGULAR,"replays");
         dataM.unpackReplay(this._selectedReplayID);
      }
      
      public function refreshPlayButton() : void
      {
         if(this._selectedTileID > -1)
         {
            this.btnPlay.enableMe();
         }
         else
         {
            this.btnPlay.disableMe();
         }
      }
      
      public function createMechs(param1:Object, param2:Number = -1) : void
      {
         this.removeMechs();
         var _loc3_:BMReplayData = dataM.replaysDB_online[this._selectedReplayID];
         var _loc4_:Number = 0.45;
         this.mechView1 = new BMMechView();
         this.mechView1.useLegsShadow = true;
         this.mechView1.initialize(dataM.REPLAY_PLAYER1_ID,"battle","itemID",_loc4_,false);
         this.mechView1.buildMech(_loc3_.player1MechStructures[1],"replays");
         this.mechView1.x = this.mcMech1Pos.x;
         this.mechView1.y = this.mcMech1Pos.y - (this.mechView1.mechSizer.height + this.mechView1.mechSizer.y);
         this.mcMechsHolder.addChild(this.mechView1);
         this.mechView2 = new BMMechView();
         this.mechView2.useLegsShadow = true;
         this.mechView2.initialize(dataM.REPLAY_PLAYER2_ID,"battle","itemID",_loc4_,false);
         this.mechView2.buildMech(_loc3_.player2MechStructures[1],"replays");
         this.mechView2.x = this.mcMech2Pos.x;
         this.mechView2.y = this.mcMech2Pos.y - (this.mechView2.mechSizer.height + this.mechView2.mechSizer.y);
         this.mcMechsHolder.addChild(this.mechView2);
         this.mechView2.scaleX *= -1;
      }
      
      private function removeMechs() : void
      {
         if(this.mechView1 != null)
         {
            this.mechView1.removeMe();
         }
         if(this.mechView2 != null)
         {
            this.mechView2.removeMe();
         }
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.multiplayerLadderClicked();
      }
      
      private function refreshButtons() : void
      {
      }
      
      private function disableAllButtons() : void
      {
      }
      
      public function removeMe() : void
      {
         this.removeMechs();
         screensM.removeScreen("screenReplays");
         this.replaysTileList.removeMe();
         this.replaysTileList = null;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.removeMouseListeners();
         }
      }
   }
}

