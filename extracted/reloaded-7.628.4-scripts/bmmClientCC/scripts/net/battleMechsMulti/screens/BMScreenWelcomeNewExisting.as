package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.helpers.BMAffiliatesHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMLoadingTimer;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   import net.battleMechsMulti.session.LoginAsFlowTypes;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol238")]
   public class BMScreenWelcomeNewExisting extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcTextHolder:Sprite;
      
      public var mcMechsHolder:MovieClip;
      
      public var mcSizer_btnNewPlayer:Sprite;
      
      public var mcSizer_btnExistingPlayer:Sprite;
      
      public var mcSizer_btnAlreadyHasAccount:Sprite;
      
      public var btnNewPlayer:BMButton;
      
      public var btnExistingPlayer:BMButton;
      
      public var btnAlreadyHasAccount:BMButton;
      
      public var txtGuestDetails:TextField;
      
      public var txtAlreadyHasAccount:TextField;
      
      public var txtKongLogin:TextField;
      
      public var mcKongLoginBackground:Sprite;
      
      public var mcSwitchToSpecificLanguagePanel:BMSwitchToSpecificLanguagePanel;
      
      private var _moveMechsCountdown:Number;
      
      private var mechView1:BMMechView;
      
      private var mechView2:BMMechView;
      
      private var _addMechs:Boolean = true;
      
      private var _mechsTeaseFrameCounter:Number = 0;
      
      private var _mechsTeaseCurrentMech:uint = 1;
      
      private var _activateMech1BreathingInXFrames:Number = 0;
      
      private var _activateMech2BreathingInXFrames:Number = 0;
      
      private var _firstRefresh:Boolean = true;
      
      private const MECH1_X_POS:Number = 352;
      
      private const MECH1_SIZE_RATIO:Number = 0.65;
      
      private const MECH2_X_POS:Number = 460;
      
      private const MECH2_SIZE_RATIO:Number = 0.62;
      
      private const MECHS_X_JUMP:Number = 350;
      
      private const MECHS_Y_POS:Number = 245;
      
      public function BMScreenWelcomeNewExisting()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("welcomeNewExisting");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_WELCOME_NEW_EXISITNG,"btnNewPlayer","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_WELCOME_NEW_EXISITNG,"btnExistingPlayer","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_WELCOME_NEW_EXISITNG,"btnAlreadyHasAccount","regular");
            _loc1_ = this.newPlayerClicked;
            _loc2_ = this.existingPlayerClicked;
            _loc3_ = this.alreadyHasAccountClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
               _loc3_ = null;
            }
            this.btnNewPlayer.setRunAsMobile(dataM.runAsMobile);
            this.btnExistingPlayer.setRunAsMobile(dataM.runAsMobile);
            this.btnAlreadyHasAccount.initialize("","blue",null,null,_loc3_,dataM.runAsMobile);
            this.btnNewPlayer.initialize("","green",null,null,_loc1_,dataM.runAsMobile);
            this.btnExistingPlayer.initialize("","orange",null,null,_loc2_,dataM.runAsMobile);
            this.btnNewPlayer.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnExistingPlayer.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnAlreadyHasAccount.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this._firstRefresh = false;
            if(false == false)
            {
               this.txtKongLogin.parent.removeChild(this.txtKongLogin);
               this.txtKongLogin = null;
               this.mcKongLoginBackground.parent.removeChild(this.mcKongLoginBackground);
               this.mcKongLoginBackground = null;
            }
            this.btnExistingPlayer.visible = false;
            BMLoadingTimer.gi().hideLoading();
            this.initSwitchToSpecificLanguagePanel();
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         if(loginM.isConnectedOrLoggingIn == false)
         {
            dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_NONE,BMDataManager.GAME_SUB_TYPE_NONE,"welcomeNewExisting_refreshScreen");
         }
         if(FeatureFlags.BLOCK_NEW_PLAYER)
         {
            this.btnNewPlayer.visible = false;
         }
         this._mechsTeaseFrameCounter = 0;
         this._mechsTeaseCurrentMech = 1;
         this._activateMech1BreathingInXFrames = 0;
         this._activateMech2BreathingInXFrames = 0;
         this.tryToActivateMechs();
         this.txtGuestDetails.text = "";
         if(dataM.clientRunningLocally && dataM.guestSharedObjectExists)
         {
            this.txtGuestDetails.htmlText = "LEVEL : " + dataM.guestSharedObject.data.profile.level + "<BR>CREDITS :<BR>" + dataM.guestSharedObject.data.profile.gold;
         }
      }
      
      public function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            param1 = true;
         }
         if(param1)
         {
            _loc2_ = 28;
            _loc3_ = 33;
            if(dataM.languageID != BMLanguageManager.LANGUAGE_ENGLISH)
            {
               _loc2_ = -1;
               _loc3_ = -1;
            }
            _loc4_ = getScreenText("newPlayer");
            _loc5_ = getScreenText("existingPlayer");
            this.btnNewPlayer.changeFontSize(_loc2_);
            this.btnExistingPlayer.changeFontSize(_loc3_);
            this.btnAlreadyHasAccount.changeFontSize(_loc3_);
            this.btnNewPlayer.setButtonName(_loc4_);
            this.btnExistingPlayer.setButtonName(_loc5_);
            this.btnAlreadyHasAccount.setButtonName(getSpecificText("login_log_in"));
         }
         updateTextAndFormat(this.txtAlreadyHasAccount,getSpecificText("login_aleradyHaveAnAccount"));
         screensM.createMultipleTextsBitmap("newExistingAlreadyHasAccount",[this.txtAlreadyHasAccount],"",this);
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         if(screensM.screenBlack.isActive() == false)
         {
            if(this._addMechs)
            {
               this.moveMechsHandler();
            }
            this.mechAnimationsHandler();
         }
      }
      
      public function newPlayerClicked() : void
      {
         if(FeatureFlags.BLOCK_ACCOUNT_CREATION_FEATURES)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("featureNotAvailable");
            return;
         }
         trackButtonClick("NewPlayer");
         if(screensM.screenBlack.isActive() == false)
         {
            screensM.screenBlack.activateBlackScreen(this.newPlayerClickedSub,true,true,null,2);
         }
      }
      
      private function newPlayerClickedSub() : void
      {
         screensM.screenWelcomeBackground.playingAsGuest();
         this.removeMe();
      }
      
      public function refreshExistingPlayerButton() : void
      {
         if(dataM.useNoConnectionMode && dataM.firstSocketConnectionEstablished)
         {
            this.btnExistingPlayer.visible = true;
         }
      }
      
      public function existingPlayerClicked() : void
      {
         var _loc1_:Boolean = false;
         if(dataM.runAsMobile)
         {
            if(dataM.useNoConnectionMode && dataM.firstSocketConnectionEstablished == false)
            {
               _loc1_ = true;
            }
         }
         if(_loc1_)
         {
            this.btnExistingPlayer.visible = false;
         }
         else
         {
            this.alreadyHasAccountClicked();
            this.removeMe();
         }
      }
      
      public function alreadyHasAccountClicked() : void
      {
         trackButtonClick("AlreadyHasAccount");
         if(BMAffiliatesHelper.canAffiliateUseExternalLogins())
         {
            loginM.startLoginAsFlow(LoginAsFlowTypes.NOT_CONNECTED);
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_WELCOME_LOGIN);
            screensM.screenWelcomeLogin.refreshScreen(false);
         }
         this.removeMe();
      }
      
      private function initSwitchToSpecificLanguagePanel() : void
      {
         var _loc1_:uint = 0;
         this.mcSwitchToSpecificLanguagePanel.visible = false;
         _loc1_ = dataM.recommendedLanguageID;
         if(languageM.offerUserToSwitchToDetectedLanguage == false)
         {
            return;
         }
         if(_loc1_ == dataM.languageID)
         {
            return;
         }
         if(BMLanguageManager.ALL_LANGUAGES[_loc1_] == null)
         {
            return;
         }
         this.mcSwitchToSpecificLanguagePanel.visible = true;
         var _loc2_:String = languageM.getText("welcomeNewExisting_switchTo" + _loc1_);
         var _loc3_:String = languageM.getText("welcomeNewExisting_switchTo" + _loc1_,_loc1_);
         var _loc4_:Point = new Point(screensM.screenWelcomeBackground.btnLanguages.x - this.mcSwitchToSpecificLanguagePanel.x,screensM.screenWelcomeBackground.btnLanguages.y - this.mcSwitchToSpecificLanguagePanel.y);
         var _loc5_:Number = screensM.screenWelcomeBackground.btnLanguages.scaleX;
         this.mcSwitchToSpecificLanguagePanel.init(_loc1_,this.switchToDetectedLanguageClicked,this.switchToDetectedLanguageAnimCompleted,_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      public function removeSwitchToSpecificLanguagePanel() : void
      {
         this.mcSwitchToSpecificLanguagePanel.hideMe();
         this.tryToActivateMechs(true);
      }
      
      private function tryToActivateMechs(param1:Boolean = false) : void
      {
         if(param1 == false && this.mcSwitchToSpecificLanguagePanel.visible)
         {
            return;
         }
         if(this.mechView1 == null && this._addMechs)
         {
            this.activateMechs();
         }
      }
      
      private function switchToDetectedLanguageClicked(param1:uint) : void
      {
         this.tryToActivateMechs(true);
         dataM.languageID = param1;
      }
      
      private function switchToDetectedLanguageAnimCompleted() : void
      {
         screensM.screenWelcomeBackground.newLanguageSelected();
      }
      
      private function mechAnimationsHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMMechView = null;
         if(this.mechView1 == null)
         {
            return;
         }
         ++this._mechsTeaseFrameCounter;
         if(this._mechsTeaseFrameCounter >= 200)
         {
            _loc1_ = Math.ceil(Math.random() * 9);
            _loc2_ = this["mechView" + this._mechsTeaseCurrentMech];
            switch(_loc1_)
            {
               case 1:
                  _loc2_.activateTease1(null);
                  break;
               case 2:
                  _loc2_.activateTease2(null);
                  break;
               case 3:
                  _loc2_.activateTease3(null);
                  break;
               case 4:
                  _loc2_.activateTease4(null);
                  break;
               case 5:
                  _loc2_.activateTease5(null);
                  break;
               case 6:
                  _loc2_.activateTease6(null);
                  break;
               case 7:
                  _loc2_.activateTease8(null);
                  break;
               case 8:
                  _loc2_.activateTease9(null,false);
                  break;
               case 9:
                  _loc2_.activateSword(1,null,true);
            }
            this._mechsTeaseFrameCounter = 100;
            if(this._mechsTeaseCurrentMech == 1)
            {
               this._mechsTeaseCurrentMech = 2;
            }
            else
            {
               this._mechsTeaseCurrentMech = 1;
            }
         }
         if(this._activateMech1BreathingInXFrames > 0)
         {
            --this._activateMech1BreathingInXFrames;
            if(this._activateMech1BreathingInXFrames == 0)
            {
               this.mechView1.activateBreathing();
            }
         }
         if(this._activateMech2BreathingInXFrames > 0)
         {
            --this._activateMech2BreathingInXFrames;
            if(this._activateMech2BreathingInXFrames == 0)
            {
               this.mechView2.activateBreathing();
            }
         }
      }
      
      private function activateMechs() : void
      {
         this._moveMechsCountdown = 14;
         if(this.mechView1 != null)
         {
            return;
         }
         this.mechView1 = new BMMechView();
         var _loc1_:BMMechBattleData = new BMMechBattleData();
         _loc1_.initialize();
         _loc1_.mechView = this.mechView1;
         var _loc2_:uint = Math.ceil(Math.random() * 2);
         _loc2_ = 2;
         var _loc3_:BMMechStructure = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         switch(_loc2_)
         {
            case 1:
               _loc3_.torso = 321;
               _loc3_.leg = 487;
               _loc3_.sideWeapon1 = 619;
               _loc3_.sideWeapon2 = 558;
               _loc3_.topWeapon1 = 334;
               _loc3_.topWeapon2 = 334;
               break;
            case 2:
               _loc3_.torso = 938;
               _loc3_.leg = 961;
               _loc3_.sideWeapon1 = 942;
               _loc3_.sideWeapon2 = 1001;
               _loc3_.topWeapon1 = 993;
               _loc3_.topWeapon2 = 993;
         }
         _loc1_.mechStructure = _loc3_;
         this.mechView1.useLegsShadow = true;
         this.mechView1.initialize(101,"battle",BMMechStructure.ITEM_TYPE_ITEM_ID,this.MECH1_SIZE_RATIO,false);
         var _loc4_:BMMechViewManualColors = new BMMechViewManualColors();
         switch(_loc2_)
         {
            case 1:
               _loc4_.torso = 10;
               _loc4_.leg = 102;
               _loc4_.sideWeapon = 102;
               _loc4_.topWeapon = 102;
               break;
            case 2:
               _loc4_.torso = 4;
               _loc4_.leg = 4;
               _loc4_.sideWeapon = 4;
               _loc4_.topWeapon = 4;
         }
         this.mechView1.setManualColors(_loc4_);
         this.mechView1.buildMech(_loc3_,this.onMech1ItemsLoadingComplete);
         this.mechView2 = new BMMechView();
         var _loc5_:BMMechBattleData = new BMMechBattleData();
         _loc5_.initialize();
         _loc5_.mechView = this.mechView2;
         _loc3_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         switch(_loc2_)
         {
            case 1:
               _loc3_.torso = 458;
               _loc3_.leg = 488;
               _loc3_.sideWeapon1 = 610;
               _loc3_.sideWeapon4 = 483;
               _loc3_.topWeapon1 = 644;
               _loc3_.topWeapon2 = 644;
               break;
            case 2:
               _loc3_.torso = 934;
               _loc3_.leg = 962;
               _loc3_.sideWeapon1 = 619;
               _loc3_.sideWeapon2 = 920;
               _loc3_.topWeapon1 = 955;
               _loc3_.topWeapon2 = 955;
         }
         _loc5_.mechStructure = _loc3_;
         this.mechView2.useLegsShadow = true;
         this.mechView2.initialize(102,"battle",BMMechStructure.ITEM_TYPE_ITEM_ID,this.MECH2_SIZE_RATIO,false);
         _loc4_ = new BMMechViewManualColors();
         switch(_loc2_)
         {
            case 1:
               _loc4_.torso = 10;
               _loc4_.leg = 100;
               _loc4_.sideWeapon = 100;
               _loc4_.topWeapon = 100;
               break;
            case 2:
               _loc4_.torso = 101;
               _loc4_.leg = 101;
               _loc4_.sideWeapon = 101;
               _loc4_.topWeapon = 101;
         }
         this.mechView2.setManualColors(_loc4_);
         this.mechView2.buildMech(_loc3_,this.onMech2ItemsLoadingComplete);
      }
      
      private function onMech1ItemsLoadingComplete() : void
      {
         this.mechView1.setWalkingParameters(40,18,null);
         this.mechView1.setBumpParameters();
         this.mechView1.x = this.MECH1_X_POS;
         this.mechView1.y = this.MECHS_Y_POS - (this.mechView1.mechSizer.height + this.mechView1.mechSizer.y);
         this.mechView1.scaleX = -1;
         this.mechView1.visible = false;
         this.mcMechsHolder.addChild(this.mechView1);
      }
      
      private function onMech2ItemsLoadingComplete() : void
      {
         this.mechView2.setWalkingParameters(40,18,null);
         this.mechView2.setBumpParameters();
         this.mechView2.x = this.MECH2_X_POS;
         this.mechView2.y = this.MECHS_Y_POS - (this.mechView2.mechSizer.height + this.mechView2.mechSizer.y);
         this.mechView2.visible = false;
         this.mcMechsHolder.addChild(this.mechView2);
      }
      
      private function moveMechsHandler() : void
      {
         if(this.mechView1 == null)
         {
            return;
         }
         if(this._moveMechsCountdown > 0)
         {
            --this._moveMechsCountdown;
            if(this._moveMechsCountdown == 10)
            {
               this.mechView1.activateEntry1(false,this.mech1EntryDone);
               this.mechView1.visible = true;
            }
            if(this._moveMechsCountdown == 0)
            {
               this.mechView2.activateEntry1(false,this.mech2EntryDone);
               this.mechView2.visible = true;
            }
         }
         if(parent != null && screensM.screenBlack.isActive() == false)
         {
            this.mechView1.onEnterFrameTrigger();
            this.mechView2.onEnterFrameTrigger();
         }
      }
      
      private function mech1EntryDone() : void
      {
         this._activateMech1BreathingInXFrames = 3;
      }
      
      private function mech2EntryDone() : void
      {
         this._activateMech2BreathingInXFrames = 3;
      }
      
      public function removeMechs() : void
      {
         if(this.mechView1 != null)
         {
            this.mechView1.removeMe();
            this.mechView2.removeMe();
            this.mechView1 = null;
            this.mechView2 = null;
         }
      }
      
      public function removeMe() : void
      {
         this.removeMechs();
         screensM.removeScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
      }
   }
}

