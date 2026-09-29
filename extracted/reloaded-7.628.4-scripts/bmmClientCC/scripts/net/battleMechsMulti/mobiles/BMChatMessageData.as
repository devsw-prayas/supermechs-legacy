package net.battleMechsMulti.mobiles
{
   import net.battleMechsMulti.managers.chat.BMChatData;
   
   public class BMChatMessageData
   {
      
      public var slot:uint;
      
      public var type:String;
      
      public var channelID:Number;
      
      public var fromPlayerID:Number;
      
      public var toPlayerID:Number;
      
      public var specialPlayerID:Number = 0;
      
      public var message:String;
      
      public var rowsInLog:Array = new Array();
      
      public var name:String;
      
      public var level:uint;
      
      public var ladderProgress:uint;
      
      public var geo:String;
      
      public var lastDevice:uint;
      
      public var clanID:Number;
      
      public var clanName:String;
      
      public var mechsPerPlayer:uint;
      
      public function BMChatMessageData()
      {
         super();
      }
      
      public function initializeMessage(param1:uint, param2:Number, param3:Number, param4:Number, param5:String, param6:String = "", param7:uint = 0, param8:uint = 0, param9:uint = 0, param10:Number = 0, param11:String = "") : void
      {
         this.type = BMChatData.MSG_TYPE_REGULAR;
         this.slot = param1;
         this.channelID = param2;
         this.fromPlayerID = param3;
         this.toPlayerID = param4;
         this.message = param5;
         this.name = param6;
         this.level = param7;
         this.ladderProgress = param8;
         this.lastDevice = param9;
         this.clanID = param10;
         this.clanName = param11;
      }
      
      public function initializePrivateMessageAlert(param1:uint, param2:Number, param3:Number, param4:Number, param5:String, param6:String, param7:Number) : void
      {
         this.type = BMChatData.MSG_TYPE_PRIVATE_MESSAGE_ALERT;
         this.slot = param1;
         this.channelID = param2;
         this.fromPlayerID = param3;
         this.toPlayerID = param4;
         this.message = param5;
         this.name = param6;
         this.specialPlayerID = param7;
      }
      
      public function initializeClanMessageAlert(param1:uint, param2:Number, param3:Number, param4:Number, param5:String, param6:String, param7:Number) : void
      {
         this.type = BMChatData.MSG_TYPE_CLAN_MESSAGE_ALERT;
         this.slot = param1;
         this.channelID = param2;
         this.fromPlayerID = param3;
         this.toPlayerID = param4;
         this.message = param5;
         this.name = param6;
         this.specialPlayerID = param7;
      }
      
      public function initializeClanInvitation(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number, param6:String, param7:String, param8:Number, param9:String) : void
      {
         this.type = BMChatData.MSG_TYPE_CLAN_INVITATION;
         this.slot = param1;
         this.channelID = param2;
         this.fromPlayerID = param3;
         this.toPlayerID = param4;
         this.message = param6;
         this.specialPlayerID = param5;
         this.name = param7;
         this.clanID = param8;
         this.clanName = param9;
      }
      
      public function initializeBattleInvitation(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number, param6:String, param7:String, param8:uint, param9:uint) : void
      {
         this.type = BMChatData.MSG_TYPE_BATTLE_INVITATION;
         this.slot = param1;
         this.channelID = param2;
         this.fromPlayerID = param3;
         this.toPlayerID = param4;
         this.specialPlayerID = param5;
         this.message = param6;
         this.name = param7;
         this.level = param8;
         this.mechsPerPlayer = param9;
      }
      
      public function initializeWinningWall(param1:uint, param2:String) : void
      {
         this.type = BMChatData.MSG_TYPE_WINNING_WALL;
         this.slot = param1;
         this.message = param2;
      }
      
      public function initializeTip() : void
      {
         this.type = "tip";
      }
   }
}

