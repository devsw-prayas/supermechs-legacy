package net.battleMechsMulti.screens.baseBuilding
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingDB;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingManager;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingStructureState;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingTutorialHelper;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMScreenBaseBuildingMain extends BMBaseScreen
   {
      
      private static const TUTORIAL_STAGE_CLICK_ON_EMPTY_GROUND:int = 1;
      
      private static const TUTORIAL_STAGE_CLICK_ON_BUILD:int = 2;
      
      private static const TUTORIAL_STAGE_CLICK_ON_BUILD_ITEM_FACTORY:int = 3;
      
      private static const TUTORIAL_STAGE_CLICK_ON_ITEM_FACTORY:int = 4;
      
      private static const TUTORIAL_STAGE_CLICK_ON_PRODUCE:int = 5;
      
      private static const TUTORIAL_STAGE_CLICK_ON_ITEM:int = 6;
      
      private static const TUTORIAL_STAGE_CLICK_ON_ADD_ITEM:int = 7;
      
      private static const TUTORIAL_STAGE_CLICK_ON_SKIP:int = 8;
      
      private static const TUTORIAL_STAGE_WAIT_FOR_ITEM_COLLECTION:int = 9;
      
      private static const TUTORIAL_STAGE_CLICK_ON_BACK:int = 10;
      
      public var btnClose:BMBasicButton;
      
      public var mcFloorHolder:Sprite;
      
      public var mcEffectsHolder1:MovieClip;
      
      public var mcEffectsHolder2:MovieClip;
      
      public var mcStructuresHolder:MovieClip;
      
      public var mcStructurePlacementsHolder:MovieClip;
      
      public var mcFlowerMenu:BMBaseBuildingFlowerMenu;
      
      public var mcTutorialArrow:Sprite;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _hqPosition:uint;
      
      public var mcLoc0:Sprite;
      
      public var mcLoc1:Sprite;
      
      public var mcLoc2:Sprite;
      
      public var mcLoc3:Sprite;
      
      public var mcLoc4:Sprite;
      
      public var mcLoc5:Sprite;
      
      public var mcLoc6:Sprite;
      
      public var mcLoc7:Sprite;
      
      public var mcLoc8:Sprite;
      
      private var _structureDisplays:Array;
      
      private var _structureDatas:Array;
      
      private var _selectedStructurePosition:int;
      
      private var _lastActiveStructurePosition:int;
      
      private var _nextEventTime:uint;
      
      private const NUM_OF_LOCATIONS:uint = 9;
      
      private const NO_STRUCTURE_SELECTED:int = -1;
      
      private var baseBuildingTutorialStage:int = 0;
      
      public function BMScreenBaseBuildingMain()
      {
         this._selectedStructurePosition = this.NO_STRUCTURE_SELECTED;
         this._lastActiveStructurePosition = this.NO_STRUCTURE_SELECTED;
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("baseBuilding");
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
         this.initFloor();
         if(tutorialM.isTutorialActive())
         {
            this.prepareScreenForTutorial();
         }
         this.createAllStructures();
         this.initFlowerMenu();
         sub(BMPubSub.MESSAGE_BASE_BUILDING_STATE_MODIFIED,this.stateModified);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         sub(BMPubSub.MESSAGE_SCREEN_CLOSED,this.handleScreenClosed);
         sub(BMPubSub.MESSAGE_SECOND_PASSED,this.handleSecondPassed);
         if(tutorialM.isTutorialActive())
         {
            this.proceedToNextTutorialStage();
         }
      }
      
      private function createAllStructures() : void
      {
         var _loc2_:uint = 0;
         var _loc4_:uint = 0;
         this._structureDisplays = new Array();
         this._structureDatas = new Array();
         var _loc1_:Array = dataM.baseBuildingManager.state.getPositionsWithStructures();
         var _loc3_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < this.NUM_OF_LOCATIONS)
         {
            _loc3_[_loc2_] = true;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc4_ = uint(_loc1_[_loc2_]);
            this.createSpecificStructure(_loc4_);
            _loc3_[_loc4_] = false;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_])
            {
               this.createSpecificStructure(_loc2_,true);
            }
            _loc2_++;
         }
         this._nextEventTime = dataM.baseBuildingManager.getNextEventTime();
      }
      
      private function createSpecificStructure(param1:uint, param2:Boolean = false) : void
      {
         var _loc4_:BMBaseBuildingStructureDisplay = null;
         var _loc3_:BMBaseBuildingStructureState = dataM.baseBuildingManager.state.getStructureState(param1);
         if(param2)
         {
            _loc4_ = new BMBaseBuildingStructurePlaceHolder();
         }
         else
         {
            switch(_loc3_.type)
            {
               case BMBaseBuildingDB.STRUCTURE_TYPE_HQ:
                  this._hqPosition = param1;
                  _loc4_ = new BMBaseBuildingHQ();
                  break;
               case BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE:
                  _loc4_ = new BMBaseBuildingGoldMine();
                  break;
               case BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY:
                  _loc4_ = new BMBaseBuildingItemFactory();
            }
         }
         var _loc5_:Sprite = this["mcLoc" + param1];
         _loc4_.x = _loc5_.x + _loc5_.width / 2;
         _loc4_.y = _loc5_.y + _loc5_.height;
         var _loc6_:BMBaseBuildingStructureData = this.createStructureData(param1);
         _loc4_.initialize(param1,_loc6_,this.structureClicked,this.collectClicked);
         this._structureDisplays[param1] = _loc4_;
         this._structureDatas[param1] = _loc6_;
         if(param2)
         {
            this.mcStructurePlacementsHolder.addChild(_loc4_);
         }
         else
         {
            this.mcStructuresHolder.addChild(_loc4_);
         }
      }
      
      private function removeAllStructures() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._structureDisplays.length)
         {
            this.removeSpecificStructure(_loc1_);
            _loc1_++;
         }
         this._structureDisplays = new Array();
         this._structureDatas = new Array();
      }
      
      private function removeSpecificStructure(param1:uint) : void
      {
         var _loc2_:BMBaseBuildingStructureDisplay = this._structureDisplays[param1];
         _loc2_.removeMe();
      }
      
      private function createStructureData(param1:uint) : BMBaseBuildingStructureData
      {
         var _loc19_:Array = null;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc2_:BMBaseBuildingStructureState = dataM.baseBuildingManager.state.getStructureState(param1);
         var _loc3_:Boolean = false;
         var _loc4_:uint = 1;
         var _loc5_:uint = BMBaseBuildingStructureData.COLLECT_TYPE_NONE;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Function = null;
         var _loc17_:uint = 0;
         var _loc18_:Function = null;
         if(_loc2_ == null)
         {
            _loc19_ = dataM.baseBuildingManager.getStructureTypesThatCanBeBuilt();
            if(_loc19_.length > 0)
            {
               _loc9_ = true;
               _loc10_ = dataM.baseBuildingManager.isAnyStructureUpgrading();
               if(_loc10_ == false && tutorialM.isTutorialActive())
               {
                  _loc10_ = param1 > 2;
               }
            }
         }
         else
         {
            _loc14_ = true;
            _loc17_ = _loc2_.level;
            if(dataM.baseBuildingManager.isStructureUpgrading(param1))
            {
               _loc3_ = true;
            }
            if(dataM.baseBuildingManager.getSecondsLeftToUpgradeStructure(param1) > 0)
            {
               _loc18_ = dataM.baseBuildingManager.getSecondsLeftToUpgradeStructure;
               _loc15_ = true;
            }
            if(dataM.baseBuildingManager.getSecondsLeftToFinishProducingItems(param1) > 0)
            {
               _loc18_ = dataM.baseBuildingManager.getSecondsLeftToFinishProducingItems;
               _loc15_ = true;
            }
            if(_loc15_)
            {
               _loc16_ = dataM.baseBuildingManager.getCostTokensToSkipStructure;
            }
            switch(_loc2_.type)
            {
               case BMBaseBuildingDB.STRUCTURE_TYPE_HQ:
                  break;
               case BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE:
                  _loc20_ = dataM.baseBuildingManager.getGoldReadyToBeCollected(param1);
                  if(_loc20_ > 0)
                  {
                     _loc5_ = BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_0;
                  }
                  _loc21_ = dataM.baseBuildingManager.getGoldPercentReadyToBeCollected(param1);
                  if(_loc21_ >= BMBaseBuildingManager.MIN_MINED_GOLD_PERCENT_FOR_COLLECTION)
                  {
                     _loc5_ = BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_1;
                     if(_loc21_ == 100)
                     {
                        _loc5_ = BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_FULL;
                     }
                     else if(_loc21_ >= 66)
                     {
                        _loc5_ = BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_2;
                     }
                     else if(_loc21_ >= 33)
                     {
                        _loc5_ = BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_3;
                     }
                  }
                  break;
               case BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY:
                  _loc11_ = true;
                  _loc13_ = _loc3_;
                  _loc22_ = dataM.baseBuildingManager.getNumberOfItemsReadyToBeCollected(param1);
                  if(_loc22_ > 0)
                  {
                     switch(_loc22_)
                     {
                        case 1:
                           _loc5_ = BMBaseBuildingStructureData.COLLECT_TYPE_ITEMS_1;
                           break;
                        case 2:
                           _loc5_ = BMBaseBuildingStructureData.COLLECT_TYPE_ITEMS_2;
                           break;
                        case 3:
                           _loc5_ = BMBaseBuildingStructureData.COLLECT_TYPE_ITEMS_3;
                           break;
                        default:
                           _loc5_ = BMBaseBuildingStructureData.COLLECT_TYPE_ITEMS_4_PLUS;
                     }
                  }
                  if(_loc3_ == false && dataM.baseBuildingManager.getNumberOfItemsStillInQueue(param1) == 0)
                  {
                     _loc12_ = true;
                  }
            }
            if(_loc15_ == false)
            {
               switch(dataM.baseBuildingManager.getStructureUpgradeState(param1))
               {
                  case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_MAX_LEVEL:
                     break;
                  case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_CAN_UPGRADE:
                     _loc6_ = true;
                     _loc7_ = true;
                     break;
                  case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_NOT_ENOUGH_GOLD:
                     _loc6_ = true;
                     break;
                  case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_OTHER_UPGRADE_IN_PROGRESS:
                  case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_HQ_LEVEL_TOO_LOW:
                  case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_MUST_COLLECT_FIRST:
                  case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_CRAFT_IN_PROGRESS:
                     _loc6_ = true;
                     _loc8_ = true;
               }
               if(_loc6_ && (_loc5_ != BMBaseBuildingStructureData.COLLECT_TYPE_NONE && _loc5_ != BMBaseBuildingStructureData.COLLECT_TYPE_GOLD_0))
               {
                  _loc8_ = true;
               }
            }
         }
         return new BMBaseBuildingStructureData(param1,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc3_,_loc18_);
      }
      
      private function initFlowerMenu() : void
      {
         this.mcFlowerMenu.init(this.flowerMenuButtonClicked);
      }
      
      private function flowerMenuButtonClicked(param1:String) : void
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case this.mcFlowerMenu.BTN_INFO:
               this.handleInfoAction();
               _loc2_ = true;
               break;
            case this.mcFlowerMenu.BTN_BUILD:
               this.handleBuildAction();
               break;
            case this.mcFlowerMenu.BTN_BUILD_DISABLED:
               this.handleBuildDisabledAction();
               break;
            case this.mcFlowerMenu.BTN_COLLECT_GOLD:
            case this.mcFlowerMenu.BTN_COLLECT_ITEMS:
               this.handleCollectAction();
               break;
            case this.mcFlowerMenu.BTN_UPGRADE:
               this.handleUpgradeAction();
               break;
            case this.mcFlowerMenu.BTN_SKIP:
               this.handleSkipAction(this._selectedStructurePosition);
               break;
            case this.mcFlowerMenu.BTN_PRODUCE:
               this.handleProduceAction();
               break;
            case this.mcFlowerMenu.BTN_PRODUCE_DISABLED:
               this.handleProduceDisabledAction();
         }
         if(_loc2_ == false)
         {
            this.deselectStructure();
         }
      }
      
      private function handleInfoAction() : void
      {
         screensM.addScreen(BMScreensManager.SCR_BASE_BUILDING_STRUCTURE_INFO);
         screensM.screenBaseBuildingStructureInfo.showStructureInfo(this._lastActiveStructurePosition);
      }
      
      private function handleBuildAction() : void
      {
         screensM.addScreen(BMScreensManager.SCR_BASE_BUILDING_STRUCTURES_MENU);
         var _loc1_:Array = dataM.baseBuildingManager.getStructureTypesThatCanBeBuilt();
         var _loc2_:int = dataM.baseBuildingManager.getHQLevelRequiredToBuildNextInstanceOfStructure(BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE);
         var _loc3_:int = dataM.baseBuildingManager.getHQLevelRequiredToBuildNextInstanceOfStructure(BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY);
         screensM.screenBaseBuildingStructuresMenu.refreshScreen(_loc1_,_loc2_,_loc3_);
         if(this.isInTutorial && this.baseBuildingTutorialStage == TUTORIAL_STAGE_CLICK_ON_BUILD)
         {
            this.proceedToNextTutorialStage();
         }
      }
      
      private function handleBuildDisabledAction() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("baseBuilding_anotherUpgradeInProgress");
      }
      
      private function handleCollectAction() : void
      {
         var _loc1_:BMBaseBuildingStructureDisplay = null;
         var _loc2_:BMBaseBuildingStructureState = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         if(this.canCollectFromCurrentStructure())
         {
            this.showPleaseWaitMessage();
            _loc1_ = this._structureDisplays[this._lastActiveStructurePosition];
            _loc2_ = dataM.baseBuildingManager.state.getStructureState(this._lastActiveStructurePosition);
            _loc3_ = _loc1_.x + _loc1_.mcCollectIndicator.x;
            _loc4_ = _loc1_.y + _loc1_.mcCollectIndicator.y;
            if(_loc2_.type == BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE)
            {
               _loc5_ = dataM.baseBuildingManager.getGoldReadyToBeCollected(this._lastActiveStructurePosition);
               effectsM.createFlyingNumber(this.mcEffectsHolder2,_loc3_,_loc4_,"+" + _loc5_,"yellow",0,2,"up");
               _loc6_ = dataM.baseBuildingManager.getGoldPercentReadyToBeCollected(this._lastActiveStructurePosition);
               _loc7_ = 3 + Math.ceil(_loc6_ / 100) * 10;
               _loc8_ = 0;
               while(_loc8_ < _loc7_)
               {
                  TweenMax.to(this,_loc8_ * 0.05,{
                     "onComplete":this.createFlyingGoldCoin,
                     "onCompleteParams":[_loc3_,_loc4_]
                  });
                  _loc8_++;
               }
            }
            dataM.baseBuildingManager.collectResources(this._lastActiveStructurePosition);
         }
      }
      
      private function createFlyingGoldCoin(param1:Number, param2:Number) : void
      {
         effectsM.createFlyingGoldCoinEffect(param1,param2);
      }
      
      private function handleUpgradeAction() : void
      {
         var _loc1_:BMBaseBuildingStructureState = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc1_ = dataM.baseBuildingManager.state.getStructureState(this._lastActiveStructurePosition);
         var _loc2_:String = null;
         switch(dataM.baseBuildingManager.getStructureUpgradeState(this._lastActiveStructurePosition))
         {
            case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_OTHER_UPGRADE_IN_PROGRESS:
               screensM.screenConfirmation.displayQuestionOrNotification("baseBuilding_anotherUpgradeInProgress");
               break;
            case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_HQ_LEVEL_TOO_LOW:
               screensM.screenConfirmation.displayQuestionOrNotification("baseBuilding_hqLevelTooLow");
               break;
            case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_MUST_COLLECT_FIRST:
               _loc2_ = getScreenText("mustCollectBeforeUpgrade");
               screensM.screenConfirmation.displayCustomMessage(_loc2_);
               break;
            case BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_CRAFT_IN_PROGRESS:
               _loc2_ = getScreenText("cannotUpgradeDuringCraft");
               screensM.screenConfirmation.displayCustomMessage(_loc2_);
               break;
            default:
               screensM.addScreen(BMScreensManager.SCR_BASE_BUILDING_STRUCTURE_INFO);
               _loc3_ = dataM.baseBuildingManager.db.getGoldRequiredToUpgradeStructure(_loc1_.type,_loc1_.level);
               _loc4_ = dataM.baseBuildingManager.db.getSecondsRequiredToUpgradeStructure(_loc1_.type,_loc1_.level);
               screensM.screenBaseBuildingStructureInfo.showUpgradeInfo(this._lastActiveStructurePosition,_loc3_,_loc4_);
         }
      }
      
      public function upgradeClicked() : void
      {
         var _loc3_:uint = 0;
         var _loc1_:BMBaseBuildingStructureState = dataM.baseBuildingManager.state.getStructureState(this._lastActiveStructurePosition);
         var _loc2_:uint = dataM.baseBuildingManager.getStructureUpgradeState(this._lastActiveStructurePosition);
         if(_loc2_ == BMBaseBuildingManager.STRUCTURE_UPGRADE_STATE_NOT_ENOUGH_GOLD)
         {
            _loc3_ = dataM.baseBuildingManager.db.getGoldRequiredToUpgradeStructure(_loc1_.type,_loc1_.level);
            BMShopManager.gi().showBuyMoreGoldYesNoPopup(_loc3_);
         }
         else
         {
            this.showPleaseWaitMessage();
            dataM.baseBuildingManager.upgradeStructure(this._lastActiveStructurePosition);
            soundM.createSound("kitUsed",1);
         }
         this.deselectStructure();
      }
      
      public function infoClosed() : void
      {
         this.deselectStructure();
      }
      
      private function handleSkipAction(param1:uint) : void
      {
         var _loc2_:uint = dataM.baseBuildingManager.getCostTokensToSkipStructure(this._lastActiveStructurePosition);
         if(_loc2_ == 0)
         {
            this.tryToSkip();
            return;
         }
         screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP);
         var _loc3_:String = getScreenText("confirmAction");
         var _loc4_:String = getScreenText("confirmSkip");
         var _loc5_:String = getScreenText("skipAction");
         var _loc6_:String = getGeneralText("cancel");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%TOKENS%",String(_loc2_));
         screensM.screenYesNoPopup.displayYesNoPopup(_loc3_,_loc4_,"",this.tryToSkip,null,_loc5_,_loc6_);
      }
      
      private function handleProduceAction() : void
      {
         screensM.addScreen(BMScreensManager.SCR_BASE_BUILDING_ITEM_FACTORY);
         screensM.screenBaseBuildingItemFactory.refreshScreen(this.getItemFactoryItemTypesData(this._lastActiveStructurePosition));
         if(this.isInTutorial && this.baseBuildingTutorialStage == TUTORIAL_STAGE_CLICK_ON_PRODUCE)
         {
            this.proceedToNextTutorialStage();
         }
      }
      
      private function handleProduceDisabledAction() : void
      {
         var _loc1_:String = getScreenText("cannotCraftDuringUpgrade");
         screensM.screenConfirmation.displayCustomMessage(_loc1_);
      }
      
      private function updateItemFactoryData() : void
      {
         screensM.screenBaseBuildingItemFactory.refreshScreen(this.getItemFactoryItemTypesData(this._lastActiveStructurePosition));
      }
      
      private function getItemFactoryItemTypesData(param1:int) : Array
      {
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:BMItemFactoryItemTypeData = null;
         var _loc2_:BMBaseBuildingStructureState = dataM.baseBuildingManager.state.getStructureState(param1);
         var _loc3_:Array = new Array();
         var _loc4_:uint = dataM.baseBuildingManager.db.getStructureMaxLevel(BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY);
         var _loc5_:Boolean = dataM.baseBuildingManager.getSecondsLeftToFinishProducingItems(param1) > 0;
         var _loc6_:uint = 1;
         while(_loc6_ <= _loc4_)
         {
            _loc7_ = _loc6_ <= _loc2_.level;
            _loc8_ = _loc6_ <= _loc2_.level + 2 || _loc6_ == _loc4_;
            if(_loc8_ != false)
            {
               _loc9_ = new BMItemFactoryItemTypeData();
               _loc9_.level = _loc6_;
               _loc9_.title = languageM.getText(dataM.baseBuildingManager.db.getItemFactoryLevelTitle(_loc6_));
               _loc9_.desc = languageM.getText(dataM.baseBuildingManager.db.getItemFactoryLevelDescription(_loc6_));
               _loc9_.visualID = dataM.baseBuildingManager.db.getItemFactoryLevelVisualID(_loc6_);
               if(_loc6_ == _loc2_.itemFactoryItemTypeInQueue)
               {
                  _loc9_.amountInQueue = dataM.baseBuildingManager.state.getStructureState(param1).itemFactoryItemsInQueue;
                  _loc9_.amountReady = dataM.baseBuildingManager.getNumberOfItemsReadyToBeCollected(param1);
                  _loc9_.endBuildTime = dataM.baseBuildingManager.now + dataM.baseBuildingManager.getSecondsLeftToItemFactoryNextItemReadyTime(param1);
                  _loc9_.tokensCost = dataM.baseBuildingManager.getCostTokensToSkipStructure(param1);
               }
               _loc9_.locked = _loc7_ == false;
               if(_loc7_ == false)
               {
                  _loc9_.lockedLevel = _loc6_;
               }
               _loc9_.hasSeparator = _loc6_ == _loc4_ && _loc2_.level < _loc4_ - 3;
               _loc9_.goldCost = dataM.baseBuildingManager.getItemFactoryProductionPriceForPlayer(_loc6_);
               _loc3_.push(_loc9_);
               _loc9_.interactable = _loc7_ && (_loc5_ == false || _loc6_ == _loc2_.itemFactoryItemTypeInQueue);
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      private function canCollectFromCurrentStructure() : Boolean
      {
         if(dataM.isInventoryFull(true) && dataM.baseBuildingManager.state.getStructureState(this._lastActiveStructurePosition).type == BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY)
         {
            screensM.addScreen(BMScreensManager.SCR_INVENTORY_FULL);
            return false;
         }
         return true;
      }
      
      private function tryToSkip() : void
      {
         var _loc1_:uint = dataM.baseBuildingManager.getCostTokensToSkipStructure(this._lastActiveStructurePosition);
         if(dataM.myProfile.tokens >= _loc1_)
         {
            if(this.canCollectFromCurrentStructure())
            {
               this.showPleaseWaitMessage();
               dataM.baseBuildingManager.skipStructureQueueWithTokens(this._lastActiveStructurePosition);
            }
         }
         else
         {
            BMShopManager.gi().showBuyMoreGoldYesNoPopup(_loc1_);
         }
         this.deselectStructure();
      }
      
      private function structureClicked(param1:uint) : void
      {
         var _loc6_:BMBaseBuildingStructureDisplay = null;
         if(this._selectedStructurePosition != this.NO_STRUCTURE_SELECTED)
         {
            _loc6_ = this._structureDisplays[this._selectedStructurePosition];
            _loc6_.selected = false;
         }
         if(this._selectedStructurePosition == param1)
         {
            this.deselectStructure();
            return;
         }
         var _loc2_:BMBaseBuildingStructureState = dataM.baseBuildingManager.state.getStructureState(param1);
         if(_loc2_ == null && dataM.baseBuildingManager.getStructureTypesThatCanBeBuilt().length == 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("baseBuilding_cannotBuildAnotherStructure",dataM.baseBuildingManager.getHQLevelToUnlockNextStructure());
            this.deselectStructure();
            return;
         }
         this._selectedStructurePosition = param1;
         this._lastActiveStructurePosition = param1;
         var _loc3_:BMBaseBuildingStructureDisplay = this._structureDisplays[param1];
         var _loc4_:BMBaseBuildingStructureData = this.createStructureData(param1);
         var _loc5_:Point = new Point(_loc3_.x,_loc3_.y - 60);
         _loc3_.selected = true;
         this.mcFlowerMenu.open(_loc5_,_loc4_);
         if(this.isInTutorial)
         {
            this.proceedToNextTutorialStage();
         }
      }
      
      private function collectClicked(param1:uint) : void
      {
         this._lastActiveStructurePosition = param1;
         this.handleCollectAction();
         this.deselectStructure();
      }
      
      public function buildGoldMine() : void
      {
         this.buildStructure(BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE);
      }
      
      public function buildItemFactory() : void
      {
         if(this.isInTutorial)
         {
            if(this.baseBuildingTutorialStage == TUTORIAL_STAGE_CLICK_ON_BUILD_ITEM_FACTORY)
            {
               this.proceedToNextTutorialStage();
            }
         }
         else
         {
            this.buildStructure(BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY);
         }
      }
      
      public function openHQUpgrade() : void
      {
         this.deselectStructure();
         this.structureClicked(this._hqPosition);
         if(dataM.baseBuildingManager.isAnyStructureUpgrading())
         {
            this.flowerMenuButtonClicked(this.mcFlowerMenu.BTN_INFO);
         }
         else
         {
            this.flowerMenuButtonClicked(this.mcFlowerMenu.BTN_UPGRADE);
         }
      }
      
      public function buildStructureCanceled() : void
      {
         this.deselectStructure();
      }
      
      private function buildStructure(param1:uint) : void
      {
         this.showPleaseWaitMessage();
         dataM.baseBuildingManager.buildStructure(this._lastActiveStructurePosition,param1);
         this.deselectStructure();
         soundM.createSound("earnRankStar",1);
         soundM.createSound("itemBought",1);
      }
      
      private function deselectStructure() : void
      {
         var _loc1_:BMBaseBuildingStructureDisplay = null;
         if(this._selectedStructurePosition != this.NO_STRUCTURE_SELECTED)
         {
            _loc1_ = this._structureDisplays[this._selectedStructurePosition];
            _loc1_.selected = false;
         }
         this._selectedStructurePosition = this.NO_STRUCTURE_SELECTED;
         this.mcFlowerMenu.close();
      }
      
      private function refreshScreen() : *
      {
         this.removeAllStructures();
         this.createAllStructures();
         if(screensM.isScreenOpened(BMScreensManager.SCR_BASE_BUILDING_ITEM_FACTORY))
         {
            this.updateItemFactoryData();
         }
         this.refreshTutorialArrowIfNeeded();
      }
      
      public function stateModified(param1:String, param2:Object) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.refreshScreen();
      }
      
      public function handleSecondPassed(param1:String, param2:Object) : void
      {
         if(this._nextEventTime > 0 && dataM.currentTime >= this._nextEventTime)
         {
            this.refreshScreen();
         }
      }
      
      public function notifyAddItemToQueueRequested(param1:uint) : void
      {
         var _loc2_:uint = 0;
         if(this.isInTutorial)
         {
            if(this.baseBuildingTutorialStage == TUTORIAL_STAGE_CLICK_ON_ADD_ITEM)
            {
               this.proceedToNextTutorialStage();
            }
         }
         else
         {
            _loc2_ = dataM.baseBuildingManager.getItemFactoryProductionPriceForPlayer(param1);
            if(_loc2_ > dataM.myProfile.gold)
            {
               BMShopManager.gi().showBuyMoreGoldYesNoPopup(_loc2_);
            }
            else
            {
               dataM.baseBuildingManager.addToItemFactoryBuildQueue(this._lastActiveStructurePosition,param1,1);
            }
         }
      }
      
      public function notifyRemoveItemFromQueueRequested(param1:uint) : void
      {
         this.removeItemFromQueueImpl();
      }
      
      private function removeItemFromQueueImpl() : *
      {
         dataM.baseBuildingManager.removeFromItemFactoryBuildQueue(this._lastActiveStructurePosition,1);
      }
      
      public function notifyBuildItemRequested(param1:uint) : void
      {
         if(this.isInTutorial)
         {
            if(this.baseBuildingTutorialStage == TUTORIAL_STAGE_CLICK_ON_ITEM)
            {
               this.proceedToNextTutorialStage();
            }
         }
         else
         {
            dataM.baseBuildingManager.addToItemFactoryBuildQueue(this._lastActiveStructurePosition,param1,1);
         }
      }
      
      public function notifySkipBuildItemQueueRequested(param1:uint) : void
      {
         if(this.isInTutorial)
         {
            if(this.baseBuildingTutorialStage == TUTORIAL_STAGE_CLICK_ON_SKIP)
            {
               this.proceedToNextTutorialStage();
            }
         }
         else
         {
            this.handleSkipAction(this._lastActiveStructurePosition);
         }
      }
      
      private function showPleaseWaitMessage() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      private function initFloor() : void
      {
         var _loc1_:Sprite = externalAssetsM.getAsset("general","Grp_missionFloor1");
         _loc1_.width = dataM.STAGE_WIDTH;
         _loc1_.height = dataM.STAGE_HEIGHT + 100;
         this.mcFloorHolder.addChild(_loc1_);
      }
      
      private function closeClicked(param1:Event) : void
      {
         if(this.baseBuildingTutorialStage == TUTORIAL_STAGE_CLICK_ON_BACK)
         {
            tutorialM.onlyClickableMovieClip = null;
         }
         screensM.screenTransitionsManager.mainMenu();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this);
         this.removeAllStructures();
      }
      
      private function prepareScreenForTutorial() : void
      {
         this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow);
         dataM.baseBuildingManager.parseRules(BMBaseBuildingTutorialHelper.getTutorialBaseBuildingDBData());
         dataM.baseBuildingManager.updateState(BMBaseBuildingTutorialHelper.getTutorialBaseBuildingInitialStateData());
      }
      
      private function proceedToNextTutorialStage() : void
      {
         var _loc1_:BMPlayerProfile = null;
         ++this.baseBuildingTutorialStage;
         switch(this.baseBuildingTutorialStage)
         {
            case TUTORIAL_STAGE_CLICK_ON_EMPTY_GROUND:
               this.activateTutorialArrow_clickOnLoc2();
               break;
            case TUTORIAL_STAGE_CLICK_ON_BUILD:
               this.activateTutorialArrow_clickOnBuild();
               break;
            case TUTORIAL_STAGE_CLICK_ON_BUILD_ITEM_FACTORY:
               this.activateTutorialArrow_clickOnBuildItemFactory();
               break;
            case TUTORIAL_STAGE_CLICK_ON_ITEM_FACTORY:
               tutorialM.onlyClickableMovieClip = tutorialM.invisibleMovieClip;
               dataM.baseBuildingManager.updateState(BMBaseBuildingTutorialHelper.getTutorialBaseBuildingStateDataAfterBuildingItemFactory());
               break;
            case TUTORIAL_STAGE_CLICK_ON_PRODUCE:
               this.activateTutorialArrow_clickOnProduce();
               break;
            case TUTORIAL_STAGE_CLICK_ON_ITEM:
               this.activateTutorialArrow_clickOnItem();
               break;
            case TUTORIAL_STAGE_CLICK_ON_ADD_ITEM:
               dataM.baseBuildingManager.updateState(BMBaseBuildingTutorialHelper.getTutorialBaseBuildingStateDataAfterProducingFirstItem());
               dataM.myProfile.gold -= dataM.baseBuildingManager.db.getItemFactoryProductionPrice(1);
               this.activateTutorialArrow_clickOnAddItem();
               break;
            case TUTORIAL_STAGE_CLICK_ON_SKIP:
               dataM.myProfile.gold -= dataM.baseBuildingManager.db.getItemFactoryProductionPrice(1);
               dataM.baseBuildingManager.updateState(BMBaseBuildingTutorialHelper.getTutorialBaseBuildingStateDataAfterProducingSecondItem());
               this.activateTutorialArrow_clickOnSkip();
               break;
            case TUTORIAL_STAGE_WAIT_FOR_ITEM_COLLECTION:
               BMTutorialManager.gi().onlyClickableMovieClip = null;
               dataM.baseBuildingManager.notifySkipQueueWithTokensSucceeded(BMBaseBuildingTutorialHelper.getTutorialBaseBuildingStateDataAfterSkippingProductionQueue(),BMBaseBuildingTutorialHelper.getRewardDataAfterSkippingProductionQueue());
               _loc1_ = dataM.myProfile;
               if(_loc1_.tutorialLevel <= BMTutorialManager.TUTORIAL_LEVEL_SHOP1)
               {
                  tutorialM.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_SHOP1 + 1);
               }
               break;
            case TUTORIAL_STAGE_CLICK_ON_BACK:
               this.activateTutorialArrow_clickOnBack();
         }
      }
      
      private function refreshTutorialArrowIfNeeded() : *
      {
         if(this.baseBuildingTutorialStage == TUTORIAL_STAGE_CLICK_ON_ITEM_FACTORY)
         {
            if(dataM.baseBuildingManager.isAnyStructureUpgrading())
            {
               tutorialM.onlyClickableMovieClip = tutorialM.invisibleMovieClip;
            }
            else
            {
               this.activateTutorialArrow_clickOnLoc2();
            }
         }
      }
      
      private function activateTutorialArrow(param1:MovieClip, param2:MovieClip, param3:int = 0, param4:int = 0, param5:Number = 0, param6:Number = 0) : *
      {
         tutorialM.onlyClickableMovieClip = null;
         this._tutorialArrowController.deactivateTutorialArrow();
         var _loc7_:Number = param1.x + param1.width;
         var _loc8_:Number = param1.y + param1.height / 2;
         if(param5 != 0)
         {
            _loc7_ = param5;
         }
         if(param6 != 0)
         {
            _loc8_ = param6;
         }
         this._tutorialArrowController.activateTutorialArrowWithTimer(param2,_loc7_,_loc8_,param3,param4);
         tutorialM.onlyClickableMovieClip = param1;
      }
      
      public function activateTutorialArrow_clickOnLoc2() : void
      {
         var _loc1_:MovieClip = this._structureDisplays[2];
         this.activateTutorialArrow(_loc1_,this,0,0,this.mcLoc2.x + this.mcLoc2.width,this.mcLoc2.y + this.mcLoc2.height / 2);
      }
      
      public function activateTutorialArrow_clickOnBuild() : void
      {
         var _loc1_:Point = this.mcFlowerMenu.getButtonOriginPos(this.mcFlowerMenu.BTN_BUILD);
         var _loc2_:Number = _loc1_.x + this.mcFlowerMenu.btnBuild.width;
         var _loc3_:Number = _loc1_.y + this.mcFlowerMenu.btnBuild.height / 2;
         this._tutorialArrowController.deactivateTutorialArrow();
         this._tutorialArrowController.activateTutorialArrowWithTimer(this.mcFlowerMenu,_loc2_,_loc3_,0,10);
         tutorialM.onlyClickableMovieClip = this.mcFlowerMenu.btnBuild;
      }
      
      public function activateTutorialArrow_clickOnProduce() : void
      {
         this._tutorialArrowController.deactivateTutorialArrow();
         var _loc1_:Number = this.mcFlowerMenu.btnProduce.width;
         var _loc2_:Number = this.mcFlowerMenu.btnProduce.height / 2;
         this._tutorialArrowController.activateTutorialArrowWithTimer(this.mcFlowerMenu.btnProduce,_loc1_,_loc2_,0,10);
         tutorialM.onlyClickableMovieClip = this.mcFlowerMenu.btnProduce;
      }
      
      public function activateTutorialArrow_clickOnBuildItemFactory() : void
      {
         this._tutorialArrowController.deactivateTutorialArrow();
         screensM.screenBaseBuildingStructuresMenu.showTutorialArrowOnItemFactory();
      }
      
      public function activateTutorialArrow_clickOnItem() : void
      {
         this._tutorialArrowController.deactivateTutorialArrow();
         TweenMax.delayedCall(1,screensM.screenBaseBuildingItemFactory.showTutorialArrowOnFirstItemBuildButton);
      }
      
      public function activateTutorialArrow_clickOnAddItem() : void
      {
         screensM.screenBaseBuildingItemFactory.hideTutorialArrow();
         TweenMax.delayedCall(0.3,screensM.screenBaseBuildingItemFactory.showTutorialArrowOnFirstItemAddButton);
      }
      
      public function activateTutorialArrow_clickOnSkip() : void
      {
         screensM.screenBaseBuildingItemFactory.hideTutorialArrow();
         TweenMax.delayedCall(0.3,screensM.screenBaseBuildingItemFactory.showTutorialArrowOnFirstItemSkipButton);
      }
      
      public function activateTutorialArrow_clickOnBack() : void
      {
         this.activateTutorialArrow(this.btnClose,this);
      }
      
      private function get isInTutorial() : Boolean
      {
         return this.baseBuildingTutorialStage > 0;
      }
      
      private function handleScreenClosed(param1:String, param2:Object) : *
      {
         if(param2.screen == BMScreensManager.SCR_ITEM_CARDS)
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_BASE_BUILDING_ITEM_FACTORY))
            {
               screensM.screenBaseBuildingItemFactory.removeMe();
            }
            if(this.baseBuildingTutorialStage == TUTORIAL_STAGE_WAIT_FOR_ITEM_COLLECTION)
            {
               this.proceedToNextTutorialStage();
            }
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
         super.notifyClientDataReloaded();
         this.refreshScreen();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BASE_BUILDING_MAIN);
      }
      
      override public function notifyRemoved() : *
      {
         var _loc1_:String = null;
         super.notifyRemoved();
         for each(_loc1_ in [BMScreensManager.SCR_BASE_BUILDING_ITEM_FACTORY,BMScreensManager.SCR_BASE_BUILDING_STRUCTURE_INFO,BMScreensManager.SCR_BASE_BUILDING_STRUCTURES_MENU])
         {
            if(screensM.isScreenOpened(_loc1_))
            {
               screensM.removeScreen(_loc1_);
            }
         }
      }
   }
}

