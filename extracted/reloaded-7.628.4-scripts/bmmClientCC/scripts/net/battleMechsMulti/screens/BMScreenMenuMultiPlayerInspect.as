package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2396")]
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
      
      private var _allowDirectInteractions:Boolean;
      
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
      
      public function refreshScreen(param1:Number, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean = true) : void
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
         var _loc18_:Function = null;
         var _loc19_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnSendBattleInvitation","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnAcceptBattleInvitation","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnDeclineBattleInvitation","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnSendClanInvitation","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnAcceptClanInvitation","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnDeclineClanInvitation","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnBlock","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnUnBlock","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnChat","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnInspect","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT,"btnClose","pictureE");
            _loc9_ = this.sendBattleInvitationClicked;
            _loc10_ = this.acceptBattleInvitationClicked;
            _loc11_ = this.declineBattleInvitationClicked;
            _loc12_ = this.sendClanInvitationClicked;
            _loc13_ = this.acceptClanInvitationClicked;
            _loc14_ = this.declineClanInvitationClicked;
            _loc15_ = this.blockClicked;
            _loc16_ = this.unBlockClicked;
            _loc17_ = this.chatClicked;
            _loc18_ = this.inspectClicked;
            _loc19_ = this.closeClicked;
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
               _loc18_ = null;
               _loc19_ = null;
            }
            this.btnSendBattleInvitation.initialize("","",externalAssetsM.getAsset("general","interface_createBattleInvitation"),null,_loc9_,dataM.runAsMobile);
            this.btnAcceptBattleInvitation.initialize("","",externalAssetsM.getAsset("general","interface_acceptBattleInvitation"),null,_loc10_,dataM.runAsMobile);
            this.btnDeclineBattleInvitation.initialize("","",externalAssetsM.getAsset("general","interface_declineBattleInvitation"),null,_loc11_,dataM.runAsMobile);
            this.btnSendClanInvitation.initialize("","",externalAssetsM.getAsset("general","interface_sendClanInvitation"),null,_loc12_,dataM.runAsMobile);
            this.btnAcceptClanInvitation.initialize("","",externalAssetsM.getAsset("general","interface_acceptClanInvitation"),null,_loc13_,dataM.runAsMobile);
            this.btnDeclineClanInvitation.initialize("","",externalAssetsM.getAsset("general","interface_declineClanInvitation"),null,_loc14_,dataM.runAsMobile);
            this.btnBlock.initialize("","",externalAssetsM.getAsset("general","interface_chatBlock"),null,_loc15_,dataM.runAsMobile);
            this.btnUnBlock.initialize("","",externalAssetsM.getAsset("general","interface_chatUnBlock"),null,_loc16_,dataM.runAsMobile);
            this.btnChat.initialize("","",externalAssetsM.getAsset("general","interface_chat"),null,_loc17_,dataM.runAsMobile);
            this.btnInspect.initialize("","",externalAssetsM.getAsset("general","interface_inspect"),null,_loc18_,dataM.runAsMobile);
            this.btnClose.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc19_,dataM.runAsMobile);
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
         this._allowDirectInteractions = param5;
         var _loc6_:Object = dataM.chatData.playersData[param1];
         this.txtName.htmlText = TextUtils.getTextFont(16) + _loc6_.playerName;
         if(this.mcRank != null)
         {
            if(this.mcRank.parent != null)
            {
               this.mcRank.parent.removeChild(this.mcRank);
            }
         }
         var _loc7_:Number = this.mcSizer_rank.width;
         var _loc8_:Number = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc6_.ladderProgress));
         this.mcRank = externalAssetsM.getAsset("general","Grp_rank" + _loc8_,_loc7_,_loc7_,false,false);
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_SELECT_BATTLE_MECHS_PER_PLAYER))
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT))
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc2_ = dataM.chatData.playersData[dataM.onlinePlayersInspect_playerID];
            _loc3_ = false;
            if(_loc2_.clanID == 0)
            {
               if(_loc1_.clanID > 0)
               {
                  if(_loc1_.clanLeaderID == dataM.userID)
                  {
                     if(_loc1_.clanMembers < dataM.clanMaxMembers)
                     {
                        _loc3_ = true;
                     }
                  }
               }
            }
            if(dataM.chatData.isPlayerBlocked(dataM.onlinePlayersInspect_playerID))
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
            if(this._allowDirectInteractions == false)
            {
               this.btnAcceptBattleInvitation.visible = false;
               this.btnChat.visible = false;
               this.btnDeclineBattleInvitation.visible = false;
               this.btnBlock.visible = false;
               this.btnSendBattleInvitation.visible = false;
               this.btnUnBlock.visible = false;
            }
            this.btnInspect.enableMe();
         }
      }
      
      public function sendBattleInvitationClicked() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Object = dataM.chatData.playersData[dataM.onlinePlayersInspect_playerID];
         if(_loc1_.level >= dataM.SECOND_MECH_UNLOCK_LEVEL && _loc2_.level >= dataM.SECOND_MECH_UNLOCK_LEVEL)
         {
            _loc3_ = false;
            if(screensM.isScreenOpened(BMScreensManager.SCR_SELECT_BATTLE_MECHS_PER_PLAYER))
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
               screensM.addScreen(BMScreensManager.SCR_SELECT_BATTLE_MECHS_PER_PLAYER);
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
         var _loc4_:uint = 0;
         if(dataM.areMechsReadyForBattle(param1))
         {
            _loc2_ = new Array();
            _loc3_ = 1;
            while(_loc3_ <= param1)
            {
               _loc2_.push(_loc3_);
               _loc3_++;
            }
            _loc4_ = dataM.mechIsOverWeight(_loc2_);
            if(_loc4_ > 0)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",_loc4_,-1);
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
         var _loc4_:uint = 0;
         if(dataM.areMechsReadyForBattle())
         {
            _loc1_ = new Array();
            _loc2_ = dataM.chatData.battleInvitations[dataM.onlinePlayersInspect_playerID];
            _loc3_ = 1;
            while(_loc3_ <= _loc2_.mechsPerPlayer)
            {
               _loc1_.push(_loc3_);
               _loc3_++;
            }
            _loc4_ = dataM.mechIsOverWeight(_loc1_);
            if(_loc4_ > 0)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("weightBlock",_loc4_,-1);
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
         dataM.chatData.battleInvitation_remove(dataM.onlinePlayersInspect_playerID);
         remoteM.lobby_battleInvitation_declined(dataM.onlinePlayersInspect_playerID);
         this.refreshScreen(dataM.onlinePlayersInspect_playerID,false,false,false);
      }
      
      public function blockClicked() : void
      {
         dataM.chatData.blockPlayer(dataM.onlinePlayersInspect_playerID,true);
         if(dataM.chatData.useChatBlocks)
         {
            if(dataM.chatData.chatBlocksRemain > 0)
            {
               if(dataM.chatData.chatBlocksPlayerIDs[dataM.onlinePlayersInspect_playerID] == null)
               {
                  --dataM.chatData.chatBlocksRemain;
                  remoteM.socketM.lobby_chatBlock(dataM.onlinePlayersInspect_playerID);
                  dataM.chatData.chatBlocksPlayerIDs[dataM.onlinePlayersInspect_playerID] = true;
               }
            }
         }
         this.closeClicked();
      }
      
      public function unBlockClicked() : void
      {
         dataM.chatData.unBlockPlayer(dataM.onlinePlayersInspect_playerID,true);
         this.closeClicked();
      }
      
      public function chatClicked() : void
      {
         screensM.screenMultiPlayerChat.chatPlayerClicked(dataM.onlinePlayersInspect_playerID,this._clanMessage);
         this.closeClicked();
      }
      
      public function inspectClicked() : void
      {
         var _loc1_:Object = dataM.chatData.playersData[dataM.onlinePlayersInspect_playerID];
         screensM.addScreen(BMScreensManager.SCR_INSPECT_PLAYER);
         var _loc2_:Boolean = this._allowDirectInteractions;
         screensM.screenInspectPlayer.refreshScreen(dataM.onlinePlayersInspect_playerID,true,_loc1_.playerName,_loc1_.level,_loc1_.ladderProgress,_loc1_.clanID,"",_loc2_);
      }
      
      public function closeClicked() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_SELECT_BATTLE_MECHS_PER_PLAYER))
         {
            if(screensM.screenSelectBattleMechsPerPlayer.getBattleType() == "battleInvitation")
            {
               screensM.screenSelectBattleMechsPerPlayer.closeScreen();
            }
         }
         screensM.removeScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
      }
      
      public function sendClanInvitationClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         remoteM.socketM.clan_sendInvitation(dataM.onlinePlayersInspect_playerID);
         this.closeClicked();
      }
      
      public function acceptClanInvitationClicked() : void
      {
         var _loc1_:Object = dataM.chatData.playersData[dataM.onlinePlayersInspect_playerID];
         dataM.chatData.clan_removeInvitation(_loc1_.clanID);
         remoteM.socketM.clan_acceptInvitation(_loc1_.clanID);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         this.closeClicked();
      }
      
      public function declineClanInvitationClicked() : void
      {
         var _loc1_:Object = dataM.chatData.playersData[dataM.onlinePlayersInspect_playerID];
         dataM.chatData.clan_removeInvitation(_loc1_.clanID);
         remoteM.socketM.clan_declineInvitation(_loc1_.clanID);
         this.refreshScreen(dataM.onlinePlayersInspect_playerID,false,false,false);
      }
      
      override public function notifyClientDataReloaded() : *
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT))
         {
            screensM.removeScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
         }
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

