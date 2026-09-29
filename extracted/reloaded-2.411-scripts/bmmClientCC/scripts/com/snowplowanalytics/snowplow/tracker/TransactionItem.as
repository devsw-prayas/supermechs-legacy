package com.snowplowanalytics.snowplow.tracker
{
   public dynamic class TransactionItem
   {
      
      public function TransactionItem(param1:String, param2:String, param3:Number, param4:int, param5:String, param6:String, param7:String, param8:Array = null)
      {
         super();
         put(Parameter.EVENT,"ti");
         put(Parameter.TI_ITEM_ID,param1);
         put(Parameter.TI_ITEM_SKU,param2);
         put(Parameter.TI_ITEM_NAME,param5);
         put(Parameter.TI_ITEM_CATEGORY,param6);
         put(Parameter.TI_ITEM_PRICE,param3);
         put(Parameter.TI_ITEM_QUANTITY,param4);
         put(Parameter.TI_ITEM_CURRENCY,param7);
         put(Parameter.CONTEXT,param8);
         put(Parameter.TIMESTAMP,Util.getTimestamp());
      }
      
      public function get(param1:String) : *
      {
         if(this.hasOwnProperty(param1))
         {
            return this[param1];
         }
         return null;
      }
      
      public function put(param1:String, param2:*) : *
      {
         var _loc3_:* = undefined;
         if(!Util.isNullOrEmpty(param2))
         {
            _loc3_ = null;
            if(this.hasOwnProperty(param1))
            {
               _loc3_ = this[param1];
            }
            this[param1] = param2;
            return _loc3_;
         }
         return null;
      }
   }
}

