package net.battleMechsMulti.mobiles.itemComparison
{
   public class BMOneClickBoostProperties
   {
      
      public var recommendationMaxLevel:uint;
      
      public var minBoostLevelsForBoost:uint;
      
      public var itemTypesRecommendationOrder:Array;
      
      public function BMOneClickBoostProperties(param1:uint, param2:uint, param3:Array)
      {
         super();
         this.recommendationMaxLevel = param1;
         this.minBoostLevelsForBoost = param2;
         this.itemTypesRecommendationOrder = param3;
      }
   }
}

