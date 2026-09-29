package net.battleMechsMulti.screens.clan.listRow
{
   public class ClanWarMemberListRow extends ClanListRow
   {
      
      public function ClanWarMemberListRow()
      {
         super();
      }
      
      override public function initialize(param1:ClanListRowData) : void
      {
         initializeSub(param1);
         var _loc2_:ClanListRowDataForWarMembers = param1 as ClanListRowDataForWarMembers;
      }
   }
}

