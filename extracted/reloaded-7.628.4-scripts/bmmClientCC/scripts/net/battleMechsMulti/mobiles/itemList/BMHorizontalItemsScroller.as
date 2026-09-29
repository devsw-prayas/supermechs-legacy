package net.battleMechsMulti.mobiles.itemList
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   public class BMHorizontalItemsScroller extends MovieClip
   {
      
      public static const NAVIGATION_TYPE_BUTTONS:uint = 1;
      
      public static const NAVIGATION_TYPE_FINGER_SCROLLING:uint = 2;
      
      public static const NAVIGATION_TYPE_NONE:uint = 3;
      
      public static const NAVIGATION_DIRECTION_HORIZONTAL:uint = 1;
      
      public static const NAVIGATION_DIRECTION_VERTICAL:uint = 2;
      
      public var mcHitArea:Sprite;
      
      public var mcItemsHolder:Sprite;
      
      public var mcVisibleArea:Sprite;
      
      public var btnPrevious:BMBasicButton;
      
      public var btnNext:BMBasicButton;
      
      private var _viewClass:Class;
      
      private var _viewClassFunc:Function;
      
      private var _items:Array;
      
      private var _navigationType:uint = 0;
      
      private var _navigationDirection:uint = 0;
      
      private var _scrollActive:Boolean = false;
      
      private var _scrollingSpeed:Number = 0;
      
      private var _scrollPos:Array = new Array();
      
      private var _scrollMax:Number = 0;
      
      private var _scrollAbsoluteDelta:uint = 0;
      
      private var _buttonScrollingTargetSlot:Number;
      
      private var _buttonScrollingTargetPos:Number;
      
      private var _buttonScrollingActive:Boolean = false;
      
      private var _buttonScrollingDelayFrames:uint = 0;
      
      private var _itemsPerPage:uint;
      
      private var _itemsSize:Array;
      
      private var _itemsPos:Array;
      
      private var _lastItemsHolderPos:Number = 0;
      
      private var _firstSetItems:Boolean = true;
      
      private var _itemSelectedFunction:Function;
      
      private var _lastMouseDownCoords:Point;
      
      public function BMHorizontalItemsScroller()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      public function setViewClass(param1:Class) : void
      {
         this._viewClass = param1;
      }
      
      public function setViewClassFunction(param1:Function) : void
      {
         this._viewClassFunc = param1;
      }
      
      public function isInitiated() : Boolean
      {
         return this._viewClass != null || this._viewClassFunc != null;
      }
      
      public function setItemSelectedFunction(param1:Function) : void
      {
         this._itemSelectedFunction = param1;
      }
      
      public function activateScrolling(param1:uint, param2:uint = 1) : void
      {
         this._navigationType = param1;
         this._navigationDirection = param2;
         addEventListener(Event.ENTER_FRAME,this.enterFrameTrigger);
         switch(this._navigationType)
         {
            case NAVIGATION_TYPE_NONE:
               if(this.btnPrevious != null)
               {
                  this.btnPrevious.visible = false;
                  this.btnNext.visible = false;
               }
               this.mcHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownEvent);
               this.mcHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutEvent);
               this.mcHitArea.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpEvent);
               break;
            case NAVIGATION_TYPE_FINGER_SCROLLING:
               this.mcHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownEvent);
               this.mcHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutEvent);
               this.mcHitArea.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpEvent);
               if(this.btnPrevious != null)
               {
                  this.btnPrevious.visible = false;
                  this.btnNext.visible = false;
               }
               break;
            case NAVIGATION_TYPE_BUTTONS:
               if(this.btnPrevious == null)
               {
                  TsLogger.log("ERROR BMHorizontalItemsScroller btnPrevious and btnNext instances are missing");
               }
               this.btnPrevious.addEventListener(BMIntractable.HIT,this.previousClicked);
               this.btnNext.addEventListener(BMIntractable.HIT,this.nextClicked);
               this.mcHitArea.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         }
      }
      
      public function bringItemToFront(param1:int) : *
      {
         var _loc2_:BMInterfaceItemView = this.getItemView(param1);
         var _loc3_:MovieClip = _loc2_ as MovieClip;
         if(_loc3_.parent != null)
         {
            _loc3_.parent.removeChild(_loc3_);
            this.mcItemsHolder.addChild(_loc3_);
         }
      }
      
      private function enterFrameTrigger(param1:Event) : void
      {
         switch(this._navigationType)
         {
            case NAVIGATION_TYPE_FINGER_SCROLLING:
               this.fingerScrollingOnEnterFrame();
               break;
            case NAVIGATION_TYPE_BUTTONS:
               this.buttonsScrollingOnEnterFrame();
               this.borderButtonsVisibilityHandler();
               break;
            case NAVIGATION_TYPE_NONE:
               this.buttonsScrollingOnEnterFrame();
         }
         this.refreshItemsVisibility();
      }
      
      private function get scrollActive() : Boolean
      {
         return this._scrollActive || this._buttonScrollingActive;
      }
      
      private function borderButtonsVisibilityHandler() : void
      {
         if(this.btnNext == null)
         {
            return;
         }
         var _loc1_:int = this.getHighestItemSlotForButtonsScrolling();
         if(this._buttonScrollingTargetSlot > 0)
         {
            if(this.btnPrevious.alpha < 1)
            {
               this.btnPrevious.alpha += 0.2;
               if(this.btnPrevious.visible == false)
               {
                  this.btnPrevious.visible = true;
               }
            }
         }
         else if(this.btnPrevious.alpha > 0 && (!this.scrollActive || _loc1_ == 0))
         {
            this.btnPrevious.alpha -= 0.2;
            if(this.btnPrevious.alpha <= 0)
            {
               this.btnPrevious.visible = false;
            }
         }
         if(this._buttonScrollingTargetSlot < _loc1_)
         {
            if(this.btnNext.alpha < 1)
            {
               this.btnNext.alpha += 0.2;
               if(this.btnNext.visible == false)
               {
                  this.btnNext.visible = true;
               }
            }
         }
         else if(this.btnNext.alpha > 0 && (!this.scrollActive || _loc1_ == 0))
         {
            this.btnNext.alpha -= 0.2;
            if(this.btnNext.alpha <= 0)
            {
               this.btnNext.visible = false;
            }
         }
      }
      
      private function getHighestItemSlotForButtonsScrolling() : int
      {
         var _loc1_:int = this._items.length - this._itemsPerPage;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      private function previousClicked(param1:Event) : void
      {
         this.previousClickedSub();
      }
      
      private function nextClicked(param1:Event) : void
      {
         this.nextClickedSub();
      }
      
      private function nextClickedSub() : void
      {
         var _loc1_:uint = 1;
         if(this._itemsPerPage > 1)
         {
            _loc1_ = Math.max(Math.floor(this._itemsPerPage / 2),2);
         }
         this.setScrollerToSpecificItemSlot(this._buttonScrollingTargetSlot + _loc1_,true);
      }
      
      private function previousClickedSub() : void
      {
         var _loc1_:uint = 1;
         if(this._itemsPerPage > 1)
         {
            _loc1_ = Math.max(Math.floor(this._itemsPerPage / 2),2);
         }
         this.setScrollerToSpecificItemSlot(this._buttonScrollingTargetSlot - _loc1_,true);
      }
      
      private function onMouseDownEvent(param1:MouseEvent) : void
      {
         this.onMouseDownEventSub();
      }
      
      private function onMouseUpEvent(param1:MouseEvent) : void
      {
         this.onMouseUpEventSub();
      }
      
      private function onMouseOutEvent(param1:MouseEvent) : void
      {
         this.onMouseUpEventSub(true);
      }
      
      private function onMouseDownEventSub() : void
      {
         this._lastMouseDownCoords = new Point(mouseX,mouseY);
         if(!this.canScroll)
         {
            return;
         }
         this._scrollActive = true;
         this._scrollAbsoluteDelta = 0;
         this._scrollPos.push(this.mousePosition);
      }
      
      private function onMouseUpEventSub(param1:Boolean = false) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         this._scrollPos = new Array();
         this._scrollActive = false;
         if(param1)
         {
            return;
         }
         var _loc2_:Boolean = false;
         switch(this._navigationType)
         {
            case NAVIGATION_TYPE_NONE:
               if(this._lastMouseDownCoords != null)
               {
                  _loc3_ = this._lastMouseDownCoords.x - mouseX;
                  _loc4_ = this._lastMouseDownCoords.y - mouseY;
                  _loc5_ = BMDataManager.getInstance().getVectorSize(_loc3_,_loc4_);
                  if(_loc5_ <= 15)
                  {
                     _loc2_ = true;
                  }
               }
               break;
            default:
               if(Math.abs(this._scrollAbsoluteDelta) < 15)
               {
                  _loc2_ = true;
               }
         }
         if(_loc2_)
         {
            this.onMouseClickSub();
         }
      }
      
      private function fingerScrollingOnEnterFrame() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         if(this._scrollActive)
         {
            this._scrollPos.push(this.mousePosition);
            if(this._scrollPos.length > 10)
            {
               this._scrollPos.splice(0,1);
            }
            if(this._scrollPos.length > 1)
            {
               this._scrollAbsoluteDelta += Math.abs(this.mousePosition - this._scrollPos[this._scrollPos.length - 2]);
            }
         }
         if(this._scrollPos.length > 0)
         {
            _loc1_ = 0;
            _loc2_ = 1;
            while(_loc2_ < this._scrollPos.length)
            {
               _loc1_ += this._scrollPos[_loc2_] - this._scrollPos[_loc2_ - 1];
               _loc2_++;
            }
            _loc1_ /= this._scrollPos.length - 1;
            if(_loc1_ > this._scrollingSpeed)
            {
               if(_loc1_ > this._scrollingSpeed + 15)
               {
                  _loc1_ = this._scrollingSpeed + 15;
               }
            }
            else if(_loc1_ < this._scrollingSpeed - 15)
            {
               _loc1_ = this._scrollingSpeed - 15;
            }
            this._scrollingSpeed = _loc1_;
            if(this._scrollingSpeed > 50)
            {
               this._scrollingSpeed = 50;
            }
            else if(this._scrollingSpeed < -50)
            {
               this._scrollingSpeed = -50;
            }
         }
         else if(this._scrollingSpeed > 0)
         {
            this._scrollingSpeed -= 0.5;
            if(this._scrollingSpeed < 0)
            {
               this._scrollingSpeed = 0;
            }
         }
         else
         {
            this._scrollingSpeed += 0.5;
            if(this._scrollingSpeed > 0)
            {
               this._scrollingSpeed = 0;
            }
         }
         if(this._scrollingSpeed != 0)
         {
            this.mcItemsHolderPosition += this._scrollingSpeed;
            if(this.mcItemsHolderPosition > 0)
            {
               this.mcItemsHolderPosition = 0;
            }
            else if(this.mcItemsHolderPosition < -this._scrollMax)
            {
               this.mcItemsHolderPosition = -this._scrollMax;
            }
         }
      }
      
      public function onMouseClick(param1:MouseEvent) : void
      {
         this.onMouseClickSub();
      }
      
      public function onMouseClickSub() : void
      {
         var _loc1_:Boolean = false;
         switch(this._navigationType)
         {
            case NAVIGATION_TYPE_FINGER_SCROLLING:
               if(this._scrollActive)
               {
                  _loc1_ = true;
               }
               else if(this._scrollAbsoluteDelta < 50)
               {
                  _loc1_ = true;
               }
               break;
            case NAVIGATION_TYPE_NONE:
            case NAVIGATION_TYPE_BUTTONS:
               _loc1_ = true;
         }
         if(_loc1_ == false)
         {
            return;
         }
         if(Math.abs(this._scrollingSpeed) >= 2)
         {
            return;
         }
         var _loc2_:Number = this.getTargetPackageByPos(this.mousePosition - (this.mcHitAreaPosition + this.mcItemsHolderPosition));
         if(this._items[_loc2_] == null)
         {
            return;
         }
         var _loc3_:BMInterfaceItemView = this._items[_loc2_];
         if(_loc3_.isEnabled())
         {
            this.itemSelected(_loc3_.ID);
         }
      }
      
      public function getItemView(param1:uint) : BMInterfaceItemView
      {
         var _loc3_:BMInterfaceItemView = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._items.length)
         {
            _loc3_ = this._items[_loc2_];
            if(_loc3_ != null && _loc3_.ID == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      private function buttonsScrollingOnEnterFrame() : void
      {
         var _loc1_:Number = NaN;
         if(this._buttonScrollingActive == false)
         {
            return;
         }
         if(this._buttonScrollingDelayFrames > 0)
         {
            --this._buttonScrollingDelayFrames;
            return;
         }
         if(Math.abs(this.mcItemsHolderPosition - this._buttonScrollingTargetPos) < 1)
         {
            this._buttonScrollingActive = false;
            this.mcItemsHolderPosition = this._buttonScrollingTargetPos;
         }
         else
         {
            _loc1_ = (this._buttonScrollingTargetPos - this.mcItemsHolderPosition) * 0.15;
            this.mcItemsHolderPosition += _loc1_;
         }
      }
      
      private function setScrollerToSpecificItemSlot(param1:Number, param2:Boolean = false, param3:uint = 0) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         switch(this._navigationType)
         {
            case NAVIGATION_TYPE_NONE:
               break;
            case NAVIGATION_TYPE_FINGER_SCROLLING:
               _loc5_ = 0;
               _loc4_ = this._items.length - 1;
               param1 = Math.max(Math.min(param1,_loc4_),0);
               _loc5_ = -this.getItemPos(param1);
               _loc5_ = Math.min(Math.max(_loc5_,-this._scrollMax),0);
               this.mcItemsHolderPosition = _loc5_;
               break;
            case NAVIGATION_TYPE_BUTTONS:
               this._buttonScrollingTargetSlot = param1;
               _loc4_ = uint(this.getHighestItemSlotForButtonsScrolling());
               if(this._buttonScrollingTargetSlot > _loc4_)
               {
                  this._buttonScrollingTargetSlot = _loc4_;
               }
               else if(this._buttonScrollingTargetSlot < 0)
               {
                  this._buttonScrollingTargetSlot = 0;
               }
               if(this._buttonScrollingTargetSlot == 0)
               {
                  this.btnPrevious.disableMe();
               }
               else
               {
                  this.btnPrevious.enableMe();
               }
               if(this._buttonScrollingTargetSlot == _loc4_)
               {
                  this.btnNext.disableMe();
                  this._buttonScrollingTargetPos = this.mcVisibleAreaSize - this.getLastItemPos() - this.getLastItemSize();
               }
               else
               {
                  this.btnNext.enableMe();
                  this._buttonScrollingTargetPos = -this.getItemPos(this._buttonScrollingTargetSlot);
                  if(this._buttonScrollingTargetPos > 0)
                  {
                     this._buttonScrollingTargetPos = 0;
                  }
               }
               if(param2)
               {
                  this._buttonScrollingActive = true;
                  this._buttonScrollingDelayFrames = param3;
               }
               else if(param1 >= 99)
               {
                  this.mcItemsHolderPosition = this._buttonScrollingTargetPos - this.mcVisibleAreaSize;
               }
               if(!this.canScroll)
               {
                  this._buttonScrollingTargetPos = this._scrollMax / -2;
               }
               else if(this._buttonScrollingTargetPos < -this._scrollMax)
               {
                  this._buttonScrollingTargetPos = -this._scrollMax;
               }
         }
      }
      
      private function get canScroll() : *
      {
         return this._scrollMax > 0;
      }
      
      private function resetScroller() : void
      {
         switch(this._navigationType)
         {
            case NAVIGATION_TYPE_BUTTONS:
               this.setScrollerToSpecificItemSlot(99);
               this.setScrollerToSpecificItemSlot(0,true,8);
               break;
            case NAVIGATION_TYPE_FINGER_SCROLLING:
               this.onMouseUpEventSub(true);
               if(this._scrollMax < 0)
               {
                  this.mcItemsHolderPosition = this._scrollMax / -2;
               }
               else
               {
                  this.mcItemsHolderPosition = 0;
               }
               break;
            case NAVIGATION_TYPE_NONE:
               this.setScrollerToSpecificItemSlot(0);
         }
      }
      
      private function getViewClass(param1:Object) : Class
      {
         if(this._viewClassFunc != null)
         {
            return this._viewClassFunc(param1);
         }
         return this._viewClass;
      }
      
      public function setItems(param1:Array, param2:uint = 0) : void
      {
         var _loc4_:Class = null;
         var _loc5_:BMInterfaceItemView = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:MovieClip = null;
         if(this._viewClass == null && this._viewClassFunc == null)
         {
            TsLogger.log("ERROR BMHorizontalItemsScroller must run setViewClass or setViewClassFunction before setItems");
            return;
         }
         if(this._navigationType == 0)
         {
            TsLogger.log("ERROR BMHorizontalItemsScroller must run activateScrolling before setItems");
            return;
         }
         this._items = new Array();
         this._itemsSize = new Array();
         this._itemsPos = new Array();
         this._itemsPerPage = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = this.getViewClass(param1[_loc3_]);
            _loc5_ = new _loc4_();
            _loc5_.setData(param1[_loc3_]);
            _loc6_ = 0;
            if(_loc3_ > 0)
            {
               _loc6_ = this.getLastItemPos() + this.getLastItemSize();
            }
            _loc7_ = _loc5_.getItemWidth();
            if(this._navigationDirection == NAVIGATION_DIRECTION_VERTICAL)
            {
               _loc7_ = _loc5_.getItemHeight();
            }
            this._itemsSize.push(_loc7_);
            this._itemsPos.push(_loc6_);
            if(this.getItemPos(_loc3_) + this.getItemSize(_loc3_) < this.mcVisibleAreaSize)
            {
               ++this._itemsPerPage;
            }
            _loc8_ = _loc5_ as MovieClip;
            if(this._navigationDirection == NAVIGATION_DIRECTION_HORIZONTAL)
            {
               _loc8_.x = _loc6_;
            }
            else
            {
               _loc8_.y = _loc6_;
            }
            this.mcItemsHolder.addChild(_loc8_);
            this._items.push(_loc8_);
            _loc3_++;
         }
         this._itemsPerPage = Math.max(1,this._itemsPerPage);
         this._scrollMax = this.mcItemsHolderSize - this.mcVisibleAreaSize;
         if(param2 > 0)
         {
            switch(this._navigationType)
            {
               case NAVIGATION_TYPE_FINGER_SCROLLING:
                  this.setScrollerToSpecificItemSlot(param2);
                  break;
               case NAVIGATION_TYPE_BUTTONS:
                  this.setScrollerToSpecificItemSlot(99);
                  this.setScrollerToSpecificItemSlot(param2,true);
            }
         }
         else if(this._firstSetItems)
         {
            this.resetScroller();
         }
         this._firstSetItems = false;
      }
      
      private function getItemPos(param1:*) : Number
      {
         return this._itemsPos[param1];
      }
      
      private function getItemSize(param1:uint) : Number
      {
         return this._itemsSize[param1];
      }
      
      private function getLastItemPos() : Number
      {
         return this._itemsPos[this._itemsPos.length - 1];
      }
      
      private function getLastItemSize() : Number
      {
         return this._itemsSize[this._itemsSize.length - 1];
      }
      
      private function getTargetPackageByPos(param1:Number) : Number
      {
         var _loc2_:* = int(this._itemsPos.length - 1);
         while(_loc2_ >= 0)
         {
            if(param1 >= this.getItemPos(_loc2_))
            {
               return _loc2_;
            }
            _loc2_--;
         }
         return 0;
      }
      
      private function refreshItemsVisibility() : void
      {
         var _loc2_:BMInterfaceItemView = null;
         var _loc3_:MovieClip = null;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this._lastItemsHolderPos == this.mcItemsHolderPosition)
         {
            return;
         }
         this._lastItemsHolderPos = this.mcItemsHolderPosition;
         var _loc1_:uint = 0;
         while(_loc1_ < this._items.length)
         {
            _loc2_ = this._items[_loc1_];
            _loc3_ = _loc2_ as MovieClip;
            _loc4_ = false;
            _loc5_ = _loc3_.x;
            _loc6_ = _loc3_.width;
            if(this._navigationDirection == NAVIGATION_DIRECTION_VERTICAL)
            {
               _loc5_ = _loc3_.y;
               _loc6_ = _loc3_.height;
            }
            if(_loc5_ + _loc6_ + this.mcItemsHolderPosition > 0 && _loc5_ + this.mcItemsHolderPosition < this.mcVisibleAreaSize)
            {
               _loc4_ = true;
            }
            if(_loc4_)
            {
               if(_loc3_.parent == null)
               {
                  this.mcItemsHolder.addChild(_loc3_);
               }
            }
            else if(_loc3_.parent != null)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            _loc1_++;
         }
      }
      
      private function itemSelected(param1:uint) : void
      {
         if(this._itemSelectedFunction != null)
         {
            this._itemSelectedFunction(param1);
         }
         else
         {
            TsLogger.log("ERROR BMHorizontalItemsScroller use setItemSelectedFunction to set return function");
         }
      }
      
      private function get mousePosition() : Number
      {
         if(this._navigationDirection == NAVIGATION_DIRECTION_HORIZONTAL)
         {
            return mouseX;
         }
         return mouseY;
      }
      
      private function get mcItemsHolderPosition() : Number
      {
         if(this._navigationDirection == NAVIGATION_DIRECTION_HORIZONTAL)
         {
            return this.mcItemsHolder.x;
         }
         return this.mcItemsHolder.y;
      }
      
      private function get mcItemsHolderSize() : Number
      {
         if(this._navigationDirection == NAVIGATION_DIRECTION_HORIZONTAL)
         {
            return this.mcItemsHolder.width;
         }
         return this.mcItemsHolder.height;
      }
      
      private function get mcHitAreaPosition() : Number
      {
         if(this._navigationDirection == NAVIGATION_DIRECTION_HORIZONTAL)
         {
            return this.mcHitArea.x;
         }
         return this.mcHitArea.y;
      }
      
      private function set mcItemsHolderPosition(param1:Number) : void
      {
         if(this._navigationDirection == NAVIGATION_DIRECTION_HORIZONTAL)
         {
            this.mcItemsHolder.x = param1;
         }
         else
         {
            this.mcItemsHolder.y = param1;
         }
      }
      
      private function get mcVisibleAreaSize() : Number
      {
         if(this._navigationDirection == NAVIGATION_DIRECTION_HORIZONTAL)
         {
            return this.mcVisibleArea.width;
         }
         return this.mcVisibleArea.height;
      }
      
      private function removeAllItems() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMInterfaceItemView = null;
         var _loc3_:MovieClip = null;
         if(this._items != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._items.length)
            {
               _loc2_ = this._items[_loc1_];
               _loc2_.removeMe();
               _loc3_ = _loc2_ as MovieClip;
               if(_loc3_.parent != null)
               {
                  _loc3_.parent.removeChild(_loc3_);
               }
               this._items[_loc1_] = null;
               _loc1_++;
            }
         }
         this._items = null;
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeAllItems();
         removeEventListener(Event.ENTER_FRAME,this.enterFrameTrigger);
         this.mcHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownEvent);
         this.mcHitArea.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseUpEvent);
         this.mcHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpEvent);
         this.mcHitArea.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
   }
}

