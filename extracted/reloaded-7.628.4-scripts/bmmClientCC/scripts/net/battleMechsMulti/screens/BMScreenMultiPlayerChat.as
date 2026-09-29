package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.chat.BMChatInterface;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2391")]
   public class BMScreenMultiPlayerChat extends BMBaseScreen
   {
      
      public var chatInterface:BMChatInterface;
      
      public var channelsList:BMChatChannelsList;
      
      public var txtCurrentChannel:TextField;
      
      public var txtPlayersInLobby:TextField;
      
      public var txtBattleInvitationsStatus:TextField;
      
      public var mcSizer_btnBackToLadder:Sprite;
      
      public var mcSizer_btnBattleInvitationsEnabled:Sprite;
      
      public var mcSizer_btnBattleInvitationsDisabled:Sprite;
      
      public var mcSizer_btnSearchForBattle:Sprite;
      
      public var mcSizer_btnSearchForPlayer:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnChannelsList:Sprite;
      
      public var mcSizer_onlinePlayersTileList:Sprite;
      
      public var mcQuickMatchIcon:Sprite;
      
      public var mcFingerWheeling_onlinePlayers:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var btnBackToLadder:BMButton_pictureE;
      
      public var btnChannelsList:BMButton_pictureE;
      
      public var btnBattleInvitationsEnabled:BMButton_pictureE;
      
      public var btnBattleInvitationsDisabled:BMButton_pictureE;
      
      public var btnSearchForPlayer:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureE;
      
      public var mcSandClock:MovieClip;
      
      private var onlinePlayersTileList:BMTileList;
      
      private var _firstRefresh:Boolean = true;
      
      private var _fingerWheeling_onlinePlayers:BMFingerWheeling;
      
      private var _refreshOnlinePlayersFrameCounter:Number = 0;
      
      private var _addOnlinePlayersTileListFrameCounter:uint = 40;
      
      private var _refreshOnlineTileListForNewMessangerFrameCounter:uint = 0;
      
      private var _onlinePlayersTab:String = "all";
      
      private var _lastTotalPlayersInLobby:uint = 0;
      
      public var channelsVisibleOnLastFrame:Boolean = false;
      
      public var acceptingBattleInvitation:Boolean = false;
      
      private var ONLINE_PLAYERS_LIST_ROWS:Number = 13;
      
      private var ONLINE_PLAYERS_LIST_WIDTH:Number = 185;
      
      private var ONLINE_PLAYERS_LIST_ROW_HEIGHT:Number = 29;
      
      private var MAX_PLAYERS_TO_DISPLAY:uint = 30;
      
      private const REFRESH_ONLINE_PLAYERS_FRAMES:Number = 5000;
      
      private const ONLINE_PLAYER_LADDER_PROGRESS_DIFFERENCE:uint = 10;
      
      private const SECOND_TO_DELAY_ONLINE_TILE_LIST:uint = 35;
      
      public function BMScreenMultiPlayerChat()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("multiplayerChat");
      }
      
      public function refreshScreen(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("multiplayerChat");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MULTIPLAYER_CHAT,"btnBackToLadder","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MULTIPLAYER_CHAT,"btnChannelsList","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MULTIPLAYER_CHAT,"btnBattleInvitationsEnabled","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MULTIPLAYER_CHAT,"btnBattleInvitationsDisabled","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MULTIPLAYER_CHAT,"btnSearchForPlayer","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_MULTIPLAYER_CHAT,"btnBack","pictureE");
            _loc3_ = this.backToLadderClicked;
            _loc4_ = this.channelsListClicked;
            _loc5_ = this.battleInvitationsEnabledClicked;
            _loc6_ = this.battleInvitationsDisabledClicked;
            _loc7_ = this.searchForPlayerClicked;
            if(dataM.runAsMobile)
            {
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
            }
            this.btnBackToLadder.initialize("","",externalAssetsM.getAsset("general","interface_ladderBattles"),null,_loc3_,dataM.runAsMobile);
            this.btnChannelsList.initialize("","",externalAssetsM.getAsset("general","interface_openDropList"),null,_loc4_,dataM.runAsMobile);
            this.btnBattleInvitationsEnabled.initialize("","",externalAssetsM.getAsset("general","interface_battleInvitationsEnabled"),null,_loc5_,dataM.runAsMobile);
            this.btnBattleInvitationsDisabled.initialize("","",externalAssetsM.getAsset("general","interface_battleInvitationsDisabled"),null,_loc6_,dataM.runAsMobile);
            this.btnSearchForPlayer.initialize("","",externalAssetsM.getAsset("general","interface_inspect"),null,_loc7_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            if(dataM.runAsMobile == false)
            {
               this.btnBackToLadder.buttonCore.addMouseOverListerner(this.backToLadderMouseOver);
               this.btnBackToLadder.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnChannelsList.buttonCore.addMouseOverListerner(this.channelsListMouseOver);
               this.btnChannelsList.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnSearchForPlayer.buttonCore.addMouseOverListerner(this.searchForPlayerMouseOver);
               this.btnSearchForPlayer.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
            }
            this.btnBackToLadder.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChannelsList.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBattleInvitationsEnabled.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBattleInvitationsDisabled.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSearchForPlayer.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            if(dataM.runAsMobile)
            {
               this.ONLINE_PLAYERS_LIST_ROWS = 9;
               this.ONLINE_PLAYERS_LIST_WIDTH = 205;
               this.ONLINE_PLAYERS_LIST_ROW_HEIGHT = 40;
            }
            this.channelsList.initialize(this.channelClicked);
            if(dataM.runAsMobile)
            {
               this._fingerWheeling_onlinePlayers = new BMFingerWheeling();
               this._fingerWheeling_onlinePlayers.initialize("onliePlayers",this.onlinePlayersTileList,this.mcFingerWheeling_onlinePlayers,this.onlinePlayersListItemClicked,null,false);
               addChild(this._fingerWheeling_onlinePlayers);
            }
            else
            {
               this.mcFingerWheeling_onlinePlayers.parent.removeChild(this.mcFingerWheeling_onlinePlayers);
               this.mcFingerWheeling_onlinePlayers = null;
            }
            this.languageUpdate();
            this._firstRefresh = false;
         }
         dataM.battleLaunchScreen = BMScreensManager.SCR_MULTIPLAYER_CHAT;
         this.setCurrentChannelAndOnlinePlayersTab();
         this.addAndRefreshOnlinePlayersTileList();
         this.chatInterface.initialize(this.tryToInspectPlayer,this.sendChatMessage);
         this.chatInterface.refreshChatHistory();
         this.channelsList.close();
         this.refreshCurrentChannelText();
         this.acceptingBattleInvitation = false;
         this.enableAllButtons();
         this.chatInterface.enableAllButtons();
         this.refreshPlayersInLobbyText();
         this.refreshBattleInvitationsEnableDisableButtons();
         if(param1)
         {
            dataM.chatData.enterChat();
         }
         if(dataM.chatData.goToInspectPlayerID > 0)
         {
            this.tryToInspectPlayer(dataM.chatData.goToInspectPlayerID);
            dataM.chatData.goToInspectPlayerID = 0;
         }
         dataM.chatData.differentUserConnected = false;
      }
      
      private function setCurrentChannelAndOnlinePlayersTab() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._onlinePlayersTab = "all";
         var _loc2_:Boolean = false;
         if(dataM.chatData.differentUserConnected)
         {
            dataM.chatData.currentChannelPlayerID = dataM.chatData.chatDefaultLanguageID;
            if(dataM.getLadderRankByProgress(_loc1_.ladderProgress) <= 5)
            {
               dataM.chatData.currentChannelPlayerID += 3;
            }
            if(dataM.chatData.goToClanChat)
            {
               dataM.chatData.currentChannelPlayerID = dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID;
               this._onlinePlayersTab = "clan";
               dataM.chatData.goToClanChat = false;
            }
            else if(dataM.chatData.goToSpecificPlayerChatPlayerID > 0)
            {
               dataM.chatData.currentChannelPlayerID = dataM.chatData.goToSpecificPlayerChatPlayerID;
               dataM.chatData.goToSpecificPlayerChatPlayerID = 0;
            }
         }
         else
         {
            if(lastLanguageID != dataM.languageID)
            {
               this.languageUpdate(true);
            }
            if(dataM.chatData.goToClanChat)
            {
               dataM.chatData.currentChannelPlayerID = dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID;
               this._onlinePlayersTab = "clan";
               dataM.chatData.goToClanChat = false;
            }
            else if(dataM.chatData.goToSpecificPlayerChatPlayerID > 0)
            {
               dataM.chatData.currentChannelPlayerID = dataM.chatData.goToSpecificPlayerChatPlayerID;
               dataM.chatData.goToSpecificPlayerChatPlayerID = 0;
            }
            else
            {
               dataM.chatData.currentChannelPlayerID = dataM.chatData.lastChatChannel;
            }
         }
         dataM.chatData.lastChatChannel = dataM.chatData.currentChannelPlayerID;
      }
      
      public function refreshPlayersInLobbyText() : void
      {
         var _loc1_:String = getSpecificText("multiplayerLadder_playersInLobby");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%PLAYERS%",String(dataM.chatData.totalPlayersInLobby));
         updateTextAndFormat(this.txtPlayersInLobby,_loc1_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("menuMultiPlayerChat_txtPlayersInLobby",[this.txtPlayersInLobby],"",this);
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = 15;
            switch(dataM.languageID)
            {
               case 3:
               case 6:
               case 7:
               case 8:
               case 9:
                  _loc2_ = 17;
            }
            TextUtils.updateTextFormat(this.txtCurrentChannel,18);
            TextUtils.updateTextFormat(this.txtPlayersInLobby,18);
         }
         if(param1)
         {
            dataM.chatData.channelsLanguageUpdate();
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_onlinePlayers.cancelFingerWheeling();
         }
         this.channelsList.cancelFingerWheeling();
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:uint = 0;
         var _loc4_:BMClanMemberData = null;
         var _loc5_:Number = NaN;
         if(screensM.screenBlack.isActive())
         {
            return;
         }
         if(dataM.chatData.goToChatAfterBattleUserID > 0)
         {
            _loc1_ = false;
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc2_.clanID > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.clanMembers)
               {
                  _loc4_ = _loc2_.clanData.members[_loc3_];
                  if(_loc4_.playerID == dataM.chatData.goToChatAfterBattleUserID)
                  {
                     _loc1_ = true;
                     _loc3_ = uint(_loc2_.clanMembers);
                  }
                  _loc3_++;
               }
            }
            if(dataM.chatData.playersData[dataM.chatData.goToChatAfterBattleUserID] == null)
            {
               dataM.chatData.addPlayerToChatPlayersData(dataM.chatData.goToChatAfterBattleUserID,dataM.chatData.addPlayerDataAfterBattleName,dataM.chatData.addPlayerDataAfterBattleLevel,dataM.chatData.addPlayerDataAfterBattleClanID,dataM.chatData.addPlayerDataAfterBattleLadderProgress,dataM.chatData.addPlayerDataAfterBattleGeo,"");
            }
            this.chatPlayerClicked(dataM.chatData.goToChatAfterBattleUserID,_loc1_,true);
            dataM.chatData.goToChatAfterBattleUserID = 0;
            return;
         }
         if(dataM.chatData.inviteToClanAfterBattleUserID > 0)
         {
            if(dataM.chatData.playersData[dataM.chatData.inviteToClanAfterBattleUserID] == null)
            {
               dataM.chatData.addPlayerToChatPlayersData(dataM.chatData.inviteToClanAfterBattleUserID,dataM.chatData.addPlayerDataAfterBattleName,dataM.chatData.addPlayerDataAfterBattleLevel,dataM.chatData.addPlayerDataAfterBattleClanID,dataM.chatData.addPlayerDataAfterBattleLadderProgress,dataM.chatData.addPlayerDataAfterBattleGeo,"");
            }
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
            remoteM.socketM.clan_sendInvitation(dataM.chatData.inviteToClanAfterBattleUserID);
            dataM.chatData.inviteToClanAfterBattleUserID = 0;
            return;
         }
         this.chatInterface.onEnterFrameTrigger();
         if(this._addOnlinePlayersTileListFrameCounter < this.SECOND_TO_DELAY_ONLINE_TILE_LIST)
         {
            ++this._addOnlinePlayersTileListFrameCounter;
         }
         else if(this._addOnlinePlayersTileListFrameCounter == this.SECOND_TO_DELAY_ONLINE_TILE_LIST)
         {
            ++this._addOnlinePlayersTileListFrameCounter;
            this.addAndRefreshOnlinePlayersTileList();
            this.mcSandClock.gotoAndStop("animOff");
         }
         else
         {
            ++this._refreshOnlinePlayersFrameCounter;
            ++this._refreshOnlineTileListForNewMessangerFrameCounter;
            _loc5_ = this.REFRESH_ONLINE_PLAYERS_FRAMES;
            if(this._refreshOnlinePlayersFrameCounter >= _loc5_)
            {
               dataM.chatData.enterChat();
               this._refreshOnlinePlayersFrameCounter = 0;
            }
            if(dataM.runAsMobile)
            {
               this._fingerWheeling_onlinePlayers.onEnterFrameTrigger();
            }
         }
         this.channelsList.onEnterFrameTrigger();
         if(dataM.runAsMobile)
         {
            this.channelsVisibleOnLastFrame = this.channelsList.visible;
         }
      }
      
      private function sendChatMessage(param1:String) : void
      {
         if(param1 == "" || dataM.chatData.sendMessageCooldown > 0)
         {
            return;
         }
         if(TextUtils.doesStringOnlyContainsSpaces(param1))
         {
            return;
         }
         var _loc2_:Boolean = false;
         if(dataM.chatData.amIBannedFromChat)
         {
            if(dataM.chatData.currentChannelPlayerID < dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID)
            {
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("youWereChatBlocked",-1,-1);
         }
         else
         {
            remoteM.socketM.lobby_chatToAll(param1,dataM.chatData.currentChannelPlayerID);
            this.chatInterface.chatMessageSent();
         }
      }
      
      public function memberKickedFromClan(param1:Number) : void
      {
         if(dataM.chatData.playersData[param1] != null)
         {
            dataM.chatData.playersData[param1].clanID = 0;
         }
      }
      
      public function updatePlayersOnline(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Object = new Object();
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         for each(_loc4_ in param1)
         {
            _loc8_ = false;
            if(_loc2_.clanID > 0)
            {
               if(_loc2_.clanID == _loc4_.clanID)
               {
                  _loc8_ = true;
               }
            }
            _loc9_ = false;
            if(_loc8_ == false)
            {
               if(_loc5_ <= 13)
               {
                  if(Math.abs(_loc2_.ladderProgress - _loc4_.ladderProgress) <= this.ONLINE_PLAYER_LADDER_PROGRESS_DIFFERENCE)
                  {
                     _loc9_ = true;
                  }
               }
            }
            if(_loc8_ || _loc9_)
            {
               _loc10_ = Number(_loc4_.playerID);
               if(_loc10_ != dataM.userID)
               {
                  _loc4_.playerName = dataM.getCensoredString(_loc4_.playerName);
               }
               dataM.chatData.addPlayerToChatPlayersData(_loc10_,_loc4_.playerName,_loc4_.level,_loc4_.clanID,_loc4_.ladderProgress,_loc4_.geo,_loc4_.lastDevice);
               _loc3_[_loc10_] = true;
               _loc5_++;
            }
            _loc6_++;
         }
         for each(_loc4_ in dataM.chatData.playersData)
         {
            if(_loc3_[_loc4_.playerID] == null)
            {
               dataM.chatData.playersData[_loc4_.playerID].removed = true;
            }
         }
         _loc7_ = getSpecificText("multiplayerLadder_playersInLobby");
         _loc7_ = dataM.replaceStringInText(_loc7_,"%PLAYERS%",String(_loc6_));
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER))
         {
            this._lastTotalPlayersInLobby = _loc6_;
         }
         else
         {
            this.addAndRefreshOnlinePlayersTileList();
            updateTextAndFormat(this.txtPlayersInLobby,_loc7_);
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("menuMultiPlayerChat_txtPlayersInLobby",[this.txtPlayersInLobby],"",this);
            }
         }
      }
      
      private function removeOnlinePlayersTileList() : void
      {
         if(this.onlinePlayersTileList != null)
         {
            this.onlinePlayersTileList.removeMe();
            this.onlinePlayersTileList = null;
         }
      }
      
      public function addAndRefreshOnlinePlayersTileList(param1:Boolean = false) : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:Object = null;
         var _loc13_:Array = null;
         var _loc14_:Array = null;
         var _loc15_:Number = NaN;
         var _loc16_:uint = 0;
         var _loc17_:Number = NaN;
         var _loc18_:uint = 0;
         var _loc19_:Number = NaN;
         var _loc20_:BMClanMemberData = null;
         var _loc21_:Boolean = false;
         var _loc22_:String = null;
         var _loc23_:MovieClip = null;
         var _loc24_:String = null;
         var _loc25_:Boolean = false;
         var _loc26_:BMAvatarImage = null;
         var _loc27_:Number = NaN;
         var _loc28_:MovieClip = null;
         var _loc29_:BMItem = null;
         var _loc30_:BMTileListItem = null;
         var _loc31_:Function = null;
         var _loc32_:Boolean = false;
         var _loc33_:MovieClip = null;
         var _loc34_:Number = NaN;
         if(param1 || this._addOnlinePlayersTileListFrameCounter >= this.SECOND_TO_DELAY_ONLINE_TILE_LIST)
         {
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc3_ = new Array();
            _loc4_ = 0;
            _loc6_ = new Object();
            if(_loc2_.clanID > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc2_.clanMembers)
               {
                  _loc20_ = _loc2_.clanData.members[_loc5_];
                  _loc6_[_loc20_.playerID] = true;
                  _loc5_++;
               }
            }
            _loc7_ = new Array();
            _loc8_ = new Array();
            _loc9_ = new Array();
            _loc10_ = new Array();
            _loc11_ = new Array();
            _loc13_ = new Array();
            for each(_loc12_ in dataM.chatData.playersData)
            {
               if(_loc12_.playerID > dataM.chatData.CHAT_LANGUAGES - 1 && _loc12_.removed == false)
               {
                  _loc21_ = false;
                  if(_loc2_.clanID > 0)
                  {
                     if(_loc6_[_loc12_.playerID] != null)
                     {
                        _loc21_ = true;
                     }
                  }
                  if(_loc21_ || Math.abs(_loc2_.ladderProgress - _loc12_.ladderProgress) <= this.ONLINE_PLAYER_LADDER_PROGRESS_DIFFERENCE)
                  {
                     _loc22_ = "regular";
                     if(dataM.isPlayerIDAdmin(_loc12_.playerID))
                     {
                        _loc22_ = "admin";
                     }
                     else if(_loc21_)
                     {
                        _loc22_ = "clanMember";
                     }
                     _loc13_.push({
                        "ladderProgress":_loc12_.ladderProgress,
                        "playerID":_loc12_.playerID,
                        "type":_loc22_
                     });
                  }
               }
            }
            _loc13_.sortOn("ladderProgress",Array.NUMERIC);
            _loc14_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < _loc13_.length)
            {
               _loc12_ = _loc13_[_loc5_];
               switch(this._onlinePlayersTab)
               {
                  case "all":
                     switch(_loc12_.type)
                     {
                        case "regular":
                           if(_loc12_.ladderProgress < _loc2_.ladderProgress)
                           {
                              _loc10_.push(_loc12_.playerID);
                           }
                           else
                           {
                              _loc11_.push(_loc12_.playerID);
                           }
                           break;
                        case "admin":
                           _loc7_.push(_loc12_.playerID);
                     }
                     break;
                  case "clan":
               }
               switch(_loc12_.type)
               {
                  case "clanMember":
                  case "friend":
                     if(_loc12_.ladderProgress < _loc2_.ladderProgress)
                     {
                        _loc8_.push(_loc12_.playerID);
                     }
                     else
                     {
                        _loc9_.push(_loc12_.playerID);
                     }
               }
               _loc5_++;
            }
            _loc15_ = 0;
            _loc16_ = 0;
            _loc17_ = _loc8_.length - 1;
            while(_loc15_ < this.MAX_PLAYERS_TO_DISPLAY && (_loc16_ < _loc9_.length || _loc17_ >= 0))
            {
               if(_loc16_ < _loc9_.length)
               {
                  _loc14_.push(_loc9_[_loc16_]);
                  _loc16_++;
                  _loc15_++;
               }
               if(_loc17_ >= 0)
               {
                  _loc14_.splice(0,0,_loc8_[_loc17_]);
                  _loc17_--;
                  _loc15_++;
               }
            }
            _loc18_ = 0;
            _loc19_ = _loc10_.length - 1;
            while(_loc15_ < this.MAX_PLAYERS_TO_DISPLAY && (_loc18_ < _loc11_.length || _loc19_ >= 0))
            {
               if(_loc18_ < _loc11_.length)
               {
                  _loc14_.push(_loc11_[_loc18_]);
                  _loc18_++;
                  _loc15_++;
               }
               if(_loc19_ >= 0)
               {
                  _loc14_.splice(0,0,_loc10_[_loc19_]);
                  _loc19_--;
                  _loc15_++;
               }
            }
            _loc5_ = 0;
            while(_loc5_ < _loc7_.length)
            {
               _loc14_.push(_loc7_[_loc5_]);
               _loc5_++;
            }
            _loc14_.reverse();
            _loc5_ = 0;
            while(_loc5_ < _loc14_.length)
            {
               _loc12_ = dataM.chatData.playersData[_loc14_[_loc5_]];
               if(_loc12_.playerID > dataM.chatData.CHAT_LANGUAGES - 1 && _loc12_.removed == false)
               {
                  _loc4_++;
                  if(dataM.runAsMobile)
                  {
                     _loc23_ = new mcOnlinePlayerslListRow_mobile();
                     TextUtils.updateTextFormat(_loc23_.txtName,15);
                     switch(_loc12_.lastDevice)
                     {
                        case "1":
                        case "2":
                           _loc23_.txtName.x += 18;
                           _loc23_.txtName.width -= 18;
                           break;
                        default:
                           _loc23_.mcMobileDevice.parent.removeChild(_loc23_.mcMobileDevice);
                           _loc23_.mcMobileDevice = null;
                     }
                  }
                  else
                  {
                     _loc23_ = new mcOnlinePlayerslListRow();
                     TextUtils.updateTextFormat(_loc23_.txtName,14);
                     switch(_loc12_.lastDevice)
                     {
                        case "1":
                        case "2":
                           _loc23_.txtName.x += 13;
                           _loc23_.txtName.width -= 13;
                           break;
                        default:
                           _loc23_.mcMobileDevice.parent.removeChild(_loc23_.mcMobileDevice);
                           _loc23_.mcMobileDevice = null;
                     }
                  }
                  _loc24_ = _loc12_.playerName;
                  if(_loc12_.playerID == dataM.userID)
                  {
                     _loc24_ = "<FONT COLOR=\'#" + dataM.chatData.COLOR_SELF + "\'>" + _loc24_ + "</FONT>";
                  }
                  else if(dataM.isPlayerIDAdmin(_loc12_.playerID))
                  {
                     _loc24_ = "<FONT COLOR=\'#" + dataM.chatData.COLOR_ADMIN + "\'>" + _loc24_ + "</FONT>";
                  }
                  else if(_loc6_[_loc12_.playerID] != null)
                  {
                     _loc24_ = "<FONT COLOR=\'#" + dataM.chatData.COLOR_FRIEND + "\'>" + _loc24_ + "</FONT>";
                  }
                  if(_loc4_ % 2 == 0)
                  {
                     _loc23_.mcBackground.gotoAndStop("regular2");
                  }
                  updateTextAndFormat(_loc23_.txtName,_loc24_);
                  _loc25_ = false;
                  if(_loc12_.geo != "" && _loc12_.geo != null)
                  {
                     _loc25_ = true;
                  }
                  if(_loc25_)
                  {
                     _loc26_ = dataM.getAvatarImage(_loc12_.geo);
                     _loc26_.x = _loc23_.mcSizer_flag.x;
                     _loc26_.y = _loc23_.mcSizer_flag.y;
                  }
                  if(_loc12_.playerID == dataM.userID)
                  {
                     _loc27_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc2_.ladderProgress));
                  }
                  else
                  {
                     _loc27_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc12_.ladderProgress));
                  }
                  _loc28_ = externalAssetsM.getAsset("general","Grp_rank" + _loc27_);
                  _loc28_.width = _loc23_.mcSizer_rank.width;
                  _loc28_.height = _loc23_.mcSizer_rank.height;
                  _loc28_.x = _loc23_.mcSizer_rank.x;
                  _loc28_.y = _loc23_.mcSizer_rank.y;
                  _loc23_.addChild(_loc28_);
                  _loc29_ = new BMItem();
                  _loc29_.initialize(_loc12_.playerID,this.ONLINE_PLAYERS_LIST_WIDTH,this.ONLINE_PLAYERS_LIST_ROW_HEIGHT,_loc23_,-1,-1,false,null,dataM.runAsMobile);
                  if(dataM.runAsMobile)
                  {
                     _loc29_.createAssetsBitmap([_loc23_.txtName],[_loc28_],_loc23_);
                  }
                  _loc30_ = new BMTileListItem();
                  _loc31_ = this.onlinePlayersListItemClicked;
                  if(dataM.runAsMobile)
                  {
                     _loc31_ = null;
                  }
                  _loc30_.initialize(this.ONLINE_PLAYERS_LIST_WIDTH,this.ONLINE_PLAYERS_LIST_ROW_HEIGHT,_loc29_,"","","",0,_loc31_,null,null,null,null,dataM.runAsMobile);
                  if(_loc25_)
                  {
                     _loc30_.itemsThatNeedsAddingAndRemoving.push(_loc26_);
                  }
                  _loc3_.push(_loc30_);
               }
               _loc5_++;
            }
            if(this.onlinePlayersTileList == null)
            {
               this.onlinePlayersTileList = new BMTileList();
               _loc32_ = false;
               if(dataM.runAsMobile)
               {
                  this._fingerWheeling_onlinePlayers.resetTileList(this.onlinePlayersTileList);
                  _loc32_ = true;
                  this.onlinePlayersTileList.activateExtendedMode(0.55,true);
               }
               _loc33_ = new Grp_scrollerContent();
               this.onlinePlayersTileList.initialize(screensM.stagePointer.stage,_loc3_,this.ONLINE_PLAYERS_LIST_ROWS,1,this.ONLINE_PLAYERS_LIST_WIDTH,this.ONLINE_PLAYERS_LIST_ROW_HEIGHT,null,true,_loc33_,null,null,false,0,0.5,true,_loc32_,dataM.runAsMobile);
               this.onlinePlayersTileList.x = this.mcSizer_onlinePlayersTileList.x;
               this.onlinePlayersTileList.y = this.mcSizer_onlinePlayersTileList.y;
               this.mcButtonsHolder.addChild(this.onlinePlayersTileList);
            }
            else
            {
               _loc34_ = this.onlinePlayersTileList.getCurrentRow();
               this.onlinePlayersTileList.removeAllItems();
               this.onlinePlayersTileList.addItems(0,_loc3_,true);
               this.onlinePlayersTileList.jumpToRow(_loc34_,false,"menuChat addAndRefreshOnlinePlayersTileList");
               if(dataM.runAsMobile)
               {
                  this._fingerWheeling_onlinePlayers.tileListItemsModified();
               }
            }
         }
      }
      
      private function onlinePlayersListItemClicked(param1:Number, param2:Number) : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            this.tryToInspectPlayer(param2);
            soundM.createSound("buttonClick",1);
         }
      }
      
      public function tryToInspectPlayerForMobile() : void
      {
         this.tryToInspectPlayer(this.chatInterface.getRollOverPlayerID());
      }
      
      private function tryToInspectPlayer(param1:Number) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc2_:Boolean = true;
         if(param1 >= dataM.chatData.CHAT_LANGUAGES && param1 != dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID)
         {
            if(dataM.chatData.playersData[param1] != null)
            {
               if(param1 != dataM.userID)
               {
                  screensM.addScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
                  _loc3_ = false;
                  _loc4_ = Number(dataM.chatData.playersData[param1].clanID);
                  if(dataM.chatData.clanInvitations[_loc4_] != null)
                  {
                     _loc3_ = true;
                  }
                  if(_loc3_)
                  {
                     screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,false,true,this.chatInterface.isRollOverClanMessage());
                  }
                  else
                  {
                     _loc5_ = false;
                     if(dataM.chatData.battleInvitations[param1] != null)
                     {
                        _loc5_ = true;
                     }
                     if(_loc5_)
                     {
                        screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,true,false,this.chatInterface.isRollOverClanMessage());
                     }
                     else
                     {
                        screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,false,false,this.chatInterface.isRollOverClanMessage());
                     }
                  }
                  _loc2_ = false;
               }
            }
         }
         if(_loc2_)
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT))
            {
               screensM.removeScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
            }
         }
      }
      
      public function channelsListClicked() : void
      {
         var _loc1_:MovieClip = null;
         if(screensM.screenBlack.isActive() == false)
         {
            if(this.channelsList.visible)
            {
               this.channelsList.close();
               _loc1_ = externalAssetsM.getAsset("general","interface_openDropList");
               this.btnChannelsList.replacePicture(_loc1_);
            }
            else
            {
               this.channelsList.open();
               _loc1_ = externalAssetsM.getAsset("general","interface_closeDropList");
               this.btnChannelsList.replacePicture(_loc1_);
            }
         }
      }
      
      private function channelClicked(param1:Number, param2:Number) : void
      {
         if(screensM.screenBlack.isActive())
         {
            return;
         }
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         switch(param2)
         {
            case 3:
            case 4:
            case 5:
               if(dataM.getLadderRankByProgress(_loc4_.ladderProgress) > 5)
               {
                  _loc3_ = true;
               }
         }
         var _loc5_:String = this._onlinePlayersTab;
         switch(param2)
         {
            case dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID:
               this._onlinePlayersTab = "clan";
               break;
            default:
               this._onlinePlayersTab = "all";
         }
         if(_loc5_ != this._onlinePlayersTab)
         {
            this.addAndRefreshOnlinePlayersTileList();
         }
         if(_loc3_)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("chatForHighRanksOnly");
         }
         else
         {
            this.channelClickedSub(param2);
         }
         soundM.createSound("buttonClick",1);
      }
      
      public function chatPlayerClicked(param1:Number, param2:Boolean, param3:Boolean = false) : void
      {
         if(param3 || screensM.screenBlack.isActive() == false)
         {
            if(param2)
            {
               this.channelClickedSub(dataM.chatData.CHAT_CLAN_CHANNEL_PLAYER_ID);
            }
            else
            {
               dataM.chatData.addChannel(param1,dataM.chatData.playersData[param1].playerName);
               this.channelsList.addAndRefreshChannelsTileList();
               this.channelClickedSub(param1);
            }
         }
      }
      
      public function channelClickedSub(param1:Number) : void
      {
         if(param1 <= -1)
         {
            return;
         }
         if(dataM.chatData.currentChannelPlayerID != param1)
         {
            dataM.chatData.currentChannelPlayerID = param1;
            this.refreshCurrentChannelText();
            this.chatInterface.setStageFocusOnChatInput();
         }
         dataM.chatData.lastChatChannel = dataM.chatData.currentChannelPlayerID;
         this.channelsList.close();
         this.chatInterface.refreshChatHistory();
         var _loc2_:MovieClip = externalAssetsM.getAsset("general","interface_openDropList");
         this.btnChannelsList.replacePicture(_loc2_);
         this.channelsList.resetChannelMessagesCounter(dataM.chatData.currentChannelPlayerID);
      }
      
      public function refreshCurrentChannelText() : void
      {
         var _loc1_:String = dataM.chatData.getCurrentChannelText();
         updateTextAndFormat(this.txtCurrentChannel,_loc1_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("menuMultiPlayerChat_txtCurrentChannel",[this.txtCurrentChannel],"",this);
         }
      }
      
      private function backMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("menu_back"),-1,-1);
      }
      
      private function backToLadderMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("goToLadderBattles"));
      }
      
      private function channelsListMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("channelsList"),-1,-1);
      }
      
      private function hangerMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("menu_hanger"),-1,-1);
      }
      
      private function multiPlayerMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("worldMapSelectBattle_battle"),-1,-1);
      }
      
      private function rankingListMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("menu_rankingList"),-1,-1);
      }
      
      private function clanMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("menu_clan"),-1,-1);
      }
      
      private function packagesShopMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("menu_packagesShop"),-1,-1);
      }
      
      private function searchForPlayerMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("searchForPlayer"));
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      public function clanInvitationCancelled(param1:Number) : void
      {
         var _loc2_:Object = dataM.chatData.clanInvitations[param1];
         if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT) && dataM.onlinePlayersInspect_playerID == _loc2_.leaderID)
         {
            screensM.screenMenuMultiPlayerInspect.refreshScreen(_loc2_.leaderID,false,false,false);
         }
      }
      
      public function findBattleSuccess() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_VS))
         {
            this.findBattleSuccessSub();
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.findBattleSuccessSub,true,true,null,0);
         }
      }
      
      private function findBattleSuccessSub() : void
      {
         if(this.acceptingBattleInvitation)
         {
            dataM.battle_inBattleInvitation = true;
            this.acceptingBattleInvitation = false;
         }
         screensM.addBattleScreens();
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.removeOnlinePlayersTileList();
         screensM.screenTransitionsManager.removeCurrentScreen();
         screensM.screenTransitionsManager.removeMe();
      }
      
      public function battleInvitationCancelled(param1:Number) : void
      {
         this.acceptingBattleInvitation = false;
         if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT) && dataM.onlinePlayersInspect_playerID == param1)
         {
            screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,false,false,false);
         }
      }
      
      public function battleInvitationDeclined(param1:Number) : void
      {
         screensM.screenMultiPlayerChat.acceptingBattleInvitation = false;
         if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT) && dataM.onlinePlayersInspect_playerID == param1)
         {
            screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,false,false,false);
         }
      }
      
      public function playerLeftChat() : void
      {
         if(dataM.chatData.playersData[dataM.onlinePlayersInspect_playerID] != null)
         {
            dataM.chatData.playersData[dataM.onlinePlayersInspect_playerID].removed = true;
            this.onlinePlayersTileList.removeItems([dataM.onlinePlayersInspect_playerID],"tileListItemID");
         }
      }
      
      public function battleInvitationsEnabledClicked() : void
      {
         dataM.chatData.battleInvitationsEnabled = false;
         this.refreshBattleInvitationsEnableDisableButtons();
         tooltip.hideToolTip();
      }
      
      public function battleInvitationsDisabledClicked() : void
      {
         dataM.chatData.battleInvitationsEnabled = true;
         this.refreshBattleInvitationsEnableDisableButtons();
         tooltip.hideToolTip();
      }
      
      private function refreshBattleInvitationsEnableDisableButtons() : void
      {
         this.btnBattleInvitationsEnabled.visible = false;
         this.btnBattleInvitationsDisabled.visible = false;
         var _loc1_:String = "";
         if(dataM.chatData.battleInvitationsEnabled)
         {
            this.btnBattleInvitationsEnabled.visible = true;
            _loc1_ = getScreenText("battleInvitationsEnabled");
         }
         else
         {
            this.btnBattleInvitationsDisabled.visible = true;
            _loc1_ = getScreenText("battleInvitationsDisabled");
         }
         updateTextAndFormat(this.txtBattleInvitationsStatus,_loc1_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("menuMultiPlayerChat_battleInvitationsStatus",[this.txtBattleInvitationsStatus],"",this);
         }
      }
      
      public function findPlayerClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("findPlayer",-1,-1);
      }
      
      public function backToLadderClicked() : void
      {
         screensM.screenTransitionsManager.multiplayerLadderClicked();
      }
      
      public function searchForPlayerClicked() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            screensM.addScreen(BMScreensManager.SCR_SEARCH_FOR_PLAYER);
            screensM.screenSearchForPlayer.refreshScreen();
            if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT))
            {
               screensM.screenMenuMultiPlayerInspect.closeClicked();
            }
            if(this.channelsList.visible)
            {
               this.channelsListClicked();
            }
         }
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_MULTIPLAYER_CHAT);
         screensM.removeScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
         if(screensM.isScreenOpened(BMScreensManager.SCR_SELECT_BATTLE_MECHS_PER_PLAYER))
         {
            screensM.screenSelectBattleMechsPerPlayer.removeMe();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_SEARCH_FOR_PLAYER))
         {
            screensM.screenSearchForPlayer.backClicked();
         }
         this.removeOnlinePlayersTileList();
         tooltip.hideToolTip();
         this.mcSandClock.gotoAndStop("animOff");
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_onlinePlayers.removeMouseListeners();
         }
      }
      
      private function disableAllButtons(param1:Boolean) : void
      {
         if(param1)
         {
            this.chatInterface.disableAllButtons();
            this.btnChannelsList.disableMe();
            this.btnSearchForPlayer.disableMe();
         }
         screensM.screenTopBar.disableButtons();
      }
      
      private function enableAllButtons() : void
      {
         this.chatInterface.enableAllButtons();
         this.btnChannelsList.enableMe();
         this.btnSearchForPlayer.enableMe();
         screensM.screenTopBar.enableButtons("screenMultiPlayerChat enableAllButtons");
      }
      
      public function backClicked(param1:Boolean = false) : void
      {
         if(param1)
         {
            screensM.screenTransitionsManager.mainMenu();
         }
         else if(screensM.screenTransitionsManager.prevScreen == "communityClan")
         {
            screensM.screenTransitionsManager.communityClanClicked();
         }
         else
         {
            screensM.screenTransitionsManager.multiplayerLadderClicked();
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen(true);
      }
   }
}

