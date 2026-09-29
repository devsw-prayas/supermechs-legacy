package net.battleMechsMulti.mobiles
{
   public class BMQuestStatusUpdateData
   {
      
      public var title:String;
      
      public var body:String;
      
      public var isCompleted:Boolean;
      
      public var lastProgress:uint;
      
      public var currentProgress:uint;
      
      public var progressRequired:uint;
      
      public var isKin:Boolean = false;
      
      public function BMQuestStatusUpdateData()
      {
         super();
      }
   }
}

