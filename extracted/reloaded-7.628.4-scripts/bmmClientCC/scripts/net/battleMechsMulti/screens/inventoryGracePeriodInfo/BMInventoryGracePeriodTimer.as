package net.battleMechsMulti.screens.inventoryGracePeriodInfo
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMCountdownTimerText;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   public class BMInventoryGracePeriodTimer extends BMBaseClass
   {
      
      public var txtTimer:TextField;
      
      public var btnDetails:BMBasicButton;
      
      public var mcStatus:MovieClip;
      
      private var _timer:Timer;
      
      private var _infoButtonCallback:Function;
      
      private var _twoLines:Boolean;
      
      public function BMInventoryGracePeriodTimer()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      public function activateTimer(param1:Boolean = false) : void
      {
         if(this.getTimeLeft() == 0)
         {
            this.removeMe();
            return;
         }
         if(this._timer != null)
         {
            return;
         }
         this._twoLines = param1;
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerTrigger);
         this._timer.start();
         this.refreshTimerText();
      }
      
      private function onTimerTrigger(param1:TimerEvent) : void
      {
         if(this.getTimeLeft() == 0)
         {
            this.removeMe();
            return;
         }
         this.refreshTimerText();
      }
      
      private function stopTimer() : void
      {
         if(this._timer != null)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimerTrigger);
            this._timer = null;
         }
      }
      
      private function refreshTimerText() : void
      {
         var _loc1_:String = BMCountdownTimerText.getCountdownTimerText(this.getTimeLeft());
         var _loc2_:String = BMLanguageManager.getInstance().getText("migration_inventoryLimitGracePeriodTimerPrefix") + _loc1_;
         updateTextAndFormat(this.txtTimer,_loc2_);
         if(this._twoLines)
         {
            if(this.txtTimer.numLines == 1)
            {
               _loc1_ = "<BR>" + _loc1_;
               _loc2_ = BMLanguageManager.getInstance().getText("migration_inventoryLimitGracePeriodTimerPrefix") + _loc1_;
               updateTextAndFormat(this.txtTimer,_loc2_);
            }
         }
      }
      
      private function getTimeLeft() : uint
      {
         var _loc1_:Number = BMDataManager.getInstance().myProfile.inventorySizeState.gracePeriodFinishTime - BMDataManager.getInstance().currentTime;
         if(_loc1_ < 0)
         {
            return 0;
         }
         return _loc1_;
      }
      
      public function activateInfoButton(param1:Function) : void
      {
         if(this.btnDetails == null)
         {
            return;
         }
         this._infoButtonCallback = param1;
         this.btnDetails.addEventListener(BMIntractable.HIT,this.detailsHit);
      }
      
      private function detailsHit(param1:Event) : void
      {
         this._infoButtonCallback();
      }
      
      public function activateStatus() : void
      {
         if(this.mcStatus == null)
         {
            return;
         }
         var _loc1_:uint = BMDataManager.getInstance().myPlayerData.items.length;
         var _loc2_:uint = uint(BMDataManager.getInstance().myProfile.inventorySizeState.maxSize);
         if(_loc1_ > _loc2_)
         {
            this.mcStatus.gotoAndStop("bad");
         }
         else
         {
            this.mcStatus.gotoAndStop("good");
         }
      }
      
      public function isActive() : Boolean
      {
         return visible;
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.stopTimer();
      }
      
      private function removeMe() : void
      {
         visible = false;
         this.stopTimer();
      }
   }
}

