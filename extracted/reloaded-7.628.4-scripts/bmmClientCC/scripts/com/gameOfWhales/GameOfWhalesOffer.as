package com.gameOfWhales
{
   public class GameOfWhalesOffer
   {
      
      public var product:String;
      
      public var camp:String;
      
      public var createAt:Number;
      
      public var activatedAt:Number;
      
      public var finishedAt:Number;
      
      public var rest:Number;
      
      public var decisionTime:Number;
      
      public var countFactor:Number;
      
      public var priceFactor:Number;
      
      public var name:String;
      
      public var description:String;
      
      public var redeemable:Boolean;
      
      public var custom:Object = new Object();
      
      public function GameOfWhalesOffer(param1:Object)
      {
         super();
         this.product = param1.product;
         this.camp = param1.camp;
         this.createAt = param1.createdAt;
         this.activatedAt = param1.activatedAt;
         this.finishedAt = param1.finishedAt;
         this.rest = param1.rest;
         this.decisionTime = param1.decisionTime;
         this.countFactor = param1.countFactor;
         this.priceFactor = param1.priceFactor;
         this.name = param1.name;
         this.description = param1.description;
         this.redeemable = param1.redeemable;
         if(param1.custom != null)
         {
            this.custom = param1.custom;
         }
      }
   }
}

