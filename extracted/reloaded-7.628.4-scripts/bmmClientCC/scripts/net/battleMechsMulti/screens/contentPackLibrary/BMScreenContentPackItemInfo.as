package net.battleMechsMulti.screens.contentPackLibrary
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemPropertiesPanel;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenContentPackItemInfo extends BMBaseScreen
   {
      
      public var mcPropertiesHolder:Sprite;
      
      public var closeBtn:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var mcItemSizer:Sprite;
      
      public var mcTransformRangeHolder:MovieClip;
      
      public var txtFragmentsRequired:TextField;
      
      private var item:BMTileListItem;
      
      public function BMScreenContentPackItemInfo()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function showItemInfo(param1:uint, param2:Boolean, param3:String = "") : void
      {
         var _loc4_:BMItemData = null;
         var _loc5_:Number = NaN;
         var _loc6_:BMItemPropertiesPanel = null;
         this.closeBtn.addEventListener(BMIntractable.HIT,this.backClicked);
         _loc4_ = dataM.itemsDB[param1];
         this.txtTitle.text = languageM.getItemNameByItemData(_loc4_);
         if(_loc4_.isAscensionKit == false && _loc4_.isTransformKit == false)
         {
            _loc6_ = new BMItemPropertiesPanel();
            _loc6_.propertiesPerLine = 1;
            _loc6_.propetyViewCls = BMWorkshopItemProperty;
            _loc6_.show(_loc4_);
            this.mcPropertiesHolder.addChild(_loc6_);
         }
         _loc5_ = this.mcItemSizer.width;
         this.item = dataM.createItemTileListItem(param1,_loc5_,0,param2);
         this.item.x = this.mcItemSizer.x;
         this.item.y = this.mcItemSizer.y;
         this.item.width = _loc5_;
         this.item.height = _loc5_;
         addChild(this.item);
         dataM.showItemTransformRange(_loc4_,this.mcTransformRangeHolder);
         this.mcTransformRangeHolder.x = this.mcItemSizer.x + (this.mcItemSizer.width - this.mcTransformRangeHolder.width) / 2;
         updateTextAndFormat(this.txtFragmentsRequired,param3);
      }
      
      private function backClicked(param1:Event) : void
      {
         this.removeMe();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         if(this.item != null)
         {
            this.item.removeMe();
            this.item = null;
         }
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
      }
   }
}

