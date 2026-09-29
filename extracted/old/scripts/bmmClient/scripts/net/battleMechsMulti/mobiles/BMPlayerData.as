package net.battleMechsMulti.mobiles
{
   public class BMPlayerData extends BMBaseClass
   {
      
      public var items:Array = new Array();
      
      public var existingItemsIDs:Object = new Object();
      
      public var playerItemIDCounter:uint = 0;
      
      public var AP:Number;
      
      public var APMax:Number;
      
      public var battlePlayerID:Number = 0;
      
      public var mechWeight:Number = 0;
      
      public var mechStructures:Array = new Array();
      
      public var selectedMechID:uint = 1;
      
      public var mechsDestroyed:uint = 0;
      
      public var switchMech1Uses:uint;
      
      public var switchMech2Uses:uint;
      
      public var switchMech3Uses:uint;
      
      public function BMPlayerData()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function updateExistingPlayerItemIDs() : void
      {
         var _loc2_:BMPlayerItemData = null;
         this.existingItemsIDs = new Object();
         var _loc1_:uint = 0;
         while(_loc1_ < this.items.length)
         {
            _loc2_ = this.items[_loc1_];
            this.existingItemsIDs[_loc2_.itemID] = true;
            _loc1_++;
         }
      }
      
      public function updateMechsWeight() : void
      {
         var _loc1_:uint = 0;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         _loc1_ = 1;
         while(_loc1_ <= dataM.inventoryMaxMechs)
         {
            this.mechStructures[_loc1_].mechWeight = 0;
            this.mechStructures[_loc1_].totalMythicalItems = 0;
            _loc1_++;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.items.length)
         {
            _loc3_ = this.items[_loc2_];
            _loc1_ = _loc3_.equipped;
            if(_loc1_ >= 1)
            {
               _loc4_ = dataM.itemsDB[_loc3_.itemID];
               this.mechStructures[_loc1_].mechWeight += _loc4_.weight;
               if(_loc4_.specialStatus == 4)
               {
                  this.mechStructures[_loc1_].totalMythicalItems += 1;
               }
            }
            _loc2_++;
         }
      }
      
      public function resetSwitchMechUses() : void
      {
         this.switchMech1Uses = 0;
         this.switchMech2Uses = 0;
         this.switchMech3Uses = 0;
      }
   }
}

