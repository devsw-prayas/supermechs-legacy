package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol560")]
   public class BMScreenSpecialOffersPackageItemAndTokens extends BMScreenSpecialOffersPackage
   {
      
      public var mcSizer_item:Sprite;
      
      public function BMScreenSpecialOffersPackageItemAndTokens()
      {
         super();
      }
      
      override protected function updateFromData() : void
      {
         super.updateFromData();
         var _loc1_:int = int(dataM.myProfile.starterPackData.mechItemIDs[0]);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_];
         var _loc3_:BMTileListItem = dataM.createItemTileListItem(_loc1_,this.mcSizer_item.width,0);
         _loc3_.x = this.mcSizer_item.x;
         _loc3_.y = this.mcSizer_item.y;
         addChild(_loc3_);
         mcTokens.x -= 30;
      }
      
      override public function removeMe() : void
      {
         super.removeMe();
      }
      
      override public function onEnterFrameTrigger() : void
      {
         super.onEnterFrameTrigger();
      }
   }
}

