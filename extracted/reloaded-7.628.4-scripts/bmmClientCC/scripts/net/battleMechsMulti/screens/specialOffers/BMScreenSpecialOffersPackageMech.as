package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.screens.buyStarterPack.BMBuyStarterPackScreenChooser;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol555")]
   public class BMScreenSpecialOffersPackageMech extends BMScreenSpecialOffersPackage
   {
      
      public var mcMechPosition:Sprite;
      
      public var mcMechHolder:Sprite;
      
      private var mechView:BMMechView;
      
      public var mcPlusAndBag:Sprite;
      
      private const MECH_SIZE_RATIO:Number = 0.7;
      
      public function BMScreenSpecialOffersPackageMech()
      {
         super();
      }
      
      override protected function updateFromData() : void
      {
         super.updateFromData();
         this.displayMech();
      }
      
      private function displayMech() : void
      {
         var _loc2_:BMMechStructure = null;
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(this.mechView == null)
         {
            this.mechView = new BMMechView();
            this.mechView.initialize(_loc1_.player1PlayerID,"battle",BMMechStructure.ITEM_TYPE_ITEM_ID,this.MECH_SIZE_RATIO,false);
            _loc2_ = BMBuyStarterPackScreenChooser.getStarterPackMechStructure();
            this.mechView.buildMech(_loc2_,this.mechBuilt);
         }
         if(_loc1_.myProfile.starterPackData.bonusTokens == 0)
         {
            this.mcPlusAndBag.visible = false;
            this.mcMechPosition.x += 140;
            mcTokens.visible = false;
            mcGold.visible = false;
         }
      }
      
      private function mechBuilt() : void
      {
         this.mechView.activateBreathing();
         this.mechView.x = this.mcMechPosition.x;
         this.mechView.y = this.mcMechPosition.y - this.mechView.mechSizer.y * this.MECH_SIZE_RATIO;
         this.mcMechHolder.addChild(this.mechView);
      }
      
      private function removeMech() : void
      {
         if(this.mechView != null)
         {
            this.mechView.removeMe();
            this.mechView = null;
         }
      }
      
      override public function removeMe() : void
      {
         this.removeMech();
         super.removeMe();
      }
      
      override public function onEnterFrameTrigger() : void
      {
         super.onEnterFrameTrigger();
         if(parent != null)
         {
            this.mechView.onEnterFrameTrigger();
         }
      }
   }
}

