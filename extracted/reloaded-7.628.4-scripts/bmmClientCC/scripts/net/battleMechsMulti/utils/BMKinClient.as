package net.battleMechsMulti.utils
{
   import com.greensock.TweenMax;
   import org.kin.Kin;
   import org.kin.sdk.KinAccount;
   import org.kin.sdk.KinClient;
   import org.kin.sdk.data.Balance;
   import org.kin.sdk.enum.AccountStatus;
   import org.kin.sdk.enum.Environment;
   import org.kin.sdk.event.AccountBalanceEvent;
   import org.kin.sdk.event.AccountPaymentEvent;
   import org.kin.sdk.event.AccountStatusEvent;
   import skein.rest.rest;
   import skein.utils.StringUtil;
   
   public class BMKinClient
   {
      
      private static const FUND_KIN_AMOUNT:int = 10000;
      
      private static const URL_CREATE_ACCOUNT:String = "https://friendbot-testnet.kininfrastructure.com?addr={0}&amount=" + FUND_KIN_AMOUNT;
      
      private var _isInitialized:Boolean = false;
      
      private var _balance:uint = 0;
      
      private var _isTestEnvironment:Boolean = false;
      
      private var _postAccountCalled:Boolean = false;
      
      public var debugFailOnPurpose:Boolean = false;
      
      private var kinClient:KinClient;
      
      private var kinAccount:KinAccount;
      
      private var fee:int = 100;
      
      public function BMKinClient()
      {
         super();
      }
      
      public static function get isSupported() : Boolean
      {
         return Kin.isSupported;
      }
      
      private static function log(param1:String) : void
      {
         TsLogger.log("BMKinClient - " + param1);
      }
      
      public function initialize(param1:Boolean = true) : void
      {
         var _loc2_:Environment = null;
         this._isTestEnvironment = param1;
         if(!isSupported)
         {
            return;
         }
         _loc2_ = param1 ? Environment.test : Environment.production;
         this.kinClient = new KinClient(_loc2_,"mech");
         if(this.kinClient.hasAccount)
         {
            log("Has account, using existing");
            this.kinAccount = this.kinClient.getAccountAt(0);
         }
         else
         {
            log("Creating new Kin Account");
            this.kinAccount = this.kinClient.addAccount();
         }
         this.kinAccount.addEventListener(AccountStatusEvent.CREATE,this.handleAccountCreatedEvent,false,0,true);
         this.kinAccount.addEventListener(AccountBalanceEvent.BALANCE,this.handleBalanceChangedEvent,false,0,true);
         this.kinAccount.addEventListener(AccountPaymentEvent.PAYMENT,this.handlePaymentEvent,false,0,true);
         this.kinClient.getMinimumFee(this.handleGetMinimumKinFeeSuccess,this.handleGetMinimumKinFeeFailure);
         this._isInitialized = true;
         log("KinAccount instance created: " + this.kinAccount);
         this.refreshAccountStatus();
      }
      
      public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public function get balance() : uint
      {
         return this._balance;
      }
      
      public function manuallyUpdateBalance(param1:uint) : void
      {
         if(this._balance != param1)
         {
            this._balance = param1;
            BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_BALANCE_UPDATED);
            this.updateBalanceFromServer();
         }
      }
      
      public function refreshBalance() : void
      {
         this.updateBalanceFromServer();
      }
      
      public function get publicAddress() : String
      {
         if(this.isInitialized)
         {
            return this.kinAccount.getPublicAddress();
         }
         return null;
      }
      
      public function sendKin(param1:String, param2:uint, param3:String) : void
      {
         log("sendKin");
         if(!this.isInitialized)
         {
            BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_TRANSACTION_FAIL,{"error":"NOT INITIALIZED"});
            return;
         }
         this.kinAccount.buildAndSendTransaction(param1,param2,this.fee,param3,this.handleTransactionSuccessEvent,this.handleTransactionFailedEvent);
      }
      
      public function buildWhitelistableTransaction(param1:String, param2:uint, param3:String) : void
      {
         if(!this.isInitialized)
         {
            BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_TRANSACTION_FAIL,{"error":"NOT INITIALIZED"});
            return;
         }
         this.kinAccount.buildWhitelistableTransaction(param1,param2,0,param3,this.handleBuildWhitelistableTransactionSuccessEvent,this.handleBuildWhitelistableTransactionFailedEvent);
      }
      
      public function sendWhitelistTransaction(param1:String) : void
      {
         if(!this.isInitialized)
         {
            BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_TRANSACTION_FAIL,{"error":"NOT INITIALIZED"});
            return;
         }
         this.kinAccount.sendWhitelistTransaction(param1,this.handleTransactionSuccessEvent,this.handleTransactionFailedEvent);
      }
      
      public function startBackupFlow() : void
      {
         TweenMax.delayedCall(3,BMPubSub.pub,[BMPubSub.MESSAGE_KIN_ACCOUNT_BACKUP_FLOW_FINISHED,null]);
      }
      
      public function startRestoreFlow() : void
      {
         TweenMax.delayedCall(3,BMPubSub.pub,[BMPubSub.MESSAGE_KIN_ACCOUNT_RESTORE_FLOW_FINISHED,null]);
      }
      
      private function updateBalanceFromServer() : void
      {
         this.kinAccount.getBalance(function(param1:Balance):void
         {
            _balance = param1.value;
            BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_BALANCE_UPDATED);
         },function(param1:String):void
         {
            log("Error in updateBalanceFromServer: " + param1);
         });
      }
      
      public function refreshAccountStatus() : void
      {
         this._postAccountCalled = false;
         log("Refreshing account status");
         this.kinAccount.getStatus(this.handleKinAccountStatusSuccess,this.handleKinAccountGetStatusFailure);
      }
      
      public function exportAccountSecret(param1:String) : String
      {
         return this.kinAccount.export(param1);
      }
      
      public function importAccountFromSecret(param1:String, param2:String) : Boolean
      {
         var expectedPublicKey:String = null;
         var importedAccount:KinAccount = null;
         var newPublicAddress:* = undefined;
         var content:String = param1;
         var passphrase:String = param2;
         expectedPublicKey = null;
         try
         {
            expectedPublicKey = JSON.parse(content).pkey;
         }
         catch(e:Error)
         {
            log("Could not find expected public key : " + e.name + " " + e.message);
         }
         importedAccount = this.kinClient.importAccount(content,passphrase);
         if(importedAccount != null)
         {
            newPublicAddress = importedAccount.getPublicAddress();
            if(newPublicAddress != expectedPublicKey)
            {
               log("Public address mismatch (Probably password error) : Expected " + expectedPublicKey + " but found " + newPublicAddress);
               return false;
            }
            while(this.kinClient.getAccountAt(0).getPublicAddress() != newPublicAddress)
            {
               this.kinClient.deleteAccountAt(0);
            }
            while(this.kinClient.accountCount > 1)
            {
               this.kinClient.deleteAccountAt(1);
            }
            this.kinAccount = this.kinClient.getAccountAt(0);
            this.refreshBalance();
            return true;
         }
         return false;
      }
      
      public function handleAccountCreatedEvent(param1:AccountStatusEvent) : void
      {
         log("Account created. Status = " + param1.status.toString());
         this.postAccountCreated(param1.status);
      }
      
      private function postAccountCreated(param1:AccountStatus) : void
      {
         var accountStatus:AccountStatus = param1;
         if(this._postAccountCalled == true)
         {
            return;
         }
         this._postAccountCalled = true;
         if(accountStatus == AccountStatus.notCreated)
         {
            if(this._isTestEnvironment)
            {
               rest(StringUtil.substitute(URL_CREATE_ACCOUNT,this.kinAccount.getPublicAddress())).result(function(param1:Object):void
               {
                  log("On-boarding succeeded" + JSON.stringify(param1));
                  updateBalanceFromServer();
                  BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_LOAD_SUCCESS);
               }).error(function(param1:Object):void
               {
                  log("Error during on-boarding account: " + JSON.stringify(param1));
                  BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_LOAD_FAIL,{"error":JSON.stringify(param1)});
                  updateBalanceFromServer();
               }).get();
            }
            else
            {
               log("Production environment onboarding required");
               this._postAccountCalled = false;
               BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_ONBOARDING_REQUIRED,{"publicAddress":this.kinAccount.getPublicAddress()});
            }
         }
         else
         {
            BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_LOAD_SUCCESS);
            this.updateBalanceFromServer();
         }
      }
      
      public function handleBalanceChangedEvent(param1:AccountBalanceEvent) : void
      {
         log("Balance changed: " + param1.balance.value);
         this._balance = param1.balance.value;
         BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_BALANCE_UPDATED);
      }
      
      public function handlePaymentEvent(param1:AccountPaymentEvent) : void
      {
         log("Payment info: " + param1.paymentInfo);
      }
      
      public function handleTransactionSuccessEvent(param1:String) : *
      {
         log("Transaction Success " + param1);
         BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_TRANSACTION_SUCCESS,{"transactionID":param1});
         this.updateBalanceFromServer();
      }
      
      public function handleTransactionFailedEvent(param1:Error) : *
      {
         var _loc2_:String = param1.errorID.toString() + " " + param1.message;
         log("Transaction Failed " + _loc2_);
         BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_TRANSACTION_FAIL,{"error":_loc2_});
      }
      
      public function handleBuildWhitelistableTransactionSuccessEvent(param1:Object) : *
      {
         log("Build Whitelist Transaction Success " + JSON.stringify(param1));
         BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_BUILD_WHITELISTABLE_TRANSACTION_SUCCESS,{"whitelistableTransaction":param1});
      }
      
      public function handleBuildWhitelistableTransactionFailedEvent(param1:Error) : *
      {
         var _loc2_:String = param1.errorID.toString() + " " + param1.message;
         log("Build Whitelist Transaction Failed " + _loc2_);
         BMPubSub.pub(BMPubSub.MESSAGE_KIN_ACCOUNT_TRANSACTION_FAIL,{"error":_loc2_});
      }
      
      public function handleKinAccountStatusSuccess(param1:AccountStatus) : *
      {
         log("Kin Account get status success " + param1);
         this.postAccountCreated(param1);
      }
      
      public function handleKinAccountGetStatusFailure(param1:Error) : *
      {
         var _loc2_:String = param1.errorID.toString() + " " + param1.message;
         log("Could not get kin account" + _loc2_);
      }
      
      public function handleGetMinimumKinFeeSuccess(param1:Number) : *
      {
         log("Kin Account get minimum fee success " + param1);
         this.fee = param1;
      }
      
      public function handleGetMinimumKinFeeFailure(param1:Error) : *
      {
         var _loc2_:String = param1.errorID.toString() + " " + param1.message;
         log("Could not get minimum kin fee" + _loc2_);
         TweenMax.delayedCall(10,this.kinClient.getMinimumFee,[this.handleGetMinimumKinFeeSuccess,this.handleGetMinimumKinFeeFailure]);
      }
   }
}

