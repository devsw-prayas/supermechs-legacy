package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureC;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureD;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1309")]
   public class BMScreenClanCreate extends BMBaseScreen
   {
      
      public var mcTextHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnCreate:Sprite;
      
      public var mcSizer_btnCancel:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtNameDescription:TextField;
      
      public var txtInputName:TextField;
      
      public var txtCostTitle:TextField;
      
      public var txtCostValue:TextField;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnCreate:BMButton_pictureD;
      
      public var btnCancel:BMButton_pictureC;
      
      public var mcInputFrame:Sprite;
      
      private var backgroundBMD:BitmapData;
      
      private var backgroundBM:Bitmap;
      
      private var _lastNotAvailableName:String;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenClanCreate()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("clanCreate");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Array = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenClanCreate","btnBack","pictureE");
            screensM.createButtonFromSizer("screenClanCreate","btnCreate","pictureD");
            screensM.createButtonFromSizer("screenClanCreate","btnCancel","pictureC");
            _loc1_ = this.backClicked;
            _loc2_ = this.createClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc1_,dataM.runAsMobile);
            this.btnCreate.initialize("","",externalAssetsM.getAsset("general","interface_V"),null,_loc2_,dataM.runAsMobile);
            this.btnCancel.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc1_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCreate.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCancel.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.txtCostValue.text = dataM.getNumberWithComma(dataM.createClanCost);
            this.languageUpdate();
            if(dataM.runAsMobile)
            {
               _loc3_ = screensM.createAssetsBitmap([],[this.mcInputFrame],0,0);
               this.backgroundBMD = _loc3_[0];
               this.backgroundBM = _loc3_[1];
               this.mcTextHolder.addChild(this.backgroundBM);
            }
            this._firstRefresh = false;
            this.txtInputName.restrict = "^<>&";
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this.txtInputName.text = "";
         this.btnCancel.enableMe();
         this.btnCreate.enableMe();
         this.btnCancel.enableMe();
      }
      
      private function languageUpdate() : void
      {
         var _loc1_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtNameDescription,20);
            TextUtils.updateTextFormat(this.txtCostTitle,20);
            _loc1_ = 26;
            TextUtils.updateTextFormat(this.txtCostValue,_loc1_);
            TextUtils.updateTextFormat(this.txtInputName,20);
         }
         this.txtTitle.text = getScreenText("title");
         this.txtNameDescription.text = getScreenText("nameDescription");
         this.txtCostTitle.text = getScreenText("cost");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("clanCreate_texts",[this.txtTitle,this.txtNameDescription,this.txtCostTitle,this.txtCostValue],"",this.mcTextHolder);
         }
      }
      
      public function createClicked() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.gold >= dataM.createClanCost)
         {
            if(this.txtInputName.text.length < 3)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("clanNameTooShort",-1,-1);
            }
            else if(this.txtInputName.text == this._lastNotAvailableName)
            {
               this.clanNameUnavailable();
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
               remoteM.socketM.clan_create(this.txtInputName.text);
            }
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("clanNotEnoughGold",-1,-1);
            this.btnCancel.disableMe();
            this.btnCreate.disableMe();
            this.btnCancel.disableMe();
         }
      }
      
      public function clanCreated() : void
      {
         screensM.addScreen("screenClanFlag");
         screensM.screenClanFlag.refreshScreen();
         screensM.screenConfirmation.displayQuestionOrNotification("clanCreated",-1,-1);
         screensM.screenNewMenu.removeCurrentScreen();
         screensM.screenNewMenu.removeMe();
         this.backClicked();
      }
      
      public function clanNameUnavailable() : void
      {
         this._lastNotAvailableName = this.txtInputName.text;
         screensM.screenConfirmation.displayQuestionOrNotification("clanNameUnavailable",-1,-1);
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen("screenClanCreate");
      }
   }
}

