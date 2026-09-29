package skein.rest.core.coding
{
   import flash.utils.ByteArray;
   
   public class MultipartFormCoding
   {
      
      private static const MULTIPART_CHARS:String = "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
      
      public function MultipartFormCoding()
      {
         super();
      }
      
      public static function encode(param1:Object, param2:Function) : void
      {
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:String = "utf-8";
         var _loc3_:String = generateBoundary();
         if("toJSON" in param1)
         {
            param1 = param1.toJSON(undefined);
         }
         for(var _loc4_:String in param1)
         {
            writeString(_loc5_,"--" + _loc3_ + "\r\n" + "Content-Disposition: form-data; name=\"" + _loc4_ + "\"\r\n\r\n",_loc6_);
            writeString(_loc5_,param1[_loc4_] || "",_loc6_);
            writeString(_loc5_,"\r\n");
         }
         writeString(_loc5_,"--" + _loc3_ + "--\r\n");
         if(param2.length == 2)
         {
            param2(_loc5_,"multipart/form-data; boundary=" + _loc3_);
         }
         else
         {
            param2(_loc5_);
         }
      }
      
      private static function writeString(param1:ByteArray, param2:String, param3:String = "ascii") : void
      {
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeMultiByte(param2,param3);
         param1.writeBytes(_loc4_,0,_loc4_.length);
      }
      
      private static function generateBoundary() : String
      {
         var _loc3_:int = 0;
         var _loc1_:String = "";
         var _loc2_:int = int(Math.random() * 11) + 30;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ += "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".charAt(int(Math.random() * "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".length));
            _loc3_++;
         }
         return _loc1_;
      }
   }
}

