package net.battleMechsMulti.screens.baseBuilding
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemList.BMHorizontalItemsScroller;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenBaseBuildingItemFactory extends BMBaseScreen
   {
      
      public var btnClose:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var mcTutorialArrow:Sprite;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _itemFactoryItemTypesData:Array;
      
      private var _itemTypes:Array = new Array();
      
      public var itemsScroller:BMHorizontalItemsScroller;
      
      public function BMScreenBaseBuildingItemFactory()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClicked);
         updateTextAndFormat(this.txtTitle,languageM.getText("baseBuilding_structureItemFactory"));
      }
      
      public function refreshScreen(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BMItemFactoryItemType = null;
         if(this.itemsScroller.isInitiated())
         {
            if(param1.length == this._itemFactoryItemTypesData.length)
            {
               this._itemFactoryItemTypesData = param1;
               _loc2_ = 0;
               while(_loc2_ < this._itemFactoryItemTypesData.length)
               {
                  _loc3_ = BMItemFactoryItemType(this.itemsScroller.getItemView(this._itemFactoryItemTypesData[_loc2_].level));
                  _loc3_.setData(this._itemFactoryItemTypesData[_loc2_]);
                  _loc2_++;
               }
            }
            else
            {
               this.removeMe();
            }
            return;
         }
         this._itemFactoryItemTypesData = param1;
         this.itemsScroller.visible = true;
         this.itemsScroller.setViewClassFunction(this.scrollerViewClassResolver);
         if(dataM.runAsMobile)
         {
            this.itemsScroller.activateScrolling(BMHorizontalItemsScroller.NAVIGATION_TYPE_FINGER_SCROLLING);
         }
         else
         {
            this.itemsScroller.activateScrolling(BMHorizontalItemsScroller.NAVIGATION_TYPE_BUTTONS);
         }
         this.itemsScroller.setItemSelectedFunction(this.itemSelected);
         this.itemsScroller.setItems(this._itemFactoryItemTypesData,this.getScrollerTargetItemSlot());
      }
      
      private function getScrollerTargetItemSlot() : uint
      {
         var _loc3_:BMItemFactoryItemTypeData = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._itemFactoryItemTypesData.length)
         {
            _loc3_ = this._itemFactoryItemTypesData[_loc2_];
            if(_loc3_.endBuildTime > dataM.currentTime)
            {
               _loc1_ = _loc2_ - 1;
               break;
            }
            if(_loc3_.locked == false)
            {
               _loc1_ = _loc2_ - 1;
            }
            _loc2_++;
         }
         return Math.max(0,_loc1_);
      }
      
      private function scrollerViewClassResolver(param1:Object) : Class
      {
         var _loc2_:BMItemFactoryItemTypeData = param1 as BMItemFactoryItemTypeData;
         if(_loc2_.level == 20)
         {
            return BMItemFactoryItemTypeWithSeparator;
         }
         return BMItemFactoryItemType;
      }
      
      private function itemSelected(param1:uint) : void
      {
         var _loc2_:BMItemFactoryItemType = BMItemFactoryItemType(this.itemsScroller.getItemView(param1));
         _loc2_.handleMouseClick(new Point(mouseX,mouseY));
      }
      
      private function onCloseClicked(param1:Event) : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BASE_BUILDING_ITEM_FACTORY);
      }
      
      public function hideTutorialArrow() : void
      {
         this._tutorialArrowController.deactivateTutorialArrow();
      }
      
      private function activateTutorialArrow(param1:MovieClip, param2:MovieClip, param3:int = 0, param4:int = 0) : *
      {
         tutorialM.onlyClickableMovieClip = null;
         this._tutorialArrowController.deactivateTutorialArrow();
         var _loc5_:Number = param3 == 0 ? param1.width : param1.width / 2;
         var _loc6_:Number = param3 == 0 ? param1.height / 2 : 0;
         var _loc7_:Number = param1.x + _loc5_;
         var _loc8_:Number = param1.y + _loc6_;
         this._tutorialArrowController.activateTutorialArrowWithTimer(param2,_loc7_,_loc8_,param3,param4);
         tutorialM.onlyClickableMovieClip = param1;
      }
      
      public function showTutorialArrowOnFirstItemBuildButton() : void
      {
         if(this._tutorialArrowController == null)
         {
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow);
         }
         var _loc1_:BMItemFactoryItemType = BMItemFactoryItemType(this.itemsScroller.getItemView(1));
         this.itemsScroller.bringItemToFront(1);
         this.activateTutorialArrow(_loc1_.btnBuild,_loc1_,0,10);
      }
      
      public function showTutorialArrowOnFirstItemAddButton() : void
      {
         var _loc1_:BMItemFactoryItemType = BMItemFactoryItemType(this.itemsScroller.getItemView(1));
         this.itemsScroller.bringItemToFront(1);
         this.activateTutorialArrow(_loc1_.btnPlus,_loc1_,-90,10);
      }
      
      public function showTutorialArrowOnFirstItemSkipButton() : void
      {
         var _loc1_:BMItemFactoryItemType = BMItemFactoryItemType(this.itemsScroller.getItemView(1));
         this.itemsScroller.bringItemToFront(1);
         this.activateTutorialArrow(_loc1_.btnSkip,_loc1_,0,10);
      }
      
      override public function notifyClientDataReloaded() : *
      {
         super.notifyClientDataReloaded();
         this.removeMe();
      }
   }
}

