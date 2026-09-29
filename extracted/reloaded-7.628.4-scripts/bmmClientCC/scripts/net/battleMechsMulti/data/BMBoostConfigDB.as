package net.battleMechsMulti.data
{
   public class BMBoostConfigDB
   {
      
      public var subtypeContributionBonus:Number = 1;
      
      public var elementContributionBonus:Number = 1;
      
      public function BMBoostConfigDB(param1:Object)
      {
         super();
         this.subtypeContributionBonus = param1.subtypeContributionBonus;
         this.elementContributionBonus = param1.elementContributionBonus;
      }
   }
}

