package net.battleMechsMulti.mobiles
{
   public class BMBattleTurnData
   {
      
      public var player1:Object = new Object();
      
      public var player2:Object = new Object();
      
      public function BMBattleTurnData()
      {
         super();
      }
      
      public function resetPlayerData(param1:Number) : void
      {
         var _loc2_:uint = 1;
         while(_loc2_ <= 3)
         {
            this["player" + param1][_loc2_] = new Object();
            this["player" + param1][_loc2_].HP = 0;
            this["player" + param1][_loc2_].heat = 0;
            this["player" + param1][_loc2_].energy = 0;
            this["player" + param1][_loc2_].rockets = 0;
            this["player" + param1][_loc2_].bullets = 0;
            this["player" + param1][_loc2_].shieldActive = false;
            this["player" + param1][_loc2_].droneActive = false;
            this["player" + param1][_loc2_].droneFired = false;
            this["player" + param1][_loc2_].resist1 = 0;
            this["player" + param1][_loc2_].resist2 = 0;
            this["player" + param1][_loc2_].resist3 = 0;
            _loc2_++;
         }
         this["player" + param1].AP = 0;
         this["player" + param1].selectedMechID = 0;
         this["player" + param1].step = 0;
      }
      
      public function set_selectedMechID(param1:Number, param2:uint) : void
      {
         var _loc3_:Object = this["player" + param1];
         _loc3_.selectedMechID = param2;
      }
      
      public function get_selectedMechID(param1:Number) : Number
      {
         var _loc2_:Object = this["player" + param1];
         return _loc2_.selectedMechID;
      }
      
      public function set_HP(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].HP = param2;
      }
      
      public function get_HP(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].HP;
      }
      
      public function set_energy(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].energy = param2;
         if(_loc4_[param3].energy < 0)
         {
            _loc4_[param3].energy = 0;
         }
      }
      
      public function get_energy(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].energy;
      }
      
      public function set_heat(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].heat = param2;
         if(_loc4_[param3].heat < 0)
         {
            _loc4_[param3].heat = 0;
         }
      }
      
      public function get_heat(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].heat;
      }
      
      public function set_bullets(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].bullets = param2;
         if(_loc4_[param3].bullets < 0)
         {
            _loc4_[param3].bullets = 0;
         }
      }
      
      public function get_bullets(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].bullets;
      }
      
      public function set_rockets(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].rockets = param2;
         if(_loc4_[param3].rockets < 0)
         {
            _loc4_[param3].rockets = 0;
         }
      }
      
      public function get_rockets(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].rockets;
      }
      
      public function set_shieldActive(param1:Number, param2:Boolean, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].shieldActive = param2;
      }
      
      public function get_shieldActive(param1:Number, param2:uint = 0) : Boolean
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].shieldActive;
      }
      
      public function set_droneActive(param1:Number, param2:Boolean, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].droneActive = param2;
      }
      
      public function get_droneActive(param1:Number, param2:uint = 0) : Boolean
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].droneActive;
      }
      
      public function set_droneFired(param1:Number, param2:Boolean, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].droneFired = param2;
      }
      
      public function get_droneFired(param1:Number, param2:uint = 0) : Boolean
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].droneFired;
      }
      
      public function set_step(param1:Number, param2:Number) : void
      {
         var _loc3_:Object = this["player" + param1];
         _loc3_.step = param2;
      }
      
      public function get_step(param1:Number) : Number
      {
         var _loc2_:Object = this["player" + param1];
         return _loc2_.step;
      }
      
      public function set_AP(param1:Number, param2:Number) : void
      {
         var _loc3_:Object = this["player" + param1];
         _loc3_.AP = param2;
         if(_loc3_.AP < 0)
         {
            _loc3_.AP = 0;
         }
      }
      
      public function get_AP(param1:Number) : Number
      {
         var _loc2_:Object = this["player" + param1];
         return _loc2_.AP;
      }
      
      public function set_resist1(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].resist1 = param2;
      }
      
      public function set_resist2(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].resist2 = param2;
      }
      
      public function set_resist3(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID);
         }
         _loc4_[param3].resist3 = param2;
      }
      
      public function get_resist1(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].resist1;
      }
      
      public function get_resist2(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].resist2;
      }
      
      public function get_resist3(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID);
         }
         return _loc3_[param2].resist3;
      }
   }
}

