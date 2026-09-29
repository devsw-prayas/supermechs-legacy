package net.battleMechsMulti.screens.hanger.upgrade
{
   import net.battleMechsMulti.managers.upgrade.BMItemUpgradeData;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMUpgradeBasePanel extends BMBaseScreen
   {
      
      public static const ON_SOURCE_REMOVED:String = "ON_SOURCE_REMOVED";
      
      public static const ON_ALL_SOURCE_ITEMS_REMOVED:String = "ON_ALL_SOURCE_ITEMS_REMOVED";
      
      public static const ON_TAGET_REMOVED:String = "ON_TAGET_REMOVED";
      
      public static const ON_ASCEND_CLICKED:String = "ON_ASCEND_CLICKED";
      
      public static const ON_ENHANCE_CLICKED:String = "ON_ENHANCE_CLICKED";
      
      protected var _cost:int = 0;
      
      protected var _isInUpgradeBatch:Boolean = false;
      
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
      
      public function isSourceEmpty() : Boolean
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
      
      public function removeAllSourceItems() : void
      {
      }
      
      public function setTarget(param1:Number) : void
      {
      }
      
      public function canItemBeAddedAsSource(param1:Number) : Boolean
      {
         return true;
      }
      
      public function addToSource(param1:Number) : void
      {
      }
      
      public function reset() : void
      {
      }
      
      public function get targetItemPlayerItemID() : uint
      {
         return 0;
      }
      
      public function getSourcePlayerItemIDs() : Array
      {
         return null;
      }
      
      public function getNumOfSource() : int
      {
         return 0;
      }
      
      public function allowClickOnUpgrade() : Boolean
      {
         return this.getNumOfSource() > 0;
      }
      
      public function getUpgardedData() : BMItemUpgradeData
      {
         return null;
      }
      
      public function isTargetMaxLevel() : Boolean
      {
         return false;
      }
      
      public function doUpgrade() : void
      {
      }
      
      public function onUpgradeSuccess() : void
      {
      }
      
      public function beginAddToSourceBatch() : void
      {
         this._isInUpgradeBatch = true;
      }
      
      public function endAddToSourceBatch() : void
      {
         this._isInUpgradeBatch = false;
      }
      
      public function get isInAddToSourceBatch() : Boolean
      {
         return this._isInUpgradeBatch;
      }
   }
}

