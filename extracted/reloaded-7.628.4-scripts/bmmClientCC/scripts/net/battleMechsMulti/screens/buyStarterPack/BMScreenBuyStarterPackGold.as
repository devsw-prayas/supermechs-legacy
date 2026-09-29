package net.battleMechsMulti.screens.buyStarterPack
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMGoldPackageData;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1437")]
   public class BMScreenBuyStarterPackGold extends BMScreenBuyStarterPack
   {
      
      public var mcSizer_image:Sprite;
      
      public var mcRays1:Sprite;
      
      public var mcRays2:Sprite;
      
      public var txtExtraGold:TextField;
      
      public var mcImagesHolder:Sprite;
      
      private var _goldImage:Sprite;
      
      public function BMScreenBuyStarterPackGold()
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
         if(this.txtExtraGold == null)
         {
            return;
         }
         var _loc2_:BMStarterPackData = dataM.myProfile.starterPackData;
         var _loc3_:BMTokenPackage = getCheapestTokensPackage();
         var _loc4_:BMGoldPackageData = getCheapestGoldPackage();
         var _loc5_:Number = _loc2_.bonusGold / _loc2_.priceWithoutCurrency;
         var _loc6_:Number = _loc3_.tokens / _loc3_.priceWithoutCurrency;
         var _loc7_:Number = _loc4_.gold / _loc4_.costTokens;
         var _loc8_:Number = Math.floor((_loc5_ / (_loc6_ * _loc7_) - 1) * 100);
         var _loc9_:String = getSpecificText("buyTokens_more");
         _loc9_ = dataM.replaceStringInText(_loc9_,"%AMOUNT%","<FONT COLOR=\'#00FF00\'>" + _loc8_ + "</FONT>");
         updateTextAndFormat(this.txtExtraGold,_loc9_);
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         this.mcRays1.rotation += 0.4;
         this.mcRays2.rotation -= 0.2;
      }
      
      private function addImage() : void
      {
         var _loc1_:Number = this.mcSizer_image.width;
         var _loc2_:String = "starterPack_gold4";
         if(dataM.myProfile.starterPackData.skin > 0)
         {
            _loc2_ = "starterPack_gold" + dataM.myProfile.starterPackData.skin;
         }
         this._goldImage = externalAssetsM.getAsset("general",_loc2_,_loc1_,_loc1_);
         this._goldImage.x = this.mcSizer_image.x;
         this._goldImage.y = this.mcSizer_image.y;
         this.mcImagesHolder.addChild(this._goldImage);
      }
      
      override public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_GOLD);
      }
   }
}

