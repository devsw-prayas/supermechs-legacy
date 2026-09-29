package net.battleMechsMulti.managers.chat
{
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMChatMessageData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.chat.BMMiniChat;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.missionDifficulty.BMScreenMissionDifficulty;
   
   public class BMChatData extends BMBaseClass
   {
      
      public static const MSG_TYPE_PRIVATE_MESSAGE_ALERT:String = "privateMessageAlert";
      
      public static const MSG_TYPE_CLAN_MESSAGE_ALERT:String = "clanMessageAlert";
      
      public static const MSG_TYPE_BATTLE_INVITATION:String = "battleInvitation";
      
      public static const MSG_TYPE_CLAN_INVITATION:String = "clanInvitation";
      
      public static const MSG_TYPE_WINNING_WALL:String = "winningWall";
      
      public static const MSG_TYPE_REGULAR:String = "message";
      
      public static const MSG_ANNOUNCEMENT_PREFIX:String = "<Announce ";
      
      public var initialized:Boolean = false;
      
      private var _currentChannelPlayerID:Number = 0;
      
      public var messages_winningWall:Array = new Array();
      
      public var lastChatChannel:uint = 0;
      
      public var gotRecentClanMessagesThisLogin:Boolean = false;
      
      public var channels:Array = new Array();
      
      public var channelsServer:Array = new Array();
      
      public var channelsAdmins:Array = new Array();
      
      public var channelsClan:Array = new Array();
      
      public var channelsClanMembers:Array = new Array();
      
      public var channelsRegular:Array = new Array();
      
      public var log:Object = new Object();
      
      public var winningWallTexts:Array = new Array();
      
      public var differentUserConnected:Boolean = true;
      
      public var playersData:Object = new Object();
      
      public var totalPlayersInLobby:uint = 0;
      
      public var goToClanChat:Boolean = false;
      
      public var goToSpecificPlayerChatPlayerID:Number = 0;
      
      public var goToInspectPlayerID:Number = 0;
      
      public var goToChatAfterBattleUserID:Number = 0;
      
      public var inviteToClanAfterBattleUserID:Number = 0;
      
      public var addPlayerDataAfterBattleName:String;
      
      public var addPlayerDataAfterBattleClanID:Number;
      
      public var addPlayerDataAfterBattleLevel:uint;
      
      public var addPlayerDataAfterBattleGeo:String;
      
      public var addPlayerDataAfterBattleLadderProgress:uint;
      
      public var sendMessageCooldown:uint = 0;
      
      public var useChatBlocks:Boolean = false;
      
      public var chatBlocksRemain:Number = 6;
      
      public var chatBlocksPlayerIDs:Object = new Object();
      
      public var amIBannedFromChat:Boolean = false;
      
      public var useChatRank1Channels:Boolean = false;
      
      public var chatDefaultLanguageID:Number = 0;
      
      public var battleInvitations:Object = new Object();
      
      public var clanInvitations:Object = new Object();
      
      public var battleInvitationsEnabled:Boolean = true;
      
      public var blockedBattleInvitations:Object = new Object();
      
      public var isInChatChannel:Boolean = false;
      
      private var _campaignChatBlocked:Boolean = false;
      
      public const CHAT_LANGUAGES:uint = 6;
      
      public const CHAT_CLAN_CHANNEL_PLAYER_ID:uint = 10;
      
      public const CHAT_GLOBAL_CHANNEL_ID:uint = 1;
      
      public const CHAT_ONLINE_PLAYER_LADDER_PROGRESS_DIFFERENCE:uint = 10;
      
      public const COLOR_FRIEND:String = "33CC00";
      
      public const COLOR_REGULAR_PLAYER:String = "FF9900";
      
      public const COLOR_SELF:String = "0099FF";
      
      public const COLOR_TIP:String = "FFCC66";
      
      public const COLOR_ADMIN:String = "993399";
      
      public const COLOR_SERVER:String = "FFCC00";
      
      public const COLOR_PRIVATE_MESSAGE:String = "FF6699";
      
      public const COLOR_CLAN_MESSAGE:String = "669966";
      
      public const COLOR_TEXT:String = "DDDDDD";
      
      public const COLOR_BATTLE_INVITATION:String = "FFCC00";
      
      public function BMChatData()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function initialize() : void
      {
         if(this.initialized)
         {
            return;
         }
         this.playersData = new Object();
         this.channels = new Array();
         this.channelsServer = new Array();
         this.channelsAdmins = new Array();
         this.channelsClan = new Array();
         this.channelsClanMembers = new Array();
         this.channelsRegular = new Array();
         this.addChannel(0,getSpecificText("multiplayerChat_channel1"));
         this.addChannel(3,getSpecificText("multiplayerChat_channel1TopRanks"));
         this.addChannel(1,getSpecificText("multiplayerChat_channel2"));
         this.addChannel(4,getSpecificText("multiplayerChat_channel2TopRanks"));
         this.addChannel(2,getSpecificText("multiplayerChat_channel3"));
         this.addChannel(5,getSpecificText("multiplayerChat_channel3TopRanks"));
         this.addChannel(this.CHAT_CLAN_CHANNEL_PLAYER_ID,getSpecificText("multiplayerChat_channelClan"));
         this.addMessage_welcome(0,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome1"));
         this.addMessage_welcome(1,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome2"));
         this.addMessage_welcome(2,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome3"));
         this.addMessage_welcome(3,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome1"));
         this.addMessage_welcome(4,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome2"));
         this.addMessage_welcome(5,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome3"));
         this.addMessage_welcome(this.CHAT_CLAN_CHANNEL_PLAYER_ID,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcomeClan"));
         this.totalPlayersInLobby = 0;
         this.winningWallTexts = new Array();
         this.playersData = new Object();
         this.differentUserConnected = true;
         this.goToChatAfterBattleUserID = 0;
         this.inviteToClanAfterBattleUserID = 0;
         this.log = new Object();
         this.gotRecentClanMessagesThisLogin = false;
         this.currentChannelPlayerID = 0;
         this.lastChatChannel = 0;
         this.initialized = true;
      }
      
      public function channelsLanguageUpdate() : void
      {
         this.channels[this.getChannelSlot(0)].name = getSpecificText("multiplayerChat_channel1");
         this.channels[this.getChannelSlot(3)].name = getSpecificText("multiplayerChat_channel1TopRanks");
         this.channels[this.getChannelSlot(1)].name = getSpecificText("multiplayerChat_channel2");
         this.channels[this.getChannelSlot(4)].name = getSpecificText("multiplayerChat_channel2TopRanks");
         this.channels[this.getChannelSlot(2)].name = getSpecificText("multiplayerChat_channel3");
         this.channels[this.getChannelSlot(5)].name = getSpecificText("multiplayerChat_channel3TopRanks");
         this.channels[this.getChannelSlot(this.CHAT_CLAN_CHANNEL_PLAYER_ID)].name = getSpecificText("multiplayerChat_channel3TopRanks");
         this.playersData[0].playerName = getSpecificText("multiplayerChat_channel1");
         this.playersData[3].playerName = getSpecificText("multiplayerChat_channel1TopRanks");
         this.playersData[1].playerName = getSpecificText("multiplayerChat_channel2");
         this.playersData[4].playerName = getSpecificText("multiplayerChat_channel2TopRanks");
         this.playersData[2].playerName = getSpecificText("multiplayerChat_channel3");
         this.playersData[5].playerName = getSpecificText("multiplayerChat_channel3TopRanks");
         this.playersData[this.CHAT_CLAN_CHANNEL_PLAYER_ID].playerName = getSpecificText("multiplayerChat_channel3TopRanks");
      }
      
      public function addChannel(param1:Number, param2:String) : void
      {
         var _loc3_:uint = 0;
         if(this.getChannelSlot(param1) != -1)
         {
            return;
         }
         if(this.getChannelSlot(param1) == -1)
         {
            if(param1 <= this.CHAT_LANGUAGES - 1)
            {
               this.channelsServer.push({
                  "channelID":param1,
                  "name":param2
               });
            }
            else if(param1 == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
            {
               this.channelsClan.push({
                  "channelID":param1,
                  "name":param2
               });
            }
            else if(dataM.isPlayerIDAdmin(param1))
            {
               this.channelsAdmins.push({
                  "channelID":param1,
                  "name":param2
               });
            }
            else if(dataM.isMyClanMember(param1))
            {
               this.channelsClanMembers.push({
                  "channelID":param1,
                  "name":param2
               });
            }
            else
            {
               this.channelsRegular.push({
                  "channelID":param1,
                  "name":param2
               });
            }
         }
         this.channels = new Array();
         _loc3_ = 0;
         while(_loc3_ < this.channelsClan.length)
         {
            this.channels.push({
               "channelID":this.channelsClan[_loc3_].channelID,
               "name":this.channelsClan[_loc3_].name,
               "type":"clan"
            });
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.channelsServer.length)
         {
            this.channels.push({
               "channelID":this.channelsServer[_loc3_].channelID,
               "name":this.channelsServer[_loc3_].name,
               "type":"server"
            });
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.channelsAdmins.length)
         {
            this.channels.push({
               "channelID":this.channelsAdmins[_loc3_].channelID,
               "name":this.channelsAdmins[_loc3_].name,
               "type":"admin"
            });
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.channelsClanMembers.length)
         {
            this.channels.push({
               "channelID":this.channelsClanMembers[_loc3_].channelID,
               "name":this.channelsClanMembers[_loc3_].name,
               "type":"friend"
            });
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.channelsRegular.length)
         {
            this.channels.push({
               "channelID":this.channelsRegular[_loc3_].channelID,
               "name":this.channelsRegular[_loc3_].name,
               "type":"regular"
            });
            _loc3_++;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
         {
            screensM.screenMultiPlayerChat.channelsList.addAndRefreshChannelsTileList();
         }
      }
      
      public function getChannelSlot(param1:Number) : Number
      {
         var _loc2_:Number = -1;
         var _loc3_:uint = 0;
         while(_loc3_ < this.channels.length)
         {
            if(this.channels[_loc3_].channelID == param1)
            {
               _loc2_ = _loc3_;
               _loc3_ = this.channels.length;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function addMessage_welcome(param1:uint, param2:String, param3:String) : void
      {
         this.addMessage(MSG_TYPE_REGULAR,param1,param1,param3,param2,0,0,"",0,0,"",null,0,0,true);
      }
      
      private function addMessage_battleInvitation(param1:String, param2:uint, param3:String, param4:Number, param5:uint) : void
      {
         this.addMessage(MSG_TYPE_BATTLE_INVITATION,0,dataM.userID,param3,param1,param2,0,"",0,0,"",null,param4,param5,true);
      }
      
      private function addMessage_clanInvitation(param1:Number, param2:String, param3:Number, param4:String, param5:String) : void
      {
         this.addMessage(MSG_TYPE_CLAN_INVITATION,0,dataM.userID,param5,param4,0,0,"",0,param1,param2,null,param3,0,true);
      }
      
      public function addMessage(param1:String, param2:Number, param3:Number, param4:String, param5:String = "", param6:uint = 0, param7:uint = 0, param8:String = "", param9:uint = 0, param10:Number = 0, param11:String = "", param12:Object = null, param13:Number = 0, param14:uint = 0, param15:Boolean = false) : void
      {
         var _loc20_:uint = 0;
         var _loc21_:String = null;
         var _loc22_:BMPlayerProfile = null;
         var _loc23_:Boolean = false;
         var _loc24_:Boolean = false;
         var _loc25_:uint = 0;
         var _loc26_:Boolean = false;
         var _loc27_:BMMiniChat = null;
         var _loc28_:Boolean = false;
         var _loc29_:uint = 0;
         var _loc30_:BMChatMessageData = null;
         var _loc31_:* = undefined;
         var _loc32_:String = null;
         var _loc33_:String = null;
         var _loc34_:String = null;
         var _loc16_:Number = param2;
         var _loc17_:Boolean = param2 == dataM.userID;
         var _loc18_:Boolean = param3 == dataM.userID;
         switch(param1)
         {
            case MSG_TYPE_PRIVATE_MESSAGE_ALERT:
            case MSG_TYPE_CLAN_MESSAGE_ALERT:
            case MSG_TYPE_BATTLE_INVITATION:
            case MSG_TYPE_CLAN_INVITATION:
               _loc16_ = param13;
         }
         if(_loc16_ != dataM.userID)
         {
            param5 = dataM.getCensoredString(param5);
            param4 = dataM.getCensoredString(param4);
         }
         var _loc19_:BMChatMessageData = new BMChatMessageData();
         switch(param1)
         {
            case MSG_TYPE_WINNING_WALL:
               _loc20_ = this.messages_winningWall.length;
               _loc21_ = getSpecificText("multiplayerChat_winningWallMessage");
               param12.winUsername = dataM.getCensoredString(param12.winUsername);
               param12.loseUsername = dataM.getCensoredString(param12.loseUsername);
               _loc21_ = dataM.replaceStringInText(_loc21_,"%PLAYER1%","<FONT COLOR=\'#" + this.COLOR_REGULAR_PLAYER + "\'>" + param12.winUsername + "</FONT>");
               _loc21_ = dataM.replaceStringInText(_loc21_,"%PLAYER2%","<FONT COLOR=\'#" + this.COLOR_REGULAR_PLAYER + "\'>" + param12.loseUsername + "</FONT>");
               _loc19_.initializeWinningWall(_loc20_,_loc21_);
               this.messages_winningWall.push(_loc19_);
               if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER))
               {
                  screensM.screenMultiPlayerLadder.addWinningWallMessage(_loc21_);
               }
               break;
            case MSG_TYPE_BATTLE_INVITATION:
            case MSG_TYPE_CLAN_INVITATION:
            case MSG_TYPE_PRIVATE_MESSAGE_ALERT:
            case MSG_TYPE_CLAN_MESSAGE_ALERT:
            case MSG_TYPE_REGULAR:
               _loc22_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
               _loc23_ = false;
               _loc24_ = false;
               if(this.playersData[_loc16_] == null)
               {
                  this.addPlayerToChatPlayersData(_loc16_,param5,param6,param10,param7,param8,"");
                  _loc23_ = true;
               }
               else if(this.playersData[_loc16_].blocked)
               {
                  _loc24_ = true;
               }
               if(_loc24_)
               {
                  break;
               }
               switch(param1)
               {
                  case MSG_TYPE_BATTLE_INVITATION:
                  case MSG_TYPE_CLAN_INVITATION:
                     _loc25_ = 0;
                     if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT) || screensM.isScreenOpened(BMScreensManager.SCR_CAMPAIGN_CHAT))
                     {
                        _loc25_ = this.currentChannelPlayerID;
                     }
                     this.playersData[_loc16_].removed = false;
                     if(this.log[_loc25_] == null)
                     {
                        this.log[_loc25_] = new Array();
                     }
                     _loc20_ = uint(this.log[_loc25_].length);
                     switch(param1)
                     {
                        case MSG_TYPE_BATTLE_INVITATION:
                           _loc19_.initializeBattleInvitation(_loc20_,_loc25_,0,dataM.userID,param13,param4,param5,param6,param14);
                           break;
                        case MSG_TYPE_CLAN_INVITATION:
                           _loc19_.initializeClanInvitation(_loc20_,_loc25_,0,dataM.userID,param13,param4,param5,param10,param11);
                     }
                     break;
                  case MSG_TYPE_PRIVATE_MESSAGE_ALERT:
                  case MSG_TYPE_CLAN_MESSAGE_ALERT:
                  case MSG_TYPE_REGULAR:
                     if(this.playersData[_loc16_].clanID != param10)
                     {
                        this.playersData[_loc16_].clanID = param10;
                     }
                     this.playersData[_loc16_].removed = false;
                     if(param1 == MSG_TYPE_REGULAR)
                     {
                        _loc25_ = param3;
                        if(_loc18_)
                        {
                           _loc25_ = _loc16_;
                           this.addChannel(_loc25_,param5);
                           if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
                           {
                              screensM.screenMultiPlayerChat.channelsList.addAndRefreshChannelsTileList();
                           }
                        }
                     }
                     else
                     {
                        _loc25_ = 0;
                        if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
                        {
                           _loc25_ = this.currentChannelPlayerID;
                        }
                     }
                     if(this.log[_loc25_] == null)
                     {
                        this.log[_loc25_] = new Array();
                     }
                     _loc20_ = uint(this.log[_loc25_].length);
                     switch(param1)
                     {
                        case MSG_TYPE_PRIVATE_MESSAGE_ALERT:
                           _loc19_.initializePrivateMessageAlert(_loc20_,_loc25_,_loc16_,param3,param4,param5,param13);
                           break;
                        case MSG_TYPE_CLAN_MESSAGE_ALERT:
                           _loc19_.initializeClanMessageAlert(_loc20_,_loc25_,_loc16_,param3,param4,param5,param13);
                           break;
                        case MSG_TYPE_REGULAR:
                           _loc19_.initializeMessage(_loc20_,_loc25_,_loc16_,param3,param4,param5,param6,param7,param9,param10,param11);
                     }
               }
               this.log[_loc25_].push(_loc19_);
               _loc26_ = false;
               if(this.log[_loc25_].length > 35)
               {
                  this.log[_loc25_].splice(0,10);
                  _loc29_ = 0;
                  while(_loc29_ < this.log[_loc25_].length)
                  {
                     _loc30_ = this.log[_loc25_][_loc29_];
                     _loc30_.slot = _loc29_;
                     _loc29_++;
                  }
                  _loc20_ -= 10;
                  _loc26_ = true;
               }
               if(this.isMessageAnnouncement(_loc19_))
               {
                  param15 = false;
               }
               _loc27_ = this.getOpenedMiniChat();
               if(_loc27_ != null && this.campaignChatBlocked == false && _loc25_ == this.currentChannelPlayerID)
               {
                  _loc27_.addGlobalChatMessage(_loc25_,_loc20_);
               }
               _loc28_ = this.getOpenedChatContainerScreen() != null;
               if(_loc28_)
               {
                  switch(_loc19_.type)
                  {
                     case MSG_TYPE_BATTLE_INVITATION:
                     case MSG_TYPE_CLAN_INVITATION:
                        soundM.createSound("battleInvitationReceived",1);
                  }
                  _loc31_ = this.getOpenedChatContainerScreen();
                  if(_loc31_ != null && _loc25_ == this.currentChannelPlayerID)
                  {
                     if(_loc26_)
                     {
                        _loc31_.chatInterface.refreshChatHistory();
                     }
                     else
                     {
                        _loc31_.chatInterface.addGlobalChatMessage(_loc25_,_loc20_,true);
                     }
                  }
                  else if(param15)
                  {
                     switch(_loc19_.type)
                     {
                        case MSG_TYPE_BATTLE_INVITATION:
                        case MSG_TYPE_CLAN_INVITATION:
                        case MSG_TYPE_REGULAR:
                           if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
                           {
                              screensM.screenMultiPlayerChat.channelsList.incraseChannelPendingMessages(_loc25_);
                           }
                           if(_loc18_ || param3 == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
                           {
                              if(param3 == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
                              {
                                 _loc32_ = getSpecificText("multiplayerChat_clanMessageReceived");
                                 _loc32_ = dataM.replaceStringInText(_loc32_,"%NAME%",param5);
                                 _loc33_ = MSG_TYPE_CLAN_MESSAGE_ALERT;
                              }
                              else
                              {
                                 _loc32_ = getSpecificText("multiplayerChat_privateMessageReceived");
                                 _loc32_ = dataM.replaceStringInText(_loc32_,"%NAME%",param5);
                                 _loc33_ = MSG_TYPE_PRIVATE_MESSAGE_ALERT;
                              }
                              this.addMessage(_loc33_,0,dataM.userID,_loc32_,getSpecificText("multiplayerChat_server"),0,0,"",0,0,"",null,param2,0,true);
                           }
                     }
                  }
               }
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER) && param15)
         {
            _loc34_ = "";
            switch(param1)
            {
               case MSG_TYPE_BATTLE_INVITATION:
                  _loc34_ = MSG_TYPE_BATTLE_INVITATION;
                  break;
               case MSG_TYPE_CLAN_INVITATION:
                  _loc34_ = MSG_TYPE_CLAN_INVITATION;
                  break;
               case MSG_TYPE_REGULAR:
                  if(param3 == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
                  {
                     _loc34_ = "message_clan";
                  }
                  else if(_loc18_)
                  {
                     _loc34_ = "message_regular";
                  }
            }
            if(_loc34_ != "")
            {
               screensM.screenMultiPlayerLadder.addChatAlert(_loc34_,_loc16_,param5,param10,param11,param14);
            }
         }
      }
      
      private function getOpenedChatContainerScreen() : BMBaseScreen
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
         {
            return screensM.screenMultiPlayerChat;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_CHAT))
         {
            return screensM.screenClanChat;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_CAMPAIGN_CHAT))
         {
            return screensM.screenCampaignChat;
         }
         return null;
      }
      
      private function getOpenedMiniChat() : BMMiniChat
      {
         if(this.useCampaignChat == false)
         {
            return null;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
         {
            return screensM.screenMissionWorldMap.miniChat;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
         {
            return screensM.screenMissionBaseMap.miniChat;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_BOTTOM))
         {
            return screensM.screenBattleInterfaceBottom.miniChat;
         }
         return null;
      }
      
      public function setMessageRowsInLog(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         this.log[param1][param2].rowsInLog[param4] = param3;
      }
      
      public function get useCampaignChat() : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         if(dataM.gameType != BMDataManager.GAME_TYPE_PVE && dataM.gameType != BMDataManager.GAME_TYPE_DEFAULT)
         {
            return false;
         }
         return int(dataM.getGeneralSetting("useCampaignChat",0)) == 1;
      }
      
      public function get campaignChatBlocked() : Boolean
      {
         return this._campaignChatBlocked;
      }
      
      public function set campaignChatBlocked(param1:Boolean) : void
      {
         this._campaignChatBlocked = param1;
         var _loc2_:BMMiniChat = this.getOpenedMiniChat();
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.refresh();
      }
      
      public function addPlayerToChatPlayersData(param1:Number, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String) : void
      {
         var _loc9_:BMPlayerProfile = null;
         var _loc8_:Boolean = true;
         if(this.playersData[param1] != null)
         {
            _loc8_ = false;
         }
         if(param1 == dataM.userID)
         {
            _loc9_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            param2 = _loc9_.playerName;
            if(_loc8_ == false)
            {
               this.playersData[param1].playerName = param2;
            }
         }
         if(_loc8_)
         {
            this.playersData[param1] = new Object();
            this.playersData[param1].playerID = param1;
            this.playersData[param1].playerName = param2;
            this.playersData[param1].geo = param6;
            this.playersData[param1].lastDevice = param7;
            this.playersData[param1].blocked = false;
         }
         this.playersData[param1].level = param3;
         this.playersData[param1].clanID = param4;
         this.playersData[param1].ladderProgress = param5;
         this.playersData[param1].removed = false;
      }
      
      public function updatePlayersOnline(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Number = NaN;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Object = new Object();
         var _loc5_:uint = 0;
         this.totalPlayersInLobby = 0;
         for each(_loc4_ in param1)
         {
            _loc6_ = false;
            if(_loc2_.clanID > 0)
            {
               if(_loc2_.clanID == _loc4_.clanID)
               {
                  _loc6_ = true;
               }
            }
            _loc7_ = false;
            if(_loc6_ == false)
            {
               if(_loc5_ <= 13)
               {
                  if(Math.abs(_loc2_.ladderProgress - _loc4_.ladderProgress) <= this.CHAT_ONLINE_PLAYER_LADDER_PROGRESS_DIFFERENCE)
                  {
                     _loc7_ = true;
                  }
               }
            }
            if(_loc6_ || _loc7_)
            {
               _loc8_ = Number(_loc4_.playerID);
               if(_loc8_ != dataM.userID)
               {
                  _loc4_.playerName = dataM.getCensoredString(_loc4_.playerName);
               }
               this.addPlayerToChatPlayersData(_loc8_,_loc4_.playerName,_loc4_.level,_loc4_.clanID,_loc4_.ladderProgress,_loc4_.geo,_loc4_.lastDevice);
            }
            ++this.totalPlayersInLobby;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
         {
            screensM.screenMultiPlayerChat.addAndRefreshOnlinePlayersTileList(true);
            screensM.screenMultiPlayerChat.refreshPlayersInLobbyText();
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER))
         {
            screensM.screenMultiPlayerLadder.refreshPlayersInLobbyText();
         }
      }
      
      public function updateOnlinePlayerClanID(param1:Number, param2:Number) : void
      {
         if(this.playersData != null)
         {
            if(this.playersData[param1] != null)
            {
               this.playersData[param1].clanID = param2;
            }
         }
      }
      
      public function isPlayerBlocked(param1:*) : Boolean
      {
         var _loc2_:Boolean = false;
         if(this.playersData[param1] != null)
         {
            if(this.playersData[param1].blocked)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function goToChatAfterBattle(param1:Number, param2:String, param3:Number, param4:uint, param5:uint, param6:String) : void
      {
         this.goToChatAfterBattleUserID = param1;
         this.addPlayerDataAfterBattleName = param2;
         this.addPlayerDataAfterBattleClanID = param3;
         this.addPlayerDataAfterBattleLadderProgress = param4;
         this.addPlayerDataAfterBattleLevel = param5;
         this.addPlayerDataAfterBattleGeo = param6;
      }
      
      public function inviteToClanAfterBattle(param1:Number, param2:String, param3:Number, param4:uint, param5:uint, param6:String) : void
      {
         this.inviteToClanAfterBattleUserID = param1;
         this.addPlayerDataAfterBattleName = param2;
         this.addPlayerDataAfterBattleClanID = param3;
         this.addPlayerDataAfterBattleLadderProgress = param4;
         this.addPlayerDataAfterBattleLevel = param5;
         this.addPlayerDataAfterBattleGeo = param6;
      }
      
      public function blockPlayer(param1:Number, param2:Boolean) : void
      {
         if(this.playersData[param1] != null)
         {
            this.playersData[param1].blocked = true;
            if(param2)
            {
               if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
               {
                  screensM.screenMultiPlayerChat.chatInterface.refreshChatHistory();
               }
            }
         }
      }
      
      public function unBlockPlayer(param1:Number, param2:Boolean) : void
      {
         if(this.playersData[param1] != null)
         {
            this.playersData[param1].blocked = false;
            if(param2)
            {
               if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_CHAT))
               {
                  screensM.screenMultiPlayerChat.chatInterface.refreshChatHistory();
               }
            }
         }
      }
      
      public function battleInvitation_add(param1:Number, param2:String, param3:Number, param4:Number, param5:uint) : void
      {
         var _loc6_:String = null;
         param2 = dataM.getCensoredString(param2);
         this.battleInvitations[param1] = {
            "playerID":param1,
            "playerName":param2,
            "level":param3,
            "clanID":param4,
            "mechsPerPlayer":param5
         };
         switch(param5)
         {
            case 1:
               _loc6_ = getSpecificText("multiplayerChat_battleInvitationReceived1V1");
               break;
            case 2:
               _loc6_ = getSpecificText("multiplayerChat_battleInvitationReceived2V2");
               break;
            case 3:
               _loc6_ = getSpecificText("multiplayerChat_battleInvitationReceived3V3");
         }
         _loc6_ = "<FONT COLOR=\'#" + this.COLOR_BATTLE_INVITATION + "\'>" + dataM.replaceStringInText(_loc6_,"%NAME%",param2) + "</FONT>";
         this.addMessage_battleInvitation(param2,param3,_loc6_,param1,param5);
      }
      
      public function battleInvitation_remove(param1:Number) : void
      {
         this.battleInvitations[param1] = null;
      }
      
      public function clan_addInvitation(param1:Number, param2:String, param3:Number, param4:String) : void
      {
         param2 = dataM.getCensoredString(param2);
         param4 = dataM.getCensoredString(param4);
         this.clanInvitations[param1] = {
            "clanID":param1,
            "clanName":param2,
            "leaderID":param3,
            "leaderName":param4
         };
         var _loc5_:String = getSpecificText("multiplayerChat_clanInvitationReceived");
         _loc5_ = dataM.replaceStringInText(_loc5_,"%LEADER%",param4);
         _loc5_ = dataM.replaceStringInText(_loc5_,"%CLAN%",param2);
         _loc5_ = "<FONT COLOR=\'#" + this.COLOR_BATTLE_INVITATION + "\'>" + _loc5_ + "</FONT>";
         if(screensM.isScreenOpened(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT) && dataM.onlinePlayersInspect_playerID == param3)
         {
            screensM.screenMenuMultiPlayerInspect.refreshScreen(param3,false,true,false);
         }
         this.addMessage_clanInvitation(param1,param2,param3,param4,_loc5_);
      }
      
      public function clan_removeInvitation(param1:Number) : void
      {
         this.clanInvitations[param1] = null;
      }
      
      public function clearChannelLog(param1:uint) : void
      {
         if(this.log[param1] != null)
         {
            this.log[param1] = new Array();
         }
      }
      
      public function clearClanChannelLog() : void
      {
         this.clearChannelLog(this.CHAT_CLAN_CHANNEL_PLAYER_ID);
      }
      
      private function clearEntireLog() : void
      {
         this.log = new Object();
         this.gotRecentClanMessagesThisLogin = false;
      }
      
      public function getCurrentChannelText() : String
      {
         var _loc1_:String = null;
         switch(this.currentChannelPlayerID)
         {
            case 0:
               _loc1_ = BMLanguageManager.getInstance().getText("multiplayerChat_globalChannel");
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
            case this.CHAT_CLAN_CHANNEL_PLAYER_ID:
               _loc1_ = "<FONT COLOR=\'#" + this.COLOR_FRIEND + "\'>Clan</FONT>";
               break;
            default:
               _loc1_ = this.playersData[this.currentChannelPlayerID].playerName;
         }
         var _loc2_:String = BMLanguageManager.getInstance().getText("multiplayerChat_currentChannel");
         return dataM.replaceStringInText(_loc2_,"%CHANNEL%",_loc1_);
      }
      
      public function enterChat(param1:uint = 0) : void
      {
         if(this.isInChatChannel)
         {
            return;
         }
         remoteM.socketM.chat_enter(this.CHAT_GLOBAL_CHANNEL_ID);
         this.currentChannelPlayerID = param1;
      }
      
      public function exitChat() : void
      {
         if(this.isInChatChannel == false)
         {
            return;
         }
         this.clearEntireLog();
         remoteM.socketM.chat_exit();
      }
      
      public function get currentChannelPlayerID() : uint
      {
         return this._currentChannelPlayerID;
      }
      
      public function set currentChannelPlayerID(param1:uint) : void
      {
         this._currentChannelPlayerID = param1;
      }
      
      private function isMessageAnnouncement(param1:BMChatMessageData) : Boolean
      {
         return param1.type == BMChatData.MSG_TYPE_REGULAR && param1.message.indexOf(MSG_ANNOUNCEMENT_PREFIX) == 0;
      }
      
      public function getMessageText(param1:BMChatMessageData) : *
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc2_:String = param1.message;
         if(this.isMessageAnnouncement(param1))
         {
            _loc3_ = _loc2_.substr(BMChatData.MSG_ANNOUNCEMENT_PREFIX.length,_loc2_.length - MSG_ANNOUNCEMENT_PREFIX.length - 1);
            _loc4_ = _loc3_.split(",");
            _loc5_ = _loc4_[0];
            _loc2_ = languageM.getText("chatAnnouncement_" + _loc5_);
            switch(_loc5_)
            {
               case "gotItem":
                  _loc6_ = _loc4_[1];
                  _loc7_ = int(_loc6_);
                  _loc8_ = dataM.itemsDB[_loc7_];
                  _loc9_ = "<FONT COLOR=\'#" + ItemRarityResolver.getItemTierColor(_loc8_.specialStatus) + "\'>" + _loc8_.fullName + "</FONT>";
                  _loc2_ = _loc2_.replace("%ITEM%",_loc9_);
                  break;
               case "clearedChapter":
                  _loc10_ = int(_loc4_[1]);
                  _loc11_ = int(_loc4_[2]);
                  _loc12_ = languageM.getText("missionWorldMap_chapter" + _loc10_.toString());
                  _loc13_ = BMScreenMissionDifficulty.getTextForMode(_loc11_);
                  _loc2_ = _loc2_.replace("%CHAPTER%",_loc12_);
                  _loc2_ = _loc2_.replace("%DIFFICULTY%",_loc13_);
            }
         }
         return _loc2_;
      }
      
      public function getMessageTextSeparator(param1:BMChatMessageData) : *
      {
         if(this.isMessageAnnouncement(param1))
         {
            return " ";
         }
         return " : ";
      }
   }
}

