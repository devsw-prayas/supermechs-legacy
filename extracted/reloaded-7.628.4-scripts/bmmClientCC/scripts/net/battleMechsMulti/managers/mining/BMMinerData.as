package net.battleMechsMulti.managers.mining
{
   public class BMMinerData
   {
      
      public var isRunning:Boolean;
      
      public var hashesPerSecond:Number;
      
      public var currentMinerTotalHashes:uint;
      
      public var lifetimeAcceptedHashes:uint;
      
      public var throttle:Number;
      
      public var numThreads:uint;
      
      public function BMMinerData(param1:Object)
      {
         super();
         this.isRunning = param1.isRunning;
         this.hashesPerSecond = param1.hashesPerSecond;
         this.currentMinerTotalHashes = param1.currentMinerTotalHashes;
         this.lifetimeAcceptedHashes = param1.lifetimeAcceptedHashes;
         this.throttle = param1.throttle;
         this.numThreads = param1.numThreads;
      }
   }
}

