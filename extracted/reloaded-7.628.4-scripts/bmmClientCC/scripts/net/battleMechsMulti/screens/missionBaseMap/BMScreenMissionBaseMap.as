package net.battleMechsMulti.screens.missionBaseMap
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import net.battleMechsMulti.data.BMLevelUpData;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.gameOfWhales.BMGameOfWhalesManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.managers.skills.BMMechStatsResolver;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMChatBubble;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMapMech;
   import net.battleMechsMulti.mobiles.BMMapObject;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.autoplayAndGameSpeedPanel.BMAutoplayAndGameSpeedPanel;
   import net.battleMechsMulti.mobiles.baseMapAssets.BMBaseMapDamageFloor;
   import net.battleMechsMulti.mobiles.baseMapAssets.BMBaseMapEnemy;
   import net.battleMechsMulti.mobiles.baseMapAssets.BMBaseMapShot;
   import net.battleMechsMulti.mobiles.baseMapAssets.BMBaseMapTurret;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.chat.BMMiniChat;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossData;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.BMScreenBuyConfirmation;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   import net.battleMechsMulti.utils.TextUtils;
   import net.tacticsoft.utils.RandomUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol950")]
   public class BMScreenMissionBaseMap extends BMBaseScreen
   {
      
      private static const MISSION_COMPLETE_ANIM_NONE:String = "none";
      
      private static const MISSION_COMPLETE_ANIM_WAIT1:String = "wait1";
      
      private static const MISSION_COMPLETE_ANIM_IN:String = "in";
      
      private static const MISSION_COMPLETE_ANIM_OUT:String = "out";
      
      private static const MISSION_COMPLETE_ANIM_WAIT2:String = "wait2";
      
      public static const UPGRADE_HP:String = "HP";
      
      public static const UPGRADE_HEAT:String = "HT";
      
      public static const UPGRADE_ENERGY:String = "EN";
      
      private static const PLAYER_IMMUNITY_TO_MECH_ENCOUNTERS_COOLDOWN_FRAMES:uint = 100;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcFloorHolder:Sprite;
      
      public var mcBarsHolder:Sprite;
      
      public var mcInterfaceEffectsHolder:Sprite;
      
      public var mcMapEffectsHolder:MovieClip;
      
      public var mcMapHolder:MovieClip;
      
      public var mcPickupsMouseHitArea:Sprite;
      
      public var mcMapHitArea:Sprite;
      
      public var btnAbort:BMBasicButton;
      
      public var btnAbortWithText:BMBasicButton;
      
      public var mcSaving:MovieClip;
      
      public var mcMechStats:MovieClip;
      
      public var mcUpgrades:MovieClip;
      
      public var mcLoot:MovieClip;
      
      public var mcMapArrow:MovieClip;
      
      public var mcCompleted1:MovieClip;
      
      public var mcCompleted2:MovieClip;
      
      public var mcTutorialArrow_usePickup:MovieClip;
      
      public var mcChatBubble:BMChatBubble;
      
      public var mcAutoplayAndGameSpeedPanel:BMAutoplayAndGameSpeedPanel;
      
      public var miniChat:BMMiniChat;
      
      private var mcFloor:Sprite;
      
      private var playerMech:BMMapMech;
      
      private var bossMech:BMMapMech;
      
      private var mapMarker:MovieClip;
      
      private var _firstRefresh:Boolean = true;
      
      private var _mapObjects:Object;
      
      private var _dirts:Array;
      
      private var _map:Array;
      
      private var _mapOrigin:Array;
      
      private var _mapTurrets:Array;
      
      private var _mapShots:Array;
      
      private var _shotsCounter:uint = 0;
      
      private var _mapEnemyMechViews:Array;
      
      private var _mapEnemyMechDatas:Array;
      
      private var _mapDamageFloors:Array;
      
      private var _mapPickups:Array;
      
      private var _interfacePickups:Array;
      
      private var _interfacePickupsAnimationActive:Boolean;
      
      private var _halfMapWidth:Number;
      
      private var _halfMapHeight:Number;
      
      private var _targetBattleSubType:String = "";
      
      private var _mapRows:uint = 0;
      
      private var _playerPosition:uint = 0;
      
      private var _playerRow:uint = 0;
      
      private var _playerColumn:uint = 0;
      
      private var _playerLastRow:uint = 0;
      
      private var _playerLastColumn:uint = 0;
      
      private var _targetPosition:uint = 0;
      
      private var _targetRow:uint = 0;
      
      private var _targetColumn:uint = 0;
      
      private var _walkingActive:Boolean;
      
      private var _walkingPath:Array;
      
      private var _walkingPathSlot:uint;
      
      private var _walkingFrameCounter:uint;
      
      private var _walkingTotalFrameCounter:uint;
      
      private var _walkingDirectionRow:Number;
      
      private var _walkingDirectionColumn:Number;
      
      private var _walkingFinalInteractionRow:Number;
      
      private var _walkingFinalInteractionColumn:Number;
      
      private var _destroyingPlayerActive:Boolean;
      
      private var _destroyingPlayerFrameCounter:uint;
      
      private var _createFlyingRewardXPValue:uint;
      
      private var _createFlyingRewardGoldValue:uint;
      
      private var _createFlyingRewardRow:uint;
      
      private var _createFlyingRewardColumn:uint;
      
      private var _createUpgrade:String;
      
      private var _createUpgradeRow:uint;
      
      private var _createUpgradeColumn:uint;
      
      private var _saving:Boolean = false;
      
      private var _savingHandler:Boolean = false;
      
      private var _playerEntryHandler:Boolean = false;
      
      private var _playerEntryBlowGate:Boolean;
      
      private var _playerEntryGateSize:uint;
      
      private var _playerEntryFrameCounter:uint;
      
      private var _playerLostConfirmed:Boolean = false;
      
      private var _floorSquares:Array;
      
      private var _lastRollOverredPickupSlot:Number = -1;
      
      private var _missionCompleted:Boolean;
      
      private var _missionCompletedFrameCounter:uint;
      
      private var _missionCompletedStatus:String;
      
      private var _missionCompletedGotRewardsData:Boolean;
      
      private var _mechStatsOriginXPos:Number;
      
      private var _upgradesOriginXPos:Number;
      
      private var _lootOriginXPos:Number;
      
      private var _interfaceMotionFrameCounter:uint;
      
      private var _tutorialForceMovement:Boolean;
      
      private var _tutorialForceMovementRow:uint;
      
      private var _tutorialForceMovementColumn:uint;
      
      private var _mapArrowHandler:Boolean;
      
      private var _mapArrowFrameCounter:uint;
      
      private var _mapArrowDelayFrames:uint;
      
      private var _flyingRewards:Array = new Array();
      
      private var _halfStageWidth:Number;
      
      private var _firstUpgradeTutorial:Boolean;
      
      private var _playerNeedsToReviveBlock:Boolean;
      
      private var _lootBoxesArray:Array;
      
      private var _lootBoxSparks:Array = new Array();
      
      private var _availableUpgrades:Array;
      
      private var mcWallHorizontalUp:Sprite;
      
      private var mcWallHorizontalDownLeft:Sprite;
      
      private var mcWallHorizontalDownRight:Sprite;
      
      private var mcWallVerticalLeft:Sprite;
      
      private var mcWallVerticalRight:Sprite;
      
      private var mcGate:Sprite;
      
      private var _abortMissionDueToCheating_stopOnEnterFrame:Boolean = false;
      
      private var _abortMissionDueToCheating_functionTriggered:Boolean = false;
      
      private var _missionCompleted1TragetYPos:Number;
      
      private var _missionCompleted2TragetYPos:Number;
      
      private var _bossStompAnimationActive:Boolean = false;
      
      private var _bossMapObjectName:String;
      
      private var _chatBubbleXPos:Number = 0;
      
      private var _chatBubbleYPos:Number = 0;
      
      private var _triggerReviveCancelledAfterSaving:Boolean = false;
      
      private var _triggerReviveClickedAfterSaving:Boolean = false;
      
      private var _fromBattle:Boolean;
      
      private var _fromPackages:Boolean;
      
      private var _walkingFrames:uint;
      
      private var _currentMovementWalkingFrames:uint;
      
      private var _autopilotOptionsExhaustedForMission:Boolean;
      
      private var _autopilotDelayFramesCounter:uint = 0;
      
      private var _startingBattle:Boolean = false;
      
      private var _energyRegenerationIconOriginXPos:Number;
      
      private var _energyRegenerationTextOriginXPos:Number;
      
      private var _heatCoolingIconOriginXPos:Number;
      
      private var _heatCoolingTextOriginXPos:Number;
      
      private var _playerImmunityToMechEnouctersCooldown:uint;
      
      private const LIFE_X_JUMP:uint = 40;
      
      private const SQUARE_SIZE:uint = 75;
      
      private var WALKING_FRAMES_REGULAR_SPEED:uint = 36;
      
      private var WALKING_FRAMES_DOUBLE_SPEED:uint = 18;
      
      private const INTERFACE_PICKUPS_X_JUMP:uint = 40;
      
      private const INTERFACE_PICKUPS_X_MAX:uint = 205;
      
      private const INTERFACE_X_JUMP:uint = 300;
      
      private const VOLUME_RATIO:Number = 0.3;
      
      private const AUTOPILOT_IMPORTANT_ACTION_DELAY_FRAMES:uint = 50;
      
      private const AUTOPILOT_MAX_HP_RATIO_REQUIRED_TO_USE_REPAIR_CRATE:Number = 0.7;
      
      private var _useMissionGameplayImprovements:Boolean = false;
      
      private var _followEnemyRow:int = -1;
      
      private var _followEnemyColumn:int = -1;
      
      private var _runHandleBattleEndedPlayerWon:Boolean = false;
      
      private var continueToNextMission:Boolean = false;
      
      private const PATROLING_MECHS_BATTLE_DISTANCE:uint = 50;
      
      private const SHOT_SPEED:uint = 5;
      
      private const SHOT_FRAMES:uint = 100;
      
      private const SHOTS_HIT_DISTANCE:uint = 30;
      
      private var _shotsForDeletion:Array = new Array();
      
      private var _playerDamageFromFloosCooldown:uint = 0;
      
      private const PLAYER_DAMAGE_FROM_FLOORS_COOLDOWN_FRAMES:uint = 3;
      
      private var _explosionChainActive:Boolean = false;
      
      private var _explosionChainCooldown:uint;
      
      private var _explosionChainTargetLocations:Object = new Object();
      
      private var _explosionChainStructuresDataForServer:Array = new Array();
      
      private var _explosionChainEnemiesDataForServer:Array = new Array();
      
      public function BMScreenMissionBaseMap()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("missionBaseMap");
         this._mechStatsOriginXPos = this.mcMechStats.x;
         this._upgradesOriginXPos = this.mcUpgrades.x;
         this._lootOriginXPos = this.mcLoot.x;
         this.mcMapArrow.mouseEnabled = false;
         this.mcMapArrow.mouseChildren = false;
      }
      
      public function refreshScreen(param1:Boolean, param2:Boolean = false) : void
      {
         this._fromBattle = param1;
         this._fromPackages = param2;
         this._useMissionGameplayImprovements = dataM.useMissionGameplayImprovements(this.storyID,dataM.myProfile.currentMissionSlot);
         if(this._useMissionGameplayImprovements && this._fromBattle)
         {
            this._playerImmunityToMechEnouctersCooldown = PLAYER_IMMUNITY_TO_MECH_ENCOUNTERS_COOLDOWN_FRAMES;
         }
         var _loc3_:Boolean = dataM.myProfile.mission_layout.length > 0;
         if(!_loc3_)
         {
            this.reloadMissionData();
            return;
         }
         dataM.trackScreenView("missionBaseMap");
         this.mcMechStats.txtHpBonus.visible = dataM.hasHpBonus();
         if(this._firstRefresh)
         {
            this.btnAbort.addEventListener(BMIntractable.HIT,this.abortClicked);
            this.btnAbortWithText.addEventListener(BMIntractable.HIT,this.abortClicked);
            this.btnAbortWithText.text = getScreenText("abort");
            this.languageUpdate();
            if(dataM.runAsMobile == false)
            {
               this.mcMapHitArea.addEventListener(MouseEvent.CLICK,this.mapHitAreaClickedForWeb);
               this.mcPickupsMouseHitArea.addEventListener(MouseEvent.CLICK,this.upgradesClickedForWeb);
            }
            this.initMiniChat();
            this.mcMapHolder.holder_dirt = new MovieClip();
            this.mcMapHolder.holder_floorSquares = new MovieClip();
            this.mcMapHolder.addChild(this.mcMapHolder.holder_floorSquares);
            this.mcMapHolder.addChild(this.mcMapHolder.holder_dirt);
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconHP,"mcHP","icon_HP");
            this.initializeBar("mcBarHP",this.mcMechStats.mcSizer_barHP,"yellow",4);
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconEnergy,"mcEnergy","icon_energy");
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconEnergyRegeneration,"mcEnergyRegeneration","icon_energyRegeneration");
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconHeat,"mcHeat","icon_heat");
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconHeatCooling,"mcHeatCooling","icon_heatCooling");
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconBullets,"mcBullets","icon_bullets");
            this.initializeBar("mcBarBullets",this.mcMechStats.mcSizer_barBullets,"yellow",4);
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconRockets,"mcRockets","icon_rockets");
            this.initializeBar("mcBarRockets",this.mcMechStats.mcSizer_barRockets,"yellow",4);
            this._energyRegenerationIconOriginXPos = this.mcMechStats.mcEnergyRegeneration.x;
            this._energyRegenerationTextOriginXPos = this.mcMechStats.txtEnergyRegeneration.x;
            this._heatCoolingIconOriginXPos = this.mcMechStats.mcHeatCooling.x;
            this._heatCoolingTextOriginXPos = this.mcMechStats.txtHeatCooling.x;
            this.initMechTabs(param1);
            this.mapMarker = externalAssetsM.getAsset("general","map_floorMarker",this.SQUARE_SIZE,this.SQUARE_SIZE,false,false);
            this.mcCompleted1.mouseEnabled = false;
            this.mcCompleted1.mouseChildren = false;
            this.mcCompleted2.mouseEnabled = false;
            this.mcCompleted2.mouseChildren = false;
            this._halfStageWidth = dataM.STAGE_WIDTH / 2;
            this._missionCompleted1TragetYPos = this.mcCompleted1.y;
            this._missionCompleted2TragetYPos = this.mcCompleted2.y;
            if(dataM.runAsMobile == false)
            {
               this.mcTutorialArrow_usePickup.mouseEnabled = false;
               this.mcTutorialArrow_usePickup.mouseChildren = false;
            }
            this._createFlyingRewardGoldValue = 0;
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this._playerLostConfirmed = false;
         this._saving = false;
         if(dataM.mission_battleEnded)
         {
            this.battleEnded();
            dataM.mission_battleEnded = false;
         }
         this.mcChatBubble.initialize();
         this.mcChatBubble.mouseEnabled = false;
         this.mcChatBubble.mouseChildren = false;
         this.setMapScale();
         this._dirts = new Array();
         this._mapPickups = new Array();
         this._interfacePickups = new Array();
         this._interfacePickups[0] = new Array();
         this._interfacePickups[1] = new Array();
         this._interfacePickupsAnimationActive = false;
         if(param1)
         {
            this.mcMechStats.x = this._mechStatsOriginXPos;
         }
         else
         {
            this.resetBattleTrackingData();
            dataM.mission_playerMechStatus = "";
            dataM.mission_playerMechDirection = "";
            if(param2 == false)
            {
               this._playerEntryHandler = true;
               this._playerEntryFrameCounter = 0;
            }
         }
         if(this._saving == false)
         {
            this.deactivateSaving(true);
         }
         this.mcMechStats.x = this._mechStatsOriginXPos - this.INTERFACE_X_JUMP;
         this.mcUpgrades.x = this._upgradesOriginXPos - this.INTERFACE_X_JUMP;
         this.mcLoot.x = this._lootOriginXPos - this.INTERFACE_X_JUMP;
         this._interfaceMotionFrameCounter = 0;
         this._autopilotOptionsExhaustedForMission = false;
         this._missionCompleted = false;
         this._createUpgrade = "";
         this._lastRollOverredPickupSlot = -1;
         this.setMissionColor();
         this._playerPosition = dataM.myProfile.mission_playerPosition;
         var _loc4_:Array = this.getRowAndColumnByPosition(this._playerPosition);
         this._playerRow = _loc4_[0];
         this._playerColumn = _loc4_[1];
         this._playerLastRow = this._playerRow;
         this._playerLastColumn = this._playerColumn;
         this._walkingActive = false;
         this._walkingPath = new Array();
         this._walkingPathSlot = 0;
         this._walkingFrameCounter = 0;
         if(param1 == false)
         {
            dataM.mission_destroyingMapObjectActive = false;
            this._destroyingPlayerActive = false;
         }
         this._mapRows = dataM.myProfile.mission_rows;
         this.mcMapHolder.holder_damageFloors = new MovieClip();
         this.mcMapHolder.addChild(this.mcMapHolder.holder_damageFloors);
         var _loc5_:uint = 0;
         while(_loc5_ <= this._mapRows + 1)
         {
            this.mcMapHolder["holder_objects" + _loc5_] = new MovieClip();
            this.mcMapHolder.addChild(this.mcMapHolder["holder_objects" + _loc5_]);
            _loc5_++;
         }
         this._firstUpgradeTutorial = false;
         if(dataM.useHiddenBaseMap == false)
         {
            if(tutorialM.isTutorialActive())
            {
               if(dataM.myProfile.currentMissionSlot == 1)
               {
                  if(dataM.myProfile.mission_upgrades.length == 1)
                  {
                     this._firstUpgradeTutorial = true;
                     this.mcTutorialArrow_usePickup.gotoAndStop("animOn");
                  }
               }
            }
         }
         this.initAutoplayAndGameSpeedPanel();
         this.resetPlayerTarget();
         this.refreshFloor();
         this.createAllMechsDefaultStats();
         this.refreshCurrentMechStats(false);
         this.refreshLootGoldAndXp();
         this.createMap(param1);
         if(this._runHandleBattleEndedPlayerWon)
         {
            this.handleBattleEnded();
         }
         this.createPlayerMech(param1,param2);
         this.createLootBoxArray();
         this.createAvailableUpgrades();
         this.showAllEnemyMechDamage();
         this._playerNeedsToReviveBlock = false;
         if(param1 == false && this.doesPlayerNeedToRevive())
         {
            this.openReviveDialog();
            this._playerNeedsToReviveBlock = true;
         }
         this.refreshTutorial();
         if(!tutorialM.isTutorialActive())
         {
            this.btnAbort.enableMe();
            this.btnAbortWithText.enableMe();
            if(dataM.isAutopilotAllowed())
            {
               this.btnAbortWithText.visible = false;
            }
            else
            {
               this.btnAbort.visible = false;
            }
         }
         else
         {
            this.btnAbort.visible = false;
            this.btnAbortWithText.visible = false;
         }
         this.mcCompleted1.visible = false;
         this.mcCompleted2.visible = false;
         this.mcCompleted1.y = -200;
         this.mcCompleted2.y = dataM.STAGE_HEIGHT + 200;
         if(dataM.useHiddenBaseMap == false)
         {
            if(dataM.chatData.useCampaignChat)
            {
               screensM.addScreen(BMScreensManager.SCR_TOP_BAR,true,BMScreenTopBarClone3);
            }
            else
            {
               screensM.addScreen(BMScreensManager.SCR_TOP_BAR);
            }
            screensM.screenTopBar.refreshScreen(param1);
            screensM.screenTopBar.enableButtons("missionBaseMap refreshScreen");
         }
         this._missionCompletedStatus = MISSION_COMPLETE_ANIM_NONE;
         this.checkIfMissionIsComplete();
      }
      
      public function doesPlayerNeedToRevive() : Boolean
      {
         return dataM.myProfile.missionMechsAlive() == 0;
      }
      
      private function languageUpdate() : void
      {
         updateTextAndFormat(this.mcMechStats.txtStats,getScreenText("stats"));
         updateTextAndFormat(this.mcUpgrades.txtUpgrades,getScreenText("upgrades"));
         updateTextAndFormat(this.mcLoot.txtLoot,getScreenText("loot"));
         updateTextAndFormat(this.mcCompleted1.txtTitle,getScreenText("missionCompleted1"));
         updateTextAndFormat(this.mcCompleted2.txtTitle,getScreenText("missionCompleted2"));
         updateTextAndFormat(this.mcSaving.txtSaving,getScreenText("saving"));
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionMap_mechStatsTitle",[this.mcMechStats.txtStats],"",this.mcMechStats);
            screensM.createMultipleTextsBitmap("missionMap_upgrades",[this.mcUpgrades.txtUpgrades],"",this.mcUpgrades);
            screensM.createMultipleTextsBitmap("missionMap_loot",[this.mcLoot.txtLoot],"",this.mcLoot);
            screensM.createMultipleTextsBitmap("missionMap_saving",[this.mcSaving.txtSaving],"",this.mcSaving);
            screensM.createMultipleTextsBitmap("missionMap_completed1",[this.mcCompleted1.txtTitle],"",this.mcCompleted1);
            screensM.createMultipleTextsBitmap("missionMap_completed2",[this.mcCompleted2.txtTitle],"",this.mcCompleted2);
         }
      }
      
      private function createIconFromSizer(param1:Sprite, param2:String, param3:String) : void
      {
         this.mcMechStats[param2] = externalAssetsM.getAsset("general",param3,param1.width,param1.height,false,false);
         this.mcMechStats[param2].x = param1.x;
         this.mcMechStats[param2].y = param1.y;
         this.mcMechStats.addChild(this.mcMechStats[param2]);
      }
      
      private function initializeBar(param1:String, param2:Sprite, param3:String, param4:uint) : void
      {
         var _loc5_:BMBar = this.mcMechStats[param1];
         _loc5_.initialize(param3,"right");
         _loc5_.addSeparateorLines(param4);
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         if(this._abortMissionDueToCheating_stopOnEnterFrame)
         {
            if(this._abortMissionDueToCheating_functionTriggered == false)
            {
               if(screensM.screenBlack.isActive() == false)
               {
                  this.abortingMission();
                  this._abortMissionDueToCheating_functionTriggered = true;
               }
            }
            return;
         }
         this.mapPickupsHandler();
         this.interfacePickupsHandler();
         this.playerWalkingHandler();
         if(this.playerMech != null && this._startingBattle == false)
         {
            this.playerMech.onEnterFrameTrigger();
         }
         if(this.bossMech != null)
         {
            this.bossMech.onEnterFrameTrigger();
         }
         this.chatBubbleHandler();
         this.destroyMapObjectHandler();
         this.destroyPlayerHandler();
         this.savingHandler();
         this.pickupsTooltipHandler();
         this.interfaceMotionHandler();
         this.playerEntryHandler();
         this.mapArrowHandler();
         this.flyingRewardsHandler();
         this.missionCompletedHandler();
         this.lootBoxSparksHandler();
         var _loc1_:Boolean = true;
         if(screensM.isScreenOpened(BMScreensManager.SCR_CONFIRMATION) || screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_RESULT) || screensM.isScreenOpened(BMScreensManager.SCR_VS) || screensM.isScreenOpened(BMScreensManager.SCR_WATCH_REWARDED_VIDEO) || screensM.isScreenOpened(BMScreensManager.SCR_BUY_CONFIRMATION) || screensM.screenBlack.isActive())
         {
            _loc1_ = false;
         }
         if(_loc1_)
         {
            this.turretsHandler();
            this.turretShotsHandler();
            this.removeShotsHandler();
            this.explosionChainHandler();
            this.enemyMechsHandler();
            this.damageFloorsHandler();
         }
         this.activateUserAutopilot();
      }
      
      private function get useAnimations() : Boolean
      {
         return dataM.useHiddenBaseMap == false;
      }
      
      private function get useSounds() : Boolean
      {
         return dataM.useHiddenBaseMap == false;
      }
      
      private function refreshTutorial() : void
      {
         var _loc5_:Array = null;
         var _loc7_:Object = null;
         var _loc9_:uint = 0;
         var _loc10_:Object = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Object = null;
         var _loc15_:Number = NaN;
         var _loc16_:uint = 0;
         this._tutorialForceMovement = false;
         if(dataM.useHiddenBaseMap)
         {
            return;
         }
         if(tutorialM.isTutorialActive() == false)
         {
            return;
         }
         if(dataM.myProfile.currentMissionSlot > 1)
         {
            return;
         }
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         var _loc4_:uint = 1;
         while(_loc4_ <= dataM.myProfile.mission_rows)
         {
            _loc9_ = 1;
            for(; _loc9_ <= dataM.myProfile.mission_columns; _loc9_++)
            {
               if(this._map[_loc4_][_loc9_] == null)
               {
                  continue;
               }
               if(this._map[_loc4_][_loc9_] == "")
               {
                  continue;
               }
               _loc10_ = dataM.missionMapObjectDB[this._map[_loc4_][_loc9_]];
               _loc11_ = this._playerColumn - _loc9_;
               _loc12_ = this._playerRow - _loc4_;
               _loc13_ = Math.round(dataM.getVectorSize(_loc11_,_loc12_) * 10);
               _loc14_ = {
                  "row":_loc4_,
                  "column":_loc9_,
                  "distance":_loc13_
               };
               switch(_loc10_.type)
               {
                  case "enemy":
                     _loc1_.push(_loc14_);
                     break;
                  case "structure":
                  case "crate":
                     _loc2_.push(_loc14_);
                     break;
                  case "loot":
                     _loc3_.push(_loc14_);
               }
            }
            _loc4_++;
         }
         var _loc6_:uint = 0;
         if(dataM.myProfile.currentMissionSlot == 0)
         {
            if(_loc2_.length > 0)
            {
               _loc5_ = _loc2_;
            }
            else if(_loc1_.length > 0)
            {
               _loc5_ = _loc1_;
            }
            else if(_loc3_.length > 0)
            {
               _loc5_ = _loc3_;
            }
         }
         else if(this._firstUpgradeTutorial == false)
         {
            if(_loc1_.length == 2)
            {
               _loc5_ = _loc1_;
            }
            else if(_loc2_.length == 1)
            {
               _loc5_ = _loc2_;
            }
            else if(_loc1_.length == 1)
            {
               _loc5_ = _loc1_;
            }
            else if(_loc3_.length > 0)
            {
               _loc5_ = _loc3_;
            }
            _loc6_ = 120;
         }
         if(_loc5_ == null)
         {
            this.hideMapArrow();
            return;
         }
         var _loc8_:uint = 0;
         if(_loc5_.length > 1)
         {
            _loc15_ = Number(_loc5_[_loc8_].distance);
            _loc16_ = 1;
            while(_loc16_ < _loc5_.length)
            {
               _loc7_ = _loc5_[_loc16_];
               if(_loc7_.distance < _loc15_)
               {
                  _loc8_ = _loc16_;
                  _loc15_ = Number(_loc7_.distance);
               }
               _loc16_++;
            }
         }
         _loc7_ = _loc5_[_loc8_];
         this.showMapArrow(_loc7_.row,_loc7_.column,_loc6_);
         if(dataM.myProfile.currentMissionSlot == 0)
         {
            this._tutorialForceMovement = true;
            this._tutorialForceMovementRow = _loc7_.row;
            this._tutorialForceMovementColumn = _loc7_.column;
         }
      }
      
      private function showMapArrow(param1:uint, param2:uint, param3:uint = 0) : void
      {
         this.mcMapArrow.x = this.getObjectXPos(param2);
         this.mcMapArrow.y = this.getObjectYPos(param1);
         if(this.mcMapArrow.parent != null)
         {
            this.mcMapArrow.parent.removeChild(this.mcMapArrow);
         }
         this.mcMapHolder["holder_objects" + param1].addChild(this.mcMapArrow);
         this._mapArrowHandler = true;
         this._mapArrowFrameCounter = 0;
         this._mapArrowDelayFrames = param3;
      }
      
      private function hideMapArrow() : void
      {
         this._mapArrowHandler = false;
         this.mcMapArrow.gotoAndStop("animOff");
      }
      
      private function mapArrowHandler() : void
      {
         if(this.useAnimations == false)
         {
            return;
         }
         if(this._mapArrowHandler == false)
         {
            return;
         }
         if(this._mapArrowDelayFrames > 0)
         {
            --this._mapArrowDelayFrames;
            return;
         }
         ++this._mapArrowFrameCounter;
         if(this._mapArrowFrameCounter > 30)
         {
            this.mcMapArrow.gotoAndStop("animOn");
            this._mapArrowHandler = false;
         }
      }
      
      private function createMap(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Array = null;
         var _loc11_:uint = 0;
         var _loc13_:Object = null;
         var _loc15_:String = null;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Sprite = null;
         var _loc20_:Boolean = false;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc23_:String = null;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:String = null;
         var _loc27_:BMMapObject = null;
         var _loc28_:uint = 0;
         var _loc29_:uint = 0;
         var _loc30_:BMBaseMapTurret = null;
         this._halfMapWidth = dataM.myProfile.mission_columns * this.SQUARE_SIZE / 2;
         this._halfMapHeight = dataM.myProfile.mission_rows * this.SQUARE_SIZE / 2;
         this._map = new Array();
         this._mapOrigin = new Array();
         this._mapTurrets = new Array();
         this._mapShots = new Array();
         this._mapEnemyMechViews = new Array();
         this._mapEnemyMechDatas = new Array();
         this._mapDamageFloors = new Array();
         _loc2_ = 1;
         while(_loc2_ <= dataM.myProfile.mission_rows)
         {
            this._map[_loc2_] = new Array();
            this._mapOrigin[_loc2_] = new Array();
            _loc3_ = 1;
            while(_loc3_ <= dataM.myProfile.mission_columns)
            {
               this._map[_loc2_][_loc3_] = "";
               this._mapOrigin[_loc2_][_loc3_] = "";
               _loc3_++;
            }
            _loc2_++;
         }
         this._mapObjects = new Object();
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc6_:Number = dataM.myProfile.mission_layout.length - 1;
         _loc11_ = 0;
         while(_loc11_ < dataM.myProfile.mission_layout.length)
         {
            _loc15_ = dataM.myProfile.mission_layout.substr(_loc11_,1);
            if(_loc15_ == "_" || _loc15_ == "|" || _loc11_ == _loc6_)
            {
               if(_loc5_ == "")
               {
                  _loc5_ = _loc4_;
                  _loc4_ = "";
               }
               else
               {
                  if(_loc11_ == _loc6_)
                  {
                     _loc4_ += _loc15_;
                  }
                  _loc7_ = int(_loc4_);
                  _loc10_ = this.getRowAndColumnByPosition(_loc7_);
                  _loc8_ = Number(_loc10_[0]);
                  _loc9_ = Number(_loc10_[1]);
                  _loc16_ = dataM.isMandatoryMissionMapObject(_loc5_);
                  if(_loc16_)
                  {
                     this._map[_loc8_][_loc9_] = _loc5_;
                     this._mapOrigin[_loc8_][_loc9_] = _loc5_;
                  }
                  _loc4_ = "";
               }
               if(_loc15_ == "|")
               {
                  _loc5_ = "";
               }
            }
            else
            {
               _loc4_ += _loc15_;
            }
            _loc11_++;
         }
         if(dataM.clientRunningLocally)
         {
         }
         this._floorSquares = new Array();
         var _loc12_:Boolean = false;
         _loc2_ = 1;
         while(_loc2_ <= dataM.myProfile.mission_rows)
         {
            _loc3_ = 1;
            while(_loc3_ <= dataM.myProfile.mission_columns)
            {
               _loc17_ = false;
               _loc18_ = false;
               if(this._map[_loc2_][_loc3_] != "")
               {
                  _loc13_ = dataM.missionMapObjectDB[this._map[_loc2_][_loc3_]];
                  if(_loc13_.type == "invisibleBlock")
                  {
                     _loc17_ = true;
                     _loc12_ = true;
                  }
                  if(_loc13_.type == "regularBlock")
                  {
                     _loc18_ = true;
                  }
               }
               if(_loc18_ == false && _loc17_ == false)
               {
                  _loc19_ = externalAssetsM.getAsset("general","map_floorSquare",this.SQUARE_SIZE,this.SQUARE_SIZE,false,false);
                  _loc19_.x = this.getObjectXPos(_loc3_);
                  _loc19_.y = this.getObjectYPos(_loc2_);
                  this.mcMapHolder.holder_floorSquares.addChild(_loc19_);
                  this._floorSquares.push(_loc19_);
               }
               _loc3_++;
            }
            _loc2_++;
         }
         if(this.mapMarker.parent != null)
         {
            this.mapMarker.parent.removeChild(this.mapMarker);
         }
         this.mcMapHolder.holder_floorSquares.addChild(this.mapMarker);
         _loc11_ = 0;
         while(_loc11_ < dataM.myProfile.mission_progress.length)
         {
            _loc7_ = Number(dataM.myProfile.mission_progress[_loc11_]);
            _loc10_ = this.getRowAndColumnByPosition(_loc7_);
            _loc8_ = Number(_loc10_[0]);
            _loc9_ = Number(_loc10_[1]);
            _loc20_ = false;
            if(dataM.mission_battleEnemyType != "")
            {
               if(_loc8_ == dataM.mission_battleRow && _loc9_ == dataM.mission_battleColumn)
               {
                  _loc20_ = true;
                  this.resetBattleTrackingData();
               }
            }
            if(_loc20_ == false)
            {
               _loc21_ = 0;
               _loc22_ = 0;
               _loc23_ = this._map[_loc8_][_loc9_];
               _loc13_ = dataM.missionMapObjectDB[_loc23_];
               if(_loc13_ != null)
               {
                  switch(_loc13_.type)
                  {
                     case "enemy":
                     case "structure":
                     case "crate":
                        _loc21_ = uint(_loc13_.dirtSize);
                  }
                  this._map[_loc8_][_loc9_] = "";
                  if(_loc22_ > 0)
                  {
                     this.createInterfacePickups("loot","loot",_loc22_);
                  }
                  if(_loc21_ > 0)
                  {
                     _loc24_ = (_loc9_ - 0.5 - dataM.myProfile.mission_columns / 2) * this.SQUARE_SIZE;
                     _loc25_ = (_loc8_ - 0.5 - dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
                     this.createDirt(_loc24_,_loc25_,_loc21_);
                  }
               }
            }
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < dataM.myProfile.mission_upgrades.length)
         {
            _loc26_ = dataM.missionUpgradesDB[dataM.myProfile.mission_upgrades[_loc11_]];
            this.createSpecificInterfacePickup("upgrade",_loc26_);
            _loc11_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= dataM.myProfile.mission_rows)
         {
            _loc3_ = 1;
            while(_loc3_ <= dataM.myProfile.mission_columns)
            {
               if(this._map[_loc2_][_loc3_] != "")
               {
                  this.createMapObject(_loc2_,_loc3_);
                  _loc13_ = dataM.missionMapObjectDB[this._map[_loc2_][_loc3_]];
                  if(_loc13_.subType == "turret")
                  {
                     _loc27_ = this._mapObjects[_loc2_ + "_" + _loc3_];
                     _loc28_ = 100;
                     _loc29_ = 10;
                     _loc30_ = new BMBaseMapTurret(_loc2_,_loc3_,_loc13_.direction,_loc28_,_loc29_,_loc13_.weaponAnimation,_loc27_.mcGrp);
                     this._mapTurrets.push(_loc30_);
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
         var _loc14_:Boolean = false;
         if(_loc12_)
         {
            _loc14_ = true;
         }
         this._playerEntryBlowGate = false;
         if(_loc14_)
         {
            this.createWalls();
            this._playerEntryGateSize = 2;
            if(param1)
            {
               this.mcGate.visible = false;
            }
            else
            {
               this._playerEntryBlowGate = true;
            }
         }
      }
      
      private function createMapObject(param1:uint, param2:uint) : void
      {
         var _loc9_:BMWorldMapLocationData = null;
         var _loc10_:BMBaseMapDamageFloor = null;
         var _loc11_:uint = 0;
         var _loc12_:ColorTransform = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:BitmapData = null;
         var _loc3_:Object = dataM.missionMapObjectDB[this._map[param1][param2]];
         if(_loc3_.type == "invisibleBlock")
         {
            return;
         }
         var _loc4_:BMMapObject = new BMMapObject();
         var _loc5_:String = _loc3_.grp;
         var _loc6_:Number = dataM.myProfile.mission_colorID;
         var _loc7_:Boolean = false;
         switch(_loc3_.type)
         {
            case "loot":
               switch(this.getVisualMissionDifficulty())
               {
                  case BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL:
                     _loc5_ += "A";
                     break;
                  case BMSinglePlayerManager.MISSION_DIFFICULTY_HARD:
                     _loc5_ += "B";
                     break;
                  case BMSinglePlayerManager.MISSION_DIFFICULTY_INSANE:
                     _loc5_ += "C";
               }
               break;
            case "enemy":
               switch(_loc3_.subType)
               {
                  case "boss":
                     if(dataM.raidData.isRaidInProgress())
                     {
                        _loc6_ = 21;
                     }
                     else
                     {
                        _loc9_ = dataM.singlePlayerM.currentMissionDB;
                        _loc6_ = Number(dataM.missionBossData[_loc9_.bossID].color);
                     }
                     break;
                  case "mech":
                  case "tank":
                  case "jeep":
                     if(this._useMissionGameplayImprovements)
                     {
                        _loc7_ = true;
                     }
               }
               if(this.battleMechsPerPlayer > 1)
               {
                  _loc5_ = _loc5_ + "_x" + this.battleMechsPerPlayer;
               }
         }
         _loc5_ = "mo_" + _loc5_;
         var _loc8_:MovieClip = externalAssetsM.getAsset("general",_loc5_);
         switch(_loc3_.type)
         {
            case "floor":
               _loc10_ = new BMBaseMapDamageFloor();
               _loc11_ = param1 * 4 + param2 * 4;
               _loc10_.initialize(param1,param2,_loc3_.cooldown,_loc3_.damageFrames,_loc8_,_loc11_);
               this._mapDamageFloors.push(_loc10_);
         }
         _loc8_.x = this.getObjectXPos(param2);
         _loc8_.y = this.getObjectYPos(param1);
         if(_loc8_.mcColor != null)
         {
            _loc12_ = new ColorTransform();
            _loc12_.color = dataM.colorsDB[_loc6_];
            _loc8_.mcColor.transform.colorTransform = _loc12_;
            _loc8_.mcColor.blendMode = BlendMode.OVERLAY;
            if(dataM.runAsMobile)
            {
               if(_loc8_.itemGfx != null)
               {
                  _loc13_ = 2;
                  _loc8_.itemGfx.width *= _loc13_;
                  _loc8_.itemGfx.height *= _loc13_;
                  _loc8_.mcColor.width *= _loc13_;
                  _loc8_.mcColor.height *= _loc13_;
                  _loc14_ = -_loc8_.itemGfx.x;
                  _loc15_ = -_loc8_.itemGfx.y;
                  _loc8_.itemGfx.x += _loc14_;
                  _loc8_.itemGfx.y += _loc15_;
                  _loc8_.mcColor.x += _loc14_;
                  _loc8_.mcColor.y += _loc15_;
                  _loc16_ = new BitmapData(_loc8_.width,_loc8_.height,true,0);
                  _loc16_.draw(_loc8_);
                  _loc8_.gpuImage = new Bitmap(_loc16_,"auto",true);
                  _loc8_.gpuImage.width /= _loc13_;
                  _loc8_.gpuImage.height /= _loc13_;
                  _loc8_.gpuImage.x = -_loc14_;
                  _loc8_.gpuImage.y = -_loc15_;
                  _loc8_.addChild(_loc8_.gpuImage);
                  _loc8_["cacheAsBitmapMatrix"] = new Matrix();
                  _loc8_.cacheAsBitmap = true;
                  _loc8_.itemGfx.parent.removeChild(_loc8_.itemGfx);
                  _loc8_.itemGfx = null;
                  _loc8_.mcColor.parent.removeChild(_loc8_.mcColor);
                  _loc8_.mcColor = null;
               }
            }
         }
         _loc4_.initialize(param1,param2,_loc8_,_loc3_.code,_loc3_.grp);
         if(_loc3_.type == "floor")
         {
            this.mcMapHolder.holder_damageFloors.addChild(_loc8_);
         }
         else
         {
            this.mcMapHolder["holder_objects" + param1].addChild(_loc8_);
         }
         this._mapObjects[param1 + "_" + param2] = _loc4_;
         if(_loc7_)
         {
            _loc4_.mcGrp.visible = false;
            this.createEnemyMech(param1,param2);
         }
      }
      
      private function cleanMap() : void
      {
         var _loc1_:BMMapObject = null;
         var _loc2_:uint = 0;
         this._map = new Array();
         for each(_loc1_ in this._mapObjects)
         {
            if(_loc1_ != null)
            {
               _loc1_.removeMe();
               this._mapObjects[_loc1_.row + "_" + _loc1_.column] = null;
            }
         }
         this._mapObjects = new Object();
         _loc2_ = 0;
         while(_loc2_ < this._dirts.length)
         {
            if(this._dirts[_loc2_].parent != null)
            {
               this._dirts[_loc2_].parent.removeChild(this._dirts[_loc2_]);
               this._dirts[_loc2_] = null;
            }
            _loc2_++;
         }
         this._dirts = new Array();
         _loc2_ = 0;
         while(_loc2_ < this._floorSquares.length)
         {
            if(this._floorSquares[_loc2_].parent != null)
            {
               this._floorSquares[_loc2_].parent.removeChild(this._floorSquares[_loc2_]);
               this._floorSquares[_loc2_] = null;
            }
            _loc2_++;
         }
         this._floorSquares = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ <= this._mapRows + 1)
         {
            if(this.mcMapHolder["holder_objects" + _loc3_] != null)
            {
               this.mcMapHolder["holder_objects" + _loc3_].parent.removeChild(this.mcMapHolder["holder_objects" + _loc3_]);
               this.mcMapHolder["holder_objects" + _loc3_] = null;
            }
            _loc3_++;
         }
      }
      
      private function mapHitAreaClickedForWeb(param1:MouseEvent) : void
      {
         this.mapHitAreaClicked(-1,-1,true);
      }
      
      public function mapHitAreaClicked(param1:Number = -1, param2:Number = -1, param3:Boolean = false) : void
      {
         if(this.activeAutoPilotBlock())
         {
            return;
         }
         this.resetFollowingEnemy();
         this.mapHitAreaClickedSub(param1,param2,param3);
      }
      
      private function activeAutoPilotBlock() : Boolean
      {
         if(this.autopilotActive)
         {
            if(this._missionCompleted == false && dataM.myProfile.missionCurrentMechStats.hp > 0)
            {
               this.mcAutoplayAndGameSpeedPanel.activateUserAutopilotArrow();
            }
            return true;
         }
         return false;
      }
      
      private function getMapStepCodeForWalking(param1:uint, param2:uint) : String
      {
         var _loc3_:String = this._map[param1][param2];
         if(_loc3_ == "")
         {
            return "";
         }
         var _loc4_:Object = dataM.missionMapObjectDB[_loc3_];
         if(_loc4_.type == "floor")
         {
            return "";
         }
         if(this._useMissionGameplayImprovements)
         {
            if((this.isMechCode(_loc3_) || this.isTankCode(_loc3_) || this.isJeepCode(_loc3_)) && this.autopilotActive == false)
            {
               return "";
            }
         }
         return _loc3_;
      }
      
      private function get isMapInteractable() : Boolean
      {
         if(screensM.screenBlack.isActive() && dataM.useHiddenBaseMap == false)
         {
            return false;
         }
         if(this._missionCompleted || this._bossStompAnimationActive)
         {
            return false;
         }
         if(this._firstUpgradeTutorial)
         {
            return false;
         }
         return true;
      }
      
      private function mapHitAreaClickedSub(param1:Number = -1, param2:Number = -1, param3:Boolean = false) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc19_:Object = null;
         var _loc20_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc23_:BMMapObject = null;
         var _loc24_:BMMapObject = null;
         if(this.isMapInteractable == false)
         {
            return;
         }
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(this.isAnimationActive())
         {
            if(this._walkingActive)
            {
               _loc5_ = true;
            }
         }
         else
         {
            _loc4_ = true;
         }
         if(_loc4_ == false && _loc5_ == false)
         {
            return;
         }
         var _loc6_:Number = this.SQUARE_SIZE * this.mcMapHolder.scaleX;
         var _loc7_:Number = this.mcMapHolder.x - dataM.myProfile.mission_columns / 2 * _loc6_;
         var _loc8_:Number = this.mcMapHolder.y - dataM.myProfile.mission_rows / 2 * _loc6_;
         if(param1 > -1)
         {
            _loc9_ = param2;
            _loc10_ = param1;
         }
         else if(this._walkingFinalInteractionRow == -1 || param3)
         {
            _loc9_ = Math.ceil((mouseX - _loc7_) / _loc6_);
            _loc10_ = Math.ceil((mouseY - _loc8_) / _loc6_);
         }
         else
         {
            _loc9_ = this._walkingFinalInteractionColumn;
            _loc10_ = this._walkingFinalInteractionRow;
            this._walkingFinalInteractionRow = -1;
            this._walkingFinalInteractionColumn = -1;
         }
         if(_loc10_ < 1 || _loc10_ > dataM.myProfile.mission_rows)
         {
            return;
         }
         if(_loc9_ < 1 || _loc9_ > dataM.myProfile.mission_columns)
         {
            return;
         }
         var _loc11_:Boolean = false;
         if(this._tutorialForceMovement)
         {
            if(this._tutorialForceMovementRow != _loc10_ || this._tutorialForceMovementColumn != _loc9_)
            {
               _loc11_ = true;
            }
         }
         if(_loc11_)
         {
            this.activateMapMarker(_loc10_,_loc9_,"red");
            return;
         }
         if(_loc5_)
         {
            this.changeExistingWalkingPath(_loc10_,_loc9_);
            return;
         }
         this._targetBattleSubType = "";
         var _loc12_:Boolean = false;
         if(this._map[_loc10_] != null)
         {
            if(this._map[_loc10_][_loc9_] != null)
            {
               _loc12_ = true;
            }
         }
         if(_loc12_ == false)
         {
            return;
         }
         this.checkForFollowingEnemy(_loc10_,_loc9_);
         var _loc13_:uint = 0;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Number = this.getPositionByRowAndColumn(_loc10_,_loc9_);
         var _loc17_:String = "";
         var _loc18_:String = this.getMapStepCodeForWalking(_loc10_,_loc9_);
         if(_loc18_ != "")
         {
            _loc19_ = dataM.missionMapObjectDB[_loc18_];
            _loc17_ = _loc19_.type;
            switch(_loc17_)
            {
               case "enemy":
                  this._targetBattleSubType = _loc19_.subType;
                  break;
               case "loot":
                  _loc13_ = uint(_loc19_.pickups);
            }
         }
         if(_loc17_ != "")
         {
            _loc20_ = false;
            _loc21_ = false;
            _loc22_ = false;
            if(Math.abs(this._playerRow - _loc10_) <= 1 && this._playerColumn == _loc9_)
            {
               _loc22_ = true;
            }
            if(Math.abs(this._playerColumn - _loc9_) <= 1 && this._playerRow == _loc10_)
            {
               _loc21_ = true;
            }
            if(_loc21_ || _loc22_)
            {
               _loc20_ = true;
            }
            if(_loc20_)
            {
               if(_loc21_)
               {
                  if(this._playerColumn > _loc9_)
                  {
                     dataM.mission_playerMechStatus = BMMapMech.STATUS_STAND;
                     dataM.mission_playerMechDirection = BMMapMech.DIRECTION_LEFT;
                  }
                  else
                  {
                     dataM.mission_playerMechStatus = BMMapMech.STATUS_STAND;
                     dataM.mission_playerMechDirection = BMMapMech.DIRECTION_RIGHT;
                  }
               }
               else if(this._playerRow > _loc10_)
               {
                  dataM.mission_playerMechStatus = BMMapMech.STATUS_STAND;
                  dataM.mission_playerMechDirection = BMMapMech.DIRECTION_UP;
               }
               else
               {
                  dataM.mission_playerMechStatus = BMMapMech.STATUS_STAND;
                  dataM.mission_playerMechDirection = BMMapMech.DIRECTION_DOWN;
               }
               this.playerMech.setStatusAndDirection(dataM.mission_playerMechStatus,dataM.mission_playerMechDirection);
               if(this._saving)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("missionSavingProgress");
                  this.activateSavingAnimation();
               }
               else
               {
                  _loc23_ = this._mapObjects[_loc10_ + "_" + _loc9_];
                  switch(_loc17_)
                  {
                     case "structure":
                     case "crate":
                        this.addProgress(_loc16_);
                        dataM.mission_destroyingMapObjectRow = _loc10_;
                        dataM.mission_destroyingMapObjectColumn = _loc9_;
                        if(this.useAnimations)
                        {
                           dataM.mission_destroyingMapObjectActive = true;
                           dataM.mission_destroyingMapObjectFrameCounter = 10;
                        }
                        else
                        {
                           this.destroyMapObjectHandlerComplete();
                        }
                        break;
                     case "enemy":
                        if(this.isBossCode(_loc23_.code) && this.getEnemiesRemained() > 1)
                        {
                           if(dataM.clientRunningLocally == false)
                           {
                              _loc14_ = true;
                           }
                        }
                        if(_loc14_ == false)
                        {
                           this.startBattle(_loc10_,_loc9_);
                        }
                        break;
                     case "loot":
                        this.createMapPickups(_loc10_,_loc9_,"loot","loot",_loc13_);
                        this.destroyMapObject(_loc10_,_loc9_,false);
                        this.addProgress(_loc16_);
                        if(tutorialM.isTutorialActive())
                        {
                           if(dataM.myProfile.currentMissionSlot == 0)
                           {
                              this.progressAdded("",1000);
                           }
                           else
                           {
                              this.progressAdded("",420);
                           }
                        }
                  }
               }
            }
            else
            {
               _loc15_ = true;
            }
         }
         else
         {
            _loc15_ = true;
         }
         if(_loc14_)
         {
            this.showChatBubble(getScreenText("bossTaunt"));
            this._bossMapObjectName = _loc10_ + "_" + _loc9_;
            _loc24_ = this._mapObjects[this._bossMapObjectName];
            _loc24_.mcGrp.visible = false;
            this.createBossMech(_loc24_.mcGrp.x,_loc24_.mcGrp.y);
         }
         if(_loc15_)
         {
            this.playerMech.deactivateFireAnimation();
            this._walkingPath = this.getPathToPosition(_loc16_);
            if(this._walkingPath.length > 0)
            {
               this._walkingActive = true;
               this._currentMovementWalkingFrames = this._walkingFrames;
               if(this.playerMech != null)
               {
                  if(dataM.generalSpeedRatio == BMDataManager.GENERAL_SPEED_RATIO_DOUBLE)
                  {
                     this.playerMech.setFastAnimationSpeed();
                  }
                  else
                  {
                     this.playerMech.setRegularAnimationSpeed();
                  }
               }
               this._walkingPathSlot = 0;
               this._walkingFrameCounter = 0;
               this._walkingTotalFrameCounter = 0;
               this.activateMapMarker(_loc10_,_loc9_,"green");
            }
            else
            {
               this.activateMapMarker(_loc10_,_loc9_,"red");
            }
         }
      }
      
      private function checkForFollowingEnemy(param1:uint, param2:uint) : void
      {
         var _loc7_:BMMapMech = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(this._mapEnemyMechViews.length == 0)
         {
            return;
         }
         var _loc3_:Number = 999;
         var _loc4_:int = -1;
         var _loc5_:uint = 0;
         while(_loc5_ < this._mapEnemyMechViews.length)
         {
            _loc7_ = this._mapEnemyMechViews[_loc5_];
            _loc8_ = this.getObjectXPos(param2) - _loc7_.x;
            _loc9_ = this.getObjectYPos(param1) - _loc7_.y;
            _loc10_ = dataM.getVectorSize(_loc8_,_loc9_);
            if(_loc10_ < _loc3_ && _loc10_ < this.SQUARE_SIZE * 0.6)
            {
               _loc3_ = _loc10_;
               _loc4_ = int(_loc5_);
            }
            _loc5_++;
         }
         if(_loc4_ == -1)
         {
            return;
         }
         var _loc6_:BMBaseMapEnemy = this._mapEnemyMechDatas[_loc4_];
         this._followEnemyRow = _loc6_.row;
         this._followEnemyColumn = _loc6_.column;
      }
      
      private function get isFollowingEnemy() : Boolean
      {
         return this._followEnemyRow > -1;
      }
      
      private function resetFollowingEnemy() : void
      {
         this._followEnemyRow = -1;
         this._followEnemyColumn = -1;
      }
      
      private function getPositionByRowAndColumn(param1:uint, param2:uint) : uint
      {
         return (param1 - 1) * dataM.myProfile.mission_columns + param2;
      }
      
      private function getObjectXPos(param1:uint) : Number
      {
         return (param1 - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
      }
      
      private function getObjectYPos(param1:uint) : Number
      {
         return (param1 - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
      }
      
      private function showChatBubble(param1:String) : void
      {
         if(this.mcChatBubble == null)
         {
            this.mcChatBubble = new BMChatBubble();
         }
         if(this.mcChatBubble.parent == null)
         {
            addChild(this.mcChatBubble);
         }
         this.mcChatBubble.showNewMessage(param1);
      }
      
      private function chatBubbleHandler() : void
      {
         if(this.mcChatBubble == null)
         {
            return;
         }
         if(this._chatBubbleXPos <= 0)
         {
            return;
         }
         if(this.mcChatBubble.parent != null)
         {
            this.mcChatBubble.onEnterFrameTrigger(this._chatBubbleXPos,this._chatBubbleYPos);
         }
      }
      
      private function startBattle(param1:uint, param2:uint) : void
      {
         dataM.mission_battleRow = param1;
         dataM.mission_battleColumn = param2;
         dataM.mission_battleEnemyType = this._map[param1][param2];
         var _loc3_:Number = this.getPositionByRowAndColumn(param1,param2);
         var _loc4_:Boolean = dataM.myProfile.mission_damagedEnemies.indexOf(_loc3_) > -1;
         var _loc5_:BMMapObject = this._mapObjects[param1 + "_" + param2];
         var _loc6_:Boolean = false;
         if(this.isMechCode(_loc5_.code) || this.isBossCode(_loc5_.code))
         {
            _loc6_ = true;
         }
         if(this._targetBattleSubType == "")
         {
            if(this.isBossCode(_loc5_.code))
            {
               this._targetBattleSubType = BMSinglePlayerManager.ENEMY_TYPE_BOSS;
            }
            else if(this.isMechCode(_loc5_.code))
            {
               this._targetBattleSubType = BMSinglePlayerManager.ENEMY_TYPE_MECH;
            }
            else if(this.isTankCode(_loc5_.code))
            {
               this._targetBattleSubType = BMSinglePlayerManager.ENEMY_TYPE_TANK;
            }
            else if(this.isJeepCode(_loc5_.code))
            {
               this._targetBattleSubType = BMSinglePlayerManager.ENEMY_TYPE_JEEP;
            }
         }
         this._startingBattle = true;
         var _loc7_:String = BMSinglePlayerManager.BATTLE_TYPE_MISSION;
         var _loc8_:String = BattleTypeResolver.ENV_CAMPAIGN;
         var _loc9_:uint = 0;
         if(dataM.raidData.isRaidInProgress())
         {
            _loc8_ = BattleTypeResolver.ENV_RAID;
            _loc9_ = dataM.raidData.currentLevel;
         }
         var _loc10_:Boolean = BattleTypeResolver.shouldPvEBattleBeOnServer(_loc8_,_loc9_);
         dataM.singlePlayerM.startBattle_phase1(_loc7_,this._targetBattleSubType,_loc6_,_loc4_,_loc10_);
      }
      
      public function battleEndedForHiddenBase() : void
      {
         this._startingBattle = false;
         if(tutorialM.isTutorialActive() == false)
         {
            dataM.setDelayedAdvertisement();
         }
         this.handleBattleEnded();
         this.battleEnded();
      }
      
      private function battleEnded() : void
      {
         var _loc3_:BMMissionMechStats = null;
         var _loc4_:BMMissionMechStats = null;
         var _loc1_:Boolean = false;
         var _loc2_:uint = 1;
         while(_loc2_ <= dataM.mission_battleEnded_mechsStats.length)
         {
            _loc3_ = dataM.myProfile.mission_mechStats[_loc2_ - 1];
            _loc4_ = dataM.mission_battleEnded_mechsStats[_loc2_ - 1];
            if(_loc1_ == false)
            {
               if(_loc3_.hp != _loc4_.hp)
               {
                  _loc1_ = true;
               }
               if(_loc3_.bullets != _loc4_.bullets)
               {
                  _loc1_ = true;
               }
               if(_loc3_.rockets != _loc4_.rockets)
               {
                  _loc1_ = true;
               }
            }
            _loc3_.hp = _loc4_.hp;
            _loc3_.bullets = _loc4_.bullets;
            _loc3_.rockets = _loc4_.rockets;
            _loc2_++;
         }
         if(dataM.mission_battleEnded_playerWon)
         {
            this._runHandleBattleEndedPlayerWon = true;
         }
         else
         {
            this.handleBattleEndedPlayerLostOrQuit(_loc1_);
         }
         dataM.saveGuestData("missionBaseMap battleEnded");
      }
      
      private function handleBattleEnded() : void
      {
         var _loc1_:uint = 0;
         dataM.mission_battleEnded = false;
         if(dataM.mission_battleEnded_playerWon)
         {
            _loc1_ = dataM.singlePlayerM.getCurrentMissionPosition();
            this.activateSaving("handleBattleEndedPlayerWon");
            this.addProgress(_loc1_);
            dataM.mission_destroyingMapObjectRow = dataM.mission_battleRow;
            dataM.mission_destroyingMapObjectColumn = dataM.mission_battleColumn;
            if(this.useAnimations)
            {
               dataM.mission_destroyingMapObjectActive = true;
               dataM.mission_destroyingMapObjectFrameCounter = 0;
            }
            else
            {
               this.destroyMapObjectHandlerComplete();
            }
            if(tutorialM.isTutorialActive())
            {
               this.tutorialBattleEndedAddProgress();
            }
         }
         dataM.mission_battleEnded_playerWon = false;
      }
      
      private function handleBattleEndedPlayerLostOrQuit(param1:Boolean) : void
      {
         var _loc4_:BMMissionMechStats = null;
         var _loc2_:Boolean = false;
         var _loc3_:uint = 1;
         while(_loc3_ <= dataM.mission_battleEnded_mechsStats.length)
         {
            _loc4_ = dataM.mission_battleEnded_mechsStats[_loc3_ - 1];
            if(_loc4_.hp > 0)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         if(param1 == false)
         {
            return;
         }
         if(_loc2_)
         {
            this.addProgress(0);
            this.activateSaving("handleBattleEndedPlayerLostOrQuit");
         }
         else
         {
            this._playerLostConfirmed = false;
            this._destroyingPlayerActive = true;
            this._destroyingPlayerFrameCounter = 0;
            if(tutorialM.isTutorialActive())
            {
               this.playerLostSuccessful();
            }
            else
            {
               remoteM.socketM.mission_playerLost();
               this.activateSaving("handleBattleEndedPlayerLostOrQuit");
            }
         }
         this.resetBattleTrackingData();
      }
      
      private function tutorialBattleEndedAddProgress() : void
      {
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         switch(dataM.myProfile.currentMissionSlot)
         {
            case 0:
               _loc1_ = 500;
               _loc2_ = 50;
               break;
            case 1:
               switch(dataM.battleSubType)
               {
                  case BMSinglePlayerManager.ENEMY_TYPE_MECH:
                     _loc1_ = 500;
                     _loc2_ = 50;
                     break;
                  case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
                     _loc1_ = 160;
                     _loc2_ = 15;
               }
         }
         this.progressAdded("",_loc1_,_loc2_);
      }
      
      public function playerLostSuccessful() : void
      {
         this._playerLostConfirmed = true;
         this.deactivateSaving(false);
         dataM.mechBoostRecommender.allowNextRecommendationByClient();
      }
      
      private function createDirt(param1:Number, param2:Number, param3:uint) : void
      {
         var _loc4_:String = "dirt" + dataM.myProfile.mission_themeID + "_" + Math.ceil(Math.random() * 3);
         var _loc5_:Sprite = externalAssetsM.getAsset("general",_loc4_);
         switch(param3)
         {
            case 1:
               _loc5_.scaleX = 0.25;
               _loc5_.scaleY = 0.25;
               break;
            case 2:
               _loc5_.scaleX = 0.37;
               _loc5_.scaleY = 0.37;
               break;
            case 3:
               _loc5_.scaleX = 0.5;
               _loc5_.scaleY = 0.5;
         }
         _loc5_.x = param1;
         _loc5_.y = param2;
         this.mcMapHolder.holder_dirt.addChild(_loc5_);
         this._dirts.push(_loc5_);
      }
      
      private function addProgress(param1:uint) : void
      {
         var _loc2_:BMMissionMechStats = null;
         if(tutorialM.isTutorialActive() == false)
         {
            _loc2_ = dataM.myProfile.mission_mechStats[0];
            remoteM.socketM.mission_addProgress(param1,dataM.myProfile.mission_mechStats);
         }
         if(param1 > 0)
         {
            dataM.myProfile.mission_progress.push(param1);
         }
         if(tutorialM.isTutorialActive())
         {
            dataM.saveGuestData("missionBaseMap addProgress");
         }
         else
         {
            this.activateSaving("addProgress");
         }
      }
      
      public function getEnemiesDestroyed() : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc1_:uint = 0;
         if(this._mapOrigin != null)
         {
            _loc2_ = 1;
            while(_loc2_ <= dataM.myProfile.mission_rows)
            {
               _loc3_ = 1;
               while(_loc3_ <= dataM.myProfile.mission_columns)
               {
                  if(this.isEnemyCode(this._mapOrigin[_loc2_][_loc3_]))
                  {
                     if(this._map[_loc2_][_loc3_] != this._mapOrigin[_loc2_][_loc3_])
                     {
                        _loc1_++;
                     }
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function getEnemiesRemained() : uint
      {
         var _loc3_:uint = 0;
         if(this._mapOrigin == null)
         {
            return 0;
         }
         var _loc1_:uint = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= dataM.myProfile.mission_rows)
         {
            _loc3_ = 1;
            while(_loc3_ <= dataM.myProfile.mission_columns)
            {
               if(this.isEnemyCode(this._mapOrigin[_loc2_][_loc3_]))
               {
                  if(this._map[_loc2_][_loc3_] == this._mapOrigin[_loc2_][_loc3_])
                  {
                     _loc1_++;
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getEnemiesTotal() : uint
      {
         var _loc3_:uint = 0;
         if(this._mapOrigin == null)
         {
            return 0;
         }
         var _loc1_:uint = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= dataM.myProfile.mission_rows)
         {
            _loc3_ = 1;
            while(_loc3_ <= dataM.myProfile.mission_columns)
            {
               if(this.isEnemyCode(this._mapOrigin[_loc2_][_loc3_]))
               {
                  _loc1_++;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function progressAdded(param1:String, param2:uint, param3:uint = 0) : void
      {
         this.deactivateSaving(false);
         if(param2 > 0 || param3 > 0)
         {
            this._createFlyingRewardXPValue = param3;
            this._createFlyingRewardGoldValue = param2;
            this._createFlyingRewardRow = dataM.mission_destroyingMapObjectRow;
            this._createFlyingRewardColumn = dataM.mission_destroyingMapObjectColumn;
            if(dataM.mission_destroyingMapObjectActive == false)
            {
               this.createGoldReward();
               this.createXpReward();
            }
            return;
         }
         if(param1 == "")
         {
            return;
         }
         this._createUpgrade = param1;
         if(this.autopilotActive)
         {
            switch(param1)
            {
               case UPGRADE_HP:
               case UPGRADE_HEAT:
               case UPGRADE_ENERGY:
                  this._autopilotDelayFramesCounter = this.autopilotImportantActionDelayFrames;
            }
         }
         this._createUpgradeRow = dataM.mission_destroyingMapObjectRow;
         this._createUpgradeColumn = dataM.mission_destroyingMapObjectColumn;
         if(dataM.mission_destroyingMapObjectActive == false)
         {
            this.createUpgrade();
         }
      }
      
      private function destroyMapObject(param1:uint, param2:uint, param3:Boolean) : void
      {
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:uint = 0;
         var _loc14_:Array = null;
         var _loc15_:uint = 0;
         var _loc16_:Point = null;
         var _loc4_:String = param1 + "_" + param2;
         var _loc5_:BMMapObject = this._mapObjects[_loc4_];
         if(_loc5_ == null)
         {
            this.checkIfMissionIsComplete();
            return;
         }
         if(tutorialM.isTutorialActive())
         {
            _loc8_ = "";
            _loc9_ = 0;
            if(this._map[param1][param2].substr(0,1) == "C")
            {
               if(dataM.myProfile.currentMissionSlot == 1)
               {
                  _loc8_ = UPGRADE_HP;
               }
               else
               {
                  _loc10_ = uint(RandomUtils.chooseRandomIndex(this._availableUpgrades));
                  _loc8_ = this._availableUpgrades[_loc10_];
               }
            }
            else if(this._map[param1][param2].substr(0,1) == "S")
            {
               _loc9_ = 100 + (dataM.myProfile.mission_difficulty - 1) * 50;
            }
            if(_loc8_ != "" || _loc9_ > 0)
            {
               dataM.mission_destroyingMapObjectRow = param1;
               dataM.mission_destroyingMapObjectColumn = param2;
            }
            this.progressAdded(_loc8_,_loc9_);
         }
         if(dataM.useHiddenBaseMap == false)
         {
            if(tutorialM.isTutorialActive())
            {
               if(this.useAnimations)
               {
                  if(dataM.myProfile.currentMissionSlot == 1)
                  {
                     if(dataM.missionMapObjectDB[_loc5_.code].type == "crate")
                     {
                        this._firstUpgradeTutorial = true;
                        this.mcTutorialArrow_usePickup.gotoAndStop("animOn");
                     }
                  }
               }
            }
         }
         var _loc6_:Object = dataM.missionMapObjectDB[_loc5_.code];
         if(param3 && this.useAnimations)
         {
            _loc11_ = _loc5_.mcGrp.x;
            _loc12_ = _loc5_.mcGrp.y;
            _loc13_ = 1;
            _loc14_ = new Array();
            _loc14_[0] = new Point(_loc11_,_loc12_);
            if(this.isEnemyCode(_loc5_.code))
            {
               _loc13_ = this.battleMechsPerPlayer;
               if(_loc13_ == 2)
               {
                  _loc14_[0] = new Point(_loc11_ - 10,_loc12_ - 10);
                  _loc14_[1] = new Point(_loc11_ + 10,_loc12_ + 10);
               }
               else if(_loc13_ == 3)
               {
                  _loc14_[0] = new Point(_loc11_ + 15,_loc12_ + 15);
                  _loc14_[1] = new Point(_loc11_,_loc12_);
                  _loc14_[2] = new Point(_loc11_ - 15,_loc12_ - 15);
               }
            }
            _loc15_ = 0;
            while(_loc15_ < _loc13_)
            {
               _loc16_ = _loc14_[_loc15_];
               if(_loc6_.megaExplosion)
               {
                  effectsM.createHeatBombExplosion(_loc16_.x,_loc16_.y,"red",this.mcMapHolder["holder_objects" + param1]);
               }
               else
               {
                  this.createExplosion(_loc16_.x,_loc16_.y,this.mcMapHolder["holder_objects" + param1]);
               }
               if(_loc6_.dirtSize > 0)
               {
                  this.createDirt(_loc16_.x,_loc16_.y,_loc6_.dirtSize);
               }
               _loc15_++;
            }
         }
         var _loc7_:Boolean = false;
         if(_loc6_.explosive)
         {
            _loc7_ = true;
         }
         _loc5_.removeMe();
         if(this._useMissionGameplayImprovements)
         {
            this.removeEnemyMech(param1,param2);
         }
         if(this.autopilotActive)
         {
            if(this.isEnemyCode(_loc5_.code))
            {
               this._autopilotDelayFramesCounter = this.autopilotImportantActionDelayFrames;
            }
         }
         this.removeTurret(param1,param2);
         this._mapObjects[_loc4_] = null;
         this._map[param1][param2] = "";
         this.createGoldReward();
         this.createXpReward();
         this.createUpgrade();
         dataM.saveGuestData("missionBaseMap destroyMapObject");
         this.refreshTutorial();
         this.checkIfMissionIsComplete();
         if(_loc7_)
         {
            this.activateExplosionChain(param1,param2);
         }
      }
      
      private function destroyMapObjectHandler() : void
      {
         var _loc1_:BMMapObject = null;
         if(dataM.mission_destroyingMapObjectActive == false)
         {
            return;
         }
         ++dataM.mission_destroyingMapObjectFrameCounter;
         if(dataM.mission_destroyingMapObjectFrameCounter == 11)
         {
            this.playerMech.activateFireAnimation();
            if(dataM.newVisualEffects)
            {
               _loc1_ = this._mapObjects[dataM.mission_destroyingMapObjectRow + "_" + dataM.mission_destroyingMapObjectColumn];
               effectsM.createGetHitSparks(_loc1_.mcGrp.x,_loc1_.mcGrp.y,this.mcMapEffectsHolder,14,0.7);
            }
         }
         if(dataM.newVisualEffects == false)
         {
            if(dataM.mission_destroyingMapObjectFrameCounter == 19)
            {
               _loc1_ = this._mapObjects[dataM.mission_destroyingMapObjectRow + "_" + dataM.mission_destroyingMapObjectColumn];
               effectsM.createSparksMC(BMScreensManager.SCR_MISSION_BASE_MAP,"spark",_loc1_.mcGrp.x,_loc1_.mcGrp.y,1,8,40,"up","orange",true);
            }
         }
         if(dataM.mission_destroyingMapObjectFrameCounter >= 30)
         {
            this.destroyMapObjectHandlerComplete();
         }
      }
      
      private function destroyMapObjectHandlerComplete() : void
      {
         this.destroyMapObject(dataM.mission_destroyingMapObjectRow,dataM.mission_destroyingMapObjectColumn,true);
         this.resetBattleTrackingData();
         dataM.mission_destroyingMapObjectActive = false;
      }
      
      private function resetBattleTrackingData() : void
      {
         dataM.mission_battleRow = 0;
         dataM.mission_battleColumn = 0;
         dataM.mission_battleEnemyType = "";
      }
      
      private function createPlayerMech(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc7_:BMPlayerItemData = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:DisplayObjectContainer = null;
         var _loc14_:Object = null;
         var _loc17_:BMItemData = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc4_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc5_:uint = dataM.myProfile.missionCurrentMechID;
         var _loc6_:BMMechStructure = _loc4_.mechStructures[_loc5_];
         var _loc8_:String = "";
         var _loc9_:uint = 1;
         if(_loc6_.perk > 0)
         {
            _loc7_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_.perk);
            _loc17_ = dataM.itemsDB[_loc7_.itemID];
            if(_loc17_.isHatPerk)
            {
               _loc8_ = _loc17_.animation;
            }
         }
         _loc7_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_.torso);
         var _loc10_:BMItemData = dataM.itemsDB[_loc7_.itemID];
         if(_loc10_.damageType == 2 || _loc10_.damageType == 3)
         {
            _loc9_ = uint(_loc10_.damageType);
         }
         if(param3)
         {
            _loc11_ = this.playerMech.x;
            _loc12_ = this.playerMech.y;
            _loc13_ = this.playerMech.parent;
            _loc14_ = this.playerMech.exportMechState();
         }
         this.removePlayerMech();
         this.playerMech = new BMMapMech();
         this.playerMech.initialize(BMMapMech.TYPE_MECH,_loc9_,_loc8_);
         if(this.battleMechsPerPlayer == 2)
         {
            this.playerMech.scaleX = 0.8;
            this.playerMech.scaleY = 0.8;
         }
         if(dataM.generalSpeedRatio == BMDataManager.GENERAL_SPEED_RATIO_DOUBLE)
         {
            this.playerMech.setFastAnimationSpeed();
         }
         if(param3)
         {
            this.playerMech.x = _loc11_;
            this.playerMech.y = _loc12_;
            _loc13_.addChild(this.playerMech);
            this.playerMech.importMechState(_loc14_);
         }
         else
         {
            _loc18_ = dataM.myProfile.mission_playerPosition;
            _loc19_ = Math.floor((_loc18_ - 1) / dataM.myProfile.mission_columns) + 1;
            _loc20_ = _loc18_ - dataM.myProfile.mission_columns * (_loc19_ - 1);
            this.mcMapHolder["holder_objects" + _loc19_].addChild(this.playerMech);
            if(param1 == false && param2 == false)
            {
               _loc19_ += 2;
               this._currentMovementWalkingFrames = this._walkingFrames;
            }
            this.playerMech.x = this.getObjectXPos(_loc20_);
            this.playerMech.y = this.getObjectYPos(_loc19_);
         }
         if(dataM.mission_playerMechStatus != "")
         {
            this.playerMech.setStatusAndDirection(dataM.mission_playerMechStatus,dataM.mission_playerMechDirection);
         }
         _loc7_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_.torso);
         var _loc15_:uint = _loc7_.colorID;
         if(_loc15_ == 0)
         {
            _loc15_ = dataM.getItemPowerColorID(dataM.player1PlayerID,_loc6_.torso);
         }
         _loc7_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_.leg);
         var _loc16_:uint = _loc7_.colorID;
         if(_loc16_ == 0)
         {
            _loc16_ = dataM.getItemPowerColorID(dataM.player1PlayerID,_loc6_.leg);
         }
         this.playerMech.colorMech(_loc15_,_loc16_);
      }
      
      private function playerWalkingHandler() : void
      {
         if(this._startingBattle)
         {
            return;
         }
         if(this._walkingActive == false)
         {
            return;
         }
         this.playerWalkingHandler_setMechToNewDirection();
         if(this.useAnimations == false)
         {
            this.playerWalkingHandlerComplete();
            return;
         }
         ++this._walkingTotalFrameCounter;
         if(this.useSounds)
         {
            if(this._walkingTotalFrameCounter % 12 == 0)
            {
               soundM.createSound("footStep",this.VOLUME_RATIO);
            }
         }
         if(this._walkingFrameCounter > this._currentMovementWalkingFrames)
         {
            return;
         }
         if(this._walkingFrameCounter == this._currentMovementWalkingFrames)
         {
            this.playerWalkingHandlerComplete();
            return;
         }
         if(this._walkingDirectionRow != 0)
         {
            this.playerMech.y += this.SQUARE_SIZE / this._currentMovementWalkingFrames * this._walkingDirectionRow;
         }
         if(this._walkingDirectionColumn != 0)
         {
            this.playerMech.x += this.SQUARE_SIZE / this._currentMovementWalkingFrames * this._walkingDirectionColumn;
         }
         ++this._walkingFrameCounter;
      }
      
      private function playerWalkingHandlerComplete() : void
      {
         var _loc1_:BMBaseMapEnemy = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         this.playerMech.x = this.getObjectXPos(this._walkingPath[this._walkingPathSlot].column);
         this.playerMech.y = this.getObjectYPos(this._walkingPath[this._walkingPathSlot].row);
         this._walkingFrameCounter = 0;
         if(this._walkingDirectionRow != 0)
         {
            if(this._walkingPath[this._walkingPathSlot] != null)
            {
               if(this.playerMech.parent != null)
               {
                  this.playerMech.parent.removeChild(this.playerMech);
               }
               this.mcMapHolder["holder_objects" + this._walkingPath[this._walkingPathSlot].row].addChild(this.playerMech);
            }
         }
         if(this._walkingPath[this._walkingPathSlot + 1] == null && this.isFollowingEnemy && this.autopilotActive == false)
         {
            _loc1_ = this.getEnemyMechByRowAndColumn(this._followEnemyRow,this._followEnemyColumn);
            _loc2_ = -(dataM.myProfile.mission_columns / 2) * this.SQUARE_SIZE;
            _loc3_ = -(dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
            _loc4_ = Math.ceil((_loc1_.view.x - _loc2_) / this.SQUARE_SIZE);
            _loc5_ = Math.ceil((_loc1_.view.y - _loc3_) / this.SQUARE_SIZE);
            this.mapHitAreaClickedSub(_loc5_,_loc4_);
         }
      }
      
      private function playerWalkingHandler_setMechToNewDirection() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         if(this._walkingFrameCounter > 0)
         {
            return;
         }
         if(this._walkingPath[this._walkingPathSlot + 1] != null)
         {
            _loc1_ = this._walkingPath[this._walkingPathSlot];
            _loc2_ = this._walkingPath[this._walkingPathSlot + 1];
            this._walkingDirectionRow = _loc2_.row - _loc1_.row;
            this._walkingDirectionColumn = _loc2_.column - _loc1_.column;
            if(this._walkingDirectionRow != 0)
            {
               if(this._walkingDirectionRow == -1)
               {
                  this.playerMech.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_UP);
               }
               else
               {
                  this.playerMech.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_DOWN);
               }
            }
            else if(this._walkingDirectionColumn == -1)
            {
               this.playerMech.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_LEFT);
            }
            else
            {
               this.playerMech.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_RIGHT);
            }
            ++this._walkingPathSlot;
            this._playerLastRow = this._playerRow;
            this._playerLastColumn = this._playerColumn;
            this._playerRow = this._walkingPath[this._walkingPathSlot].row;
            this._playerColumn = this._walkingPath[this._walkingPathSlot].column;
            this._walkingFrameCounter = 1;
            return;
         }
         this._playerPosition = this.getPositionByRowAndColumn(this._playerRow,this._playerColumn);
         dataM.myProfile.mission_playerPosition = this._playerPosition;
         this._walkingActive = false;
         this._walkingFrameCounter = this._currentMovementWalkingFrames + 1;
         if(this._walkingFinalInteractionRow > -1)
         {
            this.mapHitAreaClickedSub();
            return;
         }
         if(this._walkingDirectionRow != 0)
         {
            if(this._walkingDirectionRow == -1)
            {
               this.playerMech.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_UP);
            }
            else
            {
               this.playerMech.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_DOWN);
            }
         }
         else if(this._walkingDirectionColumn == -1)
         {
            this.playerMech.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_LEFT);
         }
         else
         {
            this.playerMech.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_RIGHT);
         }
      }
      
      private function changeExistingWalkingPath(param1:uint, param2:uint) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc3_:Boolean = false;
         if(this._walkingPathSlot < this._walkingPath.length)
         {
            _loc4_ = this._walkingPath[this._walkingPath.length - 1];
            if(param1 != _loc4_.row || param2 != _loc4_.column)
            {
               _loc5_ = this.getPositionByRowAndColumn(param1,param2);
               _loc6_ = this.getPathToPosition(_loc5_);
               if(_loc6_.length > 1)
               {
                  if(this._walkingPath[this._walkingPathSlot + 1] != null)
                  {
                     this._walkingPath.splice(this._walkingPathSlot + 1,this._walkingPath.length - 1 - (this._walkingPathSlot + 1) + 1);
                  }
                  _loc7_ = 1;
                  while(_loc7_ < _loc6_.length)
                  {
                     this._walkingPath.push(_loc6_[_loc7_]);
                     _loc7_++;
                  }
                  this.activateMapMarker(param1,param2,"green");
                  _loc3_ = true;
               }
            }
         }
         if(_loc3_ == false)
         {
            this.activateMapMarker(param1,param2,"red");
         }
      }
      
      private function resetPlayerTarget() : void
      {
         this._targetPosition = 0;
         this._targetRow = 0;
         this._targetColumn = 0;
      }
      
      private function removePlayerMech() : void
      {
         if(this.playerMech != null)
         {
            this.playerMech.removeMe();
            this.playerMech = null;
         }
      }
      
      private function destroyPlayerHandler() : void
      {
         if(this._destroyingPlayerActive == false)
         {
            return;
         }
         if(this.useAnimations == false)
         {
            this.openReviveDialog();
            this._destroyingPlayerActive = false;
            this.playerMech.visible = false;
            return;
         }
         ++this._destroyingPlayerFrameCounter;
         if(this._destroyingPlayerFrameCounter == 20)
         {
            this.createExplosion(this.playerMech.x,this.playerMech.y);
            this.playerMech.visible = false;
         }
         else if(this._destroyingPlayerFrameCounter >= 40 && this._playerLostConfirmed)
         {
            this.openReviveDialog();
            this._destroyingPlayerActive = false;
         }
      }
      
      private function playerEntryHandler() : void
      {
         if(this._playerNeedsToReviveBlock)
         {
            return;
         }
         if(this._playerEntryHandler == false)
         {
            return;
         }
         if(this.useAnimations == false)
         {
            this.playerEntryHandlerBlowGateComplete();
            this.playerEntryHandlerWalkInComplete();
            return;
         }
         ++this._playerEntryFrameCounter;
         if(this._playerEntryBlowGate)
         {
            this.playerEntryHandlerBlowGate();
         }
         else
         {
            this.playerEntryHandlerWalkIn();
         }
      }
      
      private function playerEntryHandlerBlowGate() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._playerEntryFrameCounter == 1)
         {
            this.playerMech.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_UP);
            this.playerMech.activateFireAnimation();
         }
         if(this._playerEntryFrameCounter < 15)
         {
            return;
         }
         if(this._playerEntryFrameCounter == 15)
         {
            if(this._playerEntryGateSize == 1)
            {
               _loc1_ = this.mcGate.x + this.SQUARE_SIZE * 1.5;
            }
            else
            {
               _loc1_ = this.mcGate.x + this.SQUARE_SIZE * 2;
            }
            _loc2_ = this.mcGate.y + this.SQUARE_SIZE / 2;
            if(dataM.newVisualEffects)
            {
               effectsM.createGetHitSparks(_loc1_,_loc2_,this.mcMapEffectsHolder,14,0.7);
            }
            else
            {
               effectsM.createSparksMC(BMScreensManager.SCR_MISSION_BASE_MAP,"spark",_loc1_,_loc2_,1,8,40,"up","orange",true);
            }
            if(this.useSounds)
            {
               soundM.createSound("fireMachineGun2",this.VOLUME_RATIO);
            }
         }
         if(this._playerEntryFrameCounter == 35)
         {
            this.playerEntryHandlerBlowGateComplete();
         }
      }
      
      private function playerEntryHandlerBlowGateComplete() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         this.playerMech.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_UP);
         this._playerEntryBlowGate = false;
         this._playerEntryFrameCounter = 0;
         if(this.useAnimations)
         {
            _loc2_ = this.mcGate.y + this.SQUARE_SIZE / 2;
            if(this._playerEntryGateSize == 1)
            {
               _loc1_ = this.mcGate.x + this.SQUARE_SIZE * 1.5;
               this.createExplosion(_loc1_,_loc2_);
            }
            else
            {
               _loc1_ = this.mcGate.x + this.SQUARE_SIZE * 1.5;
               this.createExplosion(_loc1_,_loc2_);
               _loc1_ = this.mcGate.x + this.SQUARE_SIZE * 2.5;
               this.createExplosion(_loc1_,_loc2_);
            }
            this.mcGate.visible = false;
         }
      }
      
      private function playerEntryHandlerWalkIn() : void
      {
         if(this._playerEntryFrameCounter == 1)
         {
            this.playerMech.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_UP);
         }
         if(this.useSounds)
         {
            if(this._playerEntryFrameCounter % 12 == 0)
            {
               soundM.createSound("footStep",this.VOLUME_RATIO);
            }
         }
         if(this._playerEntryFrameCounter < this._currentMovementWalkingFrames * 2)
         {
            this.playerMech.y -= this.SQUARE_SIZE / this._currentMovementWalkingFrames;
         }
         else
         {
            this.playerEntryHandlerWalkInComplete();
         }
      }
      
      private function playerEntryHandlerWalkInComplete() : void
      {
         var _loc1_:Number = dataM.myProfile.mission_playerPosition;
         var _loc2_:Number = Math.floor((_loc1_ - 1) / dataM.myProfile.mission_columns) + 1;
         var _loc3_:Number = _loc1_ - dataM.myProfile.mission_columns * (_loc2_ - 1);
         this.playerMech.x = this.getObjectXPos(_loc3_);
         this.playerMech.y = this.getObjectYPos(_loc2_);
         this.playerMech.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_UP);
         this._playerEntryHandler = false;
      }
      
      private function createBossMech(param1:Number, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc6_:BMWorldMapLocationData = null;
         this.removeBossMech();
         this.bossMech = new BMMapMech();
         this.bossMech.initialize();
         if(dataM.raidData.isRaidInProgress())
         {
            _loc3_ = int(BMWorldMapBossData.COLOR_ID);
         }
         else
         {
            _loc6_ = dataM.singlePlayerM.currentMissionDB;
            _loc3_ = int(dataM.missionBossData[_loc6_.bossID].color);
         }
         this.bossMech.colorMech(_loc3_,_loc3_);
         this.bossMech.x = param1;
         this.bossMech.y = param2 - 3;
         this.bossMech.scaleX = 1.185;
         this.bossMech.scaleY = 1.185;
         this.mcMapHolder.addChild(this.bossMech);
         this.bossMech.setStatusAndDirection(BMMapMech.STATUS_STOMP,BMMapMech.DIRECTION_DOWN,this.bossStompEnded);
         var _loc4_:Point = new Point(this.bossMech.x + 20,this.bossMech.y - 90);
         var _loc5_:Point = this.mcMapHolder.localToGlobal(_loc4_);
         this._chatBubbleXPos = localToGlobal(_loc5_).x;
         this._chatBubbleYPos = localToGlobal(_loc5_).y;
         this.playerMech.parent.removeChild(this.playerMech);
         this.mcMapHolder.addChild(this.playerMech);
         this._bossStompAnimationActive = true;
      }
      
      private function removeBossMech() : void
      {
         if(this.bossMech != null)
         {
            if(this.bossMech.parent != null)
            {
               this.bossMech.parent.removeChild(this.bossMech);
            }
            this.bossMech.removeMe();
            this.bossMech = null;
         }
      }
      
      private function bossStompEnded() : void
      {
         if(this.useSounds)
         {
            soundM.createSound("stomp1",1);
         }
         this._bossStompAnimationActive = false;
         effectsM.createStompFire(this.mcMapEffectsHolder,"stompFire1",this.bossMech.x,this.bossMech.y + 25,60,6,1,false);
         effectsM.createStompFire(this.mcMapEffectsHolder,"stompFire1",this.bossMech.x,this.bossMech.y + 25,60,6,1,true);
         effectsM.createGeneralEffect(this.mcMapEffectsHolder,"stompLegHit1",false,0,0,this.bossMech.x,this.bossMech.y + 35,0,null,[]);
         this._playerRow = this._playerLastRow;
         this._playerColumn = this._playerLastColumn;
         this._playerPosition = this.getPositionByRowAndColumn(this._playerRow,this._playerColumn);
         dataM.myProfile.mission_playerPosition = this._playerPosition;
         var _loc1_:Number = dataM.myProfile.mission_playerPosition;
         var _loc2_:Number = Math.floor((_loc1_ - 1) / dataM.myProfile.mission_columns) + 1;
         var _loc3_:Number = _loc1_ - dataM.myProfile.mission_columns * (_loc2_ - 1);
         this.playerMech.x = this.getObjectXPos(_loc3_);
         this.playerMech.y = this.getObjectYPos(_loc2_);
         var _loc4_:BMMapObject = this._mapObjects[this._bossMapObjectName];
         _loc4_.mcGrp.visible = true;
         this.removeBossMech();
      }
      
      private function getPathToPosition(param1:Number) : Array
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:Object = null;
         var _loc15_:Array = null;
         var _loc17_:String = null;
         var _loc18_:Boolean = false;
         var _loc19_:Array = null;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc23_:uint = 0;
         var _loc24_:uint = 0;
         var _loc25_:Object = null;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:uint = 0;
         var _loc29_:String = null;
         var _loc30_:uint = 0;
         var _loc2_:Array = this.getRowAndColumnByPosition(param1);
         var _loc3_:uint = uint(_loc2_[0]);
         var _loc4_:uint = uint(_loc2_[1]);
         this._walkingFinalInteractionRow = -1;
         this._walkingFinalInteractionColumn = -1;
         if(_loc3_ == this._playerRow && _loc4_ == this._playerColumn)
         {
            return new Array();
         }
         var _loc5_:Array = new Array();
         var _loc8_:Array = new Array();
         _loc6_ = 1;
         while(_loc6_ <= dataM.myProfile.mission_rows)
         {
            _loc8_[_loc6_] = new Array();
            _loc7_ = 1;
            while(_loc7_ <= dataM.myProfile.mission_columns)
            {
               _loc8_[_loc6_][_loc7_] = true;
               if(_loc6_ == this._playerRow && _loc7_ == this._playerColumn)
               {
                  _loc8_[_loc6_][_loc7_] = false;
               }
               else
               {
                  _loc17_ = this.getMapStepCodeForWalking(_loc6_,_loc7_);
                  if(_loc17_ != "")
                  {
                     _loc8_[_loc6_][_loc7_] = false;
                  }
               }
               _loc7_++;
            }
            _loc6_++;
         }
         var _loc9_:Array = [{
            "row":1,
            "column":0
         },{
            "row":-1,
            "column":0
         },{
            "row":0,
            "column":1
         },{
            "row":0,
            "column":-1
         }];
         var _loc10_:Array = new Array();
         var _loc11_:Object = {
            "extendedThisRun":false,
            "path":[{
               "row":this._playerRow,
               "column":this._playerColumn
            }]
         };
         _loc10_.push(_loc11_);
         var _loc12_:Boolean = false;
         var _loc13_:uint = 0;
         var _loc16_:Number = -1;
         while(_loc12_ == false)
         {
            _loc18_ = false;
            _loc19_ = new Array();
            _loc20_ = _loc10_.length;
            _loc21_ = 0;
            while(_loc21_ < _loc20_)
            {
               _loc13_++;
               _loc14_ = _loc10_[_loc21_];
               _loc14_.extendedThisRun = false;
               _loc15_ = _loc14_.path;
               _loc22_ = uint(_loc15_[_loc15_.length - 1].row);
               _loc23_ = uint(_loc15_[_loc15_.length - 1].column);
               _loc24_ = 0;
               while(_loc24_ < _loc9_.length)
               {
                  if(_loc16_ == -1)
                  {
                     _loc25_ = _loc9_[_loc24_];
                     _loc26_ = _loc22_ + _loc25_.row;
                     _loc27_ = _loc23_ + _loc25_.column;
                     if(_loc8_[_loc26_] != null)
                     {
                        if(_loc8_[_loc26_][_loc27_] != null)
                        {
                           if(_loc8_[_loc26_][_loc27_])
                           {
                              if(_loc14_.extendedThisRun == false)
                              {
                                 _loc15_.push({
                                    "row":_loc26_,
                                    "column":_loc27_
                                 });
                                 if(_loc3_ == _loc26_ && _loc4_ == _loc27_)
                                 {
                                    _loc16_ = _loc21_;
                                    _loc21_ = _loc20_;
                                    _loc24_ = _loc9_.length;
                                 }
                                 else
                                 {
                                    _loc14_.extendedThisRun = true;
                                    _loc18_ = true;
                                 }
                              }
                              else
                              {
                                 _loc11_ = {
                                    "completed":false,
                                    "extendedThisRun":true,
                                    "path":[]
                                 };
                                 _loc28_ = 0;
                                 while(_loc28_ < _loc15_.length - 1)
                                 {
                                    _loc11_.path.push({
                                       "row":_loc15_[_loc28_].row,
                                       "column":_loc15_[_loc28_].column
                                    });
                                    _loc28_++;
                                 }
                                 _loc11_.path.push({
                                    "row":_loc26_,
                                    "column":_loc27_
                                 });
                                 if(_loc3_ == _loc26_ && _loc4_ == _loc27_)
                                 {
                                    _loc16_ = _loc10_.length;
                                    _loc21_ = _loc20_;
                                    _loc24_ = _loc9_.length;
                                 }
                                 else
                                 {
                                    _loc18_ = true;
                                 }
                                 _loc10_.push(_loc11_);
                              }
                              _loc8_[_loc26_][_loc27_] = false;
                           }
                           else if(_loc3_ == _loc26_ && _loc4_ == _loc27_)
                           {
                              if(_loc14_.extendedThisRun)
                              {
                                 _loc15_.splice(_loc15_.length - 1,1);
                              }
                              _loc16_ = _loc21_;
                              _loc21_ = _loc20_;
                              _loc24_ = _loc9_.length;
                              this._walkingFinalInteractionRow = _loc3_;
                              this._walkingFinalInteractionColumn = _loc4_;
                           }
                        }
                     }
                  }
                  _loc24_++;
               }
               _loc21_++;
            }
            if(_loc18_ == false)
            {
               _loc12_ = true;
            }
         }
         if(_loc16_ > -1)
         {
            _loc5_ = _loc10_[_loc16_].path;
            _loc29_ = "";
            _loc30_ = 0;
            while(_loc30_ < _loc10_[_loc16_].path.length)
            {
               _loc29_ = _loc29_ + _loc10_[_loc16_].path[_loc30_].row + ":" + _loc10_[_loc16_].path[_loc30_].column + " ";
               _loc30_++;
            }
         }
         return _loc5_;
      }
      
      private function checkIfMissionIsComplete() : void
      {
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 1;
         while(_loc4_ <= dataM.myProfile.mission_rows)
         {
            _loc5_ = 1;
            for(; _loc5_ <= dataM.myProfile.mission_columns; _loc5_++)
            {
               if(this._map[_loc4_][_loc5_] == null)
               {
                  continue;
               }
               if(this._map[_loc4_][_loc5_] == "")
               {
                  continue;
               }
               _loc6_ = dataM.missionMapObjectDB[this._map[_loc4_][_loc5_]];
               switch(_loc6_.type)
               {
                  case "enemy":
                     _loc1_++;
                     break;
                  case "loot":
                     _loc2_++;
               }
            }
            _loc4_++;
         }
         if(_loc1_ == 0 && _loc2_ == 0)
         {
            this.btnAbort.disableMe();
            this.btnAbortWithText.disableMe();
            this.mcAutoplayAndGameSpeedPanel.disableAutopilotButtons();
            this.mcAutoplayAndGameSpeedPanel.disableGameSpeedButtons();
            soundM.createSound("missionComplete",1);
            this._missionCompleted = true;
            this._missionCompletedFrameCounter = 0;
            this._missionCompletedStatus = MISSION_COMPLETE_ANIM_WAIT1;
            if(dataM.useHiddenBaseMap || BMGameShortcutsHelper.missionCompletedShortcut())
            {
               this._missionCompletedFrameCounter = 39;
               this._missionCompletedStatus = MISSION_COMPLETE_ANIM_WAIT2;
            }
            this._missionCompletedGotRewardsData = false;
         }
         else if(dataM.myProfile.abortCurrentMission)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            dataM.myProfile.abortCurrentMission = false;
            this._abortMissionDueToCheating_stopOnEnterFrame = true;
         }
      }
      
      private function getNextMissionRecommendationSlot() : int
      {
         if(tutorialM.isTutorialActive())
         {
            return -1;
         }
         if(!dataM.singlePlayerM.allowNextMissionButtonInBattleResult)
         {
            return -1;
         }
         if(!dataM.singlePlayerM.finishMissionForFirstTime)
         {
            return -1;
         }
         if(!dataM.singlePlayerM.isMissionOnMainPath(this.storyID,dataM.myProfile.currentMissionSlot))
         {
            return -1;
         }
         var _loc1_:int = int(dataM.myProfile.currentMissionMode);
         var _loc2_:int = dataM.singlePlayerM.getRecommendedMissionSlot(this.storyID,_loc1_);
         var _loc3_:int = dataM.singlePlayerM.getLastCompleteMissionSlotOnPath(this.storyID,_loc1_);
         if(_loc2_ <= _loc3_)
         {
            return -1;
         }
         var _loc4_:int = dataM.singlePlayerM.getMissionDifficulty(this.storyID,_loc2_);
         var _loc5_:int = int(dataM.campaignMissionRewardsRepository.getMissionBattleCreditsCost(this.storyID,_loc2_,_loc1_,_loc4_));
         if(_loc5_ > dataM.myProfile.battleCredits)
         {
            return -1;
         }
         return _loc2_;
      }
      
      private function shouldShowNextMissionButtonInMissionCompleteScreen() : Boolean
      {
         return this.getNextMissionRecommendationSlot() > 0;
      }
      
      public function missionCompletedSuccess(param1:Array, param2:BMLevelUpData = null) : void
      {
         this._missionCompletedGotRewardsData = true;
         dataM.missionCompletedSuccess(this.storyID,param1,null,param2,this.shouldShowNextMissionButtonInMissionCompleteScreen());
      }
      
      public function missionCompletedAnimationActive() : Boolean
      {
         if(this._missionCompletedStatus == MISSION_COMPLETE_ANIM_NONE)
         {
            return false;
         }
         return true;
      }
      
      public function missionFailedClicked() : void
      {
         this.abortClickedSub();
      }
      
      private function createExplosion(param1:Number, param2:Number, param3:MovieClip = null) : void
      {
         if(dataM.newVisualEffects)
         {
            if(param3 == null)
            {
               effectsM.addAnimatedEffect("effect_getHit_phys1",this.mcMapEffectsHolder,param1,param2,1.7);
               effectsM.addAnimatedEffect("effect_explosionMedium1",this.mcMapEffectsHolder,param1,param2,2);
            }
            else
            {
               effectsM.addAnimatedEffect("effect_getHit_phys1",param3,param1,param2 - 10,1.7);
               effectsM.addAnimatedEffect("effect_explosionMedium1",param3,param1,param2 - 10,1.3,0,0,1);
            }
         }
         if(dataM.newVisualEffects == false)
         {
            effectsM.createExplosion(3,param1,param2,35,50,25,2.5,5,3,this.mcMapEffectsHolder);
            effectsM.createSparksMC(BMScreensManager.SCR_MISSION_BASE_MAP,"spark",param1,param2,3,4,40,"up","orange",true);
         }
         effectsM.createSparksMC(BMScreensManager.SCR_MISSION_BASE_MAP,"debrie",param1,param2,2,3,50,"up","",true);
         var _loc4_:Number = Math.ceil(Math.random() * 2);
         var _loc5_:String = "explosionSmall";
         if(_loc4_ == 1)
         {
            _loc5_ = "explosionMedium";
         }
         if(this.useSounds)
         {
            soundM.createSound(_loc5_,this.VOLUME_RATIO);
         }
      }
      
      private function refreshFloor() : void
      {
         this.removeFloor();
         this.mcFloor = externalAssetsM.getAsset("general","Grp_missionFloor" + dataM.myProfile.mission_themeID);
         this.mcFloorHolder.addChild(this.mcFloor);
         if(dataM.chatData.useCampaignChat)
         {
            this.mcFloor.y -= 55;
            this.mcFloor.height += 60;
         }
      }
      
      private function removeFloor() : void
      {
         if(this.mcFloor == null)
         {
            return;
         }
         this.mcFloor.parent.removeChild(this.mcFloor);
         this.mcFloor = null;
      }
      
      private function createWalls() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 1;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 1;
         while(_loc5_ <= dataM.myProfile.mission_columns)
         {
            if(this._map[dataM.myProfile.mission_rows][_loc5_] == "XX")
            {
               _loc1_++;
               if(_loc2_ == _loc5_)
               {
                  _loc3_++;
                  _loc2_++;
               }
               else
               {
                  _loc4_++;
               }
            }
            _loc5_++;
         }
         var _loc6_:String = "mo_gate2";
         if(_loc1_ == dataM.myProfile.mission_columns - 1)
         {
            _loc6_ = "mo_gate1";
         }
         this.mcGate = externalAssetsM.getAsset("general",_loc6_);
         this.mcGate.x = (-2 - dataM.myProfile.mission_columns / 2 + _loc2_) * this.SQUARE_SIZE;
         this.mcGate.y = (-1 + dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects" + (dataM.myProfile.mission_rows + 1)].addChild(this.mcGate);
         this.mcGate.visible = true;
         var _loc7_:String = "mo_wallHorizontal" + dataM.myProfile.mission_columns;
         if(dataM.myProfile.mission_difficulty > BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL)
         {
            _loc7_ = "mo_wall2Horizontal" + dataM.myProfile.mission_columns;
         }
         this.mcWallHorizontalUp = externalAssetsM.getAsset("general",_loc7_);
         this.mcWallHorizontalUp.x = (-1 - dataM.myProfile.mission_columns / 2) * this.SQUARE_SIZE;
         this.mcWallHorizontalUp.y = (-1 - dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects0"].addChild(this.mcWallHorizontalUp);
         if(dataM.myProfile.mission_difficulty > BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL)
         {
            this.mcWallHorizontalUp.width = (2 + dataM.myProfile.mission_columns) * this.SQUARE_SIZE;
         }
         _loc7_ = "mo_wallHorizontal" + (_loc3_ - 1);
         if(dataM.myProfile.mission_difficulty > 1)
         {
            _loc7_ = "mo_wall2Horizontal" + (_loc3_ - 1);
         }
         var _loc8_:Number = (-1 - dataM.myProfile.mission_columns / 2) * this.SQUARE_SIZE;
         this.mcWallHorizontalDownLeft = externalAssetsM.getAsset("general",_loc7_);
         this.mcWallHorizontalDownLeft.x = _loc8_;
         this.mcWallHorizontalDownLeft.y = (-1 + dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects" + (dataM.myProfile.mission_rows + 1)].addChild(this.mcWallHorizontalDownLeft);
         _loc7_ = "mo_wallHorizontal" + (_loc4_ - 1);
         if(dataM.myProfile.mission_difficulty > BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL)
         {
            _loc7_ = "mo_wall2Horizontal" + (_loc4_ - 1);
         }
         _loc8_ = (-_loc4_ + dataM.myProfile.mission_columns / 2) * this.SQUARE_SIZE;
         this.mcWallHorizontalDownRight = externalAssetsM.getAsset("general",_loc7_);
         this.mcWallHorizontalDownRight.x = _loc8_;
         this.mcWallHorizontalDownRight.y = (-1 + dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects" + (dataM.myProfile.mission_rows + 1)].addChild(this.mcWallHorizontalDownRight);
         if(dataM.myProfile.mission_difficulty > 1)
         {
            this.mcWallHorizontalDownRight.width = (1 + _loc4_) * this.SQUARE_SIZE;
            this.mcWallHorizontalDownLeft.width = (1 + _loc3_) * this.SQUARE_SIZE;
         }
         _loc7_ = "mo_wallVertical" + (dataM.myProfile.mission_rows - 1);
         if(dataM.myProfile.mission_difficulty > BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL)
         {
            _loc7_ = "mo_wall2Vertical" + (dataM.myProfile.mission_rows - 1);
         }
         this.mcWallVerticalLeft = externalAssetsM.getAsset("general",_loc7_);
         this.mcWallVerticalLeft.x = (-1 - dataM.myProfile.mission_columns / 2) * this.SQUARE_SIZE;
         this.mcWallVerticalLeft.y = (-1 - dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects0"].addChild(this.mcWallVerticalLeft);
         this.mcWallVerticalRight = externalAssetsM.getAsset("general",_loc7_);
         this.mcWallVerticalRight.x = dataM.myProfile.mission_columns / 2 * this.SQUARE_SIZE;
         this.mcWallVerticalRight.y = (-1 - dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects0"].addChild(this.mcWallVerticalRight);
         if(dataM.myProfile.mission_difficulty > BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL)
         {
            this.mcWallVerticalLeft.height = (1 + dataM.myProfile.mission_rows) * this.SQUARE_SIZE;
            this.mcWallVerticalRight.height = (1 + dataM.myProfile.mission_rows) * this.SQUARE_SIZE;
         }
      }
      
      private function removeWalls() : void
      {
         if(this.mcWallHorizontalUp != null)
         {
            if(this.mcWallHorizontalUp.parent != null)
            {
               this.mcWallHorizontalUp.parent.removeChild(this.mcWallHorizontalUp);
               this.mcWallHorizontalDownLeft.parent.removeChild(this.mcWallHorizontalDownLeft);
               this.mcWallHorizontalDownRight.parent.removeChild(this.mcWallHorizontalDownRight);
               this.mcWallVerticalLeft.parent.removeChild(this.mcWallVerticalLeft);
               this.mcWallVerticalRight.parent.removeChild(this.mcWallVerticalRight);
               this.mcGate.parent.removeChild(this.mcGate);
               this.mcWallHorizontalUp = null;
               this.mcWallHorizontalDownLeft = null;
               this.mcWallHorizontalDownRight = null;
               this.mcWallVerticalLeft = null;
               this.mcWallVerticalRight = null;
               this.mcGate = null;
            }
         }
      }
      
      private function createMechDefaultStats(param1:uint) : void
      {
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         var _loc2_:BMMissionMechStats = dataM.myProfile.mission_mechStats[param1 - 1];
         if(_loc2_.missionOriginValuesCreated)
         {
            return;
         }
         var _loc3_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc4_:BMMechStructure = _loc3_.mechStructures[param1];
         if(_loc4_.torso > 0)
         {
            _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc4_.torso);
            _loc6_ = dataM.itemsDB[_loc5_.itemID];
            _loc2_.hpMax = _loc6_.HPBase;
            _loc2_.energyOrigin = _loc6_.energyBase;
            _loc2_.energyRegenerationOrigin = _loc6_.energyAddon;
            _loc2_.heatOrigin = _loc6_.heatBase;
            _loc2_.heatCoolingOrigin = _loc6_.heatAddon;
            _loc2_.bulletsOrigin = _loc6_.bullets;
            _loc2_.rocketsOrigin = _loc6_.rockets;
         }
         if(_loc4_.leg > 0)
         {
            _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc4_.leg);
            _loc6_ = dataM.itemsDB[_loc5_.itemID];
            _loc2_.hpMax += _loc6_.HPBase;
         }
         var _loc7_:uint = 1;
         while(_loc7_ <= dataM.maxEquipment[BMMechStructure.MODULE])
         {
            if(_loc4_[BMMechStructure.MODULE + _loc7_] != 0)
            {
               _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc4_[BMMechStructure.MODULE + _loc7_]);
               _loc6_ = dataM.itemsDB[_loc5_.itemID];
               _loc2_.hpMax += _loc6_.HPBase;
               _loc2_.energyOrigin += _loc6_.energyBase;
               _loc2_.energyRegenerationOrigin += _loc6_.energyAddon;
               _loc2_.heatOrigin += _loc6_.heatBase;
               _loc2_.heatCoolingOrigin += _loc6_.heatAddon;
               _loc2_.bulletsOrigin += _loc6_.bullets;
               _loc2_.rocketsOrigin += _loc6_.rockets;
            }
            _loc7_++;
         }
         _loc2_.energyOrigin = BMMechStatsResolver.getEnergyBase(_loc2_.energyOrigin,dataM.player1PlayerID);
         _loc2_.energyRegenerationOrigin = BMMechStatsResolver.getEnergyAddon(_loc2_.energyRegenerationOrigin,dataM.player1PlayerID);
         _loc2_.heatOrigin = BMMechStatsResolver.getHeatBase(_loc2_.heatOrigin,dataM.player1PlayerID);
         _loc2_.heatCoolingOrigin = BMMechStatsResolver.getHeatAddon(_loc2_.heatCoolingOrigin,dataM.player1PlayerID);
         _loc2_.hpMax = BMMechStatsResolver.getHPMax(_loc2_.hpMax,dataM.player1PlayerID);
         _loc2_.hpMax -= dataM.getOverloadHPPenaltyForWeight(_loc4_.mechWeight);
         if(dataM.hasHpBonus())
         {
            _loc2_.hpMax = Math.ceil(_loc2_.hpMax * 1.2);
         }
         _loc2_.missionOriginValuesCreated = true;
      }
      
      private function get battleMechsPerPlayer() : uint
      {
         if(dataM.myProfile.currentStoryID == BMSinglePlayerManager.STORY_ID_RAID)
         {
            return dataM.raidData.mechsPerPlayer;
         }
         return BMSinglePlayerManager.MECHS_PER_STORY_ID[this.storyID];
      }
      
      private function createAllMechsDefaultStats() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= this.battleMechsPerPlayer)
         {
            this.createMechDefaultStats(_loc1_);
            _loc1_++;
         }
      }
      
      private function setMechToDefaultStats(param1:uint) : void
      {
         var _loc2_:BMMissionMechStats = dataM.myProfile.mission_mechStats[param1 - 1];
         _loc2_.hp = _loc2_.hpMax;
         _loc2_.energy = _loc2_.energyOrigin;
         _loc2_.energyRegeneration = _loc2_.energyRegenerationOrigin;
         _loc2_.heat = _loc2_.heatOrigin;
         _loc2_.heatCooling = _loc2_.heatCoolingOrigin;
         _loc2_.bullets = _loc2_.bulletsOrigin;
         _loc2_.rockets = _loc2_.rocketsOrigin;
      }
      
      private function setAllMechsToDefaultStats() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= this.battleMechsPerPlayer)
         {
            this.setMechToDefaultStats(_loc1_);
            _loc1_++;
         }
      }
      
      private function refreshCurrentMechStats(param1:Boolean = false) : void
      {
         if(this.useAnimations == false)
         {
            param1 = false;
         }
         this.mcMechStats.mcBarHP.setFill(this.currentMechStats.hp / this.currentMechStats.hpMax,param1);
         this.mcMechStats.mcBarRockets.setFill(this.currentMechStats.rockets / this.currentMechStats.rocketsOrigin,param1);
         var _loc2_:String = TextUtils.getNumberWithComma(this.currentMechStats.hp) + " / " + TextUtils.getNumberWithComma(this.currentMechStats.hpMax);
         updateTextAndFormat(this.mcMechStats.txtHP,_loc2_);
         var _loc3_:String = "<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>";
         var _loc4_:String = "";
         var _loc5_:String = "";
         if(this.currentMechStats.energy > this.currentMechStats.energyOrigin)
         {
            _loc4_ = _loc3_ + this.currentMechStats.energy + "</FONT>";
            _loc5_ = _loc3_ + this.currentMechStats.energyRegeneration + "</FONT>";
         }
         else
         {
            _loc4_ = String(this.currentMechStats.energy);
            _loc5_ = String(this.currentMechStats.energyRegeneration);
         }
         this.mcMechStats.txtEnergy.htmlText = _loc4_;
         this.mcMechStats.txtEnergyRegeneration.htmlText = _loc5_;
         var _loc6_:String = "";
         var _loc7_:String = "";
         if(this.currentMechStats.heat > this.currentMechStats.heatOrigin)
         {
            _loc6_ = _loc3_ + this.currentMechStats.heat + "</FONT>";
            _loc7_ = _loc3_ + this.currentMechStats.heatCooling + "</FONT>";
         }
         else
         {
            _loc6_ = String(this.currentMechStats.heat);
            _loc7_ = String(this.currentMechStats.heatCooling);
         }
         this.mcMechStats.txtHeat.htmlText = _loc6_;
         this.mcMechStats.txtHeatCooling.htmlText = _loc7_;
         if(this.currentMechStats.bulletsOrigin == 0)
         {
            this.mcMechStats.mcBullets.visible = false;
            this.mcMechStats.mcBarBullets.visible = false;
            this.mcMechStats.txtBullets.text = "";
         }
         else
         {
            this.mcMechStats.mcBullets.visible = true;
            this.mcMechStats.mcBarBullets.visible = true;
            this.mcMechStats.mcBarBullets.setFill(this.currentMechStats.bullets / this.currentMechStats.bulletsOrigin,param1);
            this.mcMechStats.txtBullets.text = this.currentMechStats.bullets + " / " + this.currentMechStats.bulletsOrigin;
         }
         if(this.currentMechStats.rocketsOrigin == 0)
         {
            this.mcMechStats.mcRockets.visible = false;
            this.mcMechStats.mcBarRockets.visible = false;
            this.mcMechStats.txtRockets.text = "";
         }
         else
         {
            this.mcMechStats.mcRockets.visible = true;
            this.mcMechStats.mcBarRockets.visible = true;
            this.mcMechStats.mcBarRockets.setFill(this.currentMechStats.rockets / this.currentMechStats.rocketsOrigin,param1);
            this.mcMechStats.txtRockets.text = this.currentMechStats.rockets + " / " + this.currentMechStats.rocketsOrigin;
         }
         this.mcMechStats.mcEnergyRegeneration.x = this._energyRegenerationIconOriginXPos;
         this.mcMechStats.mcHeatCooling.x = this._heatCoolingIconOriginXPos;
         this.mcMechStats.txtEnergyRegeneration.x = this._energyRegenerationTextOriginXPos;
         this.mcMechStats.txtHeatCooling.x = this._heatCoolingTextOriginXPos;
         if(this.currentMechStats.bulletsOrigin == 0 && this.currentMechStats.rocketsOrigin == 0)
         {
            this.mcMechStats.mcEnergyRegeneration.x = 144;
            this.mcMechStats.mcHeatCooling.x = 144;
            this.mcMechStats.txtEnergyRegeneration.x = 166.75;
            this.mcMechStats.txtHeatCooling.x = 166.75;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionMap_stats",[this.mcMechStats.txtEnergy,this.mcMechStats.txtEnergyRegeneration,this.mcMechStats.txtHeat,this.mcMechStats.txtHeatCooling,this.mcMechStats.txtBullets,this.mcMechStats.txtRockets],"",this.mcMechStats);
         }
         this.redrawHPTextForMobile();
      }
      
      private function redrawHPTextForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionMap_hp",[this.mcMechStats.txtHP],"",this.mcMechStats);
         }
      }
      
      private function get currentMechStats() : BMMissionMechStats
      {
         return dataM.myProfile.missionCurrentMechStats;
      }
      
      private function createMapPickups(param1:Number, param2:Number, param3:String, param4:String, param5:uint) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         dataM.mission_destroyingMapObjectRow = param1;
         dataM.mission_destroyingMapObjectColumn = param2;
         if(param5 == 1)
         {
            this.createSpecificMapPickup(param1,param2,param3,param4,0);
         }
         else
         {
            _loc6_ = param5;
            while(_loc6_ >= 1)
            {
               _loc7_ = (_loc6_ - 1) * 15;
               this.createSpecificMapPickup(param1,param2,param3,param4,_loc7_);
               _loc6_--;
            }
         }
      }
      
      private function getVisualMissionDifficulty() : int
      {
         return dataM.myProfile.currentMissionMode + 1;
      }
      
      private function createSpecificMapPickup(param1:Number, param2:Number, param3:String, param4:String, param5:uint) : void
      {
         this.createSpecificInterfacePickup(param3,param4);
         if(this.useAnimations == false)
         {
            return;
         }
         var _loc6_:String = param4;
         if(_loc6_ == "loot")
         {
            switch(this.getVisualMissionDifficulty())
            {
               case BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL:
                  _loc6_ += "A";
                  break;
               case BMSinglePlayerManager.MISSION_DIFFICULTY_HARD:
                  _loc6_ += "B";
                  break;
               case BMSinglePlayerManager.MISSION_DIFFICULTY_INSANE:
                  _loc6_ += "C";
            }
         }
         _loc6_ = "icon_" + _loc6_;
         var _loc7_:Sprite = externalAssetsM.getAsset("general",_loc6_);
         var _loc8_:Number = (param2 - 0.5 - dataM.myProfile.mission_columns / 2) * this.SQUARE_SIZE;
         var _loc9_:Number = (param1 - 0.5 - dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
         _loc7_.x = _loc8_;
         _loc7_.y = _loc9_;
         var _loc10_:BMBaseMapPickupData = new BMBaseMapPickupData();
         _loc10_.framesCounter = 0;
         _loc10_.type = param3;
         _loc10_.name = param4;
         if(param5 > 0)
         {
            _loc10_.state = BMBaseMapPickupData.STATE_WAIT;
            _loc10_.waitFrames = param5;
         }
         else
         {
            _loc10_.state = BMBaseMapPickupData.STATE_GO_UP;
         }
         _loc10_.grp = _loc7_;
         this.mcMapHolder["holder_objects" + param1].addChild(_loc7_);
         this._mapPickups.push(_loc10_);
      }
      
      private function mapPickupsHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:BMBaseMapPickupData = null;
         if(this._mapPickups.length > 0)
         {
            _loc1_ = this._mapPickups.length - 1;
            while(_loc1_ >= 0)
            {
               _loc2_ = this._mapPickups[_loc1_];
               ++_loc2_.framesCounter;
               switch(_loc2_.state)
               {
                  case BMBaseMapPickupData.STATE_WAIT:
                     if(_loc2_.framesCounter >= _loc2_.waitFrames)
                     {
                        _loc2_.framesCounter = 0;
                        _loc2_.state = BMBaseMapPickupData.STATE_GO_UP;
                     }
                     break;
                  case BMBaseMapPickupData.STATE_GO_UP:
                     _loc2_.grp.y -= 12 - _loc2_.framesCounter * 2;
                     if(_loc2_.framesCounter == 1)
                     {
                        if(this.useSounds)
                        {
                           soundM.createSound("kitUsed",1);
                        }
                     }
                     else if(_loc2_.framesCounter >= 5)
                     {
                        _loc2_.framesCounter = 0;
                        _loc2_.state = BMBaseMapPickupData.STATE_GROW;
                     }
                     break;
                  case BMBaseMapPickupData.STATE_GROW:
                     _loc2_.grp.scaleX += 0.1;
                     _loc2_.grp.scaleY += 0.1;
                     if(_loc2_.framesCounter >= 5)
                     {
                        _loc2_.framesCounter = 0;
                        _loc2_.state = BMBaseMapPickupData.STATE_SHRINK;
                     }
                     break;
                  case BMBaseMapPickupData.STATE_SHRINK:
                     _loc2_.grp.scaleX -= 0.2;
                     _loc2_.grp.scaleY -= 0.2;
                     if(_loc2_.framesCounter >= 7)
                     {
                        _loc2_.grp.parent.removeChild(_loc2_.grp);
                        _loc2_.grp = null;
                        this._mapPickups[_loc1_] = null;
                        this._mapPickups.splice(_loc1_,1);
                     }
               }
               _loc1_--;
            }
         }
      }
      
      private function removeAllMapPickups() : void
      {
         var _loc2_:BMBaseMapPickupData = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._mapPickups.length)
         {
            _loc2_ = this._mapPickups[_loc1_];
            _loc2_.grp.parent.removeChild(_loc2_.grp);
            _loc2_.grp = null;
            this._mapPickups[_loc1_] = null;
            _loc1_++;
         }
         this._mapPickups = new Array();
      }
      
      private function createXpReward() : void
      {
         if(this._createFlyingRewardXPValue <= 0)
         {
            return;
         }
         dataM.myProfile.mission_xp += this._createFlyingRewardXPValue;
         if(this.useAnimations)
         {
            this.createFlyingReward(new mcFlyingXp(),this._createFlyingRewardXPValue,this._createFlyingRewardRow,this._createFlyingRewardColumn,14);
         }
         this.refreshLootGoldAndXp();
         this._createFlyingRewardXPValue = 0;
      }
      
      private function createGoldReward() : void
      {
         if(this._createFlyingRewardGoldValue <= 0)
         {
            return;
         }
         dataM.myProfile.mission_gold += this._createFlyingRewardGoldValue;
         if(this.useAnimations)
         {
            this.createFlyingReward(new mcFlyingGold(),this._createFlyingRewardGoldValue,this._createFlyingRewardRow,this._createFlyingRewardColumn);
         }
         this.refreshLootGoldAndXp();
         this._createFlyingRewardGoldValue = 0;
      }
      
      private function createFlyingReward(param1:MovieClip, param2:uint, param3:uint, param4:uint, param5:uint = 0) : void
      {
         param1.textField.text = TextUtils.getNumberWithComma(param2);
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         if(dataM.runAsMobile)
         {
            _loc6_ = -param1.textField.x;
            _loc7_ = -param1.textField.y;
            param1.textField.x = 0;
            param1.textField.y = 0;
            param1.mcIcon.x += _loc6_;
            param1.mcIcon.y += _loc7_;
         }
         var _loc8_:BMItem = new BMItem();
         _loc8_.initialize(0,param1.width,param1.height,param1,0,0,false,null,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            _loc8_.createAssetsBitmap([param1.textField],[param1.mcIcon],param1);
            _loc8_.assetsBitmap.x -= _loc6_;
            _loc8_.assetsBitmap.y -= _loc7_;
         }
         _loc8_.x = this.getObjectXPos(param4);
         _loc8_.y = this.getObjectYPos(param3);
         var _loc9_:Object = new Object();
         _loc9_.item = _loc8_;
         _loc9_.frameCounter = 0;
         if(param5 > 0)
         {
            _loc9_.delayFrames = param5;
         }
         this._flyingRewards.push(_loc9_);
      }
      
      private function createUpgrade() : void
      {
         if(this._createUpgrade == "")
         {
            return;
         }
         var _loc1_:String = dataM.missionUpgradesDB[this._createUpgrade];
         this.createSpecificMapPickup(this._createUpgradeRow,this._createUpgradeColumn,"upgrade",_loc1_,25);
         dataM.myProfile.mission_upgrades.push(dataM.missionUpgradesReverseDB[_loc1_]);
         this._createUpgrade = "";
      }
      
      private function upgradesClickedForWeb(param1:MouseEvent) : void
      {
         this.upgradesClicked();
      }
      
      public function upgradesClicked(param1:Number = -1) : void
      {
         if(this.autopilotActive)
         {
            if(this.isUpgradesBarVisibleInScreen() && this._missionCompleted == false && dataM.myProfile.missionCurrentMechStats.hp > 0)
            {
               this.mcAutoplayAndGameSpeedPanel.activateUserAutopilotArrow();
            }
            return;
         }
         this.upgradesClickedSub(param1);
      }
      
      public function upgradesClickedSub(param1:Number = -1) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         tooltip.hideToolTip();
         if(this._missionCompleted)
         {
            return;
         }
         if(this._saving)
         {
            this.activateSavingAnimation();
            return;
         }
         if(param1 > -1)
         {
            this._lastRollOverredPickupSlot = param1;
         }
         if(this._lastRollOverredPickupSlot <= -1)
         {
            return;
         }
         var _loc2_:uint = 1;
         var _loc3_:String = dataM.missionUpgradesReverseDB[this._interfacePickups[_loc2_][this._lastRollOverredPickupSlot].name];
         var _loc4_:Boolean = true;
         if(this._firstUpgradeTutorial == false)
         {
            switch(_loc3_)
            {
               case UPGRADE_HP:
                  if(this.currentMechStats.hp >= this.currentMechStats.hpMax)
                  {
                     _loc4_ = false;
                  }
            }
         }
         if(_loc4_)
         {
            if(tutorialM.isTutorialActive() == false)
            {
               remoteM.socketM.mission_useUpgrade(_loc3_,dataM.myProfile.missionCurrentMechID);
            }
            _loc5_ = this._interfacePickups[_loc2_][this._lastRollOverredPickupSlot];
            switch(_loc5_.name)
            {
               case "upgradeHP":
                  this.currentMechStats.hp += Math.ceil(this.currentMechStats.hpMax * dataM.missionUpgrade_hpRatio / 100);
                  if(this.currentMechStats.hp > this.currentMechStats.hpMax)
                  {
                     this.currentMechStats.hp = this.currentMechStats.hpMax;
                  }
                  break;
               case "upgradeEnergy":
                  this.currentMechStats.energy += Math.ceil(this.currentMechStats.energyOrigin * dataM.missionUpgrade_energyRatio / 100);
                  this.currentMechStats.energyRegeneration += Math.ceil(this.currentMechStats.energyRegenerationOrigin * dataM.missionUpgrade_energyRatio / 100);
                  break;
               case "upgradeHeat":
                  this.currentMechStats.heat += Math.ceil(this.currentMechStats.heatOrigin * dataM.missionUpgrade_heatRatio / 100);
                  this.currentMechStats.heatCooling += Math.ceil(this.currentMechStats.heatCoolingOrigin * dataM.missionUpgrade_heatRatio / 100);
            }
            if(dataM.useHiddenBaseMap)
            {
               screensM.screenBattle.baseUpgradeUsed(_loc5_.name,this.currentMechStats);
            }
            this.refreshCurrentMechStats(true);
            _loc5_.grp.parent.removeChild(_loc5_.grp);
            _loc5_.grp = null;
            this._interfacePickups[_loc2_][this._lastRollOverredPickupSlot] = null;
            this._interfacePickups[_loc2_].splice(this._lastRollOverredPickupSlot,1);
            dataM.myProfile.mission_upgrades.splice(this._lastRollOverredPickupSlot,1);
            _loc6_ = this._interfacePickups[_loc2_].length - 1;
            _loc7_ = this.INTERFACE_PICKUPS_X_JUMP;
            if(_loc6_ * _loc7_ > this.INTERFACE_PICKUPS_X_MAX)
            {
               _loc7_ = this.INTERFACE_PICKUPS_X_MAX / _loc6_;
            }
            _loc8_ = 0;
            while(_loc8_ < this._interfacePickups[_loc2_].length)
            {
               _loc5_ = this._interfacePickups[_loc2_][_loc8_];
               _loc5_.targetXPos = this.mcLoot.mcLootPointer.x - _loc6_ * _loc7_ / 2 + _loc7_ * _loc8_;
               _loc8_++;
            }
            this._lastRollOverredPickupSlot = -1;
            this.pickupsTooltipHandler();
            if(tutorialM.isTutorialActive())
            {
               dataM.saveGuestData("missionBaseMap upgradesClickedSub");
            }
            else
            {
               this.activateSaving("upgradesClickedSub");
            }
            this._interfacePickupsAnimationActive = true;
            if(this.useSounds)
            {
               soundM.createSound("kitUsed",1);
            }
            if(this._firstUpgradeTutorial)
            {
               this._firstUpgradeTutorial = false;
               this.mcTutorialArrow_usePickup.gotoAndStop("animOff");
               this.refreshTutorial();
            }
         }
      }
      
      public function upgradeUsed() : void
      {
         this.deactivateSaving(false);
      }
      
      private function createInterfacePickups(param1:String, param2:String, param3:uint) : void
      {
         var _loc4_:uint = 1;
         while(_loc4_ <= param3)
         {
            this.createSpecificInterfacePickup(param1,param2);
            _loc4_++;
         }
      }
      
      private function createSpecificInterfacePickup(param1:String, param2:String) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:MovieClip = null;
         var _loc13_:Object = null;
         var _loc3_:String = param2;
         if(_loc3_ == "loot")
         {
            switch(this.getVisualMissionDifficulty())
            {
               case BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL:
                  _loc3_ += "A";
                  break;
               case BMSinglePlayerManager.MISSION_DIFFICULTY_HARD:
                  _loc3_ += "B";
                  break;
               case BMSinglePlayerManager.MISSION_DIFFICULTY_INSANE:
                  _loc3_ += "C";
            }
         }
         _loc3_ = "icon_" + _loc3_;
         var _loc4_:Sprite = externalAssetsM.getAsset("general",_loc3_);
         switch(param1)
         {
            case "loot":
               return;
            case "upgrade":
               _loc7_ = this.mcUpgrades;
               _loc5_ = Number(this.mcUpgrades.mcUpgradesPointer.y);
               _loc6_ = 1;
         }
         var _loc8_:uint = uint(this._interfacePickups[_loc6_].length);
         var _loc9_:uint = this.INTERFACE_PICKUPS_X_JUMP;
         if(_loc8_ * _loc9_ > this.INTERFACE_PICKUPS_X_MAX)
         {
            _loc9_ = this.INTERFACE_PICKUPS_X_MAX / _loc8_;
         }
         var _loc10_:Number = this.mcLoot.mcLootPointer.x + _loc8_ * _loc9_ / 2;
         var _loc11_:uint = 0;
         while(_loc11_ < this._interfacePickups[_loc6_].length)
         {
            _loc13_ = this._interfacePickups[_loc6_][_loc11_];
            _loc13_.targetXPos = this.mcLoot.mcLootPointer.x - _loc8_ * _loc9_ / 2 + _loc9_ * _loc11_;
            _loc11_++;
         }
         _loc4_.x = _loc10_;
         _loc4_.y = _loc5_;
         _loc4_.scaleX = 0.1;
         _loc4_.scaleY = 0.1;
         _loc4_.visible = false;
         var _loc12_:Object = new Object();
         _loc12_.framesCounter = 0;
         _loc12_.targetXPos = _loc10_;
         _loc12_.state = "wait";
         if(this.useAnimations == false)
         {
            _loc12_.state = "done";
            _loc4_.scaleX = 1;
            _loc4_.scaleY = 1;
            _loc4_.visible = true;
         }
         _loc12_.type = param1;
         _loc12_.name = param2;
         _loc12_.grp = _loc4_;
         _loc7_.addChild(_loc4_);
         this._interfacePickups[_loc6_].push(_loc12_);
         this._interfacePickupsAnimationActive = true;
      }
      
      private function interfacePickupsHandler() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         if(this._interfacePickupsAnimationActive == false)
         {
            return;
         }
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this._interfacePickups.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this._interfacePickups[_loc2_].length)
            {
               _loc4_ = this._interfacePickups[_loc2_][_loc3_];
               ++_loc4_.framesCounter;
               switch(_loc4_.state)
               {
                  case "wait":
                     if(_loc4_.framesCounter >= 30)
                     {
                        _loc4_.framesCounter = 0;
                        _loc4_.state = "grow";
                        _loc4_.grp.visible = true;
                     }
                     break;
                  case "grow":
                     _loc4_.grp.scaleX += 0.2;
                     _loc4_.grp.scaleY += 0.2;
                     if(_loc4_.framesCounter >= 7)
                     {
                        _loc4_.framesCounter = 0;
                        _loc4_.state = "shrink";
                     }
                     break;
                  case "shrink":
                     _loc4_.grp.scaleX -= 0.1;
                     _loc4_.grp.scaleY -= 0.1;
                     if(_loc4_.framesCounter >= 4)
                     {
                        _loc4_.framesCounter = 0;
                        _loc4_.state = "done";
                     }
                     break;
                  case "done":
               }
               if(_loc4_.targetXPos != _loc4_.grp.x)
               {
                  _loc5_ = _loc4_.targetXPos - _loc4_.grp.x;
                  if(Math.abs(_loc5_) > 1)
                  {
                     _loc4_.grp.x += _loc5_ * 0.3;
                  }
                  else
                  {
                     _loc4_.grp.x = _loc4_.targetXPos;
                  }
               }
               if(_loc4_.state != "done" || _loc4_.targetXPos != _loc4_.grp.x)
               {
                  _loc1_++;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc1_ == 0)
         {
            this._interfacePickupsAnimationActive = false;
         }
      }
      
      private function removeAllInterfacePickups() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._interfacePickups.length)
         {
            _loc2_ = 0;
            while(_loc2_ < this._interfacePickups[_loc1_].length)
            {
               _loc3_ = this._interfacePickups[_loc1_][_loc2_];
               _loc3_.grp.parent.removeChild(_loc3_.grp);
               _loc3_.grp = null;
               this._interfacePickups[_loc1_][_loc2_] = null;
               _loc2_++;
            }
            this._interfacePickups[_loc1_] = new Array();
            _loc1_++;
         }
         this._interfacePickups = new Array();
      }
      
      private function pickupsTooltipHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Sprite = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:String = null;
         var _loc13_:uint = 0;
         var _loc14_:String = null;
         if(screensM.isScreenOpened(BMScreensManager.SCR_DISPLAY_REWARD))
         {
            if(this._lastRollOverredPickupSlot > -1)
            {
               this._lastRollOverredPickupSlot = -1;
               tooltip.hideToolTip();
            }
         }
         else
         {
            _loc1_ = false;
            if(mouseX > this.mcPickupsMouseHitArea.x && mouseX < this.mcPickupsMouseHitArea.x + this.mcPickupsMouseHitArea.width)
            {
               if(mouseY > this.mcPickupsMouseHitArea.y && mouseY < this.mcPickupsMouseHitArea.y + this.mcPickupsMouseHitArea.height)
               {
                  _loc1_ = true;
               }
            }
            _loc2_ = mouseX - this.mcUpgrades.x;
            _loc3_ = mouseY - this.mcUpgrades.y;
            if(_loc1_)
            {
               _loc4_ = -1;
               _loc5_ = 999;
               _loc6_ = 1;
               _loc7_ = 0;
               while(_loc7_ < this._interfacePickups[_loc6_].length)
               {
                  _loc8_ = this._interfacePickups[_loc6_][_loc7_].grp;
                  _loc9_ = _loc8_.x - _loc2_;
                  _loc10_ = _loc8_.y - _loc3_;
                  _loc11_ = dataM.getVectorSize(_loc9_,_loc10_);
                  if(_loc11_ < 30)
                  {
                     if(_loc5_ > _loc11_)
                     {
                        _loc5_ = _loc11_;
                        _loc4_ = _loc7_;
                     }
                  }
                  _loc7_++;
               }
               if(_loc4_ > -1)
               {
                  if(this._lastRollOverredPickupSlot != _loc4_)
                  {
                     this._lastRollOverredPickupSlot = _loc4_;
                     _loc12_ = "";
                     _loc13_ = 0;
                     switch(this._interfacePickups[_loc6_][_loc4_].name)
                     {
                        case "upgradeHP":
                           _loc12_ = "upgradeHP";
                           _loc13_ = dataM.missionUpgrade_hpRatio;
                           break;
                        case "upgradeEnergy":
                           _loc12_ = "upgradeEnergy";
                           _loc13_ = dataM.missionUpgrade_energyRatio;
                           break;
                        case "upgradeHeat":
                           _loc12_ = "upgradeHeat";
                           _loc13_ = dataM.missionUpgrade_heatRatio;
                     }
                     if(dataM.runAsMobile == false)
                     {
                        _loc14_ = getScreenText(_loc12_);
                        _loc14_ = dataM.replaceStringInText(_loc14_,"%RATIO%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>" + _loc13_ + "</FONT>");
                        tooltip.showToolTip("regularText",_loc14_);
                     }
                  }
               }
               else if(this._lastRollOverredPickupSlot > -1)
               {
                  this._lastRollOverredPickupSlot = -1;
                  tooltip.hideToolTip();
               }
            }
            else if(this._lastRollOverredPickupSlot > -1)
            {
               this._lastRollOverredPickupSlot = -1;
               tooltip.hideToolTip();
            }
         }
      }
      
      private function refreshLootGoldAndXp() : void
      {
         if(dataM.myProfile.mission_gold == 0)
         {
            this.mcLoot.mcGold.visible = false;
         }
         else
         {
            this.mcLoot.mcGold.visible = true;
            this.mcLoot.mcGold.text = TextUtils.getNumberWithComma(dataM.myProfile.mission_gold);
         }
         if(dataM.myProfile.mission_xp == 0)
         {
            this.mcLoot.mcXp.visible = false;
         }
         else
         {
            this.mcLoot.mcXp.visible = true;
            this.mcLoot.mcXp.text = TextUtils.getNumberWithComma(dataM.myProfile.mission_xp);
         }
      }
      
      public function removeLootPickup() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc1_ = 0;
         if(this._interfacePickups[_loc1_].length > 0)
         {
            _loc3_ = this._interfacePickups[_loc1_].length - 1;
            _loc2_ = this._interfacePickups[_loc1_][_loc3_];
            _loc2_.grp.parent.removeChild(_loc2_.grp);
            _loc2_.grp = null;
            this._interfacePickups[_loc1_].splice(_loc3_,1);
         }
         if(this._interfacePickups[_loc1_].length > 0)
         {
            _loc4_ = this._interfacePickups[_loc1_].length - 1;
            _loc5_ = this.INTERFACE_PICKUPS_X_JUMP;
            if(_loc4_ * _loc5_ > this.INTERFACE_PICKUPS_X_MAX)
            {
               _loc5_ = this.INTERFACE_PICKUPS_X_MAX / _loc4_;
            }
            _loc3_ = 0;
            while(_loc3_ < this._interfacePickups[_loc1_].length)
            {
               _loc2_ = this._interfacePickups[_loc1_][_loc3_];
               _loc2_.targetXPos = this.mcLoot.mcLootPointer.x - _loc4_ * _loc5_ / 2 + _loc5_ * _loc3_;
               _loc3_++;
            }
            this._interfacePickupsAnimationActive = true;
         }
      }
      
      public function abortClicked(param1:Event) : void
      {
         this.abortClickedSub();
      }
      
      private function abortClickedSub() : void
      {
         if(screensM.screenBlack.isActive())
         {
            return;
         }
         if(this.autopilotActive && dataM.clientRunningLocally == false)
         {
            this.mcAutoplayAndGameSpeedPanel.activateUserAutopilotArrow();
            return;
         }
         if(this._saving == false)
         {
            if(this.isAnimationActive() == false)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("abortMission",-1,-1);
            }
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("missionSavingProgress");
            this.activateSavingAnimation();
         }
      }
      
      public function abortingMission() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMWorldMapLocationData = null;
         _loc1_ = 0;
         if(dataM.raidData.isRaidInProgress() == false)
         {
            _loc2_ = dataM.singlePlayerM.currentMissionDB;
            if(dataM.myProfile.getCurrentMissionProgress(this.storyID) == BMSinglePlayerManager.MAP_PROGRESS_IN_PROGRESS)
            {
               dataM.myProfile.updateCurrentMissionProgress(this.storyID,BMSinglePlayerManager.MAP_PROGRESS_INCOMPLETE);
            }
            else
            {
               dataM.myProfile.updateCurrentMissionProgress(this.storyID,BMSinglePlayerManager.MAP_PROGRESS_COMPLETE);
            }
            _loc1_ = _loc2_.locationID;
         }
         this.btnAbort.disableMe();
         this.btnAbortWithText.disableMe();
         this.trackMissionEvent("Abort");
         remoteM.socketM.mission_abort(_loc1_);
      }
      
      public function missionAborted(param1:uint, param2:int, param3:BMLevelUpData) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:BMRewardData = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         dataM.mission_battleEnded = false;
         dataM.myProfile.lastBattleResult = BMDataManager.BATTLE_RESULT_LOSS;
         dataM.myProfile.lastXPGained = param2;
         dataM.myProfile.XP += param2;
         dataM.myProfile.gold += param1;
         _loc4_ = BMGameOfWhalesManager.SOURCE_MISSION_LOSS;
         _loc5_ = BMGameOfWhalesManager.PLACE_CAMPAIGN;
         dataM.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_GOLD,param1,_loc4_,_loc5_);
         dataM.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_XP,param2,_loc4_,_loc5_);
         dataM.myProfile.mission_gold = 0;
         dataM.myProfile.mission_xp = 0;
         dataM.myProfile.levelUpData = param3;
         _loc6_ = new BMRewardData();
         _loc6_.levelUpData = param3;
         _loc7_ = 0;
         _loc8_ = 0;
         screensM.addScreen(BMScreensManager.SCR_BATTLE_RESULT);
         screensM.screenBattleResult.setPrizes(param1,param2,_loc7_,_loc8_,_loc6_);
         screensM.screenBattleResult.refreshScreen();
      }
      
      public function notifyUserSelectedNextMission() : void
      {
         this.continueToNextMission = true;
      }
      
      public function exitScreen() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(this.continueToNextMission)
         {
            screensM.screenBlack.activateBlackScreen(null,true,true,null,0,true,this.exitScreenSub);
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.exitScreenSub,true,true,null,0);
         }
      }
      
      private function exitScreenSub() : void
      {
         dataM.myProfile.clearMissionData();
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(dataM.raidData.isRaidInProgress())
         {
            screensM.screenTransitionsManager.raidMenuClicked(true,true);
            dataM.raidData.updateRaidPendingData();
         }
         else if(this.continueToNextMission)
         {
            screensM.screenTransitionsManager.singlePlayerClicked(true,this.storyID,this.getNextMissionRecommendationSlot(),dataM.myProfile.currentMissionMode,true);
         }
         else
         {
            screensM.screenTransitionsManager.singlePlayerClicked(true,this.storyID);
         }
         soundM.resetMusicTrackParameters();
         if(screensM.isScreenOpened(BMScreensManager.SCR_DISPLAY_REWARD))
         {
            screensM.screenDisplayReward.removeMe();
         }
         if(dataM.useHiddenBaseMap)
         {
            screensM.screenBattle.cleanBattle();
         }
         this.removeMe();
      }
      
      private function openReviveDialog() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:BMMechView = null;
         if(dataM.raidData.isRaidInProgress())
         {
            this.abortingMission();
            return;
         }
         screensM.addScreen(BMScreensManager.SCR_BUY_CONFIRMATION);
         _loc1_ = dataM.playersData[dataM.player1PlayerID];
         _loc2_ = new BMMechView();
         _loc2_.initialize(dataM.player1PlayerID,"battle",BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,0.5,false);
         _loc2_.buildMech(_loc1_.mechStructures[1]);
         _loc2_.activateDefeated();
         screensM.screenBuyConfirmation.refreshScreen(BMScreenBuyConfirmation.CURRENCY_TOKENS,dataM.missionReviveTokensCost,getScreenText("reviveTitle"),getScreenText("reviveDescription"),getScreenText("revive"),getScreenText("abort"),this.reviveClicked,this.reviveCancelled,_loc2_);
      }
      
      private function reviveClicked() : void
      {
         if(this._saving)
         {
            this._triggerReviveClickedAfterSaving = true;
            return;
         }
         if(tutorialM.isTutorialActive())
         {
            this.reviveSuccessful();
         }
         else
         {
            this.trackMissionEvent("Revive");
            remoteM.socketM.mission_revive();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            this.activateSaving("reviveClicked");
         }
      }
      
      private function reviveCancelled() : void
      {
         var _loc1_:Boolean = false;
         if(this._saving)
         {
            this._triggerReviveCancelledAfterSaving = true;
            return;
         }
         _loc1_ = false;
         if(dataM.showStarterPackAfterMissionLoss && dataM.isStarterPackActive())
         {
            dataM.starterPack_displayAfterSinglePlayerMissionCounter = 3;
         }
         else if(dataM.isRewardedVideoAvailable(BMScreenWatchRewardedVideo.PLACEMENT_ABORT_MISSION))
         {
            if(this.getEnemiesDestroyed() > 0)
            {
               _loc1_ = true;
            }
         }
         if(_loc1_)
         {
            screensM.addScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO);
            screensM.screenWatchRewardedVideo.refreshScreen(screensM.screenWatchRewardedVideo.TYPE_ABORT_MISSION,dataM.myProfile.currentMissionSlot);
         }
         else
         {
            this.abortingMission();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
      }
      
      public function reviveSuccessful() : void
      {
         if(this._playerNeedsToReviveBlock)
         {
            this._playerNeedsToReviveBlock = false;
         }
         dataM.gameOfWhalesM.usedRevive();
         this.createTeleportEffectOnPlayerMech();
         this.setAllMechsToDefaultStats();
         this.playerMech.visible = true;
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.refreshCurrentMechStats(true);
         this.deactivateSaving(true);
         if(this.autopilotActive && dataM.useHiddenBaseMap == false)
         {
            this.mcAutoplayAndGameSpeedPanel.manuallyClickAutopilotOff();
         }
         if(dataM.useHiddenBaseMap)
         {
            screensM.screenBattle.cleanBattle();
            screensM.addBattleScreens();
         }
      }
      
      private function createTeleportEffectOnPlayerMech() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         _loc1_ = 160;
         _loc2_ = 1;
         if(dataM.newVisualEffects)
         {
            _loc2_ = 1.2;
         }
         effectsM.createTeleportReappear("teleportReappearAnim",this.playerMech.x,this.playerMech.y - 25,_loc1_,_loc2_,this.mcMapEffectsHolder);
         if(this.useSounds)
         {
            soundM.createSound("teleportAppear",this.VOLUME_RATIO);
         }
      }
      
      public function abortMissionClicked() : void
      {
         if(dataM.myProfile.missionCurrentMechStats.hp == 0)
         {
            this.openReviveDialog();
         }
      }
      
      public function activateSaving(param1:String = "") : void
      {
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         this._saving = true;
      }
      
      public function deactivateSaving(param1:Boolean) : void
      {
         this._saving = false;
         if(param1)
         {
            this.mcSaving.visible = false;
            this.mcSaving.alpha = 0;
            this.mcSaving.mcSandClock.gotoAndStop("animOff");
         }
         else
         {
            this._savingHandler = true;
         }
         if(this._missionCompleted == false)
         {
            this.btnAbort.enableMe();
            this.btnAbortWithText.enableMe();
         }
         if(this._triggerReviveCancelledAfterSaving)
         {
            this.reviveCancelled();
            this._triggerReviveCancelledAfterSaving = false;
            return;
         }
         if(this._triggerReviveClickedAfterSaving)
         {
            this.reviveClicked();
            this._triggerReviveClickedAfterSaving = false;
         }
      }
      
      public function activateSavingAnimation() : void
      {
         this._savingHandler = true;
         this.btnAbort.disableMe();
         this.btnAbortWithText.disableMe();
      }
      
      private function savingHandler() : void
      {
         if(this._savingHandler)
         {
            if(this._saving)
            {
               if(this.mcSaving.visible == false)
               {
                  this.mcSaving.visible = true;
                  this.mcSaving.mcSandClock.gotoAndStop("animOn");
               }
               if(this.mcSaving.alpha < 1)
               {
                  this.mcSaving.alpha += 0.1;
               }
               else
               {
                  this.mcSaving.alpha = 1;
                  this._savingHandler = false;
               }
            }
            else
            {
               if(this.mcSaving.visible)
               {
                  this.mcSaving.visible = false;
                  this.mcSaving.mcSandClock.gotoAndStop("animOff");
               }
               if(this.mcSaving.alpha > 0)
               {
                  this.mcSaving.alpha -= 0.1;
               }
               else
               {
                  this.mcSaving.alpha = 0;
                  this._savingHandler = false;
               }
            }
         }
      }
      
      private function activateMapMarker(param1:uint, param2:uint, param3:String) : void
      {
         if(this.useAnimations == false)
         {
            return;
         }
         this.mapMarker.x = this.getObjectXPos(param2);
         this.mapMarker.y = this.getObjectYPos(param1);
         this.mapMarker.mcMarker.gotoAndStop(param3);
         this.mapMarker.gotoAndPlay("animOn");
      }
      
      private function interfaceMotionHandler() : void
      {
         if(screensM.screenBlack.isActive())
         {
            return;
         }
         if(this._interfaceMotionFrameCounter <= 20)
         {
            ++this._interfaceMotionFrameCounter;
         }
         if(this._interfaceMotionFrameCounter <= 10)
         {
            return;
         }
         if(this.mcMechStats.x < this._mechStatsOriginXPos)
         {
            this.mcMechStats.x += (this._mechStatsOriginXPos - this.mcMechStats.x) * 0.3;
            if(Math.abs(this._mechStatsOriginXPos - this.mcMechStats.x) < 2)
            {
               this.mcMechStats.x = this._mechStatsOriginXPos;
            }
         }
         if(dataM.myProfile.mission_upgrades.length == 0)
         {
            if(this.mcUpgrades.x > this._upgradesOriginXPos - this.INTERFACE_X_JUMP)
            {
               this.mcUpgrades.x -= (this.mcUpgrades.x - (this._upgradesOriginXPos - this.INTERFACE_X_JUMP)) * 0.3;
               if(Math.abs(this.mcUpgrades.x - (this._upgradesOriginXPos - this.INTERFACE_X_JUMP)) < 2)
               {
                  this.mcUpgrades.x = this._upgradesOriginXPos - this.INTERFACE_X_JUMP;
               }
            }
         }
         else if(this._interfaceMotionFrameCounter > 15)
         {
            if(this.mcUpgrades.x < this._upgradesOriginXPos)
            {
               this.mcUpgrades.x += (this._upgradesOriginXPos - this.mcUpgrades.x) * 0.3;
               if(Math.abs(this._upgradesOriginXPos - this.mcUpgrades.x) < 2)
               {
                  this.mcUpgrades.x = this._upgradesOriginXPos;
               }
            }
         }
         if(dataM.myProfile.mission_loot.length > 0 || dataM.myProfile.mission_gold > 0 || dataM.myProfile.mission_xp > 0)
         {
            if(this._interfaceMotionFrameCounter > 20)
            {
               if(this.mcLoot.x < this._lootOriginXPos)
               {
                  this.mcLoot.x += (this._lootOriginXPos - this.mcLoot.x) * 0.3;
                  if(Math.abs(this._lootOriginXPos - this.mcLoot.x) < 2)
                  {
                     this.mcLoot.x = this._lootOriginXPos;
                  }
               }
            }
         }
      }
      
      private function isUpgradesBarVisibleInScreen() : Boolean
      {
         return this.mcUpgrades.x > this._upgradesOriginXPos - this.INTERFACE_X_JUMP;
      }
      
      private function flyingRewardsHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:BMItem = null;
         if(this.useAnimations == false)
         {
            return;
         }
         if(this._flyingRewards.length > 0)
         {
            _loc1_ = this._flyingRewards.length - 1;
            while(_loc1_ >= 0)
            {
               if(this._flyingRewards[_loc1_].delayFrames != null && this._flyingRewards[_loc1_].delayFrames > 0)
               {
                  --this._flyingRewards[_loc1_].delayFrames;
               }
               else
               {
                  ++this._flyingRewards[_loc1_].frameCounter;
                  if(this._flyingRewards[_loc1_].frameCounter <= 4)
                  {
                     if(this._flyingRewards[_loc1_].frameCounter == 4)
                     {
                        this.mcMapEffectsHolder.addChild(this._flyingRewards[_loc1_].item);
                     }
                  }
                  else
                  {
                     _loc2_ = this._flyingRewards[_loc1_].item;
                     if(this._flyingRewards[_loc1_].frameCounter <= 24)
                     {
                        _loc2_.y -= (24 - this._flyingRewards[_loc1_].frameCounter) / 3;
                     }
                     else if(_loc2_.scaleX > 0.1)
                     {
                        _loc2_.scaleX -= 0.15;
                        _loc2_.scaleY -= 0.15;
                     }
                     else
                     {
                        _loc2_.removeMe();
                        _loc2_ = null;
                        this._flyingRewards[_loc1_] = null;
                        this._flyingRewards.splice(_loc1_,1);
                     }
                  }
               }
               _loc1_--;
            }
         }
      }
      
      private function removeAllFlyingRewards() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMItem = null;
         if(this._flyingRewards.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._flyingRewards.length)
            {
               if(this._flyingRewards[_loc1_] != null)
               {
                  _loc2_ = this._flyingRewards[_loc1_].item;
                  _loc2_.removeMe();
                  _loc2_ = null;
                  this._flyingRewards[_loc1_] = null;
               }
               _loc1_++;
            }
         }
         this._flyingRewards = new Array();
      }
      
      private function missionCompletedHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:BMPlayerData = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:BMWorldMapLocationData = null;
         var _loc9_:Boolean = false;
         var _loc10_:BMWorldMapLocationData = null;
         var _loc11_:Array = null;
         if(this._missionCompleted == false)
         {
            return;
         }
         ++this._missionCompletedFrameCounter;
         switch(this._missionCompletedStatus)
         {
            case MISSION_COMPLETE_ANIM_WAIT1:
               if(this._missionCompletedFrameCounter >= 50)
               {
                  this._missionCompletedStatus = MISSION_COMPLETE_ANIM_IN;
                  this.mcCompleted1.visible = true;
                  this.mcCompleted2.visible = true;
               }
               break;
            case MISSION_COMPLETE_ANIM_IN:
               this.mcCompleted1.y += (this._missionCompleted1TragetYPos - this.mcCompleted1.y) * 0.3;
               this.mcCompleted2.y -= (this.mcCompleted2.y - this._missionCompleted2TragetYPos) * 0.3;
               if(Math.abs(this._missionCompleted1TragetYPos - this.mcCompleted1.y) < 2)
               {
                  this.mcCompleted1.y = this._missionCompleted1TragetYPos;
                  this.mcCompleted2.y = this._missionCompleted2TragetYPos;
                  this._missionCompletedStatus = MISSION_COMPLETE_ANIM_WAIT2;
                  this._missionCompletedFrameCounter = 0;
               }
               break;
            case MISSION_COMPLETE_ANIM_OUT:
               this.mcCompleted1.y += this._missionCompletedFrameCounter * 2;
               this.mcCompleted2.y -= this._missionCompletedFrameCounter * 2;
               if(this.mcCompleted1.y >= dataM.STAGE_HEIGHT + 200)
               {
                  this.mcCompleted1.y = dataM.STAGE_HEIGHT + 200;
                  this.mcCompleted2.y = -200;
                  this.mcCompleted1.visible = false;
                  this.mcCompleted2.visible = false;
                  this._missionCompletedStatus = MISSION_COMPLETE_ANIM_NONE;
               }
               break;
            case MISSION_COMPLETE_ANIM_WAIT2:
               if(this._missionCompletedFrameCounter < 40)
               {
                  break;
               }
               if(this._missionCompletedFrameCounter == 40)
               {
                  if(tutorialM.isTutorialActive())
                  {
                     _loc2_ = new Array();
                     _loc3_ = new Array();
                     _loc4_ = 0;
                     if(dataM.myProfile.currentMissionSlot == 0)
                     {
                        _loc4_ = 50;
                        _loc2_[0] = {
                           "type":"gold",
                           "amount":2500
                        };
                        _loc2_[1] = {
                           "type":"xp",
                           "amount":_loc4_
                        };
                     }
                     else
                     {
                        _loc5_ = dataM.playersData[dataM.player1PlayerID];
                        if(dataM.myProfile.currentMissionSlot == 1)
                        {
                           _loc3_.push({
                              "itemID":BMCampaignMechsHelper.getTutorial_hanger5_torso(),
                              "playerItemID":0,
                              "equipped":0
                           });
                           _loc3_.push({
                              "itemID":BMCampaignMechsHelper.getTutorial_hanger5_drone(),
                              "playerItemID":0,
                              "equipped":0
                           });
                           TsLogger.log("Pushed: \n" + JSON.stringify(_loc3_));
                           _loc4_ = 65;
                           _loc2_[0] = {
                              "type":"gold",
                              "amount":1500
                           };
                           _loc2_[1] = {
                              "type":"xp",
                              "amount":_loc4_
                           };
                           _loc2_[2] = {
                              "type":"itemBox",
                              "items":_loc3_
                           };
                        }
                     }
                     ++dataM.myProfile.missionsCompleted;
                     this.missionCompletedSuccess(_loc2_,tutorialM.calcLevelUp(_loc4_));
                  }
                  else
                  {
                     _loc6_ = 0;
                     _loc7_ = uint(dataM.myProfile.currentMissionSlot);
                     if(dataM.raidData.isRaidInProgress() == false)
                     {
                        _loc8_ = dataM.singlePlayerM.currentMissionDB;
                        _loc9_ = true;
                        _loc1_ = 0;
                        while(_loc1_ < dataM.singlePlayerM.getMissionsDB(this.storyID).length)
                        {
                           _loc10_ = dataM.singlePlayerM.getSpecificMissionDB(this.storyID,_loc1_);
                           if(_loc10_.type != BMWorldMapLocationData.TYPE_MISSION)
                           {
                              if(_loc10_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_REGULAR || _loc10_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS)
                              {
                                 if(_loc10_.difficulty == _loc8_.difficulty)
                                 {
                                    _loc11_ = dataM.myProfile.getNormalMapProgress(this.storyID);
                                    if(_loc11_[_loc1_] != BMSinglePlayerManager.MAP_PROGRESS_COMPLETE)
                                    {
                                       if(dataM.myProfile.currentMissionSlot != _loc1_)
                                       {
                                          _loc9_ = false;
                                          _loc1_ = dataM.singlePlayerM.getMissionsDB(this.storyID).length;
                                       }
                                    }
                                 }
                              }
                           }
                           _loc1_++;
                        }
                        if(_loc9_)
                        {
                           _loc6_ = _loc8_.difficulty;
                        }
                        _loc7_ = _loc8_.locationID;
                     }
                     this.trackMissionEvent("Complete");
                     remoteM.socketM.mission_complete(_loc7_,_loc6_);
                  }
               }
               if(this._missionCompletedGotRewardsData)
               {
                  this._missionCompletedStatus = MISSION_COMPLETE_ANIM_OUT;
                  this._missionCompletedFrameCounter = 0;
                  screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
               }
         }
      }
      
      private function trackMissionEvent(param1:String) : *
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc2_ = this.autopilotActive;
         _loc3_ = false;
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = null;
         if(dataM.raidData.isRaidInProgress())
         {
            _loc3_ = dataM.raidData.currentLevelHighestScore == 0;
            _loc5_ = int(dataM.raidData.currentLevel);
            _loc6_ = "Raid";
         }
         else
         {
            _loc4_ = int(dataM.myProfile.currentMissionMode);
            _loc3_ = !dataM.singlePlayerM.didCompleteSlot(this.storyID,dataM.myProfile.currentMissionSlot,dataM.myProfile.currentMissionMode);
            _loc5_ = int(dataM.myProfile.getCurrentMission().locationID);
            _loc6_ = dataM.myProfile.getCurrentMission().name;
         }
         dataM.trackEvent(3,"Mission",param1,_loc4_.toString(),_loc5_,_loc6_,_loc3_ ? 1 : 0,_loc2_ ? 1 : 0);
      }
      
      private function createLootBoxArray() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         this._lootBoxesArray = new Array();
         _loc1_ = 1;
         while(_loc1_ <= dataM.myProfile.mission_rows)
         {
            if(this._map[_loc1_] != null)
            {
               _loc2_ = 1;
               while(_loc2_ <= dataM.myProfile.mission_columns)
               {
                  if(this._map[_loc1_][_loc2_] != null)
                  {
                     if(this._map[_loc1_][_loc2_] != "")
                     {
                        _loc3_ = dataM.missionMapObjectDB[this._map[_loc1_][_loc2_]];
                        _loc4_ = (_loc2_ - 0.5 - dataM.myProfile.mission_columns / 2) * this.SQUARE_SIZE;
                        _loc5_ = (_loc1_ - 0.5 - dataM.myProfile.mission_rows / 2) * this.SQUARE_SIZE;
                        if(_loc3_.type == "loot")
                        {
                           this._lootBoxesArray.push({
                              "row":_loc1_,
                              "column":_loc2_,
                              "xPos":_loc4_,
                              "yPos":_loc5_
                           });
                        }
                     }
                  }
                  _loc2_++;
               }
            }
            _loc1_++;
         }
      }
      
      private function lootBoxSparksHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:BMMapObject = null;
         var _loc5_:Number = NaN;
         var _loc6_:Sprite = null;
         var _loc7_:Sprite = null;
         if(this.useAnimations == false)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this._lootBoxesArray.length)
         {
            _loc2_ = this._lootBoxesArray[_loc1_];
            _loc3_ = _loc2_.row + "_" + _loc2_.column;
            _loc4_ = this._mapObjects[_loc3_];
            if(_loc4_ != null)
            {
               _loc5_ = Math.ceil(Math.random() * 17);
               if(_loc5_ == 1)
               {
                  _loc6_ = externalAssetsM.getAsset("general","Grp_itemBoxSpark");
                  _loc6_.x = _loc2_.xPos + Math.random() * 30 - 15;
                  _loc6_.y = _loc2_.yPos + Math.random() * 30 - 15;
                  this.mcMapEffectsHolder.addChild(_loc6_);
                  this._lootBoxSparks.push(_loc6_);
               }
            }
            _loc1_++;
         }
         _loc1_ = this._lootBoxSparks.length - 1;
         while(_loc1_ >= 0)
         {
            _loc7_ = this._lootBoxSparks[_loc1_];
            if(_loc7_.scaleX > 0.1)
            {
               _loc7_.scaleX -= 0.1;
               _loc7_.scaleY -= 0.1;
            }
            else
            {
               this._lootBoxSparks[_loc1_].parent.removeChild(this._lootBoxSparks[_loc1_]);
               this._lootBoxSparks[_loc1_] = null;
               this._lootBoxSparks.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      private function createEnemyMech(param1:uint, param2:uint) : void
      {
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:BMMapMech = null;
         var _loc11_:BMBaseMapEnemy = null;
         var _loc12_:Array = null;
         var _loc13_:uint = 0;
         _loc3_ = this._map[param1][param2];
         _loc4_ = this.isTankCode(_loc3_);
         _loc5_ = this.isJeepCode(_loc3_);
         _loc6_ = BMMapMech.TYPE_MECH;
         if(_loc4_)
         {
            _loc6_ = BMMapMech.TYPE_TANK;
         }
         else if(_loc5_)
         {
            _loc6_ = BMMapMech.TYPE_JEEP;
         }
         _loc7_ = 1;
         if(this.battleMechsPerPlayer > 1)
         {
            _loc7_ = 0.8;
         }
         _loc8_ = 1;
         _loc9_ = _loc3_.substr(_loc3_.length - 1,1);
         if(_loc9_ == "2")
         {
            _loc8_ = 2;
         }
         else if(_loc9_ == "3")
         {
            _loc8_ = 3;
         }
         _loc10_ = new BMMapMech();
         _loc10_.initialize(_loc6_,_loc8_);
         _loc10_.colorMech(dataM.myProfile.mission_colorID,dataM.myProfile.mission_colorID);
         _loc10_.x = this.getObjectXPos(param2);
         _loc10_.y = this.getObjectYPos(param1);
         if(this.battleMechsPerPlayer == 2)
         {
            _loc10_.x -= 10;
            _loc10_.y -= 10;
         }
         else if(this.battleMechsPerPlayer == 3)
         {
            _loc10_.x -= 15;
            _loc10_.y -= 15;
         }
         _loc10_.scaleX = _loc7_;
         _loc10_.scaleY = _loc7_;
         _loc10_.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_DOWN);
         this.mcMapHolder["holder_objects" + param1].addChild(_loc10_);
         this._mapEnemyMechViews.push(_loc10_);
         _loc11_ = new BMBaseMapEnemy();
         _loc11_.setPatrol(_loc10_,this._map,param1,param2,dataM.myProfile.mission_rows,dataM.myProfile.mission_columns,this.SQUARE_SIZE);
         this._mapEnemyMechDatas.push(_loc11_);
         if(this.battleMechsPerPlayer == 1)
         {
            return;
         }
         _loc12_ = _loc11_.generateWaitingFramesArray();
         _loc13_ = 1;
         while(_loc13_ <= this.battleMechsPerPlayer - 1)
         {
            _loc10_ = new BMMapMech();
            _loc10_.initialize(_loc6_,_loc8_);
            _loc10_.colorMech(dataM.myProfile.mission_colorID,dataM.myProfile.mission_colorID);
            _loc10_.x = this.getObjectXPos(param2);
            _loc10_.y = this.getObjectYPos(param1);
            if(this.battleMechsPerPlayer == 2)
            {
               _loc10_.x += 10;
               _loc10_.y += 10;
            }
            else if(this.battleMechsPerPlayer == 3)
            {
               if(_loc13_ == 2)
               {
                  _loc10_.x += 15;
                  _loc10_.y += 15;
               }
            }
            _loc10_.scaleX = _loc7_;
            _loc10_.scaleY = _loc7_;
            _loc10_.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_DOWN);
            this.mcMapHolder["holder_objects" + param1].addChild(_loc10_);
            this._mapEnemyMechViews.push(_loc10_);
            _loc11_ = new BMBaseMapEnemy();
            _loc11_.setPatrol(_loc10_,this._map,param1,param2,dataM.myProfile.mission_rows,dataM.myProfile.mission_columns,this.SQUARE_SIZE,_loc13_);
            _loc11_.setWaitingFramesArray(_loc12_);
            this._mapEnemyMechDatas.push(_loc11_);
            _loc13_++;
         }
      }
      
      private function enemyMechsHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:Point = null;
         var _loc6_:uint = 0;
         var _loc7_:BMBaseMapEnemy = null;
         var _loc8_:BMMapMech = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(this._startingBattle || this._useMissionGameplayImprovements == false)
         {
            return;
         }
         _loc1_ = false;
         _loc6_ = 0;
         for(; _loc6_ < this._mapEnemyMechDatas.length; _loc6_++)
         {
            _loc7_ = this._mapEnemyMechDatas[_loc6_];
            if(dataM.mission_destroyingMapObjectActive)
            {
               if(dataM.mission_destroyingMapObjectRow == _loc7_.row && dataM.mission_destroyingMapObjectColumn == _loc7_.column)
               {
                  continue;
               }
            }
            _loc7_.onEnterFrameTrigger();
            if(!(dataM.mission_destroyingMapObjectActive || this._saving || this._explosionChainActive))
            {
               if(_loc1_ == false && this.playerMech != null && this.playerMech.visible)
               {
                  _loc8_ = this._mapEnemyMechViews[_loc6_];
                  _loc5_ = new Point(_loc8_.x,_loc8_.y);
                  _loc9_ = _loc8_.x - this.playerMech.x;
                  _loc10_ = _loc8_.y - this.playerMech.y;
                  _loc11_ = dataM.getVectorSize(_loc9_,_loc10_);
                  if(_loc11_ <= this.PATROLING_MECHS_BATTLE_DISTANCE)
                  {
                     _loc1_ = true;
                     _loc2_ = _loc7_.row;
                     _loc3_ = _loc7_.column;
                     _loc4_ = _loc7_.patrolDirection;
                  }
               }
            }
         }
         if(this._playerImmunityToMechEnouctersCooldown > 0)
         {
            --this._playerImmunityToMechEnouctersCooldown;
            _loc1_ = false;
         }
         if(_loc1_ == false)
         {
            return;
         }
         if(this._explosionChainActive == true)
         {
            return;
         }
         dataM.mission_playerMechStatus = BMMapMech.STATUS_STAND;
         dataM.mission_playerMechDirection = BMMapMech.DIRECTION_UP;
         switch(_loc4_)
         {
            case BMBaseMapEnemy.DIRECTION_NONE:
               break;
            case BMBaseMapEnemy.DIRECTION_HORIZONTAL:
               if(this.playerMech.x > _loc5_.x)
               {
                  dataM.myProfile.mission_playerPosition = this.getPositionByRowAndColumn(_loc2_,_loc3_ + 1);
                  dataM.mission_playerMechDirection = BMMapMech.DIRECTION_LEFT;
               }
               else
               {
                  dataM.myProfile.mission_playerPosition = this.getPositionByRowAndColumn(_loc2_,_loc3_ - 1);
                  dataM.mission_playerMechDirection = BMMapMech.DIRECTION_RIGHT;
               }
               break;
            case BMBaseMapEnemy.DIRECTION_VERTICAL:
               if(this.playerMech.y > _loc5_.y)
               {
                  dataM.myProfile.mission_playerPosition = this.getPositionByRowAndColumn(_loc2_ + 1,_loc3_);
                  dataM.mission_playerMechDirection = BMMapMech.DIRECTION_UP;
               }
               else
               {
                  dataM.myProfile.mission_playerPosition = this.getPositionByRowAndColumn(_loc2_ - 1,_loc3_);
                  dataM.mission_playerMechDirection = BMMapMech.DIRECTION_DOWN;
               }
         }
         this.startBattle(_loc2_,_loc3_);
      }
      
      private function removeEnemyMech(param1:uint, param2:uint) : void
      {
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         var _loc5_:BMBaseMapEnemy = null;
         var _loc6_:BMMapMech = null;
         _loc3_ = new Array();
         _loc4_ = 0;
         while(_loc4_ < this._mapEnemyMechDatas.length)
         {
            _loc5_ = this._mapEnemyMechDatas[_loc4_];
            if(_loc5_.row == param1 && _loc5_.column == param2)
            {
               _loc6_ = this._mapEnemyMechViews[_loc4_];
               _loc6_.visible = false;
               _loc3_.push(_loc4_);
               if(_loc3_.length == this.battleMechsPerPlayer)
               {
                  break;
               }
            }
            _loc4_++;
         }
         if(_loc3_.length == 0)
         {
            return;
         }
         _loc4_ = int(_loc3_.length - 1);
         while(_loc4_ >= 0)
         {
            this.removeEnemyMechDataAndView(_loc3_[_loc4_]);
            _loc4_--;
         }
      }
      
      private function removeEnemyMechDataAndView(param1:uint) : void
      {
         this._mapEnemyMechDatas.splice(param1,1);
         this._mapEnemyMechViews.splice(param1,1);
      }
      
      private function turretsHandler() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMBaseMapTurret = null;
         var _loc1_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < this._mapTurrets.length)
         {
            _loc3_ = this._mapTurrets[_loc2_];
            _loc3_.onEnterFrameTrigger();
            if(_loc3_.canFire != false)
            {
               if(_loc3_.isMechInFiringRange(this.playerMech) != false)
               {
                  this.createTurretShot(_loc3_);
               }
            }
            _loc2_++;
         }
      }
      
      private function createTurretShot(param1:BMBaseMapTurret) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         var _loc5_:Point = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:uint = 0;
         var _loc10_:BMBaseMapShot = null;
         _loc2_ = dataM.animationDB[param1.weaponAnimation];
         _loc3_ = externalAssetsM.getAsset("general",_loc2_.projectile);
         _loc4_ = param1.grp["mcFire" + param1.currentCannon];
         _loc5_ = new Point(param1.grp.x + _loc4_.x,param1.grp.y + _loc4_.y);
         _loc3_.x = _loc5_.x;
         _loc3_.y = _loc5_.y;
         _loc6_ = 0;
         _loc7_ = 0;
         switch(param1.direction)
         {
            case BMBaseMapTurret.DIRECTION_DOWN:
               _loc3_.rotation = 90;
               _loc7_ = int(this.SHOT_SPEED);
               break;
            case BMBaseMapTurret.DIRECTION_LEFT:
               _loc3_.rotation = 180;
               _loc6_ = -this.SHOT_SPEED;
               break;
            case BMBaseMapTurret.DIRECTION_RIGHT:
               _loc6_ = int(this.SHOT_SPEED);
         }
         param1.turretFired();
         soundM.createSound(_loc2_.sound);
         this.mcMapEffectsHolder.addChild(_loc3_);
         ++this._shotsCounter;
         _loc8_ = dataM.missionMapObjectDB[this._map[param1.row][param1.column]];
         _loc9_ = _loc8_.damage + Math.floor(_loc8_.damageAddonPerMission * dataM.myProfile.currentMissionSlot);
         _loc10_ = new BMBaseMapShot(this._shotsCounter,_loc9_,_loc3_,_loc6_,_loc7_,this.SHOT_FRAMES,this.setShotForDeletion);
         this._mapShots.push(_loc10_);
         effectsM.createFireEffect("laserFire1",_loc3_.x,_loc3_.y,false,_loc3_.rotation,this.mcMapEffectsHolder);
      }
      
      private function turretShotsHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Array = null;
         var _loc5_:BMBaseMapShot = null;
         var _loc6_:uint = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         _loc1_ = false;
         _loc4_ = new Array();
         if(this.playerMech != null && this.playerMech.visible)
         {
            _loc2_ = this.playerMech.x;
            _loc3_ = this.playerMech.y - 40;
            _loc1_ = true;
         }
         _loc6_ = 0;
         while(_loc6_ < this._mapShots.length)
         {
            _loc5_ = this._mapShots[_loc6_];
            _loc5_.onEnterFrameTrigger();
            if(_loc1_ != false)
            {
               _loc7_ = _loc5_.xPos - _loc2_;
               _loc8_ = _loc5_.yPos - _loc3_;
               _loc9_ = dataM.getVectorSize(_loc7_,_loc8_);
               if(_loc9_ <= this.SHOTS_HIT_DISTANCE)
               {
                  _loc4_.push(_loc5_);
                  this.createExplosion(_loc5_.xPos,_loc5_.yPos,this.mcMapEffectsHolder);
                  this.damagePlayer(_loc5_.damage);
               }
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc6_];
            _loc5_.setSelfForDeletion();
            _loc6_++;
         }
      }
      
      private function setShotForDeletion(param1:uint) : void
      {
         this._shotsForDeletion.push(param1);
      }
      
      private function removeShotsHandler() : void
      {
         var _loc1_:* = 0;
         var _loc2_:BMBaseMapShot = null;
         var _loc3_:int = 0;
         _loc1_ = int(this._mapShots.length - 1);
         while(_loc1_ >= 0)
         {
            _loc2_ = this._mapShots[_loc1_];
            _loc3_ = this._shotsForDeletion.indexOf(_loc2_.ID);
            if(_loc3_ > -1)
            {
               _loc2_.removeMe();
               this._mapShots.splice(_loc1_,1);
               this._shotsForDeletion.splice(_loc3_,1);
            }
            _loc1_--;
         }
      }
      
      private function damagePlayer(param1:uint) : void
      {
         var _loc2_:String = null;
         if(!(this.playerMech != null && this.playerMech.visible))
         {
            return;
         }
         this.currentMechStats.hp = Math.max(1,this.currentMechStats.hp - param1);
         this.mcMechStats.mcBarHP.setFill(this.currentMechStats.hp / this.currentMechStats.hpMax,true);
         _loc2_ = TextUtils.getNumberWithComma(this.currentMechStats.hp) + " / " + TextUtils.getNumberWithComma(this.currentMechStats.hpMax);
         updateTextAndFormat(this.mcMechStats.txtHP,_loc2_);
         this.redrawHPTextForMobile();
         if(dataM.newVisualEffects)
         {
            effectsM.createGetHitSparks(this.playerMech.x,this.playerMech.y,this.mcMapEffectsHolder,1,0.7);
         }
         else
         {
            effectsM.createSparksMC(BMScreensManager.SCR_MISSION_BASE_MAP,"spark",this.playerMech.x,this.playerMech.y,1,4,40,"up","orange",true);
         }
         soundM.createSound("getHit" + Math.ceil(Math.random() * 3),0.3);
      }
      
      private function removeTurret(param1:uint, param2:uint) : void
      {
         var _loc3_:Object = null;
         var _loc4_:* = 0;
         var _loc5_:BMBaseMapTurret = null;
         if(this._mapTurrets.length == 0)
         {
            return;
         }
         _loc3_ = dataM.missionMapObjectDB[this._map[param1][param2]];
         if(_loc3_.type == "structure" && _loc3_.subType == "turret")
         {
            _loc4_ = int(this._mapTurrets.length - 1);
            while(_loc4_ >= 0)
            {
               _loc5_ = this._mapTurrets[_loc4_];
               if(_loc5_.row == param1 && _loc5_.column == param2)
               {
                  this._mapTurrets.splice(_loc4_,1);
               }
               _loc4_--;
            }
         }
      }
      
      private function damageFloorsHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMBaseMapDamageFloor = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Object = null;
         if(this.isMapInteractable == false)
         {
            return;
         }
         if(this._playerDamageFromFloosCooldown > 0)
         {
            --this._playerDamageFromFloosCooldown;
         }
         _loc1_ = 0;
         while(_loc1_ < this._mapDamageFloors.length)
         {
            _loc2_ = this._mapDamageFloors[_loc1_];
            _loc2_.onEnterFrameTrigger();
            if(_loc2_.isDealingDamage != false)
            {
               if(_loc2_.isFirstDamageFrame)
               {
                  effectsM.createFlame(this.mcMapEffectsHolder,"flame1",100,false,2,13,_loc2_.grp.x,_loc2_.grp.y);
               }
               if(this._playerDamageFromFloosCooldown <= 0)
               {
                  _loc3_ = _loc2_.grp.x - _loc2_.grp.width / 2;
                  _loc4_ = _loc2_.grp.x + _loc2_.grp.width / 2;
                  if(!(this.playerMech.x < _loc3_ || this.playerMech.x > _loc4_))
                  {
                     _loc5_ = _loc2_.grp.y - _loc2_.grp.height / 2;
                     _loc6_ = _loc2_.grp.y + _loc2_.grp.height / 2;
                     if(!(this.playerMech.y < _loc5_ || this.playerMech.y > _loc6_))
                     {
                        _loc7_ = this._map[_loc2_.row][_loc2_.column];
                        _loc8_ = dataM.missionMapObjectDB[_loc7_];
                        this.damagePlayer(_loc8_.damage);
                     }
                  }
               }
            }
            _loc1_++;
         }
         if(this._playerDamageFromFloosCooldown == 0)
         {
            this._playerDamageFromFloosCooldown = this.PLAYER_DAMAGE_FROM_FLOORS_COOLDOWN_FRAMES;
         }
      }
      
      private function activateExplosionChain(param1:uint, param2:uint) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         _loc3_ = this.getExplosionChainEffectLocations(param1,param2);
         _loc4_ = _loc3_[0];
         _loc5_ = _loc3_[1];
         if(_loc5_.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc7_ = uint(_loc5_[_loc6_].row);
               _loc8_ = uint(_loc5_[_loc6_].column);
               dataM.myProfile.mission_damagedEnemies.push(this.getPositionByRowAndColumn(_loc7_,_loc8_));
               this._explosionChainEnemiesDataForServer.push(this.getPositionByRowAndColumn(_loc7_,_loc8_));
               this.showEnemyMechDamage(_loc7_,_loc8_);
               _loc6_++;
            }
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc9_ = _loc4_[_loc6_];
            _loc10_ = _loc9_.row + "_" + _loc9_.column;
            if(this._explosionChainTargetLocations[_loc10_] == null)
            {
               this._explosionChainTargetLocations[_loc10_] = {
                  "row":_loc9_.row,
                  "column":_loc9_.column,
                  "destroyed":false
               };
               this._explosionChainStructuresDataForServer.push(this.getPositionByRowAndColumn(_loc9_.row,_loc9_.column));
               dataM.myProfile.mission_progress.push(this.getPositionByRowAndColumn(_loc9_.row,_loc9_.column));
            }
            _loc6_++;
         }
         if(_loc4_.length == 0 && _loc5_.length == 0)
         {
            return;
         }
         if(this._explosionChainActive == false)
         {
            this._explosionChainActive = true;
            this._explosionChainCooldown = 4;
         }
      }
      
      private function showAllEnemyMechDamage() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         _loc1_ = 0;
         while(_loc1_ < dataM.myProfile.mission_damagedEnemies.length)
         {
            _loc2_ = uint(dataM.myProfile.mission_damagedEnemies[_loc1_]);
            _loc3_ = this.getRowAndColumnByPosition(_loc2_);
            this.showEnemyMechDamage(_loc3_[0],_loc3_[1]);
            _loc1_++;
         }
      }
      
      private function showEnemyMechDamage(param1:uint, param2:uint) : void
      {
         var _loc3_:BMBaseMapEnemy = null;
         _loc3_ = this.getEnemyMechByRowAndColumn(param1,param2,true);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.view.showHPBar((100 - dataM.missionExplosiveChainDamageReduction) / 100);
      }
      
      private function explosionChainHandler() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         if(this._explosionChainActive == false)
         {
            return;
         }
         if(this._explosionChainCooldown > 0)
         {
            --this._explosionChainCooldown;
            return;
         }
         this._explosionChainActive = false;
         _loc1_ = new Array();
         for each(_loc2_ in this._explosionChainTargetLocations)
         {
            if(!_loc2_.destroyed)
            {
               _loc2_.destroyed = true;
               _loc1_.push({
                  "row":_loc2_.row,
                  "column":_loc2_.column
               });
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            this.destroyMapObject(_loc4_.row,_loc4_.column,true);
            _loc3_++;
         }
         if(this._explosionChainActive == false)
         {
            if(this._explosionChainStructuresDataForServer.length == 0 && this._explosionChainEnemiesDataForServer.length == 0)
            {
               return;
            }
            remoteM.socketM.mission_addExplosiveChainProgress(this._explosionChainStructuresDataForServer,this._explosionChainEnemiesDataForServer);
            this._explosionChainEnemiesDataForServer = new Array();
         }
      }
      
      private function getExplosionChainEffectLocations(param1:uint, param2:uint) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:BMBaseMapEnemy = null;
         var _loc12_:BMMapMech = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         _loc3_ = new Array();
         _loc3_ = [[-1,0],[0,-1],[0,1],[1,0]];
         _loc4_ = new Array();
         _loc5_ = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc8_ = param1 + _loc3_[_loc6_][0];
            _loc9_ = param2 + _loc3_[_loc6_][1];
            _loc10_ = this.isExplodeStructurePossible(_loc8_,_loc9_);
            if(_loc10_)
            {
               _loc4_.push({
                  "row":_loc8_,
                  "column":_loc9_
               });
            }
            _loc6_++;
         }
         _loc7_ = 0;
         while(_loc7_ < this._mapEnemyMechDatas.length)
         {
            _loc11_ = this._mapEnemyMechDatas[_loc7_];
            if(!_loc11_.gotDamaged)
            {
               _loc12_ = this._mapEnemyMechViews[_loc7_];
               _loc13_ = this.getObjectXPos(param2) - _loc12_.x;
               _loc14_ = this.getObjectYPos(param1) - _loc12_.y;
               _loc15_ = dataM.getVectorSize(_loc13_,_loc14_);
               if(_loc15_ <= this.SQUARE_SIZE * 1.2)
               {
                  _loc11_.gotDamaged = true;
                  _loc5_.push({
                     "row":_loc11_.row,
                     "column":_loc11_.column
                  });
               }
            }
            _loc7_++;
         }
         return [_loc4_,_loc5_];
      }
      
      public function explosiveChainProgressUpdate(param1:Array) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = uint(param1[_loc3_].goldReward);
            if(_loc4_ != 0)
            {
               if(this._explosionChainStructuresDataForServer[_loc3_] == null)
               {
                  _loc3_ = param1.length;
               }
               else
               {
                  _loc5_ = uint(this.getRowAndColumnByPosition(this._explosionChainStructuresDataForServer[_loc3_])[0]);
                  _loc6_ = uint(this.getRowAndColumnByPosition(this._explosionChainStructuresDataForServer[_loc3_])[1]);
                  this.createFlyingReward(new mcFlyingGold(),_loc4_,_loc5_,_loc6_,_loc3_);
                  _loc2_ += _loc4_;
               }
            }
            _loc3_++;
         }
         if(_loc2_ > 0)
         {
            dataM.myProfile.mission_gold += _loc2_;
            this.refreshLootGoldAndXp();
         }
         this._explosionChainStructuresDataForServer = new Array();
      }
      
      private function isExplodeStructurePossible(param1:int, param2:int) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         if(this.canLocationBeAffectedByChainExplosion(param1,param2) == false)
         {
            return false;
         }
         _loc3_ = this._map[param1][param2];
         _loc4_ = dataM.missionMapObjectDB[_loc3_];
         if(_loc4_.type == "structure")
         {
            return true;
         }
         return false;
      }
      
      private function canLocationBeAffectedByChainExplosion(param1:int, param2:int) : Boolean
      {
         var _loc3_:String = null;
         if(param1 < 1 || param2 < 1)
         {
            return false;
         }
         if(this._map[param1] == null)
         {
            return false;
         }
         if(this._map[param1][param2] == null)
         {
            return false;
         }
         _loc3_ = this._map[param1][param2];
         if(_loc3_ == "")
         {
            return false;
         }
         if(this._explosionChainTargetLocations[param1 + "_" + param2] != null)
         {
            return false;
         }
         return true;
      }
      
      private function getEnemyMechByRowAndColumn(param1:uint, param2:uint, param3:Boolean = false) : BMBaseMapEnemy
      {
         var _loc4_:uint = 0;
         var _loc5_:BMBaseMapEnemy = null;
         _loc4_ = 0;
         while(true)
         {
            if(_loc4_ >= this._mapEnemyMechDatas.length)
            {
               return null;
            }
            _loc5_ = this._mapEnemyMechDatas[_loc4_];
            if(_loc5_.row == param1 && _loc5_.column == param2)
            {
               if(!param3)
               {
                  break;
               }
               if(_loc5_.followerID == this.battleMechsPerPlayer - 1)
               {
                  break;
               }
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      private function get autopilotActive() : Boolean
      {
         return dataM.userAutopilot || dataM.useHiddenBaseMap;
      }
      
      private function canUserAutopilotRun() : Boolean
      {
         if(this.autopilotActive == false)
         {
            return false;
         }
         if(this._startingBattle)
         {
            return false;
         }
         if(this.isAnimationActive())
         {
            return false;
         }
         if(this._missionCompleted)
         {
            return false;
         }
         if(screensM.screenBlack.isActive() && dataM.useHiddenBaseMap == false)
         {
            return false;
         }
         if(this._autopilotOptionsExhaustedForMission)
         {
            return false;
         }
         if(this._playerNeedsToReviveBlock || this._destroyingPlayerActive || screensM.isScreenOpened(BMScreensManager.SCR_BUY_CONFIRMATION))
         {
            return false;
         }
         if(this._saving)
         {
            return false;
         }
         if(dataM.useHiddenBaseMap == false && dataM.isShowingAdvertisement)
         {
            return false;
         }
         if(dataM.myProfile.missionCurrentMechStats == null)
         {
            return false;
         }
         if(dataM.myProfile.missionCurrentMechStats.hp <= 0)
         {
            return false;
         }
         if(this._explosionChainActive)
         {
            return false;
         }
         if(this._autopilotDelayFramesCounter > 0)
         {
            --this._autopilotDelayFramesCounter;
            return false;
         }
         if(loginM.loginState == BMLoginManager.STATE_SILENT_LOGGING_IN)
         {
            return false;
         }
         if(loginM.isDisconnected && dataM.useHiddenBaseMap == false)
         {
            return false;
         }
         return true;
      }
      
      private function activateUserAutopilot() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:Array = null;
         var _loc8_:Object = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(this.canUserAutopilotRun() == false)
         {
            return;
         }
         _loc1_ = this.autopilotManageUpgrades();
         if(_loc1_)
         {
            return;
         }
         _loc2_ = new Array();
         _loc3_ = 1;
         while(_loc3_ <= dataM.myProfile.mission_rows)
         {
            _loc4_ = 1;
            while(_loc4_ <= dataM.myProfile.mission_columns)
            {
               if(this._map[_loc3_][_loc4_] != null)
               {
                  _loc5_ = this._map[_loc3_][_loc4_];
                  if(_loc5_ != "")
                  {
                     _loc6_ = this.getPositionByRowAndColumn(_loc3_,_loc4_);
                     _loc7_ = this.getPathToPosition(_loc6_);
                     if(_loc7_.length != 0)
                     {
                        _loc8_ = dataM.missionMapObjectDB[_loc5_];
                        if(_loc8_.code.substr(0,1) != "X")
                        {
                           if(_loc8_.type != "floor")
                           {
                              _loc9_ = 1;
                              switch(_loc8_.type)
                              {
                                 case "enemy":
                                    _loc9_ = 100;
                                    if(this.isMechCode(_loc8_.code))
                                    {
                                       if(dataM.useMissionGameplayImprovements == false)
                                       {
                                          _loc9_ = 200;
                                       }
                                    }
                                    else if(this.isBossCode(_loc8_.code))
                                    {
                                       _loc9_ = 300;
                                    }
                                    break;
                                 case "structure":
                                 case "crate":
                                    if(dataM.clientRunningLocally)
                                    {
                                    }
                                    break;
                                 case "loot":
                              }
                              _loc10_ = _loc7_.length;
                              _loc9_ += _loc10_;
                              _loc2_.push({
                                 "row":_loc3_,
                                 "column":_loc4_,
                                 "code":_loc8_.code,
                                 "grp":_loc8_.grp,
                                 "position":_loc6_,
                                 "importanceValue":_loc9_
                              });
                           }
                        }
                     }
                  }
               }
               _loc4_++;
            }
            _loc3_++;
         }
         _loc2_.sortOn("importanceValue",Array.NUMERIC);
         if(_loc2_.length == 0)
         {
            this._autopilotOptionsExhaustedForMission = true;
         }
         else
         {
            this.mapHitAreaClickedSub(_loc2_[0].row,_loc2_[0].column);
         }
      }
      
      private function autopilotManageUpgrades() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         if(dataM.useHiddenBaseMap && this.getEnemiesDestroyed() == 0)
         {
            return false;
         }
         _loc1_ = 0;
         while(_loc1_ < dataM.myProfile.mission_upgrades.length)
         {
            _loc2_ = dataM.myProfile.mission_upgrades[_loc1_];
            switch(_loc2_)
            {
               case UPGRADE_HP:
                  _loc3_ = this.getEnemiesRemained();
                  _loc4_ = dataM.myProfile.missionCurrentMechStats.hp / dataM.myProfile.missionCurrentMechStats.hpMax;
                  if(_loc3_ > 0 && (_loc4_ <= this.AUTOPILOT_MAX_HP_RATIO_REQUIRED_TO_USE_REPAIR_CRATE || _loc4_ < 1 && _loc3_ == 1))
                  {
                     this.upgradesClickedSub(_loc1_);
                     return true;
                  }
                  break;
               case UPGRADE_ENERGY:
               case UPGRADE_HEAT:
                  this.upgradesClickedSub(_loc1_);
                  return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      private function userAutopilotAndGeneralSpeedRatioActionAllowedResolver() : Boolean
      {
         if(this._saving)
         {
            return false;
         }
         return true;
      }
      
      private function autopilotOnClicked() : void
      {
      }
      
      private function autopilotOffClicked() : void
      {
         this._autopilotDelayFramesCounter = 0;
      }
      
      private function gameX1SpeedClicked() : void
      {
         this._walkingFrames = this.WALKING_FRAMES_DOUBLE_SPEED;
      }
      
      private function gameX2SpeedClicked() : void
      {
         this._walkingFrames = this.WALKING_FRAMES_REGULAR_SPEED;
      }
      
      private function initAutoplayAndGameSpeedPanel() : void
      {
         this.mcAutoplayAndGameSpeedPanel.initialize(this.userAutopilotAndGeneralSpeedRatioActionAllowedResolver,this.autopilotOnClicked,this.autopilotOffClicked,this.gameX1SpeedClicked,this.gameX2SpeedClicked);
         this._walkingFrames = this.WALKING_FRAMES_REGULAR_SPEED;
         if(dataM.isAutopilotAllowed() == false)
         {
            if(tutorialM.isTutorialActive() == false)
            {
               this._walkingFrames = this.WALKING_FRAMES_DOUBLE_SPEED;
               return;
            }
            if(BMGameShortcutsHelper.gameSpeedShortcut())
            {
               this._walkingFrames = this.WALKING_FRAMES_DOUBLE_SPEED;
            }
            return;
         }
         if(dataM.generalSpeedRatio == BMDataManager.GENERAL_SPEED_RATIO_DOUBLE || BMGameShortcutsHelper.gameSpeedShortcut())
         {
            this._walkingFrames = this.WALKING_FRAMES_DOUBLE_SPEED;
         }
      }
      
      private function get autopilotImportantActionDelayFrames() : uint
      {
         if(this.useAnimations == false)
         {
            return 0;
         }
         return this.AUTOPILOT_IMPORTANT_ACTION_DELAY_FRAMES;
      }
      
      private function createAvailableUpgrades() : void
      {
         if(tutorialM.isTutorialActive())
         {
            this._availableUpgrades = new Array();
            this._availableUpgrades.push(UPGRADE_HP);
            this._availableUpgrades.push(UPGRADE_ENERGY);
            this._availableUpgrades.push(UPGRADE_HEAT);
         }
      }
      
      private function setMapScale() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         _loc1_ = 0.85;
         _loc2_ = dataM.myProfile.mission_rows;
         if(dataM.myProfile.mission_columns > dataM.myProfile.mission_rows)
         {
            _loc2_ = dataM.myProfile.mission_columns;
         }
         _loc3_ = 0;
         switch(_loc2_)
         {
            case 3:
               _loc1_ = 1.5;
               break;
            case 4:
               _loc1_ = 1.25;
               break;
            case 5:
               _loc1_ = 1.05;
               break;
            case 6:
               _loc1_ = 0.85;
               break;
            case 7:
               _loc1_ = 0.78;
               break;
            case 8:
               _loc3_ = -10;
               _loc1_ = 0.72;
               break;
            case 9:
               _loc3_ = -15;
               _loc1_ = 0.63;
               break;
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
               _loc1_ = 0.58;
               _loc3_ = -14;
         }
         if(_loc3_ != 0)
         {
            this.mcMapHolder.y += _loc3_;
            this.mcMapEffectsHolder.y += _loc3_;
         }
         this.mcMapHolder.scaleX = _loc1_;
         this.mcMapHolder.scaleY = _loc1_;
         this.mcMapEffectsHolder.scaleX = _loc1_;
         this.mcMapEffectsHolder.scaleY = _loc1_;
      }
      
      private function getRowAndColumnByPosition(param1:uint) : Array
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = Math.floor((param1 - 1) / dataM.myProfile.mission_columns) + 1;
         _loc3_ = param1 - dataM.myProfile.mission_columns * (_loc2_ - 1);
         return [_loc2_,_loc3_];
      }
      
      private function isAnimationActive() : Boolean
      {
         var _loc1_:Boolean = false;
         _loc1_ = false;
         if(this._playerEntryHandler || this._walkingActive || dataM.mission_destroyingMapObjectActive || this._destroyingPlayerActive)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function isJeepCode(param1:*) : Boolean
      {
         switch(param1)
         {
            case "JP":
            case "J1":
            case "J2":
            case "J3":
               return true;
            default:
               return false;
         }
      }
      
      private function isTankCode(param1:*) : Boolean
      {
         switch(param1)
         {
            case "TK":
            case "T1":
            case "T2":
            case "T3":
               return true;
            default:
               return false;
         }
      }
      
      private function isMechCode(param1:*) : Boolean
      {
         switch(param1)
         {
            case "ME":
            case "M1":
            case "M2":
            case "M3":
               return true;
            default:
               return false;
         }
      }
      
      private function isBossCode(param1:*) : Boolean
      {
         switch(param1)
         {
            case "BS":
            case "B1":
            case "B2":
            case "B3":
               return true;
            default:
               return false;
         }
      }
      
      private function isEnemyCode(param1:*) : Boolean
      {
         if(this.isJeepCode(param1))
         {
            return true;
         }
         if(this.isTankCode(param1))
         {
            return true;
         }
         if(this.isMechCode(param1))
         {
            return true;
         }
         if(this.isBossCode(param1))
         {
            return true;
         }
         return false;
      }
      
      private function get storyID() : uint
      {
         return dataM.myProfile.currentStoryID;
      }
      
      private function initMechTabs(param1:Boolean) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1 == false)
         {
            dataM.myProfile.missionCurrentMechID = dataM.myProfile.getMissionLiveMechID();
         }
         this.mcMechStats.mcMech2V2Tabs.visible = false;
         this.mcMechStats.mcMech3V3Tabs.visible = false;
         if(this.battleMechsPerPlayer == 1)
         {
            this.mcMechStats.mcBackground.gotoAndStop("oneMech");
            return;
         }
         if(this.battleMechsPerPlayer == 2)
         {
            this.mcMechStats.mcMech2V2Tabs.visible = true;
         }
         else
         {
            this.mcMechStats.mcMech3V3Tabs.visible = true;
         }
         this.mcMechStats.mcBackground.gotoAndStop("severalMechs");
         updateTextAndFormat(this.mcMechStats.txtStats,"");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionMap_mechStatsTitle",[this.mcMechStats.txtStats],"",this.mcMechStats);
         }
         if(this.battleMechsPerPlayer == 2)
         {
            _loc2_ = getSpecificText("hanger_mechID");
            _loc2_ = dataM.replaceStringInText(_loc2_,"%ID%","1");
            _loc3_ = getSpecificText("hanger_mechID");
            _loc3_ = dataM.replaceStringInText(_loc3_,"%ID%","2");
            updateTextAndFormat(this.mcMechStats.mcMech2V2Tabs.mcTab1Selected.txtTab1,_loc2_);
            updateTextAndFormat(this.mcMechStats.mcMech2V2Tabs.mcTab1Selected.txtTab2,_loc3_);
            updateTextAndFormat(this.mcMechStats.mcMech2V2Tabs.mcTab2Selected.txtTab1,_loc2_);
            updateTextAndFormat(this.mcMechStats.mcMech2V2Tabs.mcTab2Selected.txtTab2,_loc3_);
            this.mcMechStats.mcMech2V2Tabs.mcTab1HitArea.addEventListener(MouseEvent.CLICK,this.mechTab1Clicked);
            this.mcMechStats.mcMech2V2Tabs.mcTab2HitArea.addEventListener(MouseEvent.CLICK,this.mechTab2Clicked);
         }
         else
         {
            updateTextAndFormat(this.mcMechStats.mcMech3V3Tabs.mcTab1Selected.txtTab1,"1");
            updateTextAndFormat(this.mcMechStats.mcMech3V3Tabs.mcTab1Selected.txtTab2,"2");
            updateTextAndFormat(this.mcMechStats.mcMech3V3Tabs.mcTab1Selected.txtTab3,"3");
            updateTextAndFormat(this.mcMechStats.mcMech3V3Tabs.mcTab2Selected.txtTab1,"1");
            updateTextAndFormat(this.mcMechStats.mcMech3V3Tabs.mcTab2Selected.txtTab2,"2");
            updateTextAndFormat(this.mcMechStats.mcMech3V3Tabs.mcTab2Selected.txtTab3,"3");
            updateTextAndFormat(this.mcMechStats.mcMech3V3Tabs.mcTab3Selected.txtTab1,"1");
            updateTextAndFormat(this.mcMechStats.mcMech3V3Tabs.mcTab3Selected.txtTab2,"2");
            updateTextAndFormat(this.mcMechStats.mcMech3V3Tabs.mcTab3Selected.txtTab3,"3");
            this.mcMechStats.mcMech3V3Tabs.mcTab1HitArea.addEventListener(MouseEvent.CLICK,this.mechTab1Clicked);
            this.mcMechStats.mcMech3V3Tabs.mcTab2HitArea.addEventListener(MouseEvent.CLICK,this.mechTab2Clicked);
            this.mcMechStats.mcMech3V3Tabs.mcTab3HitArea.addEventListener(MouseEvent.CLICK,this.mechTab3Clicked);
         }
         this.refreshMechTabs();
      }
      
      private function refreshMechTabs() : void
      {
         if(this.battleMechsPerPlayer == 2)
         {
            this.mcMechStats.mcMech2V2Tabs.mcTab1Selected.visible = false;
            this.mcMechStats.mcMech2V2Tabs.mcTab2Selected.visible = false;
            this.mcMechStats.mcMech2V2Tabs["mcTab" + dataM.myProfile.missionCurrentMechID + "Selected"].visible = true;
         }
         else
         {
            this.mcMechStats.mcMech3V3Tabs.mcTab1Selected.visible = false;
            this.mcMechStats.mcMech3V3Tabs.mcTab2Selected.visible = false;
            this.mcMechStats.mcMech3V3Tabs.mcTab3Selected.visible = false;
            this.mcMechStats.mcMech3V3Tabs["mcTab" + dataM.myProfile.missionCurrentMechID + "Selected"].visible = true;
         }
      }
      
      private function mechTab1Clicked(param1:MouseEvent) : void
      {
         this.mechTabClicked(1);
      }
      
      private function mechTab2Clicked(param1:MouseEvent) : void
      {
         this.mechTabClicked(2);
      }
      
      private function mechTab3Clicked(param1:MouseEvent) : void
      {
         this.mechTabClicked(3);
      }
      
      private function mechTabClicked(param1:uint) : void
      {
         var _loc2_:BMMissionMechStats = null;
         if(this._saving)
         {
            return;
         }
         if(this.activeAutoPilotBlock())
         {
            return;
         }
         if(dataM.myProfile.missionCurrentMechID == param1)
         {
            return;
         }
         _loc2_ = dataM.myProfile.mission_mechStats[param1 - 1];
         if(_loc2_.hp == 0)
         {
            return;
         }
         dataM.myProfile.missionCurrentMechID = param1;
         this.refreshMechTabs();
         this.refreshCurrentMechStats();
         this.createPlayerMech(false,false,true);
         this.createTeleportEffectOnPlayerMech();
      }
      
      private function setMissionColor() : void
      {
         if(dataM.myProfile.mission_themeID == BMSinglePlayerManager.UNICORN_DUNGEON_THEME_ID)
         {
            dataM.myProfile.mission_colorID = 1;
         }
         else if(dataM.raidData.isRaidInProgress())
         {
            dataM.myProfile.mission_colorID = dataM.raidData.getEnemiesColor();
         }
         else
         {
            switch(this.getVisualMissionDifficulty())
            {
               case BMSinglePlayerManager.MISSION_DIFFICULTY_HARD:
                  dataM.myProfile.mission_colorID = BMSinglePlayerManager.MISSION_COLOR_HARD;
                  break;
               case BMSinglePlayerManager.MISSION_DIFFICULTY_INSANE:
                  dataM.myProfile.mission_colorID = BMSinglePlayerManager.MISSION_COLOR_INSANE;
                  break;
               case BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL:
               default:
                  dataM.myProfile.mission_colorID = BMSinglePlayerManager.MISSION_COLOR_NORMAL;
            }
         }
      }
      
      private function initMiniChat() : void
      {
         if(dataM.chatData.useCampaignChat)
         {
            this.mcMapHolder.y -= 35;
            dataM.chatData.enterChat();
            this.miniChat.setOpenChatCallback(this.openCampaignChat);
         }
         else
         {
            this.miniChat.visible = false;
         }
      }
      
      private function openCampaignChat() : void
      {
         screensM.addScreen(BMScreensManager.SCR_CAMPAIGN_CHAT);
      }
      
      public function removeMe() : void
      {
         dataM.setGeneralSpeedRatioAsNormal(false);
         dataM.setUserAutopilotOff(false);
         this.mcMechStats.mcMech2V2Tabs.mcTab1HitArea.removeEventListener(MouseEvent.CLICK,this.mechTab1Clicked);
         this.mcMechStats.mcMech2V2Tabs.mcTab2HitArea.removeEventListener(MouseEvent.CLICK,this.mechTab2Clicked);
         this.mcMechStats.mcMech3V3Tabs.mcTab1HitArea.removeEventListener(MouseEvent.CLICK,this.mechTab1Clicked);
         this.mcMechStats.mcMech3V3Tabs.mcTab2HitArea.removeEventListener(MouseEvent.CLICK,this.mechTab2Clicked);
         this.mcMechStats.mcMech3V3Tabs.mcTab3HitArea.removeEventListener(MouseEvent.CLICK,this.mechTab3Clicked);
         this.removeFloor();
         this.removeWalls();
         this.cleanMap();
         this.removeAllMapPickups();
         this.removeAllInterfacePickups();
         this.removePlayerMech();
         this.deactivateSaving(true);
         this._lastRollOverredPickupSlot = -1;
         tooltip.hideToolTip();
         this.hideMapArrow();
         this.removeAllFlyingRewards();
         this.mcTutorialArrow_usePickup.gotoAndStop("animOff");
         this._abortMissionDueToCheating_stopOnEnterFrame = false;
         this._abortMissionDueToCheating_functionTriggered = false;
         if(this.playerMech != null)
         {
            this.playerMech.removeMe();
            this.playerMech = null;
         }
         this.removeBossMech();
         screensM.removeScreen(BMScreensManager.SCR_BATTLE_RESULT);
         screensM.removeScreen(BMScreensManager.SCR_MISSION_BASE_MAP);
      }
      
      override public function notifyClientDataReloaded() : *
      {
         if(!this._missionCompletedGotRewardsData)
         {
            this.cleanMap();
            dataM.myProfile.missionCurrentMechID = dataM.myProfile.getMissionLiveMechID();
            this.refreshScreen(this._fromBattle,this._fromPackages);
            this.initMechTabs(this._fromBattle);
         }
      }
      
      public function handleRefreshedMissionData() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         dataM.myProfile.missionCurrentMechID = dataM.myProfile.getMissionLiveMechID();
         this.refreshScreen(this._fromBattle,this._fromPackages);
         this.initMechTabs(this._fromBattle);
      }
      
      private function reloadMissionData() : void
      {
         remoteM.socketM.mission_getData();
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
      }
   }
}

