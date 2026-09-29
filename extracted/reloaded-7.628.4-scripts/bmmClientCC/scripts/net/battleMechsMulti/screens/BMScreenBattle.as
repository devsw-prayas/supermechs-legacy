package net.battleMechsMulti.screens
{
   import com.greensock.TimelineMax;
   import fl.motion.Color;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.battleMechsMulti.data.BMLevelUpData;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.BMComputerManager;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.gameOfWhales.BMGameOfWhalesManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.managers.skills.BMMechStatsResolver;
   import net.battleMechsMulti.managers.specialAbilities.BMMechSpecialAbilitiesResolver;
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
   import net.battleMechsMulti.screens.battleResult.BMScreenBattleResult;
   import net.battleMechsMulti.screens.battleResult.BMScreenBattleResultClanBoss;
   import net.battleMechsMulti.screens.battleResult.BMScreenBattleResultClanWar;
   import net.battleMechsMulti.screens.battleResult.BMScreenBattleResultPremium;
   import net.battleMechsMulti.screens.battleResult.BMScreenBattleResultPremiumWithArenaCoins;
   import net.battleMechsMulti.screens.missionBaseMap.BMMissionMechStats;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.tacticsoft.utils.RandomUtils;
   import net.tacticsoft.utils.SafeInt;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3817")]
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
      
      private var _manualZoomOut:Boolean;
      
      private var _battleResult:String;
      
      private var _replayActionCooldown:Number;
      
      private var _lastWeaponEquipmentType:String;
      
      private var _lastWeaponEquipmentID:Number;
      
      private var _lastWeaponDamageType:Number;
      
      private var _lastHPBeforeRepairDrone:Number;
      
      private var _lastMeleeJumpAttack:Boolean = false;
      
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
      
      private var _resumeBattleAfterSpawning:Boolean;
      
      private var _resumeBattleAfterSpawningCountdown:uint;
      
      private var _battleReport:Object;
      
      private var _opponentAvailable:Boolean = false;
      
      private var _playerDataAndMechsCreated:Boolean = false;
      
      private var _hiddenBaseMission:Boolean = false;
      
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
      
      private var _battleResult_reward:BMRewardData;
      
      private var _battleResult_levelUpData:BMLevelUpData;
      
      private var _battleResult_newXP:Number;
      
      private var _battleResult_newNukes:Number;
      
      private var _battleResult_newRank:Number;
      
      private var _battleResult_newLadderProgress:Number;
      
      private var _reEnableBottomInterface:Boolean;
      
      private var _skipStartNewActionEnbaleInterface:Boolean;
      
      private var _setSocketAllowedStatusTrueInStartNewActionSub:Boolean;
      
      private var _skipNextSocketCallsHandlerEnbaleInterface:Boolean = false;
      
      private var _singlePlayerActions:Array;
      
      private var _singlePlayerActionSlot:uint;
      
      private var _allowFinishMoves:Boolean;
      
      private var _waitingForFinishMove:Boolean;
      
      private var _finishMoveID:Number;
      
      private var _giveTutorialItemAfterBattle1:Boolean;
      
      private var _giveTutorialItemAfterBattle2:Boolean;
      
      private var _lastGeneralSpeedRatio:Number = 1;
      
      private var _floorWidth:Number;
      
      private var _halfStageWidth:Number;
      
      private var _ignoreLegTooltip:Boolean;
      
      private var _clientDisconnected:Boolean;
      
      private var _battlePhase:String;
      
      private var _waitingForMechToBeDestroyed:Boolean;
      
      private var _lastPlayerLostID:uint = 0;
      
      private var _durabilityChanges:Array;
      
      private var _droneOnlyWin:Boolean;
      
      private var _meleeOnlyWin:Boolean;
      
      private var _opponentResistance1:Number;
      
      private var _opponentResistance2:Number;
      
      private var _opponentResistance3:Number;
      
      private var _maxSingleShotDamage:uint;
      
      private var _singleOverheats:uint;
      
      private var _doubleOverheats:uint;
      
      private var _chickenProjectile:Boolean = false;
      
      private var _delayAttackerHeatBarRefresh:Boolean = false;
      
      private var _delayAttackerEnergyBarRefresh:Boolean = false;
      
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
      
      private const AP_MAX:SafeInt = new SafeInt(2);
      
      private const AP_ONE:SafeInt = new SafeInt(1);
      
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
      
      private const DISPLAY_STEP_NUMBERS:Boolean = true;
      
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
      
      private const VIEW_SCALE_MINIMUM:Number = 0.771;
      
      private const TALKING_BOX_X_JUMP:Number = 400;
      
      private var FINISH_MOVES_FREQUENCY:Number = 4;
      
      public const USE_NUMBER_KEYS_FOR_INTERFACE:Boolean = false;
      
      public const MOBILE_MOUSE_DOWN_FRAMES_FOR_BATTLE_TOOLTIP:Number = 5;
      
      private const GRENADE_PULL_EXPLOSION_X_PUSH:uint = 125;
      
      private var _lastDestroyedMechScreenPosition:Point = null;
      
      private var _startNewBattleSuccessSubDelayed:Boolean = false;
      
      private var _forcePlayerJumpToStep:int = -1;
      
      private var _forcePlayerJumpFramesDelay:uint = 0;
      
      private var _activatePlayer2DelayedEntry:Boolean = false;
      
      private var _initialMechsBuilt:Boolean = false;
      
      private var _initialMechsBuiltCounter:uint = 0;
      
      private var _firstTurnStarted:Boolean = false;
      
      private var _screenInitiated:Boolean = false;
      
      private var _localSpecialAbilitiesActivated:Array = new Array();
      
      private var _fireJumpAcitve:Boolean = false;
      
      private var _fireJumpEquipmentType:String;
      
      private var _fireJumpEquipmentID:Number;
      
      private var _fireJumpLandingAcitve:Boolean = false;
      
      private var _triggerSocketAllowedOnFireJumpEnded:Boolean = false;
      
      private var _recentBaseUpgrades:Object = new Object();
      
      private var _upgradeTimeLine:TimelineMax;
      
      public function BMScreenBattle()
      {
         super();
      }
      
      public static function performFinishBattleOperations(param1:String, param2:Number, param3:BMLevelUpData, param4:Number, param5:Number, param6:Number, param7:Number, param8:BMRewardData = null) : *
      {
         var _loc17_:Boolean = false;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Boolean = false;
         var _loc25_:Number = NaN;
         var _loc26_:uint = 0;
         var _loc27_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:BMDataManager = BMDataManager.getInstance();
         var _loc13_:BMScreensManager = BMScreensManager.getInstance();
         var _loc14_:BMTutorialManager = BMTutorialManager.gi();
         switch(_loc12_.gameType)
         {
            case BMDataManager.GAME_TYPE_PVP:
               if(_loc12_.battle_inBattleInvitation == false)
               {
                  _loc9_ = true;
               }
         }
         if(BattleTypeResolver.isLadderBattle)
         {
            _loc17_ = param1 == BMDataManager.BATTLE_RESULT_WIN || param1 == BMDataManager.BATTLE_RESULT_OPPONENT_QUIT;
            _loc12_.kinM.onBattleEnded(_loc17_);
         }
         var _loc15_:BMPlayerProfile = _loc12_["player" + _loc12_.player1PlayerID + "Profile"];
         if(_loc12_.gameType == BMDataManager.GAME_TYPE_PVP || _loc12_.battleType == BMSinglePlayerManager.BATTLE_TYPE_REGULAR)
         {
            _loc15_.lastGoldGained = param2 - _loc15_.gold;
            if(param3 != null)
            {
               _loc15_.lastGoldGained -= param3.getGoldAmount();
            }
            _loc18_ = BMGameOfWhalesManager.SOURCE_LADDER_LOSS;
            if(param1 == BMDataManager.BATTLE_RESULT_WIN || param1 == BMDataManager.BATTLE_RESULT_OPPONENT_QUIT)
            {
               _loc18_ = BMGameOfWhalesManager.SOURCE_LADDER_WIN;
            }
            _loc19_ = BMGameOfWhalesManager.PLACE_LADDER;
            _loc12_.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_GOLD,_loc15_.lastGoldGained,_loc18_,_loc19_);
            _loc15_.gold = param2;
            _loc15_.totalGoldGained += _loc15_.lastGoldGained;
            if(param3 != null)
            {
               _loc15_.tokens += param3.getTokensAmount();
               _loc15_.tokens_bonus += param3.getTokensAmount();
               _loc15_.gold -= param3.getGoldAmount();
            }
            _loc15_.levelUpData = param3;
            _loc15_.lastXPGained = param4 - _loc15_.XP;
            _loc15_.XP = param4;
            _loc12_.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_XP,_loc15_.lastXPGained,_loc18_,_loc19_);
            _loc15_.lastNukesGained = param5 - _loc15_.nukes;
            _loc15_.nukes = param5;
            _loc15_.lastArenaCoinsGained = 0;
            if(param8 != null)
            {
               _loc15_.lastArenaCoinsGained = param8.arenaCoins;
               _loc15_.arenaCoins += param8.arenaCoins;
               _loc12_.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_ARENA_COINS,param8.arenaCoins,_loc18_,_loc19_);
            }
         }
         _loc15_.overallRank = param6;
         _loc15_.lastLadderProgress = _loc15_.ladderProgress;
         _loc15_.ladderProgress = param7;
         _loc12_.resetRankingListTimer = true;
         var _loc16_:Class = BMScreenBattleResult;
         if(_loc12_.gameType == BMDataManager.GAME_TYPE_PVP)
         {
            if(_loc15_.lastArenaCoinsGained > 0)
            {
               _loc16_ = BMScreenBattleResultPremiumWithArenaCoins;
            }
            else
            {
               _loc16_ = BMScreenBattleResultPremium;
            }
         }
         if(BattleTypeResolver.isBattleOnServer)
         {
            switch(_loc12_.battleType)
            {
               case BMSinglePlayerManager.BATTLE_TYPE_REGULAR:
                  if(_loc12_.battle_inBattleInvitation)
                  {
                     _loc10_ = true;
                  }
                  else
                  {
                     if(_loc15_.lastGoldGained == 0)
                     {
                        _loc11_ = true;
                     }
                     _loc20_ = _loc15_.lastGoldGained;
                     _loc21_ = _loc15_.lastXPGained;
                     _loc22_ = _loc15_.lastArenaCoinsGained;
                     _loc23_ = _loc15_.lastNukesGained;
                     _loc24_ = _loc20_ > 0 || _loc21_ > 0 || _loc22_ > 0 || param8.hasBoxes;
                     if(_loc24_)
                     {
                        _loc13_.addScreen(BMScreensManager.SCR_BATTLE_RESULT,true,_loc16_);
                        _loc13_.screenBattleResult.setPrizes(_loc20_,_loc21_,_loc22_,_loc23_,param8);
                     }
                  }
            }
         }
         if(_loc12_.battle_inBattleInvitation == false)
         {
            _loc25_ = 0;
            _loc26_ = 0;
            while(_loc26_ < _loc12_.levelUpDB.length)
            {
               if(_loc15_.XP < _loc12_.levelUpDB[_loc26_])
               {
                  _loc26_ = _loc12_.levelUpDB.length;
               }
               else
               {
                  _loc25_ = _loc26_;
               }
               _loc26_++;
            }
            _loc15_.lastLevel = _loc15_.level;
            _loc15_.level = _loc25_;
         }
         _loc15_.lastBattleResult = param1;
         if(_loc15_.level > _loc15_.lastLevel)
         {
            if(_loc15_.tutorialLevel >= BMTutorialManager.TUTORIAL_LEVEL_MISSION1 && _loc14_.isTutorialActive())
            {
               _loc12_.topBar_levelUpInProgress = true;
            }
         }
         if(param1 == BMDataManager.BATTLE_RESULT_WIN || param1 == BMDataManager.BATTLE_RESULT_OPPONENT_QUIT)
         {
            if(_loc12_.playingVSComputer && !(_loc12_.gameType == BMDataManager.GAME_TYPE_PVP && _loc12_.gameSubType == BMDataManager.GAME_SUB_TYPE_PVP_BOT))
            {
               ++_loc15_.winsVSComputer;
               if(_loc15_.winsVSComputer == 1)
               {
                  _loc13_.screenBattle._giveTutorialItemAfterBattle1 = true;
               }
               else if(_loc15_.winsVSComputer == 2)
               {
                  _loc13_.screenBattle._giveTutorialItemAfterBattle2 = true;
               }
            }
            else
            {
               ++_loc15_.onlineBattles;
               ++_loc15_.onlineWins;
               ++_loc15_.ladderWins;
               if(_loc9_)
               {
                  if(_loc15_.winLossStreak < 1)
                  {
                     _loc15_.winLossStreak = 1;
                  }
                  else
                  {
                     ++_loc15_.winLossStreak;
                  }
               }
            }
            _loc15_.updateWinsTotal();
         }
         else
         {
            if(_loc12_.gameType == BMDataManager.GAME_TYPE_PVP)
            {
               ++_loc15_.onlineBattles;
            }
            if(_loc9_ && param1 == BMDataManager.BATTLE_RESULT_LOSS)
            {
               if(_loc15_.winLossStreak > -1)
               {
                  _loc15_.winLossStreak = -1;
               }
               else
               {
                  --_loc15_.winLossStreak;
               }
            }
         }
         if(_loc11_)
         {
            _loc27_ = false;
            if(_loc12_.gameType == BMDataManager.GAME_TYPE_PVP && _loc12_.battle_inBattleInvitation == false)
            {
               _loc27_ = true;
            }
            if(_loc27_)
            {
               _loc13_.addScreen(BMScreensManager.SCR_LADDER_STATUS);
               _loc13_.screenLadderStatus.refreshScreen();
            }
            else
            {
               _loc13_.screenConfirmation.displayQuestionOrNotification("opponentQuitOnFirstRoundNoReward",-1,-1);
            }
         }
         else if(_loc10_)
         {
            _loc13_.screenBlack.activateBlackScreen(endPrivateBattle,true,true,null,0);
            if(_loc13_.isScreenOpened(BMScreensManager.SCR_VS))
            {
               _loc13_.screenVS.removeMe();
            }
         }
         else if(isFightingClanBoss)
         {
            _loc13_.addScreen(BMScreensManager.SCR_BATTLE_RESULT,true,BMScreenBattleResultClanBoss);
            _loc13_.screenBattleResult.refreshScreen();
         }
         else if(BattleTypeResolver.isClanWar)
         {
            _loc13_.addScreen(BMScreensManager.SCR_BATTLE_RESULT,true,BMScreenBattleResultClanWar);
            _loc13_.screenBattleResult.refreshScreen();
         }
         else if(_loc12_.gameType == BMDataManager.GAME_TYPE_PVP || _loc12_.battleType == BMSinglePlayerManager.BATTLE_TYPE_REGULAR)
         {
            _loc13_.addScreen(BMScreensManager.SCR_BATTLE_RESULT,true,_loc16_);
            _loc13_.screenBattleResult.refreshScreen();
         }
         else
         {
            _loc13_.screenBattle.closeScreen();
         }
         sendEndBattleAnalyticsEvent(param1);
         if(_loc12_.gameType == BMDataManager.GAME_TYPE_TUTORIAL_PVE)
         {
            if(_loc15_.missionID == 0 && _loc14_.getTutorialDestination() == BMTutorialManager.TUTORIAL_DESTINATION_LONE_BATTLE)
            {
               _loc14_.setTutorialLevel(_loc15_.tutorialLevel + 1,"screenBattle battleResultSuccessSub");
            }
         }
      }
      
      private static function sendEndBattleAnalyticsEvent(param1:String) : *
      {
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         var _loc3_:BMTutorialManager = BMTutorialManager.gi();
         if(_loc2_.raidData.isRaidInProgress())
         {
            return;
         }
         var _loc4_:String = "Ladder";
         var _loc5_:Number = NaN;
         var _loc6_:String = "";
         if(_loc2_.playingVSComputer)
         {
            _loc7_ = 5;
            if(_loc3_.isTutorialActive())
            {
               _loc4_ = "Tutorial";
               _loc5_ = _loc2_.myProfile.tutorialLevel;
            }
            else if(_loc2_.gameType == BMDataManager.GAME_TYPE_PVP)
            {
               _loc4_ = "PVP bot";
               _loc5_ = _loc2_.myProfile.tutorialLevel;
            }
            else if(isFightingClanBoss)
            {
               _loc4_ = _loc2_.battleType;
            }
            else
            {
               _loc4_ = _loc2_.battleType;
               _loc5_ = _loc2_.myProfile.getCurrentMission().locationID;
               _loc6_ = _loc2_.myProfile.getCurrentMission().name;
            }
         }
         else
         {
            _loc7_ = 2;
            if(_loc2_.battle_inBattleInvitation)
            {
               _loc4_ = "Private";
            }
            else
            {
               _loc4_ = "Ladder";
               _loc5_ = _loc2_.getLadderRankByProgress(_loc2_.myProfile.ladderProgress);
            }
         }
         if(param1 != null)
         {
            _loc8_ = param1;
            _loc2_.trackEvent(_loc7_,"Battle",_loc8_,_loc4_,_loc5_,_loc6_);
         }
         else
         {
            trace("screenBattle > sendEndBattleAnalyticsEvent > _battleResult = null");
         }
      }
      
      private static function endPrivateBattle() : void
      {
         var _loc1_:BMScreensManager = BMScreensManager.getInstance();
         _loc1_.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(_loc1_.isBattleOpened())
         {
            _loc1_.screenBattle.cleanBattle(false);
         }
      }
      
      public static function get isFightingClanBoss() : Boolean
      {
         return BMDataManager.getInstance().battleType == BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS;
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
         this._currentMusicTrack = RandomUtils.chooseRandomIndex(dataM.musicDB);
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
         if(parent == null || dataM.battle_gamePaused || this._opponentAvailable == false)
         {
            return;
         }
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
         this.finishBackgroundDarknessHandler();
         this.chatBubblesHandler();
         this.bulletShellsHandler();
         this.resumeBattleAfterSpawningHandler();
         this.forcePlayerJumpFramesDelayHandler();
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
      
      public function get opponentAvailable() : Boolean
      {
         return this._opponentAvailable;
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
            case "initiate_screenVSStartedClosing":
               this.screenVSStartedClosing();
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
               if(this._currentPlayerInterfacePlayerID == 2 && param2.equipmentType == "leg" && (dataM.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_JEEP || dataM.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_TANK))
               {
                  this.crashSuccess();
               }
               else
               {
                  this.fireSuccess(param2.equipmentType,param2.equipmentID);
               }
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
         if(param2 != null)
         {
            this.specialAbilitiesAnnouncerHandler(param2.specialAbilities);
         }
      }
      
      private function specialAbilitiesAnnouncerHandler(param1:Array) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.length == 0)
         {
            return;
         }
         var _loc2_:String = "";
         var _loc3_:uint = 16777215;
         switch(param1[0])
         {
            case BMMechSpecialAbilitiesResolver.CRITICAL_HIT:
               _loc2_ = "CRITICAL!";
               break;
            case BMMechSpecialAbilitiesResolver.INCREASED_ENERGY_REGENERATION:
               _loc2_ = "Extra Regeneration!";
               break;
            case BMMechSpecialAbilitiesResolver.INCREASED_HEAT_COOLING:
               _loc2_ = "Extra Cooling!";
               break;
            case BMMechSpecialAbilitiesResolver.RESISTANCE_DRAIN_SHIELD:
               _loc2_ = "Resistance Drain Blocked!";
               break;
            case BMMechSpecialAbilitiesResolver.DAMAGE_SHIELD:
               _loc2_ = "Damage Reduced!";
               break;
            case BMMechSpecialAbilitiesResolver.ENERGY_DAMAGE_SHIELD:
               _loc2_ = "Energy Damage Reduced!";
               break;
            case BMMechSpecialAbilitiesResolver.HEAT_DAMAGE_SHIELD:
               _loc2_ = "Heat Damage Reduced!";
               break;
            case BMMechSpecialAbilitiesResolver.IGNORE_RESISTANCE:
               _loc2_ = "Resistance Ignored!";
         }
         if(_loc2_ == "")
         {
            return;
         }
         screensM.screenBattleInterfaceTop.showAnnouncerText(_loc2_,_loc3_);
      }
      
      public function startNewBattleSuccess(param1:Boolean = true) : void
      {
         this._opponentAvailable = param1;
         this._playerDataAndMechsCreated = false;
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
         {
            screensM.screenBattleInterfaceBottom.refreshScreen();
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
         {
            screensM.addScreen(BMScreensManager.SCR_BATTLE_INTERFACE_EMOTES);
            screensM.screenBattleInterfaceEmotes.parent.removeChild(screensM.screenBattleInterfaceEmotes);
            screensM.screenBattleInterfaceEmotes.refreshScreen();
         }
         if(this._opponentAvailable == false)
         {
            screensM.screenBattleInterfaceTop.hideOpponentInterface();
         }
         if(screensM.USE_FPS_TRACKER)
         {
            screensM.screenFPSTracker.fpsTracker.resetMinAndMaxFPS();
         }
         dataM.setPVPAndReplaysDoubleSpeed();
         this.resetParams();
         screensM.screenBattleInterfaceTop.hideReplayProgressBar();
         screensM.screenBattleInterfaceTop.cleanTexts();
         screensM.screenBattleInterfaceTop.mcPlayer1ChatBubble.closeMessage(true);
         screensM.screenBattleInterfaceTop.mcPlayer2ChatBubble.closeMessage(true);
         screensM.screenBattleInterfaceTop.deactivateTurnOwnerMessage();
         this.initStompUnlocked();
         if(this.opponentAvailable == false)
         {
            this.initHiddenBaseMission();
         }
         this.createMapBackgrounds();
         if(this._opponentAvailable)
         {
            this.startNewBattleSuccessSub();
         }
      }
      
      private function initHiddenBaseMission() : void
      {
         dataM.battleType = BMSinglePlayerManager.BATTLE_TYPE_MISSION;
         this._currentPlayerID = dataM.player1PlayerID;
         this._opponentPlayerID = dataM.player2PlayerID;
         this.initPlayerData(this._currentPlayerID);
         this.refreshPlayerStats(this._currentPlayerID);
         this.showPlayerNameAndFlag(this._currentPlayerID);
         this.hideInterface(true,false);
         this.resetBottomInterface();
         this.setAvatar(this._currentPlayerID);
         this._playerDataAndMechsCreated = true;
         this._hiddenBaseMission = true;
         sub(BMPubSub.MESSAGE_SCREENS_DIRECTOR_FINISHED_ALL_TASKS,this.screensDirectorFinishedAllTasks);
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(1);
      }
      
      public function startNewBattleSuccessSub() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(this._hiddenBaseMission)
         {
            if(screensM.screensDirector.hasTasks())
            {
               this._startNewBattleSuccessSubDelayed = true;
               return;
            }
            this._recentBaseUpgrades = new Object();
            _loc3_ = screensM.screenMissionBaseMap.getEnemiesTotal();
            _loc4_ = screensM.screenMissionBaseMap.getEnemiesDestroyed();
            screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_BEFORE_BATTLE_WAVE,1,{
               "currentWave":_loc4_ + 1,
               "wavesTotal":_loc3_
            });
            screensM.screenBlack.unBlockOpeningScreen();
            screensM.screenBattleInterfaceTop.resetDestroyMechBadges();
         }
         this._opponentAvailable = true;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
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
         this._floorWidth = this.FLOOR_STEP_SIZE * dataM.battleData.map.stepsTotal;
         this.addMapBorders();
         this.createFloorBuffs();
         _loc1_.wonLastBattleVSComputer = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
         {
            ++_loc1_.onlineBattles;
         }
         var _loc2_:uint = dataM.player1PlayerID;
         while(_loc2_ <= dataM.player2PlayerID)
         {
            if(this._playerDataAndMechsCreated && _loc2_ == dataM.player1PlayerID)
            {
               this.updateExistingPlayerData(_loc2_);
            }
            else
            {
               this.initPlayerData(_loc2_);
            }
            _loc2_++;
         }
         this.refreshFloorBuffEffects();
         screensM.screenBattleInterfaceTop.resetWaitingForBattleResult();
         if(this._playerDataAndMechsCreated)
         {
            this.resetStatsForNextBattle(this._currentPlayerID);
         }
         else
         {
            this.refreshPlayerStats(this._currentPlayerID);
            this.showPlayerNameAndFlag(this._currentPlayerID);
            this.setAvatar(this._currentPlayerID);
         }
         this.refreshPlayerStats(this._opponentPlayerID);
         this.showPlayerNameAndFlag(this._opponentPlayerID);
         this.setAvatar(this._opponentPlayerID);
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(1);
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(2);
         this.actionRange.initialize(dataM.battleData.map.stepsTotal,this.FLOOR_STEP_SIZE);
         this.initTopInterfaceButtons();
         this.trackScreenView();
         this.initIgnoreLegTooltip();
         this.refreshMechsView();
         this.resetBottomInterface();
         this.initMusic();
         this.tryToAllowOpponentEntry();
         this.initCompTeasingAnim();
         this.refreshTurnMarkersSizeAndPosition();
         this.initKeyboard();
         dataM.saveGuestData("battle startNewBattleSuccess");
         this.setAllowFinishMoves();
         this.setSocketAllowedStatus(false,"startNewBattleSuccess");
         this._LASTsocketActionAllowed = false;
         this.refreshMechCodeStepMarker(1);
         this.refreshMechCodeStepMarker(2);
         if(this._hiddenBaseMission)
         {
            this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
         }
         this.resetBattleTurnDataLocally(null);
         this.initializeBattleReport();
         this._screenInitiated = true;
         this.tryToStartFirstTurn();
      }
      
      private function forcePlayerJumpFramesDelayHandler() : void
      {
         if(this._forcePlayerJumpFramesDelay > 0)
         {
            --this._forcePlayerJumpFramesDelay;
            if(this._forcePlayerJumpFramesDelay == 0)
            {
               this.tryToStartFirstTurn();
            }
         }
      }
      
      private function updateExistingPlayerData(param1:uint) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:uint = 0;
         var _loc6_:Boolean = false;
         var _loc7_:BMPlayerData = null;
         var _loc8_:Boolean = false;
         var _loc2_:uint = 1;
         while(_loc2_ <= dataM.battleMechsPerPlayer)
         {
            _loc3_ = this.getMechSlot(param1,_loc2_);
            _loc4_ = this._mechBattleDatas[_loc3_];
            _loc5_ = this.getPlayerInitialStep(param1);
            _loc6_ = true;
            _loc7_ = dataM.playersData[param1];
            _loc8_ = _loc2_ == _loc7_.selectedMechID;
            if((_loc8_) && _loc4_.currentStepCode != -1)
            {
               if(_loc6_)
               {
                  this._forcePlayerJumpToStep = _loc5_;
                  this._forcePlayerJumpFramesDelay = 10;
               }
               _loc4_.energy = _loc4_.energyMax;
               screensM.screenBattleInterfaceTop.refreshEnergy(param1,true);
               _loc4_.heat = 0;
               screensM.screenBattleInterfaceTop.refreshHeat(param1,true);
               _loc4_.setAllResistances();
               screensM.screenBattleInterfaceTop.refreshResistance(param1,1,true);
               screensM.screenBattleInterfaceTop.refreshResistance(param1,2,true);
               screensM.screenBattleInterfaceTop.refreshResistance(param1,3,true);
            }
            else
            {
               _loc4_.currentStepCode = _loc5_;
               _loc4_.currentStepVisual = _loc5_;
               this.setMechXPosition(_loc4_);
            }
            if(_loc4_.droneActive)
            {
               if(_loc8_)
               {
                  _loc7_.AP = 1;
                  screensM.screenBattleInterfaceTop.refreshAP(param1);
                  _loc4_.droneFired = false;
               }
               else
               {
                  _loc4_.resetDrone();
               }
            }
            _loc2_++;
         }
      }
      
      private function initPlayerData(param1:uint) : void
      {
         var _loc2_:BMPlayerData = dataM.playersData[param1];
         _loc2_.resetSwitchMechUses();
         _loc2_.APMax = this.AP_MAX.value;
         if(param1 == this._currentPlayerID || dataM.playingVSComputer && param1 == dataM.player1PlayerID)
         {
            _loc2_.AP = this.AP_ONE.value;
         }
         else
         {
            _loc2_.AP = _loc2_.APMax;
         }
         _loc2_.mechsDestroyed = 0;
         var _loc3_:Number = 0;
         _loc2_.selectedMechID = 1;
         if((BattleTypeResolver.isCampaign || BattleTypeResolver.isRaid) && param1 == dataM.player1PlayerID)
         {
            _loc2_.selectedMechID = dataM.myProfile.missionCurrentMechID;
         }
         var _loc4_:uint = 1;
         while(_loc4_ <= dataM.battleMechsPerPlayer)
         {
            this.createMechBattleData(param1,_loc4_,_loc3_);
            if(_loc4_ == _loc2_.selectedMechID)
            {
               this.createMechView(param1,_loc4_);
            }
            _loc4_++;
         }
      }
      
      private function resetStatsForNextBattle(param1:uint) : void
      {
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc2_:uint = 1;
         while(_loc2_ <= dataM.battleMechsPerPlayer)
         {
            _loc4_ = this.getMechSlot(param1,_loc2_);
            _loc5_ = this._mechBattleDatas[_loc4_];
            _loc5_.resetAlreadyFired();
            _loc5_.setUses();
            _loc5_.energy = _loc5_.energyMax;
            _loc5_.heat = 0;
            _loc2_++;
         }
         var _loc3_:BMPlayerData = dataM.playersData[param1];
         _loc3_.resetSwitchMechUses();
      }
      
      private function refreshPlayerStats(param1:uint) : void
      {
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
      }
      
      private function showPlayerNameAndFlag(param1:uint) : void
      {
         var _loc4_:BMPlayerProfile = null;
         var _loc2_:Boolean = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
         {
            _loc2_ = true;
         }
         var _loc3_:String = "";
         if(_loc2_)
         {
            _loc4_ = dataM["player" + param1 + "Profile"];
            if(_loc4_.geo != null)
            {
               _loc3_ = _loc4_.geo;
            }
         }
         screensM.screenBattleInterfaceTop.setNameAndFlag(param1,_loc3_);
      }
      
      private function initTopInterfaceButtons() : void
      {
         this._zoomViewChangeFrames = 0;
         this._manualZoomOut = false;
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
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_TUTORIAL_PVE:
               if(dataM.myProfile.winsVSComputer < dataM.TUTORIAL_BATTLES && dataM.clientRunningLocally == false)
               {
                  screensM.screenBattleInterfaceTop.btnQuit.visible = false;
                  screensM.screenBattleInterfaceTop.btnZoomIn.visible = false;
                  screensM.screenBattleInterfaceTop.btnZoomOut.visible = false;
                  screensM.screenBattleInterfaceTop.btnOptions.visible = false;
               }
               break;
            case BMDataManager.GAME_TYPE_REPLAY:
               screensM.screenBattleInterfaceTop.mcActionErrorMessage.visible = false;
               screensM.screenBattleInterfaceTop.replayBar.setFill(0,false);
         }
         screensM.screenBattleInterfaceTop.mcChat.visible = false;
         screensM.screenBattleInterfaceTop.btnEmotesOpen.visible = false;
         screensM.screenBattleInterfaceTop.btnEmotesClose.visible = false;
         screensM.screenBattleInterfaceTop.btnPlayReplay.visible = false;
         screensM.screenBattleInterfaceTop.btnPauseReplay.visible = false;
         screensM.screenBattleInterfaceTop.btnOptions.visible = false;
         if(BattleTypeResolver.isPvE)
         {
            if(tutorialM.isTutorialActive() == false)
            {
               screensM.screenBattleInterfaceTop.btnOptions.visible = true;
            }
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
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
      }
      
      private function resetParams() : void
      {
         this._replayActionSlot = 0;
         this._mechBattleDatas = new Object();
         this._refreshBattleView_low_frames = 0;
         this._refreshBattleViewImmediately = true;
         this._battleViewMech1_lastMainHolderXPos = -1;
         this._battleViewMech2_lastMainHolderXPos = -1;
         this._battleViewMech1_lastMechViewXPos = -1;
         this._battleViewMech2_lastMechViewXPos = -1;
         this._opponentResistance1 = 0;
         this._opponentResistance2 = 0;
         this._opponentResistance3 = 0;
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
         this._giveTutorialItemAfterBattle1 = false;
         this._giveTutorialItemAfterBattle2 = false;
         this._ignoreLegTooltip = false;
         this._droneOnlyWin = true;
         this._meleeOnlyWin = true;
         this._maxSingleShotDamage = 0;
         this._singleOverheats = 0;
         this._doubleOverheats = 0;
         dataM.battle_goToChatAfterBattle = false;
         dataM.battle_inviteToClanAfterBattle = false;
         this._replayActionCooldown = this.REPLAY_COOLDOWN;
         dataM.savingReplay = false;
         this._activatePlayer1Entry = false;
         this._activatePlayer2Entry = false;
         this._skipNextSocketCallsHandlerEnbaleInterface = false;
         this._timerNotice = false;
         this._forceShutDown = false;
         this._battleEnabled = true;
         this._battleResult_available = false;
         this._battleResult_triggerOnSpot = false;
         this._lastAction = "none";
         this._allowFinishMoves = false;
         this._waitingForFinishMove = false;
         this._turn = 0;
      }
      
      private function initStompUnlocked() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._stompUnlocked_displayNow = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL_PVE && _loc1_.winsVSComputer == 1 && this._stompUnlocked_alreadyDisplayed == false)
         {
            this._stompUnlocked_alreadyDisplayed = true;
            this._stompUnlocked_displayNow = true;
         }
         if(BMGameShortcutsHelper.battleStompGuideShortcut())
         {
            this._stompUnlocked_displayNow = false;
         }
      }
      
      private function trackScreenView() : void
      {
         switch(dataM.battleType)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
               dataM.trackScreenView("battle_SP_mission");
               break;
            case BMSinglePlayerManager.BATTLE_TYPE_REGULAR:
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
      }
      
      private function initIgnoreLegTooltip() : void
      {
         if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
         {
            switch(dataM.battleSubType)
            {
               case BMSinglePlayerManager.ENEMY_TYPE_TURRET:
               case BMSinglePlayerManager.ENEMY_TYPE_TANK:
               case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
                  this._ignoreLegTooltip = true;
            }
         }
      }
      
      private function initMusic() : void
      {
         var _loc1_:Boolean = true;
         if(dataM.gameType == BMDataManager.GAME_TYPE_REPLAY)
         {
            this.playLevelMusic("initMusic");
            if(soundM.music)
            {
               _loc1_ = false;
            }
         }
         if(_loc1_)
         {
            soundM.removeAllMusic();
         }
      }
      
      private function tryToAllowOpponentEntry() : void
      {
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_TUTORIAL_PVE:
            case BMDataManager.GAME_TYPE_PVE:
               if(dataM.myProfile.winsVSComputer >= dataM.TUTORIAL_BATTLES)
               {
                  this.allowPlayer2Entry();
               }
         }
         if(this._hiddenBaseMission)
         {
            this.createPlayer2Entry();
         }
      }
      
      private function initCompTeasingAnim() : void
      {
         if(dataM.battleData.startingPlayer == 1)
         {
            this.activateMechTeaseAnimation();
         }
         else
         {
            this.deactivateMechTeaseAnimation();
         }
      }
      
      private function resetBottomInterface() : void
      {
         this.hideInterface(false,false,"startNewBattleSuccess");
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
         {
            screensM.screenBattleInterfaceBottom.newBattleStarted();
            screensM.screenBattleInterfaceBottom.player1MechBattleTooltip.hideToolTip(true);
            screensM.screenBattleInterfaceBottom.player2MechBattleTooltip.hideToolTip(true);
            screensM.screenBattleInterfaceBottom.resetActionErrorMessage();
            screensM.screenBattleInterfaceBottom.setHeatCriticalAlertCountdown(0);
            screensM.screenBattleInterfaceBottom.setShuttingDownAlertCountdown(0);
         }
      }
      
      private function initKeyboard() : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
         {
            keyboardM.setKeyboardOutputFunction(this.keyboardOutput,BMScreensManager.SCR_BATTLE);
            keyboardM.activateMe(BMScreensManager.SCR_BATTLE);
         }
      }
      
      private function setAllowFinishMoves() : void
      {
         var _loc1_:Number = NaN;
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_TUTORIAL_PVE:
            case BMDataManager.GAME_TYPE_PVP:
            case BMDataManager.GAME_TYPE_PVE:
               if(tutorialM.isTutorialActive() == false && this.isOpponentSpecialBoss() == false)
               {
                  if(dataM.playingVSComputer)
                  {
                     switch(dataM.battleType)
                     {
                        case BMSinglePlayerManager.BATTLE_TYPE_REGULAR:
                           if(dataM.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_MECH)
                           {
                              _loc1_ = Math.ceil(Math.random() * 10);
                              if(_loc1_ == 1)
                              {
                                 this._allowFinishMoves = true;
                              }
                           }
                           break;
                        case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
                           if(dataM.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_BOSS)
                           {
                              if(dataM.raidData.isRaidInProgress())
                              {
                                 break;
                              }
                              if(!dataM.singlePlayerM.didCompleteSlot(dataM.myProfile.currentStoryID,dataM.myProfile.currentMissionSlot,dataM.myProfile.currentMissionMode))
                              {
                                 this._allowFinishMoves = true;
                              }
                           }
                     }
                  }
                  else if(dataM.myProfile.onlineBattles % this.FINISH_MOVES_FREQUENCY == 0)
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
      }
      
      private function setAvatar(param1:uint) : void
      {
         switch(param1)
         {
            case dataM.LOCAL_PLAYER_ID:
            case dataM.ONLINE_PLAYER_ID:
            case dataM.REPLAY_PLAYER1_ID:
               screensM.screenBattleInterfaceTop.showAvatarImage(false,1);
               break;
            case dataM.LOCAL_OPPONENT_ID:
            case dataM.ONLINE_OPPONENT_ID:
            case dataM.REPLAY_PLAYER2_ID:
               screensM.screenBattleInterfaceTop.showAvatarImage(false,2);
         }
      }
      
      public function screenVSIsClosed() : void
      {
         this.playLevelMusic("screenVSIsClosed");
      }
      
      public function screenVSStartedClosing() : void
      {
         var _loc1_:Boolean = false;
         switch(dataM.battleSubType)
         {
            case BMSinglePlayerManager.ENEMY_TYPE_CLAN_BOSS:
            case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
            case BMSinglePlayerManager.ENEMY_TYPE_TANK:
               _loc1_ = true;
         }
         if(dataM.battle_inBattleInvitation)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            this.playLevelMusic("screenVSStartedClosing");
         }
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
            screensM.addScreen(BMScreensManager.SCR_POPUP);
            screensM.screenBattleInterfaceBottom.btn4.visible = false;
            screensM.screenBattleInterfaceBottom.mcTutorialArrow_interface.visible = false;
            screensM.screenPopUp.refreshScreen("stompUnlocked",0,0,null);
            this.setSocketAllowedStatus(true,"screenVSStartedClosing");
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
      
      private function canMechMakeSpecialEntry() : Boolean
      {
         if(dataM.useHiddenBaseMap == false)
         {
            switch(dataM.battleSubType)
            {
               case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
               case BMSinglePlayerManager.ENEMY_TYPE_TANK:
                  return false;
            }
         }
         return this.isOpponentSpecialBoss() == false;
      }
      
      private function allowPlayer2Entry() : void
      {
         if(this.canMechMakeSpecialEntry() == false)
         {
            return;
         }
         this._activatePlayer2Entry = true;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player2PlayerID];
         var _loc2_:String = this.getMechSlot(dataM.player2PlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         _loc3_.mechView.visible = false;
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
         var _loc1_:String = this.getMechSlot(dataM.player2PlayerID);
         var _loc2_:BMMechBattleData = this._mechBattleDatas[_loc1_];
         if(this._activatePlayer2DelayedEntry == false)
         {
            if(this._activatePlayer2Entry == false)
            {
               this.setSocketAllowedStatus(true,"createPlayer2Entry");
               return;
            }
            if(this._forcePlayerJumpToStep > -1)
            {
               _loc2_.mechView.visible = false;
               this.player2EntryAnimationEnded(false);
               this._activatePlayer2DelayedEntry = true;
               return;
            }
         }
         _loc2_.mechView.visible = true;
         var _loc3_:Number = Math.ceil(Math.random() * 3);
         var _loc4_:Function = this.player2EntryAnimationEnded;
         if(this._activatePlayer2DelayedEntry)
         {
            _loc4_ = this.player2DelayedEntryAnimationEnded;
         }
         switch(_loc3_)
         {
            case 1:
               _loc2_.mechView.activateEntry1(true,_loc4_);
               break;
            case 2:
               _loc2_.mechView.activateEntry2(true,_loc4_);
               break;
            case 3:
               _loc2_.mechView.activateEntry3(_loc4_);
               break;
            case 4:
               _loc2_.mechView.activateEntry4(_loc4_);
         }
      }
      
      private function player2DelayedEntryAnimationEnded() : void
      {
         this._activatePlayer2DelayedEntry = false;
         this._interfaceEnabled = true;
         this.activatePlayer2Taunt();
         this.activateNextBattlePhase("turn_actionPerformed",{
            "delayNewAction":true,
            "stopBattleViewAfterDelayNewAction":false,
            "caller":"walkJumpAnimDone"
         });
      }
      
      private function player1EntryAnimationEnded() : void
      {
         this.activateNextBattlePhase("initiate_player2Entry");
      }
      
      private function player2EntryAnimationEnded(param1:Boolean = true) : void
      {
         this.setSocketAllowedStatus(true,"player2EntryAnimationEnded");
         if(param1)
         {
            this.activatePlayer2Taunt();
         }
         this._activatePlayer2Entry = false;
         this.tryToStartFirstTurn();
      }
      
      private function activatePlayer2Taunt() : void
      {
         switch(dataM.battleType)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
               switch(dataM.battleSubType)
               {
                  case BMSinglePlayerManager.ENEMY_TYPE_BOSS:
                     this.activateTaunt(2,8);
               }
         }
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
            if(dataM.generalSpeedRatio == 2)
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
            this.resetBattleEndedPlayerMechStats();
            if(_loc6_ == dataM.player1PlayerID)
            {
               this._battleResult = BMDataManager.BATTLE_RESULT_LOSS;
               if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && dataM.battle_inBattleInvitation == false)
               {
                  dataM.mechBoostRecommender.allowNextRecommendationByClient();
               }
               switch(dataM.battleType)
               {
                  case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
                     dataM.mission_battleEnded = true;
                     dataM.mission_battleEnded_playerWon = false;
               }
            }
            else
            {
               switch(dataM.battleType)
               {
                  case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
                     dataM.mission_battleEnded = true;
                     dataM.mission_battleEnded_playerWon = true;
                     this.updateBattleEndedPlayerMechStats();
               }
               this._battleResult = BMDataManager.BATTLE_RESULT_WIN;
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
               if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
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
      
      private function resetBattleEndedPlayerMechStats() : void
      {
         var _loc2_:BMMissionMechStats = null;
         dataM.mission_battleEnded_mechsStats = new Array();
         var _loc1_:uint = 1;
         while(_loc1_ <= dataM.battleMechsPerPlayer)
         {
            _loc2_ = new BMMissionMechStats();
            dataM.mission_battleEnded_mechsStats.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function updateBattleEndedPlayerMechStats() : void
      {
         var _loc2_:BMMissionMechStats = null;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= dataM.battleMechsPerPlayer)
         {
            _loc2_ = dataM.mission_battleEnded_mechsStats[_loc1_ - 1];
            _loc3_ = this.getMechSlot(dataM.player1PlayerID,_loc1_);
            _loc4_ = this._mechBattleDatas[_loc3_];
            _loc2_.hp = Math.max(0,_loc4_.HP);
            _loc2_.bullets = _loc4_.bullets;
            _loc2_.rockets = _loc4_.rockets;
            _loc1_++;
         }
      }
      
      private function actionPerformedSubEnding() : void
      {
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         if(_loc1_.AP > 0)
         {
            this.activateNextBattlePhase("turn_startNewAction",{"caller":"actionPerformedSubEnding"});
            return;
         }
         var _loc4_:Boolean = false;
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
         if(_loc4_ == false)
         {
            if(BattleTypeResolver.isReplay == false)
            {
               this.activateNextBattlePhase("action_energyRegenerationPhase");
               return;
            }
         }
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_REPLAY:
               this.playReplayAction();
               break;
            default:
               if(dataM.playingVSComputer)
               {
                  this.setSocketAllowedStatus(true,"actionPerformedSub >> droneAttack");
                  _loc3_.droneFired = true;
                  this.fireLocally(BMMechStructure.DRONE,0);
               }
               else if(this._currentPlayerID == dataM.ONLINE_OPPONENT_ID)
               {
                  screensM.screenDebugger.addTrace("### Waiting opponent\'s drone to fire");
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
                  if(BattleTypeResolver.isBattleOnServer)
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
                     if(dataM.gameType != BMDataManager.GAME_TYPE_REPLAY)
                     {
                        if(this._currentPlayerID == dataM.player1PlayerID)
                        {
                           screensM.screenBattleInterfaceBottom.setShuttingDownAlertCountdownToMax();
                           screensM.screenBattleInterfaceBottom.activateActionErrorMessage("shuttingDown");
                        }
                     }
                  }
               }
               else if(BattleTypeResolver.isBattleOnServer)
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
      
      public function autopilotSwitchedOn() : void
      {
         if(screensM.screenBattleInterfaceBottom.isEnabled() == false)
         {
            return;
         }
         switch(this._battlePhase)
         {
            case "initiate_player2Entry":
            case "turn_startNewAction":
            case "turn_startNewActionSub":
            case "turn_actionPerformed":
            case "endBattle_quit":
               if(this._currentPlayerID == dataM.player1PlayerID)
               {
                  this.computerM.executeTurn(dataM.player1PlayerID,"startNewActionSub");
               }
         }
      }
      
      private function startNewActionSub() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(this._setSocketAllowedStatusTrueInStartNewActionSub)
         {
            this.setSocketAllowedStatus(true,"startNewActionSub >> after shutDown");
            this._setSocketAllowedStatusTrueInStartNewActionSub = false;
         }
         if(this._currentPlayerID == dataM.player1PlayerID)
         {
            if(this._forcePlayerJumpToStep > -1)
            {
               this._skipStartNewActionEnbaleInterface = true;
            }
            if(this._skipStartNewActionEnbaleInterface)
            {
               this._skipStartNewActionEnbaleInterface = false;
            }
            else
            {
               this.enableInterface("startNewActionSub");
            }
            if(this._forcePlayerJumpToStep > -1)
            {
               _loc1_ = dataM.playersData[this._currentPlayerID];
               _loc2_ = this.getMechSlot(this._currentPlayerID,_loc1_.selectedMechID);
               _loc3_ = this._mechBattleDatas[_loc2_];
               if(_loc3_.droneActive)
               {
                  _loc1_.AP = 1;
                  this._battleTurnData.set_AP(1,1);
               }
               else
               {
                  _loc1_.AP = 2;
                  this._battleTurnData.set_AP(1,2);
               }
               this.moveMechToStepLocallySub("jump",this._forcePlayerJumpToStep);
               _loc1_.AP = this._battleTurnData.get_AP(1);
               this._forcePlayerJumpToStep = -1;
               _loc4_ = _loc3_.droneActive;
               _loc3_.droneActive = false;
               if(tutorialM.isTutorialActive() == false)
               {
                  this._battleTurnData = null;
               }
               this.addBattleReportData(0,0);
               this.initializeBattleReport();
               if(_loc4_)
               {
                  _loc3_.droneActive = true;
                  this._battleTurnData.set_droneActive(this._currentPlayerInterfacePlayerID,true);
                  this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_ACTIVATE_DRONE));
               }
            }
            else if(dataM.userAutopilot)
            {
               _loc5_ = this.doesPendingSinglePlayerSocketCallExist();
               if(!_loc5_)
               {
                  this.computerM.executeTurn(dataM.player1PlayerID,"startNewActionSub");
               }
            }
         }
         else
         {
            if(!(this._currentPlayerID == dataM.ONLINE_OPPONENT_ID && BattleTypeResolver.isBattleOnServer))
            {
               this.computerM.executeTurn(dataM.player2PlayerID,"startNewActionSub");
            }
            this.hideInterface(false,false,"startNewActionSub");
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
      
      private function tryToStartFirstTurn() : void
      {
         if(this._activatePlayer1Entry)
         {
            return;
         }
         if(this._activatePlayer2Entry)
         {
            return;
         }
         if(this._initialMechsBuilt == false)
         {
            return;
         }
         if(this._screenInitiated == false)
         {
            return;
         }
         if(this._forcePlayerJumpFramesDelay > 0)
         {
            return;
         }
         this._firstTurnStarted = true;
         this.activateNextBattlePhase("turn_start");
      }
      
      private function startNewTurn() : void
      {
         var _loc5_:BMPlayerProfile = null;
         ++this._turn;
         this.enableTopInterfaceButtons();
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc2_:String = this.getMechSlot(this._currentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         if(this._turn != 1)
         {
            _loc1_.AP = _loc1_.APMax;
         }
         if(this._activatePlayer2DelayedEntry == false)
         {
            screensM.screenBattleInterfaceTop.refreshAP(this._currentPlayerID);
         }
         _loc3_.droneFired = false;
         _loc3_.resetAlreadyFired();
         this.refreshMechsDepth();
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
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
               if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
               {
                  if(this._turn == 1)
                  {
                     screensM.screenBattleInterfaceTop.stopAndResetDelayTimer();
                  }
                  screensM.screenBattleInterfaceTop.activateClock(this._turn);
               }
               break;
            case dataM.LOCAL_PLAYER_ID:
            case dataM.LOCAL_OPPONENT_ID:
               this.resetBattleTurnDataLocally("startNewTurn");
               this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,_loc1_.AP);
         }
         this.activateNextBattlePhase("turn_startNewAction",{"caller":"startNewTurn"});
         var _loc4_:String = "";
         if(dataM.playingVSComputer)
         {
            _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc5_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_LONE_BATTLE2)
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
         if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_fireWeapon(param1,param2);
         }
         else
         {
            this.fireLocally(param1,param2);
         }
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
      
      private function meleeJumpAttack(param1:String, param2:Number) : Boolean
      {
         if(param1 != BMMechStructure.SIDE_WEAPON)
         {
            return false;
         }
         var _loc3_:String = param1 + param2;
         var _loc4_:String = this.getMechSlot(this._currentPlayerID);
         var _loc5_:BMMechBattleData = this._mechBattleDatas[_loc4_];
         var _loc6_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc7_:BMMechBattleData = this._mechBattleDatas[_loc6_];
         var _loc8_:Number = Number(_loc5_.mechStructure[_loc3_]);
         var _loc9_:BMPlayerItemData = dataM.getPlayerItemData(this._currentPlayerID,_loc8_);
         var _loc10_:BMItemData = dataM.itemsDB[_loc9_.itemID];
         var _loc11_:Number = _loc5_.currentStepVisual;
         var _loc12_:Number = _loc7_.currentStepVisual;
         if(_loc10_.animation.substr(0,5) == "sword")
         {
            if(Math.abs(_loc11_ - _loc12_) > 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function fireLocallyCalculations(param1:String, param2:Number, param3:Boolean) : void
      {
         var _loc12_:String = null;
         var _loc22_:Number = NaN;
         var _loc23_:BMPlayerItemData = null;
         var _loc24_:BMItemData = null;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Boolean = false;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:uint = 0;
         var _loc32_:Object = null;
         var _loc33_:Number = NaN;
         var _loc34_:int = 0;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:uint = 0;
         var _loc41_:uint = 0;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc45_:Number = NaN;
         var _loc46_:Boolean = false;
         var _loc47_:BMPlayerItemData = null;
         var _loc48_:BMItemData = null;
         var _loc49_:Number = NaN;
         var _loc50_:Number = NaN;
         var _loc51_:Number = NaN;
         var _loc52_:Number = NaN;
         this._lastMeleeJumpAttack = this.meleeJumpAttack(param1,param2);
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc5_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc6_:String = this.getMechSlot(this._currentPlayerID);
         var _loc7_:BMMechBattleData = this._mechBattleDatas[_loc6_];
         var _loc8_:int = 0;
         if(param1 == BMMechStructure.DRONE)
         {
            _loc23_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_.mechStructure.drone);
            _loc24_ = dataM.itemsDB[_loc23_.itemID];
            if(_loc24_.HPAddon > 0)
            {
               param3 = false;
               _loc8_ = _loc24_.HPAddon;
            }
         }
         var _loc9_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc10_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc11_:BMMechBattleData = this._mechBattleDatas[_loc10_];
         switch(param1)
         {
            case BMMechStructure.SIDE_WEAPON:
            case BMMechStructure.TOP_WEAPON:
               _loc12_ = param1 + param2;
               break;
            default:
               _loc12_ = param1;
         }
         var _loc13_:Number = Number(_loc7_.mechStructure[_loc12_]);
         var _loc14_:BMPlayerItemData = dataM.getPlayerItemData(this._currentPlayerID,_loc13_);
         var _loc15_:BMItemData = dataM.itemsDB[_loc14_.itemID];
         var _loc16_:Number = _loc7_.generalDamageRatio;
         if(param1 == BMMechStructure.LEG)
         {
            _loc16_ = _loc7_.stompDamageRatio;
         }
         var _loc17_:Number = 0;
         var _loc18_:Number = 0;
         var _loc19_:Number = 0;
         if(param3)
         {
            _loc25_ = _loc15_.damageBase;
            _loc26_ = _loc15_.damageAddon;
            _loc27_ = this._currentPlayerID == dataM.player1PlayerID && isFightingClanBoss;
            if(_loc25_ > 0)
            {
               _loc25_ = BMMechStatsResolver.getDamage(_loc15_.damageType,_loc25_,this._currentPlayerID,_loc27_);
            }
            if(_loc26_ > 0)
            {
               _loc26_ = BMMechStatsResolver.getDamage(_loc15_.damageType,_loc26_,this._currentPlayerID,_loc27_);
               if(tutorialM.isTutorialActive())
               {
                  _loc26_ = Math.ceil(Math.random() * (_loc26_ + 1)) - 1;
               }
               else
               {
                  _loc26_ = dataM.battle_syncRandom.randrange(0,_loc26_);
               }
            }
            _loc28_ = 0;
            if(_loc25_ + _loc26_ > 0)
            {
               _loc28_ = Math.ceil((_loc25_ + _loc26_) * _loc16_);
            }
            if(_loc28_ > 0)
            {
               _loc29_ = Number(_loc11_["resist" + _loc15_.damageType]);
               _loc30_ = _loc28_;
               _loc30_ = _loc30_ - _loc29_;
               if(dataM.clientRunningLocally)
               {
                  if(this._opponentPlayerID == dataM.player1PlayerID)
                  {
                     _loc30_ -= dataM.cheatWeaponResistance;
                  }
               }
               if(_loc30_ < 1)
               {
                  _loc30_ = 1;
               }
               if(dataM.clientRunningLocally)
               {
                  if(dataM.playingVSComputer)
                  {
                     if(this._currentPlayerID == dataM.player1PlayerID)
                     {
                        if(BMGameShortcutsHelper.extraDamamgeShortcut())
                        {
                           _loc30_ += 500;
                        }
                     }
                     else
                     {
                        _loc30_ += dataM.cheatWeaponDamageComputer;
                     }
                  }
               }
               _loc31_ = BMMechStatsResolver.getEnergyDamage(_loc15_.damageEnergy,this._currentPlayerID);
               _loc32_ = this.getShieldBlockInfo(this._opponentPlayerID,_loc30_,_loc31_);
               _loc17_ = Number(_loc32_.energyUsed);
               _loc18_ = Number(_loc32_.heatUsed);
               _loc19_ = Number(_loc32_.damageFinal);
               if(this._currentPlayerID == dataM.player1PlayerID)
               {
                  if(_loc15_.type != BMMechStructure.DRONE)
                  {
                     this._droneOnlyWin = false;
                  }
                  if(_loc15_.rangeBase != 0 || _loc15_.rangeAddon != 1)
                  {
                     this._meleeOnlyWin = false;
                  }
               }
            }
         }
         this.resetBattleTurnDataLocally("fireLocallyCalculations");
         var _loc20_:Number = this._battleTurnData.get_energy(this._currentPlayerInterfacePlayerID) - _loc15_.costEnergy;
         var _loc21_:Number = this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID) + _loc15_.costHeat;
         this._battleTurnData.set_energy(this._currentPlayerInterfacePlayerID,_loc20_);
         this._battleTurnData.set_heat(this._currentPlayerInterfacePlayerID,_loc21_);
         this._battleTurnData.set_bullets(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_bullets(this._currentPlayerInterfacePlayerID) - _loc15_.bullets);
         this._battleTurnData.set_rockets(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_rockets(this._currentPlayerInterfacePlayerID) - _loc15_.rockets);
         if(_loc15_.HPAddon < 0)
         {
            _loc33_ = this._battleTurnData.get_HP(this._currentPlayerInterfacePlayerID);
            _loc34_ = BMMechStatsResolver.getHPCost(_loc15_.HPAddon,this._currentPlayerID);
            _loc33_ += _loc34_;
            this._battleTurnData.set_HP(this._currentPlayerInterfacePlayerID,_loc33_);
         }
         if(_loc7_.shieldActive)
         {
            switch(_loc7_.shieldType)
            {
               case "energy":
                  if(_loc20_ <= 0)
                  {
                     this._battleTurnData.set_shieldActive(this._currentPlayerInterfacePlayerID,false);
                  }
                  break;
               case "heat":
                  if(_loc21_ > _loc7_.heatMax)
                  {
                     this._battleTurnData.set_shieldActive(this._currentPlayerInterfacePlayerID,false);
                  }
            }
         }
         switch(param1)
         {
            case BMMechStructure.DRONE:
               break;
            default:
               this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         }
         if(this._lastMeleeJumpAttack)
         {
            _loc35_ = _loc7_.currentStepVisual;
            _loc36_ = _loc11_.currentStepVisual;
            if(_loc35_ > _loc36_)
            {
               this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,_loc36_ + 1);
            }
            else
            {
               this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,_loc36_ - 1);
            }
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVE)
         {
            _loc37_ = this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID);
            if(dataM.clientRunningLocally)
            {
               _loc37_ += dataM.cheatExtraHeat;
            }
            this._battleTurnData.set_heat(this._currentPlayerInterfacePlayerID,_loc37_);
         }
         if(param3)
         {
            _loc38_ = this._battleTurnData.get_energy(this._opponentPlayerInterfacePlayerID);
            _loc40_ = BMMechStatsResolver.getEnergyDamage(_loc15_.damageEnergy,this._currentPlayerID);
            _loc40_ = Math.round(_loc40_ * _loc16_);
            if(_loc40_ > _loc38_ - _loc17_)
            {
               _loc44_ = _loc40_ - (_loc38_ - _loc17_);
               _loc19_ += _loc44_;
               _loc39_ = _loc38_ - (_loc40_ - _loc44_) - _loc17_;
            }
            else
            {
               _loc39_ = _loc38_ - _loc40_ - _loc17_;
            }
            _loc41_ = BMMechStatsResolver.getHeatDamage(_loc15_.damageHeat,this._currentPlayerID);
            _loc42_ = this._battleTurnData.get_heat(this._opponentPlayerInterfacePlayerID) + Math.round(_loc41_ * _loc16_) + _loc18_;
            if(tutorialM.isTutorialActive())
            {
               if(this._opponentPlayerID == dataM.player1PlayerID)
               {
                  _loc45_ = this._battleTurnData.get_HP(this._opponentPlayerInterfacePlayerID);
                  if(_loc19_ >= _loc45_)
                  {
                     _loc19_ = _loc45_ - 1;
                  }
               }
            }
            _loc43_ = this._battleTurnData.get_HP(this._opponentPlayerInterfacePlayerID,_loc9_.selectedMechID) - _loc19_;
            this._battleTurnData.set_HP(this._opponentPlayerInterfacePlayerID,_loc43_);
            this._battleTurnData.set_energy(this._opponentPlayerInterfacePlayerID,_loc39_);
            this._battleTurnData.set_heat(this._opponentPlayerInterfacePlayerID,_loc42_);
            this.fireLocallyCalculationsSub_pushPull(this._opponentPlayerID,this._currentPlayerID,this._currentPlayerInterfacePlayerID,_loc15_.pushSelf);
            this.fireLocallyCalculationsSub_pushPull(this._currentPlayerID,this._opponentPlayerID,this._opponentPlayerInterfacePlayerID,_loc15_.push);
            if(_loc28_ > 0)
            {
               if(_loc11_.shieldActive)
               {
                  switch(_loc11_.shieldType)
                  {
                     case "energy":
                        _loc46_ = false;
                        if(_loc39_ <= 0)
                        {
                           _loc46_ = true;
                        }
                        else if(_loc19_ > 0)
                        {
                           _loc47_ = dataM.getPlayerItemData(this._opponentPlayerID,_loc11_.mechStructure.shield);
                           _loc48_ = dataM.itemsDB[_loc47_.itemID];
                           if(_loc39_ < _loc48_.energyPerBlock)
                           {
                              _loc46_ = true;
                           }
                        }
                        if(_loc46_)
                        {
                           this._battleTurnData.set_shieldActive(this._opponentPlayerInterfacePlayerID,false);
                        }
                        break;
                     case "heat":
                        if(_loc42_ > _loc11_.heatMax)
                        {
                           this._battleTurnData.set_shieldActive(this._opponentPlayerInterfacePlayerID,false);
                        }
                  }
               }
            }
         }
         if(_loc15_.resist1 > 0)
         {
            _loc22_ = Math.ceil(_loc15_.resist1 * _loc16_);
            this._battleTurnData.set_resist1(this._opponentPlayerInterfacePlayerID,this._battleTurnData.get_resist1(this._opponentPlayerInterfacePlayerID) - _loc22_);
         }
         if(_loc15_.resist2 > 0)
         {
            _loc22_ = Math.ceil(_loc15_.resist2 * _loc16_);
            this._battleTurnData.set_resist2(this._opponentPlayerInterfacePlayerID,this._battleTurnData.get_resist2(this._opponentPlayerInterfacePlayerID) - _loc22_);
         }
         if(_loc15_.resist3 > 0)
         {
            _loc22_ = Math.ceil(_loc15_.resist3 * _loc16_);
            this._battleTurnData.set_resist3(this._opponentPlayerInterfacePlayerID,this._battleTurnData.get_resist3(this._opponentPlayerInterfacePlayerID) - _loc22_);
         }
         if(this._currentPlayerID == dataM.player1PlayerID)
         {
            this._opponentResistance1 = this._battleTurnData.get_resist1(this._opponentPlayerInterfacePlayerID,1);
            this._opponentResistance2 = this._battleTurnData.get_resist2(this._opponentPlayerInterfacePlayerID,1);
            this._opponentResistance3 = this._battleTurnData.get_resist3(this._opponentPlayerInterfacePlayerID,1);
            if(this._maxSingleShotDamage < _loc19_)
            {
               this._maxSingleShotDamage = _loc19_;
            }
         }
         if(_loc15_.damageEnergyBase > 0)
         {
            _loc49_ = _loc11_.energyMax - Math.round(_loc15_.damageEnergyBase * _loc16_);
            if(_loc49_ < 1)
            {
               _loc49_ = 1;
            }
            _loc11_.energyMax = _loc49_;
            if(this._battleTurnData.get_energy(this._opponentPlayerInterfacePlayerID) > _loc49_)
            {
               this._battleTurnData.set_energy(this._opponentPlayerInterfacePlayerID,_loc49_);
            }
         }
         if(_loc15_.damageEnergyAddon > 0)
         {
            _loc50_ = _loc11_.energyRegeneration - Math.round(_loc15_.damageEnergyAddon * _loc16_);
            if(_loc50_ < 1)
            {
               _loc50_ = 1;
            }
            _loc11_.energyRegeneration = _loc50_;
         }
         if(_loc15_.damageHeatBase > 0)
         {
            _loc51_ = _loc11_.heatMax - Math.round(_loc15_.damageHeatBase * _loc16_);
            if(_loc51_ < 1)
            {
               _loc51_ = 1;
            }
            _loc11_.heatMax = _loc51_;
         }
         if(_loc15_.damageHeatAddon > 0)
         {
            _loc52_ = _loc11_.heatCooling - Math.round(_loc15_.damageHeatAddon * _loc16_);
            if(_loc52_ < 1)
            {
               _loc52_ = 1;
            }
            _loc11_.heatCooling = _loc52_;
         }
         if(_loc8_ > 0)
         {
            this.addBattleReportData(_loc13_,-_loc8_);
         }
         else if(param3)
         {
            this.addBattleReportData(_loc13_,_loc19_);
         }
         else
         {
            this.addBattleReportData(0,0);
         }
         if(param1 != BMReplayAction.ACTION_NAME_TELEPORT)
         {
            if(param1 != BMReplayAction.ACTION_NAME_HARPOON)
            {
               if(param1 != BMReplayAction.ACTION_NAME_CHARGE)
               {
                  this.addBattleReportReplayAction(BMReplayAction.createFireWeaponAction(param1,param2));
               }
            }
         }
      }
      
      private function fireLocallyCalculationsSub_pushPull(param1:uint, param2:uint, param3:uint, param4:Number) : void
      {
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc5_:String = this.getMechSlot(param1);
         var _loc6_:BMMechBattleData = this._mechBattleDatas[_loc5_];
         var _loc7_:String = this.getMechSlot(param2);
         var _loc8_:BMMechBattleData = this._mechBattleDatas[_loc7_];
         var _loc9_:Number = this._battleTurnData.get_step(param3);
         var _loc10_:Boolean = false;
         if(param4 != 0)
         {
            if(!(param1 == dataM.player1PlayerID && this.isOpponentSpecialBoss()))
            {
               _loc10_ = true;
            }
         }
         if(_loc10_ == false)
         {
            return;
         }
         if(param4 > 0)
         {
            if(_loc6_.currentStepVisual > _loc8_.currentStepVisual)
            {
               _loc9_ -= param4;
               if(_loc9_ < 0)
               {
                  _loc9_ = 0;
               }
            }
            else
            {
               _loc9_ += param4;
               if(_loc9_ >= dataM.battleData.map.stepsTotal)
               {
                  _loc9_ = dataM.battleData.map.stepsTotal - 1;
               }
            }
         }
         else
         {
            _loc11_ = Math.abs(_loc6_.currentStepVisual - _loc8_.currentStepVisual) - 1;
            _loc12_ = Math.abs(param4);
            if(_loc12_ > _loc11_)
            {
               _loc12_ = _loc11_;
            }
            if(_loc12_ > 0)
            {
               if(_loc6_.currentStepVisual > _loc8_.currentStepVisual)
               {
                  _loc9_ += _loc12_;
               }
               else
               {
                  _loc9_ -= _loc12_;
               }
            }
         }
         this._battleTurnData.set_step(param3,_loc9_);
         _loc8_.currentStepCode = this._battleTurnData.get_step(param3);
      }
      
      public function fireSuccess(param1:String, param2:Number) : void
      {
         var _loc10_:String = null;
         var _loc18_:Object = null;
         var _loc21_:MovieClip = null;
         var _loc22_:Array = null;
         var _loc23_:uint = 0;
         var _loc24_:MovieClip = null;
         var _loc25_:Point = null;
         var _loc26_:Point = null;
         var _loc27_:Point = null;
         var _loc28_:Boolean = false;
         var _loc29_:MovieClip = null;
         var _loc30_:Point = null;
         var _loc31_:Point = null;
         var _loc32_:Point = null;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Array = null;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:String = null;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc45_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc47_:String = null;
         var _loc48_:String = null;
         var _loc49_:Number = NaN;
         var _loc50_:Number = NaN;
         var _loc51_:Array = null;
         var _loc52_:String = null;
         var _loc53_:String = null;
         var _loc54_:String = null;
         var _loc55_:String = null;
         var _loc56_:String = null;
         var _loc57_:Number = NaN;
         var _loc58_:Number = NaN;
         var _loc59_:Number = NaN;
         var _loc60_:Number = NaN;
         var _loc61_:Number = NaN;
         var _loc62_:uint = 0;
         var _loc63_:Boolean = false;
         var _loc64_:Number = NaN;
         var _loc65_:Number = NaN;
         var _loc66_:Number = NaN;
         var _loc67_:MovieClip = null;
         var _loc68_:Point = null;
         var _loc69_:Point = null;
         var _loc70_:Point = null;
         var _loc71_:Number = NaN;
         var _loc72_:String = null;
         var _loc73_:Number = NaN;
         var _loc74_:Number = NaN;
         var _loc75_:Boolean = false;
         var _loc76_:Number = NaN;
         var _loc77_:Boolean = false;
         var _loc78_:String = null;
         var _loc79_:uint = 0;
         var _loc80_:uint = 0;
         var _loc81_:String = null;
         var _loc82_:Boolean = false;
         var _loc83_:String = null;
         var _loc84_:MovieClip = null;
         var _loc85_:Number = NaN;
         var _loc86_:Number = NaN;
         var _loc87_:Number = NaN;
         var _loc88_:Number = NaN;
         var _loc89_:Number = NaN;
         this.setSocketAllowedStatus(false,"fireSuccess");
         if(dataM.playingVSComputer == false)
         {
            this._lastMeleeJumpAttack = this.meleeJumpAttack(param1,param2);
         }
         this._lastAction = "fireWeapon";
         this._lastWeaponEquipmentType = param1;
         this._lastWeaponEquipmentID = param2;
         var _loc3_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc4_:String = this.getMechSlot(this._currentPlayerID);
         var _loc5_:BMMechBattleData = this._mechBattleDatas[_loc4_];
         var _loc6_:BMMechView = _loc5_.mechView;
         var _loc7_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc8_:String = this.getMechSlot(this._opponentPlayerID);
         var _loc9_:BMMechBattleData = this._mechBattleDatas[_loc8_];
         switch(param1)
         {
            case BMMechStructure.DRONE:
            case BMMechStructure.LEG:
               _loc10_ = param1;
               break;
            default:
               _loc10_ = param1 + param2;
         }
         var _loc11_:Number = Number(_loc5_.mechStructure[_loc10_]);
         var _loc12_:BMPlayerItemData = dataM.getPlayerItemData(this._currentPlayerID,_loc11_);
         var _loc13_:BMItemData = dataM.itemsDB[_loc12_.itemID];
         if(FeatureFlags.ALWAYS_USER_ASCENSION_EFFECTS || _loc13_.specialStatus == ItemRarityResolver.RARITY_ASCENDED)
         {
            _loc6_.activateWeaponGlow(_loc10_,_loc13_.naturalTier);
         }
         if(this._fireJumpAcitve)
         {
            this._fireJumpAcitve = false;
         }
         else if(_loc13_.isFireJumpWeapon)
         {
            this._fireJumpAcitve = true;
            this.activateFireJump(_loc6_,param1,param2,_loc13_);
         }
         var _loc14_:Boolean = _loc13_.isFireJumpWeapon == false || _loc13_.isFireJumpWeapon && this._fireJumpAcitve == false;
         var _loc15_:Boolean = _loc13_.isFireJumpWeapon == false || _loc13_.isFireJumpWeapon && this._fireJumpAcitve;
         var _loc16_:Boolean = true;
         var _loc17_:Boolean = true;
         _loc18_ = dataM.animationDB[_loc13_.animation];
         var _loc19_:Boolean = false;
         switch(_loc18_.effectType)
         {
            case "immediate1":
            case "immediate2":
               _loc19_ = true;
         }
         var _loc20_:Boolean = true;
         if(_loc14_)
         {
            this._lastWeaponDamageType = _loc13_.damageType;
            if(_loc18_.effectType == "grenade" && Math.random() <= dataM.getGeneralSetting("chickenShotChance",0.002))
            {
               _loc18_ = dataM.animationDB["chicken"];
               this._chickenProjectile = true;
            }
            if(BattleTypeResolver.isReplay || BattleTypeResolver.isBattleOnServer)
            {
               _loc57_ = 1;
               if(BattleTypeResolver.isSinglePlayer)
               {
                  _loc57_ = _loc5_.generalDamageRatio;
               }
               if(_loc13_.damageEnergyBase > 0)
               {
                  _loc58_ = _loc9_.energyMax - Math.round(_loc13_.damageEnergyBase * _loc57_);
                  if(_loc58_ < 1)
                  {
                     _loc58_ = 1;
                  }
                  _loc9_.energyMax = _loc58_;
                  if(this._battleTurnData.get_energy(this._opponentPlayerInterfacePlayerID) > _loc58_)
                  {
                     this._battleTurnData.set_energy(this._opponentPlayerInterfacePlayerID,_loc58_);
                  }
               }
               if(_loc13_.damageEnergyAddon > 0)
               {
                  _loc59_ = _loc9_.energyRegeneration - Math.round(_loc13_.damageEnergyAddon * _loc57_);
                  if(_loc59_ < 1)
                  {
                     _loc59_ = 1;
                  }
                  _loc9_.energyRegeneration = _loc59_;
               }
               if(_loc13_.damageHeatBase > 0)
               {
                  _loc60_ = _loc9_.heatMax - Math.round(_loc13_.damageHeatBase * _loc57_);
                  if(_loc60_ < 1)
                  {
                     _loc60_ = 1;
                  }
                  _loc9_.heatMax = _loc60_;
               }
               if(_loc13_.damageHeatAddon > 0)
               {
                  _loc61_ = _loc9_.heatCooling - Math.round(_loc13_.damageHeatAddon * _loc57_);
                  if(_loc61_ < 1)
                  {
                     _loc61_ = 1;
                  }
                  _loc9_.heatCooling = _loc61_;
               }
            }
            switch(param1)
            {
               case BMMechStructure.SIDE_WEAPON:
               case BMMechStructure.TOP_WEAPON:
                  _loc5_.mechView.activateMachineGunBarrel(_loc10_);
                  _loc5_.mechView.activateShotgunHandle(_loc10_);
                  switch(_loc18_.effectType)
                  {
                     case "grenade":
                     case "grenadePull":
                        _loc5_.mechView.activateGrenadeLauncher(_loc10_);
                  }
            }
            switch(param1)
            {
               case BMMechStructure.LEG:
                  break;
               case BMMechStructure.DRONE:
                  _loc21_ = _loc5_.drone.droneGrpSub;
                  _loc5_.drone.haltVerticalMotion(30);
                  _loc5_.drone.addOnHoldFrames(_loc18_.droneOnHoldFrames);
                  break;
               default:
                  _loc21_ = _loc5_.mechView[_loc10_].item.itemGrp;
            }
            _loc22_ = new Array();
            if(_loc21_ != null)
            {
               _loc23_ = 1;
               while(_loc23_ <= 10)
               {
                  if(_loc21_["mcFire" + _loc23_] != null)
                  {
                     _loc24_ = _loc21_["mcFire" + _loc23_];
                     _loc25_ = new Point(_loc24_.x,_loc24_.y);
                     _loc26_ = _loc21_.localToGlobal(_loc25_);
                     _loc27_ = this.holder_main.globalToLocal(_loc26_);
                     _loc22_.push(_loc27_);
                  }
                  _loc23_++;
               }
            }
            _loc28_ = false;
            switch(param1)
            {
               case BMMechStructure.DRONE:
                  if(_loc5_.drone.droneGrp.scaleX == -1)
                  {
                     _loc28_ = true;
                  }
                  break;
               default:
                  if(_loc5_.mechView.scaleX == -1)
                  {
                     _loc28_ = true;
                  }
            }
            _loc37_ = ["immediate1","immediate2","projectile","grenade","grenadePull","chargeProjectile","rocket","rocketMassive","rocketStraight","artillery","artilleryDiagonal","flame","megaProjectile","orb","shockWave","wand","heatBomb","energyBomb","beam"];
            if(_loc37_.indexOf(_loc18_.effectType) > -1)
            {
               _loc29_ = _loc9_.mechView.torso;
               _loc30_ = new Point(_loc29_.x,_loc29_.y);
               _loc31_ = _loc29_.localToGlobal(_loc30_);
               _loc32_ = this.holder_main.globalToLocal(_loc31_);
               if(_loc18_.effectType != "immediate1" && _loc18_.effectType != "immediate2")
               {
                  _loc33_ = Math.abs(_loc22_[0].x - _loc32_.x);
                  _loc34_ = Math.abs(_loc22_[0].y - _loc32_.y);
                  if(_loc22_[0].y > _loc32_.y)
                  {
                     _loc34_ *= -1;
                  }
               }
            }
            _loc40_ = 0;
            switch(_loc18_.effectType)
            {
               case "projectile":
               case "chargeProjectile":
               case "rocket":
               case "rocketMassive":
               case "rocketStraight":
               case "beam":
                  switch(_loc18_.effectType)
                  {
                     case "rocket":
                     case "rocketMassive":
                     case "rocketStraight":
                        if(_loc18_.effectType == "rocketMassive")
                        {
                           _loc38_ = 1;
                           _loc39_ = 1;
                        }
                        else if(_loc13_.level <= 6)
                        {
                           _loc38_ = 2;
                           _loc39_ = 2;
                        }
                        else if(_loc13_.level <= 14)
                        {
                           _loc38_ = 3;
                           _loc39_ = 2;
                        }
                        else if(_loc13_.level <= 24)
                        {
                           _loc38_ = 4;
                           _loc39_ = 2;
                        }
                        else
                        {
                           _loc38_ = 3;
                           _loc39_ = 3;
                        }
                        _loc62_ = _loc38_ * _loc39_;
                        break;
                     case "beam":
                        _loc62_ = 8;
                        break;
                     default:
                        _loc62_ = _loc22_.length;
                  }
                  _loc63_ = true;
                  if(param1 != BMMechStructure.SIDE_WEAPON && param1 != BMMechStructure.TOP_WEAPON)
                  {
                     _loc63_ = false;
                  }
                  if(this._currentPlayerID == dataM.player2PlayerID && dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS && dataM.myProfile.clanBossData.allowWeaponFiringAngle == false)
                  {
                     _loc63_ = false;
                  }
                  if(_loc63_)
                  {
                     _loc64_ = _loc32_.x - _loc22_[0].x;
                     _loc65_ = _loc32_.y - _loc22_[0].y;
                     _loc40_ = dataM.getVectorAngle(_loc64_,_loc65_);
                     if(_loc6_.scaleX < 0)
                     {
                        _loc40_ = 180 - _loc40_;
                     }
                     _loc66_ = _loc62_ * BMMechView.WEAPON_FIRING_ANGLE_STATIC_FRAMES;
                     _loc6_.setWeaponFiringAngle(param1,param2,_loc40_,_loc66_);
                  }
            }
            if(_loc21_ != null)
            {
               _loc22_ = new Array();
               _loc23_ = 1;
               while(_loc23_ <= 10)
               {
                  if(_loc21_["mcFire" + _loc23_] != null)
                  {
                     _loc24_ = _loc21_["mcFire" + _loc23_];
                     _loc25_ = new Point(_loc24_.x,_loc24_.y);
                     _loc26_ = _loc21_.localToGlobal(_loc25_);
                     _loc27_ = this.holder_main.globalToLocal(_loc26_);
                     _loc22_.push(_loc27_);
                  }
                  _loc23_++;
               }
            }
            _loc48_ = "";
            if(_loc18_.bulletShellsInstant != "" || _loc18_.bulletShellsFrames != "")
            {
               if(_loc13_.type == BMMechStructure.DRONE)
               {
                  _loc67_ = _loc21_.mcCenter;
               }
               else
               {
                  _loc67_ = _loc21_.mcTorso;
               }
               _loc68_ = new Point(_loc67_.x,_loc67_.y);
               _loc69_ = _loc21_.localToGlobal(_loc68_);
               _loc70_ = this.holder_main.globalToLocal(_loc69_);
               this._bulletShellsDirection = "left";
               if(_loc5_.currentStepCode > _loc9_.currentStepCode)
               {
                  this._bulletShellsDirection = "right";
               }
               if(_loc18_.bulletShellsInstant != "")
               {
                  _loc71_ = _loc22_.length;
                  effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,_loc18_.bulletShellsInstant,_loc70_.x,_loc70_.y,1,_loc71_,30,this._bulletShellsDirection,"",true);
               }
               else if(_loc18_.bulletShellsFrames != "")
               {
                  this._bulletShellsHandler = true;
                  this._bulletShellsCounter = _loc18_.getHitSoundsLength;
                  if(dataM.generalSpeedRatio == 2)
                  {
                     this._bulletShellsCounter = Math.ceil(this._bulletShellsCounter / 2);
                  }
                  this._bulletShellsGrp = _loc18_.bulletShellsFrames;
                  this._bulletShellsXPos = _loc70_.x;
                  this._bulletShellsYPos = _loc70_.y;
               }
            }
            _loc51_ = this.getAttackerPerkSpecialShotData(_loc18_);
            _loc52_ = _loc51_[0];
            _loc53_ = _loc51_[1];
            _loc54_ = _loc51_[2];
            _loc55_ = _loc51_[3];
            _loc56_ = _loc51_[4];
            switch(_loc18_.effectType)
            {
               case "immediate1":
                  if(_loc53_ != "")
                  {
                     _loc43_ = 0;
                     while(_loc43_ < _loc22_.length)
                     {
                        _loc44_ = 0;
                        _loc45_ = 0;
                        _loc46_ = 0;
                        _loc78_ = "";
                        if(dataM.generalSpeedRatio == 2)
                        {
                           _loc78_ = "_fast";
                        }
                        _loc79_ = 1;
                        _loc80_ = 36;
                        switch(_loc18_.fireEffect)
                        {
                           case "machineGunFire2":
                              _loc79_ = 2;
                              _loc80_ = 38;
                              break;
                           case "machineGunFire3":
                              _loc79_ = 3;
                              _loc80_ = 38;
                        }
                        if(dataM.generalSpeedRatio == 2)
                        {
                           _loc80_ *= 0.5;
                           _loc80_ = Math.ceil(_loc80_);
                        }
                        _loc81_ = "machineGunFire" + _loc79_;
                        if(_loc53_ != "" && _loc53_ != _loc81_)
                        {
                           _loc81_ = _loc53_;
                        }
                        else if(dataM.newVisualEffects)
                        {
                           _loc81_ += "_new";
                        }
                        effectsM.createMachineGunFire(this.holder_effects,_loc81_,_loc22_[_loc43_].x,_loc22_[_loc43_].y,_loc79_,_loc28_,_loc80_);
                        if(dataM.newVisualEffects)
                        {
                           effectsM.createGetHitSparks(_loc32_.x,_loc32_.y,this.holder_effects,_loc80_);
                        }
                        _loc43_++;
                     }
                  }
                  soundM.createSound(_loc18_.sound,1);
                  if(_loc18_.getHitSoundsLength > 0)
                  {
                     this.activateGetHitSounds(_loc18_.getHitSoundsLength);
                  }
                  break;
               case "immediate2":
                  _loc72_ = _loc18_.fireEffect;
                  if(_loc53_ != "" && _loc53_ != _loc72_)
                  {
                     _loc72_ = _loc53_;
                  }
                  else if(dataM.newVisualEffects && _loc72_.indexOf("shotgun") > -1)
                  {
                     _loc72_ += "_new";
                  }
                  if(_loc18_.fireEffect != "")
                  {
                     _loc43_ = 0;
                     while(_loc43_ < _loc22_.length)
                     {
                        _loc44_ = 0;
                        _loc45_ = 0;
                        _loc46_ = 0;
                        effectsM.createFireEffect(_loc72_,_loc22_[_loc43_].x,_loc22_[_loc43_].y,_loc28_,0,this.holder_effects);
                        _loc43_++;
                     }
                  }
                  this.activateWeaponFeedbackAndSound(this._currentPlayerID,"xAxis",_loc18_.sound);
                  this.activateGetHit(this._opponentPlayerID,"xAxisFront",true,false);
                  break;
               case "grenade":
               case "grenadePull":
                  if(_loc18_.effectType == "grenadePull")
                  {
                     _loc33_ += this.GRENADE_PULL_EXPLOSION_X_PUSH;
                     _loc35_ = _loc33_ / 42;
                     if(dataM.generalSpeedRatio == 2)
                     {
                        _loc35_ = _loc33_ / 22;
                     }
                  }
                  else
                  {
                     _loc35_ = _loc33_ / 32;
                     if(dataM.generalSpeedRatio == 2)
                     {
                        _loc35_ = _loc33_ / 16;
                     }
                  }
                  _loc36_ = 0;
                  _loc42_ = _loc18_.sound;
                  _loc41_ = 6;
                  if(_loc54_ != "")
                  {
                     _loc48_ = _loc54_;
                  }
                  else if(dataM.newVisualEffects)
                  {
                     _loc48_ = "effect_getHit_phys1";
                     if(_loc13_.damageType == 2)
                     {
                        _loc48_ = "effect_getHit_heat1";
                     }
                     else if(_loc13_.damageType == 3)
                     {
                        _loc48_ = "effect_getHit_energy1";
                     }
                  }
                  if(_loc52_ == "")
                  {
                     _loc52_ = _loc18_.projectile;
                  }
                  effectsM.createProjectileShots(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc52_,_loc18_.fireEffect,_loc49_,_loc41_,_loc28_,_loc35_,_loc36_,_loc33_,_loc34_,_loc22_,_loc48_,_loc42_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
                  break;
               case "beam":
                  _loc43_ = _loc22_.length - 1;
                  while(_loc43_ >= 0)
                  {
                     _loc44_ = 0;
                     _loc45_ = 0;
                     _loc46_ = 0;
                     _loc82_ = false;
                     if(dataM.generalSpeedRatio == 2)
                     {
                        _loc82_ = true;
                     }
                     _loc83_ = _loc18_.effectColor;
                     if(_loc55_ != "")
                     {
                        _loc83_ = _loc55_;
                     }
                     if(_loc43_ == 0)
                     {
                        effectsM.createFireBeam(this.holder_effects,_loc18_.effectShape,_loc83_,_loc18_.size,false,_loc82_,_loc28_,_loc22_[_loc43_].x,_loc22_[_loc43_].y,this.beamAttackEnded,this.createBeamAttackSound,_loc40_);
                     }
                     else
                     {
                        effectsM.createFireBeam(this.holder_effects,_loc18_.effectShape,_loc83_,_loc18_.size,true,_loc82_,_loc28_,_loc22_[_loc43_].x,_loc22_[_loc43_].y,null,null,_loc40_);
                     }
                     _loc43_--;
                  }
                  this._beamAttackSound = _loc18_.sound;
                  break;
               case "projectile":
               case "chargeProjectile":
                  _loc49_ = 0;
                  switch(_loc18_.effectType)
                  {
                     case "chargeProjectile":
                        _loc84_ = externalAssetsM.getAsset("general","Grp_energyCharge_" + _loc18_.effectColor,140,140,false,false);
                        _loc85_ = 10;
                        _loc86_ = 20;
                        _loc87_ = 70;
                        _loc88_ = 7;
                        if(dataM.generalSpeedRatio == 2)
                        {
                           _loc88_ = 10;
                           _loc87_ = 50;
                        }
                        effectsM.createEnergyChargeMC(BMScreensManager.SCR_BATTLE,this.holder_effects,_loc22_[0].x,_loc22_[0].y,_loc87_,_loc85_,_loc86_,_loc88_,_loc18_.effectColor,_loc84_,null);
                        _loc49_ = _loc86_ + Math.ceil(_loc87_ / _loc88_);
                        soundM.createSound("chargeEnergy",1);
                        break;
                     case "projectile":
                  }
                  _loc42_ = _loc18_.sound;
                  _loc35_ = 80;
                  _loc36_ = 0;
                  _loc41_ = 6;
                  if(dataM.generalSpeedRatio == 2)
                  {
                     _loc35_ = 120;
                     _loc41_ = 4;
                  }
                  if(dataM.newVisualEffects)
                  {
                     if(_loc54_ != "")
                     {
                        _loc48_ = _loc54_;
                     }
                     else
                     {
                        _loc48_ = "effect_getHit_phys1";
                        if(_loc13_.damageType == 2)
                        {
                           _loc48_ = "effect_getHit_heat1";
                        }
                        else if(_loc13_.damageType == 3)
                        {
                           _loc48_ = "effect_getHit_energy1";
                        }
                     }
                  }
                  effectsM.createProjectileShots(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc52_,_loc53_,_loc49_,_loc41_,_loc28_,_loc35_,_loc36_,_loc33_,_loc34_,_loc22_,_loc48_,_loc42_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
                  break;
               case "megaProjectile":
                  effectsM.createMegaProjectile(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc18_.projectile,_loc18_.fireEffect,_loc56_,_loc18_.sound,_loc28_,_loc33_,_loc34_,_loc22_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
                  break;
               case "orb":
                  _loc33_ += this.FLOOR_STEP_SIZE / 2;
                  effectsM.createOrb(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc52_,false,false,_loc53_,_loc56_,_loc18_.effectColor,_loc18_.sound,_loc28_,_loc33_,_loc22_,this.activateWeaponFeedbackAndSound,null,this.attackEnded,[_loc17_]);
                  break;
               case "heatBomb":
                  this._delayAttackerHeatBarRefresh = true;
                  _loc33_ /= 2;
                  effectsM.createOrb(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc52_,true,false,_loc53_,_loc56_,_loc18_.effectColor,_loc18_.sound,_loc28_,_loc33_,_loc22_,this.activateWeaponFeedbackAndSound,null,this.attackEnded,[_loc17_]);
                  break;
               case "energyBomb":
                  this._delayAttackerEnergyBarRefresh = true;
                  _loc33_ /= 2;
                  effectsM.createOrb(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc52_,false,true,_loc53_,_loc56_,_loc18_.effectColor,_loc18_.sound,_loc28_,_loc33_,_loc22_,this.activateWeaponFeedbackAndSound,null,this.attackEnded,[_loc17_]);
                  break;
               case "shockWave":
                  effectsM.createShockWave(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc18_.projectile,_loc18_.fireEffect,_loc18_.tailEffect,_loc18_.effectColor,_loc22_,_loc18_.sound,_loc28_,_loc33_,_loc34_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
                  break;
               case "wand":
                  _loc5_.mechView.activateWand(param2,null,false);
                  break;
               case "repair":
                  this._attackEnded_refreshBars = true;
                  this._attackEnded_performAction = true;
                  effectsM.createRepairBeam(_loc28_,_loc22_[0].x,_loc22_[0].y,this.holder_effects,this.attackEnded,[this.delayNewActionHandler]);
                  soundM.createSound("droneRepair",1);
                  break;
               case "rocket":
               case "rocketMassive":
               case "rocketStraight":
                  _loc35_ = 1;
                  _loc36_ = 3;
                  _loc34_ -= 35;
                  _loc41_ = 4;
                  if(dataM.generalSpeedRatio == 2)
                  {
                     _loc35_ = 2;
                     _loc36_ = 6;
                     _loc41_ = 3;
                  }
                  _loc50_ = 10;
                  if(_loc18_.effectType == "rocketStraight")
                  {
                     _loc38_ = 3;
                     _loc39_ = 1;
                     _loc50_ = 0;
                  }
                  _loc42_ = _loc18_.sound;
                  if(_loc52_ != "" && _loc52_ != _loc18_.rocket)
                  {
                     _loc47_ = _loc52_;
                  }
                  else
                  {
                     _loc47_ = _loc18_.rocket;
                     if(dataM.newVisualEffects)
                     {
                        _loc47_ += "_new";
                     }
                  }
                  if(_loc54_ != "")
                  {
                     _loc48_ = _loc54_;
                  }
                  else if(dataM.newVisualEffects)
                  {
                     _loc48_ = "effect_explosionMedium1";
                  }
                  effectsM.createRocketBarrage(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc47_,_loc18_.fireEffect,_loc38_,_loc39_,_loc41_,_loc50_,_loc28_,_loc35_,_loc36_,_loc33_,_loc34_,_loc22_[0].x,_loc22_[0].y + 10,_loc48_,_loc42_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
                  break;
               case "artillery":
               case "artilleryDiagonal":
                  _loc73_ = 40;
                  _loc41_ = 4;
                  if(_loc13_.level <= 6)
                  {
                     _loc38_ = 2;
                     _loc39_ = 2;
                  }
                  else if(_loc13_.level <= 14)
                  {
                     _loc38_ = 3;
                     _loc39_ = 2;
                  }
                  else if(_loc13_.level <= 24)
                  {
                     _loc38_ = 4;
                     _loc39_ = 2;
                  }
                  else
                  {
                     _loc38_ = 3;
                     _loc39_ = 3;
                  }
                  if(dataM.generalSpeedRatio == 2)
                  {
                     _loc73_ = 80;
                     _loc41_ = 3;
                  }
                  _loc74_ = 12;
                  _loc50_ = 0;
                  _loc42_ = _loc18_.sound;
                  _loc75_ = false;
                  if(_loc18_.effectType == "artilleryDiagonal")
                  {
                     _loc50_ = 12;
                     _loc75_ = true;
                  }
                  if(_loc52_ != "" && _loc52_ != _loc18_.rocket)
                  {
                     _loc47_ = _loc52_;
                  }
                  else
                  {
                     _loc47_ = _loc18_.rocket;
                     if(dataM.newVisualEffects)
                     {
                        _loc47_ += "_new";
                        _loc48_ = "effect_explosionMedium1";
                     }
                  }
                  if(_loc54_ != "")
                  {
                     _loc48_ = _loc54_;
                  }
                  effectsM.createArtilleryBarrage(this.holder_effects,this._currentPlayerID,this._opponentPlayerID,_loc75_,_loc28_,_loc47_,_loc18_.fireEffect,_loc38_,_loc39_,_loc41_,_loc74_,_loc50_,_loc73_,_loc22_[0].x,_loc22_[0].y,_loc32_.x,_loc32_.y,_loc48_,_loc42_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc17_]);
                  break;
               case "flame":
                  _loc76_ = this.FLOOR_STEP_SIZE;
                  if(_loc13_.rangeAddon > 1)
                  {
                     _loc76_ = 1.75 * this.FLOOR_STEP_SIZE;
                  }
                  effectsM.activateFlameThrower(this._opponentPlayerID,_loc22_[0].x,_loc22_[0].y,_loc5_.mechView.scaleX,_loc76_,_loc18_.fireEffect,this.activateGetHit,this.attackEnded,[_loc17_]);
                  soundM.createSound("flameThrower",1);
                  break;
               case "sword":
                  if(this._lastMeleeJumpAttack)
                  {
                     _loc89_ = (this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID) + 0.5) * this.FLOOR_STEP_SIZE;
                     _loc5_.mechView.activateFinish7(param2,_loc89_,this.swordAttackEnded);
                     _loc5_.currentStepVisual = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
                     _loc5_.currentStepCode = _loc5_.currentStepVisual;
                     this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
                     this.refreshMechCodeStepMarker(1);
                     this.refreshMechCodeStepMarker(2);
                     this._lastMeleeJumpAttack = false;
                  }
                  else
                  {
                     _loc5_.mechView.activateSword(param2,this.swordAttackEnded,false);
                  }
                  break;
               case "stomp":
                  if(_loc13_.uses == 0)
                  {
                     _loc20_ = false;
                  }
                  _loc5_.mechView.activateStomp(this.stompRegularAnimDone);
                  _loc77_ = false;
                  if(_loc77_)
                  {
                     soundM.createSound("horn" + Math.ceil(Math.random() * 2),1);
                  }
            }
            if(_loc13_.isRecoilWeapon)
            {
               if(this.canPushPlayerID(this._currentPlayerID))
               {
                  this.pushMech(this._opponentPlayerID,this._currentPlayerID,_loc13_.pushSelf,true,-1,-1,true);
               }
            }
            this._takeDamage_effectType = _loc18_.effectType;
         }
         if(_loc15_)
         {
            this.setNewDataForAttacker();
            if(_loc20_)
            {
               this.setNewUsesForAttacker(param1,param2);
            }
            if(_loc19_)
            {
               this.attackEnded(_loc16_);
            }
         }
      }
      
      private function getAttackerPerkSpecialShotData(param1:Object) : Array
      {
         var _loc2_:String = param1.projectile;
         if(_loc2_ == null)
         {
            _loc2_ = param1.rocket;
         }
         var _loc3_:String = param1.fireEffect;
         var _loc4_:String = "";
         var _loc5_:String = param1.effectColor;
         var _loc6_:String = param1.tailEffect;
         var _loc7_:Array = [_loc2_,_loc3_,_loc4_,_loc5_,_loc6_];
         if(dataM.newVisualEffects == false)
         {
            return _loc7_;
         }
         var _loc8_:String = this.getMechSlot(this._currentPlayerID);
         var _loc9_:BMMechBattleData = this._mechBattleDatas[_loc8_];
         var _loc10_:uint = _loc9_.mechStructure.perk;
         if(_loc10_ == 0)
         {
            return _loc7_;
         }
         var _loc11_:BMPlayerItemData = dataM.getPlayerItemData(this._currentPlayerID,_loc10_);
         var _loc12_:BMItemData = dataM.itemsDB[_loc11_.itemID];
         if(_loc12_.isShotsPerk == false)
         {
            return _loc7_;
         }
         _loc5_ = "white";
         _loc4_ = "effect_getHit_snow1";
         switch(param1.effectType)
         {
            case "immediate1":
               _loc3_ = param1.fireEffect + "_snow";
               break;
            case "immediate2":
               _loc3_ = "shotgunFire_snow";
               break;
            case "projectile":
            case "chargeProjectile":
            case "megaProjectile":
               switch(param1.projectile)
               {
                  case "bullet2":
                  case "laser1":
                  case "heat1":
                     _loc2_ = "snow_bullet2";
                     _loc3_ = "snow_bulletFire2";
                     break;
                  case "bullet3":
                  case "bullet4":
                  case "laser2":
                  case "laser3":
                  case "heat2":
                  case "heat3":
                     _loc2_ = "snow_bullet3";
                     _loc3_ = "snow_bulletFire3";
                     break;
                  default:
                     _loc2_ = "snow_bullet1";
                     _loc3_ = "snow_bulletFire1";
               }
               break;
            case "beam":
            case "stomp":
            case "sword":
            case "shockWave":
            case "flame":
               break;
            case "orb":
            case "energyBomb":
            case "heatBomb":
               _loc2_ = "orbWhite1";
               _loc3_ = "orbFireWhite1";
               _loc6_ = "orbTailWhite1";
               break;
            case "rocket":
            case "rocketMassive":
            case "rocketStraight":
            case "artillery":
            case "artilleryDiagonal":
               _loc2_ = param1.rocket + "_snow";
               _loc3_ = "snow_bulletFire1";
               break;
            case "grenade":
            case "grenadePull":
               _loc2_ = param1.effectType + "_snow";
               _loc3_ = "snow_bulletFire1";
               break;
            default:
               _loc5_ = "";
               _loc4_ = "";
         }
         return [_loc2_,_loc3_,_loc4_,_loc5_,_loc6_];
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
         if(this._delayAttackerHeatBarRefresh == false)
         {
            screensM.screenBattleInterfaceTop.refreshHeat(this._currentPlayerID,true);
         }
         if(this._delayAttackerEnergyBarRefresh == false)
         {
            screensM.screenBattleInterfaceTop.refreshEnergy(this._currentPlayerID,true);
         }
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
      
      public function doesAttackerHasEnoughHPToFireWeapon(param1:uint, param2:BMItemData) : Boolean
      {
         if(param2.HPAddon >= 0)
         {
            return true;
         }
         var _loc3_:String = this.getMechSlot(param1);
         var _loc4_:BMMechBattleData = this._mechBattleDatas[_loc3_];
         var _loc5_:Number = BMMechStatsResolver.getHPCost(param2.HPAddon,param1);
         return _loc4_.HP > Math.abs(_loc5_);
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
                  case BMMechStructure.SIDE_WEAPON:
                  case BMMechStructure.TOP_WEAPON:
                     _loc6_ = param1 + param2;
                     _loc5_.weaponAlreadyFired[_loc6_] = true;
                     break;
                  default:
                     _loc6_ = param1;
               }
               ++_loc5_.uses[_loc6_];
               if(param1 == BMMechStructure.DRONE)
               {
                  _loc7_ = false;
                  if(dataM.playingVSComputer)
                  {
                     if(_loc5_.usesMax[BMMechStructure.DRONE] > 0)
                     {
                        if(_loc5_.uses[BMMechStructure.DRONE] >= _loc5_.usesMax[BMMechStructure.DRONE])
                        {
                           _loc7_ = true;
                        }
                     }
                  }
                  else if(BattleTypeResolver.isBattleOnServer)
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
                     if(dataM.generalSpeedRatio == 2)
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
         var _loc7_:Number = NaN;
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
            _loc7_ = _loc3_.heat;
            _loc3_.heat = this._battleTurnData.get_heat(this._opponentPlayerInterfacePlayerID,_loc4_);
            if(_loc3_.heat > _loc3_.heatMax && _loc7_ <= _loc3_.heatMax)
            {
               if(dataM.newVisualEffects)
               {
                  effectsM.addAnimatedEffect("effect_getHit_heat2",this.holder_effects,_loc3_.mechView.x,_loc3_.mechView.y);
               }
            }
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
            if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL_PVE)
            {
               _loc3_.HP = 1;
            }
         }
         var _loc6_:Boolean = false;
         if(this._delayAttackerEnergyBarRefresh || this._delayAttackerHeatBarRefresh)
         {
            _loc6_ = true;
         }
         if(this._delayAttackerHeatBarRefresh)
         {
            this._delayAttackerHeatBarRefresh = false;
            screensM.screenBattleInterfaceTop.refreshHeat(this._currentPlayerID,true);
         }
         if(this._delayAttackerEnergyBarRefresh)
         {
            this._delayAttackerEnergyBarRefresh = false;
            screensM.screenBattleInterfaceTop.refreshEnergy(this._currentPlayerID,true);
         }
         if(_loc6_)
         {
            screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(dataM.getInterfacePlayerID(this._currentPlayerID));
         }
         screensM.screenBattleInterfaceTop.refreshHP(this._opponentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshHeat(this._opponentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshEnergy(this._opponentPlayerID,true);
         screensM.screenBattleInterfaceTop.refreshResistance(this._opponentPlayerID,1,true);
         screensM.screenBattleInterfaceTop.refreshResistance(this._opponentPlayerID,2,true);
         screensM.screenBattleInterfaceTop.refreshResistance(this._opponentPlayerID,3,true);
         if(_loc3_.mechView != null)
         {
            if(_loc3_.HP / _loc3_.HPMax > this.MECH_LIMP_EFFECT_HP_RATIO)
            {
               _loc3_.mechView.deactivateLimping();
            }
            else
            {
               _loc3_.mechView.activateLimping();
            }
         }
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(dataM.getInterfacePlayerID(this._opponentPlayerID));
      }
      
      private function attackEnded(param1:Boolean) : void
      {
         if(this.isFireJumpInProgress == false)
         {
            this.setSocketAllowedStatus(true,"attackEnded");
         }
         else
         {
            this._triggerSocketAllowedOnFireJumpEnded = true;
         }
         this._attackEnded_refreshBars = true;
         this._attackEnded_performAction = true;
         this.takeDamage("attackEnded",true,this._viewScaleFinal,true);
         if(this.isFireJumpInProgress == false)
         {
            this.attackEndedSub(param1,"attackEnded");
         }
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
         var _loc7_:BMMechBattleData = null;
         var _loc10_:BMMechBattleData = null;
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMItemData = null;
         var _loc13_:Boolean = false;
         var _loc14_:int = 0;
         var _loc15_:String = null;
         var _loc16_:* = undefined;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:BMMechView = null;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:MovieClip = null;
         var _loc27_:Point = null;
         var _loc28_:Point = null;
         var _loc29_:Point = null;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:String = null;
         var _loc36_:Object = null;
         var _loc37_:Boolean = false;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Boolean = false;
         var _loc41_:String = null;
         var _loc42_:String = null;
         var _loc43_:String = null;
         var _loc44_:BMPlayerItemData = null;
         var _loc45_:BMItemData = null;
         var _loc46_:Number = NaN;
         var _loc47_:* = undefined;
         var _loc48_:String = null;
         var _loc49_:Array = null;
         var _loc50_:Number = NaN;
         var _loc51_:Boolean = false;
         var _loc52_:String = null;
         var _loc5_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         var _loc6_:String = this.getMechSlot(this._currentPlayerID);
         _loc7_ = this._mechBattleDatas[_loc6_];
         var _loc8_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         var _loc9_:String = this.getMechSlot(this._opponentPlayerID);
         _loc10_ = this._mechBattleDatas[_loc9_];
         _loc13_ = false;
         _loc14_ = 0;
         if(this._lastWeaponEquipmentType == BMMechStructure.DRONE)
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
            if(dataM.playingVSComputer)
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
            _loc19_ = this._battleTurnData.get_energy(this._opponentPlayerInterfacePlayerID);
            _loc20_ = _loc10_.energy - _loc19_;
            _loc21_ = 0;
            if(param2)
            {
               _loc21_ = Math.abs(_loc10_.currentStepVisual - this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID));
            }
            this.setNewDataForDefender();
            _loc22_ = _loc10_.HP / _loc10_.HPMax;
            if(_loc10_.mechView != null)
            {
               _loc10_.mechView.addDamageDecals(_loc22_);
            }
            _loc23_ = _loc10_.mechView;
            _loc25_ = 0;
            if(_loc20_ > 0 && _loc19_ == 0)
            {
               if(dataM.newVisualEffects)
               {
                  effectsM.addAnimatedEffect("effect_electricity2",this.holder_effects,_loc23_.x,_loc23_.y);
               }
               screensM.screenBattleInterfaceTop.showAnnouncerText(getSpecificText("announcer_energyBreak"),16777215,2,1);
            }
            if(_loc10_.shieldActive)
            {
               _loc40_ = false;
               _loc41_ = "front";
               if(this._takeDamage_effectType == "artillery")
               {
                  _loc41_ = "top";
               }
               else if(_loc23_.scaleX == -1)
               {
                  _loc40_ = true;
               }
               if(this._takeDamage_effectType == "orb" || this._takeDamage_effectType == "artilleryDiagonal")
               {
                  _loc41_ = "back";
               }
               switch(_loc10_.shieldType)
               {
                  case "energy":
                     _loc42_ = "blue";
                     break;
                  case "heat":
                     _loc42_ = "red";
               }
               effectsM.createShield(this.holder_effects,_loc23_.x,-10,_loc42_,_loc41_,_loc40_,dataM.generalSpeedRatio == 2);
            }
            if(_loc17_ > 0)
            {
               _loc43_ = "-" + _loc17_;
               _loc24_ = _loc23_.y + this.FLYING_NUMBER_Y_ADDON / param3;
               effectsM.createFlyingNumber(this.holder_effects,_loc23_.x,_loc24_,_loc43_,"red",0,param3,"up");
               screensM.screenBattleInterfaceTop.blinkResistance(this._opponentPlayerID,this._lastWeaponDamageType);
            }
            _loc26_ = _loc10_.mechView.torso;
            _loc27_ = new Point(_loc26_.x,_loc26_.y);
            _loc28_ = _loc26_.localToGlobal(_loc27_);
            _loc29_ = this.holder_main.globalToLocal(_loc28_);
            _loc30_ = 1;
            _loc31_ = 0;
            if(_loc10_.shieldActive && _loc10_.mechStructure.shield > 0)
            {
               _loc44_ = dataM.getPlayerItemData(this._opponentPlayerID,_loc10_.mechStructure.shield);
               _loc45_ = dataM.itemsDB[_loc44_.itemID];
               _loc31_ = _loc45_.absorbRatio / 100;
               _loc30_ -= _loc31_;
            }
            _loc32_ = Math.ceil(this.SPARKS_PER_FRAME * _loc30_);
            _loc33_ = Math.ceil(10 * _loc31_);
            _loc34_ = Math.ceil(14 * _loc30_);
            if(_loc31_ > 0)
            {
               _loc46_ = _loc29_.x + 150 * _loc23_.scaleX;
               _loc47_ = "right";
               if(_loc23_.scaleX == -1)
               {
                  _loc47_ = "left";
               }
               switch(_loc10_.shieldType)
               {
                  case "energy":
                     _loc48_ = "blue";
                     break;
                  case "heat":
                     _loc48_ = "red";
               }
               effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"spark",_loc46_,_loc29_.y,_loc33_,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,_loc47_,_loc48_,true);
            }
            _loc35_ = "orange";
            _loc37_ = false;
            _loc38_ = 0;
            switch(this._lastWeaponEquipmentType)
            {
               case BMMechStructure.SIDE_WEAPON:
               case BMMechStructure.TOP_WEAPON:
                  _loc11_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_.mechStructure[this._lastWeaponEquipmentType + this._lastWeaponEquipmentID]);
                  _loc12_ = dataM.itemsDB[_loc11_.itemID];
                  _loc36_ = dataM.animationDB[_loc12_.animation];
                  if(_loc12_.isFireJumpWeapon)
                  {
                     _loc7_.mechView.allowFireJumpLanding = true;
                  }
                  if(_loc12_.push < 0)
                  {
                     _loc21_ *= -1;
                  }
                  _loc35_ = _loc36_.effectColor;
                  switch(_loc36_.effectType)
                  {
                     case "grenade":
                     case "rocketMassive":
                        _loc37_ = true;
                        break;
                     case "grenadePull":
                        _loc37_ = true;
                        if(_loc7_.currentStepVisual < _loc10_.currentStepVisual)
                        {
                           _loc38_ = this.GRENADE_PULL_EXPLOSION_X_PUSH;
                        }
                        else
                        {
                           _loc38_ = -this.GRENADE_PULL_EXPLOSION_X_PUSH;
                        }
                  }
                  break;
               case BMMechStructure.DRONE:
                  _loc11_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_.mechStructure[this._lastWeaponEquipmentType]);
                  _loc12_ = dataM.itemsDB[_loc11_.itemID];
                  if(_loc12_.push < 0)
                  {
                     _loc21_ *= -1;
                  }
                  _loc36_ = dataM.animationDB[_loc12_.animation];
                  _loc35_ = _loc36_.effectColor;
                  break;
               case BMMechStructure.TELEPORT:
                  _loc35_ = "blue";
                  break;
               case BMMechStructure.CHARGE:
                  _loc35_ = "orange";
                  break;
               case BMMechStructure.HARPOON:
                  _loc35_ = "orange";
                  break;
               case "stomp":
                  _loc11_ = dataM.getPlayerItemData(this._currentPlayerID,_loc7_.mechStructure.leg);
                  _loc12_ = dataM.itemsDB[_loc11_.itemID];
                  _loc36_ = dataM.animationDB[_loc12_.animation];
                  _loc35_ = _loc36_.effectColor;
            }
            switch(this._lastWeaponEquipmentType)
            {
               case BMMechStructure.SIDE_WEAPON:
               case BMMechStructure.TOP_WEAPON:
               case BMMechStructure.LEG:
               case "stomp":
                  _loc49_ = this.getAttackerPerkSpecialShotData(_loc36_);
                  _loc35_ = _loc49_[3];
            }
            _loc39_ = 0;
            effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"debrie",_loc29_.x,_loc29_.y,_loc34_,1,40,"horizontal","",true);
            if(this._chickenProjectile)
            {
               this._chickenProjectile = false;
               effectsM.createChickenExplosion(this.holder_effects,_loc29_.x + _loc38_,_loc29_.y);
            }
            else if(_loc37_)
            {
               _loc50_ = _loc29_.x + _loc38_;
               effectsM.createMegaExplosion(this.holder_effects,_loc50_,_loc29_.y - 100);
               this.createEarthQuake();
            }
            else if(!dataM.newVisualEffects)
            {
               effectsM.createExplosion(3,_loc29_.x,_loc29_.y,50,30,20,2,7,2,this.holder_effects);
            }
            effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"spark",_loc29_.x,_loc29_.y,_loc32_,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontal",_loc35_,true);
            if(_loc21_ != 0)
            {
               if(this.canPushPlayerID(this._opponentPlayerID))
               {
                  this.pushMech(this._currentPlayerID,this._opponentPlayerID,_loc21_,true,-1,-1,param4);
               }
            }
            this.refreshFloorBuffEffects("takeDamage");
            if(_loc10_.HP <= 0)
            {
               screensM.screenBattleInterfaceTop.deactivateTurnOwnerMessage();
               _loc51_ = false;
               if(dataM.battleMechsPerPlayer > 1)
               {
                  if(this.getPlayerAliveMechSlot(this._opponentPlayerID) != "")
                  {
                     _loc51_ = true;
                  }
               }
               if(_loc51_ == false)
               {
                  if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
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
               if(this._allowFinishMoves && this._currentPlayerID == dataM.player1PlayerID && _loc51_ == false)
               {
                  if(dataM.userAutopilot)
                  {
                     screensM.screenBattleInterfaceBottom.mcAutoplayAndGameSpeedPanel.manuallyClickAutopilotOff();
                     screensM.screenBattleInterfaceBottom.mcAutoplayAndGameSpeedPanel.hideMe();
                  }
                  screensM.screenBattleInterfaceTop.disableTimer();
                  _loc23_.activateDefeated();
                  this._waitingForFinishMove = true;
                  this._attackEnded_performAction = false;
                  screensM.screenBattleInterfaceTop.mcFinishMove.gotoAndPlay("animOn");
                  screensM.screenBattleInterfaceTop.btnQuit.disableMe();
                  this.activateFinishBackgroundDarkness();
                  this.disableInterface("takeDamage - starting finish move");
                  this.hideInterface(false,false,"takeDamage - starting finish move");
               }
               else
               {
                  _loc52_ = null;
                  if(_loc10_.HP == 0)
                  {
                     _loc52_ = getSpecificText("announcer_bullseye");
                  }
                  else if(dataM.battleMechsPerPlayer == 1 && _loc7_.HP == _loc7_.HPMax)
                  {
                     _loc52_ = getSpecificText("announcer_perfect");
                  }
                  else if(_loc10_.HP <= -200)
                  {
                     _loc52_ = getSpecificText("announcer_ultrakill");
                  }
                  else if(_loc10_.HP <= -100)
                  {
                     _loc52_ = getSpecificText("announcer_overkill");
                  }
                  if(_loc52_ != null)
                  {
                     screensM.screenBattleInterfaceTop.showAnnouncerText(_loc52_,16777215);
                  }
                  this.destroyDefendingMech(BMMechBattleData.DESTRUCTION_REGULAR,_loc39_);
               }
            }
         }
      }
      
      private function getPlayerAliveMechSlot(param1:uint) : String
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         _loc2_ = "";
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
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc3_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc4_ = this.getMechSlot(this._opponentPlayerID);
         _loc5_ = this._mechBattleDatas[_loc4_];
         if(this.isOpponentSpecialBoss() && this._opponentPlayerID == dataM.player2PlayerID)
         {
            param1 = dataM.myProfile.clanBossData.destructionType;
         }
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
      
      private function recordDestroyedMechPosition(param1:*) : *
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc2_:BMPlayerData = dataM.playersData[param1];
         _loc3_ = this.getMechSlot(param1);
         _loc4_ = this._mechBattleDatas[_loc3_];
         this._lastDestroyedMechScreenPosition = _loc4_.mechView.centerPosition.localToGlobal(new Point());
      }
      
      private function mechDestroyedAnimationDone(param1:Number) : void
      {
         this.recordDestroyedMechPosition(this._opponentPlayerID);
         this._waitingForMechToBeDestroyed = false;
         this._attackEnded_refreshBars = true;
         this._attackEnded_performAction = true;
         this.attackEndedSub(true,"mechDestroyedAnimationDone");
      }
      
      private function getShieldBlockInfo(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMItemData = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:String = null;
         var _loc17_:Number = NaN;
         var _loc4_:BMPlayerData = dataM.playersData[param1];
         _loc5_ = this.getMechSlot(param1);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc7_ = param2;
         _loc8_ = 0;
         _loc9_ = 0;
         _loc10_ = 0;
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
      
      private function fireJumpStartFiring() : void
      {
         this._fireJumpLandingAcitve = true;
         this.fireSuccess(this._fireJumpEquipmentType,this._fireJumpEquipmentID);
      }
      
      private function fireJumpMechLanded() : void
      {
         this._fireJumpLandingAcitve = false;
         this.createEarthQuake();
         if(this._manualZoomOut)
         {
            this.zoomClicked();
         }
         if(this._triggerSocketAllowedOnFireJumpEnded)
         {
            this.setSocketAllowedStatus(true,"fireJumpMechLanded");
            this._triggerSocketAllowedOnFireJumpEnded = false;
         }
         this.attackEndedSub(true,"fireJumpMechLanded");
      }
      
      private function activateFireJump(param1:BMMechView, param2:String, param3:uint, param4:BMItemData) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this._fireJumpEquipmentType = param2;
         this._fireJumpEquipmentID = param3;
         _loc5_ = this.pushMech(this._opponentPlayerID,this._currentPlayerID,param4.pushSelf,true,0,0,true,false);
         _loc6_ = this.FLOOR_STEP_SIZE * _loc5_;
         param1.activateFireJump(_loc6_,this.fireJumpStartFiring,this.fireJumpMechLanded);
         this.activateManualZoomOut();
      }
      
      public function isAttackingMechWeaponInRetreatBlock(param1:uint, param2:uint, param3:BMItemData, param4:int = -1) : Boolean
      {
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:String = null;
         var _loc8_:BMMechBattleData = null;
         var _loc9_:uint = 0;
         if(param3.isFireJumpWeapon == false)
         {
            return false;
         }
         _loc5_ = this.getMechSlot(param1);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc7_ = this.getMechSlot(param2);
         _loc8_ = this._mechBattleDatas[_loc7_];
         _loc9_ = _loc6_.currentStepCode;
         if(param4 > -1)
         {
            _loc9_ = uint(param4);
         }
         if(_loc9_ < _loc8_.currentStepCode)
         {
            if(_loc9_ - param3.pushSelf < 0)
            {
               return true;
            }
         }
         else if(param3.pushSelf > dataM.battleData.map.stepsTotal - _loc9_ - 1)
         {
            return true;
         }
         return false;
      }
      
      private function get isFireJumpInProgress() : Boolean
      {
         return this._fireJumpAcitve || this._fireJumpLandingAcitve;
      }
      
      private function pushMech(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Number, param6:Number, param7:Boolean, param8:Boolean = true) : Number
      {
         var _loc10_:String = null;
         var _loc11_:BMMechBattleData = null;
         var _loc13_:String = null;
         var _loc14_:BMMechBattleData = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Boolean = false;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc9_:BMPlayerData = dataM.playersData[param1];
         _loc10_ = this.getMechSlot(param1);
         _loc11_ = this._mechBattleDatas[_loc10_];
         var _loc12_:BMPlayerData = dataM.playersData[param2];
         _loc13_ = this.getMechSlot(param2);
         _loc14_ = this._mechBattleDatas[_loc13_];
         _loc16_ = _loc14_.currentStepVisual;
         _loc17_ = _loc11_.currentStepVisual;
         if(param4 == false)
         {
            _loc16_ = param5;
            _loc17_ = param6;
         }
         if(_loc16_ < _loc17_)
         {
            _loc18_ = -1;
         }
         else if(_loc16_ > _loc17_)
         {
            _loc18_ = 1;
         }
         else if(_loc17_ == 0)
         {
            _loc18_ = 1;
         }
         else
         {
            _loc18_ = -1;
         }
         if(param3 < 0)
         {
            _loc18_ *= -1;
         }
         _loc19_ = 0;
         _loc20_ = false;
         if(param3 > 0)
         {
            _loc21_ = _loc16_ + _loc18_ * Math.abs(param3);
            _loc22_ = this.getAvailableStep(param2,_loc16_,_loc21_,"walk");
            if(_loc22_ > -1)
            {
               _loc19_ = Math.abs(_loc22_ - _loc16_);
            }
         }
         else
         {
            _loc20_ = true;
            _loc23_ = Math.abs(_loc17_ - _loc16_) - 1;
            _loc19_ = Math.abs(param3);
            if(_loc19_ > _loc23_)
            {
               _loc19_ = _loc23_;
            }
         }
         if(_loc19_ > 0)
         {
            _loc24_ = _loc19_ * this.FLOOR_STEP_SIZE;
            if(param8)
            {
               _loc14_.pushMe(_loc24_,_loc20_,this.pushAnimEnded,param7);
            }
            if(param4)
            {
               _loc14_.currentStepVisual += _loc19_ * _loc18_;
            }
            if(param7)
            {
               this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES_PUSH;
               this.refreshMechCodeStepMarker(1);
               this.refreshMechCodeStepMarker(2);
            }
            if(param8)
            {
               _loc14_.mechView.activateGetPushedAnimation(_loc20_);
            }
         }
         return _loc19_ * _loc18_;
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
      
      public function activateManualZoomOut() : void
      {
         if(this._zoomOut == false)
         {
            this.zoomClicked();
            this._manualZoomOut = true;
         }
      }
      
      public function teleportLocationClicked(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = dataM.getClientInvertedStep(param1);
         this.disableInterface("teleportLocationClicked");
         if(dataM.playingVSComputer)
         {
            this._skipNextSocketCallsHandlerEnbaleInterface = true;
         }
         if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_teleport(_loc2_);
         }
         else
         {
            this.teleportLocally(_loc2_);
         }
      }
      
      public function teleportLocally(param1:Number) : void
      {
         this.addSinglePlayerAction("teleport",param1,"");
      }
      
      private function teleportLocallySub(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         var _loc7_:Boolean = false;
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         _loc5_ = dataM.getPlayerItemData(this._currentPlayerID,_loc4_.mechStructure.teleport);
         _loc6_ = dataM.itemsDB[_loc5_.itemID];
         _loc7_ = this.isOpponentInWeaponRange(this._currentPlayerID,this._opponentPlayerID,_loc6_.itemID,-1,-1,param1);
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
         this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_TELEPORT));
         screensM.screenBattle.activateNextBattlePhase("action_teleportSuccess",{"targetStep":param1});
      }
      
      public function teleportSuccess(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:BMMechView = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         this.setSocketAllowedStatus(false,"teleportSuccess");
         this._lastAction = "teleport";
         _loc2_ = dataM.getClientInvertedStep(param1);
         var _loc3_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc4_ = this.getMechSlot(this._currentPlayerID);
         _loc5_ = this._mechBattleDatas[_loc4_];
         _loc6_ = _loc5_.mechView;
         _loc7_ = _loc6_.mechSizer.width * 1.8;
         _loc8_ = 1;
         if(dataM.newVisualEffects)
         {
            _loc8_ = 3;
         }
         if(_loc7_ > 400)
         {
            _loc7_ = 400;
         }
         _loc9_ = _loc6_.x;
         _loc10_ = _loc6_.y + 30;
         this._teleportAfterEffectXPos = _loc9_;
         this._teleportAfterEffectYPos = _loc10_;
         this.setNewDataForAttacker();
         this.setNewUsesForAttacker("teleport",0);
         var _loc11_:String = "";
         if(dataM.generalSpeedRatio == 2)
         {
            _loc11_ = "_fast";
         }
         effectsM.createTeleportDisappear("teleportDisappearAnim",_loc9_,_loc10_,_loc7_,_loc8_,this.teleportSuccessSub,[_loc2_],this.holder_effects);
         soundM.createSound("teleportDisappear",1);
      }
      
      private function teleportSuccessSub(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMMechView = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMItemData = null;
         var _loc13_:Number = NaN;
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         _loc5_ = _loc4_.mechView;
         _loc6_ = _loc5_.mechSizer.width * 1.8;
         _loc7_ = 1;
         if(dataM.newVisualEffects)
         {
            _loc7_ = 3;
         }
         if(_loc6_ > 400)
         {
            _loc6_ = 400;
         }
         _loc4_.currentStepVisual = param1;
         _loc4_.currentStepCode = _loc4_.currentStepVisual;
         this.setMechXPosition(_loc4_);
         this.refreshFloorBuffEffects("teleportSuccessSub");
         _loc8_ = _loc5_.x;
         _loc9_ = _loc5_.y + 30;
         var _loc10_:String = "";
         if(dataM.generalSpeedRatio == 2)
         {
            _loc10_ = "_fast";
         }
         effectsM.createTeleportReappear("teleportReappearAnim",_loc8_,_loc9_,_loc6_,_loc7_,this.holder_effects);
         this.refreshMechsView();
         _loc11_ = dataM.getPlayerItemData(this._currentPlayerID,_loc4_.mechStructure.teleport);
         _loc12_ = dataM.itemsDB[_loc11_.itemID];
         if(_loc12_.damageBase > 0 || _loc12_.damageAddon > 0)
         {
            effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"spark",_loc5_.x,_loc5_.y,this.SPARKS_PER_FRAME,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontalWider","blue",true);
         }
         this._teleportDamageHandler = true;
         if(this._manualZoomOut)
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
            _loc13_ = Math.random() * 360;
            effectsM.createTeleportAfterEffect("teleportAfterEffect",this._teleportAfterEffectXPos,this._teleportAfterEffectYPos,dataM.generalSpeedRatio == 2,this.holder_effects);
         }
         soundM.createSound("teleportAppear",1);
      }
      
      public function teleportCanceled() : void
      {
         if(this._manualZoomOut)
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
         if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_charge();
         }
         else
         {
            this.chargeLocally();
         }
      }
      
      public function chargeLocally() : void
      {
         this.addSinglePlayerAction("charge",0,"");
      }
      
      private function chargeLocallySub() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         this.fireLocallyCalculations("charge",0,true);
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
         if(_loc3_.currentStepVisual > _loc6_.currentStepVisual)
         {
            this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,_loc6_.currentStepVisual + this.CHARGE_SELF_PUSH);
         }
         else
         {
            this._battleTurnData.set_step(this._currentPlayerInterfacePlayerID,_loc6_.currentStepVisual - this.CHARGE_SELF_PUSH);
         }
         _loc3_.currentStepCode = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_CHARGE));
         this.activateNextBattlePhase("action_chargeSuccess");
      }
      
      public function chargeSuccess() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:Number = NaN;
         this.setSocketAllowedStatus(false,"chargeSuccess");
         this._lastAction = "charge";
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc7_ = _loc6_.mechView.x;
         _loc3_.charge(_loc7_,this.chargeChargingAnimationEnded);
         this.setNewDataForAttacker();
         this.setNewUsesForAttacker("charge",0);
         soundM.createSound("charge",1);
      }
      
      private function chargeChargingAnimationEnded() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc7_ = _loc3_.mechView.torso;
         _loc8_ = new Point(_loc7_.x,_loc7_.y);
         _loc9_ = _loc7_.localToGlobal(_loc8_);
         _loc10_ = this.holder_main.globalToLocal(_loc9_);
         effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"debrie",_loc3_.mechView.x,_loc10_.y,14,1,40,"horizontal","",true);
         effectsM.createExplosion(3,_loc3_.mechView.x,_loc10_.y,50,30,20,2,7,2,this.holder_effects);
         effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"spark",_loc3_.mechView.x,_loc10_.y,this.SPARKS_PER_FRAME,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontal","orange",true);
         this._lastWeaponEquipmentType = "charge";
         this.takeDamage("chargeChargingAnimationEnded",true,this._viewScaleFinal,false);
         this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
         this.createEarthQuake();
         _loc3_.currentStepVisual = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         _loc3_.currentStepCode = _loc3_.currentStepVisual;
         this.refreshFloorBuffEffects("chargeChargingAnimationEnded");
         _loc11_ = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         _loc12_ = this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID);
         _loc13_ = _loc11_;
         _loc14_ = _loc12_;
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
         var _loc2_:Boolean = false;
         _loc2_ = true;
         if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
         {
            if(dataM.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_TURRET)
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
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         this.fireLocallyCalculations(BMMechStructure.LEG,0,true);
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
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
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:Number = NaN;
         this.setSocketAllowedStatus(false,"crashSuccess");
         this._lastAction = "crash";
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc7_ = _loc6_.mechView.x;
         _loc3_.crash(_loc7_,this.crashCrashingAnimationEnded);
         this.setNewDataForAttacker();
         this.setNewUsesForAttacker(BMMechStructure.LEG,0);
      }
      
      private function crashCrashingAnimationEnded() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc7_ = _loc3_.mechView.torso;
         _loc8_ = new Point(_loc7_.x,_loc7_.y);
         _loc9_ = _loc7_.localToGlobal(_loc8_);
         _loc10_ = this.holder_main.globalToLocal(_loc9_);
         effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"debrie",_loc3_.mechView.x,_loc10_.y,14,1,40,"horizontal","",true);
         effectsM.createExplosion(3,_loc3_.mechView.x,_loc10_.y,50,30,20,2,7,2,this.holder_effects);
         effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"spark",_loc3_.mechView.x,_loc10_.y,this.SPARKS_PER_FRAME,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontal","orange",true);
         this._lastWeaponEquipmentType = "crash";
         this.takeDamage("crashCrashingAnimationEnded",true,this._viewScaleFinal,false);
         this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
         this.createEarthQuake();
         _loc3_.currentStepVisual = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         _loc3_.currentStepCode = _loc3_.currentStepVisual;
         this.refreshFloorBuffEffects("crashCrashingAnimationEnded");
         _loc11_ = this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID);
         _loc12_ = this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID);
         _loc13_ = _loc11_;
         _loc14_ = _loc12_;
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
         if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_harpoon();
         }
         else
         {
            this.harpoonLocally();
         }
      }
      
      public function harpoonLocally() : void
      {
         this.addSinglePlayerAction("harpoon",0,"");
      }
      
      private function harpoonLocallySub() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:Number = NaN;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
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
         this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_HARPOON));
         this.activateNextBattlePhase("action_harpoonSuccess");
      }
      
      public function harpoonSuccess() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         this.setSocketAllowedStatus(false,"harpoonSuccess");
         this._lastAction = "harpoon";
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         var _loc4_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc5_ = this.getMechSlot(this._opponentPlayerID);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc7_ = Math.abs(_loc3_.currentStepVisual - _loc6_.currentStepVisual);
         _loc8_ = (_loc7_ - 0.7) * this.FLOOR_STEP_SIZE;
         _loc9_ = (_loc7_ - 1.7) * this.FLOOR_STEP_SIZE;
         _loc10_ = "left";
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
         var _loc2_:String = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc2_ = this.getMechSlot(this._opponentPlayerID);
         var _loc3_:BMMechBattleData = this._mechBattleDatas[_loc2_];
         this._lastWeaponEquipmentType = "harpoon";
         this.takeDamage("harpoonAnimationEnded",false,this._viewScaleFinal,false);
         this.activateGetHit(this._opponentPlayerID,"xAxisFront",false,true);
         this.createEarthQuake();
      }
      
      private function harpoonAnimationEnded() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc2_ = this.getMechSlot(this._opponentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc3_.currentStepVisual = this._battleTurnData.get_step(this._opponentPlayerInterfacePlayerID);
         _loc3_.currentStepCode = _loc3_.currentStepVisual;
         this.refreshFloorBuffEffects("harpoonAnimationEnded");
         this.setMechXPosition(_loc3_);
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
            this.fireWeapon(BMMechStructure.LEG,0);
         }
      }
      
      public function stompRegularAnimDone() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         var _loc6_:String = null;
         var _loc7_:BMMechBattleData = null;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItemData = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.mechView;
         var _loc5_:BMPlayerData = dataM.playersData[this._opponentPlayerID];
         _loc6_ = this.getMechSlot(this._opponentPlayerID);
         _loc7_ = this._mechBattleDatas[_loc6_];
         _loc8_ = dataM.getPlayerItemData(this._currentPlayerID,_loc3_.mechStructure.leg);
         _loc9_ = dataM.itemsDB[_loc8_.itemID];
         _loc10_ = dataM.animationDB[_loc9_.animation].fireEffect;
         _loc11_ = "stompLegHit" + _loc10_.substr(_loc10_.length - 1,1);
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
         var _loc7_:String = null;
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
         _loc7_ = this.getMechSlot(param1);
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
            if(BattleTypeResolver.isBattleOnServer)
            {
               remoteM.battle_moveMechToStep(param1,_loc9_);
            }
            else
            {
               this.moveMechToStepLocally(param1,_loc9_);
            }
         }
      }
      
      public function moveMechToStep(param1:String, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = dataM.getClientInvertedStep(param2);
         if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_moveMechToStep(param1,_loc3_);
         }
         else
         {
            this.moveMechToStepLocally(param1,_loc3_);
         }
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
         this.addBattleReportData(0,0);
         this.addBattleReportReplayAction(BMReplayAction.createMoveAction(param1));
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
                     if(dataM.isWheels(_loc8_))
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
                     if(dataM.isWheels(_loc8_))
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
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:BMMechView = null;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         if(this._mechWalkingHandler == false)
         {
            return;
         }
         ++this._movingFramesCounter;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
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
            return;
         }
         this.setMechXPosition(_loc3_);
         this._mechWalkingHandler = false;
         this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
         this.refreshMechCodeStepMarker(1);
         this.refreshMechCodeStepMarker(2);
         this.walkJumpAnimDone();
         _loc5_ = dataM.getPlayerItemData(this._currentPlayerID,_loc3_.mechStructure.leg);
         _loc6_ = dataM.itemsDB[_loc5_.itemID];
         if(dataM.isWheels(_loc6_))
         {
            _loc4_.deactivateWheelsAnimation();
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
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this._mechJumpingHandler == false)
         {
            return;
         }
         ++this._movingFramesCounter;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
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
            return;
         }
         if(this._movingFramesCounter == this._movingFramesMax + 1)
         {
            _loc3_.mechView.activateBumpAnimation(true);
            this.setMechXPosition(_loc3_);
            _loc3_.mechView.resetYPos();
            _loc5_ = _loc3_.mechView.x;
            _loc6_ = _loc3_.mechView.y;
            effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"spark",_loc5_,-10,this.SPARKS_PER_FRAME,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontal","brown",true);
            soundM.createSound("footStep",1);
            this.createEarthQuake();
            this._refreshBattleView_low_frames += this.BATTLE_VIEW_LOW_QUALITY_FRAMES;
            this.refreshMechCodeStepMarker(1);
            this.refreshMechCodeStepMarker(2);
         }
         if(this._movingFramesCounter == this._movingFramesMax + 10)
         {
            this._mechJumpingHandler = false;
            this.walkJumpAnimDone();
         }
      }
      
      private function walkJumpAnimDone() : void
      {
         if(this._waitingForFinishMove)
         {
            this.activateFinishMove(this._finishMoveID);
            return;
         }
         this.setNewDataForAttacker();
         this.refreshMechsView();
         if(this._activatePlayer2DelayedEntry)
         {
            this.createPlayer2Entry();
         }
         else
         {
            this._interfaceEnabled = true;
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
         if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_shutDown();
         }
         else
         {
            this.shutDownLocally();
         }
      }
      
      public function shutDownLocally(param1:Number = 1) : void
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
         this.addBattleReportData(0,0);
         this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_SHUTDOWN));
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
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         this.setSocketAllowedStatus(false,"shutDownSuccess");
         this._lastAction = "shutDown";
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.mechView;
         _loc5_ = _loc3_.mechView.x;
         _loc6_ = _loc3_.mechView.y + 35;
         var _loc7_:String = "";
         if(dataM.generalSpeedRatio == 2)
         {
            _loc7_ = "_fast";
         }
         effectsM.createShutDown("shutDownAnim",_loc5_,_loc6_,dataM.generalSpeedRatio == 2,this.shutDownAnimationEnded,this.holder_effects);
         if(_loc3_.mechView.shutDownActive == false)
         {
            _loc3_.mechView.activateShutdown();
         }
         _loc8_ = _loc3_.heat - this._battleTurnData.get_heat(this._currentPlayerInterfacePlayerID);
         if(_loc3_.heat > _loc3_.heatMax)
         {
            _loc10_ = _loc8_ > _loc3_.heatCooling;
            if(this._currentPlayerID != dataM.player1PlayerID)
            {
               this._singleOverheats += 1;
               if(_loc10_)
               {
                  this._doubleOverheats += 1;
               }
            }
            _loc11_ = _loc10_ ? getSpecificText("announcer_shutdown") : getSpecificText("announcer_overheat");
            _loc12_ = _loc10_ ? 3 : 2;
            _loc13_ = _loc10_ ? 1 : 0.8;
            screensM.screenBattleInterfaceTop.showAnnouncerText(_loc11_,16777215,_loc12_,_loc13_);
         }
         _loc9_ = _loc4_.y + this.FLYING_NUMBER_Y_ADDON / this._viewScaleFinal;
         if(_loc8_ > 0)
         {
            effectsM.createFlyingNumber(this.holder_effects,_loc4_.x,_loc9_,"-" + _loc8_,"orange",0,this._viewScale,"up");
         }
         this.setNewDataForAttacker();
         soundM.createSound("shutDown",1);
      }
      
      public function forceShutDownSuccess(param1:Object) : void
      {
         this.activateNextBattlePhase("action_shutDownSuccess",param1);
      }
      
      private function shutDownAnimationEnded() : void
      {
         if(this._forceShutDown)
         {
            this._forceShutDown = false;
            if(BattleTypeResolver.isBattleOnServer)
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
         if(BattleTypeResolver.isBattleOnServer)
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
         var _loc5_:BMFloorBuff = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc4_ = _loc3_.energyRegeneration;
         if(_loc3_.energy + _loc4_ > _loc3_.energyMax)
         {
            _loc4_ = _loc3_.energyMax - _loc3_.energy;
         }
         this._battleTurnData.set_energy(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_energy(this._currentPlayerInterfacePlayerID) + _loc4_);
         if(BattleTypeResolver.isReplay)
         {
            _loc5_ = this._floorBuffs[this._battleTurnData.get_step(this._currentPlayerInterfacePlayerID)];
            if(_loc5_ != null)
            {
               if(_loc5_.type == "regenHP")
               {
                  _loc6_ = dataM.floorBuff_regenHP;
                  _loc7_ = Math.min(_loc3_.HPMax,this._battleTurnData.get_HP(this._currentPlayerInterfacePlayerID) + _loc6_);
                  this._battleTurnData.set_HP(this._currentPlayerInterfacePlayerID,_loc7_);
               }
            }
            this.energyRegenerationSuccessSub();
         }
         else
         {
            this.activateNextBattlePhase("action_energyRegenerationSuccess");
         }
      }
      
      public function energyRegenerationSuccess() : void
      {
         this.setSocketAllowedStatus(true,"energyRegenerationSuccess");
         this.energyRegenerationSuccessSub();
         this.activateNextBattlePhase("turn_endTurnSuccess",{
            "delayEndTurn":false,
            "swapPlayersOnly":false
         });
      }
      
      private function energyRegenerationSuccessSub() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         _loc3_.energy = this._battleTurnData.get_energy(this._currentPlayerInterfacePlayerID);
         _loc3_.HP = this._battleTurnData.get_HP(this._currentPlayerInterfacePlayerID);
         this.setNewDataForAttacker();
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
            if(BattleTypeResolver.isBattleOnServer)
            {
               remoteM.battle_shieldDeactivate();
            }
            else
            {
               this.deactivateShieldLocally();
            }
         }
         else if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_shieldActivate();
         }
         else
         {
            this.activateShieldLocally();
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
         this.addBattleReportData(0,0);
         this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_DEACTIVATE_SHIELD));
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
         this.addBattleReportData(0,0);
         this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_ACTIVATE_SHIELD));
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
            if(BattleTypeResolver.isBattleOnServer)
            {
               remoteM.battle_droneDeactivate();
            }
            else
            {
               this.deactivateDroneLocally();
            }
         }
         else if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_droneActivate();
         }
         else
         {
            this.activateDroneLocally();
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
         this.addBattleReportData(0,0);
         this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_DEACTIVATE_DRONE));
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
         this.addBattleReportData(0,0);
         this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_ACTIVATE_DRONE));
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
            _loc3_.resetDrone();
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
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:int = 0;
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         if(_loc4_.droneActive == false)
         {
            return false;
         }
         if(_loc4_.droneFired)
         {
            return false;
         }
         _loc5_ = dataM.getPlayerItemData(this._currentPlayerID,_loc4_.mechStructure.drone);
         _loc6_ = dataM.itemsDB[_loc5_.itemID];
         if(this.isOpponentInWeaponRange(this._currentPlayerID,this._opponentPlayerID,_loc5_.itemID,_loc6_.rangeBase,_loc6_.rangeAddon,_loc4_.currentStepCode) == false)
         {
            return false;
         }
         _loc7_ = false;
         _loc8_ = true;
         _loc9_ = false;
         _loc10_ = false;
         _loc11_ = false;
         _loc12_ = false;
         if(_loc6_.HPAddon > 0)
         {
            if(_loc4_.HP == _loc4_.HPMax)
            {
               _loc7_ = true;
            }
         }
         else if(_loc6_.HPAddon < 0)
         {
            _loc13_ = BMMechStatsResolver.getHPCost(_loc6_.HPAddon,this._currentPlayerID);
            if(_loc4_.HP <= Math.abs(_loc13_))
            {
               _loc8_ = false;
            }
         }
         if(_loc4_.energy >= _loc6_.costEnergy)
         {
            _loc9_ = true;
         }
         _loc10_ = true;
         if(_loc4_.bullets >= _loc6_.bullets)
         {
            _loc11_ = true;
         }
         if(_loc4_.rockets >= _loc6_.rockets)
         {
            _loc12_ = true;
         }
         if(_loc7_ == false && _loc8_ && _loc9_ && _loc10_ && _loc11_ && _loc12_)
         {
            return true;
         }
         return false;
      }
      
      public function useKit(param1:Number) : void
      {
         this.disableInterface("useKit");
         if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_useKit(param1);
         }
         else
         {
            this.useKitLocally(param1);
         }
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
         this.addBattleReportData(0,0);
         this.addBattleReportReplayAction(BMReplayAction.createSimpleAction(BMReplayAction.ACTION_NAME_USE_KIT));
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
         if(this._currentPlayerID == dataM.ONLINE_PLAYER_ID && dataM.playingVSComputer)
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
      
      private function refreshFloorBuffEffects(param1:String = "") : void
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
         if(this._battlePhase == null)
         {
            return;
         }
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
      
      public function clientSideTimerEnded() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:int = 0;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && dataM.gameSubType == BMDataManager.GAME_SUB_TYPE_PVP_BOT)
         {
            if(this._currentPlayerID == dataM.player1PlayerID)
            {
               _loc1_ = dataM.playersData[this._currentPlayerID];
               _loc2_ = _loc1_.AP;
               this.shutDownLocally(_loc2_);
            }
         }
      }
      
      public function enableInterface(param1:String) : void
      {
         if(this._timerNotice)
         {
            return;
         }
         screensM.screenBattleInterfaceBottom.enableInterface("battle enableInterface");
         screensM.screenBattleInterfaceBottom.showInterface("battle enableInterface");
      }
      
      private function disableInterface(param1:String) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerData = null;
         _loc2_ = false;
         _loc3_ = false;
         _loc4_ = dataM.playersData[this._currentPlayerID];
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
                  case "hiddenBaseMissionCompleted":
                     _loc2_ = true;
                     _loc3_ = true;
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
                     if(_loc4_.AP >= 1)
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
         {
            screensM.screenBattleInterfaceBottom.disableInterface();
         }
         if(_loc2_)
         {
            this.hideInterface(false,_loc3_,"disableInterface");
         }
      }
      
      private function showInterface(param1:String) : void
      {
         if(this._timerNotice == false)
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
            {
               screensM.screenBattleInterfaceBottom.showInterface("battle showInterface");
            }
         }
      }
      
      private function hideInterface(param1:Boolean = false, param2:Boolean = false, param3:String = "") : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
         {
            screensM.screenBattleInterfaceBottom.hideInterface(param1,param2);
         }
      }
      
      public function getWeaponsInRangeUnfired(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean = false) : Array
      {
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         _loc5_ = new Array();
         _loc6_ = 1;
         while(_loc6_ <= dataM.maxEquipment[BMMechStructure.SIDE_WEAPON])
         {
            _loc5_ = this.getWeaponsInRangeUnfiredSub(_loc5_,BMMechStructure.SIDE_WEAPON,_loc6_,true,param1,param2,param3,param4);
            _loc6_++;
         }
         _loc6_ = 1;
         while(_loc6_ <= dataM.maxEquipment[BMMechStructure.TOP_WEAPON])
         {
            _loc5_ = this.getWeaponsInRangeUnfiredSub(_loc5_,BMMechStructure.TOP_WEAPON,_loc6_,true,param1,param2,param3,param4);
            _loc6_++;
         }
         return _loc5_;
      }
      
      private function getWeaponsInRangeUnfiredSub(param1:Array, param2:String, param3:Number, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean = false) : Array
      {
         var _loc10_:String = null;
         var _loc11_:BMMechBattleData = null;
         var _loc12_:String = null;
         var _loc13_:Number = NaN;
         var _loc14_:BMPlayerItemData = null;
         var _loc15_:BMItemData = null;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc22_:int = 0;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:int = 0;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc9_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc10_ = this.getMechSlot(this._currentPlayerID);
         _loc11_ = this._mechBattleDatas[_loc10_];
         _loc12_ = param2 + param3;
         _loc13_ = Number(_loc11_.mechStructure[_loc12_]);
         if(_loc13_ > 0)
         {
            if(_loc11_.weaponAlreadyFired[_loc12_] == false)
            {
               _loc14_ = dataM.getPlayerItemData(this._currentPlayerID,_loc13_);
               _loc15_ = dataM.itemsDB[_loc14_.itemID];
               _loc16_ = false;
               _loc17_ = false;
               _loc18_ = false;
               _loc19_ = false;
               if(param4)
               {
                  if(this.isOpponentInWeaponRange(this._currentPlayerID,this._opponentPlayerID,_loc14_.itemID,-1,-1,-1))
                  {
                     _loc16_ = true;
                  }
               }
               else
               {
                  _loc16_ = true;
               }
               if(param5)
               {
                  _loc21_ = true;
                  if(_loc15_.HPAddon < 0)
                  {
                     _loc22_ = BMMechStatsResolver.getHPCost(_loc15_.HPAddon,this._currentPlayerID);
                     if(_loc11_.HP <= Math.abs(_loc22_))
                     {
                        _loc21_ = false;
                     }
                  }
                  if(_loc21_ && _loc11_.energy >= _loc15_.costEnergy && _loc11_.bullets >= _loc15_.bullets && _loc11_.rockets >= _loc15_.rockets && (_loc11_.usesMax[_loc12_] == 0 || _loc11_.uses[_loc12_] < _loc11_.usesMax[_loc12_]))
                  {
                     _loc17_ = true;
                  }
               }
               else
               {
                  _loc17_ = true;
               }
               if(param6)
               {
                  if(_loc11_.heat + _loc15_.costHeat <= _loc11_.heatMax)
                  {
                     _loc18_ = true;
                  }
               }
               else
               {
                  _loc18_ = true;
               }
               if(param7)
               {
                  _loc23_ = Number(_loc11_.usesMax[_loc12_]);
                  _loc24_ = Number(_loc11_.uses[_loc12_]);
                  if(_loc23_ == 0 || _loc23_ > 0 && _loc24_ < _loc23_)
                  {
                     _loc19_ = true;
                  }
               }
               else
               {
                  _loc19_ = true;
               }
               _loc20_ = true;
               if(param8)
               {
                  if(dataM.computerActions != null)
                  {
                     _loc25_ = this.getBattleReportNumberOfShotsFiredByComputer();
                     _loc26_ = dataM.computerActions[_loc25_];
                     _loc27_ = BMReplayAction.createFireWeaponAction(param2,param3).getReplayString([]);
                     if(_loc27_.indexOf(_loc26_) == -1)
                     {
                        _loc20_ = false;
                     }
                  }
               }
               if(_loc16_ && _loc17_ && _loc18_ && _loc19_ && _loc20_)
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
      
      public function getWeaponsUnfired(param1:Number, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false) : Array
      {
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         _loc7_ = new Array();
         _loc8_ = 1;
         while(_loc8_ <= dataM.maxEquipment[BMMechStructure.SIDE_WEAPON])
         {
            _loc7_ = this.getWeaponsInRangeUnfiredSub(_loc7_,BMMechStructure.SIDE_WEAPON,_loc8_,param2,param3,param4,param5,param6);
            _loc8_++;
         }
         _loc8_ = 1;
         while(_loc8_ <= dataM.maxEquipment[BMMechStructure.TOP_WEAPON])
         {
            _loc7_ = this.getWeaponsInRangeUnfiredSub(_loc7_,BMMechStructure.TOP_WEAPON,_loc8_,param2,param3,param4,param5,param6);
            _loc8_++;
         }
         return _loc7_;
      }
      
      public function getBestWeaponsToFire(param1:Number, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean = false) : Array
      {
         var _loc9_:String = null;
         var _loc10_:BMMechBattleData = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:uint = 0;
         var _loc15_:Object = null;
         var _loc16_:Number = NaN;
         var _loc17_:BMPlayerItemData = null;
         var _loc18_:BMItemData = null;
         var _loc19_:Number = NaN;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc23_:Number = NaN;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc26_:Object = null;
         var _loc27_:Object = null;
         var _loc28_:Object = null;
         var _loc8_:BMPlayerData = dataM.playersData[param1];
         _loc9_ = this.getMechSlot(param1);
         _loc10_ = this._mechBattleDatas[_loc9_];
         _loc11_ = new Array();
         _loc12_ = new Array();
         _loc13_ = this.getWeaponsUnfired(param1,param3,param4,param5,param6,param7);
         if(_loc13_.length > 0)
         {
            _loc14_ = 0;
            while(_loc14_ < _loc13_.length)
            {
               _loc15_ = _loc13_[_loc14_];
               _loc16_ = Number(_loc10_.mechStructure[_loc15_.type + _loc15_.equipmentID]);
               _loc17_ = dataM.getPlayerItemData(param1,_loc16_);
               _loc18_ = dataM.itemsDB[_loc17_.itemID];
               _loc19_ = this.getWeaponAverageDamage(param2,_loc17_.itemID);
               _loc20_ = BMMechStatsResolver.getHeatDamage(_loc18_.damageHeat,param1);
               _loc21_ = BMMechStatsResolver.getEnergyDamage(_loc18_.damageEnergy,param1);
               _loc22_ = _loc18_.resist1 + _loc18_.resist2 + _loc18_.resist3;
               _loc23_ = _loc19_ + 2 * (_loc20_ + _loc21_) + 10 * _loc22_;
               _loc12_[_loc14_] = _loc23_;
               _loc13_[_loc14_].damage = _loc23_;
               _loc14_++;
            }
            if(_loc12_.length > 0)
            {
               _loc12_.sort(Array.NUMERIC | Array.DESCENDING);
               _loc24_ = 0;
               while(_loc24_ < _loc12_.length)
               {
                  _loc25_ = 0;
                  while(_loc25_ < _loc13_.length)
                  {
                     _loc26_ = _loc13_[_loc25_];
                     _loc27_ = _loc12_[_loc24_];
                     if(_loc26_.damage == _loc27_)
                     {
                        _loc28_ = new Object();
                        _loc28_.type = _loc26_.type;
                        _loc28_.equipmentID = _loc26_.equipmentID;
                        _loc28_.damage = _loc26_.damage;
                        _loc11_.push(_loc28_);
                        _loc25_ = _loc12_.length;
                     }
                     _loc25_++;
                  }
                  _loc24_++;
               }
            }
         }
         return _loc11_;
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
            if(this.isAttackingMechWeaponInRetreatBlock(param1,param2,_loc24_,param6))
            {
               return false;
            }
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
         var _loc6_:BMPlayerProfile = null;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         _loc1_ = false;
         _loc2_ = false;
         _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this._battleResult == BMDataManager.BATTLE_RESULT_WIN)
         {
            _loc1_ = true;
            _loc3_.wonLastBattleVSComputer = true;
         }
         else if(this._battleResult == BMDataManager.BATTLE_RESULT_OPPONENT_QUIT)
         {
            _loc2_ = true;
         }
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         _loc6_ = dataM["player" + dataM.player2PlayerID + "Profile"];
         if(_loc1_ == false)
         {
            this._droneOnlyWin = false;
            this._meleeOnlyWin = false;
         }
         _loc7_ = uint(_loc6_.level);
         _loc8_ = dataM.singlePlayerM.getCurrentMissionPosition();
         remoteM.lobby_finishBattleVSComputer(_loc1_,_loc2_,dataM.battleType,dataM.battleSubType,dataM.campaignBattleDifficulty,dataM.computerBattleID,this._battleReport,_loc7_,_loc8_,this._droneOnlyWin,this._meleeOnlyWin,this._opponentResistance1,this._opponentResistance2,this._opponentResistance3,this._maxSingleShotDamage,this._singleOverheats,this._doubleOverheats);
      }
      
      public function finishBattleVSComputerLocally() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc2_ = 0;
         _loc3_ = 0;
         if(this._battleResult == BMDataManager.BATTLE_RESULT_LOSS)
         {
            _loc2_ = dataM.rewardSPLoseGold;
            _loc3_ = dataM.rewardSPLoseXP;
         }
         else
         {
            _loc2_ = dataM.rewardSPWinGold;
            _loc3_ = dataM.rewardSPWinXP;
         }
         if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
         {
            switch(dataM.battleSubType)
            {
               case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
                  _loc2_ *= 0.25;
                  _loc3_ *= 0.25;
                  break;
               case BMSinglePlayerManager.ENEMY_TYPE_TANK:
                  _loc2_ *= 0.5;
                  _loc3_ *= 0.5;
            }
         }
         _loc4_ = 1;
         if(_loc1_.missionID > 0)
         {
            _loc8_ = dataM.singlePlayerM.getMissionsDB(dataM.myProfile.currentStoryID).length;
            _loc4_ = 1 + 9 * (_loc1_.currentMissionSlot / (_loc8_ - 1));
         }
         _loc2_ *= _loc4_;
         _loc3_ *= _loc4_;
         _loc2_ = Math.ceil(_loc2_ / 50) * 50;
         _loc3_ = Math.ceil(_loc3_ / 5) * 5;
         var _loc5_:BMLevelUpData = null;
         if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
         {
            switch(_loc1_.currentMissionSlot)
            {
               case 0:
                  _loc2_ = 500;
                  _loc3_ = 50;
                  break;
               case 1:
                  switch(dataM.battleSubType)
                  {
                     case BMSinglePlayerManager.ENEMY_TYPE_MECH:
                        _loc2_ = 500;
                        _loc3_ = 50;
                        break;
                     case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
                        _loc2_ = 125;
                        _loc3_ = 15;
                  }
            }
         }
         else
         {
            switch(_loc1_.battlesVSComputer)
            {
               case 1:
                  _loc2_ = 500;
                  _loc3_ = 50;
                  break;
               case 2:
                  _loc2_ = 500;
                  _loc3_ = 50;
            }
         }
         _loc6_ = 0;
         _loc7_ = 0;
         this.finishBattleVSComputerSuccess(_loc2_,_loc3_,_loc6_,_loc7_,null,_loc1_.ladderProgress,tutorialM.calcLevelUp(_loc3_));
      }
      
      public function finishBattleVSComputerSuccess(param1:Number, param2:Number, param3:Number, param4:Number, param5:Vector.<BMPlayerItemData>, param6:uint, param7:BMLevelUpData) : void
      {
         var _loc8_:BMRewardData = null;
         var _loc9_:BMPlayerProfile = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Class = null;
         if(this._battleResult == BMDataManager.BATTLE_RESULT_PLAYER_QUIT)
         {
            if(this._hiddenBaseMission)
            {
               this.surrenderSuccess();
            }
            return;
         }
         _loc8_ = null;
         _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         switch(dataM.battleType)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_REGULAR:
               _loc13_ = BMScreenBattleResult;
               if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
               {
                  if(param4 > 0)
                  {
                     _loc13_ = BMScreenBattleResultPremiumWithArenaCoins;
                     _loc8_ = new BMRewardData();
                     _loc8_.arenaCoins = param4;
                  }
                  else
                  {
                     _loc13_ = BMScreenBattleResultPremium;
                  }
                  if(param5 != null)
                  {
                     if(_loc8_ == null)
                     {
                        _loc8_ = new BMRewardData();
                     }
                     _loc8_.items = param5;
                  }
               }
               screensM.addScreen(BMScreensManager.SCR_BATTLE_RESULT,false,_loc13_);
               screensM.screenBattleResult.setPrizes(param1,param2,param4,param3,_loc8_);
               break;
            case BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS:
               screensM.addScreen(BMScreensManager.SCR_BATTLE_RESULT,false,BMScreenBattleResultClanBoss);
               break;
            case BMSinglePlayerManager.BATTLE_TYPE_CLAN_WAR:
               screensM.addScreen(BMScreensManager.SCR_BATTLE_RESULT,false,BMScreenBattleResultClanWar);
         }
         _loc10_ = _loc9_.gold + param1;
         if(param7 != null)
         {
            _loc10_ += param7.getGoldAmount();
         }
         _loc11_ = _loc9_.XP + param2;
         _loc12_ = _loc9_.nukes;
         if(dataM.playingVSComputer)
         {
            switch(this._battleResult)
            {
               case BMDataManager.BATTLE_RESULT_WIN:
                  ++_loc9_.winningStreakVSComputer;
                  _loc9_.losingStreakVSComputer = 0;
                  break;
               case BMDataManager.BATTLE_RESULT_LOSS:
                  _loc9_.winningStreakVSComputer = 0;
                  ++_loc9_.losingStreakVSComputer;
            }
            dataM.savePerUserSharedObjectData();
         }
         this.battleResultSuccess(_loc10_,param7,_loc11_,_loc12_,_loc9_.overallRank,param6,_loc8_);
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
            case BMDataManager.BATTLE_RESULT_WIN:
               _loc2_ = 1;
               _loc3_ = dataM.player1PlayerID;
               break;
            case BMDataManager.BATTLE_RESULT_LOSS:
               _loc2_ = 2;
               _loc3_ = dataM.player2PlayerID;
               break;
            case BMDataManager.BATTLE_RESULT_OPPONENT_QUIT:
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
         if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
         {
            switch(dataM.battleSubType)
            {
               case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
               case BMSinglePlayerManager.ENEMY_TYPE_TANK:
                  _loc3_ = true;
            }
         }
         if(this._hiddenBaseMission)
         {
            if(screensM.screenMissionBaseMap.getEnemiesRemained() > 1)
            {
               _loc3_ = true;
            }
         }
         if(param1.shutDownActive)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            param2();
            return;
         }
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
            param2();
         }
      }
      
      private function winningTeaseEnded() : void
      {
         if(BattleTypeResolver.isSinglePlayer || BattleTypeResolver.isLadderPvPBot)
         {
            this.finishBattleVSComputer();
         }
         else if(this._battleResult_available)
         {
            this.battleResultSuccess(this._battleResult_newGold,this._battleResult_levelUpData,this._battleResult_newXP,this._battleResult_newNukes,this._battleResult_newRank,this._battleResult_newLadderProgress,this._battleResult_reward);
         }
         else
         {
            this._battleResult_triggerOnSpot = true;
         }
      }
      
      public function battleResultSuccess(param1:Number, param2:BMLevelUpData, param3:Number, param4:Number, param5:Number, param6:Number, param7:BMRewardData = null) : void
      {
         var _loc8_:Boolean = false;
         this.hideInterface(false,false,"battleResultSuccess");
         screensM.removeScreen(BMScreensManager.SCR_BATTLE_OPTIONS);
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_PVP:
               screensM.screenBattleInterfaceTop.disableTimer();
         }
         _loc8_ = false;
         if(this._battleResult_triggerOnSpot || this._battleResult_available || dataM.playingVSComputer)
         {
            _loc8_ = true;
         }
         if(_loc8_)
         {
            this.battleResultSuccessSub(param1,param2,param3,param4,param5,param6,param7);
         }
         else
         {
            this._battleResult_available = true;
            this._battleResult_newGold = param1;
            this._battleResult_levelUpData = param2;
            this._battleResult_newXP = param3;
            this._battleResult_newNukes = param4;
            this._battleResult_newRank = param5;
            this._battleResult_newLadderProgress = param6;
            this._battleResult_reward = param7;
         }
      }
      
      private function battleResultSuccessSub(param1:Number, param2:BMLevelUpData, param3:Number, param4:Number, param5:Number, param6:Number, param7:BMRewardData = null) : void
      {
         performFinishBattleOperations(this._battleResult,param1,param2,param3,param4,param5,param6,param7);
         tooltip.hideToolTip();
         this.disableScreenAfterBattleHasEnded();
      }
      
      private function disableScreenAfterBattleHasEnded() : void
      {
         screensM.screenBattleInterfaceTop.disableTimer();
         this._battleEnabled = false;
         this.hideInterface(false,false,"disableScreenAfterBattleHasEnded");
         screensM.screenBattleInterfaceTop.btnZoomIn.visible = false;
         screensM.screenBattleInterfaceTop.btnZoomOut.visible = false;
         screensM.screenBattleInterfaceTop.btnQuit.visible = false;
         screensM.screenBattleInterfaceTop.btnOptions.visible = false;
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
         var _loc19_:Number = NaN;
         var _loc20_:String = null;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:String = null;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:MovieClip = null;
         var _loc28_:MovieClip = null;
         var _loc29_:Point = null;
         var _loc30_:Point = null;
         var _loc31_:Point = null;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
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
               _loc19_ = 1;
               if(dataM.newVisualEffects)
               {
                  _loc19_ = 3;
               }
               if(_loc18_ > 400)
               {
                  _loc18_ = 400;
               }
               _loc20_ = "";
               if(dataM.generalSpeedRatio == 2)
               {
                  _loc20_ = "_fast";
               }
               effectsM.createTeleportDisappear("teleportDisappearAnim",_loc16_,_loc17_,_loc18_,_loc19_,this.finish2AnimationEnded,null,this.holder_effects);
               soundM.createSound("teleportDisappear",1);
               break;
            case 3:
               _loc21_ = Math.abs(_loc4_.currentStepVisual - _loc8_.currentStepVisual);
               _loc22_ = (_loc21_ - 0.7) * this.FLOOR_STEP_SIZE;
               _loc23_ = (_loc21_ - 1.7) * this.FLOOR_STEP_SIZE;
               _loc24_ = "left";
               if(_loc4_.currentStepVisual > _loc8_.currentStepVisual)
               {
                  _loc24_ = "right";
               }
               _loc4_.launchHarpoon("finish",_loc22_,_loc23_,_loc24_,_loc8_,this.finish3harpoonReachedTarget,this.finish3AnimationEnded);
               break;
            case 4:
               _loc25_ = _loc8_.mechView.x;
               _loc4_.charge(_loc25_,this.finish4ChargingAnimationEnded);
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
                  while(_loc14_ <= dataM.maxEquipment[BMMechStructure.SIDE_WEAPON])
                  {
                     _loc15_ = Number(_loc4_.mechStructure[BMMechStructure.SIDE_WEAPON + _loc14_]);
                     if(_loc15_ > 0)
                     {
                        _loc10_ = dataM.getPlayerItemData(this._currentPlayerID,_loc15_);
                        _loc11_ = dataM.itemsDB[_loc10_.itemID];
                        _loc12_ = dataM.animationDB[_loc11_.animation];
                        if(_loc12_.effectType == "flame")
                        {
                           _loc13_ = _loc14_;
                           _loc14_ = uint(dataM.maxEquipment[BMMechStructure.SIDE_WEAPON]);
                        }
                     }
                     _loc14_++;
                  }
                  _loc27_ = _loc5_[BMMechStructure.SIDE_WEAPON + _loc13_].item.itemGrp;
                  _loc28_ = _loc27_.mcFire1;
                  _loc29_ = new Point(_loc28_.x,_loc28_.y);
                  _loc30_ = _loc27_.localToGlobal(_loc29_);
                  _loc31_ = this.holder_main.globalToLocal(_loc30_);
                  _loc32_ = this.FLOOR_STEP_SIZE;
                  if(_loc11_.rangeAddon > 1)
                  {
                     _loc32_ = 1.75 * this.FLOOR_STEP_SIZE;
                  }
                  effectsM.activateFlameThrower(this._opponentPlayerID,_loc31_.x,_loc31_.y,_loc5_.scaleX,_loc32_,_loc12_.fireEffect,this.activateGetHit,null,null);
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
               while(_loc14_ <= dataM.maxEquipment[BMMechStructure.SIDE_WEAPON])
               {
                  _loc15_ = Number(_loc4_.mechStructure[BMMechStructure.SIDE_WEAPON + _loc14_]);
                  if(_loc15_ > 0)
                  {
                     _loc10_ = dataM.getPlayerItemData(this._currentPlayerID,_loc15_);
                     _loc11_ = dataM.itemsDB[_loc10_.itemID];
                     _loc12_ = dataM.animationDB[_loc11_.animation];
                     if(_loc12_.effectType == "sword")
                     {
                        _loc13_ = _loc14_;
                        _loc14_ = uint(dataM.maxEquipment[BMMechStructure.SIDE_WEAPON]);
                     }
                  }
                  _loc14_++;
               }
               if(_loc4_.currentStepCode > _loc8_.currentStepCode)
               {
                  _loc26_ = (_loc8_.currentStepCode + 1 + 0.5) * this.FLOOR_STEP_SIZE;
               }
               else
               {
                  _loc26_ = (_loc8_.currentStepCode - 1 + 0.5) * this.FLOOR_STEP_SIZE;
               }
               _loc5_.activateFinish7(_loc13_,_loc26_,this.finish7AnimationEnded);
               break;
            case 8:
               if(_loc4_.droneActive)
               {
                  _loc33_ = _loc9_.x - _loc4_.drone.droneGrp.x;
                  _loc34_ = _loc9_.y - _loc4_.drone.droneGrp.y;
                  _loc4_.drone.activateFinishMove(_loc33_,_loc34_);
                  soundM.createSound("droneOn",1);
               }
         }
         this.disableInterface("screenBattle activateFinishMove");
         this.hideInterface(false,false,"screenBattle activateFinishMove");
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
         this.destroyDefendingMech(BMMechBattleData.DESTRUCTION_FLYING_WEAPONS,0);
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
         var _loc12_:Number = NaN;
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
         _loc10_ = 1;
         if(dataM.newVisualEffects)
         {
            _loc10_ = 3;
         }
         if(_loc9_ > 400)
         {
            _loc9_ = 400;
         }
         _loc11_ = _loc4_.x;
         _loc12_ = _loc4_.y + 30;
         var _loc13_:String = "";
         if(dataM.generalSpeedRatio == 2)
         {
            _loc13_ = "_fast";
         }
         effectsM.createTeleportReappear("teleportReappearAnim",_loc11_,_loc12_,_loc9_,_loc10_,this.holder_effects);
         effectsM.createStompFire(this.holder_effects,"teleportFire1",_loc4_.x,0,60,6,1,false);
         effectsM.createStompFire(this.holder_effects,"teleportFire1",_loc4_.x,0,60,6,1,true);
         this._waitingForFinishMove = false;
         this.destroyDefendingMech(BMMechBattleData.DESTRUCTION_FLYING_WEAPONS,0);
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
         this.destroyDefendingMech(BMMechBattleData.DESTRUCTION_FLYING_WEAPONS,0);
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
         this.destroyDefendingMech(BMMechBattleData.DESTRUCTION_FLYING_WEAPONS,0);
      }
      
      private function finish5AnimationEnded() : void
      {
         this._waitingForFinishMove = false;
         this.destroyDefendingMech(BMMechBattleData.DESTRUCTION_FLYING_WEAPONS,0);
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
         this.destroyDefendingMech(BMMechBattleData.DESTRUCTION_FLYING_WEAPONS,_loc12_);
      }
      
      private function finish7AnimationEnded() : void
      {
         this._waitingForFinishMove = false;
         this.createGetHitSound();
         this.destroyDefendingMech(BMMechBattleData.DESTRUCTION_FLYING_WEAPONS,0);
      }
      
      public function finish8AnimationEnded() : void
      {
         this._waitingForFinishMove = false;
         this.createGetHitSound();
         this.destroyDefendingMech(BMMechBattleData.DESTRUCTION_FLYING_WEAPONS,0);
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
         this.startNewTurn();
      }
      
      private function endTurnSuccess(param1:Boolean, param2:Boolean, param3:String = "") : void
      {
         screensM.screenBattleInterfaceTop.deactivateTurnOwnerMessage();
         this._timerNotice = false;
         if(this._currentPlayerID == dataM.player2PlayerID)
         {
            this._currentPlayerID = dataM.player1PlayerID;
            this._opponentPlayerID = dataM.player2PlayerID;
            this.activateMechTeaseAnimation();
         }
         else
         {
            this._currentPlayerID = dataM.player2PlayerID;
            this._opponentPlayerID = dataM.player1PlayerID;
            this.hideInterface(false,false,"endTurnSuccess");
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
            if(dataM.generalSpeedRatio == 2)
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
         this.hideInterface(false,false,"notMyTurn");
      }
      
      private function beginEndBattleSequencesForHiddenBases() : void
      {
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WAIT,1);
         dataM.mission_battleEnded_playerWon = this._lastPlayerLostID != dataM.player1PlayerID;
         screensM.screenMissionBaseMap.battleEndedForHiddenBase();
      }
      
      public function baseUpgradeUsed(param1:String, param2:BMMissionMechStats = null) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         _loc3_ = this.getMechSlot(dataM.player1PlayerID,dataM.myProfile.missionCurrentMechID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         if(param2 != null)
         {
            if(_loc4_.HP < param2.hp)
            {
               _loc4_.HP = param2.hp;
            }
            if(_loc4_.heatMax < param2.heat)
            {
               _loc4_.heatMax = param2.heat;
            }
            if(_loc4_.heatCooling < param2.heatCooling)
            {
               _loc4_.heatCooling = param2.heatCooling;
            }
            if(_loc4_.energyMax < param2.energy)
            {
               _loc4_.energyMax = param2.energy;
            }
            if(_loc4_.energyRegeneration < param2.energyRegeneration)
            {
               _loc4_.energyRegeneration = param2.energyRegeneration;
            }
         }
         if(this._recentBaseUpgrades[param1] != null)
         {
            return;
         }
         this._recentBaseUpgrades[param1] = true;
         if(screensM.screenBlack.isActive())
         {
            _loc4_.energy = _loc4_.energyMax;
            this.onUpgradeTimelineComplete(param1);
         }
         else
         {
            screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_AFTER_BATTLE_UPGRADE,2,{"upgradeType":param1});
         }
      }
      
      private function screensDirectorFinishedAllTasks(param1:String, param2:Object) : void
      {
         if(this._startNewBattleSuccessSubDelayed == false)
         {
            return;
         }
         this._startNewBattleSuccessSubDelayed = false;
         this.startNewBattleSuccessSub();
      }
      
      public function initWaveText(param1:uint, param2:uint) : void
      {
         var _loc3_:String = null;
         if(param2 > 1)
         {
            _loc3_ = getSpecificText("announcer_wave");
            _loc3_ = dataM.replaceStringInText(_loc3_,"%WAVE%",param1 + " / " + param2);
            screensM.screenBattleInterfaceTop.showAnnouncerText(_loc3_,16777215,1.8,0.75,false);
         }
      }
      
      public function initUpgradeAnimation(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:DisplayObject = null;
         var _loc6_:Point = null;
         _loc2_ = new BattleBonusIcon();
         _loc2_.scaleX = 0.01;
         _loc2_.scaleY = 0.01;
         _loc2_.x = dataM.STAGE_WIDTH / 2;
         _loc2_.y = 200;
         if(this._lastDestroyedMechScreenPosition != null)
         {
            _loc6_ = screensM.screenBattleInterfaceTop.globalToLocal(this._lastDestroyedMechScreenPosition);
            _loc2_.x = _loc6_.x + _loc2_.width * 0.5;
            _loc2_.y = _loc6_.y + _loc2_.height * 0.5;
         }
         screensM.screenBattleInterfaceTop.addChild(_loc2_);
         this._upgradeTimeLine = new TimelineMax();
         switch(param1)
         {
            case "upgradeHP":
               _loc5_ = screensM.screenBattleInterfaceTop.player1HPBar;
               _loc3_ = _loc5_.x + _loc5_.width / 2;
               _loc4_ = _loc5_.y + _loc5_.height / 2;
               _loc2_.gotoAndStop("hp");
               break;
            case "upgradeHeat":
               _loc5_ = screensM.screenBattleInterfaceTop.player1IconHeatSizer;
               _loc3_ = _loc5_.x + _loc5_.width / 2;
               _loc4_ = _loc5_.y + _loc5_.height / 2;
               _loc2_.gotoAndStop("heat");
               break;
            case "upgradeEnergy":
               _loc5_ = screensM.screenBattleInterfaceTop.player1IconEnergySizer;
               _loc3_ = _loc5_.x + _loc5_.width / 2;
               _loc4_ = _loc5_.y + _loc5_.height / 2;
               _loc2_.gotoAndStop("energy");
         }
         this._upgradeTimeLine.addLabel("grow");
         this._upgradeTimeLine.to(_loc2_,0.4,{
            "scaleX":1.15,
            "scaleY":1.15
         },"grow");
         this._upgradeTimeLine.addLabel("shrink");
         this._upgradeTimeLine.to(_loc2_,0.1,{
            "scaleX":1,
            "scaleY":1
         },"shrink");
         this._upgradeTimeLine.addLabel("move","+=0.5");
         this._upgradeTimeLine.to(_loc2_,0.3,{
            "x":_loc3_,
            "y":_loc4_,
            "scaleX":0.1,
            "scaleY":0.1,
            "visible":false,
            "onComplete":this.onUpgradeTimelineComplete,
            "onCompleteParams":[param1]
         },"move");
         soundM.createSound("kitUsed",1);
      }
      
      private function onUpgradeTimelineComplete(param1:String) : void
      {
         if(this._upgradeTimeLine != null)
         {
            this._upgradeTimeLine.kill();
            this._upgradeTimeLine = null;
         }
         switch(param1)
         {
            case "upgradeHP":
               screensM.screenBattleInterfaceTop.refreshHP(dataM.player1PlayerID,true);
               break;
            case "upgradeHeat":
               screensM.screenBattleInterfaceTop.refreshHeat(dataM.player1PlayerID,true);
               break;
            case "upgradeEnergy":
               screensM.screenBattleInterfaceTop.refreshEnergy(dataM.player1PlayerID,true);
         }
         screensM.screenBattleInterfaceTop.createTextsBitmapForMobile(1);
      }
      
      public function hiddenBaseMissionCompleted() : void
      {
         this.disableInterface("hiddenBaseMissionCompleted");
      }
      
      public function closeScreen(param1:Boolean = false) : void
      {
         this._goToPremiumAccount = param1;
         this.closeScreenSuccess();
      }
      
      public function closeScreenSuccess() : void
      {
         if(this._hiddenBaseMission)
         {
            this.beginEndBattleSequencesForHiddenBases();
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.cleanBattle,true,true,[false],0);
         }
      }
      
      public function cleanBattle(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         keyboardM.deactivateMe();
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_TOP))
         {
            screensM.screenBattleInterfaceTop.disableTimer();
         }
         this.cleanBattleField();
         dataM.removePVPAndReplaysDoubleSpeed();
         effectsM.abortGeneralEffects();
         this._skipStartNewActionEnbaleInterface = false;
         _loc2_ = dataM.gameType;
         if(!param1)
         {
            switch(dataM.gameType)
            {
               case BMDataManager.GAME_TYPE_TUTORIAL_PVE:
                  if(this._giveTutorialItemAfterBattle1 || this._giveTutorialItemAfterBattle2)
                  {
                     _loc4_ = 20;
                     if(this._giveTutorialItemAfterBattle1)
                     {
                        dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,BMCampaignMechsHelper.getTutorial_hanger2_torso(),0,0,0,0);
                     }
                     else
                     {
                        dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,BMCampaignMechsHelper.getTutorial_hanger3_sideWeapon(),0,0,0,0);
                     }
                     dataM.saveGuestData("battle cleanBattle");
                     this._giveTutorialItemAfterBattle1 = false;
                     this._giveTutorialItemAfterBattle2 = false;
                  }
                  dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_TUTORIAL,BMDataManager.GAME_SUB_TYPE_NONE,"battle_cleanBattle");
                  dataM.battle_afterBattleFunctions(_loc2_);
                  screensM.screenBattleInterfaceTop.clearOpponentModules();
                  if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_RESULT))
                  {
                     screensM.screenBattleResult.removeMe();
                  }
                  break;
               case BMDataManager.GAME_TYPE_PVP:
               case BMDataManager.GAME_TYPE_PVE:
               case BMDataManager.GAME_TYPE_PVE_ON_SERVER:
               case BMDataManager.GAME_TYPE_CLAN_WAR:
                  dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_DEFAULT,BMDataManager.GAME_SUB_TYPE_NONE,"battle_cleanBattle");
                  _loc3_ = dataM.useHiddenBaseMap && _loc2_ == BMDataManager.GAME_TYPE_PVE;
                  if(_loc3_ == false)
                  {
                     dataM.battle_afterBattleFunctions(_loc2_);
                  }
                  screensM.screenBattleInterfaceTop.clearOpponentModules();
                  if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_RESULT))
                  {
                     screensM.screenBattleResult.removeMe();
                  }
                  if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS)
                  {
                     dataM.setGeneralSpeedRatioAsNormal(false);
                     dataM.setUserAutopilotOff(false);
                  }
                  break;
               case BMDataManager.GAME_TYPE_REPLAY:
                  switch(dataM.gameSubType)
                  {
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_REGULAR:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_DEFAULT,BMDataManager.GAME_SUB_TYPE_NONE,"battle_cleanBattle");
                        screensM.screenTransitionsManager.profileReplaysClicked(true);
                        dataM.savePerUserSharedObjectData();
                        break;
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_RANKING_LIST_INSPECT:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_DEFAULT,BMDataManager.GAME_SUB_TYPE_NONE,"battle_cleanBattle");
                        dataM.rankingList_gettingBackToRankingListFromAReplay = true;
                        screensM.screenTransitionsManager.communityRankingListClicked(true);
                        screensM.addScreen(BMScreensManager.SCR_INSPECT_PLAYER);
                        screensM.screenInspectPlayer.refreshScreenWithLastData();
                        dataM.savePerUserSharedObjectData();
                        break;
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_RAID_LEADERBOARD_INSPECT:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_DEFAULT,BMDataManager.GAME_SUB_TYPE_NONE,"battle_cleanBattle");
                        screensM.screenTransitionsManager.raidMenuClicked(true,true);
                        dataM.savePerUserSharedObjectData();
                        break;
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_MENU_CHAT_INSPECT:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_DEFAULT,BMDataManager.GAME_SUB_TYPE_NONE,"battle_cleanBattle");
                        screensM.screenTransitionsManager.multiplayerChatClicked(true,false);
                        screensM.addScreen(BMScreensManager.SCR_INSPECT_PLAYER);
                        screensM.screenInspectPlayer.refreshScreenWithLastData();
                        dataM.savePerUserSharedObjectData();
                        break;
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_CLAN_INSPECT:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_DEFAULT,BMDataManager.GAME_SUB_TYPE_NONE,"battle_cleanBattle");
                        screensM.screenTransitionsManager.communityClanClicked(true);
                        screensM.addScreen(BMScreensManager.SCR_INSPECT_PLAYER);
                        screensM.screenInspectPlayer.refreshScreenWithLastData();
                        screensM.screenClanMenu.selectMembersTab();
                        dataM.savePerUserSharedObjectData();
                        break;
                     case BMDataManager.GAME_SUB_TYPE_REPLAY_SMTV:
                        dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_DEFAULT,BMDataManager.GAME_SUB_TYPE_NONE,"battle_cleanBattle");
                        screensM.screenTransitionsManager.multiplayerLadderClicked(true,false);
                        dataM.savePerUserSharedObjectData();
                  }
            }
         }
         this.computerM.stopMe();
         dataM.battleType = BMSinglePlayerManager.BATTLE_TYPE_NONE;
         dataM.battleSubType = "";
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
         {
            screensM.screenBattleInterfaceBottom.cancelMoveToStepSelectionClicked(true);
            screensM.screenBattleInterfaceBottom.deleteMechPictures();
         }
         screensM.screenBattleInterfaceTop.removeMe();
         screensM.removeScreen(BMScreensManager.SCR_BATTLE);
         screensM.removeScreen(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM);
         screensM.removeScreen(BMScreensManager.SCR_BATTLE_INTERFACE_EMOTES);
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_RESULT))
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
         this._battleResult = BMDataManager.BATTLE_RESULT_OPPONENT_QUIT;
         this.battleIsOver("opponentQuitBattle");
      }
      
      public function quitClicked() : void
      {
         if(dataM.userAutopilot)
         {
            screensM.screenBattleInterfaceBottom.mcAutoplayAndGameSpeedPanel.activateUserAutopilotArrow();
            return;
         }
         this.activateNextBattlePhase("endBattle_quit");
      }
      
      private function tryToQuitBattle() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         _loc1_ = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && dataM.battle_inBattleInvitation == false)
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
            if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
         {
            screensM.screenBattleInterfaceBottom.cancelMoveToStepSelectionClicked();
         }
      }
      
      private function quitBattleVSPlayerConfirmed() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = null;
         this._battleResult = BMDataManager.BATTLE_RESULT_PLAYER_QUIT;
         _loc1_ = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && dataM.battle_inBattleInvitation == false)
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
            dataM.mechBoostRecommender.allowNextRecommendationByClient();
         }
         soundM.removeAllMusic();
      }
      
      private function quitBattleVSComputerConfirmed() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         if(this.getPlayerAliveMechSlot(dataM.player1PlayerID) == "")
         {
            return;
         }
         this._battleResult = BMDataManager.BATTLE_RESULT_PLAYER_QUIT;
         _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         switch(dataM.battleType)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
               dataM.mission_battleEnded = true;
               dataM.mission_battleEnded_playerWon = false;
               this.resetBattleEndedPlayerMechStats();
               this.updateBattleEndedPlayerMechStats();
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL_PVE)
         {
            --_loc1_.battlesVSComputer;
            this.surrenderSuccess();
         }
         else if(BattleTypeResolver.isBattleOnServer)
         {
            this.surrender();
            screensM.screenConfirmation.displayQuestionOrNotification("exitingBattle",-1,-1);
         }
         else if(dataM.playingVSComputer)
         {
            --_loc1_.battlesVSComputer;
            if(this._hiddenBaseMission == false)
            {
               this.surrenderSuccess();
            }
            _loc2_ = dataM["player" + dataM.player2PlayerID + "Profile"];
            _loc3_ = dataM.singlePlayerM.getCurrentMissionPosition();
            _loc4_ = false;
            _loc5_ = true;
            _loc6_ = uint(_loc2_.level);
            remoteM.lobby_finishBattleVSComputer(_loc4_,_loc5_,dataM.battleType,dataM.battleSubType,dataM.campaignBattleDifficulty,dataM.computerBattleID,this._battleReport,_loc6_,_loc3_);
         }
         else if(dataM.gameType == BMDataManager.GAME_TYPE_REPLAY)
         {
            this.endReplay();
         }
         soundM.removeAllMusic();
      }
      
      public function allowWaitingForBattleResultPopup() : Boolean
      {
         if(this.isWaitingForFinishMove())
         {
            return false;
         }
         if(this._hiddenBaseMission)
         {
            return false;
         }
         return true;
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
         this._manualZoomOut = false;
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
                  _loc3_.mechView.setMechHorizontalScale(param1);
               }
               else if(_loc3_.playerID == dataM.player2PlayerID)
               {
                  _loc3_.mechView.setMechHorizontalScale(param2);
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
         var _loc4_:uint = 0;
         var _loc5_:TextField = null;
         var _loc6_:TextFormat = null;
         var _loc7_:MovieClip = null;
         this.background_floor = new MovieClip();
         if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
         {
            dataM.battle_backgroundID = dataM.myProfile.mission_themeID;
         }
         else if(isFightingClanBoss)
         {
            dataM.battle_backgroundID = dataM.myProfile.clanBossData.themeID;
         }
         _loc3_ = externalAssetsM.getAsset("general","Grp_floor_" + dataM.battle_backgroundID);
         this.floors.push(_loc3_);
         this.background_floor.addChild(_loc3_);
         this.background_level0 = externalAssetsM.getAsset("general","Grp_background_" + dataM.battle_backgroundID);
         this.holder_backgrounds.addChild(this.background_level0);
         this.holder_backgroundFloor.addChild(this.background_floor);
         this.mapBorder1.visible = false;
         this.mapBorder2.visible = false;
         if(this.DISPLAY_STEP_NUMBERS && false)
         {
            this.floorStepNumbers = new Array();
            _loc4_ = 0;
            while(_loc4_ < dataM.battleData.map.stepsTotal)
            {
               _loc5_ = new TextField();
               _loc5_.multiline = true;
               _loc5_.htmlText = _loc4_ + "<BR>" + (dataM.battleData.map.stepsTotal - _loc4_ - 1);
               _loc6_ = new TextFormat("arial",20,16777215,true,false,false,null,null,"center");
               _loc5_.setTextFormat(_loc6_);
               _loc5_.selectable = false;
               _loc5_.x = (_loc4_ + 0.5) * this.FLOOR_STEP_SIZE - _loc5_.width / 2;
               _loc5_.y = 20;
               _loc7_ = new mcStepNumberLine();
               _loc7_.x = _loc4_ * this.FLOOR_STEP_SIZE - 3;
               _loc7_.y = 5;
               this.floorStepNumbers[_loc4_] = new Object();
               this.floorStepNumbers[_loc4_].stepText = _loc5_;
               this.floorStepNumbers[_loc4_].stepLine = _loc7_;
               this.holder_backgroundFloor.addChild(_loc5_);
               this.holder_backgroundFloor.addChild(_loc7_);
               _loc4_++;
            }
         }
         ++dataM.battle_backgroundID;
         if(dataM.battle_backgroundID > 8)
         {
            dataM.battle_backgroundID = 1;
         }
      }
      
      private function addMapBorders() : void
      {
         this.mapBorder1.x = -30;
         this.mapBorder2.x = this.FLOOR_STEP_SIZE * dataM.battleData.map.stepsTotal + 30;
         this.mapBorder1.mcLight.gotoAndStop("animOn");
         this.mapBorder2.mcLight.gotoAndStop("animOn");
         this.mapBorder1.visible = true;
         this.mapBorder2.visible = true;
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
                     effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"spark",_loc5_.x,_loc5_.y,_loc11_,_loc12_,_loc13_,"horizontal","blue",true);
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
                  effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,"spark",_loc5_.x,_loc5_.y,_loc11_,_loc12_,_loc13_,"horizontal","red",true);
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
      
      private function createMechView(param1:Number, param2:uint, param3:Boolean = false) : void
      {
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:BMMechStructure = null;
         var _loc7_:BMMechView = null;
         var _loc8_:Number = NaN;
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:BMItemData = null;
         _loc4_ = this.getMechSlot(param1,param2);
         _loc5_ = this._mechBattleDatas[_loc4_];
         _loc6_ = _loc5_.mechStructure;
         _loc7_ = new BMMechView();
         _loc7_.useLegsShadow = true;
         _loc7_.useDamageDecals = true;
         _loc8_ = this.MECH_SIZE_RATIO;
         if(_loc6_.perk > 0)
         {
            _loc9_ = dataM.getPlayerItemData(param1,_loc6_.perk);
            _loc10_ = dataM.itemsDB[_loc9_.itemID];
            if(_loc10_.isGiantSizePerk)
            {
               _loc8_ = this.MECH_SIZE_RATIO_GIANT_PERK;
            }
            else if(_loc10_.isDwarfSizePerk)
            {
               _loc8_ = this.MECH_SIZE_RATIO_DWARF_PERK;
            }
         }
         _loc5_.mechView = _loc7_;
         _loc7_.initialize(param1,"battle",BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,_loc8_,false);
         _loc7_.buildMech(_loc6_,this.createMechViewSub,[param1,param2,param3]);
      }
      
      private function setMechXPosition(param1:BMMechBattleData) : void
      {
         if(param1.mechView == null)
         {
            return;
         }
         param1.mechView.x = (param1.currentStepVisual + 0.5) * this.FLOOR_STEP_SIZE;
      }
      
      private function createMechViewSub(param1:Array) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:BMMechStructure = null;
         var _loc8_:BMMechView = null;
         var _loc9_:BMMechDrone = null;
         var _loc10_:Number = NaN;
         var _loc11_:BMMechView = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:String = null;
         _loc2_ = uint(param1[0]);
         _loc3_ = uint(param1[1]);
         _loc4_ = Boolean(param1[2]);
         _loc5_ = this.getMechSlot(_loc2_,_loc3_);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc7_ = _loc6_.mechStructure;
         _loc8_ = _loc6_.mechView;
         _loc8_.setWalkingParameters(this.WALKING_LEG_X_DISTANCE,this.MECH_WALKING_FRAMES,this.walkingDirtEffect);
         _loc8_.setBumpParameters();
         _loc8_.setGetHitParameters(5,5);
         _loc8_.showCenterPosition();
         _loc8_.createChargeEngine();
         _loc8_.activateBreathing();
         _loc8_.x = (_loc6_.currentStepCode + 0.5) * this.FLOOR_STEP_SIZE;
         _loc9_ = new BMMechDrone();
         this.holder_mechs.addChild(_loc9_);
         this.holder_mechs.addChild(_loc8_);
         _loc6_.drone = _loc9_;
         _loc10_ = _loc6_.HP / _loc6_.HPMax;
         _loc6_.mechView.addDamageDecals(_loc10_);
         _loc6_.createDrone(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
         if(_loc6_.shieldActive)
         {
            _loc6_.activateShield();
         }
         if(dataM.runAsMobile == false)
         {
            switch(_loc2_)
            {
               case dataM.LOCAL_PLAYER_ID:
               case dataM.ONLINE_PLAYER_ID:
                  this.clearMechHologram();
                  this.mechHologram = new mcMechHologramEffect();
                  _loc11_ = new BMMechView();
                  _loc11_.initialize(_loc2_,"battle",BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,_loc8_.sizeRatio,false);
                  _loc11_.buildMech(_loc7_);
                  this.mechHologram.mechViewHolder.addChild(_loc11_);
                  this.mechHologram.mechViewHolder.mechView = _loc11_;
            }
         }
         ++this._initialMechsBuiltCounter;
         if(this._initialMechsBuiltCounter == 2)
         {
            this._initialMechsBuilt = true;
            this.tryToStartFirstTurn();
         }
         if(_loc4_)
         {
            _loc12_ = _loc8_.mechSizer.width * 1.8;
            _loc13_ = 1;
            if(dataM.newVisualEffects)
            {
               _loc13_ = 3;
            }
            _loc14_ = _loc8_.x;
            _loc15_ = _loc8_.y + 30;
            _loc16_ = "";
            if(dataM.generalSpeedRatio == 2)
            {
               _loc16_ = "_fast";
            }
            effectsM.createTeleportReappear("teleportReappearAnim",_loc14_,_loc15_,_loc12_,_loc13_,this.holder_effects);
            soundM.createSound("teleportAppear",1);
         }
      }
      
      public function getMechStructure(param1:Number, param2:uint) : BMMechStructure
      {
         var _loc3_:BMPlayerData = null;
         _loc3_ = _loc3_ = dataM.playersData[param1];
         if(this.opponentAvailable)
         {
            if(param1 == dataM.player1PlayerID && dataM.battleData.player1.chosenMechIDs != null)
            {
               param2 = uint(dataM.battleData.player1.chosenMechIDs[param2 - 1]);
            }
            if(param1 == dataM.player2PlayerID && dataM.battleData.player2.chosenMechIDs != null)
            {
               param2 = uint(dataM.battleData.player2.chosenMechIDs[param2 - 1]);
            }
         }
         return _loc3_.mechStructures[param2];
      }
      
      private function getPlayerInitialStep(param1:uint, param2:uint = 0) : uint
      {
         if(param1 == dataM.player2PlayerID && this.isOpponentSpecialBoss(param2))
         {
            return dataM.battleData.map.stepsTotal - 1;
         }
         return dataM.battleData["player" + dataM.getInterfacePlayerID(param1)].currentStep;
      }
      
      private function createMechBattleData(param1:Number, param2:uint, param3:Number) : void
      {
         var _loc4_:BMMechStructure = null;
         var _loc5_:Number = NaN;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:BMPlayerItemData = null;
         var _loc9_:BMPlayerProfile = null;
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc12_:BMPlayerItemData = null;
         var _loc13_:BMItemData = null;
         var _loc14_:BMReplayStatus = null;
         var _loc15_:Boolean = false;
         var _loc16_:BMMissionMechStats = null;
         var _loc17_:BMWorldMapLocationData = null;
         var _loc18_:String = null;
         var _loc19_:BMWorldMapBossData = null;
         var _loc20_:Boolean = false;
         var _loc21_:Number = NaN;
         var _loc22_:uint = 0;
         var _loc23_:uint = 0;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         _loc4_ = this.getMechStructure(param1,param2);
         _loc4_.updateEquipmentIndicators();
         if(this.opponentAvailable == false)
         {
            _loc5_ = -1;
         }
         else
         {
            _loc5_ = this.getPlayerInitialStep(param1,_loc4_.torso);
         }
         _loc6_ = new BMMechBattleData();
         _loc6_.initialize();
         _loc6_.playerID = param1;
         _loc6_.mechID = param2;
         _loc6_.mechStructure = _loc4_;
         _loc6_.currentStepVisual = _loc5_;
         _loc6_.currentStepCode = _loc5_;
         _loc7_ = dataM.getPlayerItemData(param1,_loc4_.torso);
         var _loc8_:BMItemData = dataM.itemsDB[_loc7_.itemID];
         _loc6_.setHPMax();
         _loc6_.setEnergyMaxAndRegeneration();
         _loc6_.setHeatMaxAndCooling();
         _loc6_.setBulletsMax();
         _loc6_.setRocketsMax();
         _loc6_.setUses();
         _loc6_.setAllResistances();
         _loc6_.setMovementParameters();
         if(tutorialM.isTutorialActive() == false && dataM.playingVSComputer && param1 == dataM.player2PlayerID)
         {
            this._opponentResistance1 = _loc6_.resist1;
            this._opponentResistance2 = _loc6_.resist2;
            this._opponentResistance3 = _loc6_.resist3;
         }
         if(_loc4_.shield > 0)
         {
            _loc12_ = dataM.getPlayerItemData(param1,_loc4_.shield);
            _loc13_ = dataM.itemsDB[_loc12_.itemID];
            if(_loc13_.energyPerBlock > 0)
            {
               _loc6_.shieldType = "energy";
            }
            else
            {
               _loc6_.shieldType = "heat";
            }
         }
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_REPLAY:
               if(param2 == 1)
               {
                  _loc14_ = dataM.battle_replayData["status" + dataM.getInterfacePlayerID(param1)][0];
                  _loc6_.HPMax = _loc14_.HP;
                  _loc6_.HP = _loc6_.HPMax;
                  _loc6_.energyMax = _loc14_.energy;
                  _loc6_.energy = _loc6_.energyMax;
                  _loc6_.bulletsMax = _loc14_.bullets;
                  _loc6_.bullets = _loc6_.bulletsMax;
                  _loc6_.rocketsMax = _loc14_.rockets;
                  _loc6_.rockets = _loc6_.rocketsMax;
                  _loc6_.resist1 = _loc14_.resist1;
                  _loc6_.resist2 = _loc14_.resist2;
                  _loc6_.resist3 = _loc14_.resist3;
                  _loc6_.dataSetByReplay = true;
               }
         }
         _loc10_ = true;
         switch(dataM.battleType)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS:
               if(param1 == dataM.player2PlayerID)
               {
                  _loc6_.HPMax = dataM.myProfile.clanBossData.hpMax;
                  _loc6_.HP = dataM.myProfile.clanBossHP;
                  if(_loc6_.HPMax < _loc6_.HP)
                  {
                     _loc6_.HPMax = _loc6_.HP;
                  }
                  _loc6_.energyMax = dataM.myProfile.clanBossData.energy;
                  _loc6_.energyRegeneration = dataM.myProfile.clanBossData.energyRegeneration;
                  _loc6_.energy = _loc6_.energyMax;
                  _loc6_.heatMax = dataM.myProfile.clanBossData.heat;
                  _loc6_.heatCooling = dataM.myProfile.clanBossData.heatCooling;
                  _loc6_.resist1 = dataM.myProfile.clanBossData.resist1;
                  _loc6_.resist2 = dataM.myProfile.clanBossData.resist2;
                  _loc6_.resist3 = dataM.myProfile.clanBossData.resist3;
                  _loc15_ = true;
                  _loc6_.applyDifficultyMutliplier(dataM.myProfile.clanBossData.damageMultiplier,_loc15_);
                  _loc6_.useHeatBombExplosionOnDeath = true;
               }
               break;
            case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
               _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(param1 == dataM.player1PlayerID)
               {
                  _loc16_ = _loc9_.mission_mechStats[param2 - 1];
                  if(_loc6_.HP > _loc16_.hp)
                  {
                     _loc6_.HP = _loc16_.hp;
                  }
                  _loc6_.energyMax = _loc16_.energy;
                  _loc6_.energy = _loc6_.energyMax;
                  _loc6_.energyRegeneration = _loc16_.energyRegeneration;
                  _loc6_.heatMax = _loc16_.heat;
                  _loc6_.heatCooling = _loc16_.heatCooling;
                  if(_loc6_.bullets > _loc16_.bullets)
                  {
                     _loc6_.bullets = _loc16_.bullets;
                  }
                  if(_loc6_.rockets > _loc16_.rockets)
                  {
                     _loc6_.rockets = _loc16_.rockets;
                  }
               }
               else
               {
                  switch(dataM.battleSubType)
                  {
                     case BMSinglePlayerManager.ENEMY_TYPE_BOSS:
                        if(dataM.raidData.isRaidInProgress())
                        {
                           break;
                        }
                        _loc17_ = dataM.singlePlayerM.currentMissionDB;
                        _loc18_ = _loc17_.bossID;
                        _loc19_ = dataM.singlePlayerM.getMissionBossData(dataM.myProfile.currentStoryID,_loc17_.campaignID,_loc18_,_loc9_.currentMissionMode);
                        if(_loc19_.fixed_hp > 0)
                        {
                           _loc6_.HPMax = _loc19_.fixed_hp;
                           _loc6_.HP = _loc6_.HPMax;
                        }
                        if(_loc19_.fixed_energyBase > 0)
                        {
                           _loc6_.energyMax = _loc19_.fixed_energyBase;
                           _loc6_.energy = _loc6_.energyMax;
                        }
                        if(_loc19_.fixed_energyAddon > 0)
                        {
                           _loc6_.energyRegeneration = _loc19_.fixed_energyAddon;
                        }
                        if(_loc19_.fixed_heatBase > 0)
                        {
                           _loc6_.heatMax = _loc19_.fixed_heatBase;
                        }
                        if(_loc19_.fixed_heatAddon > 0)
                        {
                           _loc6_.heatCooling = _loc19_.fixed_heatAddon;
                        }
                        if(_loc19_.fixed_bullets > 0)
                        {
                           _loc6_.bulletsMax = _loc19_.fixed_bullets;
                           _loc6_.bullets = _loc6_.bulletsMax;
                        }
                        if(_loc19_.fixed_rockets > 0)
                        {
                           _loc6_.rocketsMax = _loc19_.fixed_rockets;
                           _loc6_.rockets = _loc6_.rocketsMax;
                        }
                        if(_loc19_.fixed_resist1 > 0)
                        {
                           _loc6_.resist1 = _loc19_.fixed_resist1;
                        }
                        if(_loc19_.fixed_resist2 > 0)
                        {
                           _loc6_.resist2 = _loc19_.fixed_resist2;
                        }
                        if(_loc19_.fixed_resist3 > 0)
                        {
                           _loc6_.resist3 = _loc19_.fixed_resist3;
                        }
                        _loc20_ = dataM.singlePlayerM.didCompleteSlot(dataM.myProfile.currentStoryID,dataM.myProfile.currentMissionSlot,dataM.myProfile.currentMissionMode);
                        if(_loc20_ == false)
                        {
                           _loc6_.useHeatBombExplosionOnDeath = true;
                        }
                  }
                  if(!tutorialM.isTutorialActive())
                  {
                     _loc21_ = dataM.computerDifficultyMultiplier;
                     if(isNaN(_loc21_))
                     {
                        _loc22_ = uint(_loc9_.currentStoryID);
                        _loc23_ = _loc9_.currentMissionMode;
                        _loc24_ = uint(_loc9_.currentMissionSlot);
                        _loc25_ = _loc9_.mission_difficulty;
                        _loc21_ = dataM.singlePlayerM.getBaseDifficultyMultiplier(_loc22_,_loc24_,_loc23_,_loc25_);
                     }
                     _loc6_.applyDifficultyMutliplier(_loc21_);
                  }
                  _loc6_.energy = _loc6_.energyMax;
               }
         }
         if(param1 == dataM.player2PlayerID)
         {
            if(_loc10_)
            {
               screensM.screenBattleInterfaceTop.showOpponentInterface();
            }
            else
            {
               screensM.screenBattleInterfaceTop.hideOpponentInterface();
            }
         }
         if(BattleTypeResolver.isClanBoss == false)
         {
            if(dataM.getInterfacePlayerID(param1) == 2 && BattleTypeResolver.isSinglePlayer)
            {
               _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               switch(_loc9_.winsVSComputer)
               {
                  case 0:
                     _loc6_.HPMax = 50;
                     break;
                  case 1:
                     _loc6_.HPMax = 80;
                     break;
                  case 2:
                     _loc6_.HPMax = 100;
                     break;
                  case 3:
                     _loc6_.HPMax = 60;
                     break;
                  case 4:
                     _loc6_.HPMax = 120;
                     break;
                  default:
                     if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION && dataM.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_MECH && _loc9_.level <= 4)
                     {
                        _loc26_ = 0.75;
                        if(_loc9_.level <= 3)
                        {
                           _loc26_ = 0.65;
                        }
                        _loc6_.HPMax = Math.ceil(_loc6_.HPMax * _loc26_ / 5) * 5;
                     }
               }
               _loc6_.HP = _loc6_.HPMax;
               if(dataM.singlePlayerM.isFightingDamagedEnemy)
               {
                  _loc6_.HP = Math.ceil(_loc6_.HP * (100 - dataM.missionExplosiveChainDamageReduction) / 100);
               }
            }
         }
         if(param3 > 0)
         {
            _loc6_.HPMax += 5 * param3;
            _loc6_.HP = _loc6_.HPMax;
            _loc27_ = 10;
            _loc28_ = 45;
            _loc29_ = 1;
            while(_loc29_ <= 3)
            {
               _loc6_["resist" + _loc29_] += Math.ceil(0.5 * param3);
               if(_loc6_["resist" + _loc29_] < _loc27_)
               {
                  _loc6_["resist" + _loc29_] = _loc27_;
               }
               else if(_loc6_["resist" + _loc29_] > _loc28_)
               {
                  _loc6_["resist" + _loc29_] = _loc28_;
               }
               _loc29_++;
            }
         }
         _loc11_ = param1 + "_" + param2;
         this._mechBattleDatas[_loc11_] = _loc6_;
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
      
      private function mechTeaseAnimationsHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerData = null;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:Number = NaN;
         if(this._mechTeaseAnimationsHandler == false)
         {
            return;
         }
         if(this._currentPlayerID != dataM.player1PlayerID)
         {
            return;
         }
         if(this._socketActionAllowed == false)
         {
            return;
         }
         ++this._mechTeaseAnimationCounter;
         if(this._mechTeaseAnimationCounter < 300)
         {
            return;
         }
         _loc1_ = true;
         switch(dataM.battleSubType)
         {
            case BMSinglePlayerManager.ENEMY_TYPE_TANK:
            case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
            case BMSinglePlayerManager.ENEMY_TYPE_TURRET:
            case BMSinglePlayerManager.ENEMY_TYPE_CLAN_BOSS:
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
      
      private function activateMechTeaseAnimation() : void
      {
         if(dataM.playingVSComputer)
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
            case BMMechStructure.SIDE_WEAPON:
            case BMMechStructure.TOP_WEAPON:
               _loc4_ = this._mechBattleDatas[this.getMechSlot(param1)];
               _loc5_ = 0;
               _loc6_ = 0;
               switch(param2)
               {
                  case "xAxisFront":
                     _loc5_ = 5;
                     break;
                  case "xAxisBack":
                     _loc5_ = -5;
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
         if(_loc5_.mechView == null)
         {
            return;
         }
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
            if(!dataM.newVisualEffects)
            {
               effectsM.createExplosion(_loc16_,_loc15_.x + _loc11_,_loc15_.y,50,30,20,2,7,2,this.holder_effects);
            }
         }
         if(param4)
         {
            soundM.createSound(_loc10_,1);
         }
         this.createGetHitSound();
         if(dataM.getInterfacePlayerID(param1) == 2)
         {
            if(this.makeSpecialGetHitSoundsForOpponent())
            {
               _loc9_ = Math.ceil(Math.random() * 3);
               if(_loc9_ <= 2)
               {
                  _loc9_ = Math.ceil(Math.random() * 4);
                  soundM.createSound("godModeAngry" + _loc9_,1);
               }
            }
         }
      }
      
      private function makeSpecialGetHitSoundsForOpponent() : Boolean
      {
         return this.isOpponentSpecialBoss();
      }
      
      public function isOpponentSpecialBoss(param1:uint = 0) : Boolean
      {
         if(isFightingClanBoss)
         {
            return true;
         }
         return this.doesOpponentHasNoneMovableTorso(param1);
      }
      
      public function doesOpponentHasNoneMovableTorso(param1:uint = 0) : Boolean
      {
         var _loc2_:BMItemData = null;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMMechBattleData = null;
         if(param1 > 0)
         {
            _loc3_ = dataM.getPlayerItemData(dataM.player2PlayerID,param1);
            _loc2_ = dataM.itemsDB[_loc3_.itemID];
         }
         else
         {
            _loc4_ = this._mechBattleDatas[this.getMechSlot(dataM.player2PlayerID)];
            _loc3_ = dataM.getPlayerItemData(dataM.player2PlayerID,_loc4_.mechStructure.torso);
            _loc2_ = dataM.itemsDB[_loc3_.itemID];
         }
         return dataM.isNoneMovableTorso(_loc2_.itemID);
      }
      
      private function activateGetHitSounds(param1:Number) : void
      {
         this._getHitSoundsHandler = true;
         if(dataM.generalSpeedRatio == 2)
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
               effectsM.createSparksMC(BMScreensManager.SCR_BATTLE,this._bulletShellsGrp,this._bulletShellsXPos,this._bulletShellsYPos,1,1,30,this._bulletShellsDirection,"",true);
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
         var _loc6_:Number = NaN;
         var _loc7_:BMMechView = null;
         var _loc8_:Boolean = false;
         var _loc9_:Number = NaN;
         var _loc10_:BMReplayStatus = null;
         var _loc11_:Boolean = false;
         var _loc12_:BMReplayStatus = null;
         var _loc13_:Number = NaN;
         var _loc14_:uint = 0;
         var _loc15_:BMMechBattleData = null;
         var _loc16_:BMPlayerItemData = null;
         var _loc17_:BMItemData = null;
         var _loc18_:Object = null;
         var _loc19_:uint = 0;
         var _loc20_:String = null;
         var _loc21_:BMPlayerItemData = null;
         var _loc22_:BMItemData = null;
         if(this._clientDisconnected)
         {
            return;
         }
         if(this._replayActionCooldown > 0)
         {
            this._replayActionCooldownHandler = true;
            return;
         }
         if(dataM.battle_replayData.actions[this._replayActionSlot] == null)
         {
            _loc9_ = 1;
            _loc10_ = dataM.battle_replayData.status1[this._replayActionSlot - 1];
            if(_loc10_.HP <= 0)
            {
               _loc9_ = 2;
            }
            screensM.screenConfirmation.displayQuestionOrNotification("replayEnded_battleOver",_loc9_,-1);
            return;
         }
         _loc1_ = dataM.battle_replayData.actions[this._replayActionSlot];
         ++this._replayActionSlot;
         _loc2_ = this._replayActionSlot / (dataM.battle_replayData.actions.length - 1);
         screensM.screenBattleInterfaceTop.replayBar.setFill(_loc2_,true);
         if(_loc1_.actionName != "quit")
         {
            _loc11_ = dataM.getInterfacePlayerID(this._currentPlayerID) != _loc1_.playerNumber;
            if(_loc11_)
            {
               this.energyRegenerationLocallySub();
            }
            this.resetBattleTurnDataLocally("playReplayAction");
            _loc13_ = 1;
            while(_loc13_ <= 2)
            {
               _loc5_ = dataM.playersData[dataM["player" + _loc13_ + "PlayerID"]];
               _loc12_ = dataM.battle_replayData["status" + _loc13_][this._replayActionSlot];
               _loc14_ = _loc5_.selectedMechID;
               if(_loc1_.actionName == "switchMech")
               {
                  if(_loc1_.playerNumber == _loc13_)
                  {
                     _loc14_ = _loc1_.mechID;
                     this._battleTurnData.set_selectedMechID(_loc13_,_loc14_);
                  }
               }
               _loc15_ = this._mechBattleDatas[dataM["player" + _loc13_ + "PlayerID"] + "_" + _loc14_];
               if(_loc15_.dataSetByReplay == false)
               {
                  _loc15_.HP = _loc15_.HPMax;
                  _loc15_.energyMax = _loc12_.energy;
                  _loc15_.energy = _loc15_.energyMax;
                  _loc15_.bulletsMax = _loc12_.bullets;
                  _loc15_.bullets = _loc15_.bulletsMax;
                  _loc15_.rocketsMax = _loc12_.rockets;
                  _loc15_.rockets = _loc15_.rocketsMax;
                  _loc15_.resist1 = _loc12_.resist1;
                  _loc15_.resist2 = _loc12_.resist2;
                  _loc15_.resist3 = _loc12_.resist3;
                  _loc15_.dataSetByReplay = true;
               }
               this._battleTurnData.set_AP(_loc13_,_loc12_.AP);
               this._battleTurnData.set_step(_loc13_,_loc12_.step);
               this._battleTurnData.set_HP(_loc13_,_loc12_.HP,_loc14_);
               this._battleTurnData.set_heat(_loc13_,_loc12_.heat,_loc14_);
               this._battleTurnData.set_energy(_loc13_,_loc12_.energy,_loc14_);
               this._battleTurnData.set_bullets(_loc13_,_loc12_.bullets,_loc14_);
               this._battleTurnData.set_rockets(_loc13_,_loc12_.rockets,_loc14_);
               this._battleTurnData.set_shieldActive(_loc13_,_loc12_.shield,_loc14_);
               this._battleTurnData.set_resist1(_loc13_,_loc12_.resist1,_loc14_);
               this._battleTurnData.set_resist2(_loc13_,_loc12_.resist2,_loc14_);
               this._battleTurnData.set_resist3(_loc13_,_loc12_.resist3,_loc14_);
               _loc3_ = this.getMechSlot(dataM["player" + _loc13_ + "PlayerID"]);
               _loc4_ = this._mechBattleDatas[_loc3_];
               if(this._currentPlayerInterfacePlayerID == _loc13_)
               {
                  if(_loc1_.actionName != "deactivateDrone" && _loc12_.drone == false && this._battleTurnData.get_droneActive(_loc13_))
                  {
                     _loc16_ = dataM.getPlayerItemData(dataM["player" + _loc13_ + "PlayerID"],_loc4_.mechStructure.drone);
                     _loc17_ = dataM.itemsDB[_loc16_.itemID];
                     _loc18_ = dataM.animationDB[_loc17_.animation];
                     _loc19_ = this.DELAY_NEW_ACTION_FRAMES_FIRE;
                     if(_loc18_.effectType == "chargeProjectile")
                     {
                        _loc19_ += 40;
                     }
                     _loc19_ = Math.ceil(_loc19_ * 0.7);
                     if(dataM.generalSpeedRatio == 2)
                     {
                        _loc19_ = Math.ceil(_loc19_ / 2);
                     }
                     _loc4_.autoDeactivateDroneInXFrames(_loc19_);
                  }
               }
               this._battleTurnData.set_droneActive(_loc13_,_loc12_.drone);
               _loc4_.currentStepCode = _loc12_.step;
               _loc13_++;
            }
            if(_loc11_)
            {
               this.activateNextBattlePhase("turn_endTurnSuccess",{
                  "delayEndTurn":false,
                  "swapPlayersOnly":true
               });
            }
            _loc13_ = 1;
            while(_loc13_ <= 2)
            {
               _loc12_ = dataM.battle_replayData["status" + _loc13_][this._replayActionSlot];
               if(_loc13_ == this._currentPlayerInterfacePlayerID)
               {
                  _loc6_ = _loc12_.step;
               }
               _loc13_++;
            }
         }
         this.refreshMechCodeStepMarker(1);
         this.refreshMechCodeStepMarker(2);
         _loc5_ = dataM.playersData[this._currentPlayerID];
         _loc3_ = this.getMechSlot(this._currentPlayerID);
         _loc4_ = this._mechBattleDatas[_loc3_];
         _loc7_ = _loc4_.mechView;
         _loc8_ = false;
         if(_loc1_.actionName != "shutDown" && _loc7_.shutDownActive)
         {
            --this._replayActionSlot;
            _loc7_.deactivateShutdown(this.playReplayAction);
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
                  _loc20_ = _loc1_.equipmentType;
                  if(_loc1_.equipmentID > 0)
                  {
                     _loc20_ += _loc1_.equipmentID;
                  }
                  _loc21_ = dataM.getPlayerItemData(this._currentPlayerID,_loc4_.mechStructure[_loc20_]);
                  _loc22_ = dataM.itemsDB[_loc21_.itemID];
                  if(_loc22_.animation.substr(0,5) == "stomp")
                  {
                     this._replayActionCooldown += 7;
                  }
                  else if(_loc22_.animation.substr(0,5) == "sword")
                  {
                     this._replayActionCooldown += 7;
                  }
                  break;
               case "moveMechToStep":
                  this.activateNextBattlePhase("action_moveMechToStepSuccess",{
                     "motionType":_loc1_.motionType,
                     "targetStep":_loc6_
                  });
                  break;
               case "opponentSwitchMechAfterLosingMech":
                  _loc8_ = true;
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
                  screensM.screenBattle.activateNextBattlePhase("action_teleportSuccess",{"targetStep":_loc6_});
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
            this.specialAbilitiesAnnouncerHandler(_loc1_.specialAbilities);
         }
         if(_loc8_)
         {
            this.playReplayAction();
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
         var _loc1_:uint = 0;
         screensM.screenBattleInterfaceTop.btnQuit.disableMe();
         _loc1_ = 0;
         if(dataM.gameSubType == BMDataManager.GAME_SUB_TYPE_PVP_BOT)
         {
            _loc1_ = dataM.computerBattleID;
         }
         remoteM.battle_surrender(_loc1_);
      }
      
      public function surrenderSuccess() : void
      {
         var _loc1_:Boolean = false;
         if(BattleTypeResolver.isBattleOnServer)
         {
            if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
            {
               this.resetBattleEndedPlayerMechStats();
               this.updateBattleEndedPlayerMechStats();
            }
         }
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         _loc1_ = false;
         sendEndBattleAnalyticsEvent(this._battleResult);
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && dataM.battle_inBattleInvitation == false)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            screensM.addScreen(BMScreensManager.SCR_LADDER_STATUS);
            screensM.screenLadderStatus.refreshScreen();
         }
         else if(this._hiddenBaseMission)
         {
            screensM.screenMissionBaseMap.abortingMission();
         }
         else
         {
            this.closeScreenSuccess();
         }
      }
      
      private function enableTopInterfaceButtons() : void
      {
         screensM.screenBattleInterfaceTop.btnQuit.visible = true;
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL_PVE)
         {
            screensM.screenBattleInterfaceTop.btnQuit.visible = false;
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
      
      private function doesPendingSinglePlayerSocketCallExist() : Boolean
      {
         var _loc1_:Boolean = false;
         return !this._clientDisconnected && this._socketActionAllowed && this._singlePlayerActions[this._singlePlayerActionSlot] != null;
      }
      
      private function socketCallsHandler() : void
      {
         var _loc1_:Object = null;
         if(this._clientDisconnected)
         {
            return;
         }
         if(BattleTypeResolver.isBattleOnServer && this._waitingForMechToBeDestroyed == false)
         {
            this._LASTsocketActionAllowed = this._socketActionAllowed;
            if(this._socketActionAllowed)
            {
               remoteM.socketM.excecuteBattleCall();
            }
            return;
         }
         if(this._socketActionAllowed == false)
         {
            return;
         }
         if(this._singlePlayerActions[this._singlePlayerActionSlot] == null)
         {
            return;
         }
         _loc1_ = this._singlePlayerActions[this._singlePlayerActionSlot];
         ++this._singlePlayerActionSlot;
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
               if(this._skipNextSocketCallsHandlerEnbaleInterface)
               {
                  this._skipNextSocketCallsHandlerEnbaleInterface = false;
               }
               else
               {
                  this.enableInterface("socketCallsHandler VS computer");
               }
            }
            else
            {
               this.disableInterface("socketCallsHandler VS computer");
               this.hideInterface(false,false,"socketCallsHandler VS computer");
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
         if(param1)
         {
         }
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
         if(this._reEnableBottomInterface == false)
         {
            return;
         }
         this._interfaceEnabled = true;
         screensM.screenBattleInterfaceBottom.showInterface("battle checkForReEnablingBottomInterface");
         screensM.screenBattleInterfaceBottom.enableInterface("battle checkForReEnablingBottomInterface");
         this._reEnableBottomInterface = false;
         this._skipStartNewActionEnbaleInterface = true;
      }
      
      private function singlePlayerCheckForReEnablingInterface() : Boolean
      {
         var _loc1_:Boolean = false;
         _loc1_ = false;
         if(dataM.playingVSComputer)
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
            case BMSinglePlayerManager.BATTLE_TYPE_REGULAR:
            case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
               break;
            case BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS:
               if(dataM.clientRunningLocally == false)
               {
                  return;
               }
               break;
            default:
               return;
         }
         _loc1_ = 9999;
         _loc4_ = 9999;
         var _loc8_:BMPlayerData = dataM.playersData[dataM.player2PlayerID];
         _loc9_ = this.getMechSlot(dataM.player2PlayerID);
         _loc10_ = this._mechBattleDatas[_loc9_];
         _loc16_ = true;
         if(mouseY <= 108)
         {
            _loc16_ = false;
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_EMOTES))
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
                              _loc22_ = new Point(mouseX,mouseY);
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
                                          _loc32_ = BMMechStructure.SIDE_WEAPON;
                                          _loc33_ = 4;
                                          break;
                                       case 2:
                                          _loc32_ = BMMechStructure.TOP_WEAPON;
                                          _loc33_ = 2;
                                          break;
                                       case 3:
                                          _loc32_ = BMMechStructure.LEG;
                                          _loc33_ = 1;
                                          if(this._ignoreLegTooltip)
                                          {
                                             _loc34_ = true;
                                          }
                                          break;
                                       case 4:
                                          _loc32_ = BMMechStructure.DRONE;
                                          _loc33_ = 1;
                                    }
                                    if(_loc34_ == false)
                                    {
                                       _loc35_ = 1;
                                       while(_loc35_ <= _loc33_)
                                       {
                                          switch(_loc32_)
                                          {
                                             case BMMechStructure.SIDE_WEAPON:
                                             case BMMechStructure.TOP_WEAPON:
                                                _loc19_ = _loc32_ + _loc35_;
                                                _loc20_ = _loc32_ + _loc35_;
                                                break;
                                             case BMMechStructure.LEG:
                                                _loc19_ = BMMechStructure.LEG;
                                                _loc20_ = "leg1";
                                                break;
                                             case BMMechStructure.DRONE:
                                                _loc19_ = BMMechStructure.DRONE;
                                                _loc20_ = BMMechStructure.DRONE;
                                          }
                                          if(_loc10_.mechStructure[_loc19_] > 0)
                                          {
                                             if(_loc19_ != BMMechStructure.DRONE || _loc19_ == BMMechStructure.DRONE && _loc10_.droneActive)
                                             {
                                                if(_loc19_ == BMMechStructure.DRONE)
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
                              case BMMechStructure.SIDE_WEAPON:
                              case BMMechStructure.TOP_WEAPON:
                                 _loc19_ = this._opponentMechTooltipType + this._opponentMechTooltipEquipmentID;
                                 _loc20_ = this._opponentMechTooltipType + this._opponentMechTooltipEquipmentID;
                                 break;
                              case BMMechStructure.LEG:
                                 _loc19_ = BMMechStructure.LEG;
                                 _loc20_ = "leg1";
                                 break;
                              case BMMechStructure.DRONE:
                                 _loc19_ = BMMechStructure.DRONE;
                                 _loc20_ = BMMechStructure.DRONE;
                           }
                           _loc11_.removeAllItemsStaticGlow();
                           _loc10_.removeDroneStaticGlow();
                           if(_loc20_ == BMMechStructure.DRONE)
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
         if(_loc2_ != null)
         {
            return;
         }
         if(this._opponentMechTooltipType == "")
         {
            if(this._lastOpponentMechTooltipType != "")
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
            return;
         }
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
      
      public function switchMechClicked(param1:Number) : void
      {
         this.disableInterface("switchMechClicked");
         if(BattleTypeResolver.isBattleOnServer)
         {
            remoteM.battle_switchMech(param1);
         }
         else
         {
            this.switchMechLocally(param1);
         }
      }
      
      public function switchMechLocally(param1:uint) : void
      {
         this.addSinglePlayerAction("switchMech",param1,"");
      }
      
      private function switchMechLocallySub(param1:uint) : void
      {
         this._battleTurnData.set_AP(this._currentPlayerInterfacePlayerID,this._battleTurnData.get_AP(this._currentPlayerInterfacePlayerID) - this.AP_COST_REGULAR_ACTION);
         this._battleTurnData.set_selectedMechID(this._currentPlayerInterfacePlayerID,param1);
         this.addBattleReportData(0,0);
         this.addBattleReportReplayAction(BMReplayAction.createSwitchMechAction(param1));
         this.disableInterface("switchMechClicked");
         this.switchMechSuccess(param1);
      }
      
      public function switchMechSuccess(param1:uint, param2:Object = null) : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         this.setSocketAllowedStatus(false,"switchMechSuccess");
         this._lastAction = "switchMech";
         _loc3_ = dataM.playersData[this._currentPlayerID];
         _loc4_ = this.getMechSlot(this._currentPlayerID);
         _loc5_ = this._mechBattleDatas[_loc4_];
         if(_loc5_ != null)
         {
            if(_loc5_.mechView != null)
            {
               if(_loc5_.drone != null)
               {
                  _loc5_.drone.removeMe();
                  _loc5_.drone = null;
               }
               _loc5_.mechView.removeMe();
               _loc5_.mechView = null;
            }
         }
         if(_loc3_.selectedMechID != param1)
         {
            this.spawnMech(this._currentPlayerID,param1);
         }
         ++_loc3_["switchMech" + param1 + "Uses"];
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
         _loc3_ = dataM["player" + param1 + "Profile"];
         _loc4_ = dataM.playersData[param1];
         _loc5_ = this.getMechSlot(param1);
         _loc6_ = this._mechBattleDatas[_loc5_];
         if(!BattleTypeResolver.isBattleOnServer)
         {
            this._battleTurnData.set_step(dataM.getInterfacePlayerID(param1),_loc6_.currentStepCode);
         }
         _loc7_ = this._battleTurnData.get_step(dataM.getInterfacePlayerID(param1));
         _loc4_.selectedMechID = param2;
         if((BattleTypeResolver.isCampaign || BattleTypeResolver.isRaid) && param1 == dataM.player1PlayerID)
         {
            _loc3_.missionCurrentMechID = param2;
         }
         _loc5_ = this.getMechSlot(param1);
         _loc6_ = this._mechBattleDatas[_loc5_];
         _loc6_.currentStepCode = _loc7_;
         _loc6_.currentStepVisual = _loc7_;
         _loc6_.resetAlreadyFired();
         this.createMechView(param1,param2,true);
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
         this.setSocketAllowedStatus(false,"spawnMech");
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
                  this.setSocketAllowedStatus(true,"resumeBattleAfterSpawningHandler");
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
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP && screensM.isScreenOpened(BMScreensManager.SCR_VS) == false)
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
            if(BattleTypeResolver.isBattleOnServer)
            {
               remoteM.battle_taunt(param1);
            }
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
            _loc11_[1].push(getSpecificText("taunt_welcome1"));
            _loc11_[1].push(getSpecificText("taunt_welcome2"));
            _loc11_[1].push(getSpecificText("taunt_welcome3"));
            _loc11_[2].push(getSpecificText("taunt_gg1"));
            _loc11_[2].push(getSpecificText("taunt_gg2"));
            _loc11_[2].push(getSpecificText("taunt_gg3"));
            _loc11_[3].push(getSpecificText("taunt_lol1"));
            _loc11_[3].push(getSpecificText("taunt_lol2"));
            _loc11_[3].push(getSpecificText("taunt_lol3"));
            _loc11_[4].push(getSpecificText("taunt_hoYea1"));
            _loc11_[4].push(getSpecificText("taunt_hoYea2"));
            _loc11_[4].push(getSpecificText("taunt_hoYea3"));
            _loc11_[5].push(getSpecificText("taunt_boring1"));
            _loc11_[5].push(getSpecificText("taunt_boring2"));
            _loc11_[5].push(getSpecificText("taunt_boring3"));
            _loc11_[6].push(getSpecificText("taunt_notFair1"));
            _loc11_[6].push(getSpecificText("taunt_notFair2"));
            _loc11_[6].push(getSpecificText("taunt_notFair3"));
            _loc11_[7].push(getSpecificText("taunt_comeOn1"));
            _loc11_[7].push(getSpecificText("taunt_comeOn2"));
            _loc11_[7].push(getSpecificText("taunt_comeOn3"));
            _loc11_[7].push(getSpecificText("taunt_comeOn4"));
            _loc11_[7].push(getSpecificText("taunt_comeOn5"));
            _loc11_[7].push(getSpecificText("taunt_comeOn6"));
            _loc11_[7].push(getSpecificText("taunt_comeOn7"));
            _loc11_[7].push(getSpecificText("taunt_comeOn8"));
            _loc11_[7].push(getSpecificText("taunt_comeOn9"));
            _loc11_[8].push(getSpecificText("taunt_threat1"));
            _loc11_[8].push(getSpecificText("taunt_threat2"));
            _loc11_[8].push(getSpecificText("taunt_threat3"));
            _loc10_ = RandomUtils.chooseRandomIndex(_loc11_[param2]);
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
         var _loc3_:BMPlayerData = null;
         var _loc4_:Array = null;
         var _loc5_:BMPlayerItemData = null;
         this._battleReport = new Object();
         if(tutorialM.isTutorialActive() || dataM.playingVSComputer == false)
         {
            return;
         }
         this._battleReport.computerEquipment = new Array();
         _loc1_ = dataM.playersData[dataM.player2PlayerID];
         _loc2_ = 0;
         while(_loc2_ < _loc1_.items.length)
         {
            _loc5_ = _loc1_.items[_loc2_];
            this._battleReport.computerEquipment.push({
               "itemID":_loc5_.itemID,
               "equipmentType":_loc5_.equipmentType,
               "equipped":_loc5_.equipped,
               "equipmentID":_loc5_.equipmentID
            });
            _loc2_++;
         }
         this._battleReport.difficultyMultiplier = dataM.computerDifficultyMultiplier;
         _loc3_ = dataM.playersData[dataM.player1PlayerID];
         _loc4_ = [1];
         switch(dataM.battleMechsPerPlayer)
         {
            case 2:
               _loc4_ = [1,2];
               if(_loc3_.selectedMechID == 2)
               {
                  _loc4_ = [2,1];
               }
               break;
            case 3:
               _loc4_ = [1,2,3];
               if(_loc3_.selectedMechID == 2)
               {
                  _loc4_ = [2,1,3];
               }
               else if(_loc3_.selectedMechID == 3)
               {
                  _loc4_ = [3,1,2];
               }
         }
         this._battleReport.pickedMechs = _loc4_;
         this._battleReport.playerDamage = new Array();
         this._battleReport.opponentDamage = new Array();
         this._battleReport.replay = "";
         this._battleReport.status1 = "";
         this._battleReport.status2 = "";
         if(this._battleTurnData == null)
         {
            this.resetBattleTurnDataLocally(null);
         }
         this.addBattleReportStatuses();
      }
      
      public function getBattleReportNumberOfShotsFiredByComputer() : int
      {
         if(this._battleReport != null && this._battleReport.opponentDamage != null)
         {
            return this._battleReport.opponentDamage.length;
         }
         return 0;
      }
      
      private function addBattleReportData(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         if(tutorialM.isTutorialActive() || dataM.playingVSComputer == false)
         {
            return;
         }
         if(this._currentPlayerID == dataM.player1PlayerID)
         {
            this._battleReport.playerDamage.push({
               "playerItemID":param1,
               "damage":param2
            });
         }
         else
         {
            _loc3_ = 0;
            if(param1 > 0)
            {
               _loc3_ = dataM.getPlayerItemData(dataM.player2PlayerID,param1).itemID;
            }
            this._battleReport.opponentDamage.push({
               "itemID":_loc3_,
               "damage":param2
            });
         }
      }
      
      private function addBattleReportReplayAction(param1:BMReplayAction) : *
      {
         if(tutorialM.isTutorialActive() || dataM.playingVSComputer == false)
         {
            return;
         }
         if(this._currentPlayerID == dataM.player1PlayerID)
         {
            param1.playerNumber = 1;
         }
         else
         {
            param1.playerNumber = 2;
         }
         if(this._battleReport.replay.length > 0)
         {
            this._battleReport.replay += "_";
         }
         this._battleReport.replay += param1.getReplayString(this._localSpecialAbilitiesActivated);
         this.specialAbilitiesAnnouncerHandler(this._localSpecialAbilitiesActivated);
         this._localSpecialAbilitiesActivated = new Array();
         this.addBattleReportStatuses();
      }
      
      private function addBattleReportStatuses() : *
      {
         this._battleReport.status1 += this._battleTurnData.get_replayStatus(1).getProtocolString();
         this._battleReport.status2 += this._battleTurnData.get_replayStatus(2).getProtocolString();
      }
      
      public function titleCompleteAnimationIsDone() : void
      {
      }
      
      public function titleLetterAnimationIsDone() : void
      {
      }
      
      public function playLevelMusic(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(this._currentMusicTrack >= dataM.musicDB.length)
         {
            this._currentMusicTrack = 0;
         }
         _loc2_ = dataM.musicDB[this._currentMusicTrack].base;
         _loc3_ = dataM.musicDB[this._currentMusicTrack].loop;
         soundM.createMusic(_loc2_,_loc3_);
      }
      
      public function increaseMusicTrack() : void
      {
         ++this._currentMusicTrack;
      }
      
      private function keyboardOutput(param1:Object) : void
      {
         if(screensM.secondaryBattleScreensOpened)
         {
            return;
         }
         if(this.getPlayerLostID() != 0)
         {
            return;
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
         {
            if(param1.enter)
            {
               if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_EMOTES))
               {
                  screensM.screenBattleInterfaceEmotes.chatEnterClicked();
               }
            }
         }
         if(this._socketActionAllowed && this._currentPlayerID == dataM.player1PlayerID)
         {
            if(param1.debuggerActivated)
            {
               screensM.addScreen(BMScreensManager.SCR_DEBUGGER);
            }
         }
      }
      
      public function applyDurabilityChangesAtTheEndOfBattle(param1:Array) : void
      {
         this._durabilityChanges = param1;
      }
      
      public function optionsClicked() : void
      {
         screensM.addScreen(BMScreensManager.SCR_BATTLE_OPTIONS);
         screensM.screenBattleOptions.refreshScreen();
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
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
      
      public function getCurrentPlayerDrone() : MovieClip
      {
         var _loc2_:String = null;
         var _loc3_:BMMechBattleData = null;
         var _loc1_:BMPlayerData = dataM.playersData[this._currentPlayerID];
         _loc2_ = this.getMechSlot(this._currentPlayerID);
         _loc3_ = this._mechBattleDatas[_loc2_];
         return _loc3_.drone.droneGrp;
      }
      
      public function get isFinishMoveActive() : Boolean
      {
         return this._allowFinishMoves || this._finishMoveID > 0;
      }
      
      public function showPostFinishMoveAnnouncer() : *
      {
         screensM.screenBattleInterfaceTop.showAnnouncerText(getSpecificText("announcer_spectacular"),16777215,2,1);
      }
   }
}

