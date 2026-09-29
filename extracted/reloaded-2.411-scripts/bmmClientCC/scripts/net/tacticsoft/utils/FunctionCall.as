package net.tacticsoft.utils
{
   public class FunctionCall
   {
      
      private var _func:Function;
      
      private var _params:Array;
      
      public function FunctionCall(param1:Function, param2:Array = null)
      {
         super();
         this._func = param1;
         this._params = param2;
      }
      
      public function get params() : Array
      {
         return this._params;
      }
      
      public function get func() : Function
      {
         return this._func;
      }
      
      public function call() : *
      {
         if(this._params == null || this._params.length == 0)
         {
            return this._func();
         }
         if(this._params.length == 1)
         {
            return this._func(this._params[0]);
         }
         if(this._params.length == 2)
         {
            return this._func(this._params[0],this._params[1]);
         }
      }
   }
}

