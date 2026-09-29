package net.battleMechsMulti.screens.hanger
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1438")]
   public class BMScreenHangerInsertGiftKey extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtGiftGuide:TextField;
      
      public var txtGiftGold:TextField;
      
      public var txtGiftKey:TextField;
      
      public var mcSizer_btnInsertKey:Sprite;
      
      public var mcSizer_giftIcon:Sprite;
      
      public var btnInsertKey:BMButton;
      
      public var mcTutorialArrow:MovieClip;
      
      private var _insertKeyAttempts:uint;
      
      private var _blockPlayer:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenHangerInsertGiftKey()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Sprite = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("insertGiftKey");
            screensM.createButtonFromSizer("screenHangerInsertGiftKey","btnInsertKey","regular");
            _loc1_ = this.insertKeyClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
            }
            this.btnInsertKey.changeFontSize(26);
            this.btnInsertKey.initialize(getScreenText("claimGift"),"orange",null,null,_loc1_,dataM.runAsMobile);
            this.txtGiftKey.restrict = "^<>";
            this.txtGiftKey.maxChars = 12;
            this.txtGiftKey.addEventListener(Event.CHANGE,this.inputTextChanged);
            _loc2_ = externalAssetsM.getAsset("general","interface_gift",this.mcSizer_giftIcon.width,this.mcSizer_giftIcon.height,false,false);
            _loc2_.x = this.mcSizer_giftIcon.x;
            _loc2_.y = this.mcSizer_giftIcon.y;
            this.mcIconsHolder.addChild(_loc2_);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            this.languageUpdate(true);
         }
         this.txtGiftKey.text = "";
         this._insertKeyAttempts = 0;
         this.mcTutorialArrow.gotoAndStop("animOn");
         this.inputTextChangedSub();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         TextUtils.updateTextFormat(this.txtGiftGold);
         TextUtils.updateTextFormat(this.txtGiftGuide);
         TextUtils.updateTextFormat(this.txtGiftKey);
         TextUtils.updateTextFormat(this.txtTitle);
         TextUtils.updateTextFormat(this.btnInsertKey.txtButtonName);
         if(param1)
         {
            this.btnInsertKey.setButtonName(getScreenText("claimGift"));
         }
         this.txtTitle.text = getScreenText("giftKey");
         this.txtGiftGuide.text = getScreenText("guide");
         this.txtGiftGold.htmlText = "+<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>25,000</FONT>";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("insertGiftKet_texts",[this.txtTitle,this.txtGiftGuide,this.txtGiftGold],"",this.mcIconsHolder);
         }
      }
      
      public function insertKeyClicked() : void
      {
         if(this._insertKeyAttempts < 3)
         {
            ++this._insertKeyAttempts;
            remoteM.socketM.lobby_useGift(this.txtGiftKey.text);
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         }
         else
         {
            this._blockPlayer = true;
         }
         this.inputTextChangedSub();
      }
      
      private function inputTextChanged(param1:Event) : void
      {
         this.inputTextChangedSub();
      }
      
      private function inputTextChangedSub() : void
      {
         if(this.txtGiftKey.text.length > 4 && this._blockPlayer == false)
         {
            this.btnInsertKey.enableMe();
         }
         else
         {
            this.btnInsertKey.disableMe();
         }
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened("screenHangerInsertGiftKey"))
         {
            screensM.removeScreen("screenHangerInsertGiftKey");
            this.mcTutorialArrow.gotoAndStop("animOff");
         }
      }
   }
}

