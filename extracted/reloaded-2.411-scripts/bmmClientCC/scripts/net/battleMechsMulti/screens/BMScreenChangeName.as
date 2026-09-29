package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureC;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureD;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol859")]
   public class BMScreenChangeName extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcTextHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnCancel:Sprite;
      
      public var mcSizer_btnChange:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtInputName:TextField;
      
      public var txtCostTitle:TextField;
      
      public var txtCostValue:TextField;
      
      public var txtFree:TextField;
      
      public var mcTokens:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnChange:BMButton_pictureD;
      
      public var btnCancel:BMButton_pictureC;
      
      private var _firstRefresh:Boolean = true;
      
      private var _changeNameTokensPrice:uint = 0;
      
      public function BMScreenChangeName()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("changeName");
         this.txtInputName.maxChars = 30;
         this.txtInputName.restrict = "^<>&";
      }
      
      public function refreshScreen() : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenChangeName","btnBack","pictureE");
            screensM.createButtonFromSizer("screenChangeName","btnChange","pictureD");
            screensM.createButtonFromSizer("screenChangeName","btnCancel","pictureC");
            _loc2_ = this.backClicked;
            _loc3_ = this.changeClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
            this.btnChange.initialize("","",externalAssetsM.getAsset("general","interface_V"),null,_loc3_,dataM.runAsMobile);
            this.btnCancel.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnChange.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCancel.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.txtInputName.text = _loc1_.playerName;
         this.txtInputName.addEventListener(Event.CHANGE,this.inputTextChanged);
         screensM.removeScreen("screenConfirmation");
         this._changeNameTokensPrice = 0;
         if(_loc1_.nameChanges == 0)
         {
            this.txtCostTitle.text = "";
            this.txtCostValue.text = "";
            this.txtFree.text = getGeneralText("free");
            this.mcTokens.visible = false;
         }
         else
         {
            this.txtCostTitle.text = getScreenText("cost");
            this._changeNameTokensPrice = dataM.nameChangeCostTokensBase + (_loc1_.nameChanges - 1) * dataM.nameChangeCostTokensAddon;
            this.txtFree.text = "";
            this.txtCostValue.text = dataM.getNumberWithComma(this._changeNameTokensPrice);
            this.mcTokens.visible = true;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("changeName_costs",[this.txtCostTitle,this.txtCostValue,this.txtFree],"",this.mcTextHolder);
         }
         this.inputTextChangedSub();
      }
      
      private function languageUpdate() : void
      {
         var _loc1_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc1_ = 20;
            switch(dataM.languageID)
            {
               case 10:
                  _loc1_ = 15;
            }
            TextUtils.updateTextFormat(this.txtCostTitle,20);
            TextUtils.updateTextFormat(this.txtCostValue,26);
            TextUtils.updateTextFormat(this.txtFree,26);
            TextUtils.updateTextFormat(this.txtInputName,20);
            TextUtils.updateTextFormat(this.txtTitle,_loc1_);
         }
         this.txtTitle.text = getScreenText("title");
      }
      
      private function inputTextChanged(param1:Event) : void
      {
         this.inputTextChangedSub();
      }
      
      private function inputTextChangedSub() : void
      {
         var _loc6_:Number = NaN;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Boolean = true;
         var _loc3_:String = this.txtInputName.text;
         var _loc4_:uint = 0;
         var _loc5_:Number = 0;
         var _loc7_:Number = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            if(_loc3_.substr(_loc6_,1) == " ")
            {
               _loc7_++;
            }
            else
            {
               _loc6_ = _loc3_.length;
            }
            _loc6_++;
         }
         if(_loc7_ > 0)
         {
            _loc3_ = _loc3_.substr(_loc7_,_loc3_.length - _loc7_);
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            if(_loc3_.substr(_loc6_,1) != " ")
            {
               _loc4_ = _loc6_;
               _loc5_++;
            }
            _loc6_++;
         }
         if(_loc4_ < _loc3_.length - 1)
         {
            _loc3_ = _loc3_.substr(0,_loc4_ + 1);
         }
         if(_loc3_.toLowerCase() == "server")
         {
            _loc2_ = false;
         }
         else if(_loc3_ == "" && _loc5_ == 0)
         {
            _loc2_ = false;
         }
         else if(_loc3_ == _loc1_.playerName)
         {
            _loc2_ = false;
         }
         if(_loc2_)
         {
            if(_loc1_.tokens >= this._changeNameTokensPrice)
            {
               this.btnChange.enableMe();
            }
            else
            {
               this.btnChange.disableMe();
            }
         }
         else
         {
            this.btnChange.disableMe();
         }
      }
      
      public function nameChanged() : void
      {
         var _loc2_:Number = NaN;
         screensM.screenConfirmation.displayQuestionOrNotification("nameChanged");
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc1_.playerName = this.txtInputName.text;
         if(this._changeNameTokensPrice > 0)
         {
            _loc2_ = this._changeNameTokensPrice;
            _loc1_.tokens -= _loc2_;
            if(_loc1_.tokens_bonus >= _loc2_)
            {
               _loc1_.tokens_bonus -= _loc2_;
            }
            else
            {
               _loc2_ -= _loc1_.tokens_bonus;
               _loc1_.tokens_bonus = 0;
               _loc1_.tokens_supporter -= _loc2_;
            }
         }
         ++_loc1_.nameChanges;
         this.removeMe();
      }
      
      public function changeClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("changeName",this._changeNameTokensPrice);
      }
      
      public function backClicked() : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         this.txtInputName.removeEventListener(Event.CHANGE,this.inputTextChanged);
         screensM.removeScreen("screenChangeName");
      }
   }
}

