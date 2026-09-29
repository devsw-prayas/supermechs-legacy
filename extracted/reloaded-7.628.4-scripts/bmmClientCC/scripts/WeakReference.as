package
{
   import flash.utils.Dictionary;
   
   public class WeakReference
   {
      
      private var dictionary:Dictionary;
      
      private var _name:String;
      
      public function WeakReference(param1:Object, param2:String)
      {
         super();
         this.dictionary = new Dictionary(true);
         this.dictionary[param1] = null;
         this._name = param2;
      }
      
      public function get object() : Object
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:* = this.dictionary;
         for(_loc1_ in _loc3_)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}

