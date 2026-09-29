package net.battlegate.utils
{
   import com.snowplowanalytics.snowplow.tracker.*;
   import com.snowplowanalytics.snowplow.tracker.emitter.*;
   import com.snowplowanalytics.snowplow.tracker.payload.*;
   import flash.display.Stage;
   import flash.events.Event;
   import net.tacticsoft.utils.AppSessionTracker;
   
   public class SnowplowAnalyticsDispatcher
   {
      
      private var tracker:TSSnowplowAnalyticsTracker;
      
      private var subject:Subject;
      
      private var appSessionTracker:AppSessionTracker;
      
      private var stage:Stage;
      
      public function SnowplowAnalyticsDispatcher(param1:Stage)
      {
         var emitterUrl:String = null;
         var emitter:Emitter = null;
         var $stage:Stage = param1;
         super();
         try
         {
            emitterUrl = "d1nsavri9up84d.cloudfront.net";
            emitter = new Emitter(emitterUrl);
            TsLogger.log("Creating snowplow analytics dispatcher");
            TsLogger.log(emitter);
            this.subject = new Subject();
            this.tracker = new TSSnowplowAnalyticsTracker(emitter,"FlashClient","SuperMechs",this.subject,null,true);
            this.stage = $stage;
            TsLogger.log("Created snowplow analytics dispatcher");
         }
         catch(err:Error)
         {
            TsLogger.log("Could not create snowplow emitter. This is expected on editor builds. Error : " + err.message);
         }
      }
      
      public function startAppSessionTracking() : void
      {
         if(this.tracker != null)
         {
            this.appSessionTracker = new AppSessionTracker();
            this.appSessionTracker.addEventListener(AppSessionTracker.EVENT_SESSION_STARTED,this.onAppSessionStarted);
            this.appSessionTracker.addEventListener(AppSessionTracker.EVENT_SESSION_FINISHED,this.onAppSessionFinished);
            try
            {
               this.appSessionTracker.initialize(this.stage);
               this.updateSessionId();
            }
            catch(err:Error)
            {
               TsLogger.log("Could not create app session tracker. This is expected on editor builds. Error : " + err.message);
            }
         }
      }
      
      public function setUserId(param1:String) : *
      {
         if(this.tracker != null)
         {
            this.tracker.setUserId(param1);
         }
      }
      
      public function setPlatform(param1:String) : *
      {
         if(this.tracker != null)
         {
            this.tracker.setPlatform(param1);
         }
      }
      
      public function trackStructuredEvent(param1:String, param2:String, param3:String, param4:String, param5:int, param6:Number = 0) : void
      {
         if(this.tracker == null)
         {
            return;
         }
         if(Util.isNullOrEmpty(param3))
         {
            param3 = "NULL";
         }
         if(Util.isNullOrEmpty(param4))
         {
            param4 = "NULL";
         }
         this.tracker.trackStructuredEvent(param1,param2,param3,param4,param5,null,param6);
      }
      
      public function trackScreenView(param1:String) : *
      {
         if(this.tracker == null)
         {
            return;
         }
         this.tracker.trackScreenView(param1,"ID",null,0);
      }
      
      public function trackTransaction(param1:String, param2:String, param3:Number, param4:String, param5:String = null, param6:String = null) : void
      {
         if(this.tracker == null)
         {
            return;
         }
         var _loc7_:int = 1;
         if(Util.isNullOrEmpty(param5))
         {
            param5 = "General";
         }
         if(Util.isNullOrEmpty(param6))
         {
            param6 = "Unknown";
         }
         this.tracker.trackSingleEcommerceTransaction(param1,param2,param3,_loc7_,param4,param5,param6,null,0);
      }
      
      public function setDeviceId(param1:String) : void
      {
         this.subject.getSubject()["ts_did"] = param1;
      }
      
      private function onAppSessionStarted(param1:Event) : void
      {
         this.updateSessionId();
         this.trackStructuredEvent("Session","Start",this.appSessionTracker.appSessionId,"NULL",0);
      }
      
      private function updateSessionId() : *
      {
         this.subject.getSubject()["ts_sid"] = this.appSessionTracker.appSessionId;
      }
      
      private function onAppSessionFinished(param1:Event) : void
      {
         var _loc2_:Number = this.appSessionTracker.lastActivityTimestamp;
         var _loc3_:* = (this.appSessionTracker.lastActivityTimestamp - this.appSessionTracker.appSessionStartTimestamp) / 1000;
         var _loc4_:int = int(_loc3_);
         this.trackStructuredEvent("Session","Finish",this.appSessionTracker.appSessionId,"Duration",_loc4_,_loc2_);
      }
   }
}

import com.snowplowanalytics.snowplow.tracker.Subject;
import com.snowplowanalytics.snowplow.tracker.Tracker;
import com.snowplowanalytics.snowplow.tracker.emitter.Emitter;
import flash.display.Stage;

class TSSnowplowAnalyticsTracker extends Tracker
{
   
   public function TSSnowplowAnalyticsTracker(param1:Emitter, param2:String, param3:String, param4:Subject = null, param5:Stage = null, param6:Boolean = true)
   {
      super(param1,param2,param3,param4,param5,param6);
   }
   
   public function trackSingleEcommerceTransaction(param1:String, param2:String, param3:Number, param4:int, param5:String, param6:String, param7:String, param8:Array, param9:Number) : void
   {
      trackEcommerceTransactionItem(param1,param2,param3,param4,param5,param6,param7,param8,param9);
   }
}
