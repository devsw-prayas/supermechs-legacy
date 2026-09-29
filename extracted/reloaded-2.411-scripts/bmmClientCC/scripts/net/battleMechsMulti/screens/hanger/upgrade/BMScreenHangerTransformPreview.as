package net.battleMechsMulti.screens.hanger.upgrade
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.itemProperties.BMItemPropertiesPanel;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1294")]
   public class BMScreenHangerTransformPreview extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcItemPreviewProperyHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
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
         x = (dataM.STAGE_WIDTH - width) / 2;
         y = (dataM.STAGE_HEIGHT - height) / 2;
         screensM.createButtonFromSizer("screenHangerTransformPreview","btnBack","pictureE");
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,dataM.runAsMobile);
         var _loc3_:BMItemData = dataM.itemsDB[param1];
         var _loc4_:BMItemData = dataM.itemsDB[param2];
         this.txtTitle.text = _loc4_.fullName;
         this.txtOldStat.htmlText = "<FONT COLOR=\'#" + dataM.getItemTierColor(_loc3_.specialStatus) + "\'>Level " + _loc3_.displayLevel + " " + dataM.getItemTierName(_loc3_.specialStatus);
         this.txtNewStat.htmlText = "<FONT COLOR=\'#" + dataM.getItemTierColor(_loc4_.specialStatus) + "\'>Level " + _loc4_.displayLevel + " " + dataM.getItemTierName(_loc4_.specialStatus);
         var _loc5_:BMItemPropertiesPanel = new BMItemPropertiesPanel();
         _loc5_.propertiesPerLine = 1;
         _loc5_.propetyViewCls = BMTransformItemPreviewProperty;
         _loc5_.showDifference(_loc3_,_loc4_,false);
         this.mcItemPreviewProperyHolder.addChild(_loc5_);
      }
      
      private function backClicked() : void
      {
         screensM.removeScreen("screenHangerTransformPreview");
      }
   }
}

