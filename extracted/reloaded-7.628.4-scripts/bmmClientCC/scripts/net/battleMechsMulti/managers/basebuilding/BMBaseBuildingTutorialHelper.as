package net.battleMechsMulti.managers.basebuilding
{
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMBaseBuildingTutorialHelper
   {
      
      public function BMBaseBuildingTutorialHelper()
      {
         super();
         throw new Error("Do not instantiate this class");
      }
      
      public static function getTutorialBaseBuildingDBData() : Object
      {
         var _loc1_:Object = {};
         _loc1_[BMBaseBuildingDB.STRUCTURE_TYPE_HQ] = {"levelsUnlocked":[1]};
         _loc1_[BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY] = {"levelsUnlocked":[1]};
         _loc1_[BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE] = {"levelsUnlocked":[1,2]};
         var _loc2_:Object = [{
            "skipCostTokens":0,
            "periodSeconds":60
         }];
         var _loc3_:Object = {};
         _loc3_[BMBaseBuildingDB.STRUCTURE_TYPE_HQ] = [{
            "upgradeCost":0,
            "upgradeSeconds":0
         }];
         _loc3_[BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE] = [{
            "upgradeCost":250,
            "upgradeSeconds":0,
            "miningRate":300,
            "capacity":1000
         }];
         _loc3_[BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY] = [{
            "upgradeCost":500,
            "productionPrice":2500,
            "upgradeSeconds":5,
            "title":"itemFactory_commonTitle",
            "description":"itemFactory_commonDescription",
            "productionSeconds":900,
            "visualID":1,
            "productionRewardScheme":"rewards-factory-common"
         },{
            "upgradeCost":800,
            "productionPrice":5000,
            "upgradeSeconds":30,
            "title":"itemFactory_commonRareTitle",
            "description":"itemFactory_commonRareDescription",
            "productionSeconds":1800,
            "visualID":2,
            "productionRewardScheme":"rewards-factory-commonrare"
         },{
            "upgradeCost":3100,
            "productionPrice":4000,
            "upgradeSeconds":200,
            "title":"itemFactory_quickTitle",
            "description":"itemFactory_quickDescription",
            "productionSeconds":300,
            "visualID":3,
            "productionRewardScheme":"rewards-factory-common"
         },{
            "upgradeCost":7800,
            "productionPrice":1500,
            "upgradeSeconds":900,
            "title":"itemFactory_lowCostTitle",
            "description":"itemFactory_lowCostDescription",
            "productionSeconds":7200,
            "visualID":4,
            "productionRewardScheme":"rewards-factory-commonrare"
         },{
            "upgradeCost":14000,
            "productionPrice":3000,
            "upgradeSeconds":2400,
            "title":"itemFactory_commonTorsosLegsTitle",
            "description":"itemFactory_commonTorsosLegsDescription",
            "productionSeconds":1200,
            "visualID":5,
            "productionRewardScheme":"rewards-factory-commonrare-torsoslegs"
         },{
            "upgradeCost":21700,
            "productionPrice":3500,
            "upgradeSeconds":6000,
            "title":"itemFactory_commonWeaponsTitle",
            "description":"itemFactory_commonWeaponsDescription",
            "productionSeconds":1200,
            "visualID":6,
            "productionRewardScheme":"rewards-factory-commonrare-weapons"
         },{
            "upgradeCost":31000,
            "productionPrice":4000,
            "upgradeSeconds":12000,
            "title":"itemFactory_commonSpecialsTitle",
            "description":"itemFactory_commonSpecialsDescription",
            "productionSeconds":1200,
            "visualID":7,
            "productionRewardScheme":"rewards-factory-commonrare-specials"
         },{
            "upgradeCost":38000,
            "productionPrice":10000,
            "upgradeSeconds":21600,
            "title":"itemFactory_superQuickTitle",
            "description":"itemFactory_superQuickDescription",
            "productionSeconds":120,
            "visualID":8,
            "productionRewardScheme":"rewards-factory-commonrare"
         },{
            "upgradeCost":52000,
            "productionPrice":20000,
            "upgradeSeconds":28800,
            "title":"itemFactory_rareTitle",
            "description":"itemFactory_rareDescription",
            "productionSeconds":2400,
            "visualID":9,
            "productionRewardScheme":"rewards-factory-rare"
         },{
            "upgradeCost":72000,
            "productionPrice":50000,
            "upgradeSeconds":40320,
            "title":"itemFactory_rareEpicTitle",
            "description":"itemFactory_rareEpicDescription",
            "productionSeconds":14400,
            "visualID":10,
            "productionRewardScheme":"rewards-factory-rareepic"
         },{
            "upgradeCost":98000,
            "productionPrice":12000,
            "upgradeSeconds":51840,
            "title":"itemFactory_rareTorsosLegsTitle",
            "description":"itemFactory_rareTorsosLegsDescription",
            "productionSeconds":10800,
            "visualID":11,
            "productionRewardScheme":"rewards-factory-rare-torsoslegs"
         },{
            "upgradeCost":130000,
            "productionPrice":13000,
            "upgradeSeconds":69120,
            "title":"itemFactory_rareWeaponsTitle",
            "description":"itemFactory_rareWeaponsDescription",
            "productionSeconds":10800,
            "visualID":12,
            "productionRewardScheme":"rewards-factory-rare-weapons"
         },{
            "upgradeCost":167000,
            "productionPrice":14000,
            "upgradeSeconds":86400,
            "title":"itemFactory_rareSpecialsTitle",
            "description":"itemFactory_rareSpecialsDescription",
            "productionSeconds":10800,
            "visualID":13,
            "productionRewardScheme":"rewards-factory-rare-specials"
         },{
            "upgradeCost":211000,
            "productionPrice":1000,
            "upgradeSeconds":100800,
            "title":"itemFactory_superCheapTitle",
            "description":"itemFactory_superCheapDescription",
            "productionSeconds":5400,
            "visualID":14,
            "productionRewardScheme":"rewards-factory-commonrare"
         },{
            "upgradeCost":261000,
            "productionPrice":10000,
            "upgradeSeconds":115200,
            "title":"itemFactory_powerKitsTitle",
            "description":"itemFactory_powerKitsDescription",
            "productionSeconds":900,
            "visualID":15,
            "productionRewardScheme":"rewards-factory-powerkits"
         },{
            "upgradeCost":317000,
            "productionPrice":200000,
            "upgradeSeconds":129600,
            "title":"itemFactory_epicTitle",
            "description":"itemFactory_epicDescription",
            "productionSeconds":172800,
            "visualID":16,
            "productionRewardScheme":"rewards-factory-epic"
         },{
            "upgradeCost":379000,
            "productionPrice":200000,
            "upgradeSeconds":144000,
            "title":"itemFactory_epicTorsosLegsTitle",
            "description":"itemFactory_epicTorsosLegsDescription",
            "productionSeconds":216000,
            "visualID":17,
            "productionRewardScheme":"rewards-factory-epic-torsoslegs"
         },{
            "upgradeCost":446000,
            "productionPrice":200000,
            "upgradeSeconds":158400,
            "title":"itemFactory_epicWeaponsTitle",
            "description":"itemFactory_epicWeaponsDescription",
            "productionSeconds":216000,
            "visualID":18,
            "productionRewardScheme":"rewards-factory-epic-weapons"
         },{
            "upgradeCost":520000,
            "productionPrice":200000,
            "upgradeSeconds":172800,
            "title":"itemFactory_epicSpecialsTitle",
            "description":"itemFactory_epicSpecialsDescription",
            "productionSeconds":216000,
            "visualID":19,
            "productionRewardScheme":"rewards-factory-epic-specials"
         },{
            "upgradeCost":600000,
            "productionPrice":300000,
            "upgradeSeconds":201600,
            "title":"itemFactory_epicLegendTitle",
            "description":"itemFactory_epicLegendDescription",
            "productionSeconds":259200,
            "visualID":20,
            "productionRewardScheme":"rewards-factory-epiclegend"
         }];
         return {
            "base_definition":_loc1_,
            "skipping_queues_config":_loc2_,
            "structures":_loc3_
         };
      }
      
      private static function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      public static function getTutorialBaseBuildingInitialStateData() : Object
      {
         var _loc1_:Object = {};
         _loc1_[BMBaseBuildingDB.HQ_STRUCTURE_POSITION] = {
            "type":BMBaseBuildingDB.STRUCTURE_TYPE_HQ,
            "level":1,
            "upgradeFinishTime":0
         };
         _loc1_[1] = {
            "type":BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE,
            "level":1,
            "upgradeFinishTime":0,
            "lastCollectTime":dataM.currentTime
         };
         return _loc1_;
      }
      
      public static function getTutorialBaseBuildingStateDataAfterBuildingItemFactory() : Object
      {
         var _loc1_:Object = getTutorialBaseBuildingInitialStateData();
         _loc1_[2] = {
            "type":BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY,
            "level":1,
            "upgradeFinishTime":dataM.currentTime + 5,
            "queueFinishTime":0,
            "itemsInQueue":0,
            "itemTypeInQueue":0
         };
         return _loc1_;
      }
      
      public static function getTutorialBaseBuildingStateDataAfterProducingFirstItem() : Object
      {
         var _loc1_:Object = getTutorialBaseBuildingStateDataAfterBuildingItemFactory();
         _loc1_[2].queueFinishTime = dataM.currentTime + 900;
         _loc1_[2].upgradeFinishTime = dataM.currentTime - 5;
         _loc1_[2].itemsInQueue = 1;
         _loc1_[2].itemTypeInQueue = 1;
         return _loc1_;
      }
      
      public static function getTutorialBaseBuildingStateDataAfterProducingSecondItem() : Object
      {
         var _loc1_:Object = getTutorialBaseBuildingStateDataAfterProducingFirstItem();
         _loc1_[2].queueFinishTime += 900;
         _loc1_[2].itemsInQueue += 1;
         return _loc1_;
      }
      
      public static function getTutorialBaseBuildingStateDataAfterSkippingProductionQueue() : Object
      {
         var _loc1_:Object = getTutorialBaseBuildingStateDataAfterProducingSecondItem();
         _loc1_[2].queueFinishTime = dataM.currentTime - 5;
         _loc1_[2].itemsInQueue = 0;
         return _loc1_;
      }
      
      public static function getRewardDataAfterSkippingProductionQueue() : BMRewardData
      {
         var _loc3_:* = undefined;
         var _loc4_:BMPlayerItemData = null;
         var _loc1_:Array = [BMCampaignMechsHelper.getTutorial_hanger4_topWeapon(),BMCampaignMechsHelper.getTutorial_hanger4_module()];
         var _loc2_:BMRewardData = new BMRewardData();
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = new BMPlayerItemData();
            _loc4_.itemID = _loc3_;
            _loc4_.playerItemID = 10000 + _loc3_;
            _loc2_.items.push(_loc4_);
         }
         return _loc2_;
      }
   }
}

