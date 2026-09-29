package net.battleMechsMulti.screens.vs
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import com.greensock.easing.Ease;
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.data.BMLevelUpData;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.BMScreenBattle;
   import net.battleMechsMulti.screens.missionBaseMap.BMMissionMechStats;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3564")]
   public class BMScreenVS extends BMBaseScreen
   {
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcPlayer1MechsHolder:Sprite;
      
      public var mcPlayer2MechsHolder:Sprite;
      
      public var mcPlayer1MechMainPosition:MovieClip;
      
      public var mcPlayer2MechMainPosition:MovieClip;
      
      public var mcEffectsHolder:MovieClip;
      
      public var mcSearchingTitle:MovieClip;
      
      public var mcSizer_btnCancel:Sprite;
      
      public var txtTip:TextField;
      
      public var mcVSCenterInterface:BMVSCenterInterface;
      
      public var mcBackground_top:MovieClip;
      
      public var mcBackground_bottom:Sprite;
      
      public var mcBackground_left:Sprite;
      
      public var mcBackground_right:Sprite;
      
      public var player1PickMech1Button:BMVSPickMechInterface;
      
      public var player1PickMech2Button:BMVSPickMechInterface;
      
      public var player1PickMech3Button:BMVSPickMechInterface;
      
      public var player2PickMech1Button:BMVSPickMechInterface;
      
      public var player2PickMech2Button:BMVSPickMechInterface;
      
      public var player2PickMech3Button:BMVSPickMechInterface;
      
      public var btnReady:BMBasicButton;
      
      public var btnCancel:BMButton_pictureE;
      
      private var _mechViews:Array;
      
      private var _mechViewFake:BMMechView;
      
      private var _onlineBattle:Boolean;
      
      private var _tipOriginYPos:Number;
      
      private var _canCloseScreen:Boolean;
      
      private var _waitingToCloseScreen:Boolean;
      
      private var _opponentFound:Boolean;
      
      private var _searchAborted:Boolean;
      
      private var _pickMechs:Boolean;
      
      private var _arena3v3Preview:Boolean;
      
      private var _lightnings:Array = new Array();
      
      private var _basicEase:Ease;
      
      private var _searchForBattleFunction:Function;
      
      private var _startPVEBattleFunction:Function;
      
      private var _startReplayBattleFunction:Function;
      
      private var _mechsPerPlayer:uint;
      
      private var _backgroundTopOriginYPos:Number;
      
      private var _backgroundBottomOriginYPos:Number;
      
      private var _backgroundLeftOriginXPos:Number;
      
      private var _backgroundRightOriginXPos:Number;
      
      private var _btnCancelOriginYPos:Number;
      
      private var _searchingOriginalYPos:Number;
      
      private var _cancelCallback:Function;
      
      private var _startBattleDelayActive:Boolean = false;
      
      private var _pickMechPositions:Array;
      
      private var _opponentMechStructures:Array;
      
      private var _selectedMechSlots:Array;
      
      private var _maxMechs:uint = 2;
      
      private const MECH_X_DISTANCE:uint = 650;
      
      private const SEARCHING_DOT_ALPHA_TIME:Number = 0.25;
      
      private const SEARCHING_DOT_VISIBLE_WAIT_TIME:Number = 1.5;
      
      private const SEARCHING_DOT_INVISIBLE_WAIT_TIME:Number = 0.3;
      
      private const EXTRA_DELAY_FOR_3V3:Number = 1;
      
      private const PICK_MECH_SCALE:Number = 0.3;
      
      private const PICK_MECH_BUTTON_X_JUMP:uint = 500;
      
      private var _pickMechsSecondsLeft:uint;
      
      private var _pickMechsTimer:Timer;
      
      public function BMScreenVS()
      {
         super();
      }
      
      private static function finalizeAnimationsAfterBattleCeremonyFinishedWithoutBattle() : *
      {
         var _loc1_:BMScreensManager = BMScreensManager.getInstance();
         _loc1_.screenMultiPlayerLadder.removeMe();
         _loc1_.removeScreen(BMScreensManager.SCR_VS);
         TweenMax.delayedCall(2,_loc1_.screenTransitionsManager.multiplayerLadderClicked,[true],true);
      }
      
      public function initialize(param1:Boolean = true) : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("vs");
         screensM.createButtonFromSizer(BMScreensManager.SCR_VS,"btnCancel","pictureE");
         this.btnCancel.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.cancelClicked,dataM.runAsMobile);
         this._onlineBattle = param1;
         this._basicEase = new Ease(null,null,2,2);
         this._backgroundTopOriginYPos = this.mcBackground_top.y;
         this._backgroundBottomOriginYPos = this.mcBackground_bottom.y;
         this._backgroundLeftOriginXPos = this.mcBackground_left.x;
         this._backgroundRightOriginXPos = this.mcBackground_right.x;
         this._btnCancelOriginYPos = this.btnCancel.y;
         this._searchingOriginalYPos = this.mcSearchingTitle.y;
         this.initTip();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         this._mechViews = new Array();
         this._mechViews[1] = new Array();
         this._mechViews[2] = new Array();
         this.createMyMech();
         if(this._onlineBattle)
         {
            this.createFakeMech(true);
         }
         else
         {
            this.btnCancel.visible = false;
            this.mcBackground_top.mcBackBackground.visible = false;
         }
         this.btnReady.text = getScreenText("ready");
         visible = false;
         this.initPickMechsData();
      }
      
      public function activateScreen(param1:Function = null) : void
      {
         this._opponentMechStructures = null;
         this._cancelCallback = param1;
         this._canCloseScreen = false;
         this._waitingToCloseScreen = false;
         this._opponentFound = false;
         this._searchAborted = false;
         this._pickMechs = false;
         this._arena3v3Preview = false;
         this.btnReady.visible = false;
         visible = true;
         this.initOpenScreenAnimations();
      }
      
      public function addSearchForBattleFunction(param1:Function, param2:uint) : void
      {
         this._searchForBattleFunction = param1;
         this._mechsPerPlayer = param2;
      }
      
      public function addStartPVEBattleFunction(param1:Function) : void
      {
         this._startPVEBattleFunction = param1;
      }
      
      public function addStartReplayBattleFunction(param1:Function) : void
      {
         this._startReplayBattleFunction = param1;
      }
      
      public function onEnterFrameTrigger() : void
      {
      }
      
      private function initOpenScreenAnimations() : void
      {
         this.removeSearching();
         this.hideVS();
         TweenMax.fromTo(this.mcBackground_bottom,0.15,{"y":this._backgroundBottomOriginYPos + 100},{
            "y":this._backgroundBottomOriginYPos,
            "ease":this._basicEase
         });
         TweenMax.fromTo(this.mcBackground_top,0.25,{"y":this._backgroundTopOriginYPos - 100},{
            "y":this._backgroundTopOriginYPos,
            "ease":this._basicEase
         });
         TweenMax.fromTo(this.mcBackground_left,0.45,{"x":this._backgroundLeftOriginXPos - this.MECH_X_DISTANCE},{
            "delay":0,
            "x":this._backgroundLeftOriginXPos,
            "ease":this._basicEase
         });
         TweenMax.fromTo(this.mcBackground_right,0.45,{"x":this._backgroundRightOriginXPos + this.MECH_X_DISTANCE},{
            "delay":0.1,
            "x":this._backgroundRightOriginXPos,
            "ease":this._basicEase,
            "onComplete":this.openScreenAnimationsDone
         });
         TweenMax.fromTo(this.btnCancel,0.25,{"y":this._btnCancelOriginYPos - 100},{
            "y":this._btnCancelOriginYPos,
            "ease":this._basicEase
         });
         this.btnCancel.disableMe();
         var _loc1_:uint = 1;
         var _loc2_:uint = 1;
         var _loc3_:BMMechView = this.getMechView(_loc1_,_loc2_);
         TweenMax.fromTo(_loc3_,0.45,{"x":this.mcPlayer1MechMainPosition.x - this.MECH_X_DISTANCE},{
            "delay":0,
            "x":this.mcPlayer1MechMainPosition.x,
            "ease":this._basicEase
         });
         if(this._onlineBattle)
         {
            TweenMax.fromTo(this._mechViewFake,0.45,{"x":this.mcPlayer2MechMainPosition.x + this.MECH_X_DISTANCE},{
               "delay":0.1,
               "x":this.mcPlayer2MechMainPosition.x,
               "ease":this._basicEase,
               "onComplete":this.startFakeMechOutAnim
            });
         }
      }
      
      private function openScreenAnimationsDone() : void
      {
         TweenMax.fromTo(this.mcVSCenterInterface,0.3,{
            "visible":true,
            "scaleX":0.05,
            "scaleY":0.05
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         });
         if(this._onlineBattle)
         {
            if(this._pickMechs == false && this._arena3v3Preview == false)
            {
               this.activateSearchingAnimation();
            }
            this.refreshTip();
         }
         if(this._waitingToCloseScreen)
         {
            this.initCloseScreenAnimations();
         }
         else
         {
            this.btnCancel.enableMe();
            this._canCloseScreen = true;
         }
         if(this._searchForBattleFunction != null)
         {
            if(dataM.kinM.bettingActive)
            {
               dataM.kinM.placeBet(this.onKinBetSuccess,this.onKinBetFailed);
               this.btnCancel.disableMe();
               return;
            }
            this.triggerSearchForBattleCall();
         }
      }
      
      private function onKinBetSuccess() : void
      {
         this.triggerSearchForBattleCall(true);
      }
      
      private function onKinBetFailed() : void
      {
         dataM.kinM.deactivateBetting(false);
         dataM.kinM.showNotEnoughKinToBetMessage(this.cancelSearchForBattleSuccess);
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER))
         {
            if(screensM.screenMultiPlayerLadder.mcKinBetPanel != null)
            {
               screensM.screenMultiPlayerLadder.mcKinBetPanel.refreshData();
            }
         }
      }
      
      public function triggerSearchForBattleCall(param1:Boolean = false) : void
      {
         var _loc2_:String = "";
         if(dataM.kinM.bettingActive)
         {
            _loc2_ = dataM.kinM.lastTransactionID;
         }
         this._searchForBattleFunction(this._mechsPerPlayer,_loc2_);
         if(param1)
         {
            this.btnCancel.enableMe();
         }
      }
      
      private function initCloseScreenAnimations(param1:Boolean = false) : void
      {
         var _loc10_:Function = null;
         this.btnCancel.disableMe();
         var _loc2_:Number = 0;
         if(this._mechsPerPlayer == 3 && dataM.gameType == BMDataManager.GAME_TYPE_PVE)
         {
            _loc2_ += this.EXTRA_DELAY_FOR_3V3;
         }
         var _loc3_:Number = 0.6 + _loc2_;
         var _loc4_:Number = 0.5 + _loc2_;
         var _loc5_:Number = 0.4 + _loc2_;
         var _loc6_:Number = 0.3 + _loc2_;
         var _loc7_:Number = 0.2 + _loc2_;
         var _loc8_:Number = 0.4 + _loc2_;
         var _loc9_:Number = 0.3 + _loc2_;
         if(param1)
         {
            _loc10_ = this.hideMe;
         }
         else
         {
            _loc10_ = this.removeMe;
         }
         TweenMax.to(this.mcBackground_bottom,0.45,{
            "delay":_loc3_,
            "y":this._backgroundBottomOriginYPos + 100
         });
         TweenMax.to(this.mcBackground_top,0.45,{
            "delay":_loc4_,
            "y":this._backgroundTopOriginYPos - 100
         });
         TweenMax.to(this.mcBackground_left,0.45,{
            "delay":_loc5_,
            "x":this._backgroundLeftOriginXPos - this.MECH_X_DISTANCE
         });
         TweenMax.to(this.mcBackground_right,0.45,{
            "delay":_loc6_,
            "x":this._backgroundRightOriginXPos + this.MECH_X_DISTANCE,
            "onComplete":_loc10_
         });
         TweenMax.to(this.mcVSCenterInterface,0.2,{
            "delay":_loc7_,
            "scaleX":0.05,
            "scaleY":0.05,
            "onComplete":this.hideVS
         });
         var _loc11_:BMMechView = this.getMechView(1,1);
         TweenMax.to(_loc11_,0.45,{
            "delay":_loc8_,
            "x":this.mcPlayer1MechMainPosition.x - this.MECH_X_DISTANCE
         });
         _loc11_ = this.getMechView(2,1);
         if(_loc11_ != null)
         {
            TweenMax.to(_loc11_,0.45,{
               "delay":_loc9_,
               "x":this.mcPlayer2MechMainPosition.x + this.MECH_X_DISTANCE
            });
         }
         if(this._onlineBattle)
         {
            TweenMax.to(this.btnCancel,0.45,{
               "delay":_loc4_,
               "y":this._btnCancelOriginYPos - 100
            });
            TweenMax.to(this.mcSearchingTitle,0.2,{"y":500});
         }
         if(this._mechViewFake != null)
         {
            this.startFakeMechOutAnim(true);
         }
         this.setTipText();
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE))
         {
            screensM.screenBattle.screenVSIsClosed();
         }
      }
      
      private function hideVS() : void
      {
         this.mcVSCenterInterface.visible = false;
      }
      
      public function battleStarted(param1:BMMechStructure, param2:Boolean = false, param3:Boolean = false) : void
      {
         if(this._pickMechs)
         {
            this.mechsPickedCloseScreen();
            return;
         }
         if(param3)
         {
            this._arena3v3Preview = true;
         }
         var _loc4_:uint = 0;
         if(param2)
         {
            _loc4_ = Math.ceil(Math.random() * 4);
            this._startBattleDelayActive = true;
         }
         TweenMax.to(this,0.3,{
            "delay":_loc4_,
            "onComplete":this.battleStartedSub,
            "onCompleteParams":[param1]
         });
      }
      
      private function battleStartedSub(param1:BMMechStructure) : void
      {
         this.createOpponentMech(param1);
         var _loc2_:BMMechView = this.getMechView(2,2);
         if(_loc2_ != null)
         {
            this.mcPlayer2MechsHolder.removeChild(_loc2_);
            this.mcPlayer2MechsHolder.addChild(_loc2_);
         }
         var _loc3_:BMMechView = this.getMechView(2,3);
         if(_loc3_ != null)
         {
            this.mcPlayer2MechsHolder.removeChild(_loc3_);
            this.mcPlayer2MechsHolder.addChild(_loc3_);
         }
         if(this._onlineBattle)
         {
            this.startFakeMechOutAnim(true);
         }
         this._opponentFound = true;
      }
      
      private function getMechView(param1:uint, param2:uint) : BMMechView
      {
         return this._mechViews[param1][param2];
      }
      
      private function createMyMech() : void
      {
         if(this.getMechView(1,1) != null)
         {
            return;
         }
         var _loc1_:uint = 1;
         if(BattleTypeResolver.isCampaign || BattleTypeResolver.isRaid)
         {
            _loc1_ = dataM.myProfile.missionCurrentMechID;
         }
         this._mechViews[1][1] = new BMMechView();
         this.initAndBuildMech(this._mechViews[1][1],dataM.player1PlayerID,dataM.myPlayerData.mechStructures[_loc1_],BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,1,this.createMyMechSub);
      }
      
      private function createMyMechSub() : void
      {
         var _loc1_:BMMechView = this.getMechView(1,1);
         this.mcPlayer1MechsHolder.addChild(_loc1_);
         this.repositionMechView(_loc1_,this.mcPlayer1MechMainPosition);
      }
      
      private function createOpponentMech(param1:BMMechStructure, param2:String = "playerItemID") : void
      {
         this._mechViews[2][1] = new BMMechView();
         this.initAndBuildMech(this._mechViews[2][1],dataM.player2PlayerID,param1,param2,1,this.createOpponentMechSub);
      }
      
      private function createOpponentMechSub() : void
      {
         var _loc2_:Function = null;
         var _loc1_:BMMechView = this.getMechView(2,1);
         _loc1_.scaleX *= -1;
         this.mcPlayer2MechsHolder.addChild(_loc1_);
         if(this._onlineBattle)
         {
            TweenMax.fromTo(_loc1_,0.45,{"x":this.mcPlayer2MechMainPosition.x + this.MECH_X_DISTANCE},{
               "delay":0.2,
               "x":this.mcPlayer2MechMainPosition.x
            });
         }
         else
         {
            TweenMax.fromTo(_loc1_,0.45,{"x":this.mcPlayer2MechMainPosition.x + this.MECH_X_DISTANCE},{
               "delay":0,
               "x":this.mcPlayer2MechMainPosition.x,
               "ease":this._basicEase
            });
         }
         this.repositionMechView(_loc1_,this.mcPlayer2MechMainPosition);
         if(this._onlineBattle)
         {
            TweenMax.to(this.mcSearchingTitle,0.2,{"y":500});
            TweenMax.to(this.btnCancel,0.2,{"y":this._btnCancelOriginYPos - 100});
         }
         if(this._pickMechs)
         {
            _loc2_ = this.startPickingMechsProcedure;
         }
         else if(this._arena3v3Preview)
         {
            _loc2_ = this.startArena3v3PreviewProcedure;
         }
         else
         {
            _loc2_ = this.opponentFoundCloseScreen;
         }
         TweenMax.to(this,1.5,{"onComplete":_loc2_});
      }
      
      private function opponentFoundCloseScreen() : void
      {
         if(this._startPVEBattleFunction != null)
         {
            this._startPVEBattleFunction();
         }
         else if(this._startReplayBattleFunction != null)
         {
            this._startReplayBattleFunction();
         }
         if(this._canCloseScreen)
         {
            this.initCloseScreenAnimations();
         }
         else
         {
            this._waitingToCloseScreen = true;
         }
      }
      
      private function mechsPickedCloseScreen() : void
      {
         if(this._arena3v3Preview == false)
         {
            this.removePickMechsTimer();
            this.disablePickMechInterface();
            this.markOpponentPickedMechs();
            this.hideUnpickedMechs();
         }
         TweenMax.to(this,0,{
            "delay":2.7,
            "onComplete":this.hidePickedMechs,
            "onCompleteParams":[]
         });
         TweenMax.to(this,0,{
            "delay":3.1,
            "onComplete":this.opponentFoundCloseScreen,
            "onCompleteParams":[]
         });
         if(this.btnReady.isEnabled())
         {
            this.hideReadyButton();
         }
      }
      
      private function disablePickMechInterface() : void
      {
         var _loc2_:BMVSPickMechInterface = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= dataM.battleMaxMechs)
         {
            _loc2_ = this["player1PickMech" + _loc1_ + "Button"];
            _loc2_.disableMe();
            _loc1_++;
         }
      }
      
      private function markOpponentPickedMechs(param1:Boolean = false) : void
      {
         var _loc3_:BMVSPickMechInterface = null;
         var _loc2_:uint = 1;
         while(_loc2_ <= dataM.battleMaxMechs)
         {
            if(!(param1 == false && dataM.battleData.player2.chosenMechIDs.indexOf(_loc2_) == -1))
            {
               _loc3_ = this["player2PickMech" + _loc2_ + "Button"];
               _loc3_.selected = true;
            }
            _loc2_++;
         }
      }
      
      private function hidePickedMechs() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Array = null;
         var _loc1_:uint = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= 2)
         {
            _loc3_ = 1;
            while(_loc3_ <= dataM.battleMaxMechs)
            {
               if(this._arena3v3Preview)
               {
                  _loc4_ = (_loc3_ - 1) * 0.2;
                  this.movePickMechOutOfScreen(_loc2_,_loc3_,_loc4_);
               }
               else
               {
                  _loc5_ = dataM.battleData["player" + _loc2_].chosenMechIDs;
                  if(_loc5_.indexOf(_loc3_) != -1)
                  {
                     _loc1_++;
                     _loc4_ = (_loc1_ - 1) * 0.2;
                     this.movePickMechOutOfScreen(_loc2_,_loc3_,_loc4_);
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function hideUnpickedMechs() : *
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         var _loc1_:uint = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= 2)
         {
            _loc3_ = 1;
            while(_loc3_ <= dataM.battleMaxMechs)
            {
               _loc4_ = dataM.battleData["player" + _loc2_].chosenMechIDs;
               if(_loc4_.indexOf(_loc3_) < 0)
               {
                  _loc1_++;
                  _loc5_ = _loc1_ * 0.2;
                  this.movePickMechOutOfScreen(_loc2_,_loc3_,_loc5_);
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function movePickMechOutOfScreen(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:BMVSPickMechInterface = this["player" + param1 + "PickMech" + param2 + "Button"];
         var _loc5_:Number = _loc4_.x - this.MECH_X_DISTANCE;
         var _loc6_:uint = 450;
         var _loc7_:Number = 0.25;
         if(param1 == 2)
         {
            _loc5_ = _loc4_.x + _loc6_;
         }
         TweenMax.to(_loc4_,_loc7_,{
            "delay":param3,
            "x":_loc5_,
            "visible":false
         });
      }
      
      private function moveMechToPickMechInterfaceCompleted(param1:uint, param2:uint) : void
      {
         var _loc3_:BMMechView = this._mechViews[param1][param2];
         var _loc4_:BMVSPickMechInterface = this["player" + param1 + "PickMech" + param2 + "Button"];
         _loc3_.parent.removeChild(_loc3_);
         _loc3_.x = 0;
         _loc3_.resetYPos();
         if(_loc3_.scaleX < 0)
         {
            _loc3_.scaleX *= -1;
         }
         _loc4_.mcMechHolder.addChild(_loc3_);
      }
      
      private function initAndBuildMech(param1:BMMechView, param2:uint, param3:BMMechStructure, param4:String = "playerItemID", param5:Number = 1, param6:Function = null, param7:Array = null) : void
      {
         var _loc8_:uint = 0;
         var _loc9_:BMItemData = null;
         var _loc10_:BMPlayerItemData = null;
         var _loc11_:Sprite = null;
         param1.initialize(param2,"hanger",param4,param5,false);
         param1.buildMech(param3,param6,param7);
         if(param3.perk > 0)
         {
            _loc8_ = 0;
            if(param4 == BMMechStructure.ITEM_TYPE_ITEM_ID)
            {
               _loc8_ = param3.perk;
            }
            else
            {
               _loc10_ = dataM.getPlayerItemData(param2,param3.perk);
               _loc8_ = _loc10_.itemID;
            }
            _loc9_ = dataM.itemsDB[_loc8_];
            if(_loc9_.isGiantSizePerk)
            {
               param1.scaleX *= 1.15;
               param1.scaleY *= 1.15;
               _loc11_ = this.mcPlayer1MechMainPosition;
               if(param2 == dataM.player2PlayerID)
               {
                  _loc11_ = this.mcPlayer2MechMainPosition;
               }
               this.repositionMechView(param1,_loc11_);
            }
         }
      }
      
      private function repositionMechView(param1:BMMechView, param2:Sprite) : void
      {
         param1.resetYPos();
         param1.y += param2.y;
      }
      
      private function mechsBreathingHandler() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMMechView = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= 2)
         {
            _loc2_ = 1;
            while(_loc2_ <= dataM.battleMaxMechs)
            {
               _loc3_ = this._mechViews[_loc1_][_loc2_];
               if(_loc3_ != null)
               {
                  _loc3_.onEnterFrameTrigger();
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function removeMech(param1:uint, param2:uint) : void
      {
         var _loc3_:BMMechView = this._mechViews[param1][param2];
         if(_loc3_ == null)
         {
            return;
         }
         TweenMax.killTweensOf(_loc3_);
         _loc3_.removeMe();
         _loc3_ = null;
         this._mechViews[param1][param2] = null;
      }
      
      private function createFakeMech(param1:Boolean = false) : void
      {
         var _loc2_:uint = dataM.myPlayerData.getMechPowerRating(1,true);
         var _loc3_:uint = _loc2_ - 1;
         var _loc4_:uint = _loc2_ + 1;
         var _loc5_:BMMechStructure = dataM.createSpecificMechStructure_ItemBased(_loc3_,_loc4_);
         this._mechViewFake = new BMMechView();
         this.initAndBuildMech(this._mechViewFake,0,_loc5_,BMMechStructure.ITEM_TYPE_ITEM_ID,1,this.handleFakeMechBuilt,[param1]);
      }
      
      private function handleFakeMechBuilt(param1:Array) : *
      {
         var _loc2_:Boolean = Boolean(param1[0]);
         if(_loc2_ == false)
         {
            TweenMax.fromTo(this._mechViewFake,0.45,{"x":this.mcPlayer2MechMainPosition.x + this.MECH_X_DISTANCE},{
               "delay":0.3,
               "x":this.mcPlayer2MechMainPosition.x,
               "onComplete":this.startFakeMechOutAnim
            });
         }
         this._mechViewFake.scaleX *= -1;
         var _loc3_:Color = new Color();
         _loc3_.setTint(0,0.7);
         this._mechViewFake.transform.colorTransform = _loc3_;
         this.mcPlayer2MechsHolder.addChild(this._mechViewFake);
         this.repositionMechView(this._mechViewFake,this.mcPlayer2MechMainPosition);
      }
      
      private function startFakeMechOutAnim(param1:Boolean = false) : void
      {
         TweenMax.killTweensOf(this._mechViewFake);
         var _loc2_:Number = 1.2;
         if(param1)
         {
            _loc2_ = 0;
         }
         TweenMax.to(this._mechViewFake,0.3,{
            "delay":_loc2_,
            "x":this.mcPlayer2MechMainPosition.x + this.MECH_X_DISTANCE,
            "ease":this._basicEase,
            "onComplete":this.fakeMechOutAnimComplete
         });
      }
      
      private function fakeMechOutAnimComplete() : void
      {
         if(this._opponentFound == false && this._searchAborted == false)
         {
            this.removeFakeMech();
            this.createFakeMech();
         }
      }
      
      private function removeFakeMech() : void
      {
         if(this._mechViewFake != null)
         {
            this._mechViewFake.removeMe();
            TweenMax.killTweensOf(this._mechViewFake);
            this._mechViewFake = null;
         }
      }
      
      private function activateSearchingAnimation() : void
      {
         this.mcSearchingTitle.visible = true;
         TweenMax.fromTo(this.mcSearchingTitle,0.2,{"y":500},{"y":this._searchingOriginalYPos});
         TweenMax.to(this.mcSearchingTitle.mcDot1,this.SEARCHING_DOT_ALPHA_TIME,{
            "delay":0,
            "alpha":0,
            "onComplete":this.dotAlphaOutAnimCompleted,
            "onCompleteParams":[this.mcSearchingTitle.mcDot1]
         });
         TweenMax.to(this.mcSearchingTitle.mcDot2,this.SEARCHING_DOT_ALPHA_TIME,{
            "delay":0.2,
            "alpha":0,
            "onComplete":this.dotAlphaOutAnimCompleted,
            "onCompleteParams":[this.mcSearchingTitle.mcDot2]
         });
         TweenMax.to(this.mcSearchingTitle.mcDot3,this.SEARCHING_DOT_ALPHA_TIME,{
            "delay":0.4,
            "alpha":0,
            "onComplete":this.dotAlphaOutAnimCompleted,
            "onCompleteParams":[this.mcSearchingTitle.mcDot3]
         });
         updateTextAndFormat(this.mcSearchingTitle.txtSearching,getScreenText("searching"));
      }
      
      private function dotAlphaOutAnimCompleted(param1:Sprite) : void
      {
         TweenMax.to(param1,this.SEARCHING_DOT_ALPHA_TIME,{
            "delay":this.SEARCHING_DOT_INVISIBLE_WAIT_TIME,
            "alpha":1,
            "onComplete":this.dotAlphaInAnimCompleted,
            "onCompleteParams":[param1]
         });
      }
      
      private function dotAlphaInAnimCompleted(param1:Sprite) : void
      {
         TweenMax.to(param1,this.SEARCHING_DOT_ALPHA_TIME,{
            "delay":this.SEARCHING_DOT_VISIBLE_WAIT_TIME,
            "alpha":0,
            "onComplete":this.dotAlphaOutAnimCompleted,
            "onCompleteParams":[param1]
         });
      }
      
      private function removeSearching() : void
      {
         TweenMax.killTweensOf(this.mcSearchingTitle.mcDot1);
         TweenMax.killTweensOf(this.mcSearchingTitle.mcDot2);
         TweenMax.killTweensOf(this.mcSearchingTitle.mcDot3);
         this.mcSearchingTitle.visible = false;
      }
      
      public function cancelClicked() : void
      {
         if(this._startBattleDelayActive)
         {
            this.btnCancel.disableMe();
            return;
         }
         this._searchAborted = true;
         remoteM.socketM.lobby_cancelSearchForBattle();
         this.btnCancel.disableMe();
         updateTextAndFormat(this.mcSearchingTitle.txtSearching,getScreenText("aborting"));
      }
      
      public function cancelSearchForBattleSuccess() : void
      {
         if(this._cancelCallback != null)
         {
            this._cancelCallback();
         }
         if(this._canCloseScreen)
         {
            this.initCloseScreenAnimations(true);
         }
         else
         {
            this._waitingToCloseScreen = true;
         }
      }
      
      private function lightningHandler() : void
      {
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         var _loc1_:uint = Math.ceil(Math.random() * 3);
         if(_loc1_ == 1)
         {
            _loc1_ = Math.ceil(Math.random() * 4);
            switch(_loc1_)
            {
               case 1:
               case 2:
               case 3:
            }
            _loc3_.scaleX = 0.5;
            _loc3_.scaleY = 0.5;
            _loc3_.rotation = Math.random() * 100 - 50;
            _loc1_ = Math.ceil(Math.random() * 2);
            if(_loc1_ == 1)
            {
               _loc3_.scaleX *= -1;
            }
            this.mcEffectsHolder.addChild(_loc3_);
            this._lightnings.push(_loc3_);
         }
         var _loc2_:Number = this._lightnings.length - 1;
         while(_loc2_ >= 0)
         {
            _loc4_ = this._lightnings[_loc2_];
            _loc4_.alpha -= 0.05;
            if(_loc4_.alpha <= 0.1)
            {
               _loc4_.parent.removeChild(_loc4_);
               _loc4_ = null;
               this._lightnings.splice(_loc2_,1);
            }
            _loc2_--;
         }
      }
      
      private function initTip() : void
      {
         this._tipOriginYPos = this.txtTip.y;
         this.setTipText();
      }
      
      private function setTipText(param1:String = "") : void
      {
         updateTextAndFormat(this.txtTip,param1);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("vs_tip",[this.txtTip],"",this);
         }
      }
      
      private function refreshTip() : void
      {
         this.setTipText(dataM.tipsManager.getTip());
         this.txtTip.y = this._tipOriginYPos;
         if(this.txtTip.numLines == 1)
         {
            this.txtTip.y += 10;
         }
      }
      
      public function addInstantMultipleMechs() : void
      {
         var _loc3_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:BMMissionMechStats = null;
         var _loc1_:uint = 1;
         var _loc2_:Array = new Array();
         this._mechsPerPlayer = 2;
         if(dataM.raidData.isRaidInProgress())
         {
            this._mechsPerPlayer = dataM.raidData.mechsPerPlayer;
         }
         else if(dataM.myProfile.currentStoryID == BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3)
         {
            this._mechsPerPlayer = 3;
         }
         if(this._mechsPerPlayer == 2)
         {
            if(dataM.myProfile.missionCurrentMechID == 2)
            {
               _loc2_.push(1);
            }
            else
            {
               _loc2_.push(2);
            }
         }
         else if(dataM.myProfile.missionCurrentMechID == 2)
         {
            _loc2_.push(1,3);
         }
         else if(dataM.myProfile.missionCurrentMechID == 3)
         {
            _loc2_.push(1,2);
         }
         else
         {
            _loc2_.push(2,3);
         }
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = uint(_loc2_[_loc4_]);
            _loc5_ = false;
            if(dataM.gameType == BMDataManager.GAME_TYPE_REPLAY)
            {
               _loc5_ = true;
            }
            else
            {
               _loc6_ = dataM.myProfile.mission_mechStats[_loc3_ - 1];
               if(_loc6_.hp > 0)
               {
                  _loc5_ = true;
               }
            }
            if(_loc5_)
            {
               this.addInstantMech(_loc1_,_loc3_,_loc4_ + 1);
            }
            _loc4_++;
         }
         _loc1_ = 2;
         _loc3_ = 2;
         this.addInstantMech(_loc1_,_loc3_,1);
         if(this._mechsPerPlayer == 3)
         {
            _loc3_ = 3;
            this.addInstantMech(_loc1_,_loc3_,2);
         }
      }
      
      private function addInstantMech(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:uint = dataM.player1PlayerID;
         if(param1 == 2)
         {
            _loc4_ = dataM.player2PlayerID;
         }
         var _loc5_:Sprite = this["mcPlayer" + param1 + "MechsHolder"];
         var _loc6_:BMMechStructure = dataM.playersData[_loc4_].mechStructures[param2];
         var _loc7_:BMMechView = new BMMechView();
         _loc5_.addChild(_loc7_);
         this._mechViews[param1][param2] = _loc7_;
         var _loc8_:Array = [param1,_loc7_,param3];
         this.initAndBuildMech(_loc7_,_loc4_,_loc6_,BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,1,this.instantMechBuilt,_loc8_);
      }
      
      private function instantMechBuilt(param1:Array) : void
      {
         var _loc2_:uint = uint(param1[0]);
         var _loc3_:BMMechView = param1[1];
         var _loc4_:uint = uint(param1[2]);
         var _loc5_:int = 1;
         var _loc6_:Number = 0.2;
         if(_loc2_ == 2)
         {
            _loc5_ = -1;
            _loc6_ = 0.6;
         }
         if(_loc4_ == 2)
         {
            _loc6_ += 0.2;
         }
         var _loc7_:Sprite = this["mcPlayer" + _loc2_ + "MechMainPosition"];
         this.repositionMechView(_loc3_,_loc7_);
         _loc3_.scaleX *= _loc5_;
         var _loc8_:Number = _loc7_.x - this.MECH_X_DISTANCE * _loc5_;
         var _loc9_:Number = _loc7_.x - 50 * _loc5_;
         var _loc10_:Number = _loc3_.y + 10;
         if(_loc4_ == 2)
         {
            _loc9_ -= 50 * _loc5_;
            _loc10_ += 10;
         }
         TweenMax.fromTo(_loc3_,0.4,{
            "x":_loc8_,
            "y":_loc10_
         },{
            "delay":_loc6_,
            "x":_loc9_,
            "onComplete":this.instantMechAnimInCompleted,
            "onCompleteParams":[_loc3_,_loc2_,_loc4_]
         });
      }
      
      private function instantMechAnimInCompleted(param1:BMMechView, param2:uint, param3:uint) : void
      {
         var _loc4_:Sprite = this["mcPlayer" + param2 + "MechMainPosition"];
         var _loc5_:int = 1;
         var _loc6_:Number = 1.3;
         if(param2 == 2)
         {
            _loc5_ = -1;
            _loc6_ = 1;
         }
         if(param3 == 2)
         {
            _loc6_ -= 0.4;
         }
         if(this._mechsPerPlayer == 3)
         {
            _loc6_ += this.EXTRA_DELAY_FOR_3V3;
         }
         var _loc7_:Number = _loc4_.x - this.MECH_X_DISTANCE * _loc5_;
         TweenMax.to(param1,0.45,{
            "delay":_loc6_,
            "x":_loc7_
         });
      }
      
      private function startArena3v3PreviewProcedure() : void
      {
         this.startPickingMechsProcedure();
         this.selectionUpdate(1,true,true);
         this.selectionUpdate(2,true,true);
         this.selectionUpdate(3,true,true);
         this.disablePickMechInterface();
         this.markOpponentPickedMechs(this._arena3v3Preview);
         TweenMax.delayedCall(0.1,this.mechsPickedCloseScreen);
      }
      
      private function startPickingMechsProcedure() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = new Array();
         _loc1_[1] = new Array();
         _loc1_[2] = new Array();
         var _loc2_:Array = new Array();
         _loc2_[1] = dataM.player1PlayerID;
         _loc2_[2] = dataM.player2PlayerID;
         var _loc3_:uint = 1;
         while(_loc3_ <= 2)
         {
            _loc4_ = int(_loc2_[_loc3_]);
            _loc1_[_loc3_] = this.getReadyForBattleMechIDs(_loc3_);
            if(_loc1_[_loc3_].length != 1)
            {
               this.createRestOfPickMechs(_loc3_,_loc1_[_loc3_]);
            }
            _loc3_++;
         }
         this._selectedMechSlots = new Array();
         if(this._arena3v3Preview == false)
         {
            this.mcVSCenterInterface.showPickMechInterface(this._maxMechs);
         }
         this.btnCancel.visible = false;
         this.mcBackground_top.mcBackBackground.visible = true;
         if(_loc1_[1].length == this._mechsPerPlayer)
         {
            _loc5_ = 1;
            while(_loc5_ <= this._mechsPerPlayer)
            {
               this.selectionUpdate(_loc5_,false);
               _loc5_++;
            }
         }
      }
      
      private function pickMechs() : void
      {
         this.btnReady.addEventListener(BMIntractable.HIT,this.pickMechsReadyClicked);
         this._opponentFound = true;
         this._pickMechs = true;
         this.initPickMechsTimer();
         this.createOpponentMech(this.getMechStructure(2,1),BMMechStructure.ITEM_TYPE_ITEM_ID);
         if(this._onlineBattle)
         {
            this.startFakeMechOutAnim(true);
         }
      }
      
      private function getMechStructure(param1:int, param2:int) : BMMechStructure
      {
         var _loc3_:Array = new Array();
         _loc3_[1] = dataM.player1PlayerID;
         _loc3_[2] = dataM.player2PlayerID;
         if(param1 == 2 && this._opponentMechStructures != null)
         {
            return this._opponentMechStructures[param2 - 1];
         }
         var _loc4_:int = int(_loc3_[param1]);
         var _loc5_:BMPlayerData = dataM.playersData[_loc4_];
         return _loc5_.mechStructures[param2];
      }
      
      private function initPickMechsData() : void
      {
         var _loc2_:uint = 0;
         this._pickMechPositions = new Array();
         var _loc1_:uint = 1;
         while(_loc1_ <= 2)
         {
            this._pickMechPositions[_loc1_] = new Array();
            _loc2_ = 1;
            while(_loc2_ <= 3)
            {
               this.initPickMechsDataSub(_loc1_,_loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function initPickMechsDataSub(param1:uint, param2:uint) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc3_:BMVSPickMechInterface = this["player" + param1 + "PickMech" + param2 + "Button"];
         this._pickMechPositions[param1][param2] = new Point(_loc3_.x,_loc3_.y);
         if(param1 == 1)
         {
            _loc3_.x -= this.PICK_MECH_BUTTON_X_JUMP;
            _loc4_ = true;
            _loc5_ = false;
            _loc3_.initialize(param2,_loc4_,_loc5_,this.selectionUpdate);
         }
         else
         {
            _loc3_.x += this.PICK_MECH_BUTTON_X_JUMP;
            _loc3_.initialize();
         }
      }
      
      private function selectionUpdate(param1:uint, param2:Boolean, param3:Boolean = false) : void
      {
         var _loc4_:BMVSPickMechInterface = this["player1PickMech" + param1 + "Button"];
         if(param3)
         {
            _loc4_.selected = true;
            return;
         }
         var _loc5_:Number = this._selectedMechSlots.indexOf(param1);
         if(_loc5_ == -1)
         {
            if(param2 == false && this._selectedMechSlots.length < this._maxMechs)
            {
               this._selectedMechSlots.push(param1);
               _loc4_.selected = true;
            }
         }
         else if(param2)
         {
            this._selectedMechSlots.splice(_loc5_,1);
            _loc4_.selected = false;
         }
         this.mcVSCenterInterface.updateMechsSelected(this._selectedMechSlots.length);
         if(this._arena3v3Preview == false && this._selectedMechSlots.length == this._maxMechs)
         {
            TweenMax.killTweensOf(this.btnReady);
            this.btnReady.enableMe();
            TweenMax.fromTo(this.btnReady,0.25,{
               "visible":true,
               "scaleX":0,
               "scaleY":0
            },{
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut
            });
         }
         else
         {
            this.hideReadyButton();
         }
      }
      
      private function hideReadyButton() : void
      {
         TweenMax.killTweensOf(this.btnReady);
         this.btnReady.disableMe();
         TweenMax.to(this.btnReady,0.25,{
            "visible":false,
            "scaleX":0,
            "scaleY":0
         });
      }
      
      private function pickMechsReadyClicked(param1:Event) : void
      {
         this.btnReady.disableMe();
         TweenMax.killTweensOf(this.btnReady);
         TweenMax.to(this.btnReady,0.25,{
            "visible":false,
            "scaleX":0,
            "scaleY":0,
            "ease":Back.easeOut
         });
         TweenMax.to(this,0,{
            "delay":0.2,
            "onComplete":this.pickMechsReadyClickedSub
         });
      }
      
      private function pickMechsReadyClickedSub() : void
      {
         dataM.pickMechs(this._selectedMechSlots);
      }
      
      public function startPickMechFlow(param1:Array) : *
      {
         this._opponentMechStructures = param1;
         this.pickMechs();
      }
      
      public function notifyMechSelectionConfirmed() : *
      {
         this.btnReady.disableMe();
      }
      
      private function getReadyForBattleMechIDs(param1:uint) : Array
      {
         var _loc4_:BMMechStructure = null;
         var _loc2_:Array = new Array();
         var _loc3_:uint = 1;
         while(_loc3_ <= dataM.battleMaxMechs)
         {
            _loc4_ = this.getMechStructure(param1,_loc3_);
            if(dataM.isMechStructureReadyForBattle(_loc4_))
            {
               _loc2_.push(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function createRestOfPickMechs(param1:uint, param2:Array) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerData = null;
         var _loc7_:BMMechStructure = null;
         var _loc8_:String = null;
         var _loc9_:BMMechView = null;
         var _loc3_:uint = dataM.player1PlayerID;
         if(param1 == 2)
         {
            _loc3_ = dataM.player2PlayerID;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < param2.length)
         {
            if(_loc4_ != 0)
            {
               _loc5_ = uint(param2[_loc4_]);
               _loc6_ = dataM.playersData[_loc3_];
               _loc7_ = this.getMechStructure(param1,_loc5_);
               _loc8_ = param1 == 1 ? BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID : BMMechStructure.ITEM_TYPE_ITEM_ID;
               if(this._arena3v3Preview)
               {
                  _loc8_ = BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID;
               }
               _loc9_ = new BMMechView();
               this._mechViews[param1][_loc5_] = _loc9_;
               this.initAndBuildMech(_loc9_,_loc3_,_loc7_,_loc8_,this.PICK_MECH_SCALE,this.createRestOfPickMechsSub,[param1,_loc5_]);
            }
            _loc4_++;
         }
         this.movePickMech(1,1);
         this.movePickMechButton(1,1);
         this.movePickMech(2,1);
         this.movePickMechButton(2,1);
      }
      
      private function createRestOfPickMechsSub(param1:Array) : void
      {
         var _loc2_:uint = uint(param1[0]);
         var _loc3_:uint = uint(param1[1]);
         var _loc4_:BMMechView = this._mechViews[_loc2_][_loc3_];
         _loc4_.x = -100;
         if(_loc2_ == 2)
         {
            _loc4_.x = 900;
            _loc4_.scaleX *= -1;
         }
         var _loc5_:Point = this._pickMechPositions[_loc2_][_loc3_];
         _loc4_.y += _loc5_.y;
         if(_loc2_ == 2)
         {
            this.mcPlayer2MechsHolder.addChild(_loc4_);
         }
         else
         {
            this.mcPlayer1MechsHolder.addChild(_loc4_);
         }
         this.movePickMech(_loc2_,_loc3_);
         this.movePickMechButton(_loc2_,_loc3_);
      }
      
      private function movePickMech(param1:uint, param2:uint) : void
      {
         var _loc3_:BMMechView = this.getMechView(param1,param2);
         var _loc4_:Number = 0.1 * (param2 - 1) + 0.3 * (param1 - 1);
         var _loc5_:Point = this._pickMechPositions[param1][param2];
         var _loc6_:Number = this.PICK_MECH_SCALE;
         var _loc7_:Number = this.PICK_MECH_SCALE;
         var _loc8_:Number = _loc5_.x;
         var _loc9_:Number = _loc3_.y;
         if(param2 > 1)
         {
            _loc6_ = 1;
            _loc7_ = 1;
         }
         else
         {
            _loc9_ = _loc5_.y - _loc3_.getSizerHeightFromCenterToBottom() * _loc7_;
         }
         if(param1 == 2)
         {
            _loc6_ *= -1;
         }
         TweenMax.to(_loc3_,0.35,{
            "delay":_loc4_,
            "x":_loc8_,
            "y":_loc9_,
            "scaleX":_loc6_,
            "scaleY":_loc7_,
            "onComplete":this.moveMechToPickMechInterfaceCompleted,
            "onCompleteParams":[param1,param2]
         });
      }
      
      private function movePickMechButton(param1:uint, param2:uint) : void
      {
         var _loc3_:BMVSPickMechInterface = this["player" + param1 + "PickMech" + param2 + "Button"];
         var _loc4_:Number = 0.1 * (param2 - 1) + 0.3 * (param1 - 1);
         var _loc5_:Point = this._pickMechPositions[param1][param2];
         TweenMax.to(_loc3_,0.35,{
            "delay":_loc4_,
            "x":_loc5_.x
         });
      }
      
      private function initPickMechsTimer() : void
      {
         this._pickMechsSecondsLeft = 30;
         this._pickMechsTimer = new Timer(1000);
         this._pickMechsTimer.addEventListener(TimerEvent.TIMER,this.onPickMechsTimerTrigger);
         this._pickMechsTimer.start();
      }
      
      private function removePickMechsTimer() : void
      {
         if(this._pickMechsTimer != null)
         {
            this._pickMechsTimer.stop();
            this._pickMechsTimer = null;
         }
      }
      
      private function onPickMechsTimerTrigger(param1:TimerEvent) : void
      {
         if(this._pickMechsSecondsLeft == 0)
         {
            this.removePickMechsTimer();
            return;
         }
         if(this._pickMechsSecondsLeft == 1)
         {
            this.mcVSCenterInterface.pickMechsTimeEnded();
         }
         if(this._pickMechsSecondsLeft > 0)
         {
            --this._pickMechsSecondsLeft;
            this.mcVSCenterInterface.updateClock(this._pickMechsSecondsLeft);
         }
      }
      
      private function removeAllMechs() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:uint = 1;
         while(_loc1_ <= 2)
         {
            _loc2_ = 1;
            while(_loc2_ <= dataM.battleMaxMechs)
            {
               this.removeMech(_loc1_,_loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeSearching();
         this.removeAllMechs();
         this.removeFakeMech();
         this.killAllTweens();
         this.removePickMechsTimer();
      }
      
      private function killAllTweens() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMMechView = null;
         TweenMax.killTweensOf(this.mcBackground_top);
         TweenMax.killTweensOf(this.mcBackground_bottom);
         TweenMax.killTweensOf(this.mcBackground_left);
         TweenMax.killTweensOf(this.mcBackground_right);
         TweenMax.killTweensOf(this.mcVSCenterInterface);
         TweenMax.killTweensOf(this.btnCancel);
         TweenMax.killTweensOf(this.mcSearchingTitle);
         TweenMax.killTweensOf(this);
         var _loc1_:uint = 1;
         while(_loc1_ <= 2)
         {
            _loc2_ = 1;
            while(_loc2_ <= dataM.battleMaxMechs)
            {
               _loc3_ = this.getMechView(_loc1_,_loc2_);
               if(_loc3_ != null)
               {
                  TweenMax.killTweensOf(_loc3_);
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function hideMe() : void
      {
         TweenMax.killTweensOf(this._mechViewFake);
         this.removeMech(2,1);
         this.killAllTweens();
         visible = false;
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_VS);
      }
      
      public function notifyBattleFinishedBeforeStart(param1:Number, param2:BMLevelUpData, param3:Number, param4:Number, param5:Number, param6:Number, param7:BMRewardData = null) : void
      {
         this.removePickMechsTimer();
         BMScreenBattle.performFinishBattleOperations(BMDataManager.BATTLE_RESULT_OPPONENT_QUIT,param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function notifyBattleResultsCeremonyFinished() : *
      {
         screensM.screenBlack.activateBlackScreen(null,true,true,[],0,false,finalizeAnimationsAfterBattleCeremonyFinishedWithoutBattle);
      }
   }
}

