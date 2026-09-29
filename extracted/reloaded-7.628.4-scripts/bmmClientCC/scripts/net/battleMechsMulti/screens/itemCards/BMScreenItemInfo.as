package net.battleMechsMulti.screens.itemCards
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemPropertiesPanel;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1289")]
   public class BMScreenItemInfo extends BMBaseScreen
   {
      
      public var mcPropertiesHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var mcBackground:MovieClip;
      
      public function BMScreenItemInfo()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function showItemInfo(param1:uint) : void
      {
         var _loc2_:BMItemData = dataM.itemsDB[param1];
         updateTextAndFormat(this.txtTitle,getSpecificText("missionBaseMap_stats"));
         var _loc3_:BMItemPropertiesPanel = new BMItemPropertiesPanel();
         _loc3_.propertiesPerLine = 1;
         _loc3_.propetyViewCls = BMWorkshopItemProperty;
         _loc3_.show(_loc2_);
         this.mcPropertiesHolder.addChild(_loc3_);
         var _loc4_:uint = _loc2_.specialStatus + 1;
         if(_loc4_ > 5)
         {
            _loc4_ = 1;
         }
         this.mcBackground.gotoAndStop(_loc4_);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
      }
   }
}

