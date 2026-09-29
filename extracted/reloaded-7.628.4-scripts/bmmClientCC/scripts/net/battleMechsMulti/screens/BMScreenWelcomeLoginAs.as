package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMLoginServicesManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.session.LoginAsFlowTypes;
   import net.battleMechsMulti.session.LoginServices;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol282")]
   public class BMScreenWelcomeLoginAs extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtTitleBig:TextField;
      
      public var txtTroubleLoggingIn:TextField;
      
      public var txtContactSupport:TextField;
      
      public var txtBottom:TextField;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcContactSupportHitArea:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      private var _firstRefresh:Boolean = true;
      
      public var btnFb:BMBasicButton;
      
      public var btnSm:BMBasicButton;
      
      public var btnItunes:BMBasicButton;
      
      public var btnGp:BMBasicButton;
      
      public function BMScreenWelcomeLoginAs()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("loginAs");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         BMLoginManager.gi().initializeExternalLoginSystemIfNeeded();
         if(this._firstRefresh)
         {
            _loc1_ = BMLoginServicesManager.getActiveServices();
            _loc2_ = _loc1_.indexOf(LoginServices.FACEBOOK) == -1;
            screensM.createButtonFromSizer(BMScreensManager.SCR_WELCOME_LOGIN_AS,"btnBack","pictureE");
            this.btnItunes.visible = false;
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,false);
            if(_loc2_)
            {
               this.btnFb.disableMe();
            }
            this.txtTitleBig.visible = false;
            this.txtTitle.visible = false;
            _loc3_ = "";
            _loc4_ = "";
            _loc5_ = "";
            switch(loginM.loginAsFlowType)
            {
               case LoginAsFlowTypes.NOT_CONNECTED:
                  _loc3_ = getSpecificText("loginAs_aleradyHaveAnAccount");
                  this.txtTitle.visible = true;
                  _loc5_ = "<font color=\'#ffffff\'>" + getGeneralText("troubleLoggingIn") + "</font> " + getGeneralText("contactSupport");
                  break;
               case LoginAsFlowTypes.SAVE_PROGRESS:
                  _loc4_ = getScreenText("saveProgress");
                  this.txtTitleBig.visible = true;
                  this.btnBack.visible = false;
                  _loc5_ = getScreenText("continueAsGuest");
                  break;
               case LoginAsFlowTypes.GUEST:
                  _loc3_ = getScreenText("registerForFree");
                  this.txtTitle.visible = true;
                  BMShopManager.gi().close();
                  _loc5_ = "<font color=\'#ffffff\'>" + getGeneralText("troubleLoggingIn") + "</font> " + getGeneralText("contactSupport");
            }
            updateTextAndFormat(this.txtTitle,_loc3_);
            updateTextAndFormat(this.txtTitleBig,_loc4_);
            updateTextAndFormat(this.txtBottom,_loc5_);
            ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
            ImageUtils.swapTextFieldWithBitMap(this.txtTitleBig,this);
            ImageUtils.swapTextFieldWithBitMap(this.txtBottom,this);
            this.btnFb.addEventListener(BMIntractable.HIT,this.facebookClicked);
            this.btnSm.addEventListener(BMIntractable.HIT,this.superMechsClicked);
            this.btnGp.addEventListener(BMIntractable.HIT,this.googlePlayClicked);
            this.btnItunes.addEventListener(BMIntractable.HIT,this.itunesClicked);
            this._firstRefresh = false;
         }
         this.refreshServiceButtonsState(LoginServices.SUPERMECHS,this.btnSm);
         this.refreshServiceButtonsState(LoginServices.GOOGLE_PLAY,this.btnGp);
         this.refreshServiceButtonsState(LoginServices.FACEBOOK,this.btnFb);
         this.refreshServiceButtonsState(LoginServices.GAME_CENTER,this.btnItunes);
         this.mcContactSupportHitArea.addEventListener(MouseEvent.CLICK,this.contactSupportClicked);
         this.mcContactSupportHitArea.buttonMode = true;
         this.mcContactSupportHitArea.useHandCursor = true;
      }
      
      private function refreshServiceButtonsState(param1:String, param2:BMBasicButton) : *
      {
         var _loc3_:* = BMLoginServicesManager.isServiceActive(param1);
         var _loc4_:Boolean = dataM.isConnectedToService(param1);
         var _loc5_:Boolean = BMLoginServicesManager.isServiceImplemented(param1);
         var _loc6_:* = _loc3_ && !_loc4_;
         param2.visible = _loc6_;
         if(Boolean(_loc3_) && !_loc5_)
         {
            param2.visible = true;
            param2.disableMe();
         }
      }
      
      public function superMechsClicked(param1:Event) : void
      {
         if(loginM.isGuestOrSaveLoginAsFlow)
         {
            screensM.addScreen(BMScreensManager.SCR_REGISTER);
            screensM.screenRegister.refreshScreen();
         }
         else
         {
            loginM.doExternalLogin(LoginServices.SUPERMECHS);
         }
         this.removeMe();
      }
      
      public function googlePlayClicked(param1:Event) : void
      {
         TsLogger.log("GOOGLE PLAY");
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         BMLoginManager.gi().doExternalLogin(LoginServices.GOOGLE_PLAY);
         this.removeMe();
      }
      
      public function itunesClicked(param1:Event) : void
      {
         TsLogger.log("ITUNES CLICKED");
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         BMLoginManager.gi().doExternalLogin(LoginServices.GAME_CENTER);
         this.removeMe();
      }
      
      public function facebookClicked(param1:Event) : void
      {
         TsLogger.log("FACEBOOK CLICKED");
         var _loc2_:String = "pleaseWait";
         screensM.screenConfirmation.displayQuestionOrNotification(_loc2_,-1,-1);
         BMLoginManager.gi().doExternalLogin(LoginServices.FACEBOOK);
         this.removeMe();
      }
      
      private function contactSupportClicked(param1:MouseEvent) : void
      {
         if(loginM.loginAsFlowType == LoginAsFlowTypes.SAVE_PROGRESS)
         {
            screensM.addScreen(BMScreensManager.SCR_WELCOME_LOGIN_WARNING);
            this.removeMe();
         }
         else
         {
            dataM.openSupportForm("Log In Support");
         }
      }
      
      public function backClicked() : void
      {
         switch(loginM.loginAsFlowType)
         {
            case LoginAsFlowTypes.NOT_CONNECTED:
               screensM.addScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
               screensM.screenWelcomeNewExisting.refreshScreen();
               this.removeMe();
               loginM.endLoginAsFlow();
               break;
            case LoginAsFlowTypes.SAVE_PROGRESS:
               break;
            case LoginAsFlowTypes.GUEST:
               loginM.endLoginAsFlow();
               this.removeMe();
         }
      }
      
      public function removeMe() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.mcContactSupportHitArea.removeEventListener(MouseEvent.CLICK,this.contactSupportClicked);
         }
         screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN_AS);
      }
      
      private function updateComingSoonText(param1:TextField, param2:BMButton, param3:Boolean) : TextField
      {
         if(param3)
         {
            param2.txtButtonName.y -= 5;
            updateTextAndFormat(param1,getGeneralText("comingSoon"));
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

