package net.battleMechsMulti.screens.missionBaseMap
{
   public class BMMissionServerToClientStats
   {
      
      public var missionID:uint;
      
      public var colorID:uint = 1;
      
      public var rows:uint = 0;
      
      public var columns:uint = 0;
      
      public var difficulty:uint = 1;
      
      public var mechsStats:Array = new Array();
      
      public var gold:uint = 0;
      
      public var xp:uint = 0;
      
      public var layout:String = "";
      
      public var loot:* = new Array();
      
      public var mode:uint = 0;
      
      public var playerPosition:uint = 0;
      
      public var progress:Array = new Array();
      
      public var startingPosition:uint = 0;
      
      public var themeID:uint = 1;
      
      public var upgrades:* = new Array();
      
      public var flag:String = "";
      
      public var raidMechsPerPlayer:uint = 0;
      
      public function BMMissionServerToClientStats()
      {
         super();
      }
      
      public function extractDataFromObject(param1:Object) : void
      {
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         this.missionID = param1.missionID;
         this.colorID = param1.colorID;
         this.rows = param1.rows;
         this.columns = param1.columns;
         this.difficulty = param1.difficulty;
         this.gold = param1.gold;
         this.xp = param1.xp;
         this.layout = param1.layout;
         this.loot = param1.loot;
         this.mode = param1.mode;
         this.playerPosition = param1.playerPosition;
         this.progress = param1.progress;
         this.startingPosition = param1.startingPosition;
         this.themeID = param1.themeID;
         this.upgrades = param1.upgrades;
         this.flag = param1.flag;
         this.raidMechsPerPlayer = param1.raidMechsPerPlayer;
         var _loc2_:String = "";
         var _loc3_:uint = 0;
         var _loc4_:BMMissionMechStats = new BMMissionMechStats();
         var _loc5_:uint = 0;
         while(_loc5_ < param1.mechData.length)
         {
            _loc6_ = param1.mechData.substr(_loc5_,1);
            _loc7_ = _loc5_ == param1.mechData.length - 1;
            if(_loc6_ == "_" || _loc6_ == "|" || _loc7_)
            {
               if(_loc5_ == param1.mechData.length - 1)
               {
                  _loc2_ += _loc6_;
               }
               switch(_loc3_)
               {
                  case 0:
                     _loc4_.hp = int(_loc2_);
                     break;
                  case 1:
                     _loc4_.energy = int(_loc2_);
                     break;
                  case 2:
                     _loc4_.energyRegeneration = int(_loc2_);
                     break;
                  case 3:
                     _loc4_.heat = int(_loc2_);
                     break;
                  case 4:
                     _loc4_.heatCooling = int(_loc2_);
                     break;
                  case 5:
                     _loc4_.bullets = int(_loc2_);
                     break;
                  case 6:
                     _loc4_.rockets = int(_loc2_);
               }
               _loc3_++;
               _loc2_ = "";
            }
            else
            {
               _loc2_ += _loc6_;
            }
            if(_loc7_ || _loc6_ == "|")
            {
               this.mechsStats.push(_loc4_);
               _loc4_ = new BMMissionMechStats();
               _loc3_ = 0;
            }
            _loc5_++;
         }
      }
   }
}

