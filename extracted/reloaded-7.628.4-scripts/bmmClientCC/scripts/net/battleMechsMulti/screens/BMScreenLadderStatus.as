package net.battleMechsMulti.screens
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3574")]
   public class BMScreenLadderStatus extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcRankStarsHolder_back:Sprite;
      
      public var mcRankStarsHolder_front:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcStarsBackground:MovieClip;
      
      public var mcBackground1:MovieClip;
      
      public var mcBackground2:MovieClip;
      
      public var mcSizer_btnPlus:Sprite;
      
      public var mcSizer_btnMinus:Sprite;
      
      public var mcSizer_btnClose:Sprite;
      
      public var mcSizer_rank:Sprite;
      
      public var btnPlus:BMButton_pictureE;
      
      public var btnMinus:BMButton_pictureE;
      
      public var btnClose:BMButton;
      
      public var txtRank:TextField;
      
      public var txtRankingListPosition:TextField;
      
      public var mcGlow1:Sprite;
      
      public var mcGlow2:Sprite;
      
      public var mcOliveLeaves:Sprite;
      
      public var mcRankingListPositionChangeArrow:MovieClip;
      
      private var _arrowOriginYPos:Number;
      
      private var _rankStars:Array;
      
      private var _tasks:Array;
      
      private var _taskSlot:uint;
      
      private var _animationInProgress:Boolean;
      
      private var _waitFrameCounter:uint;
      
      private var _rankStarsHoldersOriginYPos:Number;
      
      private var _glowActive:Boolean;
      
      private var _glow1Status:String;
      
      private var _rankingListPosition:uint;
      
      private var _firstRefresh:Boolean = true;
      
      private var mcRankHolder:MovieClip;
      
      private const MAX_STARS_IN_ROW:uint = 9;
      
      private const ROW_Y_JUMP:uint = 65;
      
      private const COLUMN_X_JUMP:uint = 67;
      
      private const ARROW_MOTION_DURATION:Number = 0.5;
      
      private const ARROW_Y_CHANGE:uint = 20;
      
      public function BMScreenLadderStatus()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("ladderStatus");
      }
      
      public function refreshScreen() : void
      {
         var _loc9_:Function = null;
         var _loc10_:Boolean = false;
         var _loc11_:Function = null;
         var _loc12_:Function = null;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:Boolean = false;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_LADDER_STATUS,"btnClose","regular");
            _loc9_ = this.closeClicked;
            if(dataM.runAsMobile)
            {
               _loc9_ = null;
            }
            this.btnClose.initialize(getGeneralText("OK"),"blue",null,null,_loc9_,dataM.runAsMobile);
            _loc10_ = false;
            if(dataM.clientRunningLocally)
            {
            }
            if(_loc10_)
            {
               screensM.createButtonFromSizer(BMScreensManager.SCR_LADDER_STATUS,"btnPlus","pictureE");
               screensM.createButtonFromSizer(BMScreensManager.SCR_LADDER_STATUS,"btnMinus","pictureE");
               _loc11_ = this.plusClicked;
               _loc12_ = this.minusClicked;
               if(dataM.runAsMobile)
               {
                  _loc11_ = null;
                  _loc12_ = null;
               }
               this.btnPlus.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc11_,dataM.runAsMobile);
               this.btnMinus.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc12_,dataM.runAsMobile);
            }
            this.btnClose.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._rankStarsHoldersOriginYPos = this.mcRankStarsHolder_back.y;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this.removeAllStars();
         this._tasks = new Array();
         this._taskSlot = 0;
         this._waitFrameCounter = 0;
         this._animationInProgress = false;
         this.btnClose.disableMe();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = dataM.getLadderRankByProgress(_loc1_.ladderProgress);
         this._glowActive = false;
         if(_loc1_.lastLadderProgress < _loc1_.ladderProgress)
         {
            this._glowActive = true;
            this.mcGlow1.visible = true;
            this.mcGlow2.visible = true;
            this.mcOliveLeaves.visible = true;
            this._glow1Status = "grow";
         }
         else
         {
            this.mcGlow1.visible = false;
            this.mcGlow2.visible = false;
            this.mcOliveLeaves.visible = false;
         }
         var _loc3_:uint = dataM.getLadderRankByProgress(_loc1_.lastLadderProgress);
         var _loc4_:uint = dataM.getLadderProgressMaxByRank(_loc3_);
         var _loc5_:uint = 2;
         if(_loc1_.lastLadderProgress != _loc1_.ladderProgress)
         {
            this._tasks.push({"action":"wait"});
            _loc13_ = Math.abs(_loc1_.ladderProgress - _loc1_.lastLadderProgress);
            _loc19_ = 1;
            while(_loc19_ <= _loc13_)
            {
               if(_loc1_.ladderProgress > _loc1_.lastLadderProgress)
               {
                  _loc14_ = dataM.getLadderRankByProgress(_loc1_.lastLadderProgress + (_loc19_ - 1));
                  _loc16_ = dataM.getLadderProgressBaseByRank(_loc14_);
                  _loc18_ = _loc1_.lastLadderProgress + _loc19_ - _loc16_;
                  _loc15_ = dataM.getLadderRankByProgress(_loc1_.lastLadderProgress + _loc19_);
                  if(_loc14_ != _loc15_)
                  {
                     this._tasks.push({
                        "action":"removeAllStars",
                        "rank":_loc14_
                     });
                     this._tasks.push({"action":"removeLevel"});
                     this._tasks.push({
                        "action":"addLevel",
                        "rank":_loc15_
                     });
                     _loc17_ = dataM.getLadderProgressBaseByRank(_loc15_);
                     _loc5_ = dataM.getLadderProgressMaxByRank(_loc15_) - _loc17_;
                     this._tasks.push({
                        "action":"addAllStars_empty",
                        "maxStars":_loc5_
                     });
                  }
                  else
                  {
                     _loc5_ = dataM.getLadderProgressMaxByRank(_loc14_) - _loc16_;
                     this._tasks.push({
                        "action":"addStar",
                        "targetStar":_loc18_,
                        "maxStars":_loc5_
                     });
                  }
               }
               else
               {
                  _loc14_ = dataM.getLadderRankByProgress(_loc1_.lastLadderProgress - (_loc19_ - 1));
                  _loc16_ = dataM.getLadderProgressBaseByRank(_loc14_);
                  _loc18_ = _loc1_.lastLadderProgress - _loc19_ - _loc16_ + 1;
                  _loc15_ = dataM.getLadderRankByProgress(_loc1_.lastLadderProgress - _loc19_);
                  if(_loc14_ != _loc15_)
                  {
                     this._tasks.push({
                        "action":"removeAllStars",
                        "rank":_loc14_
                     });
                     this._tasks.push({"action":"removeLevel"});
                     this._tasks.push({
                        "action":"addLevel",
                        "rank":_loc15_
                     });
                     _loc17_ = dataM.getLadderProgressBaseByRank(_loc15_);
                     _loc5_ = dataM.getLadderProgressMaxByRank(_loc15_) - _loc17_;
                     this._tasks.push({
                        "action":"addAllStars_full",
                        "maxStars":_loc5_
                     });
                  }
                  else
                  {
                     _loc5_ = dataM.getLadderProgressMaxByRank(_loc14_) - _loc16_;
                     this._tasks.push({
                        "action":"removeStar",
                        "targetStar":_loc18_,
                        "maxStars":_loc5_
                     });
                  }
               }
               _loc19_++;
            }
         }
         else
         {
            _loc14_ = dataM.getLadderRankByProgress(_loc1_.ladderProgress);
            _loc16_ = dataM.getLadderProgressBaseByRank(_loc14_);
            _loc20_ = dataM.getLadderProgressMaxByRank(_loc14_);
            _loc5_ = _loc20_ - _loc16_;
            TsLogger.log("MAX:" + _loc5_);
         }
         this.mcStarsBackground.gotoAndStop("stars_" + _loc5_);
         this._tasks.push({"action":"allowExit"});
         this.refreshRankingListPosition();
         this._rankStars = new Array();
         var _loc6_:uint = dataM.getLadderProgressBaseByRank(_loc3_);
         _loc5_ = _loc4_ - _loc6_;
         var _loc7_:Number = _loc1_.lastLadderProgress - _loc6_;
         var _loc8_:uint = 1;
         while(_loc8_ <= _loc5_)
         {
            _loc21_ = true;
            if(_loc8_ > _loc7_)
            {
               _loc21_ = false;
            }
            this.addStar(_loc8_,_loc5_,false,_loc21_);
            _loc8_++;
         }
         this.addRank(_loc3_);
      }
      
      private function languageUpdate() : void
      {
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.animationTasksHandler();
            this.glowHandler();
         }
      }
      
      public function plusClicked() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc1_.lastLadderProgress = _loc1_.ladderProgress;
         var _loc2_:uint = Math.ceil(Math.random() * 50);
         var _loc3_:uint = 1;
         while(_loc3_ <= _loc2_)
         {
            ++_loc1_.ladderProgress;
            if(_loc1_.ladderProgress > dataM.getLadderProgressMaxByRank(1))
            {
               _loc1_.ladderProgress = dataM.getLadderProgressMaxByRank(1);
            }
            _loc3_++;
         }
         this.removeAllStars();
         this.refreshScreen();
      }
      
      public function minusClicked() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         _loc1_.lastLadderProgress = _loc1_.ladderProgress;
         var _loc2_:uint = Math.ceil(Math.random() * 50);
         var _loc3_:uint = 1;
         while(_loc3_ <= _loc2_)
         {
            --_loc1_.ladderProgress;
            if(_loc1_.ladderProgress < 1)
            {
               _loc1_.ladderProgress = 1;
            }
            _loc3_++;
         }
         this.removeAllStars();
         this.refreshScreen();
      }
      
      private function addStar(param1:uint, param2:Number, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:MovieClip = null;
         var _loc10_:Number = NaN;
         if(param4)
         {
            _loc5_ = new mcStarFull();
         }
         else
         {
            _loc5_ = new mcStarEmpty();
         }
         _loc5_.reachedExtraSize = false;
         var _loc6_:Number = Math.ceil(param1 / this.MAX_STARS_IN_ROW) - 1;
         var _loc7_:Number = (param1 - 1) % this.MAX_STARS_IN_ROW;
         var _loc8_:Number = Math.ceil(param2 / this.MAX_STARS_IN_ROW) - 1;
         var _loc9_:Number = this.ROW_Y_JUMP;
         if(_loc6_ < _loc8_)
         {
            _loc10_ = this.MAX_STARS_IN_ROW;
         }
         else
         {
            _loc10_ = (param2 - 1) % this.MAX_STARS_IN_ROW + 1;
         }
         var _loc11_:Number = this.COLUMN_X_JUMP;
         switch(_loc10_)
         {
            case 2:
               _loc11_ += 20;
               break;
            case 3:
               _loc11_ += 12;
               break;
            case 4:
               _loc11_ += 8;
         }
         var _loc12_:Number = 0;
         if(_loc10_ > 1)
         {
            _loc12_ = (_loc10_ - 1) * _loc11_;
         }
         var _loc13_:Number = 0;
         _loc5_.x = _loc7_ * _loc11_ - _loc12_ / 2;
         if(param3)
         {
            _loc5_.scaleX = 0.05;
            _loc5_.scaleY = 0.05;
         }
         if(param4)
         {
            this.mcRankStarsHolder_front.addChild(_loc5_);
         }
         else
         {
            this.mcRankStarsHolder_back.addChild(_loc5_);
         }
         this._rankStars.push(_loc5_);
      }
      
      private function removeAllStars() : void
      {
         var _loc1_:uint = 0;
         if(this._rankStars != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._rankStars.length)
            {
               this._rankStars[_loc1_].parent.removeChild(this._rankStars[_loc1_]);
               this._rankStars[_loc1_] = null;
               _loc1_++;
            }
         }
         this._rankStars = new Array();
      }
      
      private function animationTasksHandler() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(this._tasks != null)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            switch(this._tasks[this._taskSlot].action)
            {
               case "wait":
                  ++this._waitFrameCounter;
                  if(this._waitFrameCounter >= 20)
                  {
                     ++this._taskSlot;
                  }
                  break;
               case "addLevel":
                  if(this._animationInProgress == false)
                  {
                     this._animationInProgress = true;
                     this.addRank(this._tasks[this._taskSlot].rank);
                  }
                  else if(this.mcRankHolder.reachedExtraSize)
                  {
                     if(this.mcRankHolder.scaleX <= 1)
                     {
                        this.mcRankHolder.scaleX = 1;
                        this.mcRankHolder.scaleY = 1;
                        soundM.createSound("explosionMedium",1);
                        this._animationInProgress = false;
                        ++this._taskSlot;
                     }
                     else
                     {
                        this.mcRankHolder.scaleX -= 0.07;
                        this.mcRankHolder.scaleY -= 0.07;
                     }
                  }
                  else if(this.mcRankHolder.scaleX >= 1.3)
                  {
                     this.mcRankHolder.scaleX = 1.3;
                     this.mcRankHolder.scaleY = 1.3;
                     this.mcRankHolder.reachedExtraSize = true;
                  }
                  else
                  {
                     this.mcRankHolder.scaleX += 0.15;
                     this.mcRankHolder.scaleY += 0.15;
                  }
                  break;
               case "removeLevel":
                  if(this._animationInProgress == false)
                  {
                     this._animationInProgress = true;
                  }
                  else if(this.mcRankHolder.reachedExtraSize)
                  {
                     if(this.mcRankHolder.scaleX <= 0.01)
                     {
                        this.removeRank();
                        this._animationInProgress = false;
                        ++this._taskSlot;
                     }
                     else
                     {
                        this.mcRankHolder.scaleX -= 0.2;
                        this.mcRankHolder.scaleY -= 0.2;
                     }
                  }
                  else if(this.mcRankHolder.scaleX >= 1.3)
                  {
                     this.mcRankHolder.scaleX = 1.3;
                     this.mcRankHolder.scaleY = 1.3;
                     this.mcRankHolder.reachedExtraSize = true;
                  }
                  else
                  {
                     this.mcRankHolder.scaleX += 0.15;
                     this.mcRankHolder.scaleY += 0.15;
                  }
                  break;
               case "addStar":
                  if(this._animationInProgress == false)
                  {
                     this.addStar(this._tasks[this._taskSlot].targetStar,this._tasks[this._taskSlot].maxStars,true,true);
                     soundM.createSound("earnRankStar",1);
                     this._animationInProgress = true;
                  }
                  else
                  {
                     _loc2_ = this._rankStars[this._rankStars.length - 1];
                     if(_loc2_ == null)
                     {
                        TsLogger.log("LADDER STATUS ADD STAR ERROR >> MISSING STAR : " + (this._rankStars.length - 1));
                        this._animationInProgress = false;
                        ++this._taskSlot;
                     }
                     else if(_loc2_.reachedExtraSize)
                     {
                        _loc2_.scaleX -= 0.15;
                        _loc2_.scaleY -= 0.15;
                        if(_loc2_.scaleX <= 1)
                        {
                           _loc2_.scaleX = 1;
                           _loc2_.scaleY = 1;
                           _loc2_.reachedExtraSize = false;
                           this._animationInProgress = false;
                           ++this._taskSlot;
                        }
                     }
                     else if(_loc2_.scaleX >= 1.3)
                     {
                        _loc2_.scaleX = 1.3;
                        _loc2_.scaleY = 1.3;
                        _loc2_.reachedExtraSize = true;
                     }
                     else
                     {
                        _loc2_.scaleX += 0.3;
                        _loc2_.scaleY += 0.3;
                     }
                  }
                  break;
               case "addAllStars_empty":
               case "addAllStars_full":
                  if(this._animationInProgress == false)
                  {
                     _loc3_ = 1;
                     while(_loc3_ <= this._tasks[this._taskSlot].maxStars)
                     {
                        if(this._tasks[this._taskSlot].action == "addAllStars_empty")
                        {
                           this.addStar(_loc3_,this._tasks[this._taskSlot].maxStars,true,false);
                        }
                        else
                        {
                           this.addStar(_loc3_,this._tasks[this._taskSlot].maxStars,true,true);
                        }
                        _loc3_++;
                     }
                     this._animationInProgress = true;
                  }
                  _loc3_ = 0;
                  while(_loc3_ < this._rankStars.length)
                  {
                     _loc2_ = this._rankStars[_loc3_];
                     if(_loc2_.reachedExtraSize)
                     {
                        if(_loc2_.scaleX <= 1)
                        {
                           _loc2_.scaleX = 1;
                           _loc2_.scaleY = 1;
                           if(_loc3_ == this._rankStars.length - 1)
                           {
                              _loc4_ = 0;
                              while(_loc4_ < this._rankStars.length)
                              {
                                 this._rankStars[_loc4_].reachedExtraSize = false;
                                 _loc4_++;
                              }
                              this._animationInProgress = false;
                              ++this._taskSlot;
                           }
                        }
                        else
                        {
                           _loc2_.scaleX -= 0.07;
                           _loc2_.scaleY -= 0.07;
                        }
                     }
                     else if(_loc2_.scaleX >= 1.3)
                     {
                        _loc2_.scaleX = 1.3;
                        _loc2_.scaleY = 1.3;
                        _loc2_.reachedExtraSize = true;
                     }
                     else
                     {
                        _loc2_.scaleX += 0.15;
                        _loc2_.scaleY += 0.15;
                     }
                     _loc3_++;
                  }
                  break;
               case "removeStar":
                  _loc2_ = this._rankStars[this._tasks[this._taskSlot].targetStar - 1];
                  if(_loc2_ == null)
                  {
                     TsLogger.log("LADDER STATUS REMOVE STAR ERROR >> MISSING STAR : " + (this._tasks[this._taskSlot].targetStar - 1));
                     this._animationInProgress = false;
                     ++this._taskSlot;
                  }
                  else
                  {
                     if(this._animationInProgress == false)
                     {
                        this._animationInProgress = true;
                        this.addStar(this._tasks[this._taskSlot].targetStar,this._tasks[this._taskSlot].maxStars,false,false);
                     }
                     if(_loc2_.reachedExtraSize)
                     {
                        if(_loc2_.scaleX <= 0.01)
                        {
                           _loc2_.scaleX = 0.01;
                           _loc2_.scaleY = 0.01;
                           _loc2_.visible = false;
                           _loc2_.reachedExtraSize = false;
                           this._animationInProgress = false;
                           ++this._taskSlot;
                        }
                        else
                        {
                           _loc2_.scaleX -= 0.2;
                           _loc2_.scaleY -= 0.2;
                        }
                     }
                     else if(_loc2_.scaleX >= 1.3)
                     {
                        _loc2_.scaleX = 1.3;
                        _loc2_.scaleY = 1.3;
                        _loc2_.reachedExtraSize = true;
                     }
                     else
                     {
                        _loc2_.scaleX += 0.15;
                        _loc2_.scaleY += 0.15;
                     }
                  }
                  break;
               case "removeAllStars":
                  if(this._animationInProgress == false)
                  {
                     this._animationInProgress = true;
                  }
                  _loc3_ = 0;
                  while(_loc3_ < this._rankStars.length)
                  {
                     _loc2_ = this._rankStars[_loc3_];
                     if(_loc2_.reachedExtraSize)
                     {
                        if(_loc2_.scaleX <= 0.01)
                        {
                           _loc2_.scaleX = 0.01;
                           _loc2_.scaleY = 0.01;
                           _loc2_.visible = false;
                           if(_loc3_ == this._rankStars.length - 1)
                           {
                              this._animationInProgress = false;
                              ++this._taskSlot;
                              this.removeAllStars();
                           }
                        }
                        else
                        {
                           _loc2_.scaleX -= 0.2;
                           _loc2_.scaleY -= 0.2;
                        }
                     }
                     else if(_loc2_.scaleX >= 1.3)
                     {
                        _loc2_.scaleX = 1.3;
                        _loc2_.scaleY = 1.3;
                        _loc2_.reachedExtraSize = true;
                     }
                     else
                     {
                        _loc2_.scaleX += 0.15;
                        _loc2_.scaleY += 0.15;
                     }
                     _loc3_++;
                  }
                  break;
               case "removeLevel":
               case "addLevel":
                  break;
               case "allowExit":
                  this._tasks = null;
                  this.btnClose.enableMe();
            }
         }
      }
      
      private function refreshRankingListPosition() : void
      {
         var _loc1_:Boolean = false;
         if(dataM.showRankingListPosition())
         {
            _loc1_ = false;
            if(dataM.myProfile.lastBattleResult == BMDataManager.BATTLE_RESULT_LOSS)
            {
               if(dataM.myProfile.pvpInitialRankingListPosition < dataM.myProfile.pvpFinalRankingListPosition)
               {
                  _loc1_ = true;
               }
            }
            else if(dataM.myProfile.pvpInitialRankingListPosition > dataM.myProfile.pvpFinalRankingListPosition)
            {
               _loc1_ = true;
            }
            if(_loc1_ == false)
            {
               this.txtRankingListPosition.x += 17;
            }
            this.rankingListPosition = dataM.myProfile.pvpFinalRankingListPosition;
            if(_loc1_)
            {
               this.mcRankingListPositionChangeArrow.visible = true;
               this._arrowOriginYPos = this.mcRankingListPositionChangeArrow.y;
               if(dataM.myProfile.lastBattleResult == BMDataManager.BATTLE_RESULT_LOSS)
               {
                  this.mcRankingListPositionChangeArrow.gotoAndStop(2);
                  TweenMax.fromTo(this.mcRankingListPositionChangeArrow,this.ARROW_MOTION_DURATION,{
                     "alpha":0,
                     "y":this._arrowOriginYPos - this.ARROW_Y_CHANGE
                  },{
                     "alpha":1,
                     "y":this._arrowOriginYPos,
                     "onComplete":this.arrowDownInAnimComplete
                  });
               }
               else
               {
                  TweenMax.fromTo(this.mcRankingListPositionChangeArrow,this.ARROW_MOTION_DURATION,{
                     "alpha":0,
                     "y":this._arrowOriginYPos + this.ARROW_Y_CHANGE
                  },{
                     "alpha":1,
                     "y":this._arrowOriginYPos,
                     "onComplete":this.arrowUpInAnimComplete
                  });
               }
               TweenMax.fromTo(this,1,{"rankingListPosition":dataM.myProfile.pvpInitialRankingListPosition},{"rankingListPosition":this._rankingListPosition});
            }
            else
            {
               this.mcRankingListPositionChangeArrow.visible = false;
            }
            this.btnClose.y = this.mcSizer_btnClose.y;
         }
         else
         {
            this.rankingListPosition = 0;
            this.btnClose.y = this.mcSizer_btnClose.y - 40;
            this.mcRankingListPositionChangeArrow.visible = false;
         }
      }
      
      private function arrowUpInAnimComplete() : void
      {
         TweenMax.fromTo(this.mcRankingListPositionChangeArrow,this.ARROW_MOTION_DURATION,{
            "alpha":1,
            "y":this._arrowOriginYPos
         },{
            "delay":0.3,
            "alpha":0,
            "y":this._arrowOriginYPos - this.ARROW_Y_CHANGE,
            "onComplete":this.arrowUpOutAnimComplete
         });
      }
      
      private function arrowUpOutAnimComplete() : void
      {
         TweenMax.fromTo(this.mcRankingListPositionChangeArrow,this.ARROW_MOTION_DURATION,{
            "alpha":0,
            "y":this._arrowOriginYPos + this.ARROW_Y_CHANGE
         },{
            "delay":0.3,
            "alpha":1,
            "y":this._arrowOriginYPos,
            "onComplete":this.arrowUpInAnimComplete
         });
      }
      
      private function arrowDownInAnimComplete() : void
      {
         TweenMax.fromTo(this.mcRankingListPositionChangeArrow,this.ARROW_MOTION_DURATION,{
            "alpha":1,
            "y":this._arrowOriginYPos
         },{
            "delay":0.3,
            "alpha":0,
            "y":this._arrowOriginYPos + this.ARROW_Y_CHANGE,
            "onComplete":this.arrowDownOutAnimComplete
         });
      }
      
      private function arrowDownOutAnimComplete() : void
      {
         TweenMax.fromTo(this.mcRankingListPositionChangeArrow,this.ARROW_MOTION_DURATION,{
            "alpha":0,
            "y":this._arrowOriginYPos - this.ARROW_Y_CHANGE
         },{
            "delay":0.3,
            "alpha":1,
            "y":this._arrowOriginYPos,
            "onComplete":this.arrowDownInAnimComplete
         });
      }
      
      private function removeRank() : void
      {
         if(this.mcRankHolder != null)
         {
            if(this.mcRankHolder.mcRank != null)
            {
               this.mcRankHolder.mcRank.parent.removeChild(this.mcRankHolder.mcRank);
               this.mcRankHolder.mcRank = null;
            }
         }
         else
         {
            this.mcRankHolder = new MovieClip();
         }
      }
      
      private function addRank(param1:uint) : void
      {
         this.removeRank();
         var _loc2_:String = "Grp_rank" + dataM.getLadderRankIconNumber(param1) + "_large";
         var _loc3_:Sprite = externalAssetsM.getAsset("general",_loc2_,this.mcSizer_rank.width,this.mcSizer_rank.height,false,false);
         this.mcRankHolder.mcRank = _loc3_;
         this.mcRankHolder.addChild(_loc3_);
         _loc3_.x = -_loc3_.width / 2;
         _loc3_.y = -_loc3_.height / 2;
         this.mcRankHolder.scaleX = 1;
         this.mcRankHolder.scaleY = 1;
         this.mcRankHolder.x = this.mcSizer_rank.x + this.mcSizer_rank.width / 2;
         this.mcRankHolder.y = this.mcSizer_rank.y + this.mcSizer_rank.height / 2;
         this.mcRankHolder.reachedExtraSize = false;
         this.mcIconsHolder.addChild(this.mcRankHolder);
         this.txtRank.text = String(param1);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("ladderStatusRank",[this.txtRank],"",this);
         }
      }
      
      public function get rankingListPosition() : Number
      {
         return this._rankingListPosition;
      }
      
      public function set rankingListPosition(param1:Number) : void
      {
         this._rankingListPosition = param1;
         var _loc2_:String = "";
         if(this._rankingListPosition > 0)
         {
            _loc2_ = "#" + TextUtils.getNumberWithComma(int(this._rankingListPosition));
         }
         updateTextAndFormat(this.txtRankingListPosition,_loc2_);
         ImageUtils.swapTextFieldWithBitMap(this.txtRankingListPosition,this);
      }
      
      private function glowHandler() : void
      {
         if(this._glowActive)
         {
            switch(this._glow1Status)
            {
               case "grow":
                  this.mcGlow1.scaleX += 0.001;
                  this.mcGlow1.scaleY += 0.001;
                  if(this.mcGlow1.scaleX > 1)
                  {
                     this._glow1Status = "shrink";
                  }
                  break;
               case "shrink":
                  this.mcGlow1.scaleX -= 0.001;
                  this.mcGlow1.scaleY -= 0.001;
                  if(this.mcGlow1.scaleX < 0.9)
                  {
                     this._glow1Status = "grow";
                  }
            }
            this.mcGlow2.rotation -= 0.3;
         }
      }
      
      public function closeClicked() : void
      {
         this.removeAllStars();
         screensM.removeScreen(BMScreensManager.SCR_LADDER_STATUS);
         if(screensM.isBattleOpened())
         {
            screensM.screenBattle.closeScreen();
         }
         else
         {
            screensM.screenVS.notifyBattleResultsCeremonyFinished();
         }
         this.btnClose.disableMe();
         TweenMax.killTweensOf(this.mcRankingListPositionChangeArrow);
      }
   }
}

