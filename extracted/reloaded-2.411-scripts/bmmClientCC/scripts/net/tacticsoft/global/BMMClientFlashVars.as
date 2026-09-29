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
      
      public var version:String = "4";
      
      public var disableFB:Boolean = true;
      
      public var clientType:String = "AND";
      
      public var resourceURL:String = "";
      
      public var generalLibraryPath:String = "generalLibrary.swf";
      
      public var itemsLibrary1Path:String = "itemsLibrary1.swf";
      
      public var itemsLibrary2Path:String = "itemsLibrary2.swf";
      
      public var itemsLibrary3Path:String = "itemsLibrary3.swf";
      
      public var soundsLibraryPath:String = "soundsLibrary_sound.swf";
      
      public var port:Number = 9010;
      
      public function BMMClientFlashVars(param1:Stage)
      {
         if(false)
         {
            TsLogger.log(" ");
         }
         super(param1.loaderInfo.parameters);
      }
   }
}

