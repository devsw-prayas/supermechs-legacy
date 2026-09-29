package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.helpers.BMAffiliatesHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol13")]
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
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenWelcomeNewExisting","btnNewPlayer","regular");
            screensM.createButtonFromSizer("screenWelcomeNewExisting","btnExistingPlayer","regular");
            screensM.createButtonFromSizer("screenWelcomeNewExisting","btnAlreadyHasAccount","regular");
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
            this.btnNewPlayer.changeFontSize(23);
            switch(dataM.languageID)
            {
               case 3:
                  this.btnExistingPlayer.changeFontSize(17);
                  break;
               case 5:
                  this.btnExistingPlayer.changeFontSize(17);
                  break;
               case 6:
                  this.btnExistingPlayer.changeFontSize(16);
                  break;
               case 7:
                  this.btnExistingPlayer.changeFontSize(16);
                  break;
               case 9:
                  this.btnExistingPlayer.changeFontSize(18);
                  break;
               default:
                  this.btnExistingPlayer.changeFontSize(20);
            }
            _loc4_ = getScreenText("newPlayer");
            _loc5_ = getScreenText("existingPlayer");
            this.btnAlreadyHasAccount.initialize(getSpecificText("login_log_in"),"blue",null,null,_loc3_,dataM.runAsMobile);
            this.btnNewPlayer.initialize(_loc4_,"green",null,null,_loc1_,dataM.runAsMobile);
            this.btnExistingPlayer.initialize(_loc5_,"orange",null,null,_loc2_,dataM.runAsMobile);
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
            this.btnExistingPlayer.visible = true;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_GUEST);
         this._mechsTeaseFrameCounter = 0;
         this._mechsTeaseCurrentMech = 1;
         this._activateMech1BreathingInXFrames = 0;
         this._activateMech2BreathingInXFrames = 0;
         if(this.mechView1 == null)
         {
            if(this._addMechs)
            {
               this.activateMechs();
            }
         }
         this.txtGuestDetails.text = "";
         if(dataM.clientRunningLocally && dataM.guestSharedObjectExists)
         {
            this.txtGuestDetails.htmlText = "LEVEL : " + dataM.guestSharedObject.data.profile.level + "<BR>CREDITS :<BR>" + dataM.guestSharedObject.data.profile.gold;
         }
      }
      
      public function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtAlreadyHasAccount,22);
            TextUtils.updateTextFormat(this.txtGuestDetails,16);
            TextUtils.updateTextFormat(this.btnExistingPlayer.txtButtonName);
            TextUtils.updateTextFormat(this.btnNewPlayer.txtButtonName);
            TextUtils.updateTextFormat(this.btnAlreadyHasAccount.txtButtonName);
            param1 = true;
         }
         if(param1)
         {
            this.btnNewPlayer.changeFontSize(23);
            this.btnAlreadyHasAccount.changeFontSize(33);
            switch(dataM.languageID)
            {
               case 3:
                  this.btnExistingPlayer.changeFontSize(17);
                  break;
               case 5:
                  this.btnExistingPlayer.changeFontSize(17);
                  break;
               case 6:
                  this.btnExistingPlayer.changeFontSize(16);
                  break;
               case 7:
                  this.btnExistingPlayer.changeFontSize(16);
                  break;
               case 9:
                  this.btnExistingPlayer.changeFontSize(18);
                  break;
               default:
                  this.btnExistingPlayer.changeFontSize(20);
            }
            _loc2_ = getScreenText("newPlayer");
            _loc3_ = getScreenText("existingPlayer");
            this.btnNewPlayer.setButtonName(_loc2_);
            this.btnExistingPlayer.setButtonName(_loc3_);
            this.btnAlreadyHasAccount.setButtonName(getSpecificText("login_log_in"));
         }
         this.txtAlreadyHasAccount.text = getSpecificText("login_aleradyHaveAnAccount");
         screensM.createMultipleTextsBitmap("newExistingAlreadyHasAccount",[this.txtAlreadyHasAccount],"",this);
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(screensM.screenBlack.isActive() == false)
            {
               if(this._addMechs)
               {
                  this.moveMechsHandler();
               }
               this.mechAnimationsHandler();
            }
         }
      }
      
      public function newPlayerClicked() : void
      {
         if(screensM.screenBlack.isActive() == false)
         {
            screensM.screenBlack.activateBlackScreen(this.newPlayerClickedSub,true,true,null,2);
         }
      }
      
      private function newPlayerClickedSub() : void
      {
         if(BMLoginManager.gi().loginType == BMLoginManager.LOGIN_TYPE_NEW_USER)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("changePlayerNameAndTermsOfUse_online",-1,-1);
         }
         else
         {
            screensM.screenWelcomeBackground.playingAsGuest();
         }
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
         if(BMAffiliatesHelper.canAffiliateUseExternalLogins())
         {
            screensM.addIfNotOpened("screenWelcomeLoginAs");
            screensM.screenWelcomeLoginAs.refreshScreen();
         }
         else
         {
            screensM.addScreen("screenWelcomeLogin");
            screensM.screenWelcomeLogin.refreshScreen(false);
         }
         this.removeMe();
      }
      
      private function mechAnimationsHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMMechView = null;
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
         var _loc1_:BMMechBattleData = null;
         var _loc2_:uint = 0;
         var _loc3_:BMMechStructure = null;
         var _loc4_:Object = null;
         var _loc5_:BMMechBattleData = null;
         this._moveMechsCountdown = 14;
         if(this.mechView1 == null)
         {
            if(dataM.gameType == BMDataManager.GAME_TYPE_NONE)
            {
               dataM.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_GUEST);
            }
            this.mechView1 = new BMMechView();
            _loc1_ = new BMMechBattleData();
            _loc1_.initialize();
            _loc1_.mechView = this.mechView1;
            _loc2_ = Math.ceil(Math.random() * 2);
            _loc2_ = 2;
            _loc3_ = new BMMechStructure();
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
            this.mechView1.initialize(101,"battle","itemID",this.MECH1_SIZE_RATIO,false);
            _loc4_ = new Object();
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
            this.mechView1.buildMech(_loc3_,"screenWelcomeBackground activateMechs");
            this.mechView1.setWalkingParameters(40,18,null);
            this.mechView1.setBumpParameters(6,10);
            this.mechView1.x = this.MECH1_X_POS;
            this.mechView1.y = this.MECHS_Y_POS - (this.mechView1.mechSizer.height + this.mechView1.mechSizer.y);
            this.mechView1.scaleX = -1;
            this.mechView1.visible = false;
            this.mcMechsHolder.addChild(this.mechView1);
            this.mechView2 = new BMMechView();
            _loc5_ = new BMMechBattleData();
            _loc5_.initialize();
            _loc5_.mechView = this.mechView2;
            _loc3_ = new BMMechStructure();
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
            this.mechView2.initialize(102,"battle","itemID",this.MECH2_SIZE_RATIO,false);
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
            this.mechView2.buildMech(_loc3_,"screenWelcomeBackground activateMechs");
            this.mechView2.setWalkingParameters(40,18,null);
            this.mechView2.setBumpParameters(6,10);
            this.mechView2.x = this.MECH2_X_POS;
            this.mechView2.y = this.MECHS_Y_POS - (this.mechView2.mechSizer.height + this.mechView2.mechSizer.y);
            this.mechView2.visible = false;
            this.mcMechsHolder.addChild(this.mechView2);
         }
      }
      
      private function moveMechsHandler() : void
      {
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
         screensM.removeScreen("screenWelcomeNewExisting");
      }
   }
}

