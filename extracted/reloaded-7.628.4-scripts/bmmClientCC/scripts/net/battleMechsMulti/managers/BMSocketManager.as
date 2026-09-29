package net.battleMechsMulti.managers
{
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.utils.Dictionary;
   import net.battleMechsMulti.data.BMBattleResultData;
   import net.battleMechsMulti.data.BMBoostConfigDB;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.data.BMLevelUpData;
   import net.battleMechsMulti.data.BMMissionDefinitionRepository;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.ItemCache;
   import net.battleMechsMulti.data.ItemDBDumper;
   import net.battleMechsMulti.data.ItemDBLoader;
   import net.battleMechsMulti.managers.inventory.InventorySizeState;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMGoldPackageData;
   import net.battleMechsMulti.managers.shop.BMMechShopData;
   import net.battleMechsMulti.managers.shop.BMPremiumPackageData;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.managers.specialOffers.BMOneTimeSpecialOffersManager;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMPlayerRankingListData;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.mobiles.itemComparison.BMOneClickBoostProperties;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.clan.BMClanRewardData;
   import net.battleMechsMulti.screens.shop.BMClanShopData;
   import net.battleMechsMulti.screens.worldMap.BMWorldMapHarvestData;
   import net.battleMechsMulti.session.BMDomainResolver;
   import net.battleMechsMulti.session.BMPlatformUtils;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.ExternalInterfaceWrapper;
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
      
      private var _buyGacha_amount:uint;
      
      private var _claimBoost_boostID:Number;
      
      public var sellingMultipleItems:Boolean = false;
      
      public var currentDomain:String;
      
      public var flashVars:BMMClientFlashVars;
      
      private var _fixingAddItemsForNewPlayer:Boolean = false;
      
      private var _lastMsgSent:Object;
      
      private var _getInitialData_inventorySize:uint = 0;
      
      private var _itemsDataForNextLoad:Object = null;
      
      private var _itemsDataIsCompact:Boolean = false;
      
      private var _resetGuestData:Boolean = false;
      
      private var _loadExternalLibraryWhenGetInitialDataIsOver:Boolean = false;
      
      private var _mechsNewLocations:Array;
      
      public var itemDBDumper:ItemDBDumper = null;
      
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
            this.bgSocket.removeEventListener(BGSocketEvent.DATA_PROGRESS,this.onDataProgress);
            this.bgSocket.addStatusFunction(null);
            this.bgSocket.close();
         }
         this.bgSocket = new BGSocket();
         this.bgSocket.addEventListener(BGSocketEvent.DATA_AVAILABLE,this.gotData);
         this.bgSocket.addEventListener(BGSocketEvent.CONNECTED,this.onConnect);
         this.bgSocket.addEventListener(BGSocketEvent.IO_ERROR,this.onIOError);
         this.bgSocket.addEventListener(BGSocketEvent.SECURITY_ERROR,this.onSecurityError);
         this.bgSocket.addEventListener(BGSocketEvent.DATA_PROGRESS,this.onDataProgress);
         this.bgSocket.addStatusFunction(this.socketStatus);
         this.flashVars = new BMMClientFlashVars(stage);
         this.currentDomain = BMDomainResolver.getDomain(true);
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
         var _loc3_:String = GlobalAccess.overrideHost != "" && this.flashVars.port != BMMClientFlashConsts.usedPortForDev ? GlobalAccess.overrideHost : this.currentDomain;
         this.bgSocket.connect(_loc3_,_loc2_);
      }
      
      private function socketStatus(param1:String) : void
      {
         var _loc2_:String = null;
         if(screensM.isScreenOpened(BMScreensManager.SCR_DEBUGGER))
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_DEBUGGER))
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_DEBUGGER))
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
          * Instruction count: 10063
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      private function addBattleCallData(param1:Object) : void
      {
         if(!screensM.isBattleOpened())
         {
            TsLogger.log("Tried to execute addBattleCallData while not in battle! Ignoring : " + JSON.stringify(param1));
            return;
         }
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
            else if(screensM.isScreenOpened(BMScreensManager.SCR_DEBUGGER))
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
                     "equipmentID":_loc7_,
                     "specialAbilities":_loc1_.specialAbilities
                  });
                  break;
               case "BMM_BATTLE_SHUTDOWN":
                  screensM.screenBattle.activateNextBattlePhase("action_shutDownSuccess",{"specialAbilities":_loc1_.specialAbilities});
                  break;
               case "BMM_BATTLE_USE_KIT":
                  _loc8_ = int(_loc1_.slotName.substr(_loc1_.slotName.length - 1,1));
                  screensM.screenBattle.activateNextBattlePhase("action_useKitSuccess",{"equipmentID":_loc8_});
                  break;
               case "BMM_BATTLE_TELEPORT":
                  screensM.screenBattle.activateNextBattlePhase("action_teleportSuccess",{
                     "targetStep":_loc1_.targetStep,
                     "specialAbilities":_loc1_.specialAbilities
                  });
                  break;
               case "BMM_BATTLE_CHARGE":
                  screensM.screenBattle.activateNextBattlePhase("action_chargeSuccess",{"specialAbilities":_loc1_.specialAbilities});
                  break;
               case "BMM_BATTLE_HARPOON":
                  screensM.screenBattle.activateNextBattlePhase("action_harpoonSuccess",{"specialAbilities":_loc1_.specialAbilities});
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
                  screensM.screenBattle.activateNextBattlePhase("action_energyRegenerationSuccess",{"specialAbilities":_loc1_.specialAbilities});
                  break;
               case "BMM_BATTLE_FORCE_SHUTDOWN":
                  screensM.screenBattle.forceShutDownSuccess({"specialAbilities":_loc1_.specialAbilities});
                  break;
               case "BMM_BATTLE_SWITCH_MECH":
                  screensM.screenBattle.switchMechSuccess(_loc1_.mechID,{"specialAbilities":_loc1_.specialAbilities});
                  break;
               case "BMM_BATTLE_SURRENDER":
                  _loc9_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
                  _loc9_.lastBattleResult = BMDataManager.BATTLE_RESULT_LOSS;
                  _loc9_.lastLadderProgress = _loc9_.ladderProgress;
                  _loc9_.currentSeasonHighestLadderProgress = _loc1_.currentSeasonHighestLadderProgress;
                  _loc9_.ladderProgress = _loc1_.ladderProgress;
                  _loc9_.pvpFinalRankingListPosition = _loc1_.rankingListPosition;
                  _loc9_.rankingListPosition = _loc9_.pvpFinalRankingListPosition;
                  dataM.pvpWinningRewardPredictionData.updateData(_loc1_.pvpWinningRewardPrediction);
                  screensM.screenBattle.surrenderSuccess();
                  break;
               case "BMM_BATTLE_OPPONENT_QUIT_BATTLE":
                  screensM.screenBattle.opponentQuitBattle();
                  break;
               case "BMM_BATTLE_RESULT":
                  this.handleBattleResultData(_loc1_);
            }
            screensM.screenBattle.checkForReEnablingBottomInterface();
         }
      }
      
      private function handleBattleResultData(param1:Object) : *
      {
         var _loc5_:int = 0;
         var _loc2_:BMBattleResultData = new BMBattleResultData(param1);
         var _loc3_:Boolean = screensM.isScreenOpened(BMScreensManager.SCR_BATTLE);
         if(dataM.replays_loaded)
         {
            dataM.addOnlineReplayData(_loc2_.replay,"online");
         }
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         _loc4_.pvpFinalRankingListPosition = _loc2_.rankingListPosition;
         _loc4_.rankingListPosition = _loc4_.pvpFinalRankingListPosition;
         _loc4_.currentSeasonHighestLadderProgress = _loc2_.currentSeasonHighestLadderProgress;
         if(screensM.isScreenOpened(BMScreensManager.SCR_DEBUGGER))
         {
         }
         if(_loc2_.reward.levelUpData == null)
         {
            _loc2_.reward.levelUpData = new BMLevelUpData(null,0,0,0);
         }
         dataM.pvpWinningRewardPredictionData.updateData(param1.pvpWinningRewardPrediction);
         if(_loc3_)
         {
            screensM.screenBattle.battleResultSuccess(_loc2_.totalPlayerGold,_loc2_.reward.levelUpData,_loc2_.totalPlayerXP,_loc2_.totalPlayerNukes,param1.overallRank,_loc2_.ladderProgress,_loc2_.reward);
         }
         else
         {
            screensM.screenVS.notifyBattleFinishedBeforeStart(_loc2_.totalPlayerGold,_loc2_.reward.levelUpData,_loc2_.totalPlayerXP,_loc2_.totalPlayerNukes,param1.overallRank,_loc2_.ladderProgress,_loc2_.reward);
         }
         if(param1.dPremium != null)
         {
            _loc5_ = int(param1.dPremium);
            if(dataM.premiumAccountTime < _loc5_)
            {
               dataM.premiumAccountTime = _loc5_;
            }
         }
      }
      
      public function getGuestData() : Object
      {
         var _loc5_:uint = 0;
         var _loc12_:BMPlayerItemData = null;
         var _loc13_:String = null;
         var _loc14_:BMBoostData = null;
         var _loc15_:String = null;
         var _loc16_:BMWorldMapLocationData = null;
         var _loc1_:Object = new Object();
         var _loc2_:Array = new Array();
         var _loc3_:BMPlayerData = dataM.playersData[dataM.LOCAL_PLAYER_ID];
         var _loc4_:BMPlayerProfile = dataM.player1Profile;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.items.length)
         {
            _loc12_ = _loc3_.items[_loc5_];
            _loc13_ = "";
            if(_loc12_.equipped > 0)
            {
               _loc13_ = _loc12_.equipmentType;
               if(_loc12_.equipmentID > 0)
               {
                  _loc13_ += _loc12_.equipmentID;
               }
            }
            _loc2_.push({
               "itemID":_loc12_.itemID,
               "equipped":_loc12_.equipped,
               "slotName":_loc13_,
               "power":_loc12_.power
            });
            _loc5_++;
         }
         if(_loc4_.getFreePackageAmount(2) == 1)
         {
            _loc14_ = dataM.boostsDB[2];
            _loc4_.gold += _loc14_.bonusGold;
         }
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:String = "";
         var _loc10_:String = "";
         var _loc11_:uint = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.mapProgress.length)
         {
            _loc15_ = _loc4_.mapProgress[_loc5_];
            if(_loc15_ == BMSinglePlayerManager.MAP_PROGRESS_COMPLETE)
            {
               _loc9_ = _loc9_ + _loc10_ + BMSinglePlayerManager.MAP_PROGRESS_COMPLETE;
               _loc10_ = "";
               _loc16_ = dataM.singlePlayerM.getSpecificMissionDB(_loc11_,_loc5_);
               if(_loc16_.type == BMWorldMapLocationData.TYPE_LOOT)
               {
                  _loc8_++;
               }
               else if(_loc16_.type == BMWorldMapLocationData.TYPE_MISSION)
               {
                  if(_loc16_.difficulty == 2)
                  {
                     _loc6_++;
                  }
                  else if(_loc16_.difficulty == 3)
                  {
                     _loc7_++;
                  }
               }
            }
            else
            {
               _loc10_ += BMSinglePlayerManager.MAP_PROGRESS_INCOMPLETE;
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
         _loc1_.name = _loc4_.playerName;
         return _loc1_;
      }
      
      private function onExternalAssetsLoadProgress(param1:Number, param2:Number) : void
      {
         var _loc4_:String = null;
         var _loc3_:Number = Math.ceil(param1 / param2 * 100);
         _loc3_ = Math.max(0,_loc3_);
         _loc3_ = Math.min(100,_loc3_);
         if(screensM.isScreenOpened(BMScreensManager.SCR_CONFIRMATION))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("loadingExternalAssets",_loc3_);
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_BLACK))
         {
            _loc4_ = "(" + _loc3_ + "%)";
            screensM.screenBlack.text = _loc4_;
         }
      }
      
      private function onExternalAssetsLoadComplete() : void
      {
         this.doGetInitialDataSub();
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
         },{
            "paramName":"supportsCompactItems",
            "paramValue":true
         },{
            "paramName":"version",
            "paramValue":BMExternalAssetsManager.getInstance().getVersionNumber()
         },{
            "paramName":"platform",
            "paramValue":BMPlatformUtils.sourcePlatform
         }];
         this._resetGuestData = param1;
         if(param1)
         {
            _loc3_.push({
               "paramName":"guestData",
               "paramValue":this.getGuestData()
            });
            this._loadExternalLibraryWhenGetInitialDataIsOver = true;
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
      
      private function getInitialData_setupPhase3(param1:Boolean, param2:*, param3:*) : void
      {
         this.sendObjectToSocket("BMM_GET_INITIAL_DATA_SETUP_PHASE_3",[{
            "paramName":"dailyLoginStreakWithMythical",
            "paramValue":param1
         },{
            "paramName":"notificationID",
            "paramValue":param2
         },{
            "paramName":"packageID",
            "paramValue":param3
         }]);
      }
      
      private function getInitialData_setupPhase4() : void
      {
         var _loc1_:Array = [];
         if(BMGuestABTestManager.hasData())
         {
            _loc1_.push({
               "paramName":"abTestDefinitionID",
               "paramValue":BMGuestABTestManager.getDefinitionID()
            });
         }
         this.sendObjectToSocket("BMM_GET_INITIAL_DATA_SETUP_PHASE_4",_loc1_);
      }
      
      public function sendGoodbye() : void
      {
         this.sendObjectToSocket("BMM_GOODBYE",[]);
      }
      
      public function betaOptIn() : void
      {
         this.sendObjectToSocket("BMM_BETA_OPT_IN",[]);
      }
      
      public function convertGoldToNewEconomy(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_CONVERT_GOLD_TO_NEW_ECONOMY",[{
            "paramName":"boxes",
            "paramValue":param1
         }]);
      }
      
      public function convertLegacyItems(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_CONVERT_LEGACY_ITEMS_TO_POWER",[{
            "paramName":"rarity",
            "paramValue":param1
         }]);
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
      
      public function clan_updateSettings(param1:String, param2:int, param3:int) : void
      {
         this.sendObjectToSocket("BMM_CLAN_UPDATE_FLAG",[{
            "paramName":"flag",
            "paramValue":param1
         },{
            "paramName":"minRank",
            "paramValue":param2
         },{
            "paramName":"joiningStatus",
            "paramValue":param3
         }]);
      }
      
      public function clan_collectClanBossCoins() : void
      {
         this.sendObjectToSocket("BMM_CLAN_COLLECT_CLAN_BOSS_COINS",[]);
      }
      
      public function clanWar_join() : void
      {
         dataM.mechBuildsM.createLocalBuildsDataIfNeeded();
         this.sendObjectToSocket("BMM_CLAN_WAR_JOIN",[{
            "paramName":"teams",
            "paramValue":dataM.mechBuildsM.exportData()["builds"][dataM.mechBuildsM.selectedBuildID]["mechStructures"]
         }]);
      }
      
      public function clanWar_collectReward() : void
      {
         this.sendObjectToSocket("BMM_CLAN_WAR_COLLECT_REWARD",[]);
      }
      
      public function fillBattleCredits() : void
      {
         this.sendObjectToSocket("BMM_BATTLE_CREDITS_FILL",[]);
      }
      
      public function rewardVideoWatched(param1:String) : void
      {
         TsLogger.log("BMSocketManager:rewardVideoWatched placement:" + param1);
         this.sendObjectToSocket("BMM_REWARD_VIDEO_WATCHED",[{
            "paramName":"placement",
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
      
      public function marketing_claimGiftKeys(param1:Array) : void
      {
         this.sendObjectToSocket("BMM_CLAIM_MARKETING_GIFT",[{
            "paramName":"marketingGiftKeys",
            "paramValue":param1
         }]);
      }
      
      public function mission_create(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:Boolean = false) : void
      {
         this.sendObjectToSocket("BMM_MISSION_CREATE",[{
            "paramName":"storyID",
            "paramValue":param1
         },{
            "paramName":"difficulty",
            "paramValue":param2
         },{
            "paramName":"themeID",
            "paramValue":param3
         },{
            "paramName":"flag",
            "paramValue":""
         },{
            "paramName":"missionSlot",
            "paramValue":param4
         },{
            "paramName":"mode",
            "paramValue":param5
         },{
            "paramName":"isRaid",
            "paramValue":param6
         }]);
      }
      
      public function raid_create() : void
      {
         this.sendObjectToSocket("BMM_MISSION_CREATE",[{
            "paramName":"isRaid",
            "paramValue":true
         }]);
      }
      
      public function raid_claimReward() : void
      {
         this.sendObjectToSocket("BMM_RAID_CLAIM_REWARD",[{}]);
      }
      
      public function raid_getLeaderboard(param1:Boolean = true) : void
      {
         this.sendObjectToSocket("BMM_RAID_GET_LEADERBOARD",[{
            "paramName":"currentLeaderboard",
            "paramValue":param1
         }]);
      }
      
      public function raid_getData() : void
      {
         this.sendObjectToSocket("BMM_RAID_GET_DATA",[{}]);
      }
      
      public function mission_abort(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_MISSION_ABORT",[{
            "paramName":"missionSlot",
            "paramValue":param1
         }]);
      }
      
      public function mission_useNuke(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         this.sendObjectToSocket("BMM_MISSION_USE_NUKE",[{
            "paramName":"story",
            "paramValue":param1
         },{
            "paramName":"slot",
            "paramValue":param2
         },{
            "paramName":"mode",
            "paramValue":param3
         },{
            "paramName":"times",
            "paramValue":param4
         }]);
      }
      
      public function mission_getData() : void
      {
         this.sendObjectToSocket("BMM_MISSION_GET_DATA",[]);
      }
      
      public function mission_addProgress(param1:Number, param2:Array) : void
      {
         this.sendObjectToSocket("BMM_MISSION_ADD_PROGRESS",[{
            "paramName":"position",
            "paramValue":param1
         },{
            "paramName":"mechsStats",
            "paramValue":param2
         }]);
      }
      
      public function mission_addExplosiveChainProgress(param1:Array, param2:Array) : void
      {
         this.sendObjectToSocket("BMM_MISSION_EXPLOSIVE_CHAIN_PROGRESS",[{
            "paramName":"structuresToDestroy",
            "paramValue":param1
         },{
            "paramName":"enemiesToDamage",
            "paramValue":param2
         }]);
      }
      
      public function mission_useUpgrade(param1:String, param2:uint) : void
      {
         this.sendObjectToSocket("BMM_MISSION_USE_UPGRADE",[{
            "paramName":"type",
            "paramValue":param1
         },{
            "paramName":"mechID",
            "paramValue":param2
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
      
      public function mission_claimItemBox(param1:uint, param2:uint, param3:uint) : void
      {
         this.sendObjectToSocket("BMM_MISSION_CLAIM_ITEM_BOX",[{
            "paramName":"storyID",
            "paramValue":param1
         },{
            "paramName":"missionSlot",
            "paramValue":param2
         },{
            "paramName":"packageID",
            "paramValue":param3
         }]);
      }
      
      public function harvestMission(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_HARVEST_MISSION",[{
            "paramName":"missionSlot",
            "paramValue":param1
         }]);
      }
      
      public function enterSinglePlayerLobby() : void
      {
         this.sendObjectToSocket("BMM_ENTER_SINGLE_PLAYER_LOBBY",[]);
      }
      
      public function enterMultiplayerLobby() : void
      {
         this.sendObjectToSocket("BMM_ENTER_MULTIPLAYER_LOBBY",[]);
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
      
      public function lobby_saveCurrentMechStructureForImproveYourMechStarterPack(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SAVE_CURRENT_MECH_FOR_IMPROVE_YOUR_MECH_STARTER_PACK",[{
            "paramName":"starterPackID",
            "paramValue":param1
         }]);
      }
      
      public function buyGold(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_BUY_GOLD",[{
            "paramName":"goldPackageID",
            "paramValue":param1
         }]);
      }
      
      public function buyPremiumPackage(param1:int, param2:Boolean) : void
      {
         TsLogger.log("BMSocketManager:buyPremiumPackage packageID:" + param1);
         this.sendObjectToSocket("BMM_BUY_PREMIUM_PACKAGE",[{
            "paramName":"packageID",
            "paramValue":param1
         },{
            "paramName":"isInBattleEnd",
            "paramValue":param2
         }]);
      }
      
      public function buyShopMech(param1:int, param2:Boolean = false) : void
      {
         TsLogger.log("BMSocketManager:buyShopMech packageID: " + param1 + " fromSale: " + param2);
         this.sendObjectToSocket("BMM_BUY_SHOP_MECH",[{
            "paramName":"packageID",
            "paramValue":param1
         },{
            "paramName":"fromSale",
            "paramValue":param2
         }]);
      }
      
      public function buySaleShopMech(param1:int) : void
      {
         this.buyShopMech(param1,true);
      }
      
      public function lobby_searchForBattle(param1:uint, param2:String = "") : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SEARCH_FOR_BATTLE",[{
            "paramName":"mechsPerPlayer",
            "paramValue":param1
         },{
            "paramName":"kinTransactionID",
            "paramValue":param2
         }]);
      }
      
      public function lobby_cancelSearchForBattle() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_CANCEL_SEARCH_FOR_BATTLE",[]);
      }
      
      public function lobby_finishBattleVSComputer(param1:Boolean, param2:Boolean, param3:String, param4:String, param5:uint, param6:Number, param7:Object, param8:uint, param9:Number, param10:Boolean = false, param11:Boolean = false, param12:Number = 0, param13:Number = 0, param14:Number = 0, param15:uint = 0, param16:uint = 0, param17:uint = 0) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_FINISH_BATTLE_VS_COMPUTER",[{
            "paramName":"playerWon",
            "paramValue":param1
         },{
            "paramName":"playerQuit",
            "paramValue":param2
         },{
            "paramName":"battleType",
            "paramValue":param3
         },{
            "paramName":"battleSubType",
            "paramValue":param4
         },{
            "paramName":"battleReport",
            "paramValue":param7
         },{
            "paramName":"enemyLevel",
            "paramValue":param8
         },{
            "paramName":"position",
            "paramValue":param9
         },{
            "paramName":"difficulty",
            "paramValue":param5
         },{
            "paramName":"computerBattleID",
            "paramValue":param6
         },{
            "paramName":"droneOnlyWin",
            "paramValue":param10
         },{
            "paramName":"meleeOnlyWin",
            "paramValue":param11
         },{
            "paramName":"opponentResistance1",
            "paramValue":param12
         },{
            "paramName":"opponentResistance2",
            "paramValue":param13
         },{
            "paramName":"opponentResistance3",
            "paramValue":param14
         },{
            "paramName":"maxSingleShotDamage",
            "paramValue":param15
         },{
            "paramName":"singleOverheats",
            "paramValue":param16
         },{
            "paramName":"doubleOverheats",
            "paramValue":param17
         }]);
      }
      
      public function lobby_startedBattleVSComputer(param1:Number) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_STARTED_BATTLE_VS_COMPUTER",[{
            "paramName":"position",
            "paramValue":param1
         }]);
      }
      
      public function lobby_startedOnlineBattleVSComputer(param1:Number, param2:uint = 1, param3:Boolean = false, param4:uint = 0) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_STARTED_BATTLE_VS_COMPUTER",[{
            "paramName":"position",
            "paramValue":param1
         },{
            "paramName":"isOnlineBattle",
            "paramValue":true
         },{
            "paramName":"missionCurrentMechID",
            "paramValue":param2
         },{
            "paramName":"isClanBoss",
            "paramValue":param3
         },{
            "paramName":"clanWarOpponentID",
            "paramValue":param4
         }]);
      }
      
      public function lobby_startedClanBossBattle() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_STARTED_BATTLE_VS_COMPUTER",[{
            "paramName":"isClanBoss",
            "paramValue":true
         }]);
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
      
      public function lobby_getReplayByCode(param1:String) : void
      {
         this.sendObjectToSocket("BMM_LOBBY_GET_REPLAY_BY_CODE",[{
            "paramName":"code",
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
      
      public function gameOfWhales_sendCommonData(param1:Object) : void
      {
         this.sendObjectToSocket("BMM_GAME_OF_WHALES_DATA",[{
            "paramName":"common",
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
      
      public function lobby_setLastNewsID() : void
      {
         this.sendObjectToSocket("BMM_LOBBY_SET_LAST_NEWS_ID",[]);
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
      
      public function inventory_updateMechBuilds(param1:Object) : void
      {
         this.sendObjectToSocket("BMM_INVENTORY_UPDATE_MECH_BUILDS",[{
            "paramName":"mechBuilds",
            "paramValue":param1
         }]);
      }
      
      public function inventory_changeMechsOrder(param1:Array) : void
      {
         this._mechsNewLocations = param1;
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
         if(dataM.mechBuildsM.isEnabled)
         {
            dataM.mechBuildsM.updateCurrentBuild();
            remoteM.socketM.inventory_updateMechBuilds(dataM.mechBuildsM.exportData());
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_CHANGE_MECHS_ORDER))
         {
            screensM.screenChangeMechsOrder.mechsOrderChangeSuccess();
         }
      }
      
      public function inventory_buyExpansion() : void
      {
         this.sendObjectToSocket("BMM_INVENTORY_BUY_EXPANSION",[]);
      }
      
      public function battle_pickMechs(param1:String, param2:Array) : void
      {
         this.sendObjectToSocket("BMM_BATTLE_PICK_MECHS",[{
            "paramName":"battleID",
            "paramValue":param1
         },{
            "paramName":"pickedMechs",
            "paramValue":param2
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
      
      public function battle_surrender(param1:Number = 0) : void
      {
         this.sendObjectToSocket("BMM_BATTLE_SURRENDER",[{
            "paramName":"computerBattleID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_buyGachaMachine(param1:uint, param2:uint, param3:uint) : void
      {
         this._buyGacha_gachaMachineID = param1;
         this._buyGacha_amount = param2;
         this.sendObjectToSocket("BMM_BUY_GACHA_MACHINE",[{
            "paramName":"gachaMachineID",
            "paramValue":param1
         },{
            "paramName":"amount",
            "paramValue":param2
         },{
            "paramName":"clientCostTokens",
            "paramValue":param3
         }]);
      }
      
      public function clan_buyClanShopItem(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_CLAN_BUY_CLAN_SHOP_PACKAGE",[{
            "paramName":"itemID",
            "paramValue":param1
         }]);
      }
      
      public function kin_buyShopItem(param1:uint, param2:String) : void
      {
         this.sendObjectToSocket("BMM_BUY_KIN_SHOP_PACKAGE",[{
            "paramName":"itemID",
            "paramValue":param1
         },{
            "paramName":"transactionID",
            "paramValue":param2
         }]);
      }
      
      public function kin_claim(param1:String) : void
      {
         this.sendObjectToSocket("BMM_COLLECT_BONUS_KIN",[{
            "paramName":"publicAddress",
            "paramValue":param1
         }]);
      }
      
      public function kin_onboard(param1:String) : void
      {
         this.sendObjectToSocket("BMM_ONBOARD_KIN_ACCOUNT",[{
            "paramName":"publicAddress",
            "paramValue":param1
         }]);
      }
      
      public function kin_whitelistTransaction(param1:Object, param2:String) : void
      {
         this.sendObjectToSocket("BMM_WHITELIST_KIN_TRANSACTION",[{
            "paramName":"whitelistableTransaction",
            "paramValue":param1
         },{
            "paramName":"destinationPublicAddress",
            "paramValue":param2
         }]);
      }
      
      public function lobby_claimFreeBoost(param1:uint) : void
      {
         this._claimBoost_boostID = param1;
         this.sendObjectToSocket("BMM_CLAIM_FREE_BOOST",[{
            "paramName":"boostID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_claimFragmentBox(param1:uint) : void
      {
         this._claimBoost_boostID = param1;
         this.sendObjectToSocket("BMM_CLAIM_FRAGMENT_BOX",[{
            "paramName":"gachaMachineID",
            "paramValue":param1
         }]);
      }
      
      public function lobby_upgradeSkill(param1:String) : void
      {
         this.sendObjectToSocket("BMM_UPGRADE_SKILL",[{
            "paramName":"skillName",
            "paramValue":param1
         }]);
      }
      
      public function lobby_getGachaMachines() : void
      {
         this.sendObjectToSocket("BMM_GET_GACHA_MACHINES",[]);
      }
      
      public function baseBuilding_buildStructure(param1:uint, param2:uint) : void
      {
         this.sendObjectToSocket("BMM_BASE_BUILD_STRUCTURE",[{
            "paramName":"position",
            "paramValue":param1
         },{
            "paramName":"type",
            "paramValue":param2
         }]);
      }
      
      public function baseBuilding_upgradeStructure(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_BASE_UPGRADE_STRUCTURE",[{
            "paramName":"position",
            "paramValue":param1
         }]);
      }
      
      public function baseBuilding_collectResources(param1:uint) : void
      {
         this.sendObjectToSocket("BMM_BASE_COLLECT_RESOURCES",[{
            "paramName":"position",
            "paramValue":param1
         }]);
      }
      
      public function baseBuilding_addToItemFactoryBuildQueue(param1:uint, param2:uint, param3:uint) : *
      {
         this.sendObjectToSocket("BMM_BASE_ADD_TO_ITEM_FACTORY_QUEUE",[{
            "paramName":"position",
            "paramValue":param1
         },{
            "paramName":"itemType",
            "paramValue":param2
         },{
            "paramName":"amount",
            "paramValue":param3
         }]);
      }
      
      public function baseBuilding_removeFromItemFactoryBuildQueue(param1:uint, param2:uint) : *
      {
         this.sendObjectToSocket("BMM_BASE_REMOVE_FROM_ITEM_FACTORY_QUEUE",[{
            "paramName":"position",
            "paramValue":param1
         },{
            "paramName":"amount",
            "paramValue":param2
         }]);
      }
      
      public function baseBuilding_skipBaseBuildingQueue(param1:uint, param2:uint) : *
      {
         this.sendObjectToSocket("BMM_BASE_SKIP_QUEUE_WITH_TOKENS",[{
            "paramName":"position",
            "paramValue":param1
         },{
            "paramName":"expectedCostTokens",
            "paramValue":param2
         }]);
      }
      
      public function baseBuilding_swapStructurePositions(param1:uint, param2:uint) : *
      {
         this.sendObjectToSocket("BMM_BASE_SWAP_STRUCTURE_POSITIONS",[{
            "paramName":"srcPosition",
            "paramValue":param1
         },{
            "paramName":"dstPosition",
            "paramValue":param2
         }]);
      }
      
      public function baseBuilding_optIn() : *
      {
         this.sendObjectToSocket("BMM_BASE_OPT_IN",[]);
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
         this.sendObjectToSocket("BMM_BUY_GACHA_MACHINE",[{
            "paramName":"gachaMachineID",
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
      
      public function beta_resetAccount() : void
      {
         this.sendObjectToSocket("BMM_RESET_PROGRESS",[]);
      }
      
      public function mining_getAvailableToClaimTokensCount() : void
      {
         this.sendObjectToSocket("BMM_COIN_HIVE_GET_DATA",[]);
      }
      
      public function mining_claimTokens() : void
      {
         this.sendObjectToSocket("BMM_COIN_HIVE_CLAIM_TOKENS",[]);
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
         var _loc4_:BMItemData = new BMItemData();
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
         if(_loc3_.ascensionGoldCost != null)
         {
            _loc4_.ascensionGoldCost = _loc3_.ascensionGoldCost;
         }
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
         _loc4_.pushSelf = _loc3_.pushSelf;
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
         _loc4_.chainID = _loc3_.chainID;
         _loc4_.contentPackID = _loc3_.contentPackID;
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
      
      public function isSocketConnected() : Boolean
      {
         return this.bgSocket.public::isConnected;
      }
      
      private function sendObjectToSocket(param1:String, param2:Array) : void
      {
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
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
                  _loc5_ = " > > > CALLING : " + param1;
                  TsLogger.log(_loc5_);
            }
            BMMSessionManager.gi().pythonFunctionCalled(param1);
            if(screensM.isScreenOpened(BMScreensManager.SCR_DEBUGGER))
            {
               screensM.screenDebugger.addTrace(" > > > CALLING : " + param1);
            }
         }
         else
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_DEBUGGER))
            {
               screensM.screenDebugger.addTrace("ERROR - NO CONNECTION WITH SOCKET");
            }
            TsLogger.log("ERROR - NO CONNECTION WITH SOCKET");
         }
      }
      
      private function onConnect(param1:BGSocketEvent) : void
      {
         TsLogger.log("BMSocketManager::onConnect");
         this.getInitialData(tutorialM.addGuestDataToNextConnection);
         if(tutorialM.guestGenerateUserActive)
         {
            tutorialM.completeGeneratingGuestUser();
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
         this.bgSocket.connect(BMDomainResolver.getDomain(true),_loc1_.port);
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
         var _loc2_:String = null;
         BMLoadingTimer.gi().removeLostConnectionMessage();
         this.doGetInitialData_setVersionParameters(param1);
         this.doGetInitialData_setGeneralParameters(param1);
         this.doGetInitialData_abTest(param1);
         this.doGetInitialDataMidWorkData = param1;
         if(screensM.isScreenOpened(BMScreensManager.SCR_CONFIRMATION))
         {
            screensM.screenConfirmation.displayQuestionOrNotification("loadingExternalAssets",0);
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_BLACK))
         {
            _loc2_ = "(0%)";
            screensM.screenBlack.text = _loc2_;
         }
         this.onExternalAssetsLoadComplete();
      }
      
      private function doGetInitialDataSub() : void
      {
         externalAssetsM.checkVersions();
         if(externalAssetsM.versionsUpToDate)
         {
            if(this.doGetInitialDataMidWorkData.items)
            {
               BMLoadingTimer.gi().showLoading(getSpecificText("confirmation_updatingItems"));
               this.counter = 5;
            }
            else
            {
               BMLoadingTimer.gi().showLoading(getSpecificText("confirmation_loadingData"));
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
         this.doGetInitialData_itemsOverride(param1);
         this.doGetInitialData_clanRequests(param1);
         this.doGetInitialData_userStatstics(param1);
         this.doGetInitialData_rankingLists(param1);
         this.doGetInitialData_boostsAndTokenPackages(param1);
         this.doGetInitialData_loadQuests(param1);
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.doGetInitialData_finalFunctions(param1);
         TsLogger.log("userID: " + dataM.userID);
         if(dataM.specialUser || dataM.userID == 11208154)
         {
            screensM.btnDebugger.visible = true;
         }
         if(this._loadExternalLibraryWhenGetInitialDataIsOver || tutorialM.isTutorialActive() == false)
         {
            this._loadExternalLibraryWhenGetInitialDataIsOver = false;
            if(externalAssetsM.shouldLoadExternalLibrary && screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND) == false)
            {
               screensM.addScreen(BMScreensManager.SCR_LOAD_EXTERNAL_LIBRARY);
            }
         }
         dataM.clanWarsM.createClanPlayersData();
         dataM.kinM.initialize();
         BMPubSub.pub(BMPubSub.MESSAGE_FINISHED_GET_INITIAL_DATA);
      }
      
      private function doGetInitialData_itemsOverride(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:BMItemData = null;
         var _loc7_:String = null;
         var _loc2_:* = param1.itemsOverride;
         if(_loc2_)
         {
            for(_loc3_ in _loc2_)
            {
               _loc4_ = int(_loc3_);
               _loc5_ = _loc2_[_loc3_];
               _loc6_ = dataM.itemsDB_online[_loc4_].clone();
               for(_loc7_ in _loc5_)
               {
                  _loc6_[_loc7_] = _loc5_[_loc7_];
               }
               dataM.itemsDB_online[_loc4_] = _loc6_;
            }
         }
         if(param1.notReleasedItemChainIDs)
         {
            dataM.notReleasedItemChainIDs = Vector.<int>(param1.notReleasedItemChainIDs);
         }
         else
         {
            dataM.notReleasedItemChainIDs = new Vector.<int>();
         }
      }
      
      private function doGetInitialData_abTest(param1:Object) : void
      {
         var _loc2_:* = undefined;
         dataM.abTestData.flags = param1["abTestFlags"];
         dataM.abTestData.bucketID = param1["abTestBucketID"];
         dataM.abTestData.bucketName = param1["abTestBucketName"];
         for(_loc2_ in dataM.abTestData.flags)
         {
            dataM.generalSettings[_loc2_] = dataM.abTestData.flags[_loc2_];
         }
         dataM.setABBucket(dataM.abTestData.bucketName);
      }
      
      private function doGetInitialData_setVersionParameters(param1:Object) : void
      {
         externalAssetsM.server_version_client_pc = param1.general.version_client;
         externalAssetsM.server_version_items1 = param1.general.server_version_items1;
         externalAssetsM.server_version_items2 = param1.general.server_version_items2;
         externalAssetsM.server_version_items3 = param1.general.server_version_items3;
         externalAssetsM.server_version_general = param1.general.server_version_general;
         externalAssetsM.server_version_music = param1.general.server_version_music;
         externalAssetsM.server_version_sound = param1.general.server_version_sound;
         externalAssetsM.version_client_ios = param1.general.version_ipad;
         externalAssetsM.version_client_android = param1.general.version_android;
         externalAssetsM.version_client_steam = param1.general.version_steam;
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_BACKGROUND))
         {
            screensM.screenWelcomeBackground.refreshVersionText();
         }
      }
      
      private function doGetInitialData_setGeneralParameters(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         var _loc7_:BMClanRewardData = null;
         var _loc8_:BMStarterPackData = null;
         dataM.battleMaxMechs = int(param1.general.mechsMax);
         dataM.inventoryMaxMechs = int(param1.general.inventoryMaxMechs);
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
               dataM.chatData.useChatBlocks = true;
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
         dataM.battleCredits_missionCost_normal = param1.general.battleCredits_missionCost_normal;
         dataM.battleCredits_missionCost_hard = param1.general.battleCredits_missionCost_hard;
         dataM.battleCredits_missionCost_insane = param1.general.battleCredits_missionCost_insane;
         dataM.battleCredits_missionCost_boss = param1.general.battleCredits_missionCost_boss;
         dataM.clanRewards = null;
         if(param1.general.clanRewards != null)
         {
            dataM.clanRewards = new Array();
            _loc5_ = 0;
            while(_loc5_ < param1.general.clanRewards.length)
            {
               _loc6_ = param1.general.clanRewards[_loc5_];
               _loc7_ = new BMClanRewardData(param1.general.clanRewards[_loc5_].winsRequired,param1.general.clanRewards[_loc5_].reward);
               dataM.clanRewards.push(_loc7_);
               _loc5_++;
            }
         }
         dataM.setLadderSeasonEndRewardsData(param1.general.seasonEndRewardsData);
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
         if(param1.general.floorBuff_resistanceDelta != null)
         {
            dataM.floorBuff_resistanceDelta = param1.general.floorBuff_resistanceDelta;
         }
         if(param1.general.floorBuff_regenHP != null)
         {
            dataM.floorBuff_regenHP = param1.general.floorBuff_regenHP;
         }
         dataM.supersonic_mobile_afterWins = param1.general.supersonic_mobile_afterWins;
         dataM.supersonic_mobile_SPMP = param1.general.supersonic_mobile_SPMP;
         dataM.clanBossBattlesMax = param1.general.clanBossMaxDailyBattles;
         dataM.clanBossCurrentDay = param1.general.clanBossCurrentDay;
         dataM.clanBossStartDay = param1.general.clanBossStartDay;
         dataM.clanBossActiveDays = param1.general.clanBossActiveDays;
         dataM.clanBossInactiveDays = param1.general.clanBossInactiveDays;
         if(param1.general.noneMovableTorsoItemIDs != null)
         {
            dataM.noneMovableTorsoItemIDs = param1.general.noneMovableTorsoItemIDs;
         }
         dataM.goldPerToken = param1.general.goldPerToken;
         dataM.minimalCampaignOpponentPowerRatingRatio = 0.5;
         if(param1.general.minimalCampaignOpponentPowerRatingRatio != null)
         {
            dataM.minimalCampaignOpponentPowerRatingRatio = param1.general.minimalCampaignOpponentPowerRatingRatio;
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
            if(dataM.dailyLoginStreakBonus.hasOwnProperty("reward"))
            {
               dataM.dailyLoginStreakBonus.reward = new BMRewardData(dataM.dailyLoginStreakBonus.reward);
            }
            if(dataM.dailyLoginStreakBonus.hasOwnProperty("vipReward"))
            {
               dataM.dailyLoginStreakBonus.vipReward = new BMRewardData(dataM.dailyLoginStreakBonus.vipReward);
            }
         }
         dataM.chatData.useChatRank1Channels = false;
         if(param1.general.useChatRank1Channels != null)
         {
            if(int(param1.general.useChatRank1Channels) == 1)
            {
               dataM.chatData.useChatRank1Channels = true;
            }
         }
         dataM.dailyLoginStreakData = new Dictionary();
         for(_loc3_ in param1.general.dailyLoginStreakData)
         {
            dataM.dailyLoginStreakData[uint(_loc3_)] = param1.general.dailyLoginStreakData[_loc3_];
         }
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
         dataM.showStarterPackAfterMissionLoss = int(param1.general.showStarterPackAfterMissionLoss) == 1;
         dataM.campaignMissionRewardsRepository = new BMMissionDefinitionRepository(param1.general.campaignMissionsData);
         BMOneTimeSpecialOffersManager.gi().parseData(param1.general.oneTimeSpecialOffers);
         dataM.starterPackData = new Dictionary();
         for each(_loc4_ in param1.general.starterPacks)
         {
            _loc8_ = new BMStarterPackData();
            _loc8_.initialize(_loc4_.packID,_loc4_.offerDuration,_loc4_.boostID,_loc4_.boostAmount,_loc4_.mechColorID,_loc4_.torso,_loc4_.leg,_loc4_.sideWeapon1,_loc4_.sideWeapon2,_loc4_.sideWeapon3,_loc4_.sideWeapon4,_loc4_.topWeapon1,_loc4_.topWeapon2,_loc4_.module1,_loc4_.module2,_loc4_.module3,_loc4_.module4,_loc4_.module5,_loc4_.module6,_loc4_.module7,_loc4_.module8,_loc4_.drone,_loc4_.teleport,_loc4_.charge,_loc4_.harpoon,_loc4_.perk,_loc4_.bonusGold,_loc4_.bonusTokens,_loc4_.skin,_loc4_.vipDays,_loc4_.extraValue,0,-1,"",_loc4_.isBundle,_loc4_.battleCredits,_loc4_.clanCoins,_loc4_.arenaCoins,_loc4_.nukes,_loc4_.module1Multiplier,_loc4_.module2Multiplier,_loc4_.module3Multiplier,_loc4_.module4Multiplier,_loc4_.module5Multiplier,_loc4_.module6Multiplier,_loc4_.module7Multiplier,_loc4_.module8Multiplier);
            dataM.starterPackData[_loc4_.packID] = _loc8_;
         }
         dataM.singlePlayerM.parseDungeons(param1.general.dungeonsData);
         dataM.createEquipmentUnlockedDB(param1.general.equipmentUnlockDB);
         if(param1.general.boostConfigDB != null)
         {
            dataM.boostConfigDB = new BMBoostConfigDB(param1.general.boostConfigDB);
         }
         else
         {
            TsLogger.log("WARNING : did not find boost config db");
         }
         dataM.playerSkillsManager.parseData(param1.general.playerSkillsDB);
         dataM.baseBuildingManager.parseRules(param1.general.baseBuildingDB);
         dataM.boxFragmentsManager.updateDB(param1.general.boxFragmentsDB);
         dataM.clanShopItems = this.parseClanShopItems(param1.general.clanShopData);
         if(param1.general.kinShopData != null)
         {
            dataM.kinShopItems = this.parseClanShopItems(param1.general.kinShopData);
         }
         dataM.generalSettings = param1.general["generalSettings"];
         if(param1.general.hasOwnProperty("maxRewardVideosPerDay"))
         {
            dataM.maxRewardVideosPerDay = param1.general.maxRewardVideosPerDay;
            dataM.rewardVideosSeen = param1.general.rewardVideosSeen;
         }
      }
      
      private function parseClanShopItems(param1:Array) : Vector.<BMClanShopData>
      {
         var _loc3_:Object = null;
         var _loc4_:BMClanShopData = null;
         var _loc2_:Vector.<BMClanShopData> = new Vector.<BMClanShopData>();
         if(param1 != null)
         {
            for each(_loc3_ in param1)
            {
               _loc4_ = new BMClanShopData(_loc3_.ID,_loc3_.shopCategory,_loc3_.itemID,_loc3_.cost);
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      private function getInitialData_startLoadingItems(param1:Event) : void
      {
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
         var _loc4_:Boolean = false;
         var _loc6_:String = null;
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
         _loc4_ = false;
         if(param1.hasOwnProperty("itemsDataIsCompact"))
         {
            _loc4_ = Boolean(param1.itemsDataIsCompact);
         }
         var _loc5_:ItemCache = ItemCache.gi();
         if(!_loc3_)
         {
            if(_loc5_.getVersion() == null)
            {
               _loc5_.deleteCache();
               throw new Error("No items in request and in cache");
            }
         }
         if(_loc3_)
         {
            TsLogger.log("Items are fresh");
            this.doGetInitialData_parseItems(_loc3_,_loc4_);
            _loc6_ = param1.itemsVersion;
            if((Boolean(_loc6_)) && _loc6_ != _loc5_.getVersion())
            {
               this.doGetInitialDataMidWorkData = param1;
               this.itemDBDumper = _loc5_.getItemDBDumper(dataM.itemsDB_online);
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
            this.itemDBLoader = _loc5_.getItemDBLoader();
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
            dataM.setItemsCategoriesData(true);
            addEventListener(Event.ENTER_FRAME,this.continuAfterItemLoad);
         }
      }
      
      private function continuAfterItemLoad(param1:Event) : *
      {
         removeEventListener(Event.ENTER_FRAME,this.continuAfterItemLoad);
         this.continueGetInitialDataAfterItemLoad(this.doGetInitialDataMidWorkData);
         this.doGetInitialDataMidWorkData = null;
         this.itemDBLoader = null;
         dataM.resetItemsCache();
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
         var playerName:String;
         var playerLevel:uint;
         var playerProfile:BMPlayerProfile;
         var serverLoginDateString:String;
         var storyID:uint;
         var i:int;
         var goldPackage:Object = null;
         var premiumPackage:Object = null;
         var newGoldPackageData:BMGoldPackageData = null;
         var mechShopData:Object = null;
         var newPremiumPackage:BMPremiumPackageData = null;
         var itemsString:String = null;
         var rewardSlot:Number = NaN;
         var rewardItemID:Number = NaN;
         var serverDate:Date = null;
         var tempDate:Date = null;
         var $data:Object = param1;
         dataM.currentTime = int($data.general.currentTime);
         if(dataM.serverRestartTimeDisplay > dataM.currentTime)
         {
            screensM.addScreen(BMScreensManager.SCR_SERVER_RESTART_COUNTDOWN);
            screensM.screenServerRestartCountdown.refreshScreen();
         }
         if(dataM.raidData != null)
         {
            dataM.raidData.reset();
         }
         dataM.searchForBattleLevelChangeSeconds = $data.general.searchForBattleLevelChangeSeconds;
         dataM.turnsForQuitPenalty = int($data.general.turnsForQuitPenalty);
         dataM.advancedMatchmakingBlockLevel = int($data.general.advancedMatchmakingBlockLevel);
         dataM.weightMax = int($data.general.weightMax);
         if($data.general.weightOverload != null)
         {
            dataM.weightOverload = int($data.general.weightOverload);
         }
         if($data.general.weightOverloadHPPenalty != null)
         {
            dataM.weightOverloadHPPenalty = int($data.general.weightOverloadHPPenalty);
         }
         dataM.rewardSPWinGold = int($data.general.rewardSPWinGold);
         dataM.rewardSPWinXP = int($data.general.rewardSPWinXP);
         dataM.rewardMPWinGold = int($data.general.rewardMPWinGold);
         dataM.rewardMPWinXP = int($data.general.rewardMPWinXP);
         dataM.rewardSPLoseGold = int($data.general.rewardSPLoseGold);
         dataM.rewardSPLoseXP = int($data.general.rewardSPLoseXP);
         dataM.rewardMPLoseGold = int($data.general.rewardMPLoseGold);
         dataM.rewardMPLoseXP = int($data.general.rewardMPLoseXP);
         dataM.battleCreditsMax = int($data.general.battleCreditsMax);
         dataM.battleCreditsFillTokensCost = int($data.general.battleCreditsFillTokensCost);
         dataM.secondsForNewBattleCredit = int($data.general.secondsForNewBattleCredit);
         dataM.secondsForNewBattleCredit_supporters = int($data.general.secondsForNewBattleCredit_supporters);
         dataM.bonusTokensPerLevelUp = int($data.general.bonusTokensPerLevelUp);
         dataM.bonusTokensForLevel3 = int($data.general.bonusTokensForLevel3);
         dataM.clanMaxMembers = int($data.general.clanMaxMembers);
         dataM.createClanCost = int($data.general.createClanCost);
         dataM.freeTokens_amount = int($data.general.freeTokens_amount);
         dataM.freeTokens_cooldown = int($data.general.freeTokens_cooldown);
         if($data.general.missionReviveTokensCost != null)
         {
            dataM.missionReviveTokensCost = int($data.general.missionReviveTokensCost);
         }
         dataM.advertisingCampaignID = $data.general.advertisingCampaignID;
         dataM.goldPackagesDB = new Array();
         for each(goldPackage in $data.general.goldPackagesDB)
         {
            newGoldPackageData = new BMGoldPackageData(goldPackage.title,goldPackage.bonus,goldPackage.goldPackageID,goldPackage.costTokens,goldPackage.costTokensDefault,goldPackage.gold,goldPackage.visual,goldPackage.banner,goldPackage.sortID);
            dataM.goldPackagesDB[goldPackage.goldPackageID] = newGoldPackageData;
         }
         dataM.mechShopData = {};
         if($data.mechShopData)
         {
            for each(mechShopData in $data.mechShopData)
            {
               dataM.mechShopData[mechShopData.packageID] = new BMMechShopData(mechShopData.packageID,mechShopData.starterPackID,mechShopData.tokensCost,mechShopData.goldCost,mechShopData.mechName,mechShopData.description,mechShopData.isActive);
            }
         }
         dataM.premiumPackages = new Vector.<BMPremiumPackageData>();
         for each(premiumPackage in $data.general.premiumPackages)
         {
            newPremiumPackage = new BMPremiumPackageData();
            newPremiumPackage.parse(premiumPackage);
            dataM.premiumPackages.push(newPremiumPackage);
         }
         dataM.premiumPackages.sort(function(param1:BMPremiumPackageData, param2:BMPremiumPackageData):Number
         {
            return param1.sortID - param2.sortID;
         });
         if($data.general.activeBoosts != null)
         {
            dataM.activeBoosts = $data.general.activeBoosts.split(",");
            dataM.activeBoostsMobile = $data.general.activeBoostsMobile.split(",");
         }
         if($data.general.resetBoostsDate != null)
         {
            BMSpecialOffersManager.gi().specialOffersResetTime = int($data.general.resetBoostsDate);
         }
         if($data.general.clanWinsGiveReward != null)
         {
            if(int($data.general.clanWinsGiveReward) == 1)
            {
               dataM.clanWinsGiveReward = true;
            }
            dataM.clanWinsRewardType = $data.general.clanWinsRewardType;
            dataM.clanWinsRewardValue = int($data.general.clanWinsRewardValue);
            dataM.clanWinsWinsRequired = int($data.general.clanWinsWinsRequired);
         }
         dataM.weeklyTopClanRewards = new Array();
         if($data.general.weeklyTopClanRewards != null)
         {
            itemsString = $data.general.weeklyTopClanRewards;
            dataM.weeklyTopClanRewards = itemsString.split(",");
            if(dataM.weeklyTopClanRewards.length > 0)
            {
               rewardSlot = dataM.weeklyTopClanRewards.length - 1;
               while(rewardSlot >= 0)
               {
                  rewardItemID = Number(dataM.weeklyTopClanRewards[rewardSlot]);
                  if(dataM.itemsDB_online[rewardItemID] == null)
                  {
                     dataM.weeklyTopClanRewards.splice(rewardSlot,1);
                  }
                  rewardSlot--;
               }
            }
         }
         dataM.rankPerLadderProgressList = $data.general.rankPerLadderProgressList;
         dataM.createLadderProgressData();
         dataM.nextWeeklyReset = String($data.nextWeeklyReset);
         dataM.updateLevelUpDB($data.experience);
         playerName = $data.playerProfile.name;
         playerLevel = uint($data.playerProfile.level);
         dataM.createProfile(dataM.ONLINE_PLAYER_ID,playerName,playerLevel);
         playerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         playerProfile.userName = dataM.userName;
         playerProfile.playerName = $data.playerProfile.name;
         if(FeatureFlags.BLOCK_SHOP == false)
         {
            playerProfile.gold = $data.playerProfile.gold;
         }
         playerProfile.geo = $data.playerProfile.geo;
         playerProfile.initialSelectedMechID = uint($data.playerProfile.selectedMechIDs.substr(0,1));
         if(FeatureFlags.BLOCK_SHOP == false)
         {
            playerProfile.tokens = $data.playerProfile.bonusTokens + $data.playerProfile.supporterTokens;
            playerProfile.tokens_supporter = $data.playerProfile.supporterTokens;
            playerProfile.tokens_bonus = $data.playerProfile.bonusTokens;
         }
         playerProfile.timeToFirstPayment = $data.playerProfile.timeToFirstPayment;
         playerProfile.tokensSpent = $data.playerProfile.tokensSpent;
         playerProfile.tokensBought = $data.playerProfile.tokensBought;
         playerProfile.initClanBossData($data.clanBossData,$data.clanBossPreviewData);
         playerProfile.inventorySizeState = new InventorySizeState($data.playerInventorySizeState);
         playerProfile.gotFreeTokensDate = $data.gotFreeTokensDate;
         dataM.DISPLAY_GET_TOKENS_COUNTER_MAX = 6;
         if(playerProfile.tokensSpent > 100)
         {
            if(playerProfile.tokensSpent > 1000)
            {
               if(playerProfile.tokensSpent > 5000)
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
         if($data.notificationsData != null)
         {
            playerProfile.addNotificationsData($data.notificationsData);
         }
         if($data.starterPackData != null)
         {
            if($data.starterPackData.costTokens == null)
            {
               playerProfile.setStarterPackData($data.starterPackData);
            }
         }
         playerProfile.improveYourMechStarterPackOffer = $data.improveYourMechItemChanges;
         serverLoginDateString = $data.playerProfile.lastLogin;
         if(serverLoginDateString != null)
         {
            serverDate = dataM.convertStringIntoDate(serverLoginDateString);
            tempDate = new Date();
            dataM.serverTimeDifferece = Math.floor((tempDate.getTime() - serverDate.getTime()) / 1000);
         }
         playerProfile.XP = $data.playerProfile.XP;
         playerProfile.level = $data.playerProfile.level;
         playerProfile.ladderProgress = $data.playerProfile.ladderProgress;
         playerProfile.currentSeasonHighestLadderProgress = $data.playerProfile.currentSeasonHighestLadderProgress;
         playerProfile.onlineWins = $data.playerProfile.onlineWins;
         playerProfile.onlineBattles = $data.playerProfile.onlineBattles;
         playerProfile.battlesVSComputer = $data.playerProfile.battlesVSComputer;
         playerProfile.winsVSComputer = $data.playerProfile.winsVSComputer;
         playerProfile.winLossStreak = $data.playerProfile.winLossStreak;
         playerProfile.lastNewsID = $data.playerProfile.lastNewsID;
         playerProfile.lastNewsIDBeforeLogin = $data.playerProfile.lastNewsID;
         playerProfile.totalGoldGained = $data.playerProfile.totalGoldGained;
         playerProfile.lastLevel = playerProfile.level;
         playerProfile.gameSettings = $data.playerProfile.settings;
         playerProfile.tutorialLevel = $data.playerProfile.tutorialLevel;
         playerProfile.lastLadderProgress = playerProfile.ladderProgress;
         playerProfile.setBattleCredits($data.playerProfile.battleCredits,"InitialData");
         playerProfile.missionID = $data.playerProfile.missionID;
         playerProfile.missionsCompleted = $data.playerProfile.missionsCompleted;
         playerProfile.missionsCompletedAtLastChallenge = playerProfile.missionsCompleted;
         playerProfile.pendingStarterPackMech = $data.playerProfile.pendingStarterPackMech;
         playerProfile.clan_tryingToJoinClanID = $data.requestedToJoinClanID;
         playerProfile.rateStatus = $data.playerProfile.rateStatus;
         playerProfile.dailyLoginStreak = $data.playerProfile.dailyLoginStreak;
         if($data.contentPackID != null)
         {
            playerProfile.contentPackID = $data.contentPackID;
         }
         storyID = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
         playerProfile.setCurrentMissionSlot($data.currentMissionSlot);
         playerProfile.currentStoryID = $data.currentStoryID;
         playerProfile.setDungeonsProgress($data.playerDungeonsData);
         if(playerProfile.currentMissionSlot > -1)
         {
            if(playerProfile.currentMissionSlot >= dataM.singlePlayerM.getMissionsDB(playerProfile.currentStoryID).length)
            {
               playerProfile.setCurrentMissionSlot(dataM.singlePlayerM.getMissionIndex(playerProfile.currentStoryID,playerProfile.currentMissionSlot));
            }
         }
         i = 0;
         while(i < dataM.singlePlayerM.getMissionsDB(storyID).length)
         {
            if(playerProfile.currentMissionSlot == dataM.singlePlayerM.getSpecificMissionDB(storyID,i).locationID)
            {
               playerProfile.setCurrentMissionSlot(i);
               break;
            }
            i++;
         }
         playerProfile.fortuneBoxFreeBoxCount = 0;
         if($data.playerProfile.fortuneBoxFreeBoxCount != null)
         {
            playerProfile.fortuneBoxFreeBoxCount = $data.playerProfile.fortuneBoxFreeBoxCount;
         }
         playerProfile.setMapProgress(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1,$data.playerProfile.mapProgress,0);
         playerProfile.setMapProgress(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1,$data.playerProfile.mapProgressHard,1);
         playerProfile.setMapProgress(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1,$data.playerProfile.mapProgressInsane,2);
         playerProfile.setMapProgress(BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2,$data.playerProfile.mapProgress1Normal,0);
         playerProfile.setMapProgress(BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2,$data.playerProfile.mapProgress1Hard,1);
         playerProfile.setMapProgress(BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2,$data.playerProfile.mapProgress1Insane,2);
         playerProfile.setMapProgress(BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3,$data.playerProfile.mapProgress3Normal,0);
         playerProfile.setMapProgress(BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3,$data.playerProfile.mapProgress3Hard,1);
         playerProfile.setMapProgress(BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3,$data.playerProfile.mapProgress3Insane,2);
         if($data.playerProfile.kinShopPurchasesData != null)
         {
            dataM.kinM.setShopPurchasesData($data.playerProfile.kinShopPurchasesData);
         }
         playerProfile.clan_bossBattlesDoneToday = $data.clanBossBattlesToday;
         playerProfile.clan_bossCoinsToCollect = $data.clanCoinsAvailableToCollect;
         dataM.raidData.updateRaidData($data.raidData);
         playerProfile.dRegistration = $data.playerProfile.dRegistration;
         playerProfile.rankingListPosition = $data.playerProfile.rankingListPosition;
         if($data.playerProfile.playTime != null)
         {
            playerProfile.playTime = $data.playerProfile.playTime;
         }
         if($data.playerProfile.firstSessionDate != null)
         {
            playerProfile.firstSessionDate = $data.playerProfile.firstSessionDate;
         }
         if(int($data.playerProfile.ageVerification) == 1)
         {
            playerProfile.ageVerification = true;
         }
         playerProfile.nextMissionBonus = $data.playerProfile.nextMissionBonus;
         playerProfile.nameChanges = $data.statistics.nameChanges;
         playerProfile.ladderWins = $data.statistics.ladderWins;
         playerProfile.setFreePackages($data.freeBoosts);
         playerProfile.shopMechsBought = new Object();
         if($data.shopMechsBought != null)
         {
            playerProfile.shopMechsBought = $data.shopMechsBought;
         }
         dataM.useFreeItemBoxes = false;
         if($data.freeItemBoxes != null)
         {
            dataM.useFreeItemBoxes = true;
            playerProfile.freeItemBoxes = int($data.freeItemBoxes);
            playerProfile.gotFreeItemBox = int($data.gotFreeItemBox);
         }
         this.setGachaMachinesData($data.gachaMachinesData);
         dataM.lastBattleCreditAddon = $data.playerProfile.lastBattleCreditAddon + 5;
         if(playerProfile.tutorialLevel >= BMTutorialManager.TUTORIAL_LEVEL_COMPLETED)
         {
            dataM.tutorialSkipped = true;
         }
         if($data.playerProfile.isAdmin == 1)
         {
            playerProfile.isAdmin = true;
         }
         playerProfile.overallRank = $data.overallRank;
         dataM.premiumAccountTime = int($data.playerProfile.dPremium);
         if(int($data.playerProfile.facebook) == 1)
         {
            dataM.lastLoginFromFacebook = true;
            playerProfile.facebook = true;
         }
         playerProfile.updateWinsTotal();
         playerProfile.playersJoinedByInvitation = $data.playerProfile.playersJoinedByInvitation;
         playerProfile.avatarLink = $data.playerProfile.avatarLink;
         if($data.playerProfile.hasOwnProperty("didOptInToBeta"))
         {
            playerProfile.didOptInToBeta = $data.playerProfile.didOptInToBeta;
         }
         playerProfile.clanID = 0;
         if($data.myClanData != null)
         {
            playerProfile.updateClanData($data.myClanData);
         }
         dataM.contentPackResolver.setRequirementData($data.general.contentPacks);
         dataM.breathingEffect = playerProfile.getSettingAsBoolean("breathing");
         dataM.movieClipParticleEffectsLevel = playerProfile.getSetting("particles");
         dataM.seeOpponentPerks = playerProfile.getSettingAsBoolean("seePerks");
         dataM.refreshMovieClipParticlesRatio();
         soundM.setMusic(playerProfile.getSettingAsBoolean("music"),false);
         soundM.setSound(playerProfile.getSettingAsBoolean("sound"));
         switch(playerProfile.getSetting("quality"))
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
      
      private function setGachaMachinesData(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Boolean = false;
         var _loc5_:BMGachaMachineData = null;
         dataM.gachaMachinesArray = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = _loc3_.hasOwnProperty("isSingleItem") ? Boolean(_loc3_.isSingleItem) : false;
            _loc5_ = new BMGachaMachineData(_loc3_.gachaMachineID,_loc3_.name,_loc3_.description,_loc3_.costGold,_loc3_.costTokens,_loc3_.costTokensDefault,_loc3_.imageNumber,_loc3_.isInShop,_loc3_.isInSale,_loc3_.isInChainDiscount,_loc3_.extraChanceItemIDs,_loc4_);
            dataM.gachaMachinesArray.push(_loc5_);
            _loc2_++;
         }
         dataM._createGacheMachineDBfromArray();
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
               if(_loc5_.type == "kit" && _loc5_.isPowerKit == false && _loc5_.isColorKit == false && _loc5_.isTransformKit == false && _loc5_.isEnhancerKit == false && _loc5_.isAscensionKit == false)
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
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         var _loc3_:Object = param1.activeSale;
         var _loc4_:Array = param1.boughtSales || [];
         if(_loc3_)
         {
            BMSalesManager.gi().setSale(_loc3_,_loc4_);
         }
         else
         {
            BMSalesManager.gi().clearSale();
         }
         var _loc5_:Object = null;
         if(BMSalesManager.gi().getSaleData() != null)
         {
            _loc5_ = param1.activeSale;
         }
         dataM.newsHandler.setNews(param1.news,_loc5_);
      }
      
      private function doGetInitialData_clanRequests(param1:Object) : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:int = 0;
         var _loc4_:BMClanMemberData = null;
         _loc2_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         _loc2_.clan_playersRequestedToJoin = new Vector.<BMClanMemberData>();
         if(param1.clanPlayerRequests != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.clanPlayerRequests.length)
            {
               _loc4_ = new BMClanMemberData();
               _loc4_.SetData(param1.clanPlayerRequests[_loc3_]);
               _loc2_.clan_playersRequestedToJoin.push(_loc4_);
               _loc3_++;
            }
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
            _loc3_.arenaPoints = _loc2_.rankedValue;
            _loc3_.overallRankLast = _loc3_.overallRank;
            dataM.rankingList_allTime[_loc2_.playerID] = _loc3_;
         }
         dataM.clansRankingList = new Object();
      }
      
      private function doGetInitialData_boostsAndTokenPackages(param1:Object) : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:Object = null;
         var _loc4_:Number = NaN;
         var _loc5_:BMBoostData = null;
         _loc2_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         for each(_loc3_ in param1.boosts)
         {
            _loc4_ = Number(_loc3_.boostID);
            _loc5_ = dataM.boostsDB[_loc4_];
            if(_loc5_ == null)
            {
               _loc5_ = new BMBoostData();
               dataM.boostsDB[_loc4_] = _loc5_;
            }
            _loc5_.boostID = _loc4_;
            _loc5_.type = _loc3_.type;
            _loc5_.costTokens = _loc3_.costTokens;
            _loc5_.costTokensDefault = _loc3_.costTokensDefault;
            _loc5_.costGold = _loc3_.costGold;
            _loc5_.costGoldMaxLevel = _loc3_.costGoldMaxLevel;
            _loc5_.goldAddonPerLevel = _loc3_.goldAddonPerLevel;
            _loc5_.itemID = _loc3_.itemID;
            _loc5_.itemType = _loc3_.itemType;
            _loc5_.bonusGold = _loc3_.bonusGold;
            _loc5_.amount = _loc3_.amount;
            _loc5_.levelDifference = _loc3_.levelDifference;
            _loc5_.ratioRare = _loc3_.ratioRare;
            _loc5_.ratioEpic = _loc3_.ratioEpic;
            _loc5_.ratioLegendary = _loc3_.ratioLegendary;
            _loc5_.ratioMythical = _loc3_.ratioMythical;
            _loc5_.ratioNewMythical = _loc3_.ratioNewMythical;
            _loc5_.ratioRareDefault = _loc3_.ratioRareDefault;
            _loc5_.ratioEpicDefault = _loc3_.ratioEpicDefault;
            _loc5_.ratioLegendaryDefault = _loc3_.ratioLegendaryDefault;
            _loc5_.ratioMythicalDefault = _loc3_.ratioMythicalDefault;
            _loc5_.ratioNewMythicalDefault = _loc3_.ratioNewMythicalDefault;
            _loc5_.ratioPowerKit = _loc3_.ratioPowerKit;
            if(_loc2_.isAdmin)
            {
               _loc5_.bought = _loc3_.bought;
            }
         }
         this.setTokenPackages(param1.tokenPackages);
      }
      
      private function setTokenPackages(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Boolean = false;
         var _loc4_:BMTokenPackage = null;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return;
         }
         dataM.allTokenPackages = new Array();
         for each(_loc2_ in param1)
         {
            if(_loc2_.isActive == 1)
            {
               _loc3_ = false;
               if(_loc2_.platformID == 3)
               {
                  _loc3_ = true;
               }
               if(_loc3_)
               {
                  _loc4_ = new BMTokenPackage();
                  _loc5_ = int(_loc2_.sortID);
                  if(dataM.isPayingUser())
                  {
                     _loc5_ = int(_loc2_.buyerSortID);
                  }
                  _loc4_.initialize(_loc2_.packageID,_loc2_.platformID,_loc5_,_loc2_.tokenSystemPackageID,_loc2_.starterPackID,_loc2_.visualID,_loc2_.specialBanner,_loc2_.price,_loc2_.title,_loc2_.tokens,_loc2_.bonusFromTokens,_loc2_.extraValue);
                  dataM.allTokenPackages.push(_loc4_);
               }
            }
         }
         dataM.syncPlatformStoreProducts();
         dataM.allTokenPackages.sortOn("sortID",Array.NUMERIC);
      }
      
      private function onDataProgress(param1:ProgressEvent) : *
      {
         BMLoadingTimer.gi().updateProgress(param1.bytesLoaded,param1.bytesTotal);
      }
      
      private function doGetInitialData_loadQuests(param1:Object) : void
      {
         dataM.questsManager.parseQuestData(param1["questsData"]);
         dataM.questsManager.parsePlayerQuestData(param1["questsProgress"],param1["playerDailyQuestData"],param1["playerAchievementsQuestData"],param1["playerSaleQuestData"]);
         dataM.questsManager.dailyQuestsLastResetTime = int(param1.general.dailyQuestsLastResetTime);
      }
      
      private function allowUseOfCurrentMechsByLevel() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in dataM["playerData" + dataM.ONLINE_PLAYER_ID + "Inventory"])
         {
            if(int(_loc1_.equipped) > 0)
            {
               dataM.makeSurePlayerCanEquipThisItem(_loc1_.type,_loc1_.equipmentID);
               dataM.makeSurePlayerCanEquipThisMech(int(_loc1_.equipped));
            }
         }
      }
      
      private function doGetInitialData_finalFunctions(param1:Object) : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:uint = 0;
         var _loc9_:BMWorldMapHarvestData = null;
         var _loc10_:String = null;
         var _loc11_:Number = NaN;
         dataM.pvpWinningRewardPredictionData.updateData(param1.pvpWinningRewardPrediction);
         dataM.missionBossData = param1.missionBossData;
         TsLogger.log("doGetInitialData_finalFunctions");
         _loc2_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
         _loc2_.skills = param1.skillsData;
         _loc2_.arenaCoins = param1.arenaCoins;
         _loc2_.clanCoins = param1.clanCoins;
         _loc2_.nukes = param1.nukes;
         dataM.baseBuildingManager.updateState(param1.baseState);
         dataM.boxFragmentsManager.updateState(param1.boxFragments);
         dataM.mechBuildsM.addPendingParseData(param1.mechBuilds);
         if(param1.clanWarData != null)
         {
            dataM.clanWarsM.setClanWarData(param1.clanWarData,param1.lastClanWarData);
         }
         if(param1.clanWarRewardToCollect != null)
         {
            dataM.clanWarsM.setPendingReward(param1.clanWarRewardToCollect);
         }
         if(param1.canCollectKin != null)
         {
            _loc5_ = false;
            if(int(param1.canCollectKin) == 1)
            {
               _loc5_ = true;
            }
            dataM.kinM.canClaimKin = _loc5_;
            dataM.kinM.setChallengesDoneToday(param1.kinChallengesToday);
         }
         if(param1.chainDiscountsData != null)
         {
            dataM.chainDiscountsResolver.setChainDiscountsDataString(param1.chainDiscountsData);
            _loc2_.setChainDiscountsStatus(param1.chainDiscountsStatus);
         }
         _loc2_.itemsExtraChanceStartDate = 0;
         if(param1.itemsExtraChanceStartDate != null)
         {
            _loc2_.itemsExtraChanceStartDate = param1.itemsExtraChanceStartDate;
            dataM.itemsExtraChanceData.setData(param1.itemsExtraChanceData);
         }
         this._fixingAddItemsForNewPlayer = false;
         if(_loc2_.winsVSComputer == 0)
         {
            BMLoadingTimer.gi().hideLoading();
         }
         else
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
            {
               screensM.screenWelcomeNewExisting.removeMechs();
            }
            screensM.removeScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
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
         if(this._resetGuestData)
         {
            dataM.resetGuestSharedObject("socketM getInitialData");
            this._resetGuestData = false;
         }
         BMLoginManager.gi().endLoginFlow();
         if(dataM.runAsMobile)
         {
            _loc2_.lastDevice = "2";
         }
         else
         {
            _loc2_.lastDevice = "0";
         }
         dataM.updateProfileStarterPackData();
         this.lobby_setLastDevice(_loc2_.lastDevice);
         dataM.loadPerUserSharedObjectData();
         BMSpecialOffersManager.gi().refreshSpecialOffersBoostIDs();
         this.allowUseOfCurrentMechsByLevel();
         dataM.oneClickBoostData = null;
         _loc3_ = dataM.getGeneralSetting("oneClickBoostData",null);
         if(_loc3_ != null)
         {
            _loc6_ = JSON.parse(_loc3_);
            dataM.oneClickBoostData = new BMOneClickBoostProperties(_loc6_.recommendationMaxLevel,_loc6_.minBoostLevelsForBoost,_loc6_.itemTypesRecommendationOrder);
         }
         dataM.singlePlayerHarvestingData = null;
         _loc4_ = dataM.getGeneralSetting("singlePlayerHarvestingData",null);
         if(_loc4_ != null)
         {
            dataM.singlePlayerHarvestingData = JSON.parse(_loc4_);
            _loc2_.lastHarvestingDatesByMissionSlot = new Object();
            for each(_loc7_ in dataM.singlePlayerHarvestingData)
            {
               _loc8_ = uint(_loc7_.slot);
               _loc9_ = new BMWorldMapHarvestData(_loc8_,_loc7_.cooldown,_loc7_.gold);
               dataM.singlePlayerHarvestingData[_loc8_] = _loc9_;
               _loc10_ = "mission" + _loc9_.missionSlot + "LastHarvestDate";
               _loc11_ = 0;
               if(param1.playerProfile[_loc10_] != null)
               {
                  _loc11_ = Number(param1.playerProfile[_loc10_]);
               }
               _loc2_.lastHarvestingDatesByMissionSlot[_loc8_] = _loc11_;
            }
         }
         if(ExternalInterfaceWrapper.isAvailable())
         {
            ExternalInterfaceWrapper.initJSUserData(dataM.userID,dataM.myProfile.playerName);
            if(dataM.getGeneralSetting("promptForWebNotifications",false))
            {
               if(!dataM.installationData.didAskForPushNotifications())
               {
                  dataM.installationData.setAskedForPushNotifications();
                  ExternalInterfaceWrapper.executeLine("OneSignal.push(function() {OneSignal.registerForPushNotifications()})");
               }
            }
         }
      }
      
      private function doGetInitialData_clientOutOfDate() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("clientIsNotUpToDate",-1,-1);
         BMLoadingTimer.gi().hideLoading();
         screensM.btnDebugger.visible = true;
         if(screensM.isScreenOpened(BMScreensManager.SCR_DEBUGGER))
         {
            screensM.screenDebugger.addTrace("WARNING : " + externalAssetsM.clientNotUpToDateMessage);
         }
      }
      
      private function doGetInitialData_parseItems(param1:Object, param2:Boolean) : void
      {
         var _loc3_:Object = null;
         var _loc4_:BMItemData = null;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:Object = null;
         var _loc11_:Array = null;
         var _loc12_:String = null;
         var _loc13_:* = undefined;
         var _loc14_:int = 0;
         var _loc15_:Object = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:Array = null;
         var _loc19_:BMItemData = null;
         _loc3_ = param1;
         _loc8_ = new Object();
         _loc9_ = null;
         if(param2)
         {
            _loc9_ = new Object();
         }
         for each(_loc10_ in _loc3_)
         {
            _loc15_ = null;
            if(param2)
            {
               for(_loc17_ in _loc10_)
               {
                  _loc9_[_loc17_] = _loc10_[_loc17_];
               }
               _loc15_ = _loc9_;
            }
            else
            {
               _loc15_ = _loc10_.data;
            }
            _loc4_ = this.createItemDataFromData(_loc15_,_loc8_);
            dataM.itemsDB_online[_loc4_.itemID] = _loc4_;
            _loc5_ = _loc4_.type;
            _loc6_ = _loc4_.level;
            _loc7_ = _loc5_;
            if(_loc5_ == "kit")
            {
               if(_loc4_.HPBase > 0)
               {
                  _loc7_ = "kit_repair";
               }
               else if(_loc4_.energyBase > 0)
               {
                  _loc7_ = "kit_energy";
               }
               else if(_loc4_.heatBase > 0)
               {
                  _loc7_ = "kit_heat";
               }
               else if(_loc4_.bullets > 0)
               {
                  _loc7_ = "kit_bullets";
               }
               else if(_loc4_.rockets > 0)
               {
                  _loc7_ = "kit_rockets";
               }
               else if(_loc4_.resist1 > 0 || _loc4_.resist2 > 0 || _loc4_.resist3 > 0)
               {
                  _loc7_ = "kit_resistance";
               }
               else
               {
                  _loc7_ = "kit_power";
               }
            }
            else if(_loc5_ == "module")
            {
               if(_loc4_.HPBase > 0)
               {
                  _loc7_ = "module_armor";
               }
               else if(_loc4_.energyBase > 0 || Boolean(_loc4_.energyAddon))
               {
                  _loc7_ = "module_energy";
               }
               else if(_loc4_.heatBase > 0 || Boolean(_loc4_.heatAddon))
               {
                  _loc7_ = "module_heat";
               }
               else if(_loc4_.bullets > 0 && _loc4_.rockets > 0)
               {
                  _loc7_ = "module_bulletsAndRockets";
               }
               else if(_loc4_.bullets > 0)
               {
                  _loc7_ = "module_bullets";
               }
               else if(_loc4_.rockets > 0)
               {
                  _loc7_ = "module_rockets";
               }
               else if(_loc4_.resist1 > 0 || _loc4_.resist2 > 0 || _loc4_.resist3 > 0)
               {
                  _loc7_ = "module_resistance";
               }
            }
            if(_loc5_ != "itemsBox" && _loc4_.specialStatus != 10)
            {
               if(dataM.itemsMaxLevelsDB[_loc7_] == null)
               {
                  dataM.itemsMaxLevelsDB[_loc7_] = _loc6_;
               }
               else if(dataM.itemsMaxLevelsDB[_loc7_] < _loc6_)
               {
                  dataM.itemsMaxLevelsDB[_loc7_] = _loc6_;
               }
            }
            _loc16_ = _loc4_.subType;
            switch(_loc4_.type)
            {
               case "sideWeapon":
               case "topWeapon":
               case "module":
               case "kit":
                  _loc16_ = _loc4_.type + "_" + _loc16_;
            }
         }
         _loc11_ = [];
         for(_loc12_ in _loc8_)
         {
            _loc11_.push(int(_loc12_));
         }
         _loc11_.sort();
         _loc13_ = 0;
         for each(_loc14_ in _loc11_)
         {
            _loc18_ = _loc8_[_loc14_];
            for each(_loc19_ in _loc18_)
            {
               _loc19_.finalSortID = _loc13_;
               _loc13_++;
            }
         }
      }
      
      private function applyRewardPremium(param1:BMRewardData) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerItemData = null;
         _loc2_ = new Array();
         if(param1.tokens > 0)
         {
            dataM.myProfile.tokens += param1.tokens;
            dataM.myProfile.tokens_bonus += param1.tokens;
            screensM.screenConfirmation.displayQuestionOrNotification("rewardVideosGotTokens",param1.tokens);
         }
         else if(param1.gold > 0)
         {
            dataM.myProfile.gold += param1.gold;
            screensM.screenConfirmation.displayQuestionOrNotification("rewardVideosGotGold",param1.gold);
         }
         if(param1.items != null && param1.items.length > 0)
         {
            _loc3_ = new Array();
            _loc4_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < param1.items.length)
            {
               _loc6_ = param1.items[_loc5_];
               dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,_loc6_.itemID,_loc6_.playerItemID);
               _loc3_.push(_loc6_.itemID);
               _loc4_.push(_loc6_.playerItemID);
               dataM.myProfile.newItemsPurchased.push(_loc6_.playerItemID);
               _loc5_++;
            }
            _loc2_[0] = _loc3_;
            _loc2_[1] = _loc4_;
         }
         if(param1.xp > 0)
         {
            dataM.myProfile.XP += param1.xp;
         }
         if(param1.arenaCoins > 0)
         {
            dataM.myProfile.arenaCoins += param1.arenaCoins;
         }
         if(param1.levelUpData != null)
         {
            dataM.myProfile.levelUpData = param1.levelUpData;
            dataM.myProfile.lastLevel = dataM.myProfile.level;
            dataM.myProfile.level = param1.levelUpData.newLevel;
         }
         return _loc2_;
      }
   }
}

