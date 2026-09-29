package com.gameOfWhales
{
   public class GameOfWhalesReceiptInfo
   {
      
      public var transaction:String;
      
      public var verifyState:String;
      
      public function GameOfWhalesReceiptInfo(param1:Object)
      {
         super();
         this.transaction = param1.transaction;
         this.verifyState = param1.verifyState;
      }
   }
}

