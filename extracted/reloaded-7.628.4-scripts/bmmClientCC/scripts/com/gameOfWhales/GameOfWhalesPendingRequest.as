package com.gameOfWhales
{
   public class GameOfWhalesPendingRequest
   {
      
      public var method:String;
      
      public var commonExtras:Object;
      
      public var event:Object;
      
      public var requestMethod:String;
      
      public function GameOfWhalesPendingRequest(param1:String, param2:Object = null, param3:Object = null, param4:String = "POST")
      {
         super();
         this.method = param1;
         this.commonExtras = param2;
         this.event = param3;
         this.requestMethod = param4;
      }
   }
}

