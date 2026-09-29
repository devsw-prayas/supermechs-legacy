package net.tacticsoft.responders.events
{
   import flash.events.Event;
   
   public class ExternalLoginConflictEvent extends Event
   {
      
      public var currentPlayer:ExternalLoginConflictUser = new ExternalLoginConflictUser();
      
      public var newPlayer:ExternalLoginConflictUser = new ExternalLoginConflictUser();
      
      public function ExternalLoginConflictEvent()
      {
         super(ExternalSessionEvents.EXTERNAL_LOGIN_CONFLICT);
      }
      
      override public function clone() : Event
      {
         var _loc1_:ExternalLoginConflictEvent = new ExternalLoginConflictEvent();
         _loc1_.currentPlayer = this.currentPlayer.clone();
         _loc1_.newPlayer = this.newPlayer.clone();
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("ExternalLoginConflictEvent","currentPlayer","newPlayer");
      }
   }
}

