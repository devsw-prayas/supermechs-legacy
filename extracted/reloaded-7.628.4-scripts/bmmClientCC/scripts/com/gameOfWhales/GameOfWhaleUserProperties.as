package com.gameOfWhales
{
   public class GameOfWhaleUserProperties
   {
      
      public var user:String;
      
      public var revenue:Number;
      
      public var group:String;
      
      public var custom:Object;
      
      public function GameOfWhaleUserProperties(param1:Object)
      {
         super();
         this.user = param1.user;
         this.revenue = param1.revenue;
         if(param1.group != null)
         {
            this.group = param1.group;
         }
         if(param1.custom != null)
         {
            this.custom = param1.custom;
         }
      }
   }
}

