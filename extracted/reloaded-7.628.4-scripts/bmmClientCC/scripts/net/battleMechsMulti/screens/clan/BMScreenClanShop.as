package net.battleMechsMulti.screens.clan
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenClanShop extends BMBaseScreen
   {
      
      public var txtMyClanCoins:TextField;
      
      public function BMScreenClanShop()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clan");
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.refreshClanCoins();
         BMShopManager.gi().showClanShop();
      }
      
      public function refreshClanCoins() : void
      {
         updateTextAndFormat(this.txtMyClanCoins,TextUtils.getNumberWithComma(dataM.myProfile.clanCoins));
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CLAN_SHOP);
      }
   }
}

