package net.battleMechsMulti.screens.clan.listRow
{
   import flash.text.TextField;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class ClanMemberListRow extends ClanListRow
   {
      
      public var txtArenaPoints:TextField;
      
      public var txtWins:TextField;
      
      public var txtLastOnline:TextField;
      
      public function ClanMemberListRow()
      {
         super();
      }
      
      override public function initialize(param1:ClanListRowData) : void
      {
         initializeSub(param1);
         var _loc2_:ClanListRowDataForMembers = param1 as ClanListRowDataForMembers;
         updateTextAndFormat(this.txtArenaPoints,TextUtils.getNumberWithComma(_loc2_.arenaPoints));
         updateTextAndFormat(this.txtWins,TextUtils.getNumberWithComma(_loc2_.wins));
         updateTextAndFormat(this.txtLastOnline,_loc2_.lastOnline);
      }
   }
}

