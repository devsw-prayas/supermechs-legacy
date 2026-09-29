package skein.rest.cache.response
{
   public class Response
   {
      
      public var head:Head;
      
      public var body:Object;
      
      public function Response(param1:Head, param2:Object = null)
      {
         super();
         this.head = param1;
         this.body = param2;
      }
   }
}

