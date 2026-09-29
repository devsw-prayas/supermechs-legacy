package net.battleMechsMulti.screens.clan.listRow
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class ClanBossLeaderboardListRow extends ClanListRow
   {
      
      public var txtTickets:TextField;
      
      public var txtDamage:TextField;
      
      public var txtPrize_clanCoins:TextField;
      
      public var txtPrize_gold:TextField;
      
      public var mcTicket:Sprite;
      
      public var mcGold:Sprite;
      
      public function ClanBossLeaderboardListRow()
      {
         super();
      }
      
      override public function initialize(param1:ClanListRowData) : void
      {
         initializeSub(param1);
         var _loc2_:ClanListRowDataForBossLeaderboard = param1 as ClanListRowDataForBossLeaderboard;
         if(_loc2_.hideTickets)
         {
            this.mcTicket.visible = false;
            this.txtTickets.text = "";
         }
         else
         {
            updateTextAndFormat(this.txtTickets,TextUtils.getNumberWithComma(_loc2_.tickets));
         }
         updateTextAndFormat(this.txtDamage,TextUtils.getNumberWithComma(_loc2_.damage));
         updateTextAndFormat(this.txtPrize_clanCoins,TextUtils.getNumberWithComma(_loc2_.prize_clanCoins));
         if(_loc2_.prize_gold == -1)
         {
            updateTextAndFormat(this.txtPrize_gold,"");
            this.mcGold.visible = false;
         }
         else
         {
            updateTextAndFormat(this.txtPrize_gold,TextUtils.getNumberWithComma(_loc2_.prize_gold));
         }
      }
   }
}

