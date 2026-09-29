package net.battleMechsMulti.screens.clan.listRow
{
   public class ClanListRowDataForBossDamageLeaderboard extends ClanListRowData
   {
      
      public var damage:uint;
      
      public function ClanListRowDataForBossDamageLeaderboard(param1:String, param2:uint, param3:uint)
      {
         super();
         name = param1;
         rankIconNumber = param2;
         this.damage = param3;
      }
   }
}

