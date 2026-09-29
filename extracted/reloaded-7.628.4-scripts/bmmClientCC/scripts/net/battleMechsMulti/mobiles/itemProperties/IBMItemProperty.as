package net.battleMechsMulti.mobiles.itemProperties
{
   public interface IBMItemProperty
   {
      
      function initNameOnly(param1:String) : void;
      
      function init(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false) : void;
   }
}

