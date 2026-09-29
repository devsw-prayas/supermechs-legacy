package net.battleMechsMulti.screens.buyStarterPack
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1370")]
   public class BMScreenBuyStarterPackTokens extends BMScreenBuyStarterPack
   {
      
      public var mcSizer_image:Sprite;
      
      public var mcRays1:Sprite;
      
      public var mcRays2:Sprite;
      
      public var txtExtraTokens:TextField;
      
      public var mcImagesHolder:Sprite;
      
      private var _tokensImage:Sprite;
      
      public function BMScreenBuyStarterPackTokens()
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
         if(this.txtExtraTokens == null)
         {
            return;
         }
         var _loc2_:BMStarterPackData = dataM.myProfile.starterPackData;
         var _loc3_:BMTokenPackage = getCheapestTokensPackage();
         var _loc4_:Number = _loc2_.bonusTokens / _loc2_.priceWithoutCurrency;
         var _loc5_:Number = _loc3_.tokens / _loc3_.priceWithoutCurrency;
         var _loc6_:Number = Math.floor((_loc4_ / _loc5_ - 1) * 100);
         var _loc7_:String = getSpecificText("buyTokens_more");
         _loc7_ = dataM.replaceStringInText(_loc7_,"%AMOUNT%","<FONT COLOR=\'#00FF00\'>" + _loc6_ + "</FONT>");
         updateTextAndFormat(this.txtExtraTokens,_loc7_);
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
         var _loc2_:String = "starterPack_tokens6";
         if(dataM.myProfile.starterPackData.skin > 0)
         {
            _loc2_ = "starterPack_tokens" + dataM.myProfile.starterPackData.skin;
         }
         this._tokensImage = externalAssetsM.getAsset("general",_loc2_,_loc1_,_loc1_);
         this._tokensImage.x = this.mcSizer_image.x;
         this._tokensImage.y = this.mcSizer_image.y;
         this.mcImagesHolder.addChild(this._tokensImage);
      }
      
      override public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_TOKENS);
      }
   }
}

