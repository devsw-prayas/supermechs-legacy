package net.battleMechsMulti.mobiles
{
   import net.tacticsoft.utils.SafeInt;
   
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
            this["player" + param1][_loc2_].HP = new SafeInt();
            this["player" + param1][_loc2_].heat = new SafeInt();
            this["player" + param1][_loc2_].energy = new SafeInt();
            this["player" + param1][_loc2_].rockets = new SafeInt();
            this["player" + param1][_loc2_].bullets = new SafeInt();
            this["player" + param1][_loc2_].shieldActive = false;
            this["player" + param1][_loc2_].droneActive = false;
            this["player" + param1][_loc2_].droneFired = false;
            this["player" + param1][_loc2_].resist1 = new SafeInt();
            this["player" + param1][_loc2_].resist2 = new SafeInt();
            this["player" + param1][_loc2_].resist3 = new SafeInt();
            _loc2_++;
         }
         this["player" + param1].AP = new SafeInt();
         this["player" + param1].selectedMechID = new SafeInt();
         this["player" + param1].step = new SafeInt();
      }
      
      public function set_selectedMechID(param1:Number, param2:uint) : void
      {
         var _loc3_:Object = this["player" + param1];
         _loc3_.selectedMechID.value = param2;
      }
      
      public function get_selectedMechID(param1:Number) : Number
      {
         var _loc2_:Object = this["player" + param1];
         return _loc2_.selectedMechID.value;
      }
      
      public function set_HP(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].HP.value = param2;
      }
      
      public function get_HP(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].HP.value;
      }
      
      public function set_energy(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].energy.value = param2;
         if(_loc4_[param3].energy.value < 0)
         {
            _loc4_[param3].energy.value = 0;
         }
      }
      
      public function get_energy(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].energy.value;
      }
      
      public function set_heat(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].heat.value = param2;
         if(_loc4_[param3].heat.value < 0)
         {
            _loc4_[param3].heat.value = 0;
         }
      }
      
      public function get_heat(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].heat.value;
      }
      
      public function set_bullets(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].bullets.value = param2;
         if(_loc4_[param3].bullets.value < 0)
         {
            _loc4_[param3].bullets.value = 0;
         }
      }
      
      public function get_bullets(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].bullets.value;
      }
      
      public function set_rockets(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].rockets.value = param2;
         if(_loc4_[param3].rockets.value < 0)
         {
            _loc4_[param3].rockets.value = 0;
         }
      }
      
      public function get_rockets(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].rockets.value;
      }
      
      public function set_shieldActive(param1:Number, param2:Boolean, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].shieldActive = param2;
      }
      
      public function get_shieldActive(param1:Number, param2:uint = 0) : Boolean
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].shieldActive;
      }
      
      public function set_droneActive(param1:Number, param2:Boolean, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].droneActive = param2;
      }
      
      public function get_droneActive(param1:Number, param2:uint = 0) : Boolean
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].droneActive;
      }
      
      public function set_droneFired(param1:Number, param2:Boolean, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].droneFired = param2;
      }
      
      public function get_droneFired(param1:Number, param2:uint = 0) : Boolean
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].droneFired;
      }
      
      public function set_step(param1:Number, param2:Number) : void
      {
         var _loc3_:Object = this["player" + param1];
         _loc3_.step.value = param2;
      }
      
      public function get_step(param1:Number) : Number
      {
         var _loc2_:Object = this["player" + param1];
         return _loc2_.step.value;
      }
      
      public function set_AP(param1:Number, param2:Number) : void
      {
         var _loc3_:Object = this["player" + param1];
         _loc3_.AP.value = param2;
         if(_loc3_.AP.value < 0)
         {
            _loc3_.AP.value = 0;
         }
      }
      
      public function get_AP(param1:Number) : Number
      {
         var _loc2_:Object = this["player" + param1];
         return _loc2_.AP.value;
      }
      
      public function set_resist1(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].resist1.value = param2;
      }
      
      public function set_resist2(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].resist2.value = param2;
      }
      
      public function set_resist3(param1:Number, param2:Number, param3:uint = 0) : void
      {
         var _loc4_:Object = this["player" + param1];
         if(param3 == 0)
         {
            param3 = uint(_loc4_.selectedMechID.value);
         }
         _loc4_[param3].resist3.value = param2;
      }
      
      public function get_resist1(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].resist1.value;
      }
      
      public function get_resist2(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].resist2.value;
      }
      
      public function get_resist3(param1:Number, param2:uint = 0) : Number
      {
         var _loc3_:Object = this["player" + param1];
         if(param2 == 0)
         {
            param2 = uint(_loc3_.selectedMechID.value);
         }
         return _loc3_[param2].resist3.value;
      }
      
      public function get_replayStatus(param1:Number) : BMReplayStatus
      {
         var _loc2_:BMReplayStatus = new BMReplayStatus();
         var _loc3_:uint = this.get_selectedMechID(param1);
         _loc2_.AP = this.get_AP(param1);
         _loc2_.HP = this.get_HP(param1,_loc3_);
         _loc2_.mechID = _loc3_;
         _loc2_.heat = this.get_heat(param1,_loc3_);
         _loc2_.energy = this.get_energy(param1,_loc3_);
         _loc2_.bullets = this.get_bullets(param1,_loc3_);
         _loc2_.rockets = this.get_rockets(param1,_loc3_);
         _loc2_.step = this.get_step(param1);
         _loc2_.shield = this.get_shieldActive(param1,_loc3_);
         _loc2_.drone = this.get_droneActive(param1,_loc3_);
         _loc2_.resist1 = this.get_resist1(param1,_loc3_);
         _loc2_.resist2 = this.get_resist2(param1,_loc3_);
         _loc2_.resist3 = this.get_resist3(param1,_loc3_);
         return _loc2_;
      }
   }
}

