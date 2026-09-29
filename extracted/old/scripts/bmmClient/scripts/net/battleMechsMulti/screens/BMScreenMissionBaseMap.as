package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMChatBubble;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMapMech;
   import net.battleMechsMulti.mobiles.BMMapObject;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol328")]
   public class BMScreenMissionBaseMap extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcFloorHolder:Sprite;
      
      public var mcBarsHolder:Sprite;
      
      public var mcInterfaceEffectsHolder:Sprite;
      
      public var mcMapEffectsHolder:MovieClip;
      
      public var mcMapHolder:MovieClip;
      
      public var mcSizer_btnAbort:Sprite;
      
      public var mcPickupsMouseHitArea:Sprite;
      
      public var mcMapHitArea:Sprite;
      
      public var btnAbort:BMButton;
      
      public var mcAbortShadow:Sprite;
      
      public var mcSaving:MovieClip;
      
      public var mcMechStats:MovieClip;
      
      public var mcUpgrades:MovieClip;
      
      public var mcLoot:MovieClip;
      
      public var mcMapArrow:MovieClip;
      
      public var mcCompleted1:MovieClip;
      
      public var mcCompleted2:MovieClip;
      
      public var mcTutorialArrow_usePickup:MovieClip;
      
      public var mcChatBubble:BMChatBubble;
      
      private var mcFloor:Sprite;
      
      private var playerMech:BMMapMech;
      
      private var bossMech:BMMapMech;
      
      private var mapMarker:MovieClip;
      
      private var _firstRefresh:Boolean = true;
      
      private var _mapObjects:Object;
      
      private var _dirts:Array;
      
      private var _map:Array;
      
      private var _mapOrigin:Array;
      
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
      
      private var _createGoldReward:uint;
      
      private var _createGoldRow:uint;
      
      private var _createGoldColumn:uint;
      
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
      
      private var _hpTotal:uint;
      
      private var _energyOrigin:uint;
      
      private var _energyRegenerationOrigin:uint;
      
      private var _heatOrigin:uint;
      
      private var _heatCoolingOrigin:uint;
      
      private var _bulletsTotal:uint;
      
      private var _rocketsTotal:uint;
      
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
      
      private var _lootGoldIconOriginXPos:Number;
      
      private var _lootGoldTextOriginXPos:Number;
      
      private var _flyingGold:Array = new Array();
      
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
      
      private var _fromBattle:Boolean;
      
      private var _fromPackages:Boolean;
      
      private const LIFE_X_JUMP:uint = 40;
      
      private const SQUARE_SIZE:uint = 75;
      
      private const WALKING_FRAMES:uint = 36;
      
      private const INTERFACE_PICKUPS_X_JUMP:uint = 40;
      
      private const INTERFACE_PICKUPS_X_MAX:uint = 205;
      
      private const INTERFACE_X_JUMP:uint = 300;
      
      private const VOLUME_RATIO:Number = 0.3;
      
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
      }
      
      public function refreshScreen(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc8_:Function = null;
         this._fromBattle = param1;
         this._fromPackages = param2;
         var _loc3_:Boolean = dataM.myProfile.mission_layout.length > 0;
         if(!_loc3_)
         {
            this.reloadMissionData();
            return;
         }
         dataM.trackScreenView("missionBaseMap");
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenMissionBaseMap","btnAbort","regular");
            switch(dataM.languageID)
            {
               case 3:
                  this.btnAbort.changeFontSize(31);
                  break;
               case 5:
                  this.btnAbort.changeFontSize(31);
                  break;
               default:
                  this.btnAbort.changeFontSize(33);
            }
            _loc8_ = this.abortClicked;
            if(dataM.runAsMobile)
            {
               _loc8_ = null;
            }
            this.btnAbort.initialize(getScreenText("abort"),"red",null,null,_loc8_,dataM.runAsMobile);
            this.btnAbort.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            if(dataM.runAsMobile == false)
            {
               this.mcMapHitArea.addEventListener(MouseEvent.CLICK,this.mapHitAreaClicked);
               this.mcPickupsMouseHitArea.addEventListener(MouseEvent.CLICK,this.upgradesClicked);
            }
            this.mcMapHolder.holder_dirt = new MovieClip();
            this.mcMapHolder.holder_floorSquares = new MovieClip();
            this.mcMapHolder.addChild(this.mcMapHolder.holder_floorSquares);
            this.mcMapHolder.addChild(this.mcMapHolder.holder_dirt);
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconHP,"mcHP","icon_HP");
            this.initializeBar("mcBarHP",this.mcMechStats.mcSizer_barHP,"red",4);
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconEnergy,"mcEnergy","icon_energy");
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconEnergyRegeneration,"mcEnergyRegeneration","icon_energyRegeneration");
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconHeat,"mcHeat","icon_heat");
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconHeatCooling,"mcHeatCooling","icon_heatCooling");
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconBullets,"mcBullets","icon_bullets");
            this.initializeBar("mcBarBullets",this.mcMechStats.mcSizer_barBullets,"yellow",4);
            this.createIconFromSizer(this.mcMechStats.mcSizer_iconRockets,"mcRockets","icon_rockets");
            this.initializeBar("mcBarRockets",this.mcMechStats.mcSizer_barRockets,"yellow",4);
            this.mapMarker = externalAssetsM.getAsset("general","map_floorMarker",this.SQUARE_SIZE,this.SQUARE_SIZE,false,false);
            this._lootGoldIconOriginXPos = this.mcLoot.mcGold.x;
            this._lootGoldTextOriginXPos = this.mcLoot.txtGold.x;
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
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this._playerLostConfirmed = false;
         if(dataM.mission_battleEnded)
         {
            this.battleEnded(dataM.mission_battleEnded_playerWon,dataM.mission_battleEnded_hp,dataM.mission_battleEnded_bullets,dataM.mission_battleEnded_rockets);
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
            this.deactivateSaving(true);
            dataM.mission_playerMechStatus = "";
            dataM.mission_playerMechDirection = "";
            if(param2 == false)
            {
               this._playerEntryHandler = true;
               this._playerEntryFrameCounter = 0;
            }
         }
         this.mcMechStats.x = this._mechStatsOriginXPos - this.INTERFACE_X_JUMP;
         this.mcUpgrades.x = this._upgradesOriginXPos - this.INTERFACE_X_JUMP;
         this.mcLoot.x = this._lootOriginXPos - this.INTERFACE_X_JUMP;
         this._saving = false;
         this._interfaceMotionFrameCounter = 0;
         this._missionCompleted = false;
         this._createGoldReward = 0;
         this._createUpgrade = "";
         this._lastRollOverredPickupSlot = -1;
         var _loc5_:Array = dataM.getClanFlagData(_loc4_.mission_flag);
         switch(_loc4_.mission_difficulty)
         {
            case 2:
               _loc4_.mission_colorID = 4;
               break;
            case 3:
               _loc4_.mission_colorID = 1;
               break;
            default:
               _loc4_.mission_colorID = 3;
         }
         this._playerPosition = _loc4_.mission_playerPosition;
         var _loc6_:Array = this.getPositionRowAndColumn(this._playerPosition);
         this._playerRow = _loc6_[0];
         this._playerColumn = _loc6_[1];
         this._walkingActive = false;
         this._walkingPath = new Array();
         this._walkingPathSlot = 0;
         if(param1 == false)
         {
            dataM.mission_destroyingMapObjectActive = false;
            this._destroyingPlayerActive = false;
         }
         this._mapRows = _loc4_.mission_rows;
         var _loc7_:uint = 0;
         while(_loc7_ <= this._mapRows + 1)
         {
            this.mcMapHolder["holder_objects" + _loc7_] = new Sprite();
            this.mcMapHolder.addChild(this.mcMapHolder["holder_objects" + _loc7_]);
            _loc7_++;
         }
         this._firstUpgradeTutorial = false;
         if(_loc4_.currentMissionSlot == 1)
         {
            if(_loc4_.mission_upgrades.length == 1)
            {
               this._firstUpgradeTutorial = true;
               this.mcTutorialArrow_usePickup.gotoAndStop("animOn");
            }
         }
         this.resetPlayerTarget();
         this.refreshFloor();
         this.refreshStats(false);
         this.refreshLootGold();
         this.refreshMap(param1);
         this.createPlayerMech(param1,param2);
         this.createLootBoxArray();
         this.createAvailableUpgrades();
         this._playerNeedsToReviveBlock = false;
         if(param1 == false && _loc4_.mission_hp <= 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("missionRevive");
            this._playerNeedsToReviveBlock = true;
         }
         this.refreshTutorial();
         if(_loc4_.currentMissionSlot > 1)
         {
            this.btnAbort.enableMe();
            this.btnAbort.visible = true;
            this.mcAbortShadow.visible = true;
         }
         else
         {
            this.btnAbort.visible = false;
            this.mcAbortShadow.visible = false;
         }
         this.mcCompleted1.visible = false;
         this.mcCompleted2.visible = false;
         this.mcCompleted1.y = -200;
         this.mcCompleted2.y = dataM.STAGE_HEIGHT + 200;
         screensM.addScreen("screenTopBar");
         screensM.screenTopBar.refreshScreen(param1);
         screensM.screenTopBar.enableButtons("missionBaseMap refreshScreen");
         this.checkIfMissionIsComplete();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.mcMechStats.txtStats,18);
            TextUtils.updateTextFormat(this.mcMechStats.txtHP,16);
            TextUtils.updateTextFormat(this.mcMechStats.txtEnergy,14);
            TextUtils.updateTextFormat(this.mcMechStats.txtEnergyRegeneration,14);
            TextUtils.updateTextFormat(this.mcMechStats.txtHeat,14);
            TextUtils.updateTextFormat(this.mcMechStats.txtHeatCooling,14);
            TextUtils.updateTextFormat(this.mcMechStats.txtBullets,14);
            TextUtils.updateTextFormat(this.mcMechStats.txtRockets,14);
            TextUtils.updateTextFormat(this.mcUpgrades.txtUpgrades,18);
            TextUtils.updateTextFormat(this.mcLoot.txtLoot,18);
            TextUtils.updateTextFormat(this.mcLoot.txtGold,18);
            TextUtils.updateTextFormat(this.mcSaving.txtSaving,20);
            _loc2_ = 50;
            switch(dataM.languageID)
            {
               case 1:
                  _loc2_ = 61;
            }
            TextUtils.updateTextFormat(this.mcCompleted1.txtTitle,_loc2_);
            TextUtils.updateTextFormat(this.mcCompleted2.txtTitle,_loc2_);
            TextUtils.updateTextFormat(this.btnAbort.txtButtonName);
            param1 = true;
         }
         if(param1)
         {
            switch(dataM.languageID)
            {
               case 3:
                  this.btnAbort.changeFontSize(31);
                  break;
               case 5:
                  this.btnAbort.changeFontSize(31);
                  break;
               default:
                  this.btnAbort.changeFontSize(33);
            }
            this.btnAbort.setButtonName(getScreenText("abort"));
         }
         this.mcMechStats.txtStats.text = getScreenText("stats");
         this.mcUpgrades.txtUpgrades.text = getScreenText("upgrades");
         this.mcLoot.txtLoot.text = getScreenText("loot");
         this.mcCompleted1.txtTitle.text = getScreenText("missionCompleted1");
         this.mcCompleted2.txtTitle.text = getScreenText("missionCompleted2");
         this.mcSaving.txtSaving.text = getScreenText("saving");
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
         if(parent != null)
         {
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
            }
            else
            {
               this.mapPickupsHandler();
               this.interfacePickupsHandler();
               this.playerWalkingHandler();
               if(this.playerMech != null)
               {
                  this.playerMech.onEnterFrameTrigger();
               }
               if(this.bossMech != null)
               {
                  this.bossMech.onEnterFrameTrigger();
               }
               if(this.mcChatBubble != null)
               {
                  if(this._chatBubbleXPos > 0)
                  {
                     if(this.mcChatBubble.parent != null)
                     {
                        this.mcChatBubble.onEnterFrameTrigger(this._chatBubbleXPos,this._chatBubbleYPos);
                     }
                  }
               }
               this.destroyMapObjectHandler();
               this.destroyPlayerHandler();
               this.savingHandler();
               this.pickupsTooltipHandler();
               this.interfaceMotionHandler();
               this.playerEntryHandler();
               this.mapArrowHandler();
               this.flyingGoldHandler();
               this.missionCompletedHandler();
               this.lootBoxSparksHandler();
            }
         }
      }
      
      private function refreshTutorial() : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Object = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Object = null;
         var _loc14_:Object = null;
         var _loc15_:uint = 0;
         var _loc16_:Number = NaN;
         var _loc17_:uint = 0;
         this._tutorialForceMovement = false;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.currentMissionSlot <= 1)
         {
            _loc2_ = new Array();
            _loc3_ = new Array();
            _loc4_ = new Array();
            _loc5_ = 1;
            while(_loc5_ <= _loc1_.mission_rows)
            {
               _loc8_ = 1;
               for(; _loc8_ <= _loc1_.mission_columns; _loc8_++)
               {
                  if(this._map[_loc5_][_loc8_] == null)
                  {
                     continue;
                  }
                  if(this._map[_loc5_][_loc8_] == "")
                  {
                     continue;
                  }
                  _loc9_ = dataM.missionMapObjectDB[this._map[_loc5_][_loc8_]];
                  _loc10_ = this._playerColumn - _loc8_;
                  _loc11_ = this._playerRow - _loc5_;
                  _loc12_ = Math.round(dataM.getVectorSize(_loc10_,_loc11_) * 10);
                  _loc13_ = {
                     "row":_loc5_,
                     "column":_loc8_,
                     "distance":_loc12_
                  };
                  switch(_loc9_.type)
                  {
                     case "enemy":
                        _loc2_.push(_loc13_);
                        break;
                     case "structure":
                     case "crate":
                        _loc3_.push(_loc13_);
                        break;
                     case "loot":
                        _loc4_.push(_loc13_);
                  }
               }
               _loc5_++;
            }
            _loc7_ = 0;
            if(_loc1_.currentMissionSlot == 0)
            {
               if(_loc3_.length > 0)
               {
                  _loc6_ = _loc3_;
               }
               else if(_loc2_.length > 0)
               {
                  _loc6_ = _loc2_;
               }
               else if(_loc4_.length > 0)
               {
                  _loc6_ = _loc4_;
               }
            }
            else if(this._firstUpgradeTutorial == false)
            {
               if(_loc2_.length == 2)
               {
                  _loc6_ = _loc2_;
               }
               else if(_loc3_.length == 1)
               {
                  _loc6_ = _loc3_;
               }
               else if(_loc2_.length == 1)
               {
                  _loc6_ = _loc2_;
               }
               else if(_loc4_.length > 0)
               {
                  _loc6_ = _loc4_;
               }
               _loc7_ = 120;
            }
            if(_loc6_ != null)
            {
               _loc15_ = 0;
               if(_loc6_.length > 1)
               {
                  _loc16_ = Number(_loc6_[_loc15_].distance);
                  _loc17_ = 1;
                  while(_loc17_ < _loc6_.length)
                  {
                     _loc14_ = _loc6_[_loc17_];
                     if(_loc14_.distance < _loc16_)
                     {
                        _loc15_ = _loc17_;
                        _loc16_ = Number(_loc14_.distance);
                     }
                     _loc17_++;
                  }
               }
               _loc14_ = _loc6_[_loc15_];
               this.showMapArrow(_loc14_.row,_loc14_.column,_loc7_);
               if(_loc1_.currentMissionSlot == 0)
               {
                  this._tutorialForceMovement = true;
                  this._tutorialForceMovementRow = _loc14_.row;
                  this._tutorialForceMovementColumn = _loc14_.column;
               }
            }
            else
            {
               this.hideMapArrow();
            }
         }
      }
      
      private function showMapArrow(param1:uint, param2:uint, param3:uint = 0) : void
      {
         this.mcMapArrow.x = (param2 - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
         this.mcMapArrow.y = (param1 - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
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
         if(this._mapArrowHandler)
         {
            if(this._mapArrowDelayFrames > 0)
            {
               --this._mapArrowDelayFrames;
            }
            else
            {
               ++this._mapArrowFrameCounter;
               if(this._mapArrowFrameCounter > 30)
               {
                  this.mcMapArrow.gotoAndStop("animOn");
                  this._mapArrowHandler = false;
               }
            }
         }
      }
      
      private function refreshMap(param1:Boolean) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Array = null;
         var _loc12_:uint = 0;
         var _loc15_:String = null;
         var _loc16_:Boolean = false;
         var _loc17_:Sprite = null;
         var _loc18_:Boolean = false;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:String = null;
         var _loc22_:Object = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:String = null;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._halfMapWidth = _loc2_.mission_columns * this.SQUARE_SIZE / 2;
         this._halfMapHeight = _loc2_.mission_rows * this.SQUARE_SIZE / 2;
         this._map = new Array();
         this._mapOrigin = new Array();
         _loc3_ = 1;
         while(_loc3_ <= _loc2_.mission_rows)
         {
            this._map[_loc3_] = new Array();
            this._mapOrigin[_loc3_] = new Array();
            _loc4_ = 1;
            while(_loc4_ <= _loc2_.mission_columns)
            {
               this._map[_loc3_][_loc4_] = "";
               this._mapOrigin[_loc3_][_loc4_] = "";
               _loc4_++;
            }
            _loc3_++;
         }
         this._mapObjects = new Object();
         var _loc5_:String = "";
         var _loc6_:String = "";
         var _loc7_:Number = _loc2_.mission_layout.length - 1;
         _loc12_ = 0;
         while(_loc12_ < _loc2_.mission_layout.length)
         {
            _loc15_ = _loc2_.mission_layout.substr(_loc12_,1);
            if(_loc15_ == "_" || _loc15_ == "|" || _loc12_ == _loc7_)
            {
               if(_loc6_ == "")
               {
                  _loc6_ = _loc5_;
                  _loc5_ = "";
               }
               else
               {
                  if(_loc12_ == _loc7_)
                  {
                     _loc5_ += _loc15_;
                  }
                  _loc8_ = int(_loc5_);
                  _loc11_ = this.getPositionRowAndColumn(_loc8_);
                  _loc9_ = Number(_loc11_[0]);
                  _loc10_ = Number(_loc11_[1]);
                  this._map[_loc9_][_loc10_] = _loc6_;
                  this._mapOrigin[_loc9_][_loc10_] = _loc6_;
                  _loc5_ = "";
               }
               if(_loc15_ == "|")
               {
                  _loc6_ = "";
               }
            }
            else
            {
               _loc5_ += _loc15_;
            }
            _loc12_++;
         }
         this._floorSquares = new Array();
         var _loc13_:Boolean = false;
         _loc3_ = 1;
         while(_loc3_ <= _loc2_.mission_rows)
         {
            _loc4_ = 1;
            while(_loc4_ <= _loc2_.mission_columns)
            {
               _loc16_ = false;
               if(this._map[_loc3_][_loc4_] != "")
               {
                  if(dataM.missionMapObjectDB[this._map[_loc3_][_loc4_]].type == "invisibleBlock")
                  {
                     _loc16_ = true;
                     _loc13_ = true;
                  }
               }
               if(_loc16_ == false)
               {
                  _loc17_ = externalAssetsM.getAsset("general","map_floorSquare",this.SQUARE_SIZE,this.SQUARE_SIZE,false,false);
                  _loc17_.x = (_loc4_ - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
                  _loc17_.y = (_loc3_ - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
                  this.mcMapHolder.holder_floorSquares.addChild(_loc17_);
                  this._floorSquares.push(_loc17_);
               }
               _loc4_++;
            }
            _loc3_++;
         }
         if(this.mapMarker.parent != null)
         {
            this.mapMarker.parent.removeChild(this.mapMarker);
         }
         this.mcMapHolder.holder_floorSquares.addChild(this.mapMarker);
         _loc12_ = 0;
         while(_loc12_ < _loc2_.mission_progress.length)
         {
            _loc8_ = Number(_loc2_.mission_progress[_loc12_]);
            _loc11_ = this.getPositionRowAndColumn(_loc8_);
            _loc9_ = Number(_loc11_[0]);
            _loc10_ = Number(_loc11_[1]);
            _loc18_ = false;
            if(dataM.mission_battleEnemyType != "")
            {
               if(_loc9_ == dataM.mission_battleRow && _loc10_ == dataM.mission_battleColumn)
               {
                  _loc18_ = true;
                  this.resetBattleTrackingData();
               }
            }
            if(_loc18_ == false)
            {
               _loc19_ = 0;
               _loc20_ = 0;
               _loc21_ = this._map[_loc9_][_loc10_];
               _loc22_ = dataM.missionMapObjectDB[_loc21_];
               switch(_loc22_.type)
               {
                  case "enemy":
                  case "structure":
                  case "crate":
                     _loc19_ = uint(_loc22_.dirtSize);
                     break;
                  case "loot":
                     _loc20_ = uint(_loc22_.pickups);
               }
               this._map[_loc9_][_loc10_] = "";
               if(_loc20_ > 0)
               {
                  this.createInterfacePickups("loot","loot",_loc20_);
               }
               if(_loc19_ > 0)
               {
                  _loc23_ = (_loc10_ - 0.5 - _loc2_.mission_columns / 2) * this.SQUARE_SIZE;
                  _loc24_ = (_loc9_ - 0.5 - _loc2_.mission_rows / 2) * this.SQUARE_SIZE;
                  this.createDirt(_loc23_,_loc24_,_loc19_);
               }
            }
            _loc12_++;
         }
         _loc12_ = 0;
         while(_loc12_ < _loc2_.mission_upgrades.length)
         {
            _loc25_ = dataM.missionUpgradesDB[_loc2_.mission_upgrades[_loc12_]];
            this.createSpecificInterfacePickup("upgrade",_loc25_);
            _loc12_++;
         }
         _loc3_ = 1;
         while(_loc3_ <= _loc2_.mission_rows)
         {
            _loc4_ = 1;
            while(_loc4_ <= _loc2_.mission_columns)
            {
               if(this._map[_loc3_][_loc4_] != "")
               {
                  this.createMapObject(_loc3_,_loc4_);
               }
               _loc4_++;
            }
            _loc3_++;
         }
         var _loc14_:Boolean = false;
         if(_loc13_)
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
         var _loc5_:BMMapObject = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:MovieClip = null;
         var _loc9_:ColorTransform = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:BitmapData = null;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:Object = dataM.missionMapObjectDB[this._map[param1][param2]];
         if(_loc4_.type != "invisibleBlock")
         {
            _loc5_ = new BMMapObject();
            _loc6_ = _loc4_.grp;
            _loc7_ = _loc3_.mission_colorID;
            switch(_loc4_.type)
            {
               case "loot":
                  switch(_loc3_.mission_difficulty)
                  {
                     case 1:
                        _loc6_ += "A";
                        break;
                     case 2:
                        _loc6_ += "B";
                        break;
                     case 3:
                        _loc6_ += "C";
                  }
                  break;
               case "enemy":
                  switch(_loc4_.grp)
                  {
                     case "boss":
                        _loc7_ = 9;
                  }
            }
            _loc6_ = "mo_" + _loc6_;
            _loc8_ = externalAssetsM.getAsset("general",_loc6_);
            _loc8_.x = (param2 - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
            _loc8_.y = (param1 - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
            if(_loc8_.mcColor != null)
            {
               _loc9_ = new ColorTransform();
               _loc9_.color = dataM.colorsDB[_loc7_];
               _loc8_.mcColor.transform.colorTransform = _loc9_;
               _loc8_.mcColor.blendMode = BlendMode.OVERLAY;
               if(dataM.runAsMobile)
               {
                  if(_loc8_.itemGfx != null)
                  {
                     _loc10_ = 2;
                     _loc8_.itemGfx.width *= _loc10_;
                     _loc8_.itemGfx.height *= _loc10_;
                     _loc8_.mcColor.width *= _loc10_;
                     _loc8_.mcColor.height *= _loc10_;
                     _loc11_ = -_loc8_.itemGfx.x;
                     _loc12_ = -_loc8_.itemGfx.y;
                     _loc8_.itemGfx.x += _loc11_;
                     _loc8_.itemGfx.y += _loc12_;
                     _loc8_.mcColor.x += _loc11_;
                     _loc8_.mcColor.y += _loc12_;
                     _loc13_ = new BitmapData(_loc8_.width,_loc8_.height,true,0);
                     _loc13_.draw(_loc8_);
                     _loc8_.gpuImage = new Bitmap(_loc13_,"auto",true);
                     _loc8_.gpuImage.width /= _loc10_;
                     _loc8_.gpuImage.height /= _loc10_;
                     _loc8_.gpuImage.x = -_loc11_;
                     _loc8_.gpuImage.y = -_loc12_;
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
            _loc5_.initialize(param1,param2,_loc8_,_loc4_.code,_loc4_.grp);
            this.mcMapHolder["holder_objects" + param1].addChild(_loc8_);
            this._mapObjects[param1 + "_" + param2] = _loc5_;
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
      
      private function mapHitAreaClicked(param1:MouseEvent) : void
      {
         this.mapHitAreaClickedSub(true);
      }
      
      public function mapHitAreaClickedSub(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerProfile = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:uint = 0;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Number = NaN;
         var _loc15_:String = null;
         var _loc16_:Object = null;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Boolean = false;
         var _loc20_:BMMapObject = null;
         var _loc21_:BMMapObject = null;
         if(screensM.screenBlack.isActive() == false)
         {
            if(this._missionCompleted == false && this._bossStompAnimationActive == false)
            {
               if(!this._firstUpgradeTutorial)
               {
                  _loc2_ = false;
                  _loc3_ = false;
                  if(this.isAnimationActive())
                  {
                     if(this._walkingActive)
                     {
                        _loc3_ = true;
                     }
                  }
                  else
                  {
                     _loc2_ = true;
                  }
                  if(_loc2_ || _loc3_)
                  {
                     _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                     _loc5_ = this.SQUARE_SIZE * this.mcMapHolder.scaleX;
                     _loc6_ = this.mcMapHolder.x - _loc4_.mission_columns / 2 * _loc5_;
                     _loc7_ = this.mcMapHolder.y - _loc4_.mission_rows / 2 * _loc5_;
                     if(this._walkingFinalInteractionRow == -1 || param1)
                     {
                        _loc8_ = Math.ceil((mouseX - _loc6_) / _loc5_);
                        _loc9_ = Math.ceil((mouseY - _loc7_) / _loc5_);
                     }
                     else
                     {
                        _loc8_ = this._walkingFinalInteractionColumn;
                        _loc9_ = this._walkingFinalInteractionRow;
                        this._walkingFinalInteractionRow = -1;
                        this._walkingFinalInteractionColumn = -1;
                     }
                     _loc10_ = false;
                     if(this._tutorialForceMovement)
                     {
                        if(this._tutorialForceMovementRow != _loc9_ || this._tutorialForceMovementColumn != _loc8_)
                        {
                           _loc10_ = true;
                        }
                     }
                     if(_loc10_)
                     {
                        this.activateMapMarker(_loc9_,_loc8_,"red");
                     }
                     else if(_loc3_)
                     {
                        this.changeExistingWalkingPath(_loc9_,_loc8_);
                     }
                     else
                     {
                        this._targetBattleSubType = "";
                        if(this._map[_loc9_] != null)
                        {
                           if(this._map[_loc9_][_loc8_] != null)
                           {
                              _loc11_ = 0;
                              _loc12_ = false;
                              _loc13_ = false;
                              _loc14_ = (_loc9_ - 1) * _loc4_.mission_columns + _loc8_;
                              _loc15_ = "";
                              if(this._map[_loc9_][_loc8_] != "")
                              {
                                 _loc16_ = dataM.missionMapObjectDB[this._map[_loc9_][_loc8_]];
                                 _loc15_ = _loc16_.type;
                                 switch(_loc15_)
                                 {
                                    case "enemy":
                                       this._targetBattleSubType = _loc16_.grp;
                                       break;
                                    case "loot":
                                       _loc11_ = uint(_loc16_.pickups);
                                 }
                              }
                              if(_loc15_ != "")
                              {
                                 _loc17_ = false;
                                 _loc18_ = false;
                                 _loc19_ = false;
                                 if(Math.abs(this._playerRow - _loc9_) <= 1 && this._playerColumn == _loc8_)
                                 {
                                    _loc19_ = true;
                                 }
                                 if(Math.abs(this._playerColumn - _loc8_) <= 1 && this._playerRow == _loc9_)
                                 {
                                    _loc18_ = true;
                                 }
                                 if(_loc18_ || _loc19_)
                                 {
                                    _loc17_ = true;
                                 }
                                 if(_loc17_)
                                 {
                                    if(_loc18_)
                                    {
                                       if(this._playerColumn > _loc8_)
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
                                    else if(this._playerRow > _loc9_)
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
                                       _loc20_ = this._mapObjects[_loc9_ + "_" + _loc8_];
                                       switch(_loc15_)
                                       {
                                          case "structure":
                                          case "crate":
                                             this.addProgress(_loc14_);
                                             dataM.mission_destroyingMapObjectActive = true;
                                             dataM.mission_destroyingMapObjectRow = _loc9_;
                                             dataM.mission_destroyingMapObjectColumn = _loc8_;
                                             dataM.mission_destroyingMapObjectFrameCounter = 10;
                                             break;
                                          case "enemy":
                                             switch(_loc20_.grp)
                                             {
                                                case "boss":
                                                   if(this.getEnemiesRemained() > 1)
                                                   {
                                                      _loc12_ = true;
                                                   }
                                             }
                                             if(_loc12_ == false)
                                             {
                                                dataM.mission_battleRow = _loc9_;
                                                dataM.mission_battleColumn = _loc8_;
                                                dataM.mission_battleEnemyType = this._map[_loc9_][_loc8_];
                                                screensM.screenBlack.activateBlackScreen(this.startBattle,true,true,null,0);
                                             }
                                             break;
                                          case "loot":
                                             this.createMapPickups(_loc9_,_loc8_,"loot","loot",_loc11_);
                                             this.destroyMapObject(_loc9_,_loc8_,false);
                                             this.addProgress(_loc14_);
                                       }
                                    }
                                 }
                                 else
                                 {
                                    _loc13_ = true;
                                 }
                              }
                              else
                              {
                                 _loc13_ = true;
                              }
                              if(_loc12_)
                              {
                                 this.showChatBubble("MY MINIONS ARE WAITING FOR YOU...");
                                 this._bossMapObjectName = _loc9_ + "_" + _loc8_;
                                 _loc21_ = this._mapObjects[this._bossMapObjectName];
                                 _loc21_.mcGrp.visible = false;
                                 this.createBossMech(_loc21_.mcGrp.x,_loc21_.mcGrp.y);
                              }
                              if(_loc13_)
                              {
                                 this.playerMech.deactivateFireAnimation();
                                 this._walkingPath = this.getPathToPosition(_loc14_);
                                 if(this._walkingPath.length > 0)
                                 {
                                    this._walkingActive = true;
                                    this._walkingPathSlot = 0;
                                    this._walkingFrameCounter = 0;
                                    this._walkingTotalFrameCounter = 0;
                                    this.activateMapMarker(_loc9_,_loc8_,"green");
                                 }
                                 else
                                 {
                                    this.activateMapMarker(_loc9_,_loc8_,"red");
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
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
      
      private function startBattle() : void
      {
         if(screensM.isScreenOpened("screenWorldMapSelectBattle"))
         {
            screensM.screenWorldMapSelectBattle.cleanScreen();
         }
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Number = (dataM.mission_battleRow - 1) * _loc2_.mission_columns + dataM.mission_battleColumn;
         var _loc4_:Number = -1;
         var _loc5_:Number = -1;
         if(_loc2_.mission_startPositions[_loc3_] != null)
         {
            _loc1_ = true;
            _loc4_ = Number(_loc2_.mission_startPositions[_loc3_].player1Step);
            _loc5_ = Number(_loc2_.mission_startPositions[_loc3_].player2Step);
         }
         dataM.startBattleVSComputer("mission",this._targetBattleSubType,_loc4_,_loc5_,_loc3_);
         this.saveComputerItemsInPlayerProfile(_loc3_);
         if(_loc1_ == false)
         {
            _loc2_.mission_startPositions[_loc3_] = {
               "player1Step":dataM.battleData.player1.currentStep,
               "player2Step":dataM.battleData.player2.currentStep
            };
         }
         this.removeMe();
         screensM.removeScreen("screenTopBar");
         screensM.addBattleScreens();
      }
      
      private function saveComputerItemsInPlayerProfile(param1:Number) : void
      {
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:Object = null;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player2PlayerID];
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc3_.mission_computerItems[param1] = new Array();
         for each(_loc4_ in _loc2_.items)
         {
            _loc5_ = new Object();
            _loc5_.playerItemID = _loc4_.playerItemID;
            _loc5_.itemID = _loc4_.itemID;
            _loc5_.equipmentType = _loc4_.equipmentType;
            _loc5_.equipmentID = _loc4_.equipmentID;
            _loc5_.equipped = _loc4_.equipped;
            _loc5_.colorID = _loc4_.colorID;
            _loc5_.power = _loc4_.power;
            _loc3_.mission_computerItems[param1].push(_loc5_);
         }
      }
      
      public function battleEnded(param1:Boolean, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:Boolean = false;
         var _loc5_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(param1)
         {
            _loc5_.mission_hp = param2;
            _loc5_.mission_bullets = param3;
            _loc5_.mission_rockets = param4;
            _loc6_ = (dataM.mission_battleRow - 1) * _loc5_.mission_columns + dataM.mission_battleColumn;
            this.addProgress(_loc6_);
            dataM.mission_destroyingMapObjectActive = true;
            dataM.mission_destroyingMapObjectRow = dataM.mission_battleRow;
            dataM.mission_destroyingMapObjectColumn = dataM.mission_battleColumn;
            dataM.mission_destroyingMapObjectFrameCounter = 0;
         }
         else
         {
            _loc7_ = false;
            if(_loc5_.mission_hp != param2)
            {
               _loc7_ = true;
            }
            else if(_loc5_.mission_bullets != param3)
            {
               _loc7_ = true;
            }
            else if(_loc5_.mission_rockets != param4)
            {
               _loc7_ = true;
            }
            if(_loc7_)
            {
               if(param2 > 0)
               {
                  _loc5_.mission_hp = param2;
                  _loc5_.mission_bullets = param3;
                  _loc5_.mission_rockets = param4;
                  this.addProgress(0);
               }
               else
               {
                  _loc5_.mission_hp = 0;
                  _loc5_.mission_bullets = 0;
                  _loc5_.mission_rockets = 0;
                  this._playerLostConfirmed = false;
                  this._destroyingPlayerActive = true;
                  this._destroyingPlayerFrameCounter = 0;
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     remoteM.socketM.mission_playerLost();
                     this.activateSaving();
                  }
                  else
                  {
                     this.playerLostSuccessful();
                  }
               }
               this.resetBattleTrackingData();
            }
         }
         dataM.saveGuestData("missionBaseMap battleEnded");
      }
      
      public function playerLostSuccessful() : void
      {
         this._playerLostConfirmed = true;
         this.deactivateSaving(false);
      }
      
      private function createDirt(param1:Number, param2:Number, param3:uint) : void
      {
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc5_:String = "dirt" + _loc4_.mission_themeID + "_" + Math.ceil(Math.random() * 3);
         var _loc6_:Sprite = externalAssetsM.getAsset("general",_loc5_);
         switch(param3)
         {
            case 1:
               _loc6_.scaleX = 0.25;
               _loc6_.scaleY = 0.25;
               break;
            case 2:
               _loc6_.scaleX = 0.37;
               _loc6_.scaleY = 0.37;
               break;
            case 3:
               _loc6_.scaleX = 0.5;
               _loc6_.scaleY = 0.5;
         }
         _loc6_.x = param1;
         _loc6_.y = param2;
         this.mcMapHolder.holder_dirt.addChild(_loc6_);
         this._dirts.push(_loc6_);
      }
      
      private function addProgress(param1:uint) : void
      {
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            remoteM.socketM.mission_addProgress(param1,_loc2_.mission_hp,_loc2_.mission_energy,_loc2_.mission_energyRegeneration,_loc2_.mission_heat,_loc2_.mission_heatCooling,_loc2_.mission_bullets,_loc2_.mission_rockets);
         }
         if(param1 > 0)
         {
            _loc2_.mission_progress.push(param1);
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            this.activateSaving();
         }
         else
         {
            dataM.saveGuestData("missionBaseMap addProgress");
         }
      }
      
      public function getEnemiesDestroyed() : uint
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:uint = 0;
         if(this._mapOrigin != null)
         {
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc3_ = 1;
            while(_loc3_ <= _loc2_.mission_rows)
            {
               _loc4_ = 1;
               while(_loc4_ <= _loc2_.mission_columns)
               {
                  switch(this._mapOrigin[_loc3_][_loc4_])
                  {
                     case "BS":
                     case "ME":
                     case "TK":
                     case "JP":
                        if(this._map[_loc3_][_loc4_] != this._mapOrigin[_loc3_][_loc4_])
                        {
                           _loc1_++;
                        }
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
         }
         trace("enemiesDestroyed:" + _loc1_);
         return _loc1_;
      }
      
      public function getEnemiesRemained() : uint
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:uint = 0;
         if(this._mapOrigin != null)
         {
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc3_ = 1;
            while(_loc3_ <= _loc2_.mission_rows)
            {
               _loc4_ = 1;
               while(_loc4_ <= _loc2_.mission_columns)
               {
                  switch(this._mapOrigin[_loc3_][_loc4_])
                  {
                     case "BS":
                     case "ME":
                     case "TK":
                     case "JP":
                        if(this._map[_loc3_][_loc4_] == this._mapOrigin[_loc3_][_loc4_])
                        {
                           _loc1_++;
                        }
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
         }
         trace("enemiesRemained:" + _loc1_);
         return _loc1_;
      }
      
      public function progressAdded(param1:String, param2:uint) : void
      {
         this.deactivateSaving(false);
         if(param2 > 0)
         {
            this._createGoldReward = param2;
            this._createGoldRow = dataM.mission_destroyingMapObjectRow;
            this._createGoldColumn = dataM.mission_destroyingMapObjectColumn;
            if(dataM.mission_destroyingMapObjectActive == false)
            {
               this.createGoldReward();
            }
         }
         else if(param1 != "")
         {
            this._createUpgrade = param1;
            this._createUpgradeRow = dataM.mission_destroyingMapObjectRow;
            this._createUpgradeColumn = dataM.mission_destroyingMapObjectColumn;
            if(dataM.mission_destroyingMapObjectActive == false)
            {
               this.createUpgrade();
            }
         }
      }
      
      private function destroyMapObject(param1:uint, param2:uint, param3:Boolean) : void
      {
         var _loc6_:BMPlayerProfile = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc4_:String = param1 + "_" + param2;
         var _loc5_:BMMapObject = this._mapObjects[_loc4_];
         if(_loc5_ != null)
         {
            _loc6_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               _loc7_ = "";
               _loc8_ = 0;
               if(this._map[param1][param2].substr(0,1) == "C")
               {
                  if(_loc6_.currentMissionSlot == 1)
                  {
                     _loc7_ = "HP";
                  }
                  else
                  {
                     _loc9_ = Math.ceil(Math.random() * this._availableUpgrades.length) - 1;
                     _loc7_ = this._availableUpgrades[_loc9_];
                  }
               }
               else if(this._map[param1][param2].substr(0,1) == "S")
               {
                  _loc8_ = 100 + (_loc6_.mission_difficulty - 1) * 50;
               }
               if(_loc7_ != "" || _loc8_ > 0)
               {
                  dataM.mission_destroyingMapObjectRow = param1;
                  dataM.mission_destroyingMapObjectColumn = param2;
               }
               if(_loc6_.gold >= dataM.GUEST_MAX_GOLD)
               {
                  _loc8_ = 0;
               }
               this.progressAdded(_loc7_,_loc8_);
            }
            if(_loc6_.currentMissionSlot == 1)
            {
               if(dataM.missionMapObjectDB[_loc5_.code].type == "crate")
               {
                  this._firstUpgradeTutorial = true;
                  this.mcTutorialArrow_usePickup.gotoAndStop("animOn");
               }
            }
            if(param3)
            {
               _loc10_ = uint(dataM.missionMapObjectDB[_loc5_.code].dirtSize);
               _loc11_ = _loc5_.mcGrp.x;
               _loc12_ = _loc5_.mcGrp.y;
               this.createExplosion(_loc11_,_loc12_);
               if(_loc10_ > 0)
               {
                  this.createDirt(_loc11_,_loc12_,_loc10_);
               }
            }
            _loc5_.removeMe();
            this._mapObjects[_loc4_] = null;
            this._map[param1][param2] = "";
            this.createGoldReward();
            this.createUpgrade();
            dataM.saveGuestData("missionBaseMap destroyMapObject");
            this.refreshTutorial();
         }
         this.checkIfMissionIsComplete();
      }
      
      private function destroyMapObjectHandler() : void
      {
         var _loc1_:BMMapObject = null;
         if(dataM.mission_destroyingMapObjectActive)
         {
            ++dataM.mission_destroyingMapObjectFrameCounter;
            if(dataM.mission_destroyingMapObjectFrameCounter == 11)
            {
               this.playerMech.activateFireAnimation();
            }
            if(dataM.mission_destroyingMapObjectFrameCounter == 19)
            {
               _loc1_ = this._mapObjects[dataM.mission_destroyingMapObjectRow + "_" + dataM.mission_destroyingMapObjectColumn];
               effectsM.createSparksMC("screenMissionBaseMap","spark",_loc1_.mcGrp.x,_loc1_.mcGrp.y,1,8,40,"up","orange",true);
            }
            if(dataM.mission_destroyingMapObjectFrameCounter >= 30)
            {
               this.destroyMapObject(dataM.mission_destroyingMapObjectRow,dataM.mission_destroyingMapObjectColumn,true);
               this.resetBattleTrackingData();
               dataM.mission_destroyingMapObjectActive = false;
            }
         }
      }
      
      private function resetBattleTrackingData() : void
      {
         dataM.mission_battleRow = 0;
         dataM.mission_battleColumn = 0;
         dataM.mission_battleEnemyType = "";
      }
      
      private function createPlayerMech(param1:Boolean, param2:Boolean) : void
      {
         this.removePlayerMech();
         this.playerMech = new BMMapMech();
         this.playerMech.initialize();
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:Number = _loc3_.mission_playerPosition;
         var _loc5_:Number = Math.floor((_loc4_ - 1) / _loc3_.mission_columns) + 1;
         var _loc6_:Number = _loc4_ - _loc3_.mission_columns * (_loc5_ - 1);
         this.mcMapHolder["holder_objects" + _loc5_].addChild(this.playerMech);
         if(param1 == false && param2 == false)
         {
            _loc5_ += 2;
         }
         this.playerMech.x = (_loc6_ - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
         this.playerMech.y = (_loc5_ - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
         if(dataM.mission_playerMechStatus != "")
         {
            this.playerMech.setStatusAndDirection(dataM.mission_playerMechStatus,dataM.mission_playerMechDirection);
         }
         var _loc7_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc8_:uint = 1;
         var _loc9_:BMMechStructure = _loc7_.mechStructures[_loc8_];
         var _loc10_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,_loc9_.torso);
         var _loc11_:uint = _loc10_.colorID;
         if(_loc11_ == 0)
         {
            _loc11_ = dataM.getItemPowerColorID(dataM.player1PlayerID,_loc9_.torso);
         }
         _loc10_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc9_.leg);
         var _loc12_:uint = _loc10_.colorID;
         if(_loc12_ == 0)
         {
            _loc12_ = dataM.getItemPowerColorID(dataM.player1PlayerID,_loc9_.leg);
         }
         this.playerMech.colorMech(_loc11_,_loc12_);
      }
      
      private function playerWalkingHandler() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:BMPlayerProfile = null;
         if(this._walkingActive)
         {
            if(this._walkingFrameCounter == 0)
            {
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
                  this._playerRow = this._walkingPath[this._walkingPathSlot].row;
                  this._playerColumn = this._walkingPath[this._walkingPathSlot].column;
                  this._walkingFrameCounter = 1;
               }
               else
               {
                  _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                  this._playerPosition = (this._playerRow - 1) * _loc3_.mission_columns + this._playerColumn;
                  _loc3_.mission_playerPosition = this._playerPosition;
                  this._walkingActive = false;
                  this._walkingFrameCounter = this.WALKING_FRAMES + 1;
                  if(this._walkingFinalInteractionRow > -1)
                  {
                     this.mapHitAreaClickedSub(false);
                  }
                  else if(this._walkingDirectionRow != 0)
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
            }
            ++this._walkingTotalFrameCounter;
            if(this._walkingTotalFrameCounter % 12 == 0)
            {
               soundM.createSound("footStep",this.VOLUME_RATIO);
            }
            if(this._walkingFrameCounter <= this.WALKING_FRAMES)
            {
               if(this._walkingFrameCounter == this.WALKING_FRAMES)
               {
                  this.playerMech.x = (this._walkingPath[this._walkingPathSlot].column - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
                  this.playerMech.y = (this._walkingPath[this._walkingPathSlot].row - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
                  this._walkingFrameCounter = 0;
                  if(this._walkingDirectionRow != 0)
                  {
                     if(this._walkingPath[this._walkingPathSlot] != null)
                     {
                        this.playerMech.removeMe();
                        this.mcMapHolder["holder_objects" + this._walkingPath[this._walkingPathSlot].row].addChild(this.playerMech);
                     }
                  }
               }
               else
               {
                  if(this._walkingDirectionRow != 0)
                  {
                     this.playerMech.y += this.SQUARE_SIZE / this.WALKING_FRAMES * this._walkingDirectionRow;
                  }
                  if(this._walkingDirectionColumn != 0)
                  {
                     this.playerMech.x += this.SQUARE_SIZE / this.WALKING_FRAMES * this._walkingDirectionColumn;
                  }
                  ++this._walkingFrameCounter;
               }
            }
         }
      }
      
      private function changeExistingWalkingPath(param1:uint, param2:uint) : void
      {
         var _loc4_:Object = null;
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:Number = NaN;
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         var _loc3_:Boolean = false;
         if(this._walkingPathSlot < this._walkingPath.length)
         {
            _loc4_ = this._walkingPath[this._walkingPath.length - 1];
            if(param1 != _loc4_.row || param2 != _loc4_.column)
            {
               _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc6_ = (param1 - 1) * _loc5_.mission_columns + param2;
               _loc7_ = this.getPathToPosition(_loc6_);
               if(_loc7_.length > 1)
               {
                  if(this._walkingPath[this._walkingPathSlot + 1] != null)
                  {
                     this._walkingPath.splice(this._walkingPathSlot + 1,this._walkingPath.length - 1 - (this._walkingPathSlot + 1) + 1);
                  }
                  _loc8_ = 1;
                  while(_loc8_ < _loc7_.length)
                  {
                     this._walkingPath.push(_loc7_[_loc8_]);
                     _loc8_++;
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
            this.playerMech.parent.removeChild(this.playerMech);
            this.playerMech = null;
         }
      }
      
      private function destroyPlayerHandler() : void
      {
         if(this._destroyingPlayerActive)
         {
            if(screensM.isScreenOpened("screenLevelUpEntry") == false && screensM.isScreenOpened("screenLevelUp") == false)
            {
               ++this._destroyingPlayerFrameCounter;
               if(this._destroyingPlayerFrameCounter == 20)
               {
                  TsLogger.log("_destroyingPlayerFrameCounter:" + this._destroyingPlayerFrameCounter);
                  this.createExplosion(this.playerMech.x,this.playerMech.y);
                  this.playerMech.visible = false;
               }
               else if(this._destroyingPlayerFrameCounter >= 40 && this._playerLostConfirmed)
               {
                  TsLogger.log("_playerLostConfirmed:" + this._playerLostConfirmed);
                  screensM.screenConfirmation.displayQuestionOrNotification("missionRevive");
                  this._destroyingPlayerActive = false;
               }
            }
         }
      }
      
      private function playerEntryHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this._playerNeedsToReviveBlock == false)
         {
            if(this._playerEntryHandler)
            {
               ++this._playerEntryFrameCounter;
               if(this._playerEntryBlowGate)
               {
                  if(this._playerEntryFrameCounter == 1)
                  {
                     this.playerMech.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_UP);
                     this.playerMech.activateFireAnimation();
                  }
                  if(this._playerEntryFrameCounter >= 15)
                  {
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
                        effectsM.createSparksMC("screenMissionBaseMap","spark",_loc1_,_loc2_,1,8,40,"up","orange",true);
                        soundM.createSound("fireMachineGun2",this.VOLUME_RATIO);
                     }
                     if(this._playerEntryFrameCounter == 35)
                     {
                        this.playerMech.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_UP);
                        this._playerEntryBlowGate = false;
                        this._playerEntryFrameCounter = 0;
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
               }
               else
               {
                  if(this._playerEntryFrameCounter == 1)
                  {
                     this.playerMech.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_UP);
                  }
                  if(this._playerEntryFrameCounter % 12 == 0)
                  {
                     soundM.createSound("footStep",this.VOLUME_RATIO);
                  }
                  if(this._playerEntryFrameCounter < this.WALKING_FRAMES * 2)
                  {
                     this.playerMech.y -= this.SQUARE_SIZE / this.WALKING_FRAMES;
                  }
                  else
                  {
                     _loc3_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                     _loc4_ = _loc3_.mission_playerPosition;
                     _loc5_ = Math.floor((_loc4_ - 1) / _loc3_.mission_columns) + 1;
                     _loc6_ = _loc4_ - _loc3_.mission_columns * (_loc5_ - 1);
                     this.playerMech.x = (_loc6_ - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
                     this.playerMech.y = (_loc5_ - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
                     this.playerMech.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_UP);
                     this._playerEntryHandler = false;
                  }
               }
            }
         }
      }
      
      private function createBossMech(param1:Number, param2:Number) : void
      {
         this.removeBossMech();
         this.bossMech = new BMMapMech();
         this.bossMech.initialize();
         this.bossMech.colorMech(9,9);
         this.bossMech.x = param1;
         this.bossMech.y = param2 - 3;
         this.bossMech.scaleX = 1.185;
         this.bossMech.scaleY = 1.185;
         this.mcMapHolder.addChild(this.bossMech);
         this.bossMech.setStatusAndDirection(BMMapMech.STATUS_STOMP,BMMapMech.DIRECTION_DOWN,this.bossStompEnded);
         var _loc3_:Point = new Point(this.bossMech.x + 20,this.bossMech.y - 90);
         var _loc4_:Point = this.mcMapHolder.localToGlobal(_loc3_);
         this._chatBubbleXPos = localToGlobal(_loc4_).x;
         this._chatBubbleYPos = localToGlobal(_loc4_).y;
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
         soundM.createSound("stomp1",1);
         this._bossStompAnimationActive = false;
         effectsM.createStompFire(this.mcMapEffectsHolder,"stompFire1",this.bossMech.x,this.bossMech.y + 25,60,6,1,false);
         effectsM.createStompFire(this.mcMapEffectsHolder,"stompFire1",this.bossMech.x,this.bossMech.y + 25,60,6,1,true);
         effectsM.createGeneralEffect(this.mcMapEffectsHolder,"stompLegHit1",false,0,0,this.bossMech.x,this.bossMech.y + 35,0,null,[]);
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._playerRow += 1;
         this._playerPosition = (this._playerRow - 1) * _loc1_.mission_columns + this._playerColumn;
         _loc1_.mission_playerPosition = this._playerPosition;
         var _loc2_:Number = _loc1_.mission_playerPosition;
         var _loc3_:Number = Math.floor((_loc2_ - 1) / _loc1_.mission_columns) + 1;
         var _loc4_:Number = _loc2_ - _loc1_.mission_columns * (_loc3_ - 1);
         this.playerMech.x = (_loc4_ - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
         this.playerMech.y = (_loc3_ - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
         var _loc5_:BMMapObject = this._mapObjects[this._bossMapObjectName];
         _loc5_.mcGrp.visible = true;
         this.removeBossMech();
      }
      
      private function getPathToPosition(param1:Number) : Array
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Array = null;
         var _loc9_:BMPlayerProfile = null;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:Object = null;
         var _loc13_:Boolean = false;
         var _loc14_:uint = 0;
         var _loc15_:Object = null;
         var _loc16_:Array = null;
         var _loc17_:Number = NaN;
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
         var _loc2_:Array = this.getPositionRowAndColumn(param1);
         var _loc3_:uint = uint(_loc2_[0]);
         var _loc4_:uint = uint(_loc2_[1]);
         var _loc5_:Array = new Array();
         this._walkingFinalInteractionRow = -1;
         this._walkingFinalInteractionColumn = -1;
         if(_loc3_ != this._playerRow || _loc4_ != this._playerColumn)
         {
            _loc8_ = new Array();
            _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc6_ = 1;
            while(_loc6_ <= _loc9_.mission_rows)
            {
               _loc8_[_loc6_] = new Array();
               _loc7_ = 1;
               while(_loc7_ <= _loc9_.mission_columns)
               {
                  _loc8_[_loc6_][_loc7_] = true;
                  if(_loc6_ == this._playerRow && _loc7_ == this._playerColumn)
                  {
                     _loc8_[_loc6_][_loc7_] = false;
                  }
                  else if(this._map[_loc6_][_loc7_] != "")
                  {
                     _loc8_[_loc6_][_loc7_] = false;
                  }
                  _loc7_++;
               }
               _loc6_++;
            }
            _loc10_ = [{
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
            _loc11_ = new Array();
            _loc12_ = {
               "extendedThisRun":false,
               "path":[{
                  "row":this._playerRow,
                  "column":this._playerColumn
               }]
            };
            _loc11_.push(_loc12_);
            _loc13_ = false;
            _loc14_ = 0;
            _loc17_ = -1;
            while(_loc13_ == false)
            {
               _loc18_ = false;
               _loc19_ = new Array();
               _loc20_ = _loc11_.length;
               _loc21_ = 0;
               while(_loc21_ < _loc20_)
               {
                  _loc14_++;
                  _loc15_ = _loc11_[_loc21_];
                  _loc15_.extendedThisRun = false;
                  _loc16_ = _loc15_.path;
                  _loc22_ = uint(_loc16_[_loc16_.length - 1].row);
                  _loc23_ = uint(_loc16_[_loc16_.length - 1].column);
                  _loc24_ = 0;
                  while(_loc24_ < _loc10_.length)
                  {
                     if(_loc17_ == -1)
                     {
                        _loc25_ = _loc10_[_loc24_];
                        _loc26_ = _loc22_ + _loc25_.row;
                        _loc27_ = _loc23_ + _loc25_.column;
                        if(_loc8_[_loc26_] != null)
                        {
                           if(_loc8_[_loc26_][_loc27_] != null)
                           {
                              if(_loc8_[_loc26_][_loc27_])
                              {
                                 if(_loc15_.extendedThisRun == false)
                                 {
                                    _loc16_.push({
                                       "row":_loc26_,
                                       "column":_loc27_
                                    });
                                    if(_loc3_ == _loc26_ && _loc4_ == _loc27_)
                                    {
                                       _loc17_ = _loc21_;
                                       _loc21_ = _loc20_;
                                       _loc24_ = _loc10_.length;
                                    }
                                    else
                                    {
                                       _loc15_.extendedThisRun = true;
                                       _loc18_ = true;
                                    }
                                 }
                                 else
                                 {
                                    _loc12_ = {
                                       "completed":false,
                                       "extendedThisRun":true,
                                       "path":[]
                                    };
                                    _loc28_ = 0;
                                    while(_loc28_ < _loc16_.length - 1)
                                    {
                                       _loc12_.path.push({
                                          "row":_loc16_[_loc28_].row,
                                          "column":_loc16_[_loc28_].column
                                       });
                                       _loc28_++;
                                    }
                                    _loc12_.path.push({
                                       "row":_loc26_,
                                       "column":_loc27_
                                    });
                                    if(_loc3_ == _loc26_ && _loc4_ == _loc27_)
                                    {
                                       _loc17_ = _loc11_.length;
                                       _loc21_ = _loc20_;
                                       _loc24_ = _loc10_.length;
                                    }
                                    else
                                    {
                                       _loc18_ = true;
                                    }
                                    _loc11_.push(_loc12_);
                                 }
                                 _loc8_[_loc26_][_loc27_] = false;
                              }
                              else if(_loc3_ == _loc26_ && _loc4_ == _loc27_)
                              {
                                 if(_loc15_.extendedThisRun)
                                 {
                                    _loc16_.splice(_loc16_.length - 1,1);
                                 }
                                 _loc17_ = _loc21_;
                                 _loc21_ = _loc20_;
                                 _loc24_ = _loc10_.length;
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
                  _loc13_ = true;
               }
            }
            if(_loc17_ > -1)
            {
               _loc5_ = _loc11_[_loc17_].path;
               _loc29_ = "";
               _loc30_ = 0;
               while(_loc30_ < _loc11_[_loc17_].path.length)
               {
                  _loc29_ = _loc29_ + _loc11_[_loc17_].path[_loc30_].row + ":" + _loc11_[_loc17_].path[_loc30_].column + " ";
                  _loc30_++;
               }
            }
         }
         return _loc5_;
      }
      
      private function checkIfMissionIsComplete() : void
      {
         var _loc6_:uint = 0;
         var _loc7_:Object = null;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc5_:uint = 1;
         while(_loc5_ <= _loc4_.mission_rows)
         {
            _loc6_ = 1;
            for(; _loc6_ <= _loc4_.mission_columns; _loc6_++)
            {
               if(this._map[_loc5_][_loc6_] == null)
               {
                  continue;
               }
               if(this._map[_loc5_][_loc6_] == "")
               {
                  continue;
               }
               _loc7_ = dataM.missionMapObjectDB[this._map[_loc5_][_loc6_]];
               switch(_loc7_.type)
               {
                  case "enemy":
                     _loc1_++;
                     break;
                  case "loot":
                     _loc2_++;
               }
            }
            _loc5_++;
         }
         if(_loc1_ == 0 && _loc2_ == 0)
         {
            this.btnAbort.disableMe();
            soundM.createSound("missionComplete",1);
            this._missionCompleted = true;
            this._missionCompletedFrameCounter = 0;
            this._missionCompletedStatus = "wait1";
            this._missionCompletedGotRewardsData = false;
         }
         else if(_loc4_.abortCurrentMission)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            _loc4_.abortCurrentMission = false;
            this._abortMissionDueToCheating_stopOnEnterFrame = true;
         }
      }
      
      public function missionCompletedSuccess(param1:Array) : void
      {
         var _loc3_:BMWorldMapLocationData = null;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc2_.currentMissionSlot > 0)
         {
            _loc3_ = dataM.missionsDB[_loc2_.currentMissionSlot];
            if(_loc3_.type == BMWorldMapLocationData.TYPE_MISSION)
            {
               dataM.missionWorldMap_missionCompletedSlot = _loc2_.currentMissionSlot;
            }
         }
         _loc2_.mapProgress[_loc2_.currentMissionSlot] = "v";
         _loc2_.currentMissionSlot = -1;
         screensM.removeScreen("screenConfirmation");
         screensM.addScreen("screenMissionCompleted");
         screensM.screenMissionCompleted.refreshScreen(param1);
         this._missionCompletedGotRewardsData = true;
         if(_loc2_.tutorialLevel == BMDataManager.TUTORIAL_LEVEL_MISSION1)
         {
            dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_MISSION1 + 1,"screenMissionBaseMap exitScreenSub");
         }
         else if(_loc2_.tutorialLevel == BMDataManager.TUTORIAL_LEVEL_MISSION2)
         {
            dataM.setTutorialLevel(BMDataManager.TUTORIAL_LEVEL_MISSION2 + 1,"screenMissionBaseMap exitScreenSub");
         }
         else
         {
            dataM.saveGuestData("missionBaseMap exitScreenSub");
         }
      }
      
      public function missionCompletedAnimationActive() : Boolean
      {
         return this._missionCompleted;
      }
      
      public function missionFailedClicked() : void
      {
         this.abortClicked();
      }
      
      private function createExplosion(param1:Number, param2:Number) : void
      {
         effectsM.createExplosion(3,param1,param2,35,50,25,2.5,5,3,this.mcMapEffectsHolder);
         effectsM.createSparksMC("screenMissionBaseMap","spark",param1,param2,3,4,40,"up","orange",true);
         effectsM.createSparksMC("screenMissionBaseMap","debrie",param1,param2,2,3,50,"up","",true);
         var _loc3_:Number = Math.ceil(Math.random() * 2);
         var _loc4_:String = "explosionSmall";
         if(_loc3_ == 1)
         {
            _loc4_ = "explosionMedium";
         }
         soundM.createSound(_loc4_,this.VOLUME_RATIO);
      }
      
      private function refreshFloor() : void
      {
         this.removeFloor();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.mcFloor = externalAssetsM.getAsset("general","Grp_missionFloor" + _loc1_.mission_themeID);
         this.mcFloorHolder.addChild(this.mcFloor);
      }
      
      private function removeFloor() : void
      {
         if(this.mcFloor != null)
         {
            this.mcFloor.parent.removeChild(this.mcFloor);
            this.mcFloor = null;
         }
      }
      
      private function createWalls() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = 0;
         var _loc3_:uint = 1;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 1;
         while(_loc6_ <= _loc1_.mission_columns)
         {
            if(this._map[_loc1_.mission_rows][_loc6_] == "XX")
            {
               _loc2_++;
               if(_loc3_ == _loc6_)
               {
                  _loc4_++;
                  _loc3_++;
               }
               else
               {
                  _loc5_++;
               }
            }
            _loc6_++;
         }
         var _loc7_:String = "mo_gate2";
         if(_loc2_ == _loc1_.mission_columns - 1)
         {
            _loc7_ = "mo_gate1";
         }
         this.mcGate = externalAssetsM.getAsset("general",_loc7_);
         this.mcGate.x = (-2 - _loc1_.mission_columns / 2 + _loc3_) * this.SQUARE_SIZE;
         this.mcGate.y = (-1 + _loc1_.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects" + (_loc1_.mission_rows + 1)].addChild(this.mcGate);
         this.mcGate.visible = true;
         var _loc8_:String = "mo_wallHorizontal" + _loc1_.mission_columns;
         if(_loc1_.mission_difficulty > 1)
         {
            _loc8_ = "mo_wall2Horizontal" + _loc1_.mission_columns;
         }
         this.mcWallHorizontalUp = externalAssetsM.getAsset("general",_loc8_);
         this.mcWallHorizontalUp.x = (-1 - _loc1_.mission_columns / 2) * this.SQUARE_SIZE;
         this.mcWallHorizontalUp.y = (-1 - _loc1_.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects0"].addChild(this.mcWallHorizontalUp);
         if(_loc1_.mission_difficulty > 1)
         {
            this.mcWallHorizontalUp.width = (2 + _loc1_.mission_columns) * this.SQUARE_SIZE;
         }
         _loc8_ = "mo_wallHorizontal" + (_loc4_ - 1);
         if(_loc1_.mission_difficulty > 1)
         {
            _loc8_ = "mo_wall2Horizontal" + (_loc4_ - 1);
         }
         var _loc9_:Number = (-1 - _loc1_.mission_columns / 2) * this.SQUARE_SIZE;
         this.mcWallHorizontalDownLeft = externalAssetsM.getAsset("general",_loc8_);
         this.mcWallHorizontalDownLeft.x = _loc9_;
         this.mcWallHorizontalDownLeft.y = (-1 + _loc1_.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects" + (_loc1_.mission_rows + 1)].addChild(this.mcWallHorizontalDownLeft);
         _loc8_ = "mo_wallHorizontal" + (_loc5_ - 1);
         if(_loc1_.mission_difficulty > 1)
         {
            _loc8_ = "mo_wall2Horizontal" + (_loc5_ - 1);
         }
         _loc9_ = (-_loc5_ + _loc1_.mission_columns / 2) * this.SQUARE_SIZE;
         this.mcWallHorizontalDownRight = externalAssetsM.getAsset("general",_loc8_);
         this.mcWallHorizontalDownRight.x = _loc9_;
         this.mcWallHorizontalDownRight.y = (-1 + _loc1_.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects" + (_loc1_.mission_rows + 1)].addChild(this.mcWallHorizontalDownRight);
         if(_loc1_.mission_difficulty > 1)
         {
            this.mcWallHorizontalDownRight.width = (1 + _loc5_) * this.SQUARE_SIZE;
            this.mcWallHorizontalDownLeft.width = (1 + _loc4_) * this.SQUARE_SIZE;
         }
         _loc8_ = "mo_wallVertical" + (_loc1_.mission_rows - 1);
         if(_loc1_.mission_difficulty > 1)
         {
            _loc8_ = "mo_wall2Vertical" + (_loc1_.mission_rows - 1);
         }
         this.mcWallVerticalLeft = externalAssetsM.getAsset("general",_loc8_);
         this.mcWallVerticalLeft.x = (-1 - _loc1_.mission_columns / 2) * this.SQUARE_SIZE;
         this.mcWallVerticalLeft.y = (-1 - _loc1_.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects0"].addChild(this.mcWallVerticalLeft);
         this.mcWallVerticalRight = externalAssetsM.getAsset("general",_loc8_);
         this.mcWallVerticalRight.x = _loc1_.mission_columns / 2 * this.SQUARE_SIZE;
         this.mcWallVerticalRight.y = (-1 - _loc1_.mission_rows / 2) * this.SQUARE_SIZE;
         this.mcMapHolder["holder_objects0"].addChild(this.mcWallVerticalRight);
         if(_loc1_.mission_difficulty > 1)
         {
            this.mcWallVerticalLeft.height = (1 + _loc1_.mission_rows) * this.SQUARE_SIZE;
            this.mcWallVerticalRight.height = (1 + _loc1_.mission_rows) * this.SQUARE_SIZE;
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
      
      private function refreshStats(param1:Boolean) : void
      {
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:uint = 1;
         var _loc4_:BMMechStructure = _loc2_.mechStructures[_loc3_];
         this._hpTotal = 0;
         this._energyOrigin = 0;
         this._energyRegenerationOrigin = 0;
         this._heatOrigin = 0;
         this._heatCoolingOrigin = 0;
         this._bulletsTotal = 0;
         this._rocketsTotal = 0;
         if(_loc4_.torso > 0)
         {
            _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc4_.torso);
            _loc6_ = dataM.itemsDB[_loc5_.itemID];
            this._hpTotal = _loc6_.HPBase;
            this._energyOrigin = _loc6_.energyBase;
            this._energyRegenerationOrigin = _loc6_.energyAddon;
            this._heatOrigin = _loc6_.heatBase;
            this._heatCoolingOrigin = _loc6_.heatAddon;
            this._bulletsTotal += _loc6_.bullets;
            this._rocketsTotal += _loc6_.rockets;
         }
         if(_loc4_.leg > 0)
         {
            _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc4_.leg);
            _loc6_ = dataM.itemsDB[_loc5_.itemID];
            this._hpTotal += _loc6_.HPBase;
         }
         var _loc7_:uint = 1;
         while(_loc7_ <= dataM.maxEquipment["module"])
         {
            if(_loc4_["module" + _loc7_] > 0)
            {
               _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc4_["module" + _loc7_]);
               _loc6_ = dataM.itemsDB[_loc5_.itemID];
               this._hpTotal += _loc6_.HPBase;
               this._energyOrigin += _loc6_.energyBase;
               this._energyRegenerationOrigin += _loc6_.energyAddon;
               this._heatOrigin += _loc6_.heatBase;
               this._heatCoolingOrigin += _loc6_.heatAddon;
               this._bulletsTotal += _loc6_.bullets;
               this._rocketsTotal += _loc6_.rockets;
            }
            _loc7_++;
         }
         var _loc8_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc9_:Boolean = false;
         if(param1)
         {
            _loc9_ = true;
         }
         this.mcMechStats.mcBarHP.setFill(_loc8_.mission_hp / this._hpTotal,_loc9_);
         this.mcMechStats.mcBarRockets.setFill(_loc8_.mission_rockets / this._rocketsTotal,_loc9_);
         this.mcMechStats.txtHP.text = dataM.getNumberWithComma(_loc8_.mission_hp) + " / " + dataM.getNumberWithComma(this._hpTotal);
         var _loc10_:String = "<FONT COLOR=\'#" + dataM.COLOR_GOOD + "\'>";
         if(_loc8_.mission_energy > this._energyOrigin)
         {
            this.mcMechStats.txtEnergy.htmlText = TextUtils.getTextFont() + _loc10_ + _loc8_.mission_energy + "</FONT>";
            this.mcMechStats.txtEnergyRegeneration.htmlText = TextUtils.getTextFont() + _loc10_ + _loc8_.mission_energyRegeneration + "</FONT>";
         }
         else
         {
            this.mcMechStats.txtEnergy.htmlText = TextUtils.getTextFont() + String(_loc8_.mission_energy);
            this.mcMechStats.txtEnergyRegeneration.htmlText = TextUtils.getTextFont() + String(_loc8_.mission_energyRegeneration);
         }
         if(_loc8_.mission_heat > this._heatOrigin)
         {
            this.mcMechStats.txtHeat.htmlText = TextUtils.getTextFont() + _loc10_ + _loc8_.mission_heat + "</FONT>";
            this.mcMechStats.txtHeatCooling.htmlText = TextUtils.getTextFont() + _loc10_ + _loc8_.mission_heatCooling + "</FONT>";
         }
         else
         {
            this.mcMechStats.txtHeat.htmlText = TextUtils.getTextFont() + String(_loc8_.mission_heat);
            this.mcMechStats.txtHeatCooling.htmlText = TextUtils.getTextFont() + String(_loc8_.mission_heatCooling);
         }
         this.mcMechStats.txtRockets.text = _loc8_.mission_rockets + " / " + this._rocketsTotal;
         if(this._bulletsTotal == 0)
         {
            this.mcMechStats.mcBullets.visible = false;
            this.mcMechStats.mcBarBullets.visible = false;
            this.mcMechStats.txtBullets.text = "";
         }
         else
         {
            this.mcMechStats.mcBullets.visible = true;
            this.mcMechStats.mcBarBullets.visible = true;
            this.mcMechStats.mcBarBullets.setFill(_loc8_.mission_bullets / this._bulletsTotal,_loc9_);
            this.mcMechStats.txtBullets.text = _loc8_.mission_bullets + " / " + this._bulletsTotal;
         }
         if(this._rocketsTotal == 0)
         {
            this.mcMechStats.mcRockets.visible = false;
            this.mcMechStats.mcBarRockets.visible = false;
            this.mcMechStats.txtRockets.text = "";
         }
         else
         {
            this.mcMechStats.mcRockets.visible = true;
            this.mcMechStats.mcBarRockets.visible = true;
            this.mcMechStats.mcBarRockets.setFill(_loc8_.mission_rockets / this._rocketsTotal,_loc9_);
            this.mcMechStats.txtRockets.text = _loc8_.mission_rockets + " / " + this._rocketsTotal;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionMap_stats",[this.mcMechStats.txtHP,this.mcMechStats.txtEnergy,this.mcMechStats.txtEnergyRegeneration,this.mcMechStats.txtHeat,this.mcMechStats.txtHeatCooling,this.mcMechStats.txtBullets,this.mcMechStats.txtRockets],"",this.mcMechStats);
         }
      }
      
      private function createMapPickups(param1:Number, param2:Number, param3:String, param4:String, param5:uint) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
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
      
      private function createSpecificMapPickup(param1:Number, param2:Number, param3:String, param4:String, param5:uint) : void
      {
         var _loc6_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc7_:String = param4;
         if(_loc7_ == "loot")
         {
            switch(_loc6_.mission_difficulty)
            {
               case 1:
                  _loc7_ += "A";
                  break;
               case 2:
                  _loc7_ += "B";
                  break;
               case 3:
                  _loc7_ += "C";
            }
         }
         _loc7_ = "icon_" + _loc7_;
         var _loc8_:Sprite = externalAssetsM.getAsset("general",_loc7_);
         var _loc9_:Number = (param2 - 0.5 - _loc6_.mission_columns / 2) * this.SQUARE_SIZE;
         var _loc10_:Number = (param1 - 0.5 - _loc6_.mission_rows / 2) * this.SQUARE_SIZE;
         _loc8_.x = _loc9_;
         _loc8_.y = _loc10_;
         var _loc11_:Object = new Object();
         _loc11_.framesCounter = 0;
         _loc11_.type = param3;
         _loc11_.name = param4;
         if(param5 > 0)
         {
            _loc11_.state = "wait";
            _loc11_.waitFrames = param5;
         }
         else
         {
            _loc11_.state = "goUp";
         }
         _loc11_.grp = _loc8_;
         this.mcMapHolder["holder_objects" + param1].addChild(_loc8_);
         this._mapPickups.push(_loc11_);
      }
      
      private function mapPickupsHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Object = null;
         if(this._mapPickups.length > 0)
         {
            _loc1_ = this._mapPickups.length - 1;
            while(_loc1_ >= 0)
            {
               _loc2_ = this._mapPickups[_loc1_];
               ++_loc2_.framesCounter;
               switch(_loc2_.state)
               {
                  case "wait":
                     if(_loc2_.framesCounter >= _loc2_.waitFrames)
                     {
                        _loc2_.framesCounter = 0;
                        _loc2_.state = "goUp";
                     }
                     break;
                  case "goUp":
                     _loc2_.grp.y -= 12 - _loc2_.framesCounter * 2;
                     if(_loc2_.framesCounter == 1)
                     {
                        soundM.createSound("kitUsed",1);
                     }
                     else if(_loc2_.framesCounter >= 5)
                     {
                        _loc2_.framesCounter = 0;
                        _loc2_.state = "grow";
                     }
                     break;
                  case "grow":
                     _loc2_.grp.scaleX += 0.1;
                     _loc2_.grp.scaleY += 0.1;
                     if(_loc2_.framesCounter >= 5)
                     {
                        _loc2_.framesCounter = 0;
                        _loc2_.state = "shrink";
                     }
                     break;
                  case "shrink":
                     _loc2_.grp.scaleX -= 0.2;
                     _loc2_.grp.scaleY -= 0.2;
                     if(_loc2_.framesCounter >= 7)
                     {
                        this.createSpecificInterfacePickup(_loc2_.type,_loc2_.name);
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
         var _loc2_:Object = null;
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
      
      private function createGoldReward() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:MovieClip = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:BMItem = null;
         if(this._createGoldReward > 0)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc1_.mission_gold += this._createGoldReward;
            _loc2_ = new mcFlyingGold();
            _loc2_.txtGold.text = dataM.getNumberWithComma(this._createGoldReward);
            _loc3_ = 0;
            _loc4_ = 0;
            if(dataM.runAsMobile)
            {
               _loc3_ = -_loc2_.txtGold.x;
               _loc4_ = -_loc2_.txtGold.y;
               _loc2_.txtGold.x = 0;
               _loc2_.txtGold.y = 0;
               _loc2_.mcGold.x += _loc3_;
               _loc2_.mcGold.y += _loc4_;
            }
            _loc5_ = new BMItem();
            _loc5_.initialize(0,_loc2_.width,_loc2_.height,_loc2_,0,0,false,null,dataM.runAsMobile);
            if(dataM.runAsMobile)
            {
               _loc5_.createAssetsBitmap([_loc2_.txtGold],[_loc2_.mcGold],_loc2_);
               _loc5_.assetsBitmap.x -= _loc3_;
               _loc5_.assetsBitmap.y -= _loc4_;
            }
            _loc5_.x = (this._createGoldColumn - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
            _loc5_.y = (this._createGoldRow - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
            this._flyingGold.push({
               "item":_loc5_,
               "frameCounter":0
            });
            this.refreshLootGold();
            this._createGoldReward = 0;
         }
      }
      
      private function createUpgrade() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:String = null;
         if(this._createUpgrade != "")
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc2_ = dataM.missionUpgradesDB[this._createUpgrade];
            this.createSpecificMapPickup(this._createUpgradeRow,this._createUpgradeColumn,"upgrade",_loc2_,25);
            _loc1_.mission_upgrades.push(dataM.missionUpgradesReverseDB[_loc2_]);
            this._createUpgrade = "";
         }
      }
      
      private function upgradesClicked(param1:MouseEvent) : void
      {
         this.upgradesClickedSub();
      }
      
      public function upgradesClickedSub() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:Object = null;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(this._missionCompleted == false)
         {
            if(this._saving)
            {
               this.activateSavingAnimation();
            }
            else if(this._lastRollOverredPickupSlot > -1)
            {
               _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc2_ = 1;
               _loc3_ = dataM.missionUpgradesReverseDB[this._interfacePickups[_loc2_][this._lastRollOverredPickupSlot].name];
               _loc4_ = true;
               if(this._firstUpgradeTutorial == false)
               {
                  switch(_loc3_)
                  {
                     case "HP":
                        if(_loc1_.mission_hp >= this._hpTotal)
                        {
                           _loc4_ = false;
                        }
                        break;
                     case "BL":
                        if(_loc1_.mission_bullets >= this._bulletsTotal)
                        {
                           _loc4_ = false;
                        }
                        break;
                     case "RK":
                        if(_loc1_.mission_rockets >= this._rocketsTotal)
                        {
                           _loc4_ = false;
                        }
                  }
               }
               if(_loc4_)
               {
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     remoteM.socketM.mission_useUpgrade(_loc3_);
                  }
                  _loc5_ = this._interfacePickups[_loc2_][this._lastRollOverredPickupSlot];
                  switch(_loc5_.name)
                  {
                     case "upgradeHP":
                        _loc1_.mission_hp += Math.ceil(this._hpTotal * dataM.missionUpgrade_hpRatio / 100);
                        if(_loc1_.mission_hp > this._hpTotal)
                        {
                           _loc1_.mission_hp = this._hpTotal;
                        }
                        break;
                     case "upgradeEnergy":
                        _loc1_.mission_energy += Math.ceil(this._energyOrigin * dataM.missionUpgrade_energyRatio / 100);
                        _loc1_.mission_energyRegeneration += Math.ceil(this._energyRegenerationOrigin * dataM.missionUpgrade_energyRatio / 100);
                        break;
                     case "upgradeHeat":
                        _loc1_.mission_heat += Math.ceil(this._heatOrigin * dataM.missionUpgrade_heatRatio / 100);
                        _loc1_.mission_heatCooling += Math.ceil(this._heatCoolingOrigin * dataM.missionUpgrade_heatRatio / 100);
                        break;
                     case "upgradeBullets":
                        _loc9_ = Math.ceil(this._bulletsTotal * dataM.missionUpgrade_ammoRatio / 100);
                        _loc9_ = Math.ceil(_loc9_ / 5) * 5;
                        _loc1_.mission_bullets += _loc9_;
                        if(_loc1_.mission_bullets > this._bulletsTotal)
                        {
                           _loc1_.mission_bullets = this._bulletsTotal;
                        }
                        break;
                     case "upgradeRockets":
                        _loc10_ = Math.ceil(this._rocketsTotal * dataM.missionUpgrade_ammoRatio / 100);
                        _loc10_ = Math.ceil(_loc10_ / 5) * 5;
                        _loc1_.mission_rockets += _loc10_;
                        if(_loc1_.mission_rockets > this._rocketsTotal)
                        {
                           _loc1_.mission_rockets = this._rocketsTotal;
                        }
                  }
                  this.refreshStats(true);
                  _loc5_.grp.parent.removeChild(_loc5_.grp);
                  _loc5_.grp = null;
                  this._interfacePickups[_loc2_][this._lastRollOverredPickupSlot] = null;
                  this._interfacePickups[_loc2_].splice(this._lastRollOverredPickupSlot,1);
                  _loc1_.mission_upgrades.splice(this._lastRollOverredPickupSlot,1);
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
                  if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                  {
                     this.activateSaving();
                  }
                  else
                  {
                     dataM.saveGuestData("missionBaseMap upgradesClickedSub");
                  }
                  this._interfacePickupsAnimationActive = true;
                  soundM.createSound("kitUsed",1);
                  if(this._firstUpgradeTutorial)
                  {
                     this._firstUpgradeTutorial = false;
                     this.mcTutorialArrow_usePickup.gotoAndStop("animOff");
                     this.refreshTutorial();
                  }
               }
            }
         }
         tooltip.hideToolTip();
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
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:MovieClip = null;
         var _loc14_:Object = null;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:String = param2;
         if(_loc4_ == "loot")
         {
            switch(_loc3_.mission_difficulty)
            {
               case 1:
                  _loc4_ += "A";
                  break;
               case 2:
                  _loc4_ += "B";
                  break;
               case 3:
                  _loc4_ += "C";
            }
         }
         _loc4_ = "icon_" + _loc4_;
         var _loc5_:Sprite = externalAssetsM.getAsset("general",_loc4_);
         switch(param1)
         {
            case "loot":
               _loc8_ = this.mcLoot;
               _loc6_ = Number(this.mcLoot.mcLootPointer.y);
               _loc7_ = 0;
               _loc3_.mission_loot.push(true);
               this.createLootBoxArray();
               break;
            case "upgrade":
               _loc8_ = this.mcUpgrades;
               _loc6_ = Number(this.mcUpgrades.mcUpgradesPointer.y);
               _loc7_ = 1;
         }
         var _loc9_:uint = uint(this._interfacePickups[_loc7_].length);
         var _loc10_:uint = this.INTERFACE_PICKUPS_X_JUMP;
         if(_loc9_ * _loc10_ > this.INTERFACE_PICKUPS_X_MAX)
         {
            _loc10_ = this.INTERFACE_PICKUPS_X_MAX / _loc9_;
         }
         var _loc11_:Number = this.mcLoot.mcLootPointer.x + _loc9_ * _loc10_ / 2;
         var _loc12_:uint = 0;
         while(_loc12_ < this._interfacePickups[_loc7_].length)
         {
            _loc14_ = this._interfacePickups[_loc7_][_loc12_];
            _loc14_.targetXPos = this.mcLoot.mcLootPointer.x - _loc9_ * _loc10_ / 2 + _loc10_ * _loc12_;
            _loc12_++;
         }
         _loc5_.x = _loc11_;
         _loc5_.y = _loc6_;
         _loc5_.scaleX = 0.1;
         _loc5_.scaleY = 0.1;
         var _loc13_:Object = new Object();
         _loc13_.framesCounter = 0;
         _loc13_.targetXPos = _loc11_;
         _loc13_.state = "grow";
         _loc13_.type = param1;
         _loc13_.name = param2;
         _loc13_.grp = _loc5_;
         _loc8_.addChild(_loc5_);
         this._interfacePickups[_loc7_].push(_loc13_);
         this._interfacePickupsAnimationActive = true;
      }
      
      private function interfacePickupsHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         if(this._interfacePickupsAnimationActive)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < this._interfacePickups.length)
            {
               _loc3_ = 0;
               while(_loc3_ < this._interfacePickups[_loc2_].length)
               {
                  _loc4_ = this._interfacePickups[_loc2_][_loc3_];
                  ++_loc4_.framesCounter;
                  switch(_loc4_.state)
                  {
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
         if(screensM.isScreenOpened("screenMissionCompleted"))
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
                           break;
                        case "upgradeBullets":
                           _loc12_ = "upgradeBullets";
                           _loc13_ = dataM.missionUpgrade_ammoRatio;
                           break;
                        case "upgradeRockets":
                           _loc12_ = "upgradeRockets";
                           _loc13_ = dataM.missionUpgrade_ammoRatio;
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
      
      public function refreshLootGold() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.mission_gold == 0)
         {
            this.mcLoot.mcGold.visible = false;
            this.mcLoot.txtGold.text = "";
         }
         else
         {
            if(_loc1_.mission_gold >= 1000)
            {
               this.mcLoot.txtGold.x = this._lootGoldTextOriginXPos;
               this.mcLoot.mcGold.x = this._lootGoldIconOriginXPos;
            }
            else
            {
               this.mcLoot.txtGold.x = this._lootGoldTextOriginXPos - 7;
               this.mcLoot.mcGold.x = this._lootGoldIconOriginXPos - 7;
            }
            this.mcLoot.mcGold.visible = true;
            this.mcLoot.txtGold.text = dataM.getNumberWithComma(_loc1_.mission_gold);
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("missionMap_lootGold",[this.mcLoot.txtLoot],"",this.mcLoot);
         }
      }
      
      public function removeLootPickup() : void
      {
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc1_:uint = 0;
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
      
      public function abortClicked() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
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
      }
      
      public function abortingMission() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc1_.mapProgress[_loc1_.currentMissionSlot] = "x";
         var _loc2_:Number = _loc1_.currentMissionSlot;
         _loc1_.currentMissionSlot = -1;
         this.btnAbort.disableMe();
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            remoteM.socketM.mission_abort(_loc2_);
         }
         else
         {
            this.missionAborted();
            dataM.saveGuestData("missionBaseMap abortingMission");
         }
      }
      
      public function missionAborted() : void
      {
         this.exitScreen();
      }
      
      public function exitScreen() : void
      {
         screensM.removeScreen("screenConfirmation");
         screensM.screenBlack.activateBlackScreen(this.exitScreenSub,true,true,null,0);
      }
      
      private function exitScreenSub() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc1_.clearMissionData();
         screensM.removeScreen("screenConfirmation");
         screensM.screenNewMenu.singlePlayerClicked(true);
         soundM.resetMusicTrackParameters();
         if(screensM.isScreenOpened("screenMissionCompleted"))
         {
            screensM.screenMissionCompleted.removeMe();
         }
         this.removeMe();
      }
      
      public function reviveSuccessful() : void
      {
         if(this._playerNeedsToReviveBlock)
         {
            this._playerNeedsToReviveBlock = false;
         }
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            --_loc1_.battleCredits;
            dataM.saveGuestData("reviveSuccessful");
         }
         effectsM.createTeleportReappear("teleportReappearAnim",this.playerMech.x,this.playerMech.y - 25,160,this.mcMapEffectsHolder);
         soundM.createSound("teleportAppear",this.VOLUME_RATIO);
         _loc1_.mission_hp = this._hpTotal;
         _loc1_.mission_bullets = this._bulletsTotal;
         _loc1_.mission_rockets = this._rocketsTotal;
         _loc1_.mission_energy = this._energyOrigin;
         _loc1_.mission_energyRegeneration = this._energyRegenerationOrigin;
         _loc1_.mission_heat = this._heatOrigin;
         _loc1_.mission_heatCooling = this._heatCoolingOrigin;
         this.playerMech.visible = true;
         screensM.screenTopBar.refreshBattleCredits();
         screensM.removeScreen("screenConfirmation");
         this.refreshStats(true);
      }
      
      public function notEnoughBattleCredits() : void
      {
         screensM.addScreen("screenBuyBattleCredits");
         screensM.screenBuyBattleCredits.refreshScreen();
      }
      
      public function buyBattleCreditsScreenClosed() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("missionRevive");
      }
      
      public function battleCreditsBought() : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            remoteM.socketM.mission_revive();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
         else
         {
            this.reviveSuccessful();
         }
      }
      
      private function activateSaving() : void
      {
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
         }
      }
      
      public function activateSavingAnimation() : void
      {
         this._savingHandler = true;
         this.btnAbort.disableMe();
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
         this.mapMarker.x = (param2 - 0.5) * this.SQUARE_SIZE - this._halfMapWidth;
         this.mapMarker.y = (param1 - 0.5) * this.SQUARE_SIZE - this._halfMapHeight;
         this.mapMarker.mcMarker.gotoAndStop(param3);
         this.mapMarker.gotoAndPlay("animOn");
      }
      
      private function interfaceMotionHandler() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(screensM.screenBlack.isActive() == false)
         {
            if(this._interfaceMotionFrameCounter <= 20)
            {
               ++this._interfaceMotionFrameCounter;
            }
            if(this._interfaceMotionFrameCounter > 10)
            {
               if(this.mcMechStats.x < this._mechStatsOriginXPos)
               {
                  this.mcMechStats.x += (this._mechStatsOriginXPos - this.mcMechStats.x) * 0.3;
                  if(Math.abs(this._mechStatsOriginXPos - this.mcMechStats.x) < 2)
                  {
                     this.mcMechStats.x = this._mechStatsOriginXPos;
                  }
               }
               _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc1_.mission_upgrades.length == 0)
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
               if(_loc1_.mission_loot.length > 0 || _loc1_.mission_gold > 0)
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
         }
      }
      
      private function flyingGoldHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:BMItem = null;
         if(this._flyingGold.length > 0)
         {
            _loc1_ = this._flyingGold.length - 1;
            while(_loc1_ >= 0)
            {
               ++this._flyingGold[_loc1_].frameCounter;
               if(this._flyingGold[_loc1_].frameCounter <= 4)
               {
                  if(this._flyingGold[_loc1_].frameCounter == 4)
                  {
                     this.mcMapEffectsHolder.addChild(this._flyingGold[_loc1_].item);
                  }
               }
               else
               {
                  _loc2_ = this._flyingGold[_loc1_].item;
                  if(this._flyingGold[_loc1_].frameCounter <= 24)
                  {
                     _loc2_.y -= (24 - this._flyingGold[_loc1_].frameCounter) / 3;
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
                     this._flyingGold[_loc1_] = null;
                     this._flyingGold.splice(_loc1_,1);
                  }
               }
               _loc1_--;
            }
         }
      }
      
      private function removeAllFlyingGold() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMItem = null;
         if(this._flyingGold.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._flyingGold.length)
            {
               if(this._flyingGold[_loc1_] != null)
               {
                  _loc2_ = this._flyingGold[_loc1_].item;
                  _loc2_.removeMe();
                  _loc2_ = null;
                  this._flyingGold[_loc1_] = null;
               }
               _loc1_++;
            }
         }
         this._flyingGold = new Array();
      }
      
      private function missionCompletedHandler() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:BMWorldMapLocationData = null;
         var _loc5_:Boolean = false;
         var _loc6_:BMWorldMapLocationData = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:BMPlayerData = null;
         var _loc10_:uint = 0;
         var _loc11_:Number = NaN;
         var _loc12_:uint = 0;
         var _loc13_:BMBoostData = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:uint = 0;
         var _loc17_:Array = null;
         var _loc18_:uint = 0;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         if(this._missionCompleted)
         {
            if(screensM.isScreenOpened("screenLevelUpEntry") == false && screensM.isScreenOpened("screenLevelUp") == false)
            {
               ++this._missionCompletedFrameCounter;
               switch(this._missionCompletedStatus)
               {
                  case "wait1":
                     if(this._missionCompletedFrameCounter >= 50)
                     {
                        this._missionCompletedStatus = "in";
                        this.mcCompleted1.visible = true;
                        this.mcCompleted2.visible = true;
                     }
                     break;
                  case "in":
                     this.mcCompleted1.y += (this._missionCompleted1TragetYPos - this.mcCompleted1.y) * 0.3;
                     this.mcCompleted2.y -= (this.mcCompleted2.y - this._missionCompleted2TragetYPos) * 0.3;
                     if(Math.abs(this._missionCompleted1TragetYPos - this.mcCompleted1.y) < 2)
                     {
                        this.mcCompleted1.y = this._missionCompleted1TragetYPos;
                        this.mcCompleted2.y = this._missionCompleted2TragetYPos;
                        this._missionCompletedStatus = "wait2";
                        this._missionCompletedFrameCounter = 0;
                     }
                     break;
                  case "out":
                     this.mcCompleted1.y += this._missionCompletedFrameCounter * 2;
                     this.mcCompleted2.y -= this._missionCompletedFrameCounter * 2;
                     if(this.mcCompleted1.y >= dataM.STAGE_HEIGHT + 200)
                     {
                        this.mcCompleted1.y = dataM.STAGE_HEIGHT + 200;
                        this.mcCompleted2.y = -200;
                        this.mcCompleted1.visible = false;
                        this.mcCompleted2.visible = false;
                        this._missionCompleted = false;
                     }
                     break;
                  case "wait2":
                     if(this._missionCompletedFrameCounter >= 40)
                     {
                        if(this._missionCompletedFrameCounter == 40)
                        {
                           _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                           if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
                           {
                              _loc3_ = 0;
                              _loc4_ = dataM.missionsDB[_loc1_.currentMissionSlot];
                              _loc5_ = true;
                              _loc2_ = 0;
                              while(_loc2_ < dataM.missionsDB.length)
                              {
                                 _loc6_ = dataM.missionsDB[_loc2_];
                                 if(_loc6_.type == BMWorldMapLocationData.TYPE_MISSION)
                                 {
                                    if(_loc6_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_REGULAR || _loc6_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS)
                                    {
                                       if(_loc6_.difficulty == _loc4_.difficulty)
                                       {
                                          if(_loc1_.mapProgress[_loc2_] != "v")
                                          {
                                             if(_loc1_.currentMissionSlot != _loc2_)
                                             {
                                                _loc5_ = false;
                                                _loc2_ = dataM.missionsDB.length;
                                             }
                                          }
                                       }
                                    }
                                 }
                                 _loc2_++;
                              }
                              if(_loc5_)
                              {
                                 _loc3_ = _loc4_.difficulty;
                              }
                              remoteM.socketM.mission_complete(_loc1_.currentMissionSlot,_loc3_);
                           }
                           else
                           {
                              _loc7_ = new Array();
                              _loc8_ = new Array();
                              if(_loc1_.currentMissionSlot == 0)
                              {
                                 _loc7_[0] = {
                                    "type":"gold",
                                    "amount":500
                                 };
                                 _loc7_[1] = {
                                    "type":"gold",
                                    "amount":500
                                 };
                              }
                              else
                              {
                                 _loc9_ = dataM.playersData[dataM.player1PlayerID];
                                 if(_loc1_.currentMissionSlot == 1)
                                 {
                                    _loc8_.push({
                                       "itemID":dataM.TUTORIAL_BOX_LEG_ID,
                                       "playerItemID":0,
                                       "equipped":0
                                    });
                                    _loc8_.push({
                                       "itemID":dataM.TUTORIAL_BOX_MODULE_ID,
                                       "playerItemID":0,
                                       "equipped":0
                                    });
                                    _loc8_.push({
                                       "itemID":dataM.TUTORIAL_BOX_DRONE_ID,
                                       "playerItemID":0,
                                       "equipped":0
                                    });
                                    _loc7_[0] = {
                                       "type":"gold",
                                       "amount":500
                                    };
                                    _loc7_[1] = {
                                       "type":"itemBox",
                                       "items":_loc8_
                                    };
                                 }
                                 else
                                 {
                                    _loc10_ = 0;
                                    _loc2_ = 0;
                                    while(_loc2_ < this._interfacePickups[_loc10_].length)
                                    {
                                       _loc11_ = Math.ceil(Math.random() * 100);
                                       if(_loc11_ <= 10)
                                       {
                                          _loc12_ = 9;
                                          if(_loc1_.mission_difficulty == 2)
                                          {
                                             _loc12_ = 11;
                                          }
                                          else if(_loc1_.mission_difficulty == 3)
                                          {
                                             _loc12_ = 12;
                                          }
                                          _loc13_ = dataM.boostsDB[_loc12_];
                                          _loc14_ = _loc1_.level;
                                          _loc15_ = _loc1_.level + _loc13_.levelDifference;
                                          _loc16_ = 2 + _loc1_.mission_difficulty;
                                          _loc17_ = dataM.getBonusItems(_loc14_,_loc1_.level,_loc15_,_loc13_.amount,_loc13_.ratioRare,_loc13_.ratioEpic,_loc13_.ratioLegendary);
                                          _loc8_ = new Array();
                                          _loc18_ = 0;
                                          while(_loc18_ < _loc17_.length)
                                          {
                                             _loc19_ = Number(_loc17_[_loc18_]);
                                             _loc8_.push({
                                                "itemID":_loc19_,
                                                "playerItemID":0,
                                                "equipped":0
                                             });
                                             _loc18_++;
                                          }
                                          _loc7_.push({
                                             "type":"itemBox",
                                             "items":_loc8_
                                          });
                                       }
                                       else
                                       {
                                          if(_loc1_.level >= dataM.GUEST_MAX_LEVEL)
                                          {
                                             _loc11_ = 100;
                                          }
                                          if(_loc11_ <= 55)
                                          {
                                             _loc20_ = 100;
                                             if(_loc1_.level < 25)
                                             {
                                                _loc20_ = 200;
                                             }
                                             if(_loc1_.mission_difficulty == 2)
                                             {
                                                _loc20_ *= 1.5;
                                             }
                                             else if(_loc1_.mission_difficulty == 3)
                                             {
                                                _loc20_ *= 2;
                                             }
                                             if(_loc1_.level >= dataM.GUEST_MAX_LEVEL)
                                             {
                                                _loc20_ = 0;
                                             }
                                             _loc7_.push({
                                                "type":"xp",
                                                "amount":_loc20_
                                             });
                                          }
                                          else
                                          {
                                             _loc21_ = 500;
                                             if(_loc11_ <= 70)
                                             {
                                                _loc21_ = 1000;
                                             }
                                             if(_loc1_.mission_difficulty == 2)
                                             {
                                                _loc21_ *= 1.5;
                                             }
                                             else if(_loc1_.mission_difficulty == 3)
                                             {
                                                _loc21_ *= 2;
                                             }
                                             if(_loc1_.gold >= dataM.GUEST_MAX_GOLD)
                                             {
                                                _loc21_ = 0;
                                             }
                                             _loc7_.push({
                                                "type":"gold",
                                                "amount":_loc21_
                                             });
                                          }
                                       }
                                       _loc2_++;
                                    }
                                 }
                              }
                              ++_loc1_.missionsCompleted;
                              this.missionCompletedSuccess(_loc7_);
                           }
                        }
                        if(this._missionCompletedGotRewardsData)
                        {
                           this._missionCompletedStatus = "out";
                           this._missionCompletedFrameCounter = 0;
                           screensM.removeScreen("screenConfirmation");
                        }
                        if(this._missionCompletedFrameCounter == 70)
                        {
                           screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
                        }
                     }
               }
            }
         }
      }
      
      private function createLootBoxArray() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this._lootBoxesArray = new Array();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = 1;
         while(_loc2_ <= _loc1_.mission_rows)
         {
            if(this._map[_loc2_] != null)
            {
               _loc3_ = 1;
               while(_loc3_ <= _loc1_.mission_columns)
               {
                  if(this._map[_loc2_][_loc3_] != null)
                  {
                     if(this._map[_loc2_][_loc3_] != "")
                     {
                        _loc4_ = dataM.missionMapObjectDB[this._map[_loc2_][_loc3_]];
                        _loc5_ = (_loc3_ - 0.5 - _loc1_.mission_columns / 2) * this.SQUARE_SIZE;
                        _loc6_ = (_loc2_ - 0.5 - _loc1_.mission_rows / 2) * this.SQUARE_SIZE;
                        if(_loc4_.type == "loot")
                        {
                           this._lootBoxesArray.push({
                              "xPos":_loc5_,
                              "yPos":_loc6_
                           });
                        }
                     }
                  }
                  _loc3_++;
               }
            }
            _loc2_++;
         }
      }
      
      private function lootBoxSparksHandler() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Object = null;
         var _loc5_:Sprite = null;
         var _loc6_:Sprite = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc2_ = 0;
         while(_loc2_ < this._lootBoxesArray.length)
         {
            _loc3_ = Math.ceil(Math.random() * 17);
            if(_loc3_ == 1)
            {
               _loc4_ = this._lootBoxesArray[_loc2_];
               _loc5_ = externalAssetsM.getAsset("general","Grp_itemBoxSpark");
               _loc5_.x = _loc4_.xPos + Math.random() * 30 - 15;
               _loc5_.y = _loc4_.yPos + Math.random() * 30 - 15;
               this.mcMapEffectsHolder.addChild(_loc5_);
               this._lootBoxSparks.push(_loc5_);
            }
            _loc2_++;
         }
         _loc2_ = this._lootBoxSparks.length - 1;
         while(_loc2_ >= 0)
         {
            _loc6_ = this._lootBoxSparks[_loc2_];
            if(_loc6_.scaleX > 0.1)
            {
               _loc6_.scaleX -= 0.1;
               _loc6_.scaleY -= 0.1;
            }
            else
            {
               this._lootBoxSparks[_loc2_].parent.removeChild(this._lootBoxSparks[_loc2_]);
               this._lootBoxSparks[_loc2_] = null;
               this._lootBoxSparks.splice(_loc2_,1);
            }
            _loc2_--;
         }
      }
      
      private function createAvailableUpgrades() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:BMPlayerData = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            this._availableUpgrades = new Array();
            this._availableUpgrades.push("HP");
            this._availableUpgrades.push("EN");
            this._availableUpgrades.push("HT");
            _loc1_ = false;
            _loc2_ = false;
            _loc3_ = dataM.playersData[dataM.player1PlayerID];
            _loc4_ = 1;
            _loc5_ = 0;
            for(; _loc5_ < _loc3_.items.length; _loc5_++)
            {
               _loc6_ = _loc3_.items[_loc5_];
               if(_loc6_.equipped != _loc4_)
               {
                  continue;
               }
               _loc7_ = dataM.itemsDB[_loc6_.itemID];
               switch(_loc7_.type)
               {
                  case "sideWeapon":
                  case "topWeapon":
                  case "drone":
                     if(_loc1_ == false)
                     {
                        if(_loc7_.bullets > 0)
                        {
                           _loc1_ = true;
                           this._availableUpgrades.push("BL");
                        }
                     }
                     if(_loc2_ == false)
                     {
                        if(_loc7_.rockets > 0)
                        {
                           _loc2_ = true;
                           this._availableUpgrades.push("RK");
                        }
                     }
                     if(_loc1_ && _loc2_)
                     {
                        _loc5_ = _loc3_.items.length;
                     }
               }
            }
         }
      }
      
      private function setMapScale() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc2_ = 0.85;
         _loc3_ = _loc1_.mission_rows;
         if(_loc1_.mission_columns > _loc1_.mission_rows)
         {
            _loc3_ = _loc1_.mission_columns;
         }
         switch(_loc3_)
         {
            case 3:
               _loc2_ = 1.5;
               break;
            case 4:
               _loc2_ = 1.25;
               break;
            case 5:
               _loc2_ = 1.05;
               break;
            case 6:
               _loc2_ = 0.85;
               break;
            case 7:
               _loc2_ = 0.78;
               break;
            case 8:
               _loc2_ = 0.74;
               break;
            case 9:
               _loc2_ = 0.7;
         }
         this.mcMapHolder.scaleX = _loc2_;
         this.mcMapHolder.scaleY = _loc2_;
         this.mcMapEffectsHolder.scaleX = _loc2_;
         this.mcMapEffectsHolder.scaleY = _loc2_;
      }
      
      private function getPositionRowAndColumn(param1:uint) : Array
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc3_ = Math.floor((param1 - 1) / _loc2_.mission_columns) + 1;
         _loc4_ = param1 - _loc2_.mission_columns * (_loc3_ - 1);
         return [_loc3_,_loc4_];
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
      
      public function removeMe() : void
      {
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
         this.removeAllFlyingGold();
         this.mcTutorialArrow_usePickup.gotoAndStop("animOff");
         this._abortMissionDueToCheating_stopOnEnterFrame = false;
         this._abortMissionDueToCheating_functionTriggered = false;
         if(this.playerMech != null)
         {
            this.playerMech.removeMe();
            this.playerMech = null;
         }
         this.removeBossMech();
         screensM.removeScreen("screenMissionBaseMap");
      }
      
      override public function notifyClientDataReloaded() : *
      {
         if(!this._missionCompletedGotRewardsData)
         {
            this.cleanMap();
            this.refreshScreen(this._fromBattle,this._fromPackages);
         }
      }
      
      public function handleRefreshedMissionData() : void
      {
         screensM.removeScreen("screenConfirmation");
         this.refreshScreen(this._fromBattle,this._fromPackages);
      }
      
      private function reloadMissionData() : void
      {
         remoteM.socketM.mission_getData();
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
      }
   }
}

