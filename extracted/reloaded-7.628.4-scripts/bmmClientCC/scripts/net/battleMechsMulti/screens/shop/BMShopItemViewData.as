package net.battleMechsMulti.screens.shop
{
   import net.battleMechsMulti.managers.sales.BMSale;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMShopItemViewData
   {
      
      public static const TIMER_TYPE_BOTTOM:int = 0;
      
      public static const TIMER_TYPE_BANNER:int = 1;
      
      public static const TIMER_TYPE_EXTRA_DESCRIPTION:int = 2;
      
      public static const TIMER_TYPE_EXTRA_ITEMS:int = 3;
      
      public static const CURRENCY_TYPE_GOLD:uint = 0;
      
      public static const CURRENCY_TYPE_TOKENS:uint = 1;
      
      public static const CURRENCY_TYPE_MONEY:uint = 2;
      
      public static const CURRENCY_TYPE_FREE:uint = 3;
      
      public static const CURRENCY_TYPE_CLAN_COINS:uint = 4;
      
      public static const CURRENCY_TYPE_BOX_FRAGMENTS:uint = 5;
      
      public static const CURRENCY_TYPE_KIN:uint = 6;
      
      public var id:Number = -1;
      
      public var category:uint = 0;
      
      public var titleTop:String = "";
      
      public var titleBottom:String = "";
      
      public var titleBottomTextSize:int = -1;
      
      public var price:String = "0";
      
      public var defaultPrice:String = "0";
      
      public var discount:uint = 0;
      
      public var bodyText:String = "";
      
      public var bodyTextSize:int = -1;
      
      public var bonusText:String = "";
      
      public var bonusTextSize:int = -1;
      
      public var extraDescription:String = "";
      
      public var infoOnlyText1:String = "";
      
      public var infoOnlyText2:String = "";
      
      public var currency:uint = 0;
      
      public var timerEnd:* = 0;
      
      public var timerCompleteText:* = "";
      
      public var twoRowsText:* = "";
      
      public var imagePath:String = "";
      
      public var imageName:String = "";
      
      public var itemID:uint = 0;
      
      public var putImageInSizer:Boolean = false;
      
      public var imageYAddon:int = 0;
      
      public var timerCompleteImageName:String = "";
      
      public var timerType:int = 0;
      
      public var specialBanner:uint = 0;
      
      public var itemBox_cards:uint = 0;
      
      public var itemBox_ratio4:uint = 0;
      
      public var itemBox_ratio3:uint = 0;
      
      public var itemBox_ratio2:uint = 0;
      
      public var itemBox_ratio1:uint = 0;
      
      public var ratioNewMythical:uint = 0;
      
      public var moveGrpHolderUpPixels:uint = 0;
      
      public var moveBonusTextUpPixels:int = 0;
      
      public var extraValue_text1:String = "";
      
      public var extraValue_text2:String = "";
      
      public var mechStructure:BMMechStructure = null;
      
      public var extraChanceItemIDs:Array = new Array();
      
      public var isDisabled:Boolean = false;
      
      public var counter:int = 0;
      
      public var viewCls:Class = null;
      
      public var showBoughtBanner:Boolean = false;
      
      public function BMShopItemViewData()
      {
         super();
      }
      
      public function applaySale(param1:BMSale) : void
      {
         this.timerType = BMShopItemViewData.TIMER_TYPE_BANNER;
         this.timerEnd = param1.endDate;
         this.specialBanner = param1.ribbonID + 2;
         this.discount = param1.saleEffect;
      }
      
      public function applyChainDiscount(param1:uint, param2:uint) : void
      {
         this.timerType = BMShopItemViewData.TIMER_TYPE_BANNER;
         this.timerEnd = param2;
         this.specialBanner = 7;
         this.discount = param1;
      }
      
      public function applayCostTokens(param1:uint, param2:uint) : void
      {
         this.currency = BMShopItemViewData.CURRENCY_TYPE_TOKENS;
         this.price = TextUtils.getNumberWithComma(param1);
         if(param2 > param1)
         {
            this.defaultPrice = " " + TextUtils.getNumberWithComma(param2);
         }
      }
   }
}

