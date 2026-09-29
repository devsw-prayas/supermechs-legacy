package net.battleMechsMulti.mobiles.dropdownList
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BMDropdownListRow extends MovieClip
   {
      
      private var _rowMC:MovieClip;
      
      private var _mouseHitArea:Sprite;
      
      private var _rowSlot:uint;
      
      private var _itemID:uint;
      
      private var _clickedFunction:Function;
      
      private var _mouseOverFunction:Function;
      
      private var _mouseOutFunction:Function;
      
      public function BMDropdownListRow()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:Sprite, param3:uint, param4:uint, param5:Function, param6:Function, param7:Function) : *
      {
         this._rowMC = param1;
         this._mouseHitArea = param2;
         this._rowSlot = param3;
         this._itemID = param4;
         this._clickedFunction = param5;
         this._mouseOverFunction = param6;
         this._mouseOutFunction = param7;
         this._mouseHitArea.addEventListener(MouseEvent.CLICK,this.hitAreaClicked);
         this._mouseHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.hitAreaMouseOver);
         this._mouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.hitAreaMouseOut);
         this._mouseHitArea.addEventListener(MouseEvent.MIDDLE_MOUSE_UP,this.hitAreaMouseOut);
         addChild(this._rowMC);
         addChild(this._mouseHitArea);
      }
      
      private function hitAreaClicked(param1:MouseEvent) : void
      {
         this._clickedFunction(this._rowSlot,this._itemID);
      }
      
      private function hitAreaMouseOver(param1:MouseEvent) : void
      {
         this._mouseOverFunction(this._rowSlot,this._itemID);
      }
      
      private function hitAreaMouseOut(param1:MouseEvent) : void
      {
         this._mouseOutFunction(this._rowSlot,this._itemID);
      }
      
      public function showMouseOverEffect() : void
      {
         this._rowMC.mcBackground.gotoAndStop("over");
      }
      
      public function showMouseOutEffect() : void
      {
         this._rowMC.mcBackground.gotoAndStop("out");
      }
      
      public function showCloseArrow() : void
      {
         this._rowMC.mcArrow.gotoAndStop("up");
      }
      
      public function showOpenArrow() : void
      {
         this._rowMC.mcArrow.gotoAndStop("down");
      }
      
      public function removeMe() : void
      {
         if(this._rowMC != null)
         {
            if(this._rowMC.parent != null)
            {
               this._rowMC.parent.removeChild(this._rowMC);
            }
            this._rowMC = null;
         }
         if(this._mouseHitArea != null)
         {
            this._mouseHitArea.removeEventListener(MouseEvent.CLICK,this.hitAreaClicked);
            this._mouseHitArea.removeEventListener(MouseEvent.MOUSE_OVER,this.hitAreaMouseOver);
            this._mouseHitArea.removeEventListener(MouseEvent.MOUSE_OUT,this.hitAreaMouseOut);
            this._mouseHitArea.removeEventListener(MouseEvent.MIDDLE_MOUSE_UP,this.hitAreaMouseOut);
            if(this._mouseHitArea.parent != null)
            {
               this._mouseHitArea.parent.removeChild(this._mouseHitArea);
            }
            this._mouseHitArea = null;
         }
      }
   }
}

