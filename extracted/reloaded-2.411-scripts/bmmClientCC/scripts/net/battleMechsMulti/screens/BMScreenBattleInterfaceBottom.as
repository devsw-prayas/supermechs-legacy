package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMMechBattleTooltip;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButtonBattle;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1813")]
   public class BMScreenBattleInterfaceBottom extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcScreenBitmapHolder:Sprite;
      
      public var mcBackground:Sprite;
      
      private var mouseHitAreaHolder:MovieClip;
      
      public var mouseHitArea:MovieClip;
      
      public var mcTutorialArrow_interface:MovieClip;
      
      public var mcInfoText:MovieClip;
      
      public var player1MechBattleTooltip:BMMechBattleTooltip;
      
      public var player2MechBattleTooltip:BMMechBattleTooltip;
      
      public var btn1:BMButtonBattle;
      
      public var btn2:BMButtonBattle;
      
      public var btn3:BMButtonBattle;
      
      public var btn4:BMButtonBattle;
      
      public var btn5:BMButtonBattle;
      
      public var btn6:BMButtonBattle;
      
      public var btn7:BMButtonBattle;
      
      public var btn8:BMButtonBattle;
      
      public var btn9:BMButtonBattle;
      
      public var btn10:BMButtonBattle;
      
      private var blankButton1:Sprite;
      
      private var blankButton2:Sprite;
      
      private var blankButton3:Sprite;
      
      private var blankButton4:Sprite;
      
      private var blankButton5:Sprite;
      
      private var blankButton6:Sprite;
      
      private var blankButton7:Sprite;
      
      private var _interfaceType:String;
      
      private var _moveToStepTargetStep:Number;
      
      private var _moveToStepHandler:Boolean = false;
      
      private var _moveToStepType:String;
      
      public var allButtons:Array;
      
      private var _buttonsByActions:Object;
      
      private var _displayStatus:String;
      
      private var _infoTextActive:Boolean;
      
      private var _infoTextDeactivationCountdown:Number;
      
      private var _buttonsSound:Boolean = false;
      
      private var _mouseHitAreaActiveForMoveToStep:Boolean = false;
      
      private var _actionErrorMessage:Boolean;
      
      private var _actionErrorMessageDeactivateCooldown:Number;
      
      private var _heatCriticalAlertCountdown:Number;
      
      private var _shuttingDownAlertCountdown:Number;
      
      private var _keyboardEnabled:Boolean = false;
      
      private var _keyboardCooldown:Number = 0;
      
      private var _expendInterface:Boolean;
      
      private var _walkRightClicked:Boolean = false;
      
      private var _introTutorialArrowDisplayed:Boolean = false;
      
      private var _introTutorialActions:Number;
      
      private var _mobileButtonMouseOverSlot:Number = -1;
      
      private var _refreshInterfaceTypeCalledThisFrame:Boolean = false;
      
      private var _buttonsToShow:Array;
      
      private var _totalActions:Array;
      
      private var _kitsUsed:Object;
      
      private var backgroundBMD:BitmapData;
      
      private var backgroundBM:Bitmap;
      
      private var screenBMD:BitmapData;
      
      private var screenBM:Bitmap;
      
      private var _firestRefresh:Boolean = true;
      
      private var _mechPictures:Array = new Array();
      
      private var _forceButtonsUpdate:Boolean;
      
      private const BUTTON_SIZE:Number = 76;
      
      private const BUTTON_SIZE_SHRINK:Number = 61;
      
      private const INTERFACE_HEIGHT:Number = 90;
      
      private const INTERFACE_MOTION_RATIO:Number = 0.3;
      
      private const MAX_BUTTONS_IN_ROW_REGULAR:Number = 10;
      
      private const INFO_TEXT_WIDTH:Number = 145;
      
      private const INFO_TEXT_X_CHANGE:Number = 20;
      
      private const KEYBOARD_COOLDOWN:Number = 6;
      
      private const MECH_BATTLE_TOOLTIP_X_POS:Number = 90;
      
      private const HEAT_CRITICAL_ALERT_FRAMES:Number = 65;
      
      private const SHUTTING_DOWN_ALERT_FRAMES:Number = 65;
      
      private const FINISH_MAX:Number = 8;
      
      private const DISABLED_BUTTON_Y_ADDON:uint = 7;
      
      public function BMScreenBattleInterfaceBottom()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("battleInterfaceBottom");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:BMButtonBattle = null;
         var _loc5_:BMButtonBattle = null;
         if(this._firestRefresh)
         {
            if(dataM.runAsMobile)
            {
               this.backgroundBMD = new BitmapData(this.mcBackground.width,this.mcBackground.height,true,0);
               this.backgroundBMD.draw(this.mcBackground);
               this.backgroundBM = new Bitmap(this.backgroundBMD);
               this.backgroundBM.x = this.mcBackground.x;
               this.backgroundBM.y = this.mcBackground.y;
               this.mcButtonsHolder.addChild(this.backgroundBM);
               this.mcBackground.parent.removeChild(this.mcBackground);
               this.mcBackground = null;
               this.mcInfoText.parent.removeChild(this.mcInfoText);
               this.mcInfoText = null;
            }
            this.player1MechBattleTooltip = new BMMechBattleTooltip();
            this.player2MechBattleTooltip = new BMMechBattleTooltip();
            this.player1MechBattleTooltip.initialize(1);
            this.player2MechBattleTooltip.initialize(2);
            screensM.screenBattleInterfaceTop.mcBattleTooltipHolder.addChild(this.player1MechBattleTooltip);
            screensM.screenBattleInterfaceTop.mcBattleTooltipHolder.addChild(this.player2MechBattleTooltip);
            this.resetMechBattleDataTooltips();
            if(dataM.runAsMobile == false)
            {
               this.mouseHitAreaHolder = screensM.screenBattle.mouseHitAreaHolder;
               this.mouseHitArea = new MovieClip();
               this.mouseHitArea.graphics.beginFill(0,0);
               this.mouseHitArea.graphics.drawRect(0,0,dataM.STAGE_WIDTH,dataM.STAGE_HEIGHT);
               this.mouseHitArea.graphics.endFill();
               this.mouseHitArea.addEventListener(MouseEvent.CLICK,this.mouseHitAreaClicked);
               this.mouseHitAreaHolder.addChild(this.mouseHitArea);
            }
            _loc2_ = 6;
            _loc3_ = dataM.STAGE_HEIGHT - (this.BUTTON_SIZE + _loc2_);
            this.allButtons = new Array();
            _loc1_ = 1;
            while(_loc1_ <= 10)
            {
               this.initializeInterfaceButton("btn" + _loc1_,_loc1_);
               _loc4_ = this["btn" + _loc1_];
               _loc4_.x = _loc2_ + (_loc1_ - 1) * this.BUTTON_SIZE;
               _loc4_.y = _loc3_;
               this.allButtons.push(this["btn" + _loc1_]);
               _loc1_++;
            }
            _loc1_ = 1;
            while(_loc1_ <= 7)
            {
               this["blankButton" + _loc1_] = new mcBlankBattleButton();
               this["blankButton" + _loc1_].width = this.BUTTON_SIZE;
               this["blankButton" + _loc1_].height = this.BUTTON_SIZE;
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this.allButtons.length)
            {
               _loc5_ = this.allButtons[_loc1_];
               _loc5_.width = this.BUTTON_SIZE;
               _loc5_.height = this.BUTTON_SIZE;
               _loc1_++;
            }
            this._interfaceType = "menu";
            this._displayStatus = "hide";
            this.resetInfoText();
            this.languageUpdate();
            this._firestRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this._forceButtonsUpdate = true;
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            if(dataM.runAsMobile == false)
            {
               TextUtils.updateTextFormat(this.mcInfoText.txtInfo,14);
            }
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this._refreshInterfaceTypeCalledThisFrame = false;
            this.moveToStepHandler();
            this.infoTextHandler();
            this.showHideInterfaceHandler();
            this.mechBattleTooltipsHandler();
            this.mobileMouseOverHandler();
            if(this._keyboardCooldown > 0)
            {
               --this._keyboardCooldown;
               if(this._keyboardCooldown == 0)
               {
                  this._keyboardEnabled = true;
               }
            }
         }
      }
      
      private function initializeInterfaceButton(param1:String, param2:uint) : void
      {
         this[param1] = new BMButtonBattle();
         var _loc3_:Function = this.buttonMouseClicked;
         var _loc4_:Function = this.buttonMouseOver;
         var _loc5_:Function = this.buttonMouseOut;
         if(dataM.runAsMobile)
         {
            _loc3_ = null;
            _loc4_ = null;
            _loc5_ = null;
         }
         this[param1].initialize(param1,param2,"",0,_loc3_,_loc4_,_loc5_,dataM.runAsMobile);
         this[param1].activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
      }
      
      public function newBattleStarted() : void
      {
         var _loc1_:uint = 0;
         this._kitsUsed = new Object();
         if(dataM.useMultipleMechsKitsFix)
         {
            _loc1_ = 1;
            while(_loc1_ <= dataM.battleMaxMechs)
            {
               this._kitsUsed[_loc1_] = new Object();
               _loc1_++;
            }
         }
         this._introTutorialActions = 0;
         this._refreshInterfaceTypeCalledThisFrame = false;
      }
      
      private function createScreenBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
         }
      }
      
      public function buttonMouseOver(param1:Number, param2:String, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc7_:BMMechBattleData = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:BMPlayerItemData = null;
         var _loc17_:BMItemData = null;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:BMPlayerItemData = null;
         var _loc22_:BMItemData = null;
         var _loc23_:String = null;
         var _loc24_:BMPlayerItemData = null;
         var _loc25_:BMItemData = null;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Boolean = false;
         var _loc37_:Boolean = false;
         var _loc38_:Boolean = false;
         _loc4_ = screensM.screenBattle.currentPlayerID;
         var _loc5_:BMPlayerData = dataM.playersData[_loc4_];
         var _loc6_:String = screensM.screenBattle.getMechSlot(_loc4_);
         _loc7_ = screensM.screenBattle.mechBattleDatas[_loc6_];
         var _loc8_:Number = screensM.screenBattle.opponentPlayerID;
         var _loc9_:BMPlayerData = dataM.playersData[_loc8_];
         var _loc10_:String = screensM.screenBattle.getMechSlot(_loc8_);
         var _loc11_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc10_];
         var _loc12_:Number = screensM.screenBattle.FLOOR_STEP_SIZE;
         var _loc13_:Boolean = false;
         this.player1MechBattleTooltip.displayToolTip(dataM.player1PlayerID,param2,param3);
         this.player2MechBattleTooltip.displayToolTip(dataM.player1PlayerID,param2,param3);
         switch(param2)
         {
            case "weapons":
            case "movement":
            case "specials":
            case "kits":
            case "back":
            case "cancel":
            case "switchMech":
               this.activateInfoText(dataM.infoTextDB[param2]);
               break;
            case "walkLeft":
            case "walkRight":
            case "jumpLeft":
            case "jumpRight":
               _loc21_ = dataM.getPlayerItemData(_loc4_,_loc7_.mechStructure.leg);
               _loc22_ = dataM.itemsDB[_loc21_.itemID];
               switch(param2)
               {
                  case "walkLeft":
                     _loc14_ = _loc7_.currentStepCode - _loc7_.stepsPerWalk;
                     _loc20_ = "walk";
                     break;
                  case "walkRight":
                     _loc14_ = _loc7_.currentStepCode + _loc7_.stepsPerWalk;
                     _loc20_ = "walk";
                     break;
                  case "jumpLeft":
                     _loc14_ = _loc7_.currentStepCode - _loc7_.stepsPerJump;
                     _loc20_ = "jump";
                     break;
                  case "jumpRight":
                     _loc14_ = _loc7_.currentStepCode + _loc7_.stepsPerJump;
                     _loc20_ = "jump";
               }
               _loc15_ = screensM.screenBattle.getAvailableStep(_loc4_,_loc7_.currentStepCode,_loc14_,_loc20_);
               if(_loc15_ > -1)
               {
                  screensM.screenBattle.displayMechHologram(_loc15_,false);
               }
               this.activateInfoText(dataM.infoTextDB[param2]);
               break;
            case "shutDown":
               this.activateInfoText(dataM.infoTextDB[param2]);
               break;
            case "sideWeapon":
            case "topWeapon":
               _loc16_ = dataM.getPlayerItemData(_loc4_,_loc7_.mechStructure[param2 + param3]);
               _loc17_ = dataM.itemsDB[_loc16_.itemID];
               _loc13_ = true;
               _loc18_ = param2 + param3;
               if(_loc7_.usesMax[_loc18_] > 0 && _loc7_.uses[_loc18_] == _loc7_.usesMax[_loc18_])
               {
                  this.activateActionErrorMessage("usesDepleted");
               }
               else if(_loc7_.weaponAlreadyFired[_loc18_])
               {
                  this.activateActionErrorMessage("alreadyFired");
               }
               _loc19_ = "";
               _loc19_ = _loc17_.fullName;
               this.activateInfoText(_loc19_);
               break;
            case "charge":
            case "harpoon":
            case "teleport":
               if(_loc7_.usesMax[param2] > 0 && _loc7_.uses[param2] == _loc7_.usesMax[param2])
               {
                  this.activateActionErrorMessage("usesDepleted");
               }
               this.activateInfoText(dataM.infoTextDB[param2]);
               switch(param2)
               {
                  case "harpoon":
                  case "charge":
                     _loc13_ = true;
               }
               break;
            case "drone":
               if(_loc7_.droneActive)
               {
                  this.activateInfoText(dataM.infoTextDB["droneDeactivate"]);
               }
               else
               {
                  this.activateInfoText(dataM.infoTextDB["droneActivate"]);
               }
               break;
            case "shield":
               if(_loc7_.shieldActive)
               {
                  this.activateInfoText(dataM.infoTextDB["shieldDeactivate"]);
               }
               else
               {
                  this.activateInfoText(dataM.infoTextDB["shieldActivate"]);
               }
               break;
            case "leg":
               this.activateInfoText(getScreenText("stomp"));
               _loc13_ = true;
               break;
            case "kit":
               _loc16_ = dataM.getPlayerItemData(_loc4_,_loc7_.mechStructure[param2 + param3]);
               _loc17_ = dataM.itemsDB[_loc16_.itemID];
               if(_loc17_.HPBase > 0)
               {
                  if(_loc7_.HP == _loc7_.HPMax)
                  {
                     this.activateActionErrorMessage("HPFull");
                  }
               }
               else if(_loc17_.energyBase > 0)
               {
                  if(_loc7_.energy == _loc7_.energyMax)
                  {
                     this.activateActionErrorMessage("energyFull");
                  }
               }
               else if(_loc17_.heatBase > 0)
               {
                  if(_loc7_.heat == 0)
                  {
                     this.activateActionErrorMessage("noHeat");
                  }
               }
               else if(_loc17_.bullets > 0)
               {
                  if(_loc7_.bullets == _loc7_.bulletsMax)
                  {
                     this.activateActionErrorMessage("bulletsFull");
                  }
               }
               else if(_loc17_.rockets > 0)
               {
                  if(_loc7_.rockets == _loc7_.rocketsMax)
                  {
                     this.activateActionErrorMessage("rocketsFull");
                  }
               }
               _loc19_ = "";
               _loc19_ = _loc17_.fullName;
               this.activateInfoText(_loc19_);
               break;
            case "selectMech":
               this.activateInfoText(getScreenText("selectMech"));
               break;
            case "finish":
               tooltip.showToolTip("regularText",getScreenText("finish" + param3),-1,-1);
         }
         if(_loc13_)
         {
            switch(param2)
            {
               case "charge":
               case "harpoon":
               case "leg":
                  _loc23_ = param2;
                  break;
               default:
                  _loc23_ = param2 + param3;
            }
            _loc24_ = dataM.getPlayerItemData(_loc4_,_loc7_.mechStructure[_loc23_]);
            _loc25_ = dataM.itemsDB[_loc24_.itemID];
            _loc26_ = _loc25_.rangeBase;
            _loc27_ = _loc25_.rangeAddon;
            _loc29_ = _loc28_ = _loc7_.currentStepCode;
            _loc31_ = _loc30_ = _loc11_.currentStepCode;
            _loc32_ = _loc12_ / 2;
            _loc33_ = Number(dataM.battleData.map.stepsTotal);
            if(_loc28_ > _loc30_)
            {
               _loc34_ = 0;
               if(_loc29_ - _loc26_ >= 0)
               {
                  if(_loc29_ - (_loc26_ + _loc27_) >= 0)
                  {
                     _loc34_ = _loc29_ - (_loc26_ + _loc27_);
                     _loc35_ = _loc27_;
                  }
                  else
                  {
                     _loc35_ = _loc29_ - _loc26_;
                  }
               }
               else
               {
                  _loc35_ = 0;
               }
            }
            else if(_loc29_ + _loc26_ < _loc33_)
            {
               _loc34_ = _loc29_ + _loc26_ + 1;
               if(_loc29_ + (_loc26_ + _loc27_) < _loc33_)
               {
                  _loc35_ = _loc27_;
               }
               else
               {
                  _loc35_ = _loc33_ - (_loc29_ + _loc26_);
               }
            }
            else
            {
               _loc34_ = _loc33_ + 1;
               _loc35_ = 0;
            }
            _loc36_ = true;
            _loc37_ = true;
            if(_loc26_ == 0)
            {
               if(_loc28_ > _loc30_)
               {
                  _loc37_ = false;
               }
               else
               {
                  _loc36_ = false;
               }
            }
            _loc38_ = screensM.screenBattle.isOpponentInWeaponRange(_loc4_,_loc8_,_loc25_.itemID,-1,-1,-1);
            if(_loc38_)
            {
               _loc11_.mechView.addAnimatedGlow();
            }
            screensM.screenBattle.actionRange.displayRange(_loc34_,_loc35_,null,_loc36_,_loc37_,"red");
         }
      }
      
      public function buttonMouseOut(param1:Number, param2:String, param3:Number) : void
      {
         this.deactivateInfoText();
         this.removeMechsAnimatedGlow();
         this.deactivateActionErrorMessage();
         if(this._moveToStepHandler == false)
         {
            screensM.screenBattle.removeMechHologram();
            screensM.screenBattle.actionRange.hideMe();
         }
         this.player1MechBattleTooltip.hideToolTip(false);
         this.player2MechBattleTooltip.hideToolTip(false);
         tooltip.hideToolTip();
      }
      
      private function removeMechsAnimatedGlow() : void
      {
         var _loc1_:Number = screensM.screenBattle.currentPlayerID;
         var _loc2_:BMPlayerData = dataM.playersData[_loc1_];
         var _loc3_:String = screensM.screenBattle.getMechSlot(_loc1_);
         var _loc4_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc3_];
         var _loc5_:Number = screensM.screenBattle.opponentPlayerID;
         var _loc6_:BMPlayerData = dataM.playersData[_loc5_];
         var _loc7_:String = screensM.screenBattle.getMechSlot(_loc5_);
         var _loc8_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc7_];
         if(_loc4_ != null)
         {
            if(_loc4_.mechView != null)
            {
               _loc4_.mechView.removeAnimatedGlow();
            }
         }
         if(_loc8_ != null)
         {
            if(_loc8_.mechView != null)
            {
               _loc8_.mechView.removeAnimatedGlow();
            }
         }
      }
      
      private function refreshButton(param1:BMButtonBattle, param2:Number, param3:String, param4:Boolean) : void
      {
         var _loc5_:Number = NaN;
         var _loc8_:BMMechBattleData = null;
         var _loc9_:Number = NaN;
         var _loc27_:uint = 0;
         var _loc28_:BMPlayerItemData = null;
         var _loc29_:Number = NaN;
         var _loc30_:BMItemData = null;
         var _loc31_:Object = null;
         var _loc32_:Number = NaN;
         var _loc33_:String = null;
         var _loc34_:Number = NaN;
         var _loc35_:BMPlayerItemData = null;
         var _loc36_:BMItemData = null;
         var _loc37_:Boolean = false;
         var _loc38_:Boolean = false;
         var _loc39_:String = null;
         var _loc40_:Boolean = false;
         var _loc41_:MovieClip = null;
         var _loc42_:String = null;
         var _loc43_:Boolean = false;
         var _loc44_:Array = null;
         var _loc45_:uint = 0;
         _loc5_ = screensM.screenBattle.currentPlayerID;
         var _loc6_:BMPlayerData = dataM.playersData[_loc5_];
         var _loc7_:String = screensM.screenBattle.getMechSlot(_loc5_);
         _loc8_ = screensM.screenBattle.mechBattleDatas[_loc7_];
         _loc9_ = screensM.screenBattle.opponentPlayerID;
         var _loc10_:BMPlayerData = dataM.playersData[_loc9_];
         var _loc11_:String = screensM.screenBattle.getMechSlot(_loc9_);
         var _loc12_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc11_];
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc23_:Boolean = false;
         var _loc24_:Boolean = false;
         var _loc25_:Number = 0;
         var _loc26_:Number = 0;
         switch(param3)
         {
            case "walkLeft":
            case "walkRight":
            case "jumpLeft":
            case "jumpRight":
               _loc35_ = dataM.getPlayerItemData(_loc5_,_loc8_.mechStructure.leg);
               _loc36_ = dataM.itemsDB[_loc35_.itemID];
               switch(param3)
               {
                  case "walkLeft":
                     _loc32_ = _loc8_.currentStepCode - _loc8_.stepsPerWalk;
                     _loc33_ = "walk";
                     break;
                  case "walkRight":
                     _loc32_ = _loc8_.currentStepCode + _loc8_.stepsPerWalk;
                     _loc33_ = "walk";
                     break;
                  case "jumpLeft":
                     _loc32_ = _loc8_.currentStepCode - _loc8_.stepsPerJump;
                     _loc33_ = "jump";
                     break;
                  case "jumpRight":
                     _loc32_ = _loc8_.currentStepCode + _loc8_.stepsPerJump;
                     _loc33_ = "jump";
               }
               if(_loc36_.stepsPerJump == 0)
               {
                  switch(param3)
                  {
                     case "jumpLeft":
                     case "jumpRight":
                        _loc24_ = true;
                  }
               }
               _loc34_ = screensM.screenBattle.getAvailableStep(_loc5_,_loc8_.currentStepCode,_loc32_,_loc33_);
               if(_loc34_ == -1)
               {
                  _loc13_ = true;
               }
               break;
            case "finish":
               switch(param2)
               {
                  case 1:
                     break;
                  case 2:
                     if(_loc8_.mechStructure.teleport == 0)
                     {
                        _loc18_ = true;
                     }
                     break;
                  case 3:
                     if(_loc8_.mechStructure.harpoon == 0)
                     {
                        _loc18_ = true;
                     }
                     break;
                  case 4:
                     if(_loc8_.mechStructure.charge == 0)
                     {
                        _loc18_ = true;
                     }
                     break;
                  case 5:
                     _loc37_ = false;
                     _loc27_ = 1;
                     while(_loc27_ <= dataM.maxEquipment["sideWeapon"])
                     {
                        _loc29_ = Number(_loc8_.mechStructure["sideWeapon" + _loc27_]);
                        if(_loc29_ > 0)
                        {
                           _loc28_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc29_);
                           _loc30_ = dataM.itemsDB[_loc28_.itemID];
                           _loc31_ = dataM.animationDB[_loc30_.animation];
                           if(_loc31_.effectType == "flame")
                           {
                              _loc37_ = true;
                              _loc27_ = uint(dataM.maxEquipment["sideWeapon"]);
                           }
                        }
                        _loc27_++;
                     }
                     if(_loc37_ == false)
                     {
                        _loc18_ = true;
                     }
                     break;
                  case 6:
                     break;
                  case 7:
                     _loc38_ = false;
                     _loc27_ = 1;
                     while(_loc27_ <= dataM.maxEquipment["sideWeapon"])
                     {
                        _loc29_ = Number(_loc8_.mechStructure["sideWeapon" + _loc27_]);
                        if(_loc29_ > 0)
                        {
                           _loc28_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc29_);
                           _loc30_ = dataM.itemsDB[_loc28_.itemID];
                           _loc31_ = dataM.animationDB[_loc30_.animation];
                           if(_loc31_.effectType == "sword")
                           {
                              _loc38_ = true;
                              _loc27_ = uint(dataM.maxEquipment["sideWeapon"]);
                           }
                        }
                        _loc27_++;
                     }
                     if(_loc38_ == false)
                     {
                        _loc18_ = true;
                     }
                     break;
                  case 8:
                     if(_loc8_.droneActive == false)
                     {
                        _loc18_ = true;
                     }
               }
               break;
            case "switchMech":
               TsLogger.log("refreshButton");
               break;
            case "selectMech":
               if(param1.equipmentID == _loc6_.selectedMechID)
               {
                  _loc19_ = true;
               }
               else
               {
                  _loc39_ = screensM.screenBattle.getMechSlot(dataM.player1PlayerID,param1.equipmentID);
                  if(screensM.screenBattle.mechBattleDatas[_loc39_].HP <= 0)
                  {
                     _loc20_ = true;
                  }
               }
               _loc26_ = Number(_loc6_["switchMech" + param1.equipmentID + "Uses"]);
               _loc25_ = 1;
               break;
            default:
               if(param2 > 0)
               {
                  _loc28_ = dataM.getPlayerItemData(dataM.player1PlayerID,param2);
                  _loc30_ = dataM.itemsDB[_loc28_.itemID];
                  switch(param3)
                  {
                     case "charge":
                     case "harpoon":
                     case "shield":
                     case "teleport":
                     case "drone":
                     case "leg":
                        break;
                     default:
                        _loc41_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc30_.type],_loc30_.grp,0,0,false,false);
                        param1.setPicture(_loc41_,10);
                  }
                  _loc40_ = false;
                  switch(param3)
                  {
                     case "sideWeapon":
                     case "topWeapon":
                     case "leg":
                        _loc42_ = param3;
                        switch(param3)
                        {
                           case "sideWeapon":
                           case "topWeapon":
                              _loc42_ = _loc28_.equipmentType + _loc28_.equipmentID;
                              if(_loc8_.weaponAlreadyFired[_loc42_])
                              {
                                 _loc17_ = true;
                              }
                        }
                        _loc43_ = screensM.screenBattle.isOpponentInWeaponRange(_loc5_,_loc9_,_loc30_.itemID,-1,-1,-1);
                        if(_loc43_ == false)
                        {
                           _loc13_ = true;
                        }
                        if(_loc30_.costEnergy > 0)
                        {
                           if(_loc30_.costEnergy > _loc8_.energy)
                           {
                              _loc14_ = true;
                           }
                        }
                        if(_loc30_.bullets > 0)
                        {
                           if(_loc30_.bullets > _loc8_.bullets)
                           {
                              _loc15_ = true;
                           }
                        }
                        if(_loc30_.rockets > 0)
                        {
                           if(_loc30_.rockets > _loc8_.rockets)
                           {
                              _loc16_ = true;
                           }
                        }
                        _loc26_ = Number(_loc8_.uses[_loc42_]);
                        _loc25_ = Number(_loc8_.usesMax[_loc42_]);
                        break;
                     case "teleport":
                     case "charge":
                     case "harpoon":
                        if(_loc30_.costEnergy > 0)
                        {
                           if(_loc30_.costEnergy > _loc8_.energy)
                           {
                              _loc14_ = true;
                           }
                        }
                        switch(param3)
                        {
                           case "charge":
                           case "harpoon":
                              if(screensM.screenBattle.isOpponentInWeaponRange(_loc5_,_loc9_,_loc30_.itemID,-1,-1,-1) == false)
                              {
                                 _loc13_ = true;
                              }
                        }
                        _loc26_ = Number(_loc8_.uses[param3]);
                        _loc25_ = Number(_loc8_.usesMax[param3]);
                        break;
                     case "drone":
                        if(_loc8_.droneActive)
                        {
                           _loc22_ = true;
                        }
                        else
                        {
                           _loc21_ = true;
                        }
                        break;
                     case "shield":
                        if(_loc8_.shieldActive)
                        {
                           _loc22_ = true;
                        }
                        else
                        {
                           _loc21_ = true;
                           switch(_loc8_.shieldType)
                           {
                              case "energy":
                                 if(_loc8_.energy == 0)
                                 {
                                    _loc14_ = true;
                                 }
                                 break;
                              case "heat":
                           }
                        }
                        break;
                     case "kit":
                        if(_loc30_.HPBase > 0)
                        {
                           if(_loc8_.HP == _loc8_.HPMax)
                           {
                              _loc19_ = true;
                           }
                        }
                        else if(_loc30_.energyBase > 0)
                        {
                           if(_loc8_.energy == _loc8_.energyMax)
                           {
                              _loc19_ = true;
                           }
                        }
                        else if(_loc30_.heatBase > 0)
                        {
                           if(_loc8_.heat == 0)
                           {
                              _loc19_ = true;
                           }
                        }
                        else if(_loc30_.bullets > 0)
                        {
                           if(_loc8_.bullets == _loc8_.bulletsMax)
                           {
                              _loc19_ = true;
                           }
                        }
                        else if(_loc30_.rockets > 0)
                        {
                           if(_loc8_.rockets == _loc8_.rocketsMax)
                           {
                              _loc19_ = true;
                           }
                        }
                  }
               }
               else
               {
                  _loc24_ = true;
               }
         }
         if(param4 == false)
         {
            param1.removeBlocks();
            if(_loc21_)
            {
               param1.showActivate();
            }
            else if(_loc22_)
            {
               param1.showDeactivate();
            }
            _loc44_ = new Array();
            if(_loc25_ > 0 && _loc26_ == _loc25_)
            {
               _loc18_ = true;
            }
            if(_loc18_)
            {
               _loc44_.push("usesDepleted");
            }
            else
            {
               if(_loc17_)
               {
                  _loc44_.push("alreadyFired");
               }
               if(_loc13_)
               {
                  _loc44_.push("outOfRange");
               }
               if(_loc14_)
               {
                  _loc44_.push("notEnoughEnergy");
               }
               if(_loc15_)
               {
                  _loc44_.push("notEnoughBullets");
               }
               if(_loc16_)
               {
                  _loc44_.push("notEnoughRockets");
               }
               if(_loc19_)
               {
                  _loc44_.push("blockGeneralBlock");
               }
               if(_loc20_)
               {
                  _loc44_.push("blockMechDestroyedBlock");
               }
            }
            _loc45_ = 0;
            while(_loc45_ < _loc44_.length)
            {
               switch(_loc44_[_loc45_])
               {
                  case "usesDepleted":
                     param1.showUsesDepletedBlock();
                     break;
                  case "outOfRange":
                     param1.showOutOfRangeBlock();
                     break;
                  case "alreadyFired":
                     param1.showWeaponAlreadyFiredBlock();
                     break;
                  case "notEnoughEnergy":
                     param1.showNotEnoughEnergyBlock();
                     break;
                  case "notEnoughBullets":
                     param1.showNotEnoughBulletsBlock();
                     break;
                  case "notEnoughRockets":
                     param1.showNotEnoughRocketsBlock();
                     break;
                  case "blockGeneralBlock":
                     param1.showGeneralBlock();
                     break;
                  case "blockMechDestroyedBlock":
                     param1.showMechDestroyedBlock();
               }
               _loc45_++;
            }
            if(_loc44_.length > 0)
            {
               param1.y += this.DISABLED_BUTTON_Y_ADDON;
               param1.activatePressedEffect();
            }
            if(_loc23_ == false && _loc24_ == false)
            {
               this.enableButton(param1);
            }
            else
            {
               this.disableButton(param1);
            }
         }
         if(_loc25_ > 0)
         {
            param1.showUses(_loc26_,_loc25_);
         }
      }
      
      private function enableButton(param1:BMButtonBattle) : void
      {
         param1.enableMe();
         param1.enableClickFunction();
      }
      
      private function disableButton(param1:BMButtonBattle) : void
      {
         param1.disableMe();
         param1.disableClickFunction();
      }
      
      public function enableInterface(param1:String) : void
      {
         var _loc10_:BMButtonBattle = null;
         this._expendInterface = true;
         var _loc2_:Number = screensM.screenBattle.currentPlayerID;
         var _loc3_:BMPlayerData = dataM.playersData[_loc2_];
         var _loc4_:String = screensM.screenBattle.getMechSlot(_loc2_);
         var _loc5_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc4_];
         var _loc6_:BMMechStructure = _loc5_.mechStructure;
         var _loc7_:Number = screensM.screenBattle.opponentPlayerID;
         var _loc8_:Boolean = false;
         var _loc9_:uint = 1;
         while(_loc9_ <= 10)
         {
            _loc10_ = this["btn" + _loc9_];
            _loc10_.enableMe();
            if(BMGameShortcutsHelper.extraDamamgeShortcut())
            {
               if(_loc8_ == false && (_loc10_.type == "sideWeapon" || _loc10_.type == "topWeapon"))
               {
                  this.buttonMouseClicked(_loc10_.buttonID,_loc10_.type,_loc10_.equipmentID);
                  _loc8_ = true;
               }
            }
            _loc9_++;
         }
         this.refreshInterfaceType("enableInterface");
      }
      
      public function refreshButtonsWithUses() : void
      {
         var _loc7_:BMButtonBattle = null;
         var _loc8_:String = null;
         var _loc1_:Number = screensM.screenBattle.currentPlayerID;
         var _loc2_:BMPlayerData = dataM.playersData[_loc1_];
         var _loc3_:String = screensM.screenBattle.getMechSlot(_loc1_);
         var _loc4_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc3_];
         var _loc5_:BMMechStructure = _loc4_.mechStructure;
         var _loc6_:uint = 1;
         while(_loc6_ <= 10)
         {
            _loc7_ = this["btn" + _loc6_];
            _loc8_ = _loc7_.type;
            switch(_loc8_)
            {
               case "teleport":
               case "charge":
               case "harpoon":
                  this.refreshButton(_loc7_,_loc5_[_loc8_],_loc8_,true);
                  break;
               case "sideWeapon":
               case "topWeapon":
                  this.refreshButton(_loc7_,_loc5_[_loc8_ + _loc7_.equipmentID],_loc8_,true);
            }
            _loc6_++;
         }
      }
      
      public function disableInterface() : void
      {
         var _loc2_:BMButtonBattle = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= 10)
         {
            _loc2_ = this["btn" + _loc1_];
            _loc2_.disableMe();
            _loc1_++;
         }
         this.removeMechsAnimatedGlow();
         this.deactivateActionErrorMessage();
         screensM.screenBattle.removeMechHologram();
         screensM.screenBattle.actionRange.hideMe();
         this.player1MechBattleTooltip.hideToolTip(false);
         this.player2MechBattleTooltip.hideToolTip(false);
         this.mcTutorialArrow_interface.gotoAndStop("animOff");
         this.mcTutorialArrow_interface.x = -100;
         this.createScreenBitmapForMobile();
      }
      
      public function showSpecificInterfaceType(param1:String) : void
      {
         this._interfaceType = param1;
         this.refreshInterfaceType("showSpecificInterfaceType");
      }
      
      public function disableTutorialArrow() : void
      {
         this.mcTutorialArrow_interface.gotoAndStop("animOff");
         this.mcTutorialArrow_interface.x = -100;
      }
      
      private function addActionToTotalActions(param1:String, param2:uint = 0) : void
      {
         if(param2 > 0)
         {
            this._totalActions.push({
               "type":param1,
               "equipmentID":param2
            });
         }
         else
         {
            this._totalActions.push({"type":param1});
         }
      }
      
      private function addButtonToShow(param1:String, param2:uint = 0) : void
      {
         var _loc3_:uint = 0;
         if(param1 == null || param1 == "")
         {
            this._buttonsToShow.push(null);
            if(this["btn" + this._buttonsToShow.length] != null)
            {
               this["btn" + this._buttonsToShow.length].type = "";
               this["btn" + this._buttonsToShow.length].equipmentID = 0;
            }
         }
         else
         {
            _loc3_ = this._buttonsToShow.length + 1;
            if(param2 > 0)
            {
               this._buttonsToShow.push({
                  "buttonID":_loc3_,
                  "type":param1,
                  "equipmentID":param2
               });
            }
            else
            {
               this._buttonsToShow.push({
                  "buttonID":_loc3_,
                  "type":param1
               });
            }
         }
      }
      
      public function getButtonByName(param1:String, param2:uint = 0) : BMButtonBattle
      {
         var _loc3_:BMButtonBattle = null;
         var _loc5_:BMButtonBattle = null;
         var _loc4_:uint = 1;
         while(_loc4_ <= 10)
         {
            _loc5_ = this["btn" + _loc4_];
            if(_loc5_.type == param1 && _loc5_.equipmentID == param2)
            {
               _loc3_ = this["btn" + _loc4_];
               _loc4_ = 10;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function refreshInterfaceType(param1:String) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:BMPlayerData = null;
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:BMMechStructure = null;
         var _loc7_:Number = NaN;
         var _loc8_:BMPlayerProfile = null;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Boolean = false;
         var _loc13_:BMButtonBattle = null;
         var _loc14_:Boolean = false;
         var _loc15_:Array = null;
         var _loc16_:Array = null;
         var _loc17_:Number = NaN;
         var _loc18_:BMItemData = null;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc23_:Boolean = false;
         var _loc24_:Boolean = false;
         var _loc25_:Boolean = false;
         var _loc26_:Boolean = false;
         var _loc27_:Boolean = false;
         var _loc28_:Boolean = false;
         var _loc29_:Boolean = false;
         var _loc30_:BMPlayerItemData = null;
         var _loc31_:BMItemData = null;
         var _loc32_:BMButtonBattle = null;
         var _loc33_:Sprite = null;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Boolean = false;
         var _loc41_:Number = NaN;
         var _loc42_:String = null;
         var _loc43_:String = null;
         var _loc44_:Boolean = false;
         var _loc45_:MovieClip = null;
         var _loc46_:BMPlayerItemData = null;
         var _loc47_:BMItemData = null;
         var _loc48_:Number = NaN;
         var _loc49_:BMMechView = null;
         var _loc50_:BMMechStructure = null;
         var _loc51_:BitmapData = null;
         var _loc52_:Bitmap = null;
         var _loc53_:String = null;
         var _loc54_:Boolean = false;
         var _loc55_:String = null;
         var _loc56_:BMMechBattleData = null;
         if(this._refreshInterfaceTypeCalledThisFrame == false)
         {
            this._refreshInterfaceTypeCalledThisFrame = true;
            _loc2_ = screensM.screenBattle.currentPlayerID;
            _loc3_ = dataM.playersData[_loc2_];
            _loc4_ = screensM.screenBattle.getMechSlot(_loc2_);
            _loc5_ = screensM.screenBattle.mechBattleDatas[_loc4_];
            _loc6_ = _loc5_.mechStructure;
            _loc7_ = screensM.screenBattle.opponentPlayerID;
            _loc8_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            this._buttonsToShow = new Array();
            _loc9_ = "";
            this.disableTutorialArrow();
            _loc13_ = null;
            _loc14_ = false;
            this._keyboardEnabled = true;
            this._totalActions = new Array();
            _loc16_ = [1,6,8,2,3,4,5,7];
            _loc17_ = this.FINISH_MAX;
            if(tutorialM.isTutorialActive())
            {
               _loc17_ = 2;
            }
            _loc18_ = dataM.itemsDB[dataM.getPlayerItemData(_loc2_,_loc6_.leg).itemID];
            this._expendInterface = false;
            if(this._interfaceType == "finish")
            {
               _loc10_ = 0;
               while(_loc10_ < _loc17_)
               {
                  this.addActionToTotalActions("finish",_loc16_[_loc10_]);
                  _loc10_++;
               }
            }
            else
            {
               _loc19_ = true;
               _loc20_ = true;
               switch(dataM.gameType)
               {
                  case BMDataManager.GAME_TYPE_DEFAULT:
                     if(_loc8_.level <= 2)
                     {
                        _loc20_ = false;
                     }
               }
               if(_loc19_)
               {
                  if(_loc18_.stepsPerJump > 0)
                  {
                     this.addActionToTotalActions("jumpLeft");
                     this.addActionToTotalActions("walkLeft");
                     this.addActionToTotalActions("walkRight");
                     this.addActionToTotalActions("jumpRight");
                  }
                  else if(_loc18_.stepsPerWalk > 1)
                  {
                     this.addActionToTotalActions("movement");
                  }
                  else
                  {
                     this.addActionToTotalActions("walkLeft");
                     this.addActionToTotalActions("walkRight");
                  }
               }
               _loc10_ = 1;
               while(_loc10_ <= dataM.maxEquipment["sideWeapon"])
               {
                  if(_loc6_["sideWeapon" + _loc10_] > 0)
                  {
                     this.addActionToTotalActions("sideWeapon",_loc10_);
                  }
                  _loc10_++;
               }
               _loc10_ = 1;
               while(_loc10_ <= dataM.maxEquipment["topWeapon"])
               {
                  if(_loc6_["topWeapon" + _loc10_] > 0)
                  {
                     this.addActionToTotalActions("topWeapon",_loc10_);
                  }
                  _loc10_++;
               }
               if(_loc6_.drone > 0)
               {
                  this.addActionToTotalActions("drone");
               }
               if(_loc6_.shield > 0)
               {
                  this.addActionToTotalActions("shield");
               }
               if(_loc6_.teleport > 0)
               {
                  this.addActionToTotalActions("teleport");
               }
               if(_loc6_.charge > 0)
               {
                  this.addActionToTotalActions("charge");
               }
               if(_loc6_.harpoon > 0)
               {
                  this.addActionToTotalActions("harpoon");
               }
               _loc10_ = 1;
               while(_loc10_ <= dataM.maxEquipment["kit"])
               {
                  if(dataM.useMultipleMechsKitsFix)
                  {
                     if(this._kitsUsed[_loc3_.selectedMechID][_loc10_] == null)
                     {
                        if(_loc6_["kit" + _loc10_] > 0)
                        {
                           this.addActionToTotalActions("kit",_loc10_);
                        }
                     }
                  }
                  else if(this._kitsUsed[_loc10_] == null)
                  {
                     if(_loc6_["kit" + _loc10_] > 0)
                     {
                        this.addActionToTotalActions("kit",_loc10_);
                     }
                  }
                  _loc10_++;
               }
               this.addActionToTotalActions("leg");
               if(_loc20_)
               {
                  this.addActionToTotalActions("shutDown");
               }
               if(this.multipleMechsAcitve())
               {
                  if(this.getTotlalMechsAlive() > 1)
                  {
                     _loc11_ = 1;
                     while(_loc11_ <= dataM.battleMechsPerPlayer)
                     {
                        this.addActionToTotalActions("selectMech",_loc11_);
                        _loc11_++;
                     }
                  }
               }
               if(this._totalActions.length <= this.MAX_BUTTONS_IN_ROW_REGULAR)
               {
                  this._expendInterface = true;
               }
            }
            if(this._expendInterface)
            {
               switch(this._interfaceType)
               {
                  case "moveToStepSelection":
                     this.addButtonToShow("cancel");
                     break;
                  default:
                     _loc21_ = true;
                     if(dataM.playingVSComputer)
                     {
                        switch(_loc8_.winsVSComputer)
                        {
                           case 0:
                              if(screensM.screenBattle.currentTurn > 1)
                              {
                                 this.addButtonToShow("walkRight");
                              }
                              this.addButtonToShow("sideWeapon",1);
                              if(this._walkRightClicked == false)
                              {
                                 _loc13_ = this.btn1;
                              }
                              else
                              {
                                 _loc13_ = this.getButtonByName("sideWeapon",1);
                              }
                              _loc21_ = false;
                              break;
                           case 1:
                              this.addButtonToShow("walkLeft");
                              this.addButtonToShow("walkRight");
                              this.addButtonToShow("sideWeapon",1);
                              this.addButtonToShow("sideWeapon",2);
                              this.addButtonToShow("leg");
                              _loc21_ = false;
                        }
                     }
                     if(_loc21_)
                     {
                        _loc10_ = 0;
                        while(_loc10_ < this._totalActions.length)
                        {
                           this.addButtonToShow(this._totalActions[_loc10_].type,this._totalActions[_loc10_].equipmentID);
                           _loc10_++;
                        }
                     }
               }
            }
            else
            {
               switch(this._interfaceType)
               {
                  case "menu":
                     _loc22_ = true;
                     _loc23_ = true;
                     _loc24_ = true;
                     _loc25_ = true;
                     if(dataM.playingVSComputer)
                     {
                        switch(_loc8_.winsVSComputer)
                        {
                           case 0:
                              _loc15_ = screensM.screenBattle.getWeaponsInRangeUnfired(false,false,false);
                              if(_loc15_.length == 0)
                              {
                                 _loc13_ = this.getButtonByName("movement");
                                 _loc23_ = false;
                              }
                              else
                              {
                                 _loc13_ = this.getButtonByName("weapons");
                                 _loc24_ = false;
                              }
                              _loc22_ = false;
                              _loc25_ = false;
                              break;
                           case 1:
                              _loc30_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc5_.mechStructure.leg);
                              _loc31_ = dataM.itemsDB[_loc30_.itemID];
                              if(screensM.screenBattle.isOpponentInWeaponRange(_loc2_,_loc7_,-1,_loc31_.rangeBase,_loc31_.rangeAddon,-1))
                              {
                                 _loc13_ = this.getButtonByName("leg");
                              }
                              _loc22_ = false;
                        }
                     }
                     if(_loc24_)
                     {
                        this.addButtonToShow("movement");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     if(_loc23_)
                     {
                        this.addButtonToShow("weapons");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     if(_loc6_.has_specials)
                     {
                        this.addButtonToShow("specials");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     _loc12_ = false;
                     _loc10_ = 1;
                     while(_loc10_ <= dataM.maxEquipment["kit"])
                     {
                        if(dataM.useMultipleMechsKitsFix)
                        {
                           if(this._kitsUsed[_loc3_.selectedMechID][_loc10_] == null)
                           {
                              if(_loc6_["kit" + _loc10_] > 0)
                              {
                                 _loc12_ = true;
                                 _loc10_ = uint(dataM.maxEquipment["kit"]);
                              }
                           }
                        }
                        else if(this._kitsUsed[_loc10_] == null)
                        {
                           if(_loc6_["kit" + _loc10_] > 0)
                           {
                              _loc12_ = true;
                              _loc10_ = uint(dataM.maxEquipment["kit"]);
                           }
                        }
                        _loc10_++;
                     }
                     if(_loc12_)
                     {
                        this.addButtonToShow("kits");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     if(_loc25_)
                     {
                        this.addButtonToShow("leg");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     if(_loc22_)
                     {
                        this.addButtonToShow("shutDown");
                     }
                     if(this.multipleMechsAcitve())
                     {
                        if(this.getTotlalMechsAlive() > 1)
                        {
                           this.addButtonToShow("switchMech");
                        }
                     }
                     break;
                  case "movement":
                     _loc26_ = true;
                     _loc27_ = true;
                     if(dataM.playingVSComputer)
                     {
                        switch(_loc8_.winsVSComputer)
                        {
                           case 0:
                              _loc15_ = screensM.screenBattle.getWeaponsInRangeUnfired(false,false,false);
                              if(_loc15_.length == 0)
                              {
                                 _loc13_ = this.getButtonByName("walkRight");
                                 _loc26_ = false;
                                 _loc27_ = false;
                              }
                              else
                              {
                                 _loc9_ = "menu";
                              }
                        }
                     }
                     _loc28_ = true;
                     if(_loc27_)
                     {
                        this.addButtonToShow("back");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     if(_loc18_.stepsPerJump == 0)
                     {
                        _loc28_ = false;
                     }
                     if(_loc28_)
                     {
                        this.addButtonToShow("jumpLeft");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     if(_loc26_)
                     {
                        this.addButtonToShow("walkLeft");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     this.addButtonToShow("walkRight");
                     if(_loc28_)
                     {
                        this.addButtonToShow("jumpRight");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     break;
                  case "weapons":
                     _loc29_ = true;
                     if(dataM.playingVSComputer)
                     {
                        switch(_loc8_.winsVSComputer)
                        {
                           case 0:
                              _loc13_ = this.getButtonByName("sideWeapon",1);
                              _loc14_ = true;
                              _loc29_ = false;
                        }
                     }
                     if(_loc29_)
                     {
                        this.addButtonToShow("back");
                     }
                     else
                     {
                        this.addButtonToShow(null);
                     }
                     _loc10_ = 1;
                     while(_loc10_ <= dataM.maxEquipment["sideWeapon"])
                     {
                        if(_loc6_["sideWeapon" + _loc10_] > 0)
                        {
                           this.addButtonToShow("sideWeapon",_loc10_);
                        }
                        _loc10_++;
                     }
                     _loc10_ = 1;
                     while(_loc10_ <= dataM.maxEquipment["topWeapon"])
                     {
                        if(_loc6_["topWeapon" + _loc10_] > 0)
                        {
                           this.addButtonToShow("topWeapon",_loc10_);
                        }
                        _loc10_++;
                     }
                     break;
                  case "kits":
                     _loc12_ = false;
                     _loc10_ = 1;
                     while(_loc10_ <= dataM.maxEquipment["kit"])
                     {
                        if(dataM.useMultipleMechsKitsFix)
                        {
                           if(this._kitsUsed[_loc3_.selectedMechID][_loc10_] == null)
                           {
                              if(_loc6_["kit" + _loc10_] > 0)
                              {
                                 _loc12_ = true;
                                 _loc10_ = uint(dataM.maxEquipment["kit"]);
                              }
                           }
                        }
                        else if(this._kitsUsed[_loc10_] == null)
                        {
                           if(_loc6_["kit" + _loc10_] > 0)
                           {
                              _loc12_ = true;
                              _loc10_ = uint(dataM.maxEquipment["kit"]);
                           }
                        }
                        _loc10_++;
                     }
                     if(_loc12_)
                     {
                        this.addButtonToShow("back");
                        _loc10_ = 1;
                        while(_loc10_ <= dataM.maxEquipment["kit"])
                        {
                           if(dataM.useMultipleMechsKitsFix)
                           {
                              if(this._kitsUsed[_loc3_.selectedMechID][_loc10_] == null)
                              {
                                 if(_loc6_["kit" + _loc10_] > 0)
                                 {
                                    this.addButtonToShow("kit",_loc10_);
                                 }
                              }
                           }
                           else if(this._kitsUsed[_loc10_] == null)
                           {
                              if(_loc6_["kit" + _loc10_] > 0)
                              {
                                 this.addButtonToShow("kit",_loc10_);
                              }
                           }
                           _loc10_++;
                        }
                     }
                     else
                     {
                        this._refreshInterfaceTypeCalledThisFrame = false;
                        _loc9_ = "menu";
                     }
                     break;
                  case "specials":
                     this.addButtonToShow("back");
                     if(_loc5_.mechStructure.drone > 0)
                     {
                        this.addButtonToShow("drone");
                     }
                     if(_loc5_.mechStructure.shield > 0)
                     {
                        this.addButtonToShow("shield");
                     }
                     if(_loc5_.mechStructure.teleport > 0)
                     {
                        this.addButtonToShow("teleport");
                     }
                     if(_loc5_.mechStructure.charge > 0)
                     {
                        this.addButtonToShow("charge");
                     }
                     if(_loc5_.mechStructure.harpoon > 0)
                     {
                        this.addButtonToShow("harpoon");
                     }
                     break;
                  case "moveToStepSelection":
                     this.addButtonToShow("cancel");
                     break;
                  case "switchMech":
                     this.addButtonToShow("back");
                     if(this.getTotlalMechsAlive() > 1)
                     {
                        this.addButtonToShow("selectMech",1);
                        if(dataM.battleMechsPerPlayer >= 2)
                        {
                           this.addButtonToShow("selectMech",2);
                           if(dataM.battleMechsPerPlayer == 3)
                           {
                              this.addButtonToShow("selectMech",3);
                           }
                        }
                     }
                     break;
                  case "finish":
                     _loc10_ = 0;
                     while(_loc10_ < _loc17_)
                     {
                        this.addButtonToShow("finish",_loc16_[_loc10_]);
                        _loc10_++;
                     }
               }
            }
            if(_loc9_ == "" || this._expendInterface)
            {
               _loc10_ = 0;
               while(_loc10_ < this.allButtons.length)
               {
                  _loc32_ = this.allButtons[_loc10_];
                  if(_loc32_.parent != null)
                  {
                     _loc32_.parent.removeChild(_loc32_);
                  }
                  _loc10_++;
               }
               _loc10_ = 1;
               while(_loc10_ <= 5)
               {
                  _loc33_ = this["blankButton" + _loc10_];
                  if(_loc33_.parent != null)
                  {
                     _loc33_.parent.removeChild(_loc33_);
                  }
                  _loc10_++;
               }
               _loc34_ = this.BUTTON_SIZE;
               _loc35_ = 3.5;
               _loc38_ = dataM.STAGE_HEIGHT - (_loc34_ + (_loc37_ = 6));
               _loc39_ = 1;
               _loc10_ = 0;
               while(_loc10_ < this._buttonsToShow.length)
               {
                  if(this._buttonsToShow[_loc10_] == null)
                  {
                     _loc33_ = this["blankButton" + _loc39_];
                     _loc33_.x = _loc37_;
                     _loc33_.y = _loc38_;
                     this.mcButtonsHolder.addChild(_loc33_);
                     _loc39_++;
                  }
                  else
                  {
                     _loc32_ = this["btn" + (_loc10_ + 1)];
                     _loc40_ = true;
                     if(this._forceButtonsUpdate == false)
                     {
                        switch(_loc32_.type)
                        {
                           case "sideWeapon":
                           case "topWeapon":
                           case "kit":
                           case "finish":
                           case "selectMech":
                              if(_loc32_.type == this._buttonsToShow[_loc10_].type && _loc32_.equipmentID == this._buttonsToShow[_loc10_].equipmentID)
                              {
                                 _loc40_ = false;
                              }
                              break;
                           default:
                              if(_loc32_.type == this._buttonsToShow[_loc10_].type)
                              {
                                 _loc40_ = false;
                              }
                        }
                     }
                     if(_loc40_)
                     {
                        _loc32_.type = this._buttonsToShow[_loc10_].type;
                        _loc32_.equipmentID = this._buttonsToShow[_loc10_].equipmentID;
                        _loc44_ = false;
                        _loc45_ = null;
                        switch(_loc32_.type)
                        {
                           case "leg":
                              _loc42_ = "action_stomp";
                              _loc43_ = "general";
                              break;
                           case "sideWeapon":
                           case "topWeapon":
                           case "kit":
                              _loc46_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_[_loc32_.type + _loc32_.equipmentID]);
                              _loc47_ = dataM.itemsDB[_loc46_.itemID];
                              _loc42_ = _loc47_.grp;
                              _loc43_ = dataM.itemTypeSourceDB[_loc47_.type];
                              if(dataM.runAsMobile)
                              {
                                 _loc44_ = true;
                              }
                              break;
                           case "switchMech":
                              _loc42_ = "action_switchMech";
                              _loc43_ = "general";
                              break;
                           case "selectMech":
                              if(this._mechPictures[_loc32_.equipmentID] == null)
                              {
                                 this._mechPictures[_loc32_.equipmentID] = new Object();
                                 _loc48_ = 0.4;
                                 _loc49_ = new BMMechView();
                                 _loc50_ = _loc3_.mechStructures[_loc32_.equipmentID];
                                 _loc49_.initialize(dataM.player1PlayerID,"battle","playerItemID",_loc48_,false);
                                 _loc49_.buildMech(_loc50_,"battleInterfaceBottom");
                                 _loc49_.itemsHolder.x -= _loc49_.mechSizer.x;
                                 _loc49_.itemsHolder.y -= _loc49_.mechSizer.y;
                                 _loc49_.mechSizer.parent.removeChild(_loc49_.mechSizer);
                                 _loc51_ = new BitmapData(_loc49_.width,_loc49_.height,true,0);
                                 _loc52_ = new Bitmap(_loc51_,"auto",true);
                                 _loc51_.draw(_loc49_);
                                 _loc49_.removeMe();
                                 this._mechPictures[_loc32_.equipmentID].mechBM = _loc52_;
                                 this._mechPictures[_loc32_.equipmentID].mechBMD = _loc51_;
                              }
                              _loc45_ = new MovieClip();
                              _loc45_.addChild(this._mechPictures[_loc32_.equipmentID].mechBM);
                              break;
                           case "finish":
                              _loc42_ = "action_finish" + _loc32_.equipmentID;
                              _loc43_ = "general";
                              break;
                           default:
                              _loc42_ = "action_" + _loc32_.type;
                              _loc43_ = "general";
                        }
                        if(_loc45_ != null)
                        {
                           _loc32_.setPicture(_loc45_,2);
                        }
                        else
                        {
                           _loc32_.setPicture(externalAssetsM.getAsset(_loc43_,_loc42_,0,0,false,_loc44_),0);
                        }
                        _loc32_.removeBlocks();
                     }
                     _loc32_.x = _loc37_;
                     _loc32_.y = _loc38_;
                     this.mcButtonsHolder.addChild(_loc32_);
                     _loc41_ = _loc10_ + 1;
                     if(_loc41_ == 10)
                     {
                        _loc41_ = 0;
                     }
                     if(screensM.screenBattle.USE_NUMBER_KEYS_FOR_INTERFACE)
                     {
                        _loc32_.setButtonNumber(_loc41_);
                     }
                  }
                  _loc32_.width = _loc34_;
                  _loc32_.height = _loc34_;
                  _loc32_.deactivatePressedEffect();
                  _loc37_ += _loc34_ + _loc35_;
                  switch(_loc32_.type)
                  {
                     case "sideWeapon":
                     case "topWeapon":
                     case "kit":
                        _loc53_ = _loc32_.type + _loc32_.equipmentID;
                        this.refreshButton(_loc32_,_loc6_[_loc53_],_loc32_.type,false);
                        break;
                     case "drone":
                     case "shield":
                     case "teleport":
                     case "charge":
                     case "harpoon":
                     case "leg":
                        this.refreshButton(_loc32_,_loc6_[_loc32_.type],_loc32_.type,false);
                        break;
                     case "walkLeft":
                     case "walkRight":
                     case "jumpLeft":
                     case "jumpRight":
                        this.refreshButton(_loc32_,0,_loc32_.type,false);
                        break;
                     case "selectMech":
                        _loc54_ = false;
                        if(_loc3_.selectedMechID == _loc32_.equipmentID)
                        {
                           _loc54_ = true;
                        }
                        else
                        {
                           _loc55_ = screensM.screenBattle.getMechSlot(dataM.player1PlayerID,_loc32_.equipmentID);
                           _loc56_ = screensM.screenBattle.mechBattleDatas[_loc55_];
                           if(_loc56_.HP <= 0)
                           {
                              _loc54_ = true;
                           }
                        }
                        this.refreshButton(_loc32_,_loc32_.equipmentID,_loc32_.type,false);
                        break;
                     case "finish":
                        this.refreshButton(_loc32_,_loc32_.equipmentID,_loc32_.type,false);
                  }
                  _loc10_++;
               }
               if(this._forceButtonsUpdate)
               {
                  this._forceButtonsUpdate = false;
               }
            }
            else
            {
               this.showSpecificInterfaceType(_loc9_);
            }
            if(dataM.tutorialSkipped == false && _loc13_ != null)
            {
               if(_loc14_)
               {
                  this.mcTutorialArrow_interface.rotation = 0;
                  this.mcTutorialArrow_interface.x = _loc13_.x + this.BUTTON_SIZE;
                  this.mcTutorialArrow_interface.y = _loc13_.y + _loc13_.height / 2;
               }
               else
               {
                  this.mcTutorialArrow_interface.rotation = -90;
                  this.mcTutorialArrow_interface.x = _loc13_.x + this.BUTTON_SIZE / 2;
                  this.mcTutorialArrow_interface.y = _loc13_.y;
               }
               this.mcTutorialArrow_interface.gotoAndStop("animOn");
            }
         }
         this.createScreenBitmapForMobile();
      }
      
      private function getTotlalMechsAlive() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= dataM.battleMechsPerPlayer)
         {
            if(screensM.screenBattle.mechBattleDatas[dataM.player1PlayerID + "_" + _loc2_].HP > 0)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get interfaceType() : String
      {
         return this._interfaceType;
      }
      
      public function deleteMechPictures() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= dataM.battleMaxMechs)
         {
            if(this._mechPictures[_loc1_] != null)
            {
               if(this._mechPictures[_loc1_].mechBMD != null)
               {
                  this._mechPictures[_loc1_].mechBMD.dispose();
                  this._mechPictures[_loc1_].mechBMD = null;
               }
               if(this._mechPictures[_loc1_].mechBM != null)
               {
                  if(this._mechPictures[_loc1_].mechBM.parent != null)
                  {
                     this._mechPictures[_loc1_].mechBM.parent.removeChild(this._mechPictures[_loc1_].mechBM);
                  }
                  this._mechPictures[_loc1_].mechBM = null;
               }
               this._mechPictures[_loc1_] = null;
            }
            _loc1_++;
         }
         this._mechPictures = new Array();
      }
      
      private function activatetMoveToStepSelection(param1:String) : void
      {
         this._moveToStepType = param1;
         this._moveToStepHandler = true;
         this._moveToStepTargetStep = -1;
         var _loc2_:Number = screensM.screenBattle.currentPlayerID;
         if(dataM.runAsMobile == false)
         {
            screensM.screenBattle.moveToStepArrow.gotoAndStop("animOn_available");
         }
         screensM.screenBattle.activateZoomOutForTeleport();
         this.displayWalkingActionRange(this._moveToStepType);
         this._mouseHitAreaActiveForMoveToStep = true;
      }
      
      public function cancelMoveToStepSelectionClicked(param1:Boolean = false) : void
      {
         if(this._moveToStepHandler)
         {
            this._interfaceType = "menu";
            this.deactivateMoveToStepSelection();
            screensM.screenBattle.actionRange.hideMe();
            if(param1 == false)
            {
               screensM.screenBattle.removeMechHologram();
               screensM.screenBattle.enableInterface("buttonMouseClicked");
               this.refreshInterfaceType("cancelMoveToStepSelectionClicked");
            }
         }
      }
      
      public function isMoveMechToStepActive() : Boolean
      {
         return this._moveToStepHandler;
      }
      
      public function deactivateMoveToStepSelection() : void
      {
         if(this._moveToStepHandler)
         {
            screensM.screenBattle.teleportCanceled();
            if(dataM.runAsMobile == false)
            {
               screensM.screenBattle.moveToStepArrow.gotoAndStop("animOff");
            }
            this._mouseHitAreaActiveForMoveToStep = false;
            this._moveToStepHandler = false;
         }
      }
      
      private function displayWalkingActionRange(param1:String) : void
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc2_:Number = screensM.screenBattle.currentPlayerID;
         var _loc3_:BMPlayerData = dataM.playersData[_loc2_];
         var _loc4_:String = screensM.screenBattle.getMechSlot(_loc2_);
         var _loc5_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc4_];
         var _loc6_:BMPlayerItemData = dataM.getPlayerItemData(_loc2_,_loc5_.mechStructure.leg);
         var _loc7_:BMItemData = dataM.itemsDB[_loc6_.itemID];
         var _loc8_:Number = screensM.screenBattle.opponentPlayerID;
         var _loc9_:BMPlayerData = dataM.playersData[_loc8_];
         var _loc10_:String = screensM.screenBattle.getMechSlot(_loc8_);
         var _loc11_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc10_];
         var _loc14_:Array = new Array();
         switch(param1)
         {
            case "walk":
               _loc12_ = _loc5_.currentStepCode - _loc7_.stepsPerWalk;
               _loc13_ = _loc5_.currentStepCode + _loc7_.stepsPerWalk;
               break;
            case "walkAndJump":
               _loc12_ = _loc5_.currentStepCode - _loc7_.stepsPerJump;
               _loc13_ = _loc5_.currentStepCode + _loc7_.stepsPerJump;
               break;
            case "teleport":
               if(dataM.runAsMobile)
               {
                  _loc12_ = 0;
                  _loc13_ = Number(dataM.battleData.map.stepsTotal);
               }
         }
         var _loc15_:Boolean = true;
         var _loc16_:Boolean = true;
         switch(param1)
         {
            case "walk":
               if(_loc5_.currentStepCode > _loc11_.currentStepCode)
               {
                  if(_loc11_.currentStepCode >= _loc12_)
                  {
                     _loc12_ = _loc11_.currentStepCode + 1;
                     if(_loc11_.currentStepCode == _loc5_.currentStepCode - 1)
                     {
                        _loc15_ = false;
                     }
                  }
               }
               else if(_loc11_.currentStepCode <= _loc13_)
               {
                  _loc13_ = _loc11_.currentStepCode - 1;
                  if(_loc11_.currentStepCode == _loc5_.currentStepCode + 1)
                  {
                     _loc16_ = false;
                  }
               }
         }
         if(_loc12_ < 0)
         {
            _loc12_ = 0;
         }
         if(_loc13_ > dataM.battleData.map.stepsTotal)
         {
            _loc13_ = Number(dataM.battleData.map.stepsTotal);
         }
         _loc14_.push(_loc5_.currentStepCode,_loc11_.currentStepCode);
         screensM.screenBattle.actionRange.displayRange(_loc12_,_loc13_ + 1 - _loc12_,_loc14_,_loc15_,_loc16_,"green");
      }
      
      private function displayWalkingAndJumpingActionRange() : void
      {
      }
      
      private function moveToStepHandler() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:BMPlayerData = null;
         var _loc9_:String = null;
         var _loc10_:BMMechBattleData = null;
         var _loc11_:String = null;
         var _loc12_:BMPlayerItemData = null;
         var _loc13_:BMItemData = null;
         var _loc14_:Number = NaN;
         var _loc15_:Boolean = false;
         var _loc16_:Number = NaN;
         var _loc17_:BMPlayerData = null;
         var _loc18_:String = null;
         var _loc19_:BMMechBattleData = null;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Boolean = false;
         if(this._moveToStepHandler)
         {
            if(dataM.runAsMobile == false)
            {
               _loc1_ = new Point(stage.mouseX,stage.mouseY);
               _loc2_ = screensM.screenBattle.holder_effects.globalToLocal(_loc1_);
               _loc3_ = screensM.screenBattle.FLOOR_STEP_SIZE;
               _loc4_ = Number(dataM.battleData.map.stepsTotal);
               _loc5_ = 0;
               if(_loc2_.x >= 0)
               {
                  if(_loc2_.x < _loc4_ * _loc3_)
                  {
                     _loc5_ = Math.floor(_loc2_.x / _loc3_);
                  }
                  else
                  {
                     _loc5_ = _loc4_ - 1;
                  }
               }
               if(_loc5_ != this._moveToStepTargetStep)
               {
                  this._moveToStepTargetStep = _loc5_;
                  _loc7_ = screensM.screenBattle.currentPlayerID;
                  _loc8_ = dataM.playersData[_loc7_];
                  _loc9_ = screensM.screenBattle.getMechSlot(_loc7_);
                  _loc10_ = screensM.screenBattle.mechBattleDatas[_loc9_];
                  switch(this._moveToStepType)
                  {
                     case "walk":
                     case "walkAndJump":
                        _loc11_ = "leg";
                        break;
                     case "teleport":
                        _loc11_ = "teleport";
                  }
                  _loc12_ = dataM.getPlayerItemData(_loc7_,_loc10_.mechStructure[_loc11_]);
                  _loc13_ = dataM.itemsDB[_loc12_.itemID];
                  _loc14_ = screensM.screenBattle.getAvailableStep(_loc7_,_loc10_.currentStepCode,this._moveToStepTargetStep,this._moveToStepType);
                  if(_loc14_ == this._moveToStepTargetStep)
                  {
                     switch(this._moveToStepType)
                     {
                        case "walk":
                           this.displayWalkingActionRange("walk");
                           if(Math.abs(_loc14_ - _loc10_.currentStepCode) > _loc13_.stepsPerWalk)
                           {
                              screensM.screenBattle.moveToStepArrow.gotoAndStop("animOn_blocked");
                              screensM.screenBattle.removeMechHologram();
                           }
                           else
                           {
                              screensM.screenBattle.moveToStepArrow.gotoAndStop("animOn_available");
                              screensM.screenBattle.displayMechHologram(this._moveToStepTargetStep,false);
                           }
                           break;
                        case "walkAndJump":
                           this.displayWalkingActionRange("walkAndJump");
                           if(Math.abs(_loc14_ - _loc10_.currentStepCode) > _loc13_.stepsPerJump)
                           {
                              screensM.screenBattle.moveToStepArrow.gotoAndStop("animOn_blocked");
                              screensM.screenBattle.removeMechHologram();
                           }
                           else
                           {
                              screensM.screenBattle.moveToStepArrow.gotoAndStop("animOn_available");
                              screensM.screenBattle.displayMechHologram(this._moveToStepTargetStep,false);
                           }
                           break;
                        case "teleport":
                           screensM.screenBattle.moveToStepArrow.gotoAndStop("animOn_available");
                           screensM.screenBattle.displayMechHologram(this._moveToStepTargetStep,false);
                           _loc15_ = false;
                           if(_loc13_.damageBase > 0 || _loc13_.damageAddon > 0)
                           {
                              _loc15_ = true;
                           }
                           if(_loc15_)
                           {
                              _loc16_ = screensM.screenBattle.opponentPlayerID;
                              _loc17_ = dataM.playersData[_loc16_];
                              _loc18_ = screensM.screenBattle.getMechSlot(_loc16_);
                              _loc19_ = screensM.screenBattle.mechBattleDatas[_loc18_];
                              _loc20_ = this._moveToStepTargetStep - _loc13_.rangeAddon;
                              _loc21_ = _loc13_.rangeAddon * 2 + 1;
                              _loc22_ = screensM.screenBattle.isOpponentInWeaponRange(_loc7_,_loc16_,_loc13_.itemID,-1,-1,this._moveToStepTargetStep);
                              if(_loc22_)
                              {
                                 _loc19_.mechView.addAnimatedGlow();
                              }
                              else
                              {
                                 _loc19_.mechView.removeAnimatedGlow();
                              }
                              screensM.screenBattle.actionRange.displayRange(_loc20_,_loc21_,null,true,true,"red");
                           }
                     }
                  }
                  else
                  {
                     screensM.screenBattle.moveToStepArrow.gotoAndStop("animOn_blocked");
                     screensM.screenBattle.removeMechHologram();
                     if(this._moveToStepType == "teleport")
                     {
                        this.removeMechsAnimatedGlow();
                        screensM.screenBattle.actionRange.hideMe();
                     }
                  }
               }
               _loc6_ = (this._moveToStepTargetStep + 0.5) * _loc3_;
               screensM.screenBattle.moveToStepArrow.x = _loc6_;
               if(screensM.screenBattle.moveToStepArrow.currentLabel == "animOn_available")
               {
                  screensM.screenBattle.moveToStepArrow.y = -screensM.screenBattle.mechHologram.height;
               }
               else
               {
                  screensM.screenBattle.moveToStepArrow.y = -15;
               }
            }
         }
      }
      
      private function mouseHitAreaClicked(param1:MouseEvent) : void
      {
         this.mouseHitAreaClickedSub();
      }
      
      public function mouseHitAreaClickedSub() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:BMPlayerData = null;
         var _loc3_:String = null;
         var _loc4_:BMMechBattleData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc12_:BMPlayerItemData = null;
         var _loc13_:BMItemData = null;
         var _loc14_:String = null;
         screensM.screenBattle.mouseHitAreaClicked();
         if(this._mouseHitAreaActiveForMoveToStep)
         {
            if(dataM.runAsMobile)
            {
               _loc6_ = new Point(stage.mouseX,stage.mouseY);
               _loc7_ = screensM.screenBattle.holder_effects.globalToLocal(_loc6_);
               _loc8_ = screensM.screenBattle.FLOOR_STEP_SIZE;
               _loc9_ = Number(dataM.battleData.map.stepsTotal);
               _loc10_ = 0;
               if(_loc7_.x >= 0)
               {
                  if(_loc7_.x < _loc9_ * _loc8_)
                  {
                     _loc10_ = Math.floor(_loc7_.x / _loc8_);
                  }
                  else
                  {
                     _loc10_ = _loc9_ - 1;
                  }
               }
               this._moveToStepTargetStep = _loc10_;
            }
            _loc1_ = screensM.screenBattle.currentPlayerID;
            _loc2_ = dataM.playersData[_loc1_];
            _loc3_ = screensM.screenBattle.getMechSlot(_loc1_);
            _loc4_ = screensM.screenBattle.mechBattleDatas[_loc3_];
            _loc5_ = screensM.screenBattle.getAvailableStep(_loc1_,_loc4_.currentStepCode,this._moveToStepTargetStep,this._moveToStepType);
            if(_loc5_ == this._moveToStepTargetStep)
            {
               _loc11_ = true;
               _loc12_ = dataM.getPlayerItemData(_loc1_,_loc4_.mechStructure.leg);
               _loc13_ = dataM.itemsDB[_loc12_.itemID];
               switch(this._moveToStepType)
               {
                  case "walk":
                     if(Math.abs(_loc5_ - _loc4_.currentStepCode) > _loc13_.stepsPerWalk)
                     {
                        _loc11_ = false;
                     }
                     break;
                  case "walkAndJump":
                     if(Math.abs(_loc5_ - _loc4_.currentStepCode) > _loc13_.stepsPerJump)
                     {
                        _loc11_ = false;
                     }
               }
               if(_loc11_)
               {
                  this._interfaceType = "menu";
                  this.refreshInterfaceType("mouseHitAreaClicked");
                  this.deactivateMoveToStepSelection();
                  switch(this._moveToStepType)
                  {
                     case "walk":
                        screensM.screenBattle.moveMechToStep("walk",this._moveToStepTargetStep);
                        break;
                     case "walkAndJump":
                        _loc14_ = "jump";
                        if(Math.abs(_loc4_.currentStepCode - this._moveToStepTargetStep) <= _loc13_.stepsPerWalk)
                        {
                           if(screensM.screenBattle.getAvailableStep(dataM.player1PlayerID,_loc4_.currentStepCode,this._moveToStepTargetStep,"walk") > -1)
                           {
                              _loc14_ = "walk";
                           }
                        }
                        screensM.screenBattle.moveMechToStep(_loc14_,this._moveToStepTargetStep);
                        break;
                     case "teleport":
                        screensM.screenBattle.teleportLocationClicked(this._moveToStepTargetStep);
                  }
               }
            }
         }
      }
      
      private function activateInfoText(param1:String) : void
      {
         if(dataM.runAsMobile == false)
         {
            this._infoTextActive = true;
            this.mcInfoText.txtInfo.text = param1;
         }
      }
      
      private function deactivateInfoText() : void
      {
         if(dataM.runAsMobile == false)
         {
            this._infoTextActive = false;
            this._infoTextDeactivationCountdown = 5;
         }
      }
      
      private function resetInfoText() : void
      {
         if(dataM.runAsMobile == false)
         {
            this._infoTextActive = false;
            this.mcInfoText.mcMask.width = 0;
            this.mcInfoText.mcMask.x = 0;
            this.mcInfoText.mcTextBox_left.x = 0;
            this.mcInfoText.mcTextBox_right.x = 0;
         }
      }
      
      private function infoTextHandler() : void
      {
         if(dataM.runAsMobile == false)
         {
            if(this._infoTextActive)
            {
               if(this.mcInfoText.mcTextBox_left.x > -this.INFO_TEXT_WIDTH)
               {
                  this.mcInfoText.mcTextBox_left.x -= this.INFO_TEXT_X_CHANGE;
                  this.mcInfoText.mcTextBox_right.x += this.INFO_TEXT_X_CHANGE;
                  this.mcInfoText.mcMask.width = this.mcInfoText.mcTextBox_right.x * 2;
                  this.mcInfoText.mcMask.x = 0;
                  if(this.mcInfoText.mcTextBox_left.x <= -this.INFO_TEXT_WIDTH)
                  {
                     this.mcInfoText.mcTextBox_left.x = -this.INFO_TEXT_WIDTH;
                     this.mcInfoText.mcTextBox_right.x = this.INFO_TEXT_WIDTH;
                  }
               }
            }
            else if(this._infoTextDeactivationCountdown > 0)
            {
               --this._infoTextDeactivationCountdown;
            }
            else if(this.mcInfoText.mcTextBox_left.x < 0)
            {
               this.mcInfoText.mcTextBox_left.x += this.INFO_TEXT_X_CHANGE;
               this.mcInfoText.mcTextBox_right.x -= this.INFO_TEXT_X_CHANGE;
               this.mcInfoText.mcMask.width = this.mcInfoText.mcTextBox_right.x * 2;
               this.mcInfoText.mcMask.x = 0;
               if(this.mcInfoText.mcTextBox_left.x >= 0)
               {
                  this.mcInfoText.mcTextBox_left.x = 0;
                  this.mcInfoText.mcTextBox_right.x = 0;
               }
            }
         }
      }
      
      public function showInterface(param1:String) : void
      {
         this._displayStatus = "show";
      }
      
      public function hideInterface() : void
      {
         this._displayStatus = "hide";
         this.deactivateInfoText();
      }
      
      private function showHideInterfaceHandler() : void
      {
         var _loc1_:Number = NaN;
         switch(this._displayStatus)
         {
            case "show":
               _loc1_ = 0;
               if(y > _loc1_ + 1)
               {
                  y -= (y - _loc1_) * this.INTERFACE_MOTION_RATIO;
                  if(y <= _loc1_ + 1)
                  {
                     y = _loc1_;
                  }
               }
               break;
            case "hide":
               _loc1_ = this.INTERFACE_HEIGHT;
               if(y < _loc1_)
               {
                  y += (_loc1_ - y) * this.INTERFACE_MOTION_RATIO;
                  if(y >= _loc1_ - 1)
                  {
                     y = _loc1_;
                  }
               }
         }
      }
      
      public function buttonMouseClicked(param1:Number, param2:String, param3:Number) : void
      {
         var _loc7_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:BMMechBattleData = null;
         var _loc11_:BMMechStructure = null;
         var _loc12_:BMItemData = null;
         var _loc4_:Boolean = false;
         var _loc5_:BMButtonBattle = this["btn" + param1];
         _loc5_.y += this.DISABLED_BUTTON_Y_ADDON;
         _loc5_.activatePressedEffect();
         var _loc6_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc7_ = screensM.screenBattle.currentPlayerID;
         var _loc8_:BMPlayerData = dataM.playersData[_loc7_];
         switch(param2)
         {
            case "weapons":
               this._interfaceType = "weapons";
               _loc4_ = true;
               break;
            case "kits":
               this._interfaceType = "kits";
               _loc4_ = true;
               break;
            case "movement":
               _loc9_ = screensM.screenBattle.getMechSlot(_loc7_);
               _loc10_ = screensM.screenBattle.mechBattleDatas[_loc9_];
               _loc11_ = _loc10_.mechStructure;
               _loc12_ = dataM.itemsDB[dataM.getPlayerItemData(_loc7_,_loc11_.leg).itemID];
               if(_loc12_.stepsPerJump == 0)
               {
                  this.activatetMoveToStepSelection("walk");
                  this._interfaceType = "moveToStepSelection";
               }
               else if(_loc12_.stepsPerWalk >= 2 && _loc12_.stepsPerJump >= 3)
               {
                  this.activatetMoveToStepSelection("walkAndJump");
                  this._interfaceType = "moveToStepSelection";
               }
               else
               {
                  this._interfaceType = "movement";
               }
               _loc4_ = true;
               break;
            case "specials":
               this._interfaceType = "specials";
               _loc4_ = true;
               break;
            case "switchMech":
               this._interfaceType = "switchMech";
               _loc4_ = true;
               break;
            case "back":
               this._interfaceType = "menu";
               _loc4_ = true;
               break;
            case "cancel":
               this.cancelMoveToStepSelectionClicked();
               break;
            case "walkLeft":
               screensM.screenBattle.walkLeftClicked();
               break;
            case "walkRight":
               screensM.screenBattle.walkRightClicked();
               this._walkRightClicked = true;
               break;
            case "jumpLeft":
               screensM.screenBattle.jumpLeftClicked();
               break;
            case "jumpRight":
               screensM.screenBattle.jumpRightClicked();
               break;
            case "shutDown":
               screensM.screenBattle.shutDownClicked();
               break;
            case "sideWeapon":
               screensM.screenBattle.fireWeapon("sideWeapon",param3);
               break;
            case "topWeapon":
               screensM.screenBattle.fireWeapon("topWeapon",param3);
               break;
            case "leg":
               screensM.screenBattle.fireWeapon("leg",0);
               break;
            case "drone":
               screensM.screenBattle.activateDeactivateDrone();
               break;
            case "shield":
               screensM.screenBattle.activateDeactivateShield();
               break;
            case "teleport":
               this._interfaceType = "moveToStepSelection";
               _loc4_ = true;
               this.activatetMoveToStepSelection("teleport");
               break;
            case "charge":
               screensM.screenBattle.chargeClicked();
               break;
            case "harpoon":
               screensM.screenBattle.harpoonClicked();
               break;
            case "kit":
               if(dataM.useMultipleMechsKitsFix)
               {
                  this._kitsUsed[_loc8_.selectedMechID][param3] = true;
               }
               else
               {
                  this._kitsUsed[param3] = true;
               }
               screensM.screenBattle.useKit(param3);
               _loc5_.activatePressedEffect();
               break;
            case "selectMech":
               screensM.screenBattle.switchMechClicked(param3);
               break;
            case "finish":
               screensM.screenBattle.activateFinishMove(param3);
         }
         if(_loc4_)
         {
            this.refreshInterfaceType("buttonMouseClicked " + param2 + " " + param3);
         }
         tooltip.hideToolTip();
      }
      
      public function resetWalkRightClicked() : void
      {
         this._walkRightClicked = false;
      }
      
      private function resetMechBattleDataTooltips() : void
      {
         var _loc2_:BMMechBattleTooltip = null;
         var _loc3_:Number = NaN;
         var _loc1_:uint = 1;
         while(_loc1_ <= 2)
         {
            _loc2_ = this["player" + _loc1_ + "MechBattleTooltip"];
            _loc3_ = this.MECH_BATTLE_TOOLTIP_X_POS;
            if(_loc1_ == 2)
            {
               _loc3_ = dataM.STAGE_WIDTH - this.MECH_BATTLE_TOOLTIP_X_POS;
            }
            _loc2_.setTargetXPos(_loc3_);
            _loc1_++;
         }
      }
      
      private function mechBattleTooltipsHandler() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:BMMechBattleTooltip = null;
         var _loc1_:uint = dataM.player1PlayerID;
         while(_loc1_ <= dataM.player2PlayerID)
         {
            _loc2_ = dataM.getInterfacePlayerID(_loc1_);
            _loc3_ = this["player" + _loc2_ + "MechBattleTooltip"];
            if(_loc3_.visible)
            {
               _loc3_.onEnterFrameTrigger();
            }
            _loc1_++;
         }
         if(this._heatCriticalAlertCountdown > 0)
         {
            --this._heatCriticalAlertCountdown;
            if(this._heatCriticalAlertCountdown == 0)
            {
               if(screensM.screenBattleInterfaceTop.mcActionErrorMessage.mcBackground.currentLabel == "heatCritical")
               {
                  this.deactivateActionErrorMessage();
               }
            }
         }
         if(this._shuttingDownAlertCountdown > 0)
         {
            --this._shuttingDownAlertCountdown;
            if(this._shuttingDownAlertCountdown == 0)
            {
               if(screensM.screenBattleInterfaceTop.mcActionErrorMessage.mcBackground.currentLabel == "shuttingDown")
               {
                  this.deactivateActionErrorMessage();
               }
            }
         }
         if(this._actionErrorMessage)
         {
            if(screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleX < 1)
            {
               screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleX += 0.2;
               screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleY += 0.2;
               if(screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleX > 0.95)
               {
                  screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleX = 1;
                  screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleY = 1;
               }
            }
         }
         else if(this._actionErrorMessageDeactivateCooldown > 0)
         {
            --this._actionErrorMessageDeactivateCooldown;
         }
         else if(screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleX > 0)
         {
            screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleX -= 0.2;
            screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleY -= 0.2;
            if(screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleX < 0.05)
            {
               screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleX = 0;
               screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleY = 0;
            }
         }
      }
      
      public function activateActionErrorMessage(param1:String) : void
      {
         screensM.screenBattleInterfaceTop.mcActionErrorMessage.txtError.text = getScreenText("error_" + param1);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("battleInterfaceTop_error",[screensM.screenBattleInterfaceTop.mcActionErrorMessage.txtError],"",screensM.screenBattleInterfaceTop.mcActionErrorMessage);
         }
         screensM.screenBattleInterfaceTop.mcActionErrorMessage.mcBackground.gotoAndStop(param1);
         this._actionErrorMessage = true;
      }
      
      public function deactivateActionErrorMessage() : void
      {
         if(this._actionErrorMessage)
         {
            this._actionErrorMessage = false;
            this._actionErrorMessageDeactivateCooldown = 4;
         }
      }
      
      public function resetActionErrorMessage() : void
      {
         this._actionErrorMessage = false;
         this._actionErrorMessageDeactivateCooldown = 0;
         screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleX = 0;
         screensM.screenBattleInterfaceTop.mcActionErrorMessage.scaleY = 0;
      }
      
      public function setHeatCriticalAlertCountdown(param1:Number) : void
      {
         this._heatCriticalAlertCountdown = param1;
      }
      
      public function setHeatCriticalAlertCountdownToMax() : void
      {
         this._heatCriticalAlertCountdown = this.HEAT_CRITICAL_ALERT_FRAMES;
      }
      
      public function setShuttingDownAlertCountdown(param1:Number) : void
      {
         this._shuttingDownAlertCountdown = param1;
      }
      
      public function setShuttingDownAlertCountdownToMax() : void
      {
         this._shuttingDownAlertCountdown = this.SHUTTING_DOWN_ALERT_FRAMES;
      }
      
      private function mobileMouseOverHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:BMButtonBattle = null;
         var _loc3_:uint = 0;
         if(dataM.runAsMobile)
         {
            _loc1_ = this._mobileButtonMouseOverSlot;
            this._mobileButtonMouseOverSlot = -1;
            if(screensM.mobileMouseDown && screensM.mobileMouseDownFrames >= screensM.screenBattle.MOBILE_MOUSE_DOWN_FRAMES_FOR_BATTLE_TOOLTIP)
            {
               _loc3_ = 0;
               while(_loc3_ < this.allButtons.length)
               {
                  _loc2_ = this.allButtons[_loc3_];
                  if(_loc2_.parent != null)
                  {
                     if(mouseX >= _loc2_.x && mouseX <= _loc2_.x + _loc2_.width && mouseY >= _loc2_.y && mouseY <= _loc2_.y + _loc2_.height)
                     {
                        this._mobileButtonMouseOverSlot = _loc3_;
                        if(_loc1_ != this._mobileButtonMouseOverSlot)
                        {
                           this.buttonMouseOver(_loc2_.buttonID,_loc2_.type,_loc2_.equipmentID);
                        }
                        _loc3_ = this.allButtons.length;
                     }
                  }
                  _loc3_++;
               }
            }
            if(_loc1_ > -1 && this._mobileButtonMouseOverSlot == -1)
            {
               _loc2_ = this.allButtons[_loc1_];
               this.buttonMouseOut(_loc2_.buttonID,_loc2_.type,_loc2_.equipmentID);
            }
         }
      }
      
      private function multipleMechsAcitve() : Boolean
      {
         var _loc1_:Boolean = false;
         if(dataM.battleMechsPerPlayer > 1)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
   }
}

