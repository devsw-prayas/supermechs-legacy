package net.battleMechsMulti.screens.baseBuilding
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingDB;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenBaseBuildingStructuresMenu extends BMBaseScreen
   {
      
      public var btnBuildGoldMine:BMBasicButton;
      
      public var btnBuildItemFactory:BMBasicButton;
      
      public var btnGoldMineLocked:BMBasicButton;
      
      public var btnItemFactoryLocked:BMBasicButton;
      
      public var btnClose:BMBasicButton;
      
      public var mcTutorialArrow:Sprite;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      public var txtTitle:TextField;
      
      public var txtGoldMineAllBuilt:TextField;
      
      public var txtGoldMineTitle:TextField;
      
      public var txtItemFactoryAllBuilt:TextField;
      
      public var txtItemsFactoryTitle:TextField;
      
      public function BMScreenBaseBuildingStructuresMenu()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         this.btnBuildGoldMine.addEventListener(BMIntractable.HIT,this.onBuildGoldMineClicked);
         this.btnBuildItemFactory.addEventListener(BMIntractable.HIT,this.onBuildItemFactoryClicked);
         this.btnGoldMineLocked.addEventListener(BMIntractable.HIT,this.onGoldMineLockedClicked);
         this.btnItemFactoryLocked.addEventListener(BMIntractable.HIT,this.onItemFactoryLockedClicked);
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClicked);
         updateTextAndFormat(this.txtTitle,languageM.getText("baseBuilding_buildStructure"));
         updateTextAndFormat(this.txtGoldMineTitle,dataM.baseBuildingManager.getStructureName(BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE));
         updateTextAndFormat(this.txtItemsFactoryTitle,dataM.baseBuildingManager.getStructureName(BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY));
      }
      
      public function refreshScreen(param1:Array, param2:int, param3:int) : void
      {
         var _loc4_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         _loc4_ = param1.indexOf(BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE) > -1;
         var _loc5_:Boolean = param1.indexOf(BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY) > -1;
         this.txtGoldMineAllBuilt.text = "";
         this.txtItemFactoryAllBuilt.text = "";
         this.btnBuildGoldMine.visible = false;
         this.btnBuildItemFactory.visible = false;
         this.btnGoldMineLocked.visible = false;
         this.btnItemFactoryLocked.visible = false;
         if(_loc4_)
         {
            _loc6_ = dataM.baseBuildingManager.db.getGoldRequiredToUpgradeStructure(BMBaseBuildingDB.STRUCTURE_TYPE_GOLD_MINE,0);
            this.btnBuildGoldMine.text = _loc6_.toString();
            this.btnBuildGoldMine.visible = true;
         }
         else if(param2 > -1)
         {
            this.btnGoldMineLocked.visible = true;
            _loc7_ = languageM.getText("baseBuilding_hqLevelRequirement");
            _loc7_ = dataM.replaceStringInText(_loc7_,"%LEVEL%",param2.toString());
            this.btnGoldMineLocked.text = _loc7_;
         }
         else
         {
            updateTextAndFormat(this.txtGoldMineAllBuilt,languageM.getText("baseBuilding_allLevelsBuilt"));
         }
         if(_loc5_)
         {
            _loc8_ = dataM.baseBuildingManager.db.getGoldRequiredToUpgradeStructure(BMBaseBuildingDB.STRUCTURE_TYPE_ITEM_FACTORY,0);
            this.btnBuildItemFactory.text = _loc8_.toString();
            this.btnBuildItemFactory.visible = true;
         }
         else if(param3 > -1)
         {
            this.btnItemFactoryLocked.visible = true;
            _loc9_ = languageM.getText("baseBuilding_hqLevelRequirement");
            _loc9_ = dataM.replaceStringInText(_loc9_,"%LEVEL%",param3.toString());
            this.btnItemFactoryLocked.text = _loc9_;
         }
         else
         {
            updateTextAndFormat(this.txtItemFactoryAllBuilt,languageM.getText("baseBuilding_allLevelsBuilt"));
         }
      }
      
      private function onBuildGoldMineClicked(param1:Event) : void
      {
         screensM.screenBaseBuildingMain.buildGoldMine();
         this.removeMe();
      }
      
      private function onBuildItemFactoryClicked(param1:Event) : void
      {
         screensM.screenBaseBuildingMain.buildItemFactory();
         this.removeMe();
      }
      
      private function onGoldMineLockedClicked(param1:Event) : void
      {
         screensM.screenBaseBuildingMain.openHQUpgrade();
         this.removeMe();
      }
      
      private function onItemFactoryLockedClicked(param1:Event) : void
      {
         screensM.screenBaseBuildingMain.openHQUpgrade();
         this.removeMe();
      }
      
      private function onCloseClicked(param1:Event) : void
      {
         screensM.screenBaseBuildingMain.buildStructureCanceled();
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BASE_BUILDING_STRUCTURES_MENU);
      }
      
      public function showTutorialArrowOnItemFactory() : *
      {
         if(this._tutorialArrowController == null)
         {
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow);
         }
         var _loc1_:Number = this.btnBuildItemFactory.x + this.btnBuildItemFactory.width;
         var _loc2_:Number = this.btnBuildItemFactory.y + this.btnBuildItemFactory.height / 2;
         this._tutorialArrowController.activateTutorialArrowWithTimer(this,_loc1_,_loc2_,0,10);
         tutorialM.onlyClickableMovieClip = this.btnBuildItemFactory;
      }
      
      override public function notifyClientDataReloaded() : *
      {
         super.notifyClientDataReloaded();
         this.removeMe();
      }
   }
}

