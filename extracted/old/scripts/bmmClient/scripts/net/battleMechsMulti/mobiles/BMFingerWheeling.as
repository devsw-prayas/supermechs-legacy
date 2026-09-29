package net.battleMechsMulti.mobiles
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BMFingerWheeling extends BMBaseClass
   {
      
      private var _tileList:BMTileList;
      
      private var _mouseHitArea:Sprite;
      
      private var _clickedFunction:Function;
      
      private var _mouseDownFunction:Function;
      
      private var _allowXAxisDrag:Boolean;
      
      private var _fingerWheelingActive:Boolean = false;
      
      private var _fingerWheelingActiveLast:Boolean = false;
      
      private var _fingerWheelingActiveFrames:uint;
      
      private var _fingerWheelingOriginXPos:Number;
      
      private var _fingerWheelingOriginYPos:Number;
      
      private var _fingerWheelingTotalDrag:Number;
      
      private var _fingerWheelingLastXPos:Number;
      
      private var _fingerWheelingLastYPos:Number;
      
      private var _fingerWheelingXDeltas:Array;
      
      private var _fingerWheelingYDeltas:Array;
      
      private var _fingerWheelingLastDeltaY:Number = 0;
      
      private var _fingerWheelingDragTileID:Number;
      
      private var _fingerWheelingDragTileListItemID:Number;
      
      private var _tileListCanBeScrolled:Boolean = false;
      
      private var _setCanBeScrolledOnNextFrame:Boolean = false;
      
      private var _name:String;
      
      public var mouseListenersActive:Boolean = false;
      
      private const START_X_DRAG_MIN_PIXELS_PER_FRAME:uint = 6;
      
      public function BMFingerWheeling()
      {
         super();
      }
      
      public function initialize(param1:String, param2:BMTileList, param3:Sprite, param4:Function, param5:Function, param6:Boolean) : void
      {
         generateSingletonClassesPointers("");
         this._name = param1;
         this._tileList = param2;
         this._mouseHitArea = param3;
         this._clickedFunction = param4;
         this._mouseDownFunction = param5;
         this._allowXAxisDrag = param6;
         var _loc7_:Sprite = new Sprite();
         _loc7_.graphics.beginFill(0,0);
         _loc7_.graphics.drawRect(0,0,dataM.STAGE_WIDTH,dataM.STAGE_HEIGHT);
         addChild(_loc7_);
         _loc7_.visible = false;
         this.addMouseListeners();
      }
      
      public function removeMouseListeners() : void
      {
         this._mouseHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.fingerWheelingMouseDown);
         this._mouseHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.fingerWheelingMouseUp);
         this.mouseListenersActive = false;
      }
      
      public function addMouseListeners() : void
      {
         this._mouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.fingerWheelingMouseDown);
         this._mouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.fingerWheelingMouseUp);
         this.mouseListenersActive = true;
      }
      
      public function resetTileList(param1:BMTileList) : void
      {
         this._tileList = param1;
         this._setCanBeScrolledOnNextFrame = true;
      }
      
      public function tileListItemsModified() : void
      {
         this._setCanBeScrolledOnNextFrame = true;
      }
      
      private function fingerWheelingMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         if(this._tileList != null)
         {
            if(this._tileList.getRows() == 1)
            {
               this._tileList.moveItemsHolderAllowed = false;
            }
            _loc2_ = true;
            if(this._allowXAxisDrag && draggingM.item != null)
            {
               _loc2_ = false;
            }
            if(_loc2_)
            {
               this._fingerWheelingOriginXPos = mouseX;
               this._fingerWheelingOriginYPos = mouseY;
               this._fingerWheelingTotalDrag = 0;
               this._fingerWheelingLastXPos = mouseX;
               this._fingerWheelingLastYPos = mouseY;
               this._fingerWheelingLastDeltaY = 0;
               this._fingerWheelingXDeltas = new Array();
               this._fingerWheelingYDeltas = new Array();
               this._fingerWheelingActive = true;
               this._fingerWheelingActiveLast = false;
               _loc3_ = this._tileList.getItemIDInCoords(screensM.clientPointer.stage.mouseX - this._tileList.x,screensM.clientPointer.stage.mouseY - this._tileList.y - screensM.MOBILE_FINAL_BORDER_ADDON);
               this._fingerWheelingDragTileID = _loc3_[0];
               this._fingerWheelingDragTileListItemID = _loc3_[1];
               this._fingerWheelingActiveFrames = 0;
            }
         }
      }
      
      private function fingerWheelingMouseUp(param1:MouseEvent) : void
      {
      }
      
      public function cancelFingerWheeling() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:BMPlayerItemData = null;
         if(this._tileList != null)
         {
            if(this._fingerWheelingActive && this.mouseListenersActive)
            {
               this._fingerWheelingActive = false;
               if(this._clickedFunction != null)
               {
                  _loc1_ = this._fingerWheelingOriginXPos - mouseX;
                  _loc2_ = this._fingerWheelingOriginYPos - mouseY;
                  _loc3_ = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
                  if(_loc3_ < 10 && this._fingerWheelingTotalDrag < 10)
                  {
                     this._fingerWheelingLastDeltaY = 0;
                     this._fingerWheelingActiveLast = false;
                     _loc4_ = false;
                     if(this._allowXAxisDrag && this._fingerWheelingDragTileListItemID > -1)
                     {
                        _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._fingerWheelingDragTileListItemID);
                        this._mouseDownFunction(this._fingerWheelingDragTileID,this._fingerWheelingDragTileListItemID);
                        if(draggingM.item != null)
                        {
                           this._clickedFunction(this._fingerWheelingDragTileID,this._fingerWheelingDragTileListItemID);
                           _loc4_ = true;
                        }
                     }
                     else
                     {
                        this._clickedFunction(this._fingerWheelingDragTileID,this._fingerWheelingDragTileListItemID);
                        _loc4_ = true;
                     }
                     if(this._tileList != null)
                     {
                        if(_loc4_)
                        {
                           screensM.disableNextClickForMobile = true;
                           if(this._tileList.getRows() == 1)
                           {
                              this._tileList.moveItemsHolderAllowed = true;
                              this._tileList.jumpToRow(this._tileList.getItemRow(this._fingerWheelingDragTileID),true,"fingerWheeling");
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Boolean = false;
         var _loc15_:Number = NaN;
         if(this._tileList != null)
         {
            if(this._setCanBeScrolledOnNextFrame)
            {
               this._setCanBeScrolledOnNextFrame = false;
               this._tileListCanBeScrolled = true;
               if(this._tileList.getRows() >= this._tileList.getItemsAmount() / this._tileList.getColumns())
               {
                  this._tileListCanBeScrolled = false;
               }
            }
            if(this._fingerWheelingActive)
            {
               ++this._fingerWheelingActiveFrames;
               _loc2_ = mouseX - this._fingerWheelingLastXPos;
               _loc3_ = mouseY - this._fingerWheelingLastYPos;
               this._fingerWheelingXDeltas.push(_loc2_);
               this._fingerWheelingYDeltas.push(_loc3_);
               this._fingerWheelingTotalDrag += Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
               _loc4_ = _loc3_;
               _loc7_ = 6;
               _loc8_ = _loc2_;
               _loc9_ = _loc3_;
               if(draggingM.item == null)
               {
                  if(screensM.clientPointer.stage.mouseX < this._mouseHitArea.x || screensM.clientPointer.stage.mouseX > this._mouseHitArea.x + this._mouseHitArea.width || screensM.clientPointer.stage.mouseY < this._mouseHitArea.y + screensM.MOBILE_FINAL_BORDER_ADDON || screensM.clientPointer.stage.mouseY > this._mouseHitArea.y + this._mouseHitArea.height + screensM.MOBILE_FINAL_BORDER_ADDON)
                  {
                     this._fingerWheelingDragTileID = -1;
                     this._fingerWheelingDragTileListItemID = -1;
                  }
               }
               if(this._allowXAxisDrag && this._fingerWheelingDragTileID > -1 && this._fingerWheelingActiveFrames < 30)
               {
                  _loc6_ = this._fingerWheelingXDeltas.length - _loc7_;
                  if(_loc6_ < 0)
                  {
                     _loc6_ = 0;
                  }
                  _loc10_ = 0;
                  _loc5_ = _loc6_;
                  while(_loc5_ < this._fingerWheelingXDeltas.length)
                  {
                     if(_loc8_ < Math.abs(this._fingerWheelingXDeltas[_loc5_]))
                     {
                        _loc8_ = Math.abs(this._fingerWheelingXDeltas[_loc5_]);
                     }
                     if(_loc5_ > this._fingerWheelingXDeltas.length - 10)
                     {
                        _loc10_ += this._fingerWheelingXDeltas[_loc5_];
                     }
                     _loc5_++;
                  }
                  _loc6_ = this._fingerWheelingYDeltas.length - _loc7_;
                  if(_loc6_ < 0)
                  {
                     _loc6_ = 0;
                  }
                  _loc5_ = _loc6_;
                  while(_loc5_ < this._fingerWheelingYDeltas.length)
                  {
                     if(_loc9_ < Math.abs(this._fingerWheelingYDeltas[_loc5_]))
                     {
                        _loc9_ = Math.abs(this._fingerWheelingYDeltas[_loc5_]);
                     }
                     _loc5_++;
                  }
                  _loc11_ = false;
                  if(this._fingerWheelingXDeltas.length >= 1 && _loc8_ == 0 && _loc9_ == 0)
                  {
                     _loc11_ = true;
                  }
                  if(_loc9_ == 0)
                  {
                     _loc12_ = 100;
                  }
                  else
                  {
                     _loc12_ = Math.abs(_loc8_ / _loc9_);
                  }
                  if(_loc12_ > 1.5 || _loc11_)
                  {
                     _loc13_ = this.START_X_DRAG_MIN_PIXELS_PER_FRAME;
                     _loc14_ = false;
                     if(Math.abs(_loc8_) <= _loc13_)
                     {
                        if(Math.abs(_loc10_) > _loc13_)
                        {
                           _loc14_ = true;
                        }
                     }
                     else if(Math.abs(_loc8_) > _loc13_)
                     {
                        _loc14_ = true;
                     }
                     if(this._fingerWheelingDragTileID > -1 && (_loc14_ || _loc11_) && draggingM.item == null)
                     {
                        if(this._mouseDownFunction != null)
                        {
                           this._mouseDownFunction(this._fingerWheelingDragTileID,this._fingerWheelingDragTileListItemID);
                        }
                        this._fingerWheelingActive = false;
                        if(this._tileListCanBeScrolled)
                        {
                           this._tileList.scroller.scrollerMouseUpSub();
                           if(this._tileList.getRows() == 1)
                           {
                              this._tileList.moveItemsHolderAllowed = true;
                           }
                        }
                     }
                  }
               }
               if(this._fingerWheelingActive)
               {
                  _loc6_ = this._fingerWheelingYDeltas.length - _loc7_;
                  if(_loc6_ < 0)
                  {
                     _loc6_ = 0;
                  }
                  _loc5_ = _loc6_;
                  while(_loc5_ < this._fingerWheelingYDeltas.length)
                  {
                     if(_loc4_ > 0)
                     {
                        if(_loc4_ < this._fingerWheelingYDeltas[_loc5_])
                        {
                           _loc4_ = Number(this._fingerWheelingYDeltas[_loc5_]);
                        }
                     }
                     else if(_loc4_ > this._fingerWheelingYDeltas[_loc5_])
                     {
                        _loc4_ = Number(this._fingerWheelingYDeltas[_loc5_]);
                     }
                     _loc5_++;
                  }
                  _loc15_ = 50;
                  if(_loc4_ > _loc15_)
                  {
                     _loc4_ = _loc15_;
                  }
                  else if(_loc4_ < -_loc15_)
                  {
                     _loc4_ = -_loc15_;
                  }
                  this._fingerWheelingLastDeltaY = _loc4_;
                  this._fingerWheelingLastXPos = mouseX;
                  this._fingerWheelingLastYPos = mouseY;
                  if(this._tileListCanBeScrolled)
                  {
                     _loc1_ = this._tileList.scroller.getScrollPosition();
                     this._tileList.scroller.setScrollPosition(_loc1_ - _loc4_ / this._tileList.getItemsHolderHeight());
                     this._tileList.scroller.sendScrollRatio();
                  }
               }
            }
            else if(this._fingerWheelingLastDeltaY > 0)
            {
               --this._fingerWheelingLastDeltaY;
               if(this._tileListCanBeScrolled)
               {
                  _loc1_ = this._tileList.scroller.getScrollPosition();
                  this._tileList.scroller.setScrollPosition(_loc1_ - this._fingerWheelingLastDeltaY / this._tileList.getItemsHolderHeight());
                  this._tileList.scroller.sendScrollRatio();
                  if(this._fingerWheelingLastDeltaY <= 0 || _loc1_ == 0)
                  {
                     this._fingerWheelingLastDeltaY = 0;
                     this._tileList.scroller.scrollerMouseUpSub();
                     if(this._tileList.getRows() == 1)
                     {
                        this._tileList.moveItemsHolderAllowed = true;
                     }
                  }
               }
            }
            else if(this._fingerWheelingLastDeltaY < 0)
            {
               ++this._fingerWheelingLastDeltaY;
               if(this._tileListCanBeScrolled)
               {
                  _loc1_ = this._tileList.scroller.getScrollPosition();
                  this._tileList.scroller.setScrollPosition(_loc1_ - this._fingerWheelingLastDeltaY / this._tileList.getItemsHolderHeight());
                  this._tileList.scroller.sendScrollRatio();
                  if(this._fingerWheelingLastDeltaY >= 0 || _loc1_ == 1)
                  {
                     this._fingerWheelingLastDeltaY = 0;
                     this._tileList.scroller.scrollerMouseUpSub();
                     if(this._tileList.getRows() == 1)
                     {
                        this._tileList.moveItemsHolderAllowed = true;
                     }
                  }
               }
            }
            else if(this._fingerWheelingActiveLast)
            {
               if(this._tileListCanBeScrolled)
               {
                  this._tileList.scroller.scrollerMouseUpSub();
                  if(this._tileList.getRows() == 1)
                  {
                     this._tileList.moveItemsHolderAllowed = true;
                  }
               }
            }
            this._fingerWheelingActiveLast = this._fingerWheelingActive;
         }
      }
      
      public function wheelingActive() : Boolean
      {
         return this._fingerWheelingActive;
      }
      
      public function afterWheelingActive() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this._fingerWheelingLastDeltaY != 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
   }
}

