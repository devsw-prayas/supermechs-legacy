package net.battleMechsMulti.screens.shop
{
   public class BMShopItemData
   {
      
      public static const CURRENCY_TYPE_GOLD:uint = 0;
      
      public static const CURRENCY_TYPE_TOKENS:uint = 1;
      
      public static const CURRENCY_TYPE_MONEY:uint = 2;
      
      public static const CURRENCY_TYPE_FREE:uint = 3;
      
      public var id:Number = -1;
      
      public var category:uint = 0;
      
      public var titleTop:String = "";
      
      public var titleBottom:String = "";
      
      public var price:String = "0";
      
      public var defaultPrice:String = "0";
      
      public var discount:uint = 0;
      
      public var bodyText:String = "";
      
      public var bonusText:String = "";
      
      public var currency:uint = 0;
      
      public var timerEnd:* = 0;
      
      public var timerCompleteText:* = "";
      
      public var twoRowsText:* = "";
      
      public var imagePath:String = "";
      
      public var imageName:String = "";
      
      public var timerCompleteImageName:String = "";
      
      public var useBottomTimer:Boolean = true;
      
      public var specialBanner:uint = 0;
      
      public var itemBox_cards:uint = 0;
      
      public var itemBox_ratio4:uint = 0;
      
      public var itemBox_ratio3:uint = 0;
      
      public var itemBox_ratio2:uint = 0;
      
      public var itemBox_ratio1:uint = 0;
      
      public var ratioNewMythical:uint = 0;
      
      public var moveGrpHolderUpPixels:uint = 0;
      
      public var moveBonusTextUpPixels:uint = 0;
      
      public var isDisabled:Boolean = false;
      
      public function BMShopItemData()
      {
         super();
      }
   }
}

