package net.battleMechsMulti.screens.clan
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ClanWarPlayerData;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.clan.listRow.ClanListRowDataForWarMembers;
   import net.battleMechsMulti.screens.clan.listRow.ClanWarMemberListHeader;
   import net.battleMechsMulti.screens.clan.listRow.ClanWarMemberListRow;
   
   public class BMScreenClanWarPreparation extends BMBaseScreen
   {
      
      public var btnMechBuilds:BMBasicButton;
      
      public var mcMechThumb0:RaidEnemyThumb;
      
      public var mcMechThumb1:RaidEnemyThumb;
      
      public var mcMechThumb2:RaidEnemyThumb;
      
      public var txtTitle:TextField;
      
      public var txtTimeLeft:TextField;
      
      public var txtMembersJoined:TextField;
      
      public var mcTimer:BMTimer;
      
      public var mcMechsHolder1:Sprite;
      
      public var mcMechsHolder2:Sprite;
      
      public var mcMechsHolder3:Sprite;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcTileListHolder:Sprite;
      
      public var mcTileListPosition:Sprite;
      
      private var membersTileList:BMTileList;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _selectedMemberSlot:Number;
      
      private const MEMBERS_ITEM_WIDTH:uint = 200;
      
      private const MEMBERS_ITEM_HEIGHT:uint = 30;
      
      private const MEMBERS_ROWS:uint = 4;
      
      private const MEMBERS_ITEM_WIDTH_MOBILE:uint = 200;
      
      private const MEMBERS_ITEM_HEIGHT_MOBILE:uint = 30;
      
      private const MEMBERS_ROWS_MOBILE:uint = 4;
      
      private var mechsCreator:BMClanWarEyeCandyMechs;
      
      public function BMScreenClanWarPreparation()
      {
         super();
      }
      
      public function initialize() : void
      {
         var _loc1_:String = null;
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clanWar");
         this.initButtons();
         this.initTexts();
         this.resetSelectedMemberSlot();
         this.addAndRefreshMembersTileList();
         this.initTimer();
         this.createBackgroundMechs();
         if(dataM.clanWarsM.defenceTeamChanged)
         {
            dataM.clanWarsM.defenceTeamChanged = false;
            _loc1_ = dataM.myPlayerData.isBlockedFromPlayingInCompetitveBattles(3);
            if(_loc1_ != null)
            {
               screensM.screenConfirmation.displayQuestionOrNotification(_loc1_);
               return;
            }
            remoteM.socketM.clanWar_join();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
         else
         {
            this.refreshMechThumbs();
         }
         dataM.clanWarsM.setLocalNotifications();
      }
      
      public function defenceTeamChangeUpdated() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.refreshMechThumbs();
      }
      
      private function initButtons() : void
      {
         this.btnMechBuilds.addEventListener(BMIntractable.HIT,this.mechBuildsClicked);
         if(dataM.runAsMobile)
         {
            this._fingerWheeling = new BMFingerWheeling();
            this._fingerWheeling.initialize("clanWarMembers",this.membersTileList,this.mcFingerWheeling,this.membersClicked,null,false);
            addChild(this._fingerWheeling);
         }
         else
         {
            this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
            this.mcFingerWheeling = null;
         }
      }
      
      public function resetSelectedMemberSlot() : void
      {
         this._selectedMemberSlot = -1;
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      public function mechBuildsClicked(param1:Event) : void
      {
         if(dataM.mechBuildsM.getBuildsWith3ReadyMechs().length == 0)
         {
            screensM.screenConfirmation.displayCustomMessage(getScreenText("cantChangeDefenseTeam"));
            return;
         }
         screensM.screenTransitionsManager.cameFromClanWarPreparation = true;
         screensM.screenTransitionsManager.mechBuildsClicked(3,true);
      }
      
      private function createBackgroundMechs() : void
      {
         this.mechsCreator = new BMClanWarEyeCandyMechs();
         this.mechsCreator.createMechs(this.mcMechsHolder1,this.mcMechsHolder2,this.mcMechsHolder3);
      }
      
      private function initTexts() : void
      {
         updateTextAndFormat(this.txtTitle,getScreenText("preparationPhase"));
         updateTextAndFormat(this.txtTimeLeft,getScreenText("joinTimeLeft"));
         var _loc1_:String = getScreenText("membersJoined");
         var _loc2_:String = dataM.clanWarsM.myClanPlayersData.length.toString();
         var _loc3_:String = dataM.myProfile.clanData.members.length.toString();
         _loc1_ = dataM.replaceStringInText(_loc1_,"%MEMBERS%",_loc2_);
         _loc1_ = dataM.replaceStringInText(_loc1_,"%MAX%",_loc3_);
         updateTextAndFormat(this.txtMembersJoined,_loc1_);
      }
      
      private function initTimer() : void
      {
         this.mcTimer.initialize(dataM.clanWarsM.getPhaseSecLeft,this.onTimeEnd);
      }
      
      private function onTimeEnd() : void
      {
         screensM.screenClanMenu.refreshClanData();
      }
      
      private function refreshMechThumbs() : void
      {
         var _loc3_:RaidEnemyThumb = null;
         var _loc4_:Vector.<BMMechStructure> = null;
         var _loc5_:BMMechViewManualColors = null;
         var _loc6_:BMMechStructure = null;
         var _loc1_:Vector.<BMMechStructure> = dataM.clanWarsM.getTeam(dataM.userID);
         var _loc2_:uint = 1;
         while(_loc2_ <= 3)
         {
            _loc3_ = this["mcMechThumb" + (_loc2_ - 1)];
            _loc4_ = new Vector.<BMMechStructure>();
            _loc5_ = new BMMechViewManualColors();
            if(_loc1_.length >= _loc2_)
            {
               _loc5_.setByMechStructure(_loc1_[_loc2_ - 1]);
               _loc4_.push(_loc1_[_loc2_ - 1]);
            }
            else
            {
               _loc6_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
               _loc6_.initialize(0,_loc2_);
               _loc4_.push(_loc6_);
            }
            _loc3_.initialize_mechView(_loc4_,_loc5_,1,dataM.clanWarsM.themeID,false,true);
            _loc2_++;
         }
      }
      
      public function membersClicked(param1:Number, param2:Number) : void
      {
         screensM.addScreen(BMScreensManager.SCR_CLAN_WAR_INSPECT_PLAYER,true,BMScreenClanWarInspectPlayerBase);
         screensM.screenClanWarInspectPlayer.showPlayerInfo(dataM.clanWarsM.getPlayerData(param2));
      }
      
      public function addAndRefreshMembersTileList() : void
      {
         var _loc5_:uint = 0;
         var _loc7_:Object = null;
         var _loc8_:ClanWarPlayerData = null;
         var _loc11_:ClanWarMemberListHeader = null;
         var _loc13_:Object = null;
         var _loc14_:uint = 0;
         var _loc15_:ClanWarMemberListRow = null;
         var _loc16_:ClanListRowDataForWarMembers = null;
         var _loc17_:String = null;
         var _loc18_:BMItem = null;
         var _loc19_:BMTileListItem = null;
         var _loc20_:Function = null;
         if(this.membersTileList == null)
         {
            this.membersTileList = new BMTileList();
         }
         else
         {
            this.membersTileList.removeAllItems();
         }
         var _loc1_:Array = new Array();
         var _loc2_:uint = dataM.runAsMobile ? this.MEMBERS_ROWS_MOBILE : this.MEMBERS_ROWS;
         var _loc3_:uint = dataM.runAsMobile ? this.MEMBERS_ITEM_WIDTH_MOBILE : this.MEMBERS_ITEM_WIDTH;
         var _loc4_:uint = dataM.runAsMobile ? this.MEMBERS_ITEM_HEIGHT_MOBILE : this.MEMBERS_ITEM_HEIGHT;
         var _loc6_:Array = new Array();
         for each(_loc8_ in dataM.clanWarsM.myClanPlayersData)
         {
            _loc7_ = {
               "playerID":_loc8_.playerID,
               "name":_loc8_.playerName,
               "ladderProgress":_loc8_.ladderProgress,
               "mechsInWar":dataM.clanWarsM.GetTotalMechsInTeam(_loc8_.playerID)
            };
            _loc6_.push(_loc7_);
         }
         _loc6_.sortOn(["ladderProgress"],[Array.NUMERIC | Array.DESCENDING]);
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc13_ = _loc6_[_loc5_];
            _loc14_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc13_.ladderProgress));
            _loc15_ = new mcClanWarMemberRow();
            _loc16_ = new ClanListRowDataForWarMembers(_loc13_.name,_loc14_,_loc13_.mechsInWar);
            _loc15_.initialize(_loc16_);
            _loc17_ = screensM.screenClanMenu.getMemberRowBackground(this._selectedMemberSlot,_loc15_,_loc13_,_loc5_);
            _loc15_.setBackground(_loc17_);
            _loc18_ = new BMItem();
            _loc18_.initialize(_loc13_.playerID,_loc3_,_loc4_,_loc15_,0,0,false,null,dataM.runAsMobile);
            _loc19_ = new BMTileListItem();
            _loc20_ = dataM.runAsMobile ? null : this.membersClicked;
            _loc19_.initialize(_loc3_,_loc4_,_loc18_,"","","",0,_loc20_,null,null,null,null,dataM.runAsMobile);
            _loc1_.push(_loc19_);
            _loc5_++;
         }
         var _loc9_:Boolean = false;
         if(dataM.runAsMobile)
         {
            _loc9_ = true;
            this.membersTileList.activateExtendedMode(0.35,true);
         }
         var _loc10_:MovieClip = new Grp_scrollerContent();
         if(dataM.runAsMobile)
         {
            _loc11_ = new mcClanWarMemberHeader_mobile();
         }
         else
         {
            _loc11_ = new mcClanWarMemberHeader();
         }
         _loc11_.initialize(getSpecificText("rankingList_members"));
         var _loc12_:uint = 3;
         this.membersTileList.initialize(screensM.clientPointer.stage,_loc1_,_loc2_,_loc12_,_loc3_,_loc4_,null,true,_loc10_,null,_loc11_,false,-1,1,true,_loc9_,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            this.membersTileList.x = this.mcTileListPosition.x - 4;
         }
         else
         {
            this.membersTileList.x = this.mcTileListPosition.x;
         }
         this.membersTileList.y = this.mcTileListPosition.y;
         this.mcTileListHolder.addChild(this.membersTileList);
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this.membersTileList);
            this._fingerWheeling.addMouseListeners();
         }
      }
      
      public function removeMe() : void
      {
         this.mechsCreator.removeMechs();
         screensM.removeScreen(BMScreensManager.SCR_CLAN_WAR_PREPARATION);
      }
   }
}

