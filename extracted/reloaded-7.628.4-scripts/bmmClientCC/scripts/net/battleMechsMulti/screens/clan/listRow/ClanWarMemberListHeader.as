package net.battleMechsMulti.screens.clan.listRow
{
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class ClanWarMemberListHeader extends BMMovieClip
   {
      
      public var txtMembers:TextField;
      
      public function ClanWarMemberListHeader()
      {
         super();
      }
      
      public function initialize(param1:String) : void
      {
         updateTextAndFormat(this.txtMembers,param1);
      }
   }
}

