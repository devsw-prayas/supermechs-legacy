package skein.rest.core
{
   import flash.utils.Dictionary;
   import skein.core.skein_internal;
   import skein.rest.client.RestClient;
   
   use namespace skein_internal;
   
   public class ProgressTracker
   {
      
      private static var _loaded:Number;
      
      private static var _total:Number;
      
      private static const tracks:Dictionary = new Dictionary(true);
      
      public function ProgressTracker()
      {
         super();
      }
      
      public static function get loaded() : Number
      {
         return _loaded;
      }
      
      public static function get total() : Number
      {
         return _total;
      }
      
      skein_internal static function progress(param1:RestClient, param2:Number, param3:Number) : void
      {
         tracks[param1] = new Tracking(param2,param3);
         updateProperties();
      }
      
      skein_internal static function complete(param1:RestClient) : void
      {
         delete tracks[param1];
         updateProperties();
      }
      
      private static function updateProperties() : void
      {
         _loaded = 0;
         _total = 0;
         for each(var _loc1_:Tracking in tracks)
         {
            _loaded += _loc1_.loaded;
            _total += _loc1_.total;
         }
      }
   }
}

class Tracking
{
   
   public var loaded:Number = NaN;
   
   public var total:Number = NaN;
   
   public function Tracking(param1:Number, param2:Number)
   {
      super();
      this.loaded = param1;
      this.total = param2 || NaN;
   }
}
