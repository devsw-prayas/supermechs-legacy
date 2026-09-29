package net.battleMechsMulti.screens
{
   import fl.motion.Color;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.battleMechsMulti.managers.BMComputerManager;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMActionRange;
   import net.battleMechsMulti.mobiles.BMBattleTurnData;
   import net.battleMechsMulti.mobiles.BMFloorBuff;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMMechDrone;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMReplayAction;
   import net.battleMechsMulti.mobiles.BMReplayStatus;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossData;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1556")]
   public class BMScreenBattle extends BMBaseScreen
   {
      
      private var computerM:BMComputerManager;
      
      private var _mechBattleDatas:Object;
      
      private var _interfaceEnabled:Boolean;
      
      private var _refreshBattleView_low_frames:Number;
      
      private var _refreshBattleViewImmediately:Boolean;
      
      private var _battleViewMech1_lastMainHolderXPos:Number;
      
      private var _battleViewMech2_lastMainHolderXPos:Number;
      
      private var _battleViewMech1_lastMechViewXPos:Number;
      
      private var _battleViewMech2_lastMechViewXPos:Number;
      
      public var holder_main:MovieClip;
      
      public var holder_backgrounds:MovieClip;
      
      private var holder_backgroundFloor:MovieClip;
      
      public var holder_drones:MovieClip;
      
      private var holder_mechs:MovieClip;
      
      private var holder_actionRange:MovieClip;
      
      public var holder_mechBattleTooltips:MovieClip;
      
      public var holder_effects:MovieClip;
      
      public var holder_staticEffects:MovieClip;
      
      public var mcButtonsHolder:MovieClip;
      
      private var _showTalkingBox1:Boolean;
      
      private var _showTalkingBox2:Boolean;
      
      private var background_level0:MovieClip;
      
      private var background_floor:MovieClip;
      
      public var sparksBMD:BitmapData;
      
      public var sparksBM:Bitmap;
      
      private var _socketActionAllowed:Boolean;
      
      private var _LASTsocketActionAllowed:Boolean;
      
      private var _battleTurnData:BMBattleTurnData;
      
      private var _battleEnabled:Boolean;
      
      private var _currentPlayerID:Number;
      
      private var _currentPlayerInterfacePlayerID:Number;
      
      private var _opponentPlayerID:Number;
      
      private var _opponentPlayerInterfacePlayerID:Number;
      
      private var _turn:Number;
      
      private var _mechSlotToHide:uint;
      
      private var _mechSlotToShow:uint;
      
      private var _movingFramesCounter:Number;
      
      private var _movingFramesMax:Number;
      
      private var _movingXPerFrame:Number;
      
      private var _movingSteps:Number;
      
      private var _viewScale:Number;
      
      private var _viewScaleFinal:Number;
      
      private var _mainHolderXPos:Number;
      
      private var _zoomOut:Boolean;
      
      private var _zoomViewChangeFrames:Number;
      
      private var _delayNewActionFrameCounter:Number;
      
      private var _stopBattleViewAfterDelayNewAction:Boolean;
      
      private var _endTurnFrameCounter:Number;
      
      private var _energyRegenerationDelayFrameCounter:Number;
      
      private var _lastAction:String;
      
      private var _takeDamage_effectType:String;
      
      private var _beamAttackSound:String;
      
      private var _attackEnded_refreshBars:Boolean;
      
      private var _attackEnded_performAction:Boolean;
      
      private var _pushAnimEndedActionPerformed:Boolean;
      
      private var _moveLastOriginStep:Number;
      
      private var _moveLastTargetStep:Number;
      
      private var _moveLastMotionType:String;
      
      private var _teleportElectricityXOrigin:Number;
      
      private var _teleportElectricityXPos:Number;
      
      private var _teleportElectricityYPos:Number;
      
      private var _teleportElectricityXAddon:Number;
      
      private var _teleportElectricitySize:Number;
      
      private var _teleportElectricityCounter:Number;
      
      private var _teleportElectricityFrameCounter:Number;
      
      private var _zoomOutForTeleport:Boolean;
      
      private var _battleResult:String;
      
      private var _replayActionCooldown:Number;
      
      private var _lastWeaponEquipmentType:String;
      
      private var _lastWeaponEquipmentID:Number;
      
      private var _lastWeaponDamageType:Number;
      
      private var _lastHPBeforeRepairDrone:Number;
      
      private var _delayNewActionHandler:Boolean;
      
      private var _mechTeaseAnimationsHandler:Boolean;
      
      private var _teleportDamageHandler:Boolean;
      
      private var _mechWalkingHandler:Boolean;
      
      private var _mechJumpingHandler:Boolean;
      
      private var _energyRegenerationHandler:Boolean;
      
      private var _endTurnDelayHandler:Boolean;
      
      private var _replayActionCooldownHandler:Boolean;
      
      private var _earthQuakeHandler:Boolean;
      
      private var _getHitSoundsHandler:Boolean;
      
      private var _droneXScaleHandler:Boolean;
      
      private var _finishBackgroundDarknessHandler:Boolean;
      
      private var _bulletShellsHandler:Boolean;
      
      private var _bulletShellsCounter:Number;
      
      private var _bulletShellsXPos:Number;
      
      private var _bulletShellsYPos:Number;
      
      private var _bulletShellsGrp:String;
      
      private var _bulletShellsDirection:String;
      
      private var _finishBackgroundCountdown:Number;
      
      private var _earthQuakeCounter:Number;
      
      private var _getHitSoundsAllSoundsCountdown:Number;
      
      private var _getHitSoundsSpecificSoundCountdown:Number;
      
      private var _mechTeaseAnimationCounter:Number;
      
      private var _holderMainOriginYPos:Number;
      
      private var _timerNotice:Boolean;
      
      private var _forceShutDown:Boolean;
      
      private var floors:Array;
      
      private var floorStepNumbers:Array;
      
      private var _playerMechRollOver:Boolean;
      
      private var _stompUnlocked_alreadyDisplayed:Boolean;
      
      private var _stompUnlocked_displayNow:Boolean;
      
      private var _activatePlayer1Entry:Boolean;
      
      private var _activatePlayer2Entry:Boolean;
      
      private var _currentMusicTrack:Number;
      
      private var _goToPremiumAccount:Boolean;
      
      private var _replayActionSlot:Number;
      
      private var _waitingForTaunt:Boolean;
      
      private var _startingWithOneAPDisplayed:Boolean = false;
      
      private var _teleportAfterEffectCountdown:Number;
      
      private var _teleportAfterEffectXPos:Number;
      
      private var _teleportAfterEffectYPos:Number;
      
      private var _challengeDamageTotalDamage:Number;
      
      private var _resumeBattleAfterSpawning:Boolean;
      
      private var _resumeBattleAfterSpawningCountdown:uint;
      
      private var _battleReport:Object;
      
      public var actionRange:BMActionRange;
      
      public var moveArrow:MovieClip;
      
      public var moveToStepArrow:MovieClip;
      
      public var mouseHitAreaHolder:MovieClip;
      
      public var mapBorder1:MovieClip;
      
      public var mapBorder2:MovieClip;
      
      public var mechHologram:MovieClip;
      
      private var _floorBuffs:Array = new Array();
      
      private var _lastFloorBuffStep:Number = -1;
      
      private var mcTurnMarker1:Sprite;
      
      private var mcTurnMarker2:Sprite;
      
      private var _opponentMechTooltipType:String;
      
      private var _opponentMechTooltipEquipmentID:Number;
      
      private var _lastOpponentMechTooltipType:String;
      
      private var _battleResult_available:Boolean;
      
      private var _battleResult_triggerOnSpot:Boolean;
      
      private var _battleResult_newGold:Number;
      
      private var _battleResult_goldFromLevelUp:Number;
      
      private var _battleResult_tokensFromLevelUp:Number;
      
      private var _battleResult_newXP:Number;
      
      private var _battleResult_newRank:Number;
      
      private var _battleResult_newLadderProgress:Number;
      
      private var _reEnableBottomInterface:Boolean;
      
      private var _skipStartNewActionEnbaleInterface:Boolean;
      
      private var _setSocketAllowedStatusTrueInStartNewActionSub:Boolean;
      
      private var _skipNexySocketCallsHandlerEnbaleInterface:Boolean = false;
      
      private var _singlePlayerActions:Array;
      
      private var _singlePlayerActionSlot:uint;
      
      private var _mechReflectionBMD:BitmapData;
      
      private var _mechReflectionBM:Bitmap;
      
      private var mechReflectionHolder:MovieClip;
      
      private var _allowFinishMoves:Boolean;
      
      private var _waitingForFinishMove:Boolean;
      
      private var _finishMoveID:Number;
      
      private var _totalDamageInCurrentTurn:Number;
      
      private var _giveTutorialItems:Boolean;
      
      private var _dungeonWins:Number;
      
      private var _lastGeneralSpeedRatio:Number = 1;
      
      private var _floorWidth:Number;
      
      private var _halfStageWidth:Number;
      
      private var _ignoreLegTooltip:Boolean;
      
      private var _clientDisconnected:Boolean;
      
      private var _battlePhase:String;
      
      private var _waitingForMechToBeDestroyed:Boolean;
      
      private var _lastPlayerLostID:uint = 0;
      
      private var _durabilityChanges:Array;
      
      private var mech1CodeStepMarker:Sprite;
      
      private var mech2CodeStepMarker:Sprite;
      
      public const FLOOR_STEP_SIZE:Number = 200;
      
      public const WALKING_LEG_X_DISTANCE:Number = 40;
      
      private const DELAY_NEW_ACTION_FRAMES_DEFAULT:Number = 10;
      
      private const DELAY_NEW_ACTION_FRAMES_DRONE_ACTIVATED:Number = 40;
      
      private const DELAY_NEW_ACTION_FRAMES_FIRE:Number = 35;
      
      private const DELAY_NEW_ACTION_FRAMES_END_TURN:Number = 40;
      
      private const FLYING_NUMBER_Y_ADDON:Number = -30;
      
      private const FLYING_NUMBER_DELAY_FRAMES:Number = 10;
      
      private const AP_MAX:Number = 2;
      
      private const FORCE_SHUTDOWN_TURNS:Number = 3;
      
      private const ZOOM_OUT_MAIN_HOLDER_DISTANCE_FROM_BORDER:Number = 35;
      
      private const ZOOMING_SCALE_MIN_CHANGE_RATIO:Number = 0.001;
      
      private const DISTACE_FROM_MECHS_TO_SCREEN_BORDERS_RATIO:Number = 1.7;
      
      private const MOVING_MAIN_HOLDER_MIN_CHANGE_IN_PIXELS:Number = 0.5;
      
      private const MOVING_MAIN_HOLDER_PER_FRAME_RATIO:Number = 0.2;
      
      public const MECH_WALKING_FRAMES:Number = 18;
      
      public const MECH_JUMPING_FRAMES:Number = 30;
      
      private const ENERGY_REGENERATION_DELAY_FRAMES:Number = 20;
      
      private const CHARGE_SELF_PUSH:Number = 1;
      
      private const AP_COST_REGULAR_ACTION:Number = 1;
      
      private const AP_COST_ATTACK:Number = 1;
      
      private const AP_COST_SHUTDOWN:Number = 1;
      
      private const ZOOM_VIEW_CHANGE_FRAMES:Number = 16;
      
      private const MECH_SIZE_RATIO:Number = 0.7;
      
      private const MECH_SIZE_RATIO_DWARF_PERK:Number = 0.35;
      
      private const MECH_SIZE_RATIO_GIANT_PERK:Number = 0.9;
      
      private const MECH_LIMP_EFFECT_HP_RATIO:Number = 0.25;
      
      public const JUMP_Y_CHANGE_PER_FRAME:Number = 2.4;
      
      private const SPARKS_PER_FRAME:Number = 20;
      
      private const SPARKS_SPAWNING_FRAMES:Number = 4;
      
      private const SPARKS_LIFE_FRAMES:Number = 40;
      
      public const SPARKS_BMD_WIDTH:Number = 8191;
      
      public const SPARKS_BMD_HEIGHT:Number = 700;
      
      public const SPARKS_BM_Y_POS:Number = -400;
      
      public const SPARKS_BM_Y_ADDON:Number = 300;
      
      public const DAMAGED_EFFECT_HP_RATIO:Number = 0.4;
      
      public const DAMAGED_EFFECT_RANDOM_BASE:Number = 20;
      
      public const DAMAGED_EFFECT_RANDOM_ADDON:Number = 20;
      
      public const OVERHEAT_EFFECT_RATIO:Number = 0.9;
      
      private const PLAYER_1_KIT_X_POS:Number = 28;
      
      private const PLAYER_1_KIT_Y_POS:Number = 162;
      
      private const PLAYER_2_KIT_X_POS:Number = 772;
      
      private const PLAYER_2_KIT_Y_POS:Number = 162;
      
      private const DISPLAY_STEP_NUMBERS:Boolean = false;
      
      private const REPLAY_COOLDOWN:Number = 10;
      
      private const BATTLE_VIEW_LOW_QUALITY_FRAMES:Number = 16;
      
      private const BATTLE_VIEW_LOW_QUALITY_FRAMES_PUSH:Number = 40;
      
      private const INSPECT_OPPONENT_WEAPONS_RANGE:Number = 225;
      
      private const GOD_MODE_HP_BASE:Number = 200;
      
      private const GOD_MODE_HP_PER_LEVEL:Number = 50;
      
      private const GOD_MODE_ENERGY_BASE:Number = 20;
      
      private const GOD_MODE_ENERGY_PER_LEVEL:Number = 4;
      
      private const GOD_MODE_ENERGY_REGENERATIO_BASE:Number = 10;
      
      private const GOD_MODE_ENERGY_REGENERATIO_PER_LEVEL:Number = 2;
      
      private const GOD_MODE_HEAT_BASE:Number = 20;
      
      private const GOD_MODE_HEAT_PER_LEVEL:Number = 4;
      
      private const GOD_MODE_HEAT_COOLING_BASE:Number = 10;
      
      private const GOD_MODE_HEAT_COOLING_PER_LEVEL:Number = 2;
      
      private const GOD_MODE_STOMP_DAMAGE_BASE:Number = 30;
      
      private const GOD_MODE_STOMP_DAMAGE_PER_LEVEL:Number = 3;
      
      private const GOD_MODE_WEAPON_DAMAGE_BASE:Number = 15;
      
      private const GOD_MODE_WEAPON_DAMAGE_PER_LEVEL:Number = 1;
      
      private const MISSION_JEEP_CRASH_DAMAGE_BASE:Number = 15;
      
      private const MISSION_JEEP_CRASH_DAMAGE_PER_LEVEL:Number = 1;
      
      private const MISSION_TANK_CRASH_DAMAGE_BASE:Number = 15;
      
      private const MISSION_TANK_CRASH_DAMAGE_PER_LEVEL:Number = 2;
      
      private const VIEW_SCALE_MINIMUM:Number = 0.771;
      
      private const TALKING_BOX_X_JUMP:Number = 400;
      
      private const CHALLENGE_DAMAGE_TURNS:Number = 5;
      
      private var FINISH_MOVES_FREQUENCY:Number = 4;
      
      public const USE_NUMBER_KEYS_FOR_INTERFACE:Boolean = false;
      
      public const MOBILE_MOUSE_DOWN_FRAMES_FOR_BATTLE_TOOLTIP:Number = 5;
      
      private const GRENADE_PULL_EXPLOSION_X_PUSH:uint = 125;
      
      public function BMScreenBattle()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("battle");
         this.computerM = new BMComputerManager();
         this.computerM.initialize();
         this.holder_backgroundFloor = new MovieClip();
         this.holder_drones = new MovieClip();
         this.holder_mechs = new MovieClip();
         this.holder_actionRange = new MovieClip();
         this.holder_effects = new MovieClip();
         this.holder_main.addChild(this.holder_backgroundFloor);
         this.holder_main.addChild(this.holder_drones);
         this.holder_main.addChild(this.holder_mechs);
         this.holder_main.addChild(this.holder_effects);
         this.holder_main.addChild(this.holder_actionRange);
         this.mapBorder1 = new mcMapBorder();
         this.mapBorder2 = new mcMapBorder();
         this.holder_mechs.addChild(this.mapBorder1);
         this.holder_mechs.addChild(this.mapBorder2);
         this.actionRange = new BMActionRange();
         this.actionRange.y -= 9;
         this.holder_actionRange.addChild(this.actionRange);
         this.moveArrow = new mcActionMoveArrow();
         this.holder_actionRange.addChild(this.moveArrow);
         if(dataM.runAsMobile == false)
         {
            this.moveToStepArrow = new mcActionTeleportArrow();
            this.holder_actionRange.addChild(this.moveToStepArrow);
         }
         this.mech1CodeStepMarker = new Sprite();
         this.mech2CodeStepMarker = new Sprite();
         this.holder_mechs.addChild(this.mech1CodeStepMarker);
         this.holder_mechs.addChild(this.mech2CodeStepMarker);
         this.floors = new Array();
         this._currentMusicTrack = Math.ceil(Math.random() * dataM.musicDB.length) - 1;
         this._holderMainOriginYPos = this.holder_main.y;
         this.mcTurnMarker1 = externalAssetsM.getAsset("general","mcMechTurnMarker1");
         this.mcTurnMarker2 = externalAssetsM.getAsset("general","mcMechTurnMarker2");
         this.holder_effects.addChild(this.mcTurnMarker1);
         this.holder_effects.addChild(this.mcTurnMarker2);
         this._stompUnlocked_alreadyDisplayed = false;
         this._battleEnabled = false;
         this._teleportAfterEffectCountdown = 0;
         this._halfStageWidth = dataM.STAGE_WIDTH / 2;
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null && dataM.battle_gamePaused == false)
         {
            this.battleViewHandler();
            this.lowHPAndHighHeatHandler();
            this.teleportAfterEffectHandler();
            this.delayNewActionHandler();
            this.mechTeaseAnimationsHandler();
            this.teleportDamageHandler();
            this.mechWalkingHandler();
            this.mechJumpingHandler();
            this.endTurnDelayHandler();
            this.replayActionCooldownHandler();
            this.triggerActiveMechs();
            this.turnMarkerHandler();
            this.socketCallsHandler();
            this.opponentMechTooltipHandler();
            this.playerTauntsHandler();
            this.getHitSoundsHandler();
            this.droneXScaleHandler();
            this.earthQuakeHandler();
            this.mechReflectionHandler();
            this.finishBackgroundDarknessHandler();
            this.chatBubblesHandler();
            this.bulletShellsHandler();
            this.resumeBattleAfterSpawningHandler();
         }
      }
      
      private function triggerActiveMechs() : void
      {
         var _loc2_:BMPlayerData = null;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc1_:uint = dataM.player1PlayerID;
         while(_loc1_ <= dataM.player2PlayerID)
         {
            _loc2_ = dataM.playersData[_loc1_];
            _loc3_ = this.getMechSlot(_loc1_);
            _loc4_ = this._mechBattleDatas[_loc3_];
            _loc4_.onEnterFrameTrigger();
            _loc1_++;
         }
      }
      
      public function activateNextBattlePhase(param1:String, param2:Object = null) : void
      {
         var _loc3_:String = null;
         this._battlePhase = param1;
         if(dataM.clientRunningLocally)
         {
            _loc3_ = "";
            switch(this._battlePhase.substr(0,4))
            {
               case "init":
                  _loc3_ = "### INITIATE " + this._battlePhase.substr(9,this._battlePhase.length - 9);
                  break;
               case "acti":
                  _loc3_ = "### ACTION " + this._battlePhase.substr(7,this._battlePhase.length - 7);
                  break;
               case "turn":
                  _loc3_ = "### TURN " + this._battlePhase.substr(5,this._battlePhase.length - 5);
                  break;
               case "communication":
                  _loc3_ = "### COMMUNICATION " + this._battlePhase.substr(13,this._battlePhase.length - 13);
                  break;
               case "endBattle":
                  _loc3_ = "### END BATTLE " + this._battlePhase.substr(9,this._battlePhase.length - 9);
                  break;
               case "sync":
                  _loc3_ = "### SYNC " + this._battlePhase.substr(5,this._battlePhase.length - 5);
            }
         }
         switch(this._battlePhase)
         {
            case "initiate_screenVSIsClosed":
               this.screenVSIsClosed();
               break;
            case "initiate_startNewBattle":
               this.startNewBattleSuccess();
               break;
            case "initiate_player1Entry":
               this.createPlayer1Entry();
               break;
            case "initiate_player2Entry":
               this.createPlayer2Entry();
               break;
            case "sync_syncClientWithServer":
               this.syncClientWithServer(param2.syncData,param2.battleHasJustStarted);
               break;
            case "turn_start":
               this.startNewTurn();
               break;
            case "turn_startNewAction":
               this.startNewAction(param2.caller);
               break;
            case "turn_startNewActionSub":
               this.startNewActionSub();
               break;
            case "turn_actionPerformed":
               this.actionPerformed(param2.delayNewAction,param2.stopBattleViewAfterDelayNewAction,param2.caller);
               break;
            case "turn_actionPerformedSub":
               this.actionPerformedSub(param2.caller);
               break;
            case "turn_actionPerformedSubEnding":
               this.actionPerformedSubEnding();
               break;
            case "turn_endTurnSuccess":
               this.endTurnSuccess(param2.delayEndTurn,param2.swapPlayersOnly);
               break;
            case "action_moveMechToStepLocallySub":
               this.moveMechToStepLocallySub(param2.motionType,param2.targetStep);
               break;
            case "action_moveMechToStepSuccess":
               this.moveMechToStepSuccess(param2.motionType,param2.targetStep);
               break;
            case "action_fireLocallySub":
               this.fireLocallySub(param2.equipmentType,param2.equipmentID);
               break;
            case "action_fireSuccess":
               this.fireSuccess(param2.equipmentType,param2.equipmentID);
               break;
            case "action_switchMechSuccess":
               this.switchMechSuccess(param2.mechID);
               break;
            case "action_activateDroneLocallySub":
               this.activateDroneLocallySub();
               break;
            case "action_activateDroneSuccess":
               this.activateDroneSuccess();
               break;
            case "action_deactivateDroneLocallySub":
               this.deactivateDroneLocallySub();
               break;
            case "action_deactivateDroneSuccess":
               this.deactivateDroneSuccess();
               break;
            case "action_activateShieldLocallySub":
               this.activateShieldLocallySub();
               break;
            case "action_activateShieldSuccess":
               this.activateShieldSuccess();
               break;
            case "action_deactivateShieldLocallySub":
               this.deactivateShieldLocallySub();
               break;
            case "action_deactivateShieldSuccess":
               this.deactivateShieldSuccess();
               break;
            case "action_crashLocallySub":
               this.crashLocallySub();
               break;
            case "action_chargeLocallySub":
               this.chargeLocallySub();
               break;
            case "action_chargeSuccess":
               this.chargeSuccess();
               break;
            case "action_harpoonLocallySub":
               this.harpoonLocallySub();
               break;
            case "action_harpoonSuccess":
               this.harpoonSuccess();
               break;
            case "action_teleportLocallySub":
               this.teleportLocallySub(param2.targetStep);
               break;
            case "action_teleportSuccess":
               this.teleportSuccess(param2.targetStep);
               break;
            case "action_teleportSuccessSub":
               this.teleportSuccessSub(param2.targetStep);
               break;
            case "action_useKitLocallySub":
               this.useKitLocallySub(param2.equipmentID);
               break;
            case "action_useKitSuccess":
               this.useKitSuccess(param2.equipmentID);
               break;
            case "action_switchMech":
               break;
            case "action_shutDownLocallySub":
               this.shutDownLocallySub(param2.multiplier);
               break;
            case "action_shutDownSuccess":
               this.shutDownSuccess();
               break;
            case "action_energyRegenerationPhase":
               this.energyRegenerationPhase();
               break;
            case "action_energyRegenerationLocallySub":
               this.energyRegenerationLocallySub();
               break;
            case "action_energyRegenerationSuccess":
               this.energyRegenerationSuccess();
               break;
            case "communication_taunt":
            case "communication_sendMessage":
               break;
            case "endBattle_quit":
               this.tryToQuitBattle();
               break;
            case "endBattle_quitBattleVSComputerConfirmed":
               this.quitBattleVSComputerConfirmed();
               break;
            case "endBattle_quitBattleVSPlayerConfirmed":
               this.quitBattleVSPlayerConfirmed();
               break;
            case "endBattle_opponentHasQuit":
            case "endBattle_battleResult":
         }
      }
      
      public function startNewBattleSuccess() : void
      {
         var _loc2_:BMPlayerData = null;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:BMPlayerProfile = null;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            screensM.screenBattleInterfaceBottom.refreshScreen();
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
         {
            screensM.addScreen("screenBattleInterfaceEmotes");
            screensM.screenBattleInterfaceEmotes.parent.removeChild(screensM.screenBattleInterfaceEmotes);
            screensM.screenBattleInterfaceEmotes.refreshScreen();
         }
         if(screensM.USE_FPS_TRACKER)
         {
            screensM.screenFPSTracker.fpsTracker.resetMinAndMaxFPS();
         }
         screensM.screenBattleInterfaceTop.cleanTexts();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._stompUnlocked_displayNow = false;
         if(dataM.playingVSComputer && _loc1_.winsVSComputer == 1 && this._stompUnlocked_alreadyDisplayed == false)
         {
            this._stompUnlocked_alreadyDisplayed = true;
            this._stompUnlocked_displayNow = true;
         }
         if(dataM.battleData.startingPlayer == 1)
         {
            this._currentPlayerID = dataM.player1PlayerID;
            this._opponentPlayerID = dataM.player2PlayerID;
         }
         else
         {
            this._currentPlayerID = dataM.player2PlayerID;
            this._opponentPlayerID = dataM.player1PlayerID;
         }
         this._currentPlayerInterfacePlayerID = dataM.getInterfacePlayerID(this._currentPlayerID);
         this._opponentPlayerInterfacePlayerID = dataM.getInterfacePlayerID(this._opponentPlayerID);
         this._replayActionSlot = 0;
         this._floorWidth = this.FLOOR_STEP_SIZE * dataM.battleData.map.stepsTotal;
         this._mechBattleDatas = new Object();
         this.createFloorBuffs();
         var _loc3_:uint = dataM.player1PlayerID;
         while(_loc3_ <= dataM.player2PlayerID)
         {
            _loc2_ = dataM.playersData[_loc3_];
            _loc1_.wonLastBattleVSComputer = false;
            _loc2_.resetSwitchMechUses();
            _loc2_.APMax = this.AP_MAX;
            if(_loc3_ == this._currentPlayerID || dataM.playingVSComputer && _loc3_ == dataM.player1PlayerID)
            {
               _loc2_.AP = 1;
            }
            else
            {
               _loc2_.AP = _loc2_.APMax;
            }
            _loc2_.mechsDestroyed = 0;
            _loc8_ = 0;
            _loc2_.selectedMechID = 1;
            _loc9_ = 1;
            while(_loc9_ <= dataM.battleMechsPerPlayer)
            {
               this.createMechBattleData(_loc3_,_loc9_,_loc8_,0);
               if(_loc9_ == 1)
               {
                  this.createMechView(_loc3_,_loc9_);
               }
               _loc9_++;
            }
            _loc3_++;
         }
         this.refreshFloorBuffEffects("startNewBattleSuccess");
         this.createMapBackgrounds();
         _loc2_ = dataM.playersData[this._currentPlayerID];
         screensM.screenBattleInterfaceTop.resetWaitingForBattleResult();
         screensM.screenBattleInterfaceTop.refreshLevelAndRank(this._currentPlayerID);
         screensM.screenBattleInterfaceTop.refreshHP(this._currentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshEnergy(this._currentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshHeat(this._currentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshBullets(this._currentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshRockets(this._currentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshResistance(this._currentPlayerID,1,false);
         screensM.screenBattleInterfaceTop.refreshResistance(this._currentPlayerID,2,false);
         screensM.screenBattleInterfaceTop.refreshResistance(this._currentPlayerID,3,false);
         screensM.screenBattleInterfaceTop.refreshAP(this._currentPlayerID);
         _loc2_ = dataM.playersData[this._opponentPlayerID];
         screensM.screenBattleInterfaceTop.refreshLevelAndRank(this._opponentPlayerID);
         screensM.screenBattleInterfaceTop.refreshHP(this._opponentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshEnergy(this._opponentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshHeat(this._opponentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshBullets(this._opponentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshRockets(this._opponentPlayerID,false);
         screensM.screenBattleInterfaceTop.refreshResistance(this._opponentPlayerID,1,false);
         screensM.screenBattleInterfaceTop.refreshResistance(this._opponentPlayerID,2,false);
         screensM.screenBattleInterfaceTop.refreshResistance(this._opponentPlayerID,3,false);
         screensM.screenBattleInterfaceTop.refreshAP(this._opponentPlayerID);
         var _loc4_:Boolean = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
         {
            _loc4_ = true;
         }
         var _loc5_:String = "";
         var _loc6_:String = "";
         if(_loc4_)
         {
            if(_loc1_.geo != null)
            {
               _loc5_ = _loc1_.geo;
            }
            _loc10_ = dataM["player" + dataM.player2PlayerID + "Profile"];
            if(_loc10_.geo != null)
            {
               _loc6_ = _loc10_.geo;
            }
         }
         screensM.screenBattleInterfaceTop.setNameAndFlag(dataM.player1PlayerID,_loc5_);
         screensM.screenBattleInterfaceTop.setNameAndFlag(dataM.player2PlayerID,_loc6_);
         this.actionRange.initialize(dataM.battleData.map.stepsTotal,this.FLOOR_STEP_SIZE);
         this._zoomViewChangeFrames = 0;
         this._zoomOutForTeleport = false;
         screensM.screenBattleInterfaceTop.btnZoomOut.visible = true;
         screensM.screenBattleInterfaceTop.btnZoomIn.visible = false;
         screensM.screenBattleInterfaceTop.btnQuit.visible = true;
         screensM.screenBattleInterfaceTop.btnOptions.visible = true;
         screensM.screenBattleInterfaceTop.btnQuit.disableMe();
         screensM.screenBattleInterfaceTop.btnOptions.disableMe();
         screensM.screenBattleInterfaceTop.btnZoomIn.disableMe();
         screensM.screenBattleInterfaceTop.btnZoomOut.disableMe();
         screensM.screenBattleInterfaceTop.btnEmotesOpen.disableMe();
         screensM.screenBattleInterfaceTop.btnEmotesClose.disableMe();
         screensM.screenBattleInterfaceTop.btnPlayReplay.disableMe();
         screensM.screenBattleInterfaceTop.btnPauseReplay.disableMe();
         screensM.screenBattleInterfaceTop.hideTotalDamage();
         this._refreshBattleView_low_frames = 0;
         this._refreshBattleViewImmediately = true;
         this._battleViewMech1_lastMainHolderXPos = -1;
         this._battleViewMech2_lastMainHolderXPos = -1;
         this._battleViewMech1_lastMechViewXPos = -1;
         this._battleViewMech2_lastMechViewXPos = -1;
         this._delayNewActionHandler = false;
         this._teleportDamageHandler = false;
         this._mechWalkingHandler = false;
         this._mechJumpingHandler = false;
         this._energyRegenerationHandler = false;
         this._endTurnDelayHandler = false;
         this._replayActionCooldownHandler = false;
         this._earthQuakeHandler = false;
         this._getHitSoundsHandler = false;
         this._droneXScaleHandler = true;
         this._finishBackgroundDarknessHandler = false;
         this._bulletShellsHandler = false;
         this._resumeBattleAfterSpawning = false;
         this._pushAnimEndedActionPerformed = false;
         this._goToPremiumAccount = false;
         this._waitingForMechToBeDestroyed = false;
         this._lastFloorBuffStep = -1;
         this._durabilityChanges = new Array();
         this._opponentMechTooltipType = "";
         this._opponentMechTooltipEquipmentID = 0;
         this._lastOpponentMechTooltipType = "";
         this._lastHPBeforeRepairDrone = 0;
         this._lastPlayerLostID = 0;
         this._playerMechRollOver = false;
         this._interfaceEnabled = true;
         this._reEnableBottomInterface = false;
         this._clientDisconnected = false;
         this._setSocketAllowedStatusTrueInStartNewActionSub = false;
         this._singlePlayerActions = new Array();
         this._singlePlayerActionSlot = 0;
         this._giveTutorialItems = false;
         this._ignoreLegTooltip = false;
         dataM.battle_goToChatAfterBattle = false;
         dataM.battle_inviteToClanAfterBattle = false;
         switch(dataM.battleType)
         {
            case "mission":
               dataM.trackScreenView("battle_SP_mission");
               break;
            case "challenge":
               dataM.trackScreenView("battle_SP_challenge");
               break;
            case "regular":
               if(dataM.battle_inBattleInvitation)
               {
                  dataM.trackScreenView("battle_MP_private");
               }
               else if(dataM.gameType == BMDataManager.GAME_TYPE_REPLAY)
               {
                  dataM.trackScreenView("battle_MP_replay");
               }
               else if(dataM.playingVSComputer)
               {
                  dataM.trackScreenView("battle_SP_regular");
               }
               else
               {
                  dataM.trackScreenView("battle_MP_ladder");
               }
         }
         if(dataM.battleType == "mission")
         {
            switch(dataM.battleSubType)
            {
               case "turret":
               case "tank":
               case "jeep":
                  this._ignoreLegTooltip = true;
            }
         }
         this.refreshMechsView();
         this.hideInterface("startNewBattleSuccess");
         if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            screensM.screenBattleInterfaceBottom.newBattleStarted();
            screensM.screenBattleInterfaceBottom.player1MechBattleTooltip.hideToolTip(true);
            screensM.screenBattleInterfaceBottom.player2MechBattleTooltip.hideToolTip(true);
            screensM.screenBattleInterfaceBottom.resetActionErrorMessage();
         }
         this._replayActionCooldown = this.REPLAY_COOLDOWN;
         dataM.savingReplay = false;
         screensM.screenBattleInterfaceTop.btnQuit.visible = true;
         this._activatePlayer1Entry = false;
         this._activatePlayer2Entry = false;
         this._challengeDamageTotalDamage = 0;
         this._totalDamageInCurrentTurn = 0;
         this._dungeonWins = 0;
         this._skipNexySocketCallsHandlerEnbaleInterface = false;
         screensM.screenBattleInterfaceTop.hideTotalDamage();
         screensM.screenBattleInterfaceTop.replayBar.visible = false;
         screensM.screenBattleInterfaceTop.mcReplayProgressFrame.visible = false;
         screensM.screenBattleInterfaceTop.txtReplayProgress.visible = false;
         screensM.screenBattleInterfaceTop.txtTotalDamageTitle.visible = false;
         screensM.screenBattleInterfaceTop.txtTurnsLeftTitle.visible = false;
         screensM.screenBattleInterfaceTop.txtTurnsLeft.visible = false;
         screensM.screenBattleInterfaceTop.mcChallengeBackground.visible = false;
         if(dataM.battleType == "challenge")
         {
            if(dataM.battleSubType == "damage")
            {
               screensM.screenBattleInterfaceTop.refreshTotalDamage(0);
               screensM.screenBattleInterfaceTop.txtTotalDamageTitle.visible = true;
               screensM.screenBattleInterfaceTop.txtTurnsLeftTitle.visible = true;
               screensM.screenBattleInterfaceTop.txtTurnsLeft.visible = true;
               screensM.screenBattleInterfaceTop.refreshTurnsLeft(this.CHALLENGE_DAMAGE_TURNS);
               screensM.screenBattleInterfaceTop.mcChallengeBackground.visible = true;
            }
         }
         var _loc7_:Boolean = true;
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_GUEST:
               if(_loc1_.winsVSComputer < dataM.TUTORIAL_BATTLES && dataM.clientRunningLocally == false)
               {
                  screensM.screenBattleInterfaceTop.btnQuit.visible = false;
                  screensM.screenBattleInterfaceTop.btnZoomIn.visible = false;
                  screensM.screenBattleInterfaceTop.btnZoomOut.visible = false;
                  screensM.screenBattleInterfaceTop.btnOptions.visible = false;
               }
               if(_loc1_.winsVSComputer >= dataM.TUTORIAL_BATTLES)
               {
                  this.allowPlayer2Entry();
               }
               break;
            case BMDataManager.GAME_TYPE_ONLINE:
               if(dataM.playingVSComputer && dataM.clientRunningLocally == false)
               {
                  if(_loc1_.winsVSComputer < dataM.TUTORIAL_BATTLES)
                  {
                     screensM.screenBattleInterfaceTop.btnQuit.visible = false;
                     screensM.screenBattleInterfaceTop.btnZoomIn.visible = false;
                     screensM.screenBattleInterfaceTop.btnZoomOut.visible = false;
                     screensM.screenBattleInterfaceTop.btnOptions.visible = false;
                  }
               }
               if(dataM.playingVSComputer == false)
               {
                  ++_loc1_.onlineBattles;
               }
               if(dataM.playingVSComputer && _loc1_.winsVSComputer >= dataM.TUTORIAL_BATTLES)
               {
                  this.allowPlayer2Entry();
               }
               break;
            case BMDataManager.GAME_TYPE_REPLAY:
               screensM.screenBattleInterfaceTop.mcActionErrorMessage.visible = false;
               this.playLevelMusic();
               if(soundM.music)
               {
                  _loc7_ = false;
               }
               screensM.screenBattleInterfaceTop.replayBar.visible = true;
               screensM.screenBattleInterfaceTop.mcReplayProgressFrame.visible = true;
               screensM.screenBattleInterfaceTop.replayBar.setFill(0,false);
               screensM.screenBattleInterfaceTop.txtReplayProgress.visible = true;
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("battleInterfaceTop_txtReplayProgress",screensM.screenBattleInterfaceTop.txtReplayProgress,"",screensM.screenBattleInterfaceTop);
         }
         this._timerNotice = false;
         this._forceShutDown = false;
         if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            screensM.screenBattleInterfaceBottom.setHeatCriticalAlertCountdown(0);
            screensM.screenBattleInterfaceBottom.setShuttingDownAlertCountdown(0);
         }
         if(dataM.battleData.startingPlayer == 1)
         {
            this.activateMechTeaseAnimation();
         }
         else
         {
            this.deactivateMechTeaseAnimation();
         }
         screensM.screenBattleInterfaceTop.mcChat.visible = false;
         screensM.screenBattleInterfaceTop.btnEmotesOpen.visible = false;
         screensM.screenBattleInterfaceTop.btnEmotesClose.visible = false;
         screensM.screenBattleInterfaceTop.btnPlayReplay.visible = false;
         screensM.screenBattleInterfaceTop.btnPauseReplay.visible = false;
         screensM.screenBattleInterfaceTop.btnOptions.visible = false;
         if(dataM.playingVSComputer)
         {
            if(dataM.isTutorialActive() == false)
            {
               screensM.screenBattleInterfaceTop.btnOptions.visible = true;
            }
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
         {
            screensM.screenBattleInterfaceTop.btnEmotesOpen.visible = true;
         }
         else
         {
            screensM.screenBattleInterfaceTop.disableTimer();
            if(dataM.gameType == BMDataManager.GAME_TYPE_REPLAY)
            {
               screensM.screenBattleInterfaceTop.btnPauseReplay.visible = true;
            }
         }
         this.refreshTurnMarkersSizeAndPosition();
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
         {
            keyboardM.setKeyboardOutputFunction(this.keyboardOutput,"screenBattle");
            keyboardM.activateMe("screenBattle");
         }
         dataM.saveGuestData("battle startNewBattleSuccess");
         this._allowFinishMoves = false;
         this._waitingForFinishMove = false;
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_GUEST:
            case BMDataManager.GAME_TYPE_ONLINE:
               if(_loc1_.battlesVSComputer > 3)
               {
                  if(dataM.playingVSComputer)
                  {
                     switch(dataM.battleType)
                     {
                        case "regular":
                           if(dataM.battleSubType == "mech")
                           {
                              _loc11_ = Math.ceil(Math.random() * 4);
                              if(_loc11_ == 1)
                              {
                                 this._allowFinishMoves = true;
                              }
                           }
                           break;
                        case "challenge":
                           switch(dataM.battleSubType)
                           {
                              case "invisible":
                              case "godMode":
                              case "usa":
                              case "japan":
                                 this._allowFinishMoves = true;
                           }
                           break;
                        case "dungeon":
                           this._allowFinishMoves = true;
                     }
                  }
                  else if(_loc1_.onlineBattles % this.FINISH_MOVES_FREQUENCY == 0)
                  {
                     this._allowFinishMoves = true;
                  }
                  if(dataM.clientRunningLocally)
                  {
                  }
               }
               screensM.screenBattleInterfaceTop.displayOpponentModules();
         }
         if(dataM.clientRunningLocally)
         {
         }
         switch(dataM.player1PlayerID)
         {
            case dataM.OFFLINE_PLAYER_ID:
            case dataM.ONLINE_PLAYER_ID:
            case dataM.REPLAY_PLAYER1_ID:
               screensM.screenBattleInterfaceTop.showAvatarImage(false,1);
         }
         switch(dataM.player2PlayerID)
         {
            case dataM.OFFLINE_OPPONENT_ID:
            case dataM.ONLINE_OPPONENT_ID:
            case dataM.REPLAY_PLAYER2_ID:
               _loc12_ = false;
               if(dataM.battleType == "challenge")
               {
                  if(dataM.battleSubType == "damage")
                  {
                     _loc12_ = true;
                  }
               }
               if(_loc12_ == false)
               {
                  screensM.screenBattleInterfaceTop.showAvatarImage(false,2);
               }
         }
         this._battleEnabled = true;
         this._battleResult_available = false;
         this._battleResult_triggerOnSpot = false;
         this._lastAction = "none";
         this.setSocketAllowedStatus(false,"startNewBattleSuccess");
         this._LASTsocketActionAllowed = false;
         if(_loc7_)
         {
            soundM.removeAllMusic();
         }
         screensM.screenBattleInterfaceTop.mcPlayer1ChatBubble.closeMessage(true);
         screensM.screenBattleInterfaceTop.mcPlayer2ChatBubble.closeMessage(true);
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(1);
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(2);
         screensM.screenBattleInterfaceTop.createIconsBitmapsForMobile();
         screensM.screenBattleInterfaceTop.deactivateTurnOwnerMessage();
         this.refreshMechCodeStepMarker(1);
         this.refreshMechCodeStepMarker(2);
         this.initializeBattleReport();
         this._turn = 0;
         if(this._activatePlayer1Entry == false && this._activatePlayer2Entry == false)
         {
            this.activateNextBattlePhase("turn_start");
         }
      }
      
      public function screenVSIsClosed() : void
      {
         this.playLevelMusic();
         if(dataM.playingVSComputer)
         {
            if(screensM.screenBattleInterfaceBottom.mcTutorialArrow_interface.currentLabel == "animOn")
            {
               screensM.screenBattleInterfaceBottom.mcTutorialArrow_interface.gotoAndStop("animOff");
               screensM.screenBattleInterfaceBottom.mcTutorialArrow_interface.gotoAndStop("animOn");
            }
         }
         if(this._stompUnlocked_displayNow)
         {
            screensM.addScreen("screenPopUp");
            screensM.screenBattleInterfaceBottom.btn5.visible = false;
            screensM.screenBattleInterfaceBottom.mcTutorialArrow_interface.visible = false;
            screensM.screenPopUp.refreshScreen("stompUnlocked",0,0,null);
            this.setSocketAllowedStatus(true,"screenVSIsClosed");
         }
         else
         {
            this.activateNextBattlePhase("initiate_player2Entry");
         }
      }
      
      public function stompUnlockedPopUpClosed() : void
      {
         screensM.screenBattleInterfaceBottom.mcTutorialArrow_interface.visible = true;
      }
      
      private function allowPlayer1Entry() : void
      {
         this._activatePlayer1Entry = true;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:String = this.getMechSlot(dataM.player1PlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         _loc3_.mechView.visible = false;
      }
      
      private function allowPlayer2Entry() : void
      {
         var _loc2_:BMPlayerData = null;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc1_:Boolean = true;
         switch(dataM.battleSubType)
         {
            case "turret":
            case "jeep":
            case "tank":
               _loc1_ = false;
         }
         if(_loc1_)
         {
            this._activatePlayer2Entry = true;
            _loc2_ = dataM.playersData[dataM.player2PlayerID];
            _loc3_ = this.getMechSlot(dataM.player2PlayerID);
            _loc4_ = this._mechBattleDatas[_loc3_];
            _loc4_.mechView.visible = false;
         }
      }
      
      private function createPlayer1Entry() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:String = this.getMechSlot(dataM.player1PlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         _loc3_.mechView.visible = true;
         _loc3_.mechView.activateEntry1(true,this.player1EntryAnimationEnded);
      }
      
      private function createPlayer2Entry() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:Number = NaN;
         if(this._activatePlayer2Entry)
         {
            _loc1_ = dataM.playersData[dataM.player2PlayerID];
            _loc2_ = this.getMechSlot(dataM.player2PlayerID);
            _loc3_ = this._mechBattleDatas[_loc2_];
            _loc3_.mechView.visible = true;
            _loc4_ = Math.ceil(Math.random() * 3);
            switch(_loc4_)
            {
               case 1:
                  _loc3_.mechView.activateEntry1(true,this.player2EntryAnimationEnded);
                  break;
               case 2:
                  _loc3_.mechView.activateEntry2(true,this.player2EntryAnimationEnded);
                  break;
               case 3:
                  _loc3_.mechView.activateEntry3(this.player2EntryAnimationEnded);
                  break;
               case 4:
                  _loc3_.mechView.activateEntry4(this.player2EntryAnimationEnded);
            }
         }
         else
         {
            this.setSocketAllowedStatus(true,"createPlayer2Entry");
         }
      }
      
      private function player1EntryAnimationEnded() : void
      {
         this.activateNextBattlePhase("initiate_player2Entry");
      }
      
      private function player2EntryAnimationEnded() : void
      {
         var _loc1_:String = null;
         var _loc2_:BMMechBattleData = null;
         var _loc3_:BMMechView = null;
         this.setSocketAllowedStatus(true,"player2EntryAnimationEnded");
         switch(dataM.battleType)
         {
            case "challenge":
               switch(dataM.battleSubType)
               {
                  case "invisible":
                     _loc1_ = this.getMechSlot(dataM.player2PlayerID);
                     _loc2_ = this._mechBattleDatas[_loc1_];
                     _loc3_ = _loc2_.mechView;
                     _loc3_.alpha = 0;
                     this.createMechReflection(dataM.player2PlayerID,true);
               }
               break;
            case "mission":
               switch(dataM.battleSubType)
               {
                  case "boss":
                     this.activateTaunt(2,8);
               }
         }
         this.startNewTurn();
      }
      
      private function actionPerformed(param1:Boolean, param2:Boolean, param3:String = "") : void
      {
         var _loc4_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         if(_loc4_.AP == 0)
         {
            screensM.screenBattleInterfaceTop.disableTimer();
         }
         if(param1)
         {
            this.setSocketAllowedStatus(false,"actionPerformed >> delayNewAction");
            this._delayNewActionFrameCounter = 0;
            this._stopBattleViewAfterDelayNewAction = param2;
            this._delayNewActionHandler = true;
         }
         else
         {
            this.activateNextBattlePhase("turn_actionPerformedSub",{"caller":"actionPerformed"});
         }
      }
      
      private function delayNewActionHandler() : void
      {
         var _loc1_:Number = NaN;
         if(this._delayNewActionHandler)
         {
            ++this._delayNewActionFrameCounter;
            _loc1_ = this.DELAY_NEW_ACTION_FRAMES_DEFAULT;
            switch(this._lastAction)
            {
               case "fireWeapon":
               case "stomp":
                  if(this.getPlayerLostID() == 0)
                  {
                     _loc1_ = this.DELAY_NEW_ACTION_FRAMES_FIRE;
                  }
                  break;
               case "activateDrone":
                  _loc1_ = this.DELAY_NEW_ACTION_FRAMES_DRONE_ACTIVATED;
            }
            if(dataM.slowCPUMode)
            {
               _loc1_ = Math.ceil(_loc1_ / 2);
            }
            if(this._delayNewActionFrameCounter > _loc1_)
            {
               this.setSocketAllowedStatus(true,"delayNewActionHandler >> completed");
               this._delayNewActionHandler = false;
               this.activateNextBattlePhase("turn_actionPerformedSub",{"caller":"delayNewActionHandler"});
            }
         }
      }
      
      private function actionPerformedSub(param1:String = "") : void
      {
         var _loc7_:Boolean = false;
         var _loc8_:BMPlayerData = null;
         var _loc9_:String = null;
         var _loc10_:BMMechBattleData = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc4_:String = this.getMechSlot(this._currentPlayerID);
         var _loc5_:BMMechBattleData = this._mechBattleDatas[_loc4_];
         var _loc6_:Number = this.getPlayerLostID();
         if(_loc6_ > 0)
         {
            if(_loc6_ == dataM.player1PlayerID)
            {
               this._battleResult = "youLost";
               switch(dataM.battleType)
               {
                  case "mission":
                     dataM.mission_battleEnded = true;
                     dataM.mission_battleEnded_playerWon = false;
                     dataM.mission_battleEnded_hp = 0;
                     dataM.mission_battleEnded_bullets = 0;
                     dataM.mission_battleEnded_rockets = 0;
               }
            }
            else
            {
               switch(dataM.battleType)
               {
                  case "mission":
                     dataM.mission_battleEnded = true;
                     dataM.mission_battleEnded_playerWon = true;
                     dataM.mission_battleEnded_hp = _loc5_.HP;
                     dataM.mission_battleEnded_bullets = _loc5_.bullets;
                     dataM.mission_battleEnded_rockets = _loc5_.rockets;
               }
               this._battleResult = "youWon";
            }
            this.battleIsOver("actionPerformedSub");
         }
         else
         {
            _loc7_ = false;
            _loc8_ = dataM.playersData[this._opponentPlayerID];
            _loc9_ = this.getMechSlot(this._opponentPlayerID);
            _loc10_ = this._mechBattleDatas[_loc9_];
            if(_loc10_.HP <= 0)
            {
               _loc7_ = true;
            }
            if(_loc7_)
            {
               ++_loc3_.mechsDestroyed;
               if(_loc10_ != null)
               {
                  if(_loc10_.mechView != null)
                  {
                     if(_loc10_.drone != null)
                     {
                        _loc10_.drone.removeMe();
                        _loc10_.drone = null;
                     }
                     _loc10_.mechView.removeMe();
                     _loc10_.mechView = null;
                  }
               }
               _loc11_ = 0;
               if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
               {
                  _loc11_ = this._battleTurnData.get_selectedMechID(dataM.getInterfacePlayerID(this._opponentPlayerID));
               }
               else
               {
                  _loc12_ = 1;
                  while(_loc12_ <= dataM.battleMechsPerPlayer)
                  {
                     if(this._mechBattleDatas[this._opponentPlayerID + "_" + _loc12_].HP > 0)
                     {
                        _loc11_ = _loc12_;
                        _loc12_ = dataM.battleMechsPerPlayer;
                     }
                     _loc12_++;
                  }
                  this._battleTurnData.set_selectedMechID(dataM.getInterfacePlayerID(this._opponentPlayerID),_loc11_);
               }
               this.spawnMech(this._opponentPlayerID,_loc11_);
               screensM.screenBattleInterfaceTop.activateDestroyMechBadge(dataM.getInterfacePlayerID(this._currentPlayerID));
            }
            else
            {
               this.activateNextBattlePhase("turn_actionPerformedSubEnding");
            }
         }
      }
      
      private function actionPerformedSubEnding() : void
      {
         var _loc4_:Boolean = false;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         if(_loc1_.AP > 0)
         {
            this.activateNextBattlePhase("turn_startNewAction",{"caller":"actionPerformedSubEnding"});
         }
         else
         {
            _loc4_ = false;
            if(_loc3_.droneActive)
            {
               if(_loc3_.droneFired == false)
               {
                  if(this.canDroneFire())
                  {
                     _loc4_ = true;
                  }
               }
            }
            if(_loc4_)
            {
               switch(dataM.gameType)
               {
                  case BMDataManager.GAME_TYPE_REPLAY:
                     this.playReplayAction();
                     break;
                  default:
                     if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer)
                     {
                        this.setSocketAllowedStatus(true,"actionPerformedSub >> droneAttack");
                        _loc3_.droneFired = true;
                        this.fireLocally("drone",0);
                     }
                     else if(this._currentPlayerID == dataM.ONLINE_OPPONENT_ID)
                     {
                        screensM.screenDebugger.addTrace("### Waiting opponent\'s drone to fire");
                     }
               }
            }
            else
            {
               this.activateNextBattlePhase("action_energyRegenerationPhase");
            }
         }
      }
      
      private function startNewAction(param1:String) : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:Boolean = false;
         this.setSocketAllowedStatus(true,"startNewActionSub");
         var _loc2_:Boolean = false;
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_REPLAY:
               this.playReplayAction();
               break;
            default:
               _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc3_ = dataM.playersData[this._currentPlayerID];
            _loc4_ = this.getMechSlot(this._currentPlayerID);
            _loc5_ = this._mechBattleDatas[_loc4_];
            _loc6_ = false;
            if(_loc3_.AP == _loc3_.APMax && _loc5_.heat > _loc5_.heatMax)
            {
               if(_loc5_.heat - _loc5_.heatCooling > _loc5_.heatMax)
               {
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
                  {
                     screensM.screenDebugger.addTrace("### waiting for force shutdown for 2 AP");
                  }
                  else
                  {
                     this._forceShutDown = true;
                     if(_loc5_.droneActive)
                     {
                        _loc5_.droneFired = true;
                     }
                     this.shutDownLocally(_loc3_.AP);
                     if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                     {
                        if(this._currentPlayerID == dataM.player1PlayerID)
                        {
                           screensM.screenBattleInterfaceBottom.setShuttingDownAlertCountdownToMax();
                           screensM.screenBattleInterfaceBottom.activateActionErrorMessage("shuttingDown");
                        }
                     }
                  }
               }
               else if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
               {
                  screensM.screenDebugger.addTrace("### waiting for force shutdown for 1 AP");
               }
               else
               {
                  this.shutDownLocally(1);
               }
            }
            else if(_loc5_.mechView.shutDownActive)
            {
               this.setSocketAllowedStatus(false,"startNewAction >> shutDown active");
               this._setSocketAllowedStatusTrueInStartNewActionSub = true;
               _loc5_.mechView.deactivateShutdown(this.startNewActionSub);
            }
            else
            {
               this.activateNextBattlePhase("turn_startNewActionSub");
            }
         }
      }
      
      private function startNewActionSub() : void
      {
         if(this._setSocketAllowedStatusTrueInStartNewActionSub)
         {
            this.setSocketAllowedStatus(true,"startNewActionSub >> after shutDown");
            this._setSocketAllowedStatusTrueInStartNewActionSub = false;
         }
         if(this._currentPlayerID == dataM.player1PlayerID)
         {
            if(this._skipStartNewActionEnbaleInterface)
            {
               this._skipStartNewActionEnbaleInterface = false;
            }
            else
            {
               this.enableInterface("startNewActionSub");
            }
         }
         else
         {
            if(!(this._currentPlayerID == dataM.ONLINE_OPPONENT_ID && dataM.playingVSComputer == false))
            {
               this.computerM.executeTurn("startNewActionSub");
            }
            this.hideInterface("startNewActionSub");
         }
      }
      
      public function releaseFromError() : void
      {
         this.activateNextBattlePhase("turn_actionPerformed",{
            "delayNewAction":false,
            "stopBattleViewAfterDelayNewAction":false,
            "caller":"releaseFromError"
         });
      }
      
      public function getPlayerLostID() : Number
      {
         var _loc1_:Number = 0;
         if(this.getPlayerAliveMechSlot(dataM.player1PlayerID) == "")
         {
            _loc1_ = dataM.player1PlayerID;
         }
         else if(this.getPlayerAliveMechSlot(dataM.player2PlayerID) == "")
         {
            _loc1_ = dataM.player2PlayerID;
         }
         this._lastPlayerLostID = _loc1_;
         return _loc1_;
      }
      
      private function startNewTurn() : void
      {
         var _loc5_:BMPlayerProfile = null;
         ++this._turn;
         this.enableTopInterfaceButtons();
         if(dataM.battleType == "challenge")
         {
            if(dataM.battleSubType == "damage")
            {
               screensM.screenBattleInterfaceTop.refreshTurnsLeft(this.CHALLENGE_DAMAGE_TURNS - (this._turn - 1));
            }
         }
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         if(this._turn != 1)
         {
            _loc1_.AP = _loc1_.APMax;
         }
         screensM.screenBattleInterfaceTop.refreshAP(this._currentPlayerID);
         _loc3_.droneFired = false;
         _loc3_.resetAlreadyFired();
         this.refreshMechsDepth();
         if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            if(this._currentPlayerID == dataM.player1PlayerID)
            {
               screensM.screenBattleInterfaceBottom.showSpecificInterfaceType("menu");
            }
         }
         switch(this._currentPlayerID)
         {
            case dataM.ONLINE_PLAYER_ID:
            case dataM.ONLINE_OPPONENT_ID:
               if(dataM.playingVSComputer)
               {
                  this.resetBattleTurnDataLocally("startNewTurn");
                  this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,_loc1_.AP);
               }
               else
               {
                  if(this._turn == 1)
                  {
                     screensM.screenBattleInterfaceTop.stopAndResetDelayTimer();
                  }
                  screensM.screenBattleInterfaceTop.activateClock(this._turn);
               }
               break;
            case dataM.OFFLINE_PLAYER_ID:
            case dataM.OFFLINE_OPPONENT_ID:
               this.resetBattleTurnDataLocally("startNewTurn");
               this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,_loc1_.AP);
         }
         this.activateNextBattlePhase("turn_startNewAction",{"caller":"startNewTurn"});
         var _loc4_:String = "";
         if(dataM.playingVSComputer)
         {
            _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc5_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_LONE_BATTLE2)
            {
               if(this._currentPlayerID == dataM.player1PlayerID)
               {
                  _loc4_ = "myTurn";
               }
               else
               {
                  _loc4_ = "opponentTurn";
               }
            }
         }
         if(_loc4_ == "")
         {
            screensM.screenBattleInterfaceTop.deactivateTurnOwnerMessage();
         }
         else
         {
            screensM.screenBattleInterfaceTop.activateTurnOwnerMessage(_loc4_);
         }
      }
      
      private function refreshMechsDepth() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         if(this.holder_mechs.getChildIndex(_loc3_.mechView) < this.holder_mechs.getChildIndex(_loc6_.mechView))
         {
            this.holder_mechs.swapChildren(_loc3_.mechView,_loc6_.mechView);
         }
      }
      
      public function fireWeapon(param1:String, param2:Number) : void
      {
         this.disableInterface("fireWeapon");
         remoteM.battle_fireWeapon(param1,param2);
      }
      
      public function fireLocally(param1:String, param2:Number) : void
      {
         this.addSinglePlayerAction("fireSuccess",param2,param1);
      }
      
      private function fireLocallySub(param1:String, param2:Number) : void
      {
         this.fireLocallyCalculations(param1,param2,true);
         this.activateNextBattlePhase("action_fireSuccess",{
            "equipmentType":param1,
            "equipmentID":param2
         });
      }
      
      private function fireLocallyCalculations(param1:String, param2:Number, param3:Boolean) : void
      {
         var _loc11_:String = null;
         var _loc20_:BMPlayerItemData = null;
         var _loc21_:BMItemData = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Object = null;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Boolean = false;
         var _loc39_:BMPlayerItemData = null;
         var _loc40_:BMItemData = null;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc5_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc6_:String = this.getMechSlot(this._currentPlayerID);
         var _loc7_:BMMechBattleData = this._mechBattleDatas[_loc6_];
         if(param1 == "drone")
         {
            _loc20_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_.mechStructure.drone);
            _loc21_ = dataM.itemsDB[_loc20_.itemID];
            if(_loc21_.HPAddon > 0)
            {
               param3 = false;
            }
         }
         var _loc8_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc9_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc10_:BMMechBattleData = this._mechBattleDatas[_loc9_];
         switch(param1)
         {
            case "sideWeapon":
            case "topWeapon":
               _loc11_ = param1 + param2;
               break;
            default:
               _loc11_ = param1;
         }
         var _loc12_:Number = Number(_loc7_.mechStructure[_loc11_]);
         var _loc13_:BMPlayerItemData = dataM.getPlayerItemData(this._currentPlayerID,_loc12_);
         var _loc14_:BMItemData = dataM.itemsDB[_loc13_.itemID];
         var _loc15_:Number = 0;
         var _loc16_:Number = 0;
         var _loc17_:Number = 0;
         if(param3)
         {
            _loc22_ = _loc14_.damageBase;
            _loc23_ = _loc14_.damageAddon;
            if(_loc22_ + _loc23_ > 0)
            {
               _loc24_ = 0;
               switch(_loc14_.type)
               {
                  case "leg":
                  case "sideWeapon":
                  case "topWeapon":
                  case "drone":
                  case "harpoon":
                  case "teleport":
                  case "charge":
                     _loc24_ = 0;
               }
               _loc22_ += _loc24_;
               if(_loc23_ > 0)
               {
                  _loc23_ = Math.ceil(Math.random() * (_loc23_ + 1)) - 1;
               }
               if(this._currentPlayerID == dataM.player2PlayerID)
               {
                  switch(dataM.battleType)
                  {
                     case "challenge":
                        switch(dataM.battleSubType)
                        {
                           case "godMode":
                              switch(param1)
                              {
                                 case "sideWeapon":
                                    _loc22_ = this.GOD_MODE_WEAPON_DAMAGE_BASE + _loc4_.level * this.GOD_MODE_WEAPON_DAMAGE_PER_LEVEL;
                                    _loc23_ = 0;
                                    break;
                                 case "leg":
                                    _loc22_ = this.GOD_MODE_STOMP_DAMAGE_BASE + _loc4_.level * this.GOD_MODE_STOMP_DAMAGE_PER_LEVEL;
                                    _loc23_ = 0;
                              }
                        }
                        break;
                     case "mission":
                        switch(dataM.battleSubType)
                        {
                           case "jeep":
                              switch(param1)
                              {
                                 case "leg":
                                    _loc22_ = this.MISSION_JEEP_CRASH_DAMAGE_BASE + _loc4_.level * this.MISSION_JEEP_CRASH_DAMAGE_PER_LEVEL;
                                    _loc23_ = 0;
                              }
                              break;
                           case "tank":
                              switch(param1)
                              {
                                 case "leg":
                                    _loc22_ = this.MISSION_TANK_CRASH_DAMAGE_BASE + _loc4_.level * this.MISSION_TANK_CRASH_DAMAGE_PER_LEVEL;
                                    _loc23_ = 0;
                              }
                        }
                  }
               }
               _loc25_ = Number(_loc10_["resist" + _loc14_.damageType]);
               _loc26_ = _loc7_.generalDamageRatio;
               if(param1 == "leg")
               {
                  _loc26_ = _loc7_.stompDamageRatio;
               }
               _loc27_ = Math.ceil((_loc22_ + _loc23_) * _loc26_);
               _loc27_ = _loc27_ - _loc25_;
               if(dataM.clientRunningLocally)
               {
                  if(this._opponentPlayerID == dataM.player1PlayerID)
                  {
                     _loc27_ -= dataM.cheatWeaponResistance;
                  }
               }
               if(_loc27_ < 1)
               {
                  _loc27_ = 1;
               }
               if(dataM.clientRunningLocally)
               {
                  if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     if(this._currentPlayerID == dataM.player1PlayerID)
                     {
                        _loc27_ += dataM.cheatWeaponDamage;
                     }
                     else
                     {
                        _loc27_ += dataM.cheatWeaponDamageComputer;
                     }
                  }
               }
               _loc28_ = this.getShieldBlockInfo(this._opponentPlayerID,_loc27_,_loc14_.damageEnergy);
               _loc15_ = Number(_loc28_.energyUsed);
               _loc16_ = Number(_loc28_.heatUsed);
               _loc17_ = Number(_loc28_.damageFinal);
            }
         }
         this.resetBattleTurnDataLocally("fireLocallyCalculations");
         var _loc18_:Number = this._battleTurnData.get_energy(this._currentPlayerInterfacePlayerID) - _loc14_.costEnergy;
         var _loc19_:Number = this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID) + _loc14_.costHeat;
         this._battleTurnData.set_energy(this._currentPlayerInterfacePlayerID,_loc18_);
         this._battleTurnData.set_heat(this._currentPlayerInterfacePlayerID,_loc19_);
         this._battleTurnData.set_bullets(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_bullets(this._currentPlayerInterfacePlayerID) - _loc14_.bullets);
         this._battleTurnData.set_rockets(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_rockets(this._currentPlayerInterfacePlayerID) - _loc14_.rockets);
         if(_loc7_.shieldActive)
         {
            switch(_loc7_.shieldType)
            {
               case "energy":
                  if(_loc18_ <= 0)
                  {
                     this._battleTurnData.set_shieldActive(this._currentPlayerInterfacePlayerID,false);
                  }
                  break;
               case "heat":
                  if(_loc19_ > _loc7_.heatMax)
                  {
                     this._battleTurnData.set_shieldActive(this._currentPlayerInterfacePlayerID,false);
                  }
            }
         }
         switch(param1)
         {
            case "drone":
               break;
            default:
               this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         }
         if(dataM.gameType != BMDataManager.GAME_TYPE_ONLINE || dataM.playingVSComputer)
         {
            _loc29_ = this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID);
            if(dataM.clientRunningLocally)
            {
               _loc29_ += dataM.cheatExtraHeat;
            }
            this._battleTurnData.set_heat(this._currentPlayerInterfacePlayerID,_loc29_);
         }
         if(param3)
         {
            _loc30_ = this._battleTurnData.get_energy(this._opponentPlayerInterfacePlayerID);
            if(_loc14_.damageEnergy > _loc30_ - _loc15_)
            {
               _loc34_ = _loc14_.damageEnergy - (_loc30_ - _loc15_);
               _loc17_ += _loc34_;
               _loc31_ = _loc30_ - (_loc14_.damageEnergy - _loc34_) - _loc15_;
            }
            else
            {
               _loc31_ = _loc30_ - _loc14_.damageEnergy - _loc15_;
            }
            _loc32_ = this._battleTurnData.get_heat(this._opponentPlayerInterfacePlayerID) + _loc14_.damageHeat + _loc16_;
            if(dataM.isTutorialActive())
            {
               if(this._opponentPlayerID == dataM.player1PlayerID)
               {
                  _loc35_ = this._battleTurnData.get_HP(this._opponentPlayerInterfacePlayerID);
                  if(_loc17_ >= _loc35_)
                  {
                     _loc17_ = _loc35_ - 1;
                  }
               }
            }
            this.addBattleReportData(_loc12_,_loc17_);
            this._battleTurnData.set_HP(this._opponentPlayerInterfacePlayerID,this._battleTurnData.get_HP(this._opponentPlayerInterfacePlayerID,_loc8_.selectedMechID) - _loc17_);
            this._battleTurnData.set_energy(this._opponentPlayerInterfacePlayerID,_loc31_);
            this._battleTurnData.set_heat(this._opponentPlayerInterfacePlayerID,_loc32_);
            _loc33_ = this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID);
            if(_loc14_.push != 0)
            {
               if(_loc14_.push > 0)
               {
                  if(_loc7_.currentStepVisual > _loc10_.currentStepVisual)
                  {
                     _loc33_ -= _loc14_.push;
                     if(_loc33_ < 0)
                     {
                        _loc33_ = 0;
                     }
                  }
                  else
                  {
                     _loc33_ += _loc14_.push;
                     if(_loc33_ >= dataM.battleData.map.stepsTotal)
                     {
                        _loc33_ = dataM.battleData.map.stepsTotal - 1;
                     }
                  }
               }
               else
               {
                  _loc36_ = Math.abs(_loc7_.currentStepVisual - _loc10_.currentStepVisual) - 1;
                  _loc37_ = Math.abs(_loc14_.push);
                  if(_loc37_ > _loc36_)
                  {
                     _loc37_ = _loc36_;
                  }
                  if(_loc37_ > 0)
                  {
                     if(_loc7_.currentStepVisual > _loc10_.currentStepVisual)
                     {
                        _loc33_ += _loc37_;
                     }
                     else
                     {
                        _loc33_ -= _loc37_;
                     }
                  }
               }
            }
            this._battleTurnData.set_step(this._opponentPlayerInterfacePlayerID,_loc33_);
            _loc10_.currentStepCode = this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID);
            if(_loc22_ + _loc23_ > 0)
            {
               if(_loc10_.shieldActive)
               {
                  switch(_loc10_.shieldType)
                  {
                     case "energy":
                        _loc38_ = false;
                        if(_loc31_ <= 0)
                        {
                           _loc38_ = true;
                        }
                        else if(_loc17_ > 0)
                        {
                           _loc39_ = dataM.getPlayerItemData(this._opponentPlayerID,_loc10_.mechStructure.shield);
                           _loc40_ = dataM.itemsDB[_loc39_.itemID];
                           if(_loc31_ < _loc40_.energyPerBlock)
                           {
                              _loc38_ = true;
                           }
                        }
                        if(_loc38_)
                        {
                           this._battleTurnData.set_shieldActive(this._opponentPlayerInterfacePlayerID,false);
                        }
                        break;
                     case "heat":
                        if(_loc32_ > _loc10_.heatMax)
                        {
                           this._battleTurnData.set_shieldActive(this._opponentPlayerInterfacePlayerID,false);
                        }
                  }
               }
            }
         }
         if(_loc14_.resist1 > 0)
         {
            this._battleTurnData.set_resist1(this._opponentPlayerInterfacePlayerID,this._battleTurnData.get_resist1(this._opponentPlayerInterfacePlayerID) - _loc14_.resist1);
         }
         if(_loc14_.resist2 > 0)
         {
            this._battleTurnData.set_resist2(this._opponentPlayerInterfacePlayerID,this._battleTurnData.get_resist2(this._opponentPlayerInterfacePlayerID) - _loc14_.resist2);
         }
         if(_loc14_.resist3 > 0)
         {
            this._battleTurnData.set_resist3(this._opponentPlayerInterfacePlayerID,this._battleTurnData.get_resist3(this._opponentPlayerInterfacePlayerID) - _loc14_.resist3);
         }
         if(_loc14_.damageEnergyBase > 0)
         {
            _loc41_ = _loc10_.energyMax - _loc14_.damageEnergyBase;
            if(_loc41_ < 1)
            {
               _loc41_ = 1;
            }
            _loc10_.energyMax = _loc41_;
            if(this._battleTurnData.get_energy(this._opponentPlayerInterfacePlayerID) > _loc41_)
            {
               this._battleTurnData.set_energy(this._opponentPlayerInterfacePlayerID,_loc41_);
            }
         }
         if(_loc14_.damageEnergyAddon > 0)
         {
            _loc42_ = _loc10_.energyRegeneration - _loc14_.damageEnergyAddon;
            if(_loc42_ < 1)
            {
               _loc42_ = 1;
            }
            _loc10_.energyRegeneration = _loc42_;
         }
         if(_loc14_.damageHeatBase > 0)
         {
            _loc43_ = _loc10_.heatMax - _loc14_.damageHeatBase;
            if(_loc43_ < 1)
            {
               _loc43_ = 1;
            }
            _loc10_.heatMax = _loc43_;
         }
         if(_loc14_.damageHeatAddon > 0)
         {
            _loc44_ = _loc10_.heatCooling - _loc14_.damageHeatAddon;
            if(_loc44_ < 1)
            {
               _loc44_ = 1;
            }
            _loc10_.heatCooling = _loc44_;
         }
      }
      
      public function fireSuccess(param1:String, param2:Number) : void
      {
         var _loc9_:String = null;
         var _loc13_:Object = null;
         var _loc14_:MovieClip = null;
         var _loc19_:uint = 0;
         var _loc22_:MovieClip = null;
         var _loc23_:Point = null;
         var _loc24_:Point = null;
         var _loc25_:Point = null;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:String = null;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc45_:MovieClip = null;
         var _loc46_:Point = null;
         var _loc47_:Point = null;
         var _loc48_:Point = null;
         var _loc49_:MovieClip = null;
         var _loc50_:Point = null;
         var _loc51_:Point = null;
         var _loc52_:Point = null;
         var _loc53_:Number = NaN;
         var _loc54_:Number = NaN;
         var _loc55_:Number = NaN;
         var _loc56_:Boolean = false;
         var _loc57_:Number = NaN;
         var _loc58_:Boolean = false;
         var _loc59_:String = null;
         var _loc60_:uint = 0;
         var _loc61_:uint = 0;
         var _loc62_:String = null;
         var _loc63_:Boolean = false;
         var _loc64_:MovieClip = null;
         var _loc65_:Number = NaN;
         var _loc66_:Number = NaN;
         var _loc67_:Number = NaN;
         var _loc68_:Number = NaN;
         this.setSocketAllowedStatus(false,"fireSuccess");
         this._lastAction = "fireWeapon";
         this._lastWeaponEquipmentType = param1;
         this._lastWeaponEquipmentID = param2;
         var _loc3_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc4_:String = this.getMechSlot(this._currentPlayerID);
         var _loc5_:BMMechBattleData = this._mechBattleDatas[_loc4_];
         var _loc6_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc7_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc8_:BMMechBattleData = this._mechBattleDatas[_loc7_];
         switch(param1)
         {
            case "drone":
            case "leg":
               _loc9_ = param1;
               break;
            default:
               _loc9_ = param1 + param2;
         }
         var _loc10_:Number = Number(_loc5_.mechStructure[_loc9_]);
         var _loc11_:BMPlayerItemData = dataM.getPlayerItemData(this._currentPlayerID,_loc10_);
         var _loc12_:BMItemData = dataM.itemsDB[_loc11_.itemID];
         this._lastWeaponDamageType = _loc12_.damageType;
         _loc13_ = dataM.animationDB[_loc12_.animation];
         if(dataM.gameType == BMDataManager.GAME_TYPE_REPLAY || dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
         {
            if(_loc12_.damageEnergyBase > 0)
            {
               _loc41_ = _loc8_.energyMax - _loc12_.damageEnergyBase;
               if(_loc41_ < 1)
               {
                  _loc41_ = 1;
               }
               _loc8_.energyMax = _loc41_;
               if(this._battleTurnData.get_energy(this._opponentPlayerInterfacePlayerID) > _loc41_)
               {
                  this._battleTurnData.set_energy(this._opponentPlayerInterfacePlayerID,_loc41_);
               }
            }
            if(_loc12_.damageEnergyAddon > 0)
            {
               _loc42_ = _loc8_.energyRegeneration - _loc12_.damageEnergyAddon;
               if(_loc42_ < 1)
               {
                  _loc42_ = 1;
               }
               _loc8_.energyRegeneration = _loc42_;
            }
            if(_loc12_.damageHeatBase > 0)
            {
               _loc43_ = _loc8_.heatMax - _loc12_.damageHeatBase;
               if(_loc43_ < 1)
               {
                  _loc43_ = 1;
               }
               _loc8_.heatMax = _loc43_;
            }
            if(_loc12_.damageHeatAddon > 0)
            {
               _loc44_ = _loc8_.heatCooling - _loc12_.damageHeatAddon;
               if(_loc44_ < 1)
               {
                  _loc44_ = 1;
               }
               _loc8_.heatCooling = _loc44_;
            }
         }
         switch(param1)
         {
            case "sideWeapon":
            case "topWeapon":
               _loc5_.mechView.activateMachineGunBarrel(_loc9_);
               _loc5_.mechView.activateShotgunHandle(_loc9_);
               switch(_loc13_.effectType)
               {
                  case "grenade":
                  case "grenadePull":
                     _loc5_.mechView.activateGrenadeLauncher(_loc9_);
               }
         }
         var _loc15_:Boolean = this.canDroneFire();
         var _loc16_:Boolean = true;
         var _loc17_:Boolean = true;
         switch(param1)
         {
            case "leg":
               break;
            case "drone":
               _loc14_ = _loc5_.drone.droneGrpSub;
               _loc5_.drone.haltVerticalMotion(30);
               _loc5_.drone.addOnHoldFrames(_loc13_.droneOnHoldFrames);
               break;
            default:
               _loc14_ = _loc5_.mechView[_loc9_].item.itemGrp;
         }
         var _loc18_:Array = new Array();
         if(_loc14_ != null)
         {
            _loc19_ = 1;
            while(_loc19_ <= 10)
            {
               if(_loc14_["mcFire" + _loc19_] != null)
               {
                  _loc45_ = _loc14_["mcFire" + _loc19_];
                  _loc46_ = new Point(_loc45_.x,_loc45_.y);
                  _loc47_ = _loc14_.localToGlobal(_loc46_);
                  _loc48_ = this.holder_main.globalToLocal(_loc47_);
                  _loc18_.push(_loc48_);
               }
               _loc19_++;
            }
         }
         var _loc20_:Boolean = false;
         switch(param1)
         {
            case "drone":
               if(_loc5_.drone.droneGrp.scaleX == -1)
               {
                  _loc20_ = true;
               }
               break;
            default:
               if(_loc5_.mechView.scaleX == -1)
               {
                  _loc20_ = true;
               }
         }
         var _loc21_:Boolean = false;
         switch(_loc13_.effectType)
         {
            case "beam":
            case "stomp":
            case "sword":
            case "shield":
               break;
            case "immediate1":
            case "immediate2":
            case "projectile":
            case "grenade":
            case "grenadePull":
            case "chargeProjectile":
            case "rocket":
            case "rocketMassive":
            case "rocketStraight":
            case "artillery":
            case "artilleryDiagonal":
            case "flame":
            case "megaProjectile":
            case "orb":
            case "shockWave":
            case "wand":
               _loc22_ = _loc8_.mechView.torso;
               _loc23_ = new Point(_loc22_.x,_loc22_.y);
               _loc24_ = _loc22_.localToGlobal(_loc23_);
               _loc25_ = this.holder_main.globalToLocal(_loc24_);
               if(_loc13_.effectType != "immediate1" && _loc13_.effectType != "immediate2")
               {
                  _loc26_ = Math.abs(_loc18_[0].x - _loc25_.x);
                  _loc27_ = Math.abs(_loc18_[0].y - _loc25_.y);
                  if(_loc18_[0].y > _loc25_.y)
                  {
                     _loc27_ *= -1;
                  }
               }
         }
         var _loc40_:Boolean = true;
         if(_loc13_.bulletShellsInstant != "" || _loc13_.bulletShellsFrames != "")
         {
            if(_loc12_.type == "drone")
            {
               _loc49_ = _loc14_.mcCenter;
            }
            else
            {
               _loc49_ = _loc14_.mcTorso;
            }
            _loc50_ = new Point(_loc49_.x,_loc49_.y);
            _loc51_ = _loc14_.localToGlobal(_loc50_);
            _loc52_ = this.holder_main.globalToLocal(_loc51_);
            this._bulletShellsDirection = "left";
            if(_loc5_.currentStepCode > _loc8_.currentStepCode)
            {
               this._bulletShellsDirection = "right";
            }
            if(_loc13_.bulletShellsInstant != "")
            {
               _loc53_ = _loc18_.length;
               effectsM.createSparksMC("screenBattle",_loc13_.bulletShellsInstant,_loc52_.x,_loc52_.y,1,_loc53_,30,this._bulletShellsDirection,"",true);
            }
            else if(_loc13_.bulletShellsFrames != "")
            {
               this._bulletShellsHandler = true;
               this._bulletShellsCounter = _loc13_.getHitSoundsLength;
               if(dataM.slowCPUMode)
               {
                  this._bulletShellsCounter = Math.ceil(this._bulletShellsCounter / 2);
               }
               this._bulletShellsGrp = _loc13_.bulletShellsFrames;
               this._bulletShellsXPos = _loc52_.x;
               this._bulletShellsYPos = _loc52_.y;
            }
         }
         switch(_loc13_.effectType)
         {
            case "immediate1":
               if(_loc13_.fireEffect != "")
               {
                  _loc34_ = 0;
                  while(_loc34_ < _loc18_.length)
                  {
                     _loc35_ = 0;
                     _loc36_ = 0;
                     _loc37_ = 0;
                     _loc59_ = "";
                     if(dataM.slowCPUMode)
                     {
                        _loc59_ = "_fast";
                     }
                     _loc60_ = 1;
                     _loc61_ = 36;
                     switch(_loc13_.fireEffect)
                     {
                        case "machineGunFire2":
                           _loc60_ = 2;
                           _loc61_ = 38;
                           break;
                        case "machineGunFire3":
                           _loc60_ = 3;
                           _loc61_ = 38;
                     }
                     if(dataM.slowCPUMode)
                     {
                        _loc61_ *= 0.5;
                        _loc61_ = Math.ceil(_loc61_);
                     }
                     _loc62_ = "machineGunFire" + _loc60_;
                     effectsM.createMachineGunFire(this.holder_effects,_loc62_,_loc18_[_loc34_].x,_loc18_[_loc34_].y,_loc60_,_loc20_,_loc61_);
                     _loc34_++;
                  }
               }
               _loc21_ = true;
               soundM.createSound(_loc13_.sound,1);
               if(_loc13_.getHitSoundsLength > 0)
               {
                  this.activateGetHitSounds(_loc13_.getHitSoundsLength);
               }
               break;
            case "immediate2":
               if(_loc13_.fireEffect != "")
               {
                  _loc34_ = 0;
                  while(_loc34_ < _loc18_.length)
                  {
                     _loc35_ = 0;
                     _loc36_ = 0;
                     _loc37_ = 0;
                     effectsM.createFireEffect(_loc13_.fireEffect,_loc18_[_loc34_].x,_loc18_[_loc34_].y,_loc20_,0,this.holder_effects);
                     _loc34_++;
                  }
               }
               _loc21_ = true;
               this.activateWeaponFeedbackAndSound(this._currentPlayerID,"xAxis",_loc13_.sound);
               this.activateGetHit(this._opponentPlayerID,"xAxisFront",true,false);
               break;
            case "grenade":
            case "grenadePull":
               if(_loc13_.effectType == "grenadePull")
               {
                  _loc26_ += this.GRENADE_PULL_EXPLOSION_X_PUSH;
                  _loc28_ = _loc26_ / 42;
                  if(dataM.slowCPUMode)
                  {
                     _loc28_ = _loc26_ / 22;
                  }
               }
               else
               {
                  _loc28_ = _loc26_ / 32;
                  if(dataM.slowCPUMode)
                  {
                     _loc28_ = _loc26_ / 16;
                  }
               }
               _loc29_ = 0;
               _loc33_ = _loc13_.sound;
               _loc30_ = 6;
               effectsM.createProjectileShots(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc13_.projectile,_loc13_.fireEffect,_loc38_,_loc30_,_loc20_,_loc28_,_loc29_,_loc26_,_loc27_,_loc18_,_loc33_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
               break;
            case "beam":
               _loc34_ = _loc18_.length - 1;
               while(_loc34_ >= 0)
               {
                  _loc35_ = 0;
                  _loc36_ = 0;
                  _loc37_ = 0;
                  _loc63_ = false;
                  if(dataM.slowCPUMode)
                  {
                     _loc63_ = true;
                  }
                  if(_loc34_ == 0)
                  {
                     effectsM.createFireBeam(this.holder_effects,_loc13_.effectShape,_loc13_.effectColor,_loc13_.size,false,_loc63_,_loc20_,_loc18_[_loc34_].x,_loc18_[_loc34_].y,this.beamAttackEnded,this.createBeamAttackSound);
                  }
                  else
                  {
                     effectsM.createFireBeam(this.holder_effects,_loc13_.effectShape,_loc13_.effectColor,_loc13_.size,true,_loc63_,_loc20_,_loc18_[_loc34_].x,_loc18_[_loc34_].y,null,null);
                  }
                  _loc34_--;
               }
               this._beamAttackSound = _loc13_.sound;
               break;
            case "projectile":
            case "chargeProjectile":
               _loc38_ = 0;
               switch(_loc13_.effectType)
               {
                  case "chargeProjectile":
                     _loc64_ = externalAssetsM.getAsset("general","Grp_energyCharge_" + _loc13_.effectColor,140,140,false,false);
                     _loc65_ = 10;
                     _loc66_ = 20;
                     _loc67_ = 70;
                     _loc68_ = 7;
                     if(dataM.slowCPUMode)
                     {
                        _loc68_ = 10;
                        _loc67_ = 50;
                     }
                     effectsM.createEnergyChargeMC("screenBattle",this.holder_effects,_loc18_[0].x,_loc18_[0].y,_loc67_,_loc65_,_loc66_,_loc68_,_loc13_.effectColor,_loc64_,null);
                     _loc38_ = _loc66_ + Math.ceil(_loc67_ / _loc68_);
                     soundM.createSound("chargeEnergy",1);
                     break;
                  case "projectile":
               }
               _loc33_ = _loc13_.sound;
               _loc28_ = 80;
               _loc29_ = 0;
               _loc30_ = 6;
               if(dataM.slowCPUMode)
               {
                  _loc28_ = 120;
                  _loc30_ = 4;
               }
               effectsM.createProjectileShots(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc13_.projectile,_loc13_.fireEffect,_loc38_,_loc30_,_loc20_,_loc28_,_loc29_,_loc26_,_loc27_,_loc18_,_loc33_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
               break;
            case "megaProjectile":
               effectsM.createMegaProjectile(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc13_.projectile,_loc13_.fireEffect,_loc13_.tailEffect,_loc13_.sound,_loc20_,_loc26_,_loc27_,_loc18_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
               break;
            case "orb":
               _loc26_ += this.FLOOR_STEP_SIZE / 2;
               effectsM.createOrb(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc13_.projectile,_loc13_.fireEffect,_loc13_.tailEffect,_loc13_.effectColor,_loc13_.sound,_loc20_,_loc26_,_loc18_,this.activateWeaponFeedbackAndSound,null,this.attackEnded,[_loc17_]);
               break;
            case "shockWave":
               effectsM.createShockWave(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc13_.projectile,_loc13_.fireEffect,_loc13_.tailEffect,_loc13_.effectColor,_loc18_,_loc13_.sound,_loc20_,_loc26_,_loc27_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
               break;
            case "wand":
               _loc5_.mechView.activateWand(param2,null,false);
               break;
            case "repair":
               this._attackEnded_refreshBars = true;
               this._attackEnded_performAction = true;
               effectsM.createRepairBeam(_loc20_,_loc18_[0].x,_loc18_[0].y,this.holder_effects,this.attackEnded,[this.delayNewActionHandler]);
               soundM.createSound("droneRepair",1);
               break;
            case "rocket":
            case "rocketMassive":
            case "rocketStraight":
               _loc28_ = 1;
               _loc29_ = 3;
               _loc27_ -= 35;
               _loc30_ = 4;
               if(dataM.slowCPUMode)
               {
                  _loc28_ = 2;
                  _loc29_ = 6;
                  _loc30_ = 3;
               }
               if(_loc13_.effectType == "rocketMassive")
               {
                  _loc31_ = 1;
                  _loc32_ = 1;
               }
               else if(_loc12_.level <= 6)
               {
                  _loc31_ = 2;
                  _loc32_ = 2;
               }
               else if(_loc12_.level <= 14)
               {
                  _loc31_ = 3;
                  _loc32_ = 2;
               }
               else if(_loc12_.level <= 24)
               {
                  _loc31_ = 4;
                  _loc32_ = 2;
               }
               else
               {
                  _loc31_ = 3;
                  _loc32_ = 3;
               }
               _loc39_ = 10;
               if(_loc13_.effectType == "rocketStraight")
               {
                  _loc31_ = 3;
                  _loc32_ = 1;
                  _loc39_ = 0;
               }
               _loc33_ = _loc13_.sound;
               effectsM.createRocketBarrage(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc13_.rocket,_loc13_.fireEffect,_loc31_,_loc32_,_loc30_,_loc39_,_loc20_,_loc28_,_loc29_,_loc26_,_loc27_,_loc18_[0].x,_loc18_[0].y + 10,_loc33_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
               break;
            case "artillery":
            case "artilleryDiagonal":
               _loc54_ = 40;
               _loc30_ = 4;
               if(_loc12_.level <= 6)
               {
                  _loc31_ = 2;
                  _loc32_ = 2;
               }
               else if(_loc12_.level <= 14)
               {
                  _loc31_ = 3;
                  _loc32_ = 2;
               }
               else if(_loc12_.level <= 24)
               {
                  _loc31_ = 4;
                  _loc32_ = 2;
               }
               else
               {
                  _loc31_ = 3;
                  _loc32_ = 3;
               }
               if(dataM.slowCPUMode)
               {
                  _loc54_ = 80;
                  _loc30_ = 3;
               }
               _loc55_ = 12;
               _loc39_ = 0;
               _loc33_ = _loc13_.sound;
               _loc56_ = false;
               if(_loc13_.effectType == "artilleryDiagonal")
               {
                  _loc39_ = 12;
                  _loc56_ = true;
               }
               effectsM.createArtilleryBarrage(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc56_,_loc20_,_loc13_.rocket,_loc13_.fireEffect,_loc31_,_loc32_,_loc30_,_loc55_,_loc39_,_loc54_,_loc18_[0].x,_loc18_[0].y,_loc25_.x,_loc25_.y,_loc33_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
               break;
            case "flame":
               _loc57_ = this.FLOOR_STEP_SIZE;
               if(_loc12_.rangeAddon > 1)
               {
                  _loc57_ = 1.75 * this.FLOOR_STEP_SIZE;
               }
               effectsM.activateFlameThrower(this._opponentPlayerID,_loc18_[0].x,_loc18_[0].y,_loc5_.mechView.scaleX,_loc57_,_loc13_.fireEffect,this.activateGetHit,this.attackEnded,[_loc17_]);
               soundM.createSound("flameThrower",1);
               break;
            case "sword":
               _loc5_.mechView.activateSword(param2,this.swordAttackEnded,false);
               break;
            case "stomp":
               if(_loc12_.uses == 0)
               {
                  _loc40_ = false;
               }
               _loc5_.mechView.activateStomp(this.stompRegularAnimDone);
               _loc58_ = false;
               if(this._currentPlayerID == dataM.player2PlayerID)
               {
                  if(dataM.battleType == "challenge")
                  {
                     if(dataM.battleSubType == "godMode")
                     {
                        if(this._currentPlayerID == dataM.player2PlayerID)
                        {
                           _loc58_ = true;
                        }
                     }
                  }
               }
               if(_loc58_)
               {
                  soundM.createSound("horn" + Math.ceil(Math.random() * 2),1);
               }
         }
         this._takeDamage_effectType = _loc13_.effectType;
         this.setNewDataForAttacker();
         if(_loc40_)
         {
            this.setNewUsesForAttacker(param1,param2);
         }
         if(_loc21_)
         {
            this.attackEnded(_loc16_);
         }
      }
      
      private function beamAttackEnded() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc2_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
         this.createEarthQuake();
         this.attackEnded(true);
      }
      
      private function swordAttackEnded() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc2_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
         this.createEarthQuake();
         this.attackEnded(true);
      }
      
      private function createBeamAttackSound() : void
      {
         soundM.createSound(this._beamAttackSound,1);
      }
      
      private function setNewDataForAttacker() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc1_.selectedMechID = this._battleTurnData.get_selectedMechID(dataM.getInterfacePlayerID(this._currentPlayerID));
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         this._lastHPBeforeRepairDrone = _loc3_.HP;
         var _loc4_:uint = 1;
         while(_loc4_ <= dataM.battleMechsPerPlayer)
         {
            _loc3_ = this._mechBattleDatas[this._currentPlayerID + "_" + _loc4_];
            _loc3_.HP = this._battleTurnData.get_HP(this._currentPlayerInterfacePlayerID,_loc4_);
            _loc3_.energy = this._battleTurnData.get_energy(this._currentPlayerInterfacePlayerID,_loc4_);
            _loc3_.heat = this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID,_loc4_);
            _loc3_.bullets = this._battleTurnData.get_bullets(this._currentPlayerInterfacePlayerID,_loc4_);
            _loc3_.rockets = this._battleTurnData.get_rockets(this._currentPlayerInterfacePlayerID,_loc4_);
            _loc3_.resist1 = this._battleTurnData.get_resist1(this._currentPlayerInterfacePlayerID,_loc4_);
            _loc3_.resist2 = this._battleTurnData.get_resist2(this._currentPlayerInterfacePlayerID,_loc4_);
            _loc3_.resist3 = this._battleTurnData.get_resist3(this._currentPlayerInterfacePlayerID,_loc4_);
            if(_loc4_ != _loc1_.selectedMechID)
            {
               _loc3_.shieldActive = this._battleTurnData.get_shieldActive(this._currentPlayerInterfacePlayerID,_loc4_);
            }
            _loc4_++;
         }
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         this.checkForShieldAutoDeactivation(_loc3_,this._currentPlayerInterfacePlayerID);
         this.checkForShieldAutoActivation(_loc3_,this._currentPlayerInterfacePlayerID);
         _loc3_.shieldActive = this._battleTurnData.get_shieldActive(this._currentPlayerInterfacePlayerID,_loc1_.selectedMechID);
         this.setPlayerAP(this._currentPlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID));
         screensM.screenBattleInterfaceTop.refreshHP(this._currentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshHeat(this._currentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshEnergy(this._currentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshBullets(this._currentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshRockets(this._currentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshAP(this._currentPlayerID);
         screensM.screenBattleInterfaceTop.refreshResistance(this._currentPlayerID,1,true);
         screensM.screenBattleInterfaceTop.refreshResistance(this._currentPlayerID,2,true);
         screensM.screenBattleInterfaceTop.refreshResistance(this._currentPlayerID,3,true);
         if(_loc3_.HP / _loc3_.HPMax > this.MECH_LIMP_EFFECT_HP_RATIO)
         {
            _loc3_.mechView.deactivateLimping();
         }
         else
         {
            _loc3_.mechView.activateLimping();
         }
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(dataM.getInterfacePlayerID(this._currentPlayerID));
      }
      
      private function setNewUsesForAttacker(param1:*, param2:Number) : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItemData = null;
         var _loc10_:Object = null;
         var _loc11_:uint = 0;
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_REPLAY:
               break;
            default:
               _loc3_ = dataM.playersData[this._currentPlayerID];
               _loc4_ = this.getMechSlot(this._currentPlayerID);
               _loc5_ = this._mechBattleDatas[_loc4_];
               switch(param1)
               {
                  case "sideWeapon":
                  case "topWeapon":
                     _loc6_ = param1 + param2;
                     _loc5_.weaponAlreadyFired[_loc6_] = true;
                     break;
                  default:
                     _loc6_ = param1;
               }
               ++_loc5_.uses[_loc6_];
               if(param1 == "drone")
               {
                  _loc7_ = false;
                  if(dataM.playingVSComputer)
                  {
                     if(_loc5_.usesMax["drone"] > 0)
                     {
                        if(_loc5_.uses["drone"] >= _loc5_.usesMax["drone"])
                        {
                           _loc7_ = true;
                        }
                     }
                  }
                  else if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     if(this._battleTurnData.get_droneActive(dataM.getInterfacePlayerID(this._currentPlayerID)) == false)
                     {
                        _loc7_ = true;
                     }
                  }
                  if(_loc7_)
                  {
                     _loc8_ = dataM.getPlayerItemData(this._currentPlayerID,_loc5_.mechStructure.drone);
                     _loc9_ = dataM.itemsDB[_loc8_.itemID];
                     _loc10_ = dataM.animationDB[_loc9_.animation];
                     _loc11_ = this.DELAY_NEW_ACTION_FRAMES_FIRE;
                     if(_loc10_.effectType == "chargeProjectile")
                     {
                        _loc11_ += 40;
                     }
                     if(dataM.slowCPUMode)
                     {
                        _loc11_ = Math.ceil(_loc11_ / 2);
                     }
                     _loc5_.autoDeactivateDroneInXFrames(_loc11_);
                  }
               }
               if(this._currentPlayerID == dataM.player1PlayerID)
               {
                  screensM.screenBattleInterfaceBottom.refreshButtonsWithUses();
               }
         }
      }
      
      private function setNewDataForDefender(param1:Boolean = true) : void
      {
         var _loc3_:BMMechBattleData = null;
         var _loc6_:BMPlayerProfile = null;
         var _loc2_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         if(param1 == false)
         {
            _loc2_.selectedMechID = this._battleTurnData.get_selectedMechID(dataM.getInterfacePlayerID(this._opponentPlayerID));
         }
         var _loc4_:uint = 1;
         while(_loc4_ <= dataM.battleMechsPerPlayer)
         {
            _loc3_ = this._mechBattleDatas[this._opponentPlayerID + "_" + _loc4_];
            _loc3_.HP = this._battleTurnData.get_HP(this._opponentPlayerInterfacePlayerID,_loc4_);
            _loc3_.energy = this._battleTurnData.get_energy(this._opponentPlayerInterfacePlayerID,_loc4_);
            _loc3_.heat = this._battleTurnData.get_heat(this._opponentPlayerInterfacePlayerID,_loc4_);
            _loc3_.resist1 = this._battleTurnData.get_resist1(this._opponentPlayerInterfacePlayerID,_loc4_);
            _loc3_.resist2 = this._battleTurnData.get_resist2(this._opponentPlayerInterfacePlayerID,_loc4_);
            _loc3_.resist3 = this._battleTurnData.get_resist3(this._opponentPlayerInterfacePlayerID,_loc4_);
            if(_loc4_ != _loc2_.selectedMechID)
            {
               _loc3_.shieldActive = this._battleTurnData.get_shieldActive(this._opponentPlayerInterfacePlayerID,_loc4_);
            }
            _loc4_++;
         }
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc5_];
         this.checkForShieldAutoDeactivation(_loc3_,this._opponentPlayerInterfacePlayerID);
         this.checkForShieldAutoActivation(_loc3_,this._opponentPlayerInterfacePlayerID);
         _loc3_.shieldActive = this._battleTurnData.get_shieldActive(this._opponentPlayerInterfacePlayerID,_loc2_.selectedMechID);
         if(_loc3_.HP == 0 && dataM.player1PlayerID == this._opponentPlayerID)
         {
            _loc6_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(dataM.battleType == "mission")
            {
               if((dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer) && _loc6_.currentMissionSlot <= 1)
               {
                  _loc3_.HP = 1;
               }
            }
            else if((dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer) && _loc6_.winsVSComputer < dataM.TUTORIAL_BATTLES)
            {
               _loc3_.HP = 1;
            }
         }
         screensM.screenBattleInterfaceTop.refreshHP(this._opponentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshHeat(this._opponentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshEnergy(this._opponentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshResistance(this._opponentPlayerID,1,true);
         screensM.screenBattleInterfaceTop.refreshResistance(this._opponentPlayerID,2,true);
         screensM.screenBattleInterfaceTop.refreshResistance(this._opponentPlayerID,3,true);
         if(_loc3_.HP / _loc3_.HPMax > this.MECH_LIMP_EFFECT_HP_RATIO)
         {
            _loc3_.mechView.deactivateLimping();
         }
         else
         {
            _loc3_.mechView.activateLimping();
         }
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(dataM.getInterfacePlayerID(this._opponentPlayerID));
      }
      
      private function attackEnded(param1:Boolean) : void
      {
         this.setSocketAllowedStatus(true,"attackEnded");
         this._attackEnded_refreshBars = true;
         this._attackEnded_performAction = true;
         this.takeDamage("attackEnded",true,this._viewScaleFinal,true);
         this.attackEndedSub(param1,"attackEnded");
      }
      
      private function attackEndedSub(param1:Boolean, param2:String = "") : void
      {
         if(this._attackEnded_refreshBars)
         {
            screensM.screenBattleInterfaceTop.refreshOpponentBars(true);
         }
         if(this._attackEnded_performAction)
         {
            this.activateNextBattlePhase("turn_actionPerformed",{
               "delayNewAction":param1,
               "stopBattleViewAfterDelayNewAction":false,
               "caller":"attackEndedSub"
            });
         }
      }
      
      private function takeDamage(param1:String, param2:Boolean, param3:Number, param4:Boolean) : void
      {
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMItemData = null;
         var _loc15_:String = null;
         var _loc16_:* = undefined;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:BMMechView = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:MovieClip = null;
         var _loc25_:Point = null;
         var _loc26_:Point = null;
         var _loc27_:Point = null;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:String = null;
         var _loc34_:Object = null;
         var _loc35_:Boolean = false;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Boolean = false;
         var _loc39_:String = null;
         var _loc40_:String = null;
         var _loc41_:String = null;
         var _loc42_:BMPlayerItemData = null;
         var _loc43_:BMItemData = null;
         var _loc44_:Number = NaN;
         var _loc45_:* = undefined;
         var _loc46_:String = null;
         var _loc47_:Number = NaN;
         var _loc48_:Boolean = false;
         var _loc5_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc6_:String = this.getMechSlot(this._currentPlayerID);
         var _loc7_:BMMechBattleData = this._mechBattleDatas[_loc6_];
         var _loc8_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc9_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc10_:BMMechBattleData = this._mechBattleDatas[_loc9_];
         var _loc13_:Boolean = false;
         var _loc14_:uint = 0;
         if(this._lastWeaponEquipmentType == "drone")
         {
            _loc11_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_.mechStructure.drone);
            _loc12_ = dataM.itemsDB[_loc11_.itemID];
            _loc14_ = _loc12_.HPAddon;
            if(_loc14_ > 0)
            {
               _loc13_ = true;
            }
         }
         if(_loc13_)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.playingVSComputer)
            {
               if(_loc7_.HP + _loc14_ > _loc7_.HPMax)
               {
                  _loc14_ = _loc7_.HPMax - _loc7_.HP;
               }
               this._battleTurnData.set_HP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_HP(this._currentPlayerInterfacePlayerID) + _loc14_);
               _loc7_.HP = this._battleTurnData.get_HP(this._currentPlayerInterfacePlayerID);
            }
            else
            {
               _loc14_ = this._battleTurnData.get_HP(this._currentPlayerInterfacePlayerID) - this._lastHPBeforeRepairDrone;
            }
            if(_loc14_ > 0)
            {
               _loc15_ = "+" + _loc14_;
               _loc16_ = _loc7_.mechView.y + this.FLYING_NUMBER_Y_ADDON / param3;
               effectsM.createFlyingNumber(this.holder_effects,_loc7_.mechView.x,_loc16_,_loc15_,"red",0,param3,"up");
               screensM.screenBattleInterfaceTop.refreshHP(this._currentPlayerID,true);
            }
         }
         else
         {
            _loc17_ = _loc10_.HP - this._battleTurnData.get_HP(this._opponentPlayerInterfacePlayerID,_loc10_.mechID);
            _loc18_ = this._battleTurnData.get_heat(this._opponentPlayerInterfacePlayerID) - _loc10_.heat;
            _loc19_ = _loc10_.energy - this._battleTurnData.get_energy(this._opponentPlayerInterfacePlayerID);
            if(dataM.battleType == "challenge")
            {
               if(dataM.battleSubType == "damage")
               {
                  this._challengeDamageTotalDamage += _loc17_;
                  screensM.screenBattleInterfaceTop.refreshTotalDamage(this._challengeDamageTotalDamage);
               }
            }
            this._totalDamageInCurrentTurn += _loc17_;
            _loc20_ = 0;
            if(param2)
            {
               _loc20_ = Math.abs(_loc10_.currentStepVisual - this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID));
            }
            this.setNewDataForDefender();
            _loc21_ = _loc10_.mechView;
            _loc23_ = 0;
            if(_loc10_.shieldActive)
            {
               _loc38_ = false;
               _loc39_ = "front";
               if(this._takeDamage_effectType == "artillery")
               {
                  _loc39_ = "top";
               }
               else if(_loc21_.scaleX == -1)
               {
                  _loc38_ = true;
               }
               if(this._takeDamage_effectType == "orb" || this._takeDamage_effectType == "artilleryDiagonal")
               {
                  _loc39_ = "back";
               }
               switch(_loc10_.shieldType)
               {
                  case "energy":
                     _loc40_ = "blue";
                     break;
                  case "heat":
                     _loc40_ = "red";
               }
               effectsM.createShield(this.holder_effects,_loc21_.x,-10,_loc40_,_loc39_,_loc38_,dataM.slowCPUMode);
            }
            if(_loc17_ > 0)
            {
               _loc41_ = "-" + _loc17_;
               _loc22_ = _loc21_.y + this.FLYING_NUMBER_Y_ADDON / param3;
               effectsM.createFlyingNumber(this.holder_effects,_loc21_.x,_loc22_,_loc41_,"red",0,param3,"up");
            }
            _loc24_ = _loc10_.mechView.torso;
            _loc25_ = new Point(_loc24_.x,_loc24_.y);
            _loc26_ = _loc24_.localToGlobal(_loc25_);
            _loc27_ = this.holder_main.globalToLocal(_loc26_);
            _loc28_ = 1;
            _loc29_ = 0;
            if(_loc10_.shieldActive && _loc10_.mechStructure.shield > 0)
            {
               _loc42_ = dataM.getPlayerItemData(this._opponentPlayerID,_loc10_.mechStructure.shield);
               _loc43_ = dataM.itemsDB[_loc42_.itemID];
               _loc29_ = _loc43_.absorbRatio / 100;
               _loc28_ -= _loc29_;
            }
            _loc30_ = Math.ceil(this.SPARKS_PER_FRAME * _loc28_);
            _loc31_ = Math.ceil(10 * _loc29_);
            _loc32_ = Math.ceil(14 * _loc28_);
            if(_loc29_ > 0)
            {
               _loc44_ = _loc27_.x + 150 * _loc21_.scaleX;
               _loc45_ = "right";
               if(_loc21_.scaleX == -1)
               {
                  _loc45_ = "left";
               }
               switch(_loc10_.shieldType)
               {
                  case "energy":
                     _loc46_ = "blue";
                     break;
                  case "heat":
                     _loc46_ = "red";
               }
               effectsM.createSparksMC("screenBattle","spark",_loc44_,_loc27_.y,_loc31_,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,_loc45_,_loc46_,true);
            }
            _loc33_ = "orange";
            _loc35_ = false;
            _loc36_ = 0;
            switch(this._lastWeaponEquipmentType)
            {
               case "sideWeapon":
               case "topWeapon":
                  _loc11_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_.mechStructure[this._lastWeaponEquipmentType + this._lastWeaponEquipmentID]);
                  _loc12_ = dataM.itemsDB[_loc11_.itemID];
                  _loc34_ = dataM.animationDB[_loc12_.animation];
                  if(_loc12_.push < 0)
                  {
                     _loc20_ *= -1;
                  }
                  _loc33_ = _loc34_.effectColor;
                  switch(_loc34_.effectType)
                  {
                     case "grenade":
                     case "rocketMassive":
                        _loc35_ = true;
                        break;
                     case "grenadePull":
                        _loc35_ = true;
                        if(_loc7_.currentStepVisual < _loc10_.currentStepVisual)
                        {
                           _loc36_ = this.GRENADE_PULL_EXPLOSION_X_PUSH;
                        }
                        else
                        {
                           _loc36_ = -this.GRENADE_PULL_EXPLOSION_X_PUSH;
                        }
                  }
                  break;
               case "drone":
                  _loc11_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_.mechStructure[this._lastWeaponEquipmentType]);
                  _loc12_ = dataM.itemsDB[_loc11_.itemID];
                  if(_loc12_.push < 0)
                  {
                     _loc20_ *= -1;
                  }
                  _loc33_ = dataM.animationDB[_loc12_.animation].effectColor;
                  break;
               case "teleport":
                  _loc33_ = "blue";
                  break;
               case "charge":
                  _loc33_ = "orange";
                  break;
               case "harpoon":
                  _loc33_ = "orange";
                  break;
               case "stomp":
                  _loc11_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_.mechStructure.leg);
                  _loc12_ = dataM.itemsDB[_loc11_.itemID];
                  _loc33_ = dataM.animationDB[_loc12_.animation].effectColor;
            }
            _loc37_ = 0;
            effectsM.createSparksMC("screenBattle","debrie",_loc27_.x,_loc27_.y,_loc32_,1,40,"horizontal","",true);
            if(_loc35_)
            {
               _loc47_ = _loc27_.x + _loc36_;
               effectsM.createMegaExplosion(this.holder_effects,_loc47_,_loc27_.y - 100);
               this.createEarthQuake();
            }
            else
            {
               effectsM.createExplosion(3,_loc27_.x,_loc27_.y,50,30,20,2,7,2,this.holder_effects);
            }
            effectsM.createSparksMC("screenBattle","spark",_loc27_.x,_loc27_.y,_loc30_,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontal",_loc33_,true);
            if(_loc20_ != 0)
            {
               if(this.canPushPlayerID(this._opponentPlayerID))
               {
                  this.pushMech(this._currentPlayerID,this._opponentPlayerID,_loc20_,true,-1,-1,param4);
               }
            }
            this.refreshFloorBuffEffects("takeDamage");
            if(_loc10_.HP <= 0)
            {
               screensM.screenBattleInterfaceTop.deactivateTurnOwnerMessage();
               _loc48_ = false;
               if(dataM.battleMechsPerPlayer > 1)
               {
                  if(this.getPlayerAliveMechSlot(this._opponentPlayerID) != "")
                  {
                     _loc48_ = true;
                  }
               }
               if(_loc48_ == false && dataM.playingVSComputer == false)
               {
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     screensM.screenBattleInterfaceTop.btnEmotesOpen.visible = false;
                     screensM.screenBattleInterfaceTop.btnEmotesClose.visible = false;
                     screensM.screenBattleInterfaceEmotes.closeMe();
                  }
                  else if(dataM.gameType == BMDataManager.GAME_TYPE_REPLAY)
                  {
                     screensM.screenBattleInterfaceTop.btnPauseReplay.visible = false;
                  }
               }
               if(this._allowFinishMoves && this._currentPlayerID == dataM.player1PlayerID && _loc48_ == false)
               {
                  screensM.screenBattleInterfaceTop.disableTimer();
                  _loc21_.activateDefeated();
                  this._waitingForFinishMove = true;
                  this._attackEnded_performAction = false;
                  screensM.screenBattleInterfaceTop.mcFinishMove.gotoAndPlay("animOn");
                  screensM.screenBattleInterfaceTop.btnQuit.disableMe();
                  this.activateFinishBackgroundDarkness();
                  this.disableInterface("takeDamage - starting finish move");
                  this.hideInterface("takeDamage - starting finish move");
               }
               else
               {
                  this.destroyDefendingMech(1,_loc37_);
               }
            }
         }
      }
      
      private function getPlayerAliveMechSlot(param1:uint) : String
      {
         var _loc3_:BMMechBattleData = null;
         var _loc2_:String = "";
         for each(_loc3_ in this._mechBattleDatas)
         {
            if(_loc2_ == "")
            {
               if(_loc3_.playerID == param1)
               {
                  if(_loc3_.HP > 0)
                  {
                     _loc2_ = param1 + "_" + _loc3_.mechID;
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function isWaitingForFinishMove() : Boolean
      {
         return this._waitingForFinishMove;
      }
      
      private function destroyDefendingMech(param1:Number, param2:Number) : void
      {
         var _loc3_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc4_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc5_:BMMechBattleData = this._mechBattleDatas[_loc4_];
         _loc5_.destroyMech(param1,param2,this.mechDestroyedAnimationDone);
         screensM.screenBattleInterfaceTop.refreshHP(this._opponentPlayerID,true);
         this._attackEnded_performAction = false;
         this._attackEnded_refreshBars = false;
         if(this.getPlayerLostID() > 0 && dataM.clientRunningLocally == false)
         {
            screensM.screenBattleInterfaceTop.btnQuit.disableMe();
         }
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(dataM.getInterfacePlayerID(this._opponentPlayerID));
      }
      
      private function mechDestroyedAnimationDone(param1:Number) : void
      {
         this._waitingForMechToBeDestroyed = false;
         this._attackEnded_refreshBars = true;
         this._attackEnded_performAction = true;
         this.attackEndedSub(true,"mechDestroyedAnimationDone");
      }
      
      private function getShieldBlockInfo(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMItemData = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:String = null;
         var _loc17_:Number = NaN;
         var _loc4_:BMPlayerData = dataM.playersData[param1];
         var _loc5_:String = this.getMechSlot(param1);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         var _loc7_:Number = param2;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         if(_loc6_.shieldActive)
         {
            _loc11_ = dataM.getPlayerItemData(param1,_loc6_.mechStructure.shield);
            _loc12_ = dataM.itemsDB[_loc11_.itemID];
            _loc13_ = Math.floor(param2 * _loc12_.absorbRatio / 100);
            _loc14_ = Math.ceil(_loc13_ / _loc12_.HPPerBlock);
            _loc15_ = _loc6_.energy - param3;
            if(_loc15_ < 0)
            {
               _loc15_ = 0;
            }
            _loc16_ = "energy";
            if(_loc12_.heatPerBlock > 0)
            {
               _loc16_ = "heat";
            }
            _loc17_ = _loc14_;
            switch(_loc16_)
            {
               case "energy":
                  _loc17_ = Math.floor(_loc15_ / _loc12_.energyPerBlock);
                  if(_loc17_ > _loc14_)
                  {
                     _loc17_ = _loc14_;
                  }
                  break;
               case "heat":
            }
            if(_loc17_ > 0)
            {
               _loc9_ = _loc17_ * _loc12_.energyPerBlock;
               _loc10_ = _loc17_ * _loc12_.heatPerBlock;
               _loc8_ = _loc17_ * _loc12_.HPPerBlock;
               if(_loc8_ > _loc13_)
               {
                  _loc8_ = _loc13_;
               }
               _loc7_ -= _loc8_;
            }
         }
         return {
            "damageBlocked":_loc8_,
            "damageFinal":_loc7_,
            "energyUsed":_loc9_,
            "heatUsed":_loc10_
         };
      }
      
      private function pushMech(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Number, param6:Number, param7:Boolean) : void
      {
         var _loc14_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc8_:BMPlayerData = dataM.playersData[param1];
         var _loc9_:String = this.getMechSlot(param1);
         var _loc10_:BMMechBattleData = this._mechBattleDatas[_loc9_];
         var _loc11_:BMPlayerData = dataM.playersData[param2];
         var _loc12_:String = this.getMechSlot(param2);
         var _loc13_:BMMechBattleData = this._mechBattleDatas[_loc12_];
         var _loc15_:Number = _loc13_.currentStepVisual;
         var _loc16_:Number = _loc10_.currentStepVisual;
         if(param4 == false)
         {
            _loc15_ = param5;
            _loc16_ = param6;
         }
         if(_loc15_ < _loc16_)
         {
            _loc17_ = -1;
         }
         else if(_loc15_ > _loc16_)
         {
            _loc17_ = 1;
         }
         else if(_loc16_ == 0)
         {
            _loc17_ = 1;
         }
         else
         {
            _loc17_ = -1;
         }
         if(param3 < 0)
         {
            _loc17_ *= -1;
         }
         var _loc18_:Number = 0;
         var _loc19_:Boolean = false;
         if(param3 > 0)
         {
            _loc20_ = _loc15_ + _loc17_ * Math.abs(param3);
            _loc21_ = this.getAvailableStep(param2,_loc15_,_loc20_,"walk");
            if(_loc21_ > -1)
            {
               _loc18_ = Math.abs(_loc21_ - _loc15_);
            }
         }
         else
         {
            _loc19_ = true;
            _loc22_ = Math.abs(_loc16_ - _loc15_) - 1;
            _loc18_ = Math.abs(param3);
            if(_loc18_ > _loc22_)
            {
               _loc18_ = _loc22_;
            }
         }
         if(_loc18_ > 0)
         {
            _loc23_ = _loc18_ * this.FLOOR_STEP_SIZE;
            _loc13_.pushMe(_loc23_,_loc19_,this.pushAnimEnded,param7);
            if(param4)
            {
               _loc13_.currentStepVisual += _loc18_ * _loc17_;
            }
            if(param7)
            {
               this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES_PUSH;
               this.refreshMechCodeStepMarker(1);
               this.refreshMechCodeStepMarker(2);
            }
            _loc13_.mechView.activateGetPushedAnimation(_loc19_);
         }
      }
      
      private function pushAnimEnded(param1:Boolean) : void
      {
         if(param1)
         {
            this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
            this.refreshMechCodeStepMarker(1);
            this.refreshMechCodeStepMarker(2);
         }
         if(this._pushAnimEndedActionPerformed)
         {
            this.activateNextBattlePhase("turn_actionPerformed",{
               "delayNewAction":true,
               "stopBattleViewAfterDelayNewAction":true,
               "caller":"pushAnimEnded"
            });
            this._pushAnimEndedActionPerformed = false;
         }
      }
      
      public function activateZoomOutForTeleport() : void
      {
         if(this._zoomOut == false)
         {
            this.zoomClicked();
            this._zoomOutForTeleport = true;
         }
      }
      
      public function teleportLocationClicked(param1:Number) : void
      {
         var _loc2_:Number = dataM.getClientInvertedStep(param1);
         this.disableInterface("teleportLocationClicked");
         if(dataM.playingVSComputer)
         {
            this._skipNexySocketCallsHandlerEnbaleInterface = true;
         }
         remoteM.battle_teleport(_loc2_);
      }
      
      public function teleportLocally(param1:Number) : void
      {
         this.addSinglePlayerAction("teleport",param1,"");
      }
      
      private function teleportLocallySub(param1:Number) : void
      {
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc3_:String = this.getMechSlot(this._currentPlayerID);
         var _loc4_:BMMechBattleData = this._mechBattleDatas[_loc3_];
         var _loc5_:BMPlayerItemData = dataM.getPlayerItemData(this._currentPlayerID,_loc4_.mechStructure.teleport);
         var _loc6_:BMItemData = dataM.itemsDB[_loc5_.itemID];
         var _loc7_:Boolean = this.isOpponentInWeaponRange(this._currentPlayerID,this._opponentPlayerID,_loc6_.itemID,-1,-1,param1);
         if(_loc7_)
         {
            this.fireLocallyCalculations("teleport",0,true);
         }
         else
         {
            this.fireLocallyCalculations("teleport",0,false);
         }
         this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,param1);
         _loc4_.currentStepCode = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         screensM.screenBattle.activateNextBattlePhase("action_teleportSuccess",{"targetStep":param1});
      }
      
      public function teleportSuccess(param1:Number) : void
      {
         this.setSocketAllowedStatus(false,"teleportSuccess");
         this._lastAction = "teleport";
         var _loc2_:Number = dataM.getClientInvertedStep(param1);
         var _loc3_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc4_:String = this.getMechSlot(this._currentPlayerID);
         var _loc5_:BMMechBattleData = this._mechBattleDatas[_loc4_];
         var _loc6_:BMMechView = _loc5_.mechView;
         var _loc7_:Number = _loc6_.mechSizer.width * 1.8;
         if(_loc7_ > 400)
         {
            _loc7_ = 400;
         }
         var _loc8_:Number = _loc6_.x;
         var _loc9_:Number = _loc6_.y + 30;
         this._teleportAfterEffectXPos = _loc8_;
         this._teleportAfterEffectYPos = _loc9_;
         this.setNewDataForAttacker();
         this.setNewUsesForAttacker("teleport",0);
         var _loc10_:String = "";
         if(dataM.slowCPUMode)
         {
            _loc10_ = "_fast";
         }
         effectsM.createTeleportDisappear("teleportDisappearAnim",_loc8_,_loc9_,_loc7_,this.teleportSuccessSub,[_loc2_],this.holder_effects);
         soundM.createSound("teleportDisappear",1);
      }
      
      private function teleportSuccessSub(param1:Number) : void
      {
         var _loc12_:Number = NaN;
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc3_:String = this.getMechSlot(this._currentPlayerID);
         var _loc4_:BMMechBattleData = this._mechBattleDatas[_loc3_];
         var _loc5_:BMMechView = _loc4_.mechView;
         var _loc6_:Number = _loc5_.mechSizer.width * 1.8;
         if(_loc6_ > 400)
         {
            _loc6_ = 400;
         }
         _loc4_.currentStepVisual = param1;
         _loc4_.currentStepCode = _loc4_.currentStepVisual;
         _loc4_.mechView.x = (_loc4_.currentStepVisual + 0.5) * this.FLOOR_STEP_SIZE;
         this.refreshFloorBuffEffects("teleportSuccessSub");
         var _loc7_:Number = _loc5_.x;
         var _loc8_:Number = _loc5_.y + 30;
         var _loc9_:String = "";
         if(dataM.slowCPUMode)
         {
            _loc9_ = "_fast";
         }
         effectsM.createTeleportReappear("teleportReappearAnim",_loc7_,_loc8_,_loc6_,this.holder_effects);
         this.refreshMechsView();
         var _loc10_:BMPlayerItemData = dataM.getPlayerItemData(this._currentPlayerID,_loc4_.mechStructure.teleport);
         var _loc11_:BMItemData = dataM.itemsDB[_loc10_.itemID];
         if(_loc11_.damageBase > 0 || _loc11_.damageAddon > 0)
         {
            effectsM.createSparksMC("screenBattle","spark",_loc5_.x,_loc5_.y,this.SPARKS_PER_FRAME,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontalWider","blue",true);
         }
         this._teleportDamageHandler = true;
         if(this._zoomOutForTeleport)
         {
            this.zoomClicked();
         }
         else
         {
            this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
            this.refreshMechCodeStepMarker(1);
            this.refreshMechCodeStepMarker(2);
         }
         if(dataM.runAsMobile == false)
         {
            this._teleportAfterEffectCountdown = 120;
            _loc12_ = Math.random() * 360;
            effectsM.createTeleportAfterEffect("teleportAfterEffect",this._teleportAfterEffectXPos,this._teleportAfterEffectYPos,dataM.slowCPUMode,this.holder_effects);
         }
         soundM.createSound("teleportAppear",1);
      }
      
      public function teleportCanceled() : void
      {
         if(this._zoomOutForTeleport)
         {
            this.zoomClicked();
         }
      }
      
      private function teleportDamageHandler() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         var _loc6_:BMPlayerData = null;
         var _loc7_:String = null;
         var _loc8_:BMMechBattleData = null;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         var _loc12_:BMMechView = null;
         if(this._teleportDamageHandler)
         {
            _loc1_ = dataM.playersData[this._currentPlayerID];
            _loc2_ = this.getMechSlot(this._currentPlayerID);
            _loc3_ = this._mechBattleDatas[_loc2_];
            _loc4_ = dataM.getPlayerItemData(this._currentPlayerID,_loc3_.mechStructure.teleport);
            _loc5_ = dataM.itemsDB[_loc4_.itemID];
            _loc6_ = dataM.playersData[this._opponentPlayerID];
            _loc7_ = this.getMechSlot(this._opponentPlayerID);
            _loc8_ = this._mechBattleDatas[_loc7_];
            _loc9_ = false;
            if(_loc3_.currentStepVisual > _loc8_.currentStepVisual)
            {
               if(_loc3_.currentStepVisual - _loc8_.currentStepVisual <= _loc5_.rangeAddon)
               {
                  _loc9_ = true;
               }
            }
            else if(_loc8_.currentStepVisual - _loc3_.currentStepVisual <= _loc5_.rangeAddon)
            {
               _loc9_ = true;
            }
            _loc10_ = true;
            if(_loc9_)
            {
               _loc11_ = this._viewScale;
               if(this._zoomOut)
               {
                  _loc11_ = this._viewScaleFinal;
               }
               this._lastWeaponEquipmentType = "teleport";
               this.takeDamage("teleportDamageHandler",true,_loc11_,false);
               _loc12_ = _loc3_.mechView;
               effectsM.createStompFire(this.holder_effects,"teleportFire1",_loc12_.x,0,60,6,1,false);
               effectsM.createStompFire(this.holder_effects,"teleportFire1",_loc12_.x,0,60,6,1,true);
               this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
               screensM.screenBattleInterfaceTop.refreshOpponentBars(true);
               if(_loc8_.HP <= 0)
               {
                  _loc10_ = false;
               }
            }
            if(_loc10_)
            {
               this.activateNextBattlePhase("turn_actionPerformed",{
                  "delayNewAction":true,
                  "stopBattleViewAfterDelayNewAction":true,
                  "caller":"teleportSuccessSub"
               });
            }
            this._teleportDamageHandler = false;
         }
      }
      
      public function chargeClicked() : void
      {
         this.disableInterface("charge");
         remoteM.battle_charge();
      }
      
      public function chargeLocally() : void
      {
         this.addSinglePlayerAction("charge",0,"");
      }
      
      private function chargeLocallySub() : void
      {
         this.fireLocallyCalculations("charge",0,true);
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         if(_loc3_.currentStepVisual > _loc6_.currentStepVisual)
         {
            this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,_loc6_.currentStepVisual + this.CHARGE_SELF_PUSH);
         }
         else
         {
            this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,_loc6_.currentStepVisual - this.CHARGE_SELF_PUSH);
         }
         _loc3_.currentStepCode = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         this.activateNextBattlePhase("action_chargeSuccess");
      }
      
      public function chargeSuccess() : void
      {
         this.setSocketAllowedStatus(false,"chargeSuccess");
         this._lastAction = "charge";
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         var _loc7_:Number = _loc6_.mechView.x;
         _loc3_.charge(_loc7_,this.chargeChargingAnimationEnded);
         this.setNewDataForAttacker();
         this.setNewUsesForAttacker("charge",0);
         soundM.createSound("charge",1);
      }
      
      private function chargeChargingAnimationEnded() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         var _loc7_:MovieClip = _loc3_.mechView.torso;
         var _loc8_:Point = new Point(_loc7_.x,_loc7_.y);
         var _loc9_:Point = _loc7_.localToGlobal(_loc8_);
         var _loc10_:Point = this.holder_main.globalToLocal(_loc9_);
         effectsM.createSparksMC("screenBattle","debrie",_loc3_.mechView.x,_loc10_.y,14,1,40,"horizontal","",true);
         effectsM.createExplosion(3,_loc3_.mechView.x,_loc10_.y,50,30,20,2,7,2,this.holder_effects);
         effectsM.createSparksMC("screenBattle","spark",_loc3_.mechView.x,_loc10_.y,this.SPARKS_PER_FRAME,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontal","orange",true);
         this._lastWeaponEquipmentType = "charge";
         this.takeDamage("chargeChargingAnimationEnded",true,this._viewScaleFinal,false);
         this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
         this.createEarthQuake();
         _loc3_.currentStepVisual = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         _loc3_.currentStepCode = _loc3_.currentStepVisual;
         this.refreshFloorBuffEffects("chargeChargingAnimationEnded");
         var _loc11_:Number = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         var _loc12_:Number = this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID);
         var _loc13_:Number = _loc11_;
         var _loc14_:Number = _loc12_;
         if(_loc11_ > _loc12_)
         {
            _loc13_--;
         }
         else if(_loc11_ < _loc12_)
         {
            _loc13_ += 1;
         }
         else if(_loc12_ == 0)
         {
            _loc13_--;
         }
         else
         {
            _loc13_ += 1;
         }
         this.pushMech(this._opponentPlayerID,this._currentPlayerID,this.CHARGE_SELF_PUSH,false,_loc13_,_loc14_,true);
         screensM.screenBattleInterfaceTop.refreshOpponentBars(true);
         if(_loc6_.HP > 0)
         {
            this._pushAnimEndedActionPerformed = true;
         }
      }
      
      private function canPushPlayerID(param1:*) : Boolean
      {
         var _loc2_:Boolean = true;
         if(dataM.battleType == "mission")
         {
            if(dataM.battleSubType == "turret")
            {
               if(param1 == dataM.player2PlayerID)
               {
                  _loc2_ = false;
               }
            }
         }
         return _loc2_;
      }
      
      public function crashLocally() : void
      {
         this.addSinglePlayerAction("crash",0,"");
      }
      
      private function crashLocallySub() : void
      {
         this.fireLocallyCalculations("leg",0,true);
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         if(_loc3_.currentStepVisual > _loc6_.currentStepVisual)
         {
            this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,_loc6_.currentStepVisual + this.CHARGE_SELF_PUSH);
         }
         else
         {
            this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,_loc6_.currentStepVisual - this.CHARGE_SELF_PUSH);
         }
         _loc3_.currentStepCode = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         this.crashSuccess();
      }
      
      public function crashSuccess() : void
      {
         this.setSocketAllowedStatus(false,"crashSuccess");
         this._lastAction = "crash";
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         var _loc7_:Number = _loc6_.mechView.x;
         _loc3_.crash(_loc7_,this.crashCrashingAnimationEnded);
         this.setNewDataForAttacker();
         this.setNewUsesForAttacker("leg",0);
      }
      
      private function crashCrashingAnimationEnded() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         var _loc7_:MovieClip = _loc3_.mechView.torso;
         var _loc8_:Point = new Point(_loc7_.x,_loc7_.y);
         var _loc9_:Point = _loc7_.localToGlobal(_loc8_);
         var _loc10_:Point = this.holder_main.globalToLocal(_loc9_);
         effectsM.createSparksMC("screenBattle","debrie",_loc3_.mechView.x,_loc10_.y,14,1,40,"horizontal","",true);
         effectsM.createExplosion(3,_loc3_.mechView.x,_loc10_.y,50,30,20,2,7,2,this.holder_effects);
         effectsM.createSparksMC("screenBattle","spark",_loc3_.mechView.x,_loc10_.y,this.SPARKS_PER_FRAME,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontal","orange",true);
         this._lastWeaponEquipmentType = "crash";
         this.takeDamage("crashCrashingAnimationEnded",true,this._viewScaleFinal,false);
         this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
         this.createEarthQuake();
         _loc3_.currentStepVisual = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         _loc3_.currentStepCode = _loc3_.currentStepVisual;
         this.refreshFloorBuffEffects("crashCrashingAnimationEnded");
         var _loc11_:Number = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         var _loc12_:Number = this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID);
         var _loc13_:Number = _loc11_;
         var _loc14_:Number = _loc12_;
         if(_loc11_ > _loc12_)
         {
            _loc13_--;
         }
         else if(_loc11_ < _loc12_)
         {
            _loc13_ += 1;
         }
         else if(_loc12_ == 0)
         {
            _loc13_--;
         }
         else
         {
            _loc13_ += 1;
         }
         this.pushMech(this._opponentPlayerID,this._currentPlayerID,this.CHARGE_SELF_PUSH,false,_loc13_,_loc14_,true);
         screensM.screenBattleInterfaceTop.refreshOpponentBars(true);
         if(_loc6_.HP > 0)
         {
            this._pushAnimEndedActionPerformed = true;
         }
      }
      
      public function harpoonClicked() : void
      {
         this.disableInterface("harpoon");
         remoteM.battle_harpoon();
      }
      
      public function harpoonLocally() : void
      {
         this.addSinglePlayerAction("harpoon",0,"");
      }
      
      private function harpoonLocallySub() : void
      {
         var _loc7_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         this.fireLocallyCalculations("harpoon",0,true);
         if(_loc6_.currentStepVisual > _loc3_.currentStepVisual)
         {
            _loc7_ = _loc3_.currentStepVisual + 1;
         }
         else
         {
            _loc7_ = _loc3_.currentStepVisual - 1;
         }
         this._battleTurnData.set_step(this._opponentPlayerInterfacePlayerID,_loc7_);
         _loc6_.currentStepCode = this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID);
         this.activateNextBattlePhase("action_harpoonSuccess");
      }
      
      public function harpoonSuccess() : void
      {
         this.setSocketAllowedStatus(false,"harpoonSuccess");
         this._lastAction = "harpoon";
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc5_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         var _loc7_:Number = Math.abs(_loc3_.currentStepVisual - _loc6_.currentStepVisual);
         var _loc8_:Number = (_loc7_ - 0.7) * this.FLOOR_STEP_SIZE;
         var _loc9_:Number = (_loc7_ - 1.7) * this.FLOOR_STEP_SIZE;
         var _loc10_:String = "left";
         if(_loc3_.currentStepVisual > _loc6_.currentStepVisual)
         {
            _loc10_ = "right";
         }
         _loc3_.launchHarpoon("regular",_loc8_,_loc9_,_loc10_,_loc6_,this.harpoonReachedTarget,this.harpoonAnimationEnded);
         this.setNewDataForAttacker();
         this.setNewUsesForAttacker("harpoon",0);
      }
      
      private function harpoonReachedTarget() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc2_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         this._lastWeaponEquipmentType = "harpoon";
         this.takeDamage("harpoonAnimationEnded",false,this._viewScaleFinal,false);
         this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
         this.createEarthQuake();
      }
      
      private function harpoonAnimationEnded() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc2_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         _loc3_.currentStepVisual = this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID);
         _loc3_.currentStepCode = _loc3_.currentStepVisual;
         this.refreshFloorBuffEffects("harpoonAnimationEnded");
         _loc3_.mechView.x = (_loc3_.currentStepVisual + 0.5) * this.FLOOR_STEP_SIZE;
         this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
         this.refreshMechCodeStepMarker(1);
         this.refreshMechCodeStepMarker(2);
         if(_loc3_.HP > 0)
         {
            this.activateNextBattlePhase("turn_actionPerformed",{
               "delayNewAction":true,
               "stopBattleViewAfterDelayNewAction":false,
               "caller":"harpoonAnimationEnded"
            });
         }
      }
      
      public function stompClicked() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         if(this._waitingForFinishMove)
         {
            _loc1_ = dataM.playersData[this._currentPlayerID];
            _loc2_ = this.getMechSlot(this._currentPlayerID);
            _loc3_ = this._mechBattleDatas[_loc2_];
            _loc4_ = _loc3_.mechView;
            _loc4_.activateStomp(this.stompFinishAnimDone);
         }
         else
         {
            this.fireWeapon("leg",0);
         }
      }
      
      public function stompRegularAnimDone() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMMechView = _loc3_.mechView;
         var _loc5_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc6_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc7_:BMMechBattleData = this._mechBattleDatas[_loc6_];
         var _loc8_:BMPlayerItemData = dataM.getPlayerItemData(this._currentPlayerID,_loc3_.mechStructure.leg);
         var _loc9_:BMItemData = dataM.itemsDB[_loc8_.itemID];
         var _loc10_:String = dataM.animationDB[_loc9_.animation].fireEffect;
         var _loc11_:String = "stompLegHit" + _loc10_.substr(_loc10_.length - 1,1);
         effectsM.createGeneralEffect(this.holder_effects,_loc11_,false,0,0,_loc4_.x,0,0,null,[]);
         effectsM.createStompFire(this.holder_effects,_loc10_,_loc4_.x,0,60,6,1,false);
         effectsM.createStompFire(this.holder_effects,_loc10_,_loc4_.x,0,60,6,1,true);
         this._lastWeaponEquipmentType = "stomp";
         this.takeDamage("stompRegularAnimDone",true,this._viewScaleFinal,true);
         this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
         this.createEarthQuake();
         if(_loc7_.HP > 0)
         {
            if(_loc7_.mechBeingPushed())
            {
               this._pushAnimEndedActionPerformed = true;
            }
            else
            {
               this.activateNextBattlePhase("turn_actionPerformed",{
                  "delayNewAction":true,
                  "stopBattleViewAfterDelayNewAction":false,
                  "caller":"stompRegularAnimDone"
               });
            }
         }
      }
      
      public function getAvailableStep(param1:Number, param2:Number, param3:Number, param4:String) : Number
      {
         var _loc5_:Number = NaN;
         var _loc8_:BMMechBattleData = null;
         var _loc9_:Number = NaN;
         var _loc11_:String = null;
         var _loc12_:BMMechBattleData = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:BMPlayerItemData = null;
         var _loc18_:Number = NaN;
         _loc5_ = -1;
         var _loc6_:BMPlayerData = dataM.playersData[param1];
         var _loc7_:String = this.getMechSlot(param1);
         _loc8_ = this._mechBattleDatas[_loc7_];
         if(param1 == this._currentPlayerID)
         {
            _loc9_ = this._opponentPlayerID;
         }
         else
         {
            _loc9_ = this._currentPlayerID;
         }
         var _loc10_:BMPlayerData = dataM.playersData[_loc9_];
         _loc11_ = this.getMechSlot(_loc9_);
         _loc12_ = this._mechBattleDatas[_loc11_];
         _loc16_ = dataM.getPlayerItemData(_loc8_.playerID,_loc8_.mechStructure.leg);
         var _loc17_:BMItemData = dataM.itemsDB[_loc16_.itemID];
         switch(param4)
         {
            case "teleport":
               if(param3 >= 0 && param3 < dataM.battleData.map.stepsTotal)
               {
                  if(param3 != _loc8_.currentStepCode && param3 != _loc12_.currentStepCode)
                  {
                     _loc5_ = param3;
                  }
               }
               break;
            case "walk":
            case "jump":
            case "walkAndJump":
               if(param2 < param3)
               {
                  _loc18_ = param2 + 1;
                  for(; _loc18_ <= param3; _loc18_++)
                  {
                     if(!(_loc18_ >= 0 && _loc18_ < dataM.battleData.map.stepsTotal))
                     {
                        continue;
                     }
                     switch(param4)
                     {
                        case "jump":
                        case "walkAndJump":
                           if(_loc18_ != _loc12_.currentStepCode)
                           {
                              _loc5_ = _loc18_;
                           }
                           break;
                        case "walk":
                           if(_loc18_ != _loc12_.currentStepCode)
                           {
                              _loc5_ = _loc18_;
                           }
                           else
                           {
                              _loc18_ = param3 + 1;
                           }
                     }
                  }
               }
               else
               {
                  _loc18_ = param2 - 1;
                  for(; _loc18_ >= param3; _loc18_--)
                  {
                     if(!(_loc18_ >= 0 && _loc18_ < dataM.battleData.map.stepsTotal))
                     {
                        continue;
                     }
                     switch(param4)
                     {
                        case "jump":
                        case "walkAndJump":
                           if(_loc18_ != _loc12_.currentStepCode)
                           {
                              _loc5_ = _loc18_;
                           }
                           break;
                        case "walk":
                           if(_loc18_ != _loc12_.currentStepCode)
                           {
                              _loc5_ = _loc18_;
                           }
                           else
                           {
                              _loc18_ = param3 - 1;
                           }
                     }
                  }
               }
         }
         return _loc5_;
      }
      
      public function walkLeftClicked() : void
      {
         this.walkJumpClickedSub("walk","left");
      }
      
      public function walkRightClicked() : void
      {
         this.walkJumpClickedSub("walk","right");
      }
      
      public function jumpLeftClicked() : void
      {
         this.walkJumpClickedSub("jump","left");
      }
      
      public function jumpRightClicked() : void
      {
         this.walkJumpClickedSub("jump","right");
      }
      
      public function walkJumpClickedSub(param1:String, param2:String) : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(this._interfaceEnabled)
         {
            this.disableInterface("walkJumpClickedSub");
            _loc3_ = dataM.playersData[this._currentPlayerID];
            _loc4_ = this.getMechSlot(this._currentPlayerID);
            _loc5_ = this._mechBattleDatas[_loc4_];
            _loc6_ = dataM.getPlayerItemData(this._currentPlayerID,_loc5_.mechStructure.leg);
            _loc7_ = dataM.itemsDB[_loc6_.itemID];
            switch(param1)
            {
               case "walk":
                  switch(param2)
                  {
                     case "left":
                        _loc8_ = _loc5_.currentStepCode - _loc7_.stepsPerWalk;
                        break;
                     case "right":
                        _loc8_ = _loc5_.currentStepCode + _loc7_.stepsPerWalk;
                  }
                  break;
               case "jump":
                  switch(param2)
                  {
                     case "left":
                        _loc8_ = _loc5_.currentStepCode - _loc7_.stepsPerJump;
                        break;
                     case "right":
                        _loc8_ = _loc5_.currentStepCode + _loc7_.stepsPerJump;
                  }
            }
            _loc9_ = dataM.getClientInvertedStep(this.getAvailableStep(this._currentPlayerID,_loc5_.currentStepCode,_loc8_,param1));
            remoteM.battle_moveMechToStep(param1,_loc9_);
         }
      }
      
      public function moveMechToStep(param1:String, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = dataM.getClientInvertedStep(param2);
         remoteM.battle_moveMechToStep(param1,_loc3_);
         this.disableInterface("teleportLocationClicked");
      }
      
      public function moveMechToStepLocally(param1:String, param2:Number) : void
      {
         this.addSinglePlayerAction("moveMechToStep",param2,param1);
      }
      
      private function moveMechToStepLocallySub(param1:String, param2:Number) : void
      {
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         this.resetBattleTurnDataLocally("moveMechToStepLocallySub");
         this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,param2);
         var _loc3_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc4_ = this.getMechSlot(this._currentPlayerID);
         _loc5_ = this._mechBattleDatas[_loc4_];
         _loc5_.currentStepCode = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         this.activateNextBattlePhase("action_moveMechToStepSuccess",{
            "motionType":param1,
            "targetStep":this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID)
         });
      }
      
      public function moveMechToStepSuccess(param1:String, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         this.setSocketAllowedStatus(false,"moveMechToStepSuccess");
         this._lastAction = "moveMechToStep";
         this._lastGeneralSpeedRatio = dataM.generalSpeedRatio;
         _loc3_ = dataM.getClientInvertedStep(param2);
         var _loc4_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc5_ = this.getMechSlot(this._currentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
         if(_loc6_.mechBeingPushed())
         {
            _loc6_.endCurrentPush();
         }
         _loc7_ = dataM.getPlayerItemData(this._currentPlayerID,_loc6_.mechStructure.leg);
         _loc8_ = dataM.itemsDB[_loc7_.itemID];
         _loc9_ = "left";
         if(_loc6_.currentStepVisual < _loc3_)
         {
            _loc9_ = "right";
         }
         _loc10_ = Math.abs(_loc6_.currentStepVisual - _loc3_);
         this._moveLastOriginStep = _loc6_.currentStepVisual;
         this._moveLastTargetStep = _loc3_;
         this._moveLastMotionType = param1;
         _loc6_.currentStepVisual = _loc3_;
         _loc6_.currentStepCode = _loc6_.currentStepVisual;
         this.refreshFloorBuffEffects("moveMechToStepSuccess");
         this._movingFramesCounter = 0;
         _loc12_ = false;
         switch(param1)
         {
            case "walk":
               this._movingSteps = _loc10_ * 2;
               this._movingFramesMax = this.MECH_WALKING_FRAMES * this._movingSteps / this._lastGeneralSpeedRatio;
               _loc11_ = _loc10_ * this.FLOOR_STEP_SIZE / this._movingFramesMax;
               switch(_loc9_)
               {
                  case "left":
                     if(dataM.wheelsDB[_loc8_.itemID])
                     {
                        _loc11_ *= 2;
                        this._movingFramesMax = Math.ceil(this._movingFramesMax / 2);
                        _loc12_ = true;
                     }
                     else if(_loc6_.mechView.scaleX == 1)
                     {
                        _loc6_.mechView.walkBackwards(this._movingSteps,true,null);
                     }
                     else
                     {
                        _loc6_.mechView.walkForward(this._movingSteps,true,null);
                     }
                     this._movingXPerFrame = -_loc11_;
                     break;
                  case "right":
                     if(dataM.wheelsDB[_loc8_.itemID])
                     {
                        _loc11_ *= 2;
                        this._movingFramesMax = Math.ceil(this._movingFramesMax / 2);
                        _loc12_ = true;
                     }
                     else if(_loc6_.mechView.scaleX == 1)
                     {
                        _loc6_.mechView.walkForward(this._movingSteps,true,null);
                     }
                     else
                     {
                        _loc6_.mechView.walkBackwards(this._movingSteps,true,null);
                     }
                     this._movingXPerFrame = _loc11_;
               }
               this._mechWalkingHandler = true;
               break;
            case "jump":
               this._movingFramesMax = this.MECH_JUMPING_FRAMES / this._lastGeneralSpeedRatio;
               _loc11_ = _loc10_ * this.FLOOR_STEP_SIZE / this._movingFramesMax;
               switch(_loc9_)
               {
                  case "left":
                     this._movingXPerFrame = -_loc11_;
                     break;
                  case "right":
                     this._movingXPerFrame = _loc11_;
               }
               _loc6_.mechView.activateCrouchBeforeJump(this.crouchBeforeJumpCompleted);
         }
         if(_loc12_)
         {
            _loc6_.mechView.activateWheelsAnimation();
         }
      }
      
      private function mechWalkingHandler() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         if(this._mechWalkingHandler)
         {
            ++this._movingFramesCounter;
            _loc1_ = dataM.playersData[this._currentPlayerID];
            _loc2_ = this.getMechSlot(this._currentPlayerID);
            _loc3_ = this._mechBattleDatas[_loc2_];
            _loc4_ = _loc3_.mechView;
            if(this._movingFramesCounter <= this._movingFramesMax)
            {
               if(_loc4_.mechIsLimping())
               {
                  _loc4_.x += this._movingXPerFrame * 0.5;
                  this._movingFramesCounter -= 0.5;
               }
               else
               {
                  _loc4_.x += this._movingXPerFrame;
               }
            }
            else
            {
               _loc4_.x = (_loc3_.currentStepVisual + 0.5) * this.FLOOR_STEP_SIZE;
               this._mechWalkingHandler = false;
               this.walkJumpAnimDone();
               _loc5_ = dataM.getPlayerItemData(this._currentPlayerID,_loc3_.mechStructure.leg);
               _loc6_ = dataM.itemsDB[_loc5_.itemID];
               if(dataM.wheelsDB[_loc6_.itemID])
               {
                  _loc4_.deactivateWheelsAnimation();
               }
            }
         }
      }
      
      private function walkingDirtEffect() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:Number = _loc3_.mechView.x;
         var _loc5_:Number = _loc3_.mechView.y;
      }
      
      private function crouchBeforeJumpCompleted() : void
      {
         this._mechJumpingHandler = true;
      }
      
      private function mechJumpingHandler() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this._mechJumpingHandler)
         {
            ++this._movingFramesCounter;
            _loc1_ = dataM.playersData[this._currentPlayerID];
            _loc2_ = this.getMechSlot(this._currentPlayerID);
            _loc3_ = this._mechBattleDatas[_loc2_];
            if(dataM.runAsMobile == false && this._movingFramesCounter == 1)
            {
               _loc3_.mechView.activeJumpJetAnimation();
            }
            if(this._movingFramesCounter <= this._movingFramesMax)
            {
               _loc3_.mechView.x += this._movingXPerFrame;
               if(this._movingFramesCounter <= this._movingFramesMax / 2)
               {
                  _loc4_ = (this._movingFramesMax / 2 - this._movingFramesCounter + 1) * this.JUMP_Y_CHANGE_PER_FRAME * this._lastGeneralSpeedRatio * this._lastGeneralSpeedRatio;
                  _loc3_.mechView.y -= _loc4_;
                  if(_loc3_.mechView.useLegsShadow)
                  {
                     _loc3_.mechView.leg1Shadow.y += _loc4_;
                     _loc3_.mechView.leg2Shadow.y += _loc4_;
                  }
               }
               else
               {
                  _loc4_ = (this._movingFramesMax / 2 - (this._movingFramesMax - this._movingFramesCounter)) * this.JUMP_Y_CHANGE_PER_FRAME * this._lastGeneralSpeedRatio * this._lastGeneralSpeedRatio;
                  _loc3_.mechView.y += _loc4_;
                  if(_loc3_.mechView.useLegsShadow)
                  {
                     _loc3_.mechView.leg1Shadow.y -= _loc4_;
                     _loc3_.mechView.leg2Shadow.y -= _loc4_;
                  }
               }
            }
            else
            {
               this._mechJumpingHandler = false;
               _loc3_.mechView.activateBumpAnimation(true);
               _loc3_.mechView.x = (_loc3_.currentStepVisual + 0.5) * this.FLOOR_STEP_SIZE;
               _loc3_.mechView.y = -(_loc3_.mechView.mechSizer.height + _loc3_.mechView.mechSizer.y);
               this.walkJumpAnimDone();
               _loc5_ = _loc3_.mechView.x;
               _loc6_ = _loc3_.mechView.y;
               effectsM.createSparksMC("screenBattle","spark",_loc5_,-10,this.SPARKS_PER_FRAME,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontal","brown",true);
               soundM.createSound("footStep",1);
               this.createEarthQuake();
            }
         }
      }
      
      private function walkJumpAnimDone() : void
      {
         if(this._waitingForFinishMove)
         {
            this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
            this.refreshMechCodeStepMarker(1);
            this.refreshMechCodeStepMarker(2);
            this.activateFinishMove(this._finishMoveID);
         }
         else
         {
            this.setNewDataForAttacker();
            this._interfaceEnabled = true;
            this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
            this.refreshMechCodeStepMarker(1);
            this.refreshMechCodeStepMarker(2);
            this.refreshMechsView();
            this.activateNextBattlePhase("turn_actionPerformed",{
               "delayNewAction":true,
               "stopBattleViewAfterDelayNewAction":false,
               "caller":"walkJumpAnimDone"
            });
         }
      }
      
      public function shutDownClicked() : void
      {
         this.disableInterface("shutDownClicked");
         remoteM.battle_shutDown();
      }
      
      public function shutDownLocally(param1:Number) : void
      {
         this.addSinglePlayerAction("shutDown",param1,"");
      }
      
      private function shutDownLocallySub(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:Number = NaN;
         this.resetBattleTurnDataLocally("shutDownLocallySub");
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         _loc5_ = _loc4_.heatCooling * param1;
         if(_loc5_ > _loc4_.heat)
         {
            _loc5_ = _loc4_.heat;
         }
         this._battleTurnData.set_heat(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID) - _loc5_);
         this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION * param1);
         this.activateNextBattlePhase("action_shutDownSuccess");
      }
      
      public function shutDownSuccess() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         this.setSocketAllowedStatus(false,"shutDownSuccess");
         this._lastAction = "shutDown";
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.mechView;
         _loc5_ = _loc3_.mechView.x;
         _loc6_ = _loc3_.mechView.y + 35;
         var _loc7_:String = "";
         if(dataM.slowCPUMode)
         {
            _loc7_ = "_fast";
         }
         effectsM.createShutDown("shutDownAnim",_loc5_,_loc6_,dataM.slowCPUMode,this.shutDownAnimationEnded,this.holder_effects);
         if(_loc3_.mechView.shutDownActive == false)
         {
            _loc3_.mechView.activateShutdown();
         }
         _loc8_ = _loc3_.heat - this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID);
         _loc9_ = _loc4_.y + this.FLYING_NUMBER_Y_ADDON / this._viewScaleFinal;
         if(_loc8_ > 0)
         {
            effectsM.createFlyingNumber(this.holder_effects,_loc4_.x,_loc9_,"-" + _loc8_,"orange",0,this._viewScale,"up");
         }
         this.setNewDataForAttacker();
         soundM.createSound("shutDown",1);
      }
      
      public function forceShutDownSuccess() : void
      {
         this.activateNextBattlePhase("action_shutDownSuccess");
      }
      
      private function shutDownAnimationEnded() : void
      {
         if(this._forceShutDown)
         {
            this._forceShutDown = false;
            if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
            {
               this.setSocketAllowedStatus(true,"shutDownAnimationEnded");
               if(this._currentPlayerID == dataM.player1PlayerID)
               {
                  screensM.screenDebugger.addTrace("### waiting for my own shutdown ended");
               }
               else
               {
                  screensM.screenDebugger.addTrace("### waiting for opponent\'s shutdown ended");
               }
            }
            else
            {
               this.forceShutDownEndedSuccess();
            }
         }
         else
         {
            this.shutDownEndedFinalFunctions();
         }
      }
      
      public function forceShutDownEndedLocally() : void
      {
         this.forceShutDownEndedSuccess();
      }
      
      public function forceShutDownEndedSuccess() : void
      {
         this.shutDownEndedFinalFunctions();
      }
      
      private function shutDownEndedFinalFunctions() : void
      {
         this.setSocketAllowedStatus(true,"shutDownEndedFinalFunctions");
         this._interfaceEnabled = true;
         this.activateNextBattlePhase("turn_actionPerformed",{
            "delayNewAction":true,
            "stopBattleViewAfterDelayNewAction":false,
            "caller":"shutDownEndedFinalFunctions"
         });
      }
      
      private function energyRegenerationPhase() : void
      {
         this.setSocketAllowedStatus(true,"actionPerformedSub >> energyRegeneration");
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
         {
            screensM.screenDebugger.addTrace("### waiting for energy regeneration");
         }
         else
         {
            this.energyRegenerationLocally();
         }
      }
      
      private function energyRegenerationLocally() : void
      {
         this.addSinglePlayerAction("energyRegeneration",0,"");
      }
      
      private function energyRegenerationLocallySub() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.energyRegeneration;
         if(_loc3_.energy + _loc4_ > _loc3_.energyMax)
         {
            _loc4_ = _loc3_.energyMax - _loc3_.energy;
         }
         this._battleTurnData.set_energy(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_energy(this._currentPlayerInterfacePlayerID) + _loc4_);
         this.activateNextBattlePhase("action_energyRegenerationSuccess");
      }
      
      public function energyRegenerationSuccess() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         this.setSocketAllowedStatus(true,"energyRegenerationSuccess");
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc3_.energy = this._battleTurnData.get_energy(this._currentPlayerInterfacePlayerID);
         this.setNewDataForAttacker();
         this.activateNextBattlePhase("turn_endTurnSuccess",{
            "delayEndTurn":false,
            "swapPlayersOnly":false
         });
      }
      
      public function activateDeactivateShield() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         this.disableInterface("activateDeactivateShield");
         if(_loc3_.shieldActive)
         {
            remoteM.battle_shieldDeactivate();
         }
         else
         {
            remoteM.battle_shieldActivate();
         }
      }
      
      public function deactivateShieldLocally() : void
      {
         this.addSinglePlayerAction("deactivateShield",0,"");
      }
      
      private function deactivateShieldLocallySub() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         this.resetBattleTurnDataLocally("deactivateShieldLocallySub");
         this._battleTurnData.set_shieldActive(this._currentPlayerInterfacePlayerID,false);
         this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         this.deactivateShieldSuccess();
      }
      
      public function deactivateShieldSuccess() : void
      {
         this.activateDeactivateShieldSuccess();
      }
      
      public function activateShieldLocally() : void
      {
         this.addSinglePlayerAction("activateShield",0,"");
      }
      
      private function activateShieldLocallySub() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         this.resetBattleTurnDataLocally("activateShieldLocallySub");
         this._battleTurnData.set_shieldActive(this._currentPlayerInterfacePlayerID,true);
         this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         this.activateShieldSuccess();
      }
      
      public function activateShieldSuccess() : void
      {
         this.activateDeactivateShieldSuccess();
      }
      
      public function activateDeactivateShieldSuccess() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         if(this._battleTurnData.get_shieldActive(this._currentPlayerInterfacePlayerID))
         {
            this._lastAction = "activateShield";
            _loc3_.activateShield();
            soundM.createSound("shieldOn",1);
         }
         else
         {
            this._lastAction = "deactivateShield";
            _loc3_.deactivateShield();
            soundM.createSound("shieldOff",1);
         }
         this.setNewDataForAttacker();
         this.activateNextBattlePhase("turn_actionPerformed",{
            "delayNewAction":true,
            "stopBattleViewAfterDelayNewAction":false,
            "caller":"activateDeactivateShieldSuccess"
         });
      }
      
      private function checkForShieldAutoDeactivation(param1:BMMechBattleData, param2:Number) : void
      {
         var _loc3_:BMPlayerData = null;
         if(param1.shieldActive)
         {
            _loc3_ = dataM.playersData[param1.playerID];
            if(this._battleTurnData.get_shieldActive(param2,_loc3_.selectedMechID) == false)
            {
               param1.deactivateShield();
               soundM.createSound("shieldOff",1);
            }
         }
      }
      
      private function checkForShieldAutoActivation(param1:BMMechBattleData, param2:Number) : void
      {
         var _loc3_:BMPlayerData = null;
         if(param1.shieldActive == false)
         {
            _loc3_ = dataM.playersData[param1.playerID];
            if(this._battleTurnData.get_shieldActive(param2,_loc3_.selectedMechID))
            {
               param1.activateShield();
               soundM.createSound("shieldOn",1);
            }
         }
      }
      
      public function activateDeactivateDrone() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         this.disableInterface("activateDeactivateDrone");
         if(_loc3_.droneActive)
         {
            remoteM.battle_droneDeactivate();
         }
         else
         {
            remoteM.battle_droneActivate();
         }
      }
      
      public function deactivateDroneLocally() : void
      {
         this.addSinglePlayerAction("deactivateDrone",0,"");
      }
      
      private function deactivateDroneLocallySub() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         this.resetBattleTurnDataLocally("deactivateDroneLocallySub");
         this._battleTurnData.set_droneActive(this._currentPlayerInterfacePlayerID,false);
         this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         this.activateNextBattlePhase("action_deactivateDroneSuccess");
      }
      
      public function deactivateDroneSuccess() : void
      {
         this.activateDeactivateDroneSuccess();
      }
      
      public function activateDroneLocally() : void
      {
         this.addSinglePlayerAction("activateDrone",0,"");
      }
      
      private function activateDroneLocallySub() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         this.resetBattleTurnDataLocally("activateDroneLocallySub");
         this._battleTurnData.set_droneActive(this._currentPlayerInterfacePlayerID,true);
         this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         this.activateDroneSuccess();
      }
      
      public function activateDroneSuccess() : void
      {
         this.activateDeactivateDroneSuccess();
      }
      
      public function activateDeactivateDroneSuccess() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:Boolean = false;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = false;
         if(this._battleTurnData.get_droneActive(this._currentPlayerInterfacePlayerID))
         {
            this._lastAction = "activateDrone";
            _loc3_.droneActive = true;
            soundM.createSound("droneOn",1);
            _loc4_ = true;
         }
         else
         {
            this._lastAction = "deactivateDrone";
            _loc3_.droneActive = false;
            _loc3_.uses["drone"] = 0;
            soundM.createSound("droneOff",1);
         }
         this.setNewDataForAttacker();
         this.activateNextBattlePhase("turn_actionPerformed",{
            "delayNewAction":_loc4_,
            "stopBattleViewAfterDelayNewAction":false,
            "caller":"deactivateDroneSuccess"
         });
      }
      
      private function canDroneFire() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         _loc1_ = false;
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         if(_loc4_.droneActive)
         {
            if(_loc4_.droneFired == false)
            {
               _loc5_ = dataM.getPlayerItemData(this._currentPlayerID,_loc4_.mechStructure.drone);
               _loc6_ = dataM.itemsDB[_loc5_.itemID];
               _loc7_ = false;
               _loc8_ = false;
               _loc9_ = false;
               _loc10_ = false;
               _loc11_ = false;
               if(_loc6_.HPAddon > 0)
               {
                  if(_loc4_.HP == _loc4_.HPMax)
                  {
                     _loc7_ = true;
                  }
               }
               if(_loc4_.energy >= _loc6_.costEnergy)
               {
                  _loc8_ = true;
               }
               _loc9_ = true;
               if(_loc4_.bullets >= _loc6_.bullets)
               {
                  _loc10_ = true;
               }
               if(_loc4_.rockets >= _loc6_.rockets)
               {
                  _loc11_ = true;
               }
               if(_loc7_ == false && _loc8_ && _loc9_ && _loc10_ && _loc11_)
               {
                  _loc1_ = true;
               }
            }
         }
         return _loc1_;
      }
      
      public function useKit(param1:Number) : void
      {
         this.disableInterface("useKit");
         remoteM.battle_useKit(param1);
      }
      
      public function useKitLocally(param1:Number) : void
      {
         this.addSinglePlayerAction("useKit",param1,"");
      }
      
      private function useKitLocallySub(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         this.resetBattleTurnDataLocally("useKitLocallySub");
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         _loc5_ = "kit" + param1;
         _loc6_ = Number(_loc4_.mechStructure[_loc5_]);
         _loc7_ = dataM.getPlayerItemData(this._currentPlayerID,_loc6_);
         _loc8_ = dataM.itemsDB[_loc7_.itemID];
         _loc9_ = 0;
         _loc10_ = 0;
         _loc11_ = 0;
         _loc12_ = 0;
         _loc13_ = 0;
         if(_loc8_.HPBase > 0)
         {
            _loc9_ = _loc8_.HPBase + Math.ceil(Math.random() * (_loc8_.HPAddon + 1)) - 1;
            if(_loc4_.HP + _loc9_ > _loc4_.HPMax)
            {
               _loc9_ = _loc4_.HPMax - _loc4_.HP;
            }
            this._battleTurnData.set_HP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_HP(this._currentPlayerInterfacePlayerID) + _loc9_);
         }
         if(_loc8_.energyBase > 0)
         {
            _loc10_ = _loc8_.energyBase + Math.ceil(Math.random() * (_loc8_.energyAddon + 1)) - 1;
            if(_loc4_.energy + _loc10_ > _loc4_.energyMax)
            {
               _loc10_ = _loc4_.energyMax - _loc4_.energy;
            }
            this._battleTurnData.set_energy(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_energy(this._currentPlayerInterfacePlayerID) + _loc10_);
         }
         if(_loc8_.heatBase > 0)
         {
            _loc11_ = _loc8_.heatBase + Math.ceil(Math.random() * (_loc8_.heatAddon + 1)) - 1;
            if(_loc4_.heat - _loc11_ < 0)
            {
               _loc11_ = _loc4_.heat;
            }
            this._battleTurnData.set_heat(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID) - _loc11_);
         }
         if(_loc8_.bullets > 0)
         {
            _loc12_ = _loc8_.bullets;
            if(_loc4_.bullets + _loc12_ > _loc4_.bullets)
            {
               _loc12_ = _loc4_.bulletsMax - _loc4_.bullets;
            }
            this._battleTurnData.set_bullets(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_bullets(this._currentPlayerInterfacePlayerID) + _loc12_);
         }
         if(_loc8_.rockets > 0)
         {
            _loc13_ = _loc8_.rockets;
            if(_loc4_.rockets + _loc13_ > _loc4_.rockets)
            {
               _loc13_ = _loc4_.rocketsMax - _loc4_.rockets;
            }
            this._battleTurnData.set_rockets(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_rockets(this._currentPlayerInterfacePlayerID) + _loc13_);
         }
         if(_loc8_.resist1 > 0)
         {
            this._battleTurnData.set_resist1(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_resist1(this._currentPlayerInterfacePlayerID) + _loc8_.resist1);
         }
         if(_loc8_.resist2 > 0)
         {
            this._battleTurnData.set_resist2(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_resist2(this._currentPlayerInterfacePlayerID) + _loc8_.resist2);
         }
         if(_loc8_.resist3 > 0)
         {
            this._battleTurnData.set_resist3(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_resist3(this._currentPlayerInterfacePlayerID) + _loc8_.resist3);
         }
         this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         this.activateNextBattlePhase("action_useKitSuccess",{"equipmentID":param1});
      }
      
      public function useKitSuccess(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMMechView = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItemData = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:MovieClip = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:BMPlayerProfile = null;
         this._lastAction = "useKit";
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         _loc5_ = _loc4_.mechView;
         _loc6_ = "kit" + param1;
         _loc7_ = Number(_loc4_.mechStructure[_loc6_]);
         _loc8_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_);
         _loc9_ = dataM.itemsDB[_loc8_.itemID];
         _loc10_ = _loc5_.y + this.FLYING_NUMBER_Y_ADDON / this._viewScaleFinal;
         _loc11_ = this._battleTurnData.get_HP(this._currentPlayerInterfacePlayerID) - _loc4_.HP;
         _loc12_ = this._battleTurnData.get_energy(this._currentPlayerInterfacePlayerID) - _loc4_.energy;
         _loc13_ = _loc4_.heat - this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID);
         _loc14_ = this._battleTurnData.get_bullets(this._currentPlayerInterfacePlayerID) - _loc4_.bullets;
         _loc15_ = this._battleTurnData.get_rockets(this._currentPlayerInterfacePlayerID) - _loc4_.rockets;
         _loc16_ = _loc9_.resist1;
         _loc17_ = _loc9_.resist2;
         _loc18_ = _loc9_.resist3;
         if(_loc11_ > 0)
         {
            _loc19_ = "+" + _loc11_;
            _loc20_ = "red";
         }
         else if(_loc12_ > 0)
         {
            _loc19_ = "+" + _loc12_;
            _loc20_ = "green";
         }
         else if(_loc13_ > 0)
         {
            _loc19_ = "-" + _loc13_;
            _loc20_ = "orange";
         }
         else if(_loc14_ > 0)
         {
            _loc19_ = "+" + _loc14_;
            _loc20_ = "yellow";
         }
         else if(_loc16_ > 0)
         {
            _loc19_ = "+" + _loc16_;
            _loc20_ = "yellow";
         }
         else if(_loc17_ > 0)
         {
            _loc19_ = "+" + _loc17_;
            _loc20_ = "orange";
         }
         else if(_loc18_ > 0)
         {
            _loc19_ = "+" + _loc18_;
            _loc20_ = "blue";
         }
         else
         {
            _loc19_ = "+" + _loc15_;
            _loc20_ = "yellow";
         }
         effectsM.createFlyingNumber(this.holder_effects,_loc5_.x,_loc10_,_loc19_,_loc20_,0,this._viewScale,"up");
         _loc4_.mechStructure[_loc6_] = 0;
         _loc4_.mechStructure.updateEquipmentIndicators();
         if(_loc16_ > 0)
         {
            _loc4_.resist1 += _loc16_;
            screensM.screenBattleInterfaceTop.refreshResistance(this._currentPlayerID,1,true);
         }
         if(_loc17_ > 0)
         {
            _loc4_.resist2 += _loc17_;
            screensM.screenBattleInterfaceTop.refreshResistance(this._currentPlayerID,2,true);
         }
         if(_loc18_ > 0)
         {
            _loc4_.resist3 += _loc18_;
            screensM.screenBattleInterfaceTop.refreshResistance(this._currentPlayerID,3,true);
         }
         _loc21_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc9_.type],_loc9_.grp);
         _loc22_ = Number(this["PLAYER_" + this._currentPlayerInterfacePlayerID + "_KIT_X_POS"]);
         _loc23_ = Number(this["PLAYER_" + this._currentPlayerInterfacePlayerID + "_KIT_Y_POS"]);
         effectsM.createFlyingKit(this.holder_staticEffects,_loc22_,_loc23_,_loc21_);
         this.setNewDataForAttacker();
         dataM.removePlayerItemData(this._currentPlayerID,_loc7_);
         if(this._currentPlayerID == dataM.ONLINE_PLAYER_ID && dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer)
         {
            _loc24_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            remoteM.lobby_deleteItem(_loc7_);
         }
         soundM.createSound("kitUsed",1);
         this.activateNextBattlePhase("turn_actionPerformed",{
            "delayNewAction":true,
            "stopBattleViewAfterDelayNewAction":false,
            "caller":"useKitSuccess"
         });
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(dataM.getInterfacePlayerID(this._currentPlayerID));
      }
      
      private function resetBattleTurnDataLocally(param1:String) : void
      {
         this._battleTurnData = new BMBattleTurnData();
         this.resetBattleTurnDataLocallySub(this._currentPlayerID,this._currentPlayerInterfacePlayerID,"resetBattleTurnDataLocally");
         this.resetBattleTurnDataLocallySub(this._opponentPlayerID,this._opponentPlayerInterfacePlayerID,"resetBattleTurnDataLocally");
      }
      
      public function getBattleTurnData() : BMBattleTurnData
      {
         return this._battleTurnData;
      }
      
      private function resetBattleTurnDataLocallySub(param1:Number, param2:Number, param3:String) : void
      {
         var _loc4_:BMPlayerData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:uint = 0;
         this._battleTurnData.resetPlayerData(param2);
         _loc4_ = dataM.playersData[param1];
         _loc5_ = this.getMechSlot(param1);
         _loc6_ = this._mechBattleDatas[_loc5_];
         this._battleTurnData.set_selectedMechID(param2,_loc4_.selectedMechID);
         this._battleTurnData.set_AP(param2,_loc4_.AP);
         this._battleTurnData.set_step(param2,_loc6_.currentStepVisual);
         _loc6_.currentStepCode = this._battleTurnData.get_step(param2);
         _loc7_ = 1;
         while(_loc7_ <= dataM.battleMechsPerPlayer)
         {
            _loc6_ = this._mechBattleDatas[param1 + "_" + _loc7_];
            this._battleTurnData.set_HP(param2,_loc6_.HP,_loc7_);
            this._battleTurnData.set_energy(param2,_loc6_.energy,_loc7_);
            this._battleTurnData.set_heat(param2,_loc6_.heat,_loc7_);
            this._battleTurnData.set_bullets(param2,_loc6_.bullets,_loc7_);
            this._battleTurnData.set_rockets(param2,_loc6_.rockets,_loc7_);
            this._battleTurnData.set_droneActive(param2,_loc6_.droneActive,_loc7_);
            this._battleTurnData.set_droneFired(param2,_loc6_.droneFired,_loc7_);
            this._battleTurnData.set_shieldActive(param2,_loc6_.shieldActive,_loc7_);
            this._battleTurnData.set_resist1(param2,_loc6_.resist1,_loc7_);
            this._battleTurnData.set_resist2(param2,_loc6_.resist2,_loc7_);
            this._battleTurnData.set_resist3(param2,_loc6_.resist3,_loc7_);
            _loc7_++;
         }
      }
      
      private function createFloorBuffs() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:BMFloorBuff = null;
         this._floorBuffs = new Array();
         _loc1_ = new Object();
         for each(_loc2_ in dataM.battle_floorBuffsData)
         {
            if(_loc2_ != null)
            {
               if(dataM.battle_clientInverted)
               {
                  _loc2_.step = dataM.getClientInvertedStep(_loc2_.step);
               }
               _loc1_[_loc2_.step] = _loc2_;
               _loc3_ = new BMFloorBuff();
               _loc3_.x = this.FLOOR_STEP_SIZE * (_loc2_.step + 0.5);
               _loc3_.initialize(_loc2_.step,_loc2_.type,_loc2_.subType);
               this.holder_drones.addChild(_loc3_);
               this._floorBuffs[_loc2_.step] = _loc3_;
            }
         }
         dataM.battle_floorBuffsData = _loc1_;
      }
      
      private function removeFloorBuffs() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMFloorBuff = null;
         _loc1_ = 0;
         while(_loc1_ < this._floorBuffs.length)
         {
            if(this._floorBuffs[_loc1_] != null)
            {
               _loc2_ = this._floorBuffs[_loc1_];
               _loc2_.removeMe();
               this._floorBuffs[_loc1_] = null;
            }
            _loc1_++;
         }
         this._floorBuffs = new Array();
         dataM.battle_floorBuffsData = null;
      }
      
      private function refreshFloorBuffEffects(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc3_:BMFloorBuff = null;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:BMMechBattleData = null;
         if(dataM.battle_floorBuffsData != null)
         {
            for each(_loc2_ in dataM.battle_floorBuffsData)
            {
               if(_loc2_ != null)
               {
                  _loc3_ = this._floorBuffs[_loc2_.step];
                  _loc4_ = false;
                  _loc5_ = dataM.player1PlayerID;
                  while(_loc5_ <= dataM.player2PlayerID)
                  {
                     _loc6_ = this.getMechSlot(_loc5_);
                     _loc7_ = this._mechBattleDatas[_loc6_];
                     if(_loc7_.currentStepVisual == _loc3_.step)
                     {
                        _loc4_ = true;
                     }
                     _loc5_++;
                  }
                  if(_loc4_)
                  {
                     _loc3_.activateBuff();
                  }
                  else
                  {
                     _loc3_.deactivateBuff();
                  }
               }
            }
         }
      }
      
      private function cleanBattleField() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:BMPlayerData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         if(this._durabilityChanges.length > 0)
         {
            _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc3_.applyDurabilityChanges(this._durabilityChanges);
            this._durabilityChanges = new Array();
         }
         effectsM.clearAllEffects();
         this.removeFloorBuffs();
         this.resetBackgroundDarkness();
         _loc2_ = dataM.player1PlayerID;
         while(_loc2_ <= dataM.player2PlayerID)
         {
            _loc4_ = dataM.playersData[_loc2_];
            _loc5_ = this.getMechSlot(_loc2_);
            _loc6_ = this._mechBattleDatas[_loc5_];
            _loc4_.selectedMechID = 1;
            _loc6_.removeMe();
            _loc2_++;
         }
         this._mechBattleDatas = new Object();
         this.clearMechHologram();
         this.removeMapBackgrounds();
         this.mapBorder1.mcLight.gotoAndStop("animOff");
         this.mapBorder2.mcLight.gotoAndStop("animOff");
         if(this.floorStepNumbers != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.floorStepNumbers.length)
            {
               this.holder_backgroundFloor.removeChild(this.floorStepNumbers[_loc1_].stepText);
               this.holder_backgroundFloor.removeChild(this.floorStepNumbers[_loc1_].stepLine);
               this.floorStepNumbers[_loc1_].stepText = null;
               this.floorStepNumbers[_loc1_].stepLine = null;
               _loc1_++;
            }
         }
         this.actionRange.hideMe();
         dataM.saveGuestData("battle cleanBattleField");
      }
      
      public function timerNotice() : void
      {
         screensM.screenBattleInterfaceTop.clockTimerNotice();
         this._timerNotice = true;
         if(screensM.screenBattleInterfaceBottom.isMoveMechToStepActive())
         {
            screensM.screenBattleInterfaceBottom.cancelMoveToStepSelectionClicked();
         }
         this.disableInterface("timerNotice");
      }
      
      public function timerEnded() : void
      {
         this.disableInterface("timerEnded");
         this.setNewDataForAttacker();
      }
      
      public function enableInterface(param1:String) : void
      {
         if(this._timerNotice == false)
         {
            screensM.screenBattleInterfaceBottom.enableInterface("battle enableInterface");
            screensM.screenBattleInterfaceBottom.showInterface("battle enableInterface");
         }
      }
      
      private function disableInterface(param1:String) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:BMPlayerData = null;
         _loc2_ = false;
         _loc3_ = dataM.playersData[this._currentPlayerID];
         if(this._currentPlayerID == dataM.player1PlayerID)
         {
            if(this._timerNotice)
            {
               _loc2_ = true;
            }
            else
            {
               switch(param1)
               {
                  case "opponentQuitBattle":
                     _loc2_ = true;
                     break;
                  case "fireWeapon":
                  case "stompClicked":
                     break;
                  case "teleportLocationClicked":
                  case "charge":
                  case "walkJumpClickedSub":
                  case "activateDeactivateShield":
                  case "activateDeactivateDrone":
                  case "useKit":
                     if(_loc3_.AP >= 1)
                     {
                        _loc2_ = true;
                     }
                     break;
                  case "timerNotice":
                  case "timerEnded":
                  case "shutDownClicked":
                     _loc2_ = true;
               }
            }
         }
         if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            screensM.screenBattleInterfaceBottom.disableInterface();
         }
         if(_loc2_)
         {
            this.hideInterface("disableInterface");
         }
      }
      
      private function showInterface(param1:String) : void
      {
         if(this._timerNotice == false)
         {
            if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
            {
               screensM.screenBattleInterfaceBottom.showInterface("battle showInterface");
            }
         }
      }
      
      private function hideInterface(param1:String) : void
      {
         if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            screensM.screenBattleInterfaceBottom.hideInterface();
         }
      }
      
      public function getWeaponsInRangeUnfired(param1:Boolean, param2:Boolean, param3:Boolean) : Array
      {
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         _loc4_ = new Array();
         _loc5_ = 1;
         while(_loc5_ <= dataM.maxEquipment["sideWeapon"])
         {
            _loc4_ = this.getWeaponsInRangeUnfiredSub(_loc4_,"sideWeapon",_loc5_,true,param1,param2,param3);
            _loc5_++;
         }
         _loc5_ = 1;
         while(_loc5_ <= dataM.maxEquipment["topWeapon"])
         {
            _loc4_ = this.getWeaponsInRangeUnfiredSub(_loc4_,"topWeapon",_loc5_,true,param1,param2,param3);
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function getWeaponsInRangeUnfiredSub(param1:Array, param2:String, param3:Number, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : Array
      {
         var _loc9_:String = null;
         var _loc10_:BMMechBattleData = null;
         var _loc11_:String = null;
         var _loc12_:Number = NaN;
         var _loc13_:BMPlayerItemData = null;
         var _loc14_:BMItemData = null;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc8_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc9_ = this.getMechSlot(this._currentPlayerID);
         _loc10_ = this._mechBattleDatas[_loc9_];
         _loc11_ = param2 + param3;
         _loc12_ = Number(_loc10_.mechStructure[_loc11_]);
         if(_loc12_ > 0)
         {
            if(_loc10_.weaponAlreadyFired[_loc11_] == false)
            {
               _loc13_ = dataM.getPlayerItemData(this._currentPlayerID,_loc12_);
               _loc14_ = dataM.itemsDB[_loc13_.itemID];
               _loc15_ = false;
               _loc16_ = false;
               _loc17_ = false;
               _loc18_ = false;
               if(param4)
               {
                  if(this.isOpponentInWeaponRange(this._currentPlayerID,this._opponentPlayerID,_loc13_.itemID,-1,-1,-1))
                  {
                     _loc15_ = true;
                  }
               }
               else
               {
                  _loc15_ = true;
               }
               if(param5)
               {
                  if(_loc10_.energy >= _loc14_.costEnergy && _loc10_.bullets >= _loc14_.bullets && _loc10_.rockets >= _loc14_.rockets && (_loc10_.usesMax[_loc11_] == 0 || _loc10_.uses[_loc11_] < _loc10_.usesMax[_loc11_]))
                  {
                     _loc16_ = true;
                  }
               }
               else
               {
                  _loc16_ = true;
               }
               if(param6)
               {
                  if(_loc10_.heat + _loc14_.costHeat <= _loc10_.heatMax)
                  {
                     _loc17_ = true;
                  }
               }
               else
               {
                  _loc17_ = true;
               }
               if(param7)
               {
                  _loc19_ = Number(_loc10_.usesMax[_loc11_]);
                  _loc20_ = Number(_loc10_.uses[_loc11_]);
                  if(_loc19_ == 0 || _loc19_ > 0 && _loc20_ < _loc19_)
                  {
                     _loc18_ = true;
                  }
               }
               else
               {
                  _loc18_ = true;
               }
               if(_loc15_ && _loc16_ && _loc17_ && _loc18_)
               {
                  param1.push({
                     "type":param2,
                     "equipmentID":param3
                  });
               }
            }
         }
         return param1;
      }
      
      public function getWeaponsUnfired(param1:Number, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : Array
      {
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         _loc6_ = new Array();
         _loc7_ = 1;
         while(_loc7_ <= dataM.maxEquipment["sideWeapon"])
         {
            _loc6_ = this.getWeaponsInRangeUnfiredSub(_loc6_,"sideWeapon",_loc7_,param2,param3,param4,param5);
            _loc7_++;
         }
         _loc7_ = 1;
         while(_loc7_ <= dataM.maxEquipment["topWeapon"])
         {
            _loc6_ = this.getWeaponsInRangeUnfiredSub(_loc6_,"topWeapon",_loc7_,param2,param3,param4,param5);
            _loc7_++;
         }
         return _loc6_;
      }
      
      public function getBestWeaponsToFire(param1:Number, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean) : Array
      {
         var _loc8_:String = null;
         var _loc9_:BMMechBattleData = null;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:uint = 0;
         var _loc14_:Object = null;
         var _loc15_:Number = NaN;
         var _loc16_:BMPlayerItemData = null;
         var _loc17_:BMItemData = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:Object = null;
         var _loc23_:Object = null;
         var _loc24_:Object = null;
         var _loc7_:BMPlayerData = dataM.playersData[param1];
         _loc8_ = this.getMechSlot(param1);
         _loc9_ = this._mechBattleDatas[_loc8_];
         _loc10_ = new Array();
         _loc11_ = new Array();
         _loc12_ = this.getWeaponsUnfired(param1,param3,param4,param5,param6);
         if(_loc12_.length > 0)
         {
            _loc13_ = 0;
            while(_loc13_ < _loc12_.length)
            {
               _loc14_ = _loc12_[_loc13_];
               _loc15_ = Number(_loc9_.mechStructure[_loc14_.type + _loc14_.equipmentID]);
               _loc16_ = dataM.getPlayerItemData(param1,_loc15_);
               _loc17_ = dataM.itemsDB[_loc16_.itemID];
               _loc18_ = this.getWeaponAverageDamage(param2,_loc16_.itemID);
               _loc19_ = _loc18_ + 2 * (_loc17_.damageHeat + _loc17_.damageEnergy);
               _loc11_[_loc13_] = _loc19_;
               _loc12_[_loc13_].damage = _loc19_;
               _loc13_++;
            }
            if(_loc11_.length > 0)
            {
               _loc11_.sort(Array.NUMERIC | Array.DESCENDING);
               _loc20_ = 0;
               while(_loc20_ < _loc11_.length)
               {
                  _loc21_ = 0;
                  while(_loc21_ < _loc12_.length)
                  {
                     _loc22_ = _loc12_[_loc21_];
                     _loc23_ = _loc11_[_loc20_];
                     if(_loc22_.damage == _loc23_)
                     {
                        _loc24_ = new Object();
                        _loc24_.type = _loc22_.type;
                        _loc24_.equipmentID = _loc22_.equipmentID;
                        _loc24_.damage = _loc22_.damage;
                        _loc10_.push(_loc24_);
                        _loc21_ = _loc11_.length;
                     }
                     _loc21_++;
                  }
                  _loc20_++;
               }
            }
         }
         return _loc10_;
      }
      
      public function getWeaponAverageDamage(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:BMItemData = null;
         var _loc6_:String = null;
         var _loc7_:BMMechBattleData = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         _loc3_ = 0;
         _loc4_ = dataM.itemsDB[param2];
         var _loc5_:BMPlayerData = dataM.playersData[param1];
         _loc6_ = this.getMechSlot(param1);
         _loc7_ = this._mechBattleDatas[_loc6_];
         _loc8_ = _loc4_.damageBase;
         _loc9_ = _loc4_.damageAddon;
         _loc10_ = Number(_loc7_["resist" + _loc4_.damageType]);
         if(_loc10_ >= _loc8_)
         {
            _loc10_ -= _loc8_;
            _loc8_ = 1;
         }
         else
         {
            _loc8_ -= _loc10_;
            _loc10_ = 0;
         }
         if(_loc10_ > 0)
         {
            _loc9_ -= _loc10_;
            if(_loc9_ < 0)
            {
               _loc9_ = 0;
            }
         }
         return _loc8_ + Math.ceil(Math.random() * _loc9_ / 2);
      }
      
      public function isOpponentInWeaponRange(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean
      {
         var _loc8_:String = null;
         var _loc9_:BMMechBattleData = null;
         var _loc11_:String = null;
         var _loc12_:BMMechBattleData = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Boolean = false;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:Number = NaN;
         var _loc23_:Boolean = false;
         var _loc24_:BMItemData = null;
         var _loc7_:BMPlayerData = dataM.playersData[param1];
         _loc8_ = this.getMechSlot(param1);
         _loc9_ = this._mechBattleDatas[_loc8_];
         var _loc10_:BMPlayerData = dataM.playersData[param2];
         _loc11_ = this.getMechSlot(param2);
         _loc12_ = this._mechBattleDatas[_loc11_];
         if(param3 > -1)
         {
            _loc24_ = dataM.itemsDB[param3];
            _loc13_ = _loc24_.rangeBase;
            _loc14_ = _loc24_.rangeAddon;
         }
         else
         {
            _loc13_ = param4;
            _loc14_ = param5;
         }
         _loc15_ = true;
         _loc22_ = _loc9_.currentStepCode;
         if(param6 > -1)
         {
            _loc22_ = param6;
         }
         if(_loc22_ > _loc12_.currentStepCode)
         {
            _loc16_ = _loc22_ - 1;
            if(_loc16_ - _loc13_ >= 0)
            {
               if(_loc16_ - (_loc13_ + (_loc14_ - 1)) >= 0)
               {
                  _loc20_ = _loc16_ - (_loc13_ + (_loc14_ - 1));
                  _loc21_ = _loc16_ - _loc13_;
               }
               else
               {
                  _loc20_ = 0;
                  _loc21_ = _loc16_ - _loc13_;
               }
            }
            else
            {
               _loc15_ = false;
            }
         }
         else
         {
            _loc16_ = _loc22_ + 1;
            if(_loc16_ + _loc13_ < dataM.battleData.map.stepsTotal)
            {
               if(_loc16_ + (_loc13_ + (_loc14_ - 1)) < dataM.battleData.map.stepsTotal)
               {
                  _loc20_ = _loc16_ + _loc13_;
                  _loc21_ = _loc16_ + _loc13_ + (_loc14_ - 1);
               }
               else
               {
                  _loc20_ = _loc16_ + _loc13_;
                  _loc21_ = dataM.battleData.map.stepsTotal - 1;
               }
            }
            else
            {
               _loc15_ = false;
            }
         }
         _loc23_ = false;
         if(_loc15_)
         {
            _loc19_ = _loc20_;
            while(_loc19_ <= _loc21_)
            {
               if(_loc19_ == _loc12_.currentStepCode)
               {
                  _loc19_ = _loc21_;
                  _loc23_ = true;
               }
               _loc19_++;
            }
         }
         return _loc23_;
      }
      
      private function finishBattleVSComputer() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerProfile = null;
         _loc1_ = false;
         _loc2_ = false;
         _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this._battleResult == "youWon")
         {
            _loc1_ = true;
            _loc3_.wonLastBattleVSComputer = true;
         }
         else if(this._battleResult == "opponentQuit")
         {
            _loc2_ = true;
         }
         _loc4_ = false;
         _loc5_ = 0;
         if(dataM.battleType == "challenge")
         {
            switch(dataM.battleSubType)
            {
               case "invisible":
               case "godMode":
               case "usa":
               case "japan":
                  _loc4_ = true;
                  _loc5_ = 200;
            }
         }
         _loc6_ = dataM["player" + dataM.player2PlayerID + "Profile"];
         remoteM.lobby_finishBattleVSComputer(_loc1_,_loc2_,_loc4_,dataM.battleType,dataM.battleSubType,_loc5_,dataM.campaignBattleDifficulty,dataM.computerBattleID,this._battleReport,_loc6_.level);
      }
      
      public function finishBattleVSComputerLocally(param1:Boolean, param2:uint) : void
      {
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc4_ = 0;
         _loc5_ = 0;
         if(this._battleResult == "youLost")
         {
            _loc4_ = dataM.rewardSPLoseGold;
            _loc5_ = dataM.rewardSPLoseXP;
         }
         else
         {
            _loc4_ = dataM.rewardSPWinGold;
            if(param1)
            {
               if(param2 > 200)
               {
                  param2 = 200;
               }
               _loc4_ = Math.ceil(_loc4_ * param2 / 100);
            }
            _loc5_ = dataM.rewardSPWinXP;
         }
         _loc6_ = false;
         if(dataM.premiumAccountTime > dataM.currentTime)
         {
            _loc6_ = true;
         }
         if(dataM.battleType == "mission")
         {
            switch(dataM.battleSubType)
            {
               case "turret":
               case "jeep":
                  _loc4_ = Math.ceil(_loc4_ * 0.25);
                  _loc5_ = Math.ceil(_loc5_ * 0.25);
                  break;
               case "tank":
                  _loc4_ = Math.ceil(_loc4_ * 0.5);
                  _loc5_ = Math.ceil(_loc5_ * 0.5);
            }
         }
         if(_loc6_)
         {
            _loc4_ *= 2;
            _loc5_ *= 2;
         }
         _loc7_ = 0;
         _loc8_ = 0;
         if(_loc3_.XP + _loc5_ >= dataM.levelUpDB[_loc3_.level + 1])
         {
            _loc7_ = 2000 + (_loc3_.level - 1) * 200;
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            if(_loc3_.level >= dataM.GUEST_MAX_LEVEL)
            {
               _loc5_ = 0;
               _loc3_.level = dataM.GUEST_MAX_LEVEL;
            }
            if(_loc3_.gold >= dataM.GUEST_MAX_GOLD)
            {
               _loc4_ = 0;
               _loc7_ = 0;
               _loc3_.gold = dataM.GUEST_MAX_GOLD;
            }
         }
         this.finishBattleVSComputerSuccess(_loc4_,_loc5_,_loc7_,_loc8_);
      }
      
      public function finishBattleVSComputerSuccess(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(this._battleResult != "playerQuit")
         {
            _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc6_ = false;
            if(dataM.battleType == "challenge")
            {
               if(dataM.battleSubType == "damage")
               {
                  _loc6_ = true;
               }
            }
            if(_loc6_)
            {
               _loc5_.gold += param1;
               screensM.addScreen("screenPopUp");
               screensM.screenPopUp.refreshScreen("challengeCompleted",param1,param4,null);
            }
            else
            {
               screensM.addScreen("screenBattleResult",false);
               screensM.screenBattleResult.resetRewardParameters();
               if(dataM.premiumAccountTime > dataM.currentTime)
               {
                  screensM.screenBattleResult.goldResult = Math.ceil(param1 / 2);
                  screensM.screenBattleResult.goldAccount = 2;
                  screensM.screenBattleResult.XPResult = Math.ceil(param2 / 2);
                  screensM.screenBattleResult.XPAccount = 2;
               }
               else
               {
                  screensM.screenBattleResult.goldResult = param1;
                  screensM.screenBattleResult.XPResult = param2;
               }
               screensM.screenBattleResult.goldTotal = param1;
               screensM.screenBattleResult.XPTotal = param2;
               _loc7_ = _loc5_.gold + param1 + param3;
               _loc8_ = _loc5_.XP + param2;
               if(this._battleResult == "youWon" && dataM.gameType != BMDataManager.GAME_TYPE_ONLINE)
               {
                  dataM.createComputerMechs = true;
               }
               if(dataM.playingVSComputer)
               {
                  if(_loc5_.level >= 2)
                  {
                     switch(this._battleResult)
                     {
                        case "youWon":
                           ++_loc5_.winningStreakVSComputer;
                           ++_loc5_.winningStreakVSComputerThisLevel;
                           _loc5_.losingStreakVSComputer = 0;
                           if(_loc5_.winningStreakVSComputerThisLevel >= 2)
                           {
                              ++_loc5_.computerLevelAddon;
                              _loc5_.winningStreakVSComputerThisLevel = 0;
                           }
                           break;
                        case "youLost":
                           _loc5_.winningStreakVSComputer = 0;
                           _loc5_.winningStreakVSComputerThisLevel = 0;
                           ++_loc5_.losingStreakVSComputer;
                           if(_loc5_.losingStreakVSComputer >= 1)
                           {
                              --_loc5_.computerLevelAddon;
                              _loc9_ = 0;
                              if(_loc5_.levelByItems <= 5)
                              {
                                 _loc9_ = -1;
                              }
                              else if(_loc5_.levelByItems <= 10)
                              {
                                 _loc9_ = -2;
                              }
                              else if(_loc5_.levelByItems <= 15)
                              {
                                 _loc9_ = -3;
                              }
                              else if(_loc5_.levelByItems <= 20)
                              {
                                 _loc9_ = -4;
                              }
                              else if(_loc5_.levelByItems <= 30)
                              {
                                 _loc9_ = -5;
                              }
                              else
                              {
                                 _loc9_ = -6;
                              }
                              if(_loc5_.computerLevelAddon < _loc9_)
                              {
                                 _loc5_.computerLevelAddon = _loc9_;
                              }
                              _loc5_.losingStreakVSComputer = 0;
                           }
                     }
                  }
                  dataM.savePerUserSharedObjectData();
               }
               this.battleResultSuccess(_loc7_,param3,param4,_loc8_,_loc5_.overallRank,_loc5_.ladderProgress);
            }
         }
      }
      
      public function battleIsOver(param1:String) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:BMPlayerData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         switch(this._battleResult)
         {
            case "youWon":
               _loc2_ = 1;
               _loc3_ = dataM.player1PlayerID;
               break;
            case "youLost":
               _loc2_ = 2;
               _loc3_ = dataM.player2PlayerID;
               break;
            case "opponentQuit":
               _loc3_ = 0;
         }
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_REPLAY:
               screensM.screenConfirmation.displayQuestionOrNotification("replayEnded_battleOver",_loc2_,-1);
               break;
            default:
               if(_loc3_ == dataM.player1PlayerID)
               {
                  _loc4_ = dataM.playersData[_loc3_];
                  _loc5_ = this.getMechSlot(_loc3_);
                  _loc6_ = this._mechBattleDatas[_loc5_];
                  this.activateWinningTease(_loc6_.mechView,this.winningTeaseEnded);
               }
               else
               {
                  this.winningTeaseEnded();
               }
         }
      }
      
      private function activateWinningTease(param1:BMMechView, param2:Function) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc3_ = false;
         if(dataM.battleType == "mission")
         {
            switch(dataM.battleSubType)
            {
               case "jeep":
               case "tank":
                  _loc3_ = true;
            }
         }
         if(param1.shutDownActive)
         {
            _loc3_ = true;
         }
         if(_loc3_ == false)
         {
            _loc4_ = Math.ceil(Math.random() * 3);
            if(_loc4_ == 1)
            {
               _loc5_ = Math.ceil(Math.random() * 4);
               switch(_loc5_)
               {
                  case 1:
                     param1.activateTease2(param2);
                     break;
                  case 2:
                     param1.activateTease7(param2);
                     break;
                  case 3:
                     param1.activateTease8(param2);
                     break;
                  case 4:
                     param1.activateTease9(param2,true);
               }
            }
            else
            {
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            param2();
         }
      }
      
      private function winningTeaseEnded() : void
      {
         if(dataM.playingVSComputer)
         {
            this.finishBattleVSComputer();
         }
         else if(this._battleResult_available)
         {
            this.battleResultSuccess(this._battleResult_newGold,this._battleResult_goldFromLevelUp,this._battleResult_tokensFromLevelUp,this._battleResult_newXP,this._battleResult_newRank,this._battleResult_newLadderProgress);
         }
         else
         {
            this._battleResult_triggerOnSpot = true;
         }
      }
      
      public function battleResultSuccess(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this.hideInterface("battleResultSuccess");
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
         {
            screensM.screenBattleInterfaceTop.disableTimer();
         }
         if(this._battleResult_triggerOnSpot || this._battleResult_available || (dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.playingVSComputer))
         {
            this.battleResultSuccessSub(param1,param2,param3,param4,param5,param6);
         }
         else
         {
            this._battleResult_available = true;
            this._battleResult_newGold = param1;
            this._battleResult_goldFromLevelUp = param2;
            this._battleResult_tokensFromLevelUp = param3;
            this._battleResult_newXP = param4;
            this._battleResult_newRank = param5;
            this._battleResult_newLadderProgress = param6;
         }
      }
      
      private function battleResultSuccessSub(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:BMPlayerProfile = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Boolean = false;
         var _loc19_:BMPlayerProfile = null;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:uint = 0;
         var _loc25_:Boolean = false;
         _loc7_ = false;
         _loc8_ = false;
         _loc9_ = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false && dataM.battle_inBattleInvitation == false)
         {
            _loc7_ = true;
         }
         _loc10_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc10_.lastGoldGained = param1 - param2 - _loc10_.gold;
         _loc10_.gold = param1;
         _loc10_.totalGoldGained += _loc10_.lastGoldGained;
         _loc10_.tokens += param3;
         _loc10_.tokens_bonus += param3;
         _loc10_.lastGoldFromLevelUp = param2;
         _loc10_.lastTokensFromLevelUp = param3;
         _loc10_.lastXPGained = param4 - _loc10_.XP;
         _loc10_.XP = param4;
         _loc10_.overallRank = param5;
         _loc10_.lastLadderProgress = _loc10_.ladderProgress;
         _loc10_.ladderProgress = param6;
         dataM.resetRankingListTimer = true;
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
         {
            if(dataM.battle_inBattleInvitation)
            {
               _loc8_ = true;
            }
            else
            {
               _loc11_ = 1;
               if(this._battleResult == "opponentQuit")
               {
                  if(this._turn - 1 < dataM.turnsForQuitPenalty)
                  {
                     _loc11_ = (this._turn - 1) / dataM.turnsForQuitPenalty;
                  }
               }
               _loc12_ = 0;
               _loc13_ = 0;
               _loc14_ = 0;
               _loc15_ = 0;
               _loc16_ = 0;
               _loc17_ = 0;
               screensM.addScreen("screenBattleResult",false);
               screensM.screenBattleResult.resetRewardParameters();
               _loc18_ = false;
               _loc19_ = dataM["player" + dataM.player2PlayerID + "Profile"];
               if(dataM.premiumAccountTime > dataM.currentTime)
               {
                  _loc18_ = true;
                  screensM.screenBattleResult.goldAccount = 2;
                  screensM.screenBattleResult.XPAccount = 2;
               }
               _loc20_ = _loc19_.levelByItems - _loc10_.levelByItems;
               if(_loc10_.lastGoldGained == 0)
               {
                  if(Math.abs(_loc20_) <= 5)
                  {
                     _loc9_ = true;
                  }
               }
               if(_loc20_ > 5)
               {
                  _loc20_ = 5;
               }
               else if(_loc20_ < -5)
               {
                  _loc20_ = -5;
               }
               _loc12_ = Math.ceil((1000 + (_loc10_.levelByItems - 1) * 50) * _loc11_);
               _loc15_ = Math.ceil(100 * _loc11_);
               if(_loc20_ > 0)
               {
                  _loc13_ = Math.ceil(_loc20_ * 100 * _loc11_);
                  _loc16_ = Math.ceil(_loc20_ * 25 * _loc11_);
               }
               else
               {
                  _loc13_ = Math.ceil(_loc20_ * 50 * _loc11_);
                  _loc16_ = Math.ceil(_loc20_ * 10 * _loc11_);
               }
               _loc21_ = 0.25;
               if(this._battleResult == "youLost")
               {
                  _loc12_ = Math.ceil(_loc12_ * _loc21_);
                  _loc13_ = Math.ceil(_loc13_ * _loc21_);
                  _loc15_ = Math.ceil(_loc15_ * _loc21_);
                  _loc16_ = Math.ceil(_loc16_ * _loc21_);
               }
               _loc14_ = _loc10_.lastGoldGained;
               _loc17_ = _loc10_.lastXPGained;
               if(dataM.battle_inBattleInvitation)
               {
                  _loc22_ = 0.5;
                  _loc12_ = Math.ceil(_loc12_ * _loc22_);
                  _loc13_ = Math.ceil(_loc13_ * _loc22_);
                  _loc15_ = Math.ceil(_loc15_ * _loc22_);
                  _loc16_ = Math.ceil(_loc16_ * _loc22_);
               }
               if(_loc14_ == 0)
               {
                  _loc12_ = 0;
                  _loc13_ = 0;
               }
               else if(_loc18_)
               {
                  if(_loc14_ != 2 * (_loc12_ + _loc13_))
                  {
                     _loc12_ -= Math.ceil(_loc12_ + _loc13_ - _loc14_ / 2);
                  }
               }
               else if(_loc14_ != _loc12_ + _loc13_)
               {
                  _loc12_ -= _loc12_ + _loc13_ - _loc14_;
               }
               if(_loc17_ == 0)
               {
                  _loc15_ = 0;
                  _loc16_ = 0;
               }
               else if(_loc18_)
               {
                  if(_loc17_ != 2 * (_loc15_ + _loc16_))
                  {
                     _loc15_ -= Math.ceil(_loc15_ + _loc16_ - _loc17_ / 2);
                  }
               }
               else if(_loc17_ != _loc15_ + _loc16_)
               {
                  _loc15_ -= _loc15_ + _loc16_ - _loc17_;
               }
               screensM.screenBattleResult.goldResult = _loc12_;
               screensM.screenBattleResult.goldLevelDifference = _loc13_;
               screensM.screenBattleResult.goldTotal = _loc14_;
               screensM.screenBattleResult.XPResult = _loc15_;
               screensM.screenBattleResult.XPLevelDifference = _loc16_;
               screensM.screenBattleResult.XPTotal = _loc17_;
            }
         }
         if(dataM.battle_inBattleInvitation == false)
         {
            _loc23_ = 0;
            _loc24_ = 0;
            while(_loc24_ < dataM.levelUpDB.length)
            {
               if(_loc10_.XP < dataM.levelUpDB[_loc24_])
               {
                  _loc24_ = dataM.levelUpDB.length;
               }
               else
               {
                  _loc23_ = _loc24_;
               }
               _loc24_++;
            }
            _loc10_.lastLevel = _loc10_.level;
            _loc10_.level = _loc23_;
            if(_loc10_.level > _loc10_.lastLevel)
            {
            }
            if(_loc10_.level >= 7 && _loc10_.level > _loc10_.lastLevel)
            {
               --_loc10_.computerLevelAddon;
            }
         }
         _loc10_.lastBattleResult = this._battleResult;
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            if(_loc10_.level > _loc10_.lastLevel)
            {
               if(_loc10_.tutorialLevel >= BMDataManager.TUTORIAL_LEVEL_MISSION1 && dataM.isTutorialActive())
               {
                  dataM.topBar_levelUpInProgress = true;
               }
            }
            if(this._battleResult == "youWon" || this._battleResult == "opponentQuit")
            {
               if(dataM.playingVSComputer)
               {
                  ++_loc10_.winsVSComputer;
                  if(_loc10_.winsVSComputer == 1)
                  {
                     this._giveTutorialItems = true;
                  }
               }
               else
               {
                  ++_loc10_.onlineBattles;
                  ++_loc10_.onlineWins;
                  if(_loc10_.achievementsStatistics != null)
                  {
                     if(_loc10_.achievementsStatistics.ladderWins != null)
                     {
                        ++_loc10_.achievementsStatistics.ladderWins;
                     }
                  }
                  if(_loc7_)
                  {
                     if(_loc10_.winLossStreak < 1)
                     {
                        _loc10_.winLossStreak = 1;
                     }
                     else
                     {
                        ++_loc10_.winLossStreak;
                     }
                  }
               }
               _loc10_.updateWinsTotal();
            }
            else
            {
               if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
               {
                  ++_loc10_.onlineBattles;
               }
               if(_loc7_ && this._battleResult == "youLost")
               {
                  if(_loc10_.winLossStreak > -1)
                  {
                     _loc10_.winLossStreak = -1;
                  }
                  else
                  {
                     --_loc10_.winLossStreak;
                  }
               }
            }
         }
         tooltip.hideToolTip();
         if(_loc9_)
         {
            _loc25_ = false;
            if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false && dataM.battle_inBattleInvitation == false)
            {
               _loc25_ = true;
            }
            if(_loc25_)
            {
               screensM.addScreen("screenLadderStatus");
               screensM.screenLadderStatus.refreshScreen();
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("opponentQuitOnFirstRoundNoReward",-1,-1);
            }
         }
         else if(_loc8_)
         {
            screensM.screenBlack.activateBlackScreen(this.endPrivateBattle,true,true,null,0);
         }
         else
         {
            screensM.addScreen("screenBattleResult");
            screensM.screenBattleResult.refreshScreen();
         }
         this.sendEndBattleAnalyticsEvent();
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            if(dataM.isTutorialActive())
            {
               if(_loc10_.missionID == 0 && dataM.getTutorialDestination() == BMDataManager.TUTORIAL_DESTINATION_LONE_BATTLE)
               {
                  dataM.setTutorialLevel(_loc10_.tutorialLevel + 1,"screenBattle battleResultSuccessSub");
               }
            }
         }
         this.disableScreenAfterBattleHasEnded();
      }
      
      private function sendEndBattleAnalyticsEvent() : *
      {
         var _loc1_:String = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         _loc1_ = "Ladder";
         _loc2_ = NaN;
         if(dataM.playingVSComputer)
         {
            if(dataM.isTutorialActive())
            {
               _loc1_ = "Tutorial";
               _loc2_ = dataM.myProfile.tutorialLevel;
            }
            else
            {
               _loc1_ = dataM.battleType;
               _loc2_ = dataM.myProfile.currentMissionSlot + 1;
            }
         }
         else if(dataM.battle_inBattleInvitation)
         {
            _loc1_ = "Private";
         }
         else
         {
            _loc1_ = "Ladder";
            _loc2_ = dataM.getLadderRankByProgress(dataM.myProfile.ladderProgress);
         }
         _loc3_ = this._battleResult;
         dataM.trackEvent("Battle",_loc3_,_loc1_,_loc2_);
      }
      
      private function endPrivateBattle() : void
      {
         screensM.removeScreen("screenConfirmation");
         this.cleanBattle(false);
      }
      
      private function disableScreenAfterBattleHasEnded() : void
      {
         screensM.screenBattleInterfaceTop.disableTimer();
         this._battleEnabled = false;
         this.hideInterface("disableScreenAfterBattleHasEnded");
         screensM.screenBattleInterfaceTop.btnZoomIn.visible = false;
         screensM.screenBattleInterfaceTop.btnZoomOut.visible = false;
         screensM.screenBattleInterfaceTop.btnQuit.visible = false;
      }
      
      public function challengeDone_damage() : void
      {
         var _loc1_:BMMechBattleData = null;
         screensM.screenBattleInterfaceTop.refreshTurnsLeft(0);
         this.deactivateGetHitSounds();
         _loc1_ = this._mechBattleDatas[this.getMechSlot(dataM.player2PlayerID)];
         _loc1_.mechView.activateExit1(this.challengeDone_damage_exitEnded);
      }
      
      public function challengeDone_damage_exitEnded() : void
      {
         var _loc1_:BMMechBattleData = null;
         _loc1_ = this._mechBattleDatas[this.getMechSlot(dataM.player1PlayerID)];
         this.activateWinningTease(_loc1_.mechView,this.challengeDone_damage_teaseEnded);
      }
      
      public function challengeDone_damage_teaseEnded() : void
      {
         var _loc1_:String = null;
         var _loc2_:BMMechBattleData = null;
         var _loc3_:Number = NaN;
         _loc1_ = this.getMechSlot(dataM.player1PlayerID);
         _loc2_ = this._mechBattleDatas[_loc1_];
         _loc3_ = Math.ceil(this._challengeDamageTotalDamage / _loc2_.HPMax * 100);
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         else if(_loc3_ > 200)
         {
            _loc3_ = 200;
         }
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_GUEST:
               this.finishBattleVSComputerLocally(true,_loc3_);
               break;
            case BMDataManager.GAME_TYPE_ONLINE:
               remoteM.lobby_finishBattleVSComputer(true,false,true,dataM.battleType,dataM.battleSubType,_loc3_,dataM.campaignBattleDifficulty,dataM.computerBattleID,this._battleReport,0);
         }
      }
      
      public function challengeIsOver() : void
      {
         screensM.screenBlack.activateBlackScreen(this.cleanBattle,true,true,[false],0);
      }
      
      public function showFinishMovesInterface() : void
      {
         screensM.screenBattleInterfaceBottom.showSpecificInterfaceType("finish");
         this.showInterface("showFinishMovesInterface");
         this.enableInterface("screenBattle takeDamage finishMoves");
      }
      
      public function activateFinishMove(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMMechView = null;
         var _loc7_:String = null;
         var _loc8_:BMMechBattleData = null;
         var _loc9_:BMMechView = null;
         var _loc10_:BMPlayerItemData = null;
         var _loc11_:BMItemData = null;
         var _loc12_:Object = null;
         var _loc13_:Number = NaN;
         var _loc14_:uint = 0;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:String = null;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:String = null;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:MovieClip = null;
         var _loc27_:MovieClip = null;
         var _loc28_:Point = null;
         var _loc29_:Point = null;
         var _loc30_:Point = null;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         _loc5_ = _loc4_.mechView;
         var _loc6_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc7_ = this.getMechSlot(this._opponentPlayerID);
         _loc8_ = this._mechBattleDatas[_loc7_];
         _loc9_ = _loc8_.mechView;
         this._finishMoveID = param1;
         switch(this._finishMoveID)
         {
            case 1:
               _loc5_.activateFinish1(_loc9_.x,this.finish1AnimationEnded);
               break;
            case 2:
               _loc16_ = _loc5_.x;
               _loc17_ = _loc5_.y + 30;
               _loc18_ = _loc5_.mechSizer.width * 1.8;
               if(_loc18_ > 400)
               {
                  _loc18_ = 400;
               }
               _loc19_ = "";
               if(dataM.slowCPUMode)
               {
                  _loc19_ = "_fast";
               }
               effectsM.createTeleportDisappear("teleportDisappearAnim",_loc16_,_loc17_,_loc18_,this.finish2AnimationEnded,null,this.holder_effects);
               soundM.createSound("teleportDisappear",1);
               break;
            case 3:
               _loc20_ = Math.abs(_loc4_.currentStepVisual - _loc8_.currentStepVisual);
               _loc21_ = (_loc20_ - 0.7) * this.FLOOR_STEP_SIZE;
               _loc22_ = (_loc20_ - 1.7) * this.FLOOR_STEP_SIZE;
               _loc23_ = "left";
               if(_loc4_.currentStepVisual > _loc8_.currentStepVisual)
               {
                  _loc23_ = "right";
               }
               _loc4_.launchHarpoon("finish",_loc21_,_loc22_,_loc23_,_loc8_,this.finish3harpoonReachedTarget,this.finish3AnimationEnded);
               break;
            case 4:
               _loc24_ = _loc8_.mechView.x;
               _loc4_.charge(_loc24_,this.finish4ChargingAnimationEnded);
               soundM.createSound("charge",1);
               break;
            case 5:
               if(Math.abs(_loc4_.currentStepCode - _loc8_.currentStepCode) > 1)
               {
                  this.moveMechBeforeFinish();
               }
               else
               {
                  _loc13_ = 0;
                  _loc14_ = 1;
                  while(_loc14_ <= dataM.maxEquipment["sideWeapon"])
                  {
                     _loc15_ = Number(_loc4_.mechStructure["sideWeapon" + _loc14_]);
                     if(_loc15_ > 0)
                     {
                        _loc10_ = dataM.getPlayerItemData(this._currentPlayerID,_loc15_);
                        _loc11_ = dataM.itemsDB[_loc10_.itemID];
                        _loc12_ = dataM.animationDB[_loc11_.animation];
                        if(_loc12_.effectType == "flame")
                        {
                           _loc13_ = _loc14_;
                           _loc14_ = uint(dataM.maxEquipment["sideWeapon"]);
                        }
                     }
                     _loc14_++;
                  }
                  _loc26_ = _loc5_["sideWeapon" + _loc13_].item.itemGrp;
                  _loc27_ = _loc26_.mcFire1;
                  _loc28_ = new Point(_loc27_.x,_loc27_.y);
                  _loc29_ = _loc26_.localToGlobal(_loc28_);
                  _loc30_ = this.holder_main.globalToLocal(_loc29_);
                  _loc31_ = this.FLOOR_STEP_SIZE;
                  if(_loc11_.rangeAddon > 1)
                  {
                     _loc31_ = 1.75 * this.FLOOR_STEP_SIZE;
                  }
                  effectsM.activateFlameThrower(this._opponentPlayerID,_loc30_.x,_loc30_.y,_loc5_.scaleX,_loc31_,_loc12_.fireEffect,this.activateGetHit,null,null);
                  soundM.createSound("flameThrower",1);
                  _loc9_.activateOverheat(75,this.finish5AnimationEnded);
               }
               break;
            case 6:
               this.stompClicked();
               break;
            case 7:
               _loc13_ = 0;
               _loc14_ = 1;
               while(_loc14_ <= dataM.maxEquipment["sideWeapon"])
               {
                  _loc15_ = Number(_loc4_.mechStructure["sideWeapon" + _loc14_]);
                  if(_loc15_ > 0)
                  {
                     _loc10_ = dataM.getPlayerItemData(this._currentPlayerID,_loc15_);
                     _loc11_ = dataM.itemsDB[_loc10_.itemID];
                     _loc12_ = dataM.animationDB[_loc11_.animation];
                     if(_loc12_.effectType == "sword")
                     {
                        _loc13_ = _loc14_;
                        _loc14_ = uint(dataM.maxEquipment["sideWeapon"]);
                     }
                  }
                  _loc14_++;
               }
               if(_loc4_.currentStepCode > _loc8_.currentStepCode)
               {
                  _loc25_ = (_loc8_.currentStepCode + 1 + 0.5) * this.FLOOR_STEP_SIZE;
               }
               else
               {
                  _loc25_ = (_loc8_.currentStepCode - 1 + 0.5) * this.FLOOR_STEP_SIZE;
               }
               _loc5_.activateFinish7(_loc13_,_loc25_,this.finish7AnimationEnded);
               break;
            case 8:
               if(_loc4_.droneActive)
               {
                  _loc32_ = _loc9_.x - _loc4_.drone.droneGrp.x;
                  _loc33_ = _loc9_.y - _loc4_.drone.droneGrp.y;
                  _loc4_.drone.activateFinishMove(_loc32_,_loc33_);
                  soundM.createSound("droneOn",1);
               }
         }
         this.disableInterface("screenBattle activateFinishMove");
         this.hideInterface("screenBattle activateFinishMove");
      }
      
      private function moveMechBeforeFinish() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc7_ = dataM.getPlayerItemData(this._currentPlayerID,_loc3_.mechStructure.leg);
         _loc8_ = dataM.itemsDB[_loc7_.itemID];
         _loc9_ = "walk";
         if(_loc8_.subType == "legs")
         {
            _loc9_ = "jump";
         }
         _loc10_ = _loc6_.currentStepCode + 1;
         if(_loc3_.currentStepCode < _loc6_.currentStepCode)
         {
            _loc10_ = _loc6_.currentStepCode - 1;
         }
         _loc10_ = dataM.getClientInvertedStep(_loc10_);
         this.activateNextBattlePhase("action_moveMechToStepSuccess",{
            "motionType":_loc9_,
            "targetStep":_loc10_
         });
      }
      
      private function finish1AnimationEnded() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.mechView;
         effectsM.createGeneralEffect(this.holder_effects,"stompLegHit1",false,0,0,_loc4_.x,0,0,null,[]);
         effectsM.createStompFire(this.holder_effects,"stompFire1",_loc4_.x,0,60,6,1,false);
         effectsM.createStompFire(this.holder_effects,"stompFire1",_loc4_.x,0,60,6,1,true);
         soundM.createSound("footStep",1);
         this._waitingForFinishMove = false;
         this.destroyDefendingMech(2,0);
         this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
         this.refreshMechCodeStepMarker(1);
         this.refreshMechCodeStepMarker(2);
      }
      
      private function finish2AnimationEnded() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         var _loc6_:String = null;
         var _loc7_:BMMechBattleData = null;
         var _loc8_:BMMechView = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.mechView;
         var _loc5_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc6_ = this.getMechSlot(this._opponentPlayerID);
         _loc7_ = this._mechBattleDatas[_loc6_];
         _loc8_ = _loc7_.mechView;
         _loc4_.x = _loc8_.x;
         _loc9_ = _loc4_.mechSizer.width * 1.8;
         if(_loc9_ > 400)
         {
            _loc9_ = 400;
         }
         _loc10_ = _loc4_.x;
         _loc11_ = _loc4_.y + 30;
         var _loc12_:String = "";
         if(dataM.slowCPUMode)
         {
            _loc12_ = "_fast";
         }
         effectsM.createTeleportReappear("teleportReappearAnim",_loc10_,_loc11_,_loc9_,this.holder_effects);
         effectsM.createStompFire(this.holder_effects,"teleportFire1",_loc4_.x,0,60,6,1,false);
         effectsM.createStompFire(this.holder_effects,"teleportFire1",_loc4_.x,0,60,6,1,true);
         this._waitingForFinishMove = false;
         this.destroyDefendingMech(2,0);
         this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
         this.refreshMechCodeStepMarker(1);
         this.refreshMechCodeStepMarker(2);
      }
      
      private function finish3harpoonReachedTarget() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc2_ = this.getMechSlot(this._opponentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.mechView;
         _loc3_.heat = Math.ceil(_loc3_.heatMax * 1.5);
         screensM.screenBattleInterfaceTop.refreshHeat(this._opponentPlayerID,true);
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(dataM.getInterfacePlayerID(this._opponentPlayerID));
         _loc4_.activateOverheat(50,this.finish3OpponentOverheated);
      }
      
      private function finish3OpponentOverheated() : void
      {
         this._waitingForFinishMove = false;
         this.destroyDefendingMech(2,0);
      }
      
      private function finish3AnimationEnded() : void
      {
      }
      
      private function finish4ChargingAnimationEnded() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc6_:String = null;
         var _loc7_:BMMechBattleData = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMMechView = _loc3_.mechView;
         var _loc5_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc6_ = this.getMechSlot(this._opponentPlayerID);
         _loc7_ = this._mechBattleDatas[_loc6_];
         var _loc8_:BMMechView = _loc7_.mechView;
         this.pushMech(this._opponentPlayerID,this._currentPlayerID,1,false,_loc3_.currentStepCode,_loc7_.currentStepCode,true);
         this.createEarthQuake();
         this.createGetHitSound();
         this._waitingForFinishMove = false;
         this.destroyDefendingMech(2,0);
      }
      
      private function finish5AnimationEnded() : void
      {
         this._waitingForFinishMove = false;
         this.destroyDefendingMech(2,0);
      }
      
      public function stompFinishAnimDone() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         var _loc6_:String = null;
         var _loc7_:BMMechBattleData = null;
         var _loc8_:BMMechView = null;
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.mechView;
         var _loc5_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc6_ = this.getMechSlot(this._opponentPlayerID);
         _loc7_ = this._mechBattleDatas[_loc6_];
         _loc8_ = _loc7_.mechView;
         _loc9_ = false;
         if(_loc3_.currentStepCode > _loc7_.currentStepCode)
         {
            _loc9_ = true;
         }
         effectsM.createGeneralEffect(this.holder_effects,"stompLegHit1",false,0,0,_loc4_.x,0,0,null,[]);
         effectsM.createStompFire(this.holder_effects,"stompFinish1",_loc4_.x,0,70,1,24,_loc9_);
         _loc10_ = Math.abs(_loc4_.x - _loc8_.x);
         _loc11_ = 1400 / 25;
         _loc12_ = Math.floor(_loc10_ / _loc11_);
         this.createEarthQuake();
         soundM.createSound("footStep",1);
         this._waitingForFinishMove = false;
         this.destroyDefendingMech(2,_loc12_);
      }
      
      private function finish7AnimationEnded() : void
      {
         this._waitingForFinishMove = false;
         this.createGetHitSound();
         this.destroyDefendingMech(2,0);
      }
      
      public function finish8AnimationEnded() : void
      {
         this._waitingForFinishMove = false;
         this.createGetHitSound();
         this.destroyDefendingMech(2,0);
      }
      
      private function activateFinishBackgroundDarkness() : void
      {
         if(dataM.runAsMobile == false)
         {
            this._finishBackgroundDarknessHandler = true;
            this._finishBackgroundCountdown = 0;
         }
      }
      
      private function finishBackgroundDarknessHandler() : void
      {
         var _loc1_:Color = null;
         var _loc2_:Number = NaN;
         if(this._finishBackgroundDarknessHandler)
         {
            ++this._finishBackgroundCountdown;
            _loc1_ = new Color();
            _loc2_ = this._finishBackgroundCountdown / 10;
            _loc1_.setTint(0,_loc2_);
            this.holder_backgroundFloor.transform.colorTransform = _loc1_;
            this.holder_backgrounds.transform.colorTransform = _loc1_;
            if(this._finishBackgroundCountdown == 5)
            {
               this._finishBackgroundDarknessHandler = false;
            }
         }
      }
      
      private function resetBackgroundDarkness() : void
      {
         this.holder_backgroundFloor.transform.colorTransform = new ColorTransform();
         this.holder_backgrounds.transform.colorTransform = new ColorTransform();
      }
      
      private function turnEnded() : void
      {
         var _loc1_:Boolean = false;
         _loc1_ = false;
         if(dataM.battleType == "challenge")
         {
            if(dataM.battleSubType == "damage")
            {
               _loc1_ = true;
            }
         }
         if(_loc1_ && this._turn == this.CHALLENGE_DAMAGE_TURNS)
         {
            this.challengeDone_damage();
         }
         else
         {
            this.startNewTurn();
         }
      }
      
      private function endTurnSuccess(param1:Boolean, param2:Boolean, param3:String = "") : void
      {
         var _loc4_:Boolean = false;
         screensM.screenBattleInterfaceTop.deactivateTurnOwnerMessage();
         this._timerNotice = false;
         this._totalDamageInCurrentTurn = 0;
         _loc4_ = false;
         if(dataM.battleType == "challenge")
         {
            if(dataM.battleSubType == "damage")
            {
               _loc4_ = true;
            }
         }
         if(this._currentPlayerID == dataM.player2PlayerID || _loc4_)
         {
            this._currentPlayerID = dataM.player1PlayerID;
            this._opponentPlayerID = dataM.player2PlayerID;
            this.activateMechTeaseAnimation();
         }
         else
         {
            this._currentPlayerID = dataM.player2PlayerID;
            this._opponentPlayerID = dataM.player1PlayerID;
            this.hideInterface("endTurnSuccess");
            this.deactivateMechTeaseAnimation();
            this._skipStartNewActionEnbaleInterface = false;
         }
         this._currentPlayerInterfacePlayerID = dataM.getInterfacePlayerID(this._currentPlayerID);
         this._opponentPlayerInterfacePlayerID = dataM.getInterfacePlayerID(this._opponentPlayerID);
         if(param2 == false)
         {
            if(param1)
            {
               this._endTurnFrameCounter = 0;
               this._endTurnDelayHandler = true;
            }
            else
            {
               this.turnEnded();
            }
         }
      }
      
      private function endTurnDelayHandler() : void
      {
         var _loc1_:Number = NaN;
         if(this._endTurnDelayHandler)
         {
            ++this._endTurnFrameCounter;
            _loc1_ = this.DELAY_NEW_ACTION_FRAMES_END_TURN;
            if(dataM.slowCPUMode)
            {
               _loc1_ = Math.ceil(_loc1_ / 2);
            }
            if(this._endTurnFrameCounter > _loc1_)
            {
               this._endTurnDelayHandler = false;
               this.turnEnded();
            }
         }
      }
      
      public function notMyTurn() : void
      {
         this.hideInterface("notMyTurn");
      }
      
      public function returnToLobbyClicked(param1:Boolean) : void
      {
         this._goToPremiumAccount = param1;
         this.returnToLobbySuccess();
      }
      
      public function returnToLobbyLocally() : void
      {
         this.returnToLobbySuccess();
      }
      
      public function returnToLobbySuccess() : void
      {
         screensM.screenBlack.activateBlackScreen(this.cleanBattle,true,true,[false],0);
      }
      
      public function cleanBattle(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         keyboardM.deactivateMe();
         screensM.screenBattleInterfaceTop.disableTimer();
         this.cleanBattleField();
         effectsM.abortGeneralEffects();
         _loc2_ = dataM.playingVSComputer;
         this._skipStartNewActionEnbaleInterface = false;
         if(!param1)
         {
            switch(dataM.gameType)
            {
               case BMDataManager.GAME_TYPE_GUEST:
                  if(this._giveTutorialItems)
                  {
                     _loc3_ = 20;
                     dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,dataM.TUTORIAL_BUY_TORSO1_ID,0,0,0,0);
                     dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,dataM.TUTORIAL_BUY_SIDE_WEAPON1_ID,0,0,0,0);
                     dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,dataM.TUTORIAL_BUY_TORSO2_ID,0,0,0,_loc3_);
                     dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,dataM.TUTORIAL_BUY_SIDE_WEAPON2_ID,0,0,0,0);
                     dataM.hanger_newItemsForDisplay = new Array();
                     dataM.hanger_newItemsForDisplay.push(dataM.TUTORIAL_BUY_TORSO1_ID);
                     dataM.hanger_newItemsForDisplay.push(dataM.TUTORIAL_BUY_SIDE_WEAPON1_ID);
                     dataM.hanger_newItemsForDisplay.push(dataM.TUTORIAL_BUY_TORSO2_ID);
                     dataM.hanger_newItemsForDisplay.push(dataM.TUTORIAL_BUY_SIDE_WEAPON2_ID);
                     dataM.saveGuestData("battle cleanBattle");
                     this._giveTutorialItems = false;
                  }
                  dataM.battle_afterBattleFunctions(_loc2_);
                  screensM.screenBattleInterfaceTop.clearOpponentModules();
                  if(screensM.isScreenOpened("screenBattleResult"))
                  {
                     screensM.screenBattleResult.removeMe();
                  }
                  break;
               case BMDataManager.GAME_TYPE_ONLINE:
                  if(this._giveTutorialItems)
                  {
                     remoteM.lobby_addItemsForNewPlayer();
                     this._giveTutorialItems = false;
                     screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
                  }
                  else
                  {
                     dataM.battle_afterBattleFunctions(_loc2_);
                     screensM.screenBattleInterfaceTop.clearOpponentModules();
                  }
                  if(screensM.isScreenOpened("screenBattleResult"))
                  {
                     screensM.screenBattleResult.removeMe();
                  }
                  break;
               case BMDataManager.GAME_TYPE_REPLAY:
                  switch(dataM.gameSubType)
                  {
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_REGULAR:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_ONLINE);
                        screensM.screenNewMenu.profileReplaysClicked(true);
                        dataM.savePerUserSharedObjectData();
                        break;
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_RANKING_LIST_INSPECT:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_ONLINE);
                        dataM.rankingList_gettingBackToRankingListFromAReplay = true;
                        screensM.screenNewMenu.communityRankingListClicked(true);
                        screensM.addScreen("screenInspectPlayer");
                        screensM.screenInspectPlayer.refreshScreenWithLastData();
                        dataM.savePerUserSharedObjectData();
                        break;
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_MENU_CHAT_INSPECT:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_ONLINE);
                        screensM.screenNewMenu.multiplayerChatClicked(true,false);
                        screensM.addScreen("screenInspectPlayer");
                        screensM.screenInspectPlayer.refreshScreenWithLastData();
                        screensM.screenTopBar.activateManualBattleCreditsDisplay();
                        dataM.savePerUserSharedObjectData();
                        break;
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_CLAN_INSPECT:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_ONLINE);
                        screensM.screenNewMenu.communityClanClicked(true);
                        screensM.addScreen("screenInspectPlayer");
                        screensM.screenInspectPlayer.refreshScreenWithLastData();
                        dataM.savePerUserSharedObjectData();
                        break;
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_SMTV:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_ONLINE);
                        screensM.screenNewMenu.multiplayerLadderClicked(true,false);
                        dataM.savePerUserSharedObjectData();
                        screensM.screenTopBar.activateManualBattleCreditsDisplay();
                  }
            }
         }
         dataM.playingVSComputer = false;
         dataM.battleType = "none";
         dataM.battle_inBattleInvitation = false;
         dataM.battle_clientInverted = false;
         dataM.battle_gamePaused = false;
         dataM.battle_replayData = new Object();
         screensM.screenBattleInterfaceTop.removeAvatarImage(1);
         screensM.screenBattleInterfaceTop.removeAvatarImage(2);
         screensM.screenBattleInterfaceTop.removeAvatarItem(1);
         screensM.screenBattleInterfaceTop.removeAvatarItem(2);
         screensM.screenBattleInterfaceTop.mcPlayer1ChatBubble.closeMessage(true);
         screensM.screenBattleInterfaceTop.mcPlayer2ChatBubble.closeMessage(true);
         if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            screensM.screenBattleInterfaceBottom.cancelMoveToStepSelectionClicked(true);
            screensM.screenBattleInterfaceBottom.deleteMechPictures();
         }
         screensM.screenBattleInterfaceTop.removeMe();
         screensM.removeScreen("screenBattle");
         screensM.removeScreen("screenBattleInterfaceBottom");
         screensM.removeScreen("screenBattleInterfaceEmotes");
         if(screensM.isScreenOpened("screenBattleResult"))
         {
            screensM.screenBattleResult.removeMe();
         }
         tooltip.hideToolTip();
         soundM.removeAllMusic();
      }
      
      public function opponentQuitBattle() : void
      {
         this.disableInterface("opponentQuitBattle");
         this._battleEnabled = false;
         this._battleResult = "opponentQuit";
         this.battleIsOver("opponentQuitBattle");
      }
      
      public function quitClicked() : void
      {
         this.activateNextBattlePhase("endBattle_quit");
      }
      
      private function tryToQuitBattle() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         _loc1_ = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false && dataM.battle_inBattleInvitation == false)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("quitBattleVSPlayer",-1,-1);
         }
         else
         {
            _loc2_ = false;
            if(dataM.battleType == "mission")
            {
               if(this._turn > 1)
               {
                  _loc2_ = true;
               }
            }
            if(_loc2_)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("quitBattleVSMission",-1,-1);
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("quitBattleVSComputer",-1,-1);
            }
         }
         if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            screensM.screenBattleInterfaceBottom.cancelMoveToStepSelectionClicked();
         }
      }
      
      private function quitBattleVSPlayerConfirmed() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = null;
         this._battleResult = "playerQuit";
         _loc1_ = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false && dataM.battle_inBattleInvitation == false)
         {
            _loc1_ = true;
         }
         this.surrender();
         screensM.screenBattleInterfaceTop.btnQuit.disableMe();
         screensM.screenBattleInterfaceTop.btnZoomIn.disableMe();
         screensM.screenBattleInterfaceTop.btnZoomOut.disableMe();
         screensM.screenBattleInterfaceTop.btnOptions.disableMe();
         screensM.screenBattleInterfaceTop.btnEmotesOpen.disableMe();
         screensM.screenBattleInterfaceTop.btnEmotesClose.disableMe();
         screensM.screenBattleInterfaceTop.btnPauseReplay.disableMe();
         screensM.screenBattleInterfaceTop.btnPlayReplay.disableMe();
         screensM.screenBattleInterfaceEmotes.closeMe();
         screensM.screenConfirmation.displayQuestionOrNotification("exitingBattle",-1,-1);
         if(_loc1_)
         {
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc2_.winLossStreak > -1)
            {
               _loc2_.winLossStreak = -1;
            }
            else
            {
               --_loc2_.winLossStreak;
            }
         }
         soundM.removeAllMusic();
      }
      
      private function quitBattleVSComputerConfirmed() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:BMPlayerData = null;
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:BMPlayerProfile = null;
         this._battleResult = "playerQuit";
         _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         switch(dataM.battleType)
         {
            case "challenge":
               dataM.skipChallenge = true;
               break;
            case "mission":
               _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc3_ = dataM.playersData[dataM.player1PlayerID];
               _loc4_ = this.getMechSlot(dataM.player1PlayerID);
               _loc5_ = this._mechBattleDatas[_loc4_];
               dataM.mission_battleEnded = true;
               dataM.mission_battleEnded_playerWon = false;
               dataM.mission_battleEnded_hp = _loc5_.HP;
               dataM.mission_battleEnded_bullets = _loc5_.bullets;
               dataM.mission_battleEnded_rockets = _loc5_.rockets;
         }
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_GUEST:
               --_loc1_.battlesVSComputer;
               this.surrenderSuccess();
               break;
            case BMDataManager.GAME_TYPE_ONLINE:
               if(dataM.playingVSComputer)
               {
                  --_loc1_.battlesVSComputer;
                  this.surrenderSuccess();
                  _loc6_ = dataM["player" + dataM.player2PlayerID + "Profile"];
                  remoteM.lobby_finishBattleVSComputer(false,true,false,dataM.battleType,dataM.battleSubType,0,dataM.campaignBattleDifficulty,dataM.computerBattleID,this._battleReport,_loc6_.level);
               }
               else
               {
                  this.surrender();
                  screensM.screenConfirmation.displayQuestionOrNotification("exitingBattle",-1,-1);
               }
               break;
            case BMDataManager.GAME_TYPE_REPLAY:
               this.endReplay();
         }
         soundM.removeAllMusic();
      }
      
      public function quitCancelled() : void
      {
      }
      
      private function refreshMechCodeStepMarker(param1:Number) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         if(param1 == 1)
         {
            _loc2_ = dataM.player1PlayerID;
         }
         else
         {
            _loc2_ = dataM.player2PlayerID;
         }
         _loc3_ = this.getMechSlot(_loc2_);
         this["mech" + param1 + "CodeStepMarker"].x = (this._mechBattleDatas[_loc3_].currentStepCode + 0.5) * this.FLOOR_STEP_SIZE;
      }
      
      private function battleViewHandler() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:Number = NaN;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Sprite = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         if(this._refreshBattleView_low_frames > 0 || this._refreshBattleViewImmediately || this._zoomViewChangeFrames > 0)
         {
            _loc1_ = dataM.playersData[this._currentPlayerID];
            _loc2_ = this.getMechSlot(this._currentPlayerID);
            _loc3_ = this._mechBattleDatas[_loc2_];
            _loc4_ = this._battleViewMech1_lastMainHolderXPos;
            if(_loc3_.mechView != null)
            {
               _loc8_ = this["mech" + this._currentPlayerInterfacePlayerID + "CodeStepMarker"];
               if(_loc8_.x != this._battleViewMech1_lastMechViewXPos)
               {
                  _loc5_ = new Point(_loc8_.x,_loc8_.y);
                  _loc6_ = this.holder_mechs.localToGlobal(_loc5_);
                  _loc7_ = this.holder_main.globalToLocal(_loc6_);
                  _loc4_ = _loc7_.x;
                  this._battleViewMech1_lastMainHolderXPos = _loc4_;
                  this._battleViewMech1_lastMechViewXPos = _loc8_.x;
               }
               else
               {
                  _loc4_ = this._battleViewMech1_lastMainHolderXPos;
               }
            }
            _loc1_ = dataM.playersData[this._opponentPlayerID];
            _loc2_ = this.getMechSlot(this._opponentPlayerID);
            _loc3_ = this._mechBattleDatas[_loc2_];
            _loc9_ = this._battleViewMech2_lastMainHolderXPos;
            if(_loc3_.mechView != null)
            {
               _loc8_ = this["mech" + this._opponentPlayerInterfacePlayerID + "CodeStepMarker"];
               if(_loc8_.x != this._battleViewMech2_lastMechViewXPos)
               {
                  _loc5_ = new Point(_loc8_.x,_loc8_.y);
                  _loc6_ = this.holder_mechs.localToGlobal(_loc5_);
                  _loc7_ = this.holder_main.globalToLocal(_loc6_);
                  _loc9_ = _loc7_.x;
                  this._battleViewMech2_lastMainHolderXPos = _loc9_;
                  this._battleViewMech2_lastMechViewXPos = _loc8_.x;
               }
               else
               {
                  _loc9_ = this._battleViewMech2_lastMainHolderXPos;
               }
            }
            _loc10_ = _loc4_;
            _loc11_ = _loc9_;
            if(_loc10_ > _loc11_)
            {
               _loc10_ = _loc9_;
               _loc11_ = _loc4_;
            }
            _loc12_ = _loc11_ - _loc10_;
            _loc13_ = _loc10_ + _loc12_ / 2;
            this._viewScale = 1;
            if(_loc12_ > this._halfStageWidth)
            {
               this._viewScale = 1 / (1 + (_loc12_ - this._halfStageWidth) / this._halfStageWidth / this.DISTACE_FROM_MECHS_TO_SCREEN_BORDERS_RATIO);
            }
            if(this._viewScale > this.VIEW_SCALE_MINIMUM)
            {
               this._viewScale = this.VIEW_SCALE_MINIMUM;
            }
            this._mainHolderXPos = this._halfStageWidth - this._viewScale * _loc13_;
            _loc14_ = this._mainHolderXPos;
            this._viewScaleFinal = this._viewScale;
            if(this._zoomOut)
            {
               _loc14_ = this.ZOOM_OUT_MAIN_HOLDER_DISTANCE_FROM_BORDER;
               this._viewScaleFinal = (dataM.STAGE_WIDTH - this.ZOOM_OUT_MAIN_HOLDER_DISTANCE_FROM_BORDER * 2) / this._floorWidth;
            }
            if(Math.abs(this.holder_main.x - _loc14_) > this.MOVING_MAIN_HOLDER_MIN_CHANGE_IN_PIXELS && this._refreshBattleViewImmediately == false)
            {
               if(this.holder_main.x > _loc14_)
               {
                  _loc15_ = this.holder_main.x - (this.holder_main.x - _loc14_) * this.MOVING_MAIN_HOLDER_PER_FRAME_RATIO;
               }
               else
               {
                  _loc15_ = this.holder_main.x + (_loc14_ - this.holder_main.x) * this.MOVING_MAIN_HOLDER_PER_FRAME_RATIO;
               }
            }
            else
            {
               _loc15_ = _loc14_;
            }
            this.holder_main.x = _loc15_;
            this.background_level0.x = _loc15_ * 0.03;
            if(Math.abs(this.holder_main.scaleX - this._viewScaleFinal) > this.ZOOMING_SCALE_MIN_CHANGE_RATIO && this._refreshBattleViewImmediately == false)
            {
               _loc16_ = this.holder_main.scaleX;
               if(this.holder_main.scaleX > this._viewScaleFinal)
               {
                  this.holder_main.scaleX -= (_loc16_ - this._viewScaleFinal) / 5;
                  this.holder_main.scaleY -= (_loc16_ - this._viewScaleFinal) / 5;
               }
               else
               {
                  this.holder_main.scaleX += (this._viewScaleFinal - _loc16_) / 5;
                  this.holder_main.scaleY += (this._viewScaleFinal - _loc16_) / 5;
               }
            }
            else
            {
               this.holder_main.scaleX = this._viewScaleFinal;
               this.holder_main.scaleY = this._viewScaleFinal;
            }
            this._refreshBattleViewImmediately = false;
            if(dataM.runAsMobile)
            {
               screensM.screenBattleInterfaceTop.mcViewScaleIndicator.visible = true;
            }
            if(this._refreshBattleView_low_frames > 0)
            {
               --this._refreshBattleView_low_frames;
            }
            if(this._zoomViewChangeFrames > 0)
            {
               --this._zoomViewChangeFrames;
            }
         }
         else
         {
            screensM.screenBattleInterfaceTop.mcViewScaleIndicator.visible = false;
         }
      }
      
      public function zoomClicked() : void
      {
         this._zoomOutForTeleport = false;
         screensM.screenBattleInterfaceTop.btnZoomIn.visible = false;
         screensM.screenBattleInterfaceTop.btnZoomOut.visible = false;
         if(this._zoomOut)
         {
            this._zoomOut = false;
            screensM.screenBattleInterfaceTop.btnZoomOut.visible = true;
         }
         else
         {
            this._zoomOut = true;
            screensM.screenBattleInterfaceTop.btnZoomIn.visible = true;
         }
         this._zoomViewChangeFrames = this.ZOOM_VIEW_CHANGE_FRAMES;
      }
      
      private function refreshMechsView() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
         if(_loc3_.currentStepVisual < _loc6_.currentStepVisual)
         {
            if(this._currentPlayerID == dataM.player1PlayerID)
            {
               _loc7_ = 1;
               _loc8_ = -1;
            }
            else
            {
               _loc7_ = -1;
               _loc8_ = 1;
            }
         }
         else if(this._currentPlayerID == dataM.player1PlayerID)
         {
            _loc7_ = -1;
            _loc8_ = 1;
         }
         else
         {
            _loc7_ = 1;
            _loc8_ = -1;
         }
         this.changeAllMechViews(_loc7_,_loc8_);
      }
      
      private function changeAllMechViews(param1:Number, param2:Number) : void
      {
         var _loc3_:BMMechBattleData = null;
         for each(_loc3_ in this._mechBattleDatas)
         {
            if(_loc3_.mechView != null)
            {
               if(_loc3_.playerID == dataM.player1PlayerID)
               {
                  _loc3_.mechView.scaleX = param1;
               }
               else if(_loc3_.playerID == dataM.player2PlayerID)
               {
                  _loc3_.mechView.scaleX = param2;
               }
            }
         }
      }
      
      private function addFloorPart(param1:String, param2:Number) : void
      {
         var _loc3_:MovieClip = null;
         _loc3_ = externalAssetsM.getAsset("general","Grp_" + param1);
         _loc3_.width += 1;
         _loc3_.x = param2;
         this.floors.push(_loc3_);
         this.background_floor.addChild(_loc3_);
      }
      
      private function createMapBackgrounds() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         var _loc4_:BMPlayerProfile = null;
         var _loc5_:uint = 0;
         var _loc6_:TextField = null;
         var _loc7_:TextFormat = null;
         var _loc8_:MovieClip = null;
         this.background_floor = new MovieClip();
         if(dataM.battleType == "mission")
         {
            _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            dataM.battle_backgroundID = _loc4_.mission_themeID;
         }
         _loc3_ = externalAssetsM.getAsset("general","Grp_floor_" + dataM.battle_backgroundID);
         this.floors.push(_loc3_);
         this.background_floor.addChild(_loc3_);
         this.background_level0 = externalAssetsM.getAsset("general","Grp_background_" + dataM.battle_backgroundID);
         this.holder_backgrounds.addChild(this.background_level0);
         this.holder_backgroundFloor.addChild(this.background_floor);
         this.mapBorder1.x = -30;
         this.mapBorder2.x = this.FLOOR_STEP_SIZE * dataM.battleData.map.stepsTotal + 30;
         this.mapBorder1.mcLight.gotoAndStop("animOn");
         this.mapBorder2.mcLight.gotoAndStop("animOn");
         if(this.DISPLAY_STEP_NUMBERS)
         {
            this.floorStepNumbers = new Array();
            _loc5_ = 0;
            while(_loc5_ < dataM.battleData.map.stepsTotal)
            {
               _loc6_ = new TextField();
               _loc6_.multiline = true;
               _loc6_.htmlText = _loc5_ + "<BR>" + (dataM.battleData.map.stepsTotal - _loc5_ - 1);
               _loc7_ = new TextFormat("arial",20,16777215,true,false,false,null,null,"center");
               _loc6_.setTextFormat(_loc7_);
               _loc6_.selectable = false;
               _loc6_.x = (_loc5_ + 0.5) * this.FLOOR_STEP_SIZE - _loc6_.width / 2;
               _loc6_.y = 20;
               _loc8_ = new mcStepNumberLine();
               _loc8_.x = _loc5_ * this.FLOOR_STEP_SIZE - 3;
               _loc8_.y = 5;
               this.floorStepNumbers[_loc5_] = new Object();
               this.floorStepNumbers[_loc5_].stepText = _loc6_;
               this.floorStepNumbers[_loc5_].stepLine = _loc8_;
               this.holder_backgroundFloor.addChild(_loc6_);
               this.holder_backgroundFloor.addChild(_loc8_);
               _loc5_++;
            }
         }
         ++dataM.battle_backgroundID;
         if(dataM.battle_backgroundID > 8)
         {
            dataM.battle_backgroundID = 1;
         }
      }
      
      private function removeMapBackgrounds() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.floors.length)
         {
            this.background_floor.removeChild(this.floors[_loc1_]);
            this.floors[_loc1_] = null;
            _loc1_++;
         }
         this.floors = new Array();
         if(this.background_level0 != null)
         {
            this.holder_backgrounds.removeChild(this.background_level0);
         }
         if(this.background_floor != null)
         {
            this.holder_backgroundFloor.removeChild(this.background_floor);
         }
         this.background_level0 = null;
         this.background_floor = null;
      }
      
      private function lowHPAndHighHeatHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMPlayerData = null;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMMechView = null;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:String = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         _loc1_ = dataM.player1PlayerID;
         for(; _loc1_ <= dataM.player2PlayerID; _loc1_++)
         {
            _loc2_ = dataM.playersData[_loc1_];
            _loc3_ = this.getMechSlot(_loc1_);
            _loc4_ = this._mechBattleDatas[_loc3_];
            if(!(_loc4_.HP > 0 || this._waitingForFinishMove))
            {
               continue;
            }
            _loc5_ = _loc4_.mechView;
            _loc6_ = _loc4_.HP / _loc4_.HPMax;
            _loc7_ = false;
            _loc8_ = _loc5_.entry4Active();
            if(_loc6_ <= this.DAMAGED_EFFECT_HP_RATIO || _loc8_)
            {
               _loc7_ = true;
            }
            _loc9_ = _loc4_.heat / _loc4_.heatMax;
            if(!(_loc7_ || _loc9_ >= this.OVERHEAT_EFFECT_RATIO))
            {
               continue;
            }
            if(_loc7_)
            {
               if(_loc8_)
               {
                  _loc10_ = Math.ceil(Math.random() * 10) / dataM.movieClipParticleEffectsRatio;
               }
               else
               {
                  _loc10_ = Math.ceil(Math.random() * (this.DAMAGED_EFFECT_RANDOM_BASE + this.DAMAGED_EFFECT_RANDOM_ADDON * _loc6_ / this.DAMAGED_EFFECT_HP_RATIO) / dataM.movieClipParticleEffectsRatio);
               }
               switch(_loc10_)
               {
                  case 1:
                  case 2:
                     _loc11_ = 1;
                     _loc12_ = 2;
                     _loc13_ = 40;
                     effectsM.createSparksMC("screenBattle","spark",_loc5_.x,_loc5_.y,_loc11_,_loc12_,_loc13_,"horizontal","blue",true);
                     break;
                  case 3:
                     _loc14_ = Math.random() * 60 - 30 + _loc5_.x;
                     _loc15_ = Math.random() * 60 - 30 + _loc5_.y;
                     _loc16_ = "electricity" + Math.ceil(Math.random() * 3);
                     effectsM.createElectricity(_loc16_,_loc14_,_loc15_,this.holder_effects);
               }
            }
            if(_loc9_ < this.OVERHEAT_EFFECT_RATIO)
            {
               continue;
            }
            if(_loc9_ < 1)
            {
               _loc18_ = 15;
            }
            else
            {
               _loc18_ = 10;
            }
            _loc10_ = Math.ceil(Math.random() * _loc18_ / dataM.movieClipParticleEffectsRatio);
            switch(_loc10_)
            {
               case 1:
               case 2:
                  _loc11_ = 1;
                  _loc12_ = 2;
                  _loc13_ = 40;
                  effectsM.createSparksMC("screenBattle","spark",_loc5_.x,_loc5_.y,_loc11_,_loc12_,_loc13_,"horizontal","red",true);
                  break;
               case 3:
                  _loc14_ = Math.random() * 60 - 30 + _loc5_.x;
                  _loc15_ = Math.random() * 60 - 30 + _loc5_.y;
                  _loc16_ = "electricityRed" + Math.ceil(Math.random() * 3);
                  effectsM.createElectricity(_loc16_,_loc14_,_loc15_,this.holder_effects);
            }
         }
      }
      
      private function teleportAfterEffectHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         if(this._teleportAfterEffectCountdown > 0)
         {
            _loc1_ = Math.ceil(Math.random() * 7 / dataM.movieClipParticleEffectsRatio);
            if(_loc1_ == 1)
            {
               _loc2_ = Math.random() * 60 - 30 + this._teleportAfterEffectXPos;
               _loc3_ = Math.random() * 60 - 30 + this._teleportAfterEffectYPos;
               _loc4_ = "electricity" + Math.ceil(Math.random() * 3);
               effectsM.createElectricity(_loc4_,_loc2_,_loc3_,this.holder_effects);
            }
            --this._teleportAfterEffectCountdown;
         }
      }
      
      public function createEarthQuake() : void
      {
         if(dataM.runAsMobile == false)
         {
            this._earthQuakeHandler = true;
            this._earthQuakeCounter = 10;
         }
      }
      
      private function earthQuakeHandler() : void
      {
         if(this._earthQuakeHandler)
         {
            if(this._earthQuakeCounter > 0)
            {
               if(this._earthQuakeCounter % 2 == 0)
               {
                  this.holder_main.y = this._holderMainOriginYPos + this._earthQuakeCounter;
               }
               else
               {
                  this.holder_main.y = this._holderMainOriginYPos - this._earthQuakeCounter;
               }
               --this._earthQuakeCounter;
            }
            else
            {
               this._earthQuakeHandler = false;
               this.holder_main.y = this._holderMainOriginYPos;
            }
         }
      }
      
      private function turnMarkerHandler() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:BMPlayerData = null;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:Number = NaN;
         if(this._waitingForFinishMove || this._lastPlayerLostID > 0)
         {
            _loc1_ = this["mcTurnMarker" + this._currentPlayerInterfacePlayerID];
            if(_loc1_.scaleX != 0)
            {
               if(_loc1_.scaleX > 0)
               {
                  _loc1_.scaleX -= 0.1;
                  _loc1_.scaleY -= 0.1;
               }
               else
               {
                  _loc1_.scaleX = 0;
                  _loc1_.scaleY = 0;
               }
            }
         }
         else
         {
            _loc2_ = dataM.playersData[this._currentPlayerID];
            _loc3_ = this.getMechSlot(this._currentPlayerID);
            _loc4_ = this._mechBattleDatas[_loc3_];
            if(_loc4_.mechView != null)
            {
               _loc5_ = _loc4_.mechView.mechSizer.x + _loc4_.mechView.mechSizer.width / 2;
               _loc1_ = this["mcTurnMarker" + this._currentPlayerInterfacePlayerID];
               if(_loc4_.mechView.scaleX == 1)
               {
                  _loc1_.x = _loc4_.mechView.x + _loc4_.mechView.torso.x;
               }
               else
               {
                  _loc1_.x = _loc4_.mechView.x - _loc4_.mechView.torso.x;
               }
               if(_loc1_.scaleX != 1)
               {
                  if(_loc1_.scaleX < 1)
                  {
                     _loc1_.scaleX += 0.1;
                     _loc1_.scaleY += 0.1;
                  }
                  else
                  {
                     _loc1_.scaleX = 1;
                     _loc1_.scaleY = 1;
                  }
               }
               _loc1_ = this["mcTurnMarker" + this._opponentPlayerInterfacePlayerID];
               if(_loc1_.scaleX != 0)
               {
                  if(_loc1_.scaleX > 0)
                  {
                     _loc1_.scaleX -= 0.1;
                     _loc1_.scaleY -= 0.1;
                  }
                  else
                  {
                     _loc1_.scaleX = 0;
                     _loc1_.scaleY = 0;
                  }
               }
            }
            else
            {
               TsLogger.log("NULLLLLLLLLL");
            }
         }
      }
      
      private function refreshTurnMarkersSizeAndPosition() : void
      {
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         this.mcTurnMarker1.width = 150;
         this.mcTurnMarker2.width = 150;
      }
      
      private function createMechView(param1:Number, param2:uint) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMMechStructure = null;
         var _loc6_:BMMechView = null;
         var _loc7_:Number = NaN;
         var _loc8_:BMMechDrone = null;
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:BMItemData = null;
         var _loc11_:BMMechView = null;
         _loc3_ = this.getMechSlot(param1,param2);
         _loc4_ = this._mechBattleDatas[_loc3_];
         _loc5_ = _loc4_.mechStructure;
         _loc6_ = new BMMechView();
         _loc6_.useLegsShadow = true;
         if(dataM.battleType == "challenge")
         {
            if(dataM.battleSubType == "invisible")
            {
               _loc6_.useLegsShadow = false;
            }
         }
         _loc7_ = this.MECH_SIZE_RATIO;
         if(_loc5_.perk > 0)
         {
            _loc9_ = dataM.getPlayerItemData(param1,_loc5_.perk);
            _loc10_ = dataM.itemsDB[_loc9_.itemID];
            switch(_loc10_.grp)
            {
               case "perk_sizeGiant":
                  _loc7_ = this.MECH_SIZE_RATIO_GIANT_PERK;
                  break;
               case "perk_sizeDwarf":
                  _loc7_ = this.MECH_SIZE_RATIO_DWARF_PERK;
            }
         }
         _loc6_.initialize(param1,"battle","playerItemID",_loc7_,false);
         _loc6_.buildMech(_loc5_,"screenBattle createMech regular");
         _loc6_.setWalkingParameters(this.WALKING_LEG_X_DISTANCE,this.MECH_WALKING_FRAMES,this.walkingDirtEffect);
         _loc6_.setBumpParameters(6,10);
         _loc6_.setGetHitParameters(5,5);
         _loc6_.showCenterPosition();
         _loc6_.createChargeEngine();
         _loc6_.activateBreathing();
         _loc6_.x = (_loc4_.currentStepCode + 0.5) * this.FLOOR_STEP_SIZE;
         _loc6_.y = -(_loc6_.mechSizer.height + _loc6_.mechSizer.y);
         _loc8_ = new BMMechDrone();
         this.holder_mechs.addChild(_loc8_);
         this.holder_mechs.addChild(_loc6_);
         _loc4_.mechView = _loc6_;
         _loc4_.drone = _loc8_;
         _loc4_.createDrone("playerItemID");
         if(_loc4_.shieldActive)
         {
            _loc4_.activateShield();
         }
         if(dataM.runAsMobile == false)
         {
            switch(param1)
            {
               case dataM.OFFLINE_PLAYER_ID:
               case dataM.ONLINE_PLAYER_ID:
                  this.mechHologram = new mcMechHologramEffect();
                  _loc11_ = new BMMechView();
                  _loc11_.initialize(param1,"battle","playerItemID",_loc7_,false);
                  _loc11_.buildMech(_loc5_,"screenBattle createMech hologram");
                  this.mechHologram.mechViewHolder.addChild(_loc11_);
                  this.mechHologram.mechViewHolder.mechView = _loc11_;
                  this.mechHologram.y = _loc6_.y;
            }
         }
      }
      
      private function createMechBattleData(param1:Number, param2:uint, param3:Number, param4:Number) : void
      {
         var _loc5_:BMPlayerData = null;
         var _loc6_:BMMechStructure = null;
         var _loc7_:Number = NaN;
         var _loc8_:BMMechBattleData = null;
         var _loc9_:BMPlayerItemData = null;
         var _loc11_:BMPlayerProfile = null;
         var _loc12_:Boolean = false;
         var _loc13_:String = null;
         var _loc14_:BMPlayerItemData = null;
         var _loc15_:BMItemData = null;
         var _loc16_:BMReplayStatus = null;
         var _loc17_:Number = NaN;
         var _loc18_:BMPlayerProfile = null;
         var _loc19_:Number = NaN;
         var _loc20_:BMWorldMapLocationData = null;
         var _loc21_:Number = NaN;
         var _loc22_:BMWorldMapBossData = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         _loc5_ = dataM.playersData[param1];
         _loc6_ = new BMMechStructure();
         _loc6_ = _loc5_.mechStructures[param2];
         _loc6_.updateEquipmentIndicators();
         if(param4 > 0)
         {
            _loc7_ = param4;
         }
         else
         {
            _loc7_ = Number(dataM.battleData["player" + dataM.getInterfacePlayerID(param1)].currentStep);
         }
         _loc8_ = new BMMechBattleData();
         _loc8_.initialize();
         _loc8_.playerID = param1;
         _loc8_.mechID = param2;
         _loc8_.mechStructure = _loc6_;
         _loc8_.currentStepVisual = _loc7_;
         _loc8_.currentStepCode = _loc8_.currentStepVisual;
         _loc9_ = dataM.getPlayerItemData(param1,_loc6_.torso);
         var _loc10_:BMItemData = dataM.itemsDB[_loc9_.itemID];
         _loc8_.setHPMax();
         _loc8_.setEnergyMaxAndRegeneration();
         _loc8_.setHeatMaxAndCooling();
         _loc8_.setBulletsMax();
         _loc8_.setRocketsMax();
         _loc8_.setUses();
         _loc8_.setAllResistances();
         _loc8_.setMovementParameters();
         if(_loc6_.shield > 0)
         {
            _loc14_ = dataM.getPlayerItemData(param1,_loc6_.shield);
            _loc15_ = dataM.itemsDB[_loc14_.itemID];
            if(_loc15_.energyPerBlock > 0)
            {
               _loc8_.shieldType = "energy";
            }
            else
            {
               _loc8_.shieldType = "heat";
            }
         }
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_REPLAY:
               if(param2 == 1)
               {
                  _loc16_ = dataM.battle_replayData["status" + dataM.getInterfacePlayerID(param1)][0];
                  _loc8_.HPMax = _loc16_.HP;
                  _loc8_.HP = _loc8_.HPMax;
                  _loc8_.energyMax = _loc16_.energy;
                  _loc8_.energy = _loc8_.energyMax;
                  _loc8_.bulletsMax = _loc16_.bullets;
                  _loc8_.bullets = _loc8_.bulletsMax;
                  _loc8_.rocketsMax = _loc16_.rockets;
                  _loc8_.rockets = _loc8_.rocketsMax;
                  _loc8_.resist1 = _loc16_.resist1;
                  _loc8_.resist2 = _loc16_.resist2;
                  _loc8_.resist3 = _loc16_.resist3;
                  _loc8_.dataSetByReplay = true;
               }
         }
         _loc12_ = true;
         switch(dataM.battleType)
         {
            case "challenge":
               if(param1 == dataM.player2PlayerID)
               {
                  if(dataM.battleSubType == "godMode")
                  {
                     _loc11_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                     _loc17_ = _loc11_.level - 1;
                     _loc8_.HPMax = this.GOD_MODE_HP_BASE + _loc17_ * this.GOD_MODE_HP_PER_LEVEL;
                     _loc8_.HP = _loc8_.HPMax;
                     _loc8_.energyMax = this.GOD_MODE_ENERGY_BASE + _loc17_ * this.GOD_MODE_ENERGY_PER_LEVEL;
                     _loc8_.energy = _loc8_.energyMax;
                     _loc8_.energyRegeneration = this.GOD_MODE_ENERGY_REGENERATIO_BASE + _loc17_ * this.GOD_MODE_ENERGY_REGENERATIO_PER_LEVEL;
                     _loc8_.heatMax = this.GOD_MODE_HEAT_BASE + _loc17_ * this.GOD_MODE_HEAT_PER_LEVEL;
                     _loc8_.heatCooling = this.GOD_MODE_HEAT_COOLING_BASE + _loc17_ * this.GOD_MODE_HEAT_COOLING_PER_LEVEL;
                  }
                  if(dataM.battleSubType == "damage")
                  {
                     _loc8_.HPMax = 9999;
                     _loc8_.HP = _loc8_.HPMax;
                     _loc12_ = false;
                  }
               }
               break;
            case "mission":
               if(dataM.battleType == "mission")
               {
                  _loc11_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                  if(param1 == dataM.player1PlayerID)
                  {
                     if(_loc8_.HP > _loc11_.mission_hp)
                     {
                        _loc8_.HP = _loc11_.mission_hp;
                     }
                     _loc8_.energyMax = _loc11_.mission_energy;
                     _loc8_.energy = _loc8_.energyMax;
                     _loc8_.energyRegeneration = _loc11_.mission_energyRegeneration;
                     _loc8_.heatMax = _loc11_.mission_heat;
                     _loc8_.heatCooling = _loc11_.mission_heatCooling;
                     if(_loc8_.bullets > _loc11_.mission_bullets)
                     {
                        _loc8_.bullets = _loc11_.mission_bullets;
                     }
                     if(_loc8_.rockets > _loc11_.mission_rockets)
                     {
                        _loc8_.rockets = _loc11_.mission_rockets;
                     }
                  }
                  else
                  {
                     switch(dataM.battleSubType)
                     {
                        case "turret":
                        case "jeep":
                        case "tank":
                           _loc18_ = dataM["player" + dataM.player2PlayerID + "Profile"];
                           _loc19_ = 100 + (_loc18_.level - 1) * 10;
                           if(_loc11_.missionsCompleted == 0 && dataM.battleSubType == "jeep")
                           {
                              _loc8_.HPMax = 75;
                           }
                           else
                           {
                              _loc8_.HPMax = Math.ceil(_loc8_.HPMax * _loc19_ / 100 / 5) * 5;
                           }
                           _loc8_.HP = _loc8_.HPMax;
                           _loc8_.energyMax = Math.ceil(_loc8_.energyMax * _loc19_ / 100 / 2) * 2;
                           _loc8_.energy = _loc8_.energyMax;
                           _loc8_.energyRegeneration = Math.ceil(_loc8_.energyRegeneration * _loc19_ / 100 / 2) * 2;
                           _loc8_.heatMax = Math.ceil(_loc8_.heatMax * _loc19_ / 100 / 2) * 2;
                           _loc8_.heatCooling = Math.ceil(_loc8_.heatCooling * _loc19_ / 100 / 1) * 1;
                           break;
                        case "boss":
                           _loc20_ = dataM.missionsDB[_loc11_.currentMissionSlot];
                           _loc21_ = _loc20_.bossDataSlot;
                           if(_loc21_ == -1)
                           {
                              trace("WARNING: BOSS DATA SLOT IS NULLED - AUTO SETTING TO FIRST BOSS");
                              _loc21_ = 0;
                           }
                           _loc22_ = dataM.missionBossesDB[_loc21_];
                           if(_loc22_.fixed_hp > 0)
                           {
                              _loc8_.HPMax = _loc22_.fixed_hp;
                              _loc8_.HP = _loc8_.HPMax;
                           }
                           if(_loc22_.fixed_energyBase > 0)
                           {
                              _loc8_.energyMax = _loc22_.fixed_energyBase;
                              _loc8_.energy = _loc8_.energyMax;
                           }
                           if(_loc22_.fixed_energyAddon > 0)
                           {
                              _loc8_.energyRegeneration = _loc22_.fixed_energyAddon;
                           }
                           if(_loc22_.fixed_heatBase > 0)
                           {
                              _loc8_.heatMax = _loc22_.fixed_heatBase;
                           }
                           if(_loc22_.fixed_heatAddon > 0)
                           {
                              _loc8_.heatCooling = _loc22_.fixed_heatAddon;
                           }
                           if(_loc22_.fixed_bullets > 0)
                           {
                              _loc8_.bulletsMax = _loc22_.fixed_bullets;
                              _loc8_.bullets = _loc8_.bulletsMax;
                           }
                           if(_loc22_.fixed_rockets > 0)
                           {
                              _loc8_.rocketsMax = _loc22_.fixed_rockets;
                              _loc8_.rockets = _loc8_.rocketsMax;
                           }
                           if(_loc22_.fixed_resist1 > 0)
                           {
                              _loc8_.resist1 = _loc22_.fixed_resist1;
                           }
                           if(_loc22_.fixed_resist2 > 0)
                           {
                              _loc8_.resist2 = _loc22_.fixed_resist2;
                           }
                           if(_loc22_.fixed_resist3 > 0)
                           {
                              _loc8_.resist3 = _loc22_.fixed_resist3;
                           }
                     }
                  }
               }
         }
         if(param1 == dataM.player2PlayerID)
         {
            if(_loc12_)
            {
               screensM.screenBattleInterfaceTop.showOpponentInterface();
            }
            else
            {
               screensM.screenBattleInterfaceTop.hideOpponentInterface();
            }
         }
         if(param1 == dataM.OFFLINE_OPPONENT_ID || dataM.playingVSComputer && param1 == dataM.ONLINE_OPPONENT_ID)
         {
            _loc11_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            switch(dataM.battleType)
            {
               case "mission":
                  switch(dataM.battleSubType)
                  {
                     case "mech":
                        if(_loc11_.level <= 4)
                        {
                           _loc23_ = 0.75;
                           if(_loc11_.level <= 3)
                           {
                              _loc23_ = 0.65;
                           }
                           _loc8_.HPMax = Math.ceil(_loc8_.HPMax * _loc23_ / 5) * 5;
                           _loc8_.HP = _loc8_.HPMax;
                        }
                  }
                  break;
               case "regular":
                  if(_loc11_.winsVSComputer == 0)
                  {
                     _loc8_.HPMax = 20;
                     _loc8_.HP = _loc8_.HPMax;
                  }
                  else if(_loc11_.winsVSComputer == 1)
                  {
                     _loc8_.HPMax = 50;
                     _loc8_.HP = _loc8_.HPMax;
                  }
            }
         }
         if(param3 > 0)
         {
            _loc8_.HPMax += 5 * param3;
            _loc8_.HP = _loc8_.HPMax;
            _loc24_ = 10;
            _loc25_ = 45;
            _loc26_ = 1;
            while(_loc26_ <= 3)
            {
               _loc8_["resist" + _loc26_] += Math.ceil(0.5 * param3);
               if(_loc8_["resist" + _loc26_] < _loc24_)
               {
                  _loc8_["resist" + _loc26_] = _loc24_;
               }
               else if(_loc8_["resist" + _loc26_] > _loc25_)
               {
                  _loc8_["resist" + _loc26_] = _loc25_;
               }
               _loc26_++;
            }
         }
         _loc13_ = param1 + "_" + param2;
         this._mechBattleDatas[_loc13_] = _loc8_;
      }
      
      public function getMechSlot(param1:Number, param2:uint = 0) : String
      {
         var _loc3_:BMPlayerData = null;
         _loc3_ = dataM.playersData[param1];
         if(param2 == 0)
         {
            param2 = _loc3_.selectedMechID;
         }
         return param1 + "_" + param2;
      }
      
      public function createMechReflection(param1:Number, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:BMMechView = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(dataM.battleType == "challenge")
         {
            if(dataM.battleSubType == "invisible")
            {
               if(param1 == dataM.player2PlayerID)
               {
                  _loc3_ = true;
                  if(dataM.runAsMobile && param2 == false)
                  {
                     _loc3_ = false;
                  }
                  if(_loc3_)
                  {
                     if(this.mechReflectionHolder != null)
                     {
                        if(this.mechReflectionHolder.parent != null)
                        {
                           this.mechReflectionHolder.parent.removeChild(this.mechReflectionHolder);
                        }
                     }
                     if(this.mechReflectionHolder == null)
                     {
                        this.mechReflectionHolder = new MovieClip();
                     }
                     if(this._mechReflectionBM != null)
                     {
                        if(this._mechReflectionBM.parent != null)
                        {
                           this._mechReflectionBM.parent.removeChild(this._mechReflectionBM);
                        }
                        this._mechReflectionBM = null;
                        this._mechReflectionBMD.dispose();
                     }
                     _loc4_ = this.getMechSlot(dataM.player2PlayerID);
                     _loc5_ = this._mechBattleDatas[_loc4_];
                     _loc6_ = _loc5_.mechView;
                     _loc7_ = _loc6_.itemsHolder.x;
                     _loc8_ = _loc6_.itemsHolder.y;
                     this._mechReflectionBMD = new BitmapData(400,400,true,0);
                     _loc6_.itemsHolder.x -= _loc6_.mechSizer.x - 20;
                     _loc6_.itemsHolder.y -= _loc6_.mechSizer.y - 20;
                     this._mechReflectionBMD.draw(_loc6_);
                     _loc6_.itemsHolder.x = _loc7_;
                     _loc6_.itemsHolder.y = _loc8_;
                     this._mechReflectionBM = new Bitmap(this._mechReflectionBMD);
                     this._mechReflectionBM.x = -this._mechReflectionBM.width / 2;
                     this.mechReflectionHolder.scaleX = _loc6_.scaleX;
                     if(this.mechReflectionHolder.scaleX > 0)
                     {
                        this.mechReflectionHolder.x = _loc6_.x + _loc6_.mechSizer.x + 200 - 20;
                        this.mechReflectionHolder.y = _loc6_.y + _loc6_.mechSizer.y - 20;
                     }
                     else
                     {
                        this.mechReflectionHolder.x = _loc6_.x + _loc6_.mechSizer.x - 20;
                        this.mechReflectionHolder.y = _loc6_.y + _loc6_.mechSizer.y - 20;
                     }
                     this.mechReflectionHolder.addChild(this._mechReflectionBM);
                     this.mechReflectionHolder.alpha = 1;
                     this.holder_effects.addChild(this.mechReflectionHolder);
                     if(_loc5_.droneActive)
                     {
                        _loc5_.drone.activateDroneReflection();
                     }
                  }
               }
            }
         }
      }
      
      private function mechReflectionHandler() : void
      {
         if(this._mechReflectionBM != null)
         {
            this.mechReflectionHolder.alpha -= 0.1;
            if(this.mechReflectionHolder.alpha <= 0)
            {
               if(this._mechReflectionBM.parent != null)
               {
                  this._mechReflectionBM.parent.removeChild(this._mechReflectionBM);
               }
               this._mechReflectionBM = null;
               this._mechReflectionBMD.dispose();
               if(this.mechReflectionHolder.parent != null)
               {
                  this.mechReflectionHolder.parent.removeChild(this.mechReflectionHolder);
               }
            }
         }
      }
      
      private function mechTeaseAnimationsHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerData = null;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:Number = NaN;
         if(this._mechTeaseAnimationsHandler)
         {
            if(this._currentPlayerID == dataM.player1PlayerID)
            {
               if(this._socketActionAllowed)
               {
                  ++this._mechTeaseAnimationCounter;
                  if(this._mechTeaseAnimationCounter >= 300)
                  {
                     _loc1_ = true;
                     switch(dataM.battleSubType)
                     {
                        case "tank":
                        case "jeep":
                        case "turret":
                           _loc1_ = false;
                     }
                     if(_loc1_)
                     {
                        _loc2_ = dataM.playersData[this._opponentPlayerID];
                        _loc3_ = this.getMechSlot(this._opponentPlayerID);
                        _loc4_ = this._mechBattleDatas[_loc3_];
                        if(_loc4_.HP > 0 && _loc4_.mechView.shutDownActive == false)
                        {
                           _loc5_ = Math.ceil(Math.random() * 6);
                           switch(_loc5_)
                           {
                              case 1:
                                 _loc4_.mechView.activateTease1(null);
                                 break;
                              case 2:
                                 _loc4_.mechView.activateTease3(null);
                                 break;
                              case 3:
                                 _loc4_.mechView.activateTease4(null);
                                 break;
                              case 4:
                                 _loc4_.mechView.activateTease5(null);
                                 break;
                              case 5:
                                 _loc4_.mechView.activateTease6(null);
                                 break;
                              case 6:
                                 _loc4_.mechView.activateTease8(null);
                                 break;
                              case 7:
                                 _loc4_.mechView.activateTease10(null);
                           }
                        }
                     }
                     this._mechTeaseAnimationCounter = 0;
                  }
               }
            }
         }
      }
      
      private function activateMechTeaseAnimation() : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.playingVSComputer)
         {
            this._mechTeaseAnimationsHandler = true;
            this._mechTeaseAnimationCounter = 260;
         }
      }
      
      private function deactivateMechTeaseAnimation() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc2_ = this.getMechSlot(this._opponentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         if(_loc3_.mechView != null)
         {
            _loc3_.mechView.resumeBreathing();
         }
         this._mechTeaseAnimationsHandler = false;
      }
      
      private function activateWeaponFeedbackAndSound(param1:Number, param2:String, param3:String) : void
      {
         var _loc4_:BMMechBattleData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         switch(this._lastWeaponEquipmentType)
         {
            case "sideWeapon":
            case "topWeapon":
               _loc4_ = this._mechBattleDatas[this.getMechSlot(param1)];
               _loc5_ = 0;
               _loc6_ = 0;
               switch(param2)
               {
                  case "xAxis":
                     _loc5_ = 5;
                     break;
                  case "yAxis":
                     _loc6_ = 5;
               }
               _loc4_.mechView.addWeaponFeedback(this._lastWeaponEquipmentType,this._lastWeaponEquipmentID,_loc5_,_loc6_);
         }
         if(param3 != "")
         {
            soundM.createSound(param3,1);
         }
      }
      
      public function activateGetHit(param1:Number, param2:String, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:BMMechBattleData = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc11_:Number = NaN;
         var _loc12_:MovieClip = null;
         var _loc13_:Point = null;
         var _loc14_:Point = null;
         var _loc15_:Point = null;
         var _loc16_:Number = NaN;
         _loc5_ = this._mechBattleDatas[this.getMechSlot(param1)];
         _loc6_ = false;
         _loc7_ = false;
         _loc8_ = false;
         switch(param2)
         {
            case "xAxisFront":
               _loc6_ = true;
               break;
            case "xAxisBack":
               _loc7_ = true;
               break;
            case "yAxis":
               _loc8_ = true;
         }
         _loc5_.mechView.activateGetHitAnimation(_loc6_,_loc7_,_loc8_);
         _loc9_ = Math.ceil(Math.random() * 2);
         _loc10_ = "explosionSmall";
         if(_loc9_ == 1)
         {
            _loc10_ = "explosionMedium";
         }
         if(param3)
         {
            _loc11_ = 50;
            if(_loc5_.mechView.scaleX == -1)
            {
               _loc11_ = -50;
            }
            _loc12_ = _loc5_.mechView.torso;
            _loc13_ = new Point(_loc12_.x,_loc12_.y);
            _loc14_ = _loc12_.localToGlobal(_loc13_);
            _loc15_ = this.holder_main.globalToLocal(_loc14_);
            _loc16_ = 3;
            effectsM.createExplosion(_loc16_,_loc15_.x + _loc11_,_loc15_.y,50,30,20,2,7,2,this.holder_effects);
         }
         if(param4)
         {
            soundM.createSound(_loc10_,1);
         }
         this.createGetHitSound();
         this.createMechReflection(param1,false);
         if(dataM.battleSubType == "godMode")
         {
            if(dataM.getInterfacePlayerID(param1) == 2)
            {
               _loc9_ = Math.ceil(Math.random() * 3);
               if(_loc9_ == 1)
               {
                  _loc9_ = Math.ceil(Math.random() * 4);
                  soundM.createSound("godModeAngry" + _loc9_,1);
               }
            }
         }
      }
      
      private function activateGetHitSounds(param1:Number) : void
      {
         this._getHitSoundsHandler = true;
         if(dataM.slowCPUMode)
         {
            param1 = Math.ceil(param1 / 2);
         }
         this._getHitSoundsAllSoundsCountdown = param1;
         this._getHitSoundsSpecificSoundCountdown = 0;
      }
      
      private function deactivateGetHitSounds() : void
      {
         this._getHitSoundsHandler = false;
      }
      
      private function getHitSoundsHandler() : void
      {
         var _loc1_:BMPlayerData = null;
         if(this._getHitSoundsHandler)
         {
            if(this._getHitSoundsSpecificSoundCountdown == 0)
            {
               this.createGetHitSound();
               _loc1_ = dataM.playersData[this._opponentPlayerID];
               this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,false);
               this._getHitSoundsSpecificSoundCountdown = 5;
            }
            else
            {
               --this._getHitSoundsSpecificSoundCountdown;
            }
            --this._getHitSoundsAllSoundsCountdown;
            if(this._getHitSoundsAllSoundsCountdown == 0)
            {
               this._getHitSoundsHandler = false;
            }
         }
      }
      
      public function createGetHitSound() : void
      {
         soundM.createSound("getHit" + Math.ceil(Math.random() * 3),0.3);
      }
      
      private function bulletShellsHandler() : void
      {
         var _loc1_:Boolean = false;
         if(this._bulletShellsHandler)
         {
            --this._bulletShellsCounter;
            _loc1_ = false;
            switch(dataM.movieClipParticleEffectsLevel)
            {
               case 0:
                  break;
               case 1:
                  if(this._bulletShellsCounter % 6 == 0)
                  {
                     _loc1_ = true;
                  }
                  break;
               case 2:
                  if(this._bulletShellsCounter % 4 == 0)
                  {
                     _loc1_ = true;
                  }
                  break;
               case 3:
                  if(this._bulletShellsCounter % 2 == 0)
                  {
                     _loc1_ = true;
                  }
            }
            if(_loc1_)
            {
               effectsM.createSparksMC("screenBattle",this._bulletShellsGrp,this._bulletShellsXPos,this._bulletShellsYPos,1,1,30,this._bulletShellsDirection,"",true);
            }
            if(this._bulletShellsCounter <= 0)
            {
               this._bulletShellsHandler = false;
            }
         }
      }
      
      private function droneXScaleHandler() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMPlayerData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         if(this._droneXScaleHandler)
         {
            _loc1_ = dataM.playersData[dataM.player1PlayerID];
            _loc2_ = this.getMechSlot(dataM.player1PlayerID);
            _loc3_ = this._mechBattleDatas[_loc2_];
            if(_loc3_.mechView != null)
            {
               _loc4_ = dataM.playersData[dataM.player2PlayerID];
               _loc5_ = this.getMechSlot(dataM.player2PlayerID);
               _loc6_ = this._mechBattleDatas[_loc5_];
               if(_loc6_.mechView != null)
               {
                  if(_loc3_.drone != null)
                  {
                     if(_loc3_.droneActive)
                     {
                        if(_loc3_.drone.droneGrp.x > _loc6_.mechView.x)
                        {
                           _loc3_.drone.droneGrp.scaleX = -1;
                        }
                        else
                        {
                           _loc3_.drone.droneGrp.scaleX = 1;
                        }
                     }
                  }
                  if(_loc6_.drone != null)
                  {
                     if(_loc6_.droneActive)
                     {
                        if(_loc6_.drone.droneGrp.x > _loc3_.mechView.x)
                        {
                           _loc6_.drone.droneGrp.scaleX = -1;
                        }
                        else
                        {
                           _loc6_.drone.droneGrp.scaleX = 1;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function displayMechHologram(param1:Number, param2:Boolean) : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:BMMechView = null;
         var _loc7_:BMPlayerData = null;
         var _loc8_:String = null;
         var _loc9_:BMMechBattleData = null;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         if(dataM.runAsMobile == false)
         {
            _loc3_ = dataM.playersData[this._currentPlayerID];
            _loc4_ = this.getMechSlot(this._currentPlayerID);
            _loc5_ = this._mechBattleDatas[_loc4_];
            _loc6_ = _loc5_.mechView;
            _loc7_ = dataM.playersData[this._opponentPlayerID];
            _loc8_ = this.getMechSlot(this._opponentPlayerID);
            _loc9_ = this._mechBattleDatas[_loc8_];
            this.mechHologram.scaleX = _loc6_.scaleX;
            _loc10_ = false;
            if(param1 > _loc9_.currentStepVisual && _loc5_.currentStepVisual < _loc9_.currentStepVisual)
            {
               _loc10_ = true;
            }
            else if(param1 < _loc9_.currentStepVisual && _loc5_.currentStepVisual > _loc9_.currentStepVisual)
            {
               _loc10_ = true;
            }
            if(_loc10_)
            {
               this.mechHologram.scaleX *= -1;
            }
            _loc11_ = (param1 + 0.5) * this.FLOOR_STEP_SIZE;
            this.mechHologram.x = _loc11_;
            this.holder_effects.addChild(this.mechHologram);
            if(param2)
            {
               this.moveArrow.x = _loc11_;
               this.moveArrow.y = -this.mechHologram.height;
               this.moveArrow.gotoAndStop("animOn");
            }
         }
      }
      
      public function removeMechHologram() : void
      {
         if(dataM.runAsMobile == false)
         {
            if(this.mechHologram != null)
            {
               if(this.mechHologram.parent != null)
               {
                  this.mechHologram.parent.removeChild(this.mechHologram);
               }
            }
            this.moveArrow.gotoAndStop("animOff");
         }
      }
      
      private function clearMechHologram() : void
      {
         var _loc1_:BMMechView = null;
         if(dataM.runAsMobile == false)
         {
            if(this.mechHologram != null)
            {
               if(this.mechHologram.parent != null)
               {
                  this.mechHologram.parent.removeChild(this.mechHologram);
               }
               if(this.mechHologram.mechViewHolder != null)
               {
                  _loc1_ = this.mechHologram.mechViewHolder.mechView;
                  _loc1_.removeMe();
                  this.mechHologram.mechViewHolder = null;
               }
            }
         }
      }
      
      private function setPlayerAP(param1:Number, param2:Number) : void
      {
         var _loc3_:BMPlayerData = null;
         _loc3_ = dataM.playersData[param1];
         _loc3_.AP = param2;
         if(_loc3_.AP < 0)
         {
            _loc3_.AP = 0;
         }
      }
      
      private function replayActionCooldownHandler() : void
      {
         if(this._replayActionCooldownHandler)
         {
            if(this._replayActionCooldown > 0)
            {
               --this._replayActionCooldown;
            }
            else
            {
               this._replayActionCooldownHandler = false;
               this.playReplayAction();
            }
         }
      }
      
      private function playReplayAction() : void
      {
         var _loc1_:BMReplayAction = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMPlayerData = null;
         var _loc6_:BMMechView = null;
         var _loc7_:BMReplayStatus = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:uint = 0;
         var _loc11_:BMMechBattleData = null;
         var _loc12_:BMPlayerItemData = null;
         var _loc13_:BMItemData = null;
         var _loc14_:Object = null;
         var _loc15_:uint = 0;
         var _loc16_:String = null;
         var _loc17_:BMPlayerItemData = null;
         var _loc18_:BMItemData = null;
         var _loc19_:Number = NaN;
         var _loc20_:BMReplayStatus = null;
         if(this._clientDisconnected == false)
         {
            if(this._replayActionCooldown > 0)
            {
               this._replayActionCooldownHandler = true;
            }
            else if(dataM.battle_replayData.actions[this._replayActionSlot] != null)
            {
               _loc1_ = dataM.battle_replayData.actions[this._replayActionSlot];
               ++this._replayActionSlot;
               _loc2_ = this._replayActionSlot / (dataM.battle_replayData.actions.length - 1);
               screensM.screenBattleInterfaceTop.replayBar.setFill(_loc2_,true);
               if(_loc1_.actionName != "quit")
               {
                  this.resetBattleTurnDataLocally("playReplayAction");
                  _loc8_ = 1;
                  while(_loc8_ <= 2)
                  {
                     _loc5_ = dataM.playersData[dataM["player" + _loc8_ + "PlayerID"]];
                     _loc7_ = dataM.battle_replayData["status" + _loc8_][this._replayActionSlot];
                     _loc10_ = _loc5_.selectedMechID;
                     if(_loc1_.actionName == "switchMech")
                     {
                        if(_loc1_.playerNumber == _loc8_)
                        {
                           _loc10_ = _loc1_.mechID;
                           this._battleTurnData.set_selectedMechID(_loc8_,_loc10_);
                        }
                     }
                     _loc11_ = this._mechBattleDatas[dataM["player" + _loc8_ + "PlayerID"] + "_" + _loc10_];
                     if(_loc11_.dataSetByReplay == false)
                     {
                        if(_loc7_.HP > _loc11_.HPMax)
                        {
                           _loc11_.HPMax = _loc7_.HP;
                        }
                        _loc11_.HP = _loc11_.HPMax;
                        _loc11_.energyMax = _loc7_.energy;
                        _loc11_.energy = _loc11_.energyMax;
                        _loc11_.bulletsMax = _loc7_.bullets;
                        _loc11_.bullets = _loc11_.bulletsMax;
                        _loc11_.rocketsMax = _loc7_.rockets;
                        _loc11_.rockets = _loc11_.rocketsMax;
                        _loc11_.resist1 = _loc7_.resist1;
                        _loc11_.resist2 = _loc7_.resist2;
                        _loc11_.resist3 = _loc7_.resist3;
                        _loc11_.dataSetByReplay = true;
                     }
                     this._battleTurnData.set_AP(_loc8_,_loc7_.AP);
                     this._battleTurnData.set_step(_loc8_,_loc7_.step);
                     this._battleTurnData.set_HP(_loc8_,_loc7_.HP,_loc10_);
                     this._battleTurnData.set_heat(_loc8_,_loc7_.heat,_loc10_);
                     this._battleTurnData.set_energy(_loc8_,_loc7_.energy,_loc10_);
                     this._battleTurnData.set_bullets(_loc8_,_loc7_.bullets,_loc10_);
                     this._battleTurnData.set_rockets(_loc8_,_loc7_.rockets,_loc10_);
                     this._battleTurnData.set_shieldActive(_loc8_,_loc7_.shield,_loc10_);
                     this._battleTurnData.set_resist1(_loc8_,_loc7_.resist1,_loc10_);
                     this._battleTurnData.set_resist2(_loc8_,_loc7_.resist2,_loc10_);
                     this._battleTurnData.set_resist3(_loc8_,_loc7_.resist3,_loc10_);
                     _loc3_ = this.getMechSlot(dataM["player" + _loc8_ + "PlayerID"]);
                     _loc4_ = this._mechBattleDatas[_loc3_];
                     if(this._currentPlayerInterfacePlayerID == _loc8_)
                     {
                        if(_loc1_.actionName != "deactivateDrone" && _loc7_.drone == false && this._battleTurnData.get_droneActive(_loc8_))
                        {
                           _loc12_ = dataM.getPlayerItemData(dataM["player" + _loc8_ + "PlayerID"],_loc4_.mechStructure.drone);
                           _loc13_ = dataM.itemsDB[_loc12_.itemID];
                           _loc14_ = dataM.animationDB[_loc13_.animation];
                           _loc15_ = this.DELAY_NEW_ACTION_FRAMES_FIRE;
                           if(_loc14_.effectType == "chargeProjectile")
                           {
                              _loc15_ += 40;
                           }
                           _loc15_ = Math.ceil(_loc15_ * 0.7);
                           if(dataM.slowCPUMode)
                           {
                              _loc15_ = Math.ceil(_loc15_ / 2);
                           }
                           _loc4_.autoDeactivateDroneInXFrames(_loc15_);
                        }
                     }
                     this._battleTurnData.set_droneActive(_loc8_,_loc7_.drone);
                     _loc4_.currentStepCode = _loc7_.step;
                     _loc8_++;
                  }
                  if(dataM.getInterfacePlayerID(this._currentPlayerID) != _loc1_.playerNumber)
                  {
                     this.activateNextBattlePhase("turn_endTurnSuccess",{
                        "delayEndTurn":false,
                        "swapPlayersOnly":true
                     });
                  }
                  _loc8_ = 1;
                  while(_loc8_ <= 2)
                  {
                     _loc7_ = dataM.battle_replayData["status" + _loc8_][this._replayActionSlot];
                     if(_loc8_ == this._currentPlayerInterfacePlayerID)
                     {
                        _loc9_ = _loc7_.step;
                     }
                     _loc8_++;
                  }
               }
               this.refreshMechCodeStepMarker(1);
               this.refreshMechCodeStepMarker(2);
               _loc5_ = dataM.playersData[this._currentPlayerID];
               _loc3_ = this.getMechSlot(this._currentPlayerID);
               _loc4_ = this._mechBattleDatas[_loc3_];
               _loc6_ = _loc4_.mechView;
               if(_loc1_.actionName != "shutDown" && _loc6_.shutDownActive)
               {
                  --this._replayActionSlot;
                  _loc6_.deactivateShutdown(this.playReplayAction);
               }
               else
               {
                  this.refreshMechsDepth();
                  this._replayActionCooldown = this.REPLAY_COOLDOWN;
                  switch(_loc1_.actionName)
                  {
                     case "switchMech":
                        this.activateNextBattlePhase("action_switchMechSuccess",{"mechID":_loc1_.mechID});
                        break;
                     case "fire":
                        this.activateNextBattlePhase("action_fireSuccess",{
                           "equipmentType":_loc1_.equipmentType,
                           "equipmentID":_loc1_.equipmentID
                        });
                        _loc16_ = _loc1_.equipmentType;
                        if(_loc1_.equipmentID > 0)
                        {
                           _loc16_ += _loc1_.equipmentID;
                        }
                        _loc17_ = dataM.getPlayerItemData(this._currentPlayerID,_loc4_.mechStructure[_loc16_]);
                        _loc18_ = dataM.itemsDB[_loc17_.itemID];
                        if(_loc18_.animation.substr(0,5) == "stomp")
                        {
                           this._replayActionCooldown += 7;
                        }
                        else if(_loc18_.animation.substr(0,5) == "sword")
                        {
                           this._replayActionCooldown += 7;
                        }
                        break;
                     case "moveMechToStep":
                        this.activateNextBattlePhase("action_moveMechToStepSuccess",{
                           "motionType":_loc1_.motionType,
                           "targetStep":_loc9_
                        });
                        break;
                     case "shutDown":
                        this.activateNextBattlePhase("action_shutDownSuccess");
                        break;
                     case "activateDrone":
                        this.activateDroneSuccess();
                        break;
                     case "deactivateDrone":
                        this.activateNextBattlePhase("action_deactivateDroneSuccess");
                        break;
                     case "activateShield":
                        this.activateShieldSuccess();
                        break;
                     case "deactivateShield":
                        this.deactivateShieldSuccess();
                        break;
                     case "teleport":
                        screensM.screenBattle.activateNextBattlePhase("action_teleportSuccess",{"targetStep":_loc9_});
                        break;
                     case "charge":
                        this.activateNextBattlePhase("action_chargeSuccess");
                        break;
                     case "harpoon":
                        this.activateNextBattlePhase("action_harpoonSuccess");
                        break;
                     case "useKit":
                        this.activateNextBattlePhase("action_useKitSuccess",{"equipmentID":_loc1_.equipmentID});
                        break;
                     case "quit":
                        screensM.screenConfirmation.displayQuestionOrNotification("replayEnded_playerQuit",_loc1_.playerNumber,-1);
                        break;
                     case "battleResult":
                        TsLogger.log("playReplayAction - battleResult");
                  }
               }
            }
            else
            {
               _loc19_ = 1;
               _loc20_ = dataM.battle_replayData.status1[this._replayActionSlot - 1];
               if(_loc20_.HP <= 0)
               {
                  _loc19_ = 2;
               }
               screensM.screenConfirmation.displayQuestionOrNotification("replayEnded_battleOver",_loc19_,-1);
            }
         }
      }
      
      public function endReplay() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.screenBlack.activateBlackScreen(this.endReplaySub,true,true,null,0);
         }
         else
         {
            this.endReplaySub();
         }
      }
      
      private function endReplaySub() : void
      {
         this.cleanBattle(false);
      }
      
      public function surrender() : void
      {
         remoteM.battle_surrender();
      }
      
      public function surrenderSuccess() : void
      {
         var _loc1_:Boolean = false;
         screensM.removeScreen("screenConfirmation");
         _loc1_ = false;
         this.sendEndBattleAnalyticsEvent();
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false && dataM.battle_inBattleInvitation == false)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            screensM.addScreen("screenLadderStatus");
            screensM.screenLadderStatus.refreshScreen();
         }
         else
         {
            this.returnToLobbySuccess();
         }
      }
      
      private function enableTopInterfaceButtons() : void
      {
         screensM.screenBattleInterfaceTop.btnQuit.visible = true;
         if(dataM.playingVSComputer)
         {
            if(dataM.isTutorialActive())
            {
               screensM.screenBattleInterfaceTop.btnQuit.visible = false;
            }
         }
         screensM.screenBattleInterfaceTop.btnQuit.enableMe();
         screensM.screenBattleInterfaceTop.btnOptions.enableMe();
         screensM.screenBattleInterfaceTop.btnZoomIn.enableMe();
         screensM.screenBattleInterfaceTop.btnZoomOut.enableMe();
         screensM.screenBattleInterfaceTop.btnEmotesOpen.enableMe();
         screensM.screenBattleInterfaceTop.btnEmotesClose.enableMe();
         screensM.screenBattleInterfaceTop.btnPauseReplay.enableMe();
         screensM.screenBattleInterfaceTop.btnPlayReplay.enableMe();
      }
      
      public function clientDisconnected() : void
      {
         this._clientDisconnected = true;
      }
      
      private function socketCallsHandler() : void
      {
         var _loc1_:Object = null;
         if(this._clientDisconnected == false)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false && this._waitingForMechToBeDestroyed == false)
            {
               this._LASTsocketActionAllowed = this._socketActionAllowed;
               if(this._socketActionAllowed)
               {
                  remoteM.socketM.excecuteBattleCall();
               }
            }
            else if(this._socketActionAllowed)
            {
               if(this._singlePlayerActions[this._singlePlayerActionSlot] != null)
               {
                  _loc1_ = this._singlePlayerActions[this._singlePlayerActionSlot];
                  switch(_loc1_.action)
                  {
                     case "shutDown":
                        this.activateNextBattlePhase("action_shutDownLocallySub",{"multiplier":_loc1_.value});
                        break;
                     case "energyRegeneration":
                        this.activateNextBattlePhase("action_energyRegenerationLocallySub");
                        break;
                     case "deactivateShield":
                        this.activateNextBattlePhase("action_deactivateShieldLocallySub");
                        break;
                     case "activateShield":
                        this.activateNextBattlePhase("action_activateShieldLocallySub");
                        break;
                     case "deactivateDrone":
                        this.activateNextBattlePhase("action_deactivateDroneLocallySub");
                        break;
                     case "activateDrone":
                        this.activateNextBattlePhase("action_activateDroneLocallySub");
                        break;
                     case "useKit":
                        this.activateNextBattlePhase("action_useKitLocallySub",{"equipmentID":_loc1_.value});
                        break;
                     case "fireSuccess":
                        this.activateNextBattlePhase("action_fireLocallySub",{
                           "equipmentType":_loc1_.string,
                           "equipmentID":_loc1_.value
                        });
                        break;
                     case "moveMechToStep":
                        this.activateNextBattlePhase("action_moveMechToStepLocallySub",{
                           "motionType":_loc1_.string,
                           "targetStep":_loc1_.value
                        });
                        break;
                     case "teleport":
                        this.activateNextBattlePhase("action_teleportLocallySub",{"targetStep":_loc1_.value});
                        break;
                     case "charge":
                        this.activateNextBattlePhase("action_chargeLocallySub");
                        break;
                     case "crash":
                        this.activateNextBattlePhase("action_crashLocallySub");
                        break;
                     case "harpoon":
                        this.activateNextBattlePhase("action_harpoonLocallySub");
                        break;
                     case "switchMech":
                        this.switchMechLocallySub(_loc1_.value);
                  }
                  if(this._currentPlayerID == dataM.player1PlayerID)
                  {
                     if(this._battleTurnData.get_AP(1) > 0 && this._battleTurnData.get_HP(2) > 0)
                     {
                        if(this._skipNexySocketCallsHandlerEnbaleInterface)
                        {
                           this._skipNexySocketCallsHandlerEnbaleInterface = false;
                        }
                        else
                        {
                           this.enableInterface("socketCallsHandler VS computer");
                        }
                     }
                     else
                     {
                        this.disableInterface("socketCallsHandler VS computer");
                        this.hideInterface("socketCallsHandler VS computer");
                     }
                  }
                  ++this._singlePlayerActionSlot;
               }
            }
         }
      }
      
      private function addSinglePlayerAction(param1:String, param2:Number, param3:String) : void
      {
         var _loc4_:Object = null;
         _loc4_ = new Object();
         _loc4_.action = param1;
         _loc4_.value = param2;
         _loc4_.string = param3;
         this._singlePlayerActions.push(_loc4_);
      }
      
      private function setSocketAllowedStatus(param1:Boolean, param2:String) : void
      {
         this._socketActionAllowed = param1;
      }
      
      public function syncClientWithServer(param1:Object, param2:Boolean) : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:BMPlayerData = null;
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerData = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Object = null;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Number = NaN;
         var _loc14_:String = null;
         var _loc15_:BMMechBattleData = null;
         var _loc16_:uint = 0;
         var _loc17_:String = null;
         var _loc18_:BMMechBattleData = null;
         this.resetBattleTurnDataLocally("syncClientWithServer");
         _loc3_ = dataM.playersData[dataM.player1PlayerID];
         _loc4_ = dataM.playersData[dataM.player2PlayerID];
         _loc5_ = 1;
         while(_loc5_ <= 2)
         {
            if(_loc3_.battlePlayerID == _loc5_)
            {
               _loc6_ = _loc3_;
               _loc7_ = dataM.player1PlayerID;
               _loc8_ = dataM.getInterfacePlayerID(_loc7_);
            }
            else
            {
               _loc6_ = _loc4_;
               _loc7_ = dataM.player2PlayerID;
               _loc8_ = dataM.getInterfacePlayerID(_loc7_);
            }
            _loc9_ = param1["player" + _loc5_];
            _loc16_ = 1;
            while(_loc16_ <= dataM.battleMechsPerPlayer)
            {
               this._battleTurnData.set_HP(_loc8_,_loc9_.mechs[_loc16_].HP,_loc16_);
               this._battleTurnData.set_energy(_loc8_,_loc9_.mechs[_loc16_].energy,_loc16_);
               this._battleTurnData.set_heat(_loc8_,_loc9_.mechs[_loc16_].heat,_loc16_);
               this._battleTurnData.set_bullets(_loc8_,_loc9_.mechs[_loc16_].bullets,_loc16_);
               this._battleTurnData.set_rockets(_loc8_,_loc9_.mechs[_loc16_].rockets,_loc16_);
               _loc10_ = false;
               if(_loc9_.mechs[_loc16_].shieldActive == 1)
               {
                  _loc10_ = true;
               }
               this._battleTurnData.set_shieldActive(_loc8_,_loc10_,_loc16_);
               _loc11_ = false;
               if(_loc9_.mechs[_loc16_].droneActive == 1)
               {
                  _loc11_ = true;
               }
               this._battleTurnData.set_droneActive(_loc8_,_loc11_,_loc16_);
               _loc12_ = false;
               if(_loc9_.mechs[_loc16_].droneFired == 1)
               {
                  _loc12_ = true;
               }
               this._battleTurnData.set_droneFired(_loc8_,_loc12_,_loc16_);
               this._battleTurnData.set_resist1(_loc8_,_loc9_.mechs[_loc16_].resist1,_loc16_);
               this._battleTurnData.set_resist2(_loc8_,_loc9_.mechs[_loc16_].resist2,_loc16_);
               this._battleTurnData.set_resist3(_loc8_,_loc9_.mechs[_loc16_].resist3,_loc16_);
               _loc16_++;
            }
            _loc13_ = Number(_loc9_.currentStep);
            if(dataM.battle_clientInverted)
            {
               _loc13_ = dataM.getClientInvertedStep(_loc9_.currentStep);
            }
            this._battleTurnData.set_step(_loc8_,_loc13_);
            _loc14_ = this.getMechSlot(_loc7_);
            _loc15_ = this._mechBattleDatas[_loc14_];
            _loc15_.currentStepCode = this._battleTurnData.get_step(_loc8_);
            this._battleTurnData.set_AP(_loc8_,_loc9_.AP);
            if(param2 && _loc5_ == 1)
            {
               if(_loc9_.AP == 1)
               {
                  _loc6_.AP = 1;
                  screensM.screenBattleInterfaceTop.refreshAP(_loc7_);
               }
            }
            this._battleTurnData.set_selectedMechID(_loc8_,_loc9_.mechID);
            if(_loc7_ != this._currentPlayerID)
            {
               if(_loc6_.selectedMechID != _loc9_.mechID)
               {
                  _loc17_ = this.getMechSlot(_loc7_,_loc6_.selectedMechID);
                  _loc18_ = this._mechBattleDatas[_loc17_];
                  _loc18_.HP = 0;
                  this._waitingForMechToBeDestroyed = true;
               }
            }
            _loc5_++;
         }
         this._reEnableBottomInterface = false;
         if(this._currentPlayerID == dataM.player1PlayerID)
         {
            if(this._battleTurnData.get_AP(1) > 0)
            {
               if(this._battleTurnData.get_HP(2) > 0)
               {
                  this._reEnableBottomInterface = true;
               }
            }
         }
      }
      
      public function checkForReEnablingBottomInterface() : void
      {
         if(this._reEnableBottomInterface)
         {
            this._interfaceEnabled = true;
            screensM.screenBattleInterfaceBottom.showInterface("battle checkForReEnablingBottomInterface");
            screensM.screenBattleInterfaceBottom.enableInterface("battle checkForReEnablingBottomInterface");
            this._reEnableBottomInterface = false;
            this._skipStartNewActionEnbaleInterface = true;
         }
      }
      
      private function singlePlayerCheckForReEnablingInterface() : Boolean
      {
         var _loc1_:Boolean = false;
         _loc1_ = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST || dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer)
         {
            if(this._currentPlayerID == dataM.player1PlayerID)
            {
               if(this._battleTurnData.get_AP(1) > 0)
               {
                  if(this._battleTurnData.get_HP(2) > 0)
                  {
                     _loc1_ = true;
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function opponentMechTooltipHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:BMPlayerData = null;
         var _loc9_:String = null;
         var _loc10_:BMMechBattleData = null;
         var _loc11_:BMMechView = null;
         var _loc12_:BMPlayerData = null;
         var _loc13_:String = null;
         var _loc14_:BMMechBattleData = null;
         var _loc15_:BMMechView = null;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:BMFloorBuff = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:BMPlayerProfile = null;
         var _loc22_:Point = null;
         var _loc23_:Point = null;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:MovieClip = null;
         var _loc28_:Point = null;
         var _loc29_:Point = null;
         var _loc30_:Point = null;
         var _loc31_:Number = NaN;
         var _loc32_:String = null;
         var _loc33_:Number = NaN;
         var _loc34_:Boolean = false;
         var _loc35_:Number = NaN;
         var _loc36_:MovieClip = null;
         var _loc37_:Point = null;
         var _loc38_:Point = null;
         var _loc39_:Point = null;
         var _loc40_:uint = 0;
         var _loc41_:BMFloorBuff = null;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:BMPlayerItemData = null;
         var _loc45_:BMItemData = null;
         var _loc46_:Number = NaN;
         var _loc47_:Number = NaN;
         var _loc48_:Number = NaN;
         var _loc49_:Number = NaN;
         var _loc50_:Number = NaN;
         var _loc51_:Number = NaN;
         var _loc52_:Number = NaN;
         var _loc53_:Number = NaN;
         var _loc54_:Boolean = false;
         var _loc55_:Boolean = false;
         var _loc56_:Boolean = false;
         switch(dataM.battleType)
         {
            case "regular":
            case "mission":
            case "dungeon":
               _loc1_ = 9999;
               _loc4_ = 9999;
               _loc8_ = dataM.playersData[dataM.player2PlayerID];
               _loc9_ = this.getMechSlot(dataM.player2PlayerID);
               _loc10_ = this._mechBattleDatas[_loc9_];
               _loc16_ = true;
               if(mouseY <= 108)
               {
                  _loc16_ = false;
               }
               else if(screensM.isScreenOpened("screenBattleInterfaceEmotes"))
               {
                  if(mouseY <= 180)
                  {
                     if(mouseX >= 220 && mouseX <= 580)
                     {
                        _loc16_ = false;
                     }
                  }
               }
               if(_loc16_)
               {
                  if(_loc10_.mechView != null)
                  {
                     _loc11_ = _loc10_.mechView;
                     if(_loc11_.entryAnimationActive() == false)
                     {
                        _loc12_ = dataM.playersData[dataM.player1PlayerID];
                        _loc13_ = this.getMechSlot(dataM.player1PlayerID);
                        _loc14_ = this._mechBattleDatas[_loc13_];
                        if(_loc14_.mechView != null)
                        {
                           _loc15_ = _loc14_.mechView;
                           _loc17_ = true;
                           if(dataM.runAsMobile)
                           {
                              if(screensM.mobileMouseDown == false || screensM.mobileMouseDownFrames < this.MOBILE_MOUSE_DOWN_FRAMES_FOR_BATTLE_TOOLTIP)
                              {
                                 _loc17_ = false;
                              }
                           }
                           if(_loc17_)
                           {
                              if(screensM.screenBattleInterfaceBottom.isMoveMechToStepActive() == false && screensM.secondaryBattleScreensOpenedIgnoringBattleBonus == false && _loc10_.HP > 0)
                              {
                                 _loc21_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                                 if(_loc21_.winsVSComputer >= dataM.TUTORIAL_BATTLES)
                                 {
                                    if(dataM.runAsMobile)
                                    {
                                       _loc22_ = new Point(mouseX,mouseY + screensM.MOBILE_FINAL_BORDER_ADDON);
                                    }
                                    else
                                    {
                                       _loc22_ = new Point(mouseX,mouseY);
                                    }
                                    _loc23_ = this.holder_main.globalToLocal(_loc22_);
                                    _loc27_ = _loc11_.torso;
                                    _loc28_ = new Point(_loc27_.x + _loc27_.width / 2,_loc27_.y + _loc27_.height / 2);
                                    _loc29_ = _loc27_.localToGlobal(_loc28_);
                                    _loc30_ = this.holder_main.globalToLocal(_loc29_);
                                    _loc24_ = _loc30_.x - _loc23_.x;
                                    _loc25_ = _loc30_.y - _loc23_.y;
                                    _loc26_ = dataM.getVectorSize(_loc24_,_loc25_);
                                    if(_loc23_.y < 40 && _loc26_ < this.INSPECT_OPPONENT_WEAPONS_RANGE / this._viewScale)
                                    {
                                       _loc31_ = 1;
                                       while(_loc31_ <= 4)
                                       {
                                          _loc34_ = false;
                                          switch(_loc31_)
                                          {
                                             case 1:
                                                _loc32_ = "sideWeapon";
                                                _loc33_ = 4;
                                                break;
                                             case 2:
                                                _loc32_ = "topWeapon";
                                                _loc33_ = 2;
                                                break;
                                             case 3:
                                                _loc32_ = "leg";
                                                _loc33_ = 1;
                                                if(this._ignoreLegTooltip)
                                                {
                                                   _loc34_ = true;
                                                }
                                                break;
                                             case 4:
                                                _loc32_ = "drone";
                                                _loc33_ = 1;
                                          }
                                          if(_loc34_ == false)
                                          {
                                             _loc35_ = 1;
                                             while(_loc35_ <= _loc33_)
                                             {
                                                switch(_loc32_)
                                                {
                                                   case "sideWeapon":
                                                   case "topWeapon":
                                                      _loc19_ = _loc32_ + _loc35_;
                                                      _loc20_ = _loc32_ + _loc35_;
                                                      break;
                                                   case "leg":
                                                      _loc19_ = "leg";
                                                      _loc20_ = "leg1";
                                                      break;
                                                   case "drone":
                                                      _loc19_ = "drone";
                                                      _loc20_ = "drone";
                                                }
                                                if(_loc10_.mechStructure[_loc19_] > 0)
                                                {
                                                   if(_loc19_ != "drone" || _loc19_ == "drone" && _loc10_.droneActive)
                                                   {
                                                      if(_loc19_ == "drone")
                                                      {
                                                         _loc36_ = _loc10_.drone.droneGrp;
                                                         _loc37_ = new Point(_loc36_.x,_loc36_.y);
                                                      }
                                                      else
                                                      {
                                                         _loc36_ = _loc11_[_loc20_];
                                                         _loc38_ = new Point(_loc36_.x,_loc36_.y);
                                                         _loc39_ = _loc36_.localToGlobal(_loc38_);
                                                         _loc37_ = this.holder_main.globalToLocal(_loc39_);
                                                      }
                                                      _loc24_ = _loc37_.x - _loc23_.x;
                                                      _loc25_ = _loc37_.y - _loc23_.y;
                                                      _loc26_ = dataM.getVectorSize(_loc24_,_loc25_);
                                                      if(_loc1_ > _loc26_)
                                                      {
                                                         _loc1_ = _loc26_;
                                                         _loc2_ = _loc32_;
                                                         _loc3_ = _loc35_;
                                                      }
                                                   }
                                                }
                                                _loc35_++;
                                             }
                                          }
                                          _loc31_++;
                                       }
                                    }
                                    if(_loc23_.y < 40 && _loc23_.y > -120)
                                    {
                                       _loc40_ = 0;
                                       while(_loc40_ < this._floorBuffs.length)
                                       {
                                          _loc41_ = this._floorBuffs[_loc40_];
                                          if(_loc41_ != null)
                                          {
                                             _loc24_ = _loc41_.x - _loc23_.x;
                                             _loc25_ = _loc41_.y - _loc23_.y;
                                             _loc26_ = dataM.getVectorSize(_loc24_,_loc25_);
                                             if(_loc4_ > _loc26_)
                                             {
                                                _loc4_ = _loc26_;
                                                if(_loc4_ < 100)
                                                {
                                                   _loc5_ = _loc41_.type;
                                                   _loc6_ = _loc41_.subType;
                                                   _loc7_ = _loc41_.step;
                                                }
                                             }
                                          }
                                          _loc40_++;
                                       }
                                    }
                                 }
                              }
                           }
                           if(_loc2_ != null)
                           {
                              if(this._opponentMechTooltipType != _loc2_ || this._opponentMechTooltipEquipmentID != _loc3_)
                              {
                                 this._lastOpponentMechTooltipType = this._opponentMechTooltipType;
                                 this._opponentMechTooltipType = _loc2_;
                                 this._opponentMechTooltipEquipmentID = _loc3_;
                                 switch(this._opponentMechTooltipType)
                                 {
                                    case "sideWeapon":
                                    case "topWeapon":
                                       _loc19_ = this._opponentMechTooltipType + this._opponentMechTooltipEquipmentID;
                                       _loc20_ = this._opponentMechTooltipType + this._opponentMechTooltipEquipmentID;
                                       break;
                                    case "leg":
                                       _loc19_ = "leg";
                                       _loc20_ = "leg1";
                                       break;
                                    case "drone":
                                       _loc19_ = "drone";
                                       _loc20_ = "drone";
                                 }
                                 _loc11_.removeAllItemsStaticGlow();
                                 _loc10_.removeDroneStaticGlow();
                                 if(_loc20_ == "drone")
                                 {
                                    _loc10_.addDroneStaticGlow("lightGreen");
                                 }
                                 else
                                 {
                                    _loc11_.addItemStaticGlow(_loc20_,"lightGreen");
                                 }
                                 this.actionRange.hideMe();
                                 _loc15_.removeAnimatedGlow();
                                 screensM.screenBattleInterfaceBottom.deactivateActionErrorMessage();
                                 screensM.screenBattleInterfaceBottom.player1MechBattleTooltip.hideToolTip(false);
                                 screensM.screenBattleInterfaceBottom.player2MechBattleTooltip.hideToolTip(false);
                                 screensM.screenBattleInterfaceBottom.player1MechBattleTooltip.displayToolTip(dataM.player2PlayerID,this._opponentMechTooltipType,this._opponentMechTooltipEquipmentID);
                                 screensM.screenBattleInterfaceBottom.player2MechBattleTooltip.displayToolTip(dataM.player2PlayerID,this._opponentMechTooltipType,this._opponentMechTooltipEquipmentID);
                                 _loc44_ = dataM.getPlayerItemData(dataM.player2PlayerID,_loc10_.mechStructure[_loc19_]);
                                 _loc45_ = dataM.itemsDB[_loc44_.itemID];
                                 _loc42_ = _loc45_.rangeBase;
                                 _loc43_ = _loc45_.rangeAddon;
                                 _loc47_ = _loc46_ = _loc10_.currentStepVisual;
                                 _loc49_ = _loc48_ = _loc14_.currentStepVisual;
                                 _loc50_ = this.FLOOR_STEP_SIZE / 2;
                                 _loc51_ = Number(dataM.battleData.map.stepsTotal);
                                 if(_loc46_ > _loc48_)
                                 {
                                    _loc52_ = 0;
                                    if(_loc47_ - _loc42_ >= 0)
                                    {
                                       if(_loc47_ - (_loc42_ + _loc43_) >= 0)
                                       {
                                          _loc52_ = _loc47_ - (_loc42_ + _loc43_);
                                          _loc53_ = _loc43_;
                                       }
                                       else
                                       {
                                          _loc53_ = _loc47_ - _loc42_;
                                       }
                                    }
                                    else
                                    {
                                       _loc53_ = 0;
                                    }
                                 }
                                 else if(_loc47_ + _loc42_ < _loc51_)
                                 {
                                    _loc52_ = _loc47_ + _loc42_ + 1;
                                    if(_loc47_ + (_loc42_ + _loc43_) < _loc51_)
                                    {
                                       _loc53_ = _loc43_;
                                    }
                                    else
                                    {
                                       _loc53_ = _loc51_ - (_loc47_ + _loc42_);
                                    }
                                 }
                                 else
                                 {
                                    _loc52_ = _loc51_ + 1;
                                    _loc53_ = 0;
                                 }
                                 _loc54_ = true;
                                 _loc55_ = true;
                                 if(_loc42_ == 0)
                                 {
                                    if(_loc46_ > _loc48_)
                                    {
                                       _loc55_ = false;
                                    }
                                    else
                                    {
                                       _loc54_ = false;
                                    }
                                 }
                                 _loc56_ = this.isOpponentInWeaponRange(this.currentPlayerID,this.opponentPlayerID,_loc45_.itemID,-1,-1,-1);
                                 if(_loc56_)
                                 {
                                    _loc15_.addAnimatedGlow();
                                 }
                                 this.actionRange.displayRange(_loc52_,_loc53_,null,_loc54_,_loc55_,"red");
                              }
                           }
                           if(_loc5_ != null)
                           {
                              if(this._lastFloorBuffStep != _loc7_)
                              {
                                 if(this._lastFloorBuffStep > -1)
                                 {
                                    _loc18_ = this._floorBuffs[this._lastFloorBuffStep];
                                    _loc18_.deactivateMouseOverEffect();
                                 }
                                 this._lastFloorBuffStep = _loc7_;
                                 _loc18_ = this._floorBuffs[this._lastFloorBuffStep];
                                 _loc18_.activateMouseOverEffect();
                                 tooltip.showToolTip("floorBuff",_loc5_,_loc6_,-1);
                              }
                           }
                           else if(tooltip.currentTooltipType == "floorBuff")
                           {
                              if(this._lastFloorBuffStep > -1)
                              {
                                 _loc18_ = this._floorBuffs[this._lastFloorBuffStep];
                                 _loc18_.deactivateMouseOverEffect();
                              }
                              this._lastFloorBuffStep = -1;
                              tooltip.hideToolTip();
                           }
                        }
                     }
                  }
               }
               if(_loc2_ == null)
               {
                  if(this._opponentMechTooltipType != "")
                  {
                     this._opponentMechTooltipType = "";
                     this._opponentMechTooltipEquipmentID = 0;
                     if(_loc10_ != null)
                     {
                        _loc10_.removeDroneStaticGlow();
                        if(_loc11_ != null)
                        {
                           _loc11_.removeAllItemsStaticGlow();
                        }
                     }
                     this.actionRange.hideMe();
                     screensM.screenBattleInterfaceBottom.deactivateActionErrorMessage();
                     screensM.screenBattleInterfaceBottom.player1MechBattleTooltip.hideToolTip(false);
                     screensM.screenBattleInterfaceBottom.player2MechBattleTooltip.hideToolTip(false);
                     if(_loc16_)
                     {
                        if(_loc14_ != null)
                        {
                           if(_loc15_ != null)
                           {
                              _loc15_.removeAnimatedGlow();
                           }
                        }
                     }
                     else if(_loc10_.mechView != null)
                     {
                        _loc11_ = _loc10_.mechView;
                        if(_loc11_.entryAnimationActive() == false)
                        {
                           _loc12_ = dataM.playersData[dataM.player1PlayerID];
                           _loc13_ = this.getMechSlot(dataM.player1PlayerID);
                           _loc14_ = this._mechBattleDatas[_loc13_];
                           if(_loc14_ != null)
                           {
                              if(_loc14_.mechView != null)
                              {
                                 _loc14_.mechView.removeAnimatedGlow();
                              }
                           }
                        }
                     }
                  }
                  else if(this._lastOpponentMechTooltipType != "")
                  {
                     this._lastOpponentMechTooltipType = "";
                     if(_loc14_ != null)
                     {
                        if(_loc15_ != null)
                        {
                           _loc15_.removeAnimatedGlow();
                        }
                     }
                  }
               }
         }
      }
      
      public function switchMechClicked(param1:Number) : void
      {
         this.disableInterface("switchMechClicked");
         remoteM.battle_switchMech(param1);
      }
      
      public function switchMechLocally(param1:uint) : void
      {
         this.addSinglePlayerAction("switchMech",param1,"");
      }
      
      private function switchMechLocallySub(param1:uint) : void
      {
         this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         this._battleTurnData.set_selectedMechID(this._currentPlayerInterfacePlayerID,param1);
         this.disableInterface("switchMechClicked");
         this.switchMechSuccess(param1);
      }
      
      public function switchMechSuccess(param1:uint) : void
      {
         var _loc2_:BMPlayerData = null;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         this.setSocketAllowedStatus(false,"switchMechSuccess");
         this._lastAction = "switchMech";
         _loc2_ = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         if(_loc4_ != null)
         {
            if(_loc4_.mechView != null)
            {
               if(_loc4_.drone != null)
               {
                  _loc4_.drone.removeMe();
                  _loc4_.drone = null;
               }
               _loc4_.mechView.removeMe();
               _loc4_.mechView = null;
            }
         }
         if(_loc2_.selectedMechID != param1)
         {
            this.spawnMech(this._currentPlayerID,param1);
         }
         ++_loc2_["switchMech" + param1 + "Uses"];
      }
      
      public function mechDestroyedSuccess() : void
      {
         TsLogger.log(">>>>>>>>>>> MECH DESTROYED PYTHON");
      }
      
      private function spawnMech(param1:uint, param2:uint) : void
      {
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:BMPlayerData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:Number = NaN;
         var _loc8_:BMMechView = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         _loc3_ = dataM["player" + param1 + "Profile"];
         _loc4_ = dataM.playersData[param1];
         _loc5_ = this.getMechSlot(param1);
         _loc6_ = this._mechBattleDatas[_loc5_];
         if(!(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false))
         {
            this._battleTurnData.set_step(dataM.getInterfacePlayerID(param1),_loc6_.currentStepCode);
         }
         _loc7_ = this._battleTurnData.get_step(dataM.getInterfacePlayerID(param1));
         _loc4_.selectedMechID = param2;
         _loc5_ = this.getMechSlot(param1);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc6_.currentStepCode = _loc7_;
         _loc6_.currentStepVisual = _loc7_;
         _loc6_.resetAlreadyFired();
         this.createMechView(param1,param2);
         _loc8_ = _loc6_.mechView;
         _loc9_ = _loc8_.mechSizer.width * 1.8;
         _loc10_ = _loc8_.x;
         _loc11_ = _loc8_.y + 30;
         var _loc12_:String = "";
         if(dataM.slowCPUMode)
         {
            _loc12_ = "_fast";
         }
         effectsM.createTeleportReappear("teleportReappearAnim",_loc10_,_loc11_,_loc9_,this.holder_effects);
         soundM.createSound("teleportAppear",1);
         this.refreshMechsView();
         screensM.screenBattleInterfaceTop.refreshLevelAndRank(param1);
         screensM.screenBattleInterfaceTop.refreshHP(param1,false);
         screensM.screenBattleInterfaceTop.refreshEnergy(param1,false);
         screensM.screenBattleInterfaceTop.refreshHeat(param1,false);
         screensM.screenBattleInterfaceTop.refreshBullets(param1,false);
         screensM.screenBattleInterfaceTop.refreshRockets(param1,false);
         screensM.screenBattleInterfaceTop.refreshResistance(param1,1,false);
         screensM.screenBattleInterfaceTop.refreshResistance(param1,2,false);
         screensM.screenBattleInterfaceTop.refreshResistance(param1,3,false);
         screensM.screenBattleInterfaceTop.refreshAP(param1);
         if(_loc3_.clanID == 0)
         {
            screensM.screenBattleInterfaceTop.showAvatarImage(false,dataM.getInterfacePlayerID(param1));
         }
         if(dataM.playingVSComputer)
         {
            screensM.screenBattleInterfaceTop.setNameAndFlag(param1,"");
         }
         if(_loc6_.droneActive)
         {
            this.setSocketAllowedStatus(true,"spawnMech - droneActive");
         }
         this._resumeBattleAfterSpawning = true;
         this._resumeBattleAfterSpawningCountdown = 40;
         if(param1 == this._currentPlayerID)
         {
            this.setNewDataForAttacker();
         }
         else
         {
            this.setNewDataForDefender(false);
         }
      }
      
      private function resumeBattleAfterSpawningHandler() : void
      {
         if(this._resumeBattleAfterSpawning)
         {
            if(this._resumeBattleAfterSpawningCountdown > 0)
            {
               --this._resumeBattleAfterSpawningCountdown;
               if(this._resumeBattleAfterSpawningCountdown == 0)
               {
                  this._resumeBattleAfterSpawning = false;
                  this.activateNextBattlePhase("turn_actionPerformedSubEnding");
               }
            }
         }
      }
      
      private function playerTauntsHandler() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         var _loc5_:Boolean = false;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:Point = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         _loc2_ = this.getMechSlot(dataM.player1PlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.mechView;
         _loc5_ = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false && screensM.isScreenOpened("screenVS") == false)
         {
            if(this._currentPlayerID == dataM.player2PlayerID && _loc3_.HP > 0)
            {
               if(_loc4_ != null)
               {
                  if(_loc4_.getActiveAnimations().length == 0 && _loc4_.shutDownActive == false)
                  {
                     _loc6_ = new Point(mouseX,mouseY);
                     _loc7_ = this.holder_main.globalToLocal(_loc6_);
                     _loc8_ = _loc4_.torso;
                     _loc9_ = new Point(_loc8_.x + _loc8_.width / 2,_loc8_.y + _loc8_.height / 2);
                     _loc10_ = _loc8_.localToGlobal(_loc9_);
                     _loc11_ = this.holder_main.globalToLocal(_loc10_);
                     _loc12_ = _loc11_.x - _loc7_.x;
                     _loc13_ = _loc11_.y - _loc7_.y;
                     _loc14_ = dataM.getVectorSize(_loc12_,_loc13_);
                     if(_loc14_ < 100)
                     {
                        _loc5_ = true;
                     }
                  }
               }
            }
         }
         if(this._playerMechRollOver)
         {
            if(_loc5_ == false)
            {
               _loc4_.removeAllItemsStaticGlow();
               this._playerMechRollOver = false;
               tooltip.hideToolTip();
            }
         }
      }
      
      public function mouseHitAreaClicked() : void
      {
      }
      
      public function tauntClicked(param1:Number) : void
      {
         if(this._waitingForTaunt == false)
         {
            this._waitingForTaunt = true;
            remoteM.battle_taunt(param1);
         }
      }
      
      public function activateTaunt(param1:Number, param2:Number) : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:Number = NaN;
         var _loc5_:BMPlayerData = null;
         var _loc6_:String = null;
         var _loc7_:BMMechBattleData = null;
         var _loc8_:BMMechView = null;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:Array = null;
         var _loc12_:Boolean = false;
         this._waitingForTaunt = false;
         this._playerMechRollOver = false;
         tooltip.hideToolTip();
         _loc3_ = dataM.playersData[dataM.player1PlayerID];
         _loc4_ = -1;
         if(_loc3_.battlePlayerID == param1)
         {
            _loc4_ = dataM.player1PlayerID;
         }
         else
         {
            _loc4_ = dataM.player2PlayerID;
         }
         if(_loc4_ > -1)
         {
            _loc5_ = dataM.playersData[_loc4_];
            _loc6_ = this.getMechSlot(_loc4_);
            _loc7_ = this._mechBattleDatas[_loc6_];
            _loc8_ = _loc7_.mechView;
            _loc9_ = "";
            _loc11_ = new Array();
            _loc11_[1] = new Array();
            _loc11_[2] = new Array();
            _loc11_[3] = new Array();
            _loc11_[4] = new Array();
            _loc11_[5] = new Array();
            _loc11_[6] = new Array();
            _loc11_[7] = new Array();
            _loc11_[8] = new Array();
            _loc11_[1].push("WELCOME!");
            _loc11_[1].push("HELLO");
            _loc11_[1].push("NICE TO MEET YOU");
            _loc11_[2].push("WELL PLAYED");
            _loc11_[2].push("GG!");
            _loc11_[2].push("IT WAS AN HONOR");
            _loc11_[3].push("LOL");
            _loc11_[3].push("THAT WAS A GOOD ONE...");
            _loc11_[3].push("HA HA HA!");
            _loc11_[4].push("HO YEA...");
            _loc11_[4].push("PERFECT SHOT");
            _loc11_[4].push("EXACTLY AS PLANNED");
            _loc11_[5].push("SO... BORING...");
            _loc11_[5].push("OW COME ON!");
            _loc11_[5].push("WAKE ME UP WHEN<BR>YOU\'RE READY");
            _loc11_[6].push("NOT FAIR!");
            _loc11_[6].push("ENOUGH ALREADY!");
            _loc11_[6].push("SO ANNOYING...");
            _loc11_[7].push("COME ON!");
            _loc11_[7].push("LET\'S SEE WHAT YOU\'VE GOT!");
            _loc11_[7].push("I\'M READY FOR YOU!");
            _loc11_[7].push("DO YOU REALLY THINK<BR>YOU CAN BEAT ME?");
            _loc11_[7].push("YOU ARE NOT A<BR>SERIOUS CHALLENGE");
            _loc11_[7].push("ANOTHER VICTORY AT HAND");
            _loc11_[7].push("I AM RIGHT HERE");
            _loc11_[7].push("CATCH ME IF YOU CAN");
            _loc11_[7].push("HERE I AM");
            _loc11_[8].push("I WILL DESTROY YOU!");
            _loc11_[8].push("I HOPE YOUR MECH<BR>IS INSURED");
            _loc11_[8].push("PREPARE TO BE SHUT DOWN");
            _loc10_ = Math.ceil(Math.random() * _loc11_[param2].length) - 1;
            _loc9_ = _loc11_[param2][_loc10_];
            screensM.screenBattleInterfaceTop.sendMessageSuccess(_loc9_,param1);
            _loc12_ = false;
            if(this._mechJumpingHandler)
            {
               if(_loc4_ == this._currentPlayerID)
               {
                  _loc12_ = true;
               }
            }
            if(_loc12_ == false && _loc8_.getActiveAnimations().length == 0 && _loc8_.shutDownActive == false)
            {
               switch(param2)
               {
                  case 1:
                     _loc8_.activateTease12(null);
                     break;
                  case 2:
                     _loc8_.activateTease11(null);
                     break;
                  case 3:
                     _loc8_.activateTease2(null);
                     break;
                  case 4:
                     _loc8_.activateTease8(null);
                     break;
                  case 5:
                     _loc8_.activateTease6(null);
                     break;
                  case 6:
                     _loc8_.activateTease3(null);
                     break;
                  case 7:
                     switch(_loc10_)
                     {
                        case 0:
                        case 1:
                        case 2:
                           _loc8_.activateTease1(null);
                           break;
                        case 3:
                        case 4:
                        case 5:
                           _loc8_.activateTease4(null);
                           break;
                        default:
                           _loc8_.activateTease9(null,true);
                     }
                     break;
                  case 8:
                     _loc8_.activateTease5(null);
               }
            }
         }
      }
      
      private function chatBubblesHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMMechView = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Point = null;
         _loc1_ = screensM.screenBattleInterfaceTop.mcPlayer1ChatBubble.messageActive();
         _loc2_ = screensM.screenBattleInterfaceTop.mcPlayer2ChatBubble.messageActive();
         if(_loc1_ || _loc2_)
         {
            if(_loc1_)
            {
               _loc3_ = this.getMechSlot(dataM.player1PlayerID);
               _loc4_ = this._mechBattleDatas[_loc3_];
               _loc5_ = _loc4_.mechView;
               if(_loc5_ != null)
               {
                  _loc6_ = new Point(_loc5_.centerPosition.x,_loc5_.centerPosition.y + _loc5_.mechSizer.y);
                  _loc7_ = _loc5_.localToGlobal(_loc6_);
                  _loc8_ = globalToLocal(_loc7_);
                  screensM.screenBattleInterfaceTop.mcPlayer1ChatBubble.onEnterFrameTrigger(_loc8_.x,_loc8_.y);
               }
            }
            if(_loc2_)
            {
               _loc3_ = this.getMechSlot(dataM.player2PlayerID);
               _loc4_ = this._mechBattleDatas[_loc3_];
               _loc5_ = _loc4_.mechView;
               if(_loc5_ != null)
               {
                  _loc6_ = new Point(_loc5_.centerPosition.x,_loc5_.centerPosition.y + _loc5_.mechSizer.y);
                  _loc7_ = _loc5_.localToGlobal(_loc6_);
                  _loc8_ = globalToLocal(_loc7_);
                  screensM.screenBattleInterfaceTop.mcPlayer2ChatBubble.onEnterFrameTrigger(_loc8_.x,_loc8_.y);
               }
            }
         }
      }
      
      private function initializeBattleReport() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         this._battleReport = new Object();
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer)
         {
            this._battleReport.computerEquipment = new Array();
            _loc1_ = dataM.playersData[dataM.player2PlayerID];
            _loc2_ = 0;
            while(_loc2_ < _loc1_.items.length)
            {
               _loc3_ = _loc1_.items[_loc2_];
               _loc4_ = dataM.itemsDB[_loc3_.itemID];
               switch(_loc4_.type)
               {
                  case "torso":
                  case "leg":
                  case "module":
                     this._battleReport.computerEquipment.push(_loc3_.itemID);
               }
               _loc2_++;
            }
            this._battleReport.playerDamage = new Array();
         }
      }
      
      private function addBattleReportData(param1:Number, param2:Number) : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer)
         {
            if(this._currentPlayerID == dataM.player1PlayerID)
            {
               this._battleReport.playerDamage.push({
                  "playerItemID":param1,
                  "damage":param2
               });
            }
         }
      }
      
      public function titleCompleteAnimationIsDone() : void
      {
      }
      
      public function titleLetterAnimationIsDone() : void
      {
      }
      
      public function playLevelMusic() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(this._currentMusicTrack >= dataM.musicDB.length)
         {
            this._currentMusicTrack = 0;
         }
         _loc1_ = dataM.musicDB[this._currentMusicTrack].base;
         _loc2_ = dataM.musicDB[this._currentMusicTrack].loop;
         soundM.createMusic(_loc1_,_loc2_);
      }
      
      public function increaseMusicTrack() : void
      {
         ++this._currentMusicTrack;
      }
      
      private function keyboardOutput(param1:Object) : void
      {
         if(screensM.secondaryBattleScreensOpened == false)
         {
            if(this.getPlayerLostID() == 0)
            {
               if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.playingVSComputer == false)
               {
                  if(param1.enter)
                  {
                     if(screensM.isScreenOpened("screenBattleInterfaceEmotes"))
                     {
                        screensM.screenBattleInterfaceEmotes.chatEnterClicked();
                     }
                  }
               }
               if(this._socketActionAllowed && this._currentPlayerID == dataM.player1PlayerID)
               {
                  if(this._interfaceEnabled)
                  {
                     if(this.USE_NUMBER_KEYS_FOR_INTERFACE)
                     {
                     }
                  }
                  if(param1.debuggerActivated)
                  {
                     screensM.addScreen("screenDebugger");
                  }
               }
            }
         }
      }
      
      public function applyDurabilityChangesAtTheEndOfBattle(param1:Array) : void
      {
         this._durabilityChanges = param1;
      }
      
      public function optionsClicked() : void
      {
         screensM.addScreen("screenBattleOptions");
         screensM.screenBattleOptions.refreshScreen();
         if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            screensM.screenBattleInterfaceBottom.cancelMoveToStepSelectionClicked();
         }
      }
      
      public function get currentTurn() : Number
      {
         return this._turn;
      }
      
      public function get currentPlayerID() : Number
      {
         return this._currentPlayerID;
      }
      
      public function get opponentPlayerID() : Number
      {
         return this._opponentPlayerID;
      }
      
      public function get mechBattleDatas() : Object
      {
         return this._mechBattleDatas;
      }
   }
}

