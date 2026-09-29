package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TweenMax;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   
   public class BMMassSelectionData
   {
      
      public static const ITEM_TYPES:Array = [BMMechStructure.TORSO,BMMechStructure.LEG,BMMechStructure.SIDE_WEAPON,BMMechStructure.TOP_WEAPON,BMMechStructure.SPECIAL,BMMechStructure.MODULE,BMMechStructure.KIT];
      
      private var _rarities:Array;
      
      private var _damageTypes:Array;
      
      private var _itemTypes:Array;
      
      private var _updateCallback:Function;
      
      public function BMMassSelectionData()
      {
         super();
         this._rarities = [false,false,false];
         this._damageTypes = [false,false,false,false];
         this._itemTypes = new Array();
         var _loc1_:uint = 0;
         while(_loc1_ < ITEM_TYPES.length)
         {
            this._itemTypes[_loc1_] = false;
            _loc1_++;
         }
      }
      
      public function setDefault() : *
      {
         this._rarities[0] = true;
         this._rarities[1] = true;
         this._rarities[2] = false;
         this._damageTypes[1] = true;
         this._damageTypes[2] = true;
         this._damageTypes[3] = true;
         this._itemTypes[0] = false;
         this.selectAllItemTypes();
      }
      
      public function setUpdateCallback(param1:Function) : void
      {
         this._updateCallback = param1;
      }
      
      private function needsLoadingPopupBeforeActions() : Boolean
      {
         return BMDataManager.getInstance().myPlayerData.items.length > 50;
      }
      
      private function dataUpdated() : void
      {
         if(this._updateCallback == null)
         {
            return;
         }
         if(this.needsLoadingPopupBeforeActions())
         {
            BMScreensManager.getInstance().screenConfirmation.displayQuestionOrNotification("pleaseWait");
            TweenMax.delayedCall(0.1,this.dataUpdatedSub);
         }
         else
         {
            this.dataUpdatedSub();
         }
      }
      
      private function dataUpdatedSub() : void
      {
         this._updateCallback();
      }
      
      public function addRarity(param1:uint) : void
      {
         this._rarities[param1] = true;
         this.dataUpdated();
      }
      
      public function removeRarity(param1:uint) : void
      {
         this._rarities[param1] = false;
         this.dataUpdated();
      }
      
      public function getRarity(param1:uint) : Boolean
      {
         return this._rarities[param1];
      }
      
      public function addDamageType(param1:uint) : void
      {
         this._damageTypes[param1] = true;
         this.dataUpdated();
      }
      
      public function removeDamageType(param1:uint) : void
      {
         this._damageTypes[param1] = false;
         this.dataUpdated();
      }
      
      public function getDamageType(param1:uint) : Boolean
      {
         return this._damageTypes[param1];
      }
      
      public function areAllDamageTypesEnabled() : Boolean
      {
         return this.getDamageType(1) && this.getDamageType(2) && this.getDamageType(3);
      }
      
      public function addItemType(param1:uint, param2:Boolean = true) : void
      {
         this._itemTypes[param1] = true;
         if(param2)
         {
            this.dataUpdated();
         }
      }
      
      public function removeItemType(param1:uint, param2:Boolean = true) : void
      {
         this._itemTypes[param1] = false;
         if(param2)
         {
            this.dataUpdated();
         }
      }
      
      public function selectAllItemTypes() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < ITEM_TYPES.length)
         {
            if(this.getItemTypeByTypeSlot(_loc2_) == false)
            {
               _loc1_++;
               this.addItemType(_loc2_,false);
            }
            _loc2_++;
         }
         if(_loc1_ > 0)
         {
            this.dataUpdated();
         }
      }
      
      public function deselectAllItemTypes() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < ITEM_TYPES.length)
         {
            if(this.getItemTypeByTypeSlot(_loc2_))
            {
               _loc1_++;
               this.removeItemType(_loc2_,false);
            }
            _loc2_++;
         }
         if(_loc1_ > 0)
         {
            this.dataUpdated();
         }
      }
      
      public function getItemTypeByTypeSlot(param1:uint) : Boolean
      {
         return this._itemTypes[param1];
      }
      
      public function getItemTypeByTypeName(param1:String) : Boolean
      {
         var _loc2_:Number = ITEM_TYPES.indexOf(param1);
         return this._itemTypes[_loc2_];
      }
   }
}

