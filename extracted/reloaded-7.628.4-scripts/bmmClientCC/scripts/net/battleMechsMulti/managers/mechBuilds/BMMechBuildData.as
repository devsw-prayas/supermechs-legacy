package net.battleMechsMulti.managers.mechBuilds
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   
   public class BMMechBuildData
   {
      
      public static const arrayStructure:Array = [BMMechStructure.TORSO,BMMechStructure.LEG,BMMechStructure.SIDE_WEAPON_1,BMMechStructure.SIDE_WEAPON_2,BMMechStructure.SIDE_WEAPON_3,BMMechStructure.SIDE_WEAPON_4,BMMechStructure.TOP_WEAPON_1,BMMechStructure.TOP_WEAPON_2,BMMechStructure.MODULE_1,BMMechStructure.MODULE_2,BMMechStructure.MODULE_3,BMMechStructure.MODULE_4,BMMechStructure.MODULE_5,BMMechStructure.MODULE_6,BMMechStructure.MODULE_7,BMMechStructure.MODULE_8,BMMechStructure.DRONE,BMMechStructure.TELEPORT,BMMechStructure.CHARGE,BMMechStructure.HARPOON,BMMechStructure.SHIELD,BMMechStructure.PERK];
      
      public var mechStructures:Vector.<BMMechStructure> = new Vector.<BMMechStructure>();
      
      public var buildName:String = "";
      
      public var availablePlayerItemIDs:Array = new Array();
      
      public function BMMechBuildData(param1:String, param2:Array)
      {
         super();
         this.buildName = param1;
         this.buildMechStructuresFromArray(param2);
      }
      
      public function buildMechStructuresFromArray(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:BMMechStructure = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         if(param1.length != 3)
         {
            this.createEmptyData();
            return;
         }
         this.availablePlayerItemIDs = new Array();
         this.mechStructures = new Vector.<BMMechStructure>();
         var _loc2_:uint = 1;
         while(_loc2_ <= 3)
         {
            _loc3_ = param1[_loc2_ - 1];
            if(_loc3_ == null)
            {
               this.createEmptyData();
               return;
            }
            if(_loc3_.length != arrayStructure.length)
            {
               this.createEmptyData();
               return;
            }
            _loc4_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
            _loc4_.initialize(this.dataM.ONLINE_PLAYER_ID,_loc2_);
            _loc5_ = 0;
            while(_loc5_ < arrayStructure.length)
            {
               _loc6_ = uint(_loc3_[_loc5_]);
               if(_loc6_ != 0)
               {
                  if(this.dataM.getPlayerItemData(this.dataM.ONLINE_PLAYER_ID,_loc6_) != null)
                  {
                     if(this.availablePlayerItemIDs.indexOf(_loc6_) <= -1)
                     {
                        _loc4_[arrayStructure[_loc5_]] = _loc6_;
                        this.availablePlayerItemIDs.push(_loc6_);
                     }
                  }
               }
               _loc5_++;
            }
            this.mechStructures.push(_loc4_);
            _loc2_++;
         }
      }
      
      public function cleanBuildFromDeletedItems() : void
      {
         this.buildMechStructuresFromArray(this.getMechStructuresArray());
      }
      
      public function getMechStructuresArray() : Array
      {
         var _loc3_:BMMechStructure = null;
         var _loc4_:uint = 0;
         var _loc1_:Array = new Array();
         var _loc2_:uint = 1;
         while(_loc2_ <= 3)
         {
            _loc1_.push(new Array());
            _loc3_ = this.mechStructures[_loc2_ - 1];
            _loc4_ = 0;
            while(_loc4_ < arrayStructure.length)
            {
               _loc1_[_loc2_ - 1].push(_loc3_[arrayStructure[_loc4_]]);
               _loc4_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get isEmpty() : Boolean
      {
         var _loc2_:BMMechStructure = null;
         var _loc3_:uint = 0;
         if(this.mechStructures.length == 0)
         {
            return true;
         }
         var _loc1_:uint = 1;
         loop0:
         while(_loc1_ <= 3)
         {
            _loc2_ = this.mechStructures[_loc1_ - 1];
            _loc3_ = 0;
            while(true)
            {
               if(_loc3_ >= arrayStructure.length)
               {
                  _loc1_++;
                  continue loop0;
               }
               if(_loc2_[arrayStructure[_loc3_]] > 0)
               {
                  break;
               }
               _loc3_++;
            }
            return false;
         }
         return true;
      }
      
      private function createEmptyData() : void
      {
         this.availablePlayerItemIDs = new Array();
         this.mechStructures = new Vector.<BMMechStructure>();
         var _loc1_:BMMechStructure = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
         _loc1_.initialize(this.dataM.ONLINE_PLAYER_ID,1);
         this.mechStructures.push(_loc1_);
         _loc1_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
         _loc1_.initialize(this.dataM.ONLINE_PLAYER_ID,2);
         this.mechStructures.push(_loc1_);
         _loc1_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
         _loc1_.initialize(this.dataM.ONLINE_PLAYER_ID,3);
         this.mechStructures.push(_loc1_);
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
   }
}

