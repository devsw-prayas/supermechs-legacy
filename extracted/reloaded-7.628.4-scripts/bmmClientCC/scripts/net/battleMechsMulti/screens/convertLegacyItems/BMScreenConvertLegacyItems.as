package net.battleMechsMulti.screens.convertLegacyItems
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2970")]
   public class BMScreenConvertLegacyItems extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtDescription:TextField;
      
      public var btnClose:BMBasicButton;
      
      public var btnRarity0:BMBasicButton;
      
      public var btnRarity1:BMBasicButton;
      
      public var btnRarity2:BMBasicButton;
      
      public var btnRarity3:BMBasicButton;
      
      public var btnRarity4:BMBasicButton;
      
      public var txtRarity0:TextField;
      
      public var txtRarity1:TextField;
      
      public var txtRarity2:TextField;
      
      public var txtRarity3:TextField;
      
      public var txtRarity4:TextField;
      
      public var txtRarityPower0:TextField;
      
      public var txtRarityPower1:TextField;
      
      public var txtRarityPower2:TextField;
      
      public var txtRarityPower3:TextField;
      
      public var txtRarityPower4:TextField;
      
      public function BMScreenConvertLegacyItems()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("convertLegacyItems");
         this.txtTitle.text = "LEGACY ITEM CONVERSION";
         this.txtDescription.text = "Covert you remaining legacy items into Power Units";
         this.txtRarity0.text = getGeneralText("common");
         this.txtRarity1.text = getGeneralText("rare");
         this.txtRarity2.text = getGeneralText("epic");
         this.txtRarity3.text = getGeneralText("legendary");
         this.txtRarity4.text = getGeneralText("mythical");
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.btnRarity0.addEventListener(BMIntractable.HIT,this.convert0Clicked);
         this.btnRarity1.addEventListener(BMIntractable.HIT,this.convert1Clicked);
         this.btnRarity2.addEventListener(BMIntractable.HIT,this.convert2Clicked);
         this.btnRarity3.addEventListener(BMIntractable.HIT,this.convert3Clicked);
         this.btnRarity4.addEventListener(BMIntractable.HIT,this.convert4Clicked);
         this.refreshButtonsAndTexts();
      }
      
      private function refreshButtonsAndTexts() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:BMBasicButton = null;
         var _loc1_:Array = dataM.getLegacyItemsMaterialPowerContributionPerRarity();
         var _loc2_:uint = 0;
         while(_loc2_ <= 4)
         {
            _loc3_ = uint(_loc1_[_loc2_]);
            _loc4_ = "Worth " + TextUtils.getNumberWithComma(_loc3_) + " Power";
            updateTextAndFormat(this["txtRarityPower" + _loc2_],_loc4_);
            _loc5_ = this["btnRarity" + _loc2_];
            if(_loc3_ > 0)
            {
               _loc5_.enableMe();
               _loc5_.text = "Convert";
            }
            else
            {
               _loc5_.disableMe();
               _loc5_.text = "Converted";
            }
            _loc2_++;
         }
      }
      
      public function conversionSuccess(param1:uint) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup3);
         var _loc2_:String = "CONVERSION COMPLETED";
         var _loc3_:String = "Congratulations!<BR>%AMOUNT% Power Units were added to your inventory";
         _loc3_ = dataM.replaceStringInText(_loc3_,"%AMOUNT%",String(param1));
         this.refreshButtonsAndTexts();
         screensM.screenYesNoPopup.displayYesNoPopup(_loc2_,_loc3_);
      }
      
      private function convert0Clicked(param1:Event) : void
      {
         this.convertClickedSub(0);
      }
      
      private function convert1Clicked(param1:Event) : void
      {
         this.convertClickedSub(1);
      }
      
      private function convert2Clicked(param1:Event) : void
      {
         this.convertClickedSub(2);
      }
      
      private function convert3Clicked(param1:Event) : void
      {
         this.convertClickedSub(3);
      }
      
      private function convert4Clicked(param1:Event) : void
      {
         this.convertClickedSub(4);
      }
      
      private function convertClickedSub(param1:uint) : void
      {
         var _loc2_:uint = uint(dataM.getLegacyItemsAmountPerRarity()[param1]);
         var _loc3_:uint = uint(dataM.getLegacyItemsMaterialPowerContributionPerRarity()[param1]);
         dataM.trackEvent(3,"ConvertLegacy","Convert",String(param1),_loc2_,_loc3_);
         remoteM.socketM.convertLegacyItems(param1);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      private function closeClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.hangerMechClicked();
      }
   }
}

