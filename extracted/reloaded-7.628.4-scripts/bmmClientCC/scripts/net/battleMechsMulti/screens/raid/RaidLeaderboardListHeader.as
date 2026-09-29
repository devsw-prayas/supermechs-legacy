package net.battleMechsMulti.screens.raid
{
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class RaidLeaderboardListHeader extends BMMovieClip
   {
      
      public var txtRank:TextField;
      
      public var txtScore:TextField;
      
      public var txtLevel:TextField;
      
      public var txtName:TextField;
      
      public var txtPrize:TextField;
      
      public function RaidLeaderboardListHeader()
      {
         super();
      }
      
      public function initialize(param1:String, param2:String, param3:String, param4:String, param5:String) : void
      {
         updateTextAndFormat(this.txtRank,param1);
         updateTextAndFormat(this.txtScore,param2);
         updateTextAndFormat(this.txtLevel,param3);
         updateTextAndFormat(this.txtName,param4);
         updateTextAndFormat(this.txtPrize,param5);
      }
   }
}

