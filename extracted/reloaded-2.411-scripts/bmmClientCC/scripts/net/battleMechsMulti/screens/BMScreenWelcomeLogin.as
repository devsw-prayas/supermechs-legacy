package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMLoadingTimer;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureB;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.session.LoginServices;
   import net.battleMechsMulti.utils.TextUtils;
   import net.tacticsoft.global.BMMClientFlashConsts;
   import net.tacticsoft.global.BMMClientFlashVars;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol128")]
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
            screensM.createButtonFromSizer("screenWelcomeLogin","btnLogin","regular");
            screensM.createButtonFromSizer("screenWelcomeLogin","btnRegister","regular");
            screensM.createButtonFromSizer("screenWelcomeLogin","btnFacebookLogin","regular");
            screensM.createButtonFromSizer("screenWelcomeLogin","btnBack","pictureE");
            screensM.createButtonFromSizer("screenWelcomeLogin","btnClearGuestSharedObject","pictureB");
            this.btnLogin.setRunAsMobile(dataM.runAsMobile);
            this.btnRegister.setRunAsMobile(dataM.runAsMobile);
            switch(dataM.languageID)
            {
               case 5:
                  this.btnLogin.changeFontSize(27);
                  this.btnRegister.changeFontSize(24);
                  break;
               case 9:
                  this.btnLogin.changeFontSize(27);
                  this.btnRegister.changeFontSize(24);
                  break;
               case 10:
                  this.btnLogin.changeFontSize(23);
                  this.btnRegister.changeFontSize(23);
                  break;
               default:
                  this.btnLogin.changeFontSize(31);
                  this.btnRegister.changeFontSize(31);
            }
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
            this.btnLogin.initialize(getScreenText("login"),"green",null,[],_loc2_,dataM.runAsMobile);
            this.btnRegister.initialize(getGeneralText("register"),"orange",null,[],_loc3_,dataM.runAsMobile);
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
         keyboardM.setKeyboardOutputFunction(this.keyboardOutput,"screenWelcomeLogin");
         keyboardM.activateMe("screenWelcomeLogin");
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
            TsLogger.log(">>>>>>dataM.getSharedObjectLastLoginUsername()333:" + dataM.getSharedObjectLastLoginUsername());
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
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         switch(dataM.languageID)
         {
            case 3:
               this.mcLoginBackground.gotoAndStop("wide");
               _loc2_ = 20;
               _loc3_ = 3;
               break;
            case 5:
            case 9:
            case 10:
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
         if(dataM.languageID != lastLanguageID)
         {
            if(dataM.languageFontType[dataM.languageID] != dataM.languageFontType[lastLanguageID])
            {
               _loc4_ = 22;
               _loc5_ = 22;
               _loc6_ = 18;
               switch(dataM.languageID)
               {
                  case 3:
                     _loc4_ = 18;
                     _loc5_ = 18;
                     break;
                  case 5:
                     _loc4_ = 20;
                     _loc5_ = 20;
                     break;
                  case 6:
                     _loc5_ = 20;
                     break;
                  case 9:
                     _loc5_ = 17;
                     break;
                  case 10:
                     _loc5_ = 21;
                     _loc6_ = 15;
               }
               TextUtils.updateTextFormat(this.txtError,_loc4_);
               TextUtils.updateTextFormat(this.txtFacebookLogin);
               TextUtils.updateTextFormat(this.txtForgotPassword,_loc6_);
               TextUtils.updateTextFormat(this.txtUsername,_loc5_);
               TextUtils.updateTextFormat(this.txtPassword,_loc5_);
               TextUtils.updateTextFormat(this.txtRememberPassword,18);
               TextUtils.updateTextFormat(this.txtTitle,22);
               TextUtils.updateTextFormat(this.txtInputUsername,22);
               TextUtils.updateTextFormat(this.btnLogin.txtButtonName);
               TextUtils.updateTextFormat(this.btnRegister.txtButtonName);
               param1 = true;
            }
         }
         lastLanguageID = dataM.languageID;
         if(param1)
         {
            switch(dataM.languageID)
            {
               case 5:
                  this.btnLogin.changeFontSize(27);
                  this.btnRegister.changeFontSize(24);
                  break;
               case 9:
                  this.btnLogin.changeFontSize(27);
                  this.btnRegister.changeFontSize(24);
                  break;
               case 10:
                  this.btnLogin.changeFontSize(23);
                  this.btnRegister.changeFontSize(23);
                  break;
               default:
                  this.btnLogin.changeFontSize(31);
                  this.btnRegister.changeFontSize(31);
            }
            this.btnLogin.setButtonName(getScreenText("login"));
            this.btnRegister.setButtonName(getGeneralText("register"));
         }
         this.txtTitle.text = getScreenText("welcome");
         this.txtUsername.text = getScreenText("username");
         this.txtPassword.text = getScreenText("password");
         this.txtForgotPassword.text = getScreenText("forgotPassword");
         this.txtRememberPassword.text = getScreenText("rememberPassword");
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
                  this.txtError.text = getScreenText("wrongUsernamePassword");
                  this.mcErrorServer.visible = true;
                  this.createTextsBitmapForMobile();
                  if(screensM.isScreenOpened("screenWelcomeNewExisting"))
                  {
                     screensM.screenWelcomeNewExisting.removeMechs();
                  }
                  screensM.removeScreen("screenWelcomeNewExisting");
                  break;
               case null:
                  break;
               default:
                  this.txtError.text = getScreenText("wrongUsernamePassword");
                  this.mcErrorServer.visible = true;
                  this.createTextsBitmapForMobile();
                  if(screensM.isScreenOpened("screenWelcomeNewExisting"))
                  {
                     screensM.screenWelcomeNewExisting.removeMechs();
                  }
                  screensM.removeScreen("screenWelcomeNewExisting");
            }
            TsLogger.log("!!! LOGIN FAILED");
         }
         else
         {
            TsLogger.log("!!! NOT LOGGED IN");
            _loc2_ = dataM.getSharedObjectLastLoginUsername();
            if(_loc2_ != "" || screensM.isScreenOpened("screenWelcomeLogin"))
            {
               screensM.addScreen("screenWelcomeLogin");
               screensM.screenWelcomeLogin.refreshScreen();
               if(screensM.isScreenOpened("screenWelcomeNewExisting"))
               {
                  screensM.screenWelcomeNewExisting.removeMechs();
               }
               screensM.removeScreen("screenWelcomeNewExisting");
            }
            else
            {
               screensM.addScreen("screenWelcomeNewExisting");
               screensM.screenWelcomeNewExisting.refreshScreen();
            }
         }
      }
      
      public function loginSuccess() : void
      {
         TsLogger.log("!!! LOGIN SUCCESS");
         keyboardM.deactivateMe();
         screensM.removeScreen("screenWelcomeLogin");
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
         dataM.savePerUserSharedObjectData();
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
            screensM.removeScreen("screenWelcomeLogin");
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
            this.txtError.text = getScreenText("enterUsername");
            this.mcErrorUsername.visible = true;
            return false;
         }
         if(this.txtInputPassword.text == "")
         {
            this.txtError.text = getScreenText("enterPassword");
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
               dataM.savePerUserSharedObjectData();
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
                  dataM.savePerUserSharedObjectData();
                  BMLoginManager.gi().legacyTryToLogin(this.txtInputUsername.text,this.txtInputPassword.text);
                  this.switchFromWellcomeScreenToLoading();
                  this.createTextsBitmapForMobile();
               }
            }
         }
      }
      
      public function registerClicked() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            keyboardM.deactivateMe();
            screensM.addScreen("screenRegister");
            screensM.screenRegister.refreshScreen(this.connectToSuperMechsAccount);
            screensM.removeScreen("screenWelcomeLogin");
            keyboardM.removeKeyboardOutputFunction("welcomeLogin registerClicked");
         }
      }
      
      public function backClicked() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            keyboardM.deactivateMe();
            if(this.connectToSuperMechsAccount)
            {
               if(screensM.isScreenOpened("screenWelcomeBackground"))
               {
                  screensM.addIfNotOpened("screenWelcomeLoginAs");
                  screensM.screenWelcomeLoginAs.refreshScreen();
               }
            }
            else
            {
               screensM.addScreen("screenWelcomeNewExisting");
               screensM.screenWelcomeNewExisting.refreshScreen();
            }
            screensM.removeScreen("screenWelcomeLogin");
            keyboardM.removeKeyboardOutputFunction("welcomeLogin backClicked");
         }
      }
      
      private function clearGuestSharedObjectClicked() : void
      {
         dataM.resetGuestSharedObject("login clearGuestSharedObjectClicked");
      }
      
      private function switchFromWellcomeScreenToLoading() : void
      {
         screensM.removeScreen("screenWelcomeLogin");
         keyboardM.removeKeyboardOutputFunction("welcomeLogin loginClicked");
         BMLoadingTimer.gi().showLoading(null,false);
      }
   }
}

