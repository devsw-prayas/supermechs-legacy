package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol93")]
   public class BMScreenRegisterOffer extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnRegister:Sprite;
      
      public var mcSizer_btnFacebookLogin:Sprite;
      
      public var btnRegister:BMButton;
      
      public var txtDescription:TextField;
      
      public var txtFacebookLogin:TextField;
      
      public var mcFacebookIcon:Sprite;
      
      public var btnFacebookLogin:BMButton;
      
      private var _initialYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      private var _animationOn:Boolean = false;
      
      public function BMScreenRegisterOffer()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("registerOffer");
      }
      
      public function refreshScreen(param1:Boolean) : void
      {
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenRegisterOffer","btnRegister","regular");
            screensM.createButtonFromSizer("screenRegisterOffer","btnFacebookLogin","regular");
            _loc4_ = this.registerClicked;
            _loc5_ = this.facebookLoginClicked;
            if(dataM.runAsMobile)
            {
               _loc4_ = null;
               _loc5_ = null;
            }
            _loc6_ = 33;
            switch(dataM.languageID)
            {
               case 3:
                  _loc6_ = 28;
                  break;
               case 5:
                  _loc6_ = 25;
                  break;
               case 9:
                  _loc6_ = 25;
            }
            this.btnRegister.changeFontSize(_loc6_);
            this.btnRegister.initialize(getGeneralText("register"),"orange",null,[],_loc4_,dataM.runAsMobile);
            this.btnFacebookLogin.initialize("","blue",null,[],_loc5_,dataM.runAsMobile);
            this.mcFacebookIcon.mouseEnabled = false;
            this.mcFacebookIcon.mouseChildren = false;
            this.txtFacebookLogin.mouseEnabled = false;
            this.txtDescription.mouseEnabled = false;
            this.btnRegister.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._initialYPos = 0;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Boolean = false;
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            if(dataM.isTutorialActive() == false)
            {
               this.btnRegister.visible = true;
               this.txtFacebookLogin.visible = false;
               this.btnFacebookLogin.visible = false;
               this.mcFacebookIcon.visible = false;
               _loc7_ = getScreenText("description");
               _loc7_ = dataM.replaceStringInText(_loc7_,"%COLOR%",dataM.COLOR_GOLD);
               this.txtDescription.text = _loc7_;
               _loc3_ = true;
            }
         }
         else if(_loc2_.facebook == false)
         {
            this.btnRegister.visible = false;
            this.txtFacebookLogin.visible = true;
            this.btnFacebookLogin.visible = true;
            this.mcFacebookIcon.visible = true;
            this.txtDescription.text = "Click to connect your account into Facebook";
            _loc3_ = true;
         }
         if(_loc3_)
         {
            if(parent != null)
            {
               screensM.removeScreen("screenRegisterOffer");
            }
            screensM.addScreen("screenRegisterOffer");
            if(param1)
            {
               y = this._initialYPos + 260;
               this._animationOn = true;
            }
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = 14;
            switch(dataM.languageID)
            {
               case 5:
                  _loc2_ = 12;
            }
            TextUtils.updateTextFormat(this.txtDescription,_loc2_);
            param1 = true;
         }
         if(param1)
         {
            _loc3_ = 33;
            switch(dataM.languageID)
            {
               case 3:
                  _loc3_ = 28;
                  break;
               case 5:
                  _loc3_ = 25;
                  break;
               case 9:
                  _loc3_ = 25;
            }
            TextUtils.updateTextFormat(this.btnRegister.txtButtonName);
            this.btnRegister.changeFontSize(_loc3_);
            this.btnRegister.setButtonName(getGeneralText("register"));
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(this._animationOn)
            {
               if(y > this._initialYPos)
               {
                  y -= (y - this._initialYPos) * 0.35;
               }
               else
               {
                  this._animationOn = false;
               }
            }
         }
      }
      
      public function facebookLoginClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("connectingToFacebook",-1,-1);
      }
      
      public function registerClicked() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:BMPlayerData = null;
         if(dataM.useNoConnectionMode && dataM.firstSocketConnectionEstablished == false)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("cantRegisterNoInternetConnection",-1,-1);
         }
         else
         {
            _loc1_ = true;
            if(screensM.isScreenOpened("screenMissionWorldMap"))
            {
               if(screensM.screenMissionWorldMap.isMapLocked())
               {
                  _loc1_ = false;
               }
            }
            if(_loc1_)
            {
               _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
               if(_loc2_.gold > dataM.GUEST_MAX_GOLD)
               {
                  screensM.screenConfirmation.displayQuestionOrNotification("cantRegisterTooMuchGold",-1,-1);
               }
               else
               {
                  _loc3_ = dataM.playersData[dataM.player1PlayerID];
                  if(_loc3_.items.length > dataM.GUEST_MAX_ITEMS)
                  {
                     screensM.screenConfirmation.displayQuestionOrNotification("cantRegisterTooManyItems",-1,-1);
                  }
                  else
                  {
                     screensM.addIfNotOpened("screenWelcomeLoginAs");
                     screensM.screenWelcomeLoginAs.refreshScreen(true);
                  }
               }
            }
         }
      }
   }
}

