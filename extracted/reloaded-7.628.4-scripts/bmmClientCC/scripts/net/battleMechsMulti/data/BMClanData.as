package net.battleMechsMulti.data
{
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class BMClanData
   {
      
      public var clanID:uint;
      
      public var name:String;
      
      public var leaderID:uint;
      
      private var _leaderName:String = "";
      
      public var ladderProgress:uint;
      
      public var ladderBattles:uint;
      
      public var ladderWins:uint;
      
      public var members:Vector.<BMClanMemberData> = new Vector.<BMClanMemberData>();
      
      public var flag:String;
      
      public function BMClanData()
      {
         super();
      }
      
      private static function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      public function SetData(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:BMClanMemberData = null;
         this.clanID = param1.clanID;
         this.name = dataM.getCensoredString(param1.name);
         this.leaderID = param1.leaderID;
         if(param1.leaderName != "")
         {
            this._leaderName = param1.leaderName;
         }
         this.ladderProgress = param1.ladderProgress;
         this.ladderBattles = param1.ladderBattles;
         this.ladderWins = param1.ladderWins;
         this.flag = "";
         if(param1.membersList != null)
         {
            this.flag = param1.flag;
            param1.membersList = param1.membersList.sortOn("ladderProgress",Array.DESCENDING | Array.NUMERIC);
            var _loc2_:uint = 0;
            while(_loc2_ < param1.membersList.length)
            {
               _loc3_ = param1.membersList[_loc2_];
               _loc4_ = new BMClanMemberData();
               _loc4_.SetData(_loc3_);
               this.members.push(_loc4_);
               _loc2_++;
            }
            return;
         }
         TsLogger.log("Warning!!! BMClanData SetData membersList data is null");
      }
      
      public function getClanMemberByPlayerID(param1:uint) : BMClanMemberData
      {
         var _loc3_:BMClanMemberData = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.members.length)
         {
            _loc3_ = this.members[_loc2_];
            if(_loc3_.playerID == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get leaderName() : String
      {
         if(this._leaderName != "")
         {
            return this._leaderName;
         }
         var _loc1_:BMClanMemberData = this.getClanMemberByPlayerID(this.leaderID);
         if(_loc1_ == null)
         {
            return "";
         }
         return _loc1_.name;
      }
   }
}

