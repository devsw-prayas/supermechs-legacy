package net.battleMechsMulti.screens.clan.listRow
{
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class ClanBossLeaderboardListHeader extends BMMovieClip
   {
      
      public var txtLevel:TextField;
      
      public var txtName:TextField;
      
      public var txtTickets:TextField;
      
      public var txtDamage:TextField;
      
      public var txtPrize:TextField;
      
      public function ClanBossLeaderboardListHeader()
      {
         super();
      }
      
      public function initialize(param1:String, param2:String, param3:String, param4:String, param5:String) : void
      {
         updateTextAndFormat(this.txtLevel,param1);
         updateTextAndFormat(this.txtName,param2);
         updateTextAndFormat(this.txtTickets,param3);
         updateTextAndFormat(this.txtDamage,param4);
         updateTextAndFormat(this.txtPrize,param5);
      }
   }
}

