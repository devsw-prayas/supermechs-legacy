package net.battleMechsMulti.screens
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMSpecialOffersManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMCountdownTimerText;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureI;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossData;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossDialogController;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapChapterTitleController;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol303")]
   public class BMScreenMissionWorldMap extends BMBaseScreen
   {
      
      public var mcMapHolder:MovieClip;
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcSizer_btnGoToHighestMission:Sprite;
      
      public var mcTutorialArrow_border:MovieClip;
      
      public var mcTutorialArrow_target:MovieClip;
      
      public var mcTutorialArrow_back:Sprite;
      
      public var btnGoToHighestMission:BMButton_pictureE;
      
      public var mcBottomInterface:MovieClip;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcKeyHard:Sprite;
      
      public var mcKeyInsane:Sprite;
      
      public var btnBack:BMButton_pictureI;
      
      public var mcBattleCredits:MovieClip;
      
      public var mcBossDialogMissionMarker:MovieClip;
      
      private var mcMissionRollOverMarker:MovieClip;
      
      public var mcMapContentHolder:MovieClip;
      
      private var mcMapTerrainHolder:MovieClip;
      
      private var mcMapObjectsHolder:MovieClip;
      
      private var mcMissionNumbersHolder:MovieClip;
      
      private var mcMapPathHolder:MovieClip;
      
      private var _firstRefresh:Boolean = true;
      
      private var _mapTiles:Array;
      
      private var _mapObjects:Array;
      
      private var _missionNumbers:Array;
      
      private var _mapBeingDragged:Boolean = false;
      
      private var _mapXSpeed:Number;
      
      private var _mapYSpeed:Number;
      
      private var _mapPaths:Object = new Object();
      
      private var _lastMouseXPos:Number = -1;
      
      private var _lastMouseYPos:Number = -1;
      
      private var _mapDragCoords:Array = new Array();
      
      private var _highestMissionAllowed:uint;
      
      private var _tutorialArrows:Boolean = false;
      
      private var _tutorialFramesCounter:Number;
      
      private var _itemBoxSparks:Array = new Array();
      
      private var _mouseDownXPos:Number;
      
      private var _mouseDownYPos:Number;
      
      private var _currentMouseOverMissionSlot:Number = -1;
      
      private var _bottomInterfaceOriginXPos:Number;
      
      private var _btnGoToHighestMissionOriginXPos:Number;
      
      private var _missionFlagAnimationHandler:Boolean = false;
      
      private var _missionFlagAnimationCounter:Number;
      
      private var _mapLocked:Boolean = false;
      
      private var _allHardInsaneMissionsCompleted:Boolean;
      
      private var _keyHardOriginXPos:Number;
      
      private var _keyHardOriginYPos:Number;
      
      private var _keyInsaneOriginXPos:Number;
      
      private var _keyInsaneOriginYPos:Number;
      
      private var _keyAnimationHandlerActive:Boolean;
      
      private var _keyAnimationFrameCounter:uint;
      
      private var _keyAnimationDifficulty:uint;
      
      private var _keyAnimationStatus:String;
      
      private var _keyAnimationTargetXPos:Number;
      
      private var _keyAnimationTargetYPos:Number;
      
      private var _clickedItemBoxSlot:uint;
      
      private var _mapOriginalHeight:Number;
      
      private var _mapObjectSlotsResizingToNormal:Array = new Array();
      
      private var _mapMaxXScroll:Number;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _lastVisibleChapter:Number = -1;
      
      private var _removeBoxDialogMarkerUsingAnimation:Boolean = false;
      
      private var chapterTitleController:BMWorldMapChapterTitleController;
      
      private var bossDialogController:BMWorldMapBossDialogController;
      
      private var MAP_WIDTH:uint;
      
      private var MAP_HEIGHT:uint;
      
      private const MAP_TILES_COLUMNS:uint = 7;
      
      private const MAP_TILES_ROWS:uint = 1;
      
      private const TILE_WIDTH:uint = 800;
      
      private const TILE_HEIGHT:uint = 480;
      
      public function BMScreenMissionWorldMap()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("missionWorldMap");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:uint = 0;
         var _loc3_:Function = null;
         var _loc4_:BMWorldMapLocationData = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenMissionWorldMap","btnBack","pictureI");
            _loc1_ = this.backClicked;
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,_loc1_,dataM.runAsMobile);
            this._mapTiles = new Array();
            _loc2_ = 0;
            while(_loc2_ < this.MAP_TILES_ROWS * this.MAP_TILES_COLUMNS)
            {
               this._mapTiles.push(null);
               _loc2_++;
            }
            this._mapObjects = new Array();
            this._missionNumbers = new Array();
            this.MAP_WIDTH = this.MAP_TILES_COLUMNS * this.TILE_WIDTH;
            this.MAP_HEIGHT = this.MAP_TILES_ROWS * this.TILE_HEIGHT;
            this.mcMapContentHolder = new MovieClip();
            this.mcMapTerrainHolder = new MovieClip();
            this.mcMapPathHolder = new MovieClip();
            this.mcMapObjectsHolder = new MovieClip();
            this.mcMissionNumbersHolder = new MovieClip();
            this.mcMapContentHolder.addChild(this.mcMapTerrainHolder);
            this.mcMapContentHolder.addChild(this.mcMapPathHolder);
            this.mcMapContentHolder.addChild(this.mcMapObjectsHolder);
            this.mcMapContentHolder.addChild(this.mcMissionNumbersHolder);
            this.mcMapHolder.addChild(this.mcMapContentHolder);
            this.mcTutorialArrow_border.mouseEnabled = false;
            this.mcTutorialArrow_border.mouseChildren = false;
            this.mcTutorialArrow_target.mouseEnabled = false;
            this.mcTutorialArrow_target.mouseChildren = false;
            this.mcTutorialArrow_back.mouseEnabled = false;
            this.mcTutorialArrow_back.mouseChildren = false;
            screensM.createButtonFromSizer("screenMissionWorldMap","btnGoToHighestMission","pictureE");
            _loc3_ = this.goToHighestMission;
            if(dataM.runAsMobile)
            {
               _loc3_ = null;
            }
            this.btnGoToHighestMission.initialize("","",new mcGoToHighestMission(),null,_loc3_,dataM.runAsMobile);
            this.btnGoToHighestMission.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.mcMissionRollOverMarker = new mcWorldMarkersAnim();
            this._keyHardOriginXPos = this.mcKeyHard.x;
            this._keyHardOriginYPos = this.mcKeyHard.y;
            this._keyInsaneOriginXPos = this.mcKeyInsane.x;
            this._keyInsaneOriginYPos = this.mcKeyInsane.y;
            if(!dataM.runAsMobile)
            {
               this.btnGoToHighestMission.buttonCore.addMouseOverListerner(this.goToHighestMissionMouseOver);
               this.btnGoToHighestMission.buttonCore.addMouseOutListerner(this.goToHighestMissionMouseOut);
               this.mcBottomInterface.mcTooltip_hard.addEventListener(MouseEvent.MOUSE_OVER,this.hardTooltipMouseOver);
               this.mcBottomInterface.mcTooltip_hard.addEventListener(MouseEvent.MOUSE_OUT,this.generalTooltipMouseOut);
               this.mcBottomInterface.mcTooltip_insane.addEventListener(MouseEvent.MOUSE_OVER,this.insaneTooltipMouseOver);
               this.mcBottomInterface.mcTooltip_insane.addEventListener(MouseEvent.MOUSE_OUT,this.generalTooltipMouseOut);
            }
            this._bottomInterfaceOriginXPos = this.mcBottomInterface.x;
            this._btnGoToHighestMissionOriginXPos = this.mcSizer_btnGoToHighestMission.x;
            this._mapOriginalHeight = this.mcMouseHitArea.height;
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow_back);
            this._firstRefresh = false;
         }
         this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.mapMouseDown);
         this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.mapMouseUp);
         this.mcMouseHitArea.addEventListener(MouseEvent.ROLL_OUT,this.mapMouseRollOut);
         this.unlockMap();
         this._mapBeingDragged = false;
         this.showBottomInterface();
         this.setAllHardInsaneMissionsCompleted();
         if(dataM.missionWorldMap_missionCompletedSlot > 0)
         {
            this._missionFlagAnimationHandler = true;
            this._missionFlagAnimationCounter = 0;
            this.lockMap();
         }
         else
         {
            this.checkForChallenge();
         }
         if(dataM.missionWorldMapInterfaceActive())
         {
            this.mcBottomInterface.visible = false;
            this.mcMouseHitArea.height = this._mapOriginalHeight - 112;
         }
         else
         {
            this.mcBottomInterface.visible = true;
            this.mcMouseHitArea.height = this._mapOriginalHeight;
         }
         this.resetAnimationKeys();
         this.setHighestMissionSlot();
         this.resetMapPositionToHighestAvailableMission();
         this.createMapTiles();
         this.refreshTilesVisibility();
         this.refreshMapObjects();
         this.chapterTitleController = new BMWorldMapChapterTitleController(this);
         this.bossDialogController = new BMWorldMapBossDialogController(this);
         if(dataM.runAsMobile)
         {
            _loc4_ = dataM.missionsDB[this._highestMissionAllowed];
            this.showMissionRollOverMarker(this._highestMissionAllowed,_loc4_.type,_loc4_.xPos,_loc4_.yPos,_loc4_.difficulty);
         }
         if(this._missionFlagAnimationHandler == false)
         {
            if(tutorialM.isTutorialActive())
            {
               this.activateTutorialArrows();
            }
         }
         this.mcSizer_btnGoToHighestMission.x = this._btnGoToHighestMissionOriginXPos;
         this.mcBottomInterface.x = this._bottomInterfaceOriginXPos;
         this.btnGoToHighestMission.x = this._btnGoToHighestMissionOriginXPos;
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL)
         {
            this.mcSizer_btnGoToHighestMission.x -= 148;
            this.mcBottomInterface.x -= 148;
            this.btnGoToHighestMission.x -= 148;
         }
         if(dataM.missionWorldMapInterfaceActive())
         {
            screensM.addScreen("screenMissionWorldMapInterface");
            screensM.screenMissionWorldMapInterface.refreshScreen();
         }
         if(FeatureFlags.PLAYER_ENERGY)
         {
            this.refreshBattleCredits();
         }
         else
         {
            this.mcBattleCredits.visible = false;
         }
         this.btnBack.visible = true;
         if(tutorialM.isTutorialActive())
         {
            switch(tutorialM.getTutorialDestination())
            {
               case BMTutorialManager.TUTORIAL_DESTINATION_MISSION:
                  this.btnBack.visible = false;
            }
         }
         this.removeBossDialogMissionMarker();
         if(tutorialM.isTutorialActive() == false)
         {
            this.showBossDialog(this._highestMissionAllowed);
         }
         dataM.saveGuestData("missionWorldMap");
         if(tutorialM.isTutorialActive())
         {
            if(dataM.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_MISSION3)
            {
               tutorialM.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_COMPLETED);
               tutorialM.completeLocalTutorialCheck();
            }
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.mapMotionHandler();
            this.itemBoxSparksHandler();
            this.refreshTutorialArrowsFrameCoutner();
            this.missionFlagAnimationHandler();
            this.keyAnimationHandler();
            this.resizingMapObjectsHandler();
            if(dataM.runAsMobile == false)
            {
               this.missionRollOverMarkerHandler();
            }
            this._tutorialArrowController.runFrame();
            this.bossDialogController.onEnterFrameTrigger();
         }
      }
      
      private function showBossDialog(param1:uint, param2:Boolean = false) : void
      {
         var _loc7_:uint = 0;
         var _loc8_:BMWorldMapLocationData = null;
         var _loc9_:BMWorldMapBossData = null;
         var _loc10_:BMMechView = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:MovieClip = null;
         var _loc3_:Boolean = false;
         var _loc4_:BMWorldMapLocationData = dataM.missionsDB[param1];
         var _loc5_:uint = _loc4_.chapterID;
         var _loc6_:uint = 0;
         if(param1 < dataM.missionsDB.length - 1)
         {
            if(dataM.clientRunningLocally || param2 || dataM.missionWorldMap_lastBossDialogShown < _loc5_)
            {
               _loc3_ = true;
               _loc7_ = this._highestMissionAllowed;
               while(_loc7_ < dataM.missionsDB.length)
               {
                  _loc8_ = dataM.missionsDB[_loc7_];
                  if(_loc8_.type == BMWorldMapLocationData.TYPE_MISSION && _loc8_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS)
                  {
                     _loc6_ = _loc7_;
                     break;
                  }
                  _loc7_++;
               }
            }
         }
         if(dataM.clientRunningLocally)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            if(param2 == false)
            {
               dataM.missionWorldMap_lastBossDialogShown = _loc5_;
            }
            _loc9_ = dataM.missionBossesDB[_loc5_ - 1];
            _loc10_ = new BMMechView();
            _loc10_.initialize(dataM.LOCAL_OPPONENT_ID,"battle","itemID",0.6,false);
            _loc10_.buildMech(_loc9_.getBossMechStructure());
            _loc11_ = (7 - _loc5_) * 5;
            _loc12_ = _loc5_ * 10;
            this.bossDialogController.showDialog(_loc5_,_loc10_,dataM.mapBossDialogsDB[_loc5_ - 1],_loc11_,_loc12_,this.bossDialogEnded);
            _loc13_ = this._mapObjects[_loc6_];
            if(_loc13_ != null)
            {
               this.showBossDialogMissionMarker(_loc13_,_loc5_);
            }
         }
      }
      
      private function bossDialogEnded() : void
      {
         this.removeBossDialogMissionMarker(false);
      }
      
      private function mapMotionHandler() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc1_:Boolean = false;
         if(this._mapBeingDragged)
         {
            this._mapDragCoords.push({
               "xPos":mouseX,
               "yPos":mouseY
            });
            _loc3_ = this._mapDragCoords[this._mapDragCoords.length - 1].xPos - this._mapDragCoords[this._mapDragCoords.length - 2].xPos;
            this._mapDragCoords[this._mapDragCoords.length - 2].deltaX = _loc3_;
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = 0;
            if(this._mapDragCoords.length - 1 > 7)
            {
               _loc6_ = this._mapDragCoords.length - 1 - 7;
            }
            _loc7_ = _loc6_;
            while(_loc7_ < this._mapDragCoords.length - 1)
            {
               _loc4_++;
               _loc5_ += this._mapDragCoords[_loc7_].deltaX;
               _loc7_++;
            }
            this._mapXSpeed = _loc5_ / _loc4_;
            _loc1_ = true;
         }
         if(Math.abs(this._mapXSpeed) > 1)
         {
            _loc8_ = this.mcMapContentHolder.x + this._mapXSpeed;
            _loc8_ = this.setMapXPosInMapBorders(_loc8_);
            this.mcMapContentHolder.x = _loc8_;
            this._mapXSpeed *= 0.85;
            _loc1_ = true;
            this.refreshMapObjects();
            this.refreshTutorialArrowsPosition();
         }
         else
         {
            this._mapXSpeed = 0;
         }
         if(Math.abs(this.mcMapContentHolder.x) < 400)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = Math.ceil((Math.abs(this.mcMapContentHolder.x) - 400) / 800);
         }
         if(this._lastVisibleChapter != _loc2_)
         {
            this._lastVisibleChapter = _loc2_;
            this.chapterTitleController.showTitle(dataM.mapChapterNamesDB[this._lastVisibleChapter],2.5);
         }
         if(this.mcMapContentHolder.x < this._mapMaxXScroll - 1)
         {
            _loc9_ = (Math.abs(this.mcMapContentHolder.x) - Math.abs(this._mapMaxXScroll)) * 0.15;
            this.mcMapContentHolder.x += _loc9_;
            this.mcTutorialArrow_target.x += _loc9_;
            this.refreshMapObjects();
            _loc1_ = true;
         }
         if(_loc1_)
         {
            this.refreshTilesVisibility();
         }
      }
      
      private function setMapXPosInMapBorders(param1:Number) : Number
      {
         if(param1 > 0)
         {
            param1 = 0;
         }
         else if(param1 < -this.MAP_WIDTH + this.mcMouseHitArea.width)
         {
            param1 = -this.MAP_WIDTH + this.mcMouseHitArea.width;
         }
         return param1;
      }
      
      private function refreshTilesVisibility() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:Boolean = false;
         var _loc1_:uint = 0;
         while(_loc1_ < this._mapTiles.length)
         {
            _loc2_ = this._mapTiles[_loc1_];
            _loc3_ = false;
            if(_loc1_ <= this._mapTiles.length)
            {
               if(_loc2_.x + this.mcMapContentHolder.x <= this.mcMouseHitArea.width)
               {
                  if(_loc2_.x + this.mcMapContentHolder.x >= -this.TILE_WIDTH)
                  {
                     if(_loc2_.y + this.mcMapContentHolder.y < this.mcMouseHitArea.height)
                     {
                        if(_loc2_.y + this.mcMapContentHolder.y >= -this.TILE_HEIGHT)
                        {
                           _loc3_ = true;
                        }
                     }
                  }
               }
            }
            if(_loc3_)
            {
               this.addTile(_loc1_);
            }
            else
            {
               this.removeTile(_loc1_);
            }
            _loc1_++;
         }
      }
      
      private function setHighestMissionSlot() : void
      {
         var _loc3_:BMWorldMapLocationData = null;
         var _loc4_:Number = NaN;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Number = -1;
         _loc4_ = _loc1_.mapProgress.length - 1;
         while(_loc4_ >= 0)
         {
            if(_loc1_.mapProgress[_loc4_] == "v")
            {
               _loc3_ = dataM.missionsDB[_loc4_];
               if(_loc3_.type == BMWorldMapLocationData.TYPE_MISSION)
               {
                  _loc2_ = _loc4_;
                  _loc4_ = 0;
               }
            }
            _loc4_--;
         }
         this._highestMissionAllowed = 0;
         if(_loc2_ > -1)
         {
            if(_loc2_ == dataM.missionsDB.length - 1)
            {
               this._highestMissionAllowed = dataM.missionsDB.length - 1;
            }
            else
            {
               _loc4_ = _loc2_ + 1;
               while(_loc4_ < dataM.missionsDB.length)
               {
                  this._highestMissionAllowed = _loc4_;
                  _loc3_ = dataM.missionsDB[_loc4_];
                  if(_loc3_.type == BMWorldMapLocationData.TYPE_MISSION)
                  {
                     if(_loc3_.mainPath)
                     {
                        _loc4_ = dataM.missionsDB.length;
                     }
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      private function resetMapPositionToHighestAvailableMission() : void
      {
         var _loc2_:BMWorldMapLocationData = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this._missionFlagAnimationHandler)
         {
            _loc2_ = dataM.missionsDB[dataM.missionWorldMap_missionCompletedSlot];
         }
         else
         {
            _loc2_ = dataM.missionsDB[this._highestMissionAllowed];
         }
         var _loc3_:Number = -_loc2_.xPos + this.mcMouseHitArea.width / 2;
         _loc3_ = this.setMapXPosInMapBorders(_loc3_);
         this.mcMapContentHolder.x = _loc3_;
         _loc2_ = dataM.missionsDB[this._highestMissionAllowed];
         this._mapMaxXScroll = (_loc2_.chapterID - 1) * dataM.STAGE_WIDTH * -1 - 50;
      }
      
      private function createMapTiles() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:Sprite = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.MAP_TILES_ROWS)
         {
            _loc2_ = 0;
            while(_loc2_ < this.MAP_TILES_COLUMNS)
            {
               _loc3_ = _loc1_ * this.MAP_TILES_COLUMNS + _loc2_;
               if(this._mapTiles[_loc3_] == null)
               {
                  _loc4_ = "worldMapPart" + (_loc3_ + 1);
                  _loc5_ = externalAssetsM.getAsset("general",_loc4_);
                  _loc5_.x = _loc2_ * this.TILE_WIDTH - _loc2_;
                  _loc5_.y = _loc1_ * this.TILE_HEIGHT - _loc1_;
                  this._mapTiles[_loc3_] = _loc5_;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      private function refreshMapObjects() : void
      {
         var _loc8_:BMWorldMapLocationData = null;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:MovieClip = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:MovieClip = null;
         var _loc1_:Number = -this.mcMapContentHolder.x - 30;
         var _loc2_:Number = _loc1_ + this.mcMouseHitArea.width + 60;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:Number = -1;
         var _loc5_:Number = -1;
         var _loc6_:BMWorldMapLocationData = dataM.missionsDB[this._highestMissionAllowed];
         var _loc7_:uint = 0;
         while(_loc7_ < dataM.missionsDB.length)
         {
            _loc8_ = dataM.missionsDB[_loc7_];
            _loc9_ = false;
            _loc10_ = false;
            _loc11_ = false;
            if(_loc8_.type == BMWorldMapLocationData.TYPE_MISSION && _loc8_.mainPath)
            {
               _loc11_ = true;
               if(_loc6_.chapterID == _loc8_.chapterID)
               {
                  _loc10_ = true;
               }
            }
            if(_loc8_.xPos >= _loc1_ && _loc8_.xPos <= _loc2_)
            {
               _loc9_ = true;
            }
            if(_loc9_)
            {
               if(this._mapObjects[_loc7_] == null)
               {
                  switch(_loc8_.type)
                  {
                     case BMWorldMapLocationData.TYPE_MISSION:
                        if(_loc3_.mapProgress[_loc7_] == "v")
                        {
                           _loc14_ = "_completed";
                        }
                        else if(this._highestMissionAllowed >= _loc8_.locationID)
                        {
                           _loc14_ = "_available";
                        }
                        else
                        {
                           _loc14_ = "_locked";
                        }
                        _loc15_ = _loc8_.difficulty + "A";
                        if(_loc8_.difficulty == 1)
                        {
                           if(_loc8_.chapterID == 3)
                           {
                              _loc15_ = "1B";
                           }
                        }
                        if(_loc8_.bossDataSlot > -1)
                        {
                           if(_loc8_.chapterID == 7)
                           {
                              _loc15_ = "4B";
                           }
                           else
                           {
                              _loc15_ = "4A";
                           }
                        }
                        _loc13_ = "worldMapMissionRegular" + _loc15_ + _loc14_;
                        _loc12_ = externalAssetsM.getAsset("general",_loc13_);
                        break;
                     case BMWorldMapLocationData.TYPE_LOOT:
                        if(_loc3_.mapProgress[_loc7_] == "v")
                        {
                           _loc12_ = new MovieClip();
                        }
                        else
                        {
                           switch(_loc8_.subType)
                           {
                              case BMWorldMapLocationData.SUB_TYPE_LOOT_CUSTOM_ITEM_BOX:
                                 _loc12_ = new mcWorldItemBoxRed();
                                 break;
                              case BMWorldMapLocationData.SUB_TYPE_LOOT_ITEM_BOX:
                                 switch(_loc8_.itemBoxID)
                                 {
                                    case 5:
                                       _loc12_ = new mcWorldItemBoxSilver();
                                       break;
                                    case 6:
                                       _loc12_ = new mcWorldItemBoxGold();
                                       break;
                                    case 25:
                                       _loc12_ = new mcWorldItemBoxMix();
                                 }
                           }
                        }
                  }
                  _loc12_.x = _loc8_.xPos;
                  _loc12_.y = _loc8_.yPos;
                  this.mcMapObjectsHolder.addChild(_loc12_);
                  this._mapObjects[_loc7_] = _loc12_;
               }
               else if(this._mapObjects[_loc7_].parent == null)
               {
                  this.mcMapObjectsHolder.addChild(this._mapObjects[_loc7_]);
               }
            }
            else if(this._mapObjects[_loc7_] != null)
            {
               if(this._mapObjects[_loc7_].parent != null)
               {
                  this._mapObjects[_loc7_].parent.removeChild(this._mapObjects[_loc7_]);
               }
            }
            if(_loc10_)
            {
               if(this._missionNumbers[_loc7_] == null)
               {
                  _loc16_ = new mcWorldMissionNumber();
                  _loc16_.txtNumber.text = String(_loc8_.displayNumber);
                  _loc16_.x = _loc8_.xPos;
                  _loc16_.y = _loc8_.yPos - 45;
                  this.mcMissionNumbersHolder.addChild(_loc16_);
                  this._missionNumbers[_loc7_] = _loc16_;
                  if(dataM.runAsMobile)
                  {
                     --_loc16_.txtNumber.x;
                     screensM.createMultipleTextsBitmap("worldMap_missionNumber" + _loc7_,[_loc16_.txtNumber],"",_loc16_);
                  }
               }
               else if(this._missionNumbers[_loc7_].parent == null)
               {
                  this.mcMissionNumbersHolder.addChild(this._missionNumbers[_loc7_]);
               }
            }
            else if(this._missionNumbers[_loc7_] != null)
            {
               if(this._missionNumbers[_loc7_].parent != null)
               {
                  this._missionNumbers[_loc7_].parent.removeChild(this._missionNumbers[_loc7_]);
               }
            }
            _loc7_++;
         }
      }
      
      private function addTile(param1:uint) : void
      {
         if(this._mapTiles[param1].parent == null)
         {
            this.mcMapTerrainHolder.addChild(this._mapTiles[param1]);
         }
      }
      
      private function removeTile(param1:uint) : void
      {
         if(this._mapTiles[param1] != null)
         {
            if(this._mapTiles[param1].parent != null)
            {
               this.mcMapTerrainHolder.removeChild(this._mapTiles[param1]);
            }
         }
      }
      
      private function mapClicked() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:BMWorldMapLocationData = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:BMPlayerProfile = null;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:Number = NaN;
         if(this._mapLocked == false)
         {
            if(this.userNeedsToExitScreen() == false)
            {
               _loc1_ = Math.ceil(mouseX - this.mcMapContentHolder.x - this.mcMapHolder.x);
               _loc2_ = Math.ceil(mouseY - this.mcMapContentHolder.y - this.mcMapHolder.y);
               TsLogger.log("dataM.missionsDB.push({xPos:" + _loc1_ + ",yPos:" + _loc2_ + ",difficulty:1});");
               _loc3_ = -this.mcMapContentHolder.x;
               _loc4_ = _loc3_ + this.mcMouseHitArea.width;
               _loc5_ = -this.mcMapContentHolder.y;
               _loc6_ = _loc5_ + this.mcMouseHitArea.height;
               _loc7_ = 999;
               _loc8_ = -1;
               _loc10_ = 0;
               while(_loc10_ < dataM.missionsDB.length)
               {
                  _loc9_ = dataM.missionsDB[_loc10_];
                  if(_loc9_.xPos >= _loc3_ && _loc9_.xPos <= _loc4_)
                  {
                     if(_loc9_.yPos >= _loc5_ && _loc9_.yPos <= _loc6_)
                     {
                        _loc11_ = _loc1_ - _loc9_.xPos;
                        _loc12_ = _loc2_ - _loc9_.yPos;
                        _loc13_ = dataM.getVectorSize(_loc11_,_loc12_);
                        if(_loc7_ > _loc13_)
                        {
                           _loc7_ = _loc13_;
                           _loc8_ = _loc10_;
                        }
                     }
                  }
                  _loc10_++;
               }
               if(_loc7_ < 40)
               {
                  _loc14_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                  _loc15_ = false;
                  _loc9_ = dataM.missionsDB[_loc8_];
                  if(_loc8_ <= this._highestMissionAllowed)
                  {
                     if(_loc9_.type == BMWorldMapLocationData.TYPE_LOOT)
                     {
                        if(_loc14_.mapProgress[_loc8_] == null)
                        {
                           _loc15_ = true;
                        }
                        else if(_loc14_.mapProgress[_loc8_] == "x")
                        {
                           _loc15_ = true;
                        }
                     }
                     else if(tutorialM.isTutorialActive())
                     {
                        if(_loc14_.mapProgress[_loc8_] == null)
                        {
                           _loc15_ = true;
                        }
                        else if(_loc14_.mapProgress[_loc8_] == "x")
                        {
                           _loc15_ = true;
                        }
                     }
                     else
                     {
                        _loc15_ = true;
                     }
                  }
                  else if(_loc9_.type == BMWorldMapLocationData.TYPE_LOOT)
                  {
                     screensM.screenConfirmation.displayQuestionOrNotification("previousMissionsRequiredForItemBox");
                  }
                  if(dataM.clientRunningLocally)
                  {
                  }
                  if(_loc15_)
                  {
                     switch(_loc9_.type)
                     {
                        case BMWorldMapLocationData.TYPE_MISSION:
                           if(dataM.isMechReadyForBattle(false,dataM.campaignBattleType))
                           {
                              _loc17_ = true;
                              if(FeatureFlags.PLAYER_ENERGY)
                              {
                                 _loc18_ = dataM.battleCredits_missionCost_normal;
                                 if(_loc9_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS)
                                 {
                                    _loc18_ = dataM.battleCredits_missionCost_boss;
                                 }
                                 else if(_loc9_.difficulty == 2)
                                 {
                                    _loc18_ = dataM.battleCredits_missionCost_hard;
                                 }
                                 else if(_loc9_.difficulty == 3)
                                 {
                                    _loc18_ = dataM.battleCredits_missionCost_insane;
                                 }
                                 if(_loc18_ > dataM.myProfile.battleCredits)
                                 {
                                    _loc17_ = false;
                                 }
                              }
                              if(_loc17_)
                              {
                                 _loc14_.currentMissionSlot = _loc8_;
                                 this.enterMission();
                                 this.lockMapBeforeEnteringMission(_loc8_);
                              }
                              else
                              {
                                 screensM.screenConfirmation.displayQuestionOrNotification("notEnoughBattleCredits");
                              }
                              soundM.createSound("buttonClick",1);
                           }
                           else
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",-1,-1);
                           }
                           break;
                        case BMWorldMapLocationData.TYPE_LOOT:
                           _loc16_ = false;
                           if(_loc9_.subType == BMWorldMapLocationData.SUB_TYPE_LOOT_CUSTOM_ITEM_BOX)
                           {
                              if(_loc9_.difficulty == 3)
                              {
                                 if(this._allHardInsaneMissionsCompleted == false)
                                 {
                                    _loc16_ = true;
                                 }
                              }
                           }
                           if(_loc16_)
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("hardInsaneMissionsRequiredForItemBox");
                           }
                           else
                           {
                              this._clickedItemBoxSlot = _loc8_;
                              this.tryToOpenItemBox();
                           }
                           tooltip.hideToolTip();
                     }
                  }
                  else if(_loc9_.type == BMWorldMapLocationData.TYPE_MISSION)
                  {
                     if(_loc9_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS)
                     {
                        if(_loc8_ > this._highestMissionAllowed)
                        {
                           this.showBossDialog(_loc8_,true);
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function userNeedsToExitScreen() : Boolean
      {
         var _loc1_:Boolean = false;
         if(tutorialM.isTutorialActive())
         {
            if(tutorialM.getTutorialDestination() != BMTutorialManager.TUTORIAL_DESTINATION_MISSION)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public function tryToOpenItemBox() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:BMWorldMapLocationData = dataM.missionsDB[this._clickedItemBoxSlot];
         if(_loc1_.ladderWins < _loc2_.onlineWinsRequired)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("onlineWinsRequiredForItemBox",_loc2_.onlineWinsRequired,_loc2_.onlineWinsRequired - _loc1_.ladderWins);
         }
         else
         {
            _loc1_.mapProgress[this._clickedItemBoxSlot] = "v";
            if(this._mapObjects[this._clickedItemBoxSlot] != null)
            {
               if(this._mapObjects[this._clickedItemBoxSlot].parent != null)
               {
                  this._mapObjects[this._clickedItemBoxSlot].parent.removeChild(this._mapObjects[this._clickedItemBoxSlot]);
               }
               this._mapObjects[this._clickedItemBoxSlot] = new MovieClip();
            }
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            remoteM.socketM.mission_claimItemBox(this._clickedItemBoxSlot,_loc2_.itemBoxID);
         }
      }
      
      private function lockMapBeforeEnteringMission(param1:uint) : void
      {
         this.deactivateTutorialArrows();
         this.hideMissionRollOverMarker();
         this.lockMap();
      }
      
      public function enterMission() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:BMWorldMapLocationData = dataM.missionsDB[_loc1_.currentMissionSlot];
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL)
         {
            dataM.createMissionLocally(_loc1_.currentMissionSlot,_loc2_.difficulty,_loc2_.themeID);
         }
         else
         {
            remoteM.socketM.mission_create(_loc2_.difficulty,_loc2_.themeID,_loc1_.currentMissionSlot,"");
         }
         if(_loc1_.mapProgress[_loc1_.currentMissionSlot] == "v")
         {
            _loc1_.mapProgress[_loc1_.currentMissionSlot] = "r";
         }
         else
         {
            _loc1_.mapProgress[_loc1_.currentMissionSlot] = "c";
         }
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL)
         {
            this.newMissionCreated();
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         }
      }
      
      private function setAllHardInsaneMissionsCompleted() : void
      {
         var _loc3_:Object = null;
         this._allHardInsaneMissionsCompleted = true;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = 0;
         while(_loc2_ < dataM.missionsDB.length)
         {
            _loc3_ = dataM.missionsDB[_loc2_];
            if(_loc3_.type == BMWorldMapLocationData.TYPE_MISSION)
            {
               if(_loc3_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_REGULAR)
               {
                  if(_loc3_.difficulty > 1)
                  {
                     if(_loc1_.mapProgress[_loc2_] == null)
                     {
                        this._allHardInsaneMissionsCompleted = false;
                        _loc2_ = dataM.missionsDB.length;
                     }
                     else if(_loc1_.mapProgress[_loc2_] != "v")
                     {
                        this._allHardInsaneMissionsCompleted = false;
                        _loc2_ = dataM.missionsDB.length;
                     }
                  }
               }
            }
            _loc2_++;
         }
      }
      
      private function mapMouseDown(param1:MouseEvent) : void
      {
         this.mapMouseDownSub();
      }
      
      private function mapMouseDownSub() : void
      {
         if(this._mapLocked == false)
         {
            if(screensM.screenBlack.isActive() == false)
            {
               this._mapBeingDragged = true;
               this._mapDragCoords = new Array();
               this._mapDragCoords.push({
                  "xPos":mouseX,
                  "yPos":mouseY
               });
            }
         }
      }
      
      private function mapMouseUp(param1:MouseEvent) : void
      {
         this.mapMouseUpSub(true);
      }
      
      private function mapMouseRollOut(param1:MouseEvent) : void
      {
         this.mapMouseUpSub(false);
      }
      
      private function mapMouseUpSub(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this._mapLocked == false)
         {
            if(screensM.screenBlack.isActive() == false)
            {
               if(param1)
               {
                  _loc2_ = true;
                  if(this._mapDragCoords.length > 0)
                  {
                     _loc3_ = this._mapDragCoords[0].xPos - this._mapDragCoords[this._mapDragCoords.length - 1].xPos;
                     _loc4_ = this._mapDragCoords[0].yPos - this._mapDragCoords[this._mapDragCoords.length - 1].yPos;
                     _loc5_ = dataM.getVectorSize(_loc3_,_loc4_);
                     if(_loc5_ > 20)
                     {
                        _loc2_ = false;
                     }
                  }
                  if(_loc2_)
                  {
                     this.mapClicked();
                  }
               }
               this._mapBeingDragged = false;
            }
         }
      }
      
      private function activateTutorialArrows() : void
      {
         var _loc1_:Boolean = false;
         this._tutorialArrows = false;
         this._tutorialFramesCounter = 0;
         this.mcTutorialArrow_target.gotoAndStop("animOff");
         this.mcTutorialArrow_border.gotoAndStop("animOff");
         if(this.userNeedsToExitScreen())
         {
            this._tutorialArrowController.activateTutorialArrow(this,this.btnBack.x + this.btnBack.width,this.btnBack.y + this.btnBack.height / 2);
         }
         else if(this._highestMissionAllowed < dataM.missionsDB.length - 1)
         {
            if(screensM.isScreenOpened("screenWorldMapSelectBattle") == false)
            {
               this._tutorialArrows = true;
               _loc1_ = false;
               if(this._highestMissionAllowed < 3)
               {
                  _loc1_ = true;
               }
               this.refreshTutorialArrowsPosition();
               if(_loc1_ == false)
               {
                  this._tutorialFramesCounter = 120;
               }
            }
         }
      }
      
      private function refreshTutorialArrowsFrameCoutner() : void
      {
         if(this._tutorialArrows)
         {
            if(this._tutorialFramesCounter > 0)
            {
               --this._tutorialFramesCounter;
               if(this._tutorialFramesCounter <= 0)
               {
                  this._tutorialArrows = false;
                  this.mcTutorialArrow_target.gotoAndStop("animOff");
                  this.mcTutorialArrow_border.gotoAndStop("animOff");
               }
            }
         }
      }
      
      private function deactivateTutorialArrows() : void
      {
         this._tutorialArrows = false;
         this.mcTutorialArrow_target.gotoAndStop("animOff");
         this.mcTutorialArrow_border.gotoAndStop("animOff");
      }
      
      private function refreshTutorialArrowsPosition() : void
      {
         var _loc1_:BMWorldMapLocationData = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(this._tutorialArrows)
         {
            _loc1_ = dataM.missionsDB[this._highestMissionAllowed];
            _loc2_ = -_loc1_.xPos + this.mcMouseHitArea.width / 2;
            _loc3_ = -_loc1_.yPos + this.mcMouseHitArea.height / 2;
            _loc4_ = false;
            _loc5_ = -this.mcMapContentHolder.x;
            _loc6_ = _loc5_ + this.mcMouseHitArea.width;
            _loc7_ = -this.mcMapContentHolder.y;
            _loc8_ = _loc7_ + this.mcMouseHitArea.height;
            if(_loc1_.xPos >= _loc5_ && _loc1_.xPos <= _loc6_)
            {
               if(_loc1_.yPos >= _loc7_ && _loc1_.yPos <= _loc8_)
               {
                  _loc4_ = true;
               }
            }
            if(_loc4_)
            {
               if(this.mcTutorialArrow_target.currentLabel != "animOn")
               {
                  this.mcTutorialArrow_target.gotoAndStop("animOn");
               }
               if(this.mcTutorialArrow_border.currentLabel != "animOff")
               {
                  this.mcTutorialArrow_border.gotoAndStop("animOff");
               }
               this.mcTutorialArrow_target.x = this.mcMapHolder.x + _loc1_.xPos + this.mcMapContentHolder.x;
               this.mcTutorialArrow_target.y = this.mcMapHolder.y + _loc1_.yPos + this.mcMapContentHolder.y;
               if(this.mcTutorialArrow_target.y < 300)
               {
                  if(this.mcTutorialArrow_target.rotation != 90)
                  {
                     this.mcTutorialArrow_target.rotation = 90;
                  }
               }
               else if(this.mcTutorialArrow_target.rotation != -90)
               {
                  this.mcTutorialArrow_target.rotation = -90;
               }
            }
            else
            {
               if(this.mcTutorialArrow_target.currentLabel != "animOff")
               {
                  this.mcTutorialArrow_target.gotoAndStop("animOff");
               }
               if(this.mcTutorialArrow_border.currentLabel != "animOn")
               {
                  this.mcTutorialArrow_border.gotoAndStop("animOn");
               }
               if(_loc1_.xPos < _loc5_)
               {
                  this.mcTutorialArrow_border.x = this.mcMouseHitArea.x;
                  if(_loc1_.yPos < _loc7_)
                  {
                     this.mcTutorialArrow_border.rotation = 45;
                     this.mcTutorialArrow_border.y = this.mcMouseHitArea.y;
                  }
                  else if(_loc1_.yPos > _loc8_)
                  {
                     this.mcTutorialArrow_border.rotation = 315;
                     this.mcTutorialArrow_border.y = this.mcMouseHitArea.y + this.mcMouseHitArea.height;
                  }
                  else
                  {
                     this.mcTutorialArrow_border.rotation = 0;
                     this.mcTutorialArrow_border.y = this.mcMouseHitArea.y + this.mcMapContentHolder.y + _loc1_.yPos;
                  }
               }
               else if(_loc1_.xPos > _loc6_)
               {
                  this.mcTutorialArrow_border.x = this.mcMouseHitArea.x + this.mcMouseHitArea.width;
                  if(_loc1_.yPos < _loc7_)
                  {
                     this.mcTutorialArrow_border.rotation = 135;
                     this.mcTutorialArrow_border.y = this.mcMouseHitArea.y;
                  }
                  else if(_loc1_.yPos > _loc8_)
                  {
                     this.mcTutorialArrow_border.rotation = 225;
                     this.mcTutorialArrow_border.y = this.mcMouseHitArea.y + this.mcMouseHitArea.height;
                  }
                  else
                  {
                     this.mcTutorialArrow_border.rotation = 180;
                     this.mcTutorialArrow_border.y = this.mcMouseHitArea.y + this.mcMapContentHolder.y + _loc1_.yPos;
                  }
               }
               else
               {
                  this.mcTutorialArrow_border.x = this.mcMouseHitArea.x + this.mcMapContentHolder.x + _loc1_.xPos;
                  if(_loc1_.yPos < _loc7_)
                  {
                     this.mcTutorialArrow_border.rotation = 90;
                     this.mcTutorialArrow_border.y = this.mcMouseHitArea.y;
                  }
                  else
                  {
                     this.mcTutorialArrow_border.rotation = 270;
                     this.mcTutorialArrow_border.y = this.mcMouseHitArea.y + this.mcMouseHitArea.height;
                  }
               }
            }
         }
      }
      
      private function itemBoxSparksHandler() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Sprite = null;
         var _loc6_:Sprite = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         for each(_loc2_ in dataM.missionsItemBoxSlots)
         {
            if(this._mapObjects[_loc2_] != null)
            {
               if(this._mapObjects[_loc2_].parent != null)
               {
                  if(_loc1_.mapProgress[_loc2_] != "v")
                  {
                     _loc4_ = Math.ceil(Math.random() * 17);
                     if(_loc4_ == 1)
                     {
                        _loc5_ = externalAssetsM.getAsset("general","Grp_itemBoxSpark");
                        _loc5_.x = this._mapObjects[_loc2_].x + Math.random() * 30 - 15;
                        _loc5_.y = this._mapObjects[_loc2_].y + Math.random() * 30 - 15;
                        this.mcMapObjectsHolder.addChild(_loc5_);
                        this._itemBoxSparks.push(_loc5_);
                     }
                  }
               }
            }
         }
         _loc3_ = this._itemBoxSparks.length - 1;
         while(_loc3_ >= 0)
         {
            _loc6_ = this._itemBoxSparks[_loc3_];
            if(_loc6_.scaleX > 0.1)
            {
               _loc6_.scaleX -= 0.1;
               _loc6_.scaleY -= 0.1;
            }
            else
            {
               this._itemBoxSparks[_loc3_].parent.removeChild(this._itemBoxSparks[_loc3_]);
               this._itemBoxSparks[_loc3_] = null;
               this._itemBoxSparks.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      public function goToHighestMission() : void
      {
         if(this._mapLocked == false)
         {
            this.resetMapPositionToHighestAvailableMission();
            this.refreshTilesVisibility();
            this.refreshMapObjects();
            if(tutorialM.isTutorialActive())
            {
               this.activateTutorialArrows();
            }
         }
      }
      
      private function missionRollOverMarkerHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:uint = 0;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:MovieClip = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(this._mapLocked == false)
         {
            if(this._lastMouseXPos != mouseX || this._lastMouseYPos != mouseY)
            {
               this._lastMouseXPos = mouseX;
               this._lastMouseYPos = mouseY;
               _loc1_ = Math.ceil(mouseX - this.mcMapContentHolder.x - this.mcMapHolder.x);
               _loc2_ = Math.ceil(mouseY - this.mcMapContentHolder.y - this.mcMapHolder.y);
               _loc3_ = this._currentMouseOverMissionSlot;
               _loc4_ = false;
               _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               _loc6_ = 0;
               while(_loc6_ < this._mapObjects.length)
               {
                  if(this._mapObjects[_loc6_] != null)
                  {
                     if(this._mapObjects[_loc6_].parent != null)
                     {
                        _loc7_ = false;
                        if(_loc6_ <= this._highestMissionAllowed)
                        {
                           if(dataM.missionsDB[_loc6_].type == BMWorldMapLocationData.TYPE_MISSION)
                           {
                              _loc7_ = true;
                           }
                        }
                        _loc8_ = false;
                        if(dataM.missionsDB[_loc6_].type == BMWorldMapLocationData.TYPE_LOOT)
                        {
                           if(_loc5_.mapProgress[_loc6_] == null || _loc5_.mapProgress[_loc6_] == "x")
                           {
                              _loc8_ = true;
                           }
                        }
                        if(_loc7_ || _loc8_)
                        {
                           _loc9_ = this._mapObjects[_loc6_];
                           _loc10_ = _loc9_.x - _loc1_;
                           _loc11_ = _loc9_.y - _loc2_;
                           _loc12_ = dataM.getVectorSize(_loc10_,_loc11_);
                           if(_loc12_ < 30)
                           {
                              this.showMissionRollOverMarker(_loc6_,dataM.missionsDB[_loc6_].type,_loc9_.x,_loc9_.y,dataM.missionsDB[_loc6_].difficulty);
                              _loc4_ = true;
                              _loc6_ = this._mapObjects.length;
                           }
                        }
                     }
                  }
                  _loc6_++;
               }
               if(_loc3_ > -1)
               {
                  if(_loc4_ == false)
                  {
                     this.hideMissionRollOverMarker();
                  }
               }
               else if(_loc4_)
               {
                  soundM.createSound("buttonRollover",1);
               }
            }
         }
      }
      
      private function resizingMapObjectsHandler() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Number = NaN;
         if(this._mapObjectSlotsResizingToNormal.length > 0)
         {
            _loc2_ = this._mapObjectSlotsResizingToNormal.length - 1;
            while(_loc2_ >= 0)
            {
               _loc1_ = this._mapObjects[this._mapObjectSlotsResizingToNormal[_loc2_]];
               if(_loc1_ != null)
               {
                  if(_loc1_.scaleX > 1)
                  {
                     _loc1_.scaleX -= 0.015;
                     _loc1_.scaleY -= 0.015;
                     if(_loc1_.scaleX <= 1)
                     {
                        _loc1_.scaleX = 1;
                        _loc1_.scaleY = 1;
                        this._mapObjectSlotsResizingToNormal.splice(_loc2_,1);
                     }
                  }
               }
               else
               {
                  this._mapObjectSlotsResizingToNormal.splice(_loc2_,1);
               }
               _loc2_--;
            }
         }
         if(this._currentMouseOverMissionSlot > -1)
         {
            _loc1_ = this._mapObjects[this._currentMouseOverMissionSlot];
            if(_loc1_ != null)
            {
               if(_loc1_.scaleX < 1.15)
               {
                  _loc1_.scaleX += 0.03;
                  _loc1_.scaleY += 0.03;
               }
            }
         }
      }
      
      private function addToMapObjectSlotsResizingToNormal(param1:uint) : void
      {
         var _loc2_:Boolean = true;
         var _loc3_:uint = 0;
         while(_loc3_ < this._mapObjectSlotsResizingToNormal.length)
         {
            if(this._mapObjectSlotsResizingToNormal[_loc3_] == param1)
            {
               _loc2_ = false;
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            this._mapObjectSlotsResizingToNormal.push(param1);
         }
      }
      
      private function removeFromMapObjectSlotsResizingToNormal(param1:uint) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._mapObjectSlotsResizingToNormal.length)
         {
            if(this._mapObjectSlotsResizingToNormal[_loc2_] == param1)
            {
               this._mapObjectSlotsResizingToNormal.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      private function showMissionRollOverMarker(param1:uint, param2:uint, param3:Number, param4:Number, param5:uint) : void
      {
         var _loc6_:BMWorldMapLocationData = null;
         var _loc7_:BMPlayerProfile = null;
         var _loc8_:BMBoostData = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         if(this._currentMouseOverMissionSlot != param1)
         {
            if(this._currentMouseOverMissionSlot > -1)
            {
               this.addToMapObjectSlotsResizingToNormal(this._currentMouseOverMissionSlot);
            }
            this._currentMouseOverMissionSlot = param1;
            this.removeFromMapObjectSlotsResizingToNormal(this._currentMouseOverMissionSlot);
            _loc6_ = dataM.missionsDB[this._currentMouseOverMissionSlot];
            switch(param2)
            {
               case BMWorldMapLocationData.TYPE_MISSION:
                  break;
               case BMWorldMapLocationData.TYPE_LOOT:
                  switch(_loc6_.subType)
                  {
                     case BMWorldMapLocationData.SUB_TYPE_LOOT_ITEM_BOX:
                        _loc7_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                        _loc8_ = dataM.boostsDB[_loc6_.itemBoxID];
                        if(_loc7_.level >= dataM.levelForExpandedItemBox)
                        {
                           _loc9_ = dataM.levelForExpandedItemBox;
                           _loc10_ = dataM.LEVEL_MAX;
                        }
                        else
                        {
                           _loc9_ = _loc7_.level - _loc8_.levelDifference;
                           _loc10_ = _loc7_.level + _loc8_.levelDifference;
                           if(_loc9_ < 2)
                           {
                              _loc9_ = 2;
                           }
                        }
                        _loc11_ = getSpecificText("packages_randomItemsTooltipWithMythical");
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%ITEMS%",String(_loc8_.amount));
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%LEVEL1%",String(_loc9_));
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%LEVEL2%",String(_loc10_));
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%RARE%",String(_loc8_.ratioRare));
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%EPIC%",String(_loc8_.ratioEpic));
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%LEGENDARY%",String(_loc8_.ratioLegendary));
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_RARE_ITEM + "\'>");
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%COLOR3%","<FONT COLOR=\'#" + dataM.COLOR_EPIC_ITEM + "\'>");
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%COLOR4%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%MYTHICAL%",String(_loc8_.ratioMythical));
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%RATIO%",String(_loc8_.ratioNewMythical));
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%COLOR5%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
                        _loc11_ = dataM.replaceStringInText(_loc11_,"%COLOR6%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
                        tooltip.showToolTip("regularText",_loc11_);
                        break;
                     case BMWorldMapLocationData.SUB_TYPE_LOOT_CUSTOM_ITEM_BOX:
                        _loc13_ = "<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>";
                        _loc14_ = "<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>";
                        if(_loc6_.mythicalCards == 1)
                        {
                           _loc12_ = "Get " + _loc14_ + "1</FONT> random " + _loc13_ + "Mythical item</FONT><BR>and " + _loc14_ + "4</FONT> Ultra power kits</FONT>";
                        }
                        else
                        {
                           _loc12_ = "Get " + _loc14_ + "2</FONT> random " + _loc13_ + "Mythical items</FONT><BR>and " + _loc14_ + "3</FONT> Ultra power kits</FONT>";
                        }
                        tooltip.showToolTip("regularText",_loc12_);
                  }
            }
         }
      }
      
      private function hideMissionRollOverMarker() : void
      {
         this.mcMissionRollOverMarker.gotoAndStop("animOff");
         if(this.mcMissionRollOverMarker.parent != null)
         {
            this.mcMissionRollOverMarker.parent.removeChild(this.mcMissionRollOverMarker);
         }
         if(this._currentMouseOverMissionSlot > -1)
         {
            this.addToMapObjectSlotsResizingToNormal(this._currentMouseOverMissionSlot);
         }
         this._currentMouseOverMissionSlot = -1;
         tooltip.hideToolTip();
      }
      
      public function goToHighestMissionMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("goToNextMission"));
      }
      
      public function goToHighestMissionMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      public function hardTooltipMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:String = getScreenText("hardKeys");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_HARD + "\'>");
         tooltip.showToolTip("regularText",_loc2_);
      }
      
      public function insaneTooltipMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:String = getScreenText("insaneKeys");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_INSANE + "\'>");
         tooltip.showToolTip("regularText",_loc2_);
      }
      
      public function generalTooltipMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      private function missionFlagAnimationHandler() : void
      {
         if(this._missionFlagAnimationHandler)
         {
            if(this._missionFlagAnimationCounter == 0)
            {
               this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].visible = false;
            }
            ++this._missionFlagAnimationCounter;
            if(this._missionFlagAnimationCounter >= 20)
            {
               if(this._missionFlagAnimationCounter <= 35)
               {
                  if(this._missionFlagAnimationCounter == 20)
                  {
                     this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].visible = true;
                     this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].scaleX = 0.1;
                     this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].scaleY = 0.1;
                  }
                  else
                  {
                     this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].scaleX += 0.1;
                     this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].scaleY += 0.1;
                  }
               }
               else if(this._missionFlagAnimationCounter < 40)
               {
                  this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].scaleX -= 0.1;
                  this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].scaleY -= 0.1;
               }
               else
               {
                  this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].scaleX = 1;
                  this._mapObjects[dataM.missionWorldMap_missionCompletedSlot].scaleY = 1;
                  this._missionFlagAnimationHandler = false;
                  this.unlockMap();
                  dataM.missionWorldMap_missionCompletedSlot = -1;
                  this.checkForChallenge();
                  if(tutorialM.isTutorialActive())
                  {
                     this.activateTutorialArrows();
                  }
               }
            }
         }
      }
      
      private function checkForChallenge() : void
      {
         var _loc1_:Array = dataM.getTargetBattleType();
         var _loc2_:String = _loc1_[0];
         var _loc3_:String = _loc1_[1];
         switch(_loc2_)
         {
            case "challenge":
               screensM.addScreen("screenWorldMapSelectBattle");
               screensM.screenWorldMapSelectBattle.refreshScreen(-1);
               this.lockMap();
               this.hideBottomInterface();
         }
      }
      
      public function specialChallengeClosed() : void
      {
         this.unlockMap();
         this.showBottomInterface();
      }
      
      private function showBottomInterface() : void
      {
         if(screensM.isScreenOpened("screenMissionWorldMapInterface"))
         {
            this.mcBottomInterface.visible = true;
            this.btnGoToHighestMission.visible = true;
         }
      }
      
      private function hideBottomInterface() : void
      {
         this.mcBottomInterface.visible = false;
         this.btnGoToHighestMission.visible = false;
      }
      
      public function screenBuyAnotherItemBoxClosed() : void
      {
         this.unlockMap();
      }
      
      private function resetAnimationKeys() : void
      {
         if(screensM.isScreenOpened("screenMissionWorldMapInterface"))
         {
            screensM.screenMissionWorldMapInterface.resetAnimationKeys();
         }
         else
         {
            this._keyAnimationHandlerActive = false;
            this.mcKeyHard.x = this._keyHardOriginXPos;
            this.mcKeyHard.y = this._keyHardOriginYPos;
            this.mcKeyHard.scaleX = 1;
            this.mcKeyHard.scaleY = 1;
            this.mcKeyHard.visible = false;
            this.mcKeyInsane.x = this._keyInsaneOriginXPos;
            this.mcKeyInsane.y = this._keyInsaneOriginYPos;
            this.mcKeyInsane.scaleX = 1;
            this.mcKeyInsane.scaleY = 1;
            this.mcKeyInsane.visible = false;
         }
      }
      
      private function activateKeyAnimation(param1:uint, param2:uint) : void
      {
         var _loc3_:BMWorldMapLocationData = null;
         if(screensM.isScreenOpened("screenMissionWorldMapInterface"))
         {
            screensM.screenMissionWorldMapInterface.activateKeyAnimation(param1,param2);
         }
         else
         {
            this._keyAnimationHandlerActive = true;
            this._keyAnimationFrameCounter = 0;
            this._keyAnimationDifficulty = param1;
            this._keyAnimationStatus = "up";
            _loc3_ = dataM.missionsDB[param2];
            this._keyAnimationTargetXPos = _loc3_.xPos + this.mcMapContentHolder.x + this.mcMapHolder.x;
            this._keyAnimationTargetYPos = _loc3_.yPos + this.mcMapContentHolder.y + this.mcMapHolder.y;
         }
      }
      
      public function isMapLocked() : Boolean
      {
         return this._mapLocked;
      }
      
      public function lockMap() : void
      {
         this._mapLocked = true;
      }
      
      public function unlockMap() : void
      {
         this._mapLocked = false;
      }
      
      private function keyAnimationHandler() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._keyAnimationHandlerActive)
         {
            ++this._keyAnimationFrameCounter;
            if(this._keyAnimationDifficulty == 2)
            {
               _loc1_ = this.mcKeyHard;
            }
            else
            {
               _loc1_ = this.mcKeyInsane;
            }
            switch(this._keyAnimationStatus)
            {
               case "up":
                  if(this._keyAnimationFrameCounter == 1)
                  {
                     _loc1_.visible = true;
                  }
                  if(this._keyAnimationFrameCounter <= 10)
                  {
                     _loc1_.scaleX += 0.2;
                     _loc1_.scaleY += 0.2;
                  }
                  _loc2_ = 240 - _loc1_.y;
                  _loc1_.y += _loc2_ * 0.15;
                  if(Math.abs(_loc2_) < 1)
                  {
                     _loc1_.y = 240;
                     this._keyAnimationStatus = "wait";
                     this._keyAnimationFrameCounter = 0;
                  }
                  break;
               case "wait":
                  if(this._keyAnimationFrameCounter >= 10)
                  {
                     this._keyAnimationStatus = "down";
                     this._keyAnimationFrameCounter = 0;
                  }
                  break;
               case "down":
                  _loc3_ = this._keyAnimationTargetXPos - _loc1_.x;
                  _loc2_ = this._keyAnimationTargetYPos - _loc1_.y;
                  _loc1_.x += _loc3_ * 0.3;
                  _loc1_.y += _loc2_ * 0.3;
                  if(Math.abs(_loc3_) < 1 && Math.abs(_loc2_) < 1)
                  {
                     _loc1_.x = this._keyAnimationTargetXPos;
                     _loc1_.y = this._keyAnimationTargetYPos;
                     this._keyAnimationStatus = "shrink";
                  }
                  break;
               case "shrink":
                  _loc1_.scaleX -= 0.25;
                  _loc1_.scaleY -= 0.25;
                  if(_loc1_.scaleX <= 0.25)
                  {
                     _loc1_.visible = false;
                     this._keyAnimationStatus = "done";
                  }
                  break;
               case "done":
                  this._keyAnimationHandlerActive = false;
                  this.enterMission();
            }
         }
      }
      
      public function newMissionCreated() : void
      {
         screensM.removeScreen("screenConfirmation");
         screensM.screenBlack.activateBlackScreen(this.enterNewMission,true,true,null,0);
      }
      
      public function enterNewMission() : void
      {
         screensM.screenNewMenu.removeCurrentScreen();
         screensM.addScreen("screenMissionBaseMap");
         screensM.screenMissionBaseMap.refreshScreen(false);
      }
      
      public function enterNewChallenge() : void
      {
         var _loc1_:Array = dataM.getTargetBattleType();
         var _loc2_:String = _loc1_[0];
         var _loc3_:String = _loc1_[1];
         dataM.campaignBattleDifficulty = 1;
         dataM.startBattleVSComputer(_loc2_,_loc3_);
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc4_.missionsCompletedAtLastChallenge = _loc4_.missionsCompleted;
         screensM.addBattleScreens();
         screensM.screenNewMenu.removeCurrentScreen();
      }
      
      public function refreshBattleCredits() : void
      {
         var _loc1_:String = null;
         this.mcBattleCredits.txtBattleCredits.text = dataM.getNumberWithComma(dataM.myProfile.battleCredits);
         if(dataM.myProfile.battleCredits >= dataM.battleCreditsManager.getMaxBattleCredits())
         {
            _loc1_ = "";
         }
         else
         {
            _loc1_ = BMCountdownTimerText.getCountdownTimerText(dataM.battleCreditsManager.getSecondsLeftForBattleCreditAddon());
         }
         this.mcBattleCredits.txtTimeLeft.text = _loc1_;
      }
      
      private function removeBattleCredits() : void
      {
      }
      
      private function showBossDialogMissionMarker(param1:MovieClip, param2:uint) : void
      {
         this.removeBossDialogMissionMarker();
         this.mcBossDialogMissionMarker.x = param1.x;
         this.mcBossDialogMissionMarker.y = param1.y;
         this.mcBossDialogMissionMarker.gotoAndStop(param2);
         this.mcMapObjectsHolder.addChild(this.mcBossDialogMissionMarker);
         if(param1.parent != null)
         {
            param1.parent.removeChild(param1);
            this.mcMapObjectsHolder.addChild(param1);
         }
         this.mcBossDialogMissionMarker.scaleX = 1;
         this.mcBossDialogMissionMarker.scaleY = 1;
         TweenMax.to(this.mcBossDialogMissionMarker,1,{
            "scaleX":1.1,
            "scaleY":1.1,
            "onComplete":this.bossDialogMarkerScaleIncreaseDone
         });
      }
      
      private function removeBossDialogMissionMarker(param1:Boolean = true) : void
      {
         if(this.mcBossDialogMissionMarker.parent != null)
         {
            if(param1)
            {
               this.mcBossDialogMissionMarker.parent.removeChild(this.mcBossDialogMissionMarker);
               TweenMax.killTweensOf(this.mcBossDialogMissionMarker);
            }
            else
            {
               this._removeBoxDialogMarkerUsingAnimation = true;
            }
         }
      }
      
      private function bossDialogMarkerScaleIncreaseDone() : void
      {
         if(this._removeBoxDialogMarkerUsingAnimation)
         {
            TweenMax.to(this.mcBossDialogMissionMarker,0.5,{
               "scaleX":0.2,
               "scaleY":0.2,
               "onComplete":this.bossDialogMarkerRemoveAnimationDone
            });
            this._removeBoxDialogMarkerUsingAnimation = false;
         }
         else
         {
            TweenMax.to(this.mcBossDialogMissionMarker,1,{
               "scaleX":0.9,
               "scaleY":0.9,
               "onComplete":this.bossDialogMarkerScaleDecreaseDone
            });
         }
      }
      
      private function bossDialogMarkerScaleDecreaseDone() : void
      {
         TweenMax.to(this.mcBossDialogMissionMarker,1,{
            "scaleX":1.1,
            "scaleY":1.1,
            "onComplete":this.bossDialogMarkerScaleIncreaseDone
         });
      }
      
      private function bossDialogMarkerRemoveAnimationDone() : void
      {
         this.removeBossDialogMissionMarker();
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.mainMenu();
      }
      
      public function removeMe() : void
      {
         var _loc1_:uint = 0;
         screensM.removeScreen("screenRegisterOffer");
         if(screensM.isScreenOpened("screenWorldMapSelectBattle"))
         {
            screensM.screenWorldMapSelectBattle.backClickedSub(false);
         }
         if(screensM.isScreenOpened("screenMissionWorldMapInterface"))
         {
            screensM.screenMissionWorldMapInterface.removeMe();
         }
         BMSpecialOffersManager.gi().removeSpecialOffer();
         tooltip.hideToolTip();
         this.hideMissionRollOverMarker();
         this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.mapMouseDown);
         this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.mapMouseUp);
         this.mcMouseHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.mapMouseUp);
         _loc1_ = 0;
         while(_loc1_ < this._mapTiles.length)
         {
            if(this._mapTiles[_loc1_] != null)
            {
               if(this._mapTiles[_loc1_].parent != null)
               {
                  this._mapTiles[_loc1_].parent.removeChild(this._mapTiles[_loc1_]);
               }
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._mapObjects.length)
         {
            if(this._mapObjects[_loc1_] != null)
            {
               if(this._mapObjects[_loc1_].parent != null)
               {
                  this._mapObjects[_loc1_].parent.removeChild(this._mapObjects[_loc1_]);
               }
               this._mapObjects[_loc1_] = null;
            }
            _loc1_++;
         }
         this._mapObjects = new Array();
         _loc1_ = 0;
         while(_loc1_ < this._missionNumbers.length)
         {
            if(this._missionNumbers[_loc1_] != null)
            {
               if(this._missionNumbers[_loc1_].parent != null)
               {
                  this._missionNumbers[_loc1_].parent.removeChild(this._missionNumbers[_loc1_]);
               }
               this._missionNumbers[_loc1_] = null;
            }
            _loc1_++;
         }
         this._missionNumbers = new Array();
         this.deactivateTutorialArrows();
         if(FeatureFlags.PLAYER_ENERGY)
         {
            this.removeBattleCredits();
         }
         if(screensM.isScreenOpened("screenBuyAnotherItemBox"))
         {
            screensM.screenBuyAnotherItemBox.removeMe();
         }
         screensM.removeScreen("screenMissionWorldMap");
         this.bossDialogController.removeMe();
      }
      
      override public function notifyClientDataReloaded() : *
      {
      }
   }
}

