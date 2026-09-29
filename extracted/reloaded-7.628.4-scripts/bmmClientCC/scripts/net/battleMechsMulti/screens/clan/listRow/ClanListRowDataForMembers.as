package net.battleMechsMulti.screens.clan.listRow
{
   public class ClanListRowDataForMembers extends ClanListRowData
   {
      
      public var arenaPoints:uint;
      
      public var wins:uint;
      
      public var lastOnline:String;
      
      public function ClanListRowDataForMembers(param1:uint, param2:String, param3:uint, param4:String, param5:uint, param6:uint, param7:String)
      {
         super();
         level = param1;
         name = param2;
         rankIconNumber = param3;
         this.arenaPoints = param5;
         this.wins = param6;
         this.lastOnline = param7;
         flag = param4;
      }
   }
}

