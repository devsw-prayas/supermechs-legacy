package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol993")]
   public class BMScreenMenuMultiPlayerInspect extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var txtName:TextField;
      
      public var txtPlayerID:TextField;
      
      public var mcSizer_btnSendClanInvitation:Sprite;
      
      public var mcSizer_btnAcceptClanInvitation:Sprite;
      
      public var mcSizer_btnDeclineClanInvitation:Sprite;
      
      public var mcSizer_btnSendBattleInvitation:Sprite;
      
      public var mcSizer_btnAcceptBattleInvitation:Sprite;
      
      public var mcSizer_btnDeclineBattleInvitation:Sprite;
      
      public var mcSizer_btnRequestFriendship:Sprite;
      
      public var mcSizer_btnAcceptFriendship:Sprite;
      
      public var mcSizer_btnRemoveFriendship:Sprite;
      
      public var mcSizer_btnBlock:Sprite;
      
      public var mcSizer_btnUnBlock:Sprite;
      
      public var mcSizer_btnClanRequestToJoin:Sprite;
      
      public var mcSizer_btnClanInviteToJoin:Sprite;
      
      public var mcSizer_btnChat:Sprite;
      
      public var mcSizer_btnClose:Sprite;
      
      public var mcSizer_btnInspect:Sprite;
      
      public var btnSendBattleInvitation:BMButton_pictureE;
      
      public var btnAcceptBattleInvitation:BMButton_pictureE;
      
      public var btnDeclineBattleInvitation:BMButton_pictureE;
      
      public var btnSendClanInvitation:BMButton_pictureE;
      
      public var btnAcceptClanInvitation:BMButton_pictureE;
      
      public var btnDeclineClanInvitation:BMButton_pictureE;
      
      public var btnBlock:BMButton_pictureE;
      
      public var btnUnBlock:BMButton_pictureE;
      
      public var btnChat:BMButton_pictureE;
      
      public var btnClose:BMButton_pictureE;
      
      public var btnInspect:BMButton_pictureE;
      
      public var mcSizer_rank:Sprite;
      
      private var mcRank:Sprite;
      
      private var _battleInvitation:Boolean;
      
      private var _clanInvitation:Boolean;
      
      private var _clanMessage:Boolean;
      
      private var _assetsBMD:BitmapData;
      
      private var _assetsBM:Bitmap;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenMenuMultiPlayerInspect()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("multiplayerChat");
      }
      
      private function createTextsAndRankBitmapForMobile() : void
      {
         var _loc1_:Array = null;
         if(dataM.runAsMobile)
         {
            if(this._assetsBMD != null)
            {
               this._assetsBMD.dispose();
               this._assetsBMD = null;
            }
            if(this._assetsBM != null)
            {
               this._assetsBM.parent.removeChild(this._assetsBM);
               this._assetsBM = null;
            }
            _loc1_ = screensM.createAssetsBitmap([this.txtName,this.txtPlayerID],[this.mcRank],0,0);
            this._assetsBMD = _loc1_[0];
            this._assetsBM = _loc1_[1];
            addChild(this._assetsBM);
         }
      }
      
      public function refreshScreen(param1:Number, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         var _loc8_:Function = null;
         var _loc9_:Function = null;
         var _loc10_:Function = null;
         var _loc11_:Function = null;
         var _loc12_:Function = null;
         var _loc13_:Function = null;
         var _loc14_:Function = null;
         var _loc15_:Function = null;
         var _loc16_:Function = null;
         var _loc17_:Function = null;
         var _loc18_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnSendBattleInvitation","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnAcceptBattleInvitation","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnDeclineBattleInvitation","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnSendClanInvitation","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnAcceptClanInvitation","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnDeclineClanInvitation","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnBlock","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnUnBlock","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnChat","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnInspect","pictureE");
            screensM.createButtonFromSizer("screenMenuMultiPlayerInspect","btnClose","pictureE");
            _loc8_ = this.sendBattleInvitationClicked;
            _loc9_ = this.acceptBattleInvitationClicked;
            _loc10_ = this.declineBattleInvitationClicked;
            _loc11_ = this.sendClanInvitationClicked;
            _loc12_ = this.acceptClanInvitationClicked;
            _loc13_ = this.declineClanInvitationClicked;
            _loc14_ = this.blockClicked;
            _loc15_ = this.unBlockClicked;
            _loc16_ = this.chatClicked;
            _loc17_ = this.inspectClicked;
            _loc18_ = this.closeClicked;
            if(dataM.runAsMobile)
            {
               _loc8_ = null;
               _loc9_ = null;
               _loc10_ = null;
               _loc11_ = null;
               _loc12_ = null;
               _loc13_ = null;
               _loc14_ = null;
               _loc15_ = null;
               _loc16_ = null;
               _loc17_ = null;
               _loc18_ = null;
            }
            this.btnSendBattleInvitation.initialize("","",externalAssetsM.getAsset("general","interface_createBattleInvitation"),null,_loc8_,dataM.runAsMobile);
            this.btnAcceptBattleInvitation.initialize("","",externalAssetsM.getAsset("general","interface_acceptBattleInvitation"),null,_loc9_,dataM.runAsMobile);
            this.btnDeclineBattleInvitation.initialize("","",externalAssetsM.getAsset("general","interface_declineBattleInvitation"),null,_loc10_,dataM.runAsMobile);
            this.btnSendClanInvitation.initialize("","",externalAssetsM.getAsset("general","interface_sendClanInvitation"),null,_loc11_,dataM.runAsMobile);
            this.btnAcceptClanInvitation.initialize("","",externalAssetsM.getAsset("general","interface_acceptClanInvitation"),null,_loc12_,dataM.runAsMobile);
            this.btnDeclineClanInvitation.initialize("","",externalAssetsM.getAsset("general","interface_declineClanInvitation"),null,_loc13_,dataM.runAsMobile);
            this.btnBlock.initialize("","",externalAssetsM.getAsset("general","interface_chatBlock"),null,_loc14_,dataM.runAsMobile);
            this.btnUnBlock.initialize("","",externalAssetsM.getAsset("general","interface_chatUnBlock"),null,_loc15_,dataM.runAsMobile);
            this.btnChat.initialize("","",externalAssetsM.getAsset("general","interface_chat"),null,_loc16_,dataM.runAsMobile);
            this.btnInspect.initialize("","",externalAssetsM.getAsset("general","interface_inspect"),null,_loc17_,dataM.runAsMobile);
            this.btnClose.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc18_,dataM.runAsMobile);
            if(dataM.runAsMobile == false)
            {
               this.btnChat.buttonCore.addMouseOverListerner(this.chatMouseOver);
               this.btnChat.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnBlock.buttonCore.addMouseOverListerner(this.blockMouseOver);
               this.btnBlock.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnUnBlock.buttonCore.addMouseOverListerner(this.unBlockMouseOver);
               this.btnUnBlock.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnInspect.buttonCore.addMouseOverListerner(this.inspectMouseOver);
               this.btnInspect.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnSendBattleInvitation.buttonCore.addMouseOverListerner(this.sendBattleInvitationMouseOver);
               this.btnSendBattleInvitation.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnAcceptBattleInvitation.buttonCore.addMouseOverListerner(this.acceptBattleInvitationMouseOver);
               this.btnAcceptBattleInvitation.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnDeclineBattleInvitation.buttonCore.addMouseOverListerner(this.declineBattleInvitationMouseOver);
               this.btnDeclineBattleInvitation.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnSendClanInvitation.buttonCore.addMouseOverListerner(this.sendClanInvitationMouseOver);
               this.btnSendClanInvitation.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnAcceptClanInvitation.buttonCore.addMouseOverListerner(this.acceptClanInvitationMouseOver);
               this.btnAcceptClanInvitation.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnDeclineClanInvitation.buttonCore.addMouseOverListerner(this.declineClanInvitationMouseOver);
               this.btnDeclineClanInvitation.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
            }
            this.btnSendBattleInvitation.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnAcceptBattleInvitation.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnDeclineBattleInvitation.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSendClanInvitation.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnAcceptClanInvitation.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnDeclineClanInvitation.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBlock.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnUnBlock.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChat.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnInspect.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnClose.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         dataM.onlinePlayersInspect_playerID = param1;
         this._battleInvitation = param2;
         this._clanInvitation = param3;
         this._clanMessage = param4;
         var _loc5_:Object = dataM.chat_playersData[param1];
         this.txtName.htmlText = TextUtils.getTextFont(16) + _loc5_.playerName;
         if(this.mcRank != null)
         {
            if(this.mcRank.parent != null)
            {
               this.mcRank.parent.removeChild(this.mcRank);
            }
         }
         var _loc6_:Number = this.mcSizer_rank.width;
         var _loc7_:Number = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc5_.ladderProgress));
         this.mcRank = externalAssetsM.getAsset("general","Grp_rank" + _loc7_,_loc6_,_loc6_,false,false);
         this.mcRank.x = this.mcSizer_rank.x;
         this.mcRank.y = this.mcSizer_rank.y;
         addChild(this.mcRank);
         this.refreshButtons();
         this.txtPlayerID.visible = false;
         if(dataM.specialUser)
         {
            this.txtPlayerID.visible = true;
            this.txtPlayerID.text = "PlayerID : " + dataM.onlinePlayersInspect_playerID;
         }
         if(screensM.isScreenOpened("screenSelectBattleMechsPerPlayer"))
         {
            screensM.screenSelectBattleMechsPerPlayer.closeScreen();
         }
         this.createTextsAndRankBitmapForMobile();
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtName,16);
         }
      }
      
      public function refreshButtons() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Object = null;
         var _loc3_:Boolean = false;
         if(screensM.isScreenOpened("screenMenuMultiPlayerInspect"))
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc2_ = dataM.chat_playersData[dataM.onlinePlayersInspect_playerID];
            _loc3_ = false;
            if(_loc2_.clanID == 0)
            {
               if(_loc1_.clanID > 0)
               {
                  if(_loc1_.clan_leaderPlayerID == dataM.userID)
                  {
                     if(_loc1_.clan_members.length < dataM.clanMaxMembers)
                     {
                        _loc3_ = true;
                     }
                  }
               }
            }
            if(dataM.chat_isPlayerBlocked(dataM.onlinePlayersInspect_playerID))
            {
               this.btnBlock.visible = false;
               this.btnUnBlock.visible = true;
            }
            else
            {
               this.btnBlock.visible = true;
               this.btnUnBlock.visible = false;
            }
            if(this._clanInvitation)
            {
               this.btnSendBattleInvitation.visible = false;
               this.btnAcceptBattleInvitation.visible = false;
               this.btnDeclineBattleInvitation.visible = false;
               this.btnSendClanInvitation.visible = false;
               if(_loc1_.clanID == 0)
               {
                  this.btnAcceptClanInvitation.visible = true;
                  this.btnDeclineClanInvitation.visible = true;
                  this.btnAcceptClanInvitation.enableMe();
                  this.btnDeclineClanInvitation.enableMe();
               }
               else
               {
                  this.btnAcceptClanInvitation.visible = false;
                  this.btnDeclineClanInvitation.visible = false;
               }
            }
            else if(this._battleInvitation)
            {
               this.btnSendBattleInvitation.visible = false;
               this.btnAcceptClanInvitation.visible = false;
               this.btnDeclineClanInvitation.visible = false;
               this.btnAcceptBattleInvitation.visible = true;
               this.btnDeclineBattleInvitation.visible = true;
               this.btnAcceptBattleInvitation.enableMe();
               this.btnDeclineBattleInvitation.enableMe();
               if(_loc3_)
               {
                  this.btnSendClanInvitation.visible = true;
                  this.btnSendClanInvitation.enableMe();
               }
               else
               {
                  this.btnSendClanInvitation.visible = false;
               }
            }
            else
            {
               this.btnSendBattleInvitation.visible = true;
               this.btnAcceptBattleInvitation.visible = false;
               this.btnDeclineBattleInvitation.visible = false;
               this.btnAcceptClanInvitation.visible = false;
               this.btnDeclineClanInvitation.visible = false;
               if(_loc3_)
               {
                  this.btnSendClanInvitation.visible = true;
                  this.btnSendClanInvitation.enableMe();
               }
               else
               {
                  this.btnSendClanInvitation.visible = false;
               }
            }
            this.btnInspect.enableMe();
         }
      }
      
      public function sendBattleInvitationClicked() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Object = dataM.chat_playersData[dataM.onlinePlayersInspect_playerID];
         if(_loc1_.level >= dataM.SECOND_MECH_UNLOCK_LEVEL && _loc2_.level >= dataM.SECOND_MECH_UNLOCK_LEVEL)
         {
            _loc3_ = false;
            if(screensM.isScreenOpened("screenSelectBattleMechsPerPlayer"))
            {
               if(screensM.screenSelectBattleMechsPerPlayer.getBattleType() == "battleInvitation")
               {
                  _loc3_ = true;
               }
            }
            if(_loc3_)
            {
               screensM.screenSelectBattleMechsPerPlayer.closeScreen();
            }
            else
            {
               screensM.addScreen("screenSelectBattleMechsPerPlayer");
               _loc4_ = 2;
               if(_loc1_.level >= dataM.levelRequired3V3 && _loc2_.level >= dataM.levelRequired3V3)
               {
                  _loc4_ = 3;
               }
               screensM.screenSelectBattleMechsPerPlayer.refreshScreen(_loc4_,"battleInvitation");
               screensM.screenSelectBattleMechsPerPlayer.x = this.btnSendBattleInvitation.x + this.btnSendBattleInvitation.width + 3;
               screensM.screenSelectBattleMechsPerPlayer.y = this.btnSendBattleInvitation.y - 3;
            }
         }
         else
         {
            this.battleMechsPerPlayerSelected(1);
         }
      }
      
      public function battleMechsPerPlayerSelected(param1:uint) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         if(dataM.isMechReadyForBattle(false,param1))
         {
            _loc2_ = new Array();
            _loc3_ = 1;
            while(_loc3_ <= param1)
            {
               _loc2_.push(_loc3_);
               _loc3_++;
            }
            if(dataM.mechIsOverWeight(_loc2_))
            {
               screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",-1,-1);
            }
            else
            {
               dataM.battleMechsPerPlayer = param1;
               screensM.screenMultiPlayerChat.acceptingBattleInvitation = true;
               remoteM.lobby_battleInvitation_create(dataM.onlinePlayersInspect_playerID,param1);
               screensM.screenConfirmation.displayQuestionOrNotification("sendingInvitation",-1,-1);
            }
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",-1,-1);
         }
         this.closeClicked();
      }
      
      public function acceptBattleInvitationClicked() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         if(dataM.isMechReadyForBattle(false))
         {
            _loc1_ = new Array();
            _loc2_ = dataM.battleInvitations[dataM.onlinePlayersInspect_playerID];
            _loc3_ = 1;
            while(_loc3_ <= _loc2_.mechsPerPlayer)
            {
               _loc1_.push(_loc3_);
               _loc3_++;
            }
            if(dataM.mechIsOverWeight(_loc1_))
            {
               screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",-1,-1);
            }
            else
            {
               dataM.battleMechsPerPlayer = _loc2_.mechsPerPlayer;
               screensM.screenMultiPlayerChat.acceptingBattleInvitation = true;
               remoteM.lobby_battleInvitation_accepted(dataM.onlinePlayersInspect_playerID,_loc2_.mechsPerPlayer);
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
            }
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",-1,-1);
         }
         this.closeClicked();
      }
      
      public function declineBattleInvitationClicked() : void
      {
         dataM.battleInvitation_remove(dataM.onlinePlayersInspect_playerID);
         remoteM.lobby_battleInvitation_declined(dataM.onlinePlayersInspect_playerID);
         this.refreshScreen(dataM.onlinePlayersInspect_playerID,false,false,false);
      }
      
      public function blockClicked() : void
      {
         dataM.chat_blockPlayer(dataM.onlinePlayersInspect_playerID,true);
         if(dataM.useChatBlocks)
         {
            if(dataM.chatBlocksRemain > 0)
            {
               if(dataM.chatBlocksPlayerIDs[dataM.onlinePlayersInspect_playerID] == null)
               {
                  --dataM.chatBlocksRemain;
                  remoteM.socketM.lobby_chatBlock(dataM.onlinePlayersInspect_playerID);
                  dataM.chatBlocksPlayerIDs[dataM.onlinePlayersInspect_playerID] = true;
               }
            }
         }
         this.closeClicked();
      }
      
      public function unBlockClicked() : void
      {
         dataM.chat_unBlockPlayer(dataM.onlinePlayersInspect_playerID,true);
         this.closeClicked();
      }
      
      public function chatClicked() : void
      {
         screensM.screenMultiPlayerChat.chatPlayerClicked(dataM.onlinePlayersInspect_playerID,this._clanMessage);
         this.closeClicked();
      }
      
      public function inspectClicked() : void
      {
         var _loc1_:Object = dataM.chat_playersData[dataM.onlinePlayersInspect_playerID];
         screensM.addScreen("screenInspectPlayer");
         screensM.screenInspectPlayer.refreshScreen(dataM.onlinePlayersInspect_playerID,true,_loc1_.playerName,_loc1_.level,_loc1_.ladderProgress,_loc1_.clanID);
      }
      
      public function closeClicked() : void
      {
         if(screensM.isScreenOpened("screenSelectBattleMechsPerPlayer"))
         {
            if(screensM.screenSelectBattleMechsPerPlayer.getBattleType() == "battleInvitation")
            {
               screensM.screenSelectBattleMechsPerPlayer.closeScreen();
            }
         }
         screensM.removeScreen("screenMenuMultiPlayerInspect");
      }
      
      public function sendClanInvitationClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         remoteM.socketM.clan_sendInvitation(dataM.onlinePlayersInspect_playerID);
         this.closeClicked();
      }
      
      public function acceptClanInvitationClicked() : void
      {
         var _loc1_:Object = dataM.chat_playersData[dataM.onlinePlayersInspect_playerID];
         dataM.clan_removeInvitation(_loc1_.clanID);
         remoteM.socketM.clan_acceptInvitation(_loc1_.clanID);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         this.closeClicked();
      }
      
      public function declineClanInvitationClicked() : void
      {
         var _loc1_:Object = dataM.chat_playersData[dataM.onlinePlayersInspect_playerID];
         dataM.clan_removeInvitation(_loc1_.clanID);
         remoteM.socketM.clan_declineInvitation(_loc1_.clanID);
         this.refreshScreen(dataM.onlinePlayersInspect_playerID,false,false,false);
      }
      
      override public function notifyClientDataReloaded() : *
      {
      }
      
      public function chatMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("sendAPrivateMessage"),-1,-1);
      }
      
      public function blockMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("blockPlayer"),-1,-1);
      }
      
      public function unBlockMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("unBlockPlayer"),-1,-1);
      }
      
      public function inspectMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("inspect"),-1,-1);
      }
      
      public function sendBattleInvitationMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("friends_sendBattleInvitation"),-1,-1);
      }
      
      public function acceptBattleInvitationMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("friends_acceptBattleInvitation"),-1,-1);
      }
      
      public function declineBattleInvitationMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("declineBattleInvitation"),-1,-1);
      }
      
      public function sendClanInvitationMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("sendClanInvitation"),-1,-1);
      }
      
      public function acceptClanInvitationMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("acceptClanInvitation"),-1,-1);
      }
      
      public function declineClanInvitationMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("declineClanInvitation"),-1,-1);
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
   }
}

