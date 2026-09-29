package net.battleMechsMulti.screens.raid
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenRaidLeaderboard extends BMBaseScreen
   {
      
      public static const LEADERBOARD_CURRENT_RAID:uint = 1;
      
      public static const LEADERBOARD_LAST_RAID:uint = 2;
      
      public var btnLastRaid:BMBasicButton;
      
      public var btnCurrentRaid:BMBasicButton;
      
      public var mcSelectedButtonMarker:Sprite;
      
      public var mcTileListHolder:Sprite;
      
      public var mcTileListPosition:Sprite;
      
      public var mcFingerWheeling:Sprite;
      
      private var leaderboardTileList:BMTileList;
      
      private var _selectedLeaderboard:uint = 0;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private const ITEM_WIDTH:uint = 725;
      
      private const ITEM_HEIGHT:uint = 30;
      
      private const ITEM_WIDTH_MOBILE:uint = 755;
      
      private const ITEM_HEIGHT_MOBILE:uint = 30;
      
      public function BMScreenRaidLeaderboard()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("raid");
         this.initFingerWheeling();
         dataM.raidData.resetCurrentWeekLeaderboardData();
         this.selectLeaderboard(LEADERBOARD_CURRENT_RAID);
         this.initButtons();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_RAID_LEADERBOARD) == false)
         {
            return;
         }
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.onEnterFrameTrigger();
         }
      }
      
      private function initFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling = new BMFingerWheeling();
            this._fingerWheeling.initialize("raidLeaderboard",this.leaderboardTileList,this.mcFingerWheeling,this.leaderboardItemClicked,null,false);
            this._fingerWheeling.addMouseListeners();
            addChild(this._fingerWheeling);
         }
         else
         {
            this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      public function gotData(param1:Array) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         dataM.raidData.setLeaderboardData(param1,this._selectedLeaderboard == LEADERBOARD_CURRENT_RAID);
         this.selectLeaderboard(this._selectedLeaderboard,true);
      }
      
      private function get currentLeaderboardData() : Array
      {
         switch(this._selectedLeaderboard)
         {
            case LEADERBOARD_CURRENT_RAID:
               return dataM.raidData.currentWeekLeaderboard;
            case LEADERBOARD_LAST_RAID:
               return dataM.raidData.lastWeekLeaderboard;
            default:
               return null;
         }
      }
      
      private function selectLeaderboard(param1:uint, param2:Boolean = false) : void
      {
         var _loc3_:BMBasicButton = null;
         var _loc4_:Boolean = false;
         if(this._selectedLeaderboard == param1 && param2 == false)
         {
            return;
         }
         this._selectedLeaderboard = param1;
         if(this.currentLeaderboardData == null)
         {
            _loc4_ = true;
            if(this._selectedLeaderboard == LEADERBOARD_LAST_RAID)
            {
               _loc4_ = false;
            }
            remoteM.socketM.raid_getLeaderboard(_loc4_);
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            return;
         }
         switch(this._selectedLeaderboard)
         {
            case LEADERBOARD_CURRENT_RAID:
               _loc3_ = this.btnCurrentRaid;
               break;
            case LEADERBOARD_LAST_RAID:
               _loc3_ = this.btnLastRaid;
         }
         this.mcSelectedButtonMarker.x = _loc3_.x;
         this.mcSelectedButtonMarker.y = _loc3_.y;
         this.refreshTileList();
      }
      
      private function refreshTileList() : void
      {
         var _loc5_:MovieClip = null;
         var _loc8_:RaidLeaderboardListHeader = null;
         if(this.leaderboardTileList != null)
         {
            this.leaderboardTileList.removeMe();
         }
         this.leaderboardTileList = new BMTileList();
         this.leaderboardTileList.x = this.mcTileListPosition.x;
         this.leaderboardTileList.y = this.mcTileListPosition.y;
         var _loc1_:uint = 9;
         var _loc2_:uint = 1;
         var _loc3_:Boolean = true;
         var _loc4_:Boolean = false;
         var _loc6_:Number = 0.75;
         var _loc7_:uint = 0;
         var _loc9_:Number = this.ITEM_WIDTH;
         var _loc10_:Number = this.ITEM_HEIGHT;
         if(dataM.runAsMobile)
         {
            _loc8_ = new RaidLeaderboardListHeader_mobile();
            _loc9_ = this.ITEM_WIDTH_MOBILE;
            _loc10_ = this.ITEM_HEIGHT_MOBILE;
            _loc4_ = true;
            this.leaderboardTileList.activateExtendedMode(0.44,true);
         }
         else
         {
            _loc8_ = new RaidLeaderboardListHeader();
            _loc5_ = new Grp_scrollerContent();
         }
         _loc8_.initialize(getSpecificText("rankingList_position"),getScreenText("scoreCaps"),getScreenText("tierCaps"),getGeneralText("nameCaps"),getScreenText("prizeCaps"));
         var _loc11_:Array = new Array();
         var _loc12_:Number = dataM.userID;
         var _loc13_:uint = 0;
         while(_loc13_ < this.currentLeaderboardData.length)
         {
            if(_loc12_ == this.currentLeaderboardData[_loc13_].playerID)
            {
               if(_loc13_ > 4)
               {
                  _loc7_ = _loc13_ - 4;
               }
            }
            _loc11_.push(this.createTileListRow(_loc13_,_loc9_,_loc10_));
            _loc13_++;
         }
         this.leaderboardTileList.initialize(screensM.stagePointer,_loc11_,_loc1_,_loc2_,_loc9_,_loc10_,null,_loc3_,_loc5_,null,_loc8_,false,0,_loc6_,true,_loc4_,dataM.runAsMobile);
         this.mcTileListHolder.addChild(this.leaderboardTileList);
         if(_loc7_ > 0)
         {
            this.leaderboardTileList.jumpToRow(_loc7_,true,"screenRaidLeaderboardInit");
         }
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this.leaderboardTileList);
         }
      }
      
      private function createTileListRow(param1:uint, param2:Number, param3:Number) : BMTileListItem
      {
         var _loc4_:RaidLeaderboardListRow = null;
         if(dataM.runAsMobile)
         {
            _loc4_ = new RaidLeaderboardListRow_mobile();
         }
         else
         {
            _loc4_ = new RaidLeaderboardListRow();
         }
         var _loc5_:RaidLeaderboardData = this.currentLeaderboardData[param1];
         var _loc6_:uint = _loc5_.raidLevel + 1;
         _loc4_.initialize(_loc5_.rank,_loc5_.score,_loc6_,_loc5_.name,_loc5_.gold,_loc5_.tokens,_loc5_.geo);
         var _loc7_:String = _loc4_.BACKGROUND_REGULAR1;
         if(_loc5_.rank <= 10)
         {
            if(_loc5_.playerID == dataM.userID)
            {
               _loc7_ = _loc4_.BACKGROUND_TOP10_SELF;
            }
            else
            {
               _loc7_ = _loc4_.BACKGROUND_TOP10;
            }
         }
         else if(_loc5_.playerID == dataM.userID)
         {
            _loc7_ = _loc4_.BACKGROUND_SELF;
         }
         else if(param1 % 2 == 0)
         {
            _loc7_ = _loc4_.BACKGROUND_REGULAR2;
         }
         if(_loc5_.progression == 1)
         {
            _loc4_.showPositiveProgressionArrow();
         }
         else if(_loc5_.progression == -1)
         {
            _loc4_.showNegativeProgressionArrow();
         }
         else
         {
            _loc4_.removeProgressionArrow();
         }
         _loc4_.setBackground(_loc7_);
         var _loc8_:BMItem = new BMItem();
         _loc8_.initialize(param1,param2,param3,_loc4_,0,0,false,null,dataM.runAsMobile);
         var _loc9_:BMTileListItem = new BMTileListItem();
         _loc9_.initialize(param2,param3,_loc8_,"","","",0,this.leaderboardItemClicked,null,null,null,null,dataM.runAsMobile);
         if(_loc4_.hasFlag())
         {
            _loc9_.itemsThatNeedsAddingAndRemoving.push(_loc4_.getFlagImage());
         }
         return _loc9_;
      }
      
      private function leaderboardItemClicked(param1:Number, param2:Number) : void
      {
         if(param1 == -1)
         {
            return;
         }
         var _loc3_:RaidLeaderboardData = this.currentLeaderboardData[param1];
         var _loc4_:Boolean = true;
         var _loc5_:uint = 0;
         screensM.addScreen(BMScreensManager.SCR_INSPECT_PLAYER);
         screensM.screenInspectPlayer.refreshScreen(_loc3_.playerID,_loc4_,_loc3_.name,_loc5_,_loc3_.ladderProgress,_loc3_.clanID);
      }
      
      private function initButtons() : void
      {
         var _loc1_:String = null;
         this.btnLastRaid.text = getScreenText("lastRaid");
         this.btnCurrentRaid.text = getScreenText("currentRaid");
         if(dataM.raidData.raidDaysLeft >= 1)
         {
            _loc1_ = getScreenText("daysLeft");
            _loc1_ = dataM.replaceStringInText(_loc1_,"%DAYS%",String(dataM.raidData.raidDaysLeft));
            this.btnCurrentRaid.subText = _loc1_;
         }
         else
         {
            this.btnCurrentRaid.subText = getScreenText("raidOver");
         }
         this.btnLastRaid.addEventListener(BMIntractable.HIT,this.lastRaidClicked);
         this.btnCurrentRaid.addEventListener(BMIntractable.HIT,this.currentRaidClicked);
      }
      
      private function lastRaidClicked(param1:Event) : void
      {
         this.selectLeaderboard(LEADERBOARD_LAST_RAID);
      }
      
      private function currentRaidClicked(param1:Event) : void
      {
         this.selectLeaderboard(LEADERBOARD_CURRENT_RAID);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.removeMouseListeners();
         }
         if(this.leaderboardTileList != null)
         {
            this.leaderboardTileList.removeMe();
            this.leaderboardTileList = null;
         }
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_RAID_LEADERBOARD);
      }
   }
}

