package net.tacticsoft.remoting.events
{
   import flash.events.Event;
   
   public class ResultEvent extends Event
   {
      
      public static const RESULT:String = "result";
      
      public var result:Object;
      
      public function ResultEvent(param1:Object, param2:Boolean, param3:Boolean)
      {
         super(ResultEvent.RESULT,param2,param3);
         this.result = param1;
      }
   }
}

