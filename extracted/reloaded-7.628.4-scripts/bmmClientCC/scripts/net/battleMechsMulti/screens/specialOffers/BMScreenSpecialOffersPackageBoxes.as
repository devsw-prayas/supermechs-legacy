package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol601")]
   public class BMScreenSpecialOffersPackageBoxes extends BMScreenSpecialOffersPackage
   {
      
      public var mcBoxes:MovieClip;
      
      public var mcPlusAndBag:Sprite;
      
      public function BMScreenSpecialOffersPackageBoxes()
      {
         super();
      }
      
      override protected function updateFromData() : void
      {
         super.updateFromData();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.starterPackData.boostID == 2)
         {
            this.mcBoxes.gotoAndStop(_loc1_.starterPackData.boostAmount);
         }
         else
         {
            this.mcBoxes.gotoAndStop(_loc1_.starterPackData.boostAmount + 5);
         }
         if(_loc1_.starterPackData.bonusTokens == 0)
         {
            this.mcPlusAndBag.visible = false;
            this.mcBoxes.x = 237.45;
            mcTokens.visible = false;
            mcGold.visible = false;
         }
      }
   }
}

