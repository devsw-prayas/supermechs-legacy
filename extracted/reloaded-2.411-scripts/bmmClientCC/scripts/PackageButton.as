package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2098")]
   public dynamic class PackageButton extends MovieClip
   {
      
      public var mcBackground:MovieClip;
      
      public var mcDisabledEffect:MovieClip;
      
      public var mcDiscountBadge:MovieClip;
      
      public var mcGold:MovieClip;
      
      public var mcGold2:MovieClip;
      
      public var mcItemSizer:MovieClip;
      
      public var mcTokens:MovieClip;
      
      public var txtAvailable:TextField;
      
      public var txtBonusGold:TextField;
      
      public var txtCostTokensGold:TextField;
      
      public var txtDiscount:TextField;
      
      public var txtPackageName:TextField;
      
      public var txtPackageNameSmall:TextField;
      
      public var txtPremiumAccountDays:TextField;
      
      public function PackageButton()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

