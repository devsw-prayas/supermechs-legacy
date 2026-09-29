package net.battleMechsMulti.screens.specialOffers
{
   [Embed(source="/_assets/assets.swf", symbol="symbol584")]
   public class BMScreenSpecialOffersPackageGold extends BMScreenSpecialOffersPackage
   {
      
      public function BMScreenSpecialOffersPackageGold()
      {
         super();
      }
      
      override protected function updateFromData() : void
      {
         super.updateFromData();
         mcGold.x -= 75;
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

