package net.battleMechsMulti.screens.buyStarterPack
{
   [Embed(source="/_assets/assets.swf", symbol="symbol1391")]
   public class BMScreenBuyStarterPackMechAndCurrency extends BMScreenBuyStarterPackMechOnly
   {
      
      public function BMScreenBuyStarterPackMechAndCurrency()
      {
         super();
      }
      
      override public function mechAndCurrencyOperations() : void
      {
         updateTextAndFormat(txtDescription2,getScreenText("description_goldTokens"));
      }
   }
}

