package net.battleMechsMulti.mobiles.buttons
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class BMIntractable extends MovieClip
   {
      
      public static const UP:String = "UP";
      
      public static const DOWN:String = "DOWN";
      
      public static const HIT:String = "HIT";
      
      private var _enabled:Boolean = true;
      
      public function BMIntractable()
      {
         super();
         addEventListener(MouseEvent.CLICK,this.onClick);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         addEventListener(MouseEvent.MOUSE_UP,this.onUp);
      }
      
      public function disableMe() : void
      {
         this._enabled = false;
         this.onDisableMe();
      }
      
      protected function onDisableMe() : void
      {
      }
      
      public function enableMe() : void
      {
         this._enabled = true;
         this.onEnableMe();
      }
      
      protected function onEnableMe() : void
      {
      }
      
      private function onUp(param1:MouseEvent) : void
      {
         if(this._enabled)
         {
            dispatchEvent(new Event(UP));
         }
      }
      
      public function isEnabled() : Boolean
      {
         return this._enabled;
      }
      
      private function onDown(param1:MouseEvent) : void
      {
         if(this._enabled)
         {
            dispatchEvent(new Event(DOWN));
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(this._enabled)
         {
            dispatchEvent(new Event(HIT));
         }
      }
   }
}

