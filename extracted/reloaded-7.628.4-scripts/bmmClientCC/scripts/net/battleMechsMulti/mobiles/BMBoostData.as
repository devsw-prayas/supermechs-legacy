package net.battleMechsMulti.mobiles
{
   public class BMBoostData
   {
      
      public var boostID:Number;
      
      public var boostName:String;
      
      public var type:String;
      
      public var costTokens:Number;
      
      public var costTokensDefault:Number;
      
      public var durationInSeconds:Number;
      
      public var costGold:Number;
      
      public var costGoldMaxLevel:Number;
      
      public var goldAddonPerLevel:Number;
      
      public var itemID:Number;
      
      public var bonusGold:Number;
      
      public var amount:Number;
      
      public var levelDifference:Number;
      
      public var ratioRare:uint;
      
      public var ratioEpic:uint;
      
      public var ratioLegendary:uint;
      
      public var ratioMythical:Number;
      
      public var ratioNewMythical:uint;
      
      public var ratioRareDefault:uint;
      
      public var ratioEpicDefault:uint;
      
      public var ratioLegendaryDefault:uint;
      
      public var ratioMythicalDefault:Number;
      
      public var ratioNewMythicalDefault:uint;
      
      public var ratioPowerKit:uint;
      
      public var bought:Number;
      
      public var itemType:String;
      
      public function BMBoostData()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:String, param3:String, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:uint, param14:uint, param15:uint, param16:Number, param17:uint, param18:uint, param19:uint, param20:uint, param21:Number, param22:uint, param23:uint, param24:String, param25:Number) : void
      {
         this.boostID = param1;
         this.boostName = param2;
         this.type = param3;
         this.costTokens = param4;
         this.costTokensDefault = param5;
         this.durationInSeconds = param6;
         this.costGold = param7;
         this.goldAddonPerLevel = param8;
         this.itemID = param9;
         this.bonusGold = param10;
         this.amount = param11;
         this.levelDifference = param12;
         this.ratioRare = param13;
         this.ratioEpic = param14;
         this.ratioLegendary = param15;
         this.ratioMythical = param16;
         this.ratioNewMythical = param17;
         this.ratioRareDefault = param18;
         this.ratioEpicDefault = param19;
         this.ratioLegendaryDefault = param20;
         this.ratioMythicalDefault = param21;
         this.ratioNewMythicalDefault = param22;
         this.ratioPowerKit = param23;
         this.bought = param25;
         this.itemType = param24;
      }
   }
}

