package net.tacticsoft.utils
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class LongPressListener extends EventDispatcher
   {
      
      public static const EVENT_LONG_PRESS:String = "LongPress";
      
      private var _intervalMilliseconds:Number;
      
      private var _callback:Function;
      
      private var _lastMouseDownTime:int;
      
      private var _expectingUp:Boolean = false;
      
      public function LongPressListener(param1:Sprite, param2:int)
      {
         super();
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownDetector);
         param1.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpDetector);
         param1.addEventListener(MouseEvent.RELEASE_OUTSIDE,this.releaseOutsideDetector);
         this._intervalMilliseconds = param2;
      }
      
      private function mouseDownDetector(param1:MouseEvent) : void
      {
         this._lastMouseDownTime = getTimer();
         this._expectingUp = true;
      }
      
      private function releaseOutsideDetector(param1:MouseEvent) : void
      {
         this._expectingUp = false;
      }
      
      public function ignoreNextRelease() : void
      {
         this._expectingUp = false;
      }
      
      private function mouseUpDetector(param1:MouseEvent) : void
      {
         if(!this._expectingUp)
         {
            return;
         }
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this._lastMouseDownTime;
         if(_loc3_ > this._intervalMilliseconds)
         {
            dispatchEvent(new Event(EVENT_LONG_PRESS));
         }
         this._expectingUp = false;
      }
   }
}

