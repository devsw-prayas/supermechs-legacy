package libraries.uanalytics.tracking
{
   import flash.utils.getTimer;
   
   public class RateLimiter
   {
      
      private var _capacity:int;
      
      private var _rate:int;
      
      private var _span:Number;
      
      private var _lastTime:int;
      
      private var _tokenCount:int;
      
      public function RateLimiter(param1:int, param2:int, param3:Number = 1)
      {
         super();
         this._capacity = param1;
         this._rate = param2;
         this._span = param3;
         this._tokenCount = param1;
         this._lastTime = this.now();
      }
      
      protected function now() : int
      {
         return getTimer();
      }
      
      public function consumeToken() : Boolean
      {
         var _loc1_:int = this.now();
         var _loc2_:int = Math.max(0,(_loc1_ - this._lastTime) * (this._rate * this._span / 1000));
         this._tokenCount = Math.min(this._tokenCount + _loc2_,this._capacity);
         if(this._tokenCount > 0)
         {
            --this._tokenCount;
            this._lastTime = _loc1_;
            return true;
         }
         return false;
      }
   }
}

