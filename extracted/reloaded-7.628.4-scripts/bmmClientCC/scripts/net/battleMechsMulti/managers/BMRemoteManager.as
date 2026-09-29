package net.battleMechsMulti.managers
{
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMRemoteManager extends BMBaseClass
   {
      
      private static var _instance:BMRemoteManager;
      
      private static var _allowInstantiation:Boolean;
      
      public var socketM:BMSocketManager;
      
      private var _onlineReturnFunction:Function;
      
      private var _lagFrameCounter:Number;
      
      private var _playerID:Number;
      
      private var _mechID:Number;
      
      private var _targetPlayerID:Number;
      
      private var _targetMechID:Number;
      
      private var _equipmentID:Number;
      
      private var _equipmentType:String;
      
      private var _direction:String;
      
      private var _motionType:String;
      
      private var _itemID:Number;
      
      private var _inventoryTileID:Number;
      
      private var _playerItemID:Number;
      
      private var _targetStep:Number;
      
      private var _outgoingFunctionName:String;
      
      public function BMRemoteManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMRemoteManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : BMRemoteManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMRemoteManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMRemoteManager initialized");
         generateSingletonClassesPointers("remoteManager");
         this.socketM = new BMSocketManager();
         screensM.addChild(this.socketM);
         this._lagFrameCounter = 0;
      }
      
      public function establishSocketConnection() : void
      {
         TsLogger.log("BMRemoteManager :: establishSocketConnection()");
         dataM.setFlashVarsPointer();
         this.socketM.bgSocketApp();
      }
      
      public function doDisco() : void
      {
         this.socketM.disconnect();
      }
      
      public function useSocket() : Boolean
      {
         var _loc1_:Boolean = false;
         if(loginM.isConnected && tutorialM.isTutorialActive() == false)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function lobby_searchForBattle(param1:uint, param2:String = "") : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_searchForBattle(param1,param2);
         }
      }
      
      public function lobby_cancelSearchForBattle() : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_cancelSearchForBattle();
         }
      }
      
      public function lobby_finishBattleVSComputer(param1:Boolean, param2:Boolean, param3:String, param4:String, param5:uint, param6:Number, param7:Object, param8:uint, param9:Number, param10:Boolean = false, param11:Boolean = false, param12:Number = 0, param13:Number = 0, param14:Number = 0, param15:uint = 0, param16:uint = 0, param17:uint = 0) : void
      {
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_PVE:
            case BMDataManager.GAME_TYPE_PVP:
               this.socketM.lobby_finishBattleVSComputer(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15,param16,param17);
               break;
            default:
               screensM.screenBattle.finishBattleVSComputerLocally();
         }
      }
      
      public function friendship_requestFriend(param1:Number) : void
      {
         this.socketM.friendship_requestFriend(param1);
      }
      
      public function friendship_cancelRequestFriend(param1:Number) : void
      {
         this.socketM.friendship_cancelRequestFriend(param1);
      }
      
      public function friendship_acceptFriend(param1:Number) : void
      {
         this.socketM.friendship_acceptFriend(param1);
      }
      
      public function friendship_declineFriend(param1:Number) : void
      {
         this.socketM.friendship_declineFriend(param1);
      }
      
      public function friendship_removeFriend(param1:Number) : void
      {
         this.socketM.friendship_removeFriend(param1);
      }
      
      public function enterSinglePlayerLobby() : void
      {
         this.socketM.enterSinglePlayerLobby();
      }
      
      public function enterMultiplayerLobby() : void
      {
         this.socketM.enterMultiplayerLobby();
      }
      
      public function lobby_setTutorialLevel(param1:Number) : void
      {
         this.socketM.lobby_setTutorialLevel(param1);
      }
      
      public function lobby_addIgnore(param1:Number) : void
      {
         this.socketM.lobby_addIgnore(param1);
      }
      
      public function lobby_removeIgnore(param1:Number) : void
      {
         this.socketM.lobby_removeIgnore(param1);
      }
      
      public function lobby_craftMythical(param1:Array, param2:String) : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_craftMythical(param1,param2);
         }
      }
      
      public function lobby_replaySave(param1:Number) : void
      {
         this.socketM.lobby_replaySave(param1);
      }
      
      public function lobby_replayUnsave(param1:Number) : void
      {
         this.socketM.lobby_replayUnsave(param1);
      }
      
      public function lobby_rankingList() : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_rankingList();
         }
      }
      
      public function lobby_startedBattleVSComputer(param1:Number) : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVE)
         {
            this.socketM.lobby_startedBattleVSComputer(param1);
         }
      }
      
      public function lobby_getPlayerReplays(param1:Number) : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_getPlayerReplays(param1);
         }
      }
      
      public function lobby_usersStatistics() : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_usersStatistics();
         }
      }
      
      public function lobby_deleteItem(param1:Number) : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVE)
         {
            this.socketM.lobby_deleteItem(param1);
         }
      }
      
      public function lobby_battleInvitation_create(param1:Number, param2:uint) : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_battleInvitation_create(param1,param2);
         }
      }
      
      public function lobby_battleInvitation_accepted(param1:Number, param2:uint) : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_battleInvitation_accepted(param1,param2);
         }
      }
      
      public function lobby_battleInvitation_declined(param1:Number) : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_battleInvitation_declined(param1);
         }
      }
      
      public function lobby_battleInvitation_canceled() : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_battleInvitation_canceled();
         }
      }
      
      public function lobby_setLastNewsID() : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_setLastNewsID();
         }
      }
      
      public function lobby_exitWorkshop() : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_exitWorkshop();
         }
      }
      
      public function lobby_setSettings(param1:String) : void
      {
         this.socketM.lobby_setSettings(param1);
      }
      
      public function lobby_changeName(param1:String) : void
      {
         this.socketM.lobby_changeName(param1);
      }
      
      public function lobby_addItemsForNewPlayer() : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVE)
         {
            this.socketM.lobby_addItemsForNewPlayer();
         }
      }
      
      public function lobby_getPlayerMechs(param1:Number) : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_getPlayerMechs(param1);
         }
      }
      
      public function battle_pickMechs(param1:String, param2:Array) : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_pickMechs(param1,param2);
         }
      }
      
      public function battle_fireWeapon(param1:String, param2:Number) : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_fireWeapon(param1,param2);
         }
         else
         {
            screensM.screenBattle.fireLocally(param1,param2);
         }
      }
      
      public function battle_moveMechToStep(param1:String, param2:Number) : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_moveMechToStep(param1,param2);
         }
         else
         {
            screensM.screenBattle.moveMechToStepLocally(param1,param2);
         }
      }
      
      public function battle_teleport(param1:Number) : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_teleport(param1);
         }
         else
         {
            screensM.screenBattle.teleportLocally(param1);
         }
      }
      
      public function battle_useKit(param1:Number) : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_useKit(param1);
         }
         else
         {
            screensM.screenBattle.useKitLocally(param1);
         }
      }
      
      public function battle_shutDown() : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_shutDown();
         }
         else
         {
            screensM.screenBattle.shutDownLocally(1);
         }
      }
      
      public function battle_forceShutDownEnded() : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_forceShutDownEnded();
         }
         else
         {
            screensM.screenBattle.forceShutDownEndedLocally();
         }
      }
      
      public function battle_switchMech(param1:uint) : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_switchMech(param1);
         }
         else
         {
            screensM.screenBattle.switchMechLocally(param1);
         }
      }
      
      public function battle_taunt(param1:Number) : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_taunt(param1);
         }
      }
      
      public function battle_droneActivate() : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_activateDrone();
         }
         else
         {
            screensM.screenBattle.activateDroneLocally();
         }
      }
      
      public function battle_droneDeactivate() : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_deactivateDrone();
         }
         else
         {
            screensM.screenBattle.deactivateDroneLocally();
         }
      }
      
      public function battle_shieldActivate() : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_activateShield();
         }
         else
         {
            screensM.screenBattle.activateShieldLocally();
         }
      }
      
      public function battle_shieldDeactivate() : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_deactivateShield();
         }
         else
         {
            screensM.screenBattle.deactivateShieldLocally();
         }
      }
      
      public function battle_charge() : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_charge();
         }
         else
         {
            screensM.screenBattle.chargeLocally();
         }
      }
      
      public function battle_harpoon() : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_harpoon();
         }
         else
         {
            screensM.screenBattle.harpoonLocally();
         }
      }
      
      public function battle_sendMessage(param1:String) : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_sendMessage(param1);
         }
      }
      
      public function battle_battleResult() : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_battleResult();
         }
      }
      
      public function battle_surrender(param1:uint = 0) : void
      {
         if(this.useSocket())
         {
            this.socketM.battle_surrender(param1);
         }
         else
         {
            screensM.screenBattle.surrenderSuccess();
         }
      }
      
      public function inventory_buyItem(param1:Number, param2:uint = 1) : void
      {
         if(this.useSocket())
         {
            this.socketM.inventory_buyItem(param1,param2);
         }
         else
         {
            BMShopManager.gi().buyItemLocally(param1,param2);
         }
      }
      
      public function inventory_updateMechs(param1:Boolean, param2:Array, param3:Array, param4:Boolean, param5:uint) : void
      {
         if(this.useSocket())
         {
            this.socketM.inventory_updateMechs(param1,param2,param3,param4,param5);
         }
         else
         {
            screensM.screenTransitionsManager.onMechItemsSaved();
         }
      }
      
      public function tokens_redeemPackage(param1:Number, param2:int) : void
      {
         this.socketM.tokens_redeemPackage(param1,param2);
      }
      
      public function tokens_buyPackageNew(param1:Number, param2:Number = 0, param3:Number = 0) : void
      {
         if(this.useSocket())
         {
            this.socketM.tokens_buyPackageNew(param1,param2,param3);
         }
         else
         {
            BMShopManager.gi().buyGachaMachineLocally(param1);
         }
      }
      
      public function lobby_upgradeSkill(param1:String) : void
      {
         if(this.useSocket())
         {
            this.socketM.lobby_upgradeSkill(param1);
         }
      }
      
      public function baseBuilding_buildStructure(param1:uint, param2:uint) : void
      {
         if(this.useSocket())
         {
            this.socketM.baseBuilding_buildStructure(param1,param2);
         }
      }
      
      public function baseBuilding_upgradeStructure(param1:uint) : void
      {
         if(this.useSocket())
         {
            this.socketM.baseBuilding_upgradeStructure(param1);
         }
      }
      
      public function baseBuilding_collectResources(param1:uint) : void
      {
         if(this.useSocket())
         {
            this.socketM.baseBuilding_collectResources(param1);
         }
      }
      
      public function baseBuilding_addToItemFactoryBuildQueue(param1:uint, param2:uint, param3:uint) : *
      {
         if(this.useSocket())
         {
            this.socketM.baseBuilding_addToItemFactoryBuildQueue(param1,param2,param3);
         }
      }
      
      public function baseBuilding_removeFromItemFactoryBuildQueue(param1:uint, param2:uint) : *
      {
         if(this.useSocket())
         {
            this.socketM.baseBuilding_removeFromItemFactoryBuildQueue(param1,param2);
         }
      }
      
      public function baseBuilding_skipBaseBuildingQueue(param1:uint, param2:uint) : *
      {
         if(this.useSocket())
         {
            this.socketM.baseBuilding_skipBaseBuildingQueue(param1,param2);
         }
      }
      
      public function baseBuilding_swapStructurePositions(param1:uint, param2:uint) : *
      {
         if(this.useSocket())
         {
            this.socketM.baseBuilding_swapStructurePositions(param1,param2);
         }
      }
      
      public function baseBuilding_optIn() : *
      {
         if(this.useSocket())
         {
            this.socketM.baseBuilding_optIn();
         }
      }
      
      public function chat_enter(param1:Number) : void
      {
         if(this.useSocket())
         {
            this.socketM.chat_enter(param1);
         }
      }
      
      public function chat_exit() : void
      {
         if(this.useSocket())
         {
            this.socketM.chat_exit();
         }
      }
      
      public function chat_sendMessage(param1:String) : void
      {
         if(this.useSocket())
         {
            this.socketM.chat_sendMessage(param1);
         }
      }
   }
}

