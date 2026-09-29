package net.battleMechsMulti.screens.shop
{
   public class BMGachaMachineData
   {
      
      public var gachaMachineID:uint;
      
      public var name:String;
      
      public var description:String;
      
      public var costGold:uint;
      
      public var costTokens:uint;
      
      public var costTokensDefault:uint;
      
      public var imageID:uint;
      
      public function BMGachaMachineData(param1:uint, param2:String, param3:String, param4:uint, param5:uint, param6:uint, param7:uint)
      {
         super();
         this.gachaMachineID = param1;
         this.name = param2;
         this.description = param3;
         this.costGold = param4;
         this.costTokens = param5;
         this.costTokensDefault = param6;
         this.imageID = param7;
      }
   }
}

