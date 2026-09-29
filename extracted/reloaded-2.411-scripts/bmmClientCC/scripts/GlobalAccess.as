package
{
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.display.Stage;
   
   public dynamic class GlobalAccess
   {
      
      public static var stage:Stage;
      
      public static var root:DisplayObject;
      
      public static var loaderInfo:LoaderInfo;
      
      public static var forIOS:Boolean = false;
      
      public static var forMochi:Boolean = false;
      
      public static var forKong:Boolean = false;
      
      public static var overridePort:uint = 0;
      
      public static var userbase:uint = 0;
      
      public static var mcamp_id:String = "";
      
      public var _mochiads_game_id:String = "f4c10c7d79496f81";
      
      public function GlobalAccess()
      {
         super();
      }
   }
}

