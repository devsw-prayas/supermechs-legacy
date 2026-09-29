package net.battleMechsMulti.screens.clan
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureC;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureD;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.clan.listRow.ClanListRowDataForMembers;
   import net.battleMechsMulti.screens.clan.listRow.ClanMemberListHeader;
   import net.battleMechsMulti.screens.clan.listRow.ClanMemberListRow;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3307")]
   public class BMScreenClanMembers extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnAcceptRequest:Sprite;
      
      public var mcSizer_btnDeclineRequest:Sprite;
      
      public var mcSizer_btnKickMember:Sprite;
      
      public var mcSizer_btnLeaveClan:Sprite;
      
      public var mcSizer_btnInspect:Sprite;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var btnAcceptRequest:BMButton_pictureD;
      
      public var btnDeclineRequest:BMButton_pictureC;
      
      public var btnKickMember:BMButton_pictureC;
      
      public var btnLeaveClan:BMButton_pictureC;
      
      public var btnInspect:BMButton_pictureE;
      
      private var membersTileList:BMTileList;
      
      private var _selectedMemberSlot:Number;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private const MEMBERS_ITEM_WIDTH:uint = 703;
      
      private const MEMBERS_ITEM_HEIGHT:uint = 30;
      
      private const MEMBERS_ROWS:uint = 9;
      
      private const MEMBERS_ITEM_WIDTH_MOBILE:uint = 743;
      
      private const MEMBERS_ITEM_HEIGHT_MOBILE:uint = 33;
      
      private const MEMBERS_ROWS_MOBILE:uint = 8;
      
      public function BMScreenClanMembers()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clan");
         this.initButtons();
         this.addAndRefreshMembersTileList();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function initButtons() : void
      {
         screensM.createButtonFromSizer(BMScreensManager.SCR_CLAN_MEMBERS,"btnAcceptRequest","pictureD");
         screensM.createButtonFromSizer(BMScreensManager.SCR_CLAN_MEMBERS,"btnDeclineRequest","pictureC");
         screensM.createButtonFromSizer(BMScreensManager.SCR_CLAN_MEMBERS,"btnKickMember","pictureC");
         screensM.createButtonFromSizer(BMScreensManager.SCR_CLAN_MEMBERS,"btnLeaveClan","pictureC");
         screensM.createButtonFromSizer(BMScreensManager.SCR_CLAN_MEMBERS,"btnInspect","pictureE");
         var _loc1_:Function = this.acceptRequestClicked;
         var _loc2_:Function = this.declineRequestClicked;
         var _loc3_:Function = this.kickMemberClicked;
         var _loc4_:Function = this.leaveClanClicked;
         var _loc5_:Function = this.inspectClicked;
         if(dataM.runAsMobile)
         {
            _loc1_ = null;
            _loc2_ = null;
            _loc3_ = null;
            _loc4_ = null;
            _loc5_ = null;
         }
         this.btnAcceptRequest.initialize("","",externalAssetsM.getAsset("general","interface_V"),null,_loc1_,dataM.runAsMobile);
         this.btnDeclineRequest.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
         this.btnKickMember.initialize("","",externalAssetsM.getAsset("general","interface_clanKick"),null,_loc3_,dataM.runAsMobile);
         this.btnLeaveClan.initialize("","",externalAssetsM.getAsset("general","interface_clanLeave"),null,_loc4_,dataM.runAsMobile);
         this.btnInspect.initialize("","",externalAssetsM.getAsset("general","interface_inspect"),null,_loc5_,dataM.runAsMobile);
         this.btnAcceptRequest.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnDeclineRequest.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnKickMember.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnLeaveClan.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnInspect.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         if(dataM.runAsMobile == false)
         {
            this.btnAcceptRequest.buttonCore.addMouseOverListerner(this.acceptRequestMouseOver);
            this.btnAcceptRequest.buttonCore.addMouseOutListerner(this.generalButtonMouseOutSub);
            this.btnDeclineRequest.buttonCore.addMouseOverListerner(this.declineRequestMouseOver);
            this.btnDeclineRequest.buttonCore.addMouseOutListerner(this.generalButtonMouseOutSub);
            this.btnKickMember.buttonCore.addMouseOverListerner(this.kickMemberMouseOver);
            this.btnKickMember.buttonCore.addMouseOutListerner(this.generalButtonMouseOutSub);
            this.btnLeaveClan.buttonCore.addMouseOverListerner(this.leaveClanMouseOver);
            this.btnLeaveClan.buttonCore.addMouseOutListerner(this.generalButtonMouseOutSub);
            this.btnInspect.buttonCore.addMouseOverListerner(this.inspectMouseOver);
            this.btnInspect.buttonCore.addMouseOutListerner(this.generalButtonMouseOutSub);
         }
         if(dataM.runAsMobile)
         {
            this._fingerWheeling = new BMFingerWheeling();
            this._fingerWheeling.initialize("clan",this.membersTileList,this.mcFingerWheeling,this.memberClicked,null,false);
            addChild(this._fingerWheeling);
         }
         else
         {
            this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
            this.mcFingerWheeling = null;
         }
         this.refreshButtons();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._fingerWheeling != null)
         {
            this._fingerWheeling.onEnterFrameTrigger();
         }
      }
      
      public function addAndRefreshMembersTileList() : void
      {
         var _loc6_:uint = 0;
         var _loc8_:Object = null;
         var _loc11_:ClanMemberListHeader = null;
         var _loc12_:BMClanMemberData = null;
         var _loc13_:BMClanMemberData = null;
         var _loc14_:Object = null;
         var _loc15_:uint = 0;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:ClanMemberListRow = null;
         var _loc19_:ClanListRowDataForMembers = null;
         var _loc20_:String = null;
         var _loc21_:BMItem = null;
         var _loc22_:BMTileListItem = null;
         var _loc23_:Function = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this.membersTileList == null)
         {
            this.membersTileList = new BMTileList();
         }
         else
         {
            this.membersTileList.removeAllItems();
         }
         var _loc2_:Array = new Array();
         var _loc3_:uint = this.MEMBERS_ROWS;
         var _loc4_:uint = this.MEMBERS_ITEM_WIDTH;
         var _loc5_:uint = this.MEMBERS_ITEM_HEIGHT;
         if(dataM.runAsMobile)
         {
            _loc3_ = this.MEMBERS_ROWS_MOBILE;
            _loc4_ = this.MEMBERS_ITEM_WIDTH_MOBILE;
            _loc5_ = this.MEMBERS_ITEM_HEIGHT_MOBILE;
         }
         var _loc7_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc1_.clanMembers)
         {
            _loc12_ = _loc1_.clanData.members[_loc6_];
            _loc8_ = {
               "type":"member",
               "playerID":_loc12_.playerID,
               "name":_loc12_.name,
               "level":_loc12_.level,
               "ladderProgress":_loc12_.ladderProgress,
               "lastOnline":_loc12_.lastLogin,
               "isOnline":_loc12_.isOnline,
               "geo":_loc12_.geo,
               "rankedValue":_loc12_.rankedValue,
               "ladderWins":_loc12_.ladderWins
            };
            _loc7_.push(_loc8_);
            _loc6_++;
         }
         if(_loc1_.clanMembers < dataM.clanMaxMembers)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc1_.clan_playersRequestedToJoin.length)
            {
               _loc13_ = _loc1_.clan_playersRequestedToJoin[_loc6_];
               _loc8_ = {
                  "type":"request",
                  "playerID":_loc13_.playerID,
                  "name":_loc13_.name,
                  "level":_loc13_.level,
                  "ladderProgress":_loc13_.ladderProgress,
                  "lastOnline":_loc13_.lastLogin,
                  "isOnline":_loc13_.isOnline,
                  "geo":_loc13_.geo,
                  "rankedValue":_loc13_.rankedValue,
                  "ladderWins":_loc13_.ladderWins
               };
               _loc7_.push(_loc8_);
               _loc6_++;
            }
         }
         _loc6_ = 0;
         while(_loc6_ < _loc7_.length)
         {
            _loc14_ = _loc7_[_loc6_];
            _loc15_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc14_.ladderProgress));
            _loc16_ = _loc14_.geo;
            _loc17_ = this.getLastOnlineText(_loc14_);
            _loc18_ = new mcClanMemberRow();
            _loc19_ = new ClanListRowDataForMembers(_loc14_.level,_loc14_.name,_loc15_,_loc16_,_loc14_.rankedValue,_loc14_.ladderWins,_loc17_);
            _loc18_.initialize(_loc19_);
            _loc20_ = screensM.screenClanMenu.getMemberRowBackground(this._selectedMemberSlot,_loc18_,_loc14_,_loc6_);
            _loc18_.setBackground(_loc20_);
            _loc21_ = new BMItem();
            _loc21_.initialize(_loc14_.playerID,_loc4_,_loc5_,_loc18_,0,0,false,null,dataM.runAsMobile);
            _loc22_ = new BMTileListItem();
            _loc23_ = this.memberClicked;
            if(dataM.runAsMobile)
            {
               _loc23_ = null;
            }
            _loc22_.initialize(_loc4_,_loc5_,_loc21_,"","","",0,_loc23_,null,null,null,null,dataM.runAsMobile);
            _loc2_.push(_loc22_);
            _loc6_++;
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
            _loc11_ = new mcClanMemberHeader_mobile();
         }
         else
         {
            _loc11_ = new mcClanMemberHeader();
         }
         _loc11_.initialize(getGeneralText("levelCaps"),getGeneralText("nameCaps"),getGeneralText("arenaPointsCaps"),getSpecificText("rankingList_wins"),getGeneralText("lastOnlineCaps"));
         this.membersTileList.initialize(screensM.clientPointer.stage,_loc2_,_loc3_,1,_loc4_,_loc5_,null,true,_loc10_,null,_loc11_,false,-1,1,true,_loc9_,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            this.membersTileList.x = this.mcSizer_tileList.x - 4;
         }
         else
         {
            this.membersTileList.x = this.mcSizer_tileList.x;
         }
         this.membersTileList.y = this.mcSizer_tileList.y;
         this.mcButtonsHolder.addChild(this.membersTileList);
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this.membersTileList);
            this._fingerWheeling.addMouseListeners();
         }
      }
      
      private function memberClicked(param1:Number, param2:Number) : void
      {
         var _loc5_:BMTileListItem = null;
         var _loc6_:BMPlayerProfile = null;
         if(param1 == this._selectedMemberSlot)
         {
            return;
         }
         var _loc3_:Number = this._selectedMemberSlot;
         if(_loc3_ > -1)
         {
            _loc5_ = this.membersTileList.findTileListItemByTileID(_loc3_);
            _loc6_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc3_ >= _loc6_.clanMembers)
            {
               _loc5_.item.itemGrp.mcBackground.gotoAndStop("online");
            }
            else if(_loc6_.clanLeaderID == _loc5_.item.ID)
            {
               _loc5_.item.itemGrp.mcBackground.gotoAndStop("top10");
            }
            else if(_loc3_ % 2 == 0)
            {
               _loc5_.item.itemGrp.mcBackground.gotoAndStop("regular2");
            }
            else
            {
               _loc5_.item.itemGrp.mcBackground.gotoAndStop("regular1");
            }
         }
         this._selectedMemberSlot = param1;
         var _loc4_:BMTileListItem = this.membersTileList.findTileListItemByTileID(this._selectedMemberSlot);
         if(_loc4_ != null)
         {
            _loc4_.item.itemGrp.mcBackground.gotoAndStop("self");
         }
         this.refreshButtons();
      }
      
      private function getLastOnlineText(param1:Object) : String
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:String = "";
         if(param1.playerID == dataM.userID)
         {
            return _loc2_;
         }
         if(param1.isOnline)
         {
            return "<FONT COLOR=\'#" + dataM.chatData.COLOR_FRIEND + "\'>Online</FONT>";
         }
         if(param1.lastOnline == null)
         {
            return _loc2_;
         }
         var _loc3_:Date = dataM.convertStringIntoDate(param1.lastOnline);
         var _loc4_:Number = dataM.currentTime - Math.floor(_loc3_.getTime() / 1000) - dataM.serverTimeDifferece;
         if(_loc4_ < 3600)
         {
            _loc5_ = Math.floor(_loc4_ / 60);
            if(_loc5_ < 1)
            {
               _loc5_ = 1;
            }
            if(_loc5_ == 1)
            {
               _loc2_ = _loc5_ + " minute ago";
            }
            else
            {
               _loc2_ = _loc5_ + " minutes ago";
            }
         }
         else if(_loc4_ < 86400)
         {
            _loc6_ = Math.floor(_loc4_ / 3600);
            if(_loc6_ < 1)
            {
               _loc6_ = 1;
            }
            if(_loc6_ == 1)
            {
               _loc2_ = _loc6_ + " hour ago";
            }
            else
            {
               _loc2_ = _loc6_ + " hours ago";
            }
         }
         else
         {
            _loc7_ = Math.floor(_loc4_ / 86400);
            if(_loc7_ < 1)
            {
               _loc7_ = 1;
            }
            if(_loc7_ == 1)
            {
               _loc2_ = _loc7_ + " day ago";
            }
            else
            {
               _loc2_ = _loc7_ + " days ago";
            }
         }
         return _loc2_;
      }
      
      public function removePlayerFromTileList(param1:uint) : void
      {
         if(param1 == this._selectedMemberSlot)
         {
            this._selectedMemberSlot = -1;
            this.refreshButtons();
         }
         this.addAndRefreshMembersTileList();
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
      
      private function refreshButtons() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         this.btnAcceptRequest.visible = false;
         this.btnDeclineRequest.visible = false;
         this.btnInspect.visible = false;
         this.btnKickMember.visible = false;
         if(this._selectedMemberSlot > -1)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc1_.clanLeaderID == dataM.userID)
            {
               if(this._selectedMemberSlot < _loc1_.clanMembers)
               {
                  _loc2_ = _loc1_.clanData.members[this._selectedMemberSlot].playerID;
                  if(dataM.userID != _loc2_)
                  {
                     this.btnKickMember.visible = true;
                  }
               }
               else
               {
                  this.btnAcceptRequest.visible = true;
                  this.btnDeclineRequest.visible = true;
               }
            }
            this.btnInspect.visible = true;
         }
      }
      
      public function declineRequestMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("declineRequest"),-1,-1);
      }
      
      public function declineRequestClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = this._selectedMemberSlot - _loc1_.clanMembers;
         var _loc3_:BMClanMemberData = _loc1_.clan_playersRequestedToJoin[_loc2_];
         remoteM.socketM.clan_declineRequest(_loc3_.playerID);
         _loc1_.clan_playersRequestedToJoin.splice(_loc2_,1);
         this.removePlayerFromTileList(_loc1_.clanMembers + _loc2_);
      }
      
      public function acceptRequestMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("acceptNewMember"),-1,-1);
      }
      
      private function generalButtonMouseOut(param1:MouseEvent) : void
      {
         this.generalButtonMouseOutSub();
      }
      
      private function generalButtonMouseOutSub() : void
      {
         tooltip.hideToolTip();
      }
      
      public function acceptRequestClicked() : void
      {
         var _loc1_:BMTileListItem = this.membersTileList.findTileListItemByTileID(this._selectedMemberSlot);
         var _loc2_:Number = _loc1_.item.ID;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc4_:Number = _loc3_.clan_playersRequestedToJoin.length - 1;
         while(_loc4_ >= 0)
         {
            if(_loc3_.clan_playersRequestedToJoin[_loc4_].playerID == _loc2_)
            {
               _loc3_.clan_playersRequestedToJoin.splice(_loc4_,1);
            }
            _loc4_--;
         }
         dataM.clan_tryToAcceptPlayerID = _loc2_;
         remoteM.socketM.clan_acceptNewMember(_loc2_);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
      }
      
      public function playerRequestsToJoin() : void
      {
         this.addAndRefreshMembersTileList();
      }
      
      public function playerCancelledRequestToJoin(param1:uint) : void
      {
         this.removePlayerFromTileList(param1);
      }
      
      public function acceptNewMemberFailed(param1:uint) : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("joinClanRequestNotValid",-1,-1);
         this.removePlayerFromTileList(param1);
      }
      
      public function kickMemberMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("kickMember"),-1,-1);
      }
      
      public function kickMemberClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("tryToKickMember",this._selectedMemberSlot,-1);
      }
      
      public function youWereKickedFromClan() : void
      {
         screensM.screenTransitionsManager.multiplayerLadderClicked(false,true);
      }
      
      public function inspectClicked() : void
      {
         screensM.screenClanMenu.inspectPlayer(this._selectedMemberSlot);
      }
      
      public function inspectMouseOver() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this._selectedMemberSlot >= _loc1_.clanMembers)
         {
            tooltip.showToolTip("regularText",getScreenText("inspectPlayer"),-1,-1);
         }
         else
         {
            tooltip.showToolTip("regularText",getScreenText("inspectMember"),-1,-1);
         }
      }
      
      public function leaveClanMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("leaveClan"),-1,-1);
      }
      
      public function leaveClanClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("tryToLeaveClan",-1,-1);
      }
      
      public function membersUpdate() : void
      {
         this.resetSelectedMemberSlot();
         this.addAndRefreshMembersTileList();
         this.refreshButtons();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CLAN_MEMBERS);
      }
   }
}

