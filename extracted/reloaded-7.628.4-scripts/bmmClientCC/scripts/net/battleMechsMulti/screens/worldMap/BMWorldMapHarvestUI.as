package net.battleMechsMulti.screens.worldMap
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.utils.TimeUtils;
   
   public class BMWorldMapHarvestUI extends BMMovieClip
   {
      
      private static const MISSION_SLOT_EMPTY:Number = -1;
      
      public var txtTimer:TextField;
      
      public var txtClaim:TextField;
      
      public var bar:BMRoundBar;
      
      public var mcClaimBackground:Sprite;
      
      public var mcClaimHitArea:Sprite;
      
      private var _timeTotal:uint;
      
      private var _timeLeft:uint;
      
      private var _clickFunction:Function;
      
      private var _timer:Timer;
      
      private var _missionSlot:Number = -1;
      
      private var _hitAreaDisabled:Boolean = false;
      
      public function BMWorldMapHarvestUI()
      {
         super();
         this.bar.showEmptyCover();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.mcClaimHitArea.addEventListener(MouseEvent.CLICK,this.claimHitAreaClicked);
      }
      
      public function initialize(param1:uint, param2:String) : void
      {
         this._missionSlot = param1;
         updateTextAndFormat(this.txtClaim,param2);
      }
      
      public function activateTimer(param1:uint, param2:uint, param3:Function) : void
      {
         if(this._missionSlot == MISSION_SLOT_EMPTY)
         {
            throw new Error("BMWorldMapHarvestUI must run initialize beofre activateTimer");
         }
         var _loc4_:uint = 0;
         if(param2 > 0)
         {
            _loc4_ = 2;
         }
         this._timeTotal = param1 + _loc4_;
         this._timeLeft = param2 + _loc4_;
         this._clickFunction = param3;
         this.bar.hideEmptyCover();
         this.hideClaimButton();
         this.refreshBar();
         this.refreshText();
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerTrigger);
         this._timer.start();
         this._hitAreaDisabled = false;
      }
      
      private function showClaimButton() : void
      {
         if(this.mcClaimBackground.visible)
         {
            return;
         }
         this.txtClaim.visible = true;
         this.mcClaimBackground.visible = true;
         this.txtTimer.visible = false;
      }
      
      private function hideClaimButton() : void
      {
         this.txtClaim.visible = false;
         this.mcClaimBackground.visible = false;
         this.txtTimer.visible = true;
      }
      
      private function onTimerTrigger(param1:TimerEvent) : void
      {
         if(this._timeLeft == 0)
         {
            this.removeTimer();
            this.showClaimButton();
         }
         else
         {
            --this._timeLeft;
            if(this._timeLeft == 0)
            {
               this._hitAreaDisabled = false;
            }
         }
         this.refreshBar();
         this.refreshText();
      }
      
      public function get missionSlot() : Number
      {
         return this._missionSlot;
      }
      
      private function refreshText() : void
      {
         updateTextAndFormat(this.txtTimer,TimeUtils.formatTimeLeftWithDays(this._timeLeft));
      }
      
      private function refreshBar() : void
      {
         var _loc1_:Number = (this._timeTotal - this._timeLeft) / this._timeTotal;
         this.bar.fillBar(_loc1_);
      }
      
      private function removeTimer() : void
      {
         if(this._timer == null)
         {
            return;
         }
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimerTrigger);
         this._timer = null;
      }
      
      private function claimHitAreaClicked(param1:MouseEvent) : void
      {
         this.claimHitAreaClickedSub();
      }
      
      public function claimHitAreaClickedSub() : void
      {
         if(this._hitAreaDisabled)
         {
            return;
         }
         if(this._timeLeft == 0)
         {
            this._clickFunction(this.missionSlot);
            this._hitAreaDisabled = true;
            this.removeTimer();
         }
      }
      
      public function removeMe() : void
      {
         this.mcClaimHitArea.removeEventListener(MouseEvent.CLICK,this.claimHitAreaClicked);
         this.removeTimer();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeMe();
      }
   }
}

