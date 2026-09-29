package net.battleMechsMulti.screens.clan.listRow
{
   import flash.text.TextField;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class ClanBossDamageLeaderboardListRow extends ClanListRow
   {
      
      public var txtDamage:TextField;
      
      public function ClanBossDamageLeaderboardListRow()
      {
         super();
      }
      
      override public function initialize(param1:ClanListRowData) : void
      {
         initializeSub(param1);
         var _loc2_:ClanListRowDataForBossDamageLeaderboard = param1 as ClanListRowDataForBossDamageLeaderboard;
         updateTextAndFormat(this.txtDamage,TextUtils.getNumberWithComma(_loc2_.damage));
      }
   }
}

