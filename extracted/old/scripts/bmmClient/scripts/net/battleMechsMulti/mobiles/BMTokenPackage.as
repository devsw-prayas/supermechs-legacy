package net.battleMechsMulti.mobiles
{
   public class BMTokenPackage
   {
      
      public var packageID:uint;
      
      public var platformID:uint;
      
      public var sortID:uint;
      
      public var tokenSystemPackageID:String;
      
      public var starterPackID:Number;
      
      public var visualID:uint;
      
      public var specialBanner:uint;
      
      public var price:String;
      
      public var title:String;
      
      public var tokens:uint;
      
      public var bonusFromTokens:uint;
      
      public function BMTokenPackage()
      {
         super();
      }
      
      public function initialize(param1:uint, param2:uint, param3:uint, param4:String, param5:Number, param6:uint, param7:uint = 0, param8:String = "", param9:String = "", param10:uint = 0, param11:uint = 0) : *
      {
         this.packageID = param1;
         this.platformID = param2;
         this.sortID = param3;
         this.tokenSystemPackageID = param4;
         this.starterPackID = param5;
         this.visualID = param6;
         this.specialBanner = param7;
         this.price = param8;
         this.title = param9;
         this.tokens = param10;
         this.bonusFromTokens = param11;
      }
   }
}

