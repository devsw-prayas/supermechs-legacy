package net.battleMechsMulti.mobiles
{
   public class BMStarterPackData
   {
      
      public var packID:uint = 0;
      
      public var tokenPackageID:uint = 0;
      
      public var offerDuration:uint;
      
      public var boostID:uint;
      
      public var boostAmount:uint;
      
      public var mechColorID:uint;
      
      public var torso:uint;
      
      public var leg:uint;
      
      public var sideWeapon1:uint;
      
      public var sideWeapon2:uint;
      
      public var topWeapon1:uint;
      
      public var topWeapon2:uint;
      
      public var module1:uint;
      
      public var module2:uint;
      
      public var module3:uint;
      
      public var module4:uint;
      
      public var module5:uint;
      
      public var drone:uint;
      
      public var bonusGold:uint;
      
      public var skin:uint;
      
      public var starterPackStatus:uint;
      
      public var starterPackStartDate:Number;
      
      public var price:String;
      
      public var bonusTokens:uint;
      
      public function BMStarterPackData()
      {
         super();
      }
      
      public function initialize(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint, param9:uint, param10:uint, param11:uint, param12:uint, param13:uint, param14:uint, param15:uint, param16:uint, param17:uint, param18:uint, param19:uint, param20:uint = 0, param21:Number = 0, param22:String = "", param23:uint = 0) : void
      {
         this.packID = param1;
         this.offerDuration = param2;
         this.boostID = param3;
         this.boostAmount = param4;
         this.mechColorID = param5;
         this.torso = param6;
         this.leg = param7;
         this.sideWeapon1 = param8;
         this.sideWeapon2 = param9;
         this.topWeapon1 = param10;
         this.topWeapon2 = param11;
         this.module1 = param12;
         this.module2 = param13;
         this.module3 = param14;
         this.module4 = param15;
         this.module5 = param16;
         this.drone = param17;
         this.bonusGold = param18;
         this.skin = param19;
         this.starterPackStartDate = param21;
         this.starterPackStatus = param20;
         this.price = param22;
         this.bonusTokens = param23;
      }
   }
}

