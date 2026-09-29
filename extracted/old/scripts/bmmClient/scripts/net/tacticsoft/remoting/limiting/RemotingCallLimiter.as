package net.tacticsoft.remoting.limiting
{
   import net.tacticsoft.core.IDisposable;
   
   public class RemotingCallLimiter implements IDisposable
   {
      
      private var callsInProgress:Array;
      
      public function RemotingCallLimiter()
      {
         super();
         this.callsInProgress = [];
      }
      
      public function lockCall(param1:String) : void
      {
         this.callsInProgress[param1] = true;
      }
      
      public function releaseCall(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         this.callsInProgress[param1] = false;
      }
      
      public function canExecute(param1:String) : Boolean
      {
         return !this.callsInProgress[param1];
      }
      
      public function releaseAllCalls() : void
      {
         this.callsInProgress = [];
      }
      
      public function dispose() : void
      {
         this.releaseAllCalls();
         this.callsInProgress = null;
      }
   }
}

