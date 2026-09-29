package net.battleMechsMulti.screens.baseBuilding
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingDB;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingStructureState;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   import net.battleMechsMulti.utils.TimeUtils;
   
   public class BMScreenBaseBuildingStructureInfo extends BMBaseScreen
   {
      
      private static const MAX_STRUCTURE_LEVEL_CRITERIA_KEY:String = "maxStructureLevelCriteria";
      
      private static const NUMBER_OF_ITEM_FACTORIES_CRITERIA_KEY:String = "numberOfItemFactoriesCriteria";
      
      private static const NUMBER_OF_GOLD_MINES_CRITERIA_KEY:String = "numberOfGoldMinesCriteria";
      
      private static const MINING_RATE_CRITERIA_KEY:String = "miningRateCriteria";
      
      private static const MINING_CAPACITY_CRITERIA_KEY:String = "miningCapacityCriteria";
      
      private static const CRAFTING_TYPES_CRITERIA_KEY:String = "craftingTypesCriteria";
      
      private static const NEW_CRAFTING_TYPE_CRITERIA_KEY:String = "newCraftingTypeCriteria";
      
      private static const UPGRADE_HQ_STRUCTURE_TYPES:Array = [BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE,BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY];
      
      private static const UPGRADE_HQ_STRUCTURE_CRITERIA_NAMES:Array = [NUMBER_OF_GOLD_MINES_CRITERIA_KEY,NUMBER_OF_ITEM_FACTORIES_CRITERIA_KEY];
      
      public var mcHQ:Sprite;
      
      public var mcGoldMine:Sprite;
      
      public var mcItemFactory:Sprite;
      
      public var btnClose:BMBasicButton;
      
      public var btnUpgrade:BMBasicButton;
      
      public var btnUpgradeWide:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var txtDetails:TextField;
      
      public var txtUpgradeTime:TextField;
      
      public var txtDescription:TextField;
      
      public var mcFrame:MovieClip;
      
      private var _structureState:BMBaseBuildingStructureState;
      
      private var _position:int;
      
      public function BMScreenBaseBuildingStructureInfo()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClicked);
         setLanguageManagerScreenName("baseBuilding");
         this.btnUpgrade.addEventListener(BMIntractable.HIT,this.upgradeClicked);
         this.btnUpgradeWide.addEventListener(BMIntractable.HIT,this.upgradeClicked);
      }
      
      public function showStructureInfo(param1:uint) : void
      {
         this._structureState = dataM.baseBuildingManager.state.getStructureState(param1);
         this._position = param1;
         this.showImage();
         var _loc2_:uint = 90;
         this.txtDetails.y += _loc2_;
         this.setTitle();
         updateTextAndFormat(this.txtDetails,this.getStructureDetails(this._structureState.type,this._structureState.level).join("\n"));
         this.btnUpgrade.visible = false;
         this.btnUpgradeWide.visible = false;
         this.txtUpgradeTime.text = "";
         updateTextAndFormat(this.txtDescription,this.getStructureDescription(this._structureState.type));
      }
      
      public function showUpgradeInfo(param1:uint, param2:uint, param3:uint) : void
      {
         this._structureState = dataM.baseBuildingManager.state.getStructureState(param1);
         this.showImage();
         this.setTitle(true);
         updateTextAndFormat(this.txtDetails,this.getUpgradeDetails(this._structureState.type,this._structureState.level).join("\n"));
         this.btnUpgrade.visible = false;
         this.btnUpgradeWide.visible = false;
         if(param2 > 99999)
         {
            this.btnUpgradeWide.visible = true;
            this.btnUpgradeWide.text = TextUtils.getNumberWithComma(param2);
         }
         else
         {
            this.btnUpgrade.visible = true;
            this.btnUpgrade.text = TextUtils.getNumberWithComma(param2);
         }
         var _loc4_:String = languageM.getText("baseBuilding_upgradeTime");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%TIME%",TimeUtils.formatTimeLeftWithDays(param3));
         updateTextAndFormat(this.txtUpgradeTime,_loc4_);
         this.txtDescription.text = "";
      }
      
      private function upgradeClicked(param1:Event) : void
      {
         screensM.screenBaseBuildingMain.upgradeClicked();
         this.removeMe();
      }
      
      private function setTitle(param1:Boolean = false) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = getSpecificText("selectAccount_level");
         _loc3_ = dataM.replaceStringInText(_loc3_,"%LEVEL%",String(this._structureState.level));
         var _loc4_:String = dataM.baseBuildingManager.getStructureName(this._structureState.type) + " " + _loc3_;
         if(param1)
         {
            _loc2_ = languageM.getText("hanger_fusion") + " " + _loc4_;
         }
         else
         {
            _loc2_ = _loc4_;
         }
         updateTextAndFormat(this.txtTitle,_loc2_);
      }
      
      private function showImage() : void
      {
         this.mcHQ.visible = false;
         this.mcGoldMine.visible = false;
         this.mcItemFactory.visible = false;
         switch(this._structureState.type)
         {
            case BMBaseBuildingDB.STRUCTURE_TYPE_HQ:
               this.mcHQ.visible = true;
               break;
            case BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE:
               this.mcGoldMine.visible = true;
               break;
            case BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY:
               this.mcItemFactory.visible = true;
         }
      }
      
      private function onCloseClicked(param1:Event) : void
      {
         screensM.screenBaseBuildingMain.infoClosed();
         this.removeMe();
      }
      
      private function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BASE_BUILDING_STRUCTURE_INFO);
      }
      
      private function getStructureDescription(param1:uint) : String
      {
         switch(param1)
         {
            case BMBaseBuildingDB.STRUCTURE_TYPE_HQ:
               return getScreenText("headquartersDescription");
            case BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE:
               return getScreenText("goldMineDescription");
            case BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY:
               return getScreenText("itemFactoryDescription");
            default:
               return null;
         }
      }
      
      private function getStructureDetails(param1:uint, param2:uint) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         switch(param1)
         {
            case BMBaseBuildingDB.STRUCTURE_TYPE_HQ:
               _loc3_ = [this.getNumericDescriptionString(MAX_STRUCTURE_LEVEL_CRITERIA_KEY,param2)];
               _loc5_ = 0;
               while(_loc5_ < UPGRADE_HQ_STRUCTURE_TYPES.length)
               {
                  _loc6_ = int(dataM.baseBuildingManager.getNumberOfStructuresAvailableAtHQLevel(param2,UPGRADE_HQ_STRUCTURE_TYPES[_loc5_]));
                  _loc3_.push(this.getNumericDescriptionString(UPGRADE_HQ_STRUCTURE_CRITERIA_NAMES[_loc5_],_loc6_));
                  _loc5_++;
               }
               return _loc3_;
            case BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE:
               _loc4_ = this.highlightStr(TextUtils.getNumberWithComma(dataM.baseBuildingManager.getGoldReadyToBeCollected(this._position))) + " / " + this.highlightStr(TextUtils.getNumberWithComma(dataM.baseBuildingManager.db.getGoldMineCapacity(param2)));
               return [this.getNumericDescriptionString(MINING_RATE_CRITERIA_KEY,dataM.baseBuildingManager.db.getGoldMineMiningRate(param2)),this.getDescriptionString(MINING_CAPACITY_CRITERIA_KEY,_loc4_)];
            case BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY:
               return [this.getNumericDescriptionString(CRAFTING_TYPES_CRITERIA_KEY,param2)];
            default:
               return null;
         }
      }
      
      private function getDescriptionString(param1:String, param2:String) : *
      {
         return getScreenText(param1) + ": " + param2.toString();
      }
      
      private function getNumericDescriptionString(param1:String, param2:int) : *
      {
         return this.getDescriptionString(param1,this.highlightStr(TextUtils.getNumberWithComma(param2)));
      }
      
      private function getUpgradeDescriptionString(param1:String, param2:String, param3:String) : *
      {
         return getScreenText(param1) + ": " + this.highlightStr(param2.toString()) + " -> " + this.highlightStr(param3.toString());
      }
      
      private function getNumericUpgradeDescriptionString(param1:String, param2:int, param3:int) : *
      {
         return this.getUpgradeDescriptionString(param1,TextUtils.getNumberWithComma(param2),TextUtils.getNumberWithComma(param3));
      }
      
      private function highlightStr(param1:String) : String
      {
         return "<FONT COLOR=\'#FFCC00\'>" + param1 + "</FONT>";
      }
      
      private function getUpgradeDetails(param1:uint, param2:uint) : Array
      {
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc3_ = param2 + 1;
         switch(param1)
         {
            case BMBaseBuildingDB.STRUCTURE_TYPE_HQ:
               _loc4_ = [this.getNumericUpgradeDescriptionString(MAX_STRUCTURE_LEVEL_CRITERIA_KEY,param2,_loc3_)];
               _loc6_ = 0;
               while(_loc6_ < UPGRADE_HQ_STRUCTURE_TYPES.length)
               {
                  _loc7_ = int(dataM.baseBuildingManager.getNumberOfStructuresAvailableAtHQLevel(param2,UPGRADE_HQ_STRUCTURE_TYPES[_loc6_]));
                  _loc8_ = int(dataM.baseBuildingManager.getNumberOfStructuresAvailableAtHQLevel(_loc3_,UPGRADE_HQ_STRUCTURE_TYPES[_loc6_]));
                  if(_loc8_ > _loc7_)
                  {
                     _loc4_.push(this.getNumericUpgradeDescriptionString(UPGRADE_HQ_STRUCTURE_CRITERIA_NAMES[_loc6_],_loc7_,_loc8_));
                  }
                  _loc6_++;
               }
               return _loc4_;
            case BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE:
               return [this.getNumericUpgradeDescriptionString(MINING_RATE_CRITERIA_KEY,dataM.baseBuildingManager.db.getGoldMineMiningRate(param2),dataM.baseBuildingManager.db.getGoldMineMiningRate(_loc3_)),this.getNumericUpgradeDescriptionString(MINING_CAPACITY_CRITERIA_KEY,dataM.baseBuildingManager.db.getGoldMineCapacity(param2),dataM.baseBuildingManager.db.getGoldMineCapacity(_loc3_))];
            case BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY:
               _loc5_ = this.highlightStr(languageM.getText(dataM.baseBuildingManager.db.getItemFactoryLevelTitle(_loc3_)));
               return [this.getDescriptionString(NEW_CRAFTING_TYPE_CRITERIA_KEY,_loc5_)];
            default:
               return null;
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
         super.notifyClientDataReloaded();
         this.removeMe();
      }
   }
}

