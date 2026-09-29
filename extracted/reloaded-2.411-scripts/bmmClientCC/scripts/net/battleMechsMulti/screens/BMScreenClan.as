package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureC;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureD;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureI;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1577")]
   public class BMScreenClan extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnAcceptRequest:Sprite;
      
      public var mcSizer_btnDeclineRequest:Sprite;
      
      public var mcSizer_btnKickMember:Sprite;
      
      public var mcSizer_btnLeaveClan:Sprite;
      
      public var mcSizer_btnInspect:Sprite;
      
      public var mcSizer_btnChat:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_medals:Sprite;
      
      public var mcTooltipMedals:Sprite;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcSizer_rank:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcSizer_flag:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtStats:TextField;
      
      public var txtMembers:TextField;
      
      public var btnAcceptRequest:BMButton_pictureD;
      
      public var btnDeclineRequest:BMButton_pictureC;
      
      public var btnKickMember:BMButton_pictureC;
      
      public var btnLeaveClan:BMButton_pictureC;
      
      public var btnInspect:BMButton_pictureE;
      
      public var btnChat:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureI;
      
      public var mcPendingClanMessages:MovieClip;
      
      public var mcFlagHitArea:Sprite;
      
      private var mcClanFlag:BMClanFlag;
      
      private var mcRank:Sprite;
      
      private var membersTileList:BMTileList;
      
      private var _selectedMemberSlot:Number;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _refreshClanDataCooldown:Number = 0;
      
      private var _rerunRefreshScreen:Boolean = false;
      
      private var _pendingClanMessagesOriginYPos:Number;
      
      private var _pendingClanMessagesFrameCounter:Number;
      
      private var _medals:Array = new Array();
      
      private var _medalsBM:Bitmap;
      
      private var _medalsBMD:BitmapData;
      
      private var _sparks:Array = new Array();
      
      private var _firstRefresh:Boolean = true;
      
      private const MEMBERS_ITEM_WIDTH:uint = 450;
      
      private const MEMBERS_ITEM_HEIGHT:uint = 30;
      
      private const MEMBERS_ROWS:uint = 6;
      
      private const MEMBERS_ITEM_WIDTH_MOBILE:uint = 500;
      
      private const MEMBERS_ITEM_HEIGHT_MOBILE:uint = 33;
      
      private const MEMBERS_ROWS_MOBILE:uint = 5;
      
      private const REFRESH_CLAN_DATA_COOLDOWN_FRAMES:uint = 1000;
      
      public function BMScreenClan()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("clan");
      }
      
      public function refreshScreen() : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenClan","btnAcceptRequest","pictureD");
            screensM.createButtonFromSizer("screenClan","btnDeclineRequest","pictureC");
            screensM.createButtonFromSizer("screenClan","btnKickMember","pictureC");
            screensM.createButtonFromSizer("screenClan","btnLeaveClan","pictureC");
            screensM.createButtonFromSizer("screenClan","btnInspect","pictureE");
            screensM.createButtonFromSizer("screenClan","btnChat","pictureE");
            screensM.createButtonFromSizer("screenClan","btnBack","pictureI");
            _loc2_ = this.acceptRequestClicked;
            _loc3_ = this.declineRequestClicked;
            _loc4_ = this.kickMemberClicked;
            _loc5_ = this.leaveClanClicked;
            _loc6_ = this.inspectClicked;
            _loc7_ = this.chatClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
            }
            this.btnAcceptRequest.initialize("","",externalAssetsM.getAsset("general","interface_V"),null,_loc2_,dataM.runAsMobile);
            this.btnDeclineRequest.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc3_,dataM.runAsMobile);
            this.btnKickMember.initialize("","",externalAssetsM.getAsset("general","interface_clanKick"),null,_loc4_,dataM.runAsMobile);
            this.btnLeaveClan.initialize("","",externalAssetsM.getAsset("general","interface_clanLeave"),null,_loc5_,dataM.runAsMobile);
            this.btnInspect.initialize("","",externalAssetsM.getAsset("general","interface_inspect"),null,_loc6_,dataM.runAsMobile);
            this.btnChat.initialize("","",externalAssetsM.getAsset("general","interface_chat"),null,_loc7_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnAcceptRequest.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnDeclineRequest.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnKickMember.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnLeaveClan.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnInspect.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChat.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
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
               this.btnChat.buttonCore.addMouseOverListerner(this.chatMouseOver);
               this.btnChat.buttonCore.addMouseOutListerner(this.generalButtonMouseOutSub);
               this.mcFlagHitArea.addEventListener(MouseEvent.CLICK,this.editFlagClicked);
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
            this._refreshClanDataCooldown = this.REFRESH_CLAN_DATA_COOLDOWN_FRAMES;
            this._pendingClanMessagesOriginYPos = this.mcPendingClanMessages.y;
            this._firstRefresh = false;
            this.languageUpdate();
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._pendingClanMessagesFrameCounter = 0;
         this.mcPendingClanMessages.mouseEnabled = false;
         this.mcPendingClanMessages.mouseChildren = false;
         this.refreshPendingClanMessagesCounter();
         if(this.mcClanFlag != null)
         {
            this.mcClanFlag.removeMe();
            this.mcClanFlag = null;
         }
         if(this._refreshClanDataCooldown == 0)
         {
            this.btnAcceptRequest.visible = false;
            this.btnDeclineRequest.visible = false;
            this.btnKickMember.visible = false;
            this.btnInspect.visible = false;
            this.txtTitle.text = "";
            this.txtStats.htmlText = "";
            this.txtMembers.htmlText = "";
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("clan_title",[this.txtTitle],"",this);
               screensM.createMultipleTextsBitmap("clan_stats",[this.txtStats,this.txtMembers],"",this);
            }
            this._rerunRefreshScreen = true;
            this._refreshClanDataCooldown = this.REFRESH_CLAN_DATA_COOLDOWN_FRAMES;
            remoteM.socketM.clan_getClanData(_loc1_.clanID);
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         }
         else
         {
            this._selectedMemberSlot = -1;
            this.refreshButtons();
            this.txtTitle.text = _loc1_.clan_name;
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("clan_title",[this.txtTitle],"",this);
            }
            _loc8_ = getScreenText("ladderWins");
            if(_loc1_.clan_ladderBattles > 0)
            {
               _loc10_ = Math.ceil(_loc1_.clan_ladderWins / _loc1_.clan_ladderBattles * 100);
               _loc8_ = dataM.replaceStringInText(_loc8_,"%WINS%",dataM.getNumberWithComma(_loc1_.clan_ladderWins));
               _loc8_ = dataM.replaceStringInText(_loc8_,"%BATTLES%",dataM.getNumberWithComma(_loc1_.clan_ladderBattles) + " <FONT COLOR=\'#B2B2B2\'>( " + _loc10_ + "% )</FONT>");
            }
            else
            {
               _loc8_ = dataM.replaceStringInText(_loc8_,"%WINS%","0");
               _loc8_ = dataM.replaceStringInText(_loc8_,"%BATTLES%","0");
            }
            this.txtStats.htmlText = TextUtils.getTextFont() + _loc8_;
            _loc9_ = getScreenText("members");
            _loc9_ = dataM.replaceStringInText(_loc9_,"%CURRENT%",String(_loc1_.clan_members.length));
            _loc9_ = dataM.replaceStringInText(_loc9_,"%MAX%",String(dataM.clanMaxMembers));
            this.txtMembers.htmlText = TextUtils.getTextFont() + _loc9_;
            this.refreshMedals();
            this.refreshRank();
            this.addAndRefreshMembersTileList();
            this.createFlag();
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("clan_stats",[this.txtStats,this.txtMembers],"",this);
            }
            else
            {
               this.mcTooltipMedals.addEventListener(MouseEvent.MOUSE_OVER,this.medalsMouseOver);
               this.mcTooltipMedals.addEventListener(MouseEvent.MOUSE_OUT,this.generalButtonMouseOut);
               this.mcTooltipMedals.addEventListener(MouseEvent.MOUSE_UP,this.generalButtonMouseOut);
            }
         }
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtMembers,20);
            TextUtils.updateTextFormat(this.txtStats,20);
            TextUtils.updateTextFormat(this.txtTitle,20);
         }
      }
      
      public function checkForRefreshingScreen() : void
      {
         if(this._rerunRefreshScreen)
         {
            this._rerunRefreshScreen = false;
            this.refreshScreen();
            screensM.removeScreen("screenConfirmation");
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._refreshClanDataCooldown > 0)
         {
            --this._refreshClanDataCooldown;
         }
         if(parent != null)
         {
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.onEnterFrameTrigger();
            }
            this.sparksHandler();
            if(this.mcPendingClanMessages.visible)
            {
               this.mcPendingClanMessages.y += (this._pendingClanMessagesFrameCounter - 10) / 2;
               ++this._pendingClanMessagesFrameCounter;
               if(this._pendingClanMessagesFrameCounter >= 20)
               {
                  this._pendingClanMessagesFrameCounter = 0;
                  this.mcPendingClanMessages.y = this._pendingClanMessagesOriginYPos;
               }
            }
         }
      }
      
      public function resetRefreshClanDataCooldown() : void
      {
         this._refreshClanDataCooldown = 0;
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      private function addAndRefreshMembersTileList() : void
      {
         var _loc6_:uint = 0;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc14_:MovieClip = null;
         var _loc15_:String = null;
         var _loc16_:MovieClip = null;
         var _loc17_:String = null;
         var _loc18_:uint = 0;
         var _loc19_:Number = NaN;
         var _loc20_:Sprite = null;
         var _loc21_:Boolean = false;
         var _loc22_:BMItem = null;
         var _loc23_:BMTileListItem = null;
         var _loc24_:Function = null;
         var _loc25_:Date = null;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:BMAvatarImage = null;
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
         while(_loc6_ < _loc1_.clan_members.length)
         {
            _loc9_ = _loc1_.clan_members[_loc6_];
            _loc8_ = {
               "type":"member",
               "playerID":_loc9_.playerID,
               "name":_loc9_.name,
               "level":_loc9_.level,
               "ladderProgress":_loc9_.ladderProgress,
               "lastOnline":_loc9_.lastLogin,
               "isOnline":_loc9_.isOnline,
               "geo":_loc9_.geo
            };
            _loc7_.push(_loc8_);
            _loc6_++;
         }
         if(_loc1_.clan_members.length < dataM.clanMaxMembers)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc1_.clan_playersRequestedToJoin.length)
            {
               _loc9_ = _loc1_.clan_playersRequestedToJoin[_loc6_];
               _loc8_ = {
                  "type":"request",
                  "playerID":_loc9_.playerID,
                  "name":_loc9_.name,
                  "level":_loc9_.level,
                  "ladderProgress":_loc9_.ladderProgress,
                  "lastOnline":_loc9_.lastLogin,
                  "isOnline":_loc9_.isOnline,
                  "geo":_loc9_.geo
               };
               _loc7_.push(_loc8_);
               _loc6_++;
            }
         }
         var _loc10_:uint = 13;
         var _loc11_:uint = 15;
         switch(dataM.languageID)
         {
            case 3:
               _loc10_ = 13;
               _loc11_ = 15;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc6_];
            _loc15_ = "";
            if(_loc9_.playerID != dataM.userID)
            {
               if(_loc9_.isOnline)
               {
                  _loc15_ = "<FONT COLOR=\'#" + dataM.COLOR_FRIEND + "\'>Online</FONT>";
               }
               else if(_loc9_.lastOnline != null)
               {
                  _loc25_ = dataM.convertStringIntoDate(_loc9_.lastOnline);
                  _loc26_ = dataM.currentTime - Math.floor(_loc25_.getTime() / 1000) - dataM.serverTimeDifferece;
                  if(_loc26_ < 3600)
                  {
                     _loc27_ = Math.floor(_loc26_ / 60);
                     if(_loc27_ < 1)
                     {
                        _loc27_ = 1;
                     }
                     if(_loc27_ == 1)
                     {
                        _loc15_ = _loc27_ + " minute ago";
                     }
                     else
                     {
                        _loc15_ = _loc27_ + " minutes ago";
                     }
                  }
                  else if(_loc26_ < 86400)
                  {
                     _loc28_ = Math.floor(_loc26_ / 3600);
                     if(_loc28_ < 1)
                     {
                        _loc28_ = 1;
                     }
                     if(_loc28_ == 1)
                     {
                        _loc15_ = _loc28_ + " hour ago";
                     }
                     else
                     {
                        _loc15_ = _loc28_ + " hours ago";
                     }
                  }
                  else
                  {
                     _loc29_ = Math.floor(_loc26_ / 86400);
                     if(_loc29_ < 1)
                     {
                        _loc29_ = 1;
                     }
                     if(_loc29_ == 1)
                     {
                        _loc15_ = _loc29_ + " day ago";
                     }
                     else
                     {
                        _loc15_ = _loc29_ + " days ago";
                     }
                  }
               }
            }
            _loc16_ = new mcClanMemberRow();
            _loc17_ = "regular1";
            if(_loc9_.type == "request")
            {
               _loc17_ = "online";
            }
            else if(_loc1_.clan_leaderPlayerID == _loc9_.playerID)
            {
               _loc17_ = "top10";
            }
            else if(_loc6_ == this._selectedMemberSlot)
            {
               _loc17_ = "self";
            }
            else if(_loc6_ % 2 == 0)
            {
               _loc17_ = "regular2";
            }
            _loc16_.mcBackground.gotoAndStop(_loc17_);
            _loc18_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc9_.ladderProgress));
            _loc19_ = Number(_loc16_.mcSizer_rank.width);
            _loc20_ = externalAssetsM.getAsset("general","Grp_rank" + _loc18_,_loc19_,_loc19_,false,false);
            _loc20_.x = _loc16_.mcSizer_rank.x;
            _loc20_.y = _loc16_.mcSizer_rank.y;
            _loc16_.addChild(_loc20_);
            switch(_loc9_.lastDevice)
            {
               case "1":
               case "2":
                  _loc16_.txtName.width -= 18;
                  break;
               default:
                  _loc16_.mcMobileDevice.parent.removeChild(_loc16_.mcMobileDevice);
                  _loc16_.mcMobileDevice = null;
            }
            _loc21_ = false;
            if(_loc9_.geo != null && _loc9_.geo != "")
            {
               _loc21_ = true;
            }
            if(_loc21_)
            {
               _loc30_ = dataM.getAvatarImage(_loc9_.geo);
               _loc30_.x = _loc16_.mcSizer_flag.x;
               _loc30_.y = _loc16_.mcSizer_flag.y;
               _loc16_.addChild(_loc30_);
            }
            TextUtils.updateTextFormat(_loc16_.txtLevel,_loc11_);
            TextUtils.updateTextFormat(_loc16_.txtName,_loc11_);
            TextUtils.updateTextFormat(_loc16_.txtLastOnline,_loc11_);
            _loc16_.txtLastOnline.htmlText = TextUtils.getTextFont(_loc11_) + _loc15_;
            _loc16_.txtLevel.text = String(_loc9_.level);
            _loc16_.txtName.text = _loc9_.name;
            _loc22_ = new BMItem();
            _loc22_.initialize(_loc9_.playerID,_loc4_,_loc5_,_loc16_,0,0,false,null,dataM.runAsMobile);
            if(dataM.runAsMobile)
            {
               _loc22_.createAssetsBitmap([_loc16_.txtName,_loc16_.txtLevel,_loc16_.txtLastOnline],[_loc20_],_loc16_);
            }
            _loc23_ = new BMTileListItem();
            _loc24_ = this.memberClicked;
            if(dataM.runAsMobile)
            {
               _loc24_ = null;
            }
            _loc23_.initialize(_loc4_,_loc5_,_loc22_,"","","",0,_loc24_,null,null,null,null,dataM.runAsMobile);
            _loc2_.push(_loc23_);
            _loc6_++;
         }
         var _loc12_:Boolean = false;
         if(dataM.runAsMobile)
         {
            _loc12_ = true;
            this.membersTileList.activateExtendedMode(0.35,true);
         }
         var _loc13_:MovieClip = new Grp_scrollerContent();
         if(dataM.runAsMobile)
         {
            _loc14_ = new mcClanMemberHeader_mobile();
         }
         else
         {
            _loc14_ = new mcClanMemberHeader();
         }
         TextUtils.updateTextFormat(_loc14_.txtLevel,_loc10_);
         TextUtils.updateTextFormat(_loc14_.txtName,_loc10_);
         TextUtils.updateTextFormat(_loc14_.txtLastOnline,_loc10_);
         _loc14_.txtLevel.text = getGeneralText("levelCaps");
         _loc14_.txtName.text = getGeneralText("nameCaps");
         _loc14_.txtLastOnline.text = getGeneralText("lastOnlineCaps");
         this.membersTileList.initialize(screensM.clientPointer.stage,_loc2_,_loc3_,1,_loc4_,_loc5_,null,true,_loc13_,null,_loc14_,false,-1,1,true,_loc12_,dataM.runAsMobile);
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
         var _loc3_:Number = NaN;
         var _loc4_:BMTileListItem = null;
         var _loc5_:BMTileListItem = null;
         var _loc6_:BMPlayerProfile = null;
         if(param1 != this._selectedMemberSlot)
         {
            _loc3_ = this._selectedMemberSlot;
            if(_loc3_ > -1)
            {
               _loc5_ = this.membersTileList.findTileListItemByTileID(_loc3_);
               _loc6_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc3_ >= _loc6_.clan_members.length)
               {
                  _loc5_.item.itemGrp.mcBackground.gotoAndStop("online");
               }
               else if(_loc6_.clan_leaderPlayerID == _loc5_.item.ID)
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
            _loc4_ = this.membersTileList.findTileListItemByTileID(this._selectedMemberSlot);
            if(_loc4_ != null)
            {
               _loc4_.item.itemGrp.mcBackground.gotoAndStop("self");
            }
            this.refreshButtons();
         }
      }
      
      public function resetSelectedMemberSlot() : void
      {
         this._selectedMemberSlot = -1;
      }
      
      private function removeMedals() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(this._medals != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._medals.length)
            {
               _loc2_ = this._medals[_loc1_];
               if(_loc2_.parent != null)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               this._medals[_loc1_] = null;
               _loc1_++;
            }
         }
         this._medals = new Array();
      }
      
      private function refreshMedals() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:MovieClip = null;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Sprite = null;
         var _loc11_:Number = NaN;
         var _loc12_:Array = null;
         this.removeMedals();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Number = 0;
         if(dataM.weeklyTopClans[_loc1_.clanID] != null)
         {
            _loc8_ = 0;
            _loc9_ = 0;
            _loc4_ = 3;
            while(_loc4_ >= 1)
            {
               _loc5_ = Number(dataM.weeklyTopClans[_loc1_.clanID].places[_loc4_]);
               if(_loc5_ > 0)
               {
                  _loc3_ = 1;
                  while(_loc3_ <= _loc5_)
                  {
                     _loc6_ = "medalClan" + _loc4_;
                     if(_loc5_ - _loc3_ >= 9)
                     {
                        _loc3_ += 9;
                        _loc6_ += "_10";
                     }
                     else if(_loc5_ - _loc3_ >= 4)
                     {
                        _loc3_ += 4;
                        _loc6_ += "_5";
                     }
                     else if(_loc5_ - _loc3_ >= 2)
                     {
                        _loc3_ += 2;
                        _loc6_ += "_3";
                     }
                     _loc7_ = externalAssetsM.getAsset("general",_loc6_);
                     if(_loc9_ == 0)
                     {
                        _loc9_ = this.mcSizer_medals.x + this.mcSizer_medals.width + _loc7_.width / 2;
                     }
                     _loc7_.x = _loc9_ - (1 + this._medals.length) * _loc7_.width;
                     _loc7_.y = this.mcSizer_medals.y;
                     if(this._medals.length % 2 == 1)
                     {
                        _loc7_.gotoAndStop("long");
                     }
                     this.mcIconsHolder.addChild(_loc7_);
                     this._medals.push(_loc7_);
                     _loc8_++;
                     _loc3_++;
                  }
               }
               _loc4_--;
            }
            if(_loc8_ > 1)
            {
               _loc10_ = this._medals[this._medals.length - 1];
               if(_loc10_.x < this.mcSizer_medals.x + 15)
               {
                  _loc11_ = this.mcSizer_medals.x + 15 - _loc10_.x;
                  _loc3_ = this._medals.length - 1;
                  while(_loc3_ > 0)
                  {
                     this._medals[_loc3_].x += _loc11_ / (this._medals.length - 1) * _loc3_;
                     _loc3_--;
                  }
               }
            }
         }
         if(dataM.runAsMobile)
         {
            if(this._medalsBMD != null)
            {
               this._medalsBMD.dispose();
               this._medalsBMD = null;
            }
            if(this._medalsBM != null)
            {
               this._medalsBM.parent.removeChild(this._medalsBM);
               this._medalsBM = null;
            }
            if(this._medals.length > 0)
            {
               _loc12_ = screensM.createAssetsBitmap([],this._medals,15,15);
               this._medalsBMD = _loc12_[0];
               this._medalsBM = _loc12_[1];
               this.mcIconsHolder.addChild(this._medalsBM);
            }
         }
      }
      
      private function medalsMouseOver(param1:MouseEvent) : void
      {
         this.medalsMouseOverSub();
      }
      
      public function medalsMouseOverSub() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:String = "";
         if(_loc1_.clanID > 0)
         {
            if(dataM.weeklyTopClans[_loc1_.clanID] != null)
            {
               _loc3_ = "<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>";
               _loc4_ = "</FONT>";
               _loc5_ = uint(dataM.weeklyTopClans[_loc1_.clanID].places[1]);
               _loc6_ = uint(dataM.weeklyTopClans[_loc1_.clanID].places[2]);
               _loc7_ = uint(dataM.weeklyTopClans[_loc1_.clanID].places[3]);
               if(_loc5_ > 0 || _loc6_ > 0 || _loc7_ > 0)
               {
                  if(_loc2_ == "")
                  {
                     _loc2_ = "Clan weekly wins:";
                  }
                  else
                  {
                     _loc2_ += "<BR>Clan weekly wins:";
                  }
                  if(_loc5_ > 0)
                  {
                     _loc2_ = _loc2_ + "<BR>   First place: " + _loc3_ + _loc5_ + _loc4_;
                  }
                  if(_loc6_ > 0)
                  {
                     _loc2_ = _loc2_ + "<BR>   Second place: " + _loc3_ + _loc6_ + _loc4_;
                  }
                  if(_loc7_ > 0)
                  {
                     _loc2_ = _loc2_ + "<BR>   Third place: " + _loc3_ + _loc7_ + _loc4_;
                  }
                  tooltip.showToolTip("regularText",_loc2_,-1,-1);
               }
            }
         }
      }
      
      private function refreshRank() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this.mcRank != null)
         {
            this.mcRank.parent.removeChild(this.mcRank);
            this.mcRank = null;
         }
         var _loc2_:uint = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc1_.clan_ladderProgress));
         this.mcRank = externalAssetsM.getAsset("general","Grp_rank" + _loc2_,this.mcSizer_rank.width,this.mcSizer_rank.height,false,false);
         this.mcRank.x = this.mcSizer_rank.x;
         this.mcRank.y = this.mcSizer_rank.y;
         this.mcIconsHolder.addChild(this.mcRank);
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
            if(_loc1_.clan_leaderPlayerID == dataM.userID)
            {
               if(this._selectedMemberSlot < _loc1_.clan_members.length)
               {
                  _loc2_ = Number(_loc1_.clan_members[this._selectedMemberSlot].playerID);
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
         var _loc2_:uint = this._selectedMemberSlot - _loc1_.clan_members.length;
         var _loc3_:Object = _loc1_.clan_playersRequestedToJoin[_loc2_];
         remoteM.socketM.clan_declineRequest(_loc3_.playerID);
         _loc1_.clan_playersRequestedToJoin.splice(_loc2_,1);
         this.removePlayerFromTileList(_loc1_.clan_members.length + _loc2_);
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
      
      private function removePlayerFromTileList(param1:uint) : void
      {
         if(param1 == this._selectedMemberSlot)
         {
            this._selectedMemberSlot = -1;
            this.refreshButtons();
         }
         this.addAndRefreshMembersTileList();
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
         screensM.screenNewMenu.multiplayerLadderClicked(false,true);
      }
      
      public function inspectClicked() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Object = null;
         if(this._selectedMemberSlot > -1)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(this._selectedMemberSlot >= _loc1_.clan_members.length)
            {
               _loc2_ = _loc1_.clan_playersRequestedToJoin[this._selectedMemberSlot - _loc1_.clan_members.length];
            }
            else
            {
               _loc2_ = _loc1_.clan_members[this._selectedMemberSlot];
            }
            screensM.addScreen("screenInspectPlayer");
            screensM.screenInspectPlayer.refreshScreen(_loc2_.playerID,true,_loc2_.name,_loc2_.level,_loc2_.ladderProgress,_loc1_.clanID);
         }
      }
      
      public function inspectMouseOver() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this._selectedMemberSlot >= _loc1_.clan_members.length)
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
      
      public function leftClan() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.clan_members.length == 1 && dataM.clansRankingList[_loc1_.clanID] != null)
         {
            delete dataM.clansRankingList[_loc1_.clanID];
         }
         _loc1_.clanID = 0;
         _loc1_.clan_playersRequestedToJoin = new Array();
         screensM.screenConfirmation.displayQuestionOrNotification("playerHasLeftClan",-1,-1);
      }
      
      private function createFlag() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Array = dataM.getClanFlagData(_loc1_.clan_flag);
         if(_loc2_.length > 0)
         {
            this.mcClanFlag = new BMClanFlag();
            _loc3_ = externalAssetsM.getAsset("general","clanFlag",this.mcSizer_flag.width,this.mcSizer_flag.height,false,false);
            _loc3_.x = this.mcSizer_flag.x;
            _loc3_.y = this.mcSizer_flag.y;
            this.mcClanFlag.initialize(_loc3_,dataM.runAsMobile);
            this.mcClanFlag.updateFlag(_loc2_);
            this.mcIconsHolder.addChild(_loc3_);
         }
      }
      
      private function editFlagClicked(param1:MouseEvent) : void
      {
         this.editFlagClickedSub();
      }
      
      public function editFlagClickedSub() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.clan_leaderPlayerID == dataM.userID)
         {
            screensM.addScreen("screenClanFlag");
            screensM.screenClanFlag.refreshScreen();
            screensM.screenNewMenu.removeCurrentScreen();
            screensM.screenNewMenu.removeMe();
            soundM.createSound("buttonClick",1);
         }
      }
      
      public function chatClicked() : void
      {
         dataM.chat_goToClanChat = true;
         screensM.screenNewMenu.multiplayerChatClicked(false,true);
      }
      
      public function chatMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("chat"),-1,-1);
      }
      
      public function refreshPendingClanMessagesCounter() : void
      {
         var _loc1_:String = null;
         if(dataM.chat_pendingClanMessages == 0)
         {
            this.mcPendingClanMessages.visible = false;
         }
         else
         {
            if(this.mcPendingClanMessages.visible == false)
            {
               this.mcPendingClanMessages.y = this._pendingClanMessagesOriginYPos;
               this.mcPendingClanMessages.visible = true;
               this._pendingClanMessagesFrameCounter = 0;
            }
            if(dataM.chat_pendingClanMessages <= 9)
            {
               _loc1_ = String(dataM.chat_pendingClanMessages);
            }
            else
            {
               _loc1_ = "9+";
            }
            this.mcPendingClanMessages.txtAmount.text = _loc1_;
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("clan_pendingClanMessages",[this.mcPendingClanMessages.txtAmount],"",this.mcPendingClanMessages);
            }
         }
      }
      
      private function sparksHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Sprite = null;
         var _loc7_:Sprite = null;
         var _loc8_:Sprite = null;
         if(this._medals.length > 0)
         {
            _loc2_ = 22 - (this._medals.length - 1);
            if(_loc2_ < 5)
            {
               _loc2_ = 5;
            }
            _loc3_ = Math.ceil(Math.random() * _loc2_);
            if(_loc3_ == 1)
            {
               _loc3_ = Math.ceil(Math.random() * this._medals.length) - 1;
               _loc6_ = this._medals[_loc3_];
               _loc4_ = _loc6_.x;
               _loc5_ = _loc6_.y + _loc6_.height - 10;
               _loc7_ = externalAssetsM.getAsset("general","Grp_itemBoxSpark",0,0,false,false);
               _loc7_.scaleX = 1.3;
               _loc7_.scaleY = 1.3;
               _loc7_.x = _loc4_ + Math.random() * 16 - 8;
               _loc7_.y = _loc5_ + Math.random() * 16 - 8;
               this.mcIconsHolder.addChild(_loc7_);
               this._sparks.push(_loc7_);
            }
         }
         _loc1_ = 0;
         while(_loc1_ < this._sparks.length)
         {
            _loc8_ = this._sparks[_loc1_];
            if(_loc8_.scaleX > 0.075)
            {
               _loc8_.scaleX -= 0.075;
               _loc8_.scaleY -= 0.075;
            }
            else
            {
               this._sparks[_loc1_].parent.removeChild(this._sparks[_loc1_]);
               this._sparks[_loc1_] = null;
               this._sparks.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      public function removeMe() : void
      {
         if(this.membersTileList != null)
         {
            this.membersTileList.removeMe();
            this.membersTileList = null;
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.resetTileList(null);
               this._fingerWheeling.removeMouseListeners();
            }
         }
         screensM.removeScreen("screenClan");
         if(dataM.runAsMobile == false)
         {
            this.mcTooltipMedals.removeEventListener(MouseEvent.MOUSE_OVER,this.medalsMouseOver);
            this.mcTooltipMedals.removeEventListener(MouseEvent.MOUSE_OUT,this.generalButtonMouseOut);
            this.mcTooltipMedals.removeEventListener(MouseEvent.MOUSE_UP,this.generalButtonMouseOut);
         }
         this.removeMedals();
         if(this.mcClanFlag != null)
         {
            this.mcClanFlag.removeMe();
            this.mcClanFlag = null;
         }
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.multiplayerLadderClicked();
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen();
      }
   }
}

