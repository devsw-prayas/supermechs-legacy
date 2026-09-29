package net.tacticsoft.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.net.SharedObject;
   
   public class AppSessionTracker extends EventDispatcher
   {
      
      private static const SESSION_TIMEOUT_SECONDS:int = 300;
      
      public static const EVENT_SESSION_STARTED:String = "AppSessionStarted";
      
      public static const EVENT_SESSION_FINISHED:String = "AppSessionFinished";
      
      private var appSessionSO:SharedObject;
      
      public function AppSessionTracker()
      {
         super();
         this.appSessionSO = SharedObject.getLocal("AppSessionTracker");
      }
      
      public function initialize(param1:EventDispatcher) : *
      {
         this.initializeListeners(param1);
         this.handleActivityDetected();
      }
      
      private function initializeListeners(param1:EventDispatcher) : void
      {
         param1.addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      private function onMouseClick(param1:Event) : void
      {
         this.handleActivityDetected();
      }
      
      private function handleActivityDetected() : void
      {
         var _loc4_:Boolean = false;
         var _loc1_:Number = new Date().time;
         var _loc2_:Number = this.lastActivityTimestamp;
         var _loc3_:* = (_loc1_ - _loc2_) / 1000;
         if(_loc3_ > SESSION_TIMEOUT_SECONDS)
         {
            _loc4_ = this.appSessionId != null;
            if(_loc4_)
            {
               this.dispatchSessionFinishedEvent();
            }
            this.startNewSession(_loc1_);
         }
         this.lastActivityTimestamp = _loc1_;
         this.appSessionSO.flush();
      }
      
      private function startNewSession(param1:Number) : void
      {
         this.appSessionId = RandomUtils.generateRandomString(12);
         this.appSessionStartTimestamp = param1;
         dispatchEvent(new Event(EVENT_SESSION_STARTED));
      }
      
      private function dispatchSessionFinishedEvent() : void
      {
         dispatchEvent(new Event(EVENT_SESSION_FINISHED));
      }
      
      public function get appSessionId() : String
      {
         return this.appSessionSO.data.sessionId;
      }
      
      public function set appSessionId(param1:String) : void
      {
         this.appSessionSO.data.sessionId = param1;
      }
      
      public function get appSessionStartTimestamp() : Number
      {
         return this.appSessionSO.data.sessionStartTime;
      }
      
      public function set appSessionStartTimestamp(param1:Number) : void
      {
         this.appSessionSO.data.sessionStartTime = param1;
      }
      
      public function get lastActivityTimestamp() : Number
      {
         if(this.appSessionSO.data.lastActivityTime == null)
         {
            return 0;
         }
         return this.appSessionSO.data.lastActivityTime;
      }
      
      public function set lastActivityTimestamp(param1:Number) : void
      {
         this.appSessionSO.data.lastActivityTime = param1;
      }
   }
}

