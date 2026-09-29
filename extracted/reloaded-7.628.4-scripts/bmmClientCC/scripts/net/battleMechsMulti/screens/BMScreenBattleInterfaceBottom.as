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
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMMechBattleTooltip;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.autoplayAndGameSpeedPanel.BMAutoplayAndGameSpeedPanel;
   import net.battleMechsMulti.mobiles.buttons.BMButtonBattle;
   import net.battleMechsMulti.mobiles.chat.BMMiniChat;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3815")]
   public class BMScreenBattleInterfaceBottom extends BMBaseScreen
   {
      
      private static const ITEM_DISTANCE_FROM_BORDER:uint = 10;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcScreenBitmapHolder:Sprite;
      
      public var mcBackground:Sprite;
      
      public var mcAutoplayAndGameSpeedPanel:BMAutoplayAndGameSpeedPanel;
      
      private var mouseHitAreaHolder:MovieClip;
      
      public var mouseHitArea:MovieClip;
      
      public var mcTutorialArrow_interface:MovieClip;
      
      public var mcInfoText:MovieClip;
      
      public var miniChat:BMMiniChat;
      
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
      
      private var _enabled:Boolean;
      
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
      
      private var _mechPicturesData:Array = new Array();
      
      private var _forceButtonsUpdate:Boolean;
      
      private const BUTTON_SIZE:Number = 76;
      
      private const BUTTON_SIZE_SHRINK:Number = 61;
      
      private const INTERFACE_HEIGHT:Number = 90;
      
      private const INTERFACE_MOTION_RATIO:Number = 0.3;
      
      private const MAX_BUTTONS_IN_ROW_REGULAR:Number = 10;
      
      private const MAX_BUTTONS_IN_ROW_REGULAR_WITH_AUTO_PILOT:Number = 8;
      
      private const INFO_TEXT_WIDTH:Number = 145;
      
      private const INFO_TEXT_X_CHANGE:Number = 20;
      
      private const KEYBOARD_COOLDOWN:Number = 6;
      
      private const MECH_BATTLE_TOOLTIP_X_POS:Number = 90;
      
      private const HEAT_CRITICAL_ALERT_FRAMES:Number = 65;
      
      private const SHUTTING_DOWN_ALERT_FRAMES:Number = 65;
      
      private const FINISH_MAX:Number = 8;
      
      private const DISABLED_BUTTON_Y_ADDON:uint = 7;
      
      private var miniChatOrigY:Number;
      
      private var autoplayAndSpeedOrigY:Number;
      
      private var _forceHideInterface:Boolean = false;
      
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
               if(this.mcAutoplayAndGameSpeedPanel.parent != null)
               {
                  this.mcAutoplayAndGameSpeedPanel.parent.removeChild(this.mcAutoplayAndGameSpeedPanel);
                  addChild(this.mcAutoplayAndGameSpeedPanel);
               }
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
            this.initMiniChat();
            this._firestRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this._enabled = false;
         this.initAutoplayAndGameSpeedPanel();
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
         if(parent == null || screensM.screenBattle == null)
         {
            return;
         }
         if(screensM.screenBattle.opponentAvailable == false)
         {
            return;
         }
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
         var _loc23_:Number = NaN;
         var _loc24_:String = null;
         var _loc25_:BMPlayerItemData = null;
         var _loc26_:BMItemData = null;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Boolean = false;
         var _loc38_:Boolean = false;
         var _loc39_:Boolean = false;
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
            case BMMechStructure.SIDE_WEAPON:
            case BMMechStructure.TOP_WEAPON:
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
               else if(screensM.screenBattle.doesAttackerHasEnoughHPToFireWeapon(dataM.player1PlayerID,_loc17_) == false)
               {
                  this.activateActionErrorMessage("notEnoughHP");
               }
               _loc19_ = languageM.getItemNameByItemData(_loc17_);
               this.activateInfoText(_loc19_);
               if(_loc17_.isRecoilWeapon || _loc17_.isFireJumpWeapon)
               {
                  if(_loc7_.currentStepCode < _loc11_.currentStepCode)
                  {
                     _loc23_ = _loc7_.currentStepCode - _loc17_.pushSelf;
                  }
                  else
                  {
                     _loc23_ = _loc7_.currentStepCode + _loc17_.pushSelf;
                  }
                  _loc23_ = Math.max(0,_loc23_);
                  _loc23_ = Math.min(dataM.battleData.map.stepsTotal - 1,_loc23_);
                  if(_loc23_ != _loc7_.currentStepCode)
                  {
                     screensM.screenBattle.displayMechHologram(_loc23_,false);
                  }
                  if(screensM.screenBattle.isAttackingMechWeaponInRetreatBlock(dataM.player1PlayerID,dataM.player2PlayerID,_loc17_))
                  {
                     this.activateActionErrorMessage("cannotRetreat");
                  }
               }
               break;
            case BMMechStructure.CHARGE:
            case BMMechStructure.HARPOON:
            case BMMechStructure.TELEPORT:
               if(_loc7_.usesMax[param2] > 0 && _loc7_.uses[param2] == _loc7_.usesMax[param2])
               {
                  this.activateActionErrorMessage("usesDepleted");
               }
               this.activateInfoText(dataM.infoTextDB[param2]);
               switch(param2)
               {
                  case BMMechStructure.HARPOON:
                  case BMMechStructure.CHARGE:
                     _loc13_ = true;
               }
               break;
            case BMMechStructure.DRONE:
               if(_loc7_.droneActive)
               {
                  this.activateInfoText(dataM.infoTextDB["droneDeactivate"]);
               }
               else
               {
                  this.activateInfoText(dataM.infoTextDB["droneActivate"]);
               }
               _loc16_ = dataM.getPlayerItemData(_loc4_,_loc7_.mechStructure.drone);
               _loc17_ = dataM.itemsDB[_loc16_.itemID];
               if(_loc17_.rangeAddon < 99)
               {
                  _loc13_ = true;
               }
               break;
            case BMMechStructure.SHIELD:
               if(_loc7_.shieldActive)
               {
                  this.activateInfoText(dataM.infoTextDB["shieldDeactivate"]);
               }
               else
               {
                  this.activateInfoText(dataM.infoTextDB["shieldActivate"]);
               }
               break;
            case BMMechStructure.LEG:
               this.activateInfoText(getScreenText("stomp"));
               _loc13_ = true;
               break;
            case BMMechStructure.KIT:
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
               _loc19_ = languageM.getItemNameByItemData(_loc17_);
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
               case BMMechStructure.CHARGE:
               case BMMechStructure.HARPOON:
               case BMMechStructure.LEG:
               case BMMechStructure.DRONE:
                  _loc24_ = param2;
                  break;
               default:
                  _loc24_ = param2 + param3;
            }
            _loc25_ = dataM.getPlayerItemData(_loc4_,_loc7_.mechStructure[_loc24_]);
            _loc26_ = dataM.itemsDB[_loc25_.itemID];
            _loc27_ = _loc26_.rangeBase;
            _loc28_ = _loc26_.rangeAddon;
            _loc30_ = _loc29_ = _loc7_.currentStepCode;
            _loc32_ = _loc31_ = _loc11_.currentStepCode;
            _loc33_ = _loc12_ / 2;
            _loc34_ = Number(dataM.battleData.map.stepsTotal);
            if(_loc29_ > _loc31_)
            {
               _loc35_ = 0;
               if(_loc30_ - _loc27_ >= 0)
               {
                  if(_loc30_ - (_loc27_ + _loc28_) >= 0)
                  {
                     _loc35_ = _loc30_ - (_loc27_ + _loc28_);
                     _loc36_ = _loc28_;
                  }
                  else
                  {
                     _loc36_ = _loc30_ - _loc27_;
                  }
               }
               else
               {
                  _loc36_ = 0;
               }
            }
            else if(_loc30_ + _loc27_ < _loc34_)
            {
               _loc35_ = _loc30_ + _loc27_ + 1;
               if(_loc30_ + (_loc27_ + _loc28_) < _loc34_)
               {
                  _loc36_ = _loc28_;
               }
               else
               {
                  _loc36_ = _loc34_ - (_loc30_ + _loc27_);
               }
            }
            else
            {
               _loc35_ = _loc34_ + 1;
               _loc36_ = 0;
            }
            _loc37_ = true;
            _loc38_ = true;
            if(_loc27_ == 0)
            {
               if(_loc29_ > _loc31_)
               {
                  _loc38_ = false;
               }
               else
               {
                  _loc37_ = false;
               }
            }
            _loc39_ = screensM.screenBattle.isOpponentInWeaponRange(_loc4_,_loc8_,_loc26_.itemID,-1,-1,-1);
            if(_loc39_)
            {
               _loc11_.mechView.addAnimatedGlow();
            }
            screensM.screenBattle.actionRange.displayRange(_loc35_,_loc36_,null,_loc37_,_loc38_,"red");
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
         var _loc29_:uint = 0;
         var _loc30_:BMPlayerItemData = null;
         var _loc31_:Number = NaN;
         var _loc32_:BMItemData = null;
         var _loc33_:Object = null;
         var _loc34_:Number = NaN;
         var _loc35_:String = null;
         var _loc36_:Number = NaN;
         var _loc37_:BMPlayerItemData = null;
         var _loc38_:BMItemData = null;
         var _loc39_:Boolean = false;
         var _loc40_:Boolean = false;
         var _loc41_:String = null;
         var _loc42_:Boolean = false;
         var _loc43_:MovieClip = null;
         var _loc44_:String = null;
         var _loc45_:Boolean = false;
         var _loc46_:Array = null;
         var _loc47_:uint = 0;
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
         var _loc25_:Boolean = false;
         var _loc26_:Boolean = false;
         var _loc27_:Number = 0;
         var _loc28_:Number = 0;
         switch(param3)
         {
            case "walkLeft":
            case "walkRight":
            case "jumpLeft":
            case "jumpRight":
               _loc37_ = dataM.getPlayerItemData(_loc5_,_loc8_.mechStructure.leg);
               _loc38_ = dataM.itemsDB[_loc37_.itemID];
               switch(param3)
               {
                  case "walkLeft":
                     _loc34_ = _loc8_.currentStepCode - _loc8_.stepsPerWalk;
                     _loc35_ = "walk";
                     break;
                  case "walkRight":
                     _loc34_ = _loc8_.currentStepCode + _loc8_.stepsPerWalk;
                     _loc35_ = "walk";
                     break;
                  case "jumpLeft":
                     _loc34_ = _loc8_.currentStepCode - _loc8_.stepsPerJump;
                     _loc35_ = "jump";
                     break;
                  case "jumpRight":
                     _loc34_ = _loc8_.currentStepCode + _loc8_.stepsPerJump;
                     _loc35_ = "jump";
               }
               if(_loc38_.stepsPerJump == 0)
               {
                  switch(param3)
                  {
                     case "jumpLeft":
                     case "jumpRight":
                        _loc26_ = true;
                  }
               }
               _loc36_ = screensM.screenBattle.getAvailableStep(_loc5_,_loc8_.currentStepCode,_loc34_,_loc35_);
               if(_loc36_ == -1)
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
                        _loc19_ = true;
                     }
                     break;
                  case 3:
                     if(_loc8_.mechStructure.harpoon == 0)
                     {
                        _loc19_ = true;
                     }
                     break;
                  case 4:
                     if(_loc8_.mechStructure.charge == 0)
                     {
                        _loc19_ = true;
                     }
                     break;
                  case 5:
                     _loc39_ = false;
                     _loc29_ = 1;
                     while(_loc29_ <= dataM.maxEquipment[BMMechStructure.SIDE_WEAPON])
                     {
                        _loc31_ = Number(_loc8_.mechStructure[BMMechStructure.SIDE_WEAPON + _loc29_]);
                        if(_loc31_ > 0)
                        {
                           _loc30_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc31_);
                           _loc32_ = dataM.itemsDB[_loc30_.itemID];
                           _loc33_ = dataM.animationDB[_loc32_.animation];
                           if(_loc33_.effectType == "flame")
                           {
                              _loc39_ = true;
                              _loc29_ = uint(dataM.maxEquipment[BMMechStructure.SIDE_WEAPON]);
                           }
                        }
                        _loc29_++;
                     }
                     if(_loc39_ == false)
                     {
                        _loc19_ = true;
                     }
                     break;
                  case 6:
                     break;
                  case 7:
                     _loc40_ = false;
                     _loc29_ = 1;
                     while(_loc29_ <= dataM.maxEquipment[BMMechStructure.SIDE_WEAPON])
                     {
                        _loc31_ = Number(_loc8_.mechStructure[BMMechStructure.SIDE_WEAPON + _loc29_]);
                        if(_loc31_ > 0)
                        {
                           _loc30_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc31_);
                           _loc32_ = dataM.itemsDB[_loc30_.itemID];
                           _loc33_ = dataM.animationDB[_loc32_.animation];
                           if(_loc33_.effectType == "sword")
                           {
                              _loc40_ = true;
                              _loc29_ = uint(dataM.maxEquipment[BMMechStructure.SIDE_WEAPON]);
                           }
                        }
                        _loc29_++;
                     }
                     if(_loc40_ == false)
                     {
                        _loc19_ = true;
                     }
                     break;
                  case 8:
                     if(_loc8_.droneActive == false)
                     {
                        _loc19_ = true;
                     }
               }
               break;
            case "switchMech":
               TsLogger.log("refreshButton");
               break;
            case "selectMech":
               if(param1.equipmentID == _loc6_.selectedMechID)
               {
                  _loc20_ = true;
               }
               else
               {
                  _loc41_ = screensM.screenBattle.getMechSlot(dataM.player1PlayerID,param1.equipmentID);
                  if(screensM.screenBattle.mechBattleDatas[_loc41_].HP <= 0)
                  {
                     _loc21_ = true;
                  }
               }
               _loc28_ = Number(_loc6_["switchMech" + param1.equipmentID + "Uses"]);
               _loc27_ = 1;
               break;
            default:
               if(param2 > 0)
               {
                  _loc30_ = dataM.getPlayerItemData(dataM.player1PlayerID,param2);
                  _loc32_ = dataM.itemsDB[_loc30_.itemID];
                  switch(param3)
                  {
                     case BMMechStructure.CHARGE:
                     case BMMechStructure.HARPOON:
                     case BMMechStructure.SHIELD:
                     case BMMechStructure.TELEPORT:
                     case BMMechStructure.DRONE:
                     case BMMechStructure.LEG:
                        break;
                     default:
                        if(param1.isPictureLoading() == false && param4 == false)
                        {
                           _loc43_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc32_.type],_loc32_.grp);
                           param1.setPicture(_loc43_,ITEM_DISTANCE_FROM_BORDER);
                           if(_loc43_.loading)
                           {
                              externalAssetsM.modifyExternalAssetDuplicationContainer(_loc43_,false,0,this.itemGrpLoaded,[param1]);
                           }
                        }
                  }
                  _loc42_ = false;
                  switch(param3)
                  {
                     case BMMechStructure.SIDE_WEAPON:
                     case BMMechStructure.TOP_WEAPON:
                     case BMMechStructure.LEG:
                        _loc44_ = param3;
                        switch(param3)
                        {
                           case BMMechStructure.SIDE_WEAPON:
                           case BMMechStructure.TOP_WEAPON:
                              _loc44_ = _loc30_.equipmentType + _loc30_.equipmentID;
                              if(_loc8_.weaponAlreadyFired[_loc44_])
                              {
                                 _loc18_ = true;
                              }
                        }
                        _loc45_ = screensM.screenBattle.isOpponentInWeaponRange(_loc5_,_loc9_,_loc32_.itemID,-1,-1,-1);
                        if(_loc45_ == false)
                        {
                           _loc13_ = true;
                        }
                        if(_loc32_.costEnergy > 0)
                        {
                           if(_loc32_.costEnergy > _loc8_.energy)
                           {
                              _loc14_ = true;
                           }
                        }
                        if(_loc32_.bullets > 0)
                        {
                           if(_loc32_.bullets > _loc8_.bullets)
                           {
                              _loc15_ = true;
                           }
                        }
                        if(_loc32_.rockets > 0)
                        {
                           if(_loc32_.rockets > _loc8_.rockets)
                           {
                              _loc16_ = true;
                           }
                        }
                        if(screensM.screenBattle.doesAttackerHasEnoughHPToFireWeapon(dataM.player1PlayerID,_loc32_) == false)
                        {
                           _loc17_ = true;
                        }
                        if(screensM.screenBattle.isAttackingMechWeaponInRetreatBlock(dataM.player1PlayerID,dataM.player2PlayerID,_loc32_))
                        {
                           _loc22_ = true;
                        }
                        _loc28_ = Number(_loc8_.uses[_loc44_]);
                        _loc27_ = Number(_loc8_.usesMax[_loc44_]);
                        break;
                     case BMMechStructure.TELEPORT:
                     case BMMechStructure.CHARGE:
                     case BMMechStructure.HARPOON:
                        if(_loc32_.costEnergy > 0)
                        {
                           if(_loc32_.costEnergy > _loc8_.energy)
                           {
                              _loc14_ = true;
                           }
                        }
                        if(param3 == BMMechStructure.HARPOON && screensM.screenBattle.doesOpponentHasNoneMovableTorso())
                        {
                           _loc13_ = true;
                        }
                        switch(param3)
                        {
                           case BMMechStructure.CHARGE:
                           case BMMechStructure.HARPOON:
                              if(screensM.screenBattle.isOpponentInWeaponRange(_loc5_,_loc9_,_loc32_.itemID,-1,-1,-1) == false)
                              {
                                 _loc13_ = true;
                              }
                        }
                        _loc28_ = Number(_loc8_.uses[param3]);
                        _loc27_ = Number(_loc8_.usesMax[param3]);
                        break;
                     case BMMechStructure.DRONE:
                        if(_loc8_.droneActive)
                        {
                           _loc24_ = true;
                        }
                        else
                        {
                           _loc23_ = true;
                        }
                        break;
                     case BMMechStructure.SHIELD:
                        if(_loc8_.shieldActive)
                        {
                           _loc24_ = true;
                        }
                        else
                        {
                           _loc23_ = true;
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
                     case BMMechStructure.KIT:
                        if(_loc32_.HPBase > 0)
                        {
                           if(_loc8_.HP == _loc8_.HPMax)
                           {
                              _loc20_ = true;
                           }
                        }
                        else if(_loc32_.energyBase > 0)
                        {
                           if(_loc8_.energy == _loc8_.energyMax)
                           {
                              _loc20_ = true;
                           }
                        }
                        else if(_loc32_.heatBase > 0)
                        {
                           if(_loc8_.heat == 0)
                           {
                              _loc20_ = true;
                           }
                        }
                        else if(_loc32_.bullets > 0)
                        {
                           if(_loc8_.bullets == _loc8_.bulletsMax)
                           {
                              _loc20_ = true;
                           }
                        }
                        else if(_loc32_.rockets > 0)
                        {
                           if(_loc8_.rockets == _loc8_.rocketsMax)
                           {
                              _loc20_ = true;
                           }
                        }
                  }
               }
               else
               {
                  _loc26_ = true;
               }
         }
         if(param4 == false)
         {
            param1.removeBlocks();
            if(_loc23_)
            {
               param1.showActivate();
            }
            else if(_loc24_)
            {
               param1.showDeactivate();
            }
            _loc46_ = new Array();
            if(_loc27_ > 0 && _loc28_ == _loc27_)
            {
               _loc19_ = true;
            }
            if(_loc19_)
            {
               _loc46_.push("usesDepleted");
            }
            else
            {
               if(_loc18_)
               {
                  _loc46_.push("alreadyFired");
               }
               if(_loc13_)
               {
                  _loc46_.push("outOfRange");
               }
               if(_loc22_)
               {
                  _loc46_.push("cannotRetreat");
               }
               if(_loc17_)
               {
                  _loc46_.push("notEnoughHP");
               }
               if(_loc14_)
               {
                  _loc46_.push("notEnoughEnergy");
               }
               if(_loc15_)
               {
                  _loc46_.push("notEnoughBullets");
               }
               if(_loc16_)
               {
                  _loc46_.push("notEnoughRockets");
               }
               if(_loc20_)
               {
                  _loc46_.push("blockGeneralBlock");
               }
               if(_loc21_)
               {
                  _loc46_.push("blockMechDestroyedBlock");
               }
            }
            _loc47_ = 0;
            while(_loc47_ < _loc46_.length)
            {
               switch(_loc46_[_loc47_])
               {
                  case "usesDepleted":
                     param1.showUsesDepletedBlock();
                     break;
                  case "outOfRange":
                     param1.showOutOfRangeBlock();
                     break;
                  case "cannotRetreat":
                     param1.showRetreatBlock();
                     break;
                  case "notEnoughHP":
                     param1.showHPBlock();
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
               _loc47_++;
            }
            if(_loc46_.length > 0)
            {
               param1.y += this.DISABLED_BUTTON_Y_ADDON;
               param1.activatePressedEffect();
            }
            if(_loc25_ == false && _loc26_ == false)
            {
               this.enableButton(param1);
            }
            else
            {
               this.disableButton(param1);
            }
         }
         param1.buttonCore.removeSelectedEffect();
         if(_loc27_ > 0)
         {
            param1.showUses(_loc28_,_loc27_);
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
         if(this._enabled)
         {
            return;
         }
         this._expendInterface = true;
         this._enabled = true;
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
            if((dataM.gameType == BMDataManager.GAME_TYPE_PVE || dataM.gameType == BMDataManager.GAME_TYPE_TUTORIAL_PVE) && BMGameShortcutsHelper.extraDamamgeShortcut())
            {
               if(_loc8_ == false && (_loc10_.type == BMMechStructure.SIDE_WEAPON || _loc10_.type == BMMechStructure.TOP_WEAPON))
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
               case BMMechStructure.TELEPORT:
               case BMMechStructure.CHARGE:
               case BMMechStructure.HARPOON:
                  this.refreshButton(_loc7_,_loc5_[_loc8_],_loc8_,true);
                  break;
               case BMMechStructure.SIDE_WEAPON:
               case BMMechStructure.TOP_WEAPON:
                  this.refreshButton(_loc7_,_loc5_[_loc8_ + _loc7_.equipmentID],_loc8_,true);
            }
            _loc6_++;
         }
      }
      
      public function disableInterface() : void
      {
         var _loc2_:BMButtonBattle = null;
         this._enabled = false;
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
      }
      
      public function isEnabled() : Boolean
      {
         return this._enabled;
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
            if(_loc5_.type == param1 && (_loc5_.equipmentID == param2 || param2 == 0 && isNaN(_loc5_.equipmentID)))
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
         var _loc30_:BMButtonBattle = null;
         var _loc31_:Sprite = null;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Boolean = false;
         var _loc39_:Number = NaN;
         var _loc40_:String = null;
         var _loc41_:String = null;
         var _loc42_:Boolean = false;
         var _loc43_:MovieClip = null;
         var _loc44_:Boolean = false;
         var _loc45_:Boolean = false;
         var _loc46_:Boolean = false;
         var _loc47_:BMPlayerItemData = null;
         var _loc48_:BMItemData = null;
         var _loc49_:Number = NaN;
         var _loc50_:BMMechView = null;
         var _loc51_:BMMechStructure = null;
         var _loc52_:MovieClip = null;
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
               if(_loc18_.stepsPerWalk == 0 && _loc18_.stepsPerJump == 0)
               {
                  _loc19_ = false;
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
               while(_loc10_ <= dataM.maxEquipment[BMMechStructure.SIDE_WEAPON])
               {
                  if(_loc6_[BMMechStructure.SIDE_WEAPON + _loc10_] > 0)
                  {
                     this.addActionToTotalActions(BMMechStructure.SIDE_WEAPON,_loc10_);
                  }
                  _loc10_++;
               }
               _loc10_ = 1;
               while(_loc10_ <= dataM.maxEquipment[BMMechStructure.TOP_WEAPON])
               {
                  if(_loc6_[BMMechStructure.TOP_WEAPON + _loc10_] > 0)
                  {
                     this.addActionToTotalActions(BMMechStructure.TOP_WEAPON,_loc10_);
                  }
                  _loc10_++;
               }
               if(_loc6_.drone > 0)
               {
                  this.addActionToTotalActions(BMMechStructure.DRONE);
               }
               if(_loc6_.shield > 0)
               {
                  this.addActionToTotalActions(BMMechStructure.SHIELD);
               }
               if(_loc6_.teleport > 0)
               {
                  this.addActionToTotalActions(BMMechStructure.TELEPORT);
               }
               if(_loc6_.charge > 0)
               {
                  this.addActionToTotalActions(BMMechStructure.CHARGE);
               }
               if(_loc6_.harpoon > 0)
               {
                  this.addActionToTotalActions(BMMechStructure.HARPOON);
               }
               _loc10_ = 1;
               while(_loc10_ <= dataM.maxEquipment[BMMechStructure.KIT])
               {
                  if(dataM.useMultipleMechsKitsFix)
                  {
                     if(this._kitsUsed[_loc3_.selectedMechID][_loc10_] == null)
                     {
                        if(_loc6_[BMMechStructure.KIT + _loc10_] > 0)
                        {
                           this.addActionToTotalActions(BMMechStructure.KIT,_loc10_);
                        }
                     }
                  }
                  else if(this._kitsUsed[_loc10_] == null)
                  {
                     if(_loc6_[BMMechStructure.KIT + _loc10_] > 0)
                     {
                        this.addActionToTotalActions(BMMechStructure.KIT,_loc10_);
                     }
                  }
                  _loc10_++;
               }
               this.addActionToTotalActions(BMMechStructure.LEG);
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
               if(dataM.isAutopilotAllowed())
               {
                  if(this._totalActions.length <= this.MAX_BUTTONS_IN_ROW_REGULAR_WITH_AUTO_PILOT)
                  {
                     this._expendInterface = true;
                  }
               }
               else if(this._totalActions.length <= this.MAX_BUTTONS_IN_ROW_REGULAR)
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
                              this.addButtonToShow(BMMechStructure.SIDE_WEAPON,1);
                              if(this._walkRightClicked == false)
                              {
                                 _loc13_ = this.btn1;
                              }
                              else
                              {
                                 _loc13_ = this.getButtonByName(BMMechStructure.SIDE_WEAPON,1);
                              }
                              _loc21_ = false;
                              break;
                           case 1:
                              this.addButtonToShow("walkLeft");
                              this.addButtonToShow("walkRight");
                              this.addButtonToShow(BMMechStructure.SIDE_WEAPON,1);
                              this.addButtonToShow(BMMechStructure.LEG);
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
                              if(screensM.screenBattle.isOpponentInWeaponRange(_loc2_,_loc7_,-1,_loc18_.rangeBase,_loc18_.rangeAddon,-1))
                              {
                                 _loc13_ = this.getButtonByName(BMMechStructure.LEG);
                              }
                              _loc22_ = false;
                        }
                     }
                     if(_loc18_.stepsPerWalk == 0 && _loc18_.stepsPerJump == 0)
                     {
                        _loc24_ = false;
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
                     while(_loc10_ <= dataM.maxEquipment[BMMechStructure.KIT])
                     {
                        if(dataM.useMultipleMechsKitsFix)
                        {
                           if(this._kitsUsed[_loc3_.selectedMechID][_loc10_] == null)
                           {
                              if(_loc6_[BMMechStructure.KIT + _loc10_] > 0)
                              {
                                 _loc12_ = true;
                                 _loc10_ = uint(dataM.maxEquipment[BMMechStructure.KIT]);
                              }
                           }
                        }
                        else if(this._kitsUsed[_loc10_] == null)
                        {
                           if(_loc6_[BMMechStructure.KIT + _loc10_] > 0)
                           {
                              _loc12_ = true;
                              _loc10_ = uint(dataM.maxEquipment[BMMechStructure.KIT]);
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
                        this.addButtonToShow(BMMechStructure.LEG);
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
                              _loc13_ = this.getButtonByName(BMMechStructure.SIDE_WEAPON,1);
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
                     while(_loc10_ <= dataM.maxEquipment[BMMechStructure.SIDE_WEAPON])
                     {
                        if(_loc6_[BMMechStructure.SIDE_WEAPON + _loc10_] > 0)
                        {
                           this.addButtonToShow(BMMechStructure.SIDE_WEAPON,_loc10_);
                        }
                        _loc10_++;
                     }
                     _loc10_ = 1;
                     while(_loc10_ <= dataM.maxEquipment[BMMechStructure.TOP_WEAPON])
                     {
                        if(_loc6_[BMMechStructure.TOP_WEAPON + _loc10_] > 0)
                        {
                           this.addButtonToShow(BMMechStructure.TOP_WEAPON,_loc10_);
                        }
                        _loc10_++;
                     }
                     break;
                  case "kits":
                     _loc12_ = false;
                     _loc10_ = 1;
                     while(_loc10_ <= dataM.maxEquipment[BMMechStructure.KIT])
                     {
                        if(dataM.useMultipleMechsKitsFix)
                        {
                           if(this._kitsUsed[_loc3_.selectedMechID][_loc10_] == null)
                           {
                              if(_loc6_[BMMechStructure.KIT + _loc10_] > 0)
                              {
                                 _loc12_ = true;
                                 _loc10_ = uint(dataM.maxEquipment[BMMechStructure.KIT]);
                              }
                           }
                        }
                        else if(this._kitsUsed[_loc10_] == null)
                        {
                           if(_loc6_[BMMechStructure.KIT + _loc10_] > 0)
                           {
                              _loc12_ = true;
                              _loc10_ = uint(dataM.maxEquipment[BMMechStructure.KIT]);
                           }
                        }
                        _loc10_++;
                     }
                     if(_loc12_)
                     {
                        this.addButtonToShow("back");
                        _loc10_ = 1;
                        while(_loc10_ <= dataM.maxEquipment[BMMechStructure.KIT])
                        {
                           if(dataM.useMultipleMechsKitsFix)
                           {
                              if(this._kitsUsed[_loc3_.selectedMechID][_loc10_] == null)
                              {
                                 if(_loc6_[BMMechStructure.KIT + _loc10_] > 0)
                                 {
                                    this.addButtonToShow(BMMechStructure.KIT,_loc10_);
                                 }
                              }
                           }
                           else if(this._kitsUsed[_loc10_] == null)
                           {
                              if(_loc6_[BMMechStructure.KIT + _loc10_] > 0)
                              {
                                 this.addButtonToShow(BMMechStructure.KIT,_loc10_);
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
                        this.addButtonToShow(BMMechStructure.DRONE);
                     }
                     if(_loc5_.mechStructure.shield > 0)
                     {
                        this.addButtonToShow(BMMechStructure.SHIELD);
                     }
                     if(_loc5_.mechStructure.teleport > 0)
                     {
                        this.addButtonToShow(BMMechStructure.TELEPORT);
                     }
                     if(_loc5_.mechStructure.charge > 0)
                     {
                        this.addButtonToShow(BMMechStructure.CHARGE);
                     }
                     if(_loc5_.mechStructure.harpoon > 0)
                     {
                        this.addButtonToShow(BMMechStructure.HARPOON);
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
                  _loc30_ = this.allButtons[_loc10_];
                  if(_loc30_.parent != null)
                  {
                     _loc30_.parent.removeChild(_loc30_);
                  }
                  _loc10_++;
               }
               _loc10_ = 1;
               while(_loc10_ <= 5)
               {
                  _loc31_ = this["blankButton" + _loc10_];
                  if(_loc31_.parent != null)
                  {
                     _loc31_.parent.removeChild(_loc31_);
                  }
                  _loc10_++;
               }
               _loc32_ = this.BUTTON_SIZE;
               _loc33_ = 3.5;
               _loc36_ = dataM.STAGE_HEIGHT - (_loc32_ + (_loc35_ = 6));
               _loc37_ = 1;
               _loc10_ = 0;
               while(_loc10_ < this._buttonsToShow.length)
               {
                  if(this._buttonsToShow[_loc10_] == null)
                  {
                     _loc31_ = this["blankButton" + _loc37_];
                     _loc31_.x = _loc35_;
                     _loc31_.y = _loc36_;
                     this.mcButtonsHolder.addChild(_loc31_);
                     _loc37_++;
                  }
                  else
                  {
                     _loc30_ = this["btn" + (_loc10_ + 1)];
                     _loc38_ = true;
                     if(this._forceButtonsUpdate == false)
                     {
                        switch(_loc30_.type)
                        {
                           case BMMechStructure.SIDE_WEAPON:
                           case BMMechStructure.TOP_WEAPON:
                           case BMMechStructure.KIT:
                           case "finish":
                           case "selectMech":
                              if(_loc30_.type == this._buttonsToShow[_loc10_].type && _loc30_.equipmentID == this._buttonsToShow[_loc10_].equipmentID)
                              {
                                 _loc38_ = false;
                              }
                              break;
                           default:
                              if(_loc30_.type == this._buttonsToShow[_loc10_].type)
                              {
                                 _loc38_ = false;
                              }
                        }
                     }
                     if(_loc38_)
                     {
                        _loc30_.type = this._buttonsToShow[_loc10_].type;
                        _loc30_.equipmentID = this._buttonsToShow[_loc10_].equipmentID;
                        _loc42_ = false;
                        _loc43_ = null;
                        _loc44_ = false;
                        _loc45_ = false;
                        switch(_loc30_.type)
                        {
                           case BMMechStructure.LEG:
                              _loc40_ = "action_stomp";
                              _loc41_ = "general";
                              break;
                           case BMMechStructure.SIDE_WEAPON:
                           case BMMechStructure.TOP_WEAPON:
                           case BMMechStructure.KIT:
                              _loc47_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc6_[_loc30_.type + _loc30_.equipmentID]);
                              _loc48_ = dataM.itemsDB[_loc47_.itemID];
                              _loc40_ = _loc48_.grp;
                              _loc41_ = dataM.itemTypeSourceDB[_loc48_.type];
                              if(dataM.runAsMobile)
                              {
                                 _loc42_ = true;
                              }
                              break;
                           case "switchMech":
                              _loc40_ = "action_switchMech";
                              _loc41_ = "general";
                              break;
                           case "selectMech":
                              if(this._mechPicturesData[_loc30_.equipmentID] == null)
                              {
                                 this._mechPicturesData[_loc30_.equipmentID] = new Object();
                                 _loc49_ = 0.4;
                                 _loc50_ = new BMMechView();
                                 _loc51_ = screensM.screenBattle.getMechStructure(dataM.player1PlayerID,_loc30_.equipmentID);
                                 _loc50_.initialize(dataM.player1PlayerID,"battle",BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,_loc49_,false);
                                 this._mechPicturesData[_loc30_.equipmentID].mechView = _loc50_;
                                 _loc50_.buildMech(_loc51_,this.selectMechButtonMechBuilt,[_loc30_]);
                                 _loc44_ = true;
                              }
                              else
                              {
                                 _loc45_ = true;
                              }
                              break;
                           case "finish":
                              _loc40_ = "action_finish" + _loc30_.equipmentID;
                              _loc41_ = "general";
                              break;
                           default:
                              _loc40_ = "action_" + _loc30_.type;
                              _loc41_ = "general";
                        }
                        _loc46_ = true;
                        switch(_loc30_.type)
                        {
                           case BMMechStructure.SIDE_WEAPON:
                           case BMMechStructure.TOP_WEAPON:
                           case BMMechStructure.KIT:
                              _loc46_ = false;
                        }
                        if(!_loc44_)
                        {
                           if(_loc45_)
                           {
                              this.insertMechImageIntoButton(_loc30_);
                           }
                           else if(_loc46_)
                           {
                              _loc52_ = externalAssetsM.getAsset(_loc41_,_loc40_,0,0,false,_loc42_);
                              _loc30_.setPicture(_loc52_);
                           }
                        }
                        _loc30_.removeBlocks();
                     }
                     _loc30_.x = _loc35_;
                     _loc30_.y = _loc36_;
                     this.mcButtonsHolder.addChild(_loc30_);
                     _loc39_ = _loc10_ + 1;
                     if(_loc39_ == 10)
                     {
                        _loc39_ = 0;
                     }
                     if(screensM.screenBattle.USE_NUMBER_KEYS_FOR_INTERFACE)
                     {
                        _loc30_.setButtonNumber(_loc39_);
                     }
                  }
                  _loc30_.width = _loc32_;
                  _loc30_.height = _loc32_;
                  _loc30_.deactivatePressedEffect();
                  _loc35_ += _loc32_ + _loc33_;
                  switch(_loc30_.type)
                  {
                     case BMMechStructure.SIDE_WEAPON:
                     case BMMechStructure.TOP_WEAPON:
                     case BMMechStructure.KIT:
                        _loc53_ = _loc30_.type + _loc30_.equipmentID;
                        this.refreshButton(_loc30_,_loc6_[_loc53_],_loc30_.type,false);
                        break;
                     case BMMechStructure.DRONE:
                     case BMMechStructure.SHIELD:
                     case BMMechStructure.TELEPORT:
                     case BMMechStructure.CHARGE:
                     case BMMechStructure.HARPOON:
                     case BMMechStructure.LEG:
                        this.refreshButton(_loc30_,_loc6_[_loc30_.type],_loc30_.type,false);
                        break;
                     case "walkLeft":
                     case "walkRight":
                     case "jumpLeft":
                     case "jumpRight":
                        this.refreshButton(_loc30_,0,_loc30_.type,false);
                        break;
                     case "selectMech":
                        _loc54_ = false;
                        if(_loc3_.selectedMechID == _loc30_.equipmentID)
                        {
                           _loc54_ = true;
                        }
                        else
                        {
                           _loc55_ = screensM.screenBattle.getMechSlot(dataM.player1PlayerID,_loc30_.equipmentID);
                           _loc56_ = screensM.screenBattle.mechBattleDatas[_loc55_];
                           if(_loc56_.HP <= 0)
                           {
                              _loc54_ = true;
                           }
                        }
                        this.refreshButton(_loc30_,_loc30_.equipmentID,_loc30_.type,false);
                        break;
                     case "finish":
                        this.refreshButton(_loc30_,_loc30_.equipmentID,_loc30_.type,false);
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
      }
      
      private function itemGrpLoaded(param1:MovieClip, param2:Array) : void
      {
         var _loc3_:BMButtonBattle = param2[0];
         _loc3_.updatePictureMc(param1);
      }
      
      private function selectMechButtonMechBuilt(param1:*) : void
      {
         var _loc2_:BMButtonBattle = param1[0];
         var _loc3_:BMMechView = this._mechPicturesData[_loc2_.equipmentID].mechView;
         _loc3_.itemsHolder.x -= _loc3_.mechSizer.x;
         _loc3_.itemsHolder.y -= _loc3_.mechSizer.y;
         _loc3_.mechSizer.parent.removeChild(_loc3_.mechSizer);
         var _loc4_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         var _loc5_:Bitmap = new Bitmap(_loc4_,"auto",true);
         _loc4_.draw(_loc3_);
         _loc3_.removeMe();
         this._mechPicturesData[_loc2_.equipmentID].mechView = null;
         this._mechPicturesData[_loc2_.equipmentID].mechBM = _loc5_;
         this._mechPicturesData[_loc2_.equipmentID].mechBMD = _loc4_;
         this.insertMechImageIntoButton(_loc2_);
      }
      
      private function insertMechImageIntoButton(param1:BMButtonBattle) : void
      {
         var _loc2_:MovieClip = new MovieClip();
         _loc2_.addChild(this._mechPicturesData[param1.equipmentID].mechBM);
         param1.setPicture(_loc2_,2);
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
            if(this._mechPicturesData[_loc1_] != null)
            {
               if(this._mechPicturesData[_loc1_].mechBMD != null)
               {
                  this._mechPicturesData[_loc1_].mechBMD.dispose();
                  this._mechPicturesData[_loc1_].mechBMD = null;
               }
               if(this._mechPicturesData[_loc1_].mechBM != null)
               {
                  if(this._mechPicturesData[_loc1_].mechBM.parent != null)
                  {
                     this._mechPicturesData[_loc1_].mechBM.parent.removeChild(this._mechPicturesData[_loc1_].mechBM);
                  }
                  this._mechPicturesData[_loc1_].mechBM = null;
               }
               this._mechPicturesData[_loc1_] = null;
            }
            _loc1_++;
         }
         this._mechPicturesData = new Array();
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
         screensM.screenBattle.activateManualZoomOut();
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
            case BMMechStructure.TELEPORT:
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
                        _loc11_ = BMMechStructure.LEG;
                        break;
                     case BMMechStructure.TELEPORT:
                        _loc11_ = BMMechStructure.TELEPORT;
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
                        case BMMechStructure.TELEPORT:
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
                     if(this._moveToStepType == BMMechStructure.TELEPORT)
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
         if(dataM.userAutopilot)
         {
            return;
         }
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
                     case BMMechStructure.TELEPORT:
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
            updateTextAndFormat(this.mcInfoText.txtInfo,param1);
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
      
      public function hideInterface(param1:Boolean = false, param2:Boolean = false) : void
      {
         this._displayStatus = "hide";
         this.deactivateInfoText();
         this._forceHideInterface = param2;
         if(param1)
         {
            y = this.INTERFACE_HEIGHT;
            this.updateMiniChatPosition();
            this.updateAutoplayAndSpeedPosition();
         }
      }
      
      private function showHideInterfaceHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:String = this._displayStatus;
         if(dataM.chatData.useCampaignChat)
         {
            if(dataM.userAutopilot)
            {
               _loc2_ = "hide";
            }
         }
         else if(this._forceHideInterface == false && (dataM.userAutopilot || screensM.screenBattle.opponentAvailable == false))
         {
            y = 0;
            this.updateAutoplayAndSpeedPosition();
            return;
         }
         switch(_loc2_)
         {
            case "show":
               _loc1_ = 0;
               break;
            case "hide":
               _loc1_ = this.INTERFACE_HEIGHT;
         }
         y = this.moveTowards(y,_loc1_);
         this.updateMiniChatPosition();
         this.updateAutoplayAndSpeedPosition();
      }
      
      private function moveTowards(param1:Number, param2:Number) : Number
      {
         if(param1 == param2)
         {
            return param1;
         }
         var _loc3_:Number = param1 + (param2 - param1) * this.INTERFACE_MOTION_RATIO;
         if(Math.abs(param2 - _loc3_) < 1)
         {
            return param2;
         }
         return _loc3_;
      }
      
      private function updateMiniChatPosition() : void
      {
         var _loc1_:Number = this.miniChatOrigY + this.INTERFACE_HEIGHT;
         if(dataM.userAutopilot)
         {
            _loc1_ += -2 * y;
         }
         this.miniChat.y = this.moveTowards(this.miniChat.y,_loc1_);
      }
      
      private function updateAutoplayAndSpeedPosition() : *
      {
         this.mcAutoplayAndGameSpeedPanel.y = this.autoplayAndSpeedOrigY - y;
      }
      
      public function buttonMouseClicked(param1:Number, param2:String, param3:Number) : void
      {
         var _loc7_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:BMMechBattleData = null;
         var _loc11_:BMMechStructure = null;
         var _loc12_:BMItemData = null;
         if(dataM.userAutopilot)
         {
            this.mcAutoplayAndGameSpeedPanel.activateUserAutopilotArrow();
            return;
         }
         dataM.trackEvent(BMDataManager.ANALYTICS_PRIORITY_LOWEST,"BattleAction",param2,param1.toString(),param3);
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
            case BMMechStructure.SIDE_WEAPON:
               screensM.screenBattle.fireWeapon(BMMechStructure.SIDE_WEAPON,param3);
               break;
            case BMMechStructure.TOP_WEAPON:
               screensM.screenBattle.fireWeapon(BMMechStructure.TOP_WEAPON,param3);
               break;
            case BMMechStructure.LEG:
               screensM.screenBattle.fireWeapon(BMMechStructure.LEG,0);
               break;
            case BMMechStructure.DRONE:
               screensM.screenBattle.activateDeactivateDrone();
               break;
            case BMMechStructure.SHIELD:
               screensM.screenBattle.activateDeactivateShield();
               break;
            case BMMechStructure.TELEPORT:
               this._interfaceType = "moveToStepSelection";
               _loc4_ = true;
               this.activatetMoveToStepSelection(BMMechStructure.TELEPORT);
               break;
            case BMMechStructure.CHARGE:
               screensM.screenBattle.chargeClicked();
               break;
            case BMMechStructure.HARPOON:
               screensM.screenBattle.harpoonClicked();
               break;
            case BMMechStructure.KIT:
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
         updateTextAndFormat(screensM.screenBattleInterfaceTop.mcActionErrorMessage.txtError,getScreenText("error_" + param1));
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
      
      private function initMiniChat() : void
      {
         this.miniChatOrigY = this.miniChat.y;
         if(dataM.chatData.useCampaignChat)
         {
            dataM.chatData.enterChat();
            this.miniChat.setOpenChatCallback(this.openCampaignChat);
         }
         else
         {
            this.miniChat.visible = false;
         }
      }
      
      private function openCampaignChat() : void
      {
         screensM.addScreen(BMScreensManager.SCR_CAMPAIGN_CHAT);
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
      
      private function initAutoplayAndGameSpeedPanel() : void
      {
         this.mcAutoplayAndGameSpeedPanel.initialize(null,this.autopilotOnClicked,null,null,null,true);
         this.autoplayAndSpeedOrigY = this.mcAutoplayAndGameSpeedPanel.y;
      }
      
      private function autopilotOnClicked() : void
      {
         screensM.screenBattle.autopilotSwitchedOn();
      }
   }
}

