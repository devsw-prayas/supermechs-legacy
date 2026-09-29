package net.battleMechsMulti.managers.upgrade
{
   import net.battleMechsMulti.mobiles.BMItemData;
   
   public class BMItemUpgradeData
   {
      
      public var newItemData:BMItemData;
      
      public var newPower:int;
      
      public var cost:int;
      
      public function BMItemUpgradeData(param1:BMItemData, param2:int, param3:int)
      {
         super();
         this.newItemData = param1;
         this.newPower = param2;
         this.cost = param3;
      }
   }
}

