package net.battleMechsMulti.mobiles.buttons
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class BMIntractable extends BMMovieClip
   {
      
      public static const UP:String = "UP";
      
      public static const DOWN:String = "DOWN";
      
      public static const HIT:String = "HIT";
      
      private var _enabled:Boolean = true;
      
      private var _ignoreScreensDirectorTasks:Boolean = false;
      
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
      
      public function ignoreScreensDirectorTasks() : void
      {
         this._ignoreScreensDirectorTasks = true;
      }
      
      protected function onEnableMe() : void
      {
      }
      
      private function onUp(param1:MouseEvent) : void
      {
         if(this.isBlocked)
         {
            return;
         }
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
         if(this.isBlocked)
         {
            return;
         }
         if(this._enabled)
         {
            dispatchEvent(new Event(DOWN));
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(this.isBlocked)
         {
            return;
         }
         if(this._enabled == false)
         {
            return;
         }
         dispatchEvent(new Event(HIT));
      }
      
      public function injectClick() : void
      {
         this.onClick(null);
      }
      
      private function get isBlocked() : Boolean
      {
         return this.blockedByScreensDirectorTasks() || this.blockedByTutorial();
      }
      
      private function blockedByScreensDirectorTasks() : Boolean
      {
         if(this._ignoreScreensDirectorTasks)
         {
            return false;
         }
         if(BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return true;
         }
         return false;
      }
      
      private function blockedByTutorial() : Boolean
      {
         var _loc1_:BMTutorialManager = BMTutorialManager.gi();
         return !_loc1_.isAllowedToClickOnMovieClip(this);
      }
   }
}

