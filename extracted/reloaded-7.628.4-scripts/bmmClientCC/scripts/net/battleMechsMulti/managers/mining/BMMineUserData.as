package net.battleMechsMulti.managers.mining
{
   public class BMMineUserData
   {
      
      public var tokens:uint;
      
      public var balance:uint;
      
      public var total:uint;
      
      public var withdrawn:uint;
      
      public function BMMineUserData(param1:Object)
      {
         super();
         this.tokens = param1.tokens;
         this.balance = param1.balance;
         this.total = param1.total;
         this.withdrawn = param1.withdrawn;
      }
   }
}

