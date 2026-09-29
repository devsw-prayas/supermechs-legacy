package net.tacticsoft.responders.events
{
   public class ExternalLoginConflictUser
   {
      
      public var playerID:Number;
      
      public var name:String;
      
      public var level:int;
      
      public function ExternalLoginConflictUser()
      {
         super();
      }
      
      public function clone() : ExternalLoginConflictUser
      {
         var _loc1_:ExternalLoginConflictUser = new ExternalLoginConflictUser();
         _loc1_.playerID = this.playerID;
         _loc1_.name = this.name;
         _loc1_.level = this.level;
         return _loc1_;
      }
   }
}

