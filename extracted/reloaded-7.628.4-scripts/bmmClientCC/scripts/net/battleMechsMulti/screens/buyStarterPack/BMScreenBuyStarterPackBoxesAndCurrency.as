package net.battleMechsMulti.screens.buyStarterPack
{
   [Embed(source="/_assets/assets.swf", symbol="symbol1467")]
   public class BMScreenBuyStarterPackBoxesAndCurrency extends BMScreenBuyStarterPackBoxesOnly
   {
      
      public function BMScreenBuyStarterPackBoxesAndCurrency()
      {
         super();
      }
      
      override public function boxesAndCurencyOperations() : void
      {
         updateTextAndFormat(txtDescription2,getScreenText("description_goldTokens"));
      }
   }
}

