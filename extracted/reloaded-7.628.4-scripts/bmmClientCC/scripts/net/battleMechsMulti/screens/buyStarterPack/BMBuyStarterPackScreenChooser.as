package net.battleMechsMulti.screens.buyStarterPack
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   
   public class BMBuyStarterPackScreenChooser
   {
      
      private static const IMPROVE_YOUR_MECH_STARTER_PACK_ID:uint = 700;
      
      public function BMBuyStarterPackScreenChooser()
      {
         super();
      }
      
      public static function isImproveYourMechStarterPackID(param1:uint) : Boolean
      {
         if(param1 == IMPROVE_YOUR_MECH_STARTER_PACK_ID)
         {
            return true;
         }
         if(param1 >= 8000 && param1 <= 8100)
         {
            return true;
         }
         return false;
      }
      
      public static function isStarterPackLegit() : Boolean
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(!_loc1_.myProfile.starterPackData)
         {
            return false;
         }
         if(isImproveYourMechStarterPackID(_loc1_.myProfile.starterPackData.packID))
         {
            if(_loc1_.isMechReadyForBattle(1) == false)
            {
               return false;
            }
            if(_loc1_.myProfile.starterPackData.mechItemIDs.length >= 3)
            {
               return true;
            }
            if(_loc1_.myProfile.improveYourMechStarterPackOffer == null)
            {
               return false;
            }
            return true;
         }
         return true;
      }
      
      public static function getBuyStarterPackScreenName() : String
      {
         BMSalesManager.gi().generateSaleStarterPackData();
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(isImproveYourMechStarterPackID(_loc1_.myProfile.starterPackData.packID))
         {
            return BMScreensManager.SCR_BUY_STARTER_PACK_IMPROVE_YOUR_MECH;
         }
         var _loc2_:uint = _loc1_.myProfile.starterPackData.getStarterPackType();
         if(_loc2_ == BMStarterPackData.TYPE_BOXES_ONLY)
         {
            return BMScreensManager.SCR_BUY_STARTER_PACK_BOXES_ONLY;
         }
         if(_loc2_ == BMStarterPackData.TYPE_BOXES_AND_CURRENCY)
         {
            return BMScreensManager.SCR_BUY_STARTER_PACK_BOXES_AND_CURRENCY;
         }
         if(_loc2_ == BMStarterPackData.TYPE_MECH_ONLY)
         {
            return BMScreensManager.SCR_BUY_STARTER_PACK_MECH_ONLY;
         }
         if(_loc2_ == BMStarterPackData.TYPE_MECH_AND_CURRENCY)
         {
            return BMScreensManager.SCR_BUY_STARTER_PACK_MECH_AND_CURRENCY;
         }
         if(_loc2_ == BMStarterPackData.TYPE_GOLD)
         {
            if(BMScreenBuyStarterPack.showExtraValueBanner)
            {
               return BMScreensManager.SCR_BUY_STARTER_PACK_GOLD_WITH_BADGE;
            }
            return BMScreensManager.SCR_BUY_STARTER_PACK_GOLD;
         }
         if(_loc2_ == BMStarterPackData.TYPE_TOKENS)
         {
            if(BMScreenBuyStarterPack.showExtraValueBanner)
            {
               return BMScreensManager.SCR_BUY_STARTER_PACK_TOKENS_WITH_BADGE;
            }
            return BMScreensManager.SCR_BUY_STARTER_PACK_TOKENS;
         }
         if(_loc2_ == BMStarterPackData.TYPE_GOLD_AND_TOKENS)
         {
            return BMScreensManager.SCR_BUY_STARTER_PACK_GOLD_AND_TOKENS;
         }
         if(_loc2_ == BMStarterPackData.TYPE_ITEM_AND_TOKENS)
         {
            return BMScreensManager.SCR_BUY_STARTER_PACK_ITEM_AND_TOKENS;
         }
         if(_loc2_ == BMStarterPackData.TYPE_MANDATORY_LEGENDARY_BOX)
         {
            return BMScreensManager.SCR_BUY_STARTER_PACK_GUARANTEED_LEGENDARY_BOX;
         }
         if(_loc2_ == BMStarterPackData.TYPE_BUNDLE)
         {
            return BMScreensManager.SCR_BUY_STARTER_PACK_BUNDLE;
         }
         return BMScreensManager.SCR_BUY_STARTER_PACK_BOXES_AND_CURRENCY;
      }
      
      public static function getStatsForImproveYourMechStarterPack() : Array
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:Array = getStatsForItems(getStarterPackMechStructure().mechItemIDs);
         var _loc3_:uint = 1;
         var _loc4_:BMMechStructure = _loc1_.myPlayerData.mechStructures[_loc3_];
         var _loc5_:Array = getStatsForItems(_loc4_.mechItemIDs);
         return [_loc5_,_loc2_];
      }
      
      public static function getStarterPackMechStructure() : BMMechStructure
      {
         var _loc2_:BMMechStructure = null;
         var _loc3_:Object = null;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:String = null;
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(_loc1_.myProfile.improveYourMechStarterPackOffer != null)
         {
            _loc2_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
            _loc2_.initialize(_loc1_.player1PlayerID,1);
            _loc2_.copyMechStructure(_loc1_.myPlayerData.mechStructures[1]);
            _loc2_.convertPlayerItemIDsIntoItemIDs();
            for each(_loc3_ in _loc1_.myProfile.improveYourMechStarterPackOffer)
            {
               _loc4_ = _loc1_.getPlayerItemData(_loc1_.player1PlayerID,_loc3_.playerItemID);
               _loc5_ = BMMechStructure.getEquipmentSlotByTypeAndID(_loc4_.equipmentType,_loc4_.equipmentID);
               _loc2_[_loc5_] = _loc3_.newItemID;
            }
            return _loc2_;
         }
         return _loc1_.myProfile.starterPackData.getMechStructure();
      }
      
      public static function getStatsForItems(param1:Array) : Array
      {
         var _loc9_:uint = 0;
         var _loc10_:BMItemData = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(_loc7_ < param1.length)
         {
            _loc9_ = uint(param1[_loc7_]);
            _loc10_ = BMDataManager.getInstance().itemsDB[_loc9_];
            switch(_loc10_.type)
            {
               case BMMechStructure.TORSO:
               case BMMechStructure.LEG:
               case BMMechStructure.MODULE:
                  _loc2_ += _loc10_.HPBase;
            }
            switch(_loc10_.type)
            {
               case BMMechStructure.TORSO:
               case BMMechStructure.MODULE:
                  _loc3_ += _loc10_.energyBase;
                  _loc4_ += _loc10_.heatBase;
            }
            switch(_loc10_.type)
            {
               case BMMechStructure.LEG:
               case BMMechStructure.SIDE_WEAPON:
               case BMMechStructure.TOP_WEAPON:
               case BMMechStructure.DRONE:
               case BMMechStructure.TELEPORT:
               case BMMechStructure.CHARGE:
               case BMMechStructure.HARPOON:
                  _loc5_ += Math.ceil(_loc10_.damageBase + _loc10_.damageAddon / 2);
                  _loc6_++;
            }
            _loc7_++;
         }
         var _loc8_:uint = Math.ceil(_loc5_ / _loc6_);
         return [_loc2_,_loc3_,_loc4_,_loc8_];
      }
   }
}

