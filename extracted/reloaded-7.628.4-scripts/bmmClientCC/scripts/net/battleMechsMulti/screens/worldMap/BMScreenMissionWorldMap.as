package net.battleMechsMulti.screens.worldMap
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.managers.specialOffers.BMOneTimeSpecialOffersManager;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureI;
   import net.battleMechsMulti.mobiles.chat.BMMiniChat;
   import net.battleMechsMulti.mobiles.itemComparison.BMMechBoostRecommender;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.mobiles.unlockedMechSlotsResolver.BMUnlockedMechSlotsResolver;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossData;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossDialogController;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapChapterTitleController;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.battleCredits.BMBattleCreditsBar;
   import net.battleMechsMulti.screens.clan.BMScreenClanMenu;
   import net.battleMechsMulti.screens.missionDifficulty.BMScreenMissionDifficulty;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   import net.battleMechsMulti.session.LoginAsFlowTypes;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol839")]
   public class BMScreenMissionWorldMap extends BMBaseScreen
   {
      
      public var mcMapHolder:MovieClip;
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcMouseHitArea:Sprite;
      
      public var battleCreditsBar:BMBattleCreditsBar;
      
      public var mcSizer_btnGoToHighestMission:Sprite;
      
      public var mcTutorialArrow_border:MovieClip;
      
      public var mcTutorialArrow_target:MovieClip;
      
      public var mcTutorialArrow_back:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnBack:BMButton_pictureI;
      
      public var mcBossDialogMissionMarker:MovieClip;
      
      public var screenMissionDifficulty:BMScreenMissionDifficulty;
      
      public var mcQuestCompleted:MovieClip;
      
      public var txtAdminMapCoords:TextField;
      
      public var mcMapContentHolder:MovieClip;
      
      public var mcClanBossPointer:BMWorldMapLocationPointer;
      
      public var miniChat:BMMiniChat;
      
      private var mcMissionRollOverMarker:MovieClip;
      
      private var mcMapTerrainHolder:MovieClip;
      
      private var mcMapObjectsHolder:MovieClip;
      
      private var mcMissionNumbersHolder:MovieClip;
      
      private var mcMissionStarsHolder:MovieClip;
      
      private var mcMapPathHolder:MovieClip;
      
      private var _firstRefresh:Boolean = true;
      
      private var _mapTiles:Array;
      
      private var _mapObjects:Array;
      
      private var _missionNumbers:Array;
      
      private var _missionStars:Array;
      
      private var _clanBossMapObject:MovieClip;
      
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
      
      private var _tutorialMissionSlot:int = -1;
      
      private var _itemBoxSparks:Array = new Array();
      
      private var _mouseDownXPos:Number;
      
      private var _mouseDownYPos:Number;
      
      private var _currentMouseOverMissionSlot:Number = -1;
      
      private var _bottomInterfaceOriginXPos:Number;
      
      private var _btnGoToHighestMissionOriginXPos:Number;
      
      private var _mapLocked:Boolean = false;
      
      private var _allHardInsaneMissionsCompleted:Boolean;
      
      private var _clickedItemBoxSlot:uint;
      
      private var _mapOriginalHeight:Number;
      
      private var _mapObjectSlotsResizingToNormal:Array = new Array();
      
      private var _mapMaxXScroll:Number;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _lastVisibleChapter:Number = -1;
      
      private var _removeBoxDialogMarkerUsingAnimation:Boolean = false;
      
      private var _tauntBossMechView:BMMechView;
      
      private var chapterTitleController:BMWorldMapChapterTitleController;
      
      private var bossDialogController:BMWorldMapBossDialogController;
      
      private var _selectedSlot:int = -1;
      
      private var _tauntBossLocationID:int = -1;
      
      private var _ignoreTauntBossAfterCompletingTutorial:Boolean = false;
      
      private var _harvestUIs:Array = new Array();
      
      private var _storyID:uint = 0;
      
      private var MAP_WIDTH:uint;
      
      private var MAP_HEIGHT:uint;
      
      private const MAP_TILES_COLUMNS:uint = 7;
      
      private const MAP_TILES_ROWS:uint = 1;
      
      private const TILE_WIDTH:uint = 800;
      
      private const TILE_HEIGHT:uint = 480;
      
      private var requestedToExitScreen:Boolean;
      
      private var _lockedChapters:Array;
      
      private var _nukeExplosionHolder:MovieClip;
      
      private var _nukeRocket:MovieClip;
      
      private var _nukeReward:Object;
      
      public function BMScreenMissionWorldMap()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("missionWorldMap");
      }
      
      public function refreshScreen(param1:uint = 0) : void
      {
         var _loc3_:Function = null;
         var _loc4_:uint = 0;
         var _loc5_:BMWorldMapLocationData = null;
         var _loc6_:Boolean = false;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_MISSION_WORLD_MAP,"btnBack","pictureI");
            _loc3_ = this.backClicked;
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,_loc3_,dataM.runAsMobile);
            this._mapTiles = new Array();
            _loc4_ = 0;
            while(_loc4_ < this.MAP_TILES_ROWS * this.MAP_TILES_COLUMNS)
            {
               this._mapTiles.push(null);
               _loc4_++;
            }
            this._mapObjects = new Array();
            this._missionNumbers = new Array();
            this._missionStars = new Array();
            this.MAP_WIDTH = this.MAP_TILES_COLUMNS * this.TILE_WIDTH + 200;
            this.MAP_HEIGHT = this.MAP_TILES_ROWS * this.TILE_HEIGHT;
            this.mcMapContentHolder = new MovieClip();
            this.mcMapTerrainHolder = new MovieClip();
            this.mcMapPathHolder = new MovieClip();
            this.mcMapObjectsHolder = new MovieClip();
            this.mcMissionNumbersHolder = new MovieClip();
            this.mcMissionStarsHolder = new MovieClip();
            this.mcMapContentHolder.addChild(this.mcMapTerrainHolder);
            this.mcMapContentHolder.addChild(this.mcMapPathHolder);
            this.mcMapContentHolder.addChild(this.mcMapObjectsHolder);
            this.mcMapContentHolder.addChild(this.mcMissionNumbersHolder);
            this.mcMapContentHolder.addChild(this.mcMissionStarsHolder);
            this.mcMapHolder.addChild(this.mcMapContentHolder);
            this.mcTutorialArrow_border.mouseEnabled = false;
            this.mcTutorialArrow_border.mouseChildren = false;
            this.mcTutorialArrow_target.mouseEnabled = false;
            this.mcTutorialArrow_target.mouseChildren = false;
            this.mcTutorialArrow_back.mouseEnabled = false;
            this.mcTutorialArrow_back.mouseChildren = false;
            this.mcMissionRollOverMarker = new mcWorldMarkersAnim();
            this._mapOriginalHeight = this.mcMouseHitArea.height;
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow_back);
            this._firstRefresh = false;
            if(dataM.isNeedToSaveProgress())
            {
               loginM.startLoginAsFlow(LoginAsFlowTypes.SAVE_PROGRESS);
               dataM.saveProgressSeen = true;
            }
            this.mcQuestCompleted.mouseEnabled = false;
            this.mcQuestCompleted.mouseChildren = false;
            this.onQuestsDataUpdated();
            this.initMiniChat();
         }
         this._storyID = param1;
         if(tutorialM.isTutorialActive())
         {
            this.battleCreditsBar.visible = false;
         }
         else
         {
            this.battleCreditsBar.visible = true;
         }
         this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.mapMouseDown);
         this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.mapMouseUp);
         this.mcMouseHitArea.addEventListener(MouseEvent.ROLL_OUT,this.mapMouseRollOut);
         this.unlockMap();
         this._mapBeingDragged = false;
         this.setAllHardInsaneMissionsCompleted();
         this.mcMouseHitArea.height = this._mapOriginalHeight;
         this.setHighestMissionSlot();
         this.resetMapPositionToFocusedMission();
         this.createMapTiles();
         this.createHarvestingUI();
         this.refreshTilesVisibility();
         this.refreshMapObjects();
         this.addTauntBoss();
         this.initClanBoss();
         if(dataM.myProfile.currentMissionSlot > -1 && (dataM.singlePlayerM.finishMissionForFirstTime && dataM.singlePlayerM.shouldUserBeExposedToMissionModes()) && this._missionStars[dataM.myProfile.currentMissionSlot] != null)
         {
            this.doNewStarAnimation();
         }
         else
         {
            this.checkForChallenge();
         }
         this.chapterTitleController = new BMWorldMapChapterTitleController(this,updateTextAndFormat);
         this.bossDialogController = new BMWorldMapBossDialogController(this);
         if(dataM.runAsMobile)
         {
            _loc5_ = this.getMissionDB(this._highestMissionAllowed);
            this.showMissionRollOverMarker(this._highestMissionAllowed,_loc5_.type,_loc5_.xPos,_loc5_.yPos,_loc5_.difficulty);
         }
         if(!(dataM.runAsMobile == false && dataM.isPlayerIDAdmin(dataM.userID)))
         {
            this.txtAdminMapCoords.parent.removeChild(this.txtAdminMapCoords);
         }
         if(tutorialM.isTutorialActive())
         {
            this.activateTutorialArrows();
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
         this.showBoostRecommendation();
         this.initLockedChapterMessages();
         this.removeBossDialogMissionMarker();
         var _loc2_:Boolean = dataM.myProfile.getLastSelectedMissionSlot(this.storyID) == BMSinglePlayerManager.CLAN_BOSS_MISSION_SLOT;
         if(_loc2_)
         {
            this.manuallySelectBossMission();
         }
         else
         {
            this.showBossDialog(dataM.singlePlayerM.getRecommendedMissionSlot(this.storyID));
         }
         dataM.saveGuestData("missionWorldMap");
         if(tutorialM.isTutorialActive())
         {
            this.doTutorialChooseName();
         }
         if(dataM.myProfile.showEpilogueForMode > -1)
         {
            screensM.addScreen(BMScreensManager.SCR_CAMPAIGN_ENDING_SEQUENCE);
            screensM.screenCampaignEndingSequence.startAnimation(dataM.myProfile.showEpilogueForMode);
            dataM.myProfile.showEpilogueForMode = -1;
         }
         else if(BMUnlockedMechSlotsResolver.wasNewMechSlotJustUnlockedThroughCampaign())
         {
            BMUnlockedMechSlotsResolver.activateUnlockMechSlotSequence();
         }
         else
         {
            _loc6_ = BMOneTimeSpecialOffersManager.gi().tryShowOfferInCampaign();
            if(_loc6_ == false)
            {
               dataM.showDelayedAdvertisement();
            }
         }
         if(dataM.myProfile.isInClan && this.showClanBoss)
         {
            remoteM.socketM.clan_getClanData(dataM.myProfile.clanID);
         }
         if(dataM.singlePlayerM.premiumBoxTutorialManager.shouldStartTutorial())
         {
            dataM.singlePlayerM.premiumBoxTutorialManager.startTutorial();
         }
         dataM.gameOfWhalesM.updateUserProfile();
         dataM.gameOfWhalesM.getOffers();
      }
      
      public function get storyID() : uint
      {
         return this._storyID;
      }
      
      private function get missionsDB() : Vector.<BMWorldMapLocationData>
      {
         return dataM.singlePlayerM.getMissionsDB(this.storyID);
      }
      
      private function getMissionDB(param1:uint) : BMWorldMapLocationData
      {
         return dataM.singlePlayerM.getSpecificMissionDB(this.storyID,param1);
      }
      
      private function doNewStarAnimation() : *
      {
         var _loc1_:MovieClip = this._missionStars[dataM.myProfile.currentMissionSlot];
         var _loc2_:MovieClip = _loc1_.getChildAt(dataM.myProfile.currentMissionMode) as MovieClip;
         _loc2_.gotoAndStop("empty");
         TweenMax.delayedCall(0.4,this.doNewStarAnimationSub);
      }
      
      private function doNewStarAnimationSub() : *
      {
         var _loc1_:MovieClip = this._missionStars[dataM.myProfile.currentMissionSlot];
         var _loc2_:MovieClip = _loc1_.getChildAt(dataM.myProfile.currentMissionMode) as MovieClip;
         _loc2_.gotoAndStop("full");
         TweenMax.fromTo(_loc2_,0.6,{
            "scaleX":0.2,
            "scaleY":0.2
         },{
            "scaleX":1.5,
            "scaleY":1.5,
            "colorTransform":{
               "tint":16777215,
               "tintAmount":0.5
            }
         });
         TweenMax.to(_loc2_,0.3,{
            "scaleX":1,
            "scaleY":1,
            "delay":0.6,
            "onComplete":this.checkForChallenge,
            "colorTransform":{
               "tint":16777215,
               "tintAmount":0
            }
         });
      }
      
      private function doTutorialChooseName() : *
      {
         if(dataM.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_MISSION3)
         {
            tutorialM.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_CHOOSE_NAME);
            this._ignoreTauntBossAfterCompletingTutorial = true;
         }
         if(dataM.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_CHOOSE_NAME)
         {
            tutorialM.doChooseName();
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(parent == null)
         {
            return;
         }
         this.refreshTutorialArrowsPosition();
         this.mapMotionHandler();
         this.itemBoxSparksHandler();
         this.refreshTutorialArrowsFrameCoutner();
         this.resizingMapObjectsHandler();
         this.refreshTauntBossTimerAndMech();
         if(dataM.runAsMobile == false)
         {
            this.missionRollOverMarkerHandler();
         }
         this._tutorialArrowController.runFrame();
         this.bossDialogController.onEnterFrameTrigger();
         if(this.txtAdminMapCoords.parent != null)
         {
            _loc1_ = Math.ceil(this.mcMapContentHolder.mouseX - this.mcMapHolder.x);
            _loc2_ = Math.ceil(this.mcMapContentHolder.mouseY);
            this.txtAdminMapCoords.text = TextUtils.getNumberWithComma(_loc1_) + "   " + _loc2_;
         }
         this.clanBossPointerHandler();
      }
      
      private function showBossDialog(param1:uint, param2:Boolean = false) : void
      {
         var _loc7_:uint = 0;
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         var _loc3_:int = dataM.singlePlayerM.getHighestPlayableMissionSlot(this.storyID,0);
         var _loc4_:BMWorldMapLocationData = this.getMissionDB(_loc3_);
         if(dataM.singlePlayerM.isChapterLocked(this.storyID,_loc4_.chapterID))
         {
            return;
         }
         if(screensM.screensDirector.hasTasks())
         {
            return;
         }
         var _loc5_:String = dataM.singlePlayerM.getStoryDialog(_loc3_);
         if(_loc5_ != "")
         {
            this.bossDialogController.showDialog(_loc7_,null,_loc5_,updateTextAndFormatUnlocalized);
            return;
         }
         var _loc6_:BMWorldMapLocationData = this.getMissionDB(param1);
         _loc7_ = _loc6_.chapterID;
         var _loc8_:int = BMSinglePlayerManager.NO_LOCATION_ID;
         if(param1 < this.missionsDB.length - 1)
         {
            if(dataM.clientRunningLocally || param2 || dataM.missionWorldMap_lastBossDialogShown < _loc7_)
            {
               _loc8_ = dataM.singlePlayerM.getNextBossLocationID(this.storyID,param1);
            }
         }
         if(_loc8_ == BMSinglePlayerManager.NO_LOCATION_ID)
         {
            return;
         }
         var _loc9_:BMWorldMapLocationData = this.getMissionDB(_loc8_);
         if(param2 == false)
         {
            dataM.missionWorldMap_lastBossDialogShown = _loc7_;
         }
         var _loc10_:BMWorldMapBossData = dataM.singlePlayerM.getMissionBossData(this.storyID,_loc9_.campaignID,_loc9_.bossID,0);
         var _loc11_:BMMechView = new BMMechView();
         _loc11_.initialize(dataM.LOCAL_OPPONENT_ID,"battle",BMMechStructure.ITEM_TYPE_ITEM_ID,0.6,false);
         _loc11_.buildMech(_loc10_.getBossMechStructure());
         var _loc12_:Number = (7 - _loc7_) * 5;
         var _loc13_:Number = _loc7_ * 10;
         this.bossDialogController.showDialog(_loc7_,_loc11_,dataM.singlePlayerM.getBossDialog(_loc7_),updateTextAndFormat,_loc12_,_loc13_,this.bossDialogEnded);
         var _loc14_:MovieClip = this._mapObjects[_loc8_];
         if(_loc14_ != null)
         {
            this.showBossDialogMissionMarker(_loc14_,_loc7_);
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
         if(Math.abs(this._mapXSpeed) > 5)
         {
            this.unSelectMission();
         }
         if(this._selectedSlot != -1)
         {
            return;
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
            this.chapterTitleController.showTitle(dataM.singlePlayerM.getChapterName(this._lastVisibleChapter + 1),2.5);
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
         this._highestMissionAllowed = dataM.singlePlayerM.getHighestPlayableMissionSlot(this.storyID,0);
      }
      
      private function resetMapPositionToFocusedMission(param1:Boolean = false) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:BMWorldMapLocationData = null;
         this.setMaxXScroll();
         if(param1 && this.showClanBoss)
         {
            _loc2_ = -(dataM.myProfile.clanBossData.xPos - dataM.STAGE_WIDTH / 2);
            if(_loc2_ < this._mapMaxXScroll)
            {
               this._mapMaxXScroll = _loc2_;
            }
         }
         else
         {
            _loc3_ = dataM.myProfile.getLastSelectedMissionSlot(this.storyID);
            if(_loc3_ > -1 && dataM.singlePlayerM.doesMissionExist(this.storyID,_loc3_))
            {
               _loc4_ = this.getMissionDB(_loc3_);
            }
            else
            {
               _loc4_ = this.getMissionDB(dataM.singlePlayerM.getFocusedMissionSlot(this.storyID));
            }
            _loc2_ = -_loc4_.xPos + this.mcMouseHitArea.width / 2;
         }
         _loc2_ = this.setMapXPosInMapBorders(_loc2_);
         this.mcMapContentHolder.x = _loc2_;
      }
      
      private function setMaxXScroll() : void
      {
         var _loc1_:BMWorldMapLocationData = this.getMissionDB(this._highestMissionAllowed);
         this._mapMaxXScroll = (_loc1_.chapterID - 1) * dataM.STAGE_WIDTH * -1 - 50;
      }
      
      private function createMapTiles() : void
      {
         var column:uint = 0;
         var targetSlot:uint = 0;
         var tileName:String = null;
         var newTile:Sprite = null;
         var row:uint = 0;
         while(row < this.MAP_TILES_ROWS)
         {
            column = 0;
            while(column < this.MAP_TILES_COLUMNS)
            {
               targetSlot = row * this.MAP_TILES_COLUMNS + column;
               if(this._mapTiles[targetSlot] == null)
               {
                  tileName = "worldMapPart" + (targetSlot + 1);
                  if(this.storyID == BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2)
                  {
                     tileName = "worldMap2Part" + (targetSlot + 1);
                  }
                  else if(this.storyID == BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3)
                  {
                     tileName = "worldMap3Part" + (targetSlot + 1);
                  }
                  newTile = null;
                  try
                  {
                     newTile = externalAssetsM.getAsset("general",tileName);
                  }
                  catch(e:ReferenceError)
                  {
                     tileName = tileName.substr(0,tileName.length - 1) + "1";
                     newTile = externalAssetsM.getAsset("general",tileName);
                  }
                  newTile.x = column * this.TILE_WIDTH - column;
                  newTile.y = row * this.TILE_HEIGHT - row;
                  this._mapTiles[targetSlot] = newTile;
               }
               column++;
            }
            row++;
         }
      }
      
      private function refreshMapObjects() : void
      {
         var _loc7_:BMWorldMapLocationData = null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc1_:Number = -this.mcMapContentHolder.x - 30;
         var _loc2_:Number = _loc1_ + this.mcMouseHitArea.width + 60;
         var _loc3_:BMPlayerProfile = dataM.myProfile;
         var _loc4_:Number = -1;
         var _loc5_:Number = -1;
         var _loc6_:uint = 0;
         while(_loc6_ < this.missionsDB.length)
         {
            _loc7_ = this.getMissionDB(_loc6_);
            _loc8_ = false;
            _loc9_ = false;
            _loc10_ = false;
            if(_loc7_.type == BMWorldMapLocationData.TYPE_MISSION && _loc7_.mainPath)
            {
               _loc10_ = true;
               _loc9_ = true;
            }
            if(_loc7_.xPos >= _loc1_ && _loc7_.xPos <= _loc2_)
            {
               _loc8_ = true;
            }
            if(_loc7_.isMissionActive(dataM.currentTime))
            {
               this.refreshMissionOverallView(_loc6_,_loc8_,_loc9_,_loc7_.type);
            }
            _loc11_ = true;
            if(dataM.singlePlayerM.isChapterLocked(this.storyID,_loc7_.chapterID))
            {
               _loc11_ = false;
            }
            if(this._mapObjects[_loc6_] != null)
            {
               this._mapObjects[_loc6_].visible = _loc11_;
            }
            _loc6_++;
         }
      }
      
      private function removeMissionOverallView(param1:uint) : void
      {
         if(this._missionNumbers[param1] != null)
         {
            if(this._missionNumbers[param1].parent != null)
            {
               this._missionNumbers[param1].parent.removeChild(this._missionNumbers[param1]);
            }
            this._missionNumbers[param1] = null;
         }
         if(this._missionStars[param1] != null)
         {
            if(this._missionStars[param1].parent != null)
            {
               this._missionStars[param1].parent.removeChild(this._missionStars[param1]);
            }
            this._missionStars[param1] = null;
         }
         if(this._mapObjects[param1] != null)
         {
            if(this._mapObjects[param1].parent != null)
            {
               this._mapObjects[param1].parent.removeChild(this._mapObjects[param1]);
            }
            this._mapObjects[param1] = null;
         }
      }
      
      private function refreshMissionOverallView(param1:uint, param2:Boolean, param3:Boolean, param4:uint) : void
      {
         this.refreshMissionView(param1,param2);
         this.refreshMissionNumberView(param1,param3 && param2);
         if(dataM.singlePlayerM.shouldUserBeExposedToMissionModes())
         {
            this.refreshMissionStarsView(param1,param4 == BMWorldMapLocationData.TYPE_MISSION && param2);
         }
      }
      
      private function refreshMissionView(param1:int, param2:Boolean) : *
      {
         var _loc5_:MovieClip = null;
         var _loc3_:BMPlayerProfile = dataM.myProfile;
         var _loc4_:BMWorldMapLocationData = this.getMissionDB(param1);
         if(param2 == false)
         {
            if(this._mapObjects[param1] == null)
            {
               return;
            }
            if(this._mapObjects[param1].parent == null)
            {
               return;
            }
            this._mapObjects[param1].parent.removeChild(this._mapObjects[param1]);
            return;
         }
         if(this._mapObjects[param1] != null)
         {
            if(this._mapObjects[param1].parent != null)
            {
               return;
            }
            this.mcMapObjectsHolder.addChild(this._mapObjects[param1]);
            return;
         }
         switch(_loc4_.type)
         {
            case BMWorldMapLocationData.TYPE_MISSION:
               _loc5_ = this.createMissionMapObject(_loc4_);
               break;
            case BMWorldMapLocationData.TYPE_LOOT:
               if(this.mapProgress[param1] == BMSinglePlayerManager.MAP_PROGRESS_COMPLETE)
               {
                  _loc5_ = new MovieClip();
               }
               else
               {
                  switch(_loc4_.subType)
                  {
                     case BMWorldMapLocationData.SUB_TYPE_LOOT_CUSTOM_ITEM_BOX:
                     case BMWorldMapLocationData.SUB_TYPE_LOOT_ITEM_BOX:
                        _loc5_ = new mcWorldItemBoxGold();
                  }
               }
         }
         _loc5_.x = _loc4_.xPos;
         _loc5_.y = _loc4_.yPos;
         this.mcMapObjectsHolder.addChild(_loc5_);
         this._mapObjects[param1] = _loc5_;
      }
      
      private function createMissionMapObject(param1:BMWorldMapLocationData) : MovieClip
      {
         var _loc2_:String = null;
         var _loc5_:Number = NaN;
         if(param1.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_DUNGEON)
         {
            return new BMWorldMapPortal(param1);
         }
         if(this.mapProgress[param1.locationID] == BMSinglePlayerManager.MAP_PROGRESS_COMPLETE && param1.mainPath)
         {
            _loc2_ = "_completed";
         }
         else
         {
            _loc5_ = dataM.singlePlayerM.getTauntBossLocationID(this.storyID);
            if(_loc5_ == param1.locationID)
            {
               _loc2_ = "_tauntBoss";
            }
            else if(this._highestMissionAllowed < param1.locationID)
            {
               _loc2_ = "_locked";
            }
            else
            {
               _loc2_ = "_available";
            }
         }
         var _loc3_:String = param1.difficulty + "A";
         _loc3_ = "1A";
         if(param1.difficulty > 1 && _loc2_ != "_locked")
         {
            _loc3_ = "2A";
         }
         if(param1.difficulty == BMSinglePlayerManager.MISSION_DIFFICULTY_NORMAL)
         {
            if(param1.chapterID == 3)
            {
               _loc3_ = "1B";
            }
         }
         if(param1.bossID != null)
         {
            if(param1.chapterID == 7)
            {
               _loc3_ = "4B";
            }
            else
            {
               _loc3_ = "4A";
            }
         }
         var _loc4_:String = "worldMapMissionRegular" + _loc3_ + _loc2_;
         return externalAssetsM.getAsset("general",_loc4_);
      }
      
      private function get mapProgress() : Array
      {
         return dataM.myProfile.getNormalMapProgress(this.storyID);
      }
      
      private function refreshMissionNumberView(param1:int, param2:Boolean) : *
      {
         var _loc6_:MovieClip = null;
         var _loc3_:BMPlayerProfile = dataM.myProfile;
         var _loc4_:BMWorldMapLocationData = this.getMissionDB(param1);
         var _loc5_:Boolean = param1 == dataM.singlePlayerM.getTauntBossLocationID(this.storyID);
         if(_loc5_)
         {
            return;
         }
         if(param2 == false)
         {
            if(this._missionNumbers[param1] != null)
            {
               if(this._missionNumbers[param1].parent != null)
               {
                  this._missionNumbers[param1].parent.removeChild(this._missionNumbers[param1]);
               }
            }
            return;
         }
         if(this._missionNumbers[param1] != null)
         {
            if(this._missionNumbers[param1].parent == null)
            {
               this.mcMissionNumbersHolder.addChild(this._missionNumbers[param1]);
            }
            return;
         }
         var _loc7_:uint = 40;
         _loc6_ = new mcWorldMissionNumber();
         _loc6_.txtNumber.text = String(_loc4_.displayNumber);
         _loc6_.x = _loc4_.xPos;
         _loc6_.y = _loc4_.yPos + _loc7_;
         if(dataM.singlePlayerM.isChapterLocked(this.storyID,_loc4_.chapterID))
         {
            _loc6_.visible = false;
         }
         else
         {
            _loc6_.visible = true;
         }
         this.mcMissionNumbersHolder.addChild(_loc6_);
         this._missionNumbers[param1] = _loc6_;
         if(dataM.runAsMobile)
         {
            --_loc6_.txtNumber.x;
            screensM.createMultipleTextsBitmap("worldMap_missionNumber" + param1,[_loc6_.txtNumber],"",_loc6_);
         }
      }
      
      private function refreshMissionStarsView(param1:int, param2:Boolean) : *
      {
         var _loc3_:BMPlayerProfile = dataM.myProfile;
         var _loc4_:BMWorldMapLocationData = this.getMissionDB(param1);
         if(param2 == false)
         {
            if(this._missionStars[param1] == null)
            {
               return;
            }
            if(this._missionStars[param1].parent == null)
            {
               return;
            }
            this._missionStars[param1].parent.removeChild(this._missionStars[param1]);
            this._missionStars[param1] = null;
            return;
         }
         if(this._missionStars[param1] != null)
         {
            if(this._missionStars[param1].parent == null)
            {
               this.mcMissionStarsHolder.addChild(this._missionNumbers[param1]);
            }
            return;
         }
         var _loc5_:Number = _loc4_.yPos;
         if(_loc4_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS)
         {
            if(dataM.singlePlayerM.tauntBossesOnCampaignMapEnabled && _loc4_.locationID == dataM.singlePlayerM.getNextBossLocationID(this.storyID))
            {
               _loc5_ -= 45;
            }
            else
            {
               _loc5_ -= 18;
            }
         }
         var _loc6_:MovieClip = this.addStarsTo(_loc4_.xPos,_loc5_,dataM.singlePlayerM.getSlotCompleteState(this.storyID,param1));
         this._missionStars[param1] = _loc6_;
         if(dataM.singlePlayerM.isChapterLocked(this.storyID,_loc4_.chapterID))
         {
            _loc6_.visible = false;
         }
         else
         {
            _loc6_.visible = true;
         }
      }
      
      private function addStarsTo(param1:Number, param2:Number, param3:Vector.<Boolean>) : MovieClip
      {
         var _loc6_:MovieClip = null;
         var _loc4_:MovieClip = new MovieClip();
         var _loc5_:int = 0;
         while(_loc5_ < param3.length)
         {
            _loc6_ = new mcWorldMapStar();
            if(param3[_loc5_])
            {
               _loc6_.gotoAndStop("full");
            }
            _loc6_.x = (_loc5_ - 1) * 22;
            _loc6_.y = _loc5_ == 1 ? -43 : -37;
            _loc4_.addChild(_loc6_);
            _loc5_++;
         }
         _loc4_.x = param1;
         _loc4_.y = param2;
         this.mcMissionStarsHolder.addChild(_loc4_);
         return _loc4_;
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
         var _loc9_:BMWorldMapLocationData = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc15_:BMPlayerProfile = null;
         var _loc16_:uint = 0;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Number = NaN;
         var _loc20_:BMWorldMapHarvestUI = null;
         var _loc21_:Rectangle = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         if(screensM.screensDirector.hasTasks())
         {
            return;
         }
         if(this._mapLocked)
         {
            return;
         }
         if(this.userNeedsToExitScreen())
         {
            return;
         }
         var _loc1_:Number = Math.ceil(mouseX - this.mcMapContentHolder.x - this.mcMapHolder.x);
         var _loc2_:Number = Math.ceil(mouseY - this.mcMapContentHolder.y - this.mcMapHolder.y);
         var _loc3_:Number = -this.mcMapContentHolder.x;
         var _loc4_:Number = _loc3_ + this.mcMouseHitArea.width;
         var _loc5_:Number = -this.mcMapContentHolder.y;
         var _loc6_:Number = _loc5_ + this.mcMouseHitArea.height;
         var _loc7_:Number = 999;
         var _loc8_:Number = -1;
         if(this.showClanBoss)
         {
            _loc11_ = _loc1_ - dataM.myProfile.clanBossData.xPos;
            _loc12_ = _loc2_ - dataM.myProfile.clanBossData.yPos;
            _loc13_ = dataM.getVectorSize(_loc11_,_loc12_);
            if(_loc13_ < 40)
            {
               this.clanBossClicked();
               return;
            }
         }
         _loc10_ = 0;
         while(_loc10_ < this.missionsDB.length)
         {
            _loc9_ = this.getMissionDB(_loc10_);
            if(_loc9_.isMissionActive(dataM.currentTime))
            {
               if(!dataM.singlePlayerM.isChapterLocked(this.storyID,_loc9_.chapterID))
               {
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
               }
            }
            _loc10_++;
         }
         var _loc14_:Boolean = false;
         if(_loc7_ < 40)
         {
            _loc15_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc9_ = this.getMissionDB(_loc8_);
            if(_loc9_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_DUNGEON)
            {
               _loc14_ = true;
            }
            else if(_loc8_ <= this._highestMissionAllowed)
            {
               if(_loc9_.type == BMWorldMapLocationData.TYPE_LOOT)
               {
                  if(this.mapProgress[_loc8_] == null)
                  {
                     _loc14_ = true;
                  }
                  else if(this.mapProgress[_loc8_] == BMSinglePlayerManager.MAP_PROGRESS_INCOMPLETE)
                  {
                     _loc14_ = true;
                  }
               }
               else if(tutorialM.isTutorialActive())
               {
                  if(this.mapProgress[_loc8_] == null)
                  {
                     _loc14_ = true;
                  }
                  else if(this.mapProgress[_loc8_] == BMSinglePlayerManager.MAP_PROGRESS_INCOMPLETE)
                  {
                     _loc14_ = true;
                  }
               }
               else
               {
                  _loc14_ = true;
               }
            }
            else if(_loc9_.type == BMWorldMapLocationData.TYPE_LOOT)
            {
               if(dataM.singlePlayerM.didCompleteCampaign(this.storyID,0) && _loc8_ == this.mapProgress.length && _loc8_ == this._highestMissionAllowed + 1)
               {
                  _loc14_ = true;
               }
               else if(this.mapProgress[_loc8_] != BMSinglePlayerManager.MAP_PROGRESS_COMPLETE)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("previousMissionsRequiredForItemBox");
               }
            }
            if(dataM.clientRunningLocally)
            {
            }
            if(_loc14_)
            {
               switch(_loc9_.type)
               {
                  case BMWorldMapLocationData.TYPE_MISSION:
                     _loc16_ = uint(BMSinglePlayerManager.MECHS_PER_STORY_ID[this.storyID]);
                     if(dataM.areMechsReadyForBattle(_loc16_))
                     {
                        if(dataM.singlePlayerM.shouldUserBeExposedToMissionModes())
                        {
                           this.selectMission(_loc8_);
                        }
                        else
                        {
                           _loc18_ = true;
                           if(dataM.singlePlayerM.shouldUserBeExposedToBattleCredits())
                           {
                              _loc19_ = this.getBattleCreditsCost(_loc8_);
                              if(_loc19_ > dataM.myProfile.battleCredits)
                              {
                                 _loc18_ = false;
                              }
                           }
                           if(_loc18_)
                           {
                              _loc15_.setCurrentMissionSlot(_loc8_);
                              this.enterMission();
                              this.lockMapBeforeEnteringMission(_loc8_);
                           }
                           else
                           {
                              screensM.screenConfirmation.displayQuestionOrNotification("notEnoughBattleCredits");
                           }
                        }
                        soundM.createSound("buttonClick",1);
                     }
                     else
                     {
                        screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",-1,-1);
                     }
                     break;
                  case BMWorldMapLocationData.TYPE_LOOT:
                     _loc17_ = false;
                     if(_loc9_.subType == BMWorldMapLocationData.SUB_TYPE_LOOT_CUSTOM_ITEM_BOX)
                     {
                        if(_loc9_.difficulty == 3)
                        {
                           if(this._allHardInsaneMissionsCompleted == false)
                           {
                              _loc17_ = true;
                           }
                        }
                     }
                     if(_loc17_)
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
         if(_loc14_)
         {
            return;
         }
         _loc10_ = 0;
         while(_loc10_ < this._harvestUIs.length)
         {
            _loc20_ = this._harvestUIs[_loc10_];
            _loc21_ = _loc20_.getBounds(_loc20_);
            _loc22_ = _loc20_.x + _loc21_.x;
            _loc23_ = _loc20_.x + _loc21_.x + _loc21_.width;
            _loc24_ = _loc20_.y + _loc21_.y;
            _loc25_ = _loc20_.y + _loc21_.y + _loc21_.height;
            if(_loc1_ >= _loc22_ && _loc1_ <= _loc23_ && _loc2_ >= _loc24_ && _loc2_ <= _loc25_)
            {
               _loc20_.claimHitAreaClickedSub();
            }
            _loc10_++;
         }
      }
      
      public function notEnoughBattleCredits() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("notEnoughBattleCredits");
         this.unlockMap();
      }
      
      public function tokensUpdated() : void
      {
         this.battleCreditsBar.refresh();
         if(screensM.isScreenOpened("screenFillBattleCredits"))
         {
            screensM.screenFillBattleCredits.refreshTokens();
         }
      }
      
      public function manuallySelectMission(param1:uint, param2:uint) : void
      {
         this.selectMission(param1,param2);
         this.activateTutorialArrows(param1);
      }
      
      private function selectMission(param1:int, param2:int = -1) : void
      {
         var _loc6_:uint = 0;
         dataM.myProfile.setCurrentMissionSlot(param1);
         this._selectedSlot = param1;
         var _loc3_:BMWorldMapLocationData = this.getMissionDB(this._selectedSlot);
         var _loc4_:Number = this.setMapXPosInMapBorders(this.mcMouseHitArea.width / 2 - _loc3_.xPos);
         TweenMax.to(this.mcMapContentHolder,0.3,{
            "x":_loc4_,
            "onUpdate":this.onSelectMissionTweenUpdate
         });
         var _loc5_:uint = 0;
         if(param2 > -1)
         {
            _loc5_ = uint(param2);
         }
         else
         {
            _loc5_ = _loc6_ = uint(dataM.myProfile.getLastMissionMode(this.storyID,this._selectedSlot));
         }
         this.screenMissionDifficulty.show(param1,_loc5_);
         this.chapterTitleController.hideTitle();
         this.bossDialogController.hideDialog();
         this.closeClanBossMissionDetails();
      }
      
      public function getBattleCreditsCost(param1:int, param2:int = 0) : int
      {
         var _loc3_:BMWorldMapLocationData = this.getMissionDB(param1);
         return dataM.campaignMissionRewardsRepository.getMissionBattleCreditsCost(this.storyID,_loc3_.campaignID,param2,_loc3_.difficulty);
      }
      
      private function onSelectMissionTweenUpdate() : void
      {
         this.refreshMapObjects();
         this.refreshTilesVisibility();
      }
      
      public function unSelectMission() : void
      {
         this.closeClanBossMissionDetails();
         if(this._selectedSlot == -1)
         {
            return;
         }
         this.refreshMapObjects();
         this._selectedSlot = -1;
         this.screenMissionDifficulty.hide();
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
         if(this.requestedToExitScreen)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function forceUserToExitScreen() : void
      {
         this.requestedToExitScreen = true;
         this.lockMap();
         this.activateTutorialArrows();
      }
      
      private function showNotEnoughLadderWinsYesNoPopup(param1:int, param2:int) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup2);
         var _loc3_:String = getSpecificText("confirmation_onlineWinsRequiredForItemBox");
         while(_loc3_.indexOf("<BR>") == 0)
         {
            _loc3_ = _loc3_.substr("<BR>".length);
         }
         _loc3_ = _loc3_.replace("<BR><BR>","<BR>");
         _loc3_ = dataM.replaceStringInText(_loc3_,"%REQUIRED%",String(param1));
         _loc3_ = dataM.replaceStringInText(_loc3_,"%REMAINING%",String(param2));
         _loc3_ = dataM.replaceStringInText(_loc3_,"%COLOR1%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
         _loc3_ = dataM.replaceStringInText(_loc3_,"%COLOR2%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
         screensM.screenYesNoPopup.displayYesNoPopup("",_loc3_,"",this.openLadderClicked,null,getSpecificText("mainMenu_arena"));
      }
      
      private function openLadderClicked() : void
      {
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_PVP_LOBBY);
      }
      
      public function tryToOpenItemBox() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:BMWorldMapLocationData = this.getMissionDB(this._clickedItemBoxSlot);
         if(_loc1_.ladderWins < _loc2_.onlineWinsRequired)
         {
            this.showNotEnoughLadderWinsYesNoPopup(_loc2_.onlineWinsRequired,_loc2_.onlineWinsRequired - _loc1_.ladderWins);
         }
         else
         {
            this.mapProgress[this._clickedItemBoxSlot] = "v";
            if(this._mapObjects[this._clickedItemBoxSlot] != null)
            {
               if(this._mapObjects[this._clickedItemBoxSlot].parent != null)
               {
                  this._mapObjects[this._clickedItemBoxSlot].parent.removeChild(this._mapObjects[this._clickedItemBoxSlot]);
               }
               this._mapObjects[this._clickedItemBoxSlot] = new MovieClip();
            }
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            remoteM.socketM.mission_claimItemBox(this.storyID,_loc2_.locationID,_loc2_.itemBoxID);
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
         if(dataM.myProfile.hasClanBossReward)
         {
            screensM.screenConfirmation.displayCustomMessage(getSpecificText("clanBoss_mustCollectClanCoins"),this.sendPlayerToClan);
            return;
         }
         var _loc1_:BMPlayerProfile = dataM.myProfile;
         _loc1_.currentStoryID = this.storyID;
         var _loc2_:BMWorldMapLocationData = dataM.singlePlayerM.currentMissionDB;
         trackButtonClick("Mission",_loc2_.locationID,_loc2_.name);
         if(dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL)
         {
            dataM.createMissionLocally(_loc1_.currentMissionSlot,_loc2_.difficulty,_loc2_.themeID);
         }
         else
         {
            remoteM.socketM.mission_create(this.storyID,_loc2_.difficulty,_loc2_.themeID,_loc2_.locationID,_loc1_.currentMissionMode);
         }
         if(_loc1_.getCurrentMissionProgress(this.storyID) == BMSinglePlayerManager.MAP_PROGRESS_COMPLETE)
         {
            _loc1_.updateCurrentMissionProgress(this.storyID,BMSinglePlayerManager.MAP_PROGRESS_REPLAY);
         }
         else
         {
            _loc1_.updateCurrentMissionProgress(this.storyID,BMSinglePlayerManager.MAP_PROGRESS_IN_PROGRESS);
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
      
      private function sendPlayerToClan() : void
      {
         this.screenMissionDifficulty.hide();
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_CLAN,{"tab":BMScreenClanMenu.TAB_BOSS});
      }
      
      private function setAllHardInsaneMissionsCompleted() : void
      {
         var _loc3_:BMWorldMapLocationData = null;
         this._allHardInsaneMissionsCompleted = true;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = 0;
         while(_loc2_ < this.missionsDB.length)
         {
            _loc3_ = this.getMissionDB(_loc2_);
            if(_loc3_.type == BMWorldMapLocationData.TYPE_MISSION)
            {
               if(_loc3_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_REGULAR)
               {
                  if(_loc3_.difficulty > 1)
                  {
                     if(this.mapProgress[_loc2_] == null)
                     {
                        this._allHardInsaneMissionsCompleted = false;
                        _loc2_ = this.missionsDB.length;
                     }
                     else if(this.mapProgress[_loc2_] != BMSinglePlayerManager.MAP_PROGRESS_COMPLETE)
                     {
                        this._allHardInsaneMissionsCompleted = false;
                        _loc2_ = this.missionsDB.length;
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
         this.unSelectMission();
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
      
      private function activateTutorialArrows(param1:int = -1) : void
      {
         var _loc2_:Boolean = false;
         this._tutorialArrows = false;
         this._tutorialFramesCounter = 0;
         this._tutorialMissionSlot = -1;
         this.mcTutorialArrow_target.gotoAndStop("animOff");
         this.mcTutorialArrow_border.gotoAndStop("animOff");
         if(this.userNeedsToExitScreen())
         {
            this._tutorialArrowController.activateTutorialArrow(this,this.btnBack.x + this.btnBack.width / 2,this.btnBack.y + this.btnBack.height * 0.8,90);
         }
         else if(param1 > -1)
         {
            this._tutorialArrows = true;
            this._tutorialFramesCounter = 120;
            this._tutorialMissionSlot = param1;
            this.refreshTutorialArrowsPosition();
         }
         else if(this._highestMissionAllowed < this.missionsDB.length - 1)
         {
            this._tutorialArrows = true;
            this._tutorialMissionSlot = this._highestMissionAllowed;
            _loc2_ = false;
            if(this._highestMissionAllowed < 3)
            {
               _loc2_ = true;
            }
            this.refreshTutorialArrowsPosition();
            if(_loc2_ == false)
            {
               this._tutorialFramesCounter = 120;
            }
         }
      }
      
      private function refreshTutorialArrowsFrameCoutner() : void
      {
         if(this._tutorialArrows == false)
         {
            return;
         }
         if(this._tutorialFramesCounter <= 0)
         {
            return;
         }
         --this._tutorialFramesCounter;
         if(this._tutorialFramesCounter > 0)
         {
            return;
         }
         this._tutorialArrows = false;
         this.mcTutorialArrow_target.gotoAndStop("animOff");
         this.mcTutorialArrow_border.gotoAndStop("animOff");
      }
      
      private function deactivateTutorialArrows() : void
      {
         this._tutorialArrows = false;
         this.mcTutorialArrow_target.gotoAndStop("animOff");
         this.mcTutorialArrow_border.gotoAndStop("animOff");
      }
      
      private function refreshTutorialArrowsPosition() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc10_:BMWorldMapLocationData = null;
         if(this._tutorialArrows == false)
         {
            return;
         }
         if(this._tutorialMissionSlot == BMSinglePlayerManager.CLAN_BOSS_MISSION_SLOT)
         {
            _loc1_ = this._clanBossMapObject.x;
            _loc2_ = this._clanBossMapObject.y;
         }
         else
         {
            _loc10_ = this.getMissionDB(this._tutorialMissionSlot);
            _loc1_ = _loc10_.xPos;
            _loc2_ = _loc10_.yPos;
         }
         var _loc3_:Number = -_loc1_ + this.mcMouseHitArea.width / 2 - this.mcMapContentHolder.x;
         var _loc4_:Number = -_loc2_ + this.mcMouseHitArea.height / 2;
         var _loc5_:Boolean = false;
         var _loc6_:Number = -this.mcMapContentHolder.x;
         var _loc7_:Number = _loc6_ + this.mcMouseHitArea.width;
         var _loc8_:Number = -this.mcMapContentHolder.y;
         var _loc9_:Number = _loc8_ + this.mcMouseHitArea.height;
         if(_loc1_ >= _loc6_ && _loc1_ <= _loc7_)
         {
            if(_loc2_ >= _loc8_ && _loc2_ <= _loc9_)
            {
               _loc5_ = true;
            }
         }
         if(_loc5_)
         {
            if(this.mcTutorialArrow_target.currentLabel != "animOn")
            {
               this.mcTutorialArrow_target.gotoAndStop("animOn");
            }
            if(this.mcTutorialArrow_border.currentLabel != "animOff")
            {
               this.mcTutorialArrow_border.gotoAndStop("animOff");
            }
            this.mcTutorialArrow_target.x = this.mcMapHolder.x + _loc1_ + this.mcMapContentHolder.x;
            this.mcTutorialArrow_target.y = this.mcMapHolder.y + _loc2_ + this.mcMapContentHolder.y;
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
            return;
         }
         if(this.mcTutorialArrow_target.currentLabel != "animOff")
         {
            this.mcTutorialArrow_target.gotoAndStop("animOff");
         }
         if(this.mcTutorialArrow_border.currentLabel != "animOn")
         {
            this.mcTutorialArrow_border.gotoAndStop("animOn");
         }
         if(_loc1_ < _loc6_)
         {
            this.mcTutorialArrow_border.x = this.mcMouseHitArea.x;
            if(_loc2_ < _loc8_)
            {
               this.mcTutorialArrow_border.rotation = 45;
               this.mcTutorialArrow_border.y = this.mcMouseHitArea.y;
            }
            else if(_loc2_ > _loc9_)
            {
               this.mcTutorialArrow_border.rotation = 315;
               this.mcTutorialArrow_border.y = this.mcMouseHitArea.y + this.mcMouseHitArea.height;
            }
            else
            {
               this.mcTutorialArrow_border.rotation = 0;
               this.mcTutorialArrow_border.y = this.mcMouseHitArea.y + this.mcMapContentHolder.y + _loc2_;
            }
            return;
         }
         if(_loc1_ > _loc7_)
         {
            this.mcTutorialArrow_border.x = this.mcMouseHitArea.x + this.mcMouseHitArea.width;
            if(_loc2_ < _loc8_)
            {
               this.mcTutorialArrow_border.rotation = 135;
               this.mcTutorialArrow_border.y = this.mcMouseHitArea.y;
            }
            else if(_loc2_ > _loc9_)
            {
               this.mcTutorialArrow_border.rotation = 225;
               this.mcTutorialArrow_border.y = this.mcMouseHitArea.y + this.mcMouseHitArea.height;
            }
            else
            {
               this.mcTutorialArrow_border.rotation = 180;
               this.mcTutorialArrow_border.y = this.mcMouseHitArea.y + this.mcMapContentHolder.y + _loc2_;
            }
            return;
         }
         this.mcTutorialArrow_border.x = this.mcMouseHitArea.x + this.mcMapContentHolder.x + _loc1_;
         if(_loc2_ < _loc8_)
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
      
      private function itemBoxSparksHandler() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Sprite = null;
         var _loc6_:Sprite = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         for each(_loc2_ in dataM.singlePlayerM.missionsItemBoxSlots[this.storyID])
         {
            if(this._mapObjects[_loc2_] != null)
            {
               if(this._mapObjects[_loc2_].parent != null)
               {
                  if(this.mapProgress[_loc2_] != "v")
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
            this.resetMapPositionToFocusedMission();
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
         var _loc8_:BMWorldMapLocationData = null;
         var _loc9_:Boolean = false;
         var _loc10_:MovieClip = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         if(this._mapLocked)
         {
            return;
         }
         if(this._lastMouseXPos == mouseX && this._lastMouseYPos == mouseY)
         {
            return;
         }
         if(mouseX < this.screenMissionDifficulty.x)
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
                     _loc8_ = this.getMissionDB(_loc6_);
                     if(_loc6_ <= this._highestMissionAllowed || _loc8_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_DUNGEON)
                     {
                        if(_loc8_.type == BMWorldMapLocationData.TYPE_MISSION)
                        {
                           _loc7_ = true;
                        }
                     }
                     _loc9_ = false;
                     if(_loc8_.type == BMWorldMapLocationData.TYPE_LOOT)
                     {
                        if(this.mapProgress[_loc6_] == null || this.mapProgress[_loc6_] == BMSinglePlayerManager.MAP_PROGRESS_INCOMPLETE)
                        {
                           _loc9_ = true;
                        }
                     }
                     if(!(_loc7_ == false && _loc9_ == false))
                     {
                        _loc10_ = this._mapObjects[_loc6_];
                        _loc11_ = _loc10_.x - _loc1_;
                        _loc12_ = _loc10_.y - _loc2_;
                        _loc13_ = dataM.getVectorSize(_loc11_,_loc12_);
                        if(_loc13_ < 30)
                        {
                           this.showMissionRollOverMarker(_loc6_,_loc8_.type,_loc10_.x,_loc10_.y,_loc8_.difficulty);
                           _loc4_ = true;
                           _loc6_ = this._mapObjects.length;
                        }
                     }
                  }
               }
               _loc6_++;
            }
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
         if(this._currentMouseOverMissionSlot != param1)
         {
            if(this._currentMouseOverMissionSlot > -1)
            {
               this.addToMapObjectSlotsResizingToNormal(this._currentMouseOverMissionSlot);
            }
            this._currentMouseOverMissionSlot = param1;
            this.removeFromMapObjectSlotsResizingToNormal(this._currentMouseOverMissionSlot);
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
      
      private function checkForChallenge() : void
      {
         var _loc1_:Array = dataM.getTargetBattleType();
         var _loc2_:String = _loc1_[0];
         var _loc3_:String = _loc1_[1];
         switch(_loc2_)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_CHALLENGE:
         }
      }
      
      public function specialChallengeClosed() : void
      {
         this.unlockMap();
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
      
      public function newMissionCreated() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(screensM.screenBlack.isActive())
         {
            screensM.screenBlack.unBlockOpeningScreen();
            this.enterNewMission();
         }
         else if(dataM.useHiddenBaseMap)
         {
            screensM.screenBlack.activateBlackScreen(null,true,true,null,0,true,this.enterNewMission);
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.enterNewMission,true,true,null,0);
         }
      }
      
      public function enterNewMission() : void
      {
         screensM.screenTransitionsManager.removeCurrentScreen();
         screensM.addScreen(BMScreensManager.SCR_MISSION_BASE_MAP);
         screensM.screenMissionBaseMap.refreshScreen(false);
         if(dataM.useHiddenBaseMap)
         {
            dataM.battleMechsPerPlayer = dataM.getCurrentMissionMechsPerPlayer();
            screensM.addBattleScreens();
         }
      }
      
      public function enterClanBossBattle() : void
      {
         if(dataM.myProfile.hasClanBossReward)
         {
            screensM.screenConfirmation.displayCustomMessage(getSpecificText("clanBoss_mustCollectClanCoins"),this.sendPlayerToClan);
            return;
         }
         var _loc1_:Boolean = false;
         var _loc2_:String = BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS;
         var _loc3_:String = BMSinglePlayerManager.ENEMY_TYPE_CLAN_BOSS;
         dataM.myProfile.clan_bossBattlesDoneToday += 1;
         var _loc4_:Boolean = BattleTypeResolver.shouldPvEBattleBeOnServer(BattleTypeResolver.ENV_CLAN_BOSS);
         dataM.singlePlayerM.startBattle_phase1(_loc2_,_loc3_,_loc1_,false,_loc4_);
      }
      
      public function refreshBattleCredits() : void
      {
      }
      
      private function addTauntBoss() : void
      {
         if(this._ignoreTauntBossAfterCompletingTutorial)
         {
            return;
         }
         this._tauntBossLocationID = dataM.singlePlayerM.getTauntBossLocationID(this.storyID);
         if(this._tauntBossLocationID == BMSinglePlayerManager.NO_LOCATION_ID)
         {
            return;
         }
         var _loc1_:BMWorldMapLocationData = this.getMissionDB(this._tauntBossLocationID);
         var _loc2_:BMWorldMapBossData = dataM.singlePlayerM.getMissionBossData(this.storyID,_loc1_.campaignID,_loc1_.bossID,0);
         this._tauntBossMechView = new BMMechView();
         var _loc3_:Number = 0.3;
         var _loc4_:uint = 0;
         if(_loc1_.chapterID == 7)
         {
            _loc3_ = 0.37;
            _loc4_ = 15;
         }
         this._tauntBossMechView.initialize(dataM.LOCAL_OPPONENT_ID,"battle",BMMechStructure.ITEM_TYPE_ITEM_ID,_loc3_,false);
         this._tauntBossMechView.buildMech(_loc2_.getBossMechStructure());
         this._tauntBossMechView.setMechHorizontalScale(-1);
         this._tauntBossMechView.x = _loc1_.xPos + 5;
         this._tauntBossMechView.y = _loc1_.yPos + 15 - (this._tauntBossMechView.mechSizer.height + this._tauntBossMechView.mechSizer.y) + _loc4_;
         this._tauntBossMechView.activateBreathing();
         this.mcMapContentHolder.addChild(this._tauntBossMechView);
      }
      
      private function refreshTauntBossTimerAndMech() : void
      {
         if(this._ignoreTauntBossAfterCompletingTutorial)
         {
            return;
         }
         this.refreshTauntBossMech();
      }
      
      private function refreshTauntBossMech() : void
      {
         if(this._tauntBossMechView == null)
         {
            return;
         }
         this._tauntBossMechView.onEnterFrameTrigger();
      }
      
      private function removeTauntBossMech() : void
      {
         if(this._tauntBossMechView == null)
         {
            return;
         }
         this._tauntBossMechView.removeMe();
         this._tauntBossMechView = null;
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
      
      private function get showClanBoss() : Boolean
      {
         if(dataM.myProfile.hasClanBoss == false && dataM.myProfile.hasClanBossPreview == false)
         {
            return false;
         }
         if(this.storyID != BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1)
         {
            return false;
         }
         return true;
      }
      
      private function get showClanBossPointer() : Boolean
      {
         if(this.showClanBoss == false)
         {
            return false;
         }
         if(dataM.myProfile.isClanBossAlive == false)
         {
            return false;
         }
         if(dataM.myProfile.clan_bossBattlesLeft == 0)
         {
            return false;
         }
         return true;
      }
      
      private function initClanBoss() : void
      {
         if(this.showClanBoss == false)
         {
            return;
         }
         var _loc1_:String = "worldMapClanBoss_locked";
         if(dataM.myProfile.isInClan && dataM.myProfile.clanHasEnoughBossTickets)
         {
            if(dataM.myProfile.isClanBossAlive)
            {
               _loc1_ = "worldMapClanBoss_completed";
            }
            else
            {
               _loc1_ = "worldMapClanBoss_available";
            }
         }
         this._clanBossMapObject = externalAssetsM.getAsset("general",_loc1_);
         this._clanBossMapObject.x = dataM.myProfile.clanBossData.xPos;
         this._clanBossMapObject.y = dataM.myProfile.clanBossData.yPos;
         this.mcMapObjectsHolder.addChild(this._clanBossMapObject);
         if(this.showClanBossPointer == false)
         {
            return;
         }
         this.mcClanBossPointer.initialize(this.clanBossPointerClicked);
         if(dataM.myProfile.isInClan && dataM.myProfile.clan_bossBattlesLeft > 0)
         {
            this.mcClanBossPointer.setCounter(dataM.myProfile.clan_bossBattlesLeft);
         }
         this.mcClanBossPointer.setEnemyAvatar(dataM.myProfile.clanBossData.battleAvatar,dataM.myProfile.clanBossData.colorID,dataM.myProfile.clanBossData.themeID);
         this.mcClanBossPointer.y = dataM.myProfile.clanBossData.yPos;
      }
      
      private function clanBossClicked() : void
      {
         if(this.isMapLocked())
         {
            return;
         }
         this.screenMissionDifficulty.hide();
         dataM.myProfile.setLastSelectedMissionSlotAndMode(this.storyID,BMSinglePlayerManager.CLAN_BOSS_MISSION_SLOT,0);
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_BOSS_MISSION_DETAILS))
         {
            screensM.screenClanBossMissionDetails.open();
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_CLAN_BOSS_MISSION_DETAILS);
         }
      }
      
      private function closeClanBossMissionDetails() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_BOSS_MISSION_DETAILS))
         {
            screensM.screenClanBossMissionDetails.close();
         }
      }
      
      public function manuallySelectBossMission() : void
      {
         if(this.showClanBoss == false)
         {
            return;
         }
         this.clanBossClicked();
         this.resetMapPositionToFocusedMission(true);
         this.refreshTilesVisibility();
         this.refreshMapObjects();
         this.bossDialogController.hideDialog();
      }
      
      private function clanBossPointerClicked() : void
      {
         this.manuallySelectBossMission();
      }
      
      private function clanBossPointerHandler() : void
      {
         if(this.showClanBossPointer == false)
         {
            return;
         }
         if(this.mcClanBossPointer == null)
         {
            return;
         }
         var _loc1_:Number = this.mcMapContentHolder.x + this._clanBossMapObject.x;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 70;
         if(_loc1_ < _loc4_ || _loc1_ > dataM.STAGE_WIDTH - _loc4_)
         {
            _loc3_ = true;
         }
         else
         {
            _loc2_ = true;
         }
         if(_loc3_)
         {
            if(_loc1_ < _loc4_)
            {
               this.mcClanBossPointer.x = _loc4_;
               this.mcClanBossPointer.setDirection(BMWorldMapLocationPointer.DIRECTION_LEFT);
            }
            else
            {
               this.mcClanBossPointer.x = dataM.STAGE_WIDTH - _loc4_;
               this.mcClanBossPointer.setDirection(BMWorldMapLocationPointer.DIRECTION_RIGHT);
            }
         }
         if(_loc3_)
         {
            this.mcClanBossPointer.showMe();
         }
         else if(_loc2_)
         {
            this.mcClanBossPointer.hideMe();
         }
      }
      
      public function clanBossInactive() : void
      {
         if(this._clanBossMapObject == null)
         {
            return;
         }
         this._clanBossMapObject.visible = false;
         if(this.mcClanBossPointer == null)
         {
            return;
         }
         this.mcClanBossPointer.parent.removeChild(this.mcClanBossPointer);
         this.mcClanBossPointer = null;
      }
      
      private function removeAllHarvestUIs() : void
      {
         var _loc2_:BMWorldMapHarvestUI = null;
         if(this._harvestUIs == null)
         {
            this._harvestUIs = new Array();
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._harvestUIs.length)
         {
            _loc2_ = this._harvestUIs[_loc1_];
            _loc2_.removeMe();
            _loc2_ = null;
            _loc1_++;
         }
         this._harvestUIs = new Array();
      }
      
      private function createHarvestingUI() : void
      {
         var _loc1_:BMWorldMapHarvestData = null;
         var _loc2_:BMWorldMapHarvestUI = null;
         var _loc3_:BMWorldMapLocationData = null;
         this.removeAllHarvestUIs();
         if(dataM.singlePlayerHarvestingData == null)
         {
            return;
         }
         for each(_loc1_ in dataM.singlePlayerHarvestingData)
         {
            if(dataM.singlePlayerM.didCompleteSlot(this.storyID,_loc1_.missionSlot,BMSinglePlayerManager.MISSION_MODE_NORMAL) != false)
            {
               if(dataM.myProfile.lastHarvestingDatesByMissionSlot[_loc1_.missionSlot] != null)
               {
                  _loc2_ = new BMWorldMapHarvestUI();
                  _loc2_.initialize(_loc1_.missionSlot,getSpecificText("quests_claim"));
                  this.activateHarvestTimer(_loc1_.missionSlot,_loc2_);
                  _loc3_ = this.getMissionDB(_loc1_.missionSlot);
                  _loc2_.x = _loc3_.xPos;
                  _loc2_.y = _loc3_.yPos - 76;
                  this.mcMapObjectsHolder.addChild(_loc2_);
                  this._harvestUIs.push(_loc2_);
               }
            }
         }
      }
      
      private function activateHarvestTimer(param1:uint, param2:BMWorldMapHarvestUI) : void
      {
         var _loc3_:BMWorldMapHarvestData = dataM.singlePlayerHarvestingData[param1];
         var _loc4_:BMWorldMapLocationData = this.getMissionDB(_loc3_.missionSlot);
         var _loc5_:Number = Number(dataM.myProfile.lastHarvestingDatesByMissionSlot[_loc3_.missionSlot]);
         var _loc6_:Number = _loc5_ + _loc3_.cooldown;
         var _loc7_:Number = 0;
         if(_loc6_ > dataM.currentTime)
         {
            _loc7_ = _loc6_ - dataM.currentTime;
         }
         param2.activateTimer(_loc3_.cooldown,_loc7_,this.tryToHarvestMission);
      }
      
      public function resetHarvestUI(param1:uint) : void
      {
         var _loc3_:BMWorldMapHarvestUI = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._harvestUIs.length)
         {
            _loc3_ = this._harvestUIs[_loc2_];
            if(_loc3_.missionSlot == param1)
            {
               this.activateHarvestTimer(param1,_loc3_);
               return;
            }
            _loc2_++;
         }
      }
      
      private function tryToHarvestMission(param1:int) : void
      {
         if(dataM.singlePlayerHarvestingData == null)
         {
            return;
         }
         if(dataM.singlePlayerHarvestingData[param1] == null)
         {
            return;
         }
         if(dataM.singlePlayerM.didCompleteSlot(this.storyID,param1,BMSinglePlayerManager.MISSION_MODE_NORMAL) == false)
         {
            return;
         }
         var _loc2_:Number = 0;
         if(dataM.myProfile.lastHarvestingDatesByMissionSlot[param1] != null)
         {
            _loc2_ = Number(dataM.myProfile.lastHarvestingDatesByMissionSlot[param1]);
         }
         var _loc3_:Number = dataM.currentTime - _loc2_;
         if(_loc3_ > dataM.singlePlayerHarvestingData[param1].cooldown)
         {
            remoteM.socketM.harvestMission(param1);
         }
      }
      
      private function initLockedChapterMessages() : void
      {
         var _loc2_:BMWorldMapLockedChapterMessage = null;
         var _loc3_:uint = 0;
         this._lockedChapters = new Array();
         var _loc1_:uint = 1;
         while(_loc1_ <= dataM.singlePlayerM.getTotalChapters(this.storyID))
         {
            if(dataM.singlePlayerM.isChapterLocked(this.storyID,_loc1_))
            {
               _loc2_ = new BMWorldMapLockedChapterMessage();
               _loc3_ = dataM.singlePlayerM.getChapterReleaseDate(this.storyID,_loc1_) + 2;
               _loc2_.initialize(getScreenText("chapterUnlocksIn"),_loc3_,this.chapterUnlocked);
               _loc2_.x = dataM.STAGE_WIDTH * (_loc1_ - 1) + (dataM.STAGE_WIDTH - _loc2_.width) / 2;
               _loc2_.y = (dataM.STAGE_HEIGHT - _loc2_.height) / 2;
               this.mcMapObjectsHolder.addChild(_loc2_);
               this._lockedChapters.push(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function chapterUnlocked() : void
      {
         this.refreshMapObjects();
         this.removeAllLockedChapterMessages();
         this.initLockedChapterMessages();
      }
      
      private function removeAllLockedChapterMessages() : void
      {
         var _loc2_:BMWorldMapLockedChapterMessage = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._lockedChapters.length)
         {
            _loc2_ = this._lockedChapters[_loc1_];
            _loc2_.removeMe();
            _loc2_ = null;
            this._lockedChapters[_loc1_] = null;
            _loc1_++;
         }
         this._lockedChapters = new Array();
      }
      
      private function showBoostRecommendation() : void
      {
         dataM.mechBoostRecommender.showBoostRecommendation(this.boostRecommendationAccepted);
      }
      
      private function boostRecommendationAccepted(param1:uint) : void
      {
         dataM.mechBoostRecommender.setActiveRecommendation(param1,BMMechBoostRecommender.ORIGIN_CAMPAIGN);
         this.backClicked(true);
      }
      
      public function createNukeAnimationAndGiveRewards(param1:uint, param2:Object) : void
      {
         var _loc5_:Number = NaN;
         this._nukeReward = param2;
         this.lockMap();
         this.screenMissionDifficulty.hide();
         var _loc3_:BMWorldMapLocationData = this.getMissionDB(param1);
         if(this._nukeExplosionHolder == null)
         {
            _loc5_ = 0.3;
            this._nukeExplosionHolder = new MovieClip();
            this._nukeExplosionHolder.scaleX = _loc5_;
            this._nukeExplosionHolder.scaleY = _loc5_;
            this.mcMapContentHolder.addChild(this._nukeExplosionHolder);
         }
         this._nukeExplosionHolder.x = _loc3_.xPos;
         this._nukeExplosionHolder.y = _loc3_.yPos;
         if(this._nukeRocket == null)
         {
            this._nukeRocket = externalAssetsM.getAsset("general","rocket2_new");
            this._nukeRocket.scaleX = 1.2;
            this._nukeRocket.scaleY = 1.2;
            this._nukeRocket.rotation = 90;
            this.mcMapContentHolder.addChild(this._nukeRocket);
         }
         this._nukeRocket.visible = true;
         this._nukeRocket.x = _loc3_.xPos;
         this._nukeRocket.y = _loc3_.yPos - 500;
         var _loc4_:Number = _loc3_.yPos - 20;
         TweenMax.to(this._nukeRocket,1,{
            "y":_loc4_,
            "ease":Linear.easeNone,
            "onComplete":this.nukeRocketAnimatioCompleted
         });
         soundM.createSound("fireRocket2",1);
      }
      
      private function nukeRocketAnimatioCompleted() : void
      {
         this._nukeRocket.visible = false;
         soundM.createSound("heatBombBlast",1);
         effectsM.createHeatBombExplosion(0,0,"red",this._nukeExplosionHolder);
         TweenMax.delayedCall(1,this.nukeExplosionAnimationEnded);
      }
      
      private function nukeExplosionAnimationEnded() : void
      {
         dataM.missionCompletedSuccess(this.storyID,null,this._nukeReward);
         this.unlockMap();
      }
      
      private function initMiniChat() : void
      {
         if(dataM.chatData.useCampaignChat)
         {
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
      
      public function backClicked(param1:Boolean = false) : void
      {
         if(this.isMapLocked())
         {
            return;
         }
         if(this.screenMissionDifficulty.isOpen)
         {
            this.screenMissionDifficulty.backClicked();
            return;
         }
         dataM.singlePlayerM.finishMissionForFirstTime = false;
         if(param1)
         {
            screensM.screenTransitionsManager.upgrade();
         }
         else
         {
            screensM.screenTransitionsManager.mainMenu();
         }
      }
      
      public function removeMe() : void
      {
         var _loc1_:uint = 0;
         TweenMax.killAll();
         dataM.singlePlayerM.finishMissionForFirstTime = false;
         screensM.removeScreen(BMScreensManager.SCR_REGISTER_OFFER);
         screensM.removeScreen(BMScreensManager.SCR_CLAN_BOSS_MISSION_DETAILS);
         BMSpecialOffersManager.gi().removeSpecialOffer();
         tooltip.hideToolTip();
         this.removeTauntBossMech();
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
         _loc1_ = 0;
         while(_loc1_ < this._missionStars.length)
         {
            if(this._missionStars[_loc1_] != null)
            {
               if(this._missionStars[_loc1_].parent != null)
               {
                  this._missionStars[_loc1_].parent.removeChild(this._missionStars[_loc1_]);
               }
               this._missionStars[_loc1_] = null;
            }
            _loc1_++;
         }
         this._missionStars = new Array();
         this.deactivateTutorialArrows();
         this.removeAllLockedChapterMessages();
         screensM.removeScreen(BMScreensManager.SCR_MISSION_WORLD_MAP);
         this.bossDialogController.removeMe();
      }
      
      public function onQuestsDataUpdated() : void
      {
         if(!tutorialM.isTutorialActive())
         {
            this.mcQuestCompleted.visible = dataM.questsManager.getNumOfCompletedAll() > 0;
         }
         else
         {
            this.mcQuestCompleted.visible = false;
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.onQuestsDataUpdated();
      }
   }
}

