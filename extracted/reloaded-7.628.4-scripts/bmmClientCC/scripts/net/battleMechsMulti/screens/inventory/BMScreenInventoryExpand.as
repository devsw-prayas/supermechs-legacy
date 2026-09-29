package net.battleMechsMulti.screens.inventory
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2763")]
   public class BMScreenInventoryExpand extends BMBaseScreen
   {
      
      public var closeBtn:BMBasicButton;
      
      public var buyBtn:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var txtSubTitle:TextField;
      
      public var txtBody:TextField;
      
      public function BMScreenInventoryExpand()
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
         updateTextAndFormat(this.txtTitle,getScreenText("title_expandItemSlots"));
         var _loc1_:String = getScreenText("itemSlots");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%VALUE1%",String(dataM.getNumOfInventoryItemsForInventorySize()));
         _loc1_ = dataM.replaceStringInText(_loc1_,"%VALUE2%",String(dataM.myProfile.inventorySizeState.maxSize));
         updateTextAndFormat(this.txtSubTitle,_loc1_);
         var _loc2_:String = getScreenText("buySlots");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%VALUE%",String(dataM.myProfile.inventorySizeState.expansionSlotsIncrease));
         updateTextAndFormat(this.txtBody,_loc2_);
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtSubTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtBody,this);
      }
      
      private function initButton() : void
      {
         this.closeBtn.addEventListener(BMIntractable.HIT,this.onCloseClick);
         this.buyBtn.addEventListener(BMIntractable.HIT,this.onBuyClick);
         MovieClip(this.buyBtn).txtPrice.text = dataM.myProfile.inventorySizeState.expansionTokensCost.toString();
      }
      
      private function onBuyClick(param1:Event) : void
      {
         this.backClicked();
         dataM.inventoryBuyExpansion();
      }
      
      private function onCloseClick(param1:Event) : void
      {
         this.backClicked();
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_INVENTORY_EXPAND);
      }
   }
}

