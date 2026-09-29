package net.battleMechsMulti.managers.singlePlayer
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMForceBuyPremiumBoxTutorialManager
   {
      
      private var highestSinglePlayerChapterFinishedWhenStartedTracking:int;
      
      private var currentTutorialStage:int = 0;
      
      private var addedScreenPubsubToken:Number;
      
      private const TUTORIAL_STAGE_START:int = 0;
      
      private const TUTORIAL_STAGE_CLICK_ON_BACK_TO_MAIN_MENU:int = 1;
      
      private const TUTORIAL_STAGE_CLICK_ON_SHOP:int = 2;
      
      private const TUTORIAL_STAGE_CLICK_PREMIUM_BOX:int = 3;
      
      private const TUTORIAL_STAGE_FINISH:int = 4;
      
      private const PREMIUM_BOX_GACHA_ID:int = 2;
      
      public function BMForceBuyPremiumBoxTutorialManager()
      {
         super();
      }
      
      public function beginTrackingUserProgress() : void
      {
         this.highestSinglePlayerChapterFinishedWhenStartedTracking = this.dataM.singlePlayerM.getHighestChapterCompleted(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1,0);
      }
      
      public function shouldStartTutorial() : Boolean
      {
         if(this.dataM.getGeneralSetting("forceBuyPremiumBoxAfterClearingFirstChapter",0) == 0)
         {
            return false;
         }
         if(this.highestSinglePlayerChapterFinishedWhenStartedTracking > 0)
         {
            return false;
         }
         var _loc1_:int = this.dataM.singlePlayerM.getHighestChapterCompleted(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1,0);
         if(_loc1_ == 0)
         {
            return false;
         }
         var _loc2_:BMGachaMachineData = this.dataM.getGacheMachine(this.PREMIUM_BOX_GACHA_ID);
         if(_loc2_ == null || !_loc2_.isInShop)
         {
            return false;
         }
         if(_loc2_.costTokens > this.dataM.myProfile.tokens)
         {
            return false;
         }
         return true;
      }
      
      public function startTutorial() : void
      {
         this.proceedToNextTutorialStage();
         this.addedScreenPubsubToken = BMPubSub.sub(BMPubSub.MESSAGE_SCREEN_OPENED,this.handleScreenOpenedDuringTutorial);
      }
      
      private function proceedToNextTutorialStage() : void
      {
         this.currentTutorialStage += 1;
         this.tutorialM.onlyClickableMovieClip = null;
         switch(this.currentTutorialStage)
         {
            case this.TUTORIAL_STAGE_CLICK_ON_BACK_TO_MAIN_MENU:
               this.screensM.screenMissionWorldMap.forceUserToExitScreen();
               break;
            case this.TUTORIAL_STAGE_CLICK_ON_SHOP:
               this.screensM.screenMainMenu.refreshButtonsForTutorial(BMTutorialManager.TUTORIAL_DESTINATION_SHOP);
               this.tutorialM.onlyClickableMovieClip = this.screensM.screenMainMenu.mcShopButton;
               break;
            case this.TUTORIAL_STAGE_CLICK_PREMIUM_BOX:
               this.screensM.screenMainMenu.refreshButtonsForTutorial();
               this.screensM.screenGlobalShop.showTutorialArrow(1,true);
               break;
            case this.TUTORIAL_STAGE_FINISH:
               BMPubSub.remove(this.addedScreenPubsubToken);
               this.addedScreenPubsubToken = 0;
         }
      }
      
      private function handleScreenOpenedDuringTutorial(param1:String, param2:Object) : *
      {
         var _loc3_:String = param2.screen;
         if(this.currentTutorialStage == this.TUTORIAL_STAGE_CLICK_ON_BACK_TO_MAIN_MENU && _loc3_ == BMScreensManager.SCR_MAIN_MENU)
         {
            this.proceedToNextTutorialStage();
         }
         if(this.currentTutorialStage == this.TUTORIAL_STAGE_CLICK_ON_SHOP && _loc3_ == BMScreensManager.SCR_GLOBAL_SHOP)
         {
            this.proceedToNextTutorialStage();
         }
         if(this.currentTutorialStage == this.TUTORIAL_STAGE_CLICK_PREMIUM_BOX && _loc3_ == BMScreensManager.SCR_SHOP_ITEM_INFO)
         {
            this.proceedToNextTutorialStage();
         }
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private function get screensM() : BMScreensManager
      {
         return BMScreensManager.getInstance();
      }
      
      private function get tutorialM() : BMTutorialManager
      {
         return BMTutorialManager.gi();
      }
   }
}

