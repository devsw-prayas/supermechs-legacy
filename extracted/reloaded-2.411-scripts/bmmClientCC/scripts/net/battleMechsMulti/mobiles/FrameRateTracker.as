package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.system.*;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class FrameRateTracker extends MovieClip
   {
      
      private var time:int;
      
      private var prevTime:int = 0;
      
      private var fps:int;
      
      private var avg_fps:int;
      
      private var max_fps:int = 0;
      
      private var min_fps:int = 99999;
      
      private var total_fps:int;
      
      private var total_frames:int;
      
      private var mem:int;
      
      private var avg_mem:int;
      
      private var total_mem:int;
      
      private var fps_txt:TextField;
      
      private var mem_txt:TextField;
      
      private var max_frames:int;
      
      private var timerHolder:Timer;
      
      private var _seconds:Number = 0;
      
      private var _frames:Number = 0;
      
      private var _last15SecondsTracker:Array = new Array();
      
      public var FPS:Number = 30;
      
      public function FrameRateTracker()
      {
         super();
         this.max_frames = 200;
         this.fps_txt = new TextField();
         this.fps_txt.width = 200;
         this.fps_txt.textColor = 16711680;
         addChild(this.fps_txt);
         this.mem_txt = new TextField();
         this.mem_txt.textColor = 16711680;
         this.mem_txt.width = 200;
         this.mem_txt.y = 20;
         addChild(this.mem_txt);
         addEventListener(Event.ENTER_FRAME,this.getFps);
         this.timerHolder = new Timer(1000,0);
         this.timerHolder.start();
         this.timerHolder.addEventListener(TimerEvent.TIMER,this.timerEventTrigger);
      }
      
      private function timerEventTrigger(param1:TimerEvent) : void
      {
         ++this._seconds;
         this._last15SecondsTracker.push(this._frames);
         this._frames = 0;
         var _loc2_:Number = 15;
         if(this._last15SecondsTracker.length >= _loc2_)
         {
            this._last15SecondsTracker.splice(0,1);
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         while(_loc4_ < this._last15SecondsTracker.length)
         {
            _loc3_ += this._last15SecondsTracker[_loc4_];
            _loc4_++;
         }
         this.FPS = Math.ceil(_loc3_ / this._last15SecondsTracker.length);
      }
      
      private function getFps(param1:Event) : void
      {
         ++this._frames;
         ++this.total_frames;
         this.time = getTimer();
         this.fps = 1000 / (this.time - this.prevTime);
         if(this.max_fps < this.fps)
         {
            this.max_fps = this.fps;
         }
         if(this.min_fps > this.fps)
         {
            this.min_fps = this.fps;
         }
         this.total_fps += this.fps;
         this.avg_fps = this.total_fps / this.total_frames;
         this.fps_txt.text = "FPS/AVG: " + this.fps + " / " + this.avg_fps;
         this.prevTime = getTimer();
         this.mem = Number(System.totalMemory / 1024);
         this.total_mem += this.mem;
         this.avg_mem = this.total_mem / this.total_frames;
         this.mem_txt.text = "MEM/AVG: " + this.mem.toFixed(0) + "Kb / " + this.avg_mem.toFixed(0) + "Kb";
         if(this.total_frames > this.max_frames)
         {
            this.total_frames = 0;
            this.total_mem = 0;
            this.total_fps = 0;
         }
      }
      
      public function resetMinAndMaxFPS() : void
      {
         this.min_fps = 9999;
         this.max_fps = 0;
      }
      
      public function resetAVG() : void
      {
         this.total_frames = 0;
         this.total_mem = 0;
         this.total_fps = 0;
      }
      
      public function resetFPS() : void
      {
         this.resetMinAndMaxFPS();
         this.resetAVG();
      }
      
      public function getAverageFPS() : Number
      {
         return this.avg_fps;
      }
      
      public function getMaxFPS() : Number
      {
         return this.max_fps;
      }
      
      public function getMinFPS() : Number
      {
         return this.min_fps;
      }
   }
}

