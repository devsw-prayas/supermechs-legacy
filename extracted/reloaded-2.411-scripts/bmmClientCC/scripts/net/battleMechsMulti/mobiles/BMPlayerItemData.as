package net.battleMechsMulti.mobiles
{
   public class BMPlayerItemData
   {
      
      public static const UPGRADABLE_ITEM_TYPES:Array = ["torso","leg","sideWeapon","topWeapon","torso","torso","drone","charge","harpoon","teleport","kit"];
      
      public var itemID:Number;
      
      public var playerItemID:Number;
      
      public var equipmentType:String;
      
      public var equipmentID:Number;
      
      public var equipped:Number;
      
      public var power:Number = 0;
      
      public var weight:uint = 0;
      
      public var colorID:Number;
      
      public var durability:uint = 0;
      
      public function BMPlayerItemData()
      {
         super();
      }
      
      public function canBeUpgarded() : *
      {
         return UPGRADABLE_ITEM_TYPES.indexOf(this.equipmentType) != -1;
      }
   }
}

