package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.session.LoginServices;
   import net.battleMechsMulti.utils.TextUtils;
   import net.tacticsoft.managers.BMMSessionManager;
   import net.tacticsoft.remoting.events.FaultEvent;
   import net.tacticsoft.remoting.events.ResultEvent;
   import net.tacticsoft.utils.MiscUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol113")]
   public class BMScreenRegister extends BMBaseScreen
   {
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcBlackBackground:Sprite;
      
      public var mcSizer_btnRegister:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnCopyName:Sprite;
      
      public var mcTermsOfUseLinkHitArea1:Sprite;
      
      public var mcTermsOfUseLinkHitArea2:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtErrors:TextField;
      
      public var txtUsername:TextField;
      
      public var txtPassword:TextField;
      
      public var txtPasswordRepeat:TextField;
      
      public var txtEmail:TextField;
      
      public var txtEmailDesc:TextField;
      
      public var txtTermsOfUse:TextField;
      
      public var txtInputUsername:TextField;
      
      public var txtInputPassword:TextField;
      
      public var txtInputPasswordRepeat:TextField;
      
      public var txtInputEmail:TextField;
      
      public var btnRegister:BMButton;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnCopyName:BMButton_pictureE;
      
      public var mcErrorMarkServer:Sprite;
      
      public var mcErrorMarkUsername:Sprite;
      
      public var mcErrorMarkPassword:Sprite;
      
      public var mcErrorMarkPasswordRepeat:Sprite;
      
      public var mcErrorMarkEmail:Sprite;
      
      public var mcErrorMarkTermsOfUse:Sprite;
      
      public var mcVMouseHitArea:Sprite;
      
      public var mcV:Sprite;
      
      public var mcKongBlock:Sprite;
      
      public var termsOfUseChecked:Boolean;
      
      private var currentDomain:String;
      
      public var connectToSuperMechsAccount:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenRegister()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("register");
      }
      
      private function createTextBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("register_texts",[this.txtEmail,this.txtEmailDesc,this.txtErrors,this.txtPassword,this.txtPasswordRepeat,this.txtTermsOfUse,this.txtTitle,this.txtUsername],"",this);
         }
      }
      
      public function refreshScreen(param1:Boolean = false) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         this.connectToSuperMechsAccount = param1;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenRegister","btnRegister","regular");
            screensM.createButtonFromSizer("screenRegister","btnBack","pictureE");
            screensM.createButtonFromSizer("screenRegister","btnCopyName","pictureE");
            _loc2_ = this.registerClicked;
            _loc3_ = this.backClicked;
            _loc4_ = this.copyNameClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
            }
            this.btnRegister.setRunAsMobile(dataM.runAsMobile);
            switch(dataM.languageID)
            {
               case 3:
                  this.btnRegister.changeFontSize(29);
                  break;
               case 5:
                  this.btnRegister.changeFontSize(24);
                  break;
               case 7:
                  this.btnRegister.changeFontSize(30);
                  break;
               case 9:
                  this.btnRegister.changeFontSize(25);
                  break;
               case 10:
                  this.btnRegister.changeFontSize(23);
                  break;
               default:
                  this.btnRegister.changeFontSize(33);
            }
            this.btnRegister.initialize(getGeneralText("register"),"green",null,[],_loc2_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel",0,0,false,false),[],_loc3_,dataM.runAsMobile);
            this.btnCopyName.initialize("","",null,[],_loc4_,dataM.runAsMobile);
            this.btnRegister.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.txtInputUsername.text = "";
            this.txtInputPassword.text = "";
            this.txtInputPasswordRepeat.text = "";
            this.txtInputEmail.text = "";
            this.txtInputPassword.displayAsPassword = true;
            this.txtInputPasswordRepeat.displayAsPassword = true;
            this.languageUpdate();
            if(dataM.runAsMobile == false)
            {
               this.mcVMouseHitArea.addEventListener(MouseEvent.CLICK,this.acceptTermsOfUseClicked);
               this.mcVMouseHitArea.buttonMode = true;
               this.mcVMouseHitArea.useHandCursor = true;
            }
            this.txtInputUsername.tabIndex = 1;
            this.txtInputPassword.tabIndex = 2;
            this.txtInputPasswordRepeat.tabIndex = 3;
            this.txtInputEmail.tabIndex = 4;
            if(dataM.clientRunningLocally == false)
            {
               this.btnCopyName.visible = false;
            }
            this.termsOfUseChecked = false;
            this.createTextBitmapForMobile();
            this.mcKongBlock.parent.removeChild(this.mcKongBlock);
            this.mcKongBlock = null;
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         if(screensM.isScreenOpened("screenBuyStarterPack"))
         {
            screensM.screenBuyStarterPack.removeMe();
         }
         screensM.removeScreen("screenTopBar");
         this.mcV.visible = false;
         this.termsOfUseChecked = false;
         this.btnRegister.enableMe();
         this.btnBack.enableMe();
         this.resetErrorMarkers();
         keyboardM.setKeyboardOutputFunction(this.keyboardOutput,"screenRegister");
         keyboardM.activateMe("screenRegister");
         if(this.connectToSuperMechsAccount)
         {
            this.mcBlackBackground.visible = true;
         }
         else
         {
            this.mcBlackBackground.visible = false;
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 20;
         var _loc3_:uint = 18;
         switch(dataM.languageID)
         {
            case 3:
               _loc2_ = 18;
               _loc3_ = 20;
               break;
            case 5:
               _loc2_ = 17;
               _loc3_ = 15;
               break;
            case 9:
               _loc2_ = 19;
               break;
            case 10:
               _loc2_ = 18;
         }
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtEmail,_loc2_);
            TextUtils.updateTextFormat(this.txtPassword,_loc2_);
            TextUtils.updateTextFormat(this.txtPasswordRepeat,_loc2_);
            TextUtils.updateTextFormat(this.txtUsername,_loc2_);
            TextUtils.updateTextFormat(this.txtEmailDesc,15);
            TextUtils.updateTextFormat(this.txtErrors,16);
            TextUtils.updateTextFormat(this.txtTitle,24);
            TextUtils.updateTextFormat(this.txtTermsOfUse,_loc3_);
            TextUtils.updateTextFormat(this.txtInputUsername);
            TextUtils.updateTextFormat(this.txtInputEmail);
            TextUtils.updateTextFormat(this.btnRegister.txtButtonName);
            param1 = true;
         }
         if(param1)
         {
            switch(dataM.languageID)
            {
               case 3:
                  this.btnRegister.changeFontSize(29);
                  break;
               case 5:
                  this.btnRegister.changeFontSize(24);
                  break;
               case 7:
                  this.btnRegister.changeFontSize(30);
                  break;
               case 9:
                  this.btnRegister.changeFontSize(25);
                  break;
               case 10:
                  this.btnRegister.changeFontSize(23);
                  break;
               default:
                  this.btnRegister.changeFontSize(33);
            }
            this.btnRegister.setButtonName(getGeneralText("register"));
         }
         this.txtTitle.text = getScreenText("registration");
         this.txtUsername.text = getScreenText("username");
         this.txtPassword.text = getScreenText("password");
         this.txtPasswordRepeat.text = getScreenText("repeatPassword");
         this.txtEmail.text = getScreenText("email");
         this.txtEmailDesc.text = getScreenText("emailDescription");
         var _loc4_:String = getScreenText("termsOfUse");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%COLOR%","<FONT COLOR=\'#00CCFF\'>");
         this.txtTermsOfUse.htmlText = TextUtils.getTextFont(_loc3_) + _loc4_;
      }
      
      private function resetErrorMarkers() : void
      {
         this.txtErrors.text = "";
         this.mcErrorMarkServer.visible = false;
         this.mcErrorMarkUsername.visible = false;
         this.mcErrorMarkPassword.visible = false;
         this.mcErrorMarkPasswordRepeat.visible = false;
         this.mcErrorMarkEmail.visible = false;
         this.mcErrorMarkTermsOfUse.visible = false;
         this.createTextBitmapForMobile();
      }
      
      private function acceptTermsOfUseClicked(param1:MouseEvent) : void
      {
         this.acceptTermsOfUseClickedSub();
      }
      
      public function acceptTermsOfUseClickedSub() : void
      {
         if(this.mcV.visible)
         {
            this.mcV.visible = false;
            this.termsOfUseChecked = false;
            dataM.register_termsOfUseChecked = false;
         }
         else
         {
            this.mcV.visible = true;
            this.termsOfUseChecked = true;
            dataM.register_termsOfUseChecked = true;
         }
      }
      
      private function onRegisterResult(param1:ResultEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         TsLogger.log("BMMRegistrationView :: onRegisterResult() ");
         screensM.removeScreen("screenConfirmation");
         if(param1.result is Array)
         {
            _loc2_ = "";
            for each(_loc3_ in param1.result)
            {
               if(_loc2_ == "")
               {
                  _loc2_ = _loc3_;
               }
            }
            TsLogger.log("BMMRegistrationView :: error:" + _loc2_);
            this.mcErrorMarkServer.visible = true;
            this.displayErrorMessage(_loc2_);
            this.btnRegister.enableMe();
            this.btnBack.enableMe();
         }
         else
         {
            dataM.installationData.lastLoginService = LoginServices.SUPERMECHS;
            dataM.starterPack_displayAfterOnlineBattleCounter = 3;
            dataM.starterPack_displayAfterSinglePlayerMissionCounter = 3;
            if(this.connectToSuperMechsAccount)
            {
               this.registerConnectAccount(param1);
            }
            else
            {
               if(screensM.isScreenOpened("screenDebugger"))
               {
                  screensM.screenDebugger.addTrace("$resultEvent:" + param1);
               }
               if(param1 != null)
               {
                  if(screensM.isScreenOpened("screenDebugger"))
                  {
                     screensM.screenDebugger.addTrace("$resultEvent.result:" + param1.result);
                  }
                  if(param1.result != null)
                  {
                     if(screensM.isScreenOpened("screenDebugger"))
                     {
                        screensM.screenDebugger.addTrace("$resultEvent.result.user_id:" + param1.result.user_id);
                        screensM.screenDebugger.addTrace("$resultEvent.result.pixelURL:" + param1.result.pixelURL);
                     }
                     if(param1.result.pixelURL != null)
                     {
                        if(screensM.isScreenOpened("screenDebugger"))
                        {
                           screensM.screenDebugger.addTrace("$resultEvent.result.pixelURL:" + param1.result.pixelURL);
                        }
                        if(param1.result.pixelURL != "")
                        {
                           if(screensM.isScreenOpened("screenDebugger"))
                           {
                              screensM.screenDebugger.addTrace("callFSCommandPixel");
                           }
                           _loc4_ = ExternalInterface.call("doPixelCode",param1.result.pixelURL);
                        }
                     }
                  }
               }
               dataM.allowNameChangeAfterRegister = true;
               dataM.setLastNewsIDForANewUser = true;
               if(dataM.guestRegistrationActive)
               {
                  BMLoginManager.gi().legacyTryToLogin(this.txtInputUsername.text,this.txtInputPassword.text);
               }
               else
               {
                  screensM.addScreen("screenWelcomeLogin");
                  screensM.screenWelcomeLogin.usernameFilledFromRegisterScreen = true;
                  screensM.screenWelcomeLogin.refreshScreen();
                  screensM.screenWelcomeLogin.txtInputUsername.text = this.txtInputUsername.text;
                  screensM.screenWelcomeLogin.txtInputPassword.text = this.txtInputPassword.text;
                  screensM.screenWelcomeLogin.loginClicked();
               }
               this.txtInputUsername.text = "";
               this.txtInputPassword.text = "";
               this.txtInputPasswordRepeat.text = "";
               this.txtInputEmail.text = "";
               screensM.removeScreen("screenRegister");
            }
         }
      }
      
      private function registerConnectAccount(param1:ResultEvent) : *
      {
         TsLogger.log("BMMRegistrationView :: registerConnectAccount() ");
         dataM.sessionManager.userData = param1.result;
         dataM.setFlashVarsPointer();
         if(screensM.isScreenOpened("screenProfileAccounts"))
         {
            screensM.screenProfileAccounts.refreshButtonsAndStatus();
         }
         else
         {
            screensM.addIfNotOpened("screenWelcomeLogin");
            screensM.screenWelcomeLogin.usernameFilledFromRegisterScreen = true;
            screensM.screenWelcomeLogin.refreshScreen();
            screensM.screenWelcomeLogin.txtInputUsername.text = this.txtInputUsername.text;
            screensM.screenWelcomeLogin.txtInputPassword.text = this.txtInputPassword.text;
            screensM.screenWelcomeLogin.loginClicked();
         }
         this.txtInputUsername.text = "";
         this.txtInputPassword.text = "";
         this.txtInputPasswordRepeat.text = "";
         this.txtInputEmail.text = "";
         screensM.removeScreen("screenRegister");
      }
      
      public function TEMPPIXELCODE() : void
      {
         var _loc1_:String = null;
         _loc1_ = ExternalInterface.call("doPixelCode","1234test");
      }
      
      private function onRegisterFault(param1:FaultEvent) : void
      {
         TsLogger.log("BMMRegistrationView :: onRegisterFault()");
         MiscUtils.traceObject(param1.fault,9);
         screensM.removeScreen("screenConfirmation");
         this.mcErrorMarkServer.visible = true;
         this.displayErrorMessage(param1.fault.description);
         this.btnRegister.enableMe();
         this.btnBack.enableMe();
      }
      
      private function displayErrorMessage(param1:String) : void
      {
         this.txtErrors.htmlText = TextUtils.getTextFont() + param1;
         this.createTextBitmapForMobile();
      }
      
      public function termsOfUseLinkClicked() : void
      {
         dataM.openURL("http://www.supermechs.com/tos/","_blank");
      }
      
      private function keyboardOutput(param1:Object) : void
      {
         if(param1.enter)
         {
            this.registerClicked();
         }
      }
      
      public function registerClicked() : void
      {
         this.resetErrorMarkers();
         if(this.txtInputUsername.text == "")
         {
            this.displayErrorMessage(getScreenText("usernameMissing"));
            this.mcErrorMarkUsername.visible = true;
         }
         else if(this.txtInputPassword.text == "")
         {
            this.displayErrorMessage(getScreenText("passwordMissing"));
            this.mcErrorMarkPassword.visible = true;
         }
         else if(this.txtInputPasswordRepeat.text == "")
         {
            this.displayErrorMessage(getScreenText("repeatPasswordMissing"));
            this.mcErrorMarkPasswordRepeat.visible = true;
         }
         else if(this.txtInputPassword.text != this.txtInputPasswordRepeat.text)
         {
            this.displayErrorMessage(getScreenText("passwordsDontMatch"));
            this.mcErrorMarkPassword.visible = true;
            this.mcErrorMarkPasswordRepeat.visible = true;
         }
         else if(this.txtInputEmail.text == "")
         {
            this.displayErrorMessage(getScreenText("emailMissing"));
            this.mcErrorMarkEmail.visible = true;
         }
         else if(this.mcV.visible == false)
         {
            this.displayErrorMessage(getScreenText("acceptTerms"));
            this.mcErrorMarkTermsOfUse.visible = true;
         }
         else
         {
            BMMSessionManager.gi().register([this.txtInputUsername.text,this.txtInputEmail.text,this.txtInputPassword.text],this.onRegisterResult,this.onRegisterFault);
            this.btnRegister.disableMe();
            this.btnBack.disableMe();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         }
      }
      
      public function backClicked() : void
      {
         if(this.connectToSuperMechsAccount)
         {
            this.removeMe();
         }
         else
         {
            screensM.screenBlack.activateBlackScreen(this.removeMe,true,true,null,2);
         }
      }
      
      private function removeMe() : void
      {
         keyboardM.deactivateMe();
         if(dataM.guestRegistrationActive)
         {
            screensM.screenWelcomeBackground.removeMe();
            screensM.screenNewMenu.singlePlayerClicked(true);
         }
         else
         {
            screensM.addScreen("screenWelcomeLogin");
            screensM.screenWelcomeLogin.refreshScreen(this.connectToSuperMechsAccount);
         }
         dataM.guestRegistrationActive = false;
         screensM.removeScreen("screenRegister");
      }
      
      public function copyNameClicked() : void
      {
         this.txtInputPassword.text = this.txtInputUsername.text;
         this.txtInputPasswordRepeat.text = this.txtInputUsername.text;
         this.txtInputEmail.text = this.txtInputUsername.text + "@gmail.com";
      }
   }
}

