package net.battleMechsMulti.screens.clan.listRow
{
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class ClanMemberListHeader extends BMMovieClip
   {
      
      public var txtLevel:TextField;
      
      public var txtName:TextField;
      
      public var txtArenaPoints:TextField;
      
      public var txtWins:TextField;
      
      public var txtLastOnline:TextField;
      
      public function ClanMemberListHeader()
      {
         super();
      }
      
      public function initialize(param1:String, param2:String, param3:String, param4:String, param5:String) : void
      {
         updateTextAndFormat(this.txtLevel,param1);
         updateTextAndFormat(this.txtName,param2);
         updateTextAndFormat(this.txtArenaPoints,param3);
         updateTextAndFormat(this.txtWins,param4);
         updateTextAndFormat(this.txtLastOnline,param5);
      }
   }
}

