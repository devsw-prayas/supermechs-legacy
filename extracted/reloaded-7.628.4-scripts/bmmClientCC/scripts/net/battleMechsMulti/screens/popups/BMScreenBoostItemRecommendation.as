package net.battleMechsMulti.screens.popups
{
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2197")]
   public class BMScreenBoostItemRecommendation extends BMScreenYesNoPopup
   {
      
      public var mcSizer_item:Sprite;
      
      public var mcItemsHolder:Sprite;
      
      public var mcEffectsHolder:Sprite;
      
      private var mcItem:BMTileListItem;
      
      private var _itemPlayerItemData:BMPlayerItemData;
      
      private var _boostFunction:Function;
      
      public function BMScreenBoostItemRecommendation()
      {
         super();
      }
      
      public function displayRecommendation(param1:Function, param2:BMPlayerItemData) : void
      {
         this._itemPlayerItemData = param2;
         var _loc3_:String = BMLanguageManager.getInstance().getText("boostRecommendation_title");
         var _loc4_:BMItemData = BMDataManager.getInstance().itemsDB[this._itemPlayerItemData.itemID];
         var _loc5_:String = BMLanguageManager.getInstance().getText("boostRecommendation_desc");
         var _loc6_:String = "";
         updateTextAndFormat(txtDesc1,_loc5_);
         var _loc7_:String = BMLanguageManager.getInstance().getText("boostRecommendation_boost");
         var _loc8_:String = BMLanguageManager.getInstance().getText("boostRecommendation_noThanks");
         this._boostFunction = param1;
         var _loc9_:Function = param1;
         var _loc10_:Function = null;
         displayYesNoPopup(_loc3_,_loc5_,_loc6_,_loc9_,_loc10_,_loc7_,_loc8_);
         this.showItem();
      }
      
      private function showItem() : void
      {
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         this.mcItem = _loc1_.createShopTileListItem_basedOnItemID(this._itemPlayerItemData.itemID,"reward",null,null,null,null,null,true);
         this.mcItem.width = this.mcSizer_item.width;
         this.mcItem.height = this.mcSizer_item.height;
         this.mcItem.removeAllListeners();
         this.mcItem.x = this.mcSizer_item.x;
         this.mcItem.y = this.mcSizer_item.y;
         this.mcItemsHolder.addChild(this.mcItem);
      }
      
      override public function removeMe() : void
      {
         screensM.removeScreen("screenBoostItemRecommendation");
      }
      
      override protected function runYesFunction() : void
      {
         this._boostFunction(this._itemPlayerItemData.playerItemID);
      }
   }
}

