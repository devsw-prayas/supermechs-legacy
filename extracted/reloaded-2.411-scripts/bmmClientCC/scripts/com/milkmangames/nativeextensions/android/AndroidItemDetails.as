package com.milkmangames.nativeextensions.android
{
   public class AndroidItemDetails
   {
      
      public var itemId:String;
      
      public var itemType:String;
      
      public var price:String;
      
      public var title:String;
      
      public var description:String;
      
      public var priceAmountMicros:Number;
      
      public var priceCurrencyCode:String;
      
      public function AndroidItemDetails()
      {
         super();
      }
      
      public function toString() : String
      {
         return "AndroidItem(itemId=" + this.itemId + ",itemType=" + this.itemType + ",price=" + this.price + ",priceAmountMicros=" + this.priceAmountMicros + ",priceCurrencyCode=" + this.priceCurrencyCode + ",title=" + this.title + ",description=" + this.description + ")";
      }
   }
}

