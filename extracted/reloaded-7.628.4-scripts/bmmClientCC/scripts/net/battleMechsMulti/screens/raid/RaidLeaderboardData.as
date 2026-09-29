package net.battleMechsMulti.screens.raid
{
   public class RaidLeaderboardData
   {
      
      public var playerID:uint;
      
      public var rank:uint;
      
      public var score:uint;
      
      public var raidLevel:uint;
      
      public var name:String;
      
      public var ladderProgress:uint;
      
      public var clanID:uint;
      
      public var gold:uint;
      
      public var tokens:uint;
      
      public var geo:String;
      
      public var progression:int;
      
      public function RaidLeaderboardData(param1:uint, param2:uint, param3:uint, param4:uint, param5:String, param6:uint, param7:uint, param8:uint, param9:uint, param10:String, param11:int)
      {
         super();
         this.playerID = param1;
         this.rank = param2;
         this.score = param3;
         this.raidLevel = param4;
         this.name = param5;
         this.ladderProgress = param6;
         this.clanID = param7;
         this.gold = param8;
         this.tokens = param9;
         this.geo = param10;
         this.progression = param11;
      }
   }
}

