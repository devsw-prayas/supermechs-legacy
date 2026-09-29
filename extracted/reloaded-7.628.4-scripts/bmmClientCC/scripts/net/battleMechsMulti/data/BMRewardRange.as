package net.battleMechsMulti.data
{
   public class BMRewardRange
   {
      
      public var min:BMRewardData;
      
      public var max:BMRewardData;
      
      public function BMRewardRange(param1:Object = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.min = new BMRewardData(param1["min"]);
         this.max = new BMRewardData(param1["max"]);
      }
   }
}

