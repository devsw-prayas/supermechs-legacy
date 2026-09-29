package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol910")]
   public class BMScreenSpecialOffersPackageMech extends BMScreenSpecialOffersPackage
   {
      
      public var mcMechPosition:Sprite;
      
      public var mcMechHolder:Sprite;
      
      private var mechView:BMMechView;
      
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
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         var _loc3_:BMMechStructure = null;
         var _loc4_:Object = null;
         if(this.mechView == null)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc2_ = 0.7;
            this.mechView = new BMMechView();
            this.mechView.initialize(0,"battle","itemID",_loc2_,false);
            _loc3_ = new BMMechStructure();
            _loc3_.torso = _loc1_.starterPackData.torso;
            _loc3_.leg = _loc1_.starterPackData.leg;
            _loc3_.sideWeapon1 = _loc1_.starterPackData.sideWeapon1;
            _loc3_.sideWeapon2 = _loc1_.starterPackData.sideWeapon2;
            _loc3_.topWeapon1 = _loc1_.starterPackData.topWeapon1;
            _loc3_.topWeapon2 = _loc1_.starterPackData.topWeapon2;
            _loc4_ = new Object();
            _loc4_.torso = _loc1_.starterPackData.mechColorID;
            _loc4_.leg = _loc1_.starterPackData.mechColorID;
            _loc4_.sideWeapon = _loc1_.starterPackData.mechColorID;
            _loc4_.topWeapon = _loc1_.starterPackData.mechColorID;
            this.mechView.setManualColors(_loc4_);
            this.mechView.buildMech(_loc3_,"buyStarterPack");
            this.mechView.activateBreathing();
            this.mechView.x = this.mcMechPosition.x;
            this.mechView.y = this.mcMechPosition.y - this.mechView.mechSizer.y * _loc2_;
            this.mcMechHolder.addChild(this.mechView);
         }
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

