package net.battleMechsMulti.managers.mining
{
   public class BMMineWithdrawData
   {
      
      public var tokens:uint;
      
      public var hashes:uint;
      
      public function BMMineWithdrawData(param1:Object)
      {
         super();
         this.tokens = param1.tokens;
         this.hashes = param1.hashes;
      }
   }
}

