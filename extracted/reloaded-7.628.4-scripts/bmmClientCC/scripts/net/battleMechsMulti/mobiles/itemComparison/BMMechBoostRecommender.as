package net.battleMechsMulti.mobiles.itemComparison
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.upgrade.BMPotentialBoostInfo;
   import net.battleMechsMulti.managers.upgrade.BMUpgradeManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMMechBoostRecommender
   {
      
      public static const NO_RECOMMENDATION:uint = 0;
      
      public static const ORIGIN_CAMPAIGN:uint = 1;
      
      public static const ORIGIN_PVP:uint = 2;
      
      private var _activeRecommendationPlayerItemID:uint = 0;
      
      private var _nextRecommendationAllowedByClient:Boolean = false;
      
      private var _recommendationOrigin:uint = 1;
      
      public function BMMechBoostRecommender()
      {
         super();
      }
      
      public function getRecommendedPlayerItemIDForBoost() : uint
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItemData = null;
         var _loc10_:BMPotentialBoostInfo = null;
         if(this.isRecommendationEnabled() == false)
         {
            return NO_RECOMMENDATION;
         }
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:Array = _loc1_.getRecommendedBoostMaterialPlayerItemIDs();
         var _loc3_:Array = this.getPlayerDataItemSlotsByPriority();
         var _loc4_:uint = NO_RECOMMENDATION;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(_loc3_[_loc5_] != null)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc3_[_loc5_].length)
               {
                  _loc7_ = uint(_loc3_[_loc5_][_loc6_]);
                  _loc8_ = _loc1_.myPlayerData.items[_loc7_];
                  _loc9_ = _loc1_.itemsDB[_loc8_.itemID];
                  _loc10_ = BMUpgradeManager.getInstance().getPotentialBoostInfo(_loc8_.playerItemID,_loc2_);
                  if(_loc10_.targetItemDisplayLevelAfterBoost >= _loc9_.displayLevel + _loc1_.oneClickBoostData.minBoostLevelsForBoost)
                  {
                     _loc4_ = _loc8_.playerItemID;
                     break;
                  }
                  _loc6_++;
               }
               if(_loc4_ != NO_RECOMMENDATION)
               {
                  break;
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function showBoostRecommendation(param1:Function) : void
      {
         var _loc2_:uint = this.getRecommendedPlayerItemIDForBoost();
         if(_loc2_ == BMMechBoostRecommender.NO_RECOMMENDATION)
         {
            return;
         }
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         var _loc4_:BMPlayerItemData = _loc3_.getPlayerItemData(_loc3_.player1PlayerID,_loc2_);
         var _loc5_:BMScreensManager = BMScreensManager.getInstance();
         _loc5_.addScreen(BMScreensManager.SCR_BOOST_ITEM_RECOMMENDATION);
         _loc5_.screenBoostItemRecommendation.displayRecommendation(param1,_loc4_);
      }
      
      private function isRecommendationEnabled() : Boolean
      {
         if(this._nextRecommendationAllowedByClient == false)
         {
            return false;
         }
         this._nextRecommendationAllowedByClient = false;
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         if(_loc1_.oneClickBoostData == null)
         {
            return false;
         }
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return false;
         }
         var _loc2_:Array = _loc1_.getRecommendedBoostMaterialPlayerItemIDs();
         if(_loc2_.length == 0)
         {
            return false;
         }
         if(_loc1_.myProfile.level > _loc1_.oneClickBoostData.recommendationMaxLevel)
         {
            return false;
         }
         return true;
      }
      
      private function getPlayerDataItemSlotsByPriority() : Array
      {
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         var _loc6_:Number = NaN;
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:Array = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_.myPlayerData.items.length)
         {
            _loc4_ = _loc1_.myPlayerData.items[_loc3_];
            if(_loc4_.equipped == 1)
            {
               _loc5_ = _loc1_.itemsDB[_loc4_.itemID];
               _loc6_ = _loc1_.oneClickBoostData.itemTypesRecommendationOrder.indexOf(_loc5_.type);
               if(_loc6_ != -1)
               {
                  if(_loc2_[_loc6_] == null)
                  {
                     _loc2_[_loc6_] = new Array();
                  }
                  _loc2_[_loc6_].push(_loc3_);
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function setActiveRecommendation(param1:uint, param2:uint) : void
      {
         this._activeRecommendationPlayerItemID = param1;
         this._recommendationOrigin = param2;
      }
      
      public function get activeRecommendationPlayerItemID() : uint
      {
         return this._activeRecommendationPlayerItemID;
      }
      
      public function get recommendationOrigin() : uint
      {
         return this._recommendationOrigin;
      }
      
      public function removeActiveRecommendation() : void
      {
         this._activeRecommendationPlayerItemID = NO_RECOMMENDATION;
      }
      
      public function allowNextRecommendationByClient() : void
      {
         this._nextRecommendationAllowedByClient = true;
      }
   }
}

