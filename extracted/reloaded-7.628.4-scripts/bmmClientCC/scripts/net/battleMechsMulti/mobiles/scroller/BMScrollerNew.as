package net.battleMechsMulti.mobiles.scroller
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.managers.BMScreensManager;
   
   public class BMScrollerNew extends MovieClip
   {
      
      public var mcScrollerButton:Sprite;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcScrollerRange:Sprite;
      
      public var mcFill:Sprite;
      
      private var mcFillMask:Sprite;
      
      private var _callbackFunction:Function;
      
      private var _wholeNumbers:uint = 0;
      
      public function BMScrollerNew()
      {
         super();
         this.initFill();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
      }
      
      private function addedToStage(param1:Event) : void
      {
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      public function setCallback(param1:Function) : void
      {
         this._callbackFunction = param1;
         this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.scrollerMouseDown);
         this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.scrollerMouseUp);
         this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.scrollerClick);
         this.mcMouseHitArea.addEventListener(MouseEvent.RELEASE_OUTSIDE,this.scrollerMouseUp);
         this.refreshScrollerButtonPosition();
      }
      
      public function setWholeNumbers(param1:uint) : void
      {
         this._wholeNumbers = param1;
         if(this._wholeNumbers < 1)
         {
            trace("Scroller error: whole numbers variable must be 1 or greater");
         }
      }
      
      private function fireCallback() : void
      {
         var _loc1_:Number = this.getButtonPosition();
         if(this._wholeNumbers == 0)
         {
            this._callbackFunction(_loc1_);
         }
         else
         {
            this._callbackFunction(this.getWholeNumberByPosition(_loc1_));
         }
      }
      
      private function getButtonPosition() : Number
      {
         var _loc1_:Number = (this.mcScrollerButton.x - this.mcScrollerRange.x) / this.mcScrollerRange.width;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         else if(_loc1_ > 1)
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      private function getWholeNumberByPosition(param1:Number) : uint
      {
         return Math.round(param1 * this._wholeNumbers);
      }
      
      private function scrollerClick(param1:MouseEvent) : void
      {
         if(BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         this.refreshScrollerButtonPosition(true);
      }
      
      private function scrollerMouseUp(param1:MouseEvent) : void
      {
         if(BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         removeEventListener(Event.ENTER_FRAME,this.scrollerButtonOnEnterFrame);
         this.refreshScrollerButtonPosition(true);
      }
      
      private function scrollerMouseDown(param1:MouseEvent) : void
      {
         if(BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         addEventListener(Event.ENTER_FRAME,this.scrollerButtonOnEnterFrame);
      }
      
      private function scrollerButtonOnEnterFrame(param1:Event) : void
      {
         this.refreshScrollerButtonPosition();
         this.fireCallback();
      }
      
      private function refreshScrollerButtonPosition(param1:Boolean = false) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc2_:Number = mouseX;
         if(_loc2_ > this.mcScrollerRange.x + this.mcScrollerRange.width)
         {
            _loc2_ = this.mcScrollerRange.x + this.mcScrollerRange.width;
         }
         else if(_loc2_ < this.mcScrollerRange.x)
         {
            _loc2_ = this.mcScrollerRange.x;
         }
         if(param1 && this._wholeNumbers > 0)
         {
            _loc3_ = this.getButtonPosition();
            _loc4_ = this.getWholeNumberByPosition(_loc3_);
            this.setScrollerButtonToWholeNumber(_loc4_);
         }
         else
         {
            this.mcScrollerButton.x = _loc2_;
         }
         this.refreshFill();
      }
      
      private function setScrollerButtonToWholeNumber(param1:uint) : void
      {
         this.mcScrollerButton.x = this.mcScrollerRange.x + param1 / this._wholeNumbers * this.mcScrollerRange.width;
      }
      
      private function initFill() : void
      {
         if(this.mcFill == null)
         {
            return;
         }
         this.mcFillMask = new Sprite();
         this.mcFillMask.graphics.beginFill(0);
         this.mcFillMask.graphics.drawRect(0,0,this.mcFill.width,this.mcFill.height);
         this.mcFill.mask = this.mcFillMask;
         this.mcFill.addChild(this.mcFillMask);
      }
      
      private function refreshFill() : void
      {
         if(this.mcFill == null)
         {
            return;
         }
         this.mcFillMask.scaleX = this.getButtonPosition();
      }
      
      public function resetSelection(param1:uint = 0) : void
      {
         this.mcScrollerButton.x = this.mcScrollerRange.x;
         if(param1 > 0)
         {
            this.setScrollerButtonToWholeNumber(param1);
         }
         this.refreshScrollerButtonPosition(true);
      }
      
      public function disableMe() : void
      {
         alpha = 0.5;
         this.removeAllListeners();
      }
      
      private function removeAllListeners() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.scrollerButtonOnEnterFrame);
         this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.scrollerMouseDown);
         this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.scrollerMouseUp);
         this.mcMouseHitArea.removeEventListener(MouseEvent.CLICK,this.scrollerClick);
         this.mcMouseHitArea.removeEventListener(MouseEvent.RELEASE_OUTSIDE,this.scrollerMouseUp);
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeAllListeners();
         if(this.mcScrollerButton != null)
         {
            this.mcScrollerButton.parent.removeChild(this.mcScrollerButton);
            this.mcScrollerButton = null;
         }
         if(this.mcMouseHitArea != null)
         {
            this.mcMouseHitArea.parent.removeChild(this.mcMouseHitArea);
            this.mcMouseHitArea = null;
         }
      }
   }
}

