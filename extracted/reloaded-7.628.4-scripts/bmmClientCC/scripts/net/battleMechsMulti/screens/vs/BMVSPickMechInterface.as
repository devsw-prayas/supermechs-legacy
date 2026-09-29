package net.battleMechsMulti.screens.vs
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   public class BMVSPickMechInterface extends MovieClip
   {
      
      public var btnSelect:BMBasicButton;
      
      public var btnDeselect:BMBasicButton;
      
      public var mcMechBackground:MovieClip;
      
      public var mcOpponentSelectionStatus:MovieClip;
      
      public var mcHitArea:Sprite;
      
      public var mcMechHolder:Sprite;
      
      private var _selected:Boolean;
      
      private var _showButtons:Boolean;
      
      private var _selectionUpdateOutput:Function;
      
      private var _ID:uint;
      
      public function BMVSPickMechInterface()
      {
         super();
      }
      
      public function initialize(param1:uint = 0, param2:Boolean = false, param3:Boolean = false, param4:Function = null) : void
      {
         this._showButtons = param2;
         if(this._showButtons == false)
         {
            this.refreshButtons();
            this.mcMechBackground.gotoAndStop(2);
            return;
         }
         this._ID = param1;
         this.selected = param3;
         this._selectionUpdateOutput = param4;
         this.btnSelect.addEventListener(BMIntractable.HIT,this.selectClicked);
         this.btnDeselect.addEventListener(BMIntractable.HIT,this.deselectClicked);
         this.mcHitArea.addEventListener(MouseEvent.CLICK,this.hitAreaClicked);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function hitAreaClicked(param1:MouseEvent) : void
      {
         this.sendOutput();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.disableMe();
      }
      
      private function selectClicked(param1:Event) : void
      {
         this.sendOutput();
      }
      
      private function deselectClicked(param1:Event) : void
      {
         this.sendOutput();
      }
      
      private function sendOutput() : void
      {
         this._selectionUpdateOutput(this._ID,this._selected);
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         this.refreshButtons();
      }
      
      private function refreshButtons() : void
      {
         this.btnSelect.enableMe();
         this.btnDeselect.enableMe();
         if(this._showButtons == false)
         {
            this.btnSelect.visible = false;
            this.btnDeselect.visible = false;
            if(this._selected)
            {
               this.mcOpponentSelectionStatus.gotoAndStop(2);
            }
            return;
         }
         this.btnSelect.visible = false;
         this.btnDeselect.visible = false;
         if(this._selected)
         {
            this.btnDeselect.visible = true;
         }
         else
         {
            this.btnSelect.visible = true;
         }
      }
      
      public function disableMe() : void
      {
         this.btnSelect.disableMe();
         this.btnDeselect.disableMe();
         this.mcHitArea.removeEventListener(MouseEvent.CLICK,this.hitAreaClicked);
      }
   }
}

