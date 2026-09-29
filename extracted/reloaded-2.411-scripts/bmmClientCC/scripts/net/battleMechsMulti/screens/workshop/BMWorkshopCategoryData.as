package net.battleMechsMulti.screens.workshop
{
   public class BMWorkshopCategoryData
   {
      
      private var _equipmentTypesSlots:Array;
      
      private var _catImage:String;
      
      private var _slotEmptyImages:Array;
      
      public function BMWorkshopCategoryData(param1:Array, param2:String, param3:Array)
      {
         super();
         this._equipmentTypesSlots = param1;
         this._catImage = param2;
         this._slotEmptyImages = param3;
      }
      
      public function get numOfSlots() : int
      {
         return this._slotEmptyImages.length;
      }
      
      public function getEquipmentTypeAt(param1:int) : String
      {
         if(param1 >= this._equipmentTypesSlots.length)
         {
            return this._equipmentTypesSlots[0];
         }
         return this._equipmentTypesSlots[param1];
      }
      
      public function getEquipmentSlotForType(param1:String) : int
      {
         return this._equipmentTypesSlots.indexOf(param1);
      }
      
      public function get equipmentTypesSlots() : Array
      {
         return this._equipmentTypesSlots;
      }
      
      public function get catImage() : String
      {
         return this._catImage;
      }
      
      public function getSlotEmptyImage(param1:int) : String
      {
         return this._slotEmptyImages[param1];
      }
   }
}

