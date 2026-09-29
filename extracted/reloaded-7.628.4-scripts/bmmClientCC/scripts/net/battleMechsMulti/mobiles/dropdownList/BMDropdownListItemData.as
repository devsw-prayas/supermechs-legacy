package net.battleMechsMulti.mobiles.dropdownList
{
   public class BMDropdownListItemData
   {
      
      public var itemID:uint;
      
      public var iconName:String;
      
      public var iconSource:String;
      
      public var text:String;
      
      public function BMDropdownListItemData(param1:uint, param2:String, param3:String, param4:String)
      {
         super();
         this.itemID = param1;
         this.iconName = param2;
         this.iconSource = param3;
         this.text = param4;
      }
   }
}

