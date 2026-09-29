package net.battleMechsMulti.data
{
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMRewardData
   {
      
      public var xp:int;
      
      public var gold:int;
      
      public var tokens:int;
      
      public var energy:uint;
      
      public var items:Vector.<BMPlayerItemData> = new Vector.<BMPlayerItemData>();
      
      public var boxes:Vector.<uint> = new Vector.<uint>();
      
      public function BMRewardData(param1:Object = null)
      {
         var _loc2_:Object = null;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:uint = 0;
         super();
         if(param1 == null)
         {
            return;
         }
         this.xp = param1["xp"];
         this.gold = param1["gold"];
         this.tokens = param1["tokens"];
         this.energy = param1["energy"];
         if(param1.hasOwnProperty("items"))
         {
            for each(_loc2_ in param1.items)
            {
               _loc3_ = new BMPlayerItemData();
               _loc3_.itemID = _loc2_.itemID;
               _loc3_.playerItemID = _loc2_.playerItemID;
               _loc3_.power = _loc2_.power;
               _loc3_.colorID = _loc2_.colorID;
               this.items.push(_loc3_);
            }
         }
         if(param1.hasOwnProperty("boxes"))
         {
            for each(_loc4_ in param1.boxes)
            {
               this.boxes.push(_loc4_);
            }
         }
      }
   }
}

