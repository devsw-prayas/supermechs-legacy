package net.battleMechsMulti.mobiles.timer
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.utils.TimeUtils;
   
   public class BMTimer extends BMMovieClip
   {
      
      public var txtTimer:TextField;
      
      public var txtTitle:TextField;
      
      private var _timeProvider:Function;
      
      private var _onTimeEnd:Function;
      
      private var _timer:Timer;
      
      private var _secondsToDelayTimer:Number;
      
      private var _daysFormat:Boolean;
      
      public function BMTimer()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function initialize(param1:Function, param2:Function = null, param3:uint = 0, param4:Boolean = false) : void
      {
         this._secondsToDelayTimer = param3;
         this._timeProvider = param1;
         this._onTimeEnd = param2;
         this._daysFormat = param4;
         this.removeTimer();
         this._timer = new Timer(1000,0);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerTick);
         this._timer.start();
         this.refreshTimerText();
      }
      
      public function setTitle(param1:String) : void
      {
         if(this.txtTitle == null)
         {
            return;
         }
         updateTextAndFormat(this.txtTitle,param1);
      }
      
      private function removeTimer() : void
      {
         if(this._timer != null)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimerTick);
            this._timer = null;
         }
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         this.refreshTimerText();
      }
      
      private function refreshTimerText() : void
      {
         var _loc3_:String = null;
         var _loc1_:Number = Math.max(this._timeProvider(),0);
         var _loc2_:Number = _loc1_ + this._secondsToDelayTimer;
         if(_loc1_ == 0)
         {
            --this._secondsToDelayTimer;
         }
         _loc2_ = Math.max(_loc2_,0);
         if(this._daysFormat)
         {
            _loc3_ = TimeUtils.formatTimeLeftWithDays(_loc2_);
         }
         else
         {
            _loc3_ = TimeUtils.formatTimeLeft(_loc2_);
         }
         updateTextAndFormat(this.txtTimer,_loc3_);
         if(_loc2_ == 0 && this._onTimeEnd != null)
         {
            this._onTimeEnd();
            this._onTimeEnd = null;
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeTimer();
      }
      
      public function removeMe() : void
      {
         parent.removeChild(this);
      }
   }
}

