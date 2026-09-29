package net.battleMechsMulti.screens
{
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMBaseScreen extends BMBaseClass
   {
      
      private var _isInteractive:Boolean;
      
      public function BMBaseScreen()
      {
         super();
         this._isInteractive = true;
      }
      
      public function set isInteractive(param1:Boolean) : void
      {
         this._isInteractive = param1;
      }
      
      public function get isInteractive() : Boolean
      {
         return this._isInteractive;
      }
      
      public function notifyClientDataReloaded() : *
      {
      }
   }
}

