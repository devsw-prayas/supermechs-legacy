package net.battleMechsMulti.mobiles.itemProperties
{
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   public class BMItemInfoPanel extends BMBaseClass
   {
      
      public var propertiesPanel:BMItemPropertiesPanel;
      
      public var txtItemName:TextField;
      
      public var txtPowerLevel:TextField;
      
      private var _playerItemID:Number;
      
      public function BMItemInfoPanel()
      {
         super();
         generateSingletonClassesPointers("");
         this.propertiesPanel.propetyViewCls = BMWorkshopItemProperty;
      }
      
      public function showItemInfo(param1:BMPlayerItemData) : void
      {
         this._playerItemID = param1.playerItemID;
         var _loc2_:BMItemData = dataM.itemsDB[param1.itemID];
         var _loc3_:uint = uint("0x" + dataM.getItemTierColor(_loc2_.specialStatus));
         this.txtItemName.textColor = _loc3_;
         this.itemName = _loc2_.fullName;
         this.itemPowerLevelTxt = "Power level: " + _loc2_.displayLevel + " (" + dataM.getNumberWithComma(param1.power) + " / " + dataM.getNumberWithComma(_loc2_.powerToUpgrade) + ")";
         this.propertiesPanel.propertiesPerLine = _loc2_.type == "shield" ? 1 : 2;
         this.propertiesPanel.show(_loc2_);
      }
      
      public function set itemName(param1:String) : void
      {
         this.txtItemName.text = param1;
         ImageUtils.swapTextFieldWithBitMap(this.txtItemName,this);
      }
      
      public function set itemPowerLevelTxt(param1:String) : void
      {
         this.txtPowerLevel.text = param1;
         ImageUtils.swapTextFieldWithBitMap(this.txtPowerLevel,this);
      }
      
      public function get playerItemID() : Number
      {
         return this._playerItemID;
      }
   }
}

