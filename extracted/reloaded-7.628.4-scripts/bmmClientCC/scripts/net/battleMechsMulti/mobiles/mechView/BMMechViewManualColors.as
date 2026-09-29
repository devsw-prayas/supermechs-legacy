package net.battleMechsMulti.mobiles.mechView
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMMechViewManualColors
   {
      
      public var torso:Number = -1;
      
      public var leg:Number = -1;
      
      public var sideWeapon:Number = -1;
      
      public var topWeapon:Number = -1;
      
      public var sideWeapon1:Number = -1;
      
      public var sideWeapon2:Number = -1;
      
      public var sideWeapon3:Number = -1;
      
      public var sideWeapon4:Number = -1;
      
      public var topWeapon1:Number = -1;
      
      public var topWeapon2:Number = -1;
      
      public function BMMechViewManualColors()
      {
         super();
      }
      
      public function setBlackForAll() : void
      {
         this.torso = 9;
         this.leg = 9;
         this.sideWeapon = 9;
         this.topWeapon = 9;
      }
      
      public function setSpecificColorForAll(param1:uint) : void
      {
         this.torso = param1;
         this.leg = param1;
         this.sideWeapon = param1;
         this.topWeapon = param1;
      }
      
      public function setByMechStructure(param1:BMMechStructure) : void
      {
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:BMPlayerItemData = null;
         var _loc2_:Array = new Array();
         _loc2_.push(BMMechStructure.TORSO,BMMechStructure.LEG,BMMechStructure.SIDE_WEAPON_1,BMMechStructure.SIDE_WEAPON_2,BMMechStructure.SIDE_WEAPON_3,BMMechStructure.SIDE_WEAPON_4,BMMechStructure.TOP_WEAPON_1,BMMechStructure.TOP_WEAPON_2);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(param1[_loc4_] != 0)
            {
               _loc5_ = uint(param1[_loc4_ + "_colorID"]);
               if(_loc5_ > 0)
               {
                  this[_loc4_] = _loc5_;
               }
               else
               {
                  if(param1.itemType == BMMechStructure.ITEM_TYPE_ITEM_ID)
                  {
                     _loc6_ = uint(param1[_loc4_]);
                  }
                  else
                  {
                     _loc7_ = uint(param1[_loc4_]);
                     _loc8_ = this.dataM.getPlayerItemData(param1.playerID,_loc7_);
                     _loc6_ = _loc8_.itemID;
                     if(_loc8_.colorID > 0)
                     {
                        _loc5_ = _loc8_.colorID;
                     }
                  }
                  if(_loc5_ == 0)
                  {
                     _loc5_ = this.dataM.getItemIDPowerColorID(_loc6_);
                  }
                  this[_loc4_] = _loc5_;
               }
            }
            _loc3_++;
         }
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
   }
}

