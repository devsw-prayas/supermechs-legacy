package net.battleMechsMulti.data
{
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class BMClanMemberData
   {
      
      public var playerID:uint;
      
      public var name:String;
      
      public var level:uint;
      
      public var ladderProgress:uint;
      
      public var geo:String;
      
      public var lastLogin:String;
      
      public var isOnline:Boolean;
      
      public var bossTickets:uint;
      
      public var bossDamage:uint;
      
      public var clanCoinPrize:uint;
      
      public var clanPointsWinPrize:uint;
      
      public var clanPointsLosePrize:uint;
      
      public var rankedValue:uint;
      
      public var ladderWins:uint;
      
      public var lastDevice:uint;
      
      public function BMClanMemberData()
      {
         super();
      }
      
      private static function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      public function SetData(param1:Object) : void
      {
         this.playerID = param1.playerID;
         this.name = dataM.getCensoredString(param1.name);
         this.level = param1.level;
         this.ladderProgress = param1.ladderProgress;
         this.geo = param1.geo;
         this.rankedValue = param1.rankedValue;
         this.ladderWins = param1.ladderWins;
         this.lastLogin = param1.lastLogin;
         this.isOnline = false;
         this.bossTickets = param1.bossTickets;
         this.bossDamage = param1.bossDamage;
         this.clanCoinPrize = param1.clanCoinPrize;
         this.clanPointsWinPrize = param1.clanPointsWinPrize;
         this.clanPointsLosePrize = param1.clanPointsLosePrize;
         this.lastDevice = param1.lastDevice;
      }
   }
}

