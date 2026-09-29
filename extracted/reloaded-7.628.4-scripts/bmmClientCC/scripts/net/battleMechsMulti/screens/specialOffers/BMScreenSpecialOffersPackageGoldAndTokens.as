package net.battleMechsMulti.screens.specialOffers
{
   [Embed(source="/_assets/assets.swf", symbol="symbol579")]
   public class BMScreenSpecialOffersPackageGoldAndTokens extends BMScreenSpecialOffersPackage
   {
      
      public function BMScreenSpecialOffersPackageGoldAndTokens()
      {
         super();
      }
      
      override protected function updateFromData() : void
      {
         super.updateFromData();
         mcGold.x -= 45;
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

