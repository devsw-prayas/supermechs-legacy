package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol215")]
   public class BMScreenWorldMapSelectBattle extends BMBaseScreen
   {
      
      public var progressBar:BMBar;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnBattle:Sprite;
      
      public var player2ModuleSizer:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcMechHolder:Sprite;
      
      public var txtDescription:TextField;
      
      public var btnBattle:BMButton;
      
      public var btnBack:BMButton_pictureE;
      
      public var mcTutorialPointer_battle:MovieClip;
      
      public var mcTutorialMarker_battle:MovieClip;
      
      public var mcTutorialPointer_back:MovieClip;
      
      public var mcTutorialMarker_back:MovieClip;
      
      public var mcBonusHP:Sprite;
      
      public var mcBonusDamage:Sprite;
      
      public var mcBonusAP:Sprite;
      
      public var mcFrameRegularBattle:MovieClip;
      
      public var mcFrameChallenge:MovieClip;
      
      public var mcQuestionMark:Sprite;
      
      private var mechView:BMMechView;
      
      private var _difficulty:Number;
      
      private var _campaignBattleID:Number = -1;
      
      private var _descriptionTextOriginYPos:Number;
      
      private var _mechHolderOriginYPos:Number;
      
      private var _player2Modules:Array = new Array();
      
      private var _firstUpdate:Boolean = true;
      
      private const MECH_SIZE_RATIO:Number = 0.5;
      
      public function BMScreenWorldMapSelectBattle()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("worldMapSelectBattle");
      }
      
      private function createDescriptionTextBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("worldMapSelectBattle_description",[this.txtDescription],"",this);
         }
      }
      
      public function refreshScreen(param1:Number) : void
      {
         var _loc7_:Number = NaN;
         var _loc14_:Function = null;
         var _loc15_:Function = null;
         if(this._firstUpdate)
         {
            screensM.createButtonFromSizer("screenWorldMapSelectBattle","btnBattle","regular");
            screensM.createButtonFromSizer("screenWorldMapSelectBattle","btnBack","pictureE");
            _loc14_ = this.battleClicked;
            _loc15_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc14_ = null;
               _loc15_ = null;
               this.btnBattle.changeFontSize(34);
            }
            else
            {
               this.btnBattle.changeFontSize(33);
            }
            this.btnBattle.initialize(getScreenText("battle"),"green",null,[],_loc14_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel",0,0,false,false),[],_loc15_,dataM.runAsMobile);
            this.btnBattle.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            if(dataM.runAsMobile == false)
            {
               this.mcTutorialPointer_battle.mouseEnabled = false;
               this.mcTutorialPointer_battle.mouseChildren = false;
               this.mcTutorialMarker_battle.mouseEnabled = false;
               this.mcTutorialMarker_battle.mouseChildren = false;
               this.mcTutorialPointer_back.mouseEnabled = false;
               this.mcTutorialPointer_back.mouseChildren = false;
               this.mcTutorialMarker_back.mouseEnabled = false;
               this.mcTutorialMarker_back.mouseChildren = false;
            }
            this._descriptionTextOriginYPos = this.txtDescription.y;
            this._mechHolderOriginYPos = this.mcMechHolder.y;
            this.languageUpdate();
            this._firstUpdate = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:Array = dataM.getTargetBattleType();
         var _loc4_:String = _loc3_[0];
         var _loc5_:String = _loc3_[1];
         var _loc6_:Boolean = true;
         if(this.mechView != null)
         {
            if(this._campaignBattleID == param1)
            {
               _loc6_ = false;
            }
            else
            {
               this.mechView.removeMe();
            }
         }
         this._campaignBattleID = param1;
         var _loc8_:BMMechStructure = new BMMechStructure();
         this.mcFrameRegularBattle.visible = false;
         this.mcFrameChallenge.visible = false;
         this.mcQuestionMark.visible = false;
         var _loc9_:Object = null;
         switch(_loc4_)
         {
            case "challenge":
               switch(_loc5_)
               {
                  case "godMode":
                     _loc7_ = _loc2_.levelByItems;
                     _loc8_.torso = 292;
                     _loc8_.leg = 293;
                     _loc8_.sideWeapon1 = 294;
                     _loc8_.sideWeapon2 = 294;
                     this.mcFrameChallenge.visible = true;
                     break;
                  case "usa":
                     _loc7_ = _loc2_.levelByItems;
                     _loc8_.torso = 1058;
                     _loc8_.leg = 1059;
                     _loc8_.sideWeapon1 = 294;
                     _loc8_.sideWeapon2 = 294;
                     _loc9_ = new Object();
                     _loc9_.torso = 9;
                     _loc9_.leg = 9;
                     _loc9_.sideWeapon = 9;
                     _loc9_.topWeapon = 9;
                     this.mcFrameChallenge.visible = true;
                     break;
                  case "japan":
                     _loc7_ = _loc2_.levelByItems;
                     _loc8_.torso = 1061;
                     _loc8_.leg = 1062;
                     _loc8_.sideWeapon1 = 1060;
                     _loc8_.sideWeapon2 = 294;
                     _loc9_ = new Object();
                     _loc9_.torso = 5;
                     _loc9_.leg = 5;
                     _loc9_.sideWeapon = 5;
                     _loc9_.topWeapon = 5;
                     this.mcFrameChallenge.visible = true;
                     break;
                  case "invisible":
                     _loc6_ = false;
                     this.mcQuestionMark.visible = true;
                     this.mcFrameChallenge.visible = true;
                     break;
                  case "damage":
                     _loc7_ = _loc2_.levelByItems;
                     _loc8_.torso = 718;
                     _loc8_.leg = 719;
                     _loc8_.sideWeapon1 = 720;
                     _loc8_.sideWeapon2 = 720;
                     _loc9_ = new Object();
                     _loc9_.torso = 2;
                     _loc9_.leg = 2;
                     _loc9_.sideWeapon = 2;
                     _loc9_.topWeapon = 2;
                     this.mcFrameChallenge.visible = true;
               }
         }
         this.mcBonusHP.visible = false;
         this.mcBonusDamage.visible = false;
         this.mcBonusAP.visible = false;
         if(_loc6_)
         {
            this.mechView = new BMMechView();
            this.mechView.useLegsShadow = true;
            this.mechView.initialize(0,"hanger","itemID",this.MECH_SIZE_RATIO,false);
            if(_loc9_ != null)
            {
               this.mechView.setManualColors(_loc9_);
            }
            this.mechView.buildMech(_loc8_,"screenWorldMapSelectBattle");
            this.mechView.y = -(this.mechView.mechSizer.height + this.mechView.mechSizer.y);
            this.mechView.activateBreathing();
            this.mechView.scaleX *= -1;
            this.mcMechHolder.addChild(this.mechView);
         }
         this.enableScreen();
         this.txtDescription.htmlText = "";
         var _loc10_:String = "<FONT COLOR=\'#999999\'>";
         var _loc11_:String = "<FONT COLOR=\'#00CC00\'>";
         var _loc12_:String = "<FONT COLOR=\'#FF6600\'>";
         var _loc13_:String = "<FONT COLOR=\'#CC0000\'>";
         this.txtDescription.y = this._descriptionTextOriginYPos;
         this.mcMechHolder.y = this._mechHolderOriginYPos;
         switch(_loc4_)
         {
            case "challenge":
               switch(_loc5_)
               {
                  case "godMode":
                     this.txtDescription.y -= 30;
                     this.txtDescription.htmlText = TextUtils.getTextFont(18) + getScreenText("challengeGodMode");
                     break;
                  case "usa":
                     this.txtDescription.y -= 30;
                     this.txtDescription.htmlText = TextUtils.getTextFont(18) + getScreenText("challengeGodMode");
                     break;
                  case "japan":
                     this.txtDescription.y -= 30;
                     this.txtDescription.htmlText = TextUtils.getTextFont(18) + getScreenText("challengeGodMode");
                     break;
                  case "damage":
                     this.mcMechHolder.y -= 10;
                     this.txtDescription.y -= 50;
                     this.txtDescription.htmlText = TextUtils.getTextFont(18) + getScreenText("challengeDamage");
                     break;
                  case "invisible":
                     this.txtDescription.y -= 30;
                     this.txtDescription.htmlText = TextUtils.getTextFont(18) + getScreenText("challengeInvisible");
               }
         }
         this.createDescriptionTextBitmapForMobile();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtDescription,18);
            param1 = true;
         }
         if(param1)
         {
            if(dataM.runAsMobile)
            {
               this.btnBattle.changeFontSize(34);
            }
            else
            {
               this.btnBattle.changeFontSize(33);
            }
            this.btnBattle.setButtonName(getScreenText("battle"));
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(this.mechView != null)
            {
               this.mechView.onEnterFrameTrigger();
            }
         }
      }
      
      public function battleClicked() : void
      {
         if(dataM.isMechReadyForBattle(false))
         {
            if(screensM.screenBlack.isActive() == false)
            {
               this.disableScreen();
               screensM.screenBlack.activateBlackScreen(screensM.screenMissionWorldMap.enterNewChallenge,true,true,null,0);
               tooltip.hideToolTip();
            }
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mechIsNotReady",-1,-1);
         }
      }
      
      public function disableScreen() : void
      {
         this.btnBattle.disableMe();
         this.btnBack.disableMe();
      }
      
      public function enableScreen() : void
      {
         this.btnBattle.enableMe();
         this.btnBack.enableMe();
      }
      
      public function cleanScreen() : void
      {
         if(this.mechView != null)
         {
            this.mechView.removeMe();
            this.mechView = null;
         }
         this.mcTutorialMarker_battle.gotoAndStop("animOff");
         this.mcTutorialPointer_battle.gotoAndStop("animOff");
         this.mcTutorialMarker_back.gotoAndStop("animOff");
         this.mcTutorialPointer_back.gotoAndStop("animOff");
      }
      
      public function backClicked() : void
      {
         this.backClickedSub(true);
      }
      
      public function backClickedSub(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(screensM.isScreenOpened("screenWorldMapSelectBattle"))
         {
            _loc2_ = false;
            if(param1)
            {
               _loc3_ = dataM.getTargetBattleType();
               _loc4_ = _loc3_[0];
               _loc5_ = _loc3_[1];
               switch(_loc4_)
               {
                  case "challenge":
                     _loc2_ = true;
               }
            }
            if(_loc2_)
            {
               screensM.screenConfirmation.displayQuestionOrNotification("skipChallenge",-1,-1);
            }
            else
            {
               this.cleanScreen();
               screensM.removeScreen("screenWorldMapSelectBattle");
            }
         }
      }
      
      public function challengeSkipped() : void
      {
         dataM.skipChallenge = true;
         this.cleanScreen();
         screensM.removeScreen("screenWorldMapSelectBattle");
         screensM.screenMissionWorldMap.specialChallengeClosed();
      }
   }
}

