package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMActionRange;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMMechDrone;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol849")]
   public class BMScreenHelp extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcMechsHolder:MovieClip;
      
      public var mcDroneHolder:MovieClip;
      
      public var mcEffectsHolder:MovieClip;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcFingerWheeling:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcSizer_btnReplay:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnWiki:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnReplay:BMButton_pictureE;
      
      public var btnWiki:BMButton;
      
      public var mcInterface1:MovieClip;
      
      public var mcInterface2:MovieClip;
      
      public var mcMask:Sprite;
      
      public var mcMechsBackground:Sprite;
      
      public var mcBackground:Sprite;
      
      public var mcBlackScreen:Sprite;
      
      public var txtTip:TextField;
      
      public var txtTitle:TextField;
      
      private var actionRange:BMActionRange;
      
      private var mechView1:BMMechView;
      
      private var mechView2:BMMechView;
      
      private var mechBattleData1:BMMechBattleData;
      
      private var mechBattleData2:BMMechBattleData;
      
      private var helpTileList:BMTileList;
      
      private var _lastEquipmentType:String;
      
      private var _lastEquipmentID:Number;
      
      private var _droneFire:Boolean = false;
      
      private var _droneActivatedCountdown:Number;
      
      private var _endMovie:Boolean = false;
      
      private var _endMovieCountdown:Number;
      
      private var _sceneStartDelay:Boolean = false;
      
      private var _sceneStartDelayCountdown:Number;
      
      private var _shield:Boolean = false;
      
      private var _shieldCoutdown:Number;
      
      private var _range:Boolean = false;
      
      private var _rangePhase:Number;
      
      private var _rangeCountdown:Number;
      
      private var _helpID:Number = -1;
      
      private var _costHeatHelpPhase:Number;
      
      private var _movieRunning:Boolean = false;
      
      private var _tipTextOriginYPos:Number;
      
      private var _movieOriginXPos:Number;
      
      private var _interface2OriginXPos:Number;
      
      private var _btnReplayOriginXPos:Number;
      
      private var _attackEndedRefreshBarsFunction:Function = null;
      
      private var _attackEndedRefreshBarsPlayerID:Number;
      
      private var _movingFramesCounter:Number;
      
      private var _movingFramesMax:Number;
      
      private var _movingXPerFrame:Number;
      
      private var _mechWalkingHandler:Boolean = false;
      
      private var _mechJumpingHandler:Boolean = false;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _firstRefresh:Boolean = true;
      
      private const HELP_ITEM_WIDTH:Number = 250;
      
      private const HELP_ITEM_WIDTH_MOBILE:Number = 278;
      
      private const HELP_ITEM_HEIGHT:uint = 30;
      
      private const HELP_ITEM_HEIGHT_LARGE:uint = 49;
      
      private const HELP_TILE_LIST_ROWS:Number = 13;
      
      private const HELP_TILE_LIST_ROWS_LARGE:Number = 8;
      
      private const FLOOR_STEP_SIZE:Number = 200;
      
      private const WALKING_LEG_X_DISTANCE:Number = 40;
      
      private const MECH_WALKING_FRAMES:Number = 18;
      
      private const JUMP_Y_CHANGE_PER_FRAME:Number = 2.4;
      
      public function BMScreenHelp()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("help");
      }
      
      private function addIcon(param1:MovieClip, param2:String, param3:String) : void
      {
         var _loc5_:MovieClip = null;
         var _loc4_:Sprite = param1["mcSizer_" + param2];
         _loc5_ = externalAssetsM.getAsset("general","icon_" + param3,_loc4_.width,_loc4_.height,false,false);
         _loc5_.x = _loc4_.x;
         _loc5_.y = _loc4_.y;
         param1["icon_" + param2] = _loc5_;
         param1.mcIconsHolder.addChild(_loc5_);
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:String = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenHelp","btnReplay","pictureE");
            screensM.createButtonFromSizer("screenHelp","btnWiki","regular");
            screensM.createButtonFromSizer("screenHelp","btnBack","pictureE");
            switch(dataM.languageID)
            {
               case 6:
               case 3:
                  this.btnWiki.changeFontSize(33);
                  break;
               default:
                  this.btnWiki.changeFontSize(33);
            }
            _loc1_ = this.replayClicked;
            _loc2_ = this.wikiClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
            }
            this.btnReplay.initialize("","",externalAssetsM.getAsset("general","interface_replay"),null,_loc1_,dataM.runAsMobile);
            this.btnWiki.initialize(getScreenText("wiki"),"blue",null,[],_loc2_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnReplay.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnWiki.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            _loc3_ = 0.5;
            this.mcMechsHolder.scaleX = _loc3_;
            this.mcMechsHolder.scaleY = _loc3_;
            this.mcDroneHolder.scaleX = _loc3_;
            this.mcDroneHolder.scaleY = _loc3_;
            this.mcEffectsHolder.scaleX = _loc3_;
            this.mcEffectsHolder.scaleY = _loc3_;
            this.actionRange = new BMActionRange();
            this.actionRange.x = this.FLOOR_STEP_SIZE * 0.5;
            this.mcEffectsHolder.addChild(this.actionRange);
            this.actionRange.initialize(4,this.FLOOR_STEP_SIZE);
            this._tipTextOriginYPos = this.txtTip.y;
            this._movieOriginXPos = this.mcMechsBackground.x;
            this._interface2OriginXPos = this.mcInterface2.x;
            this._btnReplayOriginXPos = this.btnReplay.x;
            _loc4_ = 1;
            while(_loc4_ <= 2)
            {
               _loc5_ = this["mcInterface" + _loc4_];
               this.addIcon(_loc5_,"energy","energy");
               this.addIcon(_loc5_,"heat","heat");
               this.addIcon(_loc5_,"bullets","bullets");
               this.addIcon(_loc5_,"rockets","rockets");
               this.addIcon(_loc5_,"resist1","resist_physical");
               this.addIcon(_loc5_,"resist2","resist_explosive");
               this.addIcon(_loc5_,"resist3","resist_electric");
               _loc6_ = "right";
               if(_loc4_ == 2)
               {
                  _loc6_ = "left";
               }
               _loc5_.barHP.initialize("red",_loc6_);
               _loc5_.barEnergy.initialize("green",_loc6_);
               _loc5_.barHeat.initialize("orange",_loc6_);
               _loc5_.barBullets.initialize("yellow",_loc6_);
               _loc5_.barRockets.initialize("yellow",_loc6_);
               _loc5_.barHP.addSeparateorLines(4);
               _loc5_.barEnergy.addSeparateorLines(3);
               _loc5_.barHeat.addSeparateorLines(3);
               _loc5_.barBullets.addSeparateorLines(3);
               _loc5_.barRockets.addSeparateorLines(3);
               _loc4_++;
            }
            if(dataM.runAsMobile)
            {
               this._fingerWheeling = new BMFingerWheeling();
               this._fingerWheeling.initialize("help",this.helpTileList,this.mcFingerWheeling,this.helpItemClicked,null,false);
               addChild(this._fingerWheeling);
            }
            else
            {
               this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
               this.mcFingerWheeling = null;
            }
            this.languageUpdate();
            this.txtTip.y = this._tipTextOriginYPos;
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this._helpID = -1;
         this.removeMechsAndInterface();
         this.btnReplay.disableMe();
         this.mcMask.x = this._movieOriginXPos;
         this.mcMechsBackground.x = this._movieOriginXPos;
         this.mcEffectsHolder.x = this._movieOriginXPos;
         this.mcMechsHolder.x = this._movieOriginXPos;
         this.mcInterface1.x = this._movieOriginXPos;
         this.mcInterface2.x = this._interface2OriginXPos;
         this.btnReplay.x = this._btnReplayOriginXPos;
         this.mcBlackScreen.visible = false;
         this.mcBackground.visible = true;
         this.btnWiki.visible = true;
         this.selectMovie(0);
         this.helpTileList.visible = true;
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtTip,18);
            TextUtils.updateTextFormat(this.btnWiki.txtButtonName);
            param1 = true;
         }
         if(param1)
         {
            switch(dataM.languageID)
            {
               case 6:
               case 3:
                  this.btnWiki.changeFontSize(33);
                  break;
               default:
                  this.btnWiki.changeFontSize(33);
            }
            this.btnWiki.setButtonName(getScreenText("wiki"));
         }
         this.txtTitle.text = getScreenText("title");
         this.txtTip.htmlText = TextUtils.getTextFont() + getScreenText("selectATopic");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("help_tip",[this.txtTip],"",this);
            screensM.createMultipleTextsBitmap("help_title",[this.txtTitle],"",this);
         }
         dataM.createHelpData();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(screensM.isScreenOpened("screenHelp"))
         {
            if(this.mechView1 != null)
            {
               this.mechBattleData1.onEnterFrameTrigger();
               this.mechBattleData2.onEnterFrameTrigger();
            }
            if(this._droneFire)
            {
               if(this._droneActivatedCountdown > 0)
               {
                  --this._droneActivatedCountdown;
                  if(this._droneActivatedCountdown == 0)
                  {
                     this.fireSuccess(1,"drone",0);
                     this._droneFire = false;
                  }
               }
            }
            if(this._shield)
            {
               if(this._shieldCoutdown > 0)
               {
                  --this._shieldCoutdown;
                  if(this._shieldCoutdown == 0)
                  {
                     this.fireSuccess(2,"sideWeapon",1);
                     this._shield = false;
                  }
               }
            }
            if(this._range)
            {
               if(this._rangeCountdown > 0)
               {
                  --this._rangeCountdown;
                  if(this._rangeCountdown == 0)
                  {
                     switch(this._rangePhase)
                     {
                        case 1:
                           this.actionRange.hideMe();
                           this.moveMechToStepSuccess("walk",2);
                           this._rangeCountdown = 60;
                           this._rangePhase = 2;
                           break;
                        case 2:
                           this.actionRange.displayRange(2,2,null,true,true,"red");
                           this._rangeCountdown = 60;
                           this._rangePhase = 3;
                           break;
                        case 3:
                           this.actionRange.hideMe();
                           this.fireSuccess(1,"sideWeapon",2);
                           this._range = false;
                     }
                  }
               }
            }
            this.mechWalkingHandler();
            this.mechJumpingHandler();
            if(this._sceneStartDelay)
            {
               if(this._sceneStartDelayCountdown > 0)
               {
                  --this._sceneStartDelayCountdown;
                  if(this._sceneStartDelayCountdown == 0)
                  {
                     this.sceneStartDelayEnded();
                     this._sceneStartDelay = false;
                  }
               }
            }
            if(this._endMovie)
            {
               if(this._endMovieCountdown > 0)
               {
                  --this._endMovieCountdown;
                  if(this._endMovieCountdown == 0)
                  {
                     this.helpTileList.enableAllItems();
                     this.btnReplay.enableMe();
                     this._movieRunning = false;
                     this._endMovie = false;
                  }
               }
            }
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.onEnterFrameTrigger();
            }
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      private function addAndRefreshHelpTileList(param1:Boolean) : void
      {
         var _loc10_:Object = null;
         var _loc11_:MovieClip = null;
         var _loc12_:uint = 0;
         var _loc13_:BMItem = null;
         var _loc14_:BMTileListItem = null;
         var _loc2_:Number = -1;
         if(this.helpTileList != null)
         {
            _loc2_ = this.helpTileList.getCurrentRow();
            this.helpTileList.removeMe();
         }
         var _loc3_:Array = new Array();
         var _loc4_:Number = this.HELP_ITEM_WIDTH;
         var _loc5_:Number = this.HELP_ITEM_HEIGHT;
         var _loc6_:uint = this.HELP_TILE_LIST_ROWS;
         if(dataM.runAsMobile)
         {
            _loc4_ = this.HELP_ITEM_WIDTH_MOBILE;
         }
         var _loc7_:uint = 0;
         while(_loc7_ < dataM.helpDB.length)
         {
            _loc10_ = dataM.helpDB[_loc7_];
            if(dataM.runAsMobile)
            {
               switch(dataM.languageID)
               {
                  case 3:
                  case 5:
                  case 9:
                     _loc5_ = this.HELP_ITEM_HEIGHT_LARGE;
                     _loc11_ = new mcHelpListRow_large_mobile();
                     _loc6_ = this.HELP_TILE_LIST_ROWS_LARGE;
                     break;
                  default:
                     _loc11_ = new mcHelpListRow_mobile();
               }
            }
            else
            {
               switch(dataM.languageID)
               {
                  case 3:
                  case 5:
                  case 9:
                     _loc5_ = this.HELP_ITEM_HEIGHT_LARGE;
                     _loc11_ = new mcHelpListRow_large();
                     _loc6_ = this.HELP_TILE_LIST_ROWS_LARGE;
                     break;
                  default:
                     _loc11_ = new mcHelpListRow();
               }
            }
            _loc12_ = 15;
            TextUtils.updateTextFormat(_loc11_.txtDescription,_loc12_);
            _loc11_.txtDescription.text = _loc10_.name;
            switch(dataM.languageID)
            {
               case 3:
               case 5:
               case 9:
                  if(_loc11_.txtDescription.numLines == 1)
                  {
                     _loc11_.txtDescription.height = 26;
                     _loc11_.txtDescription.y += 10;
                  }
            }
            if(_loc7_ == this._helpID)
            {
               _loc11_.mcBackground.gotoAndStop("selected");
            }
            else if(_loc7_ % 2 == 0)
            {
               _loc11_.mcBackground.gotoAndStop("regular2");
            }
            _loc13_ = new BMItem();
            _loc13_.initialize(_loc7_,_loc4_,_loc5_,_loc11_,0,0,false,null,dataM.runAsMobile);
            if(dataM.runAsMobile)
            {
               _loc13_.convertMeIntoBitmap();
            }
            _loc14_ = new BMTileListItem();
            _loc14_.initialize(_loc4_,_loc5_,_loc13_,"","","",0,this.helpItemClicked,null,null,null,null,dataM.runAsMobile);
            _loc3_.push(_loc14_);
            _loc7_++;
         }
         this.helpTileList = new BMTileList();
         var _loc8_:Boolean = false;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this.helpTileList);
            _loc8_ = true;
         }
         var _loc9_:MovieClip = new Grp_scrollerContent();
         this.helpTileList.initialize(screensM.stagePointer,_loc3_,_loc6_,1,_loc4_,_loc5_,null,true,_loc9_,null,null,false,0,0.65,true,_loc8_,dataM.runAsMobile);
         this.helpTileList.x = this.mcSizer_tileList.x;
         this.helpTileList.y = this.mcSizer_tileList.y;
         if(param1 == false && _loc2_ > -1)
         {
            this.helpTileList.jumpToRow(_loc2_,false,"screenHelp addAndRefreshHelpTileList");
         }
         this.mcButtonsHolder.addChild(this.helpTileList);
         if(this._movieRunning)
         {
         }
      }
      
      public function fireSuccess(param1:Number, param2:String, param3:Number) : void
      {
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:String = null;
         var _loc13_:Object = null;
         var _loc14_:MovieClip = null;
         var _loc16_:uint = 0;
         var _loc19_:MovieClip = null;
         var _loc20_:Point = null;
         var _loc21_:Point = null;
         var _loc22_:Point = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:String = null;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:MovieClip = null;
         var _loc36_:Point = null;
         var _loc37_:Point = null;
         var _loc38_:Point = null;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Boolean = false;
         var _loc44_:MovieClip = null;
         var _loc45_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc47_:Number = NaN;
         var _loc48_:Number = NaN;
         this._lastEquipmentType = param2;
         this._lastEquipmentID = param3;
         switch(param1)
         {
            case 1:
               _loc4_ = this.mechBattleData1;
               _loc5_ = this.mechBattleData2;
               _loc6_ = 1;
               _loc7_ = 2;
               break;
            case 2:
               _loc4_ = this.mechBattleData2;
               _loc5_ = this.mechBattleData1;
               _loc6_ = 2;
               _loc7_ = 1;
         }
         var _loc8_:Boolean = true;
         var _loc9_:Boolean = true;
         switch(param2)
         {
            case "drone":
               _loc10_ = "drone";
               break;
            default:
               _loc10_ = param2 + param3;
         }
         var _loc11_:Number = Number(_loc4_.mechStructure[_loc10_]);
         var _loc12_:BMItemData = dataM.itemsDB[_loc11_];
         _loc13_ = dataM.animationDB[_loc12_.animation];
         switch(param2)
         {
            case "drone":
               _loc14_ = _loc4_.drone.droneGrpSub;
               _loc4_.drone.haltVerticalMotion(30);
               break;
            default:
               _loc14_ = _loc4_.mechView[_loc10_].item.itemGrp;
         }
         var _loc15_:Array = new Array();
         _loc16_ = 1;
         while(_loc16_ <= 10)
         {
            if(_loc14_["mcFire" + _loc16_] != null)
            {
               _loc35_ = _loc14_["mcFire" + _loc16_];
               _loc36_ = new Point(_loc35_.x,_loc35_.y);
               _loc37_ = _loc14_.localToGlobal(_loc36_);
               _loc38_ = this.mcMechsHolder.globalToLocal(_loc37_);
               _loc15_.push(_loc38_);
            }
            _loc16_++;
         }
         var _loc17_:Boolean = false;
         if(_loc4_.mechView.scaleX == -1)
         {
            _loc17_ = true;
         }
         var _loc18_:Boolean = false;
         switch(_loc13_.effectType)
         {
            case "immediate1":
            case "immediate2":
            case "beam":
               break;
            case "projectile":
            case "chargeProjectile":
            case "rocket":
            case "rocketMassive":
            case "artillery":
            case "flame":
               _loc19_ = _loc5_.mechView.torso;
               _loc20_ = new Point(_loc19_.x,_loc19_.y);
               _loc21_ = _loc19_.localToGlobal(_loc20_);
               _loc22_ = this.mcMechsHolder.globalToLocal(_loc21_);
               _loc23_ = Math.abs(_loc15_[0].x - _loc22_.x);
               _loc24_ = Math.abs(_loc15_[0].y - _loc22_.y);
         }
         switch(_loc13_.effectType)
         {
            case "immediate1":
            case "immediate2":
               if(_loc13_.fireEffect != "")
               {
                  _loc31_ = 0;
                  while(_loc31_ < _loc15_.length)
                  {
                     _loc32_ = 0;
                     _loc33_ = 0;
                     _loc34_ = 0;
                     effectsM.createGeneralEffect(this.mcEffectsHolder,_loc13_.fireEffect,_loc17_,_loc32_,_loc33_,_loc15_[_loc31_].x,_loc15_[_loc31_].y,_loc34_,null,[]);
                     _loc31_++;
                  }
               }
               _loc8_ = true;
               _loc18_ = true;
               soundM.createSound(_loc13_.sound,1);
               break;
            case "beam":
               _loc31_ = _loc15_.length - 1;
               while(_loc31_ >= 0)
               {
                  _loc32_ = 0;
                  _loc33_ = 0;
                  _loc34_ = 0;
                  _loc43_ = false;
                  if(dataM.slowCPUMode)
                  {
                     _loc43_ = true;
                  }
                  if(_loc31_ == 0)
                  {
                     effectsM.createFireBeam(this.mcEffectsHolder,_loc13_.effectShape,_loc13_.effectColor,_loc13_.size,false,_loc43_,_loc17_,_loc15_[_loc31_].x,_loc15_[_loc31_].y,this.beamAttackEnded,this.createBeamAttackSound);
                  }
                  else
                  {
                     effectsM.createFireBeam(this.mcEffectsHolder,_loc13_.effectShape,_loc13_.effectColor,_loc13_.size,true,_loc43_,_loc17_,_loc15_[_loc31_].x,_loc15_[_loc31_].y,null,null);
                  }
                  _loc31_--;
               }
               break;
            case "projectile":
            case "chargeProjectile":
               _loc39_ = 0;
               switch(_loc13_.effectType)
               {
                  case "chargeProjectile":
                     _loc44_ = externalAssetsM.getAsset("general","Grp_energyCharge_" + _loc13_.effectColor,140,140,false,false);
                     _loc45_ = 10;
                     _loc46_ = 20;
                     _loc47_ = 70;
                     _loc48_ = 5;
                     effectsM.createEnergyChargeMC("screenBattle",this.mcEffectsHolder,_loc15_[0].x,_loc15_[0].y,_loc47_,_loc45_,_loc46_,_loc48_,_loc13_.effectColor,_loc44_,null);
                     _loc39_ = _loc46_ + Math.ceil(_loc47_ / _loc48_);
                     soundM.createSound("chargeEnergy",1);
                     break;
                  case "projectile":
               }
               _loc30_ = _loc13_.sound;
               _loc25_ = 80;
               _loc26_ = 0;
               _loc24_ -= 35;
               _loc27_ = 6;
               effectsM.createProjectileShots(this.mcEffectsHolder,_loc6_,_loc7_,_loc13_.projectile,_loc13_.fireEffect,_loc39_,_loc27_,_loc17_,_loc25_,_loc26_,_loc23_,_loc24_,_loc15_,_loc30_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc9_]);
               break;
            case "rocket":
            case "rocketMassive":
               _loc25_ = 1;
               _loc26_ = 2;
               _loc24_ -= 35;
               _loc27_ = 4;
               _loc28_ = 3;
               _loc29_ = 2;
               if(_loc13_.effectType == "rocketMassive")
               {
                  _loc28_ = 1;
                  _loc29_ = 1;
               }
               _loc40_ = 10;
               _loc30_ = _loc13_.sound;
               effectsM.createRocketBarrage(this.mcEffectsHolder,_loc6_,_loc7_,_loc13_.rocket,_loc13_.fireEffect,_loc28_,_loc29_,_loc27_,_loc40_,_loc17_,_loc25_,_loc26_,_loc23_,_loc24_,_loc15_[0].x,_loc15_[0].y + 10,_loc30_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc9_]);
               break;
            case "artillery":
               _loc41_ = 40;
               _loc27_ = 4;
               _loc28_ = 4;
               _loc29_ = 2;
               _loc42_ = 12;
               _loc30_ = _loc13_.sound;
               effectsM.createArtilleryBarrage(this.mcEffectsHolder,_loc6_,_loc7_,false,false,_loc13_.rocket,_loc13_.fireEffect,_loc28_,_loc29_,_loc27_,_loc42_,0,_loc41_,_loc15_[0].x,_loc15_[0].y,_loc22_.x,_loc22_.y,_loc30_,this.activateWeaponFeedbackAndSound,this.activateGetHit,this.attackEnded,[_loc9_]);
               break;
            case "flame":
               effectsM.activateFlameThrower(_loc7_,_loc15_[0].x,_loc15_[0].y,_loc4_.mechView.scaleX,_loc12_.rangeAddon * this.FLOOR_STEP_SIZE,_loc13_.fireEffect,this.activateGetHit,this.attackEnded,[_loc9_]);
               soundM.createSound("flameThrower",1);
         }
         if(_loc18_)
         {
            this.attackEnded(_loc8_);
         }
      }
      
      private function attackEnded(param1:Boolean) : void
      {
         var _loc3_:BMMechView = null;
         var _loc2_:Boolean = true;
         switch(dataM.helpDB[this._helpID].type)
         {
            case "costHeat":
               if(this._costHeatHelpPhase == 1)
               {
                  _loc2_ = false;
                  this.mechBattleData1.heat += 5;
                  this.mechBattleData1.energy -= 5;
                  this.refreshHPEnergyAndHeat(1,true);
                  this.fireSuccess(1,"sideWeapon",1);
                  ++this._costHeatHelpPhase;
               }
               else if(this._costHeatHelpPhase == 2)
               {
                  _loc2_ = false;
                  this.mechBattleData1.heat += 5;
                  this.mechBattleData1.rockets -= 5;
                  this.refreshHPEnergyAndHeat(1,true);
                  this.refreshInterface_rockets(1,true);
                  this.fireSuccess(1,"topWeapon",2);
                  ++this._costHeatHelpPhase;
               }
               break;
            case "shield":
               _loc3_ = this.mechView1;
               effectsM.createShield(this.mcEffectsHolder,_loc3_.x + 10,_loc3_.y + 200,"blue","front",false,dataM.slowCPUMode);
         }
         if(_loc2_)
         {
            this.attackEndedRefreshBarsCheck();
            this.startEndingMovie();
         }
      }
      
      private function beamAttackEnded() : void
      {
         this.attackEnded(false);
         this.activateGetHit(2,"xAxisFront",true,true);
      }
      
      private function createBeamAttackSound() : void
      {
         soundM.createSound("fireCharge1",1);
      }
      
      private function attackEndedRefreshBarsCheck() : void
      {
         if(this._attackEndedRefreshBarsFunction != null)
         {
            this._attackEndedRefreshBarsFunction(this._attackEndedRefreshBarsPlayerID,true);
         }
      }
      
      public function activateGetHit(param1:Number, param2:String, param3:Boolean, param4:Boolean) : void
      {
         var _loc11_:MovieClip = null;
         var _loc12_:Number = NaN;
         var _loc13_:Point = null;
         var _loc14_:Point = null;
         var _loc15_:Point = null;
         var _loc5_:BMMechBattleData = this["mechBattleData" + param1];
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         switch(param2)
         {
            case "xAxisFront":
               _loc6_ = true;
               break;
            case "yAxis":
               _loc8_ = true;
         }
         _loc5_.mechView.activateGetHitAnimation(_loc6_,_loc7_,_loc8_);
         var _loc9_:Number = Math.ceil(Math.random() * 2);
         var _loc10_:String = "explosionSmall";
         if(_loc9_ == 1)
         {
            _loc10_ = "explosionMedium";
         }
         if(param3)
         {
            _loc11_ = _loc5_.mechView.torso.item.itemGrp;
            _loc12_ = 50;
            if(_loc5_.mechView.scaleX == -1)
            {
               _loc12_ = -50;
            }
            _loc13_ = new Point(_loc11_.mcCenter.x,_loc11_.mcCenter.y);
            _loc14_ = _loc11_.localToGlobal(_loc13_);
            _loc15_ = this.mcMechsHolder.globalToLocal(_loc14_);
            effectsM.createExplosion(3,_loc15_.x + _loc12_,_loc15_.y,50,30,20,2,7,2,this.mcEffectsHolder);
         }
         soundM.createSound(_loc10_,1);
      }
      
      private function activateWeaponFeedbackAndSound(param1:Number, param2:String, param3:String) : void
      {
         var _loc4_:BMMechBattleData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         switch(this._lastEquipmentType)
         {
            case "sideWeapon":
            case "topWeapon":
               _loc4_ = this["mechBattleData" + param1];
               _loc5_ = 0;
               _loc6_ = 0;
               switch(param2)
               {
                  case "xAxis":
                     _loc5_ = 5;
                     break;
                  case "yAxis":
                     _loc6_ = 5;
               }
               _loc4_.mechView.addWeaponFeedback(this._lastEquipmentType,this._lastEquipmentID,_loc5_,_loc6_);
         }
         if(param3 != "")
         {
            soundM.createSound(param3,1);
         }
      }
      
      public function chargeSuccess() : void
      {
         var _loc1_:BMMechBattleData = this.mechBattleData1;
         var _loc2_:BMMechBattleData = this.mechBattleData2;
         var _loc3_:Number = _loc2_.mechView.x;
         _loc1_.charge(_loc3_,this.chargeChargingAnimationEnded);
         soundM.createSound("charge",1);
      }
      
      private function chargeChargingAnimationEnded() : void
      {
         var _loc1_:BMMechBattleData = this.mechBattleData1;
         var _loc2_:BMItemData = dataM.itemsDB[this.mechBattleData1.mechStructure.charge];
         var _loc3_:BMMechBattleData = this.mechBattleData2;
         var _loc4_:MovieClip = _loc1_.mechView.torso.item.itemGrp;
         var _loc5_:Point = new Point(_loc4_.mcCenter.x,_loc4_.mcCenter.y);
         var _loc6_:Point = _loc4_.localToGlobal(_loc5_);
         var _loc7_:Point = this.mcMechsHolder.globalToLocal(_loc6_);
         effectsM.createSparksMC("screenHelp","debrie",_loc1_.mechView.x,_loc7_.y,10,1,40,"horizontal","",true);
         effectsM.createExplosion(3,_loc1_.mechView.x,_loc7_.y,50,30,20,2,7,2,this.mcEffectsHolder);
         this.activateGetHit(2,"xAxisFront",false,true);
         var _loc8_:Number = 4;
         var _loc9_:Number = 4;
         this.pushMech(1,2,3,4);
         this.pushMech(2,1,4,3);
      }
      
      private function pushMech(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc7_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc5_:BMMechBattleData = this["mechBattleData" + param1];
         var _loc6_:BMMechBattleData = this["mechBattleData" + param2];
         var _loc8_:Number = param3;
         var _loc9_:Number = param4;
         if(_loc8_ < _loc9_)
         {
            _loc11_ = -1;
         }
         else
         {
            _loc11_ = 1;
         }
         var _loc12_:Number = 1;
         _loc10_ = _loc8_ + _loc11_ * _loc12_;
         var _loc13_:Number = _loc12_ * this.FLOOR_STEP_SIZE;
         _loc6_.pushMe(_loc13_,false,this.pushAnimEnded,false);
      }
      
      private function pushAnimEnded(param1:Boolean) : void
      {
         this.startEndingMovie();
      }
      
      public function teleportSuccess(param1:Number) : void
      {
         var _loc2_:BMMechBattleData = this.mechBattleData1;
         var _loc3_:BMMechView = _loc2_.mechView;
         var _loc4_:Number = _loc3_.mechSizer.width * 1.8;
         var _loc5_:Number = _loc3_.x;
         var _loc6_:Number = _loc3_.y + 30;
         effectsM.createTeleportDisappear("teleportDisappearAnim",_loc5_,_loc6_,_loc4_,this.teleportSuccessSub,[param1],this.mcEffectsHolder);
         soundM.createSound("teleportDisappear",1);
      }
      
      private function teleportSuccessSub(param1:Number) : void
      {
         var _loc2_:BMMechBattleData = this.mechBattleData1;
         var _loc3_:BMMechView = _loc2_.mechView;
         var _loc4_:Number = _loc3_.mechSizer.width * 1.8;
         _loc2_.currentStepVisual = param1;
         _loc2_.mechView.x = _loc2_.currentStepVisual * this.FLOOR_STEP_SIZE;
         var _loc5_:Number = _loc3_.x;
         var _loc6_:Number = _loc3_.y + 30;
         effectsM.createTeleportReappear("teleportReappearAnim",_loc5_,_loc6_,_loc4_,this.mcEffectsHolder);
         soundM.createSound("teleportAppear",1);
         this.startEndingMovie();
      }
      
      public function harpoonSuccess() : void
      {
         var _loc1_:BMMechBattleData = this.mechBattleData1;
         var _loc2_:BMMechBattleData = this.mechBattleData2;
         var _loc3_:Number = Math.abs(_loc1_.currentStepVisual - _loc2_.currentStepVisual);
         var _loc4_:Number = (_loc3_ - 0.7) * this.FLOOR_STEP_SIZE;
         var _loc5_:Number = (_loc3_ - 1.7) * this.FLOOR_STEP_SIZE;
         var _loc6_:String = "left";
         if(_loc1_.currentStepVisual > _loc2_.currentStepVisual)
         {
            _loc6_ = "right";
         }
         _loc1_.launchHarpoon("regular",_loc4_,_loc5_,_loc6_,_loc2_,this.harpoonReachedTarget,this.harpoonAnimationEnded);
      }
      
      private function harpoonReachedTarget() : void
      {
         var _loc1_:BMMechBattleData = this.mechBattleData2;
         this.activateGetHit(2,"xAxisFront",false,true);
      }
      
      private function harpoonAnimationEnded() : void
      {
         var _loc1_:BMMechBattleData = this.mechBattleData2;
         this.startEndingMovie();
      }
      
      public function activateDroneSuccess() : void
      {
         var _loc1_:BMMechBattleData = this.mechBattleData1;
         _loc1_.droneActive = true;
         soundM.createSound("droneOn",1);
         this._droneFire = true;
         this._droneActivatedCountdown = 45;
      }
      
      public function deactivateDroneSuccess() : void
      {
         var _loc1_:BMMechBattleData = this.mechBattleData1;
         _loc1_.droneActive = false;
         soundM.createSound("droneOff",1);
         this.startEndingMovie();
      }
      
      public function activateShieldSuccess() : void
      {
         var _loc1_:BMMechBattleData = this.mechBattleData1;
         _loc1_.activateShield();
         soundM.createSound("shieldOn",1);
         this._shield = true;
         this._shieldCoutdown = 20;
      }
      
      public function shutDownSuccess() : void
      {
         var _loc1_:BMMechBattleData = this.mechBattleData1;
         var _loc2_:Number = _loc1_.mechView.x;
         var _loc3_:Number = _loc1_.mechView.y + 35;
         effectsM.createShutDown("shutDownAnim",_loc2_,_loc3_,false,this.shutDownAnimationEnded,this.mcEffectsHolder);
         _loc1_.mechView.activateShutdown();
         soundM.createSound("shutDown",1);
      }
      
      private function shutDownAnimationEnded() : void
      {
         this.startEndingMovie();
      }
      
      public function moveMechToStepSuccess(param1:String, param2:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc3_:BMMechBattleData = this.mechBattleData1;
         var _loc4_:BMItemData = dataM.itemsDB[this.mechBattleData1.mechStructure.leg];
         var _loc5_:String = "left";
         if(_loc3_.currentStepVisual < param2)
         {
            _loc5_ = "right";
         }
         _loc6_ = Math.abs(_loc3_.currentStepVisual - param2);
         _loc3_.currentStepVisual = param2;
         this._movingFramesCounter = 0;
         switch(param1)
         {
            case "walk":
               _loc8_ = _loc6_ * 2;
               this._movingFramesMax = this.MECH_WALKING_FRAMES * _loc8_;
               _loc7_ = _loc6_ * this.FLOOR_STEP_SIZE / this._movingFramesMax;
               switch(_loc5_)
               {
                  case "left":
                     if(dataM.wheelsDB[_loc4_.itemID])
                     {
                        _loc7_ *= 2;
                        this._movingFramesMax = Math.ceil(this._movingFramesMax / 2);
                     }
                     else if(_loc3_.mechView.scaleX == 1)
                     {
                        _loc3_.mechView.walkBackwards(_loc8_,true,null);
                     }
                     else
                     {
                        _loc3_.mechView.walkForward(_loc8_,true,null);
                     }
                     this._movingXPerFrame = -_loc7_;
                     break;
                  case "right":
                     if(dataM.wheelsDB[_loc4_.itemID])
                     {
                        _loc7_ *= 2;
                        this._movingFramesMax = Math.ceil(this._movingFramesMax / 2);
                     }
                     else if(_loc3_.mechView.scaleX == 1)
                     {
                        _loc3_.mechView.walkForward(_loc8_,true,null);
                     }
                     else
                     {
                        _loc3_.mechView.walkBackwards(_loc8_,true,null);
                     }
                     this._movingXPerFrame = _loc7_;
               }
               this._mechWalkingHandler = true;
               break;
            case "jump":
               this._movingFramesMax = this.MECH_WALKING_FRAMES;
               _loc7_ = _loc6_ * this.FLOOR_STEP_SIZE / this._movingFramesMax;
               switch(_loc5_)
               {
                  case "left":
                     this._movingXPerFrame = -_loc7_;
                     break;
                  case "right":
                     this._movingXPerFrame = _loc7_;
               }
               _loc3_.mechView.activateCrouchBeforeJump(this.crouchBeforeJumpCompleted);
         }
      }
      
      private function mechWalkingHandler() : void
      {
         var _loc1_:BMMechBattleData = null;
         if(this._mechWalkingHandler)
         {
            ++this._movingFramesCounter;
            if(this._movingFramesCounter <= this._movingFramesMax)
            {
               _loc1_ = this.mechBattleData1;
               _loc1_.mechView.x += this._movingXPerFrame;
            }
            else
            {
               this._mechWalkingHandler = false;
               this.walkJumpAnimDone();
            }
         }
      }
      
      private function crouchBeforeJumpCompleted() : void
      {
         this._mechJumpingHandler = true;
      }
      
      private function mechJumpingHandler() : void
      {
         var _loc1_:BMMechBattleData = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._mechJumpingHandler)
         {
            ++this._movingFramesCounter;
            _loc1_ = this.mechBattleData1;
            if(this._movingFramesCounter <= this._movingFramesMax)
            {
               _loc1_.mechView.x += this._movingXPerFrame;
               if(this._movingFramesCounter <= this._movingFramesMax / 2)
               {
                  _loc1_.mechView.y -= (this._movingFramesMax / 2 - this._movingFramesCounter + 1) * this.JUMP_Y_CHANGE_PER_FRAME;
               }
               else
               {
                  _loc1_.mechView.y += (this._movingFramesMax / 2 - (this._movingFramesMax - this._movingFramesCounter)) * this.JUMP_Y_CHANGE_PER_FRAME;
               }
            }
            else
            {
               this._mechJumpingHandler = false;
               _loc1_.mechView.activateBumpAnimation(true);
               this.walkJumpAnimDone();
               _loc2_ = _loc1_.mechView.x;
               _loc3_ = _loc1_.mechView.y;
               soundM.createSound("footStep",1);
            }
         }
      }
      
      private function walkJumpAnimDone() : void
      {
      }
      
      private function helpItemClicked(param1:Number, param2:Number) : void
      {
         this.selectMovie(param2);
      }
      
      private function resetScreen() : void
      {
         this._droneFire = false;
         this._shield = false;
         this._range = false;
         this._sceneStartDelay = false;
         this._endMovie = false;
         this.actionRange.hideMe();
         effectsM.setAllEffectsForDeletionAndDeleteThem(true);
         this.removeMechsAndInterface();
      }
      
      public function selectMovie(param1:Number) : void
      {
         this.resetScreen();
         this._movieRunning = true;
         this.btnReplay.enableMe();
         this._helpID = param1;
         this.addAndRefreshHelpTileList(false);
         this.addMechs();
         var _loc2_:String = dataM.helpDB[this._helpID].type;
         var _loc3_:String = dataM.helpDB[this._helpID].tip;
         switch(_loc2_)
         {
            case "costEnergy":
            case "electricDamage":
            case "shield":
               _loc3_ = dataM.replaceStringInText(_loc3_,"%COLOR%","<FONT COLOR=\'#00CC00\'>");
               break;
            case "costBullets":
            case "costRockets":
               _loc3_ = dataM.replaceStringInText(_loc3_,"%COLOR%","<FONT COLOR=\'#FFCC00\'>");
               break;
            case "costHeat":
            case "shutdown":
            case "explosiveDamage":
               _loc3_ = dataM.replaceStringInText(_loc3_,"%COLOR%","<FONT COLOR=\'#FF6600\'>");
         }
         this.txtTip.htmlText = TextUtils.getTextFont() + _loc3_;
         this.txtTip.y = this._tipTextOriginYPos;
         if(this.txtTip.numLines > 2)
         {
            this.txtTip.y = this._tipTextOriginYPos - 24;
         }
         else if(this.txtTip.numLines > 1)
         {
            this.txtTip.y = this._tipTextOriginYPos - 12;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("help_tip",[this.txtTip],"",this);
         }
         this.mcInterface1.mcBlackCover.gotoAndStop("empty");
         this.mcInterface2.mcBlackCover.gotoAndStop("empty");
         switch(_loc2_)
         {
            case "costEnergy":
               this.mcInterface1.visible = true;
               this.mcInterface1.mcBlackCover.gotoAndStop("energy");
               break;
            case "costBullets":
               this.mechBattleData1.bullets = 10;
               this.mechBattleData1.bulletsMax = 10;
               this.mcInterface1.visible = true;
               this.mcInterface1.mcBlackCover.gotoAndStop("bullets");
               break;
            case "costRockets":
               this.mechBattleData1.rockets = 10;
               this.mechBattleData1.rocketsMax = 10;
               this.mcInterface1.visible = true;
               this.mcInterface1.mcBlackCover.gotoAndStop("rockets");
               break;
            case "costHeat":
               this.mechBattleData1.bullets = 10;
               this.mechBattleData1.bulletsMax = 10;
               this.mechBattleData1.rockets = 10;
               this.mechBattleData1.rocketsMax = 10;
               this.mcInterface1.visible = true;
               this.mcInterface1.mcBlackCover.gotoAndStop("heat");
               break;
            case "shutdown":
               this.mechBattleData1.heat = 20;
               this.mcInterface1.visible = true;
               this.mcInterface1.mcBlackCover.gotoAndStop("heat");
               break;
            case "range":
            case "drone":
            case "shield":
            case "teleport":
            case "charge":
            case "harpoon":
               break;
            case "physicalDamage":
               this.mcInterface2.visible = true;
               this.mcInterface2.mcBlackCover.gotoAndStop("HP");
               break;
            case "explosiveDamage":
               this.mcInterface2.visible = true;
               this.mcInterface2.mcBlackCover.gotoAndStop("heatHP");
               break;
            case "electricDamage":
               this.mcInterface2.visible = true;
               this.mcInterface2.mcBlackCover.gotoAndStop("energyHP");
               break;
            case "resistPhysical":
               this.mcInterface2.visible = true;
               this.mechBattleData2.resist1 = 10;
               this.mcInterface2.mcBlackCover.gotoAndStop("resist1");
               break;
            case "resistExplosive":
               this.mcInterface2.visible = true;
               this.mechBattleData2.resist2 = 10;
               this.mcInterface2.mcBlackCover.gotoAndStop("resist2");
               break;
            case "resistElectric":
               this.mcInterface2.visible = true;
               this.mechBattleData2.resist3 = 10;
               this.mcInterface2.mcBlackCover.gotoAndStop("resist3");
         }
         this.refreshInterface(1,false);
         this.refreshInterface(2,false);
         this._sceneStartDelay = true;
         this._sceneStartDelayCountdown = 20;
      }
      
      private function sceneStartDelayEnded() : void
      {
         this._attackEndedRefreshBarsFunction = null;
         switch(dataM.helpDB[this._helpID].type)
         {
            case "costEnergy":
               this.fireSuccess(1,"sideWeapon",1);
               this.mechBattleData1.heat += 5;
               this.mechBattleData1.energy -= 5;
               this.refreshHPEnergyAndHeat(1,true);
               this.mcInterface1.mcMarkerEnergy.gotoAndStop("animOn");
               break;
            case "costBullets":
               this.fireSuccess(1,"sideWeapon",2);
               this.mechBattleData1.heat += 5;
               this.mechBattleData1.bullets -= 5;
               this.refreshInterface_bullets(1,true);
               this.refreshHPEnergyAndHeat(1,true);
               this.mcInterface1.mcMarkerBullets.gotoAndStop("animOn");
               break;
            case "costRockets":
               this.fireSuccess(1,"topWeapon",2);
               this.mechBattleData1.heat += 5;
               this.mechBattleData1.rockets -= 5;
               this.refreshInterface_rockets(1,true);
               this.refreshHPEnergyAndHeat(1,true);
               this.mcInterface1.mcMarkerRockets.gotoAndStop("animOn");
               break;
            case "costHeat":
               this.fireSuccess(1,"sideWeapon",2);
               this.mechBattleData1.heat += 5;
               this.mechBattleData1.bullets -= 5;
               this.refreshHPEnergyAndHeat(1,true);
               this.refreshInterface_bullets(1,false);
               this.refreshInterface_rockets(1,false);
               this.mcInterface1.mcMarkerHeat.gotoAndStop("animOn");
               this._costHeatHelpPhase = 1;
               break;
            case "range":
               this.actionRange.displayRange(1,2,null,true,true,"red");
               this._range = true;
               this._rangeCountdown = 60;
               this._rangePhase = 1;
               break;
            case "shutdown":
               this.shutDownSuccess();
               this.mechBattleData1.heat -= 10;
               this.refreshHPEnergyAndHeat(1,true);
               this.mcInterface1.mcMarkerHeat.gotoAndStop("animOn");
               break;
            case "drone":
               this.activateDroneSuccess();
               break;
            case "shield":
               this.activateShieldSuccess();
               break;
            case "teleport":
               this.teleportSuccess(3);
               break;
            case "charge":
               this.chargeSuccess();
               break;
            case "harpoon":
               this.harpoonSuccess();
               break;
            case "physicalDamage":
               this.mechBattleData2.HP -= 15;
               this._attackEndedRefreshBarsFunction = this.refreshHPEnergyAndHeat;
               this._attackEndedRefreshBarsPlayerID = 2;
               this.fireSuccess(1,"sideWeapon",2);
               this.mcInterface2.mcMarkerHP.gotoAndStop("animOn");
               break;
            case "explosiveDamage":
               this.mechBattleData2.HP -= 15;
               this.mechBattleData2.heat += 5;
               this._attackEndedRefreshBarsFunction = this.refreshHPEnergyAndHeat;
               this._attackEndedRefreshBarsPlayerID = 2;
               this.fireSuccess(1,"topWeapon",2);
               this.mcInterface2.mcMarkerHP.gotoAndStop("animOn");
               this.mcInterface2.mcMarkerHeat.gotoAndStop("animOn");
               break;
            case "electricDamage":
               this.mechBattleData2.HP -= 15;
               this.mechBattleData2.energy -= 5;
               this._attackEndedRefreshBarsFunction = this.refreshHPEnergyAndHeat;
               this._attackEndedRefreshBarsPlayerID = 2;
               this.fireSuccess(1,"sideWeapon",1);
               this.mcInterface2.mcMarkerHP.gotoAndStop("animOn");
               this.mcInterface2.mcMarkerEnergy.gotoAndStop("animOn");
               break;
            case "resistPhysical":
               this.mechBattleData2.HP -= 5;
               this._attackEndedRefreshBarsFunction = this.refreshHPEnergyAndHeat;
               this._attackEndedRefreshBarsPlayerID = 2;
               this.fireSuccess(1,"sideWeapon",2);
               this.mcInterface2.mcMarkerHP.gotoAndStop("animOn");
               this.mcInterface2.mcMarkerResist1.gotoAndStop("animOn");
               break;
            case "resistExplosive":
               this.mechBattleData2.HP -= 5;
               this.mechBattleData2.heat += 5;
               this._attackEndedRefreshBarsFunction = this.refreshHPEnergyAndHeat;
               this._attackEndedRefreshBarsPlayerID = 2;
               this.fireSuccess(1,"topWeapon",2);
               this.mcInterface2.mcMarkerHP.gotoAndStop("animOn");
               this.mcInterface2.mcMarkerResist2.gotoAndStop("animOn");
               break;
            case "resistElectric":
               this.mechBattleData2.HP -= 5;
               this.mechBattleData2.energy -= 5;
               this._attackEndedRefreshBarsFunction = this.refreshHPEnergyAndHeat;
               this._attackEndedRefreshBarsPlayerID = 2;
               this.fireSuccess(1,"sideWeapon",1);
               this.mcInterface2.mcMarkerHP.gotoAndStop("animOn");
               this.mcInterface2.mcMarkerResist3.gotoAndStop("animOn");
         }
      }
      
      private function startEndingMovie() : void
      {
         this._endMovie = true;
         this._endMovieCountdown = 60;
      }
      
      private function removeMechsAndInterface() : void
      {
         this.mcInterface1.visible = false;
         this.mcInterface2.visible = false;
         this.removeInterfaceMarkers();
         this.removeMechs();
      }
      
      private function removeInterfaceMarkers() : void
      {
         this.mcInterface1.mcMarkerHP.gotoAndStop("animOff");
         this.mcInterface1.mcMarkerEnergy.gotoAndStop("animOff");
         this.mcInterface1.mcMarkerHeat.gotoAndStop("animOff");
         this.mcInterface1.mcMarkerBullets.gotoAndStop("animOff");
         this.mcInterface1.mcMarkerRockets.gotoAndStop("animOff");
         this.mcInterface2.mcMarkerHP.gotoAndStop("animOff");
         this.mcInterface2.mcMarkerEnergy.gotoAndStop("animOff");
         this.mcInterface2.mcMarkerHeat.gotoAndStop("animOff");
         this.mcInterface2.mcMarkerResist1.gotoAndStop("animOff");
         this.mcInterface2.mcMarkerResist2.gotoAndStop("animOff");
         this.mcInterface2.mcMarkerResist3.gotoAndStop("animOff");
      }
      
      private function removeMechs() : void
      {
         if(this.mechView1 != null)
         {
            this.mechBattleData1.removeMe();
            this.mechBattleData2.removeMe();
            this.mechView1 = null;
            this.mechView2 = null;
            this.mechBattleData1 = null;
            this.mechBattleData2 = null;
         }
      }
      
      private function addMechs() : void
      {
         this.removeMechs();
         this.mechView1 = new BMMechView();
         this.mechBattleData1 = new BMMechBattleData();
         this.mechBattleData1.initialize();
         this.mechBattleData1.currentStepVisual = 1;
         this.mechBattleData1.mechView = this.mechView1;
         this.mechBattleData1.HP = 50;
         this.mechBattleData1.HPMax = 50;
         this.mechBattleData1.energy = 20;
         this.mechBattleData1.energyMax = 20;
         this.mechBattleData1.heat = 0;
         this.mechBattleData1.heatMax = 20;
         this.mechBattleData1.shieldType = "energy";
         var _loc1_:BMMechStructure = new BMMechStructure();
         _loc1_.torso = 417;
         _loc1_.leg = 35;
         _loc1_.sideWeapon1 = 382;
         _loc1_.sideWeapon2 = 210;
         _loc1_.topWeapon2 = 399;
         _loc1_.drone = 44;
         _loc1_.shield = 99;
         _loc1_.teleport = 22;
         _loc1_.charge = 100;
         _loc1_.harpoon = 410;
         this.mechBattleData1.mechStructure = _loc1_;
         this.mechView1.initialize(101,"battle","itemID",1,false);
         var _loc2_:Object = new Object();
         _loc2_.torso = 3;
         _loc2_.leg = 3;
         _loc2_.sideWeapon = 3;
         _loc2_.topWeapon = 3;
         this.mechView1.setManualColors(_loc2_);
         this.mechView1.buildMech(_loc1_,"screenHelp addMechs");
         this.mechView1.createChargeEngine();
         var _loc3_:BMMechDrone = new BMMechDrone();
         this.mcMechsHolder.addChild(_loc3_);
         _loc3_.specialParent = this.mcDroneHolder;
         this.mechBattleData1.drone = _loc3_;
         this.mechView1.x = 150;
         this.mechView1.y = -(this.mechView1.mechSizer.height + this.mechView1.mechSizer.y);
         this.mechView1.setWalkingParameters(this.WALKING_LEG_X_DISTANCE,this.MECH_WALKING_FRAMES,null);
         this.mechView1.setGetHitParameters(5,5);
         this.mechView1.setBumpParameters(6,10);
         this.mechView2 = new BMMechView();
         this.mechBattleData2 = new BMMechBattleData();
         this.mechBattleData2.initialize();
         this.mechBattleData2.currentStepVisual = 4;
         this.mechBattleData2.mechView = this.mechView2;
         this.mechBattleData2.HP = 50;
         this.mechBattleData2.HPMax = 50;
         this.mechBattleData2.energy = 20;
         this.mechBattleData2.energyMax = 20;
         this.mechBattleData2.heat = 0;
         this.mechBattleData2.heatMax = 20;
         this.mechBattleData2.shieldType = "energy";
         _loc1_ = new BMMechStructure();
         _loc1_.torso = 156;
         _loc1_.leg = 192;
         _loc1_.sideWeapon1 = 229;
         _loc1_.sideWeapon2 = 224;
         this.mechBattleData2.mechStructure = _loc1_;
         this.mechView2.initialize(102,"battle","itemID",1,false);
         _loc2_.torso = 1;
         _loc2_.leg = 1;
         _loc2_.sideWeapon = 1;
         _loc2_.topWeapon = 1;
         this.mechView2.setManualColors(_loc2_);
         this.mechView2.buildMech(_loc1_,"screenHelp addMechs");
         this.mechView2.x = this.mechView1.x + (this.mechBattleData2.currentStepVisual - this.mechBattleData1.currentStepVisual) * this.FLOOR_STEP_SIZE;
         this.mechView2.y = -(this.mechView2.mechSizer.height + this.mechView2.mechSizer.y);
         this.mechView2.scaleX = -1;
         this.mcMechsHolder.addChild(this.mechView2);
         this.mcMechsHolder.addChild(this.mechView1);
         this.mechBattleData1.createDrone("itemID");
         this.mechView2.setWalkingParameters(this.WALKING_LEG_X_DISTANCE,this.MECH_WALKING_FRAMES,null);
         this.mechView2.setGetHitParameters(5,5);
         this.mechView2.setBumpParameters(6,10);
      }
      
      private function refreshInterface(param1:Number, param2:Boolean) : void
      {
         this.refreshHPEnergyAndHeat(param1,param2);
         this.refreshInterface_bullets(param1,param2);
         this.refreshInterface_rockets(param1,param2);
         var _loc3_:uint = 1;
         while(_loc3_ <= 3)
         {
            this.refreshInterface_resistance(param1,_loc3_);
            _loc3_++;
         }
      }
      
      private function refreshHPEnergyAndHeat(param1:Number, param2:Boolean) : void
      {
         var _loc3_:MovieClip = this["mcInterface" + param1];
         var _loc4_:BMMechBattleData = this["mechBattleData" + param1];
         _loc3_.txtHP.text = _loc4_.HP + " / " + _loc4_.HPMax;
         _loc3_.txtEnergy.text = _loc4_.energy + " / " + _loc4_.energyMax;
         _loc3_.txtHeat.text = _loc4_.heat + " / " + _loc4_.heatMax;
         _loc3_.barHP.setFill(_loc4_.HP / _loc4_.HPMax,param2);
         _loc3_.barEnergy.setFill(_loc4_.energy / _loc4_.energyMax,param2);
         _loc3_.barHeat.setFill(_loc4_.heat / _loc4_.heatMax,param2);
         this.createStatsTextBitmaps(param1);
      }
      
      private function refreshInterface_bullets(param1:Number, param2:Boolean) : void
      {
         var _loc3_:MovieClip = this["mcInterface" + param1];
         var _loc4_:BMMechBattleData = this["mechBattleData" + param1];
         if(_loc4_.bulletsMax > 0)
         {
            _loc3_.barBullets.visible = true;
            _loc3_.barBullets.setFill(_loc4_.bullets / _loc4_.bulletsMax,param2);
            _loc3_.txtBullets.text = _loc4_.bullets + " / " + _loc4_.bulletsMax;
            _loc3_.icon_bullets.visible = true;
         }
         else
         {
            _loc3_.barBullets.visible = false;
            _loc3_.txtBullets.text = "";
            _loc3_.icon_bullets.visible = false;
         }
         this.createStatsTextBitmaps(param1);
      }
      
      private function refreshInterface_rockets(param1:Number, param2:Boolean) : void
      {
         var _loc3_:MovieClip = this["mcInterface" + param1];
         var _loc4_:BMMechBattleData = this["mechBattleData" + param1];
         if(_loc4_.rocketsMax > 0)
         {
            _loc3_.barRockets.visible = true;
            _loc3_.barRockets.setFill(_loc4_.rockets / _loc4_.rocketsMax,param2);
            _loc3_.txtRockets.text = _loc4_.rockets + " / " + _loc4_.rocketsMax;
            _loc3_.icon_rockets.visible = true;
         }
         else
         {
            _loc3_.barRockets.visible = false;
            _loc3_.txtRockets.text = "";
            _loc3_.icon_rockets.visible = false;
         }
         this.createStatsTextBitmaps(param1);
      }
      
      private function refreshInterface_resistance(param1:Number, param2:Number) : void
      {
         var _loc3_:MovieClip = this["mcInterface" + param1];
         var _loc4_:BMMechBattleData = this["mechBattleData" + param1];
         if(_loc4_["resist" + param2] > 0)
         {
            _loc3_["txtResist" + param2].text = _loc4_["resist" + param2];
            _loc3_["icon_resist" + param2].visible = true;
         }
         else
         {
            _loc3_["txtResist" + param2].text = "";
            _loc3_["icon_resist" + param2].visible = false;
         }
         this.createStatsTextBitmaps(param1);
      }
      
      private function createStatsTextBitmaps(param1:Number) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Array = null;
         if(dataM.runAsMobile)
         {
            _loc2_ = this["mcInterface" + param1];
            _loc3_ = [_loc2_.txtHP,_loc2_.txtEnergy,_loc2_.txtHeat];
            if(param1 == 1)
            {
               _loc3_.push(_loc2_.txtBullets,_loc2_.txtRockets);
            }
            else
            {
               _loc3_.push(_loc2_.txtResist1,_loc2_.txtResist2,_loc2_.txtResist3);
            }
            screensM.createMultipleTextsBitmap("help_interface" + param1,_loc3_,"",this["mcInterface" + param1]);
         }
      }
      
      public function wikiClicked() : void
      {
         dataM.openURL("http://wiki.supermechs.com/index.php?title=Main_Page","_blank");
      }
      
      public function replayClicked() : void
      {
         this.helpItemClicked(0,this._helpID);
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.mainMenu();
      }
      
      public function removeMe() : void
      {
         this.resetScreen();
         this.helpTileList.removeMe();
         this.helpTileList = null;
         screensM.removeScreen("screenHelp");
      }
   }
}

