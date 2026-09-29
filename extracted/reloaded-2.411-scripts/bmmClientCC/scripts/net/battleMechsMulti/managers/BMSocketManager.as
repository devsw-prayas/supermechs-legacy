package net.battleMechsMulti.managers
{
   import flash.display.StageQuality;
   import flash.events.Event;
   import net.battleMechsMulti.data.ItemCache;
   import net.battleMechsMulti.data.ItemDBDumper;
   import net.battleMechsMulti.data.ItemDBLoader;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMNewsData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMPlayerRankingListData;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.screens.shop.BMGachaMachineData;
   import net.battleMechsMulti.session.BMDomainResolver;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battlegate.events.BGSocketEvent;
   import net.battlegate.sockets.BGSocket;
   import net.tacticsoft.global.BMMClientFlashConsts;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.managers.BMMSessionManager;
   import net.tacticsoft.utils.MiscUtils;
   
   public final dynamic class BMSocketManager extends BMBaseClass
   {
      
      private var bgSocket:BGSocket;
      
      private var battleCalls:Array;
      
      public var currentBattleCall:Number;
      
      private var _buyPackage_packageID:Number;
      
      private var _buyGacha_gachaMachineID:Number;
      
      public var sellingMultipleItems:Boolean = false;
      
      public var currentDomain:String;
      
      public var flashVars:BMMClientFlashVars;
      
      private var _fixingAddItemsForNewPlayer:Boolean = false;
      
      private var _lastMsgSent:Object;
      
      private var _getInitialData_inventorySize:uint = 0;
      
      private var _getInitialData_highestNewsID:Number = 0;
      
      private var _mechsNewLocations:Array;
      
      private var itemDBDumper:ItemDBDumper = null;
      
      private var itemDBLoader:ItemDBLoader = null;
      
      private var doGetInitialDataMidWorkData:* = null;
      
      private var counter:int = 5;
      
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
         var _loc2_:uint = Boolean(GlobalAccess.overridePort) && this.flashVars.port != BMMClientFlashConsts.usedPortForDev ? GlobalAccess.overridePort : uint(this.flashVars.port);
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
      
      public function silentDisconnect() : void
      {
         this.bgSocket.silentClose();
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
          * Instruction count: 8644
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
      
      public function getGuestData() : Object
      {
         var _loc5_:uint = 0;
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:String = null;
         var _loc13_:BMBoostData = null;
         var _loc14_:String = null;
         var _loc15_:Object = null;
         var _loc1_:Object = new Object();
         var _loc2_:Array = new Array();
         var _loc3_:BMPlayerData = dataM.playersData[dataM.LOCAL_PLAYER_ID];
         var _loc4_:BMPlayerProfile = dataM.player1Profile;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.items.length)
         {
            _loc11_ = _loc3_.items[_loc5_];
            _loc12_ = "";
            if(_loc11_.equipped > 0)
            {
               _loc12_ = _loc11_.equipmentType;
               if(_loc11_.equipmentID > 0)
               {
                  _loc12_ += _loc11_.equipmentID;
               }
            }
            _loc2_.push({
               "itemID":_loc11_.itemID,
               "equipped":_loc11_.equipped,
               "slotName":_loc12_,
               "power":_loc11_.power
            });
            _loc5_++;
         }
         if(_loc4_.getFreePackageAmount(2) == 1)
         {
            _loc13_ = dataM.boostsDB[2];
            _loc4_.gold += _loc13_.bonusGold;
         }
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:String = "";
         var _loc10_:String = "";
         _loc5_ = 0;
         while(_loc5_ < _loc4_.mapProgress.length)
         {
            _loc14_ = _loc4_.mapProgress[_loc5_];
            if(_loc14_ == "v")
            {
               _loc9_ = _loc9_ + _loc10_ + "v";
               _loc10_ = "";
               _loc15_ = dataM.missionsDB[_loc5_];
               if(_loc15_.type == "itemBox")
               {
                  _loc8_++;
               }
               else if(_loc15_.type == "mission")
               {
                  if(_loc15_.difficulty == 2)
                  {
                     _loc6_++;
                  }
                  else if(_loc15_.difficulty == 3)
                  {
                     _loc7_++;
                  }
               }
            }
            else
            {
               _loc10_ += "x";
            }
            _loc5_++;
         }
         _loc1_.gold = _loc4_.gold;
         _loc1_.xp = _loc4_.XP;
         _loc1_.bonusTokens = _loc4_.tokens;
         _loc1_.battlesVSComputer = _loc4_.battlesVSComputer;
         _loc1_.winsVSComputer = _loc4_.winsVSComputer;
         _loc1_.items = _loc2_;
         _loc1_.tutorialLevel = _loc4_.tutorialLevel;
         _loc1_.mapProgress = _loc9_;
         _loc1_.missionsCompleted = _loc4_.missionsCompleted;
         _loc1_.missionsCompleted_hard = _loc6_;
         _loc1_.missionsCompleted_insane = _loc7_;
         _loc1_.itemBoxesPickedUp = _loc8_;
         _loc1_.itemBoxesBought = _loc4_.itemBoxesBought_guest;
         return _loc1_;
      }
      
      public function getInitialData(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:Array = [{
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
         if(param1)
         {
            _loc3_.push({
               "paramName":"guestData",
               "paramValue":this.getGuestData()
            });
         }
         if(param2)
         {
            this.sendObjectToSocket("BMM_GET_INITIAL_DATA_AFTER_TUTORIAL",_loc3_);
         }
         else
         {
            this.sendObjectToSocket("BMM_GET_INITIAL_DATA",_loc3_);
         }
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
      
      public function lobby_finishBattleVSComputer(param1:Boolean, param2:Boolean, param3:Boolean, param4:String, param5:String, param6:uint, param7:uint, param8:Number, param9:Object, param10:uint, param11:Boolean = false, param12:Boolean = false, param13:Number = 0, param14:Number = 0, param15:Number = 0, param16:uint = 0, param17:uint = 0, param18:uint = 0) : void
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
         },{
            "paramName":"droneOnlyWin",
            "paramValue":param11
         },{
            "paramName":"meleeOnlyWin",
            "paramValue":param12
         },{
            "paramName":"opponentResistance1",
            "paramValue":param13
         },{
            "paramName":"opponentResistance2",
            "paramValue":param14
         },{
            "paramName":"opponentResistance3",
            "paramValue":param15
         },{
            "paramName":"maxSingleShotDamage",
            "paramValue":param16
         },{
            "paramName":"singleOverheats",
            "paramValue":param17
         },{
            "paramName":"doubleOverheats",
            "paramValue":param18
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
      
      public function inventory_changeMechsOrder(param1:Array) : void
      {
         this._mechsNewLocations = param1;
         TsLogger.log("BMSocketManager:inventory_changeMechsOrder " + this._mechsNewLocations[1] + " " + this._mechsNewLocations[2] + " " + this._mechsNewLocations[3] + " " + this._mechsNewLocations[4] + " " + this._mechsNewLocations[5] + " " + this._mechsNewLocations[6]);
         this.sendObjectToSocket("BMM_INVENTORY_CHANGE_MECHS_ORDER",[{
            "paramName":"mech1NewSlot",
            "paramValue":param1[1]
         },{
            "paramName":"mech2NewSlot",
            "paramValue":param1[2]
         },{
            "paramName":"mech3NewSlot",
            "paramValue":param1[3]
         },{
            "paramName":"mech4NewSlot",
            "paramValue":param1[4]
         },{
            "paramName":"mech5NewSlot",
            "paramValue":param1[5]
         },{
            "paramName":"mech6NewSlot",
            "paramValue":param1[6]
         }]);
      }
      
      private function onChangeMechsOrderSuccess() : *
      {
         var _loc3_:BMMechStructure = null;
         var _loc4_:uint = 0;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:String = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc5_:int = _loc1_.level >= dataM.LEVEL_MAX ? int(dataM.inventoryMaxMechs) : int(dataM.battleMaxMechs);
         _loc4_ = 1;
         while(_loc4_ <= _loc5_)
         {
            _loc3_ = _loc2_.mechStructures[_loc4_];
            _loc3_.resetStructure();
            _loc4_++;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < _loc2_.items.length)
         {
            _loc7_ = _loc2_.items[_loc6_];
            if(_loc7_.equipped > 0)
            {
               _loc7_.equipped = this._mechsNewLocations[_loc7_.equipped];
               _loc3_ = _loc2_.mechStructures[_loc7_.equipped];
               _loc8_ = _loc7_.equipmentType;
               if(_loc7_.equipmentID > 0)
               {
                  _loc8_ += _loc7_.equipmentID;
               }
               _loc3_[_loc8_] = _loc7_.playerItemID;
            }
            _loc6_++;
         }
         _loc4_ = 1;
         while(_loc4_ <= _loc5_)
         {
            _loc3_ = _loc2_.mechStructures[_loc4_];
            _loc3_.updateEquipmentIndicators();
            _loc4_++;
         }
         _loc2_.updateMechsWeight();
         if(screensM.isScreenOpened("screenChangeMechsOrder"))
         {
            screensM.screenChangeMechsOrder.mechsOrderChangeSuccess();
         }
         if(screensM.isScreenOpened("screenHangerMech"))
         {
            screensM.screenHangerMech.refreshScreen(true);
            screensM.screenHangerMech.refreshMechStats(0);
         }
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
      
      public function lobby_buyGachaMachine(param1:uint) : void
      {
         this._buyGacha_gachaMachineID = param1;
         this.sendObjectToSocket("BMM_BUY_GACHA_MACHINE",[{
            "paramName":"gachaMachineID",
            "paramValue":param1
         }]);
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
         if(FeatureFlags.GACHA_MACHINES)
         {
            this.sendObjectToSocket("BMM_BUY_GACHA_MACHINE",[{
               "paramName":"gachaMachineID",
               "paramValue":param1
            },{
               "paramName":"fromNotification",
               "paramValue":param2
            }]);
         }
         else
         {
            this.sendObjectToSocket("BMM_TOKENS_BUY_PACKAGE_NEW",[{
               "paramName":"packageID",
               "paramValue":param1
            },{
               "paramName":"fromNotification",
               "paramValue":param2
            }]);
         }
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
      
      public function getQuestsData() : void
      {
         this.sendObjectToSocket("BMM_QUEST_GET_DATA",[]);
      }
      
      public function claimQuestReward(param1:int) : void
      {
         this.sendObjectToSocket("BMM_QUEST_CLAIM_REWARD",[{
            "paramName":"playerQuestID",
            "paramValue":param1
         }]);
      }
      
      public function adminCompleteAchievement(param1:int) : void
      {
         this.sendObjectToSocket("BMM_ADMIN_COMPLETE_ACHIEVEMENT",[{
            "paramName":"questID",
            "paramValue":param1
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
      
      public function admin_giveSpecialItems() : void
      {
         this.sendObjectToSocket("BMM_ADMIN_GIVE_SPECIAL_ITEMS",[]);
      }
      
      public function temp_skipTutorial() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.tutorialLevel < BMTutorialManager.TUTORIAL_LEVEL_COMPLETED)
         {
            this.sendObjectToSocket("BMM_TEMP_SKIP_TUTORIAL",[]);
         }
      }
      
      private function createItemDataFromData(param1:Object, param2:Object) : BMItemData
      {
         var _loc3_:Object = param1;
         var _loc4_:* = new BMItemData();
         _loc4_.itemID = _loc3_.itemID;
         _loc4_.fullName = _loc3_.fullName;
         _loc4_.sortID = _loc3_.sortID;
         _loc4_.type = _loc3_.type;
         _loc4_.subType = _loc3_.subType;
         _loc4_.level = _loc3_.level;
         _loc4_.displayLevel = _loc3_.displayLevel;
         _loc4_.upgradeToItemID = _loc3_.upgradeToItemID;
         _loc4_.powerToUpgrade = _loc3_.powerToUpgrade;
         _loc4_.minPowerToHave = _loc3_.minPowerToHave;
         _loc4_.materialPowerContribution = _loc3_.materialPowerContribution;
         _loc4_.upgradeGoldCost = _loc3_.upgradeGoldCost;
         _loc4_.evolutionGoldCost = _loc3_.evolutionGoldCost;
         _loc4_.HPBase = _loc3_.HPBase;
         _loc4_.HPAddon = _loc3_.HPAddon;
         _loc4_.energyBase = _loc3_.energyBase;
         _loc4_.energyAddon = _loc3_.energyAddon;
         _loc4_.heatBase = _loc3_.heatBase;
         _loc4_.heatAddon = _loc3_.heatAddon;
         _loc4_.bullets = _loc3_.bullets;
         _loc4_.rockets = _loc3_.rockets;
         _loc4_.damageBase = _loc3_.damageBase;
         _loc4_.damageAddon = _loc3_.damageAddon;
         _loc4_.damageType = _loc3_.damageType;
         _loc4_.damageHeat = _loc3_.damageHeat;
         _loc4_.damageHeatBase = _loc3_.damageHeatBase;
         _loc4_.damageHeatAddon = _loc3_.damageHeatAddon;
         _loc4_.damageEnergy = _loc3_.damageEnergy;
         _loc4_.damageEnergyBase = _loc3_.damageEnergyBase;
         _loc4_.damageEnergyAddon = _loc3_.damageEnergyAddon;
         _loc4_.uses = _loc3_.uses;
         _loc4_.push = _loc3_.push;
         _loc4_.resist1 = _loc3_.resist1;
         _loc4_.resist2 = _loc3_.resist2;
         _loc4_.resist3 = _loc3_.resist3;
         _loc4_.rangeBase = _loc3_.rangeBase;
         _loc4_.rangeAddon = _loc3_.rangeAddon;
         _loc4_.stepsPerWalk = _loc3_.stepsPerWalk;
         _loc4_.stepsPerJump = _loc3_.stepsPerJump;
         _loc4_.energyPerBlock = _loc3_.energyPerBlock;
         _loc4_.heatPerBlock = _loc3_.heatPerBlock;
         _loc4_.HPPerBlock = _loc3_.HPPerBlock;
         _loc4_.absorbRatio = _loc3_.absorbRatio;
         _loc4_.costHeat = _loc3_.costHeat;
         _loc4_.costEnergy = _loc3_.costEnergy;
         _loc4_.costGold = _loc3_.costGold;
         _loc4_.costTokens = _loc3_.costTokens;
         if(_loc3_.costTokensDefault != null)
         {
            _loc4_.costTokensDefault = _loc3_.costTokensDefault;
         }
         else
         {
            _loc4_.costTokensDefault = _loc4_.costTokens;
         }
         _loc4_.animation = _loc3_.animation;
         _loc4_.grp = _loc3_.grp;
         _loc4_.specialStatus = _loc3_.specialStatus;
         _loc4_.power = _loc3_.power;
         _loc4_.weight = 0;
         _loc4_.weight = _loc3_.weight;
         var _loc5_:Boolean = true;
         if(_loc3_.isInShop != null)
         {
            _loc5_ = Boolean(_loc3_.isInShop);
         }
         _loc4_.isInShop = _loc5_;
         if(_loc3_.isDeprecated != null)
         {
            _loc4_.isDeprecated = _loc3_.isDeprecated;
         }
         var _loc6_:* = dataM.itemTypeSortDB[_loc4_.type];
         _loc6_ = _loc6_ + (int(_loc4_.level) * 100 + int(_loc4_.sortID));
         if(_loc4_.subType == "power")
         {
            _loc6_ += 30;
         }
         if(!param2.hasOwnProperty(_loc6_))
         {
            param2[_loc6_] = [];
         }
         param2[_loc6_].push(_loc4_);
         return _loc4_;
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
         if(tutorialM.guestGenerateUserActive)
         {
            this.getInitialData(true);
            tutorialM.completeGeneratingGuestUser();
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
      
      private function doGetInitialData(param1:Object) : void
      {
         BMLoadingTimer.gi().removeLostConnectionMessage();
         this.doGetInitialData_setVersionParameters(param1);
         this.doGetInitialData_setGeneralParameters(param1);
         externalAssetsM.checkVersions();
         this.doGetInitialDataMidWorkData = param1;
         if(externalAssetsM.versionsUpToDate)
         {
            if(param1.items)
            {
               BMLoadingTimer.gi().showLoading("Updating Items...");
               this.counter = 5;
            }
            else
            {
               BMLoadingTimer.gi().showLoading("Loading Data...");
               this.counter = 0;
            }
            addEventListener(Event.ENTER_FRAME,this.getInitialData_startLoadingItems);
         }
         else
         {
            this.doGetInitialData_clientOutOfDate();
            if(dataM.specialUser || dataM.userID == 11208154)
            {
               screensM.btnDebugger.visible = true;
            }
         }
      }
      
      private function continueGetInitialDataAfterItemLoad(param1:Object) : void
      {
         this.doGetInitialData_settingsAndProfile(param1);
         this.doGetInitialData_inventory(param1);
         this.doGetInitialData_achievements(param1);
         this.doGetInitialData_newsAndSales(param1);
         this.doGetInitialData_clanRequests(param1);
         this.doGetInitialData_userStatstics(param1);
         this.doGetInitialData_rankingLists(param1);
         this.doGetInitialData_boostsAndTokenPackages(param1);
         this.doGetInitialData_loadQuests(param1);
         this.doGetInitialData_finalFunctions(param1);
         TsLogger.log("userID: " + dataM.userID);
         if(dataM.specialUser || dataM.userID == 11208154)
         {
            screensM.btnDebugger.visible = true;
         }
      }
      
      private function doGetInitialData_setVersionParameters(param1:Object) : void
      {
         externalAssetsM.version_client_pc = param1.general.version_client;
         externalAssetsM.version_items1 = param1.general.version_items1;
         externalAssetsM.version_items2 = param1.general.version_items2;
         externalAssetsM.version_items3 = param1.general.version_items3;
         externalAssetsM.version_general = param1.general.version_general;
         externalAssetsM.version_music = param1.general.version_music;
         externalAssetsM.version_sound = param1.general.version_sound;
         externalAssetsM.version_client_ios = param1.general.version_ipad;
         externalAssetsM.version_client_android = param1.general.version_android;
         externalAssetsM.version_client_steam = param1.general.version_steam;
         if(screensM.isScreenOpened("screenWelcomeBackground"))
         {
            screensM.screenWelcomeBackground.refreshVersionText();
         }
      }
      
      private function doGetInitialData_setGeneralParameters(param1:Object) : void
      {
         dataM.battleMaxMechs = int(param1.general.mechsMax);
         dataM.inventoryMaxMechs = int(param1.general.inventoryMaxMechs);
         dataM.createEquipmentUnlockedDB(true);
         if(param1.weeklyResetEras != null)
         {
            dataM.createWeeklyWinnersData(param1.weeklyResetEras);
         }
         var _loc2_:Boolean = false;
         if(dataM.runAsMobile)
         {
            if(param1.general.useGiftSystemForMobile != null)
            {
               if(int(param1.general.useGiftSystemForMobile) == 1)
               {
                  _loc2_ = true;
               }
            }
         }
         else if(param1.general.useGiftSystem != null)
         {
            if(int(param1.general.useGiftSystem) == 1)
            {
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            dataM.useGiftSystem = true;
            dataM.giftKeyGold = int(param1.general.giftKeyGold);
            dataM.giftKeysUseMaxLevel = int(param1.general.giftKeysUseMaxLevel);
            dataM.giftKeysBonus1Level = int(param1.general.giftKeysBonus1Level);
            dataM.giftKeysBonus2Level = int(param1.general.giftKeysBonus2Level);
            dataM.giftKeysBonus3Level = int(param1.general.giftKeysBonus3Level);
            dataM.giftKeysBonus1Gold = int(param1.general.giftKeysBonus1Gold);
            dataM.giftKeysBonus2Gold = int(param1.general.giftKeysBonus2Gold);
         }
         if(param1.general.useSilverBoxesForGifts != null)
         {
            if(int(param1.general.useSilverBoxesForGifts) == 1)
            {
               dataM.useSilverBoxesForGifts = true;
            }
         }
         dataM.useMissionWorldMapInterface = false;
         if(param1.general.useMissionWorldMapInterface != null)
         {
            if(int(param1.general.useMissionWorldMapInterface) == 1)
            {
               dataM.useMissionWorldMapInterface = true;
            }
         }
         dataM.useMissionWorldMapInterface_web = false;
         if(param1.general.useMissionWorldMapInterface_web != null)
         {
            if(int(param1.general.useMissionWorldMapInterface_web) == 1)
            {
               dataM.useMissionWorldMapInterface_web = true;
            }
         }
         dataM.useCraftMythicals = false;
         if(param1.general.useCraftMythicals != null)
         {
            if(int(param1.general.useCraftMythicals) == 1)
            {
               dataM.useCraftMythicals = true;
               dataM.craftPower_torso = param1.general.craftPower_torso;
               dataM.craftPower_leg = param1.general.craftPower_leg;
               dataM.craftPower_sideWeapon = param1.general.craftPower_sideWeapon;
               dataM.craftPower_topWeapon = param1.general.craftPower_topWeapon;
               dataM.craftPower_special = param1.general.craftPower_special;
               dataM.craftPower_module = param1.general.craftPower_module;
               dataM.craftMythicals_level = param1.general.craftMythicals_level;
            }
         }
         dataM.supersonic_useRewardedVideosMobile = false;
         if(param1.general.supersonic_useRewardedVideosMobile != null)
         {
            if(int(param1.general.supersonic_useRewardedVideosMobile) == 1)
            {
               dataM.supersonic_useRewardedVideosMobile = true;
               dataM.supersonic_rewardedVideosMobile_maxPerDay = param1.general.supersonic_rewardedVideosMobile_maxPerDay;
               dataM.supersonic_rewardedVideosMobile_tokens = param1.general.supersonic_rewardedVideosMobile_tokens;
               dataM.supersonic_rewardedVideosMobile_gold = param1.general.supersonic_rewardedVideosMobile_gold;
            }
         }
         if(param1.general.useChatBlocks != null)
         {
            if(int(param1.general.useChatBlocks) == 1)
            {
               dataM.useChatBlocks = true;
            }
         }
         if(param1.general.useClientIsAlive != null)
         {
            if(int(param1.general.useClientIsAlive) == 1)
            {
               dataM.useClientIsAlive = true;
            }
         }
         if(param1.general.maxFreeItemBoxes != null)
         {
            dataM.maxFreeItemBoxes = param1.general.maxFreeItemBoxes;
            dataM.secondsForFreeItemBox = param1.general.secondsForFreeItemBox;
         }
         if(FeatureFlags.PLAYER_ENERGY)
         {
            dataM.battleCredits_missionCost_normal = param1.general.battleCredits_missionCost_normal;
            dataM.battleCredits_missionCost_hard = param1.general.battleCredits_missionCost_hard;
            dataM.battleCredits_missionCost_insane = param1.general.battleCredits_missionCost_insane;
            dataM.battleCredits_missionCost_boss = param1.general.battleCredits_missionCost_boss;
         }
         dataM.serverRestartTimeDisplay = 0;
         if(param1.general.serverRestartTimeDisplay != null)
         {
            dataM.serverRestartTimeDisplay = int(param1.general.serverRestartTimeDisplay);
         }
         if(param1.general.useExtraMusicTracksForMobile != null)
         {
            if(int(param1.general.useExtraMusicTracksForMobile) == 1)
            {
               dataM.useExtraMusicTracksForMobile = true;
            }
         }
         dataM.createMusicData();
         if(param1.general.usePersonaly != null)
         {
            if(int(param1.general.usePersonaly) == 1)
            {
               dataM.usePersonaly = true;
               dataM.personalyGeos = param1.general.personalyGeos.split(",");
            }
         }
         dataM.maxItemsPerOnePurchase = 1;
         if(param1.general.maxItemsPerOnePurchase != null)
         {
            dataM.maxItemsPerOnePurchase = param1.general.maxItemsPerOnePurchase;
         }
         dataM.floorBuff_damageAddon = param1.general.floorBuff_damageAddon;
         dataM.floorBuff_energyRegenerationAddon = param1.general.floorBuff_energyRegenerationAddon;
         dataM.floorBuff_heatCoolingAddon = param1.general.floorBuff_heatCoolingAddon;
         dataM.floorBuff_heatDamageAddon = param1.general.floorBuff_heatDamageAddon;
         dataM.floorBuff_energyDamageAddon = param1.general.floorBuff_energyDamageAddon;
         dataM.levelForExpandedItemBox = param1.general.levelForExpandedItemBox;
         dataM.supersonic_mobile_afterWins = param1.general.supersonic_mobile_afterWins;
         dataM.supersonic_mobile_SPMP = param1.general.supersonic_mobile_SPMP;
         dataM.goldPerToken = param1.general.goldPerToken;
         if(param1.general.ladderLevelsPerStar != null)
         {
            dataM.ladderRanksPerStar = param1.general.ladderLevelsPerStar;
         }
         dataM.dailyBonusOptions = new Array();
         if(param1.dailyBonusOptions != null)
         {
            dataM.dailyBonusOptions = param1.dailyBonusOptions;
         }
         dataM.dailyLoginStreakBonus = new Object();
         if(param1.dailyLoginStreakBonus != null)
         {
            dataM.dailyLoginStreakBonus = param1.dailyLoginStreakBonus;
         }
         dataM.dailyLoginStreakBonusMythical = false;
         if(param1.general.dailyLoginStreakBonusMythical != null)
         {
            if(int(param1.general.dailyLoginStreakBonusMythical) == 1)
            {
               dataM.dailyLoginStreakBonusMythical = true;
            }
         }
         dataM.sendTokens_allow = false;
         if(param1.general.sendTokens_allow != null)
         {
            if(int(param1.general.sendTokens_allow) == 1)
            {
               dataM.sendTokens_allow = true;
               dataM.sendTokens_tokensSpentRequired = param1.general.sendTokens_tokensSpentRequired;
               dataM.sendTokens_daysFromFirstPaymentRequired = param1.general.sendTokens_daysFromFirstPaymentRequired;
               dataM.sendTokens_minTokensToSend = param1.general.sendTokens_minTokensToSend;
            }
         }
         dataM.useChatRank1Channels = false;
         if(param1.general.useChatRank1Channels != null)
         {
            if(int(param1.general.useChatRank1Channels) == 1)
            {
               dataM.useChatRank1Channels = true;
            }
         }
         dataM.dailyLoginStreakData = param1.general.dailyLoginStreakData;
         dataM.useNameChange = false;
         if(param1.general.useNameChange != null)
         {
            if(int(param1.general.useNameChange) == 1)
            {
               dataM.useNameChange = true;
               dataM.nameChangeCostTokensBase = param1.general.nameChangeCostTokensBase;
               dataM.nameChangeCostTokensAddon = param1.general.nameChangeCostTokensAddon;
            }
         }
         if(param1.general.showMythicalsStats != null)
         {
            if(int(param1.general.showMythicalsStats) == 1)
            {
               dataM.showMythicalsStats = true;
            }
         }
         dataM.destroyMechDamageAddon = int(param1.general.destroyMechDamageAddon);
         dataM.levelRequired3V3 = int(param1.general.levelRequired3V3);
         dataM.useMultipleMechsKitsFix = false;
         if(param1.general.useMultipleMechsKitsFix != null)
         {
            if(int(param1.general.useMultipleMechsKitsFix) == 1)
            {
               dataM.useMultipleMechsKitsFix = true;
            }
         }
         if(dataM.runAsMobile)
         {
            if(param1.general.useRateBox != null)
            {
               if(int(param1.general.useRateBox) == 1)
               {
                  dataM.useRateBox = true;
                  dataM.rateBoxRankRequired = int(param1.general.rateBoxRankRequired);
               }
            }
         }
         dataM.missionUpgrade_hpRatio = param1.general.missionUpgrade_hpRatio;
         dataM.missionUpgrade_energyRatio = param1.general.missionUpgrade_energyRatio;
         dataM.missionUpgrade_heatRatio = param1.general.missionUpgrade_heatRatio;
         dataM.missionUpgrade_ammoRatio = param1.general.missionUpgrade_ammoRatio;
         dataM.missionBuy1HardTokensCost = param1.general.missionBuy1HardTokensCost;
         dataM.missionBuy6HardTokensCost = param1.general.missionBuy6HardTokensCost;
         dataM.missionBuy1InsaneTokensCost = param1.general.missionBuy1InsaneTokensCost;
         dataM.missionBuy6InsaneTokensCost = param1.general.missionBuy6InsaneTokensCost;
      }
      
      private function getInitialData_startLoadingItems(param1:Event) : void
      {
         trace("getInitialData_startLoadingItems counter:" + this.counter);
         if(this.counter == 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.getInitialData_startLoadingItems);
            this.doGetInitialData_setItems(this.doGetInitialDataMidWorkData);
         }
         else
         {
            --this.counter;
         }
      }
      
      private function doGetInitialData_setItems(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:ItemCache = null;
         var _loc5_:String = null;
         dataM.itemsDB_online = new Object();
         dataM.itemsMaxLevelsDB = new Object();
         for each(_loc2_ in dataM.subTypeDB)
         {
            switch(_loc2_.name)
            {
               case "itemBox1":
               case "itemBox2":
               case "itemBox3":
                  break;
               case "mythical":
                  _loc2_.unlockLevel = 3;
                  break;
               default:
                  _loc2_.unlockLevel = 999;
            }
         }
         _loc3_ = param1.items;
         _loc4_ = ItemCache.gi();
         if(!_loc3_)
         {
            if(_loc4_.getVersion() == null)
            {
               _loc4_.deleteCache();
               throw new Error("No items in request and in cache");
            }
         }
         if(_loc3_)
         {
            TsLogger.log("Items are fresh");
            this.doGetInitialData_parseItems(_loc3_);
            _loc5_ = param1.itemsVersion;
            if((Boolean(_loc5_)) && _loc5_ != _loc4_.getVersion())
            {
               this.doGetInitialDataMidWorkData = param1;
               this.itemDBDumper = _loc4_.getItemDBDumper(dataM.itemsDB_online);
               addEventListener(Event.ENTER_FRAME,this.continueProcessingItemDump);
            }
            dataM.resetItemsCache();
            dataM.setItemsCategoriesData(true);
            this.continueGetInitialDataAfterItemLoad(param1);
         }
         else
         {
            TsLogger.log("Items are from cache");
            this.doGetInitialDataMidWorkData = param1;
            this.itemDBLoader = _loc4_.getItemDBLoader();
            addEventListener(Event.ENTER_FRAME,this.continueProcessingItemLoad);
         }
      }
      
      private function continueProcessingItemLoad(param1:Event) : *
      {
         var doneProcessing:Boolean = false;
         var itemLoaderResult:Vector.<BMItemData> = null;
         var event:Event = param1;
         try
         {
            doneProcessing = this.itemDBLoader.process(1000);
         }
         catch(err:Error)
         {
            ItemCache.gi().deleteCache();
            throw err;
         }
         if(doneProcessing)
         {
            removeEventListener(Event.ENTER_FRAME,this.continueProcessingItemLoad);
            itemLoaderResult = this.itemDBLoader.getResult();
            if(this.itemDBLoader.getResult().length == 0 || itemLoaderResult[0] == null)
            {
               ItemCache.gi().deleteCache();
               throw new Error("Unable to load items");
            }
            dataM.itemsDB_online = ItemCache.gi().getItemsDB(this.itemDBLoader);
            dataM.itemsMaxLevelsDB = ItemCache.gi().getItemsMaxLevelsDB();
            dataM.subTypeDB = ItemCache.gi().getItemsSubTypeDB();
            this.continueGetInitialDataAfterItemLoad(this.doGetInitialDataMidWorkData);
            this.doGetInitialDataMidWorkData = null;
            this.itemDBLoader = null;
            dataM.resetItemsCache();
            dataM.setItemsCategoriesData(true);
         }
      }
      
      private function continueProcessingItemDump(param1:Event) : *
      {
         var _loc2_:Boolean = this.itemDBDumper.process(100);
         if(_loc2_)
         {
            removeEventListener(Event.ENTER_FRAME,this.continueProcessingItemDump);
            if(this.itemDBDumper.getResult().length == 0)
            {
               throw new Error("Unable to dump items");
            }
            ItemCache.gi().setItems(this.doGetInitialDataMidWorkData.itemsVersion,dataM.itemsDB_online,this.itemDBDumper,dataM.itemsMaxLevelsDB,dataM.subTypeDB);
            this.doGetInitialDataMidWorkData = null;
            this.itemDBDumper = null;
         }
      }
      
      private function doGetInitialData_settingsAndProfile(param1:Object) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerProfile = null;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Date = null;
         var _loc12_:Date = null;
         var _loc13_:uint = 0;
         var _loc14_:Object = null;
         var _loc15_:BMGachaMachineData = null;
         dataM.currentTime = int(param1.general.currentTime);
         if(dataM.serverRestartTimeDisplay > dataM.currentTime)
         {
            screensM.addScreen("screenServerRestartCountdown");
            screensM.screenServerRestartCountdown.refreshScreen();
         }
         dataM.searchForBattleLevelChangeSeconds = param1.general.searchForBattleLevelChangeSeconds;
         dataM.turnsForQuitPenalty = int(param1.general.turnsForQuitPenalty);
         dataM.advancedMatchmakingBlockLevel = int(param1.general.advancedMatchmakingBlockLevel);
         dataM.ladderProgressBase = int(param1.general.ladderProgressBase);
         dataM.ladderRankMax = int(param1.general.ladderLevelMax);
         dataM.weightMax = int(param1.general.weightMax);
         dataM.rewardSPWinGold = int(param1.general.rewardSPWinGold);
         dataM.rewardSPWinXP = int(param1.general.rewardSPWinXP);
         dataM.rewardMPWinGold = int(param1.general.rewardMPWinGold);
         dataM.rewardMPWinXP = int(param1.general.rewardMPWinXP);
         dataM.rewardSPLoseGold = int(param1.general.rewardSPLoseGold);
         dataM.rewardSPLoseXP = int(param1.general.rewardSPLoseXP);
         dataM.rewardMPLoseGold = int(param1.general.rewardMPLoseGold);
         dataM.rewardMPLoseXP = int(param1.general.rewardMPLoseXP);
         dataM.battleCreditsMax = int(param1.general.battleCreditsMax);
         dataM.secondsForNewBattleCredit = int(param1.general.secondsForNewBattleCredit);
         dataM.bonusTokensPerLevelUp = int(param1.general.bonusTokensPerLevelUp);
         dataM.bonusTokensForLevel3 = int(param1.general.bonusTokensForLevel3);
         dataM.clanMaxMembers = int(param1.general.clanMaxMembers);
         dataM.createClanCost = int(param1.general.createClanCost);
         dataM.freeTokens_amount = int(param1.general.freeTokens_amount);
         dataM.freeTokens_cooldown = int(param1.general.freeTokens_cooldown);
         if(param1.general.missionReviveTokensCost != null)
         {
            dataM.missionReviveTokensCost = int(param1.general.missionReviveTokensCost);
         }
         dataM.advertisingCampaignID = param1.general.advertisingCampaignID;
         if(param1.general.activeBoosts != null)
         {
            dataM.activeBoosts = param1.general.activeBoosts.split(",");
            dataM.activeBoostsMobile = param1.general.activeBoostsMobile.split(",");
         }
         if(param1.general.resetBoostsDate != null)
         {
            BMSpecialOffersManager.gi().specialOffersResetTime = int(param1.general.resetBoostsDate);
         }
         if(param1.general.clanWinsGiveReward != null)
         {
            if(int(param1.general.clanWinsGiveReward) == 1)
            {
               dataM.clanWinsGiveReward = true;
            }
            dataM.clanWinsRewardType = param1.general.clanWinsRewardType;
            dataM.clanWinsRewardValue = int(param1.general.clanWinsRewardValue);
            dataM.clanWinsWinsRequired = int(param1.general.clanWinsWinsRequired);
         }
         dataM.weeklyTopClanRewards = new Array();
         if(param1.general.weeklyTopClanRewards != null)
         {
            _loc8_ = param1.general.weeklyTopClanRewards;
            dataM.weeklyTopClanRewards = _loc8_.split(",");
            if(dataM.weeklyTopClanRewards.length > 0)
            {
               _loc9_ = dataM.weeklyTopClanRewards.length - 1;
               while(_loc9_ >= 0)
               {
                  _loc10_ = Number(dataM.weeklyTopClanRewards[_loc9_]);
                  if(dataM.itemsDB_online[_loc10_] == null)
                  {
                     dataM.weeklyTopClanRewards.splice(_loc9_,1);
                  }
                  _loc9_--;
               }
            }
         }
         dataM.createLadderProgressData();
         var _loc2_:Number = 0;
         for each(_loc3_ in param1.experience)
         {
            _loc2_++;
            dataM.levelUpDB[_loc2_] = _loc3_;
         }
         _loc4_ = param1.playerProfile.name;
         _loc5_ = uint(param1.playerProfile.level);
         dataM.createProfile(dataM.ONLINE_PLAYER_ID,_loc4_,_loc5_);
         _loc6_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         _loc6_.userName = dataM.userName;
         _loc6_.playerName = param1.playerProfile.name;
         _loc6_.gold = param1.playerProfile.gold;
         _loc6_.geo = param1.playerProfile.geo;
         _loc6_.initialSelectedMechID = uint(param1.playerProfile.selectedMechIDs.substr(0,1));
         _loc6_.tokens = param1.playerProfile.bonusTokens + param1.playerProfile.supporterTokens;
         _loc6_.tokens_supporter = param1.playerProfile.supporterTokens;
         _loc6_.tokens_bonus = param1.playerProfile.bonusTokens;
         _loc6_.timeToFirstPayment = param1.playerProfile.timeToFirstPayment;
         _loc6_.tokensSpent = param1.playerProfile.tokensSpent;
         _loc6_.gotFreeTokensDate = param1.gotFreeTokensDate;
         dataM.DISPLAY_GET_TOKENS_COUNTER_MAX = 6;
         if(_loc6_.tokensSpent > 100)
         {
            if(_loc6_.tokensSpent > 1000)
            {
               if(_loc6_.tokensSpent > 5000)
               {
                  dataM.DISPLAY_GET_TOKENS_COUNTER_MAX = 60;
               }
               else
               {
                  dataM.DISPLAY_GET_TOKENS_COUNTER_MAX = 20;
               }
            }
            else
            {
               dataM.DISPLAY_GET_TOKENS_COUNTER_MAX = 12;
            }
         }
         if(param1.notificationsData != null)
         {
            _loc6_.addNotificationsData(param1.notificationsData);
         }
         if(param1.starterPackData != null)
         {
            if(param1.starterPackData.costTokens == null)
            {
               _loc6_.setStarterPackData(param1.starterPackData);
            }
         }
         var _loc7_:String = param1.playerProfile.lastLogin;
         if(_loc7_ != null)
         {
            _loc11_ = dataM.convertStringIntoDate(_loc7_);
            _loc12_ = new Date();
            dataM.serverTimeDifferece = Math.floor((_loc12_.getTime() - _loc11_.getTime()) / 1000);
         }
         _loc6_.XP = param1.playerProfile.XP;
         _loc6_.level = param1.playerProfile.level;
         _loc6_.ladderProgress = param1.playerProfile.ladderProgress;
         _loc6_.onlineWins = param1.playerProfile.onlineWins;
         _loc6_.onlineBattles = param1.playerProfile.onlineBattles;
         _loc6_.battlesVSComputer = param1.playerProfile.battlesVSComputer;
         _loc6_.winsVSComputer = param1.playerProfile.winsVSComputer;
         _loc6_.winLossStreak = param1.playerProfile.winLossStreak;
         _loc6_.lastNewsID = param1.playerProfile.lastNewsID;
         _loc6_.lastNewsIDBeforeLogin = param1.playerProfile.lastNewsID;
         _loc6_.totalGoldGained = param1.playerProfile.totalGoldGained;
         _loc6_.lastLevel = _loc6_.level;
         _loc6_.gameSettings = param1.playerProfile.settings;
         _loc6_.tutorialLevel = param1.playerProfile.tutorialLevel;
         _loc6_.lastLadderProgress = _loc6_.ladderProgress;
         _loc6_.setBattleCredits(param1.playerProfile.battleCredits,"InitialData");
         _loc6_.missionID = param1.playerProfile.missionID;
         _loc6_.missionsCompleted = param1.playerProfile.missionsCompleted;
         _loc6_.missionsCompletedAtLastChallenge = _loc6_.missionsCompleted;
         _loc6_.pendingStarterPackMech = param1.playerProfile.pendingStarterPackMech;
         _loc6_.clan_tryingToJoinClanID = param1.requestedToJoinClanID;
         _loc6_.rateStatus = param1.playerProfile.rateStatus;
         _loc6_.dailyLoginStreak = param1.playerProfile.dailyLoginStreak;
         _loc6_.setMapProgress(param1.playerProfile.mapProgress);
         if(param1.playerProfile.playTime != null)
         {
            _loc6_.playTime = param1.playerProfile.playTime;
         }
         if(param1.playerProfile.firstSessionDate != null)
         {
            _loc6_.firstSessionDate = param1.playerProfile.firstSessionDate;
         }
         if(int(param1.playerProfile.ageVerification) == 1)
         {
            _loc6_.ageVerification = true;
         }
         _loc6_.nameChanges = param1.statistics.nameChanges;
         _loc6_.ladderWins = param1.statistics.ladderWins;
         _loc6_.setFreePackages(param1.freeBoosts);
         dataM.useFreeItemBoxes = false;
         if(param1.freeItemBoxes != null)
         {
            dataM.useFreeItemBoxes = true;
            _loc6_.freeItemBoxes = int(param1.freeItemBoxes);
            _loc6_.gotFreeItemBox = int(param1.gotFreeItemBox);
         }
         dataM.gachaMachinesArray = new Array();
         if(FeatureFlags.GACHA_MACHINES)
         {
            _loc13_ = 0;
            while(_loc13_ < param1.gachaMachinesData.length)
            {
               _loc14_ = param1.gachaMachinesData[_loc13_];
               _loc15_ = new BMGachaMachineData(_loc14_.gachaMachineID,_loc14_.name,_loc14_.description,_loc14_.costGold,_loc14_.costTokens,_loc14_.costTokensDefault,_loc14_.imageID);
               dataM.gachaMachinesArray.push(_loc15_);
               _loc13_++;
            }
         }
         dataM._createGacheMachineDBfromArray();
         dataM.lastBattleCreditAddon = param1.playerProfile.lastBattleCreditAddon + 5;
         if(_loc6_.tutorialLevel >= BMTutorialManager.TUTORIAL_LEVEL_COMPLETED)
         {
            dataM.tutorialSkipped = true;
         }
         if(param1.playerProfile.isAdmin == 1)
         {
            _loc6_.isAdmin = true;
         }
         _loc6_.overallRank = param1.overallRank;
         dataM.premiumAccountTime = int(param1.playerProfile.dPremium);
         if(int(param1.playerProfile.facebook) == 1)
         {
            dataM.lastLoginFromFacebook = true;
            _loc6_.facebook = true;
         }
         _loc6_.updateWinsTotal();
         _loc6_.playersJoinedByInvitation = param1.playerProfile.playersJoinedByInvitation;
         _loc6_.avatarLink = param1.playerProfile.avatarLink;
         _loc6_.clanID = 0;
         if(param1.myClanData != null)
         {
            _loc6_.updateClanData(param1.myClanData);
         }
         dataM.breathingEffect = _loc6_.getSettingAsBoolean("breathing");
         dataM.movieClipParticleEffectsLevel = _loc6_.getSetting("particles");
         dataM.seeOpponentPerks = _loc6_.getSettingAsBoolean("seePerks");
         dataM.refreshMovieClipParticlesRatio();
         soundM.setMusic(_loc6_.getSettingAsBoolean("music"),false);
         soundM.setSound(_loc6_.getSettingAsBoolean("sound"));
         switch(_loc6_.getSetting("quality"))
         {
            case 0:
               screensM.stagePointer.quality = StageQuality.LOW;
               break;
            case 1:
               screensM.stagePointer.quality = StageQuality.MEDIUM;
               break;
            case 2:
               screensM.stagePointer.quality = StageQuality.HIGH;
               break;
            case 3:
               screensM.stagePointer.quality = StageQuality.BEST;
         }
      }
      
      private function doGetInitialData_inventory(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc5_:BMItemData = null;
         var _loc6_:Boolean = false;
         var _loc7_:uint = 0;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         dataM["playerData" + dataM.ONLINE_PLAYER_ID + "Inventory"] = new Array();
         var _loc3_:Object = dataM["playerData" + dataM.ONLINE_PLAYER_ID + "Inventory"];
         this._getInitialData_inventorySize = 0;
         for each(_loc4_ in param1.inventory)
         {
            if(dataM.itemsDB_online[_loc4_.itemID] != null)
            {
               _loc5_ = dataM.itemsDB_online[_loc4_.itemID];
               _loc6_ = false;
               if(_loc5_.type == "kit" && _loc5_.subType != "power")
               {
                  _loc6_ = true;
               }
               if(_loc6_ == false)
               {
                  if(_loc5_.type == "perk")
                  {
                     _loc2_.hasPerks = true;
                  }
                  _loc4_.equipmentID = 0;
                  _loc4_.type = _loc5_.type;
                  _loc4_.weight = 0;
                  _loc4_.weight = _loc5_.weight;
                  if(int(_loc4_.equipped) > 0)
                  {
                     switch(_loc5_.type)
                     {
                        case "sideWeapon":
                        case "topWeapon":
                        case "kit":
                        case "module":
                           _loc7_ = uint(int(_loc4_.slotName.substr(_loc4_.slotName.length - 1,1)));
                           _loc4_.equipmentID = _loc7_;
                     }
                  }
                  _loc3_[_loc4_.playerItemID] = _loc4_;
                  ++this._getInitialData_inventorySize;
               }
            }
         }
      }
      
      private function doGetInitialData_achievements(param1:Object) : void
      {
         var _loc2_:Object = null;
         dataM.achievementsDB = new Object();
         for each(_loc2_ in param1.achievements)
         {
            dataM.achievementsDB[_loc2_.achievementID] = _loc2_;
         }
         dataM.sortAchievements();
      }
      
      private function doGetInitialData_newsAndSales(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:BMNewsData = null;
         var _loc7_:Boolean = false;
         var _loc8_:BMNewsData = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Object = null;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         dataM.newsDB = new Object();
         this._getInitialData_highestNewsID = 0;
         for each(_loc3_ in param1.news)
         {
            _loc7_ = true;
            if(_loc3_.deviceTag != null)
            {
               if(_loc3_.deviceTag > 0)
               {
                  if(dataM.runAsMobile)
                  {
                     if(_loc3_.deviceTag != 3)
                     {
                        _loc7_ = false;
                     }
                  }
                  else if(_loc3_.deviceTag != 1)
                  {
                     _loc7_ = false;
                  }
               }
            }
            if(_loc7_)
            {
               if(_loc3_.imageUrl != "" && _loc3_.category > 0 || _loc3_.newsTitle != null && _loc3_.newsText != null)
               {
                  _loc8_ = new BMNewsData(_loc3_.newsID,_loc3_.newsTitle,_loc3_.newsText,_loc3_.dDate,dataM.convertStringIntoDate(_loc3_.dDate),_loc3_.imageUrl,_loc3_.category,_loc3_.clickTarget,_loc3_.clickTargetItemID);
                  dataM.newsDB[_loc3_.newsID] = _loc8_;
                  if(this._getInitialData_highestNewsID < _loc3_.newsID)
                  {
                     this._getInitialData_highestNewsID = _loc3_.newsID;
                  }
               }
            }
         }
         _loc4_ = [BMDataManager.NEWS_CATEGORY_SALE];
         _loc5_ = new Object();
         for each(_loc6_ in dataM.newsDB)
         {
            if(_loc4_.indexOf(_loc6_.category) >= 0)
            {
               if(_loc5_.hasOwnProperty(_loc6_.category))
               {
                  _loc9_ = uint(_loc5_[_loc6_.category]);
                  if(_loc9_ < _loc6_.newsID)
                  {
                     _loc5_[_loc6_.category] = _loc6_.newsID;
                  }
               }
               else
               {
                  _loc5_[_loc6_.category] = _loc6_.newsID;
               }
            }
         }
         for each(_loc6_ in dataM.newsDB)
         {
            if(_loc4_.indexOf(_loc6_.category) >= 0)
            {
               _loc10_ = uint(_loc5_[_loc6_.category]);
               if(_loc10_ > _loc6_.newsID)
               {
                  delete dataM.newsDB[_loc6_.newsID];
               }
            }
         }
         if(_loc2_.lastNewsID > this._getInitialData_highestNewsID)
         {
            _loc2_.lastNewsID = this._getInitialData_highestNewsID;
         }
         if(param1.sales != null)
         {
            var _loc12_:int = 0;
            var _loc13_:* = param1.sales;
            for each(_loc11_ in _loc13_)
            {
               BMSalesManager.gi().setSale(_loc11_);
            }
         }
      }
      
      private function doGetInitialData_clanRequests(param1:Object) : void
      {
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         _loc2_.clan_playersRequestedToJoin = new Array();
         if(param1.clanPlayerRequests != null)
         {
            _loc2_.clan_playersRequestedToJoin = param1.clanPlayerRequests;
         }
      }
      
      private function doGetInitialData_userStatstics(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param1.usersStatistics != null)
         {
            _loc2_ = param1.usersStatistics.usersOnline;
            _loc3_ = Number(param1.usersStatistics.usersInBattleBySearching);
            _loc4_ = Number(param1.usersStatistics.usersInBattleByInvitation);
            _loc5_ = Number(param1.usersStatistics.usersInBattleVSComputer);
            _loc6_ = Number(param1.usersStatistics.usersSearching);
            dataM.updateUsersStatistics(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_);
         }
      }
      
      private function doGetInitialData_rankingLists(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:BMPlayerRankingListData = null;
         dataM.rankingList_allTime = new Object();
         for each(_loc2_ in param1.topRankings)
         {
            _loc3_ = new BMPlayerRankingListData();
            _loc3_.playerID = _loc2_.playerID;
            _loc3_.isOnline = _loc2_.online;
            _loc3_.playerName = dataM.getCensoredString(_loc2_.name);
            _loc3_.ladderProgress = _loc2_.ladderProgress;
            _loc3_.level = _loc2_.level;
            _loc3_.clanID = _loc2_.clanID;
            _loc3_.winLossStreak = _loc2_.winLossStreak;
            _loc3_.overallRank = _loc2_.rank;
            _loc3_.onlineBattles = _loc2_.onlineBattles;
            _loc3_.onlineWins = _loc2_.onlineWins;
            _loc3_.geo = _loc2_.geo;
            _loc3_.overallRankLast = _loc3_.overallRank;
            dataM.rankingList_allTime[_loc2_.playerID] = _loc3_;
         }
         dataM.clansRankingList = new Object();
      }
      
      private function doGetInitialData_boostsAndTokenPackages(param1:Object) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:BMBoostData = null;
         var _loc6_:Object = null;
         var _loc7_:Boolean = false;
         var _loc8_:BMTokenPackage = null;
         var _loc9_:int = 0;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         var _loc3_:uint = 1;
         while(_loc3_ <= 25)
         {
            if(param1.boosts != null)
            {
               if(param1.boosts[_loc3_] != null)
               {
                  _loc4_ = Number(param1.boosts[_loc3_].boostID);
                  if(dataM.boostsDB[_loc4_] != null)
                  {
                     _loc5_ = dataM.boostsDB[_loc4_];
                     _loc5_.boostID = _loc4_;
                     _loc5_.type = param1.boosts[_loc3_].type;
                     _loc5_.costTokens = param1.boosts[_loc3_].costTokens;
                     _loc5_.costTokensDefault = param1.boosts[_loc3_].costTokensDefault;
                     _loc5_.costGold = param1.boosts[_loc3_].costGold;
                     _loc5_.costGoldMaxLevel = param1.boosts[_loc3_].costGoldMaxLevel;
                     _loc5_.goldAddonPerLevel = param1.boosts[_loc3_].goldAddonPerLevel;
                     _loc5_.itemID = param1.boosts[_loc3_].itemID;
                     _loc5_.itemType = param1.boosts[_loc3_].itemType;
                     _loc5_.bonusGold = param1.boosts[_loc3_].bonusGold;
                     _loc5_.amount = param1.boosts[_loc3_].amount;
                     _loc5_.levelDifference = param1.boosts[_loc3_].levelDifference;
                     _loc5_.ratioRare = param1.boosts[_loc3_].ratioRare;
                     _loc5_.ratioEpic = param1.boosts[_loc3_].ratioEpic;
                     _loc5_.ratioLegendary = param1.boosts[_loc3_].ratioLegendary;
                     _loc5_.ratioMythical = param1.boosts[_loc3_].ratioMythical;
                     _loc5_.ratioNewMythical = param1.boosts[_loc3_].ratioNewMythical;
                     _loc5_.ratioRareDefault = param1.boosts[_loc3_].ratioRareDefault;
                     _loc5_.ratioEpicDefault = param1.boosts[_loc3_].ratioEpicDefault;
                     _loc5_.ratioLegendaryDefault = param1.boosts[_loc3_].ratioLegendaryDefault;
                     _loc5_.ratioMythicalDefault = param1.boosts[_loc3_].ratioMythicalDefault;
                     _loc5_.ratioNewMythicalDefault = param1.boosts[_loc3_].ratioNewMythicalDefault;
                     _loc5_.ratioPowerKit = param1.boosts[_loc3_].ratioPowerKit;
                     if(_loc2_.isAdmin)
                     {
                        _loc5_.bought = param1.boosts[_loc3_].bought;
                     }
                  }
               }
            }
            _loc3_++;
         }
         if(param1.tokenPackages != null)
         {
            dataM.allTokenPackages = new Array();
            for each(_loc6_ in param1.tokenPackages)
            {
               if(_loc6_.isActive == 1)
               {
                  _loc7_ = false;
                  if(_loc6_.platformID == 3)
                  {
                     _loc7_ = true;
                  }
                  if(_loc7_)
                  {
                     _loc8_ = new BMTokenPackage();
                     _loc9_ = int(_loc6_.sortID);
                     if(dataM.isPayingUser())
                     {
                        _loc9_ = int(_loc6_.buyerSortID);
                     }
                     _loc8_.initialize(_loc6_.packageID,_loc6_.platformID,_loc9_,_loc6_.tokenSystemPackageID,_loc6_.starterPackID,_loc6_.visualID,_loc6_.specialBanner,_loc6_.price,_loc6_.title,_loc6_.tokens,_loc6_.bonusFromTokens);
                     dataM.allTokenPackages.push(_loc8_);
                  }
               }
            }
            dataM.syncPlatformStoreProducts();
            dataM.allTokenPackages.sortOn("sortID",Array.NUMERIC);
         }
      }
      
      private function doGetInitialData_loadQuests(param1:Object) : void
      {
         dataM.questsManager.parseQuestData(param1["questsData"]);
         dataM.questsManager.parsePlayerQuestData(param1["questsProgress"],param1["playerDailyQuestData"],param1["playerAchievementsQuestData"]);
         dataM.questsManager.dailyQuestsLastResetTime = int(param1.general.dailyQuestsLastResetTime);
      }
      
      private function doGetInitialData_finalFunctions(param1:Object) : void
      {
         TsLogger.log("doGetInitialData_finalFunctions");
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         this._fixingAddItemsForNewPlayer = false;
         if(dataM.allowNameChangeAfterRegister || _loc2_.winsVSComputer == 0)
         {
            BMLoadingTimer.gi().hideLoading();
            if(dataM.register_termsOfUseChecked)
            {
               BMLoginManager.gi().loginType = BMLoginManager.LOGIN_TYPE_EXISTING_USER;
               if(_loc2_.tutorialLevel >= BMTutorialManager.TUTORIAL_LEVEL_COMPLETED)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("changePlayerName_online",-1,-1);
                  dataM.register_termsOfUseChecked = false;
               }
               if(screensM.isScreenOpened("screenWelcomeNewExisting"))
               {
                  screensM.screenWelcomeNewExisting.removeMechs();
               }
               screensM.removeScreen("screenWelcomeNewExisting");
            }
            else
            {
               BMLoginManager.gi().loginType = BMLoginManager.LOGIN_TYPE_NEW_USER;
               if(screensM.isScreenOpened("screenWelcomeBackground"))
               {
                  BMLoadingTimer.gi().hideLoading();
                  screensM.addIfNotOpened("screenWelcomeNewExisting");
                  screensM.screenWelcomeNewExisting.refreshScreen();
               }
               else if(_loc2_.tutorialLevel >= BMTutorialManager.TUTORIAL_LEVEL_COMPLETED)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("changePlayerNameAndTermsOfUse_online",-1,-1);
               }
            }
            dataM.allowNameChangeAfterRegister = false;
            if(dataM.clientRunningLocally == false)
            {
               dataM.resetGuestSharedObject("socketM getInitialData");
            }
         }
         else
         {
            if(screensM.isScreenOpened("screenWelcomeNewExisting"))
            {
               screensM.screenWelcomeNewExisting.removeMechs();
            }
            screensM.removeScreen("screenWelcomeNewExisting");
            if(_loc2_.level == 1)
            {
               if(_loc2_.winsVSComputer == 1)
               {
                  if(this._getInitialData_inventorySize == 3)
                  {
                     this._fixingAddItemsForNewPlayer = true;
                  }
               }
            }
            screensM.startCurrentTimeTimer();
         }
         if(dataM.rerunLoginManager_gotPlayerData)
         {
            dataM.rerunLoginManager_gotPlayerData = false;
            BMLoginManager.gi().gotPlayerData();
         }
         else
         {
            BMLoginManager.gi().endLoginFlow();
         }
         if(dataM.setLastNewsIDForANewUser)
         {
            _loc2_.lastNewsID = this._getInitialData_highestNewsID;
            this.lobby_setLastNewsID(this._getInitialData_highestNewsID);
            dataM.setLastNewsIDForANewUser = false;
         }
         if(dataM.runAsMobile)
         {
            _loc2_.lastDevice = "2";
         }
         else
         {
            _loc2_.lastDevice = "0";
         }
         this.lobby_setLastDevice(_loc2_.lastDevice);
         dataM.loadPerUserSharedObjectData();
         BMSpecialOffersManager.gi().refreshSpecialOffersBoostIDs();
      }
      
      private function doGetInitialData_clientOutOfDate() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("clientIsNotUpToDate",-1,-1);
         BMLoadingTimer.gi().hideLoading();
         screensM.btnDebugger.visible = true;
         if(screensM.isScreenOpened("screenDebugger"))
         {
            screensM.screenDebugger.addTrace("WARNING : " + externalAssetsM.clientNotUpToDateMessage);
         }
      }
      
      private function doGetInitialData_parseItems(param1:Object) : void
      {
         var _loc3_:BMItemData = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc8_:Object = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:* = undefined;
         var _loc12_:int = 0;
         var _loc13_:Object = null;
         var _loc14_:String = null;
         var _loc15_:Array = null;
         var _loc16_:BMItemData = null;
         var _loc2_:Object = param1;
         var _loc7_:Object = new Object();
         for each(_loc8_ in _loc2_)
         {
            _loc13_ = _loc8_.data;
            _loc3_ = this.createItemDataFromData(_loc13_,_loc7_);
            dataM.itemsDB_online[_loc3_.itemID] = _loc3_;
            _loc4_ = _loc3_.type;
            _loc5_ = _loc3_.level;
            _loc6_ = _loc4_;
            if(_loc4_ == "kit")
            {
               if(_loc3_.HPBase > 0)
               {
                  _loc6_ = "kit_repair";
               }
               else if(_loc3_.energyBase > 0)
               {
                  _loc6_ = "kit_energy";
               }
               else if(_loc3_.heatBase > 0)
               {
                  _loc6_ = "kit_heat";
               }
               else if(_loc3_.bullets > 0)
               {
                  _loc6_ = "kit_bullets";
               }
               else if(_loc3_.rockets > 0)
               {
                  _loc6_ = "kit_rockets";
               }
               else if(_loc3_.resist1 > 0 || _loc3_.resist2 > 0 || _loc3_.resist3 > 0)
               {
                  _loc6_ = "kit_resistance";
               }
               else
               {
                  _loc6_ = "kit_power";
               }
            }
            else if(_loc4_ == "module")
            {
               if(_loc3_.HPBase > 0)
               {
                  _loc6_ = "module_armor";
               }
               else if(_loc3_.energyBase > 0 || Boolean(_loc3_.energyAddon))
               {
                  _loc6_ = "module_energy";
               }
               else if(_loc3_.heatBase > 0 || Boolean(_loc3_.heatAddon))
               {
                  _loc6_ = "module_heat";
               }
               else if(_loc3_.bullets > 0 && _loc3_.rockets > 0)
               {
                  _loc6_ = "module_bulletsAndRockets";
               }
               else if(_loc3_.bullets > 0)
               {
                  _loc6_ = "module_bullets";
               }
               else if(_loc3_.rockets > 0)
               {
                  _loc6_ = "module_rockets";
               }
               else if(_loc3_.resist1 > 0 || _loc3_.resist2 > 0 || _loc3_.resist3 > 0)
               {
                  _loc6_ = "module_resistance";
               }
            }
            if(_loc4_ != "itemsBox" && _loc3_.specialStatus != 10)
            {
               if(dataM.itemsMaxLevelsDB[_loc6_] == null)
               {
                  dataM.itemsMaxLevelsDB[_loc6_] = _loc5_;
               }
               else if(dataM.itemsMaxLevelsDB[_loc6_] < _loc5_)
               {
                  dataM.itemsMaxLevelsDB[_loc6_] = _loc5_;
               }
            }
            _loc14_ = _loc3_.subType;
            switch(_loc3_.type)
            {
               case "sideWeapon":
               case "topWeapon":
               case "module":
               case "kit":
                  _loc14_ = _loc3_.type + "_" + _loc14_;
            }
            if(_loc3_.type != "perk")
            {
               if(dataM.subTypeDB[dataM.subTypeOriginDB[_loc14_]].unlockLevel > _loc3_.level)
               {
                  dataM.subTypeDB[dataM.subTypeOriginDB[_loc14_]].unlockLevel = _loc3_.level;
               }
            }
         }
         _loc9_ = [];
         for(_loc10_ in _loc7_)
         {
            _loc9_.push(int(_loc10_));
         }
         _loc9_.sort();
         _loc11_ = 0;
         for each(_loc12_ in _loc9_)
         {
            _loc15_ = _loc7_[_loc12_];
            for each(_loc16_ in _loc15_)
            {
               _loc16_.finalSortID = _loc11_;
               _loc11_++;
            }
         }
      }
   }
}

