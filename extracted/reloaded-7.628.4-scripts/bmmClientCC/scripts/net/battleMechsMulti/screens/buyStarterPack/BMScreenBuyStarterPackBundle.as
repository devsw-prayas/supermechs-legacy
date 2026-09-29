package net.battleMechsMulti.screens.buyStarterPack
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1442")]
   public class BMScreenBuyStarterPackBundle extends BMScreenBuyStarterPack
   {
      
      public var mcBundlesHolder:Sprite;
      
      public var txtDetails:TextField;
      
      private var totalOffers:uint;
      
      private var bundleTexts:Array;
      
      private var bundleItems:Array;
      
      private var detailsStr:String;
      
      private var detailsCount:uint;
      
      public function BMScreenBuyStarterPackBundle()
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
         this.createBundle();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
      }
      
      private function createBundle() : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:BMItemData = null;
         this.removeBundleItems();
         this.detailsStr = "";
         this.detailsCount = 0;
         this.totalOffers = 0;
         this.bundleTexts = new Array();
         var _loc1_:BMStarterPackData = dataM.myProfile.starterPackData;
         var _loc2_:String = BMStarterPackBundleItem.TYPE_ITEM_BOX;
         if(_loc1_.boostID > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,_loc1_.boostID,"",_loc1_.boostAmount,3);
         }
         _loc2_ = BMStarterPackBundleItem.TYPE_ITEM;
         var _loc3_:uint = 1;
         while(_loc3_ <= 8)
         {
            _loc5_ = uint(_loc1_["module" + _loc3_]);
            if(_loc5_ != 0)
            {
               _loc6_ = uint(_loc1_["module" + _loc3_ + "Multiplier"]);
               _loc7_ = dataM.itemsDB[_loc5_];
               this.createSpecificBundleItem(_loc2_,_loc5_,0,"",_loc6_,_loc7_.specialStatus);
            }
            _loc3_++;
         }
         _loc2_ = BMStarterPackBundleItem.TYPE_RESOURCE;
         if(_loc1_.bonusTokens > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_TOKENS,_loc1_.bonusTokens,4);
         }
         if(_loc1_.bonusGold > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_GOLD,_loc1_.bonusGold,3);
         }
         if(_loc1_.clanCoins > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_CLAN_COINS,_loc1_.clanCoins,3);
         }
         if(_loc1_.arenaCoins > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_ARENA_COINS,_loc1_.arenaCoins,3);
         }
         if(_loc1_.battleCredits > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_BATTLE_CREDITS,_loc1_.battleCredits,3);
         }
         if(_loc1_.nukes > 0)
         {
            this.createSpecificBundleItem(_loc2_,0,0,BMStarterPackBundleItem.RESOURCE_NUKES,_loc1_.nukes,3);
         }
         this.addAndArrangeBundleItems();
         var _loc4_:uint = 0;
         while(_loc4_ < this.bundleTexts.length)
         {
            if(_loc4_ >= 6)
            {
               this.detailsStr += "<BR>and more...";
               break;
            }
            if(_loc4_ == 0)
            {
               this.detailsStr = this.bundleTexts[_loc4_];
            }
            else
            {
               this.detailsStr += "<BR>" + this.bundleTexts[_loc4_];
            }
            _loc4_++;
         }
         updateTextAndFormat(this.txtDetails,this.detailsStr);
      }
      
      private function createSpecificBundleItem(param1:String, param2:uint, param3:uint, param4:String, param5:uint, param6:uint) : void
      {
         this.totalOffers += 1;
         var _loc7_:BMStarterPackBundleItem = new BMStarterPackBundleItem();
         if(param1 == BMStarterPackBundleItem.TYPE_ITEM)
         {
            _loc7_.initializeItem(param2,param5,param6);
         }
         else if(param1 == BMStarterPackBundleItem.TYPE_RESOURCE)
         {
            _loc7_.initializeResource(param4,param5,param6);
         }
         else
         {
            _loc7_.initializeItemBox(param3,param5,param6);
         }
         this.bundleItems.push(_loc7_);
         this.addToDetailsText(param1,param2,param3,param4,param5);
      }
      
      private function addToDetailsText(param1:String, param2:uint, param3:uint, param4:String, param5:uint) : void
      {
         var _loc7_:BMItemData = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:BMGachaMachineData = null;
         var _loc6_:uint = 6;
         if(this.detailsCount == _loc6_)
         {
            return;
         }
         if(param1 == BMStarterPackBundleItem.TYPE_ITEM)
         {
            _loc7_ = dataM.itemsDB[param2];
            _loc8_ = _loc7_.fullName;
            if(_loc7_.isColorKit)
            {
               if(int(_loc7_.animation) >= BMDataManager.PATTERN_COLORS_FIRST_ID)
               {
                  _loc8_ = getSpecificText("item_colorKit" + _loc7_.animation);
               }
               else
               {
                  _loc8_ = getSpecificText("item_colorKit");
               }
            }
            this.bundleTexts.push(param5 + " x " + _loc8_);
         }
         else if(param1 == BMStarterPackBundleItem.TYPE_RESOURCE)
         {
            _loc9_ = "";
            if(param4 == BMStarterPackBundleItem.RESOURCE_TOKENS)
            {
               _loc9_ = getSpecificText("globalShop_tokens");
            }
            else if(param4 == BMStarterPackBundleItem.RESOURCE_GOLD)
            {
               _loc9_ = getSpecificText("globalShop_gold");
            }
            else if(param4 == BMStarterPackBundleItem.RESOURCE_BATTLE_CREDITS)
            {
               _loc9_ = getSpecificText("general_fuel");
            }
            else if(param4 == BMStarterPackBundleItem.RESOURCE_ARENA_COINS)
            {
               _loc9_ = getSpecificText("general_arenaCoins");
            }
            else if(param4 == BMStarterPackBundleItem.RESOURCE_CLAN_COINS)
            {
               _loc9_ = getSpecificText("general_clanCoins");
            }
            else if(param4 == BMStarterPackBundleItem.RESOURCE_NUKES)
            {
               _loc9_ = getSpecificText("nukes_title");
            }
            this.bundleTexts.push(TextUtils.getNumberWithComma(param5) + " " + _loc9_);
         }
         else
         {
            _loc10_ = dataM.gachaMachinesDB[param3];
            this.bundleTexts.push(param5 + " x " + getSpecificText(_loc10_.name));
         }
      }
      
      private function addAndArrangeBundleItems() : void
      {
         var _loc12_:BMStarterPackBundleItem = null;
         var _loc1_:uint = 1;
         if(this.bundleItems.length >= 4 && this.bundleItems.length <= 8)
         {
            _loc1_ = 2;
         }
         else if(this.bundleItems.length > 8)
         {
            _loc1_ = 3;
         }
         var _loc2_:uint = Math.ceil(this.bundleItems.length / _loc1_);
         var _loc3_:uint = 1;
         var _loc4_:uint = 1;
         var _loc5_:uint = 15;
         var _loc6_:uint = 15;
         var _loc7_:* = this.bundleItems[0].mcFrame.width;
         var _loc8_:* = this.bundleItems[0].mcFrame.height;
         var _loc9_:Number = 0;
         if(_loc2_ > 1)
         {
            _loc9_ = -((_loc2_ - 1) * _loc7_ + _loc5_ * (_loc2_ - 1)) / 2;
         }
         var _loc10_:Number = 0;
         if(_loc1_ == 2)
         {
            _loc10_ = -_loc8_ / 2 - _loc6_ / 2;
         }
         else if(_loc1_ == 3)
         {
            _loc10_ = -_loc8_ - _loc6_;
         }
         var _loc11_:uint = 0;
         while(_loc11_ < this.bundleItems.length)
         {
            _loc12_ = this.bundleItems[_loc11_];
            _loc12_.x = _loc9_ + (_loc4_ - 1) * (_loc12_.mcFrame.width + _loc5_) - _loc7_ / 2;
            _loc12_.y = _loc10_ + (_loc3_ - 1) * (_loc12_.mcFrame.height + _loc6_) - _loc8_ / 2;
            this.mcBundlesHolder.addChild(_loc12_);
            if(_loc4_ == _loc2_)
            {
               _loc4_ = 1;
               _loc3_ += 1;
            }
            else
            {
               _loc4_ += 1;
            }
            _loc11_++;
         }
      }
      
      private function removeBundleItems() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMStarterPackBundleItem = null;
         if(this.bundleItems != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.bundleItems.length)
            {
               _loc2_ = this.bundleItems[_loc1_];
               _loc2_.parent.removeChild(_loc2_);
               _loc2_ = null;
               _loc1_++;
            }
         }
         this.bundleItems = new Array();
      }
      
      override public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_BUNDLE);
      }
   }
}

