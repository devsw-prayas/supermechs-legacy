package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol918")]
   public class BMScreenSpecialOffersPackageBoxes extends BMScreenSpecialOffersPackage
   {
      
      public var mcBoxes:MovieClip;
      
      public function BMScreenSpecialOffersPackageBoxes()
      {
         super();
      }
      
      override protected function updateFromData() : void
      {
         super.updateFromData();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.starterPackData.boostID == 20)
         {
            if(_loc1_.starterPackData.boostAmount == 1)
            {
               this.mcBoxes.gotoAndStop(1);
            }
            else
            {
               this.mcBoxes.gotoAndStop(2);
            }
         }
         else
         {
            this.mcBoxes.gotoAndStop(3);
         }
      }
   }
}

