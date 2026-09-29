package com.milkmangames.nativeextensions.events
{
   import flash.events.Event;
   
   public class RateBoxEvent extends Event
   {
      
      public static const RATE_SELECTED:String = "RATE_SELECTED";
      
      public static const NEVER_SELECTED:String = "NEVER_SELECTED";
      
      public static const LATER_SELECTED:String = "LATER_SELECTED";
      
      public static const PROMPT_DISPLAYED:String = "PROMPT_DISPLAYED";
      
      public static const NETWORK_UNAVAILABLE:String = "NETWORK_UNAVAILABLE";
      
      public function RateBoxEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new RateBoxEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("RateBoxEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}

