package net.battleMechsMulti.screens.clan.listRow
{
   public class ClanListRowDataForBossLeaderboard extends ClanListRowData
   {
      
      public var tickets:uint;
      
      public var damage:uint;
      
      public var prize_clanCoins:uint;
      
      public var prize_gold:int;
      
      public var hideTickets:Boolean;
      
      public function ClanListRowDataForBossLeaderboard(param1:uint, param2:String, param3:uint, param4:String, param5:uint, param6:uint, param7:uint, param8:int, param9:Boolean)
      {
         super();
         level = param1;
         name = param2;
         rankIconNumber = param3;
         flag = param4;
         this.tickets = param5;
         this.damage = param6;
         this.prize_clanCoins = param7;
         this.prize_gold = param8;
         this.hideTickets = param9;
      }
   }
}

