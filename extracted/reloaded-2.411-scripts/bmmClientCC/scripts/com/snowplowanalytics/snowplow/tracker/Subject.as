package com.snowplowanalytics.snowplow.tracker
{
   public class Subject
   {
      
      private var standardPairs:Object;
      
      public function Subject()
      {
         super();
         standardPairs = {};
         var _loc1_:Number = new Date().getTimezoneOffset();
         var _loc2_:String = "Etc/UTC" + (_loc1_ < 0 ? "" : "+") + Util.padZeroes(Math.floor(_loc1_ / 60)) + ":" + Util.padZeroes(_loc1_ % 60);
         this.setTimezone(_loc2_);
      }
      
      public function setLanguage(param1:String) : void
      {
         this.standardPairs[Parameter.LANGUAGE] = param1;
      }
      
      public function getSubject() : Object
      {
         return this.standardPairs;
      }
      
      public function setViewPort(param1:int, param2:int) : void
      {
         var _loc3_:String = param1 + "x" + param2;
         this.standardPairs[Parameter.VIEWPORT] = _loc3_;
      }
      
      public function setColorDepth(param1:int) : void
      {
         this.standardPairs[Parameter.COLOR_DEPTH] = param1;
      }
      
      public function setScreenResolution(param1:int, param2:int) : void
      {
         var _loc3_:String = param1 + "x" + param2;
         this.standardPairs[Parameter.RESOLUTION] = _loc3_;
      }
      
      public function setTimezone(param1:String) : void
      {
         this.standardPairs[Parameter.TIMEZONE] = param1;
      }
      
      public function setUserId(param1:String) : void
      {
         this.standardPairs[Parameter.UID] = param1;
      }
   }
}

