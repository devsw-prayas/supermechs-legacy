package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.screens.buyStarterPack.BMStarterPackBundleItem;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol607")]
   public class BMScreenSpecialOffersBundle extends BMScreenSpecialOffersPackage
   {
      
      private var totalOffers:uint;
      
      private var bundleItems:Array;
      
      public var mcPlus:Sprite;
      
      public function BMScreenSpecialOffersBundle()
      {
         super();
      }
      
      override protected function updateFromData() : void
      {
         super.updateFromData();
         this.createBundle();
      }
      
      private function createBundle() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:BMItemData = null;
         this.removeBundleItems();
         this.mcPlus.visible = false;
         this.totalOffers = 0;
         var _loc1_:BMStarterPackData = BMDataManager.getInstance().myProfile.starterPackData;
         var _loc2_:String = BMStarterPackBundleItem.TYPE_ITEM_BOX;
         if(_loc1_.boostID > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,_loc1_.boostID,"",_loc1_.boostAmount,3);
         }
         _loc2_ = BMStarterPackBundleItem.TYPE_ITEM;
         var _loc3_:uint = 1;
         while(_loc3_ <= 8)
         {
            _loc4_ = uint(_loc1_["module" + _loc3_]);
            if(_loc4_ != 0)
            {
               _loc5_ = uint(_loc1_["module" + _loc3_ + "Multiplier"]);
               _loc6_ = BMDataManager.getInstance().itemsDB[_loc4_];
               this.createSpecificBundleItem(_loc2_,_loc4_,0,"",_loc5_,_loc6_.specialStatus);
            }
            _loc3_++;
         }
         _loc2_ = BMStarterPackBundleItem.TYPE_RESOURCE;
         if(_loc1_.bonusTokens > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_TOKENS,_loc1_.bonusTokens,4);
         }
         if(_loc1_.bonusGold > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_GOLD,_loc1_.bonusGold,3);
         }
         if(_loc1_.clanCoins > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_CLAN_COINS,_loc1_.clanCoins,3);
         }
         if(_loc1_.arenaCoins > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_ARENA_COINS,_loc1_.arenaCoins,3);
         }
         if(_loc1_.battleCredits > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_BATTLE_CREDITS,_loc1_.battleCredits,3);
         }
         if(_loc1_.nukes > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_NUKES,_loc1_.nukes,3);
         }
      }
      
      private function createSpecificBundleItem(param1:String, param2:uint, param3:uint, param4:String, param5:uint, param6:uint) : void
      {
         var _loc7_:BMStarterPackBundleItem = null;
         this.totalOffers += 1;
         if(this.totalOffers > 5)
         {
            this.mcPlus.visible = true;
            return;
         }
         _loc7_ = new BMStarterPackBundleItem();
         _loc7_.scaleX = 0.7;
         _loc7_.scaleY = 0.7;
         if(param1 == BMStarterPackBundleItem.TYPE_ITEM)
         {
            _loc7_.initializeItem(param2,param5,param6,false);
         }
         else if(param1 == BMStarterPackBundleItem.TYPE_RESOURCE)
         {
            _loc7_.initializeResource(param4,param5,param6);
         }
         else
         {
            _loc7_.initializeItemBox(param3,param5,param6);
         }
         this.bundleItems.push(_loc7_);
         _loc7_.x = 10 + (this.totalOffers - 1) * 80;
         _loc7_.y = 14;
         mcButtonsHolder.addChild(_loc7_);
      }
      
      override public function removeMe() : void
      {
         this.removeBundleItems();
         super.removeMe();
      }
      
      override public function onEnterFrameTrigger() : void
      {
         super.onEnterFrameTrigger();
      }
      
      private function removeBundleItems() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMStarterPackBundleItem = null;
         if(this.bundleItems != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.bundleItems.length)
            {
               _loc2_ = this.bundleItems[_loc1_];
               _loc2_.parent.removeChild(_loc2_);
               _loc2_ = null;
               _loc1_++;
            }
         }
         this.bundleItems = new Array();
      }
   }
}

