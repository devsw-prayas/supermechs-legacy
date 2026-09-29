package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMLoginServicesManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton3;
   import net.battleMechsMulti.mobiles.buttons.BMButton4;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.session.BMPlatformUtils;
   import net.battleMechsMulti.session.LoginServices;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol798")]
   public class BMScreenProfileAccounts extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDesc:TextField;
      
      public var txtSuperMechs:TextField;
      
      public var txtGooglePlay:TextField;
      
      public var txtFacebook:TextField;
      
      public var txtItunes:TextField;
      
      public var txtKongregate:TextField;
      
      public var txtStatus_superMechs:TextField;
      
      public var txtStatus_googlePlay:TextField;
      
      public var txtStatus_facebook:TextField;
      
      public var txtStatus_itunes:TextField;
      
      public var txtStatus_kongregate:TextField;
      
      public var mcSizer_btnSuperMechsConnect:Sprite;
      
      public var mcSizer_btnGooglePlayConnect:Sprite;
      
      public var mcSizer_btnFacebookConnect:Sprite;
      
      public var mcSizer_btnItunesConnect:Sprite;
      
      public var mcSizer_btnKongregateConnect:Sprite;
      
      public var mcSizer_btnSuperMechsDisconnect:Sprite;
      
      public var mcSizer_btnGooglePlayDisconnect:Sprite;
      
      public var mcSizer_btnFacebookDisconnect:Sprite;
      
      public var mcSizer_btnItunesDisconnect:Sprite;
      
      public var mcSizer_btnKongregateDisconnect:Sprite;
      
      public var mcSizer_btnLogout:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnSuperMechsConnect:BMButton3;
      
      public var btnGooglePlayConnect:BMButton3;
      
      public var btnFacebookConnect:BMButton3;
      
      public var btnItunesConnect:BMButton3;
      
      public var btnKongregateConnect:BMButton3;
      
      public var btnSuperMechsDisconnect:BMButton4;
      
      public var btnGooglePlayDisconnect:BMButton4;
      
      public var btnFacebookDisconnect:BMButton4;
      
      public var btnItunesDisconnect:BMButton4;
      
      public var btnKongregateDisconnect:BMButton4;
      
      public var btnLogout:BMButton;
      
      public var btnBack:BMButton_pictureE;
      
      public var mcIcon_facebook:Sprite;
      
      public var mcIcon_sm:Sprite;
      
      public var mcIcon_googlePlay:Sprite;
      
      private var _firstRefresh:Boolean = true;
      
      private var currentLogOutService:*;
      
      public function BMScreenProfileAccounts()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("accounts");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         if(this._firstRefresh)
         {
            BMLoginManager.gi().initializeExternalLoginSystemIfNeeded();
            screensM.createButtonFromSizer("screenProfileAccounts","btnSuperMechsConnect","regular3");
            screensM.createButtonFromSizer("screenProfileAccounts","btnGooglePlayConnect","regular3");
            screensM.createButtonFromSizer("screenProfileAccounts","btnFacebookConnect","regular3");
            screensM.createButtonFromSizer("screenProfileAccounts","btnItunesConnect","regular3");
            screensM.createButtonFromSizer("screenProfileAccounts","btnKongregateConnect","regular3");
            screensM.createButtonFromSizer("screenProfileAccounts","btnSuperMechsDisconnect","regular4");
            screensM.createButtonFromSizer("screenProfileAccounts","btnGooglePlayDisconnect","regular4");
            screensM.createButtonFromSizer("screenProfileAccounts","btnFacebookDisconnect","regular4");
            screensM.createButtonFromSizer("screenProfileAccounts","btnItunesDisconnect","regular4");
            screensM.createButtonFromSizer("screenProfileAccounts","btnKongregateDisconnect","regular4");
            screensM.createButtonFromSizer("screenProfileAccounts","btnLogout","regular");
            screensM.createButtonFromSizer("screenProfileAccounts","btnBack","pictureE");
            _loc1_ = this.superMechsClicked;
            _loc2_ = this.googlePlayClicked;
            _loc3_ = this.facebookClicked;
            _loc4_ = this.logoutClicked;
            _loc5_ = this.itunesClicked;
            _loc6_ = this.kongregateClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
            }
            this.btnSuperMechsConnect.initialize("","blue",null,null,_loc1_,dataM.runAsMobile);
            this.btnGooglePlayConnect.initialize("","blue",null,null,_loc2_,dataM.runAsMobile);
            this.btnFacebookConnect.initialize("","blue",null,null,_loc3_,dataM.runAsMobile);
            this.btnItunesConnect.initialize("","blue",null,null,_loc5_,dataM.runAsMobile);
            this.btnKongregateConnect.initialize("","blue",null,null,_loc6_,dataM.runAsMobile);
            this.btnSuperMechsDisconnect.initialize("","green",null,null,_loc1_,dataM.runAsMobile);
            this.btnGooglePlayDisconnect.initialize("","green",null,null,_loc2_,dataM.runAsMobile);
            this.btnFacebookDisconnect.initialize("","green",null,null,_loc3_,dataM.runAsMobile);
            this.btnItunesDisconnect.initialize("","green",null,null,_loc5_,dataM.runAsMobile);
            this.btnKongregateDisconnect.initialize("","green",null,null,_loc6_,dataM.runAsMobile);
            this.btnLogout.initialize(getGeneralText("logoutCaps"),"red",null,null,_loc4_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.txtTitle.text = getScreenText("title");
            this.txtDesc.text = getScreenText("description");
            this.txtSuperMechs.text = BMLoginServicesManager.getServiceDisplayName(LoginServices.SUPERMECHS);
            this.txtSuperMechs.visible = BMLoginServicesManager.isServiceActive(LoginServices.SUPERMECHS);
            this.txtGooglePlay.text = BMLoginServicesManager.getServiceDisplayName(LoginServices.GOOGLE_PLAY);
            this.txtGooglePlay.visible = BMLoginServicesManager.isServiceActive(LoginServices.GOOGLE_PLAY);
            this.txtFacebook.text = BMLoginServicesManager.getServiceDisplayName(LoginServices.FACEBOOK);
            this.txtFacebook.visible = BMLoginServicesManager.isServiceActive(LoginServices.FACEBOOK);
            this.txtItunes.text = BMLoginServicesManager.getServiceDisplayName(LoginServices.GAME_CENTER);
            this.txtItunes.visible = BMLoginServicesManager.isServiceActive(LoginServices.GAME_CENTER);
            this.txtKongregate.text = BMLoginServicesManager.getServiceDisplayName(LoginServices.KONGREGATE);
            this.txtKongregate.visible = BMLoginServicesManager.isServiceActive(LoginServices.KONGREGATE);
            this.txtStatus_superMechs.mouseEnabled = false;
            this.txtStatus_googlePlay.mouseEnabled = false;
            this.txtStatus_facebook.mouseEnabled = false;
            this.txtStatus_itunes.mouseEnabled = false;
            this.txtStatus_kongregate.mouseEnabled = false;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.refreshButtonsAndStatus();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtDesc,20);
            TextUtils.updateTextFormat(this.txtFacebook,20);
            TextUtils.updateTextFormat(this.txtGooglePlay,20);
            TextUtils.updateTextFormat(this.txtItunes,20);
            TextUtils.updateTextFormat(this.txtKongregate,20);
            TextUtils.updateTextFormat(this.txtStatus_facebook,20);
            TextUtils.updateTextFormat(this.txtStatus_googlePlay,20);
            TextUtils.updateTextFormat(this.txtStatus_itunes,20);
            TextUtils.updateTextFormat(this.txtStatus_kongregate,20);
            TextUtils.updateTextFormat(this.txtStatus_superMechs,20);
            TextUtils.updateTextFormat(this.txtSuperMechs,20);
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("profileAccounts_basicTexts",[this.txtDesc,this.txtFacebook,this.txtGooglePlay,this.txtItunes,this.txtKongregate,this.txtSuperMechs,this.txtTitle],"",this);
         }
      }
      
      private function refreshServiceButtonsState(param1:String, param2:TextField, param3:BMButton3, param4:BMButton4, param5:Sprite = null) : *
      {
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc6_:* = BMLoginServicesManager.isServiceActive(param1);
         param2.visible = false;
         param3.visible = false;
         param4.visible = false;
         if(param5 != null)
         {
            param5.visible = false;
         }
         if(_loc6_)
         {
            _loc7_ = dataM.isConnectedToService(param1);
            _loc8_ = BMLoginServicesManager.isServiceImplemented(param1);
            param2.visible = true;
            if(param5 != null)
            {
               param5.visible = true;
            }
            if(_loc7_)
            {
               param2.text = getScreenText("connected");
               param3.visible = false;
               param4.visible = true;
            }
            else if(_loc8_)
            {
               param2.text = getScreenText("disconnected");
               param3.visible = true;
               param4.visible = false;
            }
            else
            {
               param2.text = getGeneralText("comingSoon");
               param3.visible = true;
               param4.visible = false;
            }
         }
      }
      
      public function refreshButtonsAndStatus() : void
      {
         var _loc1_:Array = BMLoginServicesManager.getActiveServices();
         var _loc2_:Boolean = _loc1_.indexOf(LoginServices.FACEBOOK) >= 0;
         var _loc3_:Array = dataM.getConnectedServices();
         this.refreshServiceButtonsState(LoginServices.SUPERMECHS,this.txtStatus_superMechs,this.btnSuperMechsConnect,this.btnSuperMechsDisconnect,this.mcIcon_sm);
         this.refreshServiceButtonsState(LoginServices.GOOGLE_PLAY,this.txtStatus_googlePlay,this.btnGooglePlayConnect,this.btnGooglePlayDisconnect,this.mcIcon_googlePlay);
         this.refreshServiceButtonsState(LoginServices.FACEBOOK,this.txtStatus_facebook,this.btnFacebookConnect,this.btnFacebookDisconnect,this.mcIcon_facebook);
         this.refreshServiceButtonsState(LoginServices.GAME_CENTER,this.txtStatus_itunes,this.btnItunesConnect,this.btnItunesDisconnect);
         this.refreshServiceButtonsState(LoginServices.KONGREGATE,this.txtStatus_kongregate,this.btnKongregateConnect,this.btnKongregateDisconnect);
         this.mcIcon_facebook.alpha = 1;
         if(_loc2_ == false)
         {
            this.txtStatus_facebook.text = getGeneralText("comingSoon");
            this.btnFacebookConnect.visible = true;
            this.btnFacebookConnect.disableMe();
            this.btnFacebookDisconnect.visible = false;
            this.mcIcon_facebook.alpha = 0.3;
         }
         this.btnLogout.visible = this.shouldShowLogoutButton(_loc3_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("profileAccounts_statusTexts",[this.txtStatus_facebook,this.txtStatus_googlePlay,this.txtStatus_itunes,this.txtStatus_kongregate,this.txtStatus_superMechs],"",this);
         }
      }
      
      private function shouldShowLogoutButton(param1:Array) : Boolean
      {
         if(BMPlatformUtils.isFaceBook)
         {
            return false;
         }
         return param1.length > 0;
      }
      
      public function superMechsClicked() : void
      {
         if(!dataM.isConnectedToService(LoginServices.SUPERMECHS))
         {
            BMLoginManager.gi().doExternalLogin(LoginServices.SUPERMECHS);
         }
      }
      
      private function handleLogoutYesNoAnswer(param1:Boolean) : *
      {
         if(param1)
         {
            BMLoginManager.gi().doExternalLogout(this.currentLogOutService);
         }
         this.currentLogOutService = null;
      }
      
      public function googlePlayClicked() : void
      {
         this.toggleServiceState(LoginServices.GOOGLE_PLAY);
      }
      
      public function itunesClicked() : void
      {
         this.toggleServiceState(LoginServices.GAME_CENTER);
      }
      
      private function toggleServiceState(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(dataM.isConnectedToService(param1))
         {
            if(dataM.canDisconnectFromService(param1))
            {
               this.currentLogOutService = param1;
               _loc2_ = getScreenText("unlinkConfirmation");
               _loc2_ = dataM.replaceStringInText(_loc2_,"%SERVICE%",BMLoginServicesManager.getServiceDisplayName(param1));
               screensM.screenConfirmation.displayCustomYesNoQuestion(_loc2_,this.handleLogoutYesNoAnswer);
            }
            else
            {
               _loc3_ = getScreenText("cannotUnlinkAccount");
               _loc3_ = dataM.replaceStringInText(_loc3_,"%SERVICE%",BMLoginServicesManager.getServiceDisplayName(param1));
               screensM.screenConfirmation.displayCustomMessage(_loc3_);
            }
         }
         else
         {
            BMLoginManager.gi().doExternalLogin(param1);
         }
      }
      
      public function facebookClicked() : void
      {
         if(BMPlatformUtils.isFaceBook)
         {
            return;
         }
         this.toggleServiceState(LoginServices.FACEBOOK);
      }
      
      public function logoutClicked() : void
      {
         screensM.screenNewMenu.openProfileLogout();
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.mainMenu();
      }
      
      public function kongregateClicked() : void
      {
         TsLogger.log("BMScreenProfileAccounts() :: kongregateClicked (Doing nothing)");
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenProfileAccounts");
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen();
      }
   }
}

