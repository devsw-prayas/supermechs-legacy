package net.battleMechsMulti.screens.clan
{
   import net.battleMechsMulti.data.BMRewardData;
   
   public class BMClanRewardData
   {
      
      public var winsRequired:uint;
      
      public var rewardData:BMRewardData;
      
      public function BMClanRewardData(param1:*, param2:Object)
      {
         super();
         this.winsRequired = param1;
         this.rewardData = new BMRewardData(param2);
      }
   }
}

