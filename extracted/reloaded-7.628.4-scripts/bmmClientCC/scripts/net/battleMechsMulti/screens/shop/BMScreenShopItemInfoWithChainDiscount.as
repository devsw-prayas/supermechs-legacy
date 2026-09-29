package net.battleMechsMulti.screens.shop
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   
   public class BMScreenShopItemInfoWithChainDiscount extends BMScreenShopItemInfo
   {
      
      public var txtChainDiscountTitle:TextField;
      
      public var txtChainDiscountCurrentDiscount:TextField;
      
      public var txtChainDiscountNextBoxDiscount:TextField;
      
      public var txtChainDiscountMaxDiscount:TextField;
      
      public var mcCurrentDiscount:MovieClip;
      
      public var mcRays3:Sprite;
      
      public var mcRays4:Sprite;
      
      public var mcTimer:BMTimer;
      
      public function BMScreenShopItemInfoWithChainDiscount()
      {
         super();
      }
      
      override public function initChainDiscount() : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         setLanguageManagerScreenName("chainDiscount");
         var _loc1_:uint = dataM.chainDiscountsResolver.getCurrentDiscount(getShopItemData().id);
         var _loc2_:uint = dataM.chainDiscountsResolver.getNextBoxDiscount(getShopItemData().id);
         var _loc3_:uint = dataM.chainDiscountsResolver.getMaxDiscount(getShopItemData().id);
         updateTextAndFormat(this.txtChainDiscountTitle,getScreenText("chainDiscountActive"));
         updateTextAndFormat(this.mcCurrentDiscount.txtChainDiscountCurrentDiscount,_loc1_ + "%");
         if(_loc1_ == _loc2_)
         {
            updateTextAndFormat(this.txtChainDiscountNextBoxDiscount,"");
            this.txtChainDiscountMaxDiscount.y -= 15;
            updateTextAndFormat(this.txtChainDiscountMaxDiscount,getScreenText("maxDiscount"));
         }
         else
         {
            _loc4_ = getScreenText("discountOnNextBox");
            _loc4_ = dataM.replaceStringInText(_loc4_,"%DISCOUNT%","<FONT COLOR=\'#FFCC00\'>" + _loc2_ + "%</FONT>");
            updateTextAndFormat(this.txtChainDiscountNextBoxDiscount,_loc4_);
            _loc5_ = getSpecificText("maxDiscountOf");
            _loc5_ = dataM.replaceStringInText(_loc5_,"%DISCOUNT%","<FONT COLOR=\'#FFCC00\'>" + _loc3_ + "</FONT>%");
            updateTextAndFormat(this.txtChainDiscountMaxDiscount,_loc5_);
         }
         this.mcTimer.initialize(this.getChainDiscountSecondsLeft,this.chainDiscountTimeEnded);
         this.mcTimer.setTitle(getSpecificText("raid_timeLeft"));
         TweenMax.to(this.mcRays3,24,{
            "rotation":360,
            "ease":Linear.easeNone,
            "repeat":-1
         });
         TweenMax.to(this.mcRays4,30,{
            "rotation":-360,
            "ease":Linear.easeNone,
            "repeat":-1
         });
         TweenMax.to(this.mcCurrentDiscount,0.2,{
            "delay":0.3,
            "scaleX":1.3,
            "scaleY":1.3,
            "onComplete":this.discountEnlargeComplete
         });
      }
      
      private function discountEnlargeComplete() : void
      {
         TweenMax.to(this.mcCurrentDiscount,0.2,{
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.discountShrinkComplete
         });
      }
      
      private function discountShrinkComplete() : void
      {
         TweenMax.to(this.mcCurrentDiscount,0.2,{
            "delay":3,
            "scaleX":1.3,
            "scaleY":1.3,
            "onComplete":this.discountEnlargeComplete
         });
      }
      
      private function getChainDiscountSecondsLeft() : uint
      {
         return dataM.chainDiscountsResolver.getActiveChainDiscountSecondsLeft(getShopItemData().id);
      }
      
      private function chainDiscountTimeEnded() : void
      {
         removeMe();
      }
      
      override public function removedFromStageSub() : void
      {
         TweenMax.killTweensOf(this.mcRays3);
         TweenMax.killTweensOf(this.mcRays4);
      }
   }
}

