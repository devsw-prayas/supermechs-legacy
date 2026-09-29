package net.battleMechsMulti.screens.popups
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2155")]
   public class BMScreenEquipBetterItemRecommendation extends BMScreenYesNoPopup
   {
      
      public var mcSizer_lesserItem:Sprite;
      
      public var mcSizer_betterItem:Sprite;
      
      public var txtBetterItemName:TextField;
      
      public var txtLesserItemName:TextField;
      
      public var mcItemsHolder:Sprite;
      
      public var mcEffectsHolder:Sprite;
      
      public var mcArrow:Sprite;
      
      private var mcLesserItem:BMTileListItem;
      
      private var mcBetterItem:BMTileListItem;
      
      private var _betterItemPlayerItemData:BMPlayerItemData;
      
      private var _lesserItemPlayerItemData:BMPlayerItemData;
      
      private var _equipFunction:Function;
      
      private var _equipmentSlot:String;
      
      public function BMScreenEquipBetterItemRecommendation()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function displayRecommendation(param1:Function, param2:BMPlayerItemData, param3:String, param4:BMPlayerItemData = null) : void
      {
         var _loc14_:BMItemData = null;
         var _loc15_:String = null;
         var _loc16_:Number = NaN;
         this._betterItemPlayerItemData = param2;
         this._lesserItemPlayerItemData = param4;
         var _loc5_:String = BMLanguageManager.getInstance().getText("equipmentRecommendation_title");
         var _loc6_:BMItemData = BMDataManager.getInstance().itemsDB[param2.itemID];
         var _loc7_:String = "";
         var _loc8_:String = "";
         if(param4 != null)
         {
            _loc14_ = BMDataManager.getInstance().itemsDB[param4.itemID];
            _loc15_ = this.getRarityTextWithColor(_loc14_.specialStatus) + languageM.getItemNameByItemData(_loc14_);
            updateTextAndFormat(this.txtLesserItemName,_loc15_);
         }
         else
         {
            _loc16_ = (this.mcSizer_betterItem.x - this.mcSizer_lesserItem.x) / 2;
            this.txtLesserItemName.text = BMLanguageManager.getInstance().getText("equipmentRecommendation_empty");
         }
         var _loc9_:String = this.getRarityTextWithColor(_loc6_.specialStatus) + languageM.getItemNameByItemData(_loc6_);
         updateTextAndFormat(this.txtBetterItemName,_loc9_);
         var _loc10_:String = BMLanguageManager.getInstance().getText("equipmentRecommendation_equip");
         var _loc11_:String = BMLanguageManager.getInstance().getText("equipmentRecommendation_noThanks");
         this._equipFunction = param1;
         this._equipmentSlot = param3;
         var _loc12_:Function = param1;
         var _loc13_:Function = BMDataManager.getInstance().mechEquipmentRecommander.checkRecommendationForNextItem;
         displayYesNoPopup(_loc5_,_loc7_,_loc8_,_loc12_,_loc13_,_loc10_,_loc11_);
         this.showItems();
      }
      
      private function showItems() : void
      {
         var _loc4_:Sprite = null;
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         this.mcBetterItem = _loc1_.createShopTileListItem_basedOnItemID(this._betterItemPlayerItemData.itemID,"reward",null,null,null,null,null,true);
         this.mcBetterItem.width = this.mcSizer_betterItem.width;
         this.mcBetterItem.height = this.mcSizer_betterItem.height;
         this.mcBetterItem.removeAllListeners();
         this.mcBetterItem.x = this.mcSizer_betterItem.x;
         this.mcBetterItem.y = this.mcSizer_betterItem.y;
         var _loc2_:Number = this.mcSizer_betterItem.height;
         var _loc3_:MovieClip = BMExternalAssetsManager.getInstance().getAsset("general","icon_itemNew",_loc2_,_loc2_);
         this.mcBetterItem.item.addOverItemGrp1(_loc3_);
         this.mcItemsHolder.addChild(this.mcBetterItem);
         if(this._lesserItemPlayerItemData == null)
         {
            _loc4_ = BMExternalAssetsManager.getInstance().getAsset("general","icon_tier_empty0",_loc2_,_loc2_);
            _loc4_.x = this.mcSizer_lesserItem.x;
            _loc4_.y = this.mcSizer_lesserItem.y;
            this.mcItemsHolder.addChild(_loc4_);
            return;
         }
         this.mcLesserItem = _loc1_.createShopTileListItem_basedOnItemID(this._lesserItemPlayerItemData.itemID,"reward",null,null,null,null,null,true);
         this.mcLesserItem.width = this.mcSizer_lesserItem.width;
         this.mcLesserItem.height = this.mcSizer_lesserItem.height;
         this.mcLesserItem.removeAllListeners();
         this.mcLesserItem.x = this.mcSizer_lesserItem.x;
         this.mcLesserItem.y = this.mcSizer_lesserItem.y;
         this.mcItemsHolder.addChild(this.mcLesserItem);
      }
      
      private function getRarityTextWithColor(param1:uint, param2:Boolean = true) : String
      {
         var _loc3_:String = "";
         switch(param1)
         {
            case ItemRarityResolver.RARITY_COMMON:
               _loc3_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_COMMON_ITEM + "\'>" + BMLanguageManager.getInstance().getText("general_common") + "</FONT>";
               break;
            case ItemRarityResolver.RARITY_RARE:
               _loc3_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_RARE_ITEM + "\'>" + BMLanguageManager.getInstance().getText("general_rare") + "</FONT>";
               break;
            case ItemRarityResolver.RARITY_EPIC:
               _loc3_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_EPIC_ITEM + "\'>" + BMLanguageManager.getInstance().getText("general_epic") + "</FONT>";
               break;
            case ItemRarityResolver.RARITY_LEGENDARY:
               _loc3_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + BMLanguageManager.getInstance().getText("general_legendary") + "</FONT>";
               break;
            case ItemRarityResolver.RARITY_MYTHICAL:
               _loc3_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_MYTHICAL_ITEM + "\'>" + BMLanguageManager.getInstance().getText("general_mythical") + "</FONT>";
         }
         if(_loc3_ != "" && param2)
         {
            _loc3_ += "<BR>";
         }
         return _loc3_;
      }
      
      override public function removeMe() : void
      {
         screensM.removeScreen("screenEquipBetterItemRecommendation");
      }
      
      override protected function runYesFunction() : void
      {
         var _loc1_:uint = BMMechStructure.extractEquipmentIDFromEquipmentSlot(this._equipmentSlot);
         this._equipFunction(this._betterItemPlayerItemData.playerItemID,_loc1_);
      }
   }
}

