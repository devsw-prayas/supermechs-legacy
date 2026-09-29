package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMLoadingTimer;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureB;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.session.LoginServices;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.tacticsoft.global.BMMClientFlashConsts;
   import net.tacticsoft.global.BMMClientFlashVars;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol309")]
   public class BMScreenWelcomeLogin extends BMBaseScreen
   {
      
      public var mcButtonsHolder:MovieClip;
      
      public var mcSizer_btnLogin:Sprite;
      
      public var mcSizer_btnRegister:Sprite;
      
      public var mcSizer_btnFacebookLogin:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnClearGuestSharedObject:Sprite;
      
      public var mcTextInput_username:Sprite;
      
      public var mcTextInput_password:Sprite;
      
      public var mcForgotPasswordHitArea:Sprite;
      
      public var mcRememberPasswordHitArea:Sprite;
      
      public var mcBlackBackground:Sprite;
      
      public var mcRememberFrame:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtError:TextField;
      
      public var txtUsername:TextField;
      
      public var txtPassword:TextField;
      
      public var txtFacebookLogin:TextField;
      
      public var mcFacebookIcon:Sprite;
      
      public var mcRememberPasswordV:Sprite;
      
      public var txtForgotPassword:TextField;
      
      public var txtRememberPassword:TextField;
      
      public var txtInputUsername:TextField;
      
      public var txtInputPassword:TextField;
      
      public var btnLogin:BMButton;
      
      public var btnRegister:BMButton;
      
      public var btnFacebookLogin:BMButton;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnClearGuestSharedObject:BMButton_pictureB;
      
      public var mcErrorServer:Sprite;
      
      public var mcErrorUsername:Sprite;
      
      public var mcErrorPassword:Sprite;
      
      public var mcLoginBackground:MovieClip;
      
      public var mcForgotPasswordLine:Sprite;
      
      public var usernameFilledFromRegisterScreen:Boolean = false;
      
      private var _txtUsername_originXPos:Number;
      
      private var _txtUsernameInput_originXPos:Number;
      
      private var _txtPassword_originXPos:Number;
      
      private var _txtPasswordInput_originXPos:Number;
      
      private var _mcUsernameInput_originXPos:Number;
      
      private var _mcPasswordInput_originXPos:Number;
      
      private var _txtError_originXPos:Number;
      
      private var _mcError_originXPos:Number;
      
      private var _txtUsername_originYPos:Number;
      
      private var _txtPassword_originYPos:Number;
      
      private var _txtUsernameOriginWidth:Number;
      
      private var _txtErrorOriginWidth:Number;
      
      private var _mcErrorServerWidth:Number;
      
      private var _mcErrorUsernamePasswordWidth:Number;
      
      private var _firstRefresh:Boolean = true;
      
      public var connectToSuperMechsAccount:Boolean = false;
      
      private var flashVars:BMMClientFlashVars;
      
      private var pause:Timer;
      
      public function BMScreenWelcomeLogin()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this.flashVars = new BMMClientFlashVars(GlobalAccess.stage);
         setLanguageManagerScreenName("login");
      }
      
      private function createTextsBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("welcomeLogin_texts",[this.txtError,this.txtFacebookLogin,this.txtForgotPassword,this.txtPassword,this.txtTitle,this.txtUsername,this.txtRememberPassword],"",this);
         }
      }
      
      public function refreshScreen(param1:Boolean = false) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         TsLogger.log("BMScreenWelcomeLogin:refreshScreen " + param1);
         this.connectToSuperMechsAccount = param1;
         if(this._firstRefresh)
         {
            this._txtUsername_originXPos = this.txtUsername.x;
            this._txtUsernameInput_originXPos = this.txtInputUsername.x;
            this._txtPassword_originXPos = this.txtPassword.x;
            this._txtPasswordInput_originXPos = this.txtInputPassword.x;
            this._mcUsernameInput_originXPos = this.mcTextInput_username.x;
            this._mcPasswordInput_originXPos = this.mcTextInput_password.x;
            this._txtError_originXPos = this.txtError.x;
            this._mcError_originXPos = this.mcErrorServer.x;
            this._txtUsername_originYPos = this.txtUsername.y;
            this._txtPassword_originYPos = this.txtPassword.y;
            this._txtUsernameOriginWidth = this.txtUsername.width;
            this._txtErrorOriginWidth = this.txtError.width;
            this._mcErrorServerWidth = this.mcErrorServer.width;
            this._mcErrorUsernamePasswordWidth = this.mcErrorUsername.width;
            screensM.createButtonFromSizer(BMScreensManager.SCR_WELCOME_LOGIN,"btnLogin","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_WELCOME_LOGIN,"btnRegister","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_WELCOME_LOGIN,"btnFacebookLogin","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_WELCOME_LOGIN,"btnBack","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_WELCOME_LOGIN,"btnClearGuestSharedObject","pictureB");
            _loc2_ = this.loginClicked;
            _loc3_ = this.registerClicked;
            _loc4_ = this.facebookLoginClicked;
            _loc5_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
            }
            this.btnLogin.initialize("","green",null,[],_loc2_,dataM.runAsMobile);
            this.btnRegister.initialize("","orange",null,[],_loc3_,dataM.runAsMobile);
            this.btnFacebookLogin.initialize("","blue",null,[],_loc4_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc5_,dataM.runAsMobile);
            if(dataM.runAsMobile == false)
            {
               this.btnClearGuestSharedObject.initialize("","",null,[],this.clearGuestSharedObjectClicked,dataM.runAsMobile);
            }
            this.btnLogin.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnRegister.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnFacebookLogin.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            if(FeatureFlags.BLOCK_REGISTER)
            {
               this.btnRegister.visible = false;
            }
            this.txtInputPassword.displayAsPassword = true;
            this.txtInputUsername.text = "";
            this.txtInputPassword.text = "";
            this.txtError.text = "";
            this.languageUpdate();
            this.txtInputUsername.tabIndex = 1;
            this.txtInputPassword.tabIndex = 2;
            if(dataM.runAsMobile)
            {
               this.mcRememberPasswordHitArea.parent.removeChild(this.mcRememberPasswordHitArea);
               this.mcRememberPasswordHitArea = null;
               this.txtRememberPassword.text = "";
               this.mcRememberPasswordV.visible = false;
               this.mcRememberFrame.visible = false;
            }
            else
            {
               this.mcForgotPasswordHitArea.buttonMode = true;
               this.mcForgotPasswordHitArea.useHandCursor = true;
               this.mcForgotPasswordHitArea.addEventListener(MouseEvent.CLICK,this.forgotPasswordClicked);
               this.mcForgotPasswordHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.forgotPasswordMouseOver);
               this.mcForgotPasswordHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.forgotPasswordMouseOut);
               this.mcRememberPasswordHitArea.addEventListener(MouseEvent.CLICK,this.rememberPasswordClicked);
               this.mcRememberPasswordHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.rememberPasswordMouseOver);
               this.mcRememberPasswordHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.rememberPasswordMouseOut);
            }
            if(dataM.clientRunningLocally == false && this.btnClearGuestSharedObject != null)
            {
               this.btnClearGuestSharedObject.visible = false;
            }
            this.btnFacebookLogin.visible = false;
            this.mcFacebookIcon.visible = false;
            this.txtFacebookLogin.text = "";
            this.txtFacebookLogin.mouseEnabled = false;
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.resetErrorMarkers();
         keyboardM.setKeyboardOutputFunction(this.keyboardOutput,BMScreensManager.SCR_WELCOME_LOGIN);
         keyboardM.activateMe(BMScreensManager.SCR_WELCOME_LOGIN);
         this.txtInputPassword.text = "";
         if(this.connectToSuperMechsAccount)
         {
            this.mcBlackBackground.visible = true;
         }
         else
         {
            this.mcBlackBackground.visible = false;
         }
         this.mcRememberPasswordV.visible = false;
         if(this.usernameFilledFromRegisterScreen == false)
         {
            this.txtInputUsername.text = "";
            _loc6_ = dataM.getSharedObjectLastLoginUsername();
            if(_loc6_ != "" && this.txtInputUsername.text == "")
            {
               if(dataM.lastLoginFromFacebook == false)
               {
                  this.txtInputUsername.text = _loc6_;
                  _loc7_ = dataM.getSharedObjectLastPassword();
                  if(_loc7_ != "")
                  {
                     this.txtInputPassword.text = _loc7_;
                     if(dataM.runAsMobile == false)
                     {
                        this.mcRememberPasswordV.visible = true;
                     }
                  }
               }
            }
         }
         else
         {
            this.usernameFilledFromRegisterScreen = false;
         }
         this.createTextsBitmapForMobile();
      }
      
      public function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 22;
         switch(dataM.languageID)
         {
            case BMLanguageManager.LANGUAGE_RUSSIAN:
               _loc4_ = 17;
               break;
            case BMLanguageManager.LANGUAGE_ITALIAN:
               _loc4_ = 20;
               break;
            case BMLanguageManager.LANGUAGE_SPANISH:
               _loc4_ = 15;
               break;
            case BMLanguageManager.LANGUAGE_POLISH:
               _loc4_ = 18;
         }
         switch(dataM.languageID)
         {
            case BMLanguageManager.LANGUAGE_RUSSIAN:
               this.mcLoginBackground.gotoAndStop("wide");
               _loc2_ = 20;
               _loc3_ = 3;
               break;
            case BMLanguageManager.LANGUAGE_GERMAN:
            case BMLanguageManager.LANGUAGE_POLISH:
            case BMLanguageManager.LANGUAGE_HUNGARIAN:
            case BMLanguageManager.LANGUAGE_TURKISH:
               this.mcLoginBackground.gotoAndStop("wide");
               _loc2_ = 20;
               _loc3_ = 1;
               break;
            default:
               this.mcLoginBackground.gotoAndStop("regular");
         }
         this.txtUsername.x = this._txtUsername_originXPos - _loc2_;
         this.txtInputUsername.x = this._txtUsernameInput_originXPos + _loc2_;
         this.txtPassword.x = this._txtPassword_originXPos - _loc2_;
         this.txtInputPassword.x = this._txtPasswordInput_originXPos + _loc2_;
         this.mcTextInput_username.x = this._mcUsernameInput_originXPos + _loc2_;
         this.mcTextInput_password.x = this._mcPasswordInput_originXPos + _loc2_;
         this.txtError.x = this._txtError_originXPos - _loc2_;
         this.mcErrorServer.x = this._mcError_originXPos - _loc2_;
         this.mcErrorUsername.x = this._mcError_originXPos - _loc2_;
         this.mcErrorPassword.x = this._mcError_originXPos - _loc2_;
         this.btnBack.x = this.mcSizer_btnBack.x + _loc2_;
         this.txtUsername.y = this._txtUsername_originYPos + _loc3_;
         this.txtPassword.y = this._txtPassword_originYPos + _loc3_;
         this.txtInputUsername.y = this._txtUsername_originYPos + _loc3_;
         this.txtInputPassword.y = this._txtPassword_originYPos + _loc3_;
         this.txtUsername.width = this._txtUsernameOriginWidth + _loc2_ * 2;
         this.txtError.width = this._txtErrorOriginWidth + _loc2_ * 2;
         this.mcErrorServer.width = this._mcErrorServerWidth + _loc2_ * 2;
         this.mcErrorUsername.width = this._mcErrorUsernamePasswordWidth + _loc2_ * 2;
         this.mcErrorPassword.width = this._mcErrorUsernamePasswordWidth + _loc2_ * 2;
         lastLanguageID = dataM.languageID;
         this.btnLogin.setButtonName(getScreenText("login"));
         this.btnRegister.setButtonName(getGeneralText("register"));
         updateTextAndFormat(this.txtTitle,getScreenText("welcome"));
         updateTextAndFormat(this.txtUsername,getScreenText("username"),_loc4_,true);
         updateTextAndFormat(this.txtPassword,getScreenText("password"),_loc4_,true);
         updateTextAndFormat(this.txtForgotPassword,getScreenText("forgotPassword"));
         updateTextAndFormat(this.txtRememberPassword,getScreenText("rememberPassword"));
         this.mcForgotPasswordLine.width = this.txtForgotPassword.textWidth + 4;
         this.createTextsBitmapForMobile();
      }
      
      private function resetErrorMarkers() : void
      {
         this.txtError.text = "";
         this.mcErrorServer.visible = false;
         this.mcErrorUsername.visible = false;
         this.mcErrorPassword.visible = false;
         this.createTextsBitmapForMobile();
      }
      
      public function removeSavedPassword() : void
      {
         this.txtInputPassword.text = "";
         dataM.savePasswordData(this.txtInputPassword.text);
      }
      
      public function loginFailed(param1:String = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         this.refreshScreen(this.connectToSuperMechsAccount);
         BMLoadingTimer.gi().hideLoading();
         if(dataM.flashVars.port == BMMClientFlashConsts.usedPortForDev && dataM.clientRunningLocally == false)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("playingOnDev",-1,-1);
            dataM.alreadySeenPlayingOnDevAlert = true;
         }
         if(dataM.login_userTriedToLogin || this.connectToSuperMechsAccount)
         {
            dataM.login_userTriedToLogin = false;
            TsLogger.log("BMScreenWelcomeLogin :: loginFailed(" + param1 + ")");
            if(param1 != null && param1.indexOf("You have been") == 0)
            {
               _loc2_ = param1.replace("board","game");
               param1 = "AMFPHP_BANNED";
            }
            switch(param1)
            {
               case "AMFPHP_AUTH_MISMATCH":
                  this.txtError.text = "The session has expired";
                  this.mcErrorServer.visible = true;
                  this.createTextsBitmapForMobile();
                  break;
               case "ACTIVE_ERROR":
               case "LOGIN_ERROR_ATTEMPTS":
               case "LOGIN_ERROR_PASSWORD":
               case "LOGIN_ERROR_USERNAME":
                  updateTextAndFormat(this.txtError,getScreenText("wrongUsernamePassword"));
                  this.mcErrorServer.visible = true;
                  this.createTextsBitmapForMobile();
                  if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
                  {
                     screensM.screenWelcomeNewExisting.removeMechs();
                  }
                  screensM.removeScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
                  break;
               case "AMFPHP_BANNED":
                  this.txtError.text = "Banned";
                  this.mcErrorServer.visible = true;
                  this.createTextsBitmapForMobile();
                  screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup3);
                  _loc3_ = "BANNED";
                  screensM.screenYesNoPopup.displayYesNoPopup(_loc3_,_loc2_);
                  break;
               case null:
                  break;
               default:
                  updateTextAndFormat(this.txtError,getScreenText("wrongUsernamePassword"));
                  this.mcErrorServer.visible = true;
                  this.createTextsBitmapForMobile();
                  if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
                  {
                     screensM.screenWelcomeNewExisting.removeMechs();
                  }
                  screensM.removeScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
            }
            TsLogger.log("!!! LOGIN FAILED");
         }
         else
         {
            TsLogger.log("!!! NOT LOGGED IN");
            _loc4_ = dataM.getSharedObjectLastLoginUsername();
            if(_loc4_ != "" || screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_LOGIN))
            {
               screensM.addScreen(BMScreensManager.SCR_WELCOME_LOGIN);
               screensM.screenWelcomeLogin.refreshScreen();
               if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
               {
                  screensM.screenWelcomeNewExisting.removeMechs();
               }
               screensM.removeScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
            }
            else
            {
               screensM.addScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
               screensM.screenWelcomeNewExisting.refreshScreen();
            }
         }
      }
      
      public function loginSuccess() : void
      {
         TsLogger.log("!!! LOGIN SUCCESS");
         keyboardM.deactivateMe();
         screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN);
         keyboardM.removeKeyboardOutputFunction("welcomeLogin loginSuccess");
         dataM.login_userTriedToLogin = false;
      }
      
      public function showWrongUsernamePasswordError() : void
      {
         this.txtError.text = getScreenText("wrongUsernamePassword");
         this.mcErrorServer.visible = true;
      }
      
      private function forgotPasswordClicked(param1:MouseEvent) : void
      {
         this.forgotPasswordClickedSub();
      }
      
      public function forgotPasswordClickedSub() : void
      {
         soundM.createSound("buttonClick",1);
         dataM.openURL("https://supermechs.com/restore_details.php","_blank");
      }
      
      private function forgotPasswordMouseOver(param1:MouseEvent) : void
      {
         this.txtForgotPassword.textColor = 16750848;
      }
      
      private function forgotPasswordMouseOut(param1:MouseEvent) : void
      {
         this.txtForgotPassword.textColor = 14540253;
      }
      
      private function rememberPasswordClicked(param1:MouseEvent) : void
      {
         this.rememberPasswordClickedSub();
      }
      
      public function rememberPasswordClickedSub() : void
      {
         soundM.createSound("buttonClick",1);
         if(this.mcRememberPasswordV.visible)
         {
            this.mcRememberPasswordV.visible = false;
         }
         else
         {
            this.mcRememberPasswordV.visible = true;
         }
         this.saveUserNameAndPassword();
      }
      
      private function rememberPasswordMouseOver(param1:MouseEvent) : void
      {
         this.rememberPasswordMouseOverSub();
      }
      
      public function rememberPasswordMouseOverSub() : void
      {
         this.txtRememberPassword.textColor = 16750848;
         tooltip.showToolTip("regularText",getSpecificText("tooltip_rememberPassword"));
      }
      
      private function rememberPasswordMouseOut(param1:MouseEvent) : void
      {
         this.rememberPasswordMouseOutSub();
      }
      
      public function rememberPasswordMouseOutSub() : void
      {
         this.txtRememberPassword.textColor = 14540253;
         tooltip.hideToolTip();
      }
      
      private function keyboardOutput(param1:Object) : void
      {
         if(parent != null && this.btnLogin.buttonCore.isButtonEnabled())
         {
            if(param1.enter)
            {
               this.loginClicked();
            }
         }
      }
      
      public function facebookLoginClicked() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            dataM.login_userTriedToLogin = true;
            screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN);
            BMLoginManager.gi().doExternalLogin(LoginServices.FACEBOOK);
            keyboardM.removeKeyboardOutputFunction("welcomeLogin facebookLoginClicked");
            BMLoadingTimer.gi().showLoading();
         }
      }
      
      private function isInputCorrect() : Boolean
      {
         this.resetErrorMarkers();
         if(this.txtInputUsername.text == "")
         {
            updateTextAndFormat(this.txtError,getScreenText("enterUsername"));
            this.mcErrorUsername.visible = true;
            return false;
         }
         if(this.txtInputPassword.text == "")
         {
            updateTextAndFormat(this.txtError,getScreenText("enterPassword"));
            this.mcErrorPassword.visible = true;
            return false;
         }
         return true;
      }
      
      public function loginClicked() : void
      {
         if(this.connectToSuperMechsAccount)
         {
            if(this.isInputCorrect())
            {
               this.saveUserNameAndPassword();
               BMLoginManager.gi().doExternalLogin(LoginServices.SUPERMECHS,this.txtInputUsername.text,this.txtInputPassword.text);
               this.switchFromWellcomeScreenToLoading();
            }
         }
         else
         {
            TsLogger.log("screensM.screenBlack.isActive() " + screensM.screenBlack.isActive());
            if(screensM.screenBlack.isActive() == false)
            {
               if(this.isInputCorrect())
               {
                  dataM.login_userTriedToLogin = true;
                  this.saveUserNameAndPassword();
                  BMLoginManager.gi().legacyTryToLogin(this.txtInputUsername.text,this.txtInputPassword.text);
                  this.switchFromWellcomeScreenToLoading();
                  this.createTextsBitmapForMobile();
               }
            }
         }
      }
      
      private function saveUserNameAndPassword() : void
      {
         dataM.perUserSharedObject.data.lastPassword = "";
         if(dataM.runAsMobile || this.mcRememberPasswordV.visible)
         {
            dataM.perUserSharedObject.data.lastPassword = this.txtInputPassword.text;
         }
         dataM.perUserSharedObject.data.lastLoginUsername = this.txtInputUsername.text;
         try
         {
            dataM.perUserSharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("BMScreenWelcomeLogin Error: shared object couldn\'t flush");
         }
      }
      
      public function registerClicked() : void
      {
         if(FeatureFlags.BLOCK_ACCOUNT_CREATION_FEATURES)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         if(screensM.screenBlack.isActive() == false)
         {
            keyboardM.deactivateMe();
            screensM.addScreen(BMScreensManager.SCR_REGISTER);
            screensM.screenRegister.refreshScreen(this.connectToSuperMechsAccount);
            screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN);
            keyboardM.removeKeyboardOutputFunction("welcomeLogin registerClicked");
         }
      }
      
      public function backClicked() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_PROFILE_ACCOUNTS))
         {
            this.removeScreen();
            return;
         }
         if(screensM.screenBlack.isActive() == false)
         {
            if(this.connectToSuperMechsAccount)
            {
               screensM.addIfNotOpened(BMScreensManager.SCR_WELCOME_LOGIN_AS);
               screensM.screenWelcomeLoginAs.refreshScreen();
            }
            else
            {
               screensM.addScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
               screensM.screenWelcomeNewExisting.refreshScreen();
            }
            this.removeScreen();
         }
      }
      
      private function removeScreen() : void
      {
         keyboardM.deactivateMe();
         screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN);
         keyboardM.removeKeyboardOutputFunction("welcomeLogin backClicked");
      }
      
      private function clearGuestSharedObjectClicked() : void
      {
         dataM.resetGuestSharedObject("login clearGuestSharedObjectClicked");
      }
      
      private function switchFromWellcomeScreenToLoading() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN);
         keyboardM.removeKeyboardOutputFunction("welcomeLogin loginClicked");
         BMLoadingTimer.gi().showLoading(null,false);
      }
   }
}

