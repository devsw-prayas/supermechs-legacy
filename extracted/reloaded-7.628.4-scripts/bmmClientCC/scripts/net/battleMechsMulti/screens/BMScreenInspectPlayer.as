package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMClanData;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerRankingListData;
   import net.battleMechsMulti.mobiles.BMReplayData;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_arrowLeft;
   import net.battleMechsMulti.mobiles.buttons.BMButton_arrowRight;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1587")]
   public class BMScreenInspectPlayer extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_rank:Sprite;
      
      public var mcSizer_mech:Sprite;
      
      public var mcSizer_btnPreviousMech:Sprite;
      
      public var mcSizer_btnNextMech:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnMechs:Sprite;
      
      public var mcSizer_btnReplays:Sprite;
      
      public var mcSizer_btnAchievements:Sprite;
      
      public var mcSizer_btnClan:Sprite;
      
      public var mcSizer_btnDown:Sprite;
      
      public var mcSizer_btnUp:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcSizer_playerMedals:Sprite;
      
      public var mcSizer_clanMedals:Sprite;
      
      public var mcSizer_clanFlag:Sprite;
      
      public var btnPreviousMech:BMButton_arrowLeft;
      
      public var btnNextMech:BMButton_arrowRight;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnMechs:BMButton_pictureE;
      
      public var btnReplays:BMButton_pictureE;
      
      public var btnAchievements:BMButton_pictureE;
      
      public var btnClan:BMButton_pictureE;
      
      public var btnDown:BMButton_pictureE;
      
      public var btnUp:BMButton_pictureE;
      
      public var mcButtonMarker:Sprite;
      
      public var mcBlackScreen:MovieClip;
      
      public var mcPlayerMedalsTooltip:Sprite;
      
      public var mcClanMedalsTooltip:Sprite;
      
      public var txtName:TextField;
      
      public var txtOnline:TextField;
      
      public var txtOffline:TextField;
      
      public var txtNoReplays:TextField;
      
      public var txtInfo:TextField;
      
      public var txtClanMedals:TextField;
      
      public var txtPlayerTag:TextField;
      
      public var mcSandClock:MovieClip;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcTextBackground:MovieClip;
      
      private var mcClanFlag:BMClanFlag;
      
      private var rankIcon:MovieClip;
      
      private var mechIcon:BMItem;
      
      public var currentPlayerClanID:Number = 0;
      
      private var generalTileList:BMTileList;
      
      private var _selectedReplayID:Number;
      
      private var _playerMedals:Array = new Array();
      
      private var _playerMedalsBMD:BitmapData;
      
      private var _playerMedalsBM:Bitmap;
      
      private var _clanMedals:Array = new Array();
      
      private var _clanMedalsBMD:BitmapData;
      
      private var _clanMedalsBM:Bitmap;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _sparks:Array = new Array();
      
      private var mechView:BMMechView;
      
      private var drone:BMItem;
      
      private var _droneTargetXPos:Number;
      
      private var _droneTargetYPos:Number;
      
      private var _droneMoving:Boolean;
      
      private var _droneStopCooldown:Number;
      
      private var _playerTagOriginYPos:Number;
      
      private var _allowViewReplays:Boolean;
      
      private var _firstRefresh:Boolean = true;
      
      private const REPLAY_ROWS:uint = 6;
      
      private const REPLAY_ROW_WIDTH:uint = 442;
      
      private const REPLAY_ROW_HEIGHT:uint = 50;
      
      private const REPLAY_ROWS_MOBILE:uint = 5;
      
      private const REPLAY_ROW_WIDTH_MOBILE:uint = 482;
      
      private const REPLAY_ROW_HEIGHT_MOBILE:uint = 53;
      
      private const ACHIEVMENT_ROWS:uint = 5;
      
      private const ACHIEVMENT_ROW_WIDTH:uint = 442;
      
      private const ACHIEVMENT_ROW_HEIGHT:uint = 60;
      
      private const ACHIEVMENT_ROWS_MOBILE:uint = 4;
      
      private const ACHIEVMENT_ROW_WIDTH_MOBILE:uint = 482;
      
      private const ACHIEVMENT_ROW_HEIGHT_MOBILE:uint = 69;
      
      private const CLAN_ROWS:uint = 5;
      
      private const CLAN_ROW_WIDTH:uint = 442;
      
      private const CLAN_ROW_HEIGHT:uint = 32;
      
      private const CLAN_ROWS_MOBILE:uint = 4;
      
      private const CLAN_ROW_WIDTH_MOBILE:uint = 482;
      
      private const CLAN_ROW_HEIGHT_MOBILE:uint = 34;
      
      private const DRONE_ORIGIN_X_POS:uint = 340;
      
      private const DRONE_ORIGIN_Y_POS:uint = 165;
      
      private const MECH_SCALE:Number = 0.65;
      
      public function BMScreenInspectPlayer()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("inspectPlayer");
      }
      
      public function refreshScreenWithLastData() : void
      {
         this.refreshScreen(dataM.inspectPlayer_playerID,dataM.inspectPlayer_outsideRankingList,dataM.inspectPlayer_name,dataM.inspectPlayer_level,dataM.inspectPlayer_ladderProgress,dataM.inspectPlayer_clanID,"replays");
      }
      
      public function refreshScreen(param1:Number, param2:Boolean, param3:String, param4:Number, param5:Number, param6:Number, param7:String = "", param8:Boolean = true) : void
      {
         var _loc9_:Function = null;
         var _loc10_:Function = null;
         var _loc11_:Function = null;
         var _loc12_:Function = null;
         var _loc13_:Function = null;
         var _loc14_:Function = null;
         var _loc15_:Function = null;
         var _loc16_:Function = null;
         var _loc17_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_INSPECT_PLAYER,"btnPreviousMech","arrowLeft");
            screensM.createButtonFromSizer(BMScreensManager.SCR_INSPECT_PLAYER,"btnNextMech","arrowRight");
            screensM.createButtonFromSizer(BMScreensManager.SCR_INSPECT_PLAYER,"btnBack","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_INSPECT_PLAYER,"btnMechs","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_INSPECT_PLAYER,"btnReplays","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_INSPECT_PLAYER,"btnAchievements","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_INSPECT_PLAYER,"btnClan","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_INSPECT_PLAYER,"btnDown","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_INSPECT_PLAYER,"btnUp","pictureE");
            _loc9_ = this.backClicked;
            _loc10_ = this.mechsClicked;
            _loc11_ = this.replaysClicked;
            _loc12_ = this.achievementsClicked;
            _loc13_ = this.clanClicked;
            _loc14_ = this.previousMechClicked;
            _loc15_ = this.nextMechClicked;
            _loc16_ = this.downClicked;
            _loc17_ = this.upClicked;
            if(dataM.runAsMobile)
            {
               _loc9_ = null;
               _loc10_ = null;
               _loc11_ = null;
               _loc12_ = null;
               _loc13_ = null;
               _loc14_ = null;
               _loc15_ = null;
               _loc16_ = null;
               _loc17_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc9_,dataM.runAsMobile);
            this.btnMechs.initialize("","",externalAssetsM.getAsset("general","interface_mech"),null,_loc10_,dataM.runAsMobile);
            this.btnReplays.initialize("","",externalAssetsM.getAsset("general","interface_replays"),null,_loc11_,dataM.runAsMobile);
            this.btnAchievements.initialize("","",externalAssetsM.getAsset("general","interface_achievements"),null,_loc12_,dataM.runAsMobile);
            this.btnClan.initialize("","",externalAssetsM.getAsset("general","interface_clan"),null,_loc13_,dataM.runAsMobile);
            this.btnPreviousMech.initialize("","",null,null,_loc14_,dataM.runAsMobile);
            this.btnNextMech.initialize("","",null,null,_loc15_,dataM.runAsMobile);
            this.btnDown.initialize("","",externalAssetsM.getAsset("general","interface_arrowDown"),null,_loc16_,dataM.runAsMobile);
            this.btnUp.initialize("","",externalAssetsM.getAsset("general","interface_arrowUp"),null,_loc17_,dataM.runAsMobile);
            if(dataM.runAsMobile == false)
            {
               this.btnMechs.buttonCore.addMouseOverListerner(this.mechsMouseOver);
               this.btnMechs.buttonCore.addMouseOutListerner(this.buttonMouseOut);
               this.btnReplays.buttonCore.addMouseOverListerner(this.replaysMouseOver);
               this.btnReplays.buttonCore.addMouseOutListerner(this.buttonMouseOut);
               this.btnAchievements.buttonCore.addMouseOverListerner(this.achievementsMouseOver);
               this.btnAchievements.buttonCore.addMouseOutListerner(this.buttonMouseOut);
               this.btnClan.buttonCore.addMouseOverListerner(this.clanMouseOver);
               this.btnClan.buttonCore.addMouseOutListerner(this.buttonMouseOut);
               this.btnNextMech.buttonCore.addMouseOverListerner(this.nextMechButtonMouseOver);
               this.btnNextMech.buttonCore.addMouseOutListerner(this.buttonMouseOut);
               this.btnPreviousMech.buttonCore.addMouseOverListerner(this.previousMechButtonMouseOver);
               this.btnPreviousMech.buttonCore.addMouseOutListerner(this.buttonMouseOut);
            }
            this.btnMechs.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnReplays.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnAchievements.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnClan.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnDown.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnUp.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnNextMech.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPreviousMech.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            updateTextAndFormat(this.txtOnline,getScreenText("online"));
            updateTextAndFormat(this.txtOffline,getScreenText("offline"));
            updateTextAndFormat(this.txtNoReplays,getSpecificText("replays_noReplays"));
            this.mcSandClock.mouseEnabled = false;
            this.mcSandClock.mouseChildren = false;
            if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_MENU))
            {
               this.btnClan.disableMe();
            }
            if(dataM.runAsMobile == false)
            {
               this.mcPlayerMedalsTooltip.addEventListener(MouseEvent.MOUSE_OVER,this.playerMedalsTooltipMouseOver);
               this.mcPlayerMedalsTooltip.addEventListener(MouseEvent.MOUSE_OUT,this.generalTooltipMouseOut);
               this.mcClanMedalsTooltip.addEventListener(MouseEvent.MOUSE_OVER,this.clanMedalsTooltipMouseOver);
               this.mcClanMedalsTooltip.addEventListener(MouseEvent.MOUSE_OUT,this.generalTooltipMouseOut);
            }
            if(dataM.runAsMobile)
            {
               this._fingerWheeling = new BMFingerWheeling();
               this._fingerWheeling.initialize("inspectPlayer",this.generalTileList,this.mcFingerWheeling,this.tileListItemClicked,null,false);
               addChild(this._fingerWheeling);
            }
            else
            {
               this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
               this.mcFingerWheeling = null;
            }
            this._playerTagOriginYPos = this.txtPlayerTag.y;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         if(dataM.inspectPlayer_playerID != param1)
         {
            dataM.inspectPlayer_activeMechIDs = new Array();
            dataM.inspectPlayer_currentMechSlot = 0;
            dataM.inspectPlayer_currentMechID = 1;
         }
         dataM.inspectPlayer_playerID = param1;
         dataM.inspectPlayer_outsideRankingList = param2;
         dataM.inspectPlayer_name = param3;
         dataM.inspectPlayer_level = param4;
         dataM.inspectPlayer_ladderProgress = param5;
         dataM.inspectPlayer_clanID = param6;
         dataM.inspectPlayer_playerID = param1;
         dataM.inspectPlayer_outsideRankingList = param2;
         dataM.inspectPlayer_name = param3;
         dataM.inspectPlayer_level = param4;
         dataM.inspectPlayer_ladderProgress = param5;
         updateTextAndFormat(this.txtClanMedals,getScreenText("medals"));
         this.currentPlayerClanID = param6;
         this.refreshPlayerStats();
         dataM.createProfile(dataM.INSPECT_PLAYER_ID,"",0);
         this.refreshPlayerMedals();
         if(dataM.inspectPlayer_outsideRankingList)
         {
            this.btnDown.visible = false;
            this.btnUp.visible = false;
         }
         else
         {
            this.btnDown.visible = true;
            this.btnUp.visible = true;
         }
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.addMouseListeners();
         }
         if(param7 == "")
         {
            this.tabClicked("mechs",true);
         }
         else
         {
            this.removeClanFlag();
            this.tabClicked(param7,true);
         }
         this._allowViewReplays = param8;
         if(!param8)
         {
            this.btnReplays.disableMe();
         }
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         this.sparksHandler();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.onEnterFrameTrigger();
         }
         if(this.mechView != null)
         {
            this.mechView.onEnterFrameTrigger();
         }
         this.droneMovememntHandler();
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      private function refreshCurrentTab() : void
      {
         if(dataM.inspectPlayer_lastTab != dataM.inspectPlayer_selectedTab)
         {
            this.removeClanFlag();
            this.removeClanMedals();
            switch(dataM.inspectPlayer_lastTab)
            {
               case "":
                  this.btnNextMech.visible = false;
                  this.btnPreviousMech.visible = false;
                  this.mcBlackScreen.visible = false;
                  this.txtNoReplays.visible = false;
                  this.txtInfo.visible = false;
                  this.txtClanMedals.visible = false;
                  break;
               case "mechs":
                  this.removeMech();
                  this.btnNextMech.visible = false;
                  this.btnPreviousMech.visible = false;
                  this.mcBlackScreen.visible = false;
                  break;
               case "replays":
                  if(this.generalTileList != null)
                  {
                     this.generalTileList.removeMe();
                     this.generalTileList = null;
                     if(dataM.runAsMobile)
                     {
                        this._fingerWheeling.resetTileList(null);
                     }
                  }
                  this.txtNoReplays.visible = false;
                  break;
               case "achievements":
                  this.txtInfo.visible = false;
                  this.txtClanMedals.visible = false;
                  this.txtNoReplays.visible = false;
                  if(this.generalTileList != null)
                  {
                     this.generalTileList.removeMe();
                     this.generalTileList = null;
                     if(dataM.runAsMobile)
                     {
                        this._fingerWheeling.resetTileList(null);
                     }
                  }
                  break;
               case "clan":
                  if(this.generalTileList != null)
                  {
                     this.generalTileList.removeMe();
                     this.generalTileList = null;
                     if(dataM.runAsMobile)
                     {
                        this._fingerWheeling.resetTileList(null);
                     }
                  }
                  this.txtInfo.visible = false;
                  this.txtClanMedals.visible = false;
            }
         }
         switch(dataM.inspectPlayer_selectedTab)
         {
            case "mechs":
               this.setButtonMarker(this.btnMechs);
               this.refreshMechsTab();
               this.mcTextBackground.gotoAndStop("empty");
               break;
            case "replays":
               this.setButtonMarker(this.btnReplays);
               this._selectedReplayID = -1;
               this.refreshReplayTileList();
               this.mcTextBackground.gotoAndStop("empty");
               break;
            case "achievements":
               this.setButtonMarker(this.btnAchievements);
               if(dataM.inspectPlayersStatistics[dataM.inspectPlayer_playerID] == null)
               {
                  remoteM.socketM.lobby_getAchievementStatistic(dataM.inspectPlayer_playerID);
                  this.mcSandClock.gotoAndStop("animOn");
                  this.createTextsBitmapForMobile();
                  this.disableAllNavigationButtons();
               }
               else
               {
                  this.displayAchievements();
               }
               if(dataM.runAsMobile)
               {
                  this.mcTextBackground.gotoAndStop("achievements_mobile");
               }
               else
               {
                  this.mcTextBackground.gotoAndStop("achievements");
               }
               break;
            case "clan":
               this.setButtonMarker(this.btnClan);
               if(dataM.GetInspectClanData(this.currentPlayerClanID) == null)
               {
                  remoteM.socketM.clan_getClanData(this.currentPlayerClanID);
                  this.createTextsBitmapForMobile();
                  this.disableAllNavigationButtons();
               }
               else
               {
                  this.displayClan();
               }
               if(dataM.runAsMobile)
               {
                  this.mcTextBackground.gotoAndStop("clan_mobile");
               }
               else
               {
                  this.mcTextBackground.gotoAndStop("clan");
               }
         }
      }
      
      private function getTargetRankingList() : Object
      {
         var _loc1_:Object = null;
         switch(screensM.screenRankingList.getRankingType())
         {
            case "playersWeekly":
               _loc1_ = dataM.rankingList_weekly;
               break;
            case "playersOnline":
               _loc1_ = dataM.rankingList_online;
         }
         return _loc1_;
      }
      
      private function refreshPlayerStats() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:BMPlayerRankingListData = null;
         this.mcSandClock.gotoAndStop("animOff");
         if(dataM.inspectPlayer_playerID > 0)
         {
            _loc5_ = false;
            if(dataM.inspectPlayer_outsideRankingList)
            {
               _loc3_ = dataM.inspectPlayer_name;
               _loc1_ = dataM.inspectPlayer_level;
               _loc2_ = dataM.inspectPlayer_ladderProgress;
               _loc5_ = true;
            }
            else
            {
               _loc8_ = this.getTargetRankingList()[dataM.inspectPlayer_playerID];
               _loc3_ = _loc8_.playerName;
               _loc1_ = _loc8_.level;
               _loc2_ = _loc8_.ladderProgress;
               _loc5_ = _loc8_.isOnline;
            }
            if(dataM.specialUser)
            {
               _loc3_ = dataM.inspectPlayer_playerID + " " + _loc3_;
            }
            updateTextAndFormat(this.txtName,_loc3_);
            _loc6_ = String(dataM.inspectPlayer_playerID);
            updateTextAndFormat(this.txtPlayerTag,_loc3_ + "-" + _loc6_.substr(_loc6_.length - 4,4));
            this.txtPlayerTag.y = this._playerTagOriginYPos;
            if(this.txtPlayerTag.numLines == 1)
            {
               this.txtPlayerTag.y += 6;
            }
            if(this.rankIcon != null)
            {
               this.mcIconsHolder.removeChild(this.rankIcon);
               this.rankIcon = null;
            }
            _loc7_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc2_));
            this.rankIcon = externalAssetsM.getAsset("general","Grp_rank" + _loc7_,this.mcSizer_rank.width,this.mcSizer_rank.height,false,false);
            this.rankIcon.x = this.mcSizer_rank.x;
            this.rankIcon.y = this.mcSizer_rank.y;
            this.mcIconsHolder.addChild(this.rankIcon);
            this.btnBack.enableMe();
            if(_loc5_)
            {
               this.txtOnline.visible = true;
               this.txtOffline.visible = false;
            }
            else
            {
               this.txtOnline.visible = false;
               this.txtOffline.visible = true;
            }
         }
      }
      
      private function refreshMechsTab() : void
      {
         var _loc1_:uint = 0;
         this.disableAllNavigationButtons();
         if(dataM.inspectPlayerData[dataM.inspectPlayer_playerID] == null)
         {
            remoteM.lobby_getPlayerMechs(dataM.inspectPlayer_playerID);
            this.removeMech();
            this.mcBlackScreen.gotoAndStop("animOff");
         }
         else
         {
            this.mcBlackScreen.visible = true;
            dataM.inspectPlayer_activeMechIDs = new Array();
            if(dataM.inspectPlayerData[dataM.inspectPlayer_playerID].activeMechIDs != null)
            {
               _loc1_ = 0;
               while(_loc1_ < dataM.inspectPlayerData[dataM.inspectPlayer_playerID].activeMechIDs.length)
               {
                  dataM.inspectPlayer_activeMechIDs.push(dataM.inspectPlayerData[dataM.inspectPlayer_playerID].activeMechIDs[_loc1_]);
                  _loc1_++;
               }
            }
            if(dataM.inspectPlayer_activeMechIDs.length > 0)
            {
               dataM.inspectPlayer_currentMechID = dataM.inspectPlayer_activeMechIDs[0];
            }
            this.displayPlayerMech();
            this.enableAllNavigationButtons();
            this.refreshToggleMechsButtons();
            this.createTextsBitmapForMobile();
         }
      }
      
      public function mechsLoaded(param1:Object) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:BMItemData = null;
         var _loc2_:Array = new Array();
         for each(_loc4_ in param1)
         {
            _loc3_ = uint(_loc4_.equipped);
            if(_loc3_ >= 1)
            {
               _loc5_ = dataM.itemsDB[_loc4_.itemID];
               _loc4_.type = _loc5_.type;
               _loc4_.equipmentID = 0;
               if(_loc4_.colorID == 0)
               {
                  _loc4_.colorID = dataM.getItemColorByLevel(_loc5_.specialStatus,_loc5_.displayLevel,_loc5_.type);
               }
               switch(_loc5_.type)
               {
                  case "sideWeapon":
                  case "topWeapon":
                  case "kit":
                  case "module":
                     if(_loc4_.slotName != "")
                     {
                        _loc4_.equipmentID = int(_loc4_.slotName.substr(_loc4_.slotName.length - 1,1));
                     }
               }
               switch(_loc5_.type)
               {
                  case "torso":
                  case "leg":
                  case "sideWeapon":
                  case "topWeapon":
                     if(_loc2_[_loc3_] == null)
                     {
                        _loc2_[_loc3_] = new Object();
                        _loc2_[_loc3_].torso = false;
                        _loc2_[_loc3_].leg = false;
                        _loc2_[_loc3_].weapon = false;
                     }
                     switch(_loc5_.type)
                     {
                        case "torso":
                           _loc2_[_loc3_].torso = true;
                           break;
                        case "leg":
                           _loc2_[_loc3_].leg = true;
                           break;
                        case "sideWeapon":
                        case "topWeapon":
                           _loc2_[_loc3_].weapon = true;
                     }
               }
            }
            else
            {
               TsLogger.log("ERROR - screenInspectPlayer - item data equipped = 0");
            }
         }
         dataM.inspectPlayerData[dataM.inspectPlayer_playerID] = new Object();
         dataM.inspectPlayerData[dataM.inspectPlayer_playerID].inventory = param1;
         dataM.inspectPlayerData[dataM.inspectPlayer_playerID].mechStructures = new Array();
         dataM.inspectPlayerData[dataM.inspectPlayer_playerID].activeMechIDs = new Array();
         _loc3_ = 1;
         while(_loc3_ <= dataM.battleMaxMechs)
         {
            dataM.inspectPlayerData[dataM.inspectPlayer_playerID].mechStructures[_loc3_] = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
            if(_loc2_[_loc3_] != null)
            {
               if(Boolean(_loc2_[_loc3_].torso) && Boolean(_loc2_[_loc3_].leg) && Boolean(_loc2_[_loc3_].weapon))
               {
                  dataM.inspectPlayerData[dataM.inspectPlayer_playerID].activeMechIDs.push(_loc3_);
               }
            }
            _loc3_++;
         }
         dataM.inspectPlayer_activeMechIDs = dataM.inspectPlayerData[dataM.inspectPlayer_playerID].activeMechIDs;
         if(dataM.inspectPlayer_activeMechIDs.length > 0)
         {
            dataM.inspectPlayer_currentMechID = dataM.inspectPlayer_activeMechIDs[0];
         }
         this.refreshMechsTab();
      }
      
      private function displayPlayerMech() : void
      {
         var _loc4_:Object = null;
         var _loc1_:Object = dataM.inspectPlayerData[dataM.inspectPlayer_playerID].inventory;
         var _loc2_:Object = dataM.inspectPlayerData[dataM.inspectPlayer_playerID].mechs;
         dataM["playerData" + dataM.INSPECT_PLAYER_ID + "Inventory"] = new Array();
         var _loc3_:Array = dataM["playerData" + dataM.INSPECT_PLAYER_ID + "Inventory"];
         for each(_loc4_ in _loc1_)
         {
            _loc3_[_loc4_.playerItemID] = _loc4_;
         }
         dataM.createPlayerData(dataM.INSPECT_PLAYER_ID,"screenInspectPlayer - displayPlayerMech");
         this.removeMech();
         this.addMech();
         if(this.mcBlackScreen.currentLabel != "animOff")
         {
            this.mcBlackScreen.gotoAndStop("animOff");
         }
         this.mcBlackScreen.gotoAndStop("animOn");
      }
      
      private function removeMech() : void
      {
         if(this.mechView != null)
         {
            this.mechView.deactivateBreathing();
            this.mechView.removeMe();
         }
         if(this.drone != null)
         {
            this.drone.removeMe();
            this.drone = null;
         }
      }
      
      private function addMech() : void
      {
         this.mechView = new BMMechView();
         this.mechView.initialize(dataM.INSPECT_PLAYER_ID,"hanger",BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,this.MECH_SCALE,false);
         var _loc1_:BMPlayerData = dataM.playersData[dataM.INSPECT_PLAYER_ID];
         var _loc2_:BMMechStructure = _loc1_.mechStructures[dataM.inspectPlayer_currentMechID];
         this.mechView.buildMech(_loc2_,this.buildMechSub);
      }
      
      private function buildMechSub() : void
      {
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:Number = NaN;
         var _loc7_:BMItemData = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Array = null;
         var _loc1_:BMPlayerData = dataM.playersData[dataM.INSPECT_PLAYER_ID];
         var _loc2_:BMMechStructure = _loc1_.mechStructures[dataM.inspectPlayer_currentMechID];
         this.mechView.activateBreathing();
         if(_loc2_.drone > 0)
         {
            this.drone = new BMItem();
            _loc5_ = dataM.getPlayerItemData(dataM.INSPECT_PLAYER_ID,_loc2_.drone);
            _loc6_ = _loc5_.itemID;
            _loc7_ = dataM.itemsDB[_loc6_];
            _loc8_ = externalAssetsM.getAsset("items1",_loc7_.grp,0,0,false,true);
            _loc9_ = [this.drone,_loc5_.colorID];
            if(_loc8_.loading)
            {
               externalAssetsM.modifyExternalAssetDuplicationContainer(_loc8_,false,0,this.droneGrpLoaded,_loc9_);
            }
            else
            {
               this.droneGrpLoaded(_loc8_,_loc9_);
            }
            this.drone.initialize(0,0,0,_loc8_,0,0,true,null,dataM.runAsMobile);
         }
         var _loc3_:Number = this.mcSizer_mech.x + this.mcSizer_mech.width / 2;
         var _loc4_:Number = this.mcSizer_mech.y + this.mcSizer_mech.height - (this.mechView.mechSizer.height + this.mechView.mechSizer.y);
         if(this.mechView.mechSizer.height < this.mcSizer_mech.height)
         {
            _loc4_ -= (this.mcSizer_mech.height - this.mechView.mechSizer.height) / 2;
         }
         this.mechView.x = _loc3_;
         this.mechView.y = _loc4_;
         this.mcIconsHolder.addChild(this.mechView);
      }
      
      private function droneGrpLoaded(param1:MovieClip, param2:Array) : void
      {
         var _loc3_:BMItem = param2[0];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Number = Number(param2[1]);
         _loc3_.itemGrp = param1;
         dataM.colorItem(_loc3_,_loc4_);
         param1.scaleX = this.MECH_SCALE;
         param1.scaleY = this.MECH_SCALE;
         _loc3_.x = this.DRONE_ORIGIN_X_POS;
         _loc3_.y = this.DRONE_ORIGIN_Y_POS;
         this.resetDroneMovement();
         addChild(_loc3_);
      }
      
      private function addItemToMechStructure(param1:BMMechStructure, param2:Object, param3:Object, param4:String) : BMMechStructure
      {
         if(param2[param4] > 0)
         {
            param1[param4] = param3[param2[param4]];
         }
         return param1;
      }
      
      private function resetDroneMovement() : void
      {
         this._droneTargetXPos = this.DRONE_ORIGIN_X_POS + Math.random() * 30 - 15;
         this._droneTargetYPos = this.DRONE_ORIGIN_Y_POS + Math.random() * 70 - 35;
         this._droneMoving = true;
      }
      
      private function droneMovememntHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this.drone == null)
         {
            return;
         }
         if(this._droneMoving)
         {
            _loc1_ = this._droneTargetXPos - this.drone.x;
            _loc2_ = this._droneTargetYPos - this.drone.y;
            this.drone.x += _loc1_ * 0.05;
            this.drone.y += _loc2_ * 0.05;
            if(Math.abs(this.drone.y - this._droneTargetYPos) < 1)
            {
               this._droneMoving = false;
               this._droneStopCooldown = Math.ceil(Math.random() * 100) + 50;
            }
            return;
         }
         if(this._droneStopCooldown > 0)
         {
            --this._droneStopCooldown;
         }
         else
         {
            this.resetDroneMovement();
         }
      }
      
      public function gotOnlinePlayerReplays() : void
      {
         this.mcSandClock.gotoAndStop("animOff");
         this._selectedReplayID = -1;
         this.refreshReplayTileList();
         this.enableAllNavigationButtons();
      }
      
      public function refreshReplayTileList() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Number = NaN;
         var _loc3_:Array = null;
         var _loc4_:BMReplayData = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:String = null;
         var _loc11_:uint = 0;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Sprite = null;
         var _loc15_:BMItem = null;
         var _loc16_:BMTileListItem = null;
         var _loc17_:Function = null;
         var _loc18_:MovieClip = null;
         var _loc19_:MovieClip = null;
         var _loc20_:MovieClip = null;
         var _loc21_:Boolean = false;
         var _loc22_:Number = NaN;
         if(dataM.replayInspectedPlayerIDs[dataM.inspectPlayer_playerID] == null)
         {
            this.txtNoReplays.visible = false;
            if(this.generalTileList != null)
            {
               this.generalTileList.visible = false;
            }
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.resetTileList(null);
            }
            this.mcSandClock.gotoAndStop("animOn");
            remoteM.lobby_getPlayerReplays(dataM.inspectPlayer_playerID);
            dataM.replayInspectedPlayerIDs[dataM.inspectPlayer_playerID] = true;
            this.disableAllNavigationButtons();
         }
         else
         {
            _loc1_ = new Array();
            _loc2_ = 0;
            _loc3_ = new Array();
            for each(_loc4_ in dataM.replaysDB_inspect)
            {
               if(_loc4_.playerID1 == dataM.inspectPlayer_playerID || _loc4_.playerID2 == dataM.inspectPlayer_playerID)
               {
                  if(_loc4_.quitPlayerID == 0 || _loc4_.quitPlayerID != 0 && _loc4_.numberOfTurns > 1)
                  {
                     _loc3_.push({"replayID":_loc4_.replayID});
                  }
               }
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
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc4_ = dataM.replaysDB_inspect[_loc3_[_loc8_].replayID];
               _loc2_++;
               if(dataM.runAsMobile)
               {
                  _loc9_ = new mcReplayList2Row_mobile();
               }
               else
               {
                  _loc9_ = new mcReplayList2Row();
               }
               if(_loc4_.playerName1 == this.txtName.text)
               {
                  _loc10_ = _loc2_ + " - VS " + dataM.getCensoredString(_loc4_.playerName2);
               }
               else if(_loc4_.playerName2 == this.txtName.text)
               {
                  _loc10_ = _loc2_ + " - VS " + dataM.getCensoredString(_loc4_.playerName1);
               }
               else
               {
                  _loc10_ = _loc2_ + " - " + dataM.getCensoredString(_loc4_.playerName1) + " VS " + dataM.getCensoredString(_loc4_.playerName2);
               }
               _loc11_ = 15;
               switch(dataM.languageID)
               {
                  case 7:
                     _loc11_ = 12;
               }
               updateTextAndFormat(_loc9_.txtDescription,_loc10_);
               updateTextAndFormat(_loc9_.txtTurns,String(_loc4_.numberOfTurns));
               _loc12_ = "1V1";
               if(_loc4_.battleMechsPerPlayer == 2)
               {
                  _loc12_ = "2V2";
               }
               else if(_loc4_.battleMechsPerPlayer == 3)
               {
                  _loc12_ = "3V3";
               }
               updateTextAndFormat(_loc9_.txtType,_loc12_);
               updateTextAndFormat(_loc9_.txtCode,BMScreenReplays.GetReplayIDHexCode(_loc4_.replayID));
               _loc13_ = getSpecificText("replays_win");
               if(_loc4_.wonPlayerID > 0)
               {
                  if(_loc4_.wonPlayerID != dataM.inspectPlayer_playerID)
                  {
                     _loc13_ = getSpecificText("replays_lose");
                  }
               }
               else if(_loc4_.quitPlayerID == dataM.inspectPlayer_playerID)
               {
                  _loc13_ = getSpecificText("replays_lose");
               }
               updateTextAndFormat(_loc9_.txtWinLoss,_loc13_);
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
                  _loc15_.createAssetsBitmap([_loc9_.txtDescription,_loc9_.txtTurns,_loc9_.txtType,_loc9_.txtWinLoss],null,_loc9_);
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
            if(this.generalTileList == null)
            {
               this.generalTileList = new BMTileList();
               _loc19_ = new Grp_scrollerContent();
               if(dataM.runAsMobile)
               {
                  _loc20_ = new mcReplayList2Header_mobile();
                  this.generalTileList.activateExtendedMode(0.75,true);
               }
               else
               {
                  _loc20_ = new mcReplayList2Header();
               }
               updateTextAndFormat(_loc20_.txtDescription,getSpecificText("replays_description"));
               updateTextAndFormat(_loc20_.txtTurns,getSpecificText("replays_turns"));
               updateTextAndFormat(_loc20_.txtType,getSpecificText("replays_type"));
               updateTextAndFormat(_loc20_.txtResult,getSpecificText("replays_result"));
               updateTextAndFormat(_loc20_.txtCode,getSpecificText("replays_codeCaps"));
               _loc21_ = false;
               if(dataM.runAsMobile)
               {
                  _loc21_ = true;
               }
               this.generalTileList.initialize(screensM.stagePointer.stage,_loc1_,_loc5_,1,_loc6_,_loc7_,null,true,_loc19_,null,_loc20_,false,0,1,true,_loc21_,dataM.runAsMobile);
               this.generalTileList.x = this.mcSizer_tileList.x;
               this.generalTileList.y = this.mcSizer_tileList.y;
               this.mcButtonsHolder.addChild(this.generalTileList);
            }
            else
            {
               _loc22_ = this.generalTileList.getCurrentRow();
               this.generalTileList.removeAllItems();
               this.generalTileList.addItems(0,_loc1_,true);
               this.generalTileList.jumpToRow(_loc22_,false,"screenInspectPlayer - refreshReplayTileList");
            }
            if(_loc1_.length == 0)
            {
               this.txtNoReplays.visible = true;
               this.generalTileList.visible = false;
               if(dataM.runAsMobile)
               {
                  this._fingerWheeling.resetTileList(null);
               }
            }
            else
            {
               this.txtNoReplays.visible = false;
               this.generalTileList.visible = true;
               if(dataM.runAsMobile)
               {
                  this._fingerWheeling.resetTileList(this.generalTileList);
               }
            }
         }
         this.createTextsBitmapForMobile();
      }
      
      private function tileListItemClicked(param1:Number, param2:Number) : void
      {
         var _loc3_:BMReplayData = null;
         var _loc4_:Number = NaN;
         var _loc5_:BMTileListItem = null;
         var _loc6_:Sprite = null;
         var _loc7_:MovieClip = null;
         if(param1 > -1)
         {
            switch(dataM.inspectPlayer_selectedTab)
            {
               case "replays":
                  this._selectedReplayID = param2;
                  _loc3_ = dataM.replaysDB_inspect[this._selectedReplayID];
                  if(_loc3_.watched == false)
                  {
                     _loc5_ = this.generalTileList.findTileListItemByTileListItemID(this._selectedReplayID);
                     _loc6_ = _loc5_.item.itemGrp.mcSizer_watched;
                     _loc7_ = externalAssetsM.getAsset("general","interface_V",_loc6_.width,_loc6_.height,false,false);
                     _loc7_.x = _loc6_.x;
                     _loc7_.y = _loc6_.y;
                     _loc5_.item.itemGrp.addChild(_loc7_);
                  }
                  this.tileListItemClickedSub();
                  soundM.createSound("buttonClick",1);
                  break;
               case "clan":
                  _loc4_ = param2;
                  if(dataM.inspectPlayer_playerID != _loc4_)
                  {
                     if(dataM.playersGeneralData[_loc4_] != null)
                     {
                        this.inspectGeneralPlayerData(_loc4_);
                     }
                     else
                     {
                        remoteM.socketM.lobby_getPlayerGeneralData(_loc4_);
                        screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
                     }
                  }
                  soundM.createSound("buttonClick",1);
            }
         }
      }
      
      private function tileListItemClickedSub() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_RAID_LEADERBOARD))
         {
            dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_REPLAY,BMDataManager.GAME_SUB_TYPE_REPLAY_RAID_LEADERBOARD_INSPECT,"inspectPlayer");
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_RANKING_LIST))
         {
            dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_REPLAY,BMDataManager.GAME_SUB_TYPE_REPLAY_RANKING_LIST_INSPECT,"inspectPlayer");
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_MENU))
         {
            dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_REPLAY,BMDataManager.GAME_SUB_TYPE_REPLAY_CLAN_INSPECT,"inspectPlayer");
         }
         else
         {
            dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_REPLAY,BMDataManager.GAME_SUB_TYPE_REPLAY_MENU_CHAT_INSPECT,"inspectPlayer");
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT))
         {
            screensM.removeScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
         }
         dataM.unpackReplay(this._selectedReplayID);
         this.removeMe();
      }
      
      public function achievementsNotAvailable() : void
      {
         this.enableAllNavigationButtons();
         this.mcSandClock.gotoAndStop("animOff");
         updateTextAndFormat(this.txtNoReplays,getScreenText("noData"));
         this.txtNoReplays.visible = true;
      }
      
      public function displayAchievements() : void
      {
         var _loc6_:uint = 0;
         var _loc10_:Object = null;
         var _loc12_:Object = null;
         var _loc13_:Array = null;
         var _loc17_:uint = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Object = null;
         var _loc20_:String = null;
         var _loc21_:MovieClip = null;
         var _loc22_:MovieClip = null;
         var _loc23_:MovieClip = null;
         var _loc24_:uint = 0;
         var _loc25_:BMItem = null;
         var _loc26_:BMTileListItem = null;
         var _loc27_:Array = null;
         var _loc28_:Array = null;
         this.enableAllNavigationButtons();
         this.mcSandClock.gotoAndStop("animOff");
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:uint = this.ACHIEVMENT_ROWS;
         var _loc4_:uint = this.ACHIEVMENT_ROW_WIDTH;
         var _loc5_:uint = this.ACHIEVMENT_ROW_HEIGHT;
         if(dataM.runAsMobile)
         {
            _loc3_ = this.ACHIEVMENT_ROWS_MOBILE;
            _loc4_ = this.ACHIEVMENT_ROW_WIDTH_MOBILE;
            _loc5_ = this.ACHIEVMENT_ROW_HEIGHT_MOBILE;
         }
         this.generalTileList = new BMTileList();
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this.generalTileList);
         }
         var _loc7_:Array = new Array();
         var _loc8_:Array = new Array();
         var _loc9_:Array = new Array();
         var _loc11_:Object = dataM.inspectPlayersStatistics[dataM.inspectPlayer_playerID];
         for each(_loc12_ in dataM.achievementsSortedDB)
         {
            _loc17_ = 1;
            while(_loc17_ <= _loc12_.length - 1)
            {
               _loc18_ = Number(_loc12_[_loc17_]);
               _loc10_ = dataM.achievementsDB[_loc18_];
               _loc10_.completed = false;
               _loc10_.locked = false;
               if(_loc10_.requirement > _loc11_[_loc10_.type])
               {
                  if(_loc17_ > 1)
                  {
                     _loc19_ = dataM.achievementsDB[_loc12_[_loc17_ - 1]];
                     if(_loc19_.requirement > _loc11_[_loc10_.type])
                     {
                        _loc10_.locked = true;
                     }
                  }
               }
               else
               {
                  _loc10_.completed = true;
               }
               _loc17_++;
            }
         }
         for each(_loc10_ in dataM.achievementsDB)
         {
            if(_loc10_.completed)
            {
               _loc20_ = dataM.getAchievmentDescriptionText(_loc10_);
               if(dataM.runAsMobile)
               {
                  _loc21_ = new mcAchievementsListRowInspect_mobile();
               }
               else
               {
                  _loc21_ = new mcAchievementsListRowInspect();
               }
               _loc22_ = null;
               if(_loc10_.locked)
               {
                  _loc22_ = new mcAchievementLocked();
               }
               else
               {
                  _loc22_ = externalAssetsM.getAsset("general","achievement_" + _loc10_.type);
               }
               if(_loc22_ != null)
               {
                  _loc22_.width = _loc21_.mcSizer_icon.width;
                  _loc22_.height = _loc21_.mcSizer_icon.height;
                  _loc22_.x = _loc21_.mcSizer_icon.x;
                  _loc22_.y = _loc21_.mcSizer_icon.y;
                  _loc21_.mcHolder.addChild(_loc22_);
               }
               _loc23_ = externalAssetsM.getAsset("general","achievementRank");
               _loc23_.width = _loc21_.mcSizer_icon.width;
               _loc23_.height = _loc21_.mcSizer_icon.height;
               _loc23_.x = _loc21_.mcSizer_icon.x;
               _loc23_.y = _loc21_.mcSizer_icon.y;
               _loc23_.gotoAndStop("rank" + _loc10_.level);
               _loc21_.mcHolder.addChild(_loc23_);
               _loc24_ = 16;
               updateTextAndFormat(_loc21_.txtDescription,TextUtils.getTextFont(_loc24_) + _loc20_);
               if(_loc10_.completed)
               {
                  _loc21_.mcBackground.gotoAndStop("completed");
                  _loc1_++;
               }
               _loc25_ = new BMItem();
               _loc25_.initialize(0,_loc4_,_loc5_,_loc21_,0,0,false,null,dataM.runAsMobile);
               if(dataM.runAsMobile)
               {
                  _loc27_ = new Array();
                  if(_loc22_ != null)
                  {
                     _loc27_.push(_loc22_);
                  }
                  if(_loc23_ != null)
                  {
                     _loc27_.push(_loc23_);
                  }
                  _loc28_ = [_loc21_.txtDescription];
                  if(dataM.runAsMobile)
                  {
                     _loc25_.createAssetsBitmap(_loc28_,_loc27_,_loc21_);
                  }
               }
               _loc26_ = new BMTileListItem();
               _loc26_.initialize(_loc4_,_loc5_,_loc25_,"","","",0,null,null,null,null,null,dataM.runAsMobile);
               _loc26_.disableMouseOverEffect();
               if(_loc10_.completed)
               {
                  _loc9_.push(_loc26_);
               }
               else if(_loc10_.locked)
               {
                  _loc8_.push(_loc26_);
               }
               else
               {
                  _loc7_.push(_loc26_);
               }
            }
            _loc2_++;
         }
         _loc13_ = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc7_.length)
         {
            _loc13_.push(_loc7_[_loc6_]);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc9_.length)
         {
            _loc13_.push(_loc9_[_loc6_]);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc8_.length)
         {
            _loc13_.push(_loc8_[_loc6_]);
            _loc6_++;
         }
         var _loc14_:MovieClip = new Grp_scrollerContent();
         var _loc15_:Boolean = false;
         if(dataM.runAsMobile)
         {
            _loc15_ = true;
            this.generalTileList.activateExtendedMode(0.33,true);
         }
         this.generalTileList.initialize(screensM.stagePointer,_loc13_,_loc3_,1,_loc4_,_loc5_,null,true,_loc14_,null,null,false,0,1,true,_loc15_,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            this.generalTileList.x = this.mcSizer_tileList.x + 2;
            this.generalTileList.y = this.mcSizer_tileList.y + 36;
         }
         else
         {
            this.generalTileList.x = this.mcSizer_tileList.x;
            this.generalTileList.y = this.mcSizer_tileList.y + 34;
         }
         if(_loc13_.length == 0)
         {
            this.generalTileList.visible = false;
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.resetTileList(null);
            }
         }
         else
         {
            this.generalTileList.visible = true;
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.resetTileList(this.generalTileList);
            }
         }
         this.mcButtonsHolder.addChild(this.generalTileList);
         var _loc16_:Number = Math.floor(_loc1_ / _loc2_ * 100);
         updateTextAndFormat(this.txtInfo,TextUtils.getTextFont() + getSpecificText("achievements_totalEarned") + _loc1_ + " / " + _loc2_ + "  <FONT COLOR =\'#B2B2B2\'>(" + _loc16_ + "%)</FONT>");
         this.txtInfo.visible = true;
         this.createTextsBitmapForMobile();
      }
      
      public function downClicked() : void
      {
         var _loc2_:BMPlayerRankingListData = null;
         var _loc3_:Number = NaN;
         var _loc1_:Number = this.getPreviousPlayerID(dataM.inspectPlayer_playerID);
         if(_loc1_ > 0)
         {
            this.disableAllNavigationButtons();
            _loc2_ = dataM.rankingList_weekly[_loc1_];
            _loc3_ = 0;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.clanID;
            }
            this.refreshScreen(_loc1_,false,"",0,0,_loc3_);
            screensM.screenRankingList.jumpToPlayer(_loc1_);
         }
      }
      
      private function getPreviousPlayerID(param1:Number) : Number
      {
         var _loc5_:BMPlayerRankingListData = null;
         var _loc2_:BMPlayerRankingListData = this.getTargetRankingList()[param1];
         var _loc3_:Number = 9999999;
         var _loc4_:Number = 0;
         for each(_loc5_ in this.getTargetRankingList())
         {
            if(_loc5_.playerID != _loc2_.playerID)
            {
               if(_loc5_.overallRank > _loc2_.overallRank)
               {
                  if(_loc5_.overallRank < _loc3_)
                  {
                     _loc4_ = _loc5_.playerID;
                     _loc3_ = _loc5_.overallRank;
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function upClicked() : void
      {
         var _loc2_:BMPlayerRankingListData = null;
         var _loc3_:Number = NaN;
         var _loc1_:Number = this.getNextPlayerID(dataM.inspectPlayer_playerID);
         if(_loc1_ > 0)
         {
            this.disableAllNavigationButtons();
            _loc2_ = dataM.rankingList_weekly[_loc1_];
            _loc3_ = 0;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.clanID;
            }
            this.refreshScreen(_loc1_,false,"",0,0,_loc3_);
            screensM.screenRankingList.jumpToPlayer(_loc1_);
         }
      }
      
      private function getNextPlayerID(param1:Number) : Number
      {
         var _loc5_:BMPlayerRankingListData = null;
         var _loc2_:BMPlayerRankingListData = this.getTargetRankingList()[param1];
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         for each(_loc5_ in this.getTargetRankingList())
         {
            if(_loc5_.playerID != _loc2_.playerID)
            {
               if(_loc5_.overallRank < _loc2_.overallRank)
               {
                  if(_loc5_.overallRank > _loc3_)
                  {
                     _loc4_ = _loc5_.playerID;
                     _loc3_ = _loc5_.overallRank;
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function displayClan() : void
      {
         var _loc13_:MovieClip = null;
         var _loc14_:Number = NaN;
         var _loc15_:MovieClip = null;
         var _loc16_:BMClanMemberData = null;
         var _loc17_:MovieClip = null;
         var _loc18_:String = null;
         var _loc19_:uint = 0;
         var _loc20_:Number = NaN;
         var _loc21_:Sprite = null;
         var _loc22_:Boolean = false;
         var _loc23_:BMItem = null;
         var _loc24_:BMTileListItem = null;
         var _loc25_:Function = null;
         var _loc26_:BMAvatarImage = null;
         this.enableAllNavigationButtons();
         this.refreshClanMedals();
         var _loc1_:BMClanData = dataM.GetInspectClanData(this.currentPlayerClanID);
         var _loc2_:String = "<FONT COLOR =\'#" + dataM.COLOR_GOLD + "\'>" + _loc1_.name + "</FONT><BR>";
         var _loc3_:String = getSpecificText("clan_ladderWins");
         if(_loc1_.ladderBattles > 0)
         {
            _loc14_ = Math.ceil(_loc1_.ladderWins / _loc1_.ladderBattles * 100);
            _loc3_ = dataM.replaceStringInText(_loc3_,"%WINS%",TextUtils.getNumberWithComma(_loc1_.ladderWins));
            _loc3_ = dataM.replaceStringInText(_loc3_,"%BATTLES%",TextUtils.getNumberWithComma(_loc1_.ladderBattles));
            _loc2_ = _loc2_ + _loc3_ + " (" + _loc14_ + "%)";
         }
         else
         {
            _loc3_ = dataM.replaceStringInText(_loc3_,"%WINS%","0");
            _loc3_ = dataM.replaceStringInText(_loc3_,"%BATTLES%","0");
            _loc2_ += _loc3_;
         }
         var _loc4_:String = getSpecificText("clan_members");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%CURRENT%",String(_loc1_.members.length));
         _loc4_ = dataM.replaceStringInText(_loc4_,"%MAX%",String(dataM.clanMaxMembers));
         _loc2_ = _loc2_ + "<BR>" + _loc4_;
         updateTextAndFormat(this.txtInfo,TextUtils.getTextFont() + _loc2_);
         this.txtInfo.visible = true;
         this.txtClanMedals.visible = true;
         var _loc5_:Array = dataM.getClanFlagData(_loc1_.flag);
         if(_loc5_.length > 0)
         {
            this.mcClanFlag = new BMClanFlag();
            _loc15_ = externalAssetsM.getAsset("general","clanFlag",this.mcSizer_clanFlag.width,this.mcSizer_clanFlag.height,false,false);
            _loc15_.x = this.mcSizer_clanFlag.x;
            _loc15_.y = this.mcSizer_clanFlag.y;
            this.mcClanFlag.initialize(_loc15_,dataM.runAsMobile);
            this.mcClanFlag.updateFlag(_loc5_);
            this.mcIconsHolder.addChild(_loc15_);
         }
         var _loc6_:Array = new Array();
         var _loc7_:uint = this.CLAN_ROWS;
         var _loc8_:uint = this.CLAN_ROW_WIDTH;
         var _loc9_:uint = this.CLAN_ROW_HEIGHT;
         if(dataM.runAsMobile)
         {
            _loc7_ = this.CLAN_ROWS_MOBILE;
            _loc8_ = this.CLAN_ROW_WIDTH_MOBILE;
            _loc9_ = this.CLAN_ROW_HEIGHT_MOBILE;
         }
         var _loc10_:uint = 0;
         while(_loc10_ < _loc1_.members.length)
         {
            _loc16_ = _loc1_.members[_loc10_];
            if(dataM.runAsMobile)
            {
               _loc17_ = new mcClanMemberRowInspect_mobile();
            }
            else
            {
               _loc17_ = new mcClanMemberRowInspect();
            }
            _loc18_ = "regular1";
            if(_loc1_.leaderID == _loc16_.playerID)
            {
               _loc18_ = "top10";
            }
            else if(_loc10_ % 2 == 0)
            {
               _loc18_ = "regular2";
            }
            _loc17_.mcBackground.gotoAndStop(_loc18_);
            switch(_loc16_.lastDevice)
            {
               case "1":
               case "2":
                  _loc17_.txtName.width -= 18;
                  break;
               default:
                  _loc17_.mcMobileDevice.parent.removeChild(_loc17_.mcMobileDevice);
                  _loc17_.mcMobileDevice = null;
            }
            _loc19_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc16_.ladderProgress));
            _loc20_ = Number(_loc17_.mcSizer_rank.width);
            _loc21_ = externalAssetsM.getAsset("general","Grp_rank" + _loc19_,_loc20_,_loc20_,false,false);
            _loc21_.x = _loc17_.mcSizer_rank.x;
            _loc21_.y = _loc17_.mcSizer_rank.y;
            _loc17_.addChild(_loc21_);
            _loc22_ = false;
            if(_loc16_.geo != null && _loc16_.geo != "")
            {
               _loc22_ = true;
            }
            if(_loc22_)
            {
               _loc26_ = dataM.getAvatarImage(_loc16_.geo);
               _loc26_.x = _loc17_.mcSizer_flag.x;
               _loc26_.y = _loc17_.mcSizer_flag.y;
               _loc17_.addChild(_loc26_);
            }
            updateTextAndFormat(_loc17_.txtLevel,String(_loc16_.level));
            updateTextAndFormat(_loc17_.txtName,_loc16_.name);
            _loc23_ = new BMItem();
            _loc23_.initialize(_loc16_.playerID,_loc8_,_loc9_,_loc17_,0,0,false,null,dataM.runAsMobile);
            _loc24_ = new BMTileListItem();
            _loc25_ = this.tileListItemClicked;
            if(dataM.runAsMobile)
            {
               _loc25_ = null;
            }
            _loc24_.initialize(_loc8_,_loc9_,_loc23_,"","","",0,_loc25_,null,null,null,null,dataM.runAsMobile);
            _loc6_.push(_loc24_);
            _loc10_++;
         }
         this.generalTileList = new BMTileList();
         var _loc11_:MovieClip = new Grp_scrollerContent();
         var _loc12_:Boolean = false;
         if(dataM.runAsMobile)
         {
            _loc12_ = true;
            this.generalTileList.activateExtendedMode(0.63,true);
         }
         if(dataM.runAsMobile)
         {
            _loc13_ = new mcClanMemberHeaderInspect_mobile();
         }
         else
         {
            _loc13_ = new mcClanMemberHeaderInspect();
         }
         updateTextAndFormat(_loc13_.txtLevel,getGeneralText("levelCaps"));
         updateTextAndFormat(_loc13_.txtName,getGeneralText("nameCaps"));
         this.generalTileList.initialize(screensM.clientPointer.stage,_loc6_,_loc7_,1,_loc8_,_loc9_,null,true,_loc11_,null,_loc13_,false,-1,1,true,_loc12_,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            this.generalTileList.x = this.mcSizer_tileList.x + 2;
            this.generalTileList.y = this.mcSizer_tileList.y + 148;
         }
         else
         {
            this.generalTileList.x = this.mcSizer_tileList.x;
            this.generalTileList.y = this.mcSizer_tileList.y + 144;
         }
         if(_loc6_.length == 0)
         {
            this.generalTileList.visible = false;
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.resetTileList(null);
            }
         }
         else
         {
            this.generalTileList.visible = true;
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.resetTileList(this.generalTileList);
            }
         }
         this.mcButtonsHolder.addChild(this.generalTileList);
         this.createTextsBitmapForMobile();
      }
      
      public function playerGeneralDataLoaded(param1:Number) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.inspectGeneralPlayerData(param1);
      }
      
      private function inspectGeneralPlayerData(param1:Number) : void
      {
         var _loc2_:Object = dataM.playersGeneralData[param1];
         this.refreshScreen(_loc2_.playerID,true,_loc2_.name,_loc2_.level,_loc2_.ladderProgress,_loc2_.clanID);
      }
      
      private function removeClanFlag() : void
      {
         if(this.mcClanFlag != null)
         {
            this.mcClanFlag.removeMe();
            this.mcClanFlag = null;
         }
      }
      
      private function removePlayerMedals() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(this._playerMedals != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._playerMedals.length)
            {
               _loc2_ = this._playerMedals[_loc1_];
               if(_loc2_.parent != null)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               this._playerMedals[_loc1_] = null;
               _loc1_++;
            }
         }
         this._playerMedals = new Array();
      }
      
      private function refreshPlayerMedals() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:MovieClip = null;
         var _loc8_:Sprite = null;
         var _loc9_:Number = NaN;
         var _loc10_:Array = null;
         this.removePlayerMedals();
         var _loc6_:Number = 0;
         var _loc7_:uint = 0;
         if(dataM.weeklyClanWinners[dataM.inspectPlayer_playerID] != null)
         {
            _loc2_ = 3;
            while(_loc2_ >= 1)
            {
               _loc3_ = Number(dataM.weeklyClanWinners[dataM.inspectPlayer_playerID].places[_loc2_]);
               if(_loc3_ > 0)
               {
                  _loc1_ = 1;
                  while(_loc1_ <= _loc3_)
                  {
                     _loc4_ = "medalClan" + _loc2_;
                     if(_loc3_ - _loc1_ >= 9)
                     {
                        _loc1_ += 9;
                        _loc4_ += "_10";
                     }
                     else if(_loc3_ - _loc1_ >= 4)
                     {
                        _loc1_ += 4;
                        _loc4_ += "_5";
                     }
                     else if(_loc3_ - _loc1_ >= 2)
                     {
                        _loc1_ += 2;
                        _loc4_ += "_3";
                     }
                     _loc5_ = externalAssetsM.getAsset("general",_loc4_);
                     if(_loc6_ == 0)
                     {
                        _loc6_ = this.mcSizer_playerMedals.x + this.mcSizer_playerMedals.width + _loc5_.width / 2;
                     }
                     _loc5_.x = _loc6_ - (1 + this._playerMedals.length) * _loc5_.width;
                     _loc5_.y = this.mcSizer_playerMedals.y;
                     if(this._playerMedals.length % 2 == 1)
                     {
                        _loc5_.gotoAndStop("long");
                     }
                     this.mcIconsHolder.addChild(_loc5_);
                     this._playerMedals.push(_loc5_);
                     _loc7_++;
                     _loc1_++;
                  }
               }
               _loc2_--;
            }
         }
         _loc6_ = 0;
         if(dataM.weeklySoloWinners[dataM.inspectPlayer_playerID] != null)
         {
            _loc2_ = 3;
            while(_loc2_ >= 1)
            {
               _loc3_ = Number(dataM.weeklySoloWinners[dataM.inspectPlayer_playerID].places[_loc2_]);
               if(_loc3_ > 0)
               {
                  _loc1_ = 1;
                  while(_loc1_ <= _loc3_)
                  {
                     _loc4_ = "medal" + _loc2_;
                     if(_loc3_ - _loc1_ >= 9)
                     {
                        _loc1_ += 9;
                        _loc4_ += "_10";
                     }
                     else if(_loc3_ - _loc1_ >= 4)
                     {
                        _loc1_ += 4;
                        _loc4_ += "_5";
                     }
                     else if(_loc3_ - _loc1_ >= 2)
                     {
                        _loc1_ += 2;
                        _loc4_ += "_3";
                     }
                     _loc5_ = externalAssetsM.getAsset("general",_loc4_);
                     if(_loc6_ == 0)
                     {
                        if(_loc7_ > 0)
                        {
                           _loc6_ = this._playerMedals[this._playerMedals.length - 1].x - _loc5_.width / 2;
                        }
                        else
                        {
                           _loc6_ = this.mcSizer_playerMedals.x + this.mcSizer_playerMedals.width + _loc5_.width / 2;
                        }
                     }
                     _loc5_.x = _loc6_ - (1 + this._playerMedals.length - _loc7_) * (_loc5_.width - 3);
                     _loc5_.y = this.mcSizer_playerMedals.y;
                     if(this._playerMedals.length % 2 == 1)
                     {
                        _loc5_.gotoAndStop("long");
                     }
                     this.mcIconsHolder.addChild(_loc5_);
                     this._playerMedals.push(_loc5_);
                     _loc1_++;
                  }
               }
               _loc2_--;
            }
         }
         if(this._playerMedals.length > 1)
         {
            _loc8_ = this._playerMedals[this._playerMedals.length - 1];
            if(_loc8_.x < this.mcSizer_playerMedals.x + 15)
            {
               _loc9_ = this.mcSizer_playerMedals.x + 15 - _loc8_.x;
               _loc1_ = this._playerMedals.length - 1;
               while(_loc1_ > 0)
               {
                  this._playerMedals[_loc1_].x += _loc9_ / (this._playerMedals.length - 1) * _loc1_;
                  _loc1_--;
               }
            }
         }
         if(this._playerMedals.length == 0)
         {
            this.mcPlayerMedalsTooltip.visible = false;
         }
         else
         {
            this.mcPlayerMedalsTooltip.visible = true;
         }
         if(dataM.runAsMobile)
         {
            if(this._playerMedalsBMD != null)
            {
               this._playerMedalsBMD.dispose();
               this._playerMedalsBMD = null;
            }
            if(this._playerMedalsBM != null)
            {
               this._playerMedalsBM.parent.removeChild(this._playerMedalsBM);
               this._playerMedalsBM = null;
            }
            if(this._playerMedals.length > 0)
            {
               _loc10_ = screensM.createAssetsBitmap([],this._playerMedals,15,15);
               this._playerMedalsBMD = _loc10_[0];
               this._playerMedalsBM = _loc10_[1];
               this.mcIconsHolder.addChild(this._playerMedalsBM);
            }
         }
      }
      
      private function playerMedalsTooltipMouseOver(param1:MouseEvent) : void
      {
         this.playerMedalsTooltipMouseOverSub();
      }
      
      public function playerMedalsTooltipMouseOverSub() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc1_:String = "";
         var _loc2_:String = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>";
         var _loc3_:String = "</FONT>";
         if(dataM.weeklySoloWinners[dataM.inspectPlayer_playerID] != null)
         {
            _loc4_ = uint(dataM.weeklySoloWinners[dataM.inspectPlayer_playerID].places[1]);
            _loc5_ = uint(dataM.weeklySoloWinners[dataM.inspectPlayer_playerID].places[2]);
            _loc6_ = uint(dataM.weeklySoloWinners[dataM.inspectPlayer_playerID].places[3]);
            if(_loc4_ > 0 || _loc5_ > 0 || _loc6_ > 0)
            {
               _loc1_ = "Solo weekly wins:";
               if(_loc4_ > 0)
               {
                  _loc1_ = _loc1_ + "<BR>   First place: " + _loc2_ + _loc4_ + _loc3_;
               }
               if(_loc5_ > 0)
               {
                  _loc1_ = _loc1_ + "<BR>   Second place: " + _loc2_ + _loc5_ + _loc3_;
               }
               if(_loc6_ > 0)
               {
                  _loc1_ = _loc1_ + "<BR>   Third place: " + _loc2_ + _loc6_ + _loc3_;
               }
            }
         }
         if(dataM.weeklyClanWinners[dataM.inspectPlayer_playerID] != null)
         {
            _loc7_ = uint(dataM.weeklyClanWinners[dataM.inspectPlayer_playerID].places[1]);
            _loc8_ = uint(dataM.weeklyClanWinners[dataM.inspectPlayer_playerID].places[2]);
            _loc9_ = uint(dataM.weeklyClanWinners[dataM.inspectPlayer_playerID].places[3]);
            if(_loc7_ > 0 || _loc8_ > 0 || _loc9_ > 0)
            {
               if(_loc1_ == "")
               {
                  _loc1_ = "Clan weekly wins:";
               }
               else
               {
                  _loc1_ += "<BR>Clan weekly wins:";
               }
               if(_loc7_ > 0)
               {
                  _loc1_ = _loc1_ + "<BR>   First place: " + _loc2_ + _loc7_ + _loc3_;
               }
               if(_loc8_ > 0)
               {
                  _loc1_ = _loc1_ + "<BR>   Second place: " + _loc2_ + _loc8_ + _loc3_;
               }
               if(_loc9_ > 0)
               {
                  _loc1_ = _loc1_ + "<BR>   Third place: " + _loc2_ + _loc9_ + _loc3_;
               }
            }
         }
         tooltip.showToolTip("regularText",_loc1_,-1,-1);
      }
      
      private function generalTooltipMouseOut(param1:MouseEvent) : void
      {
         this.generalTooltipMouseOutSub();
      }
      
      public function generalTooltipMouseOutSub() : void
      {
         tooltip.hideToolTip();
      }
      
      private function clanMedalsTooltipMouseOver(param1:MouseEvent) : void
      {
         this.clanMedalsTooltipMouseOverSub();
      }
      
      public function clanMedalsTooltipMouseOverSub() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc1_:String = "";
         if(this.currentPlayerClanID > 0)
         {
            if(dataM.weeklyTopClans[this.currentPlayerClanID] != null)
            {
               _loc2_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>";
               _loc3_ = "</FONT>";
               _loc4_ = uint(dataM.weeklyTopClans[this.currentPlayerClanID].places[1]);
               _loc5_ = uint(dataM.weeklyTopClans[this.currentPlayerClanID].places[2]);
               _loc6_ = uint(dataM.weeklyTopClans[this.currentPlayerClanID].places[3]);
               if(_loc4_ > 0 || _loc5_ > 0 || _loc6_ > 0)
               {
                  if(_loc1_ == "")
                  {
                     _loc1_ = "Clan weekly wins:";
                  }
                  else
                  {
                     _loc1_ += "<BR>Clan weekly wins:";
                  }
                  if(_loc4_ > 0)
                  {
                     _loc1_ = _loc1_ + "<BR>   First place: " + _loc2_ + _loc4_ + _loc3_;
                  }
                  if(_loc5_ > 0)
                  {
                     _loc1_ = _loc1_ + "<BR>   Second place: " + _loc2_ + _loc5_ + _loc3_;
                  }
                  if(_loc6_ > 0)
                  {
                     _loc1_ = _loc1_ + "<BR>   Third place: " + _loc2_ + _loc6_ + _loc3_;
                  }
               }
            }
            tooltip.showToolTip("regularText",_loc1_,-1,-1);
         }
      }
      
      private function clanMedalsTooltipMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      private function removeClanMedals() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         this.mcClanMedalsTooltip.visible = false;
         if(this._clanMedals != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._clanMedals.length)
            {
               _loc2_ = this._clanMedals[_loc1_];
               if(_loc2_.parent != null)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               this._clanMedals[_loc1_] = null;
               _loc1_++;
            }
         }
         this._clanMedals = new Array();
         if(this._clanMedalsBMD != null)
         {
            this._clanMedalsBMD.dispose();
            this._clanMedalsBMD = null;
         }
         if(this._clanMedalsBM != null)
         {
            this._clanMedalsBM.parent.removeChild(this._clanMedalsBM);
            this._clanMedalsBM = null;
         }
      }
      
      private function refreshClanMedals() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:MovieClip = null;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Sprite = null;
         var _loc10_:Number = NaN;
         var _loc11_:Array = null;
         this.removeClanMedals();
         var _loc1_:Number = 0;
         if(dataM.weeklyTopClans[this.currentPlayerClanID] != null)
         {
            _loc7_ = 0;
            _loc8_ = 0;
            _loc3_ = 3;
            while(_loc3_ >= 1)
            {
               _loc4_ = Number(dataM.weeklyTopClans[this.currentPlayerClanID].places[_loc3_]);
               if(_loc4_ > 0)
               {
                  _loc2_ = 1;
                  while(_loc2_ <= _loc4_)
                  {
                     _loc5_ = "medalClan" + _loc3_;
                     if(_loc4_ - _loc2_ >= 9)
                     {
                        _loc2_ += 9;
                        _loc5_ += "_10";
                     }
                     else if(_loc4_ - _loc2_ >= 4)
                     {
                        _loc2_ += 4;
                        _loc5_ += "_5";
                     }
                     else if(_loc4_ - _loc2_ >= 2)
                     {
                        _loc2_ += 2;
                        _loc5_ += "_3";
                     }
                     _loc6_ = externalAssetsM.getAsset("general",_loc5_);
                     if(_loc8_ == 0)
                     {
                        _loc8_ = this.mcSizer_clanMedals.x + this.mcSizer_clanMedals.width + _loc6_.width / 2;
                     }
                     _loc6_.x = _loc8_ - (1 + this._clanMedals.length) * _loc6_.width;
                     _loc6_.y = this.mcSizer_clanMedals.y;
                     if(this._clanMedals.length % 2 == 1)
                     {
                        _loc6_.gotoAndStop("long");
                     }
                     this.mcIconsHolder.addChild(_loc6_);
                     this._clanMedals.push(_loc6_);
                     _loc7_++;
                     _loc2_++;
                  }
               }
               _loc3_--;
            }
            if(_loc7_ > 0)
            {
               this.mcClanMedalsTooltip.visible = true;
            }
            if(_loc7_ > 1)
            {
               _loc9_ = this._clanMedals[this._clanMedals.length - 1];
               if(_loc9_.x < this.mcSizer_clanMedals.x + 15)
               {
                  _loc10_ = this.mcSizer_clanMedals.x + 15 - _loc9_.x;
                  _loc2_ = this._clanMedals.length - 1;
                  while(_loc2_ > 0)
                  {
                     this._clanMedals[_loc2_].x += _loc10_ / (this._clanMedals.length - 1) * _loc2_;
                     _loc2_--;
                  }
               }
            }
         }
         if(dataM.runAsMobile)
         {
            if(this._clanMedalsBMD != null)
            {
               this._clanMedalsBMD.dispose();
               this._clanMedalsBMD = null;
            }
            if(this._clanMedalsBM != null)
            {
               this._clanMedalsBM.parent.removeChild(this._clanMedalsBM);
               this._clanMedalsBM = null;
            }
            if(this._clanMedals.length > 0)
            {
               _loc11_ = screensM.createAssetsBitmap([],this._clanMedals,15,15);
               this._clanMedalsBMD = _loc11_[0];
               this._clanMedalsBM = _loc11_[1];
               this.mcIconsHolder.addChild(this._clanMedalsBM);
            }
         }
      }
      
      private function refreshToggleMechsButtons() : void
      {
         if(dataM.inspectPlayer_activeMechIDs.length > 1)
         {
            this.btnNextMech.visible = true;
            this.btnPreviousMech.visible = true;
         }
         else
         {
            this.btnNextMech.visible = false;
            this.btnPreviousMech.visible = false;
         }
      }
      
      public function previousMechClicked() : void
      {
         if(dataM.inspectPlayer_activeMechIDs.length > 1)
         {
            if(dataM.inspectPlayer_currentMechSlot <= 0)
            {
               dataM.inspectPlayer_currentMechSlot = dataM.inspectPlayer_activeMechIDs.length - 1;
            }
            else
            {
               --dataM.inspectPlayer_currentMechSlot;
            }
            dataM.inspectPlayer_currentMechID = dataM.inspectPlayer_activeMechIDs[dataM.inspectPlayer_currentMechSlot];
            this.displayPlayerMech();
         }
      }
      
      public function nextMechClicked() : void
      {
         if(dataM.inspectPlayer_activeMechIDs.length > 1)
         {
            if(dataM.inspectPlayer_currentMechSlot >= dataM.inspectPlayer_activeMechIDs.length - 1)
            {
               dataM.inspectPlayer_currentMechSlot = 0;
            }
            else
            {
               ++dataM.inspectPlayer_currentMechSlot;
            }
            dataM.inspectPlayer_currentMechID = dataM.inspectPlayer_activeMechIDs[dataM.inspectPlayer_currentMechSlot];
            this.displayPlayerMech();
         }
      }
      
      private function sparksHandler() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Sprite = null;
         var _loc8_:Sprite = null;
         var _loc9_:Sprite = null;
         var _loc1_:uint = this._clanMedals.length + this._playerMedals.length;
         if(_loc1_ > 0)
         {
            _loc3_ = 22 - (_loc1_ - 1);
            if(_loc3_ < 5)
            {
               _loc3_ = 5;
            }
            _loc4_ = Math.ceil(Math.random() * _loc3_);
            if(_loc4_ == 1)
            {
               _loc4_ = Math.ceil(Math.random() * _loc1_) - 1;
               if(_loc4_ >= this._clanMedals.length)
               {
                  _loc7_ = this._playerMedals[_loc4_ - this._clanMedals.length];
                  _loc5_ = _loc7_.x;
                  _loc6_ = _loc7_.y + _loc7_.height - 10;
               }
               else
               {
                  _loc7_ = this._clanMedals[_loc4_];
                  _loc5_ = _loc7_.x;
                  _loc6_ = _loc7_.y + _loc7_.height - 15;
               }
               _loc8_ = externalAssetsM.getAsset("general","Grp_itemBoxSpark",0,0,false,false);
               _loc8_.scaleX = 1.3;
               _loc8_.scaleY = 1.3;
               _loc8_.x = _loc5_ + Math.random() * 16 - 8;
               _loc8_.y = _loc6_ + Math.random() * 16 - 8;
               this.mcIconsHolder.addChild(_loc8_);
               this._sparks.push(_loc8_);
            }
         }
         _loc2_ = 0;
         while(_loc2_ < this._sparks.length)
         {
            _loc9_ = this._sparks[_loc2_];
            if(_loc9_.scaleX > 0.075)
            {
               _loc9_.scaleX -= 0.075;
               _loc9_.scaleY -= 0.075;
            }
            else
            {
               this._sparks[_loc2_].parent.removeChild(this._sparks[_loc2_]);
               this._sparks[_loc2_] = null;
               this._sparks.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      private function disableAllNavigationButtons() : void
      {
         this.btnBack.disableMe();
         this.btnMechs.disableMe();
         this.btnReplays.disableMe();
         this.btnAchievements.disableMe();
         this.btnClan.disableMe();
         this.btnUp.disableMe();
         this.btnDown.disableMe();
      }
      
      private function enableAllNavigationButtons() : void
      {
         this.btnBack.enableMe();
         this.btnMechs.enableMe();
         if(this._allowViewReplays)
         {
            this.btnReplays.enableMe();
         }
         else
         {
            this.btnReplays.disableMe();
         }
         this.btnAchievements.enableMe();
         if(this.currentPlayerClanID > 0 && this.currentPlayerClanID != dataM.myProfile.clanID)
         {
            this.btnClan.enableMe();
         }
         if(dataM.inspectPlayer_outsideRankingList == false)
         {
            this.btnDown.enableMe();
            this.btnUp.enableMe();
            if(this.getNextPlayerID(dataM.inspectPlayer_playerID) == 0)
            {
               this.btnUp.disableMe();
            }
            if(this.getPreviousPlayerID(dataM.inspectPlayer_playerID) == 0)
            {
               this.btnDown.disableMe();
            }
         }
      }
      
      public function mechsClicked() : void
      {
         this.tabClicked("mechs",false);
      }
      
      public function replaysClicked() : void
      {
         this.tabClicked("replays",false);
      }
      
      public function achievementsClicked() : void
      {
         this.tabClicked("achievements",false);
      }
      
      public function clanClicked() : void
      {
         this.tabClicked("clan",false);
      }
      
      private function tabClicked(param1:String, param2:Boolean) : void
      {
         if(dataM.inspectPlayer_selectedTab != param1 || param2)
         {
            dataM.inspectPlayer_lastTab = dataM.inspectPlayer_selectedTab;
            dataM.inspectPlayer_selectedTab = param1;
            if(param1 != "" && param2)
            {
               this.btnNextMech.visible = false;
               this.btnPreviousMech.visible = false;
               this.mcBlackScreen.visible = false;
               this.txtNoReplays.visible = false;
               this.txtInfo.visible = false;
               this.txtClanMedals.visible = false;
            }
            this.refreshCurrentTab();
         }
      }
      
      private function createTextsBitmapForMobile() : void
      {
      }
      
      public function mechsMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("mechs"),-1,-1);
      }
      
      public function replaysMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("menu_replays"),-1,-1);
      }
      
      public function achievementsMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("menu_achievements"),-1,-1);
      }
      
      public function clanMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("clan"),-1,-1);
      }
      
      public function nextMechButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("nextMech"),-1,-1);
      }
      
      public function previousMechButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("previousMech"),-1,-1);
      }
      
      private function buttonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      private function setButtonMarker(param1:BMButton_pictureE) : void
      {
         this.mcButtonMarker.x = param1.x;
         this.mcButtonMarker.y = param1.y;
      }
      
      public function backClicked() : void
      {
         this.removeMe();
      }
      
      private function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_INSPECT_PLAYER);
         if(this.generalTileList != null)
         {
            this.generalTileList.removeMe();
            this.generalTileList = null;
         }
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.removeMouseListeners();
         }
         this.removePlayerMedals();
         this.removeClanMedals();
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.removeMe();
      }
   }
}

