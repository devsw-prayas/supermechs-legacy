package net.battleMechsMulti.screens.buyStarterPack
{
   import net.battleMechsMulti.managers.BMScreensManager;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1432")]
   public class BMScreenBuyStarterPackGold_withBadge extends BMScreenBuyStarterPackGold
   {
      
      public function BMScreenBuyStarterPackGold_withBadge()
      {
         super();
      }
      
      override public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_GOLD_WITH_BADGE);
      }
   }
}

