package net.battleMechsMulti.mobiles
{
   public class BMReplayData
   {
      
      public var replayID:Number;
      
      public var tsCreated:Number;
      
      public var playerID1:Number;
      
      public var playerID2:Number;
      
      public var playerName1:String;
      
      public var playerName2:String;
      
      public var level1:Number;
      
      public var level2:Number;
      
      public var flag1:String;
      
      public var flag2:String;
      
      public var mapStepsTotal:Number;
      
      public var player1MechStructures:Array = new Array();
      
      public var player2MechStructures:Array = new Array();
      
      public var actions:Array = new Array();
      
      public var status1:Array = new Array();
      
      public var status2:Array = new Array();
      
      public var statusBackup1:String;
      
      public var statusBackup2:String;
      
      public var floorBuffs:String = "";
      
      public var numberOfTurns:Number;
      
      public var wonPlayerID:Number = 0;
      
      public var quitPlayerID:Number = 0;
      
      public var watched:Boolean = false;
      
      public var database:Object;
      
      public var replayInverted:Boolean = false;
      
      public var battleMechsPerPlayer:Number = 1;
      
      public function BMReplayData()
      {
         super();
      }
   }
}

