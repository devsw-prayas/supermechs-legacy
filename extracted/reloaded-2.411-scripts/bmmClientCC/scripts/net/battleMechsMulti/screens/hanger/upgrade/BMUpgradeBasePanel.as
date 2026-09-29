package net.battleMechsMulti.screens.hanger.upgrade
{
   import net.battleMechsMulti.managers.upgrade.BMItemUpgradeData;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMUpgradeBasePanel extends BMBaseScreen
   {
      
      public static const ON_SOURCE_REMOVED:String = "ON_SOURCE_REMOVED";
      
      public static const ON_TAGET_REMOVED:String = "ON_TAGET_REMOVED";
      
      protected var _cost:int = 0;
      
      public function BMUpgradeBasePanel()
      {
         super();
      }
      
      public function get cost() : int
      {
         return this._cost;
      }
      
      public function isSourceFull() : Boolean
      {
         return false;
      }
      
      public function isItemInSource(param1:Number) : Boolean
      {
         return false;
      }
      
      public function removeFromSource(param1:Number) : void
      {
      }
      
      public function setTarget(param1:Number) : void
      {
      }
      
      public function addToSource(param1:Number) : void
      {
      }
      
      public function reset() : void
      {
      }
      
      public function getSourcePlayerItemIDs() : Array
      {
         return null;
      }
      
      public function getNumOfSource() : int
      {
         return 0;
      }
      
      public function getUpgardedData() : BMItemUpgradeData
      {
         return null;
      }
      
      public function doUpgrade() : void
      {
      }
      
      public function onUpgradeSuccess() : void
      {
      }
   }
}

