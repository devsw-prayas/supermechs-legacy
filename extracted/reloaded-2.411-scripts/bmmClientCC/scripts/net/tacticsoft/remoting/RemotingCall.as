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
         var unique:String = null;
         var operation:String = null;
         var responder:Responder = null;
         var operationPath:Array = null;
         var callArgs:Array = null;
         var rs:CallEvent = null;
         var re:ResultEvent = null;
         if(!this.completed)
         {
            unique = this.getUniqueIdentifier();
            if(Boolean(this.remotingCache) && this.remotingCache.isCached(unique))
            {
               if(this.remotingLimiter)
               {
                  this.remotingLimiter.releaseCall(unique);
               }
               this.completed = true;
               this.clearIntervals();
               re = new ResultEvent(this.remotingCache.getCachedObject(unique),false,true);
               if(this.returnArgs)
               {
                  this.result(re,this.args);
               }
               else
               {
                  this.result(re);
               }
               return;
            }
            operation = this.remotingService.service + "." + this.method;
            responder = new Responder(this.onResult,this.onFault);
            operationPath = operation.split(".");
            if(operationPath[operationPath.length - 2] == "PageAbleResult")
            {
               operation = operationPath[operationPath.length - 2] + "." + operationPath[operationPath.length - 1];
            }
            callArgs = new Array(operation,responder);
            if(this.attempt == 0)
            {
               if(this.maxRetries >= 0)
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
            try
            {
               this.remotingService.remotingConnection.connection.call.apply(null,callArgs.concat(this.args));
            }
            catch(err:Error)
            {
               TsLogger.log("RemotingCall :: err " + err.getStackTrace());
            }
            rs = new CallEvent(CallEvent.REQUEST_SENT,false,false);
            rs.args = this.args;
            rs.connection = this.remotingService.remotingConnection;
            rs.service = this.remotingService;
            rs.method = this.method;
            dispatchEvent(rs);
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
         var _loc2_:Object = null;
         if(!this.completed)
         {
            if(this.attempt > this.maxRetries)
            {
               _loc2_ = new Object();
               _loc2_.description = "Loading time out";
               _loc2_.code = "LOADING_TIME_OUT";
               this.clearIntervals();
               this.onFault(_loc2_);
               this.completed = true;
               if(this.remotingLimiter)
               {
                  this.remotingLimiter.releaseCall(this.getUniqueIdentifier());
               }
               _loc1_ = new CallEvent(CallEvent.TIMEOUT,true,false);
               _loc1_.connection = this.remotingService.remotingConnection;
               _loc1_.service = this.remotingService;
               _loc1_.method = this.method;
               _loc1_.args = this.args;
               _loc1_.rawData = _loc2_;
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

