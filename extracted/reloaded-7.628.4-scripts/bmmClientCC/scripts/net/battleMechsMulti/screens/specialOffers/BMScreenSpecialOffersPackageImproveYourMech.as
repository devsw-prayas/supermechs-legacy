package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.screens.buyStarterPack.BMBuyStarterPackScreenChooser;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackImproveYourMech;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol572")]
   public class BMScreenSpecialOffersPackageImproveYourMech extends BMScreenSpecialOffersPackage
   {
      
      public var mcNewMechPosition:Sprite;
      
      public var mcMechHolder:Sprite;
      
      public var mcStat1:MovieClip;
      
      public var mcStat2:MovieClip;
      
      private var newMechView:BMMechView;
      
      private const MECH_SIZE_RATIO:Number = 0.7;
      
      public function BMScreenSpecialOffersPackageImproveYourMech()
      {
         super();
      }
      
      override protected function updateFromData() : void
      {
         super.updateFromData();
         this.displayNewMech();
         var _loc1_:Array = BMBuyStarterPackScreenChooser.getStatsForImproveYourMechStarterPack();
         var _loc2_:Array = _loc1_[0];
         var _loc3_:Array = _loc1_[1];
         this.displayStats(_loc2_,_loc3_);
      }
      
      private function displayStats(param1:Array, param2:Array) : void
      {
         var _loc9_:MovieClip = null;
         var _loc10_:Object = null;
         var _loc3_:Number = Math.ceil((param2[0] / param1[0] - 1) * 100);
         var _loc4_:Number = Math.ceil((param2[3] / param1[3] - 1) * 100);
         var _loc5_:Number = Math.ceil((param2[2] / param1[2] - 1) * 100);
         var _loc6_:Number = Math.ceil((param2[1] / param1[1] - 1) * 100);
         var _loc7_:Array = new Array();
         if(_loc3_ > 0)
         {
            _loc7_.push({
               "type":"hp",
               "text":BMScreenBuyStarterPackImproveYourMech.getHPText(_loc3_)
            });
         }
         if(_loc4_ > 0)
         {
            _loc7_.push({
               "type":"damage",
               "text":BMScreenBuyStarterPackImproveYourMech.getDamageText(_loc4_)
            });
         }
         if(_loc5_ > 0)
         {
            _loc7_.push({
               "type":"heat",
               "text":BMScreenBuyStarterPackImproveYourMech.getHeatText(_loc5_)
            });
         }
         if(_loc6_ > 0)
         {
            _loc7_.push({
               "type":"energy",
               "text":BMScreenBuyStarterPackImproveYourMech.getEnergyText(_loc6_)
            });
         }
         var _loc8_:uint = 0;
         while(_loc8_ < 2)
         {
            _loc9_ = this["mcStat" + (_loc8_ + 1)];
            if(_loc7_[_loc8_] == null)
            {
               _loc9_.visible = false;
            }
            else
            {
               _loc10_ = _loc7_[_loc8_];
               _loc9_.mcHP.visible = _loc10_.type == "hp";
               _loc9_.mcDamage.visible = _loc10_.type == "damage";
               _loc9_.mcHeat.visible = _loc10_.type == "heat";
               _loc9_.mcEnergy.visible = _loc10_.type == "energy";
               updateTextAndFormat(_loc9_.txtBonus,_loc10_.text);
            }
            _loc8_++;
         }
      }
      
      private function displayNewMech() : void
      {
         if(this.newMechView != null)
         {
            return;
         }
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         this.newMechView = new BMMechView();
         this.newMechView.initialize(_loc1_.player1PlayerID,"battle",BMMechStructure.ITEM_TYPE_ITEM_ID,this.MECH_SIZE_RATIO,false);
         var _loc2_:BMMechStructure = BMBuyStarterPackScreenChooser.getStarterPackMechStructure();
         this.newMechView.buildMech(_loc2_,this.mechBuilt);
      }
      
      private function mechBuilt() : void
      {
         this.newMechView.activateBreathing();
         this.newMechView.x = this.mcNewMechPosition.x;
         this.newMechView.y = this.mcNewMechPosition.y - this.newMechView.mechSizer.y * this.MECH_SIZE_RATIO;
         this.mcMechHolder.addChild(this.newMechView);
      }
      
      private function removeMechs() : void
      {
         if(this.newMechView != null)
         {
            this.newMechView.removeMe();
            this.newMechView = null;
         }
      }
      
      override public function removeMe() : void
      {
         this.removeMechs();
         super.removeMe();
      }
      
      override public function onEnterFrameTrigger() : void
      {
         super.onEnterFrameTrigger();
         if(parent != null)
         {
            this.newMechView.onEnterFrameTrigger();
         }
      }
   }
}

