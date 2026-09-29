package net.tacticsoft.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class PubSub
   {
      
      private var messages:Object = new Object();
      
      private var lastUid:Number = -1;
      
      public function PubSub()
      {
         super();
      }
      
      private function setTimeout(param1:Function, param2:Number = 0) : void
      {
         var t:Timer = null;
         var finish:* = undefined;
         var fn:Function = param1;
         var time:Number = param2;
         t = new Timer(time,1);
         finish = function():*
         {
            fn();
            t.removeEventListener(TimerEvent.TIMER_COMPLETE,finish);
         };
         t.addEventListener(TimerEvent.TIMER_COMPLETE,finish);
         t.start();
      }
      
      private function publish(param1:String, param2:Object) : Object
      {
         var deliverMessage:Function;
         var message:String = param1;
         var data:Object = param2;
         if(!this.messages[message])
         {
            return false;
         }
         deliverMessage = function():*
         {
            var subscribers:* = messages[message];
            var throwException:* = function(param1:*):*
            {
               var e:* = param1;
               return function():*
               {
                  throw e;
               };
            };
            var i:Number = subscribers.length - 1;
            while(i >= 0)
            {
               try
               {
                  subscribers[i]["fn"](message,data);
               }
               catch(e:*)
               {
                  TsLogger.log("Unable to publish message: " + e);
                  throwException(e);
                  setTimeout(function(param1:*):*
                  {
                     throwException(param1);
                  });
               }
               i--;
            }
         };
         this.setTimeout(deliverMessage);
         return true;
      }
      
      public function pub(param1:String, param2:Object) : Object
      {
         return this.publish(param1,param2);
      }
      
      public function emit(param1:String, param2:Object) : Object
      {
         return this.publish(param1,param2);
      }
      
      public function sub(param1:String, param2:Function) : Number
      {
         return this.on(param1,param2);
      }
      
      public function on(param1:String, param2:Function) : Number
      {
         if(!this.messages[param1])
         {
            this.messages[param1] = [];
         }
         var _loc3_:Object = new Object();
         ++this.lastUid;
         _loc3_["token"] = this.lastUid;
         _loc3_["fn"] = param2;
         this.messages[param1].push(_loc3_);
         return this.lastUid;
      }
      
      public function remove(param1:Number) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         for(_loc2_ in this.messages)
         {
            if(this.messages[_loc2_])
            {
               _loc3_ = 0;
               _loc4_ = this.messages[_loc2_].length;
               while(_loc3_ < _loc4_)
               {
                  if(this.messages[_loc2_][_loc3_]["token"] === param1)
                  {
                     return this.messages[_loc2_].splice(_loc3_,1);
                     break;
                  }
                  _loc3_++;
               }
            }
         }
         return false;
      }
   }
}

