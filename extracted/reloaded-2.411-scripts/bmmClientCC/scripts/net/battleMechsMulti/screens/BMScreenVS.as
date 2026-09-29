package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1599")]
   public class BMScreenVS extends BMBaseScreen
   {
      
      public var mcBackground:MovieClip;
      
      public var mcBackground_fast:MovieClip;
      
      public var mcMechsHolder:MovieClip;
      
      public var mcIconsHolder:MovieClip;
      
      public var mcPlayer1MechViewPosition:Sprite;
      
      public var mcPlayer2MechViewPosition:Sprite;
      
      public var mcTitle:Sprite;
      
      public var mcVS:MovieClip;
      
      public var mcVS_fast:MovieClip;
      
      public var mcPlayer1Info:MovieClip;
      
      public var mcPlayer2Info:MovieClip;
      
      private var player1MechView:BMMechView;
      
      private var player2MechView:BMMechView;
      
      private var player1Rank:MovieClip;
      
      private var player2Rank:MovieClip;
      
      private var _actions:Array;
      
      private var _actionsFrameCounter:Number;
      
      private var _player1Mech1_open:Boolean;
      
      private var _player1Mech1_close:Boolean;
      
      private var _player2Mech1_open:Boolean;
      
      private var _player2Mech1_close:Boolean;
      
      private var _player1InfoOriginYPos:Number;
      
      private var _player2InfoOriginYPos:Number;
      
      private var _player1LevelOriginXPos:Number;
      
      private var _player2LevelOriginXPos:Number;
      
      private var _titleOriginYPos:Number;
      
      private var _titleChineseOriginYPos:Number;
      
      private var _titleDelayCountdown:Number;
      
      private var _lastSlowCPUMode:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      public var blockingBattle:Boolean = false;
      
      private const MECH_ICON_SIZE:Number = 70;
      
      private const MECH_X_JUMP:Number = 450;
      
      public function BMScreenVS()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         var _loc4_:Number = NaN;
         var _loc6_:Array = null;
         if(this._firstRefresh)
         {
            this._player1InfoOriginYPos = this.mcPlayer1Info.y;
            this._player2InfoOriginYPos = this.mcPlayer2Info.y;
            this._player1LevelOriginXPos = this.mcPlayer2Info.txtLevel.x;
            this._player2LevelOriginXPos = this.mcPlayer2Info.txtLevel.x;
            if(dataM.runAsMobile)
            {
               this.mcTitle.parent.removeChild(this.mcTitle);
               this.mcTitle = null;
            }
            else
            {
               this._titleOriginYPos = this.mcTitle.y;
            }
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this.blockingBattle = true;
         this.displayMech(dataM.player1PlayerID,1);
         this.displayMech(dataM.player2PlayerID,1);
         this.mcVS.gotoAndStop("animOff");
         this.mcVS_fast.gotoAndStop("animOff");
         this.mcBackground.gotoAndStop("animOff");
         this.mcBackground_fast.gotoAndStop("animOff");
         this._lastSlowCPUMode = dataM.slowCPUMode;
         if(this._lastSlowCPUMode)
         {
            this.mcVS.visible = false;
            this.mcVS_fast.visible = true;
            this.mcBackground.visible = false;
            this.mcBackground_fast.visible = true;
         }
         else
         {
            this.mcVS.visible = true;
            this.mcVS_fast.visible = false;
            this.mcBackground.visible = true;
            this.mcBackground_fast.visible = false;
         }
         this._actions = new Array();
         var _loc1_:uint = 0;
         while(_loc1_ < 150)
         {
            this._actions[_loc1_] = "";
            _loc1_++;
         }
         this._actions[1] = "background_open";
         this._actions[2] = "addAndScaleDownMechs";
         this._actions[3] = "player1Mech1_open";
         this._actions[8] = "player2Mech1_open";
         this._actions[9] = "VS_open";
         if(this._lastSlowCPUMode)
         {
            this._actions[36] = "createBattleScreen";
            this._actions[38] = "VS_close";
            this._actions[39] = "player2Mech1_close";
            this._actions[45] = "player1Mech1_close";
            this._actions[48] = "background_close";
         }
         else
         {
            this._actions[66] = "createBattleScreen";
            this._actions[68] = "VS_close";
            this._actions[69] = "player2Mech1_close";
            this._actions[75] = "player1Mech1_close";
            this._actions[80] = "background_close";
         }
         this._actionsFrameCounter = 0;
         this._player1Mech1_open = false;
         this._player1Mech1_close = false;
         this._player2Mech1_open = false;
         this._player2Mech1_close = false;
         var _loc2_:Number = Number(this.mcPlayer1Info.mcSizer_rank.width);
         this.mcPlayer1Info.y = this._player1InfoOriginYPos;
         this.mcPlayer1Info.txtLevel.x = this._player1LevelOriginXPos;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.mcPlayer1Info.txtName.text = _loc3_.playerName;
         if(dataM.playingVSComputer)
         {
            this.mcPlayer1Info.txtRank.text = "";
            this.mcPlayer1Info.txtLevel.text = "";
            if(this.player1Rank != null)
            {
               if(this.player1Rank.parent != null)
               {
                  this.player1Rank.parent.removeChild(this.player1Rank);
                  this.player1Rank = null;
               }
            }
         }
         else
         {
            this.mcPlayer1Info.txtLevel.text = getGeneralText("rankCaps") + " " + dataM.getLadderRankByProgress(_loc3_.ladderProgress);
            if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && _loc3_.overallRank > 0)
            {
               this.mcPlayer1Info.txtRank.text = getSpecificText("rankingList_position") + " " + dataM.getNumberWithComma(_loc3_.overallRank);
            }
            else
            {
               this.mcPlayer1Info.txtRank.text = "";
            }
            if(this.player1Rank != null)
            {
               this.player1Rank.parent.removeChild(this.player1Rank);
               this.player1Rank = null;
            }
            _loc4_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc3_.ladderProgress));
            this.player1Rank = externalAssetsM.getAsset("general","Grp_rank" + _loc4_,_loc2_,_loc2_,false,false);
            this.player1Rank.x = this.mcPlayer1Info.mcSizer_rank.x;
            this.player1Rank.y = this.mcPlayer1Info.mcSizer_rank.y;
            this.mcPlayer1Info.addChild(this.player1Rank);
         }
         this.mcPlayer2Info.y = this._player2InfoOriginYPos;
         this.mcPlayer2Info.txtLevel.x = this._player2LevelOriginXPos;
         _loc3_ = dataM["player" + dataM.player2PlayerID + "Profile"];
         var _loc5_:String = _loc3_.playerName;
         if(dataM.isPlayerIDAdmin(_loc3_.userID))
         {
            _loc5_ = "<FONT COLOR=\'#" + dataM.COLOR_ADMIN + "\'>" + _loc5_ + "</FONT>";
         }
         else if(dataM.isMyFriend(_loc3_.userID))
         {
            _loc5_ = "<FONT COLOR=\'#" + dataM.COLOR_FRIEND + "\'>" + _loc5_ + "</FONT>";
         }
         this.mcPlayer2Info.txtName.htmlText = TextUtils.getTextFont(27) + _loc5_;
         if(dataM.playingVSComputer)
         {
            this.mcPlayer2Info.txtRank.text = "";
            this.mcPlayer2Info.txtLevel.text = "";
            if(this.player2Rank != null)
            {
               if(this.player2Rank.parent != null)
               {
                  this.player2Rank.parent.removeChild(this.player2Rank);
                  this.player2Rank = null;
               }
            }
         }
         else
         {
            this.mcPlayer2Info.txtLevel.text = getGeneralText("rankCaps") + " " + dataM.getLadderRankByProgress(_loc3_.ladderProgress);
            if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && _loc3_.overallRank > 0)
            {
               this.mcPlayer2Info.txtRank.text = getSpecificText("rankingList_position") + " " + dataM.getNumberWithComma(_loc3_.overallRank);
            }
            else
            {
               this.mcPlayer2Info.txtRank.text = "";
            }
            if(this.player2Rank != null)
            {
               this.player2Rank.parent.removeChild(this.player2Rank);
               this.player2Rank = null;
            }
            _loc4_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc3_.ladderProgress));
            this.player2Rank = externalAssetsM.getAsset("general","Grp_rank" + _loc4_,_loc2_,_loc2_,false,false);
            this.player2Rank.x = this.mcPlayer2Info.mcSizer_rank.x;
            this.player2Rank.y = this.mcPlayer2Info.mcSizer_rank.y;
            this.mcPlayer2Info.addChild(this.player2Rank);
         }
         if(dataM.runAsMobile)
         {
            _loc6_ = [this.mcPlayer1Info.txtName,this.mcPlayer1Info.txtLevel,this.mcPlayer1Info.txtRank];
            screensM.createMultipleTextsBitmap("vs_player1Info",_loc6_,"",this.mcPlayer1Info);
            _loc6_ = [this.mcPlayer2Info.txtName,this.mcPlayer2Info.txtLevel,this.mcPlayer2Info.txtRank];
            screensM.createMultipleTextsBitmap("vs_player2Info",_loc6_,"",this.mcPlayer2Info);
         }
         if(dataM.runAsMobile == false)
         {
            this.mcTitle.y = this._titleOriginYPos;
            this._titleDelayCountdown = 3;
         }
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.mcPlayer1Info.txtLevel,18);
            TextUtils.updateTextFormat(this.mcPlayer1Info.txtName,27);
            TextUtils.updateTextFormat(this.mcPlayer1Info.txtRank,18);
            TextUtils.updateTextFormat(this.mcPlayer2Info.txtLevel,18);
            TextUtils.updateTextFormat(this.mcPlayer2Info.txtName,27);
            TextUtils.updateTextFormat(this.mcPlayer2Info.txtRank,18);
         }
      }
      
      private function displayMech(param1:Number, param2:Number) : void
      {
         var _loc3_:BMMechView = this["player" + dataM.getInterfacePlayerID(param1) + "MechView"];
         if(_loc3_ != null)
         {
            if(_loc3_.parent != null)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            _loc3_.removeMe();
            this["player" + dataM.getInterfacePlayerID(param1) + "MechView"] = null;
         }
         var _loc4_:Sprite = this["mcPlayer" + dataM.getInterfacePlayerID(param1) + "MechViewPosition"];
         var _loc5_:Number = 0;
         this["player" + dataM.getInterfacePlayerID(param1) + "MechView"] = new BMMechView();
         _loc3_ = this["player" + dataM.getInterfacePlayerID(param1) + "MechView"];
         _loc3_.initialize(param1,"hanger","playerItemID",1,false);
         var _loc6_:BMPlayerData = dataM.playersData[param1];
         var _loc7_:Number = 1;
         _loc3_.buildMech(_loc6_.mechStructures[_loc7_],"screenVS displayMech");
      }
      
      private function addAndScaleDownMechs() : void
      {
         var _loc1_:Number = 0.8;
         this.player1MechView.scaleX = _loc1_;
         this.player1MechView.scaleY = _loc1_;
         if(dataM.runAsMobile)
         {
            this.player1MechView.x = this.mcPlayer1MechViewPosition.x;
         }
         else
         {
            this.player1MechView.x = this.mcPlayer1MechViewPosition.x - this.MECH_X_JUMP;
         }
         this.player1MechView.y = this.mcPlayer1MechViewPosition.y - (this.player1MechView.mechSizer.height + this.player1MechView.mechSizer.y) * _loc1_;
         this.mcMechsHolder.addChild(this.player1MechView);
         this.player2MechView.scaleX = -_loc1_;
         this.player2MechView.scaleY = _loc1_;
         if(dataM.runAsMobile)
         {
            this.player2MechView.x = this.mcPlayer2MechViewPosition.x;
         }
         else
         {
            this.player2MechView.x = this.mcPlayer2MechViewPosition.x + this.MECH_X_JUMP;
         }
         this.player2MechView.y = this.mcPlayer2MechViewPosition.y - (this.player2MechView.mechSizer.height + this.player2MechView.mechSizer.y) * _loc1_;
         this.mcMechsHolder.addChild(this.player2MechView);
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(parent != null)
         {
            ++this._actionsFrameCounter;
            switch(this._actions[this._actionsFrameCounter])
            {
               case "background_open":
                  if(dataM.runAsMobile == false)
                  {
                     if(this._lastSlowCPUMode)
                     {
                        this.mcBackground_fast.gotoAndPlay("animOn_open");
                     }
                     else
                     {
                        this.mcBackground.gotoAndPlay("animOn_open");
                     }
                  }
                  break;
               case "addAndScaleDownMechs":
                  this.addAndScaleDownMechs();
                  soundM.createSound("matchFound",1);
                  break;
               case "player1Mech1_open":
                  this._player1Mech1_open = true;
                  break;
               case "player2Mech1_open":
                  this._player2Mech1_open = true;
                  break;
               case "VS_open":
                  if(this._lastSlowCPUMode)
                  {
                     this.mcVS_fast.gotoAndPlay("animOn_open");
                  }
                  else
                  {
                     this.mcVS.gotoAndPlay("animOn_open");
                  }
                  break;
               case "VS_close":
                  if(dataM.runAsMobile == false)
                  {
                     if(this._lastSlowCPUMode)
                     {
                        this.mcVS_fast.gotoAndPlay("animOn_close");
                     }
                     else
                     {
                        this.mcVS.gotoAndPlay("animOn_close");
                     }
                  }
                  break;
               case "player2Mech1_close":
                  this._player2Mech1_close = true;
                  break;
               case "player1Mech1_close":
                  this._player1Mech1_close = true;
                  break;
               case "createBattleScreen":
                  screensM.addScreen("screenBattle");
                  screensM.addScreen("screenBattleInterfaceTop");
                  screensM.addScreen("screenBattleInterfaceBottom");
                  screensM.screenBattleInterfaceTop.refreshScreen();
                  screensM.screenBattle.activateNextBattlePhase("initiate_startNewBattle");
                  if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
                  {
                     screensM.screenBattle.activateNextBattlePhase("sync_activateNextBattlePhase",{
                        "syncData":dataM.battle_syncData,
                        "battleHasJustStarted":true
                     });
                  }
                  break;
               case "background_close":
                  if(dataM.runAsMobile == false)
                  {
                     if(this._lastSlowCPUMode)
                     {
                        this.mcBackground_fast.gotoAndPlay("animOn_close");
                     }
                     else
                     {
                        this.mcBackground.gotoAndPlay("animOn_close");
                     }
                  }
                  else
                  {
                     screensM.screenBlack.activateBlackScreen(this.backgroundCloseAnimationDone,true,true,null,0);
                  }
                  screensM.screenBattle.activateNextBattlePhase("initiate_screenVSIsClosed");
                  this.blockingBattle = false;
            }
            _loc3_ = 0.2;
            _loc4_ = 15;
            if(this._lastSlowCPUMode)
            {
               _loc3_ = 0.4;
               _loc4_ = 30;
            }
            if(dataM.runAsMobile == false)
            {
               if(this._player1Mech1_open)
               {
                  _loc1_ = this.mcPlayer1MechViewPosition.x - this.player1MechView.x;
                  if(_loc1_ > 1)
                  {
                     this.player1MechView.x += _loc1_ * _loc3_;
                  }
                  else
                  {
                     this.player1MechView.x = this.mcPlayer1MechViewPosition.x;
                     this._player1Mech1_open = false;
                  }
               }
               if(this._player2Mech1_open)
               {
                  _loc1_ = this.player2MechView.x - this.mcPlayer2MechViewPosition.x;
                  if(_loc1_ > 1)
                  {
                     this.player2MechView.x -= _loc1_ * _loc3_;
                  }
                  else
                  {
                     this.player2MechView.x = this.mcPlayer2MechViewPosition.x;
                     this._player2Mech1_open = false;
                  }
               }
               if(this._player1Mech1_close)
               {
                  _loc2_ = this.mcPlayer1MechViewPosition.x - this.MECH_X_JUMP;
                  _loc1_ = this.player1MechView.x - _loc2_;
                  if(_loc1_ > 1)
                  {
                     this.player1MechView.x -= this.MECH_X_JUMP - _loc1_ + 1;
                  }
                  else
                  {
                     this.player1MechView.x = _loc2_;
                     this._player1Mech1_close = false;
                  }
                  this.mcPlayer1Info.y -= _loc4_;
                  if(dataM.runAsMobile == false)
                  {
                     if(this._titleDelayCountdown > 0)
                     {
                        --this._titleDelayCountdown;
                     }
                     else if(dataM.languageID != 2)
                     {
                        this.mcTitle.y -= _loc4_;
                     }
                  }
               }
               if(this._player2Mech1_close)
               {
                  _loc2_ = this.mcPlayer2MechViewPosition.x + this.MECH_X_JUMP;
                  _loc1_ = _loc2_ - this.player2MechView.x;
                  if(_loc1_ > 1)
                  {
                     this.player2MechView.x += this.MECH_X_JUMP - _loc1_ + 1;
                  }
                  else
                  {
                     this.player2MechView.x = _loc2_;
                     this._player2Mech1_close = false;
                  }
                  this.mcPlayer2Info.y -= _loc4_;
                  if(dataM.runAsMobile == false)
                  {
                     if(this._titleDelayCountdown > 0)
                     {
                        --this._titleDelayCountdown;
                     }
                     else if(dataM.languageID != 2)
                     {
                        this.mcTitle.y -= _loc4_;
                     }
                  }
               }
            }
         }
      }
      
      public function activateVSTextAnimExplosion(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = dataM.STAGE_HEIGHT / 2;
         switch(param1)
         {
            case 1:
               _loc2_ = dataM.STAGE_WIDTH / 2 - 20;
               break;
            case 2:
               _loc2_ = dataM.STAGE_WIDTH / 2 + 20;
         }
         effectsM.createGeneralEffect(this,"glowOrange",false,120,120,_loc2_,_loc3_,0,null,[]);
      }
      
      public function backgroundCloseAnimationDone() : void
      {
         screensM.removeScreen("screenVS");
         screensM.stagePointer.focus = screensM.screenBattle;
         this.player1MechView.removeMe();
         this.player2MechView.removeMe();
         this.player1MechView = null;
         this.player2MechView = null;
      }
   }
}

