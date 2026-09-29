package net.battleMechsMulti.screens.worldMap
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.utils.TimeUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1082")]
   public class BMWorldMapPortal extends BMBaseClass
   {
      
      public var mcSwirl:MovieClip;
      
      public var mcGlow:MovieClip;
      
      public var txtTimer:TextField;
      
      private var _resetTimer:Timer = null;
      
      private var _endDate:int;
      
      public function BMWorldMapPortal(param1:BMWorldMapLocationData)
      {
         super();
         generateSingletonClassesPointers("");
         TweenMax.to(this.mcSwirl.mcInner,10,{
            "rotation":-360,
            "repeat":-1,
            "ease":Linear.easeNone
         });
         TweenMax.to(this.mcGlow,5,{
            "alpha":0.6,
            "repeat":-1,
            "yoyo":true,
            "ease":Linear.easeNone
         });
         this._endDate = param1.endDate;
         this.startTimer();
      }
      
      private function startTimer() : *
      {
         this._resetTimer = new Timer(1000,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.onTimerEvent);
         this._resetTimer.start();
         this.refreshTimer();
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         this.refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:Number = this._endDate - dataM.currentTime;
         if(_loc1_ <= 0)
         {
            this.timeText = getSpecificText("missionWorldMap_portalClosing");
            this.stopTimer();
         }
         else
         {
            this.timeText = TimeUtils.formatTimeLeftWithDays(_loc1_);
         }
      }
      
      private function set timeText(param1:String) : void
      {
         this.txtTimer.text = param1;
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTimer,this);
         }
      }
      
      private function stopTimer() : void
      {
         if(this._resetTimer != null)
         {
            this._resetTimer.stop();
            this._resetTimer.removeEventListener(TimerEvent.TIMER,this.onTimerEvent);
            this._resetTimer = null;
         }
      }
   }
}

