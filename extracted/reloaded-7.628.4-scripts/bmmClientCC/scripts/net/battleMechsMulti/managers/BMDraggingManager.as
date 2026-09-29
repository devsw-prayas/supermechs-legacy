package net.battleMechsMulti.managers
{
   import flash.events.MouseEvent;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItem;
   
   public class BMDraggingManager extends BMBaseClass
   {
      
      private static var _instance:BMDraggingManager;
      
      private static var _allowInstantiation:Boolean;
      
      private var _item:BMItem;
      
      private var _dragAfterMouseMoved:Boolean;
      
      private var _draggingHandler:Boolean = false;
      
      public var dragOrigin:String;
      
      public var dragTileID:Number;
      
      public var dragEquipmentType:String;
      
      public var dragEquipmentID:Number;
      
      public var dragMechID:Number;
      
      public function BMDraggingManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMDraggingManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : BMDraggingManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMDraggingManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("draggingManager");
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.draggingHandler();
      }
      
      public function activateDragging(param1:BMItem, param2:Boolean) : void
      {
         this._item = param1;
         this._dragAfterMouseMoved = param2;
         if(this._dragAfterMouseMoved)
         {
            screensM.stagePointer.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoved);
         }
         else
         {
            this.activateDraggingSub();
         }
      }
      
      private function activateDraggingSub() : void
      {
         addChild(this._item);
         this._draggingHandler = true;
      }
      
      public function deactivateDragging() : void
      {
         if(this._item == null)
         {
            return;
         }
         this._item.removeMe();
         if(this._item.parent != null)
         {
            removeChild(this._item);
         }
         this._item = null;
         this._draggingHandler = false;
         screensM.stagePointer.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoved);
      }
      
      private function draggingHandler() : void
      {
         if(this._draggingHandler)
         {
            this._item.x = screensM.stagePointer.mouseX;
            this._item.y = screensM.stagePointer.mouseY;
         }
      }
      
      private function mouseMoved(param1:MouseEvent) : void
      {
         screensM.stagePointer.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoved);
         this.activateDraggingSub();
      }
      
      public function get item() : BMItem
      {
         return this._item;
      }
   }
}

