package net.battleMechsMulti.screens.buyStarterPack
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1399")]
   public class BMScreenBuyStarterPackItemAndTokens extends BMScreenBuyStarterPack
   {
      
      public var mcImagesHolder:Sprite;
      
      public var mcSizer_image:Sprite;
      
      public var mcSizer_item:Sprite;
      
      public var mcRays1:Sprite;
      
      public var mcRays2:Sprite;
      
      public var txtItemName:TextField;
      
      public var mcItemsPosition:Sprite;
      
      public var mcPlus:Sprite;
      
      private var _tokensImage:Sprite;
      
      private var _tileListItems:Array;
      
      public function BMScreenBuyStarterPackItemAndTokens()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyStarterPack");
         var _loc1_:String = getScreenText("title");
         updateTextAndFormat(txtTitle,_loc1_);
      }
      
      public function refreshScreen(param1:String) : void
      {
         refreshScreenSub(param1);
         this.addImage();
         this.addItems();
         switch(this.totalItems)
         {
            case 1:
               txtBonusTokens.y += 10;
               mcTokens_bonus.y += 10;
               break;
            case 2:
               this.mcPlus.x -= 16;
               this.mcRays1.visible = false;
               break;
            case 3:
               this.mcPlus.x -= 20;
               this.mcRays1.scaleX *= 0.8;
               this.mcRays1.scaleY *= 0.8;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         this.mcRays1.rotation += 0.4;
         this.mcRays2.rotation += 0.2;
      }
      
      private function addImage() : void
      {
         var _loc1_:Number = this.mcSizer_image.width;
         var _loc2_:String = "starterPack_tokens4";
         this._tokensImage = externalAssetsM.getAsset("general",_loc2_,_loc1_,_loc1_);
         this._tokensImage.x = this.mcSizer_image.x;
         this._tokensImage.y = this.mcSizer_image.y;
         this.mcImagesHolder.addChild(this._tokensImage);
      }
      
      private function addItems() : void
      {
         var _loc1_:String = null;
         var _loc3_:BMTileListItem = null;
         var _loc4_:int = 0;
         var _loc5_:BMItemData = null;
         var _loc6_:uint = 0;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         this.removeItems();
         _loc1_ = "";
         var _loc2_:uint = 0;
         while(_loc2_ < this.totalItems)
         {
            _loc3_ = new BMTileListItem();
            _loc4_ = int(dataM.myProfile.starterPackData.mechItemIDs[_loc2_]);
            _loc5_ = dataM.itemsDB[_loc4_];
            _loc6_ = 0;
            _loc7_ = false;
            _loc8_ = true;
            _loc3_ = dataM.createItemTileListItem(_loc4_,this.getItemSize(),_loc6_,_loc7_,this.itemClicked,null,null,_loc8_);
            _loc3_.x = this.getItemXPos();
            _loc3_.y = this.getItemYPos(_loc2_);
            this.mcImagesHolder.addChild(_loc3_);
            if(_loc1_ != "")
            {
               _loc1_ += "<BR>";
            }
            _loc1_ = _loc1_ + ItemRarityResolver.getItemTierName(_loc5_.specialStatus) + " " + languageM.getItemNameByItemData(_loc5_);
            this._tileListItems.push(_loc3_);
            _loc2_++;
         }
         if(this.totalItems == 1)
         {
            _loc1_ = "<BR>" + _loc1_;
         }
         else if(this.totalItems == 2)
         {
            this.txtItemName.y += 12;
         }
         updateTextAndFormat(this.txtItemName,_loc1_);
      }
      
      private function itemClicked(param1:uint, param2:uint) : void
      {
         screensM.addScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
         screensM.screenContentPackItemInfo.showItemInfo(param2,false);
      }
      
      private function getItemXPos() : Number
      {
         return this.mcItemsPosition.x - this.getItemSize() / 2;
      }
      
      private function getItemYPos(param1:uint) : Number
      {
         var _loc2_:Number = this.mcItemsPosition.y;
         switch(this.totalItems)
         {
            case 1:
               break;
            case 2:
               switch(param1)
               {
                  case 0:
                     _loc2_ -= this.getItemSize() / 2 + 10;
                     break;
                  case 1:
                     _loc2_ += this.getItemSize() / 2 + 10;
               }
               break;
            case 3:
               switch(param1)
               {
                  case 0:
                     _loc2_ -= this.getItemSize() + 5;
                     break;
                  case 2:
                     _loc2_ += this.getItemSize() + 5;
               }
         }
         return _loc2_ - this.getItemSize() / 2;
      }
      
      private function getItemSize() : Number
      {
         var _loc1_:Number = this.mcSizer_image.width;
         switch(this.totalItems)
         {
            case 1:
               break;
            case 2:
               _loc1_ = this.mcSizer_image.width * 0.75;
               break;
            case 3:
               _loc1_ = this.mcSizer_image.width * 0.55;
         }
         return _loc1_;
      }
      
      private function get totalItems() : uint
      {
         return dataM.myProfile.starterPackData.mechItemIDs.length;
      }
      
      private function removeItems() : void
      {
         var _loc2_:BMTileListItem = null;
         if(this._tileListItems == null)
         {
            this._tileListItems = new Array();
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._tileListItems.length)
         {
            _loc2_ = this._tileListItems[_loc1_];
            _loc2_.parent.removeChild(_loc2_);
            _loc2_.removeMe();
            _loc1_++;
         }
         this._tileListItems = new Array();
      }
      
      override public function removeMe() : void
      {
         this.removeItems();
         screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_ITEM_AND_TOKENS);
      }
   }
}

