package net.battleMechsMulti.screens.hanger.upgrade
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemPropertiesPanel;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2907")]
   public class BMScreenHangerTransformPreview extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcItemPreviewProperyHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var closeBtn:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var txtOldStat:TextField;
      
      public var txtNewStat:TextField;
      
      public function BMScreenHangerTransformPreview()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
      }
      
      public function refreshScreen(param1:uint, param2:uint) : void
      {
         var _loc5_:String = null;
         this.closeBtn.addEventListener(BMIntractable.HIT,this.backClicked);
         var _loc3_:BMItemData = dataM.itemsDB[param1];
         var _loc4_:BMItemData = dataM.itemsDB[param2];
         updateTextAndFormat(this.txtTitle,languageM.getItemNameByItemData(_loc4_));
         updateTextAndFormat(this.txtOldStat,"<FONT COLOR=\'#" + ItemRarityResolver.getItemTierColor(_loc3_.specialStatus) + "\'>" + getGeneralText("level") + " " + _loc3_.displayLevel + " " + ItemRarityResolver.getItemTierName(_loc3_.specialStatus));
         if(_loc4_.specialStatus == ItemRarityResolver.RARITY_ASCENDED)
         {
            _loc5_ = "<FONT COLOR=\'#" + ItemRarityResolver.getItemTierColor(_loc4_.specialStatus) + "\'>" + ItemRarityResolver.getItemTierName(_loc4_.specialStatus);
         }
         else
         {
            _loc5_ = "<FONT COLOR=\'#" + ItemRarityResolver.getItemTierColor(_loc4_.specialStatus) + "\'>" + getGeneralText("level") + " " + _loc4_.displayLevel + " " + ItemRarityResolver.getItemTierName(_loc4_.specialStatus);
         }
         updateTextAndFormat(this.txtNewStat,_loc5_);
         var _loc6_:BMItemPropertiesPanel = new BMItemPropertiesPanel();
         _loc6_.propertiesPerLine = 1;
         _loc6_.propetyViewCls = BMTransformItemPreviewProperty;
         _loc6_.showDifference(_loc3_,_loc4_,false);
         this.mcItemPreviewProperyHolder.addChild(_loc6_);
      }
      
      private function backClicked(param1:Event) : void
      {
         screensM.removeScreen(BMScreensManager.SCR_HANGER_TRANSFORM_PREVIEW);
      }
   }
}

