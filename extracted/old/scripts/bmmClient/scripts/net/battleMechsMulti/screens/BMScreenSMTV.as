package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMPlayerRankingListData;
   import net.battleMechsMulti.mobiles.BMReplayData;
   import net.tacticsoft.global.BMMClientFlashVars;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol781")]
   public class BMScreenSMTV extends BMBaseScreen
   {
      
      public var mcSMTVHolder:MovieClip;
      
      public var mcSizer_SMTV:Sprite;
      
      public var mcSMTV:MovieClip;
      
      public var txtSMTVLink:TextField;
      
      private var _watchReplayPlayerID:Number = 0;
      
      private var _watchReplayReplayID:Number = 0;
      
      private var _watchReplayGotList:Boolean = false;
      
      private var _watchReplaySearchAttemps:Number = 0;
      
      private var _watchReplaySkipPlayerIDs:Object = new Object();
      
      private var _TVScreensFrameCounter:Number = 0;
      
      private var _TVScreensCurrentFrame:String = "";
      
      private var _type:String;
      
      private var _adsCounter:uint = 0;
      
      private var _firstRefresh:Boolean = true;
      
      private var watchReplayMech1:BMMechView;
      
      private var watchReplayMech2:BMMechView;
      
      private const TV_SCREEN_FRAMES:Number = 150;
      
      public function BMScreenSMTV()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("smtv");
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.SMTVScreensHandler();
         }
      }
      
      public function addMe(param1:String) : void
      {
         if(this._firstRefresh)
         {
            if(false)
            {
               this._TVScreensCurrentFrame = "youtube";
            }
            else
            {
               this._TVScreensCurrentFrame = "vsBattles";
            }
            this.mcSMTV = externalAssetsM.getAsset("general","newInterfaceSMTV2",0,0,false,false);
            if(dataM.runAsMobile == false)
            {
               this.mcSMTV.mcHitAreaGeneral.addEventListener(MouseEvent.CLICK,this.SMTVClicked);
               this.mcSMTV.mcHitAreaGeneral.addEventListener(MouseEvent.MOUSE_OVER,this.SMTVMouseOver);
               this.mcSMTV.mcHitAreaGeneral.addEventListener(MouseEvent.MOUSE_OUT,this.SMTVMouseOut);
            }
            this.mcSMTV.mcMouseEffect.alpha = 0;
            this.mcSMTV.width = this.mcSizer_SMTV.width;
            this.mcSMTV.height = this.mcSizer_SMTV.height;
            this.txtSMTVLink.mouseEnabled = false;
            this.mcSMTVHolder.addChild(this.mcSMTV);
            this._firstRefresh = false;
         }
         this._type = param1;
         if(parent != null)
         {
            screensM.removeScreen("screenSMTV");
         }
         screensM.addScreen("screenSMTV");
         switch(this._type)
         {
            case "multiplayerLadder":
               x = screensM.screenMultiPlayerLadder.mcSizer_SMTV.x;
               y = screensM.screenMultiPlayerLadder.mcSizer_SMTV.y;
               width = screensM.screenMultiPlayerLadder.mcSizer_SMTV.width;
               height = screensM.screenMultiPlayerLadder.mcSizer_SMTV.height;
               this.moveToNextTVScreen();
               break;
            case "replays":
         }
      }
      
      private function SMTVScreensHandler() : void
      {
         var _loc1_:Number = NaN;
         switch(this._type)
         {
            case "multiplayer":
            case "multiplayerLadder":
               if(this.mcSMTV.visible)
               {
                  ++this._TVScreensFrameCounter;
                  _loc1_ = this.TV_SCREEN_FRAMES;
                  if(this._TVScreensFrameCounter == _loc1_)
                  {
                     this.moveToNextTVScreen();
                     this.mcSMTV.mcScreens.mcBlackScreen.gotoAndPlay("animOn");
                  }
               }
         }
      }
      
      public function refreshWatchReplay() : void
      {
         var _loc2_:BMPlayerRankingListData = null;
         this.showSMTV();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(dataM.rankingList_allTime == null)
         {
            remoteM.lobby_rankingList();
         }
         else if(this._watchReplaySearchAttemps < 4)
         {
            this._watchReplayPlayerID = 0;
            for each(_loc2_ in dataM.rankingList_allTime)
            {
               if(this._watchReplayPlayerID == 0)
               {
                  if(this._watchReplaySkipPlayerIDs[_loc2_.playerID] == null && dataM.getLadderRankByProgress(_loc2_.ladderProgress) <= 6 && _loc2_.playerID != dataM.userID)
                  {
                     this._watchReplayPlayerID = _loc2_.playerID;
                  }
               }
            }
            if(this._watchReplayPlayerID > 0)
            {
               if(this._watchReplayGotList)
               {
                  this.gotOnlinePlayerReplays("refreshWatchReplay");
               }
               else
               {
                  remoteM.lobby_getPlayerReplays(this._watchReplayPlayerID);
               }
            }
         }
      }
      
      public function gotOnlinePlayerReplays(param1:String = "") : void
      {
         var _loc3_:BMReplayData = null;
         this._watchReplayGotList = true;
         this._watchReplayReplayID = 0;
         var _loc2_:Number = 0;
         for each(_loc3_ in dataM.replaysDB_inspect)
         {
            if(this._watchReplayReplayID == 0)
            {
               if(_loc3_.numberOfTurns >= 10 && _loc3_.quitPlayerID == 0 && _loc3_.watched == false)
               {
                  _loc2_++;
                  this._watchReplayReplayID = _loc3_.replayID;
                  this.createReplayMechs(dataM.replaysDB_inspect);
               }
            }
         }
         if(_loc2_ == 0)
         {
            this._watchReplaySkipPlayerIDs[this._watchReplayPlayerID] = true;
            this._watchReplayPlayerID = 0;
            this._watchReplayReplayID = 0;
            this._watchReplayGotList = false;
            ++this._watchReplaySearchAttemps;
            this.refreshWatchReplay();
         }
      }
      
      public function resetWatchReplayReplayID() : void
      {
         this._watchReplayReplayID = 0;
      }
      
      public function getRankingListSuccess() : void
      {
         this.refreshWatchReplay();
      }
      
      private function removeMechs() : void
      {
         if(this.watchReplayMech1 != null)
         {
            this.watchReplayMech1.removeMe();
         }
         if(this.watchReplayMech2 != null)
         {
            this.watchReplayMech2.removeMe();
         }
      }
      
      public function createReplayMechs(param1:Object, param2:Number = -1) : void
      {
         if(this._type == "replays" && this.mcSMTV.mcScreens.currentLabel != "vsBattles")
         {
            this.mcSMTV.mcScreens.gotoAndStop("vsBattles");
            this.txtSMTVLink.visible = false;
         }
         var _loc3_:Number = this._watchReplayReplayID;
         if(param2 > -1)
         {
            _loc3_ = param2;
         }
         this.removeMechs();
         var _loc4_:BMReplayData = param1[_loc3_];
         var _loc5_:Number = 0.4;
         this.watchReplayMech1 = new BMMechView();
         this.watchReplayMech1.initialize(dataM.REPLAY_PLAYER1_ID,"battle","itemID",_loc5_,false);
         this.watchReplayMech1.buildMech(_loc4_.player1MechStructures[1],"watchReplay");
         this.watchReplayMech1.x = this.mcSMTV.mcMech1Pos.x;
         this.watchReplayMech1.y = -(this.watchReplayMech1.mechSizer.height + this.watchReplayMech1.mechSizer.y) + this.mcSMTV.mcMech1Pos.y;
         this.mcSMTV.mcMechsHolder.addChild(this.watchReplayMech1);
         this.watchReplayMech2 = new BMMechView();
         this.watchReplayMech2.initialize(dataM.REPLAY_PLAYER2_ID,"battle","itemID",_loc5_,false);
         this.watchReplayMech2.buildMech(_loc4_.player2MechStructures[1],"watchReplay");
         this.watchReplayMech2.x = this.mcSMTV.mcMech2Pos.x;
         this.watchReplayMech2.y = -(this.watchReplayMech2.mechSizer.height + this.watchReplayMech2.mechSizer.y) + this.mcSMTV.mcMech2Pos.y;
         this.mcSMTV.mcMechsHolder.addChild(this.watchReplayMech2);
         this.watchReplayMech2.scaleX *= -1;
         this.mcSMTV.mcBackgrounds.gotoAndStop(dataM.battle_backgroundID);
      }
      
      public function moveToNextTVScreen() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:uint = 0;
         this._TVScreensFrameCounter = 0;
         this.txtSMTVLink.visible = false;
         if(false)
         {
            switch(this._TVScreensCurrentFrame)
            {
               case "youtube":
                  if(this._watchReplayReplayID > 0)
                  {
                     this._TVScreensCurrentFrame = "vsBattles";
                  }
                  else
                  {
                     this._TVScreensCurrentFrame = "youtube";
                  }
                  break;
               case "vsBattles":
                  this._TVScreensCurrentFrame = "youtube";
            }
         }
         else
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            switch(this._TVScreensCurrentFrame)
            {
               case "BDEA":
                  this._TVScreensCurrentFrame = "apple";
                  break;
               case "apple":
                  this._TVScreensCurrentFrame = "google";
                  break;
               case "google":
                  this._TVScreensCurrentFrame = "youtube";
                  break;
               case "youtube":
                  if(this._watchReplayReplayID > 0)
                  {
                     this._TVScreensCurrentFrame = "vsBattles";
                  }
                  else
                  {
                     this._TVScreensCurrentFrame = "apple";
                  }
                  break;
               case "vsBattles":
                  ++this._adsCounter;
                  if(this._adsCounter > 3)
                  {
                     this._adsCounter = 1;
                  }
                  switch(this._adsCounter)
                  {
                     case 1:
                        this._TVScreensCurrentFrame = "BDEA";
                        break;
                     case 2:
                        this._TVScreensCurrentFrame = "apple";
                        break;
                     default:
                        _loc2_ = Math.ceil(Math.random() * 2);
                        if(this._adsCounter == 2)
                        {
                           this._TVScreensCurrentFrame = "battleDawn" + _loc2_;
                           this.txtSMTVLink.visible = true;
                        }
                        else
                        {
                           _loc2_ += 2;
                           if(_loc2_ == 3)
                           {
                              this.txtSMTVLink.visible = true;
                           }
                           this._TVScreensCurrentFrame = "battleDawn" + _loc2_;
                        }
                  }
                  break;
               case "battleDawn1":
               case "battleDawn2":
               case "battleDawn3":
               case "battleDawn4":
                  if(this._watchReplayReplayID > 0)
                  {
                     this._TVScreensCurrentFrame = "vsBattles";
                  }
                  else
                  {
                     this._TVScreensCurrentFrame = "BDEA";
                  }
            }
         }
         this.mcSMTV.mcScreens.gotoAndStop(this._TVScreensCurrentFrame);
      }
      
      private function SMTVClicked(param1:MouseEvent) : void
      {
         this.SMTVClickedSub();
      }
      
      public function SMTVClickedSub() : void
      {
         var _loc1_:String = null;
         var _loc2_:BMMClientFlashVars = null;
         switch(this._type)
         {
            case "multiplayer":
            case "multiplayerLadder":
               switch(this._TVScreensCurrentFrame)
               {
                  case "BDEA":
                     dataM.openURL("https://307145.measurementapi.com/serve?action=click&publisher_id=307145&site_id=113723&my_campaign=SuperMechs&my_publisher=Web_Share","_blank");
                     break;
                  case "apple":
                     _loc1_ = "flash_0";
                     _loc2_ = new BMMClientFlashVars(screensM.clientPointer.stage);
                     if(_loc2_ != null)
                     {
                        if(_loc2_.mcamp_id != null)
                        {
                           if(_loc2_.mcamp_id != "")
                           {
                              _loc1_ = "flash_" + _loc2_.mcamp_id;
                           }
                        }
                     }
                     dataM.openURL("https://itunes.apple.com/app/apple-store/id864103912?pt=1225303&ct=" + _loc1_ + "&mt=8","_blank");
                     break;
                  case "google":
                     dataM.openURL("https://play.google.com/store/apps/details?id=air.com.supermechs.superapp&hl=en","_blank");
                     break;
                  case "youtube":
                     screensM.addScreen("screenYouTubeVidsGuide");
                     screensM.screenYouTubeVidsGuide.refreshScreen();
                     break;
                  case "battleDawn1":
                     this.battleDawnClickedSub(1);
                     break;
                  case "battleDawn2":
                     this.battleDawnClickedSub(2);
                     break;
                  case "battleDawn3":
                     this.battleDawnClickedSub(3);
                     break;
                  case "battleDawn4":
                     this.battleDawnClickedSub(4);
                     break;
                  case "vsBattles":
                     if(screensM.screenBlack.isActive() == false)
                     {
                        if(screensM.screenMultiPlayerLadder.searchingForBattleInProgress())
                        {
                           screensM.screenConfirmation.displayQuestionOrNotification("mustExitSearchForBattle",-1,-1);
                        }
                        else
                        {
                           screensM.screenBlack.activateBlackScreen(this.activateReplay,true,true,null,0);
                        }
                     }
               }
               break;
            case "replays":
         }
         this.mcSMTV.mcMouseEffect.alpha = 0;
      }
      
      private function activateReplay() : void
      {
         if(this._watchReplayReplayID > 0)
         {
            dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_REPLAY,BMDataManager.GAME_SUB_TYPE_REPLAY_SMTV);
            dataM.unpackReplay(this._watchReplayReplayID);
         }
      }
      
      private function SMTVMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:BMReplayData = null;
         switch(this._type)
         {
            case "multiplayer":
            case "multiplayerLadder":
               _loc3_ = false;
               switch(this._TVScreensCurrentFrame)
               {
                  case "BDEA":
                     _loc2_ = getScreenText("BDEA");
                     break;
                  case "apple":
                     _loc2_ = getScreenText("apple");
                     break;
                  case "google":
                     _loc2_ = getScreenText("google");
                     break;
                  case "youtube":
                     _loc2_ = getScreenText("youtube");
                     break;
                  case "battleDawn1":
                  case "battleDawn2":
                  case "battleDawn3":
                  case "battleDawn4":
                     _loc2_ = getScreenText("battleDawn");
                     break;
                  case "vsBattles":
                     _loc2_ = getSpecificText("tooltip_topPlayersReplays");
                     if(this._watchReplayPlayerID > 0 && this._watchReplayReplayID > 0)
                     {
                        _loc4_ = dataM.replaysDB_inspect[this._watchReplayReplayID];
                        _loc2_ = _loc2_ + "<BR>" + _loc4_.playerName1 + " VS " + _loc4_.playerName2;
                     }
               }
               tooltip.showToolTip("regularText",_loc2_,0,0);
               this.mcSMTV.mcMouseEffect.alpha = 0.3;
               break;
            case "replays":
         }
      }
      
      private function SMTVMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
         this.mcSMTV.mcMouseEffect.alpha = 0;
      }
      
      private function battleDawnClickedSub(param1:Number) : void
      {
         soundM.createSound("buttonClick",1);
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc2_.facebook)
         {
            if(param1 == 4)
            {
               dataM.openURL("https://apps.facebook.com/battledawn_galaxies/?mcamp_id=208&ref=BDG_Facebook","_blank");
            }
            else
            {
               dataM.openURL("https://apps.facebook.com/battledawnwar/?mcamp_id=208","_blank");
            }
         }
         else if(param1 == 4)
         {
            dataM.openURL("http://www.battlegalaxy.com/?mcamp_id=208&ref=BattleDawnGalaxies","_blank");
         }
         else
         {
            dataM.openURL("http://www.battledawn.com/?mcamp_id=208","_blank");
         }
      }
      
      public function hideSMTV() : void
      {
         visible = false;
      }
      
      public function showSMTV() : void
      {
         visible = true;
      }
      
      public function removeMe() : void
      {
         this.removeMechs();
         screensM.removeScreen("screenSMTV");
      }
   }
}

