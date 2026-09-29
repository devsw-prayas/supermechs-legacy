package net.battleMechsMulti.screens.inventory
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2767")]
   public class BMScreenGetItemsNoSpace extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtSlots:TextField;
      
      public var txtBody:TextField;
      
      public var continueBtn:BMBasicButton;
      
      public function BMScreenGetItemsNoSpace()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("inventory");
         this.initButton();
         this.initTexts();
      }
      
      private function initTexts() : void
      {
         updateTextAndFormat(this.txtTitle,getScreenText("title_noSpace"));
         updateTextAndFormat(this.txtBody,getScreenText("unclaimedBoxDescription"));
         var _loc1_:String = getScreenText("itemSlotsMaxed");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%VALUE1%",String(dataM.getNumOfInventoryItemsForInventorySize()));
         _loc1_ = dataM.replaceStringInText(_loc1_,"%VALUE2%",String(dataM.myProfile.inventorySizeState.maxSize));
         updateTextAndFormat(this.txtSlots,_loc1_);
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtSlots,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtBody,this);
      }
      
      private function initButton() : void
      {
         this.continueBtn.text = getScreenText("continue");
         this.continueBtn.addEventListener(BMIntractable.UP,this.onContinueClick);
      }
      
      private function onContinueClick(param1:Event) : void
      {
         this.backClicked();
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_GET_ITEMS_NO_SPACE);
         if(screensM.isScreenOpened(BMScreensManager.SCR_DISPLAY_REWARD))
         {
            screensM.screenDisplayReward.itemCardsScreenClosed();
         }
      }
   }
}

