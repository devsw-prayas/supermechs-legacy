package net.battleMechsMulti.data
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   
   public class BMLevelUpData
   {
      
      public var reward:BMRewardData;
      
      public var battleCreditsMax:uint;
      
      public var inventorySlots:uint;
      
      public var newLevel:uint = 2;
      
      public function BMLevelUpData(param1:BMRewardData, param2:uint, param3:uint, param4:uint)
      {
         super();
         this.reward = param1;
         this.battleCreditsMax = param2;
         this.inventorySlots = param3;
         this.newLevel = param4;
      }
      
      public static function create(param1:Object) : BMLevelUpData
      {
         if(param1)
         {
            return new BMLevelUpData(new BMRewardData(param1.reward),param1.battleCreditsMax,param1.inventorySlots,param1.newLevel);
         }
         return new BMLevelUpData(null,0,0,0);
      }
      
      public function getGoldAmount() : uint
      {
         return this.reward?.gold;
      }
      
      public function getTokensAmount() : uint
      {
         return this.reward?.tokens;
      }
      
      public function applyData(param1:BMPlayerProfile, param2:BMDataManager) : void
      {
         if(this.reward == null)
         {
            return;
         }
      }
      
      public function get hasItemsOrBoxes() : Boolean
      {
         return this.reward != null && this.reward.hasItemsOrBoxes;
      }
      
      public function get hasItems() : Boolean
      {
         return this.reward != null && this.reward.hasItems;
      }
      
      public function get hasBoxes() : Boolean
      {
         return this.reward != null && this.reward.hasBoxes;
      }
      
      public function reset() : void
      {
         this.reward = new BMRewardData();
         this.battleCreditsMax = 8;
      }
      
      public function hasContent() : Boolean
      {
         if(this.reward != null && this.reward.hasContent || this.newLevel > 0 || this.battleCreditsMax > 0 || this.inventorySlots > 0)
         {
            return true;
         }
         return false;
      }
   }
}

