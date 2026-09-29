package libraries.uanalytics.utils
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public final class crc32
   {
      
      private static var lookup:Vector.<uint> = make_crc_table();
      
      private static var _poly:uint = 3988292384;
      
      private static var _init:uint = 4294967295;
      
      private var _crc:uint;
      
      private var _length:uint;
      
      private var _endian:String;
      
      public function crc32()
      {
         super();
         this._length = 4294967295;
         this._endian = Endian.LITTLE_ENDIAN;
         this.reset();
      }
      
      private static function make_crc_table() : Vector.<uint>
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:Vector.<uint> = new Vector.<uint>();
         _loc3_ = 0;
         while(_loc3_ < 256)
         {
            _loc2_ = _loc3_;
            _loc4_ = 0;
            while(_loc4_ < 8)
            {
               if((_loc2_ & 1) != 0)
               {
                  _loc2_ = uint(_loc2_ >>> 1 ^ _poly);
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               _loc4_++;
            }
            _loc1_[_loc3_] = _loc2_;
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get endian() : String
      {
         return this._endian;
      }
      
      public function get length() : uint
      {
         return this._length;
      }
      
      public function update(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(param3 == 0)
         {
            param3 = param1.length;
         }
         param1.position = param2;
         var _loc6_:uint = uint(this._length & this._crc);
         _loc4_ = param2;
         while(_loc4_ < param3)
         {
            _loc5_ = uint(param1[_loc4_]);
            _loc6_ = uint(_loc6_ >>> 8 ^ lookup[(_loc6_ ^ _loc5_) & 0xFF]);
            _loc4_++;
         }
         this._crc = ~_loc6_;
      }
      
      public function reset() : void
      {
         this._crc = _init;
      }
      
      public function valueOf() : uint
      {
         return this._crc;
      }
      
      public function toString(param1:Number = 16) : String
      {
         return this._crc.toString(param1);
      }
   }
}

