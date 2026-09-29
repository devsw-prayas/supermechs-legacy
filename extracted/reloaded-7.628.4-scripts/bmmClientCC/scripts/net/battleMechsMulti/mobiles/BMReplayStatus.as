package net.battleMechsMulti.mobiles
{
   public class BMReplayStatus
   {
      
      public var mechID:Number;
      
      public var AP:Number;
      
      public var HP:Number;
      
      public var energy:Number;
      
      public var heat:Number;
      
      public var bullets:Number;
      
      public var rockets:Number;
      
      public var step:Number;
      
      public var shield:Boolean;
      
      public var drone:Boolean;
      
      public var resist1:Number;
      
      public var resist2:Number;
      
      public var resist3:Number;
      
      public function BMReplayStatus()
      {
         super();
      }
      
      public function getProtocolString() : String
      {
         var _loc1_:Array = [uint(this.AP),int(this.HP),uint(this.energy),uint(this.heat),uint(this.bullets),uint(this.rockets),uint(this.step),uint(this.shield),uint(this.drone),int(this.resist1),int(this.resist2),int(this.resist3),"X"];
         return _loc1_.join("_");
      }
   }
}

