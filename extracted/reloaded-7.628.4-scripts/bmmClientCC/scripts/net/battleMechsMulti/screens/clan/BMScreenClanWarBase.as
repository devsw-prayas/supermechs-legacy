package net.battleMechsMulti.screens.clan
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ClanWarAttackData;
   import net.battleMechsMulti.data.ClanWarPlayerData;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.clanWars.BMClanWarsManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMapMech;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenClanWarBase extends BMBaseScreen
   {
      
      public var mcClanOverview1:BMClanOverview;
      
      public var mcClanOverview2:BMClanOverview;
      
      public var btnClose:BMBasicButton;
      
      public var btnSwap:BMBasicButton;
      
      public var txtWarRound:TextField;
      
      public var txtAttacksLeft:TextField;
      
      public var txtScore1:TextField;
      
      public var txtScore2:TextField;
      
      public var mcScoreBar1:BMBar;
      
      public var mcScoreBar2:BMBar;
      
      public var mcFloorHolder:Sprite;
      
      public var mcMechsHolder:Sprite;
      
      public var mcBarsHolder:Sprite;
      
      public var mcArrowsHolder:Sprite;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcTopInterface:MovieClip;
      
      public var mcBackground:MovieClip;
      
      public var mcTimer:BMTimer;
      
      public var mcArrow1:Sprite;
      
      public var mcArrow2:Sprite;
      
      public var mcArrow3:Sprite;
      
      private var _arrowController1:BMTutorialArrowController;
      
      private var _arrowController2:BMTutorialArrowController;
      
      private var _arrowController3:BMTutorialArrowController;
      
      private var mcFloor:Sprite;
      
      private var _alignment:String;
      
      private var _mechPositionAddonInTeam:Array;
      
      private var _floorSquares:Array;
      
      private var _mechs:Array;
      
      private var _mechBars:Array;
      
      private var _clickLocations:Array;
      
      private var _alignmentsSwapped:Boolean = false;
      
      private const TUTORIAL_ARROWS:uint = 3;
      
      private const FLOOR_SQUARE_SIZE:uint = 74;
      
      private const FLOOR_SQUARE_DEFAULT:String = "default";
      
      private const FLOOR_SQUARE_SELF:String = "self";
      
      private const FLOOR_SQUARE_TARGET:String = "target";
      
      public function BMScreenClanWarBase()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clanWar");
         this.initMechPositionAddonInTeam();
      }
      
      public function setBaseAlignment(param1:String) : void
      {
         this._alignment = param1;
         if(this._alignment == BMClanWarsManager.ALIGNMENT_MY_CLAN)
         {
            this.mcBackground.gotoAndStop("myClan");
         }
         else
         {
            this.mcBackground.gotoAndStop("enemyClan");
         }
         if(this._alignmentsSwapped == false)
         {
            this.initButtons();
            this.initClanOverviews();
            this.initTimer();
            this.initBars();
            this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
         }
         else
         {
            this.deactivateTutorialArrows();
         }
         this._alignmentsSwapped = false;
         this.refreshAttacksLeft();
         this.createMechs();
      }
      
      public function initButtons() : void
      {
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClicked);
         this.btnSwap.addEventListener(BMIntractable.HIT,this.onSwapClicked);
      }
      
      private function onSwapClicked(param1:Event) : void
      {
         var _loc2_:String = BMClanWarsManager.ALIGNMENT_MY_CLAN;
         if(this._alignment == _loc2_)
         {
            _loc2_ = BMClanWarsManager.ALIGNMENT_ENEMY_CLAN;
         }
         this._alignmentsSwapped = true;
         screensM.screenTransitionsManager.clanWarBaseClicked(_loc2_);
      }
      
      private function onCloseClicked(param1:Event) : void
      {
         this.exitScreen();
      }
      
      private function exitScreen() : void
      {
         screensM.screenTransitionsManager.communityClanClicked(false,BMScreenClanMenu.TAB_WAR_BATTLE);
      }
      
      private function initializeGuideArrow(param1:uint) : void
      {
         if(this["_arrowController" + param1] == null)
         {
            this["_arrowController" + param1] = new BMTutorialArrowController(this["mcArrow" + param1]);
         }
      }
      
      private function activateGuideArrow(param1:uint, param2:Number, param3:Number, param4:Number) : void
      {
         this.initializeGuideArrow(param1);
         var _loc5_:uint = 0;
         var _loc6_:uint = 100;
         this["_arrowController" + param1].activateTutorialArrowWithTimer(this.mcArrowsHolder,param2,param3,param4,_loc5_,_loc6_);
      }
      
      private function deactivateTutorialArrows() : void
      {
         var _loc2_:BMTutorialArrowController = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= this.TUTORIAL_ARROWS)
         {
            if(this["_arrowController" + _loc1_] != null)
            {
               _loc2_ = this["_arrowController" + _loc1_];
               _loc2_.deactivateTutorialArrow();
            }
            _loc1_++;
         }
      }
      
      private function refreshAttacksLeft() : void
      {
         var _loc1_:String = null;
         if(this._alignment == BMClanWarsManager.ALIGNMENT_MY_CLAN || dataM.clanWarsM.didIJoin == false)
         {
            this.mcTopInterface.mcAttacksLeftFrame.visible = false;
            updateTextAndFormat(this.txtAttacksLeft,"");
         }
         else
         {
            this.mcTopInterface.mcAttacksLeftFrame.visible = true;
            _loc1_ = getScreenText("attacksLeft");
            _loc1_ = dataM.replaceStringInText(_loc1_,"%ATTACKS%",dataM.clanWarsM.myAttacksLeft.toString());
            updateTextAndFormat(this.txtAttacksLeft,_loc1_);
         }
      }
      
      private function onHitAreaClicked(param1:Event) : void
      {
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc2_:Number = param1.target.mouseX * this.mcMouseHitArea.scaleX + this.mcMouseHitArea.x;
         var _loc3_:Number = param1.target.mouseY * this.mcMouseHitArea.scaleY + this.mcMouseHitArea.y;
         var _loc4_:Number = -1;
         var _loc5_:Number = 9999;
         var _loc6_:uint = 0;
         while(_loc6_ < this._clickLocations.length)
         {
            _loc7_ = this._clickLocations[_loc6_];
            _loc8_ = dataM.getVectorSize(_loc2_ - _loc7_.x,_loc3_ - _loc7_.y);
            if(_loc8_ < _loc5_)
            {
               _loc5_ = _loc8_;
               _loc4_ = _loc6_;
            }
            _loc6_++;
         }
         if(_loc4_ == -1)
         {
            return;
         }
         if(_loc5_ > 40)
         {
            return;
         }
         if(this._alignment == BMClanWarsManager.ALIGNMENT_MY_CLAN)
         {
            this.inspectPlayer(dataM.clanWarsM.myClanPlayersData[_loc4_]);
         }
         else
         {
            this.inspectPlayer(dataM.clanWarsM.enemyClanPlayersData[_loc4_]);
         }
      }
      
      public function inspectPlayerByID(param1:uint) : void
      {
         this.inspectPlayer(dataM.clanWarsM.getPlayerData(param1,this._alignment));
      }
      
      private function inspectPlayer(param1:ClanWarPlayerData) : void
      {
         if(this._alignment == BMClanWarsManager.ALIGNMENT_MY_CLAN)
         {
            screensM.addScreen(BMScreensManager.SCR_CLAN_WAR_INSPECT_PLAYER,true,BMScreenClanWarInspectPlayerDefence);
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_CLAN_WAR_INSPECT_PLAYER,true,BMScreenClanWarInspectPlayerOffence);
         }
         screensM.screenClanWarInspectPlayer.showPlayerInfo(param1,this._alignment);
      }
      
      private function initTimer() : void
      {
         this.mcTimer.initialize(dataM.clanWarsM.getPhaseSecLeft,this.onTimeEnd);
      }
      
      private function onTimeEnd() : void
      {
         this.exitScreen();
      }
      
      private function createMechs() : void
      {
         var _loc1_:Vector.<ClanWarPlayerData> = null;
         var _loc15_:ClanWarPlayerData = null;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:ClanWarAttackData = null;
         var _loc22_:BMMechStructure = null;
         var _loc23_:String = null;
         var _loc24_:int = 0;
         var _loc25_:Boolean = false;
         var _loc26_:Point = null;
         var _loc27_:Boolean = false;
         var _loc28_:Number = NaN;
         this.removeAllFloorSquares();
         this.removeAllMechs();
         this.removeAllMechBars();
         this._mechs = new Array();
         this._mechBars = new Array();
         this._clickLocations = new Array();
         this._floorSquares = new Array();
         if(this._alignment == BMClanWarsManager.ALIGNMENT_MY_CLAN)
         {
            _loc1_ = dataM.clanWarsM.myClanPlayersData;
         }
         else
         {
            _loc1_ = dataM.clanWarsM.enemyClanPlayersData;
         }
         var _loc2_:uint = _loc1_.length;
         var _loc3_:Array = this.getPositioningData(_loc2_);
         var _loc4_:uint = uint(_loc3_[0]);
         var _loc5_:uint = uint(_loc3_[1]);
         var _loc6_:uint = uint(_loc3_[2]);
         var _loc7_:uint = uint(_loc3_[3]);
         var _loc8_:Array = _loc3_[4];
         var _loc9_:Array = _loc3_[5];
         var _loc10_:Array = _loc3_[6];
         var _loc11_:uint = 1;
         var _loc12_:uint = 0;
         var _loc13_:uint = 1;
         var _loc14_:Array = new Array();
         if(this._alignment == BMClanWarsManager.ALIGNMENT_ENEMY_CLAN && dataM.clanWarsM.didIJoin)
         {
            _loc14_ = dataM.clanWarsM.getAttackRecommendation();
         }
         for each(_loc15_ in _loc1_)
         {
            _loc12_ += 1;
            if(_loc12_ > _loc8_[_loc13_ - 1])
            {
               _loc13_ += 1;
               _loc12_ = 1;
            }
            _loc16_ = _loc9_[_loc13_ - 1] + _loc6_ * (_loc12_ - 1);
            _loc17_ = Number(_loc10_[_loc13_ - 1]);
            _loc18_ = _loc15_.mechStructures.length;
            _loc19_ = 1;
            _loc20_ = 0;
            _loc21_ = dataM.clanWarsM.getBestAttackInfoAgainstPlayer(_loc15_.playerID);
            if(_loc21_ != null)
            {
               _loc20_ = _loc21_.score;
            }
            for each(_loc22_ in _loc15_.mechStructures)
            {
               _loc26_ = this._mechPositionAddonInTeam[_loc18_][_loc19_];
               this.createMech(_loc22_,_loc16_ + _loc26_.x,_loc17_ + _loc26_.y);
               _loc27_ = _loc19_ == 1 && _loc20_ > 0;
               if(_loc27_)
               {
                  this.createBar(_loc16_,_loc17_ + 10,_loc20_,_loc15_.teamMaxScore);
               }
               _loc19_++;
            }
            _loc23_ = this.FLOOR_SQUARE_DEFAULT;
            if(_loc15_.playerID == dataM.userID)
            {
               _loc23_ = this.FLOOR_SQUARE_SELF;
            }
            this._clickLocations.push(new Point(this.mcMechsHolder.x + _loc16_,this.mcMechsHolder.y + _loc17_));
            _loc24_ = _loc14_.indexOf(_loc15_.playerID);
            _loc25_ = _loc24_ >= 0 && _loc24_ < this.TUTORIAL_ARROWS;
            if((_loc25_) && _loc11_ <= this.TUTORIAL_ARROWS)
            {
               _loc23_ = this.FLOOR_SQUARE_TARGET;
               _loc28_ = -90;
               if(_loc17_ < 0)
               {
                  _loc28_ = 90;
               }
               this.activateGuideArrow(_loc11_,_loc16_,_loc17_,_loc28_);
               _loc11_++;
            }
            this.addFloorSquare(_loc16_,_loc17_,_loc23_);
         }
      }
      
      private function initMechPositionAddonInTeam() : void
      {
         this._mechPositionAddonInTeam = new Array();
         this._mechPositionAddonInTeam[1] = new Array();
         this._mechPositionAddonInTeam[1].push(null);
         this._mechPositionAddonInTeam[1].push(new Point(0,0));
         this._mechPositionAddonInTeam[2] = new Array();
         this._mechPositionAddonInTeam[2].push(null);
         this._mechPositionAddonInTeam[2].push(new Point(-10,-5));
         this._mechPositionAddonInTeam[2].push(new Point(10,5));
         this._mechPositionAddonInTeam[3] = new Array();
         this._mechPositionAddonInTeam[3].push(null);
         this._mechPositionAddonInTeam[3].push(new Point(-13,-8));
         this._mechPositionAddonInTeam[3].push(new Point(13,-8));
         this._mechPositionAddonInTeam[3].push(new Point(0,8));
      }
      
      private function getPositioningData(param1:uint) : Array
      {
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:uint = 0;
         var _loc2_:uint = 1;
         var _loc3_:uint = 1;
         if(param1 <= 5)
         {
            _loc2_ = 1;
            _loc3_ = param1;
         }
         else if(param1 <= 10)
         {
            _loc2_ = 2;
            _loc3_ = Math.ceil(param1 / 2);
         }
         else
         {
            _loc2_ = 3;
            _loc3_ = Math.ceil(param1 / 3);
         }
         var _loc4_:uint = 85;
         var _loc5_:uint = 95;
         var _loc6_:Array = new Array();
         var _loc7_:uint = param1;
         while(_loc7_ > 0)
         {
            if(_loc7_ >= _loc3_)
            {
               _loc6_.push(_loc3_);
               _loc7_ -= _loc3_;
            }
            else
            {
               _loc6_.push(_loc7_);
               _loc7_ = 0;
            }
         }
         var _loc8_:Array = new Array();
         var _loc9_:Array = new Array();
         var _loc10_:uint = 0;
         while(_loc10_ < _loc6_.length)
         {
            _loc12_ = 0;
            _loc13_ = 0;
            _loc14_ = uint(_loc6_[_loc10_]);
            if(_loc14_ > 1)
            {
               _loc12_ = -(_loc14_ - 1) / 2 * _loc4_;
            }
            if(_loc6_.length > 1)
            {
               _loc13_ = (_loc10_ - (_loc6_.length - 1) / 2) * _loc5_;
            }
            _loc8_.push(_loc12_);
            _loc9_.push(_loc13_);
            _loc10_++;
         }
         var _loc11_:Array = new Array();
         _loc11_.push(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc8_,_loc9_);
         return _loc11_;
      }
      
      private function createMech(param1:BMMechStructure, param2:Number, param3:Number) : void
      {
         var _loc10_:BMItemData = null;
         if(param1.itemType != BMMechStructure.ITEM_TYPE_ITEM_ID)
         {
            throw Error("BMScreenClanWarBase >> createMech >> MechStructure must contain ItemIDs");
         }
         var _loc4_:String = "";
         var _loc5_:uint = 1;
         if(param1.perk > 0)
         {
            _loc10_ = dataM.itemsDB[param1.perk];
            if(_loc10_.isHatPerk)
            {
               _loc4_ = _loc10_.animation;
            }
         }
         var _loc6_:BMItemData = dataM.itemsDB[param1.torso];
         if(_loc6_.damageType == 2 || _loc6_.damageType == 3)
         {
            _loc5_ = uint(_loc6_.damageType);
         }
         var _loc7_:uint = param1.torso_colorID;
         if(_loc7_ == 0)
         {
            _loc7_ = dataM.getItemIDPowerColorID(param1.torso);
         }
         var _loc8_:uint = param1.leg_colorID;
         if(_loc8_ == 0)
         {
            _loc8_ = dataM.getItemIDPowerColorID(param1.leg);
         }
         var _loc9_:BMMapMech = new BMMapMech();
         _loc9_.initialize(BMMapMech.TYPE_MECH,_loc5_,_loc4_);
         _loc9_.scaleX = 0.55;
         _loc9_.scaleY = 0.55;
         if(dataM.generalSpeedRatio == BMDataManager.GENERAL_SPEED_RATIO_DOUBLE)
         {
            _loc9_.setFastAnimationSpeed();
         }
         _loc9_.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_DOWN);
         _loc9_.colorMech(_loc7_,_loc8_);
         _loc9_.x = param2;
         _loc9_.y = param3;
         this.mcMechsHolder.addChild(_loc9_);
         this._mechs.push(_loc9_);
      }
      
      private function removeAllMechs() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMMapMech = null;
         if(this._mechs != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._mechs.length)
            {
               _loc2_ = this._mechs[_loc1_];
               _loc2_.removeMe();
               this._mechs[_loc1_] = null;
               _loc1_++;
            }
         }
         this._mechs = new Array();
      }
      
      private function createBar(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:BMBarAndText = new BMBarAndText();
         _loc5_.x = param1;
         _loc5_.y = param2;
         _loc5_.initialize(param3,param4);
         this.mcBarsHolder.addChild(_loc5_);
         this._mechBars.push(_loc5_);
      }
      
      private function removeAllMechBars() : void
      {
         var _loc1_:uint = 0;
         if(this._mechBars != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._mechBars.length)
            {
               this._mechBars[_loc1_].parent.removeChild(this._mechBars[_loc1_]);
               this._mechBars[_loc1_] = null;
               _loc1_++;
            }
         }
         this._mechBars = new Array();
      }
      
      private function initBars() : void
      {
         this.mcScoreBar1.initialize(BMBar.COLOR_BLUE);
         this.mcScoreBar1.addSeparateorLines(4);
         this.mcScoreBar1.setFill(0);
         this.mcScoreBar1.setFill(dataM.clanWarsM.myClanScoreRatio,true);
         this.mcScoreBar2.initialize(BMBar.COLOR_BLUE,"left");
         this.mcScoreBar2.addSeparateorLines(4);
         this.mcScoreBar2.setFill(0);
         this.mcScoreBar2.setFill(dataM.clanWarsM.enemyClanScoreRatio,true);
         updateTextAndFormat(this.txtScore1,Math.ceil(dataM.clanWarsM.myClanScoreRatio * 100) + "%");
         updateTextAndFormat(this.txtScore2,Math.ceil(dataM.clanWarsM.enemyClanScoreRatio * 100) + "%");
      }
      
      private function addFloorSquare(param1:Number, param2:Number, param3:String = "default") : void
      {
         var _loc4_:MovieClip = externalAssetsM.getAsset("general","map_clanWarFloorSquare",this.FLOOR_SQUARE_SIZE,this.FLOOR_SQUARE_SIZE,false,false);
         _loc4_.x = param1;
         _loc4_.y = param2;
         _loc4_.gotoAndStop(param3);
         this.mcFloorHolder.addChild(_loc4_);
         this._floorSquares.push(_loc4_);
      }
      
      private function removeAllFloorSquares() : void
      {
         var _loc1_:uint = 0;
         if(this._floorSquares != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._floorSquares.length)
            {
               this._floorSquares[_loc1_].parent.removeChild(this._floorSquares[_loc1_]);
               this._floorSquares[_loc1_] = null;
               _loc1_++;
            }
         }
         this._floorSquares = new Array();
      }
      
      private function initClanOverviews() : void
      {
         var _loc1_:String = dataM.myProfile.clanData.name;
         var _loc2_:String = dataM.myProfile.leaderName;
         var _loc3_:uint = dataM.myProfile.clanData.ladderProgress;
         var _loc4_:String = dataM.myProfile.clanFlag;
         this.mcClanOverview1.initialize(_loc1_,_loc2_,_loc4_,_loc3_);
         _loc3_ = dataM.clanWarsM.enemyClanData.ladderProgress;
         _loc1_ = dataM.clanWarsM.enemyClanData.name;
         _loc2_ = dataM.clanWarsM.enemyClanData.leaderName;
         _loc4_ = dataM.clanWarsM.enemyClanData.flag;
         this.mcClanOverview2.initialize(_loc1_,_loc2_,_loc4_,_loc3_);
      }
      
      public function battleStarted() : *
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_INSPECT_PLAYER))
         {
            screensM.screenClanWarInspectPlayer.removeMe();
         }
         screensM.screenTransitionsManager.removeCurrentScreen();
         screensM.screenTransitionsManager.removeMe();
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_CLAN_WAR_INSPECT_PLAYER))
         {
            screensM.screenClanWarInspectPlayer.removeMe();
         }
         screensM.removeScreen(BMScreensManager.SCR_CLAN_WAR_BASE);
         this.removeAllFloorSquares();
         this.removeAllMechs();
         this.removeAllMechBars();
         this.deactivateTutorialArrows();
         this.mcMouseHitArea.removeEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
      }
   }
}

