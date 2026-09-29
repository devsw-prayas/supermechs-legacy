package net.battleMechsMulti.screens.buyStarterPack
{
   import net.battleMechsMulti.managers.BMScreensManager;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1364")]
   public class BMScreenBuyStarterPackTokens_withBadge extends BMScreenBuyStarterPackTokens
   {
      
      public function BMScreenBuyStarterPackTokens_withBadge()
      {
         super();
      }
      
      override public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_TOKENS_WITH_BADGE);
      }
   }
}

