package net.battleMechsMulti.data
{
   public class ClanWarLastWarInfo
   {
      
      public var available:Boolean = false;
      
      public var enemyClanName:String;
      
      public var enemyClanFlag:String;
      
      public var enemyClanLeaderName:String;
      
      public var enemyClanLadderProgress:uint;
      
      public var myClanAttackScores:Array;
      
      public var myClanTeamsTotalScore:uint;
      
      public var enemyClanAttackScores:Array;
      
      public var enemyClanTeamsTotalScore:uint;
      
      public var myClanWon:Boolean;
      
      public function ClanWarLastWarInfo()
      {
         super();
      }
   }
}

