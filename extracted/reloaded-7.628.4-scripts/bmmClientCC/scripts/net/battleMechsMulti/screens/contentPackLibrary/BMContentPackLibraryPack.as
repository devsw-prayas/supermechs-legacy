package net.battleMechsMulti.screens.contentPackLibrary
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   public class BMContentPackLibraryPack extends MovieClip
   {
      
      private var packRowsHolder:Sprite;
      
      private var lockedMessageHolder:Sprite;
      
      private var titleHolder:Sprite;
      
      private var mouseHitArea:Sprite;
      
      private var rows:Array;
      
      private var _packWidth:uint;
      
      private var _packHeight:uint;
      
      private var _animationsTimer:Timer;
      
      private var _lastMouseY:Number;
      
      private var _lastDeltaY:Array;
      
      private var _deltaYAfterMouseUp:Number;
      
      private var _mouseDown:Boolean;
      
      private var _itemGroupsData:Array;
      
      private var _minRowInView:Number;
      
      private var _maxRowInView:Number;
      
      private var _entirePackHeight:Number;
      
      private var _packID:uint;
      
      private var _inView:Boolean;
      
      private var _locked:Boolean;
      
      private var _ignoreNextClicked:Boolean = false;
      
      private var unlockPackMessage:MovieClip;
      
      private var _waitingForUserToUnlock:Boolean = false;
      
      private var _manualAnimationActive:Boolean = false;
      
      private var _manualAnimationTargetYPos:int;
      
      private var _manualAnimationMaxYChangePerFrame:uint;
      
      private var _manualAnimationDelayFrames:uint;
      
      private var _manualAnimationComplete:Function;
      
      private var _itemClicked:Function;
      
      public function BMContentPackLibraryPack(param1:uint, param2:uint, param3:uint, param4:Array, param5:Function, param6:Boolean, param7:Boolean)
      {
         super();
         this._packID = param1;
         this._locked = param7;
         this._itemClicked = param5;
         this._packWidth = param2;
         this._packHeight = param3;
         this._itemGroupsData = param4;
         this._lastDeltaY = new Array();
         this._inView = param6;
         this.initPackTitle();
         this.initPackRows();
         addChild(this.titleHolder);
         this.initLockedMessageHolder();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.initMouseHitArea();
         this.startAnimationsTimer();
         this.initRowsInView();
      }
      
      public function set inView(param1:Boolean) : void
      {
         this._inView = param1;
         if(this._inView)
         {
            this.addMouseEvents();
         }
         else
         {
            this.removeMouseEvents();
         }
         this.refreshRowsInView(false,true);
      }
      
      private function initPackTitle() : void
      {
         var _loc1_:String = BMDataManager.getInstance().contentPackResolver.getPackTitleText(this._packID);
         var _loc2_:BMContentPackLibraryPackRow = new BMContentPackLibraryPackPackTitle();
         _loc2_.setTitle(_loc1_);
         _loc2_.y = -_loc2_.height;
         this._packHeight -= _loc2_.height;
         y += _loc2_.height;
         this.titleHolder = new Sprite();
         this.titleHolder.addChild(_loc2_);
      }
      
      private function initPackRows() : void
      {
         this._minRowInView = 0;
         this.rows = new Array();
         this.packRowsHolder = new Sprite();
         addChild(this.packRowsHolder);
         this._entirePackHeight = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemGroupsData.length)
         {
            this.addPackRow(_loc1_);
            _loc1_++;
         }
      }
      
      private function addPackRow(param1:uint) : void
      {
         var _loc4_:BMContentPackLibraryPackRow = null;
         var _loc2_:int = int(this._itemGroupsData[param1][0]);
         var _loc3_:Boolean = _loc2_ < 0;
         if(_loc3_)
         {
            _loc4_ = new BMContentPackLibraryPackRowTitle();
            _loc4_.setTitle(BMDataManager.getInstance().contentPackResolver.getItemTypeTitleText(_loc2_));
         }
         else
         {
            _loc4_ = new BMContentPackLibraryPackRowItemChain();
            _loc4_.setItems(this._itemGroupsData[param1],this._locked);
         }
         _loc4_.y = this._entirePackHeight;
         this._entirePackHeight += _loc4_.height;
         if(this.isPackRowTopInView(_loc4_))
         {
            this._maxRowInView = param1;
         }
         this.rows.push(_loc4_);
         if(this._inView)
         {
            this.packRowsHolder.addChild(_loc4_);
         }
      }
      
      private function initMouseHitArea() : void
      {
         this.mouseHitArea = new Sprite();
         this.mouseHitArea.graphics.beginFill(0,0);
         this.mouseHitArea.graphics.drawRect(0,0,this._packWidth,this._packHeight);
         if(this._inView)
         {
            this.addMouseEvents();
         }
         addChild(this.mouseHitArea);
         this._mouseDown = false;
      }
      
      private function addMouseEvents() : void
      {
         this.mouseHitArea.addEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
         this.mouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.onHitAreaMouseDown);
         this.mouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.onHitAreaMouseUp);
         this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.onHitAreaMouseUp);
      }
      
      private function removeMouseEvents() : void
      {
         this.mouseHitArea.removeEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
         this.mouseHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.onHitAreaMouseDown);
         this.mouseHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.onHitAreaMouseUp);
         this.mouseHitArea.removeEventListener(MouseEvent.MOUSE_OUT,this.onHitAreaMouseUp);
      }
      
      private function startAnimationsTimer() : void
      {
         if(this._entirePackHeight <= this._packHeight)
         {
            return;
         }
         this._animationsTimer = new Timer(33);
         this._animationsTimer.addEventListener(TimerEvent.TIMER,this.onTimerTrigger);
         this._animationsTimer.start();
      }
      
      private function stopAnimationsTimer() : void
      {
         if(this._animationsTimer == null)
         {
            return;
         }
         this._animationsTimer.stop();
      }
      
      private function initRowsInView() : void
      {
         this.refreshRowsInView(true);
      }
      
      private function setMinAndMaxRowsInView() : void
      {
         this.setMaxRowInView();
         this.setMinRowInView();
      }
      
      private function setMaxRowInView() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:BMContentPackLibraryPackRow = this.rows[this._maxRowInView];
         var _loc2_:Boolean = this.isPackRowTopInView(_loc1_);
         if(!_loc2_)
         {
            _loc3_ = this._maxRowInView - 1;
            while(true)
            {
               if(_loc3_ >= 0)
               {
                  _loc1_ = this.rows[_loc3_];
                  if(this.isPackRowTopInView(_loc1_))
                  {
                     break;
                  }
                  _loc3_--;
                  continue;
               }
            }
            this._maxRowInView = _loc3_;
            return;
         }
         if(this._maxRowInView == this.rows.length - 1)
         {
            return;
         }
         _loc3_ = this._maxRowInView + 1;
         while(_loc3_ < this.rows.length)
         {
            _loc1_ = this.rows[_loc3_];
            if(!this.isPackRowTopInView(_loc1_))
            {
               return;
            }
            this._maxRowInView = _loc3_;
            _loc3_++;
         }
      }
      
      private function setMinRowInView() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:BMContentPackLibraryPackRow = this.rows[this._minRowInView];
         var _loc2_:Boolean = this.isPackRowBottomInView(_loc1_);
         if(!_loc2_)
         {
            _loc3_ = this._minRowInView + 1;
            while(true)
            {
               if(_loc3_ < this.rows.length)
               {
                  _loc1_ = this.rows[_loc3_];
                  if(this.isPackRowTopInView(_loc1_))
                  {
                     break;
                  }
                  _loc3_++;
                  continue;
               }
            }
            this._minRowInView = _loc3_;
            return;
         }
         if(this._minRowInView == 0)
         {
            return;
         }
         _loc3_ = this._minRowInView - 1;
         while(_loc3_ >= 0)
         {
            _loc1_ = this.rows[_loc3_];
            if(!this.isPackRowBottomInView(_loc1_))
            {
               return;
            }
            this._minRowInView = _loc3_;
            _loc3_--;
         }
      }
      
      private function isPackRowBottomInView(param1:BMContentPackLibraryPackRow) : Boolean
      {
         return param1.y + param1.height + this.packRowsHolder.y >= 0;
      }
      
      private function isPackRowTopInView(param1:BMContentPackLibraryPackRow) : Boolean
      {
         return param1.y + this.packRowsHolder.y <= this._packHeight;
      }
      
      private function refreshRowsInView(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc5_:BMContentPackLibraryPackRow = null;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         if(param2)
         {
            _loc3_ = this._inView == true;
            _loc4_ = this._inView == false;
         }
         if(param1)
         {
            _loc6_ = this._minRowInView;
            while(_loc6_ <= this._maxRowInView)
            {
               _loc5_ = this.rows[_loc6_];
               if(this._inView)
               {
                  _loc5_.showMe();
               }
               _loc6_++;
            }
            if(this._maxRowInView == this.rows.length - 1)
            {
               return;
            }
            _loc6_ = this._maxRowInView + 1;
            while(_loc6_ < this.rows.length)
            {
               _loc5_ = this.rows[_loc6_];
               if(_loc5_.parent != null)
               {
                  _loc5_.parent.removeChild(_loc5_);
               }
               _loc6_++;
            }
            return;
         }
         var _loc7_:uint = this._minRowInView;
         var _loc8_:uint = this._maxRowInView;
         this.setMinAndMaxRowsInView();
         var _loc9_:Array = new Array();
         var _loc10_:Array = new Array();
         _loc6_ = _loc7_;
         while(_loc6_ <= _loc8_)
         {
            _loc9_.push(_loc6_);
            _loc6_++;
         }
         _loc6_ = this._minRowInView;
         while(_loc6_ <= this._maxRowInView)
         {
            _loc10_.push(_loc6_);
            _loc6_++;
         }
         var _loc11_:Array = new Array();
         var _loc12_:Array = new Array();
         if(_loc3_)
         {
            _loc13_ = 0;
            while(_loc13_ < _loc10_.length)
            {
               _loc11_.push(_loc10_[_loc13_]);
               _loc13_++;
            }
         }
         else if(_loc4_)
         {
            _loc13_ = 0;
            while(_loc13_ < _loc9_.length)
            {
               _loc12_.push(_loc9_[_loc13_]);
               _loc13_++;
            }
         }
         else
         {
            _loc13_ = 0;
            while(_loc13_ < _loc9_.length)
            {
               _loc15_ = false;
               _loc14_ = 0;
               while(_loc14_ < _loc10_.length)
               {
                  if(_loc9_[_loc13_] == _loc10_[_loc14_])
                  {
                     _loc15_ = true;
                     break;
                  }
                  _loc14_++;
               }
               if(_loc15_ == false)
               {
                  _loc12_.push(_loc9_[_loc13_]);
               }
               _loc13_++;
            }
            _loc13_ = 0;
            while(_loc13_ < _loc10_.length)
            {
               _loc15_ = false;
               _loc14_ = 0;
               while(_loc14_ < _loc9_.length)
               {
                  if(_loc10_[_loc13_] == _loc9_[_loc14_])
                  {
                     _loc15_ = true;
                     break;
                  }
                  _loc14_++;
               }
               if(_loc15_ == false)
               {
                  _loc11_.push(_loc10_[_loc13_]);
               }
               _loc13_++;
            }
         }
         _loc13_ = 0;
         while(_loc13_ < _loc12_.length)
         {
            _loc5_ = this.rows[_loc12_[_loc13_]];
            _loc5_.hideMe();
            if(_loc5_.parent != null)
            {
               _loc5_.parent.removeChild(_loc5_);
            }
            _loc13_++;
         }
         _loc13_ = 0;
         while(_loc13_ < _loc11_.length)
         {
            _loc5_ = this.rows[_loc11_[_loc13_]];
            _loc5_.showMe();
            if(_loc5_.parent == null)
            {
               this.packRowsHolder.addChild(_loc5_);
            }
            _loc13_++;
         }
      }
      
      private function onTimerTrigger(param1:TimerEvent) : void
      {
         if(this._inView == false)
         {
            return;
         }
         if(this._waitingForUserToUnlock)
         {
            return;
         }
         if(this._manualAnimationActive)
         {
            this.manualAnimationTrigger();
            return;
         }
         if(this._mouseDown == false)
         {
            if(Math.abs(this._deltaYAfterMouseUp) > 1)
            {
               this.movePackRowsHolder(this._deltaYAfterMouseUp);
               this._deltaYAfterMouseUp *= 0.9;
            }
            else
            {
               this._deltaYAfterMouseUp = 0;
            }
            return;
         }
         var _loc2_:int = mouseY - this._lastMouseY;
         this._lastMouseY = mouseY;
         this.movePackRowsHolder(_loc2_);
         this._lastDeltaY.push(_loc2_);
         if(this._lastDeltaY.length > 3)
         {
            this._ignoreNextClicked = true;
         }
         if(this._lastDeltaY.length > 10)
         {
            this._lastDeltaY.splice(0,1);
         }
      }
      
      private function movePackRowsHolder(param1:Number) : void
      {
         this.packRowsHolder.y += param1;
         this.setPackRowsHolderInBounds();
         this.refreshRowsInView();
      }
      
      private function setPackRowsHolderInBounds() : void
      {
         if(this.packRowsHolder.y > 0)
         {
            this.packRowsHolder.y = 0;
            return;
         }
         if(this.packRowsHolder.y < -(this._entirePackHeight - this._packHeight))
         {
            this.packRowsHolder.y = -(this._entirePackHeight - this._packHeight);
         }
      }
      
      private function setPositionByRatio(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 1)
         {
            param1 = 1;
         }
         var _loc2_:int = this._entirePackHeight - this._packHeight;
         if(_loc2_ <= this._packHeight)
         {
            return;
         }
         this.packRowsHolder.y = -_loc2_ * param1;
         this.setPackRowsHolderInBounds();
         this.refreshRowsInView();
      }
      
      private function manuallyMoveToTop() : void
      {
         this._manualAnimationMaxYChangePerFrame = 30;
         this._manualAnimationTargetYPos = 0;
         this._manualAnimationDelayFrames = 20;
         this._manualAnimationActive = true;
      }
      
      private function manualAnimationTrigger() : void
      {
         if(this._manualAnimationDelayFrames > 0)
         {
            --this._manualAnimationDelayFrames;
            return;
         }
         var _loc1_:int = this._manualAnimationTargetYPos - this.packRowsHolder.y;
         var _loc2_:int = _loc1_ * 0.2;
         if(Math.abs(_loc2_) < 2)
         {
            this.movePackRowsHolder(_loc1_);
            this._manualAnimationActive = false;
            this._manualAnimationComplete();
            return;
         }
         if(Math.abs(_loc2_) > this._manualAnimationMaxYChangePerFrame)
         {
            if(_loc2_ > 0)
            {
               _loc2_ = int(this._manualAnimationMaxYChangePerFrame);
            }
            else
            {
               _loc2_ = -this._manualAnimationMaxYChangePerFrame;
            }
         }
         this.movePackRowsHolder(_loc2_);
      }
      
      private function onHitAreaClicked(param1:MouseEvent) : void
      {
         var _loc2_:BMContentPackLibraryPackRow = null;
         if(this._inView == false)
         {
            return;
         }
         if(this._locked)
         {
            return;
         }
         if(this._ignoreNextClicked)
         {
            this._ignoreNextClicked = false;
            return;
         }
         if(this._waitingForUserToUnlock)
         {
            return;
         }
         if(this._manualAnimationActive)
         {
            return;
         }
         var _loc3_:int = -1;
         var _loc4_:uint = this._minRowInView;
         while(_loc4_ <= this._maxRowInView)
         {
            _loc2_ = this.rows[_loc4_];
            if(_loc2_.y + this.packRowsHolder.y <= param1.localY && _loc2_.y + _loc2_.height + this.packRowsHolder.y >= param1.localY)
            {
               _loc3_ = int(_loc4_);
               break;
            }
            _loc4_++;
         }
         if(_loc3_ == -1)
         {
            return;
         }
         _loc2_ = this.rows[_loc3_];
         this._itemClicked(this._packID,_loc2_.getItemIDAt(param1.localX));
      }
      
      private function onHitAreaMouseDown(param1:MouseEvent) : void
      {
         this._mouseDown = true;
         this._lastMouseY = mouseY;
      }
      
      private function onHitAreaMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         this._mouseDown = false;
         this._deltaYAfterMouseUp = 0;
         if(this._lastDeltaY.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this._lastDeltaY.length)
            {
               this._deltaYAfterMouseUp += this._lastDeltaY[_loc2_];
               _loc2_++;
            }
            this._deltaYAfterMouseUp /= this._lastDeltaY.length;
            this._lastDeltaY = new Array();
         }
      }
      
      private function initLockedMessageHolder() : void
      {
         this.lockedMessageHolder = new Sprite();
         addChild(this.lockedMessageHolder);
      }
      
      public function addLockedMessage(param1:MovieClip) : void
      {
         this.lockedMessageHolder.graphics.beginFill(0,0.4);
         this.lockedMessageHolder.graphics.drawRect(0,0,this._packWidth,this._packHeight + 2);
         param1.x = (this._packWidth - param1.width) / 2;
         param1.y = (this._packHeight - param1.height) / 2;
         this.lockedMessageHolder.addChild(param1);
      }
      
      public function startUnlockPackAnimation(param1:Function) : void
      {
         this._manualAnimationComplete = param1;
         this.addUnlcokMessage();
         this.setPositionByRatio(1);
      }
      
      private function addUnlcokMessage() : void
      {
         this.mouseHitArea.visible = false;
         this.unlockPackMessage = new BMContentPackLibraryPackUnlockedMessage();
         var _loc1_:BMBasicButton = this.unlockPackMessage.btnUnlock;
         _loc1_.text = BMLanguageManager.getInstance().getText("contentPackLibrary_unlock");
         _loc1_.addEventListener(BMIntractable.HIT,this.unlockClicked);
         this.lockedMessageHolder.graphics.beginFill(0,0.4);
         this.lockedMessageHolder.graphics.drawRect(0,0,this._packWidth,this._packHeight + 2);
         this.unlockPackMessage.x = (this._packWidth - this.unlockPackMessage.width) / 2;
         this.unlockPackMessage.y = (this._packHeight - this.unlockPackMessage.height) / 2;
         this.lockedMessageHolder.addChild(this.unlockPackMessage);
         this._waitingForUserToUnlock = true;
      }
      
      private function unlockClicked(param1:Event) : void
      {
         this.mouseHitArea.visible = true;
         this._waitingForUserToUnlock = false;
         this.unlockPackMessage.parent.removeChild(this.unlockPackMessage);
         this.unlockPackMessage = null;
         TweenMax.to(this.lockedMessageHolder,0.5,{"alpha":0});
         this.manuallyMoveToTop();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.stopAnimationsTimer();
         this.mouseHitArea.removeEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
      }
   }
}

