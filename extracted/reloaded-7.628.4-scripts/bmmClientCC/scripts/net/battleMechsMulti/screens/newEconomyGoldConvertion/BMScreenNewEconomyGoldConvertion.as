package net.battleMechsMulti.screens.newEconomyGoldConvertion
{
   import com.greensock.TimelineMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.scroller.BMScrollerNew;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2124")]
   public class BMScreenNewEconomyGoldConvertion extends BMBaseScreen
   {
      
      public var mcSizer_btnLanguages:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var btnLanguages:BMButton_pictureE;
      
      public var txtTitle:TextField;
      
      public var txtDesc1:TextField;
      
      public var txtDesc2:TextField;
      
      public var txtOldGoldTitle:TextField;
      
      public var txtNewGoldTitle:TextField;
      
      public var txtOneTimeOffer:TextField;
      
      public var txtBoxTokensCost:TextField;
      
      public var txtBoxGoldCost:TextField;
      
      public var txtCurrentGold:TextField;
      
      public var txtNewGold:TextField;
      
      public var txtNewBoxes:TextField;
      
      public var txtBoxesTitle:TextField;
      
      public var mcScroller:BMScrollerNew;
      
      public var mcWarningPopup:MovieClip;
      
      public var btnBuy:BMBasicButton;
      
      public var mcArrow1:Sprite;
      
      public var mcArrow2:Sprite;
      
      public var mcArrow3:Sprite;
      
      public var mcIcons:Sprite;
      
      private var _oldGold:uint;
      
      private var _newGold:uint;
      
      private var _newGoldCost:uint;
      
      private var _boxNewGoldCost:uint;
      
      private var _boxOldGoldCost:uint;
      
      private var _boxTokensCost:uint;
      
      private var _freeBoxes:uint;
      
      private var _unconvertableNewGold:uint;
      
      private var _unconvertableOldGold:uint;
      
      private var _maxBoxes:uint;
      
      private var _selectedBoxes:uint;
      
      private var _timeline:TimelineMax;
      
      private var _guiChangedForNoBoxes:Boolean = false;
      
      public function BMScreenNewEconomyGoldConvertion()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("goldConversion");
         this.initLanguagesButton();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         this.btnBuy.addEventListener(BMIntractable.HIT,this.onBuyButtonHit);
         this.initWarningScreen();
         this.initTexts();
         this.initArrowsAnimation();
      }
      
      private function initTexts() : void
      {
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         updateTextAndFormat(this.txtDesc2,getScreenText("desc1"));
         updateTextAndFormat(this.txtDesc2,getScreenText("desc2"));
         updateTextAndFormat(this.txtOldGoldTitle,getScreenText("oldGold"));
         updateTextAndFormat(this.txtNewGoldTitle,getScreenText("newGold"));
         updateTextAndFormat(this.txtOneTimeOffer,getScreenText("oneTimeOffer"));
         updateTextAndFormat(this.txtBoxesTitle,getScreenText("boxes"));
         this.btnBuy.text = getScreenText("convert");
         updateTextAndFormat(this.mcWarningPopup.txtTitle,getScreenText("warningTitle"));
         updateTextAndFormat(this.mcWarningPopup.txtDesc1,getScreenText("warningDesc1"));
         updateTextAndFormat(this.mcWarningPopup.txtDesc2,getScreenText("warningDesc2"));
         var _loc1_:BMBasicButton = this.mcWarningPopup.btnBuyMore;
         var _loc2_:BMBasicButton = this.mcWarningPopup.btnMissOut;
         _loc1_.text = getScreenText("warningBuyMore");
         _loc2_.text = getScreenText("warningMissOut");
      }
      
      public function setData(param1:uint, param2:Object) : void
      {
         this._selectedBoxes = 0;
         this._newGoldCost = param2.newGoldCost;
         this._boxNewGoldCost = param2.boxNewGoldCost;
         this._boxOldGoldCost = this._boxNewGoldCost * this._newGoldCost;
         this._boxTokensCost = param2.boxTokensCost;
         this._freeBoxes = param2.freeBoxes;
         this._oldGold = param1;
         this._unconvertableNewGold = param2.unconvertableNewGold;
         this._unconvertableOldGold = this._unconvertableNewGold * this._newGoldCost;
         this.refreshNewGold();
         this._maxBoxes = 0;
         if(this._oldGold >= this._unconvertableOldGold + this._boxOldGoldCost)
         {
            this._maxBoxes = Math.floor((this._newGold - this._unconvertableNewGold) / this._boxNewGoldCost);
         }
         this.refreshCurrencyTexts(true);
         this.initScroller();
      }
      
      private function refreshNewGold() : void
      {
         var _loc1_:uint = this._selectedBoxes * this._boxNewGoldCost * this._newGoldCost;
         this._newGold = Math.floor((this._oldGold - _loc1_) / this._newGoldCost);
      }
      
      private function refreshCurrencyTexts(param1:Boolean = false) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         if(param1)
         {
            this.txtBoxTokensCost.text = TextUtils.getNumberWithComma(this._boxTokensCost);
            this.txtBoxGoldCost.text = TextUtils.getNumberWithComma(this._boxNewGoldCost * this._newGoldCost);
            if(this._maxBoxes == 0)
            {
               _loc3_ = false;
               if(this._guiChangedForNoBoxes == false)
               {
                  this.txtDesc2.y -= 61;
                  _loc3_ = true;
                  this.mcIcons.visible = false;
                  this.btnBuy.x -= 250;
                  this._guiChangedForNoBoxes = true;
               }
               _loc4_ = getScreenText("desc2_noBoxes");
               _loc4_ = dataM.replaceStringInText(_loc4_,"%BOXES%",String(this._freeBoxes));
               updateTextAndFormat(this.txtBoxGoldCost,"");
               updateTextAndFormat(this.txtOneTimeOffer,getScreenText("oneTimerOffer_noBoxes"));
               updateTextAndFormat(this.txtDesc2,_loc4_,TextUtils.SIZE_KEEP_CURRENT,_loc3_);
            }
         }
         var _loc2_:uint = this._oldGold - this._selectedBoxes * this._boxNewGoldCost * this._newGoldCost;
         this.txtCurrentGold.text = TextUtils.getNumberWithComma(_loc2_);
         this.txtNewGold.text = TextUtils.getNumberWithComma(this._newGold);
         this.txtNewBoxes.text = TextUtils.getNumberWithComma(this._selectedBoxes + this._freeBoxes);
      }
      
      private function initScroller() : void
      {
         if(this._maxBoxes == 0)
         {
            this.mcScroller.visible = false;
            return;
         }
         this.mcScroller.setWholeNumbers(this._maxBoxes);
         this.mcScroller.setCallback(this.scrollerCallback);
         this.mcScroller.resetSelection();
      }
      
      private function initWarningScreen() : void
      {
         this.mcWarningPopup.visible = false;
         var _loc1_:BMBasicButton = this.mcWarningPopup.btnBuyMore;
         _loc1_.addEventListener(BMIntractable.HIT,this.onBuyMoreButtonHit);
         var _loc2_:BMBasicButton = this.mcWarningPopup.btnMissOut;
         _loc2_.addEventListener(BMIntractable.HIT,this.onMissOutButtonHit);
      }
      
      private function scrollerCallback(param1:Number) : void
      {
         this._selectedBoxes = param1;
         this.refreshNewGold();
         this.refreshCurrencyTexts();
      }
      
      private function onBuyButtonHit(param1:Event) : void
      {
         if(this._selectedBoxes < this._maxBoxes)
         {
            this.mcWarningPopup.visible = true;
         }
         else
         {
            this.convertGold();
         }
      }
      
      private function onBuyMoreButtonHit(param1:Event) : void
      {
         this.mcWarningPopup.visible = false;
      }
      
      private function onMissOutButtonHit(param1:Event) : void
      {
         this.convertGold();
      }
      
      private function convertGold() : void
      {
         remoteM.socketM.convertGoldToNewEconomy(this._selectedBoxes);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      private function initArrowsAnimation() : void
      {
         this._timeline = new TimelineMax({
            "repeat":-1,
            "repeatDelay":0.5
         });
         this._timeline.set(this.mcArrow1,{"alpha":1});
         this._timeline.set(this.mcArrow2,{"alpha":0});
         this._timeline.set(this.mcArrow3,{"alpha":0});
         this._timeline.fromTo(this.mcArrow1,1,{"alpha":1},{"alpha":0});
         this._timeline.fromTo(this.mcArrow2,1,{"alpha":1},{"alpha":0},"+0.2");
         this._timeline.fromTo(this.mcArrow3,1,{"alpha":1},{"alpha":0},"+0.4");
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this._timeline.kill();
         if(screensM.isScreenOpened(BMScreensManager.SCR_LANGUAGE_SELECTION))
         {
            screensM.removeScreen(BMScreensManager.SCR_LANGUAGE_SELECTION);
         }
      }
      
      private function initLanguagesButton() : void
      {
         if(dataM.useLanguages == false)
         {
            return;
         }
         screensM.createButtonFromSizer(BMScreensManager.SCR_ECONOMY_GOLD_CONVERSION,"btnLanguages","pictureE");
         this.btnLanguages.initialize("","",dataM.getLanguageIcon(),[],this.languagesClicked,false);
         this.btnLanguages.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
      }
      
      private function languagesClicked() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_LANGUAGE_SELECTION))
         {
            screensM.removeScreen(BMScreensManager.SCR_LANGUAGE_SELECTION);
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_LANGUAGE_SELECTION);
            screensM.screenLanguageSelection.x = this.btnLanguages.x - 6;
            screensM.screenLanguageSelection.y = this.btnLanguages.y + this.btnLanguages.height + 4;
            screensM.screenLanguageSelection.refreshScreen(this.newLanguageSelected);
         }
      }
      
      private function newLanguageSelected() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            this.btnLanguages.replacePicture(dataM.getLanguageIcon());
            this.initTexts();
            this.refreshCurrencyTexts(true);
         }
      }
   }
}

