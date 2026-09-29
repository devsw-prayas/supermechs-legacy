package net.tacticsoft.utils
{
   public class URLParser
   {
      
      public var host:String = "";
      
      public var port:String = "";
      
      public var protocol:String = "";
      
      public var path:String = "";
      
      public var parameters:Object;
      
      public function URLParser(param1:String)
      {
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         super();
         var _loc2_:RegExp = /(?P<protocol>[a-zA-Z]+) : \/\/  (?P<host>[^:\/]*) (:(?P<port>\d+))?  ((?P<path>[^?]*))? ((?P<parameters>.*))? /x;
         var _loc3_:Array = _loc2_.exec(param1);
         this.protocol = _loc3_.protocol;
         this.host = _loc3_.host;
         this.port = _loc3_.port;
         this.path = _loc3_.path;
         var _loc4_:String = _loc3_.parameters;
         if(_loc4_ != "")
         {
            this.parameters = null;
            this.parameters = new Object();
            if(_loc4_.charAt(0) == "?")
            {
               _loc4_ = _loc4_.substring(1);
            }
            _loc5_ = _loc4_.split("&");
            for each(_loc6_ in _loc5_)
            {
               _loc7_ = _loc6_.split("=");
               this.parameters[_loc7_[0]] = _loc7_[1];
            }
         }
      }
   }
}

