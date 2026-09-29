package skein.rest.client.impl
{
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import skein.rest.core.Config;
   import skein.utils.ByteArrayUtil;
   
   public class URLLoadersQueue
   {
      
      private static var _serialNumber:int = 0;
      
      private static const queue:Array = [];
      
      private static const requests:Dictionary = new Dictionary();
      
      private static const serials:Dictionary = new Dictionary(true);
      
      public function URLLoadersQueue()
      {
         super();
      }
      
      public static function find(param1:URLRequest) : URLLoader
      {
         var _loc3_:int = 0;
         var _loc2_:URLLoader = null;
         if(!Config.sharedInstance().useQueue)
         {
            return null;
         }
         _loc3_ = int(queue.length);
         while(_loc3_ > 0)
         {
            _loc2_ = queue[_loc3_ - 1];
            if(compare(param1,requests[_loc2_]))
            {
               return _loc2_;
            }
            _loc3_--;
         }
         return null;
      }
      
      public static function keep(param1:URLRequest, param2:URLLoader) : void
      {
         if(!Config.sharedInstance().useQueue)
         {
            serials[param2] = getNextSerialName();
            return;
         }
         if(queue.indexOf(param2) == -1)
         {
            queue.push(param2);
            requests[param2] = param1;
            serials[param2] = getNextSerialName();
         }
      }
      
      public static function free(param1:URLLoader) : Boolean
      {
         if(!Config.sharedInstance().useQueue)
         {
            serials[param1] = null;
            delete serials[param1];
            return true;
         }
         if(queue.indexOf(param1) != -1)
         {
            queue.splice(queue.indexOf(param1),1);
            requests[param1] = null;
            delete requests[param1];
            serials[param1] = null;
            delete serials[param1];
            return true;
         }
         return false;
      }
      
      public static function name(param1:URLLoader) : String
      {
         return serials[param1] || "xxxx";
      }
      
      private static function compare(param1:URLRequest, param2:URLRequest) : Boolean
      {
         var _loc5_:ByteArray = null;
         var _loc4_:ByteArray = null;
         var _loc3_:Boolean = param1.url == param2.url && param1.method == param2.method;
         if(param1.hasOwnProperty("cacheResponse"))
         {
            _loc3_ &&= param1["cacheResponse"] == param2["cacheResponse"];
         }
         if(param1.hasOwnProperty("authenticate"))
         {
            _loc3_ &&= param1["authenticate"] == param2["authenticate"];
         }
         if(_loc3_)
         {
            if(param1.data != param2.data)
            {
               _loc5_ = new ByteArray();
               _loc5_.writeObject(_loc5_);
               _loc4_ = new ByteArray();
               _loc4_.writeObject(_loc4_);
               _loc3_ = ByteArrayUtil.compare(_loc5_,_loc4_);
            }
         }
         return _loc3_;
      }
      
      private static function getNextSerialName() : String
      {
         _serialNumber += 1;
         if(_serialNumber > 9999)
         {
            _serialNumber = 0;
         }
         var _loc1_:String = "0000";
         return _loc1_.substr(0,_loc1_.length - String(_serialNumber).length) + String(_serialNumber);
      }
   }
}

