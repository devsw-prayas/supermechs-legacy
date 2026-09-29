package net.battleMechsMulti.data
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   
   public class ClanWarPlayerData
   {
      
      public static const arrayStructure:Array = [BMMechStructure.TORSO,BMMechStructure.LEG,BMMechStructure.SIDE_WEAPON_1,BMMechStructure.SIDE_WEAPON_2,BMMechStructure.SIDE_WEAPON_3,BMMechStructure.SIDE_WEAPON_4,BMMechStructure.TOP_WEAPON_1,BMMechStructure.TOP_WEAPON_2,BMMechStructure.MODULE_1,BMMechStructure.MODULE_2,BMMechStructure.MODULE_3,BMMechStructure.MODULE_4,BMMechStructure.MODULE_5,BMMechStructure.MODULE_6,BMMechStructure.MODULE_7,BMMechStructure.MODULE_8,BMMechStructure.DRONE,BMMechStructure.TELEPORT,BMMechStructure.CHARGE,BMMechStructure.HARPOON,BMMechStructure.SHIELD,BMMechStructure.PERK];
      
      public var playerID:uint;
      
      public var playerName:String;
      
      public var ladderProgress:uint;
      
      public var mechStructures:Vector.<BMMechStructure> = new Vector.<BMMechStructure>();
      
      public var skills:Array = new Array();
      
      public var attacksMax:uint;
      
      public var attacksLeft:uint;
      
      public var attacks:Vector.<ClanWarAttackData> = new Vector.<ClanWarAttackData>();
      
      private var p_teamMaxScore:uint;
      
      public var teamPowerRating:uint;
      
      public var isFake:Boolean;
      
      public function ClanWarPlayerData(param1:uint, param2:String, param3:uint, param4:Array, param5:Array, param6:uint, param7:uint, param8:Array, param9:Boolean)
      {
         var _loc10_:String = null;
         var _loc11_:uint = 0;
         var _loc12_:Array = null;
         var _loc13_:ClanWarAttackData = null;
         var _loc14_:BMMechStructure = null;
         var _loc15_:uint = 0;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:BMItemData = null;
         var _loc21_:Array = null;
         super();
         this.playerID = param1;
         this.playerName = param2;
         this.ladderProgress = param3;
         this.attacksMax = param6;
         this.attacksLeft = param7;
         this.isFake = param9;
         for each(_loc10_ in param8)
         {
            _loc12_ = _loc10_.split("_");
            _loc13_ = new ClanWarAttackData(this.playerID,int(_loc12_[0]),int(_loc12_[1]));
            this.attacks.push(_loc13_);
         }
         this.skills = param5.concat();
         this.teamPowerRating = 0;
         _loc11_ = 1;
         loop1:
         while(_loc11_ <= param4.length)
         {
            _loc14_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
            _loc14_.initialize(0,_loc11_);
            _loc15_ = 0;
            while(true)
            {
               if(_loc15_ >= param4[_loc11_ - 1].length)
               {
                  this.mechStructures.push(_loc14_);
                  _loc11_++;
                  continue loop1;
               }
               _loc16_ = arrayStructure[_loc15_];
               _loc17_ = param4[_loc11_ - 1][_loc15_];
               _loc19_ = 0;
               if(_loc17_.indexOf("-") > -1)
               {
                  _loc21_ = _loc17_.split("-");
                  _loc18_ = uint(int(_loc21_[0]));
                  _loc19_ = uint(int(_loc21_[1]));
               }
               else
               {
                  _loc18_ = uint(int(_loc17_));
               }
               _loc14_[_loc16_] = _loc18_;
               if(_loc18_ != 0)
               {
                  _loc20_ = BMDataManager.getInstance().itemsDB[_loc18_];
                  if(_loc20_ == null)
                  {
                     break;
                  }
                  this.teamPowerRating += _loc20_.powerRating;
                  if(_loc20_.canBeColored && _loc19_ > 0)
                  {
                     if(_loc14_[_loc16_ + "_colorID"] != null)
                     {
                        _loc14_[_loc16_ + "_colorID"] = _loc19_;
                     }
                  }
               }
               _loc15_++;
            }
            throw Error("item " + _loc18_ + " does not exist");
         }
         this.p_teamMaxScore = 0;
      }
      
      public function addAttackData(param1:uint, param2:uint) : void
      {
         var _loc3_:ClanWarAttackData = new ClanWarAttackData(this.playerID,param1,param2);
         this.attacks.push(_loc3_);
      }
      
      public function set teamMaxScore(param1:uint) : void
      {
         this.p_teamMaxScore = param1;
      }
      
      public function get teamMaxScore() : uint
      {
         return this.p_teamMaxScore;
      }
   }
}

