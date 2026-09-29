package net.battleMechsMulti.screens.contentPackLibrary
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   
   public class BMContentPackLibraryPackRow extends BMMovieClip
   {
      
      public var txtTitle:TextField;
      
      public var mcItemSizer:Sprite;
      
      public var mcBackground:MovieClip;
      
      private var _items:Array;
      
      private var _itemIDs:Array;
      
      private var _locked:Boolean;
      
      public function BMContentPackLibraryPackRow()
      {
         super();
         this._items = new Array();
      }
      
      public function setTitle(param1:String) : void
      {
         if(this.txtTitle == null)
         {
            return;
         }
         updateTextAndFormat(this.txtTitle,param1);
      }
      
      public function showMe() : void
      {
         this.showItems();
         if(parent == null)
         {
         }
      }
      
      public function hideMe() : void
      {
         this.hideItems();
      }
      
      private function showItems() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMTileListItem = null;
         if(this._items.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._itemIDs.length)
            {
               _loc2_ = this._items[_loc1_];
               if(_loc2_.parent == null)
               {
                  addChild(_loc2_);
               }
               _loc1_++;
            }
            return;
         }
         if(this._itemIDs == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this._itemIDs.length)
         {
            this.addItem(this._itemIDs[_loc1_]);
            _loc1_++;
         }
         this.mcBackground.gotoAndStop(this._itemIDs.length);
      }
      
      private function hideItems() : void
      {
         var _loc2_:BMTileListItem = null;
         if(this._items.length == 0)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._itemIDs.length)
         {
            _loc2_ = this._items[_loc1_];
            if(_loc2_.parent != null)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc1_++;
         }
      }
      
      public function setItems(param1:Array, param2:Boolean) : void
      {
         this._locked = param2;
         if(this._itemIDs != null)
         {
            trace("BMContentPackLibraryPackRow cannot set new items");
            return;
         }
         this._itemIDs = param1;
      }
      
      private function addItem(param1:uint) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:BMTileListItem = null;
         var _loc2_:String = "contentPackItem";
         if(this._locked)
         {
            _loc2_ = "contentPackItemLocked";
         }
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         _loc4_ = this.mcItemSizer.width;
         _loc5_ = _loc3_.createItemTileListItem(param1,_loc4_,0,this._locked);
         _loc5_.x = this.mcItemSizer.x + this._items.length * (_loc4_ + 16);
         _loc5_.y = this.mcItemSizer.y;
         _loc5_.width = _loc4_;
         _loc5_.height = _loc4_;
         addChild(_loc5_);
         this._items.push(_loc5_);
      }
      
      public function getItemIDAt(param1:Number) : int
      {
         var _loc4_:BMTileListItem = null;
         var _loc2_:int = -1;
         if(this._items == null)
         {
            return _loc2_;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this._items.length)
         {
            _loc4_ = this._items[_loc3_];
            if(_loc4_.x <= param1 && _loc4_.x + _loc4_.width >= param1)
            {
               return this._itemIDs[_loc3_];
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

