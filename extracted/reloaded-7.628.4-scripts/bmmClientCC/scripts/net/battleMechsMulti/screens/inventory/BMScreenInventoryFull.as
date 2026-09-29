package net.battleMechsMulti.screens.inventory
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2759")]
   public class BMScreenInventoryFull extends BMBaseScreen
   {
      
      public var closeBtn:BMBasicButton;
      
      public var buyBtn:BMBasicButton;
      
      public var upgradeBtn:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var txtSlots:TextField;
      
      public var txtSubTitle:TextField;
      
      public var txtBuySlots:TextField;
      
      public var txtSlotsFree:TextField;
      
      public var txtOr:TextField;
      
      public function BMScreenInventoryFull()
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
         var _loc1_:String = getScreenText("itemSlotsMaxed");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%VALUE1%",String(dataM.myPlayerData.items.length));
         _loc1_ = dataM.replaceStringInText(_loc1_,"%VALUE2%",String(dataM.myProfile.inventorySizeState.maxSize));
         updateTextAndFormat(this.txtSlots,_loc1_);
         var _loc2_:String = getScreenText("buySlots");
         _loc2_ = dataM.replaceStringInText(_loc2_,"%VALUE%",String(dataM.myProfile.inventorySizeState.expansionSlotsIncrease));
         updateTextAndFormat(this.txtBuySlots,_loc2_);
         updateTextAndFormat(this.txtSubTitle,getScreenText("itemSlotsFull"));
         updateTextAndFormat(this.txtSlotsFree,getScreenText("freeSlots"));
         updateTextAndFormat(this.txtOr,getScreenText("or"));
         updateTextAndFormat(this.upgradeBtn.txtTitle,getScreenText("upgrade"));
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtSlots,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtSubTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtBuySlots,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtSlotsFree,this);
      }
      
      private function initButton() : void
      {
         this.closeBtn.addEventListener(BMIntractable.UP,this.onCloseClick);
         this.buyBtn.addEventListener(BMIntractable.HIT,this.onBuyClick);
         this.upgradeBtn.addEventListener(BMIntractable.HIT,this.onUpgradeClick);
         updateTextAndFormat(MovieClip(this.buyBtn).txtPrice.textField,dataM.myProfile.inventorySizeState.expansionTokensCost.toString());
      }
      
      private function onUpgradeClick(param1:Event) : void
      {
         this.backClicked();
         BMShopManager.getInstance().close();
         if(!screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE))
         {
            screensM.screenTransitionsManager.upgrade();
         }
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
         screensM.removeScreen(BMScreensManager.SCR_INVENTORY_FULL);
      }
   }
}

