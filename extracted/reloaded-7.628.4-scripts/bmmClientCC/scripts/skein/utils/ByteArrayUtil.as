package skein.utils
{
   import flash.utils.ByteArray;
   
   public class ByteArrayUtil
   {
      
      public function ByteArrayUtil()
      {
         super();
      }
      
      public static function compare(param1:ByteArray, param2:ByteArray) : Boolean
      {
         if(param1 == null && param2 == null)
         {
            return true;
         }
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(param1.length != param2.length)
         {
            return false;
         }
         while(param1.bytesAvailable)
         {
            if(!compareBytes(param1,param2,32))
            {
               return false;
            }
         }
         return true;
      }
      
      private static function compareBytes(param1:ByteArray, param2:ByteArray, param3:int) : Boolean
      {
         var _loc4_:String = param1.readUTFBytes(Math.max(param1.bytesAvailable,param3));
         var _loc5_:String = param2.readUTFBytes(Math.max(param2.bytesAvailable,param3));
         return _loc4_ == _loc5_;
      }
   }
}

