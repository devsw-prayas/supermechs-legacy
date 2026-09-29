package net.battleMechsMulti.managers.shop
{
   public class BMPremiumPackageData
   {
      
      private var _id:int;
      
      private var _title:String;
      
      private var _durationHours:int;
      
      private var _tokens:int;
      
      private var _costTokensDefault:int;
      
      private var _specialBanner:int;
      
      private var _sortID:int;
      
      private var _visualID:int;
      
      public function BMPremiumPackageData()
      {
         super();
      }
      
      public function parse(param1:Object) : void
      {
         this._id = param1.premiumPackageID;
         this._title = param1.title;
         this._durationHours = param1.durationHours;
         this._tokens = param1.tokens;
         this._costTokensDefault = param1.costTokensDefault;
         this._specialBanner = param1.specialBanner;
         this._sortID = param1.sortID;
         this._visualID = param1.visualID;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get durationHours() : int
      {
         return this._durationHours;
      }
      
      public function get tokens() : int
      {
         return this._tokens;
      }
      
      public function get specialBanner() : int
      {
         return this._specialBanner;
      }
      
      public function get sortID() : int
      {
         return this._sortID;
      }
      
      public function get visualID() : int
      {
         return this._visualID;
      }
      
      public function get costTokensDefault() : int
      {
         return this._costTokensDefault;
      }
   }
}

