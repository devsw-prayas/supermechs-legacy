package net.tacticsoft.utils
{
   public class SafeInt
   {
      
      private static var saltVector:Vector.<int> = null;
      
      private static const NUM_SALT_ENTRIES:int = 128;
      
      private static const SALT_MASK:int = 127;
      
      private static var reportedEvent:Boolean = false;
      
      public static var eventHandler:Function = null;
      
      private var salt:int;
      
      private var val:int;
      
      private var mVal:int;
      
      public function SafeInt(param1:int = 0)
      {
         var _loc2_:int = 0;
         super();
         if(saltVector == null)
         {
            saltVector = new Vector.<int>(NUM_SALT_ENTRIES,true);
            _loc2_ = 0;
            while(_loc2_ < NUM_SALT_ENTRIES)
            {
               saltVector[_loc2_] = int(Math.random() * (1 << 30));
               _loc2_++;
            }
         }
         this.value = param1;
      }
      
      public function set value(param1:int) : *
      {
         this.salt = int(Math.random() * (1 << 30));
         this.val = param1 ^ saltVector[this.salt & SALT_MASK];
         this.mVal = param1;
      }
      
      public function get value() : int
      {
         var _loc1_:int = this.val ^ saltVector[this.salt & SALT_MASK];
         if(this.mVal != _loc1_)
         {
            if(!reportedEvent)
            {
               reportedEvent = true;
               if(eventHandler != null)
               {
                  eventHandler(_loc1_,this.mVal);
                  eventHandler = null;
               }
            }
         }
         return _loc1_;
      }
   }
}

