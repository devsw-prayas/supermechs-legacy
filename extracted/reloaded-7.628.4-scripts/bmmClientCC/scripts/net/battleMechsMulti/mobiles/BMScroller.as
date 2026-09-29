package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton_scrollerDown;
   import net.battleMechsMulti.mobiles.buttons.BMButton_scrollerUp;
   
   public class BMScroller extends MovieClip
   {
      
      private var _scrolledFunction:Function;
      
      private var _scrollingEndedFunction:Function;
      
      private var _scrolledButtonUp:Function;
      
      private var _scrolledButtonDown:Function;
      
      private var _scrollerSizeRatio:Number;
      
      private var _scrollRatio:Number;
      
      private var _scrollerYStart:Number;
      
      private var _scrollerYEnd:Number;
      
      private var _hasScrollerGfx:Boolean;
      
      private var _scrollerEnabled:Boolean;
      
      private var _runAsMobile:Boolean;
      
      private var scrollerBorders:Rectangle;
      
      private var scroller:MovieClip;
      
      private var scrollerBackground:MovieClip;
      
      private var btnScrollToStart:BMButton_scrollerUp;
      
      private var btnScrollToEnd:BMButton_scrollerDown;
      
      public var duringInteraction:Boolean = false;
      
      private const SCROLLER_BUTTON_SIZE:Number = 40;
      
      private const SCROLLER_MINIMAL_HEIGHT:Number = 20;
      
      private const SCROLLER_WIDTH:Number = 40;
      
      private const DISABLED_ALPHA:Number = 0.4;
      
      public function BMScroller()
      {
         super();
      }
      
      public function initialize(param1:Stage, param2:Number, param3:Number, param4:MovieClip, param5:Function, param6:Function, param7:Function, param8:Function, param9:Boolean, param10:Boolean, param11:String = "") : void
      {
         this._scrolledFunction = param5;
         this._scrollingEndedFunction = param6;
         this._scrolledButtonUp = param7;
         this._scrolledButtonDown = param8;
         this._scrollerSizeRatio = param3;
         this._runAsMobile = param10;
         this._scrollRatio = 0;
         this.btnScrollToStart = new BMButton_scrollerUp();
         this.btnScrollToEnd = new BMButton_scrollerDown();
         this.btnScrollToStart.initialize("","",null,[],this.buttonUpClicked,this._runAsMobile);
         this.btnScrollToEnd.initialize("","",null,[],this.buttonDownClicked,this._runAsMobile);
         this.btnScrollToStart.width = this.SCROLLER_BUTTON_SIZE;
         this.btnScrollToStart.height = this.SCROLLER_BUTTON_SIZE;
         this.btnScrollToEnd.width = this.SCROLLER_BUTTON_SIZE;
         this.btnScrollToEnd.height = this.SCROLLER_BUTTON_SIZE;
         this.btnScrollToEnd.y = param2 - this.SCROLLER_BUTTON_SIZE;
         if(param11 == "mythical")
         {
            this.btnScrollToStart.mcBackground.gotoAndStop("mythical");
            this.btnScrollToEnd.mcBackground.gotoAndStop("mythical");
         }
         this.scrollerBackground = new MovieClip();
         this.scrollerBackground.graphics.beginFill(0,0);
         this.scrollerBackground.graphics.drawRect(0,0,this.SCROLLER_BUTTON_SIZE,param2 - this.SCROLLER_BUTTON_SIZE * 2);
         this.scrollerBackground.y = this.SCROLLER_BUTTON_SIZE;
         if(param9 == false)
         {
            this.scrollerBackground.addEventListener(MouseEvent.CLICK,this.scrollerBackgroundClicked);
         }
         addChild(this.scrollerBackground);
         addChild(this.btnScrollToStart);
         addChild(this.btnScrollToEnd);
         graphics.beginFill(0,0.3);
         graphics.drawRect(0,0,this.SCROLLER_BUTTON_SIZE,param2);
         this._scrollerYStart = this.SCROLLER_BUTTON_SIZE;
         this._scrollerYEnd = this.btnScrollToEnd.y;
         var _loc12_:Number = (this._scrollerYEnd - this._scrollerYStart) * this._scrollerSizeRatio;
         if(_loc12_ < this.SCROLLER_MINIMAL_HEIGHT)
         {
            _loc12_ = this.SCROLLER_MINIMAL_HEIGHT;
         }
         if(param4 != null)
         {
            this.scroller = param4;
            this.scroller.width = this.SCROLLER_WIDTH;
            this.scroller.height = _loc12_;
            this._hasScrollerGfx = true;
         }
         else
         {
            this.scroller = new MovieClip();
            this.scroller.graphics.beginFill(14537523,1);
            this.scroller.graphics.drawRect(0,0,this.SCROLLER_WIDTH,_loc12_);
            this.scroller.graphics.endFill();
            this._hasScrollerGfx = false;
         }
         this.scroller.y = this._scrollerYStart;
         if(param9 == false)
         {
            this.scroller.addEventListener(MouseEvent.MOUSE_DOWN,this.scrollerMouseDown);
            this.scroller.addEventListener(MouseEvent.MOUSE_UP,this.scrollerMouseUp);
            param1.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpOnStage);
         }
         addChild(this.scroller);
         this.refreshScrollerBorders();
         this._scrollerEnabled = true;
         if(param9)
         {
            visible = false;
         }
      }
      
      private function scrollerBackgroundClicked(param1:MouseEvent) : void
      {
         if(BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         var _loc2_:Number = Number(param1.target.mouseY);
         if(_loc2_ < this.scroller.y - this.SCROLLER_BUTTON_SIZE)
         {
            this.buttonUpClicked();
            this.buttonUpClicked();
         }
         else
         {
            this.buttonDownClicked();
            this.buttonDownClicked();
         }
      }
      
      private function buttonUpClicked() : void
      {
         if(BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         this._scrolledButtonUp();
      }
      
      private function buttonDownClicked() : void
      {
         if(BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         this._scrolledButtonDown();
      }
      
      private function scrollerMouseDown(param1:MouseEvent) : void
      {
         if(BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         if(this._scrollerEnabled == false)
         {
            return;
         }
         this.scroller.startDrag(false,this.scrollerBorders);
         addEventListener(Event.ENTER_FRAME,this.dragScrollerOnEnterFrame);
         this.duringInteraction = true;
      }
      
      private function scrollerMouseUp(param1:MouseEvent) : void
      {
         if(BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         if(this._scrollerEnabled == false)
         {
            return;
         }
         this.scrollerMouseUpSub();
         this.duringInteraction = false;
      }
      
      private function dragScrollerOnEnterFrame(param1:Event) : void
      {
         this._scrollRatio = (this.scroller.y - this._scrollerYStart) / this.scrollerBorders.height;
         if(this._scrollRatio < 0.01)
         {
            this._scrollRatio = 0;
         }
         else if(this._scrollRatio > 0.99)
         {
            this._scrollRatio = 1;
         }
         this.sendScrollRatio();
      }
      
      public function setScrollPosition(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 1)
         {
            param1 = 1;
         }
         this._scrollRatio = param1;
         this.updateScrollerPosition("setScrollPosition");
      }
      
      public function getScrollPosition() : Number
      {
         return this._scrollRatio;
      }
      
      private function updateScrollerPosition(param1:String) : void
      {
         this.scroller.y = this._scrollerYStart + this.scrollerBorders.height * this._scrollRatio;
      }
      
      private function mouseUpOnStage(param1:MouseEvent) : void
      {
         if(this.duringInteraction)
         {
            this.scrollerMouseUpSub();
         }
      }
      
      public function scrollerMouseUpSub() : void
      {
         this.scroller.stopDrag();
         removeEventListener(Event.ENTER_FRAME,this.dragScrollerOnEnterFrame);
         this._scrollingEndedFunction();
      }
      
      private function refreshScrollerBorders() : void
      {
         var _loc1_:Number = (this._scrollerYEnd - this._scrollerYStart) * this._scrollerSizeRatio;
         var _loc2_:Number = this._scrollerYEnd - this._scrollerYStart - _loc1_;
         this.scrollerBorders = new Rectangle(0,this._scrollerYStart,0,_loc2_);
      }
      
      public function refreshScrollerSizeRatio(param1:Number, param2:Boolean) : void
      {
         this._scrollerSizeRatio = param1;
         var _loc3_:Number = (this._scrollerYEnd - this._scrollerYStart) * this._scrollerSizeRatio;
         if(_loc3_ < this.SCROLLER_MINIMAL_HEIGHT)
         {
            this._scrollerSizeRatio *= this.SCROLLER_MINIMAL_HEIGHT / _loc3_;
            _loc3_ = this.SCROLLER_MINIMAL_HEIGHT;
         }
         if(this._hasScrollerGfx)
         {
            this.scroller.height = _loc3_;
         }
         else
         {
            this.scroller.graphics.clear();
            this.scroller.graphics.beginFill(14537523,1);
            this.scroller.graphics.drawRect(0,0,this.SCROLLER_WIDTH,_loc3_);
            this.scroller.graphics.endFill();
         }
         this._scrollRatio = 0;
         if(param2)
         {
            this.sendScrollRatio();
         }
         this.updateScrollerPosition("refreshScrollerSizeRatio");
         this.refreshScrollerBorders();
      }
      
      public function enableMe() : void
      {
         this._scrollerEnabled = true;
         this.scroller.alpha = 1;
         this.btnScrollToStart.enableMe();
         this.btnScrollToEnd.enableMe();
         this.scrollerBackground.visible = true;
      }
      
      public function disableMe() : void
      {
         this._scrollerEnabled = false;
         this.scroller.alpha = this.DISABLED_ALPHA;
         this.btnScrollToStart.disableMe();
         this.btnScrollToEnd.disableMe();
         removeEventListener(Event.ENTER_FRAME,this.dragScrollerOnEnterFrame);
         this.scrollerBackground.visible = false;
      }
      
      public function sendScrollRatio() : void
      {
         if(this._scrollRatio > 1)
         {
            this._scrollRatio = 1;
         }
         else if(this._scrollRatio < 0)
         {
            this._scrollRatio = 0;
         }
         this._scrolledFunction(this._scrollRatio);
      }
      
      public function removeMe() : void
      {
         this.btnScrollToStart.buttonCore.removeMe();
         this.btnScrollToEnd.buttonCore.removeMe();
         this.scroller.removeEventListener(MouseEvent.MOUSE_DOWN,this.scrollerMouseDown);
         this.scroller.removeEventListener(MouseEvent.MOUSE_UP,this.scrollerMouseUp);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

