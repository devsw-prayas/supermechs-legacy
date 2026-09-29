package net.battleMechsMulti.screens.inventory
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2748")]
   public class BMScreenUnclaimedBoxes extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtSlots:TextField;
      
      public var txtBody:TextField;
      
      public var claimBtn:BMBasicButton;
      
      public var closeBtn:BMBasicButton;
      
      public function BMScreenUnclaimedBoxes()
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
         updateTextAndFormat(this.txtTitle,getScreenText("title_unclaimedBoxes"));
         var _loc1_:String = getScreenText("itemSlots");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%VALUE1%",String(dataM.getNumOfInventoryItemsForInventorySize()));
         _loc1_ = dataM.replaceStringInText(_loc1_,"%VALUE2%",String(dataM.myProfile.inventorySizeState.maxSize));
         updateTextAndFormat(this.txtSlots,_loc1_);
         updateTextAndFormat(this.txtBody,getScreenText("hasUnclaimedBoxes"));
         this.claimBtn.text = getScreenText("claim");
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtSlots,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtBody,this);
      }
      
      private function initButton() : void
      {
         this.claimBtn.addEventListener(BMIntractable.UP,this.onClaimClick);
         this.closeBtn.addEventListener(BMIntractable.UP,this.onCloseClick);
      }
      
      private function onCloseClick(param1:Event) : void
      {
         this.backClicked();
      }
      
      private function onClaimClick(param1:Event) : void
      {
         this.backClicked();
         BMShopManager.gi().showUnclaimedBoxes(BMScreensManager.SCR_UNCLAIMED_BOXES);
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_UNCLAIMED_BOXES);
      }
   }
}

