package net.battleMechsMulti.screens.contentPackLibrary
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenContentPackLibrary extends BMBaseScreen
   {
      
      public var btnClose:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var contentPacksLibrary:BMContentPackLibrary;
      
      public var openedAsPopup:Boolean = false;
      
      private var loadingTime:Timer;
      
      public function BMScreenContentPackLibrary()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.loadingTime = new Timer(1000);
         this.loadingTime.addEventListener(TimerEvent.TIMER,this.onTimerTrigger);
         this.loadingTime.start();
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         setLanguageManagerScreenName("contentPackLibrary");
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
      }
      
      private function onTimerTrigger(param1:TimerEvent) : void
      {
         this.loadingTime.stop();
         this.loadingTime = null;
         var _loc2_:int = dataM.contentPackResolver.getNewUnlockedContentPackIDAndReset();
         var _loc3_:uint = 0;
         if(_loc2_ != BMContentPackResolver.NO_NEW_CONTENT_PACK_ID_UNLOCKED)
         {
            _loc3_ = uint(_loc2_);
         }
         if(_loc3_ == 0)
         {
            _loc3_ = dataM.contentPackResolver.getMyHighestContentPackID();
         }
         this.contentPacksLibrary.initialize(2,dataM.contentPackResolver.getItemsByContentPacks(),this.itemClicked,_loc3_);
         this.addPackLockedMessages();
         if(_loc2_ != BMContentPackResolver.NO_NEW_CONTENT_PACK_ID_UNLOCKED)
         {
            this.startUnlockPackAnimation(_loc2_);
         }
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
      }
      
      private function itemClicked(param1:uint, param2:int) : void
      {
         if(param2 == -1)
         {
            return;
         }
         screensM.addScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
         var _loc3_:Boolean = dataM.contentPackResolver.isPackUnlocked(param1) == false;
         screensM.screenContentPackItemInfo.showItemInfo(param2,_loc3_);
      }
      
      private function addPackLockedMessages() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:uint = 0;
         while(_loc1_ < dataM.contentPackResolver.getMaxPacks())
         {
            if(!dataM.contentPackResolver.isPackUnlocked(_loc1_))
            {
               _loc2_ = new BMContentPackLibraryPackLockedMessage();
               updateTextAndFormat(_loc2_.txtTitle,dataM.contentPackResolver.getLockedMessage(_loc1_));
               this.contentPacksLibrary.addPackLockMessage(_loc1_,_loc2_);
            }
            _loc1_++;
         }
      }
      
      public function startUnlockPackAnimation(param1:uint) : void
      {
         this.btnClose.disableMe();
         this.contentPacksLibrary.startUnlockPackAnimation(param1,this.unlockPackAnimationComplete);
      }
      
      private function unlockPackAnimationComplete() : void
      {
         this.btnClose.enableMe();
         screensM.screenConfirmation.displayQuestionOrNotification("contentPackUnlocked");
      }
      
      private function closeClicked(param1:Event) : void
      {
         if(this.openedAsPopup)
         {
            this.removeMe();
            return;
         }
         if(screensM.screenTransitionsManager.cameFromWorkshop)
         {
            screensM.screenTransitionsManager.openWorkshopSub();
            return;
         }
         if(screensM.screenTransitionsManager.cameFromSinglePlayer)
         {
            screensM.screenTransitionsManager.singlePlayerClicked();
            return;
         }
         if(screensM.screenTransitionsManager.cameFromMultiplayerLadder)
         {
            screensM.screenTransitionsManager.multiplayerLadderClicked();
            return;
         }
         screensM.screenTransitionsManager.mainMenu();
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO))
         {
            screensM.removeScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
         }
         screensM.removeScreen(BMScreensManager.SCR_CONTENT_PACK_LIBRARY);
      }
   }
}

