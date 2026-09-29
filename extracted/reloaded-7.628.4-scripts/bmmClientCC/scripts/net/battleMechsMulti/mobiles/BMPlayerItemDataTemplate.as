package net.battleMechsMulti.mobiles
{
   public class BMPlayerItemDataTemplate
   {
      
      public var itemID:Number = 0;
      
      public var equipmentType:String = "";
      
      public var equipmentID:Number = 0;
      
      public var equipped:Number = 0;
      
      public var power:Number = 0;
      
      public var weight:uint = 0;
      
      public var colorID:Number;
      
      public var durability:uint = 0;
      
      public function BMPlayerItemDataTemplate()
      {
         super();
      }
      
      public static function parsePlayerItemData(param1:Object) : BMPlayerItemDataTemplate
      {
         var _loc2_:BMPlayerItemDataTemplate = new BMPlayerItemDataTemplate();
         _loc2_.itemID = param1.itemID;
         _loc2_.colorID = param1.colorID;
         _loc2_.setSlotName(param1.slotName);
         return _loc2_;
      }
      
      public function BMPlayerItemData() : *
      {
      }
      
      public function getSlotName() : String
      {
         switch(this.equipmentType)
         {
            case BMMechStructure.SIDE_WEAPON:
            case BMMechStructure.TOP_WEAPON:
            case BMMechStructure.KIT:
            case BMMechStructure.MODULE:
               return this.equipmentType + this.equipmentID;
            default:
               return this.equipmentType;
         }
      }
      
      public function setSlotName(param1:String) : void
      {
         var _loc2_:Number = Number(param1.substr(param1.length - 1,1));
         if(isNaN(_loc2_))
         {
            this.equipmentType = param1;
            this.equipmentID = 0;
         }
         else
         {
            this.equipmentType = param1.substr(0,param1.length - 1);
            this.equipmentID = int(_loc2_);
         }
      }
      
      public function resetEquippedData() : void
      {
         this.equipmentID = 0;
         this.equipped = 0;
      }
   }
}

