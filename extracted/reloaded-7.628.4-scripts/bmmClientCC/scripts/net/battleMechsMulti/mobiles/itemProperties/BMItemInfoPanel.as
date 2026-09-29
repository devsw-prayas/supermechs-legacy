package net.battleMechsMulti.mobiles.itemProperties
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMItemInfoPanel extends BMBaseClass
   {
      
      public var propertiesPanel:BMItemPropertiesPanel;
      
      public var txtItemName:TextField;
      
      public var txtPowerLevel:TextField;
      
      public var txtTransform:TextField;
      
      public var itemTiersHolder:MovieClip;
      
      public var itemPropertiesPos:MovieClip;
      
      public var mechPropertiesPos:MovieClip;
      
      public var mcBackground:MovieClip;
      
      private var _playerItemID:Number;
      
      private var _tiersHolderXOffset:Number = 0;
      
      private var _originYPos:Number;
      
      public function BMItemInfoPanel()
      {
         super();
         generateSingletonClassesPointers("");
         this.propertiesPanel.propetyViewCls = BMWorkshopItemProperty;
         this._originYPos = y;
      }
      
      public function showItemInfo(param1:BMPlayerItemData) : void
      {
         var _loc4_:String = null;
         this._playerItemID = param1.playerItemID;
         var _loc2_:BMItemData = dataM.itemsDB[param1.itemID];
         var _loc3_:uint = uint("0x" + ItemRarityResolver.getItemTierColor(_loc2_.specialStatus));
         this.txtItemName.textColor = _loc3_;
         if(dataM.clientRunningLocally)
         {
            this.itemName = _loc2_.itemID + " " + languageM.getItemNameByItemData(_loc2_);
         }
         else
         {
            this.itemName = languageM.getItemNameByItemData(_loc2_);
         }
         if(_loc2_.isMaxEvolved)
         {
            this.itemPowerLevelTxt = getGeneralText("powerLevelMaxed");
         }
         else
         {
            _loc4_ = "";
            _loc4_ = getGeneralText("powerLevel");
            this.itemPowerLevelTxt = _loc4_ + ": " + _loc2_.displayLevel;
         }
         if(this.itemPropertiesPos != null)
         {
            this.propertiesPanel.y = this.itemPropertiesPos.y;
         }
         if(this.itemTiersHolder != null)
         {
            dataM.showItemTransformRange(_loc2_,this.itemTiersHolder);
            this.itemTiersHolder.x -= this._tiersHolderXOffset;
            switch(dataM.languageID)
            {
               case BMLanguageManager.LANGUAGE_RUSSIAN:
                  this._tiersHolderXOffset = 30;
                  break;
               default:
                  this._tiersHolderXOffset = 0;
            }
            this.itemTiersHolder.x += this._tiersHolderXOffset;
         }
         updateTextAndFormat(this.txtTransform,getGeneralText("transformRange") + ":");
         if(this.txtTransform != null)
         {
            this.txtTransform.visible = true;
         }
         this.propertiesPanel.propertiesPerLine = _loc2_.type == "shield" ? 1 : 2;
         this.propertiesPanel.show(_loc2_);
         this.setBackgroundAndPosition();
      }
      
      private function setBackgroundAndPosition() : void
      {
         if(this.mcBackground == null)
         {
            return;
         }
         y = this._originYPos;
         if(this.propertiesPanel.propertiesCount <= 10)
         {
            this.mcBackground.gotoAndStop("regular");
            return;
         }
         if(this.propertiesPanel.propertiesCount <= 12)
         {
            y -= 20;
            this.mcBackground.gotoAndStop("extra1");
            return;
         }
         y -= 40;
         this.mcBackground.gotoAndStop("extra2");
      }
      
      private function set itemName(param1:String) : void
      {
         updateTextAndFormat(this.txtItemName,param1);
         ImageUtils.swapTextFieldWithBitMap(this.txtItemName,this);
      }
      
      private function set itemPowerLevelTxt(param1:String) : void
      {
         updateTextAndFormat(this.txtPowerLevel,param1);
         ImageUtils.swapTextFieldWithBitMap(this.txtPowerLevel,this);
      }
      
      public function get playerItemID() : Number
      {
         return this._playerItemID;
      }
      
      public function showMech(param1:BMMechStructure) : *
      {
         this.txtItemName.textColor = uint("0xffffff");
         this.itemName = getSpecificText("workshop_mechSummary");
         this.itemPowerLevelTxt = "";
         if(this.itemTiersHolder != null)
         {
            this.itemTiersHolder.graphics.clear();
         }
         if(this.txtTransform != null)
         {
            this.txtTransform.visible = false;
         }
         if(this.mechPropertiesPos != null)
         {
            this.propertiesPanel.y = this.mechPropertiesPos.y;
         }
         this.propertiesPanel.propertiesPerLine = 2;
         this.propertiesPanel.showMech(param1);
      }
   }
}

