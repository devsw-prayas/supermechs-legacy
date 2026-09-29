package com.milkmangames.nativeextensions.android
{
   public class AndroidPurchase
   {
      
      public var itemId:String;
      
      public var itemType:String;
      
      public var developerPayload:String;
      
      public var orderId:String;
      
      public var jsonData:String;
      
      public var signature:String;
      
      public var purchaseTime:Number;
      
      public var purchaseToken:String;
      
      public function AndroidPurchase()
      {
         super();
      }
      
      public function toString() : String
      {
         return "AndroidPurchase(itemId=" + this.itemId + ",itemType=" + this.itemType + ",orderId=" + this.orderId + ",payload=" + this.developerPayload + ",time=" + this.purchaseTime + ",token=" + this.purchaseToken + ",signature=" + this.signature;
      }
   }
}

