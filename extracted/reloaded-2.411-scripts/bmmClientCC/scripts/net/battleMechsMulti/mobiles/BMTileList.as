package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.tacticsoft.utils.FunctionCall;
   
   public class BMTileList extends Sprite
   {
      
      private var interfaceFrameHolder:Sprite;
      
      private var guideArrowHolder:Sprite;
      
      private var scrollerHolder:Sprite;
      
      private var mainHolder:Sprite;
      
      private var itemsHolder:Sprite;
      
      private var headerHolder:Sprite;
      
      private var maskHolder:Sprite;
      
      private var backgroundHitArea:Sprite;
      
      private var interfaceFrame:Sprite;
      
      private var listHeader:MovieClip;
      
      private var _items:Array;
      
      private var _rows:Number;
      
      private var _columns:Number;
      
      private var _itemWidth:Number;
      
      private var _itemHeight:Number;
      
      private var _stage:Stage;
      
      private var _highestTileID:Number;
      
      private var _backgroundMouseUp:Function;
      
      private var _rescrollValue:Number;
      
      private var _headerHeight:Number;
      
      private var _runAsMobile:Boolean;
      
      private var _specialSkin:String;
      
      private var _currentRow:Number;
      
      private var _useScroller:Boolean;
      
      private var _scrollerContent:MovieClip;
      
      private var _itemsHolderTargetYPos:Number;
      
      private var _guideArrowTileID:Number;
      
      private var _scrollerSizeRatio:Number;
      
      private var _activateAnimatedMarkerSlot:Number = -1;
      
      private var _activateAnimatedMarkerDelayFrames:Number = 0;
      
      private var _manageItemsInView:Boolean;
      
      private var _lastVisualRow:Number;
      
      private var _itemsListenersRemoved:Boolean = false;
      
      private var _scrollerInvisibleMode:Boolean = false;
      
      private var _itemsExceedOnePage:Boolean = false;
      
      private var _scrollerAlignRight:Boolean = true;
      
      public var moveItemsHolderAllowed:Boolean = true;
      
      public var scroller:BMScroller;
      
      public var loadAssetsFunction:Function;
      
      public var _extendedMode:Boolean = false;
      
      public var _extendedMode_itemHeightRatio:Number = 0;
      
      public var _extendedMode_bottomOnly:Boolean = false;
      
      private var guideArrow:MovieClip;
      
      private const INTERFACE_FRAME_THICKNESS:Number = 7;
      
      private const INTERFACE_FRAME_SCROLLER_ADDON:Number = 40;
      
      private var MAX_ITEMS_DISPLAYED_PER_FRAME:Number = 2;
      
      private var _numOfEmptyItems:int = 0;
      
      public function BMTileList()
      {
         super();
      }
      
      public function initialize(param1:Stage, param2:Array, param3:Number, param4:Number, param5:Number, param6:Number, param7:Function, param8:Boolean, param9:MovieClip, param10:Sprite, param11:MovieClip, param12:Boolean, param13:Number, param14:Number, param15:Boolean, param16:Boolean, param17:Boolean, param18:String = "", param19:Boolean = true) : void
      {
         var _loc22_:BMTileListItem = null;
         this._stage = param1;
         this._items = param2;
         this._rows = param3;
         this._columns = param4;
         this._itemWidth = param5;
         this._itemHeight = param6;
         this._scrollerSizeRatio = param14;
         this._manageItemsInView = param15;
         this._scrollerInvisibleMode = param16;
         this._runAsMobile = param17;
         this._specialSkin = param18;
         this._backgroundMouseUp = param7;
         this.interfaceFrame = param10;
         this.listHeader = param11;
         this._useScroller = param8;
         this._scrollerContent = param9;
         this._scrollerAlignRight = param19;
         this.refreshTileIDs();
         this.interfaceFrameHolder = new Sprite();
         this.mainHolder = new Sprite();
         this.itemsHolder = new Sprite();
         this.headerHolder = new Sprite();
         this.maskHolder = new Sprite();
         this.backgroundHitArea = new Sprite();
         this.guideArrowHolder = new Sprite();
         this.scrollerHolder = new Sprite();
         addChild(this.interfaceFrameHolder);
         addChild(this.mainHolder);
         addChild(this.scrollerHolder);
         addChild(this.guideArrowHolder);
         this.guideArrowHolder.mouseEnabled = false;
         this.guideArrowHolder.mouseChildren = false;
         this.mainHolder.addChild(this.backgroundHitArea);
         this.mainHolder.addChild(this.itemsHolder);
         this.mainHolder.addChild(this.headerHolder);
         var _loc20_:uint = 1;
         var _loc21_:uint = 1;
         this._headerHeight = 0;
         if(this.listHeader != null)
         {
            this._headerHeight = this.listHeader.height;
            this.itemsHolder.y += this._headerHeight;
            this.backgroundHitArea.y += this._headerHeight;
            this.maskHolder.y += this._headerHeight;
            this.headerHolder.addChild(this.listHeader);
         }
         var _loc23_:int = int(this._items.length);
         var _loc24_:uint = 0;
         while(_loc24_ < _loc23_)
         {
            _loc22_ = this._items[_loc24_];
            if(_loc21_ > this._columns)
            {
               _loc21_ = 1;
               _loc20_++;
            }
            _loc22_.x = (_loc21_ - 1) * _loc22_.width;
            _loc22_.y = (_loc20_ - 1) * _loc22_.height;
            _loc21_++;
            _loc24_++;
         }
         if(param12)
         {
            this.backgroundHitArea.graphics.beginFill(0,0.9);
         }
         else
         {
            this.backgroundHitArea.graphics.beginFill(0,0);
         }
         this.backgroundHitArea.graphics.drawRect(0,0,this._itemWidth * this._columns,this._itemHeight * this._rows);
         this.backgroundHitArea.graphics.endFill();
         if(this._runAsMobile == false)
         {
            this.backgroundHitArea.addEventListener(MouseEvent.MOUSE_UP,this.backgroundMouseUp);
         }
         this.maskHolder.graphics.beginFill(0,0);
         if(this._extendedMode)
         {
            if(this._extendedMode_bottomOnly)
            {
               this.maskHolder.graphics.drawRect(0,0,this._itemWidth * this._columns,this._itemHeight * (this._rows + this._extendedMode_itemHeightRatio));
            }
            else
            {
               this.maskHolder.graphics.drawRect(0,0,this._itemWidth * this._columns,this._itemHeight * (this._rows + 2 * this._extendedMode_itemHeightRatio));
            }
         }
         else
         {
            this.maskHolder.graphics.drawRect(0,0,this._itemWidth * this._columns,this._itemHeight * this._rows);
         }
         this.maskHolder.graphics.endFill();
         if(this._extendedMode)
         {
            if(!this._extendedMode_bottomOnly)
            {
               this.maskHolder.y -= this._itemHeight * this._extendedMode_itemHeightRatio;
            }
         }
         addChild(this.maskHolder);
         this.itemsHolder.mask = this.maskHolder;
         this.createInterfaceFrame();
         this.refreshScroller(true,"initialize");
         this._currentRow = 0;
         this._itemsHolderTargetYPos = this.itemsHolder.y;
         this._lastVisualRow = -1;
         if(param13 > 0)
         {
            this._currentRow = param13;
            this.jumpToRow(this._currentRow,false,"initialize");
         }
         else
         {
            this.manageItemsInView("initialize");
         }
         if(this._runAsMobile)
         {
            this.MAX_ITEMS_DISPLAYED_PER_FRAME = 100;
         }
      }
      
      public function getItemsHolderHeight() : Number
      {
         var _loc2_:BMTileListItem = null;
         var _loc1_:Number = 0;
         if(this._items.length > 0)
         {
            _loc2_ = this._items[this._items.length - 1];
            _loc1_ = _loc2_.y + _loc2_.height;
         }
         return _loc1_;
      }
      
      public function activateExtendedMode(param1:Number, param2:Boolean) : void
      {
         this._extendedMode = true;
         this._extendedMode_itemHeightRatio = param1;
         this._extendedMode_bottomOnly = param2;
      }
      
      public function addItems(param1:Number, param2:Array, param3:Boolean) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:BMTileListItem = null;
         var _loc12_:BMTileListItem = null;
         var _loc13_:int = 0;
         if(param1 < 0)
         {
            TsLogger.log("BMTileList >>> addItems >>> $pos cannot be smaller then 0 ( $pos = " + param1 + " )");
         }
         else
         {
            this._activateAnimatedMarkerSlot = -1;
            _loc4_ = 1;
            _loc5_ = 1;
            _loc6_ = 1;
            _loc7_ = 1;
            _loc9_ = new Array();
            _loc8_ = 0;
            while(_loc8_ < param1)
            {
               _loc9_.push(this._items[_loc8_]);
               _loc8_++;
            }
            _loc10_ = int(param2.length);
            _loc8_ = 0;
            while(_loc8_ < _loc10_)
            {
               _loc9_.push(param2[_loc8_]);
               _loc8_++;
            }
            if(this._items != null)
            {
               _loc13_ = int(this._items.length);
               _loc8_ = param1;
               while(_loc8_ < _loc13_)
               {
                  _loc9_.push(this._items[_loc8_]);
                  _loc8_++;
               }
            }
            this._items = new Array();
            this._items = _loc9_;
            _loc13_ = int(this._items.length);
            _loc8_ = 0;
            while(_loc8_ < _loc13_)
            {
               if(_loc5_ > Math.ceil(this._columns))
               {
                  _loc5_ = 1;
                  _loc4_++;
               }
               if(_loc8_ >= param1)
               {
                  _loc11_ = this._items[_loc8_];
                  _loc11_.x = (_loc5_ - 1) * _loc11_.width;
                  _loc11_.y = (_loc4_ - 1) * _loc11_.height;
               }
               _loc5_++;
               _loc8_++;
            }
            this.refreshScroller(false,"addItems");
            this.jumpToRow(this._currentRow,param3,"addItems");
            this.refreshTileIDs();
         }
      }
      
      public function fillEmptyGridCells(param1:FunctionCall, param2:Boolean = true) : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = this._items.length - this._numOfEmptyItems;
         var _loc4_:int = Math.ceil(this._rows) * Math.ceil(this._columns);
         var _loc5_:int = 0;
         if(_loc3_ < _loc4_)
         {
            _loc5_ = _loc4_ - _loc3_ % _loc4_;
         }
         else if(_loc3_ % int(this._columns) > 0)
         {
            _loc5_ = int(this._columns) - _loc3_ % int(this._columns);
         }
         var _loc7_:Array = new Array();
         _loc6_ = this._numOfEmptyItems;
         while(_loc6_ < _loc5_)
         {
            _loc7_.push(param1.call());
            _loc6_++;
         }
         var _loc8_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < this._numOfEmptyItems - _loc5_)
         {
            _loc8_.push(this.items.length - _loc6_ - 1);
            _loc6_++;
         }
         if(_loc8_.length > 0)
         {
            this.removeItems(_loc8_,"tileID");
         }
         if(_loc7_.length > 0)
         {
            this.addItems(this.highestTileID + 1,_loc7_,param2);
         }
         this._numOfEmptyItems = _loc5_;
      }
      
      public function removeAllItems() : void
      {
         var _loc1_:BMTileListItem = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         this._numOfEmptyItems = 0;
         if(this._items != null)
         {
            this._activateAnimatedMarkerSlot = -1;
            _loc2_ = int(this._items.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = this._items[_loc3_];
               _loc1_.removeMe();
               _loc1_ = null;
               _loc3_++;
            }
            this._items = new Array();
            this.refreshScroller(false,"removeAllItems");
            this._currentRow = 0;
            this.refreshTileIDs();
         }
      }
      
      public function removeItems(param1:Array, param2:String) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:BMTileListItem = null;
         var _loc6_:BMTileListItem = null;
         var _loc9_:Number = NaN;
         var _loc3_:Array = new Array();
         var _loc7_:int = int(param1.length);
         var _loc8_:int = int(this._items.length);
         _loc9_ = 0;
         while(_loc9_ < _loc7_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc8_)
            {
               switch(param2)
               {
                  case "tileID":
                     if(_loc4_ == param1[_loc9_])
                     {
                        _loc3_.push(_loc4_);
                     }
                     break;
                  case "tileListItemID":
                     _loc5_ = this._items[_loc4_];
                     if(_loc5_.item.ID == param1[_loc9_])
                     {
                        _loc3_.push(_loc4_);
                     }
               }
               _loc4_++;
            }
            _loc9_++;
         }
         _loc3_.sort(Array.NUMERIC);
         _loc9_ = _loc3_.length - 1;
         while(_loc9_ >= 0)
         {
            if(this._items[_loc3_[_loc9_]] != null)
            {
               _loc5_ = this._items[_loc3_[_loc9_]];
               _loc5_.removeMe();
               _loc5_ = null;
               this._items.splice(_loc3_[_loc9_],1);
            }
            _loc9_--;
         }
         var _loc10_:uint = 1;
         var _loc11_:uint = 1;
         _loc9_ = 0;
         while(_loc9_ < this._items.length)
         {
            if(_loc11_ > Math.ceil(this._columns))
            {
               _loc11_ = 1;
               _loc10_++;
            }
            _loc5_ = this._items[_loc9_];
            _loc5_.x = (_loc11_ - 1) * _loc5_.width;
            _loc5_.y = (_loc10_ - 1) * _loc5_.height;
            _loc11_++;
            _loc9_++;
         }
         this.refreshScroller(true,"removeItems");
         this.jumpToRow(this._currentRow,true,"removeItems");
         this.refreshTileIDs();
      }
      
      public function findTileIDByTileListItemID(param1:Number) : Number
      {
         var _loc4_:BMTileListItem = null;
         var _loc2_:Number = -1;
         var _loc3_:int = int(this._items.length);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = this._items[_loc5_];
            if(_loc4_.item.ID == param1)
            {
               _loc2_ = _loc5_;
               _loc5_ = uint(_loc3_);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function findTileListItemByTileListItemID(param1:Number) : BMTileListItem
      {
         var _loc4_:BMTileListItem = null;
         var _loc6_:BMTileListItem = null;
         var _loc2_:Number = -1;
         var _loc3_:int = int(this._items.length);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = this._items[_loc5_];
            if(_loc4_.item.ID == param1)
            {
               _loc2_ = _loc5_;
               _loc5_ = uint(_loc3_);
            }
            _loc5_++;
         }
         if(_loc2_ > -1)
         {
            _loc6_ = this._items[_loc2_];
         }
         return _loc6_;
      }
      
      public function findTileListItemIDByTileID(param1:Number) : Number
      {
         var _loc3_:BMTileListItem = null;
         var _loc2_:Number = -1;
         if(this._items[param1] != null)
         {
            _loc3_ = this._items[param1];
            _loc2_ = _loc3_.item.ID;
         }
         return _loc2_;
      }
      
      public function findTileListItemByTileID(param1:Number) : BMTileListItem
      {
         var _loc2_:BMTileListItem = null;
         var _loc3_:BMTileListItem = null;
         if(param1 > -1 && param1 < this._items.length)
         {
            _loc3_ = this._items[param1];
         }
         return _loc3_;
      }
      
      public function get items() : Array
      {
         return this._items;
      }
      
      private function refreshTileIDs() : void
      {
         var _loc2_:BMTileListItem = null;
         this._highestTileID = -1;
         var _loc1_:int = int(this._items.length);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._items[_loc3_];
            _loc2_.tileID = _loc3_;
            if(_loc3_ == _loc1_ - 1)
            {
               this._highestTileID = _loc3_;
            }
            _loc3_++;
         }
         this._itemsExceedOnePage = false;
         if(this._items.length > this._rows * this._columns)
         {
            this._itemsExceedOnePage = true;
         }
      }
      
      public function get highestTileID() : Number
      {
         return this._highestTileID;
      }
      
      public function getAllTileListItemIDs() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:BMTileListItem = null;
         var _loc4_:uint = 0;
         var _loc1_:Array = new Array();
         if(this._items != null)
         {
            _loc2_ = int(this._items.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = this._items[_loc4_];
               _loc1_.push(_loc3_.item.ID);
               _loc4_++;
            }
         }
         return _loc1_;
      }
      
      public function disableAllItems(param1:Boolean) : void
      {
         var _loc4_:BMTileListItem = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = int(this._items.length);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = this._items[_loc5_];
            _loc2_.push(_loc4_.tileID);
            _loc5_++;
         }
         this.disableItems(_loc2_,"tileID",param1);
      }
      
      public function enableAllItems() : void
      {
         var _loc3_:BMTileListItem = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = int(this._items.length);
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._items[_loc4_];
            _loc1_.push(_loc3_.tileID);
            _loc4_++;
         }
         this.enableItems(_loc1_,"tileID");
      }
      
      public function disableItems(param1:Array, param2:String, param3:Boolean) : void
      {
         var _loc6_:BMTileListItem = null;
         var _loc8_:uint = 0;
         var _loc4_:int = int(param1.length);
         var _loc5_:int = int(this._items.length);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc4_)
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc6_ = this._items[_loc8_];
               switch(param2)
               {
                  case "tileID":
                     if(_loc6_.tileID == param1[_loc7_])
                     {
                        _loc6_.disableMe(param3);
                        _loc8_ = uint(_loc5_);
                     }
                     break;
                  case "tileListItemID":
                     if(_loc6_.item.ID == param1[_loc7_])
                     {
                        _loc6_.disableMe(param3);
                        _loc8_ = uint(_loc5_);
                     }
               }
               _loc8_++;
            }
            _loc7_++;
         }
      }
      
      public function enableItems(param1:Array, param2:String) : void
      {
         var _loc5_:BMTileListItem = null;
         var _loc7_:uint = 0;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = int(this._items.length);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc5_ = this._items[_loc7_];
               switch(param2)
               {
                  case "tileID":
                     if(_loc5_.tileID == param1[_loc6_])
                     {
                        _loc5_.enableMe();
                        _loc7_ = uint(_loc4_);
                     }
                     break;
                  case "tileListItemID":
                     if(_loc5_.item.ID == param1[_loc6_])
                     {
                        _loc5_.enableMe();
                        _loc7_ = uint(_loc4_);
                     }
               }
               _loc7_++;
            }
            _loc6_++;
         }
      }
      
      public function scrollBy(param1:int) : void
      {
         this.jumpToRow(this._currentRow + param1,true,"scrollBy");
      }
      
      public function scrollerButtonUp() : void
      {
         this.jumpToRow(this._currentRow - 1,true,"scrollerButtonUp");
      }
      
      public function scrollerButtonDown() : void
      {
         this.jumpToRow(this._currentRow + 1,true,"scrollerButtonDown");
      }
      
      public function get canScorllUp() : Boolean
      {
         return this._currentRow > 0;
      }
      
      public function get canScorllDown() : Boolean
      {
         var _loc1_:Number = Math.ceil(this._items.length / this._columns) - this._rows;
         return this._currentRow < _loc1_;
      }
      
      public function setCurrentRowManually(param1:Number) : void
      {
         this._currentRow = param1;
      }
      
      public function jumpToRow(param1:Number, param2:Boolean, param3:String) : void
      {
         var _loc4_:Number = NaN;
         if(this.scroller != null)
         {
            _loc4_ = Math.ceil(this._items.length / this._columns) - this._rows;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            if(param1 < 0)
            {
               this._currentRow = 0;
            }
            else if(param1 < _loc4_)
            {
               this._currentRow = param1;
            }
            else
            {
               this._currentRow = _loc4_;
            }
            if(this._currentRow == _loc4_ && this._extendedMode && this._extendedMode_bottomOnly && this._itemsExceedOnePage)
            {
               this._itemsHolderTargetYPos = this._headerHeight - this._itemHeight * (this._currentRow - this._extendedMode_itemHeightRatio);
            }
            else
            {
               this._itemsHolderTargetYPos = this._headerHeight - this._itemHeight * this._currentRow;
            }
            if(this.scroller.getScrollPosition() == 1)
            {
               if(this._extendedMode && this._extendedMode_bottomOnly && this._itemsExceedOnePage)
               {
                  this._itemsHolderTargetYPos = this._headerHeight - this.getItemsHolderHeight() + this._itemHeight * (_loc4_ - this._currentRow + this._rows + this._extendedMode_itemHeightRatio);
               }
               else
               {
                  this._itemsHolderTargetYPos = this._headerHeight - this.getItemsHolderHeight() + this._itemHeight * (_loc4_ - this._currentRow + this._rows);
               }
            }
            if(param2)
            {
               this.moveItemsHolder();
            }
            else
            {
               removeEventListener(Event.ENTER_FRAME,this.moveItemsHolderOnEnterFrame);
               this.itemsHolder.y = this._itemsHolderTargetYPos;
            }
            if(_loc4_ > 0)
            {
               this.scroller.setScrollPosition(this._currentRow / _loc4_);
            }
            else
            {
               this.scroller.setScrollPosition(0);
            }
            this.manageItemsInView("jumpToRow");
         }
      }
      
      public function resetOnLastRow() : void
      {
         this.jumpToRow(this._currentRow,true,"resetOnLastRow");
      }
      
      private function moveItemsHolder() : void
      {
         if(this.itemsHolder.y != this._itemsHolderTargetYPos)
         {
            addEventListener(Event.ENTER_FRAME,this.moveItemsHolderOnEnterFrame);
         }
      }
      
      private function moveItemsHolderOnEnterFrame(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(this.moveItemsHolderAllowed)
         {
            if(Math.abs(this.itemsHolder.y - this._itemsHolderTargetYPos) > 1)
            {
               _loc2_ = 0.5 * Math.abs(this.itemsHolder.y - this._itemsHolderTargetYPos);
               if(_loc2_ > 1)
               {
                  if(this.itemsHolder.y < this._itemsHolderTargetYPos)
                  {
                     this.itemsHolder.y += _loc2_;
                  }
                  else
                  {
                     this.itemsHolder.y -= _loc2_;
                  }
               }
               else
               {
                  this.itemsHolder.y = this._itemsHolderTargetYPos;
               }
            }
            else
            {
               removeEventListener(Event.ENTER_FRAME,this.moveItemsHolderOnEnterFrame);
            }
         }
         this.manageItemsInView("moveItemsHolderOnEnterFrame");
      }
      
      public function getItemRow(param1:Number) : Number
      {
         return Math.ceil((param1 + 1) / this._columns) - 1;
      }
      
      public function getCurrentRow() : Number
      {
         return this._currentRow;
      }
      
      private function continueManageItemsInView(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.continueManageItemsInView);
         this.manageItemsInView("continueManageItemsInView");
      }
      
      private function manageItemsInView(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:BMTileListItem = null;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc9_:BMTileListItem = null;
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:uint = 0;
         var _loc2_:Number = Math.abs(Math.ceil(this.itemsHolder.y / this._itemHeight));
         if(this._manageItemsInView)
         {
            if(this._currentRow >= 0)
            {
               _loc3_ = int(this._items.length);
               _loc5_ = 0;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc10_ = false;
                  if(_loc5_ >= this.MAX_ITEMS_DISPLAYED_PER_FRAME)
                  {
                     _loc10_ = true;
                  }
                  if(_loc10_)
                  {
                     addEventListener(Event.ENTER_FRAME,this.continueManageItemsInView);
                  }
                  else if(this._items[_loc4_] != null)
                  {
                     _loc6_ = this._items[_loc4_];
                     _loc7_ = this.itemsHolder.y - this._headerHeight + _loc6_.y;
                     if(_loc6_.parent != null)
                     {
                        if(_loc7_ + _loc6_.height < 0)
                        {
                           _loc6_.parent.removeChild(_loc6_);
                        }
                        else if(_loc7_ > this._rows * this._itemHeight)
                        {
                           _loc6_.parent.removeChild(_loc6_);
                        }
                     }
                     if(_loc6_.parent == null)
                     {
                        _loc8_ = false;
                        _loc11_ = "regular";
                        if(this._extendedMode)
                        {
                           if(this._extendedMode_bottomOnly)
                           {
                              if(this._itemsExceedOnePage)
                              {
                                 _loc11_ = "extended_bottom";
                              }
                           }
                           else
                           {
                              _loc11_ = "extended_topAndBottom";
                           }
                        }
                        switch(_loc11_)
                        {
                           case "regular":
                              if(_loc7_ + _loc6_.height >= 0 && _loc7_ <= this._rows * this._itemHeight)
                              {
                                 _loc8_ = true;
                              }
                              break;
                           case "extended_topAndBottom":
                              if(_loc7_ + _loc6_.height >= -this._itemHeight * (this._extendedMode_itemHeightRatio + 0.01) && _loc7_ <= (this._rows + (this._extendedMode_itemHeightRatio + 0.01)) * this._itemHeight)
                              {
                                 _loc8_ = true;
                              }
                              break;
                           case "extended_bottom":
                              if(_loc7_ + _loc6_.height >= 0 && _loc7_ <= (this._rows + (this._extendedMode_itemHeightRatio + 0.01)) * this._itemHeight)
                              {
                                 _loc8_ = true;
                              }
                        }
                        if(_loc8_)
                        {
                           if(_loc6_.contentLoaded == false)
                           {
                              switch(_loc6_.contentData_dataType)
                              {
                                 case "itemID":
                                    _loc9_ = _loc6_.contentData_createFunction(_loc6_.contentData_itemID,_loc6_.contentData_tileListType,_loc6_.contentData_clicked,_loc6_.contentData_mouseDown,_loc6_.contentData_mouseUp,_loc6_.contentData_mouseOver,_loc6_.contentData_mouseOut,true);
                                    break;
                                 case "playerItemID":
                                    _loc9_ = _loc6_.contentData_createFunction(_loc6_.contentData_playerItemID,_loc6_.contentData_justBought,_loc6_.contentData_clicked,_loc6_.contentData_mouseDown,_loc6_.contentData_mouseUp,_loc6_.contentData_mouseOver,_loc6_.contentData_mouseOut,true);
                              }
                              if(this._itemsListenersRemoved)
                              {
                                 _loc9_.removeAllListeners();
                              }
                              _loc9_.x = _loc6_.x;
                              _loc9_.y = _loc6_.y;
                              _loc6_.removeMe();
                              _loc9_.tileID = _loc4_;
                              this._items[_loc4_] = _loc9_;
                              _loc6_ = _loc9_;
                           }
                           if(_loc6_.itemsThatNeedsAddingAndRemoving != null)
                           {
                              _loc12_ = int(_loc6_.itemsThatNeedsAddingAndRemoving.length);
                              if(_loc12_ > 0)
                              {
                                 _loc13_ = 0;
                                 while(_loc13_ < _loc12_)
                                 {
                                    if(_loc6_.itemsThatNeedsAddingAndRemoving[_loc13_].parent == null)
                                    {
                                       this._items[_loc4_].addChild(_loc6_.itemsThatNeedsAddingAndRemoving[_loc13_]);
                                    }
                                    _loc13_++;
                                 }
                              }
                           }
                           this.itemsHolder.addChild(_loc6_);
                           if(this._activateAnimatedMarkerSlot == _loc4_)
                           {
                              _loc6_.activateAnimatedMarker("special",this._activateAnimatedMarkerDelayFrames);
                              this._activateAnimatedMarkerSlot = -1;
                           }
                           _loc5_++;
                        }
                     }
                  }
                  else
                  {
                     TsLogger.log("_items[" + _loc4_ + "] is nulled");
                  }
                  _loc4_++;
               }
            }
         }
         else
         {
            _loc3_ = int(this._items.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(this._items[_loc4_].parent == null)
               {
                  this.itemsHolder.addChild(this._items[_loc4_]);
               }
               _loc4_++;
            }
         }
         this._lastVisualRow = _loc2_;
      }
      
      public function addDisabledEffectForAllItems() : void
      {
         var _loc4_:BMTileListItem = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = int(this._items.length);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._items[_loc3_];
            _loc1_.push(_loc4_.tileID);
            _loc3_++;
         }
         this.addDisabledEffectForSpecificItems(_loc1_,"tileID");
      }
      
      public function removeDisabledEffectFromAllItems() : void
      {
         var _loc4_:BMTileListItem = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = int(this._items.length);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._items[_loc3_];
            _loc1_.push(_loc4_.tileID);
            _loc3_++;
         }
         this.removeDisabledEffectForSpecificItems(_loc1_,"tileID");
      }
      
      public function addDisabledEffectForSpecificItems(param1:Array, param2:String) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:BMTileListItem = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = int(this._items.length);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = this._items[_loc6_];
               switch(param2)
               {
                  case "tileID":
                     if(_loc7_.tileID == param1[_loc5_])
                     {
                        _loc7_.addDisabledEffect();
                        _loc6_ = uint(_loc4_);
                     }
                     break;
                  case "tileListItemID":
                     if(_loc7_.item.ID == param1[_loc5_])
                     {
                        _loc7_.addDisabledEffect();
                        _loc6_ = uint(_loc4_);
                     }
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      public function removeDisabledEffectForSpecificItems(param1:Array, param2:String) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:BMTileListItem = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = int(this._items.length);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = this._items[_loc6_];
               switch(param2)
               {
                  case "tileID":
                     if(_loc7_.tileID == param1[_loc5_])
                     {
                        _loc7_.removeDisabledEffect();
                        _loc6_ = uint(_loc4_);
                     }
                     break;
                  case "tileListItemID":
                     if(_loc7_.item.ID == param1[_loc5_])
                     {
                        _loc7_.removeDisabledEffect();
                        _loc6_ = uint(_loc4_);
                     }
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      public function scrollToID(param1:Number, param2:String, param3:String) : void
      {
         var _loc5_:Number = NaN;
         var _loc8_:BMTileListItem = null;
         var _loc4_:Number = -1;
         var _loc6_:int = int(this._items.length);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = this._items[_loc7_];
            switch(param3)
            {
               case "tileID":
                  if(_loc8_.tileID == param1)
                  {
                     _loc5_ = _loc8_.height;
                     _loc4_ = _loc7_;
                     _loc7_ = uint(_loc6_);
                  }
                  break;
               case "tileListItemID":
                  if(_loc8_.item.ID == param1)
                  {
                     _loc5_ = _loc8_.height;
                     _loc4_ = _loc7_;
                     _loc7_ = uint(_loc6_);
                  }
            }
            _loc7_++;
         }
         if(_loc4_ > -1)
         {
            switch(param2)
            {
               case "top":
                  this.jumpToRow(Math.floor(_loc4_ / this._columns),true,"scrollToID");
                  break;
               case "center":
                  this.jumpToRow(Math.floor(_loc4_ / this._columns) - Math.ceil((this._rows - 1) / 2),true,"scrollToID");
                  break;
               case "bottom":
                  this.jumpToRow(Math.floor(_loc4_ / this._columns - (this._rows - 1)),true,"scrollToID");
            }
         }
      }
      
      public function addGuideArrow(param1:MovieClip) : void
      {
         if(this.guideArrow != null)
         {
            if(this.guideArrow.parent != null)
            {
               this.guideArrow.parent.removeChild(this.guideArrow);
            }
            this.guideArrow = null;
         }
         param1.scaleX = 0.28;
         param1.scaleY = 0.28;
         param1.mouseEnabled = false;
         param1.mouseChildren = false;
         this.guideArrow = param1;
         this.guideArrowHolder.addChild(this.guideArrow);
      }
      
      public function activateGuideArrow(param1:Number, param2:String, param3:uint) : void
      {
         switch(param2)
         {
            case "tileID":
               this._guideArrowTileID = param1;
               break;
            case "tileListItemID":
               this._guideArrowTileID = this.findTileIDByTileListItemID(param1);
         }
         if(this.guideArrow != null)
         {
            addEventListener(Event.ENTER_FRAME,this.guideArrowOnEnterFrame);
         }
         else
         {
            TsLogger.log("ERROR : GUIDE ARROW WAS NOT ADDED");
         }
      }
      
      private function guideArrowOnEnterFrame(param1:Event) : void
      {
         var _loc3_:BMTileListItem = null;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         var _loc2_:String = "animOff";
         if(this._items[this._guideArrowTileID] != null)
         {
            _loc2_ = "animOn";
            _loc3_ = this._items[this._guideArrowTileID];
            _loc4_ = 30;
            _loc5_ = false;
            _loc6_ = "regular";
            if(this._extendedMode)
            {
               if(this._extendedMode_bottomOnly)
               {
                  if(this._itemsExceedOnePage)
                  {
                     _loc6_ = "extended_bottom";
                  }
               }
               else
               {
                  _loc6_ = "extended_topAndBottom";
               }
            }
            switch(_loc6_)
            {
               case "regular":
                  if(_loc3_.y + this.itemsHolder.y > (this._rows - 1) * this._itemHeight)
                  {
                     this.guideArrow.rotation = -90;
                     this.guideArrow.y = this._rows * this._itemHeight - _loc4_;
                     _loc5_ = true;
                  }
                  else if(_loc3_.y + this.itemsHolder.y < 0)
                  {
                     this.guideArrow.rotation = 90;
                     this.guideArrow.y = 0 + _loc4_;
                     _loc5_ = true;
                  }
                  break;
               case "extended_topAndBottom":
                  if(_loc3_.y + this.itemsHolder.y > (this._rows - this._extendedMode_itemHeightRatio) * this._itemHeight)
                  {
                     this.guideArrow.rotation = -90;
                     this.guideArrow.y = this._rows * this._itemHeight - _loc4_;
                     _loc5_ = true;
                  }
                  else if(_loc3_.y + this.itemsHolder.y < -this._extendedMode_itemHeightRatio * this._itemHeight)
                  {
                     this.guideArrow.rotation = 90;
                     this.guideArrow.y = 0 + _loc4_;
                     _loc5_ = true;
                  }
                  break;
               case "extended_bottom":
                  if(_loc3_.y + this.itemsHolder.y > (this._rows - this._extendedMode_itemHeightRatio) * this._itemHeight)
                  {
                     this.guideArrow.rotation = -90;
                     this.guideArrow.y = this._rows * this._itemHeight - _loc4_;
                     _loc5_ = true;
                  }
                  else if(_loc3_.y + this.itemsHolder.y < 0)
                  {
                     this.guideArrow.rotation = 90;
                     this.guideArrow.y = 0 + _loc4_;
                     _loc5_ = true;
                  }
            }
            if(_loc5_)
            {
               this.guideArrow.x = this.scroller.x + this.scroller.width / 2;
            }
            else
            {
               if(this._guideArrowTileID % this._columns == 0)
               {
                  this.guideArrow.rotation = 0;
                  this.guideArrow.x = _loc3_.x + this._itemWidth;
               }
               else
               {
                  this.guideArrow.rotation = 180;
                  this.guideArrow.x = _loc3_.x;
               }
               this.guideArrow.y = _loc3_.y + this._itemHeight / 2 + this.itemsHolder.y;
            }
         }
         if(this.guideArrow.currentLabel != _loc2_)
         {
            this.guideArrow.gotoAndStop(_loc2_);
         }
      }
      
      public function deactivateGuideArrow() : void
      {
         if(this.guideArrow != null)
         {
            this.guideArrow.gotoAndStop("animOff");
         }
         this._guideArrowTileID = 0;
         removeEventListener(Event.ENTER_FRAME,this.guideArrowOnEnterFrame);
      }
      
      private function backgroundMouseUp(param1:MouseEvent) : void
      {
         if(this._backgroundMouseUp != null)
         {
            this._backgroundMouseUp();
         }
      }
      
      public function addMarker(param1:Number, param2:MovieClip, param3:String) : void
      {
         var _loc4_:BMTileListItem = null;
         var _loc5_:int = int(this._items.length);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._items[_loc6_];
            switch(param3)
            {
               case "tileID":
                  if(_loc6_ == param1)
                  {
                     _loc4_.addMarker(param2);
                  }
                  break;
               case "tileListItemID":
                  _loc4_ = this._items[_loc6_];
                  if(_loc4_.item.ID == param1)
                  {
                     _loc4_.addMarker(param2);
                  }
            }
            _loc6_++;
         }
      }
      
      public function removeAllMarkers() : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:BMTileListItem = null;
         var _loc1_:Array = new Array();
         if(this._items != null)
         {
            _loc2_ = int(this._items.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = this._items[_loc3_];
               _loc1_.push(_loc4_.tileID);
               _loc3_++;
            }
         }
         this.removeMarkers(_loc1_,"tileID");
      }
      
      public function removeMarkers(param1:Array, param2:String) : void
      {
         var _loc3_:BMTileListItem = null;
         var _loc7_:uint = 0;
         var _loc4_:int = int(param1.length);
         var _loc5_:int = int(this._items.length);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc3_ = this._items[_loc7_];
               switch(param2)
               {
                  case "tileID":
                     if(_loc7_ == param1[_loc6_])
                     {
                        _loc3_.removeMarker();
                     }
                     break;
                  case "tileListItemID":
                     _loc3_ = this._items[_loc7_];
                     if(_loc3_.item.ID == param1[_loc6_])
                     {
                        _loc3_.removeMarker();
                     }
               }
               _loc7_++;
            }
            _loc6_++;
         }
      }
      
      public function activateAnimatedMarker(param1:Number, param2:String, param3:Number) : void
      {
         var _loc4_:BMTileListItem = null;
         var _loc5_:int = int(this._items.length);
         this._activateAnimatedMarkerDelayFrames = param3;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._items[_loc6_];
            switch(param2)
            {
               case "tileID":
                  if(_loc6_ == param1)
                  {
                     if(_loc4_.parent == null)
                     {
                        this._activateAnimatedMarkerSlot = _loc6_;
                     }
                     else
                     {
                        _loc4_.activateAnimatedMarker("special",param3);
                     }
                  }
                  break;
               case "tileListItemID":
                  _loc4_ = this._items[_loc6_];
                  if(_loc4_.item.ID == param1)
                  {
                     if(_loc4_.parent == null)
                     {
                        this._activateAnimatedMarkerSlot = _loc6_;
                     }
                     else
                     {
                        _loc4_.activateAnimatedMarker("special",param3);
                     }
                  }
            }
            _loc6_++;
         }
      }
      
      public function deactivateAllAnimatedMarkers() : void
      {
         var _loc4_:BMTileListItem = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = int(this._items.length);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._items[_loc3_];
            _loc1_.push(_loc4_.tileID);
            _loc3_++;
         }
         this.deactivateAnimatedMarkers(_loc1_,"tileID");
      }
      
      public function deactivateAnimatedMarkers(param1:Array, param2:String) : void
      {
         var _loc3_:BMTileListItem = null;
         var _loc7_:uint = 0;
         var _loc4_:int = int(param1.length);
         var _loc5_:int = int(this._items.length);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc3_ = this._items[_loc7_];
               switch(param2)
               {
                  case "tileID":
                     if(_loc7_ == param1[_loc6_])
                     {
                        _loc3_.deactivateAnimatedMarker("tileList deactivateAnimatedMarkers");
                     }
                     break;
                  case "tileListItemID":
                     _loc3_ = this._items[_loc7_];
                     if(_loc3_.item.ID == param1[_loc6_])
                     {
                        _loc3_.deactivateAnimatedMarker("tileList deactivateAnimatedMarkers");
                     }
               }
               _loc7_++;
            }
            _loc6_++;
         }
      }
      
      private function refreshScroller(param1:Boolean, param2:String) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         if(this._useScroller)
         {
            if(this.scroller == null)
            {
               this.createScroller();
            }
            _loc3_ = Math.ceil(this._items.length / this._columns);
            _loc4_ = false;
            if(_loc3_ > this._rows)
            {
               _loc4_ = true;
            }
            if(_loc4_)
            {
               _loc5_ = this._rows / _loc3_;
               this.scroller.enableMe();
            }
            else
            {
               _loc5_ = 1;
               this.scroller.disableMe();
            }
            this.scroller.refreshScrollerSizeRatio(_loc5_,param1);
         }
      }
      
      private function scrollerScrolled(param1:Number) : void
      {
         if(this._extendedMode && this._extendedMode_bottomOnly && this._itemsExceedOnePage)
         {
            this.itemsHolder.y = this._headerHeight - (this.getItemsHolderHeight() - this._itemHeight * (this._rows + this._extendedMode_itemHeightRatio)) * param1;
         }
         else
         {
            this.itemsHolder.y = this._headerHeight - (this.getItemsHolderHeight() - this._itemHeight * this._rows) * param1;
         }
         this.manageItemsInView("scrollerScrolled");
      }
      
      private function scrollingEnded() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.scroller != null)
         {
            _loc1_ = this.scroller.getScrollPosition();
            _loc2_ = Math.ceil(this._items.length / this._columns);
            _loc3_ = Math.round(_loc1_ * (_loc2_ - this._rows));
            this.jumpToRow(_loc3_,true,"scrollingEnded");
         }
      }
      
      private function removeScroller() : void
      {
         if(this.scroller != null)
         {
            this.scroller.removeMe();
            this.scroller = null;
         }
      }
      
      private function createScroller() : void
      {
         var _loc1_:Number = Math.ceil(this._items.length / this._columns);
         var _loc2_:Number = (this._itemHeight * this._rows + this._headerHeight) / this._scrollerSizeRatio;
         this.scroller = new BMScroller();
         this.scroller.initialize(this._stage,_loc2_,1,this._scrollerContent,this.scrollerScrolled,this.scrollingEnded,this.scrollerButtonUp,this.scrollerButtonDown,this._scrollerInvisibleMode,this._runAsMobile,this._specialSkin);
         this.scroller.scaleX = this._scrollerSizeRatio;
         this.scroller.scaleY = this._scrollerSizeRatio;
         if(this._scrollerAlignRight)
         {
            this.scroller.x = this._itemWidth * this._columns + 2;
         }
         else
         {
            this.scroller.x = -this.scroller.width - 4;
         }
         this.scrollerHolder.addChild(this.scroller);
         this.refreshInterfaceFrameSize();
      }
      
      public function disableScroller() : void
      {
         this.scroller.disableMe();
      }
      
      public function pushScroller(param1:Number, param2:Number) : void
      {
         if(this.scroller != null)
         {
            this.scroller.x += param1;
            this.scroller.y += param2;
         }
      }
      
      private function createInterfaceFrame() : void
      {
         if(this.interfaceFrame != null)
         {
            this.interfaceFrame.width = this._columns * this._itemWidth + 2 * this.INTERFACE_FRAME_THICKNESS;
            this.interfaceFrame.height = this._headerHeight + this._rows * this._itemHeight + 2 * this.INTERFACE_FRAME_THICKNESS;
            this.interfaceFrame.x = -this.INTERFACE_FRAME_THICKNESS;
            this.interfaceFrame.y = -this.INTERFACE_FRAME_THICKNESS;
            this.interfaceFrameHolder.addChild(this.interfaceFrame);
         }
      }
      
      private function refreshInterfaceFrameSize() : void
      {
         if(this.interfaceFrame != null)
         {
            if(this.scroller != null)
            {
               if(this.scroller.parent != null)
               {
                  this.interfaceFrame.width = this._columns * this._itemWidth + 2 * this.INTERFACE_FRAME_THICKNESS + this.INTERFACE_FRAME_SCROLLER_ADDON;
               }
               else
               {
                  this.interfaceFrame.width = this._columns * this._itemWidth + 2 * this.INTERFACE_FRAME_THICKNESS;
               }
            }
            else
            {
               this.interfaceFrame.width = this._columns * this._itemWidth + 2 * this.INTERFACE_FRAME_THICKNESS;
            }
         }
      }
      
      public function getItemIDInCoords(param1:Number, param2:Number) : Array
      {
         var _loc4_:BMTileListItem = null;
         var _loc3_:Array = new Array();
         _loc3_.push(-1,-1);
         var _loc5_:int = int(this._items.length);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._items[_loc6_];
            if(_loc4_.x <= param1 && _loc4_.x + _loc4_.width >= param1)
            {
               if(_loc4_.y + this.itemsHolder.y <= param2 && _loc4_.y + _loc4_.height + this.itemsHolder.y >= param2)
               {
                  _loc3_ = [_loc6_,_loc4_.item.ID];
                  _loc6_ = this._items.length;
               }
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      public function getRows() : Number
      {
         return this._rows;
      }
      
      public function getColumns() : Number
      {
         return this._columns;
      }
      
      public function getItemsAmount() : Number
      {
         return this._items.length;
      }
      
      public function getNonEmptyAmount() : Number
      {
         return this._items.length - this._numOfEmptyItems;
      }
      
      public function removeAllItemsListeners() : void
      {
         var _loc3_:BMTileListItem = null;
         this._itemsListenersRemoved = true;
         var _loc1_:int = int(this._items.length);
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._items[_loc2_];
            _loc3_.removeAllListeners();
            _loc2_++;
         }
      }
      
      public function addAllItemsListeners() : void
      {
         var _loc3_:BMTileListItem = null;
         this._itemsListenersRemoved = false;
         var _loc1_:int = int(this._items.length);
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._items[_loc2_];
            _loc3_.addAllListeners();
            _loc2_++;
         }
      }
      
      public function removeMe() : void
      {
         var _loc3_:BMTileListItem = null;
         this.deactivateGuideArrow();
         var _loc1_:int = int(this._items.length);
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._items[_loc2_];
            if(_loc3_.parent != null)
            {
               _loc3_.parent.removeChild(_loc3_);
            }
            _loc3_.removeMe();
            _loc3_ = null;
            _loc2_++;
         }
         this.removeScroller();
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

