package net.battleMechsMulti.screens.buyStarterPack
{
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMScreensManager;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1427")]
   public class BMScreenBuyStarterPackGoldAndTokens extends BMScreenBuyStarterPack
   {
      
      public var mcSizer_image:Sprite;
      
      public var mcRays1:Sprite;
      
      public var mcRays2:Sprite;
      
      public var mcImagesHolder:Sprite;
      
      private var _image:Sprite;
      
      public function BMScreenBuyStarterPackGoldAndTokens()
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
         var _loc1_:String = "starterPack_goldAndTokens1";
         this._image = externalAssetsM.getAsset("general",_loc1_,this.mcSizer_image.width,this.mcSizer_image.height);
         this._image.x = this.mcSizer_image.x;
         this._image.y = this.mcSizer_image.y;
         this.mcImagesHolder.addChild(this._image);
      }
      
      override public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_GOLD_AND_TOKENS);
      }
   }
}

