package net.battleMechsMulti.mobiles.dropdownList
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMDropdownList extends BMBaseClass
   {
      
      private static const STATUS_OPENING:uint = 1;
      
      private static const STATUS_OPENED:uint = 2;
      
      private static const STATUS_CLOSING:uint = 3;
      
      private static const STATUS_CLOSED:uint = 4;
      
      private var _itemsData:Array;
      
      private var _itemRows:Array;
      
      private var _headerItemID:Number;
      
      private var _newHeaderItemID:Number = -1;
      
      private var _status:uint = 4;
      
      private var _returnFunction:Function;
      
      private var _itemHeight:Number;
      
      private var _disabled:Boolean = false;
      
      private var mcDropdownHeader:BMDropdownListRow;
      
      private var dropdownListRows:Array;
      
      private var mainHolder:Sprite;
      
      private var headerHolder:Sprite;
      
      private var itemsHolder:Sprite;
      
      private var maskSizer:Sprite;
      
      public function BMDropdownList()
      {
         super();
         generateSingletonClassesPointers("");
      }
      
      public function createItems(param1:Array, param2:Function, param3:Number = -1) : void
      {
         var _loc5_:BMDropdownListItemData = null;
         this._itemsData = new Array();
         this._returnFunction = param2;
         this.mainHolder = new Sprite();
         this.headerHolder = new Sprite();
         this.itemsHolder = new Sprite();
         addChild(this.mainHolder);
         this.mainHolder.addChild(this.itemsHolder);
         this.mainHolder.addChild(this.headerHolder);
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            this._itemsData.push(_loc5_);
            _loc4_++;
         }
         if(param3 > -1)
         {
            this._headerItemID = param3;
         }
         else
         {
            _loc5_ = this._itemsData[0];
            this._headerItemID = _loc5_.itemID;
         }
         this._status = STATUS_CLOSED;
         this.createItemsSub();
         this.maskSizer = new Sprite();
         this.maskSizer.graphics.beginFill(0,0);
         this.maskSizer.graphics.drawRect(0,0,this.itemsHolder.width,this.itemsHolder.height + 3);
         this.maskSizer.y = this.mcDropdownHeader.height - 2;
         this.itemsHolder.mask = this.maskSizer;
         this.mainHolder.addChild(this.maskSizer);
      }
      
      private function createItemsSub() : void
      {
         var _loc3_:BMDropdownListItemData = null;
         var _loc4_:BMDropdownListRow = null;
         var _loc5_:Boolean = false;
         this.removeHeader();
         this.removeRows();
         this.refreshHeader();
         this._itemHeight = this.mcDropdownHeader.height;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this._itemsData.length)
         {
            _loc3_ = this._itemsData[_loc2_];
            if(_loc3_.itemID != this._headerItemID)
            {
               _loc4_ = new BMDropdownListRow();
               _loc5_ = false;
               if(_loc2_ == this._itemsData.length - 1)
               {
                  _loc5_ = true;
               }
               this.createDropdownRow(_loc4_,false,_loc2_,_loc3_.itemID,this._headerItemID,_loc5_);
               _loc4_.y = _loc1_ * this._itemHeight;
               this.itemsHolder.addChild(_loc4_);
               this._itemRows.push(_loc4_);
               _loc1_++;
            }
            else
            {
               this._itemRows.push(null);
            }
            _loc2_++;
         }
         if(this._status == STATUS_OPENED)
         {
            this.itemsHolder.y = this.mcDropdownHeader.height;
         }
         else
         {
            this.itemsHolder.y = this.mcDropdownHeader.height - this.itemsHolder.height;
         }
      }
      
      private function refreshHeader() : void
      {
         this.mcDropdownHeader = new BMDropdownListRow();
         this.createDropdownRow(this.mcDropdownHeader,true,this.getItemSlotByItemID(this._headerItemID),this._headerItemID,this._headerItemID);
         this.refreshHeaderArrow();
         this.headerHolder.addChild(this.mcDropdownHeader);
      }
      
      private function refreshHeaderArrow() : void
      {
         if(this._status == STATUS_OPENED)
         {
            this.mcDropdownHeader.showCloseArrow();
         }
         else
         {
            this.mcDropdownHeader.showOpenArrow();
         }
      }
      
      private function createDropdownRow(param1:BMDropdownListRow, param2:Boolean, param3:uint, param4:uint, param5:uint, param6:Boolean = false) : void
      {
         var _loc7_:MovieClip = null;
         if(param2)
         {
            _loc7_ = new mcItemTypeDropdownListHeader();
         }
         else if(param6)
         {
            _loc7_ = new mcItemTypeDropdownListRowLast();
         }
         else
         {
            _loc7_ = new mcItemTypeDropdownListRow();
         }
         var _loc8_:BMDropdownListItemData = this._itemsData[param3];
         _loc7_.txtDescription.text = _loc8_.text;
         var _loc9_:Sprite = externalAssetsM.getAsset(_loc8_.iconSource,_loc8_.iconName);
         _loc9_.width = _loc7_.mcSizer_icon.width;
         _loc9_.height = _loc7_.mcSizer_icon.height;
         _loc9_.x = _loc7_.mcSizer_icon.x;
         _loc9_.y = _loc7_.mcSizer_icon.y;
         var _loc10_:Sprite = new Sprite();
         _loc10_.graphics.beginFill(0,0);
         _loc10_.graphics.drawRect(0,0,_loc7_.width,_loc7_.height);
         _loc7_.addChild(_loc9_);
         param1.initialize(_loc7_,_loc10_,param3,param4,this.rowClicked,this.rowMouseOver,this.rowMouseOut);
      }
      
      private function rowClicked(param1:uint, param2:uint) : void
      {
         if(this._disabled)
         {
            return;
         }
         switch(this._status)
         {
            case STATUS_CLOSED:
            case STATUS_OPENED:
               if(this._status == STATUS_CLOSED)
               {
                  this.startOpeningAnimation();
               }
               else
               {
                  this.startClosingAnimation();
               }
               if(this._headerItemID != param2)
               {
                  this._newHeaderItemID = param2;
               }
         }
      }
      
      private function rowMouseOver(param1:uint, param2:uint) : void
      {
         var _loc3_:BMDropdownListRow = null;
         switch(this._status)
         {
            case STATUS_CLOSED:
            case STATUS_OPENED:
               if(param2 == this._headerItemID)
               {
                  this.mcDropdownHeader.showMouseOverEffect();
               }
               else
               {
                  _loc3_ = this._itemRows[param1];
                  _loc3_.showMouseOverEffect();
               }
         }
      }
      
      private function rowMouseOut(param1:uint, param2:uint) : void
      {
         var _loc3_:BMDropdownListRow = null;
         switch(this._status)
         {
            case STATUS_CLOSED:
            case STATUS_OPENED:
               if(param2 == this._headerItemID)
               {
                  this.mcDropdownHeader.showMouseOutEffect();
               }
               else
               {
                  _loc3_ = this._itemRows[param1];
                  _loc3_.showMouseOutEffect();
               }
         }
      }
      
      private function startClosingAnimation() : void
      {
         this._status = STATUS_CLOSING;
         TweenMax.to(this.itemsHolder,0.1,{
            "y":this._itemHeight - this.itemsHolder.height,
            "onComplete":this.closingAnimationEnded
         });
      }
      
      private function closingAnimationEnded() : void
      {
         this._status = STATUS_CLOSED;
         if(this._newHeaderItemID > -1)
         {
            this._headerItemID = this._newHeaderItemID;
            this._newHeaderItemID = -1;
            this.createItemsSub();
            this._returnFunction(this._headerItemID);
         }
         else
         {
            this.refreshHeaderArrow();
         }
      }
      
      private function startOpeningAnimation() : void
      {
         this._status = STATUS_OPENING;
         TweenMax.to(this.itemsHolder,0.1,{
            "y":this._itemHeight,
            "onComplete":this.openingAnimationEnded
         });
      }
      
      private function openingAnimationEnded() : void
      {
         this._status = STATUS_OPENED;
         this.refreshHeaderArrow();
      }
      
      public function disableMe() : void
      {
         this._disabled = true;
      }
      
      public function removemMe() : void
      {
         this.removeHeader();
         this.removeRows();
      }
      
      public function getSelectedItemID() : uint
      {
         return this._headerItemID;
      }
      
      private function removeHeader() : void
      {
         if(this.mcDropdownHeader != null)
         {
            if(this.mcDropdownHeader.parent != null)
            {
               this.mcDropdownHeader.parent.removeChild(this.mcDropdownHeader);
            }
            this.mcDropdownHeader = null;
         }
      }
      
      private function removeRows() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMDropdownListRow = null;
         if(this._itemRows != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._itemRows.length)
            {
               if(this._itemRows[_loc1_] != null)
               {
                  _loc2_ = this._itemRows[_loc1_];
                  _loc2_.removeMe();
                  if(_loc2_.parent != null)
                  {
                     _loc2_.parent.removeChild(_loc2_);
                  }
                  _loc2_ = null;
                  this._itemRows[_loc1_] = null;
               }
               _loc1_++;
            }
         }
         this._itemRows = new Array();
      }
      
      private function getItemSlotByItemID(param1:uint) : Number
      {
         var _loc3_:BMDropdownListItemData = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._itemsData.length)
         {
            _loc3_ = this._itemsData[_loc2_];
            if(_loc3_.itemID == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
   }
}

