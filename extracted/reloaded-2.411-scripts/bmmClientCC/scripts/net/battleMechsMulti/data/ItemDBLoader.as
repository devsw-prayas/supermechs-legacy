package net.battleMechsMulti.data
{
   import flash.utils.ByteArray;
   import net.battleMechsMulti.mobiles.BMItemData;
   
   public class ItemDBLoader
   {
      
      private var byteArray:ByteArray;
      
      private var iterable:Vector.<BMItemData> = new Vector.<BMItemData>();
      
      private var index:int = 0;
      
      private var finished:Boolean = false;
      
      public function ItemDBLoader(param1:String)
      {
         super();
         this.byteArray = Serializer.fromBase64(param1);
         this.byteArray.uncompress();
         this.byteArray.position = 0;
      }
      
      public function process(param1:int) : Boolean
      {
         if(this.finished)
         {
            return true;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1 && this.byteArray.bytesAvailable > 0)
         {
            this.iterable.push(new BMItemData(this.byteArray));
            _loc2_++;
            ++this.index;
         }
         if(this.byteArray.bytesAvailable <= 0)
         {
            TsLogger.log("ItemDBLoader :: Items Loaded: " + this.index);
            this.finished = true;
         }
         return this.finished;
      }
      
      public function getResult() : Vector.<BMItemData>
      {
         if(!this.finished)
         {
            throw new Error("Requested loader result when not finished");
         }
         return this.iterable;
      }
   }
}

