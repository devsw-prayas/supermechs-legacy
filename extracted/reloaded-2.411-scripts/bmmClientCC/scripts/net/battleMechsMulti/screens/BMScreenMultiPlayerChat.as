package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMChatMessageData;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMScroller;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1120")]
   public class BMScreenMultiPlayerChat extends BMBaseScreen
   {
      
      public var txtChatHistory:TextField;
      
      public var txtChatInput:TextField;
      
      public var txtSizeTester:TextField;
      
      public var txtCurrentChannel:TextField;
      
      public var txtPlayersInLobby:TextField;
      
      public var txtBattleInvitationsStatus:TextField;
      
      public var mcSizer_btnBackToLadder:Sprite;
      
      public var mcSizer_btnSendMessage:Sprite;
      
      public var mcSizer_btnBattleInvitationsEnabled:Sprite;
      
      public var mcSizer_btnBattleInvitationsDisabled:Sprite;
      
      public var mcSizer_btnSearchForBattle:Sprite;
      
      public var mcSizer_btnSearchForPlayer:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnChannelsList:Sprite;
      
      public var mcSizer_onlinePlayersTileList:Sprite;
      
      public var mcSizer_scroller:Sprite;
      
      public var mcQuickMatchIcon:Sprite;
      
      public var mcFingerWheeling_onlinePlayers:Sprite;
      
      public var mcFingerWheeling_channels:Sprite;
      
      public var mcChatMouseHitArea:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcTextBitmapHolder:Sprite;
      
      public var mcTextMarker:Sprite;
      
      public var btnBackToLadder:BMButton_pictureE;
      
      public var btnChannelsList:BMButton_pictureE;
      
      public var btnSendMessage:BMButton_pictureE;
      
      public var btnBattleInvitationsEnabled:BMButton_pictureE;
      
      public var btnBattleInvitationsDisabled:BMButton_pictureE;
      
      public var btnSearchForPlayer:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureE;
      
      public var mcChannelsHolder:Sprite;
      
      public var mcChannelsBackground:MovieClip;
      
      public var mcSandClock:MovieClip;
      
      private var scroller:BMScroller;
      
      private var channelsServer:Array = new Array();
      
      private var channelsAdmins:Array = new Array();
      
      private var channelsClan:Array = new Array();
      
      private var channelsClanMembers:Array = new Array();
      
      private var channelsRegular:Array = new Array();
      
      private var channelsTileList:BMTileList;
      
      private var onlinePlayersTileList:BMTileList;
      
      private var _mouseOverHistory:Boolean = false;
      
      private var _rollOverPlayerID:Number = 0;
      
      private var _rollOverClanMessage:Boolean = false;
      
      private var _lastTargetRow:Number = -1;
      
      private var _channelPlayerID:Number = 0;
      
      private var _firstRefresh:Boolean = true;
      
      private var _channels:Array = new Array();
      
      private var _fingerWheeling_onlinePlayers:BMFingerWheeling;
      
      private var _fingerWheeling_channels:BMFingerWheeling;
      
      private var _refreshOnlinePlayersFrameCounter:Number = 0;
      
      private var _inactivityCounter:uint;
      
      private var _serverTipsActive:Boolean;
      
      private var _serverTipCountdown:Number = 30;
      
      private var _serverTipFrames:Number;
      
      private var _differentUserConnected:Boolean = false;
      
      private var _lastChatInputLength:uint = 0;
      
      private var _addOnlinePlayersTileListFrameCounter:uint = 40;
      
      private var _refreshOnlineTileListForNewMessangerFrameCounter:uint = 0;
      
      private var _onlinePlayersTab:String = "all";
      
      private var _lastTotalPlayersInLobby:uint = 0;
      
      public var channelsVisibleOnLastFrame:Boolean = false;
      
      public var pendingClanMessages:Number = 0;
      
      public var acceptingBattleInvitation:Boolean = false;
      
      private const GIFT_KEY_CHARS:Object = new Object();
      
      private const CHAT_MAX_ROWS:Number = 16;
      
      private const ROW_HEIGHT:Number = 20.5;
      
      private var ONLINE_PLAYERS_LIST_ROWS:Number = 13;
      
      private var ONLINE_PLAYERS_LIST_WIDTH:Number = 185;
      
      private var ONLINE_PLAYERS_LIST_ROW_HEIGHT:Number = 29;
      
      private var MAX_PLAYERS_TO_DISPLAY:uint = 30;
      
      private const SEND_MESSAGE_COOLDOWN_FRAMES:Number = 100;
      
      private var CLEAN_CHAT_MESSAGES_MAX:Number = 40;
      
      private var CLEAN_CHAT_MESSAGES_REMAIN:Number = 25;
      
      private const REFRESH_ONLINE_PLAYERS_FRAMES:Number = 5000;
      
      private const INACTIVITY_FRAMES:uint = 10000;
      
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
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         var _loc9_:Function = null;
         var _loc10_:Function = null;
         var _loc11_:MovieClip = null;
         var _loc12_:Number = NaN;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("multiplayerChat");
            screensM.createButtonFromSizer("screenMultiPlayerChat","btnBackToLadder","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerChat","btnChannelsList","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerChat","btnSendMessage","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerChat","btnBattleInvitationsEnabled","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerChat","btnBattleInvitationsDisabled","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerChat","btnSearchForPlayer","pictureE");
            screensM.createButtonFromSizer("screenMultiPlayerChat","btnBack","pictureE");
            _loc5_ = this.backToLadderClicked;
            _loc6_ = this.channelsListClicked;
            _loc7_ = this.sendMessageClicked;
            _loc8_ = this.battleInvitationsEnabledClicked;
            _loc9_ = this.battleInvitationsDisabledClicked;
            _loc10_ = this.searchForPlayerClicked;
            if(dataM.runAsMobile)
            {
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
               _loc9_ = null;
               _loc10_ = null;
            }
            this.btnBackToLadder.initialize("","",externalAssetsM.getAsset("general","interface_ladderBattles"),null,_loc5_,dataM.runAsMobile);
            this.btnChannelsList.initialize("","",externalAssetsM.getAsset("general","interface_openDropList"),null,_loc6_,dataM.runAsMobile);
            this.btnSendMessage.initialize("","",externalAssetsM.getAsset("general","interface_chat"),null,_loc7_,dataM.runAsMobile);
            this.btnBattleInvitationsEnabled.initialize("","",externalAssetsM.getAsset("general","interface_battleInvitationsEnabled"),null,_loc8_,dataM.runAsMobile);
            this.btnBattleInvitationsDisabled.initialize("","",externalAssetsM.getAsset("general","interface_battleInvitationsDisabled"),null,_loc9_,dataM.runAsMobile);
            this.btnSearchForPlayer.initialize("","",externalAssetsM.getAsset("general","interface_inspect"),null,_loc10_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            if(dataM.runAsMobile == false)
            {
               this.btnBackToLadder.buttonCore.addMouseOverListerner(this.backToLadderMouseOver);
               this.btnBackToLadder.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnChannelsList.buttonCore.addMouseOverListerner(this.channelsListMouseOver);
               this.btnChannelsList.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnSendMessage.buttonCore.addMouseOverListerner(this.sendMessageMouseOver);
               this.btnSendMessage.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnSearchForPlayer.buttonCore.addMouseOverListerner(this.searchForPlayerMouseOver);
               this.btnSearchForPlayer.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
            }
            this.btnBackToLadder.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChannelsList.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSendMessage.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBattleInvitationsEnabled.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBattleInvitationsDisabled.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSearchForPlayer.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            if(!dataM.runAsMobile)
            {
               this.scroller = new BMScroller();
               _loc11_ = new Grp_scrollerContent();
               _loc12_ = 0.2;
               this.scroller.initialize(screensM.stagePointer,this.mcSizer_scroller.height * 1.66,_loc12_,_loc11_,this.scrollerScrolled,this.scrollingEnded,this.scrollerButtonUp,this.scrollerButtonDown,false,dataM.runAsMobile);
               this.scroller.x = this.mcSizer_scroller.x;
               this.scroller.y = this.mcSizer_scroller.y;
               this.scroller.width *= 0.7;
               this.scroller.height *= 0.6;
               this.mcButtonsHolder.addChild(this.scroller);
               this.scroller.disableMe();
            }
            this.txtChatHistory.htmlText = "";
            this.txtChatInput.text = "";
            this.txtChatInput.restrict = "^<>&";
            this.txtChatInput.addEventListener(Event.CHANGE,this.chatInputChanged);
            this._lastChatInputLength = 0;
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
            }
            if(Math.abs(this.txtChatHistory.width - this.txtSizeTester.width) > 0.5)
            {
               TsLogger.log("WARNING - SIZE TESTER TEXT WIDTH DOES NOT EQUAL CHAT\'S WIDTH (SCREEN MENU CHAT)");
            }
            if(dataM.runAsMobile == false)
            {
               this.mcChatMouseHitArea.addEventListener(MouseEvent.CLICK,this.mouseHitAreaClicked);
               this.mcChatMouseHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.mouseHitAreaMouseOver);
               this.mcChatMouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.mouseHitAreaMouseOut);
            }
            this.mcTextMarker.visible = false;
            addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
            if(dataM.runAsMobile)
            {
               this.CLEAN_CHAT_MESSAGES_MAX = this.CHAT_MAX_ROWS + 1;
               this.CLEAN_CHAT_MESSAGES_REMAIN = this.CHAT_MAX_ROWS;
               this.ONLINE_PLAYERS_LIST_ROWS = 9;
               this.ONLINE_PLAYERS_LIST_WIDTH = 205;
               this.ONLINE_PLAYERS_LIST_ROW_HEIGHT = 40;
               this.MAX_PLAYERS_TO_DISPLAY = 14;
            }
            if(dataM.runAsMobile)
            {
               this._fingerWheeling_onlinePlayers = new BMFingerWheeling();
               this._fingerWheeling_onlinePlayers.initialize("onliePlayers",this.onlinePlayersTileList,this.mcFingerWheeling_onlinePlayers,this.onlinePlayersListItemClicked,null,false);
               addChild(this._fingerWheeling_onlinePlayers);
               this._fingerWheeling_channels = new BMFingerWheeling();
               this._fingerWheeling_channels.initialize("channels",this.channelsTileList,this.mcFingerWheeling_channels,this.channelClicked,null,false);
               addChild(this._fingerWheeling_channels);
               this.txtSizeTester.parent.removeChild(this.txtSizeTester);
               this.txtChatHistory.width += 34;
               this.txtSizeTester.width += 34;
               this.mcTextMarker.width += 34;
               this.mcChatMouseHitArea.width += 34;
            }
            else
            {
               this.mcFingerWheeling_onlinePlayers.parent.removeChild(this.mcFingerWheeling_onlinePlayers);
               this.mcFingerWheeling_onlinePlayers = null;
               this.mcFingerWheeling_channels.parent.removeChild(this.mcFingerWheeling_channels);
               this.mcFingerWheeling_channels = null;
            }
            this.createGiftKeyChars();
            this.languageUpdate();
            this._firstRefresh = false;
         }
         keyboardM.setKeyboardOutputFunction(this.keyboardOutput,"screeMenuChat refreshScreen");
         keyboardM.activateMe("screenMultiPlayerChat");
         this.resetInactivityCounter();
         dataM.battleLaunchScreen = "screenMultiPlayerChat";
         this._mouseOverHistory = false;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc3_.level <= 15)
         {
            this._serverTipsActive = true;
            this._serverTipFrames = 1500;
         }
         else
         {
            this._serverTipsActive = false;
         }
         this._onlinePlayersTab = "all";
         var _loc4_:Boolean = false;
         if(dataM.chat_differentUserConnected)
         {
            this._channelPlayerID = dataM.chatDefaultLanguageID;
            if(dataM.getLadderRankByProgress(_loc3_.ladderProgress) <= 3)
            {
               this._channelPlayerID += 3;
            }
            if(dataM.chat_goToClanChat)
            {
               this._channelPlayerID = dataM.CHAT_CLAN_CHANNEL_PLAYER_ID;
               this._onlinePlayersTab = "clan";
               dataM.chat_pendingClanMessages = 0;
               dataM.chat_goToClanChat = false;
            }
            else if(dataM.chat_goToSpecificPlayerChatPlayerID > 0)
            {
               this._channelPlayerID = dataM.chat_goToSpecificPlayerChatPlayerID;
               dataM.chat_goToSpecificPlayerChatPlayerID = 0;
            }
         }
         else
         {
            if(lastLanguageID != dataM.languageID)
            {
               this.languageUpdate(true);
            }
            if(dataM.chat_goToClanChat)
            {
               this._channelPlayerID = dataM.CHAT_CLAN_CHANNEL_PLAYER_ID;
               this._onlinePlayersTab = "clan";
               dataM.chat_goToClanChat = false;
            }
            else if(dataM.chat_goToSpecificPlayerChatPlayerID > 0)
            {
               this._channelPlayerID = dataM.chat_goToSpecificPlayerChatPlayerID;
               dataM.chat_goToSpecificPlayerChatPlayerID = 0;
            }
            else
            {
               this._channelPlayerID = dataM.chat_lastChatChannel;
            }
         }
         dataM.chat_lastChatChannel = this._channelPlayerID;
         this.initializeChannelsTileList();
         this.addAndRefreshChannelsTileList();
         this.addAndRefreshOnlinePlayersTileList();
         this.refreshChatHistory();
         this.closeChannelsTileList();
         this.refreshCurrentChannelText();
         this.acceptingBattleInvitation = false;
         this.enableAllButtons();
         this.refreshPlayersInLobbyText();
         this.refreshBattleInvitationsEnableDisableButtons();
         if(param1)
         {
            remoteM.socketM.chat_enter(1);
         }
         if(dataM.chat_goToInspectPlayerID > 0)
         {
            this.tryToInspectPlayer(dataM.chat_goToInspectPlayerID);
            dataM.chat_goToInspectPlayerID = 0;
         }
         dataM.chat_differentUserConnected = false;
      }
      
      public function refreshPlayersInLobbyText() : void
      {
         var _loc1_:String = getSpecificText("multiplayerLadder_playersInLobby");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%PLAYERS%",String(dataM.chat_totalPlayersInLobby));
         this.txtPlayersInLobby.text = _loc1_;
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
            TextUtils.updateTextFormat(this.txtBattleInvitationsStatus,16);
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
            TextUtils.updateTextFormat(this.txtChatHistory,_loc2_);
            TextUtils.updateTextFormat(this.txtChatInput,_loc2_);
            TextUtils.updateTextFormat(this.txtCurrentChannel,18);
            TextUtils.updateTextFormat(this.txtPlayersInLobby,18);
            TextUtils.updateTextFormat(this.txtSizeTester,_loc2_);
         }
         if(param1)
         {
            dataM.chat_channelsLanguageUpdate();
         }
      }
      
      private function addedToStage(param1:Event) : void
      {
         if(stage != null)
         {
            stage.focus = this.txtChatInput;
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_onlinePlayers.cancelFingerWheeling();
            this._fingerWheeling_channels.cancelFingerWheeling();
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         if(screensM.screenBlack.isActive() == false)
         {
            if(dataM.chat_goToChatAfterBattleUserID > 0)
            {
               _loc1_ = false;
               _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc2_.clanID > 0)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_.clan_members.length)
                  {
                     _loc4_ = _loc2_.clan_members[_loc3_];
                     if(_loc4_.playerID == dataM.chat_goToChatAfterBattleUserID)
                     {
                        _loc1_ = true;
                        _loc3_ = _loc2_.clan_members.length;
                     }
                     _loc3_++;
                  }
               }
               if(dataM.chat_playersData[dataM.chat_goToChatAfterBattleUserID] == null)
               {
                  this.addPlayerToChatPlayersData(dataM.chat_goToChatAfterBattleUserID,dataM.chat_addPlayerDataAfterBattleName,dataM.chat_addPlayerDataAfterBattleLevel,dataM.chat_addPlayerDataAfterBattleClanID,dataM.chat_addPlayerDataAfterBattleLadderProgress,dataM.chat_addPlayerDataAfterBattleGeo,"");
               }
               this.chatPlayerClicked(dataM.chat_goToChatAfterBattleUserID,_loc1_,true);
               dataM.chat_goToChatAfterBattleUserID = 0;
            }
            else if(dataM.chat_inviteToClanAfterBattleUserID > 0)
            {
               if(dataM.chat_playersData[dataM.chat_inviteToClanAfterBattleUserID] == null)
               {
                  this.addPlayerToChatPlayersData(dataM.chat_inviteToClanAfterBattleUserID,dataM.chat_addPlayerDataAfterBattleName,dataM.chat_addPlayerDataAfterBattleLevel,dataM.chat_addPlayerDataAfterBattleClanID,dataM.chat_addPlayerDataAfterBattleLadderProgress,dataM.chat_addPlayerDataAfterBattleGeo,"");
               }
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               remoteM.socketM.clan_sendInvitation(dataM.chat_inviteToClanAfterBattleUserID);
               dataM.chat_inviteToClanAfterBattleUserID = 0;
            }
            else
            {
               if(dataM.runAsMobile == false)
               {
                  this.chatHistoryMouseOverHandler();
               }
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
                     remoteM.socketM.chat_enter(1);
                     this._refreshOnlinePlayersFrameCounter = 0;
                  }
                  if(dataM.runAsMobile)
                  {
                     this._fingerWheeling_onlinePlayers.onEnterFrameTrigger();
                  }
               }
               if(dataM.runAsMobile)
               {
                  this._fingerWheeling_channels.onEnterFrameTrigger();
                  this.channelsVisibleOnLastFrame = this.mcChannelsBackground.visible;
               }
               this.inactivityHandler();
               if(this._serverTipsActive)
               {
                  if(this._serverTipCountdown > 0)
                  {
                     --this._serverTipCountdown;
                  }
                  else
                  {
                     this._serverTipCountdown = this._serverTipFrames;
                     _loc6_ = Math.ceil(Math.random() * 38);
                     _loc7_ = "<FONT COLOR=\'#" + dataM.COLOR_TIP + "\'>" + getSpecificText("tip_" + _loc6_) + "</FONT>";
                  }
               }
            }
         }
         if(dataM.chat_sendMessageCooldown == 0)
         {
            if(this.txtChatInput.alpha < 1)
            {
               this.txtChatInput.alpha = 1;
               this.btnSendMessage.enableMe();
            }
         }
      }
      
      private function inactivityHandler() : void
      {
         if(screensM.isScreenOpened("screenConfirmation") == false)
         {
            if(screensM.isScreenOpened("screenLevelUp") == false)
            {
               if(this._inactivityCounter > this.INACTIVITY_FRAMES)
               {
                  if(screensM.isScreenOpened("screenInspectPlayer"))
                  {
                     screensM.screenInspectPlayer.backClicked();
                  }
                  screensM.screenNewMenu.hangerMechClicked();
                  this._inactivityCounter = 0;
               }
               else
               {
                  ++this._inactivityCounter;
               }
            }
         }
      }
      
      public function resetInactivityCounter() : void
      {
         if(screensM.isScreenOpened("screenMultiPlayerChat"))
         {
            this._inactivityCounter = 0;
         }
      }
      
      public function addPlayerToChatPlayersData(param1:Number, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String) : void
      {
         var _loc9_:BMPlayerProfile = null;
         var _loc8_:Boolean = true;
         if(dataM.chat_playersData[param1] != null)
         {
            _loc8_ = false;
         }
         if(param1 == dataM.userID)
         {
            _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            param2 = _loc9_.playerName;
            if(_loc8_ == false)
            {
               dataM.chat_playersData[param1].playerName = param2;
            }
         }
         if(_loc8_)
         {
            dataM.chat_playersData[param1] = new Object();
            dataM.chat_playersData[param1].playerID = param1;
            dataM.chat_playersData[param1].playerName = param2;
            dataM.chat_playersData[param1].geo = param6;
            dataM.chat_playersData[param1].lastDevice = param7;
            dataM.chat_playersData[param1].blocked = false;
         }
         dataM.chat_playersData[param1].level = param3;
         dataM.chat_playersData[param1].clanID = param4;
         dataM.chat_playersData[param1].ladderProgress = param5;
         dataM.chat_playersData[param1].removed = false;
      }
      
      public function getChannelPlayerID() : Number
      {
         return this._channelPlayerID;
      }
      
      public function addGlobalChatMessage(param1:Number, param2:uint, param3:Boolean = false) : void
      {
         var _loc13_:Boolean = false;
         var _loc4_:BMChatMessageData = dataM.chat_log[param1][param2];
         var _loc5_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc6_:String = dataM.COLOR_REGULAR_PLAYER;
         var _loc7_:String = dataM.COLOR_TEXT;
         switch(_loc4_.type)
         {
            case "battleInvitation":
            case "clanInvitation":
               _loc6_ = dataM.COLOR_SERVER;
               _loc7_ = dataM.COLOR_SERVER;
               break;
            case "privateMessageAlert":
               _loc6_ = dataM.COLOR_SERVER;
               _loc7_ = dataM.COLOR_SERVER;
               break;
            case "clanMessageAlert":
               _loc6_ = dataM.COLOR_CLAN_MESSAGE;
               _loc7_ = dataM.COLOR_CLAN_MESSAGE;
               break;
            case "message":
               if(_loc4_.fromPlayerID == dataM.userID)
               {
                  _loc6_ = dataM.COLOR_SELF;
               }
               else
               {
                  _loc13_ = false;
                  if(_loc5_.clanID > 0)
                  {
                     if(dataM.chat_playersData[_loc4_.fromPlayerID] != null)
                     {
                        if(dataM.chat_playersData[_loc4_.fromPlayerID].clanID == _loc5_.clanID)
                        {
                           _loc13_ = true;
                        }
                     }
                  }
                  if(_loc13_)
                  {
                     _loc6_ = dataM.COLOR_FRIEND;
                  }
                  else if(_loc4_.toPlayerID == dataM.CHAT_CLAN_CHANNEL_PLAYER_ID)
                  {
                     _loc6_ = dataM.COLOR_FRIEND;
                  }
                  else if(dataM.isPlayerIDAdmin(_loc4_.fromPlayerID))
                  {
                     _loc6_ = dataM.COLOR_ADMIN;
                  }
               }
         }
         var _loc8_:String = _loc4_.message;
         var _loc9_:String = "<FONT COLOR=\'#" + _loc6_ + "\'>" + _loc4_.name + "</FONT><FONT COLOR=\'#" + _loc7_ + "\'> : " + _loc8_ + "</FONT>";
         var _loc10_:uint = 15;
         var _loc11_:Number = 1.6;
         switch(dataM.languageID)
         {
            case 3:
            case 6:
            case 7:
            case 8:
            case 9:
               _loc10_ = 17;
               _loc11_ = 1.9;
         }
         if(param1 == this._channelPlayerID)
         {
            this.txtChatHistory.htmlText = TextUtils.getTextFont(_loc10_,_loc11_) + this.txtChatHistory.htmlText + _loc9_;
         }
         if(param3)
         {
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
            }
         }
         this.txtSizeTester.htmlText = TextUtils.getTextFont(_loc10_,_loc11_) + _loc9_;
         var _loc12_:Number = this.txtSizeTester.numLines;
         dataM.chat_log[param1][param2].rowsInLog = _loc12_;
         if(param3)
         {
            if(param1 == this._channelPlayerID)
            {
               if(this.txtChatHistory.numLines > this.CHAT_MAX_ROWS)
               {
                  if(dataM.runAsMobile == false)
                  {
                     this.scroller.enableMe();
                  }
                  if(this.txtChatHistory.scrollV > this.txtChatHistory.maxScrollV - 2 - _loc12_)
                  {
                     this.txtChatHistory.scrollV = this.txtChatHistory.maxScrollV;
                     if(param3)
                     {
                        if(dataM.runAsMobile)
                        {
                           screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
                        }
                     }
                     if(dataM.runAsMobile == false)
                     {
                        this.scroller.setScrollPosition(1);
                     }
                  }
               }
               else if(dataM.runAsMobile == false)
               {
                  this.scroller.disableMe();
               }
            }
         }
      }
      
      public function incraseChannelPendingMessages(param1:Number) : void
      {
         var _loc2_:BMTileListItem = this.channelsTileList.findTileListItemByTileListItemID(param1);
         if(_loc2_ != null)
         {
            if(param1 != this._channelPlayerID)
            {
               if(_loc2_.item.itemGrp.txtMessages.text != "99+")
               {
                  if(_loc2_.item.itemGrp.txtMessages.text == "")
                  {
                     _loc2_.item.itemGrp.txtMessages.text = "1";
                  }
                  else if(_loc2_.item.itemGrp.txtMessages.text == "99")
                  {
                     _loc2_.item.itemGrp.txtMessages.text = "99+";
                  }
                  else
                  {
                     _loc2_.item.itemGrp.txtMessages.text = String(int(_loc2_.item.itemGrp.txtMessages.text) + 1);
                  }
               }
            }
            else
            {
               _loc2_.item.itemGrp.txtMessages.text = "";
            }
         }
      }
      
      private function chatInputChanged(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(this._channelPlayerID < dataM.CHAT_CLAN_CHANNEL_PLAYER_ID)
         {
            _loc2_ = Math.abs(this.txtChatInput.text.length - this._lastChatInputLength);
            if(_loc2_ > 2)
            {
               this.txtChatInput.text = "";
            }
            this._lastChatInputLength = this.txtChatInput.text.length;
         }
      }
      
      private function sendChatMessage() : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc6_:Array = null;
         var _loc7_:Object = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:Boolean = false;
         var _loc1_:String = this.txtChatInput.text;
         if(_loc1_ != "" && dataM.chat_sendMessageCooldown == 0)
         {
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc3_ = true;
            _loc4_ = "";
            _loc5_ = false;
            _loc6_ = new Array();
            for each(_loc7_ in _loc2_.gifts)
            {
               if(_loc7_.receiverID == 0)
               {
                  _loc6_.push(_loc7_.giftKey);
               }
            }
            _loc8_ = 0;
            while(_loc8_ < _loc1_.length)
            {
               _loc9_ = _loc1_.substr(_loc8_,1);
               if(_loc9_ != " ")
               {
                  _loc3_ = false;
                  if(_loc6_.length == 0)
                  {
                     _loc8_ = uint(_loc1_.length);
                  }
                  else if(_loc9_ in this.GIFT_KEY_CHARS)
                  {
                     _loc4_ += _loc9_;
                  }
               }
               _loc8_++;
            }
            if(_loc6_.length > 0)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc4_.length)
               {
                  _loc9_ = _loc4_.substr(_loc8_,1);
                  if(_loc5_ == false)
                  {
                     _loc10_ = 0;
                     while(_loc10_ < _loc6_.length)
                     {
                        _loc11_ = _loc6_[_loc10_];
                        if(_loc4_.substr(_loc8_,_loc11_.length) == _loc11_)
                        {
                           _loc5_ = true;
                           _loc10_ = _loc6_.length;
                           _loc8_ = uint(_loc4_.length);
                        }
                        _loc10_++;
                     }
                  }
                  _loc8_++;
               }
            }
            if(_loc5_)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("cannotWriteGiftKeyInChat",-1,-1);
               this.txtChatInput.text = "";
               this._lastChatInputLength = 0;
            }
            else if(_loc3_ == false)
            {
               _loc12_ = false;
               if(dataM.iAmBannedFromChat)
               {
                  if(this._channelPlayerID < dataM.CHAT_CLAN_CHANNEL_PLAYER_ID)
                  {
                     _loc12_ = true;
                  }
               }
               if(_loc12_)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("youWereChatBlocked",-1,-1);
               }
               else
               {
                  remoteM.socketM.lobby_chatToAll(_loc1_,this._channelPlayerID);
                  this.txtChatInput.text = "";
                  this._lastChatInputLength = 0;
                  dataM.chat_sendMessageCooldown = this.SEND_MESSAGE_COOLDOWN_FRAMES;
                  this.txtChatInput.alpha = 0.3;
                  this.btnSendMessage.disableMe();
               }
            }
         }
      }
      
      public function refreshChatHistory() : void
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:BMChatMessageData = null;
         var _loc6_:Number = NaN;
         var _loc1_:Number = this.txtChatHistory.scrollV;
         this.txtChatHistory.htmlText = "";
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
         }
         var _loc2_:Boolean = false;
         if(dataM.chat_log[this._channelPlayerID] != null)
         {
            _loc3_ = dataM.chat_log[this._channelPlayerID];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc3_[_loc4_];
               _loc6_ = _loc5_.fromPlayerID;
               switch(_loc5_.type)
               {
                  case "privateMessageAlert":
                  case "clanMessageAlert":
                  case "battleInvitation":
                  case "clanInvitation":
                     _loc6_ = _loc5_.specialPlayerID;
               }
               if(_loc4_ == _loc3_.length - 1)
               {
                  _loc2_ = true;
               }
               if(dataM.chat_playersData[_loc6_].blocked == false)
               {
                  this.addGlobalChatMessage(_loc5_.channelID,_loc5_.slot,_loc2_);
               }
               _loc4_++;
            }
         }
         if(dataM.runAsMobile)
         {
            this.txtChatHistory.scrollV = this.txtChatHistory.maxScrollV;
         }
         else if(_loc1_ < this.txtChatHistory.maxScrollV)
         {
            this.txtChatHistory.scrollV = _loc1_;
         }
         else
         {
            this.txtChatHistory.scrollV = this.txtChatHistory.maxScrollV;
         }
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
         }
         if(dataM.runAsMobile == false)
         {
            if(this.txtChatHistory.maxScrollV == 1)
            {
               this.scroller.disableMe();
            }
            else
            {
               this.scroller.enableMe();
            }
            this.scrollerScrolled(1);
         }
      }
      
      public function memberKickedFromClan(param1:Number) : void
      {
         if(dataM.chat_playersData[param1] != null)
         {
            dataM.chat_playersData[param1].clanID = 0;
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
               this.addPlayerToChatPlayersData(_loc10_,_loc4_.playerName,_loc4_.level,_loc4_.clanID,_loc4_.ladderProgress,_loc4_.geo,_loc4_.lastDevice);
               _loc3_[_loc10_] = true;
               _loc5_++;
            }
            _loc6_++;
         }
         for each(_loc4_ in dataM.chat_playersData)
         {
            if(_loc3_[_loc4_.playerID] == null)
            {
               dataM.chat_playersData[_loc4_.playerID].removed = true;
            }
         }
         _loc7_ = getSpecificText("multiplayerLadder_playersInLobby");
         _loc7_ = dataM.replaceStringInText(_loc7_,"%PLAYERS%",String(_loc6_));
         if(screensM.isScreenOpened("screenMultiPlayerLadder"))
         {
            this._lastTotalPlayersInLobby = _loc6_;
         }
         else
         {
            this.addAndRefreshOnlinePlayersTileList();
            this.txtPlayersInLobby.text = _loc7_;
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("menuMultiPlayerChat_txtPlayersInLobby",[this.txtPlayersInLobby],"",this);
            }
         }
      }
      
      public function updateOnlinePlayerClanID(param1:Number, param2:Number) : void
      {
         if(dataM.chat_playersData != null)
         {
            if(dataM.chat_playersData[param1] != null)
            {
               dataM.chat_playersData[param1].clanID = param2;
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
         var _loc20_:Object = null;
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
               while(_loc5_ < _loc2_.clan_members.length)
               {
                  _loc20_ = _loc2_.clan_members[_loc5_];
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
            for each(_loc12_ in dataM.chat_playersData)
            {
               if(_loc12_.playerID > dataM.CHAT_LANGUAGES - 1 && _loc12_.removed == false)
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
               _loc12_ = dataM.chat_playersData[_loc14_[_loc5_]];
               if(_loc12_.playerID > dataM.CHAT_LANGUAGES - 1 && _loc12_.removed == false)
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
                     _loc24_ = "<FONT COLOR=\'#" + dataM.COLOR_SELF + "\'>" + _loc24_ + "</FONT>";
                  }
                  else if(dataM.isPlayerIDAdmin(_loc12_.playerID))
                  {
                     _loc24_ = "<FONT COLOR=\'#" + dataM.COLOR_ADMIN + "\'>" + _loc24_ + "</FONT>";
                  }
                  else if(_loc6_[_loc12_.playerID] != null)
                  {
                     _loc24_ = "<FONT COLOR=\'#" + dataM.COLOR_FRIEND + "\'>" + _loc24_ + "</FONT>";
                  }
                  if(_loc4_ % 2 == 0)
                  {
                     _loc23_.mcBackground.gotoAndStop("regular2");
                  }
                  _loc23_.txtName.htmlText = TextUtils.getTextFont() + _loc24_;
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
         this.tryToInspectPlayer(this._rollOverPlayerID);
      }
      
      private function tryToInspectPlayer(param1:Number) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc2_:Boolean = true;
         if(param1 >= dataM.CHAT_LANGUAGES && param1 != dataM.CHAT_CLAN_CHANNEL_PLAYER_ID)
         {
            if(dataM.chat_playersData[param1] != null)
            {
               if(param1 != dataM.userID)
               {
                  screensM.addScreen("screenMenuMultiPlayerInspect");
                  _loc3_ = false;
                  _loc4_ = Number(dataM.chat_playersData[param1].clanID);
                  if(dataM.clanInvitations[_loc4_] != null)
                  {
                     _loc3_ = true;
                  }
                  if(_loc3_)
                  {
                     screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,false,true,this._rollOverClanMessage);
                  }
                  else
                  {
                     _loc5_ = false;
                     if(dataM.battleInvitations[param1] != null)
                     {
                        _loc5_ = true;
                     }
                     if(_loc5_)
                     {
                        screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,true,false,this._rollOverClanMessage);
                     }
                     else
                     {
                        screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,false,false,this._rollOverClanMessage);
                     }
                  }
                  _loc2_ = false;
               }
            }
         }
         if(_loc2_)
         {
            if(screensM.isScreenOpened("screenMenuMultiPlayerInspect"))
            {
               screensM.removeScreen("screenMenuMultiPlayerInspect");
            }
         }
      }
      
      public function channelsListClicked() : void
      {
         var _loc1_:MovieClip = null;
         if(screensM.screenBlack.isActive() == false)
         {
            if(this.mcChannelsBackground.visible)
            {
               this.mcChannelsBackground.visible = false;
               this.channelsTileList.visible = false;
               _loc1_ = externalAssetsM.getAsset("general","interface_openDropList");
               this.btnChannelsList.replacePicture(_loc1_);
               if(dataM.runAsMobile)
               {
                  this._fingerWheeling_channels.removeMouseListeners();
               }
            }
            else
            {
               this.mcChannelsBackground.visible = true;
               this.channelsTileList.visible = true;
               _loc1_ = externalAssetsM.getAsset("general","interface_closeDropList");
               this.btnChannelsList.replacePicture(_loc1_);
               if(dataM.runAsMobile)
               {
                  this._fingerWheeling_channels.addMouseListeners();
               }
            }
         }
      }
      
      private function initializeChannelsTileList() : void
      {
         this.channelsTileList = new BMTileList();
         var _loc1_:Boolean = false;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.resetTileList(this.channelsTileList);
            _loc1_ = true;
         }
         var _loc2_:Number = 8;
         var _loc3_:Number = 1;
         var _loc4_:Number = 27.5;
         var _loc5_:Number = 260;
         if(dataM.runAsMobile)
         {
            _loc2_ = 7;
            _loc4_ = 30;
            _loc5_ = 283;
            this.channelsTileList.activateExtendedMode(0.3,true);
         }
         var _loc6_:MovieClip = new Grp_scrollerContent();
         var _loc7_:Array = new Array();
         this.channelsTileList.initialize(screensM.stagePointer.stage,_loc7_,_loc2_,_loc3_,_loc5_,_loc4_,null,true,_loc6_,null,null,true,0,0.5,true,_loc1_,dataM.runAsMobile);
         this.channelsTileList.x = this.mcChannelsBackground.x + 10;
         this.channelsTileList.y = this.mcChannelsBackground.y + 8;
         this.mcChannelsHolder.addChild(this.channelsTileList);
      }
      
      private function removeChannelsTileList() : void
      {
         if(this.channelsTileList != null)
         {
            this.channelsTileList.removeMe();
            this.channelsTileList = null;
         }
      }
      
      public function manuallyAddClanChannel() : void
      {
         var _loc1_:Number = NaN;
         if(this.channelsTileList != null)
         {
            _loc1_ = this.channelsTileList.findTileIDByTileListItemID(dataM.CHAT_CLAN_CHANNEL_PLAYER_ID);
            if(_loc1_ == -1)
            {
               this.addAndRefreshChannelsTileList();
            }
         }
      }
      
      public function addAndRefreshChannelsTileList() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerProfile = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:BMItem = null;
         var _loc8_:MovieClip = null;
         var _loc9_:String = null;
         var _loc10_:BMTileListItem = null;
         var _loc11_:Function = null;
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < dataM.chat_channels.length)
         {
            _loc3_ = true;
            if(dataM.chat_channels[_loc2_].channelID == dataM.CHAT_CLAN_CHANNEL_PLAYER_ID)
            {
               _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc4_.clanID == 0)
               {
                  _loc3_ = false;
               }
            }
            if(_loc3_)
            {
               _loc5_ = 27.5;
               _loc6_ = 260;
               if(dataM.runAsMobile)
               {
                  _loc5_ = 30;
                  _loc6_ = 283;
               }
               _loc7_ = new BMItem();
               if(dataM.runAsMobile)
               {
                  _loc8_ = new mcChatChannelListRow_mobile();
               }
               else
               {
                  _loc8_ = new mcChatChannelListRow();
               }
               if(_loc2_ % 2 == 0)
               {
                  _loc8_.mcBackground.gotoAndStop("regular2");
               }
               _loc9_ = dataM.chat_channels[_loc2_].name;
               switch(dataM.chat_channels[_loc2_].type)
               {
                  case "server":
                     _loc9_ = "<FONT COLOR=\'#" + dataM.COLOR_SERVER + "\'>" + _loc9_ + "</FONT>";
                     break;
                  case "admin":
                     _loc9_ = "<FONT COLOR=\'#" + dataM.COLOR_ADMIN + "\'>" + _loc9_ + "</FONT>";
                     break;
                  case "friend":
                     _loc9_ = "<FONT COLOR=\'#" + dataM.COLOR_FRIEND + "\'>" + _loc9_ + "</FONT>";
                     break;
                  case "clan":
                     _loc9_ = "<FONT COLOR=\'#" + dataM.COLOR_FRIEND + "\'>" + _loc9_ + "</FONT>";
                     break;
                  case "regular":
               }
               TextUtils.updateTextFormat(_loc8_.txtName,15);
               TextUtils.updateTextFormat(_loc8_.txtMessages,15);
               _loc8_.txtName.htmlText = TextUtils.getTextFont() + _loc9_;
               _loc8_.txtMessages.text = "";
               _loc7_.initialize(dataM.chat_channels[_loc2_].channelID,_loc6_,_loc5_,_loc8_,0,0,false,null,dataM.runAsMobile);
               _loc10_ = new BMTileListItem();
               _loc11_ = this.channelClicked;
               if(dataM.runAsMobile)
               {
                  _loc11_ = null;
               }
               _loc10_.initialize(_loc6_,_loc5_,_loc7_,"","","",0,_loc11_,null,null,null,null,dataM.runAsMobile);
               _loc1_.push(_loc10_);
            }
            _loc2_++;
         }
         this.channelsTileList.removeAllItems();
         this.channelsTileList.addItems(0,_loc1_,false);
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.tileListItemsModified();
         }
      }
      
      private function channelClicked(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerProfile = null;
         var _loc5_:String = null;
         if(screensM.screenBlack.isActive() == false)
         {
            _loc3_ = false;
            _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            switch(param2)
            {
               case 3:
               case 4:
               case 5:
                  if(dataM.getLadderRankByProgress(_loc4_.ladderProgress) > 3)
                  {
                     _loc3_ = true;
                  }
            }
            _loc5_ = this._onlinePlayersTab;
            switch(param2)
            {
               case dataM.CHAT_CLAN_CHANNEL_PLAYER_ID:
                  this._onlinePlayersTab = "clan";
                  dataM.chat_pendingClanMessages = 0;
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
      }
      
      public function chatPlayerClicked(param1:Number, param2:Boolean, param3:Boolean = false) : void
      {
         if(param3 || screensM.screenBlack.isActive() == false)
         {
            if(param2)
            {
               this.channelClickedSub(dataM.CHAT_CLAN_CHANNEL_PLAYER_ID);
            }
            else
            {
               dataM.chat_addChannel(param1,dataM.chat_playersData[param1].playerName);
               this.addAndRefreshChannelsTileList();
               this.channelClickedSub(param1);
            }
         }
      }
      
      public function channelClickedSub(param1:Number) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:BMTileListItem = null;
         if(param1 > -1)
         {
            if(this._channelPlayerID != param1)
            {
               this._channelPlayerID = param1;
               this.refreshCurrentChannelText();
               stage.focus = this.txtChatInput;
            }
            dataM.chat_lastChatChannel = this._channelPlayerID;
            this.closeChannelsTileList();
            this.refreshChatHistory();
            _loc2_ = externalAssetsM.getAsset("general","interface_openDropList");
            this.btnChannelsList.replacePicture(_loc2_);
            _loc3_ = this.channelsTileList.findTileListItemByTileListItemID(this._channelPlayerID);
            if(_loc3_ != null)
            {
               _loc3_.item.itemGrp.txtMessages.text = "";
            }
         }
      }
      
      private function closeChannelsTileList() : void
      {
         this.mcChannelsBackground.visible = false;
         this.channelsTileList.visible = false;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_channels.removeMouseListeners();
         }
      }
      
      private function refreshCurrentChannelText() : void
      {
         var _loc1_:String = null;
         switch(this._channelPlayerID)
         {
            case 0:
               _loc1_ = getScreenText("globalChannel");
               break;
            case 1:
               _loc1_ = "German";
               break;
            case 2:
               _loc1_ = "Spanish";
               break;
            case 3:
               _loc1_ = "English - Top Ranks";
               break;
            case 4:
               _loc1_ = "German - Top Ranks";
               break;
            case 5:
               _loc1_ = "Spanish - Top Ranks";
               break;
            case dataM.CHAT_CLAN_CHANNEL_PLAYER_ID:
               _loc1_ = "<FONT COLOR=\'#" + dataM.COLOR_FRIEND + "\'>Clan</FONT>";
               break;
            default:
               _loc1_ = dataM.chat_playersData[this._channelPlayerID].playerName;
         }
         var _loc2_:String = getScreenText("currentChannel");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%CHANNEL%",_loc1_);
         this.txtCurrentChannel.htmlText = TextUtils.getTextFont() + _loc2_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("menuMultiPlayerChat_txtCurrentChannel",[this.txtCurrentChannel],"",this);
         }
      }
      
      private function mouseHitAreaClicked(param1:MouseEvent) : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            this.tryToInspectPlayer(this._rollOverPlayerID);
         }
      }
      
      private function mouseHitAreaMouseOver(param1:MouseEvent) : void
      {
         this._mouseOverHistory = true;
      }
      
      private function mouseHitAreaMouseOut(param1:MouseEvent) : void
      {
         this._mouseOverHistory = false;
         this.mcTextMarker.visible = false;
         this._rollOverPlayerID = 0;
         this._rollOverClanMessage = false;
      }
      
      public function chatHistoryMouseOverHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:BMChatMessageData = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this._mouseOverHistory || dataM.runAsMobile)
         {
            if(dataM.chat_log[this._channelPlayerID] != null)
            {
               _loc1_ = Math.floor((mouseY - this.mcChatMouseHitArea.y) / this.ROW_HEIGHT) + this.txtChatHistory.scrollV;
               _loc2_ = 0;
               _loc3_ = dataM.chat_log[this._channelPlayerID];
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc5_ = _loc3_[_loc4_];
                  _loc6_ = _loc5_.fromPlayerID;
                  switch(_loc5_.type)
                  {
                     case "privateMessageAlert":
                     case "clanMessageAlert":
                     case "battleInvitation":
                     case "clanInvitation":
                        _loc6_ = _loc5_.specialPlayerID;
                  }
                  if(dataM.chat_playersData[_loc6_].blocked == false)
                  {
                     _loc2_ += _loc5_.rowsInLog;
                     if(_loc2_ >= _loc1_)
                     {
                        this._rollOverPlayerID = _loc6_;
                        this._rollOverClanMessage = false;
                        if(_loc5_.toPlayerID == dataM.CHAT_CLAN_CHANNEL_PLAYER_ID)
                        {
                           this._rollOverClanMessage = true;
                        }
                        if(dataM.runAsMobile == false)
                        {
                           if(_loc5_.rowsInLog > 1)
                           {
                              this.mcTextMarker.y = this.mcChatMouseHitArea.y + (_loc2_ - this.txtChatHistory.scrollV - _loc5_.rowsInLog + 1) * (this.ROW_HEIGHT - 0.2);
                           }
                           else
                           {
                              this.mcTextMarker.y = this.mcChatMouseHitArea.y + (_loc2_ - this.txtChatHistory.scrollV) * (this.ROW_HEIGHT - 0.2);
                           }
                           this.mcTextMarker.height = _loc5_.rowsInLog * this.ROW_HEIGHT;
                           _loc7_ = 0;
                           if(this.mcTextMarker.y < this.mcChatMouseHitArea.y)
                           {
                              _loc7_ = this.mcChatMouseHitArea.y - this.mcTextMarker.y;
                              this.mcTextMarker.height -= _loc7_;
                              this.mcTextMarker.y += _loc7_;
                           }
                           if(this.mcTextMarker.y + this.mcTextMarker.height > this.mcChatMouseHitArea.y + this.mcChatMouseHitArea.height)
                           {
                              _loc7_ = this.mcTextMarker.y + this.mcTextMarker.height - (this.mcChatMouseHitArea.y + this.mcChatMouseHitArea.height);
                              this.mcTextMarker.height -= _loc7_;
                           }
                           this.mcTextMarker.visible = true;
                        }
                        _loc4_ = _loc3_.length;
                     }
                     else
                     {
                        this._rollOverPlayerID = 0;
                        this.mcTextMarker.visible = false;
                     }
                  }
                  _loc4_++;
               }
               this._lastTargetRow = _loc1_;
            }
            else
            {
               this._lastTargetRow = 0;
            }
         }
      }
      
      private function scrollerScrolled(param1:Number) : void
      {
         var _loc2_:Number = this.txtChatHistory.scrollV;
         this.txtChatHistory.scrollV = Math.ceil(param1 * this.txtChatHistory.maxScrollV);
         if(dataM.runAsMobile)
         {
            if(_loc2_ != this.txtChatHistory.scrollV)
            {
               screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
            }
         }
      }
      
      private function scrollingEnded() : void
      {
      }
      
      private function scrollerButtonUp() : void
      {
         if(this.txtChatHistory.scrollV > 1)
         {
            --this.txtChatHistory.scrollV;
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
            }
            this.scroller.setScrollPosition((this.txtChatHistory.scrollV - 1) / (this.txtChatHistory.maxScrollV - 1));
         }
      }
      
      private function scrollerButtonDown() : void
      {
         if(this.txtChatHistory.scrollV < this.txtChatHistory.maxScrollV)
         {
            ++this.txtChatHistory.scrollV;
            if(dataM.runAsMobile)
            {
               screensM.createTextBitmap("txtChatHistory",this.txtChatHistory," ",this.mcTextBitmapHolder);
            }
            this.scroller.setScrollPosition((this.txtChatHistory.scrollV - 1) / (this.txtChatHistory.maxScrollV - 1));
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
      
      private function sendMessageMouseOver() : void
      {
      }
      
      private function searchForPlayerMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("searchForPlayer"));
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      private function keyboardOutput(param1:Object) : void
      {
         if(param1.enter)
         {
            this.sendChatMessage();
         }
      }
      
      public function clanInvitationCancelled(param1:Number) : void
      {
         var _loc2_:Object = dataM.clanInvitations[param1];
         if(screensM.isScreenOpened("screenMenuMultiPlayerInspect") && dataM.onlinePlayersInspect_playerID == _loc2_.leaderID)
         {
            screensM.screenMenuMultiPlayerInspect.refreshScreen(_loc2_.leaderID,false,false,false);
         }
      }
      
      public function findBattleSuccess() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.screenBlack.activateBlackScreen(this.findBattleSuccessSub,true,true,null,0);
         }
         else
         {
            this.findBattleSuccessSub();
         }
      }
      
      private function findBattleSuccessSub() : void
      {
         screensM.addBattleScreens();
         screensM.removeScreen("screenConfirmation");
         this.removeChannelsTileList();
         this.removeOnlinePlayersTileList();
         if(this.acceptingBattleInvitation)
         {
            dataM.battle_inBattleInvitation = true;
            screensM.removeScreen("screenConfirmation");
            this.acceptingBattleInvitation = false;
         }
         screensM.screenNewMenu.removeCurrentScreen();
         screensM.screenNewMenu.removeMe();
      }
      
      public function battleInvitationCancelled(param1:Number) : void
      {
         this.acceptingBattleInvitation = false;
         if(screensM.isScreenOpened("screenMenuMultiPlayerInspect") && dataM.onlinePlayersInspect_playerID == param1)
         {
            screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,false,false,false);
         }
      }
      
      public function battleInvitationDeclined(param1:Number) : void
      {
         screensM.screenMultiPlayerChat.acceptingBattleInvitation = false;
         if(screensM.isScreenOpened("screenMenuMultiPlayerInspect") && dataM.onlinePlayersInspect_playerID == param1)
         {
            screensM.screenMenuMultiPlayerInspect.refreshScreen(param1,false,false,false);
         }
      }
      
      public function playerLeftChat() : void
      {
         if(dataM.chat_playersData[dataM.onlinePlayersInspect_playerID] != null)
         {
            dataM.chat_playersData[dataM.onlinePlayersInspect_playerID].removed = true;
            this.onlinePlayersTileList.removeItems([dataM.onlinePlayersInspect_playerID],"tileListItemID");
         }
      }
      
      public function battleInvitationsEnabledClicked() : void
      {
         dataM.battleInvitationsEnabled = false;
         this.refreshBattleInvitationsEnableDisableButtons();
         tooltip.hideToolTip();
      }
      
      public function battleInvitationsDisabledClicked() : void
      {
         dataM.battleInvitationsEnabled = true;
         this.refreshBattleInvitationsEnableDisableButtons();
         tooltip.hideToolTip();
      }
      
      private function refreshBattleInvitationsEnableDisableButtons() : void
      {
         this.btnBattleInvitationsEnabled.visible = false;
         this.btnBattleInvitationsDisabled.visible = false;
         if(dataM.battleInvitationsEnabled)
         {
            this.btnBattleInvitationsEnabled.visible = true;
            this.txtBattleInvitationsStatus.htmlText = TextUtils.getTextFont() + getScreenText("battleInvitationsEnabled");
         }
         else
         {
            this.btnBattleInvitationsDisabled.visible = true;
            this.txtBattleInvitationsStatus.htmlText = TextUtils.getTextFont() + getScreenText("battleInvitationsDisabled");
         }
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
         screensM.screenNewMenu.multiplayerLadderClicked();
      }
      
      public function searchForPlayerClicked() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            screensM.addScreen("screenSearchForPlayer");
            screensM.screenSearchForPlayer.refreshScreen();
            if(screensM.isScreenOpened("screenMenuMultiPlayerInspect"))
            {
               screensM.screenMenuMultiPlayerInspect.closeClicked();
            }
            if(this.mcChannelsBackground.visible)
            {
               this.channelsListClicked();
            }
         }
      }
      
      public function sendMessageClicked() : void
      {
         this.sendChatMessage();
      }
      
      public function removeMe() : void
      {
         keyboardM.removeKeyboardOutputFunction("menuMultiplayer removeMe");
         screensM.removeScreen("screenMultiPlayerChat");
         screensM.removeScreen("screenMenuMultiPlayerInspect");
         if(screensM.isScreenOpened("screenSelectBattleMechsPerPlayer"))
         {
            screensM.screenSelectBattleMechsPerPlayer.removeMe();
         }
         if(screensM.isScreenOpened("screenSearchForPlayer"))
         {
            screensM.screenSearchForPlayer.backClicked();
         }
         this.removeChannelsTileList();
         this.removeOnlinePlayersTileList();
         tooltip.hideToolTip();
         this.mcSandClock.gotoAndStop("animOff");
         if(dataM.runAsMobile)
         {
            this._fingerWheeling_onlinePlayers.removeMouseListeners();
            this._fingerWheeling_channels.removeMouseListeners();
         }
      }
      
      private function disableAllButtons(param1:Boolean) : void
      {
         if(param1)
         {
            this.btnSendMessage.disableMe();
            this.btnChannelsList.disableMe();
            this.btnSearchForPlayer.disableMe();
         }
         screensM.screenTopBar.disableButtons();
      }
      
      private function enableAllButtons() : void
      {
         this.btnSendMessage.enableMe();
         this.btnChannelsList.enableMe();
         this.btnSearchForPlayer.enableMe();
         screensM.screenTopBar.enableButtons("screenMultiPlayerChat enableAllButtons");
      }
      
      private function createGiftKeyChars() : void
      {
         this.GIFT_KEY_CHARS["1"] = true;
         this.GIFT_KEY_CHARS["2"] = true;
         this.GIFT_KEY_CHARS["3"] = true;
         this.GIFT_KEY_CHARS["4"] = true;
         this.GIFT_KEY_CHARS["5"] = true;
         this.GIFT_KEY_CHARS["6"] = true;
         this.GIFT_KEY_CHARS["7"] = true;
         this.GIFT_KEY_CHARS["8"] = true;
         this.GIFT_KEY_CHARS["9"] = true;
         this.GIFT_KEY_CHARS["0"] = true;
         this.GIFT_KEY_CHARS["a"] = true;
         this.GIFT_KEY_CHARS["b"] = true;
         this.GIFT_KEY_CHARS["c"] = true;
         this.GIFT_KEY_CHARS["d"] = true;
         this.GIFT_KEY_CHARS["e"] = true;
         this.GIFT_KEY_CHARS["f"] = true;
         this.GIFT_KEY_CHARS["g"] = true;
         this.GIFT_KEY_CHARS["h"] = true;
         this.GIFT_KEY_CHARS["i"] = true;
         this.GIFT_KEY_CHARS["j"] = true;
         this.GIFT_KEY_CHARS["k"] = true;
         this.GIFT_KEY_CHARS["l"] = true;
         this.GIFT_KEY_CHARS["m"] = true;
         this.GIFT_KEY_CHARS["n"] = true;
         this.GIFT_KEY_CHARS["o"] = true;
         this.GIFT_KEY_CHARS["p"] = true;
         this.GIFT_KEY_CHARS["q"] = true;
         this.GIFT_KEY_CHARS["r"] = true;
         this.GIFT_KEY_CHARS["s"] = true;
         this.GIFT_KEY_CHARS["t"] = true;
         this.GIFT_KEY_CHARS["u"] = true;
         this.GIFT_KEY_CHARS["v"] = true;
         this.GIFT_KEY_CHARS["w"] = true;
         this.GIFT_KEY_CHARS["x"] = true;
         this.GIFT_KEY_CHARS["y"] = true;
         this.GIFT_KEY_CHARS["z"] = true;
         this.GIFT_KEY_CHARS["A"] = true;
         this.GIFT_KEY_CHARS["B"] = true;
         this.GIFT_KEY_CHARS["C"] = true;
         this.GIFT_KEY_CHARS["D"] = true;
         this.GIFT_KEY_CHARS["E"] = true;
         this.GIFT_KEY_CHARS["F"] = true;
         this.GIFT_KEY_CHARS["G"] = true;
         this.GIFT_KEY_CHARS["H"] = true;
         this.GIFT_KEY_CHARS["I"] = true;
         this.GIFT_KEY_CHARS["J"] = true;
         this.GIFT_KEY_CHARS["K"] = true;
         this.GIFT_KEY_CHARS["L"] = true;
         this.GIFT_KEY_CHARS["M"] = true;
         this.GIFT_KEY_CHARS["N"] = true;
         this.GIFT_KEY_CHARS["O"] = true;
         this.GIFT_KEY_CHARS["P"] = true;
         this.GIFT_KEY_CHARS["Q"] = true;
         this.GIFT_KEY_CHARS["R"] = true;
         this.GIFT_KEY_CHARS["S"] = true;
         this.GIFT_KEY_CHARS["T"] = true;
         this.GIFT_KEY_CHARS["U"] = true;
         this.GIFT_KEY_CHARS["V"] = true;
         this.GIFT_KEY_CHARS["W"] = true;
         this.GIFT_KEY_CHARS["X"] = true;
         this.GIFT_KEY_CHARS["Y"] = true;
         this.GIFT_KEY_CHARS["Z"] = true;
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.multiplayerLadderClicked();
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen(true);
      }
   }
}

