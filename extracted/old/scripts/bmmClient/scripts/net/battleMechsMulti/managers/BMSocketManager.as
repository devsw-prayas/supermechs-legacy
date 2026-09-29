package net.battleMechsMulti.managers
{
   import flash.events.Event;
   import net.battleMechsMulti.data.ItemCache;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.session.BMDomainResolver;
   import net.battlegate.events.BGSocketEvent;
   import net.battlegate.sockets.BGSocket;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.managers.BMMSessionManager;
   import net.tacticsoft.utils.MiscUtils;
   
   public final dynamic class BMSocketManager extends BMBaseClass
   {
      
      private var bgSocket:BGSocket;
      
      private var battleCalls:Array;
      
      public var currentBattleCall:Number;
      
      private var _buyPackage_packageID:Number;
      
      public var sellingMultipleItems:Boolean = false;
      
      public var currentDomain:String;
      
      public var flashVars:BMMClientFlashVars;
      
      private var _fixingAddItemsForNewPlayer:Boolean = false;
      
      private var _lastMsgSent:Object;
      
      public function BMSocketManager()
      {
         super();
      }
      
      final public function bgSocketApp() : *
      {
         TsLogger.log("BMSocketManager :: bgSocketApp");
         generateSingletonClassesPointers("");
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      private function init(param1:Event = null) : void
      {
         this.createTrace("bgSocketApp >> added to stage");
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         if(this.bgSocket != null)
         {
            this.bgSocket.removeEventListener(BGSocketEvent.DATA_AVAILABLE,this.gotData);
            this.bgSocket.removeEventListener(BGSocketEvent.CONNECTED,this.onConnect);
            this.bgSocket.removeEventListener(BGSocketEvent.IO_ERROR,this.onIOError);
            this.bgSocket.removeEventListener(BGSocketEvent.SECURITY_ERROR,this.onSecurityError);
            this.bgSocket.addStatusFunction(null);
            this.bgSocket.close();
         }
         this.bgSocket = new BGSocket();
         this.bgSocket.addEventListener(BGSocketEvent.DATA_AVAILABLE,this.gotData);
         this.bgSocket.addEventListener(BGSocketEvent.CONNECTED,this.onConnect);
         this.bgSocket.addEventListener(BGSocketEvent.IO_ERROR,this.onIOError);
         this.bgSocket.addEventListener(BGSocketEvent.SECURITY_ERROR,this.onSecurityError);
         this.bgSocket.addStatusFunction(this.socketStatus);
         this.flashVars = new BMMClientFlashVars(stage);
         this.currentDomain = BMDomainResolver.getDomain();
         if(screensM.resourcesAreLoaded)
         {
            this.doSocketConnection();
         }
         else
         {
            screensM.addEventListener(BMScreensManager.CLIENT_READY,this.doSocketConnection);
         }
      }
      
      private function doSocketConnection(param1:Event = null) : void
      {
         if(param1 != null)
         {
            screensM.removeEventListener(BMScreensManager.CLIENT_READY,this.doSocketConnection);
         }
         var _loc2_:uint = Boolean(GlobalAccess.overridePort) && this.flashVars.port != 915 ? GlobalAccess.overridePort : uint(this.flashVars.port);
         this.bgSocket.connect(this.currentDomain,_loc2_);
      }
      
      private function socketStatus(param1:String) : void
      {
         var _loc2_:String = null;
         if(screensM.isScreenOpened("screenDebugger"))
         {
            screensM.screenDebugger.addTrace("SOCKET socketStatus: " + param1);
         }
         TsLogger.log("SOCKET socketStatus:" + param1);
         dataM.sessionManager.doDisconnect();
         if(param1 != BGSocket.DISCONNECTED_CLIENT)
         {
            BMLoginManager.gi().doDisconnectFlow();
            _loc2_ = this.bgSocket.lastObjectSent == null ? "" : JSON.stringify(this.bgSocket.lastObjectSent);
            dataM.trackError("BMSocket" + param1,_loc2_);
         }
      }
      
      private function onIOError(param1:BGSocketEvent) : void
      {
         TsLogger.log("SOCKET onIOError");
         if(screensM.isScreenOpened("screenDebugger"))
         {
            screensM.screenDebugger.addTrace("bgSocketApp :: onIOError()");
            screensM.screenDebugger.addTrace(MiscUtils.getTraceObject(this.bgSocket.lastError.toString()));
         }
         this.createTrace(MiscUtils.getTraceObject("bgSocketApp :: onIOError()"));
         this.createTrace(MiscUtils.getTraceObject(this.bgSocket.lastError.toString()));
         screensM.socketConnectionFailed();
         BMLoginManager.gi().doDisconnectFlow();
         dataM.trackError("BMSocketIOError",this.bgSocket.lastError.toString());
      }
      
      private function onSecurityError(param1:BGSocketEvent) : void
      {
         if(screensM.isScreenOpened("screenDebugger"))
         {
            screensM.screenDebugger.addTrace("bgSocketApp :: onSecurityError()");
            screensM.screenDebugger.addTrace(MiscUtils.getTraceObject(this.bgSocket.lastError.toString()));
         }
         this.createTrace(MiscUtils.getTraceObject("bgSocketApp :: onSecurityError()"));
         this.createTrace(MiscUtils.getTraceObject(this.bgSocket.lastError.toString()));
         dataM.trackError("BMSocketSecurityError",this.bgSocket.lastError.toString());
      }
      
      public function disconnect() : void
      {
         TsLogger.log("BMSocketManager :: doDisco");
         if(this.bgSocket != null)
         {
            this.bgSocket.close();
         }
      }
      
      private function gotData(param1:BGSocketEvent) : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 13501
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      private function addBattleCallData(param1:Object) : void
      {
         this.battleCalls[param1.totalCalls] = param1;
      }
      
      public function excecuteBattleCall() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Number = NaN;
         var _loc3_:Object = null;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:BMPlayerProfile = null;
         if(this.battleCalls[this.currentBattleCall + 1] != null)
         {
            ++this.currentBattleCall;
            _loc1_ = this.battleCalls[this.currentBattleCall];
            if(_loc1_.syncData != null)
            {
               screensM.screenBattle.activateNextBattlePhase("sync_syncClientWithServer",{
                  "syncData":_loc1_.syncData,
                  "battleHasJustStarted":false
               });
            }
            else if(screensM.isScreenOpened("screenDebugger"))
            {
               screensM.screenDebugger.addTrace("ERROR ! ! ! - currentCallData.syncData is NULL");
            }
            TsLogger.log("currentCallData.cmd:" + _loc1_.cmd);
            switch(_loc1_.cmd)
            {
               case "BMM_BATTLE_TIMER_ENDED":
                  screensM.screenBattle.timerEnded();
                  break;
               case "BMM_BATTLE_MECH_DESTROYED":
                  screensM.screenBattle.mechDestroyedSuccess();
                  break;
               case "BMM_BATTLE_MOVE_MECH":
                  break;
               case "BMM_BATTLE_MOVE_MECH_TO_STEP":
                  screensM.screenBattle.activateNextBattlePhase("action_moveMechToStepSuccess",{
                     "motionType":_loc1_.motionType,
                     "targetStep":_loc1_.targetStep
                  });
                  break;
               case "BMM_BATTLE_FIRE_WEAPON":
                  _loc2_ = Number(_loc1_.initialDamage);
                  _loc5_ = _loc1_.slotName;
                  switch(_loc5_)
                  {
                     case "leg":
                     case "drone":
                     case "teleport":
                     case "charge":
                     case "harpoon":
                        _loc6_ = _loc5_;
                        _loc7_ = 0;
                        break;
                     default:
                        _loc6_ = _loc5_.substr(0,_loc5_.length - 1);
                        _loc7_ = int(_loc5_.substr(_loc5_.length - 1,1));
                  }
                  screensM.screenBattle.activateNextBattlePhase("action_fireSuccess",{
                     "equipmentType":_loc6_,
                     "equipmentID":_loc7_
                  });
                  break;
               case "BMM_BATTLE_SHUTDOWN":
                  screensM.screenBattle.activateNextBattlePhase("action_shutDownSuccess");
                  break;
               case "BMM_BATTLE_USE_KIT":
                  _loc8_ = int(_loc1_.slotName.substr(_loc1_.slotName.length - 1,1));
                  screensM.screenBattle.activateNextBattlePhase("action_useKitSuccess",{"equipmentID":_loc8_});
                  break;
               case "BMM_BATTLE_TELEPORT":
                  screensM.screenBattle.activateNextBattlePhase("action_teleportSuccess",{"targetStep":_loc1_.targetStep});
                  break;
               case "BMM_BATTLE_CHARGE":
                  screensM.screenBattle.activateNextBattlePhase("action_chargeSuccess");
                  break;
               case "BMM_BATTLE_HARPOON":
                  screensM.screenBattle.activateNextBattlePhase("action_harpoonSuccess");
                  break;
               case "BMM_BATTLE_SHIELD_ACTIVATE":
                  screensM.screenBattle.activateShieldSuccess();
                  break;
               case "BMM_BATTLE_SHIELD_DEACTIVATE":
                  screensM.screenBattle.deactivateShieldSuccess();
                  break;
               case "BMM_BATTLE_DRONE_ACTIVATE":
                  screensM.screenBattle.activateDroneSuccess();
                  break;
               case "BMM_BATTLE_DRONE_DEACTIVATE":
                  screensM.screenBattle.deactivateDroneSuccess();
                  break;
               case "BMM_BATTLE_FORCE_SHUTDOWN_ENDED":
                  screensM.screenBattle.forceShutDownEndedSuccess();
                  break;
               case "BMM_BATTLE_ENERGY_REGENERATION":
                  screensM.screenBattle.activateNextBattlePhase("action_energyRegenerationSuccess");
                  break;
               case "BMM_BATTLE_FORCE_SHUTDOWN":
                  screensM.screenBattle.forceShutDownSuccess();
                  break;
               case "BMM_BATTLE_SWITCH_MECH":
                  screensM.screenBattle.switchMechSuccess(_loc1_.mechID);
                  break;
               case "BMM_BATTLE_SURRENDER":
                  _loc9_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
                  _loc9_.lastLadderProgress = _loc9_.ladderProgress;
                  _loc9_.ladderProgress = _loc1_.ladderProgress;
                  screensM.screenBattle.surrenderSuccess();
                  break;
               case "BMM_BATTLE_OPPONENT_QUIT_BATTLE":
                  screensM.screenBattle.opponentQuitBattle();
                  break;
               case "BMM_BATTLE_RESULT":
                  if(dataM.replays_loaded)
                  {
                     dataM.addOnlineReplayData(_loc1_.replay,"online");
                  }
                  _loc9_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
                  if(screensM.isScreenOpened("screenDebugger"))
                  {
                     screensM.screenDebugger.addTrace("Old gold : " + _loc9_.gold + " New gold : " + _loc1_.gold + " Gold bonus : " + _loc1_.goldBonus);
                     screensM.screenDebugger.addTrace("Reward - gold : " + (_loc1_.gold - _loc9_.gold) + " XP : " + (_loc1_.XP - _loc9_.XP) + " gold bonus : " + _loc1_.goldBonus + " ladderProgress : " + _loc1_.ladderProgress);
                  }
                  _loc9_.battleCredits += _loc1_.battleCreditsRefund;
                  if(_loc1_.tokensBonus == null)
                  {
                     _loc1_.tokensBonus = 0;
                  }
                  screensM.screenBattle.battleResultSuccess(_loc1_.gold,_loc1_.goldBonus,_loc1_.tokensBonus,_loc1_.XP,_loc1_.overallRank,_loc1_.ladderProgress);
                  _loc9_.randomItemsFromLevelUp = new Array();
                  if(_loc1_.randomItemsFromLevelUp != null)
                  {
                     for each(_loc3_ in _loc1_.randomItemsFromLevelUp)
                     {
                        dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,_loc3_.itemID,_loc3_.playerItemID,0,0,0);
                        _loc9_.randomItemsFromLevelUp.push(_loc3_.itemID);
                     }
                  }
                  if(_loc1_.dPremium != null)
                  {
                     _loc4_ = int(_loc1_.dPremium);
                     if(dataM.premiumAccountTime < _loc4_)
                     {
                        dataM.premiumAccountTime = _loc4_;
                     }
                  }
            }
            screensM.screenBattle.checkForReEnablingBottomInterface();
         }
      }
      
      public function createGuestUser() : void
      {
         var _loc4_:uint = 0;
         var _loc10_:BMPlayerItemData = null;
         var _loc11_:String = null;
         var _loc12_:BMBoostData = null;
         var _loc13_:String = null;
         var _loc14_:Object = null;
         var _loc1_:Array = new Array();
         var _loc2_:BMPlayerData = dataM.playersData[dataM.OFFLINE_PLAYER_ID];
         var _loc3_:BMPlayerProfile = dataM.player1Profile;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.items.length)
         {
            _loc10_ = _loc2_.items[_loc4_];
            _loc11_ = "";
            if(_loc10_.equipped > 0)
            {
               _loc11_ = _loc10_.equipmentType;
               if(_loc10_.equipmentID > 0)
               {
                  _loc11_ += _loc10_.equipmentID;
               }
            }
            _loc1_.push({
               "itemID":_loc10_.itemID,
               "equipped":_loc10_.equipped,
               "slotName":_loc11_,
               "power":_loc10_.power
            });
            _loc4_++;
         }
         if(dataM.clientRunningLocally)
         {
         }
         if(_loc3_.getFreePackageAmount(2) == 1)
         {
            _loc12_ = dataM.boostsDB[2];
            _loc3_.gold += _loc12_.bonusGold;
            if(_loc3_.gold > dataM.GUEST_MAX_GOLD)
            {
               _loc3_.gold = dataM.GUEST_MAX_GOLD;
            }
         }
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:String = "";
         var _loc9_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc3_.mapProgress.length)
         {
            _loc13_ = _loc3_.mapProgress[_loc4_];
            if(_loc13_ == "v")
            {
               _loc8_ = _loc8_ + _loc9_ + "v";
               _loc9_ = "";
               _loc14_ = dataM.missionsDB[_loc4_];
               if(_loc14_.type == "itemBox")
               {
                  _loc7_++;
               }
               else if(_loc14_.type == "mission")
               {
                  if(_loc14_.difficulty == 2)
                  {
                     _loc5_++;
                  }
                  else if(_loc14_.difficulty == 3)
                  {
                     _loc6_++;
                  }
               }
            }
            else
            {
               _loc9_ += "x";
            }
            _loc4_++;
         }
         this.sendObjectToSocket("BMM_CREATE_GUEST_USER",[{
            "paramName":"gold",
            "paramValue":_loc3_.gold
         },{
            "paramName":"xp",
            "paramValue":_loc3_.XP
         },{
            "paramName":"bonusTokens",
            "paramValue":_loc3_.tokens
         },{
            "paramName":"battlesVSComputer",
            "paramValue":_loc3_.battlesVSComputer
         },{
            "paramName":"winsVSComputer",
            "paramValue":_loc3_.winsVSComputer
         },{
            "paramName":"items",
            "paramValue":_loc1_
         },{
            "paramName":"tutorialLevel",
            "paramValue":_loc3_.tutorialLevel
         },{
            "paramName":"mapProgress",
            "paramValue":_loc8_
         },{
            "paramName":"missionsCompleted",
            "paramValue":_loc3_.missionsCompleted
         },{
            "paramName":"missionsCompleted_hard",
            "paramValue":_loc5_
         },{
            "paramName":"missionsCompleted_insane",
            "paramValue":_loc6_
         },{
            "paramName":"itemBoxesPickedUp",
            "paramValue":_loc7_
         },{
            "paramName":"itemBoxesBought",
            "paramValue":_loc3_.itemBoxesBought_guest
         },{
            "paramName":"sessionID",
            "paramValue":dataM.sessionID
         },{
            "paramName":"uniqueID",
            "paramValue":dataM.uniqueID
         },{
            "paramName":"userbase",
            "paramValue":GlobalAccess.userbase
         }]);
      }
      
      public function getInitialData() : void
      {
         var _loc1_:Array = [{
            "paramName":"fpsMin",
            "paramValue":screensM.fpsMin()
         },{
            "paramName":"fpsMax",
            "paramValue":screensM.fpsMax()
         },{
            "paramName":"fpsAvg",
            "paramValue":screensM.fpsAvg()
         },{
            "paramName":"sessionID",
            "paramValue":dataM.sessionID
         },{
            "paramName":"uniqueID",
            "paramValue":dataM.uniqueID
         },{
            "paramName":"userbase",
            "paramValue":GlobalAccess.userbase
         },{
            "paramName":"itemsVersion",
            "paramValue":ItemCache.gi().getVersion()
         }];
         this.sendObjectToSocket("BMM_GET_INITIAL_DATA",_loc1_);
         if(screensM.USE_FPS_TRACKER)
         {
            screensM.screenFPSTracker.fpsTracker.resetMinAndMaxFPS();
         }
      }
      
      private function getInitialData_setupPhase2() : void
      {
         this.sendObjectToSocket("BMM_GET_INITIAL_DATA_SETUP_PHASE_2",[]);
      }
      
      private function getInitialData_setupPhase3(param1:Boolean) : void
      {
         this.sendObjectToSocket("BMM_GET_INITIAL_DATA_SETUP_PHASE_3",[{
            "paramName":"dailyLoginStreakWithMythical",
            "paramValue":param1
         }]);
      }
      
      private function getInitialData_setupPhase4() : void
      {
         this.sendObjectToSocket("BMM_GET_INITIAL_DATA_SETUP_PHASE_4",[]);
      }
      
      public function sendGoodbye() : void
      {
         this.sendObjectToSocket("BMM_GOODBYE",[]);
      }
      
      public function clan_getClansAroundMyLadderProgress() : void
      {
         this.sendObjectToSocket("BMM_CLAN_GET_CLANS_AROUND_MY_LADDER_PROGRESS",[]);
      }
      
      public function clan_getClanData(param1:*) : void
      {
         this.sendObjectToSocket("BMM_CLAN_GET_CLAN_DATA",[{
            "paramName":"clanID",
            "paramValue":param1
         }]);
      }
      
      public function clan_create(param1:String) : void
      {
         this.sendObjectToSocket("BMM_CLAN_CREATE",[{
            "paramName":"name",
            "paramValue":param1
         }]);
      }
      
      public function clan_leave() : void
      {
         this.sendObjectToSocket("BMM_CLAN_LEAVE",[]);
      }
      
      public function clan_kick(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_CLAN_KICK",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function clan_requestToJoin(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_CLAN_REQUEST_TO_JOIN",[{
            "paramName":"clanID",
            "paramValue":param1
         }]);
      }
      
      public function clan_acceptNewMember(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_CLAN_ACCEPT_NEW_MEMBER",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function clan_declineRequest(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_CLAN_DECLINE_REQUEST",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function clan_searchClans(param1:String) : void
      {
         this.sendObjectToSocket("BMM_CLAN_SEARCH_CLAN",[{
            "paramName":"searchString",
            "paramValue":param1
         }]);
      }
      
      public function clan_sendInvitation(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_CLAN_SEND_INVITATION",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function clan_acceptInvitation(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_CLAN_ACCEPT_INVITATION",[{
            "paramName":"clanID",
            "paramValue":param1
         }]);
      }
      
      public function clan_declineInvitation(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_CLAN_DECLINE_INVITATION",[{
            "paramName":"clanID",
            "paramValue":param1
         }]);
      }
      
      public function clan_cancelInvitation() : void
      {
         this.sendObjectToSocket("BMM_CLAN_CANCEL_INVITATION",[]);
      }
      
      public function clan_updateFlag(param1:String) : void
      {
         this.sendObjectToSocket("BMM_CLAN_UPDATE_FLAG",[{
            "paramName":"flag",
            "paramValue":param1
         }]);
      }
      
      public function ladderBattles_buyX1() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_CREDITS_BUY_X1",[]);
      }
      
      public function ladderBattles_buyX6() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_CREDITS_BUY_X6",[]);
      }
      
      public function rewardVideoWatched(param1:Boolean) : void
      {
         this.sendObjectToSocket("BMM_REWARD_VIDEO_WATCHED",[{
            "paramName":"tokensReward",
            "paramValue":param1
         }]);
      }
      
      public function lobby_getFreeTokens() : void
      {
         this.sendObjectToSocket("BMM_GET_FREE_TOKENS",[]);
      }
      
      public function lobby_getFreeItemBox() : void
      {
         this.sendObjectToSocket("BMM_GET_FREE_ITEM_BOX",[]);
      }
      
      public function mission_create(param1:uint, param2:uint, param3:uint, param4:String) : void
      {
         this.sendObjectToSocket("BMM_MISSION_CREATE",[{
            "paramName":"difficulty",
            "paramValue":param1
         },{
            "paramName":"themeID",
            "paramValue":param2
         },{
            "paramName":"missionSlot",
            "paramValue":param3
         },{
            "paramName":"flag",
            "paramValue":param4
         }]);
      }
      
      public function mission_abort(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_MISSION_ABORT",[{
            "paramName":"missionSlot",
            "paramValue":param1
         }]);
      }
      
      public function mission_getData() : void
      {
         this.sendObjectToSocket("BMM_MISSION_GET_DATA",[]);
      }
      
      public function mission_addProgress(param1:Number, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint) : void
      {
         this.sendObjectToSocket("BMM_MISSION_ADD_PROGRESS",[{
            "paramName":"position",
            "paramValue":param1
         },{
            "paramName":"hp",
            "paramValue":param2
         },{
            "paramName":"energy",
            "paramValue":param3
         },{
            "paramName":"energyRegeneration",
            "paramValue":param4
         },{
            "paramName":"heat",
            "paramValue":param5
         },{
            "paramName":"heatCooling",
            "paramValue":param6
         },{
            "paramName":"bullets",
            "paramValue":param7
         },{
            "paramName":"rockets",
            "paramValue":param8
         }]);
      }
      
      public function mission_useUpgrade(param1:String) : void
      {
         this.sendObjectToSocket("BMM_MISSION_USE_UPGRADE",[{
            "paramName":"type",
            "paramValue":param1
         }]);
      }
      
      public function mission_playerLost() : void
      {
         this.sendObjectToSocket("BMM_MISSION_PLAYER_LOST",[]);
      }
      
      public function mission_revive() : void
      {
         this.sendObjectToSocket("BMM_MISSION_REVIVE",[]);
      }
      
      public function mission_complete(param1:uint, param2:uint) : void
      {
         this.sendObjectToSocket("BMM_MISSION_COMPLETE",[{
            "paramName":"missionSlot",
            "paramValue":param1
         },{
            "paramName":"completeCampaign",
            "paramValue":param2
         }]);
      }
      
      public function mission_buyMissions(param1:uint, param2:uint) : void
      {
         this.sendObjectToSocket("BMM_MISSION_BUY_MISSIONS",[{
            "paramName":"difficulty",
            "paramValue":param1
         },{
            "paramName":"amount",
            "paramValue":param2
         }]);
      }
      
      public function mission_claimItemBox(param1:uint, param2:uint) : void
      {
         this.sendObjectToSocket("BMM_MISSION_CLAIM_ITEM_BOX",[{
            "paramName":"missionSlot",
            "paramValue":param1
         },{
            "paramName":"packageID",
            "paramValue":param2
         }]);
      }
      
      public function lobby_enter() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_ENTER",[]);
      }
      
      public function lobby_setTutorialLevel(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_TUTORIAL_LEVEL",[{
            "paramName":"tutorialLevel",
            "paramValue":param1
         }]);
      }
      
      public function lobby_chatToAll(param1:String, param2:Number) : void
      {
         this.sendObjectToSocket("BMM_CHAT_TO_ALL",[{
            "paramName":"text",
            "paramValue":param1
         },{
            "paramName":"toPlayerID",
            "paramValue":param2
         }]);
      }
      
      public function lobby_chatBlock(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_CHAT_BLOCK_PLAYER",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_tokensRefresh() : void
      {
         this.sendObjectToSocket("BMM_TOKENS_REFRESH",[]);
      }
      
      public function lobby_updateTokensBought(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_TOKENS_UPDATE_TOKENS_BOUGHT",[{
            "paramName":"tokensBought",
            "paramValue":param1
         }]);
      }
      
      public function lobby_getAchievementStatistic(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_GET_ACHIEVEMENT_STATISTICS",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_selectDailyBonus(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SELECT_DAILY_BONUS",[{
            "paramName":"bonusSlot",
            "paramValue":param1
         }]);
      }
      
      public function lobby_loadGifts() : void
      {
         this.sendObjectToSocket("BMM_GIFTS_LOAD_GIFTS",[]);
      }
      
      public function lobby_useGift(param1:String) : void
      {
         this.sendObjectToSocket("BMM_GIFTS_USE_GIFT",[{
            "paramName":"giftKey",
            "paramValue":param1
         }]);
      }
      
      public function lobby_claimGiftBonus(param1:String) : void
      {
         this.sendObjectToSocket("BMM_GIFTS_CLAIM_GIFT_BONUS",[{
            "paramName":"giftKey",
            "paramValue":param1
         }]);
      }
      
      public function lobby_setRateStatus(param1:String) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_RATE_STATUS",[{
            "paramName":"rateStatus",
            "paramValue":param1
         }]);
      }
      
      public function lobby_searchForPlayer(param1:Number, param2:String) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SEARCH_FOR_PLAYER",[{
            "paramName":"playerID",
            "paramValue":param1
         },{
            "paramName":"playerName",
            "paramValue":param2
         }]);
      }
      
      public function lobby_buyStarterPack() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_BUY_STARTER_PACK",[]);
      }
      
      public function lobby_redeemStarterPackMech(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_REDEEM_STARTER_PACK_MECH",[{
            "paramName":"targetMechID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_setStarterPackTimeOut() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_STARTER_PACK_TIME_OUT",[]);
      }
      
      public function lobby_setStarterPackStartDate() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_STARTER_PACK_START_DATE",[]);
      }
      
      public function buyGold(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_BUY_GOLD",[{
            "paramName":"costTokens",
            "paramValue":param1
         }]);
      }
      
      public function lobby_searchForBattle(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SEARCH_FOR_BATTLE",[{
            "paramName":"mechsPerPlayer",
            "paramValue":param1
         }]);
      }
      
      public function lobby_cancelSearchForBattle() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_CANCEL_SEARCH_FOR_BATTLE",[]);
      }
      
      public function lobby_finishBattleVSComputer(param1:Boolean, param2:Boolean, param3:Boolean, param4:String, param5:String, param6:uint, param7:uint, param8:Number, param9:Object, param10:uint) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_FINISH_BATTLE_VS_COMPUTER",[{
            "paramName":"playerWon",
            "paramValue":param1
         },{
            "paramName":"playerQuit",
            "paramValue":param2
         },{
            "paramName":"specialChallenge",
            "paramValue":param3
         },{
            "paramName":"battleType",
            "paramValue":param4
         },{
            "paramName":"battleSubType",
            "paramValue":param5
         },{
            "paramName":"challengeRewardRatio",
            "paramValue":param6
         },{
            "paramName":"battleReport",
            "paramValue":param9
         },{
            "paramName":"enemyLevel",
            "paramValue":param10
         },{
            "paramName":"difficulty",
            "paramValue":param7
         },{
            "paramName":"computerBattleID",
            "paramValue":param8
         }]);
      }
      
      public function lobby_startedBattleVSComputer() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_STARTED_BATTLE_VS_COMPUTER",[]);
      }
      
      public function lobby_getPlayerGeneralData(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_GET_PLAYER_GENERAL_DATA",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_deleteNotification(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_DELETE_NOTIFICATION",[{
            "paramName":"notificationID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_getPlayerReplays(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_GET_PLAYER_REPLAYS",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_setAgeVerification() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_AGE_VERIFICATION",[]);
      }
      
      public function friendship_requestFriend(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_FRIENDSHIP_REQUEST_FRIEND",[{
            "paramName":"playerID",
            "paramValue":param1
         },{
            "paramName":"username",
            "paramValue":""
         }]);
      }
      
      public function friendship_cancelRequestFriend(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_FRIENDSHIP_CANCEL_REQUEST_FRIEND",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function friendship_acceptFriend(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_FRIENDSHIP_ACCEPT_FRIEND",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function friendship_declineFriend(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_FRIENDSHIP_DECLINE_FRIEND",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function friendship_removeFriend(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_FRIENDSHIP_REMOVE_FRIEND",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_addIgnore(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_ADD_IGNORE",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_removeIgnore(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_REMOVE_IGNORE",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_battleInvitation_create(param1:Number, param2:uint) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_BATTLE_INVITATION_CREATE",[{
            "paramName":"playerID",
            "paramValue":param1
         },{
            "paramName":"mechsPerPlayer",
            "paramValue":param2
         }]);
      }
      
      public function lobby_battleInvitation_accepted(param1:Number, param2:uint) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_BATTLE_INVITATION_ACCEPTED",[{
            "paramName":"playerID",
            "paramValue":param1
         },{
            "paramName":"mechsPerPlayer",
            "paramValue":param2
         }]);
      }
      
      public function lobby_battleInvitation_declined(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_BATTLE_INVITATION_DECLINED",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_battleInvitation_canceled() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_BATTLE_INVITATION_CANCELED",[]);
      }
      
      public function lobby_replaySave(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_REPLAY_SAVE",[{
            "paramName":"replayID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_replayUnsave(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_REPLAY_UNSAVE",[{
            "paramName":"replayID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_clientIsAlive() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_CLIENT_IS_ALIVE",[]);
      }
      
      public function lobby_getPlayerMechs(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_GET_PLAYER_MECHS",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_fusionMultipleItems(param1:Array, param2:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_FUSION_MULTIPLE_ITEMS",[{
            "paramName":"sourcePlayerItemIDs",
            "paramValue":param1
         },{
            "paramName":"targetPlayerItemID",
            "paramValue":param2
         }]);
      }
      
      public function lobby_craftMythical(param1:Array, param2:String) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_CRAFT_MYTHICAL",[{
            "paramName":"sourcePlayerItemIDs",
            "paramValue":param1
         },{
            "paramName":"type",
            "paramValue":param2
         }]);
      }
      
      public function lobby_rankingList() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_RANKING_LIST",[]);
      }
      
      public function lobby_deleteItem(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_DELETE_ITEM",[{
            "paramName":"playerItemID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_usersStatistics() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_USERS_STATISTICS",[]);
      }
      
      public function lobby_setLastNewsID(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_LAST_NEWS_ID",[{
            "paramName":"lastNewsID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_exitWorkshop() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_EXIT_WORKSHOP",[]);
      }
      
      public function lobby_setSettings(param1:String) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_SETTINGS",[{
            "paramName":"settings",
            "paramValue":param1
         }]);
      }
      
      public function lobby_changeName(param1:String) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_CHANGE_NAME",[{
            "paramName":"name",
            "paramValue":param1
         }]);
      }
      
      public function lobby_buyChangeName(param1:String) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_BUY_CHANGE_NAME",[{
            "paramName":"newName",
            "paramValue":param1
         }]);
      }
      
      public function lobby_setSelectedMechID(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_SELECTED_MECH_IDS",[{
            "paramName":"selectedMechIDs",
            "paramValue":String(param1)
         }]);
      }
      
      public function lobby_setLastDevice(param1:String) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_LAST_DEVICE",[{
            "paramName":"lastDevice",
            "paramValue":param1
         }]);
      }
      
      public function lobby_addItemsForNewPlayer() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_ADD_ITEMS_FOR_NEW_PLAYER",[]);
      }
      
      public function lobby_getPlayerData(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_GET_PLAYER_DATA",[{
            "paramName":"playerID",
            "paramValue":param1
         }]);
      }
      
      public function inventory_buyItem(param1:Number, param2:uint = 1) : void
      {
         TsLogger.log("AMOUNT:" + param2);
         this.sendObjectToSocket("BMM_INVENTORY_BUY_ITEM",[{
            "paramName":"itemID",
            "paramValue":param1
         },{
            "paramName":"amount",
            "paramValue":param2
         }]);
      }
      
      public function inventory_updateMech(param1:Number, param2:Array) : void
      {
         this.sendObjectToSocket("BMM_INVENTORY_UPDATE_MECH",[{
            "paramName":"torsoPlayerItemID",
            "paramValue":param1
         },{
            "paramName":"items",
            "paramValue":param2
         }]);
      }
      
      public function inventory_updateMechs(param1:Boolean, param2:Array, param3:Array, param4:Boolean, param5:uint) : void
      {
         this.sendObjectToSocket("BMM_INVENTORY_UPDATE_MECHS",[{
            "paramName":"updateMechs",
            "paramValue":param1
         },{
            "paramName":"torsoPlayerItemIDs",
            "paramValue":param2
         },{
            "paramName":"items",
            "paramValue":param3
         },{
            "paramName":"updateSelectedMechIDs",
            "paramValue":param4
         },{
            "paramName":"selectedMechIDs",
            "paramValue":String(param5)
         }]);
      }
      
      public function inventory_changeMechsOrder(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint) : void
      {
         this.sendObjectToSocket("BMM_INVENTORY_CHANGE_MECHS_ORDER",[{
            "paramName":"mech1NewSlot",
            "paramValue":param1
         },{
            "paramName":"mech2NewSlot",
            "paramValue":param2
         },{
            "paramName":"mech3NewSlot",
            "paramValue":param3
         },{
            "paramName":"mech4NewSlot",
            "paramValue":param4
         },{
            "paramName":"mech5NewSlot",
            "paramValue":param5
         },{
            "paramName":"mech6NewSlot",
            "paramValue":param6
         }]);
      }
      
      public function battle_moveMech(param1:String, param2:String) : void
      {
         this.sendObjectToSocket("BMM_BATTLE_MOVE_MECH",[{
            "paramName":"motionType",
            "paramValue":param1
         },{
            "paramName":"direction",
            "paramValue":param2
         }]);
      }
      
      public function battle_moveMechToStep(param1:String, param2:Number) : void
      {
         this.sendObjectToSocket("BMM_BATTLE_MOVE_MECH_TO_STEP",[{
            "paramName":"motionType",
            "paramValue":param1
         },{
            "paramName":"targetStep",
            "paramValue":param2
         }]);
      }
      
      public function battle_activateDrone() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_DRONE_ACTIVATE",[]);
      }
      
      public function battle_deactivateDrone() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_DRONE_DEACTIVATE",[]);
      }
      
      public function battle_activateShield() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_SHIELD_ACTIVATE",[]);
      }
      
      public function battle_deactivateShield() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_SHIELD_DEACTIVATE",[]);
      }
      
      public function battle_forceShutDownEnded() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_FORCE_SHUTDOWN_ENDED",[]);
      }
      
      public function battle_shutDown() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_SHUTDOWN",[]);
      }
      
      public function battle_taunt(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_BATTLE_TAUNT_NEW",[{
            "paramName":"tauntID",
            "paramValue":param1
         }]);
      }
      
      public function battle_fireWeapon(param1:String, param2:Number) : void
      {
         var _loc3_:String = param1;
         switch(param1)
         {
            case "sideWeapon":
            case "topWeapon":
               _loc3_ += param2;
         }
         this.sendObjectToSocket("BMM_BATTLE_FIRE_WEAPON",[{
            "paramName":"slotName",
            "paramValue":_loc3_
         }]);
      }
      
      public function battle_useKit(param1:Number) : void
      {
         var _loc2_:String = "kit" + param1;
         this.sendObjectToSocket("BMM_BATTLE_USE_KIT",[{
            "paramName":"slotName",
            "paramValue":_loc2_
         }]);
      }
      
      public function battle_teleport(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_BATTLE_TELEPORT",[{
            "paramName":"targetStep",
            "paramValue":param1
         }]);
      }
      
      public function battle_charge() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_CHARGE",[]);
      }
      
      public function battle_harpoon() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_HARPOON",[]);
      }
      
      public function battle_stomp() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_STOMP",[]);
      }
      
      public function battle_switchMech(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_BATTLE_SWITCH_MECH",[{
            "paramName":"mechID",
            "paramValue":param1
         }]);
      }
      
      public function battle_sendMessage(param1:String) : void
      {
         this.sendObjectToSocket("BMM_BATTLE_SEND_MESSAGE",[{
            "paramName":"message",
            "paramValue":param1
         }]);
      }
      
      public function battle_battleResult() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_RESULT",[{
            "paramName":"fpsMin",
            "paramValue":screensM.fpsMin()
         },{
            "paramName":"fpsMax",
            "paramValue":screensM.fpsMax()
         },{
            "paramName":"fpsAvg",
            "paramValue":screensM.fpsAvg()
         }]);
         if(screensM.USE_FPS_TRACKER)
         {
            screensM.screenFPSTracker.fpsTracker.resetMinAndMaxFPS();
         }
      }
      
      public function battle_surrender() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_SURRENDER",[]);
      }
      
      public function tokens_buyPackage(param1:Number) : void
      {
         this._buyPackage_packageID = param1;
         this.sendObjectToSocket("BMM_TOKENS_BUY_PACKAGE",[{
            "paramName":"packageID",
            "paramValue":param1
         }]);
      }
      
      public function tokens_redeemPackage(param1:Number, param2:int) : void
      {
         this._buyPackage_packageID = param1;
         this.sendObjectToSocket("BMM_TOKENS_BUY_PACKAGE_NEW",[{
            "paramName":"packageID",
            "paramValue":param1
         },{
            "paramName":"fromNotification",
            "paramValue":param2
         }]);
      }
      
      public function tokens_buyPackageNew(param1:Number, param2:Number = 0, param3:Number = 0) : void
      {
         this._buyPackage_packageID = param1;
         if(param2 > 0)
         {
            this.sendObjectToSocket("BMM_TOKENS_BUY_PACKAGE_NEW",[{
               "paramName":"packageID",
               "paramValue":param1
            },{
               "paramName":"itemID",
               "paramValue":param2
            },{
               "paramName":"costTokens",
               "paramValue":param3
            }]);
         }
         else
         {
            this.sendObjectToSocket("BMM_TOKENS_BUY_PACKAGE_NEW",[{
               "paramName":"packageID",
               "paramValue":param1
            }]);
         }
      }
      
      public function tokens_sendToPlayerID(param1:Number, param2:Number) : void
      {
         this.sendObjectToSocket("BMM_TOKENS_SEND_TO_PLAYER_ID",[{
            "paramName":"playerID",
            "paramValue":param1
         },{
            "paramName":"tokensToSend",
            "paramValue":param2
         }]);
      }
      
      public function chat_enter(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_CHAT_ENTER",[{
            "paramName":"channelID",
            "paramValue":param1
         }]);
      }
      
      public function chat_exit() : void
      {
         this.sendObjectToSocket("BMM_CHAT_EXIT",[]);
      }
      
      public function chat_sendMessage(param1:String) : void
      {
         this.sendObjectToSocket("BMM_CHAT_SEND_MESSAGE",[{
            "paramName":"message",
            "paramValue":param1
         }]);
      }
      
      public function admin_getGeneralInfo() : void
      {
         this.sendObjectToSocket("BMM_ADMIN_GET_GENERAL_INFO",[]);
      }
      
      public function admin_activateWeeklyReset(param1:String) : void
      {
      }
      
      public function admin_updateBoostData(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint) : void
      {
         this.sendObjectToSocket("BMM_ADMIN_UPDATE_BOOST_DATA",[{
            "paramName":"boostID",
            "paramValue":param1
         },{
            "paramName":"costTokens",
            "paramValue":param2
         },{
            "paramName":"ratioRare",
            "paramValue":param3
         },{
            "paramName":"ratioEpic",
            "paramValue":param4
         },{
            "paramName":"ratioLegendary",
            "paramValue":param5
         },{
            "paramName":"ratioMythical",
            "paramValue":param6
         },{
            "paramName":"ratioNewMythical",
            "paramValue":param7
         },{
            "paramName":"itemID",
            "paramValue":param8
         }]);
      }
      
      public function admin_setBoostsResetTime(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_ADMIN_SET_BOOSTS_RESET_TIME",[{
            "paramName":"resetTimeAddon",
            "paramValue":param1
         }]);
      }
      
      public function admin_sendFreeBoosts(param1:Number, param2:uint, param3:uint) : void
      {
         this.sendObjectToSocket("BMM_ADMIN_SEND_FREE_BOOSTS",[{
            "paramName":"playerID",
            "paramValue":param1
         },{
            "paramName":"boostID",
            "paramValue":param2
         },{
            "paramName":"amount",
            "paramValue":param3
         }]);
      }
      
      public function admin_sendItem(param1:Number, param2:uint, param3:Number) : void
      {
         this.sendObjectToSocket("BMM_ADMIN_SEND_ITEM",[{
            "paramName":"playerID",
            "paramValue":param1
         },{
            "paramName":"itemID",
            "paramValue":param2
         },{
            "paramName":"power",
            "paramValue":param3
         }]);
      }
      
      public function admin_alertServerRestart(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_ADMIN_ALERT_SERVER_RESTART",[{
            "paramName":"restartTime",
            "paramValue":param1
         }]);
      }
      
      public function admin_updateItemsTable() : void
      {
         this.sendObjectToSocket("BMM_ADMIN_UPDATE_ITEMS_TABLE",[]);
      }
      
      public function temp_skipTutorial() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.tutorialLevel < BMDataManager.TUTORIAL_LEVEL_COMPLETED)
         {
            this.sendObjectToSocket("BMM_TEMP_SKIP_TUTORIAL",[]);
         }
      }
      
      private function generateUsersSearchingArray(param1:Object) : Array
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:Number = 1;
         for each(_loc4_ in param1)
         {
            _loc2_[_loc3_] = new Array();
            for each(_loc5_ in param1[_loc3_])
            {
               _loc2_[_loc3_].push(int(_loc5_));
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function generateUsersOnlineArray(param1:Object) : Array
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:Number = 1;
         for each(_loc4_ in param1)
         {
            _loc2_[_loc3_] = new Array();
            for each(_loc5_ in param1[_loc3_])
            {
               _loc2_[_loc3_].push(int(_loc5_));
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function sendObjectToSocket(param1:String, param2:Array) : void
      {
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         if(this.bgSocket.public::isConnected)
         {
            _loc3_ = new Object();
            _loc3_.cmd = param1;
            _loc4_ = 0;
            while(_loc4_ < param2.length)
            {
               _loc3_[param2[_loc4_].paramName] = param2[_loc4_].paramValue;
               _loc4_++;
            }
            this.bgSocket.sendObject(_loc3_);
            switch(param1)
            {
               case "BMM_CHAT_TO_ALL":
                  break;
               default:
                  TsLogger.log(" > > > CALLING : " + param1);
            }
            BMMSessionManager.gi().pythonFunctionCalled(param1);
            if(screensM.isScreenOpened("screenDebugger"))
            {
               screensM.screenDebugger.addTrace(" > > > CALLING : " + param1);
            }
         }
         else
         {
            if(screensM.isScreenOpened("screenDebugger"))
            {
               screensM.screenDebugger.addTrace("ERROR - NO CONNECTION WITH SOCKET");
            }
            TsLogger.log("ERROR - NO CONNECTION WITH SOCKET");
         }
      }
      
      private function onConnect(param1:BGSocketEvent) : void
      {
         if(dataM.guestRegistrationActive || dataM.guestGenerateUserActive)
         {
            this.createGuestUser();
            dataM.guestRegistrationActive = false;
            dataM.guestGenerateUserActive = false;
         }
         else
         {
            this.getInitialData();
         }
      }
      
      public function reconnect() : void
      {
         TsLogger.log("BMSocketManager::reconnect");
         if(this.bgSocket.connected)
         {
            trace("BMSocketManager::reconnect - was connected, closing before connection");
            this.bgSocket.close();
         }
         var _loc1_:BMMClientFlashVars = new BMMClientFlashVars(stage);
         this.bgSocket.connect(BMDomainResolver.getDomain(),_loc1_.port);
      }
      
      private function createTrace(param1:String) : void
      {
      }
      
      public function get isConnected() : Boolean
      {
         return this.bgSocket != null && this.bgSocket.public::isConnected;
      }
   }
}

