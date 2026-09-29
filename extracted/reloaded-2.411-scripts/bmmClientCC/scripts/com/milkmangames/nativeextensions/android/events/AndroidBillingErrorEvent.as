package com.milkmangames.nativeextensions.android.events
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   
   public class AndroidBillingErrorEvent extends ErrorEvent
   {
      
      public static const PURCHASE_FAILED:String = "iabPurchaseFailed";
      
      public static const LOAD_INVENTORY_FAILED:String = "INVENTORY_FAILED";
      
      public static const ITEM_DETAILS_FAILED:String = "ITEM_DETAILS_FAILED";
      
      public static const CONSUME_FAILED:String = "CONSUME_FAILED";
      
      public var itemId:String;
      
      public function AndroidBillingErrorEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = "", param5:int = 0)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function clone() : Event
      {
         return new AndroidBillingErrorEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("AndroidBillingErrorEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}

