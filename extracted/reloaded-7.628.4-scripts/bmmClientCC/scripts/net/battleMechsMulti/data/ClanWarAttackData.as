package net.battleMechsMulti.data
{
   public class ClanWarAttackData
   {
      
      public var attackerPlayerID:uint;
      
      public var defenderPlayerID:uint;
      
      public var score:uint;
      
      public function ClanWarAttackData(param1:uint, param2:uint, param3:uint)
      {
         super();
         this.attackerPlayerID = param1;
         this.defenderPlayerID = param2;
         this.score = param3;
      }
   }
}

