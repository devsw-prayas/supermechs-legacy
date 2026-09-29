package net.battleMechsMulti.mobiles.itemList
{
   public interface BMInterfaceItemView
   {
      
      function setData(param1:Object) : void;
      
      function isEnabled() : Boolean;
      
      function get ID() : uint;
      
      function getItemWidth() : Number;
      
      function getItemHeight() : Number;
      
      function removeMe() : void;
   }
}

