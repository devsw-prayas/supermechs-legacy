package net.battleMechsMulti.screens.hanger.upgrade
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.specialAbilities.BMMechSpecialAbilitiesResolver;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2876")]
   public class BMUpgradeEnhancePanel extends BMUpgradeBasePanel
   {
      
      private const MAX_ENHANCERS:uint = 5;
      
      public var btnClose:BMBasicButton;
      
      public var enhancerSlotsHolder:Sprite;
      
      public var targetItemSizer:Sprite;
      
      public var txtSpecialAbilities:TextField;
      
      private var enhancerSlots:Array;
      
      private var _equippedEnhancers:Vector.<BMTileListItem>;
      
      private var _currentItemID:Number;
      
      private var _targetItem:BMTileListItem;
      
      private const ENHANCER_ITEM_SIZE:uint = 68;
      
      private const ENHANCER_SLOT_SIZE:uint = 74;
      
      private const ENHANCER_SLOT_X_JUMP:uint = 4;
      
      public function BMUpgradeEnhancePanel()
      {
         super();
         generateSingletonClassesPointers("");
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
      }
      
      override public function setTarget(param1:Number) : void
      {
         if(this._targetItem != null)
         {
            removeChild(this._targetItem);
         }
         this._targetItem = dataM.createInventoryTileListItem2(param1,this.onTargetItemClicked,this.targetItemSizer.width);
         this._targetItem.x = this.targetItemSizer.x;
         this._targetItem.y = this.targetItemSizer.y;
         addChild(this._targetItem);
         var _loc2_:BMItemData = dataM.myPlayerData.getItemBy(param1);
         this._currentItemID = _loc2_.itemID;
         this.refreshEnhancerSlots();
         this.createAllEquippedEnhancers();
         this.onEnhancersChanged();
      }
      
      private function refreshEnhancerSlots() : void
      {
         var _loc2_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         this.removeAllEnhancerSlots();
         var _loc1_:BMItemData = dataM.myPlayerData.getItemBy(this.targetItemPlayerItemID);
         _loc2_ = _loc1_.enhancerSlots.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new mcEnhancerSlot();
            _loc5_ = uint(_loc1_.enhancerSlots[_loc3_]);
            _loc4_.width = this.ENHANCER_SLOT_SIZE;
            _loc4_.height = this.ENHANCER_SLOT_SIZE;
            if(_loc2_ > 1)
            {
               _loc4_.x = this.getSlotXPos(_loc3_,_loc2_);
            }
            this.enhancerSlotsHolder.addChild(_loc4_);
            this.enhancerSlots.push(_loc4_);
            this.setEnhancerSlotFrame(_loc3_,_loc5_,false);
            _loc3_++;
         }
      }
      
      private function getSlotXPos(param1:uint, param2:uint) : Number
      {
         return (param1 - (param2 - 1) / 2) * (this.ENHANCER_SLOT_SIZE + this.ENHANCER_SLOT_X_JUMP * 2);
      }
      
      private function addEquippedEnhancer(param1:uint, param2:uint) : void
      {
         var _loc8_:BMTileListItem = null;
         var _loc3_:BMItemData = dataM.myPlayerData.getItemBy(param2);
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Boolean = true;
         var _loc7_:Boolean = true;
         _loc8_ = dataM.createInventoryTileListItem2(param2,this.onSourceItemClicked,this.ENHANCER_ITEM_SIZE,_loc4_,_loc5_,_loc6_,_loc7_);
         _loc8_.x = this.getSlotXPos(param1,this._equippedEnhancers.length) - this.ENHANCER_ITEM_SIZE / 2;
         _loc8_.y = -this.ENHANCER_ITEM_SIZE / 2;
         this.enhancerSlotsHolder.addChild(_loc8_);
         this._equippedEnhancers[param1] = _loc8_;
         this.setEnhancerSlotFrame(param1,_loc3_.damageType,true);
         this.onEnhancersChanged();
      }
      
      private function removeEnhancer(param1:uint, param2:uint) : void
      {
         var _loc3_:BMTileListItem = this._equippedEnhancers[param1];
         _loc3_.removeMe();
         this._equippedEnhancers[param1] = null;
         var _loc4_:BMItemData = dataM.myPlayerData.getItemBy(param2);
         this.setEnhancerSlotFrame(param1,_loc4_.damageType,false);
         this.onEnhancersChanged();
      }
      
      private function setEnhancerSlotFrame(param1:uint, param2:uint, param3:Boolean) : void
      {
         var _loc4_:uint = param2 * 2 + 1;
         if(param3)
         {
            _loc4_++;
         }
         this.enhancerSlots[param1].gotoAndStop(_loc4_);
      }
      
      private function getEnhancerSlotByPlayerItemID(param1:uint) : Number
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._equippedEnhancers.length)
         {
            if(this._equippedEnhancers[_loc2_] != null)
            {
               if(this._equippedEnhancers[_loc2_].item.ID == param1)
               {
                  return _loc2_;
               }
            }
            _loc2_++;
         }
         return -1;
      }
      
      override public function canItemBeAddedAsSource(param1:Number) : Boolean
      {
         var _loc2_:BMItemData = dataM.myPlayerData.getItemBy(param1);
         if(_loc2_.isEnhancer == false)
         {
            return false;
         }
         var _loc3_:Array = this.getEmptyEnhancerSlotsByType(_loc2_.damageType);
         return _loc3_.length > 0;
      }
      
      private function createAllEquippedEnhancers() : void
      {
         this._equippedEnhancers = new Vector.<BMTileListItem>();
         var _loc1_:BMItemData = dataM.myPlayerData.getItemBy(this.targetItemPlayerItemID);
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.enhancerSlots.length)
         {
            this._equippedEnhancers.push(null);
            _loc2_++;
         }
      }
      
      private function getEmptyEnhancerSlotsByType(param1:uint) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:Array = new Array();
         var _loc3_:Array = this.getAllEnhancerSlotsByType(param1);
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = uint(_loc3_[_loc4_]);
            if(this._equippedEnhancers[_loc5_] == null)
            {
               _loc2_.push(_loc5_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function getAllEnhancerSlotsByType(param1:uint) : Array
      {
         var _loc2_:BMItemData = dataM.myPlayerData.getItemBy(this.targetItemPlayerItemID);
         var _loc3_:Array = new Array();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.enhancerSlots.length)
         {
            if(_loc2_.enhancerSlots[_loc4_] == param1)
            {
               _loc3_.push(_loc4_);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      override public function get targetItemPlayerItemID() : uint
      {
         if(this._targetItem == null)
         {
            return 0;
         }
         return this._targetItem.tileListItemID;
      }
      
      override public function addToSource(param1:Number) : void
      {
         if(this.isSourceFull())
         {
            return;
         }
         var _loc2_:BMItemData = dataM.myPlayerData.getItemBy(param1);
         var _loc3_:Array = this.getEmptyEnhancerSlotsByType(_loc2_.damageType);
         if(_loc3_.length == 0)
         {
            throw Error("BMUpgradeEnhancerPanel cannot add to source, no empty slots");
         }
         this.addEquippedEnhancer(_loc3_[0],param1);
      }
      
      override public function allowClickOnUpgrade() : Boolean
      {
         return this.isSourceFull() && Boolean(super.allowClickOnUpgrade());
      }
      
      private function refreshUpgardeState() : void
      {
      }
      
      private function onSourceItemClicked(param1:Number, param2:Number) : void
      {
         this.removeFromSource(param2);
      }
      
      public function tryToRemoveSourceItemByPlayerItemID(param1:uint) : void
      {
         var _loc2_:int = this.getEnhancerSlotByPlayerItemID(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         this.onSourceItemClicked(_loc2_,param1);
      }
      
      override public function removeFromSource(param1:Number) : void
      {
         var _loc2_:int = this.getEnhancerSlotByPlayerItemID(param1);
         if(_loc2_ == -1)
         {
            throw Error("BMUpgradeEnhancerPanel removeFromSource cannot find enhancer in slot");
         }
         this.removeEnhancer(_loc2_,param1);
         dispatchEvent(new DataEvent(ON_SOURCE_REMOVED,false,false,param1.toString()));
      }
      
      private function onTargetItemClicked(param1:Number, param2:Number) : void
      {
         dispatchEvent(new DataEvent(ON_TAGET_REMOVED));
      }
      
      override public function isSourceFull() : Boolean
      {
         return false;
      }
      
      override public function isItemInSource(param1:Number) : Boolean
      {
         return false;
      }
      
      override public function reset() : void
      {
      }
      
      override public function getSourcePlayerItemIDs() : Array
      {
         return new Array();
      }
      
      override public function getNumOfSource() : int
      {
         return 0;
      }
      
      override public function doUpgrade() : void
      {
      }
      
      override public function onUpgradeSuccess() : void
      {
      }
      
      private function onEnhancersChanged() : void
      {
         this.refreshCost();
         this.refreshSpecialAbilitiesText();
      }
      
      private function refreshCost() : void
      {
         _cost = BMMechSpecialAbilitiesResolver.getCostForEnhancersModification(this.targetItemPlayerItemID,this.equippedEnhancersPlayerItemIDs);
      }
      
      private function get equippedEnhancersPlayerItemIDs() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < this._equippedEnhancers.length)
         {
            if(this._equippedEnhancers[_loc2_] == null)
            {
               _loc1_.push(0);
            }
            else
            {
               _loc1_.push(this._equippedEnhancers[_loc2_].item.ID);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function refreshSpecialAbilitiesText() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:BMItemData = null;
         var _loc1_:String = "";
         var _loc2_:uint = 0;
         while(_loc2_ < this._equippedEnhancers.length)
         {
            if(this._equippedEnhancers[_loc2_] != null)
            {
               _loc3_ = this._equippedEnhancers[_loc2_].item.ID;
               _loc4_ = dataM.myPlayerData.getItemBy(_loc3_);
               if(_loc1_ != "")
               {
                  _loc1_ += "<BR>";
               }
               _loc1_ += BMMechSpecialAbilitiesResolver.getItemSpecialAbilityDescription(_loc4_.itemID);
            }
            _loc2_++;
         }
         updateTextAndFormat(this.txtSpecialAbilities,_loc1_);
      }
      
      private function removeAllEnhancerSlots() : void
      {
         var _loc2_:MovieClip = null;
         if(this.enhancerSlots == null)
         {
            this.enhancerSlots = new Array();
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this.enhancerSlots.length)
         {
            _loc2_ = this.enhancerSlots[_loc1_];
            _loc2_.parent.removeChild(_loc2_);
            _loc2_ = null;
            _loc1_++;
         }
         this.enhancerSlots = new Array();
      }
      
      private function closeClicked(param1:Event) : void
      {
         dispatchEvent(new DataEvent(ON_TAGET_REMOVED));
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeAllEnhancerSlots();
      }
   }
}

