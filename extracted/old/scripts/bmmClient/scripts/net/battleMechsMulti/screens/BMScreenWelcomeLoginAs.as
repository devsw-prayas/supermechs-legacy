package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMLoginServicesManager;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.session.LoginServices;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol34")]
   public class BMScreenWelcomeLoginAs extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtItunesComingSoon:TextField;
      
      public var txtSuperMechsAccount:TextField;
      
      public var txtFacebook:TextField;
      
      public var txtSuperMechs:TextField;
      
      public var txtGooglePlay:TextField;
      
      public var txtItunes:TextField;
      
      public var txtTroubleLoggingIn:TextField;
      
      public var txtContactSupport:TextField;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnSuperMechs:Sprite;
      
      public var mcSizer_btnGooglePlay:Sprite;
      
      public var mcSizer_btnITunes:Sprite;
      
      public var mcSizer_btnFacebook:Sprite;
      
      public var mcContactSupportHitArea:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnSuperMechs:BMButton;
      
      public var btnGooglePlay:BMButton;
      
      public var btnITunes:BMButton;
      
      public var btnFacebook:BMButton;
      
      public var mcIcon_facebook:Sprite;
      
      public var mcIcon_sm:Sprite;
      
      public var mcIcon_googlePlay:Sprite;
      
      private var _fromGuestUser:Boolean;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenWelcomeLoginAs()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:Boolean = false) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         BMLoginManager.gi().initializeExternalLoginSystemIfNeeded();
         dataM.guestRegistrationActive = param1;
         this._fromGuestUser = param1;
         if(this._firstRefresh)
         {
            _loc2_ = BMLoginServicesManager.getActiveServices();
            _loc3_ = _loc2_.indexOf(LoginServices.FACEBOOK) == -1;
            screensM.createButtonFromSizer("screenWelcomeLoginAs","btnBack","pictureE");
            screensM.createButtonFromSizer("screenWelcomeLoginAs","btnSuperMechs","regular3");
            screensM.createButtonFromSizer("screenWelcomeLoginAs","btnGooglePlay","regular3");
            screensM.createButtonFromSizer("screenWelcomeLoginAs","btnITunes","regular3");
            screensM.createButtonFromSizer("screenWelcomeLoginAs","btnFacebook","regular3");
            this.btnSuperMechs.changeFontSize(40);
            this.btnGooglePlay.changeFontSize(40);
            this.btnITunes.changeFontSize(40);
            this.btnFacebook.changeFontSize(40);
            this.btnSuperMechs.txtButtonName.y -= 5;
            this.txtSuperMechsAccount.text = BMLoginServicesManager.getServiceSubtitle(LoginServices.SUPERMECHS);
            _loc4_ = this.backClicked;
            _loc5_ = this.superMechsClicked;
            _loc6_ = this.googlePlayClicked;
            _loc7_ = this.itunesClicked;
            _loc8_ = this.facebookClicked;
            if(dataM.runAsMobile)
            {
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
            }
            this.txtItunesComingSoon.visible = false;
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this.btnSuperMechs.initialize("","blue",null,null,_loc5_,dataM.runAsMobile);
            this.btnGooglePlay.initialize("","blue",null,null,_loc6_,dataM.runAsMobile);
            this.btnITunes.initialize("","blue",null,null,_loc7_,dataM.runAsMobile);
            this.btnFacebook.initialize("","blue",null,null,_loc8_,dataM.runAsMobile);
            this.txtSuperMechs.mouseEnabled = false;
            this.txtFacebook.mouseEnabled = false;
            this.txtGooglePlay.mouseEnabled = false;
            this.txtItunes.mouseEnabled = false;
            this.txtSuperMechsAccount.mouseEnabled = false;
            if(_loc3_)
            {
               this.btnFacebook.disableMe();
            }
            if(this._fromGuestUser)
            {
               this.txtTitle.htmlText = getSpecificText("loginAs_registerForFree");
            }
            else
            {
               this.txtTitle.htmlText = getSpecificText("loginAs_aleradyHaveAnAccount");
            }
            this.txtTroubleLoggingIn.text = getGeneralText("troubleLoggingIn");
            this.txtContactSupport.text = getGeneralText("contactSupport");
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("welcomeLoginAs_texts",[this.txtTitle],"",this);
            }
            this._firstRefresh = false;
         }
         if(this._fromGuestUser)
         {
            BMShopManager.gi().close();
         }
         this.refreshServiceButtonsState(LoginServices.SUPERMECHS,this.txtSuperMechs,this.btnSuperMechs,this.mcIcon_sm,this.txtSuperMechsAccount);
         this.refreshServiceButtonsState(LoginServices.GOOGLE_PLAY,this.txtGooglePlay,this.btnGooglePlay,this.mcIcon_googlePlay);
         this.refreshServiceButtonsState(LoginServices.FACEBOOK,this.txtFacebook,this.btnFacebook,this.mcIcon_facebook);
         this.refreshServiceButtonsState(LoginServices.GAME_CENTER,this.txtItunes,this.btnITunes);
         if(dataM.runAsMobile == false)
         {
            this.mcContactSupportHitArea.addEventListener(MouseEvent.CLICK,this.contactSupportClicked);
            this.mcContactSupportHitArea.buttonMode = true;
            this.mcContactSupportHitArea.useHandCursor = true;
         }
      }
      
      private function refreshServiceButtonsState(param1:String, param2:TextField, param3:BMButton, param4:Sprite = null, param5:TextField = null) : *
      {
         var _loc9_:* = undefined;
         var _loc6_:* = BMLoginServicesManager.isServiceActive(param1);
         var _loc7_:Boolean = dataM.isConnectedToService(param1);
         var _loc8_:Boolean = BMLoginServicesManager.isServiceImplemented(param1);
         _loc9_ = _loc6_ && !_loc7_;
         param2.text = BMLoginServicesManager.getServiceDisplayName(param1);
         param2.visible = _loc9_;
         param3.visible = _loc9_;
         if(param4 != null)
         {
            param4.visible = _loc9_;
         }
         if(param5 != null)
         {
            param5.visible = _loc9_;
         }
         if(Boolean(_loc6_) && !_loc8_)
         {
            param3.visible = true;
            param3.disableMe();
         }
      }
      
      public function superMechsClicked() : void
      {
         if(this._fromGuestUser)
         {
            screensM.openRegisterScreenFromGuest();
         }
         else
         {
            BMLoginManager.gi().doExternalLogin(LoginServices.SUPERMECHS);
         }
         this.removeMe();
      }
      
      public function googlePlayClicked() : void
      {
         TsLogger.log("GOOGLE PLAY");
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         BMLoginManager.gi().doExternalLogin(LoginServices.GOOGLE_PLAY);
         this.removeMe();
      }
      
      public function itunesClicked() : void
      {
         TsLogger.log("ITUNES CLICKED");
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         this.removeMe();
      }
      
      public function facebookClicked() : void
      {
         TsLogger.log("FACEBOOK CLICKED");
         var _loc1_:String = "pleaseWait";
         _loc1_ = "pleaseWaitFacebookWeb";
         screensM.screenConfirmation.displayQuestionOrNotification(_loc1_,-1,-1);
         BMLoginManager.gi().doExternalLogin(LoginServices.FACEBOOK);
         this.removeMe();
      }
      
      private function contactSupportClicked(param1:MouseEvent) : void
      {
         this.contactSupportClickedSub();
      }
      
      public function contactSupportClickedSub() : void
      {
         dataM.emailSupport();
      }
      
      public function backClicked() : void
      {
         if(!this._fromGuestUser)
         {
            screensM.addScreen("screenWelcomeNewExisting");
            screensM.screenWelcomeNewExisting.refreshScreen();
         }
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.mcContactSupportHitArea.removeEventListener(MouseEvent.CLICK,this.contactSupportClicked);
         }
         screensM.removeScreen("screenWelcomeLoginAs");
      }
      
      private function updateComingSoonText(param1:TextField, param2:BMButton, param3:Boolean) : TextField
      {
         if(param3)
         {
            param2.txtButtonName.y -= 5;
            param1.text = getGeneralText("comingSoon");
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("welcomeLoginAs_comingSoon",[param1],"",this);
            }
            return param1;
         }
         param1.parent.removeChild(param1);
         return null;
      }
   }
}

