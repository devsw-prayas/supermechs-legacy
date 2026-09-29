package com.gameOfWhales
{
   import flash.events.Event;
   
   public class GameOfWhalesEvent extends Event
   {
      
      public static const TEMP:String = "temp";
      
      public static const VERSION_SET:String = "versionSet";
      
      public static const GOT_OFFERS:String = "gotOffers";
      
      public var result:Object;
      
      public function GameOfWhalesEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.result = param2;
      }
      
      override public function clone() : Event
      {
         return new GameOfWhalesEvent(type,this.result,bubbles,cancelable);
      }
   }
}

