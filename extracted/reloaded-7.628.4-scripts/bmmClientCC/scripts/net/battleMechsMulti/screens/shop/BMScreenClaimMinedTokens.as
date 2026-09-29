package net.battleMechsMulti.screens.shop
{
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.mining.BMMineUserData;
   import net.battleMechsMulti.managers.mining.BMMineWithdrawData;
   import net.battleMechsMulti.managers.mining.BMMiningManager;
   import net.battleMechsMulti.screens.popups.BMScreenYesNoPopup;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMScreenClaimMinedTokens extends BMScreenYesNoPopup
   {
      
      private var tokensToClaim:int = -1;
      
      public function BMScreenClaimMinedTokens()
      {
         super();
      }
      
      override public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("mineTokens");
         var _loc1_:String = getScreenText("title");
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = getScreenText("claim");
         displayYesNoPopup(_loc1_,_loc2_,_loc3_,this.claimClicked,this.closeClicked,_loc4_);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         sub(BMPubSub.MINING_GOT_USER_DATA,this.gotUserData);
         sub(BMPubSub.MINING_GOT_USER_DATA_ERROR,this.gotUserDataError);
         sub(BMPubSub.MINING_WITHDRAWN_TOKENS,this.tokensClaimed);
         sub(BMPubSub.MINING_WITHDRAWN_TOKENS_ERROR,this.tokensClaimingError);
         BMMiningManager.getAvailableToClaimTokensCount();
      }
      
      private function gotUserData(param1:String, param2:BMMineUserData) : void
      {
         this.tokensToClaim = param2.tokens;
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         var _loc3_:String = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + this.tokensToClaim + "</FONT>";
         var _loc4_:String = getScreenText("youHaveTokensToClaim");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%TOKENS%",_loc3_);
         setDesc1Text(_loc4_);
         if(this.tokensToClaim == 0)
         {
            btnYes.disableMe();
         }
      }
      
      private function gotUserDataError(param1:String, param2:Object) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         var _loc3_:String = getScreenText("error");
         setDesc1Text(_loc3_);
         btnYes.disableMe();
      }
      
      private function claimClicked() : void
      {
         screensM.screenGlobalShop.removeMinedTokensIndicator();
         if(this.tokensToClaim <= 0)
         {
            BMMiningManager.openMiningPopup();
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            BMMiningManager.claimTokens();
         }
      }
      
      private function tokensClaimed(param1:String, param2:BMMineWithdrawData) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         screensM.removeScreen(BMScreensManager.SCR_CLAIM_MINED_TOKENS);
         dataM.myProfile.tokens_bonus += param2.tokens;
         dataM.myProfile.tokens += param2.tokens;
         if(screensM.isScreenOpened(BMScreensManager.SCR_GLOBAL_SHOP))
         {
            screensM.screenGlobalShop.refreshGoldTokensTexts();
         }
      }
      
      private function tokensClaimingError(param1:String, param2:Object) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         var _loc3_:String = getScreenText("error");
         setDesc1Text(_loc3_);
         btnYes.disableMe();
      }
      
      private function closeClicked() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CLAIM_MINED_TOKENS);
      }
   }
}

