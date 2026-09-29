package net.battleMechsMulti.managers.upgrade
{
   public class BMPotentialBoostInfo
   {
      
      public var playerItemIDsToAddToSource:Array;
      
      public var targetItemDisplayLevelAfterBoost:uint;
      
      public function BMPotentialBoostInfo(param1:Array, param2:uint)
      {
         super();
         this.playerItemIDsToAddToSource = param1;
         this.targetItemDisplayLevelAfterBoost = param2;
      }
   }
}

