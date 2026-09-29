package net.battleMechsMulti.mobiles.itemComparison
{
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   
   public class BMMechEquipmentRecommender extends BMBaseClass
   {
      
      public static const NO_RECOMMENDED_SLOT_FOUND:String = "";
      
      public static const EQUIPMENT_TYPES_TO_OPEN_WORKSHOP:Array = [BMMechStructure.TORSO,BMMechStructure.LEG,BMMechStructure.SIDE_WEAPON,BMMechStructure.TOP_WEAPON];
      
      private var _newItemDB:BMItemData;
      
      private var _playerLevel:uint;
      
      private var _playerMechStructure:BMMechStructure;
      
      private var _currentPlayerItemSlot:uint;
      
      private var _playerItemIDs:Array;
      
      private var _onFinishedCallback:Function;
      
      private var _blockEquipSequence:Boolean = false;
      
      public function BMMechEquipmentRecommender()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function recommendEquippingBetterItems(param1:Array, param2:Function = null, param3:Boolean = false) : Boolean
      {
         this._onFinishedCallback = param2;
         if(tutorialM.isTutorialActive())
         {
            this.invokeFinishedCallback();
            return false;
         }
         if(dataM.myProfile.level > dataM.getGeneralSetting("equipRecommendationMaxLevel",0))
         {
            this.invokeFinishedCallback();
            return false;
         }
         this._playerItemIDs = param1;
         this._currentPlayerItemSlot = 0;
         this._blockEquipSequence = param3;
         return this.checkRecommendationForNextItem();
      }
      
      private function invokeFinishedCallback() : void
      {
         var _loc1_:Function = null;
         if(this._onFinishedCallback != null)
         {
            _loc1_ = this._onFinishedCallback;
            this._onFinishedCallback = null;
            _loc1_();
         }
      }
      
      public function checkRecommendationForNextItem() : Boolean
      {
         if(this._currentPlayerItemSlot >= this._playerItemIDs.length)
         {
            this.invokeFinishedCallback();
            return false;
         }
         var _loc1_:uint = uint(this._playerItemIDs[this._currentPlayerItemSlot]);
         ++this._currentPlayerItemSlot;
         var _loc2_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,_loc1_);
         if(_loc2_.equipped > 0)
         {
            return this.checkRecommendationForNextItem();
         }
         if(this.canGetRecommendedSlotForItemID(_loc2_.itemID) == false)
         {
            return this.checkRecommendationForNextItem();
         }
         var _loc3_:String = this.getRecommendedSlotForItemID(_loc2_.itemID);
         if(_loc3_ == NO_RECOMMENDED_SLOT_FOUND)
         {
            return this.checkRecommendationForNextItem();
         }
         var _loc4_:Number = Number(dataM.myPlayerData.mechStructures[1][_loc3_]);
         var _loc5_:BMPlayerItemData = null;
         if(_loc4_ > 0)
         {
            _loc5_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc4_);
         }
         var _loc6_:BMItemData = dataM.itemsDB[_loc2_.itemID];
         var _loc7_:Function = dataM.equipSpecificItem;
         if(this._blockEquipSequence == false && dataM.getGeneralSetting("equipRecommendationShowSequence",1) == 1 && screensM.isBattleOpened() == false && screensM.isDailyLoginStreakBonus() == false && EQUIPMENT_TYPES_TO_OPEN_WORKSHOP.indexOf(_loc6_.type) > -1)
         {
            _loc7_ = this.initEquipSequence;
         }
         screensM.addScreen(BMScreensManager.SCR_EQUIP_BETTER_ITEM_RECOMMENDATION);
         screensM.screenEquipBetterItemRecommendation.displayRecommendation(_loc7_,_loc2_,_loc3_,_loc5_);
         return true;
      }
      
      public function canGetRecommendedSlotForItemID(param1:uint) : Boolean
      {
         var _loc2_:BMItemData = dataM.itemsDB[param1];
         switch(_loc2_.type)
         {
            case BMMechStructure.TORSO:
            case BMMechStructure.LEG:
            case BMMechStructure.SIDE_WEAPON:
            case BMMechStructure.TOP_WEAPON:
            case BMMechStructure.MODULE:
            case BMMechStructure.DRONE:
            case BMMechStructure.TELEPORT:
            case BMMechStructure.CHARGE:
            case BMMechStructure.HARPOON:
               return true;
            default:
               return false;
         }
      }
      
      public function getRecommendedSlotForItemID(param1:uint) : String
      {
         var _loc2_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:BMItemData = null;
         if(this.canGetRecommendedSlotForItemID(param1) == false)
         {
            return NO_RECOMMENDED_SLOT_FOUND;
         }
         this._newItemDB = dataM.itemsDB[param1];
         this._playerLevel = dataM.myProfile.level;
         this._playerMechStructure = dataM.myPlayerData.mechStructures[1];
         var _loc3_:Array = new Array();
         _loc3_.push("");
         switch(this._newItemDB.type)
         {
            case BMMechStructure.SIDE_WEAPON:
            case BMMechStructure.TOP_WEAPON:
            case BMMechStructure.MODULE:
               _loc7_ = dataM.getEquipmentUnlockByLevel(this._playerLevel,this._newItemDB.type);
               _loc2_ = 1;
               while(_loc2_ <= _loc7_)
               {
                  _loc3_.push(this._newItemDB.type + _loc2_);
                  _loc2_++;
               }
               break;
            case BMMechStructure.TORSO:
            case BMMechStructure.LEG:
               _loc3_.push(this._newItemDB.type);
               break;
            default:
               if(dataM.getEquipmentUnlockByLevel(this._playerLevel,this._newItemDB.type) == 1)
               {
                  _loc3_.push(this._newItemDB.type);
               }
         }
         if(_loc3_.length == 1)
         {
            return NO_RECOMMENDED_SLOT_FOUND;
         }
         var _loc4_:String = NO_RECOMMENDED_SLOT_FOUND;
         var _loc5_:Number = -1;
         var _loc6_:uint = 1;
         for(; _loc6_ < _loc3_.length; _loc6_++)
         {
            _loc8_ = _loc3_[_loc6_];
            if(this._playerMechStructure[_loc8_] == 0)
            {
               if(this._playerMechStructure.mechWeight + this._newItemDB.weight <= dataM.weightMax)
               {
                  return _loc8_;
               }
            }
            else
            {
               _loc9_ = dataM.getItemByPlayerItemID(this._playerMechStructure[_loc8_]);
               if(BMItemComparisonLogic.shouldRecommendReplacingItem(_loc9_,this._newItemDB))
               {
                  if(_loc4_ != NO_RECOMMENDED_SLOT_FOUND)
                  {
                     if(_loc9_.specialStatus >= _loc5_)
                     {
                        continue;
                     }
                  }
                  if(this._playerMechStructure.mechWeight - _loc9_.weight + this._newItemDB.weight <= dataM.weightMax)
                  {
                     _loc4_ = _loc8_;
                     _loc5_ = _loc9_.specialStatus;
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function initEquipSequence(param1:uint, param2:uint) : void
      {
         var _loc3_:String = BMScreensManager.SCR_MAIN_MENU;
         var _loc4_:Boolean = BMShopManager.getInstance().isScreenOpened();
         var _loc5_:uint = 0;
         if(_loc4_)
         {
            _loc5_ = BMShopManager.getInstance().currentCategory;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_MULTIPLAYER_LADDER))
         {
            _loc3_ = BMScreensManager.SCR_MULTIPLAYER_LADDER;
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_WORLD_MAP))
         {
            _loc3_ = BMScreensManager.SCR_MISSION_WORLD_MAP;
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_MISSION_BASE_MAP))
         {
            _loc3_ = BMScreensManager.SCR_MISSION_WORLD_MAP;
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_RANKING_LIST))
         {
            _loc3_ = BMScreensManager.SCR_RANKING_LIST;
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE))
         {
            _loc3_ = BMScreensManager.SCR_HANGER_UPGRADE;
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE))
         {
            _loc3_ = BMScreensManager.SCR_MULTIPLAYER_LADDER;
         }
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_WORKSHOP);
         var _loc6_:Number = 1;
         var _loc7_:Object = {
            "playerItemID":param1,
            "equipmentID":param2
         };
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_EQUIP_ITEM,_loc6_,_loc7_);
         screensM.screensDirector.addDataUpdateTask(BMScreensDirectorTask.DATA_UPDATE_SAVE_MECH_CHANGES);
         _loc6_ = 2;
         screensM.screensDirector.addSequenceTask(BMScreensDirectorTask.SEQUENCE_WORKSHOP_MECH_DANCE,_loc6_);
         switch(_loc3_)
         {
            case BMScreensManager.SCR_MAIN_MENU:
               screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
               break;
            case BMScreensManager.SCR_MULTIPLAYER_LADDER:
               screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_PVP_LOBBY);
               break;
            case BMScreensManager.SCR_MISSION_WORLD_MAP:
               screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_CAMPAIGN_WORLD);
               break;
            case BMScreensManager.SCR_RANKING_LIST:
               screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_PVP_LOBBY);
               break;
            case BMScreensManager.SCR_HANGER_UPGRADE:
               screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_UPGRADE);
         }
         if(_loc4_)
         {
            screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_SHOP,{"category":_loc5_});
         }
      }
   }
}

