package net.battleMechsMulti.screens.hanger.upgrade
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenHangerUpgradeMassSelection extends BMBaseScreen
   {
      
      public var txtRarityTitle:TextField;
      
      public var txtDamageTypeTitle:TextField;
      
      public var txtItemTypeTitle:TextField;
      
      public var btnRarity0:BMBasicSelectable;
      
      public var btnRarity1:BMBasicSelectable;
      
      public var btnRarity2:BMBasicSelectable;
      
      public var btnDamageType1:BMBasicSelectable;
      
      public var btnDamageType2:BMBasicSelectable;
      
      public var btnDamageType3:BMBasicSelectable;
      
      public var btnType0:BMBasicSelectable;
      
      public var btnType1:BMBasicSelectable;
      
      public var btnType2:BMBasicSelectable;
      
      public var btnType3:BMBasicSelectable;
      
      public var btnType4:BMBasicSelectable;
      
      public var btnType5:BMBasicSelectable;
      
      public var btnType6:BMBasicSelectable;
      
      public var btnSelectAllItemTypes:BMBasicButton;
      
      public var btnDeselectAllItemTypes:BMBasicButton;
      
      public function BMScreenHangerUpgradeMassSelection()
      {
         super();
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("massSelect");
      }
      
      public function initialize() : void
      {
         this.initTexts();
         this.initRarityButtons();
         this.initDamageTypeButtons();
         this.initItemTypeButtons();
      }
      
      public function moveMe(param1:Number, param2:Number) : void
      {
         x = param1;
         y = param2;
      }
      
      private function initTexts() : void
      {
         updateTextAndFormat(this.txtRarityTitle,getScreenText("rarity"));
         updateTextAndFormat(this.txtDamageTypeTitle,getScreenText("element"));
         updateTextAndFormat(this.txtItemTypeTitle,getScreenText("itemType"));
      }
      
      private function initRarityButtons() : void
      {
         var _loc2_:BMBasicSelectable = null;
         var _loc1_:uint = 0;
         while(_loc1_ <= 2)
         {
            _loc2_ = this["btnRarity" + _loc1_];
            _loc2_.addEventListener(BMIntractable.HIT,this.onRarityClicked);
            _loc2_.id = String(_loc1_);
            this.refreshRarityButtonSelectionStatus(_loc1_);
            switch(_loc1_)
            {
               case 0:
                  _loc2_.text_withHTMLColoringForMobile = getGeneralText("common");
                  break;
               case 1:
                  _loc2_.text_withHTMLColoringForMobile = "<FONT COLOR=\'#0099FF\'>" + getGeneralText("rare");
                  break;
               case 2:
                  _loc2_.text_withHTMLColoringForMobile = "<FONT COLOR=\'#9C3399\'>" + getGeneralText("epic");
            }
            _loc1_++;
         }
      }
      
      private function onRarityClicked(param1:Event) : void
      {
         var _loc2_:uint = uint(int(param1.target.id));
         if(this.massSelectionData.getRarity(_loc2_))
         {
            this.massSelectionData.removeRarity(_loc2_);
         }
         else
         {
            this.massSelectionData.addRarity(_loc2_);
         }
         this.refreshRarityButtonSelectionStatus(_loc2_);
      }
      
      private function refreshRarityButtonSelectionStatus(param1:uint) : void
      {
         var _loc2_:BMBasicSelectable = this["btnRarity" + param1];
         if(this.massSelectionData.getRarity(param1))
         {
            _loc2_.selected = true;
         }
         else
         {
            _loc2_.selected = false;
         }
      }
      
      private function initDamageTypeButtons() : void
      {
         var _loc2_:BMBasicSelectable = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= 3)
         {
            _loc2_ = this["btnDamageType" + _loc1_];
            _loc2_.addEventListener(BMIntractable.HIT,this.onDamageTypeClicked);
            _loc2_.id = String(_loc1_);
            this.refreshDamageTypeButtonSelectionStatus(_loc1_);
            switch(_loc1_)
            {
               case 1:
                  _loc2_.text_withHTMLColoringForMobile = "<FONT COLOR=\'#FFCC00\'>" + getScreenText("physical");
                  break;
               case 2:
                  _loc2_.text_withHTMLColoringForMobile = "<FONT COLOR=\'#FF3300\'>" + getScreenText("explosive");
                  break;
               case 3:
                  _loc2_.text_withHTMLColoringForMobile = "<FONT COLOR=\'#0099FF\'>" + getScreenText("electric");
            }
            _loc1_++;
         }
      }
      
      private function onDamageTypeClicked(param1:Event) : void
      {
         var _loc2_:uint = uint(int(param1.target.id));
         if(this.massSelectionData.getDamageType(_loc2_))
         {
            this.massSelectionData.removeDamageType(_loc2_);
         }
         else
         {
            this.massSelectionData.addDamageType(_loc2_);
         }
         this.refreshDamageTypeButtonSelectionStatus(_loc2_);
      }
      
      private function refreshDamageTypeButtonSelectionStatus(param1:uint) : void
      {
         var _loc2_:BMBasicSelectable = this["btnDamageType" + param1];
         if(this.massSelectionData.getDamageType(param1))
         {
            _loc2_.selected = true;
         }
         else
         {
            _loc2_.selected = false;
         }
      }
      
      private function initItemTypeButtons() : void
      {
         var _loc2_:String = null;
         var _loc3_:BMBasicSelectable = null;
         var _loc4_:String = null;
         var _loc1_:uint = 0;
         while(_loc1_ < BMMassSelectionData.ITEM_TYPES.length)
         {
            _loc2_ = BMMassSelectionData.ITEM_TYPES[_loc1_];
            _loc3_ = this["btnType" + _loc1_];
            _loc4_ = this.getIconNameForItemType(_loc2_);
            _loc3_.content = externalAssetsM.getAsset("general",_loc4_);
            _loc3_.addEventListener(BMIntractable.HIT,this.onItemTypeClicked);
            _loc3_.id = String(_loc1_);
            this.refreshItemTypeButtonSelectionStatus(_loc1_);
            _loc1_++;
         }
         this.btnSelectAllItemTypes.addEventListener(BMIntractable.HIT,this.selectAllItemTypesClicked);
         this.btnDeselectAllItemTypes.addEventListener(BMIntractable.HIT,this.deselectAllItemTypesClicked);
      }
      
      private function selectAllItemTypesClicked(param1:Event) : void
      {
         this.massSelectionData.selectAllItemTypes();
         this.refreshAllItemTypeButtonsSelectionStatus();
      }
      
      private function deselectAllItemTypesClicked(param1:Event) : void
      {
         this.massSelectionData.deselectAllItemTypes();
         this.refreshAllItemTypeButtonsSelectionStatus();
      }
      
      private function onItemTypeClicked(param1:Event) : void
      {
         var _loc2_:uint = uint(int(param1.target.id));
         if(this.massSelectionData.getItemTypeByTypeSlot(_loc2_))
         {
            this.massSelectionData.removeItemType(_loc2_);
         }
         else
         {
            this.massSelectionData.addItemType(_loc2_);
         }
         this.refreshItemTypeButtonSelectionStatus(_loc2_);
      }
      
      private function refreshItemTypeButtonSelectionStatus(param1:uint) : void
      {
         var _loc2_:BMBasicSelectable = this["btnType" + param1];
         if(this.massSelectionData.getItemTypeByTypeSlot(param1))
         {
            _loc2_.selected = true;
         }
         else
         {
            _loc2_.selected = false;
         }
      }
      
      private function refreshAllItemTypeButtonsSelectionStatus() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < BMMassSelectionData.ITEM_TYPES.length)
         {
            this.refreshItemTypeButtonSelectionStatus(_loc1_);
            _loc1_++;
         }
      }
      
      public function refreshAllState() : *
      {
         this.refreshAllItemTypeButtonsSelectionStatus();
         var _loc1_:int = 0;
         while(_loc1_ <= 2)
         {
            this.refreshRarityButtonSelectionStatus(_loc1_);
            _loc1_++;
         }
         var _loc2_:int = 1;
         while(_loc2_ <= 3)
         {
            this.refreshDamageTypeButtonSelectionStatus(_loc2_);
            _loc2_++;
         }
      }
      
      private function getIconNameForItemType(param1:String) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case BMMechStructure.TORSO:
               _loc2_ = "subType_inventory_torso";
               break;
            case BMMechStructure.LEG:
               _loc2_ = "subType_inventory_leg";
               break;
            case BMMechStructure.SIDE_WEAPON:
               _loc2_ = "subType_inventory_sideWeapon";
               break;
            case BMMechStructure.TOP_WEAPON:
               _loc2_ = "subType_inventory_topWeapon";
               break;
            case BMMechStructure.SPECIAL:
               _loc2_ = "subType_inventory_special";
               break;
            case BMMechStructure.MODULE:
               _loc2_ = "subType_inventory_module";
               break;
            case BMMechStructure.KIT:
               _loc2_ = "subType_inventory_kit";
         }
         return _loc2_;
      }
      
      private function get massSelectionData() : BMMassSelectionData
      {
         return screensM.screenHangerUpgrade.massSelectionData;
      }
   }
}

