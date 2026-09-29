package com.milkmangames.nativeextensions.android.events
{
   import com.milkmangames.nativeextensions.android.AndroidItemDetails;
   import com.milkmangames.nativeextensions.android.AndroidPurchase;
   import flash.events.Event;
   
   public class AndroidBillingEvent extends Event
   {
      
      public static const SERVICE_READY:String = "iabBillingServiceReady";
      
      public static const SERVICE_NOT_SUPPORTED:String = "iabBillingServiceNotSupported";
      
      public static const INVENTORY_LOADED:String = "INVENTORY_LOADED";
      
      public static const ITEM_DETAILS_LOADED:String = "ITEM_DETAILS_LOADED";
      
      public static const CONSUME_SUCCEEDED:String = "CONSUME_SUCCEEDED";
      
      public static const PURCHASE_SUCCEEDED:String = "iabPurchaseSucceeded";
      
      public var itemId:String;
      
      public var jsonData:String;
      
      public var signature:String;
      
      public var purchaseTime:Number;
      
      public var purchaseToken:String;
      
      public var itemDetails:Vector.<AndroidItemDetails>;
      
      public var purchases:Vector.<AndroidPurchase>;
      
      public function AndroidBillingEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new AndroidBillingEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("AndroidBillingEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}

