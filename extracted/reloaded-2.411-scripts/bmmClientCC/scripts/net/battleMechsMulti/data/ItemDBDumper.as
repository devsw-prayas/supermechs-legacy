package net.battleMechsMulti.data
{
   import flash.utils.ByteArray;
   import net.battleMechsMulti.mobiles.BMItemData;
   
   public class ItemDBDumper
   {
      
      private var items:Vector.<BMItemData> = new Vector.<BMItemData>();
      
      private var index:int = 0;
      
      private var byteArray:ByteArray = new ByteArray();
      
      private var finalized:Boolean = false;
      
      private var result:String;
      
      public function ItemDBDumper(param1:Object)
      {
         var _loc2_:BMItemData = null;
         super();
         for each(_loc2_ in param1)
         {
            this.items.push(_loc2_);
         }
      }
      
      public function process(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1 && this.index < this.items.length)
         {
            this.items[this.index].writeSelf(this.byteArray);
            _loc2_++;
            ++this.index;
         }
         return this.index == this.items.length;
      }
      
      private function finalizeIfNeeded() : void
      {
         if(this.finalized)
         {
            return;
         }
         TsLogger.log("ItemDBLoader :: Dumped " + this.index + " Items...");
         this.byteArray.position = 0;
         this.byteArray.compress();
         this.byteArray.position = 0;
         this.result = Serializer.toBase64(this.byteArray);
         this.finalized = true;
      }
      
      public function getResult() : String
      {
         this.finalizeIfNeeded();
         return this.result;
      }
   }
}

