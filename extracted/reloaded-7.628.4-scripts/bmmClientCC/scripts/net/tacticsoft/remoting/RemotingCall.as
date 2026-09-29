package net.tacticsoft.remoting
{
   import flash.events.EventDispatcher;
   import flash.net.Responder;
   import flash.utils.*;
   import net.tacticsoft.remoting.events.*;
   import net.tacticsoft.remoting.limiting.RemotingCallLimiter;
   import net.tacticsoft.utils.cache.ICacheStore;
   
   public class RemotingCall extends EventDispatcher
   {
      
      private var remotingService:RemotingService;
      
      private var operation:String;
      
      private var result:Function;
      
      private var fault:Function;
      
      private var args:Array;
      
      private var attempt:uint = 0;
      
      private var timeoutInt:Number;
      
      private var completed:Boolean = false;
      
      private var callTimeout:int;
      
      private var method:String;
      
      public var remotingCache:ICacheStore;
      
      public var remotingLimiter:RemotingCallLimiter;
      
      private var maxRetries:int;
      
      private var returnArgs:Boolean;
      
      public function RemotingCall(param1:RemotingService, param2:String, param3:Function, param4:Function, param5:Array, param6:Boolean, param7:int = 30000, param8:int = 3)
      {
         super();
         if(!param1)
         {
            throw new ArgumentError("The RemotingService supplied to the remoting call was null.");
         }
         if(!param2 || param2 == "")
         {
            throw new ArgumentError("The method cannot be null or empty");
         }
         this.remotingService = param1;
         this.method = param2;
         this.args = param5;
         this.result = param3;
         this.returnArgs = param6;
         this.fault = param4;
         this.maxRetries = param8;
         this.callTimeout = param7;
         this.operation = param1.service + "." + param2;
      }
      
      private function onResult(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:ResultEvent = null;
         if(!this.completed)
         {
            this.completed = true;
            this.clearIntervals();
            _loc2_ = this.getUniqueIdentifier();
            if(this.remotingLimiter)
            {
               this.remotingLimiter.releaseCall(_loc2_);
            }
            if(this.remotingCache)
            {
               this.remotingCache.cacheObject(_loc2_,param1);
            }
            _loc3_ = new ResultEvent(param1,false,true);
            if(this.returnArgs)
            {
               this.result(_loc3_,this.args);
            }
            else
            {
               this.result(_loc3_);
            }
         }
      }
      
      private function onFault(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:FaultEvent = null;
         if(!this.completed)
         {
            _loc2_ = this.getUniqueIdentifier();
            if(this.remotingLimiter)
            {
               this.remotingLimiter.releaseCall(_loc2_);
            }
            if(this.remotingCache)
            {
               this.remotingCache.purgeItem(_loc2_);
            }
            this.completed = true;
            this.clearIntervals();
            _loc3_ = new FaultEvent(param1,false,true);
            if(this.returnArgs)
            {
               this.fault(_loc3_,this.args);
            }
            else
            {
               this.fault(_loc3_);
            }
         }
      }
      
      public function execute() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:Responder = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:CallEvent = null;
         var _loc7_:ResultEvent = null;
         if(!this.completed)
         {
            _loc1_ = this.getUniqueIdentifier();
            if(Boolean(this.remotingCache) && this.remotingCache.isCached(_loc1_))
            {
               if(this.remotingLimiter)
               {
                  this.remotingLimiter.releaseCall(_loc1_);
               }
               this.completed = true;
               this.clearIntervals();
               _loc7_ = new ResultEvent(this.remotingCache.getCachedObject(_loc1_),false,true);
               if(this.returnArgs)
               {
                  this.result(_loc7_,this.args);
               }
               else
               {
                  this.result(_loc7_);
               }
               return;
            }
            _loc2_ = this.remotingService.service + "." + this.method;
            _loc3_ = new Responder(this.onResult,this.onFault);
            _loc4_ = _loc2_.split(".");
            if(_loc4_[_loc4_.length - 2] == "PageAbleResult")
            {
               _loc2_ = _loc4_[_loc4_.length - 2] + "." + _loc4_[_loc4_.length - 1];
            }
            _loc5_ = new Array(_loc2_,_loc3_);
            if(this.attempt == 0)
            {
               if(this.maxRetries > 0)
               {
                  if(this.callTimeout)
                  {
                     this.timeoutInt = setInterval(this.handleTimeout,this.callTimeout);
                  }
               }
               else
               {
                  this.maxRetries = 0;
               }
            }
            this.remotingService.remotingConnection.connection.call.apply(null,_loc5_.concat(this.args));
            _loc6_ = new CallEvent(CallEvent.REQUEST_SENT,false,false);
            _loc6_.args = this.args;
            _loc6_.connection = this.remotingService.remotingConnection;
            _loc6_.service = this.remotingService;
            _loc6_.method = this.method;
            dispatchEvent(_loc6_);
            ++this.attempt;
            if(this.remotingLimiter)
            {
               this.remotingLimiter.lockCall(this.getUniqueIdentifier());
            }
         }
      }
      
      private function handleTimeout() : void
      {
         var _loc1_:CallEvent = null;
         if(!this.completed)
         {
            if(this.attempt > this.maxRetries)
            {
               this.completed = true;
               this.clearIntervals();
               if(this.remotingLimiter)
               {
                  this.remotingLimiter.releaseCall(this.getUniqueIdentifier());
               }
               _loc1_ = new CallEvent(CallEvent.TIMEOUT,true,false);
               _loc1_.connection = this.remotingService.remotingConnection;
               _loc1_.service = this.remotingService;
               _loc1_.method = this.method;
               _loc1_.args = this.args;
               _loc1_.rawData = null;
               dispatchEvent(_loc1_);
               this.execute();
            }
            else
            {
               _loc1_ = new CallEvent(CallEvent.RETRY,true,false);
               _loc1_.connection = this.remotingService.remotingConnection;
               _loc1_.service = this.remotingService;
               _loc1_.method = this.method;
               _loc1_.args = this.args;
               _loc1_.rawData = null;
               dispatchEvent(_loc1_);
               this.execute();
            }
         }
      }
      
      private function getUniqueIdentifier() : String
      {
         return this.remotingService.remotingConnection.gateway + this.remotingService.service + this.method + this.args.toString() as String;
      }
      
      private function clearIntervals() : void
      {
         clearInterval(this.timeoutInt);
         this.timeoutInt = 0;
      }
   }
}

