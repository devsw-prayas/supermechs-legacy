package net.battleMechsMulti.managers.kin
{
   import com.distriqt.extension.permissions.AuthorisationStatus;
   import com.distriqt.extension.permissions.Permissions;
   import com.distriqt.extension.permissions.events.AuthorisationEvent;
   import flash.events.TimerEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.utils.Timer;
   import net.battleMechsMulti.data.BMDisplayRewardData;
   import net.battleMechsMulti.managers.BMClient;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMQuestStatusUpdateData;
   import net.battleMechsMulti.screens.rewards.BMScreenDisplayReward;
   import net.battleMechsMulti.utils.BMKinClient;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMKinManager extends BMBaseClass
   {
      
      public static const MESSAGE_BET_ACCEPTED:String = "betAccepted";
      
      public static const MESSAGE_BET_CANCELLED:String = "betCancelled";
      
      public static const MESSAGE_BET_ACTIVE:String = "betActive";
      
      public static const MESSAGE_BET_WON:String = "betWon";
      
      private var _canClaimKin:Boolean;
      
      private var _pvpBetActive:Boolean;
      
      private var _bettingActive:Boolean = false;
      
      private var _accountLoaded:Boolean = false;
      
      private var kinClient:BMKinClient;
      
      private var _challengeActive:Boolean;
      
      private var _initialized:Boolean = false;
      
      private var _shopPurchasesData:Object;
      
      private var _challengesDoneToday:uint;
      
      private var _resetTimer:Timer;
      
      private var _onSuccess:Function;
      
      private var _onFail:Function;
      
      private var _lastTransactionID:String = "";
      
      private var _lastWhitelistDestination:String;
      
      private var _bettingActivatedThisSession:Boolean = false;
      
      private var lastBackupRestoreFunction:Function;
      
      public function BMKinManager()
      {
         super();
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("kin");
         this.resetKinShopItemsBoughtToday();
      }
      
      public function initialize() : void
      {
         if(this.isEnabledOnServerAndOutOfTutorial == false)
         {
            return;
         }
         if(this._initialized)
         {
            return;
         }
         this._initialized = true;
         this.kinClient = new BMKinClient();
         BMPubSub.sub(BMPubSub.MESSAGE_KIN_ACCOUNT_LOAD_SUCCESS,this.accountLoaded);
         BMPubSub.sub(BMPubSub.MESSAGE_KIN_ACCOUNT_LOAD_FAIL,this.accountLoadingFailed);
         BMPubSub.sub(BMPubSub.MESSAGE_KIN_ACCOUNT_TRANSACTION_FAIL,this.onTransactionFailed);
         BMPubSub.sub(BMPubSub.MESSAGE_KIN_ACCOUNT_TRANSACTION_SUCCESS,this.onTransactionSuccess);
         BMPubSub.sub(BMPubSub.MESSAGE_KIN_ACCOUNT_BALANCE_UPDATED,this.onBalanceUpdate);
         BMPubSub.sub(BMPubSub.MESSAGE_KIN_ACCOUNT_ONBOARDING_REQUIRED,this.onOnboardingRequested);
         BMPubSub.sub(BMPubSub.MESSAGE_KIN_ACCOUNT_BUILD_WHITELISTABLE_TRANSACTION_SUCCESS,this.onBuildWhitelistableTransactionSuccess);
         this.kinClient.initialize(this.isKinTestEnvironment);
         this._resetTimer = new Timer(dataM.questsManager.getDailyQuestsSecLeft() * 1000,1);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.dayEnded);
         this._resetTimer.start();
      }
      
      private function dayEnded(param1:Timer) : void
      {
         this._resetTimer.stop();
         this._resetTimer.removeEventListener(TimerEvent.TIMER,this.dayEnded);
         this.resetKinShopItemsBoughtToday();
         this.resetChallengesDoneToday();
      }
      
      private function accountLoaded(param1:String, param2:Object) : void
      {
         TsLogger.log("Kin client loaded : Address = " + this.kinClient.publicAddress);
         this._accountLoaded = true;
         if(this.isEnabledOnServerAndOutOfTutorial)
         {
            BMPubSub.pub(BMPubSub.MESSAGE_KIN_READY_FOR_DISPLAY);
         }
      }
      
      private function accountLoadingFailed(param1:String, param2:Object) : void
      {
         TsLogger.log("Kin client loading failed");
      }
      
      private function get isKinTestEnvironment() : Boolean
      {
         return dataM.getGeneralSetting("kinIsTestEnvironment",0) == 1;
      }
      
      private function get isEnabledOnServerAndOutOfTutorial() : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         if(!BMKinClient.isSupported)
         {
            return false;
         }
         if(int(dataM.getGeneralSetting("kinEnabled","0")) == 0)
         {
            return false;
         }
         if(this.kinData.kinMinXPLevel > dataM.myProfile.level)
         {
            return false;
         }
         if(int(dataM.getGeneralSetting("kinAndroidEnabled","0")) == 1)
         {
            return true;
         }
         return false;
      }
      
      public function get isEnabled() : Boolean
      {
         if(this._accountLoaded == false)
         {
            return false;
         }
         return this.isEnabledOnServerAndOutOfTutorial;
      }
      
      private function get systemWallet() : String
      {
         return dataM.getGeneralSetting("kinSystemWalletAddress","");
      }
      
      private function get challengeWallet() : String
      {
         return dataM.getGeneralSetting("kinChallengeWalletAddress","");
      }
      
      public function onKinOnboardFailed() : void
      {
         TsLogger.log("Could not onboard kin wallet");
      }
      
      public function onKinOnboardSuccess() : void
      {
         this.kinClient.refreshAccountStatus();
      }
      
      private function get shouldUseWhitelistTranscations() : Boolean
      {
         if(this.isKinTestEnvironment)
         {
            return true;
         }
         return true;
      }
      
      private function sendKin(param1:String, param2:uint, param3:String, param4:Function, param5:Function) : *
      {
         this._onSuccess = param4;
         this._onFail = param5;
         if(this.shouldUseWhitelistTranscations)
         {
            this._lastWhitelistDestination = param1;
            this.kinClient.buildWhitelistableTransaction(param1,param2,param3);
         }
         else
         {
            this.kinClient.sendKin(param1,param2,param3);
         }
      }
      
      public function buyUsingKin(param1:uint, param2:uint, param3:Function, param4:Function) : void
      {
         this.sendKin(this.systemWallet,param2,"Super Mechs Purchase",param3,param4);
      }
      
      public function placeBet(param1:Function, param2:Function) : void
      {
         this.showMessage(BMKinManager.MESSAGE_BET_ACCEPTED);
         this.sendKin(this.challengeWallet,this.pvpBet,"Super Mechs Challenge",param1,param2);
      }
      
      private function onTransactionSuccess(param1:String, param2:Object) : void
      {
         this._lastTransactionID = param2.transactionID;
         this._onSuccess();
      }
      
      private function onBuildWhitelistableTransactionSuccess(param1:String, param2:Object) : void
      {
         var _loc3_:Object = param2.whitelistableTransaction;
         remoteM.socketM.kin_whitelistTransaction(_loc3_,this._lastWhitelistDestination);
      }
      
      private function onTransactionFailed(param1:String, param2:Object) : void
      {
         this._onFail();
      }
      
      public function onKinWhitelistTransactionFailed() : void
      {
         this._onFail();
      }
      
      public function onKinWhitelistTransactionSuccess(param1:String) : *
      {
         this._lastTransactionID = param1;
         this._onSuccess();
      }
      
      private function onBalanceUpdate(param1:String, param2:Object) : void
      {
      }
      
      private function onOnboardingRequested(param1:String, param2:Object) : void
      {
         var _loc3_:String = param2.publicAddress;
         remoteM.socketM.kin_onboard(_loc3_);
      }
      
      public function get kin() : uint
      {
         if(this.isEnabled == false)
         {
            return 0;
         }
         return this.kinClient.balance;
      }
      
      public function refreshKin() : void
      {
         if(this.isEnabled)
         {
            this.kinClient.refreshBalance();
         }
      }
      
      public function resetKinShopItemsBoughtToday() : void
      {
         this._shopPurchasesData = new Object();
         this._shopPurchasesData.lastPurchaseTime = 0;
         this._shopPurchasesData.itemPurchasedToday = new Array();
      }
      
      public function kinShopItemBought(param1:uint) : void
      {
         if(this._shopPurchasesData == null)
         {
            this.resetKinShopItemsBoughtToday();
         }
         if(this._shopPurchasesData.lastPurchaseTime < dataM.questsManager.dailyQuestsLastResetTime)
         {
            this._shopPurchasesData.itemPurchasedToday = new Array();
         }
         this._shopPurchasesData.lastPurchaseTime = dataM.currentTime;
         this._shopPurchasesData.itemPurchasedToday.push(param1);
         this.refreshKin();
      }
      
      public function isKinShopItemAvailableForPurchase(param1:uint) : Boolean
      {
         if(this._shopPurchasesData == null)
         {
            return true;
         }
         if(this._shopPurchasesData.lastPurchaseTime < dataM.questsManager.dailyQuestsLastResetTime)
         {
            return true;
         }
         if(this._shopPurchasesData.itemPurchasedToday.indexOf(param1) == -1)
         {
            return true;
         }
         return false;
      }
      
      public function setShopPurchasesData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.lastPurchaseTime == null)
         {
            return;
         }
         this._shopPurchasesData = param1;
      }
      
      public function activateBetting(param1:Boolean = false, param2:Boolean = false) : void
      {
         if(this._bettingActive)
         {
            return;
         }
         if(param1)
         {
            if(this._bettingActivatedThisSession)
            {
               return;
            }
         }
         this._bettingActivatedThisSession = true;
         this.toggleBettingState(param2);
      }
      
      public function deactivateBetting(param1:Boolean = false) : void
      {
         if(this._bettingActive)
         {
            this.toggleBettingState(param1);
         }
      }
      
      public function toggleBettingState(param1:Boolean = false) : void
      {
         if(this._bettingActive)
         {
            this._bettingActive = false;
            return;
         }
         if(this.kin >= this.pvpBet)
         {
            this._bettingActive = true;
            return;
         }
         if(param1 == true && this._bettingActive == false)
         {
            this.showNotEnoughKinToBetMessage();
         }
      }
      
      public function showNotEnoughKinToBetMessage(param1:Function = null) : *
      {
         var _loc2_:String = "<BR>" + getScreenText("notEnoughToBet");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%VALUE%",String(this.pvpBet));
         screensM.screenConfirmation.displayCustomMessage(_loc2_,param1);
      }
      
      public function get bettingActive() : Boolean
      {
         return this._bettingActive;
      }
      
      public function get pvpBet() : uint
      {
         return this.kinData.challengeCost;
      }
      
      public function get pvpWin() : uint
      {
         if(this.challengesLeftToday > 0)
         {
            return this.pvpBet * 2 + this.kinData.challengeWinBonus;
         }
         return this.pvpBet * 2;
      }
      
      public function get kinClaimBonus() : uint
      {
         return this.kinData.claimBonus;
      }
      
      public function get pvpBetActive() : Boolean
      {
         return this._pvpBetActive;
      }
      
      public function set pvpBetActive(param1:Boolean) : void
      {
         this._pvpBetActive = param1;
      }
      
      public function get maxChallengesPerDay() : uint
      {
         return this.kinData.maxChallengesPerDay;
      }
      
      public function get challengesDoneToday() : uint
      {
         return this._challengesDoneToday;
      }
      
      public function get challengesLeftToday() : uint
      {
         return Math.max(0,this.maxChallengesPerDay - this._challengesDoneToday);
      }
      
      public function challengeCompleted() : void
      {
         this._challengesDoneToday += 1;
      }
      
      private function resetChallengesDoneToday() : void
      {
         this._challengesDoneToday = this.maxChallengesPerDay;
      }
      
      public function setChallengesDoneToday(param1:uint) : void
      {
         this._challengesDoneToday = param1;
      }
      
      private function get kinData() : Object
      {
         var _loc1_:String = dataM.getGeneralSetting("kinData","");
         if(_loc1_ == "")
         {
            TsLogger.log("Warning: kinData setting is invalid");
         }
         return JSON.parse(_loc1_);
      }
      
      public function get lastTransactionID() : String
      {
         return this._lastTransactionID;
      }
      
      public function set canClaimKin(param1:Boolean) : void
      {
         this._canClaimKin = param1;
      }
      
      public function get canClaimKin() : Boolean
      {
         return this._canClaimKin;
      }
      
      public function kinClaimed() : void
      {
         this._canClaimKin = false;
      }
      
      public function claimKin() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         this.canClaimKin = false;
         remoteM.socketM.kin_claim(this.kinClient.publicAddress);
      }
      
      public function onKinClaimFailed() : void
      {
         screensM.screenConfirmation.displayCustomMessage("<BR>Claim failed");
      }
      
      public function onKinClaimSuccess() : void
      {
         this.kinClient.manuallyUpdateBalance(this.kinClient.balance + this.kinClaimBonus);
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         var _loc1_:BMDisplayRewardData = new BMDisplayRewardData();
         _loc1_.type = BMScreenDisplayReward.REWARD_TYPE_KIN;
         _loc1_.amount = this.kinClaimBonus;
         var _loc2_:Array = [_loc1_];
         screensM.addScreen(BMScreensManager.SCR_DISPLAY_REWARD);
         screensM.screenDisplayReward.refreshScreen(_loc2_);
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER) == false)
         {
            return;
         }
         this.activateBetting();
         screensM.screenMultiPlayerLadder.refreshKin();
      }
      
      public function onBattleStarted(param1:Boolean) : void
      {
         if(this.isEnabled == false)
         {
            return;
         }
         this._challengeActive = false;
         if(this.bettingActive == false)
         {
            return;
         }
         if(param1)
         {
            this._challengeActive = true;
            this.showMessage(MESSAGE_BET_ACTIVE,this.pvpWin);
         }
         else
         {
            this.showMessage(MESSAGE_BET_CANCELLED);
         }
      }
      
      public function onBattleEnded(param1:Boolean) : void
      {
         if(this.isEnabled == false)
         {
            return;
         }
         if(this._challengeActive == false)
         {
            return;
         }
         if(param1)
         {
            this.showMessage(MESSAGE_BET_WON,this.pvpWin);
            this.kinClient.manuallyUpdateBalance(this.kinClient.balance + this.pvpWin);
            this.challengeCompleted();
         }
         else
         {
            this.kinClient.manuallyUpdateBalance(this.kinClient.balance - this.pvpBet);
         }
         this._challengeActive = false;
      }
      
      public function get isBackupAndRestoreSupported() : Boolean
      {
         return true;
      }
      
      private function ensurePermissionExists(param1:String) : Boolean
      {
         if(Permissions.service.authorisationStatusForPermission(param1) != AuthorisationStatus.AUTHORISED)
         {
            Permissions.service.addEventListener(AuthorisationEvent.CHANGED,this.authorisationChangedHandler);
            Permissions.service.requestAuthorisationForPermission(param1);
            return false;
         }
         return true;
      }
      
      public function backupAccount() : void
      {
         var _loc1_:File = null;
         this.lastBackupRestoreFunction = this.backupAccount;
         if(!this.ensurePermissionExists(BMClient.PERMISSION_READ_STORAGE))
         {
            return;
         }
         if(!this.ensurePermissionExists(BMClient.PERMISSION_WRITE_STORAGE))
         {
            return;
         }
         _loc1_ = File.documentsDirectory.resolvePath("KinWallet.json");
         if(_loc1_.exists)
         {
            screensM.screenConfirmation.displayCustomYesNoQuestion("Backup file already exists. Overwrite?",this.handleBackupAccountOverwriteQuestionAnswered);
         }
         else
         {
            this.handleBackupAccountOverwriteQuestionAnswered(true);
         }
      }
      
      public function restoreAccount() : void
      {
         var _loc1_:File = null;
         this.lastBackupRestoreFunction = this.restoreAccount;
         if(!this.ensurePermissionExists(BMClient.PERMISSION_READ_STORAGE))
         {
            return;
         }
         _loc1_ = File.documentsDirectory.resolvePath("KinWallet.json");
         if(_loc1_.exists)
         {
            screensM.screenConfirmation.displayCustomYesNoQuestion("Load wallet from " + _loc1_.nativePath + " ?",this.handleRestoreAccountConfirmationQuestionAnswered);
         }
         else
         {
            screensM.screenConfirmation.displayCustomMessage("Wallet file not found in " + _loc1_.nativePath);
         }
      }
      
      public function showMessage(param1:String, param2:uint = 0) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc3_:BMQuestStatusUpdateData = new BMQuestStatusUpdateData();
         _loc3_.isCompleted = true;
         _loc3_.isKin = true;
         switch(param1)
         {
            case MESSAGE_BET_ACCEPTED:
               _loc3_.title = getScreenText("kinChallenge");
               _loc3_.body = getScreenText("challengeAccepted");
               break;
            case MESSAGE_BET_CANCELLED:
               _loc3_.title = getScreenText("challengeCancelled");
               _loc3_.body = getScreenText("opponentDidNotBet");
               break;
            case MESSAGE_BET_ACTIVE:
               _loc3_.title = getScreenText("challengeStarted");
               _loc4_ = getScreenText("winnerReward");
               _loc4_ = dataM.replaceStringInText(_loc4_,"%VALUE%",String(param2));
               _loc3_.body = _loc4_;
               break;
            case MESSAGE_BET_WON:
               _loc3_.title = getScreenText("challengeWon");
               _loc5_ = getScreenText("yourReward");
               _loc5_ = dataM.replaceStringInText(_loc5_,"%VALUE%",String(param2));
               _loc3_.body = _loc5_;
         }
         screensM.addScreen(BMScreensManager.SCR_QUEST_STATUS_UPDATE);
         screensM.screenQuestStatusUpdate.showQuestStatus(_loc3_);
      }
      
      private function authorisationChangedHandler(param1:AuthorisationEvent) : void
      {
         Permissions.service.removeEventListener(AuthorisationEvent.CHANGED,this.authorisationChangedHandler);
         if(param1.status == AuthorisationStatus.AUTHORISED)
         {
            if(this.lastBackupRestoreFunction != null)
            {
               this.lastBackupRestoreFunction();
            }
         }
         else if(param1.status == AuthorisationStatus.SHOULD_EXPLAIN)
         {
            screensM.screenConfirmation.displayCustomMessage("Kin Backup And Restore requires Storage permission");
         }
         else if(param1.status == AuthorisationStatus.DENIED)
         {
            screensM.screenConfirmation.displayCustomMessage("Kin Backup And Restore requires Storage permission. Go to Settings -> Apps -> Supermechs -> Permissions -> Storage");
         }
      }
      
      private function handleBackupAccountOverwriteQuestionAnswered(param1:Boolean) : *
      {
         if(param1)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("enterKinWalletPassword_create");
         }
         else
         {
            this.createAccountPasswordCancelled();
         }
      }
      
      public function setAccountPassword(param1:String) : void
      {
         var _loc2_:File = File.documentsDirectory.resolvePath("KinWallet.json");
         var _loc3_:String = this.kinClient.exportAccountSecret(param1);
         var _loc4_:FileStream = new FileStream();
         _loc4_.open(_loc2_,FileMode.WRITE);
         _loc4_.writeUTFBytes(_loc3_);
         _loc4_.close();
         screensM.screenConfirmation.displayCustomMessage("Saved to " + _loc2_.nativePath);
      }
      
      public function createAccountPasswordCancelled() : void
      {
         screensM.screenConfirmation.displayCustomMessage("Cancelled");
      }
      
      private function handleRestoreAccountConfirmationQuestionAnswered(param1:Boolean) : void
      {
         if(param1)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("enterKinWalletPassword_restore");
         }
         else
         {
            this.restoreAccountCancelled();
         }
      }
      
      public function validateRestoreAccountPassword(param1:String) : void
      {
         var _loc2_:File = File.documentsDirectory.resolvePath("KinWallet.json");
         if(!_loc2_.exists)
         {
            screensM.screenConfirmation.displayCustomMessage("Failed loading. File not found at " + _loc2_.nativePath);
            return;
         }
         var _loc3_:FileStream = new FileStream();
         _loc3_.open(_loc2_,FileMode.READ);
         var _loc4_:String = _loc3_.readUTFBytes(_loc3_.bytesAvailable);
         _loc3_.close();
         var _loc5_:Boolean = this.kinClient.importAccountFromSecret(_loc4_,param1);
         if(_loc5_)
         {
            screensM.screenConfirmation.displayCustomMessage("Loaded from " + _loc2_.nativePath);
         }
         else
         {
            screensM.screenConfirmation.displayCustomMessage("Failed loading. Check your file and password");
         }
      }
      
      public function restoreAccountCancelled() : void
      {
         screensM.screenConfirmation.displayCustomMessage("Cancelled");
      }
   }
}

