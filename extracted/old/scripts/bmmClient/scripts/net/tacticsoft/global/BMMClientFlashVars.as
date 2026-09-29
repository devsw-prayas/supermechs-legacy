package net.tacticsoft.global
{
   import flash.display.Stage;
   import net.tacticsoft.utils.FlashVars;
   
   public dynamic class BMMClientFlashVars extends FlashVars
   {
      
      public static const soNameDefault:String = "BMMSessionSO";
      
      public var soName:String = "BMMSessionSO";
      
      public var clientPath:String = "bmmClient.swf";
      
      public var mcamp_id:String = "";
      
      public var authServicePort:uint = 944;
      
      public var version:String = "111";
      
      public var disableFB:Boolean = true;
      
      public var clientType:String = "WEB";
      
      public var generalLibraryPath:String = "resources/general/generalLibrary.swf";
      
      public var itemsLibrary1Path:String = "resources/items/itemsLibrary1.swf";
      
      public var itemsLibrary2Path:String = "resources/items/itemsLibrary2.swf";
      
      public var itemsLibrary3Path:String = "resources/items/itemsLibrary3.swf";
      
      public var soundsLibraryPath:String = "resources/sounds/soundsLibrary_sound.swf";
      
      public var port:Number = 9010;
      
      public var resourceURL:String = "http://supermechs.com/";
      
      public function BMMClientFlashVars(param1:Stage)
      {
         TsLogger.log(" ");
         super(param1.loaderInfo.parameters);
      }
   }
}

